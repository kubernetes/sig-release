---
title: "Kubernetes 1.29 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.29

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.29/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.29/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s129-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.29 Release Calendar][k8s129-calendar]
* Contact: [#sig-release] on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info] (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s129-enhancements)
* [Feature blog Tracking Board](https://github.com/orgs/kubernetes/projects/161/views/4)
* [Bug Triage Tracking Board](https://bit.ly/k8s129-bug-triage-tracking)
* [CI Signal Project Board & Issue Tracking](https://github.com/orgs/kubernetes/projects/68)
* [Retrospective Document](https://bit.ly/k8s129-retro)
* [kubernetes/sig-release v1.29 milestone](https://github.com/kubernetes/kubernetes/milestone/62)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.29 release cycle is as follows:

- **Monday 4th September 2023**: Week 1 — Release cycle begins
- **Thursday 28th September 2023**: Week 4 — [Production Readiness Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **[01:00 UTC Friday 6th October 2023 / 18:00 PDT Thursday 5th October 2023](https://everytimezone.com/s/1ade3dca)**: Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **[01:00 UTC Wednesday 1st November 2023 / 18:00 PDT Tuesday 31st October 2023](https://everytimezone.com/s/24b27b03)**: Week 9 — [Code Freeze](../release_phases.md#code-freeze)
- **Monday 6th - Thursday 9th November 2023**: Week 10 - [KubeCon NA](https://events.linuxfoundation.org/kubecon-cloudnativecon-north-america/)
- **[01:00 UTC Wednesday 15th November 2023 / 18:00 PDT Tuesday 14th November 2023](https://everytimezone.com/s/b708fa7a)**: Week 11 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 28th November 2023**: Week 13 — Docs must be completed and reviewed
- **Tuesday 5th December 2023**: Week 14 — Kubernetes v1.29.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                                                                              | **Week** | **CI Signal**                                          |
|----------------------------------------------------------------------------------------|-------------------------------|-----------------------------------------------------------------------------------------------------------------------|----------|--------------------------------------------------------|
| Start of Release Cycle                                                                 | Lead                          | Monday 4th September 2023                                                                                             | week 1   | [master-blocking]                                      |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 4th September 2023                                                                                             | week 1   |                                                        |
| Schedule finalized                                                                     | Lead                          | Friday 8th September 2023                                                                                             | week 1   |                                                        |
| Team finalized                                                                         | Lead                          | Friday 8th September 2023                                                                                             | week 1   |                                                        |
| Start Release Notes Draft                                                              | Release Notes Lead            | Tuesday 19th September 2023                                                                                           | week 3   |                                                        |
| 1.29.0-alpha.1 released                                                                | Branch Manager                | Monday 25th September 2023                                                                                            | Week 4   |                                                        |
| Production Readiness Freeze                                                            | Enhancements Lead             | Thursday 28th September 2023                                                                                          | week 4   |                                                        |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | [01:00 UTC Friday 6th October 2023 / 18:00 PDT Thursday 5th October 2023](https://everytimezone.com/s/1ade3dca)       | week 5   | [master-blocking], [master-informing]                  |
| 1.29.0-alpha.2 released                                                                | Branch Manager                | Tuesday 10th October                                                                                                  | Week 6   |                                                        |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 19th October 2023                                                                                            | week 7   |                                                        |
| Begin Friday APAC-friendly meetings                                                    | Lead                          | Friday 20th October 2023                                                                                              | Week 7   |                                                        |
| **Call for [Exceptions][Exception]**                                                   | Lead                          | Monday 23rd October 2023                                                                                              | week 8   |                                                        |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Bug Triage            | Monday 23rd October 2023                                                                                              | week 8   |                                                        |
| **Begin Feature blog freeze**                                                          | Comms Lead                    | [01:00 UTC Wednesday 25th October 2023 / 18:00 PDT Tuesday 24th October 2023](https://everytimezone.com/s/0fda3279)   | week 8   |                                                        |
| **Begin [Code Freeze]**                                                                | Branch Manager                | [01:00 UTC Wednesday 1st November 2023 / 18:00 PDT Tuesday 31st October 2023](https://everytimezone.com/s/24b27b03)   | week 9   |                                                        |
| 1.29.0-alpha.3 released                                                                | Branch Manager                | Thursday 2nd November 2023                                                                                            | Week 9   | [1.29-blocking], [master-blocking], [master-informing] |
| Deprecations and Removals blog published                                               | Comms                         | Thursday 2nd November 2023                                                                                            | week 9   |                                                        |
| **KubeCon NA**                                                                         |                               | Monday 6th - Thursday 9th November 2023                                                                               | week 10  |                                                        |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 13th November 2023                                                                                             | week 11  |                                                        |
| **[Test Freeze]**                                                                      | Branch Manager                | [01:00 UTC Wednesday 15th November 2023 / 18:00 PDT Tuesday 14th November 2023](https://everytimezone.com/s/b708fa7a) | week 11  |                                                        |
| **Preparing for Feature blogs review — Initiating outreach**                           | Comms                         | Monday 13th November 2023                                                                                             | week 11  |                                                        |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 14th November 2023                                                                                            | Week 11  |                                                        |
| Major Themes deadline                                                                  | Comms                         | Tuesday 14th November2023                                                                                             | week 11  |                                                        |
| Start final draft of Release Notes                                                     | Release Notes Lead            | Tuesday 14th November 2023                                                                                            | week 11  |                                                        |
| Release blog ready to review                                                           | Comms / Docs                  | [01:00 UTC Wednesday 15th November 2023 / 18:00 PDT Tuesday 14th November 2023](https://everytimezone.com/s/b708fa7a) | week 11  |                                                        |
| 1.29.0-beta.0 released                                                                 | Branch Manager                | Thursday 16th November 2023                                                                                           | week 11  |                                                        |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Friday 17th November 2023                                                                                             | week 11  |                                                        |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 20th November 2023                                                                                             | Week 12  |                                                        |
| 1.29.0-rc.0 released                                                                   | Branch Manager                | Tuesday 21st November 2023                                                                                            | week 12  |                                                        |
| release-1.29 branch created                                                            | Branch Manager                | Tuesday 21st November 2023                                                                                            | week 12  |                                                        |
| release-1.29 jobs created                                                              | Branch Manager                | Tuesday 21st November 2023                                                                                            | week 12  |                                                        |
| Major Themes complete                                                                  | Release Notes Lead            | Tuesday 28th November 2023                                                                                            | week 13  |                                                        |
| Docs complete — All PRs reviewed and ready to merge                                    | Docs Lead                     | Tuesday 28th November 2023                                                                                            | week 13  |                                                        |
| 1.29.0-rc.1 released                                                                   | Branch Manager                | Tuesday 28th November 2023                                                                                            | week 13  |                                                        |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Release Notes Lead            | Tuesday 5th December, 2023                                                                                            | week 14  |                                                        |
| **v1.29.0 released**                                                                   | Branch Manager                | Tuesday 5th December 2023                                                                                             | week 14  |                                                        |
| Release blog published                                                                 | Comms                         | Tuesday 5th December 2023                                                                                             | week 14  |                                                        |
| **[Thaw]**                                                                             | Branch Manager                | Tuesday 5th December 2023                                                                                             | week 14  |                                                        |

## Phases

Please refer to the [release phases document](../release_phases.md).

[k8s129-calendar]: https://bit.ly/k8s-release-cal
[Internal Contact Info]: https://bit.ly/k8s129-contacts
[Retrospective Document]: https://bit.ly/k8s129-retro

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
[1.29-blocking]: https://testgrid.k8s.io/sig-release-1.29-blocking#Summary

[exception requests]: ../EXCEPTIONS.md
[release phases document]: ../release_phases.md
