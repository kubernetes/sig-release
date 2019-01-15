Bug Triage Release Team Role
==============================

Primarily, your job is to make sure that bugs which affect the release are dealt with in a timely fashion.  
Bugs can appear either as GitHub Issues or Pull Requests (PRs).  

A list of common tasks is:
- Polling for bugs (mainly issues with the label `kind/bug`)
- Checking status of open issues / PRs
- Sending reminders to relevant assignees / owners / sig-leads
- Publishing summary reports 

The role has been interchangeably called "Bug Triage" and "Issue Triage", but the general term "issue" can be conflated with the specific GitHub usage of `is:issue` artifact type.  It is important to consider both `is:issue` and `is:pr` GitHub artifacts when triaging bugs.

Secondarily, you will be helping improve automation around tracking issues against the current milestone.

How this works depends on where you are in the release cycle.  
There are four relevant periods where your workload changes:

1. Early Release: from day 1 up to about a week before Code Freeze. *Duration: ~ 7-8 weeks*
2. CodeFreeze is Coming: ~10 days before Code Freeze. *Duration: ~10 days*
3. Code Freeze: Code Freeze & Burndown, beta releases, until Code Thaw. *Duration: ~2 weeks*
4. Code Thaw: Last two weeks of the cycle. *Duration: ~2 weeks*


## How You Do Your Job

As Bug Triage lead, _it is not your job_ to label, sort or gatekeep issues and PRs.

