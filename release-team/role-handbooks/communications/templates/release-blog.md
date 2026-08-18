# Outline for the Kubernetes Release Blog
This outline can be used as reference for writing up the release blog. The following sections should give you an idea what can be consider for the blog, but it's not necessary to include every section. Include the ones that make sense for the features/announcements in the release.

* Introduction to release
    * The first paragraph of the release blog announcement introduces the release, its focus, and its importance.
* Spotlight on key updates
    * Three to five picks, one per graduation phase where possible, each heading prefixed with the phase (`Stable:`, `Beta:`, `Alpha:`).
    * Order release features by impact, maturity, vision.
    * This section lists out the key features (even if they are not being recommended to be used in production or are alphas).
        * When we describe something in the alpha state, we are highlighting what is going on (in/to) the community.
        * Release cycles are so short, just because it is alpha right now, it will be stable soon. Position it as “this is what is coming.”
    * Everything else is included in the release notes.
* Changes in Stable, Beta, Alpha
    * One section per phase, one `###` per feature, `####` for sub-features under a grouping heading (for example, DRA or Workload-aware Scheduling).
    * When possible, link upstream docs or KEP docs.
    * State the feature gate and whether it is on or off by default, for every feature.
* Other notable changes
    * Changes that matter to users but don't belong to a single graduation, such as a default flipping or a subproject retirement.
* Graduations, deprecations, and removals
    * Full list of graduations to Stable.
    * Call out important API deprecations and removals, and reconcile them against the mid-cycle Deprecations and Removals blog.
* Known Issues
    * Optional section to call out specific known issues and workarounds, if applicable.
* Release notes
    * Release notes are always included in the blog announcement.
* Availability of release
    * Link to where the release can be downloaded on GitHub.
    * Include tutorials on the current release or how to get started with Kubernetes when relevant.
* Release Team
    * Mention job of release team
    * Important to highlight company contributions in a way that is respectful to the entire community – including a copy of the release team in relation to the project and their work
    * Mention efforts of community
    * Mention the growth of the community
    * List of contributors to the spec should go in the 5 Day blog series
* Project Velocity
    * Growth since the last release
    * Number of companies involved in the release
    * Other relevant velocity numbers from DevStats
* Event Updates
    * Relevant KubeCon dates and information
    * Conferences where the release will be discussed
* Upcoming release webinar
    * CNCF hosts a release webinar 30 days after the release is available. Webinar is conducted by the release team and discusses the current release. Include information on the webinar in the release announcement blog to encourage attendance.
* Get Involved
    * SIGs
    * New Contributor Orientation
    * Where to host questions (or answer questions)
    * Slack, Discuss, Stack Overflow
    * Bluesky, LinkedIn, X
    * Kubernetes blog

## Style

