# Kubernetes Patch Releases

Schedule and team contact information for Kubernetes patch releases.

For general information about Kubernetes release cycle, see the
[release process description].

## Cadence

Our typical patch release cadence is monthly.  It is
commonly a bit faster (1 to 2 weeks) for the earliest patch releases
after a 1.X minor release.  Critical bug fixes may cause a more
immediate release outside of the normal cadence.  We also aim to not make
releases during major holiday periods.

## Contact

See the [Release Managers page][release-managers] for full contact details on the Patch Release Team.

Please give us a business day to respond - we may be in a different timezone!

In between releases the team is looking at incoming cherry-pick
requests on a weekly basis.  The team will get in touch with
submitters via GitHub PR, SIG channels in Slack, and direct messages
in Slack and [email](mailto:release-managers-private@kubernetes.io)
if there are questions on the PR.

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

## Upcoming Monthly Releases

Timelines may vary with the severity of bug fixes, but for easier planning we
will target the following monthly release points.  Unplanned, critical
releases may also occur in between these.

| Monthly Patch Release | Target date |
| --- | --- |
| September 2020 | 2020-09-16 |
| October 2020 | 2020-10-14 |
| November 2020 | 2020-11-11 |
| December 2020 | 2020-12-09 |
| January 2021 | 2021-01-13 |
| February 2021 | 2021-02-17 |
| March 2021 | 2021-03-17 |

## Detailed Release History for Active Branches

### 1.18

Next patch release is **1.18.9**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.18.9 | 2020-09-11 | 2020-09-16 |
| 1.18.8 | N/A | 2020-08-13 |
| 1.18.7 | 2020-08-07 | 2020-08-12 |
| 1.18.6 | 2020-07-10 | 2020-07-15 |
| 1.18.5 | 2020-06-25 | 2020-06-26 |
| 1.18.4 | 2020-06-12 | 2020-06-17 |
| 1.18.3 | 2020-05-15 | 2020-05-20 |
| 1.18.2 | 2020-04-13 | 2020-04-16 |
| 1.18.1 | 2020-04-06 | 2020-04-08 |

### 1.17

Next patch release is **1.17.12**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.17.12 | 2020-09-11 | 2020-09-16 |
| 1.17.11 | N/A | 2020-08-13 |
| 1.17.10 | 2020-08-07 | 2020-08-12 |
| 1.17.9 | 2020-07-10 | 2020-07-15 |
| 1.17.8 | 2020-06-25 | 2020-06-26 |
| 1.17.7 | 2020-06-12 | 2020-06-17 |
| 1.17.6 | 2020-05-15 | 2020-05-20 |
| 1.17.5 | 2020-04-13 | 2020-04-16 |
| 1.17.4 | 2020-03-09 | 2020-03-12 |
| 1.17.3 | 2020-02-07 | 2020-02-11 |
| 1.17.2 | [No-op release](https://groups.google.com/d/topic/kubernetes-dev/Mhpx-loSBns/discussion) | 2020-01-21 |
| 1.17.1 | 2020-01-10 | 2020-01-14 |

### 1.16

The most recent patch release was **1.16.14**.

The pending 1.16.15 release will be the last patch release for the 1.16 branch before it is EOL.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.16.15 | 2020-08-28 | 2020-09-02 |
| 1.16.14 | 2020-08-07 | 2020-08-12 |
| 1.16.13 | 2020-07-10 | 2020-07-15 |
| 1.16.12 | 2020-06-25 | 2020-06-26 |
| 1.16.11 | 2020-06-12 | 2020-06-17 |
| 1.16.10 | 2020-05-15 | 2020-05-20 |
| 1.16.9 | 2020-04-13 | 2020-04-16 |
| 1.16.8 | 2020-03-09 | 2020-03-12 |
| 1.16.7 | 2020-02-07 | 2020-02-11 |
| 1.16.6 | [No-op release](https://groups.google.com/d/topic/kubernetes-dev/Mhpx-loSBns/discussion) | 2020-01-21 |
| 1.16.5 | 2020-01-10 | 2020-01-14 |
| 1.16.4 | 2019-12-06 | 2019-12-11 |
| 1.16.3 | 2019-11-08 | 2019-11-13 |
| 1.16.2 | 2019-10-11 | 2019-10-15 |
| 1.16.1 | 2019-09-27 | 2019-10-02 |

## Non-Active Branch History

These releases are no longer supported.

| Minor Version | Final Patch Release | EOL date |
| --- | --- | --- |
| 1.15 | 1.15.12 | 2020-05-06 |
| 1.14 | 1.14.10 | 2019-12-11 |
| 1.13 | 1.13.12 | 2019-10-15 |
| 1.12 | 1.12.10 | 2019-07-08 |
| 1.11 | 1.11.10 | 2019-05-01 |
| 1.10 | 1.10.13 | 2019-02-13 |
| 1.9  | 1.9.11  | 2018-09-29 |
| 1.8  | 1.8.15  | 2018-07-12 |
| 1.7  | 1.7.16  | 2018-04-04 |
| 1.6  | 1.6.13  | 2017-11-23 |
| 1.5  | 1.5.8   | 2017-10-01 |
| 1.4  | 1.4.12  | 2017-04-21 |
| 1.3  | 1.3.10  | 2016-11-01 |
| 1.2  | 1.2.7   | 2016-10-23 |

[cherry-pick process]: https://git.k8s.io/community/contributors/devel/sig-release/cherry-picks.md
[release-managers]: /release-managers.md
[release process description]: https://git.k8s.io/community/contributors/devel/sig-release/release.md
