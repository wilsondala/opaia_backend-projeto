from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from app.database import get_db
from app.models.rent import Rent
from app.schemas.rent import RentCreate, RentOut

router = APIRouter(prefix="/rents", tags=["rents"])

@router.post("/", response_model=RentOut, status_code=status.HTTP_201_CREATED)
def create_rent(rent_in: RentCreate, db: Session = Depends(get_db)):
    rent = Rent(**rent_in.dict())
    db.add(rent)
    db.commit()
    db.refresh(rent)
    return rent

@router.get("/", response_model=List[RentOut])
def list_rents(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    rents = db.query(Rent).offset(skip).limit(limit).all()
    return rents

@router.get("/{rent_id}", response_model=RentOut)
def get_rent(rent_id: int, db: Session = Depends(get_db)):
    rent = db.query(Rent).filter(Rent.id == rent_id).first()
    if not rent:
        raise HTTPException(status_code=404, detail="Aluguel não encontrado")
    return rent

@router.delete("/{rent_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_rent(rent_id: int, db: Session = Depends(get_db)):
    rent = db.query(Rent).filter(Rent.id == rent_id).first()
    if not rent:
        raise HTTPException(status_code=404, detail="Aluguel não encontrado")
    db.delete(rent)
    db.commit()
