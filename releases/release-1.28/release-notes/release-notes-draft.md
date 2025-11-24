## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Action required for the custom scheduler plugin developers. 
  Here's the breaking change in `EnqueueExtension` in the scheduling framework. 
  The `EventsToRegister` in `EnqueueExtension` changed the return value from `ClusterEvent` to `ClusterEventWithHint`. `ClusterEventWithHint` allows each plugin to filter out more useless events via the callback function named `QueueingHintFn`.
  When the scheduling queue receives a cluster event, before moving each Pod from unschedulable pod pool to activeQ/backoffQ, it will call QueueingHintFn of plugins that rejected each Pod in the previous scheduling cycle.
  Depending on the value returned from QueueingHintFn, the scheduling queue changes how it queues each Pod:
  - if more than one QueueingHintFn returns QueueImmediately, it queues Pod to activeQ.
  - If no QueueingHintFn returns QueueImmediately and more than one plugin returns QueueAfterBackoff, it queues Pod to backoffQ if Pod is backing off, or to activeQ if Pod's backoff has already finished.
  - If all QueueingHintFn return QueueSkip, it puts this pod back to the unschedulable pod pool
  
  Having appropriate QueueingHintFn contributes to reducing useless retries and thus improves the overall scheduler's performance.
  
  **How can I migrate?**
  
  For backward compatibility, nil `QueueingHintFn` is treated as always returning QueueAfterBackoff. 
  So, if you want to just keep the existing behavior, you can register `ClusterEventWithHint` with no `QueueingHintFn` in it. 
  But, registering appropriate `QueueingHintFn` is, of course, better from a scheduling performance perspective. ([#118551](https://github.com/kubernetes/kubernetes/pull/118551), [@sanposhiho](https://github.com/sanposhiho)) [SIG Node, Scheduling, Storage and Testing]
 - CephFS volume plugin (`kubernetes.io/cephfs`) has been deprecated in this release and will be removed in a subsequent release. The alternative is to use the CephFS CSI driver (https://github.com/ceph/ceph-csi/) in your Kubernetes cluster. ([#118143](https://github.com/kubernetes/kubernetes/pull/118143), [@humblec](https://github.com/humblec))
 - Deprecated support for CSI migration of `Ceph RBD volumes`. Users who were relying on Kubernetes' ability
  to migrate to an out-of-tree storage driver should complete that migration before the support for it is removed. ([#118303](https://github.com/kubernetes/kubernetes/pull/118303), [@carlory](https://github.com/carlory))
 - RBD volume plugin (`kubernetes.io/rbd`) has been deprecated in this release
  and will be removed in a subsequent release. Alternative is to use RBD CSI driver
  (https://github.com/ceph/ceph-csi/) in your Kubernetes Cluster. ([#118552](https://github.com/kubernetes/kubernetes/pull/118552), [@humblec](https://github.com/humblec))
 
## Changes by Kind

### Deprecation

- Changed `kubectl version` default output to be identical to what `kubectl version --short` printed,
  and removed `--short` flag entirely. ([#116720](https://github.com/kubernetes/kubernetes/pull/116720), [@soltysh](https://github.com/soltysh))
- Kube-controller-manager deprecate `--volume-host-cidr-denylist` and `--volume-host-allow-local-loopback` flags. ([#118128](https://github.com/kubernetes/kubernetes/pull/118128), [@carlory](https://github.com/carlory)) [SIG API Machinery, Apps, Network, Node, Storage and Testing]
- Kubelet: The `--azure-container-registry-config` flag has been deprecated and will be removed in a future release, please use `--image-credential-provider-config` and `--image-credential-provider-bin-dir` to setup acr credential provider instead. ([#118596](https://github.com/kubernetes/kubernetes/pull/118596), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- Removed tracking annotation from validation and defaulting. ([#117633](https://github.com/kubernetes/kubernetes/pull/117633), [@kannon92](https://github.com/kannon92))
- Removed withdrawn feature `NetworkPolicyStatus`. ([#115843](https://github.com/kubernetes/kubernetes/pull/115843), [@rikatz](https://github.com/rikatz))
- The deprecated flag `--lock-object-namespace` and `--lock-object-name` have been removed from kube-scheduler. Please use `--leader-elect-resource-namespace` and `--leader-elect-resource-name` or ComponentConfig instead to configure those parameters. ([#119130](https://github.com/kubernetes/kubernetes/pull/119130), [@SataQiu](https://github.com/SataQiu)) [SIG Scheduling]
- `KMSv1` is deprecated and will only receive security updates going forward. Use `KMSv2` instead. In a future release, Set `--feature-gates=KMSv1=true` to use the deprecated KMSv1 feature. ([#119007](https://github.com/kubernetes/kubernetes/pull/119007), [@aramase](https://github.com/aramase))

### API Change

- A CDIDevice field is included in the Device Plugin's `ContainerAllocateResponse`. This field maps to the CDIDevice field in the CRI protocol. ([#118254](https://github.com/kubernetes/kubernetes/pull/118254), [@elezar](https://github.com/elezar)) [SIG Node and Testing]
- ACTION_REQUIRED
  When an Indexed Job has a number of completions higher than 10^5 and parallelism higher than 10^4, and a big number of Indexes fail, Kubernetes might not be able to track the termination of the Job. Kubernetes now emits a warning, at Job creation, when the Job manifest exceeds both of these limits. ([#118420](https://github.com/kubernetes/kubernetes/pull/118420), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- Added `ServedVersions` field to `StorageVersion` API. ([#118386](https://github.com/kubernetes/kubernetes/pull/118386), [@Richabanker](https://github.com/Richabanker))
- Added `IP mode` field to loadbalancer status ingress. ([#118895](https://github.com/kubernetes/kubernetes/pull/118895), [@RyanAoh](https://github.com/RyanAoh))
- Added `podReplacementPolicy` and terminating field to job api. ([#119301](https://github.com/kubernetes/kubernetes/pull/119301), [@kannon92](https://github.com/kannon92))
- Added a new `namespaceParamRef` field to `admissionregistration.k8s.io/v1alpha1.ValidatingAdmissionPolicy`. ([#119215](https://github.com/kubernetes/kubernetes/pull/119215), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery and Testing]
- Added a warning that TLS 1.3 ciphers are not configurable. ([#115399](https://github.com/kubernetes/kubernetes/pull/115399), [@3u13r](https://github.com/3u13r)) [SIG API Machinery and Node]
- Added error handling for seccomp localhost configurations that do not properly set a `localhostProfile`. ([#117020](https://github.com/kubernetes/kubernetes/pull/117020), [@cji](https://github.com/cji))
- Added fields `reason` and `fieldPath` into CRD validation rules to allow users to specify reason and field path when validation failed. ([#118041](https://github.com/kubernetes/kubernetes/pull/118041), [@cici37](https://github.com/cici37)) [SIG API Machinery]
- Added namespace access support to the CEL expressions of ValidatingAdmissionPolicy via a `namespaceObject`
  variable with expressions. ([#118267](https://github.com/kubernetes/kubernetes/pull/118267), [@cici37](https://github.com/cici37)) [SIG API Machinery and Testing]
- Added new `CRDValidationRatcheting` alpha feature. During a PATCH or UPDATE Validation Ratcheting discards errors thrown by unchanged portions of the resource from most OpenAPI schema validations. ([#118990](https://github.com/kubernetes/kubernetes/pull/118990), [@alexzielenski](https://github.com/alexzielenski))
- Added new annotation `batch.kubernetes.io/cronjob-scheduled-timestamp` to Job objects scheduled from CronJobs. ([#118137](https://github.com/kubernetes/kubernetes/pull/118137), [@helayoty](https://github.com/helayoty))
- Added new config option `delayCacheUntilActive` to `KubeSchedulerConfiguration` that can provide a tradeoff between memory efficiency and scheduling speed when their leadership is updated in `kube-scheduler` ([#115754](https://github.com/kubernetes/kubernetes/pull/115754), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery and Scheduling]
- Changed how KMS v2 encryption at rest can generate data encryption keys.
  When you enable the `KMSv2KDF` feature gate (off by default), KMS v2 uses a key derivation function to generate single use data encryption keys from a secret seed combined with some random data. This eliminates the need for a counter based nonce while avoiding nonce collision concerns associated with AES-GCM's 12 byte nonce. ([#118828](https://github.com/kubernetes/kubernetes/pull/118828), [@enj](https://github.com/enj))
- Exposed `rest.DefaultServerUrlFor` function. ([#118055](https://github.com/kubernetes/kubernetes/pull/118055), [@timofurrer](https://github.com/timofurrer))
- Extended the Job API for alpha version of `BackoffLimitPerIndex`. ([#119294](https://github.com/kubernetes/kubernetes/pull/119294), [@mimowo](https://github.com/mimowo))
- Graduated `AdmissionWebhookMatchCondition` feature to beta. ([#119380](https://github.com/kubernetes/kubernetes/pull/119380), [@a-hilaly](https://github.com/a-hilaly))
- If using cgroups v2, then the cgroup aware OOM killer will be enabled for container cgroups via  `memory.oom.group` .  This causes processes within the cgroup to be treated as a unit and killed simultaneously in the event of an OOM kill on any process in the cgroup. ([#117793](https://github.com/kubernetes/kubernetes/pull/117793), [@tzneal](https://github.com/tzneal)) [SIG Apps, Node and Testing]
- In the API Priority and Fairness feature, priority levels that are exempt from limitation can now be given a nominal and a lendable concurrency and their dispatching borrows from the concurrency limits of the other priority levels.  For details see https://github.com/kubernetes/enhancements/tree/master/keps/sig-api-machinery/1040-priority-and-fairness#dispatching . ([#118782](https://github.com/kubernetes/kubernetes/pull/118782), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- Indexed Job pods now have the pod completion index set as a pod label. ([#118883](https://github.com/kubernetes/kubernetes/pull/118883), [@danielvegamyhre](https://github.com/danielvegamyhre)) [SIG Apps]
- Kube-proxy: added `--logging-format` flag to support structured logging. ([#117800](https://github.com/kubernetes/kubernetes/pull/117800), [@cyclinder](https://github.com/cyclinder))
- NodeVolumeLimits implement the `PreFilter` extension point for skipping the Filter phase if the Pod doesn't use volumes with limits. ([#115398](https://github.com/kubernetes/kubernetes/pull/115398), [@tangwz](https://github.com/tangwz)) [SIG Scheduling]
- PersistentVolumes have a new `LastPhaseTransitionTime` field which holds a timestamp of when the volume last transitioned its phase. ([#116469](https://github.com/kubernetes/kubernetes/pull/116469), [@RomanBednar](https://github.com/RomanBednar))
- Pods which set `hostNetwork: true` and declare ports, get the `hostPort` field set automatically. Previously this would happen in the PodTemplate of a Deployment, DaemonSet or other workload API.  Now `hostPort` will only be set when an actual Pod is being created.  If this presents a problem, setting the feature gate "DefaultHostNetworkHostPortsInPodTemplates" to true will revert this behavior.  Please file a kubernetes bug if you need to do this. ([#117696](https://github.com/kubernetes/kubernetes/pull/117696), [@thockin](https://github.com/thockin)) [SIG Apps]
- Promoted API groups `ValidatingAdmissionPolicy` and `ValidatingAdmissionPolicyBinding` to `v1beta1`. ([#118644](https://github.com/kubernetes/kubernetes/pull/118644), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery, Apps and Testing]
- Promoted the feature gate `ValidtaingAdmissionPolicy` to beta, and it is turned off by default. ([#119409](https://github.com/kubernetes/kubernetes/pull/119409), [@alexzielenski](https://github.com/alexzielenski))
- Registered_metric_total, disabled_metric_total, hidden_metric_total & kubernetes_feature_enabled are promoted to `BETA` stability. ([#119264](https://github.com/kubernetes/kubernetes/pull/119264), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery, Architecture, Cluster Lifecycle and Instrumentation]
- Removed `resizeStatus` enum from `pvc.Status` and replaced with `AllocatedResourceStatus`. ([#116335](https://github.com/kubernetes/kubernetes/pull/116335), [@gnufied](https://github.com/gnufied)) [SIG API Machinery, Apps, Auth, Node, Storage and Testing]
- Removed `WindowsHostProcessContainers` feature-gate. ([#117570](https://github.com/kubernetes/kubernetes/pull/117570), [@marosset](https://github.com/marosset)) [SIG API Machinery, Apps, Auth, Node and Windows]
- Revised the comment about the feature-gate level for `PodFailurePolicy` from alpha to beta. ([#117802](https://github.com/kubernetes/kubernetes/pull/117802), [@kerthcet](https://github.com/kerthcet)) [SIG API Machinery and Apps]
- StatefulSet pods now have the pod index set as a pod label `statefulset.kubernetes.io/pod-index`. ([#119232](https://github.com/kubernetes/kubernetes/pull/119232), [@danielvegamyhre](https://github.com/danielvegamyhre)) [SIG Apps]
- Support for proxying a request to a peer kube-apiserver if the local apiserver is not able to serve it due to version skew or in the case the requested api is disabled on the local apiserver ([#117740](https://github.com/kubernetes/kubernetes/pull/117740), [@Richabanker](https://github.com/Richabanker)) [SIG API Machinery, Apps, Auth, Cloud Provider, Network, Node and Testing]
- Supported `BackoffLimitPerIndex` in Jobs. ([#118009](https://github.com/kubernetes/kubernetes/pull/118009), [@mimowo](https://github.com/mimowo))
- The `IPTablesOwnershipCleanup` feature (KEP-3178) is now GA; kubelet no longer
  creates the `KUBE-MARK-DROP` chain (which has been unused for several releases)
  or the `KUBE-MARK-MASQ` chain (which is now only created by kube-proxy). ([#119374](https://github.com/kubernetes/kubernetes/pull/119374), [@danwinship](https://github.com/danwinship))
- The `SelfSubjectReview` API is promoted to `authentication.k8s.io/v1` and the `kubectl auth whoami` command is GA. ([#117713](https://github.com/kubernetes/kubernetes/pull/117713), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Architecture, Auth, CLI and Testing]
- The names of ResourceClaims generated from ResourceClaimTemplate are now generated. The base name is still `<pod>-<claim name>`, but a random suffix will avoid name collisions. ([#117351](https://github.com/kubernetes/kubernetes/pull/117351), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, Node, Scheduling and Testing]
- The new feature gate "SidecarContainers" is now available. This feature introduces sidecar containers, a new type of init container that starts before other containers but remains running for the full duration of the pod's lifecycle and will not block pod termination. ([#116429](https://github.com/kubernetes/kubernetes/pull/116429), [@gjkim42](https://github.com/gjkim42)) [SIG API Machinery, Apps, Node, Scheduling and Testing]
- Updated the comment about the feature-gate level for `PodFailurePolicy` from alpha to beta ([#118278](https://github.com/kubernetes/kubernetes/pull/118278), [@mimowo](https://github.com/mimowo))
- `client-go`: Improved memory use of reflector caches when watching large numbers
  of objects which do not change frequently. ([#113362](https://github.com/kubernetes/kubernetes/pull/113362), [@sxllwx](https://github.com/sxllwx))
- `component-base/logs` is now stricter about not applying configurations multiple
  times and will return an error when that is attempted. Can be overridden by binaries
  which need to do that. ([#117108](https://github.com/kubernetes/kubernetes/pull/117108), [@pohly](https://github.com/pohly))
- `kube-controller-manager`: The `LegacyServiceAccountTokenCleanUp` feature gate
  is now available as alpha (off by default). When enabled, the `legacy-service-account-token-cleaner`
  controller loop removes service account token secrets that have not been used
  in the time specified by `--legacy-service-account-token-clean-up-period` (defaulting
  to one year), **and are** referenced from the `.secrets` list of a ServiceAccount
  object, **and are not** referenced from pods. ([#115554](https://github.com/kubernetes/kubernetes/pull/115554), [@yt2985](https://github.com/yt2985))
- `kube-scheduler` component config (KubeSchedulerConfiguration) `kubescheduler.config.k8s.io/v1beta2`
  is removed in `v1.28`. Migrate `kube-scheduler` configuration files to `kubescheduler.config.k8s.io/v1`. ([#117649](https://github.com/kubernetes/kubernetes/pull/117649), [@SataQiu](https://github.com/SataQiu))

### Feature

- A ValidatingAdmissionPolicy now has its `messageExpression` field checked against resolved types. ([#119209](https://github.com/kubernetes/kubernetes/pull/119209), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery]
- Added '--concurrent-cron-job-syncs' flag for `kube-controller-manager` to set the number of workers for cron job controller. ([#117550](https://github.com/kubernetes/kubernetes/pull/117550), [@borgerli](https://github.com/borgerli))
- Added '--concurrent-job-syncs' flag for `kube-controller-manager` to set the number of job controller workers. ([#117138](https://github.com/kubernetes/kubernetes/pull/117138), [@tosi3k](https://github.com/tosi3k))
- Added `--concurrency` flag to configure the concurrency of `kubectl diff` execution, defaults to 1. ([#118810](https://github.com/kubernetes/kubernetes/pull/118810), [@brancz](https://github.com/brancz))
- Added `ConsistentListFromCache` feature gate that allows apiserver to serve consistent lists from cache. ([#118508](https://github.com/kubernetes/kubernetes/pull/118508), [@serathius](https://github.com/serathius))
- Added `DisruptionTarget` condition to the pod preempted by kubelet to make room for a critical pod. ([#117586](https://github.com/kubernetes/kubernetes/pull/117586), [@mimowo](https://github.com/mimowo))
- Added `apiserver_admission_match_condition_evaluation_seconds` and `apiserver_admission_match_condition_exclusions_total` metrics. ([#119311](https://github.com/kubernetes/kubernetes/pull/119311), [@ivelichkovich](https://github.com/ivelichkovich))
- Added a container image for `kubectl` at `registry.k8s.io/kubectl` across the same architectures as other images (linux/amd64 linux/arm64 linux/s390x linux/ppc64le) ([#116672](https://github.com/kubernetes/kubernetes/pull/116672), [@dims](https://github.com/dims)) [SIG Architecture and Release]
- Added a new command line argument `--interactive` to kubectl. The new command line argument lets a user confirm deletion requests per resource interactively. ([#114530](https://github.com/kubernetes/kubernetes/pull/114530), [@ardaguclu](https://github.com/ardaguclu)) [SIG CLI and Testing]
- Added a new feature gate, `SchedulerQueueingHints` (enabled by default).
  The new feature gate activates a framework for fine-grained filtering of events related to scheduler plugins.
  In this release, no default scheduling plugins make use of the hinting framework, so you should not expect any behavior changes. ([#119328](https://github.com/kubernetes/kubernetes/pull/119328), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Added full cgroup v2 swap support for both `Limited` and `Unlimited` swap.
  
  When `LimitedSwap` is enabled the swap limit would be automatically calculated for
  Burstable QoS pods. For Best-Effort/Guaranteed QoS pods, swap would be disabled.
  
  Containers with memory requests equal to their memory limits also won't have
  swap access, and it is a way to opt-out of swap for a single container.
  
  The formula for the swap limit for Burstable QoS pods is:
  `(<memory-request>/<node-memory-capacity>)*<node-swap-capacity>`.
  
  Support for `cgroup v1` is removed. ([#118764](https://github.com/kubernetes/kubernetes/pull/118764), [@iholder101](https://github.com/iholder101))
- Added handling for pods in podgc for `PodReplacementPolicy` or `PodDisruption`. ([#118772](https://github.com/kubernetes/kubernetes/pull/118772), [@kannon92](https://github.com/kannon92))
- Added reason to metric `attachdetach_controller_forced_detaches` in the attach detach controller. ([#119185](https://github.com/kubernetes/kubernetes/pull/119185), [@xing-yang](https://github.com/xing-yang))
- Added support for pod `hostNetwork` field selector ([#110477](https://github.com/kubernetes/kubernetes/pull/110477), [@halfcrazy](https://github.com/halfcrazy)) [SIG Apps and Node]
- Added swap to stats to Summary API and Prometheus endpoints (stats/summary and /metrics/resource). ([#118865](https://github.com/kubernetes/kubernetes/pull/118865), [@iholder101](https://github.com/iholder101))
- Added the implementation for `PodRecreationPolicy` to wait for the creation of pods once the existing ones are fully terminated. ([#117015](https://github.com/kubernetes/kubernetes/pull/117015), [@kannon92](https://github.com/kannon92))
- Allow to monitor client-go DNS resolver latencies via `rest_client_dns_resolution_duration_seconds` Prometheus metric. ([#115357](https://github.com/kubernetes/kubernetes/pull/115357), [@mfojtik](https://github.com/mfojtik))
- Apiserver adds two new metrics `etcd_requests_total` and `etcd_request_errors_total` that allow users to monitor requests to etcd storage, split by operation and resource type. ([#117222](https://github.com/kubernetes/kubernetes/pull/117222), [@iyear](https://github.com/iyear)) [SIG API Machinery]
- Bumped `distroless-iptables` to 0.2.6 based on Go 1.20.6. ([#119365](https://github.com/kubernetes/kubernetes/pull/119365), [@xmudrii](https://github.com/xmudrii))
- Bumped metrics-server to `v0.6.3`. ([#117120](https://github.com/kubernetes/kubernetes/pull/117120), [@dgrisonnet](https://github.com/dgrisonnet))
- CEL authorizer checks no longer raise runtime errors. Calls to "check" will always return a decision object and the authorization error (if any) can be accessed within expressions using the new decision methods "errored" and "error". ([#118804](https://github.com/kubernetes/kubernetes/pull/118804), [@benluddy](https://github.com/benluddy)) [SIG API Machinery]
- CRI: exposed commit memory bytes in container stats specific to Windows ([#119238](https://github.com/kubernetes/kubernetes/pull/119238), [@kiashok](https://github.com/kiashok))
- Client-go now exposes two new metrics to monitor the client-go logic that
  generate http.Transports for the clients.
  
  - `rest_client_transport_cache_entries` is a gauge metric
  with the number of existing entries in the internal cache
  
  - `rest_client_transport_create_calls_total` is a counter
  that increments each time a new transport is created, storing
  the result of the operation needed to generate it: hit, miss
  or uncacheable. ([#117295](https://github.com/kubernetes/kubernetes/pull/117295), [@aojea](https://github.com/aojea))
- Cloud controller manager's node controller now emits timing metrics for initial `Node` synchronization. These metrics measure the delay between the creation of a new `Node` and the node controller's initial management actions, such as removing the cloud provider taint. These metrics should be consulted when setting cloud controller manager's `--concurrent-node-syncs` flag. ([#119241](https://github.com/kubernetes/kubernetes/pull/119241), [@cartermckinnon](https://github.com/cartermckinnon)) [SIG Cloud Provider and Instrumentation]
- Dynamic resource allocation: when a claim uses "wait for first consumer" allocation (the default), then it will now get deallocated after it was used by a pod. That ensures that the next pod isn't affected by previous scheduling decision and that resources are not kept allocated unless really needed. If keeping a claim allocated is desired, use "immediate allocation." ([#118936](https://github.com/kubernetes/kubernetes/pull/118936), [@pohly](https://github.com/pohly))
- Enabled use of pods with volumes and user namespaces. The feature gate was renamed from `UserNamespacesStatelessPodsSupport` to `UserNamespacesSupport`. ([#118691](https://github.com/kubernetes/kubernetes/pull/118691), [@giuseppe](https://github.com/giuseppe))
- External credential provider plugins will now have their standard error output logged by kubelet upon failures. ([#117448](https://github.com/kubernetes/kubernetes/pull/117448), [@cartermckinnon](https://github.com/cartermckinnon))
- Faster scheduling when `ResourceClaims` are involved. ([#119078](https://github.com/kubernetes/kubernetes/pull/119078), [@pohly](https://github.com/pohly))
- Fixed the alpha `CloudDualStackNodeIPs` feature. ([#118329](https://github.com/kubernetes/kubernetes/pull/118329), [@danwinship](https://github.com/danwinship))
- Graduated the `LegacyServiceAccountTokenTracking` feature gate to GA. The usage of auto-generated secret-based service account token now produces warnings, and relevant Secrets are labeled with a last-used timestamp (label key `kubernetes.io/legacy-token-last-used`). ([#117591](https://github.com/kubernetes/kubernetes/pull/117591), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth and Testing]
- Graduated the `ProbeTerminationGracePeriod` feature gate to GA. ([#114307](https://github.com/kubernetes/kubernetes/pull/114307), [@rphillips](https://github.com/rphillips))
- Hashing of KeyID in Logs
  
  This release adds a feature to hash the `KeyID` values in the logs. The `KeyID` values are sensitive information that should not be exposed in plain text in the logs. By hashing the `KeyID` values, we can protect the confidentiality of the data while still being able to log the necessary information. ([#118988](https://github.com/kubernetes/kubernetes/pull/118988), [@nilekhc](https://github.com/nilekhc)) [SIG API Machinery, Auth and Testing]
- Implemented alpha support for a drop-in kubelet configuration directory. ([#119390](https://github.com/kubernetes/kubernetes/pull/119390), [@sohankunkerkar](https://github.com/sohankunkerkar))
- In the course of admitting a single request, the ValidatingAdmissionPolicy plugin will perform no more than one authorization check per unique authorizer expression. All evaluations of identical authorizer expressions will produce the same decision. ([#116443](https://github.com/kubernetes/kubernetes/pull/116443), [@benluddy](https://github.com/benluddy)) [SIG API Machinery and Testing]
- Introduce support for CEL optionals (see [CEL spec proposal 246](https://github.com/google/cel-spec/wiki/proposal-246)).
  This feature will not be fully enabled until a future Kubernetes release (likely to be v1.29), but is added in v1.28 to enable
  safe rollback on downgrade. ([#118339](https://github.com/kubernetes/kubernetes/pull/118339), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth, Cloud Provider and Testing]
- Kube-controller-manager: the dynamic resource controller steps in when a pod got created such that the scheduler ignores it (i.e. spec.nodeName is set) and then takes care of triggering delayed resource claim allocation and/or reserving a claim for the pod. ([#118209](https://github.com/kubernetes/kubernetes/pull/118209), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, Node and Testing]
- Kube-proxy handles Terminating EndpointSlices conditions and enables zero downtime deployments for Services with ExternalTrafficPolicy=Local author: @andrewsykim ([#117718](https://github.com/kubernetes/kubernetes/pull/117718), [@aojea](https://github.com/aojea)) [SIG Network, Testing and Windows]
- Kube-proxy service health returns http header `X-Load-Balancing-Endpoint-Weight` with number of local endpoints. The same information is still available in response body JSON `payload.LocalEndpoints`. ([#118999](https://github.com/kubernetes/kubernetes/pull/118999), [@cezarygerard](https://github.com/cezarygerard))
- Kubelet: plugins for dynamic resource allocation may use the `v1alpha3` API instead of v1alpha2 if they want to do prepare/unprepare operations in batches. ([#119012](https://github.com/kubernetes/kubernetes/pull/119012), [@pohly](https://github.com/pohly))
- Kubelet: security of dynamic resource allocation was enhanced by limiting node access to those objects that are needed on the node. ([#116254](https://github.com/kubernetes/kubernetes/pull/116254), [@pohly](https://github.com/pohly)) [SIG Auth and Testing]
- Kubelet: un-deprecated `--provider-id` flag. ([#116530](https://github.com/kubernetes/kubernetes/pull/116530), [@pacoxu](https://github.com/pacoxu))
- Kubernetes is now built with Go `1.20.4`. ([#117744](https://github.com/kubernetes/kubernetes/pull/117744), [@xmudrii](https://github.com/xmudrii)) [SIG Release and Testing]
- Kubernetes is now built with Go `1.20.5`. ([#118507](https://github.com/kubernetes/kubernetes/pull/118507), [@jeremyrickard](https://github.com/jeremyrickard))
- Kubernetes is now built with Go `1.20.6`. ([#119324](https://github.com/kubernetes/kubernetes/pull/119324), [@xmudrii](https://github.com/xmudrii))
- Metric `scheduler_scheduler_goroutines` is removed. Use `scheduler_goroutines` instead. ([#117727](https://github.com/kubernetes/kubernetes/pull/117727), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Migrated `pkg/controller/endpoint` to contextual logging. ([#116755](https://github.com/kubernetes/kubernetes/pull/116755), [@my-git9](https://github.com/my-git9))
- Migrated `pkg/scheduler/framework/preemption` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116835](https://github.com/kubernetes/kubernetes/pull/116835), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated `pod-security-admission` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#114471](https://github.com/kubernetes/kubernetes/pull/114471), [@Namanl2001](https://github.com/Namanl2001)) [SIG Apps and Auth]
- Migrated controller functions to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116930](https://github.com/kubernetes/kubernetes/pull/116930), [@fatsheep9146](https://github.com/fatsheep9146)) [SIG API Machinery, Apps, Network, Node, Storage and Testing]
- Migrated the Job controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116910](https://github.com/kubernetes/kubernetes/pull/116910), [@fatsheep9146](https://github.com/fatsheep9146)) [SIG API Machinery, Apps and Testing]
- Migrated the `EndpointSlice` and `EndpointSliceMirroring` controllers (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#115295](https://github.com/kubernetes/kubernetes/pull/115295), [@Namanl2001](https://github.com/Namanl2001)) [SIG API Machinery, Apps, Network and Testing]
- Migrated the certificate controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113994](https://github.com/kubernetes/kubernetes/pull/113994), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery, Apps, Auth, Instrumentation and Testing]
- Migrated the noderesources scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116748](https://github.com/kubernetes/kubernetes/pull/116748), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated the podtopologyspread scheduler plugins to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116797](https://github.com/kubernetes/kubernetes/pull/116797), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Moved `non-graceful node` shutdown to GA. ([#118228](https://github.com/kubernetes/kubernetes/pull/118228), [@carlory](https://github.com/carlory))
- New CEL Library functions to support Kubernetes Quantities. ([#118803](https://github.com/kubernetes/kubernetes/pull/118803), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery]
- New Metrics Added for Encryption Configuration Controller
  
  This release adds new metrics to the Encryption Configuration Controller to help monitor the automatic reloading of encryption configuration. The new metrics include:
  
  - `apiserver_encryption_config_controller_automatic_reload_failures_total`: Total number of failed automatic reloads of encryption configuration.
  - `apiserver_encryption_config_controller_automatic_reload_success_total`: Total number of successful automatic reloads of encryption configuration.
  - `apiserver_encryption_config_controller_automatic_reload_last_timestamp_seconds`: Timestamp of the last successful or failed automatic reload of encryption configuration.
  
  These metrics can be used to monitor the health of the Encryption Configuration Controller and to troubleshoot any issues that may arise during automatic reloading of encryption configuration. ([#119008](https://github.com/kubernetes/kubernetes/pull/119008), [@nilekhc](https://github.com/nilekhc))
- New staging repo has been created for the `EndpointSlice` reconciler. ([#118953](https://github.com/kubernetes/kubernetes/pull/118953), [@mskrocki](https://github.com/mskrocki))
- Promoted `ServiceNodePortStaticSubrange` feature gate to beta, and it will be enabled by default. ([#117877](https://github.com/kubernetes/kubernetes/pull/117877), [@xuzhenglun](https://github.com/xuzhenglun))
- Promoted the following apiserver flowcontrol metrics to Beta:

  - apiserver_flowcontrol_request_wait_duration_seconds 
  - apiserver_flowcontrol_current_executing_seats
  - apiserver_flowcontrol_nominal_limit_seats
  - apiserver_flowcontrol_rejected_requests_total
  - apiserver_flowcontrol_dispatched_requests_total
  - apiserver_flowcontrol_current_inqueue_requests
  - apiserver_flowcontrol_current_executing_requests ([#119110](https://github.com/kubernetes/kubernetes/pull/119110), [@andrewsykim](https://github.com/andrewsykim))
- Renamed `PodHasNetwork` to `PodReadyToStartContainers`. ([#117702](https://github.com/kubernetes/kubernetes/pull/117702), [@kannon92](https://github.com/kannon92)) [SIG Node and Testing]
- Replaced `apiserver_storage_db_total_size_in_bytes` with `apiserver_storage_size_bytes` metric. ([#118812](https://github.com/kubernetes/kubernetes/pull/118812), [@serathius](https://github.com/serathius))
- Scheduler now waits for handlers to finish syncing before the scheduling cycles start. ([#116729](https://github.com/kubernetes/kubernetes/pull/116729), [@AxeZhan](https://github.com/AxeZhan))
- Set metrics-server's metric-resolution to 15s. ([#117121](https://github.com/kubernetes/kubernetes/pull/117121), [@dgrisonnet](https://github.com/dgrisonnet)) [SIG Cloud Provider and Instrumentation]
- SubjectAccessReview requests sent to webhook authorizers now default `spec.resourceAttributes.version` to `*` if unset. ([#116937](https://github.com/kubernetes/kubernetes/pull/116937), [@AxeZhan](https://github.com/AxeZhan)) [SIG Apps and Auth]
- Supported specifying a custom retry period for cloud `load-balancer` operations. ([#94021](https://github.com/kubernetes/kubernetes/pull/94021), [@timoreimann](https://github.com/timoreimann))
- The "value" part in the `wait --for=jsonpath='{expression}'[=value]` is now
  optional. If the value is not provided i.e., the command looks like `wait --for=jsonpath='{expression}'`
  then the wait condition is interpreted as matched when the expression returns
  *any* single JSON value like object or a literal. ([#118160](https://github.com/kubernetes/kubernetes/pull/118160), [@minherz](https://github.com/minherz))
- The Kubernetes apiserver now emits a warning message for Pods with a null labelSelector in podAffinity or topologySpreadConstraints. The null labelSelector means "match none". Using it in podAffinity or topologySpreadConstraint could lead to unintended behavior. ([#117025](https://github.com/kubernetes/kubernetes/pull/117025), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- The `AdvancedAuditing` feature gate that graduated to GA in `v1.12` (and was unconditionally
  enabled) has been removed. ([#118763](https://github.com/kubernetes/kubernetes/pull/118763), [@Shubham82](https://github.com/Shubham82))
- The `ExpandedDNSConfig` feature has graduated to GA. 'ExpandedDNSConfig' feature was locked to default value and will be removed in v1.30. If you were setting this feature gate explicitly, please remove it now. ([#116741](https://github.com/kubernetes/kubernetes/pull/116741), [@gjkim42](https://github.com/gjkim42)) [SIG Apps, Network and Node]
- The apiserver debug endpoint `/debug/api_priority_and_fairness/dump_requests` has been extended to dump executing requests as well as queued ones.  A column for StartTime has been added to the returned table, with the queued requests having a StartTime of "0001-01-01T00:00:00Z".  The executing requests have a RequestIndexInQueue of -1, and the QueueIndex is also -1 for priority levels without queues. ([#119009](https://github.com/kubernetes/kubernetes/pull/119009), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- The helping message of commands which have sub-commands is now clearer and more instructive. It will show the full command instead of `kubectl <command> --help ...`
  
  Changed `kubectl create secret --help` description. There will be a short introduction to the three secret types and clearer guidance on how to use the command. ([#117930](https://github.com/kubernetes/kubernetes/pull/117930), [@LronDC](https://github.com/LronDC))
- The scheduler skips the `InterPodAffinity` Score plugin when nothing to do with the Pod.
  It will affect some metrics values related to the InterPodAffinity Score plugin. ([#117794](https://github.com/kubernetes/kubernetes/pull/117794), [@utam0k](https://github.com/utam0k)) [SIG Scheduling]
- The scheduler skips the `PodTopologySpread` Filter plugin if no spread constraints.
  It will affect some metrics values related to the `PodTopologySpread` Filter plugin. ([#117683](https://github.com/kubernetes/kubernetes/pull/117683), [@utam0k](https://github.com/utam0k))
- The scheduler skips the `PodTopologySpread` Score plugin when nothing to do with the Pod.
  It will affect some metrics values related to the PodTopologySpread Score plugin. ([#118608](https://github.com/kubernetes/kubernetes/pull/118608), [@utam0k](https://github.com/utam0k))
- The short names `vwc` and `mwc` were introduced for the resources `validatingwebhookconfigurations` and `mutatingwebhookconfigurations`. ([#117535](https://github.com/kubernetes/kubernetes/pull/117535), [@hysyeah](https://github.com/hysyeah))
- Updated etcd image to `3.5.9-0`. ([#117999](https://github.com/kubernetes/kubernetes/pull/117999), [@kkkkun](https://github.com/kkkkun)) [SIG API Machinery]
- Updated cAdvisor to `v0.47.2` and fixed metrics in `cri-o` when a container restarts. ([#118774](https://github.com/kubernetes/kubernetes/pull/118774), [@harche](https://github.com/harche))
- Updated distroless I-tables to use registry.k8s.io/build-image/distroless-iptables:v0.2.5 ([#118541](https://github.com/kubernetes/kubernetes/pull/118541), [@jeremyrickard](https://github.com/jeremyrickard)) [SIG Testing]
- Updated distroless iptables to use released image `registry.k8s.io/build-image/distroless-iptables:v0.2.4` ([#117746](https://github.com/kubernetes/kubernetes/pull/117746), [@xmudrii](https://github.com/xmudrii)) [SIG Testing]
- Updated the scheduler interface and cache methods to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116849](https://github.com/kubernetes/kubernetes/pull/116849), [@mengjiao-liu](https://github.com/mengjiao-liu))
- ValidatingAdmissionPolicy type checking now correctly handles `authorizer` variable. ([#118540](https://github.com/kubernetes/kubernetes/pull/118540), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery]
- When a pod is done or not going to run, then `ResourceClaims` for it can be reused by other pods or deleted. ([#118817](https://github.com/kubernetes/kubernetes/pull/118817), [@pohly](https://github.com/pohly))
- With the `KubeletCgroupDriverFromCRI` feature gate enabled and sufficiently new version of a container
  runtime, kubelet automatically detects the cgroup driver config from the container runtime, eliminating
  the need to specify the `cgroupDriver` configuration option (or `--cgroup-driver` flag) of kubelet. ([#118770](https://github.com/kubernetes/kubernetes/pull/118770), [@marquiz](https://github.com/marquiz))
- [Kube-proxy]: Implemented connection draining for terminating nodes. ([#116470](https://github.com/kubernetes/kubernetes/pull/116470), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- `--version=v1.X.Y...` can now be used to set the prerelease and buildID portions of the version reported by components ([#117688](https://github.com/kubernetes/kubernetes/pull/117688), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Architecture and Release]
- `RetroactiveDefaultStorageClass` feature made stable and enabled by default. ([#118102](https://github.com/kubernetes/kubernetes/pull/118102), [@RomanBednar](https://github.com/RomanBednar))
- `TopologyManagerPolicyOptions` feature-flag is promoted to beta and enabled by default. ([#118816](https://github.com/kubernetes/kubernetes/pull/118816), [@PiotrProkop](https://github.com/PiotrProkop))
- `force_delete_pods_total` and `force_delete_pod_errors_total` metrics count all pod deletion behaviors. ([#118480](https://github.com/kubernetes/kubernetes/pull/118480), [@carlory](https://github.com/carlory))
- `klog` text output now uses JSON as encoding for structs, maps and slices. ([#117687](https://github.com/kubernetes/kubernetes/pull/117687), [@pohly](https://github.com/pohly))
- `kube-proxy` in iptables mode will now have separate `sync_full_proxy_rules_duration_seconds`\nand
  `sync_partial_proxy_rules_duration_seconds` (in addition to the existing\n`sync_proxy_rules_duration_seconds`),
  giving better information about the duration of each \nsync type, rather than
  only giving a weighted average of the two sync types together. ([#117787](https://github.com/kubernetes/kubernetes/pull/117787), [@danwinship](https://github.com/danwinship))
- `kubeadm`: added a new "kubeadm config validate" command that can be used to
  validate any input config file. Use the `--config` flag to pass a config file
  to it. See the command `--help` screen for more information. As a result of adding
  this new command, enhance the validation capabilities of the existing "kubeadm
  config migrate" command. For both commands unknown APIs or fields will throw errors. ([#118013](https://github.com/kubernetes/kubernetes/pull/118013), [@neolit123](https://github.com/neolit123))
- `kubeadm`: added the `--allow-experimental-api` flag to "kubeadm config migrate/validate" commands. It can be used to migrate or validate WIP/experimental APIs in the future. ([#118866](https://github.com/kubernetes/kubernetes/pull/118866), [@neolit123](https://github.com/neolit123))
- `kubeadm`: generate CA certificates with a start time that is offset 5
  minutes in the past relative to the current system time to workaround cases of
  clock desync. ([#118922](https://github.com/kubernetes/kubernetes/pull/118922), [@champtar](https://github.com/champtar))
- `plugin_evaluation_total` metric supports prescore/score extension point.
  The metric doesn't get incremented when the prescore/score plugin has nothing to do with an incoming pod. ([#118025](https://github.com/kubernetes/kubernetes/pull/118025), [@AxeZhan](https://github.com/AxeZhan))

### Documentation

- Enhanced clarity in error messaging when waiting for volume creation ([#118262](https://github.com/kubernetes/kubernetes/pull/118262), [@torredil](https://github.com/torredil)) [SIG Apps and Storage]

### Failing Test

- Allowed Azure Disk e2es to use newer topology labels if available from nodes. ([#117216](https://github.com/kubernetes/kubernetes/pull/117216), [@gnufied](https://github.com/gnufied))
- Fixed nil pointer in test AfterEach volumeperf.go for sidecar release. ([#117368](https://github.com/kubernetes/kubernetes/pull/117368), [@sunnylovestiramisu](https://github.com/sunnylovestiramisu))
- Switched back to `debian-base` instead of distroless for conformance image. ([#119422](https://github.com/kubernetes/kubernetes/pull/119422), [@saschagrunert](https://github.com/saschagrunert))

### Bug or Regression

- Added a new event `FailedToRetrieveImagePullSecret` which will be generated when a pod references an `ImagePullSecret` that doesn't exist. ([#117927](https://github.com/kubernetes/kubernetes/pull/117927), [@kaisoz](https://github.com/kaisoz)) [SIG Node]
- Added additional validation for endpoint IP configuration while iterating through queried endpoint list. ([#116749](https://github.com/kubernetes/kubernetes/pull/116749), [@princepereira](https://github.com/princepereira))
- Added warning for dup ports update/patching in pod's container ports and service ports. ([#113245](https://github.com/kubernetes/kubernetes/pull/113245), [@pacoxu](https://github.com/pacoxu))
- As in Kubernetes `v1.26` and `v1.27`, resource claims do not get prepared by `kubelet` when no container uses them. This was changed accidentally in [v1.28.0-alpha.1](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.0-alpha.1). ([#118786](https://github.com/kubernetes/kubernetes/pull/118786), [@pohly](https://github.com/pohly))
- Bumped cadvisor version to `v0.47.3`. ([#119225](https://github.com/kubernetes/kubernetes/pull/119225), [@iholder101](https://github.com/iholder101))
- CI job `ci-kubernetes-node-arm64-ubuntu-serial` will test node e2e on arm64, `use-dockerized-build` and `target-build-arch` are required to run this job. ([#118567](https://github.com/kubernetes/kubernetes/pull/118567), [@chendave](https://github.com/chendave))
- CVE-2023-27561 CVE-2023-25809 CVE-2023-28642: Bump fix runc v1.1.4 -> v1.1.5 ([#117095](https://github.com/kubernetes/kubernetes/pull/117095), [@PushkarJ](https://github.com/PushkarJ)) [SIG Architecture, Node and Security]
- Code blocks in `kubectl {$COMMAND}--help` will move right by 3 indentation. ([#118029](https://github.com/kubernetes/kubernetes/pull/118029), [@ardaguclu](https://github.com/ardaguclu))
- Compute the backoff delay more accurately for deleted pods ([#118413](https://github.com/kubernetes/kubernetes/pull/118413), [@mimowo](https://github.com/mimowo)) [SIG Apps]
- Declare Job as finished only after removing all Pod finalizers to avoid orphan Pods. ([#119159](https://github.com/kubernetes/kubernetes/pull/119159), [@alculquicondor](https://github.com/alculquicondor))
- During device plugin allocation, resources requested by the pod can only be allocated if the device plugin has registered itself to kubelet AND healthy devices are present on the node to be allocated. If these conditions are not sattsfied, the pod would fail with `UnexpectedAdmissionError` error. ([#116376](https://github.com/kubernetes/kubernetes/pull/116376), [@swatisehgal](https://github.com/swatisehgal)) [SIG Node and Testing]
- Dynamic Resource Allocation: logged an error and submitted an event when `Kubelet` failed to prepare dynamic resources. ([#118578](https://github.com/kubernetes/kubernetes/pull/118578), [@bart0sh](https://github.com/bart0sh))
- Ensure Job status updates are batched by 1s. This fixes an unlikely scenario when a sequence of immediately 
  completing pods could trigger a sequence of non-batched Job status updates. ([#118470](https://github.com/kubernetes/kubernetes/pull/118470), [@mimowo](https://github.com/mimowo)) [SIG Apps]
- Faster `StatefulSet` creation when `Parallel` mode is enabled. ([#117865](https://github.com/kubernetes/kubernetes/pull/117865), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Fixed a data race in TopologyCache when `AddHints` and `SetNodes` are called concurrently. ([#117249](https://github.com/kubernetes/kubernetes/pull/117249), [@tnqn](https://github.com/tnqn)) [SIG Apps and Network]
- Fixed a race condition in `kube-proxy` when using LocalModeNodeCIDR, to avoid dropping Services traffic if the object node is recreated when `kube-proxy` is starting. ([#118499](https://github.com/kubernetes/kubernetes/pull/118499), [@aojea](https://github.com/aojea))
- Fixed bug where `listOfStrings.join()` in CEL expressions resulted in an unexpected internal error. ([#117593](https://github.com/kubernetes/kubernetes/pull/117593), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery]
- Fixed incorrect calculation for ResourceQuota with PriorityClass as its scope. ([#117677](https://github.com/kubernetes/kubernetes/pull/117677), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG API Machinery]
- Fix: After a Node is down and take some time to get back to up again, the mount point of the evicted Pods cannot be cleaned up successfully. (#111933) Meanwhile Kubelet will print the log `Orphaned pod "xxx" found, but error not a directory occurred when trying to remove the volumes dir` every 2 seconds. (#105536) ([#116134](https://github.com/kubernetes/kubernetes/pull/116134), [@cvvz](https://github.com/cvvz)) [SIG Node and Storage]
- Fix: The volume is not detached after the pod and PVC objects are deleted. ([#116138](https://github.com/kubernetes/kubernetes/pull/116138), [@cvvz](https://github.com/cvvz)) [SIG Storage]
- Fixed Cronjob `status.lastSuccessfulTime` not populated by a manually triggered ([#118530](https://github.com/kubernetes/kubernetes/pull/118530), [@carlory](https://github.com/carlory))
- Fixed Topology Aware Hints not working when the `topology.kubernetes.io/zone` label is added after Node creation. ([#117245](https://github.com/kubernetes/kubernetes/pull/117245), [@tnqn](https://github.com/tnqn))
- Fixed `creationTimestamp: null` causing unnecessary writes to etcd. ([#116865](https://github.com/kubernetes/kubernetes/pull/116865), [@alexzielenski](https://github.com/alexzielenski))
- Fixed `vSphere` cloud provider not to skip detach volumes from nodes at `kube-controller-startup`. ([#117243](https://github.com/kubernetes/kubernetes/pull/117243), [@jsafrane](https://github.com/jsafrane))
- Fixed a bug at `kube-apiserver` start where `APIService` objects for custom resources could be deleted and recreated. ([#118104](https://github.com/kubernetes/kubernetes/pull/118104), [@liggitt](https://github.com/liggitt))
- Fixed a bug that unintentionally overrides custom Accept headers in http (live-/readiness)-probes if the header is in lowercase. ([#114606](https://github.com/kubernetes/kubernetes/pull/114606), [@tuunit](https://github.com/tuunit))
- Fixed a bug where `kubectl port-forward`, when used with a Deployment, could connect to a terminating pod even when a running pod is also available. ([#119256](https://github.com/kubernetes/kubernetes/pull/119256), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed a bug where pv recycler failed to scrub volume with too many files in the directory due to hitting ARG_MAX limit with rm command (#117189). ([#117283](https://github.com/kubernetes/kubernetes/pull/117283), [@defo89](https://github.com/defo89)) [SIG Cloud Provider and Storage]
- Fixed a memory leak in the Kubernetes API server that occurs during APIService processing. ([#117258](https://github.com/kubernetes/kubernetes/pull/117258), [@enj](https://github.com/enj)) [SIG API Machinery]
- Fixed a race condition between `Run()` and `SetTransform()` and `SetWatchErrorHandler()` in shared informers. ([#117870](https://github.com/kubernetes/kubernetes/pull/117870), [@howardjohn](https://github.com/howardjohn)) [SIG API Machinery]
- Fixed a race condition serving `OpenAPI` content ([#117705](https://github.com/kubernetes/kubernetes/pull/117705), [@Jefftree](https://github.com/Jefftree))
- Fixed a regression in `1.27.0` that resulted in `missing metadata in converted object` errors when modifying objects for multi-version custom resource definitions with a conversion strategy of `None`. ([#117301](https://github.com/kubernetes/kubernetes/pull/117301), [@ncdc](https://github.com/ncdc))
- Fixed a regression in `kubectl` and `client-go` discovery when configured with a server URL other than the root of a server ([#117495](https://github.com/kubernetes/kubernetes/pull/117495), [@ardaguclu](https://github.com/ardaguclu))
- Fixed an issue where the API server did not send impersonated UID to authentication webhooks. ([#116681](https://github.com/kubernetes/kubernetes/pull/116681), [@stlaz](https://github.com/stlaz)) [SIG API Machinery and Auth]
- Fixed bug that caused a resource to include patch directives when using strategic merge patch against a non-existent field. ([#117568](https://github.com/kubernetes/kubernetes/pull/117568), [@alexzielenski](https://github.com/alexzielenski))
- Fixed bug to correctly report `ErrRegistryUnavailable` on pulling container images for remote CRI runtimes. ([#117612](https://github.com/kubernetes/kubernetes/pull/117612), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- Fixed bug where explain was not properly respecting jsonpaths. ([#115694](https://github.com/kubernetes/kubernetes/pull/115694), [@mpuckett159](https://github.com/mpuckett159))
- Fixed bug where using the $deleteFromPrimitiveList directive in a strategic merge patch of certain fields would remove the other values from the list instead of the values specified. ([#110472](https://github.com/kubernetes/kubernetes/pull/110472), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery]
- Fixed component status calling etcd health endpoint over http which exposed kubernetes to the risk of complete watch starvation and is inconsistent with other etcd probing done by `kube-apiserver`. ([#118460](https://github.com/kubernetes/kubernetes/pull/118460), [@serathius](https://github.com/serathius))
- Fixed computing backoff delay when using Job pod failure policy, by including in the backoff delay calculation pod failures ignored from the backoffLimit counter. ([#119434](https://github.com/kubernetes/kubernetes/pull/119434), [@mimowo](https://github.com/mimowo))
- Fixed cronjob controller handling of complex schedules, like `30 6-16/4 * * 1-5`, for example. ([#118724](https://github.com/kubernetes/kubernetes/pull/118724), [@soltysh](https://github.com/soltysh))
- Fixed deletion of non-admissible pods that are deleted during Kubelet restart. ([#118497](https://github.com/kubernetes/kubernetes/pull/118497), [@mimowo](https://github.com/mimowo))
- Fixed issue where `kubectl-convert` would fail when encountering resources that could not be converted to the specified api version. New behavior is to warn the user of the failed conversions and continue to convert the remaining resources. ([#117002](https://github.com/kubernetes/kubernetes/pull/117002), [@gxwilkerson33](https://github.com/gxwilkerson33))
- Fixed issue where there was no response or error from kubectl rollout status when there were no resources of specified kind. ([#117884](https://github.com/kubernetes/kubernetes/pull/117884), [@gxwilkerson33](https://github.com/gxwilkerson33)) [SIG CLI]
- Fixed kubelet startup getting stuck with `NewVolumeManagerReconstruction` feature enabled and a CSI volume present in /var/lib/kubelet/pods. ([#117804](https://github.com/kubernetes/kubernetes/pull/117804), [@jsafrane](https://github.com/jsafrane)) [SIG Node and Storage]
- Fixed performance regression in scheduler caused by frequent metric lookup on critical code path. ([#117594](https://github.com/kubernetes/kubernetes/pull/117594), [@tosi3k](https://github.com/tosi3k))
- Fixed restricted debug profile. ([#117543](https://github.com/kubernetes/kubernetes/pull/117543), [@mochizuki875](https://github.com/mochizuki875))
- Fixed the `preStop` hook. This will now block the pod termination grace period. ([#115835](https://github.com/kubernetes/kubernetes/pull/115835), [@HirazawaUi](https://github.com/HirazawaUi))
- Fixed the discoverability of `apiregistration.k8s.io` in `openapi/v3` ([#118879](https://github.com/kubernetes/kubernetes/pull/118879), [@atiratree](https://github.com/atiratree))
- If `kubeadm reset` finds no etcd member ID for the peer it removes during the `remove-etcd-member` phase, it continues immediately to other phases, instead of retrying the phase for up to 3 minutes before continuing. ([#117724](https://github.com/kubernetes/kubernetes/pull/117724), [@dlipovetsky](https://github.com/dlipovetsky)) [SIG Cluster Lifecycle]
- Improved exponential backoff in Reflector, significantly reducing the load on Kubernetes apiserver in case of throttling of requests. ([#118132](https://github.com/kubernetes/kubernetes/pull/118132), [@marseel](https://github.com/marseel)) [SIG API Machinery and Scalability]
- Known issue: fixed that the PreEnqueue plugins aren't executed for Pods proceeding to activeQ through backoffQ. ([#117194](https://github.com/kubernetes/kubernetes/pull/117194), [@sanposhiho](https://github.com/sanposhiho)) [SIG Release and Scheduling]
- Kubeadm: the limitation that the `ignorePreflightErrors` field can not be set to `all` in kubeadm config file has been removed. ([#119351](https://github.com/kubernetes/kubernetes/pull/119351), [@SataQiu](https://github.com/SataQiu))
- Kubelet terminates pods correctly upon restart, fixing an issue where pods may have not been fully terminated if the kubelet was restarted during pod termination. ([#117019](https://github.com/kubernetes/kubernetes/pull/117019), [@bobbypage](https://github.com/bobbypage)) [SIG Node and Testing]
- Kubelet will now skip pod resource checks when the request is zero. ([#116408](https://github.com/kubernetes/kubernetes/pull/116408), [@ChenLingPeng](https://github.com/ChenLingPeng))
- Number of errors reported to the metric `storage_operation_duration_seconds_count` for emptyDir decreased significantly because previously one error was reported for each projected volume created. ([#117022](https://github.com/kubernetes/kubernetes/pull/117022), [@mpatlasov](https://github.com/mpatlasov)) [SIG Storage]
- Pod termination will be faster when the pod has a missing volume reference. ([#117412](https://github.com/kubernetes/kubernetes/pull/117412), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node and Testing]
- Recording timing traces had a race condition. Impact in practice was probably low. ([#117139](https://github.com/kubernetes/kubernetes/pull/117139), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node and Storage]
- Reduced CPU and memory consumption of `kube-apiserver` if OpenAPI V2 will not be accessed by any client. Also improved performance of the apiserver on installation of many CRDs. ([#118212](https://github.com/kubernetes/kubernetes/pull/118212), [@Jefftree](https://github.com/Jefftree))
- Removed leading zeros from the etcd member ID in kubeadm log messages. ([#117919](https://github.com/kubernetes/kubernetes/pull/117919), [@dlipovetsky](https://github.com/dlipovetsky)) [SIG Cluster Lifecycle]
- Resolves a spurious "Unknown discovery response content-type" error in client-go discovery requests by tolerating extra content-type parameters in API responses ([#117571](https://github.com/kubernetes/kubernetes/pull/117571), [@seans3](https://github.com/seans3)) [SIG API Machinery]
- Reverted NewVolumeManagerReconstruction and SELinuxMountReadWriteOncePod feature gates to disabled by default to resolve a regression of volume reconstruction on kubelet/node restart ([#117751](https://github.com/kubernetes/kubernetes/pull/117751), [@liggitt](https://github.com/liggitt)) [SIG Storage]
- Setting a mirror pod's phase to Succeeded or Failed can prevent the corresponding static pod from restarting due mutation of a Kubelet cache. ([#116482](https://github.com/kubernetes/kubernetes/pull/116482), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Show a warning when `volume.beta.kubernetes.io/storage-class` annotation is used in pv or pvc ([#117036](https://github.com/kubernetes/kubernetes/pull/117036), [@haoruan](https://github.com/haoruan)) [SIG Storage]
- Static pods were taking extra time to be restarted after being updated.  Static pods that are waiting to restart were not correctly counted in `kubelet_working_pods`. ([#116995](https://github.com/kubernetes/kubernetes/pull/116995), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- The Daemonset controller creates replacements for terminal Pods, which can appear during VM preemptions or when using Pod finalizers. ([#118716](https://github.com/kubernetes/kubernetes/pull/118716), [@alculquicondor](https://github.com/alculquicondor))
- The `pod_scheduling_duration_seconds` metrics won't consider the time when a pod fails `PreEnqueue` (like being gated). ([#118049](https://github.com/kubernetes/kubernetes/pull/118049), [@helayoty](https://github.com/helayoty))
- The kube-proxy `sync_proxy_rules_iptables_total` metric has now reverted back
  to its pre-1.27 behavior of tracking the total number of iptables rules that
  kube-proxy is responsible for, rather than only counting the number of rules
  that it re-synced on the last sync. The new `sync_proxy_rules_iptables_last`
  metric now gives the latter number. ([#119140](https://github.com/kubernetes/kubernetes/pull/119140), [@danwinship](https://github.com/danwinship)) [SIG Network]
- The metric `apiserver_flowcontrol_request_concurrency_limit` has been deprecated and will be removed in a future release.  It is a duplicate of `apiserver_flowcontrol_nominal_limit_seats` (introduced in release 1.26) but has an outdated name and had an outdated HELP string. ([#118959](https://github.com/kubernetes/kubernetes/pull/118959), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- Updated `etcd` version to `3.5.8`. ([#117335](https://github.com/kubernetes/kubernetes/pull/117335), [@kkkkun](https://github.com/kkkkun))
- Updated apiserver metric `request_filter_duration_seconds` to include a 10s, 15s and 30s bucket.
Updated apiserver metric `request_wait_duration_seconds` to include a 15s bucket. ([#118945](https://github.com/kubernetes/kubernetes/pull/118945), [@andrewsykim](https://github.com/andrewsykim))
- Updated kube-apiserver's priority & fairness work estimator such that 'max seats' is MIN(0.15 x nominalCL, nominalCL / handSize)
  
  This fixes a bug where clients with requests using hand size x max seats greater than the nominal concurrency limit can starve other requests in the same priority level. ([#118601](https://github.com/kubernetes/kubernetes/pull/118601), [@andrewsykim](https://github.com/andrewsykim))
- Updated static pods are restarted 2s faster by correcting a safe but non-optimal ordering bug. ([#116690](https://github.com/kubernetes/kubernetes/pull/116690), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Users will no longer see an error for failed events caused due to terminating namespace. ([#114849](https://github.com/kubernetes/kubernetes/pull/114849), [@padlar](https://github.com/padlar)) [SIG API Machinery]
- [Dual-stack] Fixed `generateAPIPodStatus()` of kubelet handling Secondary IP. hostIPs order may not be consistent. If secondary IP is before primary one, current logic adds primary IP twice into `PodIPs`, which leads to error: "may specify no more than one IP for each IP family". ([#116879](https://github.com/kubernetes/kubernetes/pull/116879), [@lzhecheng](https://github.com/lzhecheng))
- [KCCM] service controller: change the cloud controller manager to make `providerID` a predicate when synchronizing nodes. This change allows load balancer integrations to ensure that  the `providerID` is set when configuring
  load balancers and targets. ([#117388](https://github.com/kubernetes/kubernetes/pull/117388), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu)) [SIG Cloud Provider and Network]
- `kube-apiserver` will now always remove its endpoint from Kubernetes service during
  graceful shutdown (even if it's the only/last one). ([#116685](https://github.com/kubernetes/kubernetes/pull/116685), [@nayihz](https://github.com/nayihz))
- `kubeadm:` fixed a bug where the static pod changes detection logic is inconsistent
  with kubelet. ([#118069](https://github.com/kubernetes/kubernetes/pull/118069), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: `crictl pull` should use `-i` to set the image service endpoint. ([#117835](https://github.com/kubernetes/kubernetes/pull/117835), [@pacoxu](https://github.com/pacoxu))
- `kubeadm`: fixed a bug where file copy(backup) could not be executed correctly
  on Windows platform during upgrade. ([#117861](https://github.com/kubernetes/kubernetes/pull/117861), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: speedup init by 0s or 20s. kubelet-start phase is now after etcd
  and control-plane phases, removing a race condition between kubelet looking for
  static pod manifests and kubeadm writing them. ([#117984](https://github.com/kubernetes/kubernetes/pull/117984), [@champtar](https://github.com/champtar))
- `kubeadm`: will now throw warnings instead of errors for deprecated feature gates. ([#118270](https://github.com/kubernetes/kubernetes/pull/118270), [@pacoxu](https://github.com/pacoxu))
- `kubectl events --for` will also support fully qualified names such as replicasets.apps,
  etc. ([#117034](https://github.com/kubernetes/kubernetes/pull/117034), [@ardaguclu](https://github.com/ardaguclu))
- `kubectl explain` should correctly work for all resources. ([#118876](https://github.com/kubernetes/kubernetes/pull/118876), [@atiratree](https://github.com/atiratree))
- `kubectl expose` supports the creation of different protocol services on the same port. ([#114909](https://github.com/kubernetes/kubernetes/pull/114909), [@aimuz](https://github.com/aimuz))
- `kubelet` will ensure /etc/hosts file is mode 0644 regardless of umask. ([#113209](https://github.com/kubernetes/kubernetes/pull/113209), [@luozhiwenn](https://github.com/luozhiwenn))
- `kubelet`: print sorted volumes message in events. ([#117079](https://github.com/kubernetes/kubernetes/pull/117079), [@qingwave](https://github.com/qingwave))
- `wait.PollUntilContextTimeout` function, if immediate is true, the condition
  will be invoked before waiting and guarantees that the condition is invoked at
  least once, regardless of whether the context has been cancelled. ([#118686](https://github.com/kubernetes/kubernetes/pull/118686), [@aojea](https://github.com/aojea))

### Other (Cleanup or Flake)

- A `v2-level` info log will be added, which will output the details of the pod being preempted, including victim and preemptor. ([#117214](https://github.com/kubernetes/kubernetes/pull/117214), [@HirazawaUi](https://github.com/HirazawaUi))
- Allowed container runtimes to use `ErrSignatureValidationFailed` as possible image pull failure. ([#117717](https://github.com/kubernetes/kubernetes/pull/117717), [@saschagrunert](https://github.com/saschagrunert))
- Deprecated `genericclioptions.IOStreams` and used `genericiooptions.IOStreams`. ([#117102](https://github.com/kubernetes/kubernetes/pull/117102), [@ardaguclu](https://github.com/ardaguclu))
- E2e framework: the `node-role.kubernetes.io/master` taint has been removed from the default value of `--non-blocking-taints` flag. You may need to set `--non-blocking-taints` explicitly if the cluster to be tested has nodes with the deprecated `node-role.kubernetes.io/master` taint. ([#118510](https://github.com/kubernetes/kubernetes/pull/118510), [@SataQiu](https://github.com/SataQiu)) [SIG Testing]
- Enabled the `node-local` kubelet podresources API endpoint on windows, alongside unix. ([#115133](https://github.com/kubernetes/kubernetes/pull/115133), [@ffromani](https://github.com/ffromani))
- Fixed dra e2e image build on non-amd64 architectures. ([#117912](https://github.com/kubernetes/kubernetes/pull/117912), [@bart0sh](https://github.com/bart0sh)) [SIG Node and Testing]
- Kube-apiserver adds two new alpha metrics `conversion_webhook_request_total` and `conversion_webhook_duration_seconds` that allow users to monitor requests to CRD conversion webhooks, split by result, and failure_type (In case of failure). ([#118292](https://github.com/kubernetes/kubernetes/pull/118292), [@cchapla](https://github.com/cchapla)) [SIG API Machinery, Architecture and Instrumentation]
- Kube-proxy will now warn at startup if the configuration seems inconsistent
  with respect to IP families. (For example, if you have an IPv4 node IP, but
  `--cluster-cidr` is IPv6.) ([#119003](https://github.com/kubernetes/kubernetes/pull/119003), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Kube-proxy: removed log warning about not using config file. ([#118115](https://github.com/kubernetes/kubernetes/pull/118115), [@TommyStarK](https://github.com/TommyStarK)) [SIG Network]
- Made Job controller batching of syncJob invocations enabled unconditionally (it was conditional on JobReadyPods feature before).
Also, Job controller's constants for default backoff and maximal backoff are lowered down to 1s (from 10s) and 1min (from 6min), respectively. These constants are used to determine the backoff delay for the next Job controller sync in case of a request failure. ([#118615](https://github.com/kubernetes/kubernetes/pull/118615), [@mimowo](https://github.com/mimowo)) [SIG Apps and Testing]
- Marked the feature gate `ExperimentalHostUserNamespaceDefaulting` as deprecated.
  Enabling the feature gate already had no effect; the deprecation allows for removing the feature gate in a future release. ([#116723](https://github.com/kubernetes/kubernetes/pull/116723), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Node]
- Migrated `pkg/scheduler/framework/runtime` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116842](https://github.com/kubernetes/kubernetes/pull/116842), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Migrated the disruption controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#119147](https://github.com/kubernetes/kubernetes/pull/119147), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery, Apps, Instrumentation and Testing]
- Migrated the interpodaffinity scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116635](https://github.com/kubernetes/kubernetes/pull/116635), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Migrated the podgc controller and some other remaining log calls within `kube-controller-manager` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). `kube-controller-manager` is now converted completely. ([#119250](https://github.com/kubernetes/kubernetes/pull/119250), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Cloud Provider, Instrumentation, Network, Storage and Testing]
- Migrated the volumezone scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116829](https://github.com/kubernetes/kubernetes/pull/116829), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Moved `k8s.io/kubernetes/pkg/kubelet/cri/streaming` package to `k8s.io/kubelet/pkg/cri/streaming`. ([#118253](https://github.com/kubernetes/kubernetes/pull/118253), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node, Release and Security]
- OpenAPI proto deserializations should use `gnostic-models` instead of the gnostic library. ([#118384](https://github.com/kubernetes/kubernetes/pull/118384), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Instrumentation, Node, Storage and Testing]
- Projects which use k8s.io/code-generator and invoke `generate-groups` or `generate-internal-groups.sh` have a new, simpler script (`kube_codegen.sh`) they can use.  The old scripts are deprecated but remain intact. ([#117262](https://github.com/kubernetes/kubernetes/pull/117262), [@thockin](https://github.com/thockin)) [SIG API Machinery and Instrumentation]
- Promoted `kubernetes_healthcheck` and `kubernetes_healthchecks_total` to `BETA` stability level. ([#118986](https://github.com/kubernetes/kubernetes/pull/118986), [@logicalhan](https://github.com/logicalhan))
- Reduced delay when processing jobs after a transient API error. ([#118759](https://github.com/kubernetes/kubernetes/pull/118759), [@mimowo](https://github.com/mimowo))
- Removed GA'ed feature gate `DelegateFSGroupToCSIDriver`. ([#117655](https://github.com/kubernetes/kubernetes/pull/117655), [@carlory](https://github.com/carlory))
- Removed GA'ed feature gate `DevicePlugins`. ([#117656](https://github.com/kubernetes/kubernetes/pull/117656), [@carlory](https://github.com/carlory))
- Removed GA'ed feature gate `KubeletCredentialProviders`. ([#116901](https://github.com/kubernetes/kubernetes/pull/116901), [@pacoxu](https://github.com/pacoxu))
- Removed GA'ed feature gates: `MixedProtocolLBService`, `ServiceInternalTrafficPolicy`,
  `ServiceIPStaticSubrange`, and `EndpointSliceTerminatingCondition`. ([#117237](https://github.com/kubernetes/kubernetes/pull/117237), [@yulng](https://github.com/yulng))
- Removed `KUBECTL_EXPLAIN_OPENAPIV3` which is already redundant. ([#119286](https://github.com/kubernetes/kubernetes/pull/119286), [@ardaguclu](https://github.com/ardaguclu))
- Removed the deprecated `azureFile` in-tree storage plugin. ([#118236](https://github.com/kubernetes/kubernetes/pull/118236), [@andyzhangx](https://github.com/andyzhangx))
- Revised `OpenAPI v2` fetching for CustomResourceDefinitions. CRDs are now aggregated lazily,
  which improves resource usage during installation of many CRDs. As a result, the first request
  to fetch the OpenAPI may be slower. ([#118808](https://github.com/kubernetes/kubernetes/pull/118808), [@Jefftree](https://github.com/Jefftree))
- Shrank the `OpenAPI v2` spec by more than 50%, especially for less CPU resource consumption. ([#118204](https://github.com/kubernetes/kubernetes/pull/118204), [@sttts](https://github.com/sttts))
- Structured logging of `NamespacedName` was inconsistent with `klog.KObj`. Now both will use lower case field names and namespace is optional. ([#117238](https://github.com/kubernetes/kubernetes/pull/117238), [@pohly](https://github.com/pohly))
- The `GetAllocatableResources` podresources API endpoint is now GA. ([#118973](https://github.com/kubernetes/kubernetes/pull/118973), [@ffromani](https://github.com/ffromani))
- The `NetworkPolicyLegacy` test suite (deprecated in `v1.21`) has now officially been removed in favor of the new table driven e2e tests. ([#118915](https://github.com/kubernetes/kubernetes/pull/118915), [@astoycos](https://github.com/astoycos))
- The `generate_groups.sh` and `generate_internal_groups.sh` scripts from the `k8s.io/code-generator` repo are deprecated (but still work) in favor of `kube_codegen.sh` in that same repo.  Projects which use the old scripts are encouraged to look at adopting the new one. ([#117897](https://github.com/kubernetes/kubernetes/pull/117897), [@thockin](https://github.com/thockin)) [SIG API Machinery]
- The feature gate `CSIStorageCapacity` have been removed and must no longer be referenced in `--feature-gates` flags. ([#118018](https://github.com/kubernetes/kubernetes/pull/118018), [@humblec](https://github.com/humblec))
- The feature gates `CSIMigrationGCE` is graduated to GA and were unconditionally enabled have been removed in `v1.25`, and the entire `gcepd` package has been removed. ([#117055](https://github.com/kubernetes/kubernetes/pull/117055), [@cyclinder](https://github.com/cyclinder))
- The feature gates `DisableAcceleratorUsageMetrics` and `PodSecurity` that graduated to GA and were unconditionally enabled have been removed in v1.28. ([#114068](https://github.com/kubernetes/kubernetes/pull/114068), [@cyclinder](https://github.com/cyclinder)) [SIG API Machinery, Node, Scheduling and Storage]
- The kubelet podresources endpoint is GA and always enabled. ([#116525](https://github.com/kubernetes/kubernetes/pull/116525), [@ffromani](https://github.com/ffromani)) [SIG Node]
- The metric `apiserver_flowcontrol_current_executing_seats` has been introduced as a duplicate of `apiserver_flowcontrol_request_concurrency_in_use` because the latter has a confusing name and will be removed in a later release. ([#118960](https://github.com/kubernetes/kubernetes/pull/118960), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- Updated `Cluster Autosaler` to version 1.26.1. ([#116526](https://github.com/kubernetes/kubernetes/pull/116526), [@pacoxu](https://github.com/pacoxu)) [SIG Autoscaling and Cloud Provider]
- Updated `cri-tools` to `v1.27.0`. ([#117545](https://github.com/kubernetes/kubernetes/pull/117545), [@saschagrunert](https://github.com/saschagrunert))
- Updated `setcap` image to debian bookworm v1.0.0. ([#119247](https://github.com/kubernetes/kubernetes/pull/119247), [@saschagrunert](https://github.com/saschagrunert))
- Updated `cri-tools` to `v1.26.1`. ([#116649](https://github.com/kubernetes/kubernetes/pull/116649), [@saschagrunert](https://github.com/saschagrunert)) [SIG Architecture and Release]
- Updated debian-base image to `bookworm-v1.0.0`. ([#119095](https://github.com/kubernetes/kubernetes/pull/119095), [@saschagrunert](https://github.com/saschagrunert))
- Use table-driven test for `TestPerPodSchedulingMetrics`. ([#118842](https://github.com/kubernetes/kubernetes/pull/118842), [@helayoty](https://github.com/helayoty))
- When retrieving event resources, the `reportingController` and `reportingInstance` fields in the event will contain values. ([#116506](https://github.com/kubernetes/kubernetes/pull/116506), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG API Machinery and Instrumentation]
- [KCCM] drop filtering nodes for the providerID when syncing load balancers, but have changes to the field trigger a re-sync of load balancers. This should ensure that cloud providers which don't specify providerID, can still use the service controller implementation to provision load balancers. ([#117602](https://github.com/kubernetes/kubernetes/pull/117602), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu)) [SIG Cloud Provider and Network]
- `kube-apiserver` added two new metrics `authorization_attempts_total` and `authorization_duration_seconds`
  that allow users to monitor requests to authorization webhooks, split by result. ([#117211](https://github.com/kubernetes/kubernetes/pull/117211), [@HirazawaUi](https://github.com/HirazawaUi))
- `kube-apiserver`: Improved memory use when performing `GetList` on the cache. ([#116327](https://github.com/kubernetes/kubernetes/pull/116327), [@sxllwx](https://github.com/sxllwx))
- `kube-controller-manager` and `cloud-controller-manager` have changed the
  name of controllers that can be turned on/off that are passed to the `--controllers`
  flag (e.g., `pod-garbage-collector-controller`). The old names (eg `podgc`) are
  also accepted and aliased to the new names. ([#115813](https://github.com/kubernetes/kubernetes/pull/115813), [@atiratree](https://github.com/atiratree))
- `kubeadm`: Introduced a new feature gate `UpgradeAddonsBeforeControlPlane` to
  fix a kube-proxy skew policy misalignment. Its default value is `false`. Upgrade
  of the CoreDNS and kube-proxy addons will now trigger after all the control plane
  instances have been upgraded, unless the fearure gate is set to true. This feature
  gate will be removed in a future release. ([#117660](https://github.com/kubernetes/kubernetes/pull/117660), [@pacoxu](https://github.com/pacoxu))
