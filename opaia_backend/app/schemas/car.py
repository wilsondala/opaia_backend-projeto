from typing import Optional
from pydantic import BaseModel

class CarBase(BaseModel):
    marca: str
    modelo: str
    ano: int
    preco: Optional[float] = None  # <-- alteração aqui
    descricao: Optional[str] = None
    imagem_url: Optional[str] = None


class CarCreate(CarBase):
    pass


class CarOut(CarBase):
    id: int

    class Config:
        from_attributes = True
