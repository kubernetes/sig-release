# Release Blocking Jobs

Here is a list of jobs that should block release if not healthy.

If you want to add a release-branch job, please add them to the appropriate
sig-release-x.y-all dashboard first. Then show the test is not flaky, and the
release team can decide if the test should be added to release-blocking
dashboard as well.

## Release-Blocking Criteria

NB: Note that while we describe the "ideal" goals below, not all jobs currently
in the release-blocking dashboards currently meet these criteria, and we intend
to correct with follow on PR's.  Please see the umbrella issue for followup
work: [kubernetes/sig-release#347](https://github.com/kubernetes/sig-release/issues/347)

The ideal release-blocking job meets the following criteria:

- It provisions clusters via open-source software instead of a hosted service
<!-- TODO(spiffxp):
  - should any allowances be made for conformance?
-->
- It finishes a run in 120 minutes or less
<!-- TODO(spiffxp):
  - this should be a percentile, not a max
-->
- It runs at least every 3 hours
- It passes 75% of all of its runs in the past week (regardless of underlying
  commit(s))
- Is capable of passing 3 times in a row against the same commit
- Is owned by a SIG that is responsive to addressing failures
<!-- TODO(spiffxp):
  - represented by a configured testgrid alert
  - contact info is also part of job description
-->
- Fails for no more than 10 runs in a row
- Has a documented reason for its inclusion in the release-blocking suite
<!-- TODO(spiffxp):
  - represented in description? link to an issue where discussion was had?
-->

The reasoning for the above is that as we get to the end of a release cycle,
we are usually waiting on a handful of bug fixes and want to be certain that
the underlying bug is truly fixed. This means we prefer to see multiple test
results for the same commit. If we wait for three successful runs that are
scheduled every three hours, we wait for nine hours.  This effectively gives
us the chance to make two changes/decisions in a 24 hour period.

The thresholds given are aspirational. We recognize that not every job may be
able to strictly adhere to all of these criteria all of the time.  We also
recognize that metrics can be gamed. Thus we consider human review to be the
ultimate authority in the process to promote a demote a job as
release-blocking, and metrics to be the triggering criteria for such review.
There is no shame in being demoted, and once the problems have been fixed, a
job can be promoted back.

We intend to drive the criteria to stricter thresholds over time, e.g.,
- finishing a run in 60min or less
- running at least every 2 hours
- passing at least 90% of all runs

## Release-Informing Criteria

Jobs that are considered useful or necessary to inform whether a commit on
master is ready for release, but that clearly do not meet release-blocking
criteria, may be placed on the sig-release-master-informing dashboard. These
are often jobs that are some combination of slow, flaky, infrequent, or
difficult to maintain.

These jobs may still block the release, but because they require a lot of
manual, human interpretation, we choose to move them to a separate dashboard.

<!-- TOOD(spiffxp): implement release-master-informing, populate with e.g.:
- gce-master-scale-performance
- gce-cos-master-serial
- gke-cos-master-serial
- packages-pushed-master
- conformance jobs that run less frequently than every 3 hours
-->

## Promoting or Demoting Jobs

As described above, the thresholds and criteria given for jobs to be considered
release-blocking or release-informing are at present aspirational. Having a
formal, detailed process to promote or demote jobs is also aspirational.

Here is a sketch of a process to follow, we will iterate as we find areas to
improve.

- When opening a kubernetes/test-infra PR that promotes or demotes a job to/from
  any of the sig-release boards, please ensure that you get lgtm/approval from
  the appropriate individuals:
  - patch release manager for release-1.y if you touch release-1.y dashboards
  - current release team lead if you touch release-master dashboards or the
    release-1.y dashboard for the current release cycle
  - a representative from the sig that owns the job in question (if you are
    that representative, then your authorship can be considered approval)
- Provide links to data or reasoning that prove the job should be promoted or
  demoted. The goal is to make your case, and do the legwork for your
  audience, so that the PR can represent an auditable decision. eg:
  - links to issues or this doc if a job is seen as not meeting criteria
  - links to testgrid dashboards or summaries that show the job's performance
  - links to triage that show the job's performance
  - rationale for why this job is meaningful or necessary (or is no longer
    meaningful or necessary)
  - etc.

## Release-Blocking Dashboards

<!-- TODO(krzyzacy): use master-blocking dashboard, once we sort out jobs
                     like scalability -->

We use [1.12 release-blocking dashboard](http://k8s-testgrid.appspot.com/sig-release-1.12-blocking)
as a source of truth. The tab names are autogenerated based on the job names,
and have the branch/version in their name. For example, for release x.y:

* Make & Unit & Integration
  - build-x.y
  - verify-x.y
  - integration-x.y
  - bazel-build-x.y
  - bazel-test-x.y
* GCE
  - gce-cos-default-x.y
  - gce-cos-serial-x.y
  - gce-cos-slow-x.y
  - gce-cos-ingress-x.y
  - gce-cos-reboot-x.y
  - gce-cos-alphafeatures-x.y
  - gce-cos-conformance-x.y
  - gce-gpu-device-plugin-x.y
  - gci-gce-scalability-x.y
* GKE
  - gke-cos-default-x.y
  - gke-cos-serial-x.y
  - gke-cos-slow-x.y
  - gke-cos-ingress-x.y
  - gke-cos-reboot-x.y
  - gke-gpu-device-plugin-x.y
  - gke-gpu-device-plugin-p100-x.y
* AWS
  - kops-aws-x.y
* Node
  - node-kubelet-x.y
* [Kubeadm](https://github.com/kubernetes/kubeadm/blob/master/docs/managing-e2e-tests.md)
  - kubeadm-gce
  - kubeadm-gce-x.$(y-1)-on-x.y

## Testgrid Release Blocking Dashboards

- [master blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)
- [1.12 blocking](https://k8s-testgrid.appspot.com/sig-release-1.12-blocking)
- [1.11 blocking](https://k8s-testgrid.appspot.com/sig-release-1.11-blocking)
- [1.10 blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

<!--
The link map need to be updated every release
-->
