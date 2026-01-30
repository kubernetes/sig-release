# Communication Templates

In all the templates, replace the text in `{ }` with appropriate values.

The freeze dates/times can be found at `https://github.com/kubernetes/sig-release/blob/master/releases/release-{version}/README.md`.

## PRR Freeze Templates

If the Enhancement Issue **does not** meet the criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, {current release} Enhancements team here.

This is a reminder of the upcoming [PRR freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#prr-freeze) on **{ PRR_FREEZE_DATETIME }**.

This enhancement is targeting stage `{stage}` for {current release} (correct me, if otherwise)

Here's where this enhancement currently stands:

- [ ] PR open or merged with the KEP's [PRR questionnaire](https://github.com/kubernetes/enhancements/tree/master/keps/NNNN-kep-template#production-readiness-review-questionnaire) filled out.
- [ ] PR open or merged with [kep.yaml](https://github.com/kubernetes/enhancements/blob/master/keps/NNNN-kep-template/kep.yaml) updated with the `stage`, `latest-milestone`, and `milestone` struct filled out.
- [ ] PR open or merged with a [PRR approval file](https://github.com/kubernetes/enhancements/blob/master/keps/prod-readiness/template/nnnn.yaml) with the PRR approver listed for the stage the KEP is targeting.

For this KEP, we would just need to update the following:
- {insert list of action items}

Note that the PR is not required to be approved or merged by the PRR freeze deadline. Having the PRR questionnaire filled out by the deadline will help ensure that the PRR team has enough time to review your KEP before **enhancements freeze on { ENHANCEMENTS_FREEZE_DATETIME }**. For more information on the PRR process, see [here](https://github.com/kubernetes/community/blob/master/sig-architecture/production-readiness.md#submitting-a-kep-for-production-readiness-approval).

The status of this enhancement is marked as `At risk for PRR freeze`. Please keep the issue description up-to-date with appropriate stages as well.

If you anticipate missing PRR freeze, you can file an [exception request](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md) in advance. Thank you!
```

Then make sure the status of the enhancement is set to `At risk for PRR freeze`.

If the Enhancement Issue **does** meet the criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, {current release} Enhancements team here.

This is a reminder of the upcoming [PRR freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#prr-freeze) on **{ PRR_FREEZE_DATETIME }**.

This enhancement is targeting stage `{stage}` for {current release} (correct me, if otherwise)

Here's where this enhancement currently stands:

- [x] PR open or merged with the KEP's [PRR questionnaire](https://github.com/kubernetes/enhancements/tree/master/keps/NNNN-kep-template#production-readiness-review-questionnaire) filled out.
- [x] PR open or merged with [kep.yaml](https://github.com/kubernetes/enhancements/blob/master/keps/NNNN-kep-template/kep.yaml) updated with the `stage`, `latest-milestone`, and `milestone` struct filled out.
- [x] PR open or merged with a [PRR approval file](https://github.com/kubernetes/enhancements/blob/master/keps/prod-readiness/template/nnnn.yaml) with the PRR approver listed for the stage the KEP is targeting.

Note that the PR is not required to be approved or merged by the PRR freeze deadline. Having the PRR questionnaire filled out by the deadline will help ensure that the PRR team has enough time to review your KEP before **enhancements freeze on { ENHANCEMENTS_FREEZE_DATETIME }**. For more information on the PRR process, see [here](https://github.com/kubernetes/community/blob/master/sig-architecture/production-readiness.md#submitting-a-kep-for-production-readiness-approval).

With all the PRR freeze requirements in place, this enhancement is now marked as `Tracked for PRR freeze`! Please keep the issue description up-to-date with appropriate stages as well.

/label tracked/yes
```

Then make sure the status of the enhancement is set to `Tracked for PRR freeze`.

## Enhancement Freeze Templates

If the Enhancement Issue **does not** meet the criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, {current release} Enhancements team here.

Just checking in as we approach [enhancements freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#enhancements-freeze) on **{ ENHANCEMENTS_FREEZE_DATETIME }**.

This enhancement is targeting stage `{stage}` for {current release} (correct me, if otherwise)

Here's where this enhancement currently stands:

- [ ] KEP readme using the [latest template](https://github.com/kubernetes/enhancements/tree/master/keps/NNNN-kep-template) has been merged into the k/enhancements repo.
- [ ] KEP status is marked as `implementable` for `latest-milestone: { CURRENT_RELEASE }`.
- [ ] KEP readme has up-to-date graduation criteria.
- [ ] KEP has a production readiness review that has been completed and merged into k/enhancements. (For more information on the PRR process, check [here](https://github.com/kubernetes/community/blob/master/sig-architecture/production-readiness.md#submitting-a-kep-for-production-readiness-approval)).
- [ ] There are no other outstanding (unmerged) PRs that modify the KEP readme or kep.yaml file.

For this KEP, we would just need to update the following:
- {insert list of action items}

The status of this enhancement is marked as `At risk for enhancements freeze`. Please keep the issue description up-to-date with appropriate stages as well.

If you anticipate missing enhancements freeze, you can file an [exception request](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md) in advance. Thank you!
```

Then make sure the status of the enhancement is set to `At risk for enhancements freeze`.

If the Enhancement Issue **does** meet the criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, {current release} Enhancements team here.

Just checking in as we approach [enhancements freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#enhancements-freeze) on **{ ENHANCEMENTS_FREEZE_DATETIME }**.

This enhancement is targeting stage `{stage}` for {current release} (correct me, if otherwise)

Here’s where this enhancement currently stands:

- [X] KEP readme using the [latest template](https://github.com/kubernetes/enhancements/tree/master/keps/NNNN-kep-template) has been merged into the k/enhancements repo.
- [X] KEP status is marked as `implementable` for `latest-milestone: { CURRENT_RELEASE }`. KEPs targeting `stable` will need to be marked as `implemented` after code PRs are merged.
- [X] KEP readme has up-to-date graduation criteria.
- [X] KEP has [submitted a production readiness review](https://github.com/kubernetes/community/blob/master/sig-architecture/production-readiness.md#submitting-a-kep-for-production-readiness-approval) request for approval and has a reviewer assigned.
- [X] KEP has a production readiness review that has been completed and merged into k/enhancements. (For more information on the PRR process, check [here](https://github.com/kubernetes/community/blob/master/sig-architecture/production-readiness.md#submitting-a-kep-for-production-readiness-approval)).
- [X] There are no other outstanding (unmerged) PRs that modify the KEP readme or kep.yaml file.

With all the KEP requirements in place and merged into k/enhancements, this enhancement is all good for the upcoming enhancements freeze. 🚀

The status of this enhancement is marked as `Tracked for enhancements freeze`. Please keep the issue description up-to-date with appropriate stages as well. Thank you!

/label tracked/yes
```

Then make sure the status of the enhancement is set to `Tracked for enhancements freeze`.

## Enhancements Freeze Party Templates

If the Enhancement Issue **does not** meet the enhancement freeze criteria for inclusion in the current release use this template in Issue comments:

```markdown 
Hello {enhancement owner} 👋, {current release} Enhancements team here.

Unfortunately, this enhancement did not meet requirements for [enhancements freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#enhancements-freeze).

If you still wish to progress this enhancement in {current release}, please file an [exception](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md) request as soon as possible, within three days. If you have any questions, you can reach out in the #release-enhancements channel on Slack and we'll be happy to help. Thanks!

/remove-label tracked/yes
/label tracked/no
/milestone clear
```

Then make sure the status of the enhancement is set to `Removed from Milestone`. 

If the Enhancement Issue **does** meet the enhancement freeze criteria for inclusion in the current release (and has not already been marked as `Tracked for enhancements freeze`), use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, {current release} Enhancements team here.

With all the requirements fulfilled, this enhancement is now marked as tracked for the upcoming enhancements freeze 🚀

/label tracked/yes
```

Then make sure the status of the enhancement is set to `Tracked for enhancements freeze`.

## Code Freeze Templates

> **Note**: Refer to the [What Changes Require Tracking](#what-changes-require-tracking) section for guidance on whether your KEP needs to be tracked by the Release Team and marked as `Tracked for code freeze`.

If the Enhancement Issue **does not** meet the code freeze criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hey again {enhancement owner} 👋, {current release} Enhancements team here,

Just checking in as we approach [code freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#code-freeze) and [test freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#test-freeze) at **{ CODE_FREEZE_DATETIME }**.

Here's where this enhancement currently stands:

- [ ] All PRs to the Kubernetes repo that are related to your enhancement are linked in the above issue description (for tracking purposes).
- [ ] All PRs are ready to be merged (they have `approved` and `lgtm` labels applied) by the code freeze deadline. This **includes** tests.

Per the issue description, these are all of the implementation (code-related) PRs for {current release}, some of which are not merged yet:
- { list of PRs associated with this enhancement }

Please let me know (and keep the issue description updated) if there are any other PRs in [`k/k`](https://github.com/kubernetes/kubernetes) that we should track for this KEP, so that we can maintain accurate status.

If the implementation work for this enhancement is occurring **out-of-tree** (i.e., outside of `k/k`), please link the relevant PRs in the issue description for visibility. Alternatively, if you're unable to provide specific PR links, a confirmation that **all out-of-tree implementation work is complete and merged** will help us finalize tracking and maintain accuracy.

The status of this enhancement is marked as `At risk for code freeze`.

If you anticipate missing code freeze, you can file an [exception request](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md) in advance.
```

Then make sure the status of the enhancement is set to `At risk for code freeze`.

If the Enhancement Issue **does** meet the code freeze criteria for inclusion in the current release use this template in Issue comments:

```markdown
Hey again {enhancement owner} 👋, {current release} Enhancements team here,

Just checking in as we approach [code freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#code-freeze) and [test freeze](https://github.com/kubernetes/sig-release/blob/master/releases/release_phases.md#test-freeze) at **{ CODE_FREEZE_DATETIME }**.

Here's where this enhancement currently stands:

- [x] All PRs to the Kubernetes repo that are related to your enhancement are linked in the above issue description (for tracking purposes).
- [x] All PRs are ready to be merged (they have `approved` and `lgtm` labels applied) by the code freeze deadline. This **includes** tests.

Per the issue description, these are all of the implementation (code-related) PRs for {current release}:
- { list of PRs associated with this enhancement }

Please let me know (and keep the issue description updated) if there are any other PRs in [`k/k`](https://github.com/kubernetes/kubernetes) that we should track for this KEP, so that we can maintain accurate status.

If the implementation work for this enhancement is occurring **out-of-tree** (i.e., outside of `k/k`), please link the relevant PRs in the issue description for visibility. Alternatively, if you're unable to provide specific PR links, a confirmation that **all out-of-tree implementation work is complete and merged** will help us finalize tracking and maintain accuracy.

This enhancement is now marked as `Tracked for code freeze`!

Please note that KEPs targeting `stable` need to have the `status` field marked as `implemented` in the kep.yaml file after code PRs are merged.

/label tracked/yes
```

Then make sure the status of the enhancement is set to `Tracked for code freeze`.

# Code Freeze Party Templates

If the Enhancement Issue **does not** meet the code freeze criteria for inclusion in the current release use this template in Issue comments:

```markdown 
Hello {enhancement owner} 👋, {current release} Enhancements team here,

Unfortunately, the implementation (code-related) PRs associated with this enhancement are not in the merge-ready state by code-freeze and hence this enhancement is now removed from the {current release} milestone.

<!-- Use the following paragraph if not all implementation PRs for the KEP were merged before freeze deadline -->
Additionally, if **any of the merged implementation PRs** for this enhancement include **user-facing changes**, please let us know. This will help us determine whether the changes should be documented or considered for rollback to maintain release integrity.

If you still wish to progress this enhancement in {current release}, please file an [exception](https://github.com/kubernetes/sig-release/blob/master/releases/EXCEPTIONS.md) request as soon as possible, within three days. If you have any questions, you can reach out in the #release-enhancements channel on Slack and we'll be happy to help. Thanks!

/remove-label tracked/yes
/label tracked/no
/milestone clear
```

Then make sure the status of the enhancement is set to `Removed from Milestone`.

If the Enhancement Issue **does** meet the code freeze criteria for inclusion in the current release (and has not already been marked as `Tracked for code freeze`), use this template in Issue comments:

```markdown
Hello {enhancement owner} 👋, {current release} Enhancements team here.

With all the implementation (code-related) PRs merged per the issue description:
- {insert list of code prs}

This enhancement is now marked as `Tracked for code freeze` for the {current release} Code Freeze!

Please note that KEPs targeting `stable` need to have the `status` field marked as `implemented` in the kep.yaml file after code PRs are merged.

/label tracked/yes
```

Then make sure the status of the enhancement is set to `Tracked for code freeze`.

## SIG Outreach Templates (optional)

For SIGs which have opted to include Enhancements in the current release:

```markdown
Hello SIG { SIG_NAME }! Enhancements team here.
Just checking in as we approach PRR freeze at { PRR_FREEZE_DATETIME }.
Your SIG has submitted { X } enhancements for the { CURRENT_RELEASE } cycle, and { Y } enhancements are currently `At risk for PRR freeze`.
Refer to the [announcement here]({link to announcement for current release cycle}) for the list of review requirements.
If your SIG still plans to submit more enhancements, follow the [instructions here]({link to announcement for current release cycle}) so the enhancements team can begin tracking.
Please plan to make KEP updates to meet all the requirements before enhancement freeze.
Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.
```

For SIGs which have not opted to include Enhancements in the current release:

```markdown
Hello SIG {{ SIG_NAME }}. Enhancements team here.
Just checking in as we approach PRR freeze at {{ PRR_FREEZE_DATETIME }}.
Your SIG has not submitted any enhancements for the { CURRENT_RELEASE } cycle.
If your SIG still plans to submit an enhancement, follow the [instructions here]({link to announcement for current release cycle}) so the enhancements team can begin tracking.
If your SIG is not planning to submit an enhancement, please reply to this message to confirm.
Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.
```
