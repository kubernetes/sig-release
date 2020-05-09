# Base Image Exception List

Theoretically, we expect to have all kubernetes images based on distroless (Please see this [KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-release/20190316-rebase-images-to-distroless.md) for details). Due to the complexity and difficulty of rebasing all those images, we keep the exception list below to track the reasons and blockers about why certain images are not rebased.

Please feel free to edit this file when you find any updates. Links to detailed `Reason` are welcomed.

- [Release images](#release-images)
  - [Release: `debian-base`](#release-debian-base)
  - [Release: `debian-iptables`](#release-debian-iptables)
- [Non-release images](#non-release-images)

## Release images

### Release: `debian-base`

| Image Name | Reasons for exception |
|---|---|
| debian-iptables | Needed to supported images that require `iptables` |
| kube-apiserver | Causes performance regression, requires further investigation on klog when running 2000 nodes scalability test. OWNER:@yuwenma |
| kube-controller-manager | Causes performance regression, requires further investigation on klog when running 2000 nodes scalability test. OWNER:@yuwenma |
| kube-scheduler | Causes performance regression, requires further investigation on klog when running 2000 nodes scalability test. OWNER:@yuwenma |

### Release: `debian-iptables`

| Image Name | Reasons for exception |
|---|---|
| kube-proxy | Requires `iptables` |

## Non-release images

| Image Name | Base Image | OWNER | Supported? | Reasons for exception |
|---|---|---|---|---|
| etcd | [debian-base] |  |  | Requires shell to do data migration |
| etcd-empty-dir-cleanup | [debian-base] |  |  | Requires shell to do some cleanup |
| fluentd-elasticsearch | [k8s.gcr.io/debian:stretch-slim](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Dockerfile) |  |  | Requires shell to install fluentd via ruby |
| fluentd-gcp-scaler | [[debian-base]-amd64:v1.0.0](https://github.com/GoogleCloudPlatform/k8s-stackdriver/blob/master/fluentd-gcp-scaler/Dockerfile) |  |  | Requires shell and kubectl |
| ip-masq-agent | [debian-iptables] |  |  | Requires `iptables` |
| k8s-dns-dnsmasq-nanny | [debian-base] |  |  | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| k8s-dns-kube-dns | [debian-base] |  |  | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| k8s-dns-node-cache | [debian-base] |  |  | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| k8s-dns-sidecar | [debian-base] |  |  | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
| kube-addon-manager | [debian-base] |  |  | Requires [shell](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/kube-addons.sh) |
| node-problem-detector | [debian-base] |  |  | Requires `libsystemd0` |
| stackdriver-logging-agent |  |  |  | Requires fluentd |

[debian-base]: https://github.com/kubernetes/kubernetes/blob/ba3bf32300574d86c98657981c96ca609de787a2/build/debian-base/Dockerfile.build
[debian-iptables]: https://github.com/kubernetes/kubernetes/blob/ba3bf32300574d86c98657981c96ca609de787a2/build/debian-iptables/Dockerfile
