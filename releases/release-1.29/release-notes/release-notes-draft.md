## What's New (Major Themes)

Major themes for Kubernetes v1.29 _Mandala (The Universe)_ have been published in the [release announcement](https://kubernetes.io/blog/2023/12/13/kubernetes-v1-29-release/), which also contains additional information on the release.

## Known Issues

### Evented PLEG beta feature (disabled by default) has a critical bug

The Evented PLEG (Pod Lifecycle Event Generator ) feature is disabled by default, and additional care is recommended when enabling it: when enabled, a [bug](https://github.com/kubernetes/kubernetes/issues/121349) affecting pods (and especially static pods) can have a critical impact on cluster health.

### Feature gate `SchedulerQueueingHints` is disabled by default

[An issue was found](https://github.com/kubernetes/kubernetes/pull/122285) in the `beta` feature `SchedulingHint`, and to mitigate it the feature was changed to `disabled` by default in this release. It can be manually enabled, in which case it's possible that the identified behavior (pods pending for 5 minutes, even though the cluster can accomodate them) manifests itself.

## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

- Stopped accepting component configuration for `kube-proxy` and `kubelet` during `kubeadm upgrade plan --config`. This was a legacy behavior that was not well supported for upgrades and could be used only at the plan stage to determine if the configuration for these components stored in the cluster needs manual version migration. In the future, `kubeadm` will attempt alternative component config migration approaches. ([#120788](https://github.com/kubernetes/kubernetes/pull/120788), [@chendave](https://github.com/chendave))
 - `kubeadm`: a separate `super-admin.conf` file is now deployed. The User in `admin.conf` is now bound to a new RBAC Group `kubeadm:cluster-admins` that has `cluster-admin` `ClusterRole` access. The User in `super-admin.conf` is now bound to the `system:masters` built-in super-powers / break-glass Group that can bypass RBAC. Before this change, the default `admin.conf` was bound to `system:masters` Group, which was undesired. Executing `kubeadm init phase kubeconfig all` or just `kubeadm init` will now generate the new `super-admin.conf` file. The cluster admin can then decide to keep the file present on a node host or move it to a safe location. `kubadm certs renew` will renew the certificate in `super-admin.conf` to one year if the file exists; if it does not exist a "MISSING" note will be printed. `kubeadm upgrade apply` for this release will migrate this particular node to the two file setup. Subsequent kubeadm releases will continue to optionally renew the certificate in `super-admin.conf` if the file exists on disk and if renew on upgrade is not disabled. `kubeadm join --control-plane` will now generate only an `admin.conf` file that has the less privileged User. ([#121305](https://github.com/kubernetes/kubernetes/pull/121305), [@neolit123](https://github.com/neolit123))
- In-tree cloud provider integrations are now switched off by default. This change will require that users who are currently using in-tree cloud provider integrations (Azure, GCE, or vSphere) enable external cloud controller managers, or opt in to the legacy integration by setting the associated feature gates to  `false`. For more information about how to enable and run external cloud controller managers, read [Cloud Controller Manager Administration](https://kubernetes.io/docs/tasks/administer-cluster/running-cloud-controller/) and [Migrate Replicated Control Plane To Use Cloud Controller Manager](https://kubernetes.io/docs/tasks/administer-cluster/controller-manager-leader-migration/). ([#117503](https://github.com/kubernetes/kubernetes/pull/117503), [@dims](https://github.com/dims))

## Changes by Kind

### Deprecation

- #### Additional documentation e.g., KEPs (Kubernetes Enhancement Proposals), usage docs, etc.:

- The `flowcontrol.apiserver.k8s.io/v1beta2` API version of `FlowSchema` and `PriorityLevelConfiguration` is no longer served in `v1.29`. Migrate manifests and API clients to use the `flowcontrol.apiserver.k8s.io/v1beta3` API version, available since `v1.26`. More information is at https://kubernetes.io/docs/reference/using-api/deprecation-guide/#flowcontrol-resources-v129. ([#119495](https://github.com/kubernetes/kubernetes/pull/119495), [@bzsuni](https://github.com/bzsuni))
- Creation of new `CronJob` objects containing `TZ` or `CRON_TZ` in `.spec.schedule`, accidentally enabled in `v1.22`, is now disallowed. Use the `.spec.timeZone` field instead, supported in `v1.25+` clusters in default configurations. See https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#unsupported-timezone-specification for more information. ([#116252](https://github.com/kubernetes/kubernetes/pull/116252), [@soltysh](https://github.com/soltysh))
- Removed the networking `alpha` API `ClusterCIDR`. ([#121229](https://github.com/kubernetes/kubernetes/pull/121229), [@aojea](https://github.com/aojea))

### API Change

- `kube-apiserver`: added `--authentication-config` flag for reading `AuthenticationConfiguration`
  files. `--authentication-config` flag is mutually exclusive with the existing `--oidc-*`
  flags. ([#119142](https://github.com/kubernetes/kubernetes/pull/119142), [@aramase](https://github.com/aramase))
- `kube-scheduler` component config (`KubeSchedulerConfiguration`) `kubescheduler.config.k8s.io/v1beta3`
  is removed in `v1.29`. Migrated `kube-scheduler` configuration files to `kubescheduler.config.k8s.io/v1`. ([#119994](https://github.com/kubernetes/kubernetes/pull/119994), [@SataQiu](https://github.com/SataQiu))
- A new sleep action for the `PreStop` lifecycle hook was added, allowing containers to pause for a specified duration before termination. ([#119026](https://github.com/kubernetes/kubernetes/pull/119026), [@AxeZhan](https://github.com/AxeZhan))
- Added CEL expressions to `v1alpha1 AuthenticationConfiguration`. ([#121078](https://github.com/kubernetes/kubernetes/pull/121078), [@aramase](https://github.com/aramase))
- Added Windows support for InPlace Pod Vertical Scaling feature. ([#112599](https://github.com/kubernetes/kubernetes/pull/112599), [@fabi200123](https://github.com/fabi200123)) [SIG Autoscaling, Node, Scalability, Scheduling and Windows]
- Added `ImageMaximumGCAge` field to kubelet configuration, which allows a user to set the maximum age an image is unused before it's garbage collected. ([#121275](https://github.com/kubernetes/kubernetes/pull/121275), [@haircommander](https://github.com/haircommander))
- Added `UserNamespacesPodSecurityStandards` feature gate to enable user namespace support for Pod Security Standards.
  Enabling this feature will modify all Pod Security Standard rules to allow setting: `spec[.*].securityContext.[runAsNonRoot,runAsUser]`.
  This feature gate should only be enabled if all nodes in the cluster support the user namespace feature and have it enabled.
  The feature gate will not graduate or be enabled by default in future Kubernetes releases. ([#118760](https://github.com/kubernetes/kubernetes/pull/118760), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery, Auth, Node and Release]
- Added `optionalOldSelf` to `x-kubernetes-validations` to support ratcheting CRD schema constraints. ([#121034](https://github.com/kubernetes/kubernetes/pull/121034), [@alexzielenski](https://github.com/alexzielenski))
- Added a new `ServiceCIDR` type that allows to dynamically configure the cluster range used to allocate `Service ClusterIPs` addresses. ([#116516](https://github.com/kubernetes/kubernetes/pull/116516), [@aojea](https://github.com/aojea))
- Added a new `ipMode` field to the `.status` of Services where `type` is set to `LoadBalancer`.
  The new field is behind the `LoadBalancerIPMode` feature gate. ([#119937](https://github.com/kubernetes/kubernetes/pull/119937), [@RyanAoh](https://github.com/RyanAoh)) [SIG API Machinery, Apps, Cloud Provider, Network and Testing]
- Added options for configuring `nf_conntrack_udp_timeout`, and `nf_conntrack_udp_timeout_stream` variables of netfilter conntrack subsystem. ([#120808](https://github.com/kubernetes/kubernetes/pull/120808), [@aroradaman](https://github.com/aroradaman))
- Added support for CEL expressions to `v1alpha1 AuthorizationConfiguration` webhook `matchConditions`. ([#121223](https://github.com/kubernetes/kubernetes/pull/121223), [@ritazh](https://github.com/ritazh))
- Added support for projecting `certificates.k8s.io/v1alpha1` ClusterTrustBundle objects into pods. ([#113374](https://github.com/kubernetes/kubernetes/pull/113374), [@ahmedtd](https://github.com/ahmedtd))
- Added the `DisableNodeKubeProxyVersion` feature gate. If `DisableNodeKubeProxyVersion` is enabled, the `kubeProxyVersion` field is not set. ([#120954](https://github.com/kubernetes/kubernetes/pull/120954), [@HirazawaUi](https://github.com/HirazawaUi))
- Fixed a bug where CEL expressions in CRD validation rules would incorrectly compute a high estimated cost for functions that return strings, lists or maps.
  The incorrect cost was evident when the result of a function was used in subsequent operations. ([#119800](https://github.com/kubernetes/kubernetes/pull/119800), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth and Cloud Provider]
- Fixed the API comments for the Job `Ready` field in status. ([#121765](https://github.com/kubernetes/kubernetes/pull/121765), [@mimowo](https://github.com/mimowo))
- Fixed the API comments for the `FailIndex` Job pod failure policy action. ([#121764](https://github.com/kubernetes/kubernetes/pull/121764), [@mimowo](https://github.com/mimowo))
- Go API: the `ResourceRequirements` struct was replaced with `VolumeResourceRequirements` for use with volumes. ([#118653](https://github.com/kubernetes/kubernetes/pull/118653), [@pohly](https://github.com/pohly))
- Graduated `Job BackoffLimitPerIndex` feature to `beta`. ([#121356](https://github.com/kubernetes/kubernetes/pull/121356), [@mimowo](https://github.com/mimowo))
- Marked the `onPodConditions` field as optional in `Job`'s pod failure policy. ([#120204](https://github.com/kubernetes/kubernetes/pull/120204), [@mimowo](https://github.com/mimowo))
- Promoted `PodReadyToStartContainers` condition to `beta`. ([#119659](https://github.com/kubernetes/kubernetes/pull/119659), [@kannon92](https://github.com/kannon92))
- `NodeStageVolume` calls will now be retried if the CSI node driver is not running. ([#120330](https://github.com/kubernetes/kubernetes/pull/120330), [@rohitssingh](https://github.com/rohitssingh))
- The `flowcontrol.apiserver.k8s.io/v1beta3` `FlowSchema` and `PriorityLevelConfiguration` APIs has been promoted to `flowcontrol.apiserver.k8s.io/v1`, with the following changes:
  - `PriorityLevelConfiguration`: the `.spec.limited.nominalConcurrencyShares` field defaults to `30` only if the field is omitted (v1beta3 also defaulted an explicit `0` value to `30`). Specifying an explicit `0` value is not allowed in the `v1` version in v1.29 to ensure compatibility with `v1.28` API servers. In `v1.30`, explicit `0` values will be allowed in this field in the `v1` API.
  The `flowcontrol.apiserver.k8s.io/v1beta3` APIs are deprecated and will no longer be served in v1.32. All existing objects are available via the `v1` APIs. Transition clients and manifests to use the `v1` APIs before upgrading to `v1.32`. ([#121089](https://github.com/kubernetes/kubernetes/pull/121089), [@tkashem](https://github.com/tkashem))
- The `kube-proxy` command-line documentation was updated to clarify that
  `--bind-address` does not actually have anything to do with binding to an
  address, and you probably don't actually want to be using it. ([#120274](https://github.com/kubernetes/kubernetes/pull/120274), [@danwinship](https://github.com/danwinship))
- The `kube-scheduler` `selectorSpread` plugin has been removed, please use the `podTopologySpread` plugin instead. ([#117720](https://github.com/kubernetes/kubernetes/pull/117720), [@kerthcet](https://github.com/kerthcet))
- The `matchLabelKeys/mismatchLabelKeys` feature is introduced to the hard/soft `PodAffinity/PodAntiAffinity`. ([#116065](https://github.com/kubernetes/kubernetes/pull/116065), [@sanposhiho](https://github.com/sanposhiho))
- When updating a CRD, per-expression cost limit check are now skipped for `x-kubernetes-validations` rules of versions that are not mutated. ([#121460](https://github.com/kubernetes/kubernetes/pull/121460), [@jiahuif](https://github.com/jiahuif))
- `CSINodeExpandSecret` feature has been promoted to `GA` in this release and is enabled
  by default. The CSI drivers can make use of the `secretRef` values passed in `NodeExpansion`
  request optionally sent by the CSI Client from this release onwards. ([#121303](https://github.com/kubernetes/kubernetes/pull/121303), [@humblec](https://github.com/humblec))
- `NodeStageVolume` calls will now be retried if the CSI node driver is not running. ([#120330](https://github.com/kubernetes/kubernetes/pull/120330), [@rohitssingh](https://github.com/rohitssingh))
- `PersistentVolumeLastPhaseTransitionTime` is now beta and enabled by default. ([#120627](https://github.com/kubernetes/kubernetes/pull/120627), [@RomanBednar](https://github.com/RomanBednar))
- `ValidatingAdmissionPolicy` type checking now supports CRDs and API extensions types. ([#119109](https://github.com/kubernetes/kubernetes/pull/119109), [@jiahuif](https://github.com/jiahuif))
- `kube-apiserver`: added `--authorization-config` flag for reading a configuration file containing an `apiserver.config.k8s.io/v1alpha1 AuthorizationConfiguration` object. The `--authorization-config` flag is mutually exclusive with `--authorization-modes` and `--authorization-webhook-*` flags. The `alpha` `StructuredAuthorizationConfiguration` feature flag must be enabled for `--authorization-config` to be specified. ([#120154](https://github.com/kubernetes/kubernetes/pull/120154), [@palnabarun](https://github.com/palnabarun))
- `kube-proxy` now has a new nftables-based mode, available by running

      `kube-proxy --feature-gates NFTablesProxyMode=true --proxy-mode nftables`

  This is currently an alpha-level feature and while it probably will not
  eat your data, it may nibble at it a bit. (It passes e2e testing but has
  not yet seen real-world use.)

  At this point it should be functionally mostly identical to the iptables
  mode, except that it does not (and will not) support Service NodePorts on
  127.0.0.1. (Also note that there are currently no command-line arguments
  for the nftables-specific config; you will need to use a config file if
  you want to set the equivalent of any of the `--iptables-xxx` options.)

  As this code is still very new, it has not been heavily optimized yet;
  while it is expected to _eventually_ have better performance than the
  iptables backend, very little performance testing has been done so far. ([#121046](https://github.com/kubernetes/kubernetes/pull/121046), [@danwinship](https://github.com/danwinship))
- `kube-proxy`: Added an option/flag for configuring the `nf_conntrack_tcp_be_liberal` sysctl (in the kernel's netfilter conntrack subsystem). When enabled, `kube-proxy` will not install the `DROP` rule for invalid conntrack states, which currently breaks users of asymmetric routing. ([#120354](https://github.com/kubernetes/kubernetes/pull/120354), [@aroradaman](https://github.com/aroradaman))

### Feature

- #### Additional documentation e.g., KEPs (Kubernetes Enhancement Proposals), usage docs, etc.:

  <!--
  This section can be blank if this pull request does not require a release note.

  When adding links which point to resources within git repositories, like
  KEPs or supporting documentation, please reference a specific commit and avoid
  linking directly to the master branch. This ensures that links reference a
  specific point in time, rather than a document that may change over time.

  See here for guidance on getting permanent links to files: https://help.github.com/en/articles/getting-permanent-links-to-files

  Please use the following format for linking documentation:
  - [KEP]: <link>
  - [Usage]: <link>
  - [Other doc]: <link>
  --> ([#119517](https://github.com/kubernetes/kubernetes/pull/119517), [@sanposhiho](https://github.com/sanposhiho)) [SIG Node, Scheduling and Testing]
- `kubeadm`: added validation to verify that the `CertificateKey` is a valid hex
  encoded AES key. ([#120064](https://github.com/kubernetes/kubernetes/pull/120064), [@SataQiu](https://github.com/SataQiu))
- A customizable `OrderedScoreFuncs()` function was introduced. Out-of-tree plugins
  that used the scheduler's preemption interface could implement this function
  for custom preemption preferences or return nil to keep the current behavior. ([#121867](https://github.com/kubernetes/kubernetes/pull/121867), [@lianghao208](https://github.com/lianghao208))
- Added `apiextensions_apiserver_update_ratcheting_time` metric for tracking time taken during requests by feature `CRDValidationRatcheting`. ([#121462](https://github.com/kubernetes/kubernetes/pull/121462), [@alexzielenski](https://github.com/alexzielenski))
- Added `apiserver_envelope_encryption_dek_cache_filled` to measure number of records in data encryption key (DEK) cache. ([#119878](https://github.com/kubernetes/kubernetes/pull/119878), [@ritazh](https://github.com/ritazh))
- Added `apiserver_watch_list_duration_seconds` metrics which will measure response latency distribution in seconds for watchlist requests broken by group, version, resource and scope. ([#120490](https://github.com/kubernetes/kubernetes/pull/120490), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Added `job_pods_creation_total` metrics for tracking Pods created by the Job controller labeled by events which triggered the Pod creation. ([#121481](https://github.com/kubernetes/kubernetes/pull/121481), [@dejanzele](https://github.com/dejanzele))
- Added `kubectl node drain` helper callbacks `OnPodDeletionOrEvictionStarted`
  and `OnPodDeletionOrEvictionFailed`; people extending `kubectl` can use these
  new callbacks for more granularity. Deprecated the `OnPodDeletedOrEvicted`
  node drain helper callback. ([#117502](https://github.com/kubernetes/kubernetes/pull/117502), [@adilGhaffarDev](https://github.com/adilGhaffarDev))
- Added a new `--init-only` command line flag to `kube-proxy`. Setting the flag makes `kube-proxy` perform its initial configuration that requires privileged mode, and then exit. The `--init-only` mode is intended to be executed in a privileged init container, so that the main container may run with a stricter `securityContext`. ([#120864](https://github.com/kubernetes/kubernetes/pull/120864), [@uablrek](https://github.com/uablrek)) [SIG Network and Scalability]
- Added a new scheduler metric, `pod_scheduling_sli_duration_seconds`, and started the deprecation for `pod_scheduling_duration_seconds`. ([#119049](https://github.com/kubernetes/kubernetes/pull/119049), [@helayoty](https://github.com/helayoty))
- Added a return value to `QueueingHint` to indicate an error. If `QueueingHint` returns an error,
  the scheduler logs it and treats the event as a `QueueAfterBackoff` so that
  the Pod won't be stuck in the unschedulable pod pool. ([#119290](https://github.com/kubernetes/kubernetes/pull/119290), [@carlory](https://github.com/carlory))
- Added apiserver identity to the following metrics:
  `apiserver_envelope_encryption_key_id_hash_total`, `apiserver_envelope_encryption_key_id_hash_last_timestamp_seconds`, `apiserver_envelope_encryption_key_id_hash_status_last_timestamp_seconds`, `apiserver_encryption_config_controller_automatic_reload_failures_total`, `apiserver_encryption_config_controller_automatic_reload_success_total`, `apiserver_encryption_config_controller_automatic_reload_last_timestamp_seconds`.

  Fixed bug to surface events for the following metrics: `apiserver_encryption_config_controller_automatic_reload_failures_total`, `apiserver_encryption_config_controller_automatic_reload_last_timestamp_seconds`, `apiserver_encryption_config_controller_automatic_reload_success_total`. ([#120438](https://github.com/kubernetes/kubernetes/pull/120438), [@ritazh](https://github.com/ritazh))
- Added container filesystem to the `ImageFsInfoResponse`. ([#120914](https://github.com/kubernetes/kubernetes/pull/120914), [@kannon92](https://github.com/kannon92))
- Added multiplication functionality to `Quantity`. ([#117411](https://github.com/kubernetes/kubernetes/pull/117411), [@tenzen-y](https://github.com/tenzen-y))
- Added new feature gate called `RuntimeClassInImageCriApi` to address `kubelet` changes needed for KEP 4216.
  Noteable changes:
  1. Populate new `RuntimeHandler` field in CRI's `ImageSpec` struct during image pulls from container runtimes.
  2. Pass `runtimeHandler` field in `RemoveImage()` call to container runtime in `kubelet`'s image garbage collection. ([#121456](https://github.com/kubernetes/kubernetes/pull/121456), [@kiashok](https://github.com/kiashok))
- Added support for split image filesystem in kubelet. ([#120616](https://github.com/kubernetes/kubernetes/pull/120616), [@kannon92](https://github.com/kannon92))
- Bumped `cel-go` to `v0.17.7` and introduced set `ext` library with new options. ([#121577](https://github.com/kubernetes/kubernetes/pull/121577), [@cici37](https://github.com/cici37))
- Bumped `distroless-iptables` to `0.3.2` based on Go `1.21.1`. ([#120527](https://github.com/kubernetes/kubernetes/pull/120527), [@cpanato](https://github.com/cpanato))
- Bumped `distroless-iptables` to `0.3.3` based on Go `1.21.2`. ([#121073](https://github.com/kubernetes/kubernetes/pull/121073), [@cpanato](https://github.com/cpanato))
- Bumped `distroless-iptables` to `0.4.1` based on Go `1.21.3`. ([#121216](https://github.com/kubernetes/kubernetes/pull/121216), [@cpanato](https://github.com/cpanato))
- Bumped `cel-go to` `v0.17.7` and introduced set ext library with new options. ([#121577](https://github.com/kubernetes/kubernetes/pull/121577), [@cici37](https://github.com/cici37))
- CEL can now correctly handle a CRD `openAPIV3Schema` that has neither `Properties` nor `AdditionalProperties`. ([#121459](https://github.com/kubernetes/kubernetes/pull/121459), [@jiahuif](https://github.com/jiahuif))
- CEL cost estimator no longer treats enums as unbounded strings when determining its length. Instead, the length is set to the longest possible enum value. ([#121085](https://github.com/kubernetes/kubernetes/pull/121085), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery]
- CRI: image pull per runtime class is now supported. ([#121121](https://github.com/kubernetes/kubernetes/pull/121121), [@kiashok](https://github.com/kiashok))
- Certain `requestBody` parameters in the OpenAPI `v3` are now correctly marked as required. ([#120735](https://github.com/kubernetes/kubernetes/pull/120735), [@Jefftree](https://github.com/Jefftree))
- Changed `kubectl help` to display basic details for subcommands from plugins. ([#116752](https://github.com/kubernetes/kubernetes/pull/116752), [@xvzf](https://github.com/xvzf))
- Changed the `KMSv2KDF` feature gate to be enabled by default. ([#120433](https://github.com/kubernetes/kubernetes/pull/120433), [@enj](https://github.com/enj)) [SIG API Machinery, Auth and Testing]
- Client-side apply will now use OpenAPI `v3` by default. ([#120707](https://github.com/kubernetes/kubernetes/pull/120707), [@Jefftree](https://github.com/Jefftree))
- Decoding etcd's response now respects the timeout context. ([#121614](https://github.com/kubernetes/kubernetes/pull/121614), [@HirazawaUi](https://github.com/HirazawaUi))
- Decoupled `TaintManager` from `NodeLifeCycleController` (KEP-3902). ([#119208](https://github.com/kubernetes/kubernetes/pull/119208), [@atosatto](https://github.com/atosatto))
- Enabled traces for KMSv2 encrypt/decrypt operations. ([#121095](https://github.com/kubernetes/kubernetes/pull/121095), [@aramase](https://github.com/aramase))
- Fixed `kube-proxy` panicking on exit when the `Node` object changed its `PodCIDR`. ([#120375](https://github.com/kubernetes/kubernetes/pull/120375), [@pegasas](https://github.com/pegasas))
- Fixed bugs in handling of server-side apply, create, and update API requests for objects containing duplicate items in keyed lists.
  - A `create` or `update` API request with duplicate items in a keyed list no longer wipes out managedFields. Examples include env var entries with the same name, or port entries with the same containerPort in a pod spec.
  - A server-side apply request that makes unrelated changes to an object which has duplicate items in a keyed list no longer fails, and leaves the existing duplicate items as-is.
  - A server-side apply request that changes an object which has duplicate items in a keyed list, and modifies the duplicated item removes the duplicates and replaces them with the single item contained in the server-side apply request. ([#121575](https://github.com/kubernetes/kubernetes/pull/121575), [@apelisse](https://github.com/apelisse))
- Fixed overriding default `KubeletConfig` fields in drop-in configs if not set. ([#121193](https://github.com/kubernetes/kubernetes/pull/121193), [@sohankunkerkar](https://github.com/sohankunkerkar))
- Graduated API List chunking (aka pagination) feature to `stable`. ([#119503](https://github.com/kubernetes/kubernetes/pull/119503), [@wojtek-t](https://github.com/wojtek-t))
- Graduated the `ReadWriteOncePod` feature gate to `GA`. ([#121077](https://github.com/kubernetes/kubernetes/pull/121077), [@chrishenzie](https://github.com/chrishenzie))
- Graduated the following kubelet resource metrics to **general availability**:
  - `container_cpu_usage_seconds_total`
  - `container_memory_working_set_bytes`
  - `container_start_time_seconds`
  - `node_cpu_usage_seconds_total`
  - `node_memory_working_set_bytes`
  - `pod_cpu_usage_seconds_total`
  - `pod_memory_working_set_bytes`
  - `resource_scrape_error`

  Deprecated (renamed) `scrape_error` in favor of `resource_scrape_error` ([#116897](https://github.com/kubernetes/kubernetes/pull/116897), [@Richabanker](https://github.com/Richabanker)) [SIG Architecture, Instrumentation, Node and Testing]
- Implemented API for streaming for the `etcd` store implementation.
  When `sendInitialEvents ListOption` is set together with `watch=true`, it begins the watch stream with synthetic init events followed by a synthetic `Bookmark`, after which the server continues streaming events. ([#119557](https://github.com/kubernetes/kubernetes/pull/119557), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Improved memory usage of `kube-scheduler` by dropping the `.metadata.managedFields` field that `kube-scheduler` doesn't require. ([#119556](https://github.com/kubernetes/kubernetes/pull/119556), [@linxiulei](https://github.com/linxiulei))
- In a scheduler with `Permit` plugins, when a Pod is rejected during `WaitOnPermit`, the scheduler records the plugin.
  The scheduler will use the record to honor cluster events and queueing `hints registered` for the plugin, to inform whether to retry the pod. ([#119785](https://github.com/kubernetes/kubernetes/pull/119785), [@sanposhiho](https://github.com/sanposhiho))
- In-tree cloud providers are now switched off by default. Please use `DisableCloudProviders` and `DisableKubeletCloudCredentialProvider` feature flags if you still need this functionality. ([#117503](https://github.com/kubernetes/kubernetes/pull/117503), [@dims](https://github.com/dims))
- Introduced new apiserver metric `apiserver_flowcontrol_current_inqueue_seats`. This metric is analogous to `apiserver_flowcontrol_current_inqueue_requests`, but tracks the total number of seats, as each request can take more than one seat. ([#119385](https://github.com/kubernetes/kubernetes/pull/119385), [@andrewsykim](https://github.com/andrewsykim))
- Introduced the `job_finished_indexes_total` metric for the `BackoffLimitPerIndex` feature. ([#121292](https://github.com/kubernetes/kubernetes/pull/121292), [@mimowo](https://github.com/mimowo))
- Kubeadm: supported updating certificate organization during `kubeadm certs renew` operation. ([#121841](https://github.com/kubernetes/kubernetes/pull/121841), [@SataQiu](https://github.com/SataQiu))
- Kubernetes is now built with Go `1.21.0`. ([#118996](https://github.com/kubernetes/kubernetes/pull/118996), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Go `1.21.1`. ([#120493](https://github.com/kubernetes/kubernetes/pull/120493), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Go `1.21.2`. ([#121021](https://github.com/kubernetes/kubernetes/pull/121021), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Go `1.21.4`. ([#121808](https://github.com/kubernetes/kubernetes/pull/121808), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Go `v1.21.3`. ([#121149](https://github.com/kubernetes/kubernetes/pull/121149), [@cpanato](https://github.com/cpanato))
- List of metric labels can now be configured by supplying a manifest using the `--allow-metric-labels-manifest` flag. ([#118299](https://github.com/kubernetes/kubernetes/pull/118299), [@rexagod](https://github.com/rexagod))
- Listed the pods using `<PVC>` as an ephemeral storage volume in "Used by:" part of the output of `kubectl describe pvc <PVC>` command. ([#120427](https://github.com/kubernetes/kubernetes/pull/120427), [@MaGaroo](https://github.com/MaGaroo))
- Migrated the `nodevolumelimits` scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116884](https://github.com/kubernetes/kubernetes/pull/116884), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated the `volumebinding scheduler plugins` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116803](https://github.com/kubernetes/kubernetes/pull/116803), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Priority and Fairness feature is now `stable`, the feature gate will be removed in `v1.31`. ([#121638](https://github.com/kubernetes/kubernetes/pull/121638), [@tkashem](https://github.com/tkashem))
- Promoted `PodHostIPs` condition to `beta`. ([#120257](https://github.com/kubernetes/kubernetes/pull/120257), [@wzshiming](https://github.com/wzshiming))
- Promoted `PodHostIPs` condition to `beta`. ([#121477](https://github.com/kubernetes/kubernetes/pull/121477), [@wzshiming](https://github.com/wzshiming))
- Promoted `PodReplacementPolicy` to `beta`. ([#121491](https://github.com/kubernetes/kubernetes/pull/121491), [@dejanzele](https://github.com/dejanzele))
- Promoted `ServiceNodePortStaticSubrange` to stable and lock to default. ([#120233](https://github.com/kubernetes/kubernetes/pull/120233), [@xuzhenglun](https://github.com/xuzhenglun))
- Promoted plugin subcommand resolution feature to `beta`. ([#120663](https://github.com/kubernetes/kubernetes/pull/120663), [@ardaguclu](https://github.com/ardaguclu))
- Removed `/livez` livezchecks for KMS v1 and v2 to ensure KMS health does not cause `kube-apiserver` restart. KMS health checks are still in place as a healthz and readiness checks. ([#120583](https://github.com/kubernetes/kubernetes/pull/120583), [@ritazh](https://github.com/ritazh))
- Restartable init containers resource in pod autoscaler are now calculated. ([#120001](https://github.com/kubernetes/kubernetes/pull/120001), [@qingwave](https://github.com/qingwave))
- Sidecar termination is now serialized and each sidecar container will receive a `SIGTERM` after all main containers and later starting sidecar containers have terminated. ([#120620](https://github.com/kubernetes/kubernetes/pull/120620), [@tzneal](https://github.com/tzneal))
- The CRD validation rule with feature gate `CustomResourceValidationExpressions` was promoted to `GA`. ([#121373](https://github.com/kubernetes/kubernetes/pull/121373), [@cici37](https://github.com/cici37))
- The KMSv2 features with feature gates `KMSv2` and `KMSv2KDF` are promoted to `GA`. The `KMSv1` feature gate is now disabled by default. ([#121485](https://github.com/kubernetes/kubernetes/pull/121485), [@ritazh](https://github.com/ritazh))
- The `--interactive` flag in `kubectl delete` is now visible to all users by default. ([#120416](https://github.com/kubernetes/kubernetes/pull/120416), [@ardaguclu](https://github.com/ardaguclu))
- The `CloudDualStackNodeIPs` feature is now `beta`, meaning that when using
  an external cloud provider that has been updated to support the feature,
  you can pass comma-separated dual-stack `--node-ips` to `kubelet` and have
  the cloud provider take both IPs into account. ([#120275](https://github.com/kubernetes/kubernetes/pull/120275), [@danwinship](https://github.com/danwinship))
- The `Dockerfile` for the kubectl image has been updated with the addition of a specific base image and essential utilities (bash and jq). ([#119592](https://github.com/kubernetes/kubernetes/pull/119592), [@rayandas](https://github.com/rayandas))
- The `SidecarContainers` feature has graduated to `beta` and is enabled by default. ([#121579](https://github.com/kubernetes/kubernetes/pull/121579), [@gjkim42](https://github.com/gjkim42))
- The `kube-apiserver` will now expose four new metrics to inform about errors on the clusterIP and nodePort allocation logic. ([#120843](https://github.com/kubernetes/kubernetes/pull/120843), [@aojea](https://github.com/aojea))
- The `volume_zone` plugin will consider `beta` labels as `GA` labels during the scheduling
  process. Therefore, if the values of the labels are the same, PVs with `beta` labels
  can also be scheduled to nodes with `GA` labels. ([#118923](https://github.com/kubernetes/kubernetes/pull/118923), [@AxeZhan](https://github.com/AxeZhan))
- Updated the generic apiserver library to produce an error if a new API server is configured with support for a data format other than JSON, YAML, or Protobuf. ([#121325](https://github.com/kubernetes/kubernetes/pull/121325), [@benluddy](https://github.com/benluddy)) [SIG API Machinery]
- Use of secret-based service account tokens now adds an `authentication.k8s.io/legacy-token-autogenerated-secret` or `authentication.k8s.io/legacy-token-manual-secret` audit annotation containing the name of the secret used. ([#118598](https://github.com/kubernetes/kubernetes/pull/118598), [@yuanchen8911](https://github.com/yuanchen8911)) [SIG Auth, Instrumentation and Testing]
- `--sync-frequency` will not affect the update interval of volumes that use `ConfigMaps`
  or `Secrets` when the `configMapAndSecretChangeDetectionStrategy` is set to `Cache`.
  The update interval is only affected by `node.alpha.kubernetes.io/ttl` node annotation." ([#120255](https://github.com/kubernetes/kubernetes/pull/120255), [@likakuli](https://github.com/likakuli))
- `CRDValidationRatcheting`: added support for ratcheting `x-kubernetes-validations` in schema. ([#121016](https://github.com/kubernetes/kubernetes/pull/121016), [@alexzielenski](https://github.com/alexzielenski))
- `DevicePluginCDIDevices` feature has been graduated to `beta` and enabled by default in the kubelet. ([#121254](https://github.com/kubernetes/kubernetes/pull/121254), [@bart0sh](https://github.com/bart0sh))
- `ValidatingAdmissionPolicy` now preserves types of composition variables, and raises type-related errors early. ([#121001](https://github.com/kubernetes/kubernetes/pull/121001), [@jiahuif](https://github.com/jiahuif))
- `cluster/gce`: added webhook to replace `PersistentVolumeLabel` admission controller. ([#121628](https://github.com/kubernetes/kubernetes/pull/121628), [@andrewsykim](https://github.com/andrewsykim))
- `dra`: the scheduler plugin now avoids additional scheduling attempts in some cases by falling back to SSA after a conflict. ([#120534](https://github.com/kubernetes/kubernetes/pull/120534), [@pohly](https://github.com/pohly))
- `etcd`: image is now based on `v3.5.9`. ([#121567](https://github.com/kubernetes/kubernetes/pull/121567), [@mzaian](https://github.com/mzaian))
- `kube-apiserver` added:
  - `alpha` support (guarded by the `ServiceAccountTokenJTI` feature gate) for adding a `jti` (JWT ID) claim to service account tokens it issues, adding an `authentication.kubernetes.io/credential-id` audit annotation in audit logs when the tokens are issued, and `authentication.kubernetes.io/credential-id` entry in the extra user info when the token is used to authenticate.
  - `alpha` support (guarded by the `ServiceAccountTokenPodNodeInfo` feature gate) for including the node name (and uid, if the node exists) as additional claims in service account tokens it issues which are bound to pods, and `authentication.kubernetes.io/node-name` and `authentication.kubernetes.io/node-uid` extra user info when the token is used to authenticate.
  - `alpha` support (guarded by the `ServiceAccountTokenNodeBinding` feature gate) for allowing `TokenRequests` that bind tokens directly to nodes, and (guarded by the ServiceAccountTokenNodeBindingValidation feature gate) for validating the node name and uid still exist when the token is used. ([#120780](https://github.com/kubernetes/kubernetes/pull/120780), [@munnerz](https://github.com/munnerz))
- `kube-controller-manager`: The `LegacyServiceAccountTokenCleanUp` feature gate is now `beta` and enabled by default. When enabled, legacy auto-generated service account token secrets are auto-labeled with a `kubernetes.io/legacy-token-invalid-since` label if the credentials have not been used in the time specified by `--legacy-service-account-token-clean-up-period` (defaulting to one year), **and** are referenced from the `.secrets` list of a ServiceAccount object, **and** are not referenced from pods. This label causes the authentication layer to reject use of the credentials. After being labeled as invalid, if the time specified by `--legacy-service-account-token-clean-up-period` (defaulting to one year) passes without the credential being used, the secret is automatically deleted. Secrets labeled as invalid which have not been auto-deleted yet can be re-activated by removing the `kubernetes.io/legacy-token-invalid-since` label. ([#120682](https://github.com/kubernetes/kubernetes/pull/120682), [@yt2985](https://github.com/yt2985))
- `kube-proxy` will only install the `DROP` rules for invalid `conntrack` states if
  the `nf_conntrack_tcp_be_liberal` is not set. ([#120412](https://github.com/kubernetes/kubernetes/pull/120412), [@aojea](https://github.com/aojea))
- `kube-scheduler` now implements scheduling hints for the `NodeAffinity` plugin.
  The scheduling hints allow the scheduler to only retry scheduling a `Pod`
  that was previously rejected by the `NodeAffinity` plugin if a new `Node` or a `Node` update matches the `Pod`'s node affinity. ([#119155](https://github.com/kubernetes/kubernetes/pull/119155), [@carlory](https://github.com/carlory))
- `kube-scheduler` now implements scheduling hints for the `NodeUnschedulable` plugin.
  The scheduling hints allow the scheduler to only retry scheduling a `Pod`
  that was previously rejected by the `NodeSchedulable` plugin if a new `Node` or a `Node` update sets `.spec.unschedulable` to false. ([#119396](https://github.com/kubernetes/kubernetes/pull/119396), [@wackxu](https://github.com/wackxu))
- `kubeadm`: deploying a kubelet that is 3 versions older than the version of `kubeadm` (N-3) is now allowed. This aligns with the recent change made by SIG Architecture that extends the support skew between the control plane and kubelets. Tolerate this new kubelet skew for the commands `init`, `join` and `upgrade`. Note that if the `kubeadm` user applies a control plane version that is older than the `kubeadm` version (N-1 maximum) then the skew between the kubelet and control plane would become a maximum of N-2. ([#120825](https://github.com/kubernetes/kubernetes/pull/120825), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: promoted feature gate `EtcdLearnerMode` to `beta`. Learner mode for
  joining `etcd` members is now enabled by default. ([#120228](https://github.com/kubernetes/kubernetes/pull/120228), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: turned on feature gate `MergeCLIArgumentsWithConfig` to merge the config from flag and config file, otherwise, if the flag `--ignore-preflight-errors` is set from the CLI, then the value from config file will be ignored. ([#119946](https://github.com/kubernetes/kubernetes/pull/119946), [@chendave](https://github.com/chendave))
- `kubeadm`: will now allow deploying a kubelet that is 3 versions older than the version of `kubeadm` (N-3). This aligns with the recent change made by SIG Architecture that extends the support skew between the control plane and kubelets. Tolerate this new kubelet skew for the commands `init`, `join` and `upgrade`. Note that if the `kubeadm` user applies a control plane version that is older than the `kubeadm` version (N-1 maximum) then the skew between the kubelet and control plane would become a maximum of N-2. ([#120825](https://github.com/kubernetes/kubernetes/pull/120825), [@pacoxu](https://github.com/pacoxu))
- `kubelet` , when using `--cloud-provider=external`, will now initialize the node addresses with the value of `--node-ip` , if it exists, or waits for the cloud provider to assign the addresses. ([#121028](https://github.com/kubernetes/kubernetes/pull/121028), [@aojea](https://github.com/aojea))
- `kubelet` will now allow pods to use the `net.ipv4.tcp_fin_timeout`, “net.ipv4.tcp_keepalive_intvl”
  and “net.ipv4.tcp_keepalive_probes“ sysctl by default; Pod Security Admission
  allows this sysctl in `v1.29+` versions of the baseline and restricted policies. ([#121240](https://github.com/kubernetes/kubernetes/pull/121240), [@HirazawaUi](https://github.com/HirazawaUi))
- `kubelet` will now expose latency metrics of different stages of the node startup. ([#118568](https://github.com/kubernetes/kubernetes/pull/118568), [@qiutongs](https://github.com/qiutongs))
- `kubelet` now allows pods to use the `net.ipv4.tcp_keepalive_time` sysctl by default
  and the minimal kernel version is 4.5; Pod Security Admission allows this sysctl
  in `v1.29+` versions of the baseline and restricted policies. ([#118846](https://github.com/kubernetes/kubernetes/pull/118846), [@cyclinder](https://github.com/cyclinder))
- `kubelet` now emits a metric for end-to-end pod startup latency, including image pull. ([#121041](https://github.com/kubernetes/kubernetes/pull/121041), [@ruiwen-zhao](https://github.com/ruiwen-zhao))
- `kubelet` now exposes latency metrics of different stages of the node startup. ([#118568](https://github.com/kubernetes/kubernetes/pull/118568), [@qiutongs](https://github.com/qiutongs))

### Documentation

- Added descriptions and examples for the situation of using `kubectl rollout restart` without specifying a particular deployment. ([#120118](https://github.com/kubernetes/kubernetes/pull/120118), [@Ithrael](https://github.com/Ithrael))
- When the kubelet fails to assign CPUs to a Pod because there less available CPUs than the Pod requests, the error message changed from
  `not enough cpus available to satisfy request` to `not enough cpus available to satisfy request: <num_requested> requested, only <num_available> available`. ([#121059](https://github.com/kubernetes/kubernetes/pull/121059), [@matte21](https://github.com/matte21))

### Failing Test

- Added mock framework support for unit tests for Windows in `kubeproxy`. ([#120105](https://github.com/kubernetes/kubernetes/pull/120105), [@princepereira](https://github.com/princepereira))
- DRA: when the scheduler had to deallocate a claim after a node became unsuitable for a pod, it might have needed more attempts than really necessary. This was fixed by first disabling allocations. ([#120428](https://github.com/kubernetes/kubernetes/pull/120428), [@pohly](https://github.com/pohly))
- E2e framework: retrying after intermittent `apiserver` failures was fixed in `WaitForPodsResponding` ([#120559](https://github.com/kubernetes/kubernetes/pull/120559), [@pohly](https://github.com/pohly))
- KCM specific args can be passed with `/cluster` script, without affecting CCM. New variable name: `KUBE_CONTROLLER_MANAGER_TEST_ARGS`. ([#120524](https://github.com/kubernetes/kubernetes/pull/120524), [@jprzychodzen](https://github.com/jprzychodzen)) [SIG Cloud Provider]
- `k8s.io/dynamic-resource-allocation`: DRA drivers updating to this release are compatible with Kubernetes `v1.27` and `v1.28`. ([#120868](https://github.com/kubernetes/kubernetes/pull/120868), [@pohly](https://github.com/pohly))

### Bug or Regression

- `kubeadm`: printing the default component configs for `reset` and `join` is now
  unsupported. ([#119346](https://github.com/kubernetes/kubernetes/pull/119346), [@chendave](https://github.com/chendave))
- `kubeadm`: removed `system:masters` organization from `etcd/healthcheck-client`
  certificate. ([#119859](https://github.com/kubernetes/kubernetes/pull/119859), [@SataQiu](https://github.com/SataQiu))
- Added `CAP_NET_RAW` to netadmin debug profile and removed privileges when debugging nodes. ([#118647](https://github.com/kubernetes/kubernetes/pull/118647), [@mochizuki875](https://github.com/mochizuki875))
- Added a check on a user attempting to create a static pod via the `kubelet` without specifying a name. They will now get a visible validation error. ([#119522](https://github.com/kubernetes/kubernetes/pull/119522), [@YTGhost](https://github.com/YTGhost))
- Added a redundant process to remove tracking finalizers from Pods that belong to Jobs. The process kicks in after the control plane marks a Job as finished. ([#119944](https://github.com/kubernetes/kubernetes/pull/119944), [@Sharpz7](https://github.com/Sharpz7))
- Added more accurate requeueing in scheduling queue for Pods rejected by the temporal failure (e.g., temporal failure on `kube-apiserver`). ([#119105](https://github.com/kubernetes/kubernetes/pull/119105), [@sanposhiho](https://github.com/sanposhiho))
- Allowed specifying `ExternalTrafficPolicy` for `Services` with `ExternalIPs`. ([#119150](https://github.com/kubernetes/kubernetes/pull/119150), [@tnqn](https://github.com/tnqn))
- Changed kubelet logs from `error` to `info` for uncached partitions when using CRI stats provider. ([#100448](https://github.com/kubernetes/kubernetes/pull/100448), [@saschagrunert](https://github.com/saschagrunert))
- Empty values are no longer assigned to undefined resources (CPU or memory) when storing the resources allocated to the pod in checkpoint. ([#117615](https://github.com/kubernetes/kubernetes/pull/117615), [@aheng-ch](https://github.com/aheng-ch))
- Fixed CEL estimated cost of `replace()` to handle a zero length replacement string correctly.
  Previously this would cause the estimated cost to be higher than it should be. ([#120097](https://github.com/kubernetes/kubernetes/pull/120097), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery]
- Fixed OpenAPI v3 not being cleaned up after deleting `APIServices`. ([#120108](https://github.com/kubernetes/kubernetes/pull/120108), [@tnqn](https://github.com/tnqn))
- Fixed [121094](https://github.com/kubernetes/kubernetes/issues/121094) by re-introducing the readiness predicate for `externalTrafficPolicy: Local` services. ([#121116](https://github.com/kubernetes/kubernetes/pull/121116), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Fixed `kubectl events` not filtering events by `GroupVersion` for resources with a full name. ([#120119](https://github.com/kubernetes/kubernetes/pull/120119), [@Ithrael](https://github.com/Ithrael))
- Fixed `systemLogQuery` service name matching. ([#120678](https://github.com/kubernetes/kubernetes/pull/120678), [@rothgar](https://github.com/rothgar))
- Fixed a `1.27` scheduling regression that `PostFilter` plugin may not function if previous `PreFilter` plugins return `Skip`. ([#119769](https://github.com/kubernetes/kubernetes/pull/119769), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed a `v1.26` regression scheduling bug by ensuring that preemption is skipped when a `PreFilter` plugin returns `UnschedulableAndUnresolvable`. ([#119778](https://github.com/kubernetes/kubernetes/pull/119778), [@sanposhiho](https://github.com/sanposhiho))
- Fixed a `v1.28.0` regression where `kube-controller-manager` can crash when `StatefulSet` with `Parallel` policy and PVC labels are scaled up. ([#121142](https://github.com/kubernetes/kubernetes/pull/121142), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Fixed a `v1.28` regression around restarting init containers in the right order relative to normal containers. ([#120281](https://github.com/kubernetes/kubernetes/pull/120281), [@gjkim42](https://github.com/gjkim42))
- Fixed a `v1.28` regression handling negative index json patches. ([#120327](https://github.com/kubernetes/kubernetes/pull/120327), [@liggitt](https://github.com/liggitt))
- Fixed a `v1.28` regression in scheduler: a pod with concurrent events could incorrectly get moved to the unschedulable queue where it could get stuck until the next periodic purging after 5 minutes, if there was no other event for it. ([#120413](https://github.com/kubernetes/kubernetes/pull/120413), [@pohly](https://github.com/pohly))
- Fixed a bug around restarting init containers in the right order relative to normal containers with `SidecarContainers` feature enabled. ([#120269](https://github.com/kubernetes/kubernetes/pull/120269), [@gjkim42](https://github.com/gjkim42))
- Fixed a bug in the cronjob controller where already created jobs might be missing from the status. ([#120649](https://github.com/kubernetes/kubernetes/pull/120649), [@andrewsykim](https://github.com/andrewsykim))
- Fixed a bug where `Services` using finalizers may hold onto `ClusterIP` and/or `NodePort` allocated resources for longer than expected if the finalizer is removed using the status subresource. ([#120623](https://github.com/kubernetes/kubernetes/pull/120623), [@aojea](https://github.com/aojea))
- Fixed a bug where an API group's path was not unregistered from the API server's root paths when the group was deleted. ([#121283](https://github.com/kubernetes/kubernetes/pull/121283), [@tnqn](https://github.com/tnqn)) [SIG API Machinery and Testing]
- Fixed a bug where containers would not start on `cgroupv2` systems where `swap` is disabled. ([#120784](https://github.com/kubernetes/kubernetes/pull/120784), [@elezar](https://github.com/elezar))
- Fixed a bug where the CPU set allocated to an init container, with containerRestartPolicy of `Always`, were erroneously reused by a regular container. ([#119447](https://github.com/kubernetes/kubernetes/pull/119447), [@gjkim42](https://github.com/gjkim42)) [SIG Node and Testing]
- Fixed a bug where the device resources allocated to an init container, with `containerRestartPolicy` of `Always`, were erroneously reused by a regular container. ([#120461](https://github.com/kubernetes/kubernetes/pull/120461), [@gjkim42](https://github.com/gjkim42))
- Fixed a bug where the memory resources allocated to an init container, with containerRestartPolicy of `Always`, were erroneously reused by a regular container. ([#120715](https://github.com/kubernetes/kubernetes/pull/120715), [@gjkim42](https://github.com/gjkim42)) [SIG Node]
- Fixed a concurrent map access in `TopologyCache`'s `HasPopulatedHints` method. ([#118189](https://github.com/kubernetes/kubernetes/pull/118189), [@Miciah](https://github.com/Miciah))
- Fixed a regression (`CLIENTSET_PKG: unbound variable`) when invoking deprecated `generate-groups.sh` script. ([#120877](https://github.com/kubernetes/kubernetes/pull/120877), [@soltysh](https://github.com/soltysh))
- Fixed a regression in `kube-proxy` where it might refuse to start if given
  single-stack `IPv6` configuration options on a node that has both `IPv4` and
  `IPv6` IPs. ([#121008](https://github.com/kubernetes/kubernetes/pull/121008), [@danwinship](https://github.com/danwinship))
- Fixed a regression in default configurations, which enabled `PodDisruptionConditions`
  by default, that prevented the control plane's pod garbage collector from deleting
  pods that contained duplicated field keys (environmental variables with repeated keys or
  container ports). ([#121103](https://github.com/kubernetes/kubernetes/pull/121103), [@mimowo](https://github.com/mimowo))
- Fixed a regression in the default `v1.27` configurations in `kube-apiserver`: fixed the `AggregatedDiscoveryEndpoint` feature (`beta` in `v1.27+`) to successfully fetch discovery information from aggregated API servers that do not check `Accept` headers when serving the `/apis` endpoint. ([#119870](https://github.com/kubernetes/kubernetes/pull/119870), [@Jefftree](https://github.com/Jefftree))
- Fixed a regression in the kubelet's behavior while creating a container when the `EventedPLEG` feature gate is enabled. ([#120942](https://github.com/kubernetes/kubernetes/pull/120942), [@sairameshv](https://github.com/sairameshv))
- Fixed a regression since `v1.27.0` in the scheduler framework when running score plugins.
  The `skippedScorePlugins` number might be greater than `enabledScorePlugins`,
  so when initializing a slice the `cap(len(skippedScorePlugins) - len(enabledScorePlugins))` is negative,
  which is not allowed. ([#121632](https://github.com/kubernetes/kubernetes/pull/121632), [@kerthcet](https://github.com/kerthcet))
- Fixed a situation when, sometimes, the scheduler incorrectly placed a pod in the `unschedulable` queue instead of the `backoff` queue. This happened when some plugin previously declared the pod as `unschedulable` and then in a later attempt encounters some other error. Scheduling of that pod then got delayed by up to five minutes, after which periodic flushing moved the pod back into the `active` queue. ([#120334](https://github.com/kubernetes/kubernetes/pull/120334), [@pohly](https://github.com/pohly))
- Fixed an issue related to not draining all the pods in a namespace when an empty selector, i.e., "{}," is specified in a Pod Disruption Budget (PDB). ([#119732](https://github.com/kubernetes/kubernetes/pull/119732), [@sairameshv](https://github.com/sairameshv))
- Fixed an issue where `StatefulSet` might not restart a pod after eviction or node failure. ([#120398](https://github.com/kubernetes/kubernetes/pull/120398), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Fixed an issue where a `CronJob` could fail to clean up Jobs when the `ResourceQuota` for `Jobs` had been reached. ([#119776](https://github.com/kubernetes/kubernetes/pull/119776), [@ASverdlov](https://github.com/ASverdlov))
- Fixed an issue where a `StatefulSet` might not restart a pod after eviction or node failure. ([#121389](https://github.com/kubernetes/kubernetes/pull/121389), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Fixed an issue with the `garbagecollection` controller registering duplicate event handlers if discovery requests failed. ([#117992](https://github.com/kubernetes/kubernetes/pull/117992), [@liggitt](https://github.com/liggitt))
- Fixed attaching volumes after detach errors. Now volumes that failed to detach are not treated as attached. Kubernetes will make sure they are fully attached before they can be used by pods. ([#120595](https://github.com/kubernetes/kubernetes/pull/120595), [@jsafrane](https://github.com/jsafrane))
- Fixed bug that kubelet resource metric `container_start_time_seconds` had timestamp equal to container start time. ([#120518](https://github.com/kubernetes/kubernetes/pull/120518), [@saschagrunert](https://github.com/saschagrunert)) [SIG Instrumentation, Node and Testing]
- Fixed inconsistency in the calculation of number of nodes that have an image, which affect the scoring in the `ImageLocality` plugin. ([#116938](https://github.com/kubernetes/kubernetes/pull/116938), [@olderTaoist](https://github.com/olderTaoist))
- Fixed issue with incremental id generation for `loadbalancer` and `endpoint` in `kubeproxy` mock test framework. ([#120723](https://github.com/kubernetes/kubernetes/pull/120723), [@princepereira](https://github.com/princepereira))
- Fixed panic in Job controller when `podRecreationPolicy: Failed` is used, and the number of terminating pods exceeds parallelism. ([#121147](https://github.com/kubernetes/kubernetes/pull/121147), [@kannon92](https://github.com/kannon92))
- Fixed regression with adding aggregated `APIservices` panicking and affected health check introduced in release `v1.28.0`. ([#120814](https://github.com/kubernetes/kubernetes/pull/120814), [@Jefftree](https://github.com/Jefftree))
- Fixed some invalid and unimportant log calls. ([#121249](https://github.com/kubernetes/kubernetes/pull/121249), [@pohly](https://github.com/pohly)) [SIG Cloud Provider, Cluster Lifecycle and Testing]
- Fixed stale SMB mount issue when SMB file share is deleted and then unmounted. ([#121851](https://github.com/kubernetes/kubernetes/pull/121851), [@andyzhangx](https://github.com/andyzhangx))
- Fixed the bug where images that were pinned by the container runtime could be garbage collected by `kubelet`. ([#119986](https://github.com/kubernetes/kubernetes/pull/119986), [@ruiwen-zhao](https://github.com/ruiwen-zhao))
- Fixed the bug where kubelet couldn't output logs after log file rotated when `kubectl logs POD_NAME -f` is running. ([#115702](https://github.com/kubernetes/kubernetes/pull/115702), [@xyz-li](https://github.com/xyz-li))
- Fixed the calculation of the requeue time in the cronjob controller, resulting in proper handling of failed/stuck jobs. ([#121327](https://github.com/kubernetes/kubernetes/pull/121327), [@soltysh](https://github.com/soltysh))
- Fixed the issue where pod with ordinal number lower than the rolling partitioning number was being deleted. It was coming up with updated image. ([#120731](https://github.com/kubernetes/kubernetes/pull/120731), [@adilGhaffarDev](https://github.com/adilGhaffarDev))
- Fixed tracking of terminating Pods in the Job status. The field was not updated unless there were other changes to apply. ([#121342](https://github.com/kubernetes/kubernetes/pull/121342), [@dejanzele](https://github.com/dejanzele))
- Forbidden sysctls for pod sharing the respective namespaces with the host are now checked when creating or updating pods without such sysctls. ([#118705](https://github.com/kubernetes/kubernetes/pull/118705), [@pacoxu](https://github.com/pacoxu))
- If a watch with the `progressNotify` option set is to be created, and the registry hasn't provided a `newFunc`, an error is now returned. ([#120212](https://github.com/kubernetes/kubernetes/pull/120212), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Improved handling of jsonpath expressions for `kubectl wait --for`. It is now possible to use simple filter expressions which match on a field's content. ([#118748](https://github.com/kubernetes/kubernetes/pull/118748), [@andreaskaris](https://github.com/andreaskaris))
- In the `wait.PollUntilContextTimeout` function, if `immediate` is true, the condition will now be invoked before waiting, guaranteeing that the condition is invoked at least once and then wait a interval before executing again. ([#119762](https://github.com/kubernetes/kubernetes/pull/119762), [@AxeZhan](https://github.com/AxeZhan))
- KCCM: fixed transient node addition and removal caused by #121090 while syncing load balancers on large clusters with a lot of churn. ([#121091](https://github.com/kubernetes/kubernetes/pull/121091), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Kubeadm: changed the "system:masters" Group in the apiserver-kubelet-client.crt certificate Subject to be "kubeadm:cluster-admins" which is a less privileged Group. ([#121837](https://github.com/kubernetes/kubernetes/pull/121837), [@neolit123](https://github.com/neolit123))
- Incorporated feedback on PR #119341, on `failOpen` metric counting for mutate and validate webhooks ([#120087](https://github.com/kubernetes/kubernetes/pull/120087), [@divyasri537](https://github.com/divyasri537)) [SIG API Machinery]
- Metric buckets for `pod_start_duration_seconds` were changed to `{0.5, 1, 2, 3, 4, 5, 6, 8, 10, 20, 30, 45, 60, 120, 180, 240, 300, 360, 480, 600, 900, 1200, 1800, 2700, 3600}`. ([#120680](https://github.com/kubernetes/kubernetes/pull/120680), [@ruiwen-zhao](https://github.com/ruiwen-zhao))
- Mitigated http/2 DOS vulnerabilities for `CVE-2023-44487` and `CVE-2023-39325` for the API server when the client is unauthenticated. The mitigation may be disabled by setting the `UnauthenticatedHTTP2DOSMitigation` feature gate to `false` (it is enabled by default). An API server fronted by an L7 load balancer that already mitigates these http/2 attacks may choose to disable the kube-apiserver mitigation to avoid disrupting load balancer -> kube-apiserver connections if http/2 requests from multiple clients share the same backend connection. An API server on a private network may opt to disable the kube-apiserver mitigation to prevent performance regressions for unauthenticated clients. Authenticated requests rely on the fix in golang.org/x/net `v0.17.0` alone. https://issue.k8s.io/121197 tracks further mitigation of http/2 attacks by authenticated clients. ([#121120](https://github.com/kubernetes/kubernetes/pull/121120), [@enj](https://github.com/enj))
- No-op and GC related updates to cluster trust bundles no longer require attest authorization when the `ClusterTrustBundleAttest` plugin is enabled. ([#120779](https://github.com/kubernetes/kubernetes/pull/120779), [@enj](https://github.com/enj))
- Registered metric `apiserver_request_body_size_bytes` to track the size distribution of requests by `resource` and `verb`. ([#120474](https://github.com/kubernetes/kubernetes/pull/120474), [@YaoC](https://github.com/YaoC)) [SIG API Machinery and Instrumentation]
- Revised the logic for `DaemonSet` rolling update to exclude nodes if scheduling constraints are not met. This eliminates the problem of rolling updates to a `DaemonSet` getting stuck around tolerations. ([#119317](https://github.com/kubernetes/kubernetes/pull/119317), [@mochizuki875](https://github.com/mochizuki875))
- Scheduler: in `v1.29` pre-releases, enabling contextual logging slowed down pod scheduling. ([#121715](https://github.com/kubernetes/kubernetes/pull/121715), [@pohly](https://github.com/pohly)) [SIG Instrumentation and Scheduling]
- Service Controller: load balancer hosts will now update after node's `ProviderID` is updated. ([#120492](https://github.com/kubernetes/kubernetes/pull/120492), [@cezarygerard](https://github.com/cezarygerard))
- Setting the `status.loadBalancer` of a Service whose `spec.type` is not `LoadBalancer` was previously allowed, but any update to the `metadata` or `spec` would wipe that field. Setting this field is no longer permitted unless `spec.type` is `LoadBalancer`. In the very unlikely event that this has unexpected impact, you can enable the `AllowServiceLBStatusOnNonLB` feature gate, which will restore the previous behavior. If you do need to set this, please file an issue with the Kubernetes project to help contributors understand why you need it. ([#119789](https://github.com/kubernetes/kubernetes/pull/119789), [@thockin](https://github.com/thockin))
- The `--bind-address` parameter in kube-proxy is misleading, no port is opened with this address. Instead it is translated internally to "nodeIP". The nodeIPs for both families are now taken from the Node object if `--bind-address` is unspecified or set to the "any" address (0.0.0.0 or ::). It is recommended to leave `--bind-address` unspecified, and in particular avoid to set it to localhost (127.0.0.1 or ::1) ([#119525](https://github.com/kubernetes/kubernetes/pull/119525), [@uablrek](https://github.com/uablrek)) [SIG Network and Scalability]
- Updated `kube-openapi` to remove invalid defaults: OpenAPI spec no longer includes default of `{}` for certain fields where it did not make sense. ([#120757](https://github.com/kubernetes/kubernetes/pull/120757), [@alexzielenski](https://github.com/alexzielenski))
- Updated the CRI-O socket path, so users who configure kubelet to use a location like `/run/crio/crio.sock` don't see strange behaviour from CRI stats provider. ([#118704](https://github.com/kubernetes/kubernetes/pull/118704), [@dgl](https://github.com/dgl))
- Volume attach or publish operation will not fail at `kubelet` if target path directory already exists on the node. ([#119735](https://github.com/kubernetes/kubernetes/pull/119735), [@akankshapanse](https://github.com/akankshapanse))
- `cluster-bootstrap`: improved the security of the functions responsible for generation and validation of bootstrap tokens. ([#120400](https://github.com/kubernetes/kubernetes/pull/120400), [@neolit123](https://github.com/neolit123))
- `etcd`: updated to `v3.5.10`. ([#121566](https://github.com/kubernetes/kubernetes/pull/121566), [@mzaian](https://github.com/mzaian))
- `k8s.io/dynamic-resource-allocation/controller:` `UnsuitableNodes` can now handle a mix of allocated and unallocated claims correctly. ([#120338](https://github.com/kubernetes/kubernetes/pull/120338), [@pohly](https://github.com/pohly))
- `k8s.io/dynamic-resource-allocation/controller`: `ResourceClaimParameters` and `ResourceClassParameters` validation errors are now visible on `ResourceClaim`, `ResourceClass` and `Pod`. ([#121065](https://github.com/kubernetes/kubernetes/pull/121065), [@byako](https://github.com/byako))
- `k8s.io/dynamic-resource-allocation`: can now handle a `selected` node which isn't listed
  as `potential` node. ([#120871](https://github.com/kubernetes/kubernetes/pull/120871), [@pohly](https://github.com/pohly))
- `kube-proxy` now reports its health more accurately in dual-stack clusters when there are problems with only one IP family. ([#118146](https://github.com/kubernetes/kubernetes/pull/118146), [@aroradaman](https://github.com/aroradaman))
- `kubeadm`: fixed the bug where it always did CRI detection when `--config` was passed, even if it is not required by the subcommand. ([#120828](https://github.com/kubernetes/kubernetes/pull/120828), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: use universal deserializer to decode static pod. ([#120549](https://github.com/kubernetes/kubernetes/pull/120549), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: fix `nil` pointer when `etcd` member is already removed. ([#119753](https://github.com/kubernetes/kubernetes/pull/119753), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: fixed the bug where `--image-repository` flag is missing for some init
  phase sub-commands. ([#120072](https://github.com/kubernetes/kubernetes/pull/120072), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: improved the logic that checks whether a `systemd` service exists. ([#120514](https://github.com/kubernetes/kubernetes/pull/120514), [@fengxsong](https://github.com/fengxsong))
- `kubeadm`: will now use universal deserializer to decode static pod. ([#120549](https://github.com/kubernetes/kubernetes/pull/120549), [@pacoxu](https://github.com/pacoxu))
- `kubectl prune v2`: Switched annotation from `contains-group-resources` to `contains-group-kinds`,
  because this is what we defined in the KEP and is clearer to end-users. Although the functionality is
  in `alpha`, we will recognize the prior annotation. This migration support will be removed in `beta`/`GA`. ([#118942](https://github.com/kubernetes/kubernetes/pull/118942), [@justinsb](https://github.com/justinsb))
- `kubectl` will not print events if `--show-events=false` argument is passed to
  describe PVC subcommand. ([#120380](https://github.com/kubernetes/kubernetes/pull/120380), [@MaGaroo](https://github.com/MaGaroo))
- `scheduler`: Fixed missing field `apiVersion` from events reported by the taint
  manager. ([#114095](https://github.com/kubernetes/kubernetes/pull/114095), [@aimuz](https://github.com/aimuz))

### Other (Cleanup or Flake)

- Added automatic download of the CNI binary in `local-up-cluster.sh`, facilitating local debugging. ([#120312](https://github.com/kubernetes/kubernetes/pull/120312), [@HirazawaUi](https://github.com/HirazawaUi))
- Added context to `caches populated` log messages. ([#119796](https://github.com/kubernetes/kubernetes/pull/119796), [@sttts](https://github.com/sttts))
- Changed behavior of `kube-proxy` by allowing to set `sysctl` values lower than the existing one. ([#120448](https://github.com/kubernetes/kubernetes/pull/120448), [@aroradaman](https://github.com/aroradaman))
- Cleaned up `kube-apiserver` HTTP logs for impersonated requests. ([#119795](https://github.com/kubernetes/kubernetes/pull/119795), [@sttts](https://github.com/sttts))
- Deprecated the `--cloud-provider` and `--cloud-config` CLI parameters in kube-apiserver.
  These parameters will be removed in a future release. ([#120903](https://github.com/kubernetes/kubernetes/pull/120903), [@dims](https://github.com/dims)) [SIG API Machinery]
- Dynamic resource allocation: will now avoid creating a new gRPC connection for every call of prepare/unprepare resource(s). ([#118619](https://github.com/kubernetes/kubernetes/pull/118619), [@TommyStarK](https://github.com/TommyStarK))
- E2E storage tests: setting test tags like `[Slow]` via the `DriverInfo.FeatureTag` field is no longer supported. ([#121391](https://github.com/kubernetes/kubernetes/pull/121391), [@pohly](https://github.com/pohly))
- Fixed an issue where the `vsphere` cloud provider would not trust a certificate if:
  - The issuer of the certificate was unknown (`x509.UnknownAuthorityError`)
  - The requested name did not match the set of authorized names (`x509.HostnameError`)
  - The error surfaced after attempting a connection contained one of the substrings: "certificate is not trusted" or "certificate signed by unknown authority". ([#120736](https://github.com/kubernetes/kubernetes/pull/120736), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Fixed bug where `Adding GroupVersion` log line was constantly repeated without any group version changes. ([#119825](https://github.com/kubernetes/kubernetes/pull/119825), [@Jefftree](https://github.com/Jefftree))
- Generated `ResourceClaim` names are now more readable because of an additional hyphen before the random suffix (`<pod name>-<claim name>-<random suffix>`). ([#120336](https://github.com/kubernetes/kubernetes/pull/120336), [@pohly](https://github.com/pohly))
- Graduated `JobReadyPods` to `stable`. The feature gate can no longer be disabled. ([#121302](https://github.com/kubernetes/kubernetes/pull/121302), [@stuton](https://github.com/stuton))
- Improved memory usage of `kube-controller-manager` by dropping the `.metadata.managedFields` field that `kube-controller-manager` doesn't require. ([#118455](https://github.com/kubernetes/kubernetes/pull/118455), [@linxiulei](https://github.com/linxiulei))
- Lower and upper case feature flag values are now allowed, but the name still has to match. ([#121441](https://github.com/kubernetes/kubernetes/pull/121441), [@soltysh](https://github.com/soltysh))
- Makefile and scripts now respect `GOTOOLCHAIN` and otherwise ensure `./.go-version` is used. ([#120279](https://github.com/kubernetes/kubernetes/pull/120279), [@BenTheElder](https://github.com/BenTheElder))
- Migrated the remainder of the scheduler to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#120933](https://github.com/kubernetes/kubernetes/pull/120933), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation, Scheduling and Testing]
- Optimized `NodeUnschedulable` Filter to avoid unnecessary calculations. ([#119399](https://github.com/kubernetes/kubernetes/pull/119399), [@wackxu](https://github.com/wackxu))
- Previous versions of Kubernetes on Google Cloud required that workloads (e.g., Deployments, DaemonSets, etc.) which used `PersistentDisk` volumes were using them in read-only mode. This validation provided very little value at relatively host implementation cost, and will no longer be validated. If this is a problem for a specific use-case, please set the `SkipReadOnlyValidationGCE` gate to false to re-enable the validation, and file a Kubernetes bug with details. ([#121083](https://github.com/kubernetes/kubernetes/pull/121083), [@thockin](https://github.com/thockin))
- Previously, the pod name and namespace were eliminated in the event log message. This PR attempts to add the preemptor pod UID in the preemption event message logs for easier debugging and safer transparency. ([#119971](https://github.com/kubernetes/kubernetes/pull/119971), [@kwakubiney](https://github.com/kwakubiney)) [SIG Scheduling]
- Promoted to conformance a test that verified that `Services` only forward traffic on the port and protocol specified. ([#120069](https://github.com/kubernetes/kubernetes/pull/120069), [@aojea](https://github.com/aojea))
- Removed `GA` feature gate about `CSIMigrationvSphere`. ([#121291](https://github.com/kubernetes/kubernetes/pull/121291), [@bzsuni](https://github.com/bzsuni))
- Removed `GA` feature gate about `ProbeTerminationGracePeriod`. ([#121257](https://github.com/kubernetes/kubernetes/pull/121257), [@bzsuni](https://github.com/bzsuni))
- Removed `GA` feature gate for `JobTrackingWithFinalizers` in `v1.28`. ([#119100](https://github.com/kubernetes/kubernetes/pull/119100), [@bzsuni](https://github.com/bzsuni))
- Removed `GA`ed feature gate `TopologyManager`. ([#121252](https://github.com/kubernetes/kubernetes/pull/121252), [@tukwila](https://github.com/tukwila))
- Removed `GA`ed feature gates `OpenAPIV3`. ([#121255](https://github.com/kubernetes/kubernetes/pull/121255), [@tukwila](https://github.com/tukwila))
- Removed `GA`ed feature gates `SeccompDefault`. ([#121246](https://github.com/kubernetes/kubernetes/pull/121246), [@tukwila](https://github.com/tukwila))
- Removed ephemeral container legacy server support for the server versions prior to `1.22`. ([#119537](https://github.com/kubernetes/kubernetes/pull/119537), [@ardaguclu](https://github.com/ardaguclu))
- Removed the `CronJobTimeZone` feature gate (the feature is stable and always enabled)
  - Removed the `JobMutableNodeSchedulingDirectives` feature gate (the feature is stable and always enabled)
  - Removed the `LegacyServiceAccountTokenNoAutoGeneration` feature gate (the feature is stable and always enabled) ([#120192](https://github.com/kubernetes/kubernetes/pull/120192), [@SataQiu](https://github.com/SataQiu)) [SIG Apps, Auth and Scheduling]
- Removed the `DownwardAPIHugePages` feature gate (the feature is stable and always enabled) ([#120249](https://github.com/kubernetes/kubernetes/pull/120249), [@pacoxu](https://github.com/pacoxu)) [SIG Apps and Node]
- Removed the `GRPCContainerProbe` feature gate (the feature is stable and always enabled). ([#120248](https://github.com/kubernetes/kubernetes/pull/120248), [@pacoxu](https://github.com/pacoxu))
- Renamed `apiserver_request_body_sizes` metric to `apiserver_request_body_size_bytes`. ([#120503](https://github.com/kubernetes/kubernetes/pull/120503), [@dgrisonnet](https://github.com/dgrisonnet))
- Set the resolution for the `job_controller_job_sync_duration_seconds` metric from `4ms` to `1min`. ([#120577](https://github.com/kubernetes/kubernetes/pull/120577), [@alculquicondor](https://github.com/alculquicondor))
- The `horizontalpodautoscaling` and `clusterrole-aggregation` controllers now assume the `autoscaling/v1` and `rbac.authorization.k8s.io/v1` APIs are available. If you disable those APIs and do not want to run those controllers, exclude them by passing `--controllers=-horizontalpodautoscaling` or `--controllers=-clusterrole-aggregation` to `kube-controller-manager`. ([#117977](https://github.com/kubernetes/kubernetes/pull/117977), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Cloud Provider]
- The metrics controlled by the `ComponentSLIs` feature-gate and served at `/metrics/slis` are now GA and unconditionally enabled. The feature-gate will be removed in `v1.31`. ([#120574](https://github.com/kubernetes/kubernetes/pull/120574), [@logicalhan](https://github.com/logicalhan))
- Updated CNI plugins to `v1.3.0`. ([#119969](https://github.com/kubernetes/kubernetes/pull/119969), [@saschagrunert](https://github.com/saschagrunert))
- Updated `cri-tools` to `v1.28.0`. ([#119933](https://github.com/kubernetes/kubernetes/pull/119933), [@saschagrunert](https://github.com/saschagrunert))
- Updated `distroless-iptables` to use `registry.k8s.io/build-image/distroless-iptables:v0.3.1`. ([#120352](https://github.com/kubernetes/kubernetes/pull/120352), [@saschagrunert](https://github.com/saschagrunert))
- Updated runc to `1.1.10`. ([#121739](https://github.com/kubernetes/kubernetes/pull/121739), [@ty-dc](https://github.com/ty-dc))
- Upgraded `coredns` to `v1.11.1`. ([#120116](https://github.com/kubernetes/kubernetes/pull/120116), [@tukwila](https://github.com/tukwila))
- `EnqueueExtensions` from plugins other than `PreEnqueue`, `PreFilter`, `Filter`, `Reserve` and `Permit` are now ignored.
  It reduces the number of kinds of cluster events the scheduler needs to subscribe/handle. ([#121571](https://github.com/kubernetes/kubernetes/pull/121571), [@sanposhiho](https://github.com/sanposhiho))
- `GetPodQOS(pod *core.Pod)` function now returns the stored value from `PodStatus.QOSClass`, if set. To compute/evaluate the value of `QOSClass` from scratch, `ComputePodQOS(pod*core.Pod)` must be used. ([#119665](https://github.com/kubernetes/kubernetes/pull/119665), [@vinaykul](https://github.com/vinaykul))
- `RetroactiveDefaultStorageClass` feature gate that graduated to GA in `v1.28` and was unconditionally enabled has been removed in `v1.29`. ([#120861](https://github.com/kubernetes/kubernetes/pull/120861), [@RomanBednar](https://github.com/RomanBednar))
- `Statefulset` now waits for new replicas in tests when removing `.start.ordinal`. ([#119761](https://github.com/kubernetes/kubernetes/pull/119761), [@soltysh](https://github.com/soltysh))
- `ValidatingAdmissionPolicy` and `ValidatingAdmissionPolicyBinding` objects are
  persisted in `etcd` using the `v1beta1` version. Either remove alpha objects, or disable the
  alpha `ValidatingAdmissionPolicy` feature in a `v1.27` server before upgrading to a
  `v1.28` server with the beta feature and API enabled. ([#120018](https://github.com/kubernetes/kubernetes/pull/120018), [@liggitt](https://github.com/liggitt))
- `client-go`: `k8s.io/client-go/tools` events and record packages now have new APIs for specifying a context and logger. ([#120729](https://github.com/kubernetes/kubernetes/pull/120729), [@pohly](https://github.com/pohly))
- `kube-controller-manager` help now includes controllers behind a feature gate in `--controllers` flag. ([#120371](https://github.com/kubernetes/kubernetes/pull/120371), [@atiratree](https://github.com/atiratree))
- `kubeadm`: removed `system:masters` organization from `apiserver-etcd-client`
  certificate. ([#120521](https://github.com/kubernetes/kubernetes/pull/120521), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: removed leftover disclaimer that could be seen in the `kubeadm init phase certs` command help screen, since the "certs" phase of "init" is no longer alpha. ([#121172](https://github.com/kubernetes/kubernetes/pull/121172), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: updated warning message when swap space is detected. When swap is
  active on Linux, `kubeadm` explains that swap is supported for cgroup v2 only and
  is beta but disabled by default. ([#120198](https://github.com/kubernetes/kubernetes/pull/120198), [@pacoxu](https://github.com/pacoxu))
- `kubectl` will not support the `/swagger-2.0.0.pb-v1` endpoint that has been long deprecated. ([#119410](https://github.com/kubernetes/kubernetes/pull/119410), [@Jefftree](https://github.com/Jefftree))
- `scheduler`: handling of unschedulable pods because a `ResourceClass` is missing
  is a bit more efficient and no longer relies on periodic retries. ([#120213](https://github.com/kubernetes/kubernetes/pull/120213), [@pohly](https://github.com/pohly))
