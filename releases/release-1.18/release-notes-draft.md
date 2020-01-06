## Action Required

- action required
  1. Currently, if users were to explicitly specify CacheSize of 0 for KMS provider, they would end-up with a provider that caches up to 1000 keys. This PR changes this behavior.
  Post this PR, when users supply 0 for CacheSize this will result in a validation error.
  
  2. CacheSize type was changed from int32 to *int32. This allows defaulting logic to differentiate between cases where users explicitly supplied 0 vs. not supplied any value.
  3. KMS Provider's endpoint (path to Unix socket) is now validated when the EncryptionConfiguration files is loaded. This used to be handled by the GRPCService. ([#85363](https://github.com/kubernetes/kubernetes/pull/85363), [@immutableT](https://github.com/immutableT))

  Courtesy of SIG API Machinery, SIG Auth, and SIG Instrumentation


## New Features

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
- kubeadm: reset raises warnings if it cannot delete folders ([#85265](https://github.com/kubernetes/kubernetes/pull/85265), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- Windows nodes on GCE can use TPM-based authentication to the master. ([#85466](https://github.com/kubernetes/kubernetes/pull/85466), [@pjh](https://github.com/pjh))

  Courtesy of SIG Cluster Lifecycle
- kubectl/drain: add disable-eviction option.
  Force drain to use delete, even if eviction is supported. This will bypass checking PodDisruptionBudgets, and should be used with caution. ([#85571](https://github.com/kubernetes/kubernetes/pull/85571), [@michaelgugino](https://github.com/michaelgugino))

  Courtesy of SIG CLI
- kubelet now exports a "server_expiration_renew_failure" and "client_expiration_renew_failure" metric counter if the certificate rotations cannot be performed. ([#84614](https://github.com/kubernetes/kubernetes/pull/84614), [@rphillips](https://github.com/rphillips))

  Courtesy of SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Node, and SIG Release
- allow for configuration of CoreDNS replica count ([#85837](https://github.com/kubernetes/kubernetes/pull/85837), [@pickledrick](https://github.com/pickledrick))

  Courtesy of SIG Cluster Lifecycle
- kubeadm: add a upgrade health check that deploys a Job ([#81319](https://github.com/kubernetes/kubernetes/pull/81319), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- kubeadm now supports automatic calculations of dual-stack node cidr masks to kube-controller-manager. ([#85609](https://github.com/kubernetes/kubernetes/pull/85609), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- TBA ([#74525](https://github.com/kubernetes/kubernetes/pull/74525), [@gliush](https://github.com/gliush))

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


### Notes from Multiple SIGs

#### SIG Cluster Lifecycle, and SIG Node

- Changed core_pattern on COS nodes to be an absolute path. ([#86329](https://github.com/kubernetes/kubernetes/pull/86329), [@mml](https://github.com/mml))

#### SIG Auth, and SIG Network

- Fixes kube-proxy when EndpointSlice feature gate is enabled on Windows. ([#86016](https://github.com/kubernetes/kubernetes/pull/86016), [@robscott](https://github.com/robscott))

#### SIG Cloud Provider, and SIG Storage

- fix azure file AuthorizationFailure ([#85475](https://github.com/kubernetes/kubernetes/pull/85475), [@andyzhangx](https://github.com/andyzhangx))
- Fixed "requested device X but found Y" attach error on AWS. ([#85675](https://github.com/kubernetes/kubernetes/pull/85675), [@jsafrane](https://github.com/jsafrane))

#### SIG API Machinery, SIG Apps, and SIG Network

- Fix bug where EndpointSlice controller would attempt to modify shared objects. ([#85368](https://github.com/kubernetes/kubernetes/pull/85368), [@robscott](https://github.com/robscott))

#### SIG Cluster Lifecycle, SIG Instrumentation, and SIG Windows

- Bind metrics-server containers to linux nodes to avoid Windows scheduling on kubernetes cluster includes linux nodes and windows nodes ([#83362](https://github.com/kubernetes/kubernetes/pull/83362), [@wawa0210](https://github.com/wawa0210))
- Bind metadata-agent containers to linux nodes to avoid Windows scheduling on kubernetes cluster includes linux nodes and windows nodes ([#83363](https://github.com/kubernetes/kubernetes/pull/83363), [@wawa0210](https://github.com/wawa0210))

#### SIG API Machinery, and SIG Testing

- Resolved regression in admission, authentication, and authorization webhook performance in v1.17.0-rc.1 ([#85810](https://github.com/kubernetes/kubernetes/pull/85810), [@liggitt](https://github.com/liggitt))

#### SIG Storage, and SIG Testing

- None. ([#85621](https://github.com/kubernetes/kubernetes/pull/85621), [@chewong](https://github.com/chewong))

#### SIG Apps, SIG Testing, and SIG Windows

- Verify kubelet & kube-proxy can recover after being killed on Windows nodes ([#84886](https://github.com/kubernetes/kubernetes/pull/84886), [@YangLu1031](https://github.com/YangLu1031))

#### SIG API Machinery, SIG Auth, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node

- Renamed Kubelet metric certificate_manager_server_expiration_seconds to certificate_manager_server_ttl_seconds and changed to report the second until expiration at read time rather than absolute time of expiry.
  - Improved accuracy of Kubelet metric rest_client_exec_plugin_ttl_seconds. ([#85874](https://github.com/kubernetes/kubernetes/pull/85874), [@sambdavidson](https://github.com/sambdavidson))

#### SIG Autoscaling, and SIG Cluster Lifecycle

- Update Cluster Autoscaler to 1.17.0; changelog: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.17.0 ([#85610](https://github.com/kubernetes/kubernetes/pull/85610), [@losipiuk](https://github.com/losipiuk))

#### SIG CLI, and SIG Storage

- Includes FSType when describing CSI persistent volumes. ([#85293](https://github.com/kubernetes/kubernetes/pull/85293), [@huffmanca](https://github.com/huffmanca))

#### SIG Cluster Lifecycle, SIG Instrumentation, SIG Scalability, and SIG Testing

- Remove cluster-monitoring addon ([#85512](https://github.com/kubernetes/kubernetes/pull/85512), [@serathius](https://github.com/serathius))

#### SIG API Machinery, SIG Architecture, SIG CLI, and SIG Testing

- The sample-apiserver aggregated conformance test has updated to use the Kubernetes v1.17.0 sample apiserver ([#84735](https://github.com/kubernetes/kubernetes/pull/84735), [@liggitt](https://github.com/liggitt))

#### SIG Cluster Lifecycle, and SIG Instrumentation

- Fixed issue with addon-resizer using deprecated extensions APIs ([#85793](https://github.com/kubernetes/kubernetes/pull/85793), [@bskiba](https://github.com/bskiba))
- addons: elasticsearch discovery supports IPv6 ([#85543](https://github.com/kubernetes/kubernetes/pull/85543), [@SataQiu](https://github.com/SataQiu))

#### SIG API Machinery, SIG Apps, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Testing

- kube-apiserver no longer serves the following deprecated APIs:
  - All resources under `apps/v1beta1` and `apps/v1beta2` - use `apps/v1` instead
  - `daemonsets`, `deployments`, `replicasets` resources under `extensions/v1beta1` - use `apps/v1` instead
  - `networkpolicies` resources under `extensions/v1beta1` - use `networking.k8s.io/v1` instead
  - `podsecuritypolicies` resources under `extensions/v1beta1` - use `policy/v1beta1` instead ([#85903](https://github.com/kubernetes/kubernetes/pull/85903), [@liggitt](https://github.com/liggitt))

#### SIG API Machinery, SIG Cluster Lifecycle, and SIG Instrumentation

- kube-apiserver: Fixes a bug that hidden metrics can not be enabled by the command-line option `--show-hidden-metrics-for-version`. ([#85444](https://github.com/kubernetes/kubernetes/pull/85444), [@RainbowMango](https://github.com/RainbowMango))


### Notes from Individual SIGs

#### SIG API Machinery

- Use context to check client closed instead of http.CloseNotifier in processing watch request which will reduce 1 goroutine for each request if proto is HTTP/2.x . ([#85408](https://github.com/kubernetes/kubernetes/pull/85408), [@answer1991](https://github.com/answer1991))
- Resolves performance regression in `kubectl get all` and in client-go discovery clients constructed using `NewDiscoveryClientForConfig` or `NewDiscoveryClientForConfigOrDie`. ([#86168](https://github.com/kubernetes/kubernetes/pull/86168), [@liggitt](https://github.com/liggitt))
- kube-apiserver: fixed a conflict error encountered attempting to delete a pod with gracePeriodSeconds=0 and a resourceVersion precondition ([#85516](https://github.com/kubernetes/kubernetes/pull/85516), [@michaelgugino](https://github.com/michaelgugino))
- Fix API Server potential memory leak issue in processing watch request. ([#85410](https://github.com/kubernetes/kubernetes/pull/85410), [@answer1991](https://github.com/answer1991))
- Filter published OpenAPI schema by making nullable, required fields non-required in order to avoid kubectl to wrongly reject null values. ([#85722](https://github.com/kubernetes/kubernetes/pull/85722), [@sttts](https://github.com/sttts))

#### SIG CLI

- Fix a bug in port-forward: named port not working with service ([#85511](https://github.com/kubernetes/kubernetes/pull/85511), [@oke-py](https://github.com/oke-py))
- kubectl set resources will no longer return an error if passed an empty change for a resource. 
  kubectl set subject will no longer return an error if passed an empty change for a resource. ([#85490](https://github.com/kubernetes/kubernetes/pull/85490), [@sallyom](https://github.com/sallyom))
- kubectl drain node --dry-run will list pods that would be evicted or deleted ([#82660](https://github.com/kubernetes/kubernetes/pull/82660), [@sallyom](https://github.com/sallyom))

#### SIG Cloud Provider

- fix: azure data disk should use same key as os disk by default ([#86351](https://github.com/kubernetes/kubernetes/pull/86351), [@andyzhangx](https://github.com/andyzhangx))
- Make error message and service event message more clear ([#86078](https://github.com/kubernetes/kubernetes/pull/86078), [@feiskyer](https://github.com/feiskyer))
- VMSS cache is added so that less chances of VMSS GET throttling ([#85885](https://github.com/kubernetes/kubernetes/pull/85885), [@nilo19](https://github.com/nilo19))
- Fix LoadBalancer rule checking so that no unexpected LoadBalancer updates are made ([#85990](https://github.com/kubernetes/kubernetes/pull/85990), [@feiskyer](https://github.com/feiskyer))

#### SIG Cluster Lifecycle

- Wait for kubelet & kube-proxy to be ready on Windows node within 10s ([#85228](https://github.com/kubernetes/kubernetes/pull/85228), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm now errors out whenever a not supported component config version is supplied for the kubelet and kube-proxy ([#85639](https://github.com/kubernetes/kubernetes/pull/85639), [@rosti](https://github.com/rosti))
- kubeadm: don't write the kubelet environment file on "upgrade apply" ([#85412](https://github.com/kubernetes/kubernetes/pull/85412), [@boluisa](https://github.com/boluisa))
- kubeadm: fix potential panic when executing "kubeadm reset" with a corrupted kubelet.conf file ([#86216](https://github.com/kubernetes/kubernetes/pull/86216), [@neolit123](https://github.com/neolit123))
- kubeadm: make sure images are pre-pulled even if a tag did not change but their contents changed ([#85603](https://github.com/kubernetes/kubernetes/pull/85603), [@bart0sh](https://github.com/bart0sh))
- During initialization phase (preflight), kubeadm now verifies the presence of the conntrack executable ([#85857](https://github.com/kubernetes/kubernetes/pull/85857), [@hnanni](https://github.com/hnanni))
- kubeadm: uses the apiserver AdvertiseAddress IP family to choose the etcd endpoint IP family for non external etcd clusters ([#85745](https://github.com/kubernetes/kubernetes/pull/85745), [@aojea](https://github.com/aojea))
- kubeadm: Forward cluster name to the controller-manager arguments ([#85817](https://github.com/kubernetes/kubernetes/pull/85817), [@ereslibre](https://github.com/ereslibre))
- kubeadm: retry `kubeadm-config` ConfigMap creation or mutation if the apiserver is not responding. This will improve resiliency when joining new control plane nodes. ([#85763](https://github.com/kubernetes/kubernetes/pull/85763), [@ereslibre](https://github.com/ereslibre))

#### SIG Network

- kubernetes will try to acquire the iptables lock every 100 msec during 5 seconds instead of every second. This specially useful for environments using kube-proxy in iptables mode with a high churn rate of services. ([#85771](https://github.com/kubernetes/kubernetes/pull/85771), [@aojea](https://github.com/aojea))
- Fixes wrong validation result of NetworkPolicy PolicyTypes ([#85747](https://github.com/kubernetes/kubernetes/pull/85747), [@tnqn](https://github.com/tnqn))
- kube-proxy no longer modifies shared EndpointSlices. ([#86092](https://github.com/kubernetes/kubernetes/pull/86092), [@robscott](https://github.com/robscott))

#### SIG Node

- Fixes an issue with kubelet-reported pod status on deleted/recreated pods. ([#86320](https://github.com/kubernetes/kubernetes/pull/86320), [@liggitt](https://github.com/liggitt))
- OwnerReferences []OwnerReferencematches 
  so nil len(OwnerReferences) ==0 
  
  change:
   if lease.OwnerReferences == nil || len(lease.OwnerReferences) == 0 ==>if len(lease.OwnerReferences) == 0 ([#85789](https://github.com/kubernetes/kubernetes/pull/85789), [@ZP-AlwaysWin](https://github.com/ZP-AlwaysWin))
- Fixed a regression where the kubelet would fail to update the ready status of pods. ([#84951](https://github.com/kubernetes/kubernetes/pull/84951), [@tedyu](https://github.com/tedyu))

#### SIG Scheduling

- Fixed an issue that the scheduler only returns the first failure reason. ([#86022](https://github.com/kubernetes/kubernetes/pull/86022), [@Huang-Wei](https://github.com/Huang-Wei))

#### SIG Storage

- Fixed a panic in the kubelet cleaning up pod volumes ([#86277](https://github.com/kubernetes/kubernetes/pull/86277), [@tedyu](https://github.com/tedyu))

#### SIG Testing

- e2e-test-framework: add e2e test namespace dump if all tests succeed but the cleanup fails. ([#85542](https://github.com/kubernetes/kubernetes/pull/85542), [@schrodit](https://github.com/schrodit))

#### SIG Windows

- Update go-winio module version from 0.4.11 to 0.4.14 ([#85739](https://github.com/kubernetes/kubernetes/pull/85739), [@wawa0210](https://github.com/wawa0210))



