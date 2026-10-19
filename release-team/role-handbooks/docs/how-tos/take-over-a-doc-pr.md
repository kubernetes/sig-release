# Taking over a docs PR

Sometimes, exceptions to Docs Freeze arise when a feature and its
documentation are almost ready for release, but the original author cannot
complete the documentation due to extenuating circumstances. In rare cases
where SIG Docs, SIG Release and the relevant technical SIG all agree, a lead
or shadow from the Docs team may be asked to finish the documentation. This
document outlines the process.

## Contributing to the original PR

Ideally, the Docs team member contributes new commits to the PR that the
other SIG originally opened. The
[detailed process](https://kubernetes.io/docs/contribute/review/for-approvers/#commit-into-another-person-s-pr)
can be done through the GitHub UI.

The author's source branch usually lives in their personal fork of the
Kubernetes website. As an alternative, the Docs team member may push commits
to that branch of the author's fork, if the author allows edits from
maintainers.

## Creating a new PR

If the Docs team cannot commit to the original PR, create a new one. Add the
author's fork as a remote, so that their source branch can be continued in
your fork:

```bash
# Step 0: clone your fork of the Kubernetes website, if you haven't before
git clone https://github.com/<your GitHub username>/website.git kubernetes-website
cd kubernetes-website
git remote add upstream https://github.com/kubernetes/website.git && git remote set-url --push upstream no_push

# Step 1: add the original author's fork as a remote
git remote add docAuthor https://github.com/<author>/website.git && git remote set-url --push docAuthor no_push

# Step 2: confirm that you have docAuthor as a remote
git remote -v

# Step 3: fetch all branches of the author's fork
git fetch docAuthor

# Step 4: create a new branch based on the PR's source branch
git checkout -b <source branch>-releasedocs docAuthor/<source branch>

# Step 5: push the new branch to your fork
git push --set-upstream origin <source branch>-releasedocs

# Step 6: make the changes in the editor of your choice

# Step 7: add, commit and push your changes
git add <changed files>
git commit -s -m "<helpful commit message>"
git push

# Step 8: on GitHub, open a new PR from your fork and branch against
# the dev-<future release> branch of kubernetes/website
```

Once the new PR is open, proceed with the normal review process,
collaborating with SIG Docs and the relevant technical SIG to get the changes
approved. Link the original PR from the new one and close the original PR
once the new one has merged.
