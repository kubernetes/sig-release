# Release Phases

## Enhancements Freeze
All enhancements wishing to be included in the current release must have
* A KEP in an implementable state
  * Including Testing Plans
  * Including Graduation Criteria
* An open issue in the Release Milestone

If your enhancement does not meet these requirements, it will be removed from the milestone and will require an [Exception].

## Burndown
One week prior to Code Freeze, we increase the cadence of release team meetings
to begin tracking work more closely.  We call this Burndown, because at this
point we have a list of outstanding issues and PRs, and are actively working to
burn that list down.  SIG representatives will be asked to attend if their SIG has
specific outstanding issues that are blocking the release.

Please subscribe to the [Kubernetes Release Calendar][kubernetes-release-calendar] to see meeting events. Burndown meetings
may conflict with other community meetings.  Please prioritize this meeting if
a member of the release team asks you to attend.

The intent of these meetings is to:

* Focus on fixing bugs, eliminating test flakes and general release
  stabilization.
* Ensure docs and release notes are written and accurate.
* Identify all enhancement going into the release, and make sure alpha, beta, GA
  is marked in enhancements repo.
* Provide a one-stop view of release progress via the current meeting notes (TODO: link to the template?) including relevant release metrics.

## Code Freeze

All enhancements going into the release must be code-complete, **including
tests**, and have docs PRs open by the due date.

The docs PRs don't have to be ready to merge, but it should be clear what the
topic will be and who is responsible for writing it. This person will become the
primary contact for the documentation lead. It’s incredibly important that
documentation work gets completed as quickly as possible.

After this point, only release-blocking issues and PRs will be allowed in the
milestone.

## Code Thaw

One week prior to release, it is expected that all but a handful of outstanding
PRs for the relase of kubernetes have landed in the release branch. Assuming the
release team agrees, Code Freeze will be lifted, and we enter Code Thaw.

From this point forward, any PRs intended for the current release must be cherry picked to the
appropriate branch.

## Exceptions

Starting at [Enhancements Freeze] the release team will solicit and rule on
[Exception] requests for enhancements and test work that is unlikely to be done
by Code Freeze. The exception approval is the responsibility of the SIG or SIGs
labeled in the pull request. The release team may intervene or deny the request
only if it poses a risk to release quality, or could negatively impact the overall
timeline. Changes introduced at this point should be well-tested,
well-understood, limited in architectural scope, and low risk.  All of those
factors should be considered in the approval process.  Enhancements on an
feature branch with documentation, test cases, and passing CI are more likely to
be accepted.

## Pruning

Enhancements that are partially implemented and/or lack sufficient tests may be
considered for pruning beginning after [Code Freeze], unless they've been
granted an [Exception](./EXCEPTIONS.md).

The release team will work with SIGs and enhancements owners to evaluate each
case, but for example, pruning could include actions such as:

* Disabling the use of a new API or field
* Switching the default value of a flag or field
* Moving a new API or field behind an Alpha Enhancements gate
* Reverting commits or deleting code

This should occur before 1.x.0-beta.1 is cut so we have time to gather signal
on whether the system is stable in this state. These are considered drastic
measures, so the release team will strive to coordinate at-risk work with SIGs
before this time. The goal is to make code freeze, and overall project
transparency, enforceable despite the lack of a consistently used feature branch
process.

## Docs

If an enhancement needs documentation, enter "Yes" in the enhancement tracking
spreadsheet and add a link to the documentation PR. You can open documentation
PRs in the [kubernetes/website] repository. If you have questions, the release
documentation lead, or representatives from SIG-Docs will be happy to assist
you.

For documentation PRs:

* Open PRs against the dev-1.x branch based off of the current release PR. The
  documentation workflow uses feature branches for release documentation, rather
than basing from master. **Be sure to open your PR against the release branch**.
* Add your PR to the current Release milestone.

[kubernetes/website]: https://github.com/kubernetes/website
[kubernetes-release-calendar]: https://bit.ly/k8s-release-cal
[Exception]: ./EXCEPTIONS.md