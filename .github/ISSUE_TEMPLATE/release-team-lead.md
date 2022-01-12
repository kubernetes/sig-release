---
name: Release Team Lead onboarding
about: Grant/update access for new Release Team Leads and/or Lead Shadows
title: 'Release Team Lead access for <GH-handle>'
labels: sig/release, area/release-eng, area/release-team
---

<!--
This template can be used for onboarding the Release Team Lead and Lead Shadows.

The issue should be kept open for the entirety of the release cycle, so we can track the offboarding tasks as well.
-->

### GitHub Username(s)

- (at)example_user1
- (at)example_user2
- (at)example_user3

### Release Cycle

e.g., Kubernetes 1.18

### Prerequisites

- [ ] Ensure new Release Team Lead:
  - [ ] Has joined the following mailing lists:
    - [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
    - [kubernetes-dev](https://groups.google.com/a/kubernetes.io/g/dev)
  - [ ] Has joined the following Slack channels:
    - [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF)
    - [#release-management](https://kubernetes.slack.com/messages/CJH2GBF7Y)
  - [ ] Is a [Kubernetes GitHub org member](https://github.com/kubernetes/community/blob/master/community-membership.md#member)
  - [ ] Has completed the [CNCF Inclusive Speaker Orientation](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/)

### Onboarding

<!--
As you work through the checklist, use the following PRs as guides:
- k/sig-release: https://github.com/kubernetes/sig-release/pull/884
- k/org: https://github.com/kubernetes/org/pull/1205
- k/k8s.io: https://github.com/kubernetes/k8s.io/pull/452
-->

- [ ] Release Team Lead has agreed to abide by the guidelines set forth in the
  [Security Release Process](https://git.k8s.io/security/security-release-process.md), specifically the embargo on CVE communications.
  This must be done as an issue comment by the incoming Release Team Lead.
- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-team`
  - `release-team-leads`
  - `sig-release`
- [ ] Update `kubernetes/sig-release` `OWNERS`
  - Release Team Lead and Shadows
    - Add an `approvers` entry in `releases/release-x.y/OWNERS`
  - **Release Team Lead only**
    - In `OWNERS_ALIASES`, add an entry in the following sections:
      - `release-team`
      - `release-team-lead-role`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
  - `release-team@`
- [ ] Grant calendar access
- [ ] Regenerate and re-issue Zoom host key to the Release Lead and Lead Shadows.
- [ ] Add incoming leads to `release-team-leads` Slack Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
  - Add slack ID(s) to [`users.yaml`](https://git.k8s.io/community/communication/slack-config/users.yaml), if they are not yet in the file
  - Add username(s) to [`usergroups.yaml`](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)

### Offboarding

- [ ] Remove from GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-team`
  - `release-team-leads`
- [ ] Remove from Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
- [ ] Manually remove from the following Google Groups:
  - [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team) (Add as Manager)
  - [kubernetes-sig-leads](https://groups.google.com/forum/#!forum/kubernetes-sig-leads) (Add as Member)
- [ ] Remove from `release-team-leads` Slack Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
  - Remove slack ID(s) from [`users.yaml`](https://git.k8s.io/community/communication/slack-config/users.yaml), if no longer in a group
  - Remove username(s) from [`usergroups.yaml`](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)

cc: @kubernetes/release-engineering @kubernetes/release-team
