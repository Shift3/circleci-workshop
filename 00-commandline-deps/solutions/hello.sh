#!/bin/bash
# ^^^ Tells your terminal that when you run the script it should use bash to execute it.
# It can be vital since you may be using a different shell in your machine ( zsh , fish , sh , etc.),
# but you designed the script to work specifically with bash.
echo “Hello World”

echo "Hello. The time is currently"
echo `date "+%l %M"`

# prints something on the screen. Play around with special chars to have really interesting effects!

RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I am an ${RED}error${NC}\n"

exit 0

# exit 1
# echo $?