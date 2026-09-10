#!/bin/bash



local_example() {
    local LOCAL_VAR="I am local"
    echo "Inside function: $LOCAL_VAR"
}

regular_example() {
    REGULAR_VAR="I am global"
    echo "Inside function: $REGULAR_VAR"
}

echo "===== Local Variable Example ====="

local_example

echo "outside the funtions"
echo "LOCAL_VAR = ${LOCAL_VAR:-Not available}"

echo
echo "===== Regular Variable Example ====="

regular_example

echo "Outside function:"
echo "REGULAR_VAR = $REGULAR_VAR"
