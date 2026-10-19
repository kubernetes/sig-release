---
name: Chair or Technical Lead onboarding
about: Grant/update access for a new Chair/Technical Lead
title: "Chair/Technical Lead access for <GH-handle>"
labels: sig/release, area/release-eng
---

### GitHub Username

e.g., (at)example_user

### [Chair/Technical Lead](https://git.k8s.io/sig-release/leads/onboarding.md) role

e.g., Chair, Technical Lead

### Chair and Technical Lead Onboarding

**All pull requests within these checklists should be marked with an _explicit_
hold and only released once approved by a SIG Release (subproject) owner.**

- [ ] Addition of a new Chair/Technical Lead has been discussed with and
      approved by the SIG Release leads
- [ ] Ensure new Chair/Technical Lead:
  - [ ] Has joined the following mailing lists:
    - [kubernetes-sig-release](https://groups.google.com/g/kubernetes-sig-release)
    - [release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
    - [dev](https://groups.google.com/a/kubernetes.io/g/dev)
    - [kubernetes-announce](https://groups.google.com/g/kubernetes-announce)
    - [release-managers](https://groups.google.com/a/kubernetes.io/g/release-managers)
    - [release-managers-private](https://groups.google.com/a/kubernetes.io/g/release-managers-private)
  - [ ] Has joined the following Slack channels:
    - [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF)
    - [#release-management](https://kubernetes.slack.com/messages/CJH2GBF7Y)
  - [ ] Is a [Kubernetes GitHub org member](https://github.com/kubernetes/community/blob/master/community-membership.md#member)
  - [ ] Is part of the [@kubernetes/sig-release-admins](https://github.com/orgs/kubernetes/teams/sig-release-admins) GitHub team
- [ ] Update the [Release Managers](https://git.k8s.io/website/content/en/releases/release-managers.md) page to include the new Chair or Technical Lead

<!--
Uncomment the appropriate checklist for the Chair/Technical Lead role the new candidate will hold.

As you work through the checklist, use the PRs linked from the most recent
closed "Chair/Technical Lead access for" issues in this repository as guides:
https://github.com/kubernetes/sig-release/issues?q=is%3Aissue+%22Technical+Lead+access+for%22
-->

<!--
### Chair/Technical Lead

- [ ] Chair/Technical Lead has agreed to abide by the guidelines set forth in
  the [Security Release
  Process](https://git.k8s.io/security/security-release-process.md),
  specifically the embargo on CVE communications.
  (This must be done as an issue comment by the incoming Chair/Technical Lead.)
- [ ] Update GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-engineering`
  - `release-managers`
  - `sig-release-admins`
- [ ] Update `OWNERS`
  - [ ] `kubernetes/sig-release` `OWNERS_ALIASES`
    - Add entry in the `sig-release-leads` section
  - [ ] `kubernetes/release` `OWNERS_ALIASES`
    - Add entry in the `sig-release-leads` section
  - [ ] `kubernetes/test-infra` `OWNERS_ALIASES`
    - Add entry in the `sig-release-leads` section
  - [ ] `kubernetes/kubernetes` `OWNERS_ALIASES`
    - Add entry in the `sig-release-approvers` section
  - [ ] `kubernetes/k8s.io` `OWNERS_ALIASES`
    - Add entry in the `release-engineering-approvers` section
- [ ] Update `SECURITY_CONTACTS`
  - [ ] `kubernetes/release`
  - [ ] `kubernetes/sig-release`
- [ ] Update Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/sig-release/groups.yaml)
  - `sig-release-leads` (members)
  - `k8s-infra-release-admins` (members)
  - `k8s-infra-release-editors` (members)
  - `release-comms` (owners)
  - `release-managers` (owners)
  - `release-managers-private` (owners)
- [ ] Manually grant permission to post on [kubernetes-announce](https://groups.google.com/g/kubernetes-announce)
- [ ] Manually add to the [Release Team Google Group](https://groups.google.com/a/kubernetes.io/g/release-team)
- [ ] Update Slack `release-managers` and `release-team-leads` User Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
- [ ] Manually add to the [#release-private](https://kubernetes.slack.com/archives/GKEA5EL67) Slack channel
-->

cc: @kubernetes/sig-release-admins
