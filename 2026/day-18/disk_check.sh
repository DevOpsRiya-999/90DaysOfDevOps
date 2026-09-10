#!/bin/bash


check_disk() {
	echo "===================disk Uses==================="
       df -h /
}

check_memory() {

	echo " ========================memory check===================="

	free -h 

}

main() {

	check_disk
	echo
	check_memory

}

main

