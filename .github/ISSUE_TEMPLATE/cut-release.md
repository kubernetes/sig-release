---
name: Cut a release
about: Create a tracking issue for a release cut
title: Cut 1.x.y-{alpha,beta,rc}.z release
labels: sig/release, area/release-eng
---
## Scheduled to happen: <!-- Tue, 2019-02-26 -->

<!-- 
- Add/Remove items of the checklist as you see fit 
- Post bumps or issues encountered along the way
-->

- [ ] Screenshot unhealthy release branch testgrid boards and add them as a comment
<!--
Screenshot `master` branch for releases <= `x.y.z-beta.0` OR the `release-x.y` branch for releases > x.y.z-beta.0.
see template below, example: https://github.com/kubernetes/sig-release/issues/842#issuecomment-547453821
-->
- [ ] Stage & release
  - [ ] Notify [#release-management](https://kubernetes.slack.com/messages/CJH2GBF7Y): [see notification](https://link-to-slack-message)
  <!-- e.g. https://kubernetes.slack.com/archives/CJH2GBF7Y/p1572365803088800 -->
  - [ ] Collect metrics and add them to the `Release steps` table below
<!-- ONLY FOR OFFICIAL RELEASES - [ ] Build & publish packages (debs & rpms) -->
- [ ] Send notification [email](https://link-to-email-on-kubernetes-announce-google-group)

## Release steps

| Step | Command | Link | Start | Duration | Succeeded? |
| --- | --- | --- | --- | --- | --- |
| Mock stage | `./gcbmgr stage [arguments]` | <!-- link-to-MOCK-gcb-stage-run --> |  |  |  |
| Mock release | `./gcbmgr release [arguments]` | <!-- link-to-MOCK-gcb-release-run --> |  |  |  |
| Stage | `./gcbmgr stage [arguments]` | <!-- link-to-REAL-gcb-stage-run --> |  |  |  |
| Release | `./gcbmgr release [arguments]` | <!-- link-to-REAL-gcb-release-run --> |  |  |  |
| Cut packages <!-- not required for pre-releases (alpha, beta, rc) --> | -- | -- |  |  |  |
| Notify | -- | <!-- link-to-kubernetes-announce-list-thread --> |  | -- |  |

## Action items

<!--
During the release, you may find a few things that require updates
(process changes, documentation updates, fixes to release tooling).

Please list them here.

It will be your responsibility to open issues/PRs to resolve these issues/improvements.
Keep this issue open until these action items are complete.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

## Open questions

<!--
During the release, you may have a few questions that you can't answer yourself or may
require group discussion.

Please list them here.

Follow up with Branch Managers/Patch Release Team/Release Engineering subproject owners
to get these questions answered.

- [ ] Item 1
- [ ] Item 2
- [ ] Item 3
-->

/milestone <!-- v1.x e.g. v1.14 -->
/assign <!-- @ the Release Manager responsible for this release -->
<!-- cc: shadows (optional)-->

<!-- Example template for screenshots comment:

----[ template ]----
### Failing testgrid jobs

#### sig-release-master-blocking

<details><summary>`gce-cos-master-default`</summary></p>

... paste image here ...
</p></details>

#### sig-release-master-informing

<details><summary>`gce-new-master-upgrade-master`</summary><p>

... paste image here ...
... paste multiple images here ...
</p></details>

[screenshot capture tool](https://git.k8s.io/release/testgridshot)
----[ template ]----

-->
