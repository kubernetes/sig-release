# SIG Release

## Charter

The [charter] defines the scope and governance of the Release Special Interest Group.

## Join us!

If you are new to the Kubernetes community and would like to start contributing, you can check out the ["Getting Started"](https://www.kubernetes.dev/docs/guide/) guide for Kubernetes contributors. Below are some more links specifically to SIG Release to get in touch with us.

- [Slack](https://kubernetes.slack.com/messages/sig-release)
- [Mailing list](https://groups.google.com/g/kubernetes-sig-release)
- [Open Issues / PRs](https://github.com/search?q=org%3Akubernetes+org%3Akubernetes-client+org%3Akubernetes-csi+org%3Akubernetes-incubator+org%3Akubernetes-retired+org%3Akubernetes-sigs+is%3Aopen+label%3Asig%2Frelease)
- [Meetings](https://git.k8s.io/community/sig-release#meetings) and the [meeting agenda and notes](https://bit.ly/k8s-sig-release-meeting)
- [Contributing guidelines](CONTRIBUTING.md) and [security policy](SECURITY.md)

## Roadmap and Vision

SIG Release maintains their own [Roadmap and Vision in a dedicated document](roadmap.md).

## Subprojects

### Release Team

Several of the responsibilities of SIG Release are discharged by the Release Team, a subproject of SIG Release. Explicit details on each of the roles can be found in the [Release Team subproject directory][rt-directory].

### Release Engineering

The Release Engineering subproject owns the process, tooling and infrastructure used to build and publish Kubernetes releases. Its handbooks and reference documentation live in the [Release Engineering directory][releng-directory].

## Current release

Each release cycle has a directory under [`releases/`](releases/) with its schedule, Release Team roster and links to the tracking boards and meeting notes. The directory of the release currently in development is the one with the highest version number. Each release directory is also reachable via `https://rel.k8s.io/vX.YY`, for example https://rel.k8s.io/v1.38.

## Processes

The following high-level descriptions of SIG Release processes should provide a
general overview about the work we're doing:

- [Release Phases](releases/release_phases.md)
- [Exceptions to release deadlines](releases/EXCEPTIONS.md)
- [Release Blocking Jobs and Criteria](release-blocking-jobs.md)
- [Release Notes](release-engineering/README.md#release-notes)
- [Versioning](release-engineering/reference/versioning.md)
- [Security Releases](release-engineering/handbooks/security-releases.md)

[charter]: https://git.k8s.io/community/sig-release/charter.md
[rt-directory]: release-team/README.md
[releng-directory]: release-engineering/README.md
