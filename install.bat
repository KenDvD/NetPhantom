@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title NetPhantom 安装向导
color 0B

:: ============================================================================
:: NetPhantom 智能安装向导 v3.0
:: 自动检测并安装所有必需的依赖项
:: ============================================================================

set VERSION=3.0
set DOWNLOAD_DIR=%~dp0downloads

:: 初始化状态变量
set ADMIN_OK=0
set DOTNET_OK=0
set NPCAP_OK=0
set PROGRAM_OK=0

:: ============================================================================
:: 显示欢迎界面
:: ============================================================================
cls
echo.
echo     ╔══════════════════════════════════════════════════════════════╗
echo     ║                                                              ║
echo     ║              NetPhantom - ARP 扫描与欺骗工具                 ║
echo     ║                    智能安装向导 v%VERSION%                        ║
echo     ║                                                              ║
echo     ╚══════════════════════════════════════════════════════════════╝
echo.
echo     本向导将引导您完成 NetPhantom 的安装和配置
echo.
echo     ┌──────────────────────────────────────────────────────────────┐
echo     │  安装步骤：                                                  │
echo     │    1. 检查管理员权限                                         │
echo     │    2. 检查 .NET 8 Runtime                                    │
echo     │    3. 检查 Npcap 网络驱动                                    │
echo     │    4. 验证程序文件                                           │
echo     └──────────────────────────────────────────────────────────────┘
echo.
echo     按任意键开始安装检查...
pause >nul

:: ============================================================================
:: 步骤 1: 检查管理员权限
:: ============================================================================
cls
echo.
echo     ════════════════════════════════════════════════════════════════
echo       步骤 1/4: 检查管理员权限
echo     ════════════════════════════════════════════════════════════════
echo.
echo     [检测中] 正在验证管理员权限...
timeout /t 1 >nul

net session >nul 2>&1
if !errorLevel! neq 0 (
    echo.
    echo     [✗] 权限不足
    echo.
    echo     ┌──────────────────────────────────────────────────────────┐
    echo     │  错误：需要管理员权限才能继续                            │
    echo     │                                                          │
    echo     │  解决方法：                                              │
    echo     │    1. 关闭此窗口                                         │
    echo     │    2. 右键点击 install.bat                               │
    echo     │    3. 选择"以管理员身份运行"                             │
    echo     └──────────────────────────────────────────────────────────┘
    echo.
    pause
    exit /b 1
)

set ADMIN_OK=1
echo     [✓] 管理员权限验证通过
echo.
timeout /t 1 >nul

:: ============================================================================
:: 步骤 2: 检查 .NET 8 Runtime
:: ============================================================================
cls
echo.
echo     ════════════════════════════════════════════════════════════════
echo       步骤 2/4: 检查 .NET 8 Desktop Runtime
echo     ════════════════════════════════════════════════════════════════
echo.
echo     [检测中] 正在扫描 .NET Runtime...
timeout /t 1 >nul

dotnet --version >nul 2>&1
if !errorLevel! neq 0 (
    echo.
    echo     [!] 未检测到 .NET 8 Runtime
    echo.
    echo     ┌──────────────────────────────────────────────────────────┐
    echo     │  .NET 8 Desktop Runtime 是运行程序的必需组件             │
    echo     │  大小: 约 55 MB                                          │
    echo     └──────────────────────────────────────────────────────────┘
    echo.
    echo     请选择安装方式：
    echo.
    echo       [1] 自动下载并安装 (推荐)
    echo       [2] 手动下载安装
    echo       [3] 跳过此步骤
    echo.
    set /p dotnet_choice="     请输入选项 (1-3): "
    
    if "!dotnet_choice!"=="1" (
        call :InstallDotNetAuto
    ) else if "!dotnet_choice!"=="2" (
        call :InstallDotNetManual
    ) else (
        echo.
        echo     [跳过] 已跳过 .NET Runtime 安装
        echo     [警告] 程序可能无法运行
        timeout /t 2 >nul
    )
) else (
    for /f "tokens=*" %%i in ('dotnet --version') do set dotnet_ver=%%i
    set DOTNET_OK=1
    echo.
    echo     [✓] .NET Runtime 已安装
    echo         版本: !dotnet_ver!
    timeout /t 1 >nul
)

