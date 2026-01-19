import uuid
from fastapi import APIRouter, File, Form, UploadFile
from fastapi.params import Depends
from models.Song import Song
from settings import settings
from middleware.authMiddleware import authMiddleware
from sqlalchemy.orm import Session
import cloudinary
import cloudinary.uploader
from database import get_db


router = APIRouter()
cloudinary.config( 
    cloud_name = "df6lzrmqk", 
    api_key = "523974723711272", 
    api_secret = settings.CLOUDINARY_URL, 
    secure=True
)

@router.post('/upload',status_code=201)
def upload_song(thumbnail:UploadFile=File(...),song:UploadFile=File(...),song_name:str =Form(...),artist_name:str=Form(...),hex_code:str=Form(...),db:Session=Depends(get_db),auth_dict=Depends(authMiddleware)): 
    song_id=str(uuid.uuid4())
    song_res=cloudinary.uploader.upload(song.file,resource_type="auto",folder=f"songs/{song_id}")
    # print(song_res['url'])
    thumbnail_res=cloudinary.uploader.upload(thumbnail.file,folder=f"songs/{song_id}")
    # print(thumbnail_res['url'])
    new_song=Song(
        id=song_id,
        song_url=song_res['url'],
        thumbnail_url=thumbnail_res['url'],
        song_name=song_name,
        artist_name=artist_name,
        hex_code=hex_code
    )
    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    return new_song