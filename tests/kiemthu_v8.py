# -*- coding: utf-8 -*-
"""Kiem thu hop den cac chuc nang bo sung ban V8 (theo de cuong): lich su va thong ke hoc tap, bang thanh tich tu CSDL,
quan ly nguoi dung, quan ly bo de, che do on tap, xem lai bai lam, anh cau hoi tren Cloudinary, bao mat (an dap an,
bam mat khau, tam khoa dang nhap). Can back-end chay o cong 8000: python tests/kiemthu_v8.py
Du lieu tam (tai khoan kt8_*, bo de KT8-*) duoc xoa o cuoi."""
import json, os, struct, sys, time, urllib.error, urllib.request, zlib
import pyodbc

sys.stdout.reconfigure(encoding="utf8")
B = "http://127.0.0.1:8000/api"
CS = r"DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost\SQLEXPRESS;DATABASE=OnThiDGNL_DB;Trusted_Connection=yes;TrustServerCertificate=yes;"
TAG = str(int(time.time()))[-6:]
kq = []


def call(m, path, body=None, tok=None, raw=None, ctype="application/json"):
    h = {"Content-Type": ctype}
    if tok: h["Authorization"] = "Bearer " + tok
    data = raw if raw is not None else (None if body is None else json.dumps(body).encode())
    r = urllib.request.Request(B + path, data=data, headers=h, method=m)
    try:
        with urllib.request.urlopen(r) as x: return x.status, x.read().decode()
    except urllib.error.HTTPError as e: return e.code, e.read().decode()


def ca(ma, ten, mong, thuc):
    ok = str(mong) == str(thuc)
    kq.append((ma[:2], ok))
    print(f"{ma:6}{ten:64}{str(mong):>10}{str(thuc):>10}  {'DAT' if ok else 'KHONG DAT'}")


def nhom(t):
    print(); print(t); print(f"{'Ma':6}{'Dau vao':64}{'Mong doi':>10}{'Thuc te':>10}  Ket qua")


J = lambda r: json.loads(r[1])
tk = lambda u, p: J(call("POST", "/auth/login", {"Username": u, "Password": p}))["AccessToken"]
adm = tk("admin", "Admin@123")
call("POST", "/auth/register", {"Username": f"kt8_{TAG}", "Password": "Kt8@2026", "FullName": "Kiem thu V8"})
hs = tk(f"kt8_{TAG}", "Kt8@2026")
de = [q for q in J(call("GET", "/questions", tok=adm)) if q["ExamCode"] == "SINH10-GK1-MD01"]
toan01 = [q for q in J(call("GET", "/questions", tok=adm)) if q["ExamCode"] == "ĐỀ-01" and q["SubjectCategory"] == "Toán"]
khac = [q for q in J(call("GET", "/questions", tok=adm)) if q["ExamCode"] == "LICHSU-DE01"][0]
tl = lambda q, ok=True: {"questionId": q["Id"], "selectedAnswer": q["CorrectAnswer"] if ok else ("A" if q["CorrectAnswer"] != "A" else "B")}

nhom("1. BAO MAT DU LIEU")
ca("BM01", "GET /questions khong token: khong lo dap an, loi giai", "an", "an" if not any(q["CorrectAnswer"] or q["Explanation"] for q in J(call("GET", "/questions"))) else "lo")
ca("BM02", "GET /questions token hoc sinh: van khong lo dap an", "an", "an" if not any(q["CorrectAnswer"] for q in J(call("GET", "/questions", tok=hs))) else "lo")
ca("BM03", "GET /questions token admin: co dap an de quan ly", "co", "co" if all(q["CorrectAnswer"] for q in J(call("GET", "/questions", tok=adm))) else "thieu")
pw = pyodbc.connect(CS).execute("SELECT Password FROM Users WHERE Username=?", f"kt8_{TAG}").fetchone()[0]
ca("BM04", "Mat khau tai khoan moi luu dang bam PBKDF2", "bam", "bam" if pw.startswith("pbkdf2_sha256$") and "Kt8@2026" not in pw else "tho")
ca("BM05", "GET /users khong tra cot mat khau", "khong", "khong" if all("Password" not in u for u in J(call("GET", "/users", tok=adm))) else "co")

