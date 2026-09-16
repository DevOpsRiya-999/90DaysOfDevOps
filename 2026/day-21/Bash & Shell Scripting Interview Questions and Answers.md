Bash & Shell Scripting Interview Questions and Answers

A practical documentation guide for DevOps Engineer, AWS DevOps, and SRE
interviews.

1. What is a Shell Script?

A shell script is a text file containing a series of Linux commands that
are executed by a shell.

#!/bin/bash

echo "Hello DevOps"

Why use shell scripts?

Automate repetitive tasks

Manage files and logs

Monitor servers

Automate deployments

Perform backups

Check services and disk usage

2. What is the difference between sh and bash?

sh is a generic POSIX shell interface.

bash is the Bourne Again Shell and provides additional features
such as arrays, improved scripting features, and Bash-specific
syntax.

Example:

#!/bin/bash

3. What is a Shebang?

The shebang tells Linux which interpreter should execute the script.

#!/bin/bash

Other examples:

#!/bin/sh
#!/usr/bin/python3

4. How do you execute a shell script?

Give execute permission:

chmod +x script.sh

Run it:

./script.sh

You can also run:

bash script.sh

Interview Tip

./script.sh requires execute permission, while bash script.sh
directly invokes Bash.

5. What does $? mean?

$? stores the exit status of the previous command.

ls
echo $?

Usually: - 0 = success - Non-zero = failure

Example:

systemctl is-active nginx
echo $?

6. Explain $0, $1, $#, and $@.

If we run:

./script.sh Riya DevOps

Then:

Variable   Meaning

$0       Script name
$1       First argument
$2       Second argument
$#       Number of arguments
$@       All arguments

Example:

echo "Script: $0"
echo "First argument: $1"
echo "Argument count: $#"
echo "All arguments: $@"

7. What is the difference between single and double quotes?

Double quotes

Variables are expanded:

NAME="Riya"
echo "$NAME"

Output:

Riya

Single quotes

Variables are not expanded:

echo '$NAME'

Output:

$NAME

Interview Tip

Use double quotes around variables in most scripts:

echo "$FILE"

This helps prevent problems with spaces and special characters.

8. How do you take user input?

Use read:

read -p "Enter your name: " NAME
echo "Hello $NAME"

9. How do you check whether an argument was provided?

if [ $# -eq 0 ]; then
    echo "Please provide an argument"
    exit 1
fi

10. How do you check if a file exists?

if [ -f "$FILE" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi

11. How do you check if a directory exists?

if [ -d "$DIR" ]; then
    echo "Directory exists"
else
    echo "Directory does not exist"
fi

12. How do you check whether a file is empty?

Use:

[ ! -s "$FILE" ]

Example:

if [ ! -s "$FILE" ]; then
    echo "File is empty"
fi

File Test Operators

Operator   Meaning

-f       Regular file exists
-d       Directory exists
-e       Path exists
-r       File is readable
-w       File is writable
-x       File is executable
-s       File exists and is not empty

Example:

if [ -x script.sh ]; then
    echo "Script is executable"
fi

String Comparisons

Operator   Meaning

=        Equal
!=       Not equal
-z       String is empty
-n       String is not empty

Example:

if [ -z "$NAME" ]; then
    echo "Name is empty"
fi

Integer Comparisons

Operator   Meaning

-eq      Equal
-ne      Not equal
-lt      Less than
-gt      Greater than
-le      Less than or equal
-ge      Greater than or equal

Example:

if [ "$CPU" -gt 80 ]; then
    echo "High CPU usage"
fi

13. Explain if, elif, and else.

if [ "$AGE" -ge 18 ]; then
    echo "Adult"
elif [ "$AGE" -gt 0 ]; then
    echo "Minor"
else
    echo "Invalid age"
fi

14. Explain &&, ||, and !.

&& --- AND

Second command runs if first succeeds.

mkdir backup && echo "Backup directory created"

|| --- OR

Second command runs if first fails.

systemctl is-active nginx || echo "Nginx is down"

! --- NOT

Negates a condition.

if [ ! -f "$FILE" ]; then
    echo "File does not exist"
fi

15. What is case in Bash?

case is useful when there are multiple possible values.

case "$ACTION" in
    start)
        echo "Starting service"
        ;;
    stop)
        echo "Stopping service"
        ;;
    restart)
        echo "Restarting service"
        ;;
    *)
        echo "Invalid option"
        ;;
