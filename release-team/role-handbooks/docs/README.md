# Kubernetes Docs Lead Handbook
- [Overview](#overview)
    - [Common Terms](#common-terms)
- [Docs Lead Responsibilities](#docs-lead-responsibilities)
- [Prerequisites for Docs Lead and Shadows](#prerequisites-for-docs-lead-and-shadows)
    - [General Requirements](#general-requirements)
    - [Time Requirements](#time-requirements)
    - [Prerequisites for Docs Leads](#prerequisites-for-docs-leads)
    - [Prerequisites for Shadows](#prerequisites-for-shadows)
- [Release Timeline](#release-timeline)
- [Doc Authors and Contributors](#doc-authors-and-contributors)

## Overview

This document covers the responsibilities, time commitments, and timeline for Docs Leads shepherding docs releases for Kubernetes. Docs Lead Shadows should also read through this document and understand the launch processes so they can do it in the future.

### Common Terms

| Variable             | Explanation                                 | Example                                                  |
|----------------------|---------------------------------------------|----------------------------------------------------------|
| [current release]    | Active Kubernetes release                   | 1.13                                                     |
| [future release]     | Release that the team is actively composing | 1.14                                                     |
| [integration branch] | A PR [WIP] merging dev branch into main   | [link](https://github.com/kubernetes/website/pull/11401) |
|  ⚠️                   | Stresses extra importance                   |                                                          |

## Docs Lead Responsibilities

The Docs Lead is responsible for working with the Release Team to coordinate documentation updates for the next Kubernetes release.

Responsibilities include:

* Identifying and tracking new Kubernetes features and feature updates that require new content
* Offering guidance to code contributors about where new feature and enhancements documentation should live
* Working with contributors to modify existing docs to accurately represent any upcoming changes
* Providing weekly updates to the Release Team about the current state of release-bound docs
* Introducing and mentoring Docs Lead Shadows to this process and empowering them with the knowledge needed to be future Docs Leads
* Reviewing documentation PRs to ensure quality following the website [Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/)
* Migrating the old website [version] documentation and updating it with the new release
* Communicating changes with all of the localization branches in order to stay synced across repositories
* Updating these instructions with each release

## Prerequisites for Docs Lead and Shadows

### General Requirements

Before continuing on to the Docs specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).

### Time Requirements

A release is usually 12 weeks long. In general, there's a lot of work in the first few weeks of the release cycle to get the process started, and a lot of work in the last few weeks of the release cycle as documentation deadlines approach.

General time requirements for leads and shadows are:

- ½ hour to 2 hours a day, reviewing incoming enhancements, tracking documentation PRs, and monitoring Slack
- Between 1 and 2 hours a week to attend the majority of Release Team (weekly) and Burndown meetings (daily during Code Freeze), subject to time zone appropriateness
- Up to 1 hour weekly to attend [SIG Docs meetings](https://github.com/kubernetes/community/tree/master/sig-docs#meetings) for status reports

> Note: that the time commitment becomes greater closer to the release deadline, peaking during the final release day.

**During the last week of the release, shadows should expect to spend at least 5 hours and leads at least 10 hours finalizing the launch.**

### Prerequisites for Docs Leads

In addition to the time requirements above, a Docs Lead must:

- Have the ability to add a milestone to issues, so must be a member of the [website milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/). Access can be requested by creating a [PR](https://github.com/kubernetes/org/pull/2235) against `kubernetes/org` repo.
> Note: access to see [website milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/) is restricted to Kubernetes GitHub org members
- Have the ability to `/approve` PRs. Access can be requested by creating a [PR](https://github.com/kubernetes/website/pull/20351) against `main` branch.

### Prerequisites for Shadows

Docs Lead Shadows are people who are preparing to be a Docs Lead in the future. In addition to the time requirements above, shadows must:

- Have signed the [contributor CLA](https://github.com/kubernetes/community/blob/master/CLA.md) for Kubernetes.
- Be invested in becoming an org member within the release cycle. This can often be achieved during the release cycle with sponsorship from a role lead. See the [Release Team onboarding guide](/release-team/release-team-onboarding.md) for more details.
- General knowledge of our SIG-Docs [areas of responsibility](https://github.com/kubernetes/community/tree/master/sig-docs#subprojects).
- Experience with the general process involved with [contributing](https://kubernetes.io/docs/contribute/start/) to Kubernetes website.
- Have the ability to add a milestone to issues, so must be a member of the [milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/). Access can be requested by creating a [PR](https://github.com/kubernetes/org/pull/2235) against `kubernetes/org` repo.

## Release Timeline

Reference the [release timeline documentation](Release-Timeline.md) for responsibilities during the release cycle.

## Doc Authors and Contributors

**Authors:** [Jim Angel](https://github.com/jimangel) & [Cody Clark](https://github.com/cody-clark)

Special thanks to contributors to this document, including:
* Andrew Chen
* Anna Jung
* Jared Bhatti
* Jennifer Rondeau
* Misty Linville
* Savitha Raghunathan
* Tim Bannister
* Tim Fogarty
* Zach Arnold
* Zach Corleissen

In addition, this document wouldn't be possible without the wonderful people in [#sig-docs](https://kubernetes.slack.com/messages/sig-docs)!