Bug Triage Release Team Role
==============================

Your job is to make sure that bugs which affect the release are dealt with in a timely fashion.  Bugs can appear either as GitHub Issues or Pull Requests (PRs).  

Primarily, you will be polling bugs, checking status, sending reminders and questions to contributors and SIG leads, and publishing summary reports.  The role has been interchangeably called "Bug Triage" and "Issue Triage", but the general term "issue" can be conflated with the specific GitHub usage of `is:issue` artifact type.  It is important to consider both `is:issue` and `is:pr` GitHub artifacts when triaging bugs.

Secondarily, you will be helping improve automation around artifact management and release tagging.

How this works depends on where you are in the release cycle.  There are five relevant periods where your workload changes:

1. Early Release: between Enhancement Freeze and a week before Code Slush.
2. Pre-Code-Slush: a week to 10 days before Code Slush
3. Code Slush: from Code Slush to Code Freeze, usually 3-4 days.
4. Code Freeze: from Code Freeze through Betas, until Release Burndown
5. Release Burndown: Less than 1 week until final release.

## How You Do Your Job

As Bug Triage lead, it is not your job to fix, label, sort, or gatekeep issues and PRs.  It is your job to get the SIGs, the issue or PR owners, and the key contributors to do it.  So whenever you find a bug that needs to be "fixed" or kicked out of the release, you go through the following escalation:

