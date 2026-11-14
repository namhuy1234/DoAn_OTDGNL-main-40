# -*- coding: utf-8 -*-
"""Kiem thu dua tren thuoc tinh (Property-Based Testing) bang thu vien Hypothesis.
Hypothesis tu sinh du lieu ngau nhien, kiem tra thuoc tinh luon dung.
Chay khi back-end dang chay o cong 8000: python tests/kiemthu_thuoctinh.py"""
import json, string, urllib.error, urllib.request
from hypothesis import given, settings, strategies as st

B = "http://127.0.0.1:8000/api"
SO_MAU = 100


def call(m, path, body=None, tok=None):
    h = {"Content-Type": "application/json"}
    if tok: h["Authorization"] = "Bearer " + tok
    r = urllib.request.Request(B + path, data=None if body is None else json.dumps(body).encode(), headers=h, method=m)
    try:
        with urllib.request.urlopen(r) as x: return x.status, x.read().decode()
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()


adm = json.loads(call("POST", "/auth/login", {"Username": "admin", "Password": "Admin@123"})[1])["AccessToken"]
de = [q for q in json.loads(call("GET", "/questions", None, adm)[1]) if q["ExamCode"] == "SINH10-GK1-MD01"]


@settings(max_examples=SO_MAU, deadline=None)
@given(st.text(alphabet=string.ascii_letters, min_size=1, max_size=30))
def tt1_mat_khau_chi_co_chu_luon_bi_tu_choi(pw):
    assert call("POST", "/auth/register", {"Username": "kt_tt", "Password": pw})[0] == 400


@settings(max_examples=SO_MAU, deadline=None)
@given(st.text(alphabet=string.digits, min_size=1, max_size=30))
def tt2_mat_khau_chi_co_so_luon_bi_tu_choi(pw):
    assert call("POST", "/auth/register", {"Username": "kt_tt", "Password": pw})[0] == 400


@settings(max_examples=SO_MAU, deadline=None)
@given(st.lists(st.sampled_from("ABCD"), min_size=12, max_size=12))
def tt3_diem_bang_so_cau_dung_chia_tong_so_cau(chon):
    body = {"answers": [{"questionId": q["Id"], "selectedAnswer": c} for q, c in zip(de, chon)]}
    kq = json.loads(call("POST", "/exam/submit", body)[1])
    dung = sum(q["CorrectAnswer"] == c for q, c in zip(de, chon))
    assert kq["CorrectCount"] == dung and kq["TotalQuestions"] == 12 and abs(kq["ScorePercentage"] - dung / 12 * 100) < 0.01


@settings(max_examples=SO_MAU, deadline=None)
@given(st.lists(st.booleans(), min_size=12, max_size=12))
def tt4_cham_diem_khong_phan_biet_chu_hoa_thuong(thuong):
    body = {"answers": [{"questionId": q["Id"], "selectedAnswer": q["CorrectAnswer"].lower() if t else q["CorrectAnswer"]} for q, t in zip(de, thuong)]}
    assert json.loads(call("POST", "/exam/submit", body)[1])["CorrectCount"] == 12


dat = 0
DS = [("TT1", "Mat khau chi co chu cai luon bi tu choi (400)", tt1_mat_khau_chi_co_chu_luon_bi_tu_choi),
      ("TT2", "Mat khau chi co chu so luon bi tu choi (400)", tt2_mat_khau_chi_co_so_luon_bi_tu_choi),
      ("TT3", "Diem = so cau dung / tong so cau x 100", tt3_diem_bang_so_cau_dung_chia_tong_so_cau),
      ("TT4", "Cham diem khong phan biet chu hoa, chu thuong", tt4_cham_diem_khong_phan_biet_chu_hoa_thuong)]
print(f"Cong cu: Hypothesis. Moi thuoc tinh tu sinh {SO_MAU} bo du lieu ngau nhien.\n")
for ma, ten, f in DS:
    try:
        f(); dat += 1; print(f"{ma}  {ten:55} {SO_MAU} mau  DAT")
    except AssertionError as e:
        print(f"{ma}  {ten:55} KHONG DAT")
print(f"\nTONG HOP: {dat}/{len(DS)} thuoc tinh dat")