The release announcement is held to the [Kubernetes style guide](https://kubernetes.io/docs/contribute/style/style-guide/).

* Sentence case headings, and an explicit `{#anchor}` on every feature heading so release notes and social posts can deep-link it.
* Start case for graduation phases (Alpha, Beta, Stable, Generally Available); italics and lowercase for a feature or concept on first mention (`_gang scheduling_`).
* Use U.S. English. Wrap source lines at around 80 characters, but never break a line inside `[...]` or `(...)` a split link renders as literal text.
* Write as if the release has already happened: pre-release behavior goes in the past tense.
* Per-section technical review: make sure to receive a review from KEP authors and owning SIG's leads.

## Latest Release Blogs as Reference
* [Kubernetes v1.36: ハル (Haru)](https://kubernetes.io/blog/2026/04/22/kubernetes-v1-36-release/)
* [Kubernetes v1.35](https://kubernetes.io/blog/2025/12/17/kubernetes-v1-35-release/)
* [Kubernetes v1.34: Of Wind & Will](https://kubernetes.io/blog/2025/08/27/kubernetes-v1-34-release/)
* [Kubernetes v1.33: Octarine](https://kubernetes.io/blog/2025/04/23/kubernetes-v1-33-release/)
* [Kubernetes v1.32: Penelope](https://kubernetes.io/blog/2024/12/11/kubernetes-v1-32-release/)

## Release Blog Template

The template should give you some boilerplate. However, each release has its own story to tell, there will be always something special around and exactly this flavour must be brought and individualized into the release blog. Don't be just a copy cat.

Open the announcement as a draft placeholder PR against `main` in `kubernetes/website`. Keep `draft: true` and set no `date` — a follow-up PR sets the date and drops the draft flag when the release ships.

```md
---
layout: blog
title: "Kubernetes v1.XX: <Release Name>"
draft: true # replaced with `date: YYYY-MM-DD` in the publishing PR
evergreen: true
slug: kubernetes-v1-XX-release
author: >
  [Kubernetes v1.XX Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md)
release_announcement:
  minor_version: "1.XX"
  themes:
    - "<Release Name>"
---

**Editors:** <comma-separated list of Comms team member names>

Similar to previous releases, the release of [Kubernetes v1.XX](/releases/1.XX/) introduces new Stable, Beta, and Alpha features. The consistent delivery of high-quality releases underscores the strength of our development cycle and the vibrant support from our community.

This release consists of X enhancements.
Of those enhancements, X have graduated to Stable, X have graduated to Beta,
X are entering Alpha, and X are deprecations or removals.

## Release theme and logo

<!-- Place the logo in this post's page bundle; SVG is strongly preferred. Recommended size is no more than 2160px. -->

{{< figure src="k8s-1.XX.svg" alt="Kubernetes v1.XX <release theme> logo, <description of what the image shows>" class="release-logo" >}}

<THE STORY BEHIND THE RELEASE NAME AND THE LOGO, AND CREDIT FOR THE LOGO ARTIST>

## Spotlight on key updates

Kubernetes v1.XX is packed with new features and improvements. Here are a few select updates the Release Team would like to highlight!

### Stable: <feature name> {#spotlight-stable-feature}

<1-2 PARAGRAPH DESCRIPTION OF THE CHANGE, WRITTEN FOR USERS WHO HAVE NOT READ THE KEP>

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

### Beta: <feature name> {#spotlight-beta-feature}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This feature is on by default; you can disable it with the `SomeFeatureGate` feature gate.

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

### Alpha: <feature name> {#spotlight-alpha-feature}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This is an opt-in, off-by-default Alpha feature. To try it out, enable the `SomeFeatureGate` feature gate.

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

## Features graduating to Stable

_This is a selection of some of the improvements that are now Generally Available following the v1.XX release._

### <feature title> {#feature-title}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

### <grouping title, for a family of related features> {#grouping-title}

<INTRO SENTENCE FOR THE GROUP>

#### <sub-feature title> {#sub-feature-title}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

## Features graduating to Beta

_This is a selection of some of the improvements that are now Beta following the v1.XX release._

### <feature title> {#feature-title}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This feature is behind the `SomeFeatureGate` feature gate (**on** by default).

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

## New features in Alpha

_This is a selection of some of the improvements that are now Alpha following the v1.XX release._

### <feature title> {#feature-title}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This is an opt-in, off-by-default Alpha feature. To try it out, enable the `SomeFeatureGate` feature gate.

This work was done as part of [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/) led by [SIG XXXX](https://www.kubernetes.dev/community/community-groups/sigs/xxxx/).

## Other notable changes

_Changes that matter to users but are not a graduation: a default flipping, a subproject retirement, a performance improvement._

### <change title> {#change-title}

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

## Graduations, deprecations, and removals in v1.XX

### Graduations to Stable

This lists all the features that graduated to Stable (also known as general availability). For a full list of updates including new features and graduations from Alpha to Beta, see the release notes.

This release includes a total of X enhancements promoted to Stable:

* [KEP TITLE](https://www.kubernetes.dev/resources/keps/XXXX/)

## Deprecations, removals, and community updates

As Kubernetes develops and matures, features may be deprecated, removed, or replaced with better ones for the project's overall health.
See the Kubernetes [deprecation and removal policy](/docs/reference/using-api/deprecation-policy/) for more details on this process.
Many of these deprecations and removals were announced in the [Deprecations and Removals blog](LINK TO MID-CYCLE BLOG).

### <deprecation title> {#deprecation-title}

<1-2 PARAGRAPH DESCRIPTION, INCLUDING WHAT USERS SHOULD MIGRATE TO AND BY WHEN>

To learn more about this deprecation, refer to [KEP #XXXX](https://www.kubernetes.dev/resources/keps/XXXX/).

### Ongoing major change: <change planned for a future release> {#future-change}

<ANYTHING THAT LANDS IN A LATER RELEASE GETS ITS OWN HEADING WITH "FUTURE" OR "ONGOING" IN IT, SO READERS DON'T ASSUME IT APPLIES TO v1.XX>

## Release notes

Check out the full details of the Kubernetes v1.XX release in our [release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX.md).

## Availability

[Kubernetes v1.XX](/releases/1.XX/) is available for download from
the [Kubernetes download page](/releases/download/) or directly from [GitHub](https://github.com/kubernetes/kubernetes/releases/tag/v1.XX.0).

To get started with Kubernetes, check out [these tutorials](/docs/tutorials/) or run local Kubernetes clusters using [minikube](https://minikube.sigs.k8s.io/).
You can also easily install v1.XX using [kubeadm](/docs/setup/production-environment/tools/kubeadm/install-kubeadm/).

## Release Team

<FIND AN INDIVIDUAL TEXT, EACH RELEASE TEAM HAS ITS OWN STORY, TELL IT! BELOW IS AN EXAMPLE FROM PAST RELEASES>

Kubernetes is only possible with the support, commitment, and hard work of its community.
Each release team is made up of dedicated community volunteers who work together to build the many pieces that make up the Kubernetes releases you rely on.
This requires the specialized skills of people from all corners of our community, from the code itself to its documentation and project management.

We would like to thank the entire [release team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md) for the hours spent hard at work to deliver the Kubernetes v1.XX release to our community.
The Release Team's membership ranges from first-time shadows to returning team leads with experience forged over several release cycles.
A very special thanks goes out to our release lead, RELEASE LEAD, for supporting us through a successful release cycle, advocating for us, making sure that we could all contribute in the best way possible, and challenging us to improve the release process.

## Project Velocity

<CHECKOUT THE DEVSTATS AND HIGHLIGHT SOME INTERESTING NUMBERS https://k8s.devstats.cncf.io/d/12/dashboards?orgId=1&refresh=15m, INCLUDE ANY INTERESTING DATA YOU FIND FOR THE CYCLE>

The CNCF K8s [DevStats](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&var-period=m&var-repogroup_name=All) project aggregates a number of interesting data points related to the velocity of Kubernetes and various sub-projects.
This includes everything from individual contributions to the number of companies that are contributing and is an illustration of the depth and breadth of effort that goes into evolving this ecosystem.

During the v1.XX release cycle, which spanned X weeks from START DATE to RELEASE DATE, Kubernetes received contributions from as many as X different companies and X,XXX individuals.

<PIN BOTH SOURCE LINKS TO THE CYCLE'S START AND END TIMESTAMPS. NEVER LEAVE `to=now`, OR THE DASHBOARD WILL STOP MATCHING THE NUMBERS IN THIS PARAGRAPH. REFRESH THE NUMBERS RIGHT BEFORE MERGE — THEY MOVE DURING REVIEW.>

Source for this data:
- [Companies contributing to Kubernetes](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&from=START_MS&to=END_MS&var-period=d28&var-repogroup_name=Kubernetes&var-repo_name=kubernetes%2Fkubernetes)
- [Overall ecosystem contributions](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&from=START_MS&to=END_MS&var-period=d28&var-repogroup_name=All&var-repo_name=kubernetes%2Fkubernetes)

By contribution we mean when someone makes a commit, code review, comment, creates an issue or PR, reviews a PR (including blogs and documentation) or comments on issues and PRs.

If you are interested in contributing, see our [getting started](https://www.kubernetes.dev/docs/guide/#getting-started) page.

## Events Update

Explore the upcoming Kubernetes and cloud native events, featuring KubeCon + CloudNativeCon, KCDs, and other notable conferences worldwide.

<PULL EVENTS FROM https://community.cncf.io/events/#/list, GROUPED BY MONTH, GIVE THE LATEST INFORMATION>

## Upcoming Release Webinar

Join members of the Kubernetes v1.XX Release Team on **DAY, DATE at TIME (UTC)** to learn about the release highlights of this release. For more information and registration, visit the [event page](LINK) on the CNCF Online Programs site.

<RELEASE WEBINAR NORMALLY TAKES PLACE 30 DAYS AFTER THE RELEASE; ALIGN WITH CNCF TO HIGHLIGHT IT>

## Get Involved

The simplest way to get involved with Kubernetes is by joining one of the many [Special Interest Groups](https://www.kubernetes.dev/community/community-groups/sigs/) (SIGs) that align with your interests.

If you don't know where to start, join our monthly [New Contributor Orientation](https://www.kubernetes.dev/docs/orientation/), where we teach the community how the project is structured and guide you through your first contribution.

Have something you'd like to broadcast to the Kubernetes community? Share your voice through the channels below. Thank you for your continued feedback and support.

- Read more on how to become a [Kubernetes Contributor](https://www.kubernetes.dev/docs/guide/)
- Read more about what's happening with Kubernetes on our [blog](https://kubernetes.io/blog/)
- Join us on [Slack](https://slack.k8s.io/)
- Follow us on [Bluesky](https://bsky.app/profile/kubernetes.io) for the latest updates
- Follow us on [LinkedIn](https://www.linkedin.com/company/kubernetes/)
- Follow us on [X](https://x.com/kubernetesio)
- Join the community discussion on [Discuss](https://discuss.kubernetes.io/)
- Post questions (or answer questions) on [Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes)
- Share your [Kubernetes End User Story](https://www.cncf.io/case-studies/)
- Learn more about the [Kubernetes Release Team](https://github.com/kubernetes/sig-release/tree/master/release-team)
```
