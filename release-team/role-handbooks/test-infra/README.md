# Test Infra Lead Handbook

There are two major areas that test-infra lead need to take care of during the release cycle, which are:

1. [Create CI/Presubmit jobs for the new release, and populate the Testgrid dashboard](#create-cipresubmit-jobs-for-the-new-release)

1. [Configure merge automation for code freeze, and thaw](#configure-merge-automation-for-code-freeze-and-thaw)

You can work with @kubernetes/test-infra-maintainers or [test infra oncall](https://go.k8s.io/oncall) if you are blocked by anything.
Also feel free to ping the `#sig-testing` and `#testing-ops` Kubernetes Slack channels to reach out for help.

## Create CI/Presubmit jobs for the new release

This step should happen in week 6-7, when we create the new release branch.

1. Update [`images/kubekins-e2e/variants.yaml`](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e/variants.yaml)
   by deleting the oldest entry and copying the `master` block to create an entry
   using the latest version number. Create a PR with this and wait for it to land,
   then wait for the `test-infra-push-kubekins-e2e` presubmit to finish (you can
   [check on prow](https://prow.k8s.io/?job=post-test-infra-push-kubekins-e2e)).
   Pull latest master before continuing.

1. Run `bazel run //experiment:prepare_release_branch`

1. grep for `manual-release-bump-required` under [test-infra](https://github.com/kubernetes/test-infra)
   and duplicate appropriately.

1. Verify that testgrid is in a reasonable state. As of today, this means
   deleting the oldest `sig-release-<version>-{master,informing,all}`
   dashboards and making new `sig-release-<version>-{master,informing,all}`
   ones. You can run `bazel test //testgrid/cmd/configurator/...` to make sure
   you are in a good state.

1. Finally, update the [release target section](https://github.com/kubernetes/test-infra#release-branch-jobs--image-validation-jobs)
   of the README.

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

Milestone requirements are configured by adding `milestone: foo` to a query config.

It is also helpful to remind #sig-testing when code freeze starts so they know
not to do anything too dangerous to the test infrastructure.


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


## Useful Links

[Test Infra Home Page](https://github.com/kubernetes/test-infra)

[Prow Home Page](https://prow.k8s.io)

[PR Status Dashboard](https://prow.k8s.io/pr)

[Tide](https://prow.k8s.io/tide)

[Gubernator PR Dashboard](https://gubernator.k8s.io/pr)

[Velodrome](http://velodrome.k8s.io)

[Code search](https://cs.k8s.io/)

[Devstats](https://k8s.devstats.cncf.io)

[Test Infra oncall](https://go.k8s.io/oncall)

[API Snoop](https://apisnoop.cncf.io)

[TestGrid](https://testgrid.k8s.io/)

[Triage Dashboard](https://storage.googleapis.com/k8s-gubernator/triage/index.html)

[Gubernator Event Dump](http://github-dot-k8s-gubernator.appspot.com/timeline?repo=kubernetes/kubernetes&number=1)

[GCSWeb](http://gcsweb.k8s.io/gcs/test-infra-oncall/)
