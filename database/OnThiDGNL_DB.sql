-- Script tao CSDL OnThiDGNL_DB (SQL Server) + du lieu mau de chay thu / chup anh bao cao.
-- Chay: sqlcmd -S .\SQLEXPRESS -E -C -f 65001 -i database\OnThiDGNL_DB.sql
IF DB_ID(N'OnThiDGNL_DB') IS NULL CREATE DATABASE OnThiDGNL_DB;
GO
-- SQL Server Express mac dinh bat AUTO_CLOSE: CSDL tu dong dong khi ranh, lan ket noi dau tien
-- sau do co the bi qua thoi gian (loi 258, API tra HTTP 500). Tat AUTO_CLOSE de tranh loi nay.
ALTER DATABASE OnThiDGNL_DB SET AUTO_CLOSE OFF;
GO
USE OnThiDGNL_DB;
GO
IF OBJECT_ID(N'dbo.Questions') IS NOT NULL DROP TABLE dbo.Questions;
IF OBJECT_ID(N'dbo.Users') IS NOT NULL DROP TABLE dbo.Users;
GO
CREATE TABLE dbo.Users (
    Id       INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(200) NOT NULL,
    Role     NVARCHAR(20)  NOT NULL DEFAULT N'Student',
    FullName NVARCHAR(200) NULL
);
CREATE TABLE dbo.Questions (
    Id              INT IDENTITY(1,1) PRIMARY KEY,
    Content         NVARCHAR(MAX) NOT NULL,
    OptionA         NVARCHAR(500) NOT NULL,
    OptionB         NVARCHAR(500) NOT NULL,
    OptionC         NVARCHAR(500) NOT NULL,
    OptionD         NVARCHAR(500) NOT NULL,
    CorrectAnswer   NVARCHAR(10)  NOT NULL,
    SubjectCategory NVARCHAR(100) NOT NULL,
    Explanation     NVARCHAR(MAX) NULL,
    ExamCode        NVARCHAR(100) NULL
);
CREATE INDEX IX_Questions_Subject_Exam ON dbo.Questions (SubjectCategory, ExamCode);
GO
INSERT INTO dbo.Users (Username, Password, Role, FullName) VALUES
 (N'admin',   N'Admin@123', N'Admin',   N'Quản trị viên'),
 (N'hocsinh', N'Hoc@1234',  N'Student', N'Nguyễn Văn An');
