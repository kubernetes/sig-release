---
title: "Kubernetes v1.35 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes v1.35

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.35/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.35/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s135-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.35 Release Calendar](https://bit.ly/k8s-release-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on
  slack, [release-team](mailto:release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://bit.ly/k8s135-contacts) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s135-enhancements)
* [Feature blog Tracking Board](https://bit.ly/k8s135-feature-blogs)
* [Bug Triage Tracking Board](https://bit.ly/k8s135-bugtriage)
* [CI Signal Project Board & Issue Tracking](https://bit.ly/k8s135-cisignal)
* [Retrospective Document](https://bit.ly/k8s135-retro)
* [kubernetes/kubernetes v1.35 milestone](https://github.com/kubernetes/kubernetes/milestone/67)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The v1.35 release cycle is as follows:

- **Monday 15th September 2025**: Week 1 — Release cycle begins
- **Thursday 9th October 2025**: Week 4 — [Production Readiness Freeze][Production Readiness Freeze]
- **Friday 17th October 2025 at 12:00am anywhere on Earth time (12:00 UTC)**: Week 5 — [Enhancements Freeze][Enhancements Freeze]
-  **Friday 31st October 2025 at 12:00am anywhere on Earth time (12:00 UTC)**: Week 7 — [Feature blog freeze][Feature blog freeze]
- **Friday 7th November 2025 at 12:00am anywhere on Earth time (12:00 UTC)**: Week 8 — [Code Freeze][Code Freeze] and [Test Freeze][Test Freeze]
- **Monday 10th - Thursday 13th November 2025**: Week 9 - [KubeCon NA](https://events.linuxfoundation.org/kubecon-cloudnativecon-north-america/)
- **Tuesday 2nd December 2025**: Week 12 — [Docs Freeze][Docs Freeze]
- **Wednesday 17th December 2025**: Week 14 — Kubernetes v1.35.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                                    | **Week** | **Release Signal**                                                       |
| -------------------------------------------------------------------------------------- | ----------------------------- | --------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------ |
| Start of Release Cycle                                                                 | Lead                          | Monday 15th September 2025                                                  | week 1   | [master-blocking], [master-informing]                                    |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 15th September 2025                                                  | week 1   |                                                                          |
| Schedule finalized                                                                     | Lead                          | Friday 19th September 2025                                                  | week 1   |                                                                          |
| Team finalized                                                                         | Lead                          | Friday 19th September 2025                                                  | week 1   |                                                                          |
| Begin APAC-friendly meetings                                                           | Lead                          | Wednesday 24th September 2025                                               | week 2   |                                                                          |
| Start Release Notes Draft                                                              | Docs Lead                     | Wednesday 1st October 2025                                                  | week 3   |                                                                          |
| v1.35.0-alpha.1 released                                                               | Branch Manager                | Wednesday 8th October 2025                                                  | week 4   |                                                                          |
| **Begin [Production Readiness Freeze]**                                                | Enhancements Lead             | Thursday 9th October 2025                                                   | week 4   |                                                                          |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | Friday 17th October 2025 at 12:00am anywhere on Earth time (12:00 UTC)     | week 5   |                                                                          |
| v1.35.0-alpha.2 released                                                               | Branch Manager                | Wednesday 22nd October 2025                                                 | week 6   |                                                                          |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Release Signal        | Monday 27th October 2025                                                    | week 7   |                                                                          |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 30th October 2025                                                  | week 7   |                                                                          |
| **Begin [Feature blog freeze] - Open placeholder PRs**                                 | Comms Lead                    | Friday 31st October 2025 at 12:00am anywhere on Earth time (12:00 UTC)     | week 7   |                                                                          |
| Call for [Exceptions][Exception]                                                       | Lead                          | Monday 3rd November 2025                                                    | week 8   |                                                                          |
| v1.35.0-alpha.3 released                                                               | Branch Manager                | Wednesday 5th November 2025                                                 | week 8   |                                                                          |
| **Begin [Code Freeze] and [Test Freeze]**                                              | Branch Manager                | Friday 7th November 2025 at 12:00am anywhere on Earth time (12:00 UTC)     | week 8   |                                                                          |
| **KubeCon NA**                                                                         |                               | Monday 10th - Thursday 13th November 2025                                   | week 9   |                                                                          |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 17th November 2025                                                   | week 10  |                                                                          |
| Deprecations and Removals blog published                                               | Comms                         | Monday 17th November 2025                                                   | week 10  |                                                                          |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 18th November 2025                                                  | week 10  |                                                                          |
| Release Highlights deadline                                                            | Comms                         | Tuesday 18th November 2025                                                  | week 10  |                                                                          |
| v1.35.0-beta.0 released                                                                | Branch Manager                | Wednesday 19th November 2025                                                | week 10  |                                                                          |
| Release blog ready to review                                                           | Comms / Docs                  | Friday 21st November 2025 at 12:00am anywhere on Earth time (12:00 UTC)     | week 10  |                                                                          |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Monday 24th November 2025                                                   | week 11  |                                                                          |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 24th November 2025                                                   | week 11  |                                                                          |
| release-1.35 branch created                                                            | Branch Manager                | Tuesday 2nd December 2025                                                   | week 12  |                                                                          |
| release-1.35 jobs created                                                              | Branch Manager                | Tuesday 2nd December 2025                                                   | week 12  |                                                                          |
| Start final draft of Release Notes                                                     | Docs Lead                     | Tuesday 2nd December 2025                                                   | week 12  |                                                                          |
| **[Docs Freeze]**                                                                      | Docs Lead                     | Tuesday 2nd December 2025                                                   | week 12  |                                                                          |
| v1.35.0-rc.0 released                                                                  | Branch Manager                | Tuesday 2nd December 2025                                                   | week 12  | [1.35-informing], [1.35-blocking], [master-blocking], [master-informing] |
| Release Highlights complete                                                            | Docs Lead                     | Tuesday 9th December 2025                                                   | week 13  |                                                                          |
| v1.35.0-rc.1 released                                                                  | Branch Manager                | Tuesday 9th December 2025                                                   | week 13  |                                                                          |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Docs Lead                     | Wednesday 17th December 2025                                                | week 14  |                                                                          |
| **v1.35.0 released**                                                                   | Branch Manager                | Wednesday 17th December 2025                                                | week 14  |                                                                          |
| Release blog published                                                                 | Comms                         | Wednesday 17th December 2025                                                | week 14  |                                                                          |
| [Thaw]                                                                                 | Comms                         | Thursday 18th December 2025                                                 | week 14  |                                                                          |
| Feature blog publication starts                                                        | Comms                         | Thursday 18th December 2025                                                 |          |                                                                          |

## Phases

Please refer to the [release phases document](../release_phases.md).

[Production Readiness Freeze]: ../release_phases.md#prr-freeze

[Enhancements Freeze]: ../release_phases.md#enhancements-freeze

[Burndown]: ../release_phases.md#burndown

[Code Freeze]: ../release_phases.md#code-freeze

[Exception]: ../release_phases.md#exceptions

[Thaw]: ../release_phases.md#thaw

[Test Freeze]: ../release_phases.md#test-freeze

[Docs Freeze]: ../release_phases.md#docs-freeze

[Feature blog freeze]: ../release_phases.md#feature-blog-freeze

[master-blocking]: https://testgrid.k8s.io/sig-release-master-blocking#Summary

[master-informing]: https://testgrid.k8s.io/sig-release-master-informing#Summary

[1.35-blocking]: https://testgrid.k8s.io/sig-release-1.35-blocking#Summary

[1.35-informing]: https://testgrid.k8s.io/sig-release-1.35-informing#Summary

[release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team