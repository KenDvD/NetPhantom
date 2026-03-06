@echo off
chcp 65001 >nul
title NetPhantom 自动发布构建脚本
color 0B

set version=1.0.0

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║          NetPhantom - 自动发布构建脚本 v%version%         ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

echo [1/6] 清理旧文件...
if exist "release" rmdir /s /q "release"
mkdir "release"
dotnet clean -c Release >nul 2>&1

echo.
echo [2/6] 编译 Release 版本...
dotnet build -c Release
if %errorLevel% neq 0 (
    echo [错误] 编译失败
    pause
    exit /b 1
)

echo.
echo [3/6] 发布标准版本（需要 .NET Runtime）...
dotnet publish -c Release -r win-x64 --self-contained false -o "release\NetPhantom-v%version%" -p:PublishSingleFile=false
if %errorLevel% neq 0 (
    echo [错误] 发布失败
    pause
    exit /b 1
)

echo.
echo [4/6] 发布完整版本（包含 .NET Runtime）...
dotnet publish -c Release -r win-x64 --self-contained true -o "release\NetPhantom-v%version%-full" -p:PublishSingleFile=false
if %errorLevel% neq 0 (
    echo [错误] 发布失败
    pause
    exit /b 1
)

echo.
echo [5/6] 复制文档文件...
copy README.md "release\NetPhantom-v%version%\" >nul
copy INSTALL_GUIDE.md "release\NetPhantom-v%version%\" >nul
copy "ARP欺骗使用说明.md" "release\NetPhantom-v%version%\" >nul
copy LICENSE "release\NetPhantom-v%version%\" >nul
copy CHANGELOG.md "release\NetPhantom-v%version%\" >nul
copy install.bat "release\NetPhantom-v%version%\" >nul
copy RunAsAdmin.bat "release\NetPhantom-v%version%\" >nul

copy README.md "release\NetPhantom-v%version%-full\" >nul
copy INSTALL_GUIDE.md "release\NetPhantom-v%version%-full\" >nul
copy "ARP欺骗使用说明.md" "release\NetPhantom-v%version%-full\" >nul
copy LICENSE "release\NetPhantom-v%version%-full\" >nul
copy CHANGELOG.md "release\NetPhantom-v%version%-full\" >nul
copy install.bat "release\NetPhantom-v%version%-full\" >nul
copy RunAsAdmin.bat "release\NetPhantom-v%version%-full\" >nul

echo.
echo [6/6] 创建 ZIP 压缩包...
powershell -Command "Compress-Archive -Path 'release\NetPhantom-v%version%\*' -DestinationPath 'release\NetPhantom-v%version%.zip' -Force"
powershell -Command "Compress-Archive -Path 'release\NetPhantom-v%version%-full\*' -DestinationPath 'release\NetPhantom-v%version%-full.zip' -Force"

echo.
echo [✓] 生成 SHA256 校验和...
powershell -Command "$hash1 = (Get-FileHash 'release\NetPhantom-v%version%.zip' -Algorithm SHA256).Hash; $hash2 = (Get-FileHash 'release\NetPhantom-v%version%-full.zip' -Algorithm SHA256).Hash; 'NetPhantom-v%version%.zip' + [Environment]::NewLine + 'SHA256: ' + $hash1 + [Environment]::NewLine + [Environment]::NewLine + 'NetPhantom-v%version%-full.zip' + [Environment]::NewLine + 'SHA256: ' + $hash2 | Out-File -FilePath 'release\checksums.txt' -Encoding UTF8"

echo.
echo [✓] 复制发布说明...
copy RELEASE_NOTES_v%version%.md "release\" >nul

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                    构建完成！                              ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo 发布文件位于 release\ 目录：
dir /b release\*.zip
echo.
echo 文件大小：
powershell -Command "Get-ChildItem release\*.zip | ForEach-Object { '{0,-40} {1,10:N2} MB' -f $_.Name, ($_.Length / 1MB) }"
echo.
echo 下一步：
echo   1. 测试发布包
echo   2. 创建 Git tag: git tag v%version%
echo   3. 推送 tag: git push origin v%version%
echo   4. 在 GitHub 创建 Release 并上传文件
echo   5. 使用 RELEASE_NOTES_v%version%.md 作为发布说明
echo.
pause
