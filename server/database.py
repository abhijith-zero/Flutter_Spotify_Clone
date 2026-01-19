from settings import settings
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


engine=create_engine(settings.DB_URL)
sessionLocal=sessionmaker(autocommit=False,autoflush=False,bind=engine)

def get_db():
    db=sessionLocal()
    try:
        yield db
    finally:
        db.close()