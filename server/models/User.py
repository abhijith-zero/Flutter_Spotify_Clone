
from sqlalchemy import Column, VARCHAR, TEXT, LargeBinary
from .base import Base


class User(Base):
    __tablename__ = 'users'
    id = Column(TEXT, primary_key=True)
    username = Column(VARCHAR(100))
    password = Column(LargeBinary)
    email = Column(VARCHAR(100), unique=True)
