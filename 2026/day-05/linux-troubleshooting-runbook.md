# What is a Runbook?

Think of it like a doctor's checklist.

When a patient is sick, a doctor doesn't immediately perform surgery.

They check:

Temperature
Blood pressure
Heart rate
Reports

Then they decide.

A DevOps engineer does exactly the same.

When a server is unhealthy, we check:

CPU
Memory
Disk
Network
Logs

Only then do we fix the issue.

======================================
Step 1 — Check System Information
## uname -a

ubuntu@ip-172-31-31-152:~$ uname -a
Linux ip-172-31-31-152 7.0.0-1006-aws #6-Ubuntu SMP PREEMPT Tue May 26 12:04:34 UTC 2026 x86_64 GNU/Linux
ubuntu@ip-172-31-31-152:~$
========================
## Why?

This tells you

Linux version
Kernel version
Architecture

Think of it as checking the patient's identity.

==========================
## cat /etc/os-release
ubuntu@ip-172-31-31-152:~$ cat /etc/os-release
PRETTY_NAME="Ubuntu 26.04 LTS"
NAME="Ubuntu"
VERSION_ID="26.04"

## Why?

Sometimes commands differ between Ubuntu, Amazon Linux and CentOS.

You first identify the operating system.

=============================================
# Step 2 — Filesystem Sanity Check

## mkdir /tmp/runbook-demo
## cp /etc/hosts /tmp/runbook-demo/hosts-copy
## ls -l /tmp/runbook-demo

ubuntu@ip-172-31-31-152:~$ cp /etc/hosts /tmp/runbook-demo/hosts-copy
ubuntu@ip-172-31-31-152:~$ ls -l /tmp/runbook-demo
total 4
## -rw-r--r-- 1 ubuntu ubuntu 221 Aug  3 19:27 hosts-copy ## 

## Why?

This confirms

Disk is writable
Permissions work correctly
Filesystem isn't read-only

===========================================
## Step 3 — CPU and Memory
Imagine your website is slow.

The first question is

Is the server overloaded?
## top
ubuntu@ip-172-31-31-152:~$ top
top - 19:33:30 up 41 min,  2 users,  load average: 0.00, 0.00, 0.00
Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.5 us,  0.7 sy,  0.0 ni, 98.7 id,  0.2 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    908.7 total,    171.8 free,    338.5 used,    512.8 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    570.2 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   1374 ubuntu    20   0   18724   8720   6076 S   0.3   0.9   0:01.37 sshd-session
      1 root      20   0   25476  16252  10996 S   0.0   1.7   0:03.17 systemd
## check only for nginx

## ps -o pid,pcpu,pmem,comm -p 4699

ubuntu@ip-172-31-31-152:~$ ps -o pid,pcpu,pmem,comm -p 4699
    PID %CPU %MEM COMMAND
   4699  0.0  1.0 nginx
ubuntu@ip-172-31-31-152:~$
Observation:
  Nginx is using 0.0 % CPU.
Memory usage is normal.

=====================================
## Check RAM
## free -h
ubuntu@ip-172-31-31-152:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           908Mi       334Mi       175Mi       2.7Mi       513Mi       573Mi
Swap:             0B          0B          0B

Observation:
ram uses are also fine 

==================================

## Step 4 — Disk Space
## df -h

ubuntu@ip-172-31-31-152:~$ df -h
Filesystem       Size  Used Avail Use% Mounted on
/dev/root         11G  2.3G  8.3G  22% /
tmpfs            455M     0  455M   0% /dev/shm
 Observation: 
 disk use are 20% which is healthy
IF:
Disk is 95% full.

This is dangerous.

Applications may stop writing logs.

 =============================
 ## sudo du -sh /var/log
ubuntu@ip-172-31-31-152:~$ sudo du -sh /var/log
18M     /var/log
ubuntu@ip-172-31-31-152:~$

============================
## Step 5 — Network
## ss -tulpn

ubuntu@ip-172-31-31-152:~$ ss -tulpn
Netid          State           Recv-Q          Send-Q                        Local Address:Port                   Peer Address:Port          Process
udp            UNCONN          0               0                                127.0.0.54:53                          0.0.0.0:*
udp            UNCONN          0               0                             127.0.0.53%lo:53                          0.0.0.0:*
udp            UNCONN          0               0                        172.31.31.152%ens5:68                          0.0.0.0:*
udp            UNCONN          0               0                                 127.0.0.1:323                         0.0.0.0:*
udp            UNCONN          0               0                                     [::1]:323                            [::]:*
tcp            LISTEN          0               4096                          127.0.0.53%lo:53                          0.0.0.0:*
tcp            LISTEN          0               4096                                0.0.0.0:22                          0.0.0.0:*
tcp            LISTEN          0               511                                 0.0.0.0:80                          0.0.0.0:*
tcp            LISTEN          0               128                               127.0.0.1:6010                        0.0.0.0:*
tcp            LISTEN          0               4096                             127.0.0.54:53                          0.0.0.0:*
tcp            LISTEN          0               4096                                   [::]:22                             [::]:*
tcp            LISTEN          0               128                                   [::1]:6010                           [::]:*
tcp            LISTEN          0  
Meaning

Nginx is listening on port 80.

===========================
## Step 6 — Logs
Logs tell the real story.

Check service logs.
 ## journalctl -u nginx -n 50
 
ubuntu@ip-172-31-31-152:~$ journalctl -u nginx -n 50
Aug 03 19:18:58 ip-172-31-31-152 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Aug 03 19:18:58 ip-172-31-31-152 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.

===================================
## Quick Findings Example
✔ Ubuntu server healthy

✔ CPU usage normal

✔ Memory usage acceptable

✔ Disk usage 68%

✔ Nginx running

✔ Port 80 listening

✔ Website returns HTTP 200

✔ No critical errors in logs

=====================================
## Conclusion
No immediate issue found.

Website appears healthy.

Continue monitoring.

=================================
## If This Worsens

Imagine users still complain.

Now your runbook says

Step 1

## Restart service
Why?

Sometimes restarting clears temporary issues like hung worker processes.

-------------------------------------------
Step 2

Increase logging

Why?

If current logs don't explain the issue, enable more detailed logging to capture additional information.

--------------------------------------------
Step 3

Collect detailed process information
## strace -p <PID>

Why?

strace shows what system calls a process is making, which can help identify if it's stuck waiting on files, network, or other resources.

----------------------------------------
