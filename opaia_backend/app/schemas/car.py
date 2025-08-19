from typing import Optional
from pydantic import BaseModel

# ----- Base Carro -----
class CarBase(BaseModel):
    marca: str
    modelo: str
    ano: int
    preco: Optional[float] = None
    descricao: Optional[str] = None
    imagem_url: Optional[str] = None

# ----- Criar Carro -----
class CarCreate(CarBase):
    pass

# ----- Retorno de Carro -----
class CarOut(CarBase):
    id: int

    class Config:
        from_attributes = True  # Pydantic v2, compatível com SQLAlchemy
