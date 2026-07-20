const state = { repositories: [], query: '', sort: 'updated', filters: { category: new Set(), language: new Set(), platform: new Set(), status: new Set() } };
const languageColors = { 'C#':'#178600', JavaScript:'#f1e05a', TypeScript:'#3178c6', Python:'#3572A5', Java:'#b07219', SQL:'#e38c00', Dockerfile:'#384d54', HCL:'#844fba' };
const labels = { category: 'category-filters', language: 'language-filters', platform: 'platform-filters', status: 'status-filters' };
const elements = {
  grid: document.querySelector('#repository-grid'), empty: document.querySelector('#empty-state'), template: document.querySelector('#repository-card-template'), resultCount: document.querySelector('#result-count'), lastUpdated: document.querySelector('#last-updated'), search: document.querySelector('#search'), sort: document.querySelector('#sort')
};

async function loadRepositories() {
  try {
    const response = await fetch('data.json');
    if (!response.ok) throw new Error('Não foi possível carregar os dados.');
    state.repositories = await response.json();
    renderFilters(); renderStats(); render();
  } catch (error) {
    elements.resultCount.textContent = 'Não foi possível carregar o catálogo.';
    elements.empty.hidden = false;
    elements.empty.querySelector('h2').textContent = 'Dados indisponíveis';
    elements.empty.querySelector('p').textContent = 'Execute a página por um servidor local ou verifique o arquivo data.json.';
  }
}
function uniqueValues(key) { return [...new Set(state.repositories.map(repo => repo[key]).filter(Boolean))].sort((a,b) => a.localeCompare(b, 'pt-BR')); }
function renderFilters() {
  Object.entries(labels).forEach(([key, id]) => {
    const target = document.querySelector(`#${id}`); target.replaceChildren();
    uniqueValues(key).forEach(value => {
      const label = document.createElement('label'); label.className = 'filter-option';
      label.innerHTML = `<input type="checkbox" data-filter="${key}" value="${escapeHtml(value)}"><span>${escapeHtml(value)}</span><span class="count">${state.repositories.filter(r => r[key] === value).length}</span>`;
      target.append(label);
    });
  });
  document.querySelectorAll('[data-filter]').forEach(input => input.addEventListener('change', event => {
    const { filter } = event.target.dataset;
    const { value } = event.target;
    event.target.checked ? state.filters[filter].add(value) : state.filters[filter].delete(value);
    render();
  }));
}
function renderStats() {
  const total = state.repositories.length;
  document.querySelector('#total-projects').textContent = total;
  document.querySelector('#completed-projects').textContent = state.repositories.filter(r => r.status === 'Finalizado').length;
  document.querySelector('#in-progress-projects').textContent = state.repositories.filter(r => r.status === 'Em andamento').length;
  document.querySelector('#total-languages').textContent = uniqueValues('language').length;
  document.querySelector('#total-platforms').textContent = uniqueValues('platform').length;
  const newest = state.repositories.reduce((latest, repo) => !latest || repo.updated_at > latest ? repo.updated_at : latest, '');
  elements.lastUpdated.textContent = newest ? `Atualizado em ${formatDate(newest)}` : '';
}
function matchesFilters(repo) { return Object.entries(state.filters).every(([key, selected]) => !selected.size || selected.has(repo[key])); }
function getFilteredRepositories() {
  const query = normalize(state.query);
  const result = state.repositories.filter(repo => {
    const searchable = [repo.name, repo.description, repo.language, repo.platform, repo.category, ...(repo.technology || []), ...(repo.topics || [])].join(' ');
    return (!query || normalize(searchable).includes(query)) && matchesFilters(repo);
  });
  return result.sort((a,b) => {
    if (state.sort === 'name') return a.name.localeCompare(b.name, 'pt-BR');
    if (state.sort === 'stars') return b.stars - a.stars;
    if (state.sort === 'status') return (a.status === 'Finalizado' ? 0 : 1) - (b.status === 'Finalizado' ? 0 : 1) || b.updated_at.localeCompare(a.updated_at);
    return b.updated_at.localeCompare(a.updated_at);
  });
}
function render() {
  const repositories = getFilteredRepositories(); elements.grid.replaceChildren();
  elements.resultCount.textContent = `${repositories.length} ${repositories.length === 1 ? 'projeto encontrado' : 'projetos encontrados'}`;
  elements.empty.hidden = repositories.length !== 0;
  repositories.forEach(repo => elements.grid.append(createCard(repo)));
}
function createCard(repo) {
  const card = elements.template.content.cloneNode(true);
  card.querySelector('.category-badge').textContent = repo.category;
  const status = card.querySelector('.status-badge'); status.textContent = repo.status; status.dataset.status = repo.status;
  card.querySelector('.repository-name').textContent = repo.name;
  card.querySelector('.repository-description').textContent = repo.description || 'Sem descrição disponível.';
  const tags = card.querySelector('.technologies'); (repo.technology || []).slice(0, 3).forEach(tech => { const tag = document.createElement('span'); tag.className = 'tag'; tag.textContent = tech; tags.append(tag); });
  const language = card.querySelector('.language'); language.style.setProperty('--language-color', languageColors[repo.language] || '#8b949e'); language.querySelector('span').textContent = repo.language || '—';
  card.querySelector('.platform').textContent = repo.platform || 'Independente'; card.querySelector('.stars span').textContent = repo.stars || 0;
  card.querySelector('time').textContent = `Atualizado ${formatDate(repo.updated_at)}`; card.querySelector('.repository-link').href = repo.url;
  return card;
}
function clearFilters() { state.query = ''; state.sort = 'updated'; Object.values(state.filters).forEach(set => set.clear()); elements.search.value = ''; elements.sort.value = 'updated'; document.querySelectorAll('[data-filter]').forEach(input => input.checked = false); render(); }
function normalize(value) { return String(value).normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase(); }
function formatDate(date) { return new Intl.DateTimeFormat('pt-BR', { day:'2-digit', month:'short', year:'numeric' }).format(new Date(`${date}T12:00:00`)).replace('.', ''); }
function escapeHtml(value) { const element = document.createElement('span'); element.textContent = value; return element.innerHTML; }
elements.search.addEventListener('input', event => { state.query = event.target.value; render(); });
elements.sort.addEventListener('change', event => { state.sort = event.target.value; render(); });
document.querySelector('#clear-filters').addEventListener('click', clearFilters); document.querySelector('#empty-clear').addEventListener('click', clearFilters);
loadRepositories();
