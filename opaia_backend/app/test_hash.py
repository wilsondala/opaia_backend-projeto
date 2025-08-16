from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Hash esperado no banco
hash_from_db = "$2b$12$KIu0xmOfnOK4VqC1DL39F.kK8Zgl7u7RqoOxCqEHLKxfE41q46dN6"

# Senha que o usuário tenta usar
plain_password = "1234"

# Verifica
print("Senha confere?", pwd_context.verify(plain_password, hash_from_db))