nhom("2. NOP BAI VA LUU LICH SU (ExamResults, ExamResultAnswers)")
r = J(call("POST", "/exam/submit", {"answers": [tl(q, i < 9) for i, q in enumerate(de)], "examCode": "SINH10-GK1-MD01", "durationSeconds": 300}, hs))
ca("LS01", "Nop 12 cau (9 dung) co token: luu lich su", "True", r["Saved"])
ca("LS02", "Diem = 9/12 = 75%", 75.0, r["ScorePercentage"])
r2 = J(call("POST", "/exam/submit", {"answers": [tl(de[0])], "examCode": "SINH10-GK1-MD01"}, hs))
ca("LS03", "Nop 1/12 cau: mau so van la 12, 11 cau bo trong", "12/11", f'{r2["TotalQuestions"]}/{r2["BlankCount"]}')
ca("LS04", "Nop khong token (khach): cham diem nhung khong luu", "False", J(call("POST", "/exam/submit", {"answers": [tl(de[0])]}))["Saved"])
ca("LS05", "De tong hop DE-01 lam theo mon Toan: mau so 4 cau", 4, J(call("POST", "/exam/submit", {"answers": [tl(toan01[0])]}))["TotalQuestions"])
ca("LS06", "Gui trung cau hoi: tu choi", 400, call("POST", "/exam/submit", {"answers": [tl(de[0])] * 2})[0])
ca("LS07", "Tron cau cua hai bo de: tu choi", 400, call("POST", "/exam/submit", {"answers": [tl(de[0]), tl(khac)]})[0])
ca("LS08", "Khai bao ma de khac voi cau hoi: tu choi", 400, call("POST", "/exam/submit", {"answers": [tl(de[0])], "examCode": "TOAN-DE01"})[0])
h = J(call("GET", "/exam/history", tok=hs))
ca("LS09", "GET /exam/history: 2 luot, moi nhat truoc", "2/8.33", f'{len(h)}/{h[0]["ScorePercentage"]}')
ca("LS10", "GET /exam/history khong token", 401, call("GET", "/exam/history")[0])
rv = J(call("GET", f"/exam/history/{h[1]['Id']}", tok=hs))
ca("LS11", "Xem lai luot 12 cau: du 12 cau, 9 dung", "12/9", f'{len(rv["Details"])}/{sum(d["isCorrect"] for d in rv["Details"])}')
ca("LS12", "Xem lai luot cua nguoi khac (hocsinh): khong cho", 404, call("GET", f"/exam/history/{h[1]['Id']}", tok=tk("hocsinh", "Hoc@1234"))[0])
ca("LS13", "Admin xem lai luot cua hoc sinh", 200, call("GET", f"/exam/history/{h[1]['Id']}", tok=adm)[0])

nhom("3. THONG KE HOC TAP VA BANG THANH TICH")
st = J(call("GET", "/exam/statistics", tok=hs))
ca("TK01", "Tong quan: 2 luot, TB (75+8.33)/2, cao nhat 75", f"2/{round((75 + 8.33) / 2, 2)}/75.0", f'{st["Summary"]["Attempts"]}/{st["Summary"]["AverageScore"]}/{st["Summary"]["BestScore"]}')
ca("TK02", "Thong ke theo mon: 1 mon Sinh hoc", "Sinh học", ",".join(s["Subject"] for s in st["BySubject"]))
lb = J(call("GET", "/exam/leaderboard?subject=" + urllib.request.quote("Sinh học")))
ca("TK03", "Bang thanh tich mon Sinh: diem giam dan", "True", all(lb[i]["ScorePercentage"] >= lb[i + 1]["ScorePercentage"] for i in range(len(lb) - 1)))
ca("TK04", "Moi hoc sinh moi bo de chi 1 dong (diem cao nhat)", "True", len({(x["Username"], x["ExamCode"]) for x in lb}) == len(lb))
ca("TK05", "Thong ke toan he thong: hoc sinh goi", 403, call("GET", "/exam/overview", tok=hs)[0])
ca("TK06", "Thong ke toan he thong: admin goi", 200, call("GET", "/exam/overview", tok=adm)[0])

nhom("4. CHE DO ON TAP")
c1 = J(call("POST", "/exam/check", {"questionId": de[0]["Id"], "selectedAnswer": de[0]["CorrectAnswer"]}))
ca("OT01", "Chon dung: IsCorrect, tra loi giai", "True", c1["IsCorrect"] and "Explanation" in c1)
ca("OT02", "Chon sai: tra dap an dung", de[0]["CorrectAnswer"], J(call("POST", "/exam/check", tl(de[0], False)))["CorrectAnswer"])
ca("OT03", "Cau hoi khong ton tai", 404, call("POST", "/exam/check", {"questionId": 999999, "selectedAnswer": "A"})[0])

