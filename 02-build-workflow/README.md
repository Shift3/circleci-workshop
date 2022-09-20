# Build Workflow

The build workflow is arguably the most important part of the ci/cd pipeline. Without a buildable project, developers can't reliably build the application, DevOps cannot deploy the project, and we will have very little in the way of confidence in the application. Some projects will come with a well defined build process and need help creating a ci/cd script around it while some may come to us with no defined process other than 

## Workflows Basics
Terms:

* Workflows - A set of rules defining how jobs (such as build, test, deploy) are run,
giving teams granular control over their software development process.

* Jobs - A collection of steps and an execution environment to run them in.

* Step - An executable command

Example Stemtaught: https://github.com/Shift3/stemtaught-client/blob/development/.circleci/config.yml

Workflows: 

* `build_and_test` contains a job called `test`. The `test` job includes several steps (Actual code being run on the container). 
* `deploy` contains multiple jobs `test` (same as above), `deploy-qa`, and `deploy-staging`. 
The deploy workflow has multiple steps. It will check to see if the test job is successful, then move on with the `deploy-qa` and `deploy-staging` jobs. 

You can reuse jobs within workflows. Its a DRY (dont repeat yourself) way of keeping similar commands together. 

Within CircleCI, workflows are typically at the bottom of the script, orchestrating the overall ci/cd processes.

While most projects (like the above) may combine workflows, they usually have the same three kind of operations: `build`, `test`, and `deploy`. In the example above, they contained the `build` and `test` workflows together, which is fine.

## React App - Build Workflow

We have provided a sample react app that will be the basis of this workshop. Please take a look now at the app and pay special attention to the [README](sample-app/README.md).

Imagine for a moment, a developer team came to us and asked us to create a circleci script from this project. They want to be able to make sure the application can build before tey start on any major features. This will allow the team to be confidenct their new libraries that they are planning on implementing will not break the application in any meaningful way. 

Steps to follow: 
1. Create a .circleci/config.yml file at the root folder of the repo.
2. Create a `build` workflow. Hint: we already did this within our `01-hello-world` applciation.
3. Read the [README](sample-app/README.md) within the sample-app to see how the project is able to build.
4. Create steps that follow the same instructions within the README. 
5. Run circelci manually within your own machine.
6. Commit your code and see if it ran correctly.

DONT LOOK AT THE SOLUTION UNTIL YOU HAVE DONE THE ABOVE!

Solution: 
TODO: Circleci script within folder called `solutions`.


## Parallel Build Workflows
If you ever want to test multiple versions of the same 