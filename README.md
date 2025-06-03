# 🙋‍♂️ candidate-se

Aplicação de uma estória de usuário da aplicação original [TEMPO BEM GASTO](https://github.com/lealgabriel1/tempo-bem-gasto) (INCOMPLETA)   
Estória a ser feita:    
*"Eu, como voluntário, quero visualizar uma lista de oportunidades para poder escolher onde me inscrever."*
---

## 💡 Funcionalidades

- Visualização de vagas de voluntariado - RF
- Inscrição do usuário logado em oportunidades - RF
- Visualização e edição do perfil do usuário padrão - RNF

---

## 🚀 Tecnologias utilizadas

- **Banco de Dados:** MySQL 8
- **Backend:** FastAPI (Python)
- **Frontend:** a definir
- **Containerização:** Docker & Docker Compose

---

## 🛠️ Como rodar o projeto (Docker)

**TODO**

---

## 👤 Usuário padrão

- **Nome:** a definir
- **Email:** a definir
- **Endereço:** a definir

*-usuário é inserido automaticamente na criação do banco-*

---

## 📄 Estrutura das Tabelas

- **usuarios:** id, nome, email, endereco
- **oportunidades:** id, titulo, descricao, local
- **inscricoes:** id, usuario_id, oportunidade_id, data_inscricao

---

## 📝 Notas

- Backend, frontend e banco de dados rodam em containers independentes.
- O frontend consome a API REST do backend.

---

## 🌐 Deploy na nuvem (AWS)

**TODO**

---

