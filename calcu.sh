n1=10
n2=10
read choice
echo "This is the calculator script"
case $choice in
  Add)res=$(( $n1 + $n2 ))
  ;;
  subtract)res=$(( $n1 - $n2 ))
  ;;
  multiply)res=$(( $n1 * $n2 ))
  ;;
  divide)res=$(( $n1 / $n2 ))
  ;;
esac
echo "Your choice is$choice"
echo "values are $n1 $n2"
echo "Result is : $res"


