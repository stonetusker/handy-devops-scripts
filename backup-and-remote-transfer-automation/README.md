# Backup and Remote Transfer Automation Script
> Performs automated backups of a specified folder, names them with timestamps, and transfers them securely to a remote destination. Includes logging and optional failure alerts.

## Table of COntents
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
This Bash script simplifies and automates the process of backing up important data from a local directory, compressing it into timestamped .tar.gz archives, and transferring the archive securely to a remote machine. 

## How It Works
- Creates a timestamped .tar.gz archive of the specified source directory.
- Saves the archive locally to a backup folder.
- Ensures the target directory exists on the remote server.
- Transfers the archive securely using rsync over SSH.
- Logs each step (successes and failures) to a local log file.

## Setup & Configuration
1. **Clone the repository or download the script.**
~/backup-and-remote-transfer-automation.sh

2.** Modify Configurable Variables in Script.**

SOURCE_DIR="$HOME/mydata"                  # Directory to back up (must exist)
BACKUP_DIR="$HOME/local_backups"           # Local storage location
REMOTE_USER="user"                         # SSH username of remote machine
REMOTE_HOST="192.168.1.8"                  # IP or hostname of remote machine
REMOTE_DIR="/home/user/remote_backups"     # Target directory on remote host
LOG_FILE="$HOME/backup_transfer.log"       # Local log file
EMAIL="user@ubuntu-pc"                     # Optional email for alert

3.** Permissions:**
 Ensure script execution rights:  
   ```bash
chmod +x ~/backup-remote-transfer-automation.sh
 ```
## Usage
Run the script manually or set as a scheduled cron job for automated log maintenance:
./backup-and-remote-transfer-automation.sh

- To schedule every day at 10 PM:
 ```
0 22 * * * /home/user/backup-remote-transfer-automation.sh
 ```
## Requirements

- Linux system with Bash (Tested on Bash 4+)
- tar, rsync, and ssh utilities installed
- Passwordless SSH setup recommended
- Ensure the SOURCE_DIR exists before running the script
- User must have read/write permissions for both local and remote backup directories

## Example Output

```
==============================================================

user@ubuntu-pc:~$ > ~/backup_transfer.log
user@ubuntu-pc:~$ ./backup-and-remote-transfer-automation.sh
user@192.168.1.8's password:
user@192.168.1.8's password:
user@ubuntu-pc:~$ cat ~/backup_transfer.log
[Mon Jul 21 08:58:13 PM IST 2025] Script started.
[Mon Jul 21 08:58:13 PM IST 2025] Creating backup: /home/user/local_backups/backup_20250721_205813.tar.gz
tar: Removing leading `/' from member names
[Mon Jul 21 08:58:13 PM IST 2025] Checking/creating remote directory /home/user/remote_backups
[Mon Jul 21 08:58:18 PM IST 2025] Transferring backup to 192.168.1.8:/home/user/remote_backups
sending incremental file list
backup_20250721_205813.tar.gz

sent 335 bytes  received 35 bytes  82.22 bytes/sec
total size is 209  speedup is 0.56
[Mon Jul 21 08:58:22 PM IST 2025] Backup successfully transferred.
[Mon Jul 21 08:58:22 PM IST 2025] Script completed successfully.

==============================================================  

```
![backup remote](https://github.com/user-attachments/assets/4251c296-e533-4b44-976f-d00a45c1f2fc)

## Troubleshooting

- ** Backup fails with tar error: **
Verify that the SOURCE_DIR exists and the user has read permissions.
- ** Rsync or SSH errors: **
Check if REMOTE_HOST is reachable. Use an IP address instead of hostname if DNS resolution fails.
- ** Permission denied errors:**
Ensure the script is executable and the user has write permissions to both local and remote backup directories.
- ** Script doesn't run via cron: **
Use absolute paths for all variables and commands in cron job. Avoid relying on environment variables.

## License

[MIT License](LICENSE)



