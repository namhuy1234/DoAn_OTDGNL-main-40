// Thêm chức năng import đề thi từ file CSV, JSON, Excel, PDF trong modal "Tải đề thi".
(function () {
    const importModal = document.getElementById('importModal');
    const importFile = document.getElementById('importFile');
    const importPreview = document.getElementById('importPreview');
    const importMsg = document.getElementById('importMsg');
    const openImportBtn = document.getElementById('openImportBtn');
    const closeImportModal = document.getElementById('closeImportModal');
    const cancelImport = document.getElementById('cancelImport');
    const startImport = document.getElementById('startImport');

    if (!importModal || !openImportBtn) return;

    const importCodeBox = document.getElementById('importCodeBox');
    const importExamCode = document.getElementById('importExamCode');

    let parsedQuestions = [];
    let laPdf = false;
    let boQuaPdf = 0;

    function setImportMessage(text, type) {
        if (!importMsg) return;
        importMsg.textContent = text;
        importMsg.className = 'mt-3 text-center text-sm font-medium min-h-[20px] ' +
            (type === 'error' ? 'text-red-600' : type === 'success' ? 'text-emerald-600' : 'text-brand-600');
    }

    function openImport() {
        importModal.classList.remove('hidden');
        importModal.classList.add('flex');
    }

    function closeImport() {
        importModal.classList.add('hidden');
        importModal.classList.remove('flex');
        parsedQuestions = [];
        laPdf = false;
        if (importCodeBox) importCodeBox.classList.add('hidden');
        if (importFile) importFile.value = '';
        if (importPreview) importPreview.textContent = 'Chưa có file nào được chọn.';
        if (importMsg) importMsg.textContent = '';
    }

    function findField(raw, name) {
        const key = Object.keys(raw).find(k => k.toLowerCase() === name.toLowerCase());
        return key ? raw[key] : '';
    }

    function normalizeQuestion(raw) {
        return {
            Content: String(findField(raw, 'Content') || '').trim(),
            OptionA: String(findField(raw, 'OptionA') || '').trim(),
            OptionB: String(findField(raw, 'OptionB') || '').trim(),
            OptionC: String(findField(raw, 'OptionC') || '').trim(),
            OptionD: String(findField(raw, 'OptionD') || '').trim(),
            CorrectAnswer: String(findField(raw, 'CorrectAnswer') || '').trim().toUpperCase(),
            SubjectCategory: String(findField(raw, 'SubjectCategory') || 'Khac').trim(),
            Explanation: String(findField(raw, 'Explanation') || '').trim(),        ExamCode: String(findField(raw, 'ExamCode') || '').trim()
        };
    }

    function isValidQuestion(q) {
        return q.Content && q.OptionA && q.OptionB && q.OptionC && q.OptionD &&
            ['A', 'B', 'C', 'D'].includes(q.CorrectAnswer);
    }

    function renderPreview(items) {
        if (!items.length) {
            importPreview.textContent = 'Không có dữ liệu hợp lệ.';
            return;
        }
        const preview = items.slice(0, 5).map((q, i) =>
            '#' + (i + 1) + ': ' + q.Content + ' | Đáp án: ' + q.CorrectAnswer + ' | Môn: ' + q.SubjectCategory
        ).join('\n');
        importPreview.textContent = 'Tổng ' + items.length + ' câu. Xem trước ' + Math.min(5, items.length) + ' câu:\n\n' + preview;
    }

    // Xem trước đề PDF: hiện đủ từng câu để kiểm tra, câu chưa có đáp án thì admin tự chọn.
    function renderPdfPreview() {
        const esc = window.OT.esc;
        importPreview.innerHTML = parsedQuestions.map((q, i) => `
            <div class="py-2 border-b border-slate-200 last:border-0">
                <p class="font-semibold text-slate-800 mb-1">Câu ${q.So}: ${esc(q.Content)}</p>
                <p>A. ${esc(q.OptionA)}</p><p>B. ${esc(q.OptionB)}</p><p>C. ${esc(q.OptionC)}</p><p>D. ${esc(q.OptionD)}</p>
                <label class="inline-flex items-center gap-2 mt-1 font-semibold ${q.CorrectAnswer ? 'text-emerald-700' : 'text-red-600'}">Đáp án đúng:
                    <select data-pdf-answer="${i}" class="px-2 py-1 rounded-lg border border-slate-300 bg-white text-slate-800">
                        ${['', 'A', 'B', 'C', 'D'].map(x => `<option value="${x}"${x === q.CorrectAnswer ? ' selected' : ''}>${x || 'Chọn'}</option>`).join('')}
                    </select>
                </label>
            </div>`).join('');
    }

    function capNhatThongBaoPdf(boQua) {
        const thieu = parsedQuestions.filter(q => !q.CorrectAnswer).length;
        let t = 'Đọc được ' + parsedQuestions.length + ' câu trắc nghiệm.';
        if (thieu) t += ' Còn ' + thieu + ' câu chưa có đáp án, hãy chọn ở phần xem trước; câu thiếu đáp án sẽ không được tải lên.';
        if (boQua) t += ' Bỏ qua ' + boQua + ' câu không đủ 4 đáp án A, B, C, D.';
        setImportMessage(t, thieu ? 'error' : 'success');
    }

    function splitCsvLine(line) {
        const result = [];
        let current = '';
        let inQuotes = false;
        for (let i = 0; i < line.length; i++) {
            const ch = line[i];
            if (ch === '"') {
                if (inQuotes && line[i + 1] === '"') {
                    current += '"';
                    i++;
                } else {
                    inQuotes = !inQuotes;
                }
            } else if (ch === ',' && !inQuotes) {
                result.push(current);
                current = '';
            } else {
                current += ch;
            }
        }
        result.push(current);
        return result.map(x => x.trim());
    }

    function parseCsv(text) {
        const lines = text.replace(/\r\n/g, '\n').replace(/\r/g, '\n').split('\n').filter(l => l.trim() !== '');
        if (lines.length < 2) return [];
        const headers = splitCsvLine(lines[0]);
        const rows = [];
        for (let i = 1; i < lines.length; i++) {
            const cols = splitCsvLine(lines[i]);
            const obj = {};
            headers.forEach((h, idx) => { obj[h] = cols[idx] || ''; });
            rows.push(obj);
        }
        return rows;
    }

    window.openImport = openImport;
    openImportBtn.addEventListener('click', openImport);
    closeImportModal.addEventListener('click', closeImport);
    cancelImport.addEventListener('click', closeImport);
    importModal.addEventListener('click', (e) => { if (e.target === importModal) closeImport(); });

    importFile.addEventListener('change', async (e) => {
        const file = e.target.files[0];
        if (!file) return;
        setImportMessage('Đang đọc file...', 'info');
        try {
            const ext = file.name.split('.').pop().toLowerCase();
            let rawRows = [];
            laPdf = ext === 'pdf';
            importCodeBox.classList.toggle('hidden', !laPdf);
            if (laPdf) {
                const kq = await window.PdfDe.doc(file);
                parsedQuestions = kq.cau;
                boQuaPdf = kq.boQua;
                importExamCode.value = file.name.replace(/\.pdf$/i, '');
                renderPdfPreview();
                capNhatThongBaoPdf(boQuaPdf);
                return;
            }
            if (ext === 'json') {
                const text = await file.text();
                rawRows = JSON.parse(text);
                if (!Array.isArray(rawRows)) throw new Error('File JSON phải là mảng [...]');
            } else if (ext === 'csv') {
                const text = await file.text();
                rawRows = parseCsv(text);
            } else if (ext === 'xlsx' || ext === 'xls') {
                if (!window.XLSX) throw new Error('Chưa tải xong thư viện Excel.');
                const buffer = await file.arrayBuffer();
                const workbook = window.XLSX.read(buffer);
                const sheetName = workbook.SheetNames[0];
                rawRows = window.XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);
            } else {
                throw new Error('Chỉ hỗ trợ CSV, JSON, XLSX, XLS, PDF.');
            }

            parsedQuestions = rawRows.map(normalizeQuestion);
            renderPreview(parsedQuestions);
            const validCount = parsedQuestions.filter(isValidQuestion).length;
            setImportMessage('Đã đọc ' + parsedQuestions.length + ' câu, hợp lệ ' + validCount + ' câu.', validCount > 0 ? 'success' : 'error');
        } catch (err) {
            parsedQuestions = [];
            importPreview.textContent = 'Không đọc được file.';
            setImportMessage(err.message || 'Đọc file thất bại.', 'error');
        }
    });

    importPreview.addEventListener('change', (e) => {
        const i = e.target.getAttribute && e.target.getAttribute('data-pdf-answer');
        if (i === null || i === undefined) return;
        parsedQuestions[+i].CorrectAnswer = e.target.value;
        renderPdfPreview();
        capNhatThongBaoPdf(boQuaPdf);
    });

    startImport.addEventListener('click', async () => {
        if (!parsedQuestions.length) {
            setImportMessage('Chưa có dữ liệu để tải lên.', 'error');
            return;
        }

        const importSubjectSelect = document.getElementById("importSubject");
        const selectedSubject = importSubjectSelect ? importSubjectSelect.value.trim() : "";
        if (laPdf && !selectedSubject) {
            setImportMessage('File PDF không có thông tin môn, hãy chọn môn áp dụng.', 'error');
            return;
        }
        if (laPdf && !importExamCode.value.trim()) {
            setImportMessage('Hãy nhập mã đề cho file PDF.', 'error');
            return;
        }
        const sourceQuestions = parsedQuestions.map(q => {
            const { So, ...cau } = q;
            if (selectedSubject) cau.SubjectCategory = selectedSubject;
            if (laPdf) cau.ExamCode = importExamCode.value.trim();
            return cau;
        });
        const validQuestions = sourceQuestions.filter(isValidQuestion);
        if (!validQuestions.length) {
            setImportMessage('Không có câu hỏi hợp lệ để tải lên.', 'error');
            return;
        }

        const user = JSON.parse(localStorage.getItem('user') || '{}');
        const token = user.AccessToken;
        if (!token) {
            alert('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
            window.location.href = 'login.html';
            return;
        }

        setImportMessage('Đang tải lên ' + validQuestions.length + ' câu hỏi...', 'info');
        let success = 0;
        let fail = 0;
        for (const q of validQuestions) {
            try {
                const res = await fetch('http://localhost:8000/api/Questions', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + token
                    },
                    body: JSON.stringify(q)
                });
                if (!res.ok) throw new Error(await res.text());
                success++;
            } catch (err) {
                fail++;
            }
        }
        setImportMessage('Hoàn tất: ' + success + ' thành công, ' + fail + ' thất bại.', fail ? 'error' : 'success');
        if (typeof window.loadQuestions === 'function') window.loadQuestions();
    });
})();
