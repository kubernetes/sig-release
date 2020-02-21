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

## Timelines

### 1.17

Next patch release is **1.17.4**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.17.4 | 2020-03-09 | 2020-03-12 |
| 1.17.3 | 2020-02-07 | 2020-02-11 |
| 1.17.2 | [No-op release](https://groups.google.com/d/topic/kubernetes-dev/Mhpx-loSBns/discussion) | 2020-01-21 |
| 1.17.1 | 2020-01-10 | 2020-01-14 |

### 1.16

Next patch release is **1.16.8**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.16.8 | 2020-03-09 | 2020-03-12 |
| 1.16.7 | 2020-02-07 | 2020-02-11 |
| 1.16.6 | [No-op release](https://groups.google.com/d/topic/kubernetes-dev/Mhpx-loSBns/discussion) | 2020-01-21 |
| 1.16.5 | 2020-01-10 | 2020-01-14 |
| 1.16.4 | 2019-12-06 | 2019-12-11 |
| 1.16.3 | 2019-11-08 | 2019-11-13 |
| 1.16.2 | 2019-10-11 | 2019-10-15 |
| 1.16.1 | 2019-09-27 | 2019-10-02 |

### 1.15

Next patch release is **1.15.11**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.15.11 | 2020-03-09 | 2020-03-12 |
| 1.15.10 | 2020-02-07 | 2020-02-11 |
| 1.15.9 | [No-op release](https://groups.google.com/d/topic/kubernetes-dev/Mhpx-loSBns/discussion) | 2020-01-21 |
| 1.15.8 | 2020-01-10 | 2020-01-14 |
| 1.15.7 | 2019-12-06 | 2019-12-11 |
| 1.15.6 | 2019-11-08 | 2019-11-13 |
| 1.15.5 | 2019-10-11 | 2019-10-15 |
| 1.15.4 | 2019-09-13 | 2019-09-18 |
| 1.15.3 | 2019-08-15 | 2019-08-19 |
| 1.15.2 | 2019-08-02 | 2019-08-05 |
| 1.15.1 | 2019-07-15 | 2019-07-18 |

### 1.14 and older

These releases are no longer supported.

| Minor Version | Final Patch Release | EOL date |
| --- | --- | --- |
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
