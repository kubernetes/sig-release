---
title: "Kubernetes 1.33 Release Information"
weight: 98
slug: "release"
aliases: [ "/release" ]
description: |
  Information regarding the current release cycle including important dates,
  Release Team contact information, tracking spreadsheets and more!
---

# Kubernetes v1.33: Octarine (The Color of Magic)

![Kubernetes v1.33: Octarine (The Color of Magine)](./logo/k8s133-octarine.svg)

The theme for Kubernetes v1.33 is Octarine: The Color of Magic, inspired by Terry Pratchett’s Discworld series. 
This release highlights the open-source magic that Kubernetes enables across the ecosystem.

Kubernetes v1.33 is a testament to the enduring power of open-source innovation, where hundreds of contributors from 
around the world work together to create something truly extraordinary. Each release builds upon the other, 
creating something greater than we could achieve alone.

The release logo was made by [Nina Polshakova](https://www.linkedin.com/in/ninapolshakova/) and [Aaron Ray](https://github.com/GoldenZephyr) using [Inkscape](https://inkscape.org/), an open source vector graphics editor.

#### Links

* [This document](https://git.k8s.io/sig-release/releases/release-1.33/README.md)
* [Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.33/release-team.md)
* [Meeting Minutes](https://bit.ly/k8s133-releasemtg) (members of [release-team@] receive meeting invites)
* [v1.33 Release Calendar](https://bit.ly/k8s-release-cal)
* Contact: [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) on slack, [release-team](mailto://release-team@kubernetes.io) on e-mail
* [Internal Contact Info](https://bit.ly/k8s133-contacts) (accessible only to members of [release-team@])

#### Tracking docs

* [Enhancements Tracking Board](https://bit.ly/k8s133-enhancements)
* [Feature blog Tracking Board](https://bit.ly/k8s133-feature-blogs)
* [Bug Triage Tracking Board](https://bit.ly/k8s133-bugtriage)
* [CI Signal Project Board & Issue Tracking](https://bit.ly/k8s133-cisignal)
* [Retrospective Document](https://bit.ly/k8s133-retro)
* [kubernetes/sig-release v1.33 milestone](https://github.com/kubernetes/kubernetes/milestone/66)

#### Guides

* [Targeting Issues and PRs to This Milestone](https://git.k8s.io/community/contributors/devel/sig-release/release.md)
* [Triaging and Escalating Test Failures](https://git.k8s.io/community/contributors/devel/sig-testing/testing.md#troubleshooting-a-failure)

## Summary

The 1.33 release cycle is as follows:

- **Monday 13th January 2025**: Week 1 — Release cycle begins
- **Thursday 6th February 2025**: Week 4 — [Production Readiness Freeze](https://groups.google.com/g/kubernetes-sig-architecture/c/a6_y81N49aQ)
- **[02:00 UTC Friday 14th February 2025 / 19:00 PDT Thursday 13th February 2025](https://everytimezone.com/s/db953795)**: Week 5 — [Enhancements Freeze](../release_phases.md#enhancements-freeze)
- **[02:00 UTC Wednesday 5th March 2025 / 19:00 PDT Tuesday 4th March 2025](https://everytimezone.com/s/7fab9efc)**: Week 8 — [Feature blog freeze](../release_phases.md#feature-blog-freeze)
- **[02:00 UTC Friday 21st March 2025 / 19:00 PDT Thursday 20th March 2025](https://everytimezone.com/s/2c5e9275)**: Week 10 — [Code Freeze](../release_phases.md#code-freeze) and [Test Freeze](../release_phases.md#test-freeze)
- **Tuesday 1st - Friday 4th April 2025**: Week 13 - [KubeCon EU](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/)
- **Tuesday 8th April 2025**: Week 13 — [Docs Freeze](../release_phases.md#docs-freeze)
- **Wednesday 23rd April 2025**: Week 15 — Kubernetes v1.33.0 released

## Timeline

| **What**                                                                               | **Who**                       | **When**                                                                                                            | **Week** | **Release Signal**                                                       |
|----------------------------------------------------------------------------------------|-------------------------------|---------------------------------------------------------------------------------------------------------------------|----------|--------------------------------------------------------------------------|
| Start of Release Cycle                                                                 | Lead                          | Monday 13th January 2025                                                                                            | week 1   | [master-blocking], [master-informing]                                    |
| Start Enhancements Tracking                                                            | Enhancements Lead             | Monday 13th January 2025                                                                                            | week 1   |                                                                          |
| Schedule finalized                                                                     | Lead                          | Friday 17th January 2025                                                                                            | week 1   |                                                                          |
| Team finalized                                                                         | Lead                          | Friday 17th January 2025                                                                                            | week 1   |                                                                          |
| Begin APAC-friendly meetings                                                           | Lead                          | Wednesday 22nd January 2025                                                                                         | week 2   |                                                                          |
| Start Release Notes Draft                                                              | Docs Lead                     | Tuesday 28th January 2025                                                                                           | week 3   |                                                                          |
| 1.33.0-alpha.1 released                                                                | Branch Manager                | Tuesday 4th February 2025                                                                                           | week 4   |                                                                          |
| **Production Readiness Freeze**                                                        | Enhancements Lead             | Thursday 6th February 2025                                                                                          | week 4   |                                                                          |
| **Begin [Enhancements Freeze]**                                                        | Enhancements Lead             | [02:00 UTC Friday 14th February 2025 / 18:00 PST Thursday 13th February 2025](https://everytimezone.com/s/db953795) | week 5   |                                                                          |
| 1.33.0-alpha.2 released                                                                | Branch Manager                | Tuesday 18th February 2025                                                                                          | week 6   |                                                                          |
| Docs deadline — Open placeholder PRs                                                   | Docs Lead                     | Thursday 27th February 2025                                                                                         | week 7   |                                                                          |
| Call for [Exceptions](Exception)                                                       | Lead                          | Monday 3rd March 2025                                                                                               | week 8   |                                                                          |
| Brace Yourself, Code Freeze is Coming                                                  | Comms / Release Signal        | Monday 3rd March 2025                                                                                               | week 8   |                                                                          |
| 1.33.0-alpha.3 released                                                                | Branch Manager                | Tuesday 4th March 2025                                                                                              | week 8   |                                                                          |
| **Begin Feature blog freeze**                                                          | Comms Lead                    | [02:00 UTC Wednesday 5th March 2025 / 18:00 PST Tuesday 4th March 2025](https://everytimezone.com/s/7fab9efc)       | week 8   |                                                                          |
| 1.33.0-beta.0 released                                                                 | Branch Manager                | Tuesday 11th March 2025                                                                                             | week 9   |                                                                          |
| **Begin [Code Freeze] and [Test Freeze]**                                              | Branch Manager                | [02:00 UTC Friday 21st March 2025 / 19:00 PDT Thursday 20th March 2025](https://everytimezone.com/s/2c5e9275)       | week 10  |                                                                          |
| **Begin [Burndown]** (Monday, Wednesday, and Friday meetings)                          | Lead                          | Monday 24th March 2025                                                                                              | week 11  |                                                                          |
| Deprecations and Removals blog published                                               | Comms                         | Monday 24th March 2025                                                                                              | week 11  |                                                                          |
| **Preparing for Feature blogs review — Initiating outreach**                           | Comms                         | Monday 24th March 2025                                                                                              | week 11  |                                                                          |
| Docs deadline — PRs ready for review                                                   | Docs Lead                     | Tuesday 25th March 2025                                                                                             | week 11  |                                                                          |
| Release Highlights deadline                                                            | Comms                         | Tuesday 25th March 2025                                                                                             | week 11  |                                                                          |
| **KubeCon EU**                                                                         |                               | Tuesday 1st - Friday 4th April 2025                                                                                 | week 12  |                                                                          |
| Feature blogs ready to review                                                          | Enhancement Owner / SIG Leads | Monday 7th April 2025                                                                                               | week 13  |                                                                          |
| Burndown Meetings daily (Tuesday & Thursday over Slack)                                | Lead                          | Monday 7th April 2025                                                                                               | week 13  |                                                                          |
| release-1.33 branch created                                                            | Branch Manager                | Tuesday 8th April 2025                                                                                              | week 13  |                                                                          |
| release-1.33 jobs created                                                              | Branch Manager                | Tuesday 8th April 2025                                                                                              | week 13  |                                                                          |
| Start final draft of Release Notes                                                     | Docs Lead                     | Tuesday 8th April 2025                                                                                              | week 13  |                                                                          |
| **Docs Freeze**                                                                        | Docs Lead                     | Tuesday 8th April 2025                                                                                              | week 13  |                                                                          |
| 1.33.0-rc.0 released                                                                   | Branch Manager                | Tuesday 8th April 2025                                                                                              | week 13  | [1.33-informing], [1.33-blocking], [master-blocking], [master-informing] |
| Release blog ready to review                                                           | Comms / Docs                  | [02:00 UTC Friday 11th April 2025 / 19:00 PDT Thursday 10th April 2025](https://everytimezone.com/s/f0425fb0)       | week 13  |                                                                          |
| 1.33.0-rc.1 released                                                                   | Branch Manager                | Tuesday 15th April 2025                                                                                             | week 14  |                                                                          |
| Release Notes complete — reviewed & merged to https://github.com/kubernetes/kubernetes | Docs Lead                     | Wednesday 23rd April 2025                                                                                           | week 15  |                                                                          |
| **v1.33.0 released**                                                                   | Branch Manager                | Wednesday 23rd April 2025                                                                                           | week 15  |                                                                          |
| Release blog published                                                                 | Comms                         | Wednesday 23rd April 2025                                                                                           | week 15  |                                                                          |
| [Thaw]                                                                                 | Branch Manager                | Wednesday 23rd April 2025                                                                                           | week 15  |                                                                          |
