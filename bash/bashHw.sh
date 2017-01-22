#!/bin/bash

getDate(){
	date

	return
}

getDate

getSum(){
	num3=$1 # The "local" is not strictly necessary.
	local num4=$2

	local sum=$((num3+num4))

	echo $sum
	return #this seems not to matter in this case
}

num1=5
num2=6

# These statements are identical
echo $(getSum num1 num2)
getSum num1 num2

sum=$(getSum num1 num2)
echo "The sum is $sum"


# Read function is raw_input. -p option lets you pass a string prompt. 
# varname to store it goes at the end
# read -p "What is your name? " name
# echo "Hello, $name"

name=""
echo "I am ${name:-Steve}" #Replaces name with Steve if name does not exist. 
echo $name
echo "I am ${name:=Steve}" #Replaces name with Steve even if name exists.
echo $name

