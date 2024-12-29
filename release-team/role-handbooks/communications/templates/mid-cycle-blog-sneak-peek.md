# Outline for the release mid-cycle blog
This outline can be used as reference for writing up the mid cycle release blog in case of sneak peek required. Deprecations and removal is required in case there are any.

The following sections should give you an idea what can be consider for this mid-cycle blog, but it's not necessary to include every section. Include the ones that make sense for the features/announcements in the release.

* Introduction to the current status of the release
* The Kubernetes API Removal and Deprecation process
* Notes of important removals or deprecations (if any)
* Changes (KEPs) that are deemed to be interesting
    * Order release features by impact, maturity, vision or grouped by SIG.
    * This section lists out the key features (even if they are not being recommended to be used in production or are alphas).
    * Call out important API deprecations and removals
    * When possible, link upstream docs or KEP docs (past blogs link k/enhancement issues)
* Want to know more?
* Get involved
    * SIGs
    * Community meeting
    * Where to host questions (or answer questions) 
    * Advocates
    * Bluesky
    * Slack
    * Kubernetes blog


## Release Mid-Cycle Blog Template

The template should give you some boilerplate. However, this blog is optional and each release has its own story to tell. You can be creative with it!

```md
---
layout: blog
title: 'Kubernetes 1.XX: Sneak peek'
date: 202n-mm-dd
slug: kubernetes-1-XX-sneak-peek
author: >
  [Kubernetes v1.XX Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md)
---

**Editors:** [Comms teams members, ordered by last name ascending]

As we get closer to the release date for Kubernetes v1.xx, the project develops and matures, features may be deprecated, removed, or replaced with better ones for the project's overall health. This blog outlines some of the planned changes for the Kubernetes 1.xx release, that the release team feels you should be aware off for the continued mantainance of your Kubernetes enviroment and keeping up to date with the latest changes. Information listed below is based on the current status of the v1.xx release and may change before the actual release date. 

### The Kubernetes API Removal and Deprecation process
The Kubernetes project has a well-documented [deprecation policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/) for features. This policy states that stable APIs may only be deprecated when a newer, stable version of that same API is available and that APIs have a minimum lifetime for each stability level. A deprecated API has been marked for removal in a future Kubernetes release, it will continue to function until removal (at least one year from the deprecation), but usage will result in a warning being displayed. Removed APIs are no longer available in the current version, at which point you must migrate to using the replacement.

* Generally available (GA) or stable API versions may be marked as deprecated but must not be removed within a major version of Kubernetes.

* Beta or pre-release API versions must be supported for 3 releases after the deprecation.

* Alpha or experimental API versions may be removed in any release without prior deprecation notice, this process can become a withdrawal in cases where a different implementation for the same feature is already in place.

Whether an API is removed as a result of a feature graduating from beta to stable or because that API simply did not succeed, all removals comply with this deprecation policy. Whenever an API is removed, migration options are communicated in the [documentation](https://kubernetes.io/docs/reference/using-api/deprecation-guide/).

## A note about xxx - Comms Lead

Here you can insert a note about a topic of the release or tangential to it. This can be a note about a feature, a process, or a community initiative that you think is important to highlight in the mid-cycle blog.

## Sneak peek of Kubernetes 1.xx

### KEP [#xxx](https://github.com/kubernetes/enhancements/issues/xxx) - Comms Owner
<insert here a KEP explaination paragraph>
- Repeat for every KEP that is interesting for the release

## Want to know more?
New features and deprecations are also announced in the Kubernetes release notes. We will formally announce what's new in [Kubernetes v1.xx](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.xx.md) as part of the CHANGELOG for that release.

You can see the announcements of changes in the release notes for:

* [Kubernetes v1.32](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.31.md)

* [Kubernetes v1.31](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.31.md)

* [Kubernetes v1.30](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md)

* [Kubernetes v1.29](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md)

## Get involved

The simplest way to get involved with Kubernetes is by joining one of the many [Special Interest Groups](https://github.com/kubernetes/community/blob/master/sig-list.md) (SIGs) that align with your interests. 
Have something you’d like to broadcast to the Kubernetes community? 
Share your voice at our weekly [community meeting](https://github.com/kubernetes/community/tree/master/communication), and through the channels below. 
Thank you for your continued feedback and support.

- Follow us on Bluesky [@Kubernetesio](https://bsky.app/profile/kubernetes.io) for the latest updates
- Join the community discussion on [Discuss](https://discuss.kubernetes.io/)
- Join the community on [Slack](http://slack.k8s.io/)
- Post questions (or answer questions) on [Stack Overflow](http://stackoverflow.com/questions/tagged/kubernetes)
- Share your Kubernetes [story](https://docs.google.com/a/linuxfoundation.org/forms/d/e/1FAIpQLScuI7Ye3VQHQTwBASrgkjQDSS5TP0g3AXfFhwSM9YpHgxRKFA/viewform)
- Read more about what’s happening with Kubernetes on the [blog](https://kubernetes.io/blog/)
- Learn more about the [Kubernetes Release Team](https://github.com/kubernetes/sig-release/tree/master/release-team)
```