from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import Car, User
from app.schemas import CarroCreate, CarroOut
from app.api.deps import get_current_user

router = APIRouter()

@router.post("/cars/", response_model=CarroOut, tags=["Carros"])
def criar_carro(
    carro: CarroCreate,
    usuario: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    novo_carro = Car(
        marca=carro.marca,
        modelo=carro.modelo,
        ano=carro.ano,
        preco=carro.preco,
        descricao=carro.descricao,
        dono_id=usuario.id
    )
    db.add(novo_carro)
    db.commit()
    db.refresh(novo_carro)
    return novo_carro
