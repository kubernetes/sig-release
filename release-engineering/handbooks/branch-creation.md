# Post Branch Creation Tasks

<!-- toc -->
- [Checklist](#checklist)
  - [Remove EOL version jobs from test-infra (optional)](#remove-eol-version-jobs-from-test-infra-optional)
  - [Update milestone applier rules and check milestone requirements](#update-milestone-applier-rules-and-check-milestone-requirements)
  - [Update Kubekins-e2e v2 variants](#update-kubekins-e2e-v2-variants)
  - [Update release branch jobs in kubernetes/test-infra for the new release and create the dashboards](#update-release-branch-jobs-in-kubernetestest-infra-for-the-new-release-and-create-the-dashboards)
    - [Configure the release dashboards](#configure-the-release-dashboards)
    - [Run the prepare-release-branch tool](#run-the-prepare-release-branch-tool)
    - [Submit the PR for release branch jobs and dashboards in kubernetes/test-infra](#submit-the-pr-for-release-branch-jobs-and-dashboards-in-kubernetestest-infra)
  - [Add new variant for kube-cross image](#add-new-variant-for-kube-cross-image)
  - [Update k8s-cloud-builder and k8s-ci-builder](#update-k8s-cloud-builder-and-k8s-ci-builder)
  - [Update `kubernetes/kubernetes` references for the `kube-cross` image](#update-kuberneteskubernetes-references-for-the-kube-cross-image)
  - [Update publishing bot rules](#update-publishing-bot-rules)
  - [Create Performance Tests Branch](#create-performance-tests-branch)
  - [Check and eventually improve release scripts (optional)](#check-and-eventually-improve-release-scripts-optional)
- [Additional Resources](#additional-resources)
- [Notes](#notes)
<!-- /toc -->

This document details the tasks that need to be executed after cutting a Kubernetes rc.0 release. These tasks ensure proper configuration for the new release branch and testing infrastructure.
They must be executed after the `nomock release` is completed, and the release branch is created, as stated in the [branch creation chapter](release-cuts.md#next-release-branch-creation) of the release cut handbook.

PR can be created beforehand (and this is recommended in order to get reviews in a timely manner) but you got to remember to put a `/hold` on all the PRs, they have to be lifted only once the `nomock` release phase is done and the branch is created.

> [!WARNING]
It is essential to follow these steps to maintain the integrity of the release process and ensure that all necessary components are updated accordingly. The examples provided are for illustrative purposes and need to be adapted to the specific release version. In the examples, `1.34` is the version going EOL, `1.37` is the previous release, `1.38` is the release whose branch was just created and `<go-version>` is the Go version used by that release. Replace them with the actual versions.

## Checklist

Open a new issue using [this template](https://github.com/kubernetes/sig-release/issues/new?template=post-release-branch-creation.md).

### Remove EOL version jobs from test-infra (optional)

Consider removing jobs for versions that are going EOL. **This is not a priority for the post branch creation tasks**, prioritize adding the new release's jobs (see below) first; EOL job removal can happen later and does not need to precede or block that work.

Removing EOL jobs involves different steps, including deleting old configs from `config/jobs/kubernetes/sig-release/release-branch-jobs/`, e.g. the 1.29 EOL jobs were removed in [this PR](https://github.com/kubernetes/test-infra/pull/34672).
There could also be some other jobs living outside `config/jobs/kubernetes/sig-release/release-branch-jobs` that also needs to be removed.

You should also remove the unused EOL jobs from the `kubekins-e2e-v2/variants.yaml` file ([here](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e-v2/variants.yaml)), for example:

```bash
# Example PR: https://github.com/kubernetes/test-infra/pull/34674
# Changes would involve removing the EOL version from: images/kubekins-e2e-v2/variants.yaml

# Diff example:

- '1.34':
-    CONFIG: '1.34'
-    K8S_RELEASE: latest-1.34
-    K8S_BRANCH: release-1.34
-    BAZEL_VERSION: 3.4.1
-    DOCKER_VERSION: 5:28.*
```

> [!NOTE]
This step may alternatively be performed as part of a patch release process, or deferred until after the rest of the post branch creation tasks are done. It's mandatory to consult with the release engineering team regarding the timing of this step.

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
    master: v1.38
    release-1.38: v1.38
    release-1.37: v1.37
    ...
    # remove oldest version (e.g., release-1.34: v1.34)
```

> [!NOTE]
Look out for the code freeze config and ensure excluded and included branches include the newly created release branch `release-1.xy`.

### Update Kubekins-e2e v2 variants

Create a PR to update the `kubekins-e2e-v2/variants.yaml` file with the new version's configuration.
File can be found [here](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e-v2/variants.yaml).

> [!NOTE]
The image does not pin a Go version. It reads the `.go-version` file from the `kubernetes/kubernetes` branch named by `K8S_BRANCH`, so the new variant automatically builds with the Go version of the new release branch. Copy `BAZEL_VERSION` and `DOCKER_VERSION` from the previous release variant (for example `1.37`), since `master` may already use a newer Docker version than the release branches.

```yaml
# Example PR: https://github.com/kubernetes/test-infra/pull/34651
# Edit this file: images/kubekins-e2e-v2/variants.yaml

# Add the new version configuration as follows:
variants:
  '1.38':
    CONFIG: '1.38'
    K8S_RELEASE: latest-1.38
    K8S_BRANCH: release-1.38
    BAZEL_VERSION: 3.4.1
    DOCKER_VERSION: 5:28.*
```

Before proceeding with the next step, wait for the `post-test-infra-push-kubekins-e2e-v2` postsubmit to finish. You can check the status on [the Prow Status page](https://prow.k8s.io/?job=post-test-infra-push-kubekins-e2e-v2).

### Update release branch jobs in kubernetes/test-infra for the new release and create the dashboards

> [!CAUTION]
Follow the guidelines below very carefully during the update process.

- Do not remove old jobs while adding new jobs in this phase. Handle it before or after the post branch creation tasks, or let release engineering take care of this.
- Do not hesitate to remove broken jobs, but let the interested SIG(s) know about it so they can re-add it.

The GCE COS e2e jobs (alphafeatures, default, reboot, serial, slow) use `fork-per-release` annotations and are automatically handled by the `prepare-release-branch` tool. Other jobs that live outside the fork-per-release system may still require manual updates.

#### Configure the release dashboards

Configure the [release dashboards](https://github.com/kubernetes/test-infra/blob/master/config/testgrids/kubernetes/sig-release/config.yaml), example [commit](https://github.com/kubernetes/test-infra/commit/31fb8f2b5c4458af675e37765dfebd128da19971), remembering to:

- Remove the deprecated release sig-release-1.xx-{blocking,informing} dashboards
- Add the new dashboards for the current release e.g., sig-release-1.xx-{blocking,informing}

> [!NOTE]
Comparing the new jobs with previous version(s) might help to identify any missing jobs or misconfigurations.

#### Run the prepare-release-branch tool

From the root of your `test-infra` fork, run:

```bash
make -C releng prepare-release-branch
```

This tool will:

1. Check if the next release branch (e.g. `release-1.38`) exists on `kubernetes/kubernetes`
2. If the branch does not exist yet, exit early without making changes (safe to re-run)
3. Fetch the Go version from the release branch
4. Rotate existing release branch job tiers (beta → stable1 → stable2 → stable3 → stable4)
5. Fork new job configurations for the new release branch

The tool is idempotent: running it before the release branch exists is a no-op.

#### Submit the PR for release branch jobs and dashboards in kubernetes/test-infra

You can finally issue a new PR as [this example](https://github.com/kubernetes/test-infra/pull/34668/files) one.

After this PR is merged, you will be pairing with the Release Signal lead, checking that the new dashboards are working by visiting the TestGrid pages for the new dashboards and verifying that all the necessary jobs show up correctly. This task should be considered completed within 48 hours after the dashboards are created.

### Add new variant for kube-cross image

> [!NOTE]
This work on the kube-cross image could have been done as part of the Golang bumps (see the [Go update handbook](go-updates.md#kube-cross-image)), but it is worth mentioning here as it is a common step.

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
       version: v1.37.0
       refPaths:
         - path: images/build/cross/Makefile
           match: KUBERNETES_VERSION\ \?=\ v((([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)
         - path: images/build/cross/variants.yaml
           match: "KUBERNETES_VERSION: 'v((([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?)'"

     # Update after the stable marker has been updated to stable.0
     - name: "Kubernetes version (next candidate.0)"
       version: v1.38.0
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
   '1.38':
      CONFIG: '1.38'
      GO_VERSION: '<go-version>'
      GO_VERSION_TOOLING: '<go-version>'
      OS_CODENAME: 'bookworm'
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

Set the release branch, the Go version and the path of your `kubernetes/kubernetes` checkout (with the `master` branch checked out) as environment variables before running the tool:

```bash
# set release branch
export K8S_REL_BRANCH=release-1.38
# https://github.com/kubernetes/release/blob/master/images/build/cross/variants.yaml
export GO_VERSION=<go-version>
# local kubernetes/kubernetes checkout containing staging/publishing/rules.yaml
export K8S_CHECKOUT=$HOME/kubernetes
```

> [!WARNING]
Remember to use the appropriate (updated) Go version for the release, coordinate with #release-management or @release-managers to ensure the correct version is used.

The tool rewrites the rules file in place, so the result shows up as a diff in your checkout that you can review with `git diff` and open as a PR:

```bash
_output/update-rules -branch ${K8S_REL_BRANCH} -go ${GO_VERSION} -rules ${K8S_CHECKOUT}/staging/publishing/rules.yaml -o ${K8S_CHECKOUT}/staging/publishing/rules.yaml
```

You can also use the Docker image to run the tool, which is useful if you don't want to build it locally (but you can also do that with make `make build-image`). The live Docker image is available at `gcr.io/k8s-staging-publishing-bot/publishing-bot:latest`. Mount your checkout into the container so the tool can read and write the same rules file:

```bash
docker run -t -v "${K8S_CHECKOUT}:/kubernetes" gcr.io/k8s-staging-publishing-bot/publishing-bot:latest /update-rules -branch ${K8S_REL_BRANCH} -go ${GO_VERSION} -rules /kubernetes/staging/publishing/rules.yaml -o /kubernetes/staging/publishing/rules.yaml
```

Or, if you ever need to manually edit the rules file, you can do so, as follows:

```yaml
# Example PR: https://github.com/kubernetes/kubernetes/pull/131250
# Edit this file: staging/publishing/rules.yaml

# Repeat this new section for each repository following this pattern:
- name: release-1.38
  go: <go-version> # Remember to use the appropriate Go version for the release
  dependencies:
  - repository: apimachinery
    branch: release-1.38
  - repository: api
    branch: release-1.38
  source:
    branch: release-1.38
    dirs:
    - staging/src/k8s.io/[repository-name]
```

> [!WARNING]
You should never really have to manually do this. If you have problems with the update-rules tool, those should be addressed as soon as possible.

Once the rules are updated you can submit a PR similar to [this one](https://github.com/kubernetes/kubernetes/pull/131250) to `kubernetes/kubernetes`, where `staging/publishing/rules.yaml` lives.

### Create Performance Tests Branch

Ensure a performance tests branch is created for the new version:

```bash
# Example: https://github.com/kubernetes/perf-tests/issues/3290

# A maintainer from SIG Scalability should create:
https://github.com/kubernetes/perf-tests/tree/release-1.xx

# Example for 1.38:
https://github.com/kubernetes/perf-tests/tree/release-1.38

# Verify the branch is working in CI:
https://prow.k8s.io/view/gs/kubernetes-ci-logs/logs/ci-kubernetes-kubemark-500-gce-1-xx

# Example for 1.38:
https://prow.k8s.io/view/gs/kubernetes-ci-logs/logs/ci-kubernetes-kubemark-500-gce-1-38
```

Reach out to SIG Scalability to ensure a new branch is cut in the [kubernetes/perf-tests](https://github.com/kubernetes/perf-tests/) repo.

### Check and eventually improve release scripts (optional)

If needed, fix error messages or anomalies found in any of the release scripts you've run during the post-rc.0 tasks.

Generally speaking, update scripts and documentation as needed to ensure they are up-to-date and reflect the current release process.

## Additional Resources

- [Release Manager Handbook](release-manager.md)
- [Example 1.34.0-rc.0 Release Cut Issue](https://github.com/kubernetes/sig-release/issues/2824)
- [Example of post branch creation tasks issue for 1.34.0-rc.0](https://github.com/kubernetes/sig-release/issues/2826) _this also contains an example of each PR linked in the body of the issue_
- [Slack Discussion Thread for 1.33.0-rc.0](https://kubernetes.slack.com/archives/CJH2GBF7Y/p1744125003875769) - _do not rely on the Slack thread being long lived, if it got archived or the channel got deleted, you should just rely on the docs and the PRs linked in this document_

## Notes

- The order of operations is important. Generally, update configuration files first, then generate files, check them and push on your fork before opening a PR.
- Some tasks may be release-specific. Always check with the rest of release engineering and inform them if you're unsure about any step. Also remember to keep the Release Team informed as they are responsible for the success of the release as a whole.
- After completing these tasks, verify that CI jobs are running properly for the new release branch and that the dashboards reflect the new version.
