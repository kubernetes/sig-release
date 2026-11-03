# Onboarding Chairs and Technical Leads

New Chairs and Technical Leads are onboarded through a
[Chair or Technical Lead onboarding issue](https://github.com/kubernetes/sig-release/issues/new?template=lead.md),
which tracks the items below.

To ensure quality communication SIG Release Chairs and Technical Leads should:

- Be part of the Kubernetes GitHub organization:
  https://github.com/kubernetes/community/blob/master/community-membership.md#member

- Be part of the @kubernetes/sig-release-admins GitHub team:
  https://github.com/orgs/kubernetes/teams/sig-release-admins

- Join the following mailing lists and be able to post there:

  - kubernetes-sig-release:
    https://groups.google.com/g/kubernetes-sig-release
  - release-team:
    https://groups.google.com/a/kubernetes.io/g/release-team
  - dev:
    https://groups.google.com/a/kubernetes.io/g/dev
  - kubernetes-announce:
    https://groups.google.com/g/kubernetes-announce
  - release-managers:
    https://groups.google.com/a/kubernetes.io/g/release-managers
  - release-managers-private:
    https://groups.google.com/a/kubernetes.io/g/release-managers-private

- Join the following Slack channels:
  - #sig-release:
    https://kubernetes.slack.com/archives/C2C40FMNF
  - #release-management:
    https://kubernetes.slack.com/archives/CJH2GBF7Y

The following permissions are needed to be able to act in the role as technical
lead:

- Be part of `sig-release-leads` in kubernetes/community/OWNERS_ALIASES:
  https://github.com/kubernetes/community/blob/master/OWNERS_ALIASES

- Be listed as a tech lead of SIG Release in kubernetes/community/sigs.yaml:
  https://github.com/kubernetes/community/blob/master/sigs.yaml

- Be part of the Technical Leads section in kubernetes/community/sig-release/README.md
  (generated from `sigs.yaml`):
  https://github.com/kubernetes/community/tree/master/sig-release#technical-leads

Technical leads should have the full set of permissions of the
[Release Managers](https://git.k8s.io/website/content/en/releases/release-managers.md),
which are:

- Technical leads should have formally agreed to abide by the guidelines set
  forth in the Security Release Process, specifically the embargo on CVE
  communications: https://git.k8s.io/security/security-release-process.md

- Be part of the following GitHub teams in kubernetes/org:
  https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml

  - milestone-maintainers
  - release-managers
  - release-engineering
  - sig-release

- Be part of the following OWNERS files:

  - kubernetes/kubernetes: OWNERS_ALIASES (sig-release-approvers section)
  - kubernetes/sig-release: OWNERS_ALIASES (sig-release-leads section)
  - kubernetes/release: OWNERS_ALIASES (sig-release-leads section)
  - kubernetes/k8s.io: OWNERS_ALIASES (release-engineering-approvers section)
  - kubernetes/test-infra (as reviewer for SIG Release OWNERS)

- Be part of the following SECURITY_CONTACTS files:

  - kubernetes/sig-release
  - kubernetes/release

- Have the correct Google Groups/GCP IAM membership in kubernetes/k8s.io:
  https://git.k8s.io/k8s.io/groups/sig-release/groups.yaml

  - sig-release-leads (members)
  - k8s-infra-release-admins (members)
  - k8s-infra-release-editors (members)
  - release-comms (owners)
  - release-managers (owners)
  - release-managers-private (owners)

- Be part of the Slack `release-managers` and `release-team-leads` user groups
  in kubernetes/community:
  https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml
