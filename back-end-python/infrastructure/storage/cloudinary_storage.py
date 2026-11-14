"""Infrastructure: lưu ảnh câu hỏi lên Cloudinary (SDK chính thức `cloudinary`).

Khóa đọc từ .env: CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET
(hoặc một biến CLOUDINARY_URL=cloudinary://<key>:<secret>@<cloud_name>).
"""
import os

import cloudinary
import cloudinary.uploader

from application.interfaces.image_storage import IImageStorage

FOLDER = os.getenv("CLOUDINARY_FOLDER", "ontidgnl/cau-hoi")


def _configure() -> bool:
    name = os.getenv("CLOUDINARY_CLOUD_NAME")
    key = os.getenv("CLOUDINARY_API_KEY")
    secret = os.getenv("CLOUDINARY_API_SECRET")
    if name and key and secret:
        cloudinary.config(cloud_name=name, api_key=key, api_secret=secret, secure=True)
    elif os.getenv("CLOUDINARY_URL"):
        cloudinary.config(secure=True)  # SDK tự đọc CLOUDINARY_URL
    cfg = cloudinary.config()
    return bool(cfg.cloud_name and cfg.api_key and cfg.api_secret)


class CloudinaryImageStorage(IImageStorage):
    def __init__(self):
        self._ready = _configure()

    def is_configured(self) -> bool:
        return self._ready

    def cloud_name(self) -> str:
        return cloudinary.config().cloud_name or ""

    def upload(self, data: bytes, filename: str) -> dict:
        res = cloudinary.uploader.upload(
            data,
            folder=FOLDER,
            resource_type="image",
            use_filename=True,
            unique_filename=True,
            filename_override=filename,
            # Ảnh lớn được thu về tối đa 1200px, định dạng/chất lượng tự chọn để tải nhanh.
            transformation=[{"width": 1200, "crop": "limit"}, {"fetch_format": "auto", "quality": "auto"}],
        )
        return {
            "url": res.get("secure_url", ""),
            "public_id": res.get("public_id", ""),
            "width": res.get("width"),
            "height": res.get("height"),
            "bytes": res.get("bytes"),
        }
