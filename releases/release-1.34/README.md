---
title: "Kubernetes v1.34 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes v1.34: Of Wind & Will (O' WaW)

![Kubernetes v1.34: Of Wind & Will (O' WaW)](./logo/k8s134-owaw.png?raw=true)

A release powered by the wind around us — and the will within us.

Every release cycle, we inherit winds that we don't really control — the state of our tooling, documentation, and the historical quirks of our project. Sometimes these winds fill our sails, sometimes they push us sideways or die down.

What keeps Kubernetes moving isn't the perfect winds, but the will of our sailors who adjust the sails, man the helm, chart the courses and keep the ship steady. The release happens not because conditions are always ideal, but because of the people who build it, the people who release it, and the bears ^, cats, dogs, wizards, and curious minds who keep Kubernetes sailing strong — no matter which way the wind blows.

This release, **Of Wind & Will (O' WaW)**, honors the winds that have shaped us, and the will that propels us forward.

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.34/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.34/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s134-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.34 Release Calendar](https://bit.ly/k8s-release-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on
  slack, [release-team](mailto:release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://bit.ly/k8s134-contacts) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s134-enhancements)
* [Feature blog Tracking Board](https://bit.ly/k8s134-feature-blogs)
* [Bug Triage Tracking Board](https://bit.ly/k8s134-bugtriage)
* [CI Signal Project Board & Issue Tracking](https://bit.ly/k8s134-cisignal)
* [Retrospective Document](https://bit.ly/k8s134-retro)
* [kubernetes/kubernetes v1.34 milestone](https://github.com/kubernetes/kubernetes/milestone/67)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The v1.34 release cycle is as follows:

- **Monday 19th May 2025**: Week 1 — Release cycle begins
- **Thursday 12th June 2025**:
  Week 4 — [Production Readiness Freeze][Production Readiness Freeze]
- **[21:00 UTC Friday 20th June 2025 / 14:00 PST Friday 20th June 2025](https://everytimezone.com/s/a17d0bdd)**:
  Week 5 — [Enhancements Freeze][Enhancements Freeze]
- **[02:00 UTC Friday 11th July 2025 / 19:00 PST Thursday 10th July 2025](https://everytimezone.com/s/dcc4aad9)**:
  Week 8 — [Feature blog freeze][Feature blog freeze]
- **[02:00 UTC Friday 25th July 2025 / 19:00 PDT Thursday 24th July 2025](https://everytimezone.com/s/a2c01c54)**:
  Week 10 — [Code Freeze][Code Freeze] and [Test Freeze][Test Freeze]
- **Wednesday 6th August 2025**: Week 12 — [Docs Freeze][Docs Freeze]
- **Wednesday 27th August 2025**: Week 15 — Kubernetes v1.34.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                                                                        | **Week** | **Release Signal**                                                       |
|----------------------------------------------------------------------------------------|-------------------------------|-----------------------------------------------------------------------------------------------------------------|----------|--------------------------------------------------------------------------|
| Start of Release Cycle                                                                 | Lead                          | Monday 19th May 2025                                                                                            | week 1   | [master-blocking], [master-informing]                                    |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 19th May 2025                                                                                            | week 1   |                                                                          |
| Schedule finalized                                                                     | Lead                          | Friday 23rd May 2025                                                                                            | week 1   |                                                                          |
| Team finalized                                                                         | Lead                          | Friday 23rd May 2025                                                                                            | week 1   |                                                                          |
| Begin APAC-friendly meetings                                                           | Lead                          | Wednesday 28th May 2025                                                                                         | week 2   |                                                                          |
| Start Release Notes Draft                                                              | Docs Lead                     | Wednesday 4th June 2025                                                                                         | week 3   |                                                                          |
| v1.34.0-alpha.1 released                                                               | Branch Manager                | Wednesday 11th June 2025                                                                                        | week 4   |                                                                          |
| **Begin [Production Readiness Freeze]**                                                | Enhancements Lead             | Thursday 12th June 2025                                                                                         | week 4   |                                                                          |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | [21:00 UTC Friday 20th June 2025 / 14:00 PST Friday 20th June 2025](https://everytimezone.com/s/a17d0bdd)       | week 5   |                                                                          |
| v1.34.0-alpha.2 released                                                               | Branch Manager                | Wednesday 25th June 2025                                                                                        | week 6   |                                                                          |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 3rd July 2025                                                                                          | week 7   |                                                                          |
| Call for [Exceptions][Exception]                                                       | Lead                          | Monday 7th July 2025                                                                                            | week 8   |                                                                          |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Release Signal        | Monday 7th July 2025                                                                                            | week 8   |                                                                          |
| v1.34.0-alpha.3 released                                                               | Branch Manager                | Wednesday 9th July 2025                                                                                         | week 8   |                                                                          |
| **Begin [Feature blog freeze] - Open placeholder PRs**                                 | Comms Lead                    | [02:00 UTC Friday 11th July 2025 / 19:00 PST Thursday 10th July 2025](https://everytimezone.com/s/dcc4aad9)     | week 8   |                                                                          |
| v1.34.0-beta.0 released                                                                | Branch Manager                | Wednesday 16th July 2025                                                                                        | week 9   |                                                                          |
| **Begin [Code Freeze] and [Test Freeze]**                                              | Branch Manager                | [02:00 UTC Friday 25th July 2025 / 19:00 PDT Thursday 24th July 2025](https://everytimezone.com/s/a2c01c54)     | week 10  |                                                                          |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 28th July 2025                                                                                           | week 11  |                                                                          |
| Deprecations and Removals blog published                                               | Comms                         | Monday 28th July 2025                                                                                           | week 11  |                                                                          |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 29th July 2025                                                                                          | week 11  |                                                                          |
| Release Highlights deadline                                                            | Comms                         | Tuesday 29th July 2025                                                                                          | week 11  |                                                                          |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 4th August 2025                                                                                          | week 12  |                                                                          |
| release-1.34 branch created                                                            | Branch Manager                | Wednesday 6th August 2025                                                                                       | week 12  |                                                                          |
| release-1.34 jobs created                                                              | Branch Manager                | Wednesday 6th August 2025                                                                                       | week 12  |                                                                          |
| Start final draft of Release Notes                                                     | Docs Lead                     | Wednesday 6th August 2025                                                                                       | week 12  |                                                                          |
| **[Docs Freeze]**                                                                      | Docs Lead                     | Wednesday 6th August 2025                                                                                       | week 12  |                                                                          |
| v1.34.0-rc.0 released                                                                  | Branch Manager                | Wednesday 6th August 2025                                                                                       | week 12  | [1.34-informing], [1.34-blocking], [master-blocking], [master-informing] |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Friday 8th August 2025                                                                                          | week 12  |                                                                          |
| v1.34.0-rc.1 released (additional release cut for critical bug fix)                    | Branch Manager                | Saturday 9th August 2025                                                                                        | week 12  |                                                                          |
| Release blog ready to review                                                           | Comms / Docs                  | [02:00 UTC Friday 15th August 2025 / 19:00 PDT Thursday 14th August 2025](https://everytimezone.com/s/815eefb6) | week 13  |                                                                          |
| v1.34.0-rc.2 released                                                                  | Branch Manager                | Wednesday 20th August 2025                                                                                      | week 14  |                                                                          |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Docs Lead                     | Wednesday 27th August 2025                                                                                      | week 15  |                                                                          |
| **v1.34.0 released**                                                                   | Branch Manager                | Wednesday 27th August 2025                                                                                      | week 15  |                                                                          |
| Release blog published                                                                 | Comms                         | Wednesday 27th August 2025                                                                                      | week 15  |                                                                          |
| [Thaw]                                                                                 | Branch Manager                | Wednesday 27th August 2025                                                                                      | week 15  |                                                                          |
| Feature blog publication starts                                                        | Comms                         | Thursday 28th August 2025                                                                                       | week 15  |                                                                          |

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

[1.34-blocking]: https://testgrid.k8s.io/sig-release-1.34-blocking#Summary

[1.34-informing]: https://testgrid.k8s.io/sig-release-1.34-informing#Summary

[release-team@]: https://groups.google.com/a/kubernetes.io/g/release-team
