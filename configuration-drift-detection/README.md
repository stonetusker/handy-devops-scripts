#  Configuration Drift Detection Script
> Automatically detect unauthorized or accidental changes in system configuration files.

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

This Bash script helps detect **configuration drift** by monitoring critical system files (e.g., `/etc/passwd`, `/etc/ssh/sshd_config`).  
It compares the current file hashes with a stored baseline and alerts when any file is changed, missing, or tampered with.  

## How It Works

- On the **first run**, a baseline file of SHA-256 checksums is created.
- On subsequent runs:
  - The script recalculates hashes for the monitored config files.
  - Compares current hashes to the saved baseline.
  - Reports any differences as drift.

## Setup & Configuration

1.**Clone the repository or download the script.**

2. **Edit the script to customize the config files to monitor:**

   In the `CONFIG_FILES` array:
   ```bash
   CONFIG_FILES=(
     "/etc/ssh/sshd_config"
     "/etc/passwd"
     "/etc/group"
     "/etc/fstab"
   )

3. **Permissions:**
 Ensure script execution rights:  
   ```bash
   chmod +x configuration-drift-detection.sh
   ```

4. **Baseline File Location:**
Default: /var/tmp/config_hash_baseline.txt

## Usage
Run the Script:
```bash
./configuration-drift-detection.sh
```

- To schedule daily at 2 AM with cron
```
0 2 * * * /path/to/configuration-drift-detection.sh
```

## Requirements

- Bash (Tested on Bash 4+)
- Utilities: sha256sum, diff
- Sufficient permissions to read the configuration files being monitored.

## Example Output
```
for the first-time setup:
========================================

user@ubuntu-pc:~$ ./configuration-drift-detection.sh
[INFO] Baseline file not found. Creating baseline...
Baseline created at /var/tmp/config_hash_baseline.txt

========================================
Run the script again without making changesx
=========================================

user@ubuntu-pc:~$ ./configuration-drift-detection.sh
=== Configuration Drift Report (2025-07-21 23:31:13) on ubuntu-pc ===
[OK] No changes detected in monitored config files.
===========================================

Simulate a change to test drift detection:
============================================
user@ubuntu-pc:~$ sudo sh -c 'echo "# test drift" >> /etc/ssh/sshd_config'
[sudo] password for user:
user@ubuntu-pc:~$ ./configuration-drift-detection.sh
=== Configuration Drift Report (2025-07-21 23:33:27) on ubuntu-pc ===
[ALERT] Configuration drift detected!
1c1
< 97f9c064a8236300b011693cbd74c47de796db3ca3b8f2cf6eed7d563dfad0bf  /etc/ssh/sshd_config
---
> 685e5e3d1f2b3bb9c92224252794d3547e83c76ee87b17c78f09f06e5bfd5f93  /etc/ssh/sshd_config
==============================================
This confirms the script is correctly detecting changes.
```
## Troubleshooting

- **Baseline file not found:**
This is expected on first run. The script creates it automatically.

- **Script reports files as missing:**
Verify all monitored files exist. Remove or update entries in CONFIG_FILES.

- **No changes detected despite edits:**
Ensure the file was actually saved and edited. Comments or whitespace may not always result in hash change.


## License

[MIT License](LICENSE)


