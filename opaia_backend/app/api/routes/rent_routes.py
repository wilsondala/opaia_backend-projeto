from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app.schemas.rent import RentCreate, RentOut
from app.models.user import User
from app.api.deps import get_current_user
from app.crud import rent as rent_crud

router = APIRouter(tags=["Aluguel de Carros"])

@router.post("/", response_model=RentOut)
def solicitar_aluguel(
    aluguel: RentCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return rent_crud.criar_aluguel(db=db, aluguel=aluguel, user_id=current_user.id)
