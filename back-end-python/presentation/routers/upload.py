"""Presentation: Upload router (tải ảnh minh họa câu hỏi lên Cloudinary, chỉ admin)."""
import os

from fastapi import APIRouter, Depends, File, UploadFile
from fastapi.responses import PlainTextResponse

from infrastructure.storage.cloudinary_storage import CloudinaryImageStorage
from presentation.dependencies.auth import require_admin

router = APIRouter(prefix="/upload", tags=["Upload"])

MAX_BYTES = 5 * 1024 * 1024
ALLOWED = {"image/png", "image/jpeg", "image/gif", "image/webp"}


@router.get("/status")
async def upload_status():
    """Cho trang quản lý biết Cloudinary đã được cấu hình hay chưa (không trả về khóa)."""
    storage = CloudinaryImageStorage()
    return {"Provider": "Cloudinary", "Configured": storage.is_configured(), "CloudName": storage.cloud_name()}


@router.post("/image", status_code=201)
async def upload_image(file: UploadFile = File(...), admin_user: dict = Depends(require_admin)):
    storage = CloudinaryImageStorage()
    if not storage.is_configured():
        return PlainTextResponse(
            content="Chưa cấu hình Cloudinary: thêm CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET vào back-end-python/.env.",
            status_code=503,
        )
    if file.content_type not in ALLOWED:
        return PlainTextResponse(content="Chỉ nhận ảnh PNG, JPG, GIF hoặc WEBP.", status_code=400)
    data = await file.read()
    if not data:
        return PlainTextResponse(content="Tệp ảnh rỗng.", status_code=400)
    if len(data) > MAX_BYTES:
        return PlainTextResponse(content="Ảnh vượt quá 5 MB.", status_code=413)
    try:
        res = storage.upload(data, os.path.splitext(file.filename or "anh")[0])
    except Exception as err:  # lỗi mạng hoặc khóa sai trả về từ Cloudinary
        return PlainTextResponse(content=f"Cloudinary từ chối tải ảnh: {err}", status_code=502)
    return {"Url": res["url"], "PublicId": res["public_id"], "Width": res["width"], "Height": res["height"], "Bytes": res["bytes"]}