:: ============================================================================
:: 步骤 3: 检查 Npcap 驱动
:: ============================================================================
cls
echo.
echo     ════════════════════════════════════════════════════════════════
echo       步骤 3/4: 检查 Npcap 网络驱动
echo     ════════════════════════════════════════════════════════════════
echo.
echo     [检测中] 正在扫描 Npcap 驱动...
timeout /t 1 >nul

call :DetectNpcap

if !NPCAP_OK! equ 0 (
    echo.
    echo     [!] 未检测到 Npcap 驱动
    echo.
    echo     ┌──────────────────────────────────────────────────────────┐
    echo     │  Npcap 是网络数据包捕获驱动，NetPhantom 必需组件        │
    echo     │  大小: 约 3 MB                                           │
    echo     │  注意: 由于许可证限制，无法自动安装                     │
    echo     └──────────────────────────────────────────────────────────┘
    echo.
    echo     请选择安装方式：
    echo.
    echo       [1] 打开官网下载 (推荐)
    echo       [2] 查看详细安装说明
    echo       [3] 跳过此步骤
    echo.
    set /p npcap_choice="     请输入选项 (1-3): "
    
    if "!npcap_choice!"=="1" (
        call :InstallNpcapQuick
    ) else if "!npcap_choice!"=="2" (
        call :InstallNpcapDetailed
    ) else (
        echo.
        echo     [跳过] 已跳过 Npcap 安装
        echo     [警告] 程序将无法正常工作
        timeout /t 2 >nul
    )
) else (
    echo.
    echo     [✓] Npcap 驱动已安装
    call :ShowNpcapInfo
    timeout /t 1 >nul
)

:: ============================================================================
:: 步骤 4: 检查程序文件
:: ============================================================================
cls
echo.
echo     ════════════════════════════════════════════════════════════════
echo       步骤 4/4: 验证程序文件
echo     ════════════════════════════════════════════════════════════════
echo.
echo     [检测中] 正在查找 NetPhantom.exe...
timeout /t 1 >nul

set exe_path=
if exist "bin\Release\net8.0-windows\NetPhantom.exe" (
    set exe_path=bin\Release\net8.0-windows\NetPhantom.exe
    set build_type=Release
) else if exist "bin\Debug\net8.0-windows\NetPhantom.exe" (
    set exe_path=bin\Debug\net8.0-windows\NetPhantom.exe
    set build_type=Debug
) else if exist "NetPhantom.exe" (
    set exe_path=NetPhantom.exe
    set build_type=Standalone
)

if defined exe_path (
    set PROGRAM_OK=1
    echo.
    echo     [✓] 程序文件已找到
    echo         路径: !exe_path!
    echo         类型: !build_type!
    
    :: 获取文件大小
    for %%A in ("!exe_path!") do set file_size=%%~zA
    set /a file_size_mb=!file_size! / 1048576
    echo         大小: !file_size_mb! MB
) else (
    echo.
    echo     [✗] 未找到程序文件
    echo.
    echo     ┌──────────────────────────────────────────────────────────┐
    echo     │  可能的原因：                                            │
    echo     │    • 项目尚未编译                                        │
    echo     │    • 文件路径不正确                                      │
    echo     │                                                          │
    echo     │  解决方法：                                              │
    echo     │    运行命令: dotnet build -c Release                     │
    echo     └──────────────────────────────────────────────────────────┘
    echo.
    pause
    exit /b 1
)

timeout /t 1 >nul

:: ============================================================================
:: 显示安装摘要
:: ============================================================================
cls
echo.
echo     ╔══════════════════════════════════════════════════════════════╗
echo     ║                      安装检查完成                            ║
echo     ╚══════════════════════════════════════════════════════════════╝
echo.
echo     ┌──────────────────────────────────────────────────────────────┐
echo     │  系统状态摘要                                                │
echo     ├──────────────────────────────────────────────────────────────┤

if !ADMIN_OK! equ 1 (
    echo     │  [✓] 管理员权限      已获取                              │
) else (
    echo     │  [✗] 管理员权限      未获取                              │
)

if !DOTNET_OK! equ 1 (
    echo     │  [✓] .NET Runtime    已安装                              │
) else (
    echo     │  [✗] .NET Runtime    未安装                              │
)

if !NPCAP_OK! equ 1 (
    echo     │  [✓] Npcap 驱动      已安装                              │
) else (
    echo     │  [✗] Npcap 驱动      未安装                              │
)

