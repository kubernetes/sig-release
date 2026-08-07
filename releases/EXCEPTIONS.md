# Exceptions to Milestone Enhancement Complete dates

For minor (1.x) milestones, the Kubernetes project has enhancement complete dates (hitting enhancement complete is all enhancement LGTMed and in submit queue with tests written) after which no new enhancements are accepted. Since minor releases come three times per year, missing a enhancement complete date by just one day can mean that enhancement takes an additional 4 months to be released.

While the enhancement complete milestone dates are published well in advance, and the default is that missing the date means your enhancement will be part of the next milestone, there may be cases where an exception makes sense.

Note that the exception process only applies to enhancements, not bugs managed by the Release Signal team.

If you have questions about the status of your enhancement, including the reasons for its removal from the milestone, please reach out to the enhancements lead in the `#release-enhancements` channel on Slack.  Some trivial "clerical errors", such as forgetting the set the milestone, can be remedied without a formal exception.

## Exception Criteria

Exceptions will be granted on the basis of *risk*, *length of exception required*, and *timeliness of exception request*.

The enhancement coming in late should represent a **low risk to the Kubernetes system** - it should not risk other areas of the code, and it should itself be well contained and tested.

The length of exception needed should be on the order of days, not weeks. If there are 3 PRs in and 1 still waiting review, that's a much stronger case than a enhancement that doesn't have any PRs out yet. Granted exception requests are due at the end of the last day [Anywhere on Earth (AoE) time](https://dateful.com/convert/aoe-anywhere-on-earth).

Exceptions should be filed at the earliest opportunity i.e., as soon as it's clear an enhancement may miss the deadline.

## Requesting an exception

### Enhancement Owners

To file for an exception, please fill out the questions below:

- Enhancement name:
- Enhancement status (alpha/beta/stable):
- SIG:
- k/enhancements repo issue #:
- PR #’s:
- Additional time needed (in calendar days, due end of day AoE):
- Reason this enhancement is critical for this milestone:
- Risks from adding code late: (to k8s stability, testing, etc.)
- Risks from cutting enhancement: (partial implementation, critical customer usecase, etc.)

Email them to:

- Your SIG's mailing list
- release-team@kubernetes.io
- kubernetes-sig-release@googlegroups.com

You should have *very high confidence* on the "additional time needed" number. The Release Team will not grant multiple exceptions for the **same** freeze for a single enhancement — once an exception has been approved or rejected for a given freeze, the decision is final and additional time cannot be requested for that freeze. The same goes for over-estimating on the time needed: if the exception request is rejected on the basis that the asking time is too high, we will not re-evaluate if the asking time decreases.

A KEP may still request separate exceptions at different freeze points across the release cycle (e.g. a PRR Freeze exception and, later, a Code/Test Freeze exception), each evaluated on its own merits. The [combined PRR + Enhancements Freeze request described below](#exceptions-after-prr-freeze) remains the one case where a single request may cover two freezes.

#### Exceptions after PRR freeze:
- Requests for exceptions must be submitted within 3 days after PRR freeze. You may file an exception request in advance if you know your KEP will miss the PRR freeze deadline.
- Due to the proximity to enhancements freeze, if you anticipate that you will need an enhancements freeze exception as well, you may submit an exception request for both in the same request (please mention that the request is for both PRR freeze and enhancements freeze, and list the expected completion date of both combined).
- All requests will be reviewed and either approved or rejected as they come in.  The release team will be responsible for approving or rejecting exceptions based on the questions above.

#### Exceptions after enhancements freeze:
- Requests for exceptions must be submitted within 3 days after enhancements freeze. You may file an exception request in advance if you know your KEP will miss the enhancements freeze deadline.
- All requests will be reviewed and either approved or rejected as they come in. The release team will be responsible for approving or rejecting exceptions based on the questions above.

#### Exceptions after code freeze and test freeze:
- Requests for exceptions must be submitted within 3 days after code freeze and test freeze. You may file an exception request in advance if you know your KEP will miss the code freeze and test freeze deadline.
- All requests for exception will be reviewed and either approved or rejected during the first meeting. The release team will be responsible for approving or rejecting exceptions based on the questions above.

#### Exceptions after docs freeze:
- As the docs freeze takes place close to the end of the release cycle, please file an exception request as soon as possible, ideally in advance of the deadline if you know you will miss it, or within 24 hours of missing the docs freeze deadline.
- The Kubernetes website PR review process applies to docs exception work (see [Reviewing a PR](https://kubernetes.io/docs/contribute/review/for-approvers/#reviewing-a-pr)), including technical review and approver workflows.
- Exception requests should include at least one additional business day after technical review is complete so SIG Docs OWNERS have time to review and approve.
- All requests will be reviewed and approved or rejected as they come in. The release team will be responsible for approving or rejecting exceptions based on the questions above, with input from SIG Docs.


Information about the current release can be found in the relevant release directory:
- important dates e.g., [releases/release-1.14/README.md](/releases/release-1.14/README.md)
- Release Team members e.g., [releases/release-1.14/release_team.md](/releases/release-1.14/release_team.md)


Once an exception is approved, it should be broadcast broadly: send an email with the data and approval to kubernetes-dev@ and your SIG group, then follow up with a reply to that email once the enhancement is completed.

### Tracking Exception Requests

Starting with the v1.36 release cycle, exception requests are tracked on the release's Release Tracking Board using the `Exception Requests` view (e.g., [v1.36 Exception Requests view](https://github.com/orgs/kubernetes/projects/241/views/7)) instead of an `exceptions.yaml` file in the release directory.

When an exception request comes in, the Enhancements Lead, Release Lead Shadows, or the Release Lead are responsible for:

- Setting the `Exception Request Type` field on the KEP in the Release Tracking Board so it surfaces in the `Exception Requests` view.
- Populating the request metadata (links to the Google Groups thread, Slack thread, related PRs, requested time, request/decision dates, and final status).
- Assigning a Release Team member to follow up.

For the detailed workflow, including how to handle KEPs requesting exceptions for multiple freezes, see the [Exceptions section of the Enhancements Lead handbook](/release-team/role-handbooks/enhancements/README.md#exceptions).
