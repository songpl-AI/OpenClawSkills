#!/bin/bash
# OpenClaw Backup Script
# 用法: ./backup-openclaw.sh
# 备份文件将保存在 ~/Desktop/OpenClawBak/

set -e

DESKTOP_DIR="$HOME/Desktop"
BACKUP_DIR="$DESKTOP_DIR/OpenClawBak"
TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)
BACKUP_FILE="$BACKUP_DIR/openclaw-backup-$TIMESTAMP.tar.gz"

echo "🧠 OpenClaw 备份脚本"
echo "===================="

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Stop gateway
echo "📦 停止 Gateway..."
openclaw gateway stop

# Create backup
echo "📦 正在备份 ~/.openclaw/ ..."
tar -czf "$BACKUP_FILE" -C ~ .openclaw

# Restart gateway
echo "▶️  重新启动 Gateway..."
openclaw gateway start

echo ""
echo "✅ 备份完成!"
echo "📁 位置: $BACKUP_FILE"
echo "📁 大小: $(du -h $BACKUP_FILE | cut -f1)"
echo ""
echo "💡 还原命令: cd $BACKUP_DIR && ./restore-openclaw.sh"
