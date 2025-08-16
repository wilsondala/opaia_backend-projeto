# app/models/car_image.py
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.db.base_class import Base

class CarImage(Base):
    __tablename__ = "car_images"

    id = Column(Integer, primary_key=True, index=True)
    filename = Column(String, nullable=False)
    url = Column(String, nullable=False)  # Pode ser a URL local ou URL do bucket
    car_id = Column(Integer, ForeignKey("cars.id"))
    car = relationship("Car", back_populates="images")
