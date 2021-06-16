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
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.23/release-team.md)
* [Meeting Minutes](http://bit.ly/k8s122-releasemtg) (join [kubernetes-sig-release@] to receive meeting invites)
* [v1.23 Release Calendar][k8s123-calendar]
* Contact: [#sig-release] on slack, [kubernetes-release-team@] on e-mail
* [Internal Contact Info][Internal Contact Info] (accessible only to members of [kubernetes-release-team@])

#### Tracking docs

* [Enhancements Tracking Sheet](TBD)
* [Feature blog Tracking Sheet](TBD)
* [Bug Triage Tracking Sheet](TBD)
* CI Signal Report: TODO
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.23 milestone](https://github.com/kubernetes/kubernetes/milestone/51)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## TL;DR

The 1.23 release cycle is proposed as follows:

- **Monday, August 23rd**: Week 1 - Release cycle begins
- **TBD**: TBD - [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **TBD**: TBD - [Code Freeze](../release_phases.md#code-freeze)
- **TBD**: TBD - [Test Freeze](../release_phases.md#test-freeze)
- **TBD**: TBD - Docs must be completed and reviewed
- **Tuesday, December 7th**: Week 16 - Kubernetes v1.23.0 released
- **TBD**: Week 17 - Release Retrospective

## Timeline

| **What** | **Who** | **When** | **WEEK** | **CI SIGNAL** |
|---|---|-------|---|---|
| Start of Release Cycle | Lead | Mon August 23rd | week 1 | [master-blocking] |
| Start Enhancements Tracking | Enhancements Lead | Mon August 23rd | Week 1 | |
| 1.230-alpha.1 released | Branch Manager ([TBD](TBD)) | Wed August 25  | Week 1 | |
| Schedule finalized | Lead | Thur August 26 | week 1 | |
| Team finalized | Lead | Fri August 27 | week 1 | |
| **Begin [Enhancements Freeze]** (23:59 PDT) | Enhancements Lead | TBD | TBD | [master-blocking], [master-informing] |
| 1.23.0-alpha.2 released | Branch Manager ([@TBD](TBD)) | TBD | TBD | |
| 1.23.0-alpha.3 released | Branch Manager ([TBD](TBD)) | TBD | TBD | |
| KubeCon NA + Co-located events | | Oct 11-15 | | Week 8 |
| 1.23.0-beta.0 released | Branch Manager ([TBD](TBD)) | TBD | TBD | |
| **Begin [Burndown]** (MWF meetings) | Lead | TBD | TBD | [1.23-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]** | Lead | TBD | TBD | |
| Brace Yourself, Code Freeze is Coming | Comms / Bug Triage | TBD | TBD | |
| **Begin Feature blog freeze** (23:59 PDT) | Comms Lead | TBD | TBD | |
| 1.23.0-beta.1 released | Branch Manager ([TBD](TBD)) | TBD | TBD | |
| **Begin [Code Freeze]** (18:00 PDT) | Branch Manager | TBD | TBD | |
| Docs deadline - Open placeholder PRs | Docs Lead |TBD | TBD | |
| Burndown Meetings daily| Lead | TBD | TBD | |
| 1.23.0-beta.2 released | Branch Manager ([TBD](TBD)) | TBD | TBD | |
| **[Test Freeze]** (18:00 PDT) | Branch Manager | TBD | TBD | |
| Docs deadline - PRs ready for review | Docs Lead | TBD | TBD | |
| 1.23.0-rc.0 released | Branch Manager ([TBD](TBD)) | TBD | TBD | |
| release-1.23 branch created | Branch Manager | TBD | TBD | |
| release-1.23 jobs created | Branch Manager | TBD | TBD | |
| Start final draft of Release Notes | Release Notes Lead | TBD | TBD | |
| Release blog ready to review (23:59 PDT) | Comms / Docs | TBD | TBD | |
| Docs complete - All PRs reviewed and ready to merge | Docs Lead | TBD | TBD | |
| Feature blogs ready to review (23:59 PDT)| Enhancement Owner / SIG Leads | TBD | TBD | |
| Release Notes complete - reviewed & merged to `k/sig-release` (23:59 PDT) | Release Notes Lead | TBD | TBD | |
| **v1.23.0 released** | Branch Manager ([TBD](TBD)) | Tues December 7 | Week 16 | |
| Release blog published | Comms | Tues December 7 | Week 16 | |
| **[Thaw]** | Branch Manager | Tues December 7 | Week 16 | |
| Release retrospective | Community | TBD | Week 17 | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s123-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: TBD
[Retrospective Document]: https://TBD

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
[1.23-blocking]: https://testgrid.k8s.io/sig-release-1.23-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
