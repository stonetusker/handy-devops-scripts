# Disk Usage Monitoring and Alert Script.sh
> Monitor disk space usage across mounted file systems and receive alerts when usage exceeds a defined threshold.

## Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)
- [Setup & Configuration](#setup--configuration)
- [Usage](#usage)
- [Requirements](#requirements)
- [Example Output](#example-output)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Contact](#contact)

## Overview

This Bash script monitors disk usage across all mounted file systems and records the results in a log file. If any partition exceeds a defined usage threshold (e.g., 80%), it flags the condition as an alert and can optionally send an email notification.

## How It Works

- Executes `df -hP` to list disk usage on all mounted filesystems (excluding `tmpfs`, `cdrom`, etc.).
- Parses usage percentage and mount point.
- Compares usage against a configurable threshold.
- Logs all results to a file with statuses (`Normal` or `ALERT: High Usage`).
- Sends an alert email if any mount exceeds the threshold.

## Setup & Configuration

1. **Clone the repository or download the script.**
2. **Modify script parameters as needed:** 
   - `THRESHOLD`: Maximum allowed disk usage percentage (default `80`)
   - `ALERT_EMAIL`: Email address to receive alerts (optional; local mail setup required)
   - `LOG_FILE`: Path to store disk usage logs (default `$HOME/disk_usage_report.log`)
3. **Permissions:** 
   ```bash
   chmod +x disk-usage-monitoring-and-alert.sh
   ```

## Usage
Run the script manually or schedule it via cron to check usage regularly:
```bash
./disk-usage-monitoring-and-alert.sh
```

- To schedule every day at 7 AM with cron:
  ```
  0 7 * * * /path/to/disk-usage-monitoring-and-alert.sh
  
  ```
## Requirements

- Bash (Tested on Bash 4+)
- Core utilities: df, awk, sed, grep
- Optional: mail command for sending email notifications

## Example Output

- when THRESHOLD=80
===============================================
user@ubuntu-pc:~$ chmod +x disk-usage-monitoring-and-alert.sh
user@ubuntu-pc:~$ ./disk-usage-monitoring-and-alert.sh
user@ubuntu-pc:~$ cat ~/disk_usage_report.log
=== Disk Usage Report - Mon Jul 21 10:47:53 PM IST 2025 ===
Mount Point | Usage (%) | Status
------------------------------------
/ | 12% | Normal
=================================================

- After changing THRESHOLD=1
=============================================
user@ubuntu-pc:~$ chmod +x disk-usage-monitoring-and-alert.sh
user@ubuntu-pc:~$ ./disk-usage-monitoring-and-alert.sh
user@ubuntu-pc:~$ cat ~/disk_usage_report.log
=== Disk Usage Report - Mon Jul 21 10:42:30 PM IST 2025 ===
Mount Point | Usage (%) | Status
------------------------------------
/ | 12% | ALERT: High Usage
================================================

## Troubleshooting

- **No alert email received:**
    Ensure the mail utility is installed and configured.
    Verify  ALERT_EMAIL value is reachable from the local system.

- **Script shows "Permission denied":**
     Ensure script has execute permission: chmod +x scriptname.sh
     Ensure log file path is writable.

- **Log file not updating:**
     Check path in LOG_FILE
     Verify disk space and permissions for that directory

## License

[MIT License](LICENSE)




