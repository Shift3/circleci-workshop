# circleci-workshop
Bitwise Consulting - Circleci Workshop

This workshop will focus on the basics behind Continuous Integration within [CircleCI](https://circleci.com/docs/2.0/about-circleci/). You will gain the
skills to use and apply workflows to automate the three most common workflows within the development process. This will enable teams to find problems and solve them, quickly.

## Skill Level

This workshop will be presenting fundamentals.

- [ ] Fundamentals
- [x] Intermediate
- [ ] Advanced

## Prerequisites

- Light Javascript Knowledge (ES6), no typescript knowledge required.
- Knowledge of common bash commands. `cd`, `echo`, `npm`, environment variables, and many others will be discussed.
- Bare minimum you will need node and npm installed.
- Come prepared to do some coding, only your editor of choice and a terminal will be required.

I *highly* recommend using our [Shift3 Laptop setup
scripts](https://github.com/shift3/laptop) which will install nvm as well as
some other helpful tools.


## How to Work on the Exercises

Fork this repo and start with the instructions on `01-hello-world` folder.

Lessons:
01 - Hello world
02 - Build Workflow
03 - Test Workflow
04 - Production Workflow

The exercises are numbered, the first one is `01-hello world`, you will `cd`
into that directory in your terminal and can run the test file at any time.

```bash
# change directory to first exercise
cd 01-hello-world

# make changes to config.yml
code circleci/config.yml
```

Now you can open this folder up in your editor and start the exercise.

- Each lesson will provide an exercise will contain a .circleci/config.yml that will need to be edited to pass the exercise.
- Each lesson (except the last) will contain the solution of the last in case you get stuck. Its highly recommended that you try and work through the exercise and ask for help during the workshop.

## Post Workshop Takeaways
Everyone here should be able to build a CircleCI Script.

Set up a Build, Test, and Deploy workflow and understand the steps in getting there.

Understand each of the commands within the workflow.

Presentation [slides](https://docs.google.com/presentation/d/1k4cb-MnL7nGAMxiUd3FG2FDLAXLR3sm8UbjHJjRQ8pI/edit#slide=id.gcc4f38faa6_0_4)
