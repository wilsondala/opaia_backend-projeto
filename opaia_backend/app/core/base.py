# app/db/base.py
from sqlalchemy.ext.declarative import declarative_base
from app.core.base import Base

__all__ = ['Base']


Base = declarative_base()
