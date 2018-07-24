# Features Lead Handbook

## Overview

While the Features Lead serves as a member of the Release Team (a subproject of [SIG Release][sig-release]), this role is also a liaison to [SIG PM][sig-pm] across the following subprojects:
- Product Management
- Program Management & Release
- Release Marketing

## Responsibilities

A Features Lead holds the following responsibilities:
- Maintain the active status of Features within [kubernetes/features][k/features]
- Facilitate communication between Feature Owners, Product Management, and SIG leadership, as necessary
- Collate the major themes of the release, including but not limited to:
  - new features
  - long-awaited features
  - features moving into GA
  - feature deprecations
  - notable changes to existing behaviors
- Assist in Communications activities (in conjunction with the Communications Lead & the CNCF Communications team):
  - Draft and / or review https://kubernetes.io/blog/ release announcement post, leveraging the themes collected across the release cycle e.g., [1.11 Announcement][1.11-announcement]
  - Engage with media analysts during the embargo period to discuss the release themes
  - CNCF Kubernetes Release webinar
  - Identify potential contributors for the “5 Days of Kubernetes” blog series
  - Identify candidates to assume the Features Lead role (according to the [Release Team selection process][rt-selection]) in the following release cycle

## General Requirements

In addition to the [requirements detailed for all Release Team members][rt-requirements], becoming a Features Lead has additional gates:
  - MUST have served on the Release Team in a previous capacity, ideally as a Features Shadow
  - MUST be a member of the [SIG Release Google Group][sig-release-group]
  - MUST be a member of the [SIG PM Google Group][sig-pm-group]
  - MUST be a member of the [Kubernetes Milestone Burndown Google Group][burndown-group]

Helpful characteristics of a Features Lead include:
- experience with the Kubernetes community, code layout, ecosystem projects, organizational norms, governance, SIG structure, architecture, and release process
- product / project / program management experience
- release management experience

## Mentoring Shadows

## Getting Started

### Access Required
Ensure that the previous Features Lead has given (or facilitated getting) you access to:
- GitHub teams
  - features-maintainers
  - kubernetes-milestone-maintainers
- OWNERS_ALIASES (as `features-maintainers` in [kubernetes/features][k/features] repo)
- Edit access to the Kubernetes x.y.0 Features Tracking Sheet e.g., [Kubernetes 1.12 Features Tracking][1.12-tracking]

## Process

### Standards
As mentioned previously, the Features Lead role encompasses several cross-functional responsibilities with [SIG PM][sig-pm].

The process of maintaining a feature in Kubernetes is documented in the [kubernetes/features][k/features] repo. Any questions / concerns / suggestions for improvement to the Features process should be raised as GitHub issues / PRs to k/features.

It is important that this process be followed and documentation remain up-to-date as the [Features repo][k/features] is the primary ingress point for contributors interested in tracking features.

### Milestone Activities + Timing
- Link items from succession section
- (optional) Watch the kubernetes/features repo to get notified on all issues
- Ensure that Feature Tracking sheet for the new release was created by the previous Features Lead and populated with the features removed from the previous milestone
- Features Tracking sheet is shortlinked with the pattern `k8sxyy-features` e.g., http://bit.ly/k8s112-features
- Ensure the Features Tracking sheet has the appropriate permissions:
ownership transferred to you
  - anyone who has the link can comment
  - Edit access
    - [SIG PM][sig-pm] Chairs
    - [Kubernetes Release Team Google Group][rt-group]
  - Comment access
    - [SIG Release Google Group][sig-release-group]
    - [SIG PM Google Group][sig-pm-group]
    - [SIG Docs Google Group][sig-docs-group]
    - [SIG Leads Google Group][sig-leads-group]
- Work with outgoing Features Lead to elicit information from SIGs on features removed from previous milestone
- Features Triage
  - Check features and ensure they provide the required information and labels to be accepted into the milestone.
    - Features marked for current milestone
    - Features marked for previous milestone
    - Features marked with `next-milestone` (https://github.com/kubernetes/features/issues?q=is%3Aopen+is%3Aissue+milestone%3Anext-milestone+sort%3Acreated-desc)
    - Features without a milestone (https://github.com/kubernetes/features/issues?q=is%3Aopen+is%3Aissue+sort%3Acreated-desc+no%3Amilestone)
    - Features from two or more milestones ago
  - Confirm with the Feature Owner if work is planned for current milestone
    - Apply the current milestone
    - Add the feature to the Features Tracking sheet
    - Apply the `tracked/yes` label
    - Remove `lifecycle/frozen` label from all issues
- Sync with Product Management Chair (bi-weekly?)

### Escalation / Handling Unresponsive Feature Owners
List of unresponsive issues? Add unresponsive status to features tracking?

### Exceptions

### CNCF / Media Engagement

### Succession
- Generate new Features Tracking sheet with features that were removed from the current milestone
- Features Tracking sheet is shortlinked with the pattern `k8sxyy-features` e.g., http://bit.ly/k8s112-features
- Continually work to improve Features process
- Review / update documentation as the release cycle
- Close issues marked as stable that made it into the release
- Close milestones that are complete
- Cleanup old milestones

### Limitations
- Populating the Features Tracking sheet is a manual process
- Features issues that are not submitted to [k/features][k/features] are not actively tracked in the context of the Release Team and Release cycle e.g.,
  - `kubeadm` (https://github.com/kubernetes/kubeadm/issues?utf8=%E2%9C%93&q=is%3Aissue+label%3Akind%2Ffeature+milestone%3Av1.12+)
  - out-of-tree Cloud Provider code that may live in `kubernetes-sigs/*`
  - additional out-of-tree code that may live in the following organizations:
    - `kubernetes`
		- `kubernetes-client`
		- `kubernetes-csi`
		- `kubernetes-incubator`
		- `kubernetes-sig-testing`
		- `kubernetes-sigs`
- Finding consensus on how frequently to triage features

## Signals

## Tips & Tricks

#### Sample Searches (examples)

#### GitHub Notifications
https://groups.google.com/forum/#!topic/kubernetes-dev/5qU8irU7_tE


[burndown-group]: https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown
[k/features]: https://github.com/kubernetes/features
[rt-group]: https://groups.google.com/forum/#!forum/kubernetes-release-team
[rt-selection]: /README.md#release-team-selection
[rt-requirements]: /README.md#release-team-requirements
[sig-docs-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-docs
[sig-leads-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-leads
[sig-pm]: https://github.com/kubernetes/community/blob/master/sig-pm/README.md
[sig-pm-group]: https://groups.google.com/forum/#!forum/kubernetes-pm
[sig-release]: https://github.com/kubernetes/community/blob/master/sig-release/README.md
[sig-release-group]: https://groups.google.com/forum/#!forum/kubernetes-sig-release
[1.11-announcement]: https://kubernetes.io/blog/2018/06/27/kubernetes-1.11-release-announcement/
[1.12-tracking]: http://bit.ly/k8s112-features