_Instead_, you should get the assignees, owners, SIG-leads or key contributors to do it, as it is their _job_ to do so.
Check [Escalation Path](#escalation-path) on how you can do it.

In general, you shouldn't decide whether something is in or out of a milestone; either the SIG or the Release Team Lead needs to do that.  
In practice, you should fix anything simple that saves folks time when the intent is obvious or a milestone decision has been made. 
For example, you might add/modify `kind` and `priority` labels for a PR to match a correlating issue, or make sure an urgently awaited PR is in the milestone so it will pass CI.  See [the documentation for issue kind labels](https://git.k8s.io/community/contributors/devel/release.md#issue-kind-label)

Bug Triage relates to both the Enhancements Lead and CI Signal Lead roles.  Understanding the in-bound enhancements is important during the Early Release phase as they set the themes for incoming issues and bugs.  Having an awareness on current test status is also critical, even though there is a specific lead for that area.  The [documentation for CI Signal lead role](../ci-signal) includes a listing of special high risk test categories to monitor with useful information for the Bug Triage Lead to also understand.  The Bug Triage Lead should regularly interact with the peer leads for Enhancements and CI Signal.

### Escalation Path
Whenever you find a bug that needs to be "fixed" or kicked out of the release, try the following escalation path:

1. Leave a comment on the GitHub issue or PR: "This issue hasn't been updated in 3 months.  Are you still expecting to complete it for 1.14?".  It's helpful here to @ mention individuals or SIG ```-bugs``` or ```-pr-reviews``` aliases, e.g. "@kubernetes/sig-node-bugs" or "@kubernetes/sig-network-pr-reviews".
2. Send a message to relevant SIG slack channels or mailing list about the problem: It's helpful to directly @ mention the relevant SIG Leads / Owners, and to condense multiple issues into a list, e.g. "Hey, these three issues haven't seen any attention, are they still valid for 1.11?"
3. Message individual owners and reviewers directly via Slack and/or email (GitHub notification emails must have been filtered or missed if you're past step #1).  Individual's email addresses may be harder to find than GitHub ID, but ure usually in the git commit history.  Sometimes Slack handles are hard to find.  There is no master list mapping human names to GitHub ID, email or Slack ID.  If you can't find contact info, asking in the appropriate SIG's Slack channel will usually get you pointed in the right direction.
4. Escalate to the Release Team Lead with suggestions on what to do with non-responsive issues.


## Early Release 

*There is no critical work for you in this stage.*

This is the best stage to get involved with any automation work that can ease the workload of later stages.

As this stage lasts nearly 2 months up until Code Freeze, you can use this time to familiarize yourself with the _major enhancements and fixes_ planned by each SIG for this release, so that you can have context in advance of when you will need to identify incoming bugs as being associated with a work focus in the current release. This can greatly help in focused communication with the relevant SIG leads, as in later stages there can be an elevated urgency to fix related critical bugs and deliver new features in time.

It is also a good time to interact with the Enhancements Lead and CI Signal Lead to understand any early concerns they might have, as the release team's risk management comes as much from this proactive collaboration more as from the Bug Triage lead reacting to incoming issues and PRs.

### Sample Searches

* [Issues in the v1.14 milestone which haven't been updated in a while](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.11+updated%3A%3C2018-10-01+repo%3Akubernetes%2Fkubernetes): `is:open is:issue milestone:v1.14 updated:<2018-10-01 repo:kubernetes/kubernetes`

* [Issues in the milestone with no SIG or Kind](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.14+label%3Aneeds-sig): `is:open is:issue milestone:v1.14 label:needs-sig`

* Enhancements (for familiarization purposes):

  * [k/enhancements repo milestone enhancements](https://github.com/kubernetes/enhancements/issues?q=is%3Aopen+is%3Aissue+milestone%3Av1.14) `is:issue is:open milestone:v1.14 repo:kubernetes/enhancements` 

  * [k/k main repo milestone enhancements](https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+is%3Aissue+milestone%3Av1.14+label%3Akind%2Ffeature)`is:issue is:open milestone:v1.14 label:kind/feature repo:kubernetes/kubernetes` 

  * [k org-wide milestone enhancements](https://github.com/search?q=org%3Akubernetes+is%3Aissue+is%3Aopen+milestone%3Av1.14+label%3Akind%2Ffeature)`is:issue is:open milestone:v1.14 label:kind/feature org:kubernetes` 

### Reports

No reports are required during this period.


## Brace Yourselves, Code Freeze Is Coming

One of the main purposes of Code Freeze is to get issues and PRs filtered through the use of labels, with `milestone` and the `priority` label playing an important role on that.

The following items help with achieving the above:

* issues targeting your release should have a *milestone*, kind, and sig.
* PRs linked to these issues should have the same labels and milestone.
* priority should be `important-soon` or `critical-urgent`.

If the needed additions on the issues/PRs do not match the above, you can add the relevant labels.

If you are not sure (mainly priority), you can comment and ask the owner or SIG leads about the status of the issue/PR (also see [Escalation Path](#escalation-path) on pinging options).

Other regular patterns are:

Stuck PRs: Sometimes PRs get stuck in the approval process, as every PR requires both a `/lgtm` and an `/approve` by an Owner. When you detect such cases, you should remind relevant SIG Leads / Owners to review these.

CI Signal: Checking newly-reported test failures becomes more important; you should assume that any new failure is related to the upcoming release, bring to the attention of the CI Signal lead, and assist in getting follow-up from the appropriate SIG.  Generally the CI Signal lead will track these failures, but newly opened issues may not initially have sufficient labelling to catch their attention.

[The release document from the developer's guide](https://git.k8s.io/community/contributors/devel/release.md) is also a good resource on describing how developers target issues and pull requests to a milestone. 

### Filtering / What belongs in the milestone

Around this point, the release is about 1 month away, and there is less and less time for PRs to make it in time.

Filtering is one of the main functions of the Bug Triage role. It involves informing owners and SIG leads about the timelines and asking  whether an issue/PR at hand is relevant to the release, whether it should be prioritized or moved to another release via the use of `milestone`. This process involves a mix of multiple parameters such as:

- Criticality: How critical is the Issue to be fixed for the currently imminent release?
- Relevance: What does it fix/introduce? e.g. - issues marked as kind/cleanup are usually less important.
- Time Estimation: Is the PR expected to be ready for merging soon? Is there any time left?
- CI Stability: How big is the change? Could it cause instability to CI? If so, it either needs to be closely tracked /or/ moved.
- Consensus 
- Critical Thinking

As stated on a previoous section, decisions and actions should be made either by the Release Lead or SIG Leads - Bug Triage's role is mainly to keep track, ping people and report the overall status to the Release Lead.

If you see an issue or PR that is not making progress, hasn't got an update for a while and there is no anecdotal knowledge that someone is working on it, you should comment and ask about the status. If there is no response for quite some time, it's very likely that it will be marked for the subsequent release. The task of filtering becomes more frequent as time progresses.

This section is also described in [the release document](https://github.com/kubernetes/community/blob/master/contributors/devel/release.md#removal-of-items-from-the-milestone) from the contributor's perspective.

### Priority label definitions

You can [refer to this guide](https://github.com/kubernetes/community/blob/master/contributors/guide/issue-triage.md#define-priority).


### Sample Searches
* Open v1.14 Issues
   * `is:open is:issue milestone:v1.14 -label:"kind/feature" -label:"kind/failing-test"` [milestone open issues, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.14+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
   * `is:open is:issue milestone:v1.14` [milestone open issues, no exclusions](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.14)
* Open v1.14 PRs
   * `is:open is:pr milestone:v1.14 -label:"kind/feature" -label:"kind/failing-test"` [milestone open PRs, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.14+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:pr milestone:v1.14"` [milestone open PRs, no exclusions](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.14)


### Reports

At this point, release meetings occur ~3 times per week and a report is expected in each of them.

You should soon start maintaining an overall list of items/areas/issues which seem to be delaying, at risk of not making it in time, or in need of attention by the Release Lead or other roles, and present it in the meetings.

The Release Lead will include a template for this information in the Monday/Wednesday/Friday release team meeting notes.

Code Freeze hasn't really started yet at this point, and it depends on the overall status and volume of open issues/PRs on how many to report. It's good to have some numbers of total issues/PRs available to see general trends over time, like increased or lowered volumes.

### Issue Categorization

Issues can be categorized with the following 'status codes', Green/Yellow/Red.

* green: issues/PRs where the resolution is known and will be resolved soon
* yellow: issues/PRs which are in progress but are not as easy and need to be watched
* red: issues/PRs that are heavily release-impacting, and/or with a likelihood of not making it in time.

In each meeting, it is good to give an overall status of Bug Triage: Green, Yellow or Red, generally based on the amount of issues from each category. Examples are:

- status can be Red if there are multiple release-impacting issues that are in danger of not being fixed in the release.
- status can be Yellow if there are multiple issues open but they are being worked on, which is the usual state of the world.
- status can be Green if there are no Red issues and workpaces seem normal.

It is useful to keep Red issues on a separate section and report them during the meetings.


## Code Freeze

Once Code Freeze kicks in, only PRs with the label `priority/critical-urgent` && targeting the upcoming release (/milestone v1.xx) are able to get merged.

This is enforced via test-infra automation, as a means of "new release coming in a few weeks - we're only merging critical PRs in".

As explained in sections [Code Freeze Preparation](#code-freeze-preparation) and [Filtering](#filtering), it becomes incrementally more difficult to merge new stuff as time progresses, and this should be incrementally enforced. As such, in the days around the start of Code Freeze, owners of issues and PRs not marked as critical-urgent should be poked again, reminding them that Code Freeze starts/started at DD/MM, which means any issues not marked `priority/critical-urgent` _might_ be moved to the subsequent release. 

The criteria for moving issues are described in [Filtering](#filtering).

For issues/PRs that look tricky, you can always consolidate with the Release Lead and SIG/PR owners to reach a decision.

Any new enhancements that aren't making rapid progress need to either jump to the next release, or reduce their scope.
You may need to send daily reminders/queries about stuck PRs.

New test failures will also show up during Code Freeze and you need to make sure that these are labeled properly, get attention of the CI Signal lead, and get attention from the appropriate SIGs.


### Sample Searches

* Open v1.14 Issues
  * `is:open is:issue milestone:v1.14 -label:"kind/feature" -label:"kind/failing-test"` [milestone open issues, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.14+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:issue milestone:v1.14` [milestone open issues, no exclusions](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+milestone%3Av1.14+)
  * `is:open is:issue created:>2018-06-14` [open issues, no exclusions, created since you last looked](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen++created%3A%3E2018-06-14)
  * `is:open is:issue modified:>2018-06-14` [open issues, no exclusions, modified since you last looked](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen++modified%3A%3E2018-06-14)
* Open v1.14 PRs
  * `is:open is:pr milestone:v1.14 -label:"kind/feature" -label:"kind/failing-test"` [milestone open PRs, excluding kind/feature and kind/failing-test](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.14+-label%3A%22kind%2Ffeature%22+-label%3A%22kind%2Ffailing-test%22+)
  * `is:open is:pr milestone:v1.14"` [milestone open PRs, no exclusions](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+milestone%3Av1.14+)
  * `is:open is:pr created:>2018-06-14` [open PRs, no exclusions, created since you last looked](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen++created%3A%3E2018-06-14)
  * `is:open is:pr modified:>2018-06-14` [open PRs, no exclusions, modified since you last looked](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Aopen++modified%3A%3E2018-06-14)
* Reports against the beta(s):
  * `is:issue "1.14.0-beta"' [issues mentioning beta version](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=%221.14.0-beta%22)
  * `is:pr "1.14.0-beta"' [PRs mentioning beta version](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=%221.14.0-beta%22)

### Reports

A few days after Code Freeze kicks in, daily 'burndown' meetings start, which means that either you or a shadow has to give updates every day. See [Issue Categorization](#issue-categorization).

There will also be several enhancements which will have requested exceptions from the normal release timeline/requirements.  You'll want to track the exceptions specifically and report on them.  It is useful to be tracking in a spreadsheet the open issues/PRs which have caught your attention, because GitHub queries are only point in time.  It's easy for an issue you want to follow to stop showing up in a query and thus fall off your radar if you're only going by the queries.

## Code Thaw

Starting a few working days before the first Release Candidate, Code Freeze labeling restrictions are lifted.  At this point, you need to make sure that three things happen:

1. major breakage bugs get fixed immediately
2. any pending PRs get approved and merged
3. *anything else gets kicked out of the release*

During this period, it's reasonable to expect issue owners and SIG leads to get back to you within hours (check their time zones, though). In cases where SIG Leads are unavailable, you may need to appeal to Kubernetes project leaders to deal with stuck PRs.

Another part of staying on top of code churn, regression, and risk is monitoring commits to master and the release branch especially in the final days of the release, as shown below in Sample Searches for this phase.  On occasion things will merge that are unexpected by the release team.  This possibility needs monitored and when it happens the commits need triaged for destabilizing risk and proper exception justification, tests, docs, etc.

### Sample Searches

Most important query at this point is a plain `milestone:v1.xx`, which includes all remaining issues/PRs. Ideally, the queue should be empty.

Additionally for tracking recent changes to master and the release branch,
eg:
* [master branch commits](https://github.com/kubernetes/kubernetes/commits/master/)
* [release-1.14 branch commits](https://github.com/kubernetes/kubernetes/commits/release-1.14)

### Reports

Same as Code Freeze.

During this short period it may also be necessary to check in on and report out status changes on the weekend. This should be an exception versus the norm because all the prior months' work by the release team and community has led to well managed and understood risks, but surprises do happen.
