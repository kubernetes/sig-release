Bug Triage Release Team Role
==============================

**This is an incomplete draft.  It will be updated through the 1.10 release cycle to complete it.**

Your job for the release is to make sure that bugs (issues) and their related PRs which affect the release are dealt with in a timely fashion.  In general, you will be polling bugs, checking status, sending reminders and questions to contributors and SIG leads, and publishing summary reports.

Secondarily, you will be helping improve automation around issue management and release tagging.

How this works depends on where you are in the release cycle.  There are five relevant periods where your workload changes:

1. Early Release: between Feature Freeze and a week before Code Slush.
2. Pre-Code-Slush: a week to 10 days before Code Slush
3. Code Slush: from Code Slush to Code Freeze, usually 3-4 days.
4. Code Freeze: from Code Freeze through Betas, until Release Burndown
5. Release Burndown: Less than 1 week until final release.

## How You Do Your Job

As Issue Triage lead, it is not your job to fix, label, sort, or gatekeep issues.  It is your job to get the SIGs, the issue owners, and the key contributors to do it.  So whenever you find an issue that needs to be "fixed" or kicked out of the release, you go through the following escalation:

1. leaving a comment on the issue, e.g. "This issue hasn't been updated in 3 months.  Are you still expecting to complete it for 1.11?"
2. sending a message to the SIG channel or mailing list about the issue.  It's helpful here to condense issues into lists if there's several, e.g. "Hey, these three issues haven't seen any attention, are they still valid for 1.11?"
3. messaging individual issue owners and reviewers via Slack and/or email.
4. escalating to the Release Team Lead with suggestions on what to do with non-responsive issues.

In practice, you should fix anything simple that saves folks time and doesn't usurp the decision-making of the SIGs.  For example, adding/modifying kind and priority labels, or making PR labels match issue labeling.  However, you should never decide whether something is in or out of a milestone; the SIG or the RT captain needs to do that.

## Early Release

You have no critical work during this cycle.  Instead, use the time to familiarize yourself with the major features and fixes planned by each SIG for this release, so that you'll be ready for issues which come up with them.  This is also a good time to do any work on automation that you plan to do.  You can also get started early on the pre-code-slush work.

### Sample Searches

* Open Feature Issues: `is:issue is:open milestone:v1.10 repo:kubernetes/features`
* All Issues in the milestone K/K: `is:open is:issue milestone:v1.10 repo:kubernetes/kubernetes`
* All Issues in any repo: `is:open is:issue milestone:v1.10 org:kubernetes`
* Issues in the milestone which haven't been updated in a while: `is:open is:issue milestone:v1.10 updated:<2018-01-01 repo:kubernetes/kubernetes`
* Issues in the milestone with no SIG or Kind: code needed
* Feature Issues with no PR: code needed

### Reports

No reports are required during this period, although you might consider setting up a red/yellow/green report template.

## Pre-Code-Slush

During this period your job is to make sure that all issues which are related to Features for the upcoming release.  While you've been doing that some earlier, now you have a deadline (the beginning of Code Slush) where every feature issue has to be linked.  Specifically:

* each Feature issue should have a milestone, kind, and sig.
* PRs linked to these feature issues should have the same labels (and milestone)
* priority should be important-soon or critical-urgent

If issues do not match the above, you should comment and urge the SIGs to fix them, or even fix some labels yourself (particularly kind and sig).

The second thing you need to do is to start filtering issues which have been assigned to the milestone, specifically getting SIGs to change milestones on issues which are not making progress.  For example, if there's an issue with no consensus on an approach to fix it, and no PRs, you should comment and suggest that that issue be taken out of the milestone.

The third thing you should do, time permitting, is to look at issues which are bugs or test failures to see if they're failures against the upcoming release features, especially critical ones.  For ones which are, you should ensure that they have all the correct labelling to be tracked and udpated.

### Sample Searches



### Reports

## Code Slush

At the beginning of Code Slush, all issues to stay in the milestone need to have the following characteristics.  PRs for the milestone should share the same labels.

* kind, sig, and milestone labels
* status/approved-for-milestone

