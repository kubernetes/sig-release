# Platforms Guide

This document outlines the necessary steps to either add or remove supported
platform builds in Kubernetes.

## Adding supported platforms

The default Kubernetes platform is `linux/amd64`. This platform is fully tested,
where build and release systems initially supported only that. A while ago we
started an [effort to support multiple architectures][0]. As part of this
effort, we added support in our build and release pipelines for the
architectures `arm`, `arm64`, `ppc64le` and `s390x` on different operating
systems like Linux, Windows and macOS.

[0]: https://github.com/kubernetes/kubernetes/issues/38067

The main focus was to have binaries and container images to be available for
these architectures/operating systems. Contributors should be able to to take
these artifacts and set up CI jobs to adequately test these platforms.
Specifically to call out the ability to run conformance tests on these
platforms.

Target of this document is to provide a starting point for adding new platforms
to Kubernetes from a SIG Architecture and SIG Release perspective. This does not
include release mechanics or supportability in terms of functionality.

### Step 1: Building

The container image based build infrastructure should support this architecture.
This implicitly requires the following:

- golang should support the platform
- All dependencies, whether vendored or run separately, should support this
  platform

In other words, anyone in the community should be able to use our build infra to
generate all artifacts required to stand up Kubernetes.

More information about how to build Kubernetes can be found in [the build
documentation][1].

[1]: https://github.com/kubernetes/kubernetes/tree/3f7c09e/build#building-kubernetes

### Step 2: Testing

It is not enough for builds to work as it gets bit-rotted quickly when we vendor
in new changes, update versions of things we use etc. So we need a good set of
tests that exercise a wide battery of jobs in this new architecture.

A good starting point from a testing perspective are:

- unit tests
- e2e tests
- node e2e tests

This will ensure that community members can rely on these architectures on a
consistent basis. This will give folks who are making changes a signal when they
break things in a specific architecture.

This implies a set of folks who stand up and maintain both post-submit and
periodic tests, watch them closely and raise the flag when things break. They
will also have to help debug and fix any platform specific issues as well.

Creating custom [testgrid][4] dashboards can help to monitor platform specific
tests.

[4]: https://testgrid.k8s.io

### Step 3: Releasing

With the first 2 steps we have a reasonable expectation that there are people
taking care of a supported platform and it works in a reproducible environment.

Getting to the next level is a big jump from here. We are talking about real
users who are betting their business literally on the work we are doing here. So
we need guarantees around "can we really ship this!?" question.

Specifically we are talking about a set of CI jobs in our release-informing and
release-blocking tabs of our testgrid. The Kubernetes release team has a "CI
signal" team that relies on the status(es) of these jobs to either ship or hold
a release. Essentially, if things are mostly red with occasional green, it would
be prudent to not even bother making this architecture as part of the release.
CI jobs get added to release-informing first and when these get to a point where
they work really well, then they get promoted to release-blocking.

The problem here is once we start shipping something, users will start to rely
on it, whether we like it or not. So it becomes a trust issue on this team that
is talking care of a platform/architecture. Do we really trust this team not
just for this release but on an ongoing basis. Do they show up consistently when
things break, do they proactively work with testing/release on ongoing efforts
and try to apply them to their architectures. It's very easy to setup a CI job
as a one time thing, tick a box and advocate to get something added. It's a
totally different ball game to be there consistently over time and show that you
mean it. There has to be a consistent body of people working on this over time
(life happens!).

What are we looking for here, a strong green CI signal for release managers
to cut a release and for folks to be able to report problems and them getting
addressed. This includes [conformance testing][2] as use of the Kubernetes
trademark is controlled through a conformance ensurance process. So we are
looking for folks here to work with [the conformance sub project][3] in addition
to testing and release.

[2]: https://github.com/cncf/k8s-conformance
[3]: https://bit.ly/sig-architecture-conformance

### Step 4: Finishing

If you got this far, you really have made it! You have a clear engagement with
the community, you are working seamlessly with all the relevant SIGs, you have
your content in the Kubernetes release and get end users to adopt your
architecture. Having achieved conformance, you will gain conditional use of the
Kubernetes trademark relative to your offerings.

### Generic rules to consider

- We should keep it easy for contributors to get into Step 1.
- Step 1, by default things should not build and should be switched off.
- Step 1, should not place undue burden on review or infrastructure (case in
  point - Windows).
- Once Step 2 is done, we could consider switching things on by default (but
  still not in release artifacts).
- Once Step 3 is done, binaries / images in arch can ship with release.
- Step 2 is at least the default e2e-gce equivalent, PLUS the node e2e tests.
  More the better.
- Step 2 will involve 3rd party reporting to test-grid at the least.
- Step 2 may end up needing boskos etc to run against clouds (with these arches)
  where we have credits.
- Step 3 is at least the conformance test suite. More the better. Using
  community tools like prow/kubeadm is encouraged but not mandated.
- Step 4 is where we take this up to CNCF trademark program. For at least a year
  in Step 3 before we go to Step 4.
- If at any stage things bit rot, we go back to a previous step, giving an
  opportunity for the community to step up.

## Deprecating and removing supported platforms

Supported platforms may be considered as deprecated for various reasons, for
example if they are being replaced by new ones, are not actively used or
maintained any more. Deprecating an already supported platform has to follow a
couple of steps:

1. The platform deprecation has been announced on k-dev and links to a k/k issue
   for further discussions and consensus.

1. The deprecation will be active immediately after consensus has been reached
   at a set deadline. This incorporates approval from SIG Release and
   Architecture.

1. Removing the supported platform will be done in the beginning of the next
   minor (v1.N+1.0) release cycle, which means to:
   - Update the k/k build scripts to exclude the platform from all targets
   - Update the k/sig-release repository to reflect the current set of supported
     platforms.

Please note that actively supported release branches are not affected by the
removal. This ensures compatibility with existing artifact consumers.
