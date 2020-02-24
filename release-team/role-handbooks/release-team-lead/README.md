# Release Team Lead <!-- omit in toc -->

## Overview <!-- omit in toc -->

The release team leader role is responsible for coordinating release activities, assembling the release team, taking ultimate accountability for all release tasks to be completed on time, and ensuring that a retrospective happens. The lead is also responsible for ensuring a successor is selected and trained for future release cycles.

- [Authority and Responsibility](#authority-and-responsibility)
- [Prerequisites](#prerequisites)
- [Skills and Experience Required](#skills-and-experience-required)
- [Time Commitments](#time-commitments)
- [Choosing a Release Team](#choosing-a-release-team)
- [Standards](#standards)
- [Release Milestone Activities](#release-milestone-activities)
  - [Before Release Begins](#before-release-begins)
  - [Week 1](#week-1)
    - [Starting the release cycle](#starting-the-release-cycle)
  - [Week 2](#week-2)
  - [Week 3](#week-3)
  - [Week 4](#week-4)
  - [Week 5](#week-5)
- [Release Halfway Point](#release-halfway-point)
  - [Week 6](#week-6)
  - [Week 7](#week-7)
    - [Code Freeze Day](#code-freeze-day)
  - [Week 8](#week-8)
  - [Week 9](#week-9)
  - [Week 10](#week-10)
  - [Week 11](#week-11)
- [Release Day](#release-day)
  - [Week 12](#week-12)
  - [Week 13](#week-13)
  - [Week 14](#week-14)

## Authority and Responsibility

The Release Team Lead should be an arbiter of decisions, and not the primary decision-maker. A lead should constantly search for the best-qualified people or SIGs to guide the decision, not "go it alone", unless it is a very specific concern within the release process itself. When decisions are made they must be weighted in favor of community concerns over those of individuals or specific companies. Leads must also relinquish any favoritism for the company they work for. If there is a conflict of interest, the lead must recuse themselves from that decision. Above all, the release lead is a servant leader to the team and the community.

## Prerequisites

**Before we can grant access to new Release Team Leads, a [Release Team Lead onboarding issue][rtl-onboarding] _MUST_ be opened in this repo. Please take a moment to do that before executing the tasks contained in this handbook.**

## Skills and Experience Required

This role requires a tremendous amount of experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process.

In addition to the [Release Team Lead selection criteria][lead-criteria] you are required to fulfill, there are some additional aspirations we have for a Release Team Lead.

- The Release Team is a global volunteer group, as is the Kubernetes project, so the Lead must be prepared to schedule and attend meetings that may be very late or very early in his or her time zone, in order to include as many of the team as possible.
- Project management experience is highly desirable
- Strong written and verbal communications skills are required
- As the public face of the community during release time, you must do so with a very high level of professionalism
- Prior experience in release management is extremely helpful

## Time Commitments

Release Lead is a very time-consuming role, especially towards the end of the release cycle. Before you volunteer to be Release Lead, please make certain that your employer and your family are okay with you spending a lot of time on the release for the next three months. Here's a rough estimate of the time requirements by week:

- Weeks 1-4: 4-8 hours a week
- Weeks 5-8: 6-12 hours a week
- Weeks 9-13: 10 to 25 hours a week
- Release Day: Prepare to spend all day on release-related activities. Given the choice between working after-hours or weekends, and having the release be later than the initial target, delaying the release is preferred.

Among the specific time commitments you have are:

- SIG-Release and Release Team meetings once a week during weeks 1-7.
- Burndown meetings three to five times a week during weeks 8-12.
- Community meetings once a week.

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
- Burndown meetings happen at 10AM Pacific Time, and you invite the community calendar (`cgnt364vd8s86hr2phapfjc6uk@group.calendar.google.com`) and the Kubernetes Release calendar (`agst.us_b07popf7t4avmt4km7eq5tk5ao@group.calendar.google.com`) to them.
- Burndown communications happen on the [kubernetes-sig-release] mailing list.
- Enhancement exceptions are to be reviewed by the owning SIG and brought to the Release Team for assessment of risk, especially across the project
- General notification regarding the release should go to the [kubernetes-dev] and [kubernetes-sig-leads] lists, and this should automatically be captured into the [Kubernetes Discourse site][discourse].
- All issues and PRs in the milestone are considered [release-blocking] until proven otherwise by the owning SIG.
  - Issues and PRs are added to the milestone by members of the milestone-maintainers GitHub team, which primarily includes SIG leads. Review the [milestone-maintainers] page for full criteria for membership to that team. The Release Team Lead is responsible for adding certain members of the Release Team to the group, and should check with and prune prior Release Team members who are no longer active.
  - Members of the Release Team should not be the primary contributors making the choice whether issues and PRs are in a milestone. This is the job of SIG Leads. However, the Release Team may apply milestones when doing housekeeping on tracked issues and PRs where the milestone label has clearly been forgotten.
- The Release Team Lead is responsible for updating the [burndown template] ahead of the release (changing the milestone in links and anything else requested during the retrospective)
- Release theme: There is no particular reason for this other than to have fun, and possibly provide a theme for Release Team gifts. As Release Team Lead, you get to pick a theme for the release.
  - Kubernetes 1.8 to 1.10, had unofficial food-based code names.
    - 1.8 - "Burrito"
    - 1.9 - "Pumpkin"
    - 1.10 - "Kiwi"
  - Kubernetes 1.10 had a late change to "Left Shark".
  - Kubernetes 1.11 had a Tolkien theme of "Eleventy-One: A Long-Expected Release"
  - Kubernetes 1.12: Game of Life
  - Kubernetes 1.13: Angel Release
  - Kubernetes 1.14: Caturnetes
  - Kubernetes 1.15: Game of Release/Thrones
  - Kubernetes 1.16: Unlimited Breadsticks For All
  - Kubernetes 1.17: The Chillest Release - Capynetes

## Release theme gifts

You cannot start too early on this!

Once you have a release theme, there is a budget for you to create a release team gift as a thank you for each of your hard working team members.
This gift can be a T-shirt, or a badge, but can be anything customizable within the budget, with a fun design of your choice and creation that relates to the release theme.
Coordinate with SIG-Release Chairs (who have access to the CNCF Service Desk as well as know the budget) to put in an order, and make sure everyone gets their release swag gift.

## Release Milestone Activities

### Before Release Begins

- Attend previous release retro to capture feedback and incorporate it into next release cycle
- Plan release schedule and milestones. Gather feedback as needed.
- Make sure you have your shadows confirmed
- Make sure everyone joining the team reads the [release team onboarding document][release-team-onboarding].
- Complete a [Release Team Lead onboarding issue][rtl-onboarding] for the Lead and RT Lead Shadows

### Week 1

**While the Release Team Lead has always been a stakeholder in getting security fixes out the door, the Kubernetes security disclosures and response policy has evolved into something more formal. The documents linked below are required reading for an incoming Release Team Lead, who must understand and abide by the embargo policy.**

- [Security Release Process][security-release-process]
- [Private distributors and Embargo Policy][private-distributors-list]

#### Starting the release cycle

- Ensure the release team is fully filled, with members subscribed to the [kubernetes-release-team] and [kubernetes-sig-release] groups.
- Create an internal contact sheet and corresponding bit.ly link. Make sure to
  only give access to the [kubernetes-release-team]. Communicate with section
  leads to add their shadows so that you and your shadows can add them to the
  [kubernetes-release-team].
- Ensure top-level OWNERS_ALIASES only includes Release Team personnel from four (4) releases, including the current one.
- Create and finalize the release schedule, blocking test gates, and role assignments as a pull request in: kubernetes/sig-release/releases/release-x.y/README.md **Note: Do not ship the release on a Monday, to avoid preparing for the release on a weekend. Aim for Tuesday.**
- Send an update to [kubernetes-dev] and [kubernetes-sig-leads] mailing list to announce the start of the release cycle, including any notable changes in the release process, key dates, and links to important documents
- Create the retrospective document and corresponding bit.ly link
- Begin meeting with SIGs to introduce yourself
- Begin paying attention to [CI signal][ci-signal], as it may begin degrading soon after the prior release is cut and any slips must be caught and rectified promptly.
- Request, in coordination with CI Signal Lead, a representative from SIG-Scalability to give a weekly update on the release meeting notes. Prepare to have a release team representative attend SIG-scalability's meeting two or three times throughout the release.
- Meet your Shadows and create a communication channel with them. Establish expectations and share out work - delegate!
- Request review of this document by the Release Team Lead shadow(s). The shadow(s) should also take all actions in this document around joining groups and requesting access permissions.

### Week 2

- Assist the Enhancements Lead in collecting planned work from SIGs
- Schedule weekly Release Team meetings on a day that is most acceptable to the team. These will eventually turn into burndown meetings and occur daily. Invite the [kubernetes-sig-release] group.
- Poll Release Team membership and schedule a weekly alternate meeting to better enable more attendance outside of the Americas.
- Add key event dates to the [Kubernetes Release Calendar][kubernetes-release-calendar] during the cycle. Ensure major calendar events are set to send an email reminder one week in advance.
- Begin reporting release status at the community meeting
- Continue meeting with SIGs for introductions


### Week 3

- Create the release notes draft file in the release directory per the standard above
- Prepare for x.y.0-alpha.0 "release", specifically that there is a [Branch Manager][branch-manager] available to support the team, and that master-blocking tests are all green. The alpha.0 artifacts were created already as a part of the prior release. This synthetic notation is a point to review process with the [Branch Manager][branch-manager].
- Identify any other dependent ecosystem projects that need release coordination
- Announce/email that the following week is Enhancements Freeze and what that means

### Week 4

- Assist the Enhancements Lead with anything required for Enhancements Freeze
- Remind the community about Enhancements Freeze
- Make sure everything is in synch between the [enhancements repo][k/enhancements] and the enhancements tracking spreadsheet
- If there are enhancements with questions or concerns, help coordinate those conversations between the team and the SIG/owners
- Start collecting SIG release themes in the release notes draft, outlining what they are delivering this release milestone, and how it aligns with their mission statements - start with SIGs identifying enhancements in the enhancements repo, and focus on those since not every SIG will be delivering something

### Week 5

- Prepare for x.y.0-alpha.1 release ensuring that master-blocking tests are all green
- Bring exceptions to the Release Team meetings, and make sure SIG representatives for the exception(s) know to attend and discuss if necessary
- Check in with docs team on release notes progress
- Follow up with SIGs on release themes
- Begin casual observation of [issues](https://git.k8s.io/sig-release/release-team/role-handbooks/bug-triage/README.md), CI signal, test flakes, and critical PRs

---

## Release Halfway Point

### Week 6

- Continue reviewing enhancement exceptions as needed
- Release themes should be completed by now
- Exception requests should be almost zero
- Check in with SIGs on their enhancement work to make sure they know Code Freeze is 3 weeks away, as well as emailing the [kubernetes-dev] list, and notifying the community at the weekly meeting
- Adjust the enhancements repo/tracking spreadsheet as necessary (this may also require modifying themes that can’t be delivered)
- Remind Branch Manager that branch CI jobs will be needed next week.

### Week 7

- Coordinate x.y.0-beta.0 release, ensuring master-blocking are 100% green if possible (this release is not an official beta, just an artifact of the release process), and any flakes are being actively worked by SIGs since this is a chance to look at CI signal. The release-x.y branch is created automatically as a part of the beta.0 release. The Branch Manager now begins daily fast-forwards.
- The burndown templates should be useful at this point since it starts asking about status relevant to each area now tracking (e.g. branch health, docs, communications, issues, etc.)
- Branch Manager has release branch CI created and added to Testgrid
- Most enhancement-oriented tasks should be completed at the end of this week
- SIGs that have not completed release themes should be contacted again, with a focus on explaining why this matters to the community
- Ping role leads reminding them to start considering succession plans. If they are handing the role off to a successor, identifying them early gives more time for the committed volunteer to get targeted mentoring.

#### Code Freeze Day

Code Freeze will typically fall around Weeks 8 or 9 depending on the length or release cycle.  As Code Freeze approaches here are some good practices

- Monitor the enhancements spreadsheet to get an idea of how many PRs are still outstanding leading up to Code Freeze
- Send a reminder email to [kubernetes-dev]
- Monitor [Testgrid] and [Prow] to understand the stability of the release and PRs getting ready to merge. If Prow and Test grid are not in a good state consult folks from SIG Testing on delaying code freeze by a day if needed.  
- LGTM / Approve and remove the hold on the PR for enabling code freeze. [Example from 1.15 here](https://github.com/kubernetes/test-infra/pull/12808)
- As needed, assist the Bug Triage Lead and Enhancements Lead removing PRs and enhancements from the milestone that aren't merged in time

### Week 8

- The code exception process is now in effect, meaning you will likely have to assemble decision makers on specific pending PRs to assess whether the risk of inclusion is acceptable or not. Remember this is not you making a decision, it’s you helping SIGs follow the process, and ensuring there’s consensus. In the event of a contentious PR, you should err on the side of risk aversion. In extreme cases, you can defer to the steering committee, but that is extremely unlikely.
- If the release branch is not healthy, stable, and passing tests consistently, notify community through standard channels of need to rectify or code freeze will come early to force focus on stabilization.

### Week 9

- Branch Manager ensures automation is ready to enforce labeling and other release policies
- The once-weekly release meeting schedule now shifts to M, W, F and becomes burndown-specific (the template should be used from here forward and will need to be updated ahead of the meeting, which takes about 10 minutes for the lead, and less for the other team members)
- Make sure everyone knows the Docs deadline (PRs ready for review) is coming the following Friday.
- Prepare for x.y.0-beta.1 release (week 10), ensuring x.y-blocking, master-blocking are 100% green, or all failures have issues filed and are being actively worked.  

### Week 10

- Code Freeze begins, and it’s now the home stretch of the release. SIGs will need to ensure all work moving forward is carefully curated with [required merge labels][merge-labels].
- Branch Manager ensures automation is actively enforcing merge blocking labeling and other release policies
- The Release Team needs to look at any in-flight PRs and ensure nothing is being jammed in at the last minute without proper tests, review, etc. This is something to watch extremely closely because it happens every release. Just watch what gets merged closely after Code Freeze. Incorrectly merged items need assessed and perhaps reverted. GitHub has a [query comparing a release branch and master](https://github.com/kubernetes/kubernetes/compare/release-1.15).
- Assist the Documentation Leads in collecting missing docs PRs.
- Schedule burndown meetings starting next week for every weekday until the Friday after release day. Make sure to invite the community calendar (`cgnt364vd8s86hr2phapfjc6uk@group.calendar.google.com`) and the Kubernetes Release calendar (`agst.us_b07popf7t4avmt4km7eq5tk5ao@group.calendar.google.com`).
- Release notes and themes should be close to done if not completed. There is a script that gathers notes from PRs but it’s still in progress. As the lead, you may need to help assemble the notes.
- Identify potential vacancies on the incoming Release Team and begin asking team shadows and former team shadows to serve as Lead in the upcoming cycle. Continue to improve and uphold the [Release Team Selection][selection] process.
- Prepare for x.y.0-beta.2 release (week 11), ensuring x.y-blocking, master-blocking are 100% green.  

### Week 11

- Begin daily burndown meetings
- If the release branch, master branch and associated tests are stable, it’s time to lift code freeze. The bot will need to be updated.
- The Branch Manager will perform one final branch fast-forward - make sure everything pending has been merged beforehand
- Master branch is then opened for new pull requests on x.y (the next release). Remaining release activities will happen on the release-x.y branch via cherry picks from master.
- Use all of the appropriate communications channels to announce the lifting of Code Freeze
- The task is now to ensure the release branch is ready to go. This means there are zero pending PRs, no failing x.y-blocking tests, no open issues in the milestone. This will continue until release day.
- Final documentation PRs are reviewed and ready to be merged. Likely, this is not true and some are outstanding, so you need to help convince SIG doc writers to get these in with urgency.
- The release notes draft needs to be completely done and ready to consume by anago. Have SIG volunteers do a final proofread of their sections. Make sure people actually do this. You need to avoid having the release notes volunteers pull “all nighters” before the release.
- Work with the CNCF, SIG PM, SIG Docs, and Communications Lead to start the Release Blog post pulling from SIG Themes, the enhancements repo, SIG members, and possibly release notes in specific PRs.
- Work with the incoming Release Team Lead to establish incoming Release Team.
- Release Day is coming up! Make the day as fun as you can for the team. Plan ahead for this and do something nice.

---

## Release Day

### Week 12

- Note that release day can and should be postponed if any of the conditions outlined in week 11 are not satisfied.
- Every issue in the milestone is considered release blocking.
- If you have to push the release date back, try to avoid Friday since it makes release publicity extremely difficult. Also, people seem to have patience with delay as long as the reasons are clear and openly communicated. This is your duty. You must over-communicate and ensure the team is also talking to their stakeholders (CNCF, community, press, etc.)
- Confirm a facilitator for the Release Retrospective with SIG PM
- The following final actions **must occur in order**, with successful completion of each being the entry criteria to the next.
  - Release day morning:
    - Go / No-Go: should generally be clear a day or three ahead of release, but the day's burndown provides a final opportunity for the team to affirm things are ready.
    - Release Notes Lead PRs final draft release notes to sig-release, with Release Team Lead approving merge.
    - Branch Manager does mock release build.
    - Branch Manager does mock publication. Validates with Release Team lead and broader team the mock announcement email content.
    - Branch Manager does nomock release build.
  - Starting when ready:
    - Communications Lead begins staging blog post.
    - Branch Manager Lead does nomock publication.
    - Branch Manager coordinates the building and publishing of rpm/deb packages with [Build Admins][build-admins].
    - Build Admins affirms build is complete.
    - Docs Lead publishes release docs to website.
    - Branch Manager does release-notify.
  - Approximately 5pm Pacific: all work is complete and the release team
    lead announces release to k-dev, SIG Leads lists, and discuss.k8s.io.

### Week 13

- Release Retrospective participation
- Follow-up interviews with the media, the media roundtable
- Contact the [Release Managers Google Group][release-managers-group] to complete the Release Team Lead & Lead Shadows offboarding tasks from the previously-opened onboarding issue

### Week 14

- Help fill any open positions for the next release milestone

[branch-manager]: /release-managers.md#branch-managers
[build-admins]: /release-managers.md#build-admins
[burndown-template]: https://docs.google.com/document/d/1zLnmDDOp_ko9Yh5uPJtgqPFD7GKq76fQsKaenXoMHzM/edit
[ci-signal]: /release-team/role-handbooks/ci-signal/README.md
[discourse]: https://discuss.kubernetes.io/
[k/enhancements]: https://git.k8s.io/enhancements
[kubernetes-release-calendar]: https://bit.ly/k8s-release-cal
[kubernetes-release-team]: https://groups.google.com/forum/#!forum/kubernetes-release-team
[kubernetes-sig-release]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[kubernetes-sig-leads]: https://groups.google.com/forum/#!forum/kubernetes-sig-leads
[kubernetes-dev]: https://groups.google.com/forum/#!forum/kubernetes-dev
[lead-criteria]: /release-team/release-team-selection.md#release-team-lead
[merge-labels]: https://git.k8s.io/community/contributors/devel/sig-release/release.md#tldr
[milestone-maintainers]: /release-team/README.md#milestone-maintainers
[onboarding]: /release-team/release-team-onboarding.md
[private-distributors-list]: https://github.com/kubernetes/security/blob/master/private-distributors-list.md
[Prow]: https://prow.k8s.io/
[release-blocking]: /release-blocking-jobs.md
[release-managers-group]: https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers
[rtl-onboarding]: https://github.com/kubernetes/sig-release/issues/new?labels=sig%2Frelease%2C+area%2Frelease-eng%2C+area%2Frelease-team&template=release-team-lead.md&title=Release+Team+Lead+access+for+%3CGH-handle%3E
[security-release-process]: https://github.com/kubernetes/security/blob/master/security-release-process.md
[selection]: /release-team/release-team-selection.md
[Testgrid]: https://testgrid.k8s.io/
[release-team-onboarding]: /release-team/release-team-onboarding.md
