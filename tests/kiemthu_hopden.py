# -*- coding: utf-8 -*-
"""Kiem thu hop den tu dong API, ca kiem thu thiet ke theo 4 ky thuat:
phan vung tuong duong, gia tri bien, bang quyet dinh, doan loi.
Cong cu: Python (urllib) goi truc tiep API; pyodbc don du lieu tam.
Chay khi back-end dang chay o cong 8000: python tests/kiemthu_hopden.py"""
import json, os, time, urllib.error, urllib.request, uuid
import pyodbc

B = "http://127.0.0.1:8000/api"
CS = r"DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost\SQLEXPRESS;DATABASE=OnThiDGNL_DB;Trusted_Connection=yes;TrustServerCertificate=yes;"
TAG = uuid.uuid4().hex[:6]
kq = []


def call(m, path, body=None, tok=None, raw=None):
    h = {"Content-Type": "application/json"}
    if tok: h["Authorization"] = "Bearer " + tok
    data = raw if raw is not None else (None if body is None else json.dumps(body).encode())
    r = urllib.request.Request(B + path, data=data, headers=h, method=m)
    try:
        with urllib.request.urlopen(r) as x: return x.status, x.read().decode()
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()


def ca(ma, ten, mong, thuc):
    ok = str(mong) == str(thuc)
    kq.append((ma[:2], ok))
    time.sleep(float(os.getenv("KT_CHAM", "0")))
    print(f"{ma:6}{ten:60}{str(mong):>10}{str(thuc):>9}  {'DAT' if ok else 'KHONG DAT'}")


def nhom(t):
    print(); print(t); print(f"{'Ma':6}{'Dau vao':60}{'Mong doi':>10}{'Thuc te':>9}  Ket qua")


def dk(u, pw):
    return call("POST", "/auth/register", {"Username": f"kt_{TAG}_{u}", "Password": pw, "FullName": "Kiem thu"})[0]


tk = lambda u, p: json.loads(call("POST", "/auth/login", {"Username": u, "Password": p})[1])["AccessToken"]
adm, stu = tk("admin", "Admin@123"), tk("hocsinh", "Hoc@1234")
de = [q for q in json.loads(call("GET", "/questions", None, adm)[1]) if q["ExamCode"] == "SINH10-GK1-MD01"]  # token admin de co dap an
assert len(de) == 12
nop = lambda ds: call("POST", "/exam/submit", {"answers": ds})
Q = {"Content": "Cau kiem thu", "OptionA": "a", "OptionB": "b", "OptionC": "c", "OptionD": "d", "CorrectAnswer": "A", "SubjectCategory": "Sinh học", "Explanation": "", "ExamCode": "KT-TMP"}

nhom("1. PHAN VUNG TUONG DUONG (EP) - dang ky, lop hop le / khong hop le cua mat khau va ten dang nhap")
ca("EP01", "Lop hop le: co so va ky tu dac biet (Abc@1234)", 200, dk("a", "Abc@1234"))
ca("EP02", "Khong hop le: khong so, khong ky tu dac biet (abcdefgh)", 400, dk("b", "abcdefgh"))
ca("EP03", "Khong hop le: co so, thieu ky tu dac biet (abcd1234)", 400, dk("c", "abcd1234"))
ca("EP04", "Khong hop le: co ky tu dac biet, thieu so (abcd@efg)", 400, dk("d", "abcd@efg"))
ca("EP05", "Khong hop le: mat khau rong", 400, dk("e", ""))
ca("EP06", "Khong hop le: ten dang nhap da ton tai", 400, dk("a", "Abc@1234"))

nhom("2. GIA TRI BIEN (BVA) - so ky tu toi thieu cua mat khau; so cau khi nop bai; diem 0% va 100%")
ca("BV01", "Mat khau nho nhat hop le: dung 1 so, 1 ky tu dac biet (1@)", 200, dk("f", "1@"))
ca("BV02", "Duoi bien: chi 1 so (1)", 400, dk("g", "1"))
ca("BV03", "Duoi bien: chi 1 ky tu dac biet (@)", 400, dk("h", "@"))
ca("BV04", "Nop bai 0 cau (duoi bien)", 400, nop([])[0])
ca("BV05", "Nop bai 1 cau (bien duoi)", 200, nop([{"questionId": de[0]["Id"], "selectedAnswer": de[0]["CorrectAnswer"]}])[0])
ca("BV06", "Nop du 12 cau, dung het: diem bien tren", 100, int(json.loads(nop([{"questionId": q["Id"], "selectedAnswer": q["CorrectAnswer"]} for q in de])[1])["ScorePercentage"]))
sai = lambda a: "A" if a != "A" else "B"
ca("BV07", "Nop du 12 cau, sai het: diem bien duoi", 0, int(json.loads(nop([{"questionId": q["Id"], "selectedAnswer": sai(q["CorrectAnswer"])} for q in de])[1])["ScorePercentage"]))

