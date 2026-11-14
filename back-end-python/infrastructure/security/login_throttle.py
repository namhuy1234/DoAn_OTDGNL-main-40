"""Infrastructure: tạm khóa đăng nhập khi sai mật khẩu nhiều lần liên tiếp (chống dò mật khẩu).

Lưu trong bộ nhớ của tiến trình (đủ cho một máy chủ); đăng nhập đúng thì xóa bộ đếm.
Cấu hình qua .env: LOGIN_MAX_FAILS (mặc định 5), LOGIN_LOCK_SECONDS (mặc định 300).
"""
import os
import threading
import time

MAX_FAILS = int(os.getenv("LOGIN_MAX_FAILS", "5"))
LOCK_SECONDS = int(os.getenv("LOGIN_LOCK_SECONDS", "300"))

_lock = threading.Lock()
_fails: dict = {}  # tên đăng nhập -> (số lần sai liên tiếp, thời điểm mở khóa)


def _key(username: str) -> str:
    return str(username or "").strip().lower()


def seconds_locked(username: str) -> int:
    with _lock:
        count, until = _fails.get(_key(username), (0, 0.0))
    return max(0, int(until - time.time() + 0.999)) if until else 0


def record_failure(username: str) -> None:
    with _lock:
        count, until = _fails.get(_key(username), (0, 0.0))
        if until and until <= time.time():
            count, until = 0, 0.0  # hết thời gian khóa thì đếm lại từ đầu
        count += 1
        if count >= MAX_FAILS:
            until = time.time() + LOCK_SECONDS
        _fails[_key(username)] = (count, until)


def record_success(username: str) -> None:
    with _lock:
        _fails.pop(_key(username), None)
