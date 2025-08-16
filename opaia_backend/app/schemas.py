from pydantic import BaseModel
from typing import Optional

class CarroCreate(BaseModel):
    marca: str
    modelo: str
    ano: int
    preco: float
    descricao: Optional[str] = None

class CarroOut(CarroCreate):
    id: int

    class Config:
        from_attributes = True  # Para converter objetos ORM automaticamente
