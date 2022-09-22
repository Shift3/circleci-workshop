# Command Line - A primer
Bitwise Consulting - Circleci Workshop

This workshop will focus on the basics behind the command line. For ease of use, we will be assuming you have a Mac OS system provided by Bitwise.

`telnet towel.blinkenlights.nl`

`sl`

`bastet`


## Prerequisites
 - Open your terminal.
- Install [Shift3 Laptop setup
scripts](https://github.com/shift3/laptop)
- Come prepared to do some coding, only your editor of choice and a terminal will be required.


## Workshop
This workshop will be using a circleci script but will not require you to know how to use it (yet).

### Creating a Bash Script
```bash
nano hello.sh

#!/bin/bash
echo “Hello World”


```
https://www.tomshardware.com/how-to/write-bash-scripts-linux

#### Running Bash Scripts

`bash hello.sh`

`sh hello.sh`

`chmod +x hello.sh` then `./hello.sh`.

#### exit codes
For our purposes, we will only concentrate on two error codes:
* 0 means everything ran ok!
* 1 means something went wrong.
* Circleci will only move forward if it detects 0.

How do you detect?
`echo $?`

Modify the script so that it exits with a -1 status and echo out the result.


### Common commands within CI/CD

For any command, take a look at their man page!
`man echo` for example.

Assignment:
* Create a example-commands.sh script. Give it an exit code of 0.

1. echo
2. cat
3. cd
4. pwd
5. curl
6. wget
7. ssh (with tunnelling included)
8. rsync
9. aws
10. docker
11. ssh-keygen
12. jq
13. grep
14. ps

### Common Building Tools
1. yarn
2. npm
3. make
4. brew (Mac OS)
5. apt (Ubuntu)
6. LOTS of others!

### Common patterns within CI/CD scripts
```
# Both curl and wget are often used within CI/CD to do health checks and download binaries not easily accessable by package managers:

wget --spider -S "https://bitwiseindustries.com" 2>&1 | grep "HTTP/" | awk '{print $2}'

curl https://github.com/Shift3/laptop/blob/master/setup > setup.sh
#./setup.sh
```

### Installing circleci cli
https://circleci.com/docs/local-cli

Make sure you have the laptop script installed and Docker is already installed. Circleci cli uses docker to build.

https://circleci.com/docs/local-cli#configuring-the-cli
`circleci setup`

https://circleci.com/docs/local-cli#validate-a-circleci-config
`circleci config validate`

#### Using/testing Circleci scripts from command line
* Using the command line on your local machine does NOT incur cost.
* Lets you test out scripts before it hits Circleci.
https://circleci.com/docs/how-to-use-the-circleci-local-cli#running-a-job
`circleci local execute --job build`


## Post Workshop Takeaways
Everyone here should be able to run a bash script.  
They should also be able to run a CircleCI Script locally.
