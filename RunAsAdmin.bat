@echo off
echo NetPhantom - 正在以管理员身份启动...
echo.

cd /d "%~dp0"

if exist "bin\Release\net8.0-windows\NetPhantom.exe" (
    powershell -Command "Start-Process 'bin\Release\net8.0-windows\NetPhantom.exe' -Verb RunAs"
) else if exist "bin\Debug\net8.0-windows\NetPhantom.exe" (
    powershell -Command "Start-Process 'bin\Debug\net8.0-windows\NetPhantom.exe' -Verb RunAs"
) else (
    echo 错误：未找到 NetPhantom.exe
    echo 请先编译项目：dotnet build
    pause
)
