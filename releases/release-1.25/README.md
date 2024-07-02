---
title: "Kubernetes 1.25 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.25: Combiner

<p align="center">
  <img src="./logo/main-logo.png" height="500" alt="Kubernetes 1.25 Release Logo" />
</p>

Kubernetes 1.25 is named *Combiner*, to the combined force capable of changing the world!

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.25/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.25/release-team.md)
* [Meeting Minutes](http://bit.ly/k8s125-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.25 Release Calendar][k8s125-calendar]
* Contact: [#sig-release] on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info] (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Sheet](https://bit.ly/k8s125-enhancements)
* [Feature blog Tracking Sheet](http://bit.ly/k8s125-feature-blog)
* [Bug Triage Tracking Sheet](https://bit.ly/k8s125-bug-triage-tracking)
* [CI Signal Project Board & Issue Tracking](https://github.com/orgs/kubernetes/projects/68)
* [Retrospective Document][Retrospective Document]
* [kubernetes/sig-release v1.25 milestone](https://github.com/kubernetes/kubernetes/milestone/58)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.25 release cycle is as follows:

- **Monday 23rd May 2022**: Week 1 — Release cycle begins
- **Thursday 16th June 2022**: Week 4 — [Production Readiness Soft Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **01:00 UTC Friday 24th June 2022** / **18:00 PDT Thursday 23rd June 2022** : Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **Wednesday 27th July 2022**: Week 10 — [Release Retrospective][Retrospective Document] part 1
- **01:00 UTC Wednesday 3rd August 2022** / **02:00 BST Wednesday 3rd August 2022** / **18:00 PDT Tuesday 2nd August 2022**: Week 11 — [Code Freeze](../release_phases.md#code-freeze)
- **01:00 UTC Wednesday 10th August 2022** / **02:00 BST Wednesday 10th August 2022** / **18:00 PDT Tuesday 9th August 2022**: Week 12 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 16th August 2022**: Week 13 — Docs must be completed and reviewed
- **Tuesday 23rd August 2022**: Week 14 — Kubernetes v1.25.0 released
- **TBC**: Week 16 — [Release Retrospective][Retrospective Document] part 2

## Timeline

| **What**                                                      | **Who** | **When**                                                                                                        | **Week** | **CI Signal** |
|---------------------------------------------------------------|---|-----------------------------------------------------------------------------------------------------------------|----------|---|
| KubeCon EU                                                    | | May 16-20 2022                                                                                                  | week 0   | |
| Start of Release Cycle                                        | Lead | Monday 23rd May 2022                                                                                            | week 1   | [master-blocking] |
| Start Enhancements Tracking                                   | Enhancements Lead | Monday 23rd May 2022                                                                                            | week 1   | |
| Schedule finalized                                            | Lead | Friday 27th May 2022                                                                                            | week 1   | |
| Team finalized                                                | Lead | Friday 27th May 2022                                                                                            | week 1   | |
| Start Release Notes Draft                                     | Release Notes Lead | Tuesday 7th June 2022                                                                                           | week 3   | |
| 1.25.0-alpha.1 released                                       | Branch Manager | Wednesday 15th June 2022                                                                                             | Week 4   | |
| Production Readiness Soft Freeze                              | Enhancements Lead | Thursday 16th June 2022                                                                                         | week 4   | |
| **Begin [Enhancements Freeze]**                               | Enhancements Lead | 01:00 UTC Friday 24th June 2022 / 18:00 PDT Thursday 23rd June 2022                                             | week 5   | [master-blocking], [master-informing] |
| 1.25.0-alpha.2 released                                       | Branch Manager | Tuesday 28th June 2022                                                                                                             | Week 6   | |
| Begin Friday APAC-friendly meetings                           | Lead | Friday 8th July 2022                                                                                            | Week 7   | |
| 1.25.0-alpha.3 released                                       | Branch Manager | Tuesday 19th July 2022                                                                                               | Week 9   | |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings) | Lead | Monday 25th July 2022                                                                                           | week 10  | [1.25-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]**                          | Lead | Monday 25th July 2022                                                                                           | week 10  | |
| Brace Yourself, Code Freeze is Coming                         | Comms / Bug Triage | Monday 25th July 2022                                                                                           | week 10  | |
| **Begin Feature blog freeze**                                 | Comms Lead | 01:00 UTC Wednesday 27th July 2022 / 18:00 PDT Tuesday 26th July 2022                                           | week 10  | |
| Release retrospective part 1                                  | Community | 17:00 UTC Wednesday 27th July 2022 / 10:00 PDT Wednesday 27th July 2022                                         | week 10  | |
| Burndown Meetings daily                                       | Lead | Monday 1st August 2022                                                                                          | week 11  | |
| **Begin [Code Freeze]**                                       | Branch Manager | 01:00 UTC Wednesday 3rd August 2022 / 02:00 BST Wednesday 3rd August 2022 / 18:00 PDT Tuesday 2nd August 2022   | week 11  | |
| 1.25.0-beta.0 released                                        | Branch Manager | Thursday 4th August 2022                                                                                              | week 11  | |
| Docs deadline — Open placeholder PRs                          | Docs Lead | Thursday 4th August 2022                                                                                        | week 11  | |
| Deprecations and Removals blog published                      | Comms | Thursday 4th August 2022                                                                                        | week 11  | |
| **[Test Freeze]**                                             | Branch Manager | 01:00 UTC Wednesday 10th August 2022 / 02:00 BST Wednesday 10th August 2022 / 18:00 PDT Tuesday 9th August 2022 | week 12  | |
| Docs deadline — PRs ready for review                          | Docs Lead | Tuesday 9th August 2022                                                                                         | week 12  | |
| 1.25.0-rc.0 released                                          | Branch Manager | Tuesday 9th August 2022                                                                                                             | week 12  | |
| release-1.25 branch created                                   | Branch Manager | Tuesday 9th August 2022                                                                                                             | week 12  | |
| release-1.25 jobs created                                     | Branch Manager | Tuesday 9th August 2022                                                                                                             | week 12  ||
| Start final draft of Release Notes                            | Release Notes Lead | Tuesday 9th August 2022                                                                                         | week 12  | |
| Release blog ready to review                                  | Comms / Docs | 01:00 UTC Wednesday 10th August 2022 / 02:00 BST Wednesday 10th August 2022 / 18:00 PDT Tuesday 9th August 2022 | week 12  | |
| Major Themes complete                                         | Release Notes Lead | Tuesday 16th August 2022                                                                                        | week 13  | |
| Docs complete — All PRs reviewed and ready to merge           | Docs Lead | Tuesday 16th August 2022                                                                                        | week 13  | |
| Feature blogs ready to review                                 | Enhancement Owner / SIG Leads | Tuesday 16th August 2022                                                                                        | week 13  | |
| 1.25.0-rc.1 released                                          | Branch Manager | Tuesday 16th August 2022                                                                                                      | week 13  | |
| Release Notes complete — reviewed & merged to `k/k` | Release Notes Lead | 01:00 UTC Friday 19th August 2022 / 02:00 BST Friday 19th August 2022 / 18:00 PDT Thursday 18th August 2022     | week 13  | |
| **v1.25.0 released**                                          | Branch Manager | Tuesday 23rd August 2022                                                                                        | week 14  | |
| Release blog published                                        | Comms | Tuesday 23rd August 2022                                                                                        | week 14  | |
| **[Thaw]**                                                    | Branch Manager | Tuesday 23rd August 2022                                                                                        | week 14  | |
| Release retrospective part 2 (**Time TBC**)                   | Community | TBC                                                                                                             | week 15  | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s125-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: https://bit.ly/k8s125-contacts
[Retrospective Document]: https://bit.ly/k8s125-retro

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
[1.25-blocking]: https://testgrid.k8s.io/sig-release-1.25-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
