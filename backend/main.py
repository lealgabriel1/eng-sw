import os
from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from database.db import get_connection
from pydantic import BaseModel
from typing import Optional
from middleware_log import log_requests
import pytz
from datetime import datetime
from better_profanity import profanity

api = FastAPI()
api.middleware("http")(log_requests)
tz_br = pytz.timezone("America/Sao_Paulo")

BADWORDS_PATH = os.path.join(os.path.dirname(__file__), "blacklist.txt")
profanity.load_censor_words_from_file(BADWORDS_PATH)

# basemodels (pydantic)
class InscricaoPayLoad(BaseModel):
    user_id: int
    opp_id: int
    mensagem: str = ""

class PerfilUpdatePayload(BaseModel):
    nome: Optional[str]
    endereco: Optional[str]
    competencias: Optional[str]

#acesso <- ajustar
api.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#endpoints
# teste de conexão
@api.get("/test-connection")
def test_connection():
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
    conn.close()
    return {"db_connection": result}

### endpoints acerca das oporunidades ##

# oportunidades (feed com busca)
@api.get("/oportunidades")
def listar_oportunidades_feed(search: str = Query(None, description="Buscar por título da vaga")):
    conn = get_connection()
    with conn.cursor() as cursor:
        if search:
            cursor.execute("""
                SELECT 
                    o.id, o.titulo, o.lugar, o.msg_rapida, o.data_realizacao, g.nome AS ong_nome,
                    COALESCE(g.foto_perfil, '/images/placeholder_ong.png') AS foto_perfil_ong
                FROM oportunidades o
                JOIN ongs g ON o.ong_id = g.id
                WHERE o.titulo LIKE %s
                ORDER BY o.data_realizacao DESC
            """, (f"%{search}%",))
        else:
            cursor.execute("""
                SELECT 
                    o.id, o.titulo, o.lugar, o.msg_rapida, o.data_realizacao, g.nome AS ong_nome,
                    COALESCE(g.foto_perfil, '/images/placeholder_ong.png') AS foto_perfil_ong
                FROM oportunidades o
                JOIN ongs g ON o.ong_id = g.id
                ORDER BY o.data_realizacao DESC
            """)
        oportunidades = cursor.fetchall()
    conn.close()
    return oportunidades

