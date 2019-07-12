# Release Team Selection

In addition to discharging the duties of their respective Release Team roles, the current Release Team is charged with selecting the team for the following release cycle.

Team selection should happen transparently.

In the 1.11 release cycle, we selected the Release Team Lead by quorum during a public Release Team meeting and additional roles were staffed via [an issue in k/sig-release](https://github.com/kubernetes/sig-release/issues/167) and a set of PRs, starting with [this one](https://github.com/kubernetes/sig-release/pull/168).

Each Release Team role is responsible for staffing their respective role, with this order of fall-through in mind:
- training and selecting a successor from the current pool of role shadows
- training and selecting a successor from non-Release Team members
- staffing the role themselves

Ultimately, if none of these can be satisfied, responsibility falls to the future Release Team Lead and SIG Release to staff the roles.

## Considerations

### Timing

Staff early! The Release Team should undertake the selection process at the beginning of Code Freeze, with a deadline of three days following the current release.

Any staffing decisions that cannot be made within this timeframe should be escalated to SIG Release Chairs and discussed publicly.

Following the future Release Team selection, or the end of Code Freeze (whichever comes first), the Emeritus Adviser will publish a questionnaire and announce that we are accepting submissions for [shadows](#shadows).

The questionnaire / survey will remain open for 2 weeks. Once closed, the respective role leads within the Release Team will have 1 week to review and select their shadows based on the role's specific handbook criteria and fit.

### Membership

Try to ensure potential Release Team candidates:
- can commit to the amount of time required across the release cycle
- are enthusiastic about being on the release team
- are members of the relevant SIGs for their role, if applicable
- have some prior experience with contributing to Kubernetes (such as shadowing a role for a prior release)

Most importantly, strive for diversity in:
- gender identity
- ethnicity
- nationality
- locality
- company affiliation

## Selection Criteria

### Release Team Lead

The incoming Release Team Lead _MUST_ have participated on the Release Team for two or more release cycles, acting in a lead (non-shadow) or Release Team Lead shadow capacity for at least one of those cycles

Release Team Leads should be staffed, with this order of fall-through in mind:
- the current pool of Release Team Lead shadows
- the current pool of Release Team members
- former Release Team members

Bear in mind that these are suggestions based on precedent and a Release Team Lead may be nominated by any Release Team member, past or present.

_The new Release Team Lead can be selected via lazy consensus of the current Release Team members._

### Release Team Lead Shadow

Same as [Release Team Lead](#release-team-lead).

### <a name="shadows"></a>Shadows

Every Release Team role should seek to accommodate a set of role shadows. This creates a new avenue for code and non-code contributors alike to contribute to the project. Additionally, it seeds future release cycles with new leaders.

While there isn't a strict restriction on the amount of shadows, we've found three shadows per role to be a reasonable upper bound. However, as shadowing is intended to be a mentor / mentee journey, it is important that role leads only accept an amount of shadows that they feel that can reasonably mentor within the scope of a release cycle.

If there are more contributors interested in shadowing once hitting that upper bound, we welcome them to sit in on Release Team meetings in preparation for shadowing in a future release cycle.

In Kubernetes 1.14, we begun handling shadow selection using a questionnaire, as opposed to the first-come, first-served GitHub issue approach that we had adopted during previous release cycles ([1.12](https://github.com/kubernetes/sig-release/issues/167), [1.13](https://github.com/kubernetes/sig-release/issues/280).

Moving to a [questionnaire](#sample-questionnaire) / survey format will allow us to capture more of the information required to vet potential shadows and well as begin to generate metrics around some of the Release Team processes.

Questionnaire creation will be facilitated by SIG Release Chairs or a delegated coordinator to ensure consistency across release cycles.

Following submissions, the questionnaires will be reviewed by role leads of the incoming Release Team.

Volunteers that meet the requirements of the respective role will be contacted by those leads via some convenient mechanism (Slack, video chat, etc.) to further discuss.

After vetting the volunteers for their roles, role leads should make a final decision on selected shadows with the incoming Release Team Lead.


### Sample Questionnaire

Thank you for volunteering for the Kubernetes 1.14 Release Team! 

This questionnaire is meant to learn a little bit more about you, your journey with Kubernetes, your understanding of the Release Team processes and procedures, as well as to determine if you're a good fit for the current Release Team. Please note that you are expected to be inexperienced in some areas, as a role shadow is a mentorship opportunity.

Participation in the Release Team can include somewhat open-ended expectations. We never know what blocking/critical issue may come up at what point during the release cycle. On a rare occasion this may mean we each make some personal sacrifice to check in on a status or show up at a meeting to give or receive information. The team of leads and shadows must be flexible and pragmatic in addressing these. The Release Team Lead will endeavor to make sure any such inconveniences do not unfairly hit individuals or specific timezones.

#### Logistics

- What [Release Team role(s)](https://git.k8s.io/sig-release/release-team#kubernetes-release-team-roles) are you interested in shadowing? _[Select up to two (2)]_
- The [Role Handbooks](https://git.k8s.io/sig-release/release-team/role-handbooks) defines the tasks and responsibilities of each role for this release cycle. Are you prepared to assist in fulfilling these duties? You must read the handbook relevant to the role you're interested in before answering.
- Shadowing Release Team roles requires a substantial time commitment, especially during the periods specified in your role handbook. The time requirements specified are estimates and depending on the need, you may need to dedicate more time than initially estimated. This may include attending video meetings at inconvenient times. Is this time you can commit to? (This usually requires support from your employer, as you may need to do release work during work hours.)
- Do you have any schedule conflicts during [this release cycle](https://git.k8s.io/sig-release/releases/release-1.14/README.md), such as vacations, school, or intense periods of work, that would make you unavailable for more than a couple of workdays?
- The purpose of shadowing is to train new Release Team members. Assuming that your job or life situations don't change between now and then, are you willing to volunteer for the relevant role Lead position for 1.15 or 1.16? (This usually requires support from your employer, as you may need to do release work during work hours.)
- What time zone are you usually in?

#### Experience

- What's your current experience and involvement with Kubernetes SIGs?
- Are you already a [Kubernetes organization member](https://git.k8s.io/community/community-membership.md#member)?
- Have you applied to, or served on, a prior release team? Please give details.
- Do you have any past experience (outside of the Kubernetes upstream community) working/volunteering in the role you're interested in? Please give details.
- Is there any specific goal you hope to accomplish or experience you intend to gain by participating in the Release Team? Please give details.