if !PROGRAM_OK! equ 1 (
    echo     │  [✓] 程序文件        已就绪                              │
) else (
    echo     │  [✗] 程序文件        未找到                              │
)

echo     └──────────────────────────────────────────────────────────────┘
echo.

:: 检查是否所有组件都已就绪
set all_ready=1
if !ADMIN_OK! equ 0 set all_ready=0
if !DOTNET_OK! equ 0 set all_ready=0
if !NPCAP_OK! equ 0 set all_ready=0
if !PROGRAM_OK! equ 0 set all_ready=0

if !all_ready! equ 1 (
    echo     所有依赖项已就绪，可以启动 NetPhantom
    echo.
    echo     按任意键启动程序...
    pause >nul
    
    echo.
    echo     [启动中] 正在以管理员身份启动 NetPhantom...
    powershell -Command "Start-Process '!exe_path!' -Verb RunAs" >nul 2>&1
    
    if !errorLevel! equ 0 (
        echo     [✓] 程序已启动
        echo.
        echo     提示: 首次运行可能需要允许防火墙访问
    ) else (
        echo     [!] 自动启动失败
        echo.
        echo     请手动运行: 右键 !exe_path! → 以管理员身份运行
    )
) else (
    echo     [警告] 部分依赖项未安装，程序可能无法正常运行
    echo.
    echo     请安装缺失的组件后重新运行此脚本
)

echo.
pause
exit /b 0

:: ============================================================================
:: 函数: 自动安装 .NET Runtime
:: ============================================================================
:InstallDotNetAuto
echo.
echo     [下载中] 正在下载 .NET 8 Desktop Runtime...
echo.
echo     下载地址: https://aka.ms/dotnet/8.0/windowsdesktop-runtime-win-x64.exe

if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"
set DOTNET_INSTALLER=%DOWNLOAD_DIR%\dotnet-runtime-8.0.exe

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; try { Invoke-WebRequest -Uri 'https://aka.ms/dotnet/8.0/windowsdesktop-runtime-win-x64.exe' -OutFile '%DOTNET_INSTALLER%' -UseBasicParsing; exit 0 } catch { exit 1 }}" >nul 2>&1

if !errorLevel! equ 0 (
    if exist "%DOTNET_INSTALLER%" (
        echo     [✓] 下载完成
        echo.
        echo     [安装中] 正在启动安装程序...
        echo     请在安装向导中完成安装，然后返回此窗口
        echo.
        start /wait "" "%DOTNET_INSTALLER%"
        
        echo.
        echo     [验证中] 重新检测 .NET Runtime...
        timeout /t 2 >nul
        
        dotnet --version >nul 2>&1
        if !errorLevel! equ 0 (
            for /f "tokens=*" %%i in ('dotnet --version') do set dotnet_ver=%%i
            set DOTNET_OK=1
            echo     [✓] .NET Runtime 安装成功
            echo         版本: !dotnet_ver!
        ) else (
            echo     [✗] 安装失败或未完成
            echo.
            echo     请手动安装后重新运行此脚本
            pause
            exit /b 1
        )
    )
) else (
    echo     [✗] 下载失败
    echo.
    echo     可能的原因: 网络连接问题
    echo     请检查网络后重试，或选择手动下载
    pause
    exit /b 1
)
timeout /t 2 >nul
goto :eof

:: ============================================================================
:: 函数: 手动安装 .NET Runtime
:: ============================================================================
:InstallDotNetManual
echo.
echo     [浏览器] 正在打开官方下载页面...
start https://dotnet.microsoft.com/download/dotnet/8.0
echo.
echo     ┌──────────────────────────────────────────────────────────┐
echo     │  请下载并安装:                                           │
echo     │    .NET Desktop Runtime 8.0.x (x64)                      │
echo     │                                                          │
echo     │  安装完成后，请重新运行此脚本                           │
echo     └──────────────────────────────────────────────────────────┘
echo.
pause
exit /b 1

:: ============================================================================
:: 函数: 检测 Npcap
:: ============================================================================
:DetectNpcap
set NPCAP_OK=0
set detection_methods=0

:: 方法 1: 检查驱动文件
if exist "%SystemRoot%\System32\drivers\npcap.sys" (
    set NPCAP_OK=1
    set /a detection_methods+=1
)

