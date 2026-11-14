@echo off
chcp 65001 >nul
cd /d "%~dp0"
where npm >nul 2>nul
if errorlevel 1 goto python
if not exist node_modules\.bin\http-server.cmd call npm install
if not exist node_modules\.bin\http-server.cmd goto python
call npm start
goto :eof
:python
echo Khong dung duoc npm, chay client bang Python...
start "" http://localhost:5500/presentation/pages/index.html
python -m http.server 5500 -d src
