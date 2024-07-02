# Kubernetes v1.14 Release Notes

## 1.14 What’s New

Support for Windows Nodes is Graduating to Stable ([#116](https://github.com/kubernetes/enhancements/issues/116) )

- Support for Windows Server 2019 for worker nodes and containers
- Support for out of tree networking with Azure-CNI, OVN-Kubernetes and Flannel
- Improved support for pods, service types, workload controllers and metrics/quotas to closely match the capabilities offered for Linux containers
kubernetes/enhancements: [#116](https://github.com/kubernetes/enhancements/issues/116) [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-windows/20190103-windows-node-support.md)]

Updated Plugin Mechanism for kubectl is Graduating to Stable ([#579](https://github.com/kubernetes/enhancements/issues/579))

- Extends functionality to kubectl to support extensions adding new commands as well as overriding specific subcommands (at any depth).
- Documentation fixes
kubernetes/enhancements: [#579](https://github.com/kubernetes/enhancements/issues/579) [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cli/0024-kubectl-plugins.md#summary)]

Durable Local Storage Management is Now GA ([#121](https://github.com/kubernetes/enhancements/issues/121#issuecomment-457396290))

- Makes locally attached (non-network attached) storage available as a persistent volume source.
- Allows users to take advantage of the typically cheaper and improved performance of persistent local storage
kubernetes/kubernetes: [#73525](https://github.com/kubernetes/kubernetes/pull/73525), [#74391](https://github.com/kubernetes/kubernetes/pull/74391), [#74769](http://github.com/kubernetes/kubernetes/pull/74769)
kubernetes/enhancements: [#121](https://github.com/kubernetes/enhancements/issues/121#issuecomment-457396290) [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-storage/20190124-local-persistent-volumes.md)]

Pid Limiting is Graduating to Beta ([#757](https://github.com/kubernetes/enhancements/issues/757))

- Prevents a pod from starving pid resource
- Ability to isolate pid resources pod-to-pod and node-to-pod
kubernetes/kubernetes: [#73651](http://github.com/kubernetes/kubernetes/pull/73651)
kubernetes/enhancements: [#757](https://github.com/kubernetes/enhancements/issues/757) [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190129-pid-limiting.md)]

Pod Priority and Preemption in Kubernetes ([#564](https://github.com/kubernetes/enhancements/issues/564))

- Pod priority and preemption enables Kubernetes scheduler to schedule more important Pods first and when cluster is out of resources, it removes less important pods to create room for more important ones. The importance is specified by priority.
kubernetes/kubernetes: [#73498](https://github.com/kubernetes/kubernetes/pull/73498), [#73555](https://github.com/kubernetes/kubernetes/pull/73555), [#74465](https://github.com/kubernetes/kubernetes/pull/74465)
kubernetes/enhancements: [#564](https://github.com/kubernetes/enhancements/issues/564)  [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-scheduling/20190131-pod-priority-preemption.md)]

Pod Ready++ ([#580](https://github.com/kubernetes/enhancements/issues/580))

- Introduces extension point for external feedback on pod readiness.
kubernetes/kubernetes: [#74434](http://github.com/kubernetes/kubernetes/pull/74434),
kubernetes/enhancements: [#580](https://github.com/kubernetes/enhancements/issues/580) [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/0007-pod-ready%2B%2B.md)]

Kubeadm: Automate certificate copy between control planes in HA setups

- Joining control plane nodes to a HA cluster can now be simplified by enabling the optional automatic copy of certificates from an existing control plane node.
- You can now use `kubeadm init --experimental-upload-certs` and `kubeadm join --experimental-control-plane --certificate-key`.
kubernetes/kubeadm: [#1373](https://github.com/kubernetes/kubeadm/issues/1373)
kubernetes/enhancements: [#357](https://github.com/kubernetes/enhancements/issues/357) [[kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cluster-lifecycle/20190122-Certificates-copy-for-kubeadm-join--control-plane.md)]

Kubeadm: Expose the `kubeadm join` workflow as phases

- The `kubeadm join` command can now be used in phases. Similar to the work that was done for `kubeadm init` in 1.13, in 1.14 the `join` phases can be now executed step-by-step/selectively using the `kubeadm join phase` sub-command. This makes it possible to further customize the workflow of joining nodes to the cluster.
kubernetes/kubeadm: [#1204](https://github.com/kubernetes/kubeadm/issues/1204)
kubernetes/enhancements: [kep](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cluster-lifecycle/0029-20180918-kubeadm-phases-beta.md)

## Known Issues

- There is a known issue [coredns/coredns#2629](https://github.com/coredns/coredns/issues/2629) in CoreDNS 1.3.1, wherein if the Kubernetes API shuts down while CoreDNS is connected, CoreDNS will crash. The issue is fixed in CoreDNS 1.4.0 in [coredns/coredns#2529](https://github.com/coredns/coredns/pull/2529).
- Kubelet might fail to restart if an existing flexvolume mounted pvc contains a large number of directories, or is full. [#75019](https://github.com/kubernetes/kubernetes/pull/75019)

## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

- kube-apiserver:
  - Default RBAC policy no longer grants access to discovery and permission-checking APIs (used by `kubectl auth can-i`) to *unauthenticated* users. Upgraded clusters preserve prior behavior, but cluster administrators wishing to grant unauthenticated users access in new clusters will need to explicitly opt-in to expose the discovery and/or permission-checking APIs:
    - `kubectl create clusterrolebinding anonymous-discovery --clusterrole=system:discovery --group=system:unauthenticated`
    - `kubectl create clusterrolebinding anonymous-access-review --clusterrole=system:basic-user --group=system:unauthenticated`
  - The deprecated --storage-versions flag has been removed. The storage versions will always be the default value built-in the kube-apiserver binary. ([#67678](https://github.com/kubernetes/kubernetes/pull/67678), [@caesarxuchao](https://github.com/caesarxuchao))
  - The deprecated `--repair-malformed-updates` flag has been removed ([#73663](https://github.com/kubernetes/kubernetes/pull/73663), [@danielqsj](https://github.com/danielqsj))
  - The `/swaggerapi/*` schema docs, deprecated since 1.7, have been removed in favor of the /openapi/v2 schema docs. ([#72924](https://github.com/kubernetes/kubernetes/pull/72924), [@liggitt](https://github.com/liggitt))
  - The /swagger.json and /swagger-2.0.0.pb-v1 schema documents, deprecated since v1.10, have been removed in favor of `/openapi/v2` ([#73148](https://github.com/kubernetes/kubernetes/pull/73148), [@liggitt](https://github.com/liggitt))
  - `kube-apiserver` now only aggregates openapi schemas from `/openapi/v2` endpoints of aggregated API servers. The fallback to aggregate from `/swagger.json` has been removed. Ensure aggregated API servers provide schema information via `/openapi/v2` (available since v1.10). ([#73441](https://github.com/kubernetes/kubernetes/pull/73441), [@roycaihw](https://github.com/roycaihw))
  - The OpenAPI definitions with the prefix "io.k8s.kubernetes.pkg" (deprecated since 1.9) have been removed. ([#74596](https://github.com/kubernetes/kubernetes/pull/74596), [@sttts](https://github.com/sttts))
  - The `ValidateProxyRedirects` feature was promoted to Beta and enabled by default. This feature restricts redirect-following from the apiserver to same-host redirects.  If nodes are configured to respond to CRI streaming requests on a different host interface than what the apiserver makes requests on (only the case if not using the built-in dockershim & setting the kubelet flag `--redirect-container-streaming=true`), then these requests will be broken. In that case, the feature can be temporarily disabled until the node configuration is corrected. We suggest setting `--redirect-container-streaming=false` on the kubelet to avoid issues.([#72552](https://github.com/kubernetes/kubernetes/pull/72552), [@tallclair](https://github.com/tallclair))

- kubectl
  - The deprecated `--show-all` flag to `kubectl get` has been removed  ([#69255](https://github.com/kubernetes/kubernetes/pull/69255), [@Pingan2017](https://github.com/Pingan2017))

- kubelet
  - The deprecated `--experimental-fail-swap-on` flag has been removed ([#69552](https://github.com/kubernetes/kubernetes/pull/69552), [@Pingan2017](https://github.com/Pingan2017))
  - Health check (liveness & readiness) probes using an HTTPGetAction will no longer follow redirects to different hostnames from the original probe request. Instead, these non-local redirects will be treated as a Success (the documented behavior). In this case an event with reason "ProbeWarning" will be generated, indicating that the redirect was ignored. If you were previously relying on the redirect to run health checks against different endpoints, you will need to perform the healthcheck logic outside the Kubelet, for instance by proxying the external endpoint rather than redirecting to it. ([#75416](https://github.com/kubernetes/kubernetes/pull/75416), [@tallclair](https://github.com/tallclair))

- client-go
  - The deprecated versionless API group accessors (like `clientset.Apps()`) have been removed. Use an explicit version instead (like `clientset.AppsV1()`) ([#74422](https://github.com/kubernetes/kubernetes/pull/74422), [@liggitt](https://github.com/liggitt))
  - The disk-cached discovery client is moved from k8s.io/client-go/discovery to k8s.io/client-go/discovery/cached/disk.
The memory-cached discovery client is moved from k8s.io/client-go/discovery/cached to k8s.io/client-go/discovery/cached/memory.
([#72214](https://github.com/kubernetes/kubernetes/pull/72214), [@caesarxuchao](https://github.com/caesarxuchao))

- kubeadm
  - `kubeadm alpha preflight` and `kubeadm alpha preflight node` are removed; you can now use `kubeadm join phase preflight` ([#73718](https://github.com/kubernetes/kubernetes/pull/73718), [@fabriziopandini](https://github.com/fabriziopandini))

- The deprecated taints `node.alpha.kubernetes.io/notReady` and `node.alpha.kubernetes.io/unreachable` are no longer supported or adjusted. These uses should be replaced with `node.kubernetes.io/not-ready` and `node.kubernetes.io/unreachable`
 ([#73001](https://github.com/kubernetes/kubernetes/pull/73001), [@shivnagarajan](https://github.com/shivnagarajan))

- Any Prometheus queries that match `pod_name` and `container_name` labels (e.g. cadvisor or kubelet probe metrics) should be updated to use `pod` and `container` instead. `pod_name` and `container_name` labels will be present alongside `pod` and `container` labels for one transitional release and removed in the future.
([#69099](https://github.com/kubernetes/kubernetes/pull/69099), [@ehashman](https://github.com/ehashman))

## Deprecations

- kubectl
  - `kubectl convert` is deprecated and will be removed in v1.17.
  - The `--export` flag for the `kubectl get` command is deprecated and will be removed in v1.18. ([#73787](https://github.com/kubernetes/kubernetes/pull/73787), [@soltysh](https://github.com/soltysh))

- kubelet
  - OS and Arch information is now recorded in `kubernetes.io/os` and `kubernetes.io/arch` labels on Node objects. The previous labels (`beta.kubernetes.io/os` and `beta.kubernetes.io/arch`) are still recorded, but are deprecated and targeted for removal in v1.18. ([#73333](https://github.com/kubernetes/kubernetes/pull/73333), [@yujuhong](https://github.com/yujuhong))
  - The `--containerized` flag is deprecated and will be removed in a future release ([#74267](https://github.com/kubernetes/kubernetes/pull/74267), [@dims](https://github.com/dims))

- hyperkube
  - The `--make-symlinks` flag is deprecated and will be removed in a future release. ([#74975](https://github.com/kubernetes/kubernetes/pull/74975), [@dims](https://github.com/dims))
- API
  - Ingress resources are now available via `networking.k8s.io/v1beta1`. Ingress resources in `extensions/v1beta1` are deprecated and will no longer be served in v1.18. Existing persisted data is available via the new API group/version  ([#74057](https://github.com/kubernetes/kubernetes/pull/74057), [@liggitt](https://github.com/liggitt))
  - NetworkPolicy resources will no longer be served from `extensions/v1beta1` in v1.16. Migrate use to the `networking.k8s.io/v1` API, available since v1.8. Existing persisted data can be retrieved via the `networking.k8s.io/v1` API.
  - PodSecurityPolicy resources will no longer be served from `extensions/v1beta1` in v1.16. Migrate to the `policy/v1beta1` API, available since v1.10. Existing persisted data can be retrieved via the `policy/v1beta1` API.
  - DaemonSet, Deployment, and ReplicaSet resources will no longer be served from `extensions/v1beta1`, `apps/v1beta1`, or `apps/v1beta2` in v1.16. Migrate to the `apps/v1` API, available since v1.9. Existing persisted data can be retrieved via the `apps/v1` API.
  - PriorityClass resources have been promoted to `scheduling.k8s.io/v1` with no changes. The `scheduling.k8s.io/v1beta1` and `scheduling.k8s.io/v1alpha1` versions are now deprecated and will stop being served by default in v1.17.  ([#73555](https://github.com/kubernetes/kubernetes/pull/73555), [#74465](https://github.com/kubernetes/kubernetes/pull/74465), [@bsalamat](https://github.com/bsalamat))
  - The `export` query parameter for list API calls is deprecated and will be removed in v1.18 ([#73783](https://github.com/kubernetes/kubernetes/pull/73783), [@deads2k](https://github.com/deads2k))
- The following features are now GA, and the associated feature gates are deprecated and will be removed in v1.15:
  - `CustomPodDNS`
  - `HugePages`
  - `MountPropagation`
  - `PersistentLocalVolumes`
- CoreDNS: The following directives or keywords are deprecated and will be removed in v1.15:
  - `upstream` option of `kubernetes` plugin, becoming default behavior in v1.15.
  - `proxy` plugin replaced by `forward` plugin

## Removed and deprecated metrics

### Removed metrics

- `reflector_items_per_list`
- `reflector_items_per_watch`
- `reflector_last_resource_version`
- `reflector_list_duration_seconds`
- `reflector_lists_total`
- `reflector_short_watches_total`
- `reflector_watch_duration_seconds`
- `reflector_watches_total`

### Deprecated metrics

- `rest_client_request_latency_seconds` -> `rest_client_request_duration_seconds`
- `apiserver_proxy_tunnel_sync_latency_secs` -> `apiserver_proxy_tunnel_sync_duration_seconds`
- `scheduler_scheduling_latency_seconds` -> `scheduler_scheduling_duration_seconds`
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
- `docker_operations` -> `docker_operations_total`
- `docker_operations_latency_microseconds` -> `docker_operations_latency_seconds`
- `docker_operations_errors` -> `docker_operations_errors_total`
- `docker_operations_timeout` -> `docker_operations_timeout_total`
- `network_plugin_operations_latency_microseconds` -> `network_plugin_operations_latency_seconds`
- `sync_proxy_rules_latency_microseconds` -> `sync_proxy_rules_latency_seconds`
- `apiserver_request_count` -> `apiserver_request_total`
- `apiserver_request_latencies` -> `apiserver_request_latency_seconds`
- `apiserver_request_latencies_summary` -> `apiserver_request_latency_seconds`
- `apiserver_dropped_requests` -> `apiserver_dropped_requests_total`
- `etcd_helper_cache_hit_count` -> `etcd_helper_cache_hit_total`
- `etcd_helper_cache_miss_count` -> `etcd_helper_cache_miss_total`
- `etcd_helper_cache_entry_count` -> `etcd_helper_cache_entry_total`
- `etcd_request_cache_get_latencies_summary` -> `etcd_request_cache_get_latency_seconds`
- `etcd_request_cache_add_latencies_summary` -> `etcd_request_cache_add_latency_seconds`
- `etcd_request_latencies_summary` -> `etcd_request_latency_seconds`
- `transformation_latencies_microseconds` -> `transformation_latencies_seconds`
- `data_key_generation_latencies_microseconds` -> `data_key_generation_latencies_seconds`

## Notable Features

- Increased the histogram resolution of the API server client certificate  to accommodate short-lived (< 6h) client certificates. ([#74806](https://github.com/kubernetes/kubernetes/pull/74806), [@mxinden](https://github.com/mxinden))
- Updated to use golang 1.12 ([#74632](https://github.com/kubernetes/kubernetes/pull/74632), [@cblecker](https://github.com/cblecker))
- The `RunAsGroup` feature has been promoted to beta and enabled by default. `PodSpec` and `PodSecurityPolicy` objects can be used to control the primary GID of containers on supported container runtimes. ([#73007](https://github.com/kubernetes/kubernetes/pull/73007), [@krmayankk](https://github.com/krmayankk))
- Added the same information to an init container as a standard container in a pod when using `PodPresets`. ([#71479](https://github.com/kubernetes/kubernetes/pull/71479), [@soggiest](https://github.com/soggiest))
- kube-conformance image will now run ginkgo with the `--dryRun` flag if the container is run with the environment variable E2E_DRYRUN set. ([#74731](https://github.com/kubernetes/kubernetes/pull/74731), [@johnSchnake](https://github.com/johnSchnake))
- Introduced dynamic volume provisioning shim for CSI migration ([#73653](https://github.com/kubernetes/kubernetes/pull/73653), [@ddebroy](https://github.com/ddebroy))
- Applied resources from a directory containing kustomization.yaml ([#74140](https://github.com/kubernetes/kubernetes/pull/74140), [@Liujingfang1](https://github.com/Liujingfang1))
- kubeadm: Allowed to download certificate secrets uploaded by `init` or `upload-certs` phase, allowing to transfer certificate secrets (certificates and keys) from the cluster to other master machines when creating HA deployments. ([#74168](https://github.com/kubernetes/kubernetes/pull/74168), [@ereslibre](https://github.com/ereslibre))
- The `--quiet` option to `kubectl run` now suppresses resource deletion messages emitted when the `--rm` option is specified. ([#73266](https://github.com/kubernetes/kubernetes/pull/73266), [@awh](https://github.com/awh))
- Added Custom Resource support to `kubectl autoscale` ([#72678](https://github.com/kubernetes/kubernetes/pull/72678), [@rmohr](https://github.com/rmohr))
- Cinder volume limit can now be configured from node too ([#74542](https://github.com/kubernetes/kubernetes/pull/74542), [@gnufied](https://github.com/gnufied))
- It is now possible to combine the `-f` and `-l` flags in `kubectl logs` ([#67573](https://github.com/kubernetes/kubernetes/pull/67573), [@m1kola](https://github.com/m1kola))
- New conformance tests added for API Aggregation. ([#63947](https://github.com/kubernetes/kubernetes/pull/63947), [@jennybuckley](https://github.com/jennybuckley))
- Moved fluentd-elasticsearch addon images to community controlled location ([#73819](https://github.com/kubernetes/kubernetes/pull/73819), [@coffeepac](https://github.com/coffeepac))
- Removed local etcd members from the etcd cluster when `kubeadm reset` ([#74112](https://github.com/kubernetes/kubernetes/pull/74112), [@pytimer](https://github.com/pytimer))
- kubeadm will now not fail preflight checks when running on >= 5.0 Linux kernel ([#74355](https://github.com/kubernetes/kubernetes/pull/74355), [@brb](https://github.com/brb))
- Scheduler cache snapshot algorithm has been optimized to improve scheduling throughput. ([#74041](https://github.com/kubernetes/kubernetes/pull/74041), [@bsalamat](https://github.com/bsalamat))
- It is now possible to upload certificates required to join a new control-plane to kubeadm-certs secret using the flag `--experimental-upload-certs` on `init` or upload-certs phase. ([#73907](https://github.com/kubernetes/kubernetes/pull/73907), [@yagonobre](https://github.com/yagonobre))
[@RobertKrawitz](https://github.com/RobertKrawitz))
- `kubectl auth reconcile` now outputs details about what changes are being made ([#71564](https://github.com/kubernetes/kubernetes/pull/71564), [@liggitt](https://github.com/liggitt))
- Added Kustomize as a subcommand in kubectl ([#73033](https://github.com/kubernetes/kubernetes/pull/73033), [@Liujingfang1](https://github.com/Liujingfang1))
- Added `kubelet_node_name` metrics. ([#72910](https://github.com/kubernetes/kubernetes/pull/72910), [@danielqsj](https://github.com/danielqsj))
- Updated AWS SDK to v1.16.26 for ECR PrivateLink support ([#73435](https://github.com/kubernetes/kubernetes/pull/73435), [@micahhausler](https://github.com/micahhausler))
- Expanded `kubectl wait` to work with more types of selectors. ([#71746](https://github.com/kubernetes/kubernetes/pull/71746), [@rctl](https://github.com/rctl))
([#72832](https://github.com/kubernetes/kubernetes/pull/72832), [@MrHohn](https://github.com/MrHohn))
- Added configuration for AWS endpoint fine control: ([#72245](https://github.com/kubernetes/kubernetes/pull/72245), [@ampsingram](https://github.com/ampsingram))
- The CoreDNS configuration now has the forward plugin for proxy in the default configuration instead of the proxy plugin.  ([#73267](https://github.com/kubernetes/kubernetes/pull/73267), [@rajansandeep](https://github.com/rajansandeep))
- Added alpha field storageVersionHash to the discovery document for each resource. Its value must be treated as opaque by clients. Only equality comparison on the value is valid. ([#73191](https://github.com/kubernetes/kubernetes/pull/73191), [@caesarxuchao](https://github.com/caesarxuchao))
- If you are running the cloud-controller-manager and you have the `pvlabel.kubernetes.io` alpha Initializer enabled, you must now enable PersistentVolume labeling using the `PersistentVolumeLabel` admission controller instead. You can do this by adding `PersistentVolumeLabel` in the `--enable-admission-plugins` kube-apiserver flag.  ([#73102](https://github.com/kubernetes/kubernetes/pull/73102), [@andrewsykim](https://github.com/andrewsykim))
- kubectl supports copying files with wild card ([#72641](https://github.com/kubernetes/kubernetes/pull/72641), [@dixudx](https://github.com/dixudx))
- kubeadm now attempts to detect an installed CRI by its usual domain socket, so that `--cri-socket` can be omitted from the command line if Docker is not used and there is a single CRI installed. ([#69366](https://github.com/kubernetes/kubernetes/pull/69366), [@rosti](https://github.com/rosti))
- `CSINodeInfo` and `CSIDriver` CRDs have been installed in the local cluster. ([#72584](https://github.com/kubernetes/kubernetes/pull/72584), [@xing-yang](https://github.com/xing-yang))
- Node OS/arch labels have been promoted to GA ([#73048](https://github.com/kubernetes/kubernetes/pull/73048), [@yujuhong](https://github.com/yujuhong))
- Added support for max attach limit for Cinder ([#72980](https://github.com/kubernetes/kubernetes/pull/72980), [@gnufied](https://github.com/gnufied))
- Enabled mTLS encryption between etcd and kube-apiserver in GCE ([#70144](https://github.com/kubernetes/kubernetes/pull/70144), [@wenjiaswe](https://github.com/wenjiaswe))
- Added `ResourceVersion` as a precondition for delete in order to ensure a delete fails if an unobserved change happens to an object. ([#74040](https://github.com/kubernetes/kubernetes/pull/74040), [@ajatprabha](https://github.com/ajatprabha))
- There is now support for collecting pod logs under `/var/log/pods/NAMESPACE_NAME_UID` to stackdriver with `k8s_pod` resource type. ([#74502](https://github.com/kubernetes/kubernetes/pull/74502), [@Random-Liu](https://github.com/Random-Liu))
- Changed CRI pod log directory from `/var/log/pods/UID` to `/var/log/pods/NAMESPACE_NAME_UID`. ([#74441](https://github.com/kubernetes/kubernetes/pull/74441), [@Random-Liu](https://github.com/Random-Liu))
- `RuntimeClass` has been promoted to beta, and is enabled by default. ([#75003](https://github.com/kubernetes/kubernetes/pull/75003), [@tallclair](https://github.com/tallclair))
- New "dry_run" metric label (indicating the value of the dryRun query parameter) has been added into the metrics:
* apiserver_request_total
* apiserver_request_duration_seconds
New "APPLY" value for the "verb" metric label which indicates a PATCH with "Content-Type: apply-patch+yaml". This value is experimental and will only be present if the ServerSideApply alpha feature is enabled. ([#74997](https://github.com/kubernetes/kubernetes/pull/74997), [@jennybuckley](https://github.com/jennybuckley))
- GCE: bumped COS image version to `cos-beta-73-11647-64-0` ([#75149](https://github.com/kubernetes/kubernetes/pull/75149), [@yguo0905](https://github.com/yguo0905))
- Added alpha support for ephemeral CSI inline volumes that are embedded in pod specs. ([#74086](https://github.com/kubernetes/kubernetes/pull/74086), [@vladimirvivien](https://github.com/vladimirvivien))

## API Changes

- [CRI] Added a new field called `runtime_handler` into `PodSandbox` and `PodSandboxStatus` to track the `RuntimeClass` information of a pod. ([#73833](https://github.com/kubernetes/kubernetes/pull/73833), [@haiyanmeng](https://github.com/haiyanmeng))

## Detailed Bug Fixes And Changes

### API Machinery

- client-go: `PortForwarder.GetPorts()` now contain correct local port if no local port was initially specified when setting up the port forwarder ([#73676](https://github.com/kubernetes/kubernetes/pull/73676), [@martin-helmich](https://github.com/martin-helmich))
- Fixed an issue with missing `apiVersion/kind` in object data sent to admission webhooks ([#74448](https://github.com/kubernetes/kubernetes/pull/74448), [@liggitt](https://github.com/liggitt))
- Prometheus metrics for `crd_autoregister`, `crd_finalizer` and `crd_naming_condition_controller` are exported. ([#71767](https://github.com/kubernetes/kubernetes/pull/71767), [@roycaihw](https://github.com/roycaihw))
- Fixed admission metrics in seconds. ([#72343](https://github.com/kubernetes/kubernetes/pull/72343), [@danielqsj](https://github.com/danielqsj))
- When a watch is closed by an HTTP2 load balancer and we are told to go away, skip printing the message to stderr by default.
- Spedup kubectl by >10 when calling out to kube-apiserver for discovery information. ([#73345](https://github.com/kubernetes/kubernetes/pull/73345), [@sttts](https://github.com/sttts))
- Fixed watch to not send the same set of events multiple times causing watcher to go back in time ([#73845](https://github.com/kubernetes/kubernetes/pull/73845), [@wojtek-t](https://github.com/wojtek-t))
([#73277](https://github.com/kubernetes/kubernetes/pull/73277), [@smarterclayton](https://github.com/smarterclayton))
- Fix kube-apiserver not to create default/kubernetes service endpoints before it reports readiness via the /healthz and therefore is ready to serve requests. Also early during startup old endpoints are remove which might be left over from a previously crashed kube-apiserver. ([#74668](https://github.com/kubernetes/kubernetes/pull/74668), [@sttts](https://github.com/sttts))
- Add a configuration field to shorten the timeout of validating/mutating admission webhook call. The timeout value must be between 1 and 30 seconds. Default to 30 seconds when unspecified.  ([#74562](https://github.com/kubernetes/kubernetes/pull/74562), [@roycaihw](https://github.com/roycaihw))
- The apiserver, including both the kube-apiserver and apiservers built with the generic apiserver library, will now return 413 RequestEntityTooLarge error if a json patch contains more than 10,000 operations. ([#74000](https://github.com/kubernetes/kubernetes/pull/74000), [@caesarxuchao](https://github.com/caesarxuchao))
- Fixed an error processing watch events when running skewed apiservers ([#73482](https://github.com/kubernetes/kubernetes/pull/73482), [@liggitt](https://github.com/liggitt))
- jsonpath expressions containing `[start:end:step]` slice are now evaluated correctly ([#73149](https://github.com/kubernetes/kubernetes/pull/73149), [@liggitt](https://github.com/liggitt))
- `metadata.deletionTimestamp` is no longer moved into the future when issuing repeated DELETE requests against a resource containing a finalizer. ([#73138](https://github.com/kubernetes/kubernetes/pull/73138), [@liggitt](https://github.com/liggitt))
- Fixed kube-apiserver not to create default/kubernetes service endpoints before it reports readiness via the /healthz and therefore is ready to serve requests. Also early during startup old endpoints are remove which might be left over from a previously crashed kube-apiserver. ([#74668](https://github.com/kubernetes/kubernetes/pull/74668), [@sttts](https://github.com/sttts))
- `watch.Until` now works for long durations. ([#67350](https://github.com/kubernetes/kubernetes/pull/67350), [@tnozicka](https://github.com/tnozicka))
- Added duration metric for CRD webhook converters. ([#74376](https://github.com/kubernetes/kubernetes/pull/74376), [@mbohlool](https://github.com/mbohlool))
- Fixed keymutex issues which may crash in some platforms. ([#74348](https://github.com/kubernetes/kubernetes/pull/74348), [@danielqsj](https://github.com/danielqsj))
- Considerably reduced the CPU load in kube-apiserver while aggregating OpenAPI specifications from aggregated API servers. ([#71223](https://github.com/kubernetes/kubernetes/pull/71223), [@sttts](https://github.com/sttts))
- Fixed graceful apiserver shutdown to not drop outgoing bytes before the process terminates. ([#72970](https://github.com/kubernetes/kubernetes/pull/72970), [@sttts](https://github.com/sttts))

### Apps

- Added deleting pods created by `DaemonSet` assigned to not existing nodes. ([#73401](https://github.com/kubernetes/kubernetes/pull/73401), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- Pod eviction now honors graceful deletion by default if no delete options are provided in the eviction request. ([#72730](https://github.com/kubernetes/kubernetes/pull/72730), [@liggitt](https://github.com/liggitt))

### Auth

- Added `kubectl auth can-i --list` option, which allows users to  know what actions they can do in specific namespaces. ([#64820](https://github.com/kubernetes/kubernetes/pull/64820), [@WanLinghao](https://github.com/WanLinghao))
- The `rules` field in RBAC `Role` and `ClusterRole` objects is now correctly reported as optional in the openapi schema. ([#73250](https://github.com/kubernetes/kubernetes/pull/73250), [@liggitt](https://github.com/liggitt))
- `system:kube-controller-manager` and `system:kube-scheduler` users are now permitted to perform delegated authentication/authorization checks by default RBAC policy ([#72491](https://github.com/kubernetes/kubernetes/pull/72491), [@liggitt](https://github.com/liggitt))
- Error messages returned in authentication webhook status responses are now correctly included in the apiserver log ([#73595](https://github.com/kubernetes/kubernetes/pull/73595), [@liggitt](https://github.com/liggitt))
- Fixed use of webhook admission plugins with multi-version custom resources ([#74154](https://github.com/kubernetes/kubernetes/pull/74154), [@mbohlool](https://github.com/mbohlool))

### AWS

- Prevented AWS Network Load Balancer security groups ingress rules to be deleted by ensuring target groups are tagged. ([#73594](https://github.com/kubernetes/kubernetes/pull/73594), [@masterzen](https://github.com/masterzen))
- AWS ELB health checks will now use HTTPS/SSL protocol for HTTPS/SSL backends. ([#70309](https://github.com/kubernetes/kubernetes/pull/70309), [@2rs2ts](https://github.com/2rs2ts))

### Azure

- Fixed failure to detach Azure disk when there is server side error ([#74398](https://github.com/kubernetes/kubernetes/pull/74398), [@andyzhangx](https://github.com/andyzhangx))
- Fixed subnet annotation checking for Azure internal loadbalancer ([#74498](https://github.com/kubernetes/kubernetes/pull/74498), [@feiskyer](https://github.com/feiskyer))
- Fixed mixed protocol issue for Azure load balancer ([#74200](https://github.com/kubernetes/kubernetes/pull/74200), [@andyzhangx](https://github.com/andyzhangx))
- Fixed Azure accounts timeout issue when there is no out-bound IP ([#74191](https://github.com/kubernetes/kubernetes/pull/74191), [@andyzhangx](https://github.com/andyzhangx))
- Fixed Azure Container Registry anonymous repo image pull error ([#74715](https://github.com/kubernetes/kubernetes/pull/74715), [@andyzhangx](https://github.com/andyzhangx))
- Fixed parse devicePath issue on Azure Disk  ([#74499](https://github.com/kubernetes/kubernetes/pull/74499), [@andyzhangx](https://github.com/andyzhangx))

### CLI

- Fixed `--help` flag parsing  ([#74682](https://github.com/kubernetes/kubernetes/pull/74682), [@soltysh](https://github.com/soltysh))
- Fixed a bug where `kubectl describe` cannot obtain the event messages for a static pod ([#74156](https://github.com/kubernetes/kubernetes/pull/74156), [@gaorong](https://github.com/gaorong))
- Fixed panic when performing a `set env` operation on a `--local` resource ([#65636](https://github.com/kubernetes/kubernetes/pull/65636), [@juanvallejo](https://github.com/juanvallejo))
- Missing directories listed in a user's PATH are no longer considered errors and are instead logged by the `kubectl plugin list` command when listing available plugins. ([#73542](https://github.com/kubernetes/kubernetes/pull/73542), [@juanvallejo](https://github.com/juanvallejo))
- Now users can get object info like:

  ```bash
    a. kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0:3].name
    b. kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[-2:].name
  ```

([#73063](https://github.com/kubernetes/kubernetes/pull/73063), [@WanLinghao](https://github.com/WanLinghao))

- The `kubectl api-resources` command will no longer fail to display any resources on a single failure  ([#73035](https://github.com/kubernetes/kubernetes/pull/73035), [@juanvallejo](https://github.com/juanvallejo))
- kubectl now loads config file once and uses persistent client config ([#71117](https://github.com/kubernetes/kubernetes/pull/71117), [@dixudx](https://github.com/dixudx))
- Printed `SizeLimit` of `EmptyDir` in `kubectl describe pod` outputs. ([#69279](https://github.com/kubernetes/kubernetes/pull/69279), [@dtaniwaki](https://github.com/dtaniwaki))
- `kubectl delete --all-namespaces` is now a recognized flag. ([#73716](https://github.com/kubernetes/kubernetes/pull/73716), [@deads2k](https://github.com/deads2k))

### Cloud Provider

- Fixed a bug that caused PV allocation on non-English vSphere installations to fail  ([#73115](https://github.com/kubernetes/kubernetes/pull/73115), [@alvaroaleman](https://github.com/alvaroaleman))

### Cluster Lifecycle

- kubeadm: fixed nil pointer dereference caused by a bug in url parsing ([#74454](https://github.com/kubernetes/kubernetes/pull/74454), [@bart0sh](https://github.com/bart0sh))
- CoreDNS adds readinessProbe which prevents loadbalancing to unready pods, and also allows rolling updates to work as expected. ([#74137](https://github.com/kubernetes/kubernetes/pull/74137), [@rajansandeep](https://github.com/rajansandeep))
- kubeadm no longer allows using v1alpha3 configs for anything else than converting them to `v1beta1`. ([#74025](https://github.com/kubernetes/kubernetes/pull/74025), [@rosti](https://github.com/rosti))
- kubeadm: now allows the usage of `--kubeconfig-dir` and `--config` flags on kubeadm init ([#73998](https://github.com/kubernetes/kubernetes/pull/73998), [@yagonobre](https://github.com/yagonobre))
- kubeadm: all master components are now exclusively relying on the `PriorityClassName` pod spec for annotating them as cluster critical components. Since `scheduler.alpha.kubernetes.io/critical-pod` annotation is no longer supported by Kubernetes 1.14 this annotation is no longer added to master components. ([#73857](https://github.com/kubernetes/kubernetes/pull/73857), [@ereslibre](https://github.com/ereslibre))
- kubeadm no longer dumps backtrace if it fails to remove the running containers on reset. ([#73951](https://github.com/kubernetes/kubernetes/pull/73951), [@rosti](https://github.com/rosti))
- kubeadm: fixed a bug in the underlying library for diff related to characters like '%' ([#73941](https://github.com/kubernetes/kubernetes/pull/73941), [@neolit123](https://github.com/neolit123))
- Scale max-inflight now limits together with master VM sizes. ([#73268](https://github.com/kubernetes/kubernetes/pull/73268), [@wojtek-t](https://github.com/wojtek-t))
- kubeadm reset: fixed a crash caused by the absence of a configuration file ([#73636](https://github.com/kubernetes/kubernetes/pull/73636), [@bart0sh](https://github.com/bart0sh))
- CoreDNS is now version 1.3.1 ([#73610](https://github.com/kubernetes/kubernetes/pull/73610), [@rajansandeep](https://github.com/rajansandeep))
- kubeadm: When certificates are present in joining a new control plane now ensures that they match at least the required SANs ([#73093](https://github.com/kubernetes/kubernetes/pull/73093), [@ereslibre](https://github.com/ereslibre))
- kubeadm: added back `--cert-dir` option for `kubeadm init phase certs sa` ([#73239](https://github.com/kubernetes/kubernetes/pull/73239), [@mattkelly](https://github.com/mattkelly))
- kubeadm: now explicitly waits for `etcd` to have grown when joining a new control plane ([#72984](https://github.com/kubernetes/kubernetes/pull/72984), [@ereslibre](https://github.com/ereslibre))
- kubeadm: now pulls images when joining a new control plane instance ([#72870](https://github.com/kubernetes/kubernetes/pull/72870), [@MalloZup](https://github.com/MalloZup))
- Exited kube-proxy when configuration file changes ([#59176](https://github.com/kubernetes/kubernetes/pull/59176), [@dixudx](https://github.com/dixudx))
- kube-addon-manager was updated to v9.0, and now uses kubectl v1.13.2 and prunes workload resources via the apps/v1 API ([#72978](https://github.com/kubernetes/kubernetes/pull/72978), [@liggitt](https://github.com/liggitt))
- kubeadm: Now allows certain certs/keys to be missing on the secret when transferring secrets using `--experimental-upload-certs` feature ([#75415](https://github.com/kubernetes/kubernetes/pull/75415), [@ereslibre](https://github.com/ereslibre))

### GCP

- Fixed liveness probe in fluentd-gcp cluster addon ([#74522](https://github.com/kubernetes/kubernetes/pull/74522), [@Pluies](https://github.com/Pluies))
- Reduced GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#72062](https://github.com/kubernetes/kubernetes/pull/72062), [@jpbetz](https://github.com/jpbetz))

### Network

- Reduces the cache TTL for negative responses to 5s minimum. ([#74093](https://github.com/kubernetes/kubernetes/pull/74093), [@blakebarnett](https://github.com/blakebarnett))

### Node

- Fixed help message for `--container-runtime-endpoint`: only unix socket is support on Linux. ([#74712](https://github.com/kubernetes/kubernetes/pull/74712), [@feiskyer](https://github.com/feiskyer))
- Image garbage collection no longer fails for images with only one tag but more than one repository associated. ([#70647](https://github.com/kubernetes/kubernetes/pull/70647), [@corvus-ch](https://github.com/corvus-ch))
- Re-issued Allocate grpc calls before starting a container that requests device-plugin resources if the cached state is missing. ([#73824](https://github.com/kubernetes/kubernetes/pull/73824), [@jiayingz](https://github.com/jiayingz))
- [CRI] Added a new field called `runtime_handler` into `PodSandbox` and `PodSandboxStatus` to track the `RuntimeClass` information of a pod. ([#73833](https://github.com/kubernetes/kubernetes/pull/73833), [@haiyanmeng](https://github.com/haiyanmeng))
- Kubelet now tries to stop containers in unknown state once before restart or remove. ([#73802](https://github.com/kubernetes/kubernetes/pull/73802), [@Random-Liu](https://github.com/Random-Liu))
- When pleg channel is full, events are now discarded and count is recorded ([#72709](https://github.com/kubernetes/kubernetes/pull/72709), [@changyaowei](https://github.com/changyaowei))
- Fixed the unexpected `NotReady` status when Node's iops is full if the runtime is dockershim. ([#74389](https://github.com/kubernetes/kubernetes/pull/74389), [@answer1991](https://github.com/answer1991))
- Fixed #73264 `cpuPeriod` was not reset, but used as set via flag, although it was disabled via alpha gate ([#73342](https://github.com/kubernetes/kubernetes/pull/73342), [@szuecs](https://github.com/szuecs))
- Updated kubelet CLI summary documentation and generated webpage ([#73256](https://github.com/kubernetes/kubernetes/pull/73256), [@deitch](https://github.com/deitch))
- Set a low `oom_score_adj` for containers in pods with system-critical priorities ([#73758](https://github.com/kubernetes/kubernetes/pull/73758), [@sjenning](https://github.com/sjenning))
- kubelet: Resolved hang/timeout issues when running large numbers of pods with unique `ConfigMap/Secret` references ([#74755](https://github.com/kubernetes/kubernetes/pull/74755), [@liggitt](https://github.com/liggitt))
- Events reported for container creation, start, and stop now report the container name in the message and are more consistently formatted. ([#73892](https://github.com/kubernetes/kubernetes/pull/73892), [@smarterclayton](https://github.com/smarterclayton))
- Removed stale `OutOfDisk` condition from kubelet side ([#72507](https://github.com/kubernetes/kubernetes/pull/72507), [@dixudx](https://github.com/dixudx))
- Fixed the setting of `NodeAddresses` when using the vSphere CloudProvider and nodes that have multiple IP addresses. ([#70805](https://github.com/kubernetes/kubernetes/pull/70805), [@danwinship](https://github.com/danwinship))
- Fixed dockershim panic issues when deleting docker images. ([#75367](https://github.com/kubernetes/kubernetes/pull/75367), [@feiskyer](https://github.com/feiskyer))
- Kubelet no longer watches `ConfigMaps` and `Secrets` for terminated pods, in worst scenario causing it to not be able to send other requests to kube-apiserver ([#74809](https://github.com/kubernetes/kubernetes/pull/74809), [@oxddr](https://github.com/oxddr))
- A new `TaintNodesByCondition` admission plugin taints newly created Node objects as "not ready", to fix a race condition that could cause pods to be scheduled on new nodes before their taints were updated to accurately reflect their reported conditions. This admission plugin is enabled by default if the `TaintNodesByCondition` feature is enabled. ([#73097](https://github.com/kubernetes/kubernetes/pull/73097), [@bsalamat](https://github.com/bsalamat))
- kubelet now accepts `pid=<number>` in the `--system-reserved` and `--kube-reserved` options to ensure that the specified number of process IDs will be reserved for the system as a whole and for Kubernetes system daemons respectively.  Please reference `Kube Reserved` and `System Reserved` in `Reserve Compute Resources for System Daemons` in the Kubernetes documentation for general discussion of resource reservation.  To utilize this functionality, you must set the feature gate `SupportNodePidsLimit=true` ([#73651](https://github.com/kubernetes/kubernetes/pull/73651)

### Scheduling

- Improved fairness of the scheduling queue by placing pods which are attempted recently behind other pods with the same priority. ([#73700](https://github.com/kubernetes/kubernetes/pull/73700), [@denkensk](https://github.com/denkensk))
- Improved scheduler robustness to ensure that unschedulable pods are reconsidered for scheduling when appropriate. ([#73700](https://github.com/kubernetes/kubernetes/pull/73700), [#72558](https://github.com/kubernetes/kubernetes/pull/72558), [@denkensk](https://github.com/denkensk), [#73078](https://github.com/kubernetes/kubernetes/pull/73078), [@Huang-Wei](https://github.com/Huang-Wei))

### Storage

- Fixed scanning of failed iSCSI targets. ([#74306](https://github.com/kubernetes/kubernetes/pull/74306), [@jsafrane](https://github.com/jsafrane))
- StorageOS volume plugin updated to fix an issue where volume mount succeeds even if request to mount via StorageOS API fails. ([#69782](https://github.com/kubernetes/kubernetes/pull/69782), [@darkowlzz](https://github.com/darkowlzz))
- Ensured directories on volumes are group-executable when using `fsGroup` ([#73533](https://github.com/kubernetes/kubernetes/pull/73533), [@mxey](https://github.com/mxey))
- Updated CSI version to 1.1 ([#75391](https://github.com/kubernetes/kubernetes/pull/75391), [@gnufied](https://github.com/gnufied))
- Ensured that volumes get provisioned based on the zone information provided in `allowedTopologies`. ([#72731](https://github.com/kubernetes/kubernetes/pull/72731), [@skarthiksrinivas](https://github.com/skarthiksrinivas))
- Extended the `VolumeSubpathEnvExpansion` alpha feature to support environment variable expansion ([#71351](https://github.com/kubernetes/kubernetes/pull/71351), [@kevtaylor](https://github.com/kevtaylor))
- Fixed a bug that prevented deletion of dynamically provisioned volumes in Quobyte backends. ([#68925](https://github.com/kubernetes/kubernetes/pull/68925), [@casusbelli](https://github.com/casusbelli))

### Testing

- e2e storage tests now run faster and are easier to read ([#72434](https://github.com/kubernetes/kubernetes/pull/72434), [@pohly](https://github.com/pohly))
- `e2e.test` now rejects unknown `--provider` values instead of merely warning about them. An empty provider name is not accepted anymore and was replaced by `skeleton` (a provider with no special behavior). ([#73402](https://github.com/kubernetes/kubernetes/pull/73402), [@pohly](https://github.com/pohly))
- Updated to go1.11.5 ([#73326](https://github.com/kubernetes/kubernetes/pull/73326), [@ixdy](https://github.com/ixdy))
- Updated to use go1.12.1 ([#75413](https://github.com/kubernetes/kubernetes/pull/75413), [@BenTheElder](https://github.com/BenTheElder))
- e2e tests that require SSH may now be used against clusters that have nodes without external IP addresses by setting the environment variable `KUBE_SSH_BASTION` to the `host:port` of a machine that is allowed to SSH to those nodes.  The same private key that the test would use is used for the bastion host.  The test connects to the bastion and then tunnels another SSH connection to the node. ([#72286](https://github.com/kubernetes/kubernetes/pull/72286), [@smarterclayton](https://github.com/smarterclayton))
- `PidPressure` now evicts pods from lowest priority to highest priority ([#72844](https://github.com/kubernetes/kubernetes/pull/72844), [@dashpole](https://github.com/dashpole))
- Split up the mondo `kubernetes-test` tarball into `kubernetes-test-portable` and `kubernetes-test-{OS}-{ARCH}` tarballs. ([#74065](https://github.com/kubernetes/kubernetes/pull/74065), [@ixdy](https://github.com/ixdy))

### VMware

- Applied zone labels to vSphere Volumes automatically. The zone labels are visible on the PV: ([#72687](https://github.com/kubernetes/kubernetes/pull/72687), [@subramanian-neelakantan](https://github.com/subramanian-neelakantan))

### Windows

Support for Windows nodes and Windows containers went going stable.

Support for Group Managed Service Accounts (GMSA) for Windows containers in Kubernetes. GMSA are a specific type of Active Directory account that provides automatic password management, simplified service principal name (SPN) management, and the ability to delegate the management to other administrators across multiple servers.

- Fixed smb remount and unmount issues on Windows ([#73661](https://github.com/kubernetes/kubernetes/pull/73661), [@andyzhangx](https://github.com/andyzhangx), [#75087](https://github.com/kubernetes/kubernetes/pull/75087), [@andyzhangx](https://github.com/andyzhangx))
- Added network stats for Windows nodes and containers ([#74788](https://github.com/kubernetes/kubernetes/pull/74788), [@feiskyer](https://github.com/feiskyer))
- The new test `[sig-network] DNS should now provide /etc/hosts entries for the cluster [LinuxOnly] [Conformance]` will validate the host entries set in the ``/etc/hosts`` file (pod's FQDN and hostname), which should be managed by Kubelet. ([#72729](https://github.com/kubernetes/kubernetes/pull/72729), [@bclau](https://github.com/bclau))
- Allowed the kubelet to pass Windows GMSA credentials down to Docker ([#73726](https://github.com/kubernetes/kubernetes/pull/73726), [@wk8](https://github.com/wk8))
- Added kube-proxy support for overlay networking and DSR in Windows and new flags for `network-name`, `source-vip`, and `enable-dsr`. ([#70896](https://github.com/kubernetes/kubernetes/pull/70896), [@ksubrmnn](https://github.com/ksubrmnn))
- windows: Ensured graceful termination when being run as windows service ([#73292](https://github.com/kubernetes/kubernetes/pull/73292), [@steffengy](https://github.com/steffengy))
- vSphere cloud provider now correctly retrieves the VM's UUID when running on Windows ([#71147](https://github.com/kubernetes/kubernetes/pull/71147), [@benmoss](https://github.com/benmoss))
- Kubelet: added `usageNanoCores` from CRI stats provider ([#73659](https://github.com/kubernetes/kubernetes/pull/73659), [@feiskyer](https://github.com/feiskyer))
- Introduced support for Windows nodes into the cluster bringup scripts for GCE. ([#73442](https://github.com/kubernetes/kubernetes/pull/73442), [@pjh](https://github.com/pjh))
- Added network stats for Windows nodes and pods. ([#70121](https://github.com/kubernetes/kubernetes/pull/70121), [@feiskyer](https://github.com/feiskyer))
- CoreDNS is only officially supported on Linux at this time.  As such, when kubeadm is used to deploy this component into your kubernetes cluster, it will be restricted (using `nodeSelectors`) to run only on nodes with that operating system. This ensures that in clusters which include Windows nodes, the scheduler will not ever attempt to place CoreDNS pods on these machines, reducing setup latency and enhancing initial cluster stability. ([#69940](https://github.com/kubernetes/kubernetes/pull/69940), [@MarcPow](https://github.com/MarcPow))

## External Dependencies

- Default etcd server and client have been updated to v3.3.10. ([#71615](https://github.com/kubernetes/kubernetes/pull/71615), [#70168](https://github.com/kubernetes/kubernetes/pull/70168))
- The list of validated docker versions has changed. 1.11.1 and 1.12.1 have been removed. The current list is 1.13.1, 17.03, 17.06, 17.09, 18.06, 18.09. ([#72823](https://github.com/kubernetes/kubernetes/pull/72823), [#72831](https://github.com/kubernetes/kubernetes/pull/72831))
- The default Go version was updated to 1.12.1. ([#75422](https://github.com/kubernetes/kubernetes/pull/75422))
- CNI has been updated to v0.7.5 ([#75455](https://github.com/kubernetes/kubernetes/pull/75455))
- CSI has been updated to v1.1.0. ([#75391](https://github.com/kubernetes/kubernetes/pull/75391))
- The dashboard add-on has been updated to v1.10.1. ([#72495](https://github.com/kubernetes/kubernetes/pull/72495))
- Cluster Autoscaler has been updated to v1.14.0 ([#75480](https://github.com/kubernetes/kubernetes/pull/75480))
- kube-dns is unchanged at v1.14.13 since Kubernetes 1.12 ([#68900](https://github.com/kubernetes/kubernetes/pull/68900))
- Influxdb is unchanged at v1.3.3 since Kubernetes 1.10 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Grafana is unchanged at v4.4.3 since Kubernetes 1.10 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Kibana has been upgraded to v6.6.1. ([#71251](https://github.com/kubernetes/kubernetes/pull/71251))
- CAdvisor has been updated to v0.33.1 ([#75140](https://github.com/kubernetes/kubernetes/pull/75140))
- fluentd-gcp-scaler is unchanged at v0.5.0 since Kubernetes 1.13 ([#68837](https://github.com/kubernetes/kubernetes/pull/68837))
- Fluentd in fluentd-elasticsearch has been upgraded to v1.3.3 ([#71180](https://github.com/kubernetes/kubernetes/pull/71180))
- fluentd-elasticsearch has been updated to v2.4.0 ([#71180](https://github.com/kubernetes/kubernetes/pull/71180))
- The fluent-plugin-kubernetes_metadata_filter plugin in fluentd-elasticsearch has been updated to v2.1.6 ([#71180](https://github.com/kubernetes/kubernetes/pull/71180))
- fluentd-gcp is unchanged at v3.2.0 since Kubernetes 1.13 ([#70954](https://github.com/kubernetes/kubernetes/pull/70954))
- OIDC authentication is unchanged at coreos/go-oidc v2 since Kubernetes 1.10 ([#58544](https://github.com/kubernetes/kubernetes/pull/58544))
- Calico is unchanged at v3.3.1 since Kubernetes 1.13 ([#70932](https://github.com/kubernetes/kubernetes/pull/70932))
- crictl on GCE is unchanged at v1.12.0 since Kubernetes 1.13 ([#69033](https://github.com/kubernetes/kubernetes/pull/69033))
- CoreDNS has been updated to v1.3.1 ([#73610](https://github.com/kubernetes/kubernetes/pull/73610))
- event-exporter has been updated to v0.2.3 ([#67691](https://github.com/kubernetes/kubernetes/pull/67691))
- Es-image has been updated to Elasticsearch 6.6.1 ([#71252](https://github.com/kubernetes/kubernetes/pull/71252))
- metrics-server remains unchanged at v0.3.1 since Kubernetes 1.12 ([#68746](https://github.com/kubernetes/kubernetes/pull/68746))
- GLBC remains unchanged at v1.2.3 since Kubernetes 1.12 ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- Ingress-gce remains unchanged at v1.2.3 since Kubernetes 1.12 ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- ip-masq-agen remains unchanged at v2.1.1 since Kubernetes 1.12 ([#67916](https://github.com/kubernetes/kubernetes/pull/67916))
