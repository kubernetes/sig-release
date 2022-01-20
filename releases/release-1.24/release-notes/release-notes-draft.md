## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Docker runtime support using dockshim in the kubelet is now completely removed in 1.24. The kubelet used to have a a module called "dockershim" which implements CRI support for Docker and it has seen maintenance issues in the Kubernetes community. From 1.24 onwards, please move to a container runtime that is a full-fledged implementation of CRI (v1alpha1 or v1 compliant) as they become available. ([#97252](https://github.com/kubernetes/kubernetes/pull/97252), [@dims](https://github.com/dims)) [SIG Cloud Provider, Instrumentation, Network, Node and Testing]
 
## Changes by Kind

### Feature

- Kubernetes is now built with Golang 1.17.4 ([#106833](https://github.com/kubernetes/kubernetes/pull/106833), [@cpanato](https://github.com/cpanato))
- The `NamespaceDefaultLabelName` feature gate, GA since v1.22, is now removed. ([#106838](https://github.com/kubernetes/kubernetes/pull/106838), [@mengjiao-liu](https://github.com/mengjiao-liu))

### Bug or Regression

- Fix bug in error messaging for basic-auth and ssh secret validations. ([#106179](https://github.com/kubernetes/kubernetes/pull/106179), [@vivek-koppuru](https://github.com/vivek-koppuru))
- Kube-apiserver: Server Side Apply merge order is reverted to match v1.22 behavior until http://issue.k8s.io/104641 is resolved. ([#106660](https://github.com/kubernetes/kubernetes/pull/106660), [@liggitt](https://github.com/liggitt))
- Kubeadm: allow the "certs check-expiration" command to not require the existence of the cluster CA key (ca.key file) when checking the expiration of managed certificates in kubeconfig files. ([#106854](https://github.com/kubernetes/kubernetes/pull/106854), [@neolit123](https://github.com/neolit123))
- Publishing kube-proxy metrics for Windows kernel-mode ([#106581](https://github.com/kubernetes/kubernetes/pull/106581), [@knabben](https://github.com/knabben))
- Reverts the CRI API version surfaced by dockershim to v1alpha2 ([#106803](https://github.com/kubernetes/kubernetes/pull/106803), [@saschagrunert](https://github.com/saschagrunert)) [SIG Network and Node]
- The deprecated flag `--really-crash-for-testing` has been removed. ([#101719](https://github.com/kubernetes/kubernetes/pull/101719), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- [Metrics Server] Bump image to v0.5.2 ([#106492](https://github.com/kubernetes/kubernetes/pull/106492), [@serathius](https://github.com/serathius))

### Other (Cleanup or Flake)

- Added an example for the kubectl plugin list command. ([#106600](https://github.com/kubernetes/kubernetes/pull/106600), [@bergerhoffer](https://github.com/bergerhoffer))
- Kubelet config validation error messages are updated ([#105360](https://github.com/kubernetes/kubernetes/pull/105360), [@shuheiktgw](https://github.com/shuheiktgw))