#!/usr/bin/env python3
"""Build the study-repository catalogue from GitHub repository metadata.

Required environment variable:
    GITHUB_USERNAME   GitHub account whose public repositories are catalogued.

Optional environment variable:
    GITHUB_TOKEN      Token used to avoid GitHub API rate limits and include private
                      repositories when the token has access to them.
"""

from __future__ import annotations

import json
import os
import sys
from collections import Counter
from datetime import UTC, datetime
from pathlib import Path
from typing import Any

import requests


ROOT = Path(__file__).resolve().parent
DATA_FILE = ROOT / "docs" / "data.json"
README_FILE = ROOT / "README.md"
API_URL = "https://api.github.com"

PLATFORMS = {
    "dio": "DIO",
    "tftec": "TFTEC",
    "alura": "Alura",
    "fabricio-veronez": "Fabricio Veronez",
    "microsoft-learn": "Microsoft Learn",
    "udemy": "Udemy",

}

CATEGORIES = {
    "backend": "Backend",
    "frontend": "Frontend",
    "mobile": "Mobile",
    "cloud": "Cloud",
    "devops": "DevOps",
    "database": "Banco de Dados",
    "ia": "IA",
    "ai": "IA",
    "arquitetura": "Arquitetura",
    "azure": "Azure",
    "aws": "AWS",
    "oci": "OCI",
    "gcp": "GCP",
    "terraform": "Terraform",
    "docker": "Docker",

}

STATUS = {
    "finalizado": "Finalizado",
    "em-andamento": "Em andamento",
    "em-atualizacao": "Em atualização",
}


def configuration() -> tuple[str, dict[str, str]]:
    username = os.environ.get("GITHUB_USERNAME", "").strip()
    if not username:
        raise RuntimeError("Defina a variável de ambiente GITHUB_USERNAME.")

    headers = {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    token = os.environ.get("GITHUB_TOKEN", "").strip()
    if token:
        headers["Authorization"] = f"Bearer {token}"
    return username, headers


def get_repositories(username: str, headers: dict[str, str]) -> list[dict[str, Any]]:
    """Return only public repositories owned by the configured account."""
    repositories: list[dict[str, Any]] = []
    page = 1
    while True:
        response = requests.get(
            f"{API_URL}/users/{username}/repos",
            headers=headers,
            params={"per_page": 100, "page": page, "type": "owner", "sort": "updated"},
            timeout=30,
        )
        if response.status_code == 404:
            raise RuntimeError(f"Usuário GitHub não encontrado: {username}")
        response.raise_for_status()
        batch = response.json()
        if not batch:
            return repositories
        # A rota /users/{username}/repos já expõe repositórios públicos, mas o
        # filtro adicional mantém a regra explícita caso a resposta da API mude.
        repositories.extend(repository for repository in batch if not repository.get("private", False))
        page += 1


def first_match(topics: list[str], choices: dict[str, str], fallback: str) -> str:
    return next((choices[topic] for topic in topics if topic in choices), fallback)


def to_catalogue_entry(repository: dict[str, Any], index_name: str) -> dict[str, Any] | None:
    if (
        repository.get("private", False)
        or repository.get("fork")
        or repository["name"].casefold() == index_name.casefold()
    ):
        return None

    topics = sorted({topic.casefold().strip() for topic in repository.get("topics", []) if topic.strip()})
    recognised = set(PLATFORMS) | set(CATEGORIES) | set(STATUS)
    technology = [topic for topic in topics if topic not in recognised]
    updated_at = (repository.get("updated_at") or "")[:10]

    return {
        "name": repository["name"],
        "description": repository.get("description") or "Sem descrição.",
        "url": repository["html_url"],
        "language": repository.get("language") or "Não informado",
        "platform": first_match(topics, PLATFORMS, "Independente"),
        "category": first_match(topics, CATEGORIES, "Outros"),
        "technology": technology,
        "topics": topics,
        "status": first_match(topics, STATUS, "Não informado"),
        "stars": repository.get("stargazers_count", 0),
        "updated_at": updated_at,
    }


def write_json(entries: list[dict[str, Any]]) -> None:
    DATA_FILE.parent.mkdir(parents=True, exist_ok=True)
    DATA_FILE.write_text(json.dumps(entries, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def render_readme(entries: list[dict[str, Any]], username: str) -> str:
    completed = sum(entry["status"] == "Finalizado" for entry in entries)
    in_progress = sum(entry["status"] == "Em andamento" for entry in entries)
    categories = Counter(entry["category"] for entry in entries)
    generated_at = datetime.now(UTC).strftime("%d/%m/%Y %H:%M UTC")
    lines = [
        "# 📚 Repositório de Estudos",
        "",
        "Catálogo automático dos meus repositórios de estudo no GitHub.",
        "",
        f"**Projetos:** {len(entries)} · **Finalizados:** {completed} · **Em andamento:** {in_progress}",
        "",
        "Acesse o catálogo interativo pelo GitHub Pages ou use a tabela abaixo.",
        "",
        "## Repositórios",
        "",
        "| Projeto | Categoria | Plataforma | Linguagem | Status |",
        "| --- | --- | --- | --- | --- |",
    ]
    for entry in entries:
        lines.append(
            f"| [{entry['name']}]({entry['url']}) | {entry['category']} | "
            f"{entry['platform']} | {entry['language']} | {entry['status']} |"
        )
    lines.extend(["", "## Categorias", ""])
    for category, count in sorted(categories.items()):
        lines.append(f"- {category}: {count}")
    lines.extend([
        "",
        "## Como classificar um repositório",
        "",
        "Use *topics* para plataforma (`dio`, `udemy`), categoria (`backend`, `cloud`), "
        "status (`finalizado`, `andamento`) e tecnologias (`docker`, `terraform`).",
        "",
        f"_Gerado automaticamente em {generated_at} a partir dos repositórios de [{username}](https://github.com/{username})._",
        "",
    ])
    return "\n".join(lines)


def main() -> int:
    try:
        username, headers = configuration()
        index_name = os.environ.get("CATALOG_REPOSITORY", ROOT.name)
        raw_repositories = get_repositories(username, headers)
        entries = [entry for repo in raw_repositories if (entry := to_catalogue_entry(repo, index_name))]
        entries.sort(key=lambda entry: (entry["updated_at"], entry["name"].casefold()), reverse=True)
        write_json(entries)
        README_FILE.write_text(render_readme(entries, username), encoding="utf-8")
        print(f"Catálogo atualizado: {len(entries)} repositório(s).")
        return 0
    except (requests.RequestException, RuntimeError) as error:
        print(f"Erro ao gerar o catálogo: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
