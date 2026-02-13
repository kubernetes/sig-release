---
name: Post Release Branch Creation Tasks
about: Tasks to perform after the rc.0 is cut and the upcoming release branch is created
title: Post Release Branch Creation Tasks for v1.x.y-rc.0
labels: sig/release, area/release-eng
---

## As a follow up on: <!-- #<issue> typically the rc.0 cut issue (currently the branch is created by krel during that cut process) -->

## Tasks

<!--

Follow the docs here: https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/post-release-branch-creation.md

Help? Ring @release-managers on slack!

-->

- [ ] Create a thread in #release-management: <!-- Paste link to Slack thread -->
- [ ] (optional) Remove jobs for EOL versions, **only** if agreed upon with Release Managers
<!--
Branch Managers might not have a context on if it is "safe" to remove the EOL jobs. We try to be firm with the deadlines and stop cutting patches as soon as we reach the EOL date, but e.g. there might be a new patch needed because of some important security fix, in which case only Release Managers will know about that.

There might be a significant time/delay between the release reaching EOL and the new branch being created, leaving those jobs hanging for a while, which has an impact on the project infra costs.

The trigger for removing such jobs should be solely the EOL date but we shouldn't connect getting rid of EOL jobs and the new branch creation. Even if has been like that before, it shouldn't be longterm.
-->
- [ ] Update [`milestone_applier` rules](https://github.com/kubernetes/test-infra/blob/master/config/prow/plugins.yaml)
- [ ] Update [`kubekins-e2e-v2/variants.yaml`](https://github.com/kubernetes/test-infra/blob/master/images/kubekins-e2e-v2/variants.yaml) with the new version config
- [ ] Run `make -C releng prepare-release-branch` in kubernetes/test-infra, configure the new release dashboards and send a PR
- [ ] Add a new variant for the `kube-cross` image (`kubernetes/release` repository) and ensure the image is built and pushed properly
- [ ] Add new variants for `k8s-cloud-builder` and `k8s-ci-builder` images (`kubernetes/release` repository) and ensure images are built and pushed properly
- [ ] Update references in `kubernetes/kubernetes` with the new kube-cross image (only after all images are pushed/promoted)
- [ ] Update publishing-bot rules to include the new release branch
- [ ] Ensure that a new [performance tests](https://github.com/kubernetes/perf-tests/) branch is created by SIG Scalability maintainers
- [ ] Inform stakeholders about the post branch creation tasks being completed
- [ ] Monitor the new release dashboard with the Release Signal Lead for at least 48 hours - mainly for missing or misconfigured jobs

## Action Items

<!--
During the post rc tasks, you may find a few things that require updates
(process changes, documentation updates, fixes to release tooling).

Please list them here.

It will be your responsibility to open issues/PRs to resolve these
issues/improvements. Keep this issue open until these action items
are complete.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

## Open Questions

<!--
During the post rc tasks, you may have a few questions that you can't
answer yourself or may require group discussion.

Please list them here.

Follow up with Branch Managers/Patch Release Team/Release Engineering
subproject owners to get these questions answered.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

/milestone <!-- v1.x e.g. v1.14 -->
/assign <!-- @ the Release or Branch Manager responsible for this release -->
/cc @kubernetes/release-managers @kubernetes/release-team-release-signal
/priority important-soon
/kind documentation
