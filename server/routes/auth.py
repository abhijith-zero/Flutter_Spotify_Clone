import uuid
from fastapi import APIRouter, Depends, HTTPException
from fastapi.params import Header
from middleware.authMiddleware import authMiddleware
from pydantic_schemas.UserResponse import  UserResponse
from pydantic_schemas.AuthResponse import AuthResponse
from pydantic_schemas.userLogin import userLogin
from pydantic_schemas.userCreate import userCreate
from sqlalchemy.orm import Session
import bcrypt
from database import get_db
from models.User import User
import jwt  

router = APIRouter()
@router.post('/signup',status_code=201,response_model=UserResponse)
def signup_user(user: userCreate, db: Session=Depends(get_db)):
    if user.password != user.confirm_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")
    foundUser=db.query(User).filter(User.email == user.email).first()
    if foundUser:
        raise HTTPException(status_code=400, detail="User with this email already exists")
    hashed_password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    new_user = User(
        id=str(uuid.uuid4()),
        username=user.username,
        password=hashed_password,
        email=user.email
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return new_user


@router.post('/login',status_code=200,response_model=AuthResponse)
def login_user(user: userLogin, db: Session=Depends(get_db)):
    foundUser=db.query(User).filter(User.email == user.email).first()
    if not foundUser:
        raise HTTPException(status_code=400, detail="Invalid email or password")
    if not bcrypt.checkpw(user.password.encode(), foundUser.password):
        raise HTTPException(status_code=400, detail="Invalid password")
    token = jwt.encode({"id":foundUser.id},'secret_key')
    
    return {"access_token": token, "user": foundUser}

@router.get('/',status_code=200,response_model=UserResponse)
def current_user_session(db: Session=Depends(get_db),user_dict=Depends(authMiddleware)):  # authMiddleware
    user_id = user_dict["user_id"]
    foundUser = db.query(User).filter(User.id == user_id).first()
    if not foundUser:
        raise HTTPException(status_code=404, detail="User not found")
    return foundUser