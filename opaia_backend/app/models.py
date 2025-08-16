from sqlalchemy import Column, Integer, String, Float
from app.database import Base  # use só um lugar para importar Base

class Car(Base):
    __tablename__ = "cars"

    id = Column(Integer, primary_key=True, index=True)
    brand = Column(String, index=True)
    model = Column(String, index=True)
    year = Column(Integer)
    price = Column(Float)
    description = Column(String, nullable=True)
