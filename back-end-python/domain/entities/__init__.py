"""Domain entities."""
from domain.entities.exam import Exam
from domain.entities.exam_result import ExamAttempt
from domain.entities.question import Question
from domain.entities.user import User

__all__ = ["Exam", "ExamAttempt", "Question", "User"]
