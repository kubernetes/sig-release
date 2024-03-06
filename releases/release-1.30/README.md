---
title: "Kubernetes 1.30 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes 1.30


#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.30/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.30/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s130-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.30 Release Calendar](https://bit.ly/k8s-release-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://docs.google.com/spreadsheets/d/1wiuNeO7eWGR3uTwQwmWby405eULyHgn8zNBRE7pJdjA/edit#gid=0) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s130-enhancements)
* [Feature blog Tracking Board](https://github.com/orgs/kubernetes/projects/161/views/4)
* [Bug Triage Tracking Board](https://bit.ly/k8s130-bug-triage-tracking)
* [CI Signal Project Board & Issue Tracking](https://github.com/orgs/kubernetes/projects/68)
* [Retrospective Document](https://bit.ly/k8s130-retro)
* [kubernetes/sig-release v1.30 milestone](https://github.com/kubernetes/website/milestone/87)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.30 release cycle is as follows:

- **Monday 8th January 2024**: Week 1 — Release cycle begins
- **Thursday 1st February 2024**: Week 4 — [Production Readiness Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **[02:00 UTC Friday 9th February 2024 / 18:00 PDT Thursday 8th February 2024](https://everytimezone.com/s/1ade3dca)**: Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **[02:00 UTC Wednesday 6th March 2024 / 18:00 PDT Tuesday 5th March 2024](https://everytimezone.com/s/24b27b03)**: Week 9 — [Code Freeze](../release_phases.md#code-freeze)
- **Tuesday 19th - Friday 22nd March 2024**: Week 11 - [KubeCon EU](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/)
- **[01:00 UTC Wednesday 20th March 2024 / 18:00 PDT Tuesday 19th March 2024](https://everytimezone.com/s/b708fa7a)**: Week 11 — [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 26th March 2024**: Week 12 — [Docs Freeze](../release_phases.md#docs-freeze)
- **Wednesday 17th April 2024**: Week 15 — Kubernetes v1.30.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                                                                              | **Week** | **CI Signal**                                          |
|----------------------------------------------------------------------------------------|-------------------------------|-----------------------------------------------------------------------------------------------------------------------|----------|--------------------------------------------------------|
| Start of Release Cycle                                                                 | Lead                          | Monday 8th January 2024                                                                                             | week 1   | [master-blocking]                                      |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 8th January 2024                                                                                             | week 1   |                                                        |
| Schedule finalized                                                                     | Lead                          | Friday 12th January 2024                                                                                             | week 1   |                                                        |
| Team finalized                                                                         | Lead                          | Friday 12th January 2024                                                                                             | week 1   |                                                        |
| Start Release Notes Draft                                                              | Release Notes Lead            | Tuesday 23th January 2024                                                                                           | week 3   |                                                        |
| 1.30.0-alpha.1 released                                                                | Branch Manager                | Tuesday 30th January 2024                                                                                            | Week 4   |                                                        |
| Production Readiness Freeze                                                            | Enhancements Lead             | Thursday 01st February 2024                                                                                          | week 4   |                                                        |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | [02:00 UTC Friday 9th February 2024 / 18:00 PDT Thursday 8th February 2024](https://everytimezone.com/s/94c1e78b)       | week 5   | [master-blocking], [master-informing]                  |
| 1.30.0-alpha.2 released                                                                | Branch Manager                | Tuesday 13th February 2024                                                                                                  | Week 6   |                                                        |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 22nd February 2024                                                                                            | week 7   |                                                        |
| Begin Friday APAC-friendly meetings                                                    | Lead                          | Friday 23rd February 2024                                                                                              | Week 7   |                                                        |
| **Call for [Exceptions][Exception]**                                                   | Lead                          | Monday 26th February 2024                                                                                              | week 8   |                                                        |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Release Signal            | Monday 26th February 2024                                                                                              | week 8   |                                                        |
| 1.30.0-alpha.3 released                                                                | Branch Manager                | Tuesday 27th February 2024                                                                                            | Week 8   |                                                        |
| **Begin Feature blog freeze**                                                          | Comms Lead                    | [02:00 UTC Wednesday 27th February 2024 / 18:00 PDT Tuesday 26th February 2024](https://everytimezone.com/s/b23acb87)   | week 8   |                                                        |
| **Begin [Code Freeze]**                                                                | Branch Manager                | [02:00 UTC Wednesday 6th March 2024 / 18:00 PDT Tuesday 5th March 2024](https://everytimezone.com/s/5056bace)   | week 9   |                                                        |
| Deprecations and Removals blog published                                               | Comms                         | Thursday 7th March 2024                                                                                            | week 9   |                                                        |
| **Preparing for Feature blogs review — Initiating outreach**                           | Comms                         | Monday 11th March 2024                                                                                             | week 10  |
| 1.30.0-beta.0 released                                                                 | Branch Manager                | Tuesday 12th March 2024                                                                                           | week 10  |                                                        |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 12th March 2024                                                                                            | Week 10  |                                                        |
| **KubeCon EU**                                                                         |                               | Tuesday 19th - Friday 22nd March 2024                                                                               | week 11  |                                                        |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 18th March 2024                                                                                             | week 11  |                                                        |
| Major Themes deadline                                                                  | Comms                         | Tuesday 19th March 2024                                                                                             | week 11  |                                                        |
| Start final draft of Release Notes                                                     | Release Notes Lead            | Tuesday 19th March 2024                                                                                            | week 11  |                                                        |
| Release blog ready to review                                                           | Comms / Docs                  | [01:00 UTC Wednesday 20th March 2024 / 18:00 PDT Tuesday 19th March 2024](https://everytimezone.com/s/e016958f) | week 11  |                                                        |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Friday 22nd March 2024                                                                                             | week 11  |                                                        |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 25th March 2024                                                                                             | Week 12  |                                                        |
| **[Test Freeze]**                                                                      | Branch Manager                | [01:00 UTC Wednesday 27th March 2024 / 18:00 PDT Tuesday 26th March 2024](https://everytimezone.com/s/e016958f) | week 12  |                                                        |
| release-1.30 branch created                                                            | Branch Manager                | Tuesday 26th March 2024                                                                                            | week 12  |                                                        |
| release-1.30 jobs created                                                              | Branch Manager                | Tuesday 26th March 2024                                                                                            | week 12  |                                                        |
| 1.30.0-rc.0 released                                                                   | Branch Manager                | Tuesday 26th March 2024                                                                                            | week 12  | [1.30-blocking], [master-blocking], [master-informing] |
| **Docs Freeze**                                   | Docs Lead                     | Tuesday 26th March 2024                                                                                            | week 12  |                                                        |
| Major Themes complete                                                                  | Release Notes Lead            | Tuesday 2nd April 2024                                                                                            | week 13  |                                                        |
| 1.30.0-rc.1 released                                                                   | Branch Manager                | Tuesday 2nd April 2024                                                                                            | week 13  |                                                        |
| 1.30.0-rc.2 released                                                                   | Branch Manager                | Thursday 11th April 2024                                                                                            | week 14  | [1.30-blocking], [master-blocking], [master-informing] |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Release Notes Lead            | Wednesday 17th April 2024                                                                                          | week 15  |                                                        |
| **v1.30.0 released**                                                                   | Branch Manager                | Wednesday 17th April 2024                                                                                          | week 15  |                                                        |
| Release blog published                                                                 | Comms                         | Wednesday 17th April 2024                                                                                          | week 15  |                                                        |
| **[Thaw]**                                                                             | Branch Manager                | Wednesday 17th April 2024                                                                                          | week 15  |                                                        |
