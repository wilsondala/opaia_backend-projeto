from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app.models.rent import Rent
from app.schemas.rent import RentCreate, RentOut
from app.api.deps import get_current_user

router = APIRouter(prefix="/rents", tags=["Aluguéis"])

@router.post("/", response_model=RentOut)
def rent_car(rent_in: RentCreate, db: Session = Depends(get_db), user=Depends(get_current_user)):
    new_rent = Rent(**rent_in.dict(), user_id=user.id)
    db.add(new_rent)
    db.commit()
    db.refresh(new_rent)
    return new_rent

@router.get("/", response_model=list[RentOut])
def list_user_rents(db: Session = Depends(get_db), user=Depends(get_current_user)):
    return db.query(Rent).filter(Rent.user_id == user.id).all()
