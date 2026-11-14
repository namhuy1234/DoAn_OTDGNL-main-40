"""Application: repository interfaces (Dependency Inversion)."""
from abc import ABC, abstractmethod
from typing import List, Optional

from domain.entities.exam import Exam
from domain.entities.exam_result import ExamAttempt
from domain.entities.question import Question
from domain.entities.user import User


class IUserRepository(ABC):
    @abstractmethod
    def exists_username(self, username: str) -> bool:
        ...

    @abstractmethod
    def create(self, user: User) -> None:
        ...

    @abstractmethod
    def get_by_username(self, username: str) -> Optional[User]:
        ...

    @abstractmethod
    def get_by_id(self, user_id: int) -> Optional[User]:
        ...

    @abstractmethod
    def update_password(self, username: str, new_password: str) -> None:
        ...

    @abstractmethod
    def get_all(self) -> List[User]:
        ...

    @abstractmethod
    def update_role(self, user_id: int, role: str) -> bool:
        ...

    @abstractmethod
    def delete(self, user_id: int) -> bool:
        ...


class IQuestionRepository(ABC):
    @abstractmethod
    def get_all(self) -> List[Question]:
        ...

    @abstractmethod
    def create(self, question: Question) -> int:
        ...

    @abstractmethod
    def update(self, question_id: int, question: Question) -> bool:
        ...

    @abstractmethod
    def delete(self, question_id: int) -> bool:
        ...

    @abstractmethod
    def get_by_ids(self, ids: List[int]) -> List[Question]:
        ...

    @abstractmethod
    def count_by_exam_code(self, exam_code: str, subject: Optional[str] = None) -> int:
        ...


class IExamResultRepository(ABC):
    @abstractmethod
    def create(self, attempt: ExamAttempt, answers: Optional[List[tuple]] = None) -> int:
        """answers: danh sách (question_id, selected_answer, is_correct) của bài làm."""
        ...

    @abstractmethod
    def get_by_id(self, result_id: int) -> Optional[ExamAttempt]:
        ...

    @abstractmethod
    def get_answers(self, result_id: int) -> List[tuple]:
        ...

    @abstractmethod
    def get_by_user(self, user_id: int) -> List[ExamAttempt]:
        ...

    @abstractmethod
    def get_best_per_exam(self, subject: Optional[str] = None, limit: int = 10) -> List[ExamAttempt]:
        ...

    @abstractmethod
    def get_all(self) -> List[ExamAttempt]:
        ...


class IExamRepository(ABC):
    @abstractmethod
    def get_all(self) -> List[Exam]:
        ...

    @abstractmethod
    def get_by_code(self, exam_code: str) -> Optional[Exam]:
        ...

    @abstractmethod
    def get_by_id(self, exam_id: int) -> Optional[Exam]:
        ...

    @abstractmethod
    def create(self, exam: Exam) -> int:
        ...

    @abstractmethod
    def update(self, exam_id: int, exam: Exam) -> bool:
        ...

    @abstractmethod
    def delete(self, exam_id: int) -> bool:
        ...

    @abstractmethod
    def ensure(self, exam_code: str, subject: str) -> None:
        ...
