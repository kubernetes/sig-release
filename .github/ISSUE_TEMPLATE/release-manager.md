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

### Release Manager Onboarding

**All pull requests within these checklists should be marked with an _explicit_ hold and only released once approved by a Release Engineering subproject owner.**

- [ ] Addition of a new Release Manager has been discussed with and approved by Release Engineering subproject owners
- [ ] Update [Release Managers](/release-managers.md) page to include the new Release Manager

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

<!-- ### Patch Release Team

- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `patch-release-team`
  - `release-engineering`
  - `release-managers`
  - `sig-release`
- [ ] Update `OWNERS`
  - `kubernetes/sig-release`
    - Entry in the `release-engineering` section in `OWNERS_ALIASES`
  - `kubernetes/release`
    - Entry in the `release-engineering` section in `OWNERS_ALIASES`
  - `kubernetes/test-infra`
    - Add as reviewer for SIG Release `OWNERS`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-editors@`
  - `k8s-infra-release-viewers@`
  - `release-managers@`
  - `release-managers-private@`
- [ ] Update Slack `release-managers` User Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
-->

<!-- ### Branch Manager

- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-managers`
  - `release-engineering`
  - `sig-release`
- [ ] Update `OWNERS`
  - `kubernetes/sig-release`
    - Entry in the `branch-managers` section in `OWNERS_ALIASES`
  - `kubernetes/release`
    - Entry in the `branch-managers` section in `OWNERS_ALIASES`
  - `kubernetes/test-infra`
    - Add as reviewer for SIG Release `OWNERS`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-editors@`
  - `k8s-infra-release-viewers@`
  - `release-managers@`
- [ ] Update Slack `release-managers` User Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
-->

<!-- ### Release Manager Associate

- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `release-engineering`
  - `sig-release`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
-->
