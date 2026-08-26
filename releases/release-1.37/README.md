---
title: "Kubernetes v1.37 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes v1.37: Garhwal

![Kubernetes v1.37: Garhwal](./logo/k8s-v1.37.svg)

Kubernetes v1.37 is named **Garhwal** (गढ़वाल, pronounced _gaṛhvāl_), after the Himalayan region of Uttarakhand, India.
Inspired by its snow-capped peaks, deodar forests, terraced fields, rivers, and mountain paths,
the theme celebrates a community in which every layer, route, and contribution is connected.

Imagined as a window into Garhwal, the logo shows terraced fields rising towards snowy peaks
and a river gathering mountain streams.
Together, they represent contributions from many SIGs and communities flowing into one project,
while the deodar forest reflects an ecosystem where distinct projects share common ground and grow side by side.

A frame inspired by _ringaal_ basketry surrounds the landscape,
showing how individual contributions gain strength when woven together.
Within it, the colourful [Himalayan monal](https://en.wikipedia.org/wiki/Himalayan_monal) represents the community's many skills and perspectives,
while red _buransh_ flowers carry Kubernetes helm symbols at their centres.
A mountain house marked १.३७ (1.37 in Devanagari numerals) grounds the release in Garhwal.

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.37/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.37/release-team.md)
* [Release Links](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.37/links.md)
* [v1.37 Release Calendar](https://rel.k8s.io/release-team-cal)
* [kubernetes/kubernetes v1.37 milestone](https://github.com/kubernetes/kubernetes/milestone/70)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on
  slack, [release-team](mailto:release-team@kubernetes.io) on e-mail

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The v1.37 release cycle is proposed as follows:

- **Monday 18th May 2026**: Week 1 — Release cycle begins
- **Tuesday 9th June 2026 (AoE) / Wednesday 10th June 2026, 12:00 UTC**: Week 4 — [Production Readiness Freeze][Production Readiness Freeze]
- **Tuesday 16th June 2026 (AoE) / Wednesday 17th June 2026, 12:00 UTC**: Week 5 — [Enhancements Freeze][Enhancements Freeze]
- **Thursday 18th - Friday 19th June 2026**: Week 5 — KubeCon India
- **Thursday 9th July 2026 (AoE) / Friday 10th July 2026, 12:00 UTC**: Week 8 — [Feature blog freeze][Feature blog freeze]
- **Wednesday 22nd July 2026 (AoE) / Thursday 23rd July 2026, 12:00 UTC**: Week 10 — [Code Freeze][Code Freeze] and [Test Freeze][Test Freeze]
- **Tuesday 28th - Thursday 30th July 2026**: Week 11 — KubeCon Japan
- **Wednesday 5th August 2026 (AoE) / Thursday 6th August 2026, 12:00 UTC**: Week 12 — [Docs Freeze][Docs Freeze]
- **Wednesday 26th August 2026**: Week 15 — Kubernetes v1.37.0 released

> [!NOTE]
> Deadlines are expressed in "Anywhere on Earth" (AoE) time. This means the date ends when the calendar day finishes in the last timezone on Earth (UTC-12).
> Example: A deadline of Thursday, Oct 16 (AoE) gives contributors their full Thursday everywhere in the world. The cutoff therefore would be Friday, Oct 17 at 12:00 UTC.

## Timeline

| **What**                                           | **Who**                       | **When**                                                              | **Week** | **Release Signal**                                                       |
|----------------------------------------------------|-------------------------------|-----------------------------------------------------------------------|----------|--------------------------------------------------------------------------|
| Start of Release Cycle                             | Lead                          | Monday 18th May 2026                                                  | week 1   | [master-blocking], [master-informing]                                    |
| Start Enhancements Tracking                        | Enhancements Lead             | Monday 18th May 2026                                                  | week 1   |                                                                          |
| Schedule finalized                                 | Lead                          | Friday 22nd May 2026                                                  | week 1   |                                                                          |
| Team finalized                                     | Lead                          | Friday 22nd May 2026                                                  | week 1   |                                                                          |
| Begin APAC-friendly meetings                       | ALL                           | Wednesday 27th May 2026                                               | week 2   |                                                                          |
| Start Release Notes Draft                          | Docs Lead                     | Wednesday 3rd June 2026                                               | week 3   |                                                                          |
| Call for PRR and Enhancement Freeze [Exceptions]   | Lead                          | Thursday 4th June 2026                                                | week 3   |                                                                          |
| v1.37.0-alpha.1 released                           | Branch Manager                | Wednesday 10th June 2026                                              | week 4   |                                                                          |
| **Begin [Production Readiness Freeze]**            | Enhancements Lead             | Tuesday 9th June 2026 (AoE) / Wednesday 10th June 2026, 12:00 UTC    | week 4   |                                                                          |
| **Begin [Enhancements Freeze]**                    | Enhancements Lead             | Tuesday 16th June 2026 (AoE) / Wednesday 17th June 2026, 12:00 UTC   | week 5   |                                                                          |
| **KubeCon India**                                  |                               | Thursday 18th - Friday 19th June 2026                                 | week 5   |                                                                          |
| v1.37.0-alpha.2 released                           | Branch Manager                | Wednesday 24th June 2026                                              | week 6   |                                                                          |
| Brace Yourself, Code Freeze is Coming              | Comms / Release Signal        | Monday 29th June 2026                                                 | week 7   |                                                                          |
| Docs deadline — Open placeholder PRs               | Docs Lead                     | Thursday 2nd July 2026 (AoE) / Friday 3rd July 2026, 12:00 UTC       | week 7   |                                                                          |
| v1.37.0-alpha.3 released                           | Branch Manager                | Wednesday 8th July 2026                                               | week 8   |                                                                          |
| Begin [Feature blog freeze] - Open placeholder PRs | Comms Lead                    | Thursday 9th July 2026 (AoE) / Friday 10th July 2026, 12:00 UTC      | week 8   |                                                                          |
| Call for Code Freeze [Exceptions]                  | Lead                          | Monday 13th July 2026                                                 | week 9   |                                                                          |
| v1.37.0-beta.0 released                            | Branch Manager                | Wednesday 15th July 2026                                              | week 9   |                                                                          |
| **Begin [Code Freeze] and [Test Freeze]**          | Branch Manager                | Wednesday 22nd July 2026 (AoE) / Thursday 23rd July 2026, 12:00 UTC  | week 10  |                                                                          |
| **Begin [Burndown]** (Meetings on Mon / Wed / Fri) | ALL                           | Monday 27th July 2026                                                 | week 11  |                                                                          |
| Deprecations and Removals blog published           | Comms Lead                    | Monday 27th July 2026                                                 | week 11  |                                                                          |
| Docs deadline — PRs ready for review               | Docs Lead                     | Tuesday 28th July 2026                                                | week 11  |                                                                          |
| Release Highlights deadline                        | Comms Lead                    | Tuesday 28th July 2026                                                | week 11  |                                                                          |
| **KubeCon Japan**                                  |                               | Tuesday 28th - Thursday 30th July 2026                              | week 11  |                                                                          |
| Feature blogs ready to review                      | Enhancement Owner / SIG Leads | Monday 3rd August 2026                                                | week 12  |                                                                          |
| **Burndown Meetings daily (Tue & Thu over Slack)** | ALL                           | Monday 3rd August 2026                                                | week 12  |                                                                          |
| release-1.37 branch created                        | Branch Manager                | Wednesday 5th August 2026                                             | week 12  |                                                                          |
| release-1.37 jobs created                          | Branch Manager                | Wednesday 5th August 2026                                             | week 12  |                                                                          |
| v1.37.0-rc.0 released                              | Branch Manager                | Wednesday 5th August 2026                                             | week 12  | [1.37-informing], [1.37-blocking], [master-blocking], [master-informing] |
| Start final draft of Release Notes                 | Docs Lead                     | Wednesday 5th August 2026                                             | week 12  |                                                                          |
| **[Docs Freeze]**                                  | Docs Lead                     | Wednesday 5th August 2026 (AoE) / Thursday 6th August 2026, 12:00 UTC | week 12  |                                                                          |
| Release blog ready to review                       | Comms / Docs                  | Thursday 13th August 2026 (AoE) / Friday 14th August 2026, 12:00 UTC  | week 13  |                                                                          |
| v1.37.0-rc.1 released                              | Branch Manager                | Wednesday 19th August 2026                                            | week 14  |                                                                          |
| Release Notes complete                             | Docs Lead                     | Wednesday 26th August 2026                                            | week 15  |                                                                          |
| **v1.37.0 released**                               | Branch Manager                | Wednesday 26th August 2026                                            | week 15  |                                                                          |
| Release blog published                             | Comms Lead                    | Wednesday 26th August 2026                                            | week 15  |                                                                          |
| [Thaw]                                             | Branch Manager                | Wednesday 26th August 2026                                            | week 15  |                                                                          |
| Feature blog publication starts                    | Comms Lead                    | Thursday 27th August 2026                                             | week 15  |                                                                          |

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

[1.37-blocking]: https://testgrid.k8s.io/sig-release-1.37-blocking#Summary

[1.37-informing]: https://testgrid.k8s.io/sig-release-1.37-informing#Summary

[release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team

[k/k]: https://code.k8s.io
