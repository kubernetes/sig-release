# Release Blocking Jobs and Criteria

* [SIG-Release-Master-Blocking](https://testgrid.k8s.io/sig-release-master-blocking)
* [SIG-Release-Master-Informing](https://testgrid.k8s.io/sig-release-master-informing)

SIG-release maintains two sets of jobs that decide whether the release is
healthy: Blocking and Informing.  Each of these sets is instantiated for each
active release (beta or later), plus Master, so at any given time there will
be 8-10 dashboards in pairs.

Below, the set of "sig-release-master-blocking" and "sig-release-X.Y-blocking"
dashboards will be referred to collectively as "Blocking", and the set of all
"-informing" dashboards as Informing.  Where only specific dashboards are
required, they will be referred to by name or pattern.

There are also some other release dashboards, such as sig-release-misc,
sig-release-orphaned, and sig-release-x.y-all, none of which are used to
determine readiness to release.  They are there either to support other
teams (such as the Release Engineering) or as "parking" for jobs that need to
be fixed.

If you want to add a Blocking job, please ask to add them to the appropriate
Informing dashboard first. The release team can later decide if the test should
be moved to the Blocking dashboard.

Additional documentation may be found in the [CI Signal Role Handbook](./release-team/role-handbooks/ci-signal/README.md).

## Release-Blocking Criteria and Dashboard

Jobs on the Blocking dashboard for a particular release should block that
release if they do not have at least three successive "green" runs at go/nogo
decision time.  In some cases, the CI Signal team may authorize release with a
job still failing for thoroughly investigated reasons, but the general
expectation is "jobs red, do not release."

As such, criteria for what jobs are on Blocking are rather stringent, in order
to prevent aborting a release unnecessarily.  Note that not all current jobs
meet the below criteria completely due to technical debt.  Blocking jobs must:

- Have a documented reason for its inclusion in the Blocking suite
<!-- TODO(spiffxp, jberkus):
  - need to determine by policy where such documentation would exist
  - this will probably be tied to the process of adding new jobs
-->
- Provision clusters via open-source software instead of a hosted service
- Have the average of 75% percentile duration of all runs for a week finishing in 120 minutes or less
- Run at least every 3 hours
- Be able to pass 3 times in a row against the same commit
- Be Owned by a SIG, or other team, that is responsive to addressing failures, and whose alert email is configured in the job.
- Depend on accounts and resources owned by The Kubernetes Project through SIG K8s Infra, so the project has visibility into funding and management of resources
- Have passed 75% of all of its runs in a week, and have failed for no more than 10 runs in a row

*In the case of failures, there must be an issue in kubernetes/kubernetes
detailing that there is at least one person from the owning SIG working to
resolve the issue. Said issue must be acknowledged within a short period
(i.e., a week) and resolved within a short period being acknowledged by the
owning SIG (i.e., a week as well).*

The reasoning for the above time limits is that as we get to the end of a release cycle,
we are usually waiting on a handful of bug fixes and want to be certain that
the underlying bug is truly fixed. This means we prefer to see multiple test
results for the same commit. If we wait for three successful runs that are
scheduled every three hours, we wait for nine hours.  This effectively gives
us the chance to make two changes/decisions in a 24 hour period.

The thresholds given have some flexibility. We recognize that not every job may be
able to strictly adhere to all of these criteria all of the time.  We also
recognize that metrics can be gamed. Thus we consider human review to be the
ultimate authority in the process to promote a demote a job as
Blocking, and metrics to be the triggering criteria for such review.
There is no shame in being demoted, and once the problems have been fixed, a
job can be promoted back.

## Release-Informing Dashboard



Jobs that are considered useful or necessary to inform whether a commit on
master is ready for release, but that clearly do not meet Blocking
criteria, may be placed on the Informing dashboard. These
are often jobs that are some combination of slow, flaky, infrequent, or
difficult to maintain.  There are often good reasons for these jobs to not meet
Blocking criteria, such as requiring 12 hours for each run, or having
intrinsic race conditions.

These jobs may still block the release, but because they require a lot of
manual, human interpretation, we choose to move them to a separate dashboard.

CI Signal Team members will regularly check the Informing Dashboard for new
failures.  Unexplained failures that are not flakes should be considered reason
to block the release until the failures are investigated and evaluated.
Unlike Blocking, however, jobs in Informing do not need to be green before
authorizing a release, they can be failing for known and "acceptable" reasons.
Such failures are "tolerated", meaning that they are not release-blocking, although
they need to be corrected after the release as time allows.

The criteria for deciding whether a failure in informing is not release-blocking is
based on the following considerations:

* Failure is due to a malfunction of the components that run a job and said
  components are not part of Kubernetes
  * For example, if a job is marked as failing because a test cluster could not be setup
    but there are similar jobs that run the same tests, then the failing job
    is tolerated.
  * If a job fails at a stage that is not related to any Kubernetes e2e test,
    (e.g., couldn't upload some logs to a remote source) then the job failure can be
    tolerated given that the stage doesn't disrupt any e2e tests.
  * If a test-infra-related component fails and there are no other factors
    that could be responsible for the failure then the failure can be tolerated.
* Failure is well understood and is caused by the configuration of a test and said
  configuration is not related to an official SLO
  * For example, if a test polls for metrics more frequently than these are
    updated and fails because of it, then the failure may be tolerated.
* Job is flaking too frequently and is marked as failing
  * This should only be done when different tests are flaking. If the same set
    of tests are flaking then we should fix them.
* A test failed and was subsequently removed, thus marking the job as failed.

## Promoting or Demoting Jobs

As described above, the thresholds and criteria given for jobs to be considered
blocking or informing are aspirational. The same applies to having a formal,
detailed process to promote or demote jobs. The key factor for such a process is
to provide enough time for discussions and consensus within the Kubernetes
community and all participating roles.

The general process to promote or demote jobs follows these steps:

1. Posting a note to the k-dev and kubernetes-sig-release mailing lists about
   the overall plan, linking to a k/sig-release issue to leave room for
   further discussions.

1. In the issue, provide links to data or reasoning that prove the job should be
   promoted or demoted. The goal is to make your case, and do the legwork for
   your audience, so that the resulting test-infra PR can represent an auditable
   decision. Examples for such data are:

   - links to issues or this doc if a job is seen as not meeting criteria
   - links to testgrid dashboards or summaries that show the job's performance
   - links to triage that show the job's performance
   - rationale for why this job is (no longer) meaningful or necessary

1. Ensure approval from the job OWNERS, SIG Release Tech Leads or Chairs as well
   as:

   - the current Release Team Lead, CI Signal Lead and Release Manager if the
     intention is to change a `sig-release-master-*` dashboard
   - the Release Managers if the intention is to change a `sig-release-1.x-*`
     dashboard

1. Ensure that lazy consensus is reached in the issue by setting a deadline at
   least 4 weeks after creation. If code freeze for a minor release is in place,
   then the consensus deadline will automatically extend until the Kubernetes
   `master` branch gets reopened.

1. Open a kubernetes/test-infra PR that promotes or demotes the job to/from any
   of the sig-release boards.
