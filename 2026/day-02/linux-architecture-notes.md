
## Day 02 – Linux Architecture, Processes, and systemd
[x]Task
Today’s goal is to understand how Linux works under the hood.

You will create a short note that explains:


# The core components of Linux (kernel, user space, init/systemd)

User
  │
  ▼
User Space
(Applications & Commands)
  │
  ▼
Kernel
(Manages the System)
  │
  ▼
Hardware

systemd
   │
   ├── Starts Linux
   ├── Starts Services
   └── Keeps Everything Running


Kernel =The core of Linux. It manages hardware, memory, CPU, files, and processes.
User Space =	Where users and applications run. Programs communicate with the kernel using system calls.
init/systemd	= The first process that starts after the kernel boots. It starts and manages system services, making the system ready for users.


# Linux Architecture


                  Linux Architecture

                     +----------------------+
                     |        User          |
                     +----------------------+
                               │
                               ▼
                     +----------------------+
                     |      User Space      |
                     |----------------------|
                     | • Applications       |
                     | • Shell (Bash)       |
                     | • Utilities          |
                     +----------------------+
                               │
                        System Calls
                               │
                               ▼
                     +----------------------+
                     |        Kernel        |
                     |----------------------|
                     | • Process Management |
                     | • Memory Management  |
                     | • File System        |
                     | • Device Drivers     |
                     | • Network Management |
                     +----------------------+
                               │
                               ▼
                     +----------------------+
                     |      Hardware        |
                     |----------------------|
                     | CPU • RAM • Disk     |
                     | Keyboard • Network   |
                     | USB Devices          |
  
                     +---------------------
# Linux Boot Process
 Power ON
            │
            ▼
      Bootloader (GRUB)[Bios]
            │
            ▼
     Linux Kernel Starts
            │
            ▼
      systemd (PID = 1)
            │
            ▼
 Starts Essential Services
(Network, SSH, Docker, etc.)
            │
            ▼
       Login Screen/Terminal
            │
            ▼
            User
# What systemd Does
             systemd (PID 1)
                        │
      ┌─────────────────┼──────────────────┐
      │                 │                  │
      ▼                 ▼                  ▼
 Starts Services   Monitors Services   Collects Logs
 (SSH, Docker,     Restarts Failed      (journalctl)
 Apache, etc.)     Services
      │
      ▼
 Makes Linux Ready for Users

 # Linux Process States
 Running (R): The process is currently using the CPU or is ready to run.
* Sleeping (S): The process is waiting for an event, such as user input or a file to become available.
* Stopped (T): The process has been paused and can be resumed later.
*Zombie (Z): The process has finished, but its entry still exists until its parent process removes it.
* Uninterruptible Sleep (D): The process is waiting for hardware operations (like disk I/O) and cannot be interrupted.
# Linux Commands I Would Use Daily
* pwd – Shows the current working directory.
* ls – Lists files and folders in a directory.
* cd – Changes from one directory to another.
* ps – Displays the running processes on the system.
* top – Shows live system performance, including CPU, memory, and running processes.
* sudo - super root user do 
*s udo apt-get update- use for downloaded packages
* sudo apt-get upgrade - use for install all packages
* grep-
* sudo apt update -
* systemctl reboot-
* uname-
* ping-
* rm -rf -



