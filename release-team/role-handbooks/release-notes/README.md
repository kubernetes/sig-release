# Kubernetes Release Team: Release Notes

- [Overview](#overview)
- [Prerequisites for Release Notes Lead and Shadows](#prerequisites-for-release-notes-lead-and-shadows)
  - [General Requirements](#general-requirements)
  - [Skills and Experience Requirements](#skills-and-experience-requirements)
  - [Time Requirements](#general-requirements)
    - [Early and mid release cycle (weeks 1-8)](#early-and-mid-release-cycle-weeks-1-8)
    - [Late release cycle (weeks 9-12+)](#late-release-cycle-weeks-9-12)
  - [Machine and GitHub Setup](#machine-and-github-setup)
    - [Setup krel](#setup-krel)
    - [Get a GitHub token](#get-a-github-token)
    - [Fork the kubernetes repositories](#fork-the-kubernetes-repositories)
- [Tasks and Responsibilities](#tasks-and-responsibilities)
  - [Setup the Tools and Generate the Release Notes](#setup-the-tools-and-generate-the-release-notes)
  - [Periodically review and fix new release notes](#periodically-review-and-fix-new-release-notes)
  - [Attend Release Meetings and follow #sig-release](#attend-Release-Meetings-and-follow-sig-release)
  - [Maintain the _Known Issues_ Issue](#maintain-the-known-issues-issue)
  - [Ensure Major Themes are Reflected in the Notes](#ensure-major-themes-are-reflected-in-the-notes)
  - [Get feedback from SIG Leads](#get-feedback-from-sig-leads)
  - [Clean up and edit the final document](#clean-up-and-edit-the-final-document)
  - [Curate the External Dependencies Section](#curate-the-external-dependencies-section)
- [Release Milestone Activities](#release-milestone-activities)
  - [Week 1](#week-1)
  - [Weeks 2 - 10](#weeks-2-10)
  - [Week 11 (Begin of Code Freeze)](#week-11-begin-of-code-freeze)
  - [Week 13-16](#week-13-16)
  - [Week 15](#week-15)
  - [Week 16](#week-16)
  - [Week 17](#week-17)
  - [Week 19](#week-19)
- [Tools](#tools)
- [TODOs](#todos)  

## Overview:

The Release Notes role is responsible for collecting and fine-tuning release-notes from the many contributions to Kubernetes between release cycles. This role is likely to find that work during the first several weeks of the release cycle is very laid back with the bulk of the tasks being completed at the end, once the release is firmed up.

The release lead will be responsible for introducing shadows to the team and the release notes subcommand in [krel](https://github.com/kubernetes/release/tree/master/docs/krel) and may ask shadows to run it and make the update PR’s. The release notes lead should indicate pain points and known issues to the shadows (if there are any) and work on strategies for overcoming them to avoid their coalescence during the later weeks. 

If there are potential fixes to the issues indicated and team members are keen, fixes and automation of the process is very welcome but not expected.

## Prerequisites for Release Notes Lead and Shadows

### General Requirements

**Before continuing on to the Release Notes specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Skills and Experience Requirements:

* Strong written and verbal communications skills
* A working knowledge of Kubernetes concepts
* Project management experience is helpful but not required

### Time Requirements:

Compared to other release team roles, release notes is one of the least time intensive roles.

#### Onboarding Session (week 1) ~1 hour

In the first week of the release cycle, the Release Notes Lead will organize a onboarding session with the shadows to go over general responsibilities and expectations.

#### Early and mid release cycle (weeks 1-8) ~1-5 hours/week

In the first 8 weeks of the cycle, the Release Notes team should/must, attend weekly release meetings and run the [release-notes subcommand of krel](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md) as well as update the [release-notes website](https://github.com/kubernetes-sigs/release-notes) for every `alpha`, `beta` and `rc` to create an early draft of the release notes. This ensures that the overall quality of the release notes can be verified from the beginning of the release cycle.

#### Late release cycle (weeks 9-12+) ~4-10 hours/week

This period has an increase in release team meetings each week and there is also significantly more work to do to ensure the release notes are in good working order for the release.

Once code freeze begins, the release notes draft is transferred to a Google Doc which is made public to the Kubernetes community. The doc will be edited by SIG leads and SIG members but the team will also ensure proper grammar and uniform style in accordance to the [Kuberentes Documentation Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/).

The Release Notes team should use the [template](relnotes-template.md) to organize the raw generated release notes in the Google doc as best as possible and help to guide SIG leads and members in their further editing of the release notes. The final edited release notes should follow this template. 

The `release-notes` subcommand of `krel` must continue to be run on the release branch (for `beta` and `rc` releases) in order to pull in any outstanding PRs that are merged between the beginning of code freeze and the release.

### GitHub Organization Membership

As well as becoming a member of the kubernetes GitHub organization as discussed in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md), release notes members should ensure that they [become members of the kubernetes-sigs GitHub organization](https://github.com/kubernetes/community/blob/master/community-membership.md#kubernetes-ecosystem). The tooling used by the release notes team creates pull requests kubernetes and kubernetes-sigs repositories, so membership of both is needed to streamline reviews.

### Machine and GitHub Setup

#### Setup krel

[Install Go](https://golang.org/doc/install) in your machine and follow the [instructions to build the release tools](https://github.com/kubernetes/release/tree/master/docs/krel#installation) in your machine. Check the system requirements in the krel documentation.   

#### Get a GitHub token

4. Obtain a GitHub Personal Access Token with the repo scope:
https://github.com/settings/tokens
- [X] repo
    - [X] repo: status
    - [X] repo_deployment
    - [X] public_repo
    - [X] repo:invite

#### Fork the kubernetes repositories

Fork the following repositories to your GitHub account, and clone them using SSH:

 - [`kubernetes/sig-release`](https://github.com/kubernetes/sig-release): This is where you will push regular PRs to keep the Release Notes draft up to date.
 - [`kubernetes-sigs/release-notes`](https://github.com/kubernetes-sigs/release-notes): This repo has the [release notes website](https://relnotes.k8s.io) sources. 

## Tasks and Responsibilities

### Setup the Tools and Generate the Release Notes

The main task of the Release Notes team is the generation of the release notes during the release cycle.

At least one member of the Release Notes Team should be responsible for [setting up](https://github.com/kubernetes/release/tree/master/docs/krel#installation) and [running](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md) the release-notes subcommand of krel to generate both versions of the release notes after each Patch Release:

1. Update the release notes draft, a markdown file which will become the final document which will encompass all release notes written by contributors during the current release cycle. See previous drafts for versions [v1.20](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.20/release-notes-draft.md), [v1.19](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.18/release-notes-draft.md) or [v1.18](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.19/release-notes-draft.md).

2. The team is responsible for adding Patch Release (e.g. [1.20.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1201), etc.) notes to the release notes website at https://relnotes.k8s.io. The krel release notes subcommand will automatically generate the necessary JSON files and patch the release notes website source.

Detailed instructions for generating the release notes bundles are in the [krel release-notes subcommand documentation](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md).

### Periodically review and fix new release notes

The Release Notes team must make sure that the final document includes well written and 
informative release notes. To achieve a high-quality document the team should review and edit the
notes by running `krel release-notes --fix` weekly or as often as development pace
demands.

This command will enable the team to review each release note and edit the note's data.
It is recommended that the team splits the work among all members and runs the editing flow
on a weekly or biweekly basis. More information about the editing flow can be found in
a separate document detailing the [editing process and tooling](editing-flow.md).

### Attend Release Meetings and follow #sig-release 

The Release Notes Lead and Shadows attend burn down meetings, SIG Release meetings and follow the [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF) Slack channel for relevant information throughout the release cycle.

### Maintain the _Known Issues_ Issue

A ["Known Issues Umbrella Issue"](known-issues-bucket.md) for the release must be created by the release notes team in [kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/issues/new) so issues can be collected for the "Known Issues" section of the release notes. See previous known issues for 
*TODO Find correct issue in k/k
[v1.20](https://github.com/kubernetes/kubernetes/issues/90304), 
[v1.19](https://github.com/kubernetes/kubernetes/issues/90304), 
[v1.18](https://github.com/kubernetes/kubernetes/issues/86882) or 
[v1.17](https://github.com/kubernetes/kubernetes/issues/83683).


### Ensure Major Themes are Reflected in the Notes

The Communications team will hold meetings to discuss blogposts and media releases regarding the release sometime before code freeze. Ensure that at least one person from the release notes team attends this meeting with the release lead and enhancements lead. The release notes team should ensure that the "Major Themes" identified in this meeting are reflected in the "Major Themes" section of the release notes. If no one is able to attend the meeting, reach out to the communications team, release lead or enhancements lead to ensure messaging around Major Themes is coordinated.

### Get feedback from SIG Leads

Around Code Freeze, the release notes team will get in touch with the SIG Leads to capture the major themes of their SIGs. The team will also ensure that major issues captured in the release notes are confirmed by the SIG leads before release day.

If gentle nudging of SIG Leads is not effective in retrieving feedback/confirmation, the Release Notes Team can use a reasonable amount of creative liberty in completing the notes

### Clean up and edit the final document
The confirmed notes are cleaned up and copy edited by the release-notes team to ensure uniform language/style is used. The team must make sure that the final document conforms to the [Documentation Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/).

### Curate the External Dependencies Section
*TODO: There are not external dependencies after release 1.14 in the release notes!Check with Wilson about it.

An "External Dependencies" section should be curated which outlines how external dependency versions have changed since the last release. See [the v1.14 release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.14.md#external-dependencies) for an example. 

Note that there are [plans in the process to formalize and automate the process of aggregating the changes](https://github.com/kubernetes/community/issues/2234), but this is currently [a very manual process](https://github.com/kubernetes/sig-release/pull/398).

To update an entry in this section the following steps must be performed:

- Pick an entry, for example "Default etcd server was updated to v3.2.24. (#68318)"
- Open the linked PR 68318 and find which files and lines it modifies
- Open the same files in the `kubernetes/kubernetes` master branch and see if the version changed from v3.2.24
- Look at the history of the file and find which commit / PR changed the version
- Update the entry with the new version and PR URL
- Update the entry message accordingly - if the version has changed or it has been preserved between versions
- The website [lwkd.info](http://lwkd.info/) has weekly Kubernetes updates that often include information about changes in dependencies under a "Version Updates" section
- Kubernetes is released with the completed notes!

## Release Cycle Milestone Activities:

### Week 1

Begin running release-notes tool for ongoing collection of release notes with the first alpha release, which has been cut directly after the latest minor.
    - Update the `release-notes-draft.md`
    - Update the website
- Begin attending release team meetings
- Informal intro meeting with release notes team to discuss contact information and logistics

### Weeks 2 - 10

- Begin attending burndown meetings
- Same as above, but generate the notes for each `alpha` and `beta`

### Week 11 (Begin of Code Freeze)

- Create Google Doc for generated release notes and share with release-notes team
- Create [known issues issue](known-issues-bucket.md) in `kubernetes/kubernetes` to capture known issues for the release.
- Share created doc with release-team
- Send [an email to SIG-leads](sig-leads-email.md) to capture major themes from their SIG.
- Start determining major themes for release notes template to send to SIG-leads

### Weeks 13-16

- Repeat previous tasks until final copy is complete
- Ensure "known issues" section is incorporated into final document

### Week 15

- Finalize lead and shadow roles for subsequent release
- Work with SIG-leads to finalize major themes for release-notes
- Copy edit notes for spelling, grammar and uniform style

### Week 16

- Start attending daily burndown meetings

### Week 17

- __Release day__
- Copy notes from Google Doc to HackMD in markdown
- Final version of release notes committed for release
- Release Notes must be merged into master prior to the release. If this is not done the release will include the latest draft.

### Week 19

- Release retrospective participation

## Tools
- [krel](https://github.com/kubernetes/release/tree/master/docs/krel) The Kubernetes Release Toolbox
- [The krel `release-notes` subcommand](https://github.com/kubernetes/release/blob/master/docs/krel/release-notes.md)
- [The old release notes tool](https://github.com/kubernetes/release/tree/master/cmd/release-notes)
- [Release notes website](https://relnotes.k8s.io)
- [go-modiff](https://github.com/saschagrunert/go-modiff)
- [Hackmd](https://hackmd.io/)
- [LWKD](http://lwkd.info) *(consider contributing to LWKD as part of your role)*
- [Kubernetes Documentation Style Guide](https://kubernetes.io/docs/contribute/style/style-guide/)

## TODOs

Update this section at the end of each release for the next Release Notes Team.

### Post 1.17 TODOs

#### If any team members have NLP experience:
Implement functionality in release-notes tool to automatically process language in generated release notes file

Goals:

- Generate uniform style across release notes (ie. past tense, formatting)
- Decrease copy editing time
