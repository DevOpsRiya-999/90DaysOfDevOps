# 🚀 Day 19 – Shell Scripting Project
1️⃣ Log Rotation Script
Key concepts
$1 → first command-line argument
-d → checks whether directory exists
-f → checks whether file exists
-mtime +7 → modified more than 7 days ago
gzip → compresses files
find → searches files/directories
-delete → deletes matching files
exit 1 → exits with an error

======================================
2️⃣ Server Backup Script
Purpose

Create a compressed backup of important application/server data.

Basic command:

tar -czf backup.tar.gz /source/directory
tar options
-c → create archive
-z → gzip compression
-f → specify filename

Example:

tar -czf backup-2026-09-14.tar.gz /home/ubuntu/app
Timestamp
date +%Y-%m-%d

Output:

2026-09-14

You can create:

backup-$(date +%Y-%m-%d).tar.gz
Check archive
ls -lh backup-*.tar.gz

-h makes the file size human-readable.

Example:

-rw-r--r-- 1 ubuntu ubuntu 25M backup-2026-09-14.tar.gz
Delete old backups
find /backup -name "*.tar.gz" -mtime +14 -delete

This automatically removes backups older than 14 days.

============================
## 🧠 Cron Syntax
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week
│ │ │ └──── Month
│ │ └────── Day of month
│ └──────── Hour
└────────── Minute

## Range
Minute       0-59
Hour         0-23
Day          1-31
Month        1-12
Day of week  0-7
====================================
| Command      | Purpose                           |
| ------------ | --------------------------------- |
| `find`       | Find files/directories            |
| `gzip`       | Compress files                    |
| `tar`        | Create archives                   |
| `date`       | Generate timestamps               |
| `crontab -l` | List cron jobs                    |
| `crontab -e` | Edit cron jobs                    |
| `chmod +x`   | Make script executable            |
| `exit 1`     | Exit with error                   |
| `>>`         | Append output                     |
| `2>&1`       | Redirect errors                   |
| `ls -lh`     | Show readable file sizes          |
| `-mtime`     | Search based on modification time |

==============================================
🎯 Interview Questions From Day 19
1. What is log rotation?

Log rotation is the process of compressing, archiving and deleting old logs to prevent disk space problems.

2. What does mtime +7 mean?
-mtime +7

Finds files modified more than 7 days ago.

3. Difference between gzip and tar?

gzip compresses files.

tar creates an archive containing multiple files/directories. With -z, tar uses gzip compression.

tar -czf backup.tar.gz /data
4. What is cron?

Cron is a Linux scheduler used to execute commands/scripts automatically at specified times.

5. How do you check existing cron jobs?
crontab -l
6. How do you edit cron jobs?
crontab -e
7. How do you run a script every 5 minutes?
*/5 * * * * /path/script.sh
8. Why use exit 1?

It indicates that the script terminated because of an error.

9. What does 2>&1 do?

It redirects stderr (errors) to stdout, allowing both to be logged together.

10. Why are backups deleted after 14 days?

To implement retention, preventing unlimited backup growth and unnecessary disk usage.

==============================
## 🧠 Day 19 Quick Revision

LOG ROTATION
     │
     ├── Find old .log
     ├── gzip
     ├── Delete old .gz
     └── Count files
     
BACKUP
     │
     ├── Validate source
     ├── tar + gzip
     ├── Timestamp
     ├── Verify archive
     ├── Show size
     └── Delete backups >14 days

CRON
     │
     ├── crontab -l
     ├── crontab -e
     ├── Schedule scripts
     └── Automate tasks

MAINTENANCE
     │
     ├── Log rotation
     ├── Backup
     ├── Health check
     └── Central maintenance log
