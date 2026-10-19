# Kubernetes Docs Role Handbook

- [Overview](#overview)
  - [Common terms](#common-terms)
- [Tasks and responsibilities](#tasks-and-responsibilities)
  - [Responsibilities overview](#responsibilities-overview)
- [Prerequisites for the Docs Lead and shadows](#prerequisites-for-the-docs-lead-and-shadows)
  - [General requirements](#general-requirements)
  - [Time requirements](#time-requirements)
  - [Prerequisites for Docs Leads](#prerequisites-for-docs-leads)
  - [Prerequisites for shadows](#prerequisites-for-shadows)
  - [Machine and GitHub setup](#machine-and-github-setup)
    - [Set up krel](#set-up-krel)
    - [Fork the Kubernetes repositories](#fork-the-kubernetes-repositories)
- [Release timeline](#release-timeline)
- [Tools](#tools)
- [Debugging tips](#debugging-tips)
- [Release notes file structure](#release-notes-file-structure)
- [Improvement ideas](#improvement-ideas)

## Overview

This document covers the responsibilities, time commitments and timeline for
Docs Leads shepherding docs releases for Kubernetes, including the generation
and fine-tuning of the release notes. Docs shadows should also read through
this document and understand the launch process so they can do it in the
future.

The Docs Lead introduces the shadows to the team and to the `release-notes`
subcommand of [krel](https://github.com/kubernetes/release/tree/master/docs/krel).
Shadows should expect to perform this task at least once themselves. The Docs
Lead should point out pain points and known issues to the shadows and work
on strategies for overcoming them, to avoid them piling up in the later
weeks.

If there are potential fixes to the issues and team members are keen, fixes
and automation of the process are encouraged but not required.

**The [release timeline](release-timeline.md) has the exhaustive list of
Docs team responsibilities, grouped by release milestone.**

### Common terms

| Term | Explanation | Example (v1.38 cycle) |
|------|-------------|-----------------------|
| `<current release>` | The active Kubernetes release | 1.37 |
| `<future release>` | The release the team is actively composing | 1.38 |
| `<next release>` | The release after the future release | 1.39 |
| Integration branch | The PR that merges `dev-<future release>` into `main` on release day | [v1.21 integration branch](https://github.com/kubernetes/website/pull/26153) |
| Release Tracking Board | The GitHub project the Enhancements team sets up for the cycle | [v1.38 links](/releases/release-1.38/links.md#releasetracking) |

## Tasks and responsibilities

The Docs Lead works with the Release Team to coordinate documentation updates
for the next Kubernetes release, including the generation of the release
notes.

### Responsibilities overview

- Identify new Kubernetes features and enhancements
  ([Kubernetes Enhancement Proposals, KEPs](https://www.kubernetes.dev/resources/keps/))
  that require documentation, and track them in the Release Tracking Board
  for the release cycle (linked from `releases/release-<future release>/links.md`).
- Create the dev branch that contributors target with documentation updates
  for the upcoming release.
- Generate, review and fix the release notes periodically throughout the
  release cycle.
- Guide contributors on how to document new features and enhancements, and
  work with them to update existing docs so that they accurately represent
  upcoming changes.
- Provide weekly updates to the Release Team about the state of
  release-bound docs.
- Mentor the Docs shadows throughout the process and empower them with the
  knowledge needed to be future Docs Leads.
- Work with SIG Docs to review documentation PRs according to the website
  [style guide](https://kubernetes.io/docs/contribute/style/style-guide/).
- Work with the SIG owners to ensure documentation is reviewed for technical
  accuracy.
- Work with Release Comms to review the release blog.
- Approve reviewed documentation to ensure its inclusion in the upcoming
  release.
- Migrate the previous website version documentation and update it with the
  new release.
- Communicate changes to all localization teams to stay in sync across
  branches.
- Update this handbook, the [release timeline](release-timeline.md) and the
  [Release Team onboarding guide](/release-team/release-team-onboarding.md)
  after each release.

## Prerequisites for the Docs Lead and shadows

### General requirements

Before continuing with the Docs specific requirements below, complete the
tasks in the [Release Team onboarding guide](/release-team/release-team-onboarding.md).

### Time requirements

Release cycles run for 14 to 16 weeks. There is less work before
Enhancements Freeze, more work between Enhancements Freeze and Code Freeze
as KEP owners need to be reminded to contribute documentation updates, and a
lot of work between Code Freeze and release day as documentation must be
reviewed and approved. The largest time commitment for the Docs Lead is
release day itself, when the Docs Lead merges all documentation updates and
unfreezes the website.

General time requirements for leads and shadows are:

- Half an hour to two hours a day reviewing incoming enhancements, tracking
  documentation PRs and monitoring Slack.
- One to two hours a week to attend the majority of the Release Team
  meetings (weekly) and the burndown meetings (several times a week after
  Code Freeze), subject to time zone appropriateness.
- Up to one hour a week to attend
  [SIG Docs meetings](https://github.com/kubernetes/community/tree/master/sig-docs#meetings)
  for status reports.

#### Onboarding session, about one hour

In the first week of the release cycle, the Docs Lead organizes an
onboarding session with the shadows to go over the general responsibilities
and expectations.

#### Before Code Freeze, one to five hours a week

Until Code Freeze, the Docs team attends the weekly Release Team meetings
and runs the [release-notes subcommand of krel](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md)
after every pre-release cut to create an early draft of the release notes.
This ensures that the overall quality of the release notes can be verified
from the beginning of the release cycle.

Weekly branch syncs keep `dev-<future release>` consistent with `main`. The
Docs team communicates the documentation deadlines to the KEP owners and SIG
leads, tracks the documentation PRs and enforces the deadlines.

All members of the Docs team participate in PR reviews as time allows.

#### Code Freeze to release day, four to ten hours a week

The Release Team meets more often in this period, and there is significantly
more work to do to ensure that the release notes and documentation are in
good order for the release.

The `release-notes` subcommand of krel must continue to be run for each
`rc` to pull in any outstanding PRs merged between Code Freeze and the
release.

The Docs Lead syncs with the Comms team, SIG Docs and SIG Cluster Lifecycle,
and prepares the website for release day. On release day, the Docs Lead
merges the documentation, publishes the release blog and updates the
website.

**During the last weeks of the release, shadows should expect to spend at
least five hours and leads at least ten hours a week finalizing the launch.**

### Prerequisites for Docs Leads

In addition to the time requirements above, a Docs Lead must:

- Be familiar with GitHub.
- Be able to add milestones to issues, which requires membership of the
  [website milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/)
  team. Request access with a PR against `kubernetes/org`, for example
  [this one](https://github.com/kubernetes/org/pull/2235). Viewing the team
  is restricted to Kubernetes GitHub org members.
- Be able to `/approve` PRs in `kubernetes/website`. Request access with a
  PR against the `main` branch that adds you to `OWNERS_ALIASES`, for
  example [this one](https://github.com/kubernetes/website/pull/20351).
- Take the [Inclusive Speaker Orientation (LFC101)](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/)
  training course.

### Prerequisites for shadows

Docs shadows are people who are preparing to be a Docs Lead in the future.
In addition to the time requirements above, shadows must:

- Have strong written and verbal communication skills.
- Have a working knowledge of Kubernetes concepts.
- Be familiar with Git and command line tools.
- Have signed the [contributor CLA](https://github.com/kubernetes/community/blob/master/CLA.md)
  for Kubernetes.
- Be invested in becoming an org member within the release cycle. This can
  often be achieved during the release cycle with sponsorship from a role
  lead. See the [Release Team onboarding guide](/release-team/release-team-onboarding.md)
  for details.
- Have general knowledge of the SIG Docs
  [areas of responsibility](https://github.com/kubernetes/community/tree/master/sig-docs#subprojects).
- Have experience with the general process of
  [contributing](https://kubernetes.io/docs/contribute/start/) to the
  Kubernetes website.
- Be a [website milestone maintainer](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/)
  in order to add milestones to issues. Request access with a PR against
  `kubernetes/org` (see the Docs Lead prerequisites above).

Project management experience is helpful but not required.

### Machine and GitHub setup

#### Set up krel

[Install Go](https://golang.org/doc/install) and follow the
[instructions to build the release tools](https://github.com/kubernetes/release/tree/master/docs/krel#installation).
Check the system requirements in the krel documentation.

#### Fork the Kubernetes repositories

Fork the following repositories to your GitHub account and clone them using
SSH:

- [`kubernetes/sig-release`](https://github.com/kubernetes/sig-release): this
  is where you push the regular PRs that keep the release notes draft up to
  date.
- [`kubernetes/website`](https://github.com/kubernetes/website): this is
  where the docs live and where the branch sync PRs go.
- [`kubernetes-sigs/release-notes`](https://github.com/kubernetes-sigs/release-notes):
  the sources of the [release notes website](https://relnotes.k8s.io).

## Release timeline

The [release timeline](release-timeline.md) lists the Docs team tasks for
each release milestone. The dates for the current cycle are in the release
directory, `releases/release-<future release>/README.md`, together with the
Release Team contacts and tracking links.

## Tools

- [krel](https://github.com/kubernetes/release/tree/master/docs/krel), the
  Kubernetes release toolbox. Always use the latest version of krel to get
  the latest fixes.
- [The krel `release-notes` subcommand](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md)
- [The `release-notes` tool](https://github.com/kubernetes/release/tree/master/cmd/release-notes)
  that krel builds on
- [Release notes website](https://relnotes.k8s.io), which is updated
  automatically
- [go-modiff](https://github.com/saschagrunert/go-modiff) for the
  dependencies section
- [HackMD](https://hackmd.io/)
- [LWKD](http://lwkd.info). Contributing to LWKD is not a requirement of the
  Docs shadow role, but might be of interest to shadows.
- [Kubernetes documentation style guide](https://kubernetes.io/docs/contribute/style/style-guide/)
- [Generating reference documentation for a release](https://kubernetes.io/docs/contribute/generate-ref-docs/release-generation/).
  The generated reference sets are built by a SIG Docs tech lead, not the
  Docs Lead.

## Debugging tips

If you are having trouble running krel, here are some common issues and
solutions:

1. Run with `--log-level=debug` or `--log-level=trace` to get more
   information about what is going wrong.
1. krel creates a temporary directory named `k8s-<hash>` in the system
   temporary directory (`$TMPDIR` on macOS, usually `/tmp` on Linux) when it
   runs. If this data is stale, remove the `k8s-*` directories there and run
   krel again.

See the documentation of the
[krel `release-notes` subcommand](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md)
for more.

## Release notes file structure

All release notes of a release are stored under the
[releases](https://github.com/kubernetes/sig-release/tree/master/releases)
directory of the sig-release repo.

For each release there is a JSON and a Markdown file that contain the
collected release notes across the pre-releases. For example,
`releases/release-<future release>/release-notes/release-notes-draft.md`
contains all the correctly formatted release notes text for the release, and
`release-notes-draft.json` contains the release notes metadata used to
generate the Markdown file.

When a Docs team member runs `krel release-notes`, a new session is created
so that the editing process can be paused and resumed. The sessions are
stored in the `release-notes/sessions` directory of the release.

When a Docs team member fixes a release note, the edit is saved as a map YAML
file in the `release-notes/maps` directory of the release. These maps are
used to generate the Markdown and JSON files with the corrected release
note.

## Improvement ideas

Docs shadows interested in improving the release notes process can pick up
one of these ideas:

- A GitHub workflow that detects common release note issues in the release
  notes PRs: a YAML linter that blocks invalid YAML from manually edited
  maps (invalid YAML blocks krel for the next pre-release until it is fixed
  in a separate PR, see [this v1.30 PR](https://github.com/kubernetes/sig-release/pull/2446)),
  a spell check based on a dictionary of common Kubernetes terms, and checks
  for punctuation and tense. [Vale](https://vale.sh/) and its
  [GitHub action](https://github.com/errata-ai/vale-action) are candidates
  for the editorial checks.
- Language processing in the `release-notes` tool to generate a uniform
  style across release notes (past tense, formatting) and decrease the copy
  editing time.
- A release notes classifier that learns from the edits made during the
  cycle to flag notes that need attention. See
  [kubernetes/enhancements#1833](https://github.com/kubernetes/enhancements/issues/1833).
- krel improvements, for example showing how many PRs are left to review in
  the editing flow.
