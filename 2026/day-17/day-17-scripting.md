# Challenge Tasks
## Task 1: For Loop
- Create for_loop.sh that:
- Loops through a list of 5 fruits and prints each one
- Create count.sh that:
- Prints numbers 1 to 10 using a for loop

<img width="900" height="385" alt="image" src="https://github.com/user-attachments/assets/654250a8-d5ef-4470-8858-4af29b465214" />
<img width="998" height="212" alt="image" src="https://github.com/user-attachments/assets/5dd3f186-a313-4554-86bd-336559f1f6da" />

## Task 2: While Loop
- Create countdown.sh that:
- Takes a number from the user
- Counts down to 0 using a while loop
- Prints "Done!" at the end
<img width="625" height="436" alt="image" src="https://github.com/user-attachments/assets/9185bcae-4ca4-4a0e-87f4-328b3b2f9918" />
<img width="1093" height="407" alt="image" src="https://github.com/user-attachments/assets/4f5f7b5d-c498-4211-b283-4f11be09e157" />

## Task 3: Command-Line Arguments
- Create greet.sh that:

- Accepts a name as $1
- Prints Hello, <name>!
- If no argument is passed, prints "Usage: ./greet.sh "

<img width="681" height="400" alt="image" src="https://github.com/user-attachments/assets/37c4441e-50b3-421d-a294-bc4c55b8e0d5" />
<img width="1346" height="257" alt="image" src="https://github.com/user-attachments/assets/7c9fa7e1-cab5-4fdf-8906-03350b618ee0" />

## Create args_demo.sh that:
- Prints total number of arguments ($#)
- Prints all arguments ($@)
- Prints the script name ($0)
<img width="643" height="438" alt="image" src="https://github.com/user-attachments/assets/cc28b9f9-dd72-4a37-9630-ea7b4e68f999" />
<img width="1522" height="205" alt="image" src="https://github.com/user-attachments/assets/3877e865-521e-4fc4-8490-a63a92e256de" />

## Task 4: Install Packages via Script
- Create install_packages.sh that:
- Defines a list of packages: nginx, curl, wget
- Loops through the list
- Checks if each package is installed (use dpkg -s or rpm -q)
- Installs it if missing, skips if already present
- Prints status for each package
- Run as root: sudo -i or sudo su
<img width="1431" height="992" alt="image" src="https://github.com/user-attachments/assets/f6abd72a-3185-4242-8091-7e6ea137864f" />
<img width="1706" height="417" alt="image" src="https://github.com/user-attachments/assets/89956fa6-eace-40cc-8fea-089b7383bba8" />

## Task 5: Error Handling
- Create safe_script.sh that:
- Uses set -e at the top (exit on error)
- Tries to create a directory /tmp/devops-test
- Tries to navigate into it
- Creates a file inside
- Uses || operator to print an error if any step fails
### Example:

- mkdir /tmp/devops-test || echo "Directory already exists"
- Modify your install_packages.sh to check if the script is being run as root — exit with a message if not.

<img width="1150" height="911" alt="image" src="https://github.com/user-attachments/assets/269602d7-89cb-442d-93a2-b0d3668dfb0f" />
<img width="1845" height="155" alt="image" src="https://github.com/user-attachments/assets/6bbacfb0-cf27-47ab-9cd3-5f15522eeb2c" />

💡 DevOps Interview Connection

## If an interviewer asks:

"Why do DevOps engineers use shell scripting?"

A simple answer is:

"Shell scripting helps automate repetitive Linux tasks such as installing packages, checking services, managing files, processing logs, deploying applications, and performing system checks."

And remember these commands/concepts from Day 17:

- for       → repeat over a list
- while     → repeat while condition is true
- $1        → first argument
- $#        → number of arguments
- $@        → all arguments
- $0        → script name
- read      → take user input
- set -e    → stop on command failure
- ||        → execute if previous command fails
- EUID      → check current user ID
- dpkg -s   → check Ubuntu/Debian package
=================================

### 4. What is the difference between bash script.sh and ./script.sh?
bash script.sh

You explicitly tell Linux:

Use Bash to execute this file.

./script.sh

Linux uses the interpreter defined in the shebang.

For example:

#!/bin/bash

========================================

### Scenario 3

Interviewer:

Your package installation script is accidentally executed by a normal user. How will you prevent it?

Answer:

if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

==============================

