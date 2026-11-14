# -*- coding: utf-8 -*-
"""Cac test case bo sung TC32-TC39: kiem tra cac loi nghiep vu/bao mat da biet. Chay sau apitest_full.py"""
import json, urllib.request, urllib.error, datetime, sqlite3
try:
    import jwt
except ImportError:
    jwt = None
B = "http://127.0.0.1:8000/api"
def call(m, p, body=None, tok=None):
    h = {"Content-Type": "application/json"}
    if tok: h["Authorization"] = "Bearer " + tok
    r = urllib.request.Request(B + p, data=None if body is None else json.dumps(body).encode(), headers=h, method=m)
    try:
        with urllib.request.urlopen(r) as x: return x.status, x.read().decode()
    except urllib.error.HTTPError as e: return e.code, e.read().decode()
adm = json.loads(call("POST", "/auth/login", {"Username": "admin", "Password": "Admin@123"})[1])["AccessToken"]
# Tu ban V8 API cong khai khong tra dap an; can token admin de lay dap an lam du lieu kiem thu.
qs = json.loads(call("GET", "/questions", None, adm)[1])
qs_cong_khai = json.loads(call("GET", "/questions")[1])
toan = [q for q in qs if q["SubjectCategory"] == "Toán" and q["ExamCode"] == "ĐỀ-01"]
# Cau cua mot bo de khac (truoc day lay nham cau Lich su nam cung bo de tong hop DE-01)
su = [q for q in qs if q["SubjectCategory"] == "Lịch sử" and q["ExamCode"] != "ĐỀ-01"][0]
res = []
def add(id, name, req, expect_txt, actual_txt, ok, sev):
    res.append(dict(id=id, name=name, req=req, expect=expect_txt, actual=actual_txt, ok=ok, severity=sev))
# TC32
s, b = call("POST", "/exam/submit", {"answers": [{"questionId": toan[0]["Id"], "selectedAnswer": toan[0]["CorrectAnswer"]}]}); r = json.loads(b)
add("TC32", "Chỉ nộp 1/4 câu của đề (đúng câu đó)", "POST /api/exam/submit", "25% (mẫu số = 4 câu của đề)", f'{r["ScorePercentage"]}% (mẫu số = {r["TotalQuestions"]})', r["ScorePercentage"] == 25.0, "S1")
# TC33
s, b = call("POST", "/exam/submit", {"answers": [{"questionId": toan[0]["Id"], "selectedAnswer": toan[0]["CorrectAnswer"]}] * 10})
add("TC33", "Nộp trùng 10 lần cùng một câu đúng", "POST /api/exam/submit", "400 (từ chối mã câu hỏi trùng)", f'{s}: {b[:60]}', s == 400, "S2")
# TC34
s, b = call("POST", "/exam/submit", {"answers": [{"questionId": toan[0]["Id"], "selectedAnswer": toan[0]["CorrectAnswer"]}, {"questionId": su["Id"], "selectedAnswer": su["CorrectAnswer"]}]})
add("TC34", "Nộp lẫn câu thuộc hai môn/bộ đề khác nhau", "POST /api/exam/submit", "400 (câu ngoài bộ đề)", f'{s}: {b[:60]}', s == 400, "S2")
# TC35
bad = {"Content": "", "OptionA": "", "OptionB": "", "OptionC": "", "OptionD": "", "CorrectAnswer": "Z", "SubjectCategory": "", "Explanation": "", "ExamCode": "VERIFY-TMP"}
s, b = call("POST", "/questions", bad, adm)
add("TC35", "Thêm câu hỏi rỗng, đáp án đúng = “Z” (admin)", "POST /api/questions", "400/422 (dữ liệu không hợp lệ)", f"{s}: {b[:50]}", s in (400, 422), "S2")
if s == 201: call("DELETE", f"/questions/{json.loads(b)['Id']}", None, adm)
# TC36
if jwt:
    forged = jwt.encode({"sub": "hacker", "role": "Admin", "user_id": 999, "exp": datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(hours=1)}, "dev-secret-key-change-this-in-production-32chars+", algorithm="HS256")
    s, b = call("POST", "/questions", dict(bad, Content="forged", OptionA="a", OptionB="b", OptionC="c", OptionD="d", CorrectAnswer="A", SubjectCategory="Toán"), forged)
    add("TC36", "Giả mạo JWT Admin bằng khóa mặc định trong mã nguồn", "POST /api/questions", "401", str(s), s == 401, "S1")
    if s == 201: call("DELETE", f"/questions/{json.loads(b)['Id']}", None, adm)
# TC37
# Dung tai khoan tam de khong khoa admin cua cac bo kiem thu chay sau
tam = "kt_khoa_" + datetime.datetime.now().strftime("%H%M%S")
call("POST", "/auth/register", {"Username": tam, "Password": "Khoa@123", "FullName": "Kiem thu khoa"})
codes = [call("POST", "/auth/login", {"Username": tam, "Password": f"sai{i}"})[0] for i in range(30)]
s2, _ = call("POST", "/auth/login", {"Username": tam, "Password": "Khoa@123"})
add("TC37", "Đăng nhập sai 30 lần liên tiếp rồi đăng nhập đúng", "POST /api/auth/login", "bị giới hạn/khóa tạm (429 hoặc 401 kéo dài)", f"{codes.count(401)} lần 401, {codes.count(429)} lần 429; lần đúng: {s2}", s2 != 200, "S3")
# TC38
lo = any(q["CorrectAnswer"] or q["Explanation"] for q in qs_cong_khai)
add("TC38", "API công khai không được chứa đáp án trước khi nộp bài", "GET /api/questions", "không có CorrectAnswer/Explanation", "có CorrectAnswer và Explanation" if lo else "CorrectAnswer, Explanation để trống", not lo, "S2")
# TC39
import pyodbc
cn = pyodbc.connect(r"DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost\SQLEXPRESS;DATABASE=OnThiDGNL_DB;Trusted_Connection=yes;TrustServerCertificate=yes;")
pw = cn.cursor().execute("SELECT Password FROM Users WHERE Username='admin'").fetchone()[0]
add("TC39", "Mật khẩu trong bảng Users phải được băm", "Truy vấn SELECT Password FROM Users", "chuỗi băm (có salt)", pw[:14] + "…" if pw != "Admin@123" else "văn bản thuần (so khớp trực tiếp)", pw != "Admin@123", "S1")
cn.cursor().execute("DELETE FROM Users WHERE Username = ?", tam); cn.cursor().execute("DELETE FROM Exams WHERE ExamCode = 'VERIFY-TMP'"); cn.commit()
base = json.load(open("apitest_full.json", encoding="utf8"))
json.dump({"base": base, "extra": res}, open("apitest_v2.json", "w", encoding="utf8"), ensure_ascii=False, indent=1)
for r in res: print(r["id"], "ĐẠT" if r["ok"] else "KHÔNG ĐẠT", "|", r["severity"], "|", r["name"], "->", r["actual"])
