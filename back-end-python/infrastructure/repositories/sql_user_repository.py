"""Infrastructure: SQL Server implementation of IUserRepository."""
from typing import List, Optional

from application.interfaces.repositories import IUserRepository
from domain.entities.user import User
from infrastructure.db.connection import get_db

_SELECT = "SELECT Id, Username, Password, Role, FullName FROM Users"


def _row_to_user(row) -> User:
    return User(
        id=int(row[0]),
        username=row[1] or "",
        password=row[2] or "",
        role=row[3] or "",
        full_name=row[4] or "",
    )


class SqlUserRepository(IUserRepository):
    def exists_username(self, username: str) -> bool:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("SELECT COUNT(*) FROM Users WHERE Username = ?", username)
            return (cur.fetchone()[0] or 0) > 0

    def create(self, user: User) -> None:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO Users (Username, Password, Role, FullName) VALUES (?, ?, ?, ?)",
                user.username,
                user.password,
                user.role,
                user.full_name,
            )

    def get_by_username(self, username: str) -> Optional[User]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(_SELECT + " WHERE Username = ?", username)
            row = cur.fetchone()
        return _row_to_user(row) if row else None

    def get_by_id(self, user_id: int) -> Optional[User]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(_SELECT + " WHERE Id = ?", user_id)
            row = cur.fetchone()
        return _row_to_user(row) if row else None

    def update_password(self, username: str, new_password: str) -> None:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(
                "UPDATE Users SET Password = ? WHERE Username = ?",
                new_password,
                username,
            )

    def get_all(self) -> List[User]:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute(_SELECT + " ORDER BY Id")
            return [_row_to_user(r) for r in cur.fetchall()]

    def update_role(self, user_id: int, role: str) -> bool:
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("UPDATE Users SET Role = ? WHERE Id = ?", role, user_id)
            return cur.rowcount > 0

    def delete(self, user_id: int) -> bool:
        # Lịch sử làm bài bị xóa theo nhờ ON DELETE CASCADE của FK_ExamResults_Users.
        with get_db() as conn:
            cur = conn.cursor()
            cur.execute("DELETE FROM Users WHERE Id = ?", user_id)
            return cur.rowcount > 0
