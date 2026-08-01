# Process checks
* ps -ef | head

## Sample Output
ubuntu@ip-172-31-23-121:~$ ps -ef |head
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 11:42 ?        00:00:02 /sbin/init
root           2       0  0 11:42 ?        00:00:00 [kthreadd]
root           3       2  0 11:42 ?        00:00:00 [pool_workqueue_release]
root           4       2  0 11:42 ?        00:00:00 [kworker/R-rcu_gp]
root           5       2  0 11:42 ?        00:00:00 [kworker/R-sync_wq]
root           6       2  0 11:42 ?        00:00:00 [kworker/R-kvfree_rcu_reclaim]
root           7       2  0 11:42 ?        00:00:00 [kworker/R-slub_flushwq]
root           8       2  0 11:42 ?        00:00:00 [kworker/R-netns]
root          10       2  0 11:42 ?        00:00:00 [kworker/0:0H-kblockd]
ubuntu@ip-172-31-23-121:~$
## Observation

* Displayed all running processes.
* Verified that the Nginx master and worker processes are running.
=================================
  [] pgrep nginx

  ## Sample Output
  ubuntu@ip-172-31-23-121:~$ pgrep nginx
9968
9969
9970
## Observation
* Quickly located the Process IDs (PIDs) for the Nginx service.
==================================
## Service checks
[] systemctl status nginx

  ## Sample Output
  ubuntu@ip-172-31-23-121:~$ systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sat 2026-08-01 12:14:15 UTC; 11min ago
 Invocation: aa36eb3bf2d147ea876b37902e915afa

## Observation
* Confirmed that the Nginx service is active and running.
==========================================
[] systemctl list-units --type=service --state=running
  ## Sample Output
  
ubuntu@ip-172-31-23-121:~$ systemctl list-units --type=service --state=running
  UNIT                                           LOAD   ACTIVE SUB     DESCRIPTION
  acpid.service                                  loaded active running ACPI event daemon
  chrony.service                                 loaded active running chrony, an NTP client/server
  cron.service                                   loaded active running Regular background program processing daemon
  dbus.service                                   loaded active running D-Bus System Message Bus
  getty@tty1.service                             loaded active running Getty on tty1
  irqbalance.service                             loaded active running irqbalance daemon
  ModemManager.service                           loaded active running Modem Manager
  multipathd.service                             loaded active running Device-Mapper Multipath Device Controller
  networkd-dispatcher.service                    loaded active running Dispatcher daemon for systemd-networkd
  nginx.service                                  loaded active running A high performance web server and a reverse proxy server
  polkit.service                                 loaded active running Authorization Manager
  rsyslog.service                                loaded active running System Logging Service
  serial-getty@ttyS0.service                     loaded active running Serial Getty on ttyS0
  snap.amazon-ssm-agent.amazon-ssm-agent.service loaded active running Service for snap application amazon-ssm-agent.amazon-ssm-agent
  snapd.service                                  loaded active running Snap Daemon
  ssh.service                                    loaded active running OpenBSD Secure Shell server
  systemd-journald.service                       loaded active running Journal Service
  systemd-logind.service                         loaded active running User Login Management
  systemd-networkd.service                       loaded active running Network Management
  systemd-resolved.service                       loaded active running Network Name Resolution
  systemd-udevd.service                          loaded active running Rule-based Manager for Device Events and Files
  udisks2.service                                loaded active running Disk Manager
  unattended-upgrades.service                    loaded active running Unattended Upgrades Shutdown
  user@1000.service                              loaded active running User Manager for UID 1000

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

24 loaded units listed.
## Observation
Listed all currently running services managed by systemd.
=========================================
## Log checks
[] journalctl -u nginx --no-pager | tail -10
  ## Sample Output
ubuntu@ip-172-31-23-121:~$ journalctl -u nginx --no-pager | tail -10
Aug 01 11:56:17 ip-172-31-23-121 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Aug 01 11:56:17 ip-172-31-23-121 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
Aug 01 12:13:17 ip-172-31-23-121 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Aug 01 12:13:17 ip-172-31-23-121 systemd[1]: nginx.service: Deactivated successfully.
Aug 01 12:13:17 ip-172-31-23-121 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
Aug 01 12:14:15 ip-172-31-23-121 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Aug 01 12:14:15 ip-172-31-23-121 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
ubuntu@ip-172-31-23-121:~$

## Observation
Reviewed recent logs related to the Nginx service.
Confirmed the service started successfully without errors.

## explanation for above command 
* journalctl - Journalctl is a command used to view system logs on Linux.
Imagine it as a system diary where Linux records everything that happens, such as:

- Services starting and stopping
* Errors
* Warnings
* Login attempts
* System events
=====
* -u nginx - The -u option stands for unit, which refers to a systemd service.
- means:

"Show me only the logs related to the nginx service."

Instead of seeing logs for every service, you only see Nginx logs.
============
* --no-pager
- tells Linux:

"Print everything directly to the terminal. Don't open the pager."

This is especially useful when combining commands with | (pipes).
============
* (Pipe) (|)

The pipe symbol (|) sends the output of one command to another command.
The logs from journalctl become the input for tail.
===============
* tail -10
- means:

"Show only the last 10 lines."

================================
## Simple Troubleshooting Flow
 --Scenario

* Verify whether the Nginx web server is running properly.
1. Check if the process exists.
   pgrep nginx

2. Verify service status.
   systemctl status nginx

3. Review service logs.
   journalctl -u nginx

4. Check access logs.
   tail -n 20 /var/log/nginx/access.log

5. If the service is inactive:
   sudo systemctl restart nginx

6. Verify the service again.
   systemctl status nginx
   
   ===================================
   
