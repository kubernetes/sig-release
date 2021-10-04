## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Kubeadm: remove the deprecated flag `--experimental-patches` for the `init|join|upgrade` commands. The flag `--patches` is no longer allowed in a mixture with the flag `--config`. Please use the kubeadm configuration for setting patches for a node using `{Init|Join}Configuration.patches`. ([#104065](https://github.com/kubernetes/kubernetes/pull/104065), [@pacoxu](https://github.com/pacoxu))
 - Support for the seccomp annotations `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io/[name]` has been deprecated since 1.19, will be dropped in 1.25. Transition to using the `seccompProfile` API field. ([#104389](https://github.com/kubernetes/kubernetes/pull/104389), [@saschagrunert](https://github.com/saschagrunert))
 
## Changes by Kind

### Deprecation

- Added `apiserver_longrunning_requests` metric to replace the soon to be deprecated `apiserver_longrunning_gauge` metric. ([#103799](https://github.com/kubernetes/kubernetes/pull/103799), [@jyz0309](https://github.com/jyz0309))
- Controller-manager: the following flags have no effect and would be removed in v1.24:
  - `--port`
  - `--address`
  The insecure port flags `--port` may only be set to 0 now.
  Also `metricsBindAddress` and `healthzBindAddress` fields from `kubescheduler.config.k8s.io/v1beta1` are no-op and expected to be empty. Removed in `kubescheduler.config.k8s.io/v1beta2` completely. ([#96345](https://github.com/kubernetes/kubernetes/pull/96345), [@ingvagabund](https://github.com/ingvagabund))
- Kubeadm: remove the `--port` flag from the manifest for the `kube-controller-manager` since the flag has been a NO-OP since 1.22 and insecure serving was removed for the component. ([#104157](https://github.com/kubernetes/kubernetes/pull/104157), [@knight42](https://github.com/knight42))
- Remove 'master' as a valid EgressSelection type in the EgressSelectorConfiguration API. ([#102242](https://github.com/kubernetes/kubernetes/pull/102242), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery and Cloud Provider]
- Remove VolumeSubpath feature gate ([#105090](https://github.com/kubernetes/kubernetes/pull/105090), [@saad-ali](https://github.com/saad-ali)) [SIG Apps, Node and Storage]
- Removed deprecated metric `scheduler_volume_scheduling_duration_seconds`. ([#104518](https://github.com/kubernetes/kubernetes/pull/104518), [@dntosas](https://github.com/dntosas))
- The deprecated --experimental-bootstrap-kubeconfig flag has been removed.
  This can be set via --bootstrap-kubeconfig. ([#103172](https://github.com/kubernetes/kubernetes/pull/103172), [@niulechuan](https://github.com/niulechuan)) [SIG Node]

### API Change

- A small regression in Service updates was fixed.  The circumstances are so unlikely that probably nobody would ever hit it. ([#104601](https://github.com/kubernetes/kubernetes/pull/104601), [@thockin](https://github.com/thockin))
- Client-go impersonation config can specify a UID to pass impersonated uid information through in requests. ([#104483](https://github.com/kubernetes/kubernetes/pull/104483), [@margocrawf](https://github.com/margocrawf))
- IPv6DualStack feature moved to stable.
  Controller Manager flags for the node IPAM controller have slightly changed:
  1. When configuring a dual-stack cluster, the user must specify both --node-cidr-mask-size-ipv4 and --node-cidr-mask-size-ipv6 to set the per-node IP mask sizes, instead of the previous --node-cidr-mask-size flag.
  2. The --node-cidr-mask-size flag is mutually exclusive with --node-cidr-mask-size-ipv4 and --node-cidr-mask-size-ipv6.
  3. Single-stack clusters do not need to change, but may choose to use the more specific flags.  Users can use either the older --node-cidr-mask-size flag or one of the newer --node-cidr-mask-size-ipv4 or --node-cidr-mask-size-ipv6 flags to configure the per-node IP mask size, provided that the flag's IP family matches the cluster's IP family (--cluster-cidr). ([#104691](https://github.com/kubernetes/kubernetes/pull/104691), [@khenidak](https://github.com/khenidak)) [SIG API Machinery, Apps, Auth, Cloud Provider, Cluster Lifecycle, Network, Node and Testing]
- If a conflict occurs when creating an object with generateName, the server now returns an "AlreadyExists" error with a retry option. ([#104699](https://github.com/kubernetes/kubernetes/pull/104699), [@vincepri](https://github.com/vincepri))
- Introduce v1beta2 for Priority and Fairness with no changes in API spec. ([#104399](https://github.com/kubernetes/kubernetes/pull/104399), [@tkashem](https://github.com/tkashem))
- Kube-apiserver: Fixes handling of CRD schemas containing literal null values in enums. ([#104969](https://github.com/kubernetes/kubernetes/pull/104969), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: The `rbac.authorization.k8s.io/v1alpha1` API version is removed; use the `rbac.authorization.k8s.io/v1` API, available since v1.8. The `scheduling.k8s.io/v1alpha1` API version is removed; use the `scheduling.k8s.io/v1` API, available since v1.14. ([#104248](https://github.com/kubernetes/kubernetes/pull/104248), [@liggitt](https://github.com/liggitt))
- Kubelet: turn the KubeletConfiguration v1beta1 `ResolverConfig` field from a `string` to `*string`. ([#104624](https://github.com/kubernetes/kubernetes/pull/104624), [@Haleygo](https://github.com/Haleygo)) [SIG Cluster Lifecycle and Node]
- Kubernetes is now built using go 1.17. ([#103692](https://github.com/kubernetes/kubernetes/pull/103692), [@justaugustus](https://github.com/justaugustus))
- Removed deprecated `--seccomp-profile-root`/`seccompProfileRoot` config. ([#103941](https://github.com/kubernetes/kubernetes/pull/103941), [@saschagrunert](https://github.com/saschagrunert))
- Since golang 1.17 both net.ParseIP and net.ParseCIDR rejects leading zeros in the dot-decimal notation of IPv4 addresses,
  Kubernetes will keep allowing leading zeros on IPv4 address to not break the compatibility.
  IMPORTANT: Kubernetes interprets leading zeros on IPv4 addresses as decimal, users must not rely on parser alignment to not being impacted by the associated security advisory:
  CVE-2021-29923 golang standard library "net" - Improper Input Validation of octal literals in golang 1.16.2 and below standard library "net" results in indeterminate SSRF & RFI vulnerabilities.
  Reference: https://nvd.nist.gov/vuln/detail/CVE-2021-29923 ([#104368](https://github.com/kubernetes/kubernetes/pull/104368), [@aojea](https://github.com/aojea))
- StatefulSet `minReadySeconds` is promoted to beta. ([#104045](https://github.com/kubernetes/kubernetes/pull/104045), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- The `CSIDriver.Spec.StorageCapacity` can now be modified. ([#101789](https://github.com/kubernetes/kubernetes/pull/101789), [@pohly](https://github.com/pohly))
- The `Service.spec.ipFamilyPolicy` field is now *required* in order to create or update a Service as dual-stack.  This is a breaking change from the beta behavior.  Previously the server would try to infer the value of that field from either `ipFamilies` or `clusterIPs`, but that caused ambiguity on updates.  Users who want a dual-stack Service MUST specify `ipFamilyPolicy` as either "PreferDualStack" or "RequireDualStack". ([#96684](https://github.com/kubernetes/kubernetes/pull/96684), [@thockin](https://github.com/thockin))
- The `kube-controller-manager` supports `--concurrent-ephemeralvolume-syncs` flag to set the number of ephemeral volume controller workers. ([#102981](https://github.com/kubernetes/kubernetes/pull/102981), [@SataQiu](https://github.com/SataQiu))
- Users of `LogFormatRegistry` in component-base must update their code to use the logr v1.0.0 API. The JSON log output now uses the format from go-logr/zapr (no `v` field for error messages, additional information for invalid calls) and has some fixes (correct source code location for warnings about invalid log calls). ([#104103](https://github.com/kubernetes/kubernetes/pull/104103), [@pohly](https://github.com/pohly))

### Feature

- Add fish shell completion to kubectl. ([#92989](https://github.com/kubernetes/kubernetes/pull/92989), [@WLun001](https://github.com/WLun001))
- Add mechanism to load simple sniffer class into fluentd-elasticsearch image ([#92853](https://github.com/kubernetes/kubernetes/pull/92853), [@cosmo0920](https://github.com/cosmo0920)) [SIG Cloud Provider and Instrumentation]
- Added PowerShell completion generation by running `kubectl completion powershell`. ([#103758](https://github.com/kubernetes/kubernetes/pull/103758), [@zikhan](https://github.com/zikhan))
- Added a `Processing` condition for the `workqueue` API.
  Changed `Shutdown` for the workqueue API to wait until the work queue finishes processing all in-flight items. ([#101928](https://github.com/kubernetes/kubernetes/pull/101928), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Added a new flag `--append-server-path` to `kubectl proxy` that will automatically append the kube context server path to each request. ([#97350](https://github.com/kubernetes/kubernetes/pull/97350), [@FabianKramm](https://github.com/FabianKramm))
- Added support for setting controller-manager log level online. ([#104571](https://github.com/kubernetes/kubernetes/pull/104571), [@h4ghhh](https://github.com/h4ghhh))
- Adding support for multiple `--from-env-file flags`. ([#104232](https://github.com/kubernetes/kubernetes/pull/104232), [@lauchokyip](https://github.com/lauchokyip))
- Adding support for multiple `--from-env-file` flags. ([#101646](https://github.com/kubernetes/kubernetes/pull/101646), [@lauchokyip](https://github.com/lauchokyip))
- Allow node expansion of local volumes. ([#102886](https://github.com/kubernetes/kubernetes/pull/102886), [@gnufied](https://github.com/gnufied))
- Allow to build kubernetes with a custom `kube-cross` image. ([#104185](https://github.com/kubernetes/kubernetes/pull/104185), [@dims](https://github.com/dims))
- Cloud providers can set service account names for cloud controllers. ([#103178](https://github.com/kubernetes/kubernetes/pull/103178), [@nckturner](https://github.com/nckturner))
- Display Labels when kubectl describe ingress. ([#103894](https://github.com/kubernetes/kubernetes/pull/103894), [@kabab](https://github.com/kabab))
- Expose a `NewUnstructuredExtractor` from apply configurations `meta/v1` package that enables extracting objects into unstructured apply configurations. ([#103564](https://github.com/kubernetes/kubernetes/pull/103564), [@kevindelgado](https://github.com/kevindelgado))
- Health check of kube-controller-manager now includes each controller. ([#104667](https://github.com/kubernetes/kubernetes/pull/104667), [@jiahuif](https://github.com/jiahuif))
- Introduce a feature gate `DisableKubeletCloudCredentialProviders` which allows disabling the in-tree kubelet credential providers.
  
  The feature gate `DisableKubeletCloudCredentialProviders` is currently in Alpha, which means is currently disabled by default. Once this feature gate moves to beta, in-tree credential providers will be disabled by default, and users will need to migrate to use external credential providers. ([#102507](https://github.com/kubernetes/kubernetes/pull/102507), [@ostrain](https://github.com/ostrain))
- Introduces a new metric: `admission_webhook_request_total` with the following labels: name (string) - the webhook name, type (string) - the admission type, operation (string) - the requested verb, code (int) - the HTTP status code, rejected (bool) - whether the request was rejected, namespace (string) - the namespace of the requested resource. ([#103162](https://github.com/kubernetes/kubernetes/pull/103162), [@rmoriar1](https://github.com/rmoriar1))
- Kubeadm: add support for dry running `kubeadm join`. The new flag `kubeadm join --dry-run` is similar to the existing flag for `kubeadm init/upgrade` and allows you to see what changes would be applied. ([#103027](https://github.com/kubernetes/kubernetes/pull/103027), [@Haleygo](https://github.com/Haleygo))
- Kubeadm: do not check if the '/etc/kubernetes/manifests' folder is empty on joining worker nodes during preflight ([#104942](https://github.com/kubernetes/kubernetes/pull/104942), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubernetes is now built with Golang 1.16.7. ([#104199](https://github.com/kubernetes/kubernetes/pull/104199), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Golang 1.17.1. ([#104904](https://github.com/kubernetes/kubernetes/pull/104904), [@cpanato](https://github.com/cpanato))
- The `ServiceAccountIssuerDiscovery` feature gate is removed. It reached GA in Kubernetes 1.21. ([#103685](https://github.com/kubernetes/kubernetes/pull/103685), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The `constants/variables` from k8s.io for STABLE metrics is now supported. ([#103654](https://github.com/kubernetes/kubernetes/pull/103654), [@coffeepac](https://github.com/coffeepac))
- The kube-apiserver's Prometheus metrics have been extended with some that describe the costs of handling LIST requests.  They are as follows.
  - *apiserver_cache_list_total*: Counter of LIST requests served from watch cache, broken down by resource_prefix and index_name
  - *apiserver_cache_list_fetched_objects_total*: Counter of objects read from watch cache in the course of serving a LIST request, broken down by resource_prefix and index_name
  - *apiserver_cache_list_evaluated_objects_total*: Counter of objects tested in the course of serving a LIST request from watch cache, broken down by resource_prefix
  - *apiserver_cache_list_returned_objects_total*: Counter of objects returned for a LIST request from watch cache, broken down by resource_prefix
  - *apiserver_storage_list_total*: Counter of LIST requests served from etcd, broken down by resource
  - *apiserver_storage_list_fetched_objects_total*: Counter of objects read from etcd in the course of serving a LIST request, broken down by resource
  - *apiserver_storage_list_evaluated_objects_total*: Counter of objects tested in the course of serving a LIST request from etcd, broken down by resource
  - *apiserver_storage_list_returned_objects_total*: Counter of objects returned for a LIST request from etcd, broken down by resource ([#104983](https://github.com/kubernetes/kubernetes/pull/104983), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery and Instrumentation]
- The pause image list now contains Windows Server 2022. ([#104438](https://github.com/kubernetes/kubernetes/pull/104438), [@nick5616](https://github.com/nick5616))
- The script `kube-up.sh` installs `csi-proxy v1.0.1-gke.0`. ([#104426](https://github.com/kubernetes/kubernetes/pull/104426), [@mauriciopoppe](https://github.com/mauriciopoppe))
- Turn on CSIMigrationAzureDisk by default on 1.23 ([#104670](https://github.com/kubernetes/kubernetes/pull/104670), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Updated Cluster Autosaler to version `1.22.0`. Release notes: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.22.0. ([#104293](https://github.com/kubernetes/kubernetes/pull/104293), [@x13n](https://github.com/x13n))
- Updates `debian-iptables` to v1.6.7 to pick up CVE fixes. ([#104970](https://github.com/kubernetes/kubernetes/pull/104970), [@PushkarJ](https://github.com/PushkarJ))
- Updates the following images to pick up CVE fixes:
  - `debian` to v1.9.0
  - `debian-iptables` to v1.6.6
  - `setcap` to v2.0.4 ([#104142](https://github.com/kubernetes/kubernetes/pull/104142), [@mengjiao-liu](https://github.com/mengjiao-liu))
- `client-go` event library allows customizing spam filtering function. 
  It is now possible to override `SpamKeyFunc`, which is used by event filtering to detect spam in the events. ([#103918](https://github.com/kubernetes/kubernetes/pull/103918), [@olagacek](https://github.com/olagacek))
- `kube-scheduler` now logs node and plugin scoring  even though --v<10
  - scores of the top 3 plugins in the top 3 nodes are dumped if --v=4,5
  - scores of all plugins in the top 6 nodes are dumped if --v=6,7,8,9 ([#103515](https://github.com/kubernetes/kubernetes/pull/103515), [@muma378](https://github.com/muma378))

### Documentation

- The test "[sig-network] EndpointSlice should have Endpoints and EndpointSlices pointing to API Server [Conformance]" only requires that there is an EndpointSlice that references the "kubernetes.default" service, it no longer requires that its named "kubernetes". ([#104664](https://github.com/kubernetes/kubernetes/pull/104664), [@aojea](https://github.com/aojea))
- Update description of `--audit-log-maxbackup` to describe behavior when `value = 0`. ([#103843](https://github.com/kubernetes/kubernetes/pull/103843), [@Arkessler](https://github.com/Arkessler))

### Bug or Regression

- A pod that the Kubelet rejects was still considered as being accepted for a brief period of time after rejection, which might cause some pods to be rejected briefly that could fit on the node.  A pod that is still terminating (but has status indicating it has failed) may also still be consuming resources and so should also be considered. ([#104817](https://github.com/kubernetes/kubernetes/pull/104817), [@smarterclayton](https://github.com/smarterclayton))
- Add Kubernetes Events to the `Kubelet Graceful Shutdown` feature. ([#101081](https://github.com/kubernetes/kubernetes/pull/101081), [@rphillips](https://github.com/rphillips))
- CA, certificate and key bundles for the `generic-apiserver` based servers will be reloaded immediately after the files are changed. ([#104102](https://github.com/kubernetes/kubernetes/pull/104102), [@tnqn](https://github.com/tnqn))
- Changed kubectl describe to compute age of an event using the `EventSeries.count` and `EventSeries.lastObservedTime`. ([#104482](https://github.com/kubernetes/kubernetes/pull/104482), [@harjas27](https://github.com/harjas27))
- Changes behaviour of kube-proxy start; does not attempt to set specific sysctl values (which does not work in recent Kernel versions anymore in non-init namespaces), when the current sysctl values are already set higher. ([#103174](https://github.com/kubernetes/kubernetes/pull/103174), [@Napsty](https://github.com/Napsty)) [SIG Network]
- Disable aufs module for gce clusters. ([#103831](https://github.com/kubernetes/kubernetes/pull/103831), [@lizhuqi](https://github.com/lizhuqi))
- Don't prematurely close reflectors in case of slow initialization in watch based manager to fix issues with inability to properly mount secrets/configmaps. ([#104604](https://github.com/kubernetes/kubernetes/pull/104604), [@wojtek-t](https://github.com/wojtek-t))
- Ensure `InstanceShutdownByProviderID` return false for creating Azure VMs. ([#104382](https://github.com/kubernetes/kubernetes/pull/104382), [@feiskyer](https://github.com/feiskyer))
- Fix `kube-apiserver` metric reporting for the deprecated watch path of `/api/<version>/watch/...`. ([#104161](https://github.com/kubernetes/kubernetes/pull/104161), [@wojtek-t](https://github.com/wojtek-t))
- Fix a regression where the Kubelet failed to exclude already completed pods from calculations about how many resources it was currently using when deciding whether to allow more pods. ([#104577](https://github.com/kubernetes/kubernetes/pull/104577), [@smarterclayton](https://github.com/smarterclayton))
- Fix detach disk issue on deleting vmss node. ([#104572](https://github.com/kubernetes/kubernetes/pull/104572), [@andyzhangx](https://github.com/andyzhangx))
- Fix job controller syncs: In case of conflicts, ensure that the sync happens with the most up to date information. Improves reliability of JobTrackingWithFinalizers. ([#105214](https://github.com/kubernetes/kubernetes/pull/105214), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- Fix job tracking with finalizers for more than 500 pods, ensuring all finalizers are removed before counting the Pod. ([#104666](https://github.com/kubernetes/kubernetes/pull/104666), [@alculquicondor](https://github.com/alculquicondor))
- Fix system default topology spreading when nodes don't have zone labels. Pods correctly spread by default now. ([#105046](https://github.com/kubernetes/kubernetes/pull/105046), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix: ignore non-VMSS error for VMAS nodes in `reconcileBackendPools`. ([#103997](https://github.com/kubernetes/kubernetes/pull/103997), [@nilo19](https://github.com/nilo19))
- Fix: skip case sensitivity when checking Azure NSG rules. ([#104384](https://github.com/kubernetes/kubernetes/pull/104384), [@feiskyer](https://github.com/feiskyer))
- Fixed a bug which kubectl would emit duplicate warning messages for flag names that contain an underscore and recommend using a nonexistent flag in some cases. ([#103852](https://github.com/kubernetes/kubernetes/pull/103852), [@brianpursley](https://github.com/brianpursley))
- Fixed a regression setting `--audit-log-path=-` to log to stdout in 1.22 pre-release. ([#103875](https://github.com/kubernetes/kubernetes/pull/103875), [@andrewrynhard](https://github.com/andrewrynhard))
- Fixed an issue which didn't append OS's environment variables with the one provided in Credential Provider Config file, which may fail execution of external credential provider binary. 
  See https://github.com/kubernetes/kubernetes/issues/102750. ([#103231](https://github.com/kubernetes/kubernetes/pull/103231), [@n4j](https://github.com/n4j))
- Fixed architecture within manifest for non `amd64` etcd images. ([#104116](https://github.com/kubernetes/kubernetes/pull/104116), [@saschagrunert](https://github.com/saschagrunert))
- Fixed azure disk translation issue due to lower case `managed` kind. ([#103439](https://github.com/kubernetes/kubernetes/pull/103439), [@andyzhangx](https://github.com/andyzhangx))
- Fixed client IP preservation for NodePort service with protocol SCTP in ipvs. ([#104756](https://github.com/kubernetes/kubernetes/pull/104756), [@tnqn](https://github.com/tnqn))
- Fixed occasional pod cgroup freeze when using cgroup v1 and systemd driver. ([#104528](https://github.com/kubernetes/kubernetes/pull/104528), [@kolyshkin](https://github.com/kolyshkin))
- Fixes a regression that could cause panics in LRU caches in controller-manager, kubelet, kube-apiserver, or client-go. ([#104466](https://github.com/kubernetes/kubernetes/pull/104466), [@stbenjam](https://github.com/stbenjam))
- Fixes an issue where an admission webhook can observe a v1 Pod object that does not have the `defaultMode` field set in the injected service account token volume in kube-api-server. ([#104523](https://github.com/kubernetes/kubernetes/pull/104523), [@liggitt](https://github.com/liggitt))
- Graceful node shutdown, allow the actual inhibit delay to be greater than the expected inhibit delay. ([#103137](https://github.com/kubernetes/kubernetes/pull/103137), [@wzshiming](https://github.com/wzshiming))
- Headless Services with no selector which were created without dual-stack enabled will be defaulted to RequireDualStack instead of PreferDualStack.  This is consistent with such Services which are created with dual-stack enabled. ([#104986](https://github.com/kubernetes/kubernetes/pull/104986), [@thockin](https://github.com/thockin)) [SIG Network]
- Ignore the case when comparing azure tags in service annotation. ([#104705](https://github.com/kubernetes/kubernetes/pull/104705), [@nilo19](https://github.com/nilo19))
- Ignore the case when updating Azure tags. ([#104593](https://github.com/kubernetes/kubernetes/pull/104593), [@nilo19](https://github.com/nilo19))
- Introduce a new server run option 'shutdown-send-retry-after'. If true the HTTP Server will continue listening until all non longrunning request(s) in flight have been drained, during this window all incoming requests will be rejected with a status code `429` and a 'Retry-After' response header. ([#101257](https://github.com/kubernetes/kubernetes/pull/101257), [@tkashem](https://github.com/tkashem))
- Kube-apiserver: Avoid unnecessary repeated calls to `admission webhooks` that reject an update or delete request. ([#104182](https://github.com/kubernetes/kubernetes/pull/104182), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: events created via the `events.k8s.io` API group for cluster-scoped objects are now permitted in the default namespace as well for compatibility with events clients and the `v1` API ([#100125](https://github.com/kubernetes/kubernetes/pull/100125), [@h4ghhh](https://github.com/h4ghhh)) [SIG API Machinery, Apps and Testing]
- Kube-proxy health check ports used to listen to `:<port>` for each of the services. This is not needed and opens ports in addresses the cluster user may not have intended. The PR limits listening to all node address which are controlled by `--nodeport-addresses` flag. if no addresses are provided then we default to existing behavior by listening to `:<port>` for each service ([#104742](https://github.com/kubernetes/kubernetes/pull/104742), [@khenidak](https://github.com/khenidak))
- Kube-proxy: delete stale conntrack UDP entries for loadbalancer ingress IP. ([#104009](https://github.com/kubernetes/kubernetes/pull/104009), [@aojea](https://github.com/aojea))
- Kube-scheduler now doesn't print any usage message when unknown flag is specified. ([#104503](https://github.com/kubernetes/kubernetes/pull/104503), [@sanposhiho](https://github.com/sanposhiho))
- Kubeadm: When adding an etcd peer to an existing cluster, if an error is returned indicating the peer has already been added, this is accepted and a `ListMembers` call is used instead to return the existing cluster. This helps to diminish the exponential backoff when the first AddMember call times out, while still retaining a similar performance when the peer has already been added from a previous call. ([#104134](https://github.com/kubernetes/kubernetes/pull/104134), [@ihgann](https://github.com/ihgann))
- Kubeadm: switch the preflight check (called 'Swap') that verifies if swap is enabled on Linux hosts to report a warning instead of an error. This is related to the graduation of the NodeSwap feature gate in the kubelet to Beta and being enabled by default in 1.23 - allows swap support on Linux hosts. In the next release of kubeadm (1.24) the preflight check will be removed, thus we recommend that you stop using it - e.g. via --ignore-preflight-errors or the kubeadm config. ([#104854](https://github.com/kubernetes/kubernetes/pull/104854), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Makes the etcd client (used by the API server) retry certain types of errors. The full list of retriable (codes.Unavailable) errors can be found at https://github.com/etcd-io/etcd/blob/main/api/v3rpc/rpctypes/error.go#L72 ([#105069](https://github.com/kubernetes/kubernetes/pull/105069), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Metrics changes: Fix exposed buckets of `scheduler_volume_scheduling_duration_seconds_bucket` metric. ([#100720](https://github.com/kubernetes/kubernetes/pull/100720), [@dntosas](https://github.com/dntosas))
- Pass additional flags to subpath mount to avoid flakes in certain conditions. ([#104253](https://github.com/kubernetes/kubernetes/pull/104253), [@mauriciopoppe](https://github.com/mauriciopoppe))
- Provide IPv6 support for internal load balancer. ([#103794](https://github.com/kubernetes/kubernetes/pull/103794), [@nilo19](https://github.com/nilo19))
- Reverts adding namespace label to admission metrics (and histogram exansion) due to cardinality issues. ([#104033](https://github.com/kubernetes/kubernetes/pull/104033), [@s-urbaniak](https://github.com/s-urbaniak))
- Scheduler resource metrics over fractional binary quantities (2.5Gi, 1.1Ki) were incorrectly reported as very small values. ([#103751](https://github.com/kubernetes/kubernetes/pull/103751), [@y-tag](https://github.com/y-tag))
- Update Go used to build migrate script in etcd image to v1.16.7. ([#104301](https://github.com/kubernetes/kubernetes/pull/104301), [@serathius](https://github.com/serathius))
- Updated json representation for a conflicted taint to `Key=Effect` when a conflicted taint occurs in kubectl taint. ([#104011](https://github.com/kubernetes/kubernetes/pull/104011), [@manugupt1](https://github.com/manugupt1))
- When a static pod file is deleted and recreated while using a fixed UID, the pod was not properly restarted. ([#104847](https://github.com/kubernetes/kubernetes/pull/104847), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node and Testing]
- XFS-filesystems are now force-formatted (option `-f`) in order to avoid problems being formatted due to detection of magic super-blocks. This aligns with the behaviour of formatting of ext3/4 filesystems. ([#104923](https://github.com/kubernetes/kubernetes/pull/104923), [@davidkarlsen](https://github.com/davidkarlsen)) [SIG Storage]

### Other (Cleanup or Flake)

- Better pod events ("waiting for ephemeral volume controller to create the persistentvolumeclaim"" instead of "persistentvolumeclaim not found") when using generic ephemeral volumes. ([#104605](https://github.com/kubernetes/kubernetes/pull/104605), [@pohly](https://github.com/pohly))
- Deprecate `apiserver_longrunning_gauge` and `apiserver_register_watchers` in 1.23.0. ([#103793](https://github.com/kubernetes/kubernetes/pull/103793), [@yan-lgtm](https://github.com/yan-lgtm))
- Enhanced error message for nodes not selected by scheduler due to pod's PersistentVolumeClaim(s) bound to PersistentVolume(s) that do not exist. ([#105196](https://github.com/kubernetes/kubernetes/pull/105196), [@yibozhuang](https://github.com/yibozhuang)) [SIG Scheduling and Storage]
- Fix an issue in cleaning up `CertificateSigningRequest` objects with an unparseable `status.certificate` field. ([#103823](https://github.com/kubernetes/kubernetes/pull/103823), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: sets an upper-bound on the lifetime of idle keep-alive connections and time to read the headers of incoming requests. ([#103958](https://github.com/kubernetes/kubernetes/pull/103958), [@liggitt](https://github.com/liggitt))
- Kubeadm: external etcd endpoints passed in the `ClusterConfiguration` that have Unicode characters are no longer IDNA encoded (converted to Punycode). They are now just URL encoded as per Go's implementation of RFC-3986, have duplicate "/" removed from the URL paths, and passed like that directly to the `kube-apiserver` `--etcd-servers` flag. If you have etcd endpoints that have Unicode characters, it is advisable to encode them in advance with tooling that is fully IDNA compliant. If you don't do that, the Go standard library (used in k8s and etcd) would do it for you when making requests to the endpoints. ([#103801](https://github.com/kubernetes/kubernetes/pull/103801), [@gkarthiks](https://github.com/gkarthiks))
- Kubeadm: remove the --port flag from the manifest for the kube-scheduler since the flag has been a NO-OP since 1.23 and insecure serving was removed for the component. ([#105034](https://github.com/kubernetes/kubernetes/pull/105034), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: update references to legacy artifacts locations, the `ci-cross` prefix has been removed from the version match as it does not exist in the new `gs://k8s-release-dev` bucket. ([#103813](https://github.com/kubernetes/kubernetes/pull/103813), [@SataQiu](https://github.com/SataQiu))
- Migrate `cmd/proxy/{config, healthcheck, winkernel}` to structured logging ([#104944](https://github.com/kubernetes/kubernetes/pull/104944), [@jyz0309](https://github.com/jyz0309)) [SIG Network]
- Migrate `pkg/scheduler` to structured logging. ([#99273](https://github.com/kubernetes/kubernetes/pull/99273), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Migrate cmd/proxy/app and pkg/proxy/meta_proxier to structured logging ([#104928](https://github.com/kubernetes/kubernetes/pull/104928), [@jyz0309](https://github.com/jyz0309)) [SIG Apps, Cluster Lifecycle, Network, Node and Testing]
- Migrate pkg/proxy to structured logs ([#104908](https://github.com/kubernetes/kubernetes/pull/104908), [@CIPHERTron](https://github.com/CIPHERTron)) [SIG Network]
- Migrated `pkg/proxy/userspace` to structured logging. ([#104931](https://github.com/kubernetes/kubernetes/pull/104931), [@shivanshu1333](https://github.com/shivanshu1333))
- Migrated pkg/proxy/winuserspace to structured logging ([#105035](https://github.com/kubernetes/kubernetes/pull/105035), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Network]
- More detailed logging has been added to the EndpointSlice controller for Topology. ([#104741](https://github.com/kubernetes/kubernetes/pull/104741), [@robscott](https://github.com/robscott))
- Remove the deprecated flags `--csr-only` and `--csr-dir` from `kubeadm certs renew`. Please use `kubeadm certs generate-csr` instead. ([#104796](https://github.com/kubernetes/kubernetes/pull/104796), [@RA489](https://github.com/RA489))
- Support for Windows Server 2022 was added to the `k8s.gcr.io/pause:3.6` image. ([#104711](https://github.com/kubernetes/kubernetes/pull/104711), [@claudiubelu](https://github.com/claudiubelu))
- Surface warning when users don't set `propagationPolicy` for jobs while deleting. ([#104080](https://github.com/kubernetes/kubernetes/pull/104080), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- The `AllowInsecureBackendProxy` feature gate is removed. It reached GA in Kubernetes 1.21. ([#103796](https://github.com/kubernetes/kubernetes/pull/103796), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The `BoundServiceAccountTokenVolume` feature gate that is GA since v1.22 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104167](https://github.com/kubernetes/kubernetes/pull/104167), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Auth]
- The `StartupProbe` feature gate that is GA since v1.20 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104168](https://github.com/kubernetes/kubernetes/pull/104168), [@ialidzhikov](https://github.com/ialidzhikov))
- The `SupportPodPidsLimit` and  `SupportNodePidsLimit` feature gates that are GA since v1.20 are unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104163](https://github.com/kubernetes/kubernetes/pull/104163), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Node]
- The `apiserver` exposes 4 new metrics that allow to track the status of the Service CIDRs allocations:
      - current number of available IPs per Service CIDR
      - current number of used IPs per Service CIDR
      - total number of allocation per Service CIDR
      - total number of allocation errors per ServiceCIDR ([#104119](https://github.com/kubernetes/kubernetes/pull/104119), [@aojea](https://github.com/aojea))
- The flag `--deployment-controller-sync-period` has been deprecated and will be removed in v1.24. ([#103538](https://github.com/kubernetes/kubernetes/pull/103538), [@Pingan2017](https://github.com/Pingan2017))
- The image `gcr.io/kubernetes-e2e-test-images` will no longer be used in E2E / CI testing, `k8s.gcr.io/e2e-test-images` will be used instead. ([#103724](https://github.com/kubernetes/kubernetes/pull/103724), [@claudiubelu](https://github.com/claudiubelu))
- The maximum length of the `CSINode` id field has increased to 256 bytes to match the CSI spec. ([#104160](https://github.com/kubernetes/kubernetes/pull/104160), [@pacoxu](https://github.com/pacoxu))
- Troubleshooting: informers log handlers that take more than 100 milliseconds to process an object if the `DeltaFIFO` queue starts to grow beyond 10 elements. ([#103917](https://github.com/kubernetes/kubernetes/pull/103917), [@aojea](https://github.com/aojea))
- Update `cri-tools` dependency to v1.22.0. ([#104430](https://github.com/kubernetes/kubernetes/pull/104430), [@saschagrunert](https://github.com/saschagrunert))
- Update `migratecmd/kube-proxy/app` logs to structured logging. ([#98913](https://github.com/kubernetes/kubernetes/pull/98913), [@yxxhero](https://github.com/yxxhero))
- Update build images to Debian 11 (Bullseye)
  - debian-base:bullseye-v1.0.0
  - debian-iptables:bullseye-v1.0.0
  - go-runner:v2.3.1-go1.17.1-bullseye.0
  - kube-cross:v1.23.0-go1.17.1-bullseye.1
  - setcap:bullseye-v1.0.0
  - cluster/images/etcd: Build 3.5.0-2 image
  - test/conformance/image: Update runner image to base-debian11 ([#105158](https://github.com/kubernetes/kubernetes/pull/105158), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Architecture, Release and Testing]
- Update conformance image to use `debian-base:buster-v1.9.0`. ([#104696](https://github.com/kubernetes/kubernetes/pull/104696), [@PushkarJ](https://github.com/PushkarJ))
- `volume.kubernetes.io/storage-provisioner` annotation will be added to dynamic provisioning required PVC. `volume.beta.kubernetes.io/storage-provisioner` annotation is deprecated. ([#104590](https://github.com/kubernetes/kubernetes/pull/104590), [@Jiawei0227](https://github.com/Jiawei0227))