from fastapi import APIRouter, Depends, Query
from typing import Optional, List
from sqlalchemy.orm import Session
from app.api.deps import get_current_user
from app.database import get_db
from app.models.car import Car
from app.models.user import User
from app.schemas.car import CarCreate, CarOut

router = APIRouter(prefix="/cars", tags=["Carros"])

@router.post("/", response_model=CarOut)
def criar_carro(
    carro: CarCreate,
    db: Session = Depends(get_db),
    usuario: User = Depends(get_current_user)
):
    novo_carro = Car(**carro.dict(), dono_id=usuario.id)
    db.add(novo_carro)
    db.commit()
    db.refresh(novo_carro)
    return novo_carro

@router.get("/", response_model=List[CarOut])
def listar_carros(
    marca: Optional[str] = Query(None),
    ano_min: Optional[int] = Query(None),
    ano_max: Optional[int] = Query(None),
    preco_min: Optional[float] = Query(None),
    preco_max: Optional[float] = Query(None),
    db: Session = Depends(get_db)
):
    query = db.query(Car)

    if marca:
        query = query.filter(Car.marca.ilike(f"%{marca}%"))
    if ano_min:
        query = query.filter(Car.ano >= ano_min)
    if ano_max:
        query = query.filter(Car.ano <= ano_max)
    if preco_min:
        query = query.filter(Car.preco >= preco_min)
    if preco_max:
        query = query.filter(Car.preco <= preco_max)

    return query.all()

@router.get("/meus", response_model=List[CarOut])
def listar_meus_carros(
    db: Session = Depends(get_db),
    usuario: User = Depends(get_current_user)
):
    carros = db.query(Car).filter(Car.dono_id == usuario.id).all()
    return carros
