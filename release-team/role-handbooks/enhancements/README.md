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
  - Draft and / or review https://kubernetes.io/blog/ release announcement post, leveraging the themes collected across the release cycle e.g., [1.11 Announcement][1.11-announcement]
  - Engage with media analysts during the embargo period to discuss the release themes
  - CNCF Kubernetes Release webinar
  - Identify potential contributors for the “5 Days of Kubernetes” blog series
- Identify candidates to assume the Enhancements Lead role (according to the [Release Team selection process][rt-selection]) in the following release cycle
  - Chose Enhancement shadows whom you believe would be a good fit for succession and help mentor them throughout the release cycle  

## General Requirements

In addition to the [requirements detailed for all Release Team members][rt-requirements], becoming an Enhancements Lead has additional gates:
  - MUST have served on the Release Team in a previous capacity, ideally as an Enhancements Shadow
  - MUST be a member of the [SIG Release Google Group][sig-release-group]
  - MUST be a member of the [SIG PM Google Group][sig-pm-group]
  - MUST be a member of the [Kubernetes Milestone Burndown Google Group][burndown-group]

Helpful characteristics of an Enhancements Lead include:
- experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process
- product / project / program management experience
- release management experience

Approximate Time Committments 
Beginning of the cycle through enhancement freeze: 3-6 hours a week fluctuating based on how many SIG meetings need to be attended
Enhancement Freeze through Code Freeze: 4-7 hours a week
Code Freeze through Release Day: 1-4 hours a week 

## Mentoring Shadows
It is importantto select shadows who are interested in learning more about the Kubernetes release process and are able to devote a couple hours a week for attending the Release meeting as well as helping with weekly tasks.  Remeber one of these shadows should eventually be taking on the Enhancement Lead role so it is important to think about how you can delegate tasks to them to train them for succession.  

## Getting Started

### Access Required
Ensure that the previous Enhancements Lead has given (or facilitated getting) you access to:
- GitHub teams
  - enhancements-maintainers
  - kubernetes-milestone-maintainers
- OWNERS_ALIASES (as `enhancements-maintainers` in [kubernetes/enhancements][k/enhancements] repo)
- Edit access to the Kubernetes x.y.0 Enhancements Tracking Sheet e.g., [Kubernetes 1.12 Enhancements Tracking][1.12-tracking]

## Process

### Standards
As mentioned previously, the Enhancements Lead role encompasses several cross-functional responsibilities with [SIG PM][sig-pm].

The process of maintaining an enhancement in Kubernetes is documented in the [kubernetes/enhancements][k/enhancements] repo. Any questions / concerns / suggestions for improvement to the Enhancements process should be raised as GitHub issues / PRs to k/enhancements.

It is important that this process be followed and documentation remain up-to-date as the [Enhancements repo][k/enhancements] is the primary ingress point for contributors interested in tracking enhancements.

### Milestone Activities + Timing

| **Week** | **Stage** | **Action** |
| --- | --- | --- |
| 0 | Pre-Collection | Gather Shadows to have them read this handbook, watch the [k/enhancements](https://github.com/kubernetes/enhancements) repo to get notified on all issues, and give expectations on what the process looks like and their particular role. |
| 0 | Pre-Collection | Duplicate the previous enhancement collection spreadsheet into your own Google Drive and adjust it for the current milestone. Enhancements Tracking sheet is shortlinked with the pattern `k8sxyy-enhancements` e.g., http://bit.ly/k8s113-enhancements. Edit access is needed for yourself, prior lead, release lead, shadows, [SIG PM][sig-pm] Chairs, and  [Kubernetes Release Team Google Group][rt-group]. Access is done two ways. First is giving sheet RW access with Data -> Protected Sheets and Ranges. Add users there and then Share the sheet as well. Comment access is needed by [SIG Release Google Group][sig-release-group], [SIG PM Google Group][sig-pm-group], [SIG Docs Google Group][sig-docs-group], and [SIG Leads Google Group][sig-leads-group]. Remove all currently tracked issues. |
| 0 | Pre-Collection | Examine the `Removed From Milestone` tab and visit those issues to see if they have been added to the current milestone. These enhancements likely slipped because of docs or testing. Ping owners to make sure they are targeted for the current milestone. |
| 0 | Pre-Collection | Find Issues from previous milestone that have graduated to Stable and close the issue. Remove `tracked/yes` or `tracked/no` labels. |
| 0 | Pre-Collection | Clear out previous milestone issues. Ping owners to get them to drop milestone or add to the current milestone so it can be tracked. This can be a responsibility for shadow roles. |
| 0 | Pre-Collection | Close previous milestone. |
| 0 | Pre-Collection | Any issues in the current milestone can be added to the tracking sheet. Add the `tracked/yes` label to any issue that is being tracked in the sheet and current milestone. |
| 0 | Pre-Collection | Ping any owners on `lifecycle/frozen` label from all issues to see if there is any planned work or if the issue is no longer relevant to Kubernetes. |
| 0 | Pre-Collection | Send an email to the [Kubernetes-Dev](https://groups.google.com/forum/#!forum/kubernetes-dev) mailing list with a call for enhancements. View prior examples for references ([1](https://groups.google.com/forum/#!msg/kubernetes-dev/vGSBzUUWp9g/bFa1re3ZAgAJ) [2](https://groups.google.com/forum/#!msg/kubernetes-dev/T-kIHtgS5J4/ZjKTsCf_AwAJ;context-place=msg/kubernetes-dev/vGSBzUUWp9g/bFa1re3ZAgAJ)). |
| 1 | Collection | Find Issues that have been marked with the current milestone and apply the `tracked/yes` label and add it to the tracking sheet. Ensure they provide the required information and labels to be accepted into the milestone. |
| 1 | Collection | Go to every open issue that is marked with `tracked/no` and ping the owner to see if the enhancement will be included or graduating stages in the current milestone. If there is no graduation, leave as-is. If the enhancement is graduating, remove `tracked/no`, add `tracked/yes`, add to the current milestone, and add to the tracking sheet. Another great task for shadow help or some automation. |
| 1 | Collection | Verify issues have k/k PRs associated so they can be referenced and easily tracked. This is going to be critical come Enhancement Freeze and Code Freeze to see the status of the code. |
| 1 | Collection | Work with the Release Lead to attend every SIG meeting over the span of 2-3 weeks. Take 2 minutes to introduce yourself, talk about release information, and relay information about issues that haven't been removed from the previous milestone or call out issues that may need some attention. |
| 1 | Collection | New issues will be created. Take the opportunity to apply correct labels, milestone information, and add to the sheet if necessary. |
| 1 | Collection | Weekly Release meetings require updates of current status. Use the `Feature stats` tab to update the release team on counts of enhancements in good and bad progress.|
| 1 | Collection | Start reminding Issue owners that KEPs are required for each enhancement and that KEPs must be in an implementable state by Enhancement Freeze. | 
| 2-3 | Collection Monitoring and Triage | Stay on top of comments in issues when owners respond. Apply correct labels, milestone information, and add to the sheet if necessary. |
| 2-3 | Collection Monitoring and Triage | Mark features as "At Risk" if there is no communication or active PRs on the issues coming into Enhancement Freeze. |
| 4 | Enhancement Freeze | On Freeze day, send an email to [Kubernetes-Dev](https://groups.google.com/forum/#!forum/kubernetes-dev) that freeze has happened. "We are at X enhancements, and any new ones will require an exception." Examples [1](https://groups.google.com/forum/#!msg/kubernetes-dev/4kefhF6nOFQ/rCOme6vjCAAJ) [2](https://groups.google.com/forum/#!msg/kubernetes-dev/T-kIHtgS5J4/wW73F2HmBAAJ;context-place=msg/kubernetes-dev/T-kIHtgS5J4/ZjKTsCf_AwAJ). | 
| 4 | Enhancement Freeze | Remove any enhancements from the sheet that do not have a KEP in an implementable state. |
| 4 | Enhancement Freeze | Any enhancements removed from the milestone will now require an exception.  As exception requests come in approve/reject at your descretion and create the exception file in the Release for exceptions Example [1](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/exception.yaml). | 
| 5-7 | Freeze Monitoring | Stay on top of issues and continually monitor them twice a week and look at attached PRs. As Code Freeze gets closer, there are PRs that have not been merged, move the issue to At Risk. If there is no activity, ping issue owners on either the issue or the k/k PR. |
| 8-10 | Freeze Monitoring | Monitor issues that are At Risk closer, almost daily. Code Freeze means no new code and keeping tabs on the status of the k/k PR is critical to planning. Make decisions if the enhancement should be deferred and work with SIG Leads to determine the best path forward. |
| 10+ | Code Freeze | Start planning for the next release while assisting the Release Lead with anything relating to Analyst or Public Relation planning. Work with the Communications Lead to develop major themes for the official Kubernetes blog post. |

### Escalation / Handling Unresponsive Enhancement Owners
For issues where the initial owner is unresponsive goin to the issue SIG leadership to check if the issue is still targeted for the release.  

If there is continue unresponsiveness on issues remove them from the milestone at your descretion.  

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


[burndown-group]: https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown
[k/enhancements]: https://github.com/kubernetes/enhancements
[rt-group]: https://groups.google.com/forum/#!forum/kubernetes-release-team
[rt-selection]: /README.md#release-team-selection
[rt-requirements]: /README.md#release-team-requirements
[sig-docs-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-docs
[sig-leads-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-leads
[sig-pm]: https://github.com/kubernetes/community/blob/master/sig-pm/README.md
[sig-pm-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-pm
[sig-release]: https://github.com/kubernetes/community/blob/master/sig-release/README.md
[sig-release-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[1.11-announcement]: https://kubernetes.io/blog/2018/06/27/kubernetes-1.11-release-announcement/
[1.12-tracking]: http://bit.ly/k8s112-enhancements
