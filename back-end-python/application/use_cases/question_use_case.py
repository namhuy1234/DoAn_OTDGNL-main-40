"""Application use case cho question."""
from typing import List

from application.dto.question import QuestionDto
from typing import Optional

from application.interfaces.repositories import IExamRepository, IQuestionRepository
from domain.entities.question import Question


def _to_domain(dto: QuestionDto) -> Question:
    return Question(
        id=dto.Id,
        content=dto.Content,
        option_a=dto.OptionA,
        option_b=dto.OptionB,
        option_c=dto.OptionC,
        option_d=dto.OptionD,
        correct_answer=dto.CorrectAnswer,
        subject_category=dto.SubjectCategory,
        explanation=dto.Explanation,
        exam_code=dto.ExamCode,
        image_url=(dto.ImageUrl or "").strip(),
    )


def _to_dto(entity: Question, with_answer: bool = True) -> QuestionDto:
    return QuestionDto(
        Id=entity.id,
        Content=entity.content,
        OptionA=entity.option_a,
        OptionB=entity.option_b,
        OptionC=entity.option_c,
        OptionD=entity.option_d,
        # Học sinh chỉ thấy đáp án và lời giải sau khi nộp bài (trong kết quả chấm).
        CorrectAnswer=entity.correct_answer if with_answer else "",
        SubjectCategory=entity.subject_category,
        Explanation=entity.explanation if with_answer else "",
        ExamCode=entity.exam_code,
        ImageUrl=entity.image_url,
    )


class QuestionUseCase:
    def __init__(self, question_repo: IQuestionRepository, exam_repo: Optional[IExamRepository] = None):
        self._question_repo = question_repo
        self._exam_repo = exam_repo

    def _ensure_exam(self, dto: QuestionDto) -> None:
        if self._exam_repo is not None:
            self._exam_repo.ensure(dto.ExamCode, dto.SubjectCategory)

    def get_all(self, with_answer: bool = True) -> List[QuestionDto]:
        return [_to_dto(q, with_answer) for q in self._question_repo.get_all()]

    @staticmethod
    def validate(dto: QuestionDto) -> None:
        if not (dto.Content or "").strip():
            raise ValueError("Nội dung câu hỏi không được để trống.")
        if not all((getattr(dto, "Option" + k) or "").strip() for k in "ABCD"):
            raise ValueError("Phải nhập đủ 4 phương án A, B, C, D.")
        dto.CorrectAnswer = (dto.CorrectAnswer or "").strip().upper()
        if dto.CorrectAnswer not in ("A", "B", "C", "D"):
            raise ValueError("Đáp án đúng chỉ được là A, B, C hoặc D.")
        if not (dto.SubjectCategory or "").strip():
            raise ValueError("Vui lòng chọn môn học.")
        url = (dto.ImageUrl or "").strip()
        if url and not url.lower().startswith("https://"):
            raise ValueError("Đường dẫn ảnh phải bắt đầu bằng https://")

    def create(self, dto: QuestionDto) -> QuestionDto:
        self.validate(dto)
        new_id = self._question_repo.create(_to_domain(dto))
        dto.Id = new_id
        self._ensure_exam(dto)
        return dto

    def update(self, question_id: int, dto: QuestionDto) -> QuestionDto:
        self.validate(dto)
        ok = self._question_repo.update(question_id, _to_domain(dto))
        if not ok:
            raise ValueError("Không tìm thấy câu hỏi để cập nhật.")
        dto.Id = question_id
        self._ensure_exam(dto)
        return dto

    def delete(self, question_id: int) -> None:
        ok = self._question_repo.delete(question_id)
        if not ok:
            raise ValueError("Không tìm thấy câu hỏi để xóa.")
