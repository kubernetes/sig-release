# Base Image Exception List

We expect all Kubernetes images to be based on distroless (please see this [KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-release/20190316-rebase-images-to-distroless.md) for details). Due to the complexity and difficulty of rebasing all those images, we keep the exception list below to track the reasons and blockers about why certain images are not rebased.

Please feel free to edit this file when you find any updates. Links to detailed `Reason` are welcomed. The list was last curated in October 2026.

- [Release images](#release-images)
  - [Release: `debian-base`](#release-debian-base)
  - [Release: `distroless-iptables`](#release-distroless-iptables)
  - [Release: `go-runner`](#release-go-runner)
- [Non-release images](#non-release-images)
- [Non-org images](#non-org-images)

## Release images

### Release: `debian-base`

| Image Name | Reasons for exception |
|---|---|
| [distroless-iptables] | Needed to support images that require `iptables` |

### Release: `distroless-iptables`

| Image Name | Reasons for exception |
|---|---|
| [kube-proxy][core-images] | Requires `iptables` |

### Release: `go-runner`

| Image Name | Reasons for exception |
|---|---|
| [kube-apiserver][core-images] | `go-runner` (`distroless++`)[[1](https://github.com/kubernetes/kubernetes/pull/90804)][[2](https://github.com/kubernetes/kubernetes/pull/90674)] |
| [kube-scheduler][core-images] | `go-runner` (`distroless++`)[[1](https://github.com/kubernetes/kubernetes/pull/90804)][[2](https://github.com/kubernetes/kubernetes/pull/90674)] |
| [kubectl][core-images] | `go-runner` (`distroless++`)[[1](https://github.com/kubernetes/kubernetes/pull/90804)][[2](https://github.com/kubernetes/kubernetes/pull/90674)] |

## Non-release images

| Image Name | Base Image | OWNER | Supported? (Yes/No/Unknown) | Reasons for exception |
|---|---|---|---|---|
| [ip-masq-agent] | [distroless-iptables] | https://github.com/kubernetes-sigs/ip-masq-agent/blob/master/OWNERS | U | Requires `iptables` |
| [k8s-dns-dnsmasq-nanny] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/277-ephemeral-containers/README.md) |
| [k8s-dns-kube-dns] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/277-ephemeral-containers/README.md) |
| [k8s-dns-node-cache] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/277-ephemeral-containers/README.md) |
| [k8s-dns-sidecar] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/277-ephemeral-containers/README.md) |
| [kube-addon-manager] | [debian-base] | https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/OWNERS | U | Requires [shell](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/kube-addons.sh) |
| [node-problem-detector] | [debian-base] | https://github.com/kubernetes/node-problem-detector/blob/master/OWNERS | U | Requires `libsystemd0` |

## Non-org images

| Image Name | Base Image | OWNER | Supported? (Yes/No/Unknown) | Reasons for exception |
|---|---|---|---|---|
| [fluentd-gcp-scaler] | [debian-base] |  | U | Requires shell and kubectl |
| [stackdriver-logging-agent] | `debian:buster` |  | U | Requires fluentd |

[core-images]: https://github.com/kubernetes/kubernetes/blob/master/build/common.sh
[debian-base]: https://github.com/kubernetes/release/tree/master/images/build/debian-base
[distroless-iptables]: https://github.com/kubernetes/release/tree/master/images/build/distroless-iptables
[fluentd-gcp-scaler]: https://github.com/GoogleCloudPlatform/k8s-stackdriver/blob/a8690c15342dc0545c8ed404c7e3ba70867e08f2/fluentd-gcp-scaler/Dockerfile
[ip-masq-agent]: https://github.com/kubernetes-sigs/ip-masq-agent/blob/83d8fe820435ac4c6b045a597d993ddee2983d1f/Dockerfile.in
[k8s-dns-dnsmasq-nanny]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.dnsmasq-nanny
[k8s-dns-kube-dns]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.kube-dns
[k8s-dns-node-cache]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.node-cache
[k8s-dns-sidecar]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.sidecar
[kube-addon-manager]: https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/Dockerfile
[node-problem-detector]: https://github.com/kubernetes/node-problem-detector/blob/1d03b66f1516657a354a7466e975e59fc9aafd29/Dockerfile.in
[stackdriver-logging-agent]: https://github.com/Stackdriver/agent-packaging
