# SIG-Docs Release Meister Process 
**Authors:** Jim Angel, Jared Bhatti, Misty Linville, Zach Arnold

[Early steps](#Early-steps)  
[Mid steps](#Mid-steps)  
[Late steps](#Late-steps)  
[Doing the release](#Doing-the-release)  
[Post release](#Post-release)  
[Appendix II: Merging master into a branch](#Appendix-II:-Merging-master-into-a-branch)  
[Appendix I: Setup and tools](#Appendix-I:-Setup-and-tools)  

## Doc Goals, Placement & Existing Resources

The goal of this doc is to outline the Sig-Docs release lead process for future Kubernetes SIG-Docs releases. The audience for this doc is K8s Release Leads, Sig-Docs release leads, and Sig-Docs release shadows.

This doc builds on existing documentation:  
[Misty’s 1.12 release process](https://gist.github.com/mistyhacks/daa4f9285085208127e3fa14c42b81b8)  
[Existing sig-release sig-docs' docs](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/docs)  
[Existing sig-release handbooks]()  

### Common Terms

| Variable       | Explanation | Example |
| -------------- | -------- | -------- |
| [current release]| Active Kubernetes release     | 1.13     |
| [future release] | Release that the team is actively composing     | 1.14     |
| [integration branch] | A PR [WIP] merging dev / master | [link](https://github.com/kubernetes/website/pull/11401)


Release cycles usually begin 1-2 weeks after the previous cycle completes.

---

## Early Steps

1. Get connected.

- Join the Kubernetes [#sig-release Slack channel](https://kubernetes.slack.com/messages/C2C40FMNF/). Introduce yourself as the docs lead for the [future release].

- Slack DM the [future release] lead to introduce yourself (or say Hey again!).

- Join these Google groups:
    - [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
    - [kubernetes-sig-leads](https://groups.google.com/forum/#!forum/kubernetes-sig-leads)
    - [kubernetes-sig-docs](https://groups.google.com/forum/#!forum/kubernetes-sig-docs)
    - [kubernetes-milestone-burndown](https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown)
    - [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev)
    - [kubernetes-release-team](https://groups.google.com/forum/#!forum/kubernetes-release-team) #important for enhancement google sheets access!

- Make sure you're included in the release team docs, for example: [release 1.14](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/release_team.md).

- Review (and correct if necessary) the proposed timeline for the release, for example: [release 1.14](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/README.md).

   **Make sure the timeline includes dates for:**
    - Docs deadline - Open placeholder PRs (~3.5 weeks before release)
    - Docs deadline - PRs ready for review: (~2 weeks before release)
    - Docs complete - All PRs reviewed and ready to merge (~1 week before release)

    Example of [what to do if there are no dates](https://github.com/kubernetes/sig-release/pull/472). **Note:** If you need to create PR, send pull URL to #sig-docs slack channel for community review.

    Early in the cycle, the release manager opens an enhancement tracking spreadsheet (for example, [the 1.14 release spreadsheet](https://docs.google.com/spreadsheets/d/1AFksRDgAt6BGA3OjRNIiO3IyKmA-GU7CXaxbihy48ns/edit#gid=0)). The spreadsheet contains important information for docs:

    - Which enhancements need user-facing docs
    - Feature owners (and their GitHub IDs)
    - The SIG associated with each enhancement (useful for obtaining technical reviews)
    - Links to docs PRs opened for each enhancement

2. Open PR with localization owners to sync up early on strategy (needs coordination for main release). Example: https://github.com/kubernetes/website/issues/12396

3. **Attend the release team meeting outlined in k/sig-release.**

4. Read this: https://github.com/kubernetes/sig-release/tree/master/release-team

5. Selecting your shadows

    In Kubernetes 1.14, we begun handling shadow selection using a questionnaire, as opposed to the first-come, first-served GitHub issue approach that we had adopted during previous release cycles (1.12, 1.13.

    Moving to a questionnaire / survey format will allow us to capture more of the information required to vet potential shadows and well as begin to generate metrics around some of the Release Team processes.

    Questionnaire creation will be facilitated by SIG Release Chairs or a delegated coordinator to ensure consistency across release cycles.

    Following submissions, the questionnaires will be reviewed by role leads of the incoming Release Team.

    Volunteers that meet the requirements of the respective role will be contacted by those leads via some convenient mechanism (Slack, video chat, etc.) to further discuss.

    After vetting the volunteers for their roles, role leads should make a final decision on selected shadows with the incoming Release Team Lead. **In the past the sig-docs release team has been between 3-6 members.**
     
    [For additional information on shadows](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-selection.md#shadows)

6. Contact all volunteers

Send a Slack message to those that you select. Example:

> Hey, you're officially on the sig-docs 1.14 release team as a shadow! Let me know if there's any issues with being a shadow (as far as timing / availability / etc) and feel free to introduce yourself!
> 
> I'll start: I'm Jim Angel, I work as a Cloud Admin for General Motors. I try to keep up with #sig-docs #sig-ui and #wg-lts. I was a sig-doc's shadow for 1.12 and 1.13.
> 
> I live in Austin, Texas (transplanting from Chicago in late 2017). I love computers and hockey.
> 
> Also, just so everyone's not left with a cliff hanger, next we will find a meeting time to go over the release process; nothing worth losing sleep over :slightly_smiling_face:

Also send a Slack message to those that you didn't select. Example:

> Hey, I'm Jim Angel (release lead for sig-docs). Thanks for your interest in the sig-docs 1.14 release team!
> 
> The release team for sig-doc shadows has no additional availability, but please stick around help out with some of our other sigs (including sig-docs)!
> 
> How can you help?
> - Attend the sig release meetings (10AM PST every Monday - see #sig-release for more info).
> - SIG-DOCs is always looking for new contributors, please go introduce yourself and we're happy to help! As a bonus, you will be preferred during the next release cycle as opposed to someone not involved with sig-docs.
> - Slack is full of other great SIGs that could always use your help!
> 
> I am also a resource to reach out to if you have any community questions (there's also #sig-contribex). I started out as a volunteer and now I am part of many Kubernetes sigs and teams.
> 
> Thanks again for your interest and time!
> 
> Jim Angel

7. Find time to meet with shadows and explain the release process. Essentially read this entire document and review the flow with them. It helps to set expectations that the release cycle is a lot of "hurry up and wait" and then gets very hectic at the end. If you have the ability to, please record the meeting and share it with your shadows for future review.

8. Add contacts to the shadows release docs. Example: [https://bit.ly/k8s114-contacts](https://docs.google.com/spreadsheets/d/1BiGSLuCqjglQS1bJvpKk6rKFMciebPkUndzgDRnJsns/edit?ts=5c3bd42a#gid=0)

9. You need push access to the k/website repo (contact the sig-docs chair if you don't have it)

10. IMPORTANT: Create a working branch (Named `dev-[future release]`, for example `dev-1.14`) locally, based on master. Push it to upstream.

- Open a pull request against `master` with a new branch that follows the naming convention `dev-X.Y`.

    For example, the [Release 1.14](https://github.com/kubernetes/website/pull/12584) PR uses the branch `dev-1.14`.

    This release pull request (also known as the [integration branch]) serves as the base for individual, component enhancement PRs of the release. A [integration branch] lets you bundle and merge multiple PRs simultaneously.

- Add the label `do-not-merge/hold` to the PR.

11. Add a tracking comment to the [integration branch] PR.

## Release 1.14 Integration Branch

PR | Based on `dev-1.14` | Tech LGTM | Docs approved | Merged
---|---|---|---|---
| | | |

- Definitions:  
**PR:** the number, for easy linking  
**Based on:** Verifying that the PR is based on the correct release branch (dev-1.14 now)  
**Tech LGTM:** Someone else from the developer’s SIG or who understands the feature change has signed off  
**Docs approved:** The docs have been reviewed for quality and style guide consistency  
**Merged:** once it’s merged to the dev branch :stars:  

- Use this placeholder text:

```
## Release X.Y Integration Branch

PR | Based on `dev-X.Y`? | Tech LGTM | Docs approved | Merged
---|---|---|---|---
| | | |
```
Example: https://github.com/kubernetes/website/pull/12584#issuecomment-462396797

12. First PR in `dev-[future release]`: Update config.toml to show `[future release]` as the current version and add the `[future release]` entry to the drop-down.

    The intent is that your new branch should be showing as the current version IN the new branch...

13. Update the Netlify _vnext staging_ site to use the new branch: (contact [sig-docs chair](https://github.com/kubernetes/community/tree/master/sig-docs#leadership) if you do not have access and they can assist with this).

- Login to [Netlify](https://app.netlify.com/) and navigate to the Sites tab.

- Open the settings for the [kubernetes-io-vnext-staging](https://app.netlify.com/sites/kubernetes-io-vnext-staging/settings) site.

- Edit the Deploy settings and change "Branch" to the new version branch, for example: `dev-1.14`.

- Save the change and verify that the change is live at [https://kubernetes-io-vnext-staging.netlify.com/](https://kubernetes-io-vnext-staging.netlify.com/).

14. Announce that `[future release]` branch is open for new feature docs on slack #sig-docs.

15. Make a PR against master to edit the [pull request template](https://github.com/kubernetes/kubernetes.github.io/blob/master/.github/PULL_REQUEST_TEMPLATE.md) to give advice about raising `[future release]`-related PRs against the `[future release]` branch. Example: https://github.com/kubernetes/website/pull/8057

---

## Mid steps

1. Reach out to release notes team to see if there's anything that might need docs that isn't already clearly known.

Example:

> Hey :wave: Release Notes folks! I just wanted to touch base early (ish) in the cycle to introduce myself (Jim Angel, sig-docs release lead for 1.14) and to ask that we stay in touch as you start drafting your release notes. This came up from previous sig-docs leads, who said they found things in the release notes that _probably needed docs_ :slightly_smiling_face: Questions?

2. Maintain the current and upcoming release branches

- Periodically merge `master` into the current release branch.

You should merge into `dev-[future release]` regularly. But you should also merge into `release-[current release]` regularly too. Reason being when we cut the release, we'll need to point to `release-[current release]` for the `[current release]` docs.

For example, during the v1.14 release cycle, you must periodically merge `master` into `release-1.13`.

Periodic merges must continue throughout the release cycle, until the pending release (for example, `release-1.14`) merges to `master`. This is to ensure that the current release branch remains up to date, and to preserve the current branch as a snapshot when the new version is released. Periodic maintenance also helps avoid excessive merge conflicts between `master` and the current branch at the end of the release cycle.

On your local fork:
```
$ git remote add upstream https://github.com/kubernetes/website.git
$ git fetch upstream
$ git checkout release-[current release]
$ git merge upstream/master
$ git push -f upstream release-[current release]
```

- Periodically rebase the upcoming release branch onto `master`.

For example, during the v1.14 release, you must periodically rebase `dev-1.14` onto `master` in order to pick up any changes in `master` during the release process.

On your local fork:
```
$ git remote add upstream https://github.com/kubernetes/website.git
$ git fetch upstream
$ checkout dev-[future release]
$ git rebase upstream/master
# if needed: https://help.github.com/articles/resolving-a-merge-conflict-using-the-command-line/
$ git push -f upstream dev-[future release]
```

You may need to fix conflicts manually. If somebody has improved a page on master, and at the same time it has been updated in dev-1.14, we may need to figure out how to make those changes work together. In my experience this was usually pretty straightforward. But if something comes up which isn't obvious, you can always abort the merge and reach out to people for help.


2b. Periodically merge both master and [future release] into an [integration branch](https://github.com/kubernetes/website/pull/11401).

3. Make a query showing all PRs raised against [future release] and monitor that regularly. You can select all and assign them to the [future release] milestone. But I found that the query for the base branch was easier to track.

4. For a given PR, when it has technical sign-off via `/lgtm`, you almost always need to do a copyedit / rewrite. Get technical sign-off on your copyedit before approving and merging the PR, unless you are absolutely sure you haven't changed any technical meaning. If you can't handle all the copyediting, assign some of these out to other sig-docs members.

5. Monitor the enhancement tracking spreadsheet.

6. Enforce deadlines. Communicate with SIGs via Slack and email lists to keep up to date on status.

7. Work with enhancement developers and reviewers

- Keep developers apprised of due dates for docs.

    Send announcements to:
        - [gke-kubernetes-team@google.com](mailto:gke-kubernetes-team@google.com)
        - [kubernetes-sig-release@google.com](mailto:kubernetes-sig-release@google.com)
        - [#sig-release](https://kubernetes.slack.com/messages/C2C40FMNF/) on Slack
        - [kubernetes-sig-leads@google.com](mailto:kubernetes-sig-leads@google.com)
        - Feature owners listed in the OSS enhancement tracking spreadsheet

- As developers open PRs, give them `sig/*` labels (listed in the enhancement tracking spreadsheet) to help find technical reviewers.

8. Track PRs

- Follow the enhancement spreadsheet.

    Keep the enhancement tracking spreadsheet up to date with review progress and merge status for each documentation PR. For example: [Kubernetes Enhancements OSS tracking board (1.14 release)](https://docs.google.com/spreadsheets/d/116X6E-lmDJG5UZPlqDAFw8hN9vS6SNY4qRNZ9fKtsMU/edit#gid=0)

- Update documentation PR progress in the Release 1.14 Integration Branch (see above for info).

- Make sure that docs PRs for the release have the correct base and set the correct Milestone. For example, enhancement PRs for version 1.14 need a base branch of `dev-1.14` and the Milestone set to `1.14`.

9. Review PRs

- Remind tech reviewers to comment with `/lgtm` when PRs pass review.

- Ask SIG Docs (#sig-docs channel on Slack) for help with reviews.

- Review PR commit histories.

    Make sure that PR commit histories contain only changes to files. It's especially important to avoid revert commits.

    Encourage developers to rebase any PRs with complicated commit histories.

---

## Late steps

### Last minute PRs

*   Triage:
    *   Decide what must go out with release, what can be published just after the release.
    *   Determine how much effort will be required to review the doc(s).
        *   Is it a complex enhancement needing specific reviewers?
        *   Is it a long doc? Is it several docs?
        *   Do you have edit permissions to help speed up the turnaround? If not, request that they check the [Allow edits from maintainers](https://help.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/) checkbox.
*   Get the PR author to help find tech reviewers.
*   Ping the PR author to incorporate review feedback ASAP.
*   Ask the release manager at the burndown meeting to help find appropriate tech reviewers.
*   If not critical to initial release, un-merged PRs can be dealt with after the release.

Meetings increase in frequency over the course of the release, moving from weekly to daily.

1. Generate reference docs.
2. For PRs that won't make the release, change their milestone and make sure everyone is clear.
3. Update the `config.toml` file for the pending release and its four previous releases. For example: if 1.14 is the pending release, update config.toml in 1.14-1.10. Example: https://github.com/pulls?utf8=%E2%9C%93&q=is%3Apr+author%3Ajimangel+archived%3Afalse+is%3Aclosed+modified+1.13+release+in%3Atitle


### Generate reference docs

- Regenerate [reference docs](https://kubernetes.io/editdocs/) ("Updating Automatically Generated Reference Pages") and open PRs.

- Update the reference page for [enhancement gates](https://github.com/kubernetes/website/blob/master/content/en/docs/reference/enhancement-gates.md).
    *   Update [/update-imported-docs.sh](https://github.com/kubernetes/website/blob/master/update-imported-docs.sh), e.g. [PR #4210](https://github.com/kubernetes/website/pull/4210/files#diff-8696ecc75d1b25a0b2812f88aefea8c3).
*   Make sure the auto-generated docs have been updated.
    *   Check with Phillip Wittrock ([pwittroc@google.com](mailto:pwittroc@google.com)).
    *   Run update-imported-docs.sh.
*   Make sure the tutorials are imported from kubernetes/examples repo.
    *   Run ./update-imported-tutorials.py
*   Merge `master` back into the branch for the last release to create final snapshot of the last release, e.g. finalize `release-1.13` branch before `release-1.14` is merged into `master`.
*   Add tags to `master`, last release, and next release branches to keep track of snapshot points, e.g. `snapshot-final-v1.13`, `snapshot-initial-v1.14`, etc.
*   Update links for release announcement given by Kubernetes PM, currently Aparna Sinha ([apsinha@google.com](mailto:apsinha@google.com)), e.g. [Kubernetes.io Blog: 1.7 Release announcement](https://docs.google.com/a/google.com/document/d/1U8oNYK-baoF-ObIRFKEmCicDnrgFdXAz7Nfkatg_jUo/edit?usp=sharing).
*   Work with release manager to update links in release notes to k8s.io docs, e.g. [Google Doc](https://docs.google.com/a/google.com/document/d/1dWFkFJIHo3liTWomvB1ur6jqd6cnxvGb_jjE-3-c6Bo/edit?usp=sharing) that fed into [kubernetes/enhancements: /release-1.7/release-notes-draft.md](https://github.com/kubernetes/enhancements/blob/master/release-1.7/release-notes-draft.md).

---

## Doing the release

1. Merge master into [future release] again if needed (check the on-hold PR for conflicts).
2. Remove the hold from the on-hold PR when needed and merge into master.
*   _Squash and merge_ the release PR, e.g. [PR #4094](https://github.com/kubernetes/website/pull/4094).
*   Move any hanging (un-merged) PRs back to the `master` branch.
*   Remove the reminder in the [pull request template](https://github.com/kubernetes/website/blob/master/.github/PULL_REQUEST_TEMPLATE.md) for release PRs.
*   Merge `master` back into the current release branch to keep them in sync.
3. Tag the current state of the integration branch as the final commit for [current release].
4. Merge master into the integration branch.
5. Tag the new integration branch state as the [future release] release.
6. Close the [future release] milestone.

---

## Post release

Nominate a new lead

1. At the beginning of the release, nominate a release lead and request release shadows. **Note: It’s highly recommended that you be release shadow before you are a release lead.**

2. Hold a docs-only burn down
- Can we improve process?
- Can we improve playbook?
- Can we remove stuff from playbook?

3. Send the playbook to sig-docs slack and mailinglist for review

4. Remove this file: https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/docs/update-release-docs-old.md (old gh-pages doc). After merging, delete this line.

---

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

1. Git command line (free): [https://git-scm.com/downloads](https://git-scm.com/downloads)
1. Atlassian SourceTree Git client (free): [https://www.sourcetreeapp.com/](https://www.sourcetreeapp.com/)
1. Source URL: [https://github.com/kubernetes/kubernetes.github.io.git](https://github.com/kubernetes/kubernetes.github.io.git)

## Appendix II: Merging master into a branch

When merging master into a release branch, e.g. `dev-1.14`:

1.  Make sure you are on the checked out `dev-1.14` branch.
1.  Do a _Pull_ from the k8s.io repo but set the _Remote branch to pull_ to `master`.
1.  Resolve any conflicts.
1.  Push the commits back up to the k8s.io repo to the `dev-1.14` remote branch.

## Appendix III: Resolving conflicts during a merge

If using a Git client such as SourceTree, here is a good guide for dealing with merge conflicts: [https://githubtraining.com/fix-merge-conflict-git-using-sourcetree/](https://githubtraining.com/fix-merge-conflict-git-using-sourcetree/)

When you are on a release branch, e.g. `dev-1.14`, and are merging `master` into it, the options to resolve a conflict are:

*   Resolve using 'mine' - this means to take all the changes from the `dev-1.14` branch to resolve the conflict.
*   Resolve using 'theirs' - this means to take all the changes from the `master` branch to resolve the conflict.
*   Resolve using an external merge tool - there are visual merge tools, like FileMerge on the Mac, that can help you see the differences between file versions and will allow you to select each one you want to keep. I recommend this for more complicated conflicts.
*   Resolve manually - you can open the conflicted file with a text editor and manually edit the conflicts. Perform a text search for `>>>>>>`, `<<<<<<` and `======`. This will help you navigate to conflicted parts of the file quickly.

**Note:** Keep in mind that sometimes changes to the documentation involve the removal of content, so if a file or paragraph was removed on purpose, make sure it is not there after a conflict has been resolved.
