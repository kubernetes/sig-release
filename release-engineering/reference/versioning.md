# Kubernetes Release Versioning

Reference: [Semantic Versioning](https://semver.org)

Legend:

- **X.Y.Z** refers to the version (git tag) of Kubernetes that is released.
  This versions all components: apiserver, kubelet, kubectl, etc. (**X** is the
  major version, **Y** is the minor version, and **Z** is the patch version.)

## Release versioning

### Minor version scheme and timeline

- X.Y.0-{alpha,beta}.W, W >= 0 (Branch: master)
  - Alpha and beta releases are created roughly every two weeks directly from
    the master branch.
  - Depending on the release schedule progress, the release team decides when to
    move from alpha.W to beta releases, which then start again at beta.0.
  - No cherrypick releases. If there is a critical bugfix, a new release from
    master can be created ahead of schedule.
- X.Y.Z-rc.W (Branch: release-X.Y)
  - When master is feature-complete for X.Y, we will cut the release-X.Y
    branch 2 weeks prior to the desired X.Y.0 date and cherrypick only PRs essential
    to X.Y.
  - This cut will be marked as X.Y.0-rc.0, and master will be revved to X.Y+1.0-alpha.0.
  - If we're not satisfied with X.Y.0-rc.0, we'll release other rc releases,
    (X.Y.0-rc.W | W > 0) as necessary.
- X.Y.0 (Branch: release-X.Y)
  - Final release, cut from the release-X.Y branch cut two weeks prior.
  - X.Y.0 occur approximately 4 months after X.(Y-1).0.
- X.Y.Z, Z > 0 (Branch: release-X.Y)
  - [Patch releases](#patch-releases) are released as we cherrypick commits into
    the release-X.Y branch as needed.
  - Between patch releases the branch carries no pre-release tag; `git
    describe` reports it as X.Y.Z-N-g<hash> relative to the last patch release.
  - X.Y.Z+1 is cut and tagged straight from the release-X.Y branch by `krel`.
- X.Y.Z, Z > 0 (Branch: release-X.Y.Z)
  - These are special and different in that the X.Y.Z tag is branched to isolate
    the emergency/critical fix from all other changes that have landed on the
    release branch since the previous tag
  - Cut release-X.Y.Z branch to hold the isolated patch release
  - Tag release-X.Y.Z branch + fixes with X.Y.(Z+1)
  - Branched [patch releases](#patch-releases) are rarely needed but used for
    emergency/critical fixes to the latest release, see
    [Hotfix release](../handbooks/release-manager.md#hotfix-release)

### Major version timeline

There is no mandated timeline for major versions and there are currently no criteria
for shipping 2.0.0. We haven't so far applied a rigorous interpretation of semantic
versioning with respect to incompatible changes of any kind (e.g., component flag changes).
We previously discussed releasing 2.0.0 when removing the monolithic `v1` API
group/version, but there are no current plans to do so.

### CI and dev version scheme

- Continuous integration versions also exist, and are versioned off of alpha and
  beta releases. X.Y.Z-alpha.W.C+aaaa is C commits after X.Y.Z-alpha.W, with an
  additional +aaaa build suffix added; X.Y.Z-beta.W.C+bbbb is C commits after
  X.Y.Z-beta.W, with an additional +bbbb build suffix added. Furthermore, builds
  that are built off of a dirty build tree, (during development, with things in
  the tree that are not checked in,) it will be appended with -dirty.

### Supported releases and component skew

We expect users to stay reasonably up-to-date with the versions of Kubernetes
they use in production, but understand that it may take time to upgrade,
especially for production-critical components.

We expect users to be running approximately the latest patch release of a given
minor release; we often include critical bug fixes in
[patch releases](#patch-releases), and so encourage users to upgrade as soon as
possible.

Different components are expected to be compatible across different amounts of
skew, all relative to the control plane version. Nodes may lag the control
plane by up to three minor versions but should be at a version no newer than
the control plane; a client should be skewed no more than one minor version
from the control plane, but may lead it by up to one minor version. For
example, a vX.Y control plane should work with vX.Y-3 to vX.Y nodes, and with
vX.Y-1 to vX.Y+1 clients. The authoritative rules are in the
[version skew policy](https://kubernetes.io/releases/version-skew-policy/).

Furthermore, each minor release is supported for approximately 14 months (12
months of full support plus 2 months of maintenance mode), see the
[support period](https://kubernetes.io/releases/patch-releases/#support-period)
policy. "Support" means we expect users to be running that version in
production, and that fixes are ported back to it. The reasonable response to
the question "my unsupported cluster isn't working" is "you should probably
upgrade it, (and probably should have some time ago)".

## Patch releases

Patch releases are intended for critical bug fixes to the latest minor version,
such as addressing security vulnerabilities, fixes to problems affecting a large
number of users, severe problems with no workaround, and blockers for products
based on Kubernetes.

They should not contain miscellaneous feature additions or improvements, and
especially no incompatibilities should be introduced between patch versions of
the same minor version (or even major version).

Dependencies, such as containerd or etcd, should also not be changed unless
absolutely necessary, and also just to fix critical bugs (so, at most patch
version changes, not new major nor minor versions).

## Upgrades

- Clusters are upgraded as a rolling upgrade, control plane first and then
  one node at a time, following the
  [version skew policy](https://kubernetes.io/releases/version-skew-policy/):
  the control plane is upgraded one minor version at a time, and nodes may
  lag the control plane by up to three minor versions (see
  [Supported releases and component skew](#supported-releases-and-component-skew)).
  - We do not recommend running non-latest patch releases of a given minor
    release.
- No hard breaking changes over version boundaries.
  - For example, if a user is at 1.x, we may require them to upgrade to
    1.x+y before upgrading to 2.x. In others words, an upgrade across
    major versions (e.g. 1.x to 2.x) should effectively be a no-op and as
    graceful as an upgrade from 1.x to 1.x+1. But you can require someone
    to go from 1.x to 1.x+y before they go to 2.x.

There is a separate question of how to track the capabilities of a kubelet to
facilitate rolling upgrades. That is not addressed here.
