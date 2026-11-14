"""Presentation: Exam router (nộp bài, lịch sử, thống kê, bảng thành tích)."""
from typing import Optional

from fastapi import APIRouter, Depends, Path, Query
from fastapi.responses import PlainTextResponse

from application.dto.exam import ExamSubmissionDto
from application.dto.exam_info import CheckAnswerDto
from application.use_cases.exam_use_case import ExamUseCase
from infrastructure.repositories.sql_exam_result_repository import SqlExamResultRepository
from infrastructure.repositories.sql_question_repository import SqlQuestionRepository
from presentation.dependencies.auth import get_current_user, get_optional_user, is_admin, require_admin


router = APIRouter(prefix="/exam", tags=["Exam"])


def _use_case() -> ExamUseCase:
    return ExamUseCase(SqlQuestionRepository(), SqlExamResultRepository())


@router.post("/submit")
async def submit_exam(submission: Optional[ExamSubmissionDto] = None, user: Optional[dict] = Depends(get_optional_user)):
    if submission is None or not submission.Answers:
        return PlainTextResponse(content="Bài làm không có dữ liệu trả lời.", status_code=400)

    try:
        # Có token học sinh thì lưu lượt làm bài vào ExamResults; khách chỉ được chấm điểm.
        result = _use_case().submit(submission, user.get("user_id") if user else None)
    except ValueError as err:
        return PlainTextResponse(content=str(err), status_code=400)
    return {
        "TotalQuestions": result.total_questions,
        "CorrectCount": result.correct_count,
        "BlankCount": result.blank_count,
        "ScorePercentage": result.score_percentage,
        "ExamCode": result.exam_code,
        "SubjectCategory": result.subject_category,
        "ResultId": result.result_id,
        "Saved": result.result_id is not None,
        "Details": result.details,
    }


@router.get("/history")
async def my_history(user: dict = Depends(get_current_user)):
    """Lịch sử làm bài của người đang đăng nhập, mới nhất trước."""
    return _use_case().history(int(user["user_id"]))


@router.get("/statistics")
async def my_statistics(user: dict = Depends(get_current_user)):
    """Thống kê học tập: tổng quan, theo môn và điểm các lượt gần nhất."""
    return _use_case().statistics(int(user["user_id"]))


@router.get("/leaderboard")
async def leaderboard(subject: Optional[str] = Query(None), limit: int = Query(10, ge=1, le=50)):
    """Bảng thành tích: điểm cao nhất của mỗi học sinh trên mỗi bộ đề."""
    return _use_case().leaderboard(subject, limit)


@router.get("/overview")
async def overview(admin_user: dict = Depends(require_admin)):
    """Thống kê toàn hệ thống cho trang quản lý."""
    return _use_case().overview()


@router.post("/check")
async def check_answer(body: Optional[CheckAnswerDto] = None):
    """Chế độ ôn tập: chấm ngay một câu (không lưu lịch sử)."""
    if body is None:
        return PlainTextResponse(content="Thiếu dữ liệu câu trả lời.", status_code=400)
    try:
        return _use_case().check_answer(body.QuestionId, body.SelectedAnswer)
    except LookupError as err:
        return PlainTextResponse(content=str(err), status_code=404)


@router.get("/history/{result_id}")
async def review_attempt(result_id: int = Path(...), user: dict = Depends(get_current_user)):
    """Xem lại bài làm chi tiết của một lượt (chủ bài làm hoặc admin)."""
    try:
        return _use_case().review(result_id, int(user["user_id"]), is_admin(user))
    except LookupError as err:
        return PlainTextResponse(content=str(err), status_code=404)
