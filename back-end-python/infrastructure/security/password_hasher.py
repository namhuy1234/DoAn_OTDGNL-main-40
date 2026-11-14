"""Infrastructure: băm mật khẩu bằng PBKDF2-HMAC-SHA256 (thư viện chuẩn hashlib).

Định dạng lưu trong cột Users.Password: pbkdf2_sha256$<số vòng>$<salt hex>$<hash hex>.
Tài khoản cũ còn lưu mật khẩu thô vẫn đăng nhập được và được băm lại ngay lần đăng nhập đó.
"""
import hashlib
import hmac
import secrets

from application.interfaces.password_hasher import IPasswordHasher

_PREFIX = "pbkdf2_sha256"
_ITERATIONS = 200_000


class Pbkdf2PasswordHasher(IPasswordHasher):
    def hash(self, password: str) -> str:
        salt = secrets.token_hex(16)
        digest = hashlib.pbkdf2_hmac("sha256", password.encode("utf-8"), bytes.fromhex(salt), _ITERATIONS)
        return f"{_PREFIX}${_ITERATIONS}${salt}${digest.hex()}"

    def is_hashed(self, stored: str) -> bool:
        return str(stored or "").startswith(_PREFIX + "$")

    def verify(self, password: str, stored: str) -> bool:
        stored = str(stored or "")
        if not self.is_hashed(stored):
            # Dữ liệu cũ (trước bản V8) lưu mật khẩu thô.
            return hmac.compare_digest(stored.encode("utf-8"), str(password or "").encode("utf-8"))
        try:
            _, iterations, salt, expected = stored.split("$")
            digest = hashlib.pbkdf2_hmac("sha256", str(password or "").encode("utf-8"), bytes.fromhex(salt), int(iterations))
        except ValueError:
            return False
        return hmac.compare_digest(digest.hex(), expected)
