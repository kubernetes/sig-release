### Release Notes Tool initial Draft

To get the sha of the first commit for the new release, you can navigate to:
`https://github.com/kubernetes/kubernetes/releases/tag/v1.<previous release number>.0-rc.1`
or [`kubernetes/kubernetes`](https://github.com/kubernetes/kubernetes) on github
and change the tag to `v1.x.0-rc.1` The latest commit in this branch occurs on the
first day of code thaw for the previous release.

On the command line, this sha can be fetched by updating your
kubernetes/kubernetes local repo and running:

```
git log --oneline master..v1.x.0-rc.1 | head -1
```

this will give you the start sha for the [release notes tool](https://github.com/kubernetes/release/tree/master/cmd/release-notes).
