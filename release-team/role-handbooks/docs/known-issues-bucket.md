# Known issues umbrella issue

The Docs team creates one umbrella issue per release to collect the entries
for the "Known Issues" section of the release notes.

First search the [Kubernetes issues](https://github.com/kubernetes/kubernetes/issues)
to make sure that a known issues umbrella issue hasn't already been created
for the current release. Then create a regular issue in
[kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/issues/new)
with a title such as:

```
v1.XX Release Notes: "Known Issues"
```

And a body such as:

```
This issue is a bucket placeholder for collaborating on the "Known Issues" additions for the v1.XX release notes. If you know of issues or API changes that are going out in v1.XX, please comment here so that we can coordinate incorporating information about these changes in the release notes.

/assign @<Docs team members>

/sig release
/milestone v1.XX
```

Note: you need to be a member of `kubernetes/kubernetes-milestone-maintainers`
to use the `/milestone` command. If you are not, ask the Docs Lead or the
Release Team Lead to set the milestone.
