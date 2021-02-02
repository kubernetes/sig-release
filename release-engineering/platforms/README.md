# Platform Builds

The Kubernetes project's development process produces
[artifacts](../artifacts.md) for different architectures and operating systems.
We consider the combination of architecture (`GOARCH`) and operating system
(`GOOS`) as "platforms". Target of this document is to outline different
categories of platforms as well as guiding through their graduation criteria.

## Tiers

Build and release support for different platforms' artifacts are organized into
three tiers, whereas each comes with a different set of guarantees. Tiers can be
scoped to single binaries or a subset of them. This means for example that we
can provide Tier 1 support for client binaries, even if the server binaries do
not exist at all.

### Tier 1

Tier 1 platforms are considered as "expected to work". To achieve this, they
have to fulfill the following criteria:

- Official binary releases are provided for the platform. This includes
  container images as well as deb and rpm packages. Building the artifacts is
  integrated in the release process.
- Continuous Integration is set up to run tests for the platform. Necessary
  tests are defined by SIG Release and usually correspond to the
  [`blocking`](https://testgrid.k8s.io/sig-release-master-blocking) and
  [`informing`](https://testgrid.k8s.io/sig-release-master-informing) testgrid
  dashboards.
- Documentation about the usage of artifacts for the platform is available.

### Tier 2

Tier 2 platforms are considered as "expected to build". To achieve this, they
have to fulfill the following criteria:

- Official binary releases are provided for the platform. Building the artifacts
  is integrated in the release process.
- Automated testing is not or only partially setup.

It may be possible that single features are not available for a certain
platform.

### Tier 3

Tier 3 platforms are those that have been demonstrated to work and have a
documented build process that is available to anyone in the community. There is
no guarantee that builds will continue to work, and the platform may be dropped
if documentation is not maintained.

- Official builds are not available.
- Automated testing is not setup.
- Documentation on how to build for the platform is available.

## Currently available Kubernetes platforms

The following table defines the current setup of available Kubernetes platforms:

| Platform        |       Tier 1       |       Tier 2       |       Tier 3       |
| --------------- | :----------------: | :----------------: | :----------------: |
| `amd64-linux`   | :heavy_check_mark: |                    |                    |
| `arm64-linux`   |                    | :heavy_check_mark: |                    |
| `arm-linux`     |                    | :heavy_check_mark: |                    |
| `amd64-darwin`  |                    | :heavy_check_mark: |                    |
| `386-linux`     |                    | :heavy_check_mark: |                    |
| `ppc64le-linux` |                    | :heavy_check_mark: |                    |
| `s390x-linux`   |                    | :heavy_check_mark: |                    |
| `386-windows`   |                    | :heavy_check_mark: |                    |
| `amd64-windows` |                    | :heavy_check_mark: |                    |
