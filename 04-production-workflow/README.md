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
    deploy_application:
      jobs:
        - aws-code-deploy/deploy:
            application-name: myApplication
            bundle-bucket: myApplicationS3Bucket
            bundle-key: myS3BucketKey
            deployment-group: myDeploymentGroup
            service-role-arn: myDeploymentGroupRoleARN
```
2. Create a test workflow by copy/pasting everything from `build:` to `npm run build` on the steps.
3. On the workflows, modify your workflow name `builds` to `build-and-test`.
4. At the end of the file, navigate to the end of the file to `workflows` -> `builds` -> `jobs`, add `- test` to the last line.
5. Verify your version of the circleci script is runnable via `circleci config validate`. You should get a `Config file at .circleci/config.yml is valid.` message.
6. Try and run your new workflow via `circleci local execute --job test`. It should be successful.


### Modify Test workflow to test the application

Take a look at the sample-app/README.md file. The README tells us how our developers are testing their application. We should always try and match how our developers test their app with the CircleCI script to give them the most value out of their CI/CD processes.

Lets modify our test workflow to more accurately mirror what is in the README.

1. Within test job, lets change the last line: `npm run build` to `npm test`.
2. Run via `circleci local execute --job test`
3. As it turns out, npm test will get stuck in "watch mode" AKA looking for changes for the developer. Since we have no way of interacting with a CI/CD script, we will need to make a workaround. Luckily the npm test script [has a workaround](https://create-react-app.dev/docs/running-tests/#linux-macos-bash) already built in. Modify the last line again to `CI=true npm test`.
4. Application should run correctly.


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
