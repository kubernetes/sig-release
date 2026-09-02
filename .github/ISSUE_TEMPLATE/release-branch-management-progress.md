---
name: Release Branch Management Subteam Cycle Progress
about: Used to track release branch management subteam work which needs to be done every release cycle
title: '[v1.XX] Branch Management Subteam Cycle Progress'
labels: sig/release, area/release-eng, area/release-team
---

<!--
This template is used for tracking tasks that the Branch Management Subteam needs to do in a release cycle.

The issue should be kept open for the entirety of the release cycle, until all tasks are completed.

The below is the full content of the progress tracking issue. Replace all the `v1.XX` / `1.XX` references with the target release, and adjust the week headings/dates to match the release schedule.

Example tickets:

- v1.37 https://github.com/kubernetes/sig-release/issues/3026

-->

> [!NOTE]
> This ticket follows the Release Team Lead Cycle Progress ticket, and is curated for Branch Management specific actions. Additional information can be found in the [Release Manager Handbook](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md). If tasks are not needed to be done or additional tasks are required, make sure to update the issue template!
> More information about the release can be found in [/releases/release-1.XX/README.md](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/README.md).

# Overview

## Latest Update

<!-- Keep this in sync with the most recent entry added to "Status / Notes" below. -->

As of Day, xx Month (week X):
* TBC

## Currently Tracked Goals
- [ ] Alpha releases (alpha.1, alpha.2, alpha.3)
- [ ] Beta release (beta.0)
- [ ] Code Freeze and Test Freeze
- [ ] `release-1.XX` branch + jobs created
- [ ] Release candidates (rc.0, rc.1)
- [ ] v1.XX.0 released
- [ ] Thaw

## Useful Links
- [v1.XX Schedule](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/README.md#timeline)
- [Cutting a Kubernetes release](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md)
- [Release Manager Handbook](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md)
- [Branch creation handbook](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/branch-creation.md)

# Schedule

<!-- The weeks below follow the standard release schedule phases. Update the calendar dates in each heading to match /releases/release-1.XX/README.md#timeline for this cycle, and add/remove weeks if the schedule differs. -->

## Week 1–3: Onboarding & setup
- [ ] Select and onboard shadows
- [ ] Create Slack group and send instructions
- [ ] Update [release-team.md](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md) and `k/org` teams.yaml (lead + shadows as milestone maintainers)
- [ ] Create the v1.XX [Releases tracking issue](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md#creating-and-managing-the-release-issue) in `k/sig-release`
- [ ] Create release cuts rota and share, ask shadows to self-assign cuts
- [ ] Add lead + shadows to [`k8s-infra-release-editors`](https://github.com/kubernetes/k8s.io/blob/main/groups/sig-release/groups.yaml)
- [ ] Ask the [kubernetes-dev](https://groups.google.com/a/kubernetes.io/g/dev) and [kubernetes-announce](https://groups.google.com/forum/#!forum/kubernetes-announce) moderators to allow lead + shadows to post (see [Mailing List Permissions](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md#mailing-list-permissions))
- [ ] Confirm machine setup per [Release Manager Handbook](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md#machine-setup)

## Week 4: v1.XX.0-alpha.1 (Wed DD Mon YYYY)
- [ ] Assign and cut release

## Week 5: Enhancements Freeze
- No tasks

## Week 6: v1.XX.0-alpha.2 (Wed DD Mon YYYY)
- [ ] Assign and cut release

## Week 7
- No tasks

## Week 8: v1.XX.0-alpha.3 (Wed DD Mon YYYY)
- [ ] Assign and cut release

## Week 9: v1.XX.0-beta.0 (Wed DD Mon YYYY)
- [ ] Assign and cut release

## Week 10: Code Freeze + Test Freeze begin (Wed DD Mon AoE)
See [Code Freeze](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md#code-freeze)
- [ ] Open Code Freeze enforcement PR
- [ ] Confirm Code Freeze enforcement by making sure the above PR is merged after Code and Test freeze party

## Week 11: Burndown begins
- No tasks

## Week 12: Branch creation + v1.XX.0-rc.0 (Wed DD Mon YYYY)
- [ ] Stage and release rc.0
  - [ ] Create `release-1.XX` branch. See [RC.0 only Considerations](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#rc0-only-considerations-and-post-branch-creation-release-tasks)
- [ ] Reach out to release-managers a few days before the cut. Make sure someone is available to help you with the post branch creation tasks, some bugs may come up.
- [ ] Complete [post-release-branch-creation](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#post-branch-creation-release-tasks) tasks
  - [ ] Create `release-1.XX` jobs (test-infra)

## Week 13
- No tasks

## Week 14: v1.XX.0-rc.1 (Wed DD Mon YYYY)
- [ ] Assign and cut release

## Week 15: v1.XX.0 + Thaw (Wed DD Mon YYYY)
- [ ] Reach out to release-managers a few days before the cut, so someone is on standby in case something goes wrong.
- [ ] Run Mock Stage and Mock release the night before of the release
- [ ] Stage and release v1.XX.0
- [ ] Perform Code Thaw ([revert Tide config](https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-manager.md#code-thaw))
- [ ] Nominate next Branch Manager Lead
- [ ] Participate in release retro
- [ ] Update the Release Manager Handbook with lessons learned
- [ ] Close the Releases tracking issue and this progress issue

# Status / Notes

<!--
Append weekly updates here, newest entry first, e.g.:

As of Sunday, 26th July:
* v1.XX.0-beta.0 is live
* Lessons learned / blockers encountered this week
-->

_Weekly updates will be appended here._

cc: @kubernetes/release-engineering @kubernetes/release-team
