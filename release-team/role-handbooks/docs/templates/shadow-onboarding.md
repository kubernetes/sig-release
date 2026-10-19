# Shadow confirmation and welcome messages

## Confirm interest and availability

Send as a Slack DM or email to each selected shadow.

```markdown
Hello!

You have been selected to be a Kubernetes <future release> Release Docs Shadow. Can you please confirm that you're still interested and available?

Thanks,
<Docs Lead name>
```

## Welcome message

Post in the Docs team Slack group once all shadows have confirmed.

```markdown
Welcome to the Kubernetes <future release> Docs team! :k8s-heart: Beyond just shipping docs, this is a space for collaboration, growth, and fun. Looking forward to learning from each other and making this journey memorable. :kubernetes-intensifies:

Hi everyone! <Introduce yourself with your name, workplace, community involvement, time zone and so on>

I'd love to hear from you all, so please introduce yourself so we can all get to know each other.

We are an inclusive group, so if there's something you're concerned about or don't understand, don't worry and just ask! Also, let me know if there are any issues with being a shadow (timing, availability and so on).
```

## First onboarding tasks

Post in the Docs team Slack group after the welcome message.

```markdown
We'll be collaborating on the <future release> docs over the next few months.

Our team includes both returning and new members, so feel free to ask questions and support one another whenever possible. During this cycle, we'll be working on tasks such as:
- Creating and reviewing release notes PRs.
- Syncing the main branch with the development branch.
- Reaching out to KEP owners to raise placeholder docs PRs.
- Providing status updates during the weekly Release Team meetings and the SIG Docs meetings.

I'll walk you through these tasks during our onboarding call.

**Action items (react to this post with a :white_check_mark: once you've completed them)**:
- Onboarding: complete the [Release Team onboarding guide](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md#new-members).
  - For new members:
    - Review the [community membership guidelines](https://github.com/kubernetes/community/blob/master/community-membership.md).
    - Sign the [CLA](https://github.com/kubernetes/community/blob/master/CLA.md).
      - Tip: the CLA bot is only triggered on your first PR to the `kubernetes` org. To avoid delaying that until you have a real PR, open a test PR in `k/contributor-playground` to trigger it.
    - Apply to become an org member (`kubernetes` and `kubernetes-sigs`) by [creating an issue](https://github.com/kubernetes/org/issues/new?assignees=&labels=area%2Fgithub-membership&template=membership.yml&title=REQUEST%3A+New+membership+for+%3Cyour-GH-handle%3E). Use @<Release Team Subproject Lead> and @<Release Team Lead> as your sponsors.
  - Join the Slack channels and Google Groups listed in the [onboarding guide](https://github.com/kubernetes/sig-release/blob/master/release-team/release-team-onboarding.md#slack).
  - Subscribe to the [Kubernetes release calendar](https://bit.ly/k8s-release-cal).
  - Read the [docs style guide](https://kubernetes.io/docs/contribute/style/style-guide/) before contributing to or reviewing PRs.
  - Read the [Docs handbook](https://github.com/kubernetes/sig-release/tree/master/release-team/role-handbooks/docs) to get an idea of what to expect from the role.

**Resources**:
- Know your timeline: the [release schedule](https://github.com/kubernetes/sig-release/blob/master/releases/release-<future release>/README.md) shows where we are in the cycle and what is expected at each milestone, especially the docs deadlines. I will also provide updates and reminders as we progress.

**Meetings**:
- Shadow onboarding meeting: I'd love to jump on a call to go over the release process, describe what we'll be doing, and answer any questions. Below is a poll to see what time works best for everyone. As we near the end of the release cycle I will add a regular weekly check-in. Please select your preferred time(s): <poll link>
- @<Release Team Subproject Lead> will also host a general release shadow orientation soon, stay tuned!
```
