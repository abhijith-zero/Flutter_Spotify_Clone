from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


DB_URL = "postgresql://admin:admin123@localhost:5432/app_db"
engine=create_engine(DB_URL)
sessionLocal=sessionmaker(autocommit=False,autoflush=False,bind=engine)

def get_db():
    db=sessionLocal()
    try:
        yield db
    finally:
        db.close()