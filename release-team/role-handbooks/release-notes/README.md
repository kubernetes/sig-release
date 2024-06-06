# Kubernetes Release Team: Release Notes

- [Kubernetes Release Team: Release Notes](#kubernetes-release-team-release-notes)
  - [Overview:](#overview)
  - [Prerequisites for Release Notes Lead and Shadows](#prerequisites-for-release-notes-lead-and-shadows)
    - [General Requirements](#general-requirements)
    - [Skills and Experience Requirements](#skills-and-experience-requirements)
    - [Time Requirements](#time-requirements)
      - [Onboarding Session (week 1) ~1 hour](#onboarding-session-week-1-1-hour)
      - [Early and mid release cycle (weeks 1-8) ~1-5 hours/week](#early-and-mid-release-cycle-weeks-1-8-1-5-hoursweek)
      - [Late release cycle (weeks 9-12+) ~4-10 hours/week](#late-release-cycle-weeks-9-12-4-10-hoursweek)
    - [GitHub Organization Membership](#github-organization-membership)
    - [Machine and GitHub Setup](#machine-and-github-setup)
      - [Setup krel](#setup-krel)
      - [Fork the kubernetes repositories](#fork-the-kubernetes-repositories)
  - [Tasks and Responsibilities](#tasks-and-responsibilities)
    - [Manage permissions](#manage-permissions)
    - [Setup the Tools and Generate the Release Notes](#setup-the-tools-and-generate-the-release-notes)
    - [Periodically review and fix new release notes](#periodically-review-and-fix-new-release-notes)
    - [Attend Release Meetings and follow #sig-release](#attend-release-meetings-and-follow-sig-release)
    - [Maintain the _Known Issues_ Issue](#maintain-the-known-issues-issue)
    - [Ensure Major Themes are Reflected in the Notes](#ensure-major-themes-are-reflected-in-the-notes)
    - [Get feedback from SIG Leads](#get-feedback-from-sig-leads)
    - [Clean up and edit the final document](#clean-up-and-edit-the-final-document)
    - [Curate the External Dependencies Section](#curate-the-external-dependencies-section)
  - [Release Cycle Milestone Activities:](#release-cycle-milestone-activities)
    - [Week 1](#week-1)
    - [Weeks 2 - 10](#weeks-2---10)
      - [Week 4](#week-4)
      - [Week 10](#week-10)
    - [Week 11 (Begin of Code Freeze)](#week-11-begin-of-code-freeze)
    - [Weeks 13-16](#weeks-13-16)
    - [Week 15](#week-15)
    - [Week 16](#week-16)
    - [Week 17](#week-17)
    - [Week 19](#week-19)
  - [Tools](#tools)
  - [TODOs](#todos)
    - [Post 1.17 TODOs](#post-117-todos)
      - [If any team members have NLP experience](#if-any-team-members-have-nlp-experience)

## Overview:

The Release Notes role is responsible for collecting and fine-tuning release-notes from the many contributions to Kubernetes between release cycles. This role is likely to find that work during the first several weeks of the release cycle is very laid back with the bulk of the tasks being completed at the end, once the release is firmed up.

The release lead will be responsible for introducing shadows to the team and the release notes subcommand in [krel](https://github.com/kubernetes/release/tree/master/docs/krel) and may ask shadows to run it and make the update PR’s. The release notes lead should indicate pain points and known issues to the shadows (if there are any) and work on strategies for overcoming them to avoid their coalescence during the later weeks.

If there are potential fixes to the issues indicated and team members are keen, fixes and automation of the process is very welcome but not expected.

## Prerequisites for Release Notes Lead and Shadows

### General Requirements

**Before continuing on to the Release Notes specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Skills and Experience Requirements

- Strong written and verbal communications skills
- A working knowledge of Kubernetes concepts
- Project management experience is helpful but not required
- The release notes lead should take the [Inclusive Speaker Orientation (LFC101)](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/) training course

### Time Requirements

Compared to other release team roles, release notes is one of the least time intensive roles.

#### Onboarding Session (week 1) ~1 hour

In the first week of the release cycle, the Release Notes Lead will organize an onboarding session with the shadows to go over general responsibilities and expectations.

#### Early and mid release cycle (weeks 1-8) ~1-5 hours/week

In the first 8 weeks of the cycle, the Release Notes team must attend weekly release meetings and run the [release-notes subcommand of krel](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md) for every `alpha`, `beta` and `rc` to create an early draft of the release notes. This ensures that the overall quality of the release notes can be verified from the beginning of the release cycle.

#### Late release cycle (weeks 9-12+) ~4-10 hours/week

This period has an increase in release team meetings each week and there is also significantly more work to do to ensure the release notes are in good working order for the release.

The `release-notes` subcommand of `krel` must continue to be run on the release branch (for `beta` and `rc` releases) in order to pull in any outstanding PRs that are merged between the beginning of code freeze and the release.

### GitHub Organization Membership

As well as becoming a member of the kubernetes GitHub organization as discussed in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md), release notes members should ensure that they [become members of the kubernetes-sigs GitHub organization](https://github.com/kubernetes/community/blob/master/community-membership.md#kubernetes-ecosystem). The tooling used by the release notes team creates pull requests kubernetes and kubernetes-sigs repositories, so membership of both is needed to streamline reviews.

### Machine and GitHub Setup

#### Setup krel

[Install Go](https://golang.org/doc/install) in your machine and follow the [instructions to build the release tools](https://github.com/kubernetes/release/tree/master/docs/krel#installation) in your machine. Check the system requirements in the krel documentation.

#### Fork the kubernetes repositories

Fork the following repositories to your GitHub account, and clone them using SSH:

 - [`kubernetes/sig-release`](https://github.com/kubernetes/sig-release): This is where you will push regular PRs to keep the Release Notes draft up to date.
 - [`kubernetes-sigs/release-notes`](https://github.com/kubernetes-sigs/release-notes): This repo has the [release notes website](https://relnotes.k8s.io) sources

## Tasks and Responsibilities

### Manage permissions

Release Notes lead should be responsible for granting team members required access:
1. Add OWNERS file into release notes directory. [Sample PR](https://github.com/kubernetes/sig-release/pull/1943) for v1.25 release.
2. Add release notes team members for CHANGELOG review/approval.
   [Sample PR](https://github.com/kubernetes/kubernetes/pull/112045) for v1.25 release.
3. Typically, the release lead updates the [release-team-release-notes](https://github.com/kubernetes/org/blob/main/config/kubernetes/sig-release/teams.yaml) GitHub team along with other teams in a single PR; check the PR and make sure the release notes team has been updated, otherwise open a PR yourself [Sample PR](https://github.com/kubernetes/org/pull/3735).

### Setup the Tools and Generate the Release Notes

The main task of the Release Notes team is the generation of the release notes during the release cycle.

At least one member of the Release Notes Team should be responsible for [setting up](https://github.com/kubernetes/release/tree/master/docs/krel#installation) and [running](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md) the release-notes subcommand of krel to generate the release notes after each Patch Release:

1. Update the release notes draft, a markdown file which will become the final document which will encompass all release notes written by contributors during the current release cycle. See previous drafts for versions [1.25](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.25/release-notes/release-notes-draft.md), [v1.24](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.24/release-notes/release-notes-draft.md) or [v1.23](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.23/release-notes/release-notes-draft.md).

Detailed instructions for generating the release notes bundle is in the [krel release-notes subcommand documentation](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md).

### Periodically review and fix new release notes

The Release Notes team must make sure that the final document includes well written and informative release notes. To achieve a high-quality document the team should review and edit the
notes by running `krel release-notes --fix` weekly or as often as development pace
demands.

This command will enable the team to review each release note and edit the note's data.
It is recommended that the team splits the work among all members and runs the editing flow
on a weekly or biweekly basis. More information about the editing flow can be found in
a separate document detailing the [editing process and tooling](editing-flow.md).

The general style guide for release notes includes checking for:
- Past tense: Release notes should be written in the past tense since the changes have already been implemented.
- Technical jargon: While the notes are generally user-friendly, some technical terms like "VAC" or "scheduling hints" could be explained briefly with backticks or double quotes for users unfamiliar with them.
- Additional context: In some cases, providing more context about the problem these changes address or the specific situations where they're relevant could be helpful for understanding their significance. You can find additional context referenced in the PR in k8s/k8s repo to check what the PR does for end users.

Additional style guidelines can be found in the [Documentation Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/).

### Attend Release Meetings and follow #sig-release

The Release Notes Lead and Shadows attend burn down meetings, SIG Release meetings and follow the [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF) Slack channel for relevant information throughout the release cycle.

### Maintain the _Known Issues_ Issue

A ["Known Issues Umbrella Issue"](known-issues-bucket.md) for the release must be created by the release notes team in [kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/issues/new) so issues can be collected for the "Known Issues" section of the release notes. See previous known issues for [1.25](https://github.com/kubernetes/kubernetes/issues/110336), [1.24](https://github.com/kubernetes/kubernetes/issues/109027), [v1.23](https://github.com/kubernetes/kubernetes/issues/104885), [v1.22](https://github.com/kubernetes/kubernetes/issues/101728), [v1.21](https://github.com/kubernetes/kubernetes/issues/98232), [v1.19](https://github.com/kubernetes/kubernetes/issues/90304), [v1.18](https://github.com/kubernetes/kubernetes/issues/86882) or [v1.17](https://github.com/kubernetes/kubernetes/issues/83683).

### Ensure Major Themes are Reflected in the Notes

The Communications team will hold a meeting to discuss Major Themes sometime around Code Freeze. Ensure that at least one person from the Release Notes team attends this meeting with the Release Lead and Enhancements Lead. The Release Notes team should ensure that the "Major Themes" identified in this meeting are reflected in the "Major Themes" section of the release notes. If no one is able to attend the meeting, reach out to the Communications team, Release Lead or Enhancements Lead to ensure messaging around Major Themes is coordinated.

### Get feedback from SIG Leads

Around Code Freeze, the Release Notes team will get in touch with the SIG Leads to ensure that the Release Notes accurately reflect the major themes for their SIGs. The team will also ensure that major issues captured in the release notes are confirmed by the SIG leads before release day.

If gentle nudging of SIG Leads is not effective in retrieving feedback/confirmation, the Release Notes Team can use a reasonable amount of creative liberty in completing the notes.

### Clean up and edit the final document

The confirmed notes are cleaned up and copy edited by the release-notes team to ensure uniform language/style is used. The team must make sure that the final document conforms to the [Documentation Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/).

### Curate the External Dependencies Section

A "Dependencies" section should be curated which outlines how external dependency versions have changed since the last release. These changes are currently [automatically aggregated](https://github.com/kubernetes/community/issues/2234), but should still be manually validated for correct content and formatting.

## Release Cycle Milestone Activities:

### Week 0 
 
Create a table to track `Release`, `Branch Created Day`, `Week of Release`, `PR Merge Deadline`, `Release Notes Assignee`
and `Release Notes Reviewer` based on the release timeline. This will serve as an internal schedule and signup sheet for
the release notes team to follow. The schedule is used to track progress and give status updates during release team meetings. 

##### Release Team Meeting Updates

For the release team meeting, provide a `status` based on the following criteria:
- A `Red` on our release notes status means that we are delayed past the deadline or there is a major blocker for our work to create Release Notes pull requests. 
- A `Yellow` status generally means that we are still within the deadline of creating the Release Notes pull request, but 
there are things (minor blockages, `krel` issues, etc.) that could cause a delay past the PR merge deadline.
- A `Green` status means that everything looks good and done from Release Notes team side, i.e. the release notes pull requests are being created, reviewed and merged before the deadline. Everything is A-OK here.

### Week 1

Begin running release-notes tool for the ongoing collection of release notes with the first alpha release, which has been cut directly after the latest minor.

- Update the `release-notes-draft.md`
- Verify release notes are available on (relnotes.k8s.io)[https://relnotes.k8s.io/]
- Begin attending release team meetings
- Informal intro meeting with release notes team to discuss contact information and logistics

### Weeks 2 - 10

- Begin attending burndown meetings
- Same as above, but generate the notes for each `alpha` and `beta`. Announce in the #release-notes channel when the release notes PR is ready for review. 

#### Week 10

- Coordinate with Release Comms to ensure major themes of the release are checked in before Code Freeze; reach out to SIGs and release leads if additional coordination is needed.

### Week 11 (Beginning of Code Freeze)

- Create [known issues issue](known-issues-bucket.md) in `kubernetes/kubernetes` to capture known issues for the release.
- Share created doc with release-team
- Send [an email to SIG-leads](sig-leads-email.md) to ensure major changes for their SIGs are accurately reflected in the release notes
- Start determining major themes for release notes template to send to SIG-leads

### Weeks 13-16

- Repeat previous tasks until the final copy is complete
- Ensure "known issues" section is incorporated into a final document

### Week 15

- Finalize subteam lead for subsequent release
- Work with SIG-leads to finalize major themes for release-notes
- Copy edit notes for spelling, grammar and uniform style

### Week 16

- Start attending daily burndown meetings

### Week 17

- __Release day__
- Final version of release notes committed for release
- Close the _Known Issues_ Issue and make sure everything has been resolved
- Release Notes must be merged into master prior to the release. If this is not done the release will include the latest draft.
- Keep an eye on the #release-notes channel for any requests for any questions, edits or missed release notes.

### Week 19

- Release retrospective participation
- Update the Release Notes Team Handbook to include any tool documentation, debugging tips, etc. that were discovered during the release cycle
- Update the TODOs section at the end of each release for the next Release Notes Team

## Tools
- [krel](https://github.com/kubernetes/release/tree/master/docs/krel) The Kubernetes Release Toolbox
- [The krel `release-notes` subcommand](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md)
- [The old release notes tool](https://github.com/kubernetes/release/tree/master/cmd/release-notes)
- [Release notes website](https://relnotes.k8s.io)
- [go-modiff](https://github.com/saschagrunert/go-modiff)
- [Hackmd](https://hackmd.io/)
- [LWKD](http://lwkd.info) *(consider contributing to LWKD as part of your role)*
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

When a release notes team member runs the `krel release-notes` command, a new session is created so that you can pause and resume
the editing process. For example the 1.30 release notes sessions are stored in the [sessions](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.30/release-notes/sessions)
directory in the sig-release repo under `release-1.30`.

If a release notes team member finds a mistake in the release notes, the edit will be saved as a map yaml file in the [maps](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.30/release-notes/maps)
directory. These maps are used to generate the markdown file and JSON file with the correctly edited release note. 

## TODOs

As a Release Notes shadow, if you are interested in contributing to the improvement of the release notes process, consider the following
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
