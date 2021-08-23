# Onboarding & Tooling

<!-- toc -->
- [Content Notice](#content-notice)
- [Overview](#overview)
  - [Conventions](#conventions)
- [Prerequisites](#prerequisites)
  - [Branch Management Onboarding](#branch-management-onboarding)
  - [Machine setup](#machine-setup)
    - [Operating System](#operating-system)
    - [Release tooling](#release-tooling)
    - [Google Cloud SDK](#google-cloud-sdk)
    - [Sending mail](#sending-mail)
    - [Skopeo](#skopeo)

<!-- end toc -->

## Content Notice

The Patch Release Team and Branch Manager roles have been consolidated into a
single [Release Managers][release-managers] group.

This means that several areas of this document may currently be out of date.
While we work to update these documents, please reach out to
[Release Managers][release-managers] directly for any clarifications on Release
Engineering processes.

**This notice will be removed when the documentation is no longer under
construction.**

## Overview

### Conventions

In this handbook, we will make several references to Kubernetes releases, milestones, and [semantic versioning](http://semver.org/).

For the purposes of this handbook, we'll assume that:

- the current release in development is Kubernetes 1.18
- the previous release is Kubernetes 1.17
- the next release is Kubernetes 1.19
- the release no longer in support is Kubernetes 1.14

To simplify certain instructions, we will make the following connections:

| Text | SemVer | Reference Release |
| --- | --- | --- |
| "current release", "current milestone", "in development" | `x.y` | Kubernetes 1.18 |
| "previous release", "previous milestone" | `x.y-1` | Kubernetes 1.17 |
| "next release", "next milestone" | `x.y+1` | Kubernetes 1.19 |
| "release no longer in support" | `x.y-4` | Kubernetes 1.14 |

**As an editor of this content, Branch Managers should periodically update these conventions and the examples contained within this handbook.**

## Prerequisites

This is a collection of requirements and conditions to fulfill when taking on the role as branch manager.

### Branch Management Onboarding

**Before we can grant Release Manager access to new Branch Managers, a [Release Manager onboarding issue](https://github.com/kubernetes/sig-release/issues/new?labels=sig%2Frelease%2C+area%2Frelease-eng&template=release-manager.md&title=Release+Manager+access+for+%3CGH-handle%3E) _MUST_ be opened in this repo. Please take a moment to do that before executing the tasks contained in this handbook.**

### Machine setup

#### Operating System

There's a small amount of effort to ensure our [release tools] are supported on multiple platforms, please note that only the following systems are supported:

- Debian-like (Debian, Ubuntu)
- Fedora-like (Fedora, RHEL, CentOS)
- MacOS

Windows is not supported by [release tools].

While our tooling may not support every platform, you may find success running within a container image.

See "Cutting v1.15.0-alpha.2" under [References](#References) for an example Dockerfile.

**If you notice that [release tools] are not working as expected, please file an issue in [kubernetes/release].**

#### Release tooling

To leverage/contribute to our [release tools], Release Managers will need to fork and clone the [kubernetes/release] repo.

Building and publishing releases requires the latest revision of the release tools. The release tools can be compiled by running the following command from the [kubernetes/release] repository:

```shell
make release-tools
```

Release Managers primarily use an SSH key to authenticate to GitHub.

GitHub has documentation to assist in:

- [Connecting to GitHub with SSH](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
- [Forking a repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)

Additionally, `kubernetes/community` has a great [overview of the GitHub workflow](https://git.k8s.io/community/contributors/guide/github-workflow.md) we use across several Kubernetes org repositories.

Please take a moment to review the above documentation before continuing.

[image-promotion]: ./release-image-promotion.md

#### Google Cloud SDK

[Kubernetes release artifacts](/release-engineering/artifacts.md) are stored on Google Cloud Platform (GCP).

Release Managers will need to use the Google Cloud SDK to interact with release artifacts.

Google Cloud has [documentation on installing and configuring the Google Cloud SDK CLI tools](https://cloud.google.com/sdk/docs/quickstarts).

To authenticate the Google Cloud SDK tool with your GCP account, you can run:

```shell
gcloud auth login
```

It might ask you to define the default project, region, and similar settings. The project can be set to `kubernetes-release-test`, while other settings can be ignored.

In addition to `gcloud,` `gsutil` is required as well. By default, it comes with Google Cloud SDK.

#### Sending mail

At the end of a release, Release Managers will need to announce the new release to the community.

This can be done in one of two ways:

- The `krel announce` sub command -- A [`SENDGRID_API_KEY`](https://sendgrid.com/docs/ui/account-and-settings/api-keys) will need to be configured correctly on your environment for this to work
  - If you haven't used SendGrid before, SendGrid might require you to go through the [Sender Identity Verification process][sendgrid-identity-verification] before you can send emails/announcements
- Manually -- Send the email notification manually to [kubernetes-announce][k-announce-list] and [kubernetes-dev][k-dev-list]. You can take contents of the announcement in one of the following ways:
  - By taking the contents from the Google Cloud Bucket: `gs://kubernetes-release/archive/anago-vX.Y.0-{alpha,beta,rc}.z`:
  - By using `krel announce` command with the `--print-only` flag
  - [Example subject](https://gcsweb.k8s.io/gcs/kubernetes-release/archive/anago-v1.17.0-rc.2/announcement-subject.txt)
  - [Example body](https://gcsweb.k8s.io/gcs/kubernetes-release/archive/anago-v1.17.0-rc.2/announcement.html)


#### Skopeo

[Skopeo][skopeo] is a command line utility that performs various operations on container images and image repositories. Skopeo is not required for performing branch management tasks (if needed, Docker and other relevant tools can be used instead), however, it might be referred to by other guides. If you want to install Skopeo, you can follow the [official installation guide][skopeo-install].

#### Crane

[Crane][crane] crane is a tool for interacting with remote images and registries. It does similar things that Skopeo does, it is another option to work with containers. Crane is not required for performing branch management tasks. If you want to install Crane, you can follow the [official installation guide][crane-install].

[k-announce-list]: https://groups.google.com/forum/#!forum/kubernetes-announce
[k-dev-list]: https://groups.google.com/forum/#!forum/kubernetes-dev
[release tools]: https://github.com/kubernetes/release#tools
[kubernetes/release]: https://github.com/kubernetes/release
[sendgrid-identity-verification]: https://sendgrid.com/docs/for-developers/sending-email/sender-identity/
[crane]: https://github.com/google/go-containerregistry/tree/main/cmd/crane
[crane-install]: https://github.com/google/go-containerregistry/tree/main/cmd/crane#installation
[skopeo]: https://github.com/containers/skopeo
[skopeo-install]: https://github.com/containers/skopeo/blob/master/install.md
[kubernetes-release-team]: https://groups.google.com/a/kubernetes.io/g/release-team
[release-managers]: /release-managers.md#release-managers
[release-managers-group]: https://groups.google.com/a/kubernetes.io/forum/#!forum/release-managers
