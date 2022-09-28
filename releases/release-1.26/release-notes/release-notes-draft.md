## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

- Deprecated beta APIs scheduled for removal in 1.26 are no longer served. See https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-26 for more information. ([#111973](https://github.com/kubernetes/kubernetes/pull/111973), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]

## Changes by Kind

### Deprecation

- The `gcp` and `azure` auth plugins have been removed from `client-go` and `kubectl`. See [kubelogin](https://github.com/Azure/kubelogin) and [Kubectl Auth Changes in GKE](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) for details about the cloud-specific replacements. ([#112341](https://github.com/kubernetes/kubernetes/pull/112341), [@enj](https://github.com/enj))

### API Change

- Add auth API to get self subject attributes (new selfsubjectreviews API is added).
  The corresponding command for kubctl is provided - `kubectl auth whoami`. ([#111333](https://github.com/kubernetes/kubernetes/pull/111333), [@nabokihms](https://github.com/nabokihms)) [SIG API Machinery, Auth, CLI and Testing]
- Clarified the CFS quota as 100ms in the code comments and set the minimum `cpuCFSQuotaPeriod` to 1ms to match Linux kernel expectations. ([#112123](https://github.com/kubernetes/kubernetes/pull/112123), [@paskal](https://github.com/paskal))
- Component-base: make the validation logic about LeaderElectionConfiguration consistent between component-base and client-go ([#111758](https://github.com/kubernetes/kubernetes/pull/111758), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery and Scheduling]
- Fixes spurious `field is immutable` errors validating updates to Event API objects via the `events.k8s.io/v1` API ([#112183](https://github.com/kubernetes/kubernetes/pull/112183), [@liggitt](https://github.com/liggitt)) [SIG Apps]
- Kubelet: changed default value of `cpuCFSQuotaPeriod` from 100ms to 100µs to match the Linux CFS and k8s defaults. `cpuCFSQuotaPeriod` of 100ms now requires `customCPUCFSQuotaPeriod` flag to be set to work. ([#111520](https://github.com/kubernetes/kubernetes/pull/111520), [@paskal](https://github.com/paskal))
- Protobuf serialization of metav1.MicroTime timestamps (used in `Lease` and `Event` API objects) has been corrected to truncate to microsecond precision, to match the documented behavior and JSON/YAML serialization. Any existing persisted data is truncated to microsecond when read from etcd. ([#111936](https://github.com/kubernetes/kubernetes/pull/111936), [@haoruan](https://github.com/haoruan))
- Revert regression that prevented client-go latency metrics to be reported with a template URL to avoid label cardinality. ([#111752](https://github.com/kubernetes/kubernetes/pull/111752), [@aanm](https://github.com/aanm)) [SIG API Machinery]

### Feature

- A new "DisableCompression" field (default = false) has been added to kubeconfig under cluster info. When set to true, clients using the kubeconfig opt out of response compression for all requests to the apiserver. This can help improve list call latencies significantly when client-server network bandwidth is ample (>30MB/s) or if the server is CPU-constrained. ([#112309](https://github.com/kubernetes/kubernetes/pull/112309), [@shyamjvs](https://github.com/shyamjvs)) [SIG API Machinery and Auth]
- API Server tracing root span name for opentelemetry is changed from "KubernetesAPI" to "HTTP GET" ([#112545](https://github.com/kubernetes/kubernetes/pull/112545), [@dims](https://github.com/dims)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node, Storage and Testing]
- Add new Golang runtime-related metrics to Kubernetes components:
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
  - go_sched_latencies_seconds ([#111910](https://github.com/kubernetes/kubernetes/pull/111910), [@tosi3k](https://github.com/tosi3k)) [SIG API Machinery, Architecture, Auth, Cloud Provider and Instrumentation]
- CSRDuration feature gate that graduated to GA in 1.24 and was unconditionally enabled has been removed in v1.26 ([#112386](https://github.com/kubernetes/kubernetes/pull/112386), [@Shubham82](https://github.com/Shubham82)) [SIG Auth]
- Client-go: SharedInformerFactory supports waiting for goroutines during shutdown ([#112200](https://github.com/kubernetes/kubernetes/pull/112200), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Kube-apiserver: gzip compression switched from level 4 to level 1 to improve large list call latencies in exchange for higher network bandwidth usage (10-50% higher). This increases the headroom before very large unpaged list calls exceed request timeout limits. ([#112299](https://github.com/kubernetes/kubernetes/pull/112299), [@shyamjvs](https://github.com/shyamjvs)) [SIG API Machinery]
- Kubeadm: "show-join-command" has been added as a new separate phase at the end of "kubeadm init". You can skip printing the join information by using "kubeadm init --skip-phases=show-join-command". Executing only this phase on demand will throw an error because the phase needs dependencies such as bootstrap tokens to be pre-populated. ([#111512](https://github.com/kubernetes/kubernetes/pull/111512), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: added the "--cleanup-tmp-dir" flag for `kubeadm reset`. It will cleanup the contents of `/etc/kubernetes/tmp`. The flag is off by default. ([#112172](https://github.com/kubernetes/kubernetes/pull/112172), [@chendave](https://github.com/chendave))
- Kubeadm: try to load CA cert from external CertificateAuthority file when CertificateAuthorityData is empty for existing kubeconfig ([#111783](https://github.com/kubernetes/kubernetes/pull/111783), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubernetes is now built with Go 1.19.1 ([#112287](https://github.com/kubernetes/kubernetes/pull/112287), [@palnabarun](https://github.com/palnabarun)) [SIG Release and Testing]
- Scheduler now retries updating a pod's status on ServiceUnavailable and InternalError errors, in addition to net ConnectionRefused error. ([#111809](https://github.com/kubernetes/kubernetes/pull/111809), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- The `goroutines` metric is newly added in the scheduler.
  It replaces `scheduler_goroutines` metric and it counts the number of goroutine in more places than `scheduler_goroutine` does. ([#112003](https://github.com/kubernetes/kubernetes/pull/112003), [@sanposhiho](https://github.com/sanposhiho)) [SIG Instrumentation and Scheduling]

### Documentation

- Clarified the default CFS quota period as being 100µs and not 100ms. ([#111554](https://github.com/kubernetes/kubernetes/pull/111554), [@paskal](https://github.com/paskal)) [SIG Node]

### Bug or Regression

- Added back unused flags on `kubectl run` command, which did not go through the required deprecation period before being removed. ([#112243](https://github.com/kubernetes/kubernetes/pull/112243), [@brianpursley](https://github.com/brianpursley))
- Allow Label section in vsphere e2e cloudprovider configuration ([#112427](https://github.com/kubernetes/kubernetes/pull/112427), [@gnufied](https://github.com/gnufied)) [SIG Storage and Testing]
- Apiserver /healthz/etcd endpoint rate limits the number of forwarded health check requests to the etcd backends, answering with the last known state if the rate limit is exceeded. The rate limit is based on 1/2 of the timeout configured, with no burst allowed. ([#112046](https://github.com/kubernetes/kubernetes/pull/112046), [@aojea](https://github.com/aojea)) [SIG API Machinery]
- Avoid propagating hosts' `search .` into containers' `/etc/resolv.conf` ([#112157](https://github.com/kubernetes/kubernetes/pull/112157), [@dghubble](https://github.com/dghubble)) [SIG Network and Node]
- Callers using `DelegatingAuthenticationOptions` can now use `DisableAnonymous` to disable Anonymous authentication. ([#112181](https://github.com/kubernetes/kubernetes/pull/112181), [@xueqzhan](https://github.com/xueqzhan))
- Changed error message when resource is not supported by given patch type in `kubectl patch` ([#112556](https://github.com/kubernetes/kubernetes/pull/112556), [@ardaguclu](https://github.com/ardaguclu))
- Correct the calculating error in podTopologySpread plugin to avoid unexpected scheduling results. ([#112507](https://github.com/kubernetes/kubernetes/pull/112507), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Etcd: Update to v3.5.5 ([#112489](https://github.com/kubernetes/kubernetes/pull/112489), [@dims](https://github.com/dims)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- Fix race condition in GCE between containerized mounter setup in the kubelet and node startup. ([#112195](https://github.com/kubernetes/kubernetes/pull/112195), [@mattcary](https://github.com/mattcary)) [SIG Cloud Provider and Storage]
- Fix relative cpu priority for pods where containers explicitly request zero cpu by giving the lowest priority instead of falling back to the cpu limit to avoid possible cpu starvation of other pods ([#108832](https://github.com/kubernetes/kubernetes/pull/108832), [@waynepeking348](https://github.com/waynepeking348)) [SIG Node]
- Fixed an ephemeral port exhaustion bug caused by improper connection management that occurred when a large number of objects were handled by `kubectl` while exec auth was in use. ([#112017](https://github.com/kubernetes/kubernetes/pull/112017), [@enj](https://github.com/enj))
- Fixed bug in kubectl rollout history where only the latest revision was displayed when a specific revision was requested and an output format was specified ([#111093](https://github.com/kubernetes/kubernetes/pull/111093), [@brianpursley](https://github.com/brianpursley)) [SIG CLI and Testing]
- Fixed bug where dry run message was not printed when running kubectl label with --dry-run flag. ([#111571](https://github.com/kubernetes/kubernetes/pull/111571), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed list cost estimation in Priority and Fairness for list requests with `metadata.name` specified. ([#112557](https://github.com/kubernetes/kubernetes/pull/112557), [@marseel](https://github.com/marseel))
- For raw block CSI volumes on Kubernetes, kubelet was incorrectly calling CSI `NodeStageVolume` for every single "map" (i.e. raw block "mount") operation for a volume already attached to the node. This change modified that behavior to ensure it is only called once per volume per node. ([#112403](https://github.com/kubernetes/kubernetes/pull/112403), [@akankshakumari393](https://github.com/akankshakumari393))
- Improved `kubectl` display of invalid request errors returned by the API server ([#112150](https://github.com/kubernetes/kubernetes/pull/112150), [@liggitt](https://github.com/liggitt))
- Increase the maximum backoff delay of the endpointslice controller to match the expected sequence of delays when syncing Services. ([#112353](https://github.com/kubernetes/kubernetes/pull/112353), [@dgrisonnet](https://github.com/dgrisonnet)) [SIG Apps and Network]
- Kube-apiserver: redirect responses are no longer returned from backends by default. Set `--aggregator-reject-forwarding-redirect=false` to continue forwarding redirect responses. ([#112193](https://github.com/kubernetes/kubernetes/pull/112193), [@jindijamie](https://github.com/jindijamie)) [SIG API Machinery and Testing]
- Kube-apiserver: resolved a regression that treated `304 Not Modified` responses from aggregated API servers as internal errors ([#112526](https://github.com/kubernetes/kubernetes/pull/112526), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
- Kube-apiserver: x-kubernetes-list-type validation is now enforced when updating status of custom resources ([#111866](https://github.com/kubernetes/kubernetes/pull/111866), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery]
- Kube-proxy no longer falls back from ipvs mode to iptables mode if you ask it to do ipvs but the system is not correctly configured. Instead, it will just exit with an error. ([#111806](https://github.com/kubernetes/kubernetes/pull/111806), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Kube-scheduler: add taints filtering logic consistent with TaintToleration plugin for PodTopologySpread plugin ([#112357](https://github.com/kubernetes/kubernetes/pull/112357), [@SataQiu](https://github.com/SataQiu)) [SIG Scheduling and Testing]
- Kubeadm will cleanup the stale data on best effort basis. Stale data will be removed when each reset phase are executed, default etcd data directory will be cleanup when the `remove-etcd-member` phase are executed. ([#110972](https://github.com/kubernetes/kubernetes/pull/110972), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle]
- Kubeadm: allow RSA and ECDSA format keys in preflight check ([#112508](https://github.com/kubernetes/kubernetes/pull/112508), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: when a subcommand is needed but not provided for a kubeadm command, print a help screen instead of showing a short message. ([#111277](https://github.com/kubernetes/kubernetes/pull/111277), [@chymy](https://github.com/chymy)) [SIG Cluster Lifecycle]
- Log messages and metrics for the watch cache are now keyed by `<resource>.<group>` instead of `go` struct type. This means e.g. that `*v1.Pod` becomes `pods`. Additionally, resources that come from CustomResourceDefinitions are now displayed as the correct resource and group, instead of `*unstructured.Unstructured`. ([#111807](https://github.com/kubernetes/kubernetes/pull/111807), [@ncdc](https://github.com/ncdc)) [SIG API Machinery and Instrumentation]
- Moved `LocalStorageCapacityIsolationFSQuotaMonitoring` back to Alpha. ([#112076](https://github.com/kubernetes/kubernetes/pull/112076), [@rphillips](https://github.com/rphillips))
- Pod failed in scheduling due to expected error will be updated with the reason of "SchedulerError"
  rather than "Unschedulable" ([#111999](https://github.com/kubernetes/kubernetes/pull/111999), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling and Testing]
- Services of type LoadBalancer create fewer AWS security group rules in most cases ([#112267](https://github.com/kubernetes/kubernetes/pull/112267), [@sjenning](https://github.com/sjenning)) [SIG Cloud Provider]
- The errors in `k8s.io/apimachinery/pkg/api/meta` now support for the `stdlibs` `errors.Is` matching, including when wrapped ([#111808](https://github.com/kubernetes/kubernetes/pull/111808), [@alvaroaleman](https://github.com/alvaroaleman))
- The metrics etcd_request_duration_seconds and etcd_bookmark_counts now differentiate by group resource instead of object type, allowing unique entries per CustomResourceDefinition, instead of grouping them all under `*unstructured.Unstructured`. ([#112042](https://github.com/kubernetes/kubernetes/pull/112042), [@ncdc](https://github.com/ncdc)) [SIG API Machinery]
- Update the system-validators library to v1.8.0 ([#112026](https://github.com/kubernetes/kubernetes/pull/112026), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]

### Other (Cleanup or Flake)

- E2e: tests can now register callbacks with `ginkgo.BeforeEach`, `ginkgo.AfterEach` or `ginkgo.DeferCleanup` directly after creating a framework instance and are guaranteed that their code is called after the framework is initialized and before it gets cleaned up. `ginkgo.DeferCleanup` replaces `f.AddAfterEach` and `AddCleanupAction` which got removed to simplify the framework. ([#111998](https://github.com/kubernetes/kubernetes/pull/111998), [@pohly](https://github.com/pohly))
- Kube scheduler Component Config release version v1beta3 is deprecated in v1.26 and will be removed in v1.29,
  also v1beta2 will be removed in v1.28. ([#112257](https://github.com/kubernetes/kubernetes/pull/112257), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Kube-scheduler: the `DefaultPodTopologySpread`, `NonPreemptingPriority`, `PodAffinityNamespaceSelector` and `PreferNominatedNode` feature gates that graduated to GA in v1.24 and were unconditionally enabled have been removed in v1.26 ([#112567](https://github.com/kubernetes/kubernetes/pull/112567), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: remove the usage of the --container-runtime=remote flag for the kubelet during kubeadm init/join/upgrade. The flag value "remote" has been the only possible value since dockershim was removed from the kubelet. ([#112000](https://github.com/kubernetes/kubernetes/pull/112000), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: removed the toleration for the `node-role.kubernetes.io/master` taint from the CoreDNS deployment of `kubeadm`. With the 1.25 release of kubeadm the taint `node-role.kubernetes.io/master` is no longer applied to control plane nodes and the toleration for it can be removed with the release of 1.26. You can also perform the same toleration removal from your own addon manifests. ([#112008](https://github.com/kubernetes/kubernetes/pull/112008), [@pacoxu](https://github.com/pacoxu))
- NoneNone ([#111533](https://github.com/kubernetes/kubernetes/pull/111533), [@zhoumingcheng](https://github.com/zhoumingcheng)) [SIG CLI]
- Release-note ([#111708](https://github.com/kubernetes/kubernetes/pull/111708), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Apps, Instrumentation and Network]
- Scheduler dumper now exposes a summary to indicate the number of pending pods in each internal queue. ([#111726](https://github.com/kubernetes/kubernetes/pull/111726), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- The in-tree cloud provider for OpenStack (and the cinder volume provider) has now been removed. Please use the external cloud provider and csi driver from https://github.com/kubernetes/cloud-provider-openstack instead. ([#67782](https://github.com/kubernetes/kubernetes/pull/67782), [@dims](https://github.com/dims)) [SIG API Machinery, Apps, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node, Release, Scheduling, Storage and Testing]
- `GlusterFS` in-tree storage driver which was deprecated in kubernetes 1.25 release is now removed entirely in 1.26. ([#112015](https://github.com/kubernetes/kubernetes/pull/112015), [@humblec](https://github.com/humblec))
