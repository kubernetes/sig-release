---
name: Release Comms Subteam Cycle Progress
about: Used to track release comms subteam work which needs to be done every release cycle
title: '[v1.XX] Release Comms Subteam Cycle Progress'
labels: sig/release, area/release-eng, area/release-team
---

<!--
This template is used for tracking tasks that the Release Comms Subteam needs to do in a release cycle.

The issue should be kept open for the entirety of the release cycle, until all tasks are completed.

The below is the full content of the progress tracking issue. Replace all the `v1.XX` references with the target release, fill in every `<...>` placeholder during week 1 (or as soon as the linked item exists), and adjust the "v1.38 example" week numbers to the current release schedule.

The sections are keyed to release milestones rather than fixed week numbers. Check the dates in releases/release-1.XX/README.md.

Example tickets:

- v1.37 https://github.com/kubernetes/sig-release/issues/3027
- v1.34 https://github.com/kubernetes/sig-release/issues/2790
- v1.33 https://github.com/kubernetes/sig-release/issues/2718

-->

> [!NOTE]
> This ticket follows the [Release Team Lead Cycle Progress ticket](<link to the Release Team Lead Cycle Progress issue>), and is curated for Comms specific actions and plans. Additional information about Comms actions can be found in the [release comms handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/communications). If tasks are not needed or additional tasks are required, make sure to update the issue template as well!
> More information about the release can be found in [/releases/release-1.XX/README.md](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/README.md).

<!--
Example Release Team Lead Cycle Progress tickets:

- v1.34 https://github.com/kubernetes/sig-release/issues/2779
- v1.33 https://github.com/kubernetes/sig-release/issues/2705

-->

# Overview

## Latest Update

<!-- Use this section to provide the latest updates on the progress of the Release Comms Subteam. This is not necessary, but could be useful.-->

As of <weekday, date> (week <N>):
- <update>

## Currently Tracked Goals

- [ ] Feature Blogs
  - [ ] Opt-in Outreach
- [ ] Deprecations and Removals Blog
  - [ ] Internal write-up
  - [ ] Official PR
- [ ] Release Announcement
  - [ ] Release Highlights
  - [ ] Internal write-up
  - [ ] Official PR
- [ ] Webinar and Press
  - [ ] Schedule with CNCF
  - [ ] Coordinate interview setup with press
  - [ ] Hold webinar

## Useful Links

<!-- Use this section to link to useful resources and Release Comms deliverables. Fill in the placeholders during week 1, or as soon as the linked item exists. -->

