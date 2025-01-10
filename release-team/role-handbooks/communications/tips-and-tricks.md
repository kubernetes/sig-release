### Tips and best practices

#### Use the 2 week guideline

Try to give 2 weeks notice for all deadlines and requests for reviews. When planning to reach out for blog opt-in or asking for reviews on blog drafts, you should start posting messages or have blog drafts ready for review at least two weeks from the deadline. Especially when asking for blog reviews, as the blog team is understaffed, this will give reviewers enough time to do the review and you enough time to address any feedback. This is best effort guideline, as the schedule does not always allow for this much lead time before a deadline.

#### Reaching out to KEP owners, blog authors, and reviewers

Post messages to GitHub or in SIG slack channels for the best visibility into ongoing work and to allow other contributors to help. Having messages in the KEPs, blog PRs, or SIG slack channels, can help centralize information about the work being done and any outstanding issues. If you need to escalate an issue to Release Leads or SIG Chairs, having public messages/records of conversations can make it easy to tag who you need to. 

If you do use direct messages to contact someone during a release, post summaries of the conversation to PRs or SIG slack channels. This way everyone can stay up-to-date on the ongoing work.

#### Deadlines

As much as possible stick to the comms deadlines set in the release schedule for the mid-cycle blog and main release blog. This will ensure that no release-blocking issues come up and that all blogs go out when they need to.

Feature blog deadlines are a little more flexible compared to other release deadlines. Because the feature blogs are published after the release, there is usually more wiggle room on the deadlines. In general, as long as blog authors are responsive and blog content is getting added/reviewed, its OK to give authors extra time to finish their work. If you need to, you can publish the blog later in the publicaiton schedule to give the author and reviewers more time to complete the blog. If you feel that a blog author is not responsive, progress is not being made, and the dealines have been stretched too far, escalate to the release or SIG chairs or cancel the blog. A blog can always been written outside of the release cycle.

##### An example process to handle blog opt-in deadlines

Pushing deadlines is a common practice in the release team, but it's not always clear how to handle it for Comms since we don't have a hard deadline like code/docs freeze. 
Here's a proposal for a process to handle the push of deadlines for blogs:

- Talk with the Release Lead about the new deadline and the reason for the push;
- Push the new deadline out with a clear message to the author(s) and the SIGs involved;
- Ask the author(s) to confirm if they are ready for review on the new deadline;
- Are you ready for review on the new (pushed back) deadline?
  - If yes, comms decides the feature blog publishing date and follows through to get the SIGs to review and push sig docs to do the same (eventually providing additional review);
  - If not, the feature blog follows the standard sig docs process, the approvers decide when to publish and the responsibility of reaching out to SIGs for the tech review passes to the author;

This eases up our work as Comms after the release is complete and helps sig-docs not to have a big urgent backlog of blogs to review.

#### Useful queries on the enhancement board

My issues as comms-opt-in-assignee:
`https://github.com/orgs/kubernetes/projects/195/views/4?filterQuery=comms-opt-in-assignee%3A<username>`

All the issues that are tracked for the enhancements freeze:
`https://github.com/orgs/kubernetes/projects/195/views/4?filterQuery=status%3A%22Tracked+for+enhancements+freeze%22+&sortedBy%5Bdirection%5D=desc&sortedBy%5BcolumnId%5D=Status`

All issues tracked for enhancement freeze + at risk for code freeze, with a placeholder created:
`https://github.com/orgs/kubernetes/projects/195/views/4?filterQuery=status%3A%22Tracked+for+enhancements+freeze%22%2C%22At+risk+for+code+freeze%22+blog-status%3A%22Placeholder+created%22&sortedBy%5Bdirection%5D=desc&sortedBy%5BcolumnId%5D=Status&sortedBy%5Bdirection%5D=asc&sortedBy%5BcolumnId%5D=130436282`

All issues tracked for code freeze and exceptions (after code freeze), that have a placeholder created, with a link assigned:
`https://github.com/orgs/kubernetes/projects/195/views/4?filterQuery=status%3A%22Tracked+for+code+freeze%22%2C%22Exception+Required%22+has%3Apod-pr`

#### KEP statuses for Comms purposes

These are the possible values of Blog Status in the enhancement board explained:

- `Opted-in` - the owner replied to your comment on the issue, expressing their interest in having a blog about their KEP
- `Opted-out` - the owner replied to your comment on the issue, saying that there won't be a blog - this can be for various reason that we don't ask as we don't necessarily need to know why!
- `Placeholder created` - the owner created a placeholder PR and linked it in the KEP - in this last case, "Placeholder created" we also fill the field "pod-PR" with the GitHub link. (see picture #2)
- `Opted out (no answer)` value to track the lack of communication around the blog opt-in. Only after deadline
- `Cancelled` - when the KEP is cancelled or the author doesn't want to proceed with the blog anymore, it can be used to track blogs that fell off the release cycle too due to deadlines being missed.
- `Ready for review` - when the content of the blog is ready for review, communicate with SIG-docs-(blog) to get the content review started and with the SIGs involved to get the tech review needed.
- `Merged` - when the blog is merged and ready to be scheduled.
- `Scheduled` - when the blog is scheduled for publication on the Kubernetes blog.
- `Published` - when the blog is published, it can be used to track the status of the blog post-release.

#### I was asked to rebase my blogs, help me!

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

_Yes, you can do everything in a single rebase command, but if you are not used to how git works, doing it in two steps helps avoiding mistakes_