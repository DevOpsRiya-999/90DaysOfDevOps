task1 :
<img width="1066" height="212" alt="image" src="https://github.com/user-attachments/assets/bb2b3cfe-d52f-4491-8bd4-39761127ba39" />

task2 : 
<img width="1152" height="285" alt="image" src="https://github.com/user-attachments/assets/0ce0cdaa-19a1-481c-b983-46789ebcc482" />
task3 :
-set -e →Exit immediately when a command fails.
-set -u →Treat unset variables as errors.
-set -o pipefail →Pipeline fails if any command fails

Together:

- set -euo pipefail

makes shell scripts safer and more predictable.

<img width="1065" height="222" alt="image" src="https://github.com/user-attachments/assets/0e4b9816-5dbb-44f7-af60-323c5ad0e561" />

task4: Local Variables

<img width="1125" height="310" alt="image" src="https://github.com/user-attachments/assets/62cdc01b-86fc-4eb1-86bd-b76f5b342b03" />

task5: 
<img width="1018" height="587" alt="image" src="https://github.com/user-attachments/assets/a05c7430-37d9-42f4-b7c3-a624ca7e4340" />

Important: Understand the Disk Function

This line:

du -ah / 2>/dev/null | sort -rh | head -n 5

is worth understanding for interviews.

du -ah /

Find disk usage under /.

2>/dev/null

Hide permission/error messages.

sort -rh

Sort from largest to smallest.

-r → reverse
-h → human-readable sorting

head -n 5

Show only the top five.


## Three Key Things I Learned
Functions make Bash scripts reusable, cleaner and easier to maintain.
set -euo pipefail helps make production scripts safer and easier to troubleshoot.
Using local variables prevents functions from accidentally modifying global variables.
