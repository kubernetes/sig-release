# Release Team Onboarding Guide

When joining the Release Team or taking on a new role on the Release Team, there are various lists and groups you'll need to be a part of, various permissions that you'll need to have, keys you may need to know, etc. For roles ranging from someone new to the Kubernetes Community to the incoming Release Team Lead, this document aims to enumerate the access that you'll need to ensure you have to various repos and tools.

- [New Members](#new-members)
  - [Slack](#slack)
  - [Kubernetes Community Membership](#kubernetes-community-membership)
- [All Members](#all-members)
  - [Contact Sheet](#contact-sheet)
  - [Mailing Lists](#mailing-lists)
  - [Calendar](#calendar)
  - [Familiarize with Prow commands](#familiarize-with-prow-commands)
- [Role Leads](#role-leads)
- [Release Team Lead](#release-team-lead)

## New Members

If you're a brand new member to the Kubernetes Community or the Release Team, welcome! It's great to have you involved with SIG Release.

### Slack

The communication and coordination for the overwhelming majority of SIG Release topics happens in the Kubernetes Slack. If you need access to the Kubernetes Slack, please see [slack.k8s.io](https://slack.k8s.io/). If you need help with any of your additional access needs, `#sig-release` is a good place to ask for help.

Every Release Team member should join:

- [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF): the main SIG Release channel, where the Release Team posts its status updates
- [#release-management](https://kubernetes.slack.com/archives/CJH2GBF7Y): the Release Managers' channel, where release cuts are coordinated

Each sub-team has its own channel. Join the one for your role and feel free to join the others:

- [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E): Enhancements team
- [#release-ci-signal](https://kubernetes.slack.com/archives/CN0K3TE2C): Release Signal team
- [#release-docs](https://kubernetes.slack.com/archives/C0156PJ62RE) and [#release-notes](https://kubernetes.slack.com/archives/CN1KH4K9A): Docs team
- [#release-comms](https://kubernetes.slack.com/archives/CNT9Y603D): Communications team

Related SIG channels that the Docs and Communications teams work with closely:

- [#sig-docs](https://kubernetes.slack.com/archives/C1J0BPD2M)
- [#sig-docs-blog](https://kubernetes.slack.com/archives/CJDHVD54J)

### Kubernetes Community Membership

The Kubernetes Community [defines](https://github.com/kubernetes/community/blob/master/community-membership.md#member) Members as the following:

> Members are continuously active contributors in the community. They can have issues and PRs assigned to them, participate in SIGs through GitHub teams, and pre-submit tests are automatically run for their PRs. Members are expected to remain active contributors to the community.
>
> Defined by: Member of the Kubernetes GitHub organization

The requirements for becoming a member are enumerated in the [k/community repo documentation](https://github.com/kubernetes/community/blob/master/community-membership.md#member). Generally, you'll need a few public contributions and some existing community members to sponsor you. The Release Team is a great place to meet members of the community that might be able to sponsor you! Membership is requested with a [membership request issue](https://github.com/kubernetes/org/issues/new?template=membership.yml) in the `kubernetes/org` repository, and you need to have signed the [CLA](https://github.com/kubernetes/community/blob/master/CLA.md) first.

For new shadows, it's not always necessary to become a member of the GitHub organization right away. Talk to the lead for the Release Team role you're shadowing for the definitive answer. For some roles (Enhancements for example) it is important for Shadows to be members of the GitHub organization because they have to maintain milestones in the [k/enhancements](https://github.com/kubernetes/enhancements) repo. For other roles it's less urgent for new Shadows to be members of the GitHub organization. Your mileage may vary, but you should try to become an official member of the Kubernetes Community as soon as possible.

## All Members

### Contact Sheet

Each release has a Release Team contact sheet which is a source of truth for who has which role in the Release Team and what their contact information is. The Release Team Lead usually creates it very early on in the release and links it from the `links.md` file of the release directory. Make sure that you have filled in your contact information in the contact sheet as soon as you become a member of the Release Team.

### Mailing Lists

There are a few mailing lists that you should be aware of. Depending on your relationship with the Release Team, you may want to join one or more of the following lists:

#### Release Team Mailing List

All members of the current release team should be a part of [release-team@kubernetes.io](https://groups.google.com/a/kubernetes.io/g/release-team). Membership is managed by PR to the [`groups/sig-release/groups.yaml`](https://git.k8s.io/k8s.io/groups/sig-release/groups.yaml) file of the `kubernetes/k8s.io` repository, which the Release Team Lead (or a lead shadow) opens at the start of the cycle. If you're on the Release Team and cannot access the group, please tell your role lead or the Release Team Lead that you need access.

#### Release Team Shadows Mailing List

Shadows are also members of [release-team-shadows@kubernetes.io](https://groups.google.com/a/kubernetes.io/g/release-team-shadows). The Emeritus Adviser opens the PR to `groups/sig-release/groups.yaml` that adds the selected shadows.

#### SIG Release Mailing List

All members of the release team and anyone who attends Release Team meetings / keeps up with the release process should join the [SIG Release group](https://groups.google.com/g/kubernetes-sig-release).

#### SIG Docs Mailing List

Members of the Docs and Communications teams should also join the [SIG Docs group](https://groups.google.com/g/kubernetes-sig-docs).

#### Kubernetes Dev Mailing List

Release announcements, exception requests and other project-wide communication go to [dev@kubernetes.io](https://groups.google.com/a/kubernetes.io/g/dev). Every Release Team member should be subscribed.

### Calendar

Release Team meetings, burndown meetings and the release deadlines are published in the [Kubernetes Release Calendar](https://rel.k8s.io/release-team-cal). Subscribing to the SIG Release mailing list typically adds the meeting invites to your calendar as well.

### Familiarize with Prow commands

Kubernetes uses [Prow](https://docs.prow.k8s.io/docs/overview/) to manage CI automation. Issues and PRs are categorized by applying suitable labels, which helps in prioritization of that specific issue/PR during the release cycle. Learn more about the available labels and Prow commands from the [command help](https://prow.k8s.io/command-help).

## Role Leads

The leads of each role need some access. If this is your first time as a lead, please go through the following list and make sure you have the required access.

### Milestone Maintainers

The leads of all roles should be able to manage issue milestones (often in [k/enhancements](https://github.com/kubernetes/enhancements)) using the [Prow `/milestone` command](https://prow.k8s.io/command-help#milestone). To gain access as a Milestone Maintainer, please talk to the Release Team Lead, who updates the [milestone-maintainers](https://github.com/orgs/kubernetes/teams/milestone-maintainers) GitHub team every cycle.

### OWNERS File Entries

Each role lead is listed in the `<role>-subteam-approvers` alias of the [`OWNERS_ALIASES`](/OWNERS_ALIASES) file of this repository, so that they can approve changes to their handbook and review changes to the release directory. Open a PR to update the aliases at the start of the cycle.

## Release Team Lead

The Release Team Lead needs some additional access. With great power comes great responsibility.

### OWNERS File Entries

The Release Team Lead and the lead shadows are listed in the `release-team-lead` and `release-team-lead-shadows` aliases of the [`OWNERS_ALIASES`](/OWNERS_ALIASES) file. When you become Release Team Lead, open a PR to update them.

### Everything Else

Please open a [Release Team Lead Cycle Progress issue][rtl-progress] from the issue template. Its first section is the official checklist for Zoom meeting owner codes, release team calendar access, Google Group ownership and everything else you need in order to fulfill your role as lead, together with your lead shadows.

[rtl-progress]: https://github.com/kubernetes/sig-release/issues/new?template=release-team-lead-progress.md
