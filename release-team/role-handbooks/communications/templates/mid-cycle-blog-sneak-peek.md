# Outline for the release mid-cycle blog
This outline can be used as a reference for writing up the mid cycle release blog in case of sneak peek is required. Deprecations and removal are required in case there are any.

The following sections should give you an idea what can be considered for this mid-cycle blog, but it's not necessary to include every section. Include the ones that make sense for the features/announcements in the release.

* Introduction to the current status of the release
* The Kubernetes API Removal and Deprecation process
* Notes of important removals or deprecations (if any)
* Ongoing major changes (multi-release deprecations still in flight)
* Breaking changes (behaviour changes that can break running workloads, separate from removals)
* Changes (KEPs) that are deemed to be interesting
    * Order release features by impact, maturity, vision or grouped by SIG.
    * This section lists out the key features (even if they are not being recommended to be used in production or are alphas).
    * Call out important API deprecations and removals
    * When possible, link upstream docs or KEP docs (past blogs link k/enhancement issues)
* Want to know more? (include the planned release date)
* Get involved
    * SIGs
    * New Contributor Orientations
    * Kubernetes contributor guide
    * Kubernetes blog
    * Slack, X, LinkedIn, Bluesky
    * Discuss and Stack Overflow (where to ask or answer questions)
    * Kubernetes End User Stories
    * Kubernetes Release Team


## Release Mid-Cycle Blog Template

The template should give you some boilerplate. However, this blog is optional and each release has its own story to tell. You can be creative with it!

```md
---
layout: blog
title: 'Kubernetes v1.XX Sneak Peek'
date: 202n-mm-ddT08:00:00-08:00
slug: kubernetes-v1-XX-sneak-peek
author: >
  [Comms team members, ordered by last name ascending]
---

As we get closer to the release date for Kubernetes v1.xx, the project develops and matures, features may be deprecated, removed, or replaced with better ones for the project's overall health. This blog outlines some of the planned changes for the Kubernetes 1.xx release, that the release team feels you should be aware of for the continued maintenance of your Kubernetes environment and keeping up to date with the latest changes. The information listed below is based on the current status of the v1.xx release and may change before the actual release date. 

### The Kubernetes API Removal and Deprecation process
The Kubernetes project has a well-documented [deprecation policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/) for features. This policy states that stable APIs may only be deprecated when a newer, stable version of that same API is available and that APIs have a minimum lifetime for each stability level. A deprecated API has been marked for removal in a future Kubernetes release, it will continue to function until removal (at least one year from the deprecation), but usage will result in a warning being displayed. Removed APIs are no longer available in the current version, at which point you must migrate to using the replacement.

* Generally available (GA) or stable API versions may be marked as deprecated but must not be removed within a major version of Kubernetes.

* Beta or pre-release API versions must be supported for 3 releases after the deprecation.

* Alpha or experimental API versions may be removed in any release without prior deprecation notice, this process can become a withdrawal in cases where a different implementation for the same feature is already in place.

Whether an API is removed as a result of a feature graduating from beta to stable or because that API simply did not succeed, all removals comply with this deprecation policy. Whenever an API is removed, migration options are communicated in the [documentation](https://kubernetes.io/docs/reference/using-api/deprecation-guide/).

## A note about xxx - Comms Lead

Here you can insert a note about a topic of the release or tangential to it. This can be a note about a feature, a process, or a community initiative that you think is important to highlight in the mid-cycle blog.

## Deprecations and removals for Kubernetes v1.xx

### <Component>: <what is deprecated or removed>
<one or two paragraphs; link the tracking issue or KEP. Add an {#anchor-id} only if this entry is likely to be linked from elsewhere.>
- Repeat for every removal or deprecation in this release

## Ongoing major changes

### <Multi-release deprecation still in flight> {#anchor-id}
<which release it lands in, and the temporary override if one exists>

## Breaking changes in Kubernetes v1.xx

### <Behaviour change that can break running workloads> {#anchor-id}
<who is affected, and how to keep the previous behaviour>

## Featured enhancements of Kubernetes v1.xx

The following list of enhancements is likely to be included in the upcoming v1.xx release. This is not a commitment and the release content is subject to change.

### <Feature name and maturity, e.g. "Metrics API goes GA"> {#anchor-id}
<insert here a KEP explanation paragraph>

To learn more about this enhancement, refer to [KEP-xxxx: <title>](https://kubernetes.dev/resources/keps/xxxx).
- Repeat for every KEP that is interesting for the release

## Want to know more?
New features and deprecations are also announced in the Kubernetes release notes. We will formally announce what's new in [Kubernetes v1.xx](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.xx.md) as part of the CHANGELOG for that release.

Kubernetes v1.xx release is planned for **<Weekday, Month DDth, YYYY>**. Stay tuned for updates!

You can see the announcements of changes in the release notes for:

<!-- Only list releases the community currently supports — see the patch release support period: https://kubernetes.io/releases/patch-releases/#support-period. Update this list each cycle: drop the oldest entry, add the new one. -->
* [Kubernetes v1.36](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.36.md)

* [Kubernetes v1.35](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.35.md)

* [Kubernetes v1.34](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.34.md)

* [Kubernetes v1.33](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.33.md)

## Get involved

The simplest way to get involved with Kubernetes is by joining one of the many [Special Interest Groups](https://kubernetes.dev/community/community-groups/sigs/) (SIGs) that align with your interests.

If you don't know where to start, join our monthly [New Contributor Orientations](https://www.kubernetes.dev/docs/orientation/)
where we teach the community how the project is structured, and we'll guide you on how to make your first contribution to the project.

- Read more on how to become a [Kubernetes Contributor](https://www.kubernetes.dev/docs/guide/)
- Read more about what’s happening with Kubernetes on our [blog](https://kubernetes.io/blog/)
- Join us on [Slack](http://slack.k8s.io/)
- Follow us on [X](https://x.com/kubernetesio)
- Follow us on [LinkedIn](https://www.linkedin.com/company/kubernetes/)
- Follow us on [Bluesky](https://bsky.app/profile/kubernetes.io) for the latest updates
- Join the community discussion on [Discuss](https://discuss.kubernetes.io/)
- Post questions (or answer questions) on [Stack Overflow](http://stackoverflow.com/questions/tagged/kubernetes)
- Share your [Kubernetes End User Story](https://www.cncf.io/case-studies/)
- Learn more about the [Kubernetes Release Team](https://github.com/kubernetes/sig-release/tree/master/release-team)
```