#!/bin/bash

# Prompt the user to enter two numbers
read -p "Input the first number: " num1
read -p "Input the second number: " num2

# Check if the second number is zero
if [ "$num2" -eq 0 ]; then
    echo "Error: Division by zero"
else
    # Perform division and display the result
    result=$(($num1 /$num2 ))
    echo "Result of division: $result"
fi  
