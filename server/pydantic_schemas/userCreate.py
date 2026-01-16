from pydantic import BaseModel
class userCreate(BaseModel):
    username: str   
    password: str
    confirm_password: str
    email: str
