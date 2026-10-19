---
name: Release Team Lead Cycle Progress
about: Used to track release lead work which needs to be done every release cycle
title: '[v1.XX] Release Team Lead Cycle Progress'
labels: sig/release, area/release-eng, area/release-team
---

<!--
This template is used for tracking tasks that the Release Team Lead and Lead Shadows need to do in a release cycle.

The issue should be kept open for the entirety of the release cycle, until all tasks are completed.

The sections below are ordered by release milestone. The week numbers in parentheses are from the v1.38 cycle and are
only there for orientation; always check the schedule in the release directory for the current cycle.
-->

* Release Team Leads
  * Release Lead: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
  * Release Lead Shadow: (at)USERNAME
* Release Cycle: `Kubernetes v1.XX`
* [Release Timeline](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.XX) <!-- DON'T FORGET TO UPDATE THE LINK -->

Additional information can be found in the [release team lead handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead). If tasks are not needed to be done or additional tasks are required, make sure to update the issue template!

## Release Lead tasks

### 1. Before the start of the Release Cycle

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
  - In the top-level `OWNERS_ALIASES`:
    - Release Team Lead: update the `release-team-lead` alias
    - Lead Shadows: update the `release-team-lead-shadows` alias
    - Role leads: update the `*-subteam-approvers` aliases
- [ ] Updated Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/sig-release/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
  - `release-team@`
- [ ] Release Team calendar access granted (reach out to sig-release chairs)
- [ ] Zoom credentials (host key) granted (reach out to sig-release chairs)
- [ ] Added incoming release team leads to `release-team-leads` Slack Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
  - Add slack ID(s) to [`users.yaml`](https://git.k8s.io/community/communication/slack-config/users.yaml), if they are not yet in the file
  - Add username(s) to [`usergroups.yaml`](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
- [ ] Ensured the Release Team subproject owners are the owners of the [kubernetes-release-team-shadows](https://groups.google.com/a/kubernetes.io/g/release-team-shadows) Google Group.
- [ ] Ensured top-level `OWNERS_ALIASES` only includes Release Team personnel from four (4) releases, including the current one.

**Create Release Team Documents:**
- [ ] `links.md` created in `releases/release-1.XX` with one section per `rel.k8s.io` short link (`releasemtg`, `releasetracking`, `bugtriage`, `cisignal`, `retro`, `contacts`), see the [Standards section of the handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#standards) and the [v1.38 `links.md`](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.38/links.md)
- [ ] Meeting Notes document created
  - Access: public comment access, edit access [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Short link: `https://rel.k8s.io/vXYY/releasemtg` (for example `https://rel.k8s.io/v138/releasemtg`)
- [ ] Retro document created
  - Access: public comment access, edit rights shared with [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Short link: `https://rel.k8s.io/vXYY/retro`
- [ ] Release Team contact sheet created
  - Access: **restricted access**, edit rights shared with [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - Short link: `https://rel.k8s.io/vXYY/contacts`
- [ ] Lead rotation sheet created
  - Access: **restricted access**, edit rights shared with release team lead shadows individually

**One week before the start of the release cycle:**
- [ ] "Release Sneak Peek" email to introduce yourself, lead shadows, role leads, and Release Managers has been sent out
  - Send the email to [k-dev](https://groups.google.com/a/kubernetes.io/g/dev), [SIG Leads](https://groups.google.com/a/kubernetes.io/g/leads), [SIG Release](https://groups.google.com/g/kubernetes-sig-release), [Release Team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - The emails of previous cycles on the k-dev list can be used as a template

### 2. Start of the release cycle up to Enhancements Freeze (v1.38 example: weeks 1 to 5)

**First week of the release cycle:**
- [ ] Checked in with team leads and verified that the release team is complete
- [ ] Reminded release team members to subscribe to the [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team) and [kubernetes-sig-release](https://groups.google.com/g/kubernetes-sig-release) google groups and to the [kubernetes-release calendar](https://rel.k8s.io/release-team-cal).
- [ ] Notified team leads to update the contact sheet with shadow information (`https://rel.k8s.io/vXYY/contacts`)
- [ ] Release schedule finalized
- [ ] Begin paying attention to Release Signal, as it may begin degrading soon after the prior release is cut and any slips must be caught and rectified promptly.
- [ ] Meet your Shadows and create a communication channel with them. Establish expectations and share out work - delegate!
- [ ] Pair your Shadows to support two subteams for the duration of the release.
- [ ] Request review of this document by the Release Team Lead shadow(s). The shadow(s) should also take all actions in this document around joining groups and requesting access permissions.
- [ ] Update the SIG Release groups in the `k/k8s.io/groups/sig-release/groups.yaml` with the following:
  - [ ] Add Lead and Lead shadows to members of `k8s-infra-release-viewers`
  - [ ] Add EA, Lead, Lead shadows, comms lead, comms shadows to members of `release-comms`
  - [ ] Add EA, Lead and Lead shadows to members of `release-managers`
  - [ ] Add EA, Lead and Lead shadows to managers of `release-team`
  - [ ] Add Role Leads and Role shadows to members of `release-team`
  - [ ] Add Role shadows and Lead shadows to members of `release-team-shadows`
  - [ ] Add EA to manager of release-team-shadows, if EA is owner of `release-team-shadows` already then add Lead to manager of `release-team-shadows`
- [ ] Ensured that a Release Manager is available for cutting v1.XX.0-alpha.1
- [ ] Assist the Enhancements Lead in collecting planned work from SIGs
- [ ] Discussed and scheduled a weekly Release Team meeting on a day that is most acceptable to the team. Invite the `kubernetes-sig-release` group.
- [ ] Update the release calendar with the initial release meeting times and dates set to UTC.
- [ ] Poll Release Team membership and schedule a weekly alternate meeting to better enable more attendance outside of the Americas.
- [ ] Major release cycle events have been added to the Kubernetes Release Calendar with one week in advance reminders set. (defer to the [handbook for more information](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#working-with-the-release-team-calendar))

**A week before the KEP Readiness Deadline and Enhancements Freeze:**
- [ ] Reminded the community about the KEP Readiness Deadline and Enhancements Freeze by sending an email to [k-dev](https://groups.google.com/a/kubernetes.io/g/dev). It may also be useful to send a short version to the `#sig-release` and `#chairs-and-techleads` Slack channels referencing the k-dev email.

**For every pre-release cut (alpha.N, beta.0):**
- [ ] Checked in with the Release Signal team and the Release Managers that v1.XX.0-alpha.N is ok to be released and [master-blocking](https://testgrid.k8s.io/sig-release-master-blocking) tests are all green
- [ ] Checked in with the Docs team on release notes progress after the tag for v1.XX.0-alpha.N is generated

### 3. Enhancements Freeze up to the Release Halfway Point (v1.38 example: weeks 5 to 8)

- [ ] Bring exceptions to the `#sig-release` Slack channel and to Release Team meetings, and make sure SIG representatives for the exception(s) know to attend and discuss if necessary.
- [ ] Begin casual observation of issues, Release Signal, test flakes, and critical PRs

### 4. Release Halfway Point up to Code Freeze (v1.38 example: weeks 8 to 12)

**General Tasks:**
- [ ] Send out a "Release Update / State of the Release" email to [k-dev](https://groups.google.com/a/kubernetes.io/g/dev)
- [ ] Notify SIGs about the upcoming Code Freeze deadline by sending an email to the [kubernetes-dev](https://groups.google.com/a/kubernetes.io/g/dev) list
- [ ] Make sure everyone knows the docs placeholder PR deadline is coming (v1.38 example: week 9)
- [ ] The first retrospective meeting is scheduled for the first week of Monday, Wednesday, and Friday burndown meetings after Code Freeze, typically mid-week. Confirm the Emeritus Adviser can serve as facilitator. If the Emeritus Adviser is unavailable then defer the responsibility as appropriate.
- [ ] Pinged role leads reminding them to start considering succession plans. If they are handing the role off to a successor, identifying them early gives more time for the committed volunteer to get targeted mentoring.

**Deprecations and Removals Blog:**
- [ ] Check in with release-comms if they are in contact with the release-enhancements team to collect "deprecations and removals" targeting the release
- [ ] Identified with release-comms and SIG Docs if a "Deprecations and Removals" blog is needed and if so, started drafting it (see the posts of previous cycles on the [Kubernetes blog](https://kubernetes.io/blog/))
- [ ] A Release Team representative (ideally from release-comms) should attend the SIG Docs meeting to raise awareness about the "Deprecations and Removals blog" for reviews.
- [ ] The Deprecations and Removals blog is scheduled for the week after Code Freeze. A draft of the blog should be started as reviews and iterations will be needed before publication
- [ ] Ensured that the authors of the deprecations and removals are reviewing the blog before it is published

**Release Highlights and Release Blog:**
- [ ] Followed up with SIGs on the release highlights of the release
- [ ] Checked in with release-comms about the status of release highlights collection

### 5. Around Code Freeze and Test Freeze (v1.38 example: week 12)

Defer to the [code freeze section](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#code-freeze) in the release-team-lead handbook.

#### Shortly before Code Freeze

Code Freeze begins, and it is now the home stretch of the release. SIGs will need to ensure all work moving forward is carefully curated with required merge labels.

- [ ] Monitor the Release Tracking Board to get an idea of how many PRs are still outstanding leading up to Code Freeze
- [ ] Monitor Testgrid and Prow to understand the stability of the release and PRs getting ready to merge. If Prow and Testgrid are not in a good state consult folks from SIG Testing on delaying Code Freeze by a day if needed.
    - If `master` is not healthy, stable, and passing tests consistently, notify the community through standard channels of the need to rectify, or Code Freeze will come early to force focus on stabilization.
- [ ] Reminded the Release Managers that the release branch and its CI jobs will be needed with the rc.0 cut
- [ ] Send out a reminder email to [kubernetes-dev](https://groups.google.com/a/kubernetes.io/g/dev)

#### With Code Freeze

- [ ] As needed, assist the Release Signal Lead and Enhancements Lead removing PRs and enhancements from the milestone that aren't merged in time (`/milestone clear`)
- [ ] Bring Code Freeze exceptions to the `#sig-release` Slack channel, start a thread for each, and ensure SIG representatives for the exception(s) discuss in the thread.

### 6. Code Freeze up to Docs Freeze (v1.38 example: weeks 13 to 14)

- [ ] Started burndown meetings on Monday, Wednesday, and Friday the week after Code Freeze
- [ ] Published the "Deprecations and Removals" blog
- [ ] Make sure everyone knows the docs "PRs ready for review" deadline is coming (v1.38 example: week 13)
- [ ] Monitor the docs view of the Release Tracking Board to get an idea of how many docs PRs are still outstanding leading up to Docs Freeze.
- [ ] Verified that the Release Managers created the [`release-1.XX` branch](https://github.com/kubernetes/kubernetes/branches) with the rc.0 cut
- [ ] Verified that the Release Managers created the CI dashboards on [Testgrid](https://testgrid.k8s.io/sig-release) for the release cycle (1.XX-blocking and 1.XX-informing)
- [ ] Verified together with the Docs team that all KEPs with required documentation are ready for review
- [ ] Make sure everyone knows Docs Freeze is coming the following week

### 7. Around Docs Freeze (v1.38 example: week 14)

Defer to the Docs Freeze guidance in the [Docs release timeline](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/docs/release-timeline.md).

- [ ] As needed, assist the Docs subteam lead with any last-minute escalations.
- [ ] After Docs Freeze: bring exceptions to the `#sig-release` Slack channel, start a thread for each, and ensure SIG representatives for the exception(s) discuss in the thread.

### 8. Docs Freeze up to Release Day (v1.38 example: weeks 14 to 16)

- [ ] Completed release theme (slogan, logo and explanation text) and added it to the [release cycle documentation in k/sig-release/releases/release-1.XX](https://github.com/kubernetes/sig-release/tree/master/releases)
- [ ] Decided with the Release team if burndown meetings are necessary or updates are done via Slack thread on Tuesdays and Thursdays
- [ ] Discussed Release Lead succession with the EA and sig-release leads
- [ ] Remind team leads to find successors for the upcoming cycle and discuss candidates with the EA
- [ ] The task is now to ensure the release branch is ready to go. This means there are zero pending PRs, no failing 1.XX-blocking tests, no open issues in the milestone. This will continue until release day.
- [ ] Final documentation PRs are reviewed and ready to be merged. Likely, this is not true and some are outstanding, so you need to help convince SIG doc writers to get these in with urgency.
- [ ] Planned something for Release Day. Make the day as fun as you can for the team. Plan ahead for this and do something nice
- [ ] Prepared [Release Team gifts](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/release-team-lead#release-theme-gifts)
- [ ] The Communications Lead has contacted the CNCF (around Code Freeze) to gauge media interest, schedule the CNCF Kubernetes release webinar, and publish the release blog post. Stay in the loop for that. If there is media interest in the release, an interview with the journalist will be organized by the CNCF.
- [ ] Check in with the docs lead and verify tasks that should happen before the release day are completed (ref [Docs release timeline](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/docs/release-timeline.md))
- [ ] The Release Team Retro part 2 and part 3 are scheduled shortly after release day and a host / facilitator is available
- [ ] Remind the release team to add items to the retro meeting agenda

### 9. Release Day (v1.38 example: week 16)

- Note that release day can and should be postponed if any of the conditions outlined in the previous section are not satisfied.
- Every issue in the milestone is considered release blocking
- If you have to push the release date back, try to avoid Friday since it makes release publicity extremely difficult. Also, people seem to have patience with delay as long as the reasons are clear and openly communicated. This is your duty. You must over-communicate and ensure the team is also talking to their stakeholders (CNCF, community, press, etc.)

- The following final actions **must occur in order**, with successful completion of each being the entry criteria to the next.
  - Release day morning:
    - [ ] Go / No-Go: should generally be clear a day or three ahead of release, but the day's burndown provides a final opportunity for the team to affirm things are ready.
    - [ ] Docs Lead PRs final draft release notes to sig-release, with Release Team Lead approving merge.
    - [ ] Release Managers do the mock release build.
    - [ ] Release Managers do the mock publication and validate the mock announcement email content with the Release Team Lead and the broader team.
    - [ ] Release Managers do the nomock release build.
  - Starting when ready:
    - [ ] Communications Lead should have completed staging blog post, merging the blog with `draft:true` and creating a second PR that removes the draft with a `/hold` label.
    - [ ] Release Managers do the nomock publication.
    - [ ] Release Managers affirm the build is complete.
    - [ ] Verify with the docs lead that the staging release website is in correct shape by verifying the blog posts, the release page, download page, etc.
    - [ ] Docs Lead publishes release docs to website (ref [Docs release timeline](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/docs/release-timeline.md))
    - [ ] Release Managers send the release announcement.
  - [ ] Approximately 5pm Pacific: all work is complete and the release team
    lead announces the release to [k-dev](https://groups.google.com/a/kubernetes.io/g/dev), [SIG Leads](https://groups.google.com/a/kubernetes.io/g/leads), and discuss.k8s.io.
- [ ] After the release, it is time to lift Code Freeze. The bot will need to be updated.
  - [Thaw k/k](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#thaw), `master` is then opened for new pull requests.
- [ ] The Docs lead thaws k/website
- [ ] Use all of the appropriate communications channels to announce the lifting of Code Freeze and thawing of
  k/website, this can be part of the release announcement.

### 10. After Release Day

- [ ] Release Retrospective Part 2 completed
- [ ] Release Retrospective Part 3 completed or cancelled
- [ ] Contact the Release Managers Google Group to complete the Release Team Lead and Lead Shadows offboarding tasks from the previously-opened onboarding issue
- [ ] Help fill any open positions for the next release milestone
- [ ] Work with the incoming Release Team Lead to establish the incoming Release Team.

**Release Lead Offboarding tasks**:
- [ ] Remove from GitHub teams [(`kubernetes/org`)](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - `milestone-maintainers`
  - `release-team`
  - `release-team-leads`
- [ ] Remove from Google Groups/GCP IAM membership [(`kubernetes/k8s.io`)](https://git.k8s.io/k8s.io/groups/sig-release/groups.yaml)
  - `k8s-infra-release-viewers@`
  - `release-managers@`
- [ ] Manually remove from the following Google Groups:
  - [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
  - [kubernetes-sig-leads](https://groups.google.com/a/kubernetes.io/g/leads)
- [ ] Remove from `release-team-leads` Slack Group [(`kubernetes/community`)](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)
  - Remove slack ID(s) from [`users.yaml`](https://git.k8s.io/community/communication/slack-config/users.yaml), if no longer in a group
  - Remove username(s) from [`usergroups.yaml`](https://git.k8s.io/community/communication/slack-config/sig-release/usergroups.yaml)

## Further comments

`NONE`

cc: @kubernetes/release-engineering @kubernetes/release-team
