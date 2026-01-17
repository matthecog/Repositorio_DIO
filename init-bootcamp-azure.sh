#!/bin/bash

echo "🚀 Inicializando estrutura do bootcamp no repositório atual"

# ======================
# README RAIZ
# ======================
cat <<EOF > README.md
# Microsoft Azure Cloud Native 2026

Este repositório documenta minha jornada completa no bootcamp
**Microsoft Azure Cloud Native 2026**.

## Estrutura do Bootcamp
- ✅ 11 cursos
- ✅ 6 desafios de projeto
- ✅ 3 desafios de código

## Objetivo
Registrar ambientes, códigos, decisões técnicas e aprendizados
adquiridos ao longo do bootcamp, servindo como material de estudo
e portfólio profissional.

## Tecnologias
- Microsoft Azure
- Linux
- Containers
- Infraestrutura como Código (IaC)
- Git & GitHub
EOF

touch ROADMAP.md CHANGELOG.md .gitignore

# ======================
# VISÃO GERAL
# ======================
mkdir -p "00-visao-geral"

cat <<EOF > "00-visao-geral/README.md"
# Visão Geral

Documentação geral do bootcamp, objetivos e tecnologias utilizadas.
EOF

cat <<EOF > "00-visao-geral/sobre-o-bootcamp.md"
## Sobre o Bootcamp

O **Microsoft Azure Cloud Native 2026** é focado em Cloud Computing,
arquiteturas cloud-native e boas práticas de infraestrutura moderna.
EOF

cat <<EOF > "00-visao-geral/tecnologias-utilizadas.md"
## Tecnologias Utilizadas

- Azure Virtual Machines
- Azure App Services
- Containers e Docker
- Networking
- Segurança
EOF

# ======================
# CURSOS (11)
# ======================
mkdir -p "01-cursos"

cat <<EOF > "01-cursos/README.md"
# Cursos

Esta seção contém a documentação dos 11 cursos do bootcamp.
Cada pasta representa um curso individual.
EOF

for i in {01..11}; do
  mkdir -p "01-cursos/curso-$i/codigo"
  mkdir -p "01-cursos/curso-$i/prints"

  cat <<EOF > "01-cursos/curso-$i/README.md"
# Curso $i – Em andamento ⏳

## Status
⏳ Pendente

## Objetivo
Descrever os conceitos abordados neste curso e os laboratórios realizados.

## Conteúdos
- Conceitos teóricos
- Exercícios práticos
- Configurações no Azure

## Evidências
- Prints dos ambientes
- Códigos utilizados
EOF

  cat <<EOF > "01-cursos/curso-$i/conteudos.md"
## Conteúdo Programático

> Este arquivo será atualizado conforme o andamento do curso.
EOF
done

# ======================
# DESAFIOS DE PROJETO (6)
# ======================
mkdir -p "02-desafios-de-projeto"

cat <<EOF > "02-desafios-de-projeto/README.md"
# Desafios de Projeto

Projetos práticos aplicando os conceitos aprendidos durante o bootcamp.
EOF

for i in {01..06}; do
  mkdir -p "02-desafios-de-projeto/projeto-$i/codigo"
  mkdir -p "02-desafios-de-projeto/projeto-$i/prints"

  cat <<EOF > "02-desafios-de-projeto/projeto-$i/README.md"
# Projeto $i – Em planejamento ⏳

## Status
⏳ Pendente

## Descrição
Implementação prática de uma solução cloud no Azure.

## Tecnologias Utilizadas
- Microsoft Azure
- Infraestrutura como Código
- Containers (quando aplicável)

## Resultado Esperado
Ambiente funcional seguindo boas práticas de Cloud Computing.
EOF

  cat <<EOF > "02-desafios-de-projeto/projeto-$i/arquitetura.md"
## Arquitetura

Descrição da arquitetura da solução e diagrama (quando aplicável).
EOF

  cat <<EOF > "02-desafios-de-projeto/projeto-$i/resultados.md"
## Resultados

Resultados obtidos após a conclusão do projeto.
EOF
done

# ======================
# DESAFIOS DE CÓDIGO (3)
# ======================
mkdir -p "03-desafios-de-codigo"

cat <<EOF > "03-desafios-de-codigo/README.md"
# Desafios de Código

Desafios focados em lógica, automação e scripts.
EOF

for i in {01..03}; do
  mkdir -p "03-desafios-de-codigo/desafio-$i/solucao"

  cat <<EOF > "03-desafios-de-codigo/desafio-$i/README.md"
# Desafio de Código $i – Não iniciado ⏳

## Objetivo
Resolver o desafio proposto utilizando boas práticas de programação.

## Linguagem
A definir.

## Observações
Solução será adicionada após a conclusão.
EOF
done

# ======================
# AMBIENTES
# ======================
mkdir -p "04-ambientes/azure/vms"
mkdir -p "04-ambientes/azure/app-services"
mkdir -p "04-ambientes/azure/containers"
mkdir -p "04-ambientes/azure/networking"
mkdir -p "04-ambientes/azure/security"
mkdir -p "04-ambientes/prints"

cat <<EOF > "04-ambientes/README.md"
# Ambientes

Documentação dos ambientes criados no Azure durante o bootcamp.
EOF

# ======================
# ERROS E APRENDIZADOS
# ======================
mkdir -p "05-erros-e-aprendizados"

cat <<EOF > "05-erros-e-aprendizados/README.md"
# Erros e Aprendizados

Registro de erros comuns, soluções e lições aprendidas.
EOF

cat <<EOF > "05-erros-e-aprendizados/principais-erros.md"
## Principais Erros

> Este arquivo será atualizado conforme novos aprendizados surgirem.
EOF

# ======================
# REFERÊNCIAS
# ======================
mkdir -p "06-referencias"

cat <<EOF > "06-referencias/links.md"
## Links Úteis

- Documentação oficial Microsoft Azure
- GitHub Docs
EOF

cat <<EOF > "06-referencias/documentacoes.md"
## Documentações

Lista de materiais oficiais e complementares.
EOF

echo "✅ Estrutura criada com sucesso no repositório atual!"