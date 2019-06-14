# Test Infra Lead Handbook 
Note: This role was deprecated after the 1.15 release.  Starting with 1.16 this role was mostly merged with [Branch Management](https://github.com/sig-release/blob/updating-test-infra-role-references/release-team/role-handbooks/branch-manager/README.md) 

Note: Currently, the test-infra lead has to be someone from Google GKE Engprod Team, in order to gain access to the prow cluster. This
will change once we migrate our testing infrastructure under CNCF account. (xref kubernetes/test-infra#5085)

There are three major area that test-infra lead need to take care during the release cycle, which are:

1. [Create CI/Presubmit jobs for the new release, and populate the Testgrid dashboard](#create-cipresubmit-jobs-for-the-new-release)

1. [Configure merge automation for code freeze, and thaw](#configure-merge-automation-for-code-freeze-and-thaw)

1. [Watch for test infra status, make sure test infra is stable, react to test infra related issues and notify Release Lead and CI Signal Lead of issue status changes](#ensure-the-stability-of-test-infra)

You can work with @kubernetes/test-infra-maintainers or [test infra oncall](https://go.k8s.io/oncall) if you are blocked by anything.
Also feel free to ping the `#sig-testing` and `#testing-ops` Kubernetes Slack channels to reach out for help.

## Create CI/Presubmit jobs for the new release

This step should happen in week 6-7, when we create the new release branch.

Most of the release blocking jobs are named with -beta|-stableX, which are mapped to our [release channels](https://github.com/kubernetes/test-infra#release-branch-jobs--image-validation-jobs).

Note that this section reflects the status of the world today, we are actively looking for simplify the process.

1. Bump build job branches for the [k8s build jobs](https://github.com/kubernetes/test-infra/blob/master/config/jobs/kubernetes/sig-release/kubernetes-builds.yaml)

1. Create kubekins images for the new release, add a new release target in the [kubekins Makefile](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e/Makefile)

1. Update release version in the [image bump script](https://github.com/kubernetes/test-infra/blob/master/experiment/bump_e2e_image.sh) and push new kubekins images by running the script. (Note that the runner need to have access to [k8s-testimages](https://pantheon.corp.google.com/home/dashboard?project=k8s-testimages) gcp project)

1. Similarly, make a new Dockerfile for [kubekins-test](https://github.com/kubernetes/test-infra/tree/master/images/kubekins-test) image, this is the image we used for our integration and verify jobs. Also bump the image tags in the [kubernetes_verify scenario](https://github.com/kubernetes/test-infra/blob/master/scenarios/kubernetes_verify.py)

1. grep for `manual-release-bump-required` under [test-infra](https://github.com/kubernetes/test-infra), those are the jobs that need to be manually bumped per release cycle, remap them to the up-to-date branches. Similar to 2, Fork a new version of kubernetes/kubernetes presubmit job, and remove references to the older branches.

1. Okay, now let's update the Testgrid config. It's a manual work now, basically you want to find dashboard tabs for release-1.x, and bump that, and the jobs inside, to release-1.(x+1)

1. Finally, update the [release target section](https://github.com/kubernetes/test-infra#release-branch-jobs--image-validation-jobs)

Not all the steps need to happen together, some new jobs, like bazel-build/integration/verify will require images to be pushed before they can work properly. 


## Configure merge automation for code freeze, and thaw

The code freeze and code thaw dates in the release cycle mark points at which merge requirements for PRs in the `master` branch and `release-<current-release-number>` change. The remaining branches are `release-X.X` branches for *previous* releases and are unaffected by the release cycle.

Code freeze is the one phase of the release cycle with additional merge requirements. Code thaw marks the switch back to the development (normal) phase.

### Tide

The tool that we use to automate merges is called [Tide](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/tide#tide). Its configuration lives in [`config.yaml`](https://github.com/kubernetes/test-infra/blob/master/prow/config.yaml). Tide identifies PRs that are mergeable using GitHub queries that correspond to the entries in the `queries` field.
Here is an example of what the query config for `kubernetes/kubernetes` looks like without additional constraints related to the release cycle:

```yaml
  - repos:
    - kubernetes/kubernetes
    labels:
    - lgtm
    - approved
    - "cncf-cla: yes"
    missingLabels:
    - do-not-merge
    - do-not-merge/blocked-paths
    - do-not-merge/cherry-pick-not-approved
    - do-not-merge/hold
    - do-not-merge/invalid-owners-file
    - do-not-merge/release-note-label-needed
    - do-not-merge/work-in-progress
    - needs-kind
    - needs-rebase
    - needs-sig
```

During code freeze we use two queries instead of one for the `kubernetes/kubernetes` repo. One query handles the `master` and current release branches while the other query handles all other branches. The partition is achieved with the `includedBranches` and `excludedBranches` fields.

### Code Freeze

Code freeze is when merge requirements for the `master` and current release branch diverge from the requirements for the other branches so this is when we split the `kubernetes/kubernetes` Tide query into two queries.

We only add additional merge requirements for PRs to these two branches for code freeze:
- PRs must be in the GitHub milestone for the current release (e.g. `v1.14`).
- PRs must have the `priority/critical-urgent` label.

Milestone requirements are configured by adding `milestone: foo` to a query config.

The label requirement is configured by adding `priority/critical-urgent` to the list specified by the `labels` field.

```yaml
  - repos:
    - kubernetes/kubernetes
    milestone: v1.14
    includedBranches:
    - master
    - release-1.14
    labels:
    - lgtm
    - approved
    - priority/critical-urgent
    - "cncf-cla: yes"
    missingLabels:
      # as above...
  - repos:
    - kubernetes/kubernetes
    excludedBranches:
    - master
    - release-1.14
    labels:
    - lgtm
    - approved
    - "cncf-cla: yes"
    missingLabels:
      # as above...
```

### Code Thaw

Code thaw removes the release cycle merge restrictions and replaces the two queries with a single one. We remain in this state until the next code freeze.

```yaml
  - repos:
    - kubernetes/kubernetes
    labels:
    - lgtm
    - approved
    - "cncf-cla: yes"
    missingLabels:
      # as above...
```

## Ensure the stability of test infra

During the release cycle, especially inside the code freeze, the test infra lead need to actively watch for

1. If the presubmit/CI is failing due to test infra issues (do some initial triage with CI Signal Lead)

1. If Tide is merging PRs into the master and release branches

We record test-infra commit SHAs in each Testgrid tab, and if CI starts to fail between two test-infra commits, test infra lead can diff the SHAs to triage if the failure is caused by a test-infra change.

The [velodrome monitoring dashboard](http://velodrome.k8s.io/dashboard/db/monitoring?orgId=1) will be your good friends.

### Monitoring Tide

It is important to monitor Tide after config changes are made for code freeze and thaw to ensure that the changes are having the intended effect.

Until the CNCF infra migration is complete, a member of Google's gke-engprod team will need to monitor Tide logs.
However, most of Tide's behavior can be monitored without access to the cluster. The [Tide dashboard](https://prow.k8s.io/tide) and [Velodrome monitoring dashboard](http://velodrome.k8s.io/dashboard/db/monitoring?orgId=1) provide insight into what Tide is currently doing, how much load it is handling, and how it is performing.

### Test-Infra 'Code Freeze'

The stability of our test infra is critical to getting reliable testing signals throughout the release cycle, but the signal is most important at the end of the release cycle during code freeze. While the `kubernetes/test-infra` repo does not enforce additional merge restrictions related to the release cycle, we do try to limit the changes that are merged. Specifically, during freeze, changes to test-infra should be limited to important fixes and work that doesn't impact critical infrastructure. Large changes should be delayed if possible.
In particular, bumping the kubekins-e2e images should be avoided unless a critical fix in necessary.

## Useful Links

[Test Infra Home Page](https://github.com/kubernetes/test-infra)

[Prow Home Page](https://prow.k8s.io)

[Tide](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/tide#tide)
