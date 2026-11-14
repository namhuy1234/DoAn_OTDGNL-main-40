// Phần dùng chung của mọi trang: thanh menu, chân trang, nút hiện mật khẩu, hiệu ứng, bảng thành tích.
(function () {
    const OT = window.OT = {};

    OT.SUBJECTS = [
        ['Toán', 'TOÁN'], ['Ngữ văn', 'VĂN'], ['Tiếng Anh', 'ANH'], ['Vật lý', 'LÝ'],
        ['Hóa học', 'HÓA'], ['Sinh học', 'SINH'], ['Địa lý', 'ĐỊA'], ['Lịch sử', 'SỬ']
    ];
    OT.abbr = function (subject) {
        const s = OT.SUBJECTS.find(x => x[0] === subject);
        return s ? s[1] : 'ĐGNL';
    };
    OT.esc = function (text) {
        return String(text == null ? '' : text).replace(/[&<>"']/g, ch => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[ch]));
    };
    OT.user = function () {
        try { return JSON.parse(localStorage.getItem('user') || 'null'); } catch (e) { return null; }
    };
    OT.isAdmin = function () {
        const u = OT.user();
        return !!u && String(u.Role || '').toLowerCase() === 'admin';
    };
    OT.logout = function () {
        localStorage.removeItem('user');
        window.location.href = 'index.html';
    };

    // Gom câu hỏi thành bộ đề theo mã đề.
    OT.groupSets = function (questions) {
        const groups = new Map();
        for (const q of questions) {
            const code = (q.ExamCode || '').trim() || 'Bộ đề chung';
            if (!groups.has(code)) groups.set(code, { code, subject: (q.SubjectCategory || '').trim() || 'Chung', count: 0 });
            groups.get(code).count++;
        }
        return [...groups.values()];
    };

    // Gọi API: tự gắn token của người đang đăng nhập. Token hết hạn (401) thì đăng xuất và mời đăng nhập lại.
    OT.API = 'http://localhost:8000/api';
    OT.authHeaders = function (extra) {
        const u = OT.user();
        return Object.assign({}, extra || {}, u && u.AccessToken ? { 'Authorization': 'Bearer ' + u.AccessToken } : {});
    };
    OT.api = async function (path, options) {
        const opt = Object.assign({}, options || {});
        opt.headers = OT.authHeaders(opt.headers);
        const res = await fetch(OT.API + path, opt);
        if (res.status === 401 && OT.user()) {
            localStorage.removeItem('user');
            alert('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
            window.location.href = 'login.html';
            throw new Error('Phiên đăng nhập đã hết hạn.');
        }
        if (!res.ok) throw new Error((await res.text()) || ('Lỗi máy chủ ' + res.status));
        return res.status === 204 ? null : res.json();
    };

    // Lịch sử làm bài lưu trong CSDL (bảng ExamResults); trang Kho đề dùng để hiện điểm cao nhất mỗi bộ đề.
    let history = [];
    OT.loadHistory = async function () {
        if (!OT.user()) return [];
        try { history = await OT.api('/Exam/history'); } catch (e) { history = []; }
        return history;
    };
    OT.bestOf = function (code) {
        const mine = history.filter(x => x.ExamCode === code);
        if (!mine.length) return null;
        const best = mine.reduce((a, b) => (b.ScorePercentage > a.ScorePercentage ? b : a));
        return { score: best.ScorePercentage, times: mine.length };
    };
    OT.fmtTime = function (iso) {
        if (!iso) return '';
        const d = new Date(iso);
        return d.toLocaleDateString('vi-VN') + ' ' + d.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
    };
    OT.fmtDuration = function (s) {
        if (!s) return '–';
        return Math.floor(s / 60) + ' phút ' + String(s % 60).padStart(2, '0') + ' giây';
    };

    // Ảnh bìa bộ đề: tờ đề và ký hiệu riêng của từng môn, vẽ bằng SVG do nhóm tự làm.
    const COVER = {
        'Toán': ['#dbeafe', '#1d4ed8', '∑'], 'Ngữ văn': ['#fee2e2', '#b91c1c', 'Văn'], 'Tiếng Anh': ['#ede9fe', '#6d28d9', 'Aa'], 'Vật lý': ['#cffafe', '#0e7490', 'Lý'],
        'Hóa học': ['#fef3c7', '#b45309', 'Hóa'], 'Sinh học': ['#d1fae5', '#047857', 'Sinh'], 'Địa lý': ['#e0f2fe', '#0369a1', 'Địa'], 'Lịch sử': ['#ffedd5', '#c2410c', 'Sử']
    };
    OT.cover = function (subject) {
        const c = COVER[subject] || ['#f1f5f9', '#475569', 'Đề'];
        return `<div class="set-img" style="background:${c[0]}"><svg viewBox="0 0 160 120" role="img" aria-label="Môn ${OT.esc(subject)}">
            <rect x="34" y="10" width="92" height="104" rx="8" fill="#fff" stroke="${c[1]}" stroke-width="3"/>
            <text x="80" y="58" text-anchor="middle" font-family="Poppins, sans-serif" font-weight="700" font-size="28" fill="${c[1]}">${OT.esc(c[2])}</text>
            <path d="M50 76h60M50 88h60M50 100h36" stroke="${c[1]}" stroke-width="4" stroke-linecap="round" opacity=".45"/>
            <circle cx="126" cy="96" r="16" fill="${c[1]}"/><path d="M119 96l5 5 9-10" stroke="#fff" stroke-width="3.5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
        </svg></div>`;
    };

    const LOGO = '<span class="inline-flex w-10 h-10 items-center justify-center rounded-xl bg-brand-600 text-white shadow-sm"><svg viewBox="0 0 24 24" class="w-6 h-6" fill="currentColor"><path d="M12 2l9 6-9 6-9-6 9-6zm0 8.5l9 5.5-9 6-9-5.5 9-5.5z"/></svg></span>';

    function menuItems() {
        const items = [
            ['index', 'Trang chủ', 'index.html'],
            ['kho', 'Kho đề thi', 'kho-de-thi.html'],
            ['thanh-tich', 'Bảng thành tích', 'index.html#bang-thanh-tich'],
            ['tin-tuc', 'Tin tức', 'index.html#tin-tuc']
        ];
        if (OT.user()) items.push(['lich-su', 'Lịch sử', 'lich-su.html']);
        if (OT.isAdmin()) items.push(['admin', 'Quản trị', 'admin.html']);
        return items;
    }

    // Thanh tab chung của các trang quản trị: câu hỏi, bộ đề, người dùng.
    OT.renderAdminTabs = function () {
        const host = document.getElementById('adminTabs');
        if (!host || !OT.isAdmin()) return;
        const page = document.body.getAttribute('data-admin-tab') || '';
        host.innerHTML = [['cau-hoi', 'Câu hỏi', 'admin.html'], ['de-thi', 'Bộ đề', 'de-thi.html'], ['nguoi-dung', 'Người dùng', 'nguoi-dung.html']].map(t =>
            `<a href="${t[2]}" class="px-4 py-2 rounded-full text-sm font-semibold transition ${t[0] === page ? 'bg-brand-600 text-white' : 'bg-white text-slate-700 border border-slate-200 hover:text-brand-600'}">${t[1]}</a>`).join('');
        host.className = 'flex flex-wrap gap-2 mb-6';
    };

    OT.renderHeader = function () {
        const host = document.getElementById('siteHeader');
        if (!host) return;
        const page = document.body.getAttribute('data-page') || '';
        const u = OT.user();
        const name = u ? (u.FullName || u.Username || '') : '';
        const link = (it) => {
            const active = it[0] === page;
            const auth = it[0] === 'kho' ? ' data-require-auth' : '';
            return `<a href="${it[2]}"${auth} class="px-3 py-2 rounded-lg transition ${active ? 'text-brand-600 font-semibold' : 'text-slate-900 hover:text-brand-600'}">${it[1]}</a>`;
        };
        const right = u ? `
            <div id="headerUserBox" class="flex items-center gap-2">
                <span class="hidden sm:inline-flex w-9 h-9 items-center justify-center rounded-full bg-brand-100 text-brand-700 font-bold text-sm">${OT.esc(name.trim().charAt(0).toUpperCase())}</span>
                <b id="headerUserName" class="hidden lg:inline text-sm text-slate-700 max-w-[10rem] truncate">${OT.esc(name)}</b>
                <button id="headerLogoutBtn" type="button" class="px-4 py-2 rounded-full text-sm font-semibold text-brand-600 border border-brand-200 hover:bg-brand-50 transition">Đăng xuất</button>
            </div>` : `
            <a id="headerRegisterBtn" href="register.html" class="px-4 py-2 rounded-full text-sm font-semibold text-brand-600 border border-brand-300 hover:bg-brand-50 transition">Đăng ký</a>
            <a id="headerLoginBtn" href="login.html" class="px-4 py-2 rounded-full text-sm font-semibold text-white bg-brand-600 hover:bg-brand-700 shadow-sm transition">Đăng nhập</a>`;
        host.innerHTML = `
        <header class="sticky top-0 z-50 bg-white/95 backdrop-blur border-b border-brand-200 shadow-sm">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-[72px] flex items-center justify-between gap-3">
                <div class="flex items-center gap-1 sm:gap-6 min-w-0">
                    <button id="menuBtn" type="button" aria-label="Mở menu" aria-expanded="false" class="xl:hidden p-2 -ml-2 rounded-lg text-brand-600 hover:bg-brand-50">
                        <svg viewBox="0 0 24 24" class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M4 7h16M4 12h16M4 17h16"/></svg>
                    </button>
                    <a href="index.html" class="flex items-center gap-2 font-extrabold text-lg text-brand-700 whitespace-nowrap">${LOGO}<span class="hidden min-[420px]:inline">Ôn Thi ĐGNL</span></a>
                    <nav class="hidden xl:flex items-center gap-1 text-sm font-medium whitespace-nowrap">${menuItems().map(link).join('')}</nav>
                </div>
                <div class="flex items-center gap-2 shrink-0">
                    <a href="kho-de-thi.html?focus=search" data-require-auth aria-label="Tìm bộ đề" class="hidden sm:inline-flex p-2 rounded-lg text-brand-600 hover:bg-brand-50">
                        <svg viewBox="0 0 24 24" class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/></svg>
                    </a>
                    ${right}
                </div>
            </div>
            <nav id="mobileMenu" class="hidden xl:hidden border-t border-brand-100 bg-white px-4 py-2 text-sm font-medium flex-col">${menuItems().map(link).join('')}</nav>
        </header>`;
        document.getElementById('menuBtn').addEventListener('click', function () {
            const m = document.getElementById('mobileMenu');
            const open = m.classList.toggle('hidden') === false;
            m.classList.toggle('flex', open);
            this.setAttribute('aria-expanded', String(open));
        });
        const out = document.getElementById('headerLogoutBtn');
        if (out) out.addEventListener('click', OT.logout);
        // Chưa đăng nhập thì vào kho đề sẽ chuyển sang trang đăng nhập.
        document.querySelectorAll('[data-require-auth]').forEach(el => {
            el.addEventListener('click', e => {
                if (!OT.user()) { e.preventDefault(); window.location.href = 'login.html'; }
            });
        });
    };

    OT.renderFooter = function () {
        const host = document.getElementById('siteFooter');
        if (!host) return;
        host.innerHTML = `
        <footer class="bg-brand-50 border-t border-brand-200 text-sm text-slate-700">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 grid sm:grid-cols-2 lg:grid-cols-4 gap-8">
                <div class="lg:col-span-2">
                    <div class="flex items-center gap-3 mb-3">${LOGO}<div class="font-bold text-brand-700 leading-snug">ÔN THI ĐGNL<br>ĐỒ ÁN CHUYÊN NGÀNH – NHÓM 40</div></div>
                    <p class="max-w-md leading-relaxed">Hệ thống ôn thi Đánh giá năng lực, sản phẩm học tập tại Khoa Công nghệ Thông tin, Trường Đại học Đà Lạt.</p>
                </div>
                <div>
                    <h4 class="font-semibold text-brand-700 mb-3">Danh mục</h4>
                    <ul class="space-y-2">
                        <li><a class="hover:text-brand-600 transition" href="index.html">Trang chủ</a></li>
                        <li><a class="hover:text-brand-600 transition" href="kho-de-thi.html">Kho đề thi</a></li>
                        <li><a class="hover:text-brand-600 transition" href="index.html#bang-thanh-tich">Bảng thành tích</a></li>
                        <li><a class="hover:text-brand-600 transition" href="index.html#tin-tuc">Tin tức</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold text-brand-700 mb-3">Nhóm thực hiện</h4>
                    <ul class="space-y-2">
                        <li>Giảng viên hướng dẫn: Lê Gia Công</li>
                        <li>Nhóm trưởng: Đặng Nam Huy</li>
                        <li>Thành viên: Kiều Hà Linh, Y-ba</li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-brand-200 py-4 text-center text-xs text-slate-500">© 2026 Nhóm 40 – Sản phẩm phục vụ học tập.</div>
        </footer>`;
    };

    // Nút con mắt: hiện hoặc che mật khẩu trong ô nhập.
    OT.addPasswordToggles = function () {
        document.querySelectorAll('input[data-password]').forEach(input => {
            const wrap = document.createElement('div');
            wrap.className = 'relative';
            input.parentNode.insertBefore(wrap, input);
            wrap.appendChild(input);
            input.classList.add('!pr-12');
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'pw-toggle absolute inset-y-0 right-0 px-3.5 text-slate-400 hover:text-brand-600 transition';
            btn.setAttribute('aria-label', 'Hiện mật khẩu');
            btn.setAttribute('aria-pressed', 'false');
            const icon = (off) => `<svg viewBox="0 0 24 24" class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7-10-7-10-7z"/><circle cx="12" cy="12" r="3"/>${off ? '<path d="M3 3l18 18"/>' : ''}</svg>`;
            btn.innerHTML = icon(false);
            btn.addEventListener('click', () => {
                const show = input.type === 'password';
                input.type = show ? 'text' : 'password';
                btn.innerHTML = icon(show);
                btn.setAttribute('aria-pressed', String(show));
                btn.setAttribute('aria-label', show ? 'Che mật khẩu' : 'Hiện mật khẩu');
            });
            wrap.appendChild(btn);
        });
    };

    // Hiện dần khi cuộn: phần đang nằm trong màn hình đầu tiên giữ nguyên, không bị mờ lúc mở trang.
    OT.initReveal = function () {
        if (!('IntersectionObserver' in window)) return;
        const io = new IntersectionObserver(entries => {
            entries.forEach(en => {
                if (en.isIntersecting) { en.target.classList.add('reveal-in'); io.unobserve(en.target); }
            });
        }, { threshold: 0.08 });
        document.querySelectorAll('[data-reveal]').forEach(el => {
            if (el.getBoundingClientRect().top < window.innerHeight) return;
            el.classList.add('reveal-ready');
            io.observe(el);
        });
    };

    // Số đếm dần tới giá trị thật lấy từ API.
    OT.countUp = function (el, value) {
        const reduce = window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches;
        if (reduce) { el.textContent = value; return; }
        const t0 = performance.now(), dur = 800;
        (function tick(t) {
            const k = Math.min((t - t0) / dur, 1);
            el.textContent = Math.round(value * k);
            if (k < 1) requestAnimationFrame(tick);
        })(t0);
    };

    OT.renderHeader();
    OT.renderAdminTabs();
    OT.renderFooter();
    document.addEventListener('DOMContentLoaded', OT.addPasswordToggles);
    document.addEventListener('DOMContentLoaded', OT.initReveal);
})();
