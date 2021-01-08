---
title: "Kubernetes 1.21 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.21

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.21/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.21/release-team.md)
* [Meeting Minutes](http://bit.ly/k8s121-releasemtg) (join [kubernetes-sig-release@] to receive meeting invites)
* [v1.21 Release Calendar][k8s121-calendar]
* Contact: [#sig-release] on slack, [kubernetes-release-team@] on e-mail
* [Internal Contact Info][Internal Contact Info] (accessible only to members of [kubernetes-release-team@])

#### Tracking docs

* Enhancements Tracking Sheet: TODO
* Bug Triage Tracking Sheet: TODO
* CI Signal Report: TODO
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.21 milestone](https://github.com/kubernetes/kubernetes/milestone/49)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## TL;DR

The 1.21 release cycle is proposed as follows:

- **Monday, January 11th**: Week 1 - Release cycle begins
- **Tuesday, February 9th**: Week 5 - [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **Tuesday, March 9th**: Week 9 - [Code Freeze](../release_phases.md#code-freeze)
- **TBC**: TBC - [Test Freeze](../release_phases.md#test-freeze)
- **TBC**: TBC - Docs must be completed and reviewed
- **Thursday, April 8th**: Week 13 - Kubernetes v1.21.0 released
- **TBC**: TBC - Release Retrospective

## Timeline

> The below schedule is tentative and would be finalized by Thursday, January 14.

| **What** | **Who** | **When** | **WEEK** | **CI SIGNAL** |
|---|---|---|---|---|
| Start of Release Cycle | Lead | Mon January 11 | week 1 | [master-blocking] |
| Start Enhancements Tracking | Enhancements Lead | Tue January 12 | | |
| Schedule finalized | Lead | Thurs January 14 | | |
| Team finalized | Lead | Friday January 15 |  | |
| 1.21.0-alpha.1 released | Branch Manager | TBC | TBC | |
| Start Release Notes Draft | Release Notes Lead | TBC | TBC | |
| **Begin [Enhancements Freeze]** (EOD PST) | Enhancements Lead | Tue February 9th | week 5 | [master-blocking], [master-informing] |
| 1.21.0-alpha.2 released | Branch Manager | TBC | TBC | |
| 1.21.0-alpha.3 released | Branch Manager | TBC | TBC | |
| 1.21.0-beta.0 released | Branch Manager | TBC | TBC | |
| **Begin [Burndown]** (MWF meetings) | Lead | Mon March 1 | week 8 | [1.21-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]** | Lead | Mon March 1 | | |
| Brace Yourself, Code Freeze is Coming | Comms / Bug Triage | Mon March 1 | | |
| 1.21.0-beta.1 released | Branch Manager | TBC | | |
| Docs deadline - Open placeholder PRs | Docs Lead | TBC | | |
| **Begin [Code Freeze]** (EOD PST) | Branch Manager | Tue March 9 | week 9 | |
| Burndown Meetings daily| Lead | Mon March 15 | week 10 | |
| 1.21.0-beta.2 released | Branch Manager | TBC | | |
| Docs deadline - PRs ready for review | Docs Lead | TBC | TBC | |
| **[Test Freeze]** (EOD PST) | Branch Manager | TBC | |
| Docs complete - All PRs reviewed and ready to merge | Docs Lead | TBC | TBC | |
| release-1.21 branch created | Branch Manager | TBC | | |
| release-1.21 jobs created | Branch Manager | TBC | | |
| 1.21.0-rc.0 released | Branch Manager | TBC | | |
| **v1.21.0 released** | Branch Manager | Thurs April 8 | week 13 | |
| **[Thaw]** | Branch Manager | Thurs April 8 | | |
| Release retrospective | Community | TBC | TBC | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s121-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: http://bit.ly/k8s121-contacts
[Retrospective Document]: http://bit.ly/k8s121-retro

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
[1.21-blocking]: https://testgrid.k8s.io/sig-release-1.21-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
