"""Presentation: Users router (quản lý người dùng, chỉ admin)."""
from typing import Annotated, Optional

from fastapi import APIRouter, Depends, Path
from fastapi.responses import PlainTextResponse
from pydantic import BaseModel, ConfigDict, Field

from application.dto.common import aliases
from application.use_cases.user_use_case import UserUseCase
from infrastructure.repositories.sql_exam_result_repository import SqlExamResultRepository
from infrastructure.repositories.sql_user_repository import SqlUserRepository
from presentation.dependencies.auth import require_admin

router = APIRouter(prefix="/users", tags=["Users"])


class RoleDto(BaseModel):
    model_config = ConfigDict(populate_by_name=True)

    Role: Annotated[Optional[str], Field(validation_alias=aliases("Role"))] = None


def _use_case() -> UserUseCase:
    return UserUseCase(SqlUserRepository(), SqlExamResultRepository())


def _error(err: Exception) -> PlainTextResponse:
    code = 400 if isinstance(err, ValueError) else 403 if isinstance(err, PermissionError) else 404
    return PlainTextResponse(content=str(err), status_code=code)


@router.get("")
async def get_users(admin_user: dict = Depends(require_admin)):
    return _use_case().get_all()


@router.put("/{user_id}/role")
async def change_role(user_id: int = Path(...), body: Optional[RoleDto] = None, admin_user: dict = Depends(require_admin)):
    try:
        _use_case().change_role(user_id, body.Role if body else None, admin_user.get("user_id"))
    except (ValueError, PermissionError, LookupError) as err:
        return _error(err)
    return {"Message": "Đã cập nhật vai trò."}


@router.delete("/{user_id}")
async def delete_user(user_id: int = Path(...), admin_user: dict = Depends(require_admin)):
    try:
        _use_case().delete(user_id, admin_user.get("user_id"))
    except (PermissionError, LookupError) as err:
        return _error(err)
    return {"Message": "Đã xóa người dùng và lịch sử làm bài của người đó."}