esac

Loops

16. Explain a for loop.

for i in 1 2 3 4 5; do
    echo "$i"
done

C-style loop:

for ((i=1; i<=5; i++)); do
    echo "$i"
done

17. How do you loop through log files?

for file in *.log; do
    echo "$file"
done

This is useful for processing multiple log files.

18. How do you read a file line by line?

Recommended approach:

while IFS= read -r line; do
    echo "$line"
done < file.txt

Why IFS= and -r?

They help preserve whitespace and prevent backslash interpretation.

19. What is a while loop?

A while loop continues while its condition is true.

COUNT=1

while [ "$COUNT" -le 5 ]; do
    echo "$COUNT"
    COUNT=$((COUNT + 1))
done

20. What is an until loop?

An until loop continues until its condition becomes true.

COUNT=1

until [ "$COUNT" -gt 5 ]; do
    echo "$COUNT"
    COUNT=$((COUNT + 1))
done

21. Difference between break and continue.

break

Stops the loop completely.

for i in 1 2 3 4 5; do
    if [ "$i" -eq 3 ]; then
        break
    fi
    echo "$i"
done

continue

Skips the current iteration.

for i in 1 2 3 4 5; do
    if [ "$i" -eq 3 ]; then
        continue
    fi
    echo "$i"
done

22. How can you create an infinite loop?

while true; do
    echo "Running..."
    sleep 5
done

Stop it with:

Ctrl + C

Functions

23. What is a function in Bash?

A function is a reusable block of code.

greet() {
    echo "Hello DevOps!"
}

greet

24. How do you pass arguments to a function?

greet() {
    echo "Hello $1"
}

greet "Riya"

Here $1 is the first function argument.

25. What is the difference between return and echo in a function?

echo sends output/data:

get_name() {
    echo "Riya"
}

NAME=$(get_name)

return sends an exit status, normally 0–255:

check_file() {
    [ -f "$1" ]
    return $?
}

Interview Tip

Use echo when you need to return data. Use return for
success/failure status.

26. What is local?

local creates a variable whose scope is limited to the function.

my_function() {
    local NAME="Riya"
    echo "$NAME"
}

Text Processing

27. What is grep?

grep searches text for a pattern.

Search for ERROR:

grep "ERROR" app.log

Case-insensitive:

grep -i "error" app.log

Show line numbers:

grep -n "ERROR" app.log

Recursive search:

grep -r "ERROR" /var/log

Count matches:

grep -c "ERROR" app.log

28. How do you count ERROR lines?

grep -c "ERROR" app.log

Or:

grep "ERROR" app.log | wc -l

29. How do you find CRITICAL messages with line numbers?

grep -n "CRITICAL" app.log

30. How do you find the top 5 common errors?

grep "ERROR" app.log |
sort |
uniq -c |
sort -rn |
head -5

What happens?

grep → selects ERROR lines

sort → sorts them

uniq -c → counts duplicates

sort -rn → highest count first

head -5 → shows top 5

31. What is awk?

awk is a powerful text-processing tool commonly used for columns,
filtering, calculations, and reporting.

Example:

awk '{print $1}' file.txt

Print first column.

32. How do you print the first column of /etc/passwd?

Because /etc/passwd uses : as a separator:

awk -F: '{print $1}' /etc/passwd

33. What is -F in awk?

-F specifies the field separator.

Example:

awk -F, '{print $1}' users.csv

Here comma is the separator.

34. What are BEGIN and END in awk?

BEGIN runs before processing records.

END runs after all records are processed.

awk 'BEGIN {print "Start"} {print $1} END {print "Done"}' file.txt

35. What is sed?

sed is used to search, replace, delete, and transform text.

Replace:

sed 's/old/new/g' file.txt

Replace directly in the file:

sed -i 's/old/new/g' file.txt

Delete lines:

