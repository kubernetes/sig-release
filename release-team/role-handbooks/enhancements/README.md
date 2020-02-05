# Enhancements Lead Handbook

## Overview

While the Enhancements Lead serves as a member of the Release Team (a subproject of [SIG Release][sig-release]), this role is also a liaison to [SIG PM][sig-pm] across the following subprojects:
- Product Management
- Program Management & Release
- Release Marketing

## Responsibilities

An Enhancements Lead holds the following responsibilities:
- Maintain the active status of Enhancements within [kubernetes/enhancements][k/enhancements]
- Facilitate communication between Enhancement Owners, Product Management, and SIG leadership, as necessary
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
- MUST be a member of the [SIG Release Google Group][sig-release-group]
- MUST be a member of the [SIG PM Google Group][sig-pm-group]

Helpful characteristics of an Enhancements Lead include:
- experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process
- product / project / program management experience
- release management experience

Approximate Time Commitments
Beginning of the cycle through enhancement freeze: 3-6 hours a week fluctuating based on how many SIG meetings need to be attended
Enhancement Freeze through Code Freeze: 4-7 hours a week
Code Freeze through Release Day: 1-4 hours a week

## Mentoring Shadows

The selected shadows should be:
- Interested in learning more about the Kubernetes release process.
- Able to dedicate a couple hours each week to attending the Release meeting in addition to helping with weekly tasks.

The shadows should be selected keeping in mind that one of them may eventually be taking up the Enhancements Lead role. It is important to delegate tasks and give the shadows broad exposure to the different aspects of the role.


## Getting Started

### Access Required

Ensure that the previous Enhancements Lead has given (or facilitated getting) you access to:
- GitHub teams
  - enhancements-maintainers
  - kubernetes-milestone-maintainers
- OWNERS_ALIASES (as `enhancements-maintainers` in [kubernetes/enhancements][k/enhancements] repo)
- Edit access to the Kubernetes x.y.0 Enhancements Tracking Sheet e.g., [Kubernetes 1.17 Enhancements Tracking][1.17-tracking]

## Process

### Standards

As mentioned previously, the Enhancements Lead role encompasses several cross-functional responsibilities with [SIG PM][sig-pm].

The process of maintaining an enhancement in Kubernetes is documented in the [kubernetes/enhancements][k/enhancements] repo. Any questions / concerns / suggestions for improvement to the Enhancements process should be raised as GitHub issues / PRs to k/enhancements.

It is important that this process be followed and documentation remain up-to-date as the [Enhancements repo][k/enhancements] is the primary ingress point for contributors interested in tracking enhancements.

### Milestone Activities + Timing

