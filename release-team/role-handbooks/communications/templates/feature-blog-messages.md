# Feature Blog Opt-in

## Initial Reach-out

This is a message to send to enhancement owners to opt in to write a feature blog for their enhancement. It should be sent on the KEP issue once the Enhancements Freeze is in effect.
After this message is sent, the Comms team will follow up with the enhancement owner every 1-2 weeks to help them keep the feature blog timeline in mind.

```
Hi @<KEP owners> 👋 -- this is <your name> (@<your GitHub handle>) from the v1.XX Communications Team!

For the v1.XX release, we are currently in the process of collecting and curating a list of potential feature blogs, and we'd love for you to consider writing one for your enhancement!

**Please note that feature blogs are optional and not mandatory.** However, they are a great way to communicate to users about features which fall into (but not limited to) the following categories:
- This introduces some breaking change(s)
- This has significant impacts and/or implications to users
- ...Or this is a long-awaited feature, which would go a long way to cover the journey more in detail 🎉

To opt in to write a feature blog, could you please let us know and open a "Feature Blog placeholder PR" (which can be only a skeleton at first) against the [website repository](https://github.com/kubernetes/website) by **<feature blog freeze deadline, weekday, day month>**? For more information about writing a blog, please find the [release communications guidelines](https://kubernetes.io/docs/contribute/blog/release-comms/) 📚

For easier tracking, please let us know whether you'd like to opt in or opt out. If you're opting in, please include the skeleton blog PR in your reply.

> [!Tip]
> Some timeline to keep in mind:
> - **<feature blog freeze deadline, weekday, day month>**: Feature blog freeze (opt-in and placeholder PR deadline)
> - **<feature blogs ready for review deadline, weekday, day month>**: Feature blogs ready for review
> - You can find more in the [release document](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.XX#timeline)

> [!Note]
> Title your blog PR in the following format: "[WIP] KEP:<number>: <name> blog". In your placeholder PR, add `draft:true` to the front matter to indicate its draft status. This will help us merge this blog prior to the release date and schedule it after the release date.
```

Placeholders to replace:
- `@<KEP owners>`: Mention the KEP's primary contact(s), assignee(s), and potentially other members who are actively working on the KEP
- `<your name>` and `@<your GitHub handle>`: Your name, as you prefer, and your GitHub handle
- `v1.XX`: The upcoming Kubernetes version
- `<feature blog freeze deadline>`: The "Feature blog freeze" milestone from the release schedule, which is the single deadline for both opting in and opening the placeholder PR (v1.38 example: week 10)
- `<feature blogs ready for review deadline>`: The "Feature blogs ready to review" milestone from the release schedule (v1.38 example: week 14)
- `release-1.XX`: The release directory for the current cycle

## Follow-up

```
Hi @<KEP owners> 👋, v1.XX Communications Team here again!

This is a gentle reminder for the feature blog deadline mentioned above, which is **<feature blog freeze deadline, weekday, day month>**. To opt in, please let us know and open a Feature Blog placeholder PR against [`k/website`](https://github.com/kubernetes/website) by the deadline. If you have any questions, please feel free to reach out to us!

> [!Tip]
> Some timeline to keep in mind:
> - **<feature blog freeze deadline, weekday, day month>**: Feature blog freeze (opt-in and placeholder PR deadline)
> - **<feature blogs ready for review deadline, weekday, day month>**: Feature blogs ready for review
> - You can find more in the [release document](https://github.com/kubernetes/sig-release/tree/master/releases/release-1.XX#timeline)
```

The placeholders are the same as in the initial reach-out.

# Feature Blog PR

## "Ready for review" deadline reminder

This is a message to send Feature Blog authors in their Feature Blog PR if they haven't marked it as "ready for review" a few days before the deadline.

```
Hi @<PR authors> 👋 -- this is <your name> (@<your GitHub handle>) from the v1.XX Communications Team!

Just a friendly reminder that we are approaching the feature blog "ready for review" deadline: **<feature blogs ready for review deadline, weekday, day month>**. We ask you to have the blog in non-draft state by retitling it using `/retitle` to remove the "[WIP]" from the title, while retaining `draft:true` in the front matter. Additionally, ensure that the write-up is complete so that we can start the blog review from the SIG Docs Blog team.

If you have any questions or need help, please don't hesitate to reach out to me or any of the Communications Team members. We are here to help you!
```

Placeholders to replace:
- `@<PR authors>`: Mention the Feature Blog PR author(s)
- `<your name>` and `@<your GitHub handle>`: Your name, as you prefer, and your GitHub handle
- `v1.XX`: The upcoming Kubernetes version
- `<feature blogs ready for review deadline>`: The "Feature blogs ready to review" milestone from the release schedule
