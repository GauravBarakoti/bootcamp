#!/bin/bash


echo "Enter the first number:"
read num1
echo "Enter the second number:"
read num2
echo "Choose an operation:"
echo "1: Addition"
echo "2: Subtraction"
echo "3: Multiplication"
echo "4: Division"
read choice

case $choice in
    1)
        result=$(($num1 + $num2))
        echo "Result: $result"
        ;;
    2)
        result=$(($num1 - $num2))
        echo "Result: $result"
        ;;
    3)
        result=$(($num1 * $num2))
        echo "Result: $result"
        ;;
    4)
        result=$(($num1 / $num2))
        echo "Result: $result"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac

