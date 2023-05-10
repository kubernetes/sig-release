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

Note that Enhancements Lead in particular will need to do work **during the week** during the early release, and will need to be available at least daily.

Enhancements shadows can expect to spend ~10–15 hours a week during the early release until enhancements freeze, and ~1–5 hours a week after enhancements freeze. Unlike Enhancements Lead, shadows can expect to do their work largely on weekends if they desire.

## Mentoring Shadows

The selected shadows should be:

- Interested in learning more about the Kubernetes release process.
- Able to dedicate a couple hours each week to attending the Release meeting in addition to helping with weekly tasks.

The shadows should be selected keeping in mind that one of them may eventually be taking up the Enhancements Lead role. It is important to delegate tasks and give the shadows broad exposure to the different aspects of the role.

## Getting Started

### Access Required

Ensure that the previous Enhancements Lead has given you access to:

- The previous Kubernetes release enhancements tracking board.

Ensure that you and the shadows have been added to:

- GitHub teams
  - [enhancements](https://git.k8s.io/org/config/kubernetes/sig-architecture/teams.yaml) (This group should be used for Enhancement Subproject related pinging only and not for Release Team Enhancements Group)
  - [milestone-maintainers](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - [release-team](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml)
  - [release-team-enhancements](https://git.k8s.io/org/config/kubernetes/sig-release/teams.yaml) (For elevated access to tracking board)

### Slack

Join the following Kubernetes Slack channels:

- [#sig-release](https://kubernetes.slack.com/messages/sig-release)
- [#enhancements](https://kubernetes.slack.com/messages/enhancements)
- [#release-enhancements](https://kubernetes.slack.com/messages/release-enhancements)
- (optional) [#prod-readiness](https://kubernetes.slack.com/messages/prod-readiness)
- (optional) [#release-management](https://kubernetes.slack.com/messages/release-management)

## Process

### Standards

As mentioned previously, the Enhancements Lead role encompasses several cross-functional responsibilities with [sig-arch-Enhancements][sig-arch-enhancements] subproject of [SIG Architecture][sig-arch-readme].

The process of maintaining an enhancement in Kubernetes is documented in the [kubernetes/enhancements][k/enhancements] repo. Any questions / concerns / suggestions for improvement to the Enhancements process should be raised as GitHub issues / PRs to k/enhancements.

It is important that this process be followed and documentation remain up-to-date as the [Enhancements repo][k/enhancements] is the primary ingress point for contributors interested in tracking enhancements.

### Milestone Activities + Timing

> Note: The week #n timings given below are tentative. There are special releases like Kubernetes 1.19 or releases at the end of the year which may not strictly conform to that.

#### Week 0

- Create the Enhancements Tracking Board for the current release
  - Navigate to https://github.com/orgs/kubernetes/projects/, click the `New Project` button, select the `Table` template (default), and click the `Create` button.
  - Update project settings by clicking `...` -> `Settings` from the project board
    - Update the `Project name` to reflect the current release e.g, **1.27 Enhancements Tracking**
    - Set the project's `Visibility` to **Public**
  - Update project access by clicking `Manage Access` from the settings page
    - Set the `Base role` access to **Read**
    - Add the following github teams with **Admin** access
      - @release-team-leads
    - Add the following github teams with  **Write** access
      - @production-readiness
      - @release-team-comms
      - @release-team-docs
      - @release-team-enhancements
  - Create all the Fields (columns) for the board
    > Note: This is currently a manual process and  <https://github.com/orgs/community/discussions/41133> filed to help automate the process.
    - Until this can be automated; manually create fields with the same `Field Name`, `Field type`, and `Option` values from the previous release's project board.
  - Create all the Views for the board
    > Note: This is also currently a manual process until github GraphQL APIs allow for manipulating Views
    - Until this can be automated; manually create Views with the same Names and Fields from the previous release's project board.
      Tip: You can easily view all the Fields present in each view by clicking the `v` next to the View's name an selecting `Configuration` -> `Fields`
      Note: Remember to **save** each View. If there is a blue bubble next to the Views name there are unsaved changed for that view!
  - Disable all Workflows for the project
    - Click `...` -> `Workflows`
    - For each workflow that enabled (has a green circle next to it), click the workflow and slide the toggle to 'Off'
  - Update automation to add issues to the correct Enhancement Tracking Board
    - Open a PR into kubernetes/test-infra which to update the [`GITHUB_PROJECT_BETA_NUMBER`](https://github.com/kubernetes/test-infra/blob/3de59f96b327c87c6d23a7308abc785268931707/config/jobs/kubernetes/sig-k8s-infra/trusted/sig-release-release-team-jobs/release-team-periodics.yaml#L20-L21) variable used by automation to identity the enhancements tracking board for the current release.
- Create a shortlink for the Tracking Board
  - Create a free account on [bitly](https://bitly.com/) to create a shortlink for the new Enhancement Tracking Board following the pattern `k8sxyy-enhancements` e.g., <https://bit.ly/k8s127-enhancements>.
- Make a [pull request](https://github.com/kubernetes/sig-release/pull/1411) to add the shortlinked Enhancement Tracking Board to the current release page in [sig-release][sig-release].
- Make a pull request to add the shortlinked Enhancement Tracking Board to [kubernetes/enhancements README page](https://github.com/kubernetes/enhancements#enhancements-tracking-board).
- Find [Issues][enhancements-issues] from previous milestone that have graduated to Stable. Remove `tracked/yes` or `tracked/no` labels. Check to see if the KEP status has been updated to `implemented`. If it has, close the issue. If it has not, ask the issue contact to both update the KEP status field and close the Enhancement issue once the update PR has merged.
- Find [Issues labeled `tracked/yes`](https://github.com/kubernetes/enhancements/issues?q=is%3Aopen+is%3Aissue+label%3Atracked%2Fyes) and change to `tracked/no` until the Enhancement is ready to be tracked for the upcoming release.
- Find [Issues labeled `lead-opted-in`](https://github.com/kubernetes/enhancements/issues?q=+is%3Aissue+label%3Alead-opted-in+) and remove the `lead-opted-in` label from all issues. Enhancements must be explicitly opted into each release.
- Close previous milestone by ensuring that there are no open issues/PRs in that milestone.
- Gather Shadows to have them read this handbook and give expectations on what the process looks like and their particular role. If possible, try to schedule a call with the shadows to get them accustomed to the team. This helps as a great team building exercise.
- Add Shadows to the  `release-team` and `release-team-enhancements` GitHub teams. (See [access-required](#access-required))
- Add Shadows to the `Enhancements Contact` Field of the Enhancements Tracking Board.
- Create a Google Sheet to track who will give updates at release team meetings
  - Access: : **restricted access**, edit rights shared with release team enhancements shadows individually

#### Week 1

- Send an email to the [Kubernetes-Dev](https://groups.google.com/a/kubernetes.io/g/dev) mailing list and a message to #chairs-and-techleads slack channel with a call for enhancements and how to opt-in to the release. Previous communications can be used as a template.
  - [1.26 call for enhancements](https://groups.google.com/a/kubernetes.io/g/dev/c/lnxXgZmOOMo/m/r6QNJIewBwAJ?utm_medium=email)
- Verify issues have k/k PRs associated so they can be referenced and easily tracked. This is going to be critical come Enhancement Freeze and Code Freeze to see the status of the code.
- Work with the Release Lead to introduce yourself, talk about release information, and relay information about opting into the release with SIG Leads.

#### Before Enhancements Freeze

- Monitor the Enhancements Tracking Board for new additions as SIGs opt-in KEPs for the release and assign an enhancement contact to each Issue.
- For opted in Issues periodically (at least once a week):
  - Ensure Issue is in the current milestone
  - Ensure Issue has correct labels (has `tracked/yes`, does not have `tracked/no`, `stage/xxx` is accurate, ...)
  - Ensure Fields in the Enhancement Tracking Board are populated and accurate (Status, Stage, SIG, ...)
  - Evaluate if the enhancement satisfies all of the [requirements](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#enhancements-freeze) for inclusion in the current release.
    - Comment on the Issue with a status updating using one of the [templates from below](#enhancement-freeze-templates)
    - Update `Enhancement Status` field for this Enhancement in the Enhancement Tracking Board (`Tracked` or `At Risk`)
- Reach out to each [SIG on Slack](https://github.com/kubernetes/community/blob/master/sig-list.md) tagging one or more chairs or technical leads to communicate the Enhancements statuses. Example [communication templates](#sig-outreach-templates) can be found below.
- Start syncing with Communications Team on giving an induction what's coming up for the release.
- Send an email to [Kubernetes-Dev](https://groups.google.com/a/kubernetes.io/g/dev) that Enhancement freeze is coming and share current Enhancements status. Examples [1](https://groups.google.com/g/kubernetes-dev/c/-nTNtBBHL2Y/m/WfNzb_E1EAAJ).
- Provide updates during release team meetings
  - Use the `KEPs by Stage` insight from the Enhancement Tracking Board ([example](https://github.com/orgs/kubernetes/projects/98/insights/3))

#### Week of Enhancements Freeze

- On Freeze day, send an email to [Kubernetes-Dev](https://groups.google.com/a/kubernetes.io/g/dev) that freeze has happened and upcoming key dates. Examples [1](https://groups.google.com/g/kubernetes-dev/c/JDM7bNKvhqQ/m/8S7BXtXPBQAJ).
- Remove any Enhancements that failed to meet the criteria by the Enhancement freeze deadline.
  - Set their **Enhancement Status** in the board to `Removed from Milestone`.
  - Remove the milestone and change `tracked/yes` label to `tracked/no` on the Enhancement Issue with the following comments

    ```text
    /remove-label tracked/yes
    /label tracked/no
    /milestone clear
    ```

- Clean up Enhancements issues by removing milestone from the enhancements that have not opted-in and make sure that number of in-tree open issues with current milestone matches number of opted-in enhancements.
- Any enhancements removed from the milestone will now require an exception. As exception requests come in, discuss each with the Release Lead (and Shadows) to arrive at an approve/reject decision.
  - Create an exception file in the Release for exceptions Example [1](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/exception.yaml).
  - If a previously removed Enhancement has had their exception Approved, set their **Enhancement Status** to `Tracked` in the Enhancement Tracking Board.

#### Post Enhancements Freeze

- Stay on top of issues and continually monitor them twice a week and look at attached PRs. As Code Freeze gets closer, if there are PRs that have not been merged, move the issue to `At Risk`. If there is no activity, ping issue owners on either the issue or the k/k PR.
- Monitor issues that are `At Risk` closely, almost daily. Code Freeze means no new code and keeping tabs on the status of the k/k PR is critical to planning. Make decisions if the enhancement should be deferred and work with SIG Leads to determine the best path forward.

#### Before Code Freeze

All enhancements going into the release must have their code pull requests in a merge-ready state with approved and lgtm labels applied. This includes tests, and docs PRs opened by the due date. Due to the Prow queue, this may mean that approved PRs merge shortly after the deadline.

#### Week of Code Freeze

- Remove any enhancements that failed to merge their code by the Code freeze deadline.
  - Set their status in the sheet to `Removed from Milestone`.
  - Remove the milestone and change `tracked/yes` label to `tracked/no` on the Enhancement Issue with the following comments

    ```text
    /remove-label tracked/yes
    /label tracked/no
    /milestone clear
    ```

  - Remove the milestone from all open `k/k` PRs related to the enhancement.
- Any enhancements removed from the milestone will now require an exception. As exception requests come in, discuss each with the Release Lead (and Shadows) to arrive at an approve/reject decision.
  - Add a `/hold` label to `k/k` PRs associated with incoming exceptions to prevent from accidental merge.
  - Add incoming exception information to the previous created `exception.yaml` file.
  - If a previously removed Enhancement has had their exception Approved, set their status back to `Tracked`
- Start planning for the next release while assisting the Release Lead with anything relating to analytics or Public Relation planning of the release. Work with the Communications Lead to develop major themes for the official Kubernetes blog post.

### Communication Templates

#### Enhancement Freeze Templates

If the Enhancement Issue **does not** meet the criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, Enhancements team here.

Just checking in as we approach **enhancements freeze on { FREEZE_DATETIME }**.

This enhancement is targeting for stage `<insert-stage-here>` for {current release} (correct me, if otherwise)

Here's where this enhancement currently stands:

- [ ] KEP readme using the [latest template](https://github.com/kubernetes/enhancements/tree/master/keps/NNNN-kep-template) has been merged into the k/enhancements repo.
- [ ] KEP status is marked as `implementable` for `latest-milestone: { CURRENT_RELEASE }`
- [ ] KEP readme has a [updated detailed test plan section](https://github.com/kubernetes/enhancements/blob/master/keps/NNNN-kep-template/README.md?plain=1#L257-L328) filled out
- [ ] KEP readme has up to date graduation criteria
- [ ] KEP has a production readiness review that has been completed and merged into k/enhancements.

For this KEP, we would just need to update the following:
- {insert list of action items}

The status of this enhancement is marked as `at risk`. Please keep the issue description up-to-date with appropriate stages as well. Thank you!

```

If the Enhancement Issue **does** meet the criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, Enhancements team here.

Just checking in as we approach **enhancements freeze on { FREEZE_DATETIME }**.

This enhancement is targeting for stage `<insert-stage-here>` for {current release} (correct me, if otherwise)

Here’s where this enhancement currently stands:

- [X] KEP readme using the [latest template](https://github.com/kubernetes/enhancements/tree/master/keps/NNNN-kep-template) has been merged into the k/enhancements repo.
- [X] KEP status is marked as `implementable` for `latest-milestone: { CURRENT_RELEASE }`
- [X] KEP readme has a [updated detailed test plan section](https://github.com/kubernetes/enhancements/blob/master/keps/NNNN-kep-template/README.md?plain=1#L257-L328) filled out
- [X] KEP readme has up to date graduation criteria.
- [X] KEP has a production readiness review that has been completed and merged into k/enhancements.

With all the KEP requirements in place and merged into k/enhancements, this enhancement is all good for the upcoming enhancements freeze. 🚀

The status of this enhancement is marked as `tracked`. Please keep the issue description up-to-date with appropriate stages as well. Thank you!
```

#### Code Freeze Templates

```markdown
Hey again {enhancement owner} 👋 Enhancements team here,

Just checking in as we approach **code freeze at { FREEZE_DATETIME }** .

Here's where this enhancement currently stands:

[ ] All PRs to the Kubernetes repo that are related to your enhancement are linked in the above issue description (for tracking purposes).
[ ] All PR/s are ready to be merged (they have `approved` and `lgtm` labels applied) by the code freeze deadline. This **includes** tests.

For this enhancement, it looks like the following PRs are open and need to be merged before code freeze (and we need to update the Issue description to include all the related PRs of this KEP):
- { list of PRs associated with this enhancement }

Also please let me know if there are other PRs in k/k we should be tracking for this KEP.
As always, we are here to help if any questions come up. Thanks!
```

#### SIG Outreach Templates (optional)

For SIGs which have opted to include Enhancements in the current release:

```markdown
Hello sig-{ SIG_NAME }. Enhancements team here.
Just checking in as we approach enhancements freeze at { FREEZE_DATETIME }.
Your SIG has submitted { X } enhancements for the { CURRENT_RELEASE } cycle, and { Y } enhancements are currently `At Risk`.
Refer to the [announcement here]({link to announcement for current release cycle}) for the list of review requirements.
If your SIG still plans to submit any more enhancement, follow the [instructions here]({link to announcement for current release cycle}) so the enhancements team can begin tracking.
Please plan to make KEP updates to meet all of the requirements before enhancement freeze.
Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.
```

For SIGs which have not opted to include Enhancements in the current release:

```markdown
Hello sig-{{ SIG_NAME }}. Enhancements team here.
Just checking in as we approach enhancements freeze at {{ FREEZE_DATETIME }}.
Your SIG has not submitted any enhancements for the { CURRENT_RELEASE } cycle.
If your SIG still plans to submit an enhancement, follow the [instructions here]({link to announcement for current release cycle}) so the enhancements team can begin tracking.
If your SIG is not planning to submit an enhancement, please reply to this message to confirm.
Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.
```

### Working with the Enhancement Tracking Board

The Enhancements Tracking Board is used by the release-enhancements, release-docs, and release-comms teams.
Information in this document will be focused on how the Enhancements team should interact with the project board.

#### Enhancements View

The `Enhancements` view is the primary view for the project board and is owned by the Enhancements sub-team.
This view is used source of truth for tracking the status of enhancements included in a given release.

> - **Do not** archive items from the board! Enhancements that are no longer being tracked for the current release are filtered out of the default View but should remain in the board for tracking purposes.

|                Field | Description                                                                       |
|---------------------:|-----------------------------------------------------------------------------------|
|                Title | Title of (and link to) the `Issue` in k/enhancements.                             |
|            Assignees | Assignees for the `Issue` in k/enhancements.                                      |
|                 Type | [Type](#type) of enhancement.                                                     |
|                Stage | Target stage (Alpha, Beta, Stable) for the current release.                       |
|               Status | [Status](#status) of the enhancement.                                             |
| Enhancements Contact | Alias of the Enhancements team designated as primary contact for the enhancement. |
|                  SIG | Owning SIG.                                                                       |
|           PRR Status | Status of PRR review for the enhancement.                                         |
|               Labels | Labels applied to the `Issue` in k/enhancements.                                  |
|            Milestone | The milestone assigned to the `Issue` in k/enhancements.                          |
|                 Note | Freeform notes added by the Enhancements team.                                    |

##### Type

|         Type | Description                                                                                                   |
|-------------:|---------------------------------------------------------------------------------------------------------------|
|      Net New | Enhancement is adding net-new work. Usually reserved for enhancements targeting their `Alpha` implementation. |
| Major Change | Enhancement is staying at the current Stage, but major changes in functionality are being implemented.        |
|   Graduating | Enhancement is graduating to `Beta` or `Stable`.                                                              |
|  Deprecation | Enhancement is tracking a deprecations or removals.                                                           |

Notes :

- If the feature is graduating to `Alpha`, the type can either be Net New/Major Change. But usually when features are introduced to Kubernetes, they are not Major Changes.
- If the feature is graduating to `Beta/Stable`, almost always the type is Graduating/Major Change. One exception to that is some features directly jump the hoop to Beta, in that case, the type can be Net New for even a `Beta` feature.

##### Status

The field `Status` tracks if the KEP has met all the criteria for inclusion in the current release.
Refer to the [Enhancement Freeze Communications](#enhancement-freeze-templates) for detailed requirements.

|                 Status | Description                                                                                                                                 |
|-----------------------:|---------------------------------------------------------------------------------------------------------------------------------------------|
|                Tracked | Enhancement has met all requirements for inclusion into current release.                                                                    |
|                At Risk | Enhancement does not currently meet requirements for inclusion into current release.                                                        |
|     Exception Required | Enhancement did not meet requirements by enhancement / code freeze and deadlines for requesting an [exception](#exceptions) has not passed. |
|               Deferred | Enhancement has been bumped to a future release by owning SIG.                                                                              |
| Removed From Milestone | Enhancement did not meet requirements by enhancement / code freeze for current release and an exception was not requested and/or approved.  |

Notes:

- If the Enhancement is being bumped to a later release, set it's status to `Deferred`.
- If it is being removed due to missing criteria or lack of response after being included in the milestone, set its status to `Removed from Milestone`.

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

### Sample Searches (examples)

### GitHub Notifications

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
