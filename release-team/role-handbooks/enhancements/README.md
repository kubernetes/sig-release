# Enhancements Lead Handbook

## Overview

While the Enhancements Lead serves as a member of the Release Team (a subproject of [SIG Release][sig-release]), this role is also a liaison to [sig-arch-Enhancements][sig-arch-enhancements] subproject of [SIG Architecture][sig-arch-readme].

## Responsibilities

An Enhancements Lead holds the following responsibilities:
- Maintain the active status of Enhancements within [kubernetes/enhancements][k/enhancements]
- Facilitate communication between Enhancement Owners, and SIG leadership, as necessary
- Collate the major themes of the release, including but not limited to:
  - new enhancements
  - long-awaited enhancements
  - enhancements moving into GA
  - enhancement deprecations
  - notable changes to existing behaviors
- Assist in Communications activities (in conjunction with the Communications Lead & the CNCF Communications team):
  - Draft and / or review https://kubernetes.io/blog/ release announcement post, leveraging the themes collected across the release cycle e.g., [1.17 Announcement][1.17-announcement]
  - Engage with media analysts during the embargo period to discuss the release themes
  - CNCF Kubernetes Release webinar
  - Identify potential contributors for the “5 Days of Kubernetes” blog series
- Identify candidates to assume the Enhancements Lead role (according to the [Release Team selection process][rt-selection]) in the following release cycle
  - Chose Enhancement shadows whom you believe would be a good fit for succession and help mentor them throughout the release cycle

## Prerequisites for Enhancements Lead and Shadows

### General Requirements

**Before continuing on to the Enhancements specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Enhancements Specific Requirements

