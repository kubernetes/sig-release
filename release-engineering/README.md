# Release Engineering

## Table of Contents
- [Communication Channels, and How We Use Them](#communication-channels-and-how-we-use-them)
  - [Slack](#slack)
  - [Mailing List](#mailing-list)
  - [GitHub Project Board](#github-project-board)
  - [Meetings](#meetings)
    - [Instructional Meetings and Using Zoom](#instructional-meetings-and-using-zoom)
- [How We Discuss Work](#how-we-discuss-work)
  - [Communicating Decisions](#communicating-decisions)
  - [Communicating Decisions on Pull Requests](#communicating-decisions-on-pull-requests)
  - [Communicating Your Availability: Quick Tips](#communicating-your-availability-quick-tips)
  - [Handing Over Work That You Can't Finish: Steps](#handing-over-work-that-you-cant-finish-steps)
  - [Tracking Progress](#tracking-progress)
- [Roles, Responsibilities, and Notes for Newcomers](#roles-responsibilities-and-notes-for-newcomers)
- [Schedule of Recurring Work](#schedule-of-recurring-work)
  - [Weekly](#weekly)
  - [Bimonthly](#bimonthly)
  - [Monthly](#monthly)
  - [Ongoing](#ongoing)
  - [Ad Hoc/As Needed](#ad-hocas-needed)

## Communication Channels, and How We Use Them

- [Slack](https://kubernetes.slack.com/messages/release-management)
- [Mailing list](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
- [Meeting agenda and notes](https://bit.ly/k8s-releng-meeting)

### Slack

- We strongly encourage you to raise questions about our work in the [#release-management](https://kubernetes.slack.com/messages/release-management) channel and *not* via direct messages. This enables us to avoid duplicating conversations, and drives transparency and knowledge exchange.
- To prompt a discussion thread, we post a question or issue in brief (1-3 lines) and use the spool-of-thread emoticon to draw attention to it.
- To post several discussion topics or questions at one time, please post them individually in the channel. This helps us to keep discussion focused. 

### Mailing List

We use the [kubernetes-sig-release@ mailing list](https://groups.google.com/forum/#!forum/kubernetes-sig-release). Feel free to use it if you have a topic or question that, due to its complexity or need for brainstorming discussion, would be difficult to resolve over Slack or GitHub.

### Roadmap and Vision

Please see the SIG Release Roadmap and Vision document [here](https://github.com/kubernetes/sig-release/blob/master/roadmap.md). This is a great place to look if you're a newcomer looking to help out. 

### Meetings

Release Engineering meetings take place every other Tuesday at 7:30am PT / 14:30 UTC and last 60 minutes. 

- We set the core meeting agenda by the previous Friday, leaving time for open discussion/spontaneous topics. Topics come from group members.
- Meetings are recorded and follow the Kubernetes Code of Conduct. 
- A SIG Release Chair facilitates.
- A volunteer takes notes to create a decision log and call out questions and Action Items (AIs). 
  - Notetakers shouldn’t feel obligated to transcribe discussions; we record meetings to eliminate this need.
- Meetings cover critical Release Engineering deliverables, policies, and processes.
- We aim to have at least three different people present topics per meeting, to drive inclusivity.

If you’re driving a discussion topic, think about:
- What do you need from the group?
- How can others in the group help you?
- How much discussion time would you like? Noting this in the agenda helps us streamline meetings.

If you’d like to present topics during meetings but aren’t comfortable speaking up, please let us know and we’ll help ensure your ideas get discussed.

#### Instructional Meetings and Using Zoom

Sometimes group members hold small meetings to exchange knowledge. If you want to hold an instructional meeting that will be useful for the future, please ask the Release Managers for the SIG Release Zoom account credentials and record the meeting.

## How We Discuss Work

We’re biased toward asynchronous communication, but use our bimonthly meetings, Zoom calls, and Slack whenever questions arise that require discussion. 

For discussions related to work in progress, team priorities, policies and practices, and complex implementations:
- We recommend starting a discussion via meetings and GitHub issues.
 - The mailing list is also useful, but please note that many people receive a lot of email so they might not see your message right away.
- Try to keep your initial announcements and ideas pitches brief: messages that are under 2-3 sentences generate more and quicker responses than lengthy messages.
- If you’re not sure whether a topic merits discussion, first ping @leads on the #release-management Slack channel for guidance.
- Add your items/questions to the Release Engineering meeting agenda as early as possible.
- File a GitHub issue describing your idea and post it in the #release-management channel—this is an efficient way to provide context and spark discussion.
- If you have a small idea that you’re confident about, go forward with it—we support entrepreneurial spirit. Please communicate about your effort via Slack early on so that you don’t duplicate efforts or get blocked/block others.
- When you don’t get a response in the #release-management channel, please try again. People are busy and might have missed it.

### Communicating Decisions

This section remains under development while we work on creating a stakeholder communications matrix. Generally speaking, we use these mechanisms:

- Release Engineering agenda notes
- PRs, and amendment PRs on top of prior merged PRs

### Communicating Decisions on Pull Requests

We follow this flow:
- Reviewer gives `/lgtm`.
- Approver gives `/approve`.

If you’re making code changes and unsure about something, open the PR with a hold (`do-not-merge/hold`). This gives us time for discussion and collecting input from critical stakeholders.

We do not bypass the “at least one reviewer” rule, so please wait for a review. 

### Communicating Your Availability: Quick Tips

- We don’t require people to work on nights and weekends. However, if they are the times you want to dedicate to the project, feel free to do so. It's also important to note that for some contributors the weekend starts on a Thursday, and that meetings scheduled on Friday are an inconvenience.
    - We don't cut releases on Mondays precisely to preserve everyone’s weekends.
- Communicate honestly and openly about what you can and can’t do, and please ask for help. 
- If you ever feel workload-related pressure, please reach out to the SIG Release Chairs, Tech Leads, and/or Release Managers.
- When you're not sure what to work on, ping/@ the leads in the #release-management Slack channel. Doing this can inform others with the same question.

### Handing Over Work That You Can't Finish: Steps

- First, bring it up in a Slack channel post that you can’t finish something. 
- If no one responds within 2-3 days, cc @leads to raise awareness.
- Once someone claims the issue from you, unassign yourself from the GitHub issue.
- If the matter is not urgent, you can raise it at the Release Engineering. This tends to be successful and increases visibility around the issue.
- Please do not reassign work to others without some sort of communication first.

### Tracking Progress

- We use project boards linked in the [Roadmap and Vision document](https://github.com/kubernetes/sig-release/blob/master/roadmap.md) and try to review them during the Release Engineering meeting.
- As of Autumn 2020 SIG Release is setting up an instance of Triage Party to accelerate and automate triaging issues.
- We organize our work into sub-themes based on urgency and impact, and identify drivers of those topics.
- We call out and celebrate achievements. Some suggested communication paths for amplifying:
    - **First order**: role promotions, finishing a PR, etc.:
      - Mention in Release Engineering meeting; also in Release Team meeting, if it affects the release
      - Post in #release-management Slack channel
    - **Bigger order**: completing a milestone, finishing a major docs effort, other “headline news":
      - Post in #release-management and #sig-release Slack channels
      - Mention in Release Engineering and SIG Release meetings; also in Release Team meeting, if it affects the release
      - Post about individual and small-team efforts in the #shoutouts Slack channel
    - **Biggest order**: forming a new subproject, shipping a release:
      - Mentions in Release Engineering, SIG Release and Release Team meetings
      - Post in #sig-release and #release-management Slack channels
      - Post about individual and small-team efforts in the #shoutouts Slack channel
      - Demo or mention at Monthly Community Meeting

## Roles, Responsibilities, and Notes for Newcomers

[This page](https://github.com/kubernetes/sig-release/blob/master/release-managers.md) provides details about the different roles in Release Engineering, along with requirements for moving up the "career ladder."

### For Newcomers
At Release Engineering meetings, we like to give newcomers a happy and warm welcome. We also give space for newcomers to introduce themselves and their motivations/interests for joining. However, if you prefer not to speak during your first meeting we'll respect that. 

As of Autumn 2020 we're developing a Buddy Program to improve our onboarding. Here's how it will work:

- Release Managers follow up with newcomers to go over the details of this page and empower them to ask questions about our work and processes.
- Newcomers can request a Buddy (a Release Manager), who will also be shadowed/supported by up to two Release Manager Associates.
- Buddies will come from the same general time zone area and, as often as possible, share the same language.
- Work-related conversations should take place in the Slack channel as much as possible to help other newcomers onboard.
 
More information about the Buddy Program is available [on this page](https://github.com/kubernetes/sig-release/blob/master/release-managers.md).

## Schedule of Recurring Work

These topics recur for release engineering during every release cycle. To keep the team’s workflow more manageable, it’s advisable to account for this work as part of the time/planning budget:

### Weekly

- Cherry pick triage and approval
- Provide status updates at Release Team meetings
 
### Bimonthly

-  k/release updates
   - Go dependencies / go.mod updates
     - We don’t deliver k/release binaries to users, but toolchain artifacts may leak into the actual 
Kubernetes project delivered artifacts—making it important for these dependencies to be updated from a security perspective.
   - Push new semver tags to demarcate a release or preferred consumable instance of the release tooling.

### Monthly

- Patch releases: 1.Y.Z, 1.Y.(Z-1), ...1.Y.(Z-...n)
 - A week before each patch deadline, notify the community of the pending deadline.
 - A week before each patch deadline, generate an updated status report on all cherry picks and share it.
 - Cut the three most recent minor versions.
 - Communicate to the community ahead of the final release from a release branch, to ensure 
that any final cherry-pick content is merged ahead of that last release.
 - Deprovision CI for the oldest release branch after its last release.
 - Golang versions in Kubernetes
   - Document the different triage types/priorities and a triage process:
     - Golang 1.X release
     - Golang 1.X.Y release
     - Golang 1.X.Y release with CVE with no or minor Kubernetes impact (what is the maximum CVSS?)
     - Golang 1.X.Y release with CVE with major Kubernetes impact (what is the mininum CVSS?)
   - Document the different triage per repo/image.
     - kubernetes/kubernetes
       - UNLESS there are CVEs (then we must address)
       - Every update requires an update to bazel rules_go
     - kubernetes/release
       - images/k8s-cloud-builder
       - images/build/cross (kube-cross)
       - images/build/go-runner (arguably part of the Golang version updates above)
     - kubernetes/test-infra
       - kubekins
       - Krte

### Ongoing

- Cut prereleases (Alpha, Beta, Release Candidate) for the minor release in development.
 
### Ad Hoc/As Needed

- Update Golang versions in Kubernetes.
- Update core Kubernetes base images, e.g.:
  - CRI tools
  - CNI plugins
  - OS base images (example: debian-base)
  - distroless-iptables
  - debian-hyperkube-base
  - Publishing bot updates
    - The bot runs on a schedule but sometimes breaks, requiring ad hoc fixes.
  - Curation of the [base images exception list](https://github.com/kubernetes/sig-release/blob/master/release-engineering/baseimage-exception-list.md) (most of this list is complete; more info [here](https://github.com/kubernetes/enhancements/issues/1729)).
  - Maintaining instructions on how to consume all above official artifacts, plus variations for how 
consumers can test pre-release Alpha/Beta/RC artifacts
  - push-build.sh maintenance, until it goes away