sed '/ERROR/d' app.log

36. What is cut?

cut extracts columns or characters.

Example:

cut -d',' -f1 users.csv

-d → delimiter

-f1 → first field

37. What is sort?

sort sorts lines.

Alphabetical:

sort file.txt

Numeric:

sort -n numbers.txt

Reverse:

sort -r file.txt

38. What is uniq?

uniq removes/counts adjacent duplicate lines.

Remove duplicates:

sort file.txt | uniq

Count duplicates:

sort file.txt | uniq -c

39. What is tr?

tr translates or deletes characters.

Convert lowercase to uppercase:

echo "devops" | tr 'a-z' 'A-Z'

Delete spaces:

echo "Dev Ops" | tr -d ' '

40. What is wc?

wc counts lines, words, and characters.

Lines:

wc -l file.txt

Words:

wc -w file.txt

Characters:

wc -c file.txt

41. What are head and tail?

Show first 10 lines:

head file.txt

Show last 10 lines:

tail file.txt

Follow a growing log:

tail -f app.log

Linux / DevOps Scenario Questions

42. How would you search a 10 GB log file for ERROR?

You do not need to open the whole file in an editor.

Use:

grep "ERROR" app.log

Count errors:

grep -c "ERROR" app.log

Show line numbers:

grep -n "ERROR" app.log

For large logs, use streaming/filtering tools rather than loading the
entire file into an editor.

43. How do you check disk usage in a script?

df -h

Example threshold check:

USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -gt 80 ]; then
    echo "Warning: Disk usage is above 80%"
else
    echo "Disk usage is normal"
fi

44. How do you check whether Nginx is running?

if systemctl is-active --quiet nginx; then
    echo "Nginx is running"
else
    echo "Nginx is not running"
fi

45. How would you restart a service if it is down?

if ! systemctl is-active --quiet nginx; then
    systemctl restart nginx
fi

In production, you would normally also log the event and verify that the
restart succeeded.

46. How do you find files larger than 1 GB?

find / -type f -size +1G 2>/dev/null

2>/dev/null hides permission-denied messages.

47. How do you find the top 5 IP addresses in an access log?

If the IP address is the first field:

awk '{print $1}' access.log |
sort |
uniq -c |
sort -rn |
head -5

Error Handling and Debugging

48. What is set -e?

set -e makes a script exit when a command fails.

set -e

Useful for catching failures early.

49. What is set -u?

set -u treats unset variables as errors.

set -u

This helps catch typing mistakes and missing variables.

50. What is set -o pipefail?

Normally, a pipeline's status can be based on the last command.

With:

set -o pipefail

the pipeline fails if an earlier command in the pipeline fails.

51. What is set -euo pipefail?

This is a common Bash safety pattern:

set -euo pipefail

Meaning:

-e → exit on command failure

-u → error on unset variables

pipefail → detect failures inside pipelines

Interview Answer

"I use set -euo pipefail in Bash scripts to make failures visible and
prevent silent errors."

52. How do you debug a Bash script?

Run:

bash -x script.sh

Or inside the script:

set -x

Stop tracing:

set +x

-x prints commands as they are executed.

53. What is trap?

trap allows a script to react to signals or events.

Example cleanup:

cleanup() {
    echo "Cleaning up..."
}

trap cleanup EXIT

The cleanup function runs when the script exits.

Common uses: - Temporary file cleanup - Removing locks - Handling
interrupts - Logging script termination

Practical Script-Writing Interview Questions

54. Write a script to check whether a file exists.

#!/bin/bash

FILE="$1"

if [ -f "$FILE" ]; then
    echo "File exists"
else
    echo "File does not exist"
    exit 1
fi

55. Write a script to count ERROR messages.

#!/bin/bash

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found"
    exit 1
fi

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")

echo "Total ERROR messages: $ERROR_COUNT"

56. Write a script to check disk usage.

#!/bin/bash

USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -gt 80 ]; then
    echo "WARNING: Disk usage is ${USAGE}%"
else
    echo "Disk usage is ${USAGE}%"
fi

57. Write a script to check a service.

#!/bin/bash

