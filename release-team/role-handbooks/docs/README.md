# Kubernetes Docs Role Handbook
- [Overview](#overview)
    - [Common Terms](#common-terms)
- [Docs Lead Responsibilities](#docs-lead-responsibilities)
- [Prerequisites for Docs Lead and Shadows](#prerequisites-for-docs-lead-and-shadows)
    - [General Requirements](#general-requirements)
    - [Time Requirements](#time-requirements)
    - [Prerequisites for Docs Leads](#prerequisites-for-docs-leads)
    - [Prerequisites for Shadows](#prerequisites-for-shadows)
- [Release Timeline](#release-timeline)

## Overview

This document covers the responsibilities, time commitments, and timeline for Docs Leads shepherding docs releases for Kubernetes. Docs Lead Shadows should also read through this document and understand the launch processes so they can do it in the future.

**Please refer to the Docs [Release Timeline](/release-team/role-handbooks/docs/Release-Timeline.md) for an exhaustive list of the responsibilities of the Docs Lead.** 

### Common Terms

| Variable             | Explanation                                 | Example                                                  |
|----------------------|---------------------------------------------|----------------------------------------------------------|
| [current release]    | Active Kubernetes release                   | 1.27                                                     |
| [future release]     | Release that the team is actively composing | 1.28                                                     |
| [integration branch] | A PR [WIP] merging dev branch into main   | [Official 1.27 Release Docs dev branch](https://github.com/kubernetes/website/pull/39124) |                                                    

## Docs Lead Responsibilities

The Docs Lead is responsible for working with the Release Team to coordinate documentation updates for the next Kubernetes release. 

Responsibilities include:

* Identifying new Kubernetes features and enhancements ([Kubernetes Enhancement Proposals, also referred to as KEPs](https://www.kubernetes.dev/resources/keps/)) that require new documentation and tracking them using the Enhancements Tracking sheet created for the release (e.g. [Example Enhancements Tracking sheet from the Kubernetes 1.26 Release](https://github.com/orgs/kubernetes/projects/117/views/3))
* Creating a dev branch used by contributors to target documentation updates for the upcoming release
* Offering guidance to contributors about how to contribute new feature and enhancements documentation and working with contributors to modify existing docs to accurately represent any upcoming changes 
* Providing weekly updates to the Release Team about the current state of release-bound docs
* Mentoring Docs Lead Shadows throughout this process and empowering them with the knowledge needed to be future Docs Leads
* Working with SIG-Docs to review documentation PRs according to the website [Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/) to ensure quality 
* Working with SIG owners to ensure documentation is reviewed for technical accuracy
* Working with Release Comms to review the Release Blog
* Approving reviewed documentation to ensure its inclusion in the upcoming release
* Migrating the old website [version] documentation and updating it with the new release
* Communicating changes with all of the localization branches in order to stay synced across repositories
* Updating the [Docs Lead and Shadow Handbook](release-team/role-handbooks/docs/README.md) and [Release Team Onboarding Guide](/release-team/release-team-onboarding.md) instructions following each release

## Prerequisites for Docs Lead and Shadows

### General Requirements

Before continuing on to the Docs specific requirements listed below, please review the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).

### Time Requirements

Releases are usually 15 weeks long. In general, there is less work in the first few weeks of the release cycle, more work in the middle as KEP owners need to be reminded to contribute documentation updates, and a lot of work in the last few weeks of the release cycle as documentation must be reviewed and approved prior to release day. The largest time commitment for the Docs Lead is the release day itself, because on that day the Docs Lead must follow the process to merge all documentation updates and unfreeze the website. 

General time requirements for leads and shadows are:

- ½ hour to 2 hours a day, reviewing incoming enhancements, tracking documentation PRs, and monitoring Slack
- Between 1 and 2 hours a week to attend the majority of Release Team (weekly) and Burndown meetings (daily during Code Freeze), subject to time zone appropriateness
- Up to 1 hour weekly to attend [SIG Docs meetings](https://github.com/kubernetes/community/tree/master/sig-docs#meetings) for status reports

**During the last weeks of the release, shadows should expect to spend at least 5 hours and leads at least 10 hours finalizing the launch.**

### Prerequisites for Docs Leads

In addition to the time requirements above, a Docs Lead must:

- Familiarity with Github
- Have the ability to add a milestone to issues, so must be a member of the [website milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/). Access can be requested by creating a [PR](https://github.com/kubernetes/org/pull/2235) against `kubernetes/org` repo.
> Note: access to see [website milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/) is restricted to Kubernetes GitHub org members
- Have the ability to `/approve` PRs. Access can be requested by creating a [PR](https://github.com/kubernetes/website/pull/20351) against `main` branch.
- Take the [Inclusive Speaker Orientation (LFC101)](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/) training course

### Prerequisites for Shadows

Docs Lead Shadows are people who are preparing to be a Docs Lead in the future. In addition to the time requirements above, shadows must:

- Have signed the [contributor CLA](https://github.com/kubernetes/community/blob/master/CLA.md) for Kubernetes.
- Be invested in becoming an org member within the release cycle. This can often be achieved during the release cycle with sponsorship from a role lead. See the [Release Team onboarding guide](/release-team/release-team-onboarding.md) for more details.
- General knowledge of our SIG-Docs [areas of responsibility](https://github.com/kubernetes/community/tree/master/sig-docs#subprojects).
- Experience with the general process involved with [contributing](https://kubernetes.io/docs/contribute/start/) to Kubernetes website.
- Be a [milestone maintainer](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/) in order to have the ability to add a milestone to an issue. Access can be requested by creating a [PR](https://github.com/kubernetes/org/pull/2235) against `kubernetes/org` repo.

## Release Timeline

Reference the Docs [Release Timeline](Release-Timeline.md) for key dates and responsibilities during the release cycle and the Kubernetes Release Information page for the specific release (e.g. [Kubernetes 1.28 Release Information page](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.28/README.md) for information regarding the current release cycle including important dates, Release Team contact information, tracking spreadsheets, and more.
