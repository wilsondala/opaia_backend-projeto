from sqlalchemy.orm import Session
from app.models.car import Car
from app.schemas.car import CarCreate
from app.models.user import User
from typing import Optional, List

def criar_carro(db: Session, dados: CarCreate, usuario: User) -> Car:
    novo_carro = Car(**dados.dict(), dono_id=usuario.id)
    db.add(novo_carro)
    db.commit()
    db.refresh(novo_carro)
    return novo_carro

def listar_carros(db: Session, marca: Optional[str] = None, modelo: Optional[str] = None, preco_maximo: Optional[float] = None) -> List[Car]:
    query = db.query(Car)
    if marca:
        query = query.filter(Car.marca == marca)
    if modelo:
        query = query.filter(Car.modelo == modelo)
    if preco_maximo:
        query = query.filter(Car.preco <= preco_maximo)
    return query.all()

def buscar_carro_por_id(db: Session, carro_id: int) -> Optional[Car]:
    return db.query(Car).filter(Car.id == carro_id).first()


def atualizar_carro(db: Session, carro: Car, dados_atualizados: CarCreate):
    for campo, valor in dados_atualizados.dict(exclude_unset=True).items():
        setattr(carro, campo, valor)
    db.commit()
    db.refresh(carro)
    return carro
