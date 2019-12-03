## Action Required

- Renamed FeatureGate RequestManagement to APIPriorityAndFairness.  This feature gate is an alpha and has not yet been associated with any actual functionality.
  change references to feature gate RequestManagement into references to APIPriorityAndFairness ([#85260](https://github.com/kubernetes/kubernetes/pull/85260), [@MikeSpreitzer](https://github.com/MikeSpreitzer))

  Courtesy of SIG API Machinery
- kubeadm: add a new "kubelet-finalize" phase as part of the "init" workflow and an experimental sub-phase to enable automatic kubelet client certificate rotation on primary control-plane nodes.
  
  Prior to 1.17 and for existing nodes created by "kubeadm init" where kubelet client certificate rotation is desired, you must modify "/etc/kubernetes/kubelet.conf" to point to the PEM symlink for rotation:
  "client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem" and "client-key: /var/lib/kubelet/pki/kubelet-client-current.pem", replacing the embedded client certificate and key. ([#84118](https://github.com/kubernetes/kubernetes/pull/84118), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- kubeadm deprecates the use of the hyperkube image ([#85094](https://github.com/kubernetes/kubernetes/pull/85094), [@rosti](https://github.com/rosti))

  Courtesy of SIG Cluster Lifecycle
- Graduate ScheduleDaemonSetPods to GA. (feature gate will be removed in 1.18) action required. ([#82795](https://github.com/kubernetes/kubernetes/pull/82795), [@draveness](https://github.com/draveness))

  Courtesy of SIG Apps, SIG Scheduling, and SIG Testing
- Graduate TaintNodesByCondition to GA in 1.17. (feature gate will be removed in 1.18) action required ([#82703](https://github.com/kubernetes/kubernetes/pull/82703), [@draveness](https://github.com/draveness))

  Courtesy of SIG API Machinery, SIG Apps, SIG Cloud Provider, SIG Node, SIG Scheduling, and SIG Testing
- Expand scheduler priority functions and scheduling framework plugins' node score range to [0, 100]. action required. Note: this change is internal and does not affect extender and RequestedToCapacityRatio custom priority, which are still expected to provide a [0, 10] range. ([#83522](https://github.com/kubernetes/kubernetes/pull/83522), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling
- kubeadm: when adding extra apiserver authorization-modes, the defaults "Node,RBAC" are no longer prepended in the resulting static Pod manifests and a full override is allowed. ([#82616](https://github.com/kubernetes/kubernetes/pull/82616), [@ghouscht](https://github.com/ghouscht))

  Courtesy of SIG Cluster Lifecycle
- `kubeadm.k8s.io/v1beta1` has been deprecated, you should update your config to use newer non-deprecated API versions. ([#83276](https://github.com/kubernetes/kubernetes/pull/83276), [@Klaven](https://github.com/Klaven))

  Courtesy of SIG Cluster Lifecycle
- The deprecated feature gates `GCERegionalPersistentDisk`, `EnableAggregatedDiscoveryTimeout` and `PersistentLocalVolumes` are now unconditionally enabled and can no longer be specified in component invocations. ([#82472](https://github.com/kubernetes/kubernetes/pull/82472), [@draveness](https://github.com/draveness))

  Courtesy of SIG API Machinery, SIG Storage, and SIG Testing
- Deprecate the default service IP CIDR. The previous default was `10.0.0.0/24` which will be removed in 6 months/2 releases. Cluster admins must specify their own desired value, by using `--service-cluster-ip-range` on kube-apiserver. ([#81668](https://github.com/kubernetes/kubernetes/pull/81668), [@darshanime](https://github.com/darshanime))

  Courtesy of SIG API Machinery, and SIG Network
- Remove deprecated "include-uninitialized" flag. action required ([#80337](https://github.com/kubernetes/kubernetes/pull/80337), [@draveness](https://github.com/draveness))

  Courtesy of SIG CLI


## New Features

- kubeadm: add a upgrade health check that deploys a Job ([#81319](https://github.com/kubernetes/kubernetes/pull/81319), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- kubeadm now supports automatic calculations of dual-stack node cidr masks to kube-controller-manager. ([#85609](https://github.com/kubernetes/kubernetes/pull/85609), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- kubeadm: reset raises warnings if it cannot delete folders ([#85265](https://github.com/kubernetes/kubernetes/pull/85265), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- Promote CSIMigrationAWS to Beta (off by default since it requires installation of the AWS EBS CSI Driver)
  The in-tree AWS EBS plugin "kubernetes.io/aws-ebs" is now deprecated and will be removed in 1.21. Users should enable CSIMigration + CSIMigrationAWS features and install the AWS EBS CSI Driver (https://github.com/kubernetes-sigs/aws-ebs-csi-driver) to avoid disruption to existing Pod and PVC objects at that time.
  Users should start using the AWS EBS CSI CSI Driver directly for any new volumes. ([#85237](https://github.com/kubernetes/kubernetes/pull/85237), [@leakingtapan](https://github.com/leakingtapan))

  Courtesy of SIG Storage
- Following metrics have been turned off:
  - apiserver_request_count
  - apiserver_request_latencies
  - apiserver_request_latencies_summary
  - apiserver_dropped_requests
  - etcd_request_latencies_summary
  - apiserver_storage_transformation_latencies_microseconds
  - apiserver_storage_data_key_generation_latencies_microseconds
  - apiserver_storage_transformation_failures_total ([#83837](https://github.com/kubernetes/kubernetes/pull/83837), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, and SIG Testing
- The official kube-proxy image (used by kubeadm, among other things) is now
  compatible with systems running iptables 1.8 in "nft" mode, and will autodetect
  which mode it should use. ([#82966](https://github.com/kubernetes/kubernetes/pull/82966), [@danwinship](https://github.com/danwinship))

  Courtesy of SIG Network
- Kubenet: added HostPort IPv6 support
  HostPortManager: operates only with one IP family, failing if receives portmapping entries with different IP families
  HostPortSyncer: operates only with one IP family, skipping portmap entries with different IP families ([#80854](https://github.com/kubernetes/kubernetes/pull/80854), [@aojea](https://github.com/aojea))

  Courtesy of SIG Network, and SIG Node
- Feature gates CSIMigration to Beta (on by default) and CSIMigrationGCE to Beta (off by default since it requires installation of the GCE PD CSI Driver)
  The in-tree GCE PD plugin "kubernetes.io/gce-pd" is now deprecated and will be removed in 1.21. Users should enable CSIMigration + CSIMigrationGCE features and install the GCE PD CSI Driver (https://github.com/kubernetes-sigs/gcp-compute-persistent-disk-csi-driver) to avoid disruption to existing Pod and PVC objects at that time.
  Users should start using the GCE PD CSI CSI Driver directly for any new volumes. ([#85231](https://github.com/kubernetes/kubernetes/pull/85231), [@davidz627](https://github.com/davidz627))

  Courtesy of SIG Apps, SIG Auth, SIG Node, SIG Storage, and SIG Testing
- Following metrics have been turned off:
  - scheduler_scheduling_latency_seconds
  - scheduler_e2e_scheduling_latency_microseconds
  - scheduler_scheduling_algorithm_latency_microseconds
  - scheduler_scheduling_algorithm_predicate_evaluation
  - scheduler_scheduling_algorithm_priority_evaluation
  - scheduler_scheduling_algorithm_preemption_evaluation
  - scheduler_scheduling_binding_latency_microseconds ([#83838](https://github.com/kubernetes/kubernetes/pull/83838), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Scheduling
- Support Service Topology ([#72046](https://github.com/kubernetes/kubernetes/pull/72046), [@m1093782566](https://github.com/m1093782566))

  Courtesy of SIG Apps, SIG Auth, and SIG Network
- kube-controller-manager
  --node-cidr-mask-size-ipv4 int32     Default: 24. Mask size for IPv4 node-cidr in dual-stack cluster.
  --node-cidr-mask-size-ipv6 int32     Default: 64. Mask size for IPv6 node-cidr in dual-stack cluster.
  
  These 2 flags can be used only for dual-stack clusters. For non dual-stack clusters, continue to use
  --node-cidr-mask-size flag to configure the mask size.
  
  The default node cidr mask size for IPv6 was 24 which is now changed to 64. ([#79993](https://github.com/kubernetes/kubernetes/pull/79993), [@aramase](https://github.com/aramase))

  Courtesy of SIG API Machinery, SIG Apps, SIG Cloud Provider, SIG Network, and SIG Testing
- `--runtime-config` now supports an `api/beta=false` value which disables all built-in REST API versions matching `v[0-9]+beta[0-9]+`.
  `--feature-gates` now supports an `AllBeta=false` value which disables all beta feature gates. ([#84304](https://github.com/kubernetes/kubernetes/pull/84304), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, and SIG Cluster Lifecycle
- kube-proxy now supports DualStack feature with EndpointSlices and IPVS. ([#85246](https://github.com/kubernetes/kubernetes/pull/85246), [@robscott](https://github.com/robscott))

  Courtesy of SIG Network
- Bump CSI version to 1.2.0 ([#84832](https://github.com/kubernetes/kubernetes/pull/84832), [@gnufied](https://github.com/gnufied))

  Courtesy of SIG Storage
- Adds Windows Server build information as a label on the node. ([#84472](https://github.com/kubernetes/kubernetes/pull/84472), [@gab-satchi](https://github.com/gab-satchi))

  Courtesy of SIG Node, and SIG Windows
- Deprecated metric `kubeproxy_sync_proxy_rules_latency_microseconds` has been turned off. ([#83839](https://github.com/kubernetes/kubernetes/pull/83839), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Network
- Existing PVs are converted to use volume topology if migration is enabled. ([#83394](https://github.com/kubernetes/kubernetes/pull/83394), [@bertinatto](https://github.com/bertinatto))

  Courtesy of SIG Apps, SIG Scheduling, and SIG Storage
- Finalizer Protection for Service LoadBalancers is now in GA (enabled by default). This feature ensures the Service resource is not fully deleted until the correlating load balancer resources are deleted. ([#85023](https://github.com/kubernetes/kubernetes/pull/85023), [@MrHohn](https://github.com/MrHohn))

  Courtesy of SIG Apps, and SIG Network
- EndpointSlices are now beta and enabled by default for better Network Endpoint performance at scale. ([#84390](https://github.com/kubernetes/kubernetes/pull/84390), [@robscott](https://github.com/robscott))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, SIG Network, and SIG Testing
- New flag `--show-hidden-metrics-for-version` in kube-apiserver can be used to show all hidden metrics that deprecated in the previous minor release. ([#84292](https://github.com/kubernetes/kubernetes/pull/84292), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG Instrumentation
- The ResourceQuotaScopeSelectors feature has graduated to GA. The `ResourceQuotaScopeSelectors` feature gate is now unconditionally enabled and will be removed in 1.18. ([#82690](https://github.com/kubernetes/kubernetes/pull/82690), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling
- Pod process namespace sharing is now Generally Available. The `PodShareProcessNamespace` feature gate is now deprecated and will be removed in Kubernetes 1.19. ([#84356](https://github.com/kubernetes/kubernetes/pull/84356), [@verb](https://github.com/verb))

  Courtesy of SIG Apps, SIG Node, and SIG Testing
- add RequiresExactMatch for label.Selector ([#85048](https://github.com/kubernetes/kubernetes/pull/85048), [@shaloulcy](https://github.com/shaloulcy))

  Courtesy of SIG API Machinery
- Deprecated metric `rest_client_request_latency_seconds` has been turned off. ([#83836](https://github.com/kubernetes/kubernetes/pull/83836), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG Instrumentation
- Removed dependency on kubectl from several storage E2E tests ([#84042](https://github.com/kubernetes/kubernetes/pull/84042), [@okartau](https://github.com/okartau))

  Courtesy of SIG Storage, and SIG Testing
- Add plugin_execution_duration_seconds metric for scheduler framework plugins. ([#84522](https://github.com/kubernetes/kubernetes/pull/84522), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG Scheduling
- Node-specific volume limits has graduated to GA. ([#83568](https://github.com/kubernetes/kubernetes/pull/83568), [@bertinatto](https://github.com/bertinatto))

  Courtesy of SIG Auth, SIG Node, SIG Scheduling, SIG Storage, and SIG Testing
- Adds a new label to indicate what is managing an EndpointSlice. ([#83965](https://github.com/kubernetes/kubernetes/pull/83965), [@robscott](https://github.com/robscott))

  Courtesy of SIG Apps, and SIG Network
- Enables VolumeSnapshotDataSource feature gate and promotes volume snapshot APIs to beta. ([#80058](https://github.com/kubernetes/kubernetes/pull/80058), [@xing-yang](https://github.com/xing-yang))

  Courtesy of SIG Cluster Lifecycle, SIG Storage, and SIG Testing
- kubeadm alpha certs command now skip missing files ([#85092](https://github.com/kubernetes/kubernetes/pull/85092), [@fabriziopandini](https://github.com/fabriziopandini))

  Courtesy of SIG Cluster Lifecycle
- A new flag "progress-report-url" has been added to the test context which allows progress information about the test run to be sent to a webhook. In addition, this information is printed to stdout to aid in users watching the logs. ([#84524](https://github.com/kubernetes/kubernetes/pull/84524), [@johnSchnake](https://github.com/johnSchnake))

  Courtesy of SIG Testing
- Following metrics from kubelet are now marked as with the ALPHA stability level:
  node_cpu_usage_seconds_total
  node_memory_working_set_bytes
  container_cpu_usage_seconds_total
  container_memory_working_set_bytes
  scrape_error ([#84987](https://github.com/kubernetes/kubernetes/pull/84987), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node
- Following metrics from kubelet are now marked as with the ALPHA stability level:
  kubelet_container_log_filesystem_used_bytes
  kubelet_volume_stats_capacity_bytes
  kubelet_volume_stats_available_bytes
  kubelet_volume_stats_used_bytes
  kubelet_volume_stats_inodes
  kubelet_volume_stats_inodes_free
  kubelet_volume_stats_inodes_used
  plugin_manager_total_plugins
  volume_manager_total_volumes ([#84907](https://github.com/kubernetes/kubernetes/pull/84907), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Node
- kubeadm: enable the usage of the secure kube-scheduler and kube-controller-manager ports for health checks. For kube-scheduler was 10251, becomes 10259. For kube-controller-manager was 10252, becomes 10257. ([#85043](https://github.com/kubernetes/kubernetes/pull/85043), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- Mirror pods now include an ownerReference for the node that created them. ([#84485](https://github.com/kubernetes/kubernetes/pull/84485), [@tallclair](https://github.com/tallclair))

  Courtesy of SIG Node, and SIG Testing
- kubeadm: the command "kubeadm token create" now has a "--certificate-key" flag that can be used for the formation of join commands for control-planes with automatic copy of certificates ([#84591](https://github.com/kubernetes/kubernetes/pull/84591), [@TheLastProject](https://github.com/TheLastProject))

  Courtesy of SIG Cluster Lifecycle
- Promote NodeLease feature to GA.
  The feature make Lease object changes an additional healthiness signal from Node. Together with that, we reduce frequency of NodeStatus updates to 5m by default in case of no changes to status itself ([#84351](https://github.com/kubernetes/kubernetes/pull/84351), [@wojtek-t](https://github.com/wojtek-t))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG Node, and SIG Testing
- Following metrics from kube-controller-manager are now marked as with the ALPHA stability level:
  storage_count_attachable_volumes_in_use
  attachdetach_controller_total_volumes
  pv_collector_bound_pv_count
  pv_collector_unbound_pv_count
  pv_collector_bound_pvc_count
  pv_collector_unbound_pvc_count ([#84896](https://github.com/kubernetes/kubernetes/pull/84896), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Apps
- Updated EndpointSlices to use PublishNotReadyAddresses from Services. ([#84573](https://github.com/kubernetes/kubernetes/pull/84573), [@robscott](https://github.com/robscott))

  Courtesy of SIG Apps, and SIG Network
- A new kubelet command line option, --reserved-cpus, is introduced to explicitly define the the CPU list that will be reserved for system. For example, if --reserved-cpus=0,1,2,3 is specified, then cpu 0,1,2,3 will be reserved for the system.  On a system with 24 CPUs, the user may specify isolcpus=4-23 for the kernel option and use CPU 4-23 for the user containers. ([#83592](https://github.com/kubernetes/kubernetes/pull/83592), [@jianzzha](https://github.com/jianzzha))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG Node
- Profiling is enabled by default in the scheduler ([#84835](https://github.com/kubernetes/kubernetes/pull/84835), [@denkensk](https://github.com/denkensk))

  Courtesy of SIG Scheduling
- Adding initial EndpointSlice metrics. ([#83257](https://github.com/kubernetes/kubernetes/pull/83257), [@robscott](https://github.com/robscott))

  Courtesy of SIG Apps, and SIG Network
- add azure disk encryption(SSE+CMK) support ([#84605](https://github.com/kubernetes/kubernetes/pull/84605), [@andyzhangx](https://github.com/andyzhangx))

  Courtesy of SIG Cloud Provider, and SIG Storage
- Reduce default NodeStatusReportFrequency to 5 minutes. With this change, periodic node status updates will be send every 5m if node status doesn't change (otherwise they are still send with 10s).
  
  Bump NodeProblemDetector version to v0.8.0 to reduce forced NodeStatus updates frequency to 5 minutes. ([#84007](https://github.com/kubernetes/kubernetes/pull/84007), [@wojtek-t](https://github.com/wojtek-t))

  Courtesy of SIG Cluster Lifecycle, SIG Node, SIG Scalability, and SIG Testing
- CSI Topology feature is GA. The CSINodeInfo feature gate is deprecated and will be removed in a future release. The storage.k8s.io/v1beta1 CSINode object is deprecated and will be removed in a future release. ([#83474](https://github.com/kubernetes/kubernetes/pull/83474), [@msau42](https://github.com/msau42))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, SIG Storage, and SIG Testing
- Added kubelet serving certificate metric `server_rotation_seconds` which is a histogram reporting the age of a just rotated serving certificate in seconds. ([#84534](https://github.com/kubernetes/kubernetes/pull/84534), [@sambdavidson](https://github.com/sambdavidson))

  Courtesy of SIG API Machinery, SIG Auth, SIG Instrumentation, and SIG Node
- local: support local filesystem volume with block resource reconstruction ([#84218](https://github.com/kubernetes/kubernetes/pull/84218), [@cofyc](https://github.com/cofyc))

  Courtesy of SIG Node, SIG Storage, and SIG Testing
- kubelet: a configuration file specified via `--config` is now loaded with strict deserialization, which fails if the config file contains duplicate or unknown fields. This protects against accidentally running with config files that are malformed, mis-indented, or have typos in field names, and getting unexpected behavior. ([#83204](https://github.com/kubernetes/kubernetes/pull/83204), [@obitech](https://github.com/obitech))

  Courtesy of SIG Cluster Lifecycle, and SIG Node
- kubeadm now propagates proxy environment variables to kube-proxy ([#84559](https://github.com/kubernetes/kubernetes/pull/84559), [@yastij](https://github.com/yastij))

  Courtesy of SIG Cluster Lifecycle
- Reload apiserver SNI certificates from disk every minute ([#84303](https://github.com/kubernetes/kubernetes/pull/84303), [@jackkleeman](https://github.com/jackkleeman))

  Courtesy of SIG API Machinery, and SIG Testing
- Update Azure SDK versions to v35.0.0 ([#84543](https://github.com/kubernetes/kubernetes/pull/84543), [@andyzhangx](https://github.com/andyzhangx))

  Courtesy of SIG Cloud Provider
- Scheduler now reports metrics on cache size including nodes, pods, and assumed pods ([#83508](https://github.com/kubernetes/kubernetes/pull/83508), [@damemi](https://github.com/damemi))

  Courtesy of SIG Instrumentation, and SIG Scheduling
- azure: Add allow unsafe read from cache ([#83685](https://github.com/kubernetes/kubernetes/pull/83685), [@aramase](https://github.com/aramase))

  Courtesy of SIG Cloud Provider
- update the latest validated version of Docker to 19.03 ([#84476](https://github.com/kubernetes/kubernetes/pull/84476), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- User can now use component config to configure NodeLabel plugin for the scheduler framework. ([#84297](https://github.com/kubernetes/kubernetes/pull/84297), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG Scheduling
- Pod labels can no longer be updated through the pod/status updates by nodes. ([#84260](https://github.com/kubernetes/kubernetes/pull/84260), [@tallclair](https://github.com/tallclair))

  Courtesy of SIG Auth, and SIG Node
- Reload apiserver serving certificate from disk every minute ([#84200](https://github.com/kubernetes/kubernetes/pull/84200), [@jackkleeman](https://github.com/jackkleeman))

  Courtesy of SIG API Machinery, SIG Auth, SIG Node, and SIG Testing
- Adds FQDN addressType support for EndpointSlice. ([#84091](https://github.com/kubernetes/kubernetes/pull/84091), [@robscott](https://github.com/robscott))

  Courtesy of SIG API Machinery, and SIG Network
- Add permit_wait_duration_seconds metric for scheduler. ([#84011](https://github.com/kubernetes/kubernetes/pull/84011), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG Scheduling
- Optimize inter-pod affinity preferredDuringSchedulingIgnoredDuringExecution type, up to 4x in some cases. ([#84264](https://github.com/kubernetes/kubernetes/pull/84264), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling
- filter plugin for cloud provider storage predicate ([#84148](https://github.com/kubernetes/kubernetes/pull/84148), [@gongguan](https://github.com/gongguan))

  Courtesy of SIG Scheduling, and SIG Testing
- Fixed binding of block PersistentVolumes / PersistentVolumeClaims when BlockVolume feature is off. ([#84049](https://github.com/kubernetes/kubernetes/pull/84049), [@jsafrane](https://github.com/jsafrane))

  Courtesy of SIG Apps, and SIG Storage
- Refactor scheduler's framework permit API. ([#83756](https://github.com/kubernetes/kubernetes/pull/83756), [@hex108](https://github.com/hex108))

  Courtesy of SIG Scheduling, and SIG Testing
- The kubectl's api-resource command now has a `--sort-by` flag to sort resources by name or kind. ([#81971](https://github.com/kubernetes/kubernetes/pull/81971), [@laddng](https://github.com/laddng))

  Courtesy of SIG CLI
- Update to Ingress-GCE v1.6.1 ([#84018](https://github.com/kubernetes/kubernetes/pull/84018), [@rramkumar1](https://github.com/rramkumar1))

  Courtesy of SIG Cluster Lifecycle
- When scaling down a ReplicaSet, delete doubled up replicas first, where a "doubled up replica" is defined as one that is on the same node as an active replica belonging to a related ReplicaSet.  ReplicaSets are considered "related" if they have a common controller (typically a Deployment). ([#80004](https://github.com/kubernetes/kubernetes/pull/80004), [@Miciah](https://github.com/Miciah))

  Courtesy of SIG Apps, SIG Autoscaling, SIG Scalability, and SIG Testing
- kubeadm: enhance certs check-expiration to show the expiration info of related CAs ([#83932](https://github.com/kubernetes/kubernetes/pull/83932), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- Add incoming pods metrics to scheduler queue. ([#83577](https://github.com/kubernetes/kubernetes/pull/83577), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG Scheduling
- Allow dynamically set glog logging level of kube-scheduler ([#83910](https://github.com/kubernetes/kubernetes/pull/83910), [@mrkm4ntr](https://github.com/mrkm4ntr))

  Courtesy of SIG Scheduling
- Add latency and request count metrics for scheduler framework. ([#83569](https://github.com/kubernetes/kubernetes/pull/83569), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG Scheduling
- ETCD version monitor metrics are now marked as with the ALPHA stability level. ([#83283](https://github.com/kubernetes/kubernetes/pull/83283), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG Cluster Lifecycle
- A new `--prefix` flag added into `kubectl logs` which prepends each log line with information about it's source (pod name and container name) ([#76471](https://github.com/kubernetes/kubernetes/pull/76471), [@m1kola](https://github.com/m1kola))

  Courtesy of SIG CLI
- Change `pod_preemption_victims` metric from Gauge to Histogram. ([#83603](https://github.com/kubernetes/kubernetes/pull/83603), [@Tabrizian](https://github.com/Tabrizian))

  Courtesy of SIG Scheduling
- Expose SharedInformerFactory in the framework handle ([#83663](https://github.com/kubernetes/kubernetes/pull/83663), [@draveness](https://github.com/draveness))

  Courtesy of SIG Apps, SIG Scheduling, and SIG Testing
- The topology manager aligns resources for pods of all QoS classes with respect to NUMA locality, not just Guaranteed QoS pods. ([#83492](https://github.com/kubernetes/kubernetes/pull/83492), [@ConnorDoyle](https://github.com/ConnorDoyle))

  Courtesy of SIG Node
- Add per-pod scheduling metrics across 1 or more schedule attempts. ([#83674](https://github.com/kubernetes/kubernetes/pull/83674), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG Scheduling
- The mutating and validating admission webhook plugins now read configuration from the admissionregistration.k8s.io/v1 API. ([#80883](https://github.com/kubernetes/kubernetes/pull/80883), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery
- kubeadm: implemented structured output of 'kubeadm token list' in JSON, YAML, Go template and JsonPath formats ([#78764](https://github.com/kubernetes/kubernetes/pull/78764), [@bart0sh](https://github.com/bart0sh))

  Courtesy of SIG Cluster Lifecycle
- kube-proxy: a configuration file specified via `--config` is now loaded with strict deserialization, which fails if the config file contains duplicate or unknown fields. This protects against accidentally running with config files that are malformed, mis-indented, or have typos in field names, and getting unexpected behavior. ([#82927](https://github.com/kubernetes/kubernetes/pull/82927), [@obitech](https://github.com/obitech))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG Network
- Add "podInitialBackoffDurationSeconds" and "podMaxBackoffDurationSeconds" to the scheduler config API ([#81263](https://github.com/kubernetes/kubernetes/pull/81263), [@draveness](https://github.com/draveness))

  Courtesy of SIG Apps, and SIG Scheduling
- Expose kubernetes client in the scheduling framework handle. ([#82432](https://github.com/kubernetes/kubernetes/pull/82432), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling
- Kubeadm: add support for 127.0.0.1 as advertise address. kubeadm will automatically replace this value with matching global unicast IP address on the loopback interface. ([#83475](https://github.com/kubernetes/kubernetes/pull/83475), [@fabriziopandini](https://github.com/fabriziopandini))

  Courtesy of SIG API Machinery, and SIG Cluster Lifecycle
- kube-scheduler: a configuration file specified via `--config` is now loaded with strict deserialization, which fails if the config file contains duplicate or unknown fields. This protects against accidentally running with config files that are malformed, mis-indented, or have typos in field names, and getting unexpected behavior. ([#83030](https://github.com/kubernetes/kubernetes/pull/83030), [@obitech](https://github.com/obitech))

  Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG Scheduling
- Bump version of event-exporter to 0.3.1, to switch it to protobuf. ([#83396](https://github.com/kubernetes/kubernetes/pull/83396), [@loburm](https://github.com/loburm))

  Courtesy of SIG Instrumentation, and SIG Scalability
- kubeadm: use the --service-cluster-ip-range flag to init or use the ServiceSubnet field in the kubeadm config to pass a comma separated list of Service CIDRs. ([#82473](https://github.com/kubernetes/kubernetes/pull/82473), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- Remove MaxPriority in the scheduler API, please use MaxNodeScore or MaxExtenderPriority instead. ([#83386](https://github.com/kubernetes/kubernetes/pull/83386), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- Update crictl to v1.16.1. ([#82856](https://github.com/kubernetes/kubernetes/pull/82856), [@Random-Liu](https://github.com/Random-Liu))

  Courtesy of SIG Cluster Lifecycle, and SIG Node
- Reduces the number of calls made to the Azure API when requesting the instance view of a virtual machine scale set node. ([#82496](https://github.com/kubernetes/kubernetes/pull/82496), [@hasheddan](https://github.com/hasheddan))

  Courtesy of SIG Cloud Provider
- Consolidate ScoreWithNormalizePlugin into the ScorePlugin interface ([#83042](https://github.com/kubernetes/kubernetes/pull/83042), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- New APIs to allow adding/removing pods from pre-calculated prefilter state in the scheduling framework ([#82912](https://github.com/kubernetes/kubernetes/pull/82912), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling, and SIG Testing
- Added metrics 'authentication_latency_seconds' that can be used to understand the latency of authentication. ([#82409](https://github.com/kubernetes/kubernetes/pull/82409), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, SIG Auth, and SIG Instrumentation
- Added Clone method to the scheduling framework's PluginContext and ContextData. ([#82951](https://github.com/kubernetes/kubernetes/pull/82951), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling
- Modified the scheduling framework's Filter API. ([#82842](https://github.com/kubernetes/kubernetes/pull/82842), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling, and SIG Testing
- Added cloud operation count metrics to azure cloud controller manager. ([#82574](https://github.com/kubernetes/kubernetes/pull/82574), [@kkmsft](https://github.com/kkmsft))

  Courtesy of SIG Cloud Provider
- When registering with a 1.17+ API server, MutatingWebhookConfiguration and ValidatingWebhookConfiguration objects can now request that only `v1` AdmissionReview requests be sent to them. Previously, webhooks were required to support receiving `v1beta1` AdmissionReview requests as well for compatibility with API servers <= 1.15.
  - When registering with a 1.17+ API server, a CustomResourceDefinition conversion webhook can now request that only `v1` ConversionReview requests be sent to them. Previously, conversion webhooks were required to support receiving `v1beta1` ConversionReview requests as well for compatibility with API servers <= 1.15. ([#82707](https://github.com/kubernetes/kubernetes/pull/82707), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery
- /test/e2e/framework: Adds a flag "non-blocking-taints" which allows tests to run in environments with tainted nodes. String value should be a comma-separated list. ([#81043](https://github.com/kubernetes/kubernetes/pull/81043), [@johnSchnake](https://github.com/johnSchnake))

  Courtesy of SIG Testing


## API Changes

- Implement the documented API semantics of list-type and map-type atomic to reject non-atomic sub-types. ([#84722](https://github.com/kubernetes/kubernetes/pull/84722), [@sttts](https://github.com/sttts))
- kube-apiserver: The `AdmissionConfiguration` type accepted by `--admission-control-config-file` has been promoted to `apiserver.config.k8s.io/v1` with no schema changes. ([#85098](https://github.com/kubernetes/kubernetes/pull/85098), [@liggitt](https://github.com/liggitt))
- All resources within the rbac.authorization.k8s.io/v1alpha1 and rbac.authorization.k8s.io/v1beta1 API groups are deprecated in favor of rbac.authorization.k8s.io/v1, and will no longer be served in v1.20. ([#84758](https://github.com/kubernetes/kubernetes/pull/84758), [@liggitt](https://github.com/liggitt))
- Fixed EndpointSlice port name validation to match Endpoint port name validation (allowing port names longer than 15 characters) ([#84481](https://github.com/kubernetes/kubernetes/pull/84481), [@robscott](https://github.com/robscott))
- Introduce x-kubernetes-map-type annotation as a CRD API extension. Enables this particular validation for server-side apply. ([#84113](https://github.com/kubernetes/kubernetes/pull/84113), [@enxebre](https://github.com/enxebre))
- Promote WatchBookmark feature to GA.
  With WatchBookmark feature, clients are able to request watch events with BOOKMARK type. Clients should not assume bookmarks are returned at any specific interval, nor may they assume the server will send any BOOKMARK event during a session. ([#83195](https://github.com/kubernetes/kubernetes/pull/83195), [@wojtek-t](https://github.com/wojtek-t))


## Notes From Multiple SIGs

### SIG Cluster Lifecycle, and SIG Instrumentation

- addons: elasticsearch discovery supports IPv6 ([#85543](https://github.com/kubernetes/kubernetes/pull/85543), [@SataQiu](https://github.com/SataQiu))
- Bumps metrics-server version to v0.3.6 with following bugfix:
  
  -  Don't break metric storage when duplicate pod metrics encountered causing hpa to fail ([#83907](https://github.com/kubernetes/kubernetes/pull/83907), [@olagacek](https://github.com/olagacek))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Cloud Provider, and SIG Scheduling

- Migrate controller-manager and scheduler to EndpointsLeases leader election. ([#84084](https://github.com/kubernetes/kubernetes/pull/84084), [@wojtek-t](https://github.com/wojtek-t))

### SIG Auth, and SIG Node

- k8s dockerconfigjson secrets are now compatible with docker config desktop authentication credentials files ([#82148](https://github.com/kubernetes/kubernetes/pull/82148), [@bbourbie](https://github.com/bbourbie))

### SIG Cluster Lifecycle, and SIG Release

- Simple script based hyperkube image that bundles all the necessary binaries. This is a equivalent replacement for the image based on the go based hyperkube command + image. ([#84662](https://github.com/kubernetes/kubernetes/pull/84662), [@dims](https://github.com/dims))
- hyperkube will now be available in a new github repository and will not be included in the kubernetes release from 1.17 onwards ([#83454](https://github.com/kubernetes/kubernetes/pull/83454), [@dims](https://github.com/dims))

### SIG Architecture, and SIG Testing

- Conformance tests may now include disruptive tests. If you are running tests against a live cluster, consider skipping those tests tagged as `Disruptive` to avoid non-test workloads being impacted. Be aware, skipping any conformance tests (even disruptive ones) will make the results ineligible for consideration for the CNCF Certified Kubernetes program. ([#82664](https://github.com/kubernetes/kubernetes/pull/82664), [@johnSchnake](https://github.com/johnSchnake))

### SIG CLI, and SIG Network

- Fix incorrect network policy description suggesting that pods are isolated when a network policy has no rules of a given type ([#84194](https://github.com/kubernetes/kubernetes/pull/84194), [@jackkleeman](https://github.com/jackkleeman))

### SIG API Machinery, SIG Auth, SIG Node, and SIG Testing

- kubelet and aggregated API servers now use v1 TokenReview and SubjectAccessReview endpoints to check authentication/authorization.
  - kube-apiserver can now specify `--authentication-token-webhook-version=v1` or `--authorization-webhook-version=v1` to use `v1` TokenReview and SubjectAccessReview API objects when communicating with authentication and authorization webhooks. ([#84768](https://github.com/kubernetes/kubernetes/pull/84768), [@liggitt](https://github.com/liggitt))
- client-ca bundles for the all generic-apiserver based servers will dynamically reload from disk on content changes ([#83579](https://github.com/kubernetes/kubernetes/pull/83579), [@deads2k](https://github.com/deads2k))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Scheduling

- kube-scheduler: emits a warning when a malformed component config file is used with v1alpha1. ([#84129](https://github.com/kubernetes/kubernetes/pull/84129), [@obitech](https://github.com/obitech))

### SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, and SIG Node

- The certificate signer no longer accepts ca.key passwords via the CFSSL_CA_PK_PASSWORD environment variable. This capability was not prompted by user request, never advertised, and recommended against in the security audit. ([#84677](https://github.com/kubernetes/kubernetes/pull/84677), [@mikedanese](https://github.com/mikedanese))

### SIG API Machinery, SIG Apps, SIG Scheduling, and SIG Testing

- kube-scheduler now fallbacks to emitting events using core/v1 Events when events.k8s.io/v1beta1 is disabled. ([#83692](https://github.com/kubernetes/kubernetes/pull/83692), [@yastij](https://github.com/yastij))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Autoscaling, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Network, SIG Node, SIG Scheduling, SIG Storage, and SIG Testing

- Update etcd client side to v3.4.3
  Deprecated prometheus request meta-metrics have been removed (http_request_duration_microseconds, http_request_duration_microseconds_sum, http_request_duration_microseconds_count, http_request_size_bytes, http_request_size_bytes_sum, http_request_size_bytes_count, http_requests_total, http_response_size_bytes, http_response_size_bytes_sum, http_response_size_bytes_count) due to removal from the prometheus client library. Prometheus http request meta-metrics are now generated from [promhttp.InstrumentMetricHandler](https://godoc.org/github.com/prometheus/client_golang/prometheus/promhttp&#35;InstrumentMetricHandler) instead. ([#83987](https://github.com/kubernetes/kubernetes/pull/83987), [@wenjiaswe](https://github.com/wenjiaswe))

### SIG API Machinery, SIG Apps, and SIG Network

- Fix bug where EndpointSlice controller would attempt to modify shared objects. ([#85368](https://github.com/kubernetes/kubernetes/pull/85368), [@robscott](https://github.com/robscott))

### SIG API Machinery, and SIG Auth

- Resolves error from v1.17.0-beta.2 with --authorizer-mode webhook complaining about an invalid version ([#85441](https://github.com/kubernetes/kubernetes/pull/85441), [@liggitt](https://github.com/liggitt))
- Fix a racing issue in client-go UpdateTransportConfig. ([#80284](https://github.com/kubernetes/kubernetes/pull/80284), [@danielqsj](https://github.com/danielqsj))
- Authentication token cache size is increased (from 4k to 32k) to support clusters with many nodes or many namespaces with active service accounts. ([#83643](https://github.com/kubernetes/kubernetes/pull/83643), [@lavalamp](https://github.com/lavalamp))

### SIG Apps, SIG Auth, SIG Cloud Provider, SIG Node, and SIG Scheduling

- Deprecate the instance type beta label ("beta.kubernetes.io/instance-type") in favor of it's GA equivalent: "node.kubernetes.io/instance-type" ([#82049](https://github.com/kubernetes/kubernetes/pull/82049), [@andrewsykim](https://github.com/andrewsykim))

### SIG Cluster Lifecycle, and SIG Testing

- Remove prometheus cluster monitoring addon from kube-up ([#83442](https://github.com/kubernetes/kubernetes/pull/83442), [@serathius](https://github.com/serathius))

### SIG Autoscaling, and SIG Cluster Lifecycle

- Update Cluster Autoscaler to 1.17.0; changelog: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.17.0 ([#85610](https://github.com/kubernetes/kubernetes/pull/85610), [@losipiuk](https://github.com/losipiuk))

### SIG API Machinery, SIG Auth, and SIG Testing

- apiservers based on k8s.io/apiserver with delegated authn based on cluster authentication will automatically update to new authentication information when the authoritative configmap is updated. ([#85004](https://github.com/kubernetes/kubernetes/pull/85004), [@deads2k](https://github.com/deads2k))
- configmaps/extension-apiserver-authentication in kube-system is continuously updated by kube-apiservers, instead of just at apiserver start ([#82705](https://github.com/kubernetes/kubernetes/pull/82705), [@deads2k](https://github.com/deads2k))

### SIG Cluster Lifecycle, and SIG Node

- sourcesReady provides the readiness of kubelet configuration sources such as apiserver update readiness. ([#81344](https://github.com/kubernetes/kubernetes/pull/81344), [@zouyee](https://github.com/zouyee))

### SIG Release, and SIG Testing

- Update to use go1.12.12 ([#84064](https://github.com/kubernetes/kubernetes/pull/84064), [@cblecker](https://github.com/cblecker))
- Update to go 1.12.10 ([#83139](https://github.com/kubernetes/kubernetes/pull/83139), [@cblecker](https://github.com/cblecker))
- The deprecated mondo `kubernetes-test` tarball is no longer built. Users running Kubernetes e2e tests should use the `kubernetes-test-portable` and `kubernetes-test-{OS}-{ARCH}` tarballs instead. ([#83093](https://github.com/kubernetes/kubernetes/pull/83093), [@ixdy](https://github.com/ixdy))

### SIG Apps, SIG Node, SIG Storage, and SIG Testing

- The VolumeSubpathEnvExpansion feature is graduating to GA. The `VolumeSubpathEnvExpansion` feature gate is unconditionally enabled, and will be removed in v1.19. ([#82578](https://github.com/kubernetes/kubernetes/pull/82578), [@kevtaylor](https://github.com/kevtaylor))

### SIG Cloud Provider, SIG Network, and SIG Node

- On AWS nodes with multiple network interfaces, kubelet should now more reliably report the same primary node IP. ([#80747](https://github.com/kubernetes/kubernetes/pull/80747), [@danwinship](https://github.com/danwinship))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Instrumentation

- kube-apiserver: Fixes a bug that hidden metrics can not be enabled by the command-line option `--show-hidden-metrics-for-version`. ([#85444](https://github.com/kubernetes/kubernetes/pull/85444), [@RainbowMango](https://github.com/RainbowMango))

### SIG Apps, SIG Node, and SIG Windows

- Moving WindowsRunAsUserName feature to beta ([#84882](https://github.com/kubernetes/kubernetes/pull/84882), [@marosset](https://github.com/marosset))

### SIG Node, SIG Storage, and SIG Testing

- BREAKING CHANGE: Remove plugin watching of deprecated directory {kubelet_root_dir}/plugins and CSI V0 support in accordance with deprecation announcement in https://v1-13.docs.kubernetes.io/docs/setup/release/notes/ ([#84533](https://github.com/kubernetes/kubernetes/pull/84533), [@davidz627](https://github.com/davidz627))
- local: support local volume block mode reconstruction ([#84173](https://github.com/kubernetes/kubernetes/pull/84173), [@cofyc](https://github.com/cofyc))
- Fixed cleanup of raw block devices after kubelet restart. ([#83451](https://github.com/kubernetes/kubernetes/pull/83451), [@jsafrane](https://github.com/jsafrane))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Network

- If given an IPv6 bind-address, kube-apiserver will now advertise an IPv6 endpoint for the kubernetes.default service. ([#84727](https://github.com/kubernetes/kubernetes/pull/84727), [@danwinship](https://github.com/danwinship))

### SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Network, SIG Node, SIG Release, SIG Storage, and SIG Testing

- Kubernetes now requires go1.13.4+ to build ([#82809](https://github.com/kubernetes/kubernetes/pull/82809), [@liggitt](https://github.com/liggitt))

### SIG Apps, SIG CLI, SIG Network, SIG Scheduling, and SIG Testing

- Splitting IP address type into IPv4 and IPv6 for EndpointSlices ([#84971](https://github.com/kubernetes/kubernetes/pull/84971), [@robscott](https://github.com/robscott))

### SIG Auth, and SIG Storage

- The built-in system:csi-external-provisioner and system:csi-external-attacher cluster roles are removed as of 1.17 release ([#84282](https://github.com/kubernetes/kubernetes/pull/84282), [@tedyu](https://github.com/tedyu))

### SIG Storage, and SIG Windows

- Add data cache flushing during unmount device for GCE-PD driver in Windows Server. ([#83591](https://github.com/kubernetes/kubernetes/pull/83591), [@jingxu97](https://github.com/jingxu97))

### SIG API Machinery, and SIG CLI

- Add table convertor to componentstatus. ([#85174](https://github.com/kubernetes/kubernetes/pull/85174), [@zhouya0](https://github.com/zhouya0))
- Scale custom resource unconditionally if resourceVersion is not provided ([#80572](https://github.com/kubernetes/kubernetes/pull/80572), [@knight42](https://github.com/knight42))
- The `--certificate-authority` flag now correctly overrides existing skip TLS or CA data settings in the kubeconfig file ([#83547](https://github.com/kubernetes/kubernetes/pull/83547), [@liggitt](https://github.com/liggitt))

### SIG Node, and SIG Windows

- When using Containerd on Windows, the ``TerminationMessagePath`` file will now be mounted in the Windows Pod. ([#83057](https://github.com/kubernetes/kubernetes/pull/83057), [@bclau](https://github.com/bclau))
- Fix kubelet metrics gathering on non-English Windows hosts ([#84156](https://github.com/kubernetes/kubernetes/pull/84156), [@wawa0210](https://github.com/wawa0210))

### SIG Scheduling, and SIG Testing

- Critical pods can now be created in namespaces other than kube-system. To limit critical pods to the kube-system namespace, cluster admins should create an admission configuration file limiting critical pods by default, and a matching quota object in the `kube-system` namespace permitting critical pods in that namespace. See https://kubernetes.io/docs/concepts/policy/resource-quotas/&#35;limit-priority-class-consumption-by-default for details. ([#76310](https://github.com/kubernetes/kubernetes/pull/76310), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Scheduler ComponentConfig fields are now pointers ([#83619](https://github.com/kubernetes/kubernetes/pull/83619), [@damemi](https://github.com/damemi))
- Scheduler Policy API has a new recommended apiVersion "apiVersion: kubescheduler.config.k8s.io/v1" which is consistent with the scheduler API group "kubescheduler.config.k8s.io". It holds the same API as the old apiVersion "apiVersion: v1". ([#83578](https://github.com/kubernetes/kubernetes/pull/83578), [@Huang-Wei](https://github.com/Huang-Wei))
- Rename PluginContext to CycleState in the scheduling framework ([#83430](https://github.com/kubernetes/kubernetes/pull/83430), [@draveness](https://github.com/draveness))
- Some scheduler extender API fields are moved from `pkg/scheduler/api` to `pkg/scheduler/apis/extender/v1`. ([#83262](https://github.com/kubernetes/kubernetes/pull/83262), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG API Machinery, SIG Auth, SIG CLI, SIG Network, and SIG Testing

- Clients can request protobuf and json and correctly negotiate with the server for JSON for CRD objects, allowing all client libraries to request protobuf if it is available.  If an error occurs negotiating a watch with the server, the error is immediately return by the client `Watch()` method instead of being sent as an `Error` event on the watch stream. ([#84692](https://github.com/kubernetes/kubernetes/pull/84692), [@smarterclayton](https://github.com/smarterclayton))

### SIG Cluster Lifecycle, and SIG Network

- This PR sets the --cluster-dns flag value to kube-dns service IP whether or not NodeLocal DNSCache is enabled. NodeLocal DNSCache will listen on both the link-local as well as the service IP. ([#84383](https://github.com/kubernetes/kubernetes/pull/84383), [@prameshj](https://github.com/prameshj))
- kube-dns add-on: 
  - All containers are now being executed under more restrictive privileges. 
  - Most of the containers now run as non-root user and has the root filesystem set as read-only. 
  - The remaining container running as root only has the minimum Linux capabilities it requires to run. 
  - Privilege escalation has been disabled for all containers. ([#82347](https://github.com/kubernetes/kubernetes/pull/82347), [@pjbgf](https://github.com/pjbgf))

### SIG API Machinery, and SIG Testing

- Resolved regression in admission, authentication, and authorization webhook performance in v1.17.0-rc.1 ([#85810](https://github.com/kubernetes/kubernetes/pull/85810), [@liggitt](https://github.com/liggitt))
- OpenAPI v3 format in CustomResourceDefinition schemas are now documented. ([#85381](https://github.com/kubernetes/kubernetes/pull/85381), [@sttts](https://github.com/sttts))
- kube-apiserver: Fixed a regression accepting patch requests > 1MB ([#84963](https://github.com/kubernetes/kubernetes/pull/84963), [@liggitt](https://github.com/liggitt))
- The example API server has renamed its `wardle.k8s.io` API group to `wardle.example.com` ([#81670](https://github.com/kubernetes/kubernetes/pull/81670), [@liggitt](https://github.com/liggitt))
- CRDs defaulting is promoted to GA. Note: the feature gate CustomResourceDefaulting will be removed in 1.18. ([#84713](https://github.com/kubernetes/kubernetes/pull/84713), [@sttts](https://github.com/sttts))
- Fix validation message to mention bytes, not characters. ([#80880](https://github.com/kubernetes/kubernetes/pull/80880), [@DirectXMan12](https://github.com/DirectXMan12))
- Restores compatibility with <=1.15.x custom resources by not publishing OpenAPI for non-structural custom resource definitions ([#82653](https://github.com/kubernetes/kubernetes/pull/82653), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, and SIG Node

- When the go-client reflector relists, the ResourceVersion list option is set to the reflector's latest synced resource version to ensure the reflector does not "go back in time" and reprocess events older than it has already processed. If the the server responds with an HTTP 410 (Gone) status code response, the relist falls back to using resourceVersion="". ([#83520](https://github.com/kubernetes/kubernetes/pull/83520), [@jpbetz](https://github.com/jpbetz))

### SIG API Machinery, SIG Apps, and SIG Node

- Fix unsafe JSON construction in a number of locations in the codebase ([#81158](https://github.com/kubernetes/kubernetes/pull/81158), [@zouyee](https://github.com/zouyee))

### SIG Cluster Lifecycle, SIG Network, SIG Node, and SIG Testing

- Kubernetes no longer monitors firewalld. On systems using firewalld for firewall
  maintenance, kube-proxy will take slightly longer to recover from disruptive
  firewalld operations that delete kube-proxy's iptables rules.
  
  As a side effect of these changes, kube-proxy's
  `sync_proxy_rules_last_timestamp_seconds` metric no longer behaves the
  way it used to; now it will only change when services or endpoints actually
  change, rather than reliably updating every 60 seconds (or whatever). If you
  are trying to monitor for whether iptables updates are failing, the
  `sync_proxy_rules_iptables_restore_failures_total` metric may be more useful. ([#81517](https://github.com/kubernetes/kubernetes/pull/81517), [@danwinship](https://github.com/danwinship))

### SIG Apps, and SIG Storage

- Report non-confusing error for negative storage size in PVC spec. ([#82759](https://github.com/kubernetes/kubernetes/pull/82759), [@sttts](https://github.com/sttts))

### SIG Node, and SIG Storage

- All nodes need to be drained before upgrading Kubernetes cluster, because paths used for block volumes are changed in this release, so on-line upgrade of nodes aren't allowed. ([#74026](https://github.com/kubernetes/kubernetes/pull/74026), [@mkimuram](https://github.com/mkimuram))
- Removed Alpha feature `MountContainers` ([#84365](https://github.com/kubernetes/kubernetes/pull/84365), [@codenrhoden](https://github.com/codenrhoden))

### SIG Node, and SIG Testing

- Fix a bug that a node Lease object may have been created without OwnerReference. ([#84998](https://github.com/kubernetes/kubernetes/pull/84998), [@wojtek-t](https://github.com/wojtek-t))
- external facing APIs in pluginregistration and deviceplugin packages are now available under k8s.io/kubelet/pkg/apis/ ([#83551](https://github.com/kubernetes/kubernetes/pull/83551), [@dims](https://github.com/dims))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Testing

- Update default etcd server version to 3.4.3 ([#84329](https://github.com/kubernetes/kubernetes/pull/84329), [@jingyih](https://github.com/jingyih))
- Upgrade default etcd server version to 3.3.17 ([#83804](https://github.com/kubernetes/kubernetes/pull/83804), [@jpbetz](https://github.com/jpbetz))

### SIG Apps, SIG Cloud Provider, and SIG Network

- Update Azure load balancer to prevent orphaned public IP addresses ([#82890](https://github.com/kubernetes/kubernetes/pull/82890), [@chewong](https://github.com/chewong))

### SIG API Machinery, and SIG Cloud Provider

- Upgrade to etcd client 3.3.17 to fix bug where etcd client does not parse IPv6 addresses correctly when members are joining, and to fix bug where failover on multi-member etcd cluster fails certificate check on DNS mismatch ([#83801](https://github.com/kubernetes/kubernetes/pull/83801), [@jpbetz](https://github.com/jpbetz))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Testing

- more complete and accurate logging of stack backtraces in E2E failures ([#82176](https://github.com/kubernetes/kubernetes/pull/82176), [@pohly](https://github.com/pohly))
- Fixes a flaw (CVE-2019-11253) in json/yaml decoding where large or malformed documents could consume excessive server resources. Request bodies for normal API requests (create/delete/update/patch operations of regular resources) are now limited to 3MB. ([#83261](https://github.com/kubernetes/kubernetes/pull/83261), [@liggitt](https://github.com/liggitt))

### SIG Auth, and SIG Cluster Lifecycle

- Fix typos in `certificates.k8s.io/v1beta1` KeyUsage constant names: `UsageContentCommittment` becomes `UsageContentCommitment` and `UsageNetscapSGC` becomes `UsageNetscapeSGC`. ([#82511](https://github.com/kubernetes/kubernetes/pull/82511), [@abursavich](https://github.com/abursavich))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node

- CRDs can have fields named `type` with value `array` and nested array with `items` fields without validation to fall over this. ([#85223](https://github.com/kubernetes/kubernetes/pull/85223), [@sttts](https://github.com/sttts))

### SIG Auth, and SIG Network

- EndpointSlices are not enabled by default. Use the EndpointSlice feature gate to enable this feature. ([#85365](https://github.com/kubernetes/kubernetes/pull/85365), [@robscott](https://github.com/robscott))

### SIG CLI, and SIG Testing

- kubectl: --resource-version now works properly in label/annotate/set selector commands when racing with other clients to update the target object ([#85285](https://github.com/kubernetes/kubernetes/pull/85285), [@liggitt](https://github.com/liggitt))

### SIG Apps, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Network

- Added appProtocol field to EndpointSlice Port ([#83815](https://github.com/kubernetes/kubernetes/pull/83815), [@howardjohn](https://github.com/howardjohn))

### SIG Network, and SIG Node

- The docker container runtime now enforces a 220 second timeout on container network operations. ([#71653](https://github.com/kubernetes/kubernetes/pull/71653), [@liucimin](https://github.com/liucimin))
- Fix panic in kubelet when running IPv4/IPv6 dual-stack mode with a CNI plugin ([#82508](https://github.com/kubernetes/kubernetes/pull/82508), [@aanm](https://github.com/aanm))

### SIG Apps, and SIG Network

- kube-controller-manager: Fixes bug setting headless service labels on endpoints ([#85361](https://github.com/kubernetes/kubernetes/pull/85361), [@liggitt](https://github.com/liggitt))
- EndpointSlice hostname is now set in the same conditions Endpoints hostname is. ([#84207](https://github.com/kubernetes/kubernetes/pull/84207), [@robscott](https://github.com/robscott))
- Improving the performance of Endpoint and EndpointSlice controllers by caching Service Selectors ([#84280](https://github.com/kubernetes/kubernetes/pull/84280), [@gongguan](https://github.com/gongguan))
- People can see the right log and note. ([#84637](https://github.com/kubernetes/kubernetes/pull/84637), [@zhipengzuo](https://github.com/zhipengzuo))
- clean duplicate GetPodServiceMemberships function ([#83902](https://github.com/kubernetes/kubernetes/pull/83902), [@gongguan](https://github.com/gongguan))
- Significant kube-proxy performance improvements when using Endpoint Slices at scale. ([#83206](https://github.com/kubernetes/kubernetes/pull/83206), [@robscott](https://github.com/robscott))

### SIG API Machinery, and SIG Scheduling

- matches := stackCreator.FindStringSubmatch(string(stack))
  matches type is []string
  
  so nil len(matches) ==0 
  
  change:
   if matches == nil || len(matches) != 4 ==>if len(matches) != 4 ([#84957](https://github.com/kubernetes/kubernetes/pull/84957), [@ZP-AlwaysWin](https://github.com/ZP-AlwaysWin))

### SIG Instrumentation, SIG Node, and SIG Scheduling

- A new `kubelet_preemptions` metric is reported from Kubelets to track the number of preemptions occuring over time, and which resource is triggering those preemptions. ([#84120](https://github.com/kubernetes/kubernetes/pull/84120), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, and SIG Instrumentation

- Adds a metric apiserver_request_error_total to kube-apiserver. This metric tallies the number of request_errors encountered by verb, group, version, resource, subresource, scope, component, and code. ([#83427](https://github.com/kubernetes/kubernetes/pull/83427), [@logicalhan](https://github.com/logicalhan))

### SIG Cloud Provider, and SIG Storage

- Fixed "requested device X but found Y" attach error on AWS. ([#85675](https://github.com/kubernetes/kubernetes/pull/85675), [@jsafrane](https://github.com/jsafrane))
- Reduced frequency of DescribeVolumes calls of AWS API when attaching/detaching a volume. ([#84181](https://github.com/kubernetes/kubernetes/pull/84181), [@jsafrane](https://github.com/jsafrane))
- Fixed attachment of AWS volumes that have just been detached. ([#83567](https://github.com/kubernetes/kubernetes/pull/83567), [@jsafrane](https://github.com/jsafrane))
- Fix possible fd leak and closing of dirs when using openstack ([#82873](https://github.com/kubernetes/kubernetes/pull/82873), [@odinuge](https://github.com/odinuge))

### SIG Apps, SIG Network, and SIG Testing

- When upgrading to 1.17 with a cluster with EndpointSlices enabled, the `endpointslice.kubernetes.io/managed-by` label needs to be set on each EndpointSlice. ([#85359](https://github.com/kubernetes/kubernetes/pull/85359), [@robscott](https://github.com/robscott))

### SIG Apps, SIG Auth, SIG Cloud Provider, SIG Network, SIG Node, SIG Scheduling, SIG Storage, and SIG Testing

- Deprecate the beta labels for zones ("failure-domain.beta.kubernetes.io/zone") and 
  regions ("failure-domain.beta.kubernetes.io/region") in favor of their GA equivalents:
  "topology.kubernetes.io/zone" and "topology.kubernetes.io/region". 
  
  The beta labels "failure-domain.beta.kubernetes.io/zone" and "failure-domain.beta.kubernetes.io/region" will be removed in v1.21 ([#81431](https://github.com/kubernetes/kubernetes/pull/81431), [@andrewsykim](https://github.com/andrewsykim))

### SIG Apps, SIG Node, and SIG Testing

- An end-user may choose to request logs without confirming the identity of the backing kubelet.  This feature can be disabled by setting the `AllowInsecureBackendProxy` feature-gate to false. ([#83419](https://github.com/kubernetes/kubernetes/pull/83419), [@deads2k](https://github.com/deads2k))

### SIG Network, and SIG Windows

- Fixes kube-proxy bug accessing self nodeip:port on windows ([#83027](https://github.com/kubernetes/kubernetes/pull/83027), [@liggitt](https://github.com/liggitt))


## Notes from Individual SIGs

### SIG API Machinery

- Filter published OpenAPI schema by making nullable, required fields non-required in order to avoid kubectl to wrongly reject null values. ([#85722](https://github.com/kubernetes/kubernetes/pull/85722), [@sttts](https://github.com/sttts))
- kube-apiserver: fixed a conflict error encountered attempting to delete a pod with gracePeriodSeconds=0 and a resourceVersion precondition ([#85516](https://github.com/kubernetes/kubernetes/pull/85516), [@michaelgugino](https://github.com/michaelgugino))
- Use context to check client closed instead of http.CloseNotifier in processing watch request which will reduce 1 goroutine for each request if proto is HTTP/2.x . ([#85408](https://github.com/kubernetes/kubernetes/pull/85408), [@answer1991](https://github.com/answer1991))
- Implement the documented API semantics of list-type and map-type atomic to reject non-atomic sub-types. ([#84722](https://github.com/kubernetes/kubernetes/pull/84722), [@sttts](https://github.com/sttts))
- kube-apiserver: Authentication configuration for mutating and validating admission webhooks referenced from an `--admission-control-config-file` can now be specified with `apiVersion: apiserver.config.k8s.io/v1, kind: WebhookAdmissionConfiguration`. ([#85138](https://github.com/kubernetes/kubernetes/pull/85138), [@liggitt](https://github.com/liggitt))
- kube-apiserver: The `ResourceQuota` admission plugin configuration referenced from `--admission-control-config-file` admission config has been promoted to `apiVersion: apiserver.config.k8s.io/v1`, `kind: ResourceQuotaConfiguration` with no schema changes. ([#85099](https://github.com/kubernetes/kubernetes/pull/85099), [@liggitt](https://github.com/liggitt))
- kube-apiserver: The `AdmissionConfiguration` type accepted by `--admission-control-config-file` has been promoted to `apiserver.config.k8s.io/v1` with no schema changes. ([#85098](https://github.com/kubernetes/kubernetes/pull/85098), [@liggitt](https://github.com/liggitt))
- kube-apiserver: fixed a bug that could cause a goroutine leak if the apiserver encountered an encoding error serving a watch to a websocket watcher ([#84693](https://github.com/kubernetes/kubernetes/pull/84693), [@tedyu](https://github.com/tedyu))
- Fix the bug that EndpointSlice for masters wasn't created after enabling EndpointSlice feature on a pre-existing cluster. ([#84421](https://github.com/kubernetes/kubernetes/pull/84421), [@tnqn](https://github.com/tnqn))
- Introduce x-kubernetes-map-type annotation as a CRD API extension. Enables this particular validation for server-side apply. ([#84113](https://github.com/kubernetes/kubernetes/pull/84113), [@enxebre](https://github.com/enxebre))
- Promote WatchBookmark feature to GA.
  With WatchBookmark feature, clients are able to request watch events with BOOKMARK type. Clients should not assume bookmarks are returned at any specific interval, nor may they assume the server will send any BOOKMARK event during a session. ([#83195](https://github.com/kubernetes/kubernetes/pull/83195), [@wojtek-t](https://github.com/wojtek-t))
- Switched intstr.Type to sized integer to follow API guidelines and improve compatibility with proto libraries ([#83956](https://github.com/kubernetes/kubernetes/pull/83956), [@liggitt](https://github.com/liggitt))
- client-go: improved allocation behavior of the delaying workqueue when handling objects with far-future ready times. ([#83945](https://github.com/kubernetes/kubernetes/pull/83945), [@barkbay](https://github.com/barkbay))
- Fixed an issue with informers missing an `Added` event if a recently deleted object was immediately recreated at the same time the informer dropped a watch and relisted. ([#83911](https://github.com/kubernetes/kubernetes/pull/83911), [@matte21](https://github.com/matte21))
- Fixed panic when accessing CustomResources of a CRD with x-kubernetes-int-or-string. ([#83787](https://github.com/kubernetes/kubernetes/pull/83787), [@sttts](https://github.com/sttts))
- The resource version option, when passed to a list call, is now consistently interpreted as the minimum allowed resource version.  Previously when listing resources that had the watch cache disabled clients could retrieve a snapshot at that exact resource version.  If the client requests a resource version newer than the current state, a TimeoutError is returned suggesting the client retry in a few seconds.  This behavior is now consistent for both single item retrieval and list calls, and for when the watch cache is enabled or disabled. ([#72170](https://github.com/kubernetes/kubernetes/pull/72170), [@jpbetz](https://github.com/jpbetz))
- Fixes a goroutine leak in kube-apiserver when a request times out. ([#83333](https://github.com/kubernetes/kubernetes/pull/83333), [@lavalamp](https://github.com/lavalamp))
- Fixes the bug in informer-gen that it produces incorrect code if a type has nonNamespaced tag set. ([#80458](https://github.com/kubernetes/kubernetes/pull/80458), [@tatsuhiro-t](https://github.com/tatsuhiro-t))
- Resolves bottleneck in internal API server communication that can cause increased goroutines and degrade API Server performance ([#80465](https://github.com/kubernetes/kubernetes/pull/80465), [@answer1991](https://github.com/answer1991))
- Resolves regression generating informers for packages whose names contain `.` characters ([#82410](https://github.com/kubernetes/kubernetes/pull/82410), [@nikhita](https://github.com/nikhita))
- Resolves issue with /readyz and /livez not including etcd and kms health checks ([#82713](https://github.com/kubernetes/kubernetes/pull/82713), [@logicalhan](https://github.com/logicalhan))
- Fixes regression in logging spurious stack traces when proxied connections are closed by the backend ([#82588](https://github.com/kubernetes/kubernetes/pull/82588), [@liggitt](https://github.com/liggitt))

### SIG Apps

- Fix handling tombstones in pod-disruption-budged controller. ([#83951](https://github.com/kubernetes/kubernetes/pull/83951), [@zouyee](https://github.com/zouyee))
- Fixed the bug that deleted services were processed by EndpointSliceController repeatedly even their cleanup were successful. ([#82996](https://github.com/kubernetes/kubernetes/pull/82996), [@tnqn](https://github.com/tnqn))

### SIG Auth

- All resources within the rbac.authorization.k8s.io/v1alpha1 and rbac.authorization.k8s.io/v1beta1 API groups are deprecated in favor of rbac.authorization.k8s.io/v1, and will no longer be served in v1.20. ([#84758](https://github.com/kubernetes/kubernetes/pull/84758), [@liggitt](https://github.com/liggitt))

### SIG CLI

- kubectl set resources will no longer return an error if passed an empty change for a resource. 
  kubectl set subject will no longer return an error if passed an empty change for a resource. ([#85490](https://github.com/kubernetes/kubernetes/pull/85490), [@sallyom](https://github.com/sallyom))
- Fixed kubectl endpointslice output for get requests ([#82603](https://github.com/kubernetes/kubernetes/pull/82603), [@robscott](https://github.com/robscott))
- Gives the right error message when using `kubectl delete` a wrong resource. ([#83825](https://github.com/kubernetes/kubernetes/pull/83825), [@zhouya0](https://github.com/zhouya0))
- If a bad flag is supplied to a kubectl command, only a tip to run --help is printed, instead of the usage menu.  Usage menu is printed upon running `kubectl command --help`. ([#82423](https://github.com/kubernetes/kubernetes/pull/82423), [@sallyom](https://github.com/sallyom))
- Commands like `kubectl apply` now return errors if schema-invalid annotations are specified, rather than silently dropping the entire annotations section. ([#83552](https://github.com/kubernetes/kubernetes/pull/83552), [@liggitt](https://github.com/liggitt))
- &#35; kubectl rollout history sts/test-sts 
  statefulset.apps/test-sts 
  REVISION
  0
  0
  0
  1
  2
  3 ([#82643](https://github.com/kubernetes/kubernetes/pull/82643), [@ZP-AlwaysWin](https://github.com/ZP-AlwaysWin))
- Correct a reference to a not/no longer used kustomize subcommand in the documentation ([#82535](https://github.com/kubernetes/kubernetes/pull/82535), [@demobox](https://github.com/demobox))

### SIG Cloud Provider

- azure: update disk lock logic per vm during attach/detach to allow concurrent updates for different nodes. ([#85115](https://github.com/kubernetes/kubernetes/pull/85115), [@aramase](https://github.com/aramase))
- fix vmss dirty cache issue in disk attach/detach on vmss node ([#85158](https://github.com/kubernetes/kubernetes/pull/85158), [@andyzhangx](https://github.com/andyzhangx))
- fix race condition when attach/delete azure disk in same time ([#84917](https://github.com/kubernetes/kubernetes/pull/84917), [@andyzhangx](https://github.com/andyzhangx))
- Change GCP ILB firewall names to contain the "k8s-fw-" prefix like the rest of the firewall rules. This is needed for consistency and also for other components to identify the firewall rule as k8s/service-controller managed. ([#84622](https://github.com/kubernetes/kubernetes/pull/84622), [@prameshj](https://github.com/prameshj))
- Ensure health probes are created for local traffic policy UDP services on Azure ([#84802](https://github.com/kubernetes/kubernetes/pull/84802), [@feiskyer](https://github.com/feiskyer))
- None. ([#84138](https://github.com/kubernetes/kubernetes/pull/84138), [@nilo19](https://github.com/nilo19))
- Openstack: Do not delete managed LB in case of security group reconciliation errors ([#82264](https://github.com/kubernetes/kubernetes/pull/82264), [@multi-io](https://github.com/multi-io))
- Fix aggressive VM calls for Azure VMSS ([#83102](https://github.com/kubernetes/kubernetes/pull/83102), [@feiskyer](https://github.com/feiskyer))
- fix: azure disk detach failure if node not exists ([#82640](https://github.com/kubernetes/kubernetes/pull/82640), [@andyzhangx](https://github.com/andyzhangx))

### SIG Cluster Lifecycle

- kubeadm: uses the apiserver AdvertiseAddress IP family to choose the etcd endpoint IP family for non external etcd clusters ([#85745](https://github.com/kubernetes/kubernetes/pull/85745), [@aojea](https://github.com/aojea))
- kubeadm: Forward cluster name to the controller-manager arguments ([#85817](https://github.com/kubernetes/kubernetes/pull/85817), [@ereslibre](https://github.com/ereslibre))
- kubeadm: retry `kubeadm-config` ConfigMap creation or mutation if the apiserver is not responding. This will improve resiliency when joining new control plane nodes. ([#85763](https://github.com/kubernetes/kubernetes/pull/85763), [@ereslibre](https://github.com/ereslibre))
- kubeadm: make sure images are pre-pulled even if a tag did not change but their contents changed ([#85603](https://github.com/kubernetes/kubernetes/pull/85603), [@bart0sh](https://github.com/bart0sh))
- Wait for kubelet & kube-proxy to be ready on Windows node within 10s ([#85228](https://github.com/kubernetes/kubernetes/pull/85228), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm: fix a panic in case the KubeProxyConfiguration feature gates were not initialized. ([#85524](https://github.com/kubernetes/kubernetes/pull/85524), [@Arvinderpal](https://github.com/Arvinderpal))
- kubeadm: fix stray "node-cidr-mask-size" flag in the kube-controller-manager manifest when IPv6DualStack is enabled ([#85494](https://github.com/kubernetes/kubernetes/pull/85494), [@tedyu](https://github.com/tedyu))
- kubeadm: Fix a bug where kubeadm cannot parse kubelet's version if the latter dumps logs on the standard error. ([#85351](https://github.com/kubernetes/kubernetes/pull/85351), [@rosti](https://github.com/rosti))
- kubeadm: added retry to all the calls to the etcd API so kubeadm will be more resilient to network glitches ([#85201](https://github.com/kubernetes/kubernetes/pull/85201), [@fabriziopandini](https://github.com/fabriziopandini))
- Fixes a bug in kubeadm that caused init and join to hang indefinitely in specific conditions. ([#85156](https://github.com/kubernetes/kubernetes/pull/85156), [@chuckha](https://github.com/chuckha))
- Kubeadm now includes CoreDNS version 1.6.5
   - `kubernetes` plugin adds metrics to measure kubernetes control plane latency.
   -  the `health` plugin now includes the `lameduck` option by default, which waits for a duration before shutting down. ([#85109](https://github.com/kubernetes/kubernetes/pull/85109), [@rajansandeep](https://github.com/rajansandeep))
- Fixed bug when using kubeadm alpha certs commands with clusters using external etcd ([#85091](https://github.com/kubernetes/kubernetes/pull/85091), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm no longer defaults or validates the component configs of the kubelet or kube-proxy ([#79223](https://github.com/kubernetes/kubernetes/pull/79223), [@rosti](https://github.com/rosti))
- kubeadm: remove the deprecated "--cri-socket" flag for "kubeadm upgrade apply". The flag has been deprecated since v1.14. ([#85044](https://github.com/kubernetes/kubernetes/pull/85044), [@neolit123](https://github.com/neolit123))
- kubeadm: prevent potential hanging of commands such as "kubeadm reset" if the apiserver endpoint is not reachable. ([#84648](https://github.com/kubernetes/kubernetes/pull/84648), [@neolit123](https://github.com/neolit123))
- kubeadm: fix skipped etcd upgrade on secondary control-plane nodes when the command "kubeadm upgrade node" is used. ([#85024](https://github.com/kubernetes/kubernetes/pull/85024), [@neolit123](https://github.com/neolit123))
- kubeadm: fix an issue with the kube-proxy container env. variables ([#84888](https://github.com/kubernetes/kubernetes/pull/84888), [@neolit123](https://github.com/neolit123))
- Utilize diagnostics tool to dump GKE windows test logs ([#83517](https://github.com/kubernetes/kubernetes/pull/83517), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm: always mount the kube-controller-manager hostPath volume that is given by the --flex-volume-plugin-dir flag. ([#84468](https://github.com/kubernetes/kubernetes/pull/84468), [@neolit123](https://github.com/neolit123))
- Update Cluster Autoscaler version to 1.16.2 (CA release docs: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.16.2) ([#84038](https://github.com/kubernetes/kubernetes/pull/84038), [@losipiuk](https://github.com/losipiuk))
- kubeadm no longer removes /etc/cni/net.d as it does not install it. Users should remove files from it manually or rely on the component that created them ([#83950](https://github.com/kubernetes/kubernetes/pull/83950), [@yastij](https://github.com/yastij))
- kubeadm: fix wrong default value for the "upgrade node --certificate-renewal" flag. ([#83528](https://github.com/kubernetes/kubernetes/pull/83528), [@neolit123](https://github.com/neolit123))
- Bump metrics-server to v0.3.5 ([#83015](https://github.com/kubernetes/kubernetes/pull/83015), [@olagacek](https://github.com/olagacek))
- dashboard: disable the dashboard Deployment on non-Linux nodes. This step is required to support Windows worker nodes. ([#82975](https://github.com/kubernetes/kubernetes/pull/82975), [@wawa0210](https://github.com/wawa0210))
- Fixes a panic in kube-controller-manager cleaning up bootstrap tokens ([#82887](https://github.com/kubernetes/kubernetes/pull/82887), [@tedyu](https://github.com/tedyu))

### SIG Network

- Revert ensure the KUBE-MARK-DROP chain in kube-proxy mode=iptables. Fix a bug in which kube-proxy deletes the rules associated with the chain in iptables mode. ([#85527](https://github.com/kubernetes/kubernetes/pull/85527), [@aojea](https://github.com/aojea))
- Remove redundant API validation when using Service Topology with externalTrafficPolicy=Local ([#85346](https://github.com/kubernetes/kubernetes/pull/85346), [@andrewsykim](https://github.com/andrewsykim))
- update github.com/vishvananda/netlink to v1.0.0 ([#83576](https://github.com/kubernetes/kubernetes/pull/83576), [@andrewsykim](https://github.com/andrewsykim))
- Ensure the KUBE-MARK-DROP chain in kube-proxy mode=iptables. The chain is ensured for both ipv4 and ipv6 in dual-stack operation. ([#84422](https://github.com/kubernetes/kubernetes/pull/84422), [@aojea](https://github.com/aojea))
- deprecate cleanup-ipvs flag ([#83832](https://github.com/kubernetes/kubernetes/pull/83832), [@gongguan](https://github.com/gongguan))
- Fixed EndpointSlice port name validation to match Endpoint port name validation (allowing port names longer than 15 characters) ([#84481](https://github.com/kubernetes/kubernetes/pull/84481), [@robscott](https://github.com/robscott))
- kube-proxy: emits a warning when a malformed component config file is used with v1alpha1. ([#84143](https://github.com/kubernetes/kubernetes/pull/84143), [@phenixblue](https://github.com/phenixblue))
- set config.BindAddress to IPv4 address "127.0.0.1" if not specified ([#83822](https://github.com/kubernetes/kubernetes/pull/83822), [@zouyee](https://github.com/zouyee))
- Updated kube-proxy ipvs README with correct grep argument to list loaded ipvs modules ([#83677](https://github.com/kubernetes/kubernetes/pull/83677), [@pete911](https://github.com/pete911))
- The userspace mode of kube-proxy no longer confusingly logs messages about deleting endpoints that it is actually adding. ([#83644](https://github.com/kubernetes/kubernetes/pull/83644), [@danwinship](https://github.com/danwinship))
- kube-proxy iptables probabilities are now more granular and will result in better distribution beyond 319 endpoints. ([#83599](https://github.com/kubernetes/kubernetes/pull/83599), [@robscott](https://github.com/robscott))
- Significant kube-proxy performance improvements for non UDP ports. ([#83208](https://github.com/kubernetes/kubernetes/pull/83208), [@robscott](https://github.com/robscott))
- Improved performance of kube-proxy with EndpointSlice enabled with more efficient sorting. ([#83035](https://github.com/kubernetes/kubernetes/pull/83035), [@robscott](https://github.com/robscott))

### SIG Node

- Fixed a bug in the single-numa-policy of the TopologyManager. Previously, best-effort pods would result in a terminated state with a TopologyAffinity error. Now they will run as expected. ([#83777](https://github.com/kubernetes/kubernetes/pull/83777), [@lmdaly](https://github.com/lmdaly))
- Fixed a bug in the single-numa-node policy of the TopologyManager.  Previously, pods that only requested CPU resources and did not request any third-party devices would fail to launch with a TopologyAffinity error. Now they will launch successfully. ([#83697](https://github.com/kubernetes/kubernetes/pull/83697), [@klueska](https://github.com/klueska))
- Fix error where metrics related to dynamic kubelet config isn't registered ([#83184](https://github.com/kubernetes/kubernetes/pull/83184), [@odinuge](https://github.com/odinuge))
- If container fails because ContainerCannotRun, do not utilize the FallbackToLogsOnError TerminationMessagePolicy, as it masks more useful logs. ([#81280](https://github.com/kubernetes/kubernetes/pull/81280), [@yqwang-ms](https://github.com/yqwang-ms))
- Use online nodes instead of possible nodes when discovering available NUMA nodes ([#83196](https://github.com/kubernetes/kubernetes/pull/83196), [@zouyee](https://github.com/zouyee))
- Use ipv4 in wincat port forward. ([#83036](https://github.com/kubernetes/kubernetes/pull/83036), [@liyanhui1228](https://github.com/liyanhui1228))
- Single static pod files and pod files from http endpoints cannot be larger than 10 MB. HTTP probe payloads are now truncated to 10KB. ([#82669](https://github.com/kubernetes/kubernetes/pull/82669), [@rphillips](https://github.com/rphillips))
- Limit the body length of exec readiness/liveness probes. remote CRIs and Docker shim read a max of 16MB output of which the exec probe itself inspects 10kb. ([#82514](https://github.com/kubernetes/kubernetes/pull/82514), [@dims](https://github.com/dims))

### SIG Release

- Added the `crictl` Windows binaries as well as the Linux 32bit binary to the release archives ([#83944](https://github.com/kubernetes/kubernetes/pull/83944), [@saschagrunert](https://github.com/saschagrunert))
- Bumps the minimum version of Go required for building Kubernetes to 1.12.4. ([#83596](https://github.com/kubernetes/kubernetes/pull/83596), [@jktomer](https://github.com/jktomer))

### SIG Scheduling

- Only validate duplication of the RequestedToCapacityRatio custom priority and allow other custom predicates/priorities ([#84646](https://github.com/kubernetes/kubernetes/pull/84646), [@liu-cong](https://github.com/liu-cong))
- Scheduler policy configs can no longer be declared multiple times ([#83963](https://github.com/kubernetes/kubernetes/pull/83963), [@damemi](https://github.com/damemi))
- Add a metric to track number of scheduler binding and prioritizing goroutines ([#83535](https://github.com/kubernetes/kubernetes/pull/83535), [@wgliang](https://github.com/wgliang))
- TaintNodesByCondition was graduated to GA, CheckNodeMemoryPressure, CheckNodePIDPressure, CheckNodeDiskPressure, CheckNodeCondition were accidentally removed since 1.12, the replacement is to use CheckNodeUnschedulablePred ([#84152](https://github.com/kubernetes/kubernetes/pull/84152), [@draveness](https://github.com/draveness))
- [migration phase 1] PodFitsHostPorts as filter plugin ([#83659](https://github.com/kubernetes/kubernetes/pull/83659), [@wgliang](https://github.com/wgliang))
- [migration phase 1] PodFitsResources as framework plugin ([#83650](https://github.com/kubernetes/kubernetes/pull/83650), [@wgliang](https://github.com/wgliang))
- [migration phase 1] PodMatchNodeSelector/NodAffinity as filter plugin ([#83660](https://github.com/kubernetes/kubernetes/pull/83660), [@wgliang](https://github.com/wgliang))
- Add more tracing steps in generic_scheduler ([#83539](https://github.com/kubernetes/kubernetes/pull/83539), [@wgliang](https://github.com/wgliang))
- [migration phase 1] PodFitsHost as filter plugin ([#83662](https://github.com/kubernetes/kubernetes/pull/83662), [@wgliang](https://github.com/wgliang))
- Fixed a scheduler panic when using PodAffinity. ([#82841](https://github.com/kubernetes/kubernetes/pull/82841), [@Huang-Wei](https://github.com/Huang-Wei))
- Take the context as the first argument of Schedule. ([#82119](https://github.com/kubernetes/kubernetes/pull/82119), [@wgliang](https://github.com/wgliang))
- fixed an issue that the correct PluginConfig.Args is not passed to the corresponding PluginFactory in kube-scheduler when multiple PluginConfig items are defined. ([#82483](https://github.com/kubernetes/kubernetes/pull/82483), [@everpeace](https://github.com/everpeace))

### SIG Storage

- CSI Migration: Fixes issue where all volumes with the same inline volume inner spec name were staged in the same path. Migrated inline volumes are now staged at a unique path per unique volume. ([#84754](https://github.com/kubernetes/kubernetes/pull/84754), [@davidz627](https://github.com/davidz627))
- CSI Migration: GCE PD access mode now reflects read only status of inline volumes - this allows multi-attach for read only many PDs ([#84809](https://github.com/kubernetes/kubernetes/pull/84809), [@davidz627](https://github.com/davidz627))
- CSI detach timeout increased from 10 seconds to 2 minutes ([#84321](https://github.com/kubernetes/kubernetes/pull/84321), [@cduchesne](https://github.com/cduchesne))
- Ceph RBD volume plugin now does not use any keyring (/etc/ceph/ceph.client.lvs01cinder.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin) for authentication. Ceph user credentials must be provided in PersistentVolume objects and referred Secrets. ([#75588](https://github.com/kubernetes/kubernetes/pull/75588), [@smileusd](https://github.com/smileusd))
- IP validates if a string is a valid IP address ([#83104](https://github.com/kubernetes/kubernetes/pull/83104), [@zouyee](https://github.com/zouyee))
- PersistentVolumeLabel admission plugin, responsible for labeling `PersistentVolumes` with topology labels, now does not overwrite existing labels on PVs that were dynamically provisioned. It trusts the  dynamic provisioning that it provided the correct labels to the `PersistentVolume`, saving one potentially expensive cloud API call. `PersistentVolumes` created manually by users are labelled by the admission plugin in the same way as before. ([#82830](https://github.com/kubernetes/kubernetes/pull/82830), [@jsafrane](https://github.com/jsafrane))

### SIG Testing

- Adding TerminationGracePeriodSeconds to the test framework API ([#82170](https://github.com/kubernetes/kubernetes/pull/82170), [@vivekbagade](https://github.com/vivekbagade))



