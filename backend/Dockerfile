FROM python:3.11

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN mkdir -p app/logs

COPY . .

CMD ["uvicorn", "main:api", "--host", "0.0.0.0", "--port", "8000", "--reload"]
