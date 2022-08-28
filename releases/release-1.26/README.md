---
title: "Kubernetes 1.26 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.26

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.26/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.26/release-team.md)
* [Meeting Minutes](http://bit.ly/k8s126-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.26 Release Calendar][k8s126-calendar]
* Contact: [#sig-release] on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info] (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Sheet](https://bit.ly/k8s126-enhancements)
* [Feature blog Tracking Sheet](http://bit.ly/k8s126-feature-blog)
* [Bug Triage Tracking Sheet](https://bit.ly/k8s126-bug-triage-tracking)
* [CI Signal Project Board & Issue Tracking](https://github.com/orgs/kubernetes/projects/68)
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.26 milestone](https://github.com/kubernetes/kubernetes/milestone/59)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.26 release cycle is as follows:

- **Monday 5th September 2022**: Week 1 — Release cycle begins
- **Thursday 29th September 2022**: Week 4 — [Production Readiness Soft Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **01:00 UTC Friday 7th October 2022** / **18:00 PDT Thursday 6th October 2022** : Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **Wednesday 27th July 2022**: Week 11 — [Release Retrospective][Retrospective Document] part 1
- **01:00 UTC Wednesday 23rd November 2022** / **02:00 BST Wednesday 23rd November 2022** / **18:00 PDT Tuesday 22nd November 2022**: Week 12 — [Code Freeze](../release_phases.md#code-freeze)
- **01:00 UTC Wednesday 30th November 2022** / **02:00 BST Wednesday 30th November 2022** / **18:00 PDT Tuesday 29th November 2022**: Week 13 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 6th December 2022**: Week 14 — Docs must be completed and reviewed
- **Tuesday 13rd December 2022**: Week 15 — Kubernetes v1.26.0 released
- **TBC**: Week 16 — [Release Retrospective][Retrospective Document] part 2

## Timeline

| **What**                                                      | **Who** | **When**                                                                                                        | **Week** | **CI Signal** |
|---------------------------------------------------------------|---|-----------------------------------------------------------------------------------------------------------------|----------|---|
| Start of Release Cycle                                        | Lead | Monday 5th September 2022                                                                                                         | week 1   | [master-blocking] |
| Start Enhancements Tracking                                   | Enhancements Lead | Monday 5th September 2022                                                                                            | week 1   | |
| Schedule finalized                                            | Lead | Friday 9th September 2022                                                                                                         | week 1   | |
| Team finalized                                                | Lead | Friday 9th September 2022                                                                                                         | week 1   | |
| Start Release Notes Draft                                     | Release Notes Lead | Tuesday 20th September 2022                                                                                         | week 3   | |
| 1.26.0-alpha.1 released                                       | Branch Manager | Wednesday 28th September 2022                                                                                           | Week 4   | |
| Production Readiness Soft Freeze                              | Enhancements Lead | Thursday 29th September 2022                                                                                         | week 4   | |
| **Begin [Enhancements Freeze]**                               | Enhancements Lead | 01:00 UTC Friday 7th October 2022 / 18:00 PDT Thursday 6th October 2022                                              | week 5   | [master-blocking], [master-informing] |
| 1.26.0-alpha.2 released                                       | Branch Manager | Tuesday 11th October 2022                                                                                               | Week 6   | |
| KubeCon NA                                                    | | October 24-28 2022                                                                                                                     | week 8   | [KubeCon NA](https://events.linuxfoundation.org/kubecon-cloudnativecon-north-america/) |
| Begin Friday APAC-friendly meetings                           | Lead | Friday 4th November 2022                                                                                                          | Week 9   | |
| 1.26.0-alpha.3 released                                       | Branch Manager | Tuesday 8th November 2022                                                                                               | Week 10  | |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings) | Lead | Monday 14th November 2022                                                                                                         | week 11  | [1.26-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]**                          | Lead | Monday 14th November 2022                                                                                                         | week 11  | |
| Brace Yourself, Code Freeze is Coming                         | Comms / Bug Triage | Monday 14th November 2022                                                                                           | week 11  | |
| **Begin Feature blog freeze**                                 | Comms Lead | 01:00 UTC Wednesday 16th November 2022 / 18:00 PDT Tuesday 15th November 2022                                               | week 11  | |
| Release retrospective part 1                                  | Community | 17:00 UTC Wednesday 16th November 2022 / 10:00 PDT Wednesday 16th November 2022                                              | week 11  | |
| Burndown Meetings daily                                       | Lead | Monday 21st November 2022                                                                                                         | week 12  | |
| **Begin [Code Freeze]**                                       | Branch Manager | 01:00 UTC Wednesday 23rd November 2022 / 02:00 BST Wednesday 23rd November 2022 / 18:00 PDT Tuesday 22nd November 2022  | week 12  | |
| 1.26.0-beta.0 released                                        | Branch Manager | Thursday 24th November 2022                                                                                             | week 12  | |
| Docs deadline — Open placeholder PRs                          | Docs Lead | Thursday 24th November 2022                                                                                                  | week 12  | |
| Deprecations and Removals blog published                      | Comms | Thursday 24th November 2022                                                                                                      | week 12  | |
| **[Test Freeze]**                                             | Branch Manager | 01:00 UTC Wednesday 30th November 2022 / 02:00 BST Wednesday 30th November 2022 / 18:00 PDT Tuesday 29th November 2022  | week 13  | |
| Docs deadline — PRs ready for review                          | Docs Lead | Tuesday 29th November 2022                                                                                                   | week 13  | |
| 1.26.0-rc.0 released                                          | Branch Manager | Tuesday 29th November 2022                                                                                              | week 13  | |
| release-1.26 branch created                                   | Branch Manager | Tuesday 29th November 2022                                                                                              | week 13  | |
| release-1.26 jobs created                                     | Branch Manager | Tuesday 29th November 2022                                                                                              | week 13  | |
| Start final draft of Release Notes                            | Release Notes Lead | Tuesday 29th November 2022                                                                                          | week 13  | |
| Release blog ready to review                                  | Comms / Docs | 01:00 UTC Wednesday 30th November 2022 / 02:00 BST Wednesday 30th November 2022 / 18:00 PDT Tuesday 29th November 2022    | week 13  | |
| Major Themes complete                                         | Release Notes Lead | Tuesday 6th December 2022                                                                                           | week 14  | |
| Docs complete — All PRs reviewed and ready to merge           | Docs Lead | Tuesday 6th December 2022                                                                                                    | week 14  | |
| Feature blogs ready to review                                 | Enhancement Owner / SIG Leads | Tuesday 6th December 2022                                                                                | week 14  | |
| 1.26.0-rc.1 released                                          | Branch Manager | Tuesday 6th December 2022                                                                                               | week 14  | |
| Release Notes complete — reviewed & merged to `k/k` | Release Notes Lead | 01:00 UTC Friday 9th December 2022 / 02:00 BST Friday 9th December 2022 / 18:00 PDT Thursday 8th December 2022                | week 14  | |
| **v1.26.0 released**                                          | Branch Manager | Tuesday 13rd December 2022                                                                                              | week 15  | |
| Release blog published                                        | Comms | Tuesday 13rd December 2022                                                                                                       | week 15  | |
| **[Thaw]**                                                    | Branch Manager | Tuesday 13rd December 2022                                                                                              | week 15  | |
| Release retrospective part 2 (**Time TBC**)                   | Community | TBC                                                                                                                          | week 16  | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s126-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: https://bit.ly/k8s126-contacts
[Retrospective Document]: https://bit.ly/k8s126-retro

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
[1.26-blocking]: https://testgrid.k8s.io/sig-release-1.26-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