# oportunidades (detalhes)
@api.get("/oportunidades/{id}")
def detalhe_oportunidade(id: int, user_id: int = 1):  # user_id mockado
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT 
                o.id, o.titulo, o.descricao, o.data_pub, o.data_realizacao, o.lugar,
                o.msg_rapida, o.pre_reqs,
                o.ong_id, g.nome AS ong_nome, g.email AS ong_email,
                g.descricao AS ong_descricao, g.endereco AS ong_endereco,
                COALESCE(g.foto_perfil, '/images/placeholder_ong.png') AS foto_perfil_ong
            FROM oportunidades o
            JOIN ongs g ON o.ong_id = g.id
            WHERE o.id = %s
        """, (id,))
        oportunidade = cursor.fetchone()

        # competências do usuário
        cursor.execute("SELECT competencias FROM usuarios WHERE id = %s", (user_id,))
        user = cursor.fetchone()

        # verificar inscrição do usuário
        cursor.execute("""
            SELECT 1 FROM inscricoes
            WHERE user_id = %s AND opp_id = %s
        """, (user_id, id))
        inscrito = cursor.fetchone()

    conn.close()

    # verificar competencias
    if oportunidade and user:
        user_comps = [c.strip().lower() for c in (user["competencias"] or "").split(",") if c.strip()]
        reqs = [c.strip().lower() for c in (oportunidade["pre_reqs"] or "").split(",") if c.strip()]
        tem = [c for c in reqs if c in user_comps]
        falta = [c for c in reqs if c not in user_comps]
        oportunidade["competencias_usuario"] = user.get("competencias", "")
        oportunidade["match"] = {"tem": tem, "falta": falta}

    if not oportunidade:
        raise HTTPException(status_code=404, detail="Oportunidade não encontrada")

    # privacidade do endereço
    if not inscrito:
        oportunidade["ong_endereco"] = None  # ou "Disponível após inscrição <- FRONT"

    return oportunidade

### frontend: usa match.tem e match.falta

### endpoint inscricao ###
@api.post("/inscricoes")
def candidatar_inscricao(payload: InscricaoPayLoad):
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            # checa se já existe inscrição
            cursor.execute("""
                SELECT 1 FROM inscricoes WHERE user_id = %s AND opp_id = %s
            """, (payload.user_id, payload.opp_id))
            if cursor.fetchone():
                raise HTTPException(status_code=409, detail="Já existe uma inscrição sua para esta vaga.")

            # censura palavrão antes de inserir nova inscrição
            bad_filter = profanity.censor(payload.mensagem)
            cursor.execute("""
                INSERT INTO inscricoes (user_id, opp_id, mensagem) 
                VALUES (%s, %s, %s)
            """, (payload.user_id, payload.opp_id, bad_filter))
            conn.commit()
        return {"success": True, "msg": "Inscrição realizada!"}
    finally:
        conn.close()

# inscricoes do usuario (Minhas Candidaturas)
@api.get("/inscricoes")
def listar_inscricoes(user_id: int):
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT 
                i.ID AS inscricao_id, 
                o.id AS oportunidade_id,
                o.titulo, o.data_realizacao, o.lugar,
                o.msg_rapida, o.pre_reqs, i.data_inscricao, i.mensagem,
                g.nome AS ong_nome
            FROM inscricoes i
            JOIN oportunidades o ON i.opp_id = o.id
            JOIN ongs g ON o.ong_id = g.id
            WHERE i.user_id = %s
            ORDER BY i.data_inscricao DESC
        """, (user_id,))
        inscricoes = cursor.fetchall()
    conn.close()
    #adciona status fixo "em aguardo" . . . não vai atualizar nessa versão
    for item in inscricoes:
        item["status"] = "em aguardo..."
        dt = item.get("data_inscricao")
        if isinstance(dt, datetime):
            dt_utc = dt.replace(tzinfo=pytz.utc)
            dt_br = dt_utc.astimezone(tz_br)
            item["data_inscricao"] = dt_br.strftime("%d/%m/%Y às %H:%M")
        else:
            item["data_inscricao"] = "Data inválida"
    return inscricoes

### endpoints perfil ###
@api.get("/perfil")
def perfil(user_id: int = 1):
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT id, nome, email, cpf, endereco, competencias,
                COALESCE(foto_perfil, '/images/placeholder_user.png') AS foto_perfil
            FROM usuarios
            WHERE id = %s
        """, (user_id,))
        user = cursor.fetchone()
    conn.close()
    if not user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    return user

@api.patch("/perfil")
def atualizar_perfil(payload: PerfilUpdatePayload, user_id: int = 1):
    updates = []
    params = []
    if payload.nome:
        updates.append("nome = %s")
        params.append(payload.nome)
    if payload.endereco:
        updates.append("endereco = %s")
        params.append(payload.endereco)
    if payload.competencias:
        updates.append("competencias = %s")
        params.append(payload.competencias)
    if not updates:
        raise HTTPException(status_code=400, detail="Nada para atualizar.")
    params.append(user_id)

    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute(f"""
            UPDATE usuarios SET {', '.join(updates)} WHERE id = %s
        """, params)
        conn.commit()
    conn.close()
    return {"success": True}

### endpoint ONG (caso necessário) ###
@api.get("/ongs")
def listar_ongs():
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT id, nome, email, descricao, endereco
            FROM ongs
            ORDER BY nome
        """)
        ongs = cursor.fetchall()
    conn.close()
    return ongs

@api.get("/ongs/{id}")
def detalhe_ong(id: int):
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT id, nome, email, descricao, endereco,
                COALESCE(foto_perfil, '/images/placeholder_ong.png') AS foto_perfil
            FROM ongs
            WHERE id = %s
        """, (id,))
        ong = cursor.fetchone()
    conn.close()
    if not ong:
        raise HTTPException(status_code=404, detail="ONG não encontrada")
    return ong