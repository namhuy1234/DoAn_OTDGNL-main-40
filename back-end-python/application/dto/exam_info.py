"""Application DTO cho thông tin bộ đề (bảng Exams)."""
from typing import Annotated, Optional

from pydantic import BaseModel, ConfigDict, Field

from application.dto.common import aliases


class ExamInfoDto(BaseModel):
    model_config = ConfigDict(populate_by_name=True)

    ExamCode: Annotated[Optional[str], Field(validation_alias=aliases("ExamCode"))] = None
    Title: Annotated[Optional[str], Field(validation_alias=aliases("Title"))] = None
    SubjectCategory: Annotated[Optional[str], Field(validation_alias=aliases("SubjectCategory"))] = None
    DurationMinutes: Annotated[Optional[int], Field(validation_alias=aliases("DurationMinutes"))] = 15
    Description: Annotated[Optional[str], Field(validation_alias=aliases("Description"))] = None


class CheckAnswerDto(BaseModel):
    """Chế độ ôn tập: kiểm tra ngay một câu."""
    model_config = ConfigDict(populate_by_name=True)

    QuestionId: Annotated[int, Field(validation_alias=aliases("QuestionId"))]
    SelectedAnswer: Annotated[Optional[str], Field(validation_alias=aliases("SelectedAnswer"))] = None
