@echo off
cd /d "%~dp0"
rem Tai ma nguon tu GitHub ve se thieu .env (khong dua len GitHub): tao tu tep mau.
if not exist "back-end-python\.env" (
    copy "back-end-python\.env.example" "back-end-python\.env" >nul
    echo Da tao back-end-python\.env tu .env.example. Them khoa Cloudinary vao .env neu can tai anh.
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0giai-phong-cong.ps1"
if errorlevel 1 (
    pause
    exit /b 1
)
start "Backend - port 8000" cmd /k "back-end-python\run-server.bat"
start "Client - port 5500" cmd /k "front-end\run-client.bat"
