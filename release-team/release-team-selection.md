# Release Team Selection

In addition to discharging the duties of their respective Release Team roles, the current Release Team is charged with selecting the team for the following release cycle.

Team selection should happen transparently. Role leads are nominated in a public "Assemble the vX.Y Release Team" issue in this repository (see [Selection Process](#selection-process)), and shadows apply through a questionnaire (see [Shadows](#shadows)).

Each Release Team role is responsible for staffing their respective role, with this order of fall-through in mind:
- training and selecting a successor from the current pool of role shadows
- training and selecting a successor from non-Release Team members
- staffing the role themselves

Ultimately, if none of these can be satisfied, responsibility falls to the future Release Team Lead and SIG Release to staff the roles.

## Considerations

### Timing

Staff early! The timeline below is the one the [Emeritus Adviser handbook](role-handbooks/emeritus-adviser/README.md) and the [shadows guide](shadows.md) follow:

- By Code Freeze of the current cycle, SIG Release leads, the current Release Team Lead and the Emeritus Adviser reach consensus on the next Release Team Lead and Emeritus Adviser. Candidates for the Emeritus Adviser role contact the current Emeritus Adviser and Release Team Lead before Code Freeze.
- At least two weeks before the end of the current cycle, the Emeritus Adviser opens the "Assemble the vX.Y Release Team" issue to nominate and confirm the role leads.
- About two weeks before the new cycle starts, once most of the role leads are confirmed, the Emeritus Adviser publishes the shadow questionnaire. It stays open for about 7 to 10 days.
- Once the questionnaire closes, role leads review the applications and select their [shadows](#shadows) within a week, so that the full team is finalized by the end of the first week of the new cycle (see the "Team finalized" row in the release schedule, for example in [releases/release-1.38/README.md](/releases/release-1.38/README.md)).

Any staffing decisions that cannot be made within this timeframe should be escalated to the SIG Release Chairs and discussed publicly.

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

Consensus must be reached about the next Release Team Lead (RT Lead) by:

- [SIG Release Leads](https://git.k8s.io/community/sig-release/#leadership)
- The current Release Team Lead
- The current Emeritus Adviser

The incoming Release Team Lead _MUST_ have participated on the Release Team for two or more release cycles, acting in a lead (non-shadow) or Release Team Lead shadow capacity for at least one of those cycles.

Release Team Leads should be staffed, with this order of fall-through in mind:

- the current pool of Release Team Lead shadows
- the current pool of Release Team members
- former Release Team members

Bear in mind that these are suggestions based on precedent and a Release Team Lead may be nominated by any Release Team member, past or present.

#### Selection Process

At least 2 weeks before the end of the current release cycle, the EA is responsible for
posting the "Assemble the X.Y Release Team" issue in the SIG Release repo
([example](https://github.com/kubernetes/sig-release/issues/776)). Before doing
that, it's required to reach consensus with all [SIG Release Leads](https://git.k8s.io/community/sig-release/#leadership)
about the next Release Team Lead as well as EA, which can be done by using a
Slack group DM or an email thread to sig-release-leads@kubernetes.io. If consensus has been reached, then the
proposed Release Team can get nominated directly within that issue. After that,
the issue can act as a call for nominations/volunteers for the other Role Leads.

### Release Team Lead Shadow

Same as [Release Team Lead](#release-team-lead).

The release lead should reach out to all release lead shadows and release team leads directly from the previous cycle to gather input from people interested in helping shadowing the new release.

### <a name="shadows"></a>Shadows

Every Release Team role should seek to accommodate a set of role shadows. This creates a new avenue for code and non-code contributors alike to contribute to the project. Additionally, it seeds future release cycles with new leaders.

While there isn't a strict restriction on the amount of shadows, recent teams have taken four to six shadows per role.
As shadowing is intended to be a mentor / mentee journey, it is important that role leads only
accept an amount of shadows that they feel they can reasonably mentor within the scope of a release cycle. As there is
tacit knowledge gained from Release Team experience, we've found that having two shadows with prior Release Team
experience has been helpful to seed and grow future release team leaders. In addition to two shadows with prior Release
Team experience, we have found that having two new shadows helps grow contributors to the Release Team. Having two
shadows with prior Release Team experience and two new shadows per Release Team role is not a requirement and is a
suggestion.

If there are more contributors interested in shadowing once hitting that upper bound, we welcome them to sit in on Release Team meetings in preparation for shadowing in a future release cycle.

Shadows are selected using a [questionnaire](#sample-questionnaire), which captures the information required to vet potential shadows and allows us to generate metrics around the Release Team processes.

The questionnaire is maintained by the Emeritus Adviser, who publishes it following the [timing](#timing) above, to ensure consistency across release cycles.

Following submissions, the questionnaires will be reviewed by role leads of the incoming Release Team.

Volunteers that meet the requirements of the respective role will be contacted by those leads via some convenient mechanism (Slack, video chat, etc.) to further discuss.

After vetting the volunteers for their roles, role leads should make a final decision on selected shadows with the incoming Release Team Lead. Once selections have been finalized, each role lead should submit a PR to the `release-team.md` file of the release directory to add the selected shadows. The Emeritus Adviser notifies the applicants who were not selected.

### Sample Questionnaire

Thank you for volunteering for the Kubernetes v1.XX Release Team!

This questionnaire is meant to learn a little bit more about you, your journey with Kubernetes, your understanding of the Release Team processes and procedures, as well as to determine if you're a good fit for the current Release Team. Please note that you are expected to be inexperienced in some areas, as a role shadow is a mentorship opportunity.

Participation in the Release Team can include somewhat open-ended expectations. We never know what blocking/critical issue may come up at what point during the release cycle. On a rare occasion this may mean we each make some personal sacrifice to check in on a status or show up at a meeting to give or receive information. The team of leads and shadows must be flexible and pragmatic in addressing these. The Release Team Lead will endeavor to make sure any such inconveniences do not unfairly hit individuals or specific timezones.

#### Logistics

- What [Release Team role(s)](README.md#kubernetes-release-team-roles) are you interested in shadowing? _[Select up to two (2)]_
- The [Role Handbooks](role-handbooks/README.md) define the tasks and responsibilities of each role for this release cycle. Are you prepared to assist in fulfilling these duties? You must read the handbook relevant to the role you're interested in before answering.
- Shadowing Release Team roles requires a substantial time commitment, especially during the periods specified in your role handbook. The time requirements specified are estimates and depending on the need, you may need to dedicate more time than initially estimated. This may include attending video meetings at inconvenient times. Is this time you can commit to? (This usually requires support from your employer, as you may need to do release work during work hours.)
- Do you have any schedule conflicts during this release cycle (see the schedule in the `releases/release-1.XX/README.md` file), such as vacations, school, or intense periods of work, that would make you unavailable for more than a couple of workdays?
- The purpose of shadowing is to train new Release Team members. Assuming that your job or life situations don't change between now and then, are you willing to volunteer for the relevant role Lead position in one of the next two release cycles? (This usually requires support from your employer, as you may need to do release work during work hours.)
- What time zone are you usually in?

#### Experience

- What's your current experience and involvement with Kubernetes SIGs?
- Are you already a [Kubernetes organization member](https://git.k8s.io/community/community-membership.md#member)?
- Have you applied to, or served on, a prior release team? Please give details.
- Do you have any past experience (outside of the Kubernetes upstream community) working/volunteering in the role you're interested in? Please give details.
- Is there any specific goal you hope to accomplish or experience you intend to gain by participating in the Release Team? Please give details.
