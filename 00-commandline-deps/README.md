# Command Line - A primer
Bitwise Consulting - Circleci Workshop

This workshop will focus on the basics behind the command line. For ease of use, we will be assuming you have a Mac OS system provided by Bitwise.

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
### Common commands within CI/CD
1. cat
2. echo
3. cd
4. ssh (with tunnelling included)
5. rsync
6. aws
7. docker
8. ssh-keygen

### Common Building Tools
1. yarn
2. npm
3. make
4. brew (Mac OS)
5. apt (Ubuntu)
6. LOTS of others!
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
