"""Domain: entity Exam (bộ đề). Câu hỏi thuộc bộ đề qua Questions.ExamCode."""
from dataclasses import dataclass


@dataclass
class Exam:
    id: int = 0
    exam_code: str = ""
    title: str = ""
    subject_category: str = ""
    duration_minutes: int = 15
    description: str = ""
    # Chỉ có khi đọc danh sách (đếm từ bảng Questions).
    question_count: int = 0
