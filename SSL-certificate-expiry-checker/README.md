# SSL Certificate Expiry Checker Script  
> Automate SSL certificate monitoring for multiple domains and receive timely email alerts before expiry.

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
---
## Overview

This Bash script checks the SSL certificate expiry dates for a list of domains and sends an alert via email if any certificate is due to expire within a configurable number of days. It logs the results for auditing or debugging purposes.

## How It Works

- Loops through a list of domains.
- Fetches the SSL certificate using `openssl s_client`.
- Extracts and parses the certificate's expiration date.
- Compares it with the current date.
- Logs the status as one of: `EXPIRED`, `EXPIRING in X days`, or `Valid`.
- Sends an email alert if any certificate is expiring soon.

## Setup & Configuration

1. **Clone the repository or download the script.**
2. **Edit the following script parameters as required:**
   - `DOMAINS`: An array of domain names to check.
   - `THRESHOLD_DAYS`: Number of days before expiry to trigger an alert (default: `30`).
   - `ALERT_EMAIL`: The local user or email to receive alerts.
   - `LOG_FILE`: Path to store the certificate expiry report (default: `$HOME/ssl_expiry.log`).

3. **Set execute permissions:**
   ```bash
   chmod +x ssl-certificate-expiry-check.sh
   ```

## Usage

Run the script:

```bash
./ssl-certificate-expiry-check.sh
```
- To schedule daily at 8 AM with cron:

0 8 * * * /home/user/SSL-certificate-expiry-checker.sh

## Requirements

- Bash (Tested on Bash 4+)
- `openssl` utility
- `mail` command (for sending email alerts)
- Internet access to connect to the domains on port 443

## Example Output

Check the Output Log

==========================================
user@ubuntu-pc:~$ ./SSL-certificate-expiry-checker.sh
user@ubuntu-pc:~$ cat ~/ssl_expiry.log
=== SSL Certificate Expiry Report - Tue Jul 22 12:18:22 AM IST 2025 ===
example.com: Valid (178 days left) (Expires on: Jan 15 23:59:59 2026 GMT)
google.com: Valid (55 days left) (Expires on: Sep 15 08:40:22 2025 GMT)

user@ubuntu-pc:~$ ls -l SSL-certificate-expiry-checker.sh
-rwxrwxr-x 1 user user 1344 Jul 22 00:18 SSL-certificate-expiry-checker.sh
==========================================

This confirms:
Domain is reachable,Certificate is fetched,Expiry date is parsed correctly,& Days remaining is calculated.
and the Script is Executable


## Troubleshooting

- **"Unable to retrieve SSL certificate" message:**  
  Domain might not be accessible, use a different network or verify the domain.
- **No email alerts are received:**  
  Ensure the `mail` command is installed and configured properly.
- **Script exits silently:**  
  Run with `bash -x` for debug output.
- **Timezone differences:**  
  Be aware of GMT vs your local system timezone when checking expiry dates.

## License

[MIT License](LICENSE)






