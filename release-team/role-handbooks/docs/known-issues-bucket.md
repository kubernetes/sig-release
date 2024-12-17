First search in [Kubernetes
issues](https://github.com/kubernetes/kubernetes/issues) to ensure that an
issue hasn't already been created for `known issues` in the current release. Create a regular issue in
[kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/issues/new)
with a title such as:

```
<RELEASE NUMBER> Release Notes: "Known Issues"

```

And a body such as:

```
This issue is a bucket placeholder for collaborating on the "Known Issues" additions for the 1.13 Release Notes. If you know of issues or API changes that are going out in 1.13, please comment here so that we can coordinate incorporating information about these changes in the Release Notes.

/assign @<RELEASE NOTES TEAM MEMBERS>

/sig release
/milestone v<RELEASE NUMBER>
```

Note: You need to be part of `kubernetes/kubernetes-milestone-maintainers` to
use the `/milestone` label. If this does not currently apply to you, send a message to the release notes lead or release lead to set the milestone.