nhom("3. BANG QUYET DINH (DT) - dang nhap: ten x mat khau; ghi cau hoi: loai token x thao tac")
for ma, u, p, mong, ten in [("DT01", "admin", "Admin@123", 200, "Ten dung, mat khau dung"), ("DT02", "admin", "Sai@1234", 401, "Ten dung, mat khau sai"), ("DT03", f"khongco{TAG}", "Admin@123", 401, "Ten sai, mat khau dung"), ("DT04", f"khongco{TAG}", "Sai@1234", 401, "Ten sai, mat khau sai")]:
    ca(ma, ten, mong, call("POST", "/auth/login", {"Username": u, "Password": p})[0])
ca("DT05", "Them cau hoi: khong co token", 401, call("POST", "/questions", Q)[0])
ca("DT06", "Them cau hoi: token hoc sinh", 403, call("POST", "/questions", Q, stu)[0])
s, b = call("POST", "/questions", Q, adm); qid = json.loads(b)["Id"]
ca("DT07", "Them cau hoi: token admin", 201, s)
ca("DT08", "Xoa cau hoi: khong co token", 401, call("DELETE", f"/questions/{qid}")[0])
ca("DT09", "Xoa cau hoi: token hoc sinh", 403, call("DELETE", f"/questions/{qid}", None, stu)[0])
ca("DT10", "Xoa cau hoi: token admin", 200, call("DELETE", f"/questions/{qid}", None, adm)[0])

nhom("4. DOAN LOI (EG) - du doan cac dau vao de gay loi tu kinh nghiem")
ca("EG01", "SQL injection o ten dang nhap (' OR '1'='1' --)", 401, call("POST", "/auth/login", {"Username": "' OR '1'='1' --", "Password": "x"})[0])
ca("EG02", "JSON sai cu phap khi dang nhap", 422, call("POST", "/auth/login", raw=b"{sai json")[0])
ca("EG03", "Sua cau hoi khong ton tai (Id 999999)", 404, call("PUT", "/questions/999999", Q, adm)[0])
ca("EG04", "Token bi sua chu ky", 401, call("POST", "/questions", Q, adm[:-3] + "abc")[0])
ca("EG05", "Nop 1 cau dung cua de 12 cau: diem phai < 100", "<100", "<100" if json.loads(nop([{"questionId": de[0]["Id"], "selectedAnswer": de[0]["CorrectAnswer"]}])[1])["ScorePercentage"] < 100 else "100")
ca("EG06", "Nop trung 1 cau 10 lan: phai bi tu choi", 400, nop([{"questionId": de[0]["Id"], "selectedAnswer": de[0]["CorrectAnswer"]}] * 10)[0])
ca("EG07", "Them cau hoi co dap an 'Z': phai bi tu choi", 400, call("POST", "/questions", dict(Q, CorrectAnswer="Z"), adm)[0])

cn = pyodbc.connect(CS, autocommit=True)
cn.execute("DELETE FROM Users WHERE Username LIKE ?", f"kt[_]{TAG}%"); cn.execute("DELETE FROM Questions WHERE ExamCode='KT-TMP'"); cn.execute("DELETE FROM Exams WHERE ExamCode='KT-TMP'"); cn.close()

print(); print("TONG HOP HOP DEN")
for k, ten in [("EP", "Phan vung tuong duong"), ("BV", "Gia tri bien"), ("DT", "Bang quyet dinh"), ("EG", "Doan loi")]:
    r = [o for m, o in kq if m == k]
    print(f"  {ten:24}{sum(r):3}/{len(r)} dat")
print(f"  {'Tong':24}{sum(o for _, o in kq):3}/{len(kq)} dat")
