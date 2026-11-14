# -*- coding: utf-8 -*-
"""Tao du lieu mau cho Bang thanh tich: cac tai khoan thu dang ky, dang nhap va lam bai that tren giao dien;
may chu cham diem. Ket qua ghi vao front-end/src/presentation/data/thanh-tich-mau.json.
Dap an duoc chon theo ty le dung dat san cho tung tai khoan, nen day la du lieu mau, khong phai ket qua hoc sinh that.
Chay khi back-end cong 8000 va front-end cong 5500 dang chay: python tests/tao_thanh_tich_mau.py
Chi chay mot so tai khoan: python tests/tao_thanh_tich_mau.py hs_namhuy (ket qua duoc gop vao tep da co)."""
import asyncio, json, os, random, sys
from playwright.async_api import async_playwright

FE = "http://localhost:5500/presentation/pages/"
GOC = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
DB = os.path.join(GOC, "database")
RA = os.path.join(GOC, "front-end", "src", "presentation", "data", "thanh-tich-mau.json")

# ten dang nhap, ho ten, mat khau thu, ty le chon dung
TAI_KHOAN = [("hs_yba2", "Y ba 2", "Mau@2026a", 0.75), ("hs_lamdo", "Lâm Đỗ", "Mau@2026b", 0.65),
             ("hs_bien", "Biên", "Mau@2026c", 0.6), ("hs_linhkieu", "Linh Kiều", "Mau@2026d", 0.85), ("hs_namhuy", "Nam Huy", "Mau@2026e", 0.7)]
# rieng cac mon nay chon dung het de dung dau bang (du lieu mau)
DUNG_HET = {"hs_namhuy": {"Sinh học", "Ngữ văn"}}
DE = [("Toán", "de_toan", "TOAN-DE01"), ("Ngữ văn", "de_ngu_van", "NGUVAN-DE01"), ("Tiếng Anh", "de_tieng_anh", "TIENGANH-DE01"),
      ("Vật lý", "de_vat_ly", "VATLY-DE01"), ("Hóa học", "de_hoa_hoc", "HOAHOC-DE01"), ("Sinh học", "de_sinh_hoc", "SINH10-GK1-MD01"),
      ("Địa lý", "de_dia_ly", "DIALY-DE01"), ("Lịch sử", "de_lich_su", "LICHSU-DE01")]


async def lam_de(pg, mon, thu_muc, ma, ty_le, rd):
    key = {q["Content"]: q["CorrectAnswer"] for q in json.load(open(os.path.join(DB, thu_muc, ma + ".json"), encoding="utf8"))}
    await pg.goto(FE + "exam.html?subject=" + mon + "&examCode=" + ma)
    await pg.wait_for_selector("#questionContainer input")
    names = await pg.eval_on_selector_all("#questionContainer input[type=radio]", "e => [...new Set(e.map(x => x.name))]")
    texts = await pg.locator("#questionContainer > div > p").all_inner_texts()
    for n, t in zip(names, texts):
        dung = key[t.split(": ", 1)[1]]
        chon = dung if rd.random() < ty_le else rd.choice([x for x in "ABCD" if x != dung])
        await pg.check(f"input[name='{n}'][value='{chon}']")
    await pg.click("#submitExamBtn")
    await pg.wait_for_selector("#resultBox:not(.hidden)")
    return await pg.inner_text("#resultSummary")


async def main():
    chon = sys.argv[1:]
    tat_ca = []
    async with async_playwright() as p:
        b = await p.chromium.launch(channel="msedge", headless=True)
        for ten, ho_ten, mk, ty_le in TAI_KHOAN:
            if chon and ten not in chon: continue
            rd = random.Random(ten)
            pg = await (await b.new_context(locale="vi-VN")).new_page()
            await pg.goto(FE + "register.html")
            await pg.fill("#regFullName", ho_ten); await pg.fill("#regUsername", ten); await pg.fill("#regPassword", mk)
            await pg.click("#registerForm button[type=submit]")
            await pg.wait_for_timeout(600)
            print(ten, "dang ky:", await pg.inner_text("#message"))
            await pg.goto(FE + "login.html")
            await pg.fill("#loginUsername", ten); await pg.fill("#loginPassword", mk)
            await pg.click("#loginForm button[type=submit]")
            await pg.wait_for_url("**/kho-de-thi.html", timeout=10000)
            for mon, thu_muc, ma in DE:
                print(" ", ho_ten, ma, await lam_de(pg, mon, thu_muc, ma, 1.0 if mon in DUNG_HET.get(ten, ()) else ty_le, rd))
            tat_ca += await pg.evaluate("JSON.parse(localStorage.getItem('ontidgnl_results') || '[]')")
            await pg.context.close()
        await b.close()
    os.makedirs(os.path.dirname(RA), exist_ok=True)
    if chon and os.path.exists(RA):
        cu = [r for r in json.load(open(RA, encoding="utf8")) if r["username"] not in chon]
        tat_ca = cu + tat_ca
    json.dump(tat_ca, open(RA, "w", encoding="utf8"), ensure_ascii=False, indent=1)
    print("da ghi", len(tat_ca), "ket qua")

asyncio.run(main())
