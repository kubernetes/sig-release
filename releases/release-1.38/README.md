---
title: "Kubernetes v1.38 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes v1.38

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.38/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.38/release-team.md)
* [Release Links](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.38/links.md)
* [v1.38 Release Calendar](https://rel.k8s.io/release-team-cal)
* [kubernetes/kubernetes v1.38 milestone](https://github.com/kubernetes/kubernetes/milestone/71)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on
  slack, [release-team](mailto:release-team@kubernetes.io) on e-mail

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The v1.38 release cycle is proposed as follows:

- **Monday 31st August 2026**: Week 1 — Release cycle begins
- **Monday 7th - Wednesday 9th September 2026**: Week 2 — KubeCon China
- **Tuesday 22nd September 2026 (AoE) / Wednesday 23th September 2026, 12:00 UTC**: Week 4 — [KEP Readiness Deadline][KEP Readiness Deadline]
- **Tuesday 29th September 2026 (AoE) / Wednesday 30th September 2026, 12:00 UTC**: Week 5 — [Enhancements Freeze][Enhancements Freeze]
- **Wednesday 4th November 2026 (AoE) / Thursday 5th November 2026, 12:00 UTC**: Week 10 — [Feature blog freeze][Feature blog freeze] 
- **Monday 9th - Thursday 12th November 2026**: Week 11 — KubeCon NA
- **Wednesday 18th November 2026 (AoE) / Thursday 19th November 2026, 12:00 UTC**: Week 12 — [Code Freeze][Code Freeze] and [Test Freeze][Test Freeze]
- **Wednesday 2nd December 2026 (AoE) / Thursday 3rd December 2026, 12:00 UTC**: Week 14 — [Docs Freeze][Docs Freeze]
- **Wednesday 16th December 2026**: Week 16 — Kubernetes v1.38.0 released

> [!NOTE]
> Deadlines are expressed in "Anywhere on Earth" (AoE) time. This means the date ends when the calendar day finishes in the last timezone on Earth (UTC-12).
> Example: A deadline of Thursday, Oct 16 (AoE) gives contributors their full Thursday everywhere in the world. The cutoff therefore would be Friday, Oct 17 at 12:00 UTC.

## Timeline

| **What**                                           | **Who**                       | **When**                                                              | **Week** | **Release Signal**                                                       |
|----------------------------------------------------|-------------------------------|-----------------------------------------------------------------------|----------|--------------------------------------------------------------------------|
| Start of Release Cycle                             | Lead                          | Monday 31st August 2026                                                      | week 1   | [master-blocking], [master-informing]                                    |
| Start Enhancements Tracking                        | Enhancements Lead             | Monday 31st August 2026                                                      | week 1   |                                                                          |
| Schedule finalized                                 | Lead                          | Friday 4th September 2026                                                    | week 1   |                                                                          |
| Team finalized                                     | Lead                          | Friday 4th September 2026                                                    | week 1   |                                                                          |
| Begin APAC-friendly meetings                       | ALL                           | Wednesday 9th September 2026                                                 | week 2   |                                                                          |
| Call for PRR and Enhancement Freeze [Exceptions]   | Lead                          | Thursday 17th September 2026                                                 | week 3   |                                                                          |
| v1.38.0-alpha.1 released                           | Branch Manager                | Wednesday 23rd September 2026                                                | week 4   |                                                                          |
| Start Release Notes Draft                          | Docs Lead                     | Wednesday 23rd September 2026                                                | week 4   |                                                                          |
| **Begin [Production Readiness Freeze]**            | Enhancements Lead             | Tuesday 22nd September 2026 (AoE) / Wednesday 23th September 2026 12:00 UTC  | week 4   |                                                                          |
| **Begin [Enhancements Freeze]**                    | Enhancements Lead             | Tuesday 29th September 2026 (AoE) / Wednesday 30th September 2026 12:00 UTC  | week 5   |                                                                          |
| v1.38.0-alpha.2 released                           | Branch Manager                | Wednesday 7th October 2026                                                   | week 6   |                                                                          |
| v1.38.0-alpha.3 released                           | Branch Manager                | Wednesday 21st October 2026                                                  | week 8   |                                                                          |
| Brace Yourself, Code Freeze is Coming              | Comms / Release Signal        | Monday 26th October 2026                                                     | week 9   |                                                                          |
| Docs deadline — Open placeholder PRs               | Docs Lead                     | Thursday 29th October 2026 (AoE) / Friday 30th October 2026 12:00 UTC        | week 9   |                                                                          |
| v1.38.0-beta.0 released                            | Branch Manager                | Wednesday 4th November 2026                                                  | week 10  |                                                                          |
| Begin [Feature blog freeze] - Open placeholder PRs | Comms Lead                    | Wednesday 4th November 2026 (AoE) / Thursday 5th November 2026 12:00 UTC     | week 10  |                                                                          |
| Call for Code Freeze [Exceptions]                  | Lead                          | Friday 6th November 2026                                                     | week 10  |                                                                          |
| **Begin [Code Freeze] and [Test Freeze]**          | Branch Manager                | Wednesday 18th November 2026 (AoE) / Thursday 19th November 2026 12:00 UTC   | week 12  |                                                                          |
| **Begin [Burndown]** (Meetings on Mon / Wed / Fri) | ALL                           | Monday 23rd November 2026                                                    | week 13  |                                                                          |
| Deprecations and Removals blog published           | Comms Lead                    | Monday 23rd November 2026                                                    | week 13  |                                                                          |
| Docs deadline — PRs ready for review               | Docs Lead                     | Tuesday 24th November 2026                                                   | week 13  |                                                                          |
| Release Highlights deadline                        | Comms Lead                    | Tuesday 24th November 2026                                                   | week 13  |                                                                          |
| Feature blogs ready to review                      | Enhancement Owner / SIG Leads | Monday 30th November 2026                                                    | week 14  |                                                                          |
| **Burndown Meetings daily (Tue & Thu over Slack)** | ALL                           | Monday 30th November 2026                                                    | week 14  |                                                                          |
| release-1.38 branch created                        | Branch Manager                | Wednesday 2nd December 2026                                                  | week 14  |                                                                          |
| release-1.38 jobs created                          | Branch Manager                | Wednesday 2nd December 2026                                                  | week 14  |                                                                          |
| v1.38.0-rc.0 released                              | Branch Manager                | Wednesday 2nd December 2026                                                  | week 14  | [1.38-informing], [1.38-blocking], [master-blocking], [master-informing] |
| Start final draft of Release Notes                 | Docs Lead                     | Wednesday 2nd December 2026                                                  | week 14  |                                                                          |
| **[Docs Freeze]**                                  | Docs Lead                     | Wednesday 2nd December 2026 (AoE) / Thursday 3rd December 2026 12:00 UTC     | week 14  |                                                                          |
| v1.38.0-rc.1 released                              | Branch Manager                | Wednesday 9th December 2026                                                  | week 15  |                                                                          |
| Release blog ready to review                       | Comms / Docs                  | Thursday 10th December 2026 (AoE) / Friday 11th December 2026 12:00 UTC      | week 15  |                                                                          |
| Final Release Notes complete / PR Merged           | Docs Lead                     | Monday 14th December 2026 (AoE) / Tuesday 15th December 2026 12:00 UTC       | week 16  |                                                                          |
| **v1.38.0 released**                               | Branch Manager                | Wednesday 16th December 2026                                                 | week 16  |                                                                          |
| Release blog published                             | Comms Lead                    | Wednesday 16th December 2026                                                 | week 16  |                                                                          |
| [Thaw]                                             | Branch Manager                | Wednesday 16th December 2026                                                 | week 16  |                                                                          |
| Feature blog publication starts                    | Comms Lead                    | Thursday 17th December 2026                                                  | week 16  |                                                                          |

## Phases

Please refer to the [release phases document](../release_phases.md).

[Production Readiness Freeze]: ../release_phases.md#prr-freeze

[Enhancements Freeze]: ../release_phases.md#enhancements-freeze

[Burndown]: ../release_phases.md#burndown

[Code Freeze]: ../release_phases.md#code-freeze

[Exceptions]: ../release_phases.md#exceptions

[Thaw]: ../release_phases.md#thaw

[Test Freeze]: ../release_phases.md#test-freeze

[Docs Freeze]: ../release_phases.md#docs-freeze

[Feature blog freeze]: ../release_phases.md#feature-blog-freeze

[master-blocking]: https://testgrid.k8s.io/sig-release-master-blocking#Summary

[master-informing]: https://testgrid.k8s.io/sig-release-master-informing#Summary

[1.38-blocking]: https://testgrid.k8s.io/sig-release-1.38-blocking#Summary

[1.38-informing]: https://testgrid.k8s.io/sig-release-1.38-informing#Summary

[release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team

[k/k]: https://code.k8s.io