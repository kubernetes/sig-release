## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- CephFS volume plugin (`kubernetes.io/cephfs`) has been deprecated in this release and will be removed in a subsequent release. The alternative is to use the CephFS CSI driver (https://github.com/ceph/ceph-csi/) in your Kubernetes cluster. ([#118143](https://github.com/kubernetes/kubernetes/pull/118143), [@humblec](https://github.com/humblec))
 
## Changes by Kind

### Deprecation

- Kube-controller-manager deprecate `--volume-host-cidr-denylist` and `--volume-host-allow-local-loopback` flags. ([#118128](https://github.com/kubernetes/kubernetes/pull/118128), [@carlory](https://github.com/carlory)) [SIG API Machinery, Apps, Network, Node, Storage and Testing]
- Kubelet: The `--azure-container-registry-config` flag has been deprecated and will be removed in a future release, please use `--image-credential-provider-config` and `--image-credential-provider-bin-dir` to setup acr credential provider instead. ([#118596](https://github.com/kubernetes/kubernetes/pull/118596), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- Remove tracking annotation from validation and defaulting. ([#117633](https://github.com/kubernetes/kubernetes/pull/117633), [@kannon92](https://github.com/kannon92))
- Removed withdrawn feature `NetworkPolicyStatus`. ([#115843](https://github.com/kubernetes/kubernetes/pull/115843), [@rikatz](https://github.com/rikatz))

### API Change

- ACTION_REQUIRED
  When an Indexed Job has a number of completions higher than 10^5 and parallelism higher than 10^4, and a big number of Indexes fail, Kubernetes might not be able to track the termination of the Job. Kubernetes now emits a warning, at Job creation, when the Job manifest exceeds both of these limits. ([#118420](https://github.com/kubernetes/kubernetes/pull/118420), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- Added a warning that TLS 1.3 ciphers are not configurable. ([#115399](https://github.com/kubernetes/kubernetes/pull/115399), [@3u13r](https://github.com/3u13r)) [SIG API Machinery and Node]
- Added error handling for seccomp localhost configurations that do not properly set a `localhostProfile`. ([#117020](https://github.com/kubernetes/kubernetes/pull/117020), [@cji](https://github.com/cji))
- Added new config option `delayCacheUntilActive` to `KubeSchedulerConfiguration` that can provide a tradeoff between memory efficiency and scheduling speed when their leadership is updated in `kube-scheduler` ([#115754](https://github.com/kubernetes/kubernetes/pull/115754), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery and Scheduling]
- Exposed `rest.DefaultServerUrlFor` function ([#118055](https://github.com/kubernetes/kubernetes/pull/118055), [@timofurrer](https://github.com/timofurrer))
- If using cgroups v2, then the cgroup aware OOM killer will be enabled for container cgroups via  `memory.oom.group` .  This causes processes within the cgroup to be treated as a unit and killed simultaneously in the event of an OOM kill on any process in the cgroup. ([#117793](https://github.com/kubernetes/kubernetes/pull/117793), [@tzneal](https://github.com/tzneal)) [SIG Apps, Node and Testing]
- NodeVolumeLimits implement the PreFilter extension point for skipping the Filter phase if the Pod doesn't use volumes with limits. ([#115398](https://github.com/kubernetes/kubernetes/pull/115398), [@tangwz](https://github.com/tangwz)) [SIG Scheduling]
- Pods which set `hostNetwork: true` and declare ports get the `hostPort` field set automatically.  Previously this would happen in the PodTemplate of a Deployment, DaemonSet or other workload API.  Now `hostPort` will only be set when an actual Pod is being created.  If this presents a problem, setting the feature gate "DefaultHostNetworkHostPortsInWorkloads" to true will revert this behavior.  Please file a kubernetes bug if you need to do this. ([#117696](https://github.com/kubernetes/kubernetes/pull/117696), [@thockin](https://github.com/thockin)) [SIG Apps]
- Removing WindowsHostProcessContainers feature-gate ([#117570](https://github.com/kubernetes/kubernetes/pull/117570), [@marosset](https://github.com/marosset)) [SIG API Machinery, Apps, Auth, Node and Windows]
- Revised the comment about the feature-gate level for PodFailurePolicy from alpha to beta ([#117802](https://github.com/kubernetes/kubernetes/pull/117802), [@kerthcet](https://github.com/kerthcet)) [SIG API Machinery and Apps]
- The `SelfSubjectReview` API is promoted to `authentication.k8s.io/v1` and the `kubectl auth whoami` command is GA. ([#117713](https://github.com/kubernetes/kubernetes/pull/117713), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Architecture, Auth, CLI and Testing]
- Updated the comment about the feature-gate level for `PodFailurePolicy` from alpha to beta ([#118278](https://github.com/kubernetes/kubernetes/pull/118278), [@mimowo](https://github.com/mimowo))
- `client-go`: Improved memory use of reflector caches when watching large numbers
  of objects which do not change frequently. ([#113362](https://github.com/kubernetes/kubernetes/pull/113362), [@sxllwx](https://github.com/sxllwx))
- `kube-controller-manager`: The `LegacyServiceAccountTokenCleanUp` feature gate
  is now available as alpha (off by default). When enabled, the `legacy-service-account-token-cleaner`
  controller loop removes service account token secrets that have not been used
  in the time specified by `--legacy-service-account-token-clean-up-period` (defaulting
  to one year), **and are** referenced from the `.secrets` list of a ServiceAccount
  object, **and are not** referenced from pods. ([#115554](https://github.com/kubernetes/kubernetes/pull/115554), [@yt2985](https://github.com/yt2985))
- `kube-scheduler` component config (KubeSchedulerConfiguration) `kubescheduler.config.k8s.io/v1beta2`
  is removed in `v1.28`. Migrate `kube-scheduler` configuration files to `kubescheduler.config.k8s.io/v1`. ([#117649](https://github.com/kubernetes/kubernetes/pull/117649), [@SataQiu](https://github.com/SataQiu))

### Feature

- Added '--concurrent-cron-job-syncs' flag for kube-controller-manager to set the number of workers for cron job controller ([#117550](https://github.com/kubernetes/kubernetes/pull/117550), [@borgerli](https://github.com/borgerli))
- Added '--concurrent-job-syncs' flag for `kube-controller-manager` to set the number of job controller workers. ([#117138](https://github.com/kubernetes/kubernetes/pull/117138), [@tosi3k](https://github.com/tosi3k))
- Added `DisruptionTarget` condition to the pod preempted by kubelet to make room for a critical pod. ([#117586](https://github.com/kubernetes/kubernetes/pull/117586), [@mimowo](https://github.com/mimowo))
- Added a container image for `kubectl` at `registry.k8s.io/kubectl` across the same architectures as other images (linux/amd64 linux/arm64 linux/s390x linux/ppc64le) ([#116672](https://github.com/kubernetes/kubernetes/pull/116672), [@dims](https://github.com/dims)) [SIG Architecture and Release]
- Added support for pod `hostNetwork` field selector ([#110477](https://github.com/kubernetes/kubernetes/pull/110477), [@halfcrazy](https://github.com/halfcrazy)) [SIG Apps and Node]
- Apiserver adds two new metrics `etcd_requests_total` and `etcd_request_errors_total` that allow users to monitor requests to etcd storage, split by operation and resource type. ([#117222](https://github.com/kubernetes/kubernetes/pull/117222), [@iyear](https://github.com/iyear)) [SIG API Machinery]
- Bumped metrics-server to `v0.6.3`. ([#117120](https://github.com/kubernetes/kubernetes/pull/117120), [@dgrisonnet](https://github.com/dgrisonnet))
- Client-go now exposes two new metrics to monitor the client-go logic that
  generate http.Transports for the clients.
  
  - `rest_client_transport_cache_entries` is a gauge metric
  with the number of existin entries in the internal cache
  
  - `rest_client_transport_create_calls_total` is a counter
  that increments each time a new transport is created, storing
  the result of the operation needed to generate it: hit, miss
  or uncacheable. ([#117295](https://github.com/kubernetes/kubernetes/pull/117295), [@aojea](https://github.com/aojea))
- Client-go: make generated CA certificates valid 1 hour in the past (NewSelfSignedCACert). Applies to CA certificates and other certificates generated by kubeadm. ([#118631](https://github.com/kubernetes/kubernetes/pull/118631), [@champtar](https://github.com/champtar)) [SIG Auth]
- External credential provider plugins will now have their standard error output logged by kubelet upon failures. ([#117448](https://github.com/kubernetes/kubernetes/pull/117448), [@cartermckinnon](https://github.com/cartermckinnon))
- Fixed the alpha `CloudDualStackNodeIPs` feature. ([#118329](https://github.com/kubernetes/kubernetes/pull/118329), [@danwinship](https://github.com/danwinship))
- Graduated the `LegacyServiceAccountTokenTracking` feature gate to GA. The usage of auto-generated secret-based service account token now produces warnings, and relevant Secrets are labeled with a last-used timestamp (label key `kubernetes.io/legacy-token-last-used`). ([#117591](https://github.com/kubernetes/kubernetes/pull/117591), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth and Testing]
- Introduce support for CEL optionals (see [CEL spec proposal 246](https://github.com/google/cel-spec/wiki/proposal-246)).
  This feature will not be fully enabled until a future Kubernetes release (likely to be v1.29), but is added in v1.28 to enable
  safe rollback on downgrade. ([#118339](https://github.com/kubernetes/kubernetes/pull/118339), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth, Cloud Provider and Testing]
- Kube-proxy handles Terminating EndpointSlices conditions and enables zero downtime deployments for Services with ExternalTrafficPolicy=Local author: @andrewsykim ([#117718](https://github.com/kubernetes/kubernetes/pull/117718), [@aojea](https://github.com/aojea)) [SIG Network, Testing and Windows]
- Kubelet: un-deprecate `--provider-id` flag ([#116530](https://github.com/kubernetes/kubernetes/pull/116530), [@pacoxu](https://github.com/pacoxu))
- Kubernetes is now built with Go 1.20.4 ([#117744](https://github.com/kubernetes/kubernetes/pull/117744), [@xmudrii](https://github.com/xmudrii)) [SIG Release and Testing]
- Kubernetes is now built with Go `1.20.5` ([#118507](https://github.com/kubernetes/kubernetes/pull/118507), [@jeremyrickard](https://github.com/jeremyrickard))
- Metric `scheduler_scheduler_goroutines` is removed. Use `scheduler_goroutines` instead. ([#117727](https://github.com/kubernetes/kubernetes/pull/117727), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Migrated `pkg/scheduler/framework/preemption` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116835](https://github.com/kubernetes/kubernetes/pull/116835), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated `pod-security-admission` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#114471](https://github.com/kubernetes/kubernetes/pull/114471), [@Namanl2001](https://github.com/Namanl2001)) [SIG Apps and Auth]
- Migrated the Job controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116910](https://github.com/kubernetes/kubernetes/pull/116910), [@fatsheep9146](https://github.com/fatsheep9146)) [SIG API Machinery, Apps and Testing]
- Migrated the noderesources scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116748](https://github.com/kubernetes/kubernetes/pull/116748), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated the podtopologyspread scheduler plugins to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116797](https://github.com/kubernetes/kubernetes/pull/116797), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Promoted `ServiceNodePortStaticSubrange` feature gate to beta, and it will be enabled by default. ([#117877](https://github.com/kubernetes/kubernetes/pull/117877), [@xuzhenglun](https://github.com/xuzhenglun))
- Rename PodHasNetwork to PodReadyToStartContainers ([#117702](https://github.com/kubernetes/kubernetes/pull/117702), [@kannon92](https://github.com/kannon92)) [SIG Node and Testing]
- Set metrics-server's metric-resolution to 15s ([#117121](https://github.com/kubernetes/kubernetes/pull/117121), [@dgrisonnet](https://github.com/dgrisonnet)) [SIG Cloud Provider and Instrumentation]
- SubjectAccessReview requests sent to webhook authorizers now default `spec.resourceAttributes.version` to `*` if unset. ([#116937](https://github.com/kubernetes/kubernetes/pull/116937), [@AxeZhan](https://github.com/AxeZhan)) [SIG Apps and Auth]
- Supported specifying a custom retry period for cloud `load-balancer` operations ([#94021](https://github.com/kubernetes/kubernetes/pull/94021), [@timoreimann](https://github.com/timoreimann))
- The Kubernetes apiserver now emits a warning message for Pods with a null labelSelector in podAffinity or topologySpreadConstraints. The null labelSelector means "match none". Using it in podAffinity or topologySpreadConstraint could lead to unintended behavior. ([#117025](https://github.com/kubernetes/kubernetes/pull/117025), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- The `ExpandedDNSConfig` feature has graduated to GA. 'ExpandedDNSConfig' feature was locked to default value and will be removed in v1.30. If you were setting this feature gate explicitly, please remove it now. ([#116741](https://github.com/kubernetes/kubernetes/pull/116741), [@gjkim42](https://github.com/gjkim42)) [SIG Apps, Network and Node]
- The helping message of commands which have sub-commands is now clearer and more instructive. It will show the full command instead of `kubectl <command> --help ...`
  
  Changed `kubectl create secret --help` description. There will be a short introduction to the three secret types and clearer guidance on how to use the command. ([#117930](https://github.com/kubernetes/kubernetes/pull/117930), [@LronDC](https://github.com/LronDC))
- The scheduler skips the InterPodAffinity Score plugin when nothing to do with the Pod.
  It will affect some metrics values related to the InterPodAffinity Score plugin. ([#117794](https://github.com/kubernetes/kubernetes/pull/117794), [@utam0k](https://github.com/utam0k)) [SIG Scheduling]
- The scheduler skips the `PodTopologySpread` Filter plugin if no spread constraints.
  It will affect some metrics values related to the `PodTopologySpread` Filter plugin. ([#117683](https://github.com/kubernetes/kubernetes/pull/117683), [@utam0k](https://github.com/utam0k))
- The short names `vwc` and `mwc` were introduced for the resources `validatingwebhookconfigurations` and `mutatingwebhookconfigurations`. ([#117535](https://github.com/kubernetes/kubernetes/pull/117535), [@hysyeah](https://github.com/hysyeah))
- Update etcd image to 3.5.9-0 ([#117999](https://github.com/kubernetes/kubernetes/pull/117999), [@kkkkun](https://github.com/kkkkun)) [SIG API Machinery]
- Updated distroless I-tables to use registry.k8s.io/build-image/distroless-iptables:v0.2.5 ([#118541](https://github.com/kubernetes/kubernetes/pull/118541), [@jeremyrickard](https://github.com/jeremyrickard)) [SIG Testing]
- Updated distroless iptables to use released image `registry.k8s.io/build-image/distroless-iptables:v0.2.4` ([#117746](https://github.com/kubernetes/kubernetes/pull/117746), [@xmudrii](https://github.com/xmudrii)) [SIG Testing]
- Updated the scheduler interface and cache methods to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116849](https://github.com/kubernetes/kubernetes/pull/116849), [@mengjiao-liu](https://github.com/mengjiao-liu))
- `--version=v1.X.Y...` can now be used to set the prerelease and buildID portions of the version reported by components ([#117688](https://github.com/kubernetes/kubernetes/pull/117688), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Architecture and Release]
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

### Documentation

- Enhanced clarity in error messaging when waiting for volume creation ([#118262](https://github.com/kubernetes/kubernetes/pull/118262), [@torredil](https://github.com/torredil)) [SIG Apps and Storage]

### Failing Test

- Allowed Azure Disk e2es to use newer topology labels if available from nodes. ([#117216](https://github.com/kubernetes/kubernetes/pull/117216), [@gnufied](https://github.com/gnufied))
- Fixed nil pointer in test AfterEach volumeperf.go for sidecar release. ([#117368](https://github.com/kubernetes/kubernetes/pull/117368), [@sunnylovestiramisu](https://github.com/sunnylovestiramisu))

### Bug or Regression

- Added additional validation for endpoint IP configuration while iterating through queried endpoint list. ([#116749](https://github.com/kubernetes/kubernetes/pull/116749), [@princepereira](https://github.com/princepereira))
- CI job `ci-kubernetes-node-arm64-ubuntu-serial` will test node e2e on arm64, `use-dockerized-build` and `target-build-arch` are required to run this job. ([#118567](https://github.com/kubernetes/kubernetes/pull/118567), [@chendave](https://github.com/chendave))
- CVE-2023-27561 CVE-2023-25809 CVE-2023-28642: Bump fix runc v1.1.4 -> v1.1.5 ([#117095](https://github.com/kubernetes/kubernetes/pull/117095), [@PushkarJ](https://github.com/PushkarJ)) [SIG Architecture, Node and Security]
- Code blocks in `kubectl {$COMMAND}--help` will move right by 3 indentation. ([#118029](https://github.com/kubernetes/kubernetes/pull/118029), [@ardaguclu](https://github.com/ardaguclu))
- Compute the backoff delay more accurately for deleted pods ([#118413](https://github.com/kubernetes/kubernetes/pull/118413), [@mimowo](https://github.com/mimowo)) [SIG Apps]
- During device plugin allocation, resources requested by the pod can only be allocated if the device plugin has registered itself to kubelet AND healthy devices are present on the node to be allocated. If these conditions are not sattsfied, the pod would fail with `UnexpectedAdmissionError` error. ([#116376](https://github.com/kubernetes/kubernetes/pull/116376), [@swatisehgal](https://github.com/swatisehgal)) [SIG Node and Testing]
- Ensure Job status updates are batched by 1s. This fixes an unlikely scenario when a sequence of immediately 
  completing pods could trigger a sequence of non-batched Job status updates. ([#118470](https://github.com/kubernetes/kubernetes/pull/118470), [@mimowo](https://github.com/mimowo)) [SIG Apps]
- Fix a data race in TopologyCache when `AddHints` and `SetNodes` are called concurrently ([#117249](https://github.com/kubernetes/kubernetes/pull/117249), [@tnqn](https://github.com/tnqn)) [SIG Apps and Network]
- Fix a race condition in `kube-proxy` when using LocalModeNodeCIDR, to avoid dropping Services traffic if the object node is recreated when `kube-proxy` is starting. ([#118499](https://github.com/kubernetes/kubernetes/pull/118499), [@aojea](https://github.com/aojea))
- Fix bug where `listOfStrings.join()` in CEL expressions resulted in an unexpected internal error. ([#117593](https://github.com/kubernetes/kubernetes/pull/117593), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery]
- Fix incorrect calculation for ResourceQuota with PriorityClass as its scope. ([#117677](https://github.com/kubernetes/kubernetes/pull/117677), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG API Machinery]
- Fix: After a Node is down and take some time to get back to up again, the mount point of the evicted Pods cannot be cleaned up successfully. (#111933) Meanwhile Kubelet will print the log `Orphaned pod "xxx" found, but error not a directory occurred when trying to remove the volumes dir` every 2 seconds. (#105536) ([#116134](https://github.com/kubernetes/kubernetes/pull/116134), [@cvvz](https://github.com/cvvz)) [SIG Node and Storage]
- Fix: the volume is not detached after the pod and PVC objects are deleted ([#116138](https://github.com/kubernetes/kubernetes/pull/116138), [@cvvz](https://github.com/cvvz)) [SIG Storage]
- Fixed Cronjob `status.lastSuccessfulTime` not populated by a manually triggered ([#118530](https://github.com/kubernetes/kubernetes/pull/118530), [@carlory](https://github.com/carlory))
- Fixed Topology Aware Hints not working when the `topology.kubernetes.io/zone` label is added after Node creation. ([#117245](https://github.com/kubernetes/kubernetes/pull/117245), [@tnqn](https://github.com/tnqn))
- Fixed `creationTimestamp: null` causing unnecessary writes to etcd. ([#116865](https://github.com/kubernetes/kubernetes/pull/116865), [@alexzielenski](https://github.com/alexzielenski))
- Fixed `vSphere` cloud provider not to skip detach volumes from nodes at `kube-controller-startup`. ([#117243](https://github.com/kubernetes/kubernetes/pull/117243), [@jsafrane](https://github.com/jsafrane))
- Fixed a bug at `kube-apiserver` start where `APIService` objects for custom resources could be deleted and recreated. ([#118104](https://github.com/kubernetes/kubernetes/pull/118104), [@liggitt](https://github.com/liggitt))
- Fixed a bug that unintentionally overrides custom Accept headers in http (live-/readiness)-probes if the header is in lowercase. ([#114606](https://github.com/kubernetes/kubernetes/pull/114606), [@tuunit](https://github.com/tuunit))
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
- Fixed issue where `kubectl-convert` would fail when encountering resources that could not be converted to the specified api version. New behavior is to warn the user of the failed conversions and continue to convert the remaining resources. ([#117002](https://github.com/kubernetes/kubernetes/pull/117002), [@gxwilkerson33](https://github.com/gxwilkerson33))
- Fixed issue where there was no response or error from kubectl rollout status when there were no resources of specified kind. ([#117884](https://github.com/kubernetes/kubernetes/pull/117884), [@gxwilkerson33](https://github.com/gxwilkerson33)) [SIG CLI]
- Fixed performance regression in scheduler caused by frequent metric lookup on critical code path. ([#117594](https://github.com/kubernetes/kubernetes/pull/117594), [@tosi3k](https://github.com/tosi3k))
- Fixed restricted debug profile. ([#117543](https://github.com/kubernetes/kubernetes/pull/117543), [@mochizuki875](https://github.com/mochizuki875))
- Fixed the preStop hook, will block the pod termination grace period ([#115835](https://github.com/kubernetes/kubernetes/pull/115835), [@HirazawaUi](https://github.com/HirazawaUi))
- If `kubeadm reset` finds no etcd member ID for the peer it removes during the `remove-etcd-member` phase, it continues immediately to other phases, instead of retrying the phase for up to 3 minutes before continuing. ([#117724](https://github.com/kubernetes/kubernetes/pull/117724), [@dlipovetsky](https://github.com/dlipovetsky)) [SIG Cluster Lifecycle]
- Improved exponential backoff in Reflector, significantly reducing the load on Kubernetes apiserver in case of throttling of requests. ([#118132](https://github.com/kubernetes/kubernetes/pull/118132), [@marseel](https://github.com/marseel)) [SIG API Machinery and Scalability]
- Known issue: fixed that the PreEnqueue plugins aren't executed for Pods proceeding to activeQ through backoffQ. ([#117194](https://github.com/kubernetes/kubernetes/pull/117194), [@sanposhiho](https://github.com/sanposhiho)) [SIG Release and Scheduling]
- Kubelet terminates pods correctly upon restart, fixing an issue where pods may have not been fully terminated if the kubelet was restarted during pod termination. ([#117019](https://github.com/kubernetes/kubernetes/pull/117019), [@bobbypage](https://github.com/bobbypage)) [SIG Node and Testing]
- Kubelet will now skip pod resource checks when the request is zero. ([#116408](https://github.com/kubernetes/kubernetes/pull/116408), [@ChenLingPeng](https://github.com/ChenLingPeng))
- Number of errors reported to the metric `storage_operation_duration_seconds_count` for emptyDir decreased significantly because previously one error was reported for each projected volume created. ([#117022](https://github.com/kubernetes/kubernetes/pull/117022), [@mpatlasov](https://github.com/mpatlasov)) [SIG Storage]
- Pod termination will be faster when the pod has a missing volume reference. ([#117412](https://github.com/kubernetes/kubernetes/pull/117412), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node and Testing]
- Recording timing traces had a race condition. Impact in practice was probably low. ([#117139](https://github.com/kubernetes/kubernetes/pull/117139), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node and Storage]
- Removed leading zeros from the etcd member ID in kubeadm log messages. ([#117919](https://github.com/kubernetes/kubernetes/pull/117919), [@dlipovetsky](https://github.com/dlipovetsky)) [SIG Cluster Lifecycle]
- Resolves a spurious "Unknown discovery response content-type" error in client-go discovery requests by tolerating extra content-type parameters in API responses ([#117571](https://github.com/kubernetes/kubernetes/pull/117571), [@seans3](https://github.com/seans3)) [SIG API Machinery]
- Reverted NewVolumeManagerReconstruction and SELinuxMountReadWriteOncePod feature gates to disabled by default to resolve a regression of volume reconstruction on kubelet/node restart ([#117751](https://github.com/kubernetes/kubernetes/pull/117751), [@liggitt](https://github.com/liggitt)) [SIG Storage]
- Setting a mirror pod's phase to Succeeded or Failed can prevent the corresponding static pod from restarting due mutation of a Kubelet cache. ([#116482](https://github.com/kubernetes/kubernetes/pull/116482), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Show a warning when `volume.beta.kubernetes.io/storage-class` annotation is used in pv or pvc ([#117036](https://github.com/kubernetes/kubernetes/pull/117036), [@haoruan](https://github.com/haoruan)) [SIG Storage]
- Static pods were taking extra time to be restarted after being updated.  Static pods that are waiting to restart were not correctly counted in `kubelet_working_pods`. ([#116995](https://github.com/kubernetes/kubernetes/pull/116995), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Updated `etcd` version to `3.5.8`. ([#117335](https://github.com/kubernetes/kubernetes/pull/117335), [@kkkkun](https://github.com/kkkkun))
- Updated static pods are restarted 2s faster by correcting a safe but non-optimal ordering bug. ([#116690](https://github.com/kubernetes/kubernetes/pull/116690), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Users will no longer see an error for failed events caused due to terminating namespace. ([#114849](https://github.com/kubernetes/kubernetes/pull/114849), [@padlar](https://github.com/padlar)) [SIG API Machinery]
- [KCCM] service controller: change the cloud controller manager to make `providerID` a predicate when synchronizing nodes. This change allows load balancer integrations to ensure that  the `providerID` is set when configuring
  load balancers and targets. ([#117388](https://github.com/kubernetes/kubernetes/pull/117388), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu)) [SIG Cloud Provider and Network]
- `kube-apiserver` will now always remove its endpoint from Kubernetes service during
  graceful shutdown (even if it's the only/last one). ([#116685](https://github.com/kubernetes/kubernetes/pull/116685), [@czybjtu](https://github.com/czybjtu))
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
- `kubelet` will ensure /etc/hosts file is mode 0644 regardless of umask. ([#113209](https://github.com/kubernetes/kubernetes/pull/113209), [@luozhiwenn](https://github.com/luozhiwenn))
- `kubelet`: print sorted volumes message in events. ([#117079](https://github.com/kubernetes/kubernetes/pull/117079), [@qingwave](https://github.com/qingwave))

### Other (Cleanup or Flake)

- A `v2-level` info log will be added, which will output the details of the pod being preempted, including victim and preemptor ([#117214](https://github.com/kubernetes/kubernetes/pull/117214), [@HirazawaUi](https://github.com/HirazawaUi))
- Allowed container runtimes to use `ErrSignatureValidationFailed` as possible image pull failure. ([#117717](https://github.com/kubernetes/kubernetes/pull/117717), [@saschagrunert](https://github.com/saschagrunert))
- Deprecated `genericclioptions.IOStreams` and used `genericiooptions.IOStreams`. ([#117102](https://github.com/kubernetes/kubernetes/pull/117102), [@ardaguclu](https://github.com/ardaguclu))
- E2e framework: the `node-role.kubernetes.io/master` taint has been removed from the default value of `--non-blocking-taints` flag. You may need to set `--non-blocking-taints` explicitly if the cluster to be tested has nodes with the deprecated `node-role.kubernetes.io/master` taint. ([#118510](https://github.com/kubernetes/kubernetes/pull/118510), [@SataQiu](https://github.com/SataQiu)) [SIG Testing]
- Enabled the `node-local` kubelet podresources API endpoint on windows, alongside unix. ([#115133](https://github.com/kubernetes/kubernetes/pull/115133), [@ffromani](https://github.com/ffromani))
- Fixed dra e2e image build on non-amd64 architectures ([#117912](https://github.com/kubernetes/kubernetes/pull/117912), [@bart0sh](https://github.com/bart0sh)) [SIG Node and Testing]
- Kube-apiserver adds two new alpha metrics `conversion_webhook_request_total` and `conversion_webhook_duration_seconds` that allow users to monitor requests to CRD conversion webhooks, split by result, and failure_type (In case of failure). ([#118292](https://github.com/kubernetes/kubernetes/pull/118292), [@cchapla](https://github.com/cchapla)) [SIG API Machinery, Architecture and Instrumentation]
- Kube-proxy: remove log warning about not using config file ([#118115](https://github.com/kubernetes/kubernetes/pull/118115), [@TommyStarK](https://github.com/TommyStarK)) [SIG Network]
- Make Job controller batching of syncJob invocations enabled unconditionally (it was conditional on JobReadyPods feature before).
  
  Also, Job controller's constants for default backoff and maximal backoff are lowered down to 1s (from 10s) and 1min (from 6min), respectively. These constants are used to determine the backoff delay for the next Job controller sync in case of a request failure. ([#118615](https://github.com/kubernetes/kubernetes/pull/118615), [@mimowo](https://github.com/mimowo)) [SIG Apps and Testing]
- Marked the feature gate `ExperimentalHostUserNamespaceDefaulting` as deprecated.
  Enabling the feature gate already had no effect; the deprecation allows for removing the feature gate in a future release. ([#116723](https://github.com/kubernetes/kubernetes/pull/116723), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Node]
- Migrated `pkg/scheduler/framework/runtime` to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116842](https://github.com/kubernetes/kubernetes/pull/116842), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Migrated the interpodaffinity scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116635](https://github.com/kubernetes/kubernetes/pull/116635), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Migrated the volumezone scheduler plugin to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#116829](https://github.com/kubernetes/kubernetes/pull/116829), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Moved `k8s.io/kubernetes/pkg/kubelet/cri/streaming` package to `k8s.io/kubelet/pkg/cri/streaming`. ([#118253](https://github.com/kubernetes/kubernetes/pull/118253), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node, Release and Security]
- OpenAPI proto deserializations should use gnostic-models instead of the gnostic library ([#118384](https://github.com/kubernetes/kubernetes/pull/118384), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Instrumentation, Node, Storage and Testing]
- Projects which use k8s.io/code-generator and invoke `generate-groups` or `generate-internal-groups.sh` have a new, simpler script (`kube_codegen.sh`) they can use.  The old scripts are deprecated but remain intact. ([#117262](https://github.com/kubernetes/kubernetes/pull/117262), [@thockin](https://github.com/thockin)) [SIG API Machinery and Instrumentation]
- Remove GA'ed feature gate `DelegateFSGroupToCSIDriver`. ([#117655](https://github.com/kubernetes/kubernetes/pull/117655), [@carlory](https://github.com/carlory))
- Remove GA'ed feature gate `DevicePlugins`. ([#117656](https://github.com/kubernetes/kubernetes/pull/117656), [@carlory](https://github.com/carlory))
- Removed GA'ed feature gate `KubeletCredentialProviders`. ([#116901](https://github.com/kubernetes/kubernetes/pull/116901), [@pacoxu](https://github.com/pacoxu))
- Removed GA'ed feature gates: `MixedProtocolLBService`, `ServiceInternalTrafficPolicy`,
  `ServiceIPStaticSubrange`, and `EndpointSliceTerminatingCondition`. ([#117237](https://github.com/kubernetes/kubernetes/pull/117237), [@yulng](https://github.com/yulng))
- Removed the deprecated `azureFile` in-tree storage plugin. ([#118236](https://github.com/kubernetes/kubernetes/pull/118236), [@andyzhangx](https://github.com/andyzhangx))
- Structured logging of `NamespacedName` was inconsistent with `klog.KObj`. Now both will use lower case field names and namespace is optional. ([#117238](https://github.com/kubernetes/kubernetes/pull/117238), [@pohly](https://github.com/pohly))
- The `generate_groups.sh` and `generate_internal_groups.sh` scripts from the k8s.io/code-generator repo are deprecated (but still work) in favor of `kube_codegen.sh` in that same repo.  Projects which use the old scripts are encouraged to look at adopting the new one. ([#117897](https://github.com/kubernetes/kubernetes/pull/117897), [@thockin](https://github.com/thockin)) [SIG API Machinery]
- The feature gate `CSIStorageCapacity` have been removed and must no longer be referenced in `--feature-gates` flags. ([#118018](https://github.com/kubernetes/kubernetes/pull/118018), [@humblec](https://github.com/humblec))
- The feature gates `DisableAcceleratorUsageMetrics` and `PodSecurity` that graduated to GA and were unconditionally enabled have been removed in v1.28 ([#114068](https://github.com/kubernetes/kubernetes/pull/114068), [@cyclinder](https://github.com/cyclinder)) [SIG API Machinery, Node, Scheduling and Storage]
- The kubelet podresources endpoint is GA and always enabled ([#116525](https://github.com/kubernetes/kubernetes/pull/116525), [@ffromani](https://github.com/ffromani)) [SIG Node]
- Updated Cluster Autosaler to version 1.26.1 ([#116526](https://github.com/kubernetes/kubernetes/pull/116526), [@pacoxu](https://github.com/pacoxu)) [SIG Autoscaling and Cloud Provider]
- Updated `cri-tools` to `v1.27.0`. ([#117545](https://github.com/kubernetes/kubernetes/pull/117545), [@saschagrunert](https://github.com/saschagrunert))
- Updated cri-tools to v1.26.1. ([#116649](https://github.com/kubernetes/kubernetes/pull/116649), [@saschagrunert](https://github.com/saschagrunert)) [SIG Architecture and Release]
- When retrieving event resources, the reportingController and reportingInstance fields in the event will contain values. ([#116506](https://github.com/kubernetes/kubernetes/pull/116506), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG API Machinery and Instrumentation]
- [KCCM] drop filtering nodes for the providerID when syncing load balancers, but have changes to the field trigger a re-sync of load balancers. This should ensure that cloud providers which don't specify providerID, can still use the service controller implementation to provision load balancers. ([#117602](https://github.com/kubernetes/kubernetes/pull/117602), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu)) [SIG Cloud Provider and Network]
- `kube-apiserver` added two new metrics `authorization_attempts_total` and `authorization_duration_seconds`
  that allow users to monitor requests to authorization webhooks, split by result. ([#117211](https://github.com/kubernetes/kubernetes/pull/117211), [@HirazawaUi](https://github.com/HirazawaUi))
- `kube-apiserver`: Improved memory use when performing GetList on the cache. ([#116327](https://github.com/kubernetes/kubernetes/pull/116327), [@sxllwx](https://github.com/sxllwx))
- `kubeadm`: introduced a new feature gate `UpgradeAddonsBeforeControlPlane` to
  fix a kube-proxy skew policy misalignment. Its default value is `false`. Upgrade
  of the CoreDNS and kube-proxy addons will now trigger after all the control plane
  instances have been upgraded, unless the fearure gate is set to true. This feature
  gate will be removed in a future release. ([#117660](https://github.com/kubernetes/kubernetes/pull/117660), [@pacoxu](https://github.com/pacoxu))