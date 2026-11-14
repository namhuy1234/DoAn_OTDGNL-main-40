"""Application use case cho chấm bài thi, lịch sử làm bài và thống kê."""
from collections import OrderedDict
from dataclasses import dataclass
from typing import List, Optional

from application.dto.exam import ExamSubmissionDto
from application.interfaces.repositories import IExamResultRepository, IQuestionRepository
from domain.entities.exam_result import ExamAttempt


@dataclass
class ExamResult:
    total_questions: int
    correct_count: int
    score_percentage: float
    details: List[dict]
    blank_count: int = 0
    exam_code: str = ""
    subject_category: str = ""
    result_id: Optional[int] = None


def attempt_to_dict(a: ExamAttempt) -> dict:
    return {
        "Id": a.id,
        "ExamCode": a.exam_code,
        "SubjectCategory": a.subject_category,
        "TotalQuestions": a.total_questions,
        "CorrectCount": a.correct_count,
        "BlankCount": a.blank_count,
        "WrongCount": a.total_questions - a.correct_count - a.blank_count,
        "ScorePercentage": a.score_percentage,
        "DurationSeconds": a.duration_seconds,
        "SubmittedAt": a.submitted_at.isoformat() if a.submitted_at else None,
    }


def _summary(attempts: List[ExamAttempt]) -> dict:
    if not attempts:
        return {"Attempts": 0, "AverageScore": 0, "BestScore": 0, "ExamsDone": 0}
    scores = [a.score_percentage for a in attempts]
    return {
        "Attempts": len(attempts),
        "AverageScore": round(sum(scores) / len(scores), 2),
        "BestScore": max(scores),
        "ExamsDone": len({a.exam_code for a in attempts}),
    }


