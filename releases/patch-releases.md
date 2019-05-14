# Kubernetes Patch Releases

Schedule and team contact information for Kubernetes patch releases.

For general information about Kubernetes release cycle, see the
[release process description].

## Cadence

The typical patch release cadence tends to be 3 to 4 weeks.  It is
commonly a bit faster (1 to 2 weeks) for the earliest patch releases
after a 1.X minor release.  Critical bug fixes may cause a more
immediate release outside of the normal cadence.  We also aim to not make
releases during major holiday periods.

## Patch Release Management Team

| **Github username** | **Slack username** | **Focus area** |
| --- | --- | --- |
| @aleksandra-malinowska | @aleksandram | 1.13.y, 1.14.y |
| @tpepper | @tpepper | 1.13.y, 1.14.y |
| @feiskyer | @feisky | 1.12.y |

## Contact

To discuss a cherry-pick, schedule, or anything else related to
patch releases, contact the team as a whole or the appropriate member if
there is a specific one:

* Email: The whole team is reachable via email to
  [kubernetes-patch-release-team].
* Slack: You can just tag appropriate individuals or start a broader
  conversation on #sig-release, as well as reach out to team members
  via direct message.
* GitHub: Notifications are sent to the team via
  `<@kubernetes/patch-release-team>`.

Please give us a business day to respond - we may be in a different timezone!

In between releases the team is looking at incoming cherry-pick
requests on a weekly basis.  The team will get in touch with
submitters via GitHub PR, SIG channels in Slack, and direct messages
in Slack and email if there are questions on the PR.

## Cherry-Picks

Please follow the [cherry-pick process].

Cherry-picks must be merge-ready in GitHub with proper labels (eg:
approved, lgtm, release note) and passing CI tests ahead of the
cherry-pick deadline.  This is typically two days before the target
release, but may be more.  Earlier PR readiness is better, as we
need time to get CI signal after merging your cherry-picks ahead
of the actual release.

Cherry-pick PRs which miss merge criteria will be carried over and tracked
for the next patch release.

## Timelines

### 1.14

Next patch release is **1.14.2**.

| **Patch Release** | **Cherry-picks deadline** | **Target date** | **Owner** |
| --- | --- | --- | --- |
| 1.14.2 | 2019-05-10 | 2019-05-14 | [kubernetes-patch-release-team] |
| 1.14.1 | 2019-04-05 | 2019-04-08 | [kubernetes-patch-release-team] |

### 1.13

Next patch release is **1.13.7**.

| **Patch Release** | **Cherry-picks deadline** | **Target date** | **Owner** |
| --- | --- | --- | --- |
| 1.13.7 | TBD late May / early June | TBD late May / early June | [kubernetes-patch-release-team] |
| 1.13.6 | 2019-05-06 | 2019-05-08 | [kubernetes-patch-release-team] |
| 1.13.5 | 2019-03-21 | 2019-03-25 | @aleksandra-malinkowska, @tpepper |
| 1.13.4 | 2019-02-26 | 2019-02-28 | @aleksandra-malinkowska |
| 1.13.3 | 2019-01-24 | 2019-02-01 | @tpepper |
| 1.13.2 | 2019-01-08 | 2019-01-10 | @tpepper |
| 1.13.1 | 2018-12-11 | 2018-12-13 | @aleksandra-malinowska |

### 1.12

Next patch release is **1.12.9**.

| **Patch Release** | **Cherry-picks deadline** | **Target date** | **Owner** |
| --- | --- | --- | --- |
| 1.12.10 | TBD late June | TBD late June | @feiskyer |
| 1.12.9 | 2019-05-24 | 2019-05-27 | @feiskyer |
| 1.12.8 | 2019-04-19 | 2019-04-24 | @feiskyer |
| 1.12.7 | 2019-03-21 | 2019-03-25 | @feiskyer |
| 1.12.6 | 2019-02-23 | 2019-02-26 | @feiskyer |
| 1.12.5 | 2019-01-15 | 2019-01-17 | @feiskyer |
| 1.12.4 | 2018-12-13 | 2018-12-18 | @feiskyer |
| 1.12.3 | 2018-11-08 | 2018-11-26 | @feiskyer |
| 1.12.2 | 2018-10-23 | 2018-10-26 | @feiskyer |
| 1.12.1 | 2018-10-05 | 2018-10-05 | @feiskyer |

### 1.11 and older

These releases are no longer supported.

[release process description]: https://git.k8s.io/community/contributors/devel/sig-release/release.md
[kubernetes-patch-release-team]: mailto:kubernetes-patch-release-team@googlegroups.com
[cherry-pick process]: https://git.k8s.io/community/contributors/devel/sig-release/cherry-picks.md
