-- Nâng cấp CSDL OnThiDGNL_DB (bản V8):
--   1. Cột ImageUrl cho câu hỏi: lưu đường dẫn ảnh minh họa đã tải lên Cloudinary.
--   2. Bảng ExamResults: lưu lịch sử làm bài để xem lại và thống kê kết quả học tập.
-- Chạy được nhiều lần (có kiểm tra tồn tại). Chạy bằng: sqlcmd -S .\SQLEXPRESS -E -C -f 65001 -i NangCap_V8_LichSu_HinhAnh.sql
USE OnThiDGNL_DB;
GO

IF COL_LENGTH('dbo.Questions', 'ImageUrl') IS NULL
    ALTER TABLE dbo.Questions ADD ImageUrl NVARCHAR(500) NULL;
GO

IF OBJECT_ID('dbo.ExamResults', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ExamResults (
        Id              INT IDENTITY(1,1) PRIMARY KEY,
        UserId          INT           NOT NULL,
        ExamCode        NVARCHAR(100) NOT NULL DEFAULT N'',
        SubjectCategory NVARCHAR(100) NOT NULL DEFAULT N'',
        TotalQuestions  INT           NOT NULL,
        CorrectCount    INT           NOT NULL,
        BlankCount      INT           NOT NULL DEFAULT 0,
        ScorePercentage DECIMAL(5,2)  NOT NULL,
        DurationSeconds INT           NULL,
        SubmittedAt     DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME(),
        CONSTRAINT FK_ExamResults_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(Id) ON DELETE CASCADE,
        CONSTRAINT CK_ExamResults_Score CHECK (ScorePercentage BETWEEN 0 AND 100),
        CONSTRAINT CK_ExamResults_Count CHECK (CorrectCount BETWEEN 0 AND TotalQuestions)
    );
    CREATE INDEX IX_ExamResults_User ON dbo.ExamResults (UserId, SubmittedAt DESC);
    CREATE INDEX IX_ExamResults_Exam ON dbo.ExamResults (ExamCode, ScorePercentage DESC);
END
GO

-- 3. Bảng Exams: thông tin bộ đề (tên, môn, thời gian làm bài). Câu hỏi thuộc đề qua cột Questions.ExamCode.
IF OBJECT_ID('dbo.Exams', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Exams (
        Id              INT IDENTITY(1,1) PRIMARY KEY,
        ExamCode        NVARCHAR(100) NOT NULL CONSTRAINT UQ_Exams_Code UNIQUE,
        Title           NVARCHAR(200) NOT NULL,
        SubjectCategory NVARCHAR(100) NOT NULL DEFAULT N'',
        DurationMinutes INT           NOT NULL DEFAULT 15 CONSTRAINT CK_Exams_Duration CHECK (DurationMinutes BETWEEN 1 AND 300),
        Description     NVARCHAR(500) NOT NULL DEFAULT N'',
        CreatedAt       DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME()
    );
END
GO
-- Tạo đề cho các mã đề đã có trong ngân hàng câu hỏi: thời gian mặc định 1,25 phút/câu (12 câu = 15 phút, 20 câu = 25 phút).
INSERT INTO dbo.Exams (ExamCode, Title, SubjectCategory, DurationMinutes)
SELECT q.ExamCode, q.ExamCode, MAX(q.SubjectCategory), CEILING(COUNT(*) * 1.25)
FROM dbo.Questions q
WHERE LTRIM(RTRIM(ISNULL(q.ExamCode, N''))) <> N''
  AND NOT EXISTS (SELECT 1 FROM dbo.Exams e WHERE e.ExamCode = q.ExamCode)
GROUP BY q.ExamCode;
GO

-- 4. Bảng ExamResultAnswers: bài làm chi tiết (đáp án đã chọn từng câu) để học sinh xem lại lượt làm.
IF OBJECT_ID('dbo.ExamResultAnswers', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ExamResultAnswers (
        Id             INT IDENTITY(1,1) PRIMARY KEY,
        ResultId       INT          NOT NULL,
        QuestionId     INT          NOT NULL,
        SelectedAnswer NVARCHAR(10) NOT NULL DEFAULT N'',
        IsCorrect      BIT          NOT NULL,
        CONSTRAINT FK_Answers_Results FOREIGN KEY (ResultId) REFERENCES dbo.ExamResults(Id) ON DELETE CASCADE
    );
    CREATE INDEX IX_Answers_Result ON dbo.ExamResultAnswers (ResultId);
END
GO

-- 5. Bộ đề có câu hỏi của nhiều môn (đề tổng hợp ban đầu) ghi môn là "Tổng hợp"; thời gian tối thiểu 5 phút.
UPDATE dbo.Exams SET SubjectCategory = N'Tổng hợp', Title = CASE WHEN Title = ExamCode THEN N'Đề tổng hợp nhiều môn' ELSE Title END
WHERE ExamCode IN (SELECT ExamCode FROM dbo.Questions GROUP BY ExamCode HAVING COUNT(DISTINCT SubjectCategory) > 1);
UPDATE dbo.Exams SET DurationMinutes = 5 WHERE DurationMinutes < 5;
GO
