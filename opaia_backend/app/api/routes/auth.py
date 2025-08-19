from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta

from app.schemas.user import UserOut, UserCreate
from app.schemas.auth import Token
from app import crud
from app.api.deps import get_db, get_current_user
from app.core.config import settings
from app.core.security import verify_password, create_access_token

router = APIRouter(tags=["Autenticação"])

@router.post("/register", response_model=UserOut, summary="Registrar novo usuário")
def registrar_usuario(user_create: UserCreate, db: Session = Depends(get_db)):
    usuario_existente = crud.user.get_user_by_email(db, email=user_create.email)
    if usuario_existente:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Este email já está em uso.",
        )
    usuario = crud.user.create_user(db=db, user=user_create)
    return usuario

@router.post("/login", response_model=Token, summary="Login de usuário e obtenção do token")
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    usuario = crud.user.get_user_by_email(db, email=form_data.username)
    if not usuario or not verify_password(form_data.password, usuario.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Email ou senha incorretos.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    tempo_expiracao_token = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    token_acesso = create_access_token(
        data={"sub": str(usuario.id)},
        expires_delta=tempo_expiracao_token
    )
    return {"access_token": token_acesso, "token_type": "bearer"}

@router.get("/me", response_model=UserOut, summary="Obter dados do usuário autenticado")
def ler_usuario_atual(current_user=Depends(get_current_user)):
    return current_user
