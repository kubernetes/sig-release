# Outline for the Kubernetes Release Blog
This outline can be used as reference for writing up the release blog. The following sections should give you an idea what can be consider for the blog, but it's not necessary to include every section. Include the ones that make sense for the features/announcements in the release.

* Introduction to release
    * The first paragraph of the release blog announcement introduces the release, its focus, and its importance.
* Release Highlights (Enhancements)
    * Order release features by impact, maturity, vision.
    * This section lists out the key features (even if they are not being recommended to be used in production or are alphas).
        * When we describe something in the alpha state, we are highlighting what is going on (in/to) the community.
        * Release cycles are so short, just because it is alpha right now, it will be stable soon. Position it as “this is what is coming.”
    * Include additional features and what's next section following the key release features.
        * This is the vision and brand new thing you can do in-production right now.
    * Everything else is included in the release notes.
* Changes in stable, beta, alpha
    * List major changes not covered in themes
    * Call out important API deprecations and removals
    * When possible, link upstream docs or KEP docs (past blogs link k/enhancement issues)
* Known Issues
    * Optional section to call out specific known issues and workarounds, if applicable.
* Release notes
    * Release notes are always included in the blog announcement.
* Availability of release
    * Link to where the release can be downloaded on GitHub.
    * Include interactive tutorials on the current release or how to get started with Kubernetes when relevant.
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
    * Community Meeting
    * Where to host questions (or answer questions) 
    * Advocates
    * Twitter
    * Slack
    * Kubernetes blog

