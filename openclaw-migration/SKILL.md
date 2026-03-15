---
name: openclaw-migration
description: |
  Migrate OpenClaw from one machine to another, preserving all configurations, credentials, 
  OAuth tokens, session history, and workspace files. Use when: (1) user wants to move OpenClaw 
  to a new Mac/computer, (2) user mentions "迁移", "migrate", "backup and restore", or "move to new machine",
  (3) user wants to transfer OpenClaw installation including channels, API keys, and sessions.
---

# OpenClaw Migration

将 OpenClaw 从一台机器迁移到另一台机器，保留所有配置、凭证和会话。

## 核心思路

复制状态目录 + 工作区 → 安装 → doctor → 重启。无需重新进行新手引导。

## 要迁移的内容

| 项目 | 默认路径 | 包含内容 |
|------|----------|----------|
| 状态目录 | ~/.openclaw/ | 配置、凭证、API 密钥、OAuth 令牌、会话历史、渠道状态 |
| 工作区 | ~/.openclaw/workspace/ | MEMORY.md、USER.md、Skills 笔记等智能体文件 |

- 两者都复制 = 完整迁移
- 只复制工作区 = 不保留会话和凭证

## 使用方式

### 备份（旧机器）

```bash
~/.openclaw/skills/openclaw-migration/scripts/backup-openclaw.sh
```

- 会在桌面创建 `~/Desktop/OpenClawBak/` 目录
- 备份文件：`openclaw-backup-2026-03-15-183000.tar.gz`
- 还原脚本自动包含在同目录中

### 还原（新机器）

1. 将整个 `OpenClawBak` 文件夹复制到新机器桌面
2. 进入该目录并运行还原脚本：

```bash
cd ~/Desktop/OpenClawBak
./restore-openclaw.sh
```

不传参数时自动使用最新的备份文件。也可以指定文件：
```bash
./restore-openclaw.sh openclaw-backup-2026-03-15-183000.tar.gz
```

## 验证清单

- [ ] `openclaw status` 显示 Gateway 正在运行
- [ ] 渠道仍然连接（WhatsApp 不需要重新配对）
- [ ] Dashboard 显示现有会话
- [ ] 工作区文件存在

## 常见陷阱

1. **只复制了配置文件**：不够，必须迁移整个 `~/.openclaw/` 文件夹（凭证存在 `credentials/` 子目录）
2. **权限问题**：确保状态目录由运行 Gateway 的用户拥有，不要用 root 复制
3. **备份安全**：`~/.openclaw/` 含 API 密钥等敏感信息，加密存储，勿通过不安全渠道传输
