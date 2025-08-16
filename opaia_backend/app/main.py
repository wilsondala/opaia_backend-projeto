from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from app.api.api import api_router
from app.database import SessionLocal, engine, Base
import os

# Criação das tabelas
Base.metadata.create_all(bind=engine)

# Criação da aplicação FastAPI
app = FastAPI(
    title="Opaia Motors API",
    description="Backend do aplicativo de venda de carros em Angola",
    version="1.0.0"
)

# Criação de diretórios estáticos se não existirem
os.makedirs("uploads", exist_ok=True)
os.makedirs("app/static", exist_ok=True)

# Montagem dos diretórios estáticos
app.mount("/static", StaticFiles(directory="app/static"), name="static")
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")

# Garante que rotas sejam registradas
from app.api.api import incluir_rotas
incluir_rotas(app)