## Latest Release Blogs as Reference
* [Kubernetes 1.32: Penelope](https://kubernetes.io/blog/2024/12/11/kubernetes-v1-32-release/)
* [Kubernetes 1.31: Elli](https://kubernetes.io/blog/2024/08/13/kubernetes-v1-31-release/)
* [Kubernetes 1.30: Uwubernetes](https://kubernetes.io/blog/2024/04/17/kubernetes-v1-30-release/)
* [Kubernetes 1.27: Chill Vibes](https://kubernetes.io/blog/2023/04/11/kubernetes-v1-27-release/)
* [Kubernetes 1.26: Electrifying](https://kubernetes.io/blog/2022/12/09/kubernetes-v1-26-release/)
* [Kubernetes 1.25: Combiner](https://kubernetes.io/blog/2022/08/23/kubernetes-v1-25-release/)

## Release Blog Template

The template should give you some boilerplate. However, each release has its own story to tell, there will be always something special around and exactly this flavour must be brought and individualized into the relase blog. Don't be just a copy cat.

```md
---
layout: blog
title: 'Kubernetes 1.XX: <Release Name>'
date: 202n-mm-dd
slug: kubernetes-1-XX-release-announcement
author: >
  [Kubernetes v1.XX Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md)
---
---

**Editors:** [Comms teams members]

Similar to previous releases, the release of Kubernetes v1.XX introduces new stable, beta, and alpha features. The consistent delivery of high-quality releases underscores the strength of our development cycle and the vibrant support from our community.

This release consists of X enhancements.
Of those enhancements, X have graduated to Stable, X are entering Beta, 
and X have graduated to Alpha.

## Release theme and logo
<Logo image size is recommended to be no more than 2160px>
{{< figure src="/images/blog/YYYY-MM-DD-kubernetes-1.XX-release/k8s-1.XX.png" alt="Kubernetes v1.XX <release theme> logo" class="release-logo" >}}


## Release highlights

<MESSAGE ABOUT THE HIGHLIGHTS BELOW AND WHY THEY WERE CHOSEN>

### <THEME 1>

### <THEME 2>

### <THEME 3>

### <THEME 4>

### <THEME 5>

## Features graduating to Stable

_This is a selection of some of the improvements that are now stable following the v1.XX release._

### <FEATURE TITLE>

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This work was done as part of [KEP #XXXX](https://github.com/kubernetes/enhancements/issues/XXXX) led by [SIG XXXX](https://github.com/kubernetes/community/tree/master/sig-XXXXX).

## New features in Beta

_This is a selection of some of the improvements that are now beta following the v1.XX release._

### <FEATURE TITLE>

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This work was done as part of [KEP #XXXX](https://github.com/kubernetes/enhancements/issues/XXXX) led by [SIG XXXX](https://github.com/kubernetes/community/tree/master/sig-XXXXX).


## New features in Alpha

_This is a selection of some of the improvements that are now alpha following the v1.XX release._
    
### <FEATURE TITLE>

<1-2 PARAGRAPH DESCRIPTION OF CHANGE>

This work was done as part of [KEP #XXXX](https://github.com/kubernetes/enhancements/issues/XXXX) led by [SIG XXXX](https://github.com/kubernetes/community/tree/master/sig-XXXXX).


## Graduations, deprecations, and removals in 1.XX

### Graduations to stable

This lists all the features that graduated to stable (also known as _general availability_). For a full list of updates including new features and graduations from alpha to beta, see the release notes.

This release includes a total of X enhancements promoted to stable:
* [KEP TITLE](https://github.com/kubernetes/enhancements/issues/XXXXXX)

### Deprecations and removals 

As Kubernetes develops and matures, features may be deprecated, removed, or replaced with better ones for the project's overall health. 
See the Kubernetes [deprecation and removal policy](/docs/reference/using-api/deprecation-policy/) for more details on this process.
Many of these deprecations and removals were announced in the [Deprecations and Removals blog](LINK TO MID-CYCLE BLOG)


### Release notes

Check out the full details of the Kubernetes 1.XX release in our [release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX.md).

### Availability

Kubernetes v1.XX is available for download on [GitHub](https://github.com/kubernetes/kubernetes/releases/tag/v1.XX.0) or on the [Kubernetes download page](/releases/download/). 

To get started with Kubernetes, check out these [interactive tutorials](/docs/tutorials/) or run local Kubernetes clusters using [minikube](https://minikube.sigs.k8s.io/).
You can also easily install v1.XX using [kubeadm](/docs/setup/independent/create-cluster-kubeadm/). 

### Release Team

<FIND AN INDIVIDUAL TEXT, EACH RELEASE TEAM HAS ITS OWN STORY, TELL IT! BELOW IS AN EXAMPLE FROM PAST RELEASES>

Kubernetes is only possible with the support, commitment, and hard work of its community. 
Each release team is made up of dedicated community volunteers who work together to build the many pieces that make up the Kubernetes releases you rely on. 
This requires the specialized skills of people from all corners of our community, from the code itself to its documentation and project management.

We would like to thank the entire [release team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release-team.md) for the hours spent hard at work to deliver the Kubernetes v1.31 release to our community. 
The Release Team's membership ranges from first-time shadows to returning team leads with experience forged over several release cycles. 
A very special thanks goes out our release lead, RELEASE LEAD, for supporting us through a successful release cycle, advocating for us, making sure that we could all contribute in the best way possible, and challenging us to improve the release process.

### Project Velocity

<CHECKOUT THE DEVSTATS AND HIGHLIGHT SOME INTRESTING NUMBERS https://k8s.devstats.cncf.io/d/12/dashboards?orgId=1&refresh=15m, INCLUDE ANY INTERESTED DATA YOU FIND FOR THE CYCLE>

The CNCF K8s [DevStats](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&var-period=m&var-repogroup_name=All) project aggregates a number of interesting data points related to the velocity of Kubernetes and various sub-projects. 
This includes everything from individual contributions to the number of companies that are contributing and is an illustration of the depth and breadth of effort that goes into evolving this ecosystem.

In the v1.XX release cycle, which ran for X weeks (START DATE to RELEASE DATE), we saw contributions to Kubernetes from X different companies and X individuals.

Source for this data: 
- [Companies contributing to Kubernetes](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&from=1715032800000&to=1723586399000&var-period=d28&var-repogroup_name=Kubernetes&var-repo_name=kubernetes%2Fkubernetes)
- [Overall ecosystem contributions](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&from=1715032800000&to=1723586399000&var-period=d28&var-repogroup_name=All&var-repo_name=kubernetes%2Fkubernetes)

By contribution we mean when someone makes a commit, code review, comment, creates an issue or PR, reviews a PR (including blogs and documentation) or comments on issues and PRs.

If you are interested in contributing see our [getting started](https://www.kubernetes.dev/docs/guide/#getting-started) page. 

### Event Update
Explore the upcoming Kubernetes events, featuring KubeCon, KCD, and other notable conferences worldwide.

<THERE WILL BE ALWAYS A KUBECON/CLOUDNATIVECON, PULL EVENTS FROM https://community.cncf.io/events/#/list, GIVE THE LATEST INFORMATION>

### Upcoming Release Webinar

<RELEASE WEBINARE WILL TAKE PLACE NORMALLY 30 DAYS AFTER RELEASE, ALIGN WITH CNCF TO HIGHLIGHT THE WEBINAR>

### Get Involved
<THIS COMMUNITY LIVES BY ITS GREAT COMMUNITY, GET THEM INVOLVED!>
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