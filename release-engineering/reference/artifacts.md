# Release Artifacts

This document describes the artifacts produced by the Kubernetes release
process. The canonical list of artifacts for any release is available at
`https://dl.k8s.io/v<version>/`.

All binary artifacts include corresponding `.sha256` and `.sha512` checksums.

## Container Images

All container images are published to `registry.k8s.io` and are available as
multi-architecture manifest lists.

| Image                   | amd64 | arm64 | ppc64le | s390x |
| ----------------------- | :---: | :---: | :-----: | :---: |
| conformance             |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-apiserver          |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-controller-manager |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-proxy              |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-scheduler          |  ✅   |  ✅   |   ✅    |  ✅   |
| kubectl                 |  ✅   |  ✅   |   ✅    |  ✅   |

## Binaries

Individual binaries are available at `https://dl.k8s.io/v<version>/bin/<os>/<arch>/`.

| Binary                  | linux | darwin | windows |
| ----------------------- | :---: | :----: | :-----: |
| apiextensions-apiserver |  ✅   |        |         |
| kube-apiserver          |  ✅   |        |         |
| kube-controller-manager |  ✅   |        |         |
| kube-proxy              |  ✅   |        |   ✅    |
| kube-scheduler          |  ✅   |        |         |
| kubeadm                 |  ✅   |        |   ✅    |
| kubectl                 |  ✅   |   ✅   |   ✅    |
| kubelet                 |  ✅   |        |   ✅    |
| mounter                 |  ✅   |        |         |

Linux binaries are available for amd64, arm64, ppc64le, and s390x. Darwin
binaries are available for amd64 and arm64. Windows/amd64 provides client and
node binaries. Windows/arm64 provides only kubectl. See the
[platform support table](platforms.md) for details.

## Tar Archives

| Archive                                    | darwin | linux | windows | portable |
| ------------------------------------------ | :----: | :---: | :-----: | :------: |
| kubernetes-client-**[system-arch]**.tar.gz  |   ✅   |  ✅   |   ✅    |          |
| kubernetes-server-**[system-arch]**.tar.gz  |        |  ✅   |         |          |
| kubernetes-node-**[system-arch]**.tar.gz    |        |  ✅   |   ✅    |          |
| kubernetes-test-**[system-arch]**.tar.gz    |   ✅   |  ✅   |   ✅    |    ✅    |
| kubernetes-src.tar.gz                       |        |       |         |    ✅    |
| kubernetes.tar.gz                           |        |       |         |    ✅    |

The available architectures per OS match those listed in the binaries section
above.

## Packages

Packages are published to https://pkgs.k8s.io. See the
[pkgs.k8s.io documentation](https://kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/)
for repository setup instructions.

### RPMs

| Package                                         | aarch64 | ppc64le | s390x | x86_64 |
| ----------------------------------------------- | :-----: | :-----: | :---: | :----: |
| cri-tools-**[version]**.**[arch]**.rpm           |   ✅    |   ✅    |  ✅   |   ✅   |
| kubeadm-**[version]**.**[arch]**.rpm             |   ✅    |   ✅    |  ✅   |   ✅   |
| kubectl-**[version]**.**[arch]**.rpm             |   ✅    |   ✅    |  ✅   |   ✅   |
| kubelet-**[version]**.**[arch]**.rpm             |   ✅    |   ✅    |  ✅   |   ✅   |
| kubernetes-cni-**[version]**.**[arch]**.rpm      |   ✅    |   ✅    |  ✅   |   ✅   |

### Debs

| Package                                         | amd64 | arm64 | ppc64el | s390x |
| ----------------------------------------------- | :---: | :---: | :-----: | :---: |
| cri-tools-**[version]**.**[arch]**.deb           |  ✅   |  ✅   |   ✅    |  ✅   |
| kubeadm-**[version]**.**[arch]**.deb             |  ✅   |  ✅   |   ✅    |  ✅   |
| kubectl-**[version]**.**[arch]**.deb             |  ✅   |  ✅   |   ✅    |  ✅   |
| kubelet-**[version]**.**[arch]**.deb             |  ✅   |  ✅   |   ✅    |  ✅   |
| kubernetes-cni-**[version]**.**[arch]**.deb      |  ✅   |  ✅   |   ✅    |  ✅   |
