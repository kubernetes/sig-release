## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- #### Additional documentation e.g., KEPs (Kubernetes Enhancement Proposals), usage docs, etc.:
  
  <!--
  This section can be blank if this pull request does not require a release note.
  
  When adding links which point to resources within git repositories, like
  KEPs or supporting documentation, please reference a specific commit and avoid
  linking directly to the master branch. This ensures that links reference a
  specific point in time, rather than a document that may change over time.
  
  See here for guidance on getting permanent links to files: https://help.github.com/en/articles/getting-permanent-links-to-files
  
  Please use the following format for linking documentation:
  - [KEP]: <link>
  - [Usage]: <link>
  - [Other doc]: <link>
  --> ([#104389](https://github.com/kubernetes/kubernetes/pull/104389), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
 - Kubeadm: remove the deprecated flag --experimental-patches for the init|join|upgrade commands. The flag --patches is no longer allowed in a mixture with the flag --config. Please use the kubeadm configuration for setting patches for a node using {Init|Join}Configuration.patches. ([#104065](https://github.com/kubernetes/kubernetes/pull/104065), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
 
## Changes by Kind

### Deprecation

- A deprecation notice has been added when using the kube-proxy Userspace proxier, which will be removed in v1.25. (#103860) ([#104631](https://github.com/kubernetes/kubernetes/pull/104631), [@perithompson](https://github.com/perithompson)) [SIG Network]
- Add apiserver_longrunning_requests metric to replace the soon to be deprecated apiserver_longrunning_gauge metric. ([#103799](https://github.com/kubernetes/kubernetes/pull/103799), [@jyz0309](https://github.com/jyz0309)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Controller-manager: the following flags have no effect and would be removed in v1.24:
  - `--port`
  - `--address`
  The insecure port flags `--port` may only be set to 0 now.
  Also `metricsBindAddress` and `healthzBindAddress` fields from `kubescheduler.config.k8s.io/v1beta1` are no-op and expected to be empty. Removed in `kubescheduler.config.k8s.io/v1beta2` completely.
  
  In addition, please be careful that:
  - kube-scheduler MUST start with `--authorization-kubeconfig` and `--authentication-kubeconfig` correctly set to get authentication/authorization working.
  - liveness/readiness probes to kube-scheduler MUST use HTTPS now, and the default port has been changed to 10259.
  - Applications that fetch metrics from kube-scheduler should use a dedicated service account which is allowed to access nonResourceURLs `/metrics`. ([#96345](https://github.com/kubernetes/kubernetes/pull/96345), [@ingvagabund](https://github.com/ingvagabund)) [SIG Cloud Provider, Scheduling and Testing]
- Feature-gate VolumeSubpath has been deprecated and cannot be disabled. It will be completely removed in 1.25 ([#105474](https://github.com/kubernetes/kubernetes/pull/105474), [@mauriciopoppe](https://github.com/mauriciopoppe)) [SIG Storage]
- Kubeadm: add a new output/v1alpha2 API that is identical to the output/v1alpha1, but attempts to resolve some internal dependencies with the kubeadm/v1beta2 API. The output/v1alpha1 API is now deprecated and will be removed in a future release. ([#105295](https://github.com/kubernetes/kubernetes/pull/105295), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated / NO-OP phase "update-cluster-status" in "kubeadm reset" ([#105888](https://github.com/kubernetes/kubernetes/pull/105888), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Remove 'master' as a valid EgressSelection type in the EgressSelectorConfiguration API. ([#102242](https://github.com/kubernetes/kubernetes/pull/102242), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery and Cloud Provider]
- Removed deprecated metric `scheduler_volume_scheduling_duration_seconds` ([#104518](https://github.com/kubernetes/kubernetes/pull/104518), [@dntosas](https://github.com/dntosas)) [SIG Instrumentation, Scheduling and Storage]
- Removed kubectl --dry-run empty default value and boolean values. kubectl --dry-run usage must be specified with --dry-run=(server|client|none). ([#105327](https://github.com/kubernetes/kubernetes/pull/105327), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- The deprecated --experimental-bootstrap-kubeconfig flag has been removed.
  This can be set via --bootstrap-kubeconfig. ([#103172](https://github.com/kubernetes/kubernetes/pull/103172), [@niulechuan](https://github.com/niulechuan)) [SIG Node]

### API Change

- A new field `omitManagedFields` has been added to both `audit.Policy` and `audit.PolicyRule` 
  so cluster operators can opt in to omit managed fields of the request and response bodies from 
  being written to the API audit log. ([#94986](https://github.com/kubernetes/kubernetes/pull/94986), [@tkashem](https://github.com/tkashem)) [SIG API Machinery, Auth, Cloud Provider and Testing]
- A small regression in Service updates was fixed.  The circumstances are so unlikely that probably nobody would ever hit it. ([#104601](https://github.com/kubernetes/kubernetes/pull/104601), [@thockin](https://github.com/thockin)) [SIG Network]
- CSIDriver.Spec.StorageCapacity can now be modified. ([#101789](https://github.com/kubernetes/kubernetes/pull/101789), [@pohly](https://github.com/pohly)) [SIG Storage]
- Client-go impersonation config can specify a UID to pass impersonated uid information through in requests. ([#104483](https://github.com/kubernetes/kubernetes/pull/104483), [@margocrawf](https://github.com/margocrawf)) [SIG API Machinery, Auth and Testing]
- Ephemeral containers have reached beta maturity and are now available by default. ([#105405](https://github.com/kubernetes/kubernetes/pull/105405), [@verb](https://github.com/verb)) [SIG API Machinery, Apps, Node and Testing]
- IPv6DualStack feature moved to stable.
  Controller Manager flags for the node IPAM controller have slightly changed:
  1. When configuring a dual-stack cluster, the user must specify both --node-cidr-mask-size-ipv4 and --node-cidr-mask-size-ipv6 to set the per-node IP mask sizes, instead of the previous --node-cidr-mask-size flag.
  2. The --node-cidr-mask-size flag is mutually exclusive with --node-cidr-mask-size-ipv4 and --node-cidr-mask-size-ipv6.
  3. Single-stack clusters do not need to change, but may choose to use the more specific flags.  Users can use either the older --node-cidr-mask-size flag or one of the newer --node-cidr-mask-size-ipv4 or --node-cidr-mask-size-ipv6 flags to configure the per-node IP mask size, provided that the flag's IP family matches the cluster's IP family (--cluster-cidr). ([#104691](https://github.com/kubernetes/kubernetes/pull/104691), [@khenidak](https://github.com/khenidak)) [SIG API Machinery, Apps, Auth, Cloud Provider, Cluster Lifecycle, Network, Node and Testing]
- Introduce OS field in the Pod Spec ([#104693](https://github.com/kubernetes/kubernetes/pull/104693), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG API Machinery and Apps]
- Introduce v1beta2 for Priority and Fairness with no changes in API spec ([#104399](https://github.com/kubernetes/kubernetes/pull/104399), [@tkashem](https://github.com/tkashem)) [SIG API Machinery and Testing]
- Introduce v1beta3 api for scheduler. This version 
  - increases the weight of user specifiable priorities.
  The weights of following priority plugins are increased
    - TaintTolerations to 3 - as leveraging node tainting to group nodes in the cluster is becoming a widely-adopted practice
    - NodeAffinity to 2
    - InterPodAffinity to 2
  
  - Won't have HealthzBindAddress, MetricsBindAddress fields ([#104251](https://github.com/kubernetes/kubernetes/pull/104251), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Scheduling and Testing]
- JSON log output is configurable and now supports writing info messages to stdout and error messages to stderr. Info messages can be buffered in memory. The default is to write both to stdout without buffering, as before. ([#104873](https://github.com/kubernetes/kubernetes/pull/104873), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, CLI, Cluster Lifecycle, Instrumentation, Node and Scheduling]
- JobTrackingWithFinalizers graduates to beta. Feature is enabled by default. ([#105687](https://github.com/kubernetes/kubernetes/pull/105687), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps and Testing]
- Kube-apiserver: Fixes handling of CRD schemas containing literal null values in enums. ([#104969](https://github.com/kubernetes/kubernetes/pull/104969), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Apps and Network]
- Kube-apiserver: The `rbac.authorization.k8s.io/v1alpha1` API version is removed; use the `rbac.authorization.k8s.io/v1` API, available since v1.8. The `scheduling.k8s.io/v1alpha1` API version is removed; use the `scheduling.k8s.io/v1` API, available since v1.14. ([#104248](https://github.com/kubernetes/kubernetes/pull/104248), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth, Network and Testing]
- Kube-controller-manager supports '--concurrent-ephemeralvolume-syncs' flag to set the number of ephemeral volume controller workers. ([#102981](https://github.com/kubernetes/kubernetes/pull/102981), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery and Apps]
- Kube-scheduler: support for configuration file version `v1beta1` is removed. Update configuration files to v1beta2(xref: https://github.com/kubernetes/enhancements/issues/2901) or v1beta3 before upgrading to 1.23. ([#104782](https://github.com/kubernetes/kubernetes/pull/104782), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling and Testing]
- Kubelet: turn the KubeletConfiguration v1beta1 `ResolverConfig` field from a `string` to `*string`. ([#104624](https://github.com/kubernetes/kubernetes/pull/104624), [@Haleygo](https://github.com/Haleygo)) [SIG Cluster Lifecycle and Node]
- Kubernetes is now built using go1.17 ([#103692](https://github.com/kubernetes/kubernetes/pull/103692), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Apps, Architecture, Auth, Autoscaling, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scheduling, Storage and Testing]
- Remove NodeLease feature gate that was graduated and locked to stable in 1.17 release. ([#105222](https://github.com/kubernetes/kubernetes/pull/105222), [@cyclinder](https://github.com/cyclinder)) [SIG Apps, Node and Testing]
- Removed deprecated `--seccomp-profile-root`/`seccompProfileRoot` config ([#103941](https://github.com/kubernetes/kubernetes/pull/103941), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- Since golang 1.17 both net.ParseIP and net.ParseCIDR rejects leading zeros in the dot-decimal notation of IPv4 addresses.
  Kubernetes will keep allowing leading zeros on IPv4 address to not break the compatibility.
  IMPORTANT: Kubernetes interprets leading zeros on IPv4 addresses as decimal, users must not rely on parser alignment to not being impacted by the associated security advisory:
  CVE-2021-29923 golang standard library "net" - Improper Input Validation of octal literals in golang 1.16.2 and below standard library "net" results in indeterminate SSRF & RFI vulnerabilities.
  Reference: https://nvd.nist.gov/vuln/detail/CVE-2021-29923 ([#104368](https://github.com/kubernetes/kubernetes/pull/104368), [@aojea](https://github.com/aojea)) [SIG API Machinery, Apps, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scalability, Scheduling, Storage and Testing]
- StatefulSet minReadySeconds is promoted to beta ([#104045](https://github.com/kubernetes/kubernetes/pull/104045), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps and Testing]
- TTLAfterFinished is now GA and enabled by default ([#105219](https://github.com/kubernetes/kubernetes/pull/105219), [@sahilvv](https://github.com/sahilvv)) [SIG API Machinery, Apps, Auth and Testing]
- The "Generic Ephemeral Volume" feature graduates to GA. It is now enabled unconditionally. ([#105609](https://github.com/kubernetes/kubernetes/pull/105609), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, Node, Scheduling, Storage and Testing]
- The CSIVolumeFSGroupPolicy feature has moved from beta to GA. ([#105940](https://github.com/kubernetes/kubernetes/pull/105940), [@dobsonj](https://github.com/dobsonj)) [SIG Storage]
- The `Service.spec.ipFamilyPolicy` field is now *required* in order to create or update a Service as dual-stack.  This is a breaking change from the beta behavior.  Previously the server would try to infer the value of that field from either `ipFamilies` or `clusterIPs`, but that caused ambiguity on updates.  Users who want a dual-stack Service MUST specify `ipFamilyPolicy` as either "PreferDualStack" or "RequireDualStack". ([#96684](https://github.com/kubernetes/kubernetes/pull/96684), [@thockin](https://github.com/thockin)) [SIG API Machinery, Apps, Network and Testing]
- The legacy scheduler policy config is removed in v1.23, the associated flags policy-config-file, policy-configmap, policy-configmap-namespace and use-legacy-policy-config are also removed. Migrate to Component Config instead, see https://kubernetes.io/docs/reference/scheduling/config/ for details. ([#105424](https://github.com/kubernetes/kubernetes/pull/105424), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling and Testing]
- Track the number of Pods with a Ready condition in Job status. The feature is alpha and needs the feature gate JobReadyPods to be enabled. ([#104915](https://github.com/kubernetes/kubernetes/pull/104915), [@alculquicondor](https://github.com/alculquicondor)) [SIG API Machinery, Apps, CLI and Testing]
- Users of LogFormatRegistry in component-base must update their code to use the logr v1.0.0 API. The JSON log output now uses the format from go-logr/zapr (no `v` field for error messages, additional information for invalid calls) and has some fixes (correct source code location for warnings about invalid log calls). ([#104103](https://github.com/kubernetes/kubernetes/pull/104103), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- When creating an object with generateName, if a conflict occurs the server now returns an AlreadyExists error with a retry option. ([#104699](https://github.com/kubernetes/kubernetes/pull/104699), [@vincepri](https://github.com/vincepri)) [SIG API Machinery]

### Feature

- Add a new `distribute-cpus-across-numa` option to the static `CPUManager` policy. When enabled, this will trigger the `CPUManager` to evenly distribute CPUs across NUMA nodes in cases where more than one NUMA node is required to satisfy the allocation. ([#105631](https://github.com/kubernetes/kubernetes/pull/105631), [@klueska](https://github.com/klueska)) [SIG Node]
- Add fish shell completion to kubectl ([#92989](https://github.com/kubernetes/kubernetes/pull/92989), [@WLun001](https://github.com/WLun001)) [SIG CLI]
- Add mechanism to load simple sniffer class into fluentd-elasticsearch image ([#92853](https://github.com/kubernetes/kubernetes/pull/92853), [@cosmo0920](https://github.com/cosmo0920)) [SIG Cloud Provider and Instrumentation]
- Add support for PodAndContainerStatsFromCRI featuregate, which allows a user to specify their pod stats must also come from the CRI, not cAdvisor. ([#103095](https://github.com/kubernetes/kubernetes/pull/103095), [@haircommander](https://github.com/haircommander)) [SIG Node]
- Add support to generate client-side binaries for windows/arm64 platform ([#104894](https://github.com/kubernetes/kubernetes/pull/104894), [@pacoxu](https://github.com/pacoxu)) [SIG CLI, Testing and Windows]
- Added PowerShell completion generation by running `kubectl completion powershell` ([#103758](https://github.com/kubernetes/kubernetes/pull/103758), [@zikhan](https://github.com/zikhan)) [SIG CLI]
- Added a `Processing` condition for the workqueue API
  Changed `Shutdown` for the workqueue API to wait until the work queue finishes processing all in-flight items. ([#101928](https://github.com/kubernetes/kubernetes/pull/101928), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu)) [SIG API Machinery and Apps]
- Added a new feature gate `CustomResourceValidationExpressions` to enable expression validation for Custom Resource. ([#105107](https://github.com/kubernetes/kubernetes/pull/105107), [@cici37](https://github.com/cici37)) [SIG API Machinery]
- Added a new flag `--append-server-path` to `kubectl proxy` that will automatically append the kube context server path to each request. ([#97350](https://github.com/kubernetes/kubernetes/pull/97350), [@FabianKramm](https://github.com/FabianKramm)) [SIG API Machinery, CLI and Testing]
- Added support for setting controller-manager log level online ([#104571](https://github.com/kubernetes/kubernetes/pull/104571), [@h4ghhh](https://github.com/h4ghhh)) [SIG API Machinery, Apps and Cloud Provider]
- Adding support for multiple --from-env-file flags ([#101646](https://github.com/kubernetes/kubernetes/pull/101646), [@lauchokyip](https://github.com/lauchokyip)) [SIG CLI]
- Adds new [alpha] command 'kubectl events' ([#99557](https://github.com/kubernetes/kubernetes/pull/99557), [@bboreham](https://github.com/bboreham)) [SIG CLI]
- All folks to build kubernetes with a custom kube-cross image ([#104185](https://github.com/kubernetes/kubernetes/pull/104185), [@dims](https://github.com/dims)) [SIG Release and Testing]
- Allow node expansion of local volumes ([#102886](https://github.com/kubernetes/kubernetes/pull/102886), [@gnufied](https://github.com/gnufied)) [SIG Storage and Testing]
- Client-go event library allows customizing spam filtering function. 
  It is now possible to override `SpamKeyFunc`, which is used by event filtering to detect spam in the events. ([#103918](https://github.com/kubernetes/kubernetes/pull/103918), [@olagacek](https://github.com/olagacek)) [SIG API Machinery and Instrumentation]
- Client-go, using log level 9, trace the following events of an http request:
      - dns lookup
      - tcp dialing
      - tls handshake
      - time to get a connection from the pool
      - time to process a request ([#105156](https://github.com/kubernetes/kubernetes/pull/105156), [@aojea](https://github.com/aojea)) [SIG API Machinery]
- Client-go: pass `DeleteOptions` down to the fake client `Reactor` ([#102945](https://github.com/kubernetes/kubernetes/pull/102945), [@chenchun](https://github.com/chenchun)) [SIG API Machinery, Apps and Auth]
- Cloud providers can set service account names for cloud controllers. ([#103178](https://github.com/kubernetes/kubernetes/pull/103178), [@nckturner](https://github.com/nckturner)) [SIG API Machinery and Cloud Provider]
- Constants/variables from k8s.io for STABLE metrics is now supported ([#103654](https://github.com/kubernetes/kubernetes/pull/103654), [@coffeepac](https://github.com/coffeepac)) [SIG Auth, Instrumentation, Node and Testing]
- Display Labels when kubectl describe ingress ([#103894](https://github.com/kubernetes/kubernetes/pull/103894), [@kabab](https://github.com/kabab)) [SIG CLI]
- Enhance scheduler volumebinding plugin to handle Lost PVC as UnschedulableAndUnresolvable during PreFilter stage ([#105245](https://github.com/kubernetes/kubernetes/pull/105245), [@yibozhuang](https://github.com/yibozhuang)) [SIG Scheduling and Storage]
- Expose a `NewUnstructuredExtractor` from apply configurations `meta/v1` package that enables extracting objects into unstructured apply configurations ([#103564](https://github.com/kubernetes/kubernetes/pull/103564), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, Cluster Lifecycle, Release and Testing]
- Feature-gate `StorageObjectInUseProtection` has been deprecated and cannot be disabled. It will be completely removed in 1.25 ([#105495](https://github.com/kubernetes/kubernetes/pull/105495), [@ikeeip](https://github.com/ikeeip)) [SIG Apps]
- Health check of kube-controller-manager now includes each controller. ([#104667](https://github.com/kubernetes/kubernetes/pull/104667), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery and Cloud Provider]
- Introduce a feature gate DisableKubeletCloudCredentialProviders which allows disabling the in-tree kubelet credential providers.
  
  The DisableKubeletCloudCredentialProviders FeatureGate is currently in Alpha, which means is currently disabled by default. Once the FeatureGate moves to beta, in-tree credential providers will be disabled by default, and users will need to migrate to using external credential providers. ([#102507](https://github.com/kubernetes/kubernetes/pull/102507), [@ostrain](https://github.com/ostrain)) [SIG Cloud Provider]
- Introduces a new metric: admission_webhook_request_total with the following labels: name (string) - the webhook name, type (string) - the admission type, operation (string) - the requested verb, code (int) - the HTTP status code, rejected (bool) - whether the request was rejected, namespace (string) - the namespace of the requested resource. ([#103162](https://github.com/kubernetes/kubernetes/pull/103162), [@rmoriar1](https://github.com/rmoriar1)) [SIG API Machinery and Instrumentation]
- Kube-apiserver: when merging lists, Server Side Apply now prefers the order of the submitted request instead of the existing persisted object ([#105983](https://github.com/kubernetes/kubernetes/pull/105983), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Storage and Testing]
- Kube-scheduler now logs node and plugin scoring  even though --v<10
  - socres of the top 3 plugins in the top 3 nodes are dumped if --v=4,5
  - socres of all plugins in the top 6 nodes are dumped if --v=6,7,8,9 ([#103515](https://github.com/kubernetes/kubernetes/pull/103515), [@muma378](https://github.com/muma378)) [SIG Scheduling]
- Kube-up.sh installs csi-proxy v1.0.1-gke.0 ([#104426](https://github.com/kubernetes/kubernetes/pull/104426), [@mauriciopoppe](https://github.com/mauriciopoppe)) [SIG Cloud Provider, Storage and Windows]
- Kubeadm: add support for dry running "kubeadm join". The new flag "kubeadm join --dry-run" is similar to the existing flag for "kubeadm init/upgrade" and allows you to see what changes would be applied. ([#103027](https://github.com/kubernetes/kubernetes/pull/103027), [@Haleygo](https://github.com/Haleygo)) [SIG Cluster Lifecycle]
- Kubeadm: do not check if the '/etc/kubernetes/manifests' folder is empty on joining worker nodes during preflight ([#104942](https://github.com/kubernetes/kubernetes/pull/104942), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubectl will now provide shell completion choices for the --output/-o flag ([#105851](https://github.com/kubernetes/kubernetes/pull/105851), [@marckhouzam](https://github.com/marckhouzam)) [SIG CLI]
- Kubernetes is now built with Golang 1.16.7 ([#104199](https://github.com/kubernetes/kubernetes/pull/104199), [@cpanato](https://github.com/cpanato)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.17.1 ([#104904](https://github.com/kubernetes/kubernetes/pull/104904), [@cpanato](https://github.com/cpanato)) [SIG API Machinery, Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.17.2 ([#105563](https://github.com/kubernetes/kubernetes/pull/105563), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery, Cloud Provider, Instrumentation, Release and Testing]
- Move ConfigurableFSGroupPolicy to GA
  Rename metric volume_fsgroup_recursive_apply to volume_apply_access_control ([#105885](https://github.com/kubernetes/kubernetes/pull/105885), [@gnufied](https://github.com/gnufied)) [SIG Instrumentation and Storage]
- Move the getAllocatableResources endpoint in podresource-api to the beta that will make it enabled by default. ([#105003](https://github.com/kubernetes/kubernetes/pull/105003), [@swatisehgal](https://github.com/swatisehgal)) [SIG Node and Testing]
- Moving WindowsHostProcessContainers feature to beta ([#106058](https://github.com/kubernetes/kubernetes/pull/106058), [@marosset](https://github.com/marosset)) [SIG Windows]
- Node affinity, node selector and tolerations are now mutable for jobs that are suspended and have never been started ([#105479](https://github.com/kubernetes/kubernetes/pull/105479), [@ahg-g](https://github.com/ahg-g)) [SIG Apps, Scheduling and Testing]
- Pod template annotations and labels are now mutable for jobs that are suspended and have never been started ([#105980](https://github.com/kubernetes/kubernetes/pull/105980), [@ahg-g](https://github.com/ahg-g)) [SIG Apps]
- PodSecurity: add a container image and manifests for the PodSecurity validating admission webhook ([#105923](https://github.com/kubernetes/kubernetes/pull/105923), [@liggitt](https://github.com/liggitt)) [SIG Auth]
- PodSecurity: in 1.23+ restricted policy levels, pods and containers which set runAsUser=0 are forbidden at admission-time; previously, they would be rejected at runtime ([#105857](https://github.com/kubernetes/kubernetes/pull/105857), [@liggitt](https://github.com/liggitt)) [SIG Auth]
- Shell completion now knows to continue suggesting resource names when the command supports it.  For example "kubectl get pod pod1 <TAB>" will suggest more pod names. ([#105711](https://github.com/kubernetes/kubernetes/pull/105711), [@marckhouzam](https://github.com/marckhouzam)) [SIG CLI]
- Support to enable Hyper-V in GCE Windows Nodes created with kube-up ([#105999](https://github.com/kubernetes/kubernetes/pull/105999), [@mauriciopoppe](https://github.com/mauriciopoppe)) [SIG Cloud Provider and Windows]
- The CPUManager policy options are now enabled, and we introduce a graduation path for the new CPU Manager policy options. ([#105012](https://github.com/kubernetes/kubernetes/pull/105012), [@fromanirh](https://github.com/fromanirh)) [SIG Node and Testing]
- The PodSecurity admission plugin has graduated to beta and is enabled by default. The admission configuration version has been promoted to pod-security.admission.config.k8s.io/v1beta1. See https://kubernetes.io/docs/concepts/security/pod-security-admission/ for usage guidelines. ([#106089](https://github.com/kubernetes/kubernetes/pull/106089), [@liggitt](https://github.com/liggitt)) [SIG Auth and Testing]
- The ServiceAccountIssuerDiscovery feature gate is removed. It reached GA in Kubernetes 1.21. ([#103685](https://github.com/kubernetes/kubernetes/pull/103685), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery and Auth]
- The etcd container image now supports Windows. ([#92433](https://github.com/kubernetes/kubernetes/pull/92433), [@claudiubelu](https://github.com/claudiubelu)) [SIG API Machinery and Windows]
- The kube-apiserver's Prometheus metrics have been extended with some that describe the costs of handling LIST requests.  They are as follows.
  - *apiserver_cache_list_total*: Counter of LIST requests served from watch cache, broken down by resource_prefix and index_name
  - *apiserver_cache_list_fetched_objects_total*: Counter of objects read from watch cache in the course of serving a LIST request, broken down by resource_prefix and index_name
  - *apiserver_cache_list_evaluated_objects_total*: Counter of objects tested in the course of serving a LIST request from watch cache, broken down by resource_prefix
  - *apiserver_cache_list_returned_objects_total*: Counter of objects returned for a LIST request from watch cache, broken down by resource_prefix
  - *apiserver_storage_list_total*: Counter of LIST requests served from etcd, broken down by resource
  - *apiserver_storage_list_fetched_objects_total*: Counter of objects read from etcd in the course of serving a LIST request, broken down by resource
  - *apiserver_storage_list_evaluated_objects_total*: Counter of objects tested in the course of serving a LIST request from etcd, broken down by resource
  - *apiserver_storage_list_returned_objects_total*: Counter of objects returned for a LIST request from etcd, broken down by resource ([#104983](https://github.com/kubernetes/kubernetes/pull/104983), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery and Instrumentation]
- The pause image list now contains Windows Server 2022 ([#104438](https://github.com/kubernetes/kubernetes/pull/104438), [@nick5616](https://github.com/nick5616)) [SIG Windows]
- The pods and pod controllers that are exempted from the PodSecurity admission process are now marked with the "pod-security.kubernetes.io/exempt: user/namespace/runtimeClass" annotation, based on what caused the exemption.
  
  The enforcement level that allowed or denied pod during PodSecurity admission is now marked by the "pod-security.kubernetes.io/enforce-policy" annotation.
  
  The annotation that informs about audit policy violations changed from ""pod-security.kubernetes.io/audit" to ""pod-security.kubernetes.io/audit-violation". ([#105908](https://github.com/kubernetes/kubernetes/pull/105908), [@stlaz](https://github.com/stlaz)) [SIG Auth]
- This PR adds the following metrics for API Priority and Fairness.
  - **apiserver_flowcontrol_priority_level_seat_count_samples**: histograms of seats occupied by executing requests (both regular and final-delay phases included), broken down by priority_level; the observations are taken once per millisecond.
  - **apiserver_flowcontrol_priority_level_seat_count_watermarks**: histograms of high and low watermarks of number of seats occupied by executing requests (both regular and final-delay phases included), broken down by priority_level.
  - **apiserver_flowcontrol_watch_count_samples**: histograms of number of watches relevant to a given mutating request, broken down by that request's priority_level and flow_schema. ([#105873](https://github.com/kubernetes/kubernetes/pull/105873), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery, Instrumentation and Testing]
- Turn on CSIMigrationAzureDisk by default on 1.23 ([#104670](https://github.com/kubernetes/kubernetes/pull/104670), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Updated Cluster Autosaler to version 1.22.0. Release notes: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.22.0 ([#104293](https://github.com/kubernetes/kubernetes/pull/104293), [@x13n](https://github.com/x13n)) [SIG Autoscaling and Cloud Provider]
- Updates  debian-iptables to v1.6.7 to pick up CVE fixes ([#104970](https://github.com/kubernetes/kubernetes/pull/104970), [@PushkarJ](https://github.com/PushkarJ)) [SIG API Machinery, Network, Release, Security and Testing]
- Updates the following images to pick up CVE fixes:
  - debian to v1.9.0
  - debian-iptables to v1.6.6
  - setcap to v2.0.4 ([#104142](https://github.com/kubernetes/kubernetes/pull/104142), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery, Release and Testing]
- When feature gate JobTrackingWithFinalizers is enabled:
  - Limit the number of pods tracked in a single job sync to avoid starvation of small jobs.
  - The metric job_pod_finished_total counts the number of finished pods tracked by the job controller ([#105197](https://github.com/kubernetes/kubernetes/pull/105197), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps, Instrumentation and Testing]

### Documentation

- Conformance: the test "[sig-network] EndpointSlice should have Endpoints and EndpointSlices pointing to API Server [Conformance]" only requires that there is an EndpointSlice that references the "kubernetes.default" service, it no longer requires that its named "kubernetes". ([#104664](https://github.com/kubernetes/kubernetes/pull/104664), [@aojea](https://github.com/aojea)) [SIG Architecture, Network and Testing]
- Update description of --audit-log-maxbackup to describe behavior when value = 0 ([#103843](https://github.com/kubernetes/kubernetes/pull/103843), [@Arkessler](https://github.com/Arkessler)) [SIG API Machinery]

### Failing Test

- Fixes hostpath storage e2e tests within SELinux enabled env ([#104551](https://github.com/kubernetes/kubernetes/pull/104551), [@Elbehery](https://github.com/Elbehery)) [SIG Testing]

### Bug or Regression

- (PodSecurity admission) errors validating workload resources (deployment, replicaset, etc.) no longer block admission. ([#106017](https://github.com/kubernetes/kubernetes/pull/106017), [@tallclair](https://github.com/tallclair)) [SIG Auth]
- 1. Changes json representation for a conflicted taint to Key=Effect when a conflicted taint occurs in kubectl taint. ([#104011](https://github.com/kubernetes/kubernetes/pull/104011), [@manugupt1](https://github.com/manugupt1)) [SIG CLI]
- A new server run option 'shutdown-send-retry-after'  has been introduced. If true the HTTP Server
  will continue listening until all non longrunning request(s) in flight have been drained, during this window all 
  incoming requests will be rejected with a status code 429 and a 'Retry-After' response header. ([#101257](https://github.com/kubernetes/kubernetes/pull/101257), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- A pod that the Kubelet rejects was still considered as being accepted for a brief period of time after rejection, which might cause some pods to be rejected briefly that could fit on the node.  A pod that is still terminating (but has status indicating it has failed) may also still be consuming resources and so should also be considered. ([#104817](https://github.com/kubernetes/kubernetes/pull/104817), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Add Pod Security admission metrics: pod_security_evaluations_total, pod_security_exemptions_total, pod_security_errors_total ([#105898](https://github.com/kubernetes/kubernetes/pull/105898), [@tallclair](https://github.com/tallclair)) [SIG Auth, Instrumentation and Testing]
- Adds Kubernetes Events to the Kubelet Graceful Shutdown feature ([#101081](https://github.com/kubernetes/kubernetes/pull/101081), [@rphillips](https://github.com/rphillips)) [SIG Node]
- Apimachinery: pretty-printed json and yaml output is now indented consistently ([#105466](https://github.com/kubernetes/kubernetes/pull/105466), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
- CA, certificate and key bundles for the generic-apiserver based servers will be reloaded immediately after the files are changed. ([#104102](https://github.com/kubernetes/kubernetes/pull/104102), [@tnqn](https://github.com/tnqn)) [SIG API Machinery and Testing]
- Change `kubectl diff --invalid-arg` status code from 1 to 2 to match docs ([#105445](https://github.com/kubernetes/kubernetes/pull/105445), [@ardaguclu](https://github.com/ardaguclu)) [SIG CLI]
- Changed kubectl describe to compute Age of an event using the count and lastObservedTime fields available in the event series ([#104482](https://github.com/kubernetes/kubernetes/pull/104482), [@harjas27](https://github.com/harjas27)) [SIG CLI]
- Changes behaviour of kube-proxy start; does not attempt to set specific sysctl values (which does not work in recent Kernel versions anymore in non-init namespaces), when the current sysctl values are already set higher. ([#103174](https://github.com/kubernetes/kubernetes/pull/103174), [@Napsty](https://github.com/Napsty)) [SIG Network]
- Client-go uses the same http client for all the generated groups and versions, allowing to share customized transports for multiple groups versions. ([#105490](https://github.com/kubernetes/kubernetes/pull/105490), [@aojea](https://github.com/aojea)) [SIG API Machinery, Auth, Instrumentation and Testing]
- Don't prematurely close reflectors in case of slow initialization in watch based manager to fix issues with inability to properly mount secrets/configmaps. ([#104604](https://github.com/kubernetes/kubernetes/pull/104604), [@wojtek-t](https://github.com/wojtek-t)) [SIG Node]
- EndpointSlice Mirroring controller now cleans up managed EndpointSlices when a Service selector is added ([#105997](https://github.com/kubernetes/kubernetes/pull/105997), [@robscott](https://github.com/robscott)) [SIG Apps, Network and Testing]
- Evicted and other terminated pods will no longer revert to Running phase ([#105462](https://github.com/kubernetes/kubernetes/pull/105462), [@ehashman](https://github.com/ehashman)) [SIG Node and Testing]
- Fix Job tracking with finalizers for more than 500 pods, ensuring all finalizers are removed before counting the Pod. ([#104666](https://github.com/kubernetes/kubernetes/pull/104666), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps and Instrumentation]
- Fix a regression where the Kubelet failed to exclude already completed pods from calculations about how many resources it was currently using when deciding whether to allow more pods. ([#104577](https://github.com/kubernetes/kubernetes/pull/104577), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Fix concurrent map access causing panics when logging timed-out API calls. ([#105734](https://github.com/kubernetes/kubernetes/pull/105734), [@marseel](https://github.com/marseel)) [SIG API Machinery]
- Fix detach disk issue on deleting vmss node ([#104572](https://github.com/kubernetes/kubernetes/pull/104572), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix job controller syncs: In case of conflicts, ensure that the sync happens with the most up to date information. Improves reliability of JobTrackingWithFinalizers. ([#105214](https://github.com/kubernetes/kubernetes/pull/105214), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- Fix kube-apiserver metric reporting for the deprecated watch path of /api/<version>/watch/... ([#104161](https://github.com/kubernetes/kubernetes/pull/104161), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Instrumentation]
- Fix pod name of NonIndexed jobs to not include rogue -1 substring ([#105676](https://github.com/kubernetes/kubernetes/pull/105676), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- Fix scoring for NodeResourcesBalancedAllocation plugins when nodes have containers with no requests. ([#105845](https://github.com/kubernetes/kubernetes/pull/105845), [@ahmad-diaa](https://github.com/ahmad-diaa)) [SIG Scheduling]
- Fix system default topology spreading when nodes don't have zone labels. Pods correctly spread by default now. ([#105046](https://github.com/kubernetes/kubernetes/pull/105046), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix: consolidate logs for instance not found error
  fix: skip not found nodes when reconciling LB backend address pools ([#105188](https://github.com/kubernetes/kubernetes/pull/105188), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: do not delete the lb that does not exist ([#105777](https://github.com/kubernetes/kubernetes/pull/105777), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: ensure InstanceShutdownByProviderID return false for creating Azure VMs ([#104382](https://github.com/kubernetes/kubernetes/pull/104382), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix: ignore not a VMSS error for VMAS nodes in EnsureBackendPoolDeleted. ([#105185](https://github.com/kubernetes/kubernetes/pull/105185), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Cloud Provider]
- Fix: ignore the case when comparing azure tags in service annotation ([#104705](https://github.com/kubernetes/kubernetes/pull/104705), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: ignore the case when updating Azure tags ([#104593](https://github.com/kubernetes/kubernetes/pull/104593), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: leave the probe path empty for TCP probes ([#105253](https://github.com/kubernetes/kubernetes/pull/105253), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: remove VMSS and VMSS instances from SLB backend pool only when necessary ([#105839](https://github.com/kubernetes/kubernetes/pull/105839), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: skip case sensitivity when checking Azure NSG rules ([#104384](https://github.com/kubernetes/kubernetes/pull/104384), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix: skip instance not found when decoupling vmss from lb ([#105666](https://github.com/kubernetes/kubernetes/pull/105666), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fixed a bug that prevents PersistentVolume that has a Claim UID which doesn't exist in local cache but exists in ETCD from being updated to Released phase. ([#105211](https://github.com/kubernetes/kubernetes/pull/105211), [@xiaopingrubyist](https://github.com/xiaopingrubyist)) [SIG Apps]
- Fixed an issue which didn't append OS's environment variables with the one provided in Credential Provider Config file, which may lead to failed execution of external credential provider binary. 
  See https://github.com/kubernetes/kubernetes/issues/102750 ([#103231](https://github.com/kubernetes/kubernetes/pull/103231), [@n4j](https://github.com/n4j)) [SIG Auth and Node]
- Fixed applying of SELinux labels to CSI volumes on very busy systems (with "error checking for SELinux support: could not get consistent content of /proc/self/mountinfo after 3 attempts") ([#105934](https://github.com/kubernetes/kubernetes/pull/105934), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed architecture within manifest for non `amd64` etcd images. ([#105484](https://github.com/kubernetes/kubernetes/pull/105484), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery]
- Fixed bug where kubectl would emit duplicate warning messages for flag names that contain an underscore and recommend using a nonexistent flag in some cases ([#103852](https://github.com/kubernetes/kubernetes/pull/103852), [@brianpursley](https://github.com/brianpursley)) [SIG CLI and Cluster Lifecycle]
- Fixed bug where using kubectl patch with $deleteFromPrimitiveList on a nonexistent or empty list would add the item to the list ([#105421](https://github.com/kubernetes/kubernetes/pull/105421), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery]
- Fixed client IP preservation for NodePort service with protocol SCTP in ipvs mode ([#104756](https://github.com/kubernetes/kubernetes/pull/104756), [@tnqn](https://github.com/tnqn)) [SIG Network]
- Fixed occasional pod cgroup freeze when using cgroup v1 and systemd driver. ([#104528](https://github.com/kubernetes/kubernetes/pull/104528), [@kolyshkin](https://github.com/kolyshkin)) [SIG Node]
- Fixes a bug that could result in the EndpointSlice controller unnecessarily updating EndpointSlices associated with a Service that had Topology Aware Hints enabled. ([#105267](https://github.com/kubernetes/kubernetes/pull/105267), [@llhuii](https://github.com/llhuii)) [SIG Apps and Network]
- Fixes a regression that could cause panics in LRU caches in controller-manager, kubelet, kube-apiserver, or client-go ([#104466](https://github.com/kubernetes/kubernetes/pull/104466), [@stbenjam](https://github.com/stbenjam)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Fixes the `should support building a client with a CSR` e2e test to work with clusters configured with short certificate lifetimes ([#105396](https://github.com/kubernetes/kubernetes/pull/105396), [@liggitt](https://github.com/liggitt)) [SIG Auth and Testing]
- Generic ephemeral volumes can be used also as raw block devices, but the Pod validation was refusing to create pods with that combination. ([#105682](https://github.com/kubernetes/kubernetes/pull/105682), [@pohly](https://github.com/pohly)) [SIG Apps, Storage and Testing]
- Generic ephemeral volumes were not considered properly by the the node limits scheduler filter and the kubelet hostpath check. ([#100482](https://github.com/kubernetes/kubernetes/pull/100482), [@pohly](https://github.com/pohly)) [SIG Node, Scheduling, Storage and Testing]
- Graceful node shutdown, allow the actual inhibit delay to be greater than the expected inhibit delay ([#103137](https://github.com/kubernetes/kubernetes/pull/103137), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Headless Services with no selector which were created without dual-stack enabled will be defaulted to RequireDualStack instead of PreferDualStack.  This is consistent with such Services which are created with dual-stack enabled. ([#104986](https://github.com/kubernetes/kubernetes/pull/104986), [@thockin](https://github.com/thockin)) [SIG Network]
- Kube-apiserver: Avoids unnecessary repeated calls to admission webhooks that reject an update or delete request. ([#104182](https://github.com/kubernetes/kubernetes/pull/104182), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
- Kube-apiserver: events created via the `events.k8s.io` API group for cluster-scoped objects are now permitted in the default namespace as well for compatibility with events clients and the `v1` API ([#100125](https://github.com/kubernetes/kubernetes/pull/100125), [@h4ghhh](https://github.com/h4ghhh)) [SIG API Machinery, Apps and Testing]
- Kube-apiserver: fix a memory leak when deleting multiple objects with a deletecollection. ([#105606](https://github.com/kubernetes/kubernetes/pull/105606), [@sxllwx](https://github.com/sxllwx)) [SIG API Machinery]
- Kube-apiserver: fixes an issue where an admission webhook can observe a v1 Pod object that does not have the `defaultMode` field set in the injected service account token volume ([#104523](https://github.com/kubernetes/kubernetes/pull/104523), [@liggitt](https://github.com/liggitt)) [SIG Auth]
- Kube-controller incorrectly enabled support for generic ephemeral inline volumes if the storage object in use protection feature was enabled. ([#104913](https://github.com/kubernetes/kubernetes/pull/104913), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Kube-proxy health check ports used to listen to :<port> for each of the services. This is not needed and opens ports in addresses the cluster user may not have intended. The PR limits listening to all node address which are controlled by `--nodeport-addresses` flag. if no addresses are provided then we default to existing behavior by listening to :<port> for each service ([#104742](https://github.com/kubernetes/kubernetes/pull/104742), [@khenidak](https://github.com/khenidak)) [SIG Network]
- Kube-proxy: delete stale conntrack UDP entries for loadbalancer ingress IP. ([#104009](https://github.com/kubernetes/kubernetes/pull/104009), [@aojea](https://github.com/aojea)) [SIG Network]
- Kube-scheduler now doesn't print any usage message when unknown flag is specified ([#104503](https://github.com/kubernetes/kubernetes/pull/104503), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Kube-up now includes CoreDNS version v1.8.6 ([#106091](https://github.com/kubernetes/kubernetes/pull/106091), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cloud Provider]
- Kubeadm: When adding an etcd peer to an existing cluster, if an error is returned indicating the peer has already been added, this is accepted and a ListMembers call is used instead to return the existing cluster. This helps diminish the exponential backoff when the first AddMember call times out, while still retaining a similar performance when the peer had already been added from a previous call. ([#104134](https://github.com/kubernetes/kubernetes/pull/104134), [@ihgann](https://github.com/ihgann)) [SIG Cluster Lifecycle]
- Kubeadm: do not allow empty "--config" paths to be passed to "kubeadm kubeconfig user" ([#105649](https://github.com/kubernetes/kubernetes/pull/105649), [@navist2020](https://github.com/navist2020)) [SIG Cluster Lifecycle]
- Kubeadm: switch the preflight check (called 'Swap') that verifies if swap is enabled on Linux hosts to report a warning instead of an error. This is related to the graduation of the NodeSwap feature gate in the kubelet to Beta and being enabled by default in 1.23 - allows swap support on Linux hosts. In the next release of kubeadm (1.24) the preflight check will be removed, thus we recommend that you stop using it - e.g. via --ignore-preflight-errors or the kubeadm config. ([#104854](https://github.com/kubernetes/kubernetes/pull/104854), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubelet did not report `kubelet_volume_stats_*` metrics for generic ephemeral voiumes. ([#105569](https://github.com/kubernetes/kubernetes/pull/105569), [@pohly](https://github.com/pohly)) [SIG Node]
- Kubelet's Node Grace Shutdown will terminate probes when shutting down. ([#105215](https://github.com/kubernetes/kubernetes/pull/105215), [@rphillips](https://github.com/rphillips)) [SIG Node]
- Kubernetes object references (= name + namespace) were not logged as struct when using JSON as log output format. ([#104877](https://github.com/kubernetes/kubernetes/pull/104877), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Makes the etcd client (used by the API server) retry certain types of errors. The full list of retriable (codes.Unavailable) errors can be found at https://github.com/etcd-io/etcd/blob/main/api/v3rpc/rpctypes/error.go#L72 ([#105069](https://github.com/kubernetes/kubernetes/pull/105069), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Metrics changes: Fix exposed buckets of `scheduler_volume_scheduling_duration_seconds_bucket` metric ([#100720](https://github.com/kubernetes/kubernetes/pull/100720), [@dntosas](https://github.com/dntosas)) [SIG Apps, Instrumentation, Scheduling and Storage]
- Pass additional flags to subpath mount to avoid flakes in certain conditions ([#104253](https://github.com/kubernetes/kubernetes/pull/104253), [@mauriciopoppe](https://github.com/mauriciopoppe)) [SIG Storage]
- Podresources interface was changed, now it returns only isolated cpus ([#97415](https://github.com/kubernetes/kubernetes/pull/97415), [@AlexeyPerevalov](https://github.com/AlexeyPerevalov)) [SIG Node and Testing]
- Release-note Removed error message label from kubelet_started_pods_errors_total metric ([#105213](https://github.com/kubernetes/kubernetes/pull/105213), [@yxxhero](https://github.com/yxxhero)) [SIG Instrumentation and Node]
- Resolves a potential issue with GC and NS controllers which may delete objects after getting a 404 response from the server during its startup. This PR ensures that requests to aggregated APIs will get 503, not 404 while the APIServiceRegistrationController hasn't finished its job. ([#104748](https://github.com/kubernetes/kubernetes/pull/104748), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Revert building binaries with PIE mode. ([#105352](https://github.com/kubernetes/kubernetes/pull/105352), [@ehashman](https://github.com/ehashman)) [SIG Node, Release and Security]
- Scheduler resource metrics over fractional binary quantities (2.5Gi, 1.1Ki) were incorrectly reported as very small values. ([#103751](https://github.com/kubernetes/kubernetes/pull/103751), [@y-tag](https://github.com/y-tag)) [SIG API Machinery and Scheduling]
- Support more than 100 disk mounts on Windows ([#105673](https://github.com/kubernetes/kubernetes/pull/105673), [@andyzhangx](https://github.com/andyzhangx)) [SIG Storage and Windows]
- Support using negative array index in json patch replace operations. ([#105896](https://github.com/kubernetes/kubernetes/pull/105896), [@zqzten](https://github.com/zqzten)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- The --leader-elect* CLI args are now honored in scheduler. ([#105915](https://github.com/kubernetes/kubernetes/pull/105915), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- The client-go dynamic client sets the header 'Content-Type: application/json' by default ([#104327](https://github.com/kubernetes/kubernetes/pull/104327), [@sxllwx](https://github.com/sxllwx)) [SIG API Machinery]
- The pods/binding subresource now honors `metadata.uid` and `metadata.resourceVersion` preconditions ([#105913](https://github.com/kubernetes/kubernetes/pull/105913), [@aholic](https://github.com/aholic)) [SIG Scheduling]
- Topology Hints now excludes control plane notes from capacity calculations. ([#104744](https://github.com/kubernetes/kubernetes/pull/104744), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Update Go used to build migrate script in etcd image to v1.16.7 ([#104301](https://github.com/kubernetes/kubernetes/pull/104301), [@serathius](https://github.com/serathius)) [SIG API Machinery and Release]
- Watch requests that are delegated to aggregated apiservers no longer reserve concurrency units (seats) in the API Priority and Fairness dispatcher for their entire duration. ([#105511](https://github.com/kubernetes/kubernetes/pull/105511), [@benluddy](https://github.com/benluddy)) [SIG API Machinery]
- When a static pod file is deleted and recreated while using a fixed UID, the pod was not properly restarted. ([#104847](https://github.com/kubernetes/kubernetes/pull/104847), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node and Testing]
- XFS-filesystems are now force-formatted (option `-f`) in order to avoid problems being formatted due to detection of magic super-blocks. This aligns with the behaviour of formatting of ext3/4 filesystems. ([#104923](https://github.com/kubernetes/kubernetes/pull/104923), [@davidkarlsen](https://github.com/davidkarlsen)) [SIG Storage]
- `--log-flush-frequency` had no effect in several commands or was missing. Help and warning texts were not always using the right format for a command (`add_dir_header` instead of `add-dir-header`). Fixing this included cleaning up flag handling in component-base/logs: that package no longer adds flags to the global flag sets. Commands which want the klog and --log-flush-frequency flags must explicitly call logs.AddFlags; the new cli.Run does that for commands. That helper function also covers flag normalization and printing of usage and errors in a consistent way (print usage text first if parsing failed, then the error). ([#105076](https://github.com/kubernetes/kubernetes/pull/105076), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scheduling and Testing]

### Other (Cleanup or Flake)

- All klog flags except for `-v` and `-vmodule` are deprecated. Support for `-vmodule` is only guaranteed for the text log format. ([#105042](https://github.com/kubernetes/kubernetes/pull/105042), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, CLI, Cluster Lifecycle and Instrumentation]
- Deprecate apiserver_longrunning_gauge and apiserver_register_watchers in 1.23.0 ([#103793](https://github.com/kubernetes/kubernetes/pull/103793), [@yan-lgtm](https://github.com/yan-lgtm)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Enhanced error message for nodes not selected by scheduler due to pod's PersistentVolumeClaim(s) bound to PersistentVolume(s) that do not exist. ([#105196](https://github.com/kubernetes/kubernetes/pull/105196), [@yibozhuang](https://github.com/yibozhuang)) [SIG Scheduling and Storage]
- Generic ephemeral volumes: better pod events ("waiting for ephemeral volume controller to create the persistentvolumeclaim"" instead of "persistentvolumeclaim not found") ([#104605](https://github.com/kubernetes/kubernetes/pull/104605), [@pohly](https://github.com/pohly)) [SIG Scheduling and Storage]
- Kube-apiserver: requests to node, service, and pod `/proxy` subresources with no additional URL path now only automatically redirect GET and HEAD requests. ([#95128](https://github.com/kubernetes/kubernetes/pull/95128), [@Riaankl](https://github.com/Riaankl)) [SIG API Machinery, Architecture and Testing]
- Kube-apiserver: sets an upper-bound on the lifetime of idle keep-alive connections and time to read the headers of incoming requests ([#103958](https://github.com/kubernetes/kubernetes/pull/103958), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Node]
- Kubeadm: external etcd endpoints passed in the ClusterConfiguration that have Unicode characters are no longer IDNA encoded (converted to Punycode). They are now just URL encoded as per Go's implementation of RFC-3986, have duplicate "/" removed from the URL paths, and passed like that directly to the kube-apiserver --etcd-servers flag. If you have etcd endpoints that have Unicode characters, it is advisable to encode them in advance with tooling that is fully IDNA compliant. If you don't do that, the Go standard library (used in k8s and etcd) would do it for you when making requests to the endpoints. ([#103801](https://github.com/kubernetes/kubernetes/pull/103801), [@gkarthiks](https://github.com/gkarthiks)) [SIG Cluster Lifecycle]
- Kubeadm: remove the --port flag from the manifest for the kube-controller-manager since the flag has been a NO-OP since 1.22 and insecure serving was removed for the component. ([#104157](https://github.com/kubernetes/kubernetes/pull/104157), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: remove the --port flag from the manifest for the kube-scheduler since the flag has been a NO-OP since 1.23 and insecure serving was removed for the component. ([#105034](https://github.com/kubernetes/kubernetes/pull/105034), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated flags "--csr-only" and "--csr-dir" from "kubeadm certs renew". Please use "kubeadm certs generate-csr" instead. ([#104796](https://github.com/kubernetes/kubernetes/pull/104796), [@RA489](https://github.com/RA489)) [SIG Cluster Lifecycle]
- Kubeadm: update references to legacy artifacts locations, the 'ci-cross' prefix has been removed from the version match as it does not exist in the new 'gs://k8s-release-dev' bucket ([#103813](https://github.com/kubernetes/kubernetes/pull/103813), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Migrate `cmd/proxy/{config, healthcheck, winkernel}` to structured logging ([#104944](https://github.com/kubernetes/kubernetes/pull/104944), [@jyz0309](https://github.com/jyz0309)) [SIG Network]
- Migrate `pkg/scheduler/framework/plugins/interpodaffinity/filtering.go`,`pkg/scheduler/framework/plugins/podtopologyspread/filtering.go`, `pkg/scheduler/framework/plugins/volumezone/volume_zone.go` to structured logging ([#105931](https://github.com/kubernetes/kubernetes/pull/105931), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation and Scheduling]
- Migrate `pkg/scheduler` to structured logging ([#99273](https://github.com/kubernetes/kubernetes/pull/99273), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Scheduling]
- Migrate cmd/proxy/app and pkg/proxy/meta_proxier to structured logging ([#104928](https://github.com/kubernetes/kubernetes/pull/104928), [@jyz0309](https://github.com/jyz0309)) [SIG Apps, Cluster Lifecycle, Network, Node and Testing]
- Migrate pkg/proxy to structured logs ([#104908](https://github.com/kubernetes/kubernetes/pull/104908), [@CIPHERTron](https://github.com/CIPHERTron)) [SIG Network]
- Migratecmd/kube-proxy/app logs to structured logging ([#98913](https://github.com/kubernetes/kubernetes/pull/98913), [@yxxhero](https://github.com/yxxhero)) [SIG Network]
- Migrated `cmd/kube-scheduler/app/server.go`, `pkg/scheduler/framework/plugins/nodelabel/node_label.go`, `pkg/scheduler/framework/plugins/nodevolumelimits/csi.go`, `pkg/scheduler/framework/plugins/nodevolumelimits/non_csi.go` to structured logging ([#105855](https://github.com/kubernetes/kubernetes/pull/105855), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Instrumentation and Scheduling]
- Migrated `pkg/scheduler/framework/plugins/volumebinding/assume_cache.go` to structured logging. ([#105904](https://github.com/kubernetes/kubernetes/pull/105904), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation, Scheduling and Storage]
- Migrated pkg/proxy to structured logging ([#104891](https://github.com/kubernetes/kubernetes/pull/104891), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Network]
- Migrated pkg/proxy/ipvs to structured logging ([#104932](https://github.com/kubernetes/kubernetes/pull/104932), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Network]
- Migrated pkg/proxy/userspace to structured logging ([#104931](https://github.com/kubernetes/kubernetes/pull/104931), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Network]
- Migrated pkg/proxy/winuserspace to structured logging ([#105035](https://github.com/kubernetes/kubernetes/pull/105035), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Network]
- More detailed logging has been added to the EndpointSlice controller for Topology Aware Hints. ([#104741](https://github.com/kubernetes/kubernetes/pull/104741), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Support allocating whole NUMA nodes in the CPUManager when there is not a 1:1 mapping between socket and NUMA node ([#102015](https://github.com/kubernetes/kubernetes/pull/102015), [@klueska](https://github.com/klueska)) [SIG Node]
- Support for Windows Server 2022 was added to the k8s.gcr.io/pause:3.6 image. ([#104711](https://github.com/kubernetes/kubernetes/pull/104711), [@claudiubelu](https://github.com/claudiubelu)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Node, Release and Testing]
- Surface warning when users don't set propagationPolicy for jobs while deleting ([#104080](https://github.com/kubernetes/kubernetes/pull/104080), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps]
- The AllowInsecureBackendProxy feature gate is removed. It reached GA in Kubernetes 1.21. ([#103796](https://github.com/kubernetes/kubernetes/pull/103796), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery]
- The `BoundServiceAccountTokenVolume` feature gate that is GA since v1.22 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104167](https://github.com/kubernetes/kubernetes/pull/104167), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Auth]
- The `StartupProbe` feature gate that is GA since v1.20 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104168](https://github.com/kubernetes/kubernetes/pull/104168), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Node]
- The `SupportPodPidsLimit` and  `SupportNodePidsLimit` feature gates that are GA since v1.20 are unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#104163](https://github.com/kubernetes/kubernetes/pull/104163), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Node]
- The apiserver exposes 4 new metrics that allow to track the status of the Service CIDRs allocations:
      - current number of available IPs per Service CIDR
      - current number of used IPs per Service CIDR
      - total number of allocation per Service CIDR
      - total number of allocation errors per ServiceCIDR ([#104119](https://github.com/kubernetes/kubernetes/pull/104119), [@aojea](https://github.com/aojea)) [SIG Apps, Instrumentation and Network]
- The flag `--deployment-controller-sync-period` has no effect now, deprecate it and will be removed in v1.24. ([#103538](https://github.com/kubernetes/kubernetes/pull/103538), [@Pingan2017](https://github.com/Pingan2017)) [SIG Apps]
- The maximum length of the CSINode id field has increased to 256 bytes to match the CSI spec ([#104160](https://github.com/kubernetes/kubernetes/pull/104160), [@pacoxu](https://github.com/pacoxu)) [SIG Storage]
- Troubleshooting: informers log handlers that take more than 100 milliseconds to process an object if the DeltaFIFO queue starts to grow beyond 10 elements. ([#103917](https://github.com/kubernetes/kubernetes/pull/103917), [@aojea](https://github.com/aojea)) [SIG API Machinery]
- Update build images to Debian 11 (Bullseye)
  - debian-base:bullseye-v1.0.0
  - debian-iptables:bullseye-v1.0.0
  - go-runner:v2.3.1-go1.17.1-bullseye.0
  - kube-cross:v1.23.0-go1.17.1-bullseye.1
  - setcap:bullseye-v1.0.0
  - cluster/images/etcd: Build 3.5.0-2 image
  - test/conformance/image: Update runner image to base-debian11 ([#105158](https://github.com/kubernetes/kubernetes/pull/105158), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Architecture, Release and Testing]
- Update conformance image to use debian-base:buster-v1.9.0 ([#104696](https://github.com/kubernetes/kubernetes/pull/104696), [@PushkarJ](https://github.com/PushkarJ)) [SIG Architecture, Release, Security and Testing]
- Update cri-tools dependency to v1.22.0 ([#104430](https://github.com/kubernetes/kubernetes/pull/104430), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider and Node]
- ``gcr.io/kubernetes-e2e-test-images`` will no longer be used in E2E / CI testing, ``k8s.gcr.io/e2e-test-images`` will be used instead. ([#103724](https://github.com/kubernetes/kubernetes/pull/103724), [@claudiubelu](https://github.com/claudiubelu)) [SIG API Machinery and Testing]
- `volume.kubernetes.io/storage-provisioner` annotation will be added to dynamic provisioning required PVC. `volume.beta.kubernetes.io/storage-provisioner` annotation is deprecated. ([#104590](https://github.com/kubernetes/kubernetes/pull/104590), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Apps and Storage]