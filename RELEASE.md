# 📦 发布指南

本文档说明如何在 GitHub 上发布 NetPhantom 的新版本。

## 📋 发布前检查清单

- [ ] 所有功能已测试通过
- [ ] 更新 `CHANGELOG.md` 添加新版本信息
- [ ] 更新 `NetPhantom.csproj` 中的版本号
- [ ] 更新 `README.md` 中的版本徽章
- [ ] 运行 `build-release-auto.bat` 生成发布包
- [ ] 测试生成的发布包
- [ ] 提交所有更改到 Git

## 🚀 发布步骤

### 1. 创建 Git Tag

```bash
# 创建带注释的标签
git tag -a v1.0.0 -m "Release version 1.0.0"

# 推送标签到远程仓库
git push origin v1.0.0
```

### 2. 在 GitHub 创建 Release

1. 访问仓库的 Releases 页面
2. 点击 "Draft a new release"
3. 填写以下信息：

**Tag version:** `v1.0.0`

**Release title:** `NetPhantom v1.0.0 - 首个正式版本`

**Description:** 使用以下模板

```markdown
## 🎉 NetPhantom v1.0.0

这是 NetPhantom 的首个正式版本！

### ✨ 主要特性

- 🔍 主机发现模块
  - 支持 CIDR 和 IP 范围格式
  - ARP 和 Ping 双扫描模式
  - 实时显示主机信息和厂商识别
  
- 🎭 ARP 欺骗模块
  - 简单易用的界面
  - 网关自动检测
  - 实时状态监控
  
- 🎨 现代化界面
  - Material Design 深色主题
  - 直观的操作流程
  - 完整的操作日志

### 📦 下载

选择适合你的版本：

- **标准版** (`NetPhantom-v1.0.0.zip` - 3.30 MB)
  - 需要安装 .NET 8.0 Runtime
  - 适合已有 .NET 环境的用户
  
- **完整版** (`NetPhantom-v1.0.0-full.zip` - 69.92 MB)
  - 包含 .NET Runtime，解压即用
  - 推荐给首次使用的用户

### 📋 系统要求

- Windows 10/11 (64-bit)
- .NET 8.0 Runtime（标准版需要）
- Npcap 驱动程序
- 管理员权限

### 📚 文档

- [安装指南](INSTALL_GUIDE.md)
- [使用说明](README.md#-使用说明)
- [ARP 欺骗详细说明](ARP欺骗使用说明.md)
- [更新日志](CHANGELOG.md)

### 🔐 校验和

下载后请验证文件完整性：

```
NetPhantom-v1.0.0.zip
SHA256: [从 checksums.txt 复制]

NetPhantom-v1.0.0-full.zip
SHA256: [从 checksums.txt 复制]
```

### ⚠️ 安全声明

本工具仅用于授权的网络安全测试和教育目的。未经授权使用可能违反法律。

### 🐛 已知问题

- 无线网卡可能不支持 ARP 欺骗
- 某些防火墙可能阻止操作

### 🙏 致谢

感谢所有贡献者和测试者！

---

**完整更新日志:** [CHANGELOG.md](CHANGELOG.md)
```

### 3. 上传发布文件

从 `release/` 目录上传以下文件：

- `NetPhantom-v1.0.0.zip`
- `NetPhantom-v1.0.0-full.zip`
- `checksums.txt`

### 4. 发布

1. 勾选 "Set as the latest release"
2. 如果是预发布版本，勾选 "This is a pre-release"
3. 点击 "Publish release"

## 📝 发布后

1. **更新文档**
   - 在 README.md 中更新下载链接
   - 更新版本徽章

2. **通知用户**
   - 在 Discussions 发布公告
   - 更新项目主页

3. **监控反馈**
   - 关注 Issues 中的问题报告
   - 及时回复用户反馈

## 🔄 版本号规范

遵循 [语义化版本](https://semver.org/lang/zh-CN/) 规范：

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能性新增
- **修订号**：向下兼容的问题修正

示例：
- `1.0.0` - 首个正式版本
- `1.1.0` - 添加新功能
- `1.1.1` - Bug 修复
- `2.0.0` - 重大更新，可能不兼容

## 📊 发布检查

使用以下命令验证发布包：

```bash
# 检查文件大小
powershell -Command "Get-ChildItem release\*.zip | Select-Object Name, @{Name='Size(MB)';Expression={[math]::Round($_.Length/1MB, 2)}}"

# 验证 SHA256
powershell -Command "Get-FileHash release\NetPhantom-v1.0.0.zip -Algorithm SHA256"
powershell -Command "Get-FileHash release\NetPhantom-v1.0.0-full.zip -Algorithm SHA256"

# 测试解压
powershell -Command "Expand-Archive -Path release\NetPhantom-v1.0.0.zip -DestinationPath test-extract -Force"
```

## 🆘 常见问题

**Q: 如何删除已发布的版本？**
A: 在 Releases 页面找到对应版本，点击 "Delete" 按钮。注意：这不会删除 Git tag。

**Q: 如何修改已发布的版本？**
A: 点击版本的 "Edit" 按钮，可以修改描述和上传的文件。

**Q: 如何创建预发布版本？**
A: 在发布时勾选 "This is a pre-release" 选项。

## 📞 需要帮助？

如有问题，请在 [Issues](https://github.com/yourusername/NetPhantom/issues) 中提问。
