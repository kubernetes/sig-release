---
title: "Kubernetes 1.31 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.31


#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.31/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.31/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s131-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.31 Release Calendar](https://bit.ly/k8s-release-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://bit.ly/k8s131-contacts) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s131-enhancements)
* [Feature blog Tracking Board](https://github.com/orgs/kubernetes/projects/183/views/6) 
* [Bug Triage Tracking Board](https://bit.ly/k8s131-bugtriage)
* [CI Signal Project Board & Issue Tracking](https://bit.ly/k8s131-cisignal)
* [Retrospective Document](https://bit.ly/k8s131-retro)
* [kubernetes/sig-release v1.31 milestone](https://github.com/kubernetes/kubernetes/milestone/64)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.31 release cycle is as follows:

- **Monday 13th May 2024**: Week 1 — Release cycle begins
- **Thursday 6th June 2024**: Week 4 — [Production Readiness Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **02:00 UTC Friday 14th June 2024 / 19:00 PDT Thursday 13th June 2024**: Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **02:00 UTC Wednesday 10th July 2024 / 19:00 PDT Tuesday 9th July 2024**: Week 9 — [Code Freeze](../release_phases.md#code-freeze)
- **01:00 UTC Wednesday 31st July 2024 / 19:00 PDT Tuesday 30th July 2024**: Week 12 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 30th July 2024**: Week 12 — [Docs Freeze](../release_phases.md#docs-freeze)
- **Tuesday 13th August 2024**: Week 14 — Kubernetes v1.31.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                              | **Week** | **CI Signal**                                          |
| -------------------------------------------------------------------------------------- | ----------------------------- | --------------------------------------------------------------------- | -------- | ------------------------------------------------------ |
| Start of Release Cycle                                                                 | Lead                          | Monday 13th May 2024                                                  | week 1   | [master-blocking]                                      |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 13th May 2024                                                  | week 1   |                                                        |
| Schedule finalized                                                                     | Lead                          | Friday 17th May 2024                                                  | week 1   |                                                        |
| Team finalized                                                                         | Lead                          | Friday 17th May 2024                                                  | week 1   |                                                        |
| Start Release Notes Draft                                                              | Release Notes Lead            | Tuesday 28th May 2024                                                 | week 3   |                                                        |
| 1.31.0-alpha.1 released                                                                | Branch Manager                | Tuesday 4th June 2024                                                 | week 4   |                                                        |
| Production Readiness Freeze                                                            | Enhancements Lead             | Thursday 6th June 2024                                                | week 4   |                                                        |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | 02:00 UTC Friday 14th June 2024 / 19:00 PDT Thursday 13th June 2024   | week 5   | [master-blocking], [master-informing]                  |
| 1.31.0-alpha.2 released                                                                | Branch Manager                | Tuesday 18th June 2024                                                | week 6   |                                                        |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 27th June 2024                                               | week 7   |                                                        |
| Begin Friday APAC-friendly meetings                                                    | Lead                          | Friday 28th June 2024                                                 | week 7   |                                                        |
| **Call for [Exceptions][Exception]**                                                   | Lead                          | Monday 1st July 2024                                                  | week 8   |                                                        |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Release Signal        | Monday 1st July 2024                                                  | week 8   |                                                        |
| 1.31.0-alpha.3 released                                                                | Branch Manager                | Tuesday 2nd July 2024                                                 | week 8   |                                                        |
| **Begin Feature blog freeze**                                                          | Comms Lead                    | 02:00 UTC Wednesday 3rd July 2024 / 19:00 PDT Tuesday 2nd July 2024   | week 8   |                                                        |
| **Begin [Code Freeze]**                                                                | Branch Manager                | 02:00 UTC Wednesday 10th July 2024 / 19:00 PDT Tuesday 9th July 2024  | week 9   |                                                        |
| Deprecations and Removals blog published                                               | Comms                         | Thursday 11th July 2024                                               | week 9   |                                                        |
| **Preparing for Feature blogs review — Initiating outreach**                           | Comms                         | Monday 15th July 2024                                                 | week 10  |                                                        |
| 1.31.0-beta.0 released                                                                 | Branch Manager                | Tuesday 16th July 2024                                                | week 10  |                                                        |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 16th July 2024                                                | week 10  |                                                        |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 22nd July 2024                                                 | week 11  |                                                        |
| Major Themes deadline                                                                  | Comms                         | Tuesday 23rd July 2024                                                | week 11  |                                                        |
| Start final draft of Release Notes                                                     | Release Notes Lead            | Tuesday 23rd July 2024                                                | week 11  |                                                        |
| Release blog ready to review                                                           | Comms / Docs                  | 02:00 UTC Wednesday 24th July 2024 / 19:00 PDT Tuesday 23rd July 2024 | week 11  |                                                        |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Friday 26th July 2024                                                 | week 11  |                                                        |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 29th July 2024                                                 | week 12  |                                                        |
| **[Test Freeze]**                                                                      | Branch Manager                | 01:00 UTC Wednesday 31st July 2024 / 19:00 PDT Tuesday 30th July 2024 | week 12  |                                                        |
| release-1.31 branch created                                                            | Branch Manager                | Tuesday 30th July 2024                                                | week 12  |                                                        |
| release-1.31 jobs created                                                              | Branch Manager                | Tuesday 30th July 2024                                                | week 12  |                                                        |
| 1.31.0-rc.0 released                                                                   | Branch Manager                | Tuesday 30th July 2024                                                | week 12  | [1.31-blocking], [master-blocking], [master-informing] |
| **Docs Freeze**                                                                        | Docs Lead                     | Tuesday 30th July 2024                                                | week 12  |                                                        |
| Major Themes complete                                                                  | Release Notes Lead            | Tuesday 6th August 2024                                               | week 13  |                                                        |
| 1.31.0-rc.1 released                                                                   | Branch Manager                | Tuesday 6th August 2024                                               | week 13  |                                                        |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Release Notes Lead            | Tuesday 13th August 2024                                              | week 14  |                                                        |
| **v1.31.0 released**                                                                   | Branch Manager                | Tuesday 13th August 2024                                              | week 14  | [1.31-blocking], [master-blocking], [master-informing] |
| Release blog published                                                                 | Comms                         | Tuesday 13th August 2024                                              | week 14  |                                                        |
| **[Thaw]**                                                                             | Branch Manager                | Tuesday 13th August 2024                                              | week 14  |                                                        |
