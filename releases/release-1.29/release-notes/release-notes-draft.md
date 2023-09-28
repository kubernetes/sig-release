## Changes by Kind

### Deprecation

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
  --> ([#119495](https://github.com/kubernetes/kubernetes/pull/119495), [@bzsuni](https://github.com/bzsuni)) [SIG API Machinery]

### API Change

- Added a new `ipMode` field to the `.status` of Services where `type` is set to `LoadBalancer`.
  The new field is behind the `LoadBalancerIPMode` feature gate. ([#119937](https://github.com/kubernetes/kubernetes/pull/119937), [@RyanAoh](https://github.com/RyanAoh)) [SIG API Machinery, Apps, Cloud Provider, Network and Testing]
- Fixed a bug where CEL expressions in CRD validation rules would incorrectly compute a high estimated cost for functions that return strings, lists or maps.
  The incorrect cost was evident when the result of a function was used in subsequent operations. ([#119800](https://github.com/kubernetes/kubernetes/pull/119800), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth and Cloud Provider]
- Go API: the `ResourceRequirements` struct was replaced with `VolumeResourceRequirements` for use with volumes. ([#118653](https://github.com/kubernetes/kubernetes/pull/118653), [@pohly](https://github.com/pohly))
- Marked the `onPodConditions` field as optional in `Job`'s pod failure policy. ([#120204](https://github.com/kubernetes/kubernetes/pull/120204), [@mimowo](https://github.com/mimowo))
- Retry `NodeStageVolume` calls if the CSI node driver is not running. ([#120330](https://github.com/kubernetes/kubernetes/pull/120330), [@rohitssingh](https://github.com/rohitssingh))
- The `kube-scheduler` `selectorSpread` plugin has been removed, please use the `podTopologySpread` plugin instead. ([#117720](https://github.com/kubernetes/kubernetes/pull/117720), [@kerthcet](https://github.com/kerthcet))
- `kube-apiserver`: adds `--authentication-config` flag for reading `AuthenticationConfiguration`
  files. `--authentication-config` flag is mutually exclusive with the existing `--oidc-*`
  flags. ([#119142](https://github.com/kubernetes/kubernetes/pull/119142), [@aramase](https://github.com/aramase))
- `kube-scheduler` component config (`KubeSchedulerConfiguration`) `kubescheduler.config.k8s.io/v1beta3`
  is removed in `v1.29`. Migrate `kube-scheduler` configuration files to `kubescheduler.config.k8s.io/v1`. ([#119994](https://github.com/kubernetes/kubernetes/pull/119994), [@SataQiu](https://github.com/SataQiu))

### Feature

- Added `apiserver_envelope_encryption_dek_cache_filled` to measure number of records in data encryption key (DEK) cache. ([#119878](https://github.com/kubernetes/kubernetes/pull/119878), [@ritazh](https://github.com/ritazh))
- Added `kubectl node drain` helper callbacks `OnPodDeletionOrEvictionStarted`
  and `OnPodDeletionOrEvictionFailed`; people extending `kubectl` can use these
  new callbacks for more granularity. Deprecated the `OnPodDeletedOrEvicted`
  node drain helper callback. ([#117502](https://github.com/kubernetes/kubernetes/pull/117502), [@adilGhaffarDev](https://github.com/adilGhaffarDev))
- Added a new scheduler metric, `pod_scheduling_sli_duration_seconds`, and started the deprecation for `pod_scheduling_duration_seconds`. ([#119049](https://github.com/kubernetes/kubernetes/pull/119049), [@helayoty](https://github.com/helayoty))
- Added a return value to `QueueingHint` to indicate an error. If `QueueingHint` returns an error,
  the scheduler logs it and treats the event as a `QueueAfterBackoff` so that
  the Pod won't be stuck in the unschedulable pod pool. ([#119290](https://github.com/kubernetes/kubernetes/pull/119290), [@carlory](https://github.com/carlory))
- Added apiserver identity to the following metrics: 
  `apiserver_envelope_encryption_key_id_hash_total`, `apiserver_envelope_encryption_key_id_hash_last_timestamp_seconds`, `apiserver_envelope_encryption_key_id_hash_status_last_timestamp_seconds`, `apiserver_encryption_config_controller_automatic_reload_failures_total`, `apiserver_encryption_config_controller_automatic_reload_success_total`, `apiserver_encryption_config_controller_automatic_reload_last_timestamp_seconds`.
  
  Fixed bug to surface events for the following metrics: `apiserver_encryption_config_controller_automatic_reload_failures_total`, `apiserver_encryption_config_controller_automatic_reload_last_timestamp_seconds`, `apiserver_encryption_config_controller_automatic_reload_success_total`. ([#120438](https://github.com/kubernetes/kubernetes/pull/120438), [@ritazh](https://github.com/ritazh))
- Bumped `distroless-iptables` to `0.3.2` based on Go `1.21.1`. ([#120527](https://github.com/kubernetes/kubernetes/pull/120527), [@cpanato](https://github.com/cpanato))
- Changed `kubectl help` to display basic details for subcommands from plugins. ([#116752](https://github.com/kubernetes/kubernetes/pull/116752), [@xvzf](https://github.com/xvzf))
- Changed the `KMSv2KDF` feature gate to be enabled by default. ([#120433](https://github.com/kubernetes/kubernetes/pull/120433), [@enj](https://github.com/enj)) [SIG API Machinery, Auth and Testing]
- Fixed `kube-proxy` panicking on exit when the `Node` object changed its `PodCIDR`. ([#120375](https://github.com/kubernetes/kubernetes/pull/120375), [@pegasas](https://github.com/pegasas))
- Graduated API List chunking (aka pagination) feature to `stable`. ([#119503](https://github.com/kubernetes/kubernetes/pull/119503), [@wojtek-t](https://github.com/wojtek-t))
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
- Introduced new apiserver metric `apiserver_flowcontrol_current_inqueue_seats`. This metric is analogous to `apiserver_flowcontrol_current_inqueue_requests`, but tracks totals seats as each request can take more than 1 seat. ([#119385](https://github.com/kubernetes/kubernetes/pull/119385), [@andrewsykim](https://github.com/andrewsykim))
- Kubernetes is now built with Go `1.21.0`. ([#118996](https://github.com/kubernetes/kubernetes/pull/118996), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Go `1.21.1`. ([#120493](https://github.com/kubernetes/kubernetes/pull/120493), [@cpanato](https://github.com/cpanato))
- List the pods using `<PVC>` as an ephemeral storage volume in "Used by:" part of the output of `kubectl describe pvc <PVC>` command. ([#120427](https://github.com/kubernetes/kubernetes/pull/120427), [@MaGaroo](https://github.com/MaGaroo))
- Migrated the `nodevolumelimits` scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116884](https://github.com/kubernetes/kubernetes/pull/116884), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Promoted `ServiceNodePortStaticSubrange` to stable and lock to default. ([#120233](https://github.com/kubernetes/kubernetes/pull/120233), [@xuzhenglun](https://github.com/xuzhenglun))
- Removed `/livez` livezchecks for KMS v1 and v2 to ensure KMS health does not cause `kube-apiserver` restart. KMS health checks are still in place as a healthz and readiness checks. ([#120583](https://github.com/kubernetes/kubernetes/pull/120583), [@ritazh](https://github.com/ritazh))
- The `CloudDualStackNodeIPs` feature is now `beta`, meaning that when using
  an external cloud provider that has been updated to support the feature,
  you can pass comma-separated dual-stack `--node-ips` to `kubelet` and have
  the cloud provider take both IPs into account. ([#120275](https://github.com/kubernetes/kubernetes/pull/120275), [@danwinship](https://github.com/danwinship))
- The `Dockerfile` for the kubectl image has been updated with the addition of a specific base image and essential utilities (bash and jq). ([#119592](https://github.com/kubernetes/kubernetes/pull/119592), [@rayandas](https://github.com/rayandas))
- The `volume_zone` plugin will consider `beta` labels as `GA` labels during the scheduling
  process. Therefore, if the values of the labels are the same, PVs with `beta` labels
  can also be scheduled to nodes with `GA` labels. ([#118923](https://github.com/kubernetes/kubernetes/pull/118923), [@AxeZhan](https://github.com/AxeZhan))
- Use of secret-based service account tokens now adds an `authentication.k8s.io/legacy-token-autogenerated-secret` or `authentication.k8s.io/legacy-token-manual-secret` audit annotation containing the name of the secret used. ([#118598](https://github.com/kubernetes/kubernetes/pull/118598), [@yuanchen8911](https://github.com/yuanchen8911)) [SIG Auth, Instrumentation and Testing]
- `--sync-frequency` will not affect the update interval of volumes that use `ConfigMaps`
  or `Secrets` when the `configMapAndSecretChangeDetectionStrategy` is set to `Cache`.
  The update interval is only affected by `node.alpha.kubernetes.io/ttl` node annotation." ([#120255](https://github.com/kubernetes/kubernetes/pull/120255), [@likakuli](https://github.com/likakuli))
- `kube-proxy` will only install the `DROP` rules for invalid `conntrack` states if
  the `nf_conntrack_tcp_be_liberal` is not set. ([#120412](https://github.com/kubernetes/kubernetes/pull/120412), [@aojea](https://github.com/aojea))
- `kubeadm`: added validation to verify that the `CertificateKey` is a valid hex
  encoded AES key. ([#120064](https://github.com/kubernetes/kubernetes/pull/120064), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: promoted feature gate `EtcdLearnerMode` to `beta`. Learner mode for
  joining `etcd` members is now enabled by default. ([#120228](https://github.com/kubernetes/kubernetes/pull/120228), [@pacoxu](https://github.com/pacoxu))
- `kubelet` exposes latency metrics of different stages of the node startup. ([#118568](https://github.com/kubernetes/kubernetes/pull/118568), [@qiutongs](https://github.com/qiutongs))

### Documentation

- Added descriptions and examples for the situation of using `kubectl rollout restart` without specifying a particular deployment. ([#120118](https://github.com/kubernetes/kubernetes/pull/120118), [@Ithrael](https://github.com/Ithrael))

### Failing Test

- Added mock framework support for unit tests for Windows in `kubeproxy`. ([#120105](https://github.com/kubernetes/kubernetes/pull/120105), [@princepereira](https://github.com/princepereira))
- DRA: when the scheduler had to deallocate a claim after a node became unsuitable for a pod, it might have needed more attempts than really necessary. This was fixed by first disabling allocations. ([#120428](https://github.com/kubernetes/kubernetes/pull/120428), [@pohly](https://github.com/pohly))
- E2e framework: retrying after intermittent `apiserver` failures was fixed in `WaitForPodsResponding` ([#120559](https://github.com/kubernetes/kubernetes/pull/120559), [@pohly](https://github.com/pohly))
- KCM specific args can be passed with `/cluster` script, without affecting CCM. New variable name: `KUBE_CONTROLLER_MANAGER_TEST_ARGS`. ([#120524](https://github.com/kubernetes/kubernetes/pull/120524), [@jprzychodzen](https://github.com/jprzychodzen)) [SIG Cloud Provider]

### Bug or Regression

- Added a redundant process to remove tracking finalizers from Pods that belong to Jobs. The process kicks in after the control plane marks a Job as finished. ([#119944](https://github.com/kubernetes/kubernetes/pull/119944), [@Sharpz7](https://github.com/Sharpz7))
- Added more accurate requeueing in scheduling queue for Pods rejected by the temporal failure (e.g., temporal failure on `kube-apiserver`). ([#119105](https://github.com/kubernetes/kubernetes/pull/119105), [@sanposhiho](https://github.com/sanposhiho))
- Allowed specifying `ExternalTrafficPolicy` for `Services` with `ExternalIPs`. ([#119150](https://github.com/kubernetes/kubernetes/pull/119150), [@tnqn](https://github.com/tnqn))
- Fixed CEL estimated cost of `replace()` to handle a zero length replacement string correctly.
  Previously this would cause the estimated cost to be higher than it should be. ([#120097](https://github.com/kubernetes/kubernetes/pull/120097), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery]
- Fixed OpenAPI v3 not being cleaned up after deleting `APIServices`. ([#120108](https://github.com/kubernetes/kubernetes/pull/120108), [@tnqn](https://github.com/tnqn))
- Fixed `kubectl events` not filtering events by `GroupVersion` for resources with a full name. ([#120119](https://github.com/kubernetes/kubernetes/pull/120119), [@Ithrael](https://github.com/Ithrael))
- Fixed a `1.27` scheduling regression that `PostFilter` plugin may not function if previous `PreFilter` plugins return `Skip`. ([#119769](https://github.com/kubernetes/kubernetes/pull/119769), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed a `v1.26` regression scheduling bug by ensuring that preemption is skipped when a `PreFilter` plugin returns `UnschedulableAndUnresolvable`. ([#119778](https://github.com/kubernetes/kubernetes/pull/119778), [@sanposhiho](https://github.com/sanposhiho))
- Fixed a `v1.28` regression around restarting init containers in the right order relative to normal containers. ([#120281](https://github.com/kubernetes/kubernetes/pull/120281), [@gjkim42](https://github.com/gjkim42))
- Fixed a `v1.28` regression handling negative index json patches. ([#120327](https://github.com/kubernetes/kubernetes/pull/120327), [@liggitt](https://github.com/liggitt))
- Fixed a `v1.28` regression in scheduler: a pod with concurrent events could incorrectly get moved to the unschedulable queue where it could get stuck until the next periodic purging after 5 minutes, if there was no other event for it. ([#120413](https://github.com/kubernetes/kubernetes/pull/120413), [@pohly](https://github.com/pohly))
- Fixed a bug in the cronjob controller where already created jobs might be missing from the status. ([#120649](https://github.com/kubernetes/kubernetes/pull/120649), [@andrewsykim](https://github.com/andrewsykim))
- Fixed a bug where `Services` using finalizers may hold onto `ClusterIP` and/or `NodePort` allocated resources for longer than expected if the finalizer is removed using the status subresource. ([#120623](https://github.com/kubernetes/kubernetes/pull/120623), [@aojea](https://github.com/aojea))
- Fixed a concurrent map access in `TopologyCache`'s `HasPopulatedHints` method. ([#118189](https://github.com/kubernetes/kubernetes/pull/118189), [@Miciah](https://github.com/Miciah))
- Fixed a regression in the default `v1.27` configurations in `kube-apiserver`: fixed the `AggregatedDiscoveryEndpoint` feature (`beta` in `v1.27+`) to successfully fetch discovery information from aggregated API servers that do not check `Accept` headers when serving the `/apis` endpoint. ([#119870](https://github.com/kubernetes/kubernetes/pull/119870), [@Jefftree](https://github.com/Jefftree))
- Fixed a situation when, sometimes, the scheduler incorrectly placed a pod in the `unschedulable` queue instead of the `backoff` queue. This happened when some plugin previously declared the pod as `unschedulable` and then in a later attempt encounters some other error. Scheduling of that pod then got delayed by up to five minutes, after which periodic flushing moved the pod back into the `active` queue. ([#120334](https://github.com/kubernetes/kubernetes/pull/120334), [@pohly](https://github.com/pohly))
- Fixed an issue where `StatefulSet` might not restart a pod after eviction or node failure. ([#120398](https://github.com/kubernetes/kubernetes/pull/120398), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Fixed an issue where a `CronJob` could fail to clean up Jobs when the `ResourceQuota` for `Jobs` had been reached. ([#119776](https://github.com/kubernetes/kubernetes/pull/119776), [@ASverdlov](https://github.com/ASverdlov))
- Fixed an issue with the `garbagecollection` controller registering duplicate event handlers if discovery requests failed. ([#117992](https://github.com/kubernetes/kubernetes/pull/117992), [@liggitt](https://github.com/liggitt))
- Fixed issue with incremental id generation for `loadbalancer` and `endpoint` in `kubeproxy` mock test framework. ([#120723](https://github.com/kubernetes/kubernetes/pull/120723), [@princepereira](https://github.com/princepereira))
- Fixed the bug where images that were pinned by the container runtime could be garbage collected by `kubelet`. ([#119986](https://github.com/kubernetes/kubernetes/pull/119986), [@ruiwen-zhao](https://github.com/ruiwen-zhao))
- If a watch with the `progressNotify` option set is to be created, and the registry hasn't provided a `newFunc`, return an error. ([#120212](https://github.com/kubernetes/kubernetes/pull/120212), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Improved handling of jsonpath expressions for `kubectl wait --for`. It is now possible to use simple filter expressions which match on a field's content. ([#118748](https://github.com/kubernetes/kubernetes/pull/118748), [@andreaskaris](https://github.com/andreaskaris))
- Incorporating feedback on PR #119341 ([#120087](https://github.com/kubernetes/kubernetes/pull/120087), [@divyasri537](https://github.com/divyasri537)) [SIG API Machinery]
- No-op and GC related updates to cluster trust bundles no longer require attest authorization when the `ClusterTrustBundleAttest` plugin is enabled. ([#120779](https://github.com/kubernetes/kubernetes/pull/120779), [@enj](https://github.com/enj))
- Reintroduced `resourcequota.NewMonitor` constructor for other consumers. ([#120777](https://github.com/kubernetes/kubernetes/pull/120777), [@atiratree](https://github.com/atiratree))
- Revised the logic for `DaemonSet` rolling update to exclude nodes if scheduling constraints are not met. This eliminates the problem of rolling updates to a `DaemonSet` getting stuck around tolerations. ([#119317](https://github.com/kubernetes/kubernetes/pull/119317), [@mochizuki875](https://github.com/mochizuki875))
- Service Controller: update load balancer hosts after node's `ProviderID` is
  updated. ([#120492](https://github.com/kubernetes/kubernetes/pull/120492), [@cezarygerard](https://github.com/cezarygerard))
- Setting the `status.loadBalancer` of a Service whose `spec.type` is not `LoadBalancer` was previously allowed, but any update to the `metadata` or `spec` would wipe that field. Setting this field is no longer permitted unless `spec.type` is  `LoadBalancer`.  In the very unlikely event that this has unexpected impact, you can enable the `AllowServiceLBStatusOnNonLB` feature gate, which will restore the previous behavior.  If you do need to set this, please file an issue with the Kubernetes project to help contributors understand why you need it. ([#119789](https://github.com/kubernetes/kubernetes/pull/119789), [@thockin](https://github.com/thockin))
- The `--bind-address` parameter in kube-proxy is misleading, no port is opened with this address. Instead it is translated internally to "nodeIP". The nodeIPs for both families are now taken from the Node object if `--bind-address` is unspecified or set to the "any" address (0.0.0.0 or ::). It is recommended to leave `--bind-address` unspecified, and in particular avoid to set it to localhost (127.0.0.1 or ::1) ([#119525](https://github.com/kubernetes/kubernetes/pull/119525), [@uablrek](https://github.com/uablrek)) [SIG Network and Scalability]
- `kubeadm`: Use universal deserializer to decode static pod. ([#120549](https://github.com/kubernetes/kubernetes/pull/120549), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: fix `nil` pointer when `etcd` member is already removed. ([#119753](https://github.com/kubernetes/kubernetes/pull/119753), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: fixed the bug where `--image-repository` flag is missing for some init
  phase sub-commands. ([#120072](https://github.com/kubernetes/kubernetes/pull/120072), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: improved the logic that checks whether a `systemd` service exists. ([#120514](https://github.com/kubernetes/kubernetes/pull/120514), [@fengxsong](https://github.com/fengxsong))
- `kubeadm`: printing the default component configs for `reset` and `join` is now
  unsupported. ([#119346](https://github.com/kubernetes/kubernetes/pull/119346), [@chendave](https://github.com/chendave))
- `kubeadm`: remove `system:masters` organization from `etcd/healthcheck-client`
  certificate. ([#119859](https://github.com/kubernetes/kubernetes/pull/119859), [@SataQiu](https://github.com/SataQiu))
- `kubectl prune v2`: Switched annotation from `contains-group-resources` to `contains-group-kinds`,
  because this is what we defined in the KEP and is clearer to end-users.  Although the functionality is
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
- Dynamic resource allocation: avoid creating a new gRPC connection for every call of prepare/unprepare resource(s). ([#118619](https://github.com/kubernetes/kubernetes/pull/118619), [@TommyStarK](https://github.com/TommyStarK))
- Fixed an issue where the `vsphere` cloud provider would not trust a certificate if:
  - The issuer of the certificate was unknown (`x509.UnknownAuthorityError`)
  - The requested name did not match the set of authorized names (`x509.HostnameError`)
  - The error surfaced after attempting a connection contained one of the substrings: "certificate is not trusted" or "certificate signed by unknown authority". ([#120736](https://github.com/kubernetes/kubernetes/pull/120736), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Fixed bug where `Adding GroupVersion` log line was constantly repeated without any group version changes. ([#119825](https://github.com/kubernetes/kubernetes/pull/119825), [@Jefftree](https://github.com/Jefftree))
- Generated `ResourceClaim` names are now more readable because of an additional hyphen before the random suffix (`<pod name>-<claim name>-<random suffix>`). ([#120336](https://github.com/kubernetes/kubernetes/pull/120336), [@pohly](https://github.com/pohly))
- Improved memory usage of `kube-controller-manager` by dropping the `.metadata.managedFields` field that `kube-controller-manager` doesn't require. ([#118455](https://github.com/kubernetes/kubernetes/pull/118455), [@linxiulei](https://github.com/linxiulei))
- Makefile and scripts now respect `GOTOOLCHAIN` and otherwise ensure `./.go-version` is used. ([#120279](https://github.com/kubernetes/kubernetes/pull/120279), [@BenTheElder](https://github.com/BenTheElder))
- Optimized `NodeUnschedulable` Filter to avoid unnecessary calculations. ([#119399](https://github.com/kubernetes/kubernetes/pull/119399), [@wackxu](https://github.com/wackxu))
- Previously, the pod name and namespace were eliminated in the event log message. This PR attempts to add the preemptor pod UID in the preemption event message logs for easier debugging and safer transparency. ([#119971](https://github.com/kubernetes/kubernetes/pull/119971), [@kwakubiney](https://github.com/kwakubiney)) [SIG Scheduling]
- Promoted to conformance a test that verified that `Services` only forward traffic on the port and protocol specified. ([#120069](https://github.com/kubernetes/kubernetes/pull/120069), [@aojea](https://github.com/aojea))
- Removed ephemeral container legacy server support for the server versions prior to `1.22`. ([#119537](https://github.com/kubernetes/kubernetes/pull/119537), [@ardaguclu](https://github.com/ardaguclu))
- Set the resolution for the `job_controller_job_sync_duration_seconds` metric from `4ms` to `1min`. ([#120577](https://github.com/kubernetes/kubernetes/pull/120577), [@alculquicondor](https://github.com/alculquicondor))
- The `horizontalpodautoscaling` and `clusterrole-aggregation` controllers now assume the `autoscaling/v1` and `rbac.authorization.k8s.io/v1` APIs are available. If you disable those APIs and do not want to run those controllers, exclude them by passing `--controllers=-horizontalpodautoscaling` or `--controllers=-clusterrole-aggregation` to `kube-controller-manager`. ([#117977](https://github.com/kubernetes/kubernetes/pull/117977), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Cloud Provider]
- The metrics controlled by the `ComponentSLIs` feature-gate and served at `/metrics/slis` are now GA and unconditionally enabled. The feature-gate will be removed in `v1.31`. ([#120574](https://github.com/kubernetes/kubernetes/pull/120574), [@logicalhan](https://github.com/logicalhan))
- Updated CNI plugins to `v1.3.0`. ([#119969](https://github.com/kubernetes/kubernetes/pull/119969), [@saschagrunert](https://github.com/saschagrunert))
- Updated `cri-tools` to `v1.28.0`. ([#119933](https://github.com/kubernetes/kubernetes/pull/119933), [@saschagrunert](https://github.com/saschagrunert))
- Updated `distroless-iptables` to use `registry.k8s.io/build-image/distroless-iptables:v0.3.1`. ([#120352](https://github.com/kubernetes/kubernetes/pull/120352), [@saschagrunert](https://github.com/saschagrunert))
- Upgraded `coredns` to `v1.11.1`. ([#120116](https://github.com/kubernetes/kubernetes/pull/120116), [@tukwila](https://github.com/tukwila))
- `Statefulset` should wait for new replicas in tests when removing `.start.ordinal`. ([#119761](https://github.com/kubernetes/kubernetes/pull/119761), [@soltysh](https://github.com/soltysh))
- `ValidatingAdmissionPolicy` and `ValidatingAdmissionPolicyBinding` objects are
  persisted in `etcd` using the `v1beta1` version. Remove alpha objects or disable the
  alpha `ValidatingAdmissionPolicy` feature in a `v1.27` server before upgrading to a
  `v1.28` server with the beta feature and API enabled. ([#120018](https://github.com/kubernetes/kubernetes/pull/120018), [@liggitt](https://github.com/liggitt))
- `kubeadm`: removed `system:masters` organization from `apiserver-etcd-client`
  certificate. ([#120521](https://github.com/kubernetes/kubernetes/pull/120521), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: updated warning message when swap space is detected. When swap is
  active on Linux, `kubeadm` explains that swap is supported for cgroup v2 only and
  is beta but disabled by default. ([#120198](https://github.com/kubernetes/kubernetes/pull/120198), [@pacoxu](https://github.com/pacoxu))
- `kubectl` will not support the `/swagger-2.0.0.pb-v1` endpoint that has been long deprecated. ([#119410](https://github.com/kubernetes/kubernetes/pull/119410), [@Jefftree](https://github.com/Jefftree))
- `scheduler`: handling of unschedulable pods because a `ResourceClass` is missing
  is a bit more efficient and no longer relies on periodic retries. ([#120213](https://github.com/kubernetes/kubernetes/pull/120213), [@pohly](https://github.com/pohly))