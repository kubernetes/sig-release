# Base Image Exception List

Theoretically, we expect to have all kubernetes images based on distroless (Please see this [KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-release/20190316-rebase-images-to-distroless.md) for details). Due to the complexity and difficulty of rebasing all those images, we keep the exception list below to track the reasons and blockers about why certain images are not rebased.

Please feel free to edit this file when you find any updates. Links to detailed `Reason` are welcomed.

- [Release images](#release-images)
  - [Release: `debian-base`](#release-debian-base)
  - [Release: `debian-iptables`](#release-debian-iptables)
  - [Release: `go-runner`](#release-go-runner)
- [Non-release images](#non-release-images)
- [Non-org images](#non-org-images)

## Release images

### Release: `debian-base`

| Image Name | Reasons for exception |
|---|---|
| [debian-iptables] | Needed to supported images that require `iptables` |

### Release: `debian-iptables`

| Image Name | Reasons for exception |
|---|---|
| [kube-proxy][core-images] | Requires `iptables` |

### Release: `go-runner`

| Image Name | Reasons for exception |
|---|---|
| [kube-apiserver][core-images] | `go-runner` (`distroless++`)[[1](https://github.com/kubernetes/kubernetes/pull/90804)][[2](https://github.com/kubernetes/kubernetes/pull/90674)] |
| [kube-scheduler][core-images] | `go-runner` (`distroless++`)[[1](https://github.com/kubernetes/kubernetes/pull/90804)][[2](https://github.com/kubernetes/kubernetes/pull/90674)] |

## Non-release images

| Image Name | Base Image | OWNER | Supported? (Yes/No/Unknown) | Reasons for exception |
|---|---|---|---|---|
| [etcd] | [debian-base] | https://github.com/kubernetes/kubernetes/blob/master/cluster/images/etcd/OWNERS | Y | Requires shell to do data migration |
| [etcd-empty-dir-cleanup] | [debian-base] | https://github.com/kubernetes/kubernetes/blob/master/cluster/images/etcd-empty-dir-cleanup/OWNERS | U | Requires shell to do some cleanup |
| [fluentd-elasticsearch] | `ruby:2.7-slim-buster` | https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-elasticsearch/OWNERS | U | Requires shell to install fluentd via ruby |
| [ip-masq-agent] | [debian-iptables] | https://github.com/kubernetes-sigs/ip-masq-agent/blob/master/OWNERS | U | Requires `iptables` |
| [k8s-dns-dnsmasq-nanny] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| [k8s-dns-kube-dns] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| [k8s-dns-node-cache] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| [k8s-dns-sidecar] | [debian-base] | https://github.com/kubernetes/dns/blob/master/OWNERS | U | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| [kube-addon-manager] | [debian-base] | https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/OWNERS | U | Requires [shell](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/kube-addons.sh) |
| [node-problem-detector] | [debian-base] | https://github.com/kubernetes/node-problem-detector/blob/master/OWNERS | U | Requires `libsystemd0` |

## Non-org images

| Image Name | Base Image | OWNER | Supported? (Yes/No/Unknown) | Reasons for exception |
|---|---|---|---|---|
| [fluentd-gcp-scaler] | [debian-base] |  | U | Requires shell and kubectl |
| [stackdriver-logging-agent] | `debian:buster` |  | U | Requires fluentd |

[core-images]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/build/common.sh#L90-L110
[debian-base]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/build/debian-base/Dockerfile.build
[debian-iptables]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/build/debian-iptables/Dockerfile
[etcd]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/cluster/images/etcd/Dockerfile
[etcd-empty-dir-cleanup]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/cluster/images/etcd-empty-dir-cleanup/Dockerfile
[fluentd-elasticsearch]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Dockerfile
[fluentd-gcp-scaler]: https://github.com/GoogleCloudPlatform/k8s-stackdriver/blob/a8690c15342dc0545c8ed404c7e3ba70867e08f2/fluentd-gcp-scaler/Dockerfile
[ip-masq-agent]: https://github.com/kubernetes-sigs/ip-masq-agent/blob/83d8fe820435ac4c6b045a597d993ddee2983d1f/Dockerfile.in
[k8s-dns-dnsmasq-nanny]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.dnsmasq-nanny
[k8s-dns-kube-dns]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.kube-dns
[k8s-dns-node-cache]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.node-cache
[k8s-dns-sidecar]: https://github.com/kubernetes/dns/blob/69830ba1a789b3e44d4bb37a96ef01332b8044a0/Dockerfile.sidecar
[kube-addon-manager]: https://github.com/kubernetes/kubernetes/blob/d63d77dc4cae044702dac1fc5a97fafebebcbb0f/cluster/addons/addon-manager/Dockerfile
[node-problem-detector]: https://github.com/kubernetes/node-problem-detector/blob/1d03b66f1516657a354a7466e975e59fc9aafd29/Dockerfile.in
[stackdriver-logging-agent]: https://github.com/Stackdriver/agent-packaging
