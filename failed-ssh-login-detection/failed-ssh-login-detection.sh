#!/usr/bin/env bash

# --- CONFIGURABLE VARIABLES ---
LOG_FILE="/var/log/auth.log.1"         # Debian/Ubuntu default. Use /var/log/secure for RHEL/CentOS.
THRESHOLD=5                          # Number of failed attempts to trigger alert.
ALERT_EMAIL="user@ubuntu-pc"         # Local user email for alert. Leave blank ("") for syslog only.
SYSLOG_TAG="ssh-alert"               # Syslog identifier.
TMP_FILE="/tmp/ssh_failed_ips.$$"

# --- STEP 1: Extract failed SSH login attempts and offending IPs ---
#grep 'Failed password' "$LOG_FILE"\
LC_ALL=C grep 'Failed password' "$LOG_FILE" \
  | awk '{for(i=1;i<=NF;i++) if($i=="from") {print $(i+1); break}}' \
  | sort | uniq -c | sort -nr | tee "$TMP_FILE"

echo "Temp file contents:"
cat "$TMP_FILE"

# --- STEP 2: Find IPs exceeding threshold ---
alert_ips=$(awk -v th="$THRESHOLD" '$1 >= th {print $2 " ("$1" attempts)"}' "$TMP_FILE")

# --- STEP 3: Send alert if necessary ---
if [[ -n "$alert_ips" ]]; then
  msg="SSH Failed Login Attempts Alert\n\n"
  msg+="Detected IP addresses with $THRESHOLD or more failed logins in $LOG_FILE:\n"
  msg+="$alert_ips\n"

  if [[ -n "$ALERT_EMAIL" ]]; then
    echo -e "$msg" | mail -s "[SSH ALERT] High failed login attempts" "$ALERT_EMAIL"
  else
    logger -t "$SYSLOG_TAG" "$(echo -e "$msg")"
  fi
fi

# --- STEP 4: Cleanup ---

#rm -f "$TMP_FILE"

exit 0
