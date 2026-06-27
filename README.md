# Community Kitchen Infra

## Repositorios

- Infraestrutura: https://github.com/LuizReis-dev/community-kitchen-infra
- API principal: https://github.com/LuizReis-dev/community-kitchen
- Frontend: https://github.com/Lucas-Cast/community-kitchen-portal

## Contexto

Este repositorio contem a camada de infraestrutura e DevOps do projeto Community Kitchen, preparada para o trabalho final da disciplina.

A API concentra as regras de negocio da cozinha comunitaria, enquanto o frontend fornece a interface web consumida pelos usuarios.

## Aplicacoes

### API principal

- Repositorio: `LuizReis-dev/community-kitchen`
- Stack: NestJS, TypeScript e PostgreSQL.
- Responsabilidades:
  - cadastro e consulta de alimentos;
  - pratos;
  - cardapios;
  - eventos diarios;
  - presencas em cardapios;
  - requisitos de cardapio;
  - autenticacao por token remoto.
- Publicacao:
  - imagem Docker publicada no Docker Hub;
  - deploy em Kubernetes/EKS;
  - acesso externo roteado pelo Kong Gateway no prefixo `/api`.

### Frontend

- Repositorio: `Lucas-Cast/community-kitchen-portal`
- Stack: Next.js, React e TypeScript.
- Responsabilidades:
  - telas de autenticacao;
  - operacoes de cadastro e consulta;
  - consumo da API principal;
  - dashboards e tabelas da aplicacao.
- Publicacao:
  - imagem Docker publicada no Docker Hub;
  - deploy em uma VM EC2 com Docker;
  - acesso externo roteado pelo Kong Gateway no prefixo `/`.

## Arquitetura

```text
Usuario
  -> Kong Gateway
      -> /      -> Frontend em EC2 + Docker
      -> /api   -> API em Kubernetes/EKS
                  -> PostgreSQL em StatefulSet no cluster
```

O gateway e o unico ponto de entrada publico da aplicacao. A VM do frontend aceita HTTP somente a partir do security group do gateway. A API e publicada dentro do cluster Kubernetes e exposta para o gateway.

## API Gateway

O gateway utilizado e o Kong em modo declarativo.

Arquivo principal:

- `applications/kong/kong.yml.j2`

Rotas configuradas:

- `/`: encaminha para o frontend.
- `/api`: encaminha para a API principal em producao.
- `/homolog/api`: rota prevista para ambiente de homologacao.

Deploy:

- Pipeline: `.github/workflows/gateway.yml`
- Playbook: `ansible/playbooks/deploy-gateway.yml`

## Docker

Dockerfiles:

- `applications/frontend/Dockerfile`
- `applications/backend/Dockerfile`

O frontend usa build multi-stage:

1. instala dependencias;
2. executa `next build`;
3. gera imagem final com dependencias de producao;
4. executa `next start` na porta `5000`.

A API usa Docker para instalar dependencias, compilar o projeto NestJS e executar o build com `npm run start:prod`.

As imagens sao publicadas no Docker Hub pelas pipelines.

## Kubernetes

Arquivos principais:

- `kubernetes/namespace.yml`
- `kubernetes/prod/deployment.yml`
- `kubernetes/prod/service.yml`
- `kubernetes/prod/ingress.yml`
- `kubernetes/prod/hpa.yml`
- `kubernetes/prod/resource-quota.yml`
- `kubernetes/prod/limit-range.yml`
- `kubernetes/prod/database/statefulset.yml`
- `kubernetes/prod/database/service.yml`
- `kubernetes/prod/database/secret.yml`

Recursos configurados:

- namespace `prod`;
- deployment da API com multiplas replicas;
- estrategia `RollingUpdate`;
- service interno para a API;
- ingress para publicacao;
- HPA com CPU target;
- `ResourceQuota`;
- `LimitRange`;
- probes de liveness e readiness;
- banco PostgreSQL em StatefulSet.

O ambiente de homologacao possui manifests em `kubernetes/homolog`, mas esta temporariamente desativado nos playbooks.

## Banco de dados

O banco utilizado pela API e PostgreSQL.

No Kubernetes, o banco fica em:

- `kubernetes/prod/database/statefulset.yml`
- `kubernetes/prod/database/service.yml`
- `kubernetes/prod/database/secret.yml`

