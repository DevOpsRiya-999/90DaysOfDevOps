#! /bin/bash
# to take input from user read -p 
#===========================
#read -p "Enter Your Name: " NAME

#read -p "what is your favourite tool:" TOOL


#echo " Hello, ${NAME} Great to know your Favourite too is ${TOOL} ."
#===============================

# Hide Sensitive Input (Passwords): Use the -s flag to hide the user's keystrokes as they type.

read -s -p "Enter your password: " password
echo -e "\nPassword saved securely."

# Set a Time Limit: Use the -t flag followed by a number of seconds. The script will automatically move on if the user doesn't answer in time.
#


read -t 5 -p "Hurry! Enter your choice (5 seconds): " choice


#Limit Character Count: Use the -n flag followed by a number. The script will automatically press "Enter" for the user once they type that many characters.

read -n 1 -p "Press Y or N to continue: " confirmation

