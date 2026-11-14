"""Application: băm và kiểm tra mật khẩu."""
from abc import ABC, abstractmethod


class IPasswordHasher(ABC):
    @abstractmethod
    def hash(self, password: str) -> str:
        ...

    @abstractmethod
    def verify(self, password: str, stored: str) -> bool:
        ...

    @abstractmethod
    def is_hashed(self, stored: str) -> bool:
        ...
