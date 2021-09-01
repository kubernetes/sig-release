## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Kubeadm: remove the deprecated flag `--experimental-patches` for the `init|join|upgrade` commands. The flag `--patches` is no longer allowed in a mixture with the flag `--config`. Please use the kubeadm configuration for setting patches for a node using `{Init|Join}Configuration.patches`. ([#104065](https://github.com/kubernetes/kubernetes/pull/104065), [@pacoxu](https://github.com/pacoxu))
 - Support for the seccomp annotations `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io/[name]` has been deprecated since 1.19, will be dropped in 1.25. Transition to using the `seccompProfile` API field. ([#104389](https://github.com/kubernetes/kubernetes/pull/104389), [@saschagrunert](https://github.com/saschagrunert))
 
## Changes by Kind

### Deprecation

- Added `apiserver_longrunning_requests` metric to replace the soon to be deprecated `apiserver_longrunning_gauge` metric. ([#103799](https://github.com/kubernetes/kubernetes/pull/103799), [@jyz0309](https://github.com/jyz0309))
- Kubeadm: remove the `--port` flag from the manifest for the `kube-controller-manager` since the flag has been a NO-OP since 1.22 and insecure serving was removed for the component. ([#104157](https://github.com/kubernetes/kubernetes/pull/104157), [@knight42](https://github.com/knight42))

### API Change

- Kube-apiserver: The `rbac.authorization.k8s.io/v1alpha1` API version is removed; use the `rbac.authorization.k8s.io/v1` API, available since v1.8. The `scheduling.k8s.io/v1alpha1` API version is removed; use the `scheduling.k8s.io/v1` API, available since v1.14. ([#104248](https://github.com/kubernetes/kubernetes/pull/104248), [@liggitt](https://github.com/liggitt))
- The `CSIDriver.Spec.StorageCapacity` can now be modified. ([#101789](https://github.com/kubernetes/kubernetes/pull/101789), [@pohly](https://github.com/pohly))
- The `kube-controller-manager` supports `--concurrent-ephemeralvolume-syncs` flag to set the number of ephemeral volume controller workers. ([#102981](https://github.com/kubernetes/kubernetes/pull/102981), [@SataQiu](https://github.com/SataQiu))

### Feature

- Adding support for multiple `--from-env-file` flags. ([#101646](https://github.com/kubernetes/kubernetes/pull/101646), [@lauchokyip](https://github.com/lauchokyip))
- Allow node expansion of local volumes. ([#102886](https://github.com/kubernetes/kubernetes/pull/102886), [@gnufied](https://github.com/gnufied))
- Allow to build kubernetes with a custom `kube-cross` image. ([#104185](https://github.com/kubernetes/kubernetes/pull/104185), [@dims](https://github.com/dims))
- Display Labels when kubectl describe ingress. ([#103894](https://github.com/kubernetes/kubernetes/pull/103894), [@kabab](https://github.com/kabab))
- Expose a `NewUnstructuredExtractor` from apply configurations `meta/v1` package that enables extracting objects into unstructured apply configurations. ([#103564](https://github.com/kubernetes/kubernetes/pull/103564), [@kevindelgado](https://github.com/kevindelgado))
- Introduce a feature gate `DisableKubeletCloudCredentialProviders` which allows disabling the in-tree kubelet credential providers.
  
  The feature gate `DisableKubeletCloudCredentialProviders` is currently in Alpha, which means is currently disabled by default. Once this feature gate moves to beta, in-tree credential providers will be disabled by default, and users will need to migrate to use external credential providers. ([#102507](https://github.com/kubernetes/kubernetes/pull/102507), [@ostrain](https://github.com/ostrain))
- Introduces a new metric: `admission_webhook_request_total` with the following labels: name (string) - the webhook name, type (string) - the admission type, operation (string) - the requested verb, code (int) - the HTTP status code, rejected (bool) - whether the request was rejected, namespace (string) - the namespace of the requested resource. ([#103162](https://github.com/kubernetes/kubernetes/pull/103162), [@rmoriar1](https://github.com/rmoriar1))
- Kubeadm: add support for dry running `kubeadm join`. The new flag `kubeadm join --dry-run` is similar to the existing flag for `kubeadm init/upgrade` and allows you to see what changes would be applied. ([#103027](https://github.com/kubernetes/kubernetes/pull/103027), [@Haleygo](https://github.com/Haleygo))
- Kubernetes is now built with Golang 1.16.7. ([#104199](https://github.com/kubernetes/kubernetes/pull/104199), [@cpanato](https://github.com/cpanato))
- The `ServiceAccountIssuerDiscovery` feature gate is removed. It reached GA in Kubernetes 1.21. ([#103685](https://github.com/kubernetes/kubernetes/pull/103685), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The `constants/variables` from k8s.io for STABLE metrics is now supported. ([#103654](https://github.com/kubernetes/kubernetes/pull/103654), [@coffeepac](https://github.com/coffeepac))
- The script `kube-up.sh` installs `csi-proxy v1.0.1-gke.0`. ([#104426](https://github.com/kubernetes/kubernetes/pull/104426), [@mauriciopoppe](https://github.com/mauriciopoppe))
- Updated Cluster Autosaler to version `1.22.0`. Release notes: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.22.0. ([#104293](https://github.com/kubernetes/kubernetes/pull/104293), [@x13n](https://github.com/x13n))
- Updates the following images to pick up CVE fixes:
  - `debian` to v1.9.0
  - `debian-iptables` to v1.6.6
  - `setcap` to v2.0.4 ([#104142](https://github.com/kubernetes/kubernetes/pull/104142), [@mengjiao-liu](https://github.com/mengjiao-liu))
- `client-go` event library allows customizing spam filtering function. 
  It is now possible to override `SpamKeyFunc`, which is used by event filtering to detect spam in the events. ([#103918](https://github.com/kubernetes/kubernetes/pull/103918), [@olagacek](https://github.com/olagacek))

### Documentation

- Update description of `--audit-log-maxbackup` to describe behavior when `value = 0`. ([#103843](https://github.com/kubernetes/kubernetes/pull/103843), [@Arkessler](https://github.com/Arkessler))

### Bug or Regression

- Add Kubernetes Events to the `Kubelet Graceful Shutdown` feature. ([#101081](https://github.com/kubernetes/kubernetes/pull/101081), [@rphillips](https://github.com/rphillips))
- CA, certificate and key bundles for the `generic-apiserver` based servers will be reloaded immediately after the files are changed. ([#104102](https://github.com/kubernetes/kubernetes/pull/104102), [@tnqn](https://github.com/tnqn))
- Disable aufs module for gce clusters. ([#103831](https://github.com/kubernetes/kubernetes/pull/103831), [@lizhuqi](https://github.com/lizhuqi))
- Fix `kube-apiserver` metric reporting for the deprecated watch path of `/api/<version>/watch/...`. ([#104161](https://github.com/kubernetes/kubernetes/pull/104161), [@wojtek-t](https://github.com/wojtek-t))
- Fix: Provide IPv6 support for internal load balancer. ([#103794](https://github.com/kubernetes/kubernetes/pull/103794), [@nilo19](https://github.com/nilo19))
- Fix: ignore non-VMSS error for VMAS nodes in `reconcileBackendPools`. ([#103997](https://github.com/kubernetes/kubernetes/pull/103997), [@nilo19](https://github.com/nilo19))
- Fix: skip case sensitivity when checking Azure NSG rules. ([#104384](https://github.com/kubernetes/kubernetes/pull/104384), [@feiskyer](https://github.com/feiskyer))
- Fixed a bug which kubectl would emit duplicate warning messages for flag names that contain an underscore and recommend using a nonexistent flag in some cases. ([#103852](https://github.com/kubernetes/kubernetes/pull/103852), [@brianpursley](https://github.com/brianpursley))
- Fixed a regression setting `--audit-log-path=-` to log to stdout in 1.22 pre-release. ([#103875](https://github.com/kubernetes/kubernetes/pull/103875), [@andrewrynhard](https://github.com/andrewrynhard))
- Fixed an issue which didn't append OS's environment variables with the one provided in Credential Provider Config file, which may fail execution of external credential provider binary. 
  See https://github.com/kubernetes/kubernetes/issues/102750 ([#103231](https://github.com/kubernetes/kubernetes/pull/103231), [@n4j](https://github.com/n4j))
- Fixed architecture within manifest for non `amd64` etcd images. ([#104116](https://github.com/kubernetes/kubernetes/pull/104116), [@saschagrunert](https://github.com/saschagrunert))
- Fixed azure disk translation issue due to lower case `managed` kind. ([#103439](https://github.com/kubernetes/kubernetes/pull/103439), [@andyzhangx](https://github.com/andyzhangx))
- Graceful node shutdown, allow the actual inhibit delay to be greater than the expected inhibit delay. ([#103137](https://github.com/kubernetes/kubernetes/pull/103137), [@wzshiming](https://github.com/wzshiming))
- Introduce a new server run option 'shutdown-send-retry-after'. If true the HTTP Server will continue listening until all non longrunning request(s) in flight have been drained, during this window all incoming requests will be rejected with a status code `429` and a 'Retry-After' response header. ([#101257](https://github.com/kubernetes/kubernetes/pull/101257), [@tkashem](https://github.com/tkashem))
- Kube-apiserver: Avoid unnecessary repeated calls to `admission webhooks` that reject an update or delete request. ([#104182](https://github.com/kubernetes/kubernetes/pull/104182), [@liggitt](https://github.com/liggitt))
- Kube-proxy: delete stale conntrack UDP entries for loadbalancer ingress IP. ([#104009](https://github.com/kubernetes/kubernetes/pull/104009), [@aojea](https://github.com/aojea))
- Kubeadm: When adding an etcd peer to an existing cluster, if an error is returned indicating the peer has already been added, this is accepted and a `ListMembers` call is used instead to return the existing cluster. This helps to diminish the exponential backoff when the first AddMember call times out, while still retaining a similar performance when the peer has already been added from a previous call. ([#104134](https://github.com/kubernetes/kubernetes/pull/104134), [@ihgann](https://github.com/ihgann))
- Pass additional flags to subpath mount to avoid flakes in certain conditions. ([#104253](https://github.com/kubernetes/kubernetes/pull/104253), [@mauriciopoppe](https://github.com/mauriciopoppe))
- Reverts adding namespace label to admission metrics (and histogram exansion) due to cardinality issues. ([#104033](https://github.com/kubernetes/kubernetes/pull/104033), [@s-urbaniak](https://github.com/s-urbaniak))
- Update Go used to build migrate script in etcd image to v1.16.7. ([#104301](https://github.com/kubernetes/kubernetes/pull/104301), [@serathius](https://github.com/serathius))
- Updated json representation for a conflicted taint to `Key=Effect` when a conflicted taint occurs in kubectl taint. ([#104011](https://github.com/kubernetes/kubernetes/pull/104011), [@manugupt1](https://github.com/manugupt1))

### Other (Cleanup or Flake)

- Deprecate `apiserver_longrunning_gauge` and `apiserver_register_watchers` in 1.23.0. ([#103793](https://github.com/kubernetes/kubernetes/pull/103793), [@yan-lgtm](https://github.com/yan-lgtm))
- Fix an issue in cleaning up `CertificateSigningRequest` objects with an unparseable `status.certificate` field. ([#103823](https://github.com/kubernetes/kubernetes/pull/103823), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: sets an upper-bound on the lifetime of idle keep-alive connections and time to read the headers of incoming requests. ([#103958](https://github.com/kubernetes/kubernetes/pull/103958), [@liggitt](https://github.com/liggitt))
- Kubeadm: external etcd endpoints passed in the `ClusterConfiguration` that have Unicode characters are no longer IDNA encoded (converted to Punycode). They are now just URL encoded as per Go's implementation of RFC-3986, have duplicate "/" removed from the URL paths, and passed like that directly to the `kube-apiserver` `--etcd-servers` flag. If you have etcd endpoints that have Unicode characters, it is advisable to encode them in advance with tooling that is fully IDNA compliant. If you don't do that, the Go standard library (used in k8s and etcd) would do it for you when making requests to the endpoints. ([#103801](https://github.com/kubernetes/kubernetes/pull/103801), [@gkarthiks](https://github.com/gkarthiks))
- Kubeadm: update references to legacy artifacts locations, the `ci-cross` prefix has been removed from the version match as it does not exist in the new `gs://k8s-release-dev` bucket. ([#103813](https://github.com/kubernetes/kubernetes/pull/103813), [@SataQiu](https://github.com/SataQiu))
- Surface warning when users don't set `propagationPolicy` for jobs while deleting. ([#104080](https://github.com/kubernetes/kubernetes/pull/104080), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- The `AllowInsecureBackendProxy` feature gate is removed. It reached GA in Kubernetes 1.21. ([#103796](https://github.com/kubernetes/kubernetes/pull/103796), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The `StartupProbe` feature gate that is GA since v1.20 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104168](https://github.com/kubernetes/kubernetes/pull/104168), [@ialidzhikov](https://github.com/ialidzhikov))
- The `apiserver` exposes 4 new metrics that allow to track the status of the Service CIDRs allocations:
      - current number of available IPs per Service CIDR
      - current number of used IPs per Service CIDR
      - total number of allocation per Service CIDR
      - total number of allocation errors per ServiceCIDR ([#104119](https://github.com/kubernetes/kubernetes/pull/104119), [@aojea](https://github.com/aojea))
- The flag `--deployment-controller-sync-period` has been deprecated and will be removed in v1.24. ([#103538](https://github.com/kubernetes/kubernetes/pull/103538), [@Pingan2017](https://github.com/Pingan2017))
- The image `gcr.io/kubernetes-e2e-test-images` will no longer be used in E2E / CI testing, `k8s.gcr.io/e2e-test-images` will be used instead. ([#103724](https://github.com/kubernetes/kubernetes/pull/103724), [@claudiubelu](https://github.com/claudiubelu))
- Troubleshooting: informers log handlers that take more than 100 milliseconds to process an object if the `DeltaFIFO` queue starts to grow beyond 10 elements. ([#103917](https://github.com/kubernetes/kubernetes/pull/103917), [@aojea](https://github.com/aojea))
- Update `cri-tools` dependency to v1.22.0. ([#104430](https://github.com/kubernetes/kubernetes/pull/104430), [@saschagrunert](https://github.com/saschagrunert))
- Update `migratecmd/kube-proxy/app` logs to structured logging. ([#98913](https://github.com/kubernetes/kubernetes/pull/98913), [@yxxhero](https://github.com/yxxhero))

## Dependencies

### Added
- github.com/google/martian/v3: [v3.1.0](https://github.com/google/martian/v3/tree/v3.1.0)
- github.com/willf/bitset: [v1.1.11](https://github.com/willf/bitset/tree/v1.1.11)

### Changed
- cloud.google.com/go/bigquery: v1.4.0 → v1.8.0
- cloud.google.com/go/storage: v1.6.0 → v1.10.0
- cloud.google.com/go: v0.54.0 → v0.81.0
- github.com/cilium/ebpf: [v0.6.2 → v0.5.0](https://github.com/cilium/ebpf/compare/v0.6.2...v0.5.0)
- github.com/GoogleCloudPlatform/k8s-cloud-provider: [7901bc8 → ea6160c](https://github.com/GoogleCloudPlatform/k8s-cloud-provider/compare/7901bc8...ea6160c)
- github.com/golang/mock: [v1.4.4 → v1.5.0](https://github.com/golang/mock/compare/v1.4.4...v1.5.0)
- github.com/google/pprof: [1ebb73c → cbba55b](https://github.com/google/pprof/compare/1ebb73c...cbba55b)
- github.com/hashicorp/golang-lru: [v0.5.1 → v0.5.0](https://github.com/hashicorp/golang-lru/compare/v0.5.1...v0.5.0)
- github.com/ianlancetaylor/demangle: [5e5cf60 → 28f6c0f](https://github.com/ianlancetaylor/demangle/compare/5e5cf60...28f6c0f)
- github.com/opencontainers/runc: [v1.0.1 → v1.0.0-rc95](https://github.com/opencontainers/runc/compare/v1.0.1...v1.0.0-rc95)
- github.com/opencontainers/selinux: [v1.8.2 → v1.8.0](https://github.com/opencontainers/selinux/compare/v1.8.2...v1.8.0)
- github.com/prometheus/common: [v0.26.0 → v0.28.0](https://github.com/prometheus/common/compare/v0.26.0...v0.28.0)
- github.com/sirupsen/logrus: [v1.8.1 → v1.7.0](https://github.com/sirupsen/logrus/compare/v1.8.1...v1.7.0)
- go.opencensus.io: v0.22.3 → v0.23.0
- golang.org/x/net: 37e1c6a → abc4532
- golang.org/x/oauth2: bf48bf1 → f6687ab
- golang.org/x/time: 1f47c86 → f8bda1e
- google.golang.org/api: v0.20.0 → v0.46.0
- google.golang.org/appengine: v1.6.5 → v1.6.7
- honnef.co/go/tools: v0.0.1-2020.1.3 → v0.0.1-2020.1.4
- k8s.io/gengo: b6c5ce2 → 485abfe
- k8s.io/kube-openapi: 9528897 → 7fbd8d5
- k8s.io/utils: 4b05e18 → efc7438
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.22 → v0.0.21

### Removed
- cloud.google.com/go/datastore: v1.1.0
- cloud.google.com/go/pubsub: v1.2.0
- github.com/alecthomas/units: [f65c72e](https://github.com/alecthomas/units/tree/f65c72e)
- github.com/bits-and-blooms/bitset: [v1.2.0](https://github.com/bits-and-blooms/bitset/tree/v1.2.0)
- github.com/google/martian: [v2.1.0+incompatible](https://github.com/google/martian/tree/v2.1.0)
- github.com/jpillora/backoff: [v1.0.0](https://github.com/jpillora/backoff/tree/v1.0.0)
