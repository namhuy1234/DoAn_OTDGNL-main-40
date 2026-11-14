# Bo kiem thu API (Nhom 40)

Chay khi back-end dang chay o http://127.0.0.1:8000 va co CSDL OnThiDGNL_DB (tep database/OnThiDGNL_DB.sql).

    python tests/apitest_full.py     # 31 test case chuc nang (TC01-TC31) + do thoi gian phan hoi (50 lan/API)
    python tests/apitest_extra.py    # 8 test case bo sung kiem tra loi da biet (TC32-TC39)

Ket qua lan chay ngay 26/10/2026 (Windows 11, Python 3.13, SQL Server Express 2022):
- TC01-TC31: 31/31 dat. TC32-TC39: 0/8 dat (cac loi nghiep vu/bao mat da biet, xem bao cao muc 4.5.6 va 4.8.3).
- Ket qua dang JSON: apitest_full.result.json, apitest_v2.result.json, perf.result.json.
- Cac script tao du lieu tam (tai khoan tmpuser, cau hoi TMP) va can xoa bang SQL sau khi chay:
  DELETE FROM Users WHERE Username='tmpuser'; DELETE FROM Questions WHERE ExamCode IN ('TMP','VERIFY-TMP');
- apitest_full.py can quyen ghi thu muc hien tai (xuat file JSON). apitest_extra.py can thu vien PyJWT va pyodbc.
