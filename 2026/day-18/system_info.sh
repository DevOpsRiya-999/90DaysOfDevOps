#!/bin/bash

set -euo pipefail

print_header() {
    echo
    echo "=========================================="
    echo "        $1"
    echo "=========================================="
}

print_system_info() {
    print_header "HOSTNAME & OS INFORMATION"

    echo "Hostname: $(hostname)"

    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        echo "OS: ${PRETTY_NAME}"
    fi

}

print_uptime() {
    print_header "SYSTEM UPTIME"

    uptime -p
}

print_disk_usage() {
    print_header "TOP 5 DISK USAGE"

    echo "Top 5 largest items in /:"
    du -ah / 2>/dev/null | sort -rh | head -n 5
}

print_memory_usage() {
    print_header "MEMORY USAGE"

    free -h
}

print_cpu_processes() {
    print_header "TOP 5 CPU-CONSUMING PROCESSES"

    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

main() {
    print_system_info
    print_uptime
    print_disk_usage
    print_memory_usage
    print_cpu_processes
}

main

