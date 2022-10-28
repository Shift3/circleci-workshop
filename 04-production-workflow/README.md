# Production Workflow
From [Red Hat](https://www.redhat.com/en/topics/devops/what-is-ci-cd#continuous-deployment): 


The final stage of a mature CI/CD pipeline is continuous deployment. As an extension of continuous delivery, which automates the release of a production-ready build to a code repository, continuous deployment automates releasing an app to production. Because there is no manual gate at the stage of the pipeline before production, continuous deployment **relies heavily on well-designed test automation**.

In practice, continuous deployment means that a developer’s change to a cloud application could go live within minutes of writing it (assuming it passes automated testing). This makes it much easier to continuously receive and incorporate user feedback. Taken together, all of these connected CI/CD practices make deployment of an application less risky, whereby it’s easier to release changes to apps in small pieces, rather than all at once. There’s also a lot of upfront investment, though, since automated tests will need to be written to accommodate a variety of testing and release stages in the CI/CD pipeline.

In order for a production workflow to be successful, it needs two things:
1. The infrastructure to deploy the code (IE Terraform/AWS)
2. A working build and test workflow.

Production workflows are highly dependent upon what tools developers are using to deploy the application and what existing infrastructure is available to them.

## Best practices regarding Production/Deploy Workflows
Circleci has documentation on how to deploy using AWS and an existing app: https://circleci.com/docs/deploy-to-aws/ we will go through this briefly. There are many different ways to deploy, so the rule of thumb is to match the current infrastructure the developers are using. 

Don't commit keys or API tokens when creating your production workflow.

Take a look at [branching standards](https://github.com/Shift3/standards-and-practices/blob/main/standards/branching.md#branch-structure) in our S&P repo.
Branching helps both developers and devops in knowing what is being deployed as well as triggering deployments. 

In general, the `main` branch will contain whats in production, `development` will contain any sandboxed code, and `staging` will contain a feature that is client specific (or just staging deployment). This may not be universal throughout  all projects so you should ask to make sure before setting up the deployment.

## Looking at Existing Production Workflows
1. [React Boilerplate](https://github.com/Shift3/boilerplate-client-react)
2. [Node Boilerplate](https://github.com/Shift3/boilerplate-server-node)
3. [Django Boilerplate](https://github.com/Shift3/dj-starter)
4. [kidskare-api](https://github.com/Shift3/kidskare-api/blob/development/.circleci/config.yml)
5. [kidscare-admin](https://github.com/Shift3/kidskare-admin/blob/development/.circleci/config.yml)
6. [porterville-cms-client](https://github.com/Shift3/porterville-cms-client)
7. [porterville-cms-server](https://github.com/Shift3/porterville-cms-server)


## Creating a Deploy Workflow
In our last workshop, we created a test workflow. In this workshop, we shall modify it and create a deploy workflow to run alongside the build and test workflows. Because of cost, this will not go out to our sandbox just yet. We will again be adding more Quality of life changes to the existing workflows in order to both speed up our overall script and to utilize CircleCI specific features.

1. Add the following job after the test job to your `.circleci/config.yml`:
```
  deploy:
    docker: # Specify executor for running deploy job
        - image: <docker-image-name-tag> # Specify docker image to use
          auth:
            username: mydockerhub-user
            password: $DOCKERHUB_PASSWORD  # context / project UI env-var reference
    steps:
        - run: # Install the AWS CLI if it is not already included in the docker image
            name: Install awscli
            command: sudo pip install awscli
        - run: # Deploy to S3 using the sync command
            name: Deploy to S3
            command: aws s3 sync <path/to/bucket> <s3://location/in/S3-to-deploy-to>
```
2. Create a deploy workflow by copy/pasting everything from `build:` to `npm run build` on the steps.
3. At the end of the file, navigate to the end of the file to `workflows` -> `builds` -> `jobs`, add `- deploy` to the last line.
4. Verify your version of the circleci script is runnable via `circleci config validate`. You should get a `Config file at .circleci/config.yml is valid.` message.

### Advanced Workflows

#### Filters and Development 

In a normal everyday life of a developer, three branches are usually used to denote state within a project. 
The `main` branch will usually contain production code thats made its way to the client. 
The `development` branch will usually contain a sandbox that will be used for internal demos and easy to spin up/tear down environments. Usually its short lived as well. 
The `staging` branch is typically used for QA or other teams to take a look at a semi-stable environment that is still safe to tear down. 

In order to be useful, your CI/CD scripts should always attempt to follow the development cycle of our developers. The build/test/deploy process will be much easier to follow along and deploy the correct versions of applications in that manner. 

We want the script to do the following:
1. Separate the PRs that do NOT need to be deployed and run the build/test jobs (So they can get near instant feedback on the components they are adding/removing). 
2. Only run the `deploy` job when the `main` branch is updated.

CircleCI allows us to `filter` an action based on what branch it is running under. See here for more info: https://circleci.com/docs/configuration-reference/#jobfilters 

You can also use git tags to deploy: https://circleci.com/docs/workflows/#executing-workflows-for-a-git-tag

Filters only work on jobs so you will have to add the filter to all jobs within a certain workflow. If you know of a wa to make this easier, let me know!

For our example, we want to separate our main branch behavior (IE deploying the project only when the main branch is updated) from normal every-day behavior (build and test jobs). To do this:
1. Copy/Paste the `build-and-test` workflow to the last line of the `config.yml` file.
2. Create a new workflow by modifying our new `build-and-test` to `build-test-deploy`.
3. Create a filter on the build workflow by replacing `- build` with:
```yml
      - build:
          filters:
            branches:
              only:
                - main
```
3. Create a filter on the test workflow by replacing `- test:` with:
```yml
      - test:
          filters:
            branches:
              only:
                - main
```
4. Create a filter on the deploy workflow:
```yml
      - deploy:
          filters:
            branches:
              only:
                - main
```
run `circleci config validate` to make sure it works. 

Your workflows should look like the following: 
```yml
workflows:
  version: 2
  build-and-test:
    jobs:
      - build
      - test
  build-test-deploy:
    jobs:
      - build:
          filters:
            branches:
              only:
                - main
      - test:
          filters:
            branches:
              only:
                - main
      - deploy:
          filters:
            branches:
              only:
                - main
```
Double check your work with `circleci config validate`

Unfortunately, CircleCI CLI does not allow us to run the workflow like its in `main`, so we will have to "test" by looking at a few examples within CircleCI itself. See *Looking at Existing Production Workflows* for more examples.

#### Sequential Jobs

For deployments, developers will want to make sure certain actions in a certain order. The most common is to make sure the application can build before it gets tested. And that the application is tested before it gets deployed. CircleCI can accommodate this using the `requires` tag. Note, when doing sequential jobs, the time the workflow is active can increase, sometimes incurring cost.

On our build-and-test workflow, modify to match the following: 
```yml
  build-and-test:
    jobs:
      - build
      - test:
          requires:
            - build
```

If you run the circleci workflow, you will [see something different](https://app.circleci.com/pipelines/github/Shift3/circleci-workshop/46/workflows/558572c5-b6fe-42d3-bc86-60de0a209a0d) than our last couple of workshops. Instead of the build and test jobs doing the same operation at the same time in parallel, now the jobs are both sequential. The build job MUST be successful before the test job is run. 

While this is useful for debugging with developers day-to-day operations, thse operations are required when doing our deployment workflows. When a deployment occurs, the application should be able to build and test itself before pushing to production. By adding Sequential jobs, we ca make sure the application can at least run its build and test jobs before hitting production, reducing the number of bugs overall. It can also be useful when merging from many different developers (it scales). 

Please make the following change to the `build-test-deploy` workflow near the bottom of the config.yml file:
```yml
  build-test-deploy:
    jobs:
      - build:
          filters:
            branches:
              only:
                - main
      - test:
          requires:
            - build
          filters:
            branches:
              only:
                - main
      - deploy:
          requires:
            - test
          filters:
            branches:
              only:
                - main
```

## Assignment
1. Take a look at the node boilerplate and how its deployed.
2. Come prepared to answer the following questions in our next workshop:

   * What are we caching and why are we caching those resources?
   * What tools are we using to deploy the project?
   * How can we improve our current deployment process?
   * What is the first step in finding out how to deploy a new project from scratch (IE without a pre-made deploy script/process)?

Extra credit:
1. Fork the [node boilerplate](https://github.com/Shift3/boilerplate-server-node).
2. Rename the project to yourname-node-boilerplate
3. Create the infrastructure using our existing terraform and our deploy script.
