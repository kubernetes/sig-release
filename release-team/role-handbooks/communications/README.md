# Kubernetes Release Team: Communications Coordinator

## Overview

The Communications Coordinator role is responsible for facilitating, empowering, and curating communication between the release team and various stakeholders including the Cloud Native Computing Foundation (CNCF), the media, contributing vendors, Kubernetes project managers, and the overall Kubernetes community at large.

Communications deliverables that come from the release process include a release blog, an optional removals and deprecations blog, facilitation of a feature blog series, scheduling of a CNCF Kubernetes release webinar as well as other speaking opportunities, and approved messaging for media. In the event the release schedule slips, the communications coordinator will ensure media opportunities through the CNCF are synchronized and that all stakeholders are kept advised of changes in timing.

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

The Kubernetes release cycle spans 15 weeks, however it may run longer. The typical workload for the communications team is very light during the first few weeks of the release cycle. In the later weeks, **the workload can become heavy, and will continue a few weeks after the release.**

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
* The current release cycle's Release Team Lead & Lead Shadows
* The current release cycle's Communications Lead & Comms Shadows
* SIG Release Chairs

The list must rotated/actively managed every cycle. Submit a PR to update [this document](https://git.k8s.io/k8s.io/groups/groups.yaml) per the milestone activities described below.

### Slack Channel

There is a channel on the Kubernetes Slack workspace, `#release-comms`, which is used by the communications release team to coordinate their efforts. If you're on the communications team, or applying to be, then it would be advantageous to follow along with the conversations. The Communications Coordinator (often referred to as the "Comms Lead") should post a status here at a regular cadence to keep release team members and other stakeholders informed.

How a particular team communicates day-to-day is up to the Comms Lead and teams members, but usually they Slack DM on day-to-day coordination and post summary updates in `#release-comms`.
A good practice is to also update `#sig-docs` and `#sig-docs-blogs` channels with the status of the release blog, feature blogs, and other deliverables.

## Working with other teams and SIGs

Throughout the release cycle, the comms team works with lots of different teams within the Kubernetes community. As a Comms lead or member of the comms team, you should feel empowered to reach out and ask questions or ask for help from SIGs and other Release team members to meet deadlines.

Some groups you may need to contact, on top of the already mentioned SIG Docs (Blog), include:

* SIG Contributor Experience in the `#sig-contribex` slack channel and by attending meetings. They can help promote the feature blogs through social media. Also, see the special posts section below.
* Chairs and Tech Leads of SIGs in the `#chairs-and-techleads` Slack channel. This can be a helpful place to post reminders about blog deadlines SIG leads to see.

## Release deliverables

Throughout the release cycle, the main Communications deliverables include:
* **Collection of Release Highlights.** The Communications team coordinates with SIG Leads to solicit Release Highlights for the release, to be used in both the Release Blog and Release Notes.
* **Authoring the Kubernetes release blog.** The Communications team writes the release blog, which is the official announcement of the Kubernetes release. This includes the Release Highlights from SIG leads.
* **Coordination and support of the feature blog series.** SIGs opt-in to author feature blogs for the release. These blogs are written by technical owners, and the Communications team supports authors from the early stages through facilitating editorial and tech reviews as well as publication.
* **Coordination and support of an optional Mid-Cycle / Deprecations and Removals blog.** Depending upon the content of a given release, it may be necessary to prepare the community for upcoming deprecations and removals. This is decided per release cycle around the time of Code Freeze.
* **Scheduling press activities and the post-release webinar with the CNCF.** The Communications Coordinator works with the CNCF to schedule press release activities around the release, and to schedule the release webinar (typically scheduled 3-4 weeks post-release).

### Collect Release Highlights

A GitHub Discussion must be open to invite all SIG leads and members to add Release Highlights for inclusion in the Release Blog and Release Notes. The discussion must be opened in kubernetes/sig-release under General Category. 

Past discussions: [1.32](https://github.com/kubernetes/sig-release/discussions/2639), [1.25](https://github.com/kubernetes/sig-release/pull/1987), [1.24](https://github.com/kubernetes/sig-release/discussions/1868), [1.23](https://github.com/kubernetes/sig-release/discussions/1709), [1.22](https://github.com/kubernetes/sig-release/discussions/1575), [1.21](https://github.com/kubernetes/sig-release/discussions/1436).

Each SIG should be pinged via their individual Slack channels and the `#chairs-and-techleads` channel to solicit suggestions, and each KEP owner can be asked about inclusion as a Release Highlight at the same time Feature Blogs are being solicited.

The Communications team should hold a meeting to discuss Release Highlights sometime around Code Freeze. Ensure that at least one person from the Docs/Release Notes team attends this meeting with the Release Lead and Enhancements Lead.


### Release blog

The Communications Coordinator along with the Comms shadows are responsible for authoring the official Kubernetes Release blog. This blog is the official statement of release. The release blog is the primary vehicle by which the release team communicates the release highlights, known issues, and other aspects of the release to the community. 

Start the draft with the team around week 11, striking a balance between the enhancements being close to finalized and having enough to time author the blog and have it reviewed. Ahead of review, open a pull request on the [website repository](https://github.com/kubernetes/website) and assign the release lead and other stakeholders as reviewers.

It's up to you and your team regarding how best to do this. Typically it works well to assign sections to different team members and have the lead pull it all together and manage the PR and reviews. You can work on a draft in Google Docs or [Hackmd](https://hackmd.io/), then move into the PR when content is more finalized. It's also recommended to get KEP authors or SIG Leads to provide 1-2 paragraph descriptions of KEP changes as a starting point for the release blog. This is an easier starting point for putting the whole release blog together. 

The release lead will drive the content for the release theme and logo. 

### Feature blogs

Tracking, facilitating, and organizing the publication of the Feature Blog series is a major deliverable of the Comms team. Feature blogs are opt-in for SIGs, and are authored by enhancement developers and others close to the features. We do, however, need to encourage owners of important enhancements to opt in to writing feature blogs. 

Examples of enhancements that warrant a feature blog might include: 
* breaking changes 
* features and changes important to our users 
* features that have been in progress for a long time and are graduating 
* features that are considered mandatory by the Release Lead.

It helps to work closely with the Release Lead and use the respective SIG Slack channels to remind the SIGs about opting in to feature blogs and provide any necessary context to blog authors. 

**Reach out in KEP issues to ask for feature blog opt-in.** Ask every KEP owner if they want to contribute a blog by reaching out in the KEP issue. Example messaging can be found [here](/release-team/role-handbooks/communications/templates/feature-blog-opt-in-message.md).

**NOT EVERY KEP NEEDS A BLOG**. Work with the KEP owners, Release Lead, and SIG Docs Blog team (though #sig-dcos-blog slack channel) to make sure all KEPs that opt-in really need a blog written. If a feature is small, or new in Alpha it may not be ready for a blog. You should also encourage important features to sign up to write a blog. 

**As feature blogs are opted in and placeholder PRs are created**, assign the blogs to shadows and yourself for tracking and facilitation. The Comms team is responsible for making sure blog authors have the resources and information they need to write the blog, and tracking the blogs progress through editorial and tech reviews once the blog is ready. After a blog placeholder PR has been created, you should swtich to using the placeholder PR for contacting authors on GitHub instead of the KEP issue.

> Some features that opt-in to writing a blog may miss the code freeze deadline. Blog placeholder PRs for features that are no longer in the release should be closed.  

When a placeholder PR is created, make sure the PR has been opened using a `draft:true` parameter in its metadata. Feature blogs should not be merged **until after the release date and the comms team has assigned a publication date**.

#### Creating a blog publication schedule

**The Comms team establishes the feature blog publication schedule.** Other members of the release team or blog reviewers may contribute ideas and feedback on the schedule, but ultimately the schedule is determined by the Comms team. 

Use the blog schedule field in the Feature Blog view on the tracking board to assign a publication date.

Feature blog publication usually starts the day after the release. The release blog goes out on same day as the release and the first feature blog typically goes out the day after the release. The rest of the blogs are published one-at-a-time, typically at a rate of two to three posts weekly. Depending on how many feature blogs you have, you may want to publish one per day after the release (excluding weekends). In general, all feature blogs should be published within month of the release day. 

> Note that blog PRs in k/website are dated, and automation will publish future-dated entries. This enables a PR process decoupled from blog publication date. Once a blog has passed the review process and its after the release day, the PR can be merged and will be published on the date on the blog. 

**Communicate the planned publish date to SIG Docs**. Notify the following Slack channels: `#sig-docs-blog`, `#sig-docs` about the schedule. The communications team will assist in coordinating and publishing the feature blogs on schedule.

Please note that the release team will support the blog publication after the release day too. 

#### Feature blog reviews

Also see the docs for [pull requests review process](https://kubernetes.io/docs/contribute/review/reviewing-prs/) and [reviewing a pull request](https://kubernetes.io/docs/contribute/review/for-approvers/#reviewing-a-pr).

**Work closely with the [SIG Docs Blogs](https://github.com/kubernetes/community/tree/master/sig-docs/blog-subproject) team.** These are the folks responsible for editorial reviews (and sometimes tech reviews) of Kubernetes blogs. The Comms lead should plan to regularly share updates on blog status and review timelines with the blog reviewers via `#sig-docs-blogs` and during sig-docs meetings.  

Each blog should pass 2 official reviews, an editorial review and tech review. Anyone is open to do an "informal" review on any blog and leave suggestions. As part of the comms team, it's encouraged (but not required) to help reviews blogs for both editorial and technical correctness, if you have time. 

An official review comes from someone with [permission to add the lgtm label](https://kubernetes.io/docs/contribute/review/for-approvers/#prow-commands-for-reviewing) to a pull request.
* **Tech reviews** usually come from the sponsoring SIG. If you dont see a tech review on the blog, reach out to the author to make sure the PR has been flagged for review. You can also reach out in the SIG slack channel to ask for help with tech reviews. 
* **Editorial reveiws** usually come from blog reviewers or SIG Docs reviewers. They make sure that the blog is readable and adheres to the [style guide](https://kubernetes.io/docs/contribute/style/style-guide/). You can also reach out to the SIG Docs [PR wrangler](https://kubernetes.io/docs/contribute/participate/pr-wranglers/), for help getting reviews or approvals on PRs. See the [PR wrangler schedule](https://github.com/kubernetes/website/wiki/PR-Wranglers) for more details.

Once a blog has the `lgtm` label assigned an [approver] can add the `aprove` label to get the PR merged. Note that reviews can still happen on blogs with a `lgtm` label. 

Aim to have all blogs reviewed and approved by release day. But note that its common for blog reviews to continue past the release day.

#### Process to merge opt-in feature blogs

1. The blog author (including the Comms Lead in case of the final release blog) has to open a PR against the Kubernetes website, targeting the `main` branch, marking the release date, and inserting a `draft: true` parameter in its metadata.

```
---
layout: blog
title: 'Kubernetes v1.32: Penelope'
date: 2024-12-11
slug: kubernetes-v1-32-release
author: >
  [Kubernetes v1.32 Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.32/release-team.md)
draft: true
---
```

Example metadata taken from [this PR](https://github.com/kubernetes/website/pull/48666/files).

2. The PR has to be reviewed by the SIG Docs Blog team, which will provide a content and style review. A tech review is mandatory and has to be performed by the SIG that owns that KEP. After these the blog will be merged in the `main` branch, in draft mode, so not visible on the Kubernetes blog.

3. In a second PR opened (ideally) a week before the release day, the Comms Lead will:
- remove the `draft: true` parameter from the metadata of all release blogs (including the final release blog)
- rename all the files and folders to follow the date convention, according to the schedule agreed with SIG Docs Blog.
- add the release logo and theme to the final release blog

Important: This PR will be merged by the Docs Lead, launching the `/unhold` command on the release day. The Comms Lead just has to make sure that the PR is ready for merge, having all the checks passed and required `lgtm` and `approve` labels applied.

An example of this final PR can be found [here](https://github.com/kubernetes/website/pull/48962/files).

4. The release blog will be published on the Kubernetes blog on the agreed date and the feature opt-in blogs will be published in the following days, according to the schedule.

_Note: content fixes are possible for feature blogs but handled by the author and SIG Docs blog, separately._

### Mid-cycle / deprecations and removals blog

This blog is OPTIONAL and will vary from release to release. Work with the rest of the release team ahead of **the Code Freeze date to determine if a mid-cycle blog focused on feature deprecations and removals is warranted**.
Its content is agreed upon by the Comms Lead, Enhancements Lead, and Release Lead.

If so, facilitate its creation and publication. You can create a Slack thread on [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) and `#sig-docs-blog` to discuss this.

If the release will deprecate important and commonly-used features (or simply a large number of features will be deprecated) or if there's a desire to inform about the release status mid cycle, consider publishing this blog.

Keep in mind that the deadline for a mid-cycle blog has to be **after the code freeze**, at least 4/5 days later to make sure the content of this blog is relevant.

Follow these examples:
- [Kubernetes v1.32 sneak peek](https://kubernetes.io/blog/2024/11/08/kubernetes-1-32-upcoming-changes/)
- [Kubernetes Removals and Major Changes In 1.25](https://kubernetes.io/blog/2022/08/04/upcoming-changes-in-kubernetes-1-25/)
- [Kubernetes API and Feature Removals in 1.22](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/)
- [Deprecated APIs Removed in 1.16](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/)

> Publication should occur ahead of the release in order to inform the community and allow for preparation time. Start the discussion mid-cycle and well ahead of Code Freeze, and target publication for right after the Code Freeze week.

### Press and release webinar

This is a simple but very important component of the Communications Coordinator role. Two sets of activities need to be scheduled with the CNCF:
- press release and interview scheduling around the release day
- the release webinar after the release.

You will be a liaison between the Release lead and the CNCF contacts to schedule the press briefings. Send an email to `pr@cncf.io` about a month ahead of the release (on week 10/11) and coordinate between the parties to get release day press events scheduled.

See the sample email [here](/release-team/role-handbooks/communications/templates/pr-email.md) for schedule press and pre-briefings for the release lead.

To schedule the release webinar with the CNCF, start things with an email to `webinars@cncf.io`. 

See the sample webinar email [here](/release-team/role-handbooks/communications/templates/webinar-email.md) for reference.

You will likely use the Calendly link (below) to schedule a "live webinar". If things are tight on the schedule, CNCF will help find a spot.
The webinar is typically scheduled for 3-4 weeks after the release and is primarily presented by the Release lead and Enhancements lead. Often the Comms lead will also join the webinar. The format is open, but primarily the team walks through the enhancements in the release and gives a sneak peek of what's coming in the next release.

Refer to the [slides](https://docs.google.com/presentation/d/10y65ptwXQrt_0P6sA3TSvRH_c7TGBc8DEHhXRNwi-10/) and [webinar](https://www.youtube.com/watch?v=BTPlVsgO_As) from the 1.22 release as an example.

_Note: you'll need to send headshots and company/title information when you schedule the webinar and the slides should be ready at least one week ahead of the webinar._

---
The Release Lead is probably the best person to put together the slides, but it can also be something the lead, comms lead, and enhancement lead for a release can decided on the best way to pull the presentation together.

For the 1.31 release the release and enhancement lead created the slides 1 week before the webinar was scheduled. We then had a quick 10 minute meeting to talk about how to run through the slides on the webinar. Release Lead and Enhancements Lead alternated on each slide and mostly just read out the content on the slides and maybe added a little more context. 

As a Comms Lead you dont have to talk on the presentation, but you can if you want to.
The presentation isn't intended to be very technical. Just an overview of the changes. The listeners may have questions but its perfectly fine to direct them to read the KEP or asking in the sig-slack channel to get more information. So there is no need to be an expert on any of the changes. The CNCF has a moderator on the webinar with you to help with running it, recording, and managing the chat. They don't need the slides ahead of time, you just show up with the slides to the webinar.

### Tips and tricks

See this file for some [tips and tricks](/release-team/role-handbooks/communications/tips-and-tricks.md) that may help you succeeding in this role.

### Social posts

The Release Communications team is **NOT** responsible for social posting. [SIG Contributor Experience](https://github.com/kubernetes/community/tree/master/sig-contributor-experience) (SIG Contribex) manages the official Kubernetes social accounts and is responsible for all posts to those accounts. SIG Contribex has created automation around blog posts, so once a blog is published to the Kubernetes website, social posts are created and posted according to SIG Contribex's automation schedule. 

If the Communications team and Release Lead determine a feature or other release communication needs a more detailed communications or calls to action, reach out to with SIG Contributor Experience for help making posts use the `@contributor-comms` tag in the `#sig-contribex` Slack channel. 

## Release Milestone Activities

This is an example of a typical release cycle and the order of how tasks will flow for Comms. Note that some tasks may take longer than their designated "release week". Each release is a little different, the following guideline is only a suggestion. You should always refer to the specific release schedule for exact dates and deadlines in a release cycle. 

<table>
    <tr>
        <td><h3><b>Release Week</h3></b></td>
        <td><h3><b>Milestones</h3></b></td>
        <td><h3><b>Activities</h3></b></td>
    </tr>
    <tr>
        <td>1</td>
        <td><b>Start of release cycle</b></td>
        <td>
        <ul>
        <li>Start attending the Release Team weekly meeting
        <li>Join the following Slack channels: <code>#sig-release</code>, <code>#release-comms</code>, <code>#sig-docs</code>, and <code>#sig-docs-blog</code>.
        <li>Check if there are any holidays or events (e.g. KubeCon) that will occur during this release which may impact communication with the CNCF and SIG Chairs, plan accordingly
        <li>Select shadows for the team
        <li>Ensure shadows are all in the Kubernetes org on GitHub
        <li>Ensure you and your shadows are entered into the release contact sheet
        <li>Ensure you and your shadows are on the release team meeting invites
        <li>Establish initial meeting with the Comms team to introduce everyone and review tasks and the release timeline
        <li>Plan a regular-cadence Comms team sync up (mostly needed toward the end of the cycle)
        </ul>
        </ul>
        </td>
    </tr>
    <tr>
        <td>2</td>
        <td></td>
        <td>
        <ul>
        <li>Update the <code>release-comms</code> Group. <a href="https://github.com/kubernetes/k8s.io/blob/main/groups/sig-release/groups.yaml">Membership</a> for this group is defined in <a href="https://git.k8s.io/k8s.io">kubernetes/k8s.io</a>. Ensure the list <b>only includes</b>:
        <ul>
        <li>The current release cycle's Release Team Lead & Lead Shadows
        <li>The current release cycle's Communications Lead & Comms Shadows
        <li>SIG Release Chairs 
        </ul></ul>
        <ul>
        <li>Start communications with the SIG leads to align on the communications timeline and support for writing feature posts
        <li>Setup a communications plan aligned with the Release Calendar
        <li>Agree on participation together with Enhancements team lead at the next SIG Leads monthly meeting to align on expectations and communication possibilities
        </ul>
        </td>
    </tr>
    <tr>
        <td>3</td>
        <td><b>Production Readiness Freeze</b></td>
        <td>
        <ul>
        <li>Get access to the <code>Enhancements</code> and <code>Feature blog opt-in</code> tracking boards and start following along. Edit the <code>Comms Opt-in Assignee</code> and <code>Comms Editor</code> columns with everyone on the comms team.
        </ul>
        </td>
    </tr>
    <tr>
        <td>4</td>
        <td><b>Enhancements Freeze</b></td>
        <td>
        <ul>
        <li>Work with the enhancements lead to understand big-ticket items to be included in the release
        <li>Start monitoring the <code>Feature blog opt-in</code> sheet for new entries and use the <code>Status field</code> to assign and track status throughout the cycle
        <li> With Enhancement freeze in effect, create a GitHub discussion (<a href="https://github.com/kubernetes/sig-release/discussions/2047">example v1.26</a>) to start collecting the Release Highlights of the release, and reach out to all SIGs on and off over the next few weeks to ask for Release Highlights and explain why this is important to the community.
        <ul>
        </ul>
        </ul>
        </td>
    </tr>
    <tr>
        <td>5</td>
        <td></td>
        <td>
        <ul>
        <li>Work with Enhancements and Release Note leads to determine which deliverables are most noteworthy post-Enhancements Freeze
        <li>In the coming weeks, follow the progress of these enhancements, as they will roll into the Release Highlights and be called out and described in the release blog
        <li>Work with the Release Team and decide if the release warrants a mid-cycle 'Deprecations and Removals' blog. Generally, this is decided at a minimum of two deprecations or removals, or if there are significant deprecations and removals that will impact the community. 
        <li>If needed, solicit author(s) for a 'Deprecations and Removals' blog and get a placeholder PR in k/website for tracking
        </ul>
        </td>
    </tr>
    <tr>
        <td>8</td>
        <td></td>
        <td>
        <ul>
        <li>Post reminders for the feature blog opt-in on the SIG slack channels (<a href="https://kubernetes.slack.com/archives/C0BP8PW9G/p1622556913118800">for example</a>)
        <li>Assign feature blog topics as they come in to team shadows for support and tracking efforts
        <li>Join the <code>#sig-docs-blog</code> channel on Slack. Share the current status of the Feature blog opt-in's and in Slack and in the sig-docs call and work with the team to establish review expectations and publication strategy.
        </ul>
        </td>
    </tr>
    <tr>
        <td>10</td>
        <td></td>
        <td>
        <ul>
        <li>Send out final reminders for feature blog opt-in on the SIG slack channels or KEP issues
        <li>Facilitate or start writing the optional Deprecations and Removals blog
        <li>Coordinate with Release Notes to ensure Release Highlights are checked in before Code Freeze.
        </ul>
        </td>
    </tr>
    <tr>
        <td>11</td>
        <td><b>Feature blog freeze</b></td>
        <td>
        <ul>
        <li>Start attending burndown meetings
        <li>Participate in the release retro part 1
        <li>Feature blog freeze is this week
        <li>Assign remaining feature blog topics
        <li>Establish feature blog post-release publication schedule, typically 2-3 posts per week.
        <li>Post the feature blog publication schedule in <code>#sig-docs-blog</code> (<a href="https://kubernetes.slack.com/archives/CJDHVD54J/p1628649661040600">example post</a>)
        <li>Establish a regular cadence status check-in with the <code>#sig-docs-blog</code> team and maintain the publication schedule post in Slack to keep everyone synced
        <li>Request placeholder PRs in k/website from all feature blog authors
        <li>Optional 'Deprecations and Removals' blog ready for review
        </ul>
        </td>
    </tr>
    <tr>
        <td>12</td>
        <td><b>Code Freeze</b></td>
        <td>
        <ul>
        <li>Begin the release blog draft, if not yet started
        <li>Host a meeting with the Release Lead, Enhancements Lead, and Release Notes to discuss the Release Highlights to be highlighted in the release blog and ensure consistency with Release Notes
        <li>Publish the optional 'Mid-Cycle (Deprecations and Removals)' blog
        <li>Schedule the release Live Webinar with CNCF by emailing <code>webinars@cncf.io</code>. You may be referred to <a href="https://calendly.com/cncfonlineprograms">Calendly</a>. The webinar is typically scheduled for 3-4 weeks after the release
        <li>Schedule press and analyst pre-briefings and interviews for the release lead with CNCF by emailing <code>pr@cncf.io</code>
        <li>Schedule release blog and press embargo with CNCF
        </ul>
        </td>
    </tr>
    <tr>
        <td>13</td>
        <td></td>
        <td>
        <ul>
        <li>Finalize and publish the 'Deprecations and Removals' blog once code freeze is in place.
        <li>Update release blog draft, post-Code Freeze
        <li>Check status with Release Notes lead on content for the Known Issues section of the release blog
        <li>Check status on all feature blog PRs. Keep <code>#sig-docs-blog</code> up-to-date for editorial review, and establish tech reviewers are available 
        </ul>
        </td>
    </tr>
    <tr>
        <td>14</td>
        <td><b>Feature Blogs ready to review</b></td>
        <td>
        <ul>
        <li>Feature blog reviews start
        <li>Continue to partner with <code>#sig-docs-blog</code> for editorial review, work to ensure tech reviews are moving forward from SIGs
        <li>Connect with Release Lead to ensure theme and release logo will be ready for release blog (not required for draft revisions)
        <li>Ensure that short one-to-two paragraph summaries of each Release Highlights are available for the release blog from Release Notes lead or SIG Chairs
        <li>Finalize Release blog final draft and start reviews
        <li>Send release blog draft to CNCF
        </ul>
        </td>
    </tr>
    <tr>
        <td>15</td>
        <td><b>Release Week</b></td>
        <td>
        <ul>
        <li>Finalize Release Blog, ensure it's ready for Docs Lead to publish on release day (Docs lead has to unhold the final PR, due to website freeze)
        <li>Ensure feature blogs are ready to publish and that review and merge plans are in place for any still outstanding.
        </ul>
        </td>
    </tr>
    <tr>
        <td>16</td>
        <td><b>Release retrospective</b></td>
        <td>
        <ul>
        <li>Participate in release retro parts 2 and 3 (as needed)
        <li>Organize the slides for the CNCF release webinar, and send to the CNCF for review at least one week ahead of the scheduled date.
        <li>Update this document!
        <li>Rest, you did a great job :)
        </ul>
        </td>
    </tr>
</table>

The table above is a guideline for the release cycle. A realistic outline of the activities for a release cycle is [here](https://github.com/kubernetes/sig-release/issues/2625).

Remember to consider (whenever possible) KubeCons, holidays (e.g. American Thanksgiving), sig-docs-blog review capacity and other events that may impact the release cycle for Comms and adjust the schedule accordingly.

## Release Blog Outline & Templates

To support you in the creation of the release blog this [outline](/release-team/role-handbooks/communications/templates/release-blog.md) summarize ideas for sections and gives you a template for easier release blog creation.

There are other templates available in the [templates folder](/release-team/role-handbooks/communications/templates/), such as:
- [Mid-cycle / deprecations and removal blog template](/release-team/role-handbooks/communications/templates/mid-cycle-blog-sneak-peek.md)
- [Release Highlight Discussion](/release-team/role-handbooks/communications/templates/release-highlight-discussion.md)
- [Release Highlight Tracking Issue](/release-team/role-handbooks/communications/templates/release-highlights-tracking-issue.md)
- [Release Highlight Message](/release-team/role-handbooks/communications/templates/release-highlight-message.md)
- [Feature blog opt-in message](/release-team/role-handbooks/communications/templates/feature-blog-opt-in-message.md)
- [Mail for the CNCF webinar](/release-team/role-handbooks/communications/templates/webinar-email.md)
- [Mail to coordinate the PR with the CNCF](/release-team/role-handbooks/communications/templates/pr-email.md)

