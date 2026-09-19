# SIG Outreach

We need to reach out to each SIG via Slack reminding them to submit enhancements.
See full list of SIGs here: https://github.com/kubernetes/community/blob/master/sig-list.md 
- `sig-k8s-infra` can be skipped, as they have previously requested to be excluded from outreach.

For each of your assigned SIGs:
- Use the `KEPs by SIG` insight view on the tracking board to see how many enhancements each SIG has currently opted into the release:
  - { TRACKING_BOARD_INSIGHTS_LINK e.g. `https://github.com/orgs/kubernetes/projects/<id>/insights`}
- Fill in the `Opt-in?` column of the table below with one of the following values:
  - `Yes (already opted in)` - if they have at least one KEP on the board
  - `No (waiting for confirmation)` - if they don't have any KEPs on the board
  - `No (confirmed)` - if they don't have any KEPs and they responded to your slack message confirming that
- Post a message in their slack channel (`#sig-<name>`) using the appropriate template from below.
  - The SIG may or may not respond; that is OK, as long as we have reached out.
- Fill in the `Reach-out date` column with the date reached out.
- Fill in the `Slack link` column with a link to the slack message.

## SIG Outreach Assignments

| SIG | Assignee | Opt-in? | Reach-out date | Slack link |
| :---- | :---- | :---- | :---- | :---- |
| sig-api-machinery |  |  |  |  |
| sig-apps |  |  |  |  |
| sig-architecture |  |  |  |  |
| sig-auth |  |  |  |  |
| sig-autoscaling |  |  |  |  |
| sig-cli |  |  |  |  |
| sig-cloud-provider |  |  |  |  |
| sig-cluster-lifecycle |  |  |  |  |
| sig-contribex |  |  |  |  |
| sig-docs |  |  |  |  |
| sig-etcd |  |  |  |  |
| sig-instrumentation |  |  |  |  |
| sig-k8s-infra | N/A | N/A | N/A | N/A |
| sig-multicluster |  |  |  |  |
| sig-network |  |  |  |  |
| sig-node |  |  |  |  |
| sig-release |  |  |  |  |
| sig-scalability |  |  |  |  |
| sig-scheduling |  |  |  |  |
| sig-security |  |  |  |  |
| sig-storage |  |  |  |  |
| sig-testing |  |  |  |  |
| sig-ui |  |  |  |  |
| sig-windows |  |  |  |  |

## SIG Outreach Templates

✅ For SIGs which have already opted in at least one enhancement:

```markdown
Hello #sig-{ SIG_NAME } 👋 { CURRENT_RELEASE } Enhancements team here.

Just checking in as we approach the KEP readiness deadline at { KEP_READINESS_DATETIME } and enhancements freeze at { ENHANCEMENTS_FREEZE_DATETIME }.

Your SIG has submitted `{ X }` enhancements for the { CURRENT_RELEASE } cycle, and { Y } enhancements are currently `At risk for KEP readiness`.

Refer to the [announcement here]({link to announcement for current release cycle}) for the list of review requirements. If your SIG still plans to submit more enhancements, follow the instructions in the announcement so the enhancements team can begin tracking. Please plan to make KEP updates to meet all the requirements before the above freeze deadlines. Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.
```

---

❌ For SIGs which have not yet opted in any enhancements:

```markdown
Hello #sig-{ SIG_NAME } 👋 { CURRENT_RELEASE } Enhancements team here.

Just checking in as we approach the KEP readiness deadline at { KEP_READINESS_DATETIME } and enhancements freeze at { ENHANCEMENTS_FREEZE_DATETIME }.

Your SIG has not submitted any enhancements for the { CURRENT_RELEASE } cycle.

If your SIG still plans to submit an enhancement, follow the [instructions here]({link to announcement for current release cycle}) so the enhancements team can begin tracking. If your SIG is not planning to submit an enhancement, please reply to this message to confirm. Please reach out to [#release-enhancements](https://kubernetes.slack.com/archives/C02BY55KV7E) if you have any questions.
```