GO
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
-- TOAN
(N'Giá trị của biểu thức 2^3 + 3^2 bằng bao nhiêu?',N'13',N'15',N'17',N'19',N'C',N'Toán',N'2^3 = 8, 3^2 = 9 nên tổng là 17.',N'ĐỀ-01'),
(N'Đạo hàm của hàm số y = x^2 là:',N'x',N'2x',N'x^2',N'2',N'B',N'Toán',N'Áp dụng (x^n)'' = n·x^(n-1) nên (x^2)'' = 2x.',N'ĐỀ-01'),
(N'Nghiệm của phương trình 2x - 6 = 0 là:',N'x = 2',N'x = 3',N'x = 6',N'x = -3',N'B',N'Toán',N'2x = 6 suy ra x = 3.',N'ĐỀ-01'),
(N'Tổng ba góc trong một tam giác bằng:',N'90 độ',N'180 độ',N'270 độ',N'360 độ',N'B',N'Toán',N'Tổng ba góc trong của tam giác luôn bằng 180 độ.',N'ĐỀ-01'),
(N'Giá trị của log₂ 8 là:',N'2',N'3',N'4',N'8',N'B',N'Toán',N'2^3 = 8 nên log₂ 8 = 3.',N'ĐỀ-02'),
(N'Diện tích hình tròn bán kính R là:',N'2πR',N'πR²',N'πR',N'2πR²',N'B',N'Toán',N'Công thức diện tích hình tròn: S = πR².',N'ĐỀ-02'),
-- NGU VAN
(N'Tác giả của tác phẩm "Truyện Kiều" là ai?',N'Nguyễn Trãi',N'Nguyễn Du',N'Hồ Xuân Hương',N'Nguyễn Khuyến',N'B',N'Ngữ văn',N'"Truyện Kiều" là kiệt tác của đại thi hào Nguyễn Du.',N'ĐỀ-01'),
(N'Biện pháp tu từ trong câu "Thân em như tấm lụa đào" là:',N'Nhân hóa',N'Hoán dụ',N'So sánh',N'Điệp ngữ',N'C',N'Ngữ văn',N'Có từ so sánh "như" nên đây là biện pháp so sánh.',N'ĐỀ-01'),
(N'Tác phẩm "Chí Phèo" thuộc thể loại nào?',N'Thơ',N'Truyện ngắn',N'Kịch',N'Ký',N'B',N'Ngữ văn',N'"Chí Phèo" là truyện ngắn hiện thực của Nam Cao.',N'ĐỀ-01'),
(N'Tác giả của bài thơ "Tây Tiến" là:',N'Quang Dũng',N'Tố Hữu',N'Chế Lan Viên',N'Xuân Diệu',N'A',N'Ngữ văn',N'"Tây Tiến" được Quang Dũng sáng tác năm 1948.',N'ĐỀ-01'),
-- TIENG ANH
(N'She ___ to school every day.',N'go',N'goes',N'going',N'gone',N'B',N'Tiếng Anh',N'Chủ ngữ ngôi thứ ba số ít ở thì hiện tại đơn dùng động từ thêm -es: goes.',N'ĐỀ-01'),
(N'Choose the word closest in meaning to "big":',N'small',N'tiny',N'large',N'short',N'C',N'Tiếng Anh',N'"large" đồng nghĩa với "big".',N'ĐỀ-01'),
(N'If I ___ rich, I would travel the world.',N'am',N'was',N'were',N'be',N'C',N'Tiếng Anh',N'Câu điều kiện loại 2 dùng "were" cho mọi ngôi.',N'ĐỀ-01'),
(N'He has lived here ___ 2015.',N'for',N'since',N'in',N'at',N'B',N'Tiếng Anh',N'"since" đi với mốc thời gian cụ thể trong thì hiện tại hoàn thành.',N'ĐỀ-01'),
-- VAT LY
(N'Đơn vị của lực trong hệ SI là:',N'Jun (J)',N'Oát (W)',N'Niutơn (N)',N'Pascal (Pa)',N'C',N'Vật lý',N'Lực được đo bằng Niutơn (N).',N'ĐỀ-01'),
(N'Công thức tính vận tốc của chuyển động thẳng đều là:',N'v = s·t',N'v = s/t',N'v = t/s',N'v = s + t',N'B',N'Vật lý',N'Vận tốc bằng quãng đường chia thời gian.',N'ĐỀ-01'),
(N'Gia tốc rơi tự do gần mặt đất xấp xỉ bằng:',N'9,8 m/s²',N'8,9 m/s²',N'10,8 m/s²',N'6,7 m/s²',N'A',N'Vật lý',N'Giá trị g ≈ 9,8 m/s².',N'ĐỀ-01'),
(N'Định luật Ôm cho đoạn mạch cho biết:',N'U = I·R',N'U = I/R',N'I = U·R',N'R = U·I',N'A',N'Vật lý',N'Hiệu điện thế bằng cường độ dòng điện nhân điện trở.',N'ĐỀ-01'),
-- HOA HOC
(N'Công thức hóa học của nước là:',N'CO₂',N'H₂O',N'O₂',N'NaCl',N'B',N'Hóa học',N'Nước gồm 2 nguyên tử hiđro và 1 nguyên tử oxi.',N'ĐỀ-01'),
(N'Kim loại nào sau đây ở thể lỏng ở điều kiện thường?',N'Sắt',N'Đồng',N'Thủy ngân',N'Nhôm',N'C',N'Hóa học',N'Thủy ngân (Hg) là kim loại duy nhất ở thể lỏng ở điều kiện thường.',N'ĐỀ-01'),
(N'Số hiệu nguyên tử của cacbon là:',N'4',N'6',N'8',N'12',N'B',N'Hóa học',N'Cacbon có Z = 6.',N'ĐỀ-01'),
(N'Dung dịch có pH < 7 là dung dịch:',N'Bazơ',N'Trung tính',N'Axit',N'Muối',N'C',N'Hóa học',N'pH nhỏ hơn 7 là môi trường axit.',N'ĐỀ-01'),
-- DIA LY
(N'Thủ đô của Việt Nam là:',N'Đà Nẵng',N'Hà Nội',N'TP. Hồ Chí Minh',N'Huế',N'B',N'Địa lý',N'Hà Nội là thủ đô của nước Cộng hòa Xã hội Chủ nghĩa Việt Nam.',N'ĐỀ-01'),
(N'Dãy núi cao nhất Việt Nam là:',N'Trường Sơn',N'Hoàng Liên Sơn',N'Bạch Mã',N'Tam Đảo',N'B',N'Địa lý',N'Hoàng Liên Sơn có đỉnh Phan-xi-păng cao 3143 m.',N'ĐỀ-01'),
(N'Đỉnh núi cao nhất Việt Nam là:',N'Phan-xi-păng',N'Ngọc Linh',N'Lang Biang',N'Bà Đen',N'A',N'Địa lý',N'Phan-xi-păng (3143 m) là đỉnh cao nhất Việt Nam.',N'ĐỀ-01'),
(N'Việt Nam nằm ở khu vực nào của châu Á?',N'Đông Bắc Á',N'Nam Á',N'Đông Nam Á',N'Tây Á',N'C',N'Địa lý',N'Việt Nam thuộc khu vực Đông Nam Á.',N'ĐỀ-01'),
-- LICH SU
(N'Chiến thắng Điện Biên Phủ diễn ra vào năm nào?',N'1945',N'1954',N'1975',N'1968',N'B',N'Lịch sử',N'Chiến thắng Điện Biên Phủ kết thúc ngày 7/5/1954.',N'ĐỀ-01'),
(N'Ai là người đọc Tuyên ngôn Độc lập ngày 2/9/1945?',N'Võ Nguyên Giáp',N'Hồ Chí Minh',N'Trường Chinh',N'Phạm Văn Đồng',N'B',N'Lịch sử',N'Chủ tịch Hồ Chí Minh đọc Tuyên ngôn Độc lập tại Quảng trường Ba Đình.',N'ĐỀ-01'),
(N'Triều đại phong kiến cuối cùng của Việt Nam là:',N'Nhà Lê',N'Nhà Trần',N'Nhà Nguyễn',N'Nhà Lý',N'C',N'Lịch sử',N'Nhà Nguyễn (1802–1945) là triều đại cuối cùng.',N'ĐỀ-01'),
(N'Chiến dịch Hồ Chí Minh kết thúc vào ngày:',N'30/4/1975',N'2/9/1945',N'7/5/1954',N'19/8/1945',N'A',N'Lịch sử',N'Ngày 30/4/1975 miền Nam hoàn toàn giải phóng.',N'ĐỀ-01');
GO
SELECT COUNT(*) AS SoCauHoi FROM dbo.Questions;
SELECT Id, Username, Role FROM dbo.Users;
GO
