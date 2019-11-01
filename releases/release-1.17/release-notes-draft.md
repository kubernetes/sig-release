## Action Required

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

- Introduce x-kubernetes-map-type annotation as a CRD API extension. Enables this particular validation for server-side apply. ([#84113](https://github.com/kubernetes/kubernetes/pull/84113), [@enxebre](https://github.com/enxebre))
- Promote WatchBookmark feature to GA.
  With WatchBookmark feature, clients are able to request watch events with BOOKMARK type. Clients should not assume bookmarks are returned at any specific interval, nor may they assume the server will send any BOOKMARK event during a session. ([#83195](https://github.com/kubernetes/kubernetes/pull/83195), [@wojtek-t](https://github.com/wojtek-t))


## Notes From Multiple SIGs

### SIG Apps, SIG Node, and SIG Testing

- An end-user may choose to request logs without confirming the identity of the backing kubelet.  This feature can be disabled by setting the `AllowInsecureBackendProxy` feature-gate to false. ([#83419](https://github.com/kubernetes/kubernetes/pull/83419), [@deads2k](https://github.com/deads2k))

### SIG Node, and SIG Testing

- external facing APIs in pluginregistration and deviceplugin packages are now available under k8s.io/kubelet/pkg/apis/ ([#83551](https://github.com/kubernetes/kubernetes/pull/83551), [@dims](https://github.com/dims))

### SIG Apps, SIG Node, SIG Storage, and SIG Testing

- The VolumeSubpathEnvExpansion feature is graduating to GA. The `VolumeSubpathEnvExpansion` feature gate is unconditionally enabled, and will be removed in v1.19. ([#82578](https://github.com/kubernetes/kubernetes/pull/82578), [@kevtaylor](https://github.com/kevtaylor))

### SIG Network, and SIG Windows

- Fixes kube-proxy bug accessing self nodeip:port on windows ([#83027](https://github.com/kubernetes/kubernetes/pull/83027), [@liggitt](https://github.com/liggitt))

### SIG Architecture, and SIG Testing

- Conformance tests may now include disruptive tests. If you are running tests against a live cluster, consider skipping those tests tagged as `Disruptive` to avoid non-test workloads being impacted. Be aware, skipping any conformance tests (even disruptive ones) will make the results ineligible for consideration for the CNCF Certified Kubernetes program. ([#82664](https://github.com/kubernetes/kubernetes/pull/82664), [@johnSchnake](https://github.com/johnSchnake))

### SIG Cluster Lifecycle, and SIG Testing

- Remove prometheus cluster monitoring addon from kube-up ([#83442](https://github.com/kubernetes/kubernetes/pull/83442), [@serathius](https://github.com/serathius))

### SIG Node, SIG Storage, and SIG Testing

- local: support local volume block mode reconstruction ([#84173](https://github.com/kubernetes/kubernetes/pull/84173), [@cofyc](https://github.com/cofyc))
- Fixed cleanup of raw block devices after kubelet restart. ([#83451](https://github.com/kubernetes/kubernetes/pull/83451), [@jsafrane](https://github.com/jsafrane))

### SIG Cloud Provider, and SIG Storage

- Reduced frequency of DescribeVolumes calls of AWS API when attaching/detaching a volume. ([#84181](https://github.com/kubernetes/kubernetes/pull/84181), [@jsafrane](https://github.com/jsafrane))
- Fixed attachment of AWS volumes that have just been detached. ([#83567](https://github.com/kubernetes/kubernetes/pull/83567), [@jsafrane](https://github.com/jsafrane))
- Fix possible fd leak and closing of dirs when using openstack ([#82873](https://github.com/kubernetes/kubernetes/pull/82873), [@odinuge](https://github.com/odinuge))

### SIG API Machinery, SIG Apps, and SIG Node

- Fix unsafe JSON construction in a number of locations in the codebase ([#81158](https://github.com/kubernetes/kubernetes/pull/81158), [@zouyee](https://github.com/zouyee))

### SIG API Machinery, and SIG Testing

- Fix validation message to mention bytes, not characters. ([#80880](https://github.com/kubernetes/kubernetes/pull/80880), [@DirectXMan12](https://github.com/DirectXMan12))
- Restores compatibility with <=1.15.x custom resources by not publishing OpenAPI for non-structural custom resource definitions ([#82653](https://github.com/kubernetes/kubernetes/pull/82653), [@liggitt](https://github.com/liggitt))

### SIG Auth, and SIG Node

- k8s dockerconfigjson secrets are now compatible with docker config desktop authentication credentials files ([#82148](https://github.com/kubernetes/kubernetes/pull/82148), [@bbourbie](https://github.com/bbourbie))

### SIG Cloud Provider, SIG Network, and SIG Node

- On AWS nodes with multiple network interfaces, kubelet should now more reliably report the same primary node IP. ([#80747](https://github.com/kubernetes/kubernetes/pull/80747), [@danwinship](https://github.com/danwinship))

### SIG Instrumentation, SIG Node, and SIG Scheduling

- A new `kubelet_preemptions` metric is reported from Kubelets to track the number of preemptions occuring over time, and which resource is triggering those preemptions. ([#84120](https://github.com/kubernetes/kubernetes/pull/84120), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, and SIG Cloud Provider

- Upgrade to etcd client 3.3.17 to fix bug where etcd client does not parse IPv6 addresses correctly when members are joining, and to fix bug where failover on multi-member etcd cluster fails certificate check on DNS mismatch ([#83801](https://github.com/kubernetes/kubernetes/pull/83801), [@jpbetz](https://github.com/jpbetz))

### SIG Auth, and SIG Cluster Lifecycle

- Fix typos in `certificates.k8s.io/v1beta1` KeyUsage constant names: `UsageContentCommittment` becomes `UsageContentCommitment` and `UsageNetscapSGC` becomes `UsageNetscapeSGC`. ([#82511](https://github.com/kubernetes/kubernetes/pull/82511), [@abursavich](https://github.com/abursavich))

### SIG API Machinery, and SIG CLI

- The `--certificate-authority` flag now correctly overrides existing skip TLS or CA data settings in the kubeconfig file ([#83547](https://github.com/kubernetes/kubernetes/pull/83547), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle, SIG Network, SIG Node, and SIG Testing

- Kubernetes no longer monitors firewalld. On systems using firewalld for firewall
  maintenance, kube-proxy will take slightly longer to recover from disruptive
  firewalld operations that delete kube-proxy's iptables rules. ([#81517](https://github.com/kubernetes/kubernetes/pull/81517), [@danwinship](https://github.com/danwinship))

### SIG API Machinery, SIG Apps, SIG Scheduling, and SIG Testing

- kube-scheduler now fallbacks to emitting events using core/v1 Events when events.k8s.io/v1beta1 is disabled. ([#83692](https://github.com/kubernetes/kubernetes/pull/83692), [@yastij](https://github.com/yastij))

### SIG API Machinery, SIG Auth, SIG Node, and SIG Testing

- client-ca bundles for the all generic-apiserver based servers will dynamically reload from disk on content changes ([#83579](https://github.com/kubernetes/kubernetes/pull/83579), [@deads2k](https://github.com/deads2k))

### SIG Apps, and SIG Network

- clean duplicate GetPodServiceMemberships function ([#83902](https://github.com/kubernetes/kubernetes/pull/83902), [@gongguan](https://github.com/gongguan))
- Significant kube-proxy performance improvements when using Endpoint Slices at scale. ([#83206](https://github.com/kubernetes/kubernetes/pull/83206), [@robscott](https://github.com/robscott))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Testing

- more complete and accurate logging of stack backtraces in E2E failures ([#82176](https://github.com/kubernetes/kubernetes/pull/82176), [@pohly](https://github.com/pohly))
- Fixes a flaw (CVE-2019-11253) in json/yaml decoding where large or malformed documents could consume excessive server resources. Request bodies for normal API requests (create/delete/update/patch operations of regular resources) are now limited to 3MB. ([#83261](https://github.com/kubernetes/kubernetes/pull/83261), [@liggitt](https://github.com/liggitt))

### SIG Network, and SIG Node

- The docker container runtime now enforces a 220 second timeout on container network operations. ([#71653](https://github.com/kubernetes/kubernetes/pull/71653), [@liucimin](https://github.com/liucimin))
- Fix panic in kubelet when running IPv4/IPv6 dual-stack mode with a CNI plugin ([#82508](https://github.com/kubernetes/kubernetes/pull/82508), [@aanm](https://github.com/aanm))

### SIG Auth, and SIG Storage

- The built-in system:csi-external-provisioner and system:csi-external-attacher cluster roles are removed as of 1.17 release ([#84282](https://github.com/kubernetes/kubernetes/pull/84282), [@tedyu](https://github.com/tedyu))

### SIG Storage, and SIG Windows

- Add data cache flushing during unmount device for GCE-PD driver in Windows Server. ([#83591](https://github.com/kubernetes/kubernetes/pull/83591), [@jingxu97](https://github.com/jingxu97))

### SIG Cluster Lifecycle, and SIG Release

- hyperkube will now be available in a new github repository and will not be included in the kubernetes release from 1.17 onwards ([#83454](https://github.com/kubernetes/kubernetes/pull/83454), [@dims](https://github.com/dims))

### SIG Apps, SIG Cloud Provider, and SIG Network

- Update Azure load balancer to prevent orphaned public IP addresses ([#82890](https://github.com/kubernetes/kubernetes/pull/82890), [@chewong](https://github.com/chewong))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Cloud Provider, and SIG Scheduling

- Migrate controller-manager and scheduler to EndpointsLeases leader election. ([#84084](https://github.com/kubernetes/kubernetes/pull/84084), [@wojtek-t](https://github.com/wojtek-t))

### SIG Node, and SIG Windows

- Fix kubelet metrics gathering on non-English Windows hosts ([#84156](https://github.com/kubernetes/kubernetes/pull/84156), [@wawa0210](https://github.com/wawa0210))

### SIG API Machinery, and SIG Instrumentation

- Adds a metric apiserver_request_error_total to kube-apiserver. This metric tallies the number of request_errors encountered by verb, group, version, resource, subresource, scope, component, and code. ([#83427](https://github.com/kubernetes/kubernetes/pull/83427), [@logicalhan](https://github.com/logicalhan))

### SIG Apps, and SIG Storage

- Report non-confusing error for negative storage size in PVC spec. ([#82759](https://github.com/kubernetes/kubernetes/pull/82759), [@sttts](https://github.com/sttts))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Autoscaling, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Network, SIG Node, SIG Scheduling, SIG Storage, and SIG Testing

- Update etcd client side to v3.4.3
  Deprecated prometheus request meta-metrics have been removed (http_request_duration_microseconds, http_request_duration_microseconds_sum, http_request_duration_microseconds_count, http_request_size_bytes, http_request_size_bytes_sum, http_request_size_bytes_count, http_requests_total, http_response_size_bytes, http_response_size_bytes_sum, http_response_size_bytes_count) due to removal from the prometheus client library. Prometheus http request meta-metrics are now generated from [promhttp.InstrumentMetricHandler](https://godoc.org/github.com/prometheus/client_golang/prometheus/promhttp&#35;InstrumentMetricHandler) instead. ([#83987](https://github.com/kubernetes/kubernetes/pull/83987), [@wenjiaswe](https://github.com/wenjiaswe))

### SIG API Machinery, and SIG Auth

- Authentication token cache size is increased (from 4k to 32k) to support clusters with many nodes or many namespaces with active service accounts. ([#83643](https://github.com/kubernetes/kubernetes/pull/83643), [@lavalamp](https://github.com/lavalamp))

### SIG Cluster Lifecycle, and SIG Network

- kube-dns add-on: 
  - All containers are now being executed under more restrictive privileges. 
  - Most of the containers now run as non-root user and has the root filesystem set as read-only. 
  - The remaining container running as root only has the minimum Linux capabilities it requires to run. 
  - Privilege escalation has been disabled for all containers. ([#82347](https://github.com/kubernetes/kubernetes/pull/82347), [@pjbgf](https://github.com/pjbgf))

### SIG Release, and SIG Testing

- Update to use go1.12.12 ([#84064](https://github.com/kubernetes/kubernetes/pull/84064), [@cblecker](https://github.com/cblecker))
- Update to go 1.12.10 ([#83139](https://github.com/kubernetes/kubernetes/pull/83139), [@cblecker](https://github.com/cblecker))
- The deprecated mondo `kubernetes-test` tarball is no longer built. Users running Kubernetes e2e tests should use the `kubernetes-test-portable` and `kubernetes-test-{OS}-{ARCH}` tarballs instead. ([#83093](https://github.com/kubernetes/kubernetes/pull/83093), [@ixdy](https://github.com/ixdy))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Testing

- Upgrade default etcd server version to 3.3.17 ([#83804](https://github.com/kubernetes/kubernetes/pull/83804), [@jpbetz](https://github.com/jpbetz))

### SIG Scheduling, and SIG Testing

- Rename PluginContext to CycleState in the scheduling framework ([#83430](https://github.com/kubernetes/kubernetes/pull/83430), [@draveness](https://github.com/draveness))
- Some scheduler extender API fields are moved from `pkg/scheduler/api` to `pkg/scheduler/apis/extender/v1`. ([#83262](https://github.com/kubernetes/kubernetes/pull/83262), [@Huang-Wei](https://github.com/Huang-Wei))


## Notes from Individual SIGs

### SIG API Machinery

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

### SIG CLI

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

- None. ([#84138](https://github.com/kubernetes/kubernetes/pull/84138), [@nilo19](https://github.com/nilo19))
- Openstack: Do not delete managed LB in case of security group reconciliation errors ([#82264](https://github.com/kubernetes/kubernetes/pull/82264), [@multi-io](https://github.com/multi-io))
- Fix aggressive VM calls for Azure VMSS ([#83102](https://github.com/kubernetes/kubernetes/pull/83102), [@feiskyer](https://github.com/feiskyer))
- fix: azure disk detach failure if node not exists ([#82640](https://github.com/kubernetes/kubernetes/pull/82640), [@andyzhangx](https://github.com/andyzhangx))

### SIG Cluster Lifecycle

- kubeadm: always mount the kube-controller-manager hostPath volume that is given by the --flex-volume-plugin-dir flag. ([#84468](https://github.com/kubernetes/kubernetes/pull/84468), [@neolit123](https://github.com/neolit123))
- Update Cluster Autoscaler version to 1.16.2 (CA release docs: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.16.2) ([#84038](https://github.com/kubernetes/kubernetes/pull/84038), [@losipiuk](https://github.com/losipiuk))
- kubeadm no longer removes /etc/cni/net.d as it does not install it. Users should remove files from it manually or rely on the component that created them ([#83950](https://github.com/kubernetes/kubernetes/pull/83950), [@yastij](https://github.com/yastij))
- kubeadm: fix wrong default value for the "upgrade node --certificate-renewal" flag. ([#83528](https://github.com/kubernetes/kubernetes/pull/83528), [@neolit123](https://github.com/neolit123))
- Bump metrics-server to v0.3.5 ([#83015](https://github.com/kubernetes/kubernetes/pull/83015), [@olagacek](https://github.com/olagacek))
- dashboard: disable the dashboard Deployment on non-Linux nodes. This step is required to support Windows worker nodes. ([#82975](https://github.com/kubernetes/kubernetes/pull/82975), [@wawa0210](https://github.com/wawa0210))
- Fixes a panic in kube-controller-manager cleaning up bootstrap tokens ([#82887](https://github.com/kubernetes/kubernetes/pull/82887), [@tedyu](https://github.com/tedyu))

### SIG Network

- set config.BindAddress to IPv4 address "127.0.0.1" if not specified ([#83822](https://github.com/kubernetes/kubernetes/pull/83822), [@zouyee](https://github.com/zouyee))
- Updated kube-proxy ipvs README with correct grep argument to list loaded ipvs modules ([#83677](https://github.com/kubernetes/kubernetes/pull/83677), [@pete911](https://github.com/pete911))
- The userspace mode of kube-proxy no longer confusingly logs messages about deleting endpoints that it is actually adding. ([#83644](https://github.com/kubernetes/kubernetes/pull/83644), [@danwinship](https://github.com/danwinship))
- kube-proxy iptables probabilities are now more granular and will result in better distribution beyond 319 endpoints. ([#83599](https://github.com/kubernetes/kubernetes/pull/83599), [@robscott](https://github.com/robscott))
- Significant kube-proxy performance improvements for non UDP ports. ([#83208](https://github.com/kubernetes/kubernetes/pull/83208), [@robscott](https://github.com/robscott))
- Improved performance of kube-proxy with EndpointSlice enabled with more efficient sorting. ([#83035](https://github.com/kubernetes/kubernetes/pull/83035), [@robscott](https://github.com/robscott))

### SIG Node

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

- CSI detach timeout increased from 10 seconds to 2 minutes ([#84321](https://github.com/kubernetes/kubernetes/pull/84321), [@cduchesne](https://github.com/cduchesne))
- Ceph RBD volume plugin now does not use any keyring (/etc/ceph/ceph.client.lvs01cinder.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin) for authentication. Ceph user credentials must be provided in PersistentVolume objects and referred Secrets. ([#75588](https://github.com/kubernetes/kubernetes/pull/75588), [@smileusd](https://github.com/smileusd))
- IP validates if a string is a valid IP address ([#83104](https://github.com/kubernetes/kubernetes/pull/83104), [@zouyee](https://github.com/zouyee))
- PersistentVolumeLabel admission plugin, responsible for labeling `PersistentVolumes` with topology labels, now does not overwrite existing labels on PVs that were dynamically provisioned. It trusts the  dynamic provisioning that it provided the correct labels to the `PersistentVolume`, saving one potentially expensive cloud API call. `PersistentVolumes` created manually by users are labelled by the admission plugin in the same way as before. ([#82830](https://github.com/kubernetes/kubernetes/pull/82830), [@jsafrane](https://github.com/jsafrane))

### SIG Testing

- Adding TerminationGracePeriodSeconds to the test framework API ([#82170](https://github.com/kubernetes/kubernetes/pull/82170), [@vivekbagade](https://github.com/vivekbagade))