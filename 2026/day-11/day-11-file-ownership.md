# Day 11 Challenge
Document: What's the difference between owner and group?
-rw-r----- 1 ubuntu ubuntu 15 Aug 11 09:55 notes.txt

-rw-r--r-- 1 ubuntu ubuntu 100
             │      │
             │      └── Group
             └───────── Owner
  so : 
  Owner = ubuntu
  Group = ubuntu
  ## What is an owner?

The owner is the user who owns the file.
## What is a group?

A group is a collection of users.
Group: developers

Members:
  ubuntu
  tokyo
  berlin
  ## Simple example
  File: application.log

Owner → DevOps Engineer
Group → DevOps Team
-rw-rw-r-- 1 ubuntu ubuntu 20 Aug 11 20:00 notes.txt
│          │ │      │
│          │ │      └── Group
│          │ └───────── Owner
│          └──────────── Number of links
└────────────────────── Permissions
## 3. Task 2 – chown
chown means:

change owner
<img width="613" height="246" alt="image" src="https://github.com/user-attachments/assets/8c5a5ab3-fce8-4add-a9dd-81aafd83355f" />

## Create a group
// sudo groupadd heist-team//
## Change the group
//sudo chgrp heist-team team-notes.txt// 
## 5. chown can change both

// sudo chown professor:heist-team project-config.yaml//
<img width="832" height="187" alt="image" src="https://github.com/user-attachments/assets/6736918c-a87f-4f2a-b3a5-c041d730fcf3" />
Create app-logs
mkdir app-logs

Change owner and group:

sudo chown berlin:heist-team app-logs

Verify:

ls -ld app-logs

Expected:

drwxr-xr-x 2 berlin heist-team ...
<img width="825" height="757" alt="image" src="https://github.com/user-attachments/assets/d0055a65-6afb-41ca-9ca0-f3f3eebc858d" />

## 7. Task 5 – Recursive Ownership
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
// ls -lR heist-project///
-R means:

Recursive

It shows everything inside the directory and its subdirectories.

## Create planners group
sudo groupadd planners
sudo chown -R professor:planners heist-project/
sudo
 ↓
chown
 ↓
-R
 ↓
professor:planners
 ↓
heist-project/
## -R means:

Change ownership of the directory and everything inside it.
## 8. Why is -R important?
Only the heist-project directory changes.

The files inside may remain unchanged.

<img width="850" height="581" alt="image" src="https://github.com/user-attachments/assets/30f375de-f48c-4fbf-948d-a53a238bf7aa" />

🔥 Ownership vs Permissions

Don't confuse these two.

Suppose:

-rw-r----- 1 tokyo developers 100 file.txt

There are two separate concepts here.

Ownership
tokyo       → Owner
developers  → Group
Permissions
rw- r-- ---
│   │   │
│   │   └── Others
│   └────── Group
└────────── Owner

So:

Owner:
tokyo → read + write

Group:
developers → read

Others:
no permission

Think:

chown/chgrp = Who owns it?
chmod = What can they do?



## Commands Used
# View ownership
ls -l file.txt

# View directory ownership
ls -ld directory/

# Create user
sudo useradd username

# Create group
sudo groupadd groupname

# Change owner
sudo chown username file.txt

# Change group
sudo chgrp groupname file.txt

# Change owner + group
sudo chown username:groupname file.txt

# Change only group using chown
sudo chown :groupname file.txt

# Recursive ownership
sudo chown -R username:groupname directory/

# Verify recursively
ls -lR directory/

              FILE
               │
       ┌───────┴───────┐
       ↓               ↓
     OWNER            GROUP
       │               │
    chown            chgrp
       │               │
       └───────┬───────┘
               ↓
         chown user:group

## What I Learned
<img width="600" height="592" alt="image" src="https://github.com/user-attachments/assets/b55152e3-dcc5-4513-873d-1afc20fc10ca" />