- [v1.XX Schedule and Information](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/README.md)
- [v1.XX Release Links](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/links.md) (Release Tracking Board, meeting notes, contacts)
- [Templates for various reach-out / drafts](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/communications/templates)
- Comms Project Board: <link>
- **Deprecations and Removals Blog**
  - Comms team internal draft: <link>
  - PR for official blog: <link>
  - Previous blogs: [v1.31](https://kubernetes.io/blog/2024/07/19/kubernetes-1-31-upcoming-changes/), [v1.32](https://kubernetes.io/blog/2024/11/08/kubernetes-1-32-upcoming-changes/), [v1.33](https://kubernetes.io/blog/2025/03/26/kubernetes-v1-33-upcoming-changes/)
  - Published blog: <link>
- **Release Highlights**
  - Release Highlights tracking issue: <link>
  - Release Highlights discussion: <link>
- **Release Announcement**
  - Comms team internal draft: <link>
  - PR for official blog: <link>
  - Previous release announcements: [v1.35](https://kubernetes.io/blog/2025/12/17/kubernetes-v1-35-release/), [v1.36](https://kubernetes.io/blog/2026/04/22/kubernetes-v1-36-release/), [v1.37](https://kubernetes.io/blog/2026/08/26/kubernetes-v1-37-release/)

# Schedule and Details

## Start of the release cycle: onboarding and planning (v1.38 example: weeks 1-3)

Comms work tends to focus more towards the latter half of the release schedule, and thus this is the time to prepare for the team setup.

### For Lead
* [ ] With the release schedule finalized, update this progress issue by completing the deadlines and adjusting the milestones and tasks as necessary
* [ ] Onboard the shadows
  * [ ] Select the shadows
  * [ ] Prepare the onboarding presentation
  * [ ] Run down Comms expectations in a meeting
  * [ ] Provide all the relevant information for the action items for the shadows
  * [ ] Update contact details for the shadows in the release contact sheet
* [ ] Update `k/sig-release`'s `/releases/release-1.XX/release-team.md` with the shadows' information
* [ ] Update the `k/org` [/config/kubernetes/sig-release/teams.yaml](https://github.com/kubernetes/org/blob/main/config/kubernetes/sig-release/teams.yaml)
  - This gives access to the Comms Project Board and the Release Tracking Board
  - We need the lead and shadows to be listed as milestone maintainers
  * [ ] Add the lead
  * [ ] Add the shadows
* [ ] Update the `release-comms@kubernetes.io` Google Group in [`groups/sig-release/groups.yaml`](https://github.com/kubernetes/k8s.io/blob/main/groups/sig-release/groups.yaml) so it only contains the current Release Team Lead and Lead Shadows, the current Comms Lead and Comms Shadows, and the SIG Release Chairs
* [ ] Setup Comms Project Board
  * [ ] Copy "Comms - All" project board
  * [ ] Copy "Comms - Feature Blogs" project board
  * [ ] Adjust the filter setup for "Comms - Feature Blogs" to ensure anyone can find the current progress with Feature Blog status
  * [ ] Align column values with the new Comms team members
* [ ] Check for holidays and events (e.g. KubeCon) during the cycle that affect the comms schedule, and plan around them
* [ ] Start communications with the SIG leads to align on the communications timeline and support for writing feature posts

### For Shadows

> [!TIP]
> Although many actions need to be handled by the shadows themselves, it is important for the lead to guide them to the right information and material for proceeding with them.

* [ ] Create a [membership request issue](https://github.com/kubernetes/org/issues/new?template=membership.yml) in `k/org` (if not already a member)
* [ ] Sign the CLA
* [ ] Subscribe to the [Kubernetes release calendar](https://rel.k8s.io/release-team-cal)
* [ ] Join the mailing lists listed in the [Release Team Onboarding Guide](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md#mailing-lists), plus `kubernetes-sig-docs`
* [ ] Join the Slack channels listed in the [Release Team Onboarding Guide](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md#slack); `#release-comms`, `#sig-docs` and `#sig-docs-blog` are the essential ones for Comms
* [ ] Schedule and attend the mandatory shadow orientation (general)
* [ ] Schedule and attend the Comms shadow onboarding

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## KEP Readiness Deadline through the weeks after Enhancements Freeze: tracking starts (v1.38 example: weeks 4-7)

The main tracking starts as the Enhancements Freeze comes into play.

For v1.XX, the Enhancements Freeze takes place on week <N>: <Enhancements Freeze date>.

### For Lead

* [ ] Get access to the Release Tracking Board and add the Comms team members to the `Comms Opt-in Assignee` and `Comms Editor` fields
* [ ] Have a clear picture of what to expect with the Release Team Lead and other Subteam Leads
  * [ ] List all major changes to be included in this release with the Release Team Lead and Enhancements Lead
  * [ ] List the most noteworthy deliverables post-Enhancements Freeze with the Enhancements and Docs Leads
* [ ] Work with the Release Team and decide if the release warrants a Deprecations and Removals blog
  * [ ] If so, solicit author(s) and open a placeholder PR in k/website for tracking
* [ ] Prepare the Comms board with Feature Blog opt-in reach-out assignees
* [ ] With Enhancements Freeze in effect, prepare for Release Highlights
  * [ ] Create a GitHub Discussion: <link>
    - This can be used to collect the Release Highlights from various SIGs and KEP owners
    - [Template](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/communications/templates/release-highlights-discussion.md)
    - Example: [v1.37](https://github.com/kubernetes/sig-release/discussions/3051)
  * [ ] Create a GitHub Issue: <link>
    - This is more for internal tracking within the Comms team
    - [Template](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/communications/templates/release-highlights-tracking-issue.md)
    - Example: [v1.37](https://github.com/kubernetes/sig-release/issues/3052)

### For Lead and Shadows

* [ ] With Enhancements Freeze in effect, start reaching out for Feature Blog opt-in for each KEP
  * [ ] Complete the first round of reach-out
  * [ ] Complete the second round of reach-out
* [ ] Start monitoring open PRs labeled `blog` on [kubernetes/website](https://github.com/kubernetes/website/pulls?q=is%3Apr+is%3Aopen+label%3Ablog) for feature blog PRs opened outside the opt-in process, and add untracked ones to the Release Tracking Board (continue until the Feature blog freeze)
* [ ] Reach out to all SIGs for their input on Release Highlights
  - The deadline would be much later, and we should mark the initial reach-out

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Before the Feature blog freeze: Deprecations and Removals blog draft (v1.38 example: weeks 8-9)

For v1.XX, the Feature blog freeze takes place on week <N>: <Feature blog freeze date>. The Deprecations and Removals blog is set to be published on week <N>: <publication date>, the Monday of the week after Code Freeze, so the draft needs to start early enough. The weeks before the Feature blog freeze are a good target, since the major changes and noteworthy deliverables should be known by this point.

### For Lead
* [ ] Start drafting the Deprecations and Removals blog
  - The initial draft can happen outside a PR
  - [Template](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/communications/templates/mid-cycle-blog-sneak-peek.md) and previous blogs are linked under Useful Links above
* [ ] Post reminders for the feature blog opt-in on the SIG Slack channels and in the KEP issues

### For Lead and Shadows
* [ ] Update and finalise the Feature Blog status in the Project Board
* [ ] Consider pairing Feature Blog authors together following SIG Docs' writing buddy process
* [ ] Work on the Deprecations and Removals blog draft

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Feature blog freeze (v1.38 example: week 10)

As the Deprecations and Removals blog needs to be reviewed by the SIG Docs Blog team, the target is to get the blog ready for review around Code Freeze.

### For Lead
* [ ] Send out final reminders for the feature blog opt-in and request placeholder PRs from all feature blog authors
* [ ] Get the Deprecations and Removals blog draft into its placeholder PR
* [ ] Collaborate with `#sig-docs-blog` to establish review expectations and publication strategy
* [ ] Notify `#sig-docs-blog` about the review of the Deprecations and Removals blog
* [ ] Assign Feature Blogs to each member and clarify in the "Comms Editor" column

### For Lead and Shadows
* [ ] Send another reminder to SIGs about Release Highlights
* [ ] Work on Deprecations and Removals blog PR review comments

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Release blog draft (v1.38 example: week 11)

A bit of slow time other than the Deprecations and Removals blog to be finalised. Code Freeze takes place next week and the Release Highlights deadline is the week after, so we start preparing for the Release Announcement write-up. The release retro part 1 is held in the first week of burndown meetings after Code Freeze. If KubeCon falls in this window, expect a light week and carry anything unfinished over.

### For Lead
* [ ] Start drafting the Release Announcement blog
  - The initial draft can happen outside a PR
  - [Template](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/communications/templates/release-blog.md) and previous announcements are linked under Useful Links above

### For Lead and Shadows
* [ ] Join the retrospective for sharing anything you learned from the cycle so far
* [ ] Send a final reminder about the Release Highlights

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Code Freeze (v1.38 example: week 12)

For v1.XX, Code Freeze takes place on week <N>: <Code Freeze date>.

### For Lead

There are many items this week, and anything that couldn't get completed should be carried over to the week after.

* [ ] Make sure Release Highlights details are shared in the discussion ticket
  - This is to ensure transparency for all the Release teams
* [ ] Review Feature Blog assignments following Code Freeze, close placeholder PRs for features that dropped out of the release, and re-assign as necessary
* [ ] Run down the Release Announcement details for the team
* [ ] Schedule the release live webinar with the CNCF by emailing `webinars@cncf.io`. You may be referred to [CNCF's marketing form](http://marketingform.cncf.io/). The webinar is typically scheduled for 3-4 weeks after the release.
* [ ] Schedule press and analyst pre-briefings and interviews for the Release Team Lead with the CNCF by emailing `pr@cncf.io`
* [ ] Schedule the release blog and press embargo with the CNCF
* [ ] Discuss the Release Highlights status with the Release Team Lead, Enhancements Lead, and Docs Lead (during the RT meeting)
* [ ] Establish the Feature Blog publication schedule, one post per weekday starting the day after the release blog, working around major global holidays
* [ ] Establish a regular cadence status check-in with the `#sig-docs-blog` team and maintain the publication schedule post in Slack to keep everyone synced
* [ ] Start the conversation about the next Comms Lead

### For Lead and Shadows
* [ ] Join burndown meetings, which start the week after Code Freeze
  - Lead or shadows will be asked to provide the RAG (Red Amber Green) status
* [ ] Send a reminder to Feature Blog authors about the "Feature blogs ready to review" deadline
  - Once the write-up is ready for review, we need to ensure we have the right parties engaged in the review (`#sig-docs-blog`, associated SIGs, etc.).
* [ ] Prepare the Feature Blog publication schedule internally
  - Once finalised, the schedule needs to be shared in `#sig-docs-blog`
* [ ] Start writing up the Release Announcement blog draft
  - Each member should have a handful of sections to work on
  - Ensure each of the Release Highlights gets a one-to-two paragraph summary, following updates from SIGs

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Deprecations and Removals blog published, Release Highlights deadline (v1.38 example: week 13)

For v1.XX, the Release Highlights deadline is on week <N>: <Release Highlights deadline>.

### For Lead
* [ ] Publish the Deprecations and Removals blog on the Monday of the week after Code Freeze
* [ ] Check status with the Docs Lead on content for the Known Issues section of the release blog
* [ ] Check status on all feature blog PRs, keep `#sig-docs-blog` up to date for editorial review, and establish that tech reviewers are available

### For Lead and Shadows
* [ ] Continue to work on the Release Announcement blog draft

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Feature blogs ready to review (v1.38 example: week 14)

For v1.XX, the Feature blogs ready to review deadline is on week <N>: <date>. Feature Blog reviews start from this point.

### For Lead
* [ ] Continue to partner with `#sig-docs-blog` for editorial review, work with shadows to ensure tech reviews are moving forward from SIGs
* [ ] Connect with the Release Team Lead to ensure the theme and release logo will be ready for the release blog (not required for the draft)
* [ ] Finalize the Release Announcement blog draft and start the review cycle
* [ ] Share the Release Announcement blog PR in `#chairs-and-techleads` to get technical reviews
* [ ] Send the release blog draft to the CNCF

### For Lead and Shadows
* [ ] Address review comments on the Release Announcement blog draft

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Release blog ready to review: getting ready for release (v1.38 example: week 15)

For v1.XX, the release blog ready to review deadline is on week <N>: <date>. We should be done with most of the actions by the end of this week.

### For Lead
* [ ] Ensure the Release Announcement blog PR main write-up is merged (as a draft) and that the final publishing PR is ready for the Docs Lead to unhold on release day
* [ ] Open the bulk scheduling PR for the feature blogs (remove `draft: true`, set the dates, rename the files) and get it reviewed by `#sig-docs-blog`
* [ ] Continue to facilitate publication of remaining feature blogs, until all PRs are merged with the right publication date

### For Lead and Shadows
* [ ] Ensure the first few Feature Blogs are ready to publish and that review and merge plans are in place for any still outstanding

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Release and post-release actions (v1.38 example: week 16 onwards)

For v1.XX, the release date is on week <N>: <release date>.

At this point, there shouldn't be too much that we need to handle other than last minute juggling.

### For Lead
* [ ] Update the Release Announcement blog with the logo and release name!
* [ ] Once the Release Announcement is published, post in `#announcements` and `#release-comms`
* [ ] Confirm the next Comms Lead with the incoming Release Team Lead
* [ ] Update the Comms handbook with what you've learnt as lead (example PR: [v1.32](https://github.com/kubernetes/sig-release/pull/2624))
* [ ] Organize the slides for the CNCF release webinar, and send them to the CNCF for review at least one week ahead of the scheduled date.
  - Previous webinar decks: [v1.36](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.36/Kubernetes%20v1.36%20Release%20Webinar.pdf), [v1.37](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.37/Kubernetes%20v1.37%20Release%20Webinar.pdf)
* [ ] Update `k/sig-release`'s `/releases/release-1.XX` with the webinar deck
* [ ] Close all the outstanding tickets
  - This ticket for tracking Comms progress
  - Release Highlights discussion and tracking issue
  - Post-release handbook / template update PRs
  - ... and any other tickets that were created

### For Lead and Shadows
* [ ] Participate in the release retro
* [ ] Continue to facilitate publication of the remaining Feature Blogs, until all PRs are merged with the right publication date

### Status Summary / Note for Reference

<!-- Use this section to provide any relevant notes or summary for this period. This is not necessary, but could be useful for future Release Comms Leads.-->

- <notes>

## Old Updates

<!-- By moving the latest updates from the top of the issue down here, you can keep the timeline of updates in a single view. This is not necessary, but could be useful.-->

As of <weekday, date> (week <N>):
- <update>
