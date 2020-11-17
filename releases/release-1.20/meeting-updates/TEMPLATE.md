# Meeting Updates YYYY-mm-dd

Cutoff Time: YYYY-mm-dd HH:MM:SS (Times in a few other timezones as well)

Repository sync responsibility: Name / Slack Handle

## Enhancements

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Tracking Sheet: [Kubernetes 1.20 Enhancements][enhancements-tracking]

Metrics: #
  - Tracked:
  - Alpha:
  - Beta:
  - Stable:
  - Deprecation:

Additional Notes:
  - <!-- ANY ADDITIONAL UPDATE -->

## CI Signal

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Notable Events:
  - [Master-blocking][ci-signal-master-blocking]:
  - [Master-informing][ci-signal-master-informing]:
  - [release-misc][ci-signal-release-misc]:
  - [1.20 blocking][ci-signal-1.20-blocking]:
  - [1.20 informing][ci-signal-1.20-informing]:
  - Flaky Jobs:

[CI Signal Team Dashboard][ci-signal-team-dashboard]
  - No new response:
  - Under investigation:
  - Observing:
  - Resolved:
  - Resolved for over two weeks:

Additional Notes:
  - <!-- ANY ADDITIONAL UPDATE -->


## Bug triage

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Trends: Current count (diff since last mtg) (diff since 1 week ago)

Query:
  - [open non-test/flake k/k issues for v1.20][bt-issue-1.20-open-kk-non-failing]:
  - [priority/critical-urgent issues][bt-issue-1.20-critical-urgent]:
  - [priority/important-soon issues][bt-issue-1.20-important-soon]:

Query:
  - [open k/k PR’s for v1.20][bt-pr-1.20-open]:
  - [priority/critical-urgent PRs][bt-pr-1.20-critical-urgent]:
  - [priority/important-soon PRs][bt-pr-1.20-important-soon]:

Query:
  - [ALL open k/k issues for v1.20][bt-issue-1.20-all] including [open non-test/flake k/k issues for v1.20][bt-issue-1.20-open-kk-non-failing]:

Additional Notes:
  - <!-- ANY ADDITIONAL UPDATE -->


## Docs

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Updates:
  - <!-- START HERE -->


## Release Notes

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Updates:
  - <!-- START HERE -->


## Comms

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Updates:
  - <!-- START HERE -->


## Release Branch Management

Author: Name / Slack Handle

Current Status: Green | Yellow | Red

Updates:
  - <!-- START HERE -->


## Emeritus Lead

Author: Lachlan Evenson / @lachie83

Updates:
  - <!-- START HERE -->


## Release Lead

Author: Name / Slack Handle

Timeline Review:
  - <!-- Important events in current week -->
Updates:
  - <!-- START HERE -->


## SIG Scalability

Author: @tosi3k ([On Call][scalability-oncall])

Updates:
  - <!-- START HERE -->

## Program Management

Author: Lauri Apple / @Lauri Apple

Updates:
  - <!-- START HERE -->


<!-- References henceforth. Please modify if you see anything out of the place. -->

[enhancements-tracking]: https://bit.ly/k8s-1-20-enhancements
[ci-signal-master-blocking]: https://testgrid.k8s.io/sig-release-master-blocking
[ci-signal-master-informing]: https://testgrid.k8s.io/sig-release-master-informing
[ci-signal-release-misc]: https://testgrid.k8s.io/sig-release-misc
[ci-signal-1.20-blocking]: https://testgrid.k8s.io/sig-release-1.20-blocking
[ci-signal-1.20-informing]: https://testgrid.k8s.io/sig-release-1.20-informing
[ci-signal-team-dashboard]: https://github.com/orgs/kubernetes/projects/11?fullscreen=true
[bt-issue-1.20-open-kk-non-failing]: https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+milestone%3Av1.20+is%3Aissue+sort%3Aupdated-asc+-label%3Akind%2Ffailing-test+-label%3Akind%2Fflake+
[bt-issue-1.20-critical-urgent]: https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+milestone%3Av1.20+label%3Apriority%2Fcritical-urgent+is%3Aissue+sort%3Aupdated-asc+-label%3Akind%2Ffailing-test+-label%3Akind%2Fflake+
[bt-issue-1.20-important-soon]: https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+milestone%3Av1.20+label%3Apriority%2Fimportant-soon+is%3Aissue+sort%3Aupdated-asc+-label%3Akind%2Ffailing-test+-label%3Akind%2Fflake+
[bt-pr-1.20-open]: https://github.com/kubernetes/kubernetes/pulls?q=repo%3Akubernetes%2Fkubernetes+is%3Aopen+milestone%3Av1.20+is%3Apr+sort%3Aupdated-asc+
[bt-pr-1.20-critical-urgent]: https://github.com/kubernetes/kubernetes/pulls?q=repo%3Akubernetes%2Fkubernetes+is%3Aopen+milestone%3Av1.20+is%3Apr+sort%3Aupdated-asc+label%3Apriority%2Fcritical-urgent
[bt-pr-1.20-important-soon]: https://github.com/kubernetes/kubernetes/pulls?q=repo%3Akubernetes%2Fkubernetes+is%3Aopen+milestone%3Av1.20+label%3Apriority%2Fimportant-soon+is%3Apr+sort%3Aupdated-asc+
[bt-issue-1.20-all]: https://github.com/kubernetes/kubernetes/issues?q=repo%3Akubernetes%2Fkubernetes+milestone%3Av1.20+is%3Aissue+is%3Aopen+sort%3Aupdated-asc+
[scalability-oncall]: https://go.k8s.io/oncall
