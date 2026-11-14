"""Application use case cho auth."""
import re
from dataclasses import dataclass
from typing import Optional

from application.dto.auth import ChangePasswordDto, LoginDto, RegisterDto
from application.interfaces.password_hasher import IPasswordHasher
from application.interfaces.repositories import IUserRepository
from application.interfaces.token_service import ITokenService
from domain.entities.user import User


_SPECIAL_CHAR_RE = re.compile(r"[!@#$%^&*(),.?:{}|<>\-_+=~`\[\]\\/]")


@dataclass
class RegisterResult:
    status_code: int
    message: str


@dataclass
class LoginResult:
    status_code: int
    message: str
    payload: Optional[dict] = None


def is_strong_password(password: str) -> bool:
    return bool(re.search(r"[0-9]", password)) and bool(_SPECIAL_CHAR_RE.search(password))


class AuthUseCase:
    def __init__(
        self,
        user_repo: IUserRepository,
        token_service: Optional[ITokenService] = None,
        hasher: Optional[IPasswordHasher] = None,
    ):
        self._user_repo = user_repo
        # Token service có thể None khi test, nhưng production luôn truyền vào.
        self._token_service = token_service
        if hasher is None:
            from infrastructure.security.password_hasher import Pbkdf2PasswordHasher

            hasher = Pbkdf2PasswordHasher()
        self._hasher = hasher

    def _check_credentials(self, username: str, password: str) -> Optional[User]:
        user = self._user_repo.get_by_username(username)
        if user is None or not self._hasher.verify(password, user.password):
            return None
        # Tài khoản cũ còn lưu mật khẩu thô: băm lại ngay khi đăng nhập đúng.
        if not self._hasher.is_hashed(user.password):
            self._user_repo.update_password(user.username, self._hasher.hash(password))
        return user

    def register(self, dto: RegisterDto) -> RegisterResult:
        if not dto.Username or not dto.Password:
            return RegisterResult(400, "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.")

        if not is_strong_password(dto.Password):
            return RegisterResult(
                400,
                "Mật khẩu bảo mật yếu: Phải chứa ít nhất một chữ số và một ký tự đặc biệt!",
            )

        if self._user_repo.exists_username(dto.Username):
            return RegisterResult(400, "Tên đăng nhập này đã có người đăng ký. Vui lòng chọn tên khác!")

        user = User(
            username=dto.Username,
            password=self._hasher.hash(dto.Password),
            role="Student",
            full_name=dto.FullName or "",
        )
        self._user_repo.create(user)
        return RegisterResult(200, "Đăng ký tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.")

    def login(self, dto: LoginDto) -> LoginResult:
        if not dto.Username or not dto.Password:
            return LoginResult(400, "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.")

        user = self._check_credentials(dto.Username, dto.Password)
        if user is None:
            return LoginResult(401, "Tài khoản hoặc mật khẩu không chính xác.")

        # Tạo JWT token để client dùng cho các API cần quyền (ví dụ admin thêm đề, lưu lịch sử làm bài).
        access_token = None
        if self._token_service is not None:
            access_token = self._token_service.create_access_token(user)

        payload = {
            "Message": "Đăng nhập thành công!",
            "UserId": user.id,
            "Username": user.username,
            "FullName": user.full_name,
            "Role": user.role,
            "AccessToken": access_token,
        }
        return LoginResult(200, "Đăng nhập thành công!", payload)

    def change_password(self, dto: ChangePasswordDto) -> RegisterResult:
        if not dto.Username or not dto.OldPassword or not dto.NewPassword:
            return RegisterResult(400, "Vui lòng nhập đầy đủ thông tin đổi mật khẩu.")

        user = self._check_credentials(dto.Username, dto.OldPassword)
        if user is None:
            return RegisterResult(401, "Tài khoản hoặc mật khẩu cũ không chính xác.")

        if not is_strong_password(dto.NewPassword):
            return RegisterResult(
                400,
                "Mật khẩu mới bảo mật yếu: Phải chứa ít nhất một chữ số và một ký tự đặc biệt!",
            )

        self._user_repo.update_password(user.username, self._hasher.hash(dto.NewPassword))
        return RegisterResult(200, "Đổi mật khẩu thành công!")