1. Leaving a comment on the GitHub issue or PR, e.g. "This issue hasn't been updated in 3 months.  Are you still expecting to complete it for 1.11?".  It's helpful here to @ mention individuals or SIG ```-bugs``` or ```-pr-reviews``` aliases, e.g. "@kubernetes/sig-node-bugs" or "@kubernetes/sig-network-pr-reviews".
2. Sending a message to the SIG channel or mailing list about the problem.  It's helpful here to condense multiple issues into a list, e.g. "Hey, these three issues haven't seen any attention, are they still valid for 1.11?"
3. Messaging individual owners and reviewers via Slack and/or direct email (GitHub notification emails must have been filtered or missed if you're past step #1).  Individual's email addresses may be harder to find than GitHub ID, but ure usually in the git commit history.  Slack handles are often harder yet to find.  There is no master list mapping human names to GitHub ID, email or Slack ID.  If you can't find contact info, asking in the appropriate SIG's Slack channel will usually get you pointed in the right direction.
4. Escalating to the Release Team Lead with suggestions on what to do with non-responsive issues.

In general, you should never decide whether something is in or out of a milestone; the SIG or the Release Team Lead needs to do that.  In practice, you should fix anything simple that saves folks time when the intent is obvious or a milestone decision has been made.  For example, you might add/modify kind and priority labels for a PR to match a correlating issue, or make sure an urgently awaited PR is in the milestone so it will pass CI.  See [the documentation for issue kind labels](https://git.k8s.io/community/contributors/devel/release.md#issue-kind-label)

The job relates to both the Enhancements Lead and CI Signal Lead roles.  Understanding the in-bound enhancements is important during the Early Release phase.  Having an awareness on current test status is also critical, even though there is a specific lead for that area.  The [documentation for CI Signal lead role](../ci-signal) includes a listing of special high risk test categories to monitor with useful information for the Bug Triage Lead to also understand.  The Bug Triage Lead should regularly interact with the peer leads for Enhancements and CI Signal.

## Early Release

You have no critical work during this cycle.

Instead, use the time to familiarize yourself with the major enhancements and fixes planned by each SIG for this release, so that you build context in advance of when you will need to identify incoming bugs as being associated with a work focus in the current release.  It is a good time to interact with the Enhancements Lead and CI Signal Lead to understand any early concerns they might have, as the release team's risk management comes as much from this proactive collaboration more as from the Bug Triage lead reacting to incoming issues and PRs.

This is also a good time to do any work on automation that you plan to do.  You can also get started early on the pre-code-slush work.

### Sample Searches

* Open Enhancement v1.11 Issues:
  * `is:issue is:open milestone:v1.11 repo:kubernetes/enhancements` [k/enhancements repo milestone enhancements](https://github.com/kubernetes/enhancements/issues?q=is%3Aopen+is%3Aissue+milestone%3Av1.11)
  * `is:issue is:open milestone:v1.11 label:kind/feature repo:kubernetes/kubernetes` [k/k repo milestone enhancements](https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+is%3Aissue+milestone%3Av1.11+label%3Akind%2Ffeature)
  * `is:issue is:open milestone:v1.11 label:kind/feature org:kubernetes` [k org-wide milestone enhancements](https://github.com/search?q=org%3Akubernetes+is%3Aissue+is%3Aopen+milestone%3Av1.11+label%3Akind%2Ffeature)
* Issues in the v1.11 milestone which haven't been updated in a while: `is:open is:issue milestone:v1.11 updated:<2018-05-01 repo:kubernetes/kubernetes` [k/k old issues in milestone](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+updated%3A%3C2018-05-01+repo%3Akubernetes%2Fkubernetes)
* Issues in the milestone with no SIG or Kind: **code/automation needed**
* Enhancement Issues with no PR: **code/automation needed**

### Reports

No reports are required during this period, although you might consider setting up a red/yellow/green report template.

## Pre-Code-Slush

During this period your job is to make sure that all issues and PRs which are related to bugfixes for the upcoming release have reasonable labels.  While you may have been doing that some earlier, now you have a deadline.  From the beginning of Code Slush every bug issue or PR should be linked to the milestone.  Specifically:

* each issue should have a milestone, kind, and sig.
* PRs linked to these issues should have the same labels (and milestone)
* priority should be important-soon or critical-urgent

If issues do not match the above, you should comment and urge the SIGs to fix them, or even fix some labels yourself (particularly kind and sig).

The second thing you need to do is to start filtering issues which have been assigned to the milestone, specifically getting SIGs to change milestones on issues which are not making progress.  For example, if there's an issue with no consensus on an approach to fix it, and no PRs, you should comment and suggest that that issue be taken out of the milestone.

The third thing you should do, time permitting, is to scan through the newly opened issue and PR lists for bugs to see if they're failures against the upcoming release enhancements, especially critical ones.  For ones which are, you should ensure that they have all the correct labelling to be tracked and updated.  Depending on volume and time, you may wish to exclude ```label:"kind/feature"``` and ```label:"kind/failing-test"``` from your searches, as those are covered by the Enhancements and CI Signal leads respectively.

### Sample Searches
* Open v1.11 Issues
   * `is:open is:issue milestone:v1.11 -label:"kind/feature" -label:"kind/failing-test"` [milestone open issues, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
* Open v1.11 PRs
   * `is:open is:pr milestone:v1.11 -label:"kind/feature" -label:"kind/failing-test"` [milestone open PRs, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.11+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)

### Reports

No reports are required during this period, although you should be maintaining a red/yellow/green report template starting now.

## Code Slush

At the beginning of Code Slush, all issues to stay in the milestone need to have the following characteristics.  PRs for the milestone should share the same labels.

* kind, sig, and milestone labels

All bugs should also show progress towards resolution and that they're getting attention between Code Slush and Code Freeze.  If they're not, you need to get the attention of the SIG(s) on those specific bugs, and find out if they're going to fix them or target the fix for a future milestone instead.  Also, SIGs need to make a decisions on milestone inclusion and prioritization; you need to remind them to do so on each bug for example reminding them to run the "/milestone vX.YY" and "/priority ${prioritylevel}" Prow commands.

Even when bugs have PRs resolving them, these PRs can get stuck in the approval process. This means it's your job to remind SIG leads of any stuck PRs until they get approved and merged.

Checking newly-reported test failures is now more urgent; you should assume that any new failure is related to the upcoming release, bring to the attention of the CI Signal lead, and assist in getting follow-up from the appropriate SIG.  Generally the CI Signal lead will track these failures, but newly opened issues may not initially have sufficient labelling to catch their attention.

A detailed page is in the [developer guide](https://git.k8s.io/community/contributors/devel/release.md) describing how developers target issues and pull requests to a milestone.

### Sample Searches

* Open v1.11 Issues
  * `is:open is:issue milestone:v1.11 -label:"kind/feature" -label:"kind/failing-test"` [milestone open issues, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:issue milestone:v1.11` [milestone open issues, no exclusions](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+)
* Open v1.11 PRs
  * `is:open is:pr milestone:v1.11 -label:"kind/feature" -label:"kind/failing-test"` [milestone open PRs, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.11+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:pr milestone:v1.11"` [milestone open PRs, no exclusions](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.11+)

### Reports

Starting with Code Slush, you should report on issue status at least three times per week.  This report will break down into red/yellow/green issues and PRs.  As you get closer to release, the specific definitions of red/yellow/green will change, but the basic idea won't:

* red: issues/PRs which don't seem to be headed towards any resolution on deadline, and represent either major breakage or enhancements still in the release
* yellow: issues/PRs which are in progress but need to be watched
* green: issues/PRs which still show up on the reports, but are on their way to being resolved very soon

In Code Slush, these three levels are:

* red: major breakage issues which are both old and getting no attention at all, and enhancement issues without a PR.
* yellow: major breakage issues with a PR in progress, minor breakage issues, and enhancement issues with a PR which is in progress but still needs work.
* green: minor breakage issues with a PR and enhancement issues with a PR that looks to be approved soon.

You should also identify to the release team a "leader board" of those areas which appear to need major attention (e.g. upgrade testing, some specific enhancement).

The Release Lead will include a template for this information in the Monday/Wednesday/Friday release team meeting notes.

## Code Freeze

Once Code Freeze starts, all issues still in the upcoming release **should** have a priority label of `priority/critical-urgent`.  This means that on the morning before Code Freeze begins you need to go through the open issues (and PRs) which are approved-for-milestone but not marked critical-urgent and poke the owners reminding them that in the next day Code Freeze will mean any issues not marked `priority/critical-urgent` will potentially be moved to the subsequent release. 

The criteria for moving issues is a mix of:

- How critical is the Issue to be fixed for the currently imminent release?
- Is the PR expected to be ready for merging soon?
- How big is the change? Could it cause instability to CI? If so, it either needs to be closely tracked /or/ moved.

After this, you need to monitor all of these issues to make sure that daily progress is made on them.  Theoretically, issue owners/SIGs are supposed to make a daily status comment in the issue, but this is seldom followed. You also will need to send daily reminders/queries about stuck PRs.

New test failures will also show up during Code Freeze and you need to make sure that these are labeled properly, get attention of the CI Signal lead, and get attention from the appropriate SIGs.

As Code Freeze progresses, you should get increasingly aggressive about getting SIGs to kick out any issue which doesn't represent substantial breakage in the new release.  Particularly, new enhancements which aren't making rapid progress need to either jump to the next release, or reduce their scope.  You can remove issues from the release by downgrading their priority, but it's really better if the SIGs do it.  Start watching for issues with the release version string in them, eg: "1.11.0-beta".

### Sample Searches

* Open v1.11 Issues
  * `is:open is:issue milestone:v1.11 -label:"kind/feature" -label:"kind/failing-test"` [milestone open issues, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:issue milestone:v1.11` [milestone open issues, no exclusions](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+)
  * `is:open is:issue created:>2018-06-14` [open issues, no exclusions, created since you last looked](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen++created%3A%3E2018-06-14)
  * `is:open is:issue modified:>2018-06-14` [open issues, no exclusions, modified since you last looked](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen++modified%3A%3E2018-06-14)
* Open v1.11 PRs
  * `is:open is:pr milestone:v1.11 -label:"kind/feature" -label:"kind/failing-test"` [milestone open PRs, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.11+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:pr milestone:v1.11"` [milestone open PRs, no exclusions](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.11+)
  * `is:open is:pr created:>2018-06-14` [open PRs, no exclusions, created since you last looked](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen++created%3A%3E2018-06-14)
  * `is:open is:pr modified:>2018-06-14` [open PRs, no exclusions, modified since you last looked](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen++modified%3A%3E2018-06-14)
* Reports against the beta(s):
  * `is:issue "1.11.0-beta"' [issues mentioning beta version](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=%221.11.0-beta%22)
  * `is:pr "1.11.0-beta"' [PRs mentioning beta version](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=%221.11.0-beta%22)

### Reports

We're still doing the red/yellow/green reports:

* red: major breakage issues which are not making daily progress, and enhancement issues without a PR which looks to be approved soon.
* yellow: major breakage issues with a PR in good shape, minor breakage issues, and enhancement issues with a PR in good shape.
* green: minor breakage issues with a good PR and enhancement issues with a PR that is just waiting on merge.

There will also be several enhancements which will have requested exceptions from the normal release timeline/requirements.  You'll want to track the exceptions specifically and report on them.  It is useful to be tracking in a spreadsheet the open issues/PRs which have caught your attention, because GitHub queries are only point in time.  It's easy for an issue you want to follow to stop showing up in a query and thus fall off your radar if you're only going by the queries.

The Release Lead will include a template for this information in the Monday/Wednesday/Friday release team meeting notes.

## Release Burndown

Starting a few working days before the first Release Candidate, we go into Sudden Death Overtime.  At this point, you need to make sure that three things happen:

1. major breakage bugs get fixed immediately
2. any pending PRs get approved and merged
3. anything else gets kicked out of the release

During this period, it's reasonable to expect issue owners and SIG leads to get back to you within hours (check their time zones, though).  In cases where SIG Leads are unavailable, you may need to appeal to Kubernetes project leaders to deal with stuck PRs.

Another part of staying on top of code churn, regression, and risk is monitoring commits to master and the release branch especially in the final days of the release, as shown below in Sample Searches for this phase.  On occasion things will merge that are unexpected by the release team.  This possibility needs monitored and when it happens the commits need triaged for destabilizing risk and proper exception justification, tests, docs, etc.

### Sample Searches

Same as in code freeze.  Here it becomes critical to have recorded the results of prior queries to compare what issues/PRs have come into or left from the query results compared to the last time you ran a query.

Additionally for tracking recent changes to master and the release branch,
eg:
* [master branch commits](https://github.com/kubernetes/kubernetes/commits/master/)
* [release-1.11 branch commits](https://github.com/kubernetes/kubernetes/commits/release-1.11)

### Reports

During Release Burndown, you need to report on issue status at least once per day.

* red: major breakage issues or enhancement issues without a PR which looks to be approved very soon.  Minor breakage issues with no PR.
* yellow: major breakage issues with an nearly-approved PR, minor breakage issues with a PR, and enhancement issues with a nearly-approved PR.
* green: issues and PRs which are just waiting on being taken out of the milestone.

The Release Lead will include a template for this information in the daily Monday through Friday release team meeting notes.

During this short period it may also be necessary to check in on and report out status changes on the weekend.  This should be an exception versus the norm because all the prior months' work by the release team and community has led to well managed and understood risks, but surprises do happen.
