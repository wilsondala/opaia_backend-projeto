from pydantic import BaseModel, EmailStr
from typing import Optional

# ----- Token -----
class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

# ----- Dados de Token -----
class TokenData(BaseModel):
    username: Optional[str] = None

# ----- Usuário retornado -----
class UserOut(BaseModel):
    id: int
    email: EmailStr
    full_name: str

    class Config:
        from_attributes = True  # Pydantic v2
