## Action Required

- action required
  1. Currently, if users were to explicitly specify CacheSize of 0 for KMS provider, they would end-up with a provider that caches up to 1000 keys. This PR changes this behavior.
  Post this PR, when users supply 0 for CacheSize this will result in a validation error.
  
  2. CacheSize type was changed from int32 to *int32. This allows defaulting logic to differentiate between cases where users explicitly supplied 0 vs. not supplied any value.
  3. KMS Provider's endpoint (path to Unix socket) is now validated when the EncryptionConfiguration files is loaded. This used to be handled by the GRPCService. ([#85363](https://github.com/kubernetes/kubernetes/pull/85363), [@immutableT](https://github.com/immutableT))

  Courtesy of SIG API Machinery, SIG Auth, and SIG Instrumentation


## New Features

- Azure storage clients now suppress requests on throttling ([#87306](https://github.com/kubernetes/kubernetes/pull/87306), [@feiskyer](https://github.com/feiskyer))

  Courtesy of SIG Cloud Provider
- EndpointSlices will now be enabled by default. A new `EndpointSliceProxying` feature gate determines if kube-proxy will use EndpointSlices, this is disabled by default. ([#86137](https://github.com/kubernetes/kubernetes/pull/86137), [@robscott](https://github.com/robscott))

  Courtesy of SIG Auth, and SIG Network
- kube-proxy: Added dual-stack IPv4/IPv6 support to the iptables proxier. ([#82462](https://github.com/kubernetes/kubernetes/pull/82462), [@vllry](https://github.com/vllry))

  Courtesy of SIG Network
- Azure VMSS/VMSSVM clients now suppress requests on throttling ([#86740](https://github.com/kubernetes/kubernetes/pull/86740), [@feiskyer](https://github.com/feiskyer))

  Courtesy of SIG Cloud Provider
- New metric kubelet_pleg_last_seen_seconds to aid diagnosis of PLEG not healthy issues. ([#86251](https://github.com/kubernetes/kubernetes/pull/86251), [@bboreham](https://github.com/bboreham))

  Courtesy of SIG Node
- New flag `--show-hidden-metrics-for-version` in kube-controller-manager can be used to show all hidden metrics that deprecated in the previous minor release. ([#85281](https://github.com/kubernetes/kubernetes/pull/85281), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery
- Azure network and VM clients now suppress requests on throttling ([#87122](https://github.com/kubernetes/kubernetes/pull/87122), [@feiskyer](https://github.com/feiskyer))

  Courtesy of SIG Cloud Provider
- Azure global rate limit is switched to per-client. A set of new rate limit configure options are introduced, including routeRateLimit, SubnetsRateLimit, InterfaceRateLimit, RouteTableRateLimit, LoadBalancerRateLimit, PublicIPAddressRateLimit, SecurityGroupRateLimit, VirtualMachineRateLimit, StorageAccountRateLimit, DiskRateLimit, SnapshotRateLimit, VirtualMachineScaleSetRateLimit and VirtualMachineSizeRateLimit.
  
  The original rate limit options would be default values for those new client's rate limiter. ([#86515](https://github.com/kubernetes/kubernetes/pull/86515), [@feiskyer](https://github.com/feiskyer))

  Courtesy of SIG Cloud Provider
- option `preConfiguredBackendPoolLoadBalancerTypes` is added to azure cloud provider for the pre-configured load balancers, possible values: `""`, `"internal"`, "external"`, `"all"` ([#86338](https://github.com/kubernetes/kubernetes/pull/86338), [@gossion](https://github.com/gossion))

  Courtesy of SIG Cloud Provider
- Promote StartupProbe to beta for 1.18 release ([#83437](https://github.com/kubernetes/kubernetes/pull/83437), [@matthyx](https://github.com/matthyx))

  Courtesy of SIG Node, SIG Scalability, and SIG Testing
- hollow-node use fake CRI ([#85879](https://github.com/kubernetes/kubernetes/pull/85879), [@gongguan](https://github.com/gongguan))

  Courtesy of SIG Node, and SIG Scalability
- New flag `--show-hidden-metrics-for-version` in kube-proxy can be used to show all hidden metrics that deprecated in the previous minor release. ([#85279](https://github.com/kubernetes/kubernetes/pull/85279), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Cluster Lifecycle, and SIG Network
- add kube-proxy flags --ipvs-tcp-timeout, --ipvs-tcpfin-timeout, --ipvs-udp-timeout to configure IPVS connection timeouts. ([#85517](https://github.com/kubernetes/kubernetes/pull/85517), [@andrewsykim](https://github.com/andrewsykim))

  Courtesy of SIG Cluster Lifecycle, and SIG Network
- The underlying format of the `CPUManager` state file has changed. Upgrades should be seamless, but any third-party tools that rely on reading the previous format need to be updated. ([#84462](https://github.com/kubernetes/kubernetes/pull/84462), [@klueska](https://github.com/klueska))

  Courtesy of SIG Node, and SIG Testing
- azure cloud provider cache TTL is configurable, list of the azure cloud provider is as following:
  - "availabilitySetNodesCacheTTLInSeconds"
  - "vmssCacheTTLInSeconds"
  - "vmssVirtualMachinesCacheTTLInSeconds"
  - "vmCacheTTLInSeconds"
  - "loadBalancerCacheTTLInSeconds"
  - "nsgCacheTTLInSeconds"
  - "routeTableCacheTTLInSeconds" ([#86266](https://github.com/kubernetes/kubernetes/pull/86266), [@zqingqing1](https://github.com/zqingqing1))

  Courtesy of SIG Cloud Provider
- elasticsearch supports automatically setting the advertise address ([#85944](https://github.com/kubernetes/kubernetes/pull/85944), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle, and SIG Instrumentation
- Add VolumeBinder method to FrameworkHandle interface, which allows user to get the volume binder when implementing scheduler framework plugins. ([#86940](https://github.com/kubernetes/kubernetes/pull/86940), [@skilxn-go](https://github.com/skilxn-go))

  Courtesy of SIG Scheduling
- CustomResourceDefinition status fields are no longer required for client validation when submitting manifests. ([#87213](https://github.com/kubernetes/kubernetes/pull/87213), [@hasheddan](https://github.com/hasheddan))

  Courtesy of SIG API Machinery
- provider/azure: Network security groups can now be in a separate resource group. ([#87035](https://github.com/kubernetes/kubernetes/pull/87035), [@CecileRobertMichon](https://github.com/CecileRobertMichon))

  Courtesy of SIG Cloud Provider
- kubelet: resource metrics endpoint `/metrics/resource/v1alpha1` as well as all metrics under this endpoint have been deprecated.
  Please convert to the following metrics emitted by endpoint `/metrics/resource`:
  - scrape_error --> scrape_error
  - node_cpu_usage_seconds_total --> node_cpu_usage_seconds
  - node_memory_working_set_bytes --> node_memory_working_set_bytes
  - container_cpu_usage_seconds_total --> container_cpu_usage_seconds
  - container_memory_working_set_bytes --> container_memory_working_set_bytes
  - scrape_error --> scrape_error ([#86282](https://github.com/kubernetes/kubernetes/pull/86282), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Node
- You can now pass "--node-ip ::" to kubelet to indicate that it should autodetect an IPv6 address to use as the node's primary address. ([#85850](https://github.com/kubernetes/kubernetes/pull/85850), [@danwinship](https://github.com/danwinship))

  Courtesy of SIG Cloud Provider, SIG Network, and SIG Node
- kubeadm: support automatic retry after failing to pull image ([#86899](https://github.com/kubernetes/kubernetes/pull/86899), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- TODO ([#87044](https://github.com/kubernetes/kubernetes/pull/87044), [@jennybuckley](https://github.com/jennybuckley))

  Courtesy of SIG API Machinery
- Windows nodes on GCE can use TPM-based authentication to the master. ([#85466](https://github.com/kubernetes/kubernetes/pull/85466), [@pjh](https://github.com/pjh))

  Courtesy of SIG Cluster Lifecycle
- kubectl/drain: add disable-eviction option.
  Force drain to use delete, even if eviction is supported. This will bypass checking PodDisruptionBudgets, and should be used with caution. ([#85571](https://github.com/kubernetes/kubernetes/pull/85571), [@michaelgugino](https://github.com/michaelgugino))

  Courtesy of SIG CLI
- kubelet now exports a "server_expiration_renew_failure" and "client_expiration_renew_failure" metric counter if the certificate rotations cannot be performed. ([#84614](https://github.com/kubernetes/kubernetes/pull/84614), [@rphillips](https://github.com/rphillips))

  Courtesy of SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Node, and SIG Release
- kubeadm now supports automatic calculations of dual-stack node cidr masks to kube-controller-manager. ([#85609](https://github.com/kubernetes/kubernetes/pull/85609), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- kubeadm: reset raises warnings if it cannot delete folders ([#85265](https://github.com/kubernetes/kubernetes/pull/85265), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- kubeadm: add a upgrade health check that deploys a Job ([#81319](https://github.com/kubernetes/kubernetes/pull/81319), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- allow for configuration of CoreDNS replica count ([#85837](https://github.com/kubernetes/kubernetes/pull/85837), [@pickledrick](https://github.com/pickledrick))

  Courtesy of SIG Cluster Lifecycle
- Added the HPA API, that allows scale behavior to be configured through the HPA
  `behavior` field. Behaviors are specified separately for scaling up and down. In
  each direction a stabilization window can be specified as well as a list of
  policies and how to select amongst them. Policies can limit the absolute number
  of pods added or removed, or the percentage of pods added or removed. ([#74525](https://github.com/kubernetes/kubernetes/pull/74525), [@gliush](https://github.com/gliush))

  Courtesy of SIG API Machinery, SIG Apps, SIG Autoscaling, and SIG CLI
- SafeSysctlWhitelist: add net.ipv4.ping_group_range ([#85463](https://github.com/kubernetes/kubernetes/pull/85463), [@AkihiroSuda](https://github.com/AkihiroSuda))

  Courtesy of SIG Auth
- kubelet: the metric process_start_time_seconds be marked as with the ALPHA stability level. ([#85446](https://github.com/kubernetes/kubernetes/pull/85446), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node
- API request throttling (due to a high rate of requests) is now reported in the kubelet (and other component) logs by default.  The messages are of the form
  
  Throttling request took 1.50705208s, request: GET:<URL>
  
  The presence of large numbers of these messages, particularly with long delay times, may indicate to the administrator the need to tune the cluster accordingly. ([#80649](https://github.com/kubernetes/kubernetes/pull/80649), [@RobertKrawitz](https://github.com/RobertKrawitz))

  Courtesy of SIG API Machinery, and SIG Node
- kubectl/drain: add skip-wait-for-delete-timeout option.
  If pod DeletionTimestamp older than N seconds, skip waiting for the pod.  Seconds must be greater than 0 to skip. ([#85577](https://github.com/kubernetes/kubernetes/pull/85577), [@michaelgugino](https://github.com/michaelgugino))

  Courtesy of SIG CLI
- Following metrics have been turned off:
  - kubelet_pod_worker_latency_microseconds
  - kubelet_pod_start_latency_microseconds
  - kubelet_cgroup_manager_latency_microseconds
  - kubelet_pod_worker_start_latency_microseconds
  - kubelet_pleg_relist_latency_microseconds
  - kubelet_pleg_relist_interval_microseconds
  - kubelet_eviction_stats_age_microseconds
  - kubelet_runtime_operations
  - kubelet_runtime_operations_latency_microseconds
  - kubelet_runtime_operations_errors
  - kubelet_device_plugin_registration_count
  - kubelet_device_plugin_alloc_latency_microseconds
  - kubelet_docker_operations
  - kubelet_docker_operations_latency_microseconds
  - kubelet_docker_operations_errors
  - kubelet_docker_operations_timeout
  - network_plugin_operations_latency_microseconds ([#83841](https://github.com/kubernetes/kubernetes/pull/83841), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Network, and SIG Node


### API Changes

- `AlwaysCheckAllPredicates` is deprecated in scheduler Policy API. ([#86369](https://github.com/kubernetes/kubernetes/pull/86369), [@Huang-Wei](https://github.com/Huang-Wei))


### Notes from Multiple SIGs

#### SIG Cluster Lifecycle, and SIG Node

- Changed core_pattern on COS nodes to be an absolute path. ([#86329](https://github.com/kubernetes/kubernetes/pull/86329), [@mml](https://github.com/mml))

#### SIG API Machinery, SIG Apps, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Testing

- kube-apiserver no longer serves the following deprecated APIs:
  - All resources under `apps/v1beta1` and `apps/v1beta2` - use `apps/v1` instead
  - `daemonsets`, `deployments`, `replicasets` resources under `extensions/v1beta1` - use `apps/v1` instead
  - `networkpolicies` resources under `extensions/v1beta1` - use `networking.k8s.io/v1` instead
  - `podsecuritypolicies` resources under `extensions/v1beta1` - use `policy/v1beta1` instead ([#85903](https://github.com/kubernetes/kubernetes/pull/85903), [@liggitt](https://github.com/liggitt))

#### SIG Apps, and SIG Cloud Provider

- Fixed a bug which could prevent a provider ID from ever being set for node if an error occurred determining the provider ID when the node was added. ([#87043](https://github.com/kubernetes/kubernetes/pull/87043), [@zjs](https://github.com/zjs))

#### SIG Apps, and SIG Network

- Fix EndpointSlice controller race condition and ensure that it handles external changes to EndpointSlices. ([#85703](https://github.com/kubernetes/kubernetes/pull/85703), [@robscott](https://github.com/robscott))

#### SIG API Machinery, and SIG Testing

- Resolved regression in admission, authentication, and authorization webhook performance in v1.17.0-rc.1 ([#85810](https://github.com/kubernetes/kubernetes/pull/85810), [@liggitt](https://github.com/liggitt))

#### SIG API Machinery, SIG Auth, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node

- Renamed Kubelet metric certificate_manager_server_expiration_seconds to certificate_manager_server_ttl_seconds and changed to report the second until expiration at read time rather than absolute time of expiry.
  - Improved accuracy of Kubelet metric rest_client_exec_plugin_ttl_seconds. ([#85874](https://github.com/kubernetes/kubernetes/pull/85874), [@sambdavidson](https://github.com/sambdavidson))

#### SIG Cluster Lifecycle, SIG Instrumentation, SIG Scalability, and SIG Testing

- Remove cluster-monitoring addon ([#85512](https://github.com/kubernetes/kubernetes/pull/85512), [@serathius](https://github.com/serathius))

#### SIG API Machinery, SIG Auth, and SIG Cloud Provider

- Fixes issue where AAD token obtained by kubectl is incompatible with on-behalf-of flow and oidc.
  The audience claim before this fix has "spn:" prefix. After this fix, "spn:" prefix is omitted. ([#86412](https://github.com/kubernetes/kubernetes/pull/86412), [@weinong](https://github.com/weinong))

#### SIG Cluster Lifecycle, and SIG Windows

- Bind kube-dns containers to linux nodes to avoid Windows scheduling ([#83358](https://github.com/kubernetes/kubernetes/pull/83358), [@wawa0210](https://github.com/wawa0210))
- Bind dns-horizontal containers to linux nodes to avoid Windows scheduling on kubernetes cluster includes linux nodes and windows nodes ([#83364](https://github.com/kubernetes/kubernetes/pull/83364), [@wawa0210](https://github.com/wawa0210))

#### SIG Apps, and SIG Scheduling

- The following features are unconditionally enabled and the corresponding `--feature-gates` flags have been removed: `PodPriority`, `TaintNodesByCondition`, `ResourceQuotaScopeSelectors` and `ScheduleDaemonSetPods` ([#86210](https://github.com/kubernetes/kubernetes/pull/86210), [@draveness](https://github.com/draveness))

#### SIG API Machinery, SIG Cluster Lifecycle, SIG Instrumentation, SIG Network, SIG Node, and SIG Scheduling

- The following deprecated metrics are removed, please convert to the corresponding metrics:
  1. The following replacement metrics are available from v1.14.0:
  - `rest_client_request_latency_seconds` -> `rest_client_request_duration_seconds`
  - `scheduler_scheduling_latency_seconds` -> `scheduler_scheduling_duration_seconds `
  - `docker_operations` -> `docker_operations_total`
  - `docker_operations_latency_microseconds` -> `docker_operations_duration_seconds`
  - `docker_operations_errors` -> `docker_operations_errors_total`
  - `docker_operations_timeout` -> `docker_operations_timeout_total`
  - `network_plugin_operations_latency_microseconds` -> `network_plugin_operations_duration_seconds`
  - `kubelet_pod_worker_latency_microseconds` -> `kubelet_pod_worker_duration_seconds`
  - `kubelet_pod_start_latency_microseconds` -> `kubelet_pod_start_duration_seconds`
  - `kubelet_cgroup_manager_latency_microseconds` -> `kubelet_cgroup_manager_duration_seconds`
  - `kubelet_pod_worker_start_latency_microseconds` -> `kubelet_pod_worker_start_duration_seconds`
  - `kubelet_pleg_relist_latency_microseconds` -> `kubelet_pleg_relist_duration_seconds`
  - `kubelet_pleg_relist_interval_microseconds` -> `kubelet_pleg_relist_interval_seconds`
  - `kubelet_eviction_stats_age_microseconds` -> `kubelet_eviction_stats_age_seconds`
  - `kubelet_runtime_operations` -> `kubelet_runtime_operations_total`
  - `kubelet_runtime_operations_latency_microseconds` -> `kubelet_runtime_operations_duration_seconds`
  - `kubelet_runtime_operations_errors` -> `kubelet_runtime_operations_errors_total`
  - `kubelet_device_plugin_registration_count` -> `kubelet_device_plugin_registration_total`
  - `kubelet_device_plugin_alloc_latency_microseconds` -> `kubelet_device_plugin_alloc_duration_seconds`
  - `scheduler_e2e_scheduling_latency_microseconds` -> `scheduler_e2e_scheduling_duration_seconds`
  - `scheduler_scheduling_algorithm_latency_microseconds` -> `scheduler_scheduling_algorithm_duration_seconds`
  - `scheduler_scheduling_algorithm_predicate_evaluation` -> `scheduler_scheduling_algorithm_predicate_evaluation_seconds`
  - `scheduler_scheduling_algorithm_priority_evaluation` -> `scheduler_scheduling_algorithm_priority_evaluation_seconds`
  - `scheduler_scheduling_algorithm_preemption_evaluation` -> `scheduler_scheduling_algorithm_preemption_evaluation_seconds`
  - `scheduler_binding_latency_microseconds` -> `scheduler_binding_duration_seconds`
  - `kubeproxy_sync_proxy_rules_latency_microseconds` -> `kubeproxy_sync_proxy_rules_duration_seconds`
  - `apiserver_request_latencies` -> `apiserver_request_duration_seconds`
  - `apiserver_dropped_requests` -> `apiserver_dropped_requests_total`
  - `etcd_request_latencies_summary` -> `etcd_request_duration_seconds`
  - `apiserver_storage_transformation_latencies_microseconds ` -> `apiserver_storage_transformation_duration_seconds`
  - `apiserver_storage_data_key_generation_latencies_microseconds` -> `apiserver_storage_data_key_generation_duration_seconds`
  - `apiserver_request_count` -> `apiserver_request_total`
  - `apiserver_request_latencies_summary`
  2. The following replacement metrics are available from v1.15.0:
  - `apiserver_storage_transformation_failures_total` -> `apiserver_storage_transformation_operations_total` ([#76496](https://github.com/kubernetes/kubernetes/pull/76496), [@danielqsj](https://github.com/danielqsj))

#### SIG API Machinery, SIG Apps, and SIG Network

- Fix bug where EndpointSlice controller would attempt to modify shared objects. ([#85368](https://github.com/kubernetes/kubernetes/pull/85368), [@robscott](https://github.com/robscott))

#### SIG API Machinery, SIG Cluster Lifecycle, and SIG Instrumentation

- kube-apiserver: Fixes a bug that hidden metrics can not be enabled by the command-line option `--show-hidden-metrics-for-version`. ([#85444](https://github.com/kubernetes/kubernetes/pull/85444), [@RainbowMango](https://github.com/RainbowMango))

#### SIG Apps, SIG Testing, and SIG Windows

- Verify kubelet & kube-proxy can recover after being killed on Windows nodes ([#84886](https://github.com/kubernetes/kubernetes/pull/84886), [@YangLu1031](https://github.com/YangLu1031))

#### SIG API Machinery, and SIG Node

- For subprotocol negotiation, both client and server protocol is required now. ([#86646](https://github.com/kubernetes/kubernetes/pull/86646), [@tedyu](https://github.com/tedyu))

#### SIG Apps, SIG CLI, and SIG Testing

- Introduce Alpha field `Immutable` in both Secret and ConfigMap objects to mark their contents as immutable. The implementation is hidden behind feature gate `ImmutableEphemeralVolumes` (currently in Alpha stage). ([#86377](https://github.com/kubernetes/kubernetes/pull/86377), [@wojtek-t](https://github.com/wojtek-t))

#### SIG Node, and SIG Scalability

- hollow-node do not use remote CRI anymore ([#86425](https://github.com/kubernetes/kubernetes/pull/86425), [@jkaniuk](https://github.com/jkaniuk))

#### SIG Auth, and SIG Network

- Fixes kube-proxy when EndpointSlice feature gate is enabled on Windows. ([#86016](https://github.com/kubernetes/kubernetes/pull/86016), [@robscott](https://github.com/robscott))

#### SIG Network, and SIG Node

- fix a regression in kubenet that prevent pods to obtain ip addresses ([#85993](https://github.com/kubernetes/kubernetes/pull/85993), [@chendotjs](https://github.com/chendotjs))

#### SIG CLI, and SIG Storage

- Cleaned up the output from `kubectl describe CSINode <name>`. ([#85283](https://github.com/kubernetes/kubernetes/pull/85283), [@huffmanca](https://github.com/huffmanca))
- Includes FSType when describing CSI persistent volumes. ([#85293](https://github.com/kubernetes/kubernetes/pull/85293), [@huffmanca](https://github.com/huffmanca))

#### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node

- Bump golang/mock version to v1.3.1 ([#87326](https://github.com/kubernetes/kubernetes/pull/87326), [@wawa0210](https://github.com/wawa0210))
- Improved yaml parsing performance ([#85458](https://github.com/kubernetes/kubernetes/pull/85458), [@cjcullen](https://github.com/cjcullen))

#### SIG Cloud Provider, and SIG Storage

- fix: azure disk could not mounted on Standard_DC4s/DC2s instances ([#86612](https://github.com/kubernetes/kubernetes/pull/86612), [@andyzhangx](https://github.com/andyzhangx))
- fix azure file AuthorizationFailure ([#85475](https://github.com/kubernetes/kubernetes/pull/85475), [@andyzhangx](https://github.com/andyzhangx))
- Fixed "requested device X but found Y" attach error on AWS. ([#85675](https://github.com/kubernetes/kubernetes/pull/85675), [@jsafrane](https://github.com/jsafrane))

#### SIG Cluster Lifecycle, and SIG Instrumentation

- Fixed issue with addon-resizer using deprecated extensions APIs ([#85793](https://github.com/kubernetes/kubernetes/pull/85793), [@bskiba](https://github.com/bskiba))
- addons: elasticsearch discovery supports IPv6 ([#85543](https://github.com/kubernetes/kubernetes/pull/85543), [@SataQiu](https://github.com/SataQiu))

#### SIG Autoscaling, and SIG Cluster Lifecycle

- Update Cluster Autoscaler to 1.17.0; changelog: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.17.0 ([#85610](https://github.com/kubernetes/kubernetes/pull/85610), [@losipiuk](https://github.com/losipiuk))

#### SIG Cluster Lifecycle, SIG Instrumentation, and SIG Windows

- Bind metrics-server containers to linux nodes to avoid Windows scheduling on kubernetes cluster includes linux nodes and windows nodes ([#83362](https://github.com/kubernetes/kubernetes/pull/83362), [@wawa0210](https://github.com/wawa0210))
- Bind metadata-agent containers to linux nodes to avoid Windows scheduling on kubernetes cluster includes linux nodes and windows nodes ([#83363](https://github.com/kubernetes/kubernetes/pull/83363), [@wawa0210](https://github.com/wawa0210))

#### SIG API Machinery, SIG Architecture, SIG CLI, and SIG Testing

- The sample-apiserver aggregated conformance test has updated to use the Kubernetes v1.17.0 sample apiserver ([#84735](https://github.com/kubernetes/kubernetes/pull/84735), [@liggitt](https://github.com/liggitt))


### Notes from Individual SIGs

#### SIG API Machinery

- If a serving certificates param specifies a name that is an IP for an SNI certificate, it will have priority for replying to server connections. ([#85308](https://github.com/kubernetes/kubernetes/pull/85308), [@deads2k](https://github.com/deads2k))
- All apiservers log request lines in a more greppable format. ([#87203](https://github.com/kubernetes/kubernetes/pull/87203), [@lavalamp](https://github.com/lavalamp))
- Use context to check client closed instead of http.CloseNotifier in processing watch request which will reduce 1 goroutine for each request if proto is HTTP/2.x . ([#85408](https://github.com/kubernetes/kubernetes/pull/85408), [@answer1991](https://github.com/answer1991))
- Filter published OpenAPI schema by making nullable, required fields non-required in order to avoid kubectl to wrongly reject null values. ([#85722](https://github.com/kubernetes/kubernetes/pull/85722), [@sttts](https://github.com/sttts))
- kube-apiserver: fixed a conflict error encountered attempting to delete a pod with gracePeriodSeconds=0 and a resourceVersion precondition ([#85516](https://github.com/kubernetes/kubernetes/pull/85516), [@michaelgugino](https://github.com/michaelgugino))
- Resolves performance regression in `kubectl get all` and in client-go discovery clients constructed using `NewDiscoveryClientForConfig` or `NewDiscoveryClientForConfigOrDie`. ([#86168](https://github.com/kubernetes/kubernetes/pull/86168), [@liggitt](https://github.com/liggitt))
- Fix API Server potential memory leak issue in processing watch request. ([#85410](https://github.com/kubernetes/kubernetes/pull/85410), [@answer1991](https://github.com/answer1991))

#### SIG Apps

- fix a bug that orphan revision cannot be adopted and statefulset cannot be synced ([#86801](https://github.com/kubernetes/kubernetes/pull/86801), [@likakuli](https://github.com/likakuli))

#### SIG Auth

- Fixes service account token admission error in clusters that do not run the service account token controller ([#87029](https://github.com/kubernetes/kubernetes/pull/87029), [@liggitt](https://github.com/liggitt))

#### SIG CLI

- If a required flag is not provided to a command, the user will only see the required flag error message, instead of the entire usage menu. ([#86693](https://github.com/kubernetes/kubernetes/pull/86693), [@sallyom](https://github.com/sallyom))
- `kubectl apply  -f <file> --prune -n <namespace>` should prune all resources not defined in the file in the cli specified namespace. ([#85613](https://github.com/kubernetes/kubernetes/pull/85613), [@MartinKaburu](https://github.com/MartinKaburu))
- Fix a bug in port-forward: named port not working with service ([#85511](https://github.com/kubernetes/kubernetes/pull/85511), [@oke-py](https://github.com/oke-py))
- fix kubectl annotate error when local=true is set ([#86952](https://github.com/kubernetes/kubernetes/pull/86952), [@zhouya0](https://github.com/zhouya0))
- kubectl set resources will no longer return an error if passed an empty change for a resource. 
  kubectl set subject will no longer return an error if passed an empty change for a resource. ([#85490](https://github.com/kubernetes/kubernetes/pull/85490), [@sallyom](https://github.com/sallyom))
- kubectl drain node --dry-run will list pods that would be evicted or deleted ([#82660](https://github.com/kubernetes/kubernetes/pull/82660), [@sallyom](https://github.com/sallyom))

#### SIG Cloud Provider

- Fix the bug PIP's DNS is deleted if no DNS label service annotation isn't set. ([#87246](https://github.com/kubernetes/kubernetes/pull/87246), [@nilo19](https://github.com/nilo19))
- Fix issue &#35;85805 about resource not found in azure cloud provider when lb specified in other resource group. ([#86502](https://github.com/kubernetes/kubernetes/pull/86502), [@levimm](https://github.com/levimm))
- fix: azure data disk should use same key as os disk by default ([#86351](https://github.com/kubernetes/kubernetes/pull/86351), [@andyzhangx](https://github.com/andyzhangx))
- Minimize AWS NLB health check timeout when externalTrafficPolicy set to Local ([#73363](https://github.com/kubernetes/kubernetes/pull/73363), [@kellycampbell](https://github.com/kellycampbell))
- Fix nil pointer dereference in azure cloud provider ([#85975](https://github.com/kubernetes/kubernetes/pull/85975), [@ldx](https://github.com/ldx))
- Fixed the following 
  -  AWS Cloud Provider attempts to delete LoadBalancer security group it didn’t provision
  -  AWS Cloud Provider creates default LoadBalancer security group even if annotation [service.beta.kubernetes.io/aws-load-balancer-security-groups] is present ([#84265](https://github.com/kubernetes/kubernetes/pull/84265), [@bhagwat070919](https://github.com/bhagwat070919))
- Make error message and service event message more clear ([#86078](https://github.com/kubernetes/kubernetes/pull/86078), [@feiskyer](https://github.com/feiskyer))
- Fix IPv6 addresses lost issue in pure ipv6 vsphere environment ([#86001](https://github.com/kubernetes/kubernetes/pull/86001), [@hubv](https://github.com/hubv))
- VMSS cache is added so that less chances of VMSS GET throttling ([#85885](https://github.com/kubernetes/kubernetes/pull/85885), [@nilo19](https://github.com/nilo19))
- Fix LoadBalancer rule checking so that no unexpected LoadBalancer updates are made ([#85990](https://github.com/kubernetes/kubernetes/pull/85990), [@feiskyer](https://github.com/feiskyer))

#### SIG Cluster Lifecycle

- kubeadm upgrades always persist the etcd backup for stacked ([#86861](https://github.com/kubernetes/kubernetes/pull/86861), [@SataQiu](https://github.com/SataQiu))
- kubeadm: use bind-address option to configure the kube-controller-manager and kube-scheduler http probes ([#86493](https://github.com/kubernetes/kubernetes/pull/86493), [@aojea](https://github.com/aojea))
- Add instructions about how to bring up e2e test cluster ([#85836](https://github.com/kubernetes/kubernetes/pull/85836), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm: tolerate whitespace when validating certificate authority PEM data in kubeconfig files ([#86705](https://github.com/kubernetes/kubernetes/pull/86705), [@neolit123](https://github.com/neolit123))
- kubeadm: add support for the "ci/k8s-master" version label as a replacement for "ci-cross/*", which no longer exists. ([#86609](https://github.com/kubernetes/kubernetes/pull/86609), [@Pensu](https://github.com/Pensu))
- kubeadm: fix potential panic when executing "kubeadm reset" with a corrupted kubelet.conf file ([#86216](https://github.com/kubernetes/kubernetes/pull/86216), [@neolit123](https://github.com/neolit123))
- Bug fixes:
  Make sure we include latest packages node &#35;351 (@caseydavenport) ([#84163](https://github.com/kubernetes/kubernetes/pull/84163), [@david-tigera](https://github.com/david-tigera))
- kubeadm now errors out whenever a not supported component config version is supplied for the kubelet and kube-proxy ([#85639](https://github.com/kubernetes/kubernetes/pull/85639), [@rosti](https://github.com/rosti))
- Wait for kubelet & kube-proxy to be ready on Windows node within 10s ([#85228](https://github.com/kubernetes/kubernetes/pull/85228), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm: Forward cluster name to the controller-manager arguments ([#85817](https://github.com/kubernetes/kubernetes/pull/85817), [@ereslibre](https://github.com/ereslibre))
- kubeadm: uses the apiserver AdvertiseAddress IP family to choose the etcd endpoint IP family for non external etcd clusters ([#85745](https://github.com/kubernetes/kubernetes/pull/85745), [@aojea](https://github.com/aojea))
- kubeadm: don't write the kubelet environment file on "upgrade apply" ([#85412](https://github.com/kubernetes/kubernetes/pull/85412), [@boluisa](https://github.com/boluisa))
- kubeadm: retry `kubeadm-config` ConfigMap creation or mutation if the apiserver is not responding. This will improve resiliency when joining new control plane nodes. ([#85763](https://github.com/kubernetes/kubernetes/pull/85763), [@ereslibre](https://github.com/ereslibre))
- kubeadm: make sure images are pre-pulled even if a tag did not change but their contents changed ([#85603](https://github.com/kubernetes/kubernetes/pull/85603), [@bart0sh](https://github.com/bart0sh))
- During initialization phase (preflight), kubeadm now verifies the presence of the conntrack executable ([#85857](https://github.com/kubernetes/kubernetes/pull/85857), [@hnanni](https://github.com/hnanni))

#### SIG Network

- Fixes v1.17.0 regression in --service-cluster-ip-range handling with IPv4 ranges larger than 65536 IP addresses ([#86534](https://github.com/kubernetes/kubernetes/pull/86534), [@liggitt](https://github.com/liggitt))
- kubernetes will try to acquire the iptables lock every 100 msec during 5 seconds instead of every second. This specially useful for environments using kube-proxy in iptables mode with a high churn rate of services. ([#85771](https://github.com/kubernetes/kubernetes/pull/85771), [@aojea](https://github.com/aojea))
- Fixes wrong validation result of NetworkPolicy PolicyTypes ([#85747](https://github.com/kubernetes/kubernetes/pull/85747), [@tnqn](https://github.com/tnqn))
- kube-proxy no longer modifies shared EndpointSlices. ([#86092](https://github.com/kubernetes/kubernetes/pull/86092), [@robscott](https://github.com/robscott))

#### SIG Node

- change CounterVec to Counter about  PLEGDiscardEvent ([#86167](https://github.com/kubernetes/kubernetes/pull/86167), [@yiyang5055](https://github.com/yiyang5055))
- Fixes an issue with kubelet-reported pod status on deleted/recreated pods. ([#86320](https://github.com/kubernetes/kubernetes/pull/86320), [@liggitt](https://github.com/liggitt))
- OwnerReferences []OwnerReferencematches 
  so nil len(OwnerReferences) ==0 
  
  change:
   if lease.OwnerReferences == nil || len(lease.OwnerReferences) == 0 ==>if len(lease.OwnerReferences) == 0 ([#85789](https://github.com/kubernetes/kubernetes/pull/85789), [@ZP-AlwaysWin](https://github.com/ZP-AlwaysWin))
- Fixed a regression where the kubelet would fail to update the ready status of pods. ([#84951](https://github.com/kubernetes/kubernetes/pull/84951), [@tedyu](https://github.com/tedyu))

#### SIG Scheduling

- Marked scheduler's metrics scheduling_algorithm_predicate_evaluation_seconds and
  scheduling_algorithm_priority_evaluation_seconds as deprecated. Those are replaced by framework_extension_point_duration_seconds[extenstion_point="Filter"] and framework_extension_point_duration_seconds[extenstion_point="Score"] respectively. ([#86584](https://github.com/kubernetes/kubernetes/pull/86584), [@xiaoanyunfei](https://github.com/xiaoanyunfei))
- Marked scheduler's scheduling_duration_seconds Summary metric as deprecated ([#86586](https://github.com/kubernetes/kubernetes/pull/86586), [@xiaoanyunfei](https://github.com/xiaoanyunfei))
- Adds back support for AlwaysCheckAllPredicates flag. ([#86496](https://github.com/kubernetes/kubernetes/pull/86496), [@ahg-g](https://github.com/ahg-g))
- `AlwaysCheckAllPredicates` is deprecated in scheduler Policy API. ([#86369](https://github.com/kubernetes/kubernetes/pull/86369), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed an issue that the scheduler only returns the first failure reason. ([#86022](https://github.com/kubernetes/kubernetes/pull/86022), [@Huang-Wei](https://github.com/Huang-Wei))

#### SIG Storage

- Fixed a panic in the kubelet cleaning up pod volumes ([#86277](https://github.com/kubernetes/kubernetes/pull/86277), [@tedyu](https://github.com/tedyu))

#### SIG Testing

- e2e-test-framework: add e2e test namespace dump if all tests succeed but the cleanup fails. ([#85542](https://github.com/kubernetes/kubernetes/pull/85542), [@schrodit](https://github.com/schrodit))

#### SIG Windows

- Update go-winio module version from 0.4.11 to 0.4.14 ([#85739](https://github.com/kubernetes/kubernetes/pull/85739), [@wawa0210](https://github.com/wawa0210))



