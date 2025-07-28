#!/bin/bash

# === CONFIGURATION ===
SOURCE_DIR="$HOME/mydata"                        # Folder to back up (must exist)
BACKUP_DIR="$HOME/local_backups"                # Local folder to store backups
REMOTE_USER="ubuntu"                           # Remote server SSH username
REMOTE_HOST="192.168.1.8                         # Remote Ip
REMOTE_DIR="/home/ubuntu/remote_backups"       # Remote folder to receive backup
LOG_FILE="$HOME/backup_transfer.log"             # Log file in home directory
USE_RSYNC=true                                   # true = use rsync, false = use scp
EMAIL="user@ubuntu-pc"                           # Email for alerts (optional)

# Add a log entry that the script has started
echo "[$(date)] Script started." >> "$LOG_FILE"

# === CREATE TIMESTAMPED BACKUP ===
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# Ensure local backup directory exists
mkdir -p "$BACKUP_DIR"

# Create the backup archive
echo "[$(date)] Creating backup: $BACKUP_PATH" >> "$LOG_FILE"
tar -czf "$BACKUP_PATH" "$SOURCE_DIR" 2>> "$LOG_FILE"

# Check for errors
if [ $? -ne 0 ]; then
    echo "[$(date)] Backup failed!" >> "$LOG_FILE"
    [ -n "$EMAIL" ] && echo "Backup failed on $(hostname) at $(date)" | mail -s "Backup Error" "$EMAIL"
    exit 1
fi

# === TRANSFER BACKUP TO REMOTE ===


