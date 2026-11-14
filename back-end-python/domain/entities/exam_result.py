"""Domain: một lượt làm bài đã nộp (lưu vào bảng ExamResults)."""
from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class ExamAttempt:
    id: int = 0
    user_id: int = 0
    exam_code: str = ""
    subject_category: str = ""
    total_questions: int = 0
    correct_count: int = 0
    blank_count: int = 0
    score_percentage: float = 0.0
    duration_seconds: Optional[int] = None
    submitted_at: Optional[datetime] = None
    # Chỉ có khi đọc kèm bảng Users (bảng thành tích, trang quản lý).
    username: str = ""
    full_name: str = ""
