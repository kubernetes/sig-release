# Kubernetes Release Team: Release Notes

## Overview:

The Release Notes role is responsible for collecting and fine-tuning release-notes from the many contributions to Kubernetes between release cycles. This role is likely to find that work during the first several weeks of the release cycle is very laid back with the bulk of the tasks being completed at the end, once the release is firmed up.

## Skills and Experience Required:

* Strong written and verbal communications skills
* A working knowledge of Kubernetes concepts
* Project management experience is helpful

## Tasks

- The Release Notes Lead and Shadows attend burn down meetings, SIG Release meetings and follow the [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF) Slack channel for relevant information throughout the release cycle.
- One member of the Release Notes Team should be responsible for setting up and running the [`release-notes` tool](https://github.com/marpaia/release-notes) to collect generated drafts of all release-notes identified in the current release -- improvements to the tool are always welcome!
- Drafts produced by the tool are copied to a file called `release-notes-draft.md` in the release folder for the current release in the `sig-release` repo.
- Before the beginning of Code Freeze, the Release Notes Team will copy the latest draft into a Google Doc and start reaching out to SIG Leads in an effort to have them fill in a prose paragraph of "Major Themes" that outlines what their SIG has been working on throughout the lifecycle.
- If gentle nudging of SIG Leads is not effective in retrieving feedback/confirmation, the Release Notes Team can use a reasonable amount of creative liberity in completing the notes
- A "Known Issues" section will also be created in a GitHub issue to be added to the release notes before release date.
- The confirmed upon notes are cleaned up and copy edited by the release-notes team to ensure uniform language/style is used.
- An "External Dependencies" section should be currated which outlines how external depdendency versions have changed since the last release
  - See [the 1.12 release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#external-dependencies) for an example
	- Note that there are [plans in the process to formalize and automate the process of aggregating the changes](https://github.com/kubernetes/community/issues/2234), but this is currently [a very manual process](https://github.com/kubernetes/sig-release/pull/398).
  - To update an entry in this section the following steps must be performed:
    - Pick an entry, for example "Default etcd server was updated to v3.2.24. (#68318)"
    - Open the linked PR 68318 and find which files and lines it modifies
    - Open the same files in the `kubernetes/kubernetes` master branch and see if the version changed from v3.2.24
    - Look at the history of the file and find which commit / PR changed the version
    - Update the entry with the new version and PR URL
    - Update the entry message accordingly - if the version has changed or it has been preserved between versions
- Kubernetes is released with the completed notes!

## Tools

- [Release notes tool](https://github.com/marpaia/release-notes)
- [Hackmd](https://hackmd.io/)
- [LWKD](http://lwkd.info) *(consider contributing to LWKD as part of your role)*

## TODOs

Update this section at the end of each release for the next Release Notes Team.

### Post 1.12 TODOs

- Implement new functionality in release-notes tool to process language in generated release notes file

  Goals:
    - Generate uniform style across release notes (ie. past tense, formatting)
    - Decrease copy editing time

## Release Milestone Activities:

### Week 1 - 2

- Begin running release-notes script for ongoing collection of release notes
- Begin attending release team meetings
- Informal intro meeting with release notes team to discuss contact information and logistics


### Weeks 3 - 8

- Begin attending burndown meetings
- Same as above


### Week 9

- Create Google Doc for generated release notes and share with release-notes team
- Share created doc with release-team
- Start determining major themes for release notes template to send to sig-leads


### Week 10

- Finalize lead and shadow roles for subsequent release
- Work with sig-leads to finalize major themes for release-notes
- Copy edit notes for spelling, grammar and uniform style


### Week 11

- Repeat previous tasks until final copy is complete
- Ensure "known issues" section is incorporated into final document

### Week 12

- Release day
- Copy notes from Google Doc to HackMD in markdown
- Final version of release notes committed for release

### Week 13

- Release retrospective participation
