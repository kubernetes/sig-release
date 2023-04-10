## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- 'The `IPv6DualStack` feature gate for external cloud providers was removed.
  (The feature became GA in 1.23 and the gate was removed for all other
  components several releases ago.) If you were still manually
  enabling it you must stop now.' ([#116255](https://github.com/kubernetes/kubernetes/pull/116255), [@danwinship](https://github.com/danwinship))
 - Give terminal phase correctly to all pods that will not be restarted. 
  
  In particular, assign Failed phase to pods which are deleted while pending. Also, assign a terminal 
  phase (Succeeded or Failed, depending on the exit statuses of the pod containers) to pods which
  are deleted while running.
  
  This fixes the issue for jobs using pod failure policy (with JobPodFailurePolicy and PodDisruptionConditions 
  feature gates enabled) that their pods could get stuck in the pending phase when deleted.
  
  Users who maintain controllers which relied on the fact that pods with RestartPolicy=Always
  never enter the Succeeded phase may need to adapt their controllers. This is because as a consequence of 
  the change pods which use RestartPolicy=Always may end up in the Succeeded phase in two scenarios: pod 
  deletion and graceful node shutdown. ([#115331](https://github.com/kubernetes/kubernetes/pull/115331), [@mimowo](https://github.com/mimowo)) [SIG Cloud Provider, Node and Testing]
 
## Changes by Kind

### Deprecation

- Added a [warning](https://k8s.io/blog/2020/09/03/warnings/) response when handling requests that set the deprecated `spec.externalID` field for a Node. ([#115944](https://github.com/kubernetes/kubernetes/pull/115944), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- Added warnings to the Services API. Kubernetes now warns for Services in the case of:
  - IPv4 addresses with leading zeros
  - IPv6 address in non-canonical format (RFC 5952) ([#114505](https://github.com/kubernetes/kubernetes/pull/114505), [@aojea](https://github.com/aojea))
- Support for the alpha seccomp annotations `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io` were deprecated since v1.19, now have been completely removed. The seccomp fields are no longer auto-populated when pods with seccomp annotations are created. Pods should use the corresponding pod or container `securityContext.seccompProfile` field instead. ([#114947](https://github.com/kubernetes/kubernetes/pull/114947), [@saschagrunert](https://github.com/saschagrunert))
- The `SecurityContextDeny` admission plugin is going deprecated and will be removed in future versions. ([#115879](https://github.com/kubernetes/kubernetes/pull/115879), [@mtardy](https://github.com/mtardy))

### API Change

- A fix in the `resource.k8s.io/v1alpha1/ResourceClaim` API avoids harmless (?) ".status.reservedFor: element 0: associative list without keys has an element that's a map type" errors in the apiserver. Validation now rejects the incorrect reuse of the same UID in different entries. ([#115354](https://github.com/kubernetes/kubernetes/pull/115354), [@pohly](https://github.com/pohly))
- A terminating pod on a node that is not caused by preemption no longer prevents `kube-scheduler` from preempting pods on that node
  - Rename `PreemptionByKubeScheduler` to `PreemptionByScheduler` ([#114623](https://github.com/kubernetes/kubernetes/pull/114623), [@Huang-Wei](https://github.com/Huang-Wei))
- API: resource.k8s.io/v1alpha1.PodScheduling was renamed to resource.k8s.io/v1alpha2.PodSchedulingContext. ([#116556](https://github.com/kubernetes/kubernetes/pull/116556), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, CLI, Node, Scheduling and Testing]
- Added CEL runtime cost calculation into ValidatingAdmissionPolicy, matching the evaluation cost
  restrictions that already apply to CustomResourceDefinition.
  If rule evaluation uses more compute than the limit, the API server aborts the evaluation and the
  admission check that was being performed is aborted; the `failurePolicy` for the ValidatingAdmissionPolicy
  determines the outcome. ([#115747](https://github.com/kubernetes/kubernetes/pull/115747), [@cici37](https://github.com/cici37))
- Added `auditAnnotations` to `ValidatingAdmissionPolicy`, enabling CEL to be used to add audit annotations to request audit events.
  Added `validationActions` to `ValidatingAdmissionPolicyBinding`, enabling validation failures to be handled by any combination of the warn, audit and deny enforcement actions. ([#115973](https://github.com/kubernetes/kubernetes/pull/115973), [@jpbetz](https://github.com/jpbetz))
- Added `messageExpression` field to `ValidationRule`. ([#115969](https://github.com/kubernetes/kubernetes/pull/115969), [@DangerOnTheRanger](https://github.com/DangerOnTheRanger))
- Added `messageExpression` to `ValidatingAdmissionPolicy`, to set custom failure message via CEL expression. ([#116397](https://github.com/kubernetes/kubernetes/pull/116397), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery]
- Added a new IPAddress object kind
  - Added a new ClusterIP allocator. The new allocator removes previous Service CIDR block size limitations for IPv4, and limits IPv6 size to a /64 ([#115075](https://github.com/kubernetes/kubernetes/pull/115075), [@aojea](https://github.com/aojea)) [SIG API Machinery, Apps, Auth, CLI, Cluster Lifecycle, Network and Testing]
- Added a new alpha API: ClusterTrustBundle (`certificates.k8s.io/v1alpha1`).
  A ClusterTrustBundle may be used to distribute [X.509](https://www.itu.int/rec/T-REC-X.509) trust anchors to workloads within the cluster. ([#113218](https://github.com/kubernetes/kubernetes/pull/113218), [@ahmedtd](https://github.com/ahmedtd)) [SIG API Machinery, Auth and Testing]
- Added authorization check support to the CEL expressions of ValidatingAdmissionPolicy via a `authorizer`
  variable with expressions. The new variable provides a builder that allows expressions such `authorizer.group('').resource('pods').check('create').allowed()`. ([#116054](https://github.com/kubernetes/kubernetes/pull/116054), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery and Testing]
- Added matchConditions field to ValidatingAdmissionPolicy and enabled support for CEL based custom match criteria. ([#116350](https://github.com/kubernetes/kubernetes/pull/116350), [@maxsmythe](https://github.com/maxsmythe))
- Added new option to the `InterPodAffinity` scheduler plugin to ignore existing
  pods` preferred inter-pod affinities if the incoming pod has no preferred inter-pod
  affinities. This option can be used as an optimization for higher scheduling throughput
  (at the cost of an occasional pod being scheduled non-optimally/violating existing
  pods preferred inter-pod affinities). To enable this scheduler option, set the
  `InterPodAffinity` scheduler plugin arg `ignorePreferredTermsOfExistingPods: true` ([#114393](https://github.com/kubernetes/kubernetes/pull/114393), [@danielvegamyhre](https://github.com/danielvegamyhre))
- Added the `MatchConditions` field to `ValidatingWebhookConfiguration` and `MutatingWebhookConfiguration` for the v1beta and v1 apis. 
  
  The `AdmissionWebhookMatchConditions` featuregate is now in Alpha ([#116261](https://github.com/kubernetes/kubernetes/pull/116261), [@ivelichkovich](https://github.com/ivelichkovich)) [SIG API Machinery and Testing]
- Added validation to ensure that if `service.kubernetes.io/topology-aware-hints` and `service.kubernetes.io/topology-mode` annotations are both set, they are set to the same value.Also Added deprecation warning if `service.kubernetes.io/topology-aware-hints` annotation is used. ([#116612](https://github.com/kubernetes/kubernetes/pull/116612), [@robscott](https://github.com/robscott))
- Added warnings about workload resources (Pods, ReplicaSets, Deployments, Jobs, CronJobs, or ReplicationControllers) whose names are not valid DNS labels. ([#114412](https://github.com/kubernetes/kubernetes/pull/114412), [@thockin](https://github.com/thockin))
- Adds feature gate `NodeLogQuery` which provides cluster administrators with a streaming view of logs using kubectl without them having to implement a client side reader or logging into the node. ([#96120](https://github.com/kubernetes/kubernetes/pull/96120), [@LorbusChris](https://github.com/LorbusChris))
- Api: validation of a `PodSpec` now rejects invalid `ResourceClaim` and `ResourceClaimTemplate` names. For a pod, the name generated for the `ResourceClaim` when using a template also must be valid. ([#116576](https://github.com/kubernetes/kubernetes/pull/116576), [@pohly](https://github.com/pohly))
- Bump default API QPS limits for Kubelet. ([#116121](https://github.com/kubernetes/kubernetes/pull/116121), [@wojtek-t](https://github.com/wojtek-t))
- Enabled the `StatefulSetStartOrdinal` feature gate in beta ([#115260](https://github.com/kubernetes/kubernetes/pull/115260), [@pwschuurman](https://github.com/pwschuurman))
- Enabled usage of `kube-proxy`, `kube-scheduler` and `kubelet` HTTP APIs for changing the logging
   verbosity at runtime for JSON output. ([#114609](https://github.com/kubernetes/kubernetes/pull/114609), [@pohly](https://github.com/pohly))
- Encryption of API Server at rest configuration now allows the use of wildcards in the list of resources.  For example, *.* can be used to encrypt all resources, including all current and future custom resources. ([#115149](https://github.com/kubernetes/kubernetes/pull/115149), [@nilekhc](https://github.com/nilekhc))
- Extended the kubelet's PodResources API to include resources allocated in `ResourceClaims` via `DynamicResourceAllocation`. Additionally, added a new `Get()` method to query a specific pod for its resources. ([#115847](https://github.com/kubernetes/kubernetes/pull/115847), [@moshe010](https://github.com/moshe010)) [SIG Node]
- Forbid to set matchLabelKeys when labelSelector is not set in topologySpreadConstraints ([#116535](https://github.com/kubernetes/kubernetes/pull/116535), [@denkensk](https://github.com/denkensk))
- GCE does not support LoadBalancer Services with ports with different protocols (TCP and UDP) ([#115966](https://github.com/kubernetes/kubernetes/pull/115966), [@aojea](https://github.com/aojea)) [SIG Apps and Cloud Provider]
- GRPC probes are now a GA feature. `GRPCContainerProbe` feature gate was locked to default value and will be removed in v1.29. If you were setting this feature gate explicitly, please remove it now. ([#116233](https://github.com/kubernetes/kubernetes/pull/116233), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- Graduated `Kubelet Topology Manager` to GA. ([#116093](https://github.com/kubernetes/kubernetes/pull/116093), [@swatisehgal](https://github.com/swatisehgal))
- Graduated `KubeletTracing` to beta, which means that the feature gate is now enabled by default. ([#115750](https://github.com/kubernetes/kubernetes/pull/115750), [@saschagrunert](https://github.com/saschagrunert))
- Graduated seccomp profile defaulting to GA.
  
  Set the kubelet `--seccomp-default` flag or `seccompDefault` kubelet configuration field to `true` to make pods on that node default to using the `RuntimeDefault` seccomp profile.
  
  Enabling seccomp for your workload can have a negative performance impact depending on the kernel and container runtime version in use.
  
  Guidance for identifying and mitigating those issues is outlined in the Kubernetes [seccomp tutorial](https://k8s.io/docs/tutorials/security/seccomp). ([#115719](https://github.com/kubernetes/kubernetes/pull/115719), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery, Node, Storage and Testing]
- Graduated the container resource metrics feature on `HPA` to beta. ([#116046](https://github.com/kubernetes/kubernetes/pull/116046), [@sanposhiho](https://github.com/sanposhiho))
- Implemented API streaming for the `watch-cache`
  
  When `sendInitialEvents` `ListOption` is set together with `watch=true`, it begins the watch stream with synthetic init events followed by a synthetic "Bookmark" after which the server continues streaming events. ([#110960](https://github.com/kubernetes/kubernetes/pull/110960), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Introduced API for streaming.
  
  Added `SendInitialEvents` field to the `ListOptions`. When the new option is set together with `watch=true`, it begins the watch stream with synthetic init events followed by a synthetic "Bookmark" after which the server continues streaming events. ([#115402](https://github.com/kubernetes/kubernetes/pull/115402), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Introduced a breaking change to the `resource.k8s.io` API in its `AllocationResult` struct. This change allows a kubelet plugin for the `DynamicResourceAllocation` feature to service allocations from multiple resource driver controllers. ([#116332](https://github.com/kubernetes/kubernetes/pull/116332), [@klueska](https://github.com/klueska))
- Introduces new alpha functionality to the reflector, allowing user to enable API streaming.
  
  To activate this feature, users can set the `ENABLE_CLIENT_GO_WATCH_LIST_ALPHA` environmental variable.
  It is important to note that the server must support streaming for this feature to function properly.
  If streaming is not supported by the server, the reflector will revert to the previous method
  of obtaining data through LIST/WATCH semantics. ([#110772](https://github.com/kubernetes/kubernetes/pull/110772), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- K8s.io/client-go/tools/record.EventBroadcaster: after Shutdown() is called, the broadcaster now gives up immediately after a failure to write an event to a sink. Previously it tried multiple times for 12 seconds in a goroutine. ([#115514](https://github.com/kubernetes/kubernetes/pull/115514), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- K8s.io/component-base/logs: usage of the pflag values in a normal Go flag set led to panics when printing the help message ([#114680](https://github.com/kubernetes/kubernetes/pull/114680), [@pohly](https://github.com/pohly)) [SIG Instrumentation]
- Kubeadm: explicitly set `priority` for static pods with `priorityClassName: system-node-critical` ([#114338](https://github.com/kubernetes/kubernetes/pull/114338), [@champtar](https://github.com/champtar)) [SIG Cluster Lifecycle]
- Kubelet: a "maxParallelImagePulls" field can now be specified in the kubelet configuration file to control how many image pulls the kubelet can perform in parallel. ([#115220](https://github.com/kubernetes/kubernetes/pull/115220), [@ruiwen-zhao](https://github.com/ruiwen-zhao)) [SIG API Machinery, Node and Scalability]
- Kubelet: changed `MemoryThrottlingFactor` default value to `0.9` and formulas to calculate `memory.high` ([#115371](https://github.com/kubernetes/kubernetes/pull/115371), [@pacoxu](https://github.com/pacoxu))
- Kubernetes components that perform leader election now only support using `Leases` for this. ([#114055](https://github.com/kubernetes/kubernetes/pull/114055), [@aimuz](https://github.com/aimuz))
- Migrated the `DaemonSet` controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging) ([#113622](https://github.com/kubernetes/kubernetes/pull/113622), [@249043822](https://github.com/249043822))
- New `service.kubernetes.io/topology-mode` annotation has been introduced as a replacement for the `service.kubernetes.io/topology-aware-hints` annotation.
  - `service.kubernetes.io/topology-aware-hints` annotation has been deprecated.
  - kube-proxy now accepts any value that is not "disabled" for these annotations, enabling custom implementation-specific and/or future built-in heuristics to be used. ([#116522](https://github.com/kubernetes/kubernetes/pull/116522), [@robscott](https://github.com/robscott)) [SIG Apps, Network and Testing]
- Pods owned by a Job now uses the labels `batch.kubernetes.io/job-name` and `batch.kubernetes.io/controller-uid`.
  The legacy labels `job-name` and `controller-uid` are still added for compatibility. ([#114930](https://github.com/kubernetes/kubernetes/pull/114930), [@kannon92](https://github.com/kannon92))
- Promoted `CronJobTimeZone` feature to GA ([#115904](https://github.com/kubernetes/kubernetes/pull/115904), [@soltysh](https://github.com/soltysh))
- Promoted `SelfSubjectReview` to Beta ([#116274](https://github.com/kubernetes/kubernetes/pull/116274), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Auth, CLI and Testing]
- Relaxed API validation to allow pod node selector to be mutable for gated pods (additions only, no deletions or mutations). ([#116161](https://github.com/kubernetes/kubernetes/pull/116161), [@danielvegamyhre](https://github.com/danielvegamyhre))
- Remove `kubernetes.io/grpc` standard appProtocol ([#116866](https://github.com/kubernetes/kubernetes/pull/116866), [@LiorLieberman](https://github.com/LiorLieberman)) [SIG API Machinery and Apps]
- Remove deprecated `--enable-taint-manager` and `--pod-eviction-timeout` CLI ([#115840](https://github.com/kubernetes/kubernetes/pull/115840), [@atosatto](https://github.com/atosatto))
- Removed support for the `v1alpha1` kubeletplugin API of `DynamicResourceManagement`. All plugins must be updated to `v1alpha2` in order to function properly. ([#116558](https://github.com/kubernetes/kubernetes/pull/116558), [@klueska](https://github.com/klueska))
- The API server now re-uses data encryption keys while the kms v2 plugin key ID is stable.  Data encryption keys are still randomly generated on server start but an atomic counter is used to prevent nonce collisions. ([#116155](https://github.com/kubernetes/kubernetes/pull/116155), [@enj](https://github.com/enj))
- The PodDisruptionBudget `spec.unhealthyPodEvictionPolicy` field has graduated to beta and is enabled by default. On servers with the feature enabled, this field may be set to `AlwaysAllow` to always allow unhealthy pods covered by the PodDisruptionBudget to be evicted. ([#115363](https://github.com/kubernetes/kubernetes/pull/115363), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps, Auth and Node]
- The `DownwardAPIHugePages` kubelet feature graduated to stable / GA. ([#115721](https://github.com/kubernetes/kubernetes/pull/115721), [@saschagrunert](https://github.com/saschagrunert)) [SIG Apps and Node]
- The following feature gates for volume expansion GA features have now been removed and must no longer be referenced in `--feature-gates` flags: `ExpandCSIVolumes`, `ExpandInUsePersistentVolumes`, `ExpandPersistentVolumes` ([#113942](https://github.com/kubernetes/kubernetes/pull/113942), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The list-type of the alpha `resourceClaims` field introduced to `Pods` in `1.26.0` was modified from `set` to `map`, resolving an incompatibility with use of this schema in `CustomResourceDefinitions` and with server-side apply. ([#114585](https://github.com/kubernetes/kubernetes/pull/114585), [@JoelSpeed](https://github.com/JoelSpeed))
- Updated API reference for Requests, specifying they must not exceed limits ([#115434](https://github.com/kubernetes/kubernetes/pull/115434), [@ehashman](https://github.com/ehashman))
- Updated `KMSv2` to beta ([#115123](https://github.com/kubernetes/kubernetes/pull/115123), [@aramase](https://github.com/aramase))
- Updated: Redefine AppProtocol field description and add new standard values ([#115433](https://github.com/kubernetes/kubernetes/pull/115433), [@LiorLieberman](https://github.com/LiorLieberman)) [SIG API Machinery, Apps and Network]
- `/metrics/slis` is now available for control plane components allowing you to scrape health check metrics. ([#114997](https://github.com/kubernetes/kubernetes/pull/114997), [@Richabanker](https://github.com/Richabanker))
- `APIServerTracing` feature gate is now enabled by default. Tracing in the API
  Server is still disabled by default, and requires a config file to enable. ([#116144](https://github.com/kubernetes/kubernetes/pull/116144), [@dashpole](https://github.com/dashpole))
- `NodeResourceFit` and `NodeResourcesBalancedAllocation` implement the `PreScore`
  extension point for a more performant calculation. ([#115655](https://github.com/kubernetes/kubernetes/pull/115655), [@tangwz](https://github.com/tangwz))
- `PodSchedulingReadiness` is graduated to beta. ([#115815](https://github.com/kubernetes/kubernetes/pull/115815), [@Huang-Wei](https://github.com/Huang-Wei))
- `PodSpec.Container.Resources` became mutable for CPU and memory resource types.
  - `PodSpec.Container.ResizePolicy` (new object) gives users control over how their containers are resized.
  - `PodStatus.Resize` status describes the state of a requested Pod resize.
  - `PodStatus.ResourcesAllocated` describes node resources allocated to Pod.
  - `PodStatus.Resources` describes node resources applied to running containers by CRI.
  - `UpdateContainerResources` CRI API now supports both Linux and Windows. ([#102884](https://github.com/kubernetes/kubernetes/pull/102884), [@vinaykul](https://github.com/vinaykul))
- `SELinuxMountReadWriteOncePod` graduated to Beta. ([#116425](https://github.com/kubernetes/kubernetes/pull/116425), [@jsafrane](https://github.com/jsafrane))
- `StatefulSetAutoDeletePVC` feature gate promoted to beta. ([#116501](https://github.com/kubernetes/kubernetes/pull/116501), [@mattcary](https://github.com/mattcary))
- `StatefulSet` names must be DNS labels, rather than subdomains. Any `StatefulSet`
  which took advantage of subdomain validation (by having dots in the name) can't
  possibly have worked, because we eventually set `pod.spec.hostname` from the `StatefulSetName`,
  and that is validated as a DNS label. ([#114172](https://github.com/kubernetes/kubernetes/pull/114172), [@thockin](https://github.com/thockin))
- `ValidatingAdmissionPolicy` now provides a status field that contains results of type checking the validation expression.
  The type checking is fully informational, and the behavior of the policy is unchanged. ([#115668](https://github.com/kubernetes/kubernetes/pull/115668), [@jiahuif](https://github.com/jiahuif))
- `cacheSize` field in `EncryptionConfiguration` is not supported for KMSv2 provider ([#113121](https://github.com/kubernetes/kubernetes/pull/113121), [@aramase](https://github.com/aramase))
- `k8s.io/component-base/logs` now also supports adding command line flags to a `flag.FlagSet`. ([#114731](https://github.com/kubernetes/kubernetes/pull/114731), [@pohly](https://github.com/pohly))
- `kubelet`: migrated `--container-runtime-endpoint` and `--image-service-endpoint`
  to kubelet config ([#112136](https://github.com/kubernetes/kubernetes/pull/112136), [@pacoxu](https://github.com/pacoxu))
- `resource.k8s.io/v1alpha1` was replaced with `resource.k8s.io/v1alpha2`. Before
  upgrading a cluster, all objects in resource.k8s.io/v1alpha1 (ResourceClaim, ResourceClaimTemplate,
  ResourceClass, PodScheduling) must be deleted. The changes are internal, so
  YAML files which create pods and resource claims don't need changes except for
  the newer `apiVersion`. ([#116299](https://github.com/kubernetes/kubernetes/pull/116299), [@pohly](https://github.com/pohly))
- `volumes`: `resource.claims` is now cleared for PVC specs during create or update of a pod spec with inline PVC template or of a PVC because it has no effect. ([#115928](https://github.com/kubernetes/kubernetes/pull/115928), [@pohly](https://github.com/pohly))

### Feature

- A new client side metric `rest_client_request_retries_total` has been added that tracks the number of retries sent to the server, partitioned by status code, verb and host ([#108396](https://github.com/kubernetes/kubernetes/pull/108396), [@tkashem](https://github.com/tkashem))
- A new feature was enabled to improve the performance of the iptables mode of `kube-proxy` in large clusters. No action was required, however:
  
  1. If you experienced problems with Services not syncing to iptables correctly, you can disable the feature by passing `--feature-gates=MinimizeIPTablesRestore=false` to kube-proxy (and file a bug if this fixes it). (This might also be detected by seeing the value of kube-proxy's `sync_proxy_rules_iptables_partial_restore_failures_total` metric rising.)
  2. If you were previously overriding the kube-proxy configuration for performance reasons, this may no longer be necessary. See https://kubernetes.io/docs/reference/networking/virtual-ips/#optimizing-iptables-mode-performance. ([#115138](https://github.com/kubernetes/kubernetes/pull/115138), [@danwinship](https://github.com/danwinship))
- API validation relaxed allowing Indexed Jobs to be scaled up/down by changing parallelism and completions in tandem, such that parallelism == completions. ([#115236](https://github.com/kubernetes/kubernetes/pull/115236), [@danielvegamyhre](https://github.com/danielvegamyhre)) [SIG Apps and Testing]
- Added "general", "baseline", and "restricted" debugging profiles for kubectl debug. ([#114280](https://github.com/kubernetes/kubernetes/pull/114280), [@sding3](https://github.com/sding3)) [SIG CLI]
- Added "netadmin" debugging profiles for kubectl debug. ([#115712](https://github.com/kubernetes/kubernetes/pull/115712), [@wedaly](https://github.com/wedaly)) [SIG CLI]
- Added `--output plaintext-openapiv2` argument to kubectl explain to use old openapiv2 `explain` implementation. ([#115480](https://github.com/kubernetes/kubernetes/pull/115480), [@alexzielenski](https://github.com/alexzielenski))
- Added `NewVolumeManagerReconstruction` feature gate and enabled it by default to enable updated discovery of mounted volumes during kubelet startup. Please watch for kubelet getting stuck at startup and / or not unmounting volumes from deleted Pods and report any issues in this area. ([#115268](https://github.com/kubernetes/kubernetes/pull/115268), [@jsafrane](https://github.com/jsafrane))
- Added `kubelet` Topology Manager metrics to track admission requests processed and occured admission errors. ([#115137](https://github.com/kubernetes/kubernetes/pull/115137), [@swatisehgal](https://github.com/swatisehgal))
- Added apiserver_envelope_encryption_invalid_key_id_from_status_total to measure number of times an invalid keyID is returned by the Status RPC call. ([#115846](https://github.com/kubernetes/kubernetes/pull/115846), [@ritazh](https://github.com/ritazh)) [SIG API Machinery and Auth]
- Added apiserver_envelope_encryption_kms_operations_latency_seconds metric to measure the KMSv2 grpc calls latency. ([#115649](https://github.com/kubernetes/kubernetes/pull/115649), [@aramase](https://github.com/aramase)) [SIG API Machinery, Auth and Testing]
- Added e2e test to node expand volume with secret ([#115451](https://github.com/kubernetes/kubernetes/pull/115451), [@zhucan](https://github.com/zhucan))
- Added e2e tests for kubectl `--subresource` for beta graduation ([#116590](https://github.com/kubernetes/kubernetes/pull/116590), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Added kubelet Topology Manager metric to measure topology manager admission latency. ([#115590](https://github.com/kubernetes/kubernetes/pull/115590), [@swatisehgal](https://github.com/swatisehgal))
- Added logging-format option to CCMs based on `k8s.io/cloud-provider` ([#108984](https://github.com/kubernetes/kubernetes/pull/108984), [@LittleFox94](https://github.com/LittleFox94))
- Added metrics for volume reconstruction during kubelet startup. ([#115965](https://github.com/kubernetes/kubernetes/pull/115965), [@jsafrane](https://github.com/jsafrane)) [SIG Node and Storage]
- Added new -f flag into debug command to be used passing pod or node files instead explicit names. ([#111453](https://github.com/kubernetes/kubernetes/pull/111453), [@ardaguclu](https://github.com/ardaguclu))
- Added new feature gate `ServiceNodePortStaticSubrange`, to enable the new strategy in the `NodePort` Service port allocators, so the node port range is subdivided and dynamic allocated `NodePort` port for Services are allocated preferentially from the upper range. ([#114418](https://github.com/kubernetes/kubernetes/pull/114418), [@xuzhenglun](https://github.com/xuzhenglun))
- Added scheduler preemption support for pods using `ReadWriteOncePod` PVCs ([#114051](https://github.com/kubernetes/kubernetes/pull/114051), [@chrishenzie](https://github.com/chrishenzie))
- Added the `applyconfiguration` generator to the code-generator script that generates server-side apply configuration and client APIs ([#114987](https://github.com/kubernetes/kubernetes/pull/114987), [@astefanutti](https://github.com/astefanutti))
- Added the ability to host webhooks in the cloud controller manager. ([#108838](https://github.com/kubernetes/kubernetes/pull/108838), [@nckturner](https://github.com/nckturner))
- Apiserver_storage_transformation_operations_total metric has been updated to include labels transformer_prefix and status. ([#115394](https://github.com/kubernetes/kubernetes/pull/115394), [@ritazh](https://github.com/ritazh)) [SIG API Machinery, Auth, Instrumentation and Testing]
- By enabling the `UserNamespacesStatelessPodsSupport` feature gate in kubelet, you can now run a stateless pod in a separate user namespace ([#116377](https://github.com/kubernetes/kubernetes/pull/116377), [@giuseppe](https://github.com/giuseppe)) [SIG Apps, Node and Storage]
- By enabling the alpha `CloudNodeIPs` feature gate in kubelet and the cloud
  provider, you can now specify a dual-stack `--node-ip` value (when using an
  external cloud provider that supports that functionality). ([#116305](https://github.com/kubernetes/kubernetes/pull/116305), [@danwinship](https://github.com/danwinship)) [SIG API Machinery, Cloud Provider, Network and Node]
- Changed kubectl `--subresource` flag to beta ([#116595](https://github.com/kubernetes/kubernetes/pull/116595), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Changed metrics for aggregated discovery to publish new time series (alpha). ([#115630](https://github.com/kubernetes/kubernetes/pull/115630), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery and Testing]
- Dynamic Resource Allocation framework can be used for network devices ([#114364](https://github.com/kubernetes/kubernetes/pull/114364), [@bart0sh](https://github.com/bart0sh)) [SIG Node]
- Enable external plugins can be used as subcommands for kubectl create command if subcommand does not exist as builtin only when KUBECTL_ENABLE_CMD_SHADOW environment variable is exported. ([#116293](https://github.com/kubernetes/kubernetes/pull/116293), [@ardaguclu](https://github.com/ardaguclu))
- GRPC probes now set a linger option of 1s to improve the TIME-WAIT state. ([#115321](https://github.com/kubernetes/kubernetes/pull/115321), [@rphillips](https://github.com/rphillips)) [SIG Network and Node]
- Graduated CRI Events driven Pod LifeCycle Event Generator (Evented PLEG) to Beta ([#115967](https://github.com/kubernetes/kubernetes/pull/115967), [@harche](https://github.com/harche))
- Graduated `matchLabelKeys` in `podTopologySpread` to Beta ([#116291](https://github.com/kubernetes/kubernetes/pull/116291), [@denkensk](https://github.com/denkensk))
- Graduated the `CSINodeExpandSecret` feature to Beta. This feature facilitates passing secrets to CSI driver as part of Node Expansion CSI operation. ([#115621](https://github.com/kubernetes/kubernetes/pull/115621), [@humblec](https://github.com/humblec))
- Graduated the `LegacyServiceAccountTokenTracking` feature gate to Beta. The usage of auto-generated secret-based service account token now produces warnings by default, and relevant Secrets are labeled with a last-used timestamp (label key `kubernetes.io/legacy-token-last-used`). ([#114523](https://github.com/kubernetes/kubernetes/pull/114523), [@zshihang](https://github.com/zshihang)) [SIG API Machinery and Auth]
- HPA controller exposes the following metrics from the kube-controller-manager.
  - `metric_computation_duration_seconds`: Number of metric computations. 
  - `metric_computation_total`: The time(seconds) that the HPA controller takes to calculate one metric. ([#116326](https://github.com/kubernetes/kubernetes/pull/116326), [@sanposhiho](https://github.com/sanposhiho)) [SIG Apps, Autoscaling and Instrumentation]
- HPA controller starts to expose metrics from the kube-controller-manager.\n- `reconciliations_total`: Number of reconciliation of HPA controller. \n- `reconciliation_duration_seconds`: The time(seconds) that the HPA controller takes to reconcile once. ([#116010](https://github.com/kubernetes/kubernetes/pull/116010), [@sanposhiho](https://github.com/sanposhiho))
- Kube-up now includes `CoreDNS` version `v1.9.3` ([#114279](https://github.com/kubernetes/kubernetes/pull/114279), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: added the experimental (alpha) feature gate `EtcdLearnerMode` that allows etcd members to be joined as learner and only then promoted as voting members ([#113318](https://github.com/kubernetes/kubernetes/pull/113318), [@pacoxu](https://github.com/pacoxu))
- Kubectl will now display `SeccompProfile` for pods, containers and ephemeral containers, if values were set. ([#113284](https://github.com/kubernetes/kubernetes/pull/113284), [@williamyeh](https://github.com/williamyeh))
- Kubectl: added e2e test for default container annotation ([#115046](https://github.com/kubernetes/kubernetes/pull/115046), [@pacoxu](https://github.com/pacoxu))
- Kubelet TCP and HTTP probes are now more effective using networking resources:
  conntrack entries, sockets. This is achieved by reducing the `TIME-WAIT` state
  of the connection to 1 second, instead of the defaults 60 seconds. This allows
  kubelet to free the socket, and free conntrack entry and ephemeral port associated. ([#115143](https://github.com/kubernetes/kubernetes/pull/115143), [@aojea](https://github.com/aojea))
- Kubelet allows pods to use the `net.ipv4.ip_local_reserved_ports` sysctl by default and the minimal kernel version is 3.16; Pod Security admission allows this sysctl in v1.27+ versions of the baseline and restricted policies. ([#115374](https://github.com/kubernetes/kubernetes/pull/115374), [@pacoxu](https://github.com/pacoxu)) [SIG Auth, Network and Node]
- Kubelet config file will be backed up to `/etc/kubernetes/tmp/` folder with `kubeadm-kubelet-config` append with a random suffix as the filename ([#114695](https://github.com/kubernetes/kubernetes/pull/114695), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle]
- Kubernetes is now built with Go `1.19.5` ([#115010](https://github.com/kubernetes/kubernetes/pull/115010), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with go 1.20 ([#114502](https://github.com/kubernetes/kubernetes/pull/114502), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Kubernetes is now built with go 1.20.1 ([#115828](https://github.com/kubernetes/kubernetes/pull/115828), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Kubernetes is now built with go 1.20.2 ([#116404](https://github.com/kubernetes/kubernetes/pull/116404), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Locked `CSIMigrationvSphere` feature gate. ([#116610](https://github.com/kubernetes/kubernetes/pull/116610), [@xing-yang](https://github.com/xing-yang))
- Made `apiextensions-apiserver` binary linking static (also affects the deb and rpm packages). ([#114226](https://github.com/kubernetes/kubernetes/pull/114226), [@saschagrunert](https://github.com/saschagrunert))
- Made `kube-aggregator` binary linking static (also affects the deb and rpm packages). ([#114227](https://github.com/kubernetes/kubernetes/pull/114227), [@saschagrunert](https://github.com/saschagrunert))
- Made `kubectl-convert` binary linking static (also affects the deb and rpm packages). ([#114228](https://github.com/kubernetes/kubernetes/pull/114228), [@saschagrunert](https://github.com/saschagrunert))
- Migrated controller helper functions to use contextual logging. ([#115049](https://github.com/kubernetes/kubernetes/pull/115049), [@fatsheep9146](https://github.com/fatsheep9146))
- Migrated the ResourceQuota controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113315](https://github.com/kubernetes/kubernetes/pull/113315), [@ncdc](https://github.com/ncdc)) [SIG API Machinery, Apps and Testing]
- Migrated the StatefulSet controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging) ([#113840](https://github.com/kubernetes/kubernetes/pull/113840), [@249043822](https://github.com/249043822))
- Migrated the `ClusterRole` aggregation controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113910](https://github.com/kubernetes/kubernetes/pull/113910), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated the `Deployment` controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging) ([#113525](https://github.com/kubernetes/kubernetes/pull/113525), [@249043822](https://github.com/249043822))
- Migrated the `ReplicaSet` controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#114871](https://github.com/kubernetes/kubernetes/pull/114871), [@Namanl2001](https://github.com/Namanl2001))
- Migrated the bootstrap signer controller and the token cleaner controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113464](https://github.com/kubernetes/kubernetes/pull/113464), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery, Apps and Instrumentation]
- Migrated the defaultbinder scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116571](https://github.com/kubernetes/kubernetes/pull/116571), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Migrated the main kube-controller-manager binary to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116529](https://github.com/kubernetes/kubernetes/pull/116529), [@pohly](https://github.com/pohly))
- Migrated the namespace controller (within `kube-controller-manager`) to support [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113443](https://github.com/kubernetes/kubernetes/pull/113443), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Migrated the service-account controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#114918](https://github.com/kubernetes/kubernetes/pull/114918), [@Namanl2001](https://github.com/Namanl2001)) [SIG API Machinery, Apps, Auth, Instrumentation and Testing]
- Migrated the volume attach/detach controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging).
  Migrated the `PersistentVolumeClaim` protection controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging).
  Migrated the `PersistentVolume` protection controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113584](https://github.com/kubernetes/kubernetes/pull/113584), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Migrated the “TTL after finished” controller (within `kube-controller-manager`)to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113916](https://github.com/kubernetes/kubernetes/pull/113916), [@songxiao-wang87](https://github.com/songxiao-wang87))
- NONE ([#113428](https://github.com/kubernetes/kubernetes/pull/113428), [@mengjiao-liu](https://github.com/mengjiao-liu))
- New plugin_evaluation_total is added to the scheduler.This metric counts how many times the specific plugin affects the scheduling result. The metric does not get incremented when the plugin has nothing to do with an incoming Pod. ([#115082](https://github.com/kubernetes/kubernetes/pull/115082), [@sanposhiho](https://github.com/sanposhiho))
- Node `ipam` controller now exposes metrics `cidrset_cidrs_max_total` and `multicidrset_cidrs_max_total` with information about the max number of CIDRs that can be allocated. ([#112260](https://github.com/kubernetes/kubernetes/pull/112260), [@aryan9600](https://github.com/aryan9600))
- Performance improvements in `klog` ([#115277](https://github.com/kubernetes/kubernetes/pull/115277), [@pohly](https://github.com/pohly))
- Pod template `schedulingGates` are now mutable for Jobs that are suspended and have never been started ([#115940](https://github.com/kubernetes/kubernetes/pull/115940), [@ahg-g](https://github.com/ahg-g)) [SIG Apps]
- Pods which have an invalid negative `spec.terminationGracePeriodSeconds` value will now be treated as having a `terminationGracePeriodSeconds` of `1` ([#115606](https://github.com/kubernetes/kubernetes/pull/115606), [@wzshiming](https://github.com/wzshiming))
- Profiling can now be served on a unix-domain socket by using the `--profiling-path` option (when profiling is enabled) for security purposes. ([#114191](https://github.com/kubernetes/kubernetes/pull/114191), [@apelisse](https://github.com/apelisse)) [SIG API Machinery]
- Promote aggregated discovery endpoint to beta and it will be enabled by default ([#116108](https://github.com/kubernetes/kubernetes/pull/116108), [@Jefftree](https://github.com/Jefftree))
- Promoted `OpenAPIV3` to GA ([#116235](https://github.com/kubernetes/kubernetes/pull/116235), [@Jefftree](https://github.com/Jefftree))
- Promoted `whoami` kubectl command. ([#116510](https://github.com/kubernetes/kubernetes/pull/116510), [@nabokihms](https://github.com/nabokihms))
- Scheduler no longer runs the plugin's `Filter` method when its `PreFilter` method returned a Skip status.
  In other words, your `PreFilter`/`Filter` plugin can return a Skip status in `PreFilter` if the plugin does nothing in Filter for that Pod.
  Scheduler skips `NodeAffinity` Filter plugin when `NodeAffinity` Filter plugin has nothing to do with a Pod.
  It may affect some metrics values related to the `NodeAffinity` Filter plugin. ([#114125](https://github.com/kubernetes/kubernetes/pull/114125), [@sanposhiho](https://github.com/sanposhiho))
- Scheduler now skips `InterPodAffinity` Filter plugin when `InterPodAffinity` Filter plugin has nothing to do with a Pod.
  It may affect some metrics values related to the `InterPodAffinity` Filter plugin. ([#114889](https://github.com/kubernetes/kubernetes/pull/114889), [@sanposhiho](https://github.com/sanposhiho))
- Scheduler volumebinding: leveraged `PreFilterResult` to reduce down to only
  eligible node(s) for pod with bound claim(s) to local `PersistentVolume(s)` ([#109877](https://github.com/kubernetes/kubernetes/pull/109877), [@yibozhuang](https://github.com/yibozhuang))
- Scheduling cycle now terminates immediately when any scheduler plugin returns an 
  `unschedulableAndUnresolvable` status in `PostFilter`. ([#114699](https://github.com/kubernetes/kubernetes/pull/114699), [@kerthcet](https://github.com/kerthcet))
- Since Kubernetes v1.5, `kubectl apply` has had an alpha-stage `--prune` flag to support deleting previously applied objects that have been removed from the input manifest. This feature has remained in alpha ever since due to performance and correctness issues inherent in its design. This PR exposes a second, independent pruning alpha powered by a new standard named `ApplySets`. An `ApplySet` is a server-side object (by default, a Secret; ConfigMaps are also allowed) that kubectl can use to accurately and efficiently track set membership across `apply` operations. The format used for `ApplySet` is set out in  [KEP 3659](https://github.com/kubernetes/enhancements/issues/3659) as a low-level specification.  Other tools in the ecosystem can also build on this specification for improved interoperability.  To try the ApplySet-based pruning alpha, set `KUBECTL_APPLYSET=true` and use the flags `--prune --applyset=secret-name` with `kubectl apply`. ([#116205](https://github.com/kubernetes/kubernetes/pull/116205), [@justinsb](https://github.com/justinsb))
- Switched kubectl explain to use OpenAPIV3 information published by the server. OpenAPIV2 backend can  still be used with the `--output plaintext-openapiv2` argument ([#116390](https://github.com/kubernetes/kubernetes/pull/116390), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery, CLI and Testing]
- The Pod API field `.spec.schedulingGates[*].name` now requires qualified names (like `example.com/mygate`), matching validation for names of `.spec.readinessGates[*].name`. Any uses of the alpha scheduling gate feature prior to 1.27 that do not match that validation must be renamed or deleted before upgrading to 1.27. ([#115821](https://github.com/kubernetes/kubernetes/pull/115821), [@lianghao208](https://github.com/lianghao208)) [SIG Apps and Scheduling]
- The Scheduler did not run the plugin Score method when its PreScore method returned a Skip status. In other words, the PreScore/Score plugin could return a Skip status in PreScore if the plugin did nothing in Score for that Pod. ([#115652](https://github.com/kubernetes/kubernetes/pull/115652), [@AxeZhan](https://github.com/AxeZhan))
- The `AdvancedAuditing` feature gate was locked to _true_ in v1.27, and will be removed completely in v1.28 ([#115163](https://github.com/kubernetes/kubernetes/pull/115163), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery]
- The `JobMutableNodeSchedulingDirectives` feature gate has graduated to GA. ([#116116](https://github.com/kubernetes/kubernetes/pull/116116), [@ahg-g](https://github.com/ahg-g)) [SIG Apps, Scheduling and Testing]
- The `ReadWriteOncePod` feature gate has been graduated to beta. ([#114494](https://github.com/kubernetes/kubernetes/pull/114494), [@chrishenzie](https://github.com/chrishenzie))
- The bug which caused the status of Indexed Jobs to only update when new indexes were completed was fixed. Now, completed indexes are updated even if the `.status.completedIndexes` values are outside the `[0, .spec.completions> range`. ([#115349](https://github.com/kubernetes/kubernetes/pull/115349), [@danielvegamyhre](https://github.com/danielvegamyhre))
- The go version defined in `.go-version` is now fetched when invoking test, build, and code generation targets if the current go version does not match it. Set $FORCE_HOST_GO=y while testing or building to skip this behavior, or set $GO_VERSION to override the selected go version. ([#115377](https://github.com/kubernetes/kubernetes/pull/115377), [@liggitt](https://github.com/liggitt)) [SIG Testing]
- The job controller back-off logic is now decoupled from workqueue. In case of parallelism > 1, if there are multiple new failures in a reconciliation cycle, all the failures are taken into account to compute the back-off. Previously, the back-off kicked in for all types of failures; with this change, only pod failures are taken into account. If the back-off limits exceeds, the job is marked as failed immediately; before this change, the job is marked as failed in the next back-off. ([#114768](https://github.com/kubernetes/kubernetes/pull/114768), [@sathyanarays](https://github.com/sathyanarays)) [SIG Apps and Testing]
- The mount-utils mounter now provides an option to limit the number of concurrent format operations. ([#115379](https://github.com/kubernetes/kubernetes/pull/115379), [@artemvmin](https://github.com/artemvmin)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node and Storage]
- The scheduler's metric `plugin_execution_duration_seconds` now records `PreEnqueue` plugins execution seconds. ([#116201](https://github.com/kubernetes/kubernetes/pull/116201), [@sanposhiho](https://github.com/sanposhiho))
- Two changes to the `/debug/api_priority_and_fairness/dump_priority_levels` endpoint of API Priority and Fairness: added total number of dispatched, timed-out, rejected and cancelled requests; output now sorted by `PriorityLevelName`. ([#112393](https://github.com/kubernetes/kubernetes/pull/112393), [@borgerli](https://github.com/borgerli))
- Unlocked the `CSIMigrationvSphere` feature gate.
  The change allow users to continue using the in-tree vSphere driver,pending a vSphere
  CSI driver release that has with GA support for Windows, XFS, and raw block access. ([#116342](https://github.com/kubernetes/kubernetes/pull/116342), [@msau42](https://github.com/msau42)) [SIG Storage]
- Updated `cAdvisor` to `v0.47.0` ([#114883](https://github.com/kubernetes/kubernetes/pull/114883), [@bobbypage](https://github.com/bobbypage))
- Updated `kube-apiserver` SLO/SLI latency metrics to exclude priority & fairness queue wait times ([#116420](https://github.com/kubernetes/kubernetes/pull/116420), [@andrewsykim](https://github.com/andrewsykim))
- Updated distroless iptables to use released image `registry.k8s.io/build-image/distroless-iptables:v0.2.2`
  - Updated setcap to use released image `registry.k8s.io/build-image/setcap:bullseye-v1.4.2` ([#116509](https://github.com/kubernetes/kubernetes/pull/116509), [@cpanato](https://github.com/cpanato)) [SIG Testing]
- Updated distroless iptables to use released image `registry.k8s.io/distroless-iptables:v0.2.1` ([#115905](https://github.com/kubernetes/kubernetes/pull/115905), [@cpanato](https://github.com/cpanato)) [SIG Testing]
- Upgrades functionality of `kubectl kustomize` as described at
  https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv5.0.0 and https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv5.0.1. 
  
  This is a new major release of kustomize, so there are a few backwards-incompatible changes, most of which are rare use cases, bug fixes with side effects, or things that have been deprecated for multiple releases already:
  
  - https://github.com/kubernetes-sigs/kustomize/pull/4911: Drop support for a very old, legacy style of patches. patches used to be allowed to be used as an alias for patchesStrategicMerge in kustomize v3. You now have to use patchesStrategicMerge explicitly, or update to the new syntax supported by patches. See examples in the PR description of https://github.com/kubernetes-sigs/kustomize/pull/4911.
  - https://github.com/kubernetes-sigs/kustomize/issues/4731: Remove a potential build-time side-effect in ConfigMapGenerator and SecretGenerator, which loaded values from the local environment under some circumstances, breaking kustomize build's side-effect-free promise. While this behavior was never intended, we deprecated it and are announcing it as a breaking change since it existed for a long time. See also the Eschewed Features documentation.
  - https://github.com/kubernetes-sigs/kustomize/pull/4985: If you previously included .git in an AWS or Azure URL, we will no longer automatically remove that suffix. You may need to add an extra / to replace the .git for the URL to properly resolve.
  - https://github.com/kubernetes-sigs/kustomize/pull/4954: Drop support for using gh: as a host (e.g. gh:kubernetes-sigs/kustomize). We were unable to find any usage of or basis for this and believe it may have been targeting a custom gitconfig shorthand syntax. ([#116598](https://github.com/kubernetes/kubernetes/pull/116598), [@natasha41575](https://github.com/natasha41575)) [SIG CLI]
- When an unsupported PodDisruptionBudget configuration is found, an event and log will be emitted to inform users of the misconfiguration. ([#115861](https://github.com/kubernetes/kubernetes/pull/115861), [@JayKayy](https://github.com/JayKayy)) [SIG Apps]
- [E2E] Pods spawned by E2E tests can now pull images from the private registry using the new --e2e-docker-config-file flag ([#114625](https://github.com/kubernetes/kubernetes/pull/114625), [@Divya063](https://github.com/Divya063)) [SIG Node and Testing]
- [alpha: kubectl apply --prune --applyset] Enabled certain custom resources (CRs) to be used as `ApplySet` parent objects. To enable this for a given CR, apply the label `applyset.kubernetes.io/is-parent-type: true` to the CustomResourceDefinition (CRD) that defines it. ([#116353](https://github.com/kubernetes/kubernetes/pull/116353), [@KnVerey](https://github.com/KnVerey))
- `Kubelet` no longer creates certain legacy iptables rules by default.
  It is possible that this will cause problems with some third-party components
  that improperly depended on those rules. If this affects you, you can run
  `kubelet` with `--feature-gates=IPTablesOwnershipCleanup=false`, but a bug should also be filed against the third-party component. ([#114472](https://github.com/kubernetes/kubernetes/pull/114472), [@danwinship](https://github.com/danwinship))
- `MinDomainsInPodTopologySpread` feature gate is enabled by default as a
  Beta feature in 1.27. ([#114445](https://github.com/kubernetes/kubernetes/pull/114445), [@mengjiao-liu](https://github.com/mengjiao-liu))
- `Secret` of `kubernetes.io/tls` type now verifies that the private key matches the cert ([#113581](https://github.com/kubernetes/kubernetes/pull/113581), [@aimuz](https://github.com/aimuz))
- `StorageVersionGC` (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113986](https://github.com/kubernetes/kubernetes/pull/113986), [@songxiao-wang87](https://github.com/songxiao-wang87))
- `client-go`: `sharedInformerFactory` now waits for goroutines during shutdown for metadatainformer and dynamicinformer. ([#114434](https://github.com/kubernetes/kubernetes/pull/114434), [@howardjohn](https://github.com/howardjohn))
- `kube-proxy` now accepts the `ContextualLogging`, `LoggingAlphaOptions`,
  `LoggingBetaOptions` ([#115233](https://github.com/kubernetes/kubernetes/pull/115233), [@pohly](https://github.com/pohly))
- `kube-scheduler`: Optimized implementation of null `labelSelector` in topology spreading. ([#116607](https://github.com/kubernetes/kubernetes/pull/116607), [@alculquicondor](https://github.com/alculquicondor))
- `kubeadm`: now shows a warning message when detecting that the sandbox image of the container runtime is inconsistent with that used by kubeadm ([#115610](https://github.com/kubernetes/kubernetes/pull/115610), [@SataQiu](https://github.com/SataQiu))
- `kubectl` now uses `HorizontalPodAutoscaler` `v2` by default. ([#114886](https://github.com/kubernetes/kubernetes/pull/114886), [@a7i](https://github.com/a7i))
- Kubernetes is now built with Go 1.20.3 ([#117125](https://github.com/kubernetes/kubernetes/pull/117125), [@xmudrii](https://github.com/xmudrii)) [SIG Release and Testing]
- Updated distroless iptables to use released image `registry.k8s.io/build-image/distroless-iptables:v0.2.3` ([#117126](https://github.com/kubernetes/kubernetes/pull/117126), [@xmudrii](https://github.com/xmudrii)) [SIG Testing]

### Documentation

- Documented the reason field in CRI API to ensure it equals `OOMKilled` for the containers terminated by OOM killer ([#112977](https://github.com/kubernetes/kubernetes/pull/112977), [@mimowo](https://github.com/mimowo))
- Error message for Pods with requests exceeding limits will have a limit value printed. ([#112925](https://github.com/kubernetes/kubernetes/pull/112925), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- The change affects the following CLI command:
  
  kubectl create rolebinding -h ([#107124](https://github.com/kubernetes/kubernetes/pull/107124), [@ptux](https://github.com/ptux)) [SIG CLI]

### Failing Test

- Deflaked a preemption test that may patch Nodes incorrectly. ([#114350](https://github.com/kubernetes/kubernetes/pull/114350), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed panic in vSphere e2e tests. ([#115863](https://github.com/kubernetes/kubernetes/pull/115863), [@jsafrane](https://github.com/jsafrane)) [SIG Storage and Testing]
- Setting the Kubelet config option `--resolv-conf=Host` on Windows will now result in Kubelet applying the Pod DNS Policies as intended. ([#110566](https://github.com/kubernetes/kubernetes/pull/110566), [@claudiubelu](https://github.com/claudiubelu))

### Bug or Regression

- Added (dry run) and (server dry run) suffixes to `kubectl scale` command when `dry-run` is passed ([#114252](https://github.com/kubernetes/kubernetes/pull/114252), [@ardaguclu](https://github.com/ardaguclu))
- Applied configurations can be generated for types with `non-builtin` map fields ([#114920](https://github.com/kubernetes/kubernetes/pull/114920), [@astefanutti](https://github.com/astefanutti))
- Changed the error message of `kubectl rollout restart` when subsequent `kubectl rollout restart` commands are executed within a second ([#113040](https://github.com/kubernetes/kubernetes/pull/113040), [@ardaguclu](https://github.com/ardaguclu))
- Changed the error message to `cannot exec into multiple objects at a time` when file passed to `kubectl exec` contains multiple resources ([#114249](https://github.com/kubernetes/kubernetes/pull/114249), [@ardaguclu](https://github.com/ardaguclu))
- Client-go: fixed potential data races retrying requests using a custom `io.Reader` body; with this fix, only requests with no body or with `string` / `[]byte` / `runtime.Object` bodies can be retried ([#113933](https://github.com/kubernetes/kubernetes/pull/113933), [@liggitt](https://github.com/liggitt))
- Describing the CRs will now hide `.metadata.managedFields` ([#114584](https://github.com/kubernetes/kubernetes/pull/114584), [@soltysh](https://github.com/soltysh))
- Discovery document will correctly return the resources for aggregated apiservers that do not implement aggregated disovery ([#115770](https://github.com/kubernetes/kubernetes/pull/115770), [@Jefftree](https://github.com/Jefftree))
- Excluded preemptor pod metadata in the event message ([#114923](https://github.com/kubernetes/kubernetes/pull/114923), [@mimowo](https://github.com/mimowo))
- Expanded the partial fix for https://github.com/kubernetes/kubernetes/issues/111539
  which was already started in https://github.com/kubernetes/kubernetes/pull/109706
  Specifically, we will now reduce the amount of syncs for `ETP=local` services even
  further in the CCM and avoid re-configuring LBs to an even greater extent. ([#111658](https://github.com/kubernetes/kubernetes/pull/111658), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- File content check for IPV4 is now enabled by default, and the check of IPV4 or IPV6 is done for `kubeadm init` or `kubeadm join` only in case the user intends to create a cluster to support that kind of IP address family ([#115420](https://github.com/kubernetes/kubernetes/pull/115420), [@chendave](https://github.com/chendave))
- Fixed CSI `PersistentVolumes` to allow Secrets names longer than 63 characters. ([#114776](https://github.com/kubernetes/kubernetes/pull/114776), [@jsafrane](https://github.com/jsafrane))
- Fixed Route controller to update routes when NodeIP changes ([#108095](https://github.com/kubernetes/kubernetes/pull/108095), [@lzhecheng](https://github.com/lzhecheng))
- Fixed `DaemonSet` to update the status even if it fails to create a pod. ([#113787](https://github.com/kubernetes/kubernetes/pull/113787), [@gjkim42](https://github.com/gjkim42))
- Fixed `SELinux` label for host path volumes created by host path provisioner ([#112021](https://github.com/kubernetes/kubernetes/pull/112021), [@mrunalp](https://github.com/mrunalp))
- Fixed `StatefulSetAutoDeletePVC` feature when `OwnerReferencesPermissionEnforcement` admission plugin is enabled. ([#114116](https://github.com/kubernetes/kubernetes/pull/114116), [@jsafrane](https://github.com/jsafrane))
- Fixed a bug on the `EndpointSlice` mirroring controller that generated multiple slices in some cases for custom endpoints in non canonical format. ([#114155](https://github.com/kubernetes/kubernetes/pull/114155), [@aojea](https://github.com/aojea))
- Fixed a bug that caused the `apiserver` to panic when trying to allocate a Service with a dynamic `ClusterIP` and was configured with Service CIDRs with a /28 mask for IPv4 and a /124 mask for IPv6 ([#115322](https://github.com/kubernetes/kubernetes/pull/115322), [@aojea](https://github.com/aojea))
- Fixed a bug where Kubernetes would apply a default StorageClass to a PersistentVolumeClaim,
  even when the deprecated annotation `volume.beta.kubernetes.io/storage-class` was set. ([#116089](https://github.com/kubernetes/kubernetes/pull/116089), [@cvvz](https://github.com/cvvz)) [SIG Apps and Storage]
- Fixed a bug where `events/v1` `Events` with similar event type and reporting instance were not aggregated by `client-go`. ([#112365](https://github.com/kubernetes/kubernetes/pull/112365), [@dgrisonnet](https://github.com/dgrisonnet))
- Fixed a bug where when emitting similar Events consecutively, some were rejected by the apiserver. ([#114237](https://github.com/kubernetes/kubernetes/pull/114237), [@dgrisonnet](https://github.com/dgrisonnet))
- Fixed a data race when emitting similar Events consecutively ([#114236](https://github.com/kubernetes/kubernetes/pull/114236), [@dgrisonnet](https://github.com/dgrisonnet))
- Fixed a log line in scheduler that inaccurately implies that volume binding has finalized ([#116018](https://github.com/kubernetes/kubernetes/pull/116018), [@TommyStarK](https://github.com/TommyStarK))
- Fixed a rare race condition in `kube-apiserver` that could lead to missing events when a watch API request was created at the same time `kube-apiserver` was re-initializing its internal watch. ([#116172](https://github.com/kubernetes/kubernetes/pull/116172), [@wojtek-t](https://github.com/wojtek-t))
- Fixed a regression in the pod binding subresource to honor the `metadata.uid` precondition.
  This allows kube-scheduler to ensure it is assigns node names to the same instances of pods it made scheduling decisions for. ([#116550](https://github.com/kubernetes/kubernetes/pull/116550), [@alculquicondor](https://github.com/alculquicondor))
- Fixed a regression that the scheduler always goes through all Filter plugins. ([#114518](https://github.com/kubernetes/kubernetes/pull/114518), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed an EndpointSlice Controller hashing bug that could cause EndpointSlices to incorrectly handle Pods with duplicate IP addresses. For example this could happen when a new Pod reused an IP that was also assigned to a Pod in a completed state. ([#115907](https://github.com/kubernetes/kubernetes/pull/115907), [@qinqon](https://github.com/qinqon)) [SIG Apps and Network]
- Fixed an issue where a CSI migrated volume may be prematurely detached when the CSI driver is not running on the node.
  If CSI migration is enabled on the node, even the csi-driver is not up and ready, we will still add this volume to DSW. ([#115464](https://github.com/kubernetes/kubernetes/pull/115464), [@sunnylovestiramisu](https://github.com/sunnylovestiramisu))
- Fixed an issue where failed pods associated with a job with `parallelism = 1` are recreated by the job controller honoring exponential backoff delay again. However, for jobs with `parallelism > 1`, pods might be created without exponential backoff delay. ([#114516](https://github.com/kubernetes/kubernetes/pull/114516), [@nikhita](https://github.com/nikhita))
- Fixed an issue with Winkernel Proxier - ClusterIP Loadbalancers missing if the `ExternalTrafficPolicy` is set to Local and the available endpoints are all `remoteEndpoints`. ([#115919](https://github.com/kubernetes/kubernetes/pull/115919), [@princepereira](https://github.com/princepereira))
- Fixed bug in CRD Validation Rules (beta) and `ValidatingAdmissionPolicy` (alpha) where all admission requests could result in `internal error: runtime error: index out of range [3] with length 3 evaluating rule: <rule name>` under certain circumstances. ([#114857](https://github.com/kubernetes/kubernetes/pull/114857), [@jpbetz](https://github.com/jpbetz))
- Fixed bug in beta aggregated discovery endpoint which caused CRD discovery information to be temporarily missing when an Aggregated APIService with the same GroupVersion is deleted (and vice versa). ([#116770](https://github.com/kubernetes/kubernetes/pull/116770), [@alexzielenski](https://github.com/alexzielenski))
- Fixed bug in reflector that couldn't recover from `Too large resource version` errors with API servers before 1.17.0. ([#115093](https://github.com/kubernetes/kubernetes/pull/115093), [@xuzhenglun](https://github.com/xuzhenglun))
- Fixed clearing of rate-limiter for the queue of checks for cleaning stale pod disruption conditions. The bug could result in the PDB synchronization updates firing too often or the pod disruption cleanups taking too long to happen. ([#114770](https://github.com/kubernetes/kubernetes/pull/114770), [@mimowo](https://github.com/mimowo))
- Fixed data race in `kube-scheduler` when preemption races with a Pod update. ([#116395](https://github.com/kubernetes/kubernetes/pull/116395), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fixed file permission issues that happened during update of `Secret`/`ConfigMap`/`projected volume` when `fsGroup` is used. The problem caused a race condition where application gets intermittent permission denied error when reading files that were just updated, before the correct permissions were applied. ([#114464](https://github.com/kubernetes/kubernetes/pull/114464), [@tsaarni](https://github.com/tsaarni))
- Fixed incorrect watch events when a watch is initialized simultanously with a reinitializing watchcache. ([#116436](https://github.com/kubernetes/kubernetes/pull/116436), [@wojtek-t](https://github.com/wojtek-t))
- Fixed issue in `Winkernel` Proxier - Unexpected active TCP connection drops while horizontally scaling the endpoints for a LoadBalancer Service with Internal Traffic Policy: `Local` ([#113742](https://github.com/kubernetes/kubernetes/pull/113742), [@princepereira](https://github.com/princepereira))
- Fixed issue on Windows when calculating cpu limits on nodes with more than 64 logical processors ([#114231](https://github.com/kubernetes/kubernetes/pull/114231), [@mweibel](https://github.com/mweibel))
- Fixed issue with Winkernel Proxier - IPV6 load balancer policies were missing when service was configured with `ipFamilyPolicy`: `RequireDualStack` ([#115503](https://github.com/kubernetes/kubernetes/pull/115503), [@princepereira](https://github.com/princepereira))
- Fixed issue with Winkernel Proxier - IPV6 load balancer policies were missing when service was configured with `ipFamilyPolicy`: `RequireDualStack` ([#115577](https://github.com/kubernetes/kubernetes/pull/115577), [@princepereira](https://github.com/princepereira))
- Fixed issue with `Winkernel Proxier` - No ingress load balancer rules with endpoints to support load balancing when all the endpoints are terminating. ([#113776](https://github.com/kubernetes/kubernetes/pull/113776), [@princepereira](https://github.com/princepereira))
- Fixed missing delete events on informer re-lists to ensure all delete events were correctly emitted and using the latest known object state, so that all event handlers and stores always reflect the actual apiserver state as best as possible ([#115620](https://github.com/kubernetes/kubernetes/pull/115620), [@odinuge](https://github.com/odinuge))
- Fixed nil pointer error in `NodeVolumeLimits` csi logging ([#115179](https://github.com/kubernetes/kubernetes/pull/115179), [@sunnylovestiramisu](https://github.com/sunnylovestiramisu))
- Fixed panic validating custom resource definition schemas that set `multipleOf` to 0 ([#114869](https://github.com/kubernetes/kubernetes/pull/114869), [@liggitt](https://github.com/liggitt))
- Fixed performance regression in scheduler caused by frequent metric lookup on critical code path. ([#116428](https://github.com/kubernetes/kubernetes/pull/116428), [@mborsz](https://github.com/mborsz)) [SIG Scheduling]
- Fixed stuck apiserver if an aggregated apiservice returned `304 Not Modified` for aggregated discovery information ([#114459](https://github.com/kubernetes/kubernetes/pull/114459), [@alexzielenski](https://github.com/alexzielenski))
- Fixed the problem Pod terminating stuck because of trying to umount not actual mounted dir. ([#115769](https://github.com/kubernetes/kubernetes/pull/115769), [@mochizuki875](https://github.com/mochizuki875))
- Fixed the regression that introduced 34s timeout for DELETECOLLECTION calls ([#115341](https://github.com/kubernetes/kubernetes/pull/115341), [@tkashem](https://github.com/tkashem))
- Fixed two regressions introduced by the `PodDisruptionConditions` feature (on by default in 1.26):
  - pod eviction API calls returned spurious precondition errors and required a second evict API call to succeed
  - dry-run eviction API calls persisted a DisruptionTarget condition into the pod being evicted ([#116554](https://github.com/kubernetes/kubernetes/pull/116554), [@atiratree](https://github.com/atiratree))
- Fixes #115825. Kube-proxy will now include the `healthz` state in its response to the LB HC as to avoid indicating to the LB that it should use the node in question when Kube-proxy is not healthy. ([#111661](https://github.com/kubernetes/kubernetes/pull/111661), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu)) [SIG Network]
- Flag `--concurrent-node-syncs` has been added to cloud node controller which defines how many workers in parallel will be initialising and synchronising nodes. ([#113104](https://github.com/kubernetes/kubernetes/pull/113104), [@pawbana](https://github.com/pawbana)) [SIG API Machinery, Cloud Provider and Scalability]
- Force deleted pods may fail to terminate until the kubelet is restarted when the container runtime returns an error during termination. We have strengthened testing for runtime failures and now perform a more rigorous reconciliation to ensure static pods (especially those that use fixed UIDs) are restarted.  As a side effect of these changes static pods will be restarted with lower latency than before (2s vs 4s, on average) and rapid updates to pod configuration should take effect sooner.
  
  A new metric `kubelet_known_pods` has been added at ALPHA stability to report the number of pods a Kubelet is tracking in a number of internal states.  Operators may use the metrics to track an excess of pods in the orphaned state that may not be completing. ([#113145](https://github.com/kubernetes/kubernetes/pull/113145), [@smarterclayton](https://github.com/smarterclayton)) [SIG API Machinery, Auth, Cloud Provider, Node and Testing]
- From now on, the HPA controller will return an error for the container resource metrics when the feature gate `HPAContainerMetrics` is disabled. As a result, HPA with a container resource metric performs no scale-down and performs only. ([#116043](https://github.com/kubernetes/kubernetes/pull/116043), [@sanposhiho](https://github.com/sanposhiho))
- IPVS: Any ipvs scheduler can now be configured. If a un-usable scheduler is configured `kube-proxy` will re-start and the logs must be checked (same as before but different log printouts). ([#114878](https://github.com/kubernetes/kubernetes/pull/114878), [@uablrek](https://github.com/uablrek))
- If a user attempts to add an ephemeral container to a static pod, they will now get a visible validation error. ([#114086](https://github.com/kubernetes/kubernetes/pull/114086), [@xmcqueen](https://github.com/xmcqueen))
- Ingress with `ingressClass` annotation and `IngressClassName` both set can be created now. ([#115447](https://github.com/kubernetes/kubernetes/pull/115447), [@AxeZhan](https://github.com/AxeZhan))
- Kube-apiserver: errors decoding objects in etcd are now recorded in an `apiserver_storage_decode_errors_total` counter metric ([#114376](https://github.com/kubernetes/kubernetes/pull/114376), [@baomingwang](https://github.com/baomingwang)) [SIG API Machinery and Instrumentation]
- Kube-apiserver: regular expressions specified with the `--cors-allowed-origins` option are now validated to match the entire `hostname` inside the `Origin` header of the request and 
  must contain '^' or the '//' prefix to anchor to the start, and '$' or the port separator ':' to anchor to 
  the end. ([#112809](https://github.com/kubernetes/kubernetes/pull/112809), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Kube-apiserver: removed N^2 behavior loading webhook configurations. ([#114794](https://github.com/kubernetes/kubernetes/pull/114794), [@lavalamp](https://github.com/lavalamp)) [SIG API Machinery, Architecture, CLI, Cloud Provider and Node]
- Kubeadm: fixed an etcd learner-mode bug by preparing an etcd static pod manifest before promoting ([#115038](https://github.com/kubernetes/kubernetes/pull/115038), [@tobiasgiese](https://github.com/tobiasgiese))
- Kubeadm: fixed the bug where `kubeadm` always does CRI detection even if it is not required by a phase subcommand ([#114455](https://github.com/kubernetes/kubernetes/pull/114455), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: improved retries when updating node information, in case `kube-apiserver` is temporarily unavailable ([#114176](https://github.com/kubernetes/kubernetes/pull/114176), [@QuantumEnergyE](https://github.com/QuantumEnergyE))
- Kubeadm`: modified `--config` flag from required to optional for `kubeadm kubeconfig user` command ([#116074](https://github.com/kubernetes/kubernetes/pull/116074), [@SataQiu](https://github.com/SataQiu))
- Kubectl: enabled usage of label selector for filtering out resources when pruning for kubectl diff ([#114863](https://github.com/kubernetes/kubernetes/pull/114863), [@danlenar](https://github.com/danlenar))
- Kubelet startup now fails CRI connection if service or image endpoint is throwing any error ([#115102](https://github.com/kubernetes/kubernetes/pull/115102), [@saschagrunert](https://github.com/saschagrunert))
- Kubelet: fix recording issue when pulling image did finish ([#114904](https://github.com/kubernetes/kubernetes/pull/114904), [@TommyStarK](https://github.com/TommyStarK)) [SIG Node]
- Kubelet`: fixed a bug in `kubelet` that stopped rendering the `ConfigMaps` when `fsquota` monitoring is enabled ([#112624](https://github.com/kubernetes/kubernetes/pull/112624), [@pacoxu](https://github.com/pacoxu))
- Messages of `DisruptionTarget` condition now excludes preemptor pod metadata ([#114914](https://github.com/kubernetes/kubernetes/pull/114914), [@mimowo](https://github.com/mimowo))
- Optimized `LoadBalancer` creation with the help of attribute Internal Traffic Policy: `Local` ([#114407](https://github.com/kubernetes/kubernetes/pull/114407), [@princepereira](https://github.com/princepereira))
- PVCs will automatically be recreated if they are missing for a pending Pod. ([#113270](https://github.com/kubernetes/kubernetes/pull/113270), [@rrangith](https://github.com/rrangith)) [SIG Apps and Testing]
- PersistentVolume API objects which set NodeAffinities using beta Kubernetes labels for OS, architecture, zone, region, and instance type may now be modified to use the stable Kubernetes labels. ([#115391](https://github.com/kubernetes/kubernetes/pull/115391), [@haoruan](https://github.com/haoruan))
- Potentially breaking change - Updating the polling interval for Windows stats collection from 1 second to 10 seconds ([#116546](https://github.com/kubernetes/kubernetes/pull/116546), [@marosset](https://github.com/marosset)) [SIG Node and Windows]
- Relaxed API validation for usage `key encipherment` and `kubelet` uses requested usages accordingly ([#111660](https://github.com/kubernetes/kubernetes/pull/111660), [@pacoxu](https://github.com/pacoxu))
- Removed scheduler names from preemption event messages. ([#114980](https://github.com/kubernetes/kubernetes/pull/114980), [@mimowo](https://github.com/mimowo))
- Shared informers now correctly propagate whether they are synced or not. Individual informer handlers may now check if they are synced or not (new `HasSynced` method). Library support is added to assist controllers in tracking whether their own work is completed for items in the initial list (`AsyncTracker`). ([#113985](https://github.com/kubernetes/kubernetes/pull/113985), [@lavalamp](https://github.com/lavalamp))
- The Kubernetes API server now correctly detects and closes existing TLS connections when its client certificate file for kubelet authentication has been rotated. ([#115315](https://github.com/kubernetes/kubernetes/pull/115315), [@enj](https://github.com/enj)) [SIG API Machinery, Auth, Node and Testing]
- Total test spec is now available by `ProgressReporter`, it will be reported before test suite got executed. ([#114417](https://github.com/kubernetes/kubernetes/pull/114417), [@chendave](https://github.com/chendave))
- Updated the Event series starting count when emitting isomorphic events from 1 to 2. ([#112334](https://github.com/kubernetes/kubernetes/pull/112334), [@dgrisonnet](https://github.com/dgrisonnet))
- When GCing pods, `kube-controller-manager` will delete Evicted pods first. ([#116167](https://github.com/kubernetes/kubernetes/pull/116167), [@borgerli](https://github.com/borgerli))
- When describing deployments, `OldReplicaSets` now always shows all replicasets controlled the deployment, not just those that still have replicas available. ([#113083](https://github.com/kubernetes/kubernetes/pull/113083), [@llorllale](https://github.com/llorllale)) [SIG CLI]
- Windows CPU usage node stats are now correctly calculated for nodes with multiple Processor Groups. ([#110864](https://github.com/kubernetes/kubernetes/pull/110864), [@claudiubelu](https://github.com/claudiubelu)) [SIG Node, Testing and Windows]
- `LabelSelectors` specified in `topologySpreadConstraints` were validated to ensure that pods are scheduled as expected. Existing pods with invalid `LabelSelectors` could be updated, but new pods were required to specify valid `LabelSelectors`. ([#111802](https://github.com/kubernetes/kubernetes/pull/111802), [@maaoBit](https://github.com/maaoBit))
- `PodGC` for pods which are in terminal phase now do not add the `DisruptionTarget` condition. ([#115056](https://github.com/kubernetes/kubernetes/pull/115056), [@mimowo](https://github.com/mimowo))
- `Service` of type `ExternalName` do not create an `Endpoint` anymore. ([#114814](https://github.com/kubernetes/kubernetes/pull/114814), [@panslava](https://github.com/panslava))
- `cacher`: If `ResourceVersion` is unset, the watch is now served from the underlying storage as documented. ([#115096](https://github.com/kubernetes/kubernetes/pull/115096), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- `client-go`: fixed the wait time for trying to acquire the leader lease ([#114872](https://github.com/kubernetes/kubernetes/pull/114872), [@Iceber](https://github.com/Iceber))
- `etcd`: Updated to `v3.5.7` ([#115310](https://github.com/kubernetes/kubernetes/pull/115310), [@mzaian](https://github.com/mzaian))
- `golang.org/x/net` updated to `v0.7.0` to fix CVE-2022-41723 ([#115786](https://github.com/kubernetes/kubernetes/pull/115786), [@liggitt](https://github.com/liggitt))
- `kube-controller-manager` will not run nodeipam controller when allocator type
  is `CloudAllocator` and the cloud provider is not enabled. ([#114596](https://github.com/kubernetes/kubernetes/pull/114596), [@andrewsykim](https://github.com/andrewsykim))
- `kube-controller-manager`: fixed a bug that the `kubeconfig` field of `kubecontrollermanager.config.k8s.io` configuration is not populated correctly ([#116219](https://github.com/kubernetes/kubernetes/pull/116219), [@SataQiu](https://github.com/SataQiu))
- `kube-proxy` with `--proxy-mode=ipvs` can be used with statically linked kernels.
  The reseved IPv4 range `TEST-NET-2` in `rfc5737` MUST NOT be used for `ClusterIP` or `loadBalancerIP` since address `198.51.100.0` is used for probing. ([#114669](https://github.com/kubernetes/kubernetes/pull/114669), [@uablrek](https://github.com/uablrek))
- `kubeadm`: fixed a bug where the uploaded kubelet configuration in `kube-system/kubelet-config` `ConfigMap` does not respect user patch ([#115575](https://github.com/kubernetes/kubernetes/pull/115575), [@SataQiu](https://github.com/SataQiu))
- `kubeadm`: now respects user provided `kubeconfig` during discovery process ([#113998](https://github.com/kubernetes/kubernetes/pull/113998), [@SataQiu](https://github.com/SataQiu))
- `kubectl port-forward` now exits with exit code 1 when remote connection is
  lost ([#114460](https://github.com/kubernetes/kubernetes/pull/114460), [@brianpursley](https://github.com/brianpursley))
- `nodeName` being set along with non-empty `schedulingGates` is now enforced. ([#115569](https://github.com/kubernetes/kubernetes/pull/115569), [@Huang-Wei](https://github.com/Huang-Wei))
- `node_stage_path` is now set whenever available for expansion during mount ([#115346](https://github.com/kubernetes/kubernetes/pull/115346), [@gnufied](https://github.com/gnufied))
- `statefulset` status will now be consistent on API errors ([#113834](https://github.com/kubernetes/kubernetes/pull/113834), [@atiratree](https://github.com/atiratree))
- `tryUnmount` now respects `mounter.withSafeNotMountedBehavior` ([#114736](https://github.com/kubernetes/kubernetes/pull/114736), [@andyzhangx](https://github.com/andyzhangx))
- The encryption response from KMS v2 plugins is now validated earlier at DEK generation time instead of waiting until an encryption is performed. ([#116877](https://github.com/kubernetes/kubernetes/pull/116877), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- Recreate DaemonSet pods completed with Succeeded phase ([#117073](https://github.com/kubernetes/kubernetes/pull/117073), [@mimowo](https://github.com/mimowo)) [SIG Apps and Testing]


### Other (Cleanup or Flake)

- Added basic Denial Of Service prevention for the the node-local kubelet `podresource` API ([#116459](https://github.com/kubernetes/kubernetes/pull/116459), [@ffromani](https://github.com/ffromani)) [SIG Node and Testing]
- Callers of `wait.ExponentialBackoffWithContext` now must pass a `ConditionWithContextFunc` to be consistent with the signature and avoid creating a duplicate context. If your condition does not need a context you can use the `ConditionFunc.WithContext()` helper to ignore the context, or use `ExponentialBackoff` directly. ([#115113](https://github.com/kubernetes/kubernetes/pull/115113), [@smarterclayton](https://github.com/smarterclayton))
- Changed docs for `--contention-profiling` flag to reflect it performed block profiling ([#114490](https://github.com/kubernetes/kubernetes/pull/114490), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- E2e framework: added `--report-complete-ginkgo` and `--report-complete-junit` parameters. They work like `ginkgo --json-report <report dir>/ginkgo/report.json --junit-report <report dir>/ginkgo/report.xml`. ([#115678](https://github.com/kubernetes/kubernetes/pull/115678), [@pohly](https://github.com/pohly)) [SIG Testing]
- Fixed incorrect log information in the `iptables` utility. ([#110723](https://github.com/kubernetes/kubernetes/pull/110723), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Improved FormatMap: Improves performance by about 4x, or nearly 2x in the worst case ([#112661](https://github.com/kubernetes/kubernetes/pull/112661), [@aimuz](https://github.com/aimuz)) [SIG Node]
- Improved misleading message, in case of no metrics received for the `HPA` controlled pods. ([#114740](https://github.com/kubernetes/kubernetes/pull/114740), [@kushagra98](https://github.com/kushagra98))
- Introduced new metrics removing the redundant subsystem in kube-apiserver pod logs metrics and deprecate the original ones:
  - kube_apiserver_pod_logs_pods_logs_backend_tls_failure_total becomes kube_apiserver_pod_logs_backend_tls_failure_total
  - kube_apiserver_pod_logs_pods_logs_insecure_backend_total becomes kube_apiserver_pod_logs_insecure_backend_total ([#114497](https://github.com/kubernetes/kubernetes/pull/114497), [@dgrisonnet](https://github.com/dgrisonnet))
- Kubeadm: removed the deprecated `v1beta2` API. kubeadm 1.26's `config migrate`
  command can be used to migrate a `v1beta2` configuration file to `v1beta3` ([#114540](https://github.com/kubernetes/kubernetes/pull/114540), [@pacoxu](https://github.com/pacoxu))
- Kubelet: remove deprecated flag `--container-runtime` ([#114017](https://github.com/kubernetes/kubernetes/pull/114017), [@calvin0327](https://github.com/calvin0327)) [SIG Cloud Provider and Node]
- Kubelet: the deprecated `--master-service-namespace` flag is removed in v1.27 ([#116015](https://github.com/kubernetes/kubernetes/pull/116015), [@SataQiu](https://github.com/SataQiu))
- Linux/arm will not ship in Kubernetes 1.27 as we are running into issues with building artifacts using golang 1.20.2 (please see issue #116492) ([#115742](https://github.com/kubernetes/kubernetes/pull/115742), [@dims](https://github.com/dims)) [SIG Architecture, Release and Testing]
- Migrated `pkg/controller/nodeipam/ipam/cloud_cidr_allocator.go, pkg/controller/nodeipam/ipam/multi_cidr_range_allocator.go pkg/controller/nodeipam/ipam/range_allocator.go pkg/controller/nodelifecycle/node_lifecycle_controller.go` to structured logging ([#112670](https://github.com/kubernetes/kubernetes/pull/112670), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Migrated the Kubernetes object garbage collector (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113471](https://github.com/kubernetes/kubernetes/pull/113471), [@ncdc](https://github.com/ncdc))
- Migrated the ttlafterfinished controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#115332](https://github.com/kubernetes/kubernetes/pull/115332), [@obaranov1](https://github.com/obaranov1)) [SIG Apps]
- Migrated the “sample-controller” controller to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113879](https://github.com/kubernetes/kubernetes/pull/113879), [@pchan](https://github.com/pchan)) [SIG API Machinery and Instrumentation]
- Promoted pod resource `limit/request` metrics to stable. ([#115454](https://github.com/kubernetes/kubernetes/pull/115454), [@dgrisonnet](https://github.com/dgrisonnet))
- Removed AWS kubelet credential provider. Please use the external kubelet credential provider binary named `ecr-credential-provider` instead. ([#116329](https://github.com/kubernetes/kubernetes/pull/116329), [@dims](https://github.com/dims)) [SIG Node, Storage and Testing]
- Removed Azure disk in-tree storage plugin ([#116301](https://github.com/kubernetes/kubernetes/pull/116301), [@andyzhangx](https://github.com/andyzhangx))
- Removed flag `master-service-namespace` from `api-server` arguments ([#114446](https://github.com/kubernetes/kubernetes/pull/114446), [@lengrongfu](https://github.com/lengrongfu))
- Removed the following deprecated metrics:
  - node_collector_evictions_number replaced by node_collector_evictions_total
  - scheduler_e2e_scheduling_duration_seconds replaced by scheduler_scheduling_attempt_duration_seconds ([#115209](https://github.com/kubernetes/kubernetes/pull/115209), [@dgrisonnet](https://github.com/dgrisonnet))
- Removed unused rule for `nodes/spec` from `ClusterRole` `system:kubelet-api-admin` ([#113267](https://github.com/kubernetes/kubernetes/pull/113267), [@hoskeri](https://github.com/hoskeri))
- Renamed API server identity Lease labels to use the key `apiserver.kubernetes.io/identity` ([#114586](https://github.com/kubernetes/kubernetes/pull/114586), [@andrewsykim](https://github.com/andrewsykim)) [SIG API Machinery, Apps, Cloud Provider and Testing]
- Storage.k8s.io/v1beta1 API version of CSIStorageCapacity will no longer be served ([#116523](https://github.com/kubernetes/kubernetes/pull/116523), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery]
- The `CSIMigrationAzureFile` feature gate (for the feature which graduated to GA in v1.26) is now unconditionally enabled and will be removed in v1.28. ([#114953](https://github.com/kubernetes/kubernetes/pull/114953), [@enj](https://github.com/enj))
- The `ControllerManagerLeaderMigration` feature, GA since `1.24`, is now unconditionally enabled and the feature gate option has been removed. ([#113534](https://github.com/kubernetes/kubernetes/pull/113534), [@pacoxu](https://github.com/pacoxu))
- The `WaitFor` and `WaitForWithContext` functions in the wait package have now been marked private. Callers should use the equivalent `Poll*` method with a zero duration interval. ([#115116](https://github.com/kubernetes/kubernetes/pull/115116), [@smarterclayton](https://github.com/smarterclayton))
- The `wait.Poll*` and `wait.ExponentialBackoff*` functions have been deprecated and will be removed in a future release.  Callers should switch to using `wait.PollUntilContextCancel`, `wait.PollUntilContextTimeout`, or `wait.ExponentialBackoffWithContext` as appropriate.
  
  `PollWithContext(Cancel|Deadline)` will no longer return `ErrWaitTimeout` - use the `Interrupted(error) bool` helper to replace checks for `err == ErrWaitTimeout`, or compare specifically to context errors as needed. A future release will make the `ErrWaitTimeout` error private and callers must use `Interrupted()` instead. If you are returning `ErrWaitTimeout` from your own methods, switch to creating a location specific `cause err` and pass it to the new method `wait.ErrorInterrupted(cause) error` which will ensure `Interrupted()` returns true for your loop. 
  
  The `wait.NewExponentialBackoffManager` and `wait.NewJitteringBackoffManager` functions have been marked as deprecated.  Callers should switch to using the `Backoff{...}.DelayWithReset(clock, resetInterval)` method and must set the `Steps` field when using `Factor`. As a short term change, callers may use the `Timer()` method on the `BackoffManager` until the backoff managers are deprecated and removed. Please see the godoc of the deprecated functions for examples of how to replace usage of this function. ([#107826](https://github.com/kubernetes/kubernetes/pull/107826), [@smarterclayton](https://github.com/smarterclayton)) [SIG API Machinery, Auth, Cloud Provider, Storage and Testing]
- The feature gates `CSIInlineVolume`, `CSIMigration`, `DaemonSetUpdateSurge`, `EphemeralContainers`, `IdentifyPodOS`, `LocalStorageCapacityIsolation`, `NetworkPolicyEndPort` and `StatefulSetMinReadySeconds` that graduated to GA in v1.25 and were unconditionally enabled have been removed in v1.27 ([#114410](https://github.com/kubernetes/kubernetes/pull/114410), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- Upgraded `coredns` to `v1.10.1` ([#115603](https://github.com/kubernetes/kubernetes/pull/115603), [@pacoxu](https://github.com/pacoxu))
- Upgraded `go-jose` to `v2.6.0` ([#115893](https://github.com/kubernetes/kubernetes/pull/115893), [@mgoltzsche](https://github.com/mgoltzsche))
- [KCCM - service controller]: enabled connection draining for terminating pods upon node downscale by the cluster autoscaler. This is done by not reacting to the taint used by the cluster autoscaler to indicate that the node is going away soon, thus keeping the node referenced by the load balancer until the VM has been completely deleted. ([#115204](https://github.com/kubernetes/kubernetes/pull/115204), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- `apiserver_admission_webhook_admission_duration_seconds` buckets have been expanded, 25s is now the largest bucket size to match the webhook default timeout. ([#115802](https://github.com/kubernetes/kubernetes/pull/115802), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery and Instrumentation]
- `wait.ContextForChannel()` now implements the context.Context interface and
  does not return a cancellation function. ([#115140](https://github.com/kubernetes/kubernetes/pull/115140), [@smarterclayton](https://github.com/smarterclayton))