- MUST have served on the Release Team in a previous capacity, ideally as an Enhancements Shadow
- MUST be a member of the [Release Team Google Group][rt-group]
    - List of members for this group is managed in git. Create a [pull request](https://github.com/kubernetes/k8s.io/pull/1533) against [kuberenetes/k8s.io](https://github.com/kubernetes/k8s.io/) repo to include both Lead and Shadows under `release-team` group in [k8s.io/sig-release/group.yaml](https://github.com/kubernetes/k8s.io/blob/bd082f195599b8a86b76b0249e5f70f219f1d079/groups/sig-release/groups.yaml#L318)
- MUST be a member of the [SIG Release Google Group][sig-release-group]
- MUST be a member of the [SIG Architecture Google Group][sig-arch-group]
- MUST be a member of the [Kubernetes Enhancements Google Group][enhancements-group]
- The enhancements lead should take the [Inclusive Speaker Orientation (LFC101)](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/) training course

Helpful characteristics of an Enhancements Lead include:
- experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process
- product / project / program management experience
- release management experience

### Time Commitments

Enhancement is one of the most time-intensive areas of the release team, and especially so during the early parts of the release. An Enhancements Lead can expect to spend:
- Beginning of the cycle through enhancement freeze: ~8–15 hours a week
- Week of enhancements freeze: 20+ hours
- Enhancement Freeze through Code Freeze: ~4–7 hours a week
- Code Freeze through Release Day: ~1–4 hours a week

Note that Enahncements Lead in particular will need to do work **during the week** during the early release, and will need to be available at least daily.

Enhancements shadows can expect to spend ~10–15 hours a week during the early release until enhancements freeze, and ~1–5 hours a week after enhancements freeze. Unlike Enhancements Lead, shadows can expect to do their work largely on weekends if they desire.

## Mentoring Shadows

The selected shadows should be:
- Interested in learning more about the Kubernetes release process.
- Able to dedicate a couple hours each week to attending the Release meeting in addition to helping with weekly tasks.

The shadows should be selected keeping in mind that one of them may eventually be taking up the Enhancements Lead role. It is important to delegate tasks and give the shadows broad exposure to the different aspects of the role.


## Getting Started

### Access Required

Ensure that the previous Enhancements Lead has given you access to:
- The previous Kubernetes Release Enhancements Tracking Sheet.

Ensure that you and the shadows have been added to:
- GitHub teams
  - [enhancements](https://git.k8s.io/org/config/kubernetes/sig-architecture/teams.yaml) (This group should be used for Enhancement Subproject related pinging only and not for Release Team Enhancements Group)
  - [milestone-maintainers](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)

### Slack

Join the following Kubernetes Slack channels:
- [#sig-release](https://kubernetes.slack.com/messages/sig-release)
- [#enhancements](https://kubernetes.slack.com/messages/enhancements)
- (optional) [#prod-readiness](https://kubernetes.slack.com/messages/prod-readiness)
- (optional) [#release-management](https://kubernetes.slack.com/messages/release-management)


## Process

### Standards

As mentioned previously, the Enhancements Lead role encompasses several cross-functional responsibilities with [sig-arch-Enhancements][sig-arch-enhancements] subproject of [SIG Architecture][sig-arch-readme].

The process of maintaining an enhancement in Kubernetes is documented in the [kubernetes/enhancements][k/enhancements] repo. Any questions / concerns / suggestions for improvement to the Enhancements process should be raised as GitHub issues / PRs to k/enhancements.

It is important that this process be followed and documentation remain up-to-date as the [Enhancements repo][k/enhancements] is the primary ingress point for contributors interested in tracking enhancements.

### Milestone Activities + Timing

> Note: The week #n timings given below are tentative. There are special releases like Kubernetes 1.19 or releases at the end of the year which may not strictly conform to that.

#### Pre-Collection (Week 0)

- Duplicate the previous enhancement collection spreadsheet into your own Google Drive and adjust it for the current milestone. Enhancements Tracking sheet is shortlinked with the pattern `k8sxyy-enhancements` e.g., http://bit.ly/k8s113-enhancements. Create a free account on [bitly](https://bitly.com/) to create a shortlink for the new enhancement collection spreadsheet.
- Clean up the spreadsheet by removing all currently tracked issues from all tabs.
- Update the permissions on the enhancement collection sheet.
    - Using the _Share_ settings available in the top right of the sheet, enable anyone with the link to _view_ the sheet.
    - Grant _Edit_ access to yourself (Current Enhancements lead), prior Enhancements lead, release lead, Enhancements shadows, the [SIG Release Leads Google Group][sig-release-leads-group], and [SIG Leads Google Group][sig-leads-group].
    - Add _Comment_ access for the [SIG Release Google Group][sig-release-group], [SIG Docs Google Group][sig-docs-group], [Kubernetes Release Team Google Group][rt-group].
- Update the permission on the protected tabs on the enhancement collection sheet.
    - For `KEP Collection` tab, grant _Edit_ access to the [SIG Leads Google Group][sig-leads-group].
    - For `Docs` tab, grant _Edit_ access to Docs Lead and Docs shadows.
    - For `Enhancements` tab, grant _Edit_ access to the [Production Readiness Review](https://github.com/kubernetes/enhancements/tree/master/keps/prod-readiness) (PRR) reviewers, and the Enhancements Shadows (later).
- Make a [pull request](https://github.com/kubernetes/sig-release/pull/1411) to add the shortlinked Enhancement Tracking sheet to the current release page in [sig-release][sig-release].
- Make a pull request to add the shortlinked Enhancement Tracking sheet to [kubernetes/enhancements README page](https://github.com/kubernetes/enhancements/blob/master/README.md#enhancements-tracking-spreadsheet).
- Find [Issues][enhancements-issues] from previous milestone that have graduated to Stable. Remove `tracked/yes` or `tracked/no` labels. Check to see if the KEP status has been updated to `implemented`. If it has, close the issue. If it has not, ask the issue contact to both update the KEP status field and close the Enhancement issue once the update PR has merged.
- Find [Issues labeled `tracked/yes`](https://github.com/kubernetes/enhancements/issues?q=is%3Aopen+is%3Aissue+label%3Atracked%2Fyes) and change to `tracked/no` until the Enhancement is ready to be tracked for the upcoming release.
- Close previous milestone by ensuring that there are no open issues/PRs in that milestone.
- Gather Shadows to have them read this handbook and give expectations on what the process looks like and their particular role. If possible, try to schedule a call with the shadows to get them accustomed to the team. This helps as a great team building exercise.
- Add Shadow information to the `Enhancements` tab of the Enhancements Tracking sheet.

#### Pre-Enhancements Freeze (Week 1)

- Send an email to the [Kubernetes-Dev](https://groups.google.com/a/kubernetes.io/g/dev) mailing list and a message to #chairs-and-techleads slack channel with a call for enhancements and how to opt-in to the release.
- Verify issues have k/k PRs associated so they can be referenced and easily tracked. This is going to be critical come Enhancement Freeze and Code Freeze to see the status of the code.
- Work with the Release Lead to introduce yourself, talk about release information, and relay information about opting into the release with SIG Leads.
- Weekly Release meetings require updates of current status. Use the `Feature stats` tab to update the release team on counts of enhancements in good and bad progress.

#### Collection Monitoring and Triage (Week 1-2)

- Monitor the `KEP Collection` tab regularly for new additions as SIGs opt-in KEPs into the release.
- Move data from `KEP Collection` into the `data` tab to be tracked officially for the release.
- Manually add the KEP issue number into the `Enhancements` tab and verify that the KEP is now included.
  - Entering the KEP issue number will auto populate the Enhancement Name, SIG, KEP Assignee, Proposal, and KEP State.
  - Fill out rest of the column manually based on current status of the KEP.
- For the opted in issues, apply the correct milestone, `tracked/yes` label, and `stage/xxx` label.
- Start reminding opted in Issue owners that KEPs are required for each enhancement and that KEPs must meet the acceptance criteria (implementable state, graduation criteria, test plan, and production readiness review) by Enhancement Freeze.
- Stay on top of comments in issues when owners respond and update their status in the sheet if necessary.
- Mark features as `At Risk` if there is no communication, active PRs on the issues, or it is missing other requirements coming into Enhancement Freeze.
- Start syncing with Communications Team on giving an induction what's coming up for the release.
- Reach out to each [SIG on Slack](https://github.com/kubernetes/community/blob/master/sig-list.md) tagging one or more chairs or technical leads to communicate the Enhancements statuses
  - For participating SIGs, mention the total number of Enhancements on the tracking spreadsheet for that SIG and the number of Enhancements that are `At Risk`.  An example outreach on Slack could be structured as follows:

    >    Hello sig-{{ SIG_NAME }}. Enhancements team here.  Just checking in as we approach enhancements freeze at {{ FREEZE_DATETIME }}. Your SIG has submitted {{ X }} enhancements for the {{ CYCLE }} cycle, and {{ Y }} enhancements are currently `At Risk`. Refer to the [announcement here](https://groups.google.com/a/kubernetes.io/g/dev/c/slwAhtVqjXk/m/zz-eeXdFBgAJ) for the list of review requirements. If your SIG still plans to submit any more enhancement, follow the [instructions here](https://groups.google.com/a/kubernetes.io/g/dev/c/slwAhtVqjXk/m/zz-eeXdFBgAJ) so the enhancements team can begin tracking. Please plan to make KEP updates to meet all of the requirements before enhancement freeze. Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.

  - For non-participating SIGs, mention the process and deadline for adding Enhancements to the `KEP Collection` tab on the tracking spreadsheet.  An example outreach on Slack could be structured as follows:

    > Hello sig-{{ SIG_NAME }}. Enhancements team here.  Just checking in as we approach enhancements freeze at {{ FREEZE_DATETIME }}. Your SIG has not submitted any enhancements for the {{ CYCLE }} cycle. If your SIG still plans to submit an enhancement, follow the [instructions here](https://groups.google.com/a/kubernetes.io/g/dev/c/slwAhtVqjXk/m/zz-eeXdFBgAJ) so the enhancements team can begin tracking. If your SIG is not planning to submit an enhancement, please reply to this message to confirm. Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.

- Send an email to [Kubernetes-Dev](https://groups.google.com/a/kubernetes.io/g/dev) that Enhancement freeze is coming and share current Enhancements status. Examples [1](https://groups.google.com/g/kubernetes-dev/c/-nTNtBBHL2Y/m/WfNzb_E1EAAJ).

#### Enhancements Freeze (Week 3)

- On Freeze day, send an email to [Kubernetes-Dev](https://groups.google.com/a/kubernetes.io/g/dev) that freeze has happened and upcoming key dates. Examples [1](https://groups.google.com/g/kubernetes-dev/c/JDM7bNKvhqQ/m/8S7BXtXPBQAJ).
- Remove [SIG Leads Google Group][sig-leads-group]'s access to the `KEP Collection` tab on the enhancement collection sheet.
- Remove any enhancements that failed to meet the criteria by the Enhancement freeze deadline.
    - Set their status in the sheet to `Removed from Milestone` and use the `Enhancements` -> `Remove Enhancements from Milestone` menu option to move them over to the `Removed from milestone` tab.
    - Remove the milestone and change `tracked/yes` label to `tracked/no` on the enhancement issue.
- Clean up Enhancements issues by removing milestone from the enhancements that have not opted-in and make sure that number of in-tree open issues with current milestone matches number of opted-in enhancements.
- Any enhancements removed from the milestone will now require an exception. As exception requests come in, discuss each with the Release Lead (and Shadows) to arrive at an approve/reject decision.
    - Create an exception file in the Release for exceptions Example [1](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/exception.yaml).
    - If a previously removed Enhancement has had their exception Approved, set their status to `Tracked` and use the `Enhancements` -> `Track Removed Enhancements` menu option to move it back to the `Enhancements` and `Docs` tabs.

#### Post Enhancements Freeze (Week 4–10)

- Stay on top of issues and continually monitor them twice a week and look at attached PRs. As Code Freeze gets closer, if there are PRs that have not been merged, move the issue to `At Risk`. If there is no activity, ping issue owners on either the issue or the k/k PR.
- Monitor issues that are `At Risk` closely, almost daily. Code Freeze means no new code and keeping tabs on the status of the k/k PR is critical to planning. Make decisions if the enhancement should be deferred and work with SIG Leads to determine the best path forward.

#### Code Freeze (Week 10+)

- Remove any enhancements that failed to merge their code by the Code freeze deadline.
  - Set their status in the sheet to `Removed from Milestone`.
  - Remove the milestone and change `tracked/yes` label to `tracked/no` on the enhancement issue.
  - Remove the milestone from all open `k/k` PRs related to the enhancement.
- Any enhancements removed from the milestone will now require an exception. As exception requests come in, discuss each with the Release Lead (and Shadows) to arrive at an approve/reject decision.
  - Add a `/hold` label to `k/k` PRs associated with incoming exceptions to prevent from accidental merge.
  - Add incoming exception information to the previous created `exception.yaml` file.
  - If a previously removed Enhancement has had their exception Approved, set their status back to `Tracked`
- Start planning for the next release while assisting the Release Lead with anything relating to analytics or Public Relation planning of the release. Work with the Communications Lead to develop major themes for the official Kubernetes blog post.


### Working with the Enhancement Tracking Sheet

#### Cross Release Enhancement Tracking

The source of truth for Enhancements is the `data` tab within the tracking sheet. All other tabs are driven off the data in this tab.
Any changes to the KEP Assignee, KEP owning SIG, KEP link, and KEP state should be done in the `data` tab.

|               Column | Description                                                                           |
|---------------------:|---------------------------------------------------------------------------------------|
|                Issue | Enhancement Issue Number.                                                             |
|                 Name | Enhancement Issue Name and link. Generated from Issue Number.                         |
|            Responder | Last person to respond on behalf of an Enhancement.                                   |
|                  SIG | Owning SIG. Generated from KEP path. If no KEP (PR in flight), requires manual entry. |
|                  KEP | Link to KEP or KEP PR.                                                                |
|            KEP State | KEP State (Pending, Implementable etc).                                               |
| Completed in Release | The release in which the Enhancement graduated to stable.                             |

#### Dashboard

The Dashboard tab is intended to be an _at-a-glance_ view of the current
Enhancement status from both the perspective of the Enhancements and Docs teams.
It is 100% generated from the `Enhancements` and `Docs` tabs and should **NOT**
be updated manually.

#### Enhancement Signal

Enhancements that are missing any criteria should be labeled as `At Risk`. To
help make this easier for the Enhancement team to label. Proposals and KEP State
are color coded indicating their current readiness state.

- `Proposal`
  - ![#B7E0CD](https://placehold.it/12/B7E0CD?text=+) KEP is merged
  - ![#FCE8B2](https://placehold.it/12/FCE8B2?text=+) KEP PR in flight
  - ![#F4C7C3](https://placehold.it/12/F4C7C3?text=+) No KEP or KEP PR found
- `KEP State`
  - ![#B7E0CD](https://placehold.it/12/B7E0CD?text=+) `Implementable` or `Implemented`
  - ![#FCE8B2](https://placehold.it/12/FCE8B2?text=+) `Provisional`
  - ![#F4C7C3](https://placehold.it/12/F4C7C3?text=+) `none` or `invalid`


#### Removing Tracked Enhancements

If the Enhancement is being bumped to a later release, set it's state to
`Deferred`.

If it is being removed due to missing criteria or lack of response
after being included in the milestone, set its state to `Removed from Milestone`.

Once done, use the `Enhancements` -> `Remove Enhancements from Milestone` menu
item to automatically to move it to the `Removed from Milestone` tab removing it
from the `Dashboard`, `Enhancements` and `Docs` tabs.


#### Moving a Removed Enhancement Back into the Milestone

If a removed item has had an exception granted. Set it's status to `Tracked` in
the `Removed from Milestone` tab. Then use the `Enhancements` ->
`Track Removed Enhancement` menu option to move it back to the `Dashboard`,
`Enhancements`, and `Docs` tabs.

#### Tips on judging Stage Status

- If the feature is graduating to `Alpha`, the status can either be Net New/Major Change. But usually when features are introduced to Kubernetes, they are not Major Changes.
- If the feature is graduating to `Beta/Stable`, almost always the state is Graduating/Major Change. One exception to that is some features directly jump the hoop to Beta, in that case, the status can be Net New for even a Beta feature.

> Feel free to ask the previous enhancements leads about this when in doubt.

### Escalation / Handling Unresponsive Enhancement Owners

For issues where the initial owner is unresponsive, try escalating to the relevant SIG's leadership to determine if the issue is still targeted for the release.

If there is continued unresponsiveness on issues, remove them from the milestone at your discretion.

### Exceptions

Exception process is outlined [here](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md)

### CNCF / Media Engagement

 - You may be called upon by the communications lead to help with media engagement near the end of the release cycle.  Please ensure that if there are any restrictions or training required by your company before engaging that you have completed those ahead of Code Thaw.

### Succession

- Select who will be the new enhancement lead for the next release. Shadows should be the first source pool. If none are available to lead then look externally through other release team members or members of [SIG Architecture Enhancements Subproject](enhancements)
- Enhancements Tracking sheet is shortlinked with the pattern `k8sxyy-enhancements` e.g., http://bit.ly/k8s113-enhancements
- Continually work to improve Enhancements process
- Review / update documentation as the release cycle ends
- Close issues marked as stable that made it into the release, only after the corresponding KEPs have been marked `Implemented`
- Close milestones that are complete
- Cleanup old milestones

### Limitations

- Populating the Enhancements Tracking sheet is a manual process
- Enhancements issues that are not submitted to [k/enhancements][k/enhancements] are not actively tracked in the context of the Release Team and Release cycle e.g.,
  - `kubeadm` (https://github.com/kubernetes/kubeadm/issues?utf8=%E2%9C%93&q=is%3Aissue+label%3Akind%2Ffeature+milestone%3Av1.12+)
  - out-of-tree Cloud Provider code that may live in `kubernetes-sigs/*`
  - additional out-of-tree code that may live in the following organizations:
    - `kubernetes`
		- `kubernetes-client`
		- `kubernetes-csi`
		- `kubernetes-incubator`
		- `kubernetes-sig-testing`
		- `kubernetes-sigs`
- Finding consensus on how frequently to triage enhancements

## Signals

## Tips & Tricks

#### Sample Searches (examples)

#### GitHub Notifications
https://groups.google.com/forum/#!topic/kubernetes-dev/5qU8irU7_tE

[enhancements-group]: https://groups.google.com/forum/#!forum/kubernetes-keps
[enhancements-issues]: https://github.com/kubernetes/enhancements/issues
[k/enhancements]: https://github.com/kubernetes/enhancements
[rt-group]: https://groups.google.com/a/kubernetes.io/g/release-team
[rt-selection]: /release-team/release-team-selection.md
[rt-requirements]: /release-team/release-team-onboarding.md
[sig-arch-readme]: https://github.com/kubernetes/community/tree/master/sig-architecture/README.md
[sig-arch-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-architecture
[sig-arch-enhancements]: https://github.com/kubernetes/community/tree/master/sig-architecture#enhancements
[sig-docs-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-docs
[sig-leads-group]: https://groups.google.com/a/kubernetes.io/g/leads
[sig-release]: https://github.com/kubernetes/community/blob/master/sig-release/README.md
[sig-release-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[sig-release-leads-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-release-leads
[1.17-announcement]: https://kubernetes.io/blog/2019/12/09/kubernetes-1-17-release-announcement/
[1.17-tracking]: https://bit.ly/k8s117-enhancement-tracking
