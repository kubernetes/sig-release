# Post-RC.0 release tasks

This document details the tasks that need to be executed after cutting an rc.0 (release candidate 0) for a Kubernetes release. These tasks ensure proper configuration for the new release branch and testing infrastructure.
They must be executed after the nomock release stage is completed, and the release branch is created, as stated in the [release branch creation chapter](../role-handbooks/branch-manager.md#release-branch-creation) of the branch management handbook.

Alternatively you can do the work beforehead but you got to remember to put a `/hold` on all the PRs, they have to be lifted only once the nomock release phase is done and the branch is created.

> [!WARNING]
It is essential to follow these steps to maintain the integrity of the release process and ensure that all necessary components are updated accordingly, the examples provided are for illustrative purposes and need to be adapted to the specific release version, so please replace `1.30`, `1.33` and `1.34` with the actual version(s) you are deprecating, currently working on or preparing grounds for.

## Checklist

Open a new issue using [this template](https://github.com/kubernetes/sig-release/issues/new?template=post-rc-zero.md).

### Remove EOL version jobs from test-infra (optional)

Consider removing jobs for versions that are going EOL. This is sometimes done before adding new jobs to avoid overwhelming the Prow cluster.

```bash
# Example PR: https://github.com/kubernetes/test-infra/pull/34674
# Changes would involve removing the EOL version from: images/kubekins-e2e-v2/variants.yaml

# Diff example:

- '1.30':
-    CONFIG: '1.30'
-    GO_VERSION: 1.23.6
-    K8S_RELEASE: latest-1.30
-    BAZEL_VERSION: 3.4.1
```

> [!NOTE]
Note: This step may alternatively be performed as part of a patch release process. Consult with the release engineering team and test-infra people regarding the timing of this step.

### Update milestone applier rules and check milestone requirements

Create a PR to update the milestone applier rules to include the new version and remove the oldest version.

```yaml
# Example PR: https://github.com/kubernetes/test-infra/pull/34650
# Edit this file: config/prow/plugins.yaml

# Add the new version and remove the oldest version in the kubernetes/kubernetes section:
milestone_applier:
  kubernetes/kubernetes:
    master: v1.33
    release-1.33: v1.33
    release-1.32: v1.32
    ...
    # remove oldest version (e.g., release-1.29: v1.29)
```

Check that the milestone requirements include the newest release branch.

> [!NOTE]
If the [code freeze](#code-freeze) was enabled before creating the release branch, which is usually the case, there's nothing to do, as the milestone requirements include the newest release branch already.

```bash
# Example PR: https://github.com/kubernetes/test-infra/pull/35171
# Changes would involve the new branch and code freeze: config/prow/config.yaml

# Diff example:


+    excludedBranches:
+      - master
+      - release-1.34
+    labels:
+      - lgtm
+      - approved
+      - "cncf-cla: yes"
+    missingLabels:
+      - do-not-merge
+      - do-not-merge/blocked-paths
+      - do-not-merge/cherry-pick-not-approved
+      - do-not-merge/contains-merge-commits
+      - do-not-merge/hold
+      - do-not-merge/invalid-commit-message
+      - do-not-merge/invalid-owners-file
+      - do-not-merge/needs-kind
+      - do-not-merge/needs-sig
+      - do-not-merge/release-note-label-needed
+      - do-not-merge/work-in-progress
+      - needs-rebase
+  - repos:
+      - kubernetes/kubernetes
+    milestone: v1.34
+    includedBranches:
+      - master
+      - release-1.34
```

### Update Kubekins-e2e

Create a PR to update the kubekins-e2e `variants.yaml` file with the new version's configuration.

> [!WARNING]
Remember to use the appropriate (updated) Go version for the release, coordinate with #release-management and @release-managers to ensure the correct version is used.

```yaml
# Example PR: https://github.com/kubernetes/test-infra/pull/34651
# Edit this file: images/kubekins-e2e-v2/variants.yaml

# Add the new version configuration as follows:
variants:
  '1.34':
    CONFIG: '1.34'
    GO_VERSION: 1.24.5  # Use appropriate Go version for the release
    K8S_RELEASE: latest-1.34
    BAZEL_VERSION: 3.4.1
```

Wait for the `test-infra-push-kubekins-e2e` presubmit to finish. You can [check on prow](https://prow.k8s.io/?job=post-test-infra-push-kubekins-e2e).

Note: Consider what has been pointed out in [this issue](https://github.com/kubernetes/test-infra/issues/34675).

### Update test-infra jobs for the new release

Updating the test-infra jobs for the new release version involves some steps:

First of all you need to modify the `releng/test_config.yaml` file to:
- Update version references
- Rotate job configurations (n -> n+1)
- Add new version as beta
- Update stable versions sequentially
- Update configuration for all test suites

> [!NOTE]
Just shift "args" but not touch interval, sigowners or any other field.
Remember that args are bound to a set of tests for a specific release, while intervals and everything else is bound to a release "status": stable1/2/3/4 or beta. An example of how to correctly rotate the jobs can be found [here](https://github.com/kubernetes/test-infra/pull/34668/commits/819c9d253ab873aff6626a5eaf7635560f7b769e).

The docs related to these steps are available in the [test-infra releng README](https://github.com/kubernetes/test-infra/blob/master/releng/README.md).
Below is a more verbose breakdown of the steps.

#### Create the release dashboards

After running the make command you can now update the [release dashboards](https://github.com/kubernetes/test-infra/blob/master/config/testgrids/kubernetes/sig-release/config.yaml), example [commit](https://github.com/kubernetes/test-infra/commit/31fb8f2b5c4458af675e37765dfebd128da19971), remembering to:

- Remove the deprecated release sig-release-1.30-{blocking,informing} dashboards
- Add the new dashboards for the current release e.g., sig-release-1.34-{blocking,informing}

#### Run test generation script

After updating the configurations you can run the following command from the root of your `test-infra` fork to generate the updated test configurations, remember to use the correct architecture and OS for your environment, e.g., `GOARCH=arm64 GOOS=darwin` for macOS on ARM:

```bash
GOARCH=arm64 GOOS=darwin make -C releng prepare-release-branch
```

Breaking down what the above command does:

- Navigates to the releng directory (-C releng)
- Executes the `prepare-release-branch target` from the `Makefile` in that directory
- Ensures Python 3 requirements are installed
- Executes the `run.sh` script in the releng directory, passing `prepare-release-branch` as an argument
- Sets error handling (errexit, nounset, pipefail)
- Determines the repository root directory
- Sources Go setup script `setup-go.sh`
- Builds the binary and stores them in the `_bin` directory
- Runs `config-rotator`
- Runs `config-forker`
- Runs the Python script `prepare_release_branch.py` inside a Python container
- Passes the built tools and another Python script `generate_tests.py` as arguments to the main script

#### Submit the test-infra jobs PR

You can finally issue a new PR as [this example](https://github.com/kubernetes/test-infra/pull/34668) one.

Additionally update/check the following scripts, if you've found any issues with them:
- `hack/run-in-python-container.sh`
- `releng/run.sh`
- `releng/prepare_release_branch.py`

### Add new variant for kube-cross image

> [!Note]
This work on the kube-cross image could have been done as part of the Golang bumps, but it is worth mentioning here as it is a common step.

Before updating the builder images, you need to update the kube-cross image which they depend on:

1. Create a PR to update the kube-cross variants.yaml file:
   - Edit [images/build/cross/variants.yaml](https://github.com/kubernetes/release/blob/master/images/build/cross/variants.yaml)
   - Add a new variant with the appropriate Go version for the current release
   - Update the [dependencies.yaml](https://github.com/kubernetes/release/blob/master/dependencies.yaml) file

   Example PR: https://github.com/kubernetes/release/pull/3870/files

   You should also edit the dependencies.yaml to bump to the stable version and the next candidate to the n+1 version of Kubernetes.

    ```yaml
     - name: "Kubernetes version (stable.0)" # Update after the stable marker has been updated to stable.0
       version: v1.34.0
       refPaths:
         - path: images/build/cross/Makefile
           match: KUBERNETES_VERSION\ \?=\ v((([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)
         - path: images/build/cross/variants.yaml
           match: "KUBERNETES_VERSION: 'v((([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)'"

     # Update after the stable marker has been updated to stable.0
     - name: "Kubernetes version (next candidate.0)"
      version: v1.35.0
       refPaths:
         - path: images/build/cross/variants.yaml
           match: "KUBERNETES_VERSION: 'v((([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)'"
    ```

2. Wait for the Prow job to complete:
   - Monitor the [post-release-push-image-kube-cross](https://prow.k8s.io/view/gs/kubernetes-jenkins/logs/post-release-push-image-kube-cross) job

3. Create an image promotion PR:
   - This promotes the image from staging to production
   - Example PR: https://github.com/kubernetes/k8s.io/pull/8307/files

### Update k8s-cloud-builder and k8s-ci-builder

> [!Note]
Part of this work on k8s-cloud-builder and k8s-ci-builder could have been done as part of the Golang bumps, but it is worth mentioning here as it is a common step.
In any case you should always update the k8s-cloud-builder and k8s-ci-builder images to use the new kube-cross image.

#### Update k8s-cloud-builder image

Once the kube-cross image is available:

1. Create a PR to update the k8s-cloud-builder variants.yaml file:
   - Edit [images/k8s-cloud-builder/variants.yaml](https://github.com/kubernetes/release/blob/master/images/k8s-cloud-builder/variants.yaml)
   - Add a new variant that references the new kube-cross image

   ```yaml
   v1.XX-cross1.XX.Y-Z: # Example addition to variants.yaml
    CONFIG: 'cross1.XX'
    KUBE_CROSS_VERSION: 'v1.XX.y-go1.XX.Y-Z' # Match with the kube-cross image you created
   ```

2. Submit your PR and wait for review and merge
   - Example PR (that also included the k8s-ci-builder Image update): https://github.com/kubernetes/release/pull/4065/files

3. Monitor the build job in Prow:
   - After merge, the image will be automatically built

#### Update k8s-ci-builder image

The k8s-ci-builder needs to be updated in a similar fashion:

1. Create a PR to update the k8s-ci-builder variants.yaml file:
   - Edit [images/releng/k8s-ci-builder/variants.yaml](https://github.com/kubernetes/release/blob/master/images/releng/k8s-ci-builder/variants.yaml)
   - Add a new variant with the appropriate Go version that matches the release

   ```yaml
  '1.34':
    CONFIG: '1.34'
    GO_VERSION: '1.24.5'
    GO_VERSION_TOOLING: '1.24.5'
    OS_CODENAME: 'bullseye'
   ```

2. This can be included in the same PR as the k8s-cloud-builder update
   - If submitted separately, follow the same process as the k8s-cloud-builder update.


After all the above PRs are merged and prow jobs are successful, you can verify the images were built successfully:

   ```bash
   # Check the kube-cross image
   gcloud container images list-tags gcr.io/k8s-staging-build-image/kube-cross

   # Check the k8s-cloud-builder image
   gcloud container images list-tags gcr.io/k8s-staging-releng/k8s-cloud-builder

   # Check the k8s-ci-builder image
   gcloud container images list-tags gcr.io/k8s-staging-releng/k8s-ci-builder
   ```

### Update k8s references for kube-cross image

Once the new builder images are available:

Create a PR in kubernetes/kubernetes to reference the new kube-cross image in `build/build-image/cross/VERSION`:
   - Example PR: https://github.com/kubernetes/kubernetes/pull/132897/files

### Update publishing bot rules

The Kubernetes Publishing Bot is responsible for:
- ensuring that the master and release branches in the staging repositories are in-sync with the appropriate branches in `kubernetes/kubernetes`
- creating tags in the staging repositories for each Kubernetes release

Update the publishing bot rules to include the new version. Use the update-rules CLI tool to generate the necessary changes as described [here](https://github.com/kubernetes/publishing-bot/blob/master/cmd/update-rules/README.md).

You can install the tool on Linux with a simple `make build` command, similarly on MacOS by specifying your OS `GOOS=darwin make build`.
By default the binary will be located in `_output/update-rules`.

You can also use the Docker image to run the tool, which is useful if you don't want to build it locally (but you can also do that with make `make build-image`). The live Docker image is available at `gcr.io/k8s-staging-publishing-bot/publishing-bot:latest` and you can invoke the tool as follows:

```bash
docker run -t gcr.io/k8s-staging-publishing-bot/publishing-bot:latest /update-rules -branch release-1.34 -go 1.24.5 -rules ~/kubernetes/staging/publishing/rules.yaml -o /tmp/rules.yaml
```

Recommended to set the release branch and the Go version as environment variables before running the command:

```bash
 # set release branch
 export K8S_REL_BRANCH=release-1.34
 # https://github.com/kubernetes/release/blob/master/images/build/cross/variants.yaml#L7
 export GO_VERSION=1.24.5
```

> [!WARNING]
Remember to use the appropriate (updated) Go version for the release, coordinate with #release-management or @release-managers to ensure the correct version is used.

Basically you need to run the following command after having the `update-rules` tool installed.

```bash
_output/update-rules -branch ${K8S_REL_BRANCH} -go ${GO_VERSION} -rules ~/kubernetes/staging/publishing/rules.yaml -o /tmp/rules.yaml
```

Or, if you need to manually edit the rules file, you can do so, as follows:

```yaml
# Example PR: https://github.com/kubernetes/kubernetes/pull/131250
# Edit this file: staging/publishing/rules.yaml

# Repeat this new section for each repository following this pattern:
- name: release-1.34
  go: 1.24.5 # Remember to use the appropriate Go version for the release
  dependencies:
  - repository: apimachinery
    branch: release-1.34
  - repository: api
    branch: release-1.34
  source:
    branch: release-1.34
    dirs:
    - staging/src/k8s.io/[repository-name]
```

Once the rules are updated you can submit a PR similar to [this one](https://github.com/kubernetes/kubernetes/pull/131250), to the publishing-bot repository.

### Create Performance Tests Branch

Ensure a performance tests branch is created for the new version:

```bash
# Example: https://github.com/kubernetes/perf-tests/issues/3290

# A maintainer of the perf-tests repository should create:
https://github.com/kubernetes/perf-tests/tree/release-1.34

# Verify the branch is working in CI:
https://prow.k8s.io/view/gs/kubernetes-ci-logs/logs/ci-kubernetes-kubemark-500-gce-1-34
```

Reach out to SIG Scalability to ensure a new branch is cut in the [sigs.k8s.io/perf-tests](https://github.com/kubernetes/perf-tests/) repo. 

### Cut next alpha

Recall that an alpha.0 of the next minor release was created during the rc.0 cut?

To assist downstream consumers of Kubernetes, a new alpha should be cut to bring our next release tag to the tip of `master`.

Begin the release process following the [release cut handbook](k8s-release-cut.md) following the instructions tailored for alpha releases.

### Check and eventually improve release scripts (optional)

If needed, fix error messages or anomalies found in any of the release scripts you've run during the post-rc.0 tasks.

```bash
# Example: Fixing line 307 of this script:
# http://github.com/kubernetes/release/blob/9a9572f7c48f637de8499a201fb8e3ff52f8d4ba/pkg/gcp/gcb/gcb.go#L307

# This would help avoid having a "release job" message for nomock stage commands
```

Generally speaking, update scripts and documentation as needed to ensure they are up-to-date and reflect the current release process.

## Additional Resources

- [Branch Creation Handbook](http://bit.ly/relmanagers-handbook#release-branch-creation)
- [Release Manager Handbook](http://bit.ly/relmanagers-handbook)
- [Example RC.0 Release Cut Issue](https://github.com/kubernetes/sig-release/issues/2755)
- [Slack Discussion Thread for 1.33.0-rc.0](https://kubernetes.slack.com/archives/CJH2GBF7Y/p1744125003875769) - _do not rely on the Slack thread being long lived, if it got archived or the channel got deleted, you should just rely on the docs and the PRs linked in this document_

## Notes

- The order of operations is important. Generally, update configuration files first, then generate tests, then create necessary branches.
- Some tasks may be release-specific. Always check with the rest of release engineering and inform the release team if you're unsure about any step.
- After completing these tasks, verify that CI jobs are running properly for the new release branch and that the dashboards reflect the new version.

---

TODO use these too https://hackmd.io/@jimangel/BJMUW6z01g
TODO delete the parts of the handbook that are for post-rc0 release tasks as now this document is the handbook for that. Avoid duplication.