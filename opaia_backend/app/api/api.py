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
api_router.include_router(auth_router, prefix="/auth", tags=["Auth"])
api_router.include_router(user_router, prefix="/users", tags=["Usuários"])
api_router.include_router(car_router, prefix="/cars", tags=["Carros"])
api_router.include_router(rent_router, prefix="/rents", tags=["Aluguéis"])
api_router.include_router(upload_router, prefix="/upload", tags=["Uploads"])
api_router.include_router(car_image_router, prefix="/car-images", tags=["Imagens de Carros"])

def incluir_rotas(app):
    app.include_router(api_router)
