---
title: "Kubernetes 1.32 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.32


#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.32/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.32/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s132-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.32 Release Calendar](https://bit.ly/k8s-release-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://bit.ly/k8s132-contacts) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s132-enhancements)
* [Feature blog Tracking Board](FIXME)
* [Bug Triage Tracking Board](https://bit.ly/k8s132-bugtriage)
* [CI Signal Project Board & Issue Tracking](https://bit.ly/k8s133-cisignal)
* [Retrospective Document](https://bit.ly/k8s133-retro)
* [kubernetes/sig-release v1.32 milestone](FIXME)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.32 release cycle is as follows:

- **Monday 9th September 2024**: Week 1 — Release cycle begins
- **Thursday 3rd October 2024**: Week 4 — [Production Readiness Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **02:00 UTC Friday 11th October 2024 / 19:00 PDT Thursday 11th October 2024**: Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **02:00 UTC Wednesday 20th November 2024 / 19:00 PDT Tuesday 19th November 2024**: Week 11 — [Code Freeze](../release_phases.md#code-freeze)
- **02:00 UTC Wednesday 27th November 2024 / 19:00 PDT Tuesday 26th November 2024**: Week 12 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 26th November 2024**: Week 12 — [Docs Freeze](../release_phases.md#docs-freeze)
- **Tuesday 11th December 2024**: Week 14 — Kubernetes v1.32.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                                      | **Week**| **CI Signal**                                          |
|----------------------------------------------------------------------------------------|-------------------------------|-------------------------------------------------------------------------------|---------|--------------------------------------------------------|
| Start of Release Cycle                                                                 | Lead                          | Monday 9th September 2024                                                     | week 1  | [master-blocking]                                      |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 9th September 2024                                                     | week 1  |                                                        |
| Schedule finalized                                                                     | Lead                          | Friday 13th September 2024                                                    | week 1  |                                                        |
| Team finalized                                                                         | Lead                          | Friday 13th September 2024                                                    | week 1  |                                                        |
| Start Release Notes Draft                                                              | Release Notes Lead            | Tuesday 24th September 2024                                                   | week 3  |                                                        |
| 1.32.0-alpha.1 released                                                                | Branch Manager                | Tuesday 1st October 2024                                                      | week 4  |                                                        |
| **Production Readiness Freeze**                                                        | Enhancements Lead             | Thursday 3rd October 2024                                                     | week 4  |                                                        |
| Begin Friday APAC-friendly meetings                                                    | Lead                          | Wednesday 9th October 2024                                                    | week 5  |                                                        |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | 02:00 UTC Friday 11th October 2024 / 19:00 PDT Thursday 10th October 2024     | week 5  | [master-blocking], [master-informing]                  |
| 1.32.0-alpha.2 released                                                                | Branch Manager                | Tuesday 15th October 2024                                                     | week 6  |                                                        |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 24th October 2024                                                    | week 7  |                                                        |
| Call for [Exceptions][Exception]                                                       | Lead                          | Monday 28th October 2024                                                      | week 8  |                                                        |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Release Signal        | Monday 28th October 2024                                                      | week 8  |                                                        |
| 1.32.0-alpha.3 released                                                                | Branch Manager                | Tuesday Monday 29th October 20242024                                          | week 8  |                                                        |
| **Begin Feature blog freeze**                                                          | Comms Lead                    | 02:00 UTC Wednesday 30th October 2024 / 19:00 PDT Tuesday 30th October 2024   | week 8  |                                                        |
| **Preparing for Feature blogs review — Initiating outreach**                           | Comms                         | Monday 11th November 2024                                                     | week 10 |                                                        |
| 1.32.0-beta.0 released                                                                 | Branch Manager                | Tuesday 12th November 2024                                                    | week 10 |                                                        |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 12th November 2024                                                    | week 10 |                                                        |
| Deprecations and Removals blog published                                               | Comms                         | Thursday 14th November 2024                                                   | week 10 |                                                        |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 18th November 2024                                                     | week 11 |                                                        |
| Release Highlights deadline                                                                  | Comms                         | Tuesday 19th November 2024                                                    | week 11 |                                                        |
| Start final draft of Release Notes                                                     | Release Notes Lead            | Tuesday 19th November2024                                                     | week 11 |                                                        |
| **Begin [Code Freeze]**                                                                | Branch Manager                | 02:00 UTC Wednesday 20th November 2024 / 19:00 PDT Tuesday 19th November 2024 | week 11 |                                                        |
| Release blog ready to review                                                           | Comms / Docs                  | 02:00 UTC Wednesday 20th November 2024 / 19:00 PDT Tuesday 19th November 2024 | week 11 |                                                        |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Friday 22nd November 2024                                                     | week 11 |                                                        |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 25th November 2024                                                     | week 12 |                                                        |
| [**Test Freeze**]                                                                      | Branch Manager                | 01:00 UTC Wednesday 27th November 2024 / 19:00 PDT Tuesday 26th November 2024 | week 12 |                                                        |
| release-1.32 branch created                                                            | Branch Manager                | Tuesday 26th November 2024                                                    | week 12 |                                                        |
| release-1.32 jobs created                                                              | Branch Manager                | Tuesday 26th November 2024                                                    | week 12 |                                                        |
| 1.32.0-rc.0 released                                                                   | Branch Manager                | Tuesday 26th November 2024                                                    | week 12 | [1.32-blocking], [master-blocking], [master-informing] |
| **Docs Freeze**                                                                        | Docs Lead                     | Tuesday 26th November 2024                                                    | week 12 |                                                        |
| Release Highlights complete                                                                  | Release Notes Lead            | Tuesday 3rd December 2024                                                     | week 13 |                                                        |
| 1.32.0-rc.1 released                                                                   | Branch Manager                | Tuesday 3rd December 2024                                                     | week 13 |                                                        |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Release Notes Lead            | Wednesday 11th December 2024                                                  | week 14 |                                                        |
| **v1.32.0 released**                                                                   | Branch Manager                | Wednesday 11th December 2024                                                  | week 14 | [1.32-blocking], [master-blocking], [master-informing] |
| Release blog published                                                                 | Comms                         | Wednesday 11th December 2024                                                  | week 14 |                                                        |
| [Thaw]                                                                                 | Branch Manager                | Wednesday 11th December 2024                                                  | week 14 |                                                        |
