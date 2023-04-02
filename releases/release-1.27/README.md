---
title: "Kubernetes 1.27 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.27

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.27/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.27/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s127-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.27 Release Calendar][k8s127-calendar]
* Contact: [#sig-release] on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info] (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s127-enhancements)
* [Feature blog Tracking Board](#)
* [Bug Triage Tracking Board](https://bit.ly/k8s127-bug-triage-tracking)
* [CI Signal Project Board & Issue Tracking](#)
* [Retrospective Document](https://bit.ly/k8s127-retro)
* [kubernetes/sig-release v1.27 milestone](https://github.com/kubernetes/kubernetes/milestone/60)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.27 release cycle is as follows:

- **Monday 9th January 2023**: Week 1 — Release cycle begins
- **Thursday 2nd February 2023**: Week 4 — [Production Readiness Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **[01:00 UTC Friday 10th February 2023 / 18:00 PDT Thursday 9th February 2023](https://everytimezone.com/s/cc15bd3a)**: Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **[01:00 UTC Wednesday 15th March 2023 / 17:00 PDT Tuesday 14th March 2023](https://everytimezone.com/s/c4971746)**: Week 10 — [Code Freeze](../release_phases.md#code-freeze)
- **[01:00 UTC Wednesday 22nd March 2023 / 17:00 PDT Tuesday 21st March 2023](https://everytimezone.com/s/5d64ada0)**: Week 11 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 4th April 2023**: Week 13 — Docs must be completed and reviewed
- **Tuesday 11th April 2023**: Week 14 — Kubernetes v1.27.0 released
- **Monday 17th April 2023**: Week 15 - [KubeCon EU](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/)

## Timeline

| **What**                                                      | **Who** | **When**                                                                                                        | **Week** | **CI Signal** |
|---------------------------------------------------------------|---|-----------------------------------------------------------------------------------------------------------------|----------|---|
| Start of Release Cycle                                        | Lead | Monday 9th January 2023                                                                                                         | week 1   | [master-blocking] |
| Start Enhancements Tracking                                   | Enhancements Lead | Monday 9th January 2023                                                                                            | week 1   | |
| Schedule finalized                                            | Lead | Friday 13th January 2023                                                                                                         | week 1   | |
| Team finalized                                                | Lead | Friday 13th January 2023                                                                                                         | week 1   | |
| 1.27.0-alpha.1 released                                       | Branch Manager | Tuesday 24th January 2023                                                                                           | Week 3   | |
| Start Release Notes Draft                                     | Release Notes Lead | Tuesday 24th January 2023                                                                                         | week 3   | |
| Production Readiness Freeze                              | Enhancements Lead | Thursday 2nd February 2023                                                                                         | week 4   | |
| **Begin [Enhancements Freeze]**                               | Enhancements Lead | [01:00 UTC Friday 10th February 2023 / 18:00 PDT Thursday 9th February 2023](https://everytimezone.com/s/cc15bd3a)                                              | week 5   | [master-blocking], [master-informing] |
| 1.27.0-alpha.2 released                                       | Branch Manager | Tuesday 14th February 2023                                                                                               | Week 6   | |
| Begin Friday APAC-friendly meetings                           | Lead | Friday 24th February 2023                                                                                                          | Week 7   | |
| 1.27.0-alpha.3 released                                       | Branch Manager | Thursday 2nd March 2023                                                                                                                                    | week 8   | [1.27-blocking], [master-blocking], [master-informing] |
| **Call for [Exceptions][Exception]**                          | Lead | Monday 6th March 2023                                                                                                          | week 9   | |
| Brace Yourself, Code Freeze is Coming                         | Comms / Bug Triage | Monday 6th March 2023                                                                                            | week 9   | |
| **Begin Feature blog freeze**                                 | Comms Lead | [01:00 UTC Wednesday 8th March 2023 / 18:00 PDT Tuesday 7th March 2023](https://everytimezone.com/s/5b8f4c26)                                                 | week 9   | |
| **Begin [Code Freeze]**                                       | Branch Manager | [01:00 UTC Wednesday 15th March 2023 / 17:00 PDT Tuesday 14th March 2023](https://everytimezone.com/s/c4971746)     | week 10  | |
| 1.27.0-beta.0 released                                        | Branch Manager | Thursday 16th March 2023                                                                                             | week 10  | |
| Docs deadline — Open placeholder PRs                          | Docs Lead | Thursday 16th March  2023                                                                                                  | week 10  | |
| Deprecations and Removals blog published                      | Comms | Thursday 16th March 2023                                                                                                      | week 10  | |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings) | Lead           | Monday 20th March 2023 | Week 11   | |
| **[Test Freeze]**                                             | Branch Manager | [01:00 UTC Wednesday 22nd March 2023 / 17:00 PDT Tuesday 21st March 2023](https://everytimezone.com/s/5d64ada0)  | week 11  | |
| Docs deadline — PRs ready for review                          | Docs Lead | Tuesday 21st March 2023 | Week 11   | |
| 1.27.0-rc.0 released                                          | Branch Manager | Tuesday 21st March 2023                                                                                              | week 11  | |
| release-1.27 branch created                                   | Branch Manager | Tuesday 21st March 2023                                                                                              | week 11  | |
| release-1.27 jobs created                                     | Branch Manager | Tuesday 21st March 2023                                                                                              | week 11  | |
| Major Themes deadline                                     | Comms | Tuesday 21st March 2023                                                                                              | week 11  | |
| Start final draft of Release Notes                            | Release Notes Lead | Tuesday 21st March 2023                                                                                          | week 11  | |
| Release blog ready to review                                  | Comms / Docs | [01:00 UTC Wednesday 22nd March 2023 / 17:00 PDT Tuesday 21st March 2023](https://everytimezone.com/s/5d64ada0)    | week 11  | |
| Burndown Meetings daily (Tuesday & Thursday over Slack)       | Lead               | Monday 27th March 2023  | week 12  | |
| Major Themes complete                                         | Release Notes Lead | Tuesday 4th April 2023 | week 13  | |
| Docs complete — All PRs reviewed and ready to merge           | Docs Lead | Tuesday 4th April 2023                                                                                                   | week 13  | |
| Feature blogs ready to review                                 | Enhancement Owner / SIG Leads | Tuesday 4th April 2023                                                                               | week 13  | |
| 1.27.0-rc.1 released                                          | Branch Manager | Thursday 6th April 2023                                                                                              | week 13  | |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Release Notes Lead | Tuesday 11th April 2023 | week 14  | |
| **v1.27.0 released**                                          | Branch Manager | Tuesday 11th April 2023                                                                                               | week 14  | |
| Release blog published                                        | Comms | Tueday 11th April 2023                                                                                                        | week 14  | |
| **[Thaw]**                                                    | Branch Manager | Tuesday 11th April 2023                                                                                               | week 14  | |
| [KubeCon EU](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/)  | | April 17-21 2023                                                                                                       | week 15   | |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s127-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: https://bit.ly/k8s127-contacts
[Retrospective Document]: https://bit.ly/k8s127-retro

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
[1.27-blocking]: https://testgrid.k8s.io/sig-release-1.27-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
