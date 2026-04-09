# Enhancements Tracking Board

## Table of Contents

- [Cleaning Up Previously Tracked Issues](#cleaning-up-previously-tracked-issues)
- [Setting Up New Tracking Board](#setting-up-new-tracking-board)
- [Enabling Tracking Board Automation](#enabling-tracking-board-automation)
- [Disabling Tracking Board Automation](#disabling-tracking-board-automation)

## Cleaning Up Previously Tracked Issues

Before we set up the tracking board for the current release, it is important to clear out tracking labels from previous releases, so that we start from a clean slate. Enhancements must be explicitly opted into each release.

In the message templates below, make sure to replace:
- `{current release}` with the current release version, e.g. `v1.36`
- `{previous release}` with the previous release version, e.g. `v1.35`
- `{enhancement owner}` with the GitHub handles of the KEP author(s)

### Part 1: Clearing the lead-opted-in label

Before setting up automation for the new board, we need to make sure the `lead-opted-in` label is removed from issues from all old milestones, so they don't get automatically added to the new board. Use this search to find all issues that have the `lead-opted-in` label and are NOT in the current milestone: `https://github.com/kubernetes/enhancements/issues?q=is%3Aissue%20label%3Alead-opted-in%20-milestone%3A{current release}`

Here are the different cases and how to handle them:

- If the issue is already closed, just remove any outstanding tracking labels that are set:
```
/remove-label lead-opted-in
/remove-label tracked/yes
/remove-label tracked/no
```

- If the issue is open AND the `lead-opted-in` was added recently (i.e. since the end of the last release), it's possible that the KEP author / SIG wishes to work on it this cycle, but hasn't yet added/updated the milestone. In this case, we can add the milestone for them. Example message template:
```
Hi {enhancement owner} 👋, {current release} Enhancements Lead here.

It looks like this enhancement will be worked on as part of {current release}, so I've set the milestone accordingly. If this isn't accurate, please let me know!

/milestone {current release}
```

- If the KEP has successfully graduated to `stable` (we can confirm this by checking if it was tracked as `stable` in the previous milestone, and not `Removed from Milestone` or `Deferred`), we need to make sure that the `status` in `kep.yaml` has been updated to `implemented` and then close the issue (no need to wait until feature gates are removed). If `kep.yaml` is already updated to `implemented`, we can just comment and close the issue. Example message template:
```
Hi {enhancement owner} 👋, {current release} Enhancements Lead here,

Given that this KEP has graduated to `stable` and the status in `kep.yaml` has been updated to `implemented`, I will close the issue.

/remove-label lead-opted-in
/remove-label tracked/yes
/close
```

- If it's `stable` but the `kep.yaml` has not been updated yet, ask the KEP author to update `kep.yaml` and close the issue. Example message template:
```
Hi {enhancement owner} 👋, {current release} Enhancements Lead here,

Given that this KEP has graduated to `stable`, if all the work is completed, could you please update the KEP status in `kep.yaml` to `implemented`, and then close this issue?

Thanks!

/remove-label lead-opted-in
/remove-label tracked/yes
```
- For all other KEPs, we leave the issue open but clear the milestone and tracking labels. Below is an example template:
```
Hi {enhancement owner} 👋, {current release} Enhancements Lead here.

I am closing the {previous release} milestone now.

If you'd like to work on this enhancement in {current release}, please have the SIG lead opt in by adding the `lead-opted-in` label, which ensures it gets added to the tracking board. Also, please set the milestone to {current release} using `/milestone {current release}`.

Thanks!

/remove-label lead-opted-in
/remove-label tracked/yes
/remove-label tracked/no
/milestone clear
```

### Part 2: Clearing the tracked labels

The `tracked/yes` and `tracked/no` labels indicate whether a KEP is actively being tracked by the Release Team. At the beginning of the release, we should clear these out so we can start from a clean slate. Most of them would have been removed by previous steps above, but double check if we missed any, by going through any issues returned by this query https://github.com/kubernetes/enhancements/issues?q=is%3Aissue%20(label%3Atracked%2Fyes%20OR%20label%3Atracked%2Fno) and removing the label as appropriate:
```
/remove-label tracked/yes
/remove-label tracked/no
```

### Part 3: Opt-in reminders

If there are any KEPs with the new milestone `{current release}` but don't have `lead-opted-in`, then we need to remind them to opt in if they plan to work on it this cycle. For any results returned by this query `https://github.com/kubernetes/enhancements/issues?q=is%3Aissue%20state%3Aopen%20-label%3Alead-opted-in%20milestone%3A{current release}`, post a message like:
```
Hi {enhancement owner} 👋, {current release} Enhancements Lead here.

It looks like this enhancement has been added to the {current release} milestone, but doesn't yet have the `lead-opted-in` label. Just a gentle reminder that if you plan to work on this enhancement in {current release}, please have the SIG lead opt in by adding the `lead-opted-in` label, which will ensure it gets added to the tracking board.

Thanks!
```

### Part 4: Verify cleanup

Make sure these queries both return empty now:
- `https://github.com/kubernetes/enhancements/issues?q=is%3Aissue%20label%3Alead-opted-in%20-milestone%3A{current release}`
- https://github.com/kubernetes/enhancements/issues?q=is%3Aissue%20(label%3Atracked%2Fyes%20OR%20label%3Atracked%2Fno)

 If so, then cleanup is done and we can start setting up the new board!


## Setting Up New Tracking Board

Important: Make sure you have gone through the steps to [clean up the previously tracked issues](#cleaning-up-previously-tracked-issues) above, before setting up the new board.

### Option 1: Copying Previous Board (Preferred)

The easiest way to set up the new board is to make a copy of the board from the previous release (which will copy over all the views and columns), and then clean up some of the field values.

1. Go to https://github.com/orgs/kubernetes/projects, select the tracking board from last release, and click `Make a copy` (you can leave it private at first)
2. In the settings for the new project, go through all the fields and clear out the assignees that are no longer relevant (e.g. from `Enhancements Contact`, `Docs Assignee`, `Comms Opt-in Assignee`, `Comms Editor`).
    - You can leave yourself and other leads for the current release there, but remove the shadows since they will change.
    - Leave the `PRR Assignees` alone, as those are managed by the Production Readiness Review team.
3. Make the tracking board public
4. Close the enhancements tracking board for the previous release

### Option 2: Manual Steps (Old)

While it's generally easier / preferable to use [Option 1](#option-1-copying-previous-board-preferred) to create the new board, below are steps to manually create the board, for reference:

- Navigate to https://github.com/orgs/kubernetes/projects/, click the `New Project` button, select the `Table` template (default), and click the `Create` button.
- Update project settings by clicking `...` -> `Settings` from the project board
  - Update the `Project name` to reflect the current release, e.g. **1.29 Enhancements Tracking**
  - Set the project's `Visibility` to **Public**
- Update project access by clicking `Manage Access` from the settings page
  - Set the `Base role` access to **Read**
  - Add the following GitHub teams with **Admin** access
    - @release-team-leads
  - Add the following GitHub teams with  **Write** access
    - @production-readiness
    - @release-team-comms
    - @release-team-docs
    - @release-team-enhancements
    - @prod-readiness-reviewers
  - Add the @k8s-infra-ci-robot account to the board with **Write** access.
- Create all the Fields (columns) for the board
  > Note: This is currently a manual process and  <https://github.com/orgs/community/discussions/41133> filed to help automate the process.
  > Note: Since `v1.30` an exceptions process for the Release Doc team is enforced. The previous PR Ready for Review deadline has been replaced with a Docs Freeze phase. Make sure to add `At Risk for Docs Freeze` and `Tracked for Docs Freeze` to the options in `status` column. Moreover add `docs` to the options in `type` column.
  - Until this can be automated; manually create fields with the same `Field Name`, `Field type`, and `Option` values from the previous release's project board.
- Create all the Views for the board
  > Note: This is also currently a manual process until GitHub GraphQL APIs allow for manipulating Views
  - Until this can be automated; manually create Views with the same Names and Fields from the previous release's project board.
    Tip: You can easily view all the Fields present in each view by clicking the `v` next to the View's name a selecting `Configuration` -> `Fields`
    Note: Remember to **save** each View. If there is a blue bubble next to the Views name there are unsaved changed for that view!
- Disable all Workflows for the project (these should all be disabled by default, but just double check)
  - Click `...` -> `Workflows`
  - For each workflow that is enabled (has a green circle next to it), click the workflow and slide the toggle to 'Off'


## Enabling Tracking Board Automation

Important: Make sure you have gone through the steps to [clean up the previously tracked issues](#cleaning-up-previously-tracked-issues) and [set up the new tracking board](#setting-up-new-tracking-board) above, before setting up automation.

In order for KEPs to appear on the new tracking board, we need to open a pull request in [k/test-infra](https://github.com/kubernetes/test-infra) that enables the automatic syncing of issues with the `lead-opted-in` label to the new tracking board. The PR must contain the following changes:
  - Update the [`GITHUB_PROJECT_BETA_NUMBER`](https://github.com/kubernetes/test-infra/blob/3de59f96b327c87c6d23a7308abc785268931707/config/jobs/kubernetes/sig-k8s-infra/trusted/sig-release-release-team-jobs/release-team-periodics.yaml#L20-L21) variable used by automation to identify the enhancements tracking board for the current release.
  - Enable the test-infra job that syncs enhancements to the GitHub project board based on the `lead-opted-in` label. Update the name of the [periodic-sync-enhancements-github-project](https://github.com/kubernetes/test-infra/blob/master/config/jobs/kubernetes/sig-k8s-infra/trusted/sig-release-release-team-jobs/release-team-periodics.yaml#L2) cronjob with the version number of the release and enable the cronjob by commenting the impossible cron and uncommenting the `interval`.

Previous PRs for reference:
- [v1.35 enable periodic sync](https://github.com/kubernetes/test-infra/pull/35548)
- [v1.34 enable periodic sync](https://github.com/kubernetes/test-infra/pull/34816)

## Disabling Tracking Board Automation

At [PRR Freeze](/releases/release_phases.md#prr-freeze), we need to disable the automatic syncing of KEPs to the tracking board. This involves opening a pull request in [k/test-infra](https://github.com/kubernetes/test-infra) that does the inverse of the change [above](#enabling-tracking-board-automation).

Previous PRs for reference:
- [v1.35 disable periodic sync](https://github.com/kubernetes/test-infra/pull/35664)
- [v1.34 disable periodic sync](https://github.com/kubernetes/test-infra/pull/35003)