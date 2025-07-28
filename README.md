## Useful DevOps Shell Scripts 

### 1. **Automated Server Health Check and Report**
- Collects CPU, memory, disk, and network stats.
- Summarizes results in a file or sends as email.
- Conditional alerts for high resource usage.

### 2. **Backup and Remote Transfer Automation**
- Archives a directory, names backups by timestamp.
- Securely transfers to a remote host with `scp` or `rsync`.
- Optional logging and error notification.

### 3. **Configuration Drift Detection**
- Monitors hashes/checksums of critical config files.
- Compares against a baseline and alerts if files change.
- Helps enforce compliance and catch unauthorized edits.

### 4. **Log Rotation and Archiving**
- Compresses and archives log files over a certain size or age.
- Prevents disk bloat and preserves log history.

### 5. **SSL Certificate Expiry Checker**
- Scans domains for SSL cert expiry.
- Sends alerts for certificates near expiration.

### 6. **Automated System Updates and Patch Notification**
- Runs package updates/upgrades.
- Logs changed packages and emails a summary to admins.

### 7. **Disk Usage Monitoring and Alert**
- Checks free space on all mounts.
- Sends alerts when usage crosses a threshold.
- Outputs a structured report.

### 8. **Automated Cron Job Audit**
- Parses system/user cron definitions.
- Detects new, removed, or modified jobs as compared to a baseline.
- Sends changes in an alert.

### 9. **Process Count Monitoring with Automated Action**
- Counts running processes matching a pattern.
- Logs status and optionally restarts or alerts if count crosses a set threshold.

### 10. **Failed SSH Login Detection**
- Parses auth logs for failed SSH attempt patterns.
- Tallies per-IP counts and alerts on suspected brute-force attacks.


### 11. **Container Status & Health Summary**
- Lists all running Docker (or Podman) containers with health status, resource usage, and exposed ports.
- Optionally sends a daily summary email to admins.

### 12. **Automated Firewall Rule Audit**
- Checks active firewall rules (iptables/firewalld/ufw).
- Compares against an approved baseline and sends alerts if there’s a drift or unexpected change.

### 13. **Orphaned Files Cleanup in Shared Storage**
- Scans shared directories for orphaned or stale files by owner or modification time.
- Optionally archives or deletes them and generates a detailed log.

### 14. **Kubernetes Pod Crash Loop Detector**
- Queries cluster pods, identifies those in crash loop backoff or repeated restart state.
- Summarizes affected services and notifies the support channel.

### 15. **User Account Expiry & Lock Auditor**
- Finds user accounts set to expire, already expired, or locked.
- Sends periodic compliance reports for privileged or sensitive systems.

### 16. **Automated Database Backup and Verify**
- Dumps a MySQL/Postgres DB to disk with timestamped archive.
- Runs a test restore to a temp DB and logs the result for backup validation.

### 17. **Dynamic Inventory Generator for Ansible**
- Scans subnets or reads from a CMDB to produce a live Ansible inventory.
- Outputs in YAML/JSON format, grouping hosts by OS, environment, or application.

### 18. **Application Log Error Trending**
- Parses application logs for errors/warnings.
- Produces a time series summary (errors per hour/day) and sparkline/graph-ready output.

### 19. **Service Port Check Across Hosts**
- Uses a host list to check if specific services/ports are open/accessible.
- Reports connectivity issues or changes.

### 20. **Automated Security Patch Compliance Report**
- Checks installed/available security patches on one or more systems.
- Flags outdated packages or missing CVE fixes and sends a compliance summary.

### 21. **Dynamic Environment Variable Sync**
- Automates syncing environment variable files across multiple servers or containers.
- Validates presence of required variables and flags missing or extra entries.

### 22. **API Health Endpoint Monitor**
- Periodically checks application/API health endpoints.
- Records status codes and response times; sends alerts on failures or slowdowns.

### 23. **Automated Certificate Renewal & Deployment**
- Checks certificate expiration.
- Pulls new certificates (from Let’s Encrypt, Vault, etc.) and rolls them out to web servers or load balancers automatically.

### 24. **Cloud Resource Usage Snapshot**
- Captures and reports current cloud resource states (instances, volumes, buckets) for AWS, Azure, or GCP via CLI/API.
- Compares with previous snapshots to detect unexpected resources or cost spikes.

### 25. **Automated Log Forwarding Setup**
- Configures log forwarding agents (e.g., syslog, Filebeat) across a fleet.
- Verifies connectivity to log aggregation endpoints and reports setup status.

### 26. **Network Latency and Packet Loss Benchmark**
- Runs ICMP/TCP pings to key endpoints.
- Collects latency, loss metrics, and trends them over time for SLA verification.

