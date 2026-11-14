# -*- coding: utf-8 -*-
"""Kiem thu hop trang:
(1) Duong co so (Basis Path) ham AuthUseCase.register: V(G) = so nut quyet dinh + 1 = 5 + 1 = 6,
    goi truc tiep ham voi repository gia, moi duong mot ca kiem thu.
(2) Do phu cau lenh va nhanh cua back-end bang coverage.py khi chay toan bo kiem thu API.
Tu chay back-end o cong 8000, vi vay phai tat back-end khac truoc: python tests/kiemthu_hoptrang.py"""
import os, socket, subprocess, sys, tempfile, threading, time

T = os.path.dirname(os.path.abspath(__file__)); BE = os.path.join(T, "..", "back-end-python")
os.chdir(BE); sys.path.insert(0, os.getcwd())
import coverage
cov = coverage.Coverage(branch=True, source=["application", "domain", "infrastructure", "presentation"], concurrency=["thread"], data_file=os.path.join(tempfile.gettempdir(), ".coverage_otdgnl"))
cov.start()
import pyodbc, uvicorn
from application.dto.auth import RegisterDto
from application.use_cases.auth_use_case import AuthUseCase
from main import app


class RepoGia:
    def exists_username(self, u): return u == "datontai"
    def create(self, user): return 1


print("1. DUONG CO SO ham AuthUseCase.register   V(G) = 5 nut quyet dinh + 1 = 6 duong doc lap\n")
print(f"{'Duong':7}{'Dieu kien di qua':52}{'Mong doi':>9}{'Thuc te':>9}  Ket qua")
uc = AuthUseCase(RepoGia(), None); dat = 0
DS = [("P1", "Thieu ten dang nhap", "", "Abc@1234", 400), ("P2", "Co ten, thieu mat khau", "u1", "", 400), ("P3", "Mat khau khong co chu so", "u1", "abc@defg", 400),
      ("P4", "Co so, khong co ky tu dac biet", "u1", "abcd1234", 400), ("P5", "Mat khau manh, ten da ton tai", "datontai", "Abc@1234", 400), ("P6", "Hop le: tao tai khoan", "u1", "Abc@1234", 200)]
for ma, ten, u, p, mong in DS:
    r = uc.register(RegisterDto(Username=u, Password=p, FullName="x"))
    thuc = r.status_code if hasattr(r, "status_code") else r[0]
    ok = thuc == mong; dat += ok
    print(f"{ma:7}{ten:52}{mong:>9}{thuc:>9}  {'DAT' if ok else 'KHONG DAT'}"); time.sleep(0.4)
print(f"\nTONG HOP: {dat}/{len(DS)} duong co so dat\n")

srv = uvicorn.Server(uvicorn.Config(app, host="127.0.0.1", port=8000, log_level="critical"))


def chay_kiem_thu():
    for _ in range(40):
        try: socket.create_connection(("127.0.0.1", 8000), 1).close(); break
        except OSError: time.sleep(0.25)
    print("2. DO PHU MA NGUON bang coverage.py: chay apitest_full, apitest_extra, kiemthu_hopden, kiemthu_v8 tren back-end duoc do", flush=True)
    with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as d:
        env = dict(os.environ, PYTHONIOENCODING="utf8")
        for f in ("apitest_full.py", "apitest_extra.py", "kiemthu_hopden.py", "kiemthu_v8.py"):
            r = subprocess.run([sys.executable, os.path.join(T, f)], cwd=d, env=env, capture_output=True)
            print(f"   da chay {f}: ma thoat {r.returncode}", flush=True)
    srv.should_exit = True


threading.Thread(target=chay_kiem_thu, daemon=True).start()
srv.run()  # may chu chay o luong chinh de coverage do duoc cac ham xu ly
cov.stop(); cov.save()
print(); cov.report(show_missing=False, skip_empty=True, sort="-cover")
cn = pyodbc.connect(r"DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost\SQLEXPRESS;DATABASE=OnThiDGNL_DB;Trusted_Connection=yes;TrustServerCertificate=yes;", autocommit=True)
cn.execute("DELETE FROM Users WHERE Username='tmpuser'"); cn.execute("DELETE FROM Questions WHERE ExamCode IN ('TMP','VERIFY-TMP')"); cn.execute("DELETE FROM Exams WHERE ExamCode IN ('TMP','VERIFY-TMP','KT-TMP')"); cn.close()
