# Day 20 – Bash Log Analyzer & Report Generator

## Objective

Created a Bash script to analyze server log files and automatically
generate a daily summary report.

## Features

- Accepts log file as command-line argument
- Validates file existence
- Counts ERROR and Failed events
- Finds CRITICAL events with line numbers
- Finds top 5 ERROR messages
- Generates a daily report

## Commands Used

- grep
- awk
- sort
- uniq
- head
- wc
- date
- chmod
- mkdir
- mv

## Execution

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh sample_log.log

## What I Learned
How to pass arguments to Bash scripts.
How to analyze log files using grep, awk, sort and uniq.
How to automate report generation using Bash.
## basic commands

---

# 🧠 Most Important Commands to Remember

| Command | Meaning | Example |
|---|---|---|
| `mkdir` | Create directory | `mkdir logs` |
| `cd` | Change directory | `cd logs` |
| `pwd` | Show current directory | `pwd` |
| `cat` | Display file | `cat file.log` |
| `grep` | Search text | `grep ERROR file.log` |
| `grep -n` | Search + line number | `grep -n CRITICAL file.log` |
| `grep -i` | Ignore case | `grep -i error file.log` |
| `awk` | Process text | `awk '{print $1}' file` |
| `sort` | Sort data | `sort file` |
| `uniq` | Remove duplicates | `uniq file` |
| `uniq -c` | Count duplicates | `uniq -c file` |
| `head` | First lines | `head -5 file` |
| `wc -l` | Count lines | `wc -l file` |
| `date` | Current date/time | `date` |
| `chmod +x` | Make executable | `chmod +x script.sh` |
| `mv` | Move file | `mv file archive/` |
| `exit 1` | Exit with error | `exit 1` |
| `>` | Redirect output | `echo hi > file.txt` |
| `\|` | Pipe commands | `grep ERROR file \| wc -l` |

---

# ⭐ The 5 commands you should really understand today

If you're preparing for a **DevOps Engineer interview**, focus especially on these:

### 1. grep

```bash
grep "ERROR" app.log
