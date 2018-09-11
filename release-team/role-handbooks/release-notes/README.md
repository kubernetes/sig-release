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

- The Release notes lead and shadows attend burn down meetings, sig-release meetings and follow the sig-release slack chat for relevant
information throughout the release cycle to keep up with relevant release specific information.
- One member of the release notes team should be responsible for setting up and running the [release notes tool](https://github.com/marpaia/release-notes)
to collect generated drafts of all release-notes identified in the current release -- improvements to the tool are always welcome!
- Drafts produced by the tool are copied to Hackmd and shared with the rest of the release team (there is currently no automated way to keep the generated
release-notes and the hackmd file concurrent. Some tool to automate this process would be a good task for the 1.13 release team)
- Closer to the release date, major themes are collected from the release notes draft and the release notes team creates a draft in markdown of
the identified major themes to send to sig-leads for feedback/confirmation
- If gentle nudging of sig leads is not effective in retrieving feedback/confirmation, the release-notes team can use a reasonable amount of creative liberity
in completing the notes
- The confirmed upon notes are cleaned up and copy edited by the release team to ensure uniform language/style is used.
- Kubernetes is released with the completed notes!

## Tools

- [Release notes tool](https://github.com/marpaia/release-notes)
- [Hackmd](https://hackmd.io/)


## Todos

Update this section at the end of each release for the next team

### Post 1.12 todos

- Create new tool to process language in generated release notes file (or incorporate into the release notes tool)
    Goals:
    - Generate uniform style across release notes (ie. past tense, formatting)
    - Decrease copy editing time


## Release Milestone Activities:

<table>
  <tr>
    <td>RELEASE WEEK</td>
    <td>ACTIVITIES</td>
  </tr>
  <tr>
    <td>1</td>
<td>- Begin running release-notes script for ongoing collection of release notes
<br>- Begin attending release team meetings
<br>- Informal intro meeting with release notes team to discuss contact information and logistics </td>
  </tr>
  <tr>
    <td>2</td>
<td>- ?</td>
  </tr>
  <tr>
    <td>3</td>
    <td>- Begin attending burndown meetings
    <br>- ?</td>
  </tr>
  <tr>
    <td>4</td>
    <td>- ?</td>
  </tr>
  <tr>
    <td>5</td>
    <td>- ?</td>
  </tr>
  <tr>
    <td>6</td>
    <td>- ?</td>
  </tr>
  <tr>
    <td>7</td>
    <td>- ?</td>
  </tr>
  <tr>
    <td>8</td>
    <td>- ?</td>
  </tr>
  <tr>
    <td>9</td>
    <td>- Former Release Notes lead helps identify new leads and shadows
<br>- Start determining major themes for release notes template to send to sig-leads </td>
  </tr>
  <tr>
    <td>10</td>
    <td>- Finalize lead and shadow roles for subsequent release
    <br>- Work with sig-leads to finalize major themes for release-notes
    <br>- Copy edit notes for spelling, grammar and uniform style</td>
  </tr>
  <tr>
    <td>11</td>
    <td>- Repeat previous tasks until final copy is complete</td>
  </tr>
  <tr>
    <td>12</td>
    <td>- Release day
<br>- Final version of release notes submitted for release </td>
  </tr>
  <tr>
    <td>13</td>
    <td>- Release retrospective participation</td>
  </tr>
</table>
