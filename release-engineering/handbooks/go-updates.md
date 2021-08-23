# Updating Go

This handbook covers updating Go versions in `kubernetes/kubernetes` and the
various interdependent repositories that need to be updated in tandem.

- [Audience](#audience)
- [Scope](#scope)
- [Signaling intent](#signaling-intent)
- [kube-cross image](#kube-cross-image)
  - [kube-cross image building](#kube-cross-image-building)
  - [kube-cross image promotion](#kube-cross-image-promotion)
- [k8s-cloud-builder image](#k8s-cloud-builder-image)
- [`kubernetes/kubernetes` updates](#kuberneteskubernetes-updates)
  - [`master` branch updates](#master-branch-updates)
  - [Cherry picks](#cherry-picks)
- [kubekins and krte images](#kubekins-and-krte-images)
- [`publishing-bot` updates](#publishing-bot-updates)

## Audience

Updating Go is intended to be handled by a member of the
[Release Managers][release-managers] group.

There are a variety of touchpoints in this process that require special access
to debug potential failures, which are restricted to Release Managers.

## Scope

This handbook is intended to cover both minor and patch Golang version updates.

- Minor version upgrade: `x.y.z` --> `x.y+N.z`, where `N` is usually `1`
- Patch version upgrade: `x.y.z` --> `x.y.z+N`, where `N` is usually `1`

While the mechanics of a minor and patch are primarily the same, be aware that
a minor version update _may_ require:

- code changes to `kubernetes/kubernetes`
- coordination across multiple SIGs/subprojects to attain reviews/approvals for
  various code areas
- coordination with external projects e.g., golang, etcd
- extended lead time to merge (rebases, mending test failures)

**Please pair with a more senior Release Manager if you find yourself working
on a minor version update.**

## Signaling intent

Before you get started, it's important to inform a few groups that you will be
working on a Golang update.

Some broad requirements (which can be expanded as we get more people involved):

- Open an issue in `kubernetes/release` to track the work
  - Examples:
    - https://github.com/kubernetes/release/issues/1216
    - https://github.com/kubernetes/release/issues/1257
- Tag `@kubernetes/release-engineering` in the tracking issue
- (For minor updates) Tag [SIG Scalability Chairs/Technical Leads](https://github.com/kubernetes/community/tree/master/sig-scalability#leadership) in the tracking issue

## kube-cross image

- the image that we use within kubernetes/kubernetes that allows cross compilation builds
- it has to have the same go version that we're intending to bump Kubernetes to
Relevant files to create a PR:
- https://github.com/kubernetes/release/blob/master/images/build/cross/
  - Dockerfile
  - variants.yaml: update KUBE_CROSS_VERSION, e.g. "KUBE_CROSS_VERSION: 'v1.14'"
  - Makefile:
        these values must default to the current version (or prevailing minor version)
        *e.g.
        CONFIG?=go1.14
        KUBE_CROSS_VERSION?=v1.14*
- Sending this PR will trigger kube-cross image building

### kube-cross image building

Test Infra
https://github.com/kubernetes/test-infra/blob/master/config/jobs/image-pushing/k8s-staging-build-image.yaml (don't have to change anything)

- we use GCP builder
- we only trigger these jobs on changes on the relevant directory (kubecross dir, in this case); images don't need to be built all the time
- See Testgrid dashboard for job performance details, which lead to GCP(@ k8s-staging-build-image) (Note: a privileged account is needed to access the Execution Details)
- Copy the docker image digest from GCP

### kube-cross image promotion

- promote the image from staging to production, for it to be an official image
- create PR in kubernetes/k8s.io
  - Update the docker image digest and its version tag @ https://github.com/kubernetes/k8s.io/blob/main/k8s.gcr.io/images/k8s-staging-build-image/images.yaml
  - indicate the image, a link to the staging run, signature ( e.g. "Signed off by : Stephen Augustus saugustus@example.com"), CC @kubernetes/release-engineering & relevant reviewers
  - the structure of the file is structured by the digests' SHAs

## k8s-cloud-builder image

## `kubernetes/kubernetes` updates

### `master` branch updates

### Cherry picks

## kubekins and krte images

## `publishing-bot` updates


[release-managers]: /release-managers.md
