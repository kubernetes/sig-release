---
title: "Kubernetes 1.23 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.23

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.23/README.md)
* [Release Team][release-team@]
* [Meeting Minutes](http://bit.ly/k8s123-releasemtg) (join [kubernetes-sig-release@] to receive meeting invites)
* [v1.23 Release Calendar][k8s123-calendar]
* Contact: [#sig-release] on slack, [kubernetes-release-team@] on e-mail
* [Internal Contact Info] (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Sheet](https://bit.ly/k8s123-enhancements)
* [Feature blog Tracking Sheet](TBD)
* [Bug Triage Tracking Sheet](TBD)
* CI Signal Report: TODO
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.23 milestone](https://github.com/kubernetes/kubernetes/milestone/56)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## TL;DR

The 1.23 release cycle is proposed as follows:

- **Monday, August 23, 2021**: Week 1 - Release cycle begins
- **Thursday, September 2, 2021**: Week 2 - [Production Readiness Soft Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **Thursday, September 9, 2021**: Week 3 - [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **Tuesday, November 16, 2021**: Week 13 - [Code Freeze](../release_phases.md#code-freeze)
- **Tuesday, November 23, 2021**: Week 14 - [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday, November 30, 2021**: Week 15 - Docs must be completed and reviewed
- **Tuesday, December 7, 2021**: Week 16 - Kubernetes v1.23.0 released
- **TBD**: Week 17 - Release Retrospective

## Timeline

| **What** | **Who** | **When** | **WEEK** | **CI SIGNAL** |
|---|---|-------|---|---|
| Start of Release Cycle | Lead | Mon August 23, 2021 | week 1 | [master-blocking] |
| Start Enhancements Tracking | Enhancements Lead | Mon August 23, 2021| week 1 | |
| Schedule finalized | Lead | Thu August 26, 2021 | week 1 | |
| Team finalized | Lead | Fri August 27, 2021 | week 1 | |
| Production Readiness Soft Freeze | Enhancements Lead | Thu September 2, 2021 | week 2 | |
| Start Release Notes Draft | Release Notes Lead | Tue September 7, 2021 | week 3 | |
| **Begin [Enhancements Freeze]** (23:59 PDT) | Enhancements Lead | Thu September 9, 2021 | week 3 | [master-blocking], [master-informing] |
| 1.23.0-alpha.2 released | Branch Manager | TBD | TBD | |
| 1.23.0-alpha.3 released | Branch Manager | TBD | TBD | |
| KubeCon NA + Co-located events | | October 11-15, 2021 | week 8 | |
| 1.23.0-alpha.4 released | Branch Manager | TBD | TBD | |
| **Begin [Burndown]** (MWF meetings) | Lead | Mon November 1, 2021 | week 11 | [1.23-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]** | Lead | Mon November 1, 2021 | week 11 | |
| Brace Yourself, Code Freeze is Coming | Comms / Bug Triage | Mon November 1, 2021 | week 11 | |
| **Begin Feature blog freeze** (23:59 PDT) | Comms Lead | Tue November 2, 2021 | week 11 | |
| Burndown Meetings daily| Lead | Mon November 15, 2021 | week 13 | |
| **Begin [Code Freeze]** (18:00 PST) | Branch Manager | Tue November 16, 2021 | week 13 | |
| 1.23.0-beta.0 released | Branch Manager | Tue November 16, 2021 | week 13 | |
| Docs deadline - Open placeholder PRs | Docs Lead | Thu November 18, 2021 | week 13 | |
| **[Test Freeze]** (18:00 PST) | Branch Manager | Tue November 23, 2021 | week 14 | |
| Docs deadline - PRs ready for review | Docs Lead | Tue November 23, 2021 | week 14 | |
| 1.23.0-rc.0 released | Branch Manager | Tue November 23, 2021 | week 14 | |
| release-1.23 branch created | Branch Manager | Tue November 23, 2021 | week 14 | |
| release-1.23 jobs created | Branch Manager | Tue November 23, 2021 | week 14 | |
| Start final draft of Release Notes | Release Notes Lead | Tue November 23, 2021 | week 14 | |
| Release blog ready to review (23:59 PST) | Comms / Docs | Tue November 23, 2021 | week 14 | |
| Docs complete - All PRs reviewed and ready to merge | Docs Lead | Tue November 30, 2021 | week 15 | |
| Feature blogs ready to review (23:59 PST)| Enhancement Owner / SIG Leads | Tue November 30, 2021 | week 15 | |
| Release Notes complete - reviewed & merged to `k/sig-release` (23:59 PST) | Release Notes Lead | Thu December 2, 2021 | week 15 | |
| **v1.23.0 released** | Branch Manager | Tue December 7, 2021 | week 16 | |
| Release blog published | Comms | Tue December 7, 2021 | week 16 | |
| **[Thaw]** | Branch Manager | Tue December 7, 2021 | week 16 | |
| Release retrospective | Community | TBD | week 17 | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s123-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: https://bit.ly/k8s123-contacts
[Retrospective Document]: https://bit.ly/k8s123-retro

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
[1.23-blocking]: https://testgrid.k8s.io/sig-release-1.23-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
