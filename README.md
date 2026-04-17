# 🚀 DevOps Lab - CI/CD com Docker, Nginx e Monitoramento

Projeto prático de DevOps demonstrando a implementação de um pipeline completo de **CI/CD**, containerização de uma aplicação web estática, proxy reverso com Nginx e monitoramento com Zabbix.

---

## 📌 Visão Geral

Este projeto implementa um fluxo DevOps real com:

- Build automatizado de uma aplicação web estática
- Publicação de imagem Docker no Docker Hub
- Servidor web baseado em Nginx
- Proxy reverso com suporte a HTTP/HTTPS
- Monitoramento com Zabbix + MySQL
- Deploy automatizado com Docker Compose

---

## 🌐 Aplicação

A aplicação consiste em um **site estático (`index.html`)** localizado em: site/index.html


Este conteúdo é empacotado em uma imagem Docker e servido via Nginx.

---

## 🧱 Arquitetura do Projeto

```bash
.
├── .github/
│   └── workflows/
│       └── pipeline.yml         # Pipeline CI/CD
├── nginx/
│   ├── nginx.conf           # Configuração do proxy reverso
│   └── certs/               # Certificados SSL
│       └── cert.crt
│       └── cert.key
├── site/
│   └── index.html           # Aplicação web estática
├── docker-compose.yml       # Orquestração dos serviços
├── Dockerfile               # Build da aplicação (Nginx)
├── deploy.sh                # Script de deploy
└── .env                     # Variáveis de ambiente

⚙️ Tecnologias Utilizadas
- Docker / Docker Compose
- Nginx (Web Server + Reverse Proxy)
- GitHub Actions (CI/CD)
- Zabbix (Monitoramento)
- MySQL (Banco de dados do Zabbix)

🐳 Build da Aplicação

A aplicação é construída a partir de uma imagem base do Nginx:

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY site/ /usr/share/nginx/html/

EXPOSE 80

🔄 Pipeline CI/CD

Executado automaticamente a cada push na branch main.

- Etapas:
- Checkout do código
- Autenticação no Docker Hub
- Build da imagem Docker
- Push da imagem (web)
- Tag latest

docker build -t guifranco/devops-lab:web .
docker push guifranco/devops-lab:web
docker tag guifranco/devops-lab:web guifranco/devops-lab:latest
docker push guifranco/devops-lab:latest

🧩 Serviços (Docker Compose)
🔹 nginx (Proxy Reverso)
  - Porta 80 e 443
  - Encaminha requisições para o serviço web
🔹 web (Aplicação)
  - Serve o index.html
  - Container baseado em Nginx
  - Healthcheck ativo
🔹 zabbix-server
  - Monitoramento da aplicação
🔹 zabbix-db (MySQL)
  - Persistência dos dados do Zabbix

❤️ Healthcheck
healthcheck:
- test: ["CMD", "wget", "-qO-", "http://localhost"]
- interval: 30s
- timeout: 10s
- retries: 3

🚀 Deploy
./deploy.sh
- O script executa:
- Atualização das imagens
- Recriação dos containers
- Limpeza de imagens antigas

🔐 Variáveis de Ambiente

Arquivo .env:
MYSQL_ROOT_PASSWORD=senha
MYSQL_DATABASE=zabbix
ZBX_DB_HOST=zabbix-db

📊 Monitoramento

O projeto inclui stack completa de monitoramento:

- Zabbix Server
- Banco MySQL dedicado
- Base pronta para coleta de métricas

📦 Execução Local

git clone https://github.com/guilhermefranco0013/devops-lab.git
cd devops-lab

docker compose up -d --build

A aplicação estará disponível em: http://localhost ou http://IP_SERVIDOR:80

🧠 Boas Práticas Aplicadas
- CI/CD com GitHub Actions
- Versionamento de imagens Docker
- Separação de responsabilidades (proxy/app/monitoramento)
- Uso de variáveis de ambiente
- Healthchecks
- Infraestrutura como código (Docker Compose)

📌 Roadmap
 - Deploy automatizado (CD completo)
 - Integração com Kubernetes
 - Observabilidade com Prometheus ou zabbix + Grafana

👨‍💻 Autor

Guilherme Franco Antunes Pinto
