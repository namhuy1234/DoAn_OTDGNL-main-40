"""Infrastructure: SQL Server implementation of IExamRepository (bảng Exams)."""
import math
from typing import List, Optional

from application.interfaces.repositories import IExamRepository
from domain.entities.exam import Exam
from infrastructure.db.connection import get_db

_SELECT = (
    "SELECT e.Id, e.ExamCode, e.Title, e.SubjectCategory, e.DurationMinutes, e.Description, "
    "(SELECT COUNT(*) FROM Questions q WHERE LTRIM(RTRIM(q.ExamCode)) = e.ExamCode) AS QuestionCount "
    "FROM Exams e"
)


def _row_to_exam(row) -> Exam:
    return Exam(
        id=int(row[0]),
        exam_code=row[1] or "",
        title=row[2] or "",
        subject_category=row[3] or "",
        duration_minutes=int(row[4]),
        description=row[5] or "",
        question_count=int(row[6] or 0),
    )


class SqlExamRepository(IExamRepository):
    def get_all(self) -> List[Exam]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(_SELECT + " ORDER BY e.SubjectCategory, e.ExamCode")
            return [_row_to_exam(r) for r in cur.fetchall()]

    def get_by_code(self, exam_code: str) -> Optional[Exam]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(_SELECT + " WHERE e.ExamCode = ?", exam_code.strip())
            row = cur.fetchone()
        return _row_to_exam(row) if row else None

    def get_by_id(self, exam_id: int) -> Optional[Exam]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(_SELECT + " WHERE e.Id = ?", exam_id)
            row = cur.fetchone()
        return _row_to_exam(row) if row else None

    def create(self, exam: Exam) -> int:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO Exams (ExamCode, Title, SubjectCategory, DurationMinutes, Description) "
                "OUTPUT INSERTED.Id VALUES (?, ?, ?, ?, ?)",
                exam.exam_code, exam.title, exam.subject_category, exam.duration_minutes, exam.description,
            )
            return int(cur.fetchone()[0])

    def update(self, exam_id: int, exam: Exam) -> bool:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(
                "UPDATE Exams SET Title=?, SubjectCategory=?, DurationMinutes=?, Description=? WHERE Id=?",
                exam.title, exam.subject_category, exam.duration_minutes, exam.description, exam_id,
            )
            return cur.rowcount > 0

    def delete(self, exam_id: int) -> bool:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("DELETE FROM Exams WHERE Id = ?", exam_id)
            return cur.rowcount > 0

    def ensure(self, exam_code: str, subject: str) -> None:
        # Thêm câu hỏi với mã đề mới thì tự tạo bộ đề, thời gian mặc định 1,25 phút/câu.
        code = (exam_code or "").strip()
        if not code:
            return
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("SELECT COUNT(*) FROM Exams WHERE ExamCode = ?", code)
            if cur.fetchone()[0]:
                return
            cur.execute("SELECT COUNT(*) FROM Questions WHERE LTRIM(RTRIM(ExamCode)) = ?", code)
            minutes = max(5, math.ceil(int(cur.fetchone()[0] or 0) * 1.25))
            cur.execute(
                "INSERT INTO Exams (ExamCode, Title, SubjectCategory, DurationMinutes) VALUES (?, ?, ?, ?)",
                code, code, subject or "", minutes,
            )
