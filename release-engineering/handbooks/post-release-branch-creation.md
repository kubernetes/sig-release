# Post release branch creation

<!-- toc -->
- [Post release branch creation](#post-release-branch-creation)
  - [Checklist](#checklist)
    - [Remove EOL version jobs from test-infra (optional)](#remove-eol-version-jobs-from-test-infra-optional)
    - [Update milestone applier rules and check milestone requirements](#update-milestone-applier-rules-and-check-milestone-requirements)
    - [Update Kubekins-e2e v2 variants](#update-kubekins-e2e-v2-variants)
    - [Update release branch jobs in kubernetes/test-infra for the new release and create the dashboards](#update-release-branch-jobs-in-kubernetestest-infra-for-the-new-release-and-create-the-dashboards)
      - [Configure the release dashboards](#configure-the-release-dashboards)
      - [Run test generation script](#run-test-generation-script)
      - [Submit the PR for release branch jobs and dashboards in kubernetes/test-infra](#submit-the-pr-for-release-branch-jobs-and-dashboards-in-kubernetestest-infra)
    - [Add new variant for kube-cross image](#add-new-variant-for-kube-cross-image)
    - [Update k8s-cloud-builder and k8s-ci-builder](#update-k8s-cloud-builder-and-k8s-ci-builder)
    - [Update `kubernetes/kubernetes` references for the `kube-cross` image](#update-kuberneteskubernetes-references-for-the-kube-cross-image)
    - [Update publishing bot rules](#update-publishing-bot-rules)
    - [Create Performance Tests Branch](#create-performance-tests-branch)
    - [Check and eventually improve release scripts (optional)](#check-and-eventually-improve-release-scripts-optional)
  - [Additional Resources](#additional-resources)
  - [Notes](#notes)

This document details the tasks that need to be executed after cutting a Kubernetes rc.0 release. These tasks ensure proper configuration for the new release branch and testing infrastructure.
They must be executed after the `nomock release` is completed, and the release branch is created, as stated in the [branch creation chapter](k8s-release-cut.md#next-release-branch-creation) of the release cut handbook.

PR can be created beforehand (and this is recommended in order to get reviews in a timely manner) but you got to remember to put a `/hold` on all the PRs, they have to be lifted only once the `nomock` release phase is done and the branch is created.

> [!WARNING]
It is essential to follow these steps to maintain the integrity of the release process and ensure that all necessary components are updated accordingly, the examples provided are for illustrative purposes and need to be adapted to the specific release version, so please replace `1.30`, `1.33` and `1.34` with the actual version(s) you are deprecating, currently working on or preparing grounds for.

## Checklist

Open a new issue using [this template](https://github.com/kubernetes/sig-release/issues/new?template=post-release-branch-creation.md).

### Remove EOL version jobs from test-infra (optional)

Consider removing jobs for versions that are going EOL. This is sometimes done before adding new jobs to avoid overwhelming the Prow cluster.

Removing EOL jobs involves different steps, including deleting old configs from `config/jobs/kubernetes/sig-release/release-branch-jobs/` e.g. 1.29 EOL jobs removed in [this PR](https://github.com/kubernetes/test-infra/pull/34672).
There could also be some other jobs living outside `config/jobs/kubernetes/sig-release/release-branch-jobs` that also needs to be removed.

You should also remove the unused EOL jobs from the `kubekins-e2e-v2/variants.yaml` file ([here](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e-v2/variants.yaml)), for example:

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
This step may alternatively be performed as part of a patch release process. It's mandatory to consult with the release engineering team regarding the timing of this step.

### Update milestone applier rules and check milestone requirements

Create a PR to update the milestone applier rules to include the new version and remove the oldest version.

> [!WARNING]
Only remove the oldest version if it is already EOL and the release branch jobs have been already removed.

```yaml
# Example PR: https://github.com/kubernetes/test-infra/pull/34650
# Edit this file: config/prow/plugins.yaml

# Add the new version and remove the oldest version in the kubernetes/kubernetes section - if the oldest version is EOL:
milestone_applier:
  kubernetes/kubernetes:
    master: v1.33
    release-1.33: v1.33
    release-1.32: v1.32
    ...
    # remove oldest version (e.g., release-1.29: v1.29)
```

> [!NOTE]
Look out for the code freeze config and ensure excluded and included branches include the newly created release branch `release-1.xy`.

### Update Kubekins-e2e v2 variants

Create a PR to update the `kubekins-e2e-v2/variants.yaml` file with the new version's configuration.
File can be found [here](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e-v2/variants.yaml).

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

Before proceding with the next step, wait for the `post-test-infra-push-kubekins-e2e` postsubmit to finish. You can check the status on [the Prow Status page](https://prow.k8s.io/?job=post-test-infra-push-kubekins-e2e).

### Update release branch jobs in kubernetes/test-infra for the new release and create the dashboards

> [!CAUTION]
Follow the guidelines below very carefully during the update process.

- Do not remove old jobs while adding new jobs in this phase, just do not. Handle it before or after the post branch creation tasks, or let release engineering take care of this.
- Do not segregate PRs, just separate auto-generated files from manually updated ones in two (or more) clearly documented commits.
- Be super careful about `releng/test_config.yaml` especially when commenting out `stable4`
- Do not hesitate to remove broken jobs, but let the interested SIG(s) know about it so they can re-add it.

Updating the release branch jobs in `kubernetes/test-infra` for the new release version involves some steps, it is unpredictable work and requires manual intervention as not every job is generated.
Some of them are added manually and live outside of the generated job tree.

First of all you need to modify the `releng/test_config.yaml` file ([here](https://github.com/kubernetes/test-infra/blob/master/releng/test_config.yaml)) to:
- Update version references
- Rotate stable job configurations sequentially (n -> n+1) - _note: you should put config of stable1 to stable2, then repeat it until you get to the end._
- Add new version as beta
- Update configuration for all test suites

Just shift "args" but not touch interval, sigowners or any other field.
Remember that args are bound to a set of tests for a specific release, while intervals and everything else is bound to a release "status": stable1/2/3/4 or beta. An example of how to correctly rotate the jobs can be found [here](https://github.com/kubernetes/test-infra/pull/34668/commits/819c9d253ab873aff6626a5eaf7635560f7b769e).

Keep in mind that jobs order might be different, e.g. the first stable1 job and and the first stable2 job might not be the same type of the job, so remember to pay particular attention where you're copying from and to.

> [!WARNING]
Consider what has been pointed out in [this issue](https://github.com/kubernetes/test-infra/issues/34675).
When updating to new release image variants, you’ll need to update the jobs to use these new images. However, keep in mind that you can only update a job after the new image tag is available. If you attempt to update before the new image exists, the job may fail.
This is related to how the tags are managed and you should consider using `latest` images instead or you will find yourself opening PRs like [this](https://github.com/kubernetes/test-infra/pull/35288) to fix the image tags for some jobs.

Remember to update all configs before running the [generation script](#run-test-generation-script) for the upcoming release branch jobs and to verify that the jobs are generated correctly.

#### Configure the release dashboards

After configuring the jobs you can now configure the [release dashboards](https://github.com/kubernetes/test-infra/blob/master/config/testgrids/kubernetes/sig-release/config.yaml), example [commit](https://github.com/kubernetes/test-infra/commit/31fb8f2b5c4458af675e37765dfebd128da19971), remembering to:

- Remove the deprecated release sig-release-1.xx-{blocking,informing} dashboards
- Add the new dashboards for the current release e.g., sig-release-1.xx-{blocking,informing}

> [!NOTE]
Comparing the new jobs with previous version(s) might help to identify any missing jobs or misconfigurations.

#### Run test generation script

After updating the configurations you can run the following command from the root of your `test-infra` fork to generate the updated jobs configurations, remember to use the correct architecture and OS for your environment, e.g., `GOARCH=arm64 GOOS=darwin` for macOS on ARM:

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

#### Submit the PR for release branch jobs and dashboards in kubernetes/test-infra

You can finally issue a new PR as [this example](https://github.com/kubernetes/test-infra/pull/34668/files) one.

After this PR is merged, you will be pairing with the Release Signal lead, checking that the new dashboards are working by visiting the TestGrid pages for the new dashboards and verifying that all the necessary jobs show up correctly. This task should be considered completed within 48 hours after the dashboards are created.

Additionally update/fix the following scripts, if you've found any issues with or a way to improve them (they are fragile):
- `hack/run-in-python-container.sh`
- `releng/run.sh`
- `releng/prepare_release_branch.py`

### Add new variant for kube-cross image

> [!Note]
This work on the kube-cross image could have been done as part of the Golang bumps, but it is worth mentioning here as it is a common step.

Before updating the builder images, you need to update the kube-cross image which they depend on:

1. Create a PR to update the kube-cross variants.yaml file:
   - Update the [dependencies.yaml](https://github.com/kubernetes/release/blob/master/dependencies.yaml) file
   - Edit [images/build/cross/variants.yaml](https://github.com/kubernetes/release/blob/master/images/build/cross/variants.yaml)
   - Add a new variant with the appropriate Go version for the current release


   Example PR: https://github.com/kubernetes/release/pull/3870/files

   You also have to edit the dependencies.yaml to update "Kubernetes version (next candidate.0)" to the upcoming minor. 
   
> [!WARNING]
Bumping the stable version to the n+1 version of Kubernetes is done only when the official release is out.

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

> [!NOTE]
Part of this work on k8s-cloud-builder and k8s-ci-builder could have been done as part of the Golang bumps, but it is worth mentioning here as it is a common step.
In any case you should always update the k8s-cloud-builder and k8s-ci-builder images to use the new kube-cross image.

Once the updated kube-cross image is available:

1. Update the k8s-cloud-builder variants.yaml file:
   - Update dependencies.yaml
   - Edit [images/k8s-cloud-builder/variants.yaml](https://github.com/kubernetes/release/blob/master/images/k8s-cloud-builder/variants.yaml)
   - Add a new variant that references the new kube-cross image

   ```yaml
   v1.XX-cross1.XX.Y-Z: # Example addition to variants.yaml
    CONFIG: 'cross1.XX'
    KUBE_CROSS_VERSION: 'v1.XX.y-go1.XX.Y-Z' # Match with the kube-cross image you created
   ```

The k8s-ci-builder needs to be updated in a similar fashion:

2. Update the k8s-ci-builder variants.yaml file:
   - Update dependencies.yaml
   - Edit [images/releng/k8s-ci-builder/variants.yaml](https://github.com/kubernetes/release/blob/master/images/releng/k8s-ci-builder/variants.yaml)
   - Add a new variant with the appropriate Go version that matches the release

   ```yaml
   '1.34':
      CONFIG: '1.34'
      GO_VERSION: '1.24.5'
      GO_VERSION_TOOLING: '1.24.5'
      OS_CODENAME: 'bullseye'
   ```

3. Submit your PR and wait for review and merge
   - Example PR (that also included the k8s-ci-builder Image update): https://github.com/kubernetes/release/pull/4065/files

4. Monitor the build job in Prow:
   - After merge, the image will be automatically built

After the PR is merged, make sure the relevant ProwJobs are green.

You can verify the images were built successfully by either pulling the images or using  `crane` to check their digest.

Or you can use `gcloud` to list the tags of the images:

   ```bash
   # Check the kube-cross image
   gcloud container images list-tags gcr.io/k8s-staging-build-image/kube-cross

   # Check the k8s-cloud-builder image
   gcloud container images list-tags gcr.io/k8s-staging-releng/k8s-cloud-builder

   # Check the k8s-ci-builder image
   gcloud container images list-tags gcr.io/k8s-staging-releng/k8s-ci-builder
   ```

### Update `kubernetes/kubernetes` references for the `kube-cross` image

Once the new builder images are available:

Create a PR in kubernetes/kubernetes to reference the new kube-cross image in `build/build-image/cross/VERSION` ([here](https://github.com/kubernetes/kubernetes/blob/master/build/build-image/cross/VERSION)):
   - Example PR: https://github.com/kubernetes/kubernetes/pull/132897/files

### Update publishing bot rules

The Kubernetes Publishing Bot is responsible for:
- ensuring that the master and release branches in the staging repositories are in-sync with the appropriate branches in `kubernetes/kubernetes`
- creating tags in the staging repositories for each Kubernetes release

Update the publishing bot rules to include the new version. Use the update-rules CLI tool to generate the necessary changes as described [here](https://github.com/kubernetes/publishing-bot/blob/master/cmd/update-rules/README.md).

You can install the tool on Linux with a simple `make build` command, similarly on MacOS by specifying your OS `GOOS=darwin make build`.
By default the binary will be located in `_output/update-rules`. This is the preferred way to run the tool.

You can also use the Docker image to run the tool, which is useful if you don't want to build it locally (but you can also do that with make `make build-image`). The live Docker image is available at `gcr.io/k8s-staging-publishing-bot/publishing-bot:latest` and you can invoke the containerized tool as follows:

```bash
docker run -t gcr.io/k8s-staging-publishing-bot/publishing-bot:latest /update-rules -branch release-1.34 -go 1.24.5 -rules ~/kubernetes/staging/publishing/rules.yaml -o /tmp/rules.yaml
```

It's recommended to set the release branch, the Go version and the current publishing rules from kubernetes/kubernetes master branch as environment variables before running the command:

```bash
 # set release branch
 export K8S_REL_BRANCH=release-1.34
 # https://github.com/kubernetes/release/blob/master/images/build/cross/variants.yaml#L7
 export GO_VERSION=1.24.5
 export CURRENT_K8S_MASTER_RULES_FILE=/kubernetes/staging/publishing/rules.yaml
```

> [!WARNING]
Remember to use the appropriate (updated) Go version for the release, coordinate with #release-management or @release-managers to ensure the correct version is used.

Basically you need to run the following command after having the `update-rules` tool installed.

```bash
_output/update-rules -branch ${K8S_REL_BRANCH} -go ${GO_VERSION} -rules ${CURRENT_K8S_MASTER_RULES_FILE} -o /tmp/rules.yaml
```

Or, if you ever need to manually edit the rules file, you can do so, as follows:

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

> [!WARNING]
You should never really have to manually do this. If you have problems with the update-rules tool, those should be addressed as soon as possible.

Once the rules are updated you can submit a PR similar to [this one](https://github.com/kubernetes/kubernetes/pull/131250), to the publishing-bot repository.

### Create Performance Tests Branch

Ensure a performance tests branch is created for the new version:

```bash
# Example: https://github.com/kubernetes/perf-tests/issues/3290

# A maintainer from SIG Scalability should create:
https://github.com/kubernetes/perf-tests/tree/release-1.xx

# Example for 1.34:
https://github.com/kubernetes/perf-tests/tree/release-1.34

# Verify the branch is working in CI:
https://prow.k8s.io/view/gs/kubernetes-ci-logs/logs/ci-kubernetes-kubemark-500-gce-1-xx

# Example for 1.34:
https://prow.k8s.io/view/gs/kubernetes-ci-logs/logs/ci-kubernetes-kubemark-500-gce-1-34
```

Reach out to SIG Scalability to ensure a new branch is cut in the [sigs.k8s.io/perf-tests](https://github.com/kubernetes/perf-tests/) repo. 

### Check and eventually improve release scripts (optional)

If needed, fix error messages or anomalies found in any of the release scripts you've run during the post-rc.0 tasks.

```bash
# Example: Fixing line 307 of this script:
# http://github.com/kubernetes/release/blob/9a9572f7c48f637de8499a201fb8e3ff52f8d4ba/pkg/gcp/gcb/gcb.go#L307

# This would help avoid having a "release job" message for nomock stage commands
```

Generally speaking, update scripts and documentation as needed to ensure they are up-to-date and reflect the current release process.

## Additional Resources

- [Release Manager Handbook](https://github.com/kubernetes/sig-release/blob/master/release-engineering/role-handbooks/branch-manager.md)
- [Example 1.34.0-rc.0 Release Cut Issue](https://github.com/kubernetes/sig-release/issues/2824)
- [Example of post branch creation tasks issue for 1.34.0-rc.0](https://github.com/kubernetes/sig-release/issues/2826) _this also contains an example of each PR linkedin in the body of the issue_
- [Slack Discussion Thread for 1.33.0-rc.0](https://kubernetes.slack.com/archives/CJH2GBF7Y/p1744125003875769) - _do not rely on the Slack thread being long lived, if it got archived or the channel got deleted, you should just rely on the docs and the PRs linked in this document_

## Notes

- The order of operations is important. Generally, update configuration files first, then generate files, check them and push on your fork before opening a PR.
- Some tasks may be release-specific. Always check with the rest of release engineering and inform them if you're unsure about any step. Also remember to keep the Release Team informed as they are responsible for the success of the release as a whole.
- After completing these tasks, verify that CI jobs are running properly for the new release branch and that the dashboards reflect the new version.

---
