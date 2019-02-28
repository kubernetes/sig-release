---
name: Cut a release
about: Create a tracking issue for a release cut
title: Cut 1.x.y-{alpha,beta,rc}.z release
---
/assign <!-- @ the release branch manager or the person who cuts the release -->

Scheduled to happen <!-- Tue, 2019-02-26 -->

Any bumps or issues encountered along the way, post here. /close when the release has been cut.

<!-- add & remove items of the checklist as you see fit -->
- [ ] screen shot master's (unhealthy) testgrid boards and add them as a comment
- [ ] stage & release
  - [ ] collect metrics, links, ... and add them as a comment <!-- example: https://github.com/kubernetes/sig-release/issues/506#issuecomment-465202113 -->
- [ ] build & publish packages (debs & rpms)
- [ ] send notification mail

/milestone <!-- v1.14 -->
/sig release
/area release-team
