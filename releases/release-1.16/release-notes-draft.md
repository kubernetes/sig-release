# Kubernetes v1.16.0 Release Notes

A complete changelog for the release notes is now hosted in a customizable format at [relnotes.k8s.io](https://relnotes.k8s.io/?releaseVersions=1.16.0). Check it out and please give us your feedback!

## What’s New (Major Themes)

We’re pleased to announce the delivery of Kubernetes 1.16, our third release of 2019! Kubernetes 1.16 consists of 31 enhancements: 8 enhancements moving to stable, 8 enhancements in beta, and 15 enhancements in alpha.

The main themes of this release are:

- **Custom resources:** CRDs are in widespread use as a way to extend Kubernetes to persist and serve new resource types, and have been available in beta since the 1.7 release. The 1.16 release marks the graduation of CRDs to general availability (GA).
- **Admission webhooks:** Admission webhooks are in widespread use as a Kubernetes extensibility mechanism and have been available in beta since the 1.9 release. The 1.16 release marks the graduation of admission webhooks to general availability (GA).
- **Overhauled metrics**: Kubernetes has previously made extensive use of a global metrics registry to register metrics to be exposed. By implementing a metrics registry, metrics are registered in more transparent means. Previously, Kubernetes metrics have been excluded from any kind of stability requirements.
- **Volume Extension**: There are quite a few enhancements in this release that pertain to volumes and volume modifications. Volume resizing support in CSI specs is moving to beta which allows for any CSI spec volume plugin to be resizable.

### Additional Notable Feature Updates

- [Topology Manager](https://github.com/kubernetes/enhancements/issues/693), a new Kubelet component, aims to co-ordinate resource assignment decisions to provide optimized resource allocations.
- [IPv4/IPv6 dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack) enables the allocation of both IPv4 and IPv6 addresses to Pods and Services.
- [API Server Network Proxy](https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190226-network-proxy.md) going alpha in 1.16.
- [Extensions](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cloud-provider/20190422-cloud-controller-manager-migration.md) for Cloud Controller Manager Migration.
- Continued deprecation of extensions/v1beta1, apps/v1beta1, and apps/v1beta2 APIs; these extensions will be retired in 1.16!

## Known Issues

- The etcd and KMS plugin health checks are not exposed in the new `livez` and `readyz` endpoints. This will be fixed in 1.16.1.
- Systems running `iptables` 1.8.0 or newer should start it in legacy mode. Please note that this affects all versions of Kubernetes and not only v1.16.0. For more detailed information about the issue and how to apply a workaround, please refer to the official documentation

## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

#### Cluster Lifecycle

- Container images tar files for `amd64` will now contain the architecture in the RepoTags manifest.json section.
  If you are using docker manifests there are not visible changes. ([#80266](https://github.com/kubernetes/kubernetes/pull/80266), [@javier-b-perez](https://github.com/javier-b-perez))
- kubeadm now deletes the bootstrap-kubelet.conf file after TLS bootstrap
  User relying on bootstrap-kubelet.conf should switch to kubelet.conf that contains node credentials ([#80676](https://github.com/kubernetes/kubernetes/pull/80676), [@fabriziopandini](https://github.com/fabriziopandini))
- Node labels `beta.kubernetes.io/metadata-proxy-ready`, `beta.kubernetes.io/metadata-proxy-ready` and `beta.kubernetes.io/kube-proxy-ds-ready` are no longer added on new nodes.
  - ip-mask-agent addon starts to use the label `node.kubernetes.io/masq-agent-ds-ready` instead of `beta.kubernetes.io/masq-agent-ds-ready` as its node selector.
  - kube-proxy addon starts to use the label `node.kubernetes.io/kube-proxy-ds-ready` instead of `beta.kubernetes.io/kube-proxy-ds-ready` as its node selector.
  - metadata-proxy addon starts to use the label `cloud.google.com/metadata-proxy-ready` instead of `beta.kubernetes.io/metadata-proxy-ready` as its node selector.

#### Storage

- When PodInfoOnMount is enabled for a CSI driver, the new csi.storage.k8s.io/ephemeral parameter in the volume context allows a driver's NodePublishVolume implementation to determine on a case-by-case basis whether the volume is ephemeral or a normal persistent volume ([#79983](https://github.com/kubernetes/kubernetes/pull/79983), [@pohly](https://github.com/pohly))
- Add CSI Migration Shim for VerifyVolumesAreAttached and BulkVolumeVerify ([#80443](https://github.com/kubernetes/kubernetes/pull/80443), [@davidz627](https://github.com/davidz627))
- Promotes VolumePVCDataSource (Cloning) feature to beta for 1.16 release ([#81792](https://github.com/kubernetes/kubernetes/pull/81792), [@j-griffith](https://github.com/j-griffith))
- Integrated volume limits for in-tree and CSI volumes into one scheduler predicate. ([#77595](https://github.com/kubernetes/kubernetes/pull/77595), [@bertinatto](https://github.com/bertinatto))

## Deprecations and Removals

- API

  - The following APIs are no longer served by default:

    - All resources under `apps/v1beta1` and `apps/v1beta2` - use `apps/v1` instead
    - `daemonsets`, `deployments`, `replicasets` resources under `extensions/v1beta1` - use `apps/v1` instead
    - `networkpolicies` resources under `extensions/v1beta1` - use `networking.k8s.io/v1` instead
    - `podsecuritypolicies` resources under `extensions/v1beta1` - use `policy/v1beta1` instead

    Serving these resources can be temporarily re-enabled using the `--runtime-config` apiserver flag.

    - `apps/v1beta1=true`
    - `apps/v1beta2=true`
    - `extensions/v1beta1/daemonsets=true,extensions/v1beta1/deployments=true,extensions/v1beta1/replicasets=true,extensions/v1beta1/networkpolicies=true,extensions/v1beta1/podsecuritypolicies=true`

    The ability to serve these resources will be completely removed in v1.18. ([#70672](https://github.com/kubernetes/kubernetes/pull/70672), [@liggitt](https://github.com/liggitt))

  - Ingress resources will no longer be served from `extensions/v1beta1` in v1.20. Migrate use to the `networking.k8s.io/v1beta1` API, available since v1.14. Existing persisted data can be retrieved via the `networking.k8s.io/v1beta1` API.
  - PriorityClass resources will no longer be served from `scheduling.k8s.io/v1beta1` and `scheduling.k8s.io/v1alpha1` in v1.17. Migrate to the `scheduling.k8s.io/v1` API, available since v1.14. Existing persisted data can be retrieved via the `scheduling.k8s.io/v1` API.
  - The `export` query parameter for list API calls, deprecated since v1.14, will be removed in v1.18.
  - The `series.state` field in the events.k8s.io/v1beta1 Event API is deprecated and will be removed in v1.18 ([#75987](https://github.com/kubernetes/kubernetes/pull/75987), [@yastij](https://github.com/yastij))
  - The `apiextensions.k8s.io/v1beta1` version of `CustomResourceDefinition` is deprecated and will no longer be served in v1.19. Use `apiextensions.k8s.io/v1` instead. ([#79604](https://github.com/kubernetes/kubernetes/pull/79604), [@liggitt](https://github.com/liggitt))
  - The `admissionregistration.k8s.io/v1beta1` versions of `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` are deprecated and will no longer be served in v1.19. Use `admissionregistration.k8s.io/v1` instead. ([#79549](https://github.com/kubernetes/kubernetes/pull/79549), [@liggitt](https://github.com/liggitt))
  - The alpha `metadata.initializers` field, deprecated in 1.13, has been removed. ([#79504](https://github.com/kubernetes/kubernetes/pull/79504), [@yue9944882](https://github.com/yue9944882))
  - The deprecated node condition type `OutOfDisk` has been removed. Use the `DiskPressure` condition instead. ([#72420](https://github.com/kubernetes/kubernetes/pull/72420), [@Pingan2017](https://github.com/Pingan2017))
  - The `metadata.selfLink` field is deprecated in individual and list objects. It will no longer be returned starting in v1.20, and the field will be removed entirely in v1.21. ([#80978](https://github.com/kubernetes/kubernetes/pull/80978), [@wojtek-t](https://github.com/wojtek-t))
  - The deprecated cloud providers `ovirt`, `cloudstack` and `photon` have been removed ([#72178](https://github.com/kubernetes/kubernetes/pull/72178), [@dims](https://github.com/dims))
  - The `Cinder` and `ScaleIO` volume providers have been deprecated and will be removed in a future release. ([#80099](https://github.com/kubernetes/kubernetes/pull/80099), [@dims](https://github.com/dims))
  - The GA `PodPriority` feature gate is now on by default and cannot be disabled. The feature gate will be removed in v1.18. ([#79262](https://github.com/kubernetes/kubernetes/pull/79262), [@draveness](https://github.com/draveness))
  - Aggregated discovery requests can now timeout. Aggregated API servers must complete discovery calls within 5 seconds (other requests can take longer). Use the feature gate `EnableAggregatedDiscoveryTimeout=false` to temporarily revert behavior to the previous 30 second timeout if required (the temporary `EnableAggregatedDiscoveryTimeout` feature gate will be removed in v1.17). ([#82146](https://github.com/kubernetes/kubernetes/pull/82146), [@deads2k](https://github.com/deads2k))
  - the `scheduler.alpha.kubernetes.io/critical-pod` annotation is removed. Pod priority (`spec.priorityClassName`) should be used instead to mark pods as critical. ([#80342](https://github.com/kubernetes/kubernetes/pull/80342), [@draveness](https://github.com/draveness))
  - the NormalizeScore plugin set is removed from scheduler framework config API. Use ScorePlugin only. ([#80930](https://github.com/kubernetes/kubernetes/pull/80930), [@liu-cong](https://github.com/liu-cong))

- Features:

  - The following features are now GA, and the associated feature gates are deprecated and will be removed in v1.17:
    - `GCERegionalPersistentDisk` (since 1.15.0)
    - `CustomResourcePublishOpenAPI`
    - `CustomResourceSubresources`
    - `CustomResourceValidation`
    - `CustomResourceWebhookConversion`
  - The feature flags `HugePages`, `VolumeScheduling`, `CustomPodDNS` and `PodReadinessGates` have been removed ([#79307](https://github.com/kubernetes/kubernetes/pull/79307), [@draveness](https://github.com/draveness))

- hyperkube

  - the `--make-symlinks` flag, deprecated in v1.14, has been removed. ([#80017](https://github.com/kubernetes/kubernetes/pull/80017), [@Pothulapati](https://github.com/Pothulapati))

- kube-apiserver

  - the `--basic-auth-file` flag and authentication mode is deprecated and will be removed in a future release. It is not recommended for production environments. ([#81152](https://github.com/kubernetes/kubernetes/pull/81152), [@tedyu](https://github.com/tedyu))
  - the `--cloud-provider-gce-lb-src-cidrs` flag has been deprecated. This flag will be removed once the GCE Cloud Provider is removed from kube-apiserver. ([#81094](https://github.com/kubernetes/kubernetes/pull/81094), [@andrewsykim](https://github.com/andrewsykim))
  - the `--enable-logs-handler` flag and log-serving functionality is deprecated since v1.15, and scheduled to be removed in v1.19. ([#77611](https://github.com/kubernetes/kubernetes/pull/77611), [@rohitsardesai83](https://github.com/rohitsardesai83))
  - Deprecate the default service IP CIDR. The previous default was `10.0.0.0/24` which will be removed in 6 months/2 releases. Cluster admins must specify their own desired value, by using `--service-cluster-ip-range` on kube-apiserver. ([#81668](https://github.com/kubernetes/kubernetes/pull/81668), [@darshanime](https://github.com/darshanime))

- kube-proxy

  - the `--resource-container` flag has been removed from kube-proxy, and specifying it will now cause an error. The behavior is now as if you specified `--resource-container=""`. If you previously specified a non-empty `--resource-container`, you can no longer do so as of kubernetes 1.16. ([#78294](https://github.com/kubernetes/kubernetes/pull/78294), [@vllry](https://github.com/vllry))

- kube-scheduler

  - Migrate scheduler to use v1beta1 Event API. any tool targeting scheduler events needs to use v1beta1 Event API ([#78447](https://github.com/kubernetes/kubernetes/pull/78447), [@yastij](https://github.com/yastij))

- kubeadm

  - The CoreDNS Deployment now checks readiness via the `ready` plugin.
  - The `proxy` plugin has been deprecated. The `forward` plugin is to be used instead.
  - `kubernetes` plugin removes the `resyncperiod` option.
  - The `upstream` option is deprecated and ignored if included.
    ([#82127](https://github.com/kubernetes/kubernetes/pull/82127), [@rajansandeep](https://github.com/rajansandeep))

- kubectl

  - `kubectl convert`, deprecated since v1.14, will be removed in v1.17.
  - The `--export` flag for the `kubectl get` command, deprecated since v1.14, will be removed in v1.18.
  - `kubectl cp` no longer supports copying symbolic links from containers; to support this use case, see `kubectl exec --help` for examples using `tar` directly ([#82143](https://github.com/kubernetes/kubernetes/pull/82143), [@soltysh](https://github.com/soltysh))
  - Removed deprecated flag `--include-uninitialized`. ([#80337](https://github.com/kubernetes/kubernetes/pull/80337), [@draveness](https://github.com/draveness))

- kubelet

  - the `--containerized` flag was deprecated in 1.14 and has been removed ([#80043](https://github.com/kubernetes/kubernetes/pull/80043), [@dims](https://github.com/dims))
  - the `beta.kubernetes.io/os` and `beta.kubernetes.io/arch` labels, deprecated since v1.14, are targeted for removal in v1.18.
  - cAdvisor json endpoints have been deprecated since 1.15. ([#78504](https://github.com/kubernetes/kubernetes/pull/78504), [@dashpole](https://github.com/dashpole))
  - removed the ability to set `kubernetes.io`- or `k8s.io`-prefixed labels via `--node-labels`, other than the [specifically allowed labels/prefixes](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/0000-20170814-bounding-self-labeling-kubelets.md#proposal). ([#79305](https://github.com/kubernetes/kubernetes/pull/79305), [@paivagustavo](https://github.com/paivagustavo))

- client-go
  - Remove `DirectCodecFactory` (replaced with `serializer.WithoutConversionCodecFactory`), `DirectEncoder` (replaced with `runtime.WithVersionEncoder`) and `DirectDecoder` (replaced with `runtime.WithoutVersionDecoder`). ([#79263](https://github.com/kubernetes/kubernetes/pull/79263), [@draveness](https://github.com/draveness))

## Metrics Changes

### Added metrics

- Added metrics `aggregator_openapi_v2_regeneration_count`, `aggregator_openapi_v2_regeneration_gauge` and `apiextension_openapi_v2_regeneration_count` counting the triggering APIService and CRDs and the reason (add, update, delete) when kube-apiserver regenerates the OpenAPI spec. ([#81786](https://github.com/kubernetes/kubernetes/pull/81786), [@sttts](https://github.com/sttts))
- Added metrics `authentication_attempts` that can be used to understand the attempts of authentication. ([#81509](https://github.com/kubernetes/kubernetes/pull/81509), [@RainbowMango](https://github.com/RainbowMango))
- Add a new counter metrics `apiserver_admission_webhook_rejection_count` with details about the causing for a webhook rejection. ([#81399](https://github.com/kubernetes/kubernetes/pull/81399), [@roycaihw](https://github.com/roycaihw))
- NFS Drivers are now enabled to collect metrics, StatFS metrics provider is used to collect the metrics. (@brahmaroutu) ([#75805](https://github.com/kubernetes/kubernetes/pull/75805), [@brahmaroutu](https://github.com/brahmaroutu))
- Add `container_sockets`, `container_threads`, and `container_threads_max` metrics ([#81972](https://github.com/kubernetes/kubernetes/pull/81972), [@dashpole](https://github.com/dashpole))
- Add `container_state` label to `running_container_count` kubelet metrics, to get count of containers based on their state(running/exited/created/unknown) ([#81573](https://github.com/kubernetes/kubernetes/pull/81573), [@irajdeep](https://github.com/irajdeep))
- Added metric `apiserver_watch_events_total` that can be used to understand the number of watch events in the system. ([#78732](https://github.com/kubernetes/kubernetes/pull/78732), [@mborsz](https://github.com/mborsz))
- Added metric `apiserver_watch_events_sizes` that can be used to estimate sizes of watch events in the system. ([#80477](https://github.com/kubernetes/kubernetes/pull/80477), [@mborsz](https://github.com/mborsz))
- Added a new Prometheus counter metric `sync_proxy_rules_iptables_restore_failures_total` for kube-proxy iptables-restore failures (both ipvs and iptables modes)
  ([#81210](https://github.com/kubernetes/kubernetes/pull/81210), [@figo](https://github.com/figo))
- kubelet now exports an `kubelet_evictions` metric that counts the number of pod evictions carried out by the kubelet to reclaim resources ([#81377](https://github.com/kubernetes/kubernetes/pull/81377), [@sjenning](https://github.com/sjenning))

### Removed metrics

- Removed cadvisor metric labels `pod_name` and `container_name` to match instrumentation guidelines. Any Prometheus queries that match `pod_name` and `container_name` labels (e.g. cadvisor or kubelet probe metrics) must be updated to use `pod` and `container` instead. ([#80376](https://github.com/kubernetes/kubernetes/pull/80376), [@ehashman](https://github.com/ehashman))

### Depreciated/changed metrics

- kube-controller-manager and cloud-controller-manager metrics are now marked as with the ALPHA stability level. ([#81624](https://github.com/kubernetes/kubernetes/pull/81624), [@logicalhan](https://github.com/logicalhan))
- kube-proxy metrics are now marked as with the ALPHA stability level. ([#81626](https://github.com/kubernetes/kubernetes/pull/81626), [@logicalhan](https://github.com/logicalhan))
- kube-apiserver metrics are now marked as with the ALPHA stability level. ([#81531](https://github.com/kubernetes/kubernetes/pull/81531), [@logicalhan](https://github.com/logicalhan))
- kubelet metrics for /metrics and /metrics/probes are now marked as with the ALPHA stability level. ([#81534](https://github.com/kubernetes/kubernetes/pull/81534), [@logicalhan](https://github.com/logicalhan))
- Scheduler metrics are now marked as with the ALPHA stability level. ([#81576](https://github.com/kubernetes/kubernetes/pull/81576), [@logicalhan](https://github.com/logicalhan))
- The `rejected` label in `apiserver_admission_webhook_admission_duration_seconds` metrics now properly indicates if the request was rejected. ([#81399](https://github.com/kubernetes/kubernetes/pull/81399), [@roycaihw](https://github.com/roycaihw))
- Fixed a bug in the CSI metrics that does not return not supported error when a CSI driver does not support metrics. ([#79851](https://github.com/kubernetes/kubernetes/pull/79851), [@jparklab](https://github.com/jparklab))
- Fix disk stats in LXD using ZFS storage pool and CRI-O missing network metris bug ([#81972](https://github.com/kubernetes/kubernetes/pull/81972), [@dashpole](https://github.com/dashpole))

## Notable Features

### Beta

- Promote WatchBookmark feature to beta and enable it by default.
  With WatchBookmark feature, clients are able to request watch events with BOOKMARK type. Clients should not assume bookmarks are returned at any specific interval, nor may they assume the server will send any BOOKMARK event during a session. ([#79786](https://github.com/kubernetes/kubernetes/pull/79786), [@wojtek-t](https://github.com/wojtek-t))
- The server-side apply feature is now beta ([#81956](https://github.com/kubernetes/kubernetes/pull/81956), [@apelisse](https://github.com/apelisse))
- Server-side apply will now use the openapi provided in the CRD validation field to help figure out how to correctly merge objects and update ownership. ([#77354](https://github.com/kubernetes/kubernetes/pull/77354), [@jennybuckley](https://github.com/jennybuckley))
- The `CustomResourceDefaulting` feature is promoted to beta and enabled by default. Defaults may be specified in structural schemas via the `apiextensions.k8s.io/v1` API. See https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/&#35;specifying-a-structural-schema for details. ([#81872](https://github.com/kubernetes/kubernetes/pull/81872), [@sttts](https://github.com/sttts))
- Finalizer Protection for Service LoadBalancers is now in beta (enabled by default). This feature ensures the Service resource is not fully deleted until the correlating load balancer resources are deleted. ([#81691](https://github.com/kubernetes/kubernetes/pull/81691), [@MrHohn](https://github.com/MrHohn))
- Graduating Windows GMSA support from alpha to beta ([#82110](https://github.com/kubernetes/kubernetes/pull/82110), [@wk8](https://github.com/wk8))

### Alpha

- Introduce a new admission controller for RuntimeClass. Initially, RuntimeClass will be used to apply the pod overhead associated with a given RuntimeClass to the Pod `spec` if a corresponding RuntimeClassName is specified. PodOverhead is an alpha feature as of Kubernetes 1.16. ([#78484](https://github.com/kubernetes/kubernetes/pull/78484), [@egernst](https://github.com/egernst))
- Introduction of the pod overhead feature to the scheduler. This functionality is alpha-level as of
  Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.gate. ([#78319](https://github.com/kubernetes/kubernetes/pull/78319), [@egernst](https://github.com/egernst))
- Ephemeral containers have been added in alpha. These temporary containers can be added to running pods for purposes such as debugging, similar to how `kubectl exec` runs a process in an existing container. Also like `kubectl exec`, no resources are reserved for ephemeral containers and they are not restarted when they exit. Note that container namespace targeting is not yet implemented, so [process namespace sharing](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/) must be enabled to view process from other containers in the pod. ([#59484](https://github.com/kubernetes/kubernetes/pull/59484), [@verb](https://github.com/verb))
- Pod spread constraints have been added in alpha. You can use these constraints to control how Pods are spread across the cluster among failure-domains. ([#77327](https://github.com/kubernetes/kubernetes/pull/77327), [#77760](https://github.com/kubernetes/kubernetes/pull/77760), [#77828](https://github.com/kubernetes/kubernetes/pull/77828), [#79062](https://github.com/kubernetes/kubernetes/pull/79062), [#80011](https://github.com/kubernetes/kubernetes/pull/80011), [#81068](https://github.com/kubernetes/kubernetes/pull/81068), [@Huang-Wei](https://github.com/Huang-Wei))

### CLI Improvements

- the new flag `--endpoint-updates-batch-period` in kube-controller-manager can be used to reduce the number of endpoints updates generated by pod changes. ([#80509](https://github.com/kubernetes/kubernetes/pull/80509), [@mborsz](https://github.com/mborsz))
- the kubectl `--all-namespaces` flag is now honored by `kubectl wait` ([#81468](https://github.com/kubernetes/kubernetes/pull/81468), [@ashutoshgngwr](https://github.com/ashutoshgngwr))
- `kubectl get -w` now takes an `--output-watch-events` flag to indicate the event type (ADDED, MODIFIED, DELETED) ([#72416](https://github.com/kubernetes/kubernetes/pull/72416), [@liggitt](https://github.com/liggitt))
- Adds Endpoint Slice support for kubectl when discovery API group is enabled. ([#81795](https://github.com/kubernetes/kubernetes/pull/81795), [@robscott](https://github.com/robscott))

### Misc

- Add `--shutdown-delay-duration` to kube-apiserver in order to delay a graceful shutdown. `/healthz` will keep returning success during this time and requests are normally served, but `/readyz` will return failure immediately. This delay can be used to allow the SDN to update iptables on all nodes and stop sending traffic. ([#74416](https://github.com/kubernetes/kubernetes/pull/74416), [@sttts](https://github.com/sttts))
  Kubeadm now seamlessly migrates the CoreDNS Configuration when upgrading CoreDNS. ([#78033](https://github.com/kubernetes/kubernetes/pull/78033), [@rajansandeep](https://github.com/rajansandeep))
- Add Endpoint Slice Controller for managing new EndpointSlice resource, disabled by default. ([#81048](https://github.com/kubernetes/kubernetes/pull/81048), [@robscott](https://github.com/robscott))
- Adds `\livez` for liveness health checking for kube-apiserver. Using the parameter `--maximum-startup-sequence-duration` will allow the liveness endpoint to defer boot-sequence failures for the specified duration period. ([#81969](https://github.com/kubernetes/kubernetes/pull/81969), [@logicalhan](https://github.com/logicalhan))
- Adds EndpointSlice integration to kube-proxy, can be enabled with EndpointSlice feature gate. ([#81430](https://github.com/kubernetes/kubernetes/pull/81430), [@robscott](https://github.com/robscott))
- Add status condition to namespace resource ([#73405](https://github.com/kubernetes/kubernetes/pull/73405), [@wozniakjan](https://github.com/wozniakjan))
- Enhance Azure cloud provider code to support both AAD and ADFS authentication. ([#80841](https://github.com/kubernetes/kubernetes/pull/80841), [@rjaini](https://github.com/rjaini))
- kubeadm: implement support for concurrent add/remove of stacked etcd members ([#79677](https://github.com/kubernetes/kubernetes/pull/79677), [@neolit123](https://github.com/neolit123))
- kubeadm: support any Linux kernel version newer than 3.10 ([#81623](https://github.com/kubernetes/kubernetes/pull/81623), [@neolit123](https://github.com/neolit123))
- Volume expansion is enabled in the default GCE storageclass ([#78672](https://github.com/kubernetes/kubernetes/pull/78672), [@msau42](https://github.com/msau42))
- kubeadm ClusterConfiguration now supports featureGates: IPv6DualStack: true ([#80145](https://github.com/kubernetes/kubernetes/pull/80145), [@Arvinderpal](https://github.com/Arvinderpal))
- In order to enable dual-stack support within kubeadm and kubernetes components, as part of the init config file, the user should set feature-gate `IPv6DualStack=true` in the ClusterConfiguration. Additionally, for each worker node, the user should set the feature-gate for kubelet using either `nodeRegistration.kubeletExtraArgs` or `KUBELET_EXTRA_ARGS`. ([#80531](https://github.com/kubernetes/kubernetes/pull/80531), [@Arvinderpal](https://github.com/Arvinderpal))
- Add possibility to configure controller manager to use IPv6 dual stack:
  use `--cluster-cidr="<cidr1>,<cidr2>"`.
  Notes:
  1. Only the first two CIDRs are used (soft limits for Alpha, might be lifted later on).
  2. Only the "RangeAllocator" (default) is allowed as a value for `--cidr-allocator-type`. Cloud allocators are not compatible with IPv6 dual stack
     ([#73977](https://github.com/kubernetes/kubernetes/pull/73977), [@khenidak](https://github.com/khenidak))
- Add scheduling support for RuntimeClasses. RuntimeClasses can now specify nodeSelector constraints & tolerations, which are merged into the PodSpec for pods using that RuntimeClass. ([#80825](https://github.com/kubernetes/kubernetes/pull/80825), [@tallclair](https://github.com/tallclair))
- When specifying `--(kube|system)-reserved-cgroup`, with `--cgroup-driver=systemd`, it is now possible to use the fully qualified cgroupfs name (i.e. `/test-cgroup.slice`). ([#78793](https://github.com/kubernetes/kubernetes/pull/78793), [@mattjmcnaughton](https://github.com/mattjmcnaughton))
- Adds support for vSphere volumes on Windows ([#80911](https://github.com/kubernetes/kubernetes/pull/80911), [@gab-satchi](https://github.com/gab-satchi))

## API Changes

- The `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` APIs have been promoted to `admissionregistration.k8s.io/v1`:
  - `failurePolicy` default changed from `Ignore` to `Fail` for v1
  - `matchPolicy` default changed from `Exact` to `Equivalent` for v1
  - `timeout` default changed from `30s` to `10s` for v1
  - `sideEffects` default value is removed, and the field made required, and only `None` and `NoneOnDryRun` are permitted for v1
  - `admissionReviewVersions` default value is removed and the field made required for v1 (supported versions for AdmissionReview are `v1` and `v1beta1`)
  - The `name` field for specified webhooks must be unique for `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` objects created via `admissionregistration.k8s.io/v1`
- The `AdmissionReview` API sent to and received from admission webhooks has been promoted to `admission.k8s.io/v1`. Webhooks can specify a preference for receiving `v1` AdmissionReview objects with `admissionReviewVersions: ["v1","v1beta1"]`, and must respond with an API object in the same `apiVersion` they are sent. When webhooks use `admission.k8s.io/v1`, the following additional validation is performed on their responses:
  - `response.patch` and `response.patchType` are not permitted from validating admission webhooks
  - `apiVersion: "admission.k8s.io/v1"` is required
  - `kind: "AdmissionReview"` is required
  - `response.uid: "<value of request.uid>"` is required
  - `response.patchType: "JSONPatch"` is required (if `response.patch` is set) ([#80231](https://github.com/kubernetes/kubernetes/pull/80231), [@liggitt](https://github.com/liggitt))
- The `CustomResourceDefinition` API type is promoted to `apiextensions.k8s.io/v1` with the following changes:
  - Use of the new `default` feature in validation schemas is limited to v1
  - `spec.scope` is no longer defaulted to `Namespaced` and must be explicitly specified
  - `spec.version` is removed in v1; use `spec.versions` instead
  - `spec.validation` is removed in v1; use `spec.versions[*].schema` instead
  - `spec.subresources` is removed in v1; use `spec.versions[*].subresources` instead
  - `spec.additionalPrinterColumns` is removed in v1; use `spec.versions[*].additionalPrinterColumns` instead
  - `spec.conversion.webhookClientConfig` is moved to `spec.conversion.webhook.clientConfig` in v1
  - `spec.conversion.conversionReviewVersions` is moved to `spec.conversion.webhook.conversionReviewVersions` in v1
  - `spec.versions[*].schema.openAPIV3Schema` is now required when creating v1 CustomResourceDefinitions
  - `spec.preserveUnknownFields: true` is disallowed when creating v1 CustomResourceDefinitions; it must be specified within schema definitions as `x-kubernetes-preserve-unknown-fields: true`
  - In `additionalPrinterColumns` items, the `JSONPath` field was renamed to `jsonPath` in v1 (fixes https://github.com/kubernetes/kubernetes/issues/66531)
    The `apiextensions.k8s.io/v1beta1` version of `CustomResourceDefinition` is deprecated and will no longer be served in v1.19. ([#79604](https://github.com/kubernetes/kubernetes/pull/79604), [@liggitt](https://github.com/liggitt))
- The `ConversionReview` API sent to and received from custom resource CustomResourceDefinition conversion webhooks has been promoted to `apiextensions.k8s.io/v1`. CustomResourceDefinition conversion webhooks can now indicate they support receiving and responding with `ConversionReview` API objects in the `apiextensions.k8s.io/v1` version by including `v1` in the `conversionReviewVersions` list in their CustomResourceDefinition. Conversion webhooks must respond with a ConversionReview object in the same apiVersion they receive. `apiextensions.k8s.io/v1` `ConversionReview` responses must specify a `response.uid` that matches the `request.uid` of the object they were sent. ([#81476](https://github.com/kubernetes/kubernetes/pull/81476), [@liggitt](https://github.com/liggitt))
- Add scheduling support for RuntimeClasses. RuntimeClasses can now specify nodeSelector constraints & tolerations, which are merged into the PodSpec for pods using that RuntimeClass. ([#80825](https://github.com/kubernetes/kubernetes/pull/80825), [@tallclair](https://github.com/tallclair))
- Kubelet should now more reliably report the same primary node IP even if the set of node IPs reported by the CloudProvider changes. ([#79391](https://github.com/kubernetes/kubernetes/pull/79391), [@danwinship](https://github.com/danwinship))
- Omit nil or empty field when calculating container hash value to avoid hash changed. For a new field with a non-nil default value in the container spec, the hash would still get changed. ([#57741](https://github.com/kubernetes/kubernetes/pull/57741), [@dixudx](https://github.com/dixudx))
- Property `conditions` in `apiextensions.v1beta1.CustomResourceDefinitionStatus` and `apiextensions.v1.CustomResourceDefinitionStatus` is now optional instead of required. ([#64996](https://github.com/kubernetes/kubernetes/pull/64996), [@roycaihw](https://github.com/roycaihw))
- When the status of a CustomResourceDefinition condition changes, its corresponding `lastTransitionTime` is now updated. ([#69655](https://github.com/kubernetes/kubernetes/pull/69655), [@CaoShuFeng](https://github.com/CaoShuFeng))

## Other notable changes

### API Machinery

- Remove `GetReference()` and `GetPartialReference()` function from `pkg/api/ref`, as the same function exists also in `staging/src/k8s.io/client-go/tools/ref` ([#80361](https://github.com/kubernetes/kubernetes/pull/80361), [@wojtek-t](https://github.com/wojtek-t))
- Verify that CRD default values in OpenAPI specs are pruned, with the exceptions of values under `metadata`. ([#78829](https://github.com/kubernetes/kubernetes/pull/78829), [@sttts](https://github.com/sttts))
- Fixes a bug that when there is a "connection refused" error, the reflector's ListAndWatch func will return directly but what expected is that sleep 1 second and rewatch since the specified resourceVersion.
  ([#81634](https://github.com/kubernetes/kubernetes/pull/81634), [@likakuli](https://github.com/likakuli))
- Resolves an issue serving aggregated APIs backed by services that respond to requests to `/` with non-2xx HTTP responses ([#79895](https://github.com/kubernetes/kubernetes/pull/79895), [@deads2k](https://github.com/deads2k))
- The CRD handler now properly re-creates stale CR storage to reflect CRD update. ([#79114](https://github.com/kubernetes/kubernetes/pull/79114), [@roycaihw](https://github.com/roycaihw))
- Fix CVE-2019-11247: API server allows access to custom resources via wrong scope ([#80750](https://github.com/kubernetes/kubernetes/pull/80750), [@sttts](https://github.com/sttts))
- Fixed a bug with the openAPI definition for `io.k8s.apimachinery.pkg.runtime.RawExtension`, which previously required a field `raw` to be specified ([#80773](https://github.com/kubernetes/kubernetes/pull/80773), [@jennybuckley](https://github.com/jennybuckley))
- Property `conditions` in `apiextensions.v1beta1.CustomResourceDefinitionStatus` and `apiextensions.v1.CustomResourceDefinitionStatus` is now optional instead of required. ([#64996](https://github.com/kubernetes/kubernetes/pull/64996), [@roycaihw](https://github.com/roycaihw))
- Resolves a transient 404 response to custom resource requests during server startup ([#81244](https://github.com/kubernetes/kubernetes/pull/81244), [@liggitt](https://github.com/liggitt))
- OpenAPI now advertises correctly supported patch types for custom resources ([#81515](https://github.com/kubernetes/kubernetes/pull/81515), [@liggitt](https://github.com/liggitt))
- When the status of a CRD Condition changes, it's corresponding `LastTransitionTime` is now updated. ([#69655](https://github.com/kubernetes/kubernetes/pull/69655), [@CaoShuFeng](https://github.com/CaoShuFeng))
- Add `metadata.generation=1` to old CustomResources. ([#82005](https://github.com/kubernetes/kubernetes/pull/82005), [@sttts](https://github.com/sttts))
- Fix a bug in the apiserver that could cause a valid update request to be rejected with a precondition check failure. ([#82303](https://github.com/kubernetes/kubernetes/pull/82303), [@roycaihw](https://github.com/roycaihw))
- Fixes regression in logging spurious stack traces when proxied connections are closed by the backend ([#82588](https://github.com/kubernetes/kubernetes/pull/82588), [@liggitt](https://github.com/liggitt))
- RateLimiter add a context-aware method, fix client-go request goruntine backlog in async timeout scene. ([#79375](https://github.com/kubernetes/kubernetes/pull/79375), [@answer1991](https://github.com/answer1991))
- Add a `Patch` method to `ScaleInterface` ([#80699](https://github.com/kubernetes/kubernetes/pull/80699), [@knight42](https://github.com/knight42))
- CRDs under k8s.io and kubernetes.io must have the `api-approved.kubernetes.io` set to either `unapproved.*` or a link to the pull request approving the schema. See https://github.com/kubernetes/enhancements/pull/1111 for more details. ([#79992](https://github.com/kubernetes/kubernetes/pull/79992), [@deads2k](https://github.com/deads2k))
- KMS Providers will install a healthz check for the status of kms-plugin in kube-apiservers' encryption config. ([#78540](https://github.com/kubernetes/kubernetes/pull/78540), [@immutableT](https://github.com/immutableT))
- Improves validation errors for custom resources ([#81212](https://github.com/kubernetes/kubernetes/pull/81212), [@liggitt](https://github.com/liggitt))
- Populate object name for admission attributes when CREATE ([#53185](https://github.com/kubernetes/kubernetes/pull/53185), [@dixudx](https://github.com/dixudx))
- Add Overhead field to the PodSpec and RuntimeClass types as part of the Pod Overhead KEP ([#76968](https://github.com/kubernetes/kubernetes/pull/76968), [@egernst](https://github.com/egernst))

### Apps

- Fix a bug that pods not be deleted from unmatched nodes by daemon controller ([#78974](https://github.com/kubernetes/kubernetes/pull/78974), [@DaiHao](https://github.com/DaiHao))
- Fix a bug that causes DaemonSet rolling update hang when there exist failed pods. ([#78170](https://github.com/kubernetes/kubernetes/pull/78170), [@DaiHao](https://github.com/DaiHao))

### Auth

- Service account tokens now include the JWT Key ID field in their header. ([#78502](https://github.com/kubernetes/kubernetes/pull/78502), [@ahmedtd](https://github.com/ahmedtd))
- The nbf (not before) claim, if present in ID token, is now enforced. ([#81413](https://github.com/kubernetes/kubernetes/pull/81413), [@anderseknert](https://github.com/anderseknert))

### CLI

- Fix CVE-2019-11249: Incomplete fixes for CVE-2019-1002101 and CVE-2019-11246, kubectl cp potential directory traversal ([#80436](https://github.com/kubernetes/kubernetes/pull/80436), [@M00nF1sh](https://github.com/M00nF1sh))
- Fix the bash completion error with override flags. ([#80802](https://github.com/kubernetes/kubernetes/pull/80802), [@dtaniwaki](https://github.com/dtaniwaki))
- Fix a bug in server printer that could cause kube-apiserver to panic. ([#79349](https://github.com/kubernetes/kubernetes/pull/79349), [@roycaihw](https://github.com/roycaihw))
- Fix invalid "time stamp is the future" error when kubectl cp-ing a file ([#73982](https://github.com/kubernetes/kubernetes/pull/73982), [@tanshanshan](https://github.com/tanshanshan))
- Fix a bug where `kubectl set config` hangs and uses 100% CPU on some invalid property names ([#79000](https://github.com/kubernetes/kubernetes/pull/79000), [@pswica](https://github.com/pswica))
- Fix output of `kubectl get --watch-only` when watching a single resource ([#79345](https://github.com/kubernetes/kubernetes/pull/79345), [@liggitt](https://github.com/liggitt))
- Make kubectl get `--ignore-not-found` continue processing when encountering error. ([#82120](https://github.com/kubernetes/kubernetes/pull/82120), [@soltysh](https://github.com/soltysh))
- Correct a reference to a not/no longer used kustomize subcommand in the documentation ([#82535](https://github.com/kubernetes/kubernetes/pull/82535), [@demobox](https://github.com/demobox))
- kubectl could scale custom resource again ([#81342](https://github.com/kubernetes/kubernetes/pull/81342), [@knight42](https://github.com/knight42))
- Add PodOverhead awareness to kubectl ([#81929](https://github.com/kubernetes/kubernetes/pull/81929), [@egernst](https://github.com/egernst))

### Cloud Provider

- When a load balancer type service is created in a k8s cluster that is backed by Azure Standard Load Balancer, the corresponding load balancer rule added in the Azure Standard Load Balancer would now have the "EnableTcpReset" property set to true. ([#80624](https://github.com/kubernetes/kubernetes/pull/80624), [@xuto2](https://github.com/xuto2))
- Switch to VM Update call in attach/detach disk operation, original CreateOrUpdate call may lead to orphaned VMs or blocked resources ([#81208](https://github.com/kubernetes/kubernetes/pull/81208), [@andyzhangx](https://github.com/andyzhangx))
- Fix azure disk naming matching issue due to case sensitive comparison ([#81720](https://github.com/kubernetes/kubernetes/pull/81720), [@andyzhangx](https://github.com/andyzhangx))
- Fix retry issues when the nodes are under deleting on Azure ([#80419](https://github.com/kubernetes/kubernetes/pull/80419), [@feiskyer](https://github.com/feiskyer))
- Fix conflicted cache when the requests are canceled by other Azure operations. ([#81282](https://github.com/kubernetes/kubernetes/pull/81282), [@feiskyer](https://github.com/feiskyer))
- Fix make azure disk URI as case insensitive ([#79020](https://github.com/kubernetes/kubernetes/pull/79020), [@andyzhangx](https://github.com/andyzhangx))
- Fix VMSS LoadBalancer backend pools so that the network won't be broken when instances are upgraded to latest model ([#81411](https://github.com/kubernetes/kubernetes/pull/81411), [@nilo19](https://github.com/nilo19))
- Default resourceGroup should be used when the value of annotation azure-load-balancer-resource-group is an empty string. ([#79514](https://github.com/kubernetes/kubernetes/pull/79514), [@feiskyer](https://github.com/feiskyer))
- Kubelet could be run with no Azure identity without subscriptionId configured now.
  A sample cloud provider configure is: '{"vmType": "vmss", "useInstanceMetadata": true}'. ([#81500](https://github.com/kubernetes/kubernetes/pull/81500), [@feiskyer](https://github.com/feiskyer))
- Fix public IP not found issues for VMSS nodes ([#80703](https://github.com/kubernetes/kubernetes/pull/80703), [@feiskyer](https://github.com/feiskyer))
- Fix Azure client requests stuck issues on http.StatusTooManyRequests (HTTP Code 429). ([#81279](https://github.com/kubernetes/kubernetes/pull/81279), [@feiskyer](https://github.com/feiskyer))
- Add a service annotation `service.beta.kubernetes.io/azure-pip-name` to specify the public IP name for Azure load balancer. ([#81213](https://github.com/kubernetes/kubernetes/pull/81213), [@nilo19](https://github.com/nilo19))
- Optimize EC2 DescribeInstances API calls in aws cloud provider library by querying instance ID instead of EC2 filters when possible ([#78140](https://github.com/kubernetes/kubernetes/pull/78140), [@zhan849](https://github.com/zhan849))
- Creates an annotation `service.beta.kubernetes.io/aws-load-balancer-eip-allocations` to assign AWS EIP to the newly created Network Load Balancer. Number of allocations and subnets must match. ([#69263](https://github.com/kubernetes/kubernetes/pull/69263), [@brooksgarrett](https://github.com/brooksgarrett))
- Add an azure cloud configuration `LoadBalancerName` and `LoadBalancerResourceGroup` to allow the corresponding customizations of azure load balancer. ([#81054](https://github.com/kubernetes/kubernetes/pull/81054), [@nilo19](https://github.com/nilo19))

### Cluster Lifecycle

- Fix error handling and potential go null pointer exception in kubeadm upgrade diff ([#80648](https://github.com/kubernetes/kubernetes/pull/80648), [@odinuge](https://github.com/odinuge))
- kubeadm: fall back to client version in case of certain HTTP errors ([#80024](https://github.com/kubernetes/kubernetes/pull/80024), [@RainbowMango](https://github.com/RainbowMango))
- kubeadm: fix a potential panic if kubeadm discovers an invalid, existing kubeconfig file ([#79165](https://github.com/kubernetes/kubernetes/pull/79165), [@neolit123](https://github.com/neolit123))
- kubeadm: treat non-fatal errors as warnings when doing reset ([#80862](https://github.com/kubernetes/kubernetes/pull/80862), [@drpaneas](https://github.com/drpaneas))
- kubeadm: prevent PSP blocking of upgrade image prepull by using a non-root user ([#77792](https://github.com/kubernetes/kubernetes/pull/77792), [@neolit123](https://github.com/neolit123))
- kubeadm: fix "certificate-authority" files not being pre-loaded when using file discovery ([#80966](https://github.com/kubernetes/kubernetes/pull/80966), [@neolit123](https://github.com/neolit123))
- Add instruction to setup "Application Default Credentials" to run GCE Windows e2e tests locally. ([#81337](https://github.com/kubernetes/kubernetes/pull/81337), [@YangLu1031](https://github.com/YangLu1031))
- Fix error in `kubeadm join --discovery-file` when using discovery files with embedded credentials ([#80675](https://github.com/kubernetes/kubernetes/pull/80675), [@fabriziopandini](https://github.com/fabriziopandini))
- Fix remove the etcd member from the cluster during a kubeadm reset. ([#79326](https://github.com/kubernetes/kubernetes/pull/79326), [@bradbeam](https://github.com/bradbeam))
- kubeadm: the permissions of generated CSR files are changed from 0644 to 0600 ([#81217](https://github.com/kubernetes/kubernetes/pull/81217), [@SataQiu](https://github.com/SataQiu))
- kubeadm: avoid double deletion of the upgrade prepull DaemonSet ([#80798](https://github.com/kubernetes/kubernetes/pull/80798), [@xlgao-zju](https://github.com/xlgao-zju))
- kubeadm: introduce deterministic ordering for the certificates generation in the phase command `kubeadm init phase certs`. ([#78556](https://github.com/kubernetes/kubernetes/pull/78556), [@neolit123](https://github.com/neolit123))
- kubeadm: implement retry logic for certain ConfigMap failures when joining nodes ([#78915](https://github.com/kubernetes/kubernetes/pull/78915), [@ereslibre](https://github.com/ereslibre))
- kubeadm: use etcd's /health endpoint for a HTTP liveness probe on localhost instead of having a custom health check using etcdctl ([#81385](https://github.com/kubernetes/kubernetes/pull/81385), [@neolit123](https://github.com/neolit123))
- kubeadm reset: unmount directories under `/var/lib/kubelet` for Linux only ([#81494](https://github.com/kubernetes/kubernetes/pull/81494), [@Klaven](https://github.com/Klaven))
- kubeadm: fix the bug that `--cri-socket` flag does not work for `kubeadm reset` ([#79498](https://github.com/kubernetes/kubernetes/pull/79498), [@SataQiu](https://github.com/SataQiu))
- kubeadm: produce errors if they occur when resetting cluster status for a control-plane node ([#80573](https://github.com/kubernetes/kubernetes/pull/80573), [@bart0sh](https://github.com/bart0sh))
- Fix an error when using external etcd but storing etcd certificates in the same folder with the same name used by kubeadm for local etcd certificates; for an older version of kubeadm, the workaround is to avoid file name used by kubeadm for local etcd. ([#80867](https://github.com/kubernetes/kubernetes/pull/80867), [@fabriziopandini](https://github.com/fabriziopandini))
- `kubeadm join` fails if file-based discovery is too long, with a default timeout of 5 minutes. ([#80804](https://github.com/kubernetes/kubernetes/pull/80804), [@olivierlemasle](https://github.com/olivierlemasle))
- kubeadm: fixed ignoring errors when pulling control plane images ([#80529](https://github.com/kubernetes/kubernetes/pull/80529), [@bart0sh](https://github.com/bart0sh))
- Fix a bug in kube-addon-manager's leader election logic that made all replicas active. ([#80575](https://github.com/kubernetes/kubernetes/pull/80575), [@mborsz](https://github.com/mborsz))
- kubeadm: prevent overriding of certain kubelet security configuration parameters if the user wished to modify them ([#81903](https://github.com/kubernetes/kubernetes/pull/81903), [@jfbai](https://github.com/jfbai))
- kubeadm no longer performs IPVS checks as part of its preflight checks ([#81791](https://github.com/kubernetes/kubernetes/pull/81791), [@yastij](https://github.com/yastij))
- kubeadm: fix for HTTPProxy check for IPv6 addresses ([#82267](https://github.com/kubernetes/kubernetes/pull/82267), [@kad](https://github.com/kad))
- kubeadm: Allow users to skip the kube-proxy init addon phase during init and still be able to join a cluster and perform some other minor operations (but not upgrade). ([#82248](https://github.com/kubernetes/kubernetes/pull/82248), [@rosti](https://github.com/rosti))
- Mounts `/home/kubernetes/bin/nvidia/vulkan/icd.d` on the host to `/etc/vulkan/icd.d` inside containers requesting GPU. ([#78868](https://github.com/kubernetes/kubernetes/pull/78868), [@chardch](https://github.com/chardch))
- kubeadm: use the `--pod-network-cidr` flag to init or use the podSubnet field in the kubeadm config to pass a comma separated list of pod CIDRs. ([#79033](https://github.com/kubernetes/kubernetes/pull/79033), [@Arvinderpal](https://github.com/Arvinderpal))
- kubeadm: provide `--control-plane-endpoint` flag for `controlPlaneEndpoint` ([#79270](https://github.com/kubernetes/kubernetes/pull/79270), [@SataQiu](https://github.com/SataQiu))
- kubeadm: enable secure serving for the kube-scheduler ([#80951](https://github.com/kubernetes/kubernetes/pull/80951), [@neolit123](https://github.com/neolit123))
- kubeadm: print the stack trace of an error for klog level `--v>=5` ([#80937](https://github.com/kubernetes/kubernetes/pull/80937), [@neolit123](https://github.com/neolit123))
- Add `--kubernetes-version` to `kubeadm init phase certs ca` and `kubeadm init phase kubeconfig` ([#80115](https://github.com/kubernetes/kubernetes/pull/80115), [@gyuho](https://github.com/gyuho))
- kubeadm: support fetching configuration from the original cluster for `upgrade diff` ([#80025](https://github.com/kubernetes/kubernetes/pull/80025), [@SataQiu](https://github.com/SataQiu))
- When using the conformance test image, a new environment variable `E2E_USE_GO_RUNNER` will cause the tests to be run with the new golang-based test runner rather than the current bash wrapper. ([#79284](https://github.com/kubernetes/kubernetes/pull/79284), [@johnSchnake](https://github.com/johnSchnake))
- Implement a new feature that allows applying kustomize patches to static pod manifests generated by kubeadm. ([#80905](https://github.com/kubernetes/kubernetes/pull/80905), [@fabriziopandini](https://github.com/fabriziopandini))
- The 404 request handler for the GCE Ingress load balancer now exports prometheus metrics, including:

  - `http_404_request_total` (the number of 404 requests handled)
  - `http_404_request_duration_ms` (the amount of time the server took to respond in ms)

  Also includes percentile groupings. The directory for the default 404 handler includes instructions on how to enable prometheus for monitoring and setting alerts.
  ([#79106](https://github.com/kubernetes/kubernetes/pull/79106), [@vbannai](https://github.com/vbannai))

### Instrumentation

- Kibana has been slightly revamped/improved in the latest version ([#80421](https://github.com/kubernetes/kubernetes/pull/80421), [@lostick](https://github.com/lostick))

### Network

- Fix a string comparison bug in IPVS graceful termination where UDP real servers are not deleted. ([#78999](https://github.com/kubernetes/kubernetes/pull/78999), [@andrewsykim](https://github.com/andrewsykim))
- `kube-proxy --cleanup will` return the correct exit code if the cleanup was successful ([#78775](https://github.com/kubernetes/kubernetes/pull/78775), [@johscheuer](https://github.com/johscheuer))
- Fix a bug in the IPVS proxier where virtual servers are not cleaned up even though the corresponding Service object was deleted. ([#80942](https://github.com/kubernetes/kubernetes/pull/80942), [@gongguan](https://github.com/gongguan))
- kube-proxy waits for some duration for the node to be defined. ([#77167](https://github.com/kubernetes/kubernetes/pull/77167), [@paulsubrata55](https://github.com/paulsubrata55))
- Increase log level for graceful termination to `v=5` ([#80100](https://github.com/kubernetes/kubernetes/pull/80100), [@andrewsykim](https://github.com/andrewsykim))
- Reduce kube-proxy CPU usage in IPVS mode when a large number of nodePort services exist. ([#79444](https://github.com/kubernetes/kubernetes/pull/79444), [@cezarsa](https://github.com/cezarsa))
- Fix in kube-proxy for SCTP nodeport service which only works for node's InternalIP, but doesn't work for other IPs present in the node when ipvs is enabled. ([#81477](https://github.com/kubernetes/kubernetes/pull/81477), [@paulsubrata55](https://github.com/paulsubrata55))
- Ensure the `KUBE-MARK-DROP` chain in kube-proxy IPVS mode. The chain is ensured for both IPv4 and IPv6 in dual-stack operation. ([#82214](https://github.com/kubernetes/kubernetes/pull/82214), [@uablrek](https://github.com/uablrek))
- Introduce `node.kubernetes.io/exclude-balancer` and `node.kubernetes.io/exclude-disruption` labels in alpha to prevent cluster deployers from being dependent on the optional `node-role` labels which not all clusters may provide. ([#80238](https://github.com/kubernetes/kubernetes/pull/80238), [@smarterclayton](https://github.com/smarterclayton))
- If targetPort is changed that will process by service controller ([#77712](https://github.com/kubernetes/kubernetes/pull/77712), [@Sn0rt](https://github.com/Sn0rt))

### Node

- Remove PIDs cgroup controller requirement when related feature gates are disabled
  ([#79073](https://github.com/kubernetes/kubernetes/pull/79073), [@rafatio](https://github.com/rafatio))
- Fix kubelet NodeLease potential performance issues. Kubelet now will try to update lease using cached one instead of get from API Server every time. ([#81174](https://github.com/kubernetes/kubernetes/pull/81174), [@answer1991](https://github.com/answer1991))
- Passing an invalid policy name in the `--cpu-manager-policy` flag will now cause the kubelet to fail instead of simply ignoring the flag and running the `cpumanager`’s default policy instead. ([#80294](https://github.com/kubernetes/kubernetes/pull/80294), [@klueska](https://github.com/klueska))
- Make node lease renew interval more heuristic based on node-status-update-frequency in kubelet ([#80173](https://github.com/kubernetes/kubernetes/pull/80173), [@gaorong](https://github.com/gaorong))
- Kubelet should now more reliably report the same primary node IP even if the set of node IPs reported by the CloudProvider changes. ([#79391](https://github.com/kubernetes/kubernetes/pull/79391), [@danwinship](https://github.com/danwinship))
- Omit `nil` or empty field when calculating container hash value to avoid hash changed. For a new field with a non-nil default value in the container spec, the hash would still get changed. ([#57741](https://github.com/kubernetes/kubernetes/pull/57741), [@dixudx](https://github.com/dixudx))
- Fix a bug where kubelet would not retry pod sandbox creation when the restart policy of the pod is Never ([#79451](https://github.com/kubernetes/kubernetes/pull/79451), [@yujuhong](https://github.com/yujuhong))
- Limit the body length of exec readiness/liveness probes. remote CRIs and Docker shim read a max of 16MB output of which the exec probe itself inspects 10kb. ([#82514](https://github.com/kubernetes/kubernetes/pull/82514), [@dims](https://github.com/dims))
- Single static pod files and pod files from http endpoints cannot be larger than 10 MB. HTTP probe payloads are now truncated to 10KB. ([#82669](https://github.com/kubernetes/kubernetes/pull/82669), [@rphillips](https://github.com/rphillips))
- Introduce support for applying pod overhead to pod cgroups, if the PodOverhead feature is enabled. ([#79247](https://github.com/kubernetes/kubernetes/pull/79247), [@egernst](https://github.com/egernst))
- Node-Problem-Detector v0.7.1 is used on GCI ([#80726](https://github.com/kubernetes/kubernetes/pull/80726), [@wangzhen127](https://github.com/wangzhen127))
- Node-Problem-Detector v0.7.1 is used for addon daemonset. ([#82140](https://github.com/kubernetes/kubernetes/pull/82140), [@wangzhen127](https://github.com/wangzhen127))
- Enable cAdvisor ProcessMetrics collecting. ([#79002](https://github.com/kubernetes/kubernetes/pull/79002), [@jiayingz](https://github.com/jiayingz))
- kubelet: change `node-lease-renew-interval` to 0.25 of lease-renew-duration ([#80429](https://github.com/kubernetes/kubernetes/pull/80429), [@gaorong](https://github.com/gaorong))
- Attempt to set the kubelet's hostname & internal IP if `--cloud-provider=external` and no node addresses exists ([#75229](https://github.com/kubernetes/kubernetes/pull/75229), [@andrewsykim](https://github.com/andrewsykim))

### Scheduling

- Scheduler should terminate when it loses leader lock. ([#81306](https://github.com/kubernetes/kubernetes/pull/81306), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- If scheduler extender filtered a not found node, current scheduling round for this pod will just be skipped.
  ([#79641](https://github.com/kubernetes/kubernetes/pull/79641), [@yqwang-ms](https://github.com/yqwang-ms))
- Extender bind should respect IsInterested ([#79804](https://github.com/kubernetes/kubernetes/pull/79804), [@yqwang-ms](https://github.com/yqwang-ms))
- Fix an issue with toleration merging & whitelist checking in the PodTolerationRestriction admission controller. ([#81732](https://github.com/kubernetes/kubernetes/pull/81732), [@tallclair](https://github.com/tallclair))
- Add a helper function to decode scheduler plugin args. ([#80696](https://github.com/kubernetes/kubernetes/pull/80696), [@hex108](https://github.com/hex108))
- Fix filter plugins are not been called during preemption ([#81876](https://github.com/kubernetes/kubernetes/pull/81876), [@wgliang](https://github.com/wgliang))
- Fix an issue that the correct PluginConfig.Args is not passed to the corresponding PluginFactory in kube-scheduler when multiple PluginConfig items are defined. ([#82483](https://github.com/kubernetes/kubernetes/pull/82483), [@everpeace](https://github.com/everpeace))
- Take the context as the first argument of Schedule. ([#82119](https://github.com/kubernetes/kubernetes/pull/82119), [@wgliang](https://github.com/wgliang))
- Implement `post-filter` extension point for scheduling framework ([#78097](https://github.com/kubernetes/kubernetes/pull/78097), [@draveness](https://github.com/draveness))
- Add Bind extension point of the scheduling framework ([#78513](https://github.com/kubernetes/kubernetes/pull/78513), [@chenchun](https://github.com/chenchun))
- Add Filter extension point to the scheduling framework. ([#78477](https://github.com/kubernetes/kubernetes/pull/78477), [@YoubingLi](https://github.com/YoubingLi))
- Return error when the scoring plugin returns score out of range `[0, 100]`. ([#81015](https://github.com/kubernetes/kubernetes/pull/81015), [@draveness](https://github.com/draveness))
- Use a named array instead of a score array in normalizing-score phase. ([#80901](https://github.com/kubernetes/kubernetes/pull/80901), [@draveness](https://github.com/draveness))
- Updates the `requestedToCapacityRatioArguments` to add resources parameter that allows the users to specify the resource name along with weights for each resource to score nodes based on the request to capacity ratio. ([#77688](https://github.com/kubernetes/kubernetes/pull/77688), [@sudeshsh](https://github.com/sudeshsh))
- Add `UnschedulableAndUnresolvable` status code for scheduling framework ([#82034](https://github.com/kubernetes/kubernetes/pull/82034), [@alculquicondor](https://github.com/alculquicondor))
- Add normalize plugin extension point for the scheduling framework.
  ([#80383](https://github.com/kubernetes/kubernetes/pull/80383), [@liu-cong](https://github.com/liu-cong))
- Add Bind extension point to the scheduling framework. ([#79313](https://github.com/kubernetes/kubernetes/pull/79313), [@chenchun](https://github.com/chenchun))
- Add Score extension point to the scheduling framework. ([#79109](https://github.com/kubernetes/kubernetes/pull/79109), [@ahg-g](https://github.com/ahg-g))
- Add Pre-filter extension point to the scheduling framework. ([#78005](https://github.com/kubernetes/kubernetes/pull/78005), [@ahg-g](https://github.com/ahg-g))
- Add support for writing out of tree custom scheduler plugins. ([#78162](https://github.com/kubernetes/kubernetes/pull/78162), [@hex108](https://github.com/hex108))

### Storage

- Fix possible file descriptor leak and closing of dirs in `doSafeMakeDir` ([#79534](https://github.com/kubernetes/kubernetes/pull/79534), [@odinuge](https://github.com/odinuge))
- Azure disks of shared kind will no longer fail if they do not contain `skuname` or `storageaccounttype`. ([#80837](https://github.com/kubernetes/kubernetes/pull/80837), [@rmweir](https://github.com/rmweir))
- Fix CSI plugin supporting raw block that does not need attach mounted failed ([#79920](https://github.com/kubernetes/kubernetes/pull/79920), [@cwdsuzhou](https://github.com/cwdsuzhou))
- Reduces GCE PD Node Attach Limits by 1 since the node boot disk is considered an attachable disk ([#80923](https://github.com/kubernetes/kubernetes/pull/80923), [@davidz627](https://github.com/davidz627))
- Remove iSCSI volume storage cleartext secrets in logs ([#81215](https://github.com/kubernetes/kubernetes/pull/81215), [@zouyee](https://github.com/zouyee))
- Fixes validation of VolumeAttachment API objects created with inline volume sources. ([#80945](https://github.com/kubernetes/kubernetes/pull/80945), [@tedyu](https://github.com/tedyu))
- Changes timeout value in csi plugin from 15s to 2min which fixes the timeout issue ([#79529](https://github.com/kubernetes/kubernetes/pull/79529), [@andyzhangx](https://github.com/andyzhangx))
- Fix kubelet fail to delete orphaned pod directory when the kubelet's pods directory (default is `/var/lib/kubelet/pods`) symbolically links to another disk device's directory ([#79094](https://github.com/kubernetes/kubernetes/pull/79094), [@gaorong](https://github.com/gaorong))

## Testing

- Fix pod list return value of `framework.WaitForPodsWithLabelRunningReady` ([#78687](https://github.com/kubernetes/kubernetes/pull/78687), [@pohly](https://github.com/pohly))
- Adding `TerminationGracePeriodSeconds` to the test framework API ([#82170](https://github.com/kubernetes/kubernetes/pull/82170), [@vivekbagade](https://github.com/vivekbagade))
- `/test/e2e/framework`: Adds a flag `non-blocking-taints` which allows tests to run in environments with tainted nodes. String value should be a comma-separated list. ([#81043](https://github.com/kubernetes/kubernetes/pull/81043), [@johnSchnake](https://github.com/johnSchnake))
- Move CSI volume expansion to beta. ([#81467](https://github.com/kubernetes/kubernetes/pull/81467), [@bertinatto](https://github.com/bertinatto))
- Added E2E tests validating WindowsOptions.RunAsUserName. ([#79539](https://github.com/kubernetes/kubernetes/pull/79539), [@bclau](https://github.com/bclau))
- `framework.ExpectNoError` no longer logs the error and instead relies on using the new `log.Fail` as gomega fail handler. ([#80253](https://github.com/kubernetes/kubernetes/pull/80253), [@pohly](https://github.com/pohly))

### Windows

- On Windows systems, `%USERPROFILE%` is now preferred over `%HOMEDRIVE%\%HOMEPATH%` as the home folder if `%HOMEDRIVE%\%HOMEPATH%` does not contain a `.kube\config` file, and `%USERPROFILE%` exists and is writable. ([#73923](https://github.com/kubernetes/kubernetes/pull/73923), [@liggitt](https://github.com/liggitt))
- Add support for AWS EBS on windows ([#79552](https://github.com/kubernetes/kubernetes/pull/79552), [@wongma7](https://github.com/wongma7))
- Support Kubelet plugin watcher on Windows nodes. ([#81397](https://github.com/kubernetes/kubernetes/pull/81397), [@ddebroy](https://github.com/ddebroy))

## Dependencies

### Changed

- the default Go version was updated to v1.12.9. ([#78958](https://github.com/kubernetes/kubernetes/pull/78958), [#79966](https://github.com/kubernetes/kubernetes/pull/79966), [#81390](https://github.com/kubernetes/kubernetes/pull/81390), [#81489](https://github.com/kubernetes/kubernetes/pull/81489))
- etcd has been updated to v3.3.15 ([#82199](https://github.com/kubernetes/kubernetes/pull/82199), [@dims](https://github.com/dims))
- CoreDNS for kubeadm and kube-up has been updated to v1.6.2 ([#82127](https://github.com/kubernetes/kubernetes/pull/82127))
- Cluster Autoscaler has been updated to v1.16.0 ([#82501](https://github.com/kubernetes/kubernetes/pull/82501), [@losipiuk](https://github.com/losipiuk))
- fluentd has been updated to v1.5.1 ([#79014](https://github.com/kubernetes/kubernetes/pull/79014))
- fluentd-elasticsearch plugin has been updated to v3.5.3 ([#79014](https://github.com/kubernetes/kubernetes/pull/79014))
- elasticsearch has been updated to v7.1.1 ([#79014](https://github.com/kubernetes/kubernetes/pull/79014))
- kibana has been updated to v7.1.1 ([#79014](https://github.com/kubernetes/kubernetes/pull/79014))
- Azure SDK and go-autorest API versions have been updated ([#79574](https://github.com/kubernetes/kubernetes/pull/79574))
- Azure API versions have been updated (container registry to 2018-09-01, network to 2018-08-01) ([#79583](https://github.com/kubernetes/kubernetes/pull/79583))
- kube-addon-manager has been updated to v9.0.2 ([#80861](https://github.com/kubernetes/kubernetes/pull/80861))
- golang/x/net has been updated to bring in fixes for CVE-2019-9512, CVE-2019-9514 ([#81394](https://github.com/kubernetes/kubernetes/pull/81394))
- GCE windows node image has been updated. ([#81106](https://github.com/kubernetes/kubernetes/pull/81106))
- portworx plugin has been updated on libopenstorage/openstorage to v1.0.0 ([#80495](https://github.com/kubernetes/kubernetes/pull/80495))
- metrics-server has been updated to v0.3.4 ([#82322](https://github.com/kubernetes/kubernetes/pull/82322), [@olagacek](https://github.com/olagacek))
- klog has been updated to v0.4.0 ([#81164](https://github.com/kubernetes/kubernetes/pull/81164))

### Unchanged

- The list of validated docker versions remains unchanged.
  - The current list is 1.13.1, 17.03, 17.06, 17.09, 18.06, 18.09. ([#72823](https://github.com/kubernetes/kubernetes/pull/72823), [#72831](https://github.com/kubernetes/kubernetes/pull/72831))
- CNI remains unchanged at v0.7.5. ([#75455](https://github.com/kubernetes/kubernetes/pull/75455))
- cri-tools remains unchanged at v1.14.0. ([#75658](https://github.com/kubernetes/kubernetes/pull/75658))
- CAdvisor remains unchanged at v0.33.2. ([#76291](https://github.com/kubernetes/kubernetes/pull/76291))
- event-exporter remains unchanged at v0.2.5. ([#77815](https://github.com/kubernetes/kubernetes/pull/77815))
- ip-masq-agent remains unchanged at v2.4.1. ([#77844](https://github.com/kubernetes/kubernetes/pull/77844))
- k8s-dns-node-cache remains unchanged at v1.15.1 ([#76640](https://github.com/kubernetes/kubernetes/pull/76640), [@george-angel](https://github.com/george-angel))
- CSI remains unchanged at to v1.1.0. ([#75391](https://github.com/kubernetes/kubernetes/pull/75391))
- The dashboard add-on remains unchanged at v1.10.1. ([#72495](https://github.com/kubernetes/kubernetes/pull/72495))
- kube-dns is unchanged at v1.14.13 as of Kubernetes 1.12. ([#68900](https://github.com/kubernetes/kubernetes/pull/68900))
- Influxdb is unchanged at v1.3.3 as of Kubernetes 1.10. ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Grafana is unchanged at v4.4.3 as of Kubernetes 1.10. ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- The fluent-plugin-kubernetes_metadata_filter plugin in fluentd-elasticsearch is unchanged at v2.1.6. ([#71180](https://github.com/kubernetes/kubernetes/pull/71180))
- fluentd-gcp is unchanged at v3.2.0 as of Kubernetes 1.13. ([#70954](https://github.com/kubernetes/kubernetes/pull/70954))
- OIDC authentication is unchanged at coreos/go-oidc v2 as of Kubernetes 1.10. ([#58544](https://github.com/kubernetes/kubernetes/pull/58544))
- Calico is unchanged at v3.3.1 as of Kubernetes 1.13. ([#70932](https://github.com/kubernetes/kubernetes/pull/70932))
- GLBC remains unchanged at v1.2.3 as of Kubernetes 1.12. ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- Ingress-gce remains unchanged at v1.2.3 as of Kubernetes 1.12. ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))

### Removed

- Remove deprecated github.com/kardianos/osext dependency ([#80142](https://github.com/kubernetes/kubernetes/pull/80142))

### Detailed go Dependency Changes

#### Added

- github.com/Azure/go-autorest/autorest/adal: [v0.5.0](https://github.com/Azure/go-autorest/autorest/adal/tree/v0.5.0)
- github.com/Azure/go-autorest/autorest/date: [v0.1.0](https://github.com/Azure/go-autorest/autorest/date/tree/v0.1.0)
- github.com/Azure/go-autorest/autorest/mocks: [v0.2.0](https://github.com/Azure/go-autorest/autorest/mocks/tree/v0.2.0)
- github.com/Azure/go-autorest/autorest/to: [v0.2.0](https://github.com/Azure/go-autorest/autorest/to/tree/v0.2.0)
- github.com/Azure/go-autorest/autorest/validation: [v0.1.0](https://github.com/Azure/go-autorest/autorest/validation/tree/v0.1.0)
- github.com/Azure/go-autorest/autorest: [v0.9.0](https://github.com/Azure/go-autorest/autorest/tree/v0.9.0)
- github.com/Azure/go-autorest/logger: [v0.1.0](https://github.com/Azure/go-autorest/logger/tree/v0.1.0)
- github.com/Azure/go-autorest/tracing: [v0.5.0](https://github.com/Azure/go-autorest/tracing/tree/v0.5.0)
- github.com/armon/consul-api: [eb2c6b5](https://github.com/armon/consul-api/tree/eb2c6b5)
- github.com/bifurcation/mint: [93c51c6](https://github.com/bifurcation/mint/tree/93c51c6)
- github.com/caddyserver/caddy: [v1.0.3](https://github.com/caddyserver/caddy/tree/v1.0.3)
- github.com/cenkalti/backoff: [v2.1.1+incompatible](https://github.com/cenkalti/backoff/tree/v2.1.1)
- github.com/checkpoint-restore/go-criu: [bdb7599](https://github.com/checkpoint-restore/go-criu/tree/bdb7599)
- github.com/cheekybits/genny: [9127e81](https://github.com/cheekybits/genny/tree/9127e81)
- github.com/coredns/corefile-migration: [v1.0.2](https://github.com/coredns/corefile-migration/tree/v1.0.2)
- github.com/coreos/go-etcd: [v2.0.0+incompatible](https://github.com/coreos/go-etcd/tree/v2.0.0)
- github.com/dustin/go-humanize: [v1.0.0](https://github.com/dustin/go-humanize/tree/v1.0.0)
- github.com/fatih/color: [v1.6.0](https://github.com/fatih/color/tree/v1.6.0)
- github.com/flynn/go-shlex: [3f9db97](https://github.com/flynn/go-shlex/tree/3f9db97)
- github.com/go-acme/lego: [v2.5.0+incompatible](https://github.com/go-acme/lego/tree/v2.5.0)
- github.com/go-bindata/go-bindata: [v3.1.1+incompatible](https://github.com/go-bindata/go-bindata/tree/v3.1.1)
- github.com/go-logr/logr: [v0.1.0](https://github.com/go-logr/logr/tree/v0.1.0)
- github.com/google/martian: [v2.1.0+incompatible](https://github.com/google/martian/tree/v2.1.0)
- github.com/google/pprof: [3ea8567](https://github.com/google/pprof/tree/3ea8567)
- github.com/google/renameio: [v0.1.0](https://github.com/google/renameio/tree/v0.1.0)
- github.com/googleapis/gax-go/v2: [v2.0.4](https://github.com/googleapis/gax-go/v2/tree/v2.0.4)
- github.com/hashicorp/go-syslog: [v1.0.0](https://github.com/hashicorp/go-syslog/tree/v1.0.0)
- github.com/jimstudt/http-authentication: [3eca13d](https://github.com/jimstudt/http-authentication/tree/3eca13d)
- github.com/kisielk/errcheck: [v1.2.0](https://github.com/kisielk/errcheck/tree/v1.2.0)
- github.com/kisielk/gotool: [v1.0.0](https://github.com/kisielk/gotool/tree/v1.0.0)
- github.com/klauspost/cpuid: [v1.2.0](https://github.com/klauspost/cpuid/tree/v1.2.0)
- github.com/kr/pty: [v1.1.5](https://github.com/kr/pty/tree/v1.1.5)
- github.com/kylelemons/godebug: [d65d576](https://github.com/kylelemons/godebug/tree/d65d576)
- github.com/lucas-clemente/aes12: [cd47fb3](https://github.com/lucas-clemente/aes12/tree/cd47fb3)
- github.com/lucas-clemente/quic-clients: [v0.1.0](https://github.com/lucas-clemente/quic-clients/tree/v0.1.0)
- github.com/lucas-clemente/quic-go-certificates: [d2f8652](https://github.com/lucas-clemente/quic-go-certificates/tree/d2f8652)
- github.com/lucas-clemente/quic-go: [v0.10.2](https://github.com/lucas-clemente/quic-go/tree/v0.10.2)
- github.com/marten-seemann/qtls: [v0.2.3](https://github.com/marten-seemann/qtls/tree/v0.2.3)
- github.com/mattn/go-colorable: [v0.0.9](https://github.com/mattn/go-colorable/tree/v0.0.9)
- github.com/mattn/go-isatty: [v0.0.3](https://github.com/mattn/go-isatty/tree/v0.0.3)
- github.com/mholt/certmagic: [6a42ef9](https://github.com/mholt/certmagic/tree/6a42ef9)
- github.com/mitchellh/go-homedir: [v1.1.0](https://github.com/mitchellh/go-homedir/tree/v1.1.0)
- github.com/naoina/go-stringutil: [v0.1.0](https://github.com/naoina/go-stringutil/tree/v0.1.0)
- github.com/naoina/toml: [v0.1.1](https://github.com/naoina/toml/tree/v0.1.1)
- github.com/rogpeppe/go-internal: [v1.3.0](https://github.com/rogpeppe/go-internal/tree/v1.3.0)
- github.com/thecodeteam/goscaleio: [v0.1.0](https://github.com/thecodeteam/goscaleio/tree/v0.1.0)
- github.com/ugorji/go/codec: [d75b2dc](https://github.com/ugorji/go/codec/tree/d75b2dc)
- github.com/xordataexchange/crypt: [b2862e3](https://github.com/xordataexchange/crypt/tree/b2862e3)
- go.opencensus.io: v0.21.0
- golang.org/x/mod: 4bf6d31
- gopkg.in/airbrake/gobrake.v2: v2.0.9
- gopkg.in/errgo.v2: v2.1.0
- gopkg.in/gemnasium/logrus-airbrake-hook.v2: v2.1.2
- gopkg.in/mcuadros/go-syslog.v2: v2.2.1
- gotest.tools/gotestsum: v0.3.5
- honnef.co/go/tools: v0.0.1-2019.2.2

#### Changed

- cloud.google.com/go: v0.34.0 → v0.38.0
- github.com/Azure/azure-sdk-for-go: [v21.4.0+incompatible → v32.5.0+incompatible](https://github.com/Azure/azure-sdk-for-go/compare/v21.4.0...v32.5.0)
- github.com/BurntSushi/toml: [v0.3.0 → v0.3.1](https://github.com/BurntSushi/toml/compare/v0.3.0...v0.3.1)
- github.com/GoogleCloudPlatform/k8s-cloud-provider: [f8e9959 → 27a4ced](https://github.com/GoogleCloudPlatform/k8s-cloud-provider/compare/f8e9959...27a4ced)
- github.com/PuerkitoBio/purell: [v1.1.0 → v1.1.1](https://github.com/PuerkitoBio/purell/compare/v1.1.0...v1.1.1)
- github.com/asaskevich/govalidator: [f9ffefc → f61b66f](https://github.com/asaskevich/govalidator/compare/f9ffefc...f61b66f)
- github.com/client9/misspell: [9ce5d97 → v0.3.4](https://github.com/client9/misspell/compare/9ce5d97...v0.3.4)
- github.com/containernetworking/cni: [v0.6.0 → v0.7.1](https://github.com/containernetworking/cni/compare/v0.6.0...v0.7.1)
- github.com/coreos/etcd: [v3.3.13+incompatible → v3.3.15+incompatible](https://github.com/coreos/etcd/compare/v3.3.13...v3.3.15)
- github.com/coreos/go-oidc: [065b426 → v2.1.0+incompatible](https://github.com/coreos/go-oidc/compare/065b426...v2.1.0)
- github.com/coreos/go-semver: [e214231 → v0.3.0](https://github.com/coreos/go-semver/compare/e214231...v0.3.0)
- github.com/cpuguy83/go-md2man: [v1.0.4 → v1.0.10](https://github.com/cpuguy83/go-md2man/compare/v1.0.4...v1.0.10)
- github.com/cyphar/filepath-securejoin: [ae69057 → v0.2.2](https://github.com/cyphar/filepath-securejoin/compare/ae69057...v0.2.2)
- github.com/dgrijalva/jwt-go: [01aeca5 → v3.2.0+incompatible](https://github.com/dgrijalva/jwt-go/compare/01aeca5...v3.2.0)
- github.com/docker/distribution: [edc3ab2 → v2.7.1+incompatible](https://github.com/docker/distribution/compare/edc3ab2...v2.7.1)
- github.com/emicklei/go-restful: [ff4f55a → v2.9.5+incompatible](https://github.com/emicklei/go-restful/compare/ff4f55a...v2.9.5)
- github.com/evanphx/json-patch: [5858425 → v4.2.0+incompatible](https://github.com/evanphx/json-patch/compare/5858425...v4.2.0)
- github.com/fatih/camelcase: [f6a740d → v1.0.0](https://github.com/fatih/camelcase/compare/f6a740d...v1.0.0)
- github.com/go-openapi/analysis: [v0.17.2 → v0.19.2](https://github.com/go-openapi/analysis/compare/v0.17.2...v0.19.2)
- github.com/go-openapi/errors: [v0.17.2 → v0.19.2](https://github.com/go-openapi/errors/compare/v0.17.2...v0.19.2)
- github.com/go-openapi/jsonpointer: [v0.19.0 → v0.19.2](https://github.com/go-openapi/jsonpointer/compare/v0.19.0...v0.19.2)
- github.com/go-openapi/jsonreference: [v0.19.0 → v0.19.2](https://github.com/go-openapi/jsonreference/compare/v0.19.0...v0.19.2)
- github.com/go-openapi/loads: [v0.17.2 → v0.19.2](https://github.com/go-openapi/loads/compare/v0.17.2...v0.19.2)
- github.com/go-openapi/runtime: [v0.17.2 → v0.19.0](https://github.com/go-openapi/runtime/compare/v0.17.2...v0.19.0)
- github.com/go-openapi/spec: [v0.17.2 → v0.19.2](https://github.com/go-openapi/spec/compare/v0.17.2...v0.19.2)
- github.com/go-openapi/strfmt: [v0.17.0 → v0.19.0](https://github.com/go-openapi/strfmt/compare/v0.17.0...v0.19.0)
- github.com/go-openapi/swag: [v0.17.2 → v0.19.2](https://github.com/go-openapi/swag/compare/v0.17.2...v0.19.2)
- github.com/go-openapi/validate: [v0.18.0 → v0.19.2](https://github.com/go-openapi/validate/compare/v0.18.0...v0.19.2)
- github.com/godbus/dbus: [c7fdd8b → v4.1.0+incompatible](https://github.com/godbus/dbus/compare/c7fdd8b...v4.1.0)
- github.com/gogo/protobuf: [342cbe0 → 65acae2](https://github.com/gogo/protobuf/compare/342cbe0...65acae2)
- github.com/golang/mock: [bd3c8e8 → v1.2.0](https://github.com/golang/mock/compare/bd3c8e8...v1.2.0)
- github.com/golang/protobuf: [v1.2.0 → v1.3.1](https://github.com/golang/protobuf/compare/v1.2.0...v1.3.1)
- github.com/google/btree: [7d79101 → 4030bb1](https://github.com/google/btree/compare/7d79101...4030bb1)
- github.com/google/cadvisor: [9db8c7d → v0.34.0](https://github.com/google/cadvisor/compare/9db8c7d...v0.34.0)
- github.com/google/gofuzz: [24818f7 → v1.0.0](https://github.com/google/gofuzz/compare/24818f7...v1.0.0)
- github.com/google/uuid: [v1.0.0 → v1.1.1](https://github.com/google/uuid/compare/v1.0.0...v1.1.1)
- github.com/gophercloud/gophercloud: [c818fa6 → v0.1.0](https://github.com/gophercloud/gophercloud/compare/c818fa6...v0.1.0)
- github.com/gorilla/websocket: [4201258 → v1.4.0](https://github.com/gorilla/websocket/compare/4201258...v1.4.0)
- github.com/grpc-ecosystem/go-grpc-prometheus: [2500245 → v1.2.0](https://github.com/grpc-ecosystem/go-grpc-prometheus/compare/2500245...v1.2.0)
- github.com/hashicorp/golang-lru: [v0.5.0 → v0.5.1](https://github.com/hashicorp/golang-lru/compare/v0.5.0...v0.5.1)
- github.com/hashicorp/hcl: [d8c773c → v1.0.0](https://github.com/hashicorp/hcl/compare/d8c773c...v1.0.0)
- github.com/heketi/heketi: [558b292 → v9.0.0+incompatible](https://github.com/heketi/heketi/compare/558b292...v9.0.0)
- github.com/jonboulle/clockwork: [72f9bd7 → v0.1.0](https://github.com/jonboulle/clockwork/compare/72f9bd7...v0.1.0)
- github.com/json-iterator/go: [ab8a2e0 → v1.1.7](https://github.com/json-iterator/go/compare/ab8a2e0...v1.1.7)
- github.com/kr/pretty: [f31442d → v0.1.0](https://github.com/kr/pretty/compare/f31442d...v0.1.0)
- github.com/kr/text: [6807e77 → v0.1.0](https://github.com/kr/text/compare/6807e77...v0.1.0)
- github.com/libopenstorage/openstorage: [093a0c3 → v1.0.0](https://github.com/libopenstorage/openstorage/compare/093a0c3...v1.0.0)
- github.com/magiconair/properties: [61b492c → v1.8.1](https://github.com/magiconair/properties/compare/61b492c...v1.8.1)
- github.com/mailru/easyjson: [60711f1 → 94de47d](https://github.com/mailru/easyjson/compare/60711f1...94de47d)
- github.com/mattn/go-shellwords: [f8471b0 → v1.0.5](https://github.com/mattn/go-shellwords/compare/f8471b0...v1.0.5)
- github.com/miekg/dns: [5d001d0 → v1.1.4](https://github.com/miekg/dns/compare/5d001d0...v1.1.4)
- github.com/mistifyio/go-zfs: [1b4ae6f → v2.1.1+incompatible](https://github.com/mistifyio/go-zfs/compare/1b4ae6f...v2.1.1)
- github.com/mitchellh/go-wordwrap: [ad45545 → v1.0.0](https://github.com/mitchellh/go-wordwrap/compare/ad45545...v1.0.0)
- github.com/mvdan/xurls: [1b768d7 → v1.1.0](https://github.com/mvdan/xurls/compare/1b768d7...v1.1.0)
- github.com/onsi/ginkgo: [v1.6.0 → v1.8.0](https://github.com/onsi/ginkgo/compare/v1.6.0...v1.8.0)
- github.com/onsi/gomega: [5533ce8 → v1.5.0](https://github.com/onsi/gomega/compare/5533ce8...v1.5.0)
- github.com/opencontainers/go-digest: [a6d0ee4 → v1.0.0-rc1](https://github.com/opencontainers/go-digest/compare/a6d0ee4...v1.0.0-rc1)
- github.com/opencontainers/image-spec: [372ad78 → v1.0.1](https://github.com/opencontainers/image-spec/compare/372ad78...v1.0.1)
- github.com/opencontainers/runc: [f000fe1 → 6cc5158](https://github.com/opencontainers/runc/compare/f000fe1...6cc5158)
- github.com/opencontainers/selinux: [4a2974b → v1.2.2](https://github.com/opencontainers/selinux/compare/4a2974b...v1.2.2)
- github.com/robfig/cron: [df38d32 → v1.1.0](https://github.com/robfig/cron/compare/df38d32...v1.1.0)
- github.com/russross/blackfriday: [300106c → v1.5.2](https://github.com/russross/blackfriday/compare/300106c...v1.5.2)
- github.com/seccomp/libseccomp-golang: [1b506fc → v0.9.1](https://github.com/seccomp/libseccomp-golang/compare/1b506fc...v0.9.1)
- github.com/sirupsen/logrus: [v1.2.0 → v1.4.2](https://github.com/sirupsen/logrus/compare/v1.2.0...v1.4.2)
- github.com/spf13/afero: [b28a7ef → v1.2.2](https://github.com/spf13/afero/compare/b28a7ef...v1.2.2)
- github.com/spf13/cast: [e31f36f → v1.3.0](https://github.com/spf13/cast/compare/e31f36f...v1.3.0)
- github.com/spf13/cobra: [c439c4f → v0.0.5](https://github.com/spf13/cobra/compare/c439c4f...v0.0.5)
- github.com/spf13/jwalterweatherman: [33c24e7 → v1.1.0](https://github.com/spf13/jwalterweatherman/compare/33c24e7...v1.1.0)
- github.com/spf13/pflag: [v1.0.1 → v1.0.3](https://github.com/spf13/pflag/compare/v1.0.1...v1.0.3)
- github.com/spf13/viper: [7fb2782 → v1.3.2](https://github.com/spf13/viper/compare/7fb2782...v1.3.2)
- github.com/stretchr/objx: [v0.1.1 → v0.2.0](https://github.com/stretchr/objx/compare/v0.1.1...v0.2.0)
- github.com/stretchr/testify: [v1.2.2 → v1.3.0](https://github.com/stretchr/testify/compare/v1.2.2...v1.3.0)
- golang.org/x/net: 65e2d4e → cdfb69a
- golang.org/x/tools: aa82965 → 6e04913
- google.golang.org/api: 583d854 → 5213b80
- google.golang.org/genproto: 09f6ed2 → 54afdca
- google.golang.org/grpc: v1.13.0 → v1.23.0
- gopkg.in/check.v1: 20d25e2 → 788fd78
- gopkg.in/natefinch/lumberjack.v2: 20b71e5 → v2.0.0
- gopkg.in/square/go-jose.v2: 89060de → v2.2.2
- gopkg.in/yaml.v2: v2.2.1 → v2.2.2
- k8s.io/gengo: f8a0810 → 26a6646
- k8s.io/klog: v0.3.1 → v0.4.0
- k8s.io/kube-openapi: b3a7cee → 743ec37
- k8s.io/utils: c2654d5 → 581e001
- sigs.k8s.io/structured-merge-diff: e85c7b2 → 6149e45

#### Removed

- github.com/Azure/go-autorest: [v11.1.2+incompatible](https://github.com/Azure/go-autorest/tree/v11.1.2)
- github.com/codedellemc/goscaleio: [20e2ce2](https://github.com/codedellemc/goscaleio/tree/20e2ce2)
- github.com/d2g/dhcp4: [a1d1b6c](https://github.com/d2g/dhcp4/tree/a1d1b6c)
- github.com/d2g/dhcp4client: [6e570ed](https://github.com/d2g/dhcp4client/tree/6e570ed)
- github.com/jteeuwen/go-bindata: [a0ff256](https://github.com/jteeuwen/go-bindata/tree/a0ff256)
- github.com/kardianos/osext: [8fef92e](https://github.com/kardianos/osext/tree/8fef92e)
- github.com/kr/fs: [2788f0d](https://github.com/kr/fs/tree/2788f0d)
- github.com/marstr/guid: [8bdf7d1](https://github.com/marstr/guid/tree/8bdf7d1)
- github.com/mholt/caddy: [2de4950](https://github.com/mholt/caddy/tree/2de4950)
- github.com/natefinch/lumberjack: [v2.0.0+incompatible](https://github.com/natefinch/lumberjack/tree/v2.0.0)
- github.com/pkg/sftp: [4d0e916](https://github.com/pkg/sftp/tree/4d0e916)
- github.com/shurcooL/sanitized_anchor_name: [10ef21a](https://github.com/shurcooL/sanitized_anchor_name/tree/10ef21a)
- github.com/sigma/go-inotify: [c87b6cf](https://github.com/sigma/go-inotify/tree/c87b6cf)
- github.com/vmware/photon-controller-go-sdk: [4a435da](https://github.com/vmware/photon-controller-go-sdk/tree/4a435da)
- github.com/xanzy/go-cloudstack: [1e2cbf6](https://github.com/xanzy/go-cloudstack/tree/1e2cbf6)
- gopkg.in/yaml.v1: 9f9df34
