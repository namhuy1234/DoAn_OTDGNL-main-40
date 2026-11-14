"""Chạy một lần sau khi nâng cấp V8: băm mọi mật khẩu còn lưu dạng thô trong bảng Users.

Chạy: python bam_mat_khau_cu.py  (trong thư mục back-end-python). Chạy lại nhiều lần vẫn an toàn.
Mật khẩu đăng nhập của từng tài khoản không đổi, chỉ cách lưu trong CSDL thay đổi.
"""
from dotenv import load_dotenv

load_dotenv()

from infrastructure.repositories.sql_user_repository import SqlUserRepository
from infrastructure.security.password_hasher import Pbkdf2PasswordHasher


def main() -> None:
    repo, hasher = SqlUserRepository(), Pbkdf2PasswordHasher()
    done = 0
    for user in repo.get_all():
        if user.password and not hasher.is_hashed(user.password):
            repo.update_password(user.username, hasher.hash(user.password))
            done += 1
    print(f"Đã băm {done} mật khẩu còn lưu dạng thô.")


if __name__ == "__main__":
    main()
