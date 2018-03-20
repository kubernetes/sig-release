# Kubernetes.io Docs Release Playbook

author(s): [chenopis@](mailto:chenopis@google.com), stevepe@


## TL;DR

This doc contains an outline of tasks to be completed during a Kubernetes.io docs release cycle for a Kubernetes minor release, e.g. v1.9.

## Quarterly release cycle

The Kubernetes release cycle is on a quarterly cadence. For example, in 2017, the releases are: v1.6 Jan-Mar, v1.7 Apr-Jun, v1.8 Jul-Sep, and v1.9 Oct-Dec. Consequently, [kubernetes.io](https://kubernetes.io/) and its [docs maintainers](https://github.com/orgs/kubernetes/teams/sig-docs-maintainers) are part of that process to support documentation created/updated for those releases.

## Managing the cycle

The designated "release meister" (aka Docs Lead), voluntold from [@kubernetes/sig-docs-maintainers](https://github.com/orgs/kubernetes/teams/sig-docs-maintainers), is responsible for managing the process on the docs side and releasing the documentation on [kubernetes.io](https://kubernetes.io/) when the Kubernetes binary release goes out.

### Relevant links

*   k8s.io website - [https://kubernetes.io/](https://kubernetes.io/)
*   k8s.io (docs) GitHub repo - [kubernetes/kubernetes.github.io](https://github.com/kubernetes/kubernetes.github.io)
*   k8s.io [pull request (PR) queue](https://github.com/kubernetes/kubernetes.github.io/pulls) 
*   OSS Kubernetes features tracking spreadsheet
    *   [Kubernetes Features OSS tracking board (1.7 release)](https://docs.google.com/spreadsheets/d/1IJSTd3MHorwUt8i492GQaKKuAFsZppauT4v1LJ91WHY/edit?usp=sharing)
    *   [Kubernetes Features OSS tracking board (1.8 release)](https://docs.google.com/spreadsheets/d/1AFksRDgAt6BGA3OjRNIiO3IyKmA-GU7CXaxbihy48ns/edit#gid=0)
    *   Not sure whether there will be a tracking spreadsheet for 1.9
*   Netlify dashboard - [https://app.netlify.com/](https://app.netlify.com/)
*   [kubernetes.slack.com #sig-release](https://kubernetes.slack.com/messages/C2C40FMNF/) Slack channel

### Start the cycle

*   Create a new GitHub branch from `master` using the naming convention `release-X.Y`, e.g. `release-1.9`. Here's the [release-1.9 branch](https://github.com/kubernetes/kubernetes.github.io/tree/release-1.9).
*   Update the Netlify _vnext staging_ site to use the new branch:
    *   Login to [Netlify](https://app.netlify.com/) and navigate to the Sites tab.
    *   Go to the settings for the [kubernetes-io-vnext-staging](https://app.netlify.com/sites/kubernetes-io-vnext-staging/settings) site.
    *   Edit the Deploy settings and change "Branch" to the new version branch, e.g `release-1.9`.
    *   Save the change and verify that it is live at [https://kubernetes-io-vnext-staging.netlify.com/](https://kubernetes-io-vnext-staging.netlify.com/).
*   Add a reminder in the [pull request template](https://github.com/kubernetes/kubernetes.github.io/blob/master/.github/PULL_REQUEST_TEMPLATE.md) for PRs going into the new release to use the release base branch and set the Milestone, e. g. [this commit](https://github.com/kubernetes/kubernetes.github.io/pull/4632).
*   Connect with the release manager -- introduce yourself, etc.
*   Join these groups: [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release), [kubernetes-sig-leads](https://groups.google.com/forum/#!forum/kubernetes-sig-leads), [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev).
*   Make sure you have been added to the release team and in the doc, e.g. [https://github.com/kubernetes/features/blob/master/release-1.7/release_team.md](https://github.com/kubernetes/features/blob/master/release-1.7/release_team.md).
*   Check the proposed timeline for the release, e.g. [https://github.com/kubernetes/features/blob/master/release-1.7/release-1.7.md](https://github.com/kubernetes/features/blob/master/release-1.7/release-1.7.md).
*   Make sure a public OSS feature tracking spreadsheet, e.g. [Kubernetes Features OSS tracking board (1.8 release)](https://docs.google.com/spreadsheets/d/1AFksRDgAt6BGA3OjRNIiO3IyKmA-GU7CXaxbihy48ns/edit#gid=0), has been created by the Features manager, currently Jaice Singer DuMars (jdumars).
*   Update [kubernetes/community/contributors/devel/release/README.md](https://github.com/kubernetes/community/blob/master/contributors/devel/release/README.md) with your contact info for the Docs role.

### Ongoing tasks

*   Look through the [PR queue](https://github.com/kubernetes/kubernetes.github.io/pulls) to make sure ones related to the new release are using the correct base branch and have the Milestone set, e.g. base branch is `release-1.8` and Milestone is `1.8`. Example PRs from the v1.7 release can be viewed [here](https://github.com/kubernetes/kubernetes.github.io/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aclosed%20milestone%3A1.7%20).
*   Merge `master` branch back into the branch for the last release. 
For example, if you are currently on the v1.8 release, you will need to periodically merge `master` into `release-1.7` right up until `release-1.8` is merged into `master`. This is to make sure that the last release branch is as up to date as possible and left as a snapshot when the new version is released.
*   Merge `master` into the branch for the next release.
For example, if you are currently on the v1.8 release, you will need to periodically merge `master` into `release-1.8` in order to pick up any changes in `master` during the release process. Therefore, `release-1.8` should effectively be `master` + commits for v1.8.
*   Update the OSS feature tracking spreadsheet with progress on reviews and merge status for each feature doc, e.g. [Kubernetes Features OSS tracking board (1.7 release)](https://docs.google.com/spreadsheets/d/1IJSTd3MHorwUt8i492GQaKKuAFsZppauT4v1LJ91WHY/edit?usp=sharing).
*   Attend Kubernetes Tactics meetings.
*   Attend Kubernetes Burndown meetings.
*   Sync with the release manager biweekly, then weekly, then daily.

### Work with the engineers and community

*   Sync with the dev managers and SIG leads so that they know to direct the engineers to you if they have any docs questions.
*   Send announcements to:
    *   [gke-kubernetes-team@google.com](mailto:gke-kubernetes-team@google.com)
    *   [kubernetes-sig-release@google.com](mailto:kubernetes-sig-release@google.com), Slack #sig-release
    *   [kubernetes-sig-leads@google.com](mailto:kubernetes-sig-leads@google.com)
    *   feature owners listed in the OSS feature tracking spreadsheet
*   Announcements should cover:
    *   TL;DR on the docs release process with your contact info.
    *   Dates for:
        *   filling in features in the OSS feature tracking spreadsheet
        *   opening a placeholder PR in the k8s.io repo
        *   when PRs should be completed and ready for review
        *   when PRs tech reviews should be completed
        *   when review feedback should be incorporated by and Docs and Tech LGTMs given
        *   the drop-dead merge date and time for any last minute PRs
*   Meet with engineers early about feature docs and give guidance on what should be a Concept, Task, Tutorial, or Reference doc.
*   Recruit community tech writers to help with docs reviews.

### Generate reference docs

*   Generate reference docs and place them in kubernetes/website. See [PR 6366](https://github.com/kubernetes/website/pull/6366).
*   Update reference page for feature gates. See [PR 6364](https://github.com/kubernetes/website/pull/6364).

### Last minute PRs

*   Triage: 
    *   Decide what must go out with release, what can be published just after the release.
    *   Determine how much effort will be required to review the doc(s).
        *   Is it a complex feature needing specific reviewers?
        *   Is it a long doc? Is it several docs?
        *   Do you have edit permissions to help speed up the turnaround? If not, request that they check the [Allow edits from maintainers](https://help.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) checkbox.
*   Get the PR author to help find tech reviewers.
*   Ping the PR author to incorporate review feedback ASAP.
*   Ask the release manager at the burndown meeting to help find appropriate tech reviewers.
*   If not critical to initial release, un-merged PRs can be dealt with after the release.

### Finalize for release

*   Create a PR for the merge but do not merge yet, e.g. [PR #4094](https://github.com/kubernetes/kubernetes.github.io/pull/4094) for v1.7 release
    *   Add tag _do-not-merge_
    *   Add note and target date in the description, e.g.
_DO NOT MERGE UNTIL KUBERNETES 1.7 IS RELEASED
Target Date: 2017-06-29 @ 13:00 PDT_
*   Update the site variables for version numbers:
    *   Open a PR to modify [/_config.yml](https://github.com/kubernetes/kubernetes.github.io/blob/master/_config.yml) and change version variables to v1.8 and v1.8.0, e.g. [PR #4210](https://github.com/kubernetes/kubernetes.github.io/pull/4210/files).
    *   Update [/update-imported-docs.sh](https://github.com/kubernetes/kubernetes.github.io/blob/master/update-imported-docs.sh), e.g. [PR #4210](https://github.com/kubernetes/kubernetes.github.io/pull/4210/files#diff-8696ecc75d1b25a0b2812f88aefea8c3).
*   Make sure the auto-generated docs have been updated.
    *   Check with Phillip Wittrock ([pwittroc@google.com](mailto:pwittroc@google.com)).
    *   Run update-imported-docs.sh.
*   Make sure the tutorials are imported from kubernetes/examples repo.
    *   Run ./update-imported-tutorials.py
*   Merge `master` back into the branch for the last release to create final snapshot of the last release, e.g. finalize `release-1.7` branch before `release-1.8` is merged into `master`.
*   Add tags to `master`, last release, and next release branches to keep track of snapshot points, e.g. `snapshot-final-v1.6`, `snapshot-initial-v1.7`, etc.
*   Update links for release announcement given by Kubernetes PM, currently Aparna Sinha ([apsinha@google.com](mailto:apsinha@google.com)), e.g. [Kubernetes.io Blog: 1.7 Release announcement](https://docs.google.com/a/google.com/document/d/1U8oNYK-baoF-ObIRFKEmCicDnrgFdXAz7Nfkatg_jUo/edit?usp=sharing).
*   Work with release manager to update links in release notes to k8s.io docs, e.g. [Google Doc](https://docs.google.com/a/google.com/document/d/1dWFkFJIHo3liTWomvB1ur6jqd6cnxvGb_jjE-3-c6Bo/edit?usp=sharing) that fed into [kubernetes/features: /release-1.7/release-notes-draft.md](https://github.com/kubernetes/features/blob/master/release-1.7/release-notes-draft.md).

### Release and cleanup

*   _Squash and merge_ the release PR, e.g. [PR #4094](https://github.com/kubernetes/kubernetes.github.io/pull/4094).
*   Move any hanging (un-merged) PRs back to the `master` branch.
*   Remove the reminder in the [pull request template](https://github.com/kubernetes/kubernetes.github.io/blob/master/.github/PULL_REQUEST_TEMPLATE.md) for release PRs.
*   Merge `master` back into the current release branch to keep them in sync.

## Appendix I: Setup and tools

You will need to use [Git source control management](https://git-scm.com/) with the [GitHub](https://github.com/) site. 

Make sure you have a GitHub account and are properly setup with the following:

*   Register your GitHub account with Google at [https://github.corp.google.com/](https://github.corp.google.com/)
*   Sign up at the CNCF (Linux Foundation) as an employee of Google at [https://identity.linuxfoundation.org/projects/cncf](https://identity.linuxfoundation.org/projects/cncf), login with your Google account.
*   Set your [primary email in GitHub](https://github.com/settings/emails) to match your Google email address used in the CNCF step.
*   Make sure your email address in Git (either command line or client) is also set to your Google email address.
*   Request to be added to the following GitHub organizations/teams:
    *   Google - [https://github.com/google](https://github.com/google)
    *   Google Cloud Platform - [https://github.com/GoogleCloudPlatform](https://github.com/GoogleCloudPlatform)
    *   Kubernetes - [https://github.com/kubernetes](https://github.com/kubernetes)
    *   [kubernetes.github.io-maintainers](https://github.com/orgs/kubernetes/teams/kubernetes-github-io-maintainers) team as an admin
    *   [sig-docs-maintainers](https://github.com/orgs/kubernetes/teams/sig-docs-maintainers) team as a member

Use one of the tools below:

1.  Git command line (free): [https://git-scm.com/downloads](https://git-scm.com/downloads)
1.  Atlassian SourceTree Git client (free): [https://www.sourcetreeapp.com/](https://www.sourcetreeapp.com/)

    *   Source URL: [https://github.com/kubernetes/kubernetes.github.io.git](https://github.com/kubernetes/kubernetes.github.io.git)
    *   Under _REMOTES_, use _origin_ (the one that points at the k8s.io repo) and check out the branches:
        *   `master` branch
        *   current release branch, e.g. `release-1.8`
        *   previous release branch, e.g. `release-1.7`

## Appendix II: Merging master into a branch

When merging master into a release branch, e.g. `release-1.8`:

1.  Make sure you are on the checked out `release-1.8` branch.
1.  Do a _Pull_ from the k8s.io repo but set the _Remote branch to pull_ to `master`.
1.  Resolve any conflicts.
1.  Push the commits back up to the k8s.io repo to the `release-1.8` remote branch.

## Appendix III: Resolving conflicts during a merge

If using a Git client such as SourceTree, here is a good guide for dealing with merge conflicts: [https://githubtraining.com/fix-merge-conflict-git-using-sourcetree/](https://githubtraining.com/fix-merge-conflict-git-using-sourcetree/)

When you are on a release branch, e.g. `release-1.8`, and are merging `master` into it, the options to resolve a conflict are:

*   Resolve using 'mine' - this means to take all the changes from the `release-1.8` branch to resolve the conflict.
*   Resolve using 'theirs' - this means to take all the changes from the `master` branch to resolve the conflict.
*   Resolve using an external merge tool - there are visual merge tools, like FileMerge on the Mac, that can help you see the differences between file versions and will allow you to select each one you want to keep. I recommend this for more complicated conflicts.
*   Resolve manually - you can open the conflicted file with a text editor and manually edit the conflicts. Perform a text search for '>>>>>>', '<<<<<<' and '======'. This will help you navigate to conflicted parts of the file quickly.

**Note:** Keep in mind that sometimes changes to the documentation involve the removal of content, so if a file or paragraph was removed on purpose, make sure it is not there after a conflict has been resolved.
