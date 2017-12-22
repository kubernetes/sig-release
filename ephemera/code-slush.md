The Kubernetes project enters and exits a code slush once per milestone (minor version).  A typical milestone will have a long, open period where any new code or features can be added, a slush period where we will seek to minimize code churn, and a branch and release period for the new version.

The code slush period comes after all major changes (features, refactors) are merged for a milestone.  During this period, new features or large refactors might be turned away.  It is important to reduce the code churn as we stabilize for a release, and keeping large changes out is helpful.  

This period isn’t a freeze - but it is expected that there only be bug fixes and stabilizing changes.

Once the number of issues has settled down, the code will be branched into the minor version release branch.  At that point, head will be open again for larger changes and refactors, and the branch will still get a minimal set of last fixes needed before release.

It is a goal to minimize this code slush time period (which maximizes the time the project can accept features).  The trade-off is against branching too early for a minor version release, and having to ensure many PRs are ported to both head and the release branch.