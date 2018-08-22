# Kubernetes 1.10 Release Schedule
*Handy Links:*
* [Release Team](http://bit.ly/k8s110-team)
* [Zoom](http://bit.ly/k8s110-zoom)
* [Slack](https://kubernetes.slack.com/messages/sig-release/)
* [Forum](https://groups.google.com/forum/#!forum/kubernetes-sig-release)
* [Feature Tracking Sheet](https://docs.google.com/spreadsheets/d/17bZrKTk8dOx5nomLrD1-93uBfajK5JS-v1o-nCLJmzE/edit?usp=sharing)
* [Milestone Process](https://github.com/kubernetes/community/blob/master/contributors/devel/release/issues.md)
* [Burndown / Meeting Minutes](http://bit.ly/k8s110-burndown)
* [Retrospective Document](http://bit.ly/kube110retro)

**tl;dr** The 1.10 release cycle begins on **Tuesday, January 2nd, 2018**, and ends on release day, **Wednesday, March 21st**.  Feature freeze is **Monday, January 22nd**.  Code freeze begins **Monday February 26th** and ends **Wednesday, March 14th**. Docs must be completed and reviewed by **Friday, March 9th**.

## Notes About this Release

* The feature process is remaining as it has in prior releases. 
* Features that don't have complete code and tests by [Code Freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md#code-freeze) may be disabled by the release team before cutting the first beta.
* The release team will escalate [release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking) failures to SIGs throughout the cycle, not just near release cuts.
* Key deliverables (e.g. initial release cuts) tend to be scheduled on Tuesdays to maintain context while ramping up and then responding to any problems.  The final release will be on a Wednesday in keeping with prior practice.
* The release length is nearly 12 weeks
* Code name "*Left Shark*" because it's been my favorite meme of the release cycle (Thanks [Christoph](https://github.com/cblecker))

## Timeline

<table>
  <tr>
    <td>What</td>
    <td>Who</td>
    <td>JAN</td>
    <td>FEB</td>
    <td>MAR</td>
    <td>APR</td>
    <td>DEV WEEK</td>
    <td>TEST GATES</td>
  </tr>
  <tr>
    <td>Start of Release Cycle</td>
    <td>Lead</td>
    <td>2</td>
    <td></td>
    <td></td>
    <td></td>
    <td>week 1</td>
    <td></td>
  </tr>
  <tr>
    <td>Finalize Schedule</td>
    <td>Lead</td>
    <td>5</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Begin collecting planned work from SIGs</td>
    <td>Lead, Features Lead</td>
    <td>8</td>
    <td></td>
    <td></td>
    <td></td>
    <td>week 2</td>
    <td></td>
  </tr>
  <tr>
    <td>Begin weekly release team meetings</td>
    <td>Lead</td>
    <td>9</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Begin weekly status reports at Community</td>
    <td>Lead, Shadow</td>
    <td>11</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Finalize Release Team</td>
    <td>Lead</td>
    <td>12</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Start Release Notes Draft</td>
    <td>Release Notes Lead</td>
    <td>15</td>
    <td></td>
    <td></td>
    <td></td>
    <td>week 3</td>
    <td></td>
  </tr>
  <tr>
    <td>Clean up features repo</td>
    <td>Features Lead</td>
    <td>15</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>1.10.0-alpha.2 release</td>
    <td>Branch Manager</td>
    <td>16</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td>master-blocking</td>
  </tr>
  <tr>
    <td>"Feature Freeze" begins (EOD PST)</td>
    <td>Feature Lead</td>
    <td>22</td>
    <td></td>
    <td></td>
    <td></td>
    <td>week 4</td>
    <td></td>
  </tr>
  <tr>
    <td>1.10.0-alpha.3 release</td>
    <td>Branch Manager</td>
    <td>30</td>
    <td></td>
    <td></td>
    <td></td>
    <td>week 5</td>
    <td>master-blocking</td>
  </tr>
  <tr>
    <td>Blog post: what we're working on for 1.10</td>
    <td>Communications</td>
    <td></td>
    <td>6</td>
    <td></td>
    <td></td>
    <td>week 6</td>
    <td></td>
  </tr>
  <tr>
    <td>1.10.0-beta.0 release</td>
    <td>Branch Manager</td>
    <td></td>
    <td>13</td>
    <td></td>
    <td></td>
    <td>week 7</td>
    <td>master-blocking, master-upgrade</td>
  </tr>
  <tr>
    <td>Create 'release-1.10' branch and begin daily branchff</td>
    <td>Branch Manager</td>
    <td></td>
    <td>13</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>All release branch CI jobs created</td>
    <td>Test Infra Lead</td>
    <td></td>
    <td>16</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Begin Code Slush</td>
    <td>Bot, Lead</td>
    <td></td>
    <td>20</td>
    <td></td>
    <td></td>
    <td>week 8</td>
    <td></td>
  </tr>
  <tr>
    <td>Begin code freeze (EOD PST)</td>
    <td>Bot, Lead</td>
    <td></td>
    <td>26</td>
    <td></td>
    <td></td>
    <td>week 9</td>
    <td>1.10-blocking, master-blocking, master-upgrade</td>
  </tr>
  <tr>
    <td>Begin MWF Burndown meetings</td>
    <td>Lead</td>
    <td></td>
    <td>26</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Begin pruning</td>
    <td>Lead and release team</td>
    <td></td>
    <td>26</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>1.10.0-beta.1 release</td>
    <td>Branch Manager</td>
    <td></td>
    <td>27</td>
    <td></td>
    <td></td>
    <td></td>
    <td>1.10-blocking, master-blocking, master-upgrade</td>
  </tr>
  <tr>
    <td>Docs deadline - PRs ready for review</td>
    <td>Docs Lead</td>
    <td></td>
    <td></td>
    <td>2</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>1.10.0-beta.2 release</td>
    <td>Branch Manager</td>
    <td></td>
    <td></td>
    <td>6</td>
    <td></td>
    <td>week 10</td>
    <td>1.10-blocking, master-blocking, master-upgrade</td>
  </tr>
  <tr>
    <td>Docs complete - All PRs reviewed and ready to merge</td>
    <td>Docs Lead</td>
    <td></td>
    <td></td>
    <td>9</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Begin M-F Burndown meetings</td>
    <td>Lead</td>
    <td></td>
    <td></td>
    <td>12</td>
    <td></td>
    <td>week 11</td>
    <td></td>
  </tr>
  <tr>
    <td>End of code freeze (EOD PST)</td>
    <td>Bot, Lead</td>
    <td></td>
    <td></td>
    <td>19</td>
    <td></td>
    <td>week 12</td>
    <td></td>
  </tr>
  <tr>
    <td>Perform final branchff</td>
    <td>Branch Manager</td>
    <td></td>
    <td></td>
    <td>19</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>1.10.0-rc.1 release</td>
    <td>Branch Manager</td>
    <td></td>
    <td></td>
    <td>19</td>
    <td></td>
    <td></td>
    <td>1.10-blocking, master-blocking, master-upgrade</td>
  </tr>
  <tr>
    <td>Master branch re-opens for 1.11</td>
    <td>Bot, Branch Manager</td>
    <td></td>
    <td></td>
    <td>19</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>PRs for v1.10.0 must be cherry picked to release-1.10</td>
    <td>Branch Manager</td>
    <td></td>
    <td></td>
    <td>19</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Notify kubernetes-dev of lifting code freeze</td>
    <td>Lead</td>
    <td></td>
    <td></td>
    <td>20</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>v1.10.0</td>
    <td>Branch Manager</td>
    <td></td>
    <td></td>
    <td>26</td>
    <td></td>
    <td>week 13</td>
    <td>1.10-blocking</td>
  </tr>
  <tr>
    <td>v1.11.0-alpha.1</td>
    <td>Branch Manager</td>
    <td></td>
    <td></td>
    <td>27</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Release retrospective</td>
    <td>Community</td>
    <td></td>
    <td></td>
    <td>29</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>1.11 Release Cycle Begins</td>
    <td>Next Lead</td>
    <td></td>
    <td></td>
    <td></td>
    <td>2</td>
    <td></td>
    <td></td>
  </tr>
</table>

## Details

### Feature Freeze

All features going into the release must have an associated issue in the features repo by Monday, January 22nd. That issue must be in the 1.10 milestone.  SIG "themes" should also be in the release notes draft at this time to prepare for blog posts and release marketing.  Any work the SIG wants publicized needs to be called out to the Features Lead so the Release Team communications lead can work with SIG-PM and the CNCF. 

### Code Slush

Starting on Tuesday, February 20th, only PRs labeled by their owner SIGs with [`status/approved-for-milestone`](/ephemera/issues.md)will be allowed to merge into the master branch. All others will be deferred until the end of Code Freeze, when master opens back up for the next release cycle. If necessary, the release team can add the `status/approved-for-milestone` label in cases where the SIG approvers do not have permissions to do so.

Code Slush begins prior to Code Freeze to help reduce noise from miscellaneous changes that aren't related to issues that SIGs have approved for the milestone. Feature work is still allowed at this point, but it must follow the process to get approved for the milestone. SIGs are the gatekeepers of this label, not the release team.

#### Exceptions

Starting at Code Slush, the release team will solicit and rule on [exception requests](https://github.com/kubernetes/features/blob/master/EXCEPTIONS.md) for feature and test work that is unlikely to be done by Code Freeze. As with the `status/approved-for-milestone` label, the exception approval is the responsibility of the SIG or SIGs labeled in the pull request. The release team may intervene or deny the request only if it poses a risk to release quality, or could negatively impact the overall timeline. Changes introduced at this point should be well-tested, well-understood, limited in architectural scope, and low risk.  All of those factors should be considered in the approval process.

### Code Freeze

All features going into the release must be code-complete (including tests) and have docs PRs open by Monday, February 26th.

The docs PRs don't have to be ready to merge, but it should be clear what the topic will be and who is responsible for writing it. This person will become the primary contact for the documentation lead. It’s incredibly important that documentation work gets completed as quickly as possible. 

After this point, only release-blocking issues and PRs will be allowed in the milestone. The milestone bot will remove anything that lacks the priority/critical-urgent label, as well as other required labels.

### Pruning

Features that are partially implemented and/or lack sufficient tests may be considered for pruning beginning after code freeze, unless they've been granted exceptions.

The release team will work with SIGs and feature owners to evaluate each case, but for example, pruning could include actions such as:

* Disabling the use of a new API or field
* Switching the default value of a flag or field
* Moving a new API or field behind an Alpha feature gate
* Reverting commits or deleting code

This needs to occur before 1.10.0-beta.1 is cut so we have time to gather signal on whether the system is stable in this state. These are considered drastic measures, so the release team will strive to coordinate at-risk work with SIGs before this time. The goal is to make code freeze, and overall project transparency, enforceable despite the lack of a feature branch process.

### Docs

If a feature needs documentation, enter Yes in the feature tracking spreadsheet and add a link to the documentation PR. You can open documentation PRs in the [kubernetes/website](https://github.com/kubernetes/website) repository. If you have questions, the release documentation lead, or representatives from SIG-Docs will be happy to assist you.

For documentation PRs:

* Open PRs against the release-1.10 branch based off of the 1.10 release PR. The documentation workflow uses feature branches for release documentation, rather than basing from master. **Be sure to open your PR against the release branch**.
* Add your PR to the 1.10 Release milestone.

### Burndown

Burndown meetings are held on Mondays, Wednesdays and Fridays at 10AM Pacific until the final release is near, and then every business day until the release.  On Thursdays of the final 2 weeks, the meeting will happen alongside the Community Meeting.

Join the [Kubernetes Milestone Burndown Group](https://groups.google.com/forum/#!forum/kubernetes-milestone-burndown) to get the calendar invite.

The intent of these meetings is to:

* Focus on fixing bugs, eliminating test flakes and general release stabilization.
* Ensure docs and release notes are written and accurate.
* Identify all features going into the release, and make sure alpha, beta, ga is marked in features repo.
* Provide a [one-stop view of release progress](http://bit.ly/k8s110-burndown) including relevant release metrics.
* Host SIG stakeholders for updates.
