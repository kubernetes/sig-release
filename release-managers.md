# Release Managers <!-- omit in toc -->

Release Managers is an umbrella term that encompasses the set of Kubernetes contributors responsible for maintaining release branches, tagging releases, and building/packaging Kubernetes.

The responsibilities of each role are described below.

- [Contact](#Contact)
- [Handbooks](#Handbooks)
- [Patch Release Team](#Patch-Release-Team)
  - [GitHub teams](#GitHub-teams)
  - [Members](#Members)
- [Branch Managers](#Branch-Managers)
  - [Members](#Members-1)
- [Associates](#Associates)
  - [Members](#Members-2)
- [Build Admins](#Build-Admins)
  - [GitHub team](#GitHub-team)
  - [Members](#Members-3)
- [SIG Release Chairs](#SIG-Release-Chairs)
  - [GitHub team](#GitHub-team-1)
  - [Members](#Members-4)

## Contact

| Mailing List | Slack | Visibility | Usage | Membership |
|---|---|---|---|---|
| [kubernetes-release-managers@googlegroups.com](mailto:kubernetes-release-managers@googlegroups.com) | [#release-management](https://kubernetes.slack.com/messages/CJH2GBF7Y) (channel) / @release-managers (user group) | Public | Public discussion for Release Managers | All Release Managers (Patch Release Team, Branch Managers, Associates, Build Admins, SIG Chairs) |
| [kubernetes-release-managers-private@googlegroups.com](mailto:kubernetes-release-managers-private@googlegroups.com)| [#release-private](https://kubernetes.slack.com/messages/GKEA5EL67) | Private | Private discussion for privileged Release Managers | Patch Release Team, Build Admins, SIG Chairs |


## Handbooks

- [Patch Release Team](/release-engineering/role-handbooks/patch-release-manager.md)
- [Branch Managers](/release-engineering/role-handbooks/branch-manager.md)
- [Build Admins](/release-engineering/packaging.md)


## Patch Release Team

The Patch Release Team is responsible for coordinating patch releases (`x.y.z`, where `z` >= 0) of Kubernetes. This team at times works in close conjunction with the [Product Security Committee](https://git.k8s.io/community/committee-product-security/README.md) and therefore should abide by the guidelines set forth in the [Security Release Process](https://git.k8s.io/security/security-release-process.md). 

### GitHub teams
- Access: [@kubernetes/release-managers](https://github.com/orgs/kubernetes/teams/release-managers)
- Contact: [@kubernetes/patch-release-team](https://github.com/orgs/kubernetes/teams/patch-release-team)

### Members
- Aleksandra Malinowska ([@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Hannes Hörl ([@hoegaarden](https://github.com/hoegaarden))
- Pengfei Ni ([@feiskyer](https://github.com/feiskyer))
- Tim Pepper ([@tpepper](https://github.com/tpepper))


## Branch Managers

Branch Managers are responsible for minor releases (`x.y.z`, where `z` = 0) of Kubernetes, working in close conjunction with the [Release Team](/release-team/README.md) through each release cycle.

### Members
- Cheryl Fong ([@bubblemelon](https://github.com/bubblemelon))
- Yang Li ([@idealhack](https://github.com/idealhack))


## Associates

Release Manager Associates are apprentices to the Branch Managers, formerly referred to as Branch Manager shadows.

### Members
- Stephen Augustus ([@justaugustus](https://github.com/justaugustus))
- Nikhil Manchanda ([@slicknik](https://github.com/slicknik))
- Vivek Taparia ([@vivektaparia](https://github.com/vivektaparia))
- Christian Jantz ([@chrisz100](https://github.com/chrisz100))
- Dhawal Yogesh Bhanushali ([@imkin](https://github.com/imkin))
- Nikhita Raghunath ([@nikhita](https://github.com/nikhita))
- Javier B Perez ([@javier-b-perez](https://github.com/javier-b-perez))
- Klaus Ma ([@k82cn](https://github.com/k82cn))
- Giri Kuncoro ([@girikuncoro](https://github.com/girikuncoro))
- Peter Swica ([@pswica](https://github.com/pswica))
- Carlos Panato ([@cpanato](https://github.com/cpanato))
- Mike Crute ([@mcrute](https://github.com/mcrute))
- Ace Eldeib ([@alexeldeib](https://github.com/alexeldeib))


## Build Admins

Build Admins are (currently) Google employees with the requisite access to Google build systems/tooling to publish deb/rpm packages on behalf of the Kubernetes project.

### GitHub team
- [@kubernetes/build-admins](https://github.com/orgs/kubernetes/teams/build-admins)

### Members
- Aleksandra Malinowska ([@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Linus Arver ([@listx](https://github.com/listx))
- Sumitran Raghunathan ([@sumitranr](https://github.com/sumitranr))


## SIG Release Chairs

SIG Release Chairs are responsible for the governance of SIG Release. They are mentioned explicitly here as they are owners of the various communications channels and permissions groups (GitHub teams, GCP access) for each role.

As such, they are highly privileged community members and privy to some private communications, which can at times relate to Kubernetes security disclosures.

### GitHub team
- [@kubernetes/sig-release-admins](https://github.com/orgs/kubernetes/teams/sig-release-admins)

### Members
- Caleb Miles ([@calebamiles](https://github.com/calebamiles))
- Stephen Augustus ([@justaugustus](https://github.com/justaugustus))
- Tim Pepper ([@tpepper](https://github.com/tpepper))


---

Past Branch Managers, can be found in the [releases directory](/releases) within `release-x.y/release_team.md`.
Example: [1.15 Release Team](/releases/release-1.15/release_team.md)
