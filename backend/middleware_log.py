import logging
import pytz
from datetime import datetime
from fastapi import Request
from time import time
from pathlib import Path

# Garantir pasta de logs
Path("logs").mkdir(exist_ok=True)

# Função para hora local Brasil
def brazil_time(*args):
    return datetime.now(pytz.timezone("America/Sao_Paulo")).timetuple()

# Formatter customizado
class BrazilFormatter(logging.Formatter):
    def converter(self, timestamp):
        dt = datetime.fromtimestamp(timestamp, pytz.timezone("America/Sao_Paulo"))
        return dt
    def formatTime(self, record, datefmt=None):
        dt = self.converter(record.created)
        if datefmt:
            s = dt.strftime(datefmt)
        else:
            s = dt.isoformat()
        return s

logger = logging.getLogger("user_log")
logger.setLevel(logging.INFO)

if not logger.handlers:
    formatter = BrazilFormatter(
        '[%(asctime)s] %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    file_handler = logging.FileHandler("logs/app.log", encoding="utf-8")
    file_handler.setFormatter(formatter)
    stream_handler = logging.StreamHandler()
    stream_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    logger.addHandler(stream_handler)

# Middleware FastAPI
async def log_requests(request: Request, call_next):
    start_time = time()
    response = await call_next(request)
    duration_ms = round((time() - start_time) * 1000, 2)
    client_ip = request.client.host
    logger.info(
        f"{request.method} {request.url.path} (IP: {client_ip}) -> {response.status_code} ({duration_ms}ms)"
    )
    return response
