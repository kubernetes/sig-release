# Release Team Shadows

The Release Team recruits a number of apprentices for each release role, in order to train new release team leads, handle tasks that each lead may not be able to cover, share knowledge about the release process, and help contributors broaden their areas of knowledge and participation.  These apprentices are called "Shadows" on the release team, and are equivalent to similar trainee positions on other teams, such as the Release Management Assistants.

The Shadow system is an apprenticeship model, like those used by union tradespeople.  The idea is that Shadows learn by doing, while in the process taking load off the leads and improving the release.  After unplanned developments, they may even end up taking over for their lead.

The following guide is for both Release role leads and shadows so that everyone knows what shadows are expected to do and when they are expected to do it.  In cases where the guide says "you," it is addressing the Shadow or potential Shadow.

## Asking to be a Shadow

In the last week of the prior release cycle, or the first week of the new one, the Emeritus Advisor and Release Lead will post a sign-up form for people who want to be Shadows.  Potential Shadows should fill out this form, which has a number of questions about their interests, availability, and experience; this is to judge who will be the most suitable and balance the team.  

Please read the [Role Handbooks](https://github.com/kubernetes/sig-release/tree/master/release-team) for those roles before filling out the form.  Some handbooks will have a specific Shadow section that addresses what background Shadows are expected to have and what tasks they do.

Shadow is an apprenticeship position, so candidates are not expected to be that experienced in contributing to Kubernetes or working on releases.

During several release cycles, there have been three or more applicants for each Shadow spot, so many qualified candidates were turned down and asked to re-apply to a later team.  Role Leads, the EA and the Release Lead will choose Shadows based on a combination of suitability, availability, skills coverage, diversity, and compatible or covering time zones.

## Week 1

The first week should be used to get Shadows set up with all of the "paperwork" they need in order to participate fully in the Release Team:

* Sign the [CNCF CLA](https://github.com/kubernetes/community/blob/master/CLA.md), which they need for all contributions.
* Apply to be an Org Member if they are not already (see below).
* Join the [#sig-release slack channel](https://slack.k8s.io/).
* Get added to the `kubernetes-release-team` group by the Release Lead.
* Join the [sig-release](https://groups.google.com/forum/#!forum/kubernetes-sig-release) and [release-team](https://groups.google.com/forum/#!forum/kubernetes-release-team) Google Groups and calendars.
* Add all contact information to their Release Team's contact sheet.
* Get invited to the weekly Release Team Meeting and add the [sig-release calendar](https://calendar.google.com/calendar/embed?src=kipmnllvl17vl9m98jen6ujcrs%40group.calendar.google.com) to their calendar

Becoming a Release Team Shadow is considered sufficient contribution to become a Kubernetes Org Member, and membership is needed for several tasks, especially having the Github bots obey the Shadow's commands. As such, each Shadow who is not already an org member should [apply to become one](https://github.com/kubernetes/community/blob/master/community-membership.md#member) with their mentoring role lead, the Release Lead, and/or the Emeritus Advisor as their sponsors.

Most times, groups of shadows and their lead for a specific role will have a meeting during the first two weeks.   Not all do, though, since sometimes there's a considerable spread of time zones, and some leads prefer to work asynchronously.

## Weeks 2-8

For the "main" part of the development cycle, new shadows should be learning their roles and starting to take on tasks for their roles. This may include:

* Attending the weekly Release Team meeting, and possibly delivering the report for their Role for the week.
* Checking on daily statuses of things in their roles and recording them in documents shared by the team.
* Contacting and sending reminders to SIGs.
* Reviewing and resolving open issues in sig-release and test-infra that affect their roles, especially ones left over from last release.
* Other tasks as defined in the [Role Handbook](https://github.com/kubernetes/sig-release/tree/master/release-team).

For a couple roles, particularly Enhancements, this first period is actually the busiest period of the release, so there will be a lot for the Shadows to do. Consult the Role Handbook for the role to find out.  For other roles, the shadows for a role should expect to be in communication with their Lead and each other a few times a week, via Slack, shared documents, and Github issues/project boards.

More experienced shadows (those returning to the Release Team) may be starting work on some project to improve the efficiency or effectiveness of their roles.  Early in the release cycle is really the best time to work on longstanding issues.  See Experienced Shadow Projects below.

## Weeks 9-13

The final weeks of the release are the busiest for most roles; Shadows should expect to double the amount of time they put in during this period.  General tasks here include:

* Attending burndown meetings.  Since there will be 9-12 burndown meetings during the last weeks, each Shadow should take a turn preparing and delivering the role report for the burndown.  Shadows are also there to cover if the Role Lead can't make it to one of the meetings.
* Otherwise taking responsibility for the Role if the Lead is unavailable for a few days during burndown and Code Freeze.
* Checking on, and updating, release status tracking more than once a day, especially if you have several different time zones in your team.
* Following up on issues/failures/missing docs/exceptions etc. with their owners or SIGs.  During Code Freeze problems often need rapid attention, and your team should divide or rotate communication and follow-up duties. Sometimes it makes sense for a Shadow to be dedicated to tracking one particularly difficult task, such as a problematic PR or a mysterious blocking test failure.

Each Role team should be in daily, or more frequent, communication during the last three weeks, generally via Slack and Github comments.

Shadows who have been working on improvement projects should generally expect to wrap them up before Code Freeze, unless their help really isn't needed with the general Role duties.

Towards the end of the cycle, Shadows should think about whether or not they want to go on in their Role, either as Lead or Shadowing again.  See After Shadowing below.

## Shadow Improvement Projects

Sometimes contributors return to the Release Team to work on some longstanding improvement project, like better tracking boards or improved automation.  Even new Release Team members with  technical experience of the Kubernetes infrastructure have done this.  In this case, the Shadow spends most of the release cycle working on the improvement project instead of, or in addition, to their usual duties.  

The idea is to make a lasting efficiency improvement, while leaving the Lead free to deal with current release issues.  Much of the existing Release Team infrastructure originated this way, and the ultimate aspiration of SIG-Release would be to automate away 80% of the work of the Release Team.

Generally, if you're going to do an improvement project, you need to have a pretty good idea of what you want to do by the 2nd week of the release cycle.  You'll also need a knowledge of test-infra, docs/website, or some other relevant technical area where you're going to implement the improvement.  Finally, you'll want the agreement of your Role Lead and the Release Lead that the improvement you plan to implement (and how you want to implement it) is a good idea.

## After Shadowing: What's Next?

Shadowing is an apprenticeship, and as such is intended to be a stepping-stone to greater Kubernetes contributions in the future.  Towards the end of the release cycle, your Role Lead and the Emeritus Advisor (EA) will chat with you about what you want to do next.

Here's the common paths for Shadows after the release cycle ends:

**Shadowing Again**: if you didn't really get accustomed to the Role, possibly because personal issues interrupted Shadowing, you might want to Shadow the Role a second time.  Other Shadows discover that the first Role they tried isn't for them, and they want to shadow a different one so that they can try that one out.  In either case, you'll re-apply to Shadow when the next cycle opens, noting your experience in the application form.

**Becoming Role Lead**: The main goal of the Shadow program is to train new Leads.  So, if you are ready to take on Leading the Role in the succeeding cycle, then let your Role Lead know.  They will be selecting a nominee or nominees to recommend to the incoming Release Lead, who has the final decision.  You can also skip a release cycle, and volunteer to become Role Lead in a later release cycle, in which case you should contact the incoming Release Lead as soon as they are announced.  There is usually an issue in the SIG-Release repository called "Assemble Kubernetes X.YY Release Team" where you can comment with your interest in a Role.

**Another role in SIG-Release**: some Shadows go on to do something else within SIG-Release.  For example, they may join the Branch Managers as an Release Management Associate (RMA), or they may decide to take on a release-related project that's not directly tied to the release cycle.  If you are interested in the Branch Managers, wait for them to announce their next recruitment cycle, or ask in the SIG-Release Slack channel.

## Q&A

*Q: I want to shadow, but I'm not able to work on Kubernetes during my workday.  Can I still do this?*

A: Yes.  The time requirements for shadows are smaller and more flexible than they are for Role Leads.  As long as you're clear about your time availability, then you should be able to shadow.  Keep in mind, though, that you may need to have your boss's support to become a Lead for some Roles.

*Q: I want to shadow, but I'll be unavailable for part of the release cycle. Is that OK?*

A: Maybe; it depends on when it is, and which role. Put your availability limitations in the form, and the Role Lead will decide if your absence means that shadowing won't work.

*Q: I've run into problems with Shadowing, who do I talk to?*

A: if it's a problem with your schedule or the tasks you're assigned, you can simply ask your Role Lead.  If you're having problems in your relationship with your Role Lead, then contact the Emeritus Advisor. If someone in the Release Team violates the Kubernetes Code of Conduct, then contact the CoC Committee *and* the EA.

*Q: I'm a Role Lead and I'm having Shadow issues, who do I talk to?*

A: Talk to the Emeritus Advisor.

*Q: What if a Shadow needs to drop out?*

A: This happens frequently; usually the Shadow is simply dropped from the roster. In some cases, particularly in the first two weeks of the release cycle, they may be replaced.

*Q: What if the Role Lead can't continue, and one of the Shadows needs to take over?*

A: The Release Lead, the EA, and the outgoing Role Lead (if possible) will discuss the matter and select one of the Shadows to become the new Role Lead.  This is one of the reasons we have Shadows.
