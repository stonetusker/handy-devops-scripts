#!/bin/bash

############################################
# Automated System Updates and Patch Notification
#
# Runs package updates/upgrades.
# Logs changed packages and emails a summary to admin
#
############################################

LOG_FILE="/var/log/system_update.log"
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')
TIME_NOW=$(date)

# Ensure log file exists
touch "$LOG_FILE"

echo "---------------------------------------------------" | tee -a "$LOG_FILE"
echo "[INFO] Starting system update on $HOSTNAME at $TIME_NOW" | tee -a "$LOG_FILE"
echo "System IP: $IP_ADDRESS" | tee -a "$LOG_FILE"

echo "[INFO] Saving package list before update..." | tee -a "$LOG_FILE"
dpkg -l > /tmp/packages_before.txt

echo "[INFO] Running apt update..." | tee -a "$LOG_FILE"
apt update >> "$LOG_FILE" 2>&1

echo "[INFO] Running apt upgrade in non-interactive mode..." | tee -a "$LOG_FILE"
DEBIAN_FRONTEND=noninteractive apt -y upgrade >> "$LOG_FILE" 2>&1

echo "[INFO] Saving package list after update..." | tee -a "$LOG_FILE"
dpkg -l > /tmp/packages_after.txt

echo "[INFO] Comparing package lists..." | tee -a "$LOG_FILE"
diff /tmp/packages_before.txt /tmp/packages_after.txt > /tmp/package_diff.txt

# Check if there are changes
if [ -s /tmp/package_diff.txt ]; then
    echo "[INFO] The following packages were changed or updated:" | tee -a "$LOG_FILE"
    cat /tmp/package_diff.txt | tee -a "$LOG_FILE"
else
 echo "[INFO] No package changes detected." | tee -a "$LOG_FILE"
fi

echo "[INFO] Update completed at $(date)" | tee -a "$LOG_FILE"
echo "---------------------------------------------------" | tee -a "$LOG_FILE"

# === Send Summary Email ===
if [ -s "$LOG_FILE" ]; then
    mail -s "System Update Log - $(hostname)" user@ubuntu-pc < "$LOG_FILE"
    echo "[INFO] Email sent to user@ubuntu-pc"
else
    echo "[INFO] Log file empty. No email sent."
fi

