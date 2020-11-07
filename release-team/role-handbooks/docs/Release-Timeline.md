# Release Timeline
For each release, the schedule with deliverables is added to the release directory. This section talks about specific Docs Lead deliverables for each milestone in the release timeline.

- [Early Steps (Weeks 1-2)](#early-steps-weeks-1-2)
    - [Connect with the release team through Slack and Google Groups](#connect-with-the-release-team-through-slack-and-google-groups)
    - [Read the release timeline](#read-the-release-timeline)
    - [Introduce yourself](#introduce-yourself)
    - [Attend meetings](#attend-meetings)
    - [Read up on the release team](#read-up-on-the-release-team)
    - [Select Shadows](#select-shadows)
    - [Contact volunteers](#contact-volunteers)
    - [Meet with Shadows](#meet-with-shadows)
    - [Ensure access is set up](#ensure-access-is-set-up)
    - [Update the website configuration ahead of the release](#update-the-website-configuration-ahead-of-the-release)
- [Middle Steps (Weeks 3-8)](#middle-steps-weeks-3-8)
    - [Track PRs](#track-prs)
    - [Reach out to Enhancement Owners](#reach-out-to-enhancement-owners)
        - [Before the Open placeholder PR Deadline](#before-the-open-placeholder-pr-deadline)
        - [Before the PRs Ready for Review Deadline](#before-the-prs-ready-for-review-deadline)
        - [Before the PRs Ready to Merge Deadline](#before-the-prs-ready-to-merge-deadline)
    - [Reach out to release notes team](#reach-out-to-release-notes-team)
    - [Maintain the current and upcoming `dev` branch](#maintain-the-current-and-upcoming-dev-branch)
        - [Periodically merge `master` into `dev-[future release]`](#-periodically-merge-master-into-dev-future-release)
    - [Monitor PRs](#monitor-prs)
    - [Enforce deadlines](#enforce-deadlines)
    - [Communicate major deadlines](#communicate-major-deadlines)
    - [Review PRs](#review-prs)
    - [Style Guide Checklist (High to Low Level)](#style-guide-checklist-high-to-low-level)
    - [Nominate a Docs Lead for the Next Release](#nominate-a-docs-lead-for-the-next-release)
- [Late Steps (Weeks 9-11) - Prep for the release](#late-steps-weeks-9-11---prep-for-the-release)
    - [Generate the reference documentation](#generate-the-reference-documentation)
    - [Update minor version on API index page](#update-minor-version-on-api-index-page)
    - [Touch base with SIG Cluster Lifecycle (kubeadm)](#touch-base-with-sig-cluster-lifecycle-kubeadm)
    - [Update the `config.toml`s for the past four releases](#update-the-configtomls-for-the-past-four-releases)
    - [Deprecate links](#deprecate-links)
- [Release Week (Week 12)](#release-week-week-12)
    - [Create the release branch](#create-the-release-branch)
    - [Update Netlify](#update-netlify)
    - [Freeze Kubernetes website](#freeze-kubernetes-website)
    - [Inform localization teams](#inform-localization-teams)
    - [Review milestones](#review-milestones)
- [Release Day](#release-day)
    - [Merge `master`](#merge-master)
    - [Create release with tag](#create-release-with-tag)
    - [Unfreeze](#unfreeze)
    - [Close the [future release] milestone](#close-the-future-release-milestone)
- [Post Release Verification, Cleanup, and Handoff](#post-release-verification-cleanup-and-handoff)
    - [Update Release Notes Changelog](#update-release-notes-changelog)
    - [Review Docs Process and Update Documentation](#review-docs-process-and-update-documentation)
    - [Hold a docs-only burn down](#hold-a-docs-only-burn-down)
- [Prepare the Next Docs Lead for Success](#prepare-the-next-docs-lead-for-success)
    - [Create branches](#create-branches)
    - [Create milestone](#create-milestone)
    - [Update Netlify](#update-netlify)
    - [Update Slack](#update-slack)
    - [Reassign issues](#reassign-issues)
- [Celebrate](#celebrate-)


## Early Steps (Weeks 1-2)
These steps take approximately one hour to complete, and should be completed immediately.

### Connect with the release team through Slack and Google Groups

- Join the Kubernetes [#sig-release](https://kubernetes.slack.com/messages/sig-release) Slack channel. Introduce yourself as the Docs Lead for the [future release].

- Send a Slack direct message to the [future release] lead to introduce yourself.

- ⚠️  Join these Google groups:
    - [kubernetes-sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
    - [kubernetes-sig-docs](https://groups.google.com/forum/#!forum/kubernetes-sig-docs)
    - [kubernetes-dev](https://groups.google.com/forum/#!forum/kubernetes-dev)
    - [kubernetes-release-team](https://groups.google.com/a/kubernetes.io/g/release-team)
        - ⚠️  List of members for this group is managed in git. Please create a PR against `kuberenetes/sig-release` repo to include your email under `release-team` group in [`sig-release/group.yaml`](https://github.com/kubernetes/k8s.io/blob/master/groups/sig-release/groups.yaml) 
    - [kubernetes-release-team-shadows](https://groups.google.com/a/kubernetes.io/g/release-team-shadows)
        - ⚠️  List of members for this group is managed in git. Please create a PR against `kuberenetes/sig-release` repo to include your email under `release-team-shadows` group in [`sig-release/group.yaml`](https://github.com/kubernetes/k8s.io/blob/master/groups/sig-release/groups.yaml)

- Make sure you're included in the "official" release team file, e.g: [release 1.14](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/release_team.md). If not submit a PR and add yourself.

Early in the release cycle, the Release Manager opens an enhancement tracking spreadsheet, e.g: [the 1.14 release spreadsheet](https://docs.google.com/spreadsheets/d/1AFksRDgAt6BGA3OjRNIiO3IyKmA-GU7CXaxbihy48nsedit#gid=0). Later in the release this spreadsheet will contain important information for docs:

- Which enhancements we'll be tracking for this release
- Feature owners (and their GitHub IDs)
- Links to docs PRs opened for each enhancement

### Read the release timeline

Read the release timeline and **make sure the timeline includes deadlines for documentation work**, e.g: [1.14 timeline](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.14#timeline):

- Docs deadline - Open placeholder PRs (~3.5 weeks before release)
- Docs deadline - PRs ready for review (~2 weeks before release)
- Docs complete - All PRs reviewed and ready to merge (~1 week before release)

If these deadlines aren't listed in the release timeline, request that the Release Lead add them.

### Introduce yourself

Introduce yourself to the current localization owners to sync up early on strategy (needs coordination for main release). e.g: [Formalize docs release strategy with the different localization owners](https://github.com/kubernetes/website/issues/12396).

### Attend meetings

⚠️  Attend the release team meeting outlined in the current release. If you cannot attend, a Shadow needs to attend in your place.

### Read up on the release team

Read this to learn more about the entire [release team and process](https://github.com/kubernetes/sig-release/tree/master/release-team)

### Select Shadows

You will be provided with survey results from people interested working on the release team. If you do not have the results, contact the release lead for more information.

After vetting the volunteers for their roles, role leads should make a final decision on selected shadows with the incoming Release Team Lead. In the past the SIG Docs release team has been between 3-6 members.

⚠️ Beyond meeting the basic requirements and time commitments, a good Shadow is someone who is active in SIG-Docs. Selection priority should go to previous shadows who want to eventually lead a SIG-Docs release. Other than those few guidelines, use your best judgement!

[Link for additional information on shadows](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-selection.md#shadows)

### Contact volunteers

Send a Slack message to those that you select, e.g:

> Hey, you're officially on the SIG Docs 1.14 release team as a shadow! Let me know if there's any issues with being a shadow (as far as timing / availability / etc) and feel free to introduce yourself!
>
> Let me start: [General Introduction about your name, workplace, k8s community involvement, timezone etc]
>
>Ok, on to the business...
>
>We are an inclusive group so if there’s something you’re concerned about, or don’t understand, don’t worry and just ask!
>
> First off, check out the release team on-boarding guide: https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md
>
>Make sure you join the following Slack channels: #sig-docs, #sig-release, #release-docs
You'll then want to join these mailing lists if you haven't already:
>- https://groups.google.com/forum/#!forum/kubernetes-sig-release
>- https://groups.google.com/forum/#!forum/kubernetes-sig-docs
>- https://groups.google.com/forum/#!forum/kubernetes-dev
>
>Access to google docs and calendar invites are often based on these mailing lists, so it's a good idea to subscribe.
>
>When it comes to contributing and reviewing PRs, you should check out the docs style guide: https://kubernetes.io/docs/contribute/style/style-guide/
>
>We'll go over this in the meeting, but you may also want to take a quick look at the 1.14 release readme. https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/README.md
>
>Lastly, I'd love to jump on a call to go over the release process with everybody, describe what we'll be doing, and answer any questions. Below is a poll to see what time works best on Friday (if any). As we near the end of the release cycle I will add a regular weekly check-in.
>
>Please select your preferred time(s) Friday: https://doodle.com/<link-removed>


⚠️ Please coordinate with Emeritus Adviser for the release before taking this step.
Send a Slack message to those that you didn't select, e.g:

> Hey, I'm Jim Angel (Docs Lead for SIG Docs). Thanks for your interest in the SIG Docs 1.14 release team!
>
> The release team for sig-doc shadows has no additional availability, but please stick around help out with some of our other sigs (including sig-docs)!
>
> How can you help?
> - Attend the sig release meetings (07 30 AM PST Bi-weekly on Tuesdays - see #sig-release for more info).
> - SIG-DOCs is always looking for new contributors, please go introduce yourself and we're happy to help! As a bonus, you will be preferred during the next release cycle as opposed to someone not involved with sig-docs.
     - Slack is full of other great SIGs that could always use your help!
>
> I am also a resource to reach out to if you have any community questions (there's also #sig-contribex). I started out as a volunteer and now I am part of many Kubernetes sigs and teams.
>
> Thanks again for your interest and time!
>
> Jim Angel


### Meet with Shadows

Find .5-1 hour of time to meet with shadows and explain the release process. Walk through this entire document and review the flow with them. It helps to set expectations that the mantra is "hurry up and wait" but then it gets very hectic at the end. If you have the ability to, please record the meeting and share it with your Shadows for future review.

1. Add contacts to the shadows release docs, e.g: [https://bit.ly/k8s114-contacts](https://docs.google.com/spreadsheets/d/1BiGSLuCqjglQS1bJvpKk6rKFMciebPkUndzgDRnJsns/edit?ts=5c3bd42a#gid=0)

### Ensure access is set up

1. Make sure all shadows have edit access to the enhancement spreadsheet.

1. As a lead, make sure you are part of the [milestone-maintainers](https://github.com/orgs/kubernetes/teams/milestone-maintainers) and [sig-docs-en-owners](https://github.com/orgs/kubernetes/teams/sig-docs-en-owners).

1. You need push access to the Kubernetes website repo (contact a SIG Docs chair if you don't have it)

   ⚠️ (**This should be done by the Docs Lead**) Open the [integration branch] by creating a pull request against `master` referencing the `dev-[future release]` branch e.g., the [Release 1.14](https://github.com/kubernetes/website/pull/13174) PR uses the branch `dev-1.14`.

   This release pull request (also known as the [integration branch]) serves as the base for individual, component enhancement PRs of the release. A [integration branch] lets you bundle and merge multiple PRs simultaneously.

   ⚠️ Add the label `do-not-merge/hold` to the PR.

1. First PR in `dev-[future release]`: Update config.toml to show `[future release]` as the current version and add the `[future release]` entry to the drop-down, e.g: [config.toml diff](https://github.com/kubernetes/website/pull/20847)

    The intent is that your new branch should be showing as the current version IN the new branch...

### Update the website configuration ahead of the release

Update the main `config.toml` based on the version on the `master` branch. Open a PR for these changes against the `dev-[future release]` branch (which should already exist - this is a good check!)

```shell
# Step 1
# Do this on a fresh local clone OF YOUR FORK
# It's OK to use SSH for the git URL if you know how to do that
git clone https://github.com/yourGitHubUsername/website.git kubernetes-website
cd kubernetes-website
# Step 2
# Add the upstream repo as a remote
git remote add upstream https://github.com/kubernetes/website.git
git checkout --track master
git checkout -b config-toml-1.14 # change for the release you're making
# Step 3
# Edit config.toml to make the changes described above
# save your changes
git add config.toml
git commit -m "Updated config.toml for 1.14 release"
# Step 4
# Check things look right
git status
git remote -v
# Step 5
# Push this new branch to your fork
git push origin config-toml-1.14
```

Now create a pull request that targets the next release (here: `dev-1.14`) **not** `master`.


## Middle Steps (Weeks 3-8)
The middle weeks of the launch are where the Docs Lead and Docs Lead Shadows track and review incoming PRs.

### Track PRs

Track PRs based on the enhancement (KEP) spreadsheet.

Keep the enhancement tracking spreadsheet up to date with review progress and merge status for each documentation PR. For example: [Kubernetes Enhancements OSS tracking board (1.14 release)](https://docs.google.com/spreadsheets/d/116X6E-lmDJG5UZPlqDAFw8hN9vS6SNY4qRNZ9fKtsMU/edit#gid=0)

⚠️ Assign the enhancements evenly across your Shadows after the enhancement freeze. Assigning shadows before the
 enhancement freeze will cause unexpected behavior in the tracking spreadsheet due to frequent updates to dynamic data.
 (Tip: When assigning enhancements, try grouping enhancement owners and/or by SIGs)
  - You and your Shadows will be responsible for tracking whether the enhancement:
    - **has docs:** Actively has docs in place on Kubernetes website or in flight
    - **needs docs:** Actively needs docs to support the enhancement in the [future-release]
    - **unknown:** After reviewing the KEP, it is unclear if this needs docs or not
    - **not required:** The KEP doesn't change anything that requires reflection in Kubernetes website
  - You and your Shadows will also be responsible for marking whether the docs are:
    - **Complete (Merged):** PR on the dev-[future-release] is done and merged
    - **No PR:** No PR is open (helpful for dead line tracking)
    - **Late:** No PR is open AND it's passed the deadline
    - **Draft (PR):** PR is open but content isn't ready for review
    - **Ready for Review (PR):** PR is open but content IS ready for review
- ⚠️ Make sure that every docs PRs for the release have the correct base and set the correct Milestone. For example, enhancement PRs for version 1.14 need abase branch of `dev-1.14` and the Milestone set to `1.14`.

The spreadsheet can be used to track the current health of the docs for release. For example:

![Sample spreadsheet](pics/enhancement-tracking.png)

On the "Enhancement Stats" tab, a table was created to track the Doc Stats and then based on their category, in the other tab, assign a status "Green / Yellow / Red."

This is very helpful for weekly reports and managing deadlines

### Reach out to Enhancement Owners

#### Before the Open placeholder PR Deadline
After the Enhancement Freeze, reach out to all tracked enhancements to see if new docs or modification to existing docs
are required, e.g:

> Hello < tag enhancement owner(s) > :wave:, < future-release > Docs < Shadow/Lead > here.
>
> Does this enhancement work planned for < future-release > require any new docs or modification to existing docs?
>
> If so, please follows the steps [here](https://kubernetes.io/docs/contribute/new-content/new-features/#open-a-placeholder-pr)
> to open a PR against `dev-[future release]` branch in the `k/website` repo. This PR can be just a placeholder at this
> time and must be created before < docs placeholder deadline >
>
> Also, take a look at [Documenting for a release](https://kubernetes.io/docs/contribute/new-content/new-features/#for-developers-or-other-sig-members)
> to get yourself familiarize with the docs requirement for the release.
>
> Thank you!

#### Before the PRs Ready for Review Deadline
After the open placeholder PR deadline, reach out to all open/tracked doc PRs to remind the PR owners to get their
doc ready to be reviewed, e.g:

> Hello < tag doc owner(s) > :wave: please take a look at [Documenting for a release - PR Ready for Review](https://kubernetes.io/docs/contribute/new-content/new-features/#pr-ready-for-review)
> to get your PR ready for review before < PR ready for review deadline >. Thank you!

#### Before the PRs Ready to Merge Deadline
After the PR ready for review deadline, reach out to all open/tracked doc PRs to remind the PR owners to get docs review
and if needed, technical review, e.g:

> Hello < tag doc owner(s) > :wave:, a friendly reminder that this PR needs both tech and doc review by < docs complete deadline >
> to get this into the release. Please reach out to required SIGs to get their review. Thank you!


### Reach out to release notes team
Reach out to release notes team to see if there's anything that might need docs that isn't already clearly known, e.g:

> Hey :wave: Release Notes folks! I just wanted to touch base early in the cycle to introduce myself (Jim Angel, SIG Docs Lead for 1.14) and to ask that we stay in touch as you start drafting your release notes. This came up from previous SIG Docs Leads, who said they found things in the release notes that _probably needed docs_. Any questions?

### Maintain the current and upcoming `dev` branch

This allows us to avoid merge conflicts on release day with `dev-[future release]`.

#### ⚠️ Periodically merge `master` into `dev-[future release]`

To merge `master` into `dev-[future release]` on your local fork:

```bash
# Step 0 (if you don't already have a remote called "upstream")
git remote add upstream https://github.com/kubernetes/website.git
# Step 1
git fetch upstream master
# Step 2
git fetch upstream dev-[future release]
# Step 3
git checkout --track upstream/dev-[future release]
# Step 4
git pull --ff-only # make sure you're up to date
# Step 5 You might see merge conflicts at this point.
git merge upstream/master
## if needed: https://help.github.com/articles/resolving-a-merge-conflict-using-the-command-line/
## git add ...
## git merge --continue
# Step 6
git checkout -b merged-master-dev-[future release]
# Step 7
git commit -m "Merge master into dev-[future release] to keep in sync"
# Step 8
git push origin merged-master-dev-[future release]
```

Submit a PR against upstream `dev-[future release]` from your fork's branch `merged-master-dev-[future release]`. e.g., [merge master into future release](https://github.com/kubernetes/website/pull/16225).

You may need to fix conflicts manually. If somebody has improved a page on `master`, and at the same time it has been updated in the dev branch for the next release, we may need to figure out how to make those changes work together. If something comes up which isn't obvious, you can always abort the merge and reach out to SIG Docs for help.

When you have completed resolving the differences manually, run `git merge --continue` to complete the merge. Then carry on from step 5.

⚠️  **Ensure the PR is passing tests on GitHub**.

Perform merge activity on a regular basis to ensure a smooth release. eg: once/week during intial weeks and increase the frequency if required closer to the end of the release cycle. 

Report out the `dev-[future release]` branch health in Release Team meetings and sig-docs meetings. 

### Monitor PRs

Make a query showing all PRs raised against dev-[future release] and monitor that regularly e.g., [1.14 search](https://github.com/kubernetes/website/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+base%3Adev-1.14+label%3Alanguage%2Fen)

### Enforce deadlines

Enforce deadlines. Communicate with SIGs via Slack and email lists to keep everyone up-to-date on status.

### Communicate major deadlines

COMMUNICATE ALL 3 MAJOR DATES AT LEAST A WEEK PRIOR, INCLUDING THE RELEASE DATE REPO FREEZE, FOLLOWING THE BELOW METHODS:

- Keep developers apprised of due dates for docs.
    Send announcements to:
    - [Kubernetes Dev Group](https://groups.google.com/forum/#!forum/kubernetes-dev)
    - [#sig-release](https://kubernetes.slack.com/messages/sig-release) on Slack
    - Your team / shadows
    - [#sig-docs](https://kubernetes.slack.com/messages/sig-docs)
    - [#sig-docs-maintainers]((https://kubernetes.slack.com/messages/sig-docs-maintainers))
    - [#chairs-and-techleads](https://kubernetes.slack.com/messages/chairs-and-techleads)
    - (optional) Twitter
      - If you tweet, send a message to [#sig-release](https://kubernetes.slack.com/messages/sig-release) and ask for a friendly signal boost (retweets)

Example notice:

> Hey! The docs `placeholder PR` deadline is Friday March 1st.
>
> That means if you have a v1.14 enhancement (that requires docs), #sig-docs require that you have _at the very least_ a PR opened against dev-1.14 inKubernetes website.
>
> It would be AWESOME if it's the full doc! 😀
>
> Thanks! Important dates for v1.14: https://github.com/kubernetes/sig-release/blob/master/releases/release-1.14/README.md#tldr
>
> ![Bring out your docs](pics/meme-deadline.jpg)

### Review PRs

It is the Docs Lead and Shadows' responsibility to ensure the incoming docs meet our standards. It's impossible for us to understand every technical component, so it is important to get a **technical LGTM** too if you're unsure about technical accuracy.

Also review each PR for:

- Check that the PR is in the `[future release]` milestone
- Check that the KEP / enhancement is likely to land in `[future release]`.
- Review PR commit histories, and make sure that PR commit histories contain only changes to files. It's especially important to **avoid revert commits**. Encourage developers to rebase any PRs with complicated commit histories.
- Check that the PR has a technical LGTM.
- If no LGTM, assign `sig/*` labels (listed in the enhancement tracking spreadsheet) to help find technical reviewers.

#### Style Guide Checklist (High to Low Level)

The [style guide](https://kubernetes.io/docs/contribute/style/style-guide/) consists of guidelines, not rules.

- Make sure new docs use the correct page content type.
    - [Concept](https://kubernetes.io/docs/contribute/style/page-content-types/#concept)
    - [Task](https://kubernetes.io/docs/contribute/style/page-content-types/#task)
    - [Tutorial](https://kubernetes.io/docs/contribute/style/page-content-types/#tutorial)
- Make sure the page content renders correctly.
    - Numbered list
    - Code blocks
    - [Shortcodes](https://kubernetes.io/docs/contribute/style/style-guide/#shortcodes) for notes, cautions, and warnings
- Make sure the content makes sense
    - Check spelling
    - Consider the Style Guide's [best practices](https://kubernetes.io/docs/contribute/style/style-guide/#content-best-practices) and [patterns to avoid](https://kubernetes.io/docs/contribute/style/style-guide/#patterns-to-avoid)

> Note: Most PR owners are **not** writers, and many are non-native / secondary English speakers. Missing commas or passive voice should **not** block a /lgtm if the content is accurate. If something really bugs you, make a note and open a PR to fix it later.

Once the above is met, comment the following on the PR:

```
/lgtm
/approve
```

(you might already have /lgtm from the technical review stage; another /lgtm is fine if the prerequisites are already met).

If you need help reviewing PRs, ask SIG Docs (#sig-docs channel on Slack) for help. The weekly [PR Wrangler](https://github.com/kubernetes/website/wiki/PR-Wranglers) is your best resource.

> Note: PR's against the dev branch can merged at any time assuming they meet the criteria. Be careful though that you don't merge a feature that might be pushed out to the next release. If that happens, you can revert - but it's better to avoid the mess all together.
>
> You can add /hold to mark a PR that should not merge until the matching code changes are already in.

### Nominate a Docs Lead for the Next Release

⚠️ During Code Freeze, pick a successor who has demonstrated the ability and understanding of the process.

**Usually this is a Docs Lead Shadow that has been on the team for 2 releases with a desire to continue with the SIG Docs.**

- Reach out to the person you have in mind and confirm they are able to commit the time and effort for a successful release.
- Once confirmed, inform the Release Team and the SIG Docs Team.

If no suitable candidates are available, you may choose to lead again or nominate someone outside of the current release team (e.g: a recent Docs Lead).


## Late Steps (Weeks 9-11) - Prep for the release
The Docs Lead is responsible for updating the Kubernetes API reference, kubectl, and components documentation.
If you need help in building the reference documentation, reach out on Slack #sig-docs.

### Generate the reference documentation

Update the generated documentation using a Python script ([Generating Reference Pages for Kubernetes Components and Tools](https://kubernetes.io/docs/contribute/generate-ref-docs/kubernetes-components/)). Before running the script, modify `reference.yml` to checkout the Kubernetes future release branch.

![Update kubernetes release branch](pics/reference-yaml.png)

The first step is to famialiarize yourself with the `website/updated-imported-docs/update-imported-docs.py` script
and the instructions for ([Generating Reference Pages for Kubernetes Components and Tools](https://kubernetes.io/docs/contribute/generate-ref-docs/quickstart/)).

The reference documentation build depends upon a valid release tag.
When a Kubernetes release candidate version tag such as `v1.19-rc.2` is created, you can consider building
the reference documentation. Next:

- Create a branch for this work based off of the `dev-[future release]` branch.
- Run the `update-imported-docs.py` script providing the release tag to build the reference documentation.
- Commit the generated files.

![Copy and rename screenshot](pics/copy-rename-dir.png)

You can expect to maintain this branch with periodic updates to the reference documentation using the latest `rc` tag.
Merge your branch to the `dev-[future release]` branch just before the final release.
When the release is complete, you should build the reference documentation again using the final release tag and merge to the `master` branch.

Note: You should not have to build the reference documentation for every release candidate version.

### Update minor version on API index page

Update the `<MINOR_VERSION>` in `content/en/docs/reference/kubernetes-api/api-index.md` for the future release.

   ![Update API index](pics/update-api-index.png)

### Touch base with SIG Cluster Lifecycle (kubeadm)

Validate that SIG Cluster Lifecycle has all of the docs in place for the upcoming release. These are mainly kubeadm docs (upgrading, installing, changes, etc). If unsure, send a message to their [Slack](https://kubernetes.slack.com/messages/sig-cluster-lifecycle/) channel.


#### Update the `config.toml`s for the past four releases

Create the updated `config.toml` files for the 4 previous releases. These need to be 4 separate PRs because each release has its own `release-` branch.

See this for example (1.13 was the "future release"):
* 1.9 https://github.com/kubernetes/website/pull/11493
* 1.10 https://github.com/kubernetes/website/pull/11495
* 1.11 https://github.com/kubernetes/website/pull/11496
* 1.12 https://github.com/kubernetes/website/pull/11497

⚠️  DO NOT MERGE **ANY** OF THE `config.toml` PULL REQUESTS FOR PREVIOUS UNTIL THE RELEASE IS CONFIRMED

#### Deprecate links

- Deprecate the oldest API link in the reference docs e.g., https://github.com/kubernetes/website/pull/13467
- Update the index for the API reference docs e.g., https://github.com/kubernetes/website/pull/14139

> Note: These first two steps can be combined into one single PR. If done in a single PR, please update this handbook with examples.


## Release Week (Week 12)

### Create the release branch

Creating the release branch lets you snapshot the current docs in a new branch, `release-[current release]`, after merging `dev-[future release]`. For example: if `master` represents `v1.20`, you would create `release-1.20`.

> **Note:** Creating a branch requires someone with write access to `k/website`, such as a [SIG Docs co-chair](https://github.com/kubernetes/community/tree/master/sig-docs#leadership).

- From [k/website](https://github.com/kubernetes/website) click on `master` branch.
- Type the name of the release branch.
- **click** Create branch `release-x.yy` from `master`

![](pics/new-branch.png)

### Update Netlify

Update the Netlify configuration. (A [SIG Docs chair](https://github.com/kubernetes/community/tree/master/sig-docs#leadership) can assist you with access):

Login to [Netlify](https://app.netlify.com/) and navigate to the Sites tab.

- Create a Netlify site that builds from `release-[current-release]` branch. Even though the `[current-release]` is currently `master` (e.g: https://kuberneteio), eventually `master` will be a newer k8s version and we'll use the `release-[current-release]` branch to contain all prior changes - like a snapshot. (e.g https://v1-20.docs.kubernetes.io)
  - Taking the defaults here is mostly fine
  - When in doubt, compare it to a working example
  - e.g, site name: k8s-v1-20
  - e.g, custom domain: v1-20.docs.kubernetes.io

> Note: if the `release-[current-branch]` is created before the website is frozen you may need to merge in master to keep up-to-date

To merge `master` into `release-[current release]` on your local fork:

```shell
# Step 0 (if you don't already have a remote called "upstream")
git remote add upstream https://github.com/kubernetes/website.git
# Step 1
git fetch upstream master
# Step 2
git checkout --track upstream/release-[current release]
# Step 3
git merge upstream/master
# Step 4
git checkout -b merged-master-release-[current release]
# Step 5
git commit -m "Merge master into release-[current release] to keep in sync"
# Step 6
git push origin merged-master-release-[current release]
```

Now create a pull request to merge the new branch you've made into the `release-[current-release]` branch on [k/website](https://github.com/kubernetes/website).

### Freeze Kubernetes website

24 hours before the release, freeze the repo: ⚠️  no PRs should be allowed to merge AT ALL until the release PR has successfully merged.

- Request temporary write access to k/website. Any [SIG Docs co-chair](https://github.com/kubernetes/community/tree/master/sig-docs#leadership) should be able to help with this. 
- Submit an issue with `tide/merge-blocker` label. Depending upon your permissions, a [SIG Docs chair](https://github.com/kubernetes/community/tree/master/sig-docs#leadership) can assist you with adding the label.
- Submit a freeze announcement following our [protocols](#communicate-major-deadlines)

### Inform localization teams

Let localization team know about freeze and next tentative timeline(s) for important dates

> Hello localization team leads! We talked about docs in v1.14 here (https://github.com/kubernetes/website/issues/12396). I don't think any action is required from you, but I wanted to let you know that we are on track for the release (3/25/19) and all Kubernetes website branches are up to date (master, dev-1.14, release-1.13). Let me know if I can help with anything! Thanks!

### Review milestones

Review milestone for completion and outstanding PRs. For PRs that won't make the release, change their milestone and make sure everyone is clear.


## Release Day
⚠️  Everything in this section is important. It's OK to ask for advice if you're not sure.

This process takes approximately 4 hours.

Coordinate with the Release Team for the exact timing. Typically the release is 'officially' built, then you merge the docs, and then you approve the blog post to "make it official". For 1.14, we merged docs at 2:30 EST and the blog was approved at 3 EST - marking the release "complete".

### Merge `master`

- Merge master into [future release] again if any conflicts exist in the [integration branch].
- Merge `master` back into the current release branch to keep them in sync.
- Remove the hold from the on-hold integration PR when needed and merge into master.

### Create release with tag

Tag the commit hash before the [integration branch] as the final commit for [current release].

> Note: This can be done at any time post-release.

```shell
git clone https://github.com/kubernetes/website/
cd website
git checkout master
```
```
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```
Check the commit log
```shell
git log --pretty=format:"%h - %an, %ar : %s"
```
```
6c41db7e6 - Lubomir I. Ivanov, 2 hours ago : kubeadm-ts: add entry about patching kube-proxy in CCM scenarios (#13033)
6b8e14642 - Patrick Lang, 4 hours ago : Fix markdown around \ for file paths (#13404)
f024de7d3 - Noah Kantrowitz, 4 hours ago : Typo fix in a docs link. (#13405)
230dfa140 - Alex Contini, 4 hours ago : add AppDirect case study (#13338)
ef6c80a0e - Kaitlyn Barnard, 5 hours ago : 1.14 Blog Post (#13400)
851ef58fa - Jim Angel, 5 hours ago : Official 1.14 Release Docs (#13174)
28dd4d515 - evilyeti, 7 hours ago : Fixed broken link in E2E Testing blog
```
If that looks how you expect:
```shell
git tag -a snapshot-final-v1.13 28dd4d515 -m "Release 1.13 final snapshot"
git tag -a snapshot-initial-v1.14 851ef58fa -m "Release 1.14 initial snapshot"
git push --tags origin master
```

After creating the tags, you can create a release based off of a tag very easily. Follow the naming conventions as done before and update: https://github.com/kubernetes/website/releases

- "Draft a new release"
- Use new snapshot tag for release

### Unfreeze

Unfreeze the repo as done earlier (remove the `tide/merge-blocker` label and close issue).

### Close the [future release] milestone

- Merge the 4 config.toml's created as part of the sunsetting docs.
- Create a PR to update k/website's release notes
  - ex: https://raw.githubusercontent.com/kubernetes/kubernetes/master/CHANGELOG-1.14.md will be merged into content/en/docs/setup/release/notes.md
  - ex PR: https://github.com/kubernetes/website/pull/13416
- Find the open milestone for [future release] and close it.


## Post Release Verification, Cleanup, and Handoff
These steps should be done after the launch. They require approximately 4 hours of work.

### Update Release Notes Changelog

Manually update the Kubernetes website release notes changelog from the actual [release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#v1140), e.g: https://github.com/kubernetes/website/pull/13416

> Note: You need to wait until the release is cut to do this as it's included with the build process.

### Review Docs Process and Update Documentation

### Hold a docs-only burn down

- Can we improve process?
- Can we improve playbook?
- Can we add / **remove** stuff from playbook?


## Prepare the Next Docs Lead for Success

### Create branches

⚠️ Create a working branch (Named `dev-[future FUTURE release]`, for example `dev-1.15`) locally, based on master. Push it to upstream.

```shell
# This example is for a future release version 1.15
git clone https://github.com/kubernetes/website.git
git checkout -b dev-1.15
git commit --allow-empty -m "Tracking commit for v1.15 docs"
git push -u origin dev-1.15
```

Enable branch protection on the new `dev-` branch, and deprecate the older one; for an example, see: https://github.com/kubernetes/test-infra/pull/11984

### Create milestone

Create a milestone for NEW upcoming release. Depending on your permissions, you might need to contact a SIG Docs maintainer. Move anything missed for the current release to the new milestone.

### Modify prow config file

Create a [pull request](https://github.com/kubernetes/test-infra/pull/19877) against [k/test-infra](https://github.com/kubernetes/test-infra)
 to configure [prow](https://github.com/kubernetes/test-infra/tree/master/prow#) to automatically apply milestones to future release branch
 and to remove the configuration for the last release.

```diff
kubernetes/website:
-   dev-1.19: 1.19
+   dev-1.20: 1.20
```

### Update Netlify

Update Netlify (contact a [SIG Docs Chair or Technical Lead](https://git.k8s.io/community/sig-docs#leadership) if you do not have access and they can assist with this):

Login to [Netlify](https://app.netlify.com/) and navigate to the Sites tab.

- Clean Up
  - Delete the oldest docs site (usually a deprecated version 5+ releases ago)
- Update [vnext](https://app.netlify.com/sites/kubernetes-io-vnext-staging/settings) staging
  - Point at the new future dev-[future release]
  - Taking the defaults here is mostly fine
  - When in doubt, compare it to a working example
  - (check) build only production branch

- Save the change and verify that the change is live at [https://kubernetes-io-vnext-staging.netlify.com/](https://kubernetes-io-vnext-staging.netlify.com/).

### Update Slack

Announce that `[future release]` branch is open for new feature docs on slack #sig-docs.

### Reassign issues

- Clean Up
⚠️  Assign any issues / feature / PRs (that missed the release) to the new Docs Lead
⚠️  Create a PR to remove shadows from [milestone maintainers](https://github.com/orgs/kubernetes/teams/website-milestone-maintainers/)
    - The lead must stay in the list until the `[current release]` website version is officially supported


## Celebrate! 🎉
YOU MADE IT! Celebrate a job well done, keep an eye out for anything on fire, and begin to relax!