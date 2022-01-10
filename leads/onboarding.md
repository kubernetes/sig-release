# Onboarding Chairs and Technical Leads

To ensure quality communication SIG Release Chairs and Technical Leads should:

- Be part of the Kubernetes GitHub organization:
  https://github.com/kubernetes/community/blob/master/community-membership.md#member

- Be part of the @kubernetes/sig-release-admins GitHub team:
  https://github.com/orgs/kubernetes/teams/sig-release-admins

- Join the following mailing lists and be able to post there:

  - kubernetes-sig-release:
    https://groups.google.com/forum/#!forum/kubernetes-sig-release
  - kubernetes-release-team:
    https://groups.google.com/a/kubernetes.io/g/release-team
  - kubernetes-dev:
    https://groups.google.com/a/kubernetes.io/g/dev
  - kubernetes-announce:
    https://groups.google.com/forum/#!forum/kubernetes-announce
  - release-managers:
    https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers
  - release-managers-private:
    https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers-private

- Join the following Slack channels:
  - #sig-release:
    https://kubernetes.slack.com/messages/C2C40FMNF
  - #release-management:
    https://kubernetes.slack.com/messages/CJH2GBF7Y

The following permissions are needed to be able to act in the role as technical
lead:

- Be part of sig-release-leads in kubernetes/community/OWNERS_ALIASES:
  https://github.com/kubernetes/community/blob/fd5df0deed97536095a28c4f881bb5ce6247f85f/OWNERS_ALIASES#L63

- Be part of tech\*leads in kubernetes/community/sigs.yaml:
  https://github.com/kubernetes/community/blob/fd5df0deed97536095a28c4f881bb5ce6247f85f/sigs.yaml#L1680

- Be part of the Technical Leads section in kubernetes/community/sig-release/README.md:
  https://github.com/kubernetes/community/tree/master/sig-release#technical-leads

Technical leads should have the full set of permissions equally to Branch
Managers, which are:

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
  - kubernetes/k8s.io OWNERS_ALIASES (release-engineering-approvers section)
  - kubernetes/test-infra (as reviewer for SIG Release OWNERS)

- Be part of the following SECURITY_CONTACTS files:

  - kubernetes/sig-release
  - kubernetes/release

- Have the correct Google Groups/GCP IAM membership in kubernetes/k8s.io:
  https://git.k8s.io/k8s.io/groups/groups.yaml

  - leads (members)
  - k8s-infra-release-admins (members)
  - k8s-infra-release-editors (members)
  - release-comms (owners)
  - release-managers (owners)
  - release-managers-private (owners)

- Be part of the Slack release-managers and release-team-leads User Group in
  kubernetes/community:
  https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml
