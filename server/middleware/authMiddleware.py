from fastapi import Header, HTTPException
import jwt


def authMiddleware(x_auth_token=Header()):
    try:
        if not x_auth_token:
            raise HTTPException(status_code=401, detail="Authorization token missing or invalid")
        verified_token = jwt.decode(x_auth_token,'secret_key',algorithms=["HS256"])
        if not verified_token:
            raise HTTPException(status_code=401, detail="Invalid token")
        user_id = verified_token.get("id")
        return {"user_id": user_id, "token": x_auth_token}
    except jwt.PyJWTError as e:
        raise HTTPException(status_code=401, detail="Invalid token Authorization Failed")