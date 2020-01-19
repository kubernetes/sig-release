# Release Team Onboarding Guide

When joining the Release Team or taking on a new role on the Release Team, there are various lists and groups you'll need to be apart of, various permissions that you'll need to have, keys you may need to know, etc. For roles ranging from someone new to the Kubernetes Community to the incoming Release Lead, this document aims to enumerate the access that you'll need to ensure you have to various repos and tools.

## New Members

If you're a brand new member to the Kubernetes Community or the Release Team, welcome! It's great to have you involved with SIG Release.

### Slack

The communication and coordination for the overwhelming majority of SIG Release topics happens in the [`#sig-release`](https://kubernetes.slack.com/messages/C2C40FMNF/) channel of the Kubernetes Slack. If you need access to the Kubernetes Slack, please see [http://slack.k8s.io/](http://slack.k8s.io/). If you need help with any of your additional access needs, `#sig-release` is a good place to ask for help.

### Kubernetes Community Membership

The Kubernetes Community [defines](https://github.com/kubernetes/community/blob/master/community-membership.md#member) Members as the following:

> Members are continuously active contributors in the community. They can have issues and PRs assigned to them, participate in SIGs through GitHub teams, and pre-submit tests are automatically run for their PRs. Members are expected to remain active contributors to the community.
>
> Defined by: Member of the Kubernetes GitHub organization

The requirements for becoming a member are enumerated in the [k/community repo documentation](https://github.com/kubernetes/community/blob/master/community-membership.md#member). Generally, you'll need a few public contributions and some existing community members to sponsor you. The Release Team is a great place to meet members of the community that might be able to meet sponsors!

For new shadows, it's not always necessary to become a member of the GitHub organization right away. Talk to the lead for the Release Team role you're shadowing for the definitive answer. For some roles (Enhancements for example) it is important for Shadows to be members of the GitHub organization because they have to maintain milestones in the [k/enhancements](https://github.com/kubernetes/enhancements) repo. For other roles (Release Notes for example), it's less urgent for new Shadows to be members of the GitHub organization. Your mileage may vary, but you should try to become an official member of the Kubernetes Community as soon as possible.

## All Members

### Contact Sheet

Each release has a Release Team contact sheet which is a source of truth for who has which role in the Release Team and what their contact information is. The Release Lead usually makes this very early on in the release. Make sure that you have filled in your contact information in the contact sheet as soon as you become a member of the Release Team.

### Mailing Lists

There are a few mailing lists that you should be aware of. Depending on your relationship with the Release Team, you may want to join one or more of the following lists:

#### Release Team Mailing List

All members of the current release team should be apart of this list. If you're on the Release Team and cannot access: https://groups.google.com/forum/#!forum/kubernetes-release-team, please tell your role lead or the Release Team lead that you need access. The Release Lead, as well as Relase Lead shadows, can manage list membership. 

#### SIG Release Mailing List

All members of the release team and anyone who attends Release Team meetings / keeps up with the release process should join the SIG Release group: https://groups.google.com/forum/#!forum/kubernetes-sig-release

## Role Leads

The leads of each role need some access. If this is your first time as a lead, please go through the following list and make sure you have the required access.

### Milestone Maintainers

The leads of all roles should be able to manage issue milestones (often in [k/enhancements](https://github.com/kubernetes/enhancements)) using the [Prow `/milestone` command](https://prow.k8s.io/command-help#milestone). To gain access as a Milestone Maintainer, please talk to the Release Lead. For more information on Prow, see [the docs](https://github.com/kubernetes/test-infra/tree/master/prow).

## Release Lead

The Release Lead needs some additional access. With great power comes great responsibility.

### `OWNER` File Entries

The Release Lead (and most past Release Leads) are members of the `release-team-lead-role` role in [k/release](https://github.com/kubernetes/release). When you become Release Lead, PR yourself to the [`OWNERS_ALIASES`](https://github.com/kubernetes/release/blob/78f68a268c6c3920d65c6642f9f19eb8277e897d/OWNERS_ALIASES#L23-L27) file.

Similarly, you'll also need to be in a group by the same name in [k/sig-release](https://github.com/kubernetes/sig-release). PR yourself to the [`OWNERS_ALIASES`](https://github.com/kubernetes/sig-release/blob/32577773bd37f844860cdcc6c0a384007de4f34b/OWNERS_ALIASES#L17-L21) in that repo as well.

### Everything Else...

Please complete a [Release Team Lead onboarding issue][rtl-onboarding]

The onboarding issue will be the official checklist for Zoom meeting owner
code, release team calendar access, etc.
The issue will help you keep track of all the things you need in order to
fulfill your role as lead and lead shadows.

[rtl-onboarding]: https://github.com/kubernetes/sig-release/issues/new?labels=sig%2Frelease%2C+area%2Frelease-eng%2C+area%2Frelease-team&template=release-team-lead.md&title=Release+Team+Lead+access+for+%3CGH-handle%3E
