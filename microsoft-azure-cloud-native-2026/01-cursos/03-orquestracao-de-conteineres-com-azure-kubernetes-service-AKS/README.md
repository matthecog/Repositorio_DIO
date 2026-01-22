# Orquestração de Contêineres com Azure Kubernetes Service (AKS)

## 📌 Status

✅ Concluído

## 🎯 Objetivo

Compreender o conceito de contêiner. Criar e publicar imagens de contêiner no Azure e
aplicar conceitos práticos por meio de laboratório.

## 🚀 Conteúdos Abordados

Durante esta fase do bootcamp, foram estudados os seguintes conceitos:


## Máquina Virutal x Docker

VMs virtualizam hardware completo (com sistema operacional próprio), enquanto Docker usa containers, compartilhando o SO do host.
VMs são mais isoladas, porém mais pesadas e lentas para iniciar.
Containers são leves, rápidos e portáveis, ideais para microserviços.
VMs oferecem maior controle do ambiente; Docker foca em padronização e agilidade.
Em resumo: VM = infraestrutura, Docker = aplicação.

## ☁️ Serviços Azure Explorados

- **Azure Kubernetes Service (AKS)**
- **Azure Container Registry (ACR)**

## 🧪 Atividades Práticas / Laboratório

Durante o laboratório do curso foram realizadas as seguintes etapas:

- Criação de uma **Landing Page** simples conteinerizada
- Build da imagem do contêiner da aplicação
- Envio da imagem para o **Azure Container Registry (ACR)**
- Criação e configuração de um cluster **AKS**

## 📌 Observações e Aprendizados

- O AKS abstrai grande parte da complexidade operacional do Kubernetes
- O ACR é essencial para o versionamento e distribuição de imagens

## 🔗 Recursos Complementares

- Pasta do Laboratório: [Laboratório](/microsoft-azure-cloud-native-2026/04-laboratorios/lab02-orquestracao-conteiners-aks/)
- Códigos utilizados: [Códigos](/microsoft-azure-cloud-native-2026/04-laboratorios/lab02-orquestracao-conteiners-aks/codigos/)
- Imagens do ambiente: [Imagens](/microsoft-azure-cloud-native-2026/04-laboratorios/lab02-orquestracao-conteiners-aks/imagens/)