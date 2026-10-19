# Communications tips and tricks

Advice collected by previous Communications Leads and shadows. The process itself is described in the [Communications handbook](README.md).

## Use the 2 week guideline

Try to give 2 weeks notice for all deadlines and requests for reviews. When planning to reach out for blog opt-in or asking for reviews on blog drafts, you should start posting messages or have blog drafts ready for review at least two weeks from the deadline. Especially when asking for blog reviews, as the blog team is understaffed, this will give reviewers enough time to do the review and you enough time to address any feedback. This is a best effort guideline, as the schedule does not always allow for this much lead time before a deadline.

## Reaching out to KEP owners, blog authors, and reviewers

Post messages to GitHub or in SIG Slack channels for the best visibility into ongoing work and to allow other contributors to help. Having messages in the KEPs, blog PRs, or SIG Slack channels can help centralize information about the work being done and any outstanding issues. If you need to escalate an issue to the Release Team Lead or SIG Chairs, having public messages and records of conversations makes it easy to tag who you need to.

If you do use direct messages to contact someone during a release, post summaries of the conversation to PRs or SIG Slack channels. This way everyone can stay up to date on the ongoing work.

## Deadlines

As much as possible stick to the comms deadlines set in the release schedule for the Deprecations and Removals blog and the release blog. This will ensure that no release-blocking issues come up and that all blogs go out when they need to.

Feature blog deadlines are a little more flexible compared to other release deadlines. Because the feature blogs are published after the release, there is usually more wiggle room on the deadlines. In general, as long as blog authors are responsive and blog content is getting added and reviewed, it's OK to give authors extra time to finish their work. If you need to, you can publish the blog later in the publication schedule to give the author and reviewers more time to complete the blog. If you feel that a blog author is not responsive, progress is not being made, and the deadlines have been stretched too far, escalate to the Release Team Lead or SIG Chairs, or cancel the blog. A blog can always be written outside of the release cycle.

### Handling pushed feature blog deadlines

Pushing deadlines is a common practice in the release team, but it's not always clear how to handle it for Comms since we don't have a hard deadline like Code Freeze or Docs Freeze. When a feature blog deadline has to move:

1. Talk with the Release Team Lead about the new deadline and the reason for the push.
2. Announce the new deadline with a clear message to the author(s) and the SIGs involved.
3. Ask the author(s) to confirm whether they will be ready for review on the new deadline.
   - If yes, Comms decides the feature blog publishing date and follows through to get the SIGs to review, and asks SIG Docs Blog to do the same (eventually providing additional review).
   - If not, the feature blog follows the standard SIG Docs Blog process: the approvers decide when to publish and the responsibility of reaching out to SIGs for the tech review passes to the author.

This eases up our work as Comms after the release is complete and helps SIG Docs Blog not to have a big urgent backlog of blogs to review.

## Useful views on the Release Tracking Board

The Release Tracking Board for the current cycle is linked from `releases/release-1.XX/links.md`. Open its Feature Blog view and use the filter box to build these views; save the ones you use often as personal views:

- **My KEPs as comms opt-in assignee:** filter `comms-opt-in-assignee:<your GitHub handle>`.
- **All KEPs tracked for Enhancements Freeze:** filter `status:"Tracked for enhancements freeze"`, sorted by status.
- **KEPs tracked for Enhancements Freeze or at risk for Code Freeze that already have a placeholder PR:** filter `status:"Tracked for enhancements freeze","At risk for code freeze" blog-status:"Placeholder created"`.
- **KEPs tracked for Code Freeze or with an exception that have a placeholder PR linked:** filter `status:"Tracked for code freeze","Exception Required" has:pod-pr`.

The exact field and status names live on the board; adjust the filters if the current cycle's board uses different ones.

## Blog status values for Comms purposes

The Release Tracking Board records two things per KEP: the outcome of the opt-in outreach, and the stage of the blog once a PR exists. The stage names match the ones reported in the [weekly status update](templates/weekly-status-update.md).

Opt-in outcome:

- `Opted-in`: the owner replied to your comment on the issue, expressing their interest in having a blog about their KEP.
- `Opted-out`: the owner replied to your comment on the issue, saying that there won't be a blog. This can be for various reasons that we don't ask about, as we don't necessarily need to know why.
- `Opted-out (no answer)`: tracks the lack of communication around the blog opt-in. Only set after the deadline.
- `Cancelled`: the KEP is cancelled or the author doesn't want to proceed with the blog anymore. Also used to track blogs that fell off the release cycle due to missed deadlines.

Blog stage:

- `Placeholder created`: the owner created a placeholder PR and linked it in the KEP. Fill the `pod-PR` field with the PR link at the same time. The weekly status update counts these as `Placeholder (WIP/Ready, not asked for review)` or `No Content` depending on whether the PR has content.
- `Ready for review`: the content of the blog is ready for review. Communicate with SIG Docs Blog to get the content review started and with the SIGs involved to get the tech review needed.
- `Review in progress`: editorial or tech review has started.
- `Merged`: the blog is merged (as a draft) and ready to be scheduled.
- `Scheduled`: the blog is scheduled for publication on the Kubernetes blog.
- `Published`: the blog is published. Used to track the status of the blog post-release.

## I was asked to rebase my blog, help me!

In case you are asked to rebase (on main) and squash:

```bash
# > sync your fork with the latest "main" of the upstream via the GitHub UI <

git clone # your fork

# rebase on main
git checkout # your fork's branch
git remote add upstream https://github.com/kubernetes/website.git
git fetch upstream
git rebase upstream/main
git push -f

# squash all commits
git rebase -i upstream/main
# change all to "squash" except the first one to "pick" as example:
# pick 123abc Commit message 1
# squash 456def Commit message 2
# :wq
# edit commit message (dd to delete line, i to insert, :wq to save and exit)
# wait for rebase
git push -f
```

_Yes, you can do everything in a single rebase command, but if you are not used to how git works, doing it in two steps helps avoid mistakes._
