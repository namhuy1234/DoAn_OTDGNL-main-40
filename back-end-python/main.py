"""Entry point - Clean Architecture bootstrap."""
# Nạp .env trước khi import các tầng dưới (JWT_SECRET_KEY, chuỗi kết nối, khóa Cloudinary).
from dotenv import load_dotenv

load_dotenv()

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from presentation.middleware.path import LowercasePathMiddleware
from presentation.routers.auth import router as auth_router
from presentation.routers.questions import router as questions_router
from presentation.routers.exam import router as exam_router
from presentation.routers.exams import router as exams_router
from presentation.routers.users import router as users_router
from presentation.routers.upload import router as upload_router

app = FastAPI(
    title="OnThiDGNL API (Python - Clean Architecture)",
    description="API hệ thống ôn thi ĐGNL: đăng nhập, ngân hàng câu hỏi, bộ đề, ôn tập và thi thử, chấm bài, lịch sử và thống kê, "
                "quản lý người dùng, ảnh câu hỏi lưu trên Cloudinary.",
    version="3.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.add_middleware(LowercasePathMiddleware)

app.include_router(auth_router, prefix="/api")
app.include_router(questions_router, prefix="/api")
app.include_router(exam_router, prefix="/api")
app.include_router(exams_router, prefix="/api")
app.include_router(users_router, prefix="/api")
app.include_router(upload_router, prefix="/api")


@app.get("/")
def root():
    return {"message": "OnThiDGNL Python API (Clean Architecture) is running", "docs": "/docs"}
