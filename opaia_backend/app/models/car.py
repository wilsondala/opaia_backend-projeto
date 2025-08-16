from sqlalchemy import Column, Integer, String, Float, ForeignKey, Text
from sqlalchemy.orm import relationship
from app.db.base_class import Base
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from app.models.user import User
    from app.models.car_image import CarImage
    from app.models.rent import Rent

class Car(Base):
    __tablename__ = "cars"

    id = Column(Integer, primary_key=True, index=True)
    marca = Column(String, nullable=False)
    modelo = Column(String, nullable=False)
    ano = Column(Integer, nullable=False)
    preco = Column(Float, nullable=True)
    quilometragem = Column(Integer, nullable=True)
    descricao = Column(Text, nullable=True)

    dono_id = Column(Integer, ForeignKey("users.id"))
    dono = relationship("User", back_populates="cars")

    images = relationship("CarImage", back_populates="car", cascade="all, delete-orphan")
    rents = relationship("Rent", back_populates="car")
