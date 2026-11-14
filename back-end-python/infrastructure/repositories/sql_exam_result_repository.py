"""Infrastructure: SQL Server implementation of IExamResultRepository (bảng ExamResults)."""
from typing import List, Optional

from application.interfaces.repositories import IExamResultRepository
from domain.entities.exam_result import ExamAttempt
from infrastructure.db.connection import get_db

_COLUMNS = (
    "r.Id, r.UserId, r.ExamCode, r.SubjectCategory, r.TotalQuestions, r.CorrectCount, "
    "r.BlankCount, r.ScorePercentage, r.DurationSeconds, r.SubmittedAt, u.Username, u.FullName"
)
_FROM = " FROM ExamResults r JOIN Users u ON u.Id = r.UserId"


def _row_to_attempt(row) -> ExamAttempt:
    return ExamAttempt(
        id=int(row[0]),
        user_id=int(row[1]),
        exam_code=row[2] or "",
        subject_category=row[3] or "",
        total_questions=int(row[4]),
        correct_count=int(row[5]),
        blank_count=int(row[6] or 0),
        score_percentage=float(row[7]),
        duration_seconds=row[8],
        submitted_at=row[9],
        username=row[10] or "",
        full_name=row[11] or "",
    )


class SqlExamResultRepository(IExamResultRepository):
    def create(self, attempt: ExamAttempt, answers: Optional[List[tuple]] = None) -> int:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO ExamResults (UserId, ExamCode, SubjectCategory, TotalQuestions, CorrectCount, "
                "BlankCount, ScorePercentage, DurationSeconds) OUTPUT INSERTED.Id VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                attempt.user_id,
                attempt.exam_code,
                attempt.subject_category,
                attempt.total_questions,
                attempt.correct_count,
                attempt.blank_count,
                attempt.score_percentage,
                attempt.duration_seconds,
            )
            result_id = int(cur.fetchone()[0])
            # Lượt làm và bài làm chi tiết ghi trong cùng một giao dịch.
            if answers:
                cur.executemany(
                    "INSERT INTO ExamResultAnswers (ResultId, QuestionId, SelectedAnswer, IsCorrect) VALUES (?, ?, ?, ?)",
                    [(result_id, qid, sel or "", 1 if ok else 0) for qid, sel, ok in answers],
                )
            return result_id

    def get_by_user(self, user_id: int) -> List[ExamAttempt]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("SELECT " + _COLUMNS + _FROM + " WHERE r.UserId = ? ORDER BY r.SubmittedAt DESC, r.Id DESC", user_id)
            return [_row_to_attempt(r) for r in cur.fetchall()]

    def get_best_per_exam(self, subject: Optional[str] = None, limit: int = 10) -> List[ExamAttempt]:
        # Mỗi học sinh chỉ lấy lượt điểm cao nhất của mỗi bộ đề; bằng điểm thì ai nộp trước xếp trên.
        sql = (
            "WITH x AS (SELECT " + _COLUMNS + ", ROW_NUMBER() OVER (PARTITION BY r.UserId, r.ExamCode "
            "ORDER BY r.ScorePercentage DESC, r.SubmittedAt) AS rn" + _FROM +
            " WHERE (? IS NULL OR r.SubjectCategory = ?)) "
            "SELECT TOP (?) Id, UserId, ExamCode, SubjectCategory, TotalQuestions, CorrectCount, BlankCount, "
            "ScorePercentage, DurationSeconds, SubmittedAt, Username, FullName FROM x WHERE rn = 1 "
            "ORDER BY ScorePercentage DESC, SubmittedAt"
        )
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(sql, subject, subject, int(limit))
            return [_row_to_attempt(r) for r in cur.fetchall()]

    def get_all(self) -> List[ExamAttempt]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("SELECT " + _COLUMNS + _FROM + " ORDER BY r.SubmittedAt DESC, r.Id DESC")
            return [_row_to_attempt(r) for r in cur.fetchall()]

    def get_by_id(self, result_id: int) -> Optional[ExamAttempt]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("SELECT " + _COLUMNS + _FROM + " WHERE r.Id = ?", result_id)
            row = cur.fetchone()
        return _row_to_attempt(row) if row else None

    def get_answers(self, result_id: int) -> List[tuple]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("SELECT QuestionId, SelectedAnswer, IsCorrect FROM ExamResultAnswers WHERE ResultId = ? ORDER BY Id", result_id)
            return [(int(r[0]), r[1] or "", bool(r[2])) for r in cur.fetchall()]