class ExamUseCase:
    def __init__(self, question_repo: IQuestionRepository, result_repo: Optional[IExamResultRepository] = None):
        self._question_repo = question_repo
        self._result_repo = result_repo

    def submit(self, submission: ExamSubmissionDto, user_id: Optional[int] = None) -> ExamResult:
        answers = OrderedDict()
        for a in submission.Answers or []:
            if int(a.QuestionId) in answers:
                raise ValueError("Bài làm có câu hỏi bị gửi trùng.")
            answers[int(a.QuestionId)] = a.SelectedAnswer
        if not answers:
            raise ValueError("Bài làm không có dữ liệu trả lời.")

        questions = {q.id: q for q in self._question_repo.get_by_ids(list(answers))}
        if not questions:
            raise ValueError("Không tìm thấy câu hỏi nào trong bài làm.")
        # Mọi câu phải thuộc cùng một bộ đề (và đúng bộ đề đã khai báo nếu có).
        codes = {(q.exam_code or "").strip() for q in questions.values()}
        exam_code = (submission.ExamCode or "").strip()
        if len(codes) > 1 or (exam_code and codes != {exam_code} and {c.lower() for c in codes} != {exam_code.lower()}):
            raise ValueError("Bài làm chứa câu hỏi không thuộc bộ đề đang làm.")
        exam_code = codes.pop()

        correct_count = 0
        blank_count = 0
        details: List[dict] = []
        for question_id, selected in answers.items():
            question = questions.get(question_id)
            if question is None:
                continue  # mã câu hỏi không tồn tại thì không tính vào bài
            selected = str(selected or "").strip()
            is_correct = bool(selected) and str(question.correct_answer or "").strip().lower() == selected.lower()
            if is_correct:
                correct_count += 1
            if not selected:
                blank_count += 1

            details.append(
                {
                    "questionId": question.id,
                    "content": question.content,
                    "imageUrl": question.image_url,
                    "selectedAnswer": selected,
                    "correctAnswer": question.correct_answer,
                    "isCorrect": is_correct,
                    "explanation": question.explanation,
                }
            )

        # Mẫu số là số câu của cả bộ đề (đề tổng hợp làm theo môn thì là số câu của môn đó trong đề):
        # nộp thiếu câu thì các câu không gửi được tính là bỏ trống.
        subjects = {(q.subject_category or "").strip() for q in questions.values()}
        subject = subjects.pop() if len(subjects) == 1 else ""
        total = len(details)
        if exam_code:
            total = max(total, self._question_repo.count_by_exam_code(exam_code, subject or None))
            blank_count += total - len(details)
        score = round((correct_count / total) * 100, 2)

        result_id = None
        if user_id and self._result_repo is not None:
            duration = submission.DurationSeconds
            result_id = self._result_repo.create(
                ExamAttempt(
                    user_id=int(user_id),
                    exam_code=exam_code,
                    subject_category=subject,
                    total_questions=total,
                    correct_count=correct_count,
                    blank_count=blank_count,
                    score_percentage=score,
                    duration_seconds=int(duration) if duration and duration > 0 else None,
                ),
                [(d["questionId"], d["selectedAnswer"], d["isCorrect"]) for d in details],
            )

        return ExamResult(
            total_questions=total,
            correct_count=correct_count,
            score_percentage=score,
            details=details,
            blank_count=blank_count,
            exam_code=exam_code,
            subject_category=subject,
            result_id=result_id,
        )

    def history(self, user_id: int) -> List[dict]:
        return [attempt_to_dict(a) for a in self._result_repo.get_by_user(user_id)]

    def statistics(self, user_id: int) -> dict:
        attempts = self._result_repo.get_by_user(user_id)
        by_subject = {}
        for a in attempts:
            by_subject.setdefault(a.subject_category or "Khác", []).append(a)
        subjects = [dict(Subject=s, **_summary(lst)) for s, lst in sorted(by_subject.items())]
        # 20 lượt gần nhất theo thứ tự thời gian để vẽ biểu đồ tiến bộ.
        recent = [
            {"ExamCode": a.exam_code, "ScorePercentage": a.score_percentage,
             "SubmittedAt": a.submitted_at.isoformat() if a.submitted_at else None}
            for a in reversed(attempts[:20])
        ]
        return {"Summary": _summary(attempts), "BySubject": subjects, "Recent": recent}

    def leaderboard(self, subject: Optional[str] = None, limit: int = 10) -> List[dict]:
        rows = self._result_repo.get_best_per_exam(subject or None, max(1, min(int(limit), 50)))
        return [
            dict(attempt_to_dict(a), Username=a.username, Name=a.full_name or a.username)
            for a in rows
        ]

    def overview(self) -> dict:
        attempts = self._result_repo.get_all()
        by_subject = {}
        for a in attempts:
            by_subject.setdefault(a.subject_category or "Khác", []).append(a)
        return {
            "Summary": dict(_summary(attempts), Students=len({a.user_id for a in attempts})),
            "BySubject": [dict(Subject=s, **_summary(lst)) for s, lst in sorted(by_subject.items())],
            "Recent": [dict(attempt_to_dict(a), Username=a.username, Name=a.full_name or a.username) for a in attempts[:10]],
        }

    def check_answer(self, question_id: int, selected: Optional[str]) -> dict:
        """Chế độ ôn tập: chấm ngay một câu, trả đáp án đúng và lời giải."""
        found = self._question_repo.get_by_ids([int(question_id)])
        if not found:
            raise LookupError("Không tìm thấy câu hỏi.")
        q = found[0]
        selected = str(selected or "").strip()
        return {
            "QuestionId": q.id,
            "SelectedAnswer": selected,
            "CorrectAnswer": q.correct_answer,
            "IsCorrect": bool(selected) and selected.lower() == str(q.correct_answer or "").strip().lower(),
            "Explanation": q.explanation,
        }

    def review(self, result_id: int, user_id: int, admin: bool = False) -> dict:
        """Xem lại một lượt làm: chỉ chủ bài làm hoặc admin được xem."""
        attempt = self._result_repo.get_by_id(result_id)
        if attempt is None or (attempt.user_id != int(user_id) and not admin):
            raise LookupError("Không tìm thấy lượt làm bài.")
        answers = self._result_repo.get_answers(result_id)
        questions = {q.id: q for q in self._question_repo.get_by_ids([a[0] for a in answers])}
        details = []
        for qid, selected, ok in answers:
            q = questions.get(qid)
            details.append({
                "questionId": qid,
                "content": q.content if q else "(Câu hỏi đã bị xóa khỏi ngân hàng đề)",
                "imageUrl": q.image_url if q else "",
                "options": {k: getattr(q, "option_" + k.lower()) for k in "ABCD"} if q else {},
                "selectedAnswer": selected,
                "correctAnswer": q.correct_answer if q else "",
                "isCorrect": ok,
                "explanation": q.explanation if q else "",
            })
        return dict(attempt_to_dict(attempt), Name=attempt.full_name or attempt.username, Details=details)
