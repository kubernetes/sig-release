# Taking over a Doc PR

Sometimes, exceptions to Doc Freeze arise when a feature and its documentation are almost ready for release, but the original author cannot complete the documentation due to extenuating circumstances. In rare cases where SIG Docs, SIG Release, and the relevant technical SIG all agree, a lead or shadow from the Release Docs team may be asked to finish the documentation. This document outlines the process.

## Contributing to the Original PR

Ideally, the Doc lead should be able to contribute new commits to the same PR that another SIG originally opened. [Here's the detailed process](https://kubernetes.io/docs/contribute/review/for-approvers/#commit-into-another-person-s-pr). This can be done through editing in the GitHub UI.

It's also common for the author's source branch to be from their personal fork of the Kubernetes website. As an alternative, Release Docs may need to push commits to the branch of the author's fork.

## Creating a New PR

If it's determined that Release Doc members cannot make commits on the original PR, they may need to create a new one. To do so, a fork of the author's fork needs to be created so that their source branch can continue to be iterated on. Here are the Git commands to accomplish this:

```bash
# Step 0 - Clone the kubernetes website repo, only if you haven't before:
git clone https://github.com/yourGitHubUsername/website.git kubernetes-website
cd kubernetes-website
git remote add upstream https://github.com/kubernetes/website.git && git remote set-url --push upstream no_push

# Step 1 - Add the original author's fork
git remote add docAuthor git@github.com:docAuthor/website.git && git remote set-url --push docAuthor no_push

# Step 2 - Confirm that you have `docAuthor` as a remote
git remote -v

# Step 3 - Fetch the state of all branches from their remote repo
git fetch docAuthor

# Step 4 - Checkout the doc PR's source branch
git checkout kep_xxxx_authors_pr_branch_name

# Step 5 - Checkout a new branch based on this one
git checkout -b kep_xxx_authors_branch_name_releasedocs

# Step 6 - Push your new branch to your fork
git push --set-upstream origin/kep_xxxx_authors_pr_branch_name_releasedocs

# Step 7 - Make all the changes you'd like in the editor of your choice

# Step 8 - Add, commit, and push your changes
git add path/to/changed/files
git commit -m "Helpful commit message for changes"
git push

# Step 9 - On GitHub, open a new PR from your fork and branch to the Kubernetes fork and `dev-[future release]`
```
Once a new PR is open, proceed with the normal review process, collaborating with SIG Docs and the relevant technical SIG to ensure the changes are approved.

