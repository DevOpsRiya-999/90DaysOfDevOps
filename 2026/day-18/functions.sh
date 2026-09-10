#!/bin/bash


greet() {
	local name="$1"
	echo "Hello, $name"

}

add() {
	local num1="$1"
	local num2="$2"
	local sum=$((num1+num2))
	echo " the sum: $sum "
}

 
greet "ria Roy"

add 30 40

	
