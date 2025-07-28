# Automated Server Health Check and Report  
> A Bash script to monitor server health by automating resource checks—ideal for system administrators needing quick visibility into CPU, memory, disk, and network usage, hands-free reporting and alert notification.
 
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

This script performs an automated system health check by collecting metrics related to real-time CPU, memory, disk, and network usage.Results are neatly summarized either in a report file or sent via email. Alerts are triggered when resource usage exceeds predefined thresholds, helping administrators mitigate issues before they escalate.

## How It Works

- Gathers system resource usage using built-in Linux commands.
- Compares CPU, memory, and disk usage against user-defined thresholds.
- Summarizes findings in a structured report file.
- Optional: sends alert email if thresholds are breached.

## Setup & Configuration

1. Download or create the script.
2. Edit configurable parameters in the script:
   - `report_file`: Path to save the system report (default `/tmp/system_health_report.txt`)  
   - `cpu_threshold`: Alert if CPU usage exceeds this % (default `80`)  
   - `mem_threshold`: Alert if memory usage exceeds this % (default `80`)  
   - `disk_threshold`: Alert if any partition exceeds this % (default `90`)  
   - `email_to`: Optional email address to send alerts  

3. **Permissions:**  
   Make the script executable:
   ```bash
   chmod +x server-health-check-and-report.sh

## Usage
Run manually or schedule as a cron job for regular monitoring:
   ```bash
./server-health-check.sh
 ```

To schedule hourly with cron:
```
0 * * * * /path/to/server-health-check.sh
```
## Requirements
Bash (Tested on Bash 4+)
mail (for email reports, optional)
User must have permissions to execute system health commands and write report output

## Example Output:
```
==============================================
     Automated Server Health Report
Date       : 2025-07-17
Hostname   : ubuntu-pc
==============================================

CPU Usage  : 23%  
Memory     : 68% used  
Disk Usage : /dev/sda1 at 91% (ALERT)
Network    : IP - 192.168.1.10

==============================================
WARNING: Disk usage on /dev/sda1 is above 90%
Report saved to: /tmp/system_health_report.txt
==============================================

```

## Troubleshooting
- **Script does not run:**
Check execution permissions of the file.

- **Report not generated:**
Verify output path and that there is sufficient disk space/permissions.

- **Email not received:**
Confirm that the mail utility is installed, configured, and that email settings are correctly set.

- **Metrics show 0 or blank:**
Ensure the server supports standard health reporting tools like top, free, df, or ifconfig.

## License
MIT License



