#!/bin/bash

SERVICE="nginx"

read -p "Do you want to check the status of $SERVICE? (y/n): " ANSWER

if [ "$ANSWER" = "y" ]; then

    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE is active and running."
    else
        echo "$SERVICE is not running."
    fi

elif [ "$ANSWER" = "n" ]; then
    echo "Skipped."

else
    echo "Invalid choice. Please enter y or n."
fi
