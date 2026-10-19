# Outline for the Deprecations and Removals blog

This outline can be used as a reference for writing the optional Deprecations and Removals blog, published mid-cycle as the "Kubernetes v1.XX sneak peek" post. Deprecations and removals are required content whenever the release has any; the other sections are optional.

The following sections should give you an idea what can be considered for this blog, but it's not necessary to include every section. Include the ones that make sense for the features and announcements in the release.

* Introduction to the current status of the release
* The Kubernetes API Removal and Deprecation process
* Notes of important removals or deprecations (if any)
* Ongoing major changes (multi-release deprecations still in flight)
* Breaking changes (behaviour changes that can break running workloads, separate from removals)
* Changes (KEPs) that are deemed to be interesting
    * Order release features by impact, maturity, vision or grouped by SIG.
    * This section lists out the key features (even if they are not being recommended to be used in production or are alphas).
    * Call out important API deprecations and removals
    * When possible, link upstream docs or KEP docs (past blogs link k/enhancements issues)
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

## Deprecations and Removals blog template

The template should give you some boilerplate. However, this blog is optional and each release has its own story to tell. You can be creative with it!

Placeholders: `v1.XX` is the release in development, `v1.XX-1`, `v1.XX-2` and `v1.XX-3` are the currently supported releases, and everything else in angle brackets is described inline.

```md
---
layout: blog
title: 'Kubernetes v1.XX sneak peek'
date: <YYYY-MM-DD>
slug: kubernetes-v1-XX-sneak-peek
author: >
  [Kubernetes v1.XX Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md)
---

**Editors:** <Comms team members, ordered by last name ascending>

As we get closer to the release date for Kubernetes v1.XX, the project develops and matures, features may be deprecated, removed, or replaced with better ones for the project's overall health. This blog outlines some of the planned changes for the Kubernetes v1.XX release, that the release team feels you should be aware of for the continued maintenance of your Kubernetes environment and keeping up to date with the latest changes. The information listed below is based on the current status of the v1.XX release and may change before the actual release date.

## The Kubernetes API Removal and Deprecation process

<Add this section only if API deprecations or removals are present in this release; otherwise skip it.>

The Kubernetes project has a well-documented [deprecation policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/) for features. This policy states that stable APIs may only be deprecated when a newer, stable version of that same API is available and that APIs have a minimum lifetime for each stability level. A deprecated API has been marked for removal in a future Kubernetes release, it will continue to function until removal (at least one year from the deprecation), but usage will result in a warning being displayed. Removed APIs are no longer available in the current version, at which point you must migrate to using the replacement.

* Generally available (GA) or stable API versions may be marked as deprecated but must not be removed within a major version of Kubernetes.

* Beta or pre-release API versions must be supported for 3 releases after the deprecation.

* Alpha or experimental API versions may be removed in any release without prior deprecation notice, this process can become a withdrawal in cases where a different implementation for the same feature is already in place.

Whether an API is removed as a result of a feature graduating from beta to stable or because that API simply did not succeed, all removals comply with this deprecation policy. Whenever an API is removed, migration options are communicated in the [documentation](https://kubernetes.io/docs/reference/using-api/deprecation-guide/).

## A note about <topic>

<Optional. Here you can insert a note about a topic of the release or tangential to it. This can be a note about a feature, a process, or a community initiative that you think is important to highlight in this blog.>

## Deprecations and removals for Kubernetes v1.XX

### <Component>: <what is deprecated or removed>

<One or two paragraphs; link the tracking issue or KEP. Add an {#anchor-id} only if this entry is likely to be linked from elsewhere. Avoid linking the KEP number in the title, only add it in the "read more" section. Repeat for every removal or deprecation in this release.>

## Ongoing major changes

<Optional.>

### <Multi-release deprecation still in flight> {#anchor-id}

<Avoid naming the release it would land in, mention the temporary override if one exists.>

## Breaking changes in Kubernetes v1.XX

<Optional.>

### <Behaviour change that can break running workloads> {#anchor-id}

<Who is affected, and how to keep the previous behaviour.>

## Featured enhancements of Kubernetes v1.XX

The following list of enhancements is likely to be included in the upcoming v1.XX release. This is not a commitment and the release content is subject to change.

### <Feature name and maturity, e.g. "Metrics API goes GA"> {#anchor-id}

<Insert here a KEP explanation paragraph.>

To learn more about this enhancement, refer to [KEP-<number>: <title>](https://www.kubernetes.dev/resources/keps/<number>/).

<Repeat for every KEP that is interesting for the release.>

## Want to know more?

New features and deprecations are also announced in the Kubernetes release notes. We will formally announce what's new in [Kubernetes v1.XX](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX.md) as part of the CHANGELOG for that release.

The Kubernetes v1.XX release is planned for **<Weekday, Month DDth, YYYY>**. Stay tuned for updates!

You can see the announcements of changes in the release notes for:

<!-- Only list releases the community currently supports, see the patch release support period: https://kubernetes.io/releases/patch-releases/#support-period. Update this list each cycle: drop the oldest entry, add the new one. -->
* [Kubernetes v1.XX-1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX-1.md)

* [Kubernetes v1.XX-2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX-2.md)

* [Kubernetes v1.XX-3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX-3.md)

## Get involved

The simplest way to get involved with Kubernetes is by joining one of the many [Special Interest Groups](https://www.kubernetes.dev/community/community-groups/sigs/) (SIGs) that align with your interests.

If you don't know where to start, join our monthly [New Contributor Orientations](https://www.kubernetes.dev/docs/orientation/)
where we teach the community how the project is structured, and we'll guide you on how to make your first contribution to the project.

- Read more on how to become a [Kubernetes Contributor](https://www.kubernetes.dev/docs/guide/)
- Read more about what's happening with Kubernetes on our [blog](https://kubernetes.io/blog/)
- Join us on [Slack](https://slack.k8s.io/)
- Follow us on [X](https://x.com/kubernetesio)
- Follow us on [LinkedIn](https://www.linkedin.com/company/kubernetes/)
- Follow us on [Bluesky](https://bsky.app/profile/kubernetes.io) for the latest updates
- Join the community discussion on [Discuss](https://discuss.kubernetes.io/)
- Post questions (or answer questions) on [Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes)
- Share your [Kubernetes End User Story](https://www.cncf.io/case-studies/)
- Learn more about the [Kubernetes Release Team](https://github.com/kubernetes/sig-release/tree/master/release-team)
```