| **Week** | **Stage** | **Action** |
| --- | --- | --- |
| 0 | Pre-Collection | Gather Shadows to have them read this handbook, watch the [k/enhancements](https://github.com/kubernetes/enhancements)repo to get notified on all issues, and give expectations on what the process looks like and their particular role. |
| 0 | Pre-Collection | Duplicate the previous enhancement collection spreadsheet into your own Google Drive and adjust it for the current milestone. Enhancements Tracking sheet is shortlinked with the pattern `k8sxyy-enhancements` e.g., http://bit.ly/k8s113-enhancements. Update the permissions on the sheet via the _Share_ settings available in the top right of the sheet: Enable anyone with the link to _view_ the sheet. Next, grant _Edit_ access to yourself, prior lead, release lead, shadows, [SIG PM][sig-pm] Chairs, and the [Kubernetes Release Team Google Group][rt-group] . Lastly, add _Comment_ access for the [SIG Release Google Group][sig-release-group], [SIG PM Google Group][sig-pm-group], [SIG Docs Google Group][sig-docs-group], and [SIG Leads Google Group][sig-leads-group]. When complete, remove all currently tracked issues from both the `Enhancements` and `Docs` tabs. |
| 0 | Pre-Collection | Within the tracking sheet, filter the `data` tab to remove Issues that were completed in a previous release. Copy the `Issue Number` column to the `Enhancements` tab. The tab will auto-populate with a portion of the other relevant data. Once complete, set their `Enhancement Status` to `Pending Inclusion`. This will serve as the initial seed of Enhancements that need to be evaluated for the release. |
| 0 | Pre-Collection | Examine the `Removed From Milestone` tab and visit those issues to see if they have been added to the current milestone. These enhancements likely slipped because of docs or testing. Ping owners to make sure they are targeted for the current milestone. When complete, clear the issues from the tab. |
| 0 | Pre-Collection | Find Issues from previous milestone that have graduated to Stable. Remove `tracked/yes` or `tracked/no` labels. Check to see if the KEP status has been updated to `implemented`. If it has, close the issue. If it has not, ask the issue contact to both update the KEP status field and close the Enhancement issue once the update PR has merged. |
| 0 | Pre-Collection | Clear out previous milestone issues. Ping owners to get them to drop milestone or add to the current milestone so it can be tracked. This can be a responsibility for shadow roles. |
| 0 | Pre-Collection | Close previous milestone. |
| 0 | Pre-Collection | Issues in the current milestone should have the `tracked/yes` label applied and their status in the tracking sheet set to `Tracked`. Ensure they provide the required information and labels to be accepted into the milestone. If they do not meet the requirements, let the Issue owner know. set it's status within the tracking sheet to `At Risk` and add a comment describing which requirements are missing. |
| 0 | Pre-Collection | Ping any owners on `lifecycle/frozen` label from all issues to see if there is any planned work or if the issue is no longer relevant to Kubernetes. |
| 0 | Pre-Collection | Send an email to the [Kubernetes-Dev](https://groups.google.com/forum/#!forum/kubernetes-dev) mailing list with a call for enhancements. View prior examples for references ([1](https://groups.google.com/forum/#!msg/kubernetes-dev/vGSBzUUWp9g/bFa1re3ZAgAJ) [2](https://groups.google.com/forum/#!msg/kubernetes-dev/T-kIHtgS5J4/ZjKTsCf_AwAJ;context-place=msg/kubernetes-dev/vGSBzUUWp9g/bFa1re3ZAgAJ)). |
| 1 | Collection | Go to every open issue that is marked with `tracked/no` and ping the owner to see if the enhancement should be included in the current milestone. If there is no graduation or major change, leave as-is. If the enhancement is graduating or undergoing a major change, remove the `tracked/no` label and add `tracked/yes`, add the issue to the current milestone, and set it's status to `Tracked` within the tracking sheet if it meets the requirements. If it is missing some  of the requirements (e.g. KEP in a provisional state), let the issue owner know and add it as `At Risk`. Another great task for shadow help or some automation. |
| 1 | Collection | Verify issues have k/k PRs associated so they can be referenced and easily tracked. This is going to be critical come Enhancement Freeze and Code Freeze to see the status of the code. |
| 1 | Collection | Work with the Release Lead to attend every SIG meeting over the span of 2-3 weeks. Take 2 minutes to introduce yourself, talk about release information, and relay information about issues that haven't been removed from the previous milestone or call out issues that may need some attention. |
| 1 | Collection | New issues may be added during the release cycle. Take the opportunity to apply the correct labels, milestone information, and add them to the `data` tab within the sheet. If it's not being tracked for the current release, adding the information will help a later release team. |
| 1 | Collection | Weekly Release meetings require updates of current status. Use the `Feature stats` tab to update the release team on counts of enhancements in good and bad progress.|
| 1 | Collection | Start reminding Issue owners that KEPs are required for each enhancement and that KEPs must be in an implementable state by Enhancement Freeze. |
| 2-3 | Collection Monitoring and Triage | Stay on top of comments in issues when owners respond. Apply correct labels, milestone information, update their status in the sheet if necessary. |
| 2-3 | Collection Monitoring and Triage | Mark features as `At Risk` if there is no communication, active PRs on the issues, or it is missing other requirements coming into Enhancement Freeze. |
| 4 | Enhancement Freeze | On Freeze day, send an email to [Kubernetes-Dev](https://groups.google.com/forum/#!forum/kubernetes-dev) that freeze has happened. "We are at X enhancements, and any new ones will require an exception." Examples [1](https://groups.google.com/forum/#!msg/kubernetes-dev/4kefhF6nOFQ/rCOme6vjCAAJ) [2](https://groups.google.com/forum/#!msg/kubernetes-dev/T-kIHtgS5J4/wW73F2HmBAAJ;context-place=msg/kubernetes-dev/T-kIHtgS5J4/ZjKTsCf_AwAJ). |
| 4 | Enhancement Freeze | Remove any enhancements that failed to meet the criteria by the Enhancement freeze deadline. Set their status in the sheet to `Removed from Milestone` and use the `Enhancements` -> `Remove Enhancements from Milestone` menu option to move them over to the `Removed from milestone` tab. |
| 4 | Enhancement Freeze | Any enhancements removed from the milestone will now require an exception.  As exception requests come in, discuss each with the Release Lead (and Shadows) to arrive at an approve/reject decision. Create an exception file in the Release for exceptions Example [1](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/exception.yaml). If a previously removed Enhancement has had their exception Approved, set their status to `Tracked` and use the `Enhancements` -> `Track Removed Enhancements` menu option to move it back to the `Enhancements` and `Docs` tabs. |
| 5-7 | Freeze Monitoring | Stay on top of issues and continually monitor them twice a week and look at attached PRs. As Code Freeze gets closer, there are PRs that have not been merged, move the issue to At Risk. If there is no activity, ping issue owners on either the issue or the k/k PR. |
| 8-10 | Freeze Monitoring | Monitor issues that are At Risk closer, almost daily. Code Freeze means no new code and keeping tabs on the status of the k/k PR is critical to planning. Make decisions if the enhancement should be deferred and work with SIG Leads to determine the best path forward. |
| 10+ | Code Freeze | Start planning for the next release while assisting the Release Lead with anything relating to Analyst or Public Relation planning. Work with the Communications Lead to develop major themes for the official Kubernetes blog post. |

### Working with the Enhancement Tracking Sheet

#### Cross Release Enhancement Tracking

The source of truth for Enhancements is the `data` tab within the tracking sheet.
It contains items that do not often change state. All other tabs are driven off
the data in this tab. It should be kept as up-to-date as possible.

|               Column | Entry type | Description                                                                           |
|---------------------:|:----------:|---------------------------------------------------------------------------------------|
|                Issue |   Manual   | Enhancement Issue Number.                                                             |
|                 Name |  Generated | Enhancement Issue Name and link. Generated from Issue Number.                         |
|            Responder |   Manual   | Last person to respond on behalf of an Enhancement.                                   |
|                  SIG | Generated* | Owning SIG. Generated from KEP path. If no KEP (PR in flight), requires manual entry. |
|                  KEP |   Manual   | Link to KEP or KEP PR.                                                                |
|            KEP State |   Manual   | KEP State (Pending, Implementable etc).                                               |
| Completed in Release |   Manual   | The release in which the Enhancement graduated to stable.                             |

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


#### Removing Untracked Enhancements

Untracked Enhancements are Enhancements that were `Pending Inclusion` with either
no response by the Enhancement Freeze deadline or specifically stated that they
should not be included. Once either a response from issue owner stating it should
not be tracked or the Enhancement Freeze deadline occurs, their status should be
set to `Untracked`.

Once done, use the `Enhancements` -> `Removed Untracked Enhancements` menu item
to remove it from the `Dashboard`, `Enhancements` and `Docs` tabs. It will not
be moved over to the `Removed from Milestone` tab.


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


### Escalation / Handling Unresponsive Enhancement Owners

For issues where the initial owner is unresponsive, try escalating to the relevant SIG's leadership to determine if the issue is still targeted for the release.

If there is continued unresponsiveness on issues, remove them from the milestone at your discretion.

### Exceptions

Exception process is outlined [here](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md)

### CNCF / Media Engagement

 - You may be called upon by the communications lead to help with media engagement near the end of the release cycle.  Please ensure that if there are any restrictions or training required by your company before engaging that you have completed those ahead of Code Thaw.

### Succession

- Select who will be the new enhancement lead for the next release.  Shadows should be the first source pool.  If none are available to lead then look externally through other release team members or members of #SIG-PM
- Generate new Enhancements Tracking sheet with enhancements that were removed from the current milestone
- Enhancements Tracking sheet is shortlinked with the pattern `k8sxyy-enhancements` e.g., http://bit.ly/k8s113-enhancements
- Continually work to improve Enhancements process
- Review / update documentation as the release cycle
- Close issues marked as stable that made it into the release
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


[k/enhancements]: https://github.com/kubernetes/enhancements
[rt-group]: https://groups.google.com/forum/#!forum/kubernetes-release-team
[rt-selection]: /README.md#release-team-selection
[rt-requirements]: /release-team/release-team-onboarding.md
[sig-docs-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-docs
[sig-leads-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-leads
[sig-pm]: https://github.com/kubernetes/community/blob/master/sig-pm/README.md
[sig-pm-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-pm
[sig-release]: https://github.com/kubernetes/community/blob/master/sig-release/README.md
[sig-release-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[1.17-announcement]: https://kubernetes.io/blog/2019/12/09/kubernetes-1-17-release-announcement/
[1.12-tracking]: https://bit.ly/k8s117-enhancement-tracking
