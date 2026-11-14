# -*- coding: utf-8 -*-
"""Nap ket qua mau (front-end/src/presentation/data/thanh-tich-mau.json, do tests/tao_thanh_tich_mau.py tao ra)
vao bang ExamResults de Bang thanh tich doc tu CSDL. Chi nap cho cac tai khoan thu hs_*; chay lai khong bi trung.
Day la du lieu mau, khong phai ket qua hoc sinh that. Chay: python tests/nap_thanh_tich_mau_csdl.py"""
import json, os
from datetime import datetime
import pyodbc

GOC = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
RA = os.path.join(GOC, "front-end", "src", "presentation", "data", "thanh-tich-mau.json")
CS = r"DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost\SQLEXPRESS;DATABASE=OnThiDGNL_DB;Trusted_Connection=yes;TrustServerCertificate=yes;"

cn = pyodbc.connect(CS)
ids = {u: i for i, u in cn.execute("SELECT Id, Username FROM Users WHERE Username LIKE 'hs[_]%'").fetchall()}
them = 0
for r in json.load(open(RA, encoding="utf8")):
    uid = ids.get(r["username"])
    if uid is None:
        continue
    luc = datetime.fromtimestamp(r["at"] / 1000).replace(microsecond=0)
    if cn.execute("SELECT COUNT(*) FROM ExamResults WHERE UserId=? AND ExamCode=? AND SubmittedAt=?", uid, r["code"], luc).fetchone()[0]:
        continue
    cn.execute("INSERT INTO ExamResults (UserId, ExamCode, SubjectCategory, TotalQuestions, CorrectCount, BlankCount, ScorePercentage, SubmittedAt) "
               "VALUES (?, ?, ?, ?, ?, 0, ?, ?)", uid, r["code"], r["subject"], r["total"], r["correct"], r["score"], luc)
    them += 1
cn.commit()
print("da nap", them, "ket qua mau; ExamResults hien co", cn.execute("SELECT COUNT(*) FROM ExamResults").fetchone()[0], "dong")
