# Dentro de um script de inicialização como app/init_db.py, por exemplo
from app.database import Base, engine
from app.models.user import User

print("Criando tabelas...")
Base.metadata.create_all(bind=engine)
print("Tabelas criadas com sucesso.")