nhom("5. QUAN LY BO DE (Exams)")
ca("BD01", "GET /exams: co bo de SINH10-GK1-MD01 12 cau", 12, next(e["QuestionCount"] for e in J(call("GET", "/exams")) if e["ExamCode"] == "SINH10-GK1-MD01"))
ca("BD02", "Them bo de: hoc sinh", 403, call("POST", "/exams", {"ExamCode": f"KT8-{TAG}", "Title": "x"}, hs)[0])
s, b = call("POST", "/exams", {"ExamCode": f"KT8-{TAG}", "Title": "De KT8", "SubjectCategory": "Toán", "DurationMinutes": 10}, adm)
ca("BD03", "Them bo de: admin", 201, s); eid = json.loads(b)["Id"]
ca("BD04", "Them trung ma de", 400, call("POST", "/exams", {"ExamCode": f"KT8-{TAG}", "Title": "y"}, adm)[0])
ca("BD05", "Sua thoi gian 0 phut (duoi bien)", 400, call("PUT", f"/exams/{eid}", {"Title": "De KT8", "DurationMinutes": 0}, adm)[0])
ca("BD06", "Sua thoi gian 300 phut (bien tren)", 200, call("PUT", f"/exams/{eid}", {"Title": "De KT8", "DurationMinutes": 300}, adm)[0])
q = {"Content": "Cau KT8", "OptionA": "a", "OptionB": "b", "OptionC": "c", "OptionD": "d", "CorrectAnswer": "A", "SubjectCategory": "Toán", "ExamCode": f"KT8-{TAG}"}
qid = J(call("POST", "/questions", q, adm))["Id"]
ca("BD07", "Xoa bo de con cau hoi", 409, call("DELETE", f"/exams/{eid}", tok=adm)[0])
call("DELETE", f"/questions/{qid}", tok=adm)
ca("BD08", "Xoa bo de rong", 200, call("DELETE", f"/exams/{eid}", tok=adm)[0])
qid2 = J(call("POST", "/questions", dict(q, ExamCode=f"KT8-AUTO-{TAG}"), adm))["Id"]
ca("BD09", "Them cau voi ma de moi: tu tao bo de", 200, call("GET", f"/exams/KT8-AUTO-{TAG}")[0])

nhom("6. KIEM TRA DU LIEU CAU HOI")
ca("CH01", "Noi dung rong", 400, call("POST", "/questions", dict(q, Content=""), adm)[0])
ca("CH02", "Thieu phuong an D", 400, call("POST", "/questions", dict(q, OptionD=""), adm)[0])
ca("CH03", "Dap an dung la Z", 400, call("POST", "/questions", dict(q, CorrectAnswer="Z"), adm)[0])
ca("CH04", "Dap an chu thuong 'b' duoc chuan hoa thanh B", "B", J(call("PUT", f"/questions/{qid2}", dict(q, CorrectAnswer="b", ExamCode=f"KT8-AUTO-{TAG}"), adm))["CorrectAnswer"])
ca("CH05", "Anh khong phai https", 400, call("POST", "/questions", dict(q, ImageUrl="javascript:alert(1)"), adm)[0])
ca("CH06", "Anh https (Cloudinary) duoc luu", "https://res.cloudinary.com/demo/image/upload/sample.jpg",
   J(call("PUT", f"/questions/{qid2}", dict(q, ExamCode=f"KT8-AUTO-{TAG}", ImageUrl="https://res.cloudinary.com/demo/image/upload/sample.jpg"), adm))["ImageUrl"])
call("DELETE", f"/questions/{qid2}", tok=adm)

nhom("7. ANH CAU HOI (Cloudinary)")
cfg = J(call("GET", "/upload/status"))
ca("CL01", "GET /upload/status khong lo khoa bi mat", "khong", "khong" if not any(k in json.dumps(cfg).lower() for k in ("secret", "api_key")) else "co")
def png_1x1():
    chunk = lambda t, d: struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d))
    return b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", 1, 1, 8, 2, 0, 0, 0)) + chunk(b"IDAT", zlib.compress(b"\x00\xdc\x26\x26")) + chunk(b"IEND", b"")


