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

The `kube-cross` image provides the cross-compilation toolchain used to build
Kubernetes for multiple platforms. It must use the same Go version that
Kubernetes is being updated to.

To update the image, create a PR in
[kubernetes/release](https://github.com/kubernetes/release/tree/master/images/build/cross/)
modifying:

- `variants.yaml`: update `GO_VERSION` and `KUBERNETES_VERSION` for the
  target variant.
- `Makefile`: update the default `GO_VERSION` and `KUBERNETES_VERSION` values
  to match.
- `default/Dockerfile`: usually no changes needed unless the cross-compilation
  toolchain itself changes.

Merging the PR triggers the image build via a GCP Cloud Build job configured in
[kubernetes/test-infra](https://github.com/kubernetes/test-infra/blob/master/config/jobs/image-pushing/k8s-staging-build-image.yaml).
The build runs automatically on changes to the `images/build/cross/` directory.

### kube-cross image promotion

After the image is built in staging, promote it to production by creating a PR
in [kubernetes/k8s.io](https://github.com/kubernetes/k8s.io):

- Update the image digest and version tag in
  [`registry.k8s.io/images/k8s-staging-build-image/images.yaml`](https://github.com/kubernetes/k8s.io/blob/main/registry.k8s.io/images/k8s-staging-build-image/images.yaml).
- Include a link to the staging build run and CC
  `@kubernetes/release-engineering`.

## k8s-cloud-builder image

The `k8s-cloud-builder` image is used during the release process to run
`krel stage` and `krel release` in Google Cloud Build. It is maintained in the
[kubernetes/release](https://github.com/kubernetes/release/tree/master/images/k8s-cloud-builder)
repository. When updating Go, ensure that the `k8s-cloud-builder` image is
rebuilt with the new Go version as part of the overall update.

## `kubernetes/kubernetes` updates

### `master` branch updates

To update Go on the `master` branch of `kubernetes/kubernetes`:

1. Ensure the promoted `kube-cross` image is available (see above).
2. Update the Go version in
   [`build/build-image/cross/VERSION`](https://github.com/kubernetes/kubernetes/blob/master/build/build-image/cross/VERSION)
   and related files.
3. Run `hack/pin-dependency.sh` and `hack/update-vendor.sh` if dependencies
   require changes for the new Go version.
4. Verify that all unit, integration, and e2e tests pass with the new version.

Example PRs can be found in the tracking issues linked in the
[Signaling intent](#signaling-intent) section.

### Cherry picks

Cherry picking Go updates to release branches follows the same process as any
other cherry pick (see the
[cherry pick guide](https://git.k8s.io/community/contributors/devel/sig-release/cherry-picks.md)).
Before cherry picking a Go update, ensure the prerequisites described in the
[Minor version updates](#minor-version-updates) section are met for the target
branch.

## kubekins and krte images

The `kubekins-e2e` and `krte` images are maintained in
[kubernetes/test-infra](https://github.com/kubernetes/test-infra). They are used
by CI jobs and must be updated to use the new Go version after
`kubernetes/kubernetes` has been updated. Coordinate with
[SIG Testing](https://github.com/kubernetes/community/tree/master/sig-testing)
for these updates.

## `publishing-bot` updates

The [publishing-bot](https://github.com/kubernetes/publishing-bot) publishes
code from `kubernetes/kubernetes/staging` to downstream repositories. After a Go
update lands on a branch, the publishing-bot rules may need updating to ensure
the published modules reference the correct Go version in their `go.mod` files.
Check the publishing-bot configuration and coordinate with SIG API Machinery if
changes are needed.

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

[release-managers]: https://github.com/kubernetes/website/blob/main/content/en/releases/release-managers.md
