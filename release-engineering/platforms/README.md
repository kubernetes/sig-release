# Platform Support

The Kubernetes project produces [artifacts](../artifacts.md) for different
architectures and operating systems. A "platform" is the combination of
architecture (`GOARCH`) and operating system (`GOOS`). This document defines the
support tiers for platforms, the criteria for each tier, and the process for
promoting or demoting platforms between tiers.

The process for adding or removing platforms is described in the
[platforms guide](https://github.com/kubernetes/community/blob/master/contributors/guide/platforms.md).

## Tiers

Platform support is organized into three tiers. Each tier provides a different
level of guarantees. Tiers can be scoped to individual binaries or subsets of
them. For example, a platform can have Tier 1 support for client binaries while
server binaries do not exist for that platform at all.

### Tier 1: Fully Supported

Tier 1 platforms are expected to work. They must meet all of the following
criteria:

- Official binary releases and container images are provided. OS-native packages
  (e.g., deb/rpm) are provided where applicable. Artifact builds are integrated
  into the release process.
- CI jobs covering at minimum unit, integration, and end-to-end (e2e) tests run
  on the
  [`blocking`](https://testgrid.k8s.io/sig-release-master-blocking) testgrid
  dashboard. Jobs on the
  [`informing`](https://testgrid.k8s.io/sig-release-master-informing) dashboard
  are recommended but not required. See
  [release-blocking-jobs.md](../../release-blocking-jobs.md) for the policy on
  blocking job requirements.
- CI failures on the blocking dashboard prevent releases.
- At least two maintainers are responsible for the platform and reachable for
  issue triage and fixes.
- The Go toolchain provides first-class support for the platform.
- Documentation for the platform's artifacts is available on kubernetes.io.

### Tier 2: Officially Built

Tier 2 platforms are expected to build. They must meet all of the following
criteria:

- Official binary releases are provided. Artifact builds are integrated into the
  release process. Container images and packages may or may not be available.
- CI jobs run on the
  [`informing`](https://testgrid.k8s.io/sig-release-master-informing) testgrid
  dashboard or on a dedicated conformance dashboard. The required test types
  depend on the scope of the platform: platforms providing server or node
  binaries must run unit, integration, and end-to-end (e2e) tests.
  Client-only platforms must run at minimum unit and integration tests.
- CI failures do not prevent releases but are monitored by the platform
  maintainers.
- At least two maintainers are responsible for the platform and reachable for
  issue triage and fixes.
- The Go toolchain provides first-class support for the platform.
- Each Tier 2 platform should be organized as a SIG Release subproject with
  dedicated OWNERS.

It is possible that individual features are not available for Tier 2 platforms.
Tier 2 does not create obligations for contributors outside the platform's
maintainers. Bug reports or feature requests specific to Tier 2 platforms may be
redirected to the platform maintainers.

Tier 2 is a valid long-term status for platforms that are widely used but where
blocking CI is impractical (for example, client-only platforms like darwin).
However, new platforms entering Tier 2 should include a promotion plan or a
rationale for why Tier 2 is the appropriate long-term tier. Promotion plans must
declare the platform's maintainers and reference a KEP. Promotion plans are
subject to the
[KEP no-perma-beta policy](https://kubernetes.io/blog/2020/08/21/moving-forward-from-beta/)
and are re-evaluated by SIG Release every two release cycles to ensure progress
is being made. Platforms must have CI in place before or alongside being added to
the official build. Adding a platform to the release builds without any CI is
not permitted.

### Tier 3: Community Supported

Tier 3 platforms have been demonstrated to work but receive no official support
from the project. The project does not build, test, or release artifacts for
Tier 3 platforms. All support is provided by external maintainers.

- No official builds or artifacts are provided.
- No project CI is set up.
- A documented build process is available in the community.
- External artifacts may be linked with a clear disclaimer that the Kubernetes
  project does not guarantee their security or availability.

Tier 3 does not create obligations for the project. Bug reports or feature
requests specific to Tier 3 platforms may be closed without action.

## Evaluation Criteria

The following criteria are considered when evaluating a platform for any tier.
Not all criteria carry equal weight and SIG Release applies judgment based on the
overall picture.

### Maintainer Commitment

Each platform requires dedicated maintainers who:

- Monitor CI dashboards and fix platform-specific failures.
- Triage and respond to bug reports related to the platform.
- Participate in SIG Release communication channels.
- Provide or arrange access to hardware or CI infrastructure when needed.

### Ecosystem Support

The platform's support in the broader ecosystem matters. This includes:

- Go toolchain support level (first-class port vs secondary port).
- Availability of base container images (distroless, debian).
- Support in key dependencies used by the build and release process.

Platforms where Go itself treats the architecture as a secondary port (where
build breakages are not guaranteed to be fixed upstream) are restricted to
Tier 3. The Kubernetes project depends too heavily on the Go toolchain to
accept the risk of unsupported upstream breakages at higher tiers.

### User Demand

Evidence of real user demand is required for Tier 1 and Tier 2. Acceptable
evidence includes:

- Download or pull statistics for official artifacts from pkgs.k8s.io and
  registry.k8s.io.
- Publicly stated production usage of official Kubernetes artifacts by multiple
  organizations. Usage of third-party builds alone does not constitute demand
  for official project support. Organizations relying on vendor-provided builds
  should seek support from those vendors.
- Adoption trends in the broader cloud native ecosystem.

Demand claims must be substantiated with concrete data. Low demand relative to
the maintenance and infrastructure cost is grounds for demotion or rejection.

### Build and Infrastructure Cost

Adding a platform increases build times, infrastructure costs, and maintenance
burden for all contributors. Platforms that significantly increase release build
times or are a disproportionate source of build failures may be demoted or
rejected regardless of other criteria.

### Right to Reject

SIG Release reserves the right to reject a platform even if all stated criteria
are met. Reasons include but are not limited to infrastructure costs, dependency
on proprietary tooling, insufficient trust in long-term maintainer commitment,
or disproportionate burden on the project relative to demonstrated demand.

## Promoting a Platform

New platforms enter at Tier 3. A platform must meet all criteria of the target
tier before promotion. The process is:

1. An existing member of the Kubernetes GitHub organization with sufficient
   project history opens a GitHub issue in the
   [SIG Release repository](https://github.com/kubernetes/sig-release/issues)
   stating the target tier and providing evidence that all criteria are met.
2. The platform should have spent at least two full release cycles at its
   current tier without major issues.
3. For promotions to Tier 2 or Tier 1, SIG Testing must acknowledge that the
   proposed CI coverage is adequate.
4. SIG Release evaluates the request and decides by lazy consensus.
5. On approval, the platform table below is updated, the change is announced on
   the [Kubernetes Announce mailing list](https://groups.google.com/g/kubernetes-announce),
   and takes effect in the next release cycle.

For Tier 2 to Tier 1 promotions, CI jobs must first be promoted from informing
to blocking following the procedure in
[release-blocking-jobs.md](../../release-blocking-jobs.md).

## Demoting a Platform

A platform that no longer meets the criteria of its current tier will be
demoted. The process is:

1. SIG Release or SIG Testing opens a GitHub issue describing which criteria are
   no longer met.
2. Platform maintainers are given two full release cycles to address the issues.
3. If the issues are not resolved, the platform is demoted.
4. The demotion is announced on the
   [Kubernetes Announce mailing list](https://groups.google.com/g/kubernetes-announce).

A platform may be demoted faster than two release cycles if it is causing
repeated release delays, build failures, or if the platform maintainers become
unresponsive.

Demotions and removals take effect in the next release cycle. Actively supported
release branches continue to produce artifacts for the demoted platform until
they reach end of life.

## Current Platform Support

| Platform          |       Tier 1       |       Tier 2       | Tier 3 | Notes       |
| ----------------- | :----------------: | :----------------: | :----: | ----------- |
| `amd64-linux`     | :heavy_check_mark: |                    |        |             |
| `arm64-linux`     |                    | :heavy_check_mark: |        |             |
| `amd64-darwin`    |                    | :heavy_check_mark: |        | client only |
| `arm64-darwin`    |                    | :heavy_check_mark: |        | client only |
| `ppc64le-linux`   |                    | :heavy_check_mark: |        |             |
| `s390x-linux`     |                    | :heavy_check_mark: |        |             |
| `amd64-windows`   |                    | :heavy_check_mark: |        | client and node |
| `arm64-windows`   |                    | :heavy_check_mark: |        | client only |

## Removed Platforms

- **`386-linux`**, **`386-windows`**: No artifacts are produced as of v1.35.
- **`arm-linux`**: Removed due to relocation problems on linking breaking the
  build-master job.
  - https://github.com/kubernetes/kubernetes/pull/115742
  - https://github.com/kubernetes/kubernetes/issues/116492
  - https://github.com/kubernetes/kubernetes/issues/115738
  - https://github.com/kubernetes/kubernetes/issues/115675
