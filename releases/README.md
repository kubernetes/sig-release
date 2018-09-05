## Releases

These are the release subprojects for each Kubernetes release managed by SIG
Release. These subprojects allow a Release Team to store important information
related to a relase and allow the Release Team to take full advanage of the
automation such as the OWNERS process


## Looking at archived release information

We try to only keep information for six Kubernetes releases. For older
releases one can use

```
git log --follow -- release-x.y/
```

to see changes to any release subproject which had been checked into source
control. To look at the content of an arbitrary file in an older release one
can use

```
git show <SHA>:<File>
```

where `<SHA>` is actually [treeish][] but likely a SHA in this case

[treeish]: http://gitready.com/intermediate/2009/02/27/get-a-file-from-a-specific-revision.html
