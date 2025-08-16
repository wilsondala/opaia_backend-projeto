from app.database import engine, Base
from app.models.user import User
from app.models.car import Car
from app.models.car_image import CarImage
from app.models.rent import Rent  # <-- ESSA LINHA FALTAVA

def create_tables():
    print("Criando tabelas no banco de dados...")
    Base.metadata.create_all(bind=engine)
    print("Tabelas criadas com sucesso.")

if __name__ == "__main__":
    create_tables()
