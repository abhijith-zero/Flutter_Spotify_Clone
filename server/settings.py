from pydantic import Field
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DB_URL: str 
    debug: bool = False
    CLOUDINARY_URL: str

    class Config:
        env_file = ".env"

settings = Settings()