All issues should also show progress and that they're getting attention between Code Slush and Code Freeze.  If they're not, you need to get the attention of the SIG(s) on those specific issues, and find out if they're going to fix them or take them out of the milestone.  Also, SIGs need to make a decision on "approved-for-milestone" during Code Slush; you need to remind them to do so on each issue.

Even when issues have PRs resolving them, these PRs can get stuck in the approval process. This means it's going to be your job to remind SIG leads of the stuck PRs until they get approved and merged.

Checking newly-reported test failures is now more urgent; you should assume that any new failure is related to the upcoming release and try to get follow-up from the appropriate SIG.

### Sample Searches


### Reports

Starting with Code Slush, you should report on issue status at least three times per week.  This report will break down into red/yellow/green issues and PRs.  As you get closer to release, the specific definitions of red/yellow/green will change, but the basic idea won't:

* red: issues/PRs which don't seem to be headed towards any resolution on deadline, and represent either major breakage or features still in the release
* yellow: issues/PRs which are in progress but need to be watched
* green: issues/PRs which still show up on the reports, but are on their way to being resolved very soon

In Code Slush, these three levels are:

* red: major breakage issues which are both old and getting no attention at all, and feature issues without a PR.
* yellow: major breakage issues with a PR in progress, minor breakage issues, and feature issues with a PR which is in progress but still needs work.
* green: minor breakage issues with a PR and feature issues with a PR that looks to be approved soon.

You should also identify to the release team those areas which appear to need major attention (e.g. upgrade testing, some specific feature).

## Code Freeze

Once Code Freeze starts, all issues still in the upcoming release **must** be approved-for-milestone and priority/critical-urgent.  This means that, on the morning before Code Freeze begins you need to go through the open issues (and PRs) which are approved-for-milestone and escalate them to critical-urgent, in order to open the github spam floodgates (at some point, this task will be taken care of via automation).  Once the RT Lead flips the switch for Code Freeze, any issues not marked both approved-for-milestome and critical-urgent will be kicked out of the milestone by the bot.

After this, you need to monitor all of these issues to make sure that daily progress is made on them.  Theoretically, issue owners/SIGs are supposed to make a daily status comment in the issue, but this is seldom followed. You also will need to send daily reminders/queries about stuck PRs.

New test failures will also show up during Code Freeze, and you need to make sure that these are labeled properly and get attention from the appropriate SIGs.

As Code Freeze progresses, you should get increasingly aggressive about getting SIGs to kick out any issue which doesn't represent substantial breakage in the new release.  Particularly, new features which aren't making rapid progress need to either jump to the next release, or reduce their scope.  You can remove issues from the release by downgrading their priority, but it's really better if the SIGs do it.

### Sample Searches


### Reports

We're still doing the red/yellow/green reports:

* red: major breakage issues which are not making daily progress, and feature issues without a PR which looks to be approved soon.
* yellow: major breakage issues with a PR in good shape, minor breakage issues, and feature issues with a PR in good shape.
* green: minor breakage issues with a good PR and feature issues with a PR that is just waiting on merge.

There will also be several features which will have requested exceptions from the normal release timeline/requirements.  You'll want to track the exceptions specifically and report on them.

## Release Burndown

Starting a few working days before the first Release Candidate, we go into Sudden Death Overtime.  At this point, you need to make sure that three things happen:

1. major breakage bugs get fixed immediately
2. any pending PRs get approved and merged
3. anything else gets kicked out of the release

During this period, it's reasonable to expect issue owners and SIG leads to get back to you within hours (check their time zones, though).  In cases where SIG Leads are unavailable, you may need to appeal to Kubernetes project leaders to deal with stuck PRs.

### Sample Searches


### Reports

During Release Burndown, you need to report on issue status at least once per day.

* red: major breakage issues or feature issues without a PR which looks to be approved very soon.  Minor breakage issues with no PR.
* yellow: major breakage issues with an nearly-approved PR, minor breakage issues with a PR, and feature issues with a nearly-approved PR.
* green: issues and PRs which are just waiting on being taken out of the milestone.
