# app/api/api.py
from fastapi import APIRouter
from app.api.routes import (
    auth_router,
    user_router,
    car_router,
    rent_router,
    upload_router,
    car_image_router,
)

api_router = APIRouter()

# Rotas de autenticação e usuários
api_router.include_router(auth_router, prefix="/auth", tags=["Autenticação"])
api_router.include_router(user_router, prefix="/users", tags=["Usuários"])

# Rotas de carros
api_router.include_router(car_router, prefix="/cars", tags=["Carros"])

# Rotas de aluguel
api_router.include_router(rent_router, prefix="/rents", tags=["Aluguéis"])

# Rotas de uploads
api_router.include_router(upload_router, prefix="/upload", tags=["Uploads"])

# Rotas de imagens de carros
api_router.include_router(car_image_router, prefix="/car-images", tags=["Imagens de Carros"])


def incluir_rotas(app):
    """
    Função para incluir todas as rotas no FastAPI app.
    """
    app.include_router(api_router)
