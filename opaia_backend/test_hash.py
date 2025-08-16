from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

senha = "1234"
hash = pwd_context.hash(senha)

print("Hash gerado:", hash)
