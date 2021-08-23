# Branch Manager Handbook

<!-- toc -->
- [Content Notice](#content-notice)
- [Overview](#overview)
  - [Conventions](#conventions)
- [Prerequisites](#prerequisites)
  - [Branch Management Onboarding](#branch-management-onboarding)
  - [Machine setup](#machine-setup)
    - [Operating System](#operating-system)
    - [Release tooling](#release-tooling)
    - [Google Cloud SDK](#google-cloud-sdk)
    - [Sending mail](#sending-mail)
    - [Skopeo](#skopeo)
- [Releases Management](#releases-management)
  - [Creating and managing the Release Issue](#creating-and-managing-the-release-issue)
    - [Testgrid Screenshots](#testgrid-screenshots)
    - [Adding data about the Cloud Build Jobs](#adding-data-about-the-cloud-build-jobs)
    - [Closing the Issue](#closing-the-issue)
  - [Alpha Releases](#alpha-releases)
    - [Alpha Stage](#alpha-stage)
      - [krel stage](#krel-stage)
    - [Alpha Release](#alpha-release)
      - [krel release](#krel-release)
      - [Mock vs nomock](#mock-vs-nomock)
  - [Beta Releases](#beta-releases)
  - [Release Candidates](#release-candidates)
  - [Official Releases](#official-releases)
    - [Security fixes](#security-fixes)
    - [Debian and RPM Packaging](#debian-and-rpm-packaging)
    - [Release Validation](#release-validation)
  - [Post-release Activities](#post-release-activities)
    - [Update kubekins-e2e variants](#update-kubekins-e2e-variants)
    - [Cut next alpha](#cut-next-alpha)
- [Branch Management](#branch-management)
  - [Branch Creation](#branch-creation)
    - [During the release creation](#during-the-release-creation)
    - [After the release creation](#after-the-release-creation)
  - [Update test-infra configurations](#update-test-infra-configurations)
    - [Update milestone appliers](#update-milestone-appliers)
    - [Update milestone requirements](#update-milestone-requirements)
    - [Update e2e variants](#update-e2e-variants)
    - [Generate release branch jobs](#generate-release-branch-jobs)
  - [Configure Merge Automation](#configure-merge-automation)
    - [Tide](#tide)
    - [Code Freeze](#code-freeze)
    - [Code Thaw](#code-thaw)
  - [Branch Fast Forward](#branch-fast-forward)
  - [Reverts](#reverts)
  - [Cherry Picks](#cherry-picks)
- [Staging Repositories](#staging-repositories)
- [Debugging](#debugging)
- [Search past builds](#search-past-builds)
    - [Limitation](#limitation)
- [References](#references)
  - [Test Infra references](#test-infra-references)
- [Background information](#background-information)
<!-- /toc -->

## Content Notice

The Patch Release Team and Branch Manager roles have been consolidated into a
single [Release Managers][release-managers] group.

This means that several areas of this document may currently be out of date.
While we work to update these documents, please reach out to
[Release Managers][release-managers] directly for any clarifications on Release
Engineering processes.

**This notice will be removed when the documentation is no longer under
construction.**

## Overview

### Conventions

In this handbook, we will make several references to Kubernetes releases, milestones, and [semantic versioning](http://semver.org/).

For the purposes of this handbook, we'll assume that:

- the current release in development is Kubernetes 1.18
- the previous release is Kubernetes 1.17
- the next release is Kubernetes 1.19
- the release no longer in support is Kubernetes 1.14

To simplify certain instructions, we will make the following connections:

| Text | SemVer | Reference Release |
|---|---|---|
| "current release", "current milestone", "in development" | `x.y` | Kubernetes 1.18 |
| "previous release", "previous milestone" | `x.y-1` | Kubernetes 1.17 |
| "next release", "next milestone" | `x.y+1` | Kubernetes 1.19 |
| "release no longer in support" | `x.y-4` | Kubernetes 1.14 |

**As an editor of this content, Branch Managers should periodically update these conventions and the examples contained within this handbook.**

## Prerequisites

This is a collection of requirements and conditions to fulfill when taking on the role as branch manager.

### Branch Management Onboarding

**Before we can grant Release Manager access to new Branch Managers, a [Release Manager onboarding issue](https://github.com/kubernetes/sig-release/issues/new?labels=sig%2Frelease%2C+area%2Frelease-eng&template=release-manager.md&title=Release+Manager+access+for+%3CGH-handle%3E) _MUST_ be opened in this repo. Please take a moment to do that before executing the tasks contained in this handbook.**

### Machine setup

#### Operating System

There's a small amount of effort to ensure our [release tools] are supported on multiple platforms, please note that only the following systems are supported:

- Debian-like (Debian, Ubuntu)
- Fedora-like (Fedora, RHEL, CentOS)
- MacOS

Windows is not supported by [release tools].

While our tooling may not support every platform, you may find success running within a container image.

See "Cutting v1.15.0-alpha.2" under [References](#References) for an example Dockerfile.

**If you notice that [release tools] are not working as expected, please file an issue in [kubernetes/release].**

#### Release tooling

To leverage/contribute to our [release tools], Release Managers will need to fork and clone the [kubernetes/release] repo.

Building and publishing releases requires the latest revision of the release tools. The release tools can be compiled by running the following command from the [kubernetes/release] repository:

```shell
make release-tools
```

Release Managers primarily use an SSH key to authenticate to GitHub.

GitHub has documentation to assist in:

- [Connecting to GitHub with SSH](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
- [Forking a repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)

Additionally, `kubernetes/community` has a great [overview of the GitHub workflow](https://git.k8s.io/community/contributors/guide/github-workflow.md) we use across several Kubernetes org repositories.

Please take a moment to review the above documentation before continuing.

[image-promotion]: ./release-image-promotion.md

#### Google Cloud SDK

[Kubernetes release artifacts](/release-engineering/artifacts.md) are stored on Google Cloud Platform (GCP).

Release Managers will need to use the Google Cloud SDK to interact with release artifacts.

Google Cloud has [documentation on installing and configuring the Google Cloud SDK CLI tools](https://cloud.google.com/sdk/docs/quickstarts).

To authenticate the Google Cloud SDK tool with your GCP account, you can run:

```shell
gcloud auth login
```

It might ask you to define the default project, region, and similar settings. The project can be set to `kubernetes-release-test`, while other settings can be ignored.

In addition to `gcloud,` `gsutil` is required as well. By default, it comes with Google Cloud SDK.

#### Sending mail

At the end of a release, Release Managers will need to announce the new release to the community.

This can be done in one of two ways:

- The `krel announce` sub command -- A [`SENDGRID_API_KEY`](https://sendgrid.com/docs/ui/account-and-settings/api-keys) will need to be configured correctly on your environment for this to work
  - If you haven't used SendGrid before, SendGrid might require you to go through the [Sender Identity Verification process][sendgrid-identity-verification] before you can send emails/announcements
- Manually -- Send the email notification manually to [kubernetes-announce][k-announce-list] and [kubernetes-dev][k-dev-list]. You can take contents of the announcement in one of the following ways:
  - By taking the contents from the Google Cloud Bucket: `gs://kubernetes-release/archive/anago-vX.Y.0-{alpha,beta,rc}.z`:
  - By using `krel announce` command with the `--print-only` flag
  - [Example subject](https://gcsweb.k8s.io/gcs/kubernetes-release/archive/anago-v1.17.0-rc.2/announcement-subject.txt)
  - [Example body](https://gcsweb.k8s.io/gcs/kubernetes-release/archive/anago-v1.17.0-rc.2/announcement.html)

[k-announce-list]: https://groups.google.com/forum/#!forum/kubernetes-announce
[k-dev-list]: https://groups.google.com/forum/#!forum/kubernetes-dev
[release tools]: https://github.com/kubernetes/release#tools
[kubernetes/release]: https://github.com/kubernetes/release
[sendgrid-identity-verification]: https://sendgrid.com/docs/for-developers/sending-email/sender-identity/

#### Skopeo

[Skopeo][skopeo] is a command line utility that performs various operations on container images and image repositories. Skopeo is not required for performing branch management tasks (if needed, Docker and other relevant tools can be used instead), however, it might be referred to by other guides. If you want to install Skopeo, you can follow the [official installation guide][skopeo-install].

[skopeo]: https://github.com/containers/skopeo
[skopeo-install]: https://github.com/containers/skopeo/blob/master/install.md

## Releases Management

**General overview**:

Public build artifacts are published and an email notification goes out to the community. You will become very familiar with the following commands over the course of the 3 month release cycle:

 - `krel stage/release` for creating releases
 - `krel announce` to send the announcement email notification.

```shell
# Only for the official release: Inform the Google team to complete the corresponding Deb and RPM builds
export SENDGRID_API_KEY=<API_KEY>
krel announce --tag vX.Y.0-{alpha,beta,rc}.Z
```

There are more examples of the release process under the [References](#references) section.

It is also highly recommended to glance over the [Release Commands Cheat Sheet](https://github.com/kubernetes/sig-release/blob/master/release-engineering/role-handbooks/patch-release-team.md#release-commands-cheat-sheet).

### Creating and managing the Release Issue

Prior to cutting a release version, [open a "Cut a Release" issue](https://github.com/kubernetes/sig-release/issues/new?template=cut-release.md&title=Cut+1.x.y-%7Balpha%2Cbeta%2Crc%7D.z+release) on [kubernetes/sig-release](https://github.com/kubernetes/sig-release).

On the issue template, there are comments describing the predefined items that
need to be completed.

#### Testgrid Screenshots

For the item `Screenshot unhealthy release branch testgrid boards...`:

`krel testgridshot` takes care of generating screenshots of
[Testgrid](https://testgrid.k8s.io/) to keep as a reference of the state
it was in before cutting a release. This subcommand will generate images
of the boards and upload them to a Cloud Storage bucket, as well as the
Markdown code.

To invoke the subcommand, run it with the branch you are working on:

```
krel testgridshot --branch 1.20
```

You can include other testgrid states in the output and even have krel
autocomment the issue for you:

```
krel testgridshot --branch 1.20 --github-issue 12345 --states=FLAKY
```

Once the script generates the Markdown table, post it as a comment on the created issue. You can take a look at the [following comment](https://github.com/kubernetes/sig-release/issues/1249#issuecomment-696702503) as an example.

#### Adding data about the Cloud Build Jobs

When running a release cut, you should open a thread in the
[#release-management][release-management-url] Slack channel and include links
to the GCP build console. You can take a look at the
[following thread][example-release-thread] as an example.

[release-management-url]: https://app.slack.com/client/T09NY5SBT/CJH2GBF7Y
[example-release-thread]: https://kubernetes.slack.com/archives/CJH2GBF7Y/p1600247891103600

Once mock and nomock runs are complete, data about the jobs launched must be
collected in the issue. These are assembled in a table and correspond to the
`Collect metrics, links...` check mark.

After the release process has been completed, get the data table by using the
`krel history` subcommand. It will output a markdown table with the options used
to run the jobs, links to the GCB logs, and the result of each run.

```shell
krel history --branch release-1.xy --date-from <date-of-release>
```
The generated table is then appended to the release issue, as it can be seen in
the [following issue for the v1.20.0-alpha.1 release](https://github.com/kubernetes/sig-release/issues/1249#issue-705792603).


__Note:__ `krel history` works using the [Default Application
Credentials](https://cloud.google.com/sdk/gcloud/reference/auth/application-default)
set in your environment. While you may be logged as a user with one or more Google
accounts in the GCP SDK (which are used in `gsutil`, `gcloud`, etc), you need to
make sure your user identity is set as DAC as software using the Google Cloud
libraries uses it to authenticate.

If you have not set any Default Application Credentials previously, krel will notify
you. If you have another user or a service account you will simply get an
authentication error.

Use the following command to start the authorization flow to set your default credentials:

```shell
gcloud auth application-default login
```

#### Closing the Issue

After having thoroughly read the section on cutting a release version of the handbook, and that all items on the checklist have completed (you may include notes on events that was unique to cutting that release version as comments), close the issue with `/close` as a comment the issue thread.

### Alpha Releases

#### Alpha Stage

##### krel stage

To stage a new alpha release, simply run `krel stage`. The default command line
parameters will already default to the correct `--branch` and `--type`.

The output of the command should provide a link to GCP, where you can track the
progress of the build. The build duration takes approximately 1 hour. `krel
stage` is building all the bits for a bunch of target operating systems and
hardware architectures.

<!-- TODO: krel is not checking testgrid

Early in the release cycle, it is likely that the build might fail. By default the `stage master` command automatically looks for a place where [release master blocking tests](https://k8s-testgrid.appspot.com/sig-release-master-blocking) have green results, which traditionally has not happened in Kubernetes on an ongoing basis.

WE REALLY WANT (and need) TO GET THERE. Quality needs to be a continual focus. But in the meantime, acknowledging today especially for an early alpha or beta release, it is possible to just build via:

Rather than having `krel stage` pick a candidate by analyzing test data from the commit history that had no fails and building automatically from that point, we instead indicate we want to build explicitly from the last commit on the current branch.
-->

#### Alpha Release

The actual releasing may be intentionally delayed after staging. For example, the branch manager may stage a build from the head of the release branch late in the release cycle, doing so in the morning so that it is fully built and would be releasable in the afternoon (pending CI tests run against the head of the branch).

If the CI results are good and the release team approves, you can initiate the publishing portion of the release process. If staging the build only happened after the receipt of clean CI tests results, this will delay completing the entire release process for a release version (alpha,beta,rc,...).

This presumes reproducible builds and that the CI tests are meaningful relative to the release builds. There is always a risk that these diverge, and this needs to be managed broadly by the project and the release team.

##### krel release

Before running the release step, please refer to the [Image Promotion documentation](https://github.com/kubernetes/sig-release/blob/master/release-engineering/role-handbooks/release-image-promotion.md).

To finish the previously staged release, run `krel release --build-version=…`.
Use the `--build-version=` as specified in the output when `krel stage` is done.

This copies the staged build to public GCP buckets at well-known urls for the truncated release version string. The unique build staging identifier will subsequently be “v1.16.0-alpha.1”, even though the staged build had an “alpha.0” in its name.

This can be confusing. The v1.16.0-alpha.0 tag was created automatically in the past when the v1.15 branch was forked, but it wasn’t actually built.

##### Mock vs nomock

Any `krel stage/release` command without the `--nomock` flag is a dry run. It is highly encouraged to dry run first before letting `krel stage/release` take any actual impact on the release process. Mock building/releasing can help you verify that you have a working setup!

To get more information on `krel stage/release`, please refer to their
corresponding help (`-h`) output.

**Note: This run may fail. Mock builds can only be mock released. A nomock release requires a nomock build to be staged.**

### Beta Releases

Before run the `official release step` please refer to the [Image Promotion documentation](./release-image-promotion.md).

To stage a new beta release, simply run `krel stage --type=beta`. The same
applies to `krel release --build-version=… --type=beta`.

### Release Candidates

Builds against a `release-x.y` branch are implicitly the next RC (release candidate). `krel` automatically finds and increments the current build number.

**Note: If this is the first release (`rc.0`), there are additional tasks to complete. Please review them _COMPLETELY_ in the [Branch Creation section](#branch-creation), _before_ continuing.**

Before run the `official release step` please refer to the [Image Promotion documentation](./release-image-promotion.md).

To stage a new RC release, simply run `krel stage --type=rc --branch=release-x.y`. The same
applies to `krel release --build-version=… --type=rc --branch=release-x.y`.

In a perfect world, `rc.1` and the official release are the same commit. To get as close to that perfect state as we can, the following things should be considered:

1. PRs tagged with the release cycle milestone should have all merged onto the `master` branch:

   For example, there should be no open PRs tagged with the v1.18 milestone, `is:pr is:open milestone:v1.18`.

   You and the release team should push for PRs to get merged before the [code freeze](#code-freeze) is lifted or determine if the open PRs can be removed from the milestone and be merged in the next release cycle.

2. When to stage and release `rc.1`:

   Make sure that all the changes that have been merged onto `master`, make it onto the release branch. Run [`krel ff`](#branch-fast-forward) to see the state of the two branches and pull any remaining PRs from `master` onto the release branch.

   At this point in time, `master` and the release branch should have the same commits. Nothing new gets merged onto `master`, since [code freeze](#code-freeze) is not lifted. Therefore, it is safe to cut the release candidate.

3. Factors that determine if Code Freeze can be lifted:

   - Zero pending PRs and no open issues tagged with the release cycle milestone.
   - No failing X.Y-blocking tests, for example the [sig-release-1.18-blocking](https://testgrid.k8s.io/sig-release-1.18-blocking) dashboard should not have any red failing test builds.

   > **Note:** If there are non-zero pending PRs, open issues or failing tests, there is high confidence that the issue is understood and the solution can be [cherry picked](#cherry-picks) over to the release branch between the release candidate(s) and official release.

Technically we can keep [code freeze](#code-freeze) in place after `rc.1` was cut. However, we should aim at lifting code freeze relatively quickly after `rc.1`.

Otherwise we might have a mix of PRs against master, some have been merged in code freeze and for the milestone, just after `rc.1`, and others have been merged when code freeze has been lifted. We might miss this specific PR in the plethora of PRs that [tide] merges after [code thaw](#code-thaw), and we might miss that this PR actually needs to be cherry-picked into the release branch.

[tide]: https://git.k8s.io/test-infra/prow/tide

### Official Releases

Before run the `official release step` please refer to the [Image Promotion documentation](./release-image-promotion.md).

To stage a new official release, simply run `krel stage --type=official
--branch=release-x.y`. The same applies to `krel release --build-version=…
--type=official --brancH=release-x.y`.

In addition to `v1.18.n` this will also build and stage the subsequent patch's
`rc.0`, in this example `v1.18.(n+1)-rc.0`. Similar to [creating a new branch](#branch-creation), the staging step will take about twice as long, the
release step will also take a couple of minutes more.

However, there is an embargo policy which requires the nomock release publication happens after 4 pm Pacific (see [Release Team Lead Handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#week-12) for details), make sure to coordinates with other roles and follow the timeline.

To better prepare and see what to expect, this is a sequence of events that took place on past [official release days](https://docs.google.com/document/d/1K0B91lgeEiJTbT602VloA5arb6AkaTif-MLryaHmlYc/edit?usp=sharing).

#### Security fixes

The Security Response Committee (SRC) may contact you via the [Security Release Team][security-release-team]
mailing list if there are security fixes needed on the release branch.

Once the release has been confirmed to contain security fixes, the Branch Manager must inform the current
Release Team Lead and Lead Shadows. Information pertaining to these fixes is considered need-to-know and should not be disseminated to anyone else on the Release Team.

You must not make any public announcements regarding these fixes unless the SRC tells you to.

See the [Security Release Process](https://git.k8s.io/security/security-release-process.md) doc for more details.

[security-release-team]: https://groups.google.com/a/kubernetes.io/forum/#!forum/security-release-team

#### Debian and RPM Packaging

[Packaging the Official Release](https://github.com/kubernetes/sig-release/blob/master/release-engineering/packaging.md) is by conducted by employees at Google. Once `krel release --type=official …` has completed, **before sending out the email notification**, contact the [Release Managers Google Group][release-managers-group] to notify them that an official release for `vX.Y` is complete and the release is ready to be packaged.

The entire packaging process including the build and validation of the builds could take around 3-4 hours. It is preferable to have the DEB and RPM files ready prior to sending out the release notification email since, people worldwide will attempt to download the official release. Since packaging uses the release tag, it is important to [validate the release process](#release-validation).

Once the .deb and .rpm packages are done building, you can `grep` for `X.Y` e.g. `1.16` in the [yum](https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64/repodata/primary.xml) and [apt](https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages) repositories.

#### Release Validation

The following are some ways to determine if the release process was successful:

1. The build tag and release artifacts become [visible on GitHub at https://github.com/kubernetes/kubernetes/releases](https://github.com/kubernetes/kubernetes/releases)

2. The release is logged automatically by [k8s-release-robot](https://github.com/k8s-release-robot) in [k/sig-release](https://git.k8s.io/sig-release)

3. CHANGELOG-X.Y.md is automatically loaded into the kubernetes/kubernetes repo: [https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.16.md](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.16.md)



### Post-release Activities

#### Update kubekins-e2e variants

Set the `K8S_RELEASE` marker for the current release variant to `stable-x.y` which was currently `latest-x.y` in the [`variants.yaml` file for `kubekins-e2e`](https://github.com/kubernetes/test-infra/blob/fa43d4a7a6c88c0dedd0db83b250cec485b60736/images/kubekins-e2e/variants.yaml). ([reference PR review comment](https://github.com/kubernetes/test-infra/pull/13870#discussion_r313628808))

#### Cut next alpha

Recall that an alpha.0 of the next minor release was created during [branch creation](#branch-creation).

The previously created alpha.0 is now several commits behind `master`.
As an example, see the [comparison between the `v1.18.0-alpha.0` (after 1.17 branch creation) and `v1.18.0-alpha.1` (after 1.17.0 release) tags](https://github.com/kubernetes/kubernetes/compare/v1.18.0-alpha.0...v1.18.0-alpha.1).

To assist downstream consumers of Kubernetes, a new alpha should be cut to bring our next release tag to the tip of `master`.

Begin the release process with:

```shell
krel stage
```

Proceed with the [alpha release steps](#alpha-releases).

Example `1.18.0-alpha.1` release issue template: https://github.com/kubernetes/sig-release/issues/928

## Branch Management

This section discusses the methods in managing commits on the `release-x.y` branch.

### Branch Creation

During a `rc.0` release our release tooling creates a new release branch named `release-x.y`, where `x` and `y` are the major and minor versions of the next release, respectively.

Behind the scenes `krel` is doing a git branch create and git push. The branch is created in the staging phase and is pushed to the repository in the release phase.

`prow`’s [`branchprotector`](https://git.k8s.io/test-infra/prow/cmd/branchprotector/README.md) runs every hour at 54 minutes past the hour and automatically adds [branch protection](https://help.github.com/articles/about-protected-branches/) to any new branch in the `kubernetes/kubernetes` repo.

New release branch creation (for example: `release-1.18`) also automatically triggers an alpha.0 build for the subsequent release (for example: [`v1.19.0-alpha.0`](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.0-alpha.0)).

This means that the staging step will take about twice as long, as it will stage both versions `v1.18.0-rc.0` and `v1.19.0-alpha.0`. The release step will also be extended, but not substantially longer in time.

#### During the release creation

Before the nomock release job is started, run through the following tasks, **_putting an explicit hold_** on any PRs (to be removed once the release branch has been created):

- [Update test-infra configurations](#update-test-infra-configurations)
  - [Update Slack branch whitelists](#update-slack-branch-whitelists)
  - [Update milestone appliers](#update-milestone-appliers)
  - [Update milestone requirements](#update-milestone-requirements)
  - [Update e2e variants](#update-e2e-variants)

#### After the release creation

Once the new `release-x.y` branch is created, the [release jobs and dashboards should be generated and merged](#generate-release-branch-jobs).

### Update test-infra configurations

Before getting started, Branch Managers should:

- Fork the [test-infra repository](https://github.com/kubernetes/test-infra)
- Clone their fork of `kubernetes/test-infra`:

```shell
git clone git@github.com:<username>/test-infra.git
```

- [Install Bazel](https://docs.bazel.build/versions/master/install.html) or run Bazel inside a container
  - Running Bazel in a container is recommended over installing Bazel locally, as Bazel has many dependencies

#### Update milestone appliers

The [milestone applier plugin](https://git.k8s.io/test-infra/prow/plugins/milestoneapplier/milestoneapplier.go) automatically applies a GitHub milestone to pull requests after they have merged.

This only applies to repos that have the milestone applier configured and for pull requests that do not already have a milestone.

Update the `milestoneapplier` plugin configs for `kubernetes/kubernetes`:

- Remove configs for the unsupported release branches, if present
- Add config for the current release branch

Here's an [example PR](https://github.com/kubernetes/test-infra/pull/20075).

#### Update milestone requirements

If the [code freeze](#code-freeze) was enabled before creating the release branch, the milestone requirements wouldn't include the newest release branch.

Find the query config for `kubernetes/kubernetes` (in [config.yaml][config.yaml] file) with the code freeze enabled and add the newest release release branch.

[config.yaml]: https://github.com/kubernetes/test-infra/blob/3a6962d/config/prow/config.yaml

Here's an [example PR](https://github.com/kubernetes/test-infra/pull/20077).

#### Update e2e variants

Images used in Kubernetes e2e tests are generated via our [GCB Builder tool](https://github.com/kubernetes/test-infra/blob/master/images/builder/README.md).

The `variants.yaml` config file, used in conjunction with the GCB Builder, allows us to target various branches or branch combinations during CI tests. The `K8S_VERSION` variable maps to the version marker `latest-x.y.txt` file viewable in the [`kubernetes-release` GCS bucket](https://gcsweb.k8s.io/gcs/kubernetes-release/release/) for example, [`latest-1.17.txt`](https://storage.googleapis.com/kubernetes-release/release/latest-1.17.txt).

Update the [variants for the `kubekins-e2e` image](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e/variants.yaml).

- Remove the release variants for the unsupported releases
- Add an entry for the newest release variant
- Copy the `master` variant, rename it to the newest release and ensure the following:
  - The `K8S_RELEASE` marker for `experimental` matches `master`
  - The `CONFIG` marker for the newest release matches the variant/release name
  - The `K8S_RELEASE` marker for the newest release variant is `latest-x.y`
  - The `K8S_RELEASE` marker for every other release variant is `stable-x.y`

Create a PR with this change and wait for it to be merged ([example PR](https://github.com/kubernetes/test-infra/pull/20076)).

**Wait for the `test-infra-push-kubekins-e2e` presubmit to finish (you can [check on prow](https://prow.k8s.io/?job=post-test-infra-push-kubekins-e2e)).**

**`git pull` latest from `master` before continuing.**

#### Generate release branch jobs

This task should be done after the release is complete and previous PRs are merged. The following steps should be run from the test-infra repository's root.

1. Generate the new release branch jobs:

   ```shell
   bazel run //releng:prepare_release_branch
   ```

   Alternatively, if you want to run Bazel in a container, you can use the command such as:

   ```shell
   docker run -it \
      -v $PWD:/workspace/src/k8s.io/test-infra \
      -v $HOME/.cache/bazel:/root/.cache/bazel \
      -w /workspace/src/k8s.io/test-infra \
      gcr.io/k8s-testimages/launcher.gcr.io/google/bazel:latest-test-infra run //releng:prepare_release_branch
   ```

1. Update release dashboards in the [Testgrid config](https://git.k8s.io/test-infra/config/testgrids/kubernetes/sig-release/config.yaml) ([example commit](https://github.com/kubernetes/test-infra/pull/15023/commits/cad8a3ce8ef3537568b12619634dff702b16cda7)).
  - Remove the oldest release `sig-release-<version>-{blocking,informing}` dashboards
  - Add dashboards for the current release e.g., `sig-release-1.17-{blocking,informing}`

1. Check for and resolve configuration errors:

   ```shell
   bazel test //config/... //hack:verify-all
   ```

1. Issue a PR with the new release branch job configurations ([example PR](https://github.com/kubernetes/test-infra/pull/15023)).

1. Once the PR has merged, verify that the new dashboards have been created and are populated with jobs

    Examples:
    - [sig-release-1.17-blocking](https://testgrid.k8s.io/sig-release-1.17-blocking)
    - [sig-release-1.17-informing](https://testgrid.k8s.io/sig-release-1.17-informing)

1. [Announce in #sig-release and #release-management](https://kubernetes.slack.com/archives/C2C40FMNF/p1565746110248300?thread_ts=1565701466.241200&cid=C2C40FMNF) that this work has been completed

[sig-release-x.y-blocking]: https://testgrid.k8s.io/sig-release-1.17-blocking
[`krel ff`]: https://git.k8s.io/release

### Configure Merge Automation

Between the [Code Freeze](#code-freeze) and lifting Code Freeze ([Code Thaw](#code-thaw)) period, merging new code is restricted. The main focus is on fixing existing code and getting green test builds on Testgrid. Preventing new code is implemented by config changes for [tide]. The `master` and current release cycle branch (`release-x.y`) are the only branches affected during this period.

Code freeze initiates additional merge requirements, while Code thaw marks the switch back to the development phase. Look at the [release cycle timeline](https://github.com/kubernetes/sig-release/tree/master/releases) for the exact dates for code freeze and code thaw. Usually the the date for code thaw is flexible depending on pending PRs.

As Branch Manager, coordinate with the Release Lead on checking the exact config changes required to enable and disable merge restrictions.

#### Tide

Tide automates merges and is configured via a [config.yaml][config.yaml] file. Tide identifies PRs that are mergeable using GitHub queries that correspond to the configuration. Here is an example of what the query config for `kubernetes/kubernetes` looks like without additional constraints related to the release cycle:

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
    - do-not-merge/needs-kind
    - do-not-merge/needs-sig
    - needs-rebase
```

During code freeze, two queries are used instead of just one for the `kubernetes/kubernetes` repo. One query handles the `master` and current release branches while the other query handles all other branches. The partition is achieved with the `includedBranches` and `excludedBranches` fields.

#### Code Freeze

Code freeze means the code is "frozen" and there will not be any further modifications from the developers.

Branch managers create the "freeze" by altering the Tide merge requirements for the `master` and current `release-x.y` branch from the other branches (enforced by Tide with two queries).

We only add additional merge requirements for PRs to these two branches for code freeze:

- PRs must be in the GitHub milestone for the current release.

Milestone requirements are configured by adding `milestone: vX.Y` to a query config.

It is also helpful to remind [#sig-testing](https://kubernetes.slack.com/messages/C09QZ4DQB) when code freeze starts so they know not to do any major changes.

```yaml
  - repos:
    - kubernetes/kubernetes
    milestone: v1.16
    includedBranches:
    - master
    - release-1.16
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
    - release-1.16
    labels:
    - lgtm
    - approved
    - "cncf-cla: yes"
    missingLabels:
      ...
```

Example PR:

 - [1.18](https://github.com/kubernetes/test-infra/pull/16603)
 - [1.17](https://github.com/kubernetes/test-infra/pull/15301)

#### Code Thaw

Code Thaw removes the release cycle merge restrictions and replaces the two queries with one single query. We remain in this state until the next Code Freeze.

```yaml
  - repos:
    - kubernetes/kubernetes
    labels:
    - lgtm
    - approved
    - "cncf-cla: yes"
    missingLabels:
    ...
```

Update the `milestoneapplier` plugin configs for the following repos to the **_next_** milestone:

- `kubernetes/enhancements`
- `kubernetes/kubernetes`
- `kubernetes/release`
- `kubernetes/sig-release`
- `kubernetes/test-infra`

Example PRs:

- [1.18](https://github.com/kubernetes/test-infra/pull/16821)

### Branch Fast Forward

Prior to running `krel ff`, you will need membership in the [Release Managers GitHub Group](https://github.com/orgs/kubernetes/teams/release-managers)

To compile `krel`, just install it from the [`git.k8s.io/release`](https://git.k8s.io/release) repository:

```shell
make release-tools
```

Command invocation:

```shell
krel ff --branch release-x.y
```

Where `x.y` is the is release cycle version e.g. `1.18`

This is done daily as soon as the `release-x.y` branch has been cut (which happens after `rc.0` is released).

Earlier in the release cycle, the exact time of running [`krel ff`] can be at the discretion of the branch manager; as agreed upon with the release lead.

Later in the release cycle, it will become more important to align with the release lead and the CI signal team.

The exact time for pulling in the changes from `master` to the release branch might depend on the features that are merging. Considerations could be:

- Run [`krel ff`] sooner, before `$bigFeature` so we have a signal in the release branch before that feature was brought in
- Run [`krel ff`] later, after `$theOtherFeature` has been merged, so we get signal on that feature from both the master and the release branch

The first time the [`krel ff`] executes, it will:

- clone `kubernetes/kubernetes` to a temporary directory (`/tmp/k8s`)
- precheck that the provided branch is a release branch and can be forwarded
- merge the latest master ref into the release branch
- push the results to the GitHub remote release branch

It is highly recommended to run the following `git` commands as shown below:

```shell
Validate things look okay before pushing…

Check for files left uncommitted using:

    git status -s

Validate the fast-forward commit using:

    git show

Validate the changes pulled in from master using:

    git log origin/release-1.16..HEAD
```

You should see something like this when running `git show`:

```shell
commit d17cd2356993283316b10491a4beaad0931bbff3
Merge: 35a287caa6 6348200c92
Author: Yang Li <idealhack@gmail.com>
Date:   Tue Sep 10 03:47:38 2019 +0000

    Merge remote-tracking branch 'origin/master' into release-1.16
```

Sometimes the commit may or may not delete a Changelog.

It is critically important to run the following during code freeze. Look through the git log via:

```shell
git log origin/release-x.y..HEAD
```

Each and every commit ought to be something the release team has visibility into. Each merge commit indicates a PR number and owner. Invest time in researching these.

If unexpected code was merged to master, use your judgment on whether to escalate to the release team and SIG leadership associated with PR to question whether the commit is truly targeted for the release.

**The release team and the branch manager are the final safety guard on the release content.**

Upon a successful mock execution of `krel ff`, proceed with:
`krel ff --branch release-x.y --nomock`

Subsequent runs will simply be merging in changes from `master` to the branch, keeping the previous API fix-up commits on the branch.

Note that the merged commits from `krel ff` e.g. with `d17cd23569` from the above `git show` snippet will be tested against on Testgrid [sig-release-x.y-blocking].

Once code freeze is lifted ([code thaw](#code-thaw) occurred), then there will be no need to `krel ff` from `master` onto the release branch. Instead, PRs that need to be merged onto the release branch are cherry-picked over from `master`.

### Reverts

During code freeze it is especially important to first look at the list of commits on `master` since the prior fast forward, scanning their content and issues/PRs to ensure they are changes expected for this milestone.

**The merge-blocking mechanisms are relatively weak.**

It is possible still for some people to write directly to the repo (bypassing blocking mechanisms) as well as for unintentional milestone maintainers to approve a merge incorrectly. The branch manager is the last line of defense.

If code incorrectly merges onto `master` it should be reverted in `master`. Alternatively, release branch management must go to all cherry picks, picking around the incorrectly added commit.

### Cherry Picks

Once code freeze is lifted, and for the post-release patch management process, commits are cherry picked from `master`.

It's important to take note of [what is considered as a release blocking issue or PR](https://github.com/kubernetes/sig-release/blob/master/release-blocking-jobs.md) and identify PRs and issues as soon as possible. Ensure that there's work being done to release blocking PRs completed prior to the official release day.

Let the release lead know if there's not enough attention placed on the release blocking PR. This way we can prevent from prolonging the official release.

The current documentation in the [contributor guide for cherry picks](https://git.k8s.io/community/contributors/devel/sig-release/cherry-picks.md) should be generally sufficient. There are a couple prerequisites to running the script which are outlined in that guide.

The cherry pick script is also fairly self documenting in terms of how to invoke the command.

Running [cherry_pick_pull.sh](https://git.k8s.io/kubernetes/hack/cherry_pick_pull.sh) creates a cherry pick PR against the specified `release-x.y` branch. The content of the cherry pick PR is taken from a PR that was made against `master`. Once the appropriate approval is given to the cherry pick PR and has met the requirements set by the [k8s-ci-robot](https://github.com/k8s-ci-robot), this will trigger test re-runs on the PR. As soon as these tests all pass, add the `cherry-pick-approved` label.

For example, [#79044](https://github.com/kubernetes/kubernetes/pull/79044) is the cherry pick PR of [#78999](https://github.com/kubernetes/kubernetes/pull/78999). Once [#79044](https://github.com/kubernetes/kubernetes/pull/79044) is tagged with the `cherry-pick-approved` label, Prow begins the merge onto the release branch.

There has been quite a bit of recent discussion (see: [1](https://github.com/kubernetes/community/pull/2408), [2](https://github.com/kubernetes/community/pull/1980)) around improving both the cherry pick process process and its documentation.

After the official release has been published, the [Release Managers](../../release-managers.md#release-managers) will take over in handling cherry picks. In the time between [code thaw](#code-thaw) and the official release, cherry picks are the responsibility of the branch management team.

Consider the following when assessing the cherry-picks:

- Check regularly if there are new cherry picks with
  [`is:open is:pr base:release-1.18 label:do-not-merge/cherry-pick-not-approved`][cherry-pick-query]
- Consider that each cherry-pick diverges the latest release candidate that has been cut from the bits to be released as the official release
- Engage with the cherry pick requester: How important is that cherry-pick, can it be pushed to a later release (patch or even minor), ... ?
- Discuss (especially controversial) cherry-picks in [#sig-release] or at the burndown meeting if you are unsure
- If certain cherry-picks merge, does this mean we want another release
  candidate, more time for the release candidate to soak (e.g. over the
  weekend)?

[cherry-pick-query]: https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+base%3Arelease-1.18+label%3Ado-not-merge%2Fcherry-pick-not-approved

## Staging Repositories

The [publishing-bot](https://github.com/kubernetes/publishing-bot) is responsible for publishing the code in [staging](https://git.k8s.io/kubernetes/staging/src/k8s.io) to their own repositories.

The bot also syncs the Kubernetes version tags to the published repos, prefixed with `kubernetes-`. For example, if you check out the `kubernetes-1.16.0` tag in client-go, the code you get is exactly the same as if you check out the `v1.16.0` tag in Kubernetes, and change the directory to `staging/src/k8s.io/client-go`.

[client-go](https://github.com/kubernetes/client-go) follows [semver](http://semver.org/) and has its own release process. This release process and the publishing-bot are maintained by SIG API Machinery. In case of any questions related to the published staging repos, please ask someone listed in the following [OWNERS](https://git.k8s.io/publishing-bot/OWNERS) file.

The bot runs every four hours, so it might take sometime for a new tag to appear on a published repository.

The client-go major release (e.g. `v1.18.0`) is released manually a day after the main Kubernetes release.

## Debugging

To debug `krel stage/release` you can set the log level to `debug` by doing
`krel --log-level debug [args]`. There is also a `trace` log level for maximum
output verbosity. The log level is passed correctly to the Google Cloud console
and can be inspected there.

## Search past builds

To search past `cloudbuilds` to make any kind of analysis and check metrics you can use the Google Cloud Console for that.
You can access [Google Cloud Build History](https://console.cloud.google.com/cloud-build/builds?project=kubernetes-release-test)

There you can see all the `cloudbuilds`  that already ran or if there is any one running in the moment you can see that as well.

To filter for a specific build or set of builds you can use the `Filter Builds` textbox. When you click there it opens a dropdown box to you select which kind of keys you want to filter.

For example you can select `Tags` and then add the tags you want to filter, like, `Tags: release-1.18 Status: Successful`. This query in the [Google Cloud Build](https://console.cloud.google.com/cloud-build/builds?project=kubernetes-release-test&pageState=(%22builds%22:(%22f%22:%22%255B%257B_22k_22_3A_22Tags_22_2C_22t_22_3A10_2C_22v_22_3A_22_5C_22release-1.18_5C_22_22_2C_22s_22_3Atrue_2C_22i_22_3A_22tags_22%257D_2C%257B_22k_22_3A_22Status_22_2C_22t_22_3A10_2C_22v_22_3A_22_5C_22Successful_5C_22_22_2C_22s_22_3Atrue_2C_22i_22_3A_22status_22%257D%255D%22)))


#### Limitation

Looks like in the Google Cloud Build History you cannot set more than one `tag` when using the `AND` operator. The query does not bring anything if you add, for example, `Tags: release-1.18 Tags: STAGE`.
Besides the fact that exists.


## References

- [Release Tools Documentation](https://github.com/kubernetes/release/blob/master/README.md)
- [Generic Release Steps](https://docs.google.com/document/d/1x-GQDZpKk3WajtSnO0axDazE9Xs2mOSVgjziIuTWNO0/edit)
- [Detailed overview (Cutting v1.15.0-alpha.2)](https://docs.google.com/document/d/1Xv5w_eNvLvD-nNinMNqQAh0qlzee8btqAyHyFFMz3z4/edit?usp=sharing)
- If you prefer a video walk-through, see [cutting release candidate v1.15.0-rc.1](https://youtu.be/ldYt1elShD4).

### Test Infra references

Concerns and questions can be directed to [#testing-ops](https://kubernetes.slack.com/messages/C7J9RP96G) and [#sig-testing](https://kubernetes.slack.com/messages/C09QZ4DQB). For urgent matters, please contact the user group [@test-infra-oncall](https://get.slack.help/hc/en-us/articles/212906697-Create-a-user-group#browse-user-groups-and-view-members) on Slack.

- [Prow](https://github.com/kubernetes/test-infra/tree/master/prow) the Kubernetes-based CI/CD system
  - [PR Status](https://prow.k8s.io/pr)
  - [Tide Status](https://prow.k8s.io/tide)
- [Gubernator](https://github.com/kubernetes/test-infra/tree/master/gubernator) displays Kubernetes test results stored in Google Cloud Storage (GCS)
- [PR Dashboard](https://gubernator.k8s.io/pr)
- [Hound](https://cs.k8s.io/) a Kubernetes Codebase Search
- [Kubernetes DevStats](https://k8s.devstats.cncf.io/) displays Kubernetes Developer Productivity
- [Kubernetes On-call Rotation](https://go.k8s.io/oncall) displays the current Test Infra person on call
- [APISnoop](https://apisnoop.cncf.io/) snoops on the Kubernetes OpenAPI communications
  - [Source](https://github.com/cncf/apisnoop)
- [TestGrid](https://testgrid.k8s.io/) displays Kubernetes CI tests results in grids
  - [Source](https://github.com/GoogleCloudPlatform/testgrid)
  - [TestGrid Open-sourcing Planning](https://github.com/kubernetes/test-infra/issues/10409)
  - [Displaying Kubernetes Conformance Results with Testgrid](https://docs.google.com/document/d/1lGvP89_DdeNO84I86BVAU4qY3h2VCRll45tGrpyx90A/edit)
- [Triage Dashboard](https://storage.googleapis.com/k8s-gubernator/triage/index.html) displays Kubernetes aggregated failures

## Background information

You may have seen reference to `./anago` when cutting releases but there's no mention of using `anago` in this handbook, see:

- [Summary of discussion with Caleb about moving from `anago` to `gcbmgr`](https://groups.google.com/d/topic/kubernetes-milestone-burndown/YdHa51d95VI/discussion)

>  Note: To access this forum, you will need to join the [kubernetes-milestone-burndown](https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown) Google group.

See the branch management process prior to v1.12 when `anago` was still used.

- [Branch Management Playbook](https://docs.google.com/document/d/1Qoqz5IZYBp6A-Q_R9CGhMAc358ykOiE49GXZU9r5usQ/edit#heading=h.s71iha1627td)

>  Note: To view this document, you will need to join the [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev) Google group.

[kubernetes-release-team]: https://groups.google.com/a/kubernetes.io/g/release-team
[release-managers]: /release-managers.md#release-managers
[release-managers-group]: https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers
