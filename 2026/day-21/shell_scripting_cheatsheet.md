BASICS
  ↓
Variables → $VAR
Arguments → $0 $1 $# $@
Input → read

DECISIONS
  ↓
if / elif / else
case
&& || !

LOOPS
  ↓
for
while
until
break
continue

FUNCTIONS
  ↓
name() {}
$1 $2
local
return

TEXT PROCESSING
  ↓
grep → Search
awk  → Columns
sed  → Replace/Edit
cut  → Extract
sort → Arrange
uniq → Count duplicates
tr   → Translate
wc   → Count
head → Beginning
tail → End

ERROR HANDLING
  ↓
$?
exit
set -e
set -u
pipefail

===============================================================
# 🐚 Shell Scripting Cheat Sheet

> Quick Bash reference for DevOps engineers 🚀

## 📌 Quick Reference

| Topic     | Key Syntax                | Example                            |
| --------- | ------------------------- | ---------------------------------- |
| Shebang   | `#!/bin/bash`             | `#!/bin/bash`                      |
| Variable  | `VAR="value"`             | `NAME="DevOps"`                    |
| Argument  | `$1`, `$2`                | `./script.sh arg1`                 |
| If        | `if [ condition ]; then`  | `if [ -f file ]; then`             |
| For loop  | `for i in list; do`       | `for i in 1 2 3; do`               |
| While     | `while [ condition ]; do` | `while [ "$i" -lt 5 ]; do`         |
| Function  | `name() { ... }`          | `greet() { echo "Hi"; }`           |
| Grep      | `grep pattern file`       | `grep -i "error" log.txt`          |
| Awk       | `awk '{print $1}' file`   | `awk -F: '{print $1}' /etc/passwd` |
| Sed       | `sed 's/old/new/g' file`  | `sed -i 's/foo/bar/g' config.txt`  |
| Sort      | `sort file`               | `sort -rn file`                    |
| Uniq      | `uniq -c`                 | `sort file \| uniq -c`             |
| Exit code | `$?`                      | `echo $?`                          |

---

# 1. 🐚 Basics

## Shebang

```bash
#!/bin/bash
```

Tells Linux to execute the script using Bash.

## Running a Script

```bash
chmod +x script.sh
./script.sh
```

Or:

```bash
bash script.sh
```

## Comments

```bash
# Single-line comment
echo "Hello"  # Inline comment
```

## Variables

```bash
NAME="Riya"

echo "$NAME"
echo '$NAME'
```

`"$NAME"` expands the variable; `'$NAME'` keeps it literal.

## User Input

```bash
read -p "Enter name: " NAME
echo "Hello $NAME"
```

## Command-Line Arguments

```text
$0 → script name
$1 → first argument
$2 → second argument
$# → number of arguments
$@ → all arguments
$? → previous command exit status
```

Example:

```bash
./script.sh hello world
```

---

# 2. 🔀 Operators & Conditionals

## String Comparisons

```bash
=     # equal
!=    # not equal
-z    # empty string
-n    # non-empty string
```

Example:

```bash
if [ "$NAME" = "Riya" ]; then
    echo "Match"
fi
```

## Integer Comparisons

```text
-eq → equal
-ne → not equal
-lt → less than
-gt → greater than
-le → less/equal
-ge → greater/equal
```

Example:

```bash
if [ "$AGE" -ge 18 ]; then
    echo "Adult"
fi
```

## File Tests

```text
-f → regular file
-d → directory
-e → exists
-r → readable
-w → writable
-x → executable
-s → not empty
```

Example:

```bash
if [ -f "app.log" ]; then
    echo "File exists"
fi
```

## if / elif / else

```bash
if [ "$AGE" -ge 18 ]; then
    echo "Adult"
elif [ "$AGE" -gt 0 ]; then
    echo "Minor"
else
    echo "Invalid"
fi
```

## Logical Operators

```bash
&&    # AND
||    # OR
!     # NOT
```

Example:

```bash
command1 && command2
command1 || command2

if [ ! -f "$FILE" ]; then
    echo "Missing"
fi
```

## case

```bash
case "$CHOICE" in
    start)
        echo "Starting"
        ;;
    stop)
        echo "Stopping"
        ;;
    *)
        echo "Invalid"
        ;;
esac
```

---

# 3. 🔄 Loops

## List-Based for

```bash
for i in 1 2 3; do
    echo "$i"
done
```

## C-Style for

```bash
for ((i=1; i<=5; i++)); do
    echo "$i"
done
```

## while

```bash
COUNT=1

while [ "$COUNT" -le 5 ]; do
    echo "$COUNT"
    ((COUNT++))
done
```

## until

```bash
COUNT=1

until [ "$COUNT" -gt 5 ]; do
    echo "$COUNT"
    ((COUNT++))
done
```

## break

Stops the loop.

```bash
break
```

## continue

Skips the current iteration.

```bash
continue
```

## Loop Over Files

```bash
for file in *.log; do
    echo "$file"
done
```

## Read File Line-by-Line

```bash
while read -r line; do
    echo "$line"
done < file.txt
```

---

# 4. 🧩 Functions

## Define Function

```bash
greet() {
    echo "Hello DevOps!"
}
```

## Call Function

```bash
greet
```

## Function Arguments

```bash
greet() {
    echo "Hello $1"
}

greet "Riya"
```

## local Variable

```bash
greet() {
    local NAME="Riya"
    echo "$NAME"
}
```

## echo vs return

```bash
get_name() {
    echo "Riya"
}
```

`echo` → outputs data.

```bash
check_status() {
    return 0
}
```

`return` → returns exit status.

---

