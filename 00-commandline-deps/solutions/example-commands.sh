#!/bin/bash

echo “Example commands which are common within CI/CD”


# In Bash, all variables are strings.
VAR=10
echo $VAR

Var1="7" ; Var2="9" ; echo "Result = $((Var1*Var2))"

# echo examples

# echo with another commands output
echo "Hello. The time is currently"
echo `date "+%l %M"`

# terminal works with colors. Play around with special chars and colors to have really interesting effects!

RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I am an ${RED}error${NC}\n"


# cat
# Description: concatenate files and print on the standard output
# common script
cat syslog.log syslog2.log > all_logs.log

# If the all_logs.log file doesn’t exist, the command will create it. Otherwise, it will overwrite the file.

# Use the (>>) operator to append the contents of syslog.log to all_logs.log
#cat syslog.log >> all_logs.log

# To display contents of a file with line numbers
#cat -n all_logs.log

# cd
# Description: change the working directory
# often used within ci scripts to set a working directory.

cd ../
cd solutions

# pwd
# Description: print name of current/working directory
# Good for debug and pushing code into a specific directory.
pwd

# curl
# Description: curl is a tool to transfer data from or to a server
# Can be used to quickly check to see if site is up and running.

curl google.com

# wget
# Description: GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS, the most widely used Internet protocols. It is a non-interactive commandline tool, so it may easily be called from scripts, cron jobs, terminals without X-Windows support, etc.
# Often used same way as curl.

# Both curl and wget are often used within CI/CD to do health checks and download binaries not easily accessable by package managers:

wget --spider -S "https://bitwiseindustries.com" 2>&1 | grep "HTTP/" | awk '{print $2}'

curl https://github.com/Shift3/laptop/blob/master/setup > setup.sh
#./setup.sh


# ssh
# Description: ssh (SSH client) is a program for logging into a remote machine and for executing commands on a remote machine.
# https://www.digitalocean.com/community/tutorials/how-to-use-ssh-to-connect-to-a-remote-server
ssh user@box.com
ssh box.com -u user -p port_number

# Test this out!
ssh sshtron.zachlatta.com

# ssh tunneling
# using ssh to get into a box from another box
# clinet -> server -> targeted server
# good for VPNs, subdomains, and basion servers
ssh -D <port> -C user@remote_host.com



# rsync
# Description: a fast, versatile, remote (and local) file-copying tool
# https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
# most likely seen if you need to sync two folders.

# rsync -zvh backup.tar.gz /tmp/backups/
# If you do end up using, I would suggest using a progress bar on your own scripts.

# rsync -zvh -P backup.tar.gz /tmp/backups/



# aws
# Description: The AWS Command Line Interface (AWS CLI) is a unified tool to manage your AWS services. With just one tool to download and configure, you can control multiple AWS services from the command line and automate them through scripts.
# https://aws.amazon.com/cli/
# You will see this being used with CI/CD for deployments and modification of infastructure.
# Sometimes docker will also do the same on an EB env.

eb deploy
# docker
# Description: A self sufficiant runtime for containers
# common script



# ssh-keygen
# Description: OpenSSH authentication key utility
# common script

# be sure ssh server is running
# sudo systemctl start ssh

# SSH keys should be generated on the computer you wish to log in from. This is usually your local machine.
# sh-keygen -t rsa

# You may be prompted to set a password on the key files themselves, but this is a fairly uncommon practice,
# and you should press enter through the prompts to accept the defaults.
# Your keys will be created at ~/.ssh/id_rsa.pub and ~/.ssh/id_rsa.

# take a look here:
cd ~/.ssh

# Transfer Your Public Key to the Server
# ssh-copy-id remote_host



# jq
# Description: jq is like sed for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text.
# https://www.baeldung.com/linux/jq-command-json#1-prettify-json
# Often used to decipher, modify, and filter json data into something bash can work with.
# You may need to install it
# brew install jq

echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.'

# grep
# Description: print lines matching a pattern
# find something within a string (or multiple strings)
# Realy common to see within scripts.
# Can use REGEX
ps -x | grep zsh


# awk
# Description: Awk is a scripting language used for manipulating data and generating reports.
# https://www.bitarray.io/awk-with-examples/



# ps
# Description: displays information about a selection of the active processes.
# What are all the processes I am currently running?
ps -x

# Excellent tool for debugging a server or hunting down zombie processes.

# kill
# Description: send a signal to a process
# remove processes from a running server.
kill -9 process_id

# remove processes from a running server. You can identify the process by the ps -x command.
