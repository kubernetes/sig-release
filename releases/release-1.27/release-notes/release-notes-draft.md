## Changes by Kind

### Deprecation

- Added warnings to the Services API. Kubernetes now warns for Services in the case of:
  - IPv4 addresses with leading zeros
  - IPv6 address in non-canonical format (RFC 5952) ([#114505](https://github.com/kubernetes/kubernetes/pull/114505), [@aojea](https://github.com/aojea))
- Support for the alpha seccomp annotations `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io` were deprecated since v1.19, now have been completely removed. The seccomp fields are no longer auto-populated when pods with seccomp annotations are created. Pods should use the corresponding pod or container `securityContext.seccompProfile` field instead. ([#114947](https://github.com/kubernetes/kubernetes/pull/114947), [@saschagrunert](https://github.com/saschagrunert))

### API Change

- A fix in the `resource.k8s.io/v1alpha1/ResourceClaim` API avoids harmless (?) ".status.reservedFor: element 0: associative list without keys has an element that's a map type" errors in the apiserver. Validation now rejects the incorrect reuse of the same UID in different entries. ([#115354](https://github.com/kubernetes/kubernetes/pull/115354), [@pohly](https://github.com/pohly))
- A terminating pod on a node that is not caused by preemption won't prevent kube-scheduler from preempting pods on that node
  - Rename `PreemptionByKubeScheduler` to `PreemptionByScheduler` ([#114623](https://github.com/kubernetes/kubernetes/pull/114623), [@Huang-Wei](https://github.com/Huang-Wei))
- Added new option to the `InterPodAffinity` scheduler plugin to ignore existing
  pods` preferred inter-pod affinities if the incoming pod has no preferred inter-pod
  affinities. This option can be used as an optimization for higher scheduling throughput
  (at the cost of an occasional pod being scheduled non-optimally/violating existing
  pods preferred inter-pod affinities). To enable this scheduler option, set the
  `InterPodAffinity` scheduler plugin arg `ignorePreferredTermsOfExistingPods: true` ([#114393](https://github.com/kubernetes/kubernetes/pull/114393), [@danielvegamyhre](https://github.com/danielvegamyhre))
- Added warnings about workload resources (Pods, ReplicaSets, Deployments, Jobs, CronJobs, or ReplicationControllers) whose names are not valid DNS labels. ([#114412](https://github.com/kubernetes/kubernetes/pull/114412), [@thockin](https://github.com/thockin))
- CacheSize field in `EncryptionConfiguration` is not supported for KMSv2 provider ([#113121](https://github.com/kubernetes/kubernetes/pull/113121), [@aramase](https://github.com/aramase))
- Enabled usage of `kube-proxy`, `kube-scheduler` and `kubelet` HTTP APIs for changing the logging
   verbosity at runtime for JSON output. ([#114609](https://github.com/kubernetes/kubernetes/pull/114609), [@pohly](https://github.com/pohly))
- K8s.io/client-go/tools/record.EventBroadcaster: after Shutdown() is called, the broadcaster now gives up immediately after a failure to write an event to a sink. Previously it tried multiple times for 12 seconds in a goroutine. ([#115514](https://github.com/kubernetes/kubernetes/pull/115514), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- K8s.io/component-base/logs: usage of the pflag values in a normal Go flag set led to panics when printing the help message ([#114680](https://github.com/kubernetes/kubernetes/pull/114680), [@pohly](https://github.com/pohly)) [SIG Instrumentation]
- Kubeadm: explicitly set `priority` for static pods with `priorityClassName: system-node-critical` ([#114338](https://github.com/kubernetes/kubernetes/pull/114338), [@champtar](https://github.com/champtar)) [SIG Cluster Lifecycle]
- Kubelet: migrate `--container-runtime-endpoint` and `--image-service-endpoint`
  to kubelet config ([#112136](https://github.com/kubernetes/kubernetes/pull/112136), [@pacoxu](https://github.com/pacoxu))
- Kubernetes components that perform leader election now only support using `Leases` for this. ([#114055](https://github.com/kubernetes/kubernetes/pull/114055), [@aimuz](https://github.com/aimuz))
- The following feature gates for volume expansion GA features have now been removed and must no longer be referenced in `--feature-gates` flags: `ExpandCSIVolumes`, `ExpandInUsePersistentVolumes`, `ExpandPersistentVolumes` ([#113942](https://github.com/kubernetes/kubernetes/pull/113942), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The list-type of the alpha `resourceClaims` field introduced to `Pods` in `1.26.0` was modified from `set` to `map`, resolving an incompatibility with use of this schema in `CustomResourceDefinitions` and with server-side apply. ([#114585](https://github.com/kubernetes/kubernetes/pull/114585), [@JoelSpeed](https://github.com/JoelSpeed))
- Updated API reference for Requests, specifying they must not exceed limits ([#115434](https://github.com/kubernetes/kubernetes/pull/115434), [@ehashman](https://github.com/ehashman))
- `/metrics/slis` is made available for control plane components allowing you to scrape health check metrics. ([#114997](https://github.com/kubernetes/kubernetes/pull/114997), [@Richabanker](https://github.com/Richabanker)) [SIG API Machinery, Apps, Architecture, Auth, Autoscaling, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scheduling, Storage and Testing]
- `StatefulSet` names must be DNS labels, rather than subdomains. Any `StatefulSet`
  which took advantage of subdomain validation (by having dots in the name) can't
  possibly have worked, because we eventually set `pod.spec.hostname` from the `StatefulSetName`,
  and that is validated as a DNS label. ([#114172](https://github.com/kubernetes/kubernetes/pull/114172), [@thockin](https://github.com/thockin))
- `k8s.io/component-base/logs` now also supports adding command line flags to a `flag.FlagSet`. ([#114731](https://github.com/kubernetes/kubernetes/pull/114731), [@pohly](https://github.com/pohly))

### Feature

- 'kubelet TCP and HTTP probes are now more effective using networking resources:
  conntrack entries, sockets. This is achieved by reducing the `TIME-WAIT` state
  of the connection to 1 second, instead of the defaults 60 seconds. This allows
  kubelet to free the socket, and free conntrack entry and ephemeral port associated.' ([#115143](https://github.com/kubernetes/kubernetes/pull/115143), [@aojea](https://github.com/aojea))
- A new client side metric `rest_client_request_retries_total` has been added that tracks 
  the number of retries sent to the server, partitioned by status code, verb, and host ([#108396](https://github.com/kubernetes/kubernetes/pull/108396), [@tkashem](https://github.com/tkashem))
- A new feature has been enabled to improve the performance of the iptables mode of kube-proxy in large clusters. You do not need to take any action, however:
  
  1. If you experience problems with Services not syncing to iptables correctly, you can disable the feature by passing `--feature-gates=MinimizeIPTablesRestore=false` to kube-proxy (and file a bug if this fixes it). (This might also be detected by seeing the value of kube-proxy's `sync_proxy_rules_iptables_partial_restore_failures_total` metric rising.)
  2. If you were previously overriding the kube-proxy configuration for performance reasons, this may no longer be necessary. See https://kubernetes.io/docs/reference/networking/virtual-ips/#optimizing-iptables-mode-performance. ([#115138](https://github.com/kubernetes/kubernetes/pull/115138), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Added "general", "baseline", and "restricted" debugging profiles for kubectl debug. ([#114280](https://github.com/kubernetes/kubernetes/pull/114280), [@sding3](https://github.com/sding3)) [SIG CLI]
- Added apiserver_envelope_encryption_kms_operations_latency_seconds metric to measure the KMSv2 grpc calls latency. ([#115649](https://github.com/kubernetes/kubernetes/pull/115649), [@aramase](https://github.com/aramase)) [SIG API Machinery, Auth and Testing]
- Added kubelet Topology Manager metrics to track admission requests processed by it and occured admission errors. ([#115137](https://github.com/kubernetes/kubernetes/pull/115137), [@swatisehgal](https://github.com/swatisehgal))
- Added logging-format option to CCMs based on `k8s.io/cloud-provider` ([#108984](https://github.com/kubernetes/kubernetes/pull/108984), [@LittleFox94](https://github.com/LittleFox94))
- Added new -f flag into debug command to be used passing pod or node files instead explicit names. ([#111453](https://github.com/kubernetes/kubernetes/pull/111453), [@ardaguclu](https://github.com/ardaguclu))
- Added scheduler preemption support for pods using `ReadWriteOncePod` PVCs ([#114051](https://github.com/kubernetes/kubernetes/pull/114051), [@chrishenzie](https://github.com/chrishenzie))
- Adds the applyconfiguration generator to the code-generator script that generates server-side apply configuration and client APIs ([#114987](https://github.com/kubernetes/kubernetes/pull/114987), [@astefanutti](https://github.com/astefanutti)) [SIG API Machinery]
- Dynamic Resource Allocation framework can be used for network devices ([#114364](https://github.com/kubernetes/kubernetes/pull/114364), [@bart0sh](https://github.com/bart0sh)) [SIG Node]
- Fixed bug which caused the status of Indexed Jobs to only be updated when there are newly completed indexes. The completed indexes are now updated if the .status.completedIndexes has values outside of the [0, .spec.completions> range ([#115349](https://github.com/kubernetes/kubernetes/pull/115349), [@danielvegamyhre](https://github.com/danielvegamyhre)) [SIG Apps]
- GRPC probes now set a linger option of 1s to improve the TIME-WAIT state. ([#115321](https://github.com/kubernetes/kubernetes/pull/115321), [@rphillips](https://github.com/rphillips)) [SIG Network and Node]
- Graduated the `LegacyServiceAccountTokenTracking` feature gate to Beta. The usage of auto-generated secret-based service account token now produces warnings by default, and relevant Secrets are labeled with a last-used timestamp (label key `kubernetes.io/legacy-token-last-used`). ([#114523](https://github.com/kubernetes/kubernetes/pull/114523), [@zshihang](https://github.com/zshihang)) [SIG API Machinery and Auth]
- Kube-up now includes `CoreDNS` version `v1.9.3` ([#114279](https://github.com/kubernetes/kubernetes/pull/114279), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: added the experimental (alpha) feature gate `EtcdLearnerMode` that allows etcd members to be joined as learner and only then promoted as voting members ([#113318](https://github.com/kubernetes/kubernetes/pull/113318), [@pacoxu](https://github.com/pacoxu))
- Kubectl will now display `SeccompProfile` for pods, containers and ephemeral containers, if values were set. ([#113284](https://github.com/kubernetes/kubernetes/pull/113284), [@williamyeh](https://github.com/williamyeh))
- Kubectl: added e2e test for default container annotation ([#115046](https://github.com/kubernetes/kubernetes/pull/115046), [@pacoxu](https://github.com/pacoxu))
- Kubelet config file will be backed up to `/etc/kubernetes/tmp/` folder with `kubeadm-kubelet-config` append with a random suffix as the filename ([#114695](https://github.com/kubernetes/kubernetes/pull/114695), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle]
- Kubelet no longer creates certain legacy iptables rules by default.
  It is possible that this will cause problems with some third-party components
  that improperly depended on those rules. If this affects you, you can run
  kubelet with `--feature-gates=IPTablesOwnershipCleanup=false`, but you should
  also file a bug against the third-party component. ([#114472](https://github.com/kubernetes/kubernetes/pull/114472), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Kubernetes is now built with Go `1.19.5` ([#115010](https://github.com/kubernetes/kubernetes/pull/115010), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with go 1.20 ([#114502](https://github.com/kubernetes/kubernetes/pull/114502), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Made `kubectl-convert` binary linking static (also affects the deb and rpm packages). ([#114228](https://github.com/kubernetes/kubernetes/pull/114228), [@saschagrunert](https://github.com/saschagrunert))
- Migrated the ResourceQuota controller (within `kube-controller-manager`) to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#113315](https://github.com/kubernetes/kubernetes/pull/113315), [@ncdc](https://github.com/ncdc)) [SIG API Machinery, Apps and Testing]
- New feature gate, `ServiceNodePortStaticSubrange`, to enable the new strategy in the `NodePort` Service port allocators, so the node port range is subdivided and dynamic allocated `NodePort` port for Services are allocated preferentially from the upper range. ([#114418](https://github.com/kubernetes/kubernetes/pull/114418), [@xuzhenglun](https://github.com/xuzhenglun))
- Node `ipam` controller now exposes metrics `cidrset_cidrs_max_total` and `multicidrset_cidrs_max_total` with information about the max number of CIDRs that can be allocated. ([#112260](https://github.com/kubernetes/kubernetes/pull/112260), [@aryan9600](https://github.com/aryan9600))
- Profiling can now be served on a unix-domain socket by using the `--profiling-path` option (when profiling is enabled) for security purposes. ([#114191](https://github.com/kubernetes/kubernetes/pull/114191), [@apelisse](https://github.com/apelisse)) [SIG API Machinery]
- Scheduler doesn't run plugin's `Filter` method when its `PreFilter` method returned a Skip status.
  In other words, your `PreFilter`/`Filter` plugin can return a Skip status in `PreFilter` if the plugin does nothing in Filter for that Pod.
  Scheduler skips `NodeAffinity` Filter plugin when `NodeAffinity` Filter plugin has nothing to do with a Pod.
  It may affect some metrics values related to the `NodeAffinity` Filter plugin. ([#114125](https://github.com/kubernetes/kubernetes/pull/114125), [@sanposhiho](https://github.com/sanposhiho))
- Scheduler doesn't run plugin's `Score` method when its `PreScore` method returned a `Skip` status. In other words, your `PreScore/Score` plugin can return a `Skip` status in `PreScore` if the plugin does nothing in `Score` for that Pod. ([#115652](https://github.com/kubernetes/kubernetes/pull/115652), [@kidddddddddddddddddddddd](https://github.com/kidddddddddddddddddddddd))
- Scheduler skips `InterPodAffinity` Filter plugin when `InterPodAffinity` Filter plugin has nothing to do with a Pod.
  It may affect some metrics values related to the `InterPodAffinity` Filter plugin. ([#114889](https://github.com/kubernetes/kubernetes/pull/114889), [@sanposhiho](https://github.com/sanposhiho))
- Scheduler volumebinding: leveraged `PreFilterResult` to reduce down to only
  eligible node(s) for pod with bound claim(s) to local `PersistentVolume(s)` ([#109877](https://github.com/kubernetes/kubernetes/pull/109877), [@yibozhuang](https://github.com/yibozhuang))
- Scheduling cycle now terminates immediately when any scheduler plugin returns an 
  `unschedulableAndUnresolvable` status in `PostFilter`. ([#114699](https://github.com/kubernetes/kubernetes/pull/114699), [@kerthcet](https://github.com/kerthcet))
- The `AdvancedAuditing` feature gate was locked to _true_ in v1.27, and will be removed completely in v1.28 ([#115163](https://github.com/kubernetes/kubernetes/pull/115163), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery]
- The go version defined in `.go-version` is now fetched when invoking test, build, and code generation targets if the current go version does not match it. Set $FORCE_HOST_GO=y while testing or building to skip this behavior, or set $GO_VERSION to override the selected go version. ([#115377](https://github.com/kubernetes/kubernetes/pull/115377), [@liggitt](https://github.com/liggitt)) [SIG Testing]
- The mount-utils mounter now provides an option to limit the number of concurrent format operations. ([#115379](https://github.com/kubernetes/kubernetes/pull/115379), [@artemvmin](https://github.com/artemvmin)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node and Storage]
- Updated `cAdvisor` to `v0.47.0` ([#114883](https://github.com/kubernetes/kubernetes/pull/114883), [@bobbypage](https://github.com/bobbypage))
- `MinDomainsInPodTopologySpread` feature gate is enabled by default as a
  Beta feature in 1.27. ([#114445](https://github.com/kubernetes/kubernetes/pull/114445), [@mengjiao-liu](https://github.com/mengjiao-liu))
- `Secret` of `kubernetes.io/tls` type now verifies that the private key matches the cert ([#113581](https://github.com/kubernetes/kubernetes/pull/113581), [@aimuz](https://github.com/aimuz))
- `kube-proxy` now accepts the `ContextualLogging`, `LoggingAlphaOptions`, `LoggingBetaOptions` ([#115233](https://github.com/kubernetes/kubernetes/pull/115233), [@pohly](https://github.com/pohly))
- `kubectl` now uses `HorizontalPodAutoscaler` `v2` by default. ([#114886](https://github.com/kubernetes/kubernetes/pull/114886), [@a7i](https://github.com/a7i))

### Documentation

- Error message for Pods with requests exceeding limits will have a limit value printed. ([#112925](https://github.com/kubernetes/kubernetes/pull/112925), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))

### Failing Test

- Deflaked a preemption test that may patch Nodes incorrectly. ([#114350](https://github.com/kubernetes/kubernetes/pull/114350), [@Huang-Wei](https://github.com/Huang-Wei))

### Bug or Regression

- Added (dry run) and (server dry run) suffixes to `kubectl scale` command when `dry-run` is passed ([#114252](https://github.com/kubernetes/kubernetes/pull/114252), [@ardaguclu](https://github.com/ardaguclu))
- Applied configurations can be generated for types with `non-builtin` map fields ([#114920](https://github.com/kubernetes/kubernetes/pull/114920), [@astefanutti](https://github.com/astefanutti))
- Changed the error message of `kubectl rollout restart` when subsequent `kubectl rollout restart` commands are executed within a second ([#113040](https://github.com/kubernetes/kubernetes/pull/113040), [@ardaguclu](https://github.com/ardaguclu))
- Changed the error message to `cannot exec into multiple objects at a time` when file passed to `kubectl exec` contains multiple resources ([#114249](https://github.com/kubernetes/kubernetes/pull/114249), [@ardaguclu](https://github.com/ardaguclu))
- Client-go: fixed potential data races retrying requests using a custom `io.Reader` body; with this fix, only requests with no body or with `string` / `[]byte` / `runtime.Object` bodies can be retried ([#113933](https://github.com/kubernetes/kubernetes/pull/113933), [@liggitt](https://github.com/liggitt))
- Describing the CRs now hides `.metadata.managedFields` ([#114584](https://github.com/kubernetes/kubernetes/pull/114584), [@soltysh](https://github.com/soltysh))
- Enforce `nodeName` cannot be set along with non-empty `schedulingGates` ([#115569](https://github.com/kubernetes/kubernetes/pull/115569), [@Huang-Wei](https://github.com/Huang-Wei))
- Etcd: Update to v3.5.7 ([#115310](https://github.com/kubernetes/kubernetes/pull/115310), [@mzaian](https://github.com/mzaian)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- Excluded preemptor pod metadata in the event message ([#114923](https://github.com/kubernetes/kubernetes/pull/114923), [@mimowo](https://github.com/mimowo))
- Fixed CSI `PersistentVolumes` to allow Secrets names longer than 63 characters. ([#114776](https://github.com/kubernetes/kubernetes/pull/114776), [@jsafrane](https://github.com/jsafrane))
- Fixed Route controller to update routes when NodeIP changes ([#108095](https://github.com/kubernetes/kubernetes/pull/108095), [@lzhecheng](https://github.com/lzhecheng))
- Fixed `DaemonSet` to update the status even if it fails to create a pod. ([#113787](https://github.com/kubernetes/kubernetes/pull/113787), [@gjkim42](https://github.com/gjkim42))
- Fixed `SELinux` label for host path volumes created by host path provisioner ([#112021](https://github.com/kubernetes/kubernetes/pull/112021), [@mrunalp](https://github.com/mrunalp))
- Fixed `StatefulSetAutoDeletePVC` feature when `OwnerReferencesPermissionEnforcement` admission plugin is enabled. ([#114116](https://github.com/kubernetes/kubernetes/pull/114116), [@jsafrane](https://github.com/jsafrane))
- Fixed a bug on the `EndpointSlice` mirroring controller that generated multiple slices in some cases for custom endpoints in non canonical format. ([#114155](https://github.com/kubernetes/kubernetes/pull/114155), [@aojea](https://github.com/aojea))
- Fixed a bug that caused to panic the apiserver when trying to allocate a Service with a dynamic `ClusterIP` and it has been configured with Service CIDRs with a /28 mask for IPv4 and a /124 mask for IPv6 ([#115322](https://github.com/kubernetes/kubernetes/pull/115322), [@aojea](https://github.com/aojea))
- Fixed a bug where `events/v1` `Events` with similar event type and reporting instance were not aggregated by `client-go`. ([#112365](https://github.com/kubernetes/kubernetes/pull/112365), [@dgrisonnet](https://github.com/dgrisonnet))
- Fixed a bug where when emitting similar Events consecutively, some were rejected by the apiserver. ([#114237](https://github.com/kubernetes/kubernetes/pull/114237), [@dgrisonnet](https://github.com/dgrisonnet))
- Fixed a data race when emitting similar Events consecutively ([#114236](https://github.com/kubernetes/kubernetes/pull/114236), [@dgrisonnet](https://github.com/dgrisonnet))
- Fixed a regression that the scheduler always goes through all Filter plugins. ([#114518](https://github.com/kubernetes/kubernetes/pull/114518), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed an issue where a CSI migrated volume may be prematurely detached when the CSI driver is not running on the node.
  If CSI migration is enabled on the node, even the csi-driver is not up and ready, we will still add this volume to DSW. ([#115464](https://github.com/kubernetes/kubernetes/pull/115464), [@sunnylovestiramisu](https://github.com/sunnylovestiramisu))
- Fixed an issue where failed pods associated with a job with `parallelism = 1` are recreated by the job controller honoring exponential backoff delay again. However, for jobs with `parallelism > 1`, pods might be created without exponential backoff delay. ([#114516](https://github.com/kubernetes/kubernetes/pull/114516), [@nikhita](https://github.com/nikhita))
- Fixed bug in CRD Validation Rules (beta) and `ValidatingAdmissionPolicy` (alpha) where all admission requests could result in `internal error: runtime error: index out of range [3] with length 3 evaluating rule: <rule name>` under certain circumstances. ([#114857](https://github.com/kubernetes/kubernetes/pull/114857), [@jpbetz](https://github.com/jpbetz))
- Fixed bug in reflector that couldn't recover from `Too large resource version` errors with API servers before 1.17.0. ([#115093](https://github.com/kubernetes/kubernetes/pull/115093), [@xuzhenglun](https://github.com/xuzhenglun))
- Fixed clearing of rate-limiter for the queue of checks for cleaning stale pod disruption conditions. The bug could result in the PDB synchronization updates firing too often or the pod disruption cleanups taking too long to happen. ([#114770](https://github.com/kubernetes/kubernetes/pull/114770), [@mimowo](https://github.com/mimowo))
- Fixed file permission issues that happened during update of `Secret`/`ConfigMap`/`projected volume` when `fsGroup` is used. The problem caused a race condition where application gets intermittent permission denied error when reading files that were just updated, before the correct permissions were applied. ([#114464](https://github.com/kubernetes/kubernetes/pull/114464), [@tsaarni](https://github.com/tsaarni))
- Fixed issue in `Winkernel` Proxier - Unexpected active TCP connection drops while horizontally scaling the endpoints for a LoadBalancer Service with Internal Traffic Policy: `Local` ([#113742](https://github.com/kubernetes/kubernetes/pull/113742), [@princepereira](https://github.com/princepereira))
- Fixed issue on Windows when calculating cpu limits on nodes with more than 64 logical processors ([#114231](https://github.com/kubernetes/kubernetes/pull/114231), [@mweibel](https://github.com/mweibel))
- Fixed issue with Winkernel Proxier - IPV6 load balancer policies were missing when service was configured with `ipFamilyPolicy`: `RequireDualStack` ([#115503](https://github.com/kubernetes/kubernetes/pull/115503), [@princepereira](https://github.com/princepereira))
- Fixed issue with Winkernel Proxier - IPV6 load balancer policies were missing when service was configured with `ipFamilyPolicy`: `RequireDualStack` ([#115577](https://github.com/kubernetes/kubernetes/pull/115577), [@princepereira](https://github.com/princepereira))
- Fixed issue with `Winkernel Proxier` - No ingress load balancer rules with endpoints to support load balancing when all the endpoints are terminating. ([#113776](https://github.com/kubernetes/kubernetes/pull/113776), [@princepereira](https://github.com/princepereira))
- Fixed nil pointer error in nodevolumelimits csi logging ([#115179](https://github.com/kubernetes/kubernetes/pull/115179), [@sunnylovestiramisu](https://github.com/sunnylovestiramisu))
- Fixed panic validating custom resource definition schemas that set `multipleOf` to 0 ([#114869](https://github.com/kubernetes/kubernetes/pull/114869), [@liggitt](https://github.com/liggitt))
- Fixed stuck apiserver if an aggregated apiservice returned `304 Not Modified` for aggregated discovery information ([#114459](https://github.com/kubernetes/kubernetes/pull/114459), [@alexzielenski](https://github.com/alexzielenski))
- Fixed the regression that introduced 34s timeout for DELETECOLLECTION calls ([#115341](https://github.com/kubernetes/kubernetes/pull/115341), [@tkashem](https://github.com/tkashem))
- Flag `workerCount` has been added to cloud node controller which defines how many workers will be synchronizing nodes. ([#113104](https://github.com/kubernetes/kubernetes/pull/113104), [@pawbana](https://github.com/pawbana)) [SIG API Machinery, Cloud Provider and Scalability]
- IPVS: Any ipvs scheduler can now be configured. If a un-usable scheduler is configured `kube-proxy` will re-start and the logs must be checked (same as before but different log printouts). ([#114878](https://github.com/kubernetes/kubernetes/pull/114878), [@uablrek](https://github.com/uablrek))
- If a user attempts to add an ephemeral container to a static pod, they will now get a visible validation error. ([#114086](https://github.com/kubernetes/kubernetes/pull/114086), [@xmcqueen](https://github.com/xmcqueen))
- Kube-apiserver: errors decoding objects in etcd are now recorded in an `apiserver_storage_decode_errors_total` counter metric ([#114376](https://github.com/kubernetes/kubernetes/pull/114376), [@baomingwang](https://github.com/baomingwang)) [SIG API Machinery and Instrumentation]
- Kube-apiserver: regular expressions specified with the `--cors-allowed-origins` option are now validated to match the entire `hostname` inside the `Origin` header of the request and 
  must contain '^' or the '//' prefix to anchor to the start, and '$' or the port separator ':' to anchor to 
  the end. ([#112809](https://github.com/kubernetes/kubernetes/pull/112809), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Kube-apiserver: removed N^2 behavior loading webhook configurations. ([#114794](https://github.com/kubernetes/kubernetes/pull/114794), [@lavalamp](https://github.com/lavalamp)) [SIG API Machinery, Architecture, CLI, Cloud Provider and Node]
- Kubeadm: fixed an etcd learner-mode bug by preparing an etcd static pod manifest before promoting ([#115038](https://github.com/kubernetes/kubernetes/pull/115038), [@tobiasgiese](https://github.com/tobiasgiese))
- Kubeadm: fixed the bug where `kubeadm` always does CRI detection even if it is not required by a phase subcommand ([#114455](https://github.com/kubernetes/kubernetes/pull/114455), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: improved retries when updating node information, in case `kube-apiserver` is temporarily unavailable ([#114176](https://github.com/kubernetes/kubernetes/pull/114176), [@QuantumEnergyE](https://github.com/QuantumEnergyE))
- Kubeadm: respects user provided kubeconfig during discovery process ([#113998](https://github.com/kubernetes/kubernetes/pull/113998), [@SataQiu](https://github.com/SataQiu))
- Kubectl: enabled usage of label selector for filtering out resources when pruning for kubectl diff ([#114863](https://github.com/kubernetes/kubernetes/pull/114863), [@danlenar](https://github.com/danlenar))
- Kubelet startup now fails CRI connection if service or image endpoint is throwing any error ([#115102](https://github.com/kubernetes/kubernetes/pull/115102), [@saschagrunert](https://github.com/saschagrunert))
- Kubelet: fixed a bug of stoping rendering configmap when enabling fsquota monitoring ([#112624](https://github.com/kubernetes/kubernetes/pull/112624), [@pacoxu](https://github.com/pacoxu))
- Messages of `DisruptionTarget` condition now excludes preemptor pod metadata ([#114914](https://github.com/kubernetes/kubernetes/pull/114914), [@mimowo](https://github.com/mimowo))
- Optimized `LoadBalancer` creation with the help of attribute Internal Traffic Policy: `Local` ([#114407](https://github.com/kubernetes/kubernetes/pull/114407), [@princepereira](https://github.com/princepereira))
- Preemption evnet messages now do not include scheduler names ([#114980](https://github.com/kubernetes/kubernetes/pull/114980), [@mimowo](https://github.com/mimowo))
- Relaxed API validation for usage `key encipherment` and `kubelet` uses requested usages accordingly ([#111660](https://github.com/kubernetes/kubernetes/pull/111660), [@pacoxu](https://github.com/pacoxu))
- Set device stage path whenever available for expansion during mount ([#115346](https://github.com/kubernetes/kubernetes/pull/115346), [@gnufied](https://github.com/gnufied)) [SIG Storage and Testing]
- Shared informers now correctly propagate whether they are synced or not. Individual informer handlers may now check if they are synced or not (new `HasSynced` method). Library support is added to assist controllers in tracking whether their own work is completed for items in the initial list (`AsyncTracker`). ([#113985](https://github.com/kubernetes/kubernetes/pull/113985), [@lavalamp](https://github.com/lavalamp))
- Statefulset status will be consistent on API errors ([#113834](https://github.com/kubernetes/kubernetes/pull/113834), [@atiratree](https://github.com/atiratree)) [SIG Apps]
- The Kubernetes API server now correctly detects and closes existing TLS connections when its client certificate file for kubelet authentication has been rotated. ([#115315](https://github.com/kubernetes/kubernetes/pull/115315), [@enj](https://github.com/enj)) [SIG API Machinery, Auth, Node and Testing]
- Total test spec is now available by `ProgressReporter`, it will be reported before test suite got executed. ([#114417](https://github.com/kubernetes/kubernetes/pull/114417), [@chendave](https://github.com/chendave))
- When describing deployments, `OldReplicaSets` now always shows all replicasets controlled the deployment, not just those that still have replicas available. ([#113083](https://github.com/kubernetes/kubernetes/pull/113083), [@llorllale](https://github.com/llorllale)) [SIG CLI]
- `LabelSelectors` specified in `topologySpreadConstraints` are now validated to
  ensure that pod is scheduled as expected. Existing pods with invalid `LabelSelectors`
  can be updated, but new pods are required to specify valid `LabelSelectors`. ([#111802](https://github.com/kubernetes/kubernetes/pull/111802), [@maaoBit](https://github.com/maaoBit))
- `PodGC` for pods which are in terminal phase now do not add the `DisruptionTarget` condition. ([#115056](https://github.com/kubernetes/kubernetes/pull/115056), [@mimowo](https://github.com/mimowo))
- `Service` of type `ExternalName` do not create an `Endpoint` anymore. ([#114814](https://github.com/kubernetes/kubernetes/pull/114814), [@panslava](https://github.com/panslava))
- `kube-controller-manager` will not run nodeipam controller when allocator type
  is `CloudAllocator` and the cloud provider is not enabled. ([#114596](https://github.com/kubernetes/kubernetes/pull/114596), [@andrewsykim](https://github.com/andrewsykim))
- `kube-proxy` with `--proxy-mode=ipvs` can be used with statically linked kernels.
  The reseved IPv4 range `TEST-NET-2` in `rfc5737` MUST NOT be used for `ClusterIP` or `loadBalancerIP` since address `198.51.100.0` is used for probing. ([#114669](https://github.com/kubernetes/kubernetes/pull/114669), [@uablrek](https://github.com/uablrek))
- `kubectl port-forward` now exits with exit code 1 when remote connection is
  lost ([#114460](https://github.com/kubernetes/kubernetes/pull/114460), [@brianpursley](https://github.com/brianpursley))
- `tryUnmount` now respects `mounter.withSafeNotMountedBehavior` ([#114736](https://github.com/kubernetes/kubernetes/pull/114736), [@andyzhangx](https://github.com/andyzhangx))

### Other (Cleanup or Flake)

- Callers of `wait.ExponentialBackoffWithContext` now must pass a `ConditionWithContextFunc` to be consistent with the signature and avoid creating a duplicate context. If your condition does not need a context you can use the `ConditionFunc.WithContext()` helper to ignore the context, or use `ExponentialBackoff` directly. ([#115113](https://github.com/kubernetes/kubernetes/pull/115113), [@smarterclayton](https://github.com/smarterclayton))
- Changed docs for `--contention-profiling` flag to reflect it performed block profiling ([#114490](https://github.com/kubernetes/kubernetes/pull/114490), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- E2e framework: added `--report-complete-ginkgo` and `--report-complete-junit` parameters. They work like `ginkgo --json-report <report dir>/ginkgo/report.json --junit-report <report dir>/ginkgo/report.xml`. ([#115678](https://github.com/kubernetes/kubernetes/pull/115678), [@pohly](https://github.com/pohly)) [SIG Testing]
- Fixed incorrect log information in the `iptables` utility. ([#110723](https://github.com/kubernetes/kubernetes/pull/110723), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Improved misleading message, in case of no metrics received for the `HPA` controlled pods. ([#114740](https://github.com/kubernetes/kubernetes/pull/114740), [@kushagra98](https://github.com/kushagra98))
- Kubeadm: removed the deprecated `v1beta2` API. kubeadm 1.26's `config migrate`
  command can be used to migrate a `v1beta2` configuration file to `v1beta3` ([#114540](https://github.com/kubernetes/kubernetes/pull/114540), [@pacoxu](https://github.com/pacoxu))
- Promoted pod resource `limit/request` metrics to stable. ([#115454](https://github.com/kubernetes/kubernetes/pull/115454), [@dgrisonnet](https://github.com/dgrisonnet))
- Removed flag `master-service-namespace` from `api-server` arguments ([#114446](https://github.com/kubernetes/kubernetes/pull/114446), [@lengrongfu](https://github.com/lengrongfu))
- Removed unused rule for `nodes/spec` from `ClusterRole` `system:kubelet-api-admin` ([#113267](https://github.com/kubernetes/kubernetes/pull/113267), [@hoskeri](https://github.com/hoskeri))
- Renamed API server identity Lease labels to use the key `apiserver.kubernetes.io/identity` ([#114586](https://github.com/kubernetes/kubernetes/pull/114586), [@andrewsykim](https://github.com/andrewsykim)) [SIG API Machinery, Apps, Cloud Provider and Testing]
- The `CSIMigrationAzureFile` feature gate (for the feature which graduated to GA in v1.26) is now unconditionally enabled and will be removed in v1.28. ([#114953](https://github.com/kubernetes/kubernetes/pull/114953), [@enj](https://github.com/enj))
- The `ControllerManagerLeaderMigration` feature, GA since `1.24`, is unconditionally enabled and the feature gate option has been removed. ([#113534](https://github.com/kubernetes/kubernetes/pull/113534), [@pacoxu](https://github.com/pacoxu))
- The `WaitFor` and `WaitForWithContext` functions in the wait package have now been marked private. Callers should use the equivalent `Poll*` method with a zero duration interval. ([#115116](https://github.com/kubernetes/kubernetes/pull/115116), [@smarterclayton](https://github.com/smarterclayton))
- The feature gates `CSIInlineVolume`, `CSIMigration`, `DaemonSetUpdateSurge`, `EphemeralContainers`, `IdentifyPodOS`, `LocalStorageCapacityIsolation`, `NetworkPolicyEndPort` and `StatefulSetMinReadySeconds` that graduated to GA in v1.25 and were unconditionally enabled have been removed in v1.27 ([#114410](https://github.com/kubernetes/kubernetes/pull/114410), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- `wait.ContextForChannel()` now implements the context.Context interface and
  does not return a cancellation function. ([#115140](https://github.com/kubernetes/kubernetes/pull/115140), [@smarterclayton](https://github.com/smarterclayton))