# 5. 🔍 Text Processing Commands

## grep — Search

```bash
grep "ERROR" app.log
```

Useful options:

```text
-i → ignore case
-r → recursive
-c → count
-n → line number
-v → invert/exclude
-E → extended regex
```

Examples:

```bash
grep -i "error" app.log
grep -n "CRITICAL" app.log
grep -c "ERROR" app.log
grep -r "ERROR" /var/log/
```

## awk — Process Columns

```bash
awk '{print $1}' file.txt
```

Custom delimiter:

```bash
awk -F: '{print $1}' /etc/passwd
```

Pattern:

```bash
awk '$3 > 80 {print $1}' file.txt
```

BEGIN / END:

```bash
awk 'BEGIN {print "Start"} {print $1} END {print "Done"}' file.txt
```

## sed — Modify Text

Replace:

```bash
sed 's/old/new/g' file.txt
```

Delete line:

```bash
sed '3d' file.txt
```

Edit directly:

```bash
sed -i 's/foo/bar/g' config.txt
```

## cut — Extract Fields

```bash
cut -d: -f1 /etc/passwd
```

`-d` → delimiter
`-f` → field

## sort

```bash
sort file.txt
sort -n file.txt
sort -r file.txt
sort -u file.txt
```

```text
normal → alphabetical
-n → numerical
-r → reverse
-u → unique
```

## uniq

```bash
uniq file.txt
uniq -c file.txt
```

Count duplicates:

```bash
sort file.txt | uniq -c
```

## tr

Translate:

```bash
echo "hello" | tr 'a-z' 'A-Z'
```

Delete:

```bash
echo "123abc" | tr -d '0-9'
```

## wc

```bash
wc -l file.txt
wc -w file.txt
wc -c file.txt
```

```text
-l → lines
-w → words
-c → characters/bytes
```

## head / tail

```bash
head -5 file.txt
tail -5 file.txt
```

Follow logs:

```bash
tail -f app.log
```

---

# 6. ⚡ Useful DevOps One-Liners

## Find Files Older Than 7 Days

```bash
find /var/log -type f -mtime +7
```

Delete after verifying:

```bash
find /var/log -type f -mtime +7 -delete
```

## Count Log Lines

```bash
wc -l *.log
```

## Replace Text

```bash
sed -i 's/old/new/g' *.conf
```

## Check Service

```bash
systemctl is-active nginx
```

## Check Disk Usage

```bash
df -h
du -sh *
```

## Monitor Errors in Real Time

```bash
tail -f app.log | grep --line-buffered "ERROR"
```

---

# 7. 🛠️ Error Handling & Debugging

## Exit Status

```bash
echo $?
```

```text
0     → success
non-0 → failure
```

## Exit From Script

```bash
exit 0
exit 1
```

## set -e

```bash
set -e
```

Exit when a command fails.

## set -u

```bash
set -u
```

Treat unset variables as errors.

## pipefail

```bash
set -o pipefail
```

Detect failures inside pipelines.

## Recommended Strict Mode

```bash
set -euo pipefail
```

## Debug Mode

```bash
set -x
```

Shows commands during execution.

Disable:

```bash
set +x
```

## trap

```bash
cleanup() {
    echo "Cleaning up..."
}

trap cleanup EXIT
```

Runs cleanup when the script exits.

---

# 🧠 Quick Memory Cheat Sheet

```text
$0      → Script name
$1      → First argument
$#      → Argument count
$@      → All arguments
$?      → Exit status

=       → String equal
!=      → String not equal
-eq     → Number equal
-gt     → Greater than
-lt     → Less than

-f      → File
-d      → Directory
-e      → Exists

&&      → AND
||      → OR
!       → NOT

break   → Stop loop
continue→ Skip iteration

grep    → Search
awk     → Process columns
sed     → Edit/replace
cut     → Extract
sort    → Sort
uniq    → Count/remove duplicates
tr      → Translate/delete
wc      → Count
head    → First lines
tail    → Last/live lines

$?      → Check status
exit 0  → Success
exit 1  → Failure

-e      → Exit on error
-u      → Unset variable error
pipefail→ Pipeline errors
-x      → Debug/trace
trap    → Handle events
```

---

# 🎯 Final Goal

By completing this cheat sheet, you should be able to quickly answer:

**"How do I search a log?"**

```bash
grep "ERROR" app.log
```

**"How do I count errors?"**

```bash
grep -c "ERROR" app.log
```

**"How do I monitor errors live?"**

```bash
tail -f app.log | grep --line-buffered "ERROR"
```

**"How do I check a file?"**

```bash
if [ -f "$FILE" ]; then
    echo "Exists"
fi
```

**"How do I make a script safer?"**

```bash
set -euo pipefail
```

**"How do I debug a script?"**

```bash
set -x
```

**"How do I process columns?"**

```bash
awk '{print $1}' file.txt
```

**"How do I count duplicate errors?"**

```bash
sort file.txt | uniq -c | sort -rn
```

This is the kind of cheat sheet worth keeping beside you during your **DevOps/Linux practice and interviews**. 🚀🐧

set -x
trap
========================================
📁 Files       → find, ls, cp, mv
🔍 Search      → grep
📊 Process     → awk
✏️ Edit        → sed
✂️ Extract     → cut
🔢 Count       → wc, uniq
🔃 Sort        → sort
🔁 Repeat      → for, while
🔀 Decide      → if, case
🧩 Reuse       → functions
🚨 Debug       → set -x
🛡️ Safety      → set -euo pipefail
📡 Monitor     → tail -f
⚙️ Services    → systemctl
💾 Disk        → df, du
=================================

