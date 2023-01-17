## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Deprecated beta APIs scheduled for removal in `v1.26` are no longer served. See https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-26 for more information. ([#111973](https://github.com/kubernetes/kubernetes/pull/111973), [@liggitt](https://github.com/liggitt))
 
## Changes by Kind

### Deprecation

- Kube-apiserver: the unused `--master-service-namespace` flag was deprecated and will be removed in v1.27. ([#112797](https://github.com/kubernetes/kubernetes/pull/112797), [@SataQiu](https://github.com/SataQiu))
- The `gcp` and `azure` auth plugins have been removed from `client-go` and `kubectl`. See [kubelogin](https://github.com/Azure/kubelogin) and [Kubectl Auth Changes in GKE](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) for details about the cloud-specific replacements. ([#112341](https://github.com/kubernetes/kubernetes/pull/112341), [@enj](https://github.com/enj))

### API Change

- 'Container `preStop` and `postStart` lifecycle handlers using `httpGet` now
  honor the specified `scheme` and `headers` fields. This enables setting custom
  headers and changing the scheme to `HTTPS`, consistent with container
  startup/readiness/liveness probe capabilities. Lifecycle handlers configured
  with `scheme: HTTPS` that encounter errors indicating the endpoint is actually
  using HTTP fall back to making the request over HTTP for compatibility with
  previous releases. When this happens, a `LifecycleHTTPFallback` event is recorded
  in the namespace of the pod and a `kubelet_lifecycle_handler_http_fallbacks_total`
  metric in the kubelet is incremented. Cluster administrators can opt out of the
  expanded lifecycle handler capabilities by setting
  `--feature-gates=ConsistentHTTPGetHandlers=false` in `kubelet`.'
   ([#86139](https://github.com/kubernetes/kubernetes/pull/86139), [@jasimmons](https://github.com/jasimmons))
- Add `percentageOfNodesToScore` as a scheduler profile level parameter to API version `v1`. When a profile `percentageOfNodesToScore` is set, it will override global `percentageOfNodesToScore`. ([#112521](https://github.com/kubernetes/kubernetes/pull/112521), [@yuanchen8911](https://github.com/yuanchen8911))
- Add auth API to get self subject attributes (new selfsubjectreviews API is added). 
  The corresponding command for kubctl is provided - `kubectl auth whoami`. ([#111333](https://github.com/kubernetes/kubernetes/pull/111333), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Auth, CLI and Testing]
- Added `kubernetes_feature_enabled` metric series to track whether each active feature gate is enabled. ([#112690](https://github.com/kubernetes/kubernetes/pull/112690), [@logicalhan](https://github.com/logicalhan))
- Clarified the CFS quota as 100ms in the code comments and set the minimum `cpuCFSQuotaPeriod` to 1ms to match Linux kernel expectations. ([#112123](https://github.com/kubernetes/kubernetes/pull/112123), [@paskal](https://github.com/paskal))
- Component-base: make the validation logic about LeaderElectionConfiguration consistent between component-base and client-go ([#111758](https://github.com/kubernetes/kubernetes/pull/111758), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery and Scheduling]
- Enabled `kube-controller-manager` to support '--concurrent-horizontal-pod-autoscaler-syncs' flag to set the number of horizontal pod autoscaler controller workers. ([#108501](https://github.com/kubernetes/kubernetes/pull/108501), [@zroubalik](https://github.com/zroubalik))
- Fixed spurious `field is immutable` errors validating updates to Event API objects via the `events.k8s.io/v1` API. ([#112183](https://github.com/kubernetes/kubernetes/pull/112183), [@liggitt](https://github.com/liggitt))
- In `kube-proxy`: The "userspace" proxy mode (deprecated for over a year) is no
  longer supported on either Linux or Windows. Users should use "iptables" or "ipvs"
  on Linux, or "kernelspace" on Windows.
   ([#112133](https://github.com/kubernetes/kubernetes/pull/112133), [@knabben](https://github.com/knabben))
- Introduce `v1beta3` for Priority and Fairness with the following changes to the API spec:
  - rename 'assuredConcurrencyShares' (located under `spec.limited') to 'nominalConcurrencyShares'.
  - apply strategic merge patch annotations to 'Conditions' of flowschemas and `prioritylevelconfigurations`. ([#112306](https://github.com/kubernetes/kubernetes/pull/112306), [@tkashem](https://github.com/tkashem))
- Kubelet external Credential Provider feature is moved to GA. Credential Provider Plugin and Credential Provider Config APIs updated from `v1beta1` to `v1` with no API changes. ([#111616](https://github.com/kubernetes/kubernetes/pull/111616), [@ndixita](https://github.com/ndixita))
- Legacy klog flags are no longer available. Only `-v` and `-vmodule` are still supported. ([#112120](https://github.com/kubernetes/kubernetes/pull/112120), [@pohly](https://github.com/pohly)) [SIG Architecture, CLI, Instrumentation, Node and Testing]
- Protobuf serialization of metav1.MicroTime timestamps (used in `Lease` and `Event` API objects) has been corrected to truncate to microsecond precision, to match the documented behavior and JSON/YAML serialization. Any existing persisted data is truncated to microsecond when read from etcd. ([#111936](https://github.com/kubernetes/kubernetes/pull/111936), [@haoruan](https://github.com/haoruan))
- Removed feature gates `ServiceLoadBalancerClass` and `ServiceLBNodePortControl`. These feature gates were enabled (and locked) since `v1.24`. ([#112577](https://github.com/kubernetes/kubernetes/pull/112577), [@andrewsykim](https://github.com/andrewsykim))
- Reverted regression that prevented `client-go` latency metrics to be reported with a template URL to avoid label cardinality. ([#111752](https://github.com/kubernetes/kubernetes/pull/111752), [@aanm](https://github.com/aanm))
- [kubelet] Change default `cpuCFSQuotaPeriod` value with enabled `cpuCFSQuotaPeriod` flag from 100ms to 100µs to match the Linux CFS and k8s defaults. `cpuCFSQuotaPeriod` of 100ms now requires `customCPUCFSQuotaPeriod` flag to be set to work. ([#111520](https://github.com/kubernetes/kubernetes/pull/111520), [@paskal](https://github.com/paskal)) [SIG API Machinery and Node]
- `DynamicKubeletConfig` feature gate has been removed from the API server.
  Dynamic kubelet reconfiguration now can't be used even when older nodes are still
  attempting to rely on it. This is aligned with the Kubernetes version skew policy.
   ([#112643](https://github.com/kubernetes/kubernetes/pull/112643), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- `kubectl wait` command with `jsonpath` flag will wait for target path until timeout.
   ([#109525](https://github.com/kubernetes/kubernetes/pull/109525), [@jonyhy96](https://github.com/jonyhy96))

### Feature

- '`registered_metric_total` will now report the number of metrics broken down by
  stability level and deprecated version.'
   ([#112907](https://github.com/kubernetes/kubernetes/pull/112907), [@logicalhan](https://github.com/logicalhan))
- A new `DisableCompression` field (default = `false`) has been added to kubeconfig under cluster info. When set to `true`, clients using the kubeconfig opt out of response compression for all requests to the apiserver. This can help improve list call latencies significantly when client-server network bandwidth is ample (>30MB/s) or if the server is CPU-constrained. ([#112309](https://github.com/kubernetes/kubernetes/pull/112309), [@shyamjvs](https://github.com/shyamjvs))
- A new `pod_status_sync_duration_seconds` histogram is reported at alpha metrics stability that estimates how long the Kubelet takes to write a pod status change once it is detected. ([#107896](https://github.com/kubernetes/kubernetes/pull/107896), [@smarterclayton](https://github.com/smarterclayton)) [SIG Apps, Architecture, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scheduling, Storage and Testing]
- API Server Tracing now includes a variety of new spans and span events. ([#113172](https://github.com/kubernetes/kubernetes/pull/113172), [@dashpole](https://github.com/dashpole)) [SIG API Machinery, Architecture, Auth, Instrumentation, Network, Node and Scheduling]
- API Server tracing root span name for opentelemetry is changed from `KubernetesAPI` to `HTTP GET`. ([#112545](https://github.com/kubernetes/kubernetes/pull/112545), [@dims](https://github.com/dims))
- Added `--disable-compression` flag to `kubectl` (default = false). When true, it opts out of response compression for all requests to the `apiserver`. This can help improve list call latencies significantly when client-server network bandwidth is ample (>30MB/s) or if the server is CPU-constrained. ([#112580](https://github.com/kubernetes/kubernetes/pull/112580), [@shyamjvs](https://github.com/shyamjvs))
- Added a new feature gate `CelValidatingAdmissionExtensibility` to enable expression validation for Admission Control. ([#112792](https://github.com/kubernetes/kubernetes/pull/112792), [@cici37](https://github.com/cici37)) [SIG API Machinery]
- Added categories column to the `kubectl api-resources` command's wide output (`-o wide`).
  Added `--categories` flag to the `kubectl api-resources` command, which can be used to filter the output to show only resources belonging to one or more categories. ([#111096](https://github.com/kubernetes/kubernetes/pull/111096), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Added kubelet metrics to track the cpumanager cpu allocation and pinning ([#112855](https://github.com/kubernetes/kubernetes/pull/112855), [@ffromani](https://github.com/ffromani))
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
- Added new metric `job_controller_terminated_pods_tracking_finalizer` which can be used to monitor whether the job controller is removing Pod finalizers from terminated Pods after accounting them in Job status. ([#113176](https://github.com/kubernetes/kubernetes/pull/113176), [@alculquicondor](https://github.com/alculquicondor))
- Added validation for the `--container-runtime-endpoint` flag of kubelet to be non-empty. ([#112542](https://github.com/kubernetes/kubernetes/pull/112542), [@astraw99](https://github.com/astraw99))
- Changed `preemption_victims` metric bucket from `LinearBuckets` to `ExponentialBuckets`. ([#112939](https://github.com/kubernetes/kubernetes/pull/112939), [@lengrongfu](https://github.com/lengrongfu))
- Exposed health check SLI metrics on `metrics/slis` for apiserver. ([#112741](https://github.com/kubernetes/kubernetes/pull/112741), [@logicalhan](https://github.com/logicalhan))
- Extend the job `job_finished_total metric by new `reason` label and introduce a new job metric to count pod failures
  handled by pod failure policy with respect to the action applied. ([#113324](https://github.com/kubernetes/kubernetes/pull/113324), [@mimowo](https://github.com/mimowo)) [SIG Apps and Testing]
- Graduate `ServiceIPStaticSubrange` feature to GA. ([#112163](https://github.com/kubernetes/kubernetes/pull/112163), [@aojea](https://github.com/aojea))
- If `ComponentSLIs` feature gate is enabled, then `/metrics/slis` becomes available on kubelet, allowing you to scrape health check metrics. ([#113030](https://github.com/kubernetes/kubernetes/pull/113030), [@Richabanker](https://github.com/Richabanker)) [SIG Node]
- If more than one StorageClass is designated as default (via the "storageclass.kubernetes.io/is-default-class" annotation), choose the newest one instead of throwing an error.' ([#110559](https://github.com/kubernetes/kubernetes/pull/110559), [@danishprakash](https://github.com/danishprakash))
- In 'client-go` `SharedInformerFactory` will now support waiting for goroutines during shutdown.
   ([#112200](https://github.com/kubernetes/kubernetes/pull/112200), [@pohly](https://github.com/pohly))
- In `kubeadm`, command `kubeadm join phase control-plane-prepare certs` now supports to run with `dry-run` mode on it's own. ([#113005](https://github.com/kubernetes/kubernetes/pull/113005), [@chendave](https://github.com/chendave))
- Kube-apiserver: `gzip` compression switched from level 4 to level 1 to improve large list call latencies in exchange for higher network bandwidth usage (10-50% higher). This increases the headroom before very large unpaged list calls exceed request timeout limits. ([#112299](https://github.com/kubernetes/kubernetes/pull/112299), [@shyamjvs](https://github.com/shyamjvs))
- Kubeadm: added `show-join-command` as a new separate phase at the end of `kubeadm init`. You can skip printing the join information by using `kubeadm init --skip-phases=show-join-command`. Executing only this phase on demand will throw an error because the phase needs dependencies such as bootstrap tokens to be pre-populated. ([#111512](https://github.com/kubernetes/kubernetes/pull/111512), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: added the "--cleanup-tmp-dir" flag for `kubeadm reset`. It will cleanup the contents of `/etc/kubernetes/tmp`. The flag is off by default. ([#112172](https://github.com/kubernetes/kubernetes/pull/112172), [@chendave](https://github.com/chendave))
- Kubeadm: now supports image repository format validation. ([#112732](https://github.com/kubernetes/kubernetes/pull/112732), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: sub-phases are now able to support the dry-run mode, e.g. kubeadm reset phase cleanup-node --dry-run ([#112945](https://github.com/kubernetes/kubernetes/pull/112945), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle]
- Kubeadm: tried to load CA cert from external CertificateAuthority file when CertificateAuthorityData is empty for existing kubeconfig. ([#111783](https://github.com/kubernetes/kubernetes/pull/111783), [@SataQiu](https://github.com/SataQiu))
- Kubernetes is now built with Go 1.19.1 ([#112287](https://github.com/kubernetes/kubernetes/pull/112287), [@palnabarun](https://github.com/palnabarun)) [SIG Release and Testing]
- Kubernetes is now built with Go 1.19.2 ([#112900](https://github.com/kubernetes/kubernetes/pull/112900), [@xmudrii](https://github.com/xmudrii)) [SIG Release and Testing]
- Logs of requests that were timed out by a timeout handler no longer contain a `statusStack` and `logging error output` fields. ([#112374](https://github.com/kubernetes/kubernetes/pull/112374), [@Argh4k](https://github.com/Argh4k))
- Metrics for `RetroactiveDefaultStorageClass` feature are now available. To see an attempt count for updating PVC retroactively with a default StorageClass see `retroactive_storageclass_total` metric and for total numer of errors see `retroactive_storageclass_errors_total`. ([#113323](https://github.com/kubernetes/kubernetes/pull/113323), [@RomanBednar](https://github.com/RomanBednar))
- Scheduler now retries updating a pod's status on `ServiceUnavailable` and `InternalError` errors, in addition to `net.ConnectionRefused` error. ([#111809](https://github.com/kubernetes/kubernetes/pull/111809), [@Huang-Wei](https://github.com/Huang-Wei))
- Shell completion now shows plugin names when appropriate. Furthermore, shell completion will work for plugins that provide such support. ([#105867](https://github.com/kubernetes/kubernetes/pull/105867), [@marckhouzam](https://github.com/marckhouzam))
- Switched kubectl to use `github.com/russross/blackfriday/v2` ([#112731](https://github.com/kubernetes/kubernetes/pull/112731), [@pacoxu](https://github.com/pacoxu))
- The ExpandedDNSConfig feature has graduated to beta and is enabled by default. Note that this feature requires container runtime support. ([#112824](https://github.com/kubernetes/kubernetes/pull/112824), [@gjkim42](https://github.com/gjkim42)) [SIG Network and Testing]
- The `goroutines` metric is newly added in the scheduler. 
  It replaces `scheduler_goroutines` metric and it counts the number of goroutine in more places than `scheduler_goroutine` does. ([#112003](https://github.com/kubernetes/kubernetes/pull/112003), [@sanposhiho](https://github.com/sanposhiho)) [SIG Instrumentation and Scheduling]
- When `ComponentSLIs` feature gate is enabled, `/metrics/slis` becomes available on kube-scheduler, allowing you to scrape health check metrics. ([#113026](https://github.com/kubernetes/kubernetes/pull/113026), [@Richabanker](https://github.com/Richabanker))
- When `ComponentSLIs` feature gate is enabled, then `/metrics/slis` becomes available on `kube-proxy` allowing you to scrape health check metrics. ([#113057](https://github.com/kubernetes/kubernetes/pull/113057), [@Richabanker](https://github.com/Richabanker))
- When `ComponentSLIs` feature gate is enabled, then `/metrics/slis` becomes available on kube-controller-manager, allowing you to scrape health check metrics. ([#112978](https://github.com/kubernetes/kubernetes/pull/112978), [@logicalhan](https://github.com/logicalhan))
- When the alpha `LegacyServiceAccountTokenTracking` feature gate is enabled, secret-based service account tokens will have a `kubernetes.io/legacy-token-last-used` applied to them containing the date they were last used. ([#108858](https://github.com/kubernetes/kubernetes/pull/108858), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth and Testing]
- `CSRDuration` feature gate that graduated to GA in 1.24 and is unconditionally
  enabled now removed in v1.26.
   ([#112386](https://github.com/kubernetes/kubernetes/pull/112386), [@Shubham82](https://github.com/Shubham82))

### Documentation

- Clarified the default CFS quota period as being 100µs and not 100ms. ([#111554](https://github.com/kubernetes/kubernetes/pull/111554), [@paskal](https://github.com/paskal)) [SIG Node]

### Bug or Regression

- Added back unused flags on `kubectl run` command, which did not go through the required deprecation period before being removed. ([#112243](https://github.com/kubernetes/kubernetes/pull/112243), [@brianpursley](https://github.com/brianpursley))
- Added support for RSA and ECDSA format keys in preflight check on `kubeadm`. ([#112508](https://github.com/kubernetes/kubernetes/pull/112508), [@SataQiu](https://github.com/SataQiu))
- Allowed `Label` section in vSphere e2e cloud provider configuration. ([#112427](https://github.com/kubernetes/kubernetes/pull/112427), [@gnufied](https://github.com/gnufied))
- Apiserver `/healthz/etcd` endpoint rate limits the number of forwarded health check requests to the etcd backends, answering with the last known state if the rate limit is exceeded. The rate limit is based on 1/2 of the timeout configured, with no burst allowed. ([#112046](https://github.com/kubernetes/kubernetes/pull/112046), [@aojea](https://github.com/aojea))
- Avoided propagating hosts `search .` into containers in `/etc/resolv.conf`. ([#112157](https://github.com/kubernetes/kubernetes/pull/112157), [@dghubble](https://github.com/dghubble))
- Bump `golang.org/x/net` to `v0.1.1-0.20221027164007-c63010009c80`. ([#112693](https://github.com/kubernetes/kubernetes/pull/112693), [@aimuz](https://github.com/aimuz))
- Callers using `DelegatingAuthenticationOptions` can now use `DisableAnonymous` to disable Anonymous authentication. ([#112181](https://github.com/kubernetes/kubernetes/pull/112181), [@xueqzhan](https://github.com/xueqzhan))
- Changed error message when resource is not supported by given patch type in `kubectl patch`. ([#112556](https://github.com/kubernetes/kubernetes/pull/112556), [@ardaguclu](https://github.com/ardaguclu))
- Correct the calculating error in `podTopologySpread` plugin to avoid unexpected scheduling results. ([#112507](https://github.com/kubernetes/kubernetes/pull/112507), [@kerthcet](https://github.com/kerthcet))
- Etcd: Updated to v3.5.5. ([#112489](https://github.com/kubernetes/kubernetes/pull/112489), [@dims](https://github.com/dims))
- Fixed Admission controllers that caused unnecessary significant load on `apiserver'. ([#112696](https://github.com/kubernetes/kubernetes/pull/112696), [@aimuz](https://github.com/aimuz))
- Fixed a bug where a change in the `appProtocol` for a Service did not trigger a load balancer update. ([#112785](https://github.com/kubernetes/kubernetes/pull/112785), [@MartinForReal](https://github.com/MartinForReal)) [SIG Cloud Provider and Network]
- Fixed a bug where the kubelet choose the wrong container by its name when running `kubectl exec`. ([#113041](https://github.com/kubernetes/kubernetes/pull/113041), [@saschagrunert](https://github.com/saschagrunert))
- Fixed an ephemeral port exhaustion bug caused by improper connection management that occurred when a large number of objects were handled by `kubectl` while exec auth was in use. ([#112017](https://github.com/kubernetes/kubernetes/pull/112017), [@enj](https://github.com/enj))
- Fixed an issue in `winkernel` proxier that causes proxy rules to leak anytime service backends are modified. ([#112837](https://github.com/kubernetes/kubernetes/pull/112837), [@daschott](https://github.com/daschott))
- Fixed bug in `kubectl rollout history` where only the latest revision was displayed when a specific revision was requested and an output format was specified. ([#111093](https://github.com/kubernetes/kubernetes/pull/111093), [@brianpursley](https://github.com/brianpursley))
- Fixed bug where dry run message was not printed when running `kubectl label` with `--dry-run` flag. ([#111571](https://github.com/kubernetes/kubernetes/pull/111571), [@brianpursley](https://github.com/brianpursley))
- Fixed code to ensure that pods running on nodes tainted with `NoExecute` continue to run when the `PodDisruptionConditions` feature gate is enabled. ([#112518](https://github.com/kubernetes/kubernetes/pull/112518), [@mimowo](https://github.com/mimowo))
- Fixed issue where the APIServer would panic on startup if an egress selector without a controlplane configuration is specified when using APIServerTracing. ([#112979](https://github.com/kubernetes/kubernetes/pull/112979), [@dashpole](https://github.com/dashpole))
- Fixed list cost estimation in Priority and Fairness for list requests with `metadata.name` specified. ([#112557](https://github.com/kubernetes/kubernetes/pull/112557), [@marseel](https://github.com/marseel))
- Fixed race condition in GCE between containerized mounter setup in the kubelet. ([#112195](https://github.com/kubernetes/kubernetes/pull/112195), [@mattcary](https://github.com/mattcary))
- Fixed relative CPU priority for pods where containers explicitly request zero cpu by giving the lowest priority instead of falling back to the cpu limit to avoid possible cpu starvation of other pods. ([#108832](https://github.com/kubernetes/kubernetes/pull/108832), [@waynepeking348](https://github.com/waynepeking348))
- Fixed the occasional double-counting of the `job_finished_total` metric. ([#112948](https://github.com/kubernetes/kubernetes/pull/112948), [@mimowo](https://github.com/mimowo))
- For raw block CSI volumes on Kubernetes, kubelet was incorrectly calling CSI `NodeStageVolume` for every single "map" (i.e. raw block "mount") operation for a volume already attached to the node. This change modified that behavior to ensure it is only called once per volume per node. ([#112403](https://github.com/kubernetes/kubernetes/pull/112403), [@akankshakumari393](https://github.com/akankshakumari393))
- Improved `kubectl` display of invalid request errors returned by the API server. ([#112150](https://github.com/kubernetes/kubernetes/pull/112150), [@liggitt](https://github.com/liggitt))
- In 'kube-apiserver`,`x-kubernetes-list-type` validation is now enforced when updating status of custom resources.' ([#111866](https://github.com/kubernetes/kubernetes/pull/111866), [@pacoxu](https://github.com/pacoxu))
- In `kube-apiserver`, custom resources can now be specified in the `--encryption-provider-config` file and can be encrypted in etcd. ([#113015](https://github.com/kubernetes/kubernetes/pull/113015), [@ritazh](https://github.com/ritazh))
- Increased the maximum backoff delay of the endpointslice controller to match the expected sequence of delays when syncing Services. ([#112353](https://github.com/kubernetes/kubernetes/pull/112353), [@dgrisonnet](https://github.com/dgrisonnet))
- Kube-apiserver: `DELETECOLLECTION API` requests are now recorded in metrics with the correct verb. ([#113133](https://github.com/kubernetes/kubernetes/pull/113133), [@sxllwx](https://github.com/sxllwx))
- Kube-apiserver: redirect responses are no longer returned from backends by default. Set `--aggregator-reject-forwarding-redirect=false` to continue forwarding redirect responses. ([#112193](https://github.com/kubernetes/kubernetes/pull/112193), [@jindijamie](https://github.com/jindijamie)) [SIG API Machinery and Testing]
- Kube-apiserver: redirects from backend API servers are no longer followed when checking availability with requests to `/apis/$group/$version` ([#112772](https://github.com/kubernetes/kubernetes/pull/112772), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- Kube-apiserver: resolved a regression that treated `304 Not Modified` responses from aggregated API servers as internal errors. ([#112526](https://github.com/kubernetes/kubernetes/pull/112526), [@liggitt](https://github.com/liggitt))
- Kube-proxy no longer falls back from ipvs mode to iptables mode if you ask it to do ipvs but the system is not correctly configured. Instead, it will just exit with an error. ([#111806](https://github.com/kubernetes/kubernetes/pull/111806), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Kube-scheduler: added taints filtering logic consistent with `TaintToleration` plugin for `PodTopologySpread` plugin. ([#112357](https://github.com/kubernetes/kubernetes/pull/112357), [@SataQiu](https://github.com/SataQiu))
- Kubeadm will cleanup the stale data on best effort basis. Stale data will be removed when each reset phase are executed, default etcd data directory will be cleanup when the `remove-etcd-member` phase are executed. ([#110972](https://github.com/kubernetes/kubernetes/pull/110972), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle]
- Kubeadm: fixed a bug when performing validation on `ClusterConfiguration` networking fields. ([#112751](https://github.com/kubernetes/kubernetes/pull/112751), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: when a sub command is needed but not provided for a kubeadm command, print a help screen instead of showing a short message. ([#111277](https://github.com/kubernetes/kubernetes/pull/111277), [@chymy](https://github.com/chymy))
- Kubectl: fixed a bug where `kubectl convert` did not pick the right API version ([#112700](https://github.com/kubernetes/kubernetes/pull/112700), [@SataQiu](https://github.com/SataQiu))
- Kubelet now cleans up the Node's cloud node IP annotation correctly if you
  stop using `--node-ip`. (In particular, this fixes the problem where people who
  were unnecessarily using `--node-ip` with an external cloud provider in 1.23,
  and then running into problems with 1.24, could not fix the problem by just
  removing the unnecessary `--node-ip` from the kubelet arguments, because
  that wouldn't remove the annotation that caused the problems.) ([#112184](https://github.com/kubernetes/kubernetes/pull/112184), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- Kubelet: fixed log spam from kubelet_getters.go `Path does not exist`. ([#112650](https://github.com/kubernetes/kubernetes/pull/112650), [@rphillips](https://github.com/rphillips))
- Kubelet: when there are multi option lines in /etc/resolv.conf, merge all options into one line in a pod with the `Default` DNS policy. ([#112414](https://github.com/kubernetes/kubernetes/pull/112414), [@pacoxu](https://github.com/pacoxu)) [SIG Network and Node]
- Log messages and metrics for the watch cache are now keyed by `<resource>.<group>` instead of `go` struct type. This means e.g. that `*v1.Pod` becomes `pods`. Additionally, resources that come from `CustomResourceDefinitions` are displayed as the correct resource and group, instead of `*unstructured.Unstructured`. ([#111807](https://github.com/kubernetes/kubernetes/pull/111807), [@ncdc](https://github.com/ncdc))
- Moved `LocalStorageCapacityIsolationFSQuotaMonitoring` back to Alpha. ([#112076](https://github.com/kubernetes/kubernetes/pull/112076), [@rphillips](https://github.com/rphillips))
- Nested `MountPoints` are now grouped correctly on all cases. ([#112571](https://github.com/kubernetes/kubernetes/pull/112571), [@claudiubelu](https://github.com/claudiubelu))
- Pod failed in scheduling due to expected error will be updated with the reason of `SchedulerError` rather than `Unschedulable`. ([#111999](https://github.com/kubernetes/kubernetes/pull/111999), [@kerthcet](https://github.com/kerthcet))
- The `kube-scheduler` and `kube-controller-manager` now use server side apply to set conditions related to pod disruption. ([#113304](https://github.com/kubernetes/kubernetes/pull/113304), [@mimowo](https://github.com/mimowo)) [SIG API Machinery, Apps and Scheduling]
- The errors in `k8s.io/apimachinery/pkg/api/meta` now support for the `stdlibs` `errors.Is` matching, including when wrapped. ([#111808](https://github.com/kubernetes/kubernetes/pull/111808), [@alvaroaleman](https://github.com/alvaroaleman))
- The metrics `etcd_request_duration_seconds` and `etcd_bookmark_counts` now differentiate by group resource instead of object type, allowing unique entries per `CustomResourceDefinition`, instead of grouping them all under `*unstructured.Unstructured`. ([#112042](https://github.com/kubernetes/kubernetes/pull/112042), [@ncdc](https://github.com/ncdc))
- The pod admission error message was improved for usability. ([#112644](https://github.com/kubernetes/kubernetes/pull/112644), [@vitorfhc](https://github.com/vitorfhc)) [SIG Node]
- The time duration of a failed or unschedulable scheduling attempt will be longer, it 
  now includes the time duration of the unreserve operation. ([#113113](https://github.com/kubernetes/kubernetes/pull/113113), [@kerthcet](https://github.com/kerthcet))
- Updated `kube-proxy` to restart in case it detects that the Node assigned `pod.Spec.PodCIDRs` have changed. ([#111344](https://github.com/kubernetes/kubernetes/pull/111344), [@aojea](https://github.com/aojea))
- Updated creation of `LoadBalancer` services, for there to be fewer AWS security group rules in most cases. ([#112267](https://github.com/kubernetes/kubernetes/pull/112267), [@sjenning](https://github.com/sjenning))
- Updated the system-validators library to v1.8.0 ([#112026](https://github.com/kubernetes/kubernetes/pull/112026), [@pacoxu](https://github.com/pacoxu))
- Updates `golang.org/x/text`` to `v0.3.8`` to fix CVE-2022-32149 ([#112989](https://github.com/kubernetes/kubernetes/pull/112989), [@ameukam](https://github.com/ameukam))
- Volume mount cleanup now considers only plugin directory and not the entire kubelet root ([#112607](https://github.com/kubernetes/kubernetes/pull/112607), [@mattcary](https://github.com/mattcary))
- `kubectl` now escapes terminal special characters in output. This fixes CVE-2021-25743.
   ([#112553](https://github.com/kubernetes/kubernetes/pull/112553), [@dgl](https://github.com/dgl))

### Other (Cleanup or Flake)

- Added a `kubernetes_feature_enabled` metric which will tell you if a feature is enabled. ([#112652](https://github.com/kubernetes/kubernetes/pull/112652), [@logicalhan](https://github.com/logicalhan))
- E2e: tests can now register callbacks with `ginkgo.BeforeEach`, `ginkgo.AfterEach` or `ginkgo.DeferCleanup` directly after creating a framework instance and are guaranteed that their code is called after the framework is initialized and before it gets cleaned up. `ginkgo.DeferCleanup` replaces `f.AddAfterEach` and `AddCleanupAction` which got removed to simplify the framework. ([#111998](https://github.com/kubernetes/kubernetes/pull/111998), [@pohly](https://github.com/pohly))
- Introduce `ComponentSLIs` alpha feature-gate for component SLIs metrics endpoint. ([#112884](https://github.com/kubernetes/kubernetes/pull/112884), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery]
- Kube scheduler Component Config release version v1beta3 is deprecated in v1.26 and will be removed in v1.29, 
  also v1beta2 will be removed in v1.28. ([#112257](https://github.com/kubernetes/kubernetes/pull/112257), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Kube-scheduler: the `DefaultPodTopologySpread`, `NonPreemptingPriority`, `PodAffinityNamespaceSelector` and `PreferNominatedNode` feature gates that graduated to GA in v1.24 and were unconditionally enabled have been removed in v1.26. ([#112567](https://github.com/kubernetes/kubernetes/pull/112567), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: removed the `UnversionedKubeletConfigMap` feature gate. The feature has been GA and locked to enabled since `v1.25`. ([#113448](https://github.com/kubernetes/kubernetes/pull/113448), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: removed the toleration for the `node-role.kubernetes.io/master` taint from the CoreDNS deployment of `kubeadm`. With the 1.25 release of kubeadm the taint `node-role.kubernetes.io/master` is no longer applied to control plane nodes and the toleration for it can be removed with the release of 1.26. You can also perform the same toleration removal from your own addon manifests. ([#112008](https://github.com/kubernetes/kubernetes/pull/112008), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: removed the usage of the `--container-runtime=remote` flag for the kubelet during kubeadm init/join/upgrade. The flag value `remote` had been the only possible value since `dockershim` was removed from the kubelet. ([#112000](https://github.com/kubernetes/kubernetes/pull/112000), [@pacoxu](https://github.com/pacoxu))
- Locked `ServerSideApply` feature gate to true with the feature already being GA. ([#112748](https://github.com/kubernetes/kubernetes/pull/112748), [@wojtek-t](https://github.com/wojtek-t))
- NoneNone ([#111533](https://github.com/kubernetes/kubernetes/pull/111533), [@zhoumingcheng](https://github.com/zhoumingcheng)) [SIG CLI]
- Refactored `test/e2e/framework` so that the core framework is smaller. Optional functionality like resource monitoring, log size monitoring, metrics gathering and debug information dumping must be imported by specific e2e test suites. Init packages are provided which can be imported to re-enable the functionality that traditionally was in the core framework. If you have code that no longer compiles because of this PR, you can use the script [from a commit message](https://github.com/kubernetes/kubernetes/pull/112043/commits/dfdf88d4faafa6fd39988832ea0ef6d668f490e9) to update that code. ([#112043](https://github.com/kubernetes/kubernetes/pull/112043), [@pohly](https://github.com/pohly))
- Release-note ([#111708](https://github.com/kubernetes/kubernetes/pull/111708), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Apps, Instrumentation and Network]
- Removed `PodOverhead` feature gate as the feature is in GA since `v1.24`. ([#112579](https://github.com/kubernetes/kubernetes/pull/112579), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- Removing Windows Server, Version 20H2 flavors from various container images. ([#112924](https://github.com/kubernetes/kubernetes/pull/112924), [@marosset](https://github.com/marosset))
- Reworded log message upon image garbage collection failure to be more clear. ([#112631](https://github.com/kubernetes/kubernetes/pull/112631), [@tzneal](https://github.com/tzneal)) [SIG Node]
- Scheduler dumper now exposes a summary to indicate the number of pending pods in each internal queue. ([#111726](https://github.com/kubernetes/kubernetes/pull/111726), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- Service session affinity timeout tests are no longer required for Kubernetes network plugin conformance due to variations in existing implementations. New conformance tests will be developed to better express conformance in future releases. ([#112806](https://github.com/kubernetes/kubernetes/pull/112806), [@dcbw](https://github.com/dcbw)) [SIG Architecture, Network and Testing]
- The `IndexedJob` and `SuspendJob` feature gates that graduated to GA in 1.24 and were unconditionally enabled have been removed in v1.26. ([#112589](https://github.com/kubernetes/kubernetes/pull/112589), [@SataQiu](https://github.com/SataQiu))
- The `e2e.test` binary no longer emits JSON structs to document progress. ([#113212](https://github.com/kubernetes/kubernetes/pull/113212), [@pohly](https://github.com/pohly))
- The in-tree cloud provider for OpenStack (and the cinder volume provider) has been removed. Please use the external cloud provider and csi driver from [cloud-provider-openstack](https://github.com/kubernetes/cloud-provider-openstack) instead. ([#67782](https://github.com/kubernetes/kubernetes/pull/67782), [@dims](https://github.com/dims))
- The metric `etcd_db_total_size_in_bytes` is renamed to `apiserver_storage_db_total_size_in_bytes`. ([#113310](https://github.com/kubernetes/kubernetes/pull/113310), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery]
- Updated `cri-tools` to [v1.25.0(https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.25.0) ([#112058](https://github.com/kubernetes/kubernetes/pull/112058), [@saschagrunert](https://github.com/saschagrunert))
- `GlusterFS` in-tree storage driver which was deprecated in kubernetes 1.25 release is now removed entirely in 1.26. ([#112015](https://github.com/kubernetes/kubernetes/pull/112015), [@humblec](https://github.com/humblec))