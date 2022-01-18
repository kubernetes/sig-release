# 20XX-XX-XX - Kubernetes Release X.XX CI Signal Shadow Onboarding

Meet the Team

| Name  | Slack | GitHub | K8s since | Timezone |
| ---   | ---   | ---    | ---       |  ---     |
| ...   | ...   | ...    | ...       | ...      |

Timezones and possible meeting slots

| Possible meeting slot  | Timezone A | Timezone B | Timezone C |
| ------------- | ------------- |------------- |------------- |
| < ✅, ⚠️, ❌ >  | 6 am  | 9 pm  | 2 pm  |


## Responsibilities

The scope of CI Signal team is to monitor the results from our CI and raise any issues we find. 

Job comes down to:


1. Monitor testgrid: Particularly interested the [testgrid dashboards](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#blocking-vs-informing-dashboards): [master-blocking](https://testgrid.k8s.io/sig-release-master-blocking) & [master-informing](https://testgrid.k8s.io/sig-release-master-informing).
2. Create issues on GitHub: [Create GitHub issues](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#opening-issues) reporting [*failing*](https://github.com/kubernetes/kubernetes/issues/new?assignees=&labels=kind%2Ffailing-test&template=failing-test.yaml) or [*flaky*](https://github.com/kubernetes/kubernetes/issues/new?assignees=&labels=kind%2Fflake&template=flaking-test.yaml) tests.
3. Track GitHub issues: Follow up on github issues, talk to [other sigs](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#working-with-sigs-outside-sig-release), ping and cc people.
    1. You may add the [*milestone*](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#milestones) or a [*priority lables*](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#priority-labels) to the github issue.
4. Report status: [Report](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#reporting-status) in Slack and in release-team meetings about the current ci signal status.
    1. We use an [excel sheet]() to coordinate. 
5. Help cutting the release: The release branch manager cuts the release. We give a [go or no go signal](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md#release-cutting---go-or-no-go). 
    1. We use an [excel sheet]() to coordinate.

Always update the [CI Signal project board](https://github.com/orgs/kubernetes/projects/68/) along the way! 

Detailed information can be found in  the [CI Signal handbook](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/ci-signal/README.md).

## Tasks I would like to tackle throughout the release X.XX

♻️ on-going, 🆕 not yet started
* [ ] < ♻️, 🆕 >, < description >, < assignee, unassigned >, < [see link]() >
* [ ] 🆕 *Your Input here* 🙂 — just write to `#sig-release` or `#release-ci-signal` on Slack 🙏


## Useful Links
- **CI Sigal**: [Project board](https://github.com/orgs/kubernetes/projects/68), [Handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/ci-signal)
- **Testgrid**: [Overview](https://testgrid.k8s.io/), [Master blocking](https://testgrid.k8s.io/sig-release-master-blocking), [Master Informing](https://testgrid.k8s.io/sig-release-master-informing)
- **Release Team**: [Calendar](https://calendar.google.com/calendar/u/0/embed?src=agst.us_b07popf7t4avmt4km7eq5tk5ao@group.calendar.google.com), [Meeting notes](https://docs.google.com/document/d/XXXXX), [Timeline](https://github.com/kubernetes/sig-release/tree/master/releases/release-X.XX#timeline)
- **Prow**: [Generic link](https://prow.k8s.io/), [Bot commands](https://prow.k8s.io/command-help)
- **Triage**: [Board link](https://storage.googleapis.com/k8s-gubernator/triage/index.html?ci=0&pr=1&job=pull-kubernetes-e2e-gce)


## Appendix

### GitHub Issue Template

Generally, you create issues by going to the [New Issue page](https://github.com/kubernetes/kubernetes/issues/new/choose) and selecting the type of issue you want to open. For example, there is a template to report failed and failing tests. Since we use the [GitHub Project Board](https://github.com/orgs/kubernetes/projects/68/) to track work, we often don't create the issue on GitHub right away. If that is the case and you need to turn a note on the project board into an issue, you can use the following template.

```
### Which jobs are failing?

...    

### Which tests are failing?

...

### Since when has it been failing?

...

### Testgrid link

[testgrif link](https://testgrid.k8s.io/sig-release-XXX-XXX#XXX)

### Reason for failure (if possible)

...

### Anything else we need to know?

...

### Relevant SIG(s)

/sig <node ...>
/kind <failing-test or flake>
cc @kubernetes/ci-signal
```