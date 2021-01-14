# Kubernetes Release Team: Communications Coordinator

## Overview:

The Communications Coordinator role is responsible for facilitating, empowering, and curating communication between the release team and various stakeholders including the Cloud Native Computing Foundation (CNCF), the media, contributing vendors, and Kubernetes project managers.

Additionally, there are specific deliverables that must come from the release process in the form of a release blog, event speaking opportunities, webinars, coordination of 5 Day blog series with the CNCF, and approved messaging for media. In the event that the release schedule slips, the communications coordinator will ensure press timing is synchronized and kept advised of the revised timing.

## Requirements

**Before continuing on to the Communications specific requirements listed below, please review and work through the tasks in the [Release Team Onboarding Guide](/release-team/release-team-onboarding.md).**

### Skills and Experience Required

- Strong written and verbal communications skills
- Experience with the Kubernetes release process enough to understand how communications milestones fit into the overall release
- Existing relationships with the CNCF, relevant media personnel and outlets, Kubernetes project managers, and vendor stakeholders
- A working knowledge of Kubernetes concepts
- Project management experience is helpful

### Expected Time Investment

The Kubernetes release cycle usually spans 12 weeks. The typical workload for the communications team is _very_ light the first few weeks. In the later weeks of the release cycle, the workload can get very heavy.

The expected time investment for both leads and shadows are as follows:

- 30 minutes to 2 hours a day, reviewing incoming KEPs and PRs, working with other SIGs or the CNCF on creating blog posts, and following Slack channels

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

There is a channel on the Kubernetes Slack workspace, `release-comms`, which is used by the communications release team to coordinate their efforts. If you're on the communications team, or applying to be, then it would be advantageous to follow along with the conversations.

## Release Milestone Activities

This is a general example of what a release cycle might look like and the order of how tasks will flow.  Some tasks may take longer than their designated "release week".

<table>
    <tr>
        <td><h3><b>Release Week</h3></b></td>
        <td><h3><b>Milestones</h3></b></td>
        <td><h3><b>Activities</h3></b></td>
    </tr>
    <tr>
        <td>1</td>
        <td><b>Release Start</b></td>
        <td>
        <ul>
        <li>Select your shadows
        <li>Ensure yourself and your shadows are entered into the release contact sheet
        <li>Ensure yourself and your shadows are on the release team meeting invites
        <li>Establish initial meeting with team to introduce everyone, collective tasks, and upcoming timelines
        <li>Check if there are any holidays or events (KubeCon!) that occur during this release
        <ul>
        <li>This can/will affect your communication with the CNCF and SIG Chairs. Plan accordingly
        </ul>
        <li>Setup a communications plan aligned with the Release Calendar
        <li>Agree on participation together with Enhancements team lead at the next SIG Leads monthly meeting to align on expectations and communication possibilities
        </ul>
        </td>
    </tr>
    <tr>
        <td>2</td>
        <td></td>
        <td>
        <ul>
        <li>Update the <code>release-comms@kubernetes.io</code> Google Group to ensure the list <b>only includes</b>:
        <ul>
        <li>The current release cycle's Release Team Lead & Lead Shadows
        <li>The current release cycle's Communications Lead & Comms Shadows
        <li>SIG Release Chairs 
        </ul></ul>
        <p><a href="https://git.k8s.io/k8s.io/groups/groups.yaml">Membership</a> for this group is defined in <a href="https://git.k8s.io/k8s.io">kubernetes/k8s.io</a>.</p>
        <ul>
        <li>Organize a meeting with the SIG leads to align on the communications timeline and support for writing features posts
        </ul>
        </td>
    </tr>
    <tr>
        <td>3</td>
        <td></td>
        <td>
        <ul>
        <li>Work with the enhancements lead to understand what might be delivered
        <li>You should get access to the enhancements tracking sheet. You should check this regularly
        </ul>
        </td>
    </tr>
    <tr>
        <td>4</td>
        <td><b>Enhancements Freeze</b></td>
        <td>
        <ul>
        <li>This is enhancements freeze. The fun begins next week
        <li>Work with enhancements and release note leads to determine which deliverables are most note worthy
        <ul>
        <li>Approach SIG Chairs for said items and request a couple of paragraphs on each deliverable
        </ul>
        </ul>
        </td>
    </tr>
    <tr>
        <td>5</td>
        <td></td>
        <td>
        <ul>
        <li>Final agreement on note worthy enhancements
        <li>Start feature blog drafts and share for each feature blog a document to contribute in
        <li>Schedule release webinar with CNCF
        </ul>
        </td>
    </tr>
    <tr>
        <td>6</td>
        <td></td>
        <td>
        <ul>
        <li>Schedule press and analyst pre-briefings and interviews for the release lead with CNCF
        <li>Schedule release blog and press embargo with CNCF
        </ul>
        </td>
    </tr>
    <tr>
        <td>7</td>
        <td><b>Code Freeze</b></td>
        <td>
        <ul>
        <li>Send release blog draft to CNCF
        </ul>
        </td>
    </tr>
    <tr>
        <td>8</td>
        <td></td>
        <td>
        <ul>
        <li>Finalise the release blog
        <li>Work with the CNCF communications team to continue to schedule press and analyst pre-briefings and interviews
        </ul>
        </td>
    </tr>
    <tr>
        <td>9</td>
        <td><b>Cherry Pick Deadlines</b></td>
        <td>
        <ul>
        <li>Finalize the blog, and adjust based on what was delivered
        <li>Coordinate release timing with the CNCF, Media, Release team (not embargo for media stories may release this week)
        </ul>
        </td>
    </tr>
    <tr>
        <td>10</td>
        <td><b>Release</b></td>
        <td>
        <ul>
        <li><b>This is release week!</b>
        <ul>
        <li>Keep CNCF in the loop with any potential delays to the release
        </ul>
        <li>Publish release blog
        <li>Finalize feature blogs
        </ul>
        </td>
    </tr>
    <tr>
        <td>11</td>
        <td><b>Retrospective</b></td>
        <td>
        <ul>
        <li>Release retrospective participation
        <li>Publish feature blogs
        <li>Update this document!
        </ul>
        </td>
    </tr>
</table>

## Release Blog Outline & Template
To support you in the creation of the release blog this [outline](/release-team/role-handbooks/communications/release-blog.md) summarize ideas for sections and gives you a template for easier release blog creation.
