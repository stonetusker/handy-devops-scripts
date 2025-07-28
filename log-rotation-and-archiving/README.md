# Log Rotation and Archiving Script
> Automate log management to save disk space and preserve valuable history-ideal for DevOps environments seeking reliable, hands-free log cleanup.

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

This Bash script automatically archives and compresses log files in a target directory based on file size or age. By adopting this tool, organizations can prevent disk overuse and maintain historic logs for audits or troubleshooting, all with just a few lines of code.

## How It Works

- Scans a specified directory for `.log` files.
- Compresses and moves logs larger than a defined maximum size or older than a defined maximum number of days to an archive folder.
- Ensures your log directory is always clean, manageable, and retains essential history.

## Setup & Configuration

1. **Clone the repository or download the script.**
2. **Modify script parameters as needed:**  
   - `log_dir`: Path where logs are stored (default `/var/log/script_log`)
   - `archive_dir`: Destination for archived logs (default `/var/log/script_log/archive`)
   - `max_size_mb`: Compress logs over this size in MB (default `10`)
   - `max_age_days`: Compress logs older than these days (default `7`)

3. **Permissions:**  
   Ensure script execution rights:  
   ```bash
   chmod +x log-rotation-and-archiving.sh
   ```


## Usage

Run the script manually or set as a scheduled cron job for automated log maintenance:
```bash
./log-rotation-and-archiving.sh
```

- To schedule daily at midnight with cron:
  ```
  0 0 * * * /path/to/log-rotation-and-archiving.sh
  ```

## Requirements

- Bash (Tested on Bash 4+)
- `gzip` utility
- User must have read/write permissions on the log and archive directories

## Example Output

```
===========================================
Starting Log Rotation and Archiving Script
Log Directory     : /var/log/script_log
Archive Directory : /var/log/script_log/archive
Max Size (MB)     : 10
Max Age (Days)    : 7
===========================================
Checking for logs larger than 10 MB...
Compressing large log: /var/log/script_log/app.log
Checking for logs older than 7 days...
Compressing old log: /var/log/script_log/old_app.log
===========================================
Log Rotation and Archiving Complete.
Compressed logs moved to: /var/log/script_log/archive
===========================================
```

## Troubleshooting

- **No logs are compressed:**  
  Verify log directory path and file permissions.
- **Script fails with permissions errors:**  
  Run with elevated privileges or adjust `log_dir` and `archive_dir` permissions as appropriate.
- **Not finding expected logs:**  
  Ensure log files have a `.log` extension and the script user can access them.

## License

[MIT License](LICENSE)


