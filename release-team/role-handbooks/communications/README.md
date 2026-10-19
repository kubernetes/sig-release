# Kubernetes Release Team: Communications Coordinator

- [Overview](#overview)
- [Requirements](#requirements)
  - [Skills and Experience Required](#skills-and-experience-required)
  - [Expected Time Investment](#expected-time-investment)
- [External Release Communication](#external-release-communication)
  - [Slack Channel](#slack-channel)
- [Working with other teams and SIGs](#working-with-other-teams-and-sigs)
- [Release deliverables](#release-deliverables)
  - [Collect Release Highlights](#collect-release-highlights)
  - [Release blog](#release-blog)
  - [Feature blogs](#feature-blogs)
  - [Deprecations and Removals blog](#deprecations-and-removals-blog)
  - [Press and release webinar](#press-and-release-webinar)
  - [Tips and tricks](#tips-and-tricks)
  - [Social posts](#social-posts)
- [Release Milestone Activities](#release-milestone-activities)
- [Release Blog Outline and Templates](#release-blog-outline-and-templates)
- [Examples from the latest cycle](#examples-from-the-latest-cycle)

## Overview

The Communications Coordinator role is responsible for facilitating, empowering, and curating communication between the release team and various stakeholders including the Cloud Native Computing Foundation (CNCF), the media, contributing vendors, Kubernetes project managers, and the overall Kubernetes community at large.

Communications deliverables that come from the release process include a release blog, an optional Deprecations and Removals blog, facilitation of a feature blog series, scheduling of a CNCF Kubernetes release webinar as well as other speaking opportunities, and approved messaging for media. In the event the release schedule slips, the communications coordinator will ensure media opportunities through the CNCF are synchronized and that all stakeholders are kept advised of changes in timing.

## Requirements

**Before continuing on to the Communications specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Skills and Experience Required

- Strong written and verbal communications skills
- A working knowledge of Kubernetes concepts
- Fundamental GitHub skills and experience with open source projects
- Enough experience with the Kubernetes release process to understand how communications milestones fit into the overall release
- Project management experience
- Existing relationships with the CNCF, relevant media personnel and outlets, Kubernetes project managers, and vendor stakeholders is helpful, but not required
- The communications lead should take the [Inclusive Speaker Orientation (LFC101)](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/) training course

### Expected Time Investment

The Kubernetes release cycle spans 14 to 16 weeks (v1.38: 16 weeks); the exact dates are in the release README under [`releases/`](/releases). The typical workload for the communications team is very light during the first few weeks of the release cycle. In the later weeks, **the workload can become heavy, and will continue a few weeks after the release.**

The expected time investment for both leads and shadows are as follows:

- 30 minutes to 2 hours a day (depending upon week), requesting and reviewing incoming KEPs and blog PRs, working with other SIGs or the CNCF to manage the feature blog posts, and following Slack channels in order to keep pending content current.

- 1 to 5 hours a week, attending
    - Release Team (weekly)
    - SIG Docs Team (biweekly) and
    - Burndown meetings (daily during Code Freeze).

**NOTE:** These are estimates and your personal experience may vary. The keys to success in this role are collaboration with the team and maintaining regular communication within the team.

## External Release Communication

Please use the `release-comms@kubernetes.io` Google Group list for external release communications (communicating with the CNCF, etc.).

The following groups should be members:
* The current release cycle's Release Team Lead and Lead Shadows
* The current release cycle's Communications Lead and Comms Shadows
* SIG Release Chairs

The list must be rotated and actively managed every cycle. Submit a PR to update [`groups/sig-release/groups.yaml`](https://github.com/kubernetes/k8s.io/blob/main/groups/sig-release/groups.yaml) in `kubernetes/k8s.io` per the milestone activities described below.

### Slack Channel

There is a channel on the Kubernetes Slack workspace, `#release-comms`, which is used by the communications release team to coordinate their efforts. If you're on the communications team, or applying to be, then it would be advantageous to follow along with the conversations. The Communications Coordinator (often referred to as the "Comms Lead") should post a status here at a regular cadence to keep release team members and other stakeholders informed.

How a particular team communicates day-to-day is up to the Comms Lead and team members, but usually they Slack DM on day-to-day coordination and post summary updates in `#release-comms`.
A good practice is to also update the `#sig-docs` and `#sig-docs-blog` channels with the status of the release blog, feature blogs, and other deliverables.

For the weekly status post, use the [weekly status update template](templates/weekly-status-update.md). It covers the upcoming deadlines, the team's action items, the feature blog opt-in counts, and who is covering each Release Team meeting slot.

The full list of Slack channels and mailing lists to join is in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md#slack).

## Working with other teams and SIGs

Throughout the release cycle, the comms team works with lots of different teams within the Kubernetes community. As a Comms Lead or member of the comms team, you should feel empowered to reach out and ask questions or ask for help from SIGs and other Release Team members to meet deadlines.

Some groups you may need to contact, on top of the already mentioned SIG Docs (Blog), include:

* SIG Contributor Experience Comms Subproject in the `#sig-contribex-comms` Slack channel and by attending meetings. They can help promote the feature blogs through social media. Also, see the [social posts](#social-posts) section below.
* Chairs and Tech Leads of SIGs in the `#chairs-and-techleads` Slack channel. This can be a helpful place to post reminders about blog deadlines for SIG leads to see.

## Release deliverables

Throughout the release cycle, the main Communications deliverables include:
* **Collection of Release Highlights.** The Communications team coordinates with SIG Leads to solicit Release Highlights for the release, to be used in both the Release Blog and Release Notes.
* **Authoring the Kubernetes release blog.** The Communications team writes the release blog, which is the official announcement of the Kubernetes release. This includes the Release Highlights from SIG leads.
* **Coordination and support of the feature blog series.** SIGs opt in to author feature blogs for the release. These blogs are written by technical owners, and the Communications team supports authors from the early stages through facilitating editorial and tech reviews as well as publication.
* **Coordination and support of an optional Deprecations and Removals blog.** Depending upon the content of a given release, it may be necessary to prepare the community for upcoming deprecations and removals. This is decided per release cycle once the list of enhancements is known after Enhancements Freeze.
* **Scheduling press activities and the post-release webinar with the CNCF.** The Communications Coordinator works with the CNCF to schedule press release activities around the release, and to schedule the release webinar (typically scheduled 3-4 weeks post-release).

### Collect Release Highlights

A GitHub Discussion must be open to invite all SIG leads and members to add Release Highlights for inclusion in the Release Blog and Release Notes. The discussion must be opened in kubernetes/sig-release under the General category, using the [Release Highlights discussion template](templates/release-highlights-discussion.md). Track the outreach to SIGs with the [Release Highlights tracking issue template](templates/release-highlights-tracking-issue.md) and the [SIG Slack message template](templates/sig-release-highlight-message.md).

Past discussions: [v1.37](https://github.com/kubernetes/sig-release/discussions/3051), [v1.34](https://github.com/kubernetes/sig-release/discussions/2806), [v1.33](https://github.com/kubernetes/sig-release/discussions/2734).

Each SIG should be pinged via their individual Slack channels and the `#chairs-and-techleads` channel to solicit suggestions, and each KEP owner can be asked about inclusion as a Release Highlight at the same time Feature Blogs are being solicited.

For each submission, SIG representatives should provide:
- A link to the KEP
- The stage the feature is moving to
- A brief description of the KEP that will be used as an outline for the blog post content

The Communications team should hold a meeting to discuss Release Highlights sometime around Code Freeze. Ensure that at least one person from the Docs team attends this meeting with the Release Team Lead and Enhancements Lead.

**NOT EVERY KEP NEEDS A HIGHLIGHT**. Work with the SIG owners and Release Team to make sure all highlights gathered in the discussion actually need a section in the release announcement blog.

### Release blog

The Communications Coordinator along with the Comms shadows are responsible for authoring the official Kubernetes Release blog. This blog is the official statement of release. The release blog is the primary vehicle by which the release team communicates the release highlights, known issues, and other aspects of the release to the community.

Start the draft with the team the week before Code Freeze (v1.38 example: week 11), striking a balance between the enhancements being close to finalized and having enough time to author the blog and have it reviewed. Ahead of review, open a pull request on the [website repository](https://github.com/kubernetes/website) and assign the Release Team Lead and other stakeholders as reviewers.

It's up to you and your team regarding how best to do this. Typically it works well to assign sections to different team members and have the lead pull it all together and manage the PR and reviews. You can work on a draft in Google Docs or [HackMD](https://hackmd.io/), then move into the PR when content is more finalized. It's also recommended to get KEP authors or SIG Leads to provide 1-2 paragraph descriptions of KEP changes as a starting point for the release blog. This is an easier starting point for putting the whole release blog together.

The Release Team Lead will drive the content for the release theme and logo.

#### Process to publish the release blog

1. Open a PR against [k/website](https://github.com/kubernetes/website) targeting the `main` branch, and adding a front matter with `draft: true`. This flag will ensure that the blog will not be published even if it passes the target publication date, but available from the CI build for PRs. Set no `date` parameter, and include the `release_announcement` parameter along with the `themes` parameter with the release code name, if applicable:

  ```yaml
  release_announcement:
    minor_version: "<major>.<minor>"
    themes:
      - "Release CodeName 1"
  ```

2. The PR has to be reviewed by the SIG Docs Blog team, which will provide a content and style review. SIG chairs and tech leads will provide a tech review. After `lgtm` and `approve` labels are applied, the blog can be merged to the `main` branch. With the `draft: true` flag, this blog will not be published to the website.

3. In a second PR opened (ideally) a week before the release day, the Comms Lead will:
- remove the `draft: true` parameter
- add the `date` parameter, set to the release date
- add the release logo and theme to the final release blog

> [!IMPORTANT]
> Because of the merge freeze in place, this PR will need to be merged by the Docs Lead, triggering the `/unhold` command on the release day. The Comms Lead just has to make sure that the PR is ready for merge with all the checks passed and required `lgtm` and `approve` labels applied.

An example of this final PR can be found [here](https://github.com/kubernetes/website/pull/51991/files).

4. The release blog will be published on the Kubernetes blog on the agreed date.

5. Once the release blog is published, the Comms Lead should share the blog in `#announcements` ([example](https://kubernetes.slack.com/archives/C9T0QMNG4/p1756378122306569)) and `#release-comms` ([example](https://kubernetes.slack.com/archives/CNT9Y603D/p1756388540054189)) Slack channels. To get access to write in `#announcements`, please reach out to the Slack admins in `#slack-admins`.

### Feature blogs

Tracking, facilitating, and organizing the publication of the Feature Blog series is a major deliverable of the Comms team. Feature blogs are opt-in for SIGs, and are authored by enhancement developers and others close to the features. We do, however, need to encourage owners of important enhancements to opt in to writing feature blogs.

Examples of enhancements that warrant a feature blog might include:
* breaking changes
* features and changes important to our users
* features that have been in progress for a long time and are graduating
* features that are considered mandatory by the Release Team Lead.

There have been instances where blogs covering breaking changes for a future release have to be published.
There are two options for blogs covering breaking changes. They can be published as a regular feature blog (post-release communication) with the standard front matter. Alternatively, if the blog needs to go out before the release announcement, it can be published without the version prefix in the front matter and then linked in the release notes or announcement blog post.

It helps to work closely with the Release Team Lead and use the respective SIG Slack channels to remind the SIGs about opting in to feature blogs and provide any necessary context to blog authors.

Feature blogs are tracked in two places: the opt-in status and placeholder PR for each KEP live on the Release Tracking Board (linked as `releasetracking` from the `links.md` file in the current [release directory](/releases), i.e. `releases/release-1.XX/links.md#releasetracking`), and the comms team's own view of the work lives on the Comms Project Board, which the Comms Lead copies from the previous cycle at the start of the release (see [Release Milestone Activities](#release-milestone-activities)).

**Reach out in KEP issues to ask for feature blog opt-in.** Ask every KEP owner if they want to contribute a blog by reaching out in the KEP issue. Example messaging can be found in the [feature blog messages template](templates/feature-blog-messages.md).

> [!IMPORTANT]
> **Make sure to proactively track PRs raised against the k/website repository.** Feature blog authors sometimes open PRs on [kubernetes/website](https://github.com/kubernetes/website/pulls?q=is%3Apr+is%3Aopen+label%3Ablog) with the `blog` label independently before or during the comms team's outreach process without notifying anyone in the KEP thread. These PRs will not appear on the Release Tracking Board and can be missed entirely if the team only tracks blogs sourced from direct responses. Starting from the Enhancements Freeze and continuing through the Feature blog freeze, it is important to regularly check for open PRs labeled `blog` on the k/website repository and cross-reference them against the Release Tracking Board. Any PRs not already tracked should be added, assigned to a comms team member, and any further outreach must be conducted via the blog PR (not the KEP issue).

**NOT EVERY KEP NEEDS A BLOG**. Work with the KEP owners, Release Team Lead, and SIG Docs Blog team (through the `#sig-docs-blog` Slack channel) to make sure all KEPs that opt in really need a blog written. If a feature is small, or new in Alpha, it may not be ready for a blog. You should also encourage important features to sign up to write a blog. Try to limit the number of blogs to 15 or fewer.

**As feature blogs are opted in and placeholder PRs are created**, assign the blogs to shadows and yourself for tracking and facilitation. Prior to assigning blogs to shadows, you will need to ensure that they are listed under the **"Comms Opt-in Assignee"** and the **"Comms Editor"** fields through the Release Tracking Board's settings. The Comms team is responsible for making sure blog authors have the resources and information they need to write the blog, and tracking the blog's progress through editorial and tech reviews once the blog is ready. After a blog placeholder PR has been created, you should switch to using the placeholder PR for contacting authors on GitHub instead of the KEP issue.

> Some features that opt in to writing a blog may miss the Code Freeze deadline. Blog placeholder PRs for features that are no longer in the release should be closed.

When a placeholder PR is created, make sure the PR has been opened using a `draft: true` parameter in its metadata.

Once the placeholder PRs are open, **assign a writing buddy to each PR as needed**. Select the writing buddy from the KEP authors of the other open placeholder PRs and pair them up. The writing buddy will act as a peer reviewer and provide support for the main author of the feature blog. Some feature blog PRs are written collaboratively within SIGs or are opened with the blog content already complete; these may not need a writing buddy.
For more information about the writing buddy assignment process and their role, please refer to [this documentation page](https://kubernetes.io/docs/contribute/blog/writing-buddy/).
Example messaging can be found in the [writing buddy assignment template](templates/writing-buddy-assignment.md).

#### Feature blog PR instructions for authors

The blog author has to open a PR against [k/website](https://github.com/kubernetes/website) targeting the `main` branch (**not a dev branch**), and adding a front matter with `draft: true`. The following front matter is suggested, the `draft: true` parameter is required to keep the blog from being published before it's ready:
```yaml
---
layout: blog
title: 'Kubernetes v1.<minor>: <title>'
draft: true
slug: kubernetes-v1-<minor>-<slug>
author: <author>
---
```

#### Creating a blog publication schedule

**The Comms team establishes the feature blog publication schedule.** Other members of the release team or blog reviewers may contribute ideas and feedback on the schedule, but ultimately the schedule is determined by the Comms team.

Use the blog schedule field in the Feature Blog view on the Release Tracking Board to assign a publication date.

Feature blog publication usually starts the day after the release. The release blog goes out on the same day as the release and the first feature blog typically goes out the day after the release. The rest of the blogs are published one per weekday, so each post gets its own day of attention.

**Publish Monday to Friday, and work around major global holidays.** Posts that land on a weekend or a public holiday get less reach, and reviewers are harder to reach if a published post needs a fix. Before you commit to the schedule, check the weeks after the release for holidays that affect a large part of the community, and shift the affected post(s) to the next working day. The note on KubeCons, holidays and `#sig-docs-blog` review capacity in [Release Milestone Activities](#release-milestone-activities) applies to this schedule too.

**The team decides the ordering.** There is no required order, so pick the approach that tells the best story for the release and apply it consistently. Common approaches:

- **By impact**, leading with the changes that affect the most users.
- **Grouped by feature area**, so related posts land together, for example a single post covering a family of related changes.
- **Grouped by the stage of the features covered**, for example Stable first, then Beta, then Alpha.

These combine well: a schedule can run Stable first and then Beta, while still grouping one feature family into a single post that spans stages. State which approach you used when you post the schedule in `#sig-docs-blog`, so authors and reviewers understand why a post sits where it does.

Publishing every feature blog at the same time of day also helps readers and makes the schedule easier to keep straight.

> Note that blog PRs in k/website are dated, and automation will publish future-dated entries. This decouples the review and merge of a blog from its publication date: reviewed feature blogs are merged as drafts before the release, and a single scheduling PR before release day removes the draft flags and sets the publication dates. See [Process to publish opt-in feature blogs](#process-to-publish-opt-in-feature-blogs).

**Communicate the planned publish date to SIG Docs**. Notify the following Slack channels: `#sig-docs-blog` and `#sig-docs` about the schedule. The communications team will assist in coordinating and publishing the feature blogs on schedule.

Please note that the release team will support the blog publication after the release day too.

#### Feature blog reviews

Also see the docs for [pull requests review process](https://kubernetes.io/docs/contribute/review/reviewing-prs/) and [reviewing a pull request](https://kubernetes.io/docs/contribute/review/for-approvers/#reviewing-a-pr).

**Work closely with the [SIG Docs Blog](https://github.com/kubernetes/community/tree/master/sig-docs/blog-subproject) subproject.** These are the folks responsible for editorial reviews (and sometimes tech reviews) of Kubernetes blogs. The Comms Lead should plan to regularly share updates on blog status and review timelines with the blog reviewers via `#sig-docs-blog` and during SIG Docs meetings.

Each blog should pass 2 official reviews, an editorial review and a tech review. Anyone is welcome to do an "informal" review on any blog and leave suggestions. As part of the comms team, it's encouraged (but not required) to help review blogs for both editorial and technical correctness, if you have time.

An official review comes from someone with [permission to add the lgtm label](https://kubernetes.io/docs/contribute/review/for-approvers/#prow-commands-for-reviewing) to a pull request.
* **Tech reviews** usually come from the sponsoring SIG. If you don't see a tech review on the blog, reach out to the author to make sure the PR has been flagged for review. You can also reach out in the SIG Slack channel to ask for help with tech reviews.
* **Editorial reviews** usually come from blog reviewers or SIG Docs reviewers. They make sure that the blog is readable and adheres to the [style guide](https://kubernetes.io/docs/contribute/style/style-guide/). You can also reach out to the SIG Docs [PR wrangler](https://kubernetes.io/docs/contribute/participate/pr-wranglers/), for help getting reviews or approvals on PRs. See the [PR wrangler schedule](https://github.com/kubernetes/website/wiki/PR-Wranglers) for more details.

Once a blog has the `lgtm` label added, an [approver](https://kubernetes.io/docs/contribute/participate/roles-and-responsibilities/#approvers) can add the `approve` label to get the PR merged. Note that reviews can still happen on blogs with a `lgtm` label.

Aim to have all blogs reviewed and approved (merged) by release day. But note that it's common for some blog reviews to continue past the release day.

#### Process to publish opt-in feature blogs

1. The PRs with blog contents have to be reviewed by the SIG Docs Blog team, which will provide a content and style review. A tech review is mandatory and has to be performed by the SIG that owns that KEP. After these reviews, the blogs will be merged in the `main` branch, in draft mode, so not visible on the Kubernetes blog.

2. All feature blogs will be scheduled for publication in a bulk PR opened (ideally) a week before the release day, the Comms team will:
- remove the `draft: true` parameter from the metadata of all feature blogs
- ensure the date parameter is set to the agreed publication date
- rename all the files and folders to follow the date convention, according to the schedule agreed with SIG Docs Blog.
- ensure title and slug are correct

3. This publication PR has to be reviewed and approved by the SIG Docs Blog team. After `lgtm` and `approve` labels are applied, the blog will be merged in the `main` branch.

4. The feature blogs will be published in kubernetes.io/blog on the dates agreed in the schedule.

_Note: content fixes are possible for feature blogs but handled by the author and SIG Docs Blog, separately._

### Deprecations and Removals blog

This blog is OPTIONAL and will vary from release to release. It is published as the "Kubernetes v1.XX sneak peek" post and covers the deprecations, removals and other upcoming changes the community should prepare for. Its content is agreed upon by the Comms Lead, Enhancements Lead, and Release Team Lead.

Decide with the rest of the release team whether the blog is warranted once the list of enhancements is known after Enhancements Freeze. Generally, this is decided at a minimum of two deprecations or removals, or if there are significant deprecations and removals that will impact the community, or if there's a desire to inform about the release status mid cycle.

If so, facilitate its creation and publication. You can create a Slack thread on [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) and `#sig-docs-blog` to discuss this.

Timing:
- Solicit authors and open a placeholder PR in k/website well ahead of Code Freeze.
- Have the draft ready for SIG Docs Blog review around Code Freeze, so that the content reflects what actually made it into the release.
- Publish on the Monday of the week after Code Freeze (v1.38 example: week 13). The release schedule lists this as "Deprecations and Removals blog published".

Follow these examples:
- [Kubernetes v1.33 sneak peek](https://kubernetes.io/blog/2025/03/26/kubernetes-v1-33-upcoming-changes/)
- [Kubernetes v1.32 sneak peek](https://kubernetes.io/blog/2024/11/08/kubernetes-1-32-upcoming-changes/)
- [Kubernetes Removals and Major Changes In 1.25](https://kubernetes.io/blog/2022/08/04/upcoming-changes-in-kubernetes-1-25/)
- [Kubernetes API and Feature Removals in 1.22](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/)

Use the [Deprecations and Removals blog template](templates/mid-cycle-blog-sneak-peek.md) as a starting point.

### Press and release webinar

This is a simple but very important component of the Communications Coordinator role. Two sets of activities need to be scheduled with the CNCF:
- press release and interview scheduling around the release day
- the release webinar after the release.

You will be a liaison between the Release Team Lead and the CNCF contacts to schedule the press briefings. Send an email to `pr@cncf.io` around Code Freeze, about a month ahead of the release (v1.38 example: week 12), and coordinate between the parties to get release day press events scheduled.

See the [sample press email](templates/pr-email.md) for scheduling press and pre-briefings for the Release Team Lead.

To schedule the release webinar with the CNCF, start a conversation with an email to `webinars@cncf.io` at the same time. You may be referred to [CNCF's marketing form](http://marketingform.cncf.io/) to request a "live webinar". If things are tight on the schedule, CNCF will help find a spot.

See the [sample webinar email](templates/webinar-email.md) for reference.

The webinar is typically scheduled for 3-4 weeks after the release and is primarily presented by the Release Team Lead and Enhancements Lead. Often the Comms Lead will also join the webinar. The format is open, but primarily the team walks through the enhancements in the release and gives a sneak peek of what's coming in the next release.

Refer to past [slides](/releases/release-1.37/Kubernetes%20v1.37%20Release%20Webinar.pdf) and [webinars](https://www.youtube.com/live/1hOOplxu6g0?si=DqvJD9MpS3fr4vLh) as an example.

_Note: you'll need to send headshots and company/title information when you schedule the webinar and the slides should be ready at least one week ahead of the webinar._

The Release Team Lead is probably the best person to put together the slides, but the Release Team Lead, Comms Lead, and Enhancements Lead for a release can decide on the best way to pull the presentation together.

For the 1.31 release the Release Team Lead and Enhancements Lead created the slides 1 week before the webinar was scheduled. They then had a quick 10 minute meeting to talk about how to run through the slides on the webinar. Release Team Lead and Enhancements Lead alternated on each slide and mostly just read out the content on the slides and maybe added a little more context.

As a Comms Lead you don't have to talk on the presentation, but you can if you want to.
The presentation isn't intended to be very technical. Just an overview of the changes. The listeners may have questions but it's perfectly fine to direct them to read the KEP or ask in the SIG Slack channel to get more information. So there is no need to be an expert on any of the changes. The CNCF has a moderator on the webinar with you to help with running it, recording, and managing the chat. They don't need the slides ahead of time, you just show up with the slides to the webinar.

### Tips and tricks

See the [tips and tricks](tips-and-tricks.md) page for advice that may help you succeed in this role.

### Social posts

The Release Communications team is **NOT** responsible for social posting. [SIG Contributor Experience](https://github.com/kubernetes/community/tree/master/sig-contributor-experience) (SIG Contribex) manages the official Kubernetes social accounts and is responsible for all posts to those accounts. SIG Contribex has created automation around blog posts, so once a blog is published to the Kubernetes website, social posts are created and posted according to SIG Contribex's automation schedule.

If the Communications team and Release Team Lead determine a feature or other release communication needs more detailed communications or calls to action, reach out to the SIG Contributor Experience Comms Subproject for help making posts, using the `@contributor-comms` tag in the `#sig-contribex-comms` Slack channel.

## Release Milestone Activities

This is the narrative of a typical release cycle and the order in which tasks flow for Comms, keyed to the release milestones. Week numbers are given as examples from the v1.38 cycle; each release is a little different, so always refer to the specific release schedule in [`releases/release-1.XX/README.md`](/releases) for exact dates and deadlines.

The per-cycle checklist with checkboxes is the [Release Comms Subteam Cycle Progress issue template](/.github/ISSUE_TEMPLATE/release-comms-subteam-progress.md). Open one at the start of the cycle ([new issue](https://github.com/kubernetes/sig-release/issues/new?template=release-comms-subteam-progress.md)) and keep it updated; the v1.37 issue is [kubernetes/sig-release#3027](https://github.com/kubernetes/sig-release/issues/3027). If a task in this narrative is missing from the template, or the other way around, update both.

### Start of the release cycle (v1.38 example: weeks 1-3)

- Start attending the Release Team weekly meeting.
- Join the Slack channels and mailing lists listed in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md#slack).
- Check if there are any holidays or events (e.g. KubeCon) that will occur during this release which may impact communication with the CNCF and SIG Chairs, and plan accordingly.
- Select shadows for the team and onboard them: ensure they are all in the Kubernetes org on GitHub, entered into the release contact sheet, on the release team meeting invites, and listed in `releases/release-1.XX/release-team.md`.
- Update the `k/org` [`config/kubernetes/sig-release/teams.yaml`](https://github.com/kubernetes/org/blob/main/config/kubernetes/sig-release/teams.yaml) with the lead and shadows so they get access to the project boards and are listed as milestone maintainers.
- Set up the Comms Project Board by copying the previous cycle's "Comms - All" and "Comms - Feature Blogs" boards, adjust the filters so anyone can find the current feature blog status, and align the field values with the new Comms team members.
- Establish an initial meeting with the Comms team to introduce everyone and review tasks and the release timeline.
- Plan a regular-cadence Comms team sync up (mostly needed toward the end of the cycle).
- Update the `release-comms` Google Group. [Membership](https://github.com/kubernetes/k8s.io/blob/main/groups/sig-release/groups.yaml) for this group is defined in [kubernetes/k8s.io](https://git.k8s.io/k8s.io). Ensure the list **only includes** the current release cycle's Release Team Lead and Lead Shadows, the current release cycle's Communications Lead and Comms Shadows, and the SIG Release Chairs.
- Start communications with the SIG leads to align on the communications timeline and support for writing feature posts.
- Set up a communications plan aligned with the Release Calendar.
- Agree on participation together with the Enhancements Lead at the next SIG Leads monthly meeting to align on expectations and communication possibilities.

### KEP Readiness Deadline (v1.38 example: week 4)

- Get access to the Release Tracking Board and start following along. Edit the `Comms Opt-in Assignee` and `Comms Editor` fields with everyone on the comms team.

### Enhancements Freeze (v1.38 example: week 5)

- Work with the Enhancements Lead to understand big-ticket items to be included in the release.
- Start monitoring the Release Tracking Board for new feature blog opt-ins and use the blog status field to assign and track status throughout the cycle.
- Begin monitoring open PRs labeled `blog` on [kubernetes/website](https://github.com/kubernetes/website/pulls?q=is%3Apr+is%3Aopen+label%3Ablog) for feature blog PRs that were opened before or outside of the formal opt-in process; add any untracked PRs to the Release Tracking Board.
- With Enhancements Freeze in effect, create a GitHub discussion to start collecting the Release Highlights of the release (see [Collect Release Highlights](#collect-release-highlights)), and reach out to all SIGs on and off over the next few weeks to ask for Release Highlights and explain why this is important to the community.
- Start reaching out to every KEP owner for feature blog opt-in.
- Work with the Enhancements Lead and Docs Lead to determine which deliverables are most noteworthy post-Enhancements Freeze. In the coming weeks, follow the progress of these enhancements, as they will roll into the Release Highlights and be called out and described in the release blog.
- Work with the Release Team and decide if the release warrants a [Deprecations and Removals blog](#deprecations-and-removals-blog). If needed, solicit author(s) and get a placeholder PR in k/website for tracking.

### Mid-cycle, before the Feature blog freeze (v1.38 example: weeks 6-9)

- Post reminders for the feature blog opt-in on the SIG Slack channels and in the KEP issues.
- Assign feature blog topics as they come in to team shadows for support and tracking efforts.
- Share the current status of the feature blog opt-ins in `#sig-docs-blog` and in the SIG Docs call, and work with the team to establish review expectations and publication strategy.
- Facilitate or start writing the optional Deprecations and Removals blog.
- Coordinate with the Docs Lead to ensure Release Highlights are checked in before Code Freeze.

### Feature blog freeze (v1.38 example: week 10)

- Send out final reminders for the feature blog opt-in and request placeholder PRs in k/website from all feature blog authors.
- Assign remaining feature blog topics and clarify the assignments in the `Comms Editor` field.
- Assign writing buddies to placeholder PRs as needed.
- The week after the Feature blog freeze (v1.38 example: week 11), start the [release blog](#release-blog) draft with the team.

### Code Freeze (v1.38 example: week 12)

- Start attending burndown meetings (they begin the week after Code Freeze); the lead or shadows will be asked to provide the comms status.
- Participate in the release retro part 1, held in the first week of burndown meetings after Code Freeze (v1.38 example: week 13).
- Continue the release blog draft started the week before.
- Establish the feature blog post-release publication schedule of one post per weekday starting the day after the release blog, working around major global holidays, and post it in `#sig-docs-blog`.
- Establish a regular cadence status check-in with the `#sig-docs-blog` team and maintain the publication schedule post in Slack to keep everyone synced.
- Host a meeting with the Release Team Lead, Enhancements Lead, and Docs Lead to discuss the Release Highlights to be featured in the release blog and ensure consistency with the Release Notes.
- Review the feature blog assignments following Code Freeze, close placeholder PRs for features that dropped out of the release, and re-assign as necessary.
- Have the optional Deprecations and Removals blog ready for review.
- Schedule the release live webinar with the CNCF by emailing `webinars@cncf.io`.
- Schedule press and analyst pre-briefings and interviews for the Release Team Lead with the CNCF by emailing `pr@cncf.io`.
- Schedule the release blog and press embargo with the CNCF.
- Start the conversation about who will be the next Comms Lead (see [Release Team Selection](/release-team/release-team-selection.md)).

### Release Highlights deadline and Deprecations and Removals blog (v1.38 example: week 13)

- Publish the Deprecations and Removals blog on the Monday of the week after Code Freeze.
- Make sure the Release Highlights details are shared in the discussion, for transparency across the whole Release Team.
- Update the release blog draft, post-Code Freeze, and share the Release Highlights with the team so each member can take a handful of sections.
- Check status with the Docs Lead on content for the Known Issues section of the release blog.
- Check status on all feature blog PRs. Keep `#sig-docs-blog` up to date for editorial review, and establish that tech reviewers are available.

### Feature blogs ready to review (v1.38 example: week 14)

- Feature blog reviews start.
- Continue to partner with `#sig-docs-blog` for editorial review, and work to ensure tech reviews are moving forward from SIGs.
- Connect with the Release Team Lead to ensure the theme and release logo will be ready for the release blog (not required for draft revisions).
- Ensure that short one-to-two paragraph summaries of each Release Highlight are available for the release blog from the Docs Lead or SIG Chairs.
- Finalize the release blog draft and start reviews; share the PR in `#chairs-and-techleads` to get technical reviews.
- Send the release blog draft to the CNCF.

### Release blog ready to review (v1.38 example: week 15)

- Ensure the release blog PR main write-up is merged (as a draft) and that the final publishing PR is ready for the Docs Lead to unhold on release day (see [Process to publish the release blog](#process-to-publish-the-release-blog)).
- Open the bulk scheduling PR for the feature blogs and ensure review and merge plans are in place for any still outstanding.

### Release day and after (v1.38 example: week 16 onwards)

- Update the release blog with the logo and release name, and once it is published, post in `#announcements` and `#release-comms`.
- Continue to facilitate publication of the remaining feature blogs, until all PRs are merged with the right publication date.
- Participate in release retro parts 2 and 3 (as needed).
- Organize the slides for the CNCF release webinar, send them to the CNCF for review at least one week ahead of the scheduled date, and add the deck to `releases/release-1.XX/` afterwards.
- Confirm the next Comms Lead with the incoming Release Team Lead.
- Close all outstanding tickets: the progress issue, the Release Highlights discussion and tracking issue, and any post-release handbook or template update PRs.
- Update this document!
- Rest, you did a great job :)

Remember to consider (whenever possible) KubeCons, holidays (e.g. American Thanksgiving), `#sig-docs-blog` review capacity and other events that may impact the release cycle for Comms and adjust the schedule accordingly.

## Release Blog Outline and Templates

To support you in the creation of the release blog, this [outline](templates/release-blog.md) summarizes ideas for sections and gives you a template for easier release blog creation.

There are other templates available in the [templates folder](templates/), such as:
- [Weekly status update](templates/weekly-status-update.md)
- [Deprecations and Removals blog template](templates/mid-cycle-blog-sneak-peek.md)
- [Release Highlights discussion](templates/release-highlights-discussion.md)
- [Release Highlights tracking issue](templates/release-highlights-tracking-issue.md)
- [Release Highlights SIG message](templates/sig-release-highlight-message.md)
- [Feature blog messages](templates/feature-blog-messages.md)
- [Writing buddy assignment](templates/writing-buddy-assignment.md)
- [Mail for the CNCF webinar](templates/webinar-email.md)
- [Mail to coordinate the PR with the CNCF](templates/pr-email.md)

## Examples from the latest cycle

Refresh this list at the end of every cycle so the handbook always points at one recent example of each deliverable.

- Release Comms Subteam Cycle Progress issue: [v1.37](https://github.com/kubernetes/sig-release/issues/3027)
- Release blog: [Kubernetes v1.37: Garhwal](https://kubernetes.io/blog/2026/08/26/kubernetes-v1-37-release/)
- Deprecations and Removals blog: [Kubernetes v1.33 sneak peek](https://kubernetes.io/blog/2025/03/26/kubernetes-v1-33-upcoming-changes/)
- Release Highlights discussion: [v1.37](https://github.com/kubernetes/sig-release/discussions/3051)
- Release Highlights tracking issue: [v1.37](https://github.com/kubernetes/sig-release/issues/3052)
- Release webinar deck: [v1.37](/releases/release-1.37/Kubernetes%20v1.37%20Release%20Webinar.pdf)
- Feature blog publication schedule post: [v1.22 example in `#sig-docs-blog`](https://kubernetes.slack.com/archives/CJDHVD54J/p1628649661040600)
- Handbook update PR from an outgoing Comms Lead: [v1.32](https://github.com/kubernetes/sig-release/pull/2624)