### 27. **Stale Git Branch Cleaner**
- Scans remote Git repos for branches not updated in a given period.
- Summarizes candidates for cleanup and can optionally auto-delete with confirmation.

### 28. **Docker Image Vulnerability Scanner**
- Lists locally available Docker images.
- Runs vulnerability scans (using tools like Trivy or Clair) and summarizes findings.

### 29. **File Integrity Watcher**
- Monitors sensitive directories (e.g., web root, config) for file changes using `inotify`.
- Sends immediate alerts on modification, creation, or deletion events.

### 30. **Automated Dependency Version Checker**
- Parses application dependency files (e.g., `requirements.txt`, `package.json`).
- Compares installed versions with latest available; flags or automatically schedules updates.

### 31. **Automated DNS Record Checker**
- Queries DNS records for a list of domains.
- Alerts on missing, incorrect, or TTL issues.
- Useful for domain migration or DNS management.

### 32. **Load Balancer Health Status Reporter**
- Checks the health of backend servers behind a load balancer (e.g., NGINX, HAProxy).
- Reports unhealthy nodes and optionally triggers remediation.

### 33. **Automated OS Image Builder**
- Scripts the creation of custom OS images (e.g., Packer, cloud-init).
- Validates image integrity and uploads to cloud/on-prem repositories.

### 34. **Centralized Configuration Sync**
- Distributes configuration files (e.g., `/etc/hosts`, application configs) to a fleet of servers.
- Verifies sync status and logs discrepancies.

### 35. **Automated Security Group/IP Whitelist Updater**
- Dynamically updates firewall rules or security groups based on a trusted IP list (e.g., office, VPN).
- Removes stale entries and logs changes.

### 36. **Automated Jira/Ticket Status Reporter**
- Queries Jira, GitHub Issues, or similar for open tickets assigned to your team.
- Sends a daily/weekly summary email with status and aging.

### 37. **Disk I/O Performance Benchmark**
- Runs `fio` or `dd` tests across disks.
- Collects and trends read/write speeds, latency—useful for capacity planning.

### 38. **Automated User Session Audit**
- Lists active user sessions (SSH, GUI) across servers.
- Flags idle or long-running sessions for review or termination.

### 39. **Automated Let’s Encrypt Certificate Renewal and Deployment**
- Checks certificate expiry, renews via certbot, and deploys to web servers/load balancers.
- Logs success/failure and notifies on issues.

### 40. **Automated Cloud Cost Anomaly Detector**
- Queries cloud provider billing APIs (AWS Cost Explorer, GCP Billing, etc.).
- Alerts on unexpected cost spikes or budget threshold breaches.

### 41. **Zombie Process Hunter & Cleaner**
- Scans the system for zombie (defunct) processes.
- Logs findings and optionally kills them to reclaim system resources.
- Useful for keeping servers healthy, especially after long uptimes[.

### 42. **Top-N File Size Auditor**
- Finds the largest N files (e.g., top 10) in a directory or filesystem.
- Generates a size-sorted report for storage optimization.
- Helps identify culprits in out-of-space scenarios.

### 43. **Automated Graceful Disk Unmounter**
- Checks if a mount point is busy, notifies users/processes, and safely unmounts it.
- Prevents abrupt data loss by enforcing proper disk detachment.

### 44. **File Age & Size Tracker**
- Lists files created or modified in a specified time window or above a certain size.
- Automates reporting of stale or oversized files.
- Invaluable for compliance and cleanup tasks.

### 45. **New User Onboarding (with SSH Setup)**
- Automates creation of Linux user accounts.
- Sets permissions, home directories, default shells, and SSH key access.
- Ensures standards and reduces manual error in account provisioning.

### 46. **Recursive Secure File Copy to Remote Hosts**
- Copies files or directories recursively to one or multiple remote servers via SCP or rsync.
- Can be used for multi-server deployments or distributing configs/assets.

### 47. **URL Uptime & Status Checker**
- Checks the HTTP status or content of a list of URLs.
- Sends alerts or logs if any application/service is down.
- Suitable for site, API, or microservice monitoring.

### 48. **Automated Security Patch Installer**
- Updates system packages, focusing on applying only security patches.
- Sends an alert or summary email after updates.
- Promotes regular security compliance without manual intervention.

### 49. **Failed Login Reporter (with GeoIP)**
- Parses logs for failed authentication attempts.
- Summarizes attempts by IP address, attempts geolocation, and notifies on suspicious activity.
- Useful for strengthening infrastructure security and auditing breaches.

### 50. **Database Backup & Rotation**
- Automates database dumps (MySQL/Postgres/others), naming with a timestamp.
- Rotates/deletes the oldest backups after exceeding N copies or days.
- Protects data while managing limited backup storage.
