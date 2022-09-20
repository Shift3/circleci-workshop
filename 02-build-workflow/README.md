# Hello World as a CircleCI Job

Instructions and explanation is within:
[Hello world on Linux](https://circleci.com/docs/2.0/hello-world/?utm_source=google&utm_medium=sem&utm_campaign=sem-google-dg--uscan-en-dsa-maxConv-auth-brand&utm_term=g_b-_c__dsa_&utm_content=&gclid=CjwKCAiAp8iMBhAqEiwAJb94zy516NI__4wuPB8LvOn_hhOEKtu2iOy7uJcq1x7GpAueNrexbRlXzRoC7RcQAvD_BwE#echo-hello-world-on-linux)

This example adds a job called build that spins up a container running a pre-built CircleCI Docker image for Node
. Then, it runs a simple echo command. To get started, complete the following steps:

    Create a directory called .circleci in the root directory of your local GitHub or Bitbucket code repository.
    Create a config.yml
    file with the following lines (if you are using CircleCI server v2.x, use version: 2.0 configuration):
```
    version: 2.1
    jobs:
      build:
        docker:
          - image: cimg/node:14.10.1 # the primary container, where your job's commands are run
            auth:
              username: mydockerhub-user
              password: $DOCKERHUB_PASSWORD  # context / project UI env-var reference
        steps:
          - checkout # check out the code in the project directory
          - run: echo "hello world" # run the `echo` command
```
    Commit and push the changes.

    Go to the Projects page in the CircleCI app, then click the Set Up Project button next to your project. If you don’t see your project, make sure you have selected the associated Org. See the Org Switching section below for tips.
    Follow the steps to configure your config.yml file for the project and trigger your first build.

The Workflows page appears with your build job and prints Hello World to the console.

Note: If you get a No Config Found error, it may be that you used .yaml file extension. Be sure to use .yml file extension to resolve this error.

CircleCI runs each job in a separate container or VM. That is, each time your job runs, CircleCI spins up a container or VM to run the job in.