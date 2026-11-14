# -*- coding: utf-8 -*-
"""Kiem thu tu dong giao dien (hop den, end-to-end) bang Playwright, trinh duyet Microsoft Edge.
Chay khi back-end cong 8000 va front-end cong 5500 dang chay: python tests/kiemthu_giaodien.py"""
import asyncio, json, os
from playwright.async_api import async_playwright

FE = "http://localhost:5500/presentation/pages/"
DB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "database")
MON = {"Toán": 6, "Ngữ văn": 5, "Tiếng Anh": 5, "Vật lý": 5, "Hóa học": 5, "Sinh học": 4, "Địa lý": 5, "Lịch sử": 5}
kq = []


def ca(ma, ten, mong, thuc):
    ok = str(mong) == str(thuc); kq.append(ok)
    print(f"{ma:6}{ten:56}{str(mong):>18}{str(thuc):>18}  {'DAT' if ok else 'KHONG DAT'}")


async def login(pg, u, p):
    await pg.goto(FE + "login.html"); await pg.fill("#loginUsername", u); await pg.fill("#loginPassword", p)
    await pg.click("#loginForm button[type=submit]"); await pg.wait_for_timeout(2200)


async def main():
    print(f"Cong cu: Playwright + Microsoft Edge.\n{'Ma':6}{'Kich ban':56}{'Mong doi':>18}{'Thuc te':>18}  Ket qua")
    async with async_playwright() as p:
        b = await p.chromium.launch(channel="msedge", headless=True)
        pg = await (await b.new_context(locale="vi-VN")).new_page()
        await login(pg, "hocsinh", "Sai@1234")
        ca("UI01", "Dang nhap sai mat khau: o lai trang dang nhap", "login.html", pg.url.split("/")[-1])
        await login(pg, "hocsinh", "Hoc@1234")
        ca("UI02", "Hoc sinh dang nhap dung: vao kho de thi", "kho-de-thi.html", pg.url.split("/")[-1])
        await pg.wait_for_selector("#setList a")
        for i, (mon, n) in enumerate(MON.items(), 3):
            await pg.click(f"button[data-subject='{mon}']"); await pg.wait_for_timeout(200)
            ca(f"UI{i:02}", f"Loc mon {mon}: so bo de", n, await pg.locator("#setList h3").count())
        key = {q["Content"]: q["CorrectAnswer"] for q in json.load(open(os.path.join(DB, "de_sinh_hoc", "SINH10-GK1-MD01.json"), encoding="utf8"))}
        await pg.goto(FE + "exam.html?subject=Sinh%20h%E1%BB%8Dc&examCode=SINH10-GK1-MD01"); await pg.wait_for_selector("#questionContainer input")
        names = await pg.eval_on_selector_all("#questionContainer input[type=radio]", "e => [...new Set(e.map(x => x.name))]")
        texts = await pg.locator("#questionContainer > div > p").all_inner_texts()
        ca("UI11", "Mo bo de SINH10-GK1-MD01: so cau", 12, len(names))
        for n, t in zip(names, texts):
            await pg.check(f"input[name='{n}'][value='{key[t.split(': ', 1)[1]]}']")
        await pg.click("#submitExamBtn"); await pg.wait_for_selector("#resultBox:not(.hidden)")
        ca("UI12", "Lam dung het: ket qua hien thi 100%", True, "100%" in await pg.inner_text("#resultSummary"))
        await pg.click("#backBtn"); await pg.wait_for_timeout(800)
        ca("UI13", "Nut Quay lai: giu dang nhap", True, await pg.evaluate("localStorage.getItem('user') !== null"))
        await pg.goto(FE + "admin.html"); await pg.wait_for_timeout(500)
        ca("UI14", "Hoc sinh mo trang quan tri: hien thong bao tu choi", True, await pg.locator("#deniedBox").is_visible())
        await pg.goto(FE + "index.html"); await pg.wait_for_timeout(500); await pg.click("#heroLogoutBtn"); await pg.wait_for_timeout(800)
        ca("UI15", "Dang xuat: xoa phien dang nhap", False, await pg.evaluate("localStorage.getItem('user') !== null"))
        await login(pg, "admin", "Admin@123")
        ca("UI16", "Admin dang nhap: vao trang quan tri", "admin.html", pg.url.split("/")[-1])
        await b.close()
    print(f"\nTONG HOP: {sum(kq)}/{len(kq)} kich ban dat")

asyncio.run(main())
