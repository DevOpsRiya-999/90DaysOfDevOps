#! /bin/bash


read -p " Enteryour Nmumber:" num

if [  "$num" -gt 0 ]; then
	echo " The Number is positive. "

elif [ "$num" -lt 0 ]; then
	echo "The number is negative . "

else
  echo "the number is Zero."	


fi  



