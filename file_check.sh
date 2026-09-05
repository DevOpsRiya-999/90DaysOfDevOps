#! /bin/bash


read -p "Enter The File:" Filename

if [ -f "$Filename" ]; then
	echo " file exist: $Filename"

else
	echo "file does not exist: $filename"

fi	
