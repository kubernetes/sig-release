---
title: "Kubernetes 1.24 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.24 Stargazer

<p align="center">
  <img src="./logo/main-logo.png" height="500" alt="Kubernetes 1.24 Release Logo" />
</p>

Kubernetes 1.24 is named *Stargazer*, for all those that would look to the night sky. ✨

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.24/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.24/release-team.md)
* [Meeting Minutes](http://bit.ly/k8s124-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.24 Release Calendar][k8s124-calendar]
* Contact: [#sig-release] on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info] (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Sheet](https://bit.ly/k8s124-enhancements)
* [Feature blog Tracking Sheet](http://bit.ly/k8s124-feature-blog)
* [Bug Triage Tracking Sheet](https://bit.ly/k8s124-bug-triage-tracking)
* [CI Signal Project Board & Issue Tracking](https://github.com/orgs/kubernetes/projects/68)
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.24 milestone](https://github.com/kubernetes/kubernetes/milestone/56)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.24 release cycle is as follows:

- **Monday 10th January 2022**: Week 1 — Release cycle begins
- **Thursday 27th January 2022**: Week 3 — [Production Readiness Soft Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **02:00 UTC Friday 4th February 2022** / **18:00 PST Thursday 3rd February 2022** : Week 4 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **Wednesday 23rd March 2022**: Week 11 — [Release Retrospective][Retrospective Document] part 1
- **01:00 UTC Wednesday 30th March 2022** / **02:00 BST Wednesday 30th March 2022** / **18:00 PDT Tuesday 29th March 2022**: Week 12 — [Code Freeze](../release_phases.md#code-freeze)
- **01:00 UTC Wednesday 6th April 2022** / **02:00 BST Wednesday 6th April 2022** / **18:00 PDT Tuesday 5th April 2022**: Week 13 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 12th April 2022**: Week 14 — Docs must be completed and reviewed
- **Tuesday 3rd May 2022**: Week 17 — Kubernetes v1.24.0 released
- **Wednesday 11th May 2022**: Week 18 — [Release Retrospective][Retrospective Document] part 2
- **Thursday 12th May 2022**: Week 18 — [Release Retrospective][Retrospective Document] part 3

## Timeline

| **What** | **Who** | **When** | **Week** | **CI Signal** |
|---|---|-------|---|---|
| Start of Release Cycle | Lead | Monday 10th January 2022 | week 1 | [master-blocking] |
| Start Enhancements Tracking | Enhancements Lead | Monday 10th January 2022 | week 1 | |
| Schedule finalized | Lead | Friday 14th January 2022 | week 1 | |
| Team finalized | Lead | Friday 14th January 2022 | week 1 | |
| Start Release Notes Draft | Release Notes Lead | Tuesday 25th January 2022 | week 3 | |
| Production Readiness Soft Freeze | Enhancements Lead | Thursday 27th January 2022 | week 3 | |
| 1.24.0-alpha.2 released | Branch Manager | Tuesday 1st February 2022 | Week 4 | |
| **Begin [Enhancements Freeze]** | Enhancements Lead | 02:00 UTC Friday 4th February 2022 / 18:00 PST Thursday 3rd February 2022 | week 4 | [master-blocking], [master-informing] |
| 1.24.0-alpha.3 released | Branch Manager | Tuesday 15th February 2022 | Week 6 | |
| Begin Friday APAC-friendly meetings | Lead | Friday 25th February 2022 | Week 7 | |
| (most of) North America enters Daylight Savings Time | | Sunday 13th March 2022 | | |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings) | Lead | Monday 21st March 2022 | week 11 | [1.24-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]** | Lead | Monday 21st March 2022 | week 11 | |
| Brace Yourself, Code Freeze is Coming | Comms / Bug Triage | Monday 21st March 2022 | week 11 | |
| **Begin Feature blog freeze** | Comms Lead | 01:00 UTC Wednesday 23rd March 2022 / 18:00 PDT Tuesday 22nd March 2022 | week 11 | |
| 1.24.0-alpha.4 released | Branch Manager | Tuesday 22nd March 2022 | Week 11 | |
| Release retrospective part 1 | Community | 17:00 UTC Wednesday 23rd March 2022 / 10:00 PDT Wednesday 23rd March 2022 | week 11 | |
| (most of) Europe enters Daylight Savings Time | | Sunday 27th March 2022 | | |
| Burndown Meetings daily | Lead | Monday 28th March 2022 | week 12 | |
| **Begin [Code Freeze]** | Branch Manager | 01:00 UTC Wednesday 30th March 2022 / 02:00 BST Wednesday 30th March 2022 / 18:00 PDT Tuesday 29th March 2022 | week 12 | |
| 1.24.0-beta.0 released | Branch Manager | Wednesday 30th March 2022 | week 12 | |
| Docs deadline — Open placeholder PRs | Docs Lead | Thursday 31st March 2022 | week 12 | |
| Deprecations and Removals blog published | Comms | Thursday 31st March 2022 | week 12 | |
| **[Test Freeze]** | Branch Manager | 01:00 UTC Wednesday 6th April 2022 / 02:00 BST Wednesday 6th April 2022 / 18:00 PDT Tuesday 5th April 2022 | week 13 | |
| Docs deadline — PRs ready for review | Docs Lead | Tuesday 5th April 2022 | week 13 | |
| Start final draft of Release Notes | Release Notes Lead | Tuesday 5th April 2022 | week 13 | |
| Release blog ready to review | Comms / Docs | 01:00 UTC Wednesday 6th April 2022 / 02:00 BST Wednesday 6th April 2022 / 18:00 PDT Tuesday 5th April 2022 | week 13 | |
| Docs complete — All PRs reviewed and ready to merge | Docs Lead |  Tuesday 12th April 2022 | week 14 | |
| Feature blogs ready to review | Enhancement Owner / SIG Leads |  Tuesday 12th April 2022 | week 14 | |
| Release Notes complete — reviewed & merged to `k/sig-release` | Release Notes Lead | 01:00 UTC Friday 15th April 2022 / 02:00 BST Friday 15th April 2022 / 18:00 PDT Thursday 14th April 2022 | week 14 | |
| 1.24.0-rc.0 released | Branch Manager | Tuesday 19th April 2022 | week 15 | |
| release-1.24 branch created | Branch Manager | Tuesday 19th April 2022 | week 15 | |
| release-1.24 jobs created | Branch Manager | Tuesday 19th April 2022 | week 15 | |
| 1.24.0-rc.1 released | Branch Manager | Tuesday 26th April 2022 | week 16 | |
| **v1.24.0 released** | Branch Manager | Tuesday 3rd May 2022 | week 17 | |
| Release blog published | Comms | Tuesday 3rd May 2022 | week 17 | |
| **[Thaw]** | Branch Manager | Tuesday 3rd May 2022 | week 17 | |
| Release retrospective part 2 (16:00 UTC) | Community | Wednesday 11th May 2022 | week 18 | |
| Release retrospective part 3 (16:00 UTC) | Community | Thursday 12th May 2022 | week 18 | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s124-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: https://bit.ly/k8s124-contacts
[Retrospective Document]: https://bit.ly/k8s124-retro

[Enhancements Freeze]: ../release_phases.md#enhancements-freeze
[Burndown]: ../release_phases.md#burndown
[Code Freeze]: ../release_phases.md#code-freeze
[Exception]: ../release_phases.md#exceptions
[Thaw]: ../release_phases.md#thaw
[Test Freeze]: ../release_phases.md#test-freeze

[release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team
[kubernetes-sig-release@]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[#sig-release]: https://kubernetes.slack.com/messages/sig-release/
[kubernetes-release-calendar]: https://bit.ly/k8s-release-cal
[kubernetes/kubernetes]: https://github.com/kubernetes/kubernetes

[master-blocking]: https://testgrid.k8s.io/sig-release-master-blocking#Summary
[master-informing]: https://testgrid.k8s.io/sig-release-master-informing#Summary
[1.24-blocking]: https://testgrid.k8s.io/sig-release-1.24-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
