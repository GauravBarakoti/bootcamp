#!/bin/bash


num1=0
num2=0
operator=""
result=0


echo "Enter first number:"
read num1
echo "Enter second number:"
read num2
echo "Enter operator (+, -, *, /):"
read operator


while [[ $operator != "+" && $operator != "-" && $operator != "*" && $operator != "/" ]]
do
  echo "Invalid operator. Please enter a valid operator (+, -, *, /):"
  read operator
done

case $operator in
  "+") result=$(echo "$num1 + $num2" | bc);;
  "-") result=$(echo "$num1 - $num2" | bc);;
  "*") result=$(echo "$num1 * $num2" | bc);;
  "/") result=$(echo "scale=2; $num1 / $num2" | bc);;
esac


echo "Result: $result"

