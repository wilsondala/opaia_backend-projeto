from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from sqlalchemy.orm import Session
from jose import JWTError, jwt

from app.schemas import UserCreate, UserOut, Token
from app.models.user import User
from app.api.deps import get_db, get_current_user
from app.core.config import settings
from app.core.security import verify_password, create_access_token, get_password_hash

# Sem prefixo aqui — será adicionado no api.py


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")


@router.post("/register", response_model=UserOut, summary="Registrar novo usuário")
def registrar_usuario(user_create: UserCreate, db: Session = Depends(get_db)):
    usuario_existente = db.query(User).filter(User.email == user_create.email).first()
    if usuario_existente:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Este email já está em uso.",
        )
    usuario = User(
        email=user_create.email,
        full_name=user_create.full_name,
        hashed_password=get_password_hash(user_create.password),
    )
    db.add(usuario)
    db.commit()
    db.refresh(usuario)
    return usuario

@router.post("/login", response_model=Token, summary="Login de usuário e obtenção do token")
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    usuario = db.query(User).filter(User.email == form_data.username).first()
    if not usuario or not verify_password(form_data.password, usuario.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Email ou senha incorretos.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    tempo_expiracao_token = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    token_acesso = create_access_token(
        data={"sub": usuario.email}, expires_delta=tempo_expiracao_token
    )
    return {"access_token": token_acesso, "token_type": "bearer"}

@router.get("/me", response_model=UserOut, summary="Obter dados do usuário autenticado")
def ler_usuario_atual(current_user: User = Depends(get_current_user)):
    return current_user
