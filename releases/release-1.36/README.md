---
title: "Kubernetes v1.36 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes v1.36

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.36/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.36/release-team.md)
* [Meeting Minutes](https://rel.k8s.io/v136/releasemtg) (members of [release-team@] receive meeting invites)
* [v1.36 Release Calendar](https://rel.k8s.io/release-team-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on
  slack, [release-team](mailto:release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://rel.k8s.io/v136/contacts) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://rel.k8s.io/v136/enhancements)
* [Feature blog Tracking Board](https://rel.k8s.io/v136/feature-blogs)
* [Bug Triage Tracking Board](https://rel.k8s.io/v136/bugtriage)
* [CI Signal Project Board & Issue Tracking](https://rel.k8s.io/v136/cisignal)
* [Retrospective Document](https://rel.k8s.io/v136/retro)
* [kubernetes/kubernetes v1.36 milestone](https://github.com/kubernetes/kubernetes/milestone/69)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The v1.36 release cycle is as follows:

- **Monday 12th January 2026**: Week 1 — Release cycle begins
- **Wednesday 4th February 2026 (AoE) / Thursday 5th February 2026, 12:00 UTC**: Week 4 — [Production Readiness Freeze][Production Readiness Freeze]
- **Wednesday 11th February 2026 (AoE) / Thursday 12th February 2026, 12:00 UTC**: Week 5 — [Enhancements Freeze][Enhancements Freeze]
- **Thursday 26th February 2026 (AoE) / Friday 27th February 2026, 12:00 UTC**: Week 7 — [Feature blog freeze][Feature blog freeze]
- **Wednesday 18th March 2026 (AoE) / Thursday 19th March 2026, 12:00 UTC**: Week 10 — [Code Freeze][Code Freeze] and [Test Freeze][Test Freeze]
- **Monday 23rd - Thursday 26th March 2026**: Week 11 - [KubeCon EU](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/)
- **Wednesday 8th April 2026 (AoE) / Thursday 9th April 2026, 12:00 UTC**: Week 13 — [Docs Freeze][Docs Freeze]
- **Wednesday 22nd April 2026**: Week 15 — Kubernetes v1.36.0 released

#### Note on AoE deadlines:
Deadlines are expressed in “Anywhere on Earth” (AoE) time. This means the date ends when the calendar day finishes in the last timezone on Earth (UTC−12).
Example: A deadline of Thursday, Oct 16 (AoE) gives contributors their full Thursday everywhere in the world. The cutoff therefore would be Friday, Oct 17 at 12:00 UTC.

## Timeline

| **What**                                           | **Who**                       | **When**                                                                    | **Week** | **Release Signal**                                                       |
|----------------------------------------------------|-------------------------------|-----------------------------------------------------------------------------|----------|--------------------------------------------------------------------------|
| Start of Release Cycle                             | Lead                          | Monday 12th January 2026                                                    | week 1   | [master-blocking], [master-informing]                                    |
| Start Enhancements Tracking                        | Enhancements Lead             | Monday 12th January 2026                                                    | week 1   |                                                                          |
| Schedule finalized                                 | Lead                          | Friday 16th January 2026                                                    | week 1   |                                                                          |
| Team finalized                                     | Lead                          | Friday 16th January 2026                                                    | week 1   |                                                                          |
| Begin APAC-friendly meetings                       | ALL                           | Wednesday 21st January 2026                                                 | week 2   |                                                                          |
| Start Release Notes Draft                          | Docs Lead                     | Wednesday 28th January 2026                                                 | week 3   |                                                                          |
| Call for PRR and Enhancement Freeze [Exceptions]   | Lead                          | Thursday 29th January 2026                                                  | week 3   |                                                                          |
| v1.36.0-alpha.1 released                           | Branch Manager                | Wednesday 4th February 2026                                                 | week 4   |                                                                          |
| **Begin [Production Readiness Freeze]**            | Enhancements Lead             | Wednesday 4th February 2026 (AoE) / Thursday 5th February 2026, 12:00 UTC   | week 4   |                                                                          |
| **Begin [Enhancements Freeze]**                    | Enhancements Lead             | Wednesday 11th February 2026 (AoE) / Thursday 12th February 2026, 12:00 UTC | week 5   |                                                                          |
| v1.36.0-alpha.2 released                           | Branch Manager                | Wednesday 18th February 2026                                                | week 6   |                                                                          |
| Brace Yourself, Code Freeze is Coming              | Comms / Release Signal        | Monday 23rd February 2026                                                   | week 7   |                                                                          |
| Docs deadline — Open placeholder PRs               | Docs Lead                     | Thursday 26th February 2026 (AoE) / Friday 27th February 2026, 12:00 UTC    | week 7   |                                                                          |
| v1.36.0-alpha.3 released                           | Branch Manager                | Wednesday 4th March 2026                                                    | week 8   |                                                                          |
| Begin [Feature blog freeze] - Open placeholder PRs | Comms Lead                    | Thursday 5th March 2026 (AoE) / Friday 6th March 2026, 12:00 UTC            | week 8   |                                                                          |
| Call for Code Freeze [Exceptions]                  | Lead                          | Monday 9th March 2026                                                       | week 9   |                                                                          |
| v1.36.0-beta.0 released                            | Branch Manager                | Wednesday 11th March 2026                                                   | week 9   |                                                                          |
| **Begin [Code Freeze] and [Test Freeze]**          | Branch Manager                | Wednesday 18th March 2026 (AoE) / Thursday 19th March 2026, 12:00 UTC       | week 10  |                                                                          |
| **KubeCon EU**                                     |                               | Monday 23rd - Thursday 26th March 2026                                      | week 11  |                                                                          |
| **Begin [Burndown]** (Meetings on Mon / Wed / Fri) | ALL                           | Monday 30th March 2026                                                      | week 12  |                                                                          |
| Deprecations and Removals blog published           | Comms Lead                    | Monday 30th March 2026                                                      | week 12  |                                                                          |
| Docs deadline — PRs ready for review               | Docs Lead                     | Tuesday 31st March 2026                                                     | week 12  |                                                                          |
| Release Highlights deadline                        | Comms Lead                    | Tuesday 31st March 2026                                                     | week 12  |                                                                          |
| Feature blogs ready to review                      | Enhancement Owner / SIG Leads | Monday 6th April 2026                                                       | week 13  |                                                                          |
| **Burndown Meetings daily (Tue & Thu over Slack)** | ALL                           | Monday 6th April 2026                                                       | week 13  |                                                                          |
| release-1.36 branch created                        | Branch Manager                | Wednesday 8th April 2026                                                    | week 13  |                                                                          |
| release-1.36 jobs created                          | Branch Manager                | Wednesday 8th April 2026                                                    | week 13  |                                                                          |
| v1.36.0-rc.0 released                              | Branch Manager                | Wednesday 8th April 2026                                                    | week 13  | [1.36-informing], [1.36-blocking], [master-blocking], [master-informing] |
| Start final draft of Release Notes                 | Docs Lead                     | Wednesday 8th April 2026                                                    | week 13  |                                                                          |
| **[Docs Freeze]**                                  | Docs Lead                     | Wednesday 8th April 2026 (AoE) / Thursday 9th April 2026, 12:00 UTC         | week 13  |                                                                          |
| Release blog ready to review                       | Comms / Docs                  | Thursday 9th April 2026 (AoE) / Friday 10th April 2026, 12:00 UTC           | week 13  |                                                                          |
| v1.36.0-rc.1 released                              | Branch Manager                | Tuesday 14th April 2026                                                     | week 14  |                                                                          |
| Release Notes complete                             | Docs Lead                     | Wednesday 22nd April 2026                                                   | week 15  |                                                                          |
| **v1.36.0 released**                               | Branch Manager                | Wednesday 22nd April 2026                                                   | week 15  |                                                                          |
| Release blog published                             | Comms Lead                    | Wednesday 22nd April 2026                                                   | week 15  |                                                                          |
| [Thaw]                                             | Branch Manager                | Wednesday 22nd April 2026                                                   | week 15  |                                                                          |
| Feature blog publication starts                    | Comms Lead                    | Thursday 23rd April 2026                                                    | week 15  |                                                                          |

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

[1.36-blocking]: https://testgrid.k8s.io/sig-release-1.36-blocking#Summary

[1.36-informing]: https://testgrid.k8s.io/sig-release-1.36-informing#Summary

[release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team

[k/k]: https://code.k8s.io
