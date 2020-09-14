# Release Managers <!-- omit in toc -->

Release Managers is an umbrella term that encompasses the set of Kubernetes
contributors responsible for maintaining release branches, tagging releases,
and building/packaging Kubernetes.

The responsibilities of each role are described below.

- [Contact](#contact)
- [Handbooks](#handbooks)
- [Release Managers](#release-managers)
- [Associates](#associates)
- [Build Admins](#build-admins)
- [SIG Release Leads](#sig-release-leads)
  - [Chairs](#chairs)
  - [Technical Leads](#technical-leads)

## Contact

| Mailing List | Slack | Visibility | Usage | Membership |
| --- | --- | --- | --- | --- |
| [release-managers@kubernetes.io](mailto:release-managers@kubernetes.io) | [#release-management](https://kubernetes.slack.com/messages/CJH2GBF7Y) (channel) / @release-managers (user group) | Public | Public discussion for Release Managers | All Release Managers (including Associates, Build Admins, and SIG Chairs) |
| [release-managers-private@kubernetes.io](mailto:release-managers-private@kubernetes.io) | [#release-private](https://kubernetes.slack.com/messages/GKEA5EL67) | Private | Private discussion for privileged Release Managers | Patch Release Team, Branch Managers, SIG Chairs |
| [security-release-team@kubernetes.io](mailto:security-release-team@kubernetes.io) | N/A | Private | Security release coordination with the Product Security Committee | [security-discuss-private@kubernetes.io](mailto:security-discuss-private@kubernetes.io), [release-managers-private@kubernetes.io](mailto:release-managers-private@kubernetes.io) |

## Handbooks

**NOTE: The Patch Release Team and Branch Manager handbooks will be deduplicated at a later date.**

- [Patch Release Team](/release-engineering/role-handbooks/patch-release-team.md)
- [Branch Managers](/release-engineering/role-handbooks/branch-manager.md)
- [Build Admins](/release-engineering/packaging.md)

## Release Managers

Release Managers are responsible for:

- Coordinating patch releases (`x.y.z`, where `z` > 0) of Kubernetes
- Minor releases (`x.y.z`, where `z` = 0) of Kubernetes, working with the
  [Release Team](/release-team/README.md) through each release cycle
- Mentorship of the [Release Manager Associates](#associates) group

This team at times works in close conjunction with the
[Product Security Committee][psc] and therefore should abide by the guidelines
set forth in the [Security Release Process][security-release-process].

GitHub Access Controls: [@kubernetes/release-managers](https://github.com/orgs/kubernetes/teams/release-managers)

GitHub Mentions: [@kubernetes/release-engineering](https://github.com/orgs/kubernetes/teams/release-engineering)

- Carlos Panato ([@cpanato](https://github.com/cpanato))
- Daniel Mangum ([@hasheddan](https://github.com/hasheddan))
- Doug MacEachern ([@dougm](https://github.com/dougm))
- Hannes Hörl ([@hoegaarden](https://github.com/hoegaarden))
- Pengfei Ni ([@feiskyer](https://github.com/feiskyer))
- Sascha Grunert ([@saschagrunert](https://github.com/saschagrunert))
- Stephen Augustus ([@justaugustus](https://github.com/justaugustus))
- Tim Pepper ([@tpepper](https://github.com/tpepper))
- Yang Li ([@idealhack](https://github.com/idealhack))

## Associates

Release Manager Associates are apprentices to the Branch Managers, formerly
referred to as Branch Manager shadows.

- Jim Angel ([@jimangel](https://github.com/jimangel))
- Marko Mudrinić ([@xmudrii](https://github.com/xmudrii))
- Marky Jackson ([@markyjackson-taulia](https://github.com/markyjackson-taulia))
- Seth McCombs ([@sethmccombs](https://github.com/sethmccombs))
- Verónica López ([@verolop](https://github.com/verolop))

## Build Admins

Build Admins are (currently) Google employees with the requisite access to
Google build systems/tooling to publish deb/rpm packages on behalf of the
Kubernetes project.

GitHub team: [@kubernetes/build-admins](https://github.com/orgs/kubernetes/teams/build-admins)

- Aaron Crickenberger ([@spiffxp](https://github.com/spiffxp))
- Amit Watve ([@amwat](https://github.com/amwat))
- Benjamin Elder ([@BenTheElder](https://github.com/BenTheElder))
- Grant McCloskey ([@MushuEE](https://github.com/MushuEE))

## SIG Release Leads

SIG Release Chairs and Technical Leads are responsible for the governance of
SIG Release. They are mentioned explicitly here as they are owners of the
various communications channels and permissions groups (GitHub teams,
GCP access) for each role.

As such, they are highly privileged community members and privy to some private
communications, which can at times relate to Kubernetes security disclosures.

GitHub team: [@kubernetes/sig-release-leads](https://github.com/orgs/kubernetes/teams/sig-release-leads)

### Chairs

- Stephen Augustus ([@justaugustus](https://github.com/justaugustus))
- Tim Pepper ([@tpepper](https://github.com/tpepper))

### Technical Leads

- Jorge Alarcon ([@alejandrox1](https://github.com/alejandrox1))
- Sascha Grunert ([@saschagrunert](https://github.com/saschagrunert))

---

Past Branch Managers, can be found in the [releases directory](/releases) within `release-x.y/release_team.md`.
Example: [1.15 Release Team](/releases/release-1.15/release_team.md)

[psc]: https://git.k8s.io/community/committee-product-security/README.md
[security-release-process]: https://git.k8s.io/security/security-release-process.md
