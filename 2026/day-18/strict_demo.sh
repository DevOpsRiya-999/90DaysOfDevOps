#!/bin/bash


set -euo pipefail

echo "===== Strict Mode Demo ====="

echo
echo "1. Testing set -u"

if false; then
    echo "$UNDEFINED_VARIABLE"
fi

echo "Script continued after set -u test."

echo
echo "2. Testing set -e"

false

echo "This line will NOT execute."
