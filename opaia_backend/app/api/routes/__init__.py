from .auth import router as auth_router
from .user_routes import router as user_router
from .car_routes import router as car_router
from .rent_routes import router as rent_router
from .upload_routes import router as upload_router
from .car_image_routes import router as car_image_router

__all__ = [
    "auth_router",
    "user_router",
    "car_router",
    "rent_router",
    "upload_router",
    "car_image_router",
]
