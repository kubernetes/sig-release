# Base Image Exception List

Theoretically, we expect to have all kubernetes images based on distroless (Please see this [KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-release/20190316-rebase-images-to-distroless.md) for details). Due to the complexity and difficulty of rebasing all those images, we keep the exception list below to track the reasons and blockers about why certain images are not rebased.

Please feel free to edit this file when you find any updates. Links to detailed `Reason` are welcomed.


| Component Name                    |           Base Image         |        Reasons     |
| --------------------------------- | :---------------------------:|:----------------------:|
|kube-proxy      |  [k8s.gcr.io/debian-iptable](https://github.com/kubernetes/kubernetes/blob/1b9d0c1094d31f851a5ec6e277fbf0b7382196cf/build/common.sh#L101)   | Requires iptable  |
|etcd-empty-dir-cleanup | k8s.gcr.io/debian-base | Requires shell to do some cleanup |
|etcd | k8s.gcr.io/debian-base | Requires shell to do data migration|
|node-problem-detector| k8s.gcr.io/debian-base | Requires libsystemd0 |
|fluentd-elasticsearch |[k8s.gcr.io/debian:stretch-slim](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Dockerfile) |  Requires shell to install fluentd via ruby |
|fluentd-gcp-scaler | [k8s.gcr.io/debian-base-amd64:v1.0.0](https://github.com/GoogleCloudPlatform/k8s-stackdriver/blob/master/fluentd-gcp-scaler/Dockerfile) |  Requires shell and kubectl |
|stackdriver-logging-agent |  | requires fluentd |
|ip-masq-agent | k8s.gcr.io/debian-iptables| Requires the iptables for all arches.|
|kube-addon-manager | k8s.gcr.io/debian-base| Requires [shell](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/kube-addons.sh).|
|k8s-dns-kube-dns  |  k8s.gcr.io/debian-base  | Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
|k8s-dns-sidecar  |  k8s.gcr.io/debian-base  |  Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
|k8s-dns-dnsmasq-nanny  |  k8s.gcr.io/debian-base  |  Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
|k8s-dns-node-cache  |  k8s.gcr.io/debian-base  |  Requires [container debugging tooling](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190212-ephemeral-containers.md) |
|kube-apiserver | k8s.gcr.io/debian-base| Causes performance regression, requires further investigation on klog when running 2000 nodes scalability test. OWNER:@yuwenma|
|kube-controller-manager | k8s.gcr.io/debian-base| Causes performance regression, requires further investigation on klog when running 2000 nodes scalability test. OWNER:@yuwenma|
|kube-scheduler | k8s.gcr.io/debian-base| Causes performance regression, requires further investigation on klog when running 2000 nodes scalability test. OWNER:@yuwenma|
