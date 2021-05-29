# CI Signal Lead Playbook
## Content

- [Overview of CI Signal responsibilities](#overview-of-ci-signal-responsibilities)
- [Requirements](#requirements)
  - [Additional Requirements for Shadows](#additional-requirements-for-shadows)
  - [Additional Requirements for Leads](#additional-requirements-for-shadows)
- [Overview of tasks across release timeline](#overview-of-tasks-across-release-timeline)
  - [Onboarding](#onboarding)
  - [Pre Enhancement Freeze](#pre-enhancement-freeze)
  - [Enhancement Freeze to Burndown](#enhancement-freeze-to-burndown)
  - [Burndown to Code Freeze](#burndown-to-code-freeze)
  - [During Code Freeze](#during-code-freeze)
  - [Exit Code Freeze](#exit-code-freeze)
  - [Release Cutting - Go or No-Go](#release-cutting---go-or-no-go)
- [Blocking vs. Informing Dashboards](#blocking-vs-informing-dashboards)
- [Opening Issues](#opening-issues)
  - [Decision Tree](#decision-tree)
  - [Closing Issues](#closing-issues)
- [Detect flakiness on presubmit jobs](#detect-flakiness-on-presubmit-jobs)
- [Special high risk test categories to monitor](#special-high-risk-test-categories-to-monitor)
  - [Scalability tests](#scalability-tests)
- [Working with SIGs outside sig-release](#working-with-sigs-outside-sig-release)
  - [SIG-scalability report](#sig-scalability-report)
- [Tips and Tricks of the game](#tips-and-tricks-of-the-game)
  - [A Tour of CI on the Kubernetes Project](#a-tour-of-ci-on-the-kubernetes-project)
  - [Checking test dashboards](#checking-test-dashboards)
  - [Priority Labels](#priority-labels)
  - [Milestones](#milestones)
  - [Monitoring Commits for test failure triangulation](#monitoring-commits-for-test-failure-triangulation)
- [Reporting Status](#reporting-status)

## Overview of CI Signal responsibilities

CI Signal lead assumes the responsibility of the quality gate for the release. This person is responsible for:
- Continuously monitoring various e2e tests in sig-release dashboards ([master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking), [master-informing](https://k8s-testgrid.appspot.com/sig-release-master-informing), `release-x.y-blocking/informing` (x.y being the current release)) throughout the release cycle
- Hunting flakes on presubmits that could potentially block the Kubernetes master branch ([presubmits-kubernetes-blocking](https://testgrid.k8s.io/presubmits-kubernetes-blocking))
- Monitoring all the jobs in [sig-release-releng-blocking](https://testgrid.k8s.io/sig-release-releng-blocking) and [sig-release-releng-informing](https://testgrid.k8s.io/sig-release-releng-informing) dashboards.
- Providing early and ongoing signals on release and test health to both Release team and various SIGs
- Ensuring that all release blocking tests provide a clear Go/No-Go signal for the release
- Flagging regressions as close to source as possible i.e., as soon as the offending code was merged
- Filing issues proactively for test failures and flakes, triaging issues to appropriate SIG/owner, following up on status and verifying fixes on newer test runs
  - See also: [Working with SIGs outside sig-release](#working-with-sigs-outside-sig-release)
- Studying patterns/history of test health from previous releases and working closely with SIGs and test owners to
  - Understand and fix the test for the current release
  - Understand if the test needs to be release blocking
  - Work with SIG-Testing on any possible test infra improvement to help improve test pass rate
- Making recommendations to SIG-Release for promoting and demoting release blocking and merge blocking tests as per the [Blocking Jobs Criteria](/release-blocking-jobs.md)

The core responsibility of the CI Signal lead is to foster a culture of continuous test integration, fail-fast and fix-fast mindset and strive for continuously passing tests that provide true positive signal to the release team. To ensure that releases go out on-time with high quality it is absolutely critical to maintain a sustained focus on test health through the entire release cycle, as opposed to accepting destabilizing test failures during active enhancement development followed by a long test stabilization phase.

### Explicit detail is important:

- If you're looking for answer that's not in this document, please file an issue so we can keep the document current.
- Generally CI Signal lead errs on the side of filing an issue for each test failure or flake before following up with SIGs/owners. This way we don't _lose track of an issue_
- If a dashboard isn't listed here, or a test isn't on one of the listed dashboards, **_CI Signal lead is not looking at it_**

## Requirements

**Before continuing on to the CI Signal specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Time Requirements

CI Signal is one of the more time-intensive roles on the release team, and as such is not recommended for candidates who do not have employer support for their work on the Release Team.  General time requirements for Leads and Shadows are:

- 1/2 hour to 2 hours a day, every workday, checking failing tests and following up on failing test and flake issues.
- Availability to attend the majority of Release Team (weekly) and Burndown meetings (daily during Code Freeze), subject to time zone appropriateness.
- Ability to follow-up on test fixes during Code Freeze at arbitrary times to ensure rapid turnaround.
- The time commitment becomes greater through the release cycle, peaking during Code Freeze.  In the last week of Code Freeze, Shadows should expect to spend at least 10 hours and leads at least 20 hours.

### Additional Requirements for Shadows

The following requirements are all things that Leads should already have, and Shadows should acquire, with coaching, within the first weeks of the release cycle:

- Have signed the contributor CLA for Kubernetes.
- Become a Kubernetes org member.  In many cases, this will be done with the sponsorship of the CI Signal Lead or Release Lead in the first week of the cycle.
  - The process to become one of these is in [our community membership ladder](https://github.com/kubernetes/community/blob/master/community-membership.md#requirements-for-outside-collaborators)
- General familiarity with our [test boards](https://testgrid.k8s.io/) and examining test results from automated tests.
- Willingness and ability to follow-up with contributors about test failures, on Slack, email, Discuss, and SIG meetings, as appropriate.
- Ability to file well-crafted Kubernetes issues, including labelling.
- General knowledge of our SIG system and SIGs' areas of responsibility.

Additionally, the following qualifications make a candidate more suitable for the CI Signal team, but are not requirements:

- Prior involvement with SIG Testing and the Test Infrastructure team.
- Experience with automated testing, CI/CD, quality engineering, and/or quality assurance.

### Additional Requirements for Leads

In addition to the above requirements for Shadows, most of which become prerequisites, CI Signal Leads must:

- Have the ability to add a milestone to issues, so must be a member of the [milestone maintainers](https://github.com/orgs/kubernetes/teams/milestone-maintainers)
- Have a working knowledge of our various test infrastructure tools, such as Testgrid, Triage, Spyglass, gubernator, Prow, and Tide.
- Signal lead needs to understand what tests matter and generally how our testing infra is wired together.
  - He/she can ask previous CI Signal leads for advice
  - He/she can ask SIG-Testing for guidance

## Overview of tasks across release timeline

For any release, its schedule and activities/deliverable for each week will be published in the release directory, e.g: [1.16 schedule](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.16#timeline). This section talks about specific CI Signal lead deliverable for each milestone in the release cycle.

### Onboarding
Right after the CI signal release team is formed, CI signal lead is responsible for following onboarding actions:
- adding write access to all new shadows for the [CI signal board](https://github.com/orgs/kubernetes/projects/11)
- updating the [CI signal github team](https://github.com/kubernetes/org/blob/master/config/kubernetes/sig-release/teams.yaml)
- adding the lead and (more experienced) shadows as milestone maintainers in the [teams.yaml](https://github.com/kubernetes/org/blob/master/config/kubernetes/sig-release/teams.yaml)
- organizing an onboarding meeting with shadows to walk through this handbook and useful tools like TestGrid, Spyglass, and Triage

### Pre Enhancement Freeze

Here are some good early deliverables from the CI Signal lead between start of the release to enhancement freeze.
- Start maintain the [CI signal project board](https://github.com/orgs/kubernetes/projects/11) and keep it up-to-date with issues tracking any test failure/flake
- Assign the new milestone labels to the open issues from previous release, assign a member of the CI signal team, and have that member follow up on the issue with owners
- Monitor [master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking) and [master-informing](https://testgrid.k8s.io/sig-release-master-informing) dashboards **twice a week** and ensure all failures and flakes are tracked via open issues. See [Opening Issues](#opening-issues) for how to write an effective issue.
- Build and maintain a document of area experts / owners across SIGs for future needs e.g.: Scalability experts, upgrade test experts etc

#### **_Best Practice:_**
The SLA and involvement of signal lead at this stage might vary from release to release (and the CI Signal lead). However in an effort to establish an early baseline of the test health the signal lead can take an initial stab at the tests runs at the start of the release, open issues, gather and report on the current status. Post that, it might suffice to check on the tests **twice a week** due to high code churn and expected test instability.

### Enhancement Freeze to Burndown

Day to day tasks remain pretty much the same as before, with the following slight changes
- Monitor [master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking) dashboard **daily**
- Monitor [master-informing](https://k8s-testgrid.appspot.com/sig-release-master-informing) **every other day**
- Starting now, curate a **weekly CI Signal report** escalating current test failures and flakes and send to kubernetes-dev@googlegroups.com community. [See below](#reporting-status) for more details on the report format and contents

Increased attention on maintaining signal early in the release cycle goes a long way in reducing the risk of late-found issues destabilizing the release during code freeze.

### Burndown to Code Freeze

This is when things really begin to ramp up in the release cycle with active bug triaging and followup on possible release blocking issues to assess release health. Day to day tasks of CI Signal lead include
- Auditing test status of master-blocking, master-informing, release-x.y-blocking and release-x.y-informing dashboards on **daily basis**
- Keeping issues' status up-to-date on GitHub
- Working closely with SIGs, test owners, bug triage lead and Release team in triaging, punting and closing issues
- Updating issue tracker frequently so anyone on the release team can get to speed and help followup on open issues
- Continuing to send [weekly CI signal report](#reporting-status)

### During Code Freeze

- Continue best practices from Burndown stage. Monitor master-blocking, master-informing, release-x.y-blocking, and release-x.y-informing dashboards on **daily basis**
- Quickly escalate any new failures to release team and SIGs
- Continuing to send [weekly CI signal report](#reporting-status)

### Exit Code Freeze

- Once 1.x.0-rc.1 release branch is cut and master re-opens for next release PRs
  - continue **release-x.y-blocking, and release-x.y-informing dashboards on daily basis**
  - check the **scalability jobs on master-informing** as often as they run.
  - you need not monitor master-blocking on a daily basis. It is, however, worth keeping an eye on master-blocking especially before risky cherry-picks make their way into the release branch
- If tests have stabilized (they should have by now), you may stop sending the weekly CI report

### Release Cutting - Go or No-Go

Over the release cycle, the release engineering team will cut several releases (alpha, beta, rc), before it ends with a new major Kubernetes release. During the release cycle, tests fail and potentially prevent the cut of a new version. 

Therefore, the key objective is to create a picture if the release branch manager can starting the release process or if there is a major failure that needs to be solved first. To avoid a last-minute No-Go, the assigned CI Signal member aligns at least 2-3 days before the day of the release cut with the [corresponding release branch manager]([https://github.com/kubernetes/sig-release/tree/master/releases](https://github.com/kubernetes/sig-release/tree/master/releases)). Potentially blocking tests have to be followed up with high priority and being driven to be solved until release day. Having a short daily alignment telling the Go/No-Go indication should give an idea if this is going in the right direction. If the CI Signal member decides on a No-Go, the issues have to be addressed. A short heads up about what is blocking, what are the current actions to resolve this and, if possible, an estimation of how long it will take to be solved should be given to the release lead, branch manager and to the test corresponding SIG leads.

On the release day, indicate to the branch manager your availability and the current Go/No-Go status. Monitor the jobs and tests closely until the branch manager starts the release cut. In case that a test fails very close to the beginning of the release cut and the reason seems to be severe, align with the branch manager to postpone the cut until the next test runs or if you are familiar with how to test Kubernetes, if the failed test was just a flake.

## Blocking vs. Informing Dashboards

Summary: failing Blocking jobs always block release.  Failing Informing jobs sometimes block release.

Jobs on the master-blocking and release-x.y-blocking dashboards are expected to be green *all the time*.  As such, you should take immediate action when one of them turns red, and may recommend postponing the release if any one of these jobs is not passing.

Jobs on the master-informing and release-x.y-informing dashboards require more interpretation.  Some run infrequently or for a long time, and can take days to show effects from merged changes.  Others are inconsistent and require you to wait for several failed runs to file an issue and consult the owning SIG.  As a result, these tests block release either when they have unexplained failures, or failures that have been investigated and relate to blocking issues.  If they're just flaking, or failing for explained and tolerated reasons, they do not block.
<!-- TODO: document procedure/criteria for tolerated failures in Informing -->

For more detailed information about what's on these dashboards, see [Release Blocking Jobs](/release-blocking-jobs.md) documentation.

## Opening Issues

The appropriate response to a failing or flaking job on either a blocking or informing dashboard is to open an issue. The primary goal of opening an issue is to track the work that needs to be done to bring the job back to a healthy status while providing accurate signal. The format for a helpful and informative issue may vary depending on the type of job, the test(s) that are failing for the job, and the responsible parties for the job.

### Decision Tree

The decision tree below can be followed to make sure that you are opening an issue that is most effective for triaging, tracking, and resolving a failing or flaking job.

_All instances of "failing" below can be replaced with "flaking" when appropriate._

1. If a single test is failing across multiple jobs, open a test-level issue with title `[Failing Test] [responsible-SIG] failing-test-name`.
    - If you are unsure of the responsible SIG, you may omit `[responsible-SIG]`.
    - If a short regex can be used to describe the jobs that are failing (example: `kind-*-parallel`), you may add it to the end of the title in parentheses.
2. If one or more tests are failing for a single job that is owned by a single SIG (example: sig-node owns all tests in [node-kubelet-master](https://testgrid.k8s.io/sig-release-master-blocking#node-kubelet-master)), open a job-level issue with title: `[Failing Test] [responsible-SIG] failing-test-name (failing job name)`.
    - If multiple tests are failing, you can pick one for the title if it reflects the root cause, or you can write a very succinct description in place of `failing-test-name`.
3. If a job is failing for a reason that is unrelated to the test behavior or the functionality being tested, such as a failure to schedule the Pod or a timeout due to resource contention, open a job-level issue with title: `[Failing Test] failing-test-name (failing-job-name)`.
    - If the failure is clearly related to a testing infrastructure issue, it may be appropriate to open the issue in [k/test-infra](https://github.com/kubernetes/test-infra) or [k/k8s.io](https://github.com/kubernetes/k8s.io).
4. If one or more tests are failing for a single job that is not owned by a single SIG, open a separate issue for each failing test with title: `[Failing Test] [responsible-SIG] failing-test-name (failing-job-name)`.

An issue should remain open until the appropriate fix has been made and the affected tests have returned to a healthy status. If an issue is closed prematurely, or the same test starts failing or flaking again, a new issue should be opened. Do not reopen closed issues.

Once you have decided the number of issues to open an how to name them, it is important to provide appropriate information in the content of the issue such that the relevant parties are notified and have enough information to take action. For all opened issues:

- Make sure all open issues have a `priority/` label (see: [Priority Labels](#priority-labels)) and one of either the `kind/flake` or `kind/failing-test` label.
- Make sure the issue is assigned against the current milestone 1.x, using `/milestone`.
- Assign the issue to appropriate SIG using `/sig` label.
- If you are aware of the individual associated with the enhancement area or issue, @mention of individual(s) and SIG leads tends to result in faster turn around.
- Add `@kubernetes/sig-foo-test-failures` to draw SIG-foo’s attention to the issue.
- `/cc @ci-signal` github team on the issue to let rest of the team know about it, you might also `/cc` the release lead and bug triage lead if the issue needs extra attention immediately.
- Assign the issue to yourself or recruit another member of the CI signal team to own the issue. The CI signal team member assigned to an issue is responsible for driving it to resolution alongside the assignee from the appropriate SIG.
- Post the test failure in SIG’s Slack channel to get help in routing the issue to the rightful owner(s).
- Add the issue to [CI signal board](https://github.com/orgs/kubernetes/projects/11) under "New". The CI signal team lead is responsible for making sure every issue on the CI signal board is assigned to a member of the CI signal team and is being actively driven to resolution.

In addition to the steps above, make sure to fill in any additional information that is part of the [Failing Test](https://github.com/kubernetes/kubernetes/issues/new?labels=kind%2Ffailing-test&template=failing-test.md) or [Flaking Test](https://github.com/kubernetes/kubernetes/issues/new?labels=kind%2Fflake&template=flaking-test.md) issue template.

### Closing Issues

After a fix is applied to an issue, it often gets fast closed. Be aware that the issue's status (open/closed) is not the same as it is on the CI Signal board (New/under investigation/observing/resolved). For the same reasons, as explained earlier, we have to see if a flaky test got stable. When a fix is applied and it is expected, that this should solve the problem, the issue gets moved to Observing. After an appropriate amount of time, a big thumb rule would be two weeks, the issue can be moved to resolved. An issue should remain open until the appropriate fix has been made and the affected tests have returned to a healthy status. If an issue is closed prematurely, or the same test starts failing or flaking again, a new issue should be opened. Do not reopen closed issues.

## Detect flakiness on presubmit jobs

Jobs that are running on each commit (presubmits) can fail because of a bad code in which this is normal. Therefore, there is no a good way to know if the job is flaky or not by looking at the job's history in testgrid ([presubmits-kubernetes-blocking](https://testgrid.k8s.io/presubmits-kubernetes-blocking)). For that reason, the best practice is to monitor the behavior of the job via different tools.
- With [triage](https://storage.googleapis.com/k8s-gubernator/triage/index.html?ci=0&pr=1&job=pull-kubernetes-e2e-gce) you will be able to detect job failures searching by the error message and get a summary of the error frequency.
- K8s monitoring [tide-dashboard](https://monitoring.prow.k8s.io/d/d69a91f76d8110d3e72885ee5ce8038e/tide-dashboard?orgId=1) to determine merge rate and make sure that the pool is not blocked.

## Special high risk test categories to monitor

Historically there are a couple of families of test that are hard to stabilize, regression prone and pose a high risk of delaying and/or derailing a release. As CI Signal lead it is highly recommended to pay close attention and extra caution when dealing with test failures in the following areas.

### Scalability tests
Scalability testing is inherently challenging and regressions in this area are potentially a huge project risk
- Requires lots and lots of servers running tests, and hence expensive
- Tests are long running, so especially hard/expensive/slow to resolve issues via Git bisection
- Examination of results is actually the bigger more expensive part of the situation

The following scalability jobs/tests could regress quite easily (due to seemingly unrelated PRs anywhere in k8s codebase), require constant manual monitoring/triaging and domain expertise to investigate and resolve.
- [master-blocking gce-cos-master-scalability-100](https://testgrid.k8s.io/sig-release-master-blocking#gce-cos-master-scalability-100)
- [master-informing gce-scale-correctness](https://testgrid.k8s.io/sig-release-master-informing#gce-master-scale-correctness)
- [master-informing gce-scale-performance](https://testgrid.k8s.io/sig-release-master-informing#gce-master-scale-performance)
- `release-x.y-blocking gce-cos-x.y-scalability-100`

Importantly, the expensive scalability jobs that run on master-informing do not run or appear on release-x.y-informing because we don't currently run them against the release branch as well as master.  This means that during Code Freeze, when you would normally ignore master-informing, you still need to keep track of gce-scale-performance and gce-scale-correctness there, since they don't run in the current release branch.  In the event of a problem with these jobs, you then will have to figure out whether the problem is related to code that's in the release branch, as opposed to code that exists only in master.

The CI Signal team should
- Continuously monitor these tests early in the release cycle, ensure issues are filed and escalated to the Release team and right owners in [SIG-Scalability](https://github.com/kubernetes/community/tree/master/sig-scalability#chairs)
- Work with SIG-Scalability to understand if the failure is a product regression versus a test issue (flake) and in either case followup closely on a fix
- Additionally, it might help to monitor SIG-Scalability’s performance dashboard to flag if and when there is considerable performance degradation

Starting in 1.11, scalability tests are now blocking OSS presubmits. Specifically we are running performance tests on gce-100 and kubemark-500 setups. This is a step towards catching regressions sooner and stabilizing the release faster.

## Working with SIGs outside sig-release
2 scenarios that you will be involved in:

1. Identifying tests from sig-<name> that should be/are part of sig-release's blocking and informing dashboards. Those tests could be submitted as part of a new enhancement that sig-<name> is developing, or could be existing tests in blocking/informing dashboards.
Questions to ask sig-<name>:
  - Which e2e test jobs are release blocking for your SIG?
  - What is the process for making sure the SIG's test grid remains healthy and resolving test failures?
  - Would moving the e2e tests for the SIG into their own test jobs make maintaining those tests easier? If yes, consider placing them in a dashboard owned by sig-<name>.
  - Is there a playbook for how to resolve test failures and how to identify whether or not another SIG owns the resolution of the issue? If not, could you (sig-<name>) develop one?
  - What is the escalation point (email + slack) that will be responsible for keeping this test healthy?

2. Escalating test failures/flakes to sig-<name>. Expectations:
  - Each test must have an escalation point (email + slack).  The escalation point is responsible for keeping the test healthy.
  - Fixes for test failures caused by areas of ownership outside the responsibility of the escalation point should be coordinated with other teams by the test escalation point.
  - Escalation points are expected to be responsive within 24 hours, and to prioritize test failure issues over other issues.
    - If you don't see this happening, get in touch with them on slack or other means to ask for their support.

### SIG-scalability report
We've had to delay releases due to failing scalability tests in the past, as these can take multiple days to run. It is therefore important to check in with SIG-scalability on the status of their tests weekly. Ask that a member of SIG-scalability should fill the "Weekly Scalability Report" section in the release team meeting notes with an update, once a week. Additionally, a representative of the Release Team (either a CI Signal team member or a Lead team member) should attend the SIG meeting once a month (beginning of the release, code freeze, and near end of release) and check in on the following things:
  - Clearly communicate deadlines (code freeze, planned release date)
  - Check in on outstanding issues:
    - anything that may hold a release 
    - anything that could prevent the upgrade of another dependency (for example a change to the golang major/minor version)
    - whether there are any other tests they are running - they occasionally run scalability jobs on certain PRs, or on certain special configurations (run job with pinned Golang version, alpha feature turned on, etc)

## Tips and Tricks of the game

### A Tour of CI on the Kubernetes Project

[A guide to CI on Kubernetes with Rob Kielty (1.20 CI Signal lead) and Dan Magnum (1.19 CI Signal lead)](https://www.youtube.com/watch?v=bttEcArAjUw):
Introduces the role of CI Signal members and walks through the tools and processes used for logging flaky/failing tests (as explained below).

Notes to follow along: http://bit.ly/k8s-ci-signal

### Checking test dashboards

- Quirk: if a job is listed as FAILING but doesn't have "Overall" as one of its ongoing failures, it's not actually failing. It might be "red" from some previous test runs failures and will clear up after a few "green" runs
- if a job is failing in one of the meta-stages (Up, Down, DumpClusterLogs, etc), find the owning SIG since it is a infra failure
- if a job is failing because a specific test case is failing, and that test case has a [sig-foo] in its name, tag SIG-foo in the issue and find appropriate owner within the SIG
- with unit test case failures, try to infer the SIG from the path or OWNERS files in it. Otherwise find the owning SIG to help
- with verify failures, try to infer the failure from the log. Otherwise find the owning SIG to help
- if a test case is failing in one job consistently, but not others, both the job owner and test case owner are responsible for identifying why this combination is different
- You can look at past history of the job/test (even as far back as multiple releases) by querying the [triage dashboard for specific job and/or test name](https://storage.googleapis.com/k8s-gubernator/triage/index.html)

### Priority Labels
Issues you create for test failures and flakes must be assigned a `priority` label, that is compatible with the priorities described in the [Issue Triage contributor guide](https://github.com/kubernetes/community/blob/master/contributors/guide/issue-triage.md#define-priority).

In the CI signal context, we're using priority labels to mean:

| priority | Description | Expectation |
| -- | -- | -- |
| `priority/critical-urgent` | Actively impacting release-blocking signal. Includes: consistently failing tests,  frequently (more than 20% of the time) flaking tests  in release-blocking dashboards. | Work with sigs for these to be worked on as soon as possible, prioritized over other work. |
| `priority/important-soon` | Negatively impacting release-blocking signal. Includes: Flakes (especially occurring >2% of the time) in release-blocking jobs, failures and flakes in release-informing jobs. | Work with sigs to resolve them soon, ideally before the end of this release cycle. |
| `priority/important-longterm` | Painful, results in manual workarounds/toil, limits developer productivity, but is of lower urgency and importance than issues in `priority/critical-urgent` or `priority/important-soon`. | In reality, there's a high chance these won't be finished, or even started within the current release. Work with sigs to ensure they are on their radar, and help find ways they can be broken down into smaller chunks. |

CI signal is not currently using `priority/backlog` or `priority/awaiting-more-evidence`.
If ever in doubt, label as `critical-urgent` to make sure you get eyes on the
issue.

### Milestones

All issues the CI signal team creates must be part of the current milestone.
In order to apply a milestone, you'll need to be part of the GitHub team
[milestone-maintainers](https://github.com/orgs/kubernetes/teams/milestone-maintainers).

To add an issue or PR to a milestone use the following Prow command:
```
/milestone v1.x
```

Near the end of the release cycle, if you still have open issues that are not
release blocking, then feel free to move these to the next milestone.

### Monitoring Commits for test failure triangulation
Yet another effective way for the signal team to stay on top of code churn and regression is by monitoring commits to master and specific branch periodically.
- Once a day look at https://github.com/kubernetes/kubernetes/commits/master/ for master or a specific branch
- Look for any new end-to-end tests added by a PR

This helps us
- Stay aware of tests’ history and identify ownership when they start failing
- Identify possible culprit PRs incase of a regression
- Usually if the volume of things merged is very low, then that’s a signal that something is terribly broken as well

## Reporting Status
Since 1.11 we started curating and broadcasting a weekly CI Signal report to the entire kubernetes developer community highlighting
  - Top failing and flaky jobs and tests
  - New failing and flaky jobs and tests in the past week
  - Call out SIGs actively fixing and ignoring issues
  - Call out potential release blocking issues
  - Call out upcoming key dates e.g., Code freeze, thaw etc
  - [Link to the previous reports](https://docs.google.com/document/d/1Xesru5QkBxxl8WOirNcWI4ho3exqfQBGz6mYJeXOi3U/edit#heading=h.qs3772g2kexl)
  - CCing individual SIGs (kubernetes-sig-foo@googlegroups.com) that own failing tests help in getting their attention

[Sample Weekly CI Signal Report](https://groups.google.com/d/msg/kubernetes-dev/nO8aKz3tavE/-aBpStu4CQAJ)

You can use [this tool](https://github.com/alenkacz/ci-signal-report) to help you scaffold the report.

Early and continuous reporting of test health proved greatly effective in rallying SIG attention to test failures and stabilizing the release much early in the release cycle.
