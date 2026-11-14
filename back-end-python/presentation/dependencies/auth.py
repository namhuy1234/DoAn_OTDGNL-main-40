"""Presentation: JWT auth dependencies."""
from typing import Optional

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

from infrastructure.security.jwt_token_service import JwtTokenService

# Bearer token: client gửi header Authorization: Bearer <token>
bearer_scheme = HTTPBearer(auto_error=False)


def get_current_user(credentials: Optional[HTTPAuthorizationCredentials] = Depends(bearer_scheme)) -> dict:
    """
    Dependency:
    - Nếu không có token hoặc token sai => HTTP 401.
    - Nếu hợp lệ => trả payload của token.
    """
    if credentials is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Thiếu token xác thực.")
    token_service = JwtTokenService()
    payload = token_service.decode_access_token(credentials.credentials)
    if payload is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token không hợp lệ hoặc đã hết hạn.")
    return payload


def get_optional_user(credentials: Optional[HTTPAuthorizationCredentials] = Depends(bearer_scheme)) -> Optional[dict]:
    """
    Dependency cho endpoint công khai nhưng xử lý khác khi đã đăng nhập
    (ví dụ: nộp bài có token thì lưu lịch sử). Token sai thì coi như khách.
    """
    if credentials is None:
        return None
    return JwtTokenService().decode_access_token(credentials.credentials)


def is_admin(user: Optional[dict]) -> bool:
    return bool(user) and str(user.get("role", "")).lower() == "admin"


def require_admin(current_user: dict = Depends(get_current_user)) -> dict:
    """
    Dependency cho endpoint chỉ admin mới được dùng.
    - Nếu role != admin => HTTP 403.
    """
    if not is_admin(current_user):
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Bạn không có quyền admin.")
    return current_user
