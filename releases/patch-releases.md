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

### 1.15

Coming soon...

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.15.1 | TBD early July | TBD early July |


### 1.14

Next patch release is **1.14.4**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.14.5 | TBD  | TBD |
| 1.14.4 | 2019-07-02 | 2019-07-08 |
| 1.14.3 | 2019-06-03 | 2019-06-06 |
| 1.14.2 | 2019-05-10 | 2019-05-14 |
| 1.14.1 | 2019-04-05 | 2019-04-08 |


### 1.13

Next patch release is **1.13.8**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.13.9 | TBD | TBD |
| 1.13.8 | 2019-07-02 | 2019-07-08 |
| 1.13.7 | 2019-06-03 | 2019-06-06 |
| 1.13.6 | 2019-05-06 | 2019-05-08 |
| 1.13.5 | 2019-03-21 | 2019-03-25 |
| 1.13.4 | 2019-02-26 | 2019-02-28 |
| 1.13.3 | 2019-01-24 | 2019-02-01 |
| 1.13.2 | 2019-01-08 | 2019-01-10 |
| 1.13.1 | 2018-12-11 | 2018-12-13 |


### 1.12

Next patch release is **1.12.9**.

| Patch Release | Cherry-picks deadline | Target date |
| --- | --- | --- |
| 1.12.10 | 2019-06-28 | 2019-07-01 |
| 1.12.9 | 2019-05-24 | 2019-05-27 |
| 1.12.8 | 2019-04-19 | 2019-04-24 |
| 1.12.7 | 2019-03-21 | 2019-03-25 |
| 1.12.6 | 2019-02-23 | 2019-02-26 |
| 1.12.5 | 2019-01-15 | 2019-01-17 |
| 1.12.4 | 2018-12-13 | 2018-12-18 |
| 1.12.3 | 2018-11-08 | 2018-11-26 |
| 1.12.2 | 2018-10-23 | 2018-10-26 |
| 1.12.1 | 2018-10-05 | 2018-10-05 |


### 1.11 and older

These releases are no longer supported.

[cherry-pick process]: https://git.k8s.io/community/contributors/devel/sig-release/cherry-picks.md
[release-managers]: /release-managers.md
[release process description]: https://git.k8s.io/community/contributors/devel/sig-release/release.md
