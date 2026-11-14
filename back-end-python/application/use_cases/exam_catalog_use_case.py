"""Application use case cho quản lý bộ đề (bảng Exams)."""
from typing import List, Optional

from application.dto.exam_info import ExamInfoDto
from application.interfaces.repositories import IExamRepository
from domain.entities.exam import Exam


def exam_to_dict(e: Exam) -> dict:
    return {
        "Id": e.id,
        "ExamCode": e.exam_code,
        "Title": e.title,
        "SubjectCategory": e.subject_category,
        "DurationMinutes": e.duration_minutes,
        "Description": e.description,
        "QuestionCount": e.question_count,
    }


def _validate(dto: ExamInfoDto) -> Exam:
    title = (dto.Title or "").strip()
    if not title:
        raise ValueError("Vui lòng nhập tên bộ đề.")
    minutes = int(dto.DurationMinutes or 0)
    if not 1 <= minutes <= 300:
        raise ValueError("Thời gian làm bài phải từ 1 đến 300 phút.")
    return Exam(
        exam_code=(dto.ExamCode or "").strip(),
        title=title,
        subject_category=(dto.SubjectCategory or "").strip(),
        duration_minutes=minutes,
        description=(dto.Description or "").strip(),
    )


class ExamCatalogUseCase:
    def __init__(self, exam_repo: IExamRepository):
        self._exam_repo = exam_repo

    def get_all(self) -> List[dict]:
        return [exam_to_dict(e) for e in self._exam_repo.get_all()]

    def get_by_code(self, exam_code: str) -> Optional[dict]:
        e = self._exam_repo.get_by_code(exam_code)
        return exam_to_dict(e) if e else None

    def create(self, dto: ExamInfoDto) -> dict:
        exam = _validate(dto)
        if not exam.exam_code:
            raise ValueError("Vui lòng nhập mã đề.")
        if self._exam_repo.get_by_code(exam.exam_code):
            raise ValueError("Mã đề này đã tồn tại.")
        new_id = self._exam_repo.create(exam)
        return exam_to_dict(self._exam_repo.get_by_id(new_id))

    def update(self, exam_id: int, dto: ExamInfoDto) -> dict:
        if not self._exam_repo.update(exam_id, _validate(dto)):
            raise LookupError("Không tìm thấy bộ đề.")
        return exam_to_dict(self._exam_repo.get_by_id(exam_id))

    def delete(self, exam_id: int) -> None:
        exam = self._exam_repo.get_by_id(exam_id)
        if exam is None:
            raise LookupError("Không tìm thấy bộ đề.")
        # Không xóa dây chuyền câu hỏi: admin phải xóa hoặc chuyển câu hỏi sang đề khác trước.
        if exam.question_count:
            raise PermissionError(f"Bộ đề còn {exam.question_count} câu hỏi, hãy xóa hoặc chuyển câu hỏi trước.")
        self._exam_repo.delete(exam_id)
