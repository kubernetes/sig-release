# Kubernetes Release Team: Release Team Leader

## Overview:

The release team leader role is responsible for coordinating release activities, assembling the release team, taking ultimate accountability for all release tasks to be completed on time, and ensuring a retrospective happens.  The lead is also responsible for ensuring a successor is trained for future release cycles.

## Authority and Responsibility:

A guiding principle for the lead is be an arbiter of decisions, and not the primary decision-maker.  A lead should constantly search for the best-qualified people or SIGs to guide the decision, not "go it alone" unless it is a very specific concern within the release process itself. When decisions are made they must be weighted in favor of community concerns over those of individuals or specific companies.  Leads must also relinquish any favoritism for the company they work for.  If there is a conflict of interest, the lead must recuse themselves from that decision.  Above all, the release lead is a servant leader to the team and the community.

## Skills and Experience Required:

* This role requires a tremendous amount of experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process

* To properly serve as a release lead, you must have the following Kubernetes-specific qualifications:

    * If you have never held a release role before, you must shadow the release lead for two full release cycles

    * If you have held a release role, you must shadow the release lead for one full release cycle

    * You must be a member in good standing, and part of the Kubernetes org

    * You must be active in at least one Kubernetes SIG

    * You must be a member of the kubernetes-dev mailing list

* Several release team members are in the Pacific Time Zone partially due to infrastructure access limitations at Google, therefore, the release lead must be comfortable scheduling meetings and events compatible with PT working hours

* Project management experience is highly desirable

* Strong written and verbal communications skills are required

* As the public face of the community during release time, you must do so with a very high level of professionalism

* Prior experience in release management is extremely helpful

## Time Commitments:

Release Lead is a very time-consuming role, especially towards the end of the release cycle.  Before you volunteer to be Release Lead, please make certain that your employer and your family are OK with you spending a lot of time on the release for the next three months.  Here's a rough estimate of the time requirements by week:

* Weeks 1-4: 4-8 hours a week
* Weeks 5-8: 6-12 hours a week
* Weeks 9-13: 10 to 25 hours a week, including some after-hours and weekend work

Among the specific time commitments you have are:

* SIG-Release and Release Team meetings once a week during weeks 1-7.
* Burndown meetings three to five times a week during weeks 8-12.
* Community meetings once a week.

## Choosing a Release Team

One of your first, and definitely your most important, duties as Release Lead is to select a Release Team.  Currently there are 10 roles to fill on the Release Team, plus one or more shadows (trainees) of each of those roles. each of which has specific requirements. Aside from any specifics, in general you are looking for candidates who:

1. Can commit to the amount of time required across the release cycle;
2. Are enthusiastic about being on the release team;
3. Are members of the relevant SIGs for their role;
4. And have some prior experience with contributing to Kubernetes.

In most cases, you will have a pool of candidates in the form of people who have previously shadowed the role in question, or have filled a different role on the Release Team and want to try something else.  Where possible, do select new team members over someone who has done the role several times, as we are trying to share experience across the organization.

Also give some thought to ensuring diversity on the team, including members of more than one gender, ethnicity, nationality, and company affiliation.  This should not be hard to do, as prior release teams have had several women, several non-white folks, and staff from five or more companies.  In some cases, though, you may need to reach out to individuals you know and suggest that they apply for the team.

## Standards:

* The GitHub repository layout is:

    * kubernetes/sig-release

        * releases/release-x.x

            * release-x.x.md (release schedule)

            * release-notes-draft.md (consumed by the automated release process)

            * release_team.md

