---
name: Cut a release
about: Create a tracking issue for a release cut
title: Cut v1.x.y-{alpha,beta,rc}.z release
labels: sig/release, area/release-eng
---
## Scheduled to happen: <!-- Tue, 2021-MM-DD -->

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

- Add/Remove items of the checklist as you see fit
- Post bumps or issues encountered along the way

Hints and pointers to docs for each step of the release process:

Screenshot Testgrid Boards:
Use `krel testgridshot` to automatically create the screenshots
http://bit.ly/relmanagers-handbook#testgrid-screenshots

Stage and Release (mock and nomock):
Use `krel stage` && `krel release` see the handbook for more:
http://bit.ly/relmanagers-handbook#releases-management

Image promotion:
Use `krel promote images` to create a pull request
http://bit.ly/k8s-image-promotion

Notify #release-management on Slack:
Announce the release in a message in the Channel and paste the link
Direct link to slack: https://kubernetes.slack.com/messages/CJH2GBF7Y

Build & publish packages:    ← Skip for prereleases
Coordinate with @google-build-admin before starting. Once the 
NoMock Release is done and **before sending the announcement**
notify @google-build-admin to start building the packages.

Send notification:
Use `krel announce` using your Sendgrid token
http://bit.ly/relmanagers-handbook#sending-mail

Collect Metrics:
Run krel history --branch release-1.mm --date-from 2021-mm-dd
http://bit.ly/relmanagers-handbook#adding-data-about-the-cloud-build-jobs

Help? Ring @release-managers on slack!

-->

## Release Steps

- [ ] Screenshot unhealthy release branch testgrid boards
- Mock Run
  - [ ] Stage
  - [ ] Release
- NoMock Run
  - [ ] Stage
  - [ ] Image Promotion: <!-- Paste Pull Request URL here -->
  - [ ] Release
- [ ] Build & publish packages (debs & rpms) <!-- REMOVE THIS STEP FOR PRE-RELEASES -->
- [ ] Notify #release-management]: <!-- Paste link to slack -->
- [ ] Send notification: <!-- Paste link to kubernetes-dev email -->
- [ ] Collect metrics and add them to the `Release steps` table below


## Release Tools Version

<!-- Replace with output of `krel version` -->
```
GitVersion:    vM.m.p
GitCommit:     191ddd0b0b49af1adb04a98e45cebdd36cae9307
GitTreeState:  clean
BuildDate:     YYYY-MM-DDTHH:mm:ssZ
GoVersion:     go1.16.3
Compiler:      gc
Platform:      linux/amd64
```

## Release Jobs History

<!-- The following table can be automatically generated using krel --history  -->
| Step | Command | Link | Start | Duration | Succeeded? |
| --- | --- | --- | --- | --- | --- |
| Mock stage | `krel stage [arguments]` | | | | |
| Mock release | `krel release [arguments]` | | | | |
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

Follow up with Branch Managers/Patch Release Team/Release Engineering
subproject owners to get these questions answered.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

/milestone <!-- v1.x e.g. v1.14 -->
/assign <!-- @ the Release Manager responsible for this release -->
/cc @kubernetes/release-managers
/priority important-soon
/kind documentation
