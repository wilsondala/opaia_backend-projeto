from sqlalchemy.orm import Session
from sqlalchemy import and_, or_
from datetime import date
from app.models.rent import Rent
from app.schemas.rent import RentCreate
from fastapi import HTTPException

def verificar_disponibilidade(db: Session, car_id: int, data_inicio: date, data_fim: date):
    conflitos = db.query(Rent).filter(
        Rent.car_id == car_id,
        or_(
            and_(Rent.start_date <= data_inicio, Rent.end_date >= data_inicio),
            and_(Rent.start_date <= data_fim, Rent.end_date >= data_fim),
            and_(Rent.start_date >= data_inicio, Rent.end_date <= data_fim),
        )
    ).first()

    if conflitos:
        raise HTTPException(status_code=400, detail="Carro indisponível para o período selecionado.")

def criar_aluguel(db: Session, aluguel: RentCreate, user_id: int):
    verificar_disponibilidade(db, aluguel.car_id, aluguel.data_inicio, aluguel.data_fim)

    novo_aluguel = Rent(
        user_id=user_id,
        car_id=aluguel.car_id,
        start_date=aluguel.data_inicio,
        end_date=aluguel.data_fim,
        status="pendente"
    )

    db.add(novo_aluguel)
    db.commit()
    db.refresh(novo_aluguel)
    return novo_aluguel