* Short links are handled with [http://bit.ly](http://bit.ly) - and each release follows the convention of:

    * Retro doc:  [http://bit.ly/](http://bit.ly/kubeXXretro)[kube](http://bit.ly/kubeXXretro)[XXretro](http://bit.ly/kubeXXretro) where XX is the version number minus dots, e.g.: [http://bit.ly/kube110retro](http://bit.ly/kube110retro)

    * Zoom link:  [http://bit.ly/k8sXX-zoom](http://bit.ly/k8sXX-zoom)

    * Burndown/Meeting Minutes: [http://bit.ly/k8sXX-burndown](http://bit.ly/k8sXX-burndown)

    * Features tracking spreadsheet:  [http://bit.ly/k8sXX-features](http://bit.ly/k8sXX-features)

    * Merged PRs with release notes: [http://bit.ly/k8sXX-relnotes](http://bit.ly/k8sXX-relnotes)

    * Use the same conventions for additional documents

* Burndown meetings happen at 10AM Pacific Time, and you invite the [community calendar](mailto:cgnt364vd8s86hr2phapfjc6uk@group.calendar.google.com) to them.

* Burndown communications happen on the [burndown mailing list](mailto:kubernetes-milestone-burndown@googlegroups.com), not SIG-Release

* Feature exceptions are to be reviewed by the owner SIG and brought to the release team for assessment of risk, especially across SIGs

* All issues and PRs in the milestone are considered release-blocking until proven otherwise by the owner SIG.
    * Issues and PRs are added to the milestone only by members of the [kubernetes-milestone-maintainers" GitHub team](https://github.com/orgs/kubernetes/teams/kubernetes-milestone-maintainers) which primarily includes SIG leads.
    * Typically the release lead will have been granted maintainer priviledge on this team for adding/removing folks as needing during the release cycle if SIG leads have turned over.  If not and it is needed ask in Slack #sig-contribx to find the current administrator of teams.
    * The release lead may also need to add members of the release team, and should check with and prune prior release team members who are no longer active.  With maintainer permission the release lead can add and remove GitHub users to and from the team via the [kubernetes-milestone-maintainers" GitHub team](https://github.com/orgs/kubernetes/teams/kubernetes-milestone-maintainers).
    * Members of the team are not the ones making the choice whether issues and PRs are in a milestone.  This is the job of SIG leads.  But the release team members may add the milestone label when doing housekeeping on tracked issues and PRs and the milestone label has clearly been forgotten.

* The release lead is responsible for updating the [burndown template](https://docs.google.com/document/d/1zLnmDDOp_ko9Yh5uPJtgqPFD7GKq76fQsKaenXoMHzM/edit) ahead of the release (changing the milestone in links and anything else requested during the retrospective)

* Since 1.8, releases have had unofficial code names, chosen right before the release. There is no particular reason for this other than to have fun, and possibly provide a theme for release team gifts/shirts.

    * 1.9 - "Pumpkin"

    * 1.10 - "Left Shark"

    * 1.11 - "Hobbit"

## Release Milestone Activities:

<table>
  <tr>
    <td>RELEASE WEEK</td>
    <td>ACTIVITIES</td>
  </tr>
  <tr>
    <td>1</td>
    <td><p>- Start the release cycle
<p>- Insure you are joined to the following Google Groups: [kubernetes-milestone-burndown](https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown),[kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release), [kubernetes-sig-leads](https://groups.google.com/forum/#!forum/kubernetes-sig-leads), [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev).
<p>- Create and finalize the release schedule, blocking test gates, and role assignments as a pull request in: kubernetes/sig-release/releases/release-x.x/release-x.x.md
<p>- Ensure that relevant feedback from the prior retrospective is incorporated into the process
<p>- Send an update to kubernetes-dev mailing list to announce the start of the release cycle, including any notable changes in the release process, key dates, and links to important documents
<p>- Create the retrospective document and corresponding bit.ly link
<p>- Identify vacant release team roles and begin asking SIGs, the community, and CNCF-sponsor companies for volunteers
<p>- Begin meeting with SIGs to introduce yourself</td>
<p>- Request review of this document by the release lead shadow.  The shadow should also take all actions in this document around joining groups and requesting access permissions.
  </tr>
  <tr>
    <td>2</td>
    <td><p>- Assist the features lead in collecting planned work from SIGs
<p>- Schedule weekly release team meetings at 10 am Pacific time on a day that is most acceptable to the team.  These will eventually turn into burndown meetings and occur daily.  Invite the kubernetes-milestone-burndown@googlegroups.com group.  You will need to contact SIG-Release leads to gain access to the SIG's zoom.us account for hosting/recording/posting meeting video.
<p>- Create a Google Calendar for the release:  Follow the steps in [the sig-governance documentation](https://git.k8s.io/community/sig-governance.md) to create and share a calendar with the community.  Add key event dates during the cycle.
<p>- Begin reporting release status at the community meeting
<p>- Ensure the release team is fully filled if possible, with members subscribed to the kubernetes-milestone-burndown@googlegroups.com group.
<p>- Begin paying attention to CI signal, as it will begin degrading soon after the prior release is cut
<p>- Continue meeting with SIGs for introductions</td>
  </tr>
  <tr>
    <td>3</td>
    <td><p>- Create the release notes draft file in the release directory per the standard above
<p>- Prepare for x.x.0-alpha.2 release, specifically that there is a branch manager on the team, and that master-blocking tests are all green
<p>- Begin coordination with SIG-Cluster-Lifecycle for their kubeadm release (they may create an issue in the milestone to track release blocking issues)
<p>- Identify any other dependent ecosystem projects that need release coordination
<p>- Announce/email that the following week is "features freeze" and what that means</td>
  </tr>
  <tr>
    <td>4</td>
    <td><p>- Assist the features lead with anything required for feature freeze
<p>- Remind the community about feature freeze
<p>- Bring exceptions to the Release Team meetings, and make sure SIG representatives for the exception(s) know to attend and discuss if necessary
<p>- Make sure everything is in synch between the features repo and the features tracking spreadsheet
<p>- If there are features with questions or concerns, help coordinate those conversations between the team and the SIG/owners
<p>- Start collecting SIG release themes in the release notes draft, outlining what they are delivering this release milestone, and how it aligns with their mission statements - start with SIGs identifying features in the features repo, and focus on those since not every SIG will be delivering something</td>
  </tr>
  <tr>
    <td>5</td>
    <td><p>- Prepare for x.x.0-alpha.3 release ensuring that master-blocking tests are all green
<p>- Continue reviewing feature exceptions as needed
<p>- Check in with docs team on release notes progress
<p>- Follow up with SIGs on release themes
<p>- Begin casual observation of issues, CI signal, test flakes, and critical PRs</td>
  </tr>
  <tr>
    <td>6</td>
    <td><p>=== Release Halfway Point ===
<p>- Work with the CNCF, SIG-PM, SIG-Docs, and communications lead to start the Release Blog post pulling from SIG Themes, the features repo, SIG members, and possibly release notes in specific PRs
<p>- Release themes should be completed by now
<p>- Exception requests should be almost zero
<p>- The kubeadm and other dependent project issues should be created already
<p>- Check in with SIGs on their feature work to make sure they know code freeze is 3 weeks away, as well as emailing the kubernetes-dev list, and notifying the community at the weekly meeting
<p>- Adjust the features repo/tracking spreadsheet as necessary (this may also require modifying themes that can’t be delivered)</td>
  </tr>
  <tr>
    <td>7</td>
    <td><p>- Coordinate x.x.0-beta.0 release, ensuring master-blocking, and master-upgrade dashboards are 100% green if possible (this release is not an official beta, just an artifact of the release process), and any flakes are being actively worked by SIGs since this is a chance to look at CI signal
<p>- The branch manager will create release-x.x branch, and begin daily fast forwards
<p>- The burndown templates should be useful at this point since it starts asking about status relevant to each area now tracking (e.g. branch health, docs, communications, issues, etc.)
<p>- Release branch CI jobs will need to be created and added to Testgrid
<p>- Most feature-oriented tasks should be completed at the end of this week
<p>- Announce (again) that code slush is the following week, and code freeze the week after
<p>- SIGs that have not completed release themes should be contacted again, with a focus on explaining why this matters to the community
<p>- Remind SIGs about the bot processes applied after code slush/freeze</td>
  </tr>
  <tr>
    <td>8</td>
    <td><p>- Code slush begins.  SIGs will need to ensure all work moving forward is carefully curated with labels, especially `status/approved-for-milestone` that acts as an acceptance by the SIG of the work being targeted for the release
<p>- The code exception process is now in effect, meaning you will likely have to assemble decision makers on specific pending PRs to assess whether the risk of inclusion is acceptable or not. Remember this is not you making a decision, it’s you helping SIGs follow the process, and ensuring there’s consensus. In the event of a contentious PR, you should err on the side of risk aversion. In extreme cases, you can defer to the steering committee, but that is extremely unlikely.
<p>- Focus after this point will be on ensuring the release branch is healthy, stable, and passing tests consistently.  
<p>- Check in on the blog post draft
<p>- Announce upcoming code freeze through all the normal channels
<p>- Touch base with SIGs again, and see if there is anything they need ahead of code freeze
<p>- Make sure everyone knows the docs deadline (PRs ready for review) is coming the following Friday</td>
  </tr>
  <tr>
    <td>9</td>
    <td><p>- Code freeze begins, and it’s now the home stretch of the release
<p>- The bot should be used to enforce labeling and other release policies
<p>- The once-weekly release meeting schedule now shifts to M, W, F and becomes burndown-specific (the template should be used from here forward and will need to be updated ahead of the meeting, which takes about 10 minutes for the lead, and less for the other team members)
<p>- The release team needs to look at any in-flight PRs and ensure nothing is being jammed in at the last minute without proper tests, review, etc. This is something to watch extremely closely because it happens every release.  Just watch what gets merged closely after code freeze.
<p>- Prepare for x.x.0-beta.1 release, ensuring x.x-blocking, master-blocking, and master-upgrade dashboards are 100% green
<p>- Assist the documentation leads in collecting missing docs PRs</td>
  </tr>
  <tr>
    <td>10</td>
    <td><p>- Prepare for x.x.0-beta.2 release, ensuring x.x-blocking, master-blocking, and master-upgrade dashboards are 100% green
<p>- Final documentation PRs are reviewed and ready to be merged. Likely, this is not true and some are outstanding, so you need to help convince SIG doc writers to get these in as soon as possible.
<p>- Schedule burndown meetings every weekday until the Friday after release day, make sure to invite the community calendar
<p>- Release notes, and themes should be close to done if not completed. There is a script that gathers notes from PRs but it’s still in progress.  As the lead you may need to help assemble the notes.</td>
  </tr>
  <tr>
    <td>11</td>
    <td><p>- Begin daily burndown meetings
<p>- If the release branch, master branch and associated tests are stable, it’s time to lift code freeze. The bot will need to be updated.
<p>- The branch manager will perform one final branchff - make sure everything pending has been merged beforehand
<p>- Master branch is then opened for new pull requests on x.y (the next release), and remaining release activities will happen on the release-x.x branch exclusively
<p>- Use all of the appropriate communications channels to announce the lifting of code freeze
<p>- The task is now to ensure the release branch is ready to go.  This means there are zero pending PRs, no failing x.x-blocking tests, no open issues in the milestone.  This will continue until release day
<p>- The release notes draft needs to be completely done and ready to consume by anago. Have SIG volunteers do a final proofread of their sections.  Make sure people actually do this.  You need to avoid having the release notes volunteers pull “all nighters” before the release.</td>
  </tr>
  <tr>
    <td>12</td>
    <td><p>=== Release day ===
<p>- Note that release day can and should be postponed if any of the conditions outlined in week 11 are not satisfied.  
<p>- Every issue in the milestone is considered release blocking.  
<p>- If you have to push the release date back, try to avoid Friday since it makes release publicity extremely difficult.  Also, people seem to have patience with delay as long as the reasons are clear and openly communicated.  This is your duty.  You must over-communicate and ensure the team is also talking to their stakeholders (CNCF, community, press, etc.)
<p>- Make release day as fun as you can for the team.  Plan ahead for this and do something nice.  </td>
  </tr>
  <tr>
    <td>13</td>
    <td><p>- Release retrospective participation (you may also choose to facilitate it, but it’s not recommended)
<p>- Follow-up interviews with the media, the media roundtable</td>
  </tr>
  <tr>
    <td>14</td>
    <td><p>- Help fill the lead position for the next release milestone
<p>- If no one qualified steps up as a lead, you need to keep the following x.y release on track until you do.  </td>
  </tr>
</table>
