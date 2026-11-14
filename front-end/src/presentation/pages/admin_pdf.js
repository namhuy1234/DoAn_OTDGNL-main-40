// Đọc đề thi từ file PDF: lấy chữ bằng PDF.js rồi tách câu hỏi, 4 đáp án, đáp án đúng và lời giải.
// Chỉ đọc được PDF có lớp chữ; PDF dạng ảnh scan không có chữ nên sẽ báo lỗi. Không đoán đáp án.
(function () {
    const CAU = /^\s*(?:Câu|Question|Bài)\s*(\d{1,3})\s*[:.)\-–]?\s*/iu;
    const CAU_SO = /^\s*(\d{1,3})\s*[.)]\s+/;
    const SO_MUC = /^\s*(?:PHẦN\s+)?[IVX\d]+\s*[.:)\-–]\s*/iu;
    const DAU_DAP_AN = /^\s*(?:(?:PHẦN\s+)?[IVX\d]+\s*[.:)\-–]\s*)?(?:BẢNG\s+)?(?:ĐÁP\s*ÁN|HƯỚNG\s+DẪN\s+CHẤM|ANSWER\s*KEY|ANSWERS?)\b.{0,40}$/iu;
    const DA_MOT_CAU = /^\s*Đáp án(?: đúng)?\s*[:.]?\s*[A-D]\b/iu;
    const RAC = /^\s*(?:Trang\s*\d+(?:\s*\/\s*\d+)?|Page\s*\d+(?:\s*(?:\/|of)\s*\d+)?|\d+\s*\/\s*\d+|\d{1,3}|[-–—\s]*HẾT[-–—\s]*)\s*$/iu;

    // Ghép các mảnh chữ của một trang thành từng dòng theo tọa độ.
    function ghepDong(items) {
        const dong = [];
        items.filter(it => it.str && it.str.trim()).forEach(it => {
            const y = it.transform[5], x = it.transform[4];
            let d = dong.find(l => Math.abs(l.y - y) < 3);
            if (!d) { d = { y, parts: [] }; dong.push(d); }
            d.parts.push({ x, s: it.str, w: it.width || 0 });
        });
        return dong.sort((a, b) => b.y - a.y).map(d => {
            d.parts.sort((a, b) => a.x - b.x);
            let s = '', het = null;
            d.parts.forEach(p => {
                if (het !== null && p.x - het > 1.5 && !s.endsWith(' ') && !p.s.startsWith(' ')) s += ' ';
                s += p.s; het = p.x + p.w;
            });
            return s.normalize('NFC').replace(/\s+/g, ' ').trim();
        });
    }

    async function docChu(file) {
        if (!window.pdfjsLib) throw new Error('Chưa tải được thư viện đọc PDF. Kiểm tra kết nối Internet.');
        window.pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
        const pdf = await window.pdfjsLib.getDocument({ data: await file.arrayBuffer() }).promise;
        let dong = [];
        for (let i = 1; i <= pdf.numPages; i++) {
            const page = await pdf.getPage(i);
            dong = dong.concat(ghepDong((await page.getTextContent()).items));
        }
        return dong;
    }

    // Tìm A, B, C, D theo đúng thứ tự, nằm đầu chuỗi hoặc sau khoảng trắng; có thể có dấu * đánh dấu đáp án đúng.
    function tachDapAn(than) {
        const vt = [];
        let tu = 0;
        for (const chu of ['A', 'B', 'C', 'D']) {
            const re = new RegExp('(^|\\s)(\\*?)' + chu + '\\s*[.)]\\s*(\\*?)', 'g');
            re.lastIndex = tu;
            const m = re.exec(than);
            if (!m) return null;
            const dau = m.index + m[1].length;
            vt.push({ chu, dau, sau: dau + m[0].length - m[1].length, sao: !!(m[2] || m[3]) });
            tu = dau + m[0].length - m[1].length;
        }
        const out = { noiDung: than.slice(0, vt[0].dau).trim(), danhDau: '' };
        vt.forEach((v, i) => {
            out['Option' + v.chu] = than.slice(v.sau, i < 3 ? vt[i + 1].dau : undefined).trim();
            if (v.sao) out.danhDau = v.chu;
        });
        return out;
    }

    // Đọc bảng đáp án theo từng dòng, dừng khi sang phần Đúng/Sai hoặc tự luận vì các phần đó đánh số lại từ 1.
    function docBangDapAn(dong) {
        const bang = {};
        const ghi = (so, chu) => { if (!bang[so]) bang[so] = chu; };
        for (let i = 0; i < dong.length; i++) {
            if (/^\s*(?:PHẦN\s+)?(?:II|III|IV|V|2|3|4)\s*[.:)\-–]\s*\S/iu.test(dong[i])) break;
            // Dạng hai hàng: một dòng toàn số câu, dòng dưới toàn chữ đáp án
            const dongDuoi = dong[i + 1] || '';
            if (/^[\d\s|]+$/.test(dong[i]) && /^[A-D\s|]+$/.test(dongDuoi)) {
                const so = dong[i].match(/\d+/g), da = dongDuoi.match(/[A-D]/g);
                if (so.length === da.length) { so.forEach((n, k) => ghi(+n, da[k])); i++; continue; }
            }
            // Dạng từng cặp: "1.A 2-B", "Câu 3: C", "1 B 11 D"
            const re = /(?:[Cc]âu\s*)?(\d{1,3})\s*[.:\-–)]?\s*([A-D])(?![\p{L}\d])/gu;
            let m;
            while ((m = re.exec(dong[i]))) ghi(+m[1], m[2]);
        }
        return bang;
    }

    // Dòng lặp lại nhiều lần mà không phải câu hỏi hay đáp án thường là đầu trang, chân trang.
    function boDongLap(dong) {
        const dem = {};
        dong.forEach(d => { dem[d] = (dem[d] || 0) + 1; });
        return dong.filter(d => dem[d] < 2 || CAU.test(d) || /^\*?[A-D]\s*[.)]/.test(d) || d.match(/^\d/));
    }

    // Tách danh sách dòng thành câu hỏi. Trả về các câu đủ 4 đáp án và số câu bị bỏ qua.
    function tachCauHoi(dong) {
        dong = boDongLap(dong.filter(d => !RAC.test(d)));
        // "Đáp án: B" ngay dưới một câu không phải là tiêu đề bảng đáp án
        const iKey = dong.findIndex(d => DAU_DAP_AN.test(d) && !DA_MOT_CAU.test(d));
        // Bỏ số mục ở tiêu đề ("IV. ĐÁP ÁN") để không bị hiểu là đã sang phần khác
        const bang = iKey >= 0 ? docBangDapAn([dong[iKey].replace(SO_MUC, '')].concat(dong.slice(iKey + 1))) : {};
        const than = iKey >= 0 ? dong.slice(0, iKey) : dong;

        const coCau = than.some(d => CAU.test(d));
        const mau = coCau ? CAU : CAU_SO;
        const khoi = [];
        let hien = null;
        than.forEach(d => {
            const m = d.match(mau);
            if (m) {
                hien = { so: +m[1], dong: [d.slice(m[0].length)] };
                khoi.push(hien);
            } else if (/^\s*(?:PHẦN\s+[IVX\d]+|[IVX]+\s*[.:)\-–]\s+\S)/u.test(d)) {
                hien = null;   // sang phần khác của đề, dòng tiêu đề không thuộc câu trước
            } else if (hien) {
                hien.dong.push(d);
            }
        });

        const cau = [];
        let boQua = 0;
        khoi.forEach(k => {
            let t = k.dong.join(' ').replace(/\s+/g, ' ').trim();
            let giai = '';
            const g = t.match(/\s(?:Lời giải|Giải thích|Hướng dẫn giải)\s*[:.]\s*(.*)$/iu);
            if (g) { giai = g[1].trim(); t = t.slice(0, g.index); }
            let dung = '';
            const da = t.match(/\s(?:Đáp án(?: đúng)?|ĐA|Chọn)\s*[:.]?\s*([A-D])\b[.\s]*$/iu);
            if (da) { dung = da[1].toUpperCase(); t = t.slice(0, da.index); }
            const o = tachDapAn(t);
            if (!o || !o.noiDung || !o.OptionA || !o.OptionB || !o.OptionC || !o.OptionD) { boQua++; return; }
            cau.push({
                So: k.so, Content: o.noiDung, OptionA: o.OptionA, OptionB: o.OptionB, OptionC: o.OptionC, OptionD: o.OptionD,
                CorrectAnswer: dung || o.danhDau || bang[k.so] || '', Explanation: giai, SubjectCategory: '', ExamCode: ''
            });
        });
        return { cau, boQua };
    }

    window.PdfDe = {
        async doc(file) {
            const dong = await docChu(file);
            if (!dong.join('').trim()) throw new Error('PDF này không có lớp chữ (có thể là ảnh scan) nên chưa đọc được. Hãy dùng PDF xuất từ Word hoặc file Excel.');
            const kq = tachCauHoi(dong);
            if (!kq.cau.length) throw new Error('Không tìm thấy câu hỏi. Đề cần có dạng "Câu 1: ..." và 4 đáp án A. B. C. D.');
            return kq;
        }
    };
})();
