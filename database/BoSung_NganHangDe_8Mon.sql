-- Bo sung ngan hang de cho 8 mon (moi mon 4 bo de: 3 bo 12 cau + 1 bo chuyen de 20 cau = 56 cau).
-- Chay SAU OnThiDGNL_DB.sql:  sqlcmd -S .\SQLEXPRESS -E -C -f 65001 -i database\BoSung_NganHangDe_8Mon.sql
-- Moi bo de chi duoc them neu ExamCode chua co, nen chay lai nhieu lan khong bi trung du lieu.
USE OnThiDGNL_DB;
SET NOCOUNT ON;
GO
-- Toán: TOAN-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TOAN-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Tập xác định của hàm số y = √(x − 2) là:',N'ℝ',N'(2; +∞)',N'(−∞; 2]',N'[2; +∞)',N'D',N'Toán',N'Điều kiện x − 2 ≥ 0 ⇔ x ≥ 2.',N'TOAN-DE01'),
(N'Nghiệm của phương trình x² − 5x + 6 = 0 là:',N'x = −1; x = 6',N'x = 2; x = 3',N'x = −2; x = −3',N'x = 1; x = 6',N'B',N'Toán',N'Phân tích (x − 2)(x − 3) = 0.',N'TOAN-DE01'),
(N'Hoành độ đỉnh của parabol y = x² − 4x + 1 là:',N'2',N'−2',N'4',N'−4',N'A',N'Toán',N'x = −b/(2a) = 4/2 = 2.',N'TOAN-DE01'),
(N'Hàm số y = 2x + 3:',N'Nghịch biến trên ℝ',N'Là hàm hằng',N'Đồng biến trên ℝ',N'Chỉ đồng biến trên (0; +∞)',N'C',N'Toán',N'Hệ số a = 2 > 0 nên hàm bậc nhất đồng biến trên ℝ.',N'TOAN-DE01'),
(N'Tập nghiệm của bất phương trình 3x − 6 > 0 là:',N'x ≥ 2',N'x < 2',N'x > −2',N'x > 2',N'D',N'Toán',N'3x > 6 ⇔ x > 2.',N'TOAN-DE01'),
(N'Giá trị của biểu thức |−7| + |3| bằng:',N'−4',N'−10',N'4',N'10',N'D',N'Toán',N'|−7| = 7, |3| = 3 nên tổng bằng 10.',N'TOAN-DE01'),
(N'Hệ phương trình x + y = 5 và x − y = 1 có nghiệm (x; y) là:',N'(1; 4)',N'(2; 3)',N'(3; 2)',N'(4; 1)',N'C',N'Toán',N'Cộng hai phương trình được 2x = 6 nên x = 3, y = 2.',N'TOAN-DE01'),
(N'Đạo hàm của hàm số y = x³ là:',N'y'' = 3x²',N'y'' = 3x',N'y'' = x²',N'y'' = 3x³',N'A',N'Toán',N'Áp dụng (xⁿ)'' = n·xⁿ⁻¹.',N'TOAN-DE01'),
(N'Hàm số y = x³ − 3x có bao nhiêu điểm cực trị?',N'1',N'0',N'2',N'3',N'C',N'Toán',N'y'' = 3x² − 3 = 0 ⇔ x = ±1, y'' đổi dấu qua cả hai nghiệm.',N'TOAN-DE01'),
(N'Giá trị lớn nhất của hàm số y = −x² + 2x + 3 là:',N'2',N'5',N'3',N'4',N'D',N'Toán',N'Đỉnh tại x = 1, y(1) = −1 + 2 + 3 = 4; a < 0 nên đây là giá trị lớn nhất.',N'TOAN-DE01'),
(N'Nghiệm của phương trình 2ˣ = 8 là:',N'x = 2',N'x = 3',N'x = 4',N'x = 8',N'B',N'Toán',N'8 = 2³ nên x = 3.',N'TOAN-DE01'),
(N'Giá trị của log₁₀ 1000 là:',N'2',N'3',N'100',N'10',N'B',N'Toán',N'10³ = 1000 nên log₁₀ 1000 = 3.',N'TOAN-DE01');
GO
-- Toán: TOAN-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TOAN-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Giá trị của sin 30° là:',N'1',N'1/2',N'√3/2',N'√2/2',N'B',N'Toán',N'Giá trị lượng giác đặc biệt: sin 30° = 1/2.',N'TOAN-DE02'),
(N'Giá trị của cos 60° là:',N'1/2',N'1',N'√3/2',N'0',N'A',N'Toán',N'Giá trị lượng giác đặc biệt: cos 60° = 1/2.',N'TOAN-DE02'),
(N'Tam giác vuông có hai cạnh góc vuông dài 3 cm và 4 cm. Cạnh huyền dài:',N'25 cm',N'7 cm',N'5 cm',N'6 cm',N'C',N'Toán',N'Định lí Py-ta-go: √(3² + 4²) = √25 = 5.',N'TOAN-DE02'),
(N'Diện tích tam giác có đáy 10 cm và chiều cao tương ứng 6 cm là:',N'16 cm²',N'60 cm²',N'15 cm²',N'30 cm²',N'D',N'Toán',N'S = ½ · 10 · 6 = 30 cm².',N'TOAN-DE02'),
(N'Thể tích khối lập phương cạnh 3 cm là:',N'27 cm³',N'18 cm³',N'81 cm³',N'9 cm³',N'A',N'Toán',N'V = a³ = 3³ = 27 cm³.',N'TOAN-DE02'),
(N'Thể tích khối cầu bán kính R là:',N'(1/3)πR³',N'(4/3)πR³',N'4πR²',N'πR³',N'B',N'Toán',N'Công thức thể tích khối cầu V = (4/3)πR³; 4πR² là diện tích mặt cầu.',N'TOAN-DE02'),
(N'Khoảng cách giữa hai điểm A(1; 2) và B(4; 6) là:',N'7',N'5',N'√7',N'25',N'B',N'Toán',N'AB = √((4 − 1)² + (6 − 2)²) = √(9 + 16) = 5.',N'TOAN-DE02'),
(N'Hệ số góc của đường thẳng y = 2x + 1 là:',N'−2',N'1',N'1/2',N'2',N'D',N'Toán',N'Đường thẳng y = ax + b có hệ số góc a = 2.',N'TOAN-DE02'),
(N'Phương trình đường tròn tâm O(0; 0), bán kính 3 là:',N'x² + y² = 9',N'x² + y² = 6',N'x² + y² = 3',N'(x − 3)² + y² = 9',N'A',N'Toán',N'Đường tròn tâm (0; 0) bán kính R có phương trình x² + y² = R² = 9.',N'TOAN-DE02'),
(N'Giá trị của tan 45° là:',N'Không xác định',N'√3',N'1',N'0',N'C',N'Toán',N'tan 45° = sin 45°/cos 45° = 1.',N'TOAN-DE02'),
(N'Tổng các góc trong của một tứ giác lồi bằng:',N'360°',N'270°',N'540°',N'180°',N'A',N'Toán',N'Tứ giác chia được thành hai tam giác nên tổng các góc là 2 · 180° = 360°.',N'TOAN-DE02'),
(N'Thể tích khối trụ có bán kính đáy r và chiều cao h là:',N'πrh',N'πr²h',N'2πrh',N'(1/3)πr²h',N'B',N'Toán',N'V = diện tích đáy × chiều cao = πr²h; (1/3)πr²h là thể tích khối nón.',N'TOAN-DE02');
GO
-- Toán: TOAN-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TOAN-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Gieo một đồng xu cân đối một lần. Xác suất xuất hiện mặt sấp là:',N'1',N'1/4',N'1/2',N'1/3',N'C',N'Toán',N'Có 2 kết quả đồng khả năng, 1 kết quả thuận lợi.',N'TOAN-DE03'),
(N'Gieo một con xúc xắc cân đối một lần. Xác suất được mặt có số chấm chẵn là:',N'1/2',N'2/3',N'1/6',N'1/3',N'A',N'Toán',N'Có 3 mặt chẵn (2, 4, 6) trên 6 mặt.',N'TOAN-DE03'),
(N'Số cách xếp 4 bạn vào 4 ghế kê thành hàng ngang là:',N'24',N'4',N'16',N'12',N'A',N'Toán',N'Số hoán vị của 4 phần tử: 4! = 24.',N'TOAN-DE03'),
(N'Số tổ hợp chập 2 của 5 phần tử C(5, 2) bằng:',N'20',N'5',N'10',N'25',N'C',N'Toán',N'C(5, 2) = 5!/(2!·3!) = 10.',N'TOAN-DE03'),
(N'Trung bình cộng của các số 2, 4, 6, 8 là:',N'20',N'4',N'6',N'5',N'D',N'Toán',N'(2 + 4 + 6 + 8)/4 = 20/4 = 5.',N'TOAN-DE03'),
(N'Trung vị của mẫu số liệu 3, 7, 1, 9, 5 là:',N'7',N'9',N'5',N'3',N'C',N'Toán',N'Sắp xếp tăng dần 1, 3, 5, 7, 9; số đứng giữa là 5.',N'TOAN-DE03'),
(N'Cấp số cộng 2, 5, 8, … có công sai bằng:',N'5',N'1,5',N'2',N'3',N'D',N'Toán',N'd = 5 − 2 = 3.',N'TOAN-DE03'),
(N'Cấp số cộng có u₁ = 1, công sai d = 2. Số hạng u₁₀ bằng:',N'21',N'17',N'20',N'19',N'D',N'Toán',N'u₁₀ = u₁ + 9d = 1 + 18 = 19.',N'TOAN-DE03'),
(N'Cấp số nhân 3, 6, 12, … có công bội bằng:',N'3',N'2',N'6',N'1/2',N'B',N'Toán',N'q = 6/3 = 2.',N'TOAN-DE03'),
(N'Tổng 1 + 2 + 3 + … + 100 bằng:',N'5050',N'10100',N'5000',N'5100',N'A',N'Toán',N'Tổng n số tự nhiên đầu tiên: n(n + 1)/2 = 100 · 101/2 = 5050.',N'TOAN-DE03'),
(N'Mốt của mẫu số liệu 2, 3, 3, 5, 3, 7 là:',N'7',N'5',N'2',N'3',N'D',N'Toán',N'Giá trị 3 xuất hiện nhiều nhất (3 lần).',N'TOAN-DE03'),
(N'Rút ngẫu nhiên 1 lá từ bộ bài tây 52 lá. Xác suất rút được lá Át là:',N'1/52',N'1/4',N'1/13',N'4/13',N'C',N'Toán',N'Có 4 lá Át: 4/52 = 1/13.',N'TOAN-DE03');
GO
-- Toán: TOAN-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TOAN-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'25% của 80 là:',N'25',N'20',N'40',N'32',N'B',N'Toán',N'80 × 0,25 = 20.',N'TOAN-CD20'),
(N'Một chiếc áo giá 200 000 đồng được giảm 15%. Giá sau khi giảm là:',N'185 000 đồng',N'170 000 đồng',N'175 000 đồng',N'150 000 đồng',N'B',N'Toán',N'200 000 × (1 − 0,15) = 170 000 đồng.',N'TOAN-CD20'),
(N'Giá một mặt hàng tăng từ 50 nghìn lên 60 nghìn đồng. Giá đã tăng:',N'20%',N'10%',N'25%',N'16,7%',N'A',N'Toán',N'(60 − 50)/50 = 0,2 = 20%.',N'TOAN-CD20'),
(N'Ô tô đi 120 km trong 2 giờ. Vận tốc trung bình của ô tô là:',N'60 km/h',N'80 km/h',N'240 km/h',N'40 km/h',N'A',N'Toán',N'v = s/t = 120/2 = 60 km/h.',N'TOAN-CD20'),
(N'Hai số có tỉ số 3 : 5 và tổng bằng 40. Số lớn là:',N'25',N'15',N'24',N'30',N'A',N'Toán',N'Tổng số phần 8; mỗi phần 40/8 = 5; số lớn 5 × 5 = 25.',N'TOAN-CD20'),
(N'Gửi 10 triệu đồng với lãi đơn 6%/năm. Tiền lãi sau 2 năm là:',N'0,6 triệu đồng',N'1,2 triệu đồng',N'12 triệu đồng',N'1,236 triệu đồng',N'B',N'Toán',N'Lãi đơn: 10 × 0,06 × 2 = 1,2 triệu đồng.',N'TOAN-CD20'),
(N'Gửi 10 triệu đồng với lãi kép 10%/năm. Tổng số tiền sau 2 năm là:',N'11 triệu đồng',N'12,5 triệu đồng',N'12 triệu đồng',N'12,1 triệu đồng',N'D',N'Toán',N'10 × 1,1² = 12,1 triệu đồng.',N'TOAN-CD20'),
(N'3 công nhân làm xong một công việc trong 6 ngày. Với năng suất như nhau, 6 công nhân làm xong trong:',N'9 ngày',N'2 ngày',N'12 ngày',N'3 ngày',N'D',N'Toán',N'Số người và thời gian tỉ lệ nghịch: 3 × 6 / 6 = 3 ngày.',N'TOAN-CD20'),
(N'2,5 giờ bằng bao nhiêu phút?',N'90 phút',N'150 phút',N'250 phút',N'125 phút',N'B',N'Toán',N'2,5 × 60 = 150 phút.',N'TOAN-CD20'),
(N'Trên bản đồ tỉ lệ 1 : 100 000, đoạn 3 cm ứng với độ dài thực tế:',N'300 m',N'3 km',N'30 km',N'0,3 km',N'B',N'Toán',N'3 × 100 000 = 300 000 cm = 3 km.',N'TOAN-CD20'),
(N'Số tiếp theo của dãy 1, 4, 9, 16, … là:',N'36',N'25',N'20',N'24',N'B',N'Toán',N'Dãy các số chính phương 1², 2², 3², 4², 5² = 25.',N'TOAN-CD20'),
(N'Số tiếp theo của dãy 2, 6, 18, 54, … là:',N'108',N'162',N'216',N'72',N'B',N'Toán',N'Mỗi số gấp 3 lần số trước: 54 × 3 = 162.',N'TOAN-CD20'),
(N'Điểm ba bài kiểm tra là 7, 8 và x, điểm trung bình bằng 8. Giá trị của x là:',N'9',N'10',N'7',N'8',N'A',N'Toán',N'7 + 8 + x = 24 nên x = 9.',N'TOAN-CD20'),
(N'Một lớp có 40 học sinh, trong đó 60% là nữ. Số học sinh nam là:',N'20',N'24',N'16',N'14',N'C',N'Toán',N'Nam chiếm 40%: 40 × 0,4 = 16.',N'TOAN-CD20'),
(N'Hai xe đi ngược chiều từ hai địa điểm cách nhau 150 km với vận tốc 40 km/h và 35 km/h. Hai xe gặp nhau sau:',N'2,5 giờ',N'1,5 giờ',N'3 giờ',N'2 giờ',N'D',N'Toán',N't = 150/(40 + 35) = 2 giờ.',N'TOAN-CD20'),
(N'Chu vi hình chữ nhật có chiều dài 8 cm, chiều rộng 5 cm là:',N'26 cm',N'13 cm',N'30 cm',N'40 cm',N'A',N'Toán',N'P = 2(8 + 5) = 26 cm.',N'TOAN-CD20'),
(N'Một bể chứa 50 m³ nước, vòi chảy vào 5 m³ mỗi giờ. Bể đầy sau:',N'25 giờ',N'250 giờ',N'10 giờ',N'5 giờ',N'C',N'Toán',N'50/5 = 10 giờ.',N'TOAN-CD20'),
(N'5 quyển vở giá 35 000 đồng. Mua 8 quyển như vậy hết:',N'56 000 đồng',N'40 000 đồng',N'63 000 đồng',N'48 000 đồng',N'A',N'Toán',N'Mỗi quyển 7 000 đồng; 8 × 7 000 = 56 000 đồng.',N'TOAN-CD20'),
(N'Số thập phân 0,125 viết dưới dạng phân số tối giản là:',N'12/100',N'1/5',N'1/4',N'1/8',N'D',N'Toán',N'0,125 = 125/1000 = 1/8.',N'TOAN-CD20'),
(N'Nghiệm của phương trình 2x + 7 = 19 là:',N'x = 7',N'x = 5',N'x = 13',N'x = 6',N'D',N'Toán',N'2x = 12 nên x = 6.',N'TOAN-CD20');
GO
-- Vật lý: VATLY-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'VATLY-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Đơn vị của vận tốc trong hệ SI là:',N'km/h',N'N',N'm/s²',N'm/s',N'D',N'Vật lý',N'Trong hệ SI, vận tốc đo bằng mét trên giây (m/s).',N'VATLY-DE01'),
(N'Một vật chuyển động thẳng đều với vận tốc 10 m/s. Quãng đường vật đi được trong 5 s là:',N'15 m',N'500 m',N'2 m',N'50 m',N'D',N'Vật lý',N's = v · t = 10 · 5 = 50 m.',N'VATLY-DE01'),
(N'Biểu thức của định luật II Newton là:',N'F = m/a',N'a = m·F',N'F = m + a',N'F = m·a',N'D',N'Vật lý',N'Gia tốc tỉ lệ thuận với lực và tỉ lệ nghịch với khối lượng: F = m·a.',N'VATLY-DE01'),
(N'Vật khối lượng 2 kg chịu tác dụng của hợp lực 10 N. Gia tốc của vật là:',N'12 m/s²',N'0,2 m/s²',N'5 m/s²',N'20 m/s²',N'C',N'Vật lý',N'a = F/m = 10/2 = 5 m/s².',N'VATLY-DE01'),
(N'Trọng lượng của vật có khối lượng 5 kg (lấy g = 10 m/s²) là:',N'500 N',N'0,5 N',N'5 N',N'50 N',N'D',N'Vật lý',N'P = m · g = 5 · 10 = 50 N.',N'VATLY-DE01'),
(N'Đơn vị của công trong hệ SI là:',N'Pascal (Pa)',N'Oát (W)',N'Jun (J)',N'Niutơn (N)',N'C',N'Vật lý',N'Công đo bằng jun; oát là đơn vị công suất.',N'VATLY-DE01'),
(N'Động năng của vật khối lượng m chuyển động với vận tốc v là:',N'½mv²',N'mv²',N'mv',N'mgh',N'A',N'Vật lý',N'Wđ = ½mv²; mv là động lượng, mgh là thế năng trọng trường.',N'VATLY-DE01'),
(N'Thế năng trọng trường của vật 2 kg ở độ cao 5 m (g = 10 m/s², gốc thế năng tại mặt đất) là:',N'10 J',N'1000 J',N'50 J',N'100 J',N'D',N'Vật lý',N'Wt = m·g·h = 2 · 10 · 5 = 100 J.',N'VATLY-DE01'),
(N'Đơn vị của công suất là:',N'Niutơn (N)',N'Jun (J)',N'Ampe (A)',N'Oát (W)',N'D',N'Vật lý',N'Công suất P = A/t đo bằng oát (1 W = 1 J/s).',N'VATLY-DE01'),
(N'Áp suất được tính bằng công thức:',N'p = S/F',N'p = F + S',N'p = F·S',N'p = F/S',N'D',N'Vật lý',N'Áp suất là độ lớn áp lực trên một đơn vị diện tích bị ép.',N'VATLY-DE01'),
(N'Cơ năng của một vật được bảo toàn khi:',N'Vật được kéo bởi một lực ngoài thay đổi',N'Vật chịu lực ma sát lớn',N'Vật chịu lực cản của không khí',N'Vật chỉ chịu tác dụng của trọng lực (bỏ qua ma sát, lực cản)',N'D',N'Vật lý',N'Cơ năng chỉ bảo toàn khi vật chỉ chịu tác dụng của lực thế như trọng lực, lực đàn hồi.',N'VATLY-DE01'),
(N'Một vật rơi tự do từ độ cao 20 m (g = 10 m/s²). Thời gian rơi là:',N'1 s',N'2 s',N'20 s',N'4 s',N'B',N'Vật lý',N'h = ½gt² ⇒ t = √(2h/g) = √4 = 2 s.',N'VATLY-DE01');
GO
-- Vật lý: VATLY-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'VATLY-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Nhiệt độ sôi của nước nguyên chất ở áp suất tiêu chuẩn là:',N'50 °C',N'0 °C',N'100 °C',N'273 °C',N'C',N'Vật lý',N'Ở áp suất 1 atm, nước nguyên chất sôi ở 100 °C.',N'VATLY-DE02'),
(N'Nhiệt độ 0 °C tương ứng với nhiệt độ tuyệt đối khoảng:',N'273 K',N'100 K',N'−273 K',N'0 K',N'A',N'Vật lý',N'T(K) = t(°C) + 273 (chính xác là 273,15).',N'VATLY-DE02'),
(N'Âm thanh không truyền được trong môi trường nào?',N'Thép',N'Nước',N'Chân không',N'Không khí',N'C',N'Vật lý',N'Sóng âm là sóng cơ, cần môi trường vật chất để truyền.',N'VATLY-DE02'),
(N'Tốc độ ánh sáng trong chân không xấp xỉ:',N'3·10⁸ m/s',N'3·10⁶ km/s',N'3·10⁵ m/s',N'340 m/s',N'A',N'Vật lý',N'c ≈ 3·10⁸ m/s = 3·10⁵ km/s; 340 m/s là tốc độ âm trong không khí.',N'VATLY-DE02'),
(N'Một sóng có tần số 50 Hz, bước sóng 2 m. Tốc độ truyền sóng là:',N'52 m/s',N'25 m/s',N'0,04 m/s',N'100 m/s',N'D',N'Vật lý',N'v = λ · f = 2 · 50 = 100 m/s.',N'VATLY-DE02'),
(N'Đơn vị của tần số là:',N'Giây (s)',N'Mét (m)',N'Oát (W)',N'Héc (Hz)',N'D',N'Vật lý',N'Tần số là số dao động trong một giây, đo bằng héc.',N'VATLY-DE02'),
(N'Hiện tượng tia sáng bị gãy khúc khi truyền xiên góc qua mặt phân cách giữa hai môi trường trong suốt gọi là:',N'Khúc xạ ánh sáng',N'Nhiễu xạ ánh sáng',N'Phản xạ ánh sáng',N'Giao thoa ánh sáng',N'A',N'Vật lý',N'Đó là định nghĩa hiện tượng khúc xạ ánh sáng.',N'VATLY-DE02'),
(N'Theo định luật phản xạ ánh sáng, góc phản xạ:',N'Bằng góc tới',N'Lớn hơn góc tới',N'Gấp đôi góc tới',N'Nhỏ hơn góc tới',N'A',N'Vật lý',N'Định luật phản xạ: góc phản xạ bằng góc tới.',N'VATLY-DE02'),
(N'Thấu kính hội tụ có đặc điểm:',N'Phần rìa mỏng hơn phần giữa',N'Phần rìa dày hơn phần giữa',N'Luôn cho ảnh ảo nhỏ hơn vật',N'Không có tiêu điểm',N'A',N'Vật lý',N'Thấu kính hội tụ (thấu kính rìa mỏng) làm chùm sáng song song hội tụ tại tiêu điểm.',N'VATLY-DE02'),
(N'Nhiệt lượng cần cung cấp để 1 kg nước tăng thêm 1 °C (c = 4200 J/kg·K) là:',N'42 000 J',N'420 J',N'4200 J',N'1 J',N'C',N'Vật lý',N'Q = m·c·Δt = 1 · 4200 · 1 = 4200 J.',N'VATLY-DE02'),
(N'Sự chuyển từ thể lỏng sang thể khí gọi là:',N'Sự ngưng tụ',N'Sự đông đặc',N'Sự nóng chảy',N'Sự hóa hơi',N'D',N'Vật lý',N'Hóa hơi (bay hơi, sôi) là chuyển từ lỏng sang khí; ngưng tụ là quá trình ngược lại.',N'VATLY-DE02'),
(N'Liên hệ giữa chu kì T và tần số f của dao động là:',N'T = f',N'T = 1/f',N'T = 2f',N'T = f²',N'B',N'Vật lý',N'Chu kì là nghịch đảo của tần số.',N'VATLY-DE02');
GO
-- Vật lý: VATLY-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'VATLY-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Đơn vị của điện trở là:',N'Oát (W)',N'Ôm (Ω)',N'Vôn (V)',N'Ampe (A)',N'B',N'Vật lý',N'Điện trở đo bằng ôm.',N'VATLY-DE03'),
(N'Biểu thức định luật Ôm cho đoạn mạch là:',N'U = I/R',N'I = R/U',N'I = U/R',N'I = U·R',N'C',N'Vật lý',N'Cường độ dòng điện tỉ lệ thuận với hiệu điện thế, tỉ lệ nghịch với điện trở.',N'VATLY-DE03'),
(N'Đặt hiệu điện thế 12 V vào hai đầu điện trở 4 Ω. Cường độ dòng điện là:',N'16 A',N'0,33 A',N'3 A',N'48 A',N'C',N'Vật lý',N'I = U/R = 12/4 = 3 A.',N'VATLY-DE03'),
(N'Hai điện trở 3 Ω và 6 Ω mắc nối tiếp. Điện trở tương đương là:',N'3 Ω',N'9 Ω',N'18 Ω',N'2 Ω',N'B',N'Vật lý',N'Nối tiếp: R = R₁ + R₂ = 9 Ω.',N'VATLY-DE03'),
(N'Hai điện trở 3 Ω và 6 Ω mắc song song. Điện trở tương đương là:',N'4,5 Ω',N'18 Ω',N'9 Ω',N'2 Ω',N'D',N'Vật lý',N'Song song: R = R₁R₂/(R₁ + R₂) = 18/9 = 2 Ω.',N'VATLY-DE03'),
(N'Một dụng cụ hoạt động ở hiệu điện thế 220 V, cường độ 2 A. Công suất tiêu thụ là:',N'222 W',N'440 W',N'110 W',N'0,009 W',N'B',N'Vật lý',N'P = U · I = 220 · 2 = 440 W.',N'VATLY-DE03'),
(N'Bóng đèn 100 W thắp sáng trong 10 giờ tiêu thụ điện năng:',N'1000 kWh',N'0,1 kWh',N'10 kWh',N'1 kWh',N'D',N'Vật lý',N'A = P · t = 0,1 kW · 10 h = 1 kWh.',N'VATLY-DE03'),
(N'Dòng điện là:',N'Chuyển động nhiệt hỗn loạn của các electron',N'Sự quay của nam châm',N'Dòng chuyển động của các nguyên tử trung hòa',N'Dòng chuyển dời có hướng của các hạt mang điện',N'D',N'Vật lý',N'Đó là định nghĩa dòng điện.',N'VATLY-DE03'),
(N'Hai điện tích điểm cùng dấu đặt gần nhau thì:',N'Hút nhau',N'Đẩy nhau',N'Không tương tác',N'Lúc hút lúc đẩy',N'B',N'Vật lý',N'Các điện tích cùng dấu đẩy nhau, trái dấu hút nhau.',N'VATLY-DE03'),
(N'Dụng cụ dùng để đo cường độ dòng điện là:',N'Vôn kế',N'Ôm kế',N'Ampe kế',N'Nhiệt kế',N'C',N'Vật lý',N'Ampe kế mắc nối tiếp để đo cường độ dòng điện; vôn kế đo hiệu điện thế.',N'VATLY-DE03'),
(N'Máy biến áp hoạt động dựa trên hiện tượng:',N'Quang điện',N'Nhiệt điện',N'Cảm ứng điện từ',N'Phóng xạ',N'C',N'Vật lý',N'Từ thông biến thiên trong lõi thép gây ra suất điện động cảm ứng ở cuộn thứ cấp.',N'VATLY-DE03'),
(N'Hiệu điện thế định mức của mạng điện sinh hoạt gia đình ở Việt Nam là:',N'110 V',N'380 V',N'12 V',N'220 V',N'D',N'Vật lý',N'Mạng điện dân dụng một pha ở Việt Nam có hiệu điện thế 220 V.',N'VATLY-DE03');
GO
-- Vật lý: VATLY-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'VATLY-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Nguồn năng lượng nào sau đây là năng lượng tái tạo?',N'Năng lượng mặt trời',N'Khí tự nhiên',N'Than đá',N'Dầu mỏ',N'A',N'Vật lý',N'Năng lượng mặt trời được bổ sung liên tục; than, dầu, khí là nhiên liệu hóa thạch.',N'VATLY-CD20'),
(N'Pin mặt trời biến đổi:',N'Hóa năng thành nhiệt năng',N'Quang năng thành điện năng',N'Nhiệt năng thành cơ năng',N'Điện năng thành quang năng',N'B',N'Vật lý',N'Pin quang điện chuyển năng lượng ánh sáng thành điện năng.',N'VATLY-CD20'),
(N'Nhà máy thủy điện biến đổi:',N'Hóa năng thành điện năng',N'Cơ năng của dòng nước thành điện năng',N'Điện năng thành cơ năng',N'Quang năng thành điện năng',N'B',N'Vật lý',N'Nước từ hồ chứa làm quay tua-bin gắn với máy phát điện.',N'VATLY-CD20'),
(N'Động cơ điện biến đổi:',N'Quang năng thành nhiệt năng',N'Nhiệt năng thành điện năng',N'Điện năng thành cơ năng',N'Cơ năng thành điện năng',N'C',N'Vật lý',N'Động cơ điện nhận điện năng và sinh công cơ học; máy phát điện làm điều ngược lại.',N'VATLY-CD20'),
(N'Đèn LED tiết kiệm điện hơn đèn sợi đốt vì:',N'Dùng hiệu điện thế cao hơn',N'Phần lớn điện năng chuyển thành quang năng, ít tỏa nhiệt',N'Tỏa nhiều nhiệt hơn',N'Không cần dòng điện',N'B',N'Vật lý',N'Đèn sợi đốt biến phần lớn điện năng thành nhiệt, đèn LED có hiệu suất phát sáng cao hơn.',N'VATLY-CD20'),
(N'Một máy nhận năng lượng 1000 J và sinh ra công có ích 800 J. Hiệu suất của máy là:',N'125%',N'8%',N'20%',N'80%',N'D',N'Vật lý',N'H = A_có ích / A_toàn phần = 800/1000 = 80%.',N'VATLY-CD20'),
(N'Đơn vị kWh (ki-lô-oát giờ) dùng để đo:',N'Công suất',N'Điện năng tiêu thụ',N'Cường độ dòng điện',N'Hiệu điện thế',N'B',N'Vật lý',N'kWh là đơn vị năng lượng, dùng trên công tơ điện.',N'VATLY-CD20'),
(N'1 kWh bằng:',N'3600 J',N'36 000 J',N'1000 J',N'3,6·10⁶ J',N'D',N'Vật lý',N'1 kWh = 1000 W · 3600 s = 3 600 000 J.',N'VATLY-CD20'),
(N'Ấm điện công suất 1000 W hoạt động trong 30 phút tiêu thụ điện năng:',N'500 kWh',N'30 kWh',N'0,03 kWh',N'0,5 kWh',N'D',N'Vật lý',N'A = 1 kW · 0,5 h = 0,5 kWh.',N'VATLY-CD20'),
(N'Khi có ma sát, cơ năng của vật:',N'Một phần chuyển hóa thành nhiệt năng',N'Được bảo toàn hoàn toàn',N'Tăng lên',N'Biến mất hoàn toàn không chuyển thành dạng nào',N'A',N'Vật lý',N'Công của lực ma sát làm một phần cơ năng chuyển thành nhiệt năng.',N'VATLY-CD20'),
(N'Định luật bảo toàn năng lượng phát biểu:',N'Năng lượng luôn mất dần theo thời gian',N'Năng lượng luôn tự sinh ra',N'Năng lượng không tự sinh ra, không tự mất đi, chỉ chuyển hóa từ dạng này sang dạng khác',N'Năng lượng chỉ tồn tại ở dạng điện năng',N'C',N'Vật lý',N'Đó là nội dung định luật bảo toàn và chuyển hóa năng lượng.',N'VATLY-CD20'),
(N'Vật liệu dẫn nhiệt tốt nhất trong các vật liệu sau là:',N'Đồng',N'Không khí',N'Nhựa',N'Gỗ',N'A',N'Vật lý',N'Kim loại dẫn nhiệt tốt; gỗ, nhựa, không khí là vật cách nhiệt.',N'VATLY-CD20'),
(N'Mùa hè nên mặc áo màu sáng vì:',N'Màu sáng dẫn nhiệt tốt',N'Màu sáng hấp thụ nhiều bức xạ nhiệt',N'Màu sáng hấp thụ ít bức xạ nhiệt',N'Màu sáng ngăn cản đối lưu',N'C',N'Vật lý',N'Vật màu sáng phản xạ nhiều, hấp thụ ít bức xạ nhiệt từ Mặt Trời.',N'VATLY-CD20'),
(N'Nhiệt từ Mặt Trời truyền tới Trái Đất chủ yếu bằng hình thức:',N'Bức xạ nhiệt',N'Đối lưu',N'Dẫn nhiệt',N'Cọ xát',N'A',N'Vật lý',N'Giữa Mặt Trời và Trái Đất là khoảng chân không, chỉ bức xạ nhiệt truyền được.',N'VATLY-CD20'),
(N'Pin và ắc quy dự trữ năng lượng dưới dạng:',N'Năng lượng âm',N'Quang năng',N'Hóa năng',N'Năng lượng hạt nhân',N'C',N'Vật lý',N'Pin, ắc quy biến hóa năng thành điện năng khi sử dụng.',N'VATLY-CD20'),
(N'Nhà máy điện hạt nhân sử dụng năng lượng tỏa ra từ:',N'Phản ứng phân hạch hạt nhân',N'Thủy triều',N'Gió',N'Phản ứng đốt cháy than',N'A',N'Vật lý',N'Phân hạch urani tỏa nhiệt, làm nóng nước tạo hơi quay tua-bin.',N'VATLY-CD20'),
(N'Cầu chì trong mạch điện có tác dụng:',N'Tiết kiệm điện năng',N'Tự ngắt mạch khi dòng điện quá lớn',N'Tăng hiệu điện thế',N'Đổi chiều dòng điện',N'B',N'Vật lý',N'Dây chì nóng chảy khi dòng quá lớn, bảo vệ mạch điện.',N'VATLY-CD20'),
(N'Biện pháp nào giúp tiết kiệm điện năng?',N'Mở cửa tủ lạnh thường xuyên',N'Để tivi ở chế độ chờ suốt đêm',N'Thay đèn LED bằng đèn sợi đốt',N'Tắt thiết bị điện khi không sử dụng',N'D',N'Vật lý',N'Tắt thiết bị không dùng giúp giảm điện năng tiêu thụ.',N'VATLY-CD20'),
(N'Quạt điện 50 W hoạt động trong 4 giờ tiêu thụ điện năng:',N'0,2 kWh',N'0,02 kWh',N'2 kWh',N'200 kWh',N'A',N'Vật lý',N'A = 0,05 kW · 4 h = 0,2 kWh.',N'VATLY-CD20'),
(N'Năng lượng gió được chuyển thành điện năng nhờ:',N'Ắc quy',N'Pin mặt trời',N'Tua-bin gió và máy phát điện',N'Lò phản ứng hạt nhân',N'C',N'Vật lý',N'Gió làm quay cánh tua-bin gắn với máy phát điện.',N'VATLY-CD20');
GO
-- Hóa học: HOAHOC-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'HOAHOC-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Hạt mang điện tích âm trong nguyên tử là:',N'Neutron',N'Proton',N'Hạt nhân',N'Electron',N'D',N'Hóa học',N'Electron mang điện âm; proton mang điện dương; neutron không mang điện.',N'HOAHOC-DE01'),
(N'Nguyên tử oxi (Z = 8) có số proton là:',N'8',N'16',N'18',N'6',N'A',N'Hóa học',N'Số proton bằng số hiệu nguyên tử Z.',N'HOAHOC-DE01'),
(N'Nguyên tố có số hiệu nguyên tử Z = 11 là:',N'Kali (K)',N'Natri (Na)',N'Magie (Mg)',N'Nhôm (Al)',N'B',N'Hóa học',N'Na có Z = 11; Mg 12; Al 13; K 19.',N'HOAHOC-DE01'),
(N'Kí hiệu hóa học của nguyên tố sắt là:',N'F',N'Fr',N'Fe',N'S',N'C',N'Hóa học',N'Fe (ferrum) là sắt; S là lưu huỳnh, F là flo.',N'HOAHOC-DE01'),
(N'Các nguyên tố nhóm VIIA trong bảng tuần hoàn được gọi là:',N'Halogen',N'Khí hiếm',N'Kim loại kiềm',N'Kim loại kiềm thổ',N'A',N'Hóa học',N'Nhóm VIIA gồm F, Cl, Br, I… gọi là halogen.',N'HOAHOC-DE01'),
(N'Chất nào sau đây là khí hiếm?',N'Nitơ (N₂)',N'Oxi (O₂)',N'Clo (Cl₂)',N'Neon (Ne)',N'D',N'Hóa học',N'Ne thuộc nhóm VIIIA (khí hiếm).',N'HOAHOC-DE01'),
(N'Liên kết trong phân tử NaCl là:',N'Liên kết kim loại',N'Liên kết ion',N'Liên kết hiđro',N'Liên kết cộng hóa trị không cực',N'B',N'Hóa học',N'Na nhường electron cho Cl tạo ion Na⁺ và Cl⁻ hút nhau.',N'HOAHOC-DE01'),
(N'Liên kết trong phân tử H₂ là:',N'Liên kết cộng hóa trị không cực',N'Liên kết kim loại',N'Liên kết cộng hóa trị có cực',N'Liên kết ion',N'A',N'Hóa học',N'Hai nguyên tử giống nhau góp chung electron, cặp electron không lệch về bên nào.',N'HOAHOC-DE01'),
(N'Nguyên tử có 6 proton và 6 neutron có số khối là:',N'6',N'12',N'18',N'0',N'B',N'Hóa học',N'A = Z + N = 6 + 6 = 12.',N'HOAHOC-DE01'),
(N'Nguyên tử khối của cacbon xấp xỉ:',N'6',N'16',N'12',N'14',N'C',N'Hóa học',N'C có nguyên tử khối khoảng 12; N là 14, O là 16.',N'HOAHOC-DE01'),
(N'Nguyên tố nào sau đây là kim loại kiềm?',N'Sắt (Fe)',N'Nhôm (Al)',N'Canxi (Ca)',N'Kali (K)',N'D',N'Hóa học',N'K thuộc nhóm IA (kim loại kiềm); Ca thuộc nhóm IIA.',N'HOAHOC-DE01'),
(N'Trong một chu kì, theo chiều tăng điện tích hạt nhân, bán kính nguyên tử các nguyên tố nhóm A nhìn chung:',N'Giảm dần',N'Tăng dần',N'Không đổi',N'Tăng rồi giảm',N'A',N'Hóa học',N'Số lớp electron không đổi, điện tích hạt nhân tăng làm lực hút electron mạnh hơn.',N'HOAHOC-DE01');
GO
-- Hóa học: HOAHOC-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'HOAHOC-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Khối lượng mol của nước (H₂O) là:',N'20 g/mol',N'18 g/mol',N'16 g/mol',N'10 g/mol',N'B',N'Hóa học',N'M = 2·1 + 16 = 18 g/mol.',N'HOAHOC-DE02'),
(N'Số mol có trong 44 g khí CO₂ là:',N'1 mol',N'2 mol',N'0,5 mol',N'44 mol',N'A',N'Hóa học',N'M(CO₂) = 44 g/mol nên n = 44/44 = 1 mol.',N'HOAHOC-DE02'),
(N'Ở 0 °C và áp suất 1 atm, 1 mol khí bất kì chiếm thể tích khoảng:',N'11,2 lít',N'2,24 lít',N'44,8 lít',N'22,4 lít',N'D',N'Hóa học',N'Thể tích mol khí ở 0 °C, 1 atm là 22,4 lít.',N'HOAHOC-DE02'),
(N'Phương trình hóa học nào đã được cân bằng đúng?',N'2H₂ + 2O₂ → 2H₂O',N'H₂ + 2O₂ → 2H₂O',N'H₂ + O₂ → H₂O',N'2H₂ + O₂ → 2H₂O',N'D',N'Hóa học',N'Hai vế đều có 4 nguyên tử H và 2 nguyên tử O.',N'HOAHOC-DE02'),
(N'Dung dịch làm quỳ tím hóa đỏ là:',N'Nước cất',N'NaCl',N'NaOH',N'HCl',N'D',N'Hóa học',N'Dung dịch axit làm quỳ tím hóa đỏ.',N'HOAHOC-DE02'),
(N'Dung dịch NaOH làm quỳ tím:',N'Không đổi màu',N'Hóa xanh',N'Mất màu',N'Hóa đỏ',N'B',N'Hóa học',N'Dung dịch bazơ làm quỳ tím hóa xanh.',N'HOAHOC-DE02'),
(N'Phản ứng giữa axit và bazơ tạo thành muối và nước được gọi là phản ứng:',N'Phân hủy',N'Thế',N'Trung hòa',N'Hóa hợp',N'C',N'Hóa học',N'Axit + bazơ → muối + nước là phản ứng trung hòa.',N'HOAHOC-DE02'),
(N'Hòa tan 20 g muối thu được 100 g dung dịch. Nồng độ phần trăm của dung dịch là:',N'25%',N'16,7%',N'80%',N'20%',N'D',N'Hóa học',N'C% = 20/100 × 100% = 20%.',N'HOAHOC-DE02'),
(N'Hòa tan 0,5 mol NaCl vào nước được 1 lít dung dịch. Nồng độ mol của dung dịch là:',N'2 M',N'0,5 M',N'1 M',N'0,25 M',N'B',N'Hóa học',N'C_M = n/V = 0,5/1 = 0,5 M.',N'HOAHOC-DE02'),
(N'Chất xúc tác là chất:',N'Bị tiêu hao hoàn toàn trong phản ứng',N'Làm giảm tốc độ phản ứng',N'Làm tăng tốc độ phản ứng và không bị tiêu hao sau phản ứng',N'Luôn là sản phẩm chính của phản ứng',N'C',N'Hóa học',N'Đó là định nghĩa chất xúc tác.',N'HOAHOC-DE02'),
(N'Khí làm vẩn đục nước vôi trong là:',N'CO₂',N'O₂',N'H₂',N'N₂',N'A',N'Hóa học',N'CO₂ + Ca(OH)₂ → CaCO₃↓ + H₂O.',N'HOAHOC-DE02'),
(N'Trong phản ứng Zn + 2HCl → ZnCl₂ + H₂, khí sinh ra là:',N'Hơi nước',N'Clo',N'Oxi',N'Hiđro',N'D',N'Hóa học',N'Kim loại đứng trước H tác dụng với axit HCl giải phóng khí H₂.',N'HOAHOC-DE02');
GO
-- Hóa học: HOAHOC-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'HOAHOC-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Kim loại dẫn điện tốt nhất là:',N'Bạc (Ag)',N'Đồng (Cu)',N'Nhôm (Al)',N'Sắt (Fe)',N'A',N'Hóa học',N'Thứ tự dẫn điện giảm dần: Ag > Cu > Au > Al > Fe.',N'HOAHOC-DE03'),
(N'Kim loại có nhiệt độ nóng chảy cao nhất là:',N'Đồng (Cu)',N'Chì (Pb)',N'Sắt (Fe)',N'Vonfram (W)',N'D',N'Hóa học',N'Vonfram nóng chảy ở khoảng 3410 °C, dùng làm dây tóc bóng đèn.',N'HOAHOC-DE03'),
(N'Sắt bị gỉ trong không khí ẩm là do:',N'Sắt bị khử',N'Sắt tan vào không khí',N'Sắt bị oxi hóa',N'Sắt bay hơi',N'C',N'Hóa học',N'Fe nhường electron cho oxi (có hơi nước) tạo gỉ sắt.',N'HOAHOC-DE03'),
(N'Kim loại không tác dụng với dung dịch HCl loãng là:',N'Kẽm (Zn)',N'Đồng (Cu)',N'Sắt (Fe)',N'Magie (Mg)',N'B',N'Hóa học',N'Cu đứng sau H trong dãy hoạt động hóa học.',N'HOAHOC-DE03'),
(N'Khí chiếm khoảng 78% thể tích không khí là:',N'Argon',N'Cacbon đioxit',N'Oxi',N'Nitơ',N'D',N'Hóa học',N'Không khí có khoảng 78% N₂, 21% O₂.',N'HOAHOC-DE03'),
(N'Khí gây hiệu ứng nhà kính chủ yếu do hoạt động của con người là:',N'N₂',N'CO₂',N'O₂',N'He',N'B',N'Hóa học',N'Đốt nhiên liệu hóa thạch thải nhiều CO₂ gây hiệu ứng nhà kính.',N'HOAHOC-DE03'),
(N'Công thức phân tử của metan là:',N'C₂H₄',N'CH₃OH',N'CH₄',N'C₂H₆',N'C',N'Hóa học',N'Metan là ankan đơn giản nhất CH₄.',N'HOAHOC-DE03'),
(N'Công thức của etanol (rượu etylic) là:',N'C₂H₅OH',N'CH₃OH',N'C₂H₆',N'CH₃COOH',N'A',N'Hóa học',N'Etanol C₂H₅OH; CH₃OH là metanol; CH₃COOH là axit axetic.',N'HOAHOC-DE03'),
(N'Giấm ăn là dung dịch loãng của axit:',N'Axit nitric (HNO₃)',N'Axit clohiđric (HCl)',N'Axit axetic (CH₃COOH)',N'Axit sunfuric (H₂SO₄)',N'C',N'Hóa học',N'Giấm ăn chứa khoảng 2–5% axit axetic.',N'HOAHOC-DE03'),
(N'Công thức phân tử của glucozơ là:',N'C₁₂H₂₂O₁₁',N'C₆H₁₂O₆',N'C₂H₅OH',N'(C₆H₁₀O₅)ₙ',N'B',N'Hóa học',N'Glucozơ C₆H₁₂O₆; C₁₂H₂₂O₁₁ là saccarozơ; (C₆H₁₀O₅)ₙ là tinh bột, xenlulozơ.',N'HOAHOC-DE03'),
(N'Polime thường dùng sản xuất túi nilon là:',N'Tinh bột',N'Xenlulozơ',N'Polietilen (PE)',N'Protein',N'C',N'Hóa học',N'Túi nilon phổ biến được làm từ polietilen.',N'HOAHOC-DE03'),
(N'Chất béo là:',N'Ancol đơn chức',N'Trieste của glixerol với axit béo',N'Hiđrocacbon no',N'Axit vô cơ',N'B',N'Hóa học',N'Chất béo (triglixerit) là trieste của glixerol và axit béo.',N'HOAHOC-DE03');
GO
-- Hóa học: HOAHOC-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'HOAHOC-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Nước cứng là nước chứa nhiều ion:',N'Na⁺ và K⁺',N'Ca²⁺ và Mg²⁺',N'NH₄⁺ và NO₃⁻',N'H⁺ và OH⁻',N'B',N'Hóa học',N'Nước cứng chứa nhiều ion Ca²⁺, Mg²⁺.',N'HOAHOC-CD20'),
(N'Chất thường dùng để khử trùng nước sinh hoạt là:',N'Giấm',N'Đường',N'Muối ăn',N'Clo',N'D',N'Hóa học',N'Clo (hoặc hợp chất của clo) có tính oxi hóa mạnh, diệt khuẩn.',N'HOAHOC-CD20'),
(N'Mưa axit chủ yếu do các khí nào gây ra?',N'O₂ và N₂',N'H₂ và He',N'CH₄ và O₂',N'SO₂ và NOₓ',N'D',N'Hóa học',N'SO₂, NOₓ tác dụng với hơi nước tạo axit H₂SO₄, HNO₃.',N'HOAHOC-CD20'),
(N'Khí CO độc vì:',N'Gây nổ khi gặp nước',N'Kết hợp với hemoglobin, làm máu giảm khả năng vận chuyển oxi',N'Làm quỳ tím hóa đỏ',N'Có màu vàng gây kích ứng mắt',N'B',N'Hóa học',N'CO tạo phức bền với hemoglobin, gây ngạt.',N'HOAHOC-CD20'),
(N'Công thức của muối ăn là:',N'KCl',N'NaHCO₃',N'Na₂CO₃',N'NaCl',N'D',N'Hóa học',N'Muối ăn là natri clorua.',N'HOAHOC-CD20'),
(N'Thuốc muối (baking soda) dùng làm bột nở và giảm đau dạ dày có công thức:',N'CaCO₃',N'NaHCO₃',N'Na₂SO₄',N'NaCl',N'B',N'Hóa học',N'Natri hiđrocacbonat NaHCO₃ trung hòa bớt axit dạ dày và sinh khí CO₂.',N'HOAHOC-CD20'),
(N'Thành phần chính của đá vôi là:',N'Ca(OH)₂',N'CaO',N'CaSO₄',N'CaCO₃',N'D',N'Hóa học',N'Đá vôi chủ yếu là canxi cacbonat.',N'HOAHOC-CD20'),
(N'Vôi sống có công thức hóa học là:',N'CaCO₃',N'CaO',N'Ca(OH)₂',N'CaCl₂',N'B',N'Hóa học',N'Nung đá vôi CaCO₃ → CaO + CO₂; CaO là vôi sống, Ca(OH)₂ là vôi tôi.',N'HOAHOC-CD20'),
(N'Khi bị kiến đốt (có axit fomic), nên bôi vào vết đốt:',N'Nước chanh',N'Giấm ăn',N'Dung dịch muối ăn đặc',N'Nước vôi loãng',N'D',N'Hóa học',N'Chất có tính kiềm nhẹ trung hòa axit fomic.',N'HOAHOC-CD20'),
(N'Phân đạm cung cấp cho cây trồng nguyên tố dinh dưỡng:',N'Photpho',N'Kali',N'Canxi',N'Nitơ',N'D',N'Hóa học',N'Phân đạm cung cấp nitơ dưới dạng NO₃⁻, NH₄⁺.',N'HOAHOC-CD20'),
(N'Phân lân cung cấp cho cây trồng nguyên tố dinh dưỡng:',N'Photpho',N'Kali',N'Lưu huỳnh',N'Nitơ',N'A',N'Hóa học',N'Phân lân cung cấp photpho.',N'HOAHOC-CD20'),
(N'Tầng ozon bị suy giảm chủ yếu do:',N'Khí nitơ',N'Các hợp chất CFC (freon)',N'Hơi nước',N'Khí oxi',N'B',N'Hóa học',N'CFC giải phóng clo phá hủy O₃ ở tầng bình lưu.',N'HOAHOC-CD20'),
(N'Vật liệu nào khó phân hủy, gây ô nhiễm môi trường lâu dài?',N'Túi nilon',N'Giấy',N'Lá chuối',N'Bã mía',N'A',N'Hóa học',N'Túi nilon làm từ polime tổng hợp, phân hủy rất chậm.',N'HOAHOC-CD20'),
(N'Chất bị cấm dùng để bảo quản, chế biến thực phẩm là:',N'Đường',N'Muối ăn',N'Hàn the',N'Giấm ăn',N'C',N'Hóa học',N'Hàn the (borax) gây hại cho sức khỏe và bị cấm dùng trong thực phẩm.',N'HOAHOC-CD20'),
(N'Cồn 70° trong y tế được dùng để:',N'Uống hạ sốt',N'Pha nước giải khát',N'Tẩy gỉ sắt',N'Sát khuẩn',N'D',N'Hóa học',N'Cồn 70° làm biến tính protein của vi khuẩn.',N'HOAHOC-CD20'),
(N'Kim loại nặng rất độc thường gặp trong nước thải công nghiệp là:',N'Kali (K)',N'Natri (Na)',N'Thủy ngân (Hg)',N'Magie (Mg)',N'C',N'Hóa học',N'Thủy ngân, chì, cađimi… là kim loại nặng gây độc.',N'HOAHOC-CD20'),
(N'Bình chữa cháy CO₂ dập được đám cháy vì:',N'CO₂ nặng hơn không khí và không duy trì sự cháy',N'CO₂ tác dụng với lửa tạo ra nước',N'CO₂ nhẹ hơn không khí',N'CO₂ là chất cháy được',N'A',N'Hóa học',N'CO₂ phủ lên đám cháy, ngăn cách với oxi.',N'HOAHOC-CD20'),
(N'Khí hóa lỏng (LPG) dùng đun nấu có thành phần chính là:',N'Propan và butan',N'Cacbon monooxit',N'Oxi và nitơ',N'Hiđro',N'A',N'Hóa học',N'LPG là hỗn hợp propan C₃H₈ và butan C₄H₁₀.',N'HOAHOC-CD20'),
(N'Xà phòng được sản xuất bằng cách đun chất béo với:',N'Dung dịch kiềm (NaOH)',N'Axit HCl',N'Khí CO₂',N'Nước muối',N'A',N'Hóa học',N'Phản ứng xà phòng hóa: chất béo + NaOH → muối của axit béo + glixerol.',N'HOAHOC-CD20'),
(N'pH của nước nguyên chất ở 25 °C bằng:',N'14',N'0',N'7',N'1',N'C',N'Hóa học',N'Nước nguyên chất trung tính, [H⁺] = 10⁻⁷ M.',N'HOAHOC-CD20');
GO
-- Ngữ văn: NGUVAN-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'NGUVAN-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Tác giả của “Bình Ngô đại cáo” là:',N'Nguyễn Trãi',N'Lý Thường Kiệt',N'Trần Quốc Tuấn',N'Nguyễn Du',N'A',N'Ngữ văn',N'“Bình Ngô đại cáo” do Nguyễn Trãi viết năm 1428 thay Lê Lợi.',N'NGUVAN-DE01'),
(N'Tác giả của “Hịch tướng sĩ” là:',N'Quang Trung',N'Lê Lợi',N'Nguyễn Trãi',N'Trần Quốc Tuấn',N'D',N'Ngữ văn',N'Hưng Đạo Đại Vương Trần Quốc Tuấn viết bài hịch trước cuộc kháng chiến chống Mông – Nguyên.',N'NGUVAN-DE01'),
(N'Truyện “Vợ chồng A Phủ” là của nhà văn:',N'Nam Cao',N'Kim Lân',N'Nguyễn Tuân',N'Tô Hoài',N'D',N'Ngữ văn',N'Truyện in trong tập “Truyện Tây Bắc” của Tô Hoài.',N'NGUVAN-DE01'),
(N'Truyện ngắn “Vợ nhặt” là của nhà văn:',N'Nam Cao',N'Tô Hoài',N'Nguyễn Minh Châu',N'Kim Lân',N'D',N'Ngữ văn',N'“Vợ nhặt” của Kim Lân lấy bối cảnh nạn đói năm 1945.',N'NGUVAN-DE01'),
(N'Bài thơ “Việt Bắc” là của nhà thơ:',N'Huy Cận',N'Xuân Diệu',N'Chính Hữu',N'Tố Hữu',N'D',N'Ngữ văn',N'Tố Hữu viết “Việt Bắc” năm 1954.',N'NGUVAN-DE01'),
(N'Bài thơ “Sóng” là của nhà thơ:',N'Hữu Thỉnh',N'Tố Hữu',N'Xuân Quỳnh',N'Xuân Diệu',N'C',N'Ngữ văn',N'“Sóng” là bài thơ tình nổi tiếng của Xuân Quỳnh.',N'NGUVAN-DE01'),
(N'Bài thơ “Vội vàng” là của nhà thơ:',N'Huy Cận',N'Xuân Diệu',N'Hàn Mặc Tử',N'Xuân Quỳnh',N'B',N'Ngữ văn',N'“Vội vàng” in trong tập “Thơ thơ” của Xuân Diệu.',N'NGUVAN-DE01'),
(N'Bài thơ “Tràng giang” là của nhà thơ:',N'Xuân Diệu',N'Thế Lữ',N'Huy Cận',N'Chế Lan Viên',N'C',N'Ngữ văn',N'“Tràng giang” in trong tập “Lửa thiêng” của Huy Cận.',N'NGUVAN-DE01'),
(N'Bài thơ “Đây thôn Vĩ Dạ” là của nhà thơ:',N'Lưu Trọng Lư',N'Hàn Mặc Tử',N'Nguyễn Bính',N'Huy Cận',N'B',N'Ngữ văn',N'“Đây thôn Vĩ Dạ” là bài thơ nổi tiếng của Hàn Mặc Tử.',N'NGUVAN-DE01'),
(N'Truyện ngắn “Chiếc thuyền ngoài xa” là của nhà văn:',N'Nguyễn Tuân',N'Nguyễn Minh Châu',N'Nguyễn Khải',N'Kim Lân',N'B',N'Ngữ văn',N'Tác phẩm tiêu biểu của Nguyễn Minh Châu thời kì đổi mới.',N'NGUVAN-DE01'),
(N'Tùy bút “Người lái đò sông Đà” là của nhà văn:',N'Hoàng Phủ Ngọc Tường',N'Nguyễn Minh Châu',N'Thạch Lam',N'Nguyễn Tuân',N'D',N'Ngữ văn',N'Tác phẩm in trong tập “Sông Đà” của Nguyễn Tuân.',N'NGUVAN-DE01'),
(N'Bút kí “Ai đã đặt tên cho dòng sông?” là của nhà văn:',N'Thạch Lam',N'Hoàng Phủ Ngọc Tường',N'Tô Hoài',N'Nguyễn Tuân',N'B',N'Ngữ văn',N'Bút kí về sông Hương của Hoàng Phủ Ngọc Tường.',N'NGUVAN-DE01');
GO
-- Ngữ văn: NGUVAN-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'NGUVAN-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Câu thơ “Mặt trời xuống biển như hòn lửa” sử dụng biện pháp tu từ:',N'Nhân hóa',N'So sánh',N'Ẩn dụ',N'Hoán dụ',N'B',N'Ngữ văn',N'Có từ so sánh “như”.',N'NGUVAN-DE02'),
(N'Trong câu “Áo chàm đưa buổi phân li”, cụm từ “áo chàm” là biện pháp:',N'So sánh',N'Nhân hóa',N'Nói quá',N'Hoán dụ',N'D',N'Ngữ văn',N'“Áo chàm” chỉ người dân Việt Bắc (lấy trang phục để gọi người).',N'NGUVAN-DE02'),
(N'Câu ca dao “Trâu ơi, ta bảo trâu này” sử dụng biện pháp tu từ:',N'Liệt kê',N'Hoán dụ',N'So sánh',N'Nhân hóa',N'D',N'Ngữ văn',N'Trò chuyện với con trâu như với người.',N'NGUVAN-DE02'),
(N'Trong câu ca dao “Thuyền về có nhớ bến chăng / Bến thì một dạ khăng khăng đợi thuyền”, hình ảnh “thuyền”, “bến” là:',N'Ẩn dụ',N'Hoán dụ',N'So sánh',N'Điệp ngữ',N'A',N'Ngữ văn',N'“Thuyền” chỉ người con trai, “bến” chỉ người con gái dựa trên nét tương đồng.',N'NGUVAN-DE02'),
(N'Câu “Lỗ mũi mười tám gánh lông” sử dụng biện pháp tu từ:',N'Hoán dụ',N'Nói giảm nói tránh',N'So sánh',N'Nói quá',N'D',N'Ngữ văn',N'Phóng đại mức độ để gây ấn tượng, tạo tiếng cười.',N'NGUVAN-DE02'),
(N'Trong câu “Bác đã đi rồi sao Bác ơi”, từ “đi” thể hiện biện pháp:',N'Nói giảm nói tránh',N'Ẩn dụ',N'So sánh',N'Nói quá',N'A',N'Ngữ văn',N'Dùng “đi” thay cho “mất” để giảm đau thương.',N'NGUVAN-DE02'),
(N'Từ “xanh xanh” thuộc loại:',N'Thành ngữ',N'Từ ghép',N'Từ đơn',N'Từ láy',N'D',N'Ngữ văn',N'Từ láy toàn bộ, lặp lại cả tiếng gốc.',N'NGUVAN-DE02'),
(N'Từ nào sau đây là từ ghép?',N'Quần áo',N'Xinh xắn',N'Lấp lánh',N'Lung linh',N'A',N'Ngữ văn',N'“Quần áo” ghép hai tiếng có nghĩa; các từ còn lại là từ láy.',N'NGUVAN-DE02'),
(N'Câu “Trời mưa.” xét theo cấu tạo là:',N'Câu rút gọn',N'Câu ghép',N'Câu đặc biệt',N'Câu đơn',N'D',N'Ngữ văn',N'Câu có một cụm chủ ngữ – vị ngữ (“Trời” – “mưa”).',N'NGUVAN-DE02'),
(N'Phương thức biểu đạt chính của bài văn nghị luận là:',N'Nghị luận',N'Tự sự',N'Miêu tả',N'Biểu cảm',N'A',N'Ngữ văn',N'Văn nghị luận dùng lí lẽ, dẫn chứng để thuyết phục.',N'NGUVAN-DE02'),
(N'“Truyện Kiều” của Nguyễn Du được viết bằng thể thơ:',N'Song thất lục bát',N'Tự do',N'Lục bát',N'Thất ngôn bát cú',N'C',N'Ngữ văn',N'Truyện Kiều gồm 3254 câu thơ lục bát.',N'NGUVAN-DE02'),
(N'Bài thơ thất ngôn bát cú Đường luật có số câu là:',N'6',N'8',N'12',N'4',N'B',N'Ngữ văn',N'“Bát cú” là tám câu, mỗi câu bảy chữ.',N'NGUVAN-DE02');
GO
-- Ngữ văn: NGUVAN-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'NGUVAN-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Bản dịch “Chinh phụ ngâm” được viết bằng thể thơ:',N'Song thất lục bát',N'Tự do',N'Thất ngôn tứ tuyệt',N'Lục bát',N'A',N'Ngữ văn',N'Bản dịch Nôm “Chinh phụ ngâm” dùng thể song thất lục bát.',N'NGUVAN-DE03'),
(N'Nguyễn Du viết “Truyện Kiều” dựa trên cốt truyện:',N'“Kim Vân Kiều truyện” của Thanh Tâm Tài Nhân',N'“Tam quốc diễn nghĩa”',N'“Tây du kí”',N'“Hồng lâu mộng”',N'A',N'Ngữ văn',N'Nguyễn Du sáng tạo lại từ tiểu thuyết chương hồi của Thanh Tâm Tài Nhân.',N'NGUVAN-DE03'),
(N'Đặc trưng cơ bản của văn học dân gian là:',N'Tính truyền miệng và tính tập thể',N'Do một tác giả xác định sáng tác',N'Chỉ có thể loại thơ',N'Chỉ lưu truyền bằng chữ Hán',N'A',N'Ngữ văn',N'Văn học dân gian được truyền miệng và sáng tác tập thể.',N'NGUVAN-DE03'),
(N'Thể loại nào thuộc văn học dân gian?',N'Phóng sự',N'Tiểu thuyết',N'Truyện ngắn hiện đại',N'Ca dao',N'D',N'Ngữ văn',N'Ca dao là thơ trữ tình dân gian.',N'NGUVAN-DE03'),
(N'Truyện “Tấm Cám” thuộc thể loại:',N'Sử thi',N'Truyền thuyết',N'Truyện ngụ ngôn',N'Truyện cổ tích',N'D',N'Ngữ văn',N'Truyện cổ tích thần kì về người mồ côi bất hạnh.',N'NGUVAN-DE03'),
(N'Truyện “Thánh Gióng” thuộc thể loại:',N'Truyện ngụ ngôn',N'Truyền thuyết',N'Truyện cười',N'Truyện cổ tích',N'B',N'Ngữ văn',N'Truyền thuyết gắn với lịch sử chống giặc Ân thời Hùng Vương.',N'NGUVAN-DE03'),
(N'“Đăm Săn” là tác phẩm thuộc thể loại:',N'Sử thi Tây Nguyên',N'Ca dao',N'Truyện cười',N'Truyện cổ tích',N'A',N'Ngữ văn',N'“Đăm Săn” là sử thi anh hùng của người Ê-đê.',N'NGUVAN-DE03'),
(N'Truyện ngắn “Hai đứa trẻ” là của nhà văn:',N'Vũ Trọng Phụng',N'Thạch Lam',N'Nam Cao',N'Ngô Tất Tố',N'B',N'Ngữ văn',N'Thạch Lam, thành viên Tự lực văn đoàn.',N'NGUVAN-DE03'),
(N'Tiểu thuyết “Số đỏ” là của nhà văn:',N'Nam Cao',N'Vũ Trọng Phụng',N'Ngô Tất Tố',N'Nguyễn Công Hoan',N'B',N'Ngữ văn',N'“Số đỏ” (1936) là tiểu thuyết trào phúng của Vũ Trọng Phụng.',N'NGUVAN-DE03'),
(N'Tiểu thuyết “Tắt đèn” là của nhà văn:',N'Ngô Tất Tố',N'Nam Cao',N'Vũ Trọng Phụng',N'Nguyên Hồng',N'A',N'Ngữ văn',N'“Tắt đèn” với nhân vật chị Dậu của Ngô Tất Tố.',N'NGUVAN-DE03'),
(N'“Tuyên ngôn Độc lập” (1945) thuộc thể loại:',N'Tùy bút',N'Văn chính luận',N'Kí sự',N'Truyện ngắn',N'B',N'Ngữ văn',N'Văn bản chính luận mẫu mực của Hồ Chí Minh.',N'NGUVAN-DE03'),
(N'Hồ Xuân Hương được mệnh danh là:',N'Bà chúa thơ Nôm',N'Thi tiên',N'Thi bá',N'Thi thánh',N'A',N'Ngữ văn',N'Xuân Diệu gọi Hồ Xuân Hương là “Bà chúa thơ Nôm”.',N'NGUVAN-DE03');
GO
-- Ngữ văn: NGUVAN-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'NGUVAN-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Bài thơ “Đồng chí” là của nhà thơ:',N'Phạm Tiến Duật',N'Quang Dũng',N'Chính Hữu',N'Tố Hữu',N'C',N'Ngữ văn',N'Chính Hữu viết “Đồng chí” năm 1948.',N'NGUVAN-CD20'),
(N'“Bài thơ về tiểu đội xe không kính” là của nhà thơ:',N'Phạm Tiến Duật',N'Huy Cận',N'Nguyễn Duy',N'Chính Hữu',N'A',N'Ngữ văn',N'Phạm Tiến Duật viết về người lính lái xe Trường Sơn.',N'NGUVAN-CD20'),
(N'Bài thơ “Đoàn thuyền đánh cá” là của nhà thơ:',N'Tố Hữu',N'Huy Cận',N'Xuân Diệu',N'Tế Hanh',N'B',N'Ngữ văn',N'Huy Cận sáng tác năm 1958 ở vùng mỏ Quảng Ninh.',N'NGUVAN-CD20'),
(N'Bài thơ “Ánh trăng” là của nhà thơ:',N'Viễn Phương',N'Nguyễn Duy',N'Nguyễn Khoa Điềm',N'Thanh Hải',N'B',N'Ngữ văn',N'Nguyễn Duy viết năm 1978.',N'NGUVAN-CD20'),
(N'Bài thơ “Mùa xuân nho nhỏ” là của nhà thơ:',N'Hữu Thỉnh',N'Y Phương',N'Viễn Phương',N'Thanh Hải',N'D',N'Ngữ văn',N'Thanh Hải viết bài thơ không lâu trước khi mất (1980).',N'NGUVAN-CD20'),
(N'Bài thơ “Viếng lăng Bác” là của nhà thơ:',N'Thanh Hải',N'Tố Hữu',N'Chế Lan Viên',N'Viễn Phương',N'D',N'Ngữ văn',N'Viễn Phương viết năm 1976 khi ra thăm lăng Bác.',N'NGUVAN-CD20'),
(N'Bài thơ “Sang thu” là của nhà thơ:',N'Hữu Thỉnh',N'Y Phương',N'Xuân Quỳnh',N'Nguyễn Duy',N'A',N'Ngữ văn',N'Hữu Thỉnh viết về khoảnh khắc giao mùa hạ – thu.',N'NGUVAN-CD20'),
(N'Bài thơ “Nói với con” là của nhà thơ:',N'Nguyễn Khoa Điềm',N'Y Phương',N'Hữu Thỉnh',N'Bằng Việt',N'B',N'Ngữ văn',N'Y Phương, nhà thơ dân tộc Tày.',N'NGUVAN-CD20'),
(N'Bài thơ “Bếp lửa” là của nhà thơ:',N'Bằng Việt',N'Y Phương',N'Nguyễn Duy',N'Tế Hanh',N'A',N'Ngữ văn',N'Bằng Việt viết năm 1963 khi đang học ở Liên Xô.',N'NGUVAN-CD20'),
(N'Bài thơ “Khúc hát ru những em bé lớn trên lưng mẹ” là của nhà thơ:',N'Thanh Hải',N'Bằng Việt',N'Nguyễn Khoa Điềm',N'Chính Hữu',N'C',N'Ngữ văn',N'Nguyễn Khoa Điềm viết năm 1971 ở chiến khu Trị – Thiên.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Làng” là của nhà văn:',N'Nguyễn Quang Sáng',N'Nguyễn Thành Long',N'Kim Lân',N'Nam Cao',N'C',N'Ngữ văn',N'Truyện về nhân vật ông Hai của Kim Lân.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Lặng lẽ Sa Pa” là của nhà văn:',N'Kim Lân',N'Nguyễn Thành Long',N'Lê Minh Khuê',N'Nguyễn Minh Châu',N'B',N'Ngữ văn',N'Nguyễn Thành Long viết năm 1970.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Chiếc lược ngà” là của nhà văn:',N'Nguyễn Quang Sáng',N'Nguyễn Thành Long',N'Lê Minh Khuê',N'Kim Lân',N'A',N'Ngữ văn',N'Truyện về tình cha con ông Sáu và bé Thu.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Những ngôi sao xa xôi” là của nhà văn:',N'Bảo Ninh',N'Lê Minh Khuê',N'Nguyễn Minh Châu',N'Nguyễn Quang Sáng',N'B',N'Ngữ văn',N'Truyện về ba cô gái thanh niên xung phong trên tuyến đường Trường Sơn.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Bến quê” là của nhà văn:',N'Kim Lân',N'Lê Minh Khuê',N'Nguyễn Khải',N'Nguyễn Minh Châu',N'D',N'Ngữ văn',N'Truyện in trong tập “Bến quê” (1985) của Nguyễn Minh Châu.',N'NGUVAN-CD20'),
(N'Đoạn trích “Đất Nước” (trường ca “Mặt đường khát vọng”) là của nhà thơ:',N'Nguyễn Khoa Điềm',N'Chế Lan Viên',N'Nguyễn Đình Thi',N'Tố Hữu',N'A',N'Ngữ văn',N'Trường ca “Mặt đường khát vọng” viết năm 1971.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Rừng xà nu” là của nhà văn:',N'Nguyễn Minh Châu',N'Nguyễn Thi',N'Anh Đức',N'Nguyễn Trung Thành',N'D',N'Ngữ văn',N'Nguyễn Trung Thành (Nguyên Ngọc) viết năm 1965.',N'NGUVAN-CD20'),
(N'Truyện ngắn “Những đứa con trong gia đình” là của nhà văn:',N'Nguyễn Thi',N'Nguyễn Quang Sáng',N'Anh Đức',N'Nguyễn Trung Thành',N'A',N'Ngữ văn',N'Truyện về chị em Chiến và Việt của Nguyễn Thi.',N'NGUVAN-CD20'),
(N'“Người lái đò sông Đà” của Nguyễn Tuân thuộc thể loại:',N'Tiểu thuyết',N'Thơ',N'Tùy bút',N'Truyện ngắn',N'C',N'Ngữ văn',N'Đây là bài tùy bút trong tập “Sông Đà”.',N'NGUVAN-CD20'),
(N'“Hồn Trương Ba, da hàng thịt” của Lưu Quang Vũ thuộc thể loại:',N'Tùy bút',N'Kịch',N'Thơ',N'Truyện ngắn',N'B',N'Ngữ văn',N'Đây là vở kịch nổi tiếng của Lưu Quang Vũ.',N'NGUVAN-CD20');
GO
-- Tiếng Anh: TIENGANH-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TIENGANH-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'I ___ to the cinema last night.',N'am going',N'go',N'went',N'have gone',N'C',N'Tiếng Anh',N'“Last night” → past simple: went.',N'TIENGANH-DE01'),
(N'They ___ football at the moment.',N'play',N'played',N'are playing',N'have played',N'C',N'Tiếng Anh',N'“At the moment” → present continuous.',N'TIENGANH-DE01'),
(N'She has worked here ___ five years.',N'for',N'in',N'ago',N'since',N'A',N'Tiếng Anh',N'“For” + a period of time with the present perfect.',N'TIENGANH-DE01'),
(N'Water ___ at 100 degrees Celsius.',N'is boiling',N'boils',N'has boiled',N'boiled',N'B',N'Tiếng Anh',N'A general truth → present simple.',N'TIENGANH-DE01'),
(N'By the time we arrived, the film ___.',N'has started',N'is starting',N'starts',N'had started',N'D',N'Tiếng Anh',N'An action before another past action → past perfect.',N'TIENGANH-DE01'),
(N'I will call you when I ___ home.',N'got',N'am getting',N'get',N'will get',N'C',N'Tiếng Anh',N'Time clauses with “when” use the present simple for the future.',N'TIENGANH-DE01'),
(N'If it rains tomorrow, we ___ at home.',N'stay',N'would stay',N'stayed',N'will stay',N'D',N'Tiếng Anh',N'First conditional: If + present simple, will + V.',N'TIENGANH-DE01'),
(N'If I were you, I ___ harder.',N'will study',N'would study',N'studied',N'study',N'B',N'Tiếng Anh',N'Second conditional: If + past (were), would + V.',N'TIENGANH-DE01'),
(N'The letter ___ yesterday.',N'has sent',N'is sent',N'was sent',N'sent',N'C',N'Tiếng Anh',N'Passive voice, past simple: was + V3.',N'TIENGANH-DE01'),
(N'English ___ all over the world.',N'spoke',N'is speaking',N'is spoken',N'speaks',N'C',N'Tiếng Anh',N'Passive voice, present simple: is + V3.',N'TIENGANH-DE01'),
(N'He asked me where I ___.',N'lived',N'live',N'living',N'lives',N'A',N'Tiếng Anh',N'Reported question: the tense moves back (live → lived).',N'TIENGANH-DE01'),
(N'I''m looking forward to ___ you.',N'be seen',N'see',N'seeing',N'saw',N'C',N'Tiếng Anh',N'“Look forward to” + V-ing.',N'TIENGANH-DE01');
GO
-- Tiếng Anh: TIENGANH-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TIENGANH-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Choose the word OPPOSITE in meaning to “ancient”.',N'old',N'modern',N'antique',N'historic',N'B',N'Tiếng Anh',N'“Ancient” means very old; the opposite is “modern”.',N'TIENGANH-DE02'),
(N'Choose the word CLOSEST in meaning to “happy”.',N'angry',N'sad',N'tired',N'glad',N'D',N'Tiếng Anh',N'“Glad” is a synonym of “happy”.',N'TIENGANH-DE02'),
(N'A person who treats sick animals is called a ___.',N'chef',N'dentist',N'pilot',N'vet',N'D',N'Tiếng Anh',N'A vet (veterinarian) is an animal doctor.',N'TIENGANH-DE02'),
(N'Which word means “to make something smaller or less”?',N'increase',N'reduce',N'extend',N'expand',N'B',N'Tiếng Anh',N'“Reduce” means to make smaller; the others mean to make bigger.',N'TIENGANH-DE02'),
(N'She is very ___; she always helps other people.',N'selfish',N'kind',N'rude',N'lazy',N'B',N'Tiếng Anh',N'Helping others shows that she is kind.',N'TIENGANH-DE02'),
(N'Choose the word OPPOSITE in meaning to “expensive”.',N'valuable',N'costly',N'precious',N'cheap',N'D',N'Tiếng Anh',N'“Cheap” is the opposite of “expensive”.',N'TIENGANH-DE02'),
(N'The ___ of this city is about eight million people.',N'population',N'position',N'popular',N'pollution',N'A',N'Tiếng Anh',N'“Population” is the number of people living in a place.',N'TIENGANH-DE02'),
(N'I am interested ___ learning foreign languages.',N'on',N'in',N'with',N'at',N'B',N'Tiếng Anh',N'Collocation: interested in.',N'TIENGANH-DE02'),
(N'He is good ___ mathematics.',N'for',N'on',N'at',N'in',N'C',N'Tiếng Anh',N'Collocation: good at.',N'TIENGANH-DE02'),
(N'She ___ a mistake in her test.',N'took',N'gave',N'did',N'made',N'D',N'Tiếng Anh',N'Collocation: make a mistake.',N'TIENGANH-DE02'),
(N'Please ___ off the lights before you leave.',N'put',N'take',N'give',N'turn',N'D',N'Tiếng Anh',N'Phrasal verb: turn off (the lights).',N'TIENGANH-DE02'),
(N'The plural form of “child” is ___.',N'childrens',N'childes',N'childs',N'children',N'D',N'Tiếng Anh',N'“Child” has the irregular plural “children”.',N'TIENGANH-DE02');
GO
-- Tiếng Anh: TIENGANH-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TIENGANH-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'A: “How are you?” – B: “___”',N'I''m a student.',N'I''m from Hanoi.',N'I''m 18 years old.',N'I''m fine, thank you.',N'D',N'Tiếng Anh',N'The usual reply to “How are you?” is about your health or feelings.',N'TIENGANH-DE03'),
(N'A: “Would you like a cup of tea?” – B: “___”',N'Good luck.',N'Never mind.',N'Yes, please.',N'You''re welcome.',N'C',N'Tiếng Anh',N'“Yes, please” accepts an offer politely.',N'TIENGANH-DE03'),
(N'A: “Thank you for your help.” – B: “___”',N'Yes, please.',N'You''re welcome.',N'Good luck.',N'Same to you.',N'B',N'Tiếng Anh',N'“You''re welcome” is the reply to thanks.',N'TIENGANH-DE03'),
(N'A: “Can I borrow your pen?” – B: “___”',N'I''m sorry to hear that.',N'Sure, here you are.',N'Bless you.',N'Congratulations!',N'B',N'Tiếng Anh',N'Agreeing to lend something: “Sure, here you are.”',N'TIENGANH-DE03'),
(N'A: “I passed the exam!” – B: “___”',N'Same to you.',N'Bless you.',N'Never mind.',N'Congratulations!',N'D',N'Tiếng Anh',N'We congratulate someone on good news.',N'TIENGANH-DE03'),
(N'The question “What does she look like?” asks about her ___.',N'address',N'appearance',N'hobbies',N'job',N'B',N'Tiếng Anh',N'“What does … look like?” asks about physical appearance.',N'TIENGANH-DE03'),
(N'A: “How often do you go swimming?” – B: “___”',N'By bus.',N'For two hours.',N'Since 2020.',N'Twice a week.',N'D',N'Tiếng Anh',N'“How often” asks about frequency.',N'TIENGANH-DE03'),
(N'A: “How long have you lived here?” – B: “___”',N'By car.',N'For three years.',N'Three kilometres.',N'Twice a year.',N'B',N'Tiếng Anh',N'“How long” with the present perfect asks about duration.',N'TIENGANH-DE03'),
(N'A: “Excuse me, where is the post office?” – B: “___”',N'It costs 10 dollars.',N'It''s at 8 o''clock.',N'It''s sunny today.',N'It''s next to the bank.',N'D',N'Tiếng Anh',N'The answer gives a place (location).',N'TIENGANH-DE03'),
(N'A: “Let''s go for a walk.” – B: “___”',N'I''m sorry to hear that.',N'Congratulations!',N'You''re welcome.',N'That''s a good idea.',N'D',N'Tiếng Anh',N'Agreeing with a suggestion.',N'TIENGANH-DE03'),
(N'Read: “Tom gets up at 6 a.m., has breakfast at 6.30 and goes to school at 7.” What time does Tom have breakfast?',N'At 6.30',N'At 6.00',N'At 7.00',N'At 7.30',N'A',N'Tiếng Anh',N'The text says he has breakfast at 6.30.',N'TIENGANH-DE03'),
(N'Read: “Mai has two brothers and one sister.” How many siblings does Mai have?',N'One',N'Two',N'Three',N'Four',N'C',N'Tiếng Anh',N'Two brothers + one sister = three siblings.',N'TIENGANH-DE03');
GO
-- Tiếng Anh: TIENGANH-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'TIENGANH-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'The ___ of the bridge took two years. (CONSTRUCT)',N'constructive',N'construct',N'construction',N'constructed',N'C',N'Tiếng Anh',N'After “the” we need a noun: construction.',N'TIENGANH-CD20'),
(N'She sings ___. (BEAUTIFUL)',N'beauty',N'beautiful',N'beautifully',N'beautify',N'C',N'Tiếng Anh',N'An adverb modifies the verb “sings”.',N'TIENGANH-CD20'),
(N'He is a ___ driver; he never has accidents. (CARE)',N'carefully',N'care',N'careful',N'carelessness',N'C',N'Tiếng Anh',N'An adjective goes before the noun “driver”.',N'TIENGANH-CD20'),
(N'Choose the noun form of “happy”.',N'happily',N'happiness',N'unhappy',N'happier',N'B',N'Tiếng Anh',N'The suffix -ness forms the noun: happiness.',N'TIENGANH-CD20'),
(N'Choose the adjective form of “danger”.',N'dangers',N'dangerously',N'endanger',N'dangerous',N'D',N'Tiếng Anh',N'The suffix -ous forms the adjective: dangerous.',N'TIENGANH-CD20'),
(N'The opposite of “possible” is ___.',N'inpossible',N'impossible',N'unpossible',N'dispossible',N'B',N'Tiếng Anh',N'Prefix im- is used before p: impossible.',N'TIENGANH-CD20'),
(N'The opposite of “agree” is ___.',N'unagree',N'inagree',N'disagree',N'imagree',N'C',N'Tiếng Anh',N'Prefix dis- with the verb agree: disagree.',N'TIENGANH-CD20'),
(N'I was born ___ 2008.',N'in',N'since',N'on',N'at',N'A',N'Tiếng Anh',N'“In” is used with years.',N'TIENGANH-CD20'),
(N'The meeting starts ___ 9 o''clock.',N'in',N'on',N'at',N'for',N'C',N'Tiếng Anh',N'“At” is used with clock times.',N'TIENGANH-CD20'),
(N'We have English ___ Monday.',N'by',N'on',N'in',N'at',N'B',N'Tiếng Anh',N'“On” is used with days of the week.',N'TIENGANH-CD20'),
(N'She is afraid ___ dogs.',N'of',N'with',N'from',N'about',N'A',N'Tiếng Anh',N'Collocation: afraid of.',N'TIENGANH-CD20'),
(N'He apologized ___ being late.',N'of',N'to',N'with',N'for',N'D',N'Tiếng Anh',N'Collocation: apologize for something.',N'TIENGANH-CD20'),
(N'The comparative form of “good” is ___.',N'more good',N'best',N'gooder',N'better',N'D',N'Tiếng Anh',N'Irregular: good – better – best.',N'TIENGANH-CD20'),
(N'The superlative form of “big” is ___.',N'the most big',N'bigger',N'the bigest',N'the biggest',N'D',N'Tiếng Anh',N'Double the final consonant: big → the biggest.',N'TIENGANH-CD20'),
(N'She is ___ than her sister. (TALL)',N'taller',N'the tallest',N'tallest',N'more tall',N'A',N'Tiếng Anh',N'Comparative with “than”: taller.',N'TIENGANH-CD20'),
(N'This is the most ___ film I have ever seen.',N'interesting',N'interestingly',N'interest',N'interested',N'A',N'Tiếng Anh',N'“-ing” adjectives describe things that cause the feeling.',N'TIENGANH-CD20'),
(N'I am very ___ in history.',N'interesting',N'interested',N'interestingly',N'interest',N'B',N'Tiếng Anh',N'“-ed” adjectives describe how a person feels.',N'TIENGANH-CD20'),
(N'He suggested ___ to the beach.',N'go',N'going',N'to go',N'went',N'B',N'Tiếng Anh',N'“Suggest” + V-ing.',N'TIENGANH-CD20'),
(N'She decided ___ abroad.',N'to study',N'studying',N'study',N'studied',N'A',N'Tiếng Anh',N'“Decide” + to V.',N'TIENGANH-CD20'),
(N'He has lived in Hanoi ___ 2015.',N'from',N'since',N'in',N'for',N'B',N'Tiếng Anh',N'“Since” + a point in time with the present perfect.',N'TIENGANH-CD20');
GO
-- Địa lý: DIALY-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'DIALY-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Đường bờ biển nước ta (từ Móng Cái đến Hà Tiên) dài khoảng:',N'4550 km',N'3260 km',N'1650 km',N'2360 km',N'B',N'Địa lý',N'Đường bờ biển Việt Nam dài khoảng 3260 km, không tính các đảo.',N'DIALY-DE01'),
(N'Tổng diện tích lãnh thổ (đất liền và các đảo) của nước ta khoảng:',N'131 nghìn km²',N'431 nghìn km²',N'231 nghìn km²',N'331 nghìn km²',N'D',N'Địa lý',N'Diện tích nước ta khoảng 331 nghìn km².',N'DIALY-DE01'),
(N'Hai quần đảo xa bờ của Việt Nam trên Biển Đông là:',N'Côn Đảo và Phú Quốc',N'Cát Bà và Bạch Long Vĩ',N'Hoàng Sa và Trường Sa',N'Thổ Chu và Lý Sơn',N'C',N'Địa lý',N'Quần đảo Hoàng Sa và Trường Sa nằm xa bờ trên Biển Đông.',N'DIALY-DE01'),
(N'Khí hậu Việt Nam mang tính chất:',N'Hoang mạc khô hạn',N'Nhiệt đới ẩm gió mùa',N'Cận cực',N'Ôn đới lục địa',N'B',N'Địa lý',N'Nước ta nằm trong vùng nội chí tuyến, chịu ảnh hưởng của gió mùa.',N'DIALY-DE01'),
(N'Đồng bằng có diện tích lớn nhất nước ta là:',N'Đồng bằng Thanh – Nghệ – Tĩnh',N'Đồng bằng sông Cửu Long',N'Đồng bằng sông Hồng',N'Đồng bằng duyên hải miền Trung',N'B',N'Địa lý',N'Đồng bằng sông Cửu Long rộng khoảng 40 nghìn km².',N'DIALY-DE01'),
(N'Sông nào sau đây là hệ thống sông lớn nhất chảy qua lãnh thổ nước ta?',N'Sông Mê Công (Cửu Long)',N'Sông Mã',N'Sông Thu Bồn',N'Sông Cả',N'A',N'Địa lý',N'Sông Mê Công là một trong những sông lớn nhất châu Á, hạ lưu chảy qua Nam Bộ.',N'DIALY-DE01'),
(N'Gió mùa mùa đông ở miền Bắc nước ta có hướng chủ yếu là:',N'Tây nam',N'Đông bắc',N'Tây bắc',N'Đông nam',N'B',N'Địa lý',N'Gió mùa Đông Bắc hoạt động từ khoảng tháng 11 đến tháng 4.',N'DIALY-DE01'),
(N'Dãy núi có hướng tây bắc – đông nam và có đỉnh Phan-xi-păng là:',N'Đông Triều',N'Hoàng Liên Sơn',N'Ngân Sơn',N'Bạch Mã',N'B',N'Địa lý',N'Đỉnh Phan-xi-păng (3143 m) nằm trên dãy Hoàng Liên Sơn.',N'DIALY-DE01'),
(N'Đèo Hải Vân nằm giữa hai thành phố:',N'Hà Nội và Hải Phòng',N'Huế và Đà Nẵng',N'Nha Trang và Đà Lạt',N'Cần Thơ và TP. Hồ Chí Minh',N'B',N'Địa lý',N'Đèo Hải Vân trên dãy Bạch Mã, ranh giới giữa Huế và Đà Nẵng.',N'DIALY-DE01'),
(N'Hồ thủy điện Hòa Bình được xây dựng trên sông:',N'Sông Lô',N'Sông Chảy',N'Sông Đà',N'Sông Hồng',N'C',N'Địa lý',N'Nhà máy thủy điện Hòa Bình khai thác nguồn nước sông Đà.',N'DIALY-DE01'),
(N'Vịnh Hạ Long – di sản thiên nhiên thế giới thuộc tỉnh:',N'Ninh Bình',N'Quảng Ninh',N'Hải Phòng',N'Thái Bình',N'B',N'Địa lý',N'Vịnh Hạ Long nằm ở tỉnh Quảng Ninh.',N'DIALY-DE01'),
(N'Cao nguyên Lâm Viên (nơi có thành phố Đà Lạt) thuộc vùng:',N'Bắc Trung Bộ',N'Tây Bắc',N'Đông Nam Bộ',N'Tây Nguyên',N'D',N'Địa lý',N'Lâm Viên là cao nguyên ở phía nam Tây Nguyên.',N'DIALY-DE01');
GO
-- Địa lý: DIALY-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'DIALY-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Thành phố trực thuộc trung ương có số dân đông nhất nước ta là:',N'Đà Nẵng',N'TP. Hồ Chí Minh',N'Hà Nội',N'Hải Phòng',N'B',N'Địa lý',N'TP. Hồ Chí Minh là đô thị đông dân nhất cả nước.',N'DIALY-DE02'),
(N'Theo Tổng cục Thống kê, dân số trung bình của nước ta năm 2023 khoảng:',N'120 triệu người',N'100,3 triệu người',N'85 triệu người',N'70 triệu người',N'B',N'Địa lý',N'Dân số trung bình năm 2023 ước tính 100,3 triệu người.',N'DIALY-DE02'),
(N'Dân tộc có số dân đông nhất ở nước ta là:',N'Thái',N'Mường',N'Kinh',N'Tày',N'C',N'Địa lý',N'Người Kinh chiếm khoảng 85% dân số.',N'DIALY-DE02'),
(N'Vùng trọng điểm sản xuất lúa lớn nhất nước ta là:',N'Tây Nguyên',N'Đồng bằng sông Hồng',N'Bắc Trung Bộ',N'Đồng bằng sông Cửu Long',N'D',N'Địa lý',N'Đồng bằng sông Cửu Long đóng góp hơn một nửa sản lượng lúa cả nước.',N'DIALY-DE02'),
(N'Cây công nghiệp lâu năm quan trọng nhất ở Tây Nguyên là:',N'Chè',N'Lúa',N'Cà phê',N'Mía',N'C',N'Địa lý',N'Đất badan và khí hậu cận xích đạo thích hợp cho cây cà phê.',N'DIALY-DE02'),
(N'Vùng trồng chè lớn nhất nước ta là:',N'Đông Nam Bộ',N'Trung du và miền núi Bắc Bộ',N'Đồng bằng sông Hồng',N'Đồng bằng sông Cửu Long',N'B',N'Địa lý',N'Khí hậu có mùa đông lạnh, địa hình đồi thích hợp cây chè.',N'DIALY-DE02'),
(N'Than đá ở nước ta được khai thác nhiều nhất tại:',N'Bình Định',N'Lạng Sơn',N'Quảng Ninh',N'Thái Nguyên',N'C',N'Địa lý',N'Bể than Quảng Ninh có trữ lượng lớn nhất cả nước.',N'DIALY-DE02'),
(N'Dầu mỏ ở nước ta được khai thác chủ yếu ở:',N'Quảng Ninh',N'Thềm lục địa phía Nam',N'Tây Nguyên',N'Đồng bằng sông Hồng',N'B',N'Địa lý',N'Các mỏ Bạch Hổ, Rồng… nằm ở thềm lục địa phía Nam.',N'DIALY-DE02'),
(N'Cảng biển lớn nhất miền Bắc nước ta là:',N'Quy Nhơn',N'Hải Phòng',N'Cần Thơ',N'Cam Ranh',N'B',N'Địa lý',N'Cảng Hải Phòng là cửa ngõ biển quan trọng của miền Bắc.',N'DIALY-DE02'),
(N'Tuyến quốc lộ chạy dọc từ Lạng Sơn đến Cà Mau, quan trọng nhất nước ta là:',N'Quốc lộ 51',N'Quốc lộ 6',N'Quốc lộ 5',N'Quốc lộ 1',N'D',N'Địa lý',N'Quốc lộ 1 nối hầu hết các vùng kinh tế từ Bắc vào Nam.',N'DIALY-DE02'),
(N'Chăn nuôi gia cầm phát triển mạnh ở các đồng bằng chủ yếu nhờ:',N'Nhiều đồng cỏ rộng lớn',N'Khí hậu lạnh quanh năm',N'Dân cư thưa thớt',N'Nguồn thức ăn dồi dào và thị trường tiêu thụ lớn',N'D',N'Địa lý',N'Đồng bằng có nhiều lương thực, dân cư đông.',N'DIALY-DE02'),
(N'Di sản thiên nhiên thế giới nổi tiếng với hệ thống hang động, trong đó có hang Sơn Đoòng, là:',N'Vườn quốc gia Cúc Phương',N'Vịnh Hạ Long',N'Vườn quốc gia Phong Nha – Kẻ Bàng',N'Quần thể danh thắng Tràng An',N'C',N'Địa lý',N'Hang Sơn Đoòng thuộc Vườn quốc gia Phong Nha – Kẻ Bàng.',N'DIALY-DE02');
GO
-- Địa lý: DIALY-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'DIALY-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Đại dương có diện tích lớn nhất thế giới là:',N'Đại Tây Dương',N'Ấn Độ Dương',N'Thái Bình Dương',N'Bắc Băng Dương',N'C',N'Địa lý',N'Thái Bình Dương chiếm khoảng một phần ba diện tích bề mặt Trái Đất.',N'DIALY-DE03'),
(N'Châu lục có diện tích lớn nhất là:',N'Châu Mỹ',N'Châu Âu',N'Châu Phi',N'Châu Á',N'D',N'Địa lý',N'Châu Á rộng khoảng 44 triệu km².',N'DIALY-DE03'),
(N'Đỉnh núi cao nhất thế giới là:',N'Kilimanjaro',N'Mont Blanc',N'Phan-xi-păng',N'Everest',N'D',N'Địa lý',N'Đỉnh Everest (dãy Himalaya) cao khoảng 8849 m.',N'DIALY-DE03'),
(N'Hoang mạc nhiệt đới lớn nhất thế giới là:',N'Gô-bi (Gobi)',N'Xa-ha-ra (Sahara)',N'A-ta-ca-ma (Atacama)',N'Ca-la-ha-ri (Kalahari)',N'B',N'Địa lý',N'Sahara ở Bắc Phi là hoang mạc nhiệt đới lớn nhất.',N'DIALY-DE03'),
(N'Theo ước tính của Liên hợp quốc năm 2023, quốc gia đông dân nhất thế giới là:',N'Hoa Kỳ',N'In-đô-nê-xi-a',N'Trung Quốc',N'Ấn Độ',N'D',N'Địa lý',N'Báo cáo Dân số thế giới 2023 của UNFPA ước tính Ấn Độ vượt Trung Quốc.',N'DIALY-DE03'),
(N'Việt Nam trở thành thành viên của ASEAN vào năm:',N'1995',N'1975',N'2007',N'1967',N'A',N'Địa lý',N'Việt Nam gia nhập ASEAN ngày 28/7/1995.',N'DIALY-DE03'),
(N'Trái Đất tự quay quanh trục một vòng mất khoảng:',N'24 giờ',N'12 giờ',N'365 ngày',N'30 ngày',N'A',N'Địa lý',N'Một ngày đêm khoảng 24 giờ.',N'DIALY-DE03'),
(N'Hiện tượng ngày và đêm luân phiên nhau trên Trái Đất là do:',N'Trái Đất chuyển động quanh Mặt Trời',N'Trục Trái Đất thẳng đứng',N'Mặt Trăng quay quanh Trái Đất',N'Trái Đất tự quay quanh trục',N'D',N'Địa lý',N'Trái Đất hình cầu và tự quay nên các nơi lần lượt được chiếu sáng.',N'DIALY-DE03'),
(N'Đường Xích đạo chia Trái Đất thành:',N'Châu Á và châu Âu',N'Nửa cầu Bắc và nửa cầu Nam',N'Lục địa và đại dương',N'Nửa cầu Đông và nửa cầu Tây',N'B',N'Địa lý',N'Xích đạo là vĩ tuyến 0°; kinh tuyến gốc chia nửa cầu Đông và Tây.',N'DIALY-DE03'),
(N'Trên bản đồ tỉ lệ 1 : 1 000 000, 1 cm ứng với khoảng cách thực tế:',N'1 km',N'10 km',N'100 m',N'100 km',N'B',N'Địa lý',N'1 000 000 cm = 10 km.',N'DIALY-DE03'),
(N'Dạng biểu đồ thích hợp nhất để thể hiện cơ cấu (tỉ trọng các thành phần) của một đối tượng trong một năm là:',N'Biểu đồ kết hợp cột – đường',N'Biểu đồ cột đơn',N'Biểu đồ tròn',N'Biểu đồ đường',N'C',N'Địa lý',N'Biểu đồ tròn thể hiện tỉ trọng các thành phần trong tổng thể.',N'DIALY-DE03'),
(N'Dạng biểu đồ thích hợp nhất để thể hiện tốc độ tăng trưởng của một đối tượng qua nhiều năm là:',N'Biểu đồ tròn',N'Biểu đồ đường',N'Biểu đồ miền',N'Biểu đồ cột chồng',N'B',N'Địa lý',N'Biểu đồ đường thể hiện tốt xu hướng, tốc độ thay đổi theo thời gian.',N'DIALY-DE03');
GO
-- Địa lý: DIALY-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'DIALY-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Thủ đô Hà Nội thuộc vùng:',N'Đồng bằng sông Hồng',N'Đông Nam Bộ',N'Trung du và miền núi Bắc Bộ',N'Bắc Trung Bộ',N'A',N'Địa lý',N'Hà Nội là trung tâm của vùng Đồng bằng sông Hồng.',N'DIALY-CD20'),
(N'TP. Hồ Chí Minh thuộc vùng:',N'Tây Nguyên',N'Đồng bằng sông Cửu Long',N'Duyên hải Nam Trung Bộ',N'Đông Nam Bộ',N'D',N'Địa lý',N'TP. Hồ Chí Minh là trung tâm kinh tế của Đông Nam Bộ.',N'DIALY-CD20'),
(N'Thành phố Cần Thơ thuộc vùng:',N'Đồng bằng sông Cửu Long',N'Tây Nguyên',N'Đông Nam Bộ',N'Duyên hải Nam Trung Bộ',N'A',N'Địa lý',N'Cần Thơ là thành phố trung tâm của Đồng bằng sông Cửu Long.',N'DIALY-CD20'),
(N'Sau khi sắp xếp đơn vị hành chính (từ ngày 1/7/2025), cả nước có bao nhiêu đơn vị hành chính cấp tỉnh?',N'63',N'28',N'54',N'34',N'D',N'Địa lý',N'Theo Nghị quyết của Quốc hội năm 2025, cả nước có 34 đơn vị hành chính cấp tỉnh (28 tỉnh và 6 thành phố).',N'DIALY-CD20'),
(N'Từ ngày 1/7/2025, số thành phố trực thuộc trung ương của nước ta là:',N'4',N'6',N'5',N'8',N'B',N'Địa lý',N'Gồm Hà Nội, Huế, Hải Phòng, Đà Nẵng, TP. Hồ Chí Minh và Cần Thơ.',N'DIALY-CD20'),
(N'Vùng có diện tích trồng cao su lớn nhất nước ta là:',N'Trung du và miền núi Bắc Bộ',N'Đồng bằng sông Hồng',N'Bắc Trung Bộ',N'Đông Nam Bộ',N'D',N'Địa lý',N'Đất xám, đất badan và khí hậu cận xích đạo thích hợp cho cây cao su.',N'DIALY-CD20'),
(N'Vùng có sản lượng nuôi trồng thủy sản lớn nhất nước ta là:',N'Trung du và miền núi Bắc Bộ',N'Bắc Trung Bộ',N'Đồng bằng sông Hồng',N'Đồng bằng sông Cửu Long',N'D',N'Địa lý',N'Mạng lưới sông ngòi, kênh rạch dày đặc và nhiều diện tích mặt nước.',N'DIALY-CD20'),
(N'Vùng có mật độ dân số cao nhất nước ta là:',N'Đồng bằng sông Cửu Long',N'Trung du và miền núi Bắc Bộ',N'Tây Nguyên',N'Đồng bằng sông Hồng',N'D',N'Địa lý',N'Đồng bằng sông Hồng có lịch sử khai thác lâu đời, dân cư rất đông đúc.',N'DIALY-CD20'),
(N'Vùng có tiềm năng thủy điện lớn nhất nước ta là:',N'Đồng bằng sông Hồng',N'Đông Nam Bộ',N'Đồng bằng sông Cửu Long',N'Trung du và miền núi Bắc Bộ',N'D',N'Địa lý',N'Hệ thống sông Hồng (sông Đà) có độ dốc lớn, lưu lượng nước dồi dào.',N'DIALY-CD20'),
(N'Thế mạnh nổi bật của vùng ven biển Nam Trung Bộ là:',N'Trồng lúa nước quy mô lớn nhất cả nước',N'Kinh tế biển: du lịch biển, khai thác hải sản, làm muối',N'Trồng chè quy mô lớn',N'Khai thác than đá',N'B',N'Địa lý',N'Vùng có đường bờ biển dài, nhiều bãi biển đẹp và ngư trường lớn.',N'DIALY-CD20'),
(N'Nghề làm muối phát triển mạnh ở ven biển Nam Trung Bộ chủ yếu nhờ:',N'Nhiệt độ cao, nhiều nắng, ít sông đổ ra biển',N'Mưa nhiều quanh năm',N'Có nhiều sông lớn đổ ra biển',N'Khí hậu lạnh, ít nắng',N'A',N'Địa lý',N'Nước biển mặn, nhiều nắng giúp bốc hơi nhanh.',N'DIALY-CD20'),
(N'Đất phèn và đất mặn chiếm diện tích lớn ở vùng:',N'Đồng bằng sông Hồng',N'Trung du và miền núi Bắc Bộ',N'Đồng bằng sông Cửu Long',N'Tây Nguyên',N'C',N'Địa lý',N'Địa hình thấp, chịu ảnh hưởng của thủy triều và nước biển.',N'DIALY-CD20'),
(N'Đất badan phân bố tập trung chủ yếu ở:',N'Ven biển Bắc Trung Bộ',N'Tây Nguyên và Đông Nam Bộ',N'Đồng bằng sông Cửu Long',N'Đồng bằng sông Hồng',N'B',N'Địa lý',N'Đất badan hình thành từ dung nham núi lửa ở các cao nguyên.',N'DIALY-CD20'),
(N'Thiên tai thường xuyên ảnh hưởng tới vùng Bắc Trung Bộ là:',N'Bão và gió phơn Tây Nam (gió Lào)',N'Núi lửa phun trào',N'Sóng thần xảy ra hằng năm',N'Băng tuyết kéo dài',N'A',N'Địa lý',N'Bắc Trung Bộ chịu nhiều bão và gió Tây khô nóng vào đầu mùa hạ.',N'DIALY-CD20'),
(N'Khu vực có mùa đông lạnh nhất nước ta là:',N'Tây Nguyên',N'Đồng bằng sông Cửu Long',N'Trung du và miền núi Bắc Bộ',N'Đông Nam Bộ',N'C',N'Địa lý',N'Vùng chịu ảnh hưởng mạnh nhất của gió mùa Đông Bắc, địa hình núi cao.',N'DIALY-CD20'),
(N'Hệ thống đê điều ven sông lớn và lâu đời nhất nước ta được xây dựng ở:',N'Tây Nguyên',N'Đồng bằng sông Hồng',N'Duyên hải Nam Trung Bộ',N'Đông Nam Bộ',N'B',N'Địa lý',N'Đê sông Hồng được đắp từ nhiều thế kỉ để chống lũ.',N'DIALY-CD20'),
(N'Vùng dẫn đầu cả nước về công nghiệp và dịch vụ là:',N'Tây Nguyên',N'Trung du và miền núi Bắc Bộ',N'Bắc Trung Bộ',N'Đông Nam Bộ',N'D',N'Địa lý',N'Đông Nam Bộ có cơ cấu kinh tế hiện đại, tập trung nhiều khu công nghiệp.',N'DIALY-CD20'),
(N'Vùng trồng cây ăn quả lớn nhất nước ta là:',N'Bắc Trung Bộ',N'Đồng bằng sông Cửu Long',N'Đồng bằng sông Hồng',N'Tây Nguyên',N'B',N'Địa lý',N'Khí hậu cận xích đạo, đất phù sa màu mỡ thích hợp cây ăn quả nhiệt đới.',N'DIALY-CD20'),
(N'Tuyến đường sắt dài nhất nước ta là:',N'Hà Nội – Hải Phòng',N'Đường sắt Thống Nhất (Hà Nội – TP. Hồ Chí Minh)',N'Hà Nội – Lào Cai',N'Hà Nội – Lạng Sơn',N'B',N'Địa lý',N'Đường sắt Thống Nhất dài khoảng 1726 km.',N'DIALY-CD20'),
(N'Cảng hàng không quốc tế đang được xây dựng ở tỉnh Đồng Nai là:',N'Cam Ranh',N'Nội Bài',N'Long Thành',N'Tân Sơn Nhất',N'C',N'Địa lý',N'Dự án Cảng hàng không quốc tế Long Thành tại Đồng Nai.',N'DIALY-CD20');
GO
-- Lịch sử: LICHSU-DE01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'LICHSU-DE01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Nhà nước đầu tiên của người Việt là:',N'Âu Lạc',N'Văn Lang',N'Đại Việt',N'Đại Cồ Việt',N'B',N'Lịch sử',N'Nhà nước Văn Lang do các vua Hùng đứng đầu.',N'LICHSU-DE01'),
(N'Kinh đô của nước Âu Lạc là:',N'Thăng Long',N'Phong Châu',N'Cổ Loa',N'Hoa Lư',N'C',N'Lịch sử',N'An Dương Vương đóng đô ở Cổ Loa.',N'LICHSU-DE01'),
(N'Chiến thắng Bạch Đằng năm 938 gắn với tên tuổi của:',N'Lê Hoàn',N'Lý Thường Kiệt',N'Ngô Quyền',N'Trần Hưng Đạo',N'C',N'Lịch sử',N'Ngô Quyền đánh tan quân Nam Hán trên sông Bạch Đằng năm 938.',N'LICHSU-DE01'),
(N'Năm 1010, Lý Công Uẩn dời đô từ Hoa Lư về:',N'Cổ Loa',N'Tây Đô',N'Đại La (đổi tên là Thăng Long)',N'Phú Xuân',N'C',N'Lịch sử',N'Chiếu dời đô năm 1010, Đại La đổi tên là Thăng Long.',N'LICHSU-DE01'),
(N'Ba lần kháng chiến chống quân Mông – Nguyên diễn ra dưới triều đại:',N'Nhà Lê sơ',N'Nhà Hồ',N'Nhà Lý',N'Nhà Trần',N'D',N'Lịch sử',N'Nhà Trần ba lần đánh thắng Mông – Nguyên (1258, 1285, 1287–1288).',N'LICHSU-DE01'),
(N'Bài thơ “Nam quốc sơn hà” gắn với cuộc kháng chiến chống quân:',N'Nguyên',N'Tống (thời Lý)',N'Thanh',N'Minh',N'B',N'Lịch sử',N'Bài thơ gắn với trận phòng tuyến sông Như Nguyệt năm 1077.',N'LICHSU-DE01'),
(N'Cuộc khởi nghĩa Lam Sơn (1418–1427) do ai lãnh đạo?',N'Lê Lợi',N'Nguyễn Huệ',N'Trần Quốc Tuấn',N'Lê Hoàn',N'A',N'Lịch sử',N'Lê Lợi lãnh đạo khởi nghĩa Lam Sơn chống quân Minh.',N'LICHSU-DE01'),
(N'Quang Trung đại phá quân Thanh vào năm:',N'1789',N'1858',N'1771',N'1802',N'A',N'Lịch sử',N'Chiến thắng Ngọc Hồi – Đống Đa đầu xuân Kỷ Dậu 1789.',N'LICHSU-DE01'),
(N'Người đặt quốc hiệu Đại Cồ Việt là:',N'Lý Công Uẩn',N'Lê Hoàn',N'Đinh Bộ Lĩnh',N'Ngô Quyền',N'C',N'Lịch sử',N'Năm 968 Đinh Bộ Lĩnh lên ngôi, đặt quốc hiệu Đại Cồ Việt.',N'LICHSU-DE01'),
(N'Văn Miếu ở Thăng Long được xây dựng năm 1070 dưới triều:',N'Nhà Lý',N'Nhà Trần',N'Nhà Lê sơ',N'Nhà Nguyễn',N'A',N'Lịch sử',N'Vua Lý Thánh Tông cho xây Văn Miếu năm 1070.',N'LICHSU-DE01'),
(N'Khởi nghĩa Hai Bà Trưng năm 40 chống lại ách đô hộ của:',N'Nhà Đường',N'Nhà Hán',N'Nhà Minh',N'Nhà Tống',N'B',N'Lịch sử',N'Hai Bà Trưng khởi nghĩa chống nhà Đông Hán.',N'LICHSU-DE01'),
(N'Kinh đô của triều Nguyễn là:',N'Gia Định',N'Thăng Long',N'Hoa Lư',N'Phú Xuân (Huế)',N'D',N'Lịch sử',N'Năm 1802 Gia Long đóng đô ở Phú Xuân.',N'LICHSU-DE01');
GO
-- Lịch sử: LICHSU-DE02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'LICHSU-DE02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Thực dân Pháp nổ súng xâm lược nước ta tại Đà Nẵng vào năm:',N'1884',N'1945',N'1802',N'1858',N'D',N'Lịch sử',N'Ngày 1/9/1858 liên quân Pháp – Tây Ban Nha tấn công Đà Nẵng.',N'LICHSU-DE02'),
(N'Nguyễn Tất Thành ra đi tìm đường cứu nước vào năm:',N'1930',N'1945',N'1920',N'1911',N'D',N'Lịch sử',N'Ngày 5/6/1911 tại bến cảng Nhà Rồng.',N'LICHSU-DE02'),
(N'Đảng Cộng sản Việt Nam được thành lập năm:',N'1925',N'1930',N'1941',N'1945',N'B',N'Lịch sử',N'Hội nghị thành lập Đảng đầu năm 1930.',N'LICHSU-DE02'),
(N'Cách mạng tháng Tám thành công vào năm:',N'1954',N'1975',N'1930',N'1945',N'D',N'Lịch sử',N'Tổng khởi nghĩa giành chính quyền tháng 8/1945.',N'LICHSU-DE02'),
(N'Mặt trận Việt Minh được thành lập năm:',N'1936',N'1930',N'1945',N'1941',N'D',N'Lịch sử',N'Thành lập theo chủ trương của Hội nghị Trung ương 8 (5/1941).',N'LICHSU-DE02'),
(N'Hiệp định Giơ-ne-vơ về Đông Dương được kí kết năm:',N'1973',N'1946',N'1954',N'1975',N'C',N'Lịch sử',N'Hiệp định kí ngày 21/7/1954.',N'LICHSU-DE02'),
(N'Hiệp định Pa-ri về chấm dứt chiến tranh, lập lại hòa bình ở Việt Nam được kí năm:',N'1975',N'1954',N'1968',N'1973',N'D',N'Lịch sử',N'Hiệp định kí ngày 27/1/1973.',N'LICHSU-DE02'),
(N'Trận “Điện Biên Phủ trên không” diễn ra vào cuối năm:',N'1968',N'1975',N'1954',N'1972',N'D',N'Lịch sử',N'Quân dân miền Bắc đánh bại cuộc tập kích bằng B-52 tháng 12/1972.',N'LICHSU-DE02'),
(N'Tổng chỉ huy chiến dịch Điện Biên Phủ năm 1954 là:',N'Đại tướng Nguyễn Chí Thanh',N'Đại tướng Văn Tiến Dũng',N'Đại tướng Võ Nguyên Giáp',N'Đồng chí Trường Chinh',N'C',N'Lịch sử',N'Đại tướng Võ Nguyên Giáp là Tổng tư lệnh, chỉ huy chiến dịch.',N'LICHSU-DE02'),
(N'Đường lối Đổi mới được đề ra tại Đại hội đại biểu toàn quốc lần thứ mấy của Đảng?',N'Lần thứ IV (1976)',N'Lần thứ VII (1991)',N'Lần thứ VI (1986)',N'Lần thứ V (1982)',N'C',N'Lịch sử',N'Đại hội VI (12/1986) mở đầu công cuộc Đổi mới.',N'LICHSU-DE02'),
(N'Việt Nam trở thành thành viên Tổ chức Thương mại thế giới (WTO) năm:',N'1995',N'2010',N'2007',N'2000',N'C',N'Lịch sử',N'Việt Nam chính thức gia nhập WTO ngày 11/1/2007.',N'LICHSU-DE02'),
(N'Cuộc Tổng tuyển cử bầu Quốc hội khóa I diễn ra ngày:',N'2/9/1945',N'30/4/1975',N'6/1/1946',N'19/12/1946',N'C',N'Lịch sử',N'Ngày 6/1/1946 cả nước đi bầu Quốc hội khóa I.',N'LICHSU-DE02');
GO
-- Lịch sử: LICHSU-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'LICHSU-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Chiến tranh thế giới thứ nhất diễn ra trong khoảng thời gian:',N'1939 – 1945',N'1905 – 1910',N'1914 – 1918',N'1920 – 1925',N'C',N'Lịch sử',N'Chiến tranh thế giới thứ nhất kéo dài từ 1914 đến 1918.',N'LICHSU-DE03'),
(N'Chiến tranh thế giới thứ hai kết thúc vào năm:',N'1950',N'1945',N'1939',N'1918',N'B',N'Lịch sử',N'Nhật Bản đầu hàng tháng 8/1945.',N'LICHSU-DE03'),
(N'Tổ chức Liên hợp quốc được thành lập năm:',N'1945',N'1967',N'1949',N'1919',N'A',N'Lịch sử',N'Hiến chương Liên hợp quốc có hiệu lực ngày 24/10/1945.',N'LICHSU-DE03'),
(N'Hiệp hội các quốc gia Đông Nam Á (ASEAN) được thành lập năm:',N'1975',N'1995',N'1945',N'1967',N'D',N'Lịch sử',N'Tuyên bố Băng Cốc ngày 8/8/1967.',N'LICHSU-DE03'),
(N'Cách mạng tháng Mười Nga thành công năm:',N'1789',N'1905',N'1945',N'1917',N'D',N'Lịch sử',N'Cách mạng tháng Mười Nga năm 1917.',N'LICHSU-DE03'),
(N'Cách mạng tư sản Pháp bùng nổ năm:',N'1917',N'1640',N'1776',N'1789',N'D',N'Lịch sử',N'Ngày 14/7/1789 nhân dân Pa-ri tấn công ngục Ba-xti.',N'LICHSU-DE03'),
(N'Bức tường Béc-lin sụp đổ năm:',N'1961',N'1991',N'1989',N'1975',N'C',N'Lịch sử',N'Bức tường Béc-lin bị phá bỏ tháng 11/1989.',N'LICHSU-DE03'),
(N'Liên bang Xô viết tan rã vào năm:',N'2000',N'1991',N'1989',N'1985',N'B',N'Lịch sử',N'Liên Xô chấm dứt tồn tại cuối năm 1991.',N'LICHSU-DE03'),
(N'Người đầu tiên bay vào vũ trụ là:',N'I-u-ri Ga-ga-rin',N'Valentina Tereshkova',N'Neil Armstrong',N'Phạm Tuân',N'A',N'Lịch sử',N'Ngày 12/4/1961 Gagarin bay vào vũ trụ trên tàu Phương Đông.',N'LICHSU-DE03'),
(N'Con người lần đầu tiên đặt chân lên Mặt Trăng vào năm:',N'1961',N'1957',N'1969',N'1975',N'C',N'Lịch sử',N'Tàu Apollo 11 đưa con người lên Mặt Trăng năm 1969.',N'LICHSU-DE03'),
(N'Cách mạng công nghiệp lần thứ nhất bắt đầu ở nước:',N'Anh',N'Đức',N'Pháp',N'Mỹ',N'A',N'Lịch sử',N'Cách mạng công nghiệp bắt đầu ở Anh từ nửa sau thế kỉ XVIII.',N'LICHSU-DE03'),
(N'Bản Tuyên ngôn Độc lập của Mỹ được công bố năm:',N'1789',N'1917',N'1865',N'1776',N'D',N'Lịch sử',N'Tuyên ngôn Độc lập Hoa Kỳ ngày 4/7/1776.',N'LICHSU-DE03');
GO
-- Lịch sử: LICHSU-CD20 (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'LICHSU-CD20')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Hội nghị thành lập Đảng Cộng sản Việt Nam (1930) do ai chủ trì?',N'Nguyễn Ái Quốc',N'Trần Phú',N'Trường Chinh',N'Lê Hồng Phong',N'A',N'Lịch sử',N'Nguyễn Ái Quốc chủ trì hội nghị hợp nhất tại Hương Cảng (Trung Quốc).',N'LICHSU-CD20'),
(N'Lời kêu gọi toàn quốc kháng chiến của Chủ tịch Hồ Chí Minh ra đời ngày:',N'7/5/1954',N'2/9/1945',N'19/12/1946',N'6/1/1946',N'C',N'Lịch sử',N'Đêm 19/12/1946 cuộc kháng chiến toàn quốc bùng nổ.',N'LICHSU-CD20'),
(N'Chiến dịch Việt Bắc thu – đông diễn ra năm:',N'1947',N'1953',N'1950',N'1946',N'A',N'Lịch sử',N'Chiến dịch Việt Bắc thu – đông 1947 đánh bại cuộc tấn công của Pháp lên căn cứ địa.',N'LICHSU-CD20'),
(N'Chiến dịch Biên giới thu – đông diễn ra năm:',N'1954',N'1950',N'1951',N'1947',N'B',N'Lịch sử',N'Chiến dịch Biên giới 1950 khai thông biên giới Việt – Trung.',N'LICHSU-CD20'),
(N'Chiến dịch Điện Biên Phủ diễn ra trong:',N'81 ngày đêm',N'30 ngày đêm',N'56 ngày đêm',N'60 ngày đêm',N'C',N'Lịch sử',N'Từ 13/3 đến 7/5/1954, tổng cộng 56 ngày đêm.',N'LICHSU-CD20'),
(N'Chiến dịch Điện Biên Phủ diễn ra trong khoảng thời gian:',N'13/3 – 7/5/1954',N'7/5 – 21/7/1954',N'20/11/1953 – 7/5/1954',N'13/3 – 21/7/1954',N'A',N'Lịch sử',N'Quân ta nổ súng ngày 13/3/1954, chiến dịch kết thúc thắng lợi ngày 7/5/1954.',N'LICHSU-CD20'),
(N'Kế hoạch quân sự Na-va của Pháp bị phá sản hoàn toàn bởi:',N'Chiến dịch Việt Bắc',N'Chiến dịch Hòa Bình',N'Chiến thắng Điện Biên Phủ',N'Chiến dịch Biên giới',N'C',N'Lịch sử',N'Thắng lợi Điện Biên Phủ đập tan kế hoạch Na-va.',N'LICHSU-CD20'),
(N'Sau Hiệp định Giơ-ne-vơ, nước ta tạm thời bị chia cắt làm hai miền ở vĩ tuyến:',N'16',N'17',N'38',N'20',N'B',N'Lịch sử',N'Vĩ tuyến 17 (sông Bến Hải) là giới tuyến quân sự tạm thời.',N'LICHSU-CD20'),
(N'Thủ đô Hà Nội được giải phóng vào ngày:',N'10/10/1954',N'2/9/1945',N'30/4/1975',N'19/12/1946',N'A',N'Lịch sử',N'Bộ đội ta tiến vào tiếp quản Thủ đô ngày 10/10/1954.',N'LICHSU-CD20'),
(N'Phong trào “Đồng khởi” ở miền Nam diễn ra trong những năm:',N'1954 – 1955',N'1959 – 1960',N'1965 – 1966',N'1968 – 1969',N'B',N'Lịch sử',N'Đồng khởi bùng nổ mạnh mẽ nhất ở Bến Tre (1/1960).',N'LICHSU-CD20'),
(N'Chiến lược “Chiến tranh đặc biệt” của Mỹ được thực hiện ở miền Nam trong giai đoạn:',N'1961 – 1965',N'1954 – 1960',N'1965 – 1968',N'1969 – 1973',N'A',N'Lịch sử',N'Chiến tranh đặc biệt dùng quân đội Sài Gòn là chủ yếu, có cố vấn Mỹ.',N'LICHSU-CD20'),
(N'Chiến thắng Ấp Bắc (1963) chứng tỏ quân dân miền Nam có khả năng đánh bại chiến lược:',N'“Việt Nam hóa chiến tranh”',N'“Chiến tranh tổng lực”',N'“Chiến tranh cục bộ”',N'“Chiến tranh đặc biệt”',N'D',N'Lịch sử',N'Ấp Bắc là trận thắng lớn trong thời kì Chiến tranh đặc biệt.',N'LICHSU-CD20'),
(N'Chiến thắng Vạn Tường (1965) mở đầu cao trào “tìm Mỹ mà đánh” trong thời kì Mỹ thực hiện chiến lược:',N'“Chiến tranh cục bộ”',N'“Chiến tranh tổng lực”',N'“Chiến tranh đặc biệt”',N'“Việt Nam hóa chiến tranh”',N'A',N'Lịch sử',N'Vạn Tường (Quảng Ngãi, 8/1965) là trận đầu đánh thắng quân viễn chinh Mỹ.',N'LICHSU-CD20'),
(N'Chiến lược “Việt Nam hóa chiến tranh” được Mỹ thực hiện trong giai đoạn:',N'1969 – 1973',N'1965 – 1968',N'1954 – 1960',N'1961 – 1965',N'A',N'Lịch sử',N'Mỹ rút dần quân, dùng quân đội Sài Gòn là chủ yếu từ 1969.',N'LICHSU-CD20'),
(N'Cuộc Tổng tiến công và nổi dậy Tết Mậu Thân diễn ra năm:',N'1965',N'1968',N'1972',N'1975',N'B',N'Lịch sử',N'Tổng tiến công và nổi dậy Tết Mậu Thân năm 1968.',N'LICHSU-CD20'),
(N'Tuyến đường chi viện chiến lược từ miền Bắc vào miền Nam trong kháng chiến chống Mỹ là:',N'Đường số 9',N'Quốc lộ 1',N'Đường Trường Sơn (đường Hồ Chí Minh)',N'Đường sắt Thống Nhất',N'C',N'Lịch sử',N'Đường Trường Sơn mở từ tháng 5/1959.',N'LICHSU-CD20'),
(N'Chiến dịch mở đầu cuộc Tổng tiến công và nổi dậy Xuân 1975 là:',N'Chiến dịch Hồ Chí Minh',N'Chiến dịch Huế – Đà Nẵng',N'Chiến dịch Tây Nguyên',N'Chiến dịch Quảng Trị',N'C',N'Lịch sử',N'Trận then chốt Buôn Ma Thuột (3/1975) mở đầu chiến dịch Tây Nguyên.',N'LICHSU-CD20'),
(N'Chiến dịch Hồ Chí Minh là chiến dịch cuối cùng của:',N'Cuộc Tổng tiến công Tết Mậu Thân 1968',N'Cuộc Tổng tiến công và nổi dậy Xuân 1975',N'Cuộc tiến công chiến lược năm 1972',N'Cuộc tiến công chiến lược Đông – Xuân 1953 – 1954',N'B',N'Lịch sử',N'Chiến dịch Hồ Chí Minh (26 – 30/4/1975) kết thúc cuộc kháng chiến chống Mỹ.',N'LICHSU-CD20'),
(N'Xe tăng Quân giải phóng tiến vào Dinh Độc Lập, chính quyền Sài Gòn đầu hàng vào ngày:',N'30/4/1975',N'1/5/1975',N'2/9/1975',N'26/4/1975',N'A',N'Lịch sử',N'Trưa 30/4/1975, miền Nam hoàn toàn giải phóng.',N'LICHSU-CD20'),
(N'Nước ta mang tên Cộng hòa xã hội chủ nghĩa Việt Nam từ năm:',N'1945',N'1976',N'1975',N'1986',N'B',N'Lịch sử',N'Quốc hội khóa VI (7/1976) quyết định đổi tên nước.',N'LICHSU-CD20');
GO
-- Sinh học: SINH10-GK1-DE03 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'SINH10-GK1-DE03')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Sinh học tế bào tập trung nghiên cứu nội dung nào?',N'Sự phân bố sinh vật theo vùng khí hậu',N'Cấu trúc và hoạt động của tế bào',N'Mối quan hệ giữa các quần thể',N'Quy luật di truyền qua nhiều thế hệ',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 1).',N'SINH10-GK1-DE03'),
(N'Để kiểm tra ảnh hưởng của lượng nước tưới đến chiều cao cây, đại lượng nào phải được đo làm biến phụ thuộc?',N'Loại đất trồng cây',N'Thể tích nước tưới',N'Chiều cao cây sau thời gian xác định',N'Số lần tưới được quy định',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 2).',N'SINH10-GK1-DE03'),
(N'Cấp tổ chức sống nào hình thành trực tiếp từ các cơ thể cùng loài có khả năng sinh sản trong một khu vực?',N'Quần thể',N'Quần xã',N'Hệ sinh thái',N'Sinh quyển',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 3).',N'SINH10-GK1-DE03'),
(N'Một đàn cá cùng loài và một hồ chứa nhiều loài cá khác nhau lần lượt thuộc hai cấp tổ chức nào khi chỉ xét thành phần sinh vật?',N'Quần xã – quần thể',N'Quần thể – hệ sinh thái',N'Cơ thể – quần xã',N'Quần thể – quần xã',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 4).',N'SINH10-GK1-DE03'),
(N'Dãy nào gồm toàn các nguyên tố thường được xếp vào nhóm đa lượng của tế bào?',N'C, H, O, N',N'Fe, Cu, Zn, I',N'C, Zn, O, Cu',N'I, N, Cu, H',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 5).',N'SINH10-GK1-DE03'),
(N'Phát biểu nào mô tả đúng một phân tử nước?',N'Oxygen mang điện tích dương một phần, hydrogen mang điện tích âm một phần',N'Hai liên kết O–H trong nước là liên kết hydrogen',N'Phân tử gồm hai H và một O, có sự phân bố điện tích không đều',N'Nước không tương tác được với các ion tan trong dung dịch',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 6).',N'SINH10-GK1-DE03'),
(N'Vì sao nước có thể góp phần ổn định nhiệt độ tế bào khi môi trường thay đổi?',N'Vì nước không hấp thụ nhiệt',N'Vì nước có nhiệt dung riêng tương đối cao, liên quan đến liên kết hydrogen',N'Vì mọi chất tan trong nước đều có nhiệt dung giống nhau',N'Vì liên kết cộng hóa trị O–H liên tục bị phá vỡ khi cơ thể ấm lên',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 7).',N'SINH10-GK1-DE03'),
(N'Đơn phân cấu tạo nên protein là',N'nucleotide',N'monosaccharide',N'glycerol',N'amino acid',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 8).',N'SINH10-GK1-DE03'),
(N'Cặp nào gồm hai polysaccharide nhưng đảm nhiệm chức năng chủ yếu khác nhau ở thực vật?',N'Glucose – fructose',N'Tinh bột – cellulose',N'Sucrose – maltose',N'Glycerol – cellulose',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 9).',N'SINH10-GK1-DE03'),
(N'Một protein bị mất cấu trúc không gian do nhiệt nhưng chuỗi amino acid chưa bị cắt. Nhận định phù hợp nhất là',N'Protein vẫn luôn hoạt động bình thường vì bậc một không đổi',N'Mọi liên kết peptide đã bị phá vỡ',N'Chức năng có thể suy giảm vì hình dạng không gian bị thay đổi',N'Protein đã chuyển thành carbohydrate',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 10).',N'SINH10-GK1-DE03'),
(N'Muốn phát hiện tinh bột trong dịch mẫu, nên ưu tiên sử dụng',N'dung dịch iodine/Lugol',N'thuốc thử Biuret',N'giấy thấm để phát hiện dầu',N'dung dịch Benedict đun nóng',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 11).',N'SINH10-GK1-DE03'),
(N'Về tế bào nhân sơ, mô tả nào phân biệt chính xác vùng nhân và ribosome?',N'Cả hai đều là bào quan có màng kép',N'Vùng nhân tổng hợp protein, còn ribosome lưu giữ phần lớn DNA',N'Ribosome chứa DNA dạng vòng, còn vùng nhân chỉ chứa RNA',N'Vùng nhân chứa phần lớn DNA; ribosome là nơi tổng hợp protein',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề tham khảo giữa học kì I Sinh học 10, đề số 3 (câu 12).',N'SINH10-GK1-DE03');
GO
-- Sinh học: SINH10-GK1-MD01 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'SINH10-GK1-MD01')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Lĩnh vực nào của Sinh học nghiên cứu cấu tạo và hoạt động của tế bào?',N'Sinh thái học',N'Sinh học tế bào',N'Di truyền học quần thể',N'Sinh học tiến hóa',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 1).',N'SINH10-GK1-MD01'),
(N'Một học sinh dùng kính hiển vi để ghi lại hình dạng của tế bào biểu bì hành mà không tác động làm thay đổi mẫu. Phương pháp chủ yếu được sử dụng là gì?',N'Thực nghiệm có đối chứng',N'Mô hình hóa toán học',N'Quan sát',N'Điều tra bằng bảng hỏi',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 2).',N'SINH10-GK1-MD01'),
(N'Dãy nào xếp đúng các cấp độ tổ chức sống từ thấp đến cao?',N'Tế bào → cơ thể → quần thể → quần xã → hệ sinh thái',N'Tế bào → quần thể → cơ thể → hệ sinh thái → quần xã',N'Cơ thể → tế bào → quần thể → quần xã → hệ sinh thái',N'Tế bào → cơ thể → quần xã → quần thể → hệ sinh thái',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 3).',N'SINH10-GK1-MD01'),
(N'Nhiều quần thể thuộc các loài khác nhau cùng sinh sống và tương tác trong một khu vực tạo thành quần xã. Điều này thể hiện trực tiếp điều gì?',N'Mọi quần thể có cùng kiểu gene',N'Quần xã không chịu ảnh hưởng của môi trường',N'Quần xã chỉ gồm một cấp tổ chức thấp hơn',N'Cấp tổ chức cao hình thành từ các cấp thấp hơn và có những đặc tính mới',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 4).',N'SINH10-GK1-MD01'),
(N'Nhóm nào chỉ gồm các nguyên tố thường được xếp vào nhóm đa lượng của tế bào?',N'Fe, Zn, Cu, I',N'C, H, O, N',N'C, H, Zn, Cu',N'Fe, O, I, N',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 5).',N'SINH10-GK1-MD01'),
(N'Trong phân tử nước, phát biểu nào đúng?',N'O mang điện tích dương một phần; H mang điện tích âm một phần',N'Hai nguyên tử H liên kết với nhau bằng liên kết hydrogen',N'Hai liên kết O–H là liên kết cộng hóa trị phân cực',N'Phân tử nước không có sự phân bố điện tích lệch nhau',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 6).',N'SINH10-GK1-MD01'),
(N'Vì sao muối ăn có thể phân tán trong nước khi được khuấy tan?',N'Các cực điện tích một phần của phân tử nước tương tác với ion của muối',N'Nước chuyển mọi ion thành chất không phân cực',N'Nước phá hủy hạt nhân của ion natri và chloride',N'Nước không tạo tương tác với các chất mang điện',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 7).',N'SINH10-GK1-MD01'),
(N'Đơn phân tạo nên chuỗi polypeptide là gì?',N'Nucleotide',N'Monosaccharide',N'Acid béo',N'Amino acid',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 8).',N'SINH10-GK1-MD01'),
(N'Phân tử nào tham gia chủ yếu vào cấu tạo thành tế bào thực vật?',N'Glycogen',N'Cellulose',N'Triglyceride',N'Tinh bột',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 9).',N'SINH10-GK1-MD01'),
(N'Hai chất đều được cấu tạo từ các đơn vị glucose nhưng có chức năng chính khác nhau ở thực vật là',N'tinh bột dự trữ năng lượng và cellulose tạo cấu trúc thành tế bào',N'cellulose dự trữ năng lượng và tinh bột cấu tạo màng sinh chất',N'glycogen tạo thành tế bào và cellulose mang thông tin di truyền',N'tinh bột và cellulose đều là enzyme xúc tác',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 10).',N'SINH10-GK1-MD01'),
(N'Để nhận biết sự có mặt của protein trong mẫu lòng trắng trứng pha loãng, cần dùng phép thử nào?',N'Iodine/Lugol',N'Benedict có đun nóng',N'Biuret',N'Nhũ tương ethanol–nước',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 11).',N'SINH10-GK1-MD01'),
(N'Tế bào vi khuẩn không có nhân hoàn chỉnh nhưng vẫn tổng hợp được protein. Giải thích phù hợp nhất là',N'DNA của vi khuẩn thay thế trực tiếp ribosome',N'ribosome không có màng là nơi tổng hợp protein',N'thành tế bào vi khuẩn tổng hợp tất cả protein',N'mọi protein đều phải lấy nguyên vẹn từ môi trường',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 01 (câu 12).',N'SINH10-GK1-MD01');
GO
-- Sinh học: SINH10-GK1-MD02 (12 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'SINH10-GK1-MD02')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Hoạt động nào thể hiện ứng dụng Sinh học góp phần bảo vệ môi trường?',N'Khai thác không giới hạn các loài quý hiếm',N'Phá bỏ hoàn toàn khu vực cư trú tự nhiên',N'Dùng vi sinh vật phù hợp xử lí một số chất thải',N'Loại bỏ tất cả sinh vật phân giải trong đất',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 1).',N'SINH10-GK1-MD02'),
(N'Để nghiên cứu ảnh hưởng của ánh sáng đến sinh trưởng cây, hoạt động nào là một bước của phương pháp thực nghiệm?',N'Thay đổi ánh sáng và đồng thời thay mọi điều kiện khác',N'Bố trí các nhóm cây tương đồng, thay đổi mức chiếu sáng cần khảo sát',N'Chỉ lựa chọn kết quả đúng với dự đoán ban đầu',N'Bỏ qua việc ghi lại chiều cao cây theo thời gian',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 2).',N'SINH10-GK1-MD02'),
(N'Cấp tổ chức nào gồm các cá thể cùng loài sống trong một khu vực xác định ở cùng thời điểm?',N'Quần xã',N'Hệ sinh thái',N'Sinh quyển',N'Quần thể',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 3).',N'SINH10-GK1-MD02'),
(N'Một khu rừng gồm nhiều quần thể sinh vật và các thành phần vô sinh tương tác với nhau được xếp vào hệ sinh thái, không chỉ là quần xã, vì',N'hệ sinh thái bao gồm cả quần xã và các yếu tố vô sinh tương tác',N'hệ sinh thái chỉ gồm một loài sinh vật',N'quần xã bao gồm cả đất, nước và khí hậu còn hệ sinh thái thì không',N'quần xã không có tương tác giữa các loài',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 4).',N'SINH10-GK1-MD02'),
(N'Nguyên tố nào thường được xếp vào nhóm vi lượng trong tế bào?',N'Carbon',N'Oxygen',N'Zinc (Zn)',N'Hydrogen',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 5).',N'SINH10-GK1-MD02'),
(N'Trong một phân tử nước có bao nhiêu nguyên tử oxygen?',N'2',N'1',N'3',N'4',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 6).',N'SINH10-GK1-MD02'),
(N'Nước có nhiệt dung riêng tương đối cao, nhờ đó giúp cơ thể hạn chế biến động nhiệt độ nhanh. Đặc tính này liên quan nhiều đến',N'việc nước không thể bay hơi',N'việc phân tử nước không có cực',N'sự không tồn tại liên kết giữa các phân tử nước',N'mạng liên kết hydrogen giữa các phân tử nước',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 7).',N'SINH10-GK1-MD02'),
(N'Đơn phân của nucleic acid là',N'nucleotide',N'amino acid',N'glucose',N'glycerol',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 8).',N'SINH10-GK1-MD02'),
(N'Nhóm nào gồm toàn các lipid?',N'Glucose, glycogen, tinh bột',N'DNA, RNA, phospholipid',N'Triglyceride, phospholipid, steroid',N'Cellulose, cholesterol, protein',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 9).',N'SINH10-GK1-MD02'),
(N'Vì sao phospholipid thường hình thành lớp kép trong môi trường nước?',N'Toàn bộ phân tử phospholipid đều ưa nước',N'Đầu ưa nước hướng ra môi trường nước, còn đuôi kị nước quay vào phía trong',N'Các đuôi kị nước hướng ra ngoài tiếp xúc trực tiếp với nước',N'Phospholipid có cấu tạo là chuỗi amino acid',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 10).',N'SINH10-GK1-MD02'),
(N'Khi muốn nhận biết glucose là đường khử trong mẫu dịch, phép thử phù hợp là',N'Benedict, kết hợp đun nóng theo quy trình',N'Biuret, quan sát màu tím',N'Iodine, quan sát màu xanh tím',N'Nhũ tương ethanol–nước, quan sát màu trắng đục',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 11).',N'SINH10-GK1-MD02'),
(N'Một loại vi khuẩn có vùng nhân và ribosome. Nhận xét nào đúng về chức năng của hai thành phần này?',N'Vùng nhân tổng hợp protein, ribosome lưu giữ phần lớn DNA',N'Cả hai đều được bao bọc bởi màng nhân',N'Ribosome chứa DNA chính còn vùng nhân chủ yếu chứa enzyme tiêu hóa',N'Vùng nhân chứa phần lớn DNA, còn ribosome tham gia tổng hợp protein',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của đề kiểm tra giữa học kì I Sinh học 10, mã đề 02 (câu 12).',N'SINH10-GK1-MD02');
GO
-- Sinh học: SINH10-NHANBIET-20C (20 cau)
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE ExamCode = N'SINH10-NHANBIET-20C')
INSERT INTO dbo.Questions (Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode) VALUES
(N'Thuốc thử nào sau đây được sử dụng để nhận biết glucose?',N'Dung dịch iodine',N'Thuốc thử Benedict',N'Thuốc thử Biuret',N'Dung dịch ethanol',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 1).',N'SINH10-NHANBIET-20C'),
(N'Thuốc thử Benedict ban đầu có màu gì?',N'Xanh lam',N'Đỏ gạch',N'Tím',N'Vàng',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 2).',N'SINH10-NHANBIET-20C'),
(N'Khi thực hiện phép thử Benedict để nhận biết glucose, cần thực hiện thao tác nào sau đây?',N'Làm lạnh hỗn hợp',N'Đặt hỗn hợp trong bóng tối',N'Đun nóng hỗn hợp trong bể nước nóng',N'Chiếu ánh sáng vào hỗn hợp',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 3).',N'SINH10-NHANBIET-20C'),
(N'Khi dung dịch chứa nhiều glucose phản ứng với thuốc thử Benedict và được đun nóng thích hợp, hiện tượng thường xuất hiện là',N'dung dịch chuyển sang màu tím',N'xuất hiện kết tủa xanh lam',N'xuất hiện kết tủa đỏ gạch',N'xuất hiện lớp nhũ tương trắng đục',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 4).',N'SINH10-NHANBIET-20C'),
(N'Glucose thuộc nhóm chất nào sau đây?',N'Đường không khử',N'Đường khử',N'Protein',N'Lipid',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 5).',N'SINH10-NHANBIET-20C'),
(N'Chất nào sau đây có thể cho kết quả dương tính với phép thử Benedict?',N'Tinh bột nguyên chất',N'Dầu ăn',N'Glucose',N'Albumin',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 6).',N'SINH10-NHANBIET-20C'),
(N'Nếu sau khi đun nóng với thuốc thử Benedict, hỗn hợp vẫn giữ màu xanh lam, điều này thường cho thấy',N'mẫu chứa nhiều glucose',N'mẫu chứa nhiều protein',N'không phát hiện đường khử trong mẫu',N'mẫu chứa nhiều lipid',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 7).',N'SINH10-NHANBIET-20C'),
(N'Trong phép thử nhũ tương để nhận biết lipid, dung môi thường được sử dụng là',N'ethanol',N'nước muối',N'dung dịch Benedict',N'dung dịch Biuret',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 8).',N'SINH10-NHANBIET-20C'),
(N'Khi thực hiện phép thử nhũ tương, sau khi hòa tan mẫu trong ethanol, cần thêm chất nào sau đây?',N'Dung dịch iodine',N'Nước',N'Dung dịch NaOH',N'Dung dịch CuSO₄',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 9).',N'SINH10-NHANBIET-20C'),
(N'Hiện tượng nào sau đây cho thấy mẫu có lipid trong phép thử nhũ tương?',N'Xuất hiện màu tím',N'Xuất hiện kết tủa đỏ gạch',N'Xuất hiện nhũ tương trắng đục',N'Dung dịch chuyển xanh lam',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 10).',N'SINH10-NHANBIET-20C'),
(N'Chất nào sau đây có thể được nhận biết bằng phép thử nhũ tương?',N'Glucose',N'Tinh bột',N'Albumin',N'Dầu thực vật',N'D',N'Sinh học',N'Đáp án D theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 11).',N'SINH10-NHANBIET-20C'),
(N'Trong phép thử nhũ tương, lipid hòa tan tốt trong chất nào sau đây?',N'Nước',N'Ethanol',N'Dung dịch muối ăn',N'Dung dịch Benedict',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 12).',N'SINH10-NHANBIET-20C'),
(N'Nếu sau khi thực hiện đúng phép thử nhũ tương, hỗn hợp vẫn trong suốt và không xuất hiện màu trắng đục, kết luận phù hợp nhất là',N'mẫu chứa nhiều lipid',N'mẫu chứa nhiều glucose',N'không phát hiện lipid trong mẫu',N'mẫu chứa nhiều protein',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 13).',N'SINH10-NHANBIET-20C'),
(N'Thuốc thử nào sau đây được sử dụng để nhận biết protein?',N'Thuốc thử Benedict',N'Dung dịch iodine',N'Thuốc thử Biuret',N'Ethanol',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 14).',N'SINH10-NHANBIET-20C'),
(N'Thuốc thử Biuret được sử dụng để nhận biết thành phần nào trong protein?',N'Liên kết peptide',N'Liên kết glycosidic',N'Liên kết ester',N'Liên kết hydrogen',N'A',N'Sinh học',N'Đáp án A theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 15).',N'SINH10-NHANBIET-20C'),
(N'Khi mẫu chứa protein phản ứng với thuốc thử Biuret, hiện tượng đặc trưng là',N'xuất hiện kết tủa đỏ gạch',N'dung dịch xuất hiện màu tím',N'xuất hiện nhũ tương trắng đục',N'dung dịch chuyển màu vàng nâu',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 16).',N'SINH10-NHANBIET-20C'),
(N'Thuốc thử Biuret thường được tạo thành từ dung dịch NaOH và dung dịch nào sau đây?',N'HCl',N'NaCl',N'CuSO₄',N'Iodine',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 17).',N'SINH10-NHANBIET-20C'),
(N'Chất nào sau đây cho phản ứng dương tính với thuốc thử Biuret?',N'Glucose',N'Dầu ăn',N'Albumin trong lòng trắng trứng',N'Tinh bột',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 18).',N'SINH10-NHANBIET-20C'),
(N'Khi thực hiện phép thử Biuret, mẫu có chứa protein sẽ xuất hiện màu nào sau đây?',N'Xanh lục',N'Tím',N'Đỏ gạch',N'Trắng đục',N'B',N'Sinh học',N'Đáp án B theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 19).',N'SINH10-NHANBIET-20C'),
(N'Trong phép thử Biuret, nếu mẫu không chứa protein hoặc các peptide có đủ liên kết peptide để cho phản ứng dương tính, hỗn hợp thường',N'chuyển sang màu đỏ gạch',N'xuất hiện nhũ tương trắng đục',N'không xuất hiện màu tím đặc trưng',N'chuyển sang màu vàng cam',N'C',N'Sinh học',N'Đáp án C theo hướng dẫn chấm của bộ 20 câu nhận biết glucose, lipid, protein (câu 20).',N'SINH10-NHANBIET-20C');
GO
SELECT SubjectCategory, COUNT(DISTINCT ExamCode) AS SoBoDe, COUNT(*) AS SoCau FROM dbo.Questions GROUP BY SubjectCategory ORDER BY SubjectCategory;
GO
