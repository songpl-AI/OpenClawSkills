---
name: daily-summary
description: |
  每日总结技能。触发方式：(1) 用户说"今日总结"、"总结今天"、"今天做了什么" (2) heartbeat 定时触发 (3) cron 定时任务。
  用于汇总当天的活动、对话、完成任务等，生成简洁的每日总结。
---

# 每日总结

自动汇总当天发生的事件，生成简洁的每日总结。

## 触发方式

### 手动触发
- 用户说「今日总结」「总结今天」「今天做了什么」
- 直接调用技能

### 自动触发 (Heartbeat)
在 main agent 的 heartbeat 中自动执行：

```bash
# 读取今日记忆文件，生成总结
```

### 自动触发 (Cron)
可配置每日定时执行（如每天 21:00）：

```bash
openclaw cron add "daily-summary" "0 21 * * *" --agent main
```

## 数据来源

1. **当日记忆文件** - `~/.openclaw/memory/YYYY-MM-DD.md`
2. **会话历史** - 当天的对话记录
3. **Git 提交** - 当天的代码提交
4. **日历事件** - 当天的日程（可选）

## 输出格式

```
## 📅 2026年3月15日 总结

### 💬 对话
- 与 Allen 在 webchat 讨论了 OpenClaw 迁移技能
- 通过飞书讨论工作安排

### 🛠️ 完成的任务
- 创建了 openclaw-migration 备份技能
- 配置了 Get笔记 API
- 保存了 2 个链接

### 📝 记录的笔记
- [链接] OpenClaw教程
- [链接] Agent - Lilian Weng

### 🔧 技能更新
- 安装了 getnote 技能
- 更新了 GitHub 仓库 OpenClawSkills
```

## 脚本

使用 `scripts/summarize.sh` 生成当日总结：

```bash
./scripts/summarize.sh
```

输出 Markdown 格式的总结，可保存到记忆文件或发送给用户。
