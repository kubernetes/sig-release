# Initial Reach-out

This is a message to send to enhancement owners to opt in to write a feature blog for their enhancement, it should be sent on the KEP issue.
After this message is sent, the Comms team will follow up with the enhancement owner to help them keep in mind the timeline for the feature blog, every 1-2 weeks.

```
Hi @xx 👋 

This is <Comms shadow/lead name> from the <current release cycle version> Communications Team!

For the <current version> release, we are in the process of collecting and curating a list of potential feature blogs, and we'd love for you to consider writing one for your enhancement!

As you may be aware, feature blogs are a great way to communicate to users about features which fall into (but not limited to) the following categories:
- This KEP introduces some breaking change(s)
- This KEP has significant impacts and/or implications for Kubernetes users
- ...Or this is a long-awaited feature, in which case a blog would go a long way to cover the journey more in detail.

To opt in to write a feature blog, could you please let us know and open a "Feature Blog placeholder PR" (which can be only a skeleton at first) against the [website repository](https://github.com/kubernetes/website) by **<insert deadline here>**? For more information about writing a blog, please find the [blog contribution guidelines](https://kubernetes.io/docs/contribute/new-content/blogs-case-studies/#technical-considerations-for-submitting-a-blog-post) 📚

Some timelines to keep in mind:
- <insert feature blog freeze deadline here>: Feature blog PR freeze
- <insert feature blog ready for review here>: Feature blogs ready for review
- You can find more in the [release document](https://github.com/kubernetes/sig-release/tree/master/releases/release-<version>#timeline)

**Note**: In your placeholder PR, use the current scheduled overall release date for the blog `date` and add a `draft:true` to the front matter. This will help us to merging this ahead of the release date and scheduling it after the release date.

If you have any questions or need help, please feel free to reach out to me or any of the Communications Team members. We are here to help you!
```

----

Another template you could use with GitHub callouts:

```
Hi @xx 👋 -- this is YOURNAME (@your_github_id) from the x.yy Communications Team!

For the x.yy release, we are currently in the process of collecting and curating a list of potential feature blogs, and we'd love for you to consider writing one for your enhancement!

As you may be aware, feature blogs are a great way to communicate to users about features which fall into (but not limited to) the following categories:
- This introduces some breaking change(s)
- This has significant impacts and/or implications to users
- ...Or this is a long-awaited feature, which would go a long way to cover the journey more in detail 🎉 

To opt in to write a feature blog, could you please let us know and open a "Feature Blog placeholder PR" (which can be only a skeleton at first) against the [website repository](https://github.com/kubernetes/website) by **<<BLOG_PLACEHOLDER_DEADLINE>> WEEKDAY, DAY MONTH**? For more information about writing a blog, please find the [blog contribution guidelines](https://kubernetes.io/docs/contribute/new-content/blogs-case-studies/#technical-considerations-for-submitting-a-blog-post) 📚

> [!Tip]
> Some timeline to keep in mind:
> - **02:00 UTC <<BLOG_PLACEHOLDER_DEADLINE>> WEEKDAY, DAY MONTH**: Feature blog PR freeze
> - **<<BLOG_READY>> WEEKDAY, DAY MONTH**: Feature blogs ready for review
> - You can find more in the [release document](LINK)
> 

> [!Note]
> In your placeholder PR, use `XX` characters for the blog `date` in the front matter and file name. We will work with you on updating the PR with the publication date once we have a final number of feature blogs for this release.
```

With this one, you'd need to update the following placeholders:
- `@xx`: Mention KEP's primary contact(s), assignee(s), and even potentially other members who are actively working on the KEP
- `YOURNAME`: Your name, as you prefer
- `your_github_id`: Your GitHub ID
- `x.yy`: The upcoming Kubernetes version, such as 1.33, 1.34, etc.
- Dates: There are 2 separate dates; one for the placeholder PR, and another for the blog ready for review
  - `<<BLOG_PLACEHOLDER_DEADLINE>> WEEKDAY, DAY MONTH`: Deadline for the placeholder PR, which is usually at 02:00 UTC on Wednesday (on week 8)
  - `<<BLOG_READY>> WEEKDAY, DAY MONTH`: Deadline for the Feature Blogs being ready for review, which is usually on week 13
- `LINK`: Add a link to the release document, such as `https://github.com/kubernetes/sig-release/tree/master/releases/release-1.33#timeline`

# Follow-up

```
Hi @xx 👋, x.yy Communications Team here again!

This is a gentle reminder for the feature blog deadline mentioned above, which is **02:00 UTC <<BLOG_PLACEHOLDER_DEADLINE>> WEEKDAY, DAY MONTH**. To opt in, please let us know and open a Feature Blog placeholder PR against [`k/website`](https://github.com/kubernetes/website) by the deadline. If you have any questions, please feel free to reach out to us!

> [!Tip]
> Some timeline to keep in mind:
> - **02:00 UTC <<BLOG_PLACEHOLDER_DEADLINE>> WEEKDAY, DAY MONTH**: Feature blog PR freeze
> - **<<BLOG_READY>> WEEKDAY, DAY MONTH**: Feature blogs ready for review
> - You can find more in the [release document](LINK)
> 

> [!Note]
> In your placeholder PR, use `XX` characters for the blog `date` in the front matter and file name. We will work with you on updating the PR with the publication date once we have a final number of feature blogs for this release.
```

With this one, you'd need to update the following placeholders:
- `@xx`: Mention KEP's primary contact(s), assignee(s), and even potentially other members who are actively working on the KEP
- `x.yy`: The upcoming Kubernetes version, such as 1.33, 1.34, etc.
- Dates: There are 2 separate dates; one for the placeholder PR, and another for the blog ready for review
  - `<<BLOG_PLACEHOLDER_DEADLINE>> WEEKDAY, DAY MONTH`: Deadline for the placeholder PR, which is usually at 02:00 UTC on Wednesday (on week 8)
  - `<<BLOG_READY>> WEEKDAY, DAY MONTH`: Deadline for the Feature Blogs being ready for review, which is usually on week 13
- `LINK`: Add a link to the release document, such as `https://github.com/kubernetes/sig-release/tree/master/releases/release-1.33#timeline`

