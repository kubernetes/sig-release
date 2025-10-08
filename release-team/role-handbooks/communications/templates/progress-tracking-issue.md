# Progress Tracking Issue

The below is the content full content of the progress tracking issue. Replace all the `v1.XX` references to the target release.

Example tickets:

- v1.34 https://github.com/kubernetes/sig-release/issues/2790
- v1.33 https://github.com/kubernetes/sig-release/issues/2718
- v1.32 https://github.com/kubernetes/sig-release/issues/2625

-----

> [!NOTE]
> This ticket follows the [Release Team Lead Cycle Progress ticket](https://github.com/kubernetes/sig-release/issues/XXXX), and is curated for Comms specific actions and plans. More of release information can be found in [/releases/release-1.XX/README.md](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/README.md).


# Overview

## Latest Update

As of Monday, xx January (week 1)
- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

## Currently Tracked Goals

- [ ] Feature Blogs
  - [ ] Opt-in Outreach
- [ ] Mid Cycle Sneak Peek Blog
  - [ ] Internal write-up
  - [ ] Official PR
- [ ] Release Announcements
  - [ ] Release Highlights
  - [ ] Internal write-up
  - [ ] Official PR
- [ ] Webinar and Press
  - [ ] Schedule with CNCF
  - [ ] Coordinate interview setup with press
  - [ ] Hold webinar

## Useful Links

- [v1.XX Schedule and Information](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/README.md)
- [Templates for various reach-out / drafts](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/communications/templates)
- Enhancement Tracking Board: _(TBC)_
- **Mid Cycle Blog**
  - Comms team internal draft: _(TBC)_
  - PR for official blog: _(TBC)_
  - Previous Mid Cycle Blogs: [v1.29](https://kubernetes.io/blog/2023/11/16/kubernetes-1-29-upcoming-changes/), [v1.30](https://kubernetes.io/blog/2024/03/12/kubernetes-1-30-upcoming-changes/), [v1.31](https://kubernetes.io/blog/2024/07/19/kubernetes-1-31-upcoming-changes/), [v1.32](https://kubernetes.io/blog/2024/11/08/kubernetes-1-32-upcoming-changes/), [v1.33](https://kubernetes.io/blog/2025/03/26/kubernetes-v1-33-upcoming-changes/)
  - Published blog: _(TBC)_
- **Release Highlight**
  - Release Highlights contact issue: _(TBC)_
  - Release Highlights discussion: _(TBC)_
- **Release Announcement**
  - Comms team internal draft: _(TBC)_
  - PR for official blog: _(TBC)_
  - Previous Release Announcements: [v1.29](https://kubernetes.io/blog/2023/12/13/kubernetes-v1-29-release/), [v1.30](https://kubernetes.io/blog/2024/04/17/kubernetes-v1-30-release/), [v1.31](https://kubernetes.io/blog/2024/08/13/kubernetes-v1-31-release/), [v1.32](https://kubernetes.io/blog/2024/12/11/kubernetes-v1-32-release/), [v1.33](https://kubernetes.io/blog/2025/04/23/kubernetes-v1-33-release/)

# Schedule and Details

## Week 1, 2: Onboarding

Comms work tend to focus more towards the latter half of the release schedule, and thus this is the time to prepare for the team setup.

### For Lead

* [ ] Onboard the shadows
  * [ ] Select the shadows
  * [ ] Prepare the onboarding presentation
  * [ ] Run down Comms expectation in a meeting
  * [ ] Provide all the relevant information for the action items for the shadows
  * [ ] Update contact details for the shadows in the release contact sheet
* [ ] Update the `k/org`'s [/config/kubernetes/sig-release/teams.yaml](https://github.com/kubernetes/org/blob/main/config/kubernetes/sig-release/teams.yaml)
  - This gives access to the [Comms Project Board](https://github.com/orgs/kubernetes/projects/195/views/4) (Link to be fixed)
  - We need the lead and shadows to be listed as milestone maintainers
  * [ ] Add the lead
  * [ ] Add the shadows
* [ ] Setup Comms Project Board
  * [ ] Copy "Comms - All" project board
  * [ ] Copy "Comms - Feature Blogs" project board
  * [ ] Adjust the filter setup for "Comms - Feature Blogs" to ensure anyone can find the current progress with Feature Blog status

### For Shadows

> [!TIP]
> Although many actions need to be handled by the shadows themselves, it is important for the lead to guide to the right information and material for proceeding with them.

* [ ] Create [membership request issue](https://github.com/kubernetes/org/issues/new?template=membership.yml) in `k/org` (if not already members)
* [ ] Sign the CLA
* [ ] Subscribe to the Kubernetes release calendar
* [ ] Join the Slack channels related to Release Teams
  - [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF)
  - [#sig-docs](https://kubernetes.slack.com/archives/C1J0BPD2M)
  - [#sig-docs-blog](https://kubernetes.slack.com/archives/CJDHVD54J)
  - [#release-comms](https://kubernetes.slack.com/archives/CNT9Y603D)
  - Also, there are other Release related channels worth joining
    - [#release-ci-signal](https://kubernetes.slack.com/archives/CN0K3TE2C)
    - [#release-notes](https://kubernetes.slack.com/archives/CN1KH4K9A)
    - [#release-docs](https://kubernetes.slack.com/archives/C0156PJ62RE)
    - [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E)
    - [#release-management](https://kubernetes.slack.com/archives/CJH2GBF7Y)
* [ ] Schedule and attend the mandatory shadow orientation (general)
* [ ] Schedule and attend the Comms shadow onboarding

### Status Summary / Note for Reference

- TBC

## Week 3, 4, 5, 6, 7: Tracking

The main tracking starts as the enhancement freeze comes into play.

For v1.XX, the enhancement freeze takes place on week {{X}}.

### For Lead

* [ ] Have a clear picture of what to expect with Release Lead and other Subteam Leads
  * [ ] List all major changes to be included in this release with the Release Lead and Enhancements Lead
  * [ ] List most noteworthy deliverables post-Enhancements freeze with Enhancements and Docs Leads
* [ ] Prepare the Comms board with Feature Blog opt-in reach-out assignees
* [ ] With Enhancement freeze in effect (in week 5), prepare for Release Highlights
  * [ ] Create a GitHub Discussion: _(TBC)_
    - This can be used to collect the Release Highlights from various SIGs and KEP owners
    - [Template](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/communications/templates/release-highlights-discussion.md)
    - Example: [v1.26](https://github.com/kubernetes/sig-release/discussions/2047), [v1.32](https://github.com/kubernetes/sig-release/discussions/2639), [v1.33](https://github.com/kubernetes/sig-release/discussions/2734)
  * [ ] Create a GitHub Issue: _(TBC)_
    - This is more for internal tracking within Comms team
    - [Template](https://github.com/kubernetes/sig-release/blob/master/release-team/role-handbooks/communications/templates/release-highlights-tracking-issue.md)
    - Example: [v1.32](https://github.com/kubernetes/sig-release/issues/2640), [v1.33](https://github.com/kubernetes/sig-release/issues/2735)
* [ ] Work with the Release Team and decide if the release warrants a Mid Cycle Blog

### For Lead and Shadows

* [ ] Start reaching out for Feature Blog opt-in for each KEP
  * [ ] Complete the first round of reach-out
  * [ ] Complete the second round of reach-out
* [ ] Reach out to all SIGs for their input on Release Highlights
  - The deadline would be much later, and we should mark the initial reach-out

### Status Summary / Note for Reference

- TBC

## Week 8: Feature Blog Deadline + Mid Cycle Blog

TBC

<!--
Update as necessary. The below is for reference from v1.33.

For v1.33, the Feature Blog freeze takes place on week 8. Also, the Mid Cycle Sneak Peek blog is set to be published on week 11, and thus we would need to start the sneak peek blog draft early enough. The week 8 is a good target to keep in mind.
-->

### For Lead
* [ ] Start drafting the mid cycle sneak peek blog
  - The initial draft can happen outside PR
  - Previous Mid Cycle Blogs:: [v1.29](https://kubernetes.io/blog/2023/11/16/kubernetes-1-29-upcoming-changes/), [v1.30](https://kubernetes.io/blog/2024/03/12/kubernetes-1-30-upcoming-changes/), [v1.31](https://kubernetes.io/blog/2024/07/19/kubernetes-1-31-upcoming-changes/), [v1.32](https://kubernetes.io/blog/2024/11/08/kubernetes-1-32-upcoming-changes/)

### For Lead and Shadows
* [ ] Update and finalise the Feature Blog status in the Project Board

### Status Summary / Note for Reference

- TBC

## Week 9: Focus on Mid Cycle Blog

TBC

<!--
Update as necessary. The below is for reference from v1.33.

As the mid cycle blog needs to be reviewed by the SIG Docs Blog team, the target is to get the blog ready for review this week, getting ready for the publish target of early week 11 for v1.33.
-->

### For Lead
* [ ] Create the mid cycle sneak peek blog PR
* [ ] Collaborate with sig-docs-blog to establish review expectations and publication strategy
* [ ] Notify sig-docs-blog about the review of the mid cycle sneak peek blog
* [ ] Assign Feature Blogs to each member and clarify in the "Comms Editor" column

### For Lead and Shadows
* [ ] Send another reminder to SIGs about Release Highlights

### Status Summary / Note for Reference

- TBC

## Week 10: Release Blog Draft & Mid Way Retro
TBC

<!--
Update as necessary. The below is for reference from v1.33.

For v1.33, the code freeze takes place this week. The deadline of Release Highlights is week after (week 11), and thus we start preparing for the Release Announcements write-up
-->

### For Lead
* [ ] Start drafting the Release Announcement blog
  - The initial draft can happen outside PR
  - Previous Release Announcements: [v1.29](https://kubernetes.io/blog/2023/12/13/kubernetes-v1-29-release/), [v1.30](https://kubernetes.io/blog/2024/04/17/kubernetes-v1-30-release/), [v1.31](https://kubernetes.io/blog/2024/08/13/kubernetes-v1-31-release/), [v1.32](https://kubernetes.io/blog/2024/12/11/kubernetes-v1-32-release/), [v1.33](https://kubernetes.io/blog/2025/04/23/kubernetes-v1-33-release/)

### For Lead and Shadows
A bit of slow time other than the mid cycle blog to be finalised.
* [ ] Join retrospective for sharing anything you learned from the cycle so far

### Status Summary / Note for Reference
- TBC

## Week 11: Mid Cycle Blog Published + Start of Burndown Meetings
TBC

<!--
Update as necessary. The below is for reference from v1.33.

The mid cycle blog goes out, and Release Highlight deadline is on this week. With the code freeze done in the previous week, we should be ready for getting more contents in place for the Release Announcement. However, for this release, we need to note how KubeCon takes place in the week after, and some of the schedule may need to be tweaked due to that.
-->

### For Lead
There are many items in week, and anything that couldn't get completed should be carried over in the week after (which is during KubeCon).

* [ ] Publish the mid cycle sneak peek blog (24th March, 2025)
* [ ] Make sure Release Highlights details are shared in the discussion ticket
  - This is to ensure transparency for all the Release teams
* [ ] Review Feature Blog assignment following the code freeze, and re-assign as necessary
* [ ] Run down the Release Announcement details for the team
* [ ] Schedule the release Live Webinar with CNCF by emailing `webinars@cncf.io`. You may be referred to [Calendly](https://calendly.com/cncfonlineprograms). The webinar is typically scheduled for 3-4 weeks after the release.
* [ ] Schedule press and analyst pre-briefings and interviews for the release lead with CNCF by emailing `pr@cncf.io`
* [ ] Schedule release blog and press embargo with the CNCF
* [ ] Discuss the Release Highlights status with the Release Lead, Enhancements Lead, and Docs Lead (during the RT meeting)
* [ ] Establish Feature Blog publication schedule, typically 2-3 posts per week, at least starting a day after the release blog.
* [ ] Establish a regular cadence status check-in with the `#sig-docs-blog` team and maintain the publication schedule post in Slack to keep everyone synced
* [ ] Choose the next Comms Lead

### For Lead and Shadows
* [ ] Send final reminder about the Release Highlights (the deadline is on Tuesday, 25th March, 2025)
* [ ] Join burndown meetings
  - As of writing (22nd March), the burndown meeting is likely to take place asynchronously on Slack
  - Lead or shadows will be asked to provide the RAG (Red Amber Green) status
* [ ] Send a reminder to Feature Blog authors (deadline on week 13)
  - Once the write-up is ready for review, we need to ensure we have the right parties engaged in the review (sig-docs-blog, associated SIGs, etc.).
* [ ] Prepare Feature Blog publication schedule internally
  - Once finalised, the schedule needs to be shared in `#sig-docs-blog`
* [ ] Start writing up Release Announcement blog draft
  - Each member should have a handful of sections to work on
  - Ensure each of the Release Highlights gets a one-to-two paragraph summary, following updates from SIGs

### Status Summary / Note for Reference
- TBC

## Week 12: Placeholder (KubeCon)
TBC

<!--
Update as necessary. The below is for reference from v1.33.

Because of KubeCon taking place, this week would be light in terms of the actions. However, as the many of the actions have started from week 11, any work should continue in this week, especially around the Release Announcement write-up which takes quite some time.

Also, if you are attending KubeCon, join the maintainer summit to meet the team!
-->


## Week 13: Crunch time
TBC

<!--
Update as necessary. The below is for reference from v1.33.

For v1.33, Feature Blog reviews start taking place from week 13.
-->

### For Lead
* [ ] Check status with Docs lead on content for the Known Issues section of the release blog
* [ ] Continue to partner with `#sig-docs-blog` for editorial review, work with shadows to ensure tech reviews are moving forward from SIGs
* [ ] Connect with Release Lead to ensure theme and release logo will be ready for release blog (not required for draft)
* [ ] Finalize Release Announcement blog draft and start review cycle, ensure it's ready for Docs Lead to publish on release day
* [ ] Share the Release Announcement blog PR in #chairs-and-techleads channel to get technical reviews
* [ ] Send release blog draft to CNCF (week 13)
* [ ] Ensure first few Feature Blogs are ready to publish and that review and merge plans are in place for any still outstanding.

### For Lead and Shadows
* [ ] TBC

### Status Summary / Note for Reference

- TBC

## Week 14: Getting Ready for Release
As the release coming up so near, we should be done with most of the actions by the end of week 14.

### For Lead
* [ ] Ensure the Release Announcement blog PR main write-up is merged
* [ ] Continue to facilitate publication of remaining feature blogs, until all PRs are merged with the right publication date

### For Lead and Shadows
* [ ] TBC

### Status Summary / Note for Reference

- TBC

## Week15: Release + Post Release Actions
For v1.33, the release is planned on **Wednesday 23rd April 2025**. At this point, there shouldn't be too much that we need to handle other than last minute juggling...

### For Lead
* [ ] Update the Release Announcement blog with the logo and release name!
* [ ] Continue to facilitate publication of remaining Feature Blogs, until all PRs are merged with the right publication date
* [ ] Update the Comms handbook with what you've learnt as leader (example PR: [here](https://github.com/kubernetes/sig-release/pull/2624))
* [ ] Organize the slides for the CNCF release webinar, and send to the CNCF for review at least one week ahead of the scheduled date. (see example slides [here](https://docs.google.com/presentation/d/1FPeZNnvAAkj7s0Xd9A_XyD6DdcITyg8I26GLFtcx13w/edit?usp=sharing))
* [ ] Close all the outstanding tickets
  - This ticket for tracking Comms progress
  - Release Highlight discussion
  - Post-release handbook / template update PRs
  - ... and any other tickets that was created

### For Lead and Shadows
* [ ] Participate in release retro

### Status Summary / Note for Reference

- TBC

## Other Follow-up Actions and Notes

- We should make clarification on when the Feature Blog opt-in reach-outs to happen (it was a bit vague)
- In the opt-in reach-out, we should consider whether Feature Blog write-up was done in the past
- We should remove the duplicated Project Board view, and adjust the column and field wording
- Make sure all the templates use the consistent KEP referencing of something like: `[KEP-4974: Deprecate v1.Endpoints](https://kep.k8s.io/4974)`
- Document the version should be "v" prefixed
- Update the blog status field to prefix with some numbers (the current "ready for review", "review in progress", "ready to publish" are all so similar and hard to see which one's which...)
- When getting the placeholder blog PRs for Feature Blogs, we will need to get the KEP authors to come back to us in the KEP. There were a few blogs I only caught by going through the list of blog PRs, and it was quite manual.

## Old Updates

<!-- By moving the latest updates from the top of the issue down here, you can keep the timeline of updates in a single view. This is not necessary, but could be useful.-->

As of XX Jan (week 1):
- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
