#!/bin/bash

#################################################
# Log Rotation and Archiving Script
#
# Compresses and archives log files over
# a certain size or age.
#
# Prevents disk bloat and preserves log history.
#################################################

# === Define Parameters ===
log_dir="/var/log/script_log"            # where your logs live
archive_dir="/var/log/script_log/archive"  # where compressed logs will go
max_size_mb=10                            # any log bigger than this will be rotated
max_age_days=7                            # any log older than this will be rotated

# === Ensure archive_dir exists ===
mkdir -p "$archive_dir"

echo "==========================================="
echo "Starting Log Rotation and Archiving Script"
echo "Log Directory     : $log_dir"
echo "Archive Directory : $archive_dir"
echo "Max Size (MB)     : $max_size_mb"
echo "Max Age (Days)    : $max_age_days"
echo "==========================================="

# === Rotate logs larger than max_size_mb ===
echo "Checking for logs larger than $max_size_mb MB..."
find "$log_dir" -type f -name "*.log" -size +${max_size_mb}M | while read logfile; do
    echo "Compressing large log: $logfile"
    gzip "$logfile"
    mv "${logfile}.gz" "$archive_dir/"
done

# === Rotate logs older than max_age_days ===
echo "Checking for logs older than $max_age_days days..."
find "$log_dir" -type f -name "*.log" -mtime +${max_age_days} | while read logfile; do
    echo "Compressing old log: $logfile"
    gzip "$logfile"
    mv "${logfile}.gz" "$archive_dir/"
done

echo "==========================================="
echo "Log Rotation and Archiving Complete."
echo "Compressed logs moved to: $archive_dir"
echo "==========================================="

