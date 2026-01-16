from pydantic import BaseModel
from pydantic_schemas.UserResponse import UserResponse

class AuthResponse(BaseModel):
    access_token: str
    user: UserResponse
