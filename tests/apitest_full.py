# -*- coding: utf-8 -*-
import json, time, statistics, urllib.request, urllib.error, base64
B = "http://127.0.0.1:8000/api"


def call(m, path, body=None, tok=None, raw=None):
    h = {"Content-Type": "application/json"}
    if tok: h["Authorization"] = "Bearer " + tok
    data = raw if raw is not None else (None if body is None else json.dumps(body).encode())
    r = urllib.request.Request(B + path, data=data, headers=h, method=m)
    try:
        with urllib.request.urlopen(r) as x: return x.status, x.read().decode()
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()


res = []


def t(id, name, m, path, body, tok, expect, check=None, raw=None):
    s, b = call(m, path, body, tok, raw)
    ok = (s == expect) and (check(b) if check else True)
    res.append(dict(id=id, name=name, method=m, path="/api" + path, expect=expect, status=s, ok=ok, body=b[:160]))
    return s, b


adm = json.loads(call("POST", "/auth/login", {"Username": "admin", "Password": "Admin@123"})[1])["AccessToken"]
stu = json.loads(call("POST", "/auth/login", {"Username": "hocsinh", "Password": "Hoc@1234"})[1])["AccessToken"]
t("TC01", "Đăng ký thiếu mật khẩu", "POST", "/auth/register", {"Username": "tmpuser"}, None, 400)
t("TC02", "Đăng ký mật khẩu yếu (không có số/ký tự đặc biệt)", "POST", "/auth/register", {"Username": "tmpuser", "Password": "abcdefgh"}, None, 400)
t("TC03", "Đăng ký hợp lệ", "POST", "/auth/register", {"Username": "tmpuser", "Password": "Abc@1234", "FullName": "Tài khoản thử"}, None, 200)
t("TC04", "Đăng ký trùng tên đăng nhập", "POST", "/auth/register", {"Username": "tmpuser", "Password": "Abc@1234"}, None, 400)
t("TC05", "Đăng nhập đúng (trả về JWT)", "POST", "/auth/login", {"Username": "admin", "Password": "Admin@123"}, None, 200, lambda b: "AccessToken" in b)
t("TC06", "Đăng nhập sai mật khẩu", "POST", "/auth/login", {"Username": "admin", "Password": "sai"}, None, 401)
t("TC07", "Đăng nhập thiếu thông tin", "POST", "/auth/login", {"Username": "admin"}, None, 400)
t("TC08", "Đổi mật khẩu thành công", "POST", "/auth/change-password", {"Username": "tmpuser", "OldPassword": "Abc@1234", "NewPassword": "Xyz@5678"}, None, 200)
t("TC09", "Đổi mật khẩu với mật khẩu cũ sai", "POST", "/auth/change-password", {"Username": "tmpuser", "OldPassword": "Abc@1234", "NewPassword": "Xyz@5678"}, None, 401)
t("TC10", "Đổi mật khẩu mới quá yếu", "POST", "/auth/change-password", {"Username": "tmpuser", "OldPassword": "Xyz@5678", "NewPassword": "yeu"}, None, 400)
s, b = t("TC11", "Lấy danh sách câu hỏi", "GET", "/questions", None, None, 200, lambda b: len(json.loads(b)) >= 30)
qs = json.loads(call("GET", "/questions", None, adm)[1])  # từ V8 chỉ admin nhận đáp án; dùng làm dữ liệu kiểm thử
q = {"Content": "Câu hỏi kiểm thử", "OptionA": "a", "OptionB": "b", "OptionC": "c", "OptionD": "d", "CorrectAnswer": "A", "SubjectCategory": "Toán", "Explanation": "tmp", "ExamCode": "TMP"}
t("TC12", "Thêm câu hỏi khi không có token", "POST", "/questions", q, None, 401)
t("TC13", "Thêm câu hỏi bằng tài khoản học sinh", "POST", "/questions", q, stu, 403)
s, b = t("TC14", "Thêm câu hỏi bằng tài khoản admin", "POST", "/questions", q, adm, 201)
nid = json.loads(b)["Id"]
q2 = dict(q, Content="Câu hỏi kiểm thử (đã sửa)")
t("TC15", "Sửa câu hỏi (admin)", "PUT", f"/questions/{nid}", q2, adm, 200)
t("TC16", "Sửa câu hỏi không tồn tại", "PUT", "/questions/999999", q2, adm, 404)
t("TC17", "Xóa câu hỏi (admin)", "DELETE", f"/questions/{nid}", None, adm, 200)
t("TC18", "Xóa câu hỏi không tồn tại", "DELETE", f"/questions/{nid}", None, adm, 404)
toan = [x for x in qs if x["ExamCode"] == "ĐỀ-01" and x["SubjectCategory"] == "Toán"]
ans = [{"questionId": x["Id"], "selectedAnswer": x["CorrectAnswer"]} for x in toan]
t("TC19", "Nộp bài đúng toàn bộ (kỳ vọng 100%)", "POST", "/exam/submit", {"answers": ans}, None, 200, lambda b: json.loads(b)["ScorePercentage"] == 100.0)
mix = [dict(a) for a in ans]; mix[0]["selectedAnswer"] = "D"; mix[1]["selectedAnswer"] = ""
t("TC20", "Nộp bài sai 1 câu, bỏ trống 1 câu (kỳ vọng 50%)", "POST", "/exam/submit", {"answers": mix}, None, 200, lambda b: json.loads(b)["ScorePercentage"] == 50.0)
t("TC21", "Nộp bài không có dữ liệu trả lời", "POST", "/exam/submit", {"answers": []}, None, 400)
t("TC22", "Truy cập đường dẫn viết hoa (/api/Questions)", "GET", "/Questions", None, None, 200)
# --- bo sung
t("TC23", "Tấn công SQL injection ở ô tên đăng nhập (' OR '1'='1' --)", "POST", "/auth/login", {"Username": "' OR '1'='1' --", "Password": "x"}, None, 401)
t("TC24", "SQL injection ở ô mật khẩu (' OR 1=1 --)", "POST", "/auth/login", {"Username": "admin", "Password": "' OR 1=1 --"}, None, 401)
t("TC25", "Token sai định dạng khi thêm câu hỏi", "POST", "/questions", q, "abc.def.ghi", 401)
tok_tampered = adm[:-3] + ("AAA" if not adm.endswith("AAA") else "BBB")
t("TC26", "Token bị sửa chữ ký khi thêm câu hỏi", "POST", "/questions", q, tok_tampered, 401)
t("TC27", "Gửi JSON sai cú pháp khi đăng nhập", "POST", "/auth/login", None, None, 422, raw=b"{Username: admin")
# V8: bài làm không có câu hỏi hợp lệ bị từ chối (trước đây trả 200, 0 câu đúng)
t("TC28", "Nộp bài với mã câu hỏi không tồn tại", "POST", "/exam/submit", {"answers": [{"questionId": 999999, "selectedAnswer": "A"}]}, None, 400)
t("TC29", "Gửi tên trường dạng chữ thường (username/password) khi đăng nhập", "POST", "/auth/login", {"username": "hocsinh", "password": "Hoc@1234"}, None, 200, lambda b: "AccessToken" in b)
t("TC30", "Lưu câu hỏi chứa mã HTML/script (kiểm tra lưu trữ nguyên văn)", "POST", "/questions", dict(q, Content="<img src=x onerror=alert(1)> test", ExamCode="TMP"), adm, 201)
xid = [json.loads(call("GET", "/questions")[1])][0]
xid = [x["Id"] for x in xid if x["ExamCode"] == "TMP"]
for i in xid: call("DELETE", f"/questions/{i}", None, adm)
for e in json.loads(call("GET", "/exams")[1]):
    if e["ExamCode"] == "TMP": call("DELETE", f"/exams/{e['Id']}", None, adm)  # bộ đề tạm tự tạo khi thêm câu hỏi