SERVICE="nginx"

if systemctl is-active --quiet "$SERVICE"; then
    echo "$SERVICE is running"
else
    echo "$SERVICE is down"
    exit 1
fi

Important One-Liners

Find files older than 7 days

find /var/log -type f -mtime +7

Delete files older than 7 days:

find /var/log -type f -mtime +7 -delete

Count lines in log files

wc -l *.log

Replace text in configuration files

sed -i 's/old/new/g' *.conf

Check if a service is active

systemctl is-active nginx

Check disk usage

df -h

Check directory size

du -sh *

Monitor ERROR logs in real time

tail -f app.log | grep --line-buffered "ERROR"

Day 20 Log Analyzer Interview Question

58. How would you build a Bash log analyzer?

A simple approach:

Accept the log file as a command-line argument.

Validate that the file exists.

Count total lines.

Count ERROR and Failed entries.

Find CRITICAL events with line numbers.

Extract and count common error messages.

Sort and display the top 5.

Generate a dated report.

Optionally archive the processed log.

Example commands:

TOTAL_LINES=$(wc -l < "$LOG_FILE")
ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOG_FILE" | wc -l)
grep -n "CRITICAL" "$LOG_FILE"

Top error pattern:

grep "ERROR" "$LOG_FILE" |
sort |
uniq -c |
sort -rn |
head -5

Most Important Interview Questions to Practice First

If you have limited time, focus on these:

What is a shell script?

What is a shebang?

sh vs bash

How do you execute a script?

Explain $0, $1, $#, $@, $?

Single quotes vs double quotes

File test operators

String and integer comparisons

if/elif/else

case

for, while, and until

break vs continue

Functions and function arguments

return vs echo

grep

awk

sed

sort | uniq -c | sort -rn

wc

head and tail

How to analyze a large log file

How to check disk usage

How to check/restart a service

set -euo pipefail

set -x

trap

Write a file-existence script

Write an ERROR-counting script

Write a disk-usage alert script

Write a log analyzer

Quick Bash Cheat Sheet

Requirement        Command / Syntax

Shebang            #!/bin/bash
Execute            chmod +x script.sh && ./script.sh
First argument     $1
Argument count     $#
All arguments      $@
Previous status    $?
File exists        [ -f file ]
Directory exists   [ -d dir ]
Empty file         [ ! -s file ]
Search text        grep "text" file
Line number        grep -n "text" file
Count lines        wc -l file
First column       awk '{print $1}' file
Replace text       sed 's/old/new/g' file
Extract field      cut -d',' -f1 file
Sort               sort file
Count duplicates   uniq -c
First lines        head file
Last lines         tail file
Follow log         tail -f app.log
Find files         find /path -type f
Disk usage         df -h
Directory size     du -sh *
Service status     systemctl status nginx
Strict mode        set -euo pipefail
Debug              bash -x script.sh
Cleanup            trap cleanup EXIT

DevOps Interview Memory Map

Bash / Shell
│
├── Variables
│   ├── $VAR
│   ├── $1
│   ├── $#
│   └── $?
│
├── Conditions
│   ├── if
│   ├── case
│   └── file tests
│
├── Loops
│   ├── for
│   ├── while
│   └── until
│
├── Functions
│   ├── local
│   ├── arguments
│   └── return
│
├── Text Processing
│   ├── grep
│   ├── awk
│   ├── sed
│   ├── cut
│   ├── sort
│   ├── uniq
│   └── wc
│
├── DevOps Automation
│   ├── Logs
│   ├── Backups
│   ├── Disk monitoring
│   ├── Service checks
│   └── Cron jobs
│
└── Reliability
    ├── set -euo pipefail
    ├── set -x
    └── trap

Final Interview Tip

Do not only memorize commands. Be ready to explain why you are using
them.

For example:

"I use grep to filter log entries, awk to extract fields, sort
and uniq -c to calculate frequency, and head to select the top
results. This is useful for automated log analysis in DevOps."

A strong DevOps interview answer usually combines:

Linux + Bash + Logs + Automation + Troubleshooting

Practice writing small scripts from memory rather than only reading the
commands.
