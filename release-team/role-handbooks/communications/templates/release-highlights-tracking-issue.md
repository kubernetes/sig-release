### Overview
The release comms team will use this issue to track the work on nudging SIGs for entries on release highlights for the <version> release cycle.

Release Highlights discussion for <version>: #xxxx Release Highlights deadline: **Some deadline**.

Release Highlights are collected during each release cycle for every SIG to see what should be highlighted in the release blog, webinar, and other communications. Different SIGs have a different number of [tracked enhancements](<enhancement-tracking-board-link>). Some SIGs have activities that aren't quite coupled with Kubernetes releases, and it's worth checking with them in case there are things worth calling out in what they did between the previous release and the current release. One example is the Dockershim removal from 1.24 or Immutable Secrets and ConfigMaps from the 1.21 release, as well the cgroup v2 change in 1.31.

### What do I need to do?
1. Pick a group of SIGs to reach out to (listed below), and comment your selection on this issue
2. Reach out to the SIGs in slack to ask for Release Highlights feedback and directing them to the github discussion using the template below
3. Comment here when you've completed reaching out to the SIGs

Depending on the responses we get, we may need to send out a reminder in Slack later in the release cycle to each SIG to get more feedback on Release Highlights Themes.

### How do I find a SIG's slack channel?
The Slack channel for each SIG is usually #sig-, but accurate links are available in [k/community](https://github.com/kubernetes/community) under [sig-list.md](https://github.com/kubernetes/community/blob/master/sig-list.md). The plan is to ask for responses on the public Slack channel (non-disruptively).

### What should I say?
Following is a bootstrap template that you can use to reach out to the individual SIGs informing them about the discussion thread. This template includes the important information to convey to the SIG, but you are free to add your own personalization to the message if you'd like to.

A template message can be found [here](/release-team/role-handbooks/communications/templates/release-highlight-message.md)

Following that message it is advised to ping the SIGs every 2 weeks to remind them about the release highlights.

### SIG groups
The following are groups of SIGs we need to reach out to. The SIGs are grouped together in a mix of those that have tracked enhancements for this release and those that do not. Please comment below with the group you'd like to reach out to.

Group 1

* [ ]   Node
* [ ]   Cloud Provider
* [ ]   Architecture
* [ ]   Testing

Group 2

* [ ]   Auth
* [ ]   CLI
* [ ]   K8s Infra
* [ ]   Multicluster 

Group 3

* [ ]   API Machinery
* [ ]   Scheduling
* [ ]   Autoscaling
* [ ]   Security

Group 4

* [ ]   Network
* [ ]   Instrumentation
* [ ]   Cluster Lifecycle
* [ ]   Scalability

Group 5

* [ ]   Storage
* [ ]   Apps
* [ ]   Windows
* [ ]   UI


We'll try to keep the list up-to-date, but please double-check in the comments if someone has contacted their assigned channels. We can debate more details in Slack.

/milestone <version>

xref: #old-issue

