# Automated System Updates and Patch Notification Script
> Keep your system secure and up-to-date with minimal effort. This Bash script automates package updates and emails a summary log to system administrators.

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

This Bash script automates the process of running system updates and upgrades using `apt`. It logs the actions, compares pre- and post-update package lists, and sends a summary email to system administrators. This is especially useful for unattended systems or scheduled update jobs.

## How It Works

- Captures a snapshot of the currently installed packages.
- Runs `apt update` and `apt upgrade` in non-interactive mode.
- Captures the updated package list after the upgrade.
- Compares before and after snapshots to detect changes.
- Logs the entire process to a file.
- Emails the update log summary to a configured recipient.

## Setup & Configuration

1. **Download the script**  
   Save the script as `automated-system-updates-and-patch-notification.shh`.
2. **Modify script parameters as needed:**
   - `LOG_FILE`: Path where the system update logs will be stored (default /var/log/system_update.log)
   - `EMAIL`: Email address of the admin who will receive the update summary (default user@ubuntu-pc)
   - `HOSTNAME`: Automatically fetched system hostname (used in email subject)
   - `IP_ADDRESS`: Automatically detected system IP (used in logs)
   - ` TIME_NOW`: Timestamp when the update is performed (used in logs)
   - 
3. **Permissions**
     Ensure script execution rights:  
   ```bash
   chmod +x /automated-system-updates-and-patch-notification.sh
   ```
## Usage
  Run the script manually or set as a scheduled cron job for automated log maintenance:
```bash
sudo ./automated-system-updates-and-patch-notification.sh
```
- To schedule every Sunday at 2 AM with cron:
  ```
  0 2 * * 0 /path/to/automated-system-updates-and-patch-notification.sh
  ```
## Requirements

- Bash (Tested on Bash 4+)
- apt package manager
- mailutils for sending email notifications
- dpkg for capturing package snapshots
- Sudo/root permissions for system updates  

## Example Output

user@ubuntu-pc:~$ sudo ./automated-system-updates-and-patch-notification.sh
./automated-system-updates-and-patch-notification.sh: 5: [[: not found
[INFO] Starting system update on ubuntu-pc at Tue Jul 22 06:45:50 PM IST 2025
System IP: 192.168.1.8
[INFO] Saving package list before update...
[INFO] Running apt update...
[INFO] Running apt upgrade in non-interactive mode...
[INFO] Saving package list after update...
[INFO] Comparing package lists...
./automated-system-updates-and-patch-notification.sh: 44: [[: not found
[INFO] No package changes detected.
[INFO] Update completed at Tue Jul 22 06:45:58 PM IST 2025
---------------------------------------------------

user@ubuntu-pc:~$ sudo cat /var/log/system_update.log
[INFO] Starting system update on ubuntu-pc at Tue Jul 22 06:45:50 PM IST 2025
System IP: 192.168.1.8
[INFO] Saving package list before update...
[INFO] Running apt update...

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://in.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://in.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://in.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu noble-security InRelease
Reading package lists...
Building dependency tree...
Reading state information...
1 package can be upgraded. Run 'apt list --upgradable' to see it.
[INFO] Running apt upgrade in non-interactive mode...

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
Calculating upgrade...
The following packages were automatically installed and are no longer required:
  linux-headers-6.11.0-28-generic linux-hwe-6.11-headers-6.11.0-28
  linux-hwe-6.11-tools-6.11.0-28 linux-image-6.11.0-28-generic
  linux-modules-6.11.0-28-generic linux-modules-extra-6.11.0-28-generic
  linux-tools-6.11.0-28-generic
Use 'sudo apt autoremove' to remove them.
The following upgrades have been deferred due to phasing:
  ubuntu-drivers-common
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
[INFO] Saving package list after update...
[INFO] Comparing package lists...
[INFO] No package changes detected.
[INFO] Update completed at Tue Jul 22 06:45:58 PM IST 2025
-----------------------------------
