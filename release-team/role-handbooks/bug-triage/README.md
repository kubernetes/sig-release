# Bug Triage Role Handbook

- [Bug Triage Role Handbook](#bug-triage-role-handbook)
  - [Overview](#overview)
  - [Responsibilities](#responsibilities)
  - [Requirements](#requirements)
    - [Time Requirements](#time-requirements)
    - [Additional Requirements for Shadows](#additional-requirements-for-shadows)
    - [Additional Requirements for Leads](#additional-requirements-for-leads)
  - [Getting Started](#getting-started)
    - [How to Escalate](#how-to-escalate)
  - [Timeline](#timeline)
    - [Early Release](#early-release)
      - [Setting up the Bug Triage Spreadsheet](#setting-up-the-bug-triage-spreadsheet)
      - [Updating the Bug Triage Spreadsheet](#updating-the-bug-triage-spreadsheet)
      - [Sample Searches](#sample-searches)
      - [Reports](#reports)
    - [Mid-Release Cycle](#mid-release-cycle)
      - [Reports](#reports-1)
    - [Code Freeze](#code-freeze)
      - [Day Of The Code Freeze](#day-of-the-code-freeze)
      - [Once the Code Freeze starts until one week later](#once-the-code-freeze-starts-until-one-week-later)
      - [Week 1 of Code Freeze until Code Thaw starts](#week-1-of-code-freeze-until-code-thaw-starts)
      - [Reports](#reports-2)
    - [Code Thaw](#code-thaw)
      - [Sample Searches](#sample-searches-1)
      - [Reports](#reports-3)

## Overview

The bug triage team is responsible to make sure that Issues and Pull Requests (PRs) which are targeted for the ongoing release cycle are dealt with in a timely fashion.

The role has been interchangeably called "Bug Triage" and "Issue Triage", but the general term "issue" can be conflated with the specific GitHub usage of `is:issue` artifact type. It is important to consider both `is:issue` and `is:pr` GitHub artifacts when triaging bugs.

## Responsibilities

The bug triage role has the following responsibilities:

- Listing open issues and PRs targeted for the ongoing release cycle
- Communicating with relevant assignees, owners, and SIG leads of issues/PRs to get the status
- Updating issues/PRs, clarifying situations, enabling next level decision making
- Presenting summary reports at release team and burndown meetings
- Maintaining the automation around tracking issues/PRs against the current milestone

There are four relevant periods where the workload changes:

1. Early Release: from week 0 up to mid-release cycle (week 6). *Duration: ~6-7 weeks*
2. Mid release: from week 6 up to the code freeze (around week 9). *Duration: ~3-4 weeks*
3. Code Freeze: from around week 9 up to the code thaw (week 11). *Duration: ~2 weeks*
4. Code Thaw: the last week of the cycle. *Duration: 1 week*

## Requirements

**Before continuing on to the Bug Triage specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Time Requirements

Bug Triage has a lower time requirement than most roles at the beginning of the release cycle, however, leading up to and during Code Freeze, that requirement increases drastically.

General time requirements for Leads and Shadows are:

- Availability to attend the majority of Release Team (weekly) and Burndown meetings
- Ability to follow-up on issues and PRs since around week 6 (mid-release)
- From week 6 to the end of the release cycle the time commitment becomes greater. Shadows should expect to spend at least 3-5 hours and leads around 5-10 hours a week.

### Additional Requirements for Shadows

- Have signed the contributor CLA for Kubernetes.
- [Become a Kubernetes org member](https://git.k8s.io/community/community-membership.md#member). This should be done with the sponsorship of the Bug Triage Lead and the Release Lead in the first weeks of the cycle.
  - The process to become one of these is in [our community membership ladder](https://github.com/kubernetes/community/blob/master/community-membership.md#requirements-for-outside-collaborators)
- General familiarity with GitHub labels and how to find issues/PRs for the current milestone.
- Commitment to follow-up with contributors about issues/PRs on Slack, mailing lists, and SIG meetings, as appropriate.
- General knowledge of the [Kubernetes Community governance model](https://git.k8s.io/community/governance.md#community-groups), specifically, a SIGs' areas of responsibility.

Additionally, the following qualifications make a candidate more suitable for the Bug Triage team, but are not requirements:
- Experience with quality assurance and bug tracking systems.
- Experience with the GitHub automation.

### Additional Requirements for Leads

In addition to the above requirements for Shadows, most of which become prerequisites, Bug Triage Leads must:

- Have the ability to add a milestone to issues/PRs, so must be a member of the [milestone maintainers team](/release-team/README.md#milestone-maintainers)
- Have a working knowledge of GitHub labeling and labels used by the project. Bug Triage leads must be able to identify relevant issues and PRs for a given milestone.
- Have an understanding of what defines a Release Blocking issue or PR, or know who to contact to determine that information.

## Getting Started

As the Bug Triage lead, _it is not your job_ to make decisions in what milestone issue/PR should end up, how should it be prioritized, or to gatekeep issues and PRs. Instead, you should get the assignees, owners, SIG leads or key contributors to do it, as it is their job to do so. Check [How To Escalate](#how-to-escalate) on how you can do it.

In practice, you should fix anything simple that saves folks time when the intent is obvious or a milestone decision has been made. For example, you might add/modify `kind` and `priority` labels for a PR to match a correlating issue, or make sure an urgently awaited PR is in the milestone so it will pass CI.

The Bug Triage role relates to both the Enhancements and CI Signal roles. Understanding the in-bound enhancements is important during the Early Release phase as they set the themes for incoming issues and bugs. Having an awareness on current test status is also critical, even though there is a specific lead for that area. The [documentation for CI Signal lead role](../ci-signal) includes a listing of special high risk test categories to monitor with useful information for the Bug Triage to also understand. The Bug Triage Lead should regularly interact with the peer leads for Enhancements and CI Signal.

Before starting, the Bug Triage members should refer to the following guides to get familiar with used labels:
- [the documentation for issue `kind` labels](https://git.k8s.io/community/contributors/devel/sig-release/release.md#issuepr-kind-label)
- [the documentation for defining priority and `priority` labels](https://github.com/kubernetes/community/blob/master/contributors/guide/issue-triage.md#define-priority).

### How to Escalate

Whenever you find an issue or PR that needs to be finished or kicked out of the release, try the following escalation path:

1. Leave a comment on the GitHub issue or PR: "This issue hasn't been updated in 3 months. Are you still expecting to complete it for 1.17?". It's helpful to @ mention individuals or SIG ```-bugs``` or ```-pr-reviews``` aliases, e.g. "@kubernetes/sig-node-bugs" or "@kubernetes/sig-network-pr-reviews".
2. Send a message to relevant SIG Slack channel or mailing list about the problem: It's helpful to directly @ mention the relevant SIG Leads / Owners, and to condense multiple issues into a list, e.g. "Hey, these three issues haven't seen any attention, are they still valid for 1.17?"
3. Message individual owners and reviewers directly via Slack. If owners and reviewers are unresponsive, you can reach out to the SIG leads using the `kubernetes-sig-${name}-leads@googlegroups.com` mailing lists.
4. Escalate to the Release Team Lead with suggestions on what to do with non-responsive issues.

## Timeline

### Early Release

This stage lasts about 6 weeks (from week 0 until week 6/mid-release cycle).

You should use this time to familiarize yourself with the _major enhancements and fixes_ planned by each SIG for this release, so that you can have context in advance of when you will need to identify incoming bugs as being associated with a work focus in the current release. This can greatly help in focused communication with the relevant SIG leads, as in later stages there can be an elevated urgency to fix related critical bugs and deliver new features in time.

It is also a good time to interact with the Enhancements Lead and CI Signal Lead to understand any early concerns they might have, as the release team's risk management comes as much from this proactive collaboration more as from the Bug Triage lead reacting to incoming issues and PRs.

The major and potentially release-blocking PRs/issues in this stage should be identified and a strategy to distribute them among the team should be devised. It is also important to identify _priority/critical-urgent_ and _priority/important-soon_ PRs/issues early on which could become release blocking later in the cycle.

This is the best stage to get involved with any automation work that can ease the workload of later stages. Some tasks include:
- updating/extending scripts to populate spreadsheets with relevant issues/PRs, delegate them to Bug Triage team members, and track them.
- automation of notifications on relevant issues/PRs of the release cycle timeline.
- automation of tracking/categorizing issues/PRs by responses to notifications of release cycle timeline.

In order to make work at later stages easier, it can also be beneficial to start pinging stale or long-running issues / PRs, so that an early assessment can be made if these should be moved out of the current release cycle's milestone.

It is also important to make sure all membership requirements and permissions needed for the Shadows are in place, for example that they have org access and are added as `milestone-maintainers`.

#### Setting up the Bug Triage Spreadsheet

The Bug Triage team is using a tracking spreadsheet to track the current status of all issues and PRs targeting the release, their priorities, and to distribute the work among the Bug Triage team.

At the beginning of the cycle, the Bug Triage Lead should communicate with the Release Team Lead to get the spreadsheet set up for the ongoing release cycle.

Once the spreadsheet is created, the lead needs to update queries in the spreadsheet script to fetch issues and PRs for the correct milestone. To edit the script, choose Tools -> Script editor, and then replace the milestone in queries with the correct one.

With this done, the lead needs to put the link to the spreadsheet in the relevant places, usually in the release team meeting notes and in the [release overview document](https://github.com/kubernetes/sig-release/tree/master/releases).

#### Updating the Bug Triage Spreadsheet

The Bug Triage Spreadsheet is updated manually. The spreadsheet has a dedicated `Kubernetes Github Commands` menu in the spreadsheet header that has commands for managing the data. Open the menu and first run the `Refresh Issues & PRs` command. After it is done, you can run other commands to populate issues/PRs metadata, such as `kind`, `priority` and SIGs. The menu and all commands are implemented as scripts that you can access by choosing Tools -> Script editor.

**Note:** Due to bug in the `Refresh Issues & PRs` command, it is recommended to delete the issues/PRs from the spreadsheet and then run the command. Otherwise, it may happen that some issues are omitted or shown even if closed.

At this stage of the release cycle, it is usually enough to update the spreadsheet once a week, before the release team meeting. At later stages, this is usually done 2-3 times a week and then daily.

#### Sample Searches

You can use the following queries to get yourself familiarized with issues/PRs targeting the release:

* Issues which could require early intervention
  - [Issues in the v1.17 milestone with the `priority/critical-urgent` label](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.17+label%3Apriority%2Fcritical-urgent): `is:open is:issue milestone:v1.17 label:priority/critical-urgent`

  - [PRs in the v1.17 milestone with the `priority/critical-urgent` label](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.17+label%3Apriority%2Fcritical-urgent): `is:open is:pr milestone:v1.17 label:priority/critical-urgent`

  - [Issues in the v1.17 milestone which haven't been updated since 2019-09-01](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.17+updated%3A%3C2019-09-01): `is:open is:issue milestone:v1.17 updated:<2019-09-01`

  - [PRs in the v1.17 milestone which haven't been updated since 2019-09-01](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.17+updated%3A%3C2019-09-01): `is:open is:pr milestone:v1.17 updated:<2019-09-01`

* Enhancements:

  - [k/enhancements repo milestone enhancements](https://github.com/kubernetes/enhancements/issues?q=is%3Aopen+is%3Aissue+milestone%3Av1.17) `is:issue is:open milestone:v1.17 repo:kubernetes/enhancements`

  - [k/k main repo milestone enhancements](https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+is%3Aissue+milestone%3Av1.17+label%3Akind%2Ffeature)`is:issue is:open milestone:v1.17 label:kind/feature repo:kubernetes/kubernetes`

#### Reports

It is expected that at least one member in the Bug Triage role should be present for all release team meetings to provide the report. At this stage, the report should contain the number of `priority/critical-urgent` issues/PRs and what's their status.

The status is usually going to be green or yellow depending on the number of `priority/critical-urgent` issues/PRs and are those going to be fixed in a timely manner. The number of issues/PRs is mostly irrelevant because it's changing rapidly.

### Mid-Release Cycle

This stage lasts from around week 6 until the code freeze starts (usually week 9). At this point, the Bug Triage team should start [escalating issues/PRs](#how-to-escalate) and communicating deadlines with contributors and SIG leads.

There are three main tasks that should be done:

- Ensure that issues and PRs targeting the release have a correct *milestone* and *priority* labels
  - Linked issues and PRs should have the same `priority` and `kind` labels and the milestone
- Ensure that `priority/critical-urgent` issues and PRs are not blocked
  - If you find such `priority/critical-urgent` issue/PR you should ping the owner and owner SIGs, as well as, alert the release team leads.
- Ping all issues and PRs to remind contributors and SIG leads that we are about one month away from the code freeze and what does it mean.
  - You may want to ping issues at least two times to ensure deadlines are communicated correctly, usually once this stage starts and a couple of days before the code freeze starts.

At the beginning, you should prioritize pinging issues/PRs that haven't been updated for a longer time. You can use the following queries: [`is:issue is:open milestone:v1.17 sort:updated-asc`](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.17+sort%3Aupdated-asc) and [`is:pr is:open milestone:v1.17 sort:updated-asc`](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.17+sort%3Aupdated-asc).

For pinging, the following template can be used:

```
Hello! This <issue|PR> has not been updated for a long time, so I'd like to check what's the status. The code freeze is starting <insert date> (about <number of weeks> from now) and while there is still plenty of time, we want to ensure that each PR has a chance to be merged on time.

As the PR is tagged for 1.17, is it still planned for this release?
```

#### Reports

Beside the number of the `priority/critical-urgent` issues, you can start reporting the number of `priority/important-soon` issues and how good the response rate is for pinged issues.

Similar to the early release phase, the status (green/yellow/red) depends on the number of release blocking issues/PRs. You might want to declare yellow or red if there are big number of release blocking/`priority/critical-urgent` issues and/or if they're being blocked for any reason.

### Code Freeze

One of the main purposes of Code Freeze is to ensure that the code base is stable and that most of tests are passing (CI Signal is green). At this point, only release-blocking issues and PRs (usually bug fixes/`kind/bug`) are considered to be merged.

Your responsibility here is to actively watch for any new issues/PRs targeting the milestone, monitor the status of existing issues/PRs, and filter the milestone by removing issues/PRs that are not needed for this release cycle.

#### Day Of The Code Freeze

On the day of the Code Freeze, your responsibility is to try to help contributors to get the approval on their PRs and needed label. Check [How To Escalate](#how-to-escalate) part of the document for guide how to do this.

Please note that code freeze is EOD Pacific Time (astronomical sun) on the day of.

When the code freeze starts, the highest priority has the PRs which had `approved` and `lgtm` labels before the code freeze started and are in the milestones. Depending on the merge queue length, it might be proposed to hold PRs that have `approved` and `lgtm`, but are not in the milestone (using the following query [`is:pr is:open no:milestone label:approved label:lgtm`](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+no%3Amilestone+label%3Aapproved+label%3Algtm)).

You can monitor PRs using the following queries:
- [PRs supposed to be in the merge pool (`is:pr is:open milestone:v1.17 label:approved label:lgtm -label:do-not-merge/hold`)](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.17+label%3Aapproved+label%3Algtm+-label%3Ado-not-merge%2Fhold)
- [PRs that have `approved` and `lgtm`, but are on-hold (`is:pr is:open milestone:v1.17 label:approved label:lgtm label:do-not-merge/hold`)](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.17+label%3Aapproved+label%3Algtm+label%3Ado-not-merge%2Fhold+)
- [PRs that doesn't have `approved` but have `lgtm` (`is:pr is:open milestone:v1.17 -label:approved label:lgtm`)](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.17+-label%3Aapproved+label%3Algtm)
- [PRs that doesn't have `lgtm` but have `approved` (`is:pr is:open milestone:v1.17 label:approved -label:lgtm`)](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.17+label%3Aapproved+-label%3Algtm+)

#### Once the Code Freeze starts until one week later

Usually, the removal of issues/PRs doesn't start right once the code freeze starts. Depending on the CI Signal, the merge queue length, and the release team lead's decision, it might be decided to allow some more time for PRs to get merged. At this stage, `kind/bug` PRs are prioritized, but other PRs can be allowed too if there is no risk of destabilizing the release/CI Signal (such PRs require an exception).

You can still use the queries from the previous section at this stage to monitor PRs, but you should also monitor issues using similar queries.

#### Week 1 of Code Freeze until Code Thaw starts

At this stage, the Bug Triage team should start removing issues/PRs from the milestone. Before doing so, the Bug Triage Lead should confirm the intention with the Release Team Lead.

If the issue/PR got confirmation that it's planned for the next milestone or there was recent activity, it should be moved to the next milestone using the `/milestone v1.xx` command.

If there is no response on the issue/PR and no recent activity, the issue/PR should be removed from the milestone to reduce the burden on the next Bug Triage team. This is done by using the `/milestone clear` command.

If the issue/PR has the `priority/critical-urgent` label, it should be coordinated with the owning SIG and the Release Team Lead should it be allowed to stay or should the priority be decreased and issue/PR moved to the next milestone.

#### Reports

At this point, the report is contained of the following items:
- Total number of non-test/flake related issues, number of `priority/critical-urgent` and `priority/important-soon` issues
  - If there are `priority/critical-urgent` issues, those should be listed
- Total number of PRs and number of `priority/critical-urgent` and `priority/important-soon` PRs
  - If there are `priority/critical-urgent` PRs, those should be listed
- Total number of issues, including flake/test related ones

If there are issues/PRs that are going to block the release (i.e. `priority/critical-urgent` issues) and those are not close to being merged (e.g. in the merge pool or in-review process) that status is usually red. Otherwise, the status is yellow (if such issues/PRs are close to being merged) or green (if we don't have such issues/PRs).

### Code Thaw

Starting a week before the release target date, Code Freeze labeling restrictions are lifted. At this point, you need to make sure that three things happen:

1. major breakage bugs get fixed immediately
2. any pending release-blocking PRs get approved and merged
3. _anything else should get kicked out of the release_

During this period, it's reasonable to expect issue owners and SIG leads to get back to you within hours (check their time zones, though). In cases where SIG Leads are unavailable, you may need to appeal to Kubernetes project leaders to deal with stuck PRs.

Another part of staying on top of code churn, regression, and risk is monitoring commits to master and the release branch especially in the final days of the release, as shown below in Sample Searches for this phase.  On occasion, things will merge that are unexpected by the release team.  This possibility needs to be monitored and when it happens, the commits need to be triaged for destabilizing risk and proper exception justification, tests, docs, etc.

#### Sample Searches

Most important query at this point is a plain `milestone:v1.xx`, which includes all remaining issues/PRs. Ideally, the queue should be empty.

Additionally for tracking recent changes to master and the release branch,
eg:
* [master branch commits](https://github.com/kubernetes/kubernetes/commits/master/)
* [release-1.17 branch commits](https://github.com/kubernetes/kubernetes/commits/release-1.17)

#### Reports

Same as Code Freeze.

During this short period it may also be necessary to check in on and report out status changes on the weekend. This should be an exception versus the norm because all the prior months' work by the release team and community has led to well managed and understood risks, but surprises do happen.
