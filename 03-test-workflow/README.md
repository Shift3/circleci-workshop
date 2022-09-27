# Test Workflow

The test workflow allows developers to automatically test your code before changes are merged. You can integrate with existing testing tools such as Mocha, pytest, Jest, Selenium, and more. 

When you integrate your tests into your CircleCI pipelines, you not only deliver software to your users more reliably and efficiently, you get feedback more quickly so you can fix issues and failed tests faster. Test output data becomes available in CircleCI to help debug failed tests. If you save your test data in CircleCI, you can also take advantage of the Test Insights as well as parallelism features to identify opportunities to further optimize your pipelines.

Same as the Build workshop, please make sure you have `circleci` and `docker` installed on your local machine. You will be using both to test.
To see if you have both tools, open up your terminal and type: `circleci` and you should see options related to CircleCI pop up. If you do not see this, please install circleci via `brew install circleci`. 

Docker should be installed via the laptop script.

## Creating a Test Workflow
In our last workshop, we created a build workflow. In this workshop, we shall modify it and create a test workflow to run alongside the build workflow. We will also be adding more Quality of life changes to the Build workflow in order to both speed up our workflows in conjunction with one another and to utilize CircleCI specific features that will speed up our CI workflows.

1. copy the following into your `.circleci/config.yml`:
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
      - run:
          name: Build Dependencies and Application
          command: |-
            cd sample-app
            npm install
            npm run build


workflows:
  version: 2
  builds:
    jobs:
      - build
```
2. Create a test workflow by copy/pasting everything from `build:` to `npm run build` on the steps. 
3. On the workflows, modify your workflow name `builds` to `build-and-test`.
4. On the worklow jobs, add `- test` to the last line. 
5. Verify your version of the circleci script is runnable via `circleci config validate`. You should get a `Config file at .circleci/config.yml is valid.` message. 
6. Try and run your new workflow via `circleci local execute --job test`. It should be successful. 


### Modify Test workflow to test the application

Take a look at the sample-app/README.md file. The README tells us how our developers are testing their application. We should always try and match how our developers test their app with the CircleCI script to give them the most value out of their CI/CD processes. 

Lets modify our test workflow to more accurately mirror what is in the README.

1. Within test job, lets change the last line: `npm run build` to `npm test`.
2. Run via `circleci local execute --job test`
3. As it turns out, npm test will get stuck in "watch mode" AKA looking for changes for the developer. Since we have no way of interacting with a CI/CD script, we will need to make a workaround. Luckily the npm test script [has a workaround](https://create-react-app.dev/docs/running-tests/#linux-macos-bash) already built in. Modify the last line again to `CI=true npm test`.
4. Application should run correctly.

## Cleaning up the Workflows
As you may have noticed, adding workflows can add run time to your overall CI/CD orchestration. We want to keep the time down to an absolute minimum if possible. CircleCI has come up with a couple of places that it can save time within the script itself.

### Adding caching to your dependencies
https://circleci.com/docs/caching

Lets say you have two jobs that require the same dependencies within their jobs. Most workflows require the same build process over and over again. CircleCI has provided a way to save those dependencies across multiple builds and even across the same pull request. This can save minutes off of each Pull Request and requires less billable resources overall. It also saves your developers time which is always a huge plus. 

From Circle themselves: 

A cache stores a hierarchy of files under a key. Use the cache to store data that makes your job faster, but, in the case of a cache miss or zero cache restore, the job still runs successfully. For example, you might cache NPM package directories (known as node_modules). The first time your job runs, it downloads all your dependencies, caches them, and (provided your cache is valid) the cache is used to speed up your job the next time it is run.

Caching is about achieving a balance between reliability and getting maximum performance. In general, it is safer to pursue reliability than to risk a corrupted build or to build very quickly using out-of-date dependencies.

To add a cache, simply add:
```
      # look for existing cache and restore if found
      - restore_cache:
          key: v1-deps-{{ checksum "package-lock.json" }}
```
CircleCI will use the key created with the `checksum` to verify if it needs to restore our `node_modules`. If the checksum has not changed, CircleCI will add back in our `node_modules` that we used last time. IF it has changed, it wil not copy over the `node_modules` folder, kicking off another npm install later on. 

If a change has occurred within our package.json file, the system will also save the new `node_modules` via the `save_cache` job. You have the option of specifying many different caches within different applications, so feel free to play around with them. 

Example cache within npm:
```
    steps:
      - checkout: # check out the code in the project directory
          path: ~/repo/
      # look for existing cache and restore if found
      - restore_cache:
          key: v1-deps-{{ checksum "package-lock.json" }}
      # install dependencies    
      - run:
          name: install dependencies
          command: npm install
      # save any changes to the cache
      - save_cache:
          key: v1-deps-{{ checksum "package-lock.json" }}
          paths: 
            - node_modules
```

### Setting working folder and paths

You may have noticed, we use cd simple-app multiple times within our script. This is because CircleCI always assumes we are working in the root folder and we have to navigate to another folder in order to run our scripts. This can become tedious as well as create a small amount of complexity within scripts. While you don't need to set your working directory, its best practice to do so to reduce the number of `cd` commands within your `job`s. 

For our script, right before our build and test jobs, lets setup our working directories:
```
jobs:
  build:
    working_directory: ~/repo/sample-app
```
You can also set up the path that the CircleCI script runs under. This is done via:
```
    steps:
      - checkout: # check out the code in the project directory
          path: ~/repo/
```
With this, we can remove all our `cd` commands from our jobs and still have the same operations occur.

## Assignment
This assignment should take you a couple of hours. It will go over your knowledge of testing a circleci script based on known test instructions. Please reach out if you have any questions.

1. Use your angular app you created in the last exercise. 
2. Add a test workflow to the project. Hint, take a look here: https://angular.io/guide/testing

Extra credit:
1. Create a cache for dependencies.
2. Create a working_directory and remove all `cd` commands.