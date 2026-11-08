---
name: Cut a release
about: Create a tracking issue for a release cut
title: Cut v1.x.y-{alpha,beta,rc}.z release
labels: sig/release, area/release-eng
---
## Scheduled to happen: <!-- Wed, YYYY-MM-DD (pre-releases are usually cut on Wednesdays, check the release schedule; patch releases follow the patch release schedule) -->

_Note for v1.x.0 releases: Having this issue in open state will stop the
periodic run of [`krel fast-forward`](https://testgrid.k8s.io/sig-release-releng-blocking#git-repo-kubernetes-fast-forward)
to avoid conflicts with releases running in parallel. The fast-forward will
automatically stop once the v1.x.0 tag is available._

## Release Blocking Issues
<!--

Make a list of anything preventing the release to start
(failing tests, pending image bumps, etc) and link them
to the relevant GitHub issues:

- [ ] Issue 1
- [ ] Issue 2

-->

<!--

Release Process Steps:
======================

Create a thread on #release-management on Slack to notify updates
about the release. For example,
- https://kubernetes.slack.com/archives/CJH2GBF7Y/p1635868822040300
- https://kubernetes.slack.com/archives/CJH2GBF7Y/p1631606375087500

- Add/Remove items of the checklist as you see fit
- Post bumps or issues encountered along the way

Hints and pointers to docs for each step of the release process:

The full procedure is in the Release Cut Handbook:
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md

Screenshot Testgrid Boards:
Use `krel testgridshot` to automatically create the screenshots
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#3-generate-testgrid-comment

Stage and Release:
Use `krel stage` && `krel release`, see the handbook for more:
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#5-mock-stage-and-mock-release

Image promotion:
Use `kpromo pr` to create a pull request
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#7-image-promotion

Notify #release-management on Slack:
Announce the release in a message in the Channel and paste the link
Direct link to slack: https://kubernetes.slack.com/messages/CJH2GBF7Y

Send notification:
Use `krel announce send` (Gmail API with Google OAuth)
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#9-send-release-announcement

Collect Metrics:
Run krel history --branch release-1.xx --date-from yyyy-mm-dd --date-to yyyy-mm-dd
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/release-cuts.md#9-send-release-announcement

Finish post-release branch creation tasks:    <- Only for rc.0 release
See the Post Branch Creation Tasks handbook for more details:
https://github.com/kubernetes/sig-release/blob/master/release-engineering/handbooks/branch-creation.md

Help? Ring @release-managers on slack!

-->

## Release Steps

- [ ] Ensure a green signal has been given by Release Signal **on the day of the cut** (_pre-releases and official releases only_)
- [ ] Create a thread on #release-management: <!-- Paste link to slack -->
- [ ] Screenshot unhealthy release branch testgrid boards
- [ ] Check the health of the publishing-bot <!-- check if https://github.com/kubernetes/kubernetes/issues/56876 is closed -->
<!-- Uncomment for non-patch releases
- Mock Run
  - [ ] Stage
  - [ ] Release
-->
- Nomock Run
  - [ ] Stage
  - [ ] Image Promotion PR: <!-- Paste Pull Request URL here -->
  - [ ] Release
- [ ] Send email notification: <!-- Paste link to kubernetes-dev email -->
- [ ] Notify #release-management on Slack: <!-- Paste link to slack -->
- [ ] Update [`schedule.yaml` file](https://github.com/kubernetes/website/blob/main/data/releases/schedule.yaml) with the latest release using [`schedule-builder`](https://github.com/kubernetes/release/tree/master/cmd/schedule-builder) (_patch releases only_) <!-- Paste Pull Request URL here -->
- [ ] Collect metrics and add them to the `Release Jobs History` table below through `krel history --branch release-1.xx --date-from yyyy-mm-dd --date-to yyyy-mm-dd`
<!-- ONLY FOR RC.0 RELEASES - [ ] Post-release branch creation tasks -->
<!-- ONLY FOR .0 RELEASE - [ ] Code Thaw PR merged and OBS project created for the new minor release -->

## Release Tools Version

<!-- Replace with output of `krel version` -->
```
GitVersion:    v0.XX.Y
GitCommit:     <commit>
GitTreeState:  clean
BuildDate:     YYYY-MM-DDTHH:mm:ssZ
GoVersion:     go1.XX.Y
Compiler:      gc
Platform:      <os>/<arch>
```

## Release Jobs History

<!-- The following table can be automatically generated using `krel history` -->
| Step | Command | Link | Start | Duration | Succeeded? |
| --- | --- | --- | --- | --- | --- |
<!-- Uncomment for non-patch releases
| Mock stage | `krel stage [arguments]` | | | | |
| Mock release | `krel release [arguments]` | | | | |
-->
| Stage | `krel stage [arguments]` | | | | |
| Release | `krel release [arguments]` | | | | |

## Action Items

<!--
During the release, you may find a few things that require updates
(process changes, documentation updates, fixes to release tooling).

Please list them here.

It will be your responsibility to open issues/PRs to resolve these
issues/improvements. Keep this issue open until these action items
are complete.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

## Open Questions

<!--
During the release, you may have a few questions that you can't
answer yourself or may require group discussion.

Please list them here.

Follow up with Release Managers or Release Engineering subproject owners to
get these questions answered.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

/milestone <!-- v1.x e.g. v1.38 -->
/assign <!-- @ the Release Manager responsible for this release -->
/cc @kubernetes/release-managers
/priority important-soon
/kind documentation
