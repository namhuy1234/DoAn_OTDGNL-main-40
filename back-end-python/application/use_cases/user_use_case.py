"""Application use case cho quản lý người dùng (chỉ admin)."""
from typing import List

from application.interfaces.repositories import IExamResultRepository, IUserRepository

ROLES = ("Admin", "Student")


class UserUseCase:
    def __init__(self, user_repo: IUserRepository, result_repo: IExamResultRepository):
        self._user_repo = user_repo
        self._result_repo = result_repo

    def get_all(self) -> List[dict]:
        attempts = {}
        for a in self._result_repo.get_all():
            attempts.setdefault(a.user_id, []).append(a)
        rows = []
        for u in self._user_repo.get_all():
            mine = attempts.get(u.id, [])
            rows.append({
                # Không bao giờ trả cột mật khẩu ra ngoài API.
                "Id": u.id,
                "Username": u.username,
                "FullName": u.full_name,
                "Role": u.role,
                "Attempts": len(mine),
                "AverageScore": round(sum(a.score_percentage for a in mine) / len(mine), 2) if mine else None,
                "LastSubmittedAt": mine[0].submitted_at.isoformat() if mine and mine[0].submitted_at else None,
            })
        return rows

    def change_role(self, user_id: int, role: str, current_user_id: int) -> None:
        role = next((r for r in ROLES if r.lower() == str(role or "").strip().lower()), None)
        if role is None:
            raise ValueError("Vai trò chỉ được là Admin hoặc Student.")
        if int(user_id) == int(current_user_id):
            raise PermissionError("Không thể tự đổi vai trò của chính mình.")
        if not self._user_repo.update_role(user_id, role):
            raise LookupError("Không tìm thấy người dùng.")

    def delete(self, user_id: int, current_user_id: int) -> None:
        if int(user_id) == int(current_user_id):
            raise PermissionError("Không thể tự xóa tài khoản đang đăng nhập.")
        if not self._user_repo.delete(user_id):
            raise LookupError("Không tìm thấy người dùng.")
