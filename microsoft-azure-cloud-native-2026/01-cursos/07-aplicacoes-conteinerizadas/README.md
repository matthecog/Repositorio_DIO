# Aplicações Contêinerizadas com Azure Container Apps

## 📌 Status

✅ Concluído

## 🎯 Objetivo

- Entender sobre container apps, quais cenários é importante utilizar e um comparativo vs k8s, WebApp.

## Conteúdo Programático
- Aula 1: Aplicações Contêinerizadas com Azure Container Apps
- Exercício 1: Criar um Azure Container Apps no Portal
- Aula 2: Implementar os Aplicativos de Contêiner do Azure
- Exercicio 2: Implantar um aplicativo de conteiner

## 🚀 Conteúdos Abordados

Durante esta fase do bootcamp, foram estudados os seguintes conceitos:

## Aula 01
### O que são Container Apps?

- Execução Serverless
- Escalabilidade Automática
- Ambiente Gerenciado
- Suporte a Microserviços
- Integração com Eventos e Workflows

### Casos de usos para Container Apps

- Aplicações Web e APIs
- Arquiteturas de Microserviços
- Processamento de Eventos
- Ambientes de desenvolvimento e teste

### Container Apps vs AKS

- Web App (App Service): quando você quer publicar uma aplicação rápido, sem se preocupar com servidor, patch, escala ou infraestrutura. Ideal para APIs e sites.
- Container App (Azure Container Apps): quando sua aplicação já roda em Docker e você quer algo gerenciado, com escala automática, sem complexidade de Kubernetes.
- AKS (Azure Kubernetes Service): quando você precisa de alto controle, múltiplos serviços, orquestração avançada, observabilidade e cenários complexos em produção.

## Aula 02
### Explorar Aplicativos de Contêiner do Azure

Os Aplicativos de Contêiner do Azure permitem que você execute microsserviços e aplicativos em conteineres em uma plataforma sem servidor que e executada sobre Servico de Kubernetes do Azure.

- Aceita dimensionamento dinâmico com base em dimensionadores compatíveis com KEDA
- Os Aplicativos de Contêiner são implantados em um único ambiente de Aplicativos de Contêiner, que atua como um limite seguro para grupos de Aplicativos de Contêiner.
- Desenvolva, atualize, crie versões e dimensione áreas de funcionalidade importantes de forma independente em um sistema geral.
- Integração do Dapr (runtime de aplicativos distribuídos) nativa.

### Explorar conteineres nos Aplicativos de Contêiner do Azure

- Contêineres para um Aplicativo de Contêiner do Azure são agrupados em pods dentro de instantâneos de revisão.
- É possível definir vários contêineres em um único aplicativo de contêiner para implementar o padrão sidecar.
- Implante imagens hospedadas em registros privados fornecendo as credenciais na configuração de Aplicativos de Contêiner.

### Gerenciar revisões e segredos nos Aplicativos de Contêiner do Azure

 Revisões

- Os Aplicativos de Contêiner do Azure implementam o controle de versão do aplicativo de contêiner criando revisões.

- Controle quais revisões estão ativas e o tráfego externo que é roteado para cada revisão ativa.

- O comando az containerapp update pode modificar variáveis de ambiente, calcular recursos, dimensionar parâmetros e implantar uma imagem diferente.

- Se a atualização incluir alterações no escopo da revisão, uma nova revisão será gerada.

 Segredos

- Os segredos são definidos no nível do aplicativo, os valores protegidos ficam disponíveis para Aplicativos de Contêiner.
- Cada revisão de aplicativo pode fazer referência a um ou mais segredos.
- Quando você cria um aplicativo de contêiner, os segredos são definidos usando o parâmetro -- secrets.

## Aula 03
### Exercício: Implantar um aplicativo de contêiner

Neste exercício, você cria um ambiente seguro dos Aplicativos de Contêiner e implantará o aplicativo de contêiner.

Objetivos

- Prepare o seu ambiente
- Criar um ambiente de Aplicativos de Contêiner do Azure
- Criar um aplicativo de contêiner
- Verificar a implantação
- Limpar os recursos

## 🔗 Recursos Complementares

- Pasta do Laboratório: [Laboratório](/microsoft-azure-cloud-native-2026/04-laboratorios/lab03-implantar-app-conteiner/)
- Códigos utilizados: [Códigos](/microsoft-azure-cloud-native-2026/04-laboratorios/lab03-implantar-app-conteiner/codigos/)
- Imagens do ambiente: [Imagens](/microsoft-azure-cloud-native-2026/04-laboratorios/lab03-implantar-app-conteiner/imagens/)