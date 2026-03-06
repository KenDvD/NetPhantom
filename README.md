<div align="center">

# 🌐 NetPhantom

<img src="APPicon.ico" alt="NetPhantom Logo" width="128" height="128">

**专业的网络扫描与 ARP 安全测试工具**

[![.NET](https://img.shields.io/badge/.NET-8.0-512BD4?style=flat-square&logo=dotnet)](https://dotnet.microsoft.com/)
[![Platform](https://img.shields.io/badge/Platform-Windows-0078D6?style=flat-square&logo=windows)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square)](https://github.com/yourusername/NetPhantom/releases)

[English](README_EN.md) | 简体中文

</div>

---

## 📖 目录

- [功能特性](#-功能特性)
- [界面预览](#-界面预览)
- [快速开始](#-快速开始)
- [系统要求](#-系统要求)
- [安装指南](#-安装指南)
- [使用说明](#-使用说明)
- [技术架构](#-技术架构)
- [常见问题](#-常见问题)
- [安全声明](#️-安全声明)
- [贡献指南](#-贡献指南)
- [许可证](#-许可证)

---

## ⚠️ 安全声明

> **本工具仅用于授权的网络安全测试和教育目的。**
> 
> 未经授权使用 ARP 欺骗可能违反当地法律法规，使用者需自行承担法律责任。请确保：
> - ✅ 仅在自己拥有或获得授权的网络环境中使用
> - ✅ 用于学习网络安全知识和合法的渗透测试
> - ✅ 遵守当地法律法规和网络安全相关规定
> - ❌ 不得用于任何非法目的或未经授权的网络攻击

---

## ✨ 功能特性

### 🔍 主机发现模块

<table>
<tr>
<td width="50%">

**灵活的扫描方式**
- 📡 支持 CIDR 格式（`192.168.1.0/24`）
- 📡 支持 IP 范围格式（`192.168.1.1-254`）
- 🚀 ARP 扫描模式（快速）
- 🌐 Ping 扫描模式（可靠）

</td>
<td width="50%">

**丰富的信息展示**
- 🖥️ IP 地址
- 🔌 MAC 地址
- 🏢 设备厂商（OUI 查询）
- � 主机名
- ⏱️ 响应时间

</td>
</tr>
</table>

**高级特性**
- ⚡ 并发扫描，速度快
- 🎯 实时进度显示
- 🛑 支持取消操作
- 📋 双击主机自动填充到欺骗模块
- 💾 扫描结果可导出

### 🎭 ARP 欺骗模块

<table>
<tr>
<td width="50%">

**简单易用**
- 🎛️ 网卡列表选择
- 🎯 目标信息自动填充
- 🌐 网关自动检测
- ⚙️ 可调节发送间隔

</td>
<td width="50%">

**实时监控**
- 📊 运行状态显示
- 📈 发送计数统计
- 🕐 最后发送时间
- ✅ 欺骗效果验证

</td>
</tr>
</table>

**安全保护**
- ⚠️ 操作前安全警告
- 📝 详细的使用说明
- 🔒 需要管理员权限
- 📋 完整的操作日志

### 🎨 现代化界面

- 🌙 Material Design 深色主题
- 🎯 直观的左侧导航
- 📱 响应式布局设计
- 📊 数据表格展示
- 📜 实时操作日志
- 🎨 科技感十足的 UI

---

## 🖼️ 界面预览

<div align="center">

### 主机扫描界面
*快速发现网络中的活动主机*

### ARP 欺骗界面
*专业的 ARP 安全测试工具*

### 设置界面
*灵活的配置选项*

</div>

---

## 🚀 快速开始

### 方法一：使用发布版本（推荐）

1. **下载最新版本**
   - 访问 [Releases](https://github.com/yourusername/NetPhantom/releases) 页面
   - 下载 `NetPhantom-v1.0.0.zip`（标准版）或 `NetPhantom-v1.0.0-full.zip`（完整版）

2. **选择版本**
   - **标准版**（3.30 MB）：需要安装 .NET 8.0 Runtime
   - **完整版**（69.92 MB）：包含 Runtime，解压即用

3. **运行程序**
   ```bash
   # 右键 install.bat → "以管理员身份运行"
   # 或者
   # 右键 NetPhantom.exe → "以管理员身份运行"
   ```

### 方法二：从源码构建

```bash
# 克隆仓库
git clone https://github.com/yourusername/NetPhantom.git
cd NetPhantom

# 还原依赖
dotnet restore

# 编译项目
dotnet build -c Release

# 运行程序（需要管理员权限）
dotnet run --project NetPhantom.csproj
```

---

## 💻 系统要求

### 最低配置

| 项目 | 要求 |
|------|------|
| **操作系统** | Windows 10 (1809+) / Windows 11 |
| **架构** | x64 (64-bit) |
| **.NET Runtime** | .NET 8.0 Desktop Runtime |
| **网络驱动** | Npcap 或 WinPcap |
| **权限** | 管理员权限 |
| **内存** | 最低 512 MB，推荐 1 GB+ |
| **磁盘空间** | 100 MB |

### 推荐配置

- Windows 11 最新版本
- .NET 8.0 最新版本
- Npcap 最新版本（推荐使用 Npcap 而非 WinPcap）
- 有线网络连接（无线网卡可能受限）

---

## 📦 安装指南

### 步骤 1：安装 .NET 8.0 Runtime

**检查是否已安装：**
```bash
dotnet --version
```

**如果未安装：**
1. 访问 [.NET 8.0 下载页面](https://dotnet.microsoft.com/download/dotnet/8.0)
2. 下载并安装 ".NET Desktop Runtime 8.0.x"

### 步骤 2：安装 Npcap 驱动

**检查是否已安装：**
- 打开"控制面板" → "程序和功能"
- 查找 "Npcap" 或 "WinPcap"

**如果未安装：**

1. 访问 [Npcap 官网](https://npcap.com/#download)
2. 下载最新版本的 Npcap 安装程序
3. 运行安装程序（需要管理员权限）
4. **重要**：安装时请勾选以下选项：
   - ✅ **Install Npcap in WinPcap API-compatible Mode**
   - ✅ Support raw 802.11 traffic（可选）
   - ✅ Install Npcap Loopback Adapter（可选）

### 步骤 3：运行 NetPhantom

**使用自动安装脚本（推荐）：**
```bash
# 右键 install.bat → "以管理员身份运行"
```

**手动运行：**
```bash
# 右键 NetPhantom.exe → "以管理员身份运行"
```

---

## 📚 使用说明

### 主机扫描

1. **选择网络接口**
   - 在下拉列表中选择要使用的网卡
   - 显示格式：`网卡名称 (IP地址)`

2. **输入扫描范围**
   - CIDR 格式：`192.168.1.0/24`
   - 范围格式：`192.168.1.1-192.168.1.254`
   - 单个 IP：`192.168.1.100`

3. **选择扫描模式**
   - **ARP 扫描**：速度快，仅限局域网
   - **Ping 扫描**：更可靠，支持跨网段

4. **开始扫描**
   - 点击"开始扫描"按钮
   - 实时查看扫描进度和结果
   - 可随时点击"取消"停止扫描

5. **查看结果**
   - 双击主机行可自动跳转到 ARP 欺骗页面
   - 结果包含：IP、MAC、厂商、主机名、响应时间

### ARP 欺骗

1. **选择网络接口**
   - 选择与目标主机在同一网段的网卡

2. **填写目标信息**
   - **目标 IP**：要欺骗的主机 IP
   - **目标 MAC**：目标主机的 MAC 地址
   - 💡 提示：可从扫描结果双击自动填充

3. **设置网关**
   - 点击"自动检测"按钮获取默认网关
   - 或手动输入网关 IP 地址

4. **配置参数**
   - **发送间隔**：默认 1000ms（1秒）
   - 可根据需要调整（建议 500-2000ms）

5. **开始欺骗**
   - 点击"开始欺骗"按钮
   - 阅读并确认安全警告
   - 监控运行状态和发送计数

6. **停止欺骗**
   - 点击"停止"按钮
   - 查看操作日志了解详情

### 验证欺骗效果

**在目标主机上执行：**
```bash
# Windows
arp -a

# Linux/Mac
arp -n
```

查看网关 IP 对应的 MAC 地址是否变成了攻击机的 MAC 地址。

**详细说明请参考：**
- [ARP 欺骗使用说明](ARP欺骗使用说明.md)
- [安装指南](INSTALL_GUIDE.md)

---

## 🏗️ 技术架构

### 技术栈

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│  WPF + Material Design + MVVM Pattern   │
├─────────────────────────────────────────┤
│            Business Layer               │
│   ViewModels + Services + Commands      │
├─────────────────────────────────────────┤
│             Data Layer                  │
│      Models + Repositories              │
├─────────────────────────────────────────┤
│          Infrastructure Layer           │
│  SharpPcap + PacketDotNet + Serilog     │
└─────────────────────────────────────────┘
```

### 核心依赖

| 库 | 版本 | 用途 |
|---|------|------|
| **.NET** | 8.0 | 应用程序框架 |
| **WPF** | 8.0 | 用户界面框架 |
| **CommunityToolkit.Mvvm** | 8.2.2 | MVVM 模式支持 |
| **MaterialDesignThemes** | 4.9.0 | Material Design UI |
| **SharpPcap** | 6.2.5 | 网络数据包捕获 |
| **PacketDotNet** | 1.4.7 | 数据包解析 |
| **Serilog** | 3.1.1 | 日志记录 |

### 项目结构

```
NetPhantom/
├── 📁 Views/                    # 视图层
│   ├── ScannerView.xaml        # 扫描界面
│   ├── SpooferView.xaml        # 欺骗界面
│   └── SettingsView.xaml       # 设置界面
├── 📁 ViewModels/               # 视图模型层
│   ├── MainViewModel.cs        # 主视图模型
│   ├── ScannerViewModel.cs     # 扫描视图模型
│   └── SpooferViewModel.cs     # 欺骗视图模型
├── 📁 Models/                   # 数据模型层
│   ├── HostInfo.cs             # 主机信息模型
│   └── NetworkInterfaceInfo.cs # 网卡信息模型
├── 📁 Services/                 # 服务层
│   ├── ArpScannerService.cs    # ARP 扫描服务
│   ├── ArpSpoofService.cs      # ARP 欺骗服务
│   └── NetworkHelper.cs        # 网络辅助类
├── 📁 Helpers/                  # 辅助类
│   └── OuiLookup.cs            # MAC 厂商查询
├── 📁 Converters/               # 值转换器
│   └── InverseBooleanConverter.cs
├── 📁 logs/                     # 日志目录
├── App.xaml                    # 应用程序入口
├── MainWindow.xaml             # 主窗口
└── NetPhantom.csproj           # 项目文件
```

### 设计模式

- **MVVM**：视图与业务逻辑分离
- **单例模式**：ViewModel 实例管理
- **命令模式**：用户操作封装
- **观察者模式**：数据绑定和事件通知
- **依赖注入**：服务解耦

---

## ❓ 常见问题

<details>
<summary><b>Q: 提示"未找到网络接口"怎么办？</b></summary>

**解决方案：**
1. 确认 Npcap 已正确安装
2. 以管理员身份运行程序
3. 检查网络适配器是否正常工作
4. 重启计算机后再试
5. 检查 Npcap 服务是否运行：
   ```bash
   sc query npcap
   ```
</details>

<details>
<summary><b>Q: 扫描没有结果怎么办？</b></summary>

**解决方案：**
1. 检查 IP 范围是否正确
2. 确认目标主机在线
3. 尝试使用 Ping 扫描模式
4. 检查防火墙设置
5. 确认网卡选择正确
</details>

<details>
<summary><b>Q: ARP 欺骗无效怎么办？</b></summary>

**可能原因：**
1. 目标设备有 ARP 防护（Windows Defender 等）
2. 交换机有保护机制（DAI、Port Security）
3. 目标配置了静态 ARP 绑定
4. 网卡不支持混杂模式

**解决方案：**
1. 在测试环境中关闭安全软件
2. 使用自己控制的网络环境
3. 增加发送频率（减小发送间隔）
4. 使用有线网卡而非无线网卡
5. 查看操作日志获取详细错误信息
</details>

<details>
<summary><b>Q: 程序无法启动怎么办？</b></summary>

**解决方案：**
1. 确认已安装 .NET 8.0 Runtime
2. 检查是否以管理员身份运行
3. 查看日志文件：`logs/netphantom-*.log`
4. 尝试重新安装 Npcap
5. 检查 Windows 事件查看器
</details>

<details>
<summary><b>Q: 标准版和完整版有什么区别？</b></summary>

**标准版（3.30 MB）：**
- 只包含应用程序本身
- 需要用户电脑上已安装 .NET 8.0 Runtime
- 体积小，适合已有 .NET 环境的用户

**完整版（69.92 MB）：**
- 包含应用程序 + .NET 8.0 Runtime
- 无需单独安装 Runtime，解压即用
- 体积大，但更方便

**功能完全相同，根据需要选择。**
</details>

---

## 🛠️ 故障排除

### 日志文件位置

```
NetPhantom/logs/netphantom-YYYYMMDD.log
```

### 常见错误代码

| 错误 | 原因 | 解决方案 |
|------|------|----------|
| `ERROR_NO_INTERFACE` | 未找到网络接口 | 安装 Npcap，以管理员运行 |
| `ERROR_PERMISSION_DENIED` | 权限不足 | 以管理员身份运行 |
| `ERROR_DEVICE_NOT_READY` | 网卡未就绪 | 检查网卡状态，重启程序 |
| `ERROR_TIMEOUT` | 操作超时 | 检查网络连接，增加超时时间 |

### 获取帮助

如果遇到问题：
1. 📖 查看 [安装指南](INSTALL_GUIDE.md)
2. 📖 查看 [ARP 欺骗使用说明](ARP欺骗使用说明.md)
3. 📋 查看日志文件
4. 🐛 在 [Issues](https://github.com/yourusername/NetPhantom/issues) 提交问题
5. 💬 提供详细的错误信息和日志

---

## 🤝 贡献指南

我们欢迎所有形式的贡献！

### 如何贡献

1. **Fork 本仓库**
2. **创建特性分支** (`git checkout -b feature/AmazingFeature`)
3. **提交更改** (`git commit -m 'Add some AmazingFeature'`)
4. **推送到分支** (`git push origin feature/AmazingFeature`)
5. **开启 Pull Request**

### 贡献类型

- 🐛 报告 Bug
- 💡 提出新功能建议
- 📝 改进文档
- 🔧 提交代码修复
- 🌍 翻译文档

详细信息请参考 [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

```
MIT License

Copyright (c) 2026 NetPhantom

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 🙏 致谢

感谢以下开源项目：

- [SharpPcap](https://github.com/chmorgan/sharppcap) - 网络数据包捕获库
- [PacketDotNet](https://github.com/chmorgan/packetnet) - 数据包解析库
- [MaterialDesignInXamlToolkit](https://github.com/MaterialDesignInXAML/MaterialDesignInXamlToolkit) - Material Design UI 库
- [CommunityToolkit.Mvvm](https://github.com/CommunityToolkit/dotnet) - MVVM 工具包
- [Serilog](https://github.com/serilog/serilog) - 日志库
- [Npcap](https://npcap.com/) - Windows 数据包捕获库

---

## 📞 联系方式

- 📧 Email: your.email@example.com
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/NetPhantom/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/yourusername/NetPhantom/discussions)

---

## 🔖 版本历史

查看 [CHANGELOG.md](CHANGELOG.md) 了解详细的版本更新历史。

### 最新版本：v1.0.0 (2026-03-06)

- ✨ 主机发现模块
- 🎭 ARP 欺骗模块
- 🎨 Material Design UI
- 📝 完整的文档

---

## ⭐ Star History

如果这个项目对你有帮助，请给我们一个 Star ⭐

---

<div align="center">

**Made with ❤️ by NetPhantom Team**

[⬆ 回到顶部](#-netphantom)

</div>
