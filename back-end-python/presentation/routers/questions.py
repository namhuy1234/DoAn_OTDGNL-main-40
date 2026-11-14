"""Presentation: Questions router."""
from typing import Optional

from fastapi import APIRouter, Depends, Path
from fastapi.responses import PlainTextResponse

from application.dto.question import QuestionDto
from application.use_cases.question_use_case import QuestionUseCase
from infrastructure.repositories.sql_exam_repository import SqlExamRepository
from infrastructure.repositories.sql_question_repository import SqlQuestionRepository
from presentation.dependencies.auth import get_optional_user, is_admin, require_admin

router = APIRouter(prefix="/questions", tags=["Questions"])


@router.get("")
async def get_all_questions(user: Optional[dict] = Depends(get_optional_user)):
    # Chỉ admin (gửi kèm token) mới nhận đáp án đúng và lời giải; học sinh nhận đề trống đáp án.
    use_case = QuestionUseCase(SqlQuestionRepository())
    return use_case.get_all(with_answer=is_admin(user))


@router.post("", status_code=201)
async def create_question(question: Optional[QuestionDto] = None, admin_user: dict = Depends(require_admin)):
    if question is None:
        return PlainTextResponse(content="Dữ liệu câu hỏi không hợp lệ.", status_code=400)

    use_case = QuestionUseCase(SqlQuestionRepository(), SqlExamRepository())
    try:
        return use_case.create(question)
    except ValueError as err:
        return PlainTextResponse(content=str(err), status_code=400)


@router.put("/{question_id}", status_code=200)
async def update_question(question_id: int = Path(...), question: Optional[QuestionDto] = None, admin_user: dict = Depends(require_admin)):
    if question is None:
        return PlainTextResponse(content="Dữ liệu câu hỏi không hợp lệ.", status_code=400)

    use_case = QuestionUseCase(SqlQuestionRepository(), SqlExamRepository())
    try:
        QuestionUseCase.validate(question)
    except ValueError as err:
        return PlainTextResponse(content=str(err), status_code=400)
    try:
        return use_case.update(question_id, question)
    except ValueError as err:
        return PlainTextResponse(content=str(err), status_code=404)


@router.delete("/{question_id}", status_code=200)
async def delete_question(question_id: int = Path(...), admin_user: dict = Depends(require_admin)):
    use_case = QuestionUseCase(SqlQuestionRepository())
    try:
        use_case.delete(question_id)
    except ValueError as err:
        return PlainTextResponse(content=str(err), status_code=404)
    return {"Message": "Đã xóa câu hỏi thành công."}
