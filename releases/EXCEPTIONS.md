# Exceptions to Milestone Enhancement Complete dates

For minor (1.x) milestones, the Kubernetes project has enhancement complete dates (hitting enhancement complete is all enhancement LGTMed and in submit queue with tests written) after which no new enhancements are accepted. Since minor releases come three times per year, missing a enhancement complete date by just one day can mean that enhancement takes an additional 4 months to be released.

While the enhancement complete milestone dates are published well in advance, and the default is that missing the date means your enhancement will be part of the next milestone, there may be cases where an exception makes sense.

Note that the exception process only applies to enhancements, not bugs managed by the Bugs Triage team.

If you have questions about the status of your enhancement, including the reasons for its removal from the milestone, please reach out to the enhancements lead in the `#release-enhancements` channel on Slack.  Some trivial "clerical errors", such as forgetting the set the milestone, can be remedied without a formal exception.

## Exception Criteria

Exceptions will be granted on the basis of *risk*, *length of exception required*, and *timeliness of exception request*.

The enhancement coming in late should represent a **low risk to the Kubernetes system** - it should not risk other areas of the code, and it should itself be well contained and tested.

An issue must be opened for the enhancement in the [enhancements repo](https://github.com/kubernetes/enhancements/issues).

The length of exception needed should be on the order of days, not weeks. If there are 3 PRs in and 1 still waiting review, that's a much stronger case than a enhancement that doesn't have any PRs out yet.

Exceptions should be filed at the earliest opportunity i.e., as soon as it's clear an enhancement may miss the deadline.

## Requesting an exception

### Enhancement Owners

To file for an exception, please fill out the questions below:

- Enhancement name:
- Enhancement status (alpha/beta/stable):
- SIG:
- k/enhancements repo issue #:
- PR #’s:
- Additional time needed (in days):
- Reason this enhancement is critical for this milestone:
- Risks from adding code late: (to k8s stability, testing, etc.)
- Risks from cutting enhancement: (partial implementation, critical customer usecase, etc.)

Email them to:

- Your SIG's mailing list
- release-team@kubernetes.io
- kubernetes-sig-release@googlegroups.com

[You should have *very high confidence* on the “additional time needed” number - we will not grant multiple exceptions for a enhancement. The same goes for over-estimating on the time needed. If the exception request is rejected on the basis that the asking time is too high, we will not re-evaluate if the asking time decreases.]

Exceptions after enhancements freeze:
If your issue was removed during the enhancements freeze please file an exception at your earliest convenience.  All requests will be reviewed and either approved or rejected as they come in.  The release team will be responsible for approving or rejecting exceptions based on the questions above.  

Exceptions after code freeze: 
Requests for exceptions must be submitted before the first milestone burn down meeting. All requests for exception will be reviewed and either approved or rejected during the first meeting. The release team will be responsible for approving or rejecting exceptions based on the questions above.

Exceptions after docs freeze:
As the docs freeze takes place close to the end of the release cycle, please file an exception request as soon as possible, ideally in advance of the deadline if you know you will miss it, or within 24 hours of missing the docs freeze deadline. All requests will be reviewed and approved or rejected as they come in. The release team will be responsible for approving or rejecting exceptions based on the questions above, with input from SIG Docs.


Information about the current release can be found in the relevant release directory:
- important dates e.g., [releases/release-1.14/README.md](/releases/release-1.14/README.md)
- Release Team members e.g., [releases/release-1.14/release_team.md](/releases/release-1.14/release_team.md)


Once an exception is approved, it should be broadcast broadly: send an email with the data and approval to kubernetes-dev@ and your SIG group, then follow up with a reply to that email once the enhancement is completed.

### Enhancement Lead

After exceptions have been reviewed, the Enhancements Lead should create an `exceptions.yaml` file in the current release's directory e.g., [release-1.11/exceptions.yaml](release-1.11/exceptions.yaml).


`exceptions.yaml` should be formatted as follows:

```yaml
# Exceptions to Code Freeze requested in 1.13
# Google Group: https://groups.google.com/forum/#!topic/kubernetes-milestone-burndown
# Release Team Lead: Aishwarya Sundar (@AishSundar)

- name: "Update Istio addon manifest"
  issue: "https://github.com/kubernetes/kubernetes/issues/64563"
  date_requested: 2018-10-24
  date_reviewed: 2018-10-24
  thread: "https://groups.google.com/forum/#!topic/kubernetes-milestone-burndown/68ivj9MGBdU"
  pull_requests:
  - "https://github.com/kubernetes/kubernetes/pull/64537"
  status: "approved"

- name: "Implement IPVS-based in-cluster service load balancing"
  issue: "https://github.com/kubernetes/enhancements/issues/265"
  date_requested: 2018-10-24
  date_reviewed: 2018-10-24
  thread: "https://groups.google.com/forum/#!topic/kubernetes-milestone-burndown/MJrcqkLAcn0"
  pull_requests:
  - "https://github.com/kubernetes/kubernetes/pull/58442"
  status: "approved"
```
