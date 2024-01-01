# Outline for the Kubernetes Release Blog
This outline can be used as reference for writing up the release blog. The following sections should give you an idea what can be consider for the blog, but for sure you don't/can't include all sections:

* Introduction to release
    * The first paragraph of the release blog announcement introduces the release, its focus, and its importance.
* Major Themes (Enhancements)
    * Order release features by impact, maturity, vision.
    * This section lists out the key features (even if they are not being recommended to be used in production or are alphas).
        * When we describe something in the alpha state, we are highlighting what is going on (in/to) the community.
        * Release cycles are so short, just because it is alpha right now, it will be stable soon. Position it as “this is what is coming.”
    * Include additional features and what's next section following the key release features.
        * This is the vision and brand new thing you can do in-production right now.
    * Blog posts should highlight the main features and include mention of the 5-day blog series.
    * Everything else is included in the release notes.
* Major changes
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
* [Kubernetes 1.27: Chill Vibes](https://kubernetes.io/blog/2023/04/11/kubernetes-v1-27-release/)
* [Kubernetes 1.26: Electrifying](https://kubernetes.io/blog/2022/12/09/kubernetes-v1-26-release/)
* [Kubernetes 1.25: Combiner](https://kubernetes.io/blog/2022/08/23/kubernetes-v1-25-release/)
* [Kubernetes 1.24: Stargazer](https://kubernetes.io/blog/2022/05/03/kubernetes-1-24-release-announcement/)
* [Kubernetes 1.23: The Next Frontier](https://kubernetes.io/blog/2021/12/07/kubernetes-1-23-release-announcement/)
* [Kubernetes 1.22: Reaching New Peaks](https://kubernetes.io/blog/2021/08/04/kubernetes-1-22-release-announcement/)
* [Kubernetes 1.21: Power to the Community](https://kubernetes.io/blog/2021/04/08/kubernetes-1-21-release-announcement/)

## Release Blog Template

The template should give you some boilerplate. However, each release has its own story to tell, there will be always something special around and exactly this flavour must be brought and individualized into the relase blog. Don't be just a copy cat.

```md
---
layout: blog
title: 'Kubernetes 1.XX: <Release Name>'
date: 202n-mm-dd
slug: kubernetes-1-XX-release-announcement
---

**Authors:** [Kubernetes 1.XX Release Team](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.XX/release_team.md)

<INTRO>

## Release theme and logo
<Logo image size is recommended to be no more than 2160px>

## Major Themes

### <THEME 1>

### <THEME 2>

### <THEME 3>

### <THEME 4>

### <THEME 5>

## Other Updates

### Graduated to Stable

- [<Enhancement Name>](<LINK TO KEP OR DOCS>)
- [...](...)

### Major Changes

- [<Enhancement Name>](<LINK TO KEP OR DOCS>)
- [...](...)

### Major Changes

Callouts for specific known issues worthy of note. Links to issues, docs, and related content.

### Release Notes

Check out the full details of the Kubernetes 1.XX release in our [release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.XX.md).

### Availability

Kubernetes 1.XX is available for download on [GitHub](https://github.com/kubernetes/kubernetes/releases/tag/v1.XX.0). To get started with Kubernetes, check out these [interactive tutorials](https://kubernetes.io/docs/tutorials/) or run local Kubernetes clusters using [minikube](https://minikube.sigs.k8s.io/). You can also easily install 1.XX using [kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/). 

### Release Team

<FIND AN INDIVIDUAL TEXT, EACH RELEASE TEAM HAS ITS OWN STORY, TELL IT!>

### Project Velocity

<CHECKOUT THE DEVSTATS AND HIGHLIGHT SOME INTRESTING NUMBERS https://k8s.devstats.cncf.io/d/12/dashboards?orgId=1&refresh=15m>

<AS EXAMPLE>
This past quarter, 641 different companies and over 6,409 individuals contributed to Kubernetes. [Check out DevStats](https://k8s.devstats.cncf.io/d/11/companies-contributing-in-repository-groups?orgId=1&var-period=m&var-repogroup_name=All) to learn more about the overall velocity of the Kubernetes project and community.

### Event Update

<THERE WILL BE ALWAYS A KUBECON/CLOUDNATIVECON AROUND, GIVE THE LATEST INFORMATION>

### Upcoming Release Webinar

<RELEASE WEBINARE WILL TAKE PLACE NORMALLY 30 DAYS AFTER RELEASE, ALIGN WITH CNCF TO HIGHLIGHT THE WEBINAR>

### Get Involved
<THIS COMMUNITY LIVES BY ITS GREAT COMMUNITY, GET THEM INVOLVED!>
The simplest way to get involved with Kubernetes is by joining one of the many [Special Interest Groups](https://github.com/kubernetes/community/blob/master/sig-list.md) (SIGs) that align with your interests. Have something you’d like to broadcast to the Kubernetes community? Share your voice at our weekly [community meeting](https://github.com/kubernetes/community/tree/master/communication), and through the channels below. Thank you for your continued feedback and support.

- Follow us on Twitter [@Kubernetesio](https://twitter.com/kubernetesio) for latest updates
- Join the community discussion on [Discuss](https://discuss.kubernetes.io/)
- Join the community on [Slack](http://slack.k8s.io/)
- Post questions (or answer questions) on [Stack Overflow](http://stackoverflow.com/questions/tagged/kubernetes)
- Share your Kubernetes [story](https://docs.google.com/a/linuxfoundation.org/forms/d/e/1FAIpQLScuI7Ye3VQHQTwBASrgkjQDSS5TP0g3AXfFhwSM9YpHgxRKFA/viewform)
- Read more about what’s happening with Kubernetes on the [blog](https://kubernetes.io/blog/)
- Learn more about the [Kubernetes Release Team](https://github.com/kubernetes/sig-release/tree/master/release-team)
```
