#!/bin/bash

# === CONFIGURATION ===
DOMAINS=("example.com" "google.com")  # Add  domains here
THRESHOLD_DAYS=30                     # Alert if expiry is within this many days
ALERT_EMAIL="user@ubuntu-pc"         # Replace with email or user
LOG_FILE="$HOME/ssl_expiry.log"      # Log file location

# === CHECK SSL EXPIRY ===
> "$LOG_FILE"
echo "=== SSL Certificate Expiry Report - $(date) ===" >> "$LOG_FILE"

for DOMAIN in "${DOMAINS[@]}"; do
    EXPIRY_DATE=$(echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN:443" 2>/dev/null | \
                  openssl x509 -noout -enddate | cut -d= -f2)

    if [ -z "$EXPIRY_DATE" ]; then
        echo "$DOMAIN: Unable to retrieve SSL certificate" >> "$LOG_FILE"
        continue
    fi

    EXPIRY_SECONDS=$(date -d "$EXPIRY_DATE" +%s)
    CURRENT_SECONDS=$(date +%s)
    DIFF_DAYS=$(( (EXPIRY_SECONDS - CURRENT_SECONDS) / 86400 ))

    if (( DIFF_DAYS < 0 )); then
        STATUS="EXPIRED"
    elif (( DIFF_DAYS <= THRESHOLD_DAYS )); then
        STATUS="EXPIRING in $DIFF_DAYS days"
    else
        STATUS="Valid ($DIFF_DAYS days left)"
    fi

    echo "$DOMAIN: $STATUS (Expires on: $EXPIRY_DATE)" >> "$LOG_FILE"
done

# === ALERT IF ANY NEAR EXPIRY ===
if grep -q "EXPIRING" "$LOG_FILE"; then
    mail -s "SSL Certificate Expiry Alert" "$ALERT_EMAIL" < "$LOG_FILE"
fi


