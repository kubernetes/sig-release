---
name: Release Team Lead Cycle Progress
about: Used to track release lead work which needs to be done every release cycle 
title: '[1.XX] Release Team Lead Cycle Progress'
labels: sig/release, area/release-eng, area/release-team
---

<!--
This template is used for tracking tasks that the Release Team Lead and Lead Shadows needs to do in a release cycle.

The issue should be kept open for the entirety of the release cycle, until all tasks are completed.
-->

* Release Team Leads
  * Release Lead: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
* Release Cycle: `Kubernetes 1.XX`
* [Release Timeline](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.XX) <!-- DON'T FORGET TO UPDATE THE LINK -->

Additional information can be found in the [release team lead handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead). If tasks are not needed to be done or additional tasks are required, make sure to update the issue template!

## Release Lead tasks

### 1. Before the start of the Release Cycle (Week 0)

- [ ] Captured feedback from previous release cycle retro and planned to incorporate it into the release cycle
- [ ] Release directory named `release-1.XX` added to [k/sig-release/releases](https://github.com/kubernetes/sig-release/tree/master/releases)
- [ ] Started planning the release schedule by opening a thread in `#sig-release`
- [ ] Release Lead Shadows are confirmed
- [ ] Team leads notified that all release team members read the [release team onboarding document](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md)
- [ ] Update slack channel descriptions for the `#sig-release` channel and all `#release-xxx` channels

**Release Lead Onboarding:**
- [ ] Release Team Lead has agreed to abide by the guidelines set forth in the
  [Security Release Process](https://git.k8s.io/security/security-release-process.md), specifically the embargo on CVE communications.
  This must be done as an issue comment by the incoming Release Team Lead.
- [ ] Updated GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-team`
  - `release-team-leads`
  - `sig-release`
- [ ] Updated `kubernetes/sig-release` `OWNERS`
  - Release Team Lead and Shadows
    - Add an `approvers` entry in `releases/release-1.XX/OWNERS`
  - **Release Team Lead only**
    - In `OWNERS_ALIASES`, add an entry in the following sections:
      - `release-team`
      - `release-team-lead-role`
- [ ] Updated Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
  - `release-team@`
- [ ] Release Team calendar access granted (reach out to sig-release chairs)
- [ ] Zoom credentials (host key) granted (reach out to sig-release chairs)
- [ ] Added incoming release team leads to `release-team-leads` Slack Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
  - Add slack ID(s) to [`users.yaml`](https://git.k8s.io/community/communication/slack-config/users.yaml), if they are not yet in the file
  - Add username(s) to [`usergroups.yaml`](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
- [ ] Ensured SIG Release co-chairs replaced the outgoing Emeritus Advisor (EA) with the new EA as an owner of the [kubernetes-release-team-shadows](https://groups.google.com/a/kubernetes.io/g/release-team-shadows) Google Group.
- [ ] Ensured top-level `OWNERS_ALIASES` only includes Release Team personnel from four (4) releases, including the current one.

**Create Release Team Documents:**
- [ ] Meeting Notes document created
  - Access: public comment access, edit access [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Bit.ly: `bit.ly/k8s1XX-releasemtg`
  - Example: [1.26](https://bit.ly/k8s126-releasemtg)
- [ ] Retro document created
  - Access: public comment access, edit rights shared with [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Bit.ly: `bit.ly/k8s1XX-retro`
  - Example: [1.26](https://bit.ly/k8s126-retro)
- [ ] Release Team contact sheet created
  - Access: **restricted access** edit rights shared with [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Bit.ly: `bit.ly/k8s1XX-contacts`
- [ ] Lead rotation sheet created
  - Access: : **restricted access**, edit rights shared with release team lead shadows individually

**One week before the start of the release cycle:**
- [ ] "Release Sneak Peak" email to introduce yourself, lead shadows, role leads, and branch manager has been send out
  - Send the email to [k-dev](https://groups.google.com/a/kubernetes.io/g/dev), [SIG Leads](https://groups.google.com/a/kubernetes.io/g/leads), [SIG Release](https://groups.google.com/forum/#!forum/kubernetes-sig-release), [Release Team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Example: [1.26 sneak peek](https://groups.google.com/a/kubernetes.io/g/dev/c/PVe1OG8yjHw/m/zZjnttXWAQAJ)

### 2. First weeks of the release cycle up to Enhancements Freeze (1-3 Weeks)

**First Week of the release cycle:**
- [ ] Checked in with team leads and verified that the release team is complete
- [ ] Reminded release team members to subscribe to the [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team) and [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release) google groups and to the [kubernetes-release calendar](https://bit.ly/k8s-release-cal).
- [ ] Notified team leads to update the contact sheet with shadow information `bit.ly/k8s1XX-contacts`
- [ ] Release schedule finalized
- [ ] Begin paying attention to CI signal, as it may begin degrading soon after the prior release is cut and any slips must be caught and rectified promptly.
- [ ] Meet your Shadows and create a communication channel with them. Establish expectations and share out work - delegate!
- [ ] Request review of this document by the Release Team Lead shadow(s). The shadow(s) should also take all actions in this document around joining groups and requesting access permissions.
- [ ] Update the SIG Release groups in the `k/k8s.io/groups/sig-release/groups.yaml` with the following:
  - [ ] Add Lead and Lead shadows to members of `k8s-infra-release-viewers`
  - [ ] Add EA, Lead, Lead shadows, comms lead, comms shadows to members of `release-comms`
  - [ ] Add EA, Lead and Lead shadows to members of `release-managers`
  - [ ] Add EA, Lead and Lead shadows to managers of `release-team`
  - [ ] Add Role Leads and Role shadows to members of `release-team`
  - [ ] Add Role shadows and Lead shadows to members of `release-team-shadows`
  - [ ] Add EA to manager of release-team-shadows, if EA is owner of `release-team-shadows` already then add Lead to manager of `release-team-shadows`
  - [ ] Add Bug Triage Lead and shadows to `k8s-infra-rbac-triageparty-release`
- [ ] Ensured that there is a branch manager available for cutting 1.XX.0-alpha.1

- Assist the Enhancements Lead in collecting planned work from SIGs
- [ ] Discussed and scheduled a weekly Release Team meetings on a day that is most acceptable to the team. Invite the `kubernetes-sig-release` group.
- [ ] Poll Release Team membership and schedule a weekly alternate meeting to better enable more attendance outside of the Americas.
- [ ] Major release cycle events have been added to the Kubernetes Release Calendar with one week in advance reminders set. (defer to the [handbook for more information](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#working-with-the-release-team-calendar))
- [ ] Checked in with ci-signal and branch managers if 1.XX.0-alpha.2 is ok to be released and [master-blocking](https://testgrid.k8s.io/sig-release-master-blocking) tests are all green


**A week before Enhancements Freeze:**
- [ ] Remind the community about Enhancements Freeze reminder send out. Example email: [1.26](https://groups.google.com/a/kubernetes.io/g/dev/c/pJZC2cnkeJ8); It may also be useful to send a short version to the `#sig-release` and `#chairs-and-techleads` Slack channels referencing to the k-dev email.

### 3. Enhancements freeze up to Release Halfway Point (~Week 5 - 7)

**General Tasks:**
- Bring exceptions to the #sig-release Slack channel and to Release Team meetings, and make sure SIG representatives for the exception(s) know to attend and discuss if necessary.
- Begin casual observation of issues, CI signal, test flakes, and critical PRs
- [ ] Release Team Retro is scheduled shortly after the "Release Halfway Point" and a host is selected

**Release Cut Alpha 3:**
- [ ] Checked in with ci-signal and branch managers if 1.XX.0-alpha.3 is ok to be released and [master-blocking](https://testgrid.k8s.io/sig-release-master-blocking) tests are all green
- [ ] Checked in with Release Notes team on release notes progress after the tag for 1.XX.0-alpha.3 is generated

**Release Cut Alpha 4:**
- [ ] Checked in with ci-signal and branch managers if 1.XX.0-alpha.4 is ok to be released and [master-blocking](https://testgrid.k8s.io/sig-release-master-blocking) tests are all green
- [ ] Checked in with Release Notes team on release notes progress after the tag for 1.XX.0-alpha.4 is generated

### 4. Release Halfway Point up to Code Freeze (~Week 8 - 11)

**General Tasks:**
- [ ] Send out a "Release Update / State of the Release", example: [1.26](https://groups.google.com/a/kubernetes.io/g/dev/c/_nToVaHVN1Q)
- [ ] Notify SIGs and about upcoming Code Freeze Deadline by sending an email to the [kubernetes-dev](https://groups.google.com/a/kubernetes.io/g/dev) list
- [ ] The first retrospective meeting is scheduled for the first week of Monday, Wednesday, and Friday burndown meetings, typically mid-week. Confirm the Emeritus Adviser can serve as facilitator. If Emeritus Adviser is unavailable then defer the responsibility as appropriate.
- [ ] Make sure everyone knows the Docs deadline (PRs ready for review) is coming the following week.
- [ ] Started release team meetings on Monday, Wednesday, and Friday
- [ ] Pinged role leads reminding them to start considering succession plans. If they are handing the role off to a successor, identifying them early gives more time for the committed volunteer to get targeted mentoring.

**Removals, Deprecations, and Major Changes Blog:**
- [ ] Check in with release-comms if they are in contact with the release-enhancements team to collect "deprecations and removals" targeting the release
- [ ] Identified with release-comms & sig-docs if a "Removals, Deprecations, and Major Changes" blog is needed and if so, started drafting it up (ref [1.26 blog](https://kubernetes.io/blog/2022/11/18/upcoming-changes-in-kubernetes-1-26/))
- [ ] A Release Team representative (ideally from release-comms) should attend the sig-docs meeting to raise awareness about the "Deprecations and Removals blog" for reviews.
- [ ] The Deprecations and Removals blog is scheduled for next week shortly after Code Freeze. A draft of the blog should be started as reviews and iterations will be needed before publication next week
- [ ] Insured that "Removals, Deprecations, and Major Changes"-authors are reviewing the blog before it's being publicized 

**Major Themes & Release Blog:**
- [ ] Followed up with SIGs on major themes of the release
- [ ] Checked in with release-notes and release-comms about the status of major themes collection

### 5. Around Code Freeze (~Week 13)
Defer to the [code freeze section](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#standards) in the release-team-lead handbook.

#### Shortly before Code freeze
Code Freeze begins, and it’s now the home stretch of the release. SIGs will need to ensure all work moving forward is carefully curated with required merge labels.

- Monitor the enhancements GitHub project to get an idea of how many PRs are still outstanding leading up to Code Freeze
- Monitor Testgrid and Prow to understand the stability of the release and PRs getting ready to merge. If Prow and Test grid are not in a good state consult folks from SIG Testing on delaying code freeze by a day if needed.
- If the release branch is not healthy, stable, and passing tests consistently, notify community through standard channels of need to rectify or code freeze will come early to force focus on stabilization.
- [ ] Reminded the Branch Manager that branch CI jobs will be needed next week
- [ ] Send out a reminder email to [kubernetes-dev](https://groups.google.com/a/kubernetes.io/g/dev)

#### With Code Freeze
- As needed, assist the Bug Triage Lead and Enhancements Lead removing PRs and enhancements from the milestone that aren't merged in time `/milestone clear`

#### After Code Freeze
- [ ] Verified that the [`release-1.XX` branch](https://github.com/kubernetes/kubernetes/branches) has been automatically created at the start of Test Freeze
- [ ] Verified that the Branch Manager created the CI board on [Testgrid](https://testgrid.k8s.io/sig-release) for the release cycle (1.XX-blocking & 1.XX-informing)
- [ ] Published the "Removals, Deprecations, and Major Changes blog"

### 6. Test Freeze up to Release Day (~Week 14)
- [ ] Verified together with the release-docs team that all KEPs with required documentation are ready for review
- [ ] Completed release theme (slogan, logo and explanation text) and add it to the [release cycle documentation in k/sig-release/releases/release-1.XX](https://github.com/kubernetes/sig-release/tree/master/releases)
- [ ] Decided with the Release team if burndown meetings are necessary or updates are done via Slack thread on Tuesdays and Thursdays
- [ ] Discussed Release Lead succession with the EA and sig-release leads
- [ ] Remind team lead to find successors for the upcoming cycle and discuss candidates with the EA
- [ ] The task is now to ensure the release branch is ready to go. This means there are zero pending PRs, no failing 1.XX-blocking tests, no open issues in the milestone. This will continue until release day.
- [ ] Final documentation PRs are reviewed and ready to be merged. Likely, this is not true and some are outstanding, so you need to help convince SIG doc writers to get these in with urgency.
- [ ] Planned something for Release Day. Make the day as fun as you can for the team. Plan ahead for this and do something nice
- [ ] Prepared [Release Team gifts](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#release-theme-gifts)
- [ ] The Communications Lead contacts CNCF to gauge media interest, schedule the CNCF Kubernetes release workshop, and publish the release blog post. Stay in the loop for that. If there is media interest in the release, an interview between the journalist will be organized by the CNCF.
- [ ] Check in with the docs lead and verify tasks that should happen before the release day are completed (ref [release-docs handbook](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/docs/Release-Timeline.md#release-week-week-12))
- [ ] The Release Team Retro part 2 and part 3 is scheduled shortly after the "Release Halfway Point" and a host / facilitator is available
- [ ] Remind the release team to add items to the retro meeting agenda

### 7. Release Day (~Week 15)

- Note that release day can and should be postponed if any of the conditions outlined in week 11 are not satisfied.
- Every issue in the milestone is considered release blocking
- If you have to push the release date back, try to avoid Friday since it makes release publicity extremely difficult. Also, people seem to have patience with delay as long as the reasons are clear and openly communicated. This is your duty. You must over-communicate and ensure the team is also talking to their stakeholders (CNCF, community, press, etc.)

- The following final actions **must occur in order**, with successful completion of each being the entry criteria to the next.
  - Release day morning:
    - [ ] Go / No-Go: should generally be clear a day or three ahead of release, but the day's burndown provides a final opportunity for the team to affirm things are ready.
    - [ ] Release Notes Lead PRs final draft release notes to sig-release, with Release Team Lead approving merge.
    - [ ] Branch Manager does mock release build.
    - [ ] Branch Manager does mock publication. Validates with Release Team lead and broader team the mock announcement email content.
    - [ ] Branch Manager does nomock release build.
  - Starting when ready:
    - [ ] Communications Lead begins staging blog post.
    - [ ] Branch Manager Lead does nomock publication.
    - [ ] Branch Manager coordinates the building and publishing of rpm/deb packages with Google Build Admins.
    - [ ] Build Admins affirms build is complete.
    - [ ] Verify with the docs lead that the staging release website is in correct shape by verifying the blog posts, the release page, download page, etc.
    - [ ] Docs Lead publishes release docs to website (ref [tasks todo](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/docs/Release-Timeline.md#release-week-week-12))
    - [ ] Branch Manager does release-notify.
  - [ ] Approximately 5pm Pacific: all work is complete and the release team
    lead announces release to [k-dev](https://groups.google.com/a/kubernetes.io/g/dev), [SIG Leads](https://groups.google.com/a/kubernetes.io/g/leads), and discuss.k8s.io.
- [ ] After the release, it’s time to lift code freeze. The bot will need to be updated.
  - [Thaw k/k](https://github.com/kubernetes/sig-release/blob/de9e0a9821c4f73b83b4382df7a7dc837f91e18f/releases/release_phases.md#thaw), 
    master branch is then opened for new pull requests.
- [ ] The Docs lead thaws k/website
- [ ] Use all of the appropriate communications channels to announce the lifting of Code Freeze and thawing of 
  k/website, this can part of the release announcement.

### 8. After the Release Day (~Week 16, 17)
- [ ] Release Retrospective Part 2 completed
- [ ] Release Retrospective Part 3 completed or cancelled
- [ ] Contact the Release Managers Google Group to complete the Release Team Lead & Lead Shadows offboarding tasks from the previously-opened onboarding issue
- [ ] Help fill any open positions for the next release milestone
- [ ] Work with the incoming Release Team Lead to establish incoming Release Team.

**Release Lead Offboarding tasks**:
- [ ] Remove from GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-team`
  - `release-team-leads`
- [ ] Remove from Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
- [ ] Manually remove from the following Google Groups:
  - [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team) (Add as Manager)
  - [kubernetes-sig-leads](https://groups.google.com/forum/#!forum/kubernetes-sig-leads) (Add as Member)
- [ ] Remove from `release-team-leads` Slack Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
  - Remove slack ID(s) from [`users.yaml`](https://git.k8s.io/community/communication/slack-config/users.yaml), if no longer in a group
  - Remove username(s) from [`usergroups.yaml`](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)

## Further comments

`NONE`

cc: @kubernetes/release-engineering @kubernetes/release-team
