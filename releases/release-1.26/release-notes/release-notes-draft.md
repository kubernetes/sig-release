## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Deprecated beta APIs scheduled for removal in 1.26 are no longer served. See https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-26 for more information. ([#111973](https://github.com/kubernetes/kubernetes/pull/111973), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
 
## Changes by Kind

### Deprecation


- CLI flag `pod-eviction-timeout` is deprecated and will be removed together with `enable-taint-manager` in `1.27`. ([#113710](https://github.com/kubernetes/kubernetes/pull/113710), [@kerthcet](https://github.com/kerthcet))
- Kube-apiserver: the unused `--master-service-namespace` flag was deprecated and will be removed in `1.27`. ([#112797](https://github.com/kubernetes/kubernetes/pull/112797), [@SataQiu](https://github.com/SataQiu))

- The `gcp` and `azure` auth plugins have been removed from `client-go` and `kubectl`. See [kubelogin](https://github.com/Azure/kubelogin) and [Kubectl Auth Changes in GKE](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) for details about the cloud-specific replacements. ([#112341](https://github.com/kubernetes/kubernetes/pull/112341), [@enj](https://github.com/enj))

### API Change

- Added auth API to get self subject attributes (new selfsubjectreviews API is added). 
  The corresponding command for kubectl is provided - `kubectl auth whoami`. ([#111333](https://github.com/kubernetes/kubernetes/pull/111333), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Auth, CLI and Testing]
- Clarified the CFS quota as 100ms in the code comments and set the minimum `cpuCFSQuotaPeriod` to 1ms to match Linux kernel expectations. ([#112123](https://github.com/kubernetes/kubernetes/pull/112123), [@paskal](https://github.com/paskal))
- Component-base: made the validation logic about `LeaderElectionConfiguration` consistent between component-base and client-go ([#111758](https://github.com/kubernetes/kubernetes/pull/111758), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery and Scheduling]
- Fixed spurious `field is immutable` errors validating updates to Event API objects via the `events.k8s.io/v1` API ([#112183](https://github.com/kubernetes/kubernetes/pull/112183), [@liggitt](https://github.com/liggitt)) [SIG Apps]
- Kubelet: changed default value of `cpuCFSQuotaPeriod` from 100ms to 100µs to match the Linux CFS and k8s defaults. `cpuCFSQuotaPeriod` of 100ms now requires `customCPUCFSQuotaPeriod` flag to be set to work. ([#111520](https://github.com/kubernetes/kubernetes/pull/111520), [@paskal](https://github.com/paskal))
- 'A new `preEnqueue` extension point was added to scheduler's component config
  `v1beta2/v1beta3/v1`.'
   ([#113275](https://github.com/kubernetes/kubernetes/pull/113275), [@Huang-Wei](https://github.com/Huang-Wei))
- 'Added a `ResourceClaim` API (in the `resource.k8s.io/v1alpha1` API group and
  behind the `DynamicResourceAllocation` feature gate).
  The new API is now more flexible than the existing Device Plugins feature of Kubernetes because it
  allows Pods to request (claim) special kinds of resources, which can be available at node level, cluster
  level, or following any other model you implement.' ([#111023](https://github.com/kubernetes/kubernetes/pull/111023), [@pohly](https://github.com/pohly))
- 'Container `preStop` and `postStart` lifecycle handlers using `httpGet` now
  honor the specified `scheme` and `headers` fields. This enables setting custom
  headers and changing the scheme to `HTTPS`, consistent with container
  startup/readiness/liveness probe capabilities. Lifecycle handlers configured
  with `scheme: HTTPS` that encounter errors indicating the endpoint is actually
  using `HTTP` fall back to making the request over `HTTP` for compatibility with
  previous releases. When this happens, a `LifecycleHTTPFallback` event is recorded
  in the namespace of the pod and a `kubelet_lifecycle_handler_http_fallbacks_total`
  metric in the kubelet is incremented. Cluster administrators can opt out of the
  expanded lifecycle handler capabilities by setting
  `--feature-gates=ConsistentHTTPGetHandlers=false` in `kubelet`.'
   ([#86139](https://github.com/kubernetes/kubernetes/pull/86139), [@jasimmons](https://github.com/jasimmons))
- 'Graduated `JobTrackingWithFinalizers` to stable.
  Jobs created before the feature was enabled are still tracked without finalizers.
  Jobs tracked with finalizers have the annotation batch.kubernetes.io/job-tracking.
  If the annotation is present and the user attempts to remove it, the control plane adds it back.
  The annotation `batch.kubernetes.io/job-tracking` is now deprecated.
  The control plane will ignore it and stop adding it for new Jobs in v1.27.' ([#113510](https://github.com/kubernetes/kubernetes/pull/113510), [@alculquicondor](https://github.com/alculquicondor))
- 'Priority and Fairness has introduced a new feature called _borrowing_ that allows an API priority level
  to borrow a number of seats from other priority level(s). As a cluster operator, you can enable borrowing
  for a certain priority level configuration object via the two newly introduced fields `lendablePercent`, and
  `borrowingLimitPercent` located under the `.spec.limited` field of the designated priority level.
  This change added the following metrics:
  - `apiserver_flowcontrol_nominal_limit_seats`: Nominal number of execution seats configured for each priority level
  - `apiserver_flowcontrol_lower_limit_seats`: Configured lower bound on number of execution seats available to each priority level
  - `apiserver_flowcontrol_upper_limit_seats`: Configured upper bound on number of execution seats available to each priority level
  - `apiserver_flowcontrol_demand_seats`: Observations, at the end of every nanosecond, of (the number of seats each priority level could use) / (nominal number of seats for that level)
  - `apiserver_flowcontrol_demand_seats_high_watermark`: High watermark, over last adjustment period, of demand_seats
  - `apiserver_flowcontrol_demand_seats_average`: Time-weighted average, over last adjustment period, of demand_seats
  - `apiserver_flowcontrol_demand_seats_stdev`: Time-weighted standard deviation, over last adjustment period, of demand_seats
  - `apiserver_flowcontrol_demand_seats_smoothed`: Smoothed seat demands
  - `apiserver_flowcontrol_target_seats`: Seat allocation targets
  - `apiserver_flowcontrol_seat_fair_frac`: Fair fraction of server's concurrency to allocate to each priority level that can use it
  - `apiserver_flowcontrol_current_limit_seats`: current derived number of execution seats available to each priority level
  The possibility of borrowing means that the old metric `apiserver_flowcontrol_request_concurrency_limit` can no longer mean both the configured concurrency limit and the enforced concurrency limit. Henceforth it means the configured concurrency limit.' ([#113485](https://github.com/kubernetes/kubernetes/pull/113485), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- '`NodeInclusionPolicy` in `podTopologySpread` plugin is now enabled by default.'
   ([#113500](https://github.com/kubernetes/kubernetes/pull/113500), [@kerthcet](https://github.com/kerthcet))
- '`PodDisruptionBudget` now adds an alpha `spec.unhealthyPodEvictionPolicy` field.
  When the `PDBUnhealthyPodEvictionPolicy` feature-gate is enabled in `kube-apiserver`,
  setting this field to `"AlwaysAllow"` allows pods to be evicted if they do not
  have a ready condition, regardless of whether the PodDisruptionBudget is currently
  healthy.'
   ([#113375](https://github.com/kubernetes/kubernetes/pull/113375), [@atiratree](https://github.com/atiratree))
- '`metav1.LabelSelectors` specified in API objects are now validated to ensure
  they do not contain invalid label values that will error at time of use. Existing
  invalid objects can be updated, but new objects are required to contain valid
  label selectors.'
   ([#113699](https://github.com/kubernetes/kubernetes/pull/113699), [@liggitt](https://github.com/liggitt))
- 'kubelet: Added the following Pod failure conditions:
  - `DisruptionTarget` (graceful node shutdown, node pressure eviction)' ([#112360](https://github.com/kubernetes/kubernetes/pull/112360), [@mimowo](https://github.com/mimowo))
- Added `percentageOfNodesToScore` as a scheduler profile level parameter to API version `v1`. When a profile `percentageOfNodesToScore` is set, it will override global `percentageOfNodesToScore`. ([#112521](https://github.com/kubernetes/kubernetes/pull/112521), [@yuanchen8911](https://github.com/yuanchen8911))
- Added auth API to get self subject attributes (new selfsubjectreviews API is added). 
  The corresponding command for kubectl is provided - `kubectl auth whoami`. ([#111333](https://github.com/kubernetes/kubernetes/pull/111333), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Auth, CLI and Testing]
- Added `kubernetes_feature_enabled` metric series to track whether each active feature gate is enabled. ([#112690](https://github.com/kubernetes/kubernetes/pull/112690), [@logicalhan](https://github.com/logicalhan))
- Added a `--topology-manager-policy-options` flag to the `kubelet` to support fine tuning the topology manager policies. The first policy option, `prefer-closest-numa-nodes`, allows these policies to favor sets of NUMA nodes with shorter distance between nodes when making admission decisions. ([#112914](https://github.com/kubernetes/kubernetes/pull/112914), [@PiotrProkop](https://github.com/PiotrProkop))
- Added a `kube-proxy` flag (`--iptables-localhost-nodeports`, default `true`) to allow disabling `NodePort` services on loopback addresses. Note: this only applies to iptables mode and ipv4. ([#108250](https://github.com/kubernetes/kubernetes/pull/108250), [@cyclinder](https://github.com/cyclinder))
- Added a feature that allows a `StatefulSet` to start numbering replicas from an arbitrary non-negative ordinal, using the `.spec.ordinals.start` field. ([#112744](https://github.com/kubernetes/kubernetes/pull/112744), [@pwschuurman](https://github.com/pwschuurman))
- Added a new namespace alpha field to `DataSourceRef` field in `PersistentVolumeClaim` API. ([#113186](https://github.com/kubernetes/kubernetes/pull/113186), [@ttakahashi21](https://github.com/ttakahashi21))
- Aggregated discovery will be alpha and can be toggled with the `AggregatedDiscoveryEndpoint` feature flag. ([#113171](https://github.com/kubernetes/kubernetes/pull/113171), [@Jefftree](https://github.com/Jefftree))
- Clarified the CFS quota as 100ms in the code comments and set the minimum `cpuCFSQuotaPeriod` to 1ms to match Linux kernel expectations. ([#112123](https://github.com/kubernetes/kubernetes/pull/112123), [@paskal](https://github.com/paskal))
- Component-base: make the validation logic about LeaderElectionConfiguration consistent between component-base and client-go ([#111758](https://github.com/kubernetes/kubernetes/pull/111758), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery and Scheduling]
- Deprecated the `apiserver_request_slo_duration_seconds` metric for v1.27 in favor of `apiserver_request_sli_duration_seconds` for naming consistency purposes with other SLI-specific metrics and to avoid any confusion between SLOs and SLIs. ([#112679](https://github.com/kubernetes/kubernetes/pull/112679), [@dgrisonnet](https://github.com/dgrisonnet))
- Enabled `kube-controller-manager` to support '--concurrent-horizontal-pod-autoscaler-syncs' flag to set the number of horizontal pod autoscaler controller workers. ([#108501](https://github.com/kubernetes/kubernetes/pull/108501), [@zroubalik](https://github.com/zroubalik))
- Enabled the "Retriable and non-retriable pod failures for jobs" feature into beta. ([#113360](https://github.com/kubernetes/kubernetes/pull/113360), [@mimowo](https://github.com/mimowo))
- Fixed spurious `field is immutable` errors validating updates to Event API objects via the `events.k8s.io/v1` API. ([#112183](https://github.com/kubernetes/kubernetes/pull/112183), [@liggitt](https://github.com/liggitt))
- Graduated `ServiceInternalTrafficPolicy` feature to GA. ([#113496](https://github.com/kubernetes/kubernetes/pull/113496), [@avoltz](https://github.com/avoltz))
- In 'kube-proxy`: The "userspace" proxy mode (deprecated for over a year) is no
  longer supported on either Linux or Windows. Users should use "iptables" or "ipvs"
  on Linux, or "kernelspace" on Windows.
   ([#112133](https://github.com/kubernetes/kubernetes/pull/112133), [@knabben](https://github.com/knabben))
- Introduce `v1beta3` for Priority and Fairness with the following changes to the API spec:
  - rename 'assuredConcurrencyShares' (located under `spec.limited') to 'nominalConcurrencyShares'.
  - apply strategic merge patch annotations to 'Conditions' of flowschemas and `prioritylevelconfigurations`. ([#112306](https://github.com/kubernetes/kubernetes/pull/112306), [@tkashem](https://github.com/tkashem))
- Introduced `v1alpha1` API for validating admission policies, enabling extensible admission control via CEL expressions (KEP  3488: CEL for Admission Control). To use, enable the `ValidatingAdmissionPolicy` feature gate and the `admissionregistration.k8s.io/v1alpha1` API via `--runtime-config`. ([#113314](https://github.com/kubernetes/kubernetes/pull/113314), [@cici37](https://github.com/cici37))
- KMS: added validation for duplicate kms config name when auto reload is enabled. If you enabled automatic reload of encryption configuration with API server flag `--encryption-provider-config-automatic-reload`, ensure all the KMS provider names (v1 and v2) in the encryption configuration are unique. ([#113697](https://github.com/kubernetes/kubernetes/pull/113697), [@aramase](https://github.com/aramase))
- Kubelet external Credential Provider feature is moved to GA. Credential Provider Plugin and Credential Provider Config APIs updated from `v1beta1` to `v1` with no API changes. ([#111616](https://github.com/kubernetes/kubernetes/pull/111616), [@ndixita](https://github.com/ndixita))
- Legacy klog flags are no longer available. Only `-v` and `-vmodule` are still supported. ([#112120](https://github.com/kubernetes/kubernetes/pull/112120), [@pohly](https://github.com/pohly)) [SIG Architecture, CLI, Instrumentation, Node and Testing]
- Moved `MixedProtocolLBService` from beta to GA. ([#112895](https://github.com/kubernetes/kubernetes/pull/112895), [@janosi](https://github.com/janosi))
- New Pod API field `.spec.schedulingGates` was introduced to enable users to control when to mark a Pod as scheduling ready. ([#113274](https://github.com/kubernetes/kubernetes/pull/113274), [@Huang-Wei](https://github.com/Huang-Wei))
- Protobuf serialization of metav1.MicroTime timestamps (used in `Lease` and `Event` API objects) has been corrected to truncate to microsecond precision, to match the documented behavior and JSON/YAML serialization. Any existing persisted data is truncated to microsecond when read from etcd. ([#111936](https://github.com/kubernetes/kubernetes/pull/111936), [@haoruan](https://github.com/haoruan))
- Reverted regression that prevented `client-go` latency metrics to be reported with a template URL to avoid label cardinality. ([#111752](https://github.com/kubernetes/kubernetes/pull/111752), [@aanm](https://github.com/aanm))

- The `EndpointSliceTerminatingCondition` feature gate was graduated to GA. The gate is now locked and will be removed in v1.28. ([#113351](https://github.com/kubernetes/kubernetes/pull/113351), [@andrewsykim](https://github.com/andrewsykim))
- [kubelet] Changed default `cpuCFSQuotaPeriod` value with enabled `cpuCFSQuotaPeriod` flag from 100ms to 100µs to match the Linux CFS and k8s defaults. `cpuCFSQuotaPeriod` of 100ms now requires `customCPUCFSQuotaPeriod` flag to be set to work. ([#111520](https://github.com/kubernetes/kubernetes/pull/111520), [@paskal](https://github.com/paskal)) [SIG API Machinery and Node]
- `DynamicKubeletConfig` feature gate has been removed from the API server.
  Dynamic kubelet reconfiguration now can't be used even when older nodes are still
  attempting to rely on it. This is aligned with the Kubernetes version skew policy.
   ([#112643](https://github.com/kubernetes/kubernetes/pull/112643), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- `kubectl wait` command with `jsonpath` flag will wait for target path until timeout.
   ([#109525](https://github.com/kubernetes/kubernetes/pull/109525), [@jonyhy96](https://github.com/jonyhy96))

### Feature

- A new `DisableCompression` field (default = `false`) has been added to kubeconfig under cluster info. When set to `true`, clients using the kubeconfig opt out of response compression for all requests to the apiserver. This can help improve list call latencies significantly when client-server network bandwidth is ample (>30MB/s) or if the server is CPU-constrained. ([#112309](https://github.com/kubernetes/kubernetes/pull/112309), [@shyamjvs](https://github.com/shyamjvs))
- API Server tracing root span name for opentelemetry is changed from `KubernetesAPI` to `HTTP GET`. ([#112545](https://github.com/kubernetes/kubernetes/pull/112545), [@dims](https://github.com/dims))
- Added new Golang runtime-related metrics to Kubernetes components:
  - go_gc_cycles_automatic_gc_cycles_total
  - go_gc_cycles_forced_gc_cycles_total
  - go_gc_cycles_total_gc_cycles_total
  - go_gc_heap_allocs_by_size_bytes
  - go_gc_heap_allocs_bytes_total
  - go_gc_heap_allocs_objects_total
  - go_gc_heap_frees_by_size_bytes
  - go_gc_heap_frees_bytes_total
  - go_gc_heap_frees_objects_total
  - go_gc_heap_goal_bytes
  - go_gc_heap_objects_objects
  - go_gc_heap_tiny_allocs_objects_total
  - go_gc_pauses_seconds
  - go_memory_classes_heap_free_bytes
  - go_memory_classes_heap_objects_bytes
  - go_memory_classes_heap_released_bytes
  - go_memory_classes_heap_stacks_bytes
  - go_memory_classes_heap_unused_bytes
  - go_memory_classes_metadata_mcache_free_bytes
  - go_memory_classes_metadata_mcache_inuse_bytes
  - go_memory_classes_metadata_mspan_free_bytes
  - go_memory_classes_metadata_mspan_inuse_bytes
  - go_memory_classes_metadata_other_bytes
  - go_memory_classes_os_stacks_bytes
  - go_memory_classes_other_bytes
  - go_memory_classes_profiling_buckets_bytes
  - go_memory_classes_total_bytes
  - go_sched_goroutines_goroutines
  - go_sched_latencies_seconds ([#111910](https://github.com/kubernetes/kubernetes/pull/111910), [@tosi3k](https://github.com/tosi3k))
- CSRDuration feature gate that graduated to GA in `1.24` and was unconditionally enabled removed in v1.26 ([#112386](https://github.com/kubernetes/kubernetes/pull/112386), [@Shubham82](https://github.com/Shubham82))
- Client-go: SharedInformerFactory supports waiting for goroutines during shutdown ([#112200](https://github.com/kubernetes/kubernetes/pull/112200), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Kube-apiserver: `gzip` compression switched from level 4 to level 1 to improve large list call latencies in exchange for higher network bandwidth usage (10-50% higher). This increases the headroom before very large unpaged list calls exceed request timeout limits. ([#112299](https://github.com/kubernetes/kubernetes/pull/112299), [@shyamjvs](https://github.com/shyamjvs))
- Kubeadm: "show-join-command" has been added as a new separate phase at the end of "kubeadm init". You can skip printing the join information by using "kubeadm init --skip-phases=show-join-command". Executing only this phase on demand will throw an error because the phase needs dependencies such as bootstrap tokens to be pre-populated. ([#111512](https://github.com/kubernetes/kubernetes/pull/111512), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: added the "--cleanup-tmp-dir" flag for `kubeadm reset`. It will cleanup the contents of `/etc/kubernetes/tmp`. The flag is off by default. ([#112172](https://github.com/kubernetes/kubernetes/pull/112172), [@chendave](https://github.com/chendave))
- Kubeadm: tries to load CA cert from external CertificateAuthority file when CertificateAuthorityData is empty for existing kubeconfig ([#111783](https://github.com/kubernetes/kubernetes/pull/111783), [@SataQiu](https://github.com/SataQiu))
- Kubernetes is now built with Go `1.19.1` ([#112287](https://github.com/kubernetes/kubernetes/pull/112287), [@palnabarun](https://github.com/palnabarun)) [SIG Release and Testing]
- Scheduler now retries updating a pod's status on ServiceUnavailable and InternalError errors, in addition to net ConnectionRefused error. ([#111809](https://github.com/kubernetes/kubernetes/pull/111809), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- The `goroutines` metric is newly added in the scheduler. 
  It replaces `scheduler_goroutines` metric and it counts the number of goroutine in more places than `scheduler_goroutine` does. ([#112003](https://github.com/kubernetes/kubernetes/pull/112003), [@sanposhiho](https://github.com/sanposhiho)) [SIG Instrumentation and Scheduling]
- Kubernetes is now built with Go `1.19.2` ([#112900](https://github.com/kubernetes/kubernetes/pull/112900), [@xmudrii](https://github.com/xmudrii)) [SIG Release and Testing]
- Kubernetes is now built with Go `1.19.3`. ([#113550](https://github.com/kubernetes/kubernetes/pull/113550), [@xmudrii](https://github.com/xmudrii))
- Logs of requests that were timed out by a timeout handler no longer contain a `statusStack` and `logging error output` fields. ([#112374](https://github.com/kubernetes/kubernetes/pull/112374), [@Argh4k](https://github.com/Argh4k))
- Metrics for `RetroactiveDefaultStorageClass` feature are now available. To see an attempt count for updating PVC retroactively with a default StorageClass see `retroactive_storageclass_total` metric and for total numer of errors see `retroactive_storageclass_errors_total`. ([#113323](https://github.com/kubernetes/kubernetes/pull/113323), [@RomanBednar](https://github.com/RomanBednar))
- Promoted `kubectl alpha events` to `kubectl events`. ([#113819](https://github.com/kubernetes/kubernetes/pull/113819), [@soltysh](https://github.com/soltysh))
- Promoted `WindowsHostProcessContainers` to stable. ([#113476](https://github.com/kubernetes/kubernetes/pull/113476), [@marosset](https://github.com/marosset))
- Scheduler now retries updating a pod's status on `ServiceUnavailable` and `InternalError` errors, in addition to `net.ConnectionRefused` error. ([#111809](https://github.com/kubernetes/kubernetes/pull/111809), [@Huang-Wei](https://github.com/Huang-Wei))
- Shell completion now shows plugin names when appropriate. Furthermore, shell completion will work for plugins that provide such support. ([#105867](https://github.com/kubernetes/kubernetes/pull/105867), [@marckhouzam](https://github.com/marckhouzam))
- Switched kubectl to use `github.com/russross/blackfriday/v2` ([#112731](https://github.com/kubernetes/kubernetes/pull/112731), [@pacoxu](https://github.com/pacoxu))
- The ExpandedDNSConfig feature has graduated to beta and is enabled by default. Note that this feature requires container runtime support. ([#112824](https://github.com/kubernetes/kubernetes/pull/112824), [@gjkim42](https://github.com/gjkim42)) [SIG Network and Testing]
- The `LegacyServiceAccountTokenNoAutoGeneration` feature gate was promoted to GA. ([#112838](https://github.com/kubernetes/kubernetes/pull/112838), [@zshihang](https://github.com/zshihang))
- The `ProxyTerminatingEndpoints` feature is now Beta and enabled by default. When enabled, kube-proxy will attempt to route traffic to terminating pods when the traffic policy is `Local` and there are only terminating pods remaining on a node. ([#113363](https://github.com/kubernetes/kubernetes/pull/113363), [@andrewsykim](https://github.com/andrewsykim))
- The `goroutines` metric is newly added in the scheduler. 
  It replaces `scheduler_goroutines` metric and it counts the number of goroutine in more places than `scheduler_goroutine` does. ([#112003](https://github.com/kubernetes/kubernetes/pull/112003), [@sanposhiho](https://github.com/sanposhiho)) [SIG Instrumentation and Scheduling]
- Updated `cAdvisor` to `v0.46.0`. ([#113769](https://github.com/kubernetes/kubernetes/pull/113769), [@bobbypage](https://github.com/bobbypage))
- Updated the Lease identity naming format for the `APIServerIdentity` feature to use a persistent name. ([#113307](https://github.com/kubernetes/kubernetes/pull/113307), [@andrewsykim](https://github.com/andrewsykim))
- When `ComponentSLIs` feature gate is enabled, `/metrics/slis` becomes available on kube-scheduler, allowing you to scrape health check metrics. ([#113026](https://github.com/kubernetes/kubernetes/pull/113026), [@Richabanker](https://github.com/Richabanker))
- When `ComponentSLIs` feature gate is enabled, then `/metrics/slis` becomes available on `kube-proxy` allowing you to scrape health check metrics. ([#113057](https://github.com/kubernetes/kubernetes/pull/113057), [@Richabanker](https://github.com/Richabanker))
- When `ComponentSLIs` feature gate is enabled, then `/metrics/slis` becomes available on kube-controller-manager, allowing you to scrape health check metrics. ([#112978](https://github.com/kubernetes/kubernetes/pull/112978), [@logicalhan](https://github.com/logicalhan))
- When the alpha `LegacyServiceAccountTokenTracking` feature gate is enabled, secret-based service account tokens will have a `kubernetes.io/legacy-token-last-used` applied to them containing the date they were last used. ([#108858](https://github.com/kubernetes/kubernetes/pull/108858), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth and Testing]
- `CSRDuration` feature gate that graduated to GA in `1.24` and is unconditionally
  enabled now removed in `1.26`.
   ([#112386](https://github.com/kubernetes/kubernetes/pull/112386), [@Shubham82](https://github.com/Shubham82))
- `kubectl config view` now automatically redacts any secret fields marked with a `datapolicy` tag. ([#109189](https://github.com/kubernetes/kubernetes/pull/109189), [@mpuckett159](https://github.com/mpuckett159))

### Documentation

- Clarified the default CFS quota period as being 100µs and not 100ms. ([#111554](https://github.com/kubernetes/kubernetes/pull/111554), [@paskal](https://github.com/paskal)) [SIG Node]
- ```
  
### Bug or Regression

- '`kubectl apply`: Added a warning that "`kubectl apply` will no longer prune
  non-namespaced resources by default when used with the `--namespace` flag in
  a future release".'
   ([#110907](https://github.com/kubernetes/kubernetes/pull/110907), [@pacoxu](https://github.com/pacoxu))
- Added back unused flags on `kubectl run` command, which did not go through the required deprecation period before being removed. ([#112243](https://github.com/kubernetes/kubernetes/pull/112243), [@brianpursley](https://github.com/brianpursley))
- Allowed Label section in vsphere e2e cloudprovider configuration ([#112427](https://github.com/kubernetes/kubernetes/pull/112427), [@gnufied](https://github.com/gnufied))
- Apiserver `/healthz/etcd` endpoint rate limits the number of forwarded health check requests to the etcd backends, answering with the last known state if the rate limit is exceeded. The rate limit is based on 1/2 of the timeout configured, with no burst allowed. ([#112046](https://github.com/kubernetes/kubernetes/pull/112046), [@aojea](https://github.com/aojea))
- Avoided propagating hosts' `search .` into containers' `/etc/resolv.conf` ([#112157](https://github.com/kubernetes/kubernetes/pull/112157), [@dghubble](https://github.com/dghubble))
- Apiserver: used the correct error when logging errors updating managedFields. ([#113711](https://github.com/kubernetes/kubernetes/pull/113711), [@andrewsykim](https://github.com/andrewsykim))
- Avoided propagating hosts `search .` into containers in `/etc/resolv.conf`. ([#112157](https://github.com/kubernetes/kubernetes/pull/112157), [@dghubble](https://github.com/dghubble))
- Bump `golang.org/x/net` to `v0.1.1-0.20221027164007-c63010009c80`. ([#112693](https://github.com/kubernetes/kubernetes/pull/112693), [@aimuz](https://github.com/aimuz))
- Bumped `runc` to `v1.1.4`. ([#113719](https://github.com/kubernetes/kubernetes/pull/113719), [@pacoxu](https://github.com/pacoxu))
- Callers using `DelegatingAuthenticationOptions` can now use `DisableAnonymous` to disable Anonymous authentication. ([#112181](https://github.com/kubernetes/kubernetes/pull/112181), [@xueqzhan](https://github.com/xueqzhan))
- Changed error message when resource is not supported by given patch type in `kubectl patch`. ([#112556](https://github.com/kubernetes/kubernetes/pull/112556), [@ardaguclu](https://github.com/ardaguclu))
- Corrected the calculating error in podTopologySpread plugin to avoid unexpected scheduling results. ([#112507](https://github.com/kubernetes/kubernetes/pull/112507), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Etcd: Updated to v3.5.5. ([#112489](https://github.com/kubernetes/kubernetes/pull/112489), [@dims](https://github.com/dims))
- Fixed an ephemeral port exhaustion bug caused by improper connection management that occurred when a large number of objects were handled by `kubectl` while exec auth was in use. ([#112017](https://github.com/kubernetes/kubernetes/pull/112017), [@enj](https://github.com/enj))
- Fixed bug in `kubectl rollout history` where only the latest revision was displayed when a specific revision was requested and an output format was specified. ([#111093](https://github.com/kubernetes/kubernetes/pull/111093), [@brianpursley](https://github.com/brianpursley))
- Fixed bug where dry run message was not printed when running kubectl label with --dry-run flag. ([#111571](https://github.com/kubernetes/kubernetes/pull/111571), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed list cost estimation in Priority and Fairness for list requests with `metadata.name` specified. ([#112557](https://github.com/kubernetes/kubernetes/pull/112557), [@marseel](https://github.com/marseel))
- Fixed race condition in GCE between containerized mounter setup in the kubelet. ([#112195](https://github.com/kubernetes/kubernetes/pull/112195), [@mattcary](https://github.com/mattcary))
- Fixed relative cpu priority for pods where containers explicitly request zero cpu by giving the lowest priority instead of falling back to the cpu limit to avoid possible cpu starvation of other pods ([#108832](https://github.com/kubernetes/kubernetes/pull/108832), [@waynepeking348](https://github.com/waynepeking348))
- For raw block CSI volumes on Kubernetes, kubelet was incorrectly calling CSI `NodeStageVolume` for every single "map" (i.e. raw block "mount") operation for a volume already attached to the node. This change modified that behavior to ensure it is only called once per volume per node. ([#112403](https://github.com/kubernetes/kubernetes/pull/112403), [@akankshakumari393](https://github.com/akankshakumari393))
- Improved `kubectl` display of invalid request errors returned by the API server. ([#112150](https://github.com/kubernetes/kubernetes/pull/112150), [@liggitt](https://github.com/liggitt))
- Increased the maximum backoff delay of the endpointslice controller to match the expected sequence of delays when syncing Services. ([#112353](https://github.com/kubernetes/kubernetes/pull/112353), [@dgrisonnet](https://github.com/dgrisonnet))
- Kube-apiserver: redirect responses are no longer returned from backends by default. Set `--aggregator-reject-forwarding-redirect=false` to continue forwarding redirect responses. ([#112193](https://github.com/kubernetes/kubernetes/pull/112193), [@jindijamie](https://github.com/jindijamie)) [SIG API Machinery and Testing]
- Kube-apiserver: resolved a regression that treated `304 Not Modified` responses from aggregated API servers as internal errors. ([#112526](https://github.com/kubernetes/kubernetes/pull/112526), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: x-kubernetes-list-type validation is now enforced when updating status of custom resources ([#111866](https://github.com/kubernetes/kubernetes/pull/111866), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery]
- Kube-proxy no longer falls back from ipvs mode to iptables mode if you ask it to do ipvs but the system is not correctly configured. Instead, it will just exit with an error. ([#111806](https://github.com/kubernetes/kubernetes/pull/111806), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Kube-scheduler: added taints filtering logic consistent with `TaintToleration` plugin for `PodTopologySpread` plugin. ([#112357](https://github.com/kubernetes/kubernetes/pull/112357), [@SataQiu](https://github.com/SataQiu))
- Kubeadm will cleanup the stale data on best effort basis. Stale data will be removed when each reset phase are executed, default etcd data directory will be cleanup when the `remove-etcd-member` phase are executed. ([#110972](https://github.com/kubernetes/kubernetes/pull/110972), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle]
- Kubeadm: allowed RSA and ECDSA format keys in preflight check ([#112508](https://github.com/kubernetes/kubernetes/pull/112508), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: when a sub command is needed but not provided for a kubeadm command, print a help screen instead of showing a short message. ([#111277](https://github.com/kubernetes/kubernetes/pull/111277), [@chymy](https://github.com/chymy))
- Log messages and metrics for the watch cache are now keyed by `<resource>.<group>` instead of `go` struct type. This means e.g. that `*v1.Pod` becomes `pods`. Additionally, resources that come from CustomResourceDefinitions are now displayed as the correct resource and group, instead of `*unstructured.Unstructured`. ([#111807](https://github.com/kubernetes/kubernetes/pull/111807), [@ncdc](https://github.com/ncdc)) [SIG API Machinery and Instrumentation]
- Kubectl: fixed a bug where `kubectl convert` did not pick the right API version ([#112700](https://github.com/kubernetes/kubernetes/pull/112700), [@SataQiu](https://github.com/SataQiu))
- Kubelet now cleans up the Node's cloud node IP annotation correctly if you
  stop using `--node-ip`. (In particular, this fixes the problem where people who
  were unnecessarily using `--node-ip` with an external cloud provider in `1.23`,
  and then running into problems with `1.24`, could not fix the problem by just
  removing the unnecessary `--node-ip` from the kubelet arguments, because
  that wouldn't remove the annotation that caused the problems.) ([#112184](https://github.com/kubernetes/kubernetes/pull/112184), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- Kubelet: fixed a startup crash in devicemanager. ([#113021](https://github.com/kubernetes/kubernetes/pull/113021), [@rphillips](https://github.com/rphillips))
- Kubelet: fixed log spam from kubelet_getters.go `Path does not exist`. ([#112650](https://github.com/kubernetes/kubernetes/pull/112650), [@rphillips](https://github.com/rphillips))
- Kubelet: fixed nil pointer in reflector start for standalone mode. ([#113501](https://github.com/kubernetes/kubernetes/pull/113501), [@pacoxu](https://github.com/pacoxu))
- Kubelet: when there are multi option lines in /etc/resolv.conf, merge all options into one line in a pod with the `Default` DNS policy. ([#112414](https://github.com/kubernetes/kubernetes/pull/112414), [@pacoxu](https://github.com/pacoxu)) [SIG Network and Node]
- Log messages and metrics for the watch cache are now keyed by `<resource>.<group>` instead of `go` struct type. This means e.g. that `*v1.Pod` becomes `pods`. Additionally, resources that come from `CustomResourceDefinitions` are displayed as the correct resource and group, instead of `*unstructured.Unstructured`. ([#111807](https://github.com/kubernetes/kubernetes/pull/111807), [@ncdc](https://github.com/ncdc))
- Moved `LocalStorageCapacityIsolationFSQuotaMonitoring` back to Alpha. ([#112076](https://github.com/kubernetes/kubernetes/pull/112076), [@rphillips](https://github.com/rphillips))
- Pod failed in scheduling due to expected error will be updated with the reason of `SchedulerError` rather than `Unschedulable`. ([#111999](https://github.com/kubernetes/kubernetes/pull/111999), [@kerthcet](https://github.com/kerthcet))
- Services of type LoadBalancer create fewer AWS security group rules in most cases ([#112267](https://github.com/kubernetes/kubernetes/pull/112267), [@sjenning](https://github.com/sjenning)) [SIG Cloud Provider]
- Pod logs using `--timestamps` are not broken up with timestamps anymore. ([#113481](https://github.com/kubernetes/kubernetes/pull/113481), [@rphillips](https://github.com/rphillips))
- Removed raising an error when setting an annotation with the same value, just ignore it. ([#109505](https://github.com/kubernetes/kubernetes/pull/109505), [@zigarn](https://github.com/zigarn))
- Resolved an issue that caused winkernel proxier to treat stale VIPs as valid. ([#113521](https://github.com/kubernetes/kubernetes/pull/113521), [@daschott](https://github.com/daschott))
- The `ResourceVersion` returned in objects from deleted responses are now consistent with the `ResourceVersion` contained in the delete watch event. ([#113369](https://github.com/kubernetes/kubernetes/pull/113369), [@wojtek-t](https://github.com/wojtek-t))
- The `kube-scheduler` and `kube-controller-manager` now use server side apply to set conditions related to pod disruption. ([#113304](https://github.com/kubernetes/kubernetes/pull/113304), [@mimowo](https://github.com/mimowo)) [SIG API Machinery, Apps and Scheduling]
- The errors in `k8s.io/apimachinery/pkg/api/meta` now support for the `stdlibs` `errors.Is` matching, including when wrapped. ([#111808](https://github.com/kubernetes/kubernetes/pull/111808), [@alvaroaleman](https://github.com/alvaroaleman))
- The metrics `etcd_request_duration_seconds` and `etcd_bookmark_counts` now differentiate by group resource instead of object type, allowing unique entries per `CustomResourceDefinition`, instead of grouping them all under `*unstructured.Unstructured`. ([#112042](https://github.com/kubernetes/kubernetes/pull/112042), [@ncdc](https://github.com/ncdc))
- Updated the system-validators library to v1.8.0 ([#112026](https://github.com/kubernetes/kubernetes/pull/112026), [@pacoxu](https://github.com/pacoxu))

### Other (Cleanup or Flake)

- E2e: tests can now register callbacks with `ginkgo.BeforeEach`, `ginkgo.AfterEach` or `ginkgo.DeferCleanup` directly after creating a framework instance and are guaranteed that their code is called after the framework is initialized and before it gets cleaned up. `ginkgo.DeferCleanup` replaces `f.AddAfterEach` and `AddCleanupAction` which got removed to simplify the framework. ([#111998](https://github.com/kubernetes/kubernetes/pull/111998), [@pohly](https://github.com/pohly))
- Kube scheduler Component Config release version v1beta3 is deprecated in `1.26` and will be removed in `1.29`, 
  also v1beta2 will be removed in `1.28`. ([#112257](https://github.com/kubernetes/kubernetes/pull/112257), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Kube-scheduler: the `DefaultPodTopologySpread`, `NonPreemptingPriority`, `PodAffinityNamespaceSelector` and `PreferNominatedNode` feature gates that graduated to GA in `1.24` and were unconditionally enabled have been removed in `1.26`. ([#112567](https://github.com/kubernetes/kubernetes/pull/112567), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: removed the toleration for the `node-role.kubernetes.io/master` taint from the CoreDNS deployment of `kubeadm`. With the `1.25` release of kubeadm the taint `node-role.kubernetes.io/master` is no longer applied to control plane nodes and the toleration for it can be removed with the release of `1.26`. You can also perform the same toleration removal from your own addon manifests. ([#112008](https://github.com/kubernetes/kubernetes/pull/112008), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: removed the usage of the `--container-runtime=remote` flag for the kubelet during kubeadm init/join/upgrade. The flag value `remote` had been the only possible value since `dockershim` was removed from the kubelet. ([#112000](https://github.com/kubernetes/kubernetes/pull/112000), [@pacoxu](https://github.com/pacoxu))
- Locked `ServerSideApply` feature gate to true with the feature already being GA. ([#112748](https://github.com/kubernetes/kubernetes/pull/112748), [@wojtek-t](https://github.com/wojtek-t))
- Refactored `test/e2e/framework` so that the core framework is smaller. Optional functionality like resource monitoring, log size monitoring, metrics gathering and debug information dumping must be imported by specific e2e test suites. Init packages are provided which can be imported to re-enable the functionality that traditionally was in the core framework. If you have code that no longer compiles because of this PR, you can use the script [from a commit message](https://github.com/kubernetes/kubernetes/pull/112043/commits/dfdf88d4faafa6fd39988832ea0ef6d668f490e9) to update that code. ([#112043](https://github.com/kubernetes/kubernetes/pull/112043), [@pohly](https://github.com/pohly))
- Removed `PodOverhead` feature gate as the feature is in GA since `v1.24`. ([#112579](https://github.com/kubernetes/kubernetes/pull/112579), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- Removed Windows Server, Version 20H2 flavors from various container images. ([#112924](https://github.com/kubernetes/kubernetes/pull/112924), [@marosset](https://github.com/marosset))
- Renamed the feature gate for CEL in Admission Control to `ValidatingAdmissionPolicy`. ([#113735](https://github.com/kubernetes/kubernetes/pull/113735), [@cici37](https://github.com/cici37))
- Reworded log message upon image garbage collection failure to be more clear. ([#112631](https://github.com/kubernetes/kubernetes/pull/112631), [@tzneal](https://github.com/tzneal)) [SIG Node]
- Scheduler dumper now exposes a summary to indicate the number of pending pods in each internal queue. ([#111726](https://github.com/kubernetes/kubernetes/pull/111726), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- The in-tree cloud provider for OpenStack (and the cinder volume provider) has been removed. Please use the external cloud provider and csi driver from https://github.com/kubernetes/cloud-provider-openstack instead. ([#67782](https://github.com/kubernetes/kubernetes/pull/67782), [@dims](https://github.com/dims))
- `GlusterFS` in-tree storage driver which was deprecated in kubernetes `1.25` release is now removed entirely in `1.26`. ([#112015](https://github.com/kubernetes/kubernetes/pull/112015), [@humblec](https://github.com/humblec))
