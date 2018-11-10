# Kubernetes Release Team: Release Notes

## Overview:

The Release Notes role is responsible for collecting and fine-tuning release-notes from the many contributions to kubernetes between release cycles.
This role is likely to find that work during the first several weeks of the release cycle is very laid back with the bulk of the tasks being
completed at the end, once the release is firmed up.

## Skills and Experience Required:

* Strong written and verbal communications skills

* A working knowledge of Kubernetes concepts

* Project management experience is helpful

## Tasks

- The Release notes lead and shadows attend burn down meetings, sig-release meetings and follow the sig-release
slack chat for relevant information throughout the release cycle.
- One member of the release notes team should be responsible for setting up and running the [release notes tool](https://github.com/marpaia/release-notes)
to collect generated drafts of all release-notes identified in the current release -- improvements to the tool are
always welcome!
- Drafts produced by the tool are copied to a Google Document that gives editing privileges to each member of the
release-notes team (there is currently no automated way to keep the generated release-notes and the google doc
concurrent. Some tool to automate this process would be a good task for the 1.13 release team)
- Closer to the release date, major themes are collected from the release notes draft and the release notes team
creates a draft in markdown of the identified major themes to send to sig-leads for feedback/confirmation
- If gentle nudging of sig leads is not effective in retrieving feedback/confirmation, the release-notes team can
use a reasonable amount of creative liberity in completing the notes
- A "Known Issues" section will also be created in a github issue to be added to the release notes before release date
- The confirmed upon notes are cleaned up and copy edited by the release-notes team to ensure uniform language/style
is used.
- Kubernetes is released with the completed notes!

## Tools

- [Release notes tool](https://github.com/marpaia/release-notes)
- [Hackmd](https://hackmd.io/)
- [LWKD](http://lwkd.info) *(consider contributing to LWKD as part of your role)*


## Todos

Update this section at the end of each release for the next team

### Post 1.12 todos

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

### Week13

- Release retrospective participation
