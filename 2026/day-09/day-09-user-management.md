# Task 1: Create Users
Create three users with home directories and passwords:

tokyo
berlin
professor

## command 
// sudo useradd -m tokyo //

sudo-super user do
useradd- add user 
-m  - Creates a home directory for the user.
<img width="585" height="275" alt="image" src="https://github.com/user-attachments/assets/251dd2da-7ba1-4d57-aef5-21b5cc0760ec" />

## 2. Set Passwords
## command 
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor

-----------------------
New password:
Retype new password:
When typing the password, nothing will appear on the screen. That's normal.

===============================
## 3. Create Groups

Now we create two teams:
developers
admins
## commands
sudo groupadd developers
sudo groupadd admins
## 4. Verify Groups
Command
// grep -E 'developers|admins' /etc/group //

<img width="637" height="132" alt="image" src="https://github.com/user-attachments/assets/ca1995de-1b9e-4d9e-8f6a-69ea6837b55d" />

============================================
## 6. Assign Users to Groups
Now we decide who belongs to which team.
tokyo     → developers
berlin    → developers + admins
professor → admins
// sudo usermod -aG developers tokyo //

## ⭐ Important: Understand -aG
Break it down:
usermod       → modify user
-a            → append
-G developers → add to developers group
tokyo         → username

The -a means:

Add this group without removing existing supplementary groups.
==================================

## 7. Change Group Owner
We want the developers group to own this directory.
// sudo chgrp developers /opt/dev-project//
ls -ld /opt/dev-project
Output: drwxr-xr-x 2 root developers 4096 Aug 9 21:00 /opt/dev-project
<img width="835" height="170" alt="image" src="https://github.com/user-attachments/assets/bfbe65ec-e392-4f34-a485-654f6bf90744" />
The owner is: root
The group is: developers

## 10. Set Permissions to 775
command 
// sudo chmod 775 /opt/dev-project // 
chmod- change mode 
<img width="828" height="161" alt="image" src="https://github.com/user-attachments/assets/45f095b5-7829-4e0c-98ab-5d6f1fffb5e8" />

==============================
## 11. Test as Tokyo
We want to test whether Tokyo can create files.
command: 
sudo -u tokyo touch /opt/dev-project/tokyo-file.txt

<img width="957" height="147" alt="image" src="https://github.com/user-attachments/assets/9ccf71fe-7a07-433d-8cd4-0d88d8d2afa7" />

=====================================

🧠 The Complete Picture
                    LINUX SERVER
                         |
          +--------------+--------------+
          |                             |
       USERS                         GROUPS
          |                             |
   +------+------+             +--------+---------+
   |      |      |             |        |         |
 tokyo  berlin professor   developers admins project-team
   |      |      |             |        |         |
   |      |      |             |        |         |
   |      +------+-------------+--------+         |
   |                                             |
   +---------------------------------------------+
  ## More simply:
   tokyo
 ├── developers
 └── project-team

berlin
 ├── developers
 └── admins

professor
 └── admins

nairobi
 └── project-team

## Directories:
/opt/dev-project
       |
       └── developers
              |
          tokyo + berlin


/opt/team-workspace
       |
       └── project-team
              |
          tokyo + nairobi
          nairobi
📋 All Commands Together

You can use this as your Day 09 practical command sheet:
<img width="681" height="1005" alt="image" src="https://github.com/user-attachments/assets/71157e39-6836-4506-8a56-2a1cde5a9355" />

## What I Learned
Create User
     ↓
Create Group
     ↓
Add User to Group
     ↓
Create Directory
     ↓
Change Group Ownership
     ↓
Set Permissions
     ↓
Test Access
     ↓
Troubleshoot
