#! /bin/bash/

# Check if log file argument is provided

if [ $# -eq 0 ]; then
    echo "Error: Please provide a log file."
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

# Check if file exists

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

# Current date
DATE=$(date +%Y-%m-%d)

# Report file
REPORT="log_report_${DATE}.txt"

# Total lines
TOTAL_LINES=$(wc -l < "$LOG_FILE")

# Total errors: ERROR or Failed
ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOG_FILE" | wc -l)

echo "=================================="
echo "       LOG ANALYZER REPORT"
echo "=================================="
echo "Log File       : $LOG_FILE"
echo "Total Lines    : $TOTAL_LINES"
echo "Total Errors   : $ERROR_COUNT"
echo

echo "--- Critical Events ---"
grep -n "CRITICAL" "$LOG_FILE"

echo
echo "--- Top 5 Error Messages ---"

grep "ERROR" "$LOG_FILE" |
awk '{
    $1=""
    $2=""
    $3=""
    $4="ERROR"
    sub(/^ +/, "")
    print
}' |
sort |
uniq -c |
sort -rn |
head -5

# Generate report

{
    echo "=================================="
    echo "       DAILY LOG ANALYSIS"
    echo "=================================="
    echo "Date of Analysis : $(date)"
    echo "Log File         : $LOG_FILE"
    echo "Total Lines      : $TOTAL_LINES"
    echo "Total Error Count: $ERROR_COUNT"
    echo

    echo "--- Top 5 Error Messages ---"
grep "ERROR" "$LOG_FILE" |
    awk '{
        $1=""
        $2=""
        $3=""
        $4="ERROR"
        sub(/^ +/, "")
        print
    }' |
    sort |
    uniq -c |
    sort -rn |
    head -5

       echo
    echo "--- Critical Events ---"
    grep -n "CRITICAL" "$LOG_FILE"

} > "$REPORT"

echo
echo "Report generated successfully: $REPORT"