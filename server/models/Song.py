from models.base import Base
from sqlalchemy import Column, String, Integer, TEXT, VARCHAR



class Song(Base):
    __tablename__ = 'songs'
    id = Column(TEXT, primary_key=True)
    song_url = Column(TEXT)
    thumbnail_url = Column(TEXT, )
    song_name = Column(VARCHAR(100))
    artist_name = Column(TEXT, )
    hex_code = Column(VARCHAR(6))
    