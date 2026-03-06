# NetPhantom 安装指南

## 📋 系统要求

- Windows 10/11 (64-bit)
- .NET 8 Runtime
- Npcap 驱动程序
- 管理员权限

## 🚀 快速安装（推荐）

### 方法 1：自动安装脚本

运行 `install.bat`，脚本会自动：
1. 检测 .NET 8 Runtime
2. 检测 Npcap 驱动
3. 如果缺少，提供下载链接
4. 安装完成后启动程序

### 方法 2：手动安装

#### 步骤 1：安装 .NET 8 Runtime

**检查是否已安装：**
```bash
dotnet --version
```

**如果未安装：**
- 访问：https://dotnet.microsoft.com/download/dotnet/8.0
- 下载并安装 ".NET Desktop Runtime 8.0.x"

#### 步骤 2：安装 Npcap 驱动

**检查是否已安装：**
- 打开"控制面板" → "程序和功能"
- 查找 "Npcap" 或 "WinPcap"

**如果未安装：**

1. 访问官方网站：https://npcap.com/#download
2. 下载最新版本的 Npcap 安装程序
3. 运行安装程序（需要管理员权限）
4. **重要**：安装时请勾选以下选项：
   - ✅ **Install Npcap in WinPcap API-compatible Mode**
   - ✅ Support raw 802.11 traffic (可选)
   - ✅ Install Npcap Loopback Adapter (可选)

#### 步骤 3：运行 NetPhantom

1. 解压 NetPhantom 压缩包
2. 双击 `RunAsAdmin.bat` 或
3. 右键 `NetPhantom.exe` → "以管理员身份运行"

## 🔧 故障排除

### 问题 1：提示"未找到网络接口"

**解决方案：**
1. 确认 Npcap 已正确安装
2. 重启计算机
3. 以管理员身份运行程序
4. 检查 Npcap 服务是否运行：
   ```bash
   sc query npcap
   ```

### 问题 2：程序无法启动

**解决方案：**
1. 确认已安装 .NET 8 Runtime
2. 检查是否以管理员身份运行
3. 查看日志文件：`logs/netphantom-*.log`

### 问题 3：扫描无结果

**解决方案：**
1. 检查防火墙设置
2. 确认网络连接正常
3. 尝试使用 Ping 扫描模式
4. 检查 IP 范围是否正确

### 问题 4：ARP 欺骗无效

**解决方案：**
1. 确认目标 MAC 地址正确
2. 检查网关 IP 是否正确
3. 某些交换机有 ARP 防护功能
4. 查看操作日志获取详细错误

## 📦 离线安装包

如果你的环境无法访问互联网，可以准备以下离线安装包：

1. **NetPhantom 程序**
   - 从 GitHub Releases 下载最新版本

2. **.NET 8 Runtime 离线安装包**
   - 下载地址：https://dotnet.microsoft.com/download/dotnet/8.0
   - 选择 "Windows x64 Installer"

3. **Npcap 离线安装包**
   - 下载地址：https://npcap.com/#download
   - 选择 "Npcap Installer"

## 🌐 在线资源

- **项目主页**：https://github.com/[your-username]/NetPhantom
- **问题反馈**：https://github.com/[your-username]/NetPhantom/issues
- **Npcap 官网**：https://npcap.com/
- **.NET 官网**：https://dotnet.microsoft.com/

## ⚠️ 重要提示

1. **管理员权限**：本程序必须以管理员权限运行
2. **防火墙**：首次运行时可能需要允许防火墙访问
3. **杀毒软件**：某些杀毒软件可能会误报，请添加信任
4. **法律合规**：仅在授权环境中使用，遵守当地法律法规

## 📞 获取帮助

如果遇到问题，请：
1. 查看 `README.md` 文档
2. 查看 `logs/` 目录下的日志文件
3. 在 GitHub Issues 提交问题
4. 提供详细的错误信息和日志
