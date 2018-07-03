# SIG Release

## Mission
- Production of high quality Kubernetes releases on a reliable schedule
- Ensure there is a [consistent group of community members][1.6-retro] in place to support the release process
- Provide guidance and tooling to facilitate the production of automated releases
- Serve as a tightly integrated partner with other SIGs to empower SIGs to integrate their repositories into the release process

## Join us!
- [Google group](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
- [Slack channel](https://kubernetes.slack.com/messages/C2C40FMNF/)
- [Events and meetings calendar](https://calendar.google.com/calendar/embed?src=coreos.com_regcvcrgvq98lua2ikijg1g1uk%40group.calendar.google.com&ctz=America/Los_Angeles)
- [Meeting agenda and notes](https://docs.google.com/document/d/1Q6Ux-vsiRuiXhXSkVqGr9FUZifqVGRdCWkzVI1UT4l0/edit?usp=sharing) ([read-only archive](https://docs.google.com/a/google.com/document/d/e/2PACX-1vRsGZTlmggTI5T4ysYGlaJiaW3vgnrc_dlv-B1nnt69gU2Xt6vzRpZDMm-7driIj14T1DraicGzkAHr/pub))

## Broad responsibilities
- Ensuring high quality Kubernetes releases
  - Define and staff release roles to manage the resolution of release blocking criteria
  - Define and drive development processes (e.g. merge queues, cherrypicks) and release processes 
    (e.g. burndown meetings, cutting beta releases) with the intent of meeting the release schedule
  - Manage the creation of release specific artifacts including
    - Code branches
    - Binary distributions
    - Release notes
- Continually improving release and development processes
  - Work closely with SIG Contributor Experience to define and build tools to facilitate release process (e.g. dashboards)
  - Work with downstream communities responsible for packaging Kubernetes releases
  - Work with other SIGs to agree upon the responsibilities of their SIG with respect to the release
  - Define and collect metrics related to the release in order to measure progress over each release
- Collaboration with downstream communities which build artifacts from Kubernetes releases
  - Ensure the appropriate level of integration with publishing the OSS build artifacts

## Specific responsibilities
- Support SIG PM by providing tooling and processes for the generation of release notes
- Coordinate with SIG PM to communicate feature burndown progress during a release cycle
- Manage repositories and tooling dedicated to releasing Kubernetes which at time of chartering these include     
  - kubernetes/release
  - deb/rpm packaging and hosting
  - Container image hosting
- Set and enforce criteria for repository inclusion in a Kubernetes release
  - Governance
  - Stabilization
  - Test coverage
- Set and enforce criteria for code inclusion in a Kubernetes release
  - Feature flags
  - Documentation
  - Test coverage
  - Dashboards
  - Status reports
- Define template and format for communication of release status
  - Ongoing status of the release process
  - Announcement of alpha, beta, release candidate availability
  - Announcement of release availability
- Deriving signal from the following sources
  - [test grid](https://k8s-testgrid.appspot.com/)
  - GitHub [flake issues](https://github.com/kubernetes/kubernetes/issues?q=is%3Aopen+is%3Aissue+label%3Akind%2Fflake)
  - GitHub [bug issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aopen%20is%3Aissue%20label%3Akind%2Fbug)
- Identifying owning individuals and SIGs for blocking issues
- Working with SIGs and individuals to drive resolution of open issues
- Building summary of release criteria and status and publish to the community on a regular basis throughout the release cycle
- Manage the contents of `kubernetes/features` along with SIG PM
- Define burndown process
  - use of GitHub labels to signal release blocking status
  - use of GitHub milestones to communicate release blocking issues
  - use of flake GitHub issue count or CI signal as a release blocking status
- Coordinate the resolution of release blocking issues

[1.6-retro]: https://docs.google.com/a/google.com/document/d/1JAUqKl-lYdYLQ7GUT_9LzqxwQv-PcOdyAxNRZKItajo/edit?usp=sharing
