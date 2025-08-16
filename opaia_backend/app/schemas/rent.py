from pydantic import BaseModel, Field
from datetime import date
from typing import Optional

class RentCreate(BaseModel):
    car_id: int
    data_inicio: date = Field(..., alias="start_date")
    data_fim: date = Field(..., alias="end_date")

class RentOut(BaseModel):
    id: int
    user_id: int
    car_id: int
    data_inicio: date = Field(..., alias="start_date")
    data_fim: date = Field(..., alias="end_date")
    status: str

    class Config:
        orm_mode = True
        allow_population_by_field_name = True
