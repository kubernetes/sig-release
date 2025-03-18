# CI Signal Responsibility Summary

The scope of CI Signal team is to monitor the results from our CI and raise any issues we find. 

Detailed information can be found in  the [CI Signal handbook](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md), but essentially the job consists of the following.

1. The team is particularly interested in the [testgrid dashboards](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#blocking-vs-informing-dashboards): [master-blocking](https://testgrid.k8s.io/sig-release-master-blocking) & [master-informing](https://testgrid.k8s.io/sig-release-master-informing).
2. Create issues on GitHub: [Create GitHub issues](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#opening-issues) reporting [*failing*](https://github.com/kubernetes/kubernetes/issues/new?assignees=&labels=kind%2Ffailing-test&template=failing-test.yaml) or [*flaky*](https://github.com/kubernetes/kubernetes/issues/new?assignees=&labels=kind%2Fflake&template=flaking-test.yaml) tests.
3. Track GitHub issues: Follow up on github issues, talk to [other sigs](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#working-with-sigs-outside-sig-release), ping and cc people. You may add the [milestone](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#working-with-sigs-outside-sig-release) or a [priority lables](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#priority-labels) to the github issue.
4. Report status: [Report](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#reporting-status) in Slack and in release-team meetings about the current ci signal status. We use an excel sheet to coordinate. 
5. Help cutting the release: The release branch manager cuts the release. We give a [go or no go signal](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#release-cutting---go-or-no-go). We use an excel sheet to coordinate.

Always update the [CI Signal project board](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#release-cutting---go-or-no-go) along the way! 


## Videos

**Onboarding**

- 2022 [CI Signal Onboarding Clips](https://www.youtube.com/playlist?list=PL69nYSiGNLP2Lzsjir9W7S8u0UsQeeW71)
- 2021 [CI Signal Onboarding](https://youtu.be/bttEcArAjUw)

**Flaky tests**

Rob Kielty and Dan Mangum kick off Flake Finder Fridays, a new Kubernetes community livestream where we explore building, testing, CI and all other aspects of delivering Kubernetes artifacts to end users in a consistent and reliable manner
- 2021 [Flake finders 0](https://youtu.be/Hqlm2h2AEvA)
- 2021 [Flake finders 1](https://youtu.be/9muoWaXZK8I)

Jordan Liggitt walks through finding and fixing test flakes
- 2020-08-25 [Deflaking Kubernetes](https://www.youtube.com/watch?v=Ewp8LNY_qTg)