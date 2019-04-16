# Base Image Exception List

Theoretically, we expect to have all kubernetes images based on distroless (Please see this [KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-release/20190316-rebase-images-to-distroless.md) for details). Due to the complexity and difficulty of rebasing all those images, we keep the exception list below to track the reasons and blockers about why certain images are not rebased.

Please feel free to edit this file when you find any updates. Links to detailed `Reason` are welcomed.


| Component Name        |           Base Image         |        Reasons     |
| --------------------- | :---------------------------:|:------------------:|
| 		kube-proxy      |  [k8s.gcr.io/debian-iptable](https://github.com/kubernetes/kubernetes/blob/1b9d0c1094d31f851a5ec6e277fbf0b7382196cf/build/common.sh#L101)   | Requires iptable  |
|etcd-empty-dir-cleanup | debian-base | Requires shell to do cleanup |
|etcd | debian-base | Requires shell to do migration|
|node-problem-detector| debian-base | Requires libsystemd0 |
