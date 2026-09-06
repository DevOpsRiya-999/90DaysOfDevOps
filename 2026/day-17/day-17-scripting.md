# Challenge Tasks
## Task 1: For Loop
- Create for_loop.sh that:
- Loops through a list of 5 fruits and prints each one
- Create count.sh that:
- Prints numbers 1 to 10 using a for loop
Task 2: While Loop
Create countdown.sh that:
Takes a number from the user
Counts down to 0 using a while loop
Prints "Done!" at the end
Task 3: Command-Line Arguments
Create greet.sh that:

Accepts a name as $1
Prints Hello, <name>!
If no argument is passed, prints "Usage: ./greet.sh "
Create args_demo.sh that:

Prints total number of arguments ($#)
Prints all arguments ($@)
Prints the script name ($0)
Task 4: Install Packages via Script
Create install_packages.sh that:
Defines a list of packages: nginx, curl, wget
Loops through the list
Checks if each package is installed (use dpkg -s or rpm -q)
Installs it if missing, skips if already present
Prints status for each package
Run as root: sudo -i or sudo su

Task 5: Error Handling
Create safe_script.sh that:
Uses set -e at the top (exit on error)
Tries to create a directory /tmp/devops-test
Tries to navigate into it
Creates a file inside
Uses || operator to print an error if any step fails
Example:

mkdir /tmp/devops-test || echo "Directory already exists"
Modify your install_packages.sh to check if the script is being run as root — exit with a message if not.
