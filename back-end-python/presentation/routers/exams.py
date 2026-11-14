"""Presentation: Exams router (danh mục bộ đề; xem công khai, thêm/sửa/xóa chỉ admin)."""
from typing import Optional

from fastapi import APIRouter, Depends, Path
from fastapi.responses import PlainTextResponse

from application.dto.exam_info import ExamInfoDto
from application.use_cases.exam_catalog_use_case import ExamCatalogUseCase
from infrastructure.repositories.sql_exam_repository import SqlExamRepository
from presentation.dependencies.auth import require_admin

router = APIRouter(prefix="/exams", tags=["Exams"])


def _use_case() -> ExamCatalogUseCase:
    return ExamCatalogUseCase(SqlExamRepository())


def _error(err: Exception) -> PlainTextResponse:
    code = 400 if isinstance(err, ValueError) else 409 if isinstance(err, PermissionError) else 404
    return PlainTextResponse(content=str(err), status_code=code)


@router.get("")
async def get_exams():
    return _use_case().get_all()


@router.get("/{exam_code}")
async def get_exam(exam_code: str = Path(...)):
    exam = _use_case().get_by_code(exam_code)
    if exam is None:
        return PlainTextResponse(content="Không tìm thấy bộ đề.", status_code=404)
    return exam


@router.post("", status_code=201)
async def create_exam(body: Optional[ExamInfoDto] = None, admin_user: dict = Depends(require_admin)):
    try:
        return _use_case().create(body or ExamInfoDto())
    except ValueError as err:
        return _error(err)


@router.put("/{exam_id}")
async def update_exam(exam_id: int = Path(...), body: Optional[ExamInfoDto] = None, admin_user: dict = Depends(require_admin)):
    try:
        return _use_case().update(exam_id, body or ExamInfoDto())
    except (ValueError, LookupError) as err:
        return _error(err)


@router.delete("/{exam_id}")
async def delete_exam(exam_id: int = Path(...), admin_user: dict = Depends(require_admin)):
    try:
        _use_case().delete(exam_id)
    except (PermissionError, LookupError) as err:
        return _error(err)
    return {"Message": "Đã xóa bộ đề."}
