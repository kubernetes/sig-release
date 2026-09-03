This message is posted by a Communications team member in the `#release-comms` Slack channel once a week, for the whole release cycle. Assign an owner for each week, the Comms Lead or a shadow, so the update does not depend on one person and shadows get a recurring deliverable.

Posting on the same weekday every week keeps the update easy to find and gives the rest of the Release Team a predictable place to check comms progress without asking. Not every section applies every week: the opt-in counts only make sense once feature blog opt-ins are open, the stage breakdown once blog PRs exist, and the SIG Docs meeting entry only on weeks a comms member attends. Drop the sections that do not apply, and keep the ones that do in the order below.

```
Welcome to week <week number> of the release cycle!

This update will cover important dates and action items that we will be working on over the next 5 days
-----------------------------------------------------------------------------------

Important Dates for Comms
• <deadline or milestone, past or upcoming, for example "Release announcement ready for review deadline will be on Friday, 14th August 2026">.
-----------------------------------------------------------------------------------

Action Items
• <what the comms team is working on this week, one bullet per item>.
-----------------------------------------------------------------------------------

Number of opt-ins:
• Alpha: <count>.
• Beta: <count>.
• Stable: <count>.
• Deprecation/Removal: <count>.
Current number of blogs: <count>
-----------------------------------------------------------------------------------

Number of opt-ins grouped by stage:
• Merged: <count>.
• Review in Progress: <count>.
• Ready for Review: <count>.
• Placeholder(WIP/Ready, not asked for review): <count>.
• No Content: <count>.
-----------------------------------------------------------------------------------

SIG Docs Update (<meeting link>)
• <month DD> (<weekday>).
◦ EMEA Meeting (<time> UTC): <@attendee>.
-----------------------------------------------------------------------------------

Release Team Updates (<meeting link>)
• <month DD> (<weekday>).
◦ APAC Meeting (<time> UTC): <@attendee, "Async", or "<None Yet>">.
◦ EMEA Meeting (<time> UTC): <@attendee, "Async", or "<None Yet>">.
-----------------------------------------------------------------------------------
cc: <@comms team members>

For more information about what I(the comms lead) do on a week-by-week basis, please check: <link to the comms weekly tracking issue>
```

Notes on filling this in:

* **Important Dates for Comms.** Include both the deadlines coming up in the next five days and the ones just met, so the thread doubles as a record of what shipped when. Milestones worth calling out:
  * Feature blog opt-in deadline
  * Release highlights deadline
  * Mid-cycle blog publication
  * Feature blog freeze
  * Feature blog "ready for review" deadline
  * Release announcement ready for review deadline

  Cross-check the dates against the [release cycle timeline](https://www.kubernetes.dev/resources/release/) and the [comms milestone activities](/release-team/role-handbooks/communications/README.md#release-milestone-activities).
* **Number of opt-ins.** Counts come from the comms tracking board. They can move down as well as up, since feature blogs may be pruned after the blog freeze; when that happens, say so inline, for example `Current number of blogs: 30 (Will be pruned)`.
* **Number of opt-ins grouped by stage.** Add this once blog PRs are open. The stages match the columns on the comms tracking board, so group the board by that column rather than counting the cards by hand, and read the totals straight off the groups.
* **Release Team Updates.** One entry per Release Team meeting in the coming week, with the APAC and EMEA slots listed separately, since coverage is assigned per slot. Meeting times and links come from the [Kubernetes community calendar](https://www.kubernetes.dev/resources/calendar/), and the people to assign are on the current cycle's [release team roster](https://github.com/kubernetes/sig-release/tree/master/release-team). Use `Async` when no one attends live and `<None Yet>` when the slot still needs an owner, which doubles as a request for volunteers.
* **Tracking issue.** Link the comms weekly tracking issue for the current cycle ([v1.37 example](https://github.com/kubernetes/sig-release/issues/3027)) so readers can follow the week-by-week breakdown.
