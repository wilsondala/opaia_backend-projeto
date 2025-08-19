from pydantic import BaseModel

# ----- Token de Autenticação -----
class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"
