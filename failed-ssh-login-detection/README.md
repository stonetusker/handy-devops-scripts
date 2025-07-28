#  SSH Failed Login Detection Script

> Checks system logs to find failed SSH login attempts. If too many failures happen, it identifies
>  the IP addresses and sends an alert.  

##  Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)
- [Setup & Configuration](#setup--configuration)
- [Usage](#usage)
- [Requirements](#requirements)
- [Example Output](#example-output)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Contact](#contact)

##  Overview

This Bash script monitors SSH authentication logs for repeated failed login attempts. It Checks system logs to find failed SSH login attempts. If too many failures happen, it identifies the IP addresses and sends an alert. 

## How It Works

- Scans `/var/log/auth.log` (Ubuntu/Debian) or `/var/log/secure` (RHEL/CentOS).
- Filters lines containing `Failed password`.
- Extracts source IPs and counts failed attempts per IP.
- If any IP exceeds the threshold, an alert is triggered:
  - via email if configured.
  - via syslog if email is not set.
- Uses a temporary file for intermediate processing and deletes it after execution.

## Setup & Configuration

1. **Clone the repository or download the script.**
2. **Modify script parameters as needed:**
 
   LOG_FILE="/var/log/auth.log"     # Change to /var/log/secure for RHEL/CentOS
   THRESHOLD=5                      # Number of failed attempts before alert
   ALERT_EMAIL="user@ubuntu-pc"     # Leave empty ("") for syslog-only alerts
   SYSLOG_TAG="ssh-alert"           # Tag for syslog entries
   
3. **Permissions:**  
   Ensure script execution rights:  
   ```bash
   chmod +x failed-ssh-login-detection.sh
    ```
## Usage
Run the script manually or automate it using cron.
```bash
./failed-ssh-login-detector.sh
```
- To Schedule with Cron (every 15 minutes):
```
*/15 * * * * /path/to/failed-ssh-login-detector.sh
```
Check If Script Created the Output File 
/tmp/ssh_failed_ips.83730  /tmp/ssh_failed_ips.93624

Trigger a Failed SSH Login
ssh invaliduser@localhost
Enter any password 3–4 times.
Now check:  grep "Failed password" /var/log/auth.log

THRESHOLD=1 Temporarily (For Testing)
./failed-ssh-login-detection.sh

## Requirements

- Bash (4+)
- user to have access to system authentication logs
- mail utility (if using email alerts)

## Example Output

![failed-ssh-login-detection1](https://github.com/user-attachments/assets/e897455f-b563-4ab6-9635-97309ecac408)





