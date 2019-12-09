---
name: Release Manager onboarding
about: Grant/update access for a new Release Manager
title: 'Release Manager access for <GH-handle>'
labels: sig/release, area/release-eng
---

### GitHub Username

e.g., (at)example_user

### [Release Manager](/release-managers.md) role

e.g., Patch Release Team, Branch Manager, Release Manager Associate

### Tenure

<!--
Provide reasoning behind the tenure selection here.
For temporary access, we should specify a revocation time AND keep the issue open until the temporary Release Manager has been offboarded.

Examples:
- temporary: Alice is a Release Manager Associate being granted temporary elevated access to execute the Branch Management role. Access should be revoked after the x.y.z-alpha.m release is cut.
- temporary: Carmen is a Release Team Lead being granted Release Manager Associate access to observe Release Management during the x.y release cycle. Access should be revoked once the x.y cycle is complete.
-->
e.g., permanent, temporary

### Release Manager Onboarding

**All pull requests within these checklists should be marked with an _explicit_ hold and only released once approved by a Release Engineering subproject owner.**

- [ ] Addition of a new Release Manager has been discussed with and approved by Release Engineering subproject owners
- [ ] Ensure new Release Manager:
  - [ ] Has joined the following mailing lists:
    - [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
    - [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev)
  - [ ] Has joined the following Slack channels:
    - [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF)
    - [#release-management](https://kubernetes.slack.com/messages/CJH2GBF7Y)
  - [ ] Is a [Kubernetes GitHub org member](https://github.com/kubernetes/community/blob/master/community-membership.md#member)
- [ ] Update [Release Managers](https://git.k8s.io/sig-release/release-managers.md) page to include the new Release Manager

<!-- 
Uncomment the appropriate checklist for the Release Manager role the new candidate will hold.

As you work through the checklist, use the following PRs as guides:
- k/sig-release: https://github.com/kubernetes/sig-release/pull/868
- k/org: https://github.com/kubernetes/org/pull/1440
- k/release: https://github.com/kubernetes/release/pull/950
- k/k8s.io: https://github.com/kubernetes/k8s.io/pull/481
- k/test-infra: https://github.com/kubernetes/test-infra/pull/15465
- k/community: https://github.com/kubernetes/community/pull/4284
-->

<!--
### Patch Release Team

- [ ] Release Manager has agreed to abide by the guidelines set forth in the
  [Security Release Process](https://git.k8s.io/security/security-release-process.md), specifically the embargo on CVE communications.
  This must be done as an issue comment by the incoming Release Manager.
- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `patch-release-team`
  - `release-engineering`
  - `release-managers`
  - `sig-release`
- [ ] Update `OWNERS`
  - `kubernetes/sig-release` `OWNERS_ALIASES`
    - Add entry in the `release-engineering` section
    - Remove entry in the `branch-managers` section
  - `kubernetes/release` `OWNERS_ALIASES`
    - Add entry in the `release-engineering` section
    - Remove entry in the `branch-managers` section
  - `kubernetes/test-infra`
    - Add as reviewer for SIG Release `OWNERS`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-editors@`
  - `k8s-infra-release-viewers@`
  - `release-managers@`
  - `release-managers-private@`
- [ ] Manually grant permission to post on [kubernetes-announce](https://groups.google.com/forum/#!forum/kubernetes-announce)
- [ ] Manually remove from the [Release Team Google Group](https://groups.google.com/forum/#!forum/kubernetes-release-team)
- [ ] Update Slack `release-managers` User Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
- [ ] Manually add to the [#release-private](https://kubernetes.slack.com/archives/GKEA5EL67) Slack channel
-->

<!--
### Branch Manager

- [ ] Release Manager has agreed (on this issue) to abide by the guidelines set forth in the
  [Security Release Process](https://git.k8s.io/security/security-release-process.md),
  specifically the embargo on CVE communications
- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-managers`
  - `release-engineering`
  - `sig-release`
- [ ] Update `OWNERS`
  - `kubernetes/sig-release` `OWNERS_ALIASES`
    - Add entry in the `branch-managers` section
  - `kubernetes/release` `OWNERS_ALIASES`
    - Add entry in the `branch-managers` section
  - `kubernetes/test-infra`
    - Add as reviewer for SIG Release `OWNERS`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-editors@`
  - `k8s-infra-release-viewers@`
  - `release-managers@`
  - `release-managers-private@`
- [ ] Manually grant permission to post on [kubernetes-announce](https://groups.google.com/forum/#!forum/kubernetes-announce)
- [ ] Manually add to the [Release Team Google Group](https://groups.google.com/forum/#!forum/kubernetes-release-team)
- [ ] Update Slack `release-managers` User Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
-->

<!--
### Release Manager Associate

- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `release-engineering`
  - `sig-release`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
-->

cc: @kubernetes/release-engineering