:: 方法 2: 检查 WinPcap 兼容 DLL
if exist "%SystemRoot%\System32\wpcap.dll" (
    set NPCAP_OK=1
    set /a detection_methods+=1
)

:: 方法 3: 检查 Packet.dll
if exist "%SystemRoot%\System32\Packet.dll" (
    set NPCAP_OK=1
    set /a detection_methods+=1
)

:: 方法 4: 检查服务
sc query npcap >nul 2>&1
if !errorLevel! equ 0 (
    set NPCAP_OK=1
    set /a detection_methods+=1
)

goto :eof

:: ============================================================================
:: 函数: 显示 Npcap 信息
:: ============================================================================
:ShowNpcapInfo
:: 检查服务状态
for /f "tokens=*" %%i in ('powershell -Command "(Get-Service -Name npcap -ErrorAction SilentlyContinue).Status" 2^>nul') do set npcap_status=%%i
if defined npcap_status (
    echo         服务状态: !npcap_status!
)

:: 检查 WinPcap 兼容模式
if exist "%SystemRoot%\System32\wpcap.dll" (
    echo         兼容模式: WinPcap API 已启用
) else (
    echo         兼容模式: 未启用 (可能影响功能^)
)

goto :eof

:: ============================================================================
:: 函数: 快速安装 Npcap
:: ============================================================================
:InstallNpcapQuick
echo.
echo     [浏览器] 正在打开 Npcap 官方下载页面...
start https://npcap.com/#download
echo.
echo     ┌──────────────────────────────────────────────────────────┐
echo     │  重要提示: 安装时请务必勾选以下选项                     │
echo     │    [✓] Install Npcap in WinPcap API-compatible Mode     │
echo     └──────────────────────────────────────────────────────────┘
echo.
echo     下载并安装完成后，请按任意键继续...
pause >nul

echo.
echo     [验证中] 重新检测 Npcap 驱动...
timeout /t 2 >nul

call :DetectNpcap

if !NPCAP_OK! equ 0 (
    echo     [✗] 未检测到 Npcap 驱动
    echo.
    echo     可能的原因:
    echo       • 安装未完成
    echo       • 未勾选 WinPcap 兼容模式
    echo       • 需要重启计算机
    echo.
    echo     请确认安装完成后重新运行此脚本
    pause
    exit /b 1
) else (
    echo     [✓] Npcap 驱动安装成功
    call :ShowNpcapInfo
)

timeout /t 2 >nul
goto :eof

:: ============================================================================
:: 函数: 详细安装 Npcap
:: ============================================================================
:InstallNpcapDetailed
echo.
echo     ════════════════════════════════════════════════════════════
echo       Npcap 详细安装指南
echo     ════════════════════════════════════════════════════════════
echo.
echo     步骤 1: 访问官方网站
echo       https://npcap.com/#download
echo.
echo     步骤 2: 下载最新版本
echo       点击 "Download" 按钮下载安装程序
echo.
echo     步骤 3: 运行安装程序
echo       以管理员身份运行下载的安装程序
echo.
echo     步骤 4: 重要配置 (必须勾选)
echo       [✓] Install Npcap in WinPcap API-compatible Mode
echo       [✓] Support raw 802.11 traffic (可选)
echo       [✓] Install Npcap Loopback Adapter (可选)
echo.
echo     步骤 5: 完成安装
echo       点击 "Install" 完成安装
echo.
echo     步骤 6: 重启计算机 (如果提示)
echo.
echo     ════════════════════════════════════════════════════════════
echo.
echo     是否现在打开下载页面? (Y/N)
set /p open_page="     请输入: "

if /i "!open_page!"=="Y" (
    start https://npcap.com/#download
)

echo.
echo     下载并安装完成后，请按任意键继续...
pause >nul

echo.
echo     [验证中] 重新检测 Npcap 驱动...
timeout /t 2 >nul

call :DetectNpcap

if !NPCAP_OK! equ 0 (
    echo     [✗] 未检测到 Npcap 驱动
    echo.
    echo     可能的原因:
    echo       • 安装未完成
    echo       • 未勾选 WinPcap 兼容模式
    echo       • 需要重启计算机
    echo.
    echo     请确认安装完成后重新运行此脚本
    pause
    exit /b 1
) else (
    echo     [✓] Npcap 驱动安装成功
    call :ShowNpcapInfo
)

timeout /t 2 >nul
goto :eof
