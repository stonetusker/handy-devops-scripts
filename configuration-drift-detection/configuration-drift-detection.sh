
#!/bin/bash

# === CONFIGURATION DRIFT DETECTION SCRIPT ===
# Author: user@ubuntu-pc
# Purpose: Detect unauthorized changes in critical config files

# === SETTINGS ===
CONFIG_FILES=(
    "/etc/ssh/sshd_config"
    "/etc/passwd"
    "/etc/group"
    "/etc/fstab"
)  # Add more files as needed

BASELINE_FILE="/var/tmp/config_hash_baseline.txt"
CURRENT_HASH_FILE="/var/tmp/config_hash_current.txt"
HOSTNAME=$(hostname)
DATE=$(date "+%Y-%m-%d %H:%M:%S")
ALERT_EMAIL="user@ubuntu-pc"

# === FUNCTION TO CALCULATE CHECKSUMS ===
generate_checksums() {
    for file in "${CONFIG_FILES[@]}"; do
        if [[ -f "$file" ]]; then
            sha256sum "$file"
        else
            echo "MISSING: $file"
        fi
    done
}
# === INIT BASELINE IF MISSING ===
if [[ ! -f "$BASELINE_FILE" ]]; then
    echo "[INFO] Baseline file not found. Creating baseline..."
    generate_checksums > "$BASELINE_FILE"
    echo "Baseline created at $BASELINE_FILE"
    exit 0
fi

# === CREATE CURRENT HASH FILE ===
generate_checksums > "$CURRENT_HASH_FILE"

# === COMPARE FILES ===
echo "=== Configuration Drift Report ($DATE) on $HOSTNAME ==="
if ! diff -q "$BASELINE_FILE" "$CURRENT_HASH_FILE" > /dev/null; then
    echo "[ALERT] Configuration drift detected!"
    diff "$BASELINE_FILE" "$CURRENT_HASH_FILE"
    # Optionally send mail alert if mail is configured
    # diff "$BASELINE_FILE" "$CURRENT_HASH_FILE" | mail -s "Drift Detected on $HOSTNAME" "$ALERT_EMAIL"
else
    echo "[OK] No changes detected in monitored config files."
fi

# === CLEANUP ===
rm -f "$CURRENT_HASH_FILE"

