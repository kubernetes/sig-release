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
- [Minor version updates](#minor-version-updates)

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

Minor version updates are initially made *only* to the current development branch,
and require additional [tracking of changes and prerequisites](#minor-version-updates),
before backporting changes to release branches.

**Please pair with a more senior Release Manager if you find yourself working
on a minor version update.**


## Signaling intent

Before you get started, it's important to inform a few groups that you will be
working on a Golang update.

Some broad requirements (which can be expanded as we get more people involved):

- Open an issue in `kubernetes/release` to track the work
  - Examples:
    - https://github.com/kubernetes/release/issues/3076 (minor version update)
    - https://github.com/kubernetes/release/issues/3347 (patch version update)
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

## Minor version updates

Minor version updates are initially made *only* to the current development branch,
and require additional tracking of changes and prerequisites,
before backporting changes to release branches.

**1. Track prereq changes for a new minor go version**

In the `kubernetes/release` issue, track any changes made to the default Kubernetes development branch
that were required to adopt a new go minor version (go 1.N). This typically includes changes like:

* updates to static analysis tooling to support any go language changes
  (e.g. [#115129](https://github.com/kubernetes/kubernetes/pull/115129))
* updates to dependencies needed to work with go 1.N
  (e.g. [#114766](https://github.com/kubernetes/kubernetes/pull/114766))
* updates to Kubernetes code to fix issues identified by improved vet or lint checks
* updates to Kubernetes code to work with both go 1.N and 1.(N‑1)
  (e.g. [commit c31cc5ec](https://github.com/kubernetes/kubernetes/commit/c31cc5ec46315a02343ec6d6a2ef659e2cc8668e))

Prioritize making the prereq changes as minimal and low-risk as possible.
Merge those changes to the default Kubernetes development branch *prior* to updating to go 1.N.
This ensures those changes build and pass tests with both go 1.N and 1.(N‑1).
Here is an [example of tracking prereq changes for go1.20](https://github.com/kubernetes/release/issues/2815#issuecomment-1373891562).

**2. Backport prereq changes to release-1.x branches**

Backport all prereq changes for go 1.N to release-1.x branches, keeping in mind the guidance to
[avoid introducing risk to release branches](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-release/cherry-picks.md#what-kind-of-prs-are-good-for-cherry-picks).

Considering the typical changes required to update go versions:

* Tooling and test changes carry minimal risk
* Dependency updates should be evaluated for extent / risk; if needed, and if possible, work with dependency maintainers to obtain the required fix in a more scoped way
* Updates to fix issues caught by improved vet or lint checks generally fix real problems and are reasonable to backport, or are very small / isolated and carry minimal risk
* Updates to make code work with both go 1.N and 1.(N‑1) should be evaluated for extent / risk; if needed, isolate the change in go-version-specific files.

Here is an [example of tracking backports of prereq changes for go 1.20](https://github.com/kubernetes/release/issues/2815#issuecomment-1373891562).

**3. Update release-1.x branches to new go minor versions**

Update release-1.x branches to build/release using go 1.N *after* all of these conditions are satisfied:

1. go 1.N has been released at least 3 months
   * this gives ~3 months for adoption of go 1.N by the go community
   * this gives ~3 months for completing the backports and cutting Kubernetes patch releases
     until go 1.(N+1) is released and go 1.(N‑1) previously used by Kubernetes patch releases
     goes out of support
2. go 1.N has been used in a released Kubernetes version for at least 1 month
   * this ensures all release-blocking and release-informing CI has run on go 1.N
   * this gives time for release candidates and early adoption by the Kubernetes community
3. Backported code and dependency changes build and pass unit and integration tests with both go 1.N 
   and the go minor version used for the .0 release of the Kubernetes release branch
   * this ensures consumers of patch releases of published Kubernetes
     libraries are not *forced* to update to go 1.N
4. There are no regressions relative to go 1.(N‑1) known to impact Kubernetes
5. Behavior changes in go 1.N are mitigated to preserve existing behavior for previous
   Kubernetes minor versions without requiring action by Kubernetes end-users.
   In go1.21+, the go runtime is expected to match previous runtime behavior by default
   if we leave the go version indicated in `go.mod` files in release branches unchanged.

[release-managers]: /release-managers.md
