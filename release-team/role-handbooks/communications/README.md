# Kubernetes Release Team: Communications Coordinator

## Overview

The Communications Coordinator role is responsible for facilitating, empowering, and curating communication between the release team and various stakeholders including the Cloud Native Computing Foundation (CNCF), the media, contributing vendors, Kubernetes project managers, and the overall Kubernetes community at large.

Communications deliverables that come from the release process include a release blog, facilitation of a feature blog series, scheduling of a CNCF Kubernetes release webinar as well as other speaking opportunities, and approved messaging for media. In the event that the release schedule slips, the communications coordinator will ensure media opportunities through the CNCF are synchronized and that all stakeholders are kept advised of changes in timing.

## Requirements

**Before continuing on to the Communications specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Skills and Experience Required

- Strong written and verbal communications skills
- A working knowledge of Kubernetes concepts
- Fundamental GitHub skills and experience with open source projects
- Experience with the Kubernetes release process enough to understand how communications milestones fit into the overall release
- Project management experience is helpful
- Existing relationships with the CNCF, relevant media personnel and outlets, Kubernetes project managers, and vendor stakeholders is helpful
- The communications lead should take the [Inclusive Speaker Orientation (LFC101)](https://training.linuxfoundation.org/training/inclusive-speaker-orientation/) training course

### Expected Time Investment

The Kubernetes release cycle spans 15 weeks, though may run longer. The typical workload for the communications team is very light during the first few weeks. In the later weeks of the release cycle, the workload can become heavy, and often work can continue on a few weeks after release.

The expected time investment for both leads and shadows are as follows:

- 30 minutes to 2 hours a day (depending upon week), reviewing incoming KEPs and blog PRs, working with other SIGs or the CNCF managing the feature blog posts, and following Slack channels in order to keep pending content current.

- 1 to 5 hours a week, attending Release Team (weekly) and Burndown meetings (daily during Code Freeze)

**NOTE:** These are estimates and your personal experience may vary. The more time you can spend working as a team and regularly communicating within your team, the better off your experience will be.

### External Release Communication

Please use the `release-comms@kubernetes.io` Google Group list for external release communications (communicating with the CNCF, etc.).

The following groups should be members:
* The current release cycle's Release Team Lead & Lead Shadows
* The current release cycle's Communications Lead & Comms Shadows
* SIG Release Chairs

The list has to be rotated/actively managed every cycle. Submit a PR to update [this document](https://git.k8s.io/k8s.io/groups/groups.yaml) per the milestone activities described below.

### Slack Channel

There is a channel on the Kubernetes Slack workspace, `#release-comms`, which is used by the communications release team to coordinate their efforts. If you're on the communications team, or applying to be, then it would be advantageous to follow along with the conversations. The Communications Coordinator (often referred to as the "Comms Lead") should post a status here at a regular cadence to keep release team members and other stakeholders informed.

## Release deliverables

Throughout the release cycle, the main Communications deliverables include:
* **Authoring the Kubernetes release blog.** The Communications team writes the release blog, which is the official announcement of the Kubernetes release.
* **Coordination and support of the feature blog series.** SIGs opt in to author feature blogs for the release. These blogs are written by technical owners, and the Communications team supports authors from the early stages through facilitating editorial and tech reviews as well as publication.
* **Coordination and support of an optional Deprecations and Removals blog.** Depending upon the content of a given release, it may be necessary to prepare the community for upcoming deprecations and removals. This is decided per release cycle around the time of Code Freeze.
* **Scheduling press activities and the post-release webinar with the CNCF.** The Communications Coordinator works with the CNCF to schedule press release activities around the release, and to schedule the release webinar (typically scheduled 3-4 weeks post-release).

### Release blog

The Communications Coordinator along with the Comms shadows are responsible for authoring the official Kubernetes Release blog. This blog is the official statement of release. The release blog is the primary vehicle by which the release team communicates the major themes, known issues, and other aspects of the release to the community. 

Start the draft with the team around week 12, striking a balance between the release content being fairly well set and having enough to time author the blog and have it reviewed. Ahead of review, open a pull request on the [website repository](https://github.com/kubernetes/website) and assign the release lead and other stakeholders as reviewers.

It's up to you and your team regarding how best to do this, typically it works well to assign sections to different team members (e.g. Major Themes, User Highlights, Ecosystem Updates, etc) and have the lead pull it all together and manage the PR and reviews.

### Feature blogs

Tracking, facilitating, and organizing the publication of the Feature Blog series is a major deliverable of the Comms team. Feature blogs are opt-in for SIGs, and authored by enhancement developers and others close to the features.

The first feature blog typically goes out on release day alongside or shortly after the release blog, and then are published one-at-a-time, typically two to three posts weekly. The Comms team establishes the publication schedule. Note that blog PRs in k/website are dated, and automation will publish future-dated entries. This enables a PR process decoupled from blog publication date.

As feature blogs are opted in, assign them to shadows and yourself for tracking and facilitation. The responsibility is to ensure the blog authors have the resources and information they need, including editorial and tech reviews once ready.

Work closely with the SIG Docs Blogs team (connecting on `#sig-docs-blogs` and by attending meetings), as they are typically available for editorial reviews. Share with them the feature blog schedule and updates throughout the cycle.

For tech reviews, reach out to authors and the sponsoring SIG to organize at least one tech review per blog post.

### Mid-cycle deprecations and removals blog

This blog is optional and will vary from release to release. Work with the rest of the release team ahead of the Code Freeze date to determine if a mid-cycle blog focused on feature deprecations and removals is warranted. If so, facilitate its creation and publication. You can create a Slack thread on [#sig-release](https://kubernetes.slack.com/archives/C2C40FMNF) to discuss this.

If the release will deprecate important and commonly-used features (or simply a large number of features will be deprecated), consider publishing this blog. Also consider this when commonly-used features that have been deprecated are removed in a release. ['Kubernetes API and Feature Removals in 1.22'](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/) and ['Deprecated APIs Removed in 1.16'](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/) are great examples to work from.

Regardless of reason, the timing for publication is ahead of the release, in order to inform the community and allow for preparation time. Start the discussion mid-cycle and well ahead of Code Freeze, and target publication for Code Freeze week.

### Press and release webinar

This is a light but very important component of the Communications Coordinator role. Two sets of activities need to be scheduled with the CNCF, namely press release and interview scheduling around the release day, and the release webinar after the release.

To schedule the press briefings, you will be a liaison between the Release lead and the CNCF contacts. Send an email to `pr@cncf.io` about a month ahead of the release and coordinate between the parties to get release day press events scheduled.

To schedule the release webinar with the CNCF, start things with an email to `webinars@cncf.io`. You will likely use the Calendly link (below) to schedule a "live webinar". If things are tight on the schedule, CNCF will help find a spot.

The webinar is typically scheduled for 3-4 weeks after the release, and is primarily presented by the Release lead and Enhancements lead. Often the Comms lead will also join the webinar. The format is open, but primarily the team walks through the enhancements in the release and gives a sneak peek of what's coming in the next release.

Refer to the [slides](https://docs.google.com/presentation/d/10y65ptwXQrt_0P6sA3TSvRH_c7TGBc8DEHhXRNwi-10/) and [webinar](https://www.youtube.com/watch?v=BTPlVsgO_As) from the 1.22 release as an example.

Note you'll need to send headshots and company/title information when you schedule the webinar, and the slides should be sent for CNCF review at least one week ahead of the webinar.

## Release Milestone Activities

This is an example of a typical release cycle and the order of how tasks will flow for Comms.  Note that some tasks may take longer than their designated "release week".

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
        <li>Join `#sig-release` and `#release-comms` Slack channels
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
        <li>Update the <code>release-comms@kubernetes.io</code> Google Group. <a href="https://git.k8s.io/k8s.io/groups/groups.yaml">Membership</a> for this group is defined in <a href="https://git.k8s.io/k8s.io">kubernetes/k8s.io</a>. Ensure the list <b>only includes</b>:
        <ul>
        <li>The current release cycle's Release Team Lead & Lead Shadows
        <li>The current release cycle's Communications Lead & Comms Shadows
        <li>SIG Release Chairs 
        </ul></ul>
        <ul>
        <li>Organize a meeting with the SIG leads to align on the communications timeline and support for writing features posts
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
        <li>Get access to the `Enhancements` and `Feature blog opt-in` tracking sheets and start following along
        </ul>
        </td>
    </tr>
    <tr>
        <td>4</td>
        <td><b>Enhancements Freeze</b></td>
        <td>
        <ul>
        <li>Work with the enhancements lead to understand big-ticket items to be included in the release
        <li>Start monitoring the `Feature blog opt-in` sheet for new entries and use the `Assigment tab` sheet to assign and track status throughout the cycle (<a href="https://docs.google.com/spreadsheets/d/1hgFWig6YBSYORP3huwEyU0VlXGcYi6wMxjYW-swzCIY">for example</a>)
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
        <li>In the coming weeks, follow the progress of these enhancements, as they will roll into the Major Themes and be called out and described in the release blog
        <li>Work with the Release Team and decide if the release warrants a mid-cycle 'Deprecations and Removals' blog
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
        <li>Join the `#sig-docs-blog` channel on Slack and attend the bi-weekly meetings. Share the current status of the Feature blog opt-in's and work with the team to establish review expectations and publication strategy.
        </ul>
        </td>
    </tr>
    <tr>
        <td>10</td>
        <td></td>
        <td>
        <ul>
        <li>Send out final reminders for feature blog opt-in on the SIG slack channels
        <li>Facilitate or start writing the optional Deprecations and Removals blog
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
        <li>Post the feature blog publication schedule in `#sig-docs-blog` (<a href="https://kubernetes.slack.com/archives/CJDHVD54J/p1628649661040600">example post</a>)
        <li>Establish a regular cadence status check-in with the `#sig-docs-blog` team and maintain the publication schedule post in Slack to keep everyone synced
        <li>Request placeholder PRs in k/website from all feature blog authors
        </ul>
        </td>
    </tr>
    <tr>
        <td>12</td>
        <td><b>Code Freeze</b></td>
        <td>
        <ul>
        <li>Begin the release blog draft, if not yet started
        <li>Optional 'Deprecations and Removals' blog ready for review
        <li>Schedule the release Live Webinar with CNCF by emailing `webinars@cncf.io`. You may be referred to <a href="https://calendly.com/cncfonlineprograms">Calendly</a>. The webinar is typically scheduled for 3-4 weeks after the release
        <li>Schedule press and analyst pre-briefings and interviews for the release lead with CNCF by emailing `pr@cncf.io`
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
        <li>Check status with Release Notes lead on content for Major Themes and Known Issues sections of the release blog (short summaries to be included in the release blog)
        <li>Check status on all feature blog PRs. Keep `#sig-docs-blog` up-to-date for editorial review, and establish tech reviewers are available 
        </ul>
        </td>
    </tr>
    <tr>
        <td>14</td>
        <td><b>Feature Blogs ready to review</b></td>
        <td>
        <ul>
        <li>Feature blog reviews start
        <li>Continue to partner with `#sig-docs-blog` for editorial review, work to ensure tech reviews are moving forward from SIGs
        <li>Connect with Release Lead to ensure theme and release logo will be ready for release blog (not required for draft revisions)
        <li>Ensure that short one-to-two paragraph summaries of each Major Theme are available for the release blog from Release Notes lead or SIG Chairs
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
        <li>Finalize Release Blog, ensure it's ready for Docs Lead to publish on release day
        <li>Ensure first few feature blogs are ready to publish and that review and merge plans are in place for any still outstanding.
        </ul>
        </td>
    </tr>
    <tr>
        <td>16</td>
        <td><b>Release retrospective</b></td>
        <td>
        <ul>
        <li>Continue to facilitate publication of remaining feature blogs
        <li>Participate in release retro parts 2 and 3 (as needed)
        <li>Organize the slides for the CNCF release webinar, and send to the CNCF for review at least one week ahead of the scheduled date.
        <li>Update this document!
        </ul>
        </td>
    </tr>
</table>

## Release Blog Outline & Template
To support you in the creation of the release blog this [outline](/release-team/role-handbooks/communications/release-blog.md) summarize ideas for sections and gives you a template for easier release blog creation.
