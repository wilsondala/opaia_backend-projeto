from sqlalchemy.orm import Session
from app.models.car import Car
from app.schemas.car import CarCreate
from app.models.user import User

def criar_carro(db: Session, dados: CarCreate, usuario: User):
    novo_carro = Car(**dados.dict(), owner_id=usuario.id)
    db.add(novo_carro)
    db.commit()
    db.refresh(novo_carro)
    return novo_carro

def listar_carros(db: Session, marca=None, modelo=None, preco_maximo=None):
    query = db.query(Car)
    if marca:
        query = query.filter(Car.brand == marca)
    if modelo:
        query = query.filter(Car.model == modelo)
    if preco_maximo:
        query = query.filter(Car.price <= preco_maximo)
    return query.all()

def buscar_carro_por_id(db: Session, carro_id: int):
    return db.query(Car).filter(Car.id == carro_id).first()

def deletar_carro(db: Session, carro: Car):
    db.delete(carro)
    db.commit()

def atualizar_carro(db: Session, carro: Car, dados_atualizados: CarCreate):
    for chave, valor in dados_atualizados.dict(exclude_unset=True).items():
        setattr(carro, chave, valor)
    db.commit()
    db.refresh(carro)
    return carro

