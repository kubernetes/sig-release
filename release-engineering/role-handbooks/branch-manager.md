# Branch Manager Handbook <!-- omit in toc -->

- [Overview](#overview)
  - [Minimum Skills and Requirements](#minimum-skills-and-requirements)
  - [Associates Expectations](#associates-expectations)
- [Prerequisite](#prerequisite)
  - [Release Team Onboarding](#release-team-onboarding)
  - [Branch Management Onboarding](#branch-management-onboarding)
  - [Safety Check](#safety-check)
- [The Release Process](#the-release-process)
  - [Alpha Stage](#alpha-stage)
  - [Alpha Releases](#alpha-releases)
  - [Beta Releases](#beta-releases)
    - [Branch Creation](#branch-creation)
  - [Release Candidates](#release-candidates)
  - [Official Stage and Release](#official-stage-and-release)
  - [Post-release Activities](#post-release-activities)
    - [Debian and RPM Packaging](#debian-and-rpm-packaging)
  - [Release Validation](#release-validation)
  - [Create CI/Presubmit jobs](#create-cipresubmit-jobs)
  - [Configure Merge Automation](#configure-merge-automation)
  - [Tide](#tide)
  - [Code Freeze](#code-freeze)
  - [Code Thaw](#code-thaw)
- [Branch Content Management](#branch-content-management)
  - [Branch Fast Forward](#branch-fast-forward)
  - [Reverts](#reverts)
  - [Cherry Picks](#cherry-picks)
- [Staging Repositories](#staging-repositories)
- [Debugging](#debugging)
- [References](#references)
- [Background information](#background-information)

# Overview

The release branch manager is responsible for cutting a version of [Kubernetes]. Each release is a three month cycle where as branch manager:

1. You will cut releases for the vX.Y cycle as specified on the Timeline in `sig-release/releases/release-x.y/README.md`.
   - e.g. For cycle v1.15 you're expected to allocate time to cut releases on the dates detailed on [sig-release/releases/release-1.15/README.md][release-1.15].
   The bulk of your time commitment is during release cut days.
2. You must allocate time to setup your system to run the release tools; eventually you'll have a routine going and become more familiar with the process.
3. Participate in weekly one hour release team meetings.
4. Run `./branchff` on a daily basis as soon as the release branch i.e. `release-x.y` [is created](#branch-creation). (Less than 45mins)
5. Your time commitment increases during code freeze (when approaching the official release), expect 3 or more 1 hour meetings in a week.
6. Select Associates and guide them in preparation to become the section lead for the next cycle.
7. Delegate tasks to the Associates (where applicable), so that they may exercise the release process.
8. Update this handbook where appropriate for the next release cycle.
9. Have willingness to accommodate with different timezone esp. for the release team and your Associates.
10. Participate in conversations that happen on [#sig-release] and [#release-management]

To get a better overview of the time it takes to run the release tools, you can take a look at the collected metrics from each of these [release cut issues][release-cut-issues].

[Branch Management diagram](https://docs.google.com/presentation/d/1usEbwHMSC8vR7HvbxHJBOj2ISdTkw9rmufQUq7fkIl4/edit?ts=5cc0de62#slide=id.g577153f745_1_405) illustrating the process over a 3 month [release lifecycle](https://docs.google.com/presentation/d/1usEbwHMSC8vR7HvbxHJBOj2ISdTkw9rmufQUq7fkIl4/edit?ts=5cc0de62#slide=id.g577153f745_3_0).

[Kubernetes]: https://github.com/kubernetes/kubernetes/releases
[release-1.15]: https://github.com/kubernetes/sig-release/tree/master/releases/release-1.15
[#sig-release]: https://kubernetes.slack.com/messages/C2C40FMNF
[#release-management]: https://kubernetes.slack.com/messages/CJH2GBF7Y
[release-cut-issues]: https://github.com/kubernetes/sig-release/issues?utf8=%E2%9C%93&q=is%3Aissue+1.15.0+is%3Aclosed+

## Minimum Skills and Requirements

* Familiarity with basic Unix commands and able to debug shell scripts.
* Familiarity with branched source code workflows via `git` and associated `git` command line invocations.
* General knowledge of Google Cloud (Cloud Build and Cloud Storage).
* Open to seeking help and can communicating clearly.
* [Kubernetes Community Membership](https://github.com/kubernetes/community/blob/master/community-membership.md#member)

## Associates Expectations

This is not a rigid list of obligations from Associates under branch management, treat this as a list of tasks that we would like to see the Associates participate in.

1. Attend most of the release team meetings; you're highly encouraged to give suggestions, ask questions, voice thoughts, etc.
1. Know the release dates from the [release cycle Timeline](https://github.com/kubernetes/sig-release/tree/master/releases) and offer help if possible.
1. Find ways or make/participate in discussion to improve the [release tools].
1. Question the content of this handbook. *“The greatest enemy of knowledge is not ignorance, it is the illusion of knowledge.”*
1. Be curious, and try to make the most out of this opportunity.

# Prerequisite

This is a collection of requirements and conditions to fulfil when taking on the role as branch manager.

## Release Team Onboarding

**Please review and work through the tasks in the [Release Team Onboarding Guide](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md) first, before proceeding with the section specific to branch management below.**

## Branch Management Onboarding

A list of To Do(s) to get started as Branch Manager:

- [ ] Contact the [Release Managers Google Group][release-managers-group] to identify yourself as the incoming release branch manager for the current release team and request to be added to the special privilege group for the `kubernetes-release-test` GCP project that's used to build the releases
   * Similar access later in the cycle should be granted to the associates depending on how they progress and what actions they prove able to step up to exercise during the cycle.
- [ ] Request permission to post on [kubernetes-announce][k-announce-list] via owner contact form [here][k-announce-request]
   * If you haven't received access after 24 hrs, contact the [Release Team][kubernetes-release-team].
- Machine setup:
   - [ ] Linux OS
      * MacOS/Windows are not supported by [release tools] today. However, running inside a Linux container on MacOS via Docker works well.
      * See "Cutting v1.15.0-alpha.2" under [References](#References) for an example Dockerfile.
   - [ ] Setup SSH keys for GitHub (either static .ssh/config or ssh agent works)
   - [ ] Install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)
   - [ ] Run `gcloud init` using the identity (i.e. email address) that you had authorized for the GCP project
   - [ ] `git clone git@github.com:kubernetes/release.git`
   - [ ] ability to run `sendmail` from local Unix command line
      * You may send the email notification manually to [kubernetes-announce][k-announce-list] by taking the contents from the Google Cloud Bucket: [`Buckets/kubernetes-release/archive/anago-vX.Y.0-{alpha,beta,rc}.z`](https://console.cloud.google.com/storage/browser/kubernetes-release/archive/?project=kubernetes-release-test)
- Join these mailing lists to stay current:
   - [ ] [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
   - [ ] [kubernetes-release-team](https://groups.google.com/forum/#!forum/kubernetes-release-team)
   - [ ] [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev)


[k-announce-list]: https://groups.google.com/forum/#!forum/kubernetes-announce
[k-announce-request]: https://groups.google.com/forum/#!contactowner/kubernetes-announce
[release tools]: https://github.com/kubernetes/release

## Safety Check

The following command can help verify that your clone of the [release tools] are up-to-date, that your setup is fully configured, and your `gcloud` identity is authorized for the release builds:

`./gcbmgr`
   * should run successfully and even show some green colored "OK" words

# The Release Process

**General overview**:

Public build artifacts are published and an email notification goes out to the community. You will become very familiar with the following commands over the course of the 3 month release cycle:

```bash
./gcbmgr stage
./gcbmgr release ${{BRANCH_NAME}} --buildversion=${{VERSIONID}} --nomock
# Only for the official release: Inform the Google team to complete the corresponding Deb and RPM builds
./release-notify vX.Y.0-{alpha,beta,rc}.Z
./release-notify vX.Y.0-{alpha,beta,rc}.Z --nomock --mailto=${{YOUREMAILADDRESS}}[a][b]
```

There are more examples of the release process under the [References](#references) section.

It is also highly recommended to glance over the [Release Commands Cheat Sheet](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/patch-release-manager#release-commands-cheat-sheet).

**General bookkeeping**:

Prior to cutting a release version, [open a "Cut a Release" issue](https://github.com/kubernetes/sig-release/issues/new?template=cut-release.md&title=Cut+1.x.y-%7Balpha%2Cbeta%2Crc%7D.z+release) on [k/sig-release](https://github.com/kubernetes/sig-release).

On the issue template, there are comments describing the predefined items that need to be completed.

For the item `Collect metrics, links...`:

You can make a copy of this spreadsheet to collect metrics of build times and include links to the GCP build console:

[Branch Management Log](https://docs.google.com/spreadsheets/d/1gbr2byg7AmGvVv6onZtgowa729KZcyYTyH82qn1czK8/edit?usp=sharing)

A section of the log above is usually copied over as a comment on the issue. See [this thread](https://github.com/kubernetes/sig-release/issues/756#issuecomment-521065084) for cutting [1.16.0-beta.0](https://github.com/kubernetes/sig-release/issues/756).

After having thoroughly read the section on cutting a release version of the handbook, and that all items on the checklist have completed (you may include notes on events that was unique to cutting that release version as comments), close the issue with `/close` as a comment the issue thread.

## Alpha Stage

Start staging a build by running:

`./gcbmgr stage master`
   * returns relatively quick
   * provides a link to GCP where you can track the process of the build

Early in the release cycle, it is likely that the build might fail. By default the `gcbmgr stage master` command automatically looks for a place where [release master blocking tests](https://k8s-testgrid.appspot.com/sig-release-master-blocking) have green results, which traditionally has not happened in Kubernetes on an ongoing basis.

WE REALLY WANT (and need) TO GET THERE. Quality needs to be a continual focus. But in the meantime, acknowledging today especially for an early alpha or beta release, it is possible to just build via:

`./gcbmgr stage master --build-at-head`
   * Rather than having `gcbmgr` pick a candidate by analyzing test data from the commit history that had no fails and building automatically from that point, we instead indicate we want to build explicitly from HEAD (the last commit on the current branch).
   * This takes time (approximately 1 hour is the current norm).  It’s building all the bits for a bunch of target operating systems and hardware architectures.

`./gcbmgr list`
   * You should now see your new job running.

`./gcbmgr tail`
   * To observe the output log for the build (same as on Google Cloud Console).
   * Scan output for failures and warnings.
   * Successful build information is displayed for your next steps, including a build version identifier for the staged build, for example `v1.12.0-alpha.0.2622+7ac32a4f7a7ecf`. This string is passed on to the release scripting, which is nicely displayed for you to copy and paste.

For more information on the usage of `./gcbmgr` run `./gcbmgr --help` or inspect the [`gcbmgr` script](https://github.com/kubernetes/release/blob/master/gcbmgr).

## Alpha Releases

After staging comes the actual releasing, but this may be intentionally delayed. For example, the branch manager may stage a build from the head of the release branch late in the release cycle, doing so in the morning so that it is fully build and would be releasable in the afternoon (pending CI tests will results from the head of the branch). If the results are good and the release team gives the go ahead, you can initiate the publishing portion of the release process. If staging the build only happened after the receipt of clean CI tests results, this will delay completing the entire release process for a release version (alpha,beta,rc,...).  This of course presumes reproducible builds and that CI builds and tests are meaningful relative to the release builds. There is always a risk that these diverge, and this needs managed broadly by the project and the release team.

Use the `--buildversion=` as specified in the output when `gcbmgr` is done with the stage command.

`./gcbmgr release master --buildversion=v1.12.0-alpha.0.N+commit-hash`
   * This copies the staged build to public GCP buckets at well-known urls for the truncated release version string. The unique build staging identifier will subsequently be just “v1.12.0-alpha.1”, even though the staged build had an “alpha.0” in its name
   * This can be confusing. The v1.12.0-alpha.0 tag was created automatically in the past when the v1.11 branch was forked, but it wasn’t actually build.

Note:
> Any `./gcbmgr` command without the `--nomock` flag is a dry run. It is highly encouraged to dry run first before letting `gcbmgr` take any actual impact on the release process. All this mock building/releasing can help you verify that you have a working setup!

For example, to execute an actual run:

`./gcbmgr release master --buildversion=v1.12.0-alpha.0.N+commit-hash --nomock`

Note:
> This run may fail. Mock builds can only be mock released. A nomock release requires a nomock build to be staged.

Builds against the `master` branch are implicitly the next alpha. `gcbmgr` and `anago` automatically finds and increments the current build number.

## Beta Releases

### `beta.0` and Branch Creation

During a `beta.0` release e.g., `1.16.0-beta.0`, our release tooling creates a new release branch named `release-x.y`, where `x` and `y` are the major and minor versions of the next release, respectively.

Behind the scenes `anago` is doing a git branch create and git push.

`prow`’s [`branchprotector`](https://git.k8s.io/test-infra/prow/cmd/branchprotector/README.md) runs [every hour at 54 minutes past the hour](https://github.com/kubernetes/test-infra/blob/master/config/jobs/kubernetes/test-infra/test-infra-trusted.yaml#L867) and automatically adds [branch protection](https://help.github.com/articles/about-protected-branches/) to any new branch in the `kubernetes/kubernetes` repo.

New release branch creation (for example: `release-1.16`) also automatically triggers an alpha.0 build for the subsequent release (for example: [`v1.17.0-alpha.0`](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.0-alpha.0)).

**n.b.** This means that the staging step will take about twice as long, as it will stage both versions `v1.16.0-beta.0` and `v1.17.0-alpha.0`. The release step will also be extended, but not substantially longer in time.

### `beta.1` and Other Beta Releases

Builds against a `release-x.y` branch are implicitly a next beta. `gcbmgr` and `anago` automatically find and increment the current build number. The command example below is to stage a build for a beta release:

`./gcbmgr stage release-1.16 --build-at-head --nomock`

This being the first build from the newly created release branch, the publication of this build does not send out the typical changelog detail notification, but rather will only send a shorter message with subject line "[k8s release-1.15 branch has been created](https://groups.google.com/forum/#!topic/kubernetes-announce/Gu2JYa4BzAg)".

To publish (release) the build artifacts from staging beta for example, run:

`./gcbmgr release release-1.16 --buildversion=v1.16.0-alpha.3.N+commit-hash --nomock`

When the new `release-x.y` branch is created, it marks the beginning of another stage in the release process.

The following tasks should take place as soon as possible:

1. Update the [Slack branch whitelist](https://github.com/kubernetes/test-infra/blob/89e6e9743b74a646ca883c21a127773e8eb35e7d/prow/plugins.yaml#L211-L230) ([example PR](https://github.com/kubernetes/test-infra/pull/13869)):
   - Find the current branch whitelist config ([`prow/plugins.yaml`](https://github.com/kubernetes/test-infra/blob/master/prow/plugins.yaml), grep for `branch_whitelist:`)
   - Remove the oldest release branch block e.g., `release-1.12`
   - Add an entry for the newest release branch e.g., `release-1.16`
   - Add all current [Patch Release Team members](/release-managers.md#patch-release-team) to all `kubernetes/kubernetes` release branches
   - Remove [Branch Managers](/release-managers.md#branch-managers) from any previous release branches
   - Add all current [Branch Managers](/release-managers.md#branch-managers)
2. [Create CI/Presubmit jobs for the new release](#create-cipresubmit-jobs)
3. [Run `./branchff` approximately a day after the branch has been created]((#branch-fast-forward))

## Release Candidates

Adding the `--rc` flag switches behavior on to building release candidates. Again `gcbmgr` and `anago` automatically finds and increments the current build number. For example:

`./gcbmgr stage release-1.12 --rc --build-at-head --nomock`

To publish the build artifacts (release), as usual use the `--buildversion=` number as specified in the output when `gcbmgr` is done with the stage command.

In an perfect world, `rc.1` and the official release are the same commit. To get as close to that perfect state as we can, the following things should be considered:

1. PRs tagged with the release cycle milestone should have all merged onto the `master` branch:

   For example, there should be no open PRs tagged with the v1.14 milestone, [`is:pr is:open milestone:v1.14`][pr-milestone-query] .

   This means you and the release team should push for PRs to get merged before the code freeze is lifted or determine if the open PRs can be removed from the milestone and be merged in the next release cycle.

2. When to staged and release `rc.1`:

   Make sure that all the changes that have been merged onto `master`, make it onto the release branch. Run [`./branchff`](#branch-fast-forward to see the state of the two branches and pull any remaining PRs from `master` onto the release branch.

   At this point in time, `master` and the release branch should have the same commits. Nothing new gets merged onto `master`, since code freeze is not lifted. Therefore, it is safe to cut the release candidate.

3. Factors that determine if Code Freeze can be lifted:

   - Zero pending PRs and no open issues tagged with the release cycle milestone.
   - No failing X.Y-blocking tests, for example the [sig-release-1.15-blocking](https://testgrid.k8s.io/sig-release-1.15-blocking) dashboard should not have any red failing test builds.

   Note:
   > If there are non-zero pending PRs, open issues or failing tests, there is high confidence that the issue is understood and the solution/PR can be [cherry picked](#cherry-picks) over to the release branch between the release candidate(s) and official release.

Technically we can keep code freeze in place after `rc.1` was cut. However, we should aim at lifting code freeze relatively quickly after `rc.1`.

Otherwise we might have a mix of PRs against master, some have been merged in code freeze and for the milestone, just after `rc.1`, and others have been merged when code freeze has been lifted. We might miss this specific PR in the plethora of PRs that [tide] merges after code thaw, and we might miss that this PR actually needs to be cherry-picked into the release branch.

[pr-milestone-query]: https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.14
[tide]: https://git.k8s.io/test-infra/prow/tide

## Official Stage and Release

To initiate staging the build for the official release, the `--official` flag is used. For example:

`./gcbmgr stage release-1.12 --official --build-at-head --nomock`

In addition to `v1.12.n` this will also build and stage the subsequent patch's
`beta.0`, in this example `v1.12.(n+1)-beta.0`. Similar to [creating a new branch](#branch-creation), the staging step will take about twice as long, the
release step will also take a couple of minutes more.

When staging is done, as usual, use the command `./gcbmgr release` with the `--buildversion=` specified when `./gcbmgr stage` is done.

To better prepare and see what to expect, this is a sequence of events that took place on past [official release days](https://docs.google.com/document/d/1K0B91lgeEiJTbT602VloA5arb6AkaTif-MLryaHmlYc/edit?usp=sharing).

## Post-release Activities

- Set the `K8S_RELEASE` marker for the current release variant to `stable-x.y` in the [`variants.yaml` file for `kubekins-e2e`](https://github.com/kubernetes/test-infra/blob/fa43d4a7a6c88c0dedd0db83b250cec485b60736/images/kubekins-e2e/variants.yaml). ([reference PR review comment](https://github.com/kubernetes/test-infra/pull/13870#discussion_r313628808))

### Debian and RPM Packaging

[Packaging the Official Release](https://github.com/kubernetes/sig-release/blob/master/release-engineering/packaging.md) is by conducted by employees at Google. Once `./gcbmgr release --offical ...` has completed, **before sending out the email notification**, contact the [Release Managers Google Group][release-managers-group] to notify them that an official release for `vX.Y` is complete and the release is ready to be packaged.

The entire packaging process including the build and validation of the builds could take around 3-4 hours. It is preferable to have the DEB and RPM files ready prior to sending out the release notification email since, people worldwide will attempt to download the official release. Since packaging uses the release tag, it is important to [validate the release process](#release-validation).

Once the .deb and .rpm packages are done building, you can `grep` for `X.Y` e.g. `1.15` in the [yum](https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64/repodata/primary.xml) and [apt](https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages) repositories.

## Release Validation

The following are some ways to determine if the release process was successful:

1. The build tag and release artifacts become [visible on GitHub at https://github.com/kubernetes/kubernetes/releases](https://github.com/kubernetes/kubernetes/releases)

2. The release is logged automatically by [k8s-release-robot](https://github.com/k8s-release-robot) in [k/sig-release](https://git.k8s.io/sig-release)

3. CHANGELOG-X.Y.md is automatically loaded into the kubernetes/kubernetes repo: [https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md)

---

## Create CI/Presubmit jobs

This takes place around week 6-7, as soon as the new [`release-x.y` branch is created](#branch-creation).

1. Clone the [test-infra repository](https://github.com/kubernetes/test-infra) e.g., `git clone git@github.com:kubernetes/test-infra.git`

2. [Install Bazel](https://docs.bazel.build/versions/master/install.html)

3. Update [`images/kubekins-e2e/variants.yaml`](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e/variants.yaml). ([example PR](https://github.com/kubernetes/test-infra/pull/13876))

   (The `variants.yaml` allows us to target various branches or branch combinations during CI tests. The `K8S_VERSION` variable maps to the version marker files viewable in the [`kubernetes-release` GCS bucket](https://gcsweb.k8s.io/gcs/kubernetes-release/release/) e.g., [`latest-1.16.txt`](https://storage.googleapis.com/kubernetes-release/release/latest-1.16.txt))

   - Remove the oldest release variant e.g., `'1.12'`
   - Add an entry for the newest release variant e.g., `'1.16'`
   - Ensure the following:
     - The `K8S_RELEASE` marker for `experimental` matches `master`
     - The `K8S_RELEASE` marker for the newest release variant is `latest-x.y`
     - The `K8S_RELEASE` marker for every other release variant is `stable-x.y`

   Here's an example of a correct (as of time of writing (`1.16.0-beta.0`)) [`variants.yaml` for `kubekins-e2e`](https://github.com/kubernetes/test-infra/blob/fa43d4a7a6c88c0dedd0db83b250cec485b60736/images/kubekins-e2e/variants.yaml):

   ```yaml
   variants:
      experimental:
         CONFIG: experimental
         GO_VERSION: 1.12.7
         K8S_RELEASE: stable
         BAZEL_VERSION: 0.28.1
         UPGRADE_DOCKER: 'true'
      master:
         CONFIG: master
         GO_VERSION: 1.12.7
         K8S_RELEASE: stable
         BAZEL_VERSION: 0.23.2
      '1.16':
         CONFIG: '1.16'
         GO_VERSION: 1.12.7
         K8S_RELEASE: latest-1.16
         BAZEL_VERSION: 0.23.2
      '1.15':
         CONFIG: '1.15'
         GO_VERSION: 1.12.7
         K8S_RELEASE: stable-1.15
         BAZEL_VERSION: 0.23.2
      '1.14':
         CONFIG: '1.14'
         GO_VERSION: 1.12.5
         K8S_RELEASE: stable-1.14
         BAZEL_VERSION: 0.21.0
      '1.13':
         CONFIG: '1.13'
         GO_VERSION: 1.11.5
         K8S_RELEASE: stable-1.13
         BAZEL_VERSION: 0.18.1

   # Note that the last block i.e., the `1.12` block was removed
   ```

4. Create a PR with this change and wait for it to be merged. ([example PR](https://github.com/kubernetes/test-infra/pull/13876))

   **Wait for the `test-infra-push-kubekins-e2e` presubmit to finish (you can [check on prow](https://prow.k8s.io/?job=post-test-infra-push-kubekins-e2e)).**

   **Pull latest from `master` before continuing.**

5. Generate the new release branch jobs:

   ```shell
   bazel run //experiment:prepare_release_branch
   ```

6. Search for and update jobs that must be manually bumped

   `grep` for [`manual-release-bump-required`](https://github.com/kubernetes/test-infra/search?q=manual-release-bump-required&unscoped_q=manual-release-bump-required) in [test-infra](https://github.com/kubernetes/test-infra) and duplicate block entries appropriately

7. Update release dashboards in the [Testgrid config](https://git.k8s.io/test-infra/config/testgrids/config.yaml) ([example commit](https://github.com/kubernetes/test-infra/pull/13882/commits/8aad58b09ae718139b44c70512d2d133d094ed82))
   - Remove the oldest release `sig-release-<version>-{master,informing,all}` dashboards e.g., `sig-release-1.12-all`
   - Add dashboards for the current release e.g., `sig-release-1.16-{master,informing,all}`

8. Check for and resolve configuration errors ([example commit](https://github.com/kubernetes/test-infra/pull/13882/commits/867e9ee0329228c6c79399dc67097d0f94814f8f)):

   ```shell
   bazel test //config/... //testgrid/... //hack:verify-config
   ```

   **Known issues**
   - [`pull-kubernetes-{dependencies,verify}` jobs need to be manually forked](https://github.com/kubernetes/test-infra/issues/13886) ([example PR](https://github.com/kubernetes/test-infra/pull/13885))
   - [Several gke/gce/gci jobs are misconfigured for sig-release-x.y-all dashboards](https://github.com/kubernetes/test-infra/issues/13883)

9. Enable/update the `milestoneapplier` plugin configs for the following repos ([example PR](https://github.com/kubernetes/test-infra/pull/13888)):
    - `kubernetes/enhancements`
      - Update config for `master` to current milestone e.g., `v1.16`
    - `kubernetes/kubernetes`
      - Remove config oldest release branch
      - Add config for the current release branch
      - Update config for `master` to current milestone e.g., `v1.16`
    - `kubernetes/release`
      - Update config for `master` to current milestone e.g., `v1.16`
    - `kubernetes/sig-release`
      - Update config for `master` to current milestone e.g., `v1.16`

   **Known issues**
   - Once the handbook includes sections that explicitly dictate timeline, we need to mention that after Code Freeze we need to update the `kubernetes/kubernetes` config for `master` to next milestone e.g., `v1.17`.

10. Update [kubernetes-versions.md](https://github.com/kubernetes/test-infra/blob/master/docs/kubernetes-versions.md)

11. Regenerate job configs:

    ```shell
    hack/update-config.sh
    ```

12. Do a final check for configuration errors:

    ```shell
   bazel test //config/... //testgrid/... //hack:verify-config
    ```

13. Issue a PR with the new release branch job configurations ([example PR](https://github.com/kubernetes/test-infra/pull/13882))

14. Once the PR has merged, verify that the new dashboards have been created and are populated with jobs:
    - https://testgrid.k8s.io/sig-release-1.16-all
    - https://testgrid.k8s.io/sig-release-1.16-blocking
    - https://testgrid.k8s.io/sig-release-1.16-informing

15. [Announce in #sig-release and #release-management](https://kubernetes.slack.com/archives/C2C40FMNF/p1565746110248300?thread_ts=1565701466.241200&cid=C2C40FMNF) that this work has been completed

[sig-release-1.Y-blocking]: https://testgrid.k8s.io/sig-release-1.15-blocking
[`branchff`]: https://git.k8s.io/release/branchff

## Configure Merge Automation

Starting release cycle v1.16, branch management will take on duties from the Test Infra lead. Since the role was dissolved at the end of cycle v1.15. This section describes the added responsibility that branch management will partake:

Between the Code Freeze and lifting Code Freeze (or Code Thaw) period, merging new code is restricted (focus is on fixing existing code and getting green test builds on Testgrid) and is implemented by config changes for [tide]. The `master` and current release cycle branch i.e. release-x.y are the only branches affected during this period.

Code freeze initiates additional merge requirements, while Code thaw marks the switch back to the development phase. Look at the [release cycle timeline](https://github.com/kubernetes/sig-release/tree/master/releases) for the exact dates for code freeze and code thaw. Usually the the date for code thaw is flexible depending on pending PRs.

As Branch Manager, coordinate with the Release Lead on checking whichever config changes are required to enable and disable merge restrictions.

## Tide

Tide automate merges. Its configuration lives in `[config.yaml](https://github.com/kubernetes/test-infra/blob/master/prow/config.yaml)`. Tide identifies PRs that are mergeable using GitHub queries that correspond to the entries in the queries field. Here is an example of what the query config for `kubernetes/kubernetes` looks like without additional constraints related to the release cycle:

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

During code freeze, two queries are used instead of just one for the `kubernetes/kubernetes` repo. One query handles the `master `and current release branches while the other query handles all other branches. The partition is achieved with the `includedBranches` and `excludedBranches` fields.

## Code Freeze

Code freeze is when merge requirements for the `master` and current release branch diverge from the requirements for the other branches so this is when the `kubernetes/kubernetes` Tide query splits into two queries.

We only add additional merge requirements for PRs to these two branches for code freeze:

* PRs must be in the GitHub milestone for the current release.

Milestone requirements are configured by adding e.g. `milestone: v1.14` to a query config.

It is also helpful to remind [#sig-testing](https://kubernetes.slack.com/messages/C09QZ4DQB) when code freeze starts so they know not to do anything too dangerous to the test infrastructure.

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
      .
      .
      .
```

## Code Thaw

Code thaw removes the release cycle merge restrictions and replaces the two queries with one single query. We remain in this state until the next code freeze.

```yaml
  - repos:
    - kubernetes/kubernetes
    labels:
    - lgtm
    - approved
    - "cncf-cla: yes"
    missingLabels:
    .
    .
    .
```

# Branch Content Management

This section discusses the methods in managing commits on the `release-x.y` branch.

## Branch Fast Forward

Prior to running `./branchff`, you will need:
- permission to write to the `/usr/local/` directory
- permission to run under `root` privileges
- membership in the [Release Managers GitHub Group](https://github.com/orgs/kubernetes/teams/release-managers)

Command invocation:
```bash
./branchff release-x.y
```
Where `X.Y` is the is release cycle version e.g. `1.12`

This is done daily as soon as the `release-x.y` branch has been cut (which happens after `beta.0` is released).

Earlier in the release the exact time of running [`branchff`] can be at the discretion of the branch manager, as agreed upon with the release lead.

Later in the release cycle, it will become more important to align with the release lead and the CI signal team (and probably other release team members).
The exact time for pulling in the changes from `master` to the release branch might depend on the features that have or will be merged. Considerations could be:

- We should run [`branchff`] sooner, before `$bigFeature` so we have a signal in the release branch before that feature was brought in
- We should run [`branchff`] later, after `$theOtherFeature` has been merged, so we get signal on that feature from both the master and the release branch

The first time the [`branchff`] executes, it will
- do a clone of `kubernetes/kubernetes` to a temporary directory i.e. `/usr/local/google/nobody/branchff-release-x.y/src/k8s.io/kubernetes`
- run a git merge-base
- run a few cleanup scripts to ensure the branch’s generated API bits are in order
  (master branch content will move on toward version `n+1`, while release branch needs to stay at version `n`)
- commit the results of those scripts to the branch
- push to the GitHub remote release branch

It is highly recommended to run the following `git` commands as shown below:
```
Go look around in /usr/local/google/nobody/branchff-release-1.14/src/k8s.io/kubernetes to make sure things look ok:
# Any files left uncommitted?
* git status -s
# What does the commit look like?
* git show
# What are the changes we just pulled in from master?
#   will be available after push at:
#   https://github.com/kubernetes/kubernetes/compare/641856db18...6ac5d02668
* git log origin/release-1.14..HEAD

OK to push now? (y/n):
```

You should see something like this when running `git show`:

```bash
commit e0677859bbcaf681ea41d731534771a4e9843a17
Merge: 104add02ef b49d429f64
Author: bubblemelon <12985181+Bubblemelon@users.noreply.github.com>
Date:   Tue May 28 13:24:16 2019 +0000

    Merge remote-tracking branch 'origin/master' into release-1.15.  Deleting CHANGELOG-1.12.md
```
Sometimes the commit may or may not delete a Changelog.

It is critically important to run the following during code freeze. Look through the git log via:
```
git log origin/release-1.Y..HEAD
```

Each and every commit ought to be something the release team has visibility into.  Each merge commit indicates a PR number and owner. Invest time in researching these. If unexpected code was merged to master, use your judgement on whether to escalate to the release team and SIG leadership associated with PR to question whether the commit is truly targeted for the release.

**The release team and the branch manager are the final safety guard on the release content.**

Upon a successful mock execution of `./brachff`, proceed with:
`./branchff release-1.Y --nomock`

Subsequent runs will simply be merging in changes from `master` to the branch, keeping the previous API fixup commits on the branch.

Note that the merged commits from `branchff` e.g. with `e0677859b` from the above `git show` snippet will be tested against on Testgrid [sig-release-x.y-blocking].

Once code freeze is lifted (code thaw occurred), then there will be no need to `branchff` from `master` onto the release branch. Instead, PRs that need to be merged onto the release branch are cherry-picked over from `master`.

## Reverts

During code freeze it is especially important to first look at the list of commits on `master` since the prior fast forward, scanning their content and issues/PRs to ensure they are changes expected for this milestone. **The merge-blocking mechanisms are relatively weak**. It is possible still for some people to write directly to the repo (bypassing blocking mechanisms), and as well as for unintentional milestone maintainers to approve a merge incorrectly. The branch manager is the last line of defense.

If code incorrectly merges onto `master` it should be reverted in `master`. Alternatively, release branch management must go to all cherry picks, picking around the errant (incorrectly added) commit.

## Cherry Picks

Once code freeze is lifted, and for the post-release patch management process, commits are cherry picked from `master`.

It's important to take note of [what is considered as a release blocking issue or PR](https://github.com/kubernetes/sig-release/blob/master/release-blocking-jobs.md) and identify PRs and issues as soon as possible. Ensure that there's work being done to release blocking PRs completed prior to the official release day. Do let the release lead know if there's not enough attention placed on the release blocking PR. This way we can prevent from prolonging the official release.

The current documentation in the [contributor guide for cherry picks](https://git.k8s.io/community/contributors/devel/sig-release/cherry-picks.md) should be generally sufficient. There are a couple prerequisites to running the script which are outlined in that guide.

The cherry pick script is also fairly self documenting in terms of how to invoke the command.

In brief, running [cherry_pick_pull.sh](https://git.k8s.io/kubernetes/hack/cherry_pick_pull.sh) creates a cherry pick PR against the specified `release-x.y` branch. The contents of this PR is taken from the PR that was made against `master`. Once the appropriate approval is given to the cherry pick PR and has met the requirements set by the [k8s-ci-robot](https://github.com/k8s-ci-robot), this will trigger test re-runs on the PR. As soon as these tests all pass, add the `cherry-pick-approved` label.

For example, [#79044](https://github.com/kubernetes/kubernetes/pull/79044) is the cherry pick PR of [#78999](https://github.com/kubernetes/kubernetes/pull/78999). Once [#79044](https://github.com/kubernetes/kubernetes/pull/79044) is tagged with the `cherry-pick-approved` label, Prow begins the merge onto the release branch.

There has been quite a bit of recent discussion (see: [1](https://github.com/kubernetes/community/pull/2408), [2](https://github.com/kubernetes/community/pull/1980)) around improving both the cherry pick process process and its documentation.

After the official release has been published, the [patch release team](#../patch-release-manager/) will take over in handling cherry picks. In the time between code thaw and the official release, cherry picks are the responsibility of the branch management team. Consider the following when assessing the cherry-picks:

- Check regularly if there are new cherry picks with
  [`is:open is:pr base:release-1.14label:do-not-merge/cherry-pick-not-approved`][cherry-pick-query]
- Consider that each cherry-pick diverges the latest release candidate that has
  been cut from the bits to be released as the official release
- Engage with the cherry pick requesters: How important is that cherry-pick,
  can it be pushed to a later release (patch or even minor), ... ?
- Discuss (especially controversial) cherry-picks in [#sig-release] or at the
  burndown meeting if you are unsure
- If certain cherry-picks go in, does this mean we want another release
  candidate, more time for the release candidate to soak (e.g. over the
  weekend)?

[cherry-pick-query]: https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+base%3Arelease-1.14+label%3Ado-not-merge%2Fcherry-pick-not-approved

# Staging Repositories

The [publishing-bot](https://github.com/kubernetes/publishing-bot) is responsible for publishing the code in [staging](https://git.k8s.io/kubernetes/staging/src/k8s.io) to their own repositories.

The bot also syncs the Kubernetes version tags to the published repos, prefixed with `kubernetes-`. For example, if you check out the `kubernetes-1.13.0` tag in client-go, the code you get is exactly the same as if you check out the `v1.13.0` tag in Kubernetes, and change the directory to `staging/src/k8s.io/client-go`.

[client-go](https://github.com/kubernetes/client-go) follows [semver](http://semver.org/) and has its own release process. This release process and the publishing-bot are maintained by SIG API Machinery. In case of any questions related to the published staging repos, please ask someone listed in the following [OWNERS](https://git.k8s.io/publishing-bot/OWNERS) file.

The bot runs every four hours, so it might take sometime for a new tag to appear on a published repository.

The client-go major release (.e.g `v1.13.0`) is released manually a day after the main Kubernetes release.

# Debugging

Logs from `branchff`, `gcbmgr`, etc are stored in the `/tmp` directory and can provide more details as to why command executions are failing.

For example, you might see on your terminal that the execution of`./branchdff release-1.X` fails:

```bash
Merging origin/master into release-1.15 branch: OK
Ensure etcd is up to date: OK
Run 'useful' (the list may be out of date) hack/update* scripts...
Running hack/update-openapi-spec.sh:

Signal ERR caught!

Traceback (line function script):
221 logrun /release/lib/common.sh
208 main ./branchff

Exiting...
```
The above unsuccessful run did not provide the full reason for the interrupted exit above, to find out more, `cd` into `/tmp` and inspect the contents of `branchff.log`:

```bash
Detected go version: go version go1.11.10 linux/amd64
Kubernetes requires go1.12.1 or greater.
Please install go1.12.1 or later.

!!! [0519 03:02:18] Call tree:
!!! [0519 03:02:18] 1; hack/update-openapi-sh: 29 kube::golang::setup_env(...)
 Error in /usr/local/google/branchff-release-l. 15/src/k8s.io/kubernetes/hack/lib/golang.sh:495 ' ( (1<3-1 ) ) ' exited with status 2
 Call stack:
1: /usr/local/google/branchff-release-1.15/src/k8s.io/kubernetes/
hack/lib/golang.sh:495 kube::golang::setup_env(...)
2: hack/update-openapi-spec.sh:29 main( ... )
Exiting with status 1

branchff::common::trapclean(): Signal ERR caught!
branchff::common::trapclean(): Traceback (line function script) : branchff::exit(): Exiting...
```
The logs reveals a lot more information than what's printed out on the terminal. If necessary, you can also inspect the logs on the Google Cloud console or the output that appears when running `./gcbmgr tail`.

# References

A README on tools e.g. `gcbmgr`, `branchff` used in this handbook:

* [Release Tools Documentation](https://github.com/kubernetes/release/blob/master/README.md)

An overview of steps outlining the stage and release process:

* [Generic Release Steps](https://docs.google.com/document/d/1x-GQDZpKk3WajtSnO0axDazE9Xs2mOSVgjziIuTWNO0/edit)

A more detailed overview of staging and cutting a release e.g. alpha.2 (reference for any release cycle):

* [Cutting v1.15.0-alpha.2](https://docs.google.com/document/d/1Xv5w_eNvLvD-nNinMNqQAh0qlzee8btqAyHyFFMz3z4/edit?usp=sharing)

* If you refer a video walkthrough, see [cutting release candidate v1.15.0-rc.1](https://youtu.be/ldYt1elShD4).

Test Infra Specific references:

Concerns and questions can be directed to [#testing-ops](https://kubernetes.slack.com/messages/C7J9RP96G) and [#sig-testing](https://kubernetes.slack.com/messages/C09QZ4DQB). For urgent matters, please contact the user group [@test-infra-oncall](https://get.slack.help/hc/en-us/articles/212906697-Create-a-user-group#browse-user-groups-and-view-members) on Slack.

| Dashboards/Tools    | Useful Links  |
| ------------------- | ------------- |
| [Prow](https://github.com/kubernetes/test-infra/tree/master/prow) <br/> Kubernetes based CI/CD system. | <ul><li><a href="https://prow.k8s.io/pr">PR Status</a></li><li><a href="https://prow.k8s.io/tide">Tide Status</a></li></ul> |
| [Gubernator](https://github.com/kubernetes/test-infra/tree/master/gubernator) <br/> Displays Kubernetes test results stored in Google Cloud Storage(GCS). | <ul><li><a href="https://gubernator.k8s.io/pr">PR Dashboard</a></li></ul> |
| [Velodrome](http://velodrome.k8s.io) <br/> Displays Kubernetes Developer Productivity. | <ul><li><a href="http://velodrome.k8s.io/">http://velodrome.k8s.io/</a></li></ul> |
| Kubernetes Codebase Search | <ul><li><a href="https://cs.k8s.io/">https://cs.k8s.io/</a></li></ul> |
| Kubernetes [Devstats](https://devstats.cncf.io/) <br/> Toolset to visualize GitHub archives using Postgres databases and Grafana dashboards. | <ul><li><a href="https://k8s.devstats.cncf.io/">https://k8s.devstats.cncf.io/</a></li></ul> |
| [Kubernetes OnCall Rotation](https://console.cloud.google.com/storage/browser/_details/test-infra-oncall/oncall.html)<br/> Displays the current test infra person on call. | <ul><li><a href="https://go.k8s.io/oncall">https://go.k8s.io/oncall</a></li></ul> |
| [APISnoop](https://github.com/cncf/apisnoop) <br/> Snooping on the Kubernetes OpenAPI communications. | <ul><li><a href="https://apisnoop.cncf.io/">https://apisnoop.cncf.io/</a></li></ul> |
| [TestGrid](https://github.com/kubernetes/test-infra/tree/master/testgrid) <br/> Displays Kubernetes CI tests results in grids. | <ul><li><a href="https://testgrid.k8s.io/">https://testgrid.k8s.io/</a></li><li><a href="https://docs.google.com/document/d/1lGvP89_DdeNO84I86BVAU4qY3h2VCRll45tGrpyx90A/edit#heading=h.x9snb54sjlu9">Displaying Kubernetes Conformance Results with Testgrid</a></li></ul> |
| Triage Dashboard <br/> Displays Kubernetes aggregated failures. | <ul><li><a href="https://storage.googleapis.com/k8s-gubernator/triage/index.html">https://storage.googleapis.com/k8s-gubernator/triage/index.html</a></li></ul> |

# Background information

You may have noticed that there are prompts to use `./anago` when cutting releases but there's no mention of using `anago` in this handbook, see:

* [Summary of discussion with Caleb about moving from `anago` to `gcbmgr`](https://groups.google.com/d/topic/kubernetes-milestone-burndown/YdHa51d95VI/discussion)

> Note: To access this forum, you will need to join the [kubernetes-milestone-burndown](https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown) Google group.

See the branch management process prior to v1.12 when `anago` was still used.

* [Branch Management Playbook](https://docs.google.com/document/d/1Qoqz5IZYBp6A-Q_R9CGhMAc358ykOiE49GXZU9r5usQ/edit#heading=h.s71iha1627td)

> Note: To view this document, you will need to join the [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev) Google group.


[kubernetes-release-team]: https://groups.google.com/forum/#!forum/kubernetes-release-team
[release-managers-group]: https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers
