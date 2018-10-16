# Kubernetes Release Team: Release Team Leader

## Overview:

The release team leader role is responsible for coordinating release activities, assembling the release team, taking ultimate accountability for all release tasks to be completed on time, and ensuring a retrospective happens. The lead is also responsible for ensuring a successor is selected and trained for future release cycles.

## Authority and Responsibility:

A guiding principle for the lead is to be an arbiter of decisions, and not the primary decision-maker. A lead should constantly search for the best-qualified people or SIGs to guide the decision, not "go it alone" unless it is a very specific concern within the release process itself. When decisions are made they must be weighted in favor of community concerns over those of individuals or specific companies. Leads must also relinquish any favoritism for the company they work for. If there is a conflict of interest, the lead must refuse themselves from that decision. Above all, the release lead is a servant leader to the team and the community.

## Skills and Experience Required:

- This role requires a tremendous amount of experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process
- To properly serve as a release lead, you must have the following Kubernetes-specific qualifications:
  - If you have never held a release role before, you must shadow the release lead for two full release cycles
  - If you have held a release role, you must shadow the release lead for one full release cycle
  - You must be a member in good standing, and part of the Kubernetes org
  - You must be active in at least one Kubernetes SIG
  - You must be a member of the kubernetes-dev mailing list
- Several release team members are in the Pacific Time Zone partially due to infrastructure access limitations at Google, therefore, the release lead must be comfortable scheduling meetings and events compatible with PT working hours
- Project management experience is highly desirable
- Strong written and verbal communications skills are required
- As the public face of the community during release time, you must do so with a very high level of professionalism
- Prior experience in release management is extremely helpful

## Time Commitments:

Release Lead is a very time-consuming role, especially towards the end of the release cycle. Before you volunteer to be Release Lead, please make certain that your employer and your family are OK with you spending a lot of time on the release for the next three months. Here's a rough estimate of the time requirements by week:

- Weeks 1-4: 4-8 hours a week
- Weeks 5-8: 6-12 hours a week
- Weeks 9-13: 10 to 25 hours a week, including some after-hours and weekend work

Among the specific time commitments you have are:

- SIG-Release and Release Team meetings once a week during weeks 1-7.
- Burndown meetings three to five times a week during weeks 8-12.
- Community meetings once a week.

## Choosing a Release Team

One of your first, and definitely your most important, duties as Release Lead is to ensure a Release Team is in place.

Release Team selection should happen in accordance with the [Release Team Selection](/release-team/README.md#release-team-selection) process.

## Standards:

- The GitHub repository layout is:
  - kubernetes/sig-release
    - releases/release-x.y
      - README.md (release schedule)
      - release-notes-draft.md (consumed by the automated release process)
      - release_team.md
- Short links are handled with [http://bit.ly](http://bit.ly) - and each release follows the convention of:
  - Retro doc: [http://bit.ly/](http://bit.ly/kubeXXretro)[kube](http://bit.ly/kubeXXretro)[XXretro](http://bit.ly/kubeXXretro) where XX is the version number minus dots, e.g.: [http://bit.ly/kube110retro](http://bit.ly/kube110retro)
  - Release Schedule overview [http://bit.ly/k8sXX-release-info](http://bit.ly/k8sXX-release-info)
  - Zoom link: [http://bit.ly/k8sXX-zoom](http://bit.ly/k8sXX-zoom)
  - Burndown/Meeting Minutes: [http://bit.ly/k8sXX-burndown](http://bit.ly/k8sXX-burndown)
  - Features tracking spreadsheet: [http://bit.ly/k8sXX-features](http://bit.ly/k8sXX-features)
  - Merged PRs with release notes: [http://bit.ly/k8sXX-relnotes](http://bit.ly/k8sXX-relnotes)
  - Use the same conventions for additional documents
- Burndown meetings happen at 10AM Pacific Time, and you invite the [community calendar](mailto:cgnt364vd8s86hr2phapfjc6uk@group.calendar.google.com) to them.
- Burndown communications happen on the [burndown mailing list](mailto:kubernetes-milestone-burndown@googlegroups.com), not SIG-Release
- Feature exceptions are to be reviewed by the owner SIG and brought to the release team for assessment of risk, especially across SIGs
- General notification regarding the release should go to the kubernetes-dev and kubernetes-sig-leads lists, and this should automatically be captured into the [Kubernetes Discourse site](https://discuss.kubernetes.io/).
- All issues and PRs in the milestone are considered release-blocking until proven otherwise by the owner SIG.
  - Issues and PRs are added to the milestone only by members of the [kubernetes-milestone-maintainers GitHub team](https://github.com/orgs/kubernetes/teams/kubernetes-milestone-maintainers) which primarily includes SIG leads.
  - Typically the release lead will have been granted maintainer priviledge on this team for adding/removing folks as needing during the release cycle if SIG leads have turned over. If not and it is needed ask in Slack #sig-contribx to find the current administrator of teams.
  - The release lead may also need to add members of the release team, and should check with and prune prior release team members who are no longer active. With maintainer permission the release lead can add and remove GitHub users to and from the team via the [kubernetes-milestone-maintainers GitHub team](https://github.com/orgs/kubernetes/teams/kubernetes-milestone-maintainers).
  - Members of the team are not the ones making the choice whether issues and PRs are in a milestone. This is the job of SIG leads. But the release team members may add the milestone label when doing housekeeping on tracked issues and PRs and the milestone label has clearly been forgotten.
- The release lead is responsible for updating the [burndown template](https://docs.google.com/document/d/1zLnmDDOp_ko9Yh5uPJtgqPFD7GKq76fQsKaenXoMHzM/edit) ahead of the release (changing the milestone in links and anything else requested during the retrospective)
- Release theme: There is no particular reason for this other than to have fun, and possibly provide a theme for Release Team gifts / shirts. As Release Team Lead, you get to pick a theme for the release.
  - Releases 1.8 to 1.10, had unofficial food-based code names.
    - 1.8 - "Burrito"
    - 1.9 - "Pumpkin"
    - 1.10 - "Kiwi"
  - Release 1.10 had a late change to "Left Shark".
  - Release 1.11 had a Tolkien theme of "Eleventy-One: A Long-Expected Release"

## Release Milestone Activities:

### Week 1

- Start the release cycle
- Ensure you are joined to the following Google Groups:
  - [kubernetes-milestone-burndown](https://groups.google.com/forum/#!aboutgroup/kubernetes-milestone-burndown)
  - [kubernetes-sig-release](https://groups.google.com/forum/#!aboutgroup/kubernetes-sig-release)
  - [kubernetes-sig-leads](https://groups.google.com/forum/#!aboutgroup/kubernetes-sig-leads)
  - [kubernetes-dev](https://groups.google.com/forum/#!aboutgroup/kubernetes-dev)
  - [security-release-team](https://groups.google.com/a/kubernetes.io/forum/#!forum/security-release-team): Send message to this private list introducing self, key release team roles and also request list membership be added for the release branch manager, patch manager, and release lead shadow. Any previous release managers can add you.
- Ensure the release team is fully filled, with members subscribed to the kubernetes-milestone-burndown@googlegroups.com group.
- Ensure top-level OWNERS_ALIASES only includes personnel from four (4) releases, including the current one.
- Create and finalize the release schedule, blocking test gates, and role assignments as a pull request in: kubernetes/sig-release/releases/release-x.y/README.md
- Ensure that relevant feedback from the prior retrospective is incorporated into the process
- Send an update to kubernetes-dev and kubernetes-sig-leads mailing list to announce the start of the release cycle, including any notable changes in the release process, key dates, and links to important documents
- Create the retrospective document and corresponding bit.ly link
- Begin meeting with SIGs to introduce yourself
- Begin paying attention to [CI signal](https://git.k8s.io/sig-release/release-team/role-handbooks/ci-signal/README.md), as it may begin degrading soon after the prior release is cut and any slips must be caught and rectified promptly.
- Request review of this document by the release lead shadow. The shadow should also take all actions in this document around joining groups and requesting access permissions.

### Week 2

- Assist the features lead in collecting planned work from SIGs
- Schedule weekly release team meetings at 10 am Pacific time on a day that is most acceptable to the team. These will eventually turn into burndown meetings and occur daily. Invite the kubernetes-milestone-burndown@googlegroups.com group. You will need to contact SIG-Release leads to gain access to the SIG's zoom.us account for hosting / recording / posting meeting video.
- Poll release team membership and schedule a weekly alternate meeting to better enable more attendance outside of the Americas.
- Create a Google Calendar for the release: Follow the steps in the [sig-governance documentation](https://git.k8s.io/community/sig-governance.md) to create and share a calendar with the community. Add key event dates during the cycle.
- Begin reporting release status at the community meeting
- Continue meeting with SIGs for introductions

### Week 3

- Create the release notes draft file in the release directory per the standard above
- Prepare for x.y.0-alpha.0 "release", specifically that there is a branch manager on the team, and that master-blocking tests are all green. The alpha.0 artifacts were created already as a part of the prior release. But this synthetic notation is a point to review process with the branch manager. Request access to GCB through Caleb Miles for branch manager lead and optionally also read-only access (if system supports this) for the release lead and release lead shadow.
- Begin coordination with SIG-Cluster-Lifecycle for their kubeadm release (they may create an issue in the milestone to track release blocking issues)
- Identify any other dependent ecosystem projects that need release coordination
- Announce/email that the following week is "features freeze" and what that means

### Week 4

- Assist the features lead with anything required for feature freeze
- Remind the community about feature freeze
- Make sure everything is in synch between the features repo and the features tracking spreadsheet
- If there are features with questions or concerns, help coordinate those conversations between the team and the SIG/owners
- Start collecting SIG release themes in the release notes draft, outlining what they are delivering this release milestone, and how it aligns with their mission statements - start with SIGs identifying features in the features repo, and focus on those since not every SIG will be delivering something

### Week 5

- Prepare for x.y.0-alpha.1 release ensuring that master-blocking tests are all green
- Bring exceptions to the Release Team meetings, and make sure SIG representatives for the exception(s) know to attend and discuss if necessary
- Check in with docs team on release notes progress
- Follow up with SIGs on release themes
- Begin casual observation of [issues](https://git.k8s.io/sig-release/release-team/role-handbooks/bug-triage/README.md), CI signal, test flakes, and critical PRs


---
Release Halfway Point
---

### Week 6

- Continue reviewing feature exceptions as needed
- Release themes should be completed by now
- Exception requests should be almost zero
- The kubeadm and other dependent project issues should be created already
- Check in with SIGs on their feature work to make sure they know code freeze is 3 weeks away, as well as emailing the kubernetes-dev list, and notifying the community at the weekly meeting
- Adjust the features repo/tracking spreadsheet as necessary (this may also require modifying themes that can’t be delivered)
- Remind Test Infra Lead that branch CI jobs will need next week.

### Week 7

- Coordinate x.y.0-beta.0 release, ensuring master-blocking, and master-upgrade dashboards are 100% green if possible (this release is not an official beta, just an artifact of the release process), and any flakes are being actively worked by SIGs since this is a chance to look at CI signal. The release-x.y branch is created automatically as a part of the beta.0 release. The branch manager now begins daily fast forwards.
- The burndown templates should be useful at this point since it starts asking about status relevant to each area now tracking (e.g. branch health, docs, communications, issues, etc.)
- Ensure Test Infra Lead has release branch CI created and added to Testgrid
- Most feature-oriented tasks should be completed at the end of this week
- SIGs that have not completed release themes should be contacted again, with a focus on explaining why this matters to the community
- Ping release team leads reminding them to start considering succession plans. If they are handing the role off to a successor, identifying them early gives more time for the committed volunteer to get targeted mentoring.

### Week 8

- The code exception process is now in effect, meaning you will likely have to assemble decision makers on specific pending PRs to assess whether the risk of inclusion is acceptable or not. Remember this is not you making a decision, it’s you helping SIGs follow the process, and ensuring there’s consensus. In the event of a contentious PR, you should err on the side of risk aversion. In extreme cases, you can defer to the steering committee, but that is extremely unlikely.
- If the the release branch is not healthy, stable, and passing tests consistently, notify community through standard channels of need to rectify or code freeze will come early to force focus on stabilization.
- Announce (again) that code slush is the following week, and code freeze the week after. Touch base with SIGs again, and see if there is anything they need ahead of code freeze.

### Week 9

- Code slush begins. SIGs will need to ensure all work moving forward is carefully curated with merge required labels ([more info here](https://git.k8s.io/community/contributors/devel/release.md)).
- Test Infra Lead  ensures automation ready to enforce labeling and other release policies
- The once-weekly release meeting schedule now shifts to M, W, F and becomes burndown-specific (the template should be used from here forward and will need to be updated ahead of the meeting, which takes about 10 minutes for the lead, and less for the other team members)
- Make sure everyone knows the docs deadline (PRs ready for review) is coming the following Friday.
- Prepare for x.y.0-beta.1 release (week 10), ensuring x.y-blocking, master-blocking, and master-upgrade dashboards are 100% green, or all failures have issues filed and are being actively worked.

### Week 10

- Code freeze begins, and it’s now the home stretch of the release
- Test Infra Lead ensures automation actively enforcing merge blocking labeling and other release policies
- The release team needs to look at any in-flight PRs and ensure nothing is being jammed in at the last minute without proper tests, review, etc. This is something to watch extremely closely because it happens every release. Just watch what gets merged closely after code freeze. Incorrectly merged items need assessed and perhaps reverted. GitHub has [a query comparing a release branch and master](https://github.com/kubernetes/kubernetes/compare/release-1.12).
- Assist the documentation leads in collecting missing docs PRs.
- Schedule burndown meetings starting next week for every weekday until the Friday after release day, make sure to invite the community calendar
- Release notes, and themes should be close to done if not completed. There is a script that gathers notes from PRs but it’s still in progress. As the lead you may need to help assemble the notes.
- Identify vacancies on the incoming release team and begin asking SIGs, the community, and CNCF-sponsor companies for volunteers to fill roles. Getting committed volunteers now means they are also more actively engaged in the final weeks of the release, leading to more opportunities for final mentoring before they assume their release team role. Continue to improve and uphold the [Release Team Selection](/release-team/README.md#release-team-selection) process.
- Prepare for x.y.0-beta.2 release (week 11), ensuring x.y-blocking, master-blocking, and master-upgrade dashboards are 100% green.

### Week 11

- Begin daily burndown meetings
- If the release branch, master branch and associated tests are stable, it’s time to lift code freeze. The bot will need to be updated.
- The branch manager will perform one final branchff - make sure everything pending has been merged beforehand
- Master branch is then opened for new pull requests on x.y (the next release). Remaining release activities will happen on the release-x.y branch via cherry picks from master.
- Use all of the appropriate communications channels to announce the lifting of code freeze
- The task is now to ensure the release branch is ready to go. This means there are zero pending PRs, no failing x.y-blocking tests, no open issues in the milestone. This will continue until release day
- Final documentation PRs are reviewed and ready to be merged. Likely, this is not true and some are outstanding, so you need to help convince SIG doc writers to get these in with urgency.
- The release notes draft needs to be completely done and ready to consume by anago. Have SIG volunteers do a final proofread of their sections. Make sure people actually do this. You need to avoid having the release notes volunteers pull “all nighters” before the release.
- Work with the CNCF, SIG-PM, SIG-Docs, and communications lead to start the Release Blog post pulling from SIG Themes, the features repo, SIG members, and possibly release notes in specific PRs
- Work with incoming release lead to establish incoming release team.


---
Release Day
---

### Week 12

- Note that release day can and should be postponed if any of the conditions outlined in week 11 are not satisfied.
- Every issue in the milestone is considered release blocking.
- If you have to push the release date back, try to avoid Friday since it makes release publicity extremely difficult. Also, people seem to have patience with delay as long as the reasons are clear and openly communicated. This is your duty. You must over-communicate and ensure the team is also talking to their stakeholders (CNCF, community, press, etc.)
- Make release day as fun as you can for the team. Plan ahead for this and do something nice.
- The following final actions should be ordered, with successful completion of each being the entry criteria to the next.
  - Release day morning:
    - Go / No-Go: should generally be clear a day or three ahead of release, but the day's burndown provides a final opportunity for the team to affirm things are ready.
    - Release notes lead PR's final draft release notes to sig-release, with release lead approving merge.
    - Branch manager lead does mock release build.
    - Branch manager lead does mock publication.  Validates with release team lead and broader team the mock announcement email content.
    - Branch manager lead does nomock release build.
  - Starting approximately 4pm Pacific:
    - Communications lead begins staging blog post.
    - Branch manager lead does nomock publication.
    - Branch manager or release lead requests RPMs/Debs build from Google representative.
    - Google representative affirms build is complete.
    - Docs lead publishes release docs to website.
    - Branch manager does release-notify.
  - Approximately 5pm Pacific: all work is complete and the release team
    lead announces release to k-dev, sig leads lists, and discuss.k8s.io.

### Week 13

- Release retrospective participation (you may also choose to facilitate it, but it’s not recommended)
- Follow-up interviews with the media, the media roundtable.
- Contact Caleb Miles to remove release lead, release lead shadow, and branch manager authorization in GCB, as appropriate for release team turn over.
-  ensure self, shadow and branch manager are removed as members of [security-release-team](https://groups.google.com/a/kubernetes.io/forum/#!forum/security-release-team), leaving patch release manager.

### Week 14

- Help fill the any open positions for the next release milestone
