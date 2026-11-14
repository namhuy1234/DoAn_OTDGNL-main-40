-- Khoi phuc 2 cau hoi da bi xoa (ID 1 va ID 22), giu nguyen ma ID ban dau
USE OnThiDGNL_DB;
SET IDENTITY_INSERT dbo.Questions ON;
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE Id = 1)
INSERT INTO dbo.Questions (Id,Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode)
VALUES (1,N'Giá trị của biểu thức 2^3 + 3^2 bằng bao nhiêu?',N'13',N'15',N'17',N'19',N'C',N'Toán',N'2^3 = 8, 3^2 = 9 nên tổng là 17.',N'ĐỀ-01');
IF NOT EXISTS (SELECT 1 FROM dbo.Questions WHERE Id = 22)
INSERT INTO dbo.Questions (Id,Content,OptionA,OptionB,OptionC,OptionD,CorrectAnswer,SubjectCategory,Explanation,ExamCode)
VALUES (22,N'Dung dịch có pH < 7 là dung dịch:',N'Bazơ',N'Trung tính',N'Axit',N'Muối',N'C',N'Hóa học',N'pH nhỏ hơn 7 là môi trường axit.',N'ĐỀ-01');
SET IDENTITY_INSERT dbo.Questions OFF;
SELECT COUNT(*) AS SoCauHoi FROM dbo.Questions;