t("TC31", "Đổi mật khẩu với tên đăng nhập không tồn tại", "POST", "/auth/change-password", {"Username": "khongco", "OldPassword": "a", "NewPassword": "Abc@123"}, None, 401)
json.dump(res, open("apitest_full.json", "w", encoding="utf8"), ensure_ascii=False, indent=1)
for r in res: print(r["id"], r["status"], "PASS" if r["ok"] else "FAIL", r["name"])

# --- do thoi gian phan hoi
def timeit(fn, n=50):
    ts = []
    for _ in range(n):
        a = time.perf_counter(); fn(); ts.append((time.perf_counter() - a) * 1000)
    return dict(n=n, avg=round(statistics.mean(ts), 1), med=round(statistics.median(ts), 1), p95=round(sorted(ts)[int(n * 0.95) - 1], 1), mx=round(max(ts), 1))


perf = {
    "GET /api/questions": timeit(lambda: call("GET", "/questions")),
    "POST /api/auth/login": timeit(lambda: call("POST", "/auth/login", {"Username": "hocsinh", "Password": "Hoc@1234"})),
    "POST /api/exam/submit (4 câu)": timeit(lambda: call("POST", "/exam/submit", {"answers": ans})),
}
json.dump(perf, open("perf.json", "w", encoding="utf8"), ensure_ascii=False, indent=1)
print(json.dumps(perf, ensure_ascii=False, indent=1))
# payload cua JWT (khong in chu ky)
p = adm.split(".")[1]; p += "=" * (-len(p) % 4)
print(base64.urlsafe_b64decode(p).decode())
print(base64.urlsafe_b64decode(adm.split(".")[0] + "==").decode())
