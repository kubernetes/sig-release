---
name: Post rc-0 Cut Release Tasks
about: Tasks to perform after the release candidate 0 is cut
title: Post rc-0 Cut Release Tasks
labels: sig/release, area/release-eng
---

## Scheduled to happen: <!-- Tue, YYYY-MM-DD -->

## Tasks

<!--

Follow the docs here: https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/post-rc0-release-tasks.md

Help? Ring @release-managers on slack!

-->

- [ ] Create a thread on #release-management: <!-- Paste link to slack -->
- [ ] Remove EOL version jobs from test-infra (if it's the appropriate timing to do so)
- [ ] Update milestone applier rules and check milestone requirements
- [ ] Update kubekins-e2e variants.yaml with new version config
- [ ] Update test-infra jobs for the new release
- [ ] Create the release dashboards and check their creation with Release Signal Lead
- [ ] Run test generation script
- [ ] Add new variant for kube-cross image
- [ ] Update k8s-cloud-builder and k8s-ci-builder
- [ ] Update k8s references for kube-cross image
- [ ] Update publishing bot rules
- [ ] Create performance tests branch
- [ ] Cut next alpha release
- [ ] Inform stakeholders about the post rc.0 tasks being completed

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
/cc @kubernetes/release-managers
/priority important-soon
/kind documentation