O StatefulSet mantem identidade estavel para o banco dentro do cluster. O enunciado menciona cluster de leitura; nesta entrega o banco foi modelado como StatefulSet no Kubernetes para atender a persistencia do ambiente da aplicacao.

## Terraform

Terraform fica em:

- `terraform/main.tf`
- `terraform/variables.tf`
- `terraform/modules/compute`
- `terraform/modules/eks`

Principais recursos provisionados:

- VPC e rede publica para VMs;
- EC2 do frontend;
- EC2 do Kong Gateway;
- Elastic IPs;
- security groups;
- chave SSH;
- VPC do EKS;
- subnets publicas do EKS;
- cluster EKS;
- node group de producao.

Comandos basicos:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Outputs importantes:

```bash
terraform output ip_publico_vm
terraform output ip_publico_gateway
terraform output ip_privado_frontend
terraform output eks_cluster_name
terraform output eks_cluster_endpoint
```

## Ansible

Arquivos:

- `ansible/ansible.cfg`
- `ansible/hosts.ini`
- `ansible/playbooks/deploy-frontend.yml`
- `ansible/playbooks/deploy-gateway.yml`
- `ansible/playbooks/deploy-kubernetes.yml`
- `ansible/playbooks/install-eks-addons.yml`

Playbooks:

- `deploy-frontend.yml`: instala Docker na VM do frontend, baixa a imagem e reinicia o container.
- `deploy-gateway.yml`: instala Docker na VM do gateway e sobe o Kong com configuracao declarativa.
- `deploy-kubernetes.yml`: aplica manifests Kubernetes, atualiza secret da API, atualiza imagem e reinicia o deployment.
- `install-eks-addons.yml`: instala complementos necessarios no EKS.

## CI/CD

Workflows:

- `.github/workflows/frontend.yml`
- `.github/workflows/backend.yml`
- `.github/workflows/gateway.yml`

### Pipeline do frontend

Etapas:

1. checkout do repositorio do frontend;
2. instalacao de dependencias;
3. analise de qualidade com SonarQube em container;
4. build Docker com variaveis `NEXT_PUBLIC_*` via build args;
5. scan da imagem com Trivy;
6. push da imagem para Docker Hub;
7. deploy via Ansible na VM EC2;
8. DAST com OWASP ZAP contra o gateway;
9. resumo final com `echo`.

### Pipeline da API

Etapas:

1. checkout do repositorio da API;
2. instalacao de dependencias;
3. build;
4. testes unitarios;
5. analise de qualidade com SonarQube em container;
6. build Docker;
7. scan da imagem com Trivy;
8. push da imagem para Docker Hub;
9. deploy no EKS via Ansible;
10. DAST com OWASP ZAP contra `http://IP_GATEWAY/api`;
11. resumo final com `echo`.

### Pipeline do gateway

Etapas:

1. checkout da infra;
2. instalacao do Ansible;
3. configuracao de SSH e inventario;
4. deploy do Kong Gateway.

## Variaveis e secrets principais

GitHub Secrets usados:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`
- `VM_SSH_PRIVATE_KEY`
- `IP_FRONTEND`
- `IP_GATEWAY`
- `IP_FRONTEND_PRIVATE`
- `API_UPSTREAM_HOST`
- `USER_CONTROLLER_API_URI`
- `REMOTE_TOKEN_VALIDATOR_URL`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

Variaveis importantes de runtime:

- `REMOTE_TOKEN_VALIDATOR_URL`: URL usada pela API para validar tokens no servico externo.
- `NEXT_PUBLIC_CK_API_URI`: URL publica da API consumida pelo frontend.
- `NEXT_PUBLIC_USER_CONTROLLER_API_URI`: URL do servico de autenticacao/usuarios consumido pelo frontend.


## Estrutura

```text
infra/
├── .github/workflows/
│   ├── backend.yml
│   ├── frontend.yml
│   └── gateway.yml
├── ansible/
│   ├── ansible.cfg
│   ├── hosts.ini
│   └── playbooks/
├── applications/
│   ├── backend/Dockerfile
│   ├── frontend/Dockerfile
│   └── kong/kong.yml.j2
├── kubernetes/
│   ├── namespace.yml
│   ├── prod/
│   └── homolog/
└── terraform/
    ├── main.tf
    ├── variables.tf
    └── modules/
```
