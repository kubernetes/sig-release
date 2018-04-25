# Kubernetes.io Docs Release Playbook

author(s): @chenopis, @steveperry-53
revisions: @bradamant3, @zacharysarah

This doc shows how to release documentation during a Kubernetes minor version (for example, v1.10) release.

## Introduction

Kubernetes releases minor versions on a quarterly cadence. For example, in 2017, the releases were: v1.6 (Q1/Jan-Mar), v1.7 (Q2/Apr-Jun), v1.8 (Q3/Jul-Sep), and v1.9 (Q4/Oct-Dec).

SIG Docs is part of the Kubernetes release process: its [maintainers](https://github.com/orgs/kubernetes/teams/sig-docs-maintainers) support documentation created/updated for releases and published on the [kubernetes website](https://kubernetes.io/).

The designated "release meister" (aka Docs Lead), voluntold from [@kubernetes/sig-docs-maintainers](https://github.com/orgs/kubernetes/teams/sig-docs-maintainers), is responsible for managing the docs release  for new and updated documentation [kubernetes.io](https://kubernetes.io/) during quarterly releases.

### Relevant links

*   k8s.io website - [https://kubernetes.io/](https://kubernetes.io/)
*   k8s.io (docs) GitHub repo - [kubernetes/website](https://github.com/kubernetes/website)
*   k8s.io [pull request (PR) queue](https://github.com/kubernetes/website/pulls)
*   Netlify dashboard - [https://app.netlify.com/](https://app.netlify.com/)
*   Kubernetes [#sig-release channel](https://kubernetes.slack.com/messages/C2C40FMNF/) on Slack

## Start the release cycle

Release cycles usually begin 1-2 weeks after the previous cycle completes.

### General starting tasks

1. Get connected.

- Join the Kubernetes [#sig-release Slack channel](https://kubernetes.slack.com/messages/C2C40FMNF/).

    Introduce yourself as the docs lead for the release.

- Connect with the release manager.

- Join these Google groups:

    - [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
    - [kubernetes-sig-leads](https://groups.google.com/forum/#!forum/kubernetes-sig-leads)
    - [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev)

- Make sure you're included in the release team docs, for example: [release 1.11](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.11/release_team.md).

- Review (and correct if necessary) the proposed timeline for the release, for example: [release 1.11](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.11/release-1.11.md).

    Make sure the timeline includes dates for:
    - Placeholder PRs open (~3.5 weeks before release)
    - PRs ready for review: (~2.5 weeks before release)
    - Reviews complete, PRs ready to merge: First business day of the week prior to release (~9-10 days before release)

- Watch for the release feature tracking spreadsheet.

    Early in the cycle, the release manager opens a feature tracking spreadsheet (for example, [the 1.8 release spreadsheet](https://docs.google.com/spreadsheets/d/1AFksRDgAt6BGA3OjRNIiO3IyKmA-GU7CXaxbihy48ns/edit#gid=0)). The spreadsheet contains important information for docs:

    - Which features need user-facing docs
    - Feature owners (and their GitHub IDs)
    - The SIG associated with each feature (useful for obtaining technical reviews)
    - Links to docs PRs opened for each feature

### Docs starting tasks

1. Create a pull request for the release.

- Open a pull request against `master` with a new branch that follows the naming convention `release-X.Y`.

    For example, the [Release 1.11](https://github.com/kubernetes/website/pull/8046) PR uses the branch `release-1.11`.

    This release pull request (also known as a _megabranch_) serves as the base for individual, component feature PRs of the release. A megabranch lets you bundle and merge multiple PRs simultaneously.

    Use previous release PRs as a template. For example: https://github.com/kubernetes/website/pull/8046

- Add the label `do-not-merge/hold` to the PR.

2. Add a tracking comment to the megabranch PR.

Use this placeholder text:

```
## Release X.Y megabranch

PR | Based on `release-X.Y`? | Tech LGTM | Docs approved | Merged
---|---|---|---|---
| | | |
```

    A tracking comment helps track the identity and status of component PRs in the megabranch.

    For example: https://github.com/kubernetes/website/pull/8046#issuecomment-380226165

2. Update the Netlify _vnext staging_ site to use the new branch:

- Login to [Netlify](https://app.netlify.com/) and navigate to the Sites tab.

- Open the settings for the [kubernetes-io-vnext-staging](https://app.netlify.com/sites/kubernetes-io-vnext-staging/settings) site.

- Edit the Deploy settings and change "Branch" to the new version branch, for example: `release-1.11`.

- Save the change and verify that the change is live at [https://kubernetes-io-vnext-staging.netlify.com/](https://kubernetes-io-vnext-staging.netlify.com/).

- Update the [pull request template](https://github.com/kubernetes/kubernetes.github.io/blob/master/.github/PULL_REQUEST_TEMPLATE.md) with the version in development. For example: https://github.com/kubernetes/website/pull/8057

## Continue the release cycle

### Track PRs

- Follow the feature spreadsheet.

    Keep the feature tracking spreadsheet up to date with review progress and merge status for each documentation PR. For example: [Kubernetes Features OSS tracking board (1.11 release)](https://docs.google.com/spreadsheets/d/16N9KSlxWwxUA2gV6jvuW9N8tPRHzNhu1-RYY4Y0RZLs/edit#gid=0)

- Update documentation PR progress in the megabranch PR's tracking comment. For example, [Release 1.11 (tracking comment)](https://github.com/kubernetes/website/pull/8046#issuecomment-380226165)

- Make sure that docs PRs for the release have the correct base and set the correct Milestone. For example, feature PRs for version 1.11 need a base branch of `release-1.11` and the Milestone set to `1.11`.

### Maintain the current and upcoming release branches

- Periodically merge `master` into the current release branch.

For example, during the v1.11 release cycle, you must periodically merge `master` into `release-1.10`.

Periodic merges must continue throughout the release cycle, until the pending release (for example, `release-1.11`) merges to `master`. This is to ensure that the current release branch remains up to date, and to preserve the current branch as a snapshot when the new version is released. Periodic maintenance also helps avoid excessive merge conflicts between `master` and the current branch at the end of the release cycle.

On your local fork:
```
$ git fetch upstream
$ git checkout release-<current>
$ git merge upstream/master
$ git push -f upstream release-<current>
```

- Periodically rebase the upcoming release branch onto `master`.

For example, during the v1.11 release, you must periodically rebase `release-1.11` onto `master` in order to pick up any changes in `master` during the release process.

On your local fork:
```
$ git fetch upstream
$ checkout release-<upcoming>
$ git rebase upstream/master
$ git push -f upstream release-<upcoming>
```

### Stay connected with the release cycle

- Attend #sig-release meetings.

    Meetings increase in frequency over the course of the release, moving from weekly to daily.

### Work with feature developers and reviewers

- Keep developers apprised of due dates for docs.

    Send announcements to:
        - [gke-kubernetes-team@google.com](mailto:gke-kubernetes-team@google.com)
        - [kubernetes-sig-release@google.com](mailto:kubernetes-sig-release@google.com)
        - [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF/) on Slack
        - [kubernetes-sig-leads@google.com](mailto:kubernetes-sig-leads@google.com)
        - Feature owners listed in the OSS feature tracking spreadsheet

- As developers open PRs, give them `sig/*` labels (listed in the feature tracking spreadsheet) to help find technical reviewers.

### Review PRs

- Remind tech reviewers to comment with `/lgtm` when PRs pass review.

- Ask SIG Docs (#sig-docs channel on Slack) for help with reviews.

- Review PR commit histories.

    Make sure that PR commit histories contain only changes to files. It's especially important to avoid revert commits.

    Encourage developers to rebase any PRs with complicated commit histories.

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

## Finalize for release

### Update site variables

1. Update the site versions.

- Open a PR to modify site versions in `/config.toml`.

    Site versions include the current version plus the four previous versions ("current+4"). For example, supported versions in v1.11 are: v1.11-v1.7.

- Open a PR to update `/update-imported-docs/*`.

### Generate reference docs

- Regenerate [reference docs](https://kubernetes.io/editdocs/) ("Updating Automatically Generated Reference Pages") and open PRs.

- Update the reference page for [feature gates](https://github.com/kubernetes/website/blob/master/content/en/docs/reference/feature-gates.md).


    *   Update [/update-imported-docs.sh](https://github.com/kubernetes/website/blob/master/update-imported-docs.sh), e.g. [PR #4210](https://github.com/kubernetes/website/pull/4210/files#diff-8696ecc75d1b25a0b2812f88aefea8c3).
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

*   _Squash and merge_ the release PR, e.g. [PR #4094](https://github.com/kubernetes/website/pull/4094).
*   Move any hanging (un-merged) PRs back to the `master` branch.
*   Remove the reminder in the [pull request template](https://github.com/kubernetes/website/blob/master/.github/PULL_REQUEST_TEMPLATE.md) for release PRs.
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
