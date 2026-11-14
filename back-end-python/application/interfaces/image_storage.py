"""Application: nơi lưu ảnh minh họa câu hỏi (cài đặt thật dùng Cloudinary)."""
from abc import ABC, abstractmethod


class IImageStorage(ABC):
    @abstractmethod
    def is_configured(self) -> bool:
        ...

    @abstractmethod
    def upload(self, data: bytes, filename: str) -> dict:
        """Trả về {'url', 'public_id', 'width', 'height', 'bytes'}."""
        ...
