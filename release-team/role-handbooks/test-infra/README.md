# Test Infra Lead Playbook

## Overview of Test Infra Lead responsibilities

Note: Currently, the test-infra lead has to be someone from Google GKE Engprod Team, in order to gain access to the prow cluster. This
will change once we migrate our testing infrastructure under CNCF account. (xref kubernetes/test-infra#5085)

There are two major area that test-infra lead need to take care during the release cycle, which are:

1. Create CI/Presubmit jobs for the new release, and populate the testgrid dashboard

1. Watch for test infra status, make sure test infra is stable, react to test infra related issues and notify Release Lead and CI Signal Lead of issue status changes

It's important to ensure the stability of our test infra during the release cycle, so that we can get reliable testing signals throughout the release cycle.

You can also work with @kubernetes/test-infra-maintainers or [test infra oncall](https://go.k8s.io/oncall) if you are blocked by anything.

Also feel free to ping #sig-testing and #testing-ops to reach out for help.

### Create CI/Presubmit jobs for the new release

This step should happen in week 6-7, when we create the new release branch.

Most of the release blocking jobs are named with -beta|-stableX, which are mapped to our [release channels](https://github.com/kubernetes/test-infra#release-branch-jobs--image-validation-jobs).

Note that this section reflects the status of the world today, we are actively looking for simplify the process.

1. Bump build job branches for the [k8s build jobs](https://github.com/kubernetes/test-infra/blob/master/config/jobs/kubernetes/sig-release/kubernetes-builds.yaml)

1. Create kubekins images for the new release, add a new release target in the [kubekins Makefile](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e/Makefile)

1. Update release version in the [image bump script](https://github.com/kubernetes/test-infra/blob/master/experiment/bump_e2e_image.sh) and push new kubekins images by running the script. (Note that the runner need to have access to [k8s-testimages](https://pantheon.corp.google.com/home/dashboard?project=k8s-testimages) gcp project)

1. Similarly, make a new Dockerfile for [kubekins-test](https://github.com/kubernetes/test-infra/tree/master/images/kubekins-test) image, this is the image we used for our integration and verify jobs. Also bump the image tags in the [kuberketes_verify scenario](https://github.com/kubernetes/test-infra/blob/master/scenarios/kubernetes_verify.py)

1. grep for `manual-release-bump-required` under [test-infra](https://github.com/kubernetes/test-infra), those are the jobs that need to be manually bumped per release cycle, remap them to the up-to-date branches. Similar to 2, Fork a new version of kubernetes/kubernetes presubmit job, and remove references to the older branches.

1. Okay, now let's update the testgrid config. It's a manual work now, basically you want to find dashboard tabs for release-1.x, and bump that, and the jobs inside, to release-1.(x+1)

1. Finally, update the [release target section](https://github.com/kubernetes/test-infra#release-branch-jobs--image-validation-jobs)

Not all the steps need to happen together, some new jobs, like bazel-build/integration/verify will require images to be pushed before they can work properly. 


### Ensure the stability of test infra

During the release cycle, especially inside the code freeze, the test infra lead need to actively watch for

1. If the presubmit/CI is failing due to test infra issues (do some initial triage with CI Signal Lead)

1. If PRs are merging into master/release branches

We record test-infra commit SHAs in each testgrid tab, and if CI starts to fail between two test-infra commits,
test infra lead can diff the SHAs to triage if the failure is caused by a test-infra change.  

The [velodrome monitoring dashboard](http://velodrome.k8s.io/dashboard/db/monitoring?orgId=1) will be your good friends.

## Useful Links

[Test Infra Home Page](https://github.com/kubernetes/test-infra)

[Prow Home Page](https://prow.k8s.io)
