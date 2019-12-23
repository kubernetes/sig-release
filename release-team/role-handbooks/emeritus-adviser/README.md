# Emeritus Adviser Handbook

## Overview

The Emeritus Adviser (EA) is an experienced Release Team (RT) member who returns to the team in an advisory role.

### Requirements and Selection
The EA should be an individual who has served on the Release Team, in a Lead capacity. The primary selection pool should be former Release Team Leads (ideally from the previous 4 releases). However, if there are no available individuals the EA can be another former Role Lead, who has been an exemplary member of a previous Release Team or a SIG Release subproject owner e.g., Release Engineering.

An ideal Emeritus Adviser is inherently suited to people management, has shown sustained interest in the health and growth of SIG Release, and has a commitment to Release Team diversity and helping others ascend the [Contributor Ladder](https://git.k8s.io/community/community-membership.md).

Time commitments for the EA are relatively light, with the largest time commitment in the two-week period where Shadows are being selected.  However, the EA role starts 2-3 weeks before the release cycle officially begins, and continues for 1-2 weeks after it ends.

EAs are not chosen as part of the regular RT selection process. Instead, interested candidates should contact the outgoing EA and the incoming Release Lead 2 weeks before the final prior release. Based on those interested in the EA role, the outgoing EA will choose 2-3 folks to nominate to the outgoing and incoming release leads who will select the individual to be EA for the next release cycle 

The EA for the next release team should be selected ahead of opening up nominations for the next release cycle, and the incoming EA will be assigned that issue. 

Due to the nature of the role, the EA has no shadows. The job may, however, be split between more than one person.

## Responsibilities
Responsibilities for the EA are to help enable the Release Team. Activities the EA is responsible for are 

* Track the former release retrospective AIs 
* Create the incoming release shadow surveys 
* Assist release role leads in shadow selection 
* Run a general shadow orientation for folks, explaining the basics of the release team 
* Check in on leads and shadows throughout the release and offering support to them 
* Conduct Shadow experience surveys throughout the release cycle and a lead/mentor questionaire at the end of the cycle
* Facilitate the release retro at the end of the cycle 

## Requirements

Due to timing (see below) 

## Tasks

### Release Team Selection

Weeks: -2 to 0

At least 2 weeks before the new release cycle begins, the EA is responsible for posting the "Assemble the X.Y Release Team" issue in the SIG-Release repo ([example](https://github.com/kubernetes/sig-release/issues/776)).  They should then make sure that the new Release Lead is officially nominated and chosen, and then issue a call for nominations/volunteers for the other Role Leads.

### Shadow Selection

Weeks: -1 to 1

Once most of the Role Leads are selected, the EA should solicit candidates for Shadows.  Steps for this are:

1. Get a copy of the Shadow Application (on Google Forms, currently) from the outgoing EA.
2. Make any changes to it identified as required in the Retro or elsewhere.
3. When the new RT Lead gives the OK, open the form and announce it in the following places: #sig-release channel, sig-release mailing list, kubernetes-dev mailing list, and the Kubernetes Community Meeting.
4. Close the Shadow Application around 7-10 days after the initial announcement.
5. Chat with each of the incoming Role Leads about selecting their shadows, and make sure that they stay on schedule for it.
6. Once all role leads select their shadows the EA will send out a notification to all applicants not selected for this release cycle 

The most time-consuming part of this is helping the Role Leads select shadows.  In addition to the usual dilemmas of too many good candidates, the EA needs to give advice that makes sure that a diverse pool of shadows is selected, and that the Role Lead doesn't take on more shadows than they can effectively mentor.

Occasionally, a role may not get enough qualified candidates, in which case it's the EA's job to work with the new Role Lead to find or solicit additional candidates.

### Shadow and Lead Status 

Weeks: 1 to 12

First, have a "shadow orientation" meeting sometime in week 2 or week 3, after all shadows are selected.  This meeting will likely have to be split for time zone reasons and held twice.  In this meeting, go over the information in the main Shadow docs, give information about the release team and SIG Release, and then open things for questions or discussion. Make sure that Shadows know they can come to you if they have problems during their apprenticeship.

**For leads, ensure they have enough support for their role, and to be an effective mentor to their shadows.**

During the first month or so of the release try to solicit feedback from shadows. This can be done in a survey (similar to the one sent at the end of the cycle).  

Then, throughout the release cycle, do what you can to make sure that the shadows are participating in RT activities, particularly meetings. For example, each Shadow should deliver the Role update during a release meeting or burndown meeting at least once. If a Role Lead is absent from a meeting and no Shadow takes over, that often indicates a problem.

### Succession

Weeks: 9 to 12

Connect with each Role Lead and each Shadow Team to talk about succession. For the Shadows, ask them to think about what they want to do after the release. This not only includes further RT roles, but other things they could do such as Release Engineering.

The EA also needs to pick the EA for the next release no later than Week 11 (pending confirmation by the incoming RT Lead), because they need to get started before final release.  

### Evaluation

Weeks: 12 to 14

Prepare two forms based on the ones used for prior releases. The first form goes to all of the shadows to evaluate how the shadowing/apprenticeship experience went for them. The second form is for the Role Lead to evaluate how they felt they did as a mentor, and make some notes on the performance of each Shadow in case they ask to join future teams.

Release these forms no later than the week of release, although it is unlikely that the team members will fill them out until after final release. Follow up and make sure that all the Role Leads, at least, fill out theirs.
