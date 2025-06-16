# ➡ Candidate-se

Plataforma para conectar voluntários a oportunidades de ONGs.

---

## Sobre o projeto

O **Candidate-se** é uma aplicação de uma estória de usuário na plataforma de encontro entre voluntários e ONGs.  
Este MVP implementa a estória principal:

> **"Eu, como voluntário, quero visualizar uma lista de oportunidades para poder escolher onde me inscrever."**

---

## Stack e arquitetura

* **Frontend:** Node.js, Express, Handlebars (.hbs), Bootstrap 5, CSS custom
* **Backend:** FastAPI (Python), API RESTful
* **Banco:** MySQL 8 (container Docker)
* **Infra:** Docker Compose, AWS EC2, variáveis centralizadas em `.env`
* **Outros:** Axios, scripts de backup, logs centralizados

---

## Funcionalidades

| Features                                   
| --------------------------------------------------      
| Listagem de oportunidades de voluntariado    ✅  | 
| Inscrição do usuário em vagas                ✅  |
| Visualização/edição de perfil                ✅  |
| Log de acessos e backup automático           ✅  |
| Deploy Docker/AWS                            ✅  |

---

## Link de acesso

<eng-sw.lealg.xyz>

---

## Estrutura do projeto

```plaintext
frontend/     # Express, Handlebars, Bootstrap, views
backend/      # FastAPI, models, routers, config
db/           # Scripts SQL, dumps, backups
.env.example  # Variáveis de ambiente
docker-compose.yml
README.md
```

---

## API — exemplo rápido

**Endpoint:**
`GET /api/vagas`

**Response:**

```json
[
  {
    "id": 1,
    "titulo": "Apoio em evento",
    "descricao": "Auxiliar na organização de evento para ONG X.",
    "local": "São Paulo - SP"
  },
  ...
]
```

*Para detalhes, consulte a [Wiki](./docs/api.md)*

---

## Modelagem do banco

Principais tabelas:

* **usuarios:** id, nome, email, endereco
* **oportunidades:** id, titulo, descricao, local
* **inscricoes:** id, usuario\_id, oportunidade\_id, data\_inscricao

---

## Deploy

* Deploy em AWS EC2 via Docker Compose
* Variáveis de ambiente em `.env`
* Scripts de backup e log
* Dominio e HTTPS <- TODO
* Deploy Automatico <- TODO 

---
**Aluno:**
Gabriel Leal