PNG = png_1x1()  # anh do 1x1 diem anh
bd = b"----kt8"
body = b"--" + bd + b'\r\nContent-Disposition: form-data; name="file"; filename="kt8.png"\r\nContent-Type: image/png\r\n\r\n' + PNG + b"\r\n--" + bd + b"--\r\n"
ctype = "multipart/form-data; boundary=" + bd.decode()
ca("CL02", "Tai anh: hoc sinh", 403, call("POST", "/upload/image", raw=body, tok=hs, ctype=ctype)[0])
s, b = call("POST", "/upload/image", raw=body, tok=adm, ctype=ctype)
ca("CL03", "Tai anh PNG: admin" + (" (Cloudinary da cau hinh)" if cfg["Configured"] else " (chua cau hinh -> 503)"), 201 if cfg["Configured"] else 503, s)
if s == 201: print("      URL Cloudinary:", json.loads(b)["Url"])
txt = body.replace(b"Content-Type: image/png", b"Content-Type: text/plain")
ca("CL04", "Tai tep khong phai anh", 400 if cfg["Configured"] else 503, call("POST", "/upload/image", raw=txt, tok=adm, ctype=ctype)[0])

nhom("8. QUAN LY NGUOI DUNG")
us = J(call("GET", "/users", tok=adm)); me = next(u for u in us if u["Username"] == f"kt8_{TAG}")
ca("ND01", "Danh sach co so luot lam cua hoc sinh", 2, me["Attempts"])
ca("ND02", "Hoc sinh goi /users", 403, call("GET", "/users", tok=hs)[0])
ca("ND03", "Doi vai tro thanh 'Boss'", 400, call("PUT", f"/users/{me['Id']}/role", {"Role": "Boss"}, adm)[0])
ca("ND04", "Admin tu doi vai tro cua minh", 403, call("PUT", "/users/1/role", {"Role": "Student"}, adm)[0])
ca("ND05", "Doi vai tro hoc sinh thanh Admin roi tra lai", "200/200", f'{call("PUT", f"/users/{me["Id"]}/role", {"Role": "Admin"}, adm)[0]}/{call("PUT", f"/users/{me["Id"]}/role", {"Role": "Student"}, adm)[0]}')
ca("ND06", "Admin tu xoa minh", 403, call("DELETE", "/users/1", tok=adm)[0])

nhom("9. TAM KHOA DANG NHAP (5 lan sai lien tiep)")
call("POST", "/auth/register", {"Username": f"kt8k_{TAG}", "Password": "Kt8@2026", "FullName": "Khoa"})
ma = [call("POST", "/auth/login", {"Username": f"kt8k_{TAG}", "Password": f"Sai@{i}"})[0] for i in range(5)]
ca("KD01", "5 lan sai deu 401", "401x5", "401x5" if ma == [401] * 5 else str(ma))
ca("KD02", "Lan 6 dung mat khau: van bi khoa", 429, call("POST", "/auth/login", {"Username": f"kt8k_{TAG}", "Password": "Kt8@2026"})[0])
ca("KD03", "Tai khoan khac khong bi anh huong", 200, call("POST", "/auth/login", {"Username": "hocsinh", "Password": "Hoc@1234"})[0])

ca("ND07", "Xoa tai khoan kiem thu (xoa ca lich su)", 200, call("DELETE", f"/users/{me['Id']}", tok=adm)[0])
cn = pyodbc.connect(CS, autocommit=True)
ca("ND08", "Lich su cua tai khoan da xoa khong con", 0, cn.execute("SELECT COUNT(*) FROM ExamResults WHERE UserId=?", me["Id"]).fetchone()[0])
cn.execute("DELETE FROM Users WHERE Username LIKE ?", f"kt8%{TAG}"); cn.execute("DELETE FROM Exams WHERE ExamCode LIKE ?", f"KT8-%{TAG}"); cn.close()

print(); print("TONG HOP KIEM THU V8")
for k, ten in [("BM", "Bao mat du lieu"), ("LS", "Nop bai, lich su"), ("TK", "Thong ke, bang thanh tich"), ("OT", "On tap"), ("BD", "Quan ly bo de"),
               ("CH", "Kiem tra cau hoi"), ("CL", "Anh Cloudinary"), ("ND", "Quan ly nguoi dung"), ("KD", "Tam khoa dang nhap")]:
    r = [o for m, o in kq if m == k]
    print(f"  {ten:28}{sum(r):3}/{len(r)} dat")
print(f"  {'Tong':28}{sum(o for _, o in kq):3}/{len(kq)} dat")
