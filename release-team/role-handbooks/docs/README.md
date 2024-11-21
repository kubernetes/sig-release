# Kubernetes Docs Role Handbook
- [Overview](#overview)
    - [Common Terms](#common-terms)
- [Tasks and Responsibilities](#tasks-and-responsibilities)
- [Prerequisites for Docs Lead and Shadows](#prerequisites-for-docs-lead-and-shadows)
    - [General Requirements](#general-requirements)
    - [Time Requirements](#time-requirements)
    - [Prerequisites for Docs Leads](#prerequisites-for-docs-leads)
    - [Prerequisites for Shadows](#prerequisites-for-shadows)
    - [Machine and GitHub Setup](#machine-and-github-setup)
      - [Set up krel](#set-up-krel)
      - [Fork the kubernetes repositories](#fork-the-kubernetes-repositories)
- [Release Timeline](#release-timeline)
- [Tools](#tools)
- [Debugging Tips](#debugging-tips)
- [Release Notes File Structure](#release-notes-file-structure)
- [TODOs](#todos)

## Overview

This document covers the responsibilities, time commitments, and timeline for Docs Leads shepherding docs releases for Kubernetes, including the generation and fine-tuning of Release Notes. Docs Lead Shadows should also read through this document and understand the launch processes so they can do it in the future.

The Docs Lead will be responsible for introducing shadows to the team and the release notes subcommand in [krel](https://github.com/kubernetes/release/tree/master/docs/krel). Shadows should expect to perform this task at least once themselves. The Docs Lead should indicate pain points and known issues to the shadows (if there are any) and work on strategies for overcoming them to avoid their coalescence during the later weeks.

If there are potential fixes to the issues indicated and team members are keen, fixes and automation of the process is very welcome but not expected.

**Please refer to the Docs [Release Timeline](/release-team/role-handbooks/docs/Release-Timeline.md) for an exhaustive list of the responsibilities of the Docs Team.** 

### Common Terms

| Variable             | Explanation                                 | Example                                                  |
|----------------------|---------------------------------------------|----------------------------------------------------------|
| [current release]    | Active Kubernetes release                   | 1.27                                                     |
| [future release]     | Release that the team is actively composing | 1.28                                                     |
| [integration branch] | A PR [WIP] merging dev branch into main   | [Official 1.27 Release Docs dev branch](https://github.com/kubernetes/website/pull/39124) |                                                    

## Tasks and Responsibilities

The Docs Lead is responsible for working with the Release Team to coordinate documentation updates for the next Kubernetes release, including the generation of Release Notes.

### Responsibilities Overview

* Identifying new Kubernetes features and enhancements ([Kubernetes Enhancement Proposals, also referred to as KEPs](https://www.kubernetes.dev/resources/keps/)) that require new documentation and tracking them using the Enhancements Tracking sheet created for the release (e.g. [Example Enhancements Tracking sheet from the Kubernetes 1.26 Release](https://github.com/orgs/kubernetes/projects/117/views/3))
* Creating a dev branch used by contributors to target documentation updates for the upcoming release
* Generating, reviewing, and fixing Release Notes periodically throughout the release cycle
* Offering guidance to contributors about how to contribute new feature and enhancements documentation and working with contributors to modify existing docs to accurately represent any upcoming changes 
* Providing weekly updates to the Release Team about the current state of release-bound docs
* Mentoring Docs Lead Shadows throughout this process and empowering them with the knowledge needed to be future Docs Leads
* Working with SIG Docs to review documentation PRs according to the website [Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/) to ensure quality 
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

#### Onboarding Session (week 1) ~1 hour

In the first week of the release cycle, the Docs Lead will organize an onboarding session with the shadows to go over general responsibilities and expectations.

#### Early and mid release cycle (weeks 1-8) ~1-5 hours/week

In the first 8 weeks of the cycle, the Docs team must attend weekly release meetings and run the [release-notes subcommand of krel](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md) for every `alpha`, `beta` and `rc` to create an early draft of the release notes. This ensures that the overall quality of the release notes can be verified from the beginning of the release cycle.

Weekly branch syncs must be run to ensure consistency from `main` to `dev-[future-release]`. The Docs team is responsible for the communication of documentation-related deadlines to KEP owners and SIG leads, as well as the tracking of documentation and enforcement of deadlines.

All members of the Docs subteam should participate in PR reviews as time allows.

#### Late release cycle (weeks 9-12+) ~4-10 hours/week

This period has an increase in release team meetings each week and there is also significantly more work to do to ensure the release notes and documentation are in good working order for the release.

The `release-notes` subcommand of `krel` must continue to be run on the release branch (for `beta` and `rc` releases) in order to pull in any outstanding PRs that are merged between the beginning of code freeze and the release.

The Docs Lead will sync with the Comms team as well as SIG Docs and SIG Cluster-lifecycle, as well as begin prepping the website for the release day. On release day, the Docs Lead merges the documentation, publishes the release blog, and updates the website.

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

- Strong written and verbal communications skills
- A working knowledge of Kubernetes concepts
- Project management experience is helpful but not required
- Have signed the [contributor CLA](https://github.com/kubernetes/community/blob/master/CLA.md) for Kubernetes.
- Be invested in becoming an org member within the release cycle. This can often be achieved during the release cycle with sponsorship from a role lead. See the [Release Team onboarding guide](/release-team/release-team-onboarding.md) for more details.
- General knowledge of our SIG Docs [areas of responsibility](https://github.com/kubernetes/community/tree/master/sig-docs#subprojects).
- Experience with the general process involved with [contributing](https://kubernetes.io/docs/contribute/start/) to Kubernetes website.
- Be a [milestone maintainer](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/) in order to have the ability to add a milestone to an issue. Access can be requested by creating a [PR](https://github.com/kubernetes/org/pull/2235) against `kubernetes/org` repo.

### Machine and GitHub Setup

#### Setup krel

[Install Go](https://golang.org/doc/install) in your machine and follow the [instructions to build the release tools](https://github.com/kubernetes/release/tree/master/docs/krel#installation) in your machine. Check the system requirements in the krel documentation.

#### Fork the kubernetes repositories

Fork the following repositories to your GitHub account, and clone them using SSH:

 - [`kubernetes/sig-release`](https://github.com/kubernetes/sig-release): This is where you will push regular PRs to keep the Release Notes draft up to date.
 - [`kubernetes-sigs/release-notes`](https://github.com/kubernetes-sigs/release-notes): This repo has the [release notes website](https://relnotes.k8s.io) sources

## Release Timeline

Reference the Docs [Release Timeline](Release-Timeline.md) for key dates and responsibilities during the release cycle and the Kubernetes Release Information page for the specific release (e.g. [Kubernetes 1.28 Release Information page](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.28/README.md) for information regarding the current release cycle including important dates, Release Team contact information, tracking spreadsheets, and more.

## Tools
- [krel](https://github.com/kubernetes/release/tree/master/docs/krel) The Kubernetes Release Toolbox *(note: always use the latest version of krel to ensure you have the latest fixes/patches)*
- [The krel `release-notes` subcommand](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md)
- [The old release notes tool](https://github.com/kubernetes/release/tree/master/cmd/release-notes)
- [Release notes website](https://relnotes.k8s.io) *(note: release notes website is only required for the final release)*
- [go-modiff](https://github.com/saschagrunert/go-modiff)
- [Hackmd](https://hackmd.io/)
- [LWKD](http://lwkd.info) *(note: consider contributing to LWKD as part of your role)*
- [Kubernetes Documentation Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/)

## Debugging Tips

If you are having trouble running the `krel` tool, here are some common issues and solutions:

1. Try running with `--log-level=debug` or `--log-level=trace` to get more information about what is going wrong.
2. A temp directory gets created at `/var/folders/7t/273pt80d51l70mj4rxznq_lm0000gn/T/<k8s-hash>` when the `krel` tool is called.
If this data is stale, you can try clearing to remove old data with `rm -rf /var/folders/7t/273pt80d51l70mj4rxznq_lm0000gn/T/k8s`

Checkout the documentation for the [krel `release-notes` subcommand](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md).

## Release Notes File Structure

All the release notes for a release are stored under the [releases](https://github.com/kubernetes/sig-release/tree/master/releases) 
directory in the sig-release repo. 

For each release there is a JSON and markdown file that contains the collected release notes across path releases. For example,
the 1.30 release [markdown file](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.30/release-notes/release-notes-draft.md)
contains all the correctly formatted release notes text for the 1.30 release. The [JSON file](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.30/release-notes/release-notes-draft.json)
contains the release notes metadata that is used to generate the markdown file. 

When a Docs team member runs the `krel release-notes` command, a new session is created so that you can pause and resume
the editing process. For example the 1.30 release notes sessions are stored in the [sessions](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.30/release-notes/sessions)
directory in the sig-release repo under `release-1.30`.

If a Docs team member finds a mistake in the release notes, the edit will be saved as a map yaml file in the [maps](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.30/release-notes/maps)
directory. These maps are used to generate the markdown file and JSON file with the correctly edited release note. 

## TODOs

As a Docs shadow, if you are interested in contributing to the improvement of the release notes process, consider the following
areas of improvement:

#### Github Workflow to Detect Common Release Note Issues

- YAML linter to block invalid yaml merging in from manually edited release notes. If suggestions are commited that have 
invalid yaml, the krel tool will not be able to be run on the next release until the error is fixed in a separate pr. 
See [example PR](https://github.com/kubernetes/sig-release/pull/2446) from the 1.30 release that unblocked the `v1.30.0-alpha.3` release.
- Spell check based on dictionary of common Kubernetes terms.
- Check for correct punctuation in release notes.
- Check for incorrect tense in release notes.
- Look into using [Vale.sh](https://vale.sh/) or the [Valve GitHub action](https://github.com/errata-ai/vale) to add editorial checks to the release notes PR

Some initial work has been done in [this GitHub workflow](https://github.com/npolshakova/sig-release/blob/npolshak/workflow/.github/workflows/release-notes-checker.yaml) to introduce checks for common issues in release notes. 
Here is an [example run of the workflow](https://github.com/rudrakshkarpe/sig-release/actions/runs/8073807523/job/22058097731) for the 1.30.0-alpha2 release. This is a good starting point for further improvements.

#### Release Notes tool to automatically process language

If any team members have NLP experience, implement functionality in release-notes tool to automatically process language in generated release notes file

Goals:

- Generate uniform style across release notes (ie. past tense, formatting).
- Decrease copy editing time.

#### Release Notes Machine Learning Classifier

The idea is to build a continuous release notes improvement process to train a machine learning model to classify.
release notes as good or bad. The input for the model should be created continuously during the whole release cycle.
by Release Notes Team of SIG Release. See the [issue](https://github.com/kubernetes/enhancements/issues/1833) for more details.

#### Krel tool improvements 

- Update krel tool to show progress of how many PRs to review are left and other bugs.
