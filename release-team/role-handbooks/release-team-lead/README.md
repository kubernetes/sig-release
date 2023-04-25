# Release Team Lead <!-- omit in toc -->

## Overview <!-- omit in toc -->

The release team leader role is responsible for coordinating release activities, assembling the release team, taking ultimate accountability for all release tasks to be completed on time, and ensuring that a retrospective happens. The lead is also responsible for ensuring a successor is selected and trained for future release cycles.

- [Authority and Responsibility](#authority-and-responsibility)
- [Prerequisites](#prerequisites)
- [Skills and Experience Required](#skills-and-experience-required)
- [Time Commitments](#time-commitments)
- [Choosing a Release Team](#choosing-a-release-team)
- [Standards](#standards)
  - [Mailing List Standards](#mailing-list-standards)
- [Release theme gifts](#release-theme-gifts)
- [Code Freeze](#code-freeze)
- [Working with the Release Team Calendar](#working-with-the-release-team-calendar)
- [Release Team Meeting Host Playbook](#release-team-meeting-host-playbook)
  - [Requirements to host the meeting as Release Team Lead / Lead Shadow](#requirements-to-host-the-meeting-as-release-team-lead--lead-shadow)
  - [Pre-Meeting](#pre-meeting)
  - [Pre-Recording](#pre-recording)
  - [During-Recording](#during-recording)
  - [Post-Recording](#post-recording)

## Authority and Responsibility

The Release Team Lead should be an arbiter of decisions, and not the primary decision-maker. A lead should constantly search for the best-qualified people or SIGs to guide the decision, not "go it alone", unless it is a very specific concern within the release process itself. When decisions are made they must be weighted in favor of community concerns over those of individuals or specific companies. Leads must also relinquish any favoritism for the company they work for. If there is a conflict of interest, the lead must recuse themselves from that decision. Above all, the release lead is a servant leader to the team and the community.

## Prerequisites

**Before we can grant access to new Release Team Leads, a [Release Team Lead onboarding issue][rtl-onboarding] _MUST_ be opened in this repo. Please take a moment to do that before executing the tasks contained in this handbook.**

## Skills and Experience Required

This role requires a tremendous amount of experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process.

In addition to the [Release Team Lead selection criteria][lead-criteria] you are required to fulfill, there are some additional aspirations we have for a Release Team Lead.

- The Release Team is a global volunteer group, as is the Kubernetes project, so the Lead must be prepared to schedule and attend meetings that may be very late or very early in their time zone, in order to include as many of the team as possible.
- Project management experience is highly desirable
- Strong written and verbal communications skills are required
- As the public face of the community during release time, you must do so with a very high level of professionalism
- Prior experience in release management is extremely helpful

## Time Commitments

Release Lead is a very time-consuming role, especially towards the end of the release cycle. Before you volunteer to be Release Lead, please make certain that your employer and your family are okay with you spending a lot of time on the release for the next four months. Here's a rough estimate of the time requirements by week:

- Weeks 1-4: 6-12 hours a week
- Weeks 5-10: 6-12 hours a week
- Week after Code Freeze: Be prepared to spend a lot of time each day on release-related activities
- Weeks 11-15: 10 to 25 hours a week
- Release Day: Prepare to spend all day on release-related activities. Given the choice between working after-hours or weekends, and having the release be later than the initial target, delaying the release is preferred.

Among the specific time commitments you have are:

- SIG Release and Release Team meetings once a week during weeks 1-10.
- Burndown meetings three to five times a week during weeks 11-15.

In addition to the absolute time commitment you make, you must also consider the relative burdens on yourself and your team when establishing meetings. This means scheduling meetings and release events compatible with global working hours and coordinating with a global set of team leads and shadows. 
A few ways to accomplish this goal are as follows (but please feel free to implement and add your own solution):

- Create a poll amongst your Leads as to their preferred meeting time
- Schedule duplicate meetings at alternate times (these can be run by Shadows in those time zones)
- Encourage delegation of reports and meetings to Shadows 
- Vary the final weeks' burndown meeting times
- Work to maximize asynchronous communications and reduce face to face meetings to where absolutely required. 
- Time sacrifices may be necessary at times and the Release Team Lead should endeavor to spread this so as not to focus any inconvenience on specific individuals or specific geographies, for example considering major global holidays and KubeCons when planning the release timeline while also making sure the project is correctly moving forward.

Please lead by example and encourage everyone to work within their working hours as much as possible.

## Choosing a Release Team

One of your first and definitely most important duties as Release Lead is to ensure a Release Team is in place.

Release Team selection should happen in accordance with the [Release Team selection process][selection].

## Standards

- The GitHub repository layout is:
  - kubernetes/sig-release
    - releases/release-x.y
      - README.md (release schedule)
      - release-notes-draft.md (consumed by the automated release process)
      - release_team.md
- Short links are handled with [http://bit.ly](http://bit.ly). Each release should have the following documents (replacing XYY with the release version number minus dots):
  - Retro doc: `http://bit.ly/k8sXYYretro`
  - Release Schedule overview: `http://bit.ly/k8sXYY-release-info`
  - Zoom link: `http://bit.ly/k8sXYY-zoom`
  - Burndown/Meeting Minutes: `http://bit.ly/k8sXYY-burndown`
  - Enhancements tracking spreadsheet: `http://bit.ly/k8sXYY-enhancement-tracking`
  - Merged PRs with release notes: `http://bit.ly/k8sXYY-relnotes`
  - Use the same conventions for additional documents
- Burndown meetings happen at 10AM Pacific Time, and you invite the and the Kubernetes Release calendar (`agst.us_b07popf7t4avmt4km7eq5tk5ao@group.calendar.google.com`) to them.
- Burndown communications happen on the [kubernetes-sig-release] mailing list.
- Enhancement exceptions are to be reviewed by the owning SIG and brought to the Release Team for assessment of risk, especially across the project
- General notification regarding the release should go to the [kubernetes-dev] and [kubernetes-sig-leads] lists, and this should automatically be captured into the [Kubernetes Discourse site][discourse].
- All issues and PRs in the milestone are considered [release-blocking] until proven otherwise by the owning SIG.
  - Issues and PRs are added to the milestone by members of the milestone-maintainers GitHub team, which primarily includes SIG leads. Review the [milestone-maintainers] page for full criteria for membership to that team. The Release Team Lead is responsible for adding certain members of the Release Team to the group, and should check with and prune prior Release Team members who are no longer active.
  - Members of the Release Team should not be the primary contributors making the choice whether issues and PRs are in a milestone. This is the job of SIG Leads. However, the Release Team may apply milestones when doing housekeeping on tracked issues and PRs where the milestone label has clearly been forgotten.
- The Release Team Lead is responsible for updating the [burndown template] ahead of the release (changing the milestone in links and anything else requested during the retrospective)
- Release theme: There is no particular reason for this other than to have fun, and possibly provide a theme for Release Team gifts. As Release Team Lead, you get to pick a theme for the release. Release themes can be browsed over [k/sig-release/releases/release-v1.XX](https://github.com/kubernetes/sig-release/tree/master/releases).

### Mailing List Standards

Important communications and discussions should be posted in the Release Team
mailing list [kubernetes-release-team].

This list is owned by SIG Release and as such the SIG Release Chairs are owners
of it.
While SIG Release leads are owners of this list, the Release Team Lead and
Release Team Lead shadows will serve as managers of the list for the duration of the cycle.

The Release Team Lead and Release Team Lead shadows should periodically go through
the Release Team mailing list and prune members from the last release who are
no longer part of the Release Team.
This should be done after shadows for the new release cycle have been chosen
but before sending invites to the new members.

The membership criteria is as follows:
* All members of the Release Team must be part of the mailing list
* All members of the [Branch Management Team](https://github.com/kubernetes/sig-release/blob/master/release-managers.md#branch-managers)
  must be part of the mailing list
* SIG Release Chairs must be part of the mailing list

## Release theme gifts

You cannot start too early on this!

Once you have a release theme, there is a budget for you to create a release team gift as a thank you for each of your hard working team members.
This gift traditionally has been a t-shirt with a fun design of your choice and creation that relates to the release theme. Email [projects@cncf.io](mailto:projects@cncf.io) to kick the process off once you have a design and a list of all the t-shirt sizes required. The CNCF can also provide stickers of the release theme/logo, if explicitly requested.

## Code Freeze
With code exception in effect, you will likely have to assemble decision makers on specific pending PRs to assess whether the risk of inclusion is acceptable or not. Remember this is not you making a decision, it’s you helping SIGs follow the process, and ensuring there’s consensus. In the event of a contentious PR, you should err on the side of risk aversion. In extreme cases, you can defer to the steering committee, but that is extremely unlikely.

Depending on the number of exceptions code freeze will be a **very busy time**. 

**With Code Freeze in effect**
- Clear milestones and labels from feature PRs in k/k
- Wait for exception requests and bring them to `#sig-release`
- Update exception requests in the enhancements project board view `Code Freeze exceptions`
- Broadly discuss exception requests in the community

**To triage a single exception request follow the following guidelines:**
1. Open a slack thread in `#sig-release` to open the discussion. 
Example message:

```md
`@exception-request-author` filed an exception request for [KEP: `name-of-the-kep`](`https://github.com/kubernetes/enhancements/issues/XXX`). This thread is intended for the discussion of this request ([criteria](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md#exception-criteria)). PRs: [`PR-NUMBER`](`https://github.com/kubernetes/kubernetes/pull/PR-NUMBER`)
cc @release-team-leads
```

2. Collect input from responsible sig-leads and require ask for a green light (if multiple sigs are involved reach out to all!)
3. Approved exception requests must be merged prior to the rc.0 cut; therefore, do not extend the deadline for an exception request if its after the rc.0 cut!
4. Give enough time to get consensus
5. If the exception request got accepted add milestone and labels back to the KEP and related PRs
6. Communicate your decision and explain it thoroughly

## Working with the Release Team Calendar

To get access to the [release team calendar](https://calendar.google.com/calendar/embed?src=kipmnllvl17vl9m98jen6ujcrs%40group.calendar.google.com) reach out to a SIG Release tech lead or chair.
Its useful to add major events of the release cycle to the calendar e.g. Enhancements Freeze, Code Freeze and Test Freeze.

**Additional tips:**    
- Add a calendar entry for the time period before Enhancements Freeze with the title [1.xx] Enhancements Freeze coming on HH:mm PDT Month Day, Year
- When creating Google calendar entries, delete the Google Meet link which is created by default
- Be aware of the time zone when creating Google calendar entries as it will default to the last time zone used to create the last calendar entry
- If you get the "Message blocked" response after creating a calendar invitation, don't worry the invitation will be sent anyway. The reason why this message is generated is various, for example, the change of employers, the change of company DNS can lead to this.
- You can use [everytimezone.com](https://everytimezone.com/) or a similar tool to communicate deadlines easier

---

## Release Team Meeting Host Playbook

Release Team meetings are held to coordinate and discuss release-related activities. The Release Lead and Lead Shadows host Release Team meetings throughout the release cycle.
The following playbook can be used for reference to structure the meeting, you don't need to stick step by step (word by word), it should give guidance how a meeting usually is structured. 

### Requirements to host the meeting as Release Team Lead / Lead Shadow
1. Install Zoom and check your settings (especially the audio)
2. Make sure to get the **host key** from the Emeritus Adviser or Release Lead , otherwise you wont be able to claim host share the screen and start the recording

### Pre-Meeting
1. Add a new blank agenda entry to the meeting notes by copying the template and editing the details accordingly.
2. Announce the release team meeting about an hour before in the sig-release slack channel.

```txt
Hi folks! The release meeting takes place 1 hour from now
Links:
* Agenda & Minutes: https://bit.ly/k8s125-releasemtg
* Zoom Link: https://zoom.us/j/406805785?pwd=elQ1aVc0THZ, passcode 77777

If anyone has anything they’d like to discuss, please add to the notes.
```

### Pre-Recording
1. *Slack reminder (thread)* **"The meeting start now!"**
2. *join the meeting*
3. *turn on the camera*
4. *say hello to everyone* **"Hello all, let's wait a few minutes for everyone to join"**
5. *post the meeting notes to the meeting chat* 
6. *claim host* (you can claim host by opening the attendees window and clicking claim host and inserting the host key)

***wait until 3 minutes past***

7. *post the meeting notes link to the meeting chat* **"I posted the meeting notes link to chat, please add yourself to the attendees list, thank you!"**
8. **"Since it is now 3 minutes past, we will get started"**
9. **"If you rather not get recorded, you can now turn off your video"**
10. *open meeting notes and share screen* (NOTE: on Linux you might need to share the entire screen, a single window does not work sometimes)

### During-Recording
1. *start recording* record to the cloud, the automation will 'automagically' upload the recording to YouTube.
2. *say hello to everyone* **"Hello everyone, my name is 'Alice' and I will be the host for this Kubernetes 'X.XX' release team meeting. Today is 'May' the '4th' and we are in week 'X' of the release cycle.**
3. *code of conduct* **"Please be aware that this is a Kubernetes community meeting which falls under the Kubernetes code of conduct, which can be summarized to be excellent to each other, thank you all!"** 
4. *recording warning* **"This meeting is recorded and will be publicly posted to YouTube so please be mindful what you say is being recorded."**
5. *open discussion items*: If something is on the list, you can read it out loud and wait for the person to respond. If there is nothing on the open discussion list, you can say something like: **"There is nothing in the open discussion section in the meeting notes. Is there anything to discuss before we get into the team updates?"** wait a few seconds - **"Okay, let's move on"** 
6. *team updates*: **"Lets start with the team updates"** Call the person giving the update and wait for the update. Ask if there are any comments or questions for the team. If no one from the team gives the update, then you can review the last update given in a previous meeting, read it aloud, and then move to the next team. 

### Post-Recording
1. *Off record discussions* **"I stopped the recording, is there anything you like to discuss off record?"** wait a few seconds
2. *Thank all for joining the meeting* **"Thank you all again for joining the meeting, see you in the next one!"**

---

[discourse]: https://discuss.kubernetes.io/
[kubernetes-release-team]: https://groups.google.com/a/kubernetes.io/g/release-team
[kubernetes-sig-release]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[kubernetes-sig-leads]: https://groups.google.com/a/kubernetes.io/g/leads
[kubernetes-dev]: https://groups.google.com/a/kubernetes.io/g/dev
[lead-criteria]: /release-team/release-team-selection.md#release-team-lead
[milestone-maintainers]: /release-team/README.md#milestone-maintainers
[release-blocking]: /release-blocking-jobs.md
[rtl-onboarding]: https://github.com/kubernetes/sig-release/issues/new?assignees=&labels=sig%2Frelease%2C+area%2Frelease-eng%2C+area%2Frelease-team&template=release-team-lead-progress.md&title=[1.XX]+Release+Team+Lead+Cycle+Progress

[selection]: /release-team/release-team-selection.md
