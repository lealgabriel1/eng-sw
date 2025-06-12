import os
import pymysql
from dotenv import load_dotenv

#carregar variaves do .env
load_dotenv()

def get_connection():
    """Abre e retorna uma conexão mypysql (dict)."""
    return pymysql.connect(
        host=os.getenv("DB_HOST", "mysql"),
        port=int(os.getenv("DB_PORT", 3306)), 
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", "123456"),
        database=os.getenv("DB_NAME", "candidatese"),
        cursorclass=pymysql.cursors.DictCursor
    )