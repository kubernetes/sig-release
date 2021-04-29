---
title: "Kubernetes 1.22 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.22

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.22/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.22/release-team.md)
* [Meeting Minutes](http://bit.ly/k8s122-releasemtg) (join [kubernetes-sig-release@] to receive meeting invites)
* [v1.22 Release Calendar][k8s122-calendar]
* Contact: [#sig-release] on slack, [kubernetes-release-team@] on e-mail
* [Internal Contact Info][Internal Contact Info] (accessible only to members of [kubernetes-release-team@])

#### Tracking docs

* [Enhancements Tracking Sheet](https://bit.ly/k8s122-enhancements)
* Bug Triage Tracking Sheet: TODO
* CI Signal Report: TODO
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.22 milestone](https://github.com/kubernetes/kubernetes/milestone/50)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## TL;DR

The 1.22 release cycle is proposed as follows:

- **Monday, April 26th**: Week 1 - Release cycle begins
- **Thursday, May 13th**: Week 3 - [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **Thursday, July 8th**: Week 11 - [Code Freeze](../release_phases.md#code-freeze)
- **Thursday, July 15th**: Week 12 - [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday, July 27th**: Week 14 - Docs must be completed and reviewed
- **Wednesday, August 4th**: Week 15 - Kubernetes v1.22.0 released
- **TBD**: Week 16 - Release Retrospective

## Timeline

| **What** | **Who** | **When** | **WEEK** | **CI SIGNAL** |
|---|---|-------|---|---|
| Start of Release Cycle | Lead | Mon April 26 | week 1 | [master-blocking] |
| Start Enhancements Tracking | Enhancements Lead | Mon April 26 | week 1 | |
| 1.22.0-alpha.1 released | Branch Manager (@puerco) | Wed April 28  | week 1 | |
| Schedule finalized | Lead | Thur April 29 | week 1 | |
| Team finalized | Lead | Fri April 30 | week 1 | |
| KubeCon EU + Co-located events | | May 3-7 | | |
| **Begin [Enhancements Freeze]** (Time TBD) | Enhancements Lead | Thur May 13 | week 3 | [master-blocking], [master-informing] |
| 1.22.0-alpha.2 released | Branch Manager (TBD) | Tue May 18 | week 4 | |
| 1.22.0-alpha.3 released | Branch Manager (TBD) | Tue June 7 | week 7 | |
| 1.22.0-beta.0 released | Branch Manager (TBD) | Tue June 21 | week 9 | |
| **Begin [Burndown]** (MWF meetings) | Lead | Mon June 28 | week 10 | [1.22-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]** | Lead | Mon June 28 | week 10 | |
| Brace Yourself, Code Freeze is Coming | Comms / Bug Triage | TBD | TBD | |
| **Begin Feature blog freeze** | Comms Lead | TBD | TBD | |
| 1.22.0-beta.1 released | Branch Manager (TBD) | Thu June 8 | week 11 | |
| **Begin [Code Freeze]** (18:00 PDT) | Branch Manager | Thur July 8 | week 11 | |
| Docs deadline - Open placeholder PRs | Docs Lead | Fri July 9 | week 11 | |
| Burndown Meetings daily| Lead | Mon July 12 | week 12 | |
| 1.22.0-beta.2 released | Branch Manager (TBD) | Tue Jul 13 | week 12 | |
| **[Test Freeze]** (18:00 PDT) | Branch Manager | Thur July 15 | week 12 | |
| Docs deadline - PRs ready for review | Docs Lead | Tue July 20 | week 13 | |
| 1.22.0-rc.0 released | Branch Manager (@puerco) | Tue July 20 | week 13 | |
| release-1.22 branch created | Branch Manager | Tue July 20 | week 13 | |
| release-1.22 jobs created | Branch Manager | Tue July 20 | week 13 | |
| Start final draft of Release Notes | Release Notes Lead | TBD | TBD | |
| Release blog ready to review | Comms / Docs | TBD | TBD | |
| Docs complete - All PRs reviewed and ready to merge | Docs Lead | Tue July 27 | week 14 | |
| Feature blogs ready to review | Enhancement Owner / SIG Leads | TBD | TBD | |
| Release Notes complete - reviewed & merged to `k/sig-release` | Release Notes Lead | TBD | TBD | |
| **v1.22.0 released** | Branch Manager (@puerco) | Wed August 4 | week 15 | |
| Release blog published | Comms | Wed August 4 | week 15 | |
| **[Thaw]** | Branch Manager | Wed August 4 | week 15 | |
| Release retrospective | Community | TBD | Week 16 | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s122-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: TBD
[Retrospective Document]: http://bit.ly/k8s122-retro

[Enhancements Freeze]: ../release_phases.md#enhancements-freeze
[Burndown]: ../release_phases.md#burndown
[Code Freeze]: ../release_phases.md#code-freeze
[Exception]: ../release_phases.md#exceptions
[Thaw]: ../release_phases.md#thaw
[Test Freeze]: ../release_phases.md#test-freeze

[kubernetes-release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team
[kubernetes-sig-release@]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[#sig-release]: https://kubernetes.slack.com/messages/sig-release/
[kubernetes-release-calendar]: https://bit.ly/k8s-release-cal
[kubernetes/kubernetes]: https://github.com/kubernetes/kubernetes

[master-blocking]: https://testgrid.k8s.io/sig-release-master-blocking#Summary
[master-informing]: https://testgrid.k8s.io/sig-release-master-informing#Summary
[1.22-blocking]: https://testgrid.k8s.io/sig-release-1.22-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
