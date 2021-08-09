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
* [Feature blog Tracking Sheet](http://bit.ly/k8s122-feature-blog)
* [Bug Triage Tracking Sheet](https://bit.ly/1-22-bug-triage-tracking)
* [CI Signal Report](https://docs.google.com/document/d/1SjO1632JRUWqR_Jxg5h0ixezqn9yStU5I7n-gyV15NY/edit?usp=sharing)
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
- **Thursday August 19**: Week 16 - [Release Retrospective](https://zoom.us/j/91768411674?pwd=MVpqL0ZHbGFYMnpXVXpybTBvalFRQT09) at 10:00 AM (PDT) at the Kubernetes Community Meeting

## Timeline

| **What** | **Who** | **When** | **WEEK** | **CI SIGNAL** |
|---|---|-------|---|---|
| Start of Release Cycle | Lead | Mon April 26 | week 1 | [master-blocking] |
| Start Enhancements Tracking | Enhancements Lead | Mon April 26 | week 1 | |
| 1.22.0-alpha.1 released | Branch Manager ([@puerco](https://github.com/puerco)) | Wed April 28  | week 1 | |
| Schedule finalized | Lead | Thur April 29 | week 1 | |
| Team finalized | Lead | Fri April 30 | week 1 | |
| KubeCon EU + Co-located events | | May 3-7 | | |
| **Begin [Enhancements Freeze]** (23:59 PDT) | Enhancements Lead | Thur May 13 | week 3 | [master-blocking], [master-informing] |
| 1.22.0-alpha.2 released | Branch Manager ([@Verolop](https://github.com/Verolop)) | Tue May 18 | week 4 |[@mkorbi](https://github.com/mkorbi) |
| 1.22.0-alpha.3 released | Branch Manager ([@wilsonehusin](https://github.com/wilsonehusin)) | Tue June 8 | week 7 | [@lambdanis](https://github.com/lambdanis) |
| 1.22.0-beta.0 released | Branch Manager ([@onlydole](https://github.com/onlydole)) | Tue June 22 | week 9 |[@ramrodo](https://github.com/ramrodo) |
| **Begin [Burndown]** (MWF meetings) | Lead | Mon June 28 | week 10 | [1.22-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]** | Lead | Mon June 28 | week 10 | |
| Brace Yourself, Code Freeze is Coming | Comms / Bug Triage | Mon June 28 | week 10 | |
| **Begin Feature blog freeze** (23:59 PDT) | Comms Lead | Mon June 28 | week 10 | |
| 1.22.0-beta.1 released | Branch Manager ([@ameukam](https://github.com/ameukam)) | Thu July 8 | week 11 | [@encodeflush](https://github.com/encodeflush)|
| **Begin [Code Freeze]** (18:00 PDT) | Branch Manager | Thur July 8 | week 11 | |
| Docs deadline - Open placeholder PRs | Docs Lead | Fri July 9 | week 11 | |
| Burndown Meetings daily| Lead | Mon July 12 | week 12 | |
| 1.22.0-beta.2 released | Branch Manager ([@jimangel](https://github.com/jimangel)) | Tue Jul 13 | week 12 | [@soniasingla](https://github.com/soniasingla)|
| **[Test Freeze]** (18:00 PDT) | Branch Manager | Thur July 15 | week 12 | |
| Docs deadline - PRs ready for review | Docs Lead | Tue July 20 | week 13 | |
| 1.22.0-rc.0 released | Branch Manager ([@puerco](https://github.com/puerco)) | Tue July 20 | week 13 | [@mkorbi](https://github.com/mkorbi) |
| release-1.22 branch created | Branch Manager | Tue July 20 | week 13 | |
| release-1.22 jobs created | Branch Manager | Tue July 20 | week 13 | |
| Start final draft of Release Notes | Release Notes Lead | Tue July 20 | week 13 | |
| Release blog ready to review (23:59 PDT) | Comms / Docs | Wed July 21 | Week 13 | |
| Docs complete - All PRs reviewed and ready to merge | Docs Lead | Tue July 27 | week 14 | |
| Feature blogs ready to review (23:59 PDT)| Enhancement Owner / SIG Leads | Tue July 27 | week 14 | |
| Release Notes complete - reviewed & merged to `k/sig-release` (23:59 PDT) | Release Notes Lead | Thur July 29 | week 14 | |
| **v1.22.0 released** | Branch Manager ([@puerco](https://github.com/puerco)) | Wed August 4 | week 15 | [@mkorbi](https://github.com/mkorbi) |
| Release blog published | Comms | Wed August 4 | week 15 | |
| **[Thaw]** | Branch Manager | Wed August 4 | week 15 | |
| Release retrospective 10:00am PDT | [Community Meeting](https://zoom.us/j/91768411674?pwd=MVpqL0ZHbGFYMnpXVXpybTBvalFRQT09) | Thu August 19 | Week 17 | |

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
