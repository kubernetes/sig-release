## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Kubelet flag `--keep-terminated-pod-volumes` was removed.  This flag was deprecated in 2017. ([#122082](https://github.com/kubernetes/kubernetes/pull/122082), [@carlory](https://github.com/carlory))
 - The scheduler starts to use QueueingHint registered for Pod/Updated event to determine whether unschedulable Pods update make them schedulable, when the feature gate `SchedulerQueueingHints` is enabled.
  Previously, when unschedulable Pods are updated, the scheduler always put Pods back to activeQ/backoffQ. But, actually not all updates to Pods make Pods schedulable, especially considering many scheduling constraints nowadays are immutable.
  Now, when unschedulable Pods are updated, the scheduling queue checks with QueueingHint(s) whether the update may make the pods schedulable, and requeues them to activeQ/backoffQ **only when** at least one QueueingHint(s) return Queue. 
  
  Action required for custom scheduler plugin developers:
  Plugins **have to** implement a QueueingHint for Pod/Update event if the rejection from them could be resolved by updating unscheduled Pods themselves.
  Example: suppose you develop a custom plugin that denies Pods that have a `schedulable=false` label. 
  Given Pods with a `schedulable=false` label will be schedulable if the `schedulable=false` label is removed, this plugin would implement QueueingHint for Pod/Update event that returns Queue when such label changes are made in unscheduled Pods. ([#122234](https://github.com/kubernetes/kubernetes/pull/122234), [@AxeZhan](https://github.com/AxeZhan))
 
## Changes by Kind

### Deprecation

- 'kubeadm: marked the sub-phase of ''init kubelet-finilize'' called ''experimental-cert-rotation''
  as deprecated and print a warning if it is used directly; it will be removed in
  a future release. Add a replacement sub-phase ''enable-client-cert-rotation''.' ([#124419](https://github.com/kubernetes/kubernetes/pull/124419), [@neolit123](https://github.com/neolit123))
- CephFS volume plugin ( `kubernetes.io/cephfs`) was removed in this release and the `cephfs` volume type became non-functional. Alternative is to use CephFS CSI driver (https://github.com/ceph/ceph-csi/) in your Kubernetes Cluster. A re-deployment of your application is required to use the new driver if you were using `kubernetes.io/cephfs` volume plugin before upgrading cluster version to 1.31+. ([#124544](https://github.com/kubernetes/kubernetes/pull/124544), [@carlory](https://github.com/carlory))
- CephRBD volume plugin ( `kubernetes.io/rbd`) was removed in this release. And its csi migration support was also removed, so the `rbd` volume type became non-functional. Alternative is to use RBD CSI driver (https://github.com/ceph/ceph-csi/) in your Kubernetes Cluster. A re-deployment of your application is required to use the new driver if you were using `kubernetes.io/rbd` volume plugin before upgrading cluster version to 1.31+. ([#124546](https://github.com/kubernetes/kubernetes/pull/124546), [@carlory](https://github.com/carlory))
- Kube-scheduler deprecated all non-csi volumelimit plugins and removed those from defaults plugins. 
  - AzureDiskLimits
  - CinderLimits
  - EBSLimits
  - GCEPDLimits
  
  The NodeVolumeLimits plugin can handle the same functionality as the above plugins since the above volume types are migrated to CSI.
  Please remove those plugins and replace them with the NodeVolumeLimits plugin if you explicitly use those plugins in the scheduler config.
  Those plugins will be removed in the release 1.32. ([#124500](https://github.com/kubernetes/kubernetes/pull/124500), [@carlory](https://github.com/carlory))
- Kubeadm: deprecated the kubeadm `RootlessControlPlane` feature gate (previously alpha), given that the core K8s `UserNamespacesSupport` feature gate graduated to Beta in 1.30. ([#124997](https://github.com/kubernetes/kubernetes/pull/124997), [@neolit123](https://github.com/neolit123))
- Removed k8s.io/legacy-cloud-providers from staging. ([#124767](https://github.com/kubernetes/kubernetes/pull/124767), [@carlory](https://github.com/carlory))
- Removed legacy cloud provider integration code (undoing a previous reverted commit) ([#124886](https://github.com/kubernetes/kubernetes/pull/124886), [@carlory](https://github.com/carlory))

### API Change

- Added the feature gates `StrictCostEnforcementForVAP` and `StrictCostEnforcementForWebhooks` to enforce the strct cost calculation for CEL extended libraries. It is strongly recommended to turn on the feature gates as early as possible. ([#124675](https://github.com/kubernetes/kubernetes/pull/124675), [@cici37](https://github.com/cici37))
- Component-base/logs: when compiled with Go >= 1.21, component-base will automatically configure the slog default logger together with initializing klog. ([#120696](https://github.com/kubernetes/kubernetes/pull/120696), [@pohly](https://github.com/pohly))
- DRA: client-side validation of a ResourceHandle would have accepted a missing DriverName, whereas server-side validation then would have raised an error. ([#124075](https://github.com/kubernetes/kubernetes/pull/124075), [@pohly](https://github.com/pohly))
- Fixed a 1.30.0 regression in OpenAPI descriptions of the `imagePullSecrets` and 
  `hostAliases` fields to mark the fields used as keys in those lists as either defaulted
  or required. ([#124553](https://github.com/kubernetes/kubernetes/pull/124553), [@pmalek](https://github.com/pmalek))
- Fixed a deep copy issue when retrieving the controller reference. ([#124116](https://github.com/kubernetes/kubernetes/pull/124116), [@HiranmoyChowdhury](https://github.com/HiranmoyChowdhury))
- Fixed incorrect "v1 Binding is deprecated in v1.6+" warning in kube-scheduler log. ([#125540](https://github.com/kubernetes/kubernetes/pull/125540), [@pohly](https://github.com/pohly))
- Fixed the comment for the Job's managedBy field. ([#124793](https://github.com/kubernetes/kubernetes/pull/124793), [@mimowo](https://github.com/mimowo))
- Graduated `MatchLabelKeys/MismatchLabelKeys` feature in `PodAffinity/PodAntiAffinity` to Beta. ([#123638](https://github.com/kubernetes/kubernetes/pull/123638), [@sanposhiho](https://github.com/sanposhiho))
- Graduated the `DisableNodeKubeProxyVersion` feature gate to beta. By default, the kubelet no longer attempts to set the `.status.kubeProxyVersion` field for its associated Node. ([#123845](https://github.com/kubernetes/kubernetes/pull/123845), [@HirazawaUi](https://github.com/HirazawaUi))
- Improved scheduling performance when many nodes, and prefilter returns 1-2 nodes (e.g. daemonset)
  
  For developers of out-of-tree PostFilter plugins, note that the semantics of NodeToStatusMap are changing: A node with an absent value in the NodeToStatusMap should be interpreted as having an UnschedulableAndUnresolvable status ([#125197](https://github.com/kubernetes/kubernetes/pull/125197), [@gabesaba](https://github.com/gabesaba))
- K8s.io/apimachinery/pkg/util/runtime: new calls support handling panics and errors in the context where they occur. `PanicHandlers` and `ErrorHandlers` now must accept a context parameter for that. Log output is structured instead of unstructured. ([#121970](https://github.com/kubernetes/kubernetes/pull/121970), [@pohly](https://github.com/pohly)) [SIG API Machinery and Instrumentation]
- Kube-apiserver: the `--encryption-provider-config` file is now loaded with strict deserialization, which fails if the config file contains duplicate or unknown fields. This protects against accidentally running with config files that are malformed, mis-indented, or have typos in field names, and getting unexpected behavior. When `--encryption-provider-config-automatic-reload` is used, new encryption config files that contain typos after the kube-apiserver is running are treated as invalid and the last valid config is used. ([#124912](https://github.com/kubernetes/kubernetes/pull/124912), [@enj](https://github.com/enj))
- Kube-controller-manager removes deprecated command flags: --volume-host-cidr-denylist and --volume-host-allow-local-loopback ([#124017](https://github.com/kubernetes/kubernetes/pull/124017), [@carlory](https://github.com/carlory))
- Kube-controller-manager: the `horizontal-pod-autoscaler-upscale-delay` and `horizontal-pod-autoscaler-downscale-delay` flags have been removed (deprecated and non-functional since v1.12) ([#124948](https://github.com/kubernetes/kubernetes/pull/124948), [@SataQiu](https://github.com/SataQiu))
- Supported fine-grained supplemental groups policy (KEP-3619), which enabled
  fine-grained control for supplementary groups in the first container processes.
  This allows you to choose whether to include groups defined in the container image (/etc/groups)
  for the container's primary UID or not. ([#117842](https://github.com/kubernetes/kubernetes/pull/117842), [@everpeace](https://github.com/everpeace))
- The kube-proxy nodeportAddresses / --nodeport-addresses option now
  accepts the value "primary", meaning to only listen for NodePort connections
  on the node's primary IPv4 and/or IPv6 address (according to the Node object).
  This is strongly recommended, if you were not previously using
  --nodeport-addresses, to avoid surprising behavior.
  
  (This behavior is enabled by default with the nftables backend; you would
  need to explicitly request `--nodeport-addresses 0.0.0.0/0,::/0` there to get
  the traditional "listen on all interfaces" behavior.) ([#123105](https://github.com/kubernetes/kubernetes/pull/123105), [@danwinship](https://github.com/danwinship))

### Feature

- "`pause`: Added a `-v` flag to the Windows variant of the pause binary, which
  prints the version of pause and exits. The Linux pause binary already has this flag." ([#125067](https://github.com/kubernetes/kubernetes/pull/125067), [@neolit123](https://github.com/neolit123))
- 'kubeadm: enhanced the "patches" functionality to be able to patch coredns
  deployment. The new patch target is called "corednsdeployment" (e.g. patch file
  "corednsdeployment+json.json"). This makes it possible to apply custom patches
  to coredns deployment during "init" and "upgrade".' ([#124820](https://github.com/kubernetes/kubernetes/pull/124820), [@SataQiu](https://github.com/SataQiu))
- 'kubeadm: marked the flag "--experimental-output'' as deprecated (it will
  be removed in a future release) and added a new flag ''--output" that serves the
  same purpose. Affected commands are - "kubeadm config images list", "kubeadm token
  list", "kubeadm upgrade plan", "kubeadm certs check-expiration".' ([#124393](https://github.com/kubernetes/kubernetes/pull/124393), [@carlory](https://github.com/carlory))
- Added `--keep-*` flags to `kubectl debug`, which enables to control the removal
  of probes, labels, annotations and initContainers from copy pod. ([#123149](https://github.com/kubernetes/kubernetes/pull/123149), [@mochizuki875](https://github.com/mochizuki875))
- Added `cri-client` staging repository. ([#123797](https://github.com/kubernetes/kubernetes/pull/123797), [@saschagrunert](https://github.com/saschagrunert))
- Added apiserver.latency.k8s.io/apf-queue-wait annotation to the audit log
  to record the time spent waiting in APF queue. ([#123919](https://github.com/kubernetes/kubernetes/pull/123919), [@hakuna-matatah](https://github.com/hakuna-matatah))
- Added completion for `kubectl set image`. ([#124592](https://github.com/kubernetes/kubernetes/pull/124592), [@ah8ad3](https://github.com/ah8ad3))
- Added flag to `kubectl logs` called `--all-pods` to get all pods from a object that uses a pod selector. ([#124732](https://github.com/kubernetes/kubernetes/pull/124732), [@cmwylie19](https://github.com/cmwylie19))
- Added ports autocompletion for kubectl port-foward command ([#124683](https://github.com/kubernetes/kubernetes/pull/124683), [@TessaIO](https://github.com/TessaIO))
- Added support for building Windows kube-proxy container image.
  A container image for kube-proxy on Windows can now be built with the command
  `make release-images KUBE_BUILD_WINDOWS=y`.
   The Windows kube-proxy image can be used with Windows Host Process Containers. ([#109939](https://github.com/kubernetes/kubernetes/pull/109939), [@claudiubelu](https://github.com/claudiubelu))
- Added the `WatchList` method to the `rest client` in `client-go`. When used,
  it establishes a stream to obtain a consistent snapshot of data from the server.
  This method is meant to be used by the generated client. ([#122657](https://github.com/kubernetes/kubernetes/pull/122657), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Allow creating ServiceAccount tokens bound to Node objects.
  This allows users to bind a service account token's validity to a named Node object, similar to Pod bound tokens.
  Use with `kubectl create token <serviceaccount-name> --bound-object-kind=Node --bound-object-node=<node-name>`. ([#125238](https://github.com/kubernetes/kubernetes/pull/125238), [@munnerz](https://github.com/munnerz))
- CEL expressions and `additionalProperties` are now allowed to be used under nested quantifiers in CRD schemas ([#124381](https://github.com/kubernetes/kubernetes/pull/124381), [@alexzielenski](https://github.com/alexzielenski))
- CEL: added name formats library. ([#123572](https://github.com/kubernetes/kubernetes/pull/123572), [@alexzielenski](https://github.com/alexzielenski))
- Checking etcd version to warn about deprecated etcd versions if `ConsistentListFromCache` is enabled. ([#124612](https://github.com/kubernetes/kubernetes/pull/124612), [@ah8ad3](https://github.com/ah8ad3))
- Client-go/reflector:Now warns when the bookmark event for initial events have not been received ([#124614](https://github.com/kubernetes/kubernetes/pull/124614), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Custom resource field selectors are now in beta and enabled by default. Check out https://github.com/kubernetes/enhancements/issues/4358 for more details. ([#124681](https://github.com/kubernetes/kubernetes/pull/124681), [@jpbetz](https://github.com/jpbetz))
- Dependencies: started using registry.k8s.io/pause:3.10. ([#125112](https://github.com/kubernetes/kubernetes/pull/125112), [@neolit123](https://github.com/neolit123))
- Feature gates for PortForward (kubectl port-forward) over WebSockets are now enabled by default (Beta).
  - "Server-side feature gate: PortForwardWebsocket"
  - "Client-side (kubectl) feature gate: PORT_FORWARD_WEBSOCKETS environment variable"
  - "To turn off PortForward over WebSockets for kubectl, the environment variable feature gate must be explicitly set - PORT_FORWARD_WEBSOCKETS=false" ([#125528](https://github.com/kubernetes/kubernetes/pull/125528), [@seans3](https://github.com/seans3))
- Graduated support for CDI device IDs to general availability. The `DevicePluginCDIDevices` feature gate is now enabled unconditionally. ([#123315](https://github.com/kubernetes/kubernetes/pull/123315), [@bart0sh](https://github.com/bart0sh))
- Introduced a new functionality to the client-go's `List` method, allowing users to enable API streaming. To activate this feature, users can set the `client-go.WatchListClient` feature gate. ([#124509](https://github.com/kubernetes/kubernetes/pull/124509), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Kube-apiserver: http/2 serving can be disabled with a `--disable-http2-serving` flag ([#122176](https://github.com/kubernetes/kubernetes/pull/122176), [@slashpai](https://github.com/slashpai))
- Kube-proxy's nftables mode (--proxy-mode=nftables) is now beta and available by default.
  
  FIXME ADD MORE HERE BEFORE THE RELEASE, DOCS LINKS AND STUFF ([#124383](https://github.com/kubernetes/kubernetes/pull/124383), [@danwinship](https://github.com/danwinship))
- Kube-scheduler implemented scheduling hints for the CSILimit plugin.
  The scheduling hints allow the scheduler to retry scheduling a Pod that was previously rejected by the CSILimit plugin if a deleted pod has a PersistantVolumeClaim (PVC) from the same driver. ([#121508](https://github.com/kubernetes/kubernetes/pull/121508), [@utam0k](https://github.com/utam0k))
- Kubeadm: during "upgrade" , if the "etcd.yaml" static pod does not need upgrade, still consider rotating the etcd certificates and restarting the etcd static pod if the "kube-apiserver.yaml" manifest is to be upgraded and if certificate renewal is not disabled. ([#124688](https://github.com/kubernetes/kubernetes/pull/124688), [@neolit123](https://github.com/neolit123))
- Kubeadm: enabled the v1beta4 API. For a complete changelog since v1beta3 please see https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/. 
  
  The API does include a few breaking changes:
  - The "extraArgs" component construct is now a list of "name"/"value" pairs instead of a string/string map. This has been done to support duplicate args where needed.
  - The "JoinConfiguration.discovery.timeout" field has been replaced by "JoinConfiguration.timeouts.discovery".
  - The "ClusterConfiguration.timeoutForControlPlane" field has been replaced by "{Init|Join}Configuration.timeouts.controlPlaneComponentHealthCheck".
  Please use the command "kubeadm config migrate" to migrate your existing v1beta3 configuration to v1beta4.
  
  v1beta3 is now marked as deprecated but will continue to be supported until version 1.34 or later.
  The storage configuration in the kube-system/kubeadm-config ConfigMap is now a v1beta4 ClusterConfiguration. ([#125029](https://github.com/kubernetes/kubernetes/pull/125029), [@neolit123](https://github.com/neolit123))
- Kubeadm: switch to using the new etcd endpoints introduced in 3.5.11 - /livez (for liveness probe) and /readyz (for readyness and startup probe). With this change it is no longer possible to deploy a custom etcd version older than 3.5.11 with kubeadm 1.31. If so, please upgrade. ([#124465](https://github.com/kubernetes/kubernetes/pull/124465), [@neolit123](https://github.com/neolit123))
- Kubeadm: switched kubeadm to start using the CRI client library instead of shelling out of the `crictl` binary
  for actions against a CRI endpoint. The kubeadm deb/rpm packages will continue to install the `cri-tools`
  package for one more release, but in you must adapt your scripts to install `crictl` manually from
  https://github.com/kubernetes-sigs/cri-tools/releases or a different location. ([#124685](https://github.com/kubernetes/kubernetes/pull/124685), [@saschagrunert](https://github.com/saschagrunert))
- Kubeadm: use output/v1alpha3 to print structural output for the commands "kubeadm config images list" and "kubeadm token list". ([#124464](https://github.com/kubernetes/kubernetes/pull/124464), [@carlory](https://github.com/carlory))
- Kubelet server can now dynamically load certificate files ([#124574](https://github.com/kubernetes/kubernetes/pull/124574), [@zhangweikop](https://github.com/zhangweikop))
- Kubelet will not restart the container when fields other than image in the pod spec change. ([#124220](https://github.com/kubernetes/kubernetes/pull/124220), [@HirazawaUi](https://github.com/HirazawaUi))
- Kubemark: added two flags, `--kube-api-qps` which indicates the maximum QPS to the apiserver, and `--kube-api-burst` which indicates maximum burst for throttle to the apiserver. ([#124147](https://github.com/kubernetes/kubernetes/pull/124147), [@devincd](https://github.com/devincd))
- Kubernetes is now built with go 1.22.3 ([#124828](https://github.com/kubernetes/kubernetes/pull/124828), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with go 1.22.4 ([#125363](https://github.com/kubernetes/kubernetes/pull/125363), [@cpanato](https://github.com/cpanato))
- LogarithmicScaleDown is now GA ([#125459](https://github.com/kubernetes/kubernetes/pull/125459), [@MinpengJin](https://github.com/MinpengJin))
- Promoted `generateName` retries to beta, and made the `NameGenerationRetries` feature gate
  enabled by default.
  You can read https://kep.k8s.io/4420 for more details. ([#124673](https://github.com/kubernetes/kubernetes/pull/124673), [@jpbetz](https://github.com/jpbetz))
- Scheduler changed its logic of calculating `evaluatedNodes` from "contains the number of nodes that filtered out by PreFilterResult and Filter plugins" to "the number of nodes filtered out by Filter plugins only". ([#124735](https://github.com/kubernetes/kubernetes/pull/124735), [@AxeZhan](https://github.com/AxeZhan))
- Services implemented a field selector for the ClusterIP and Type fields.
  The Kubelet uses this field selector to avoid monitoring Headless Services, which helps reduce memory consumption. ([#123905](https://github.com/kubernetes/kubernetes/pull/123905), [@aojea](https://github.com/aojea))
- The iptables mode of kube-proxy now tracks accepted packets that are destined for node-ports on localhost by introducing `kubeproxy_iptables_localhost_nodeports_accepted_packets_total` metric.
  This will help users to identify if they rely on iptables.localhostNodePorts feature and ulitmately help them to migrate from iptables to nftables. ([#125015](https://github.com/kubernetes/kubernetes/pull/125015), [@aroradaman](https://github.com/aroradaman))
- The iptables mode of kube-proxy now tracks packets that are wrongfully marked invalid by conntrack and subsequently dropped by introducing `kubeproxy_iptables_ct_state_invalid_dropped_packets_total` metric ([#122812](https://github.com/kubernetes/kubernetes/pull/122812), [@aroradaman](https://github.com/aroradaman))
- The kube-scheduler added scheduling hints for the InterPodAffinity plugin.
  These hints allow the scheduler to retry scheduling a Pod
  that was previously rejected by the InterPodAffinity plugin if there are changes (create, delete, or update) to a related Pod or a node that matches the pod affinity criteria. ([#122471](https://github.com/kubernetes/kubernetes/pull/122471), [@nayihz](https://github.com/nayihz))
- The name of CEL optional type has been changed from `optional` to `optional_type`. ([#124328](https://github.com/kubernetes/kubernetes/pull/124328), [@jiahuif](https://github.com/jiahuif))
- The scheduler implemented QueueingHint in the TaintToleration plugin, enhancing the throughput of scheduling. ([#124287](https://github.com/kubernetes/kubernetes/pull/124287), [@sanposhiho](https://github.com/sanposhiho))
- The sidecars' finish time will now be accounted for when calculating the job's finish time. ([#124942](https://github.com/kubernetes/kubernetes/pull/124942), [@AxeZhan](https://github.com/AxeZhan))
- This PR added tracing support to the kubelet's read-only endpoint, which currently
  does not have tracing. It makes use of the `WithPublicEndpoint` option to prevent callers
  from influencing sampling decisions. ([#121770](https://github.com/kubernetes/kubernetes/pull/121770), [@frzifus](https://github.com/frzifus))
- Updated the CEL default compatibility environment version to "1.30", ensuring that extended libraries added before version "1.30" are available for use. ([#124779](https://github.com/kubernetes/kubernetes/pull/124779), [@cici37](https://github.com/cici37))
- Users can traverse all the pods that are in the scheduler and waiting in the permit stage through method `IterateOverWaitingPods`. In other words,  all waitingPods in scheduler can be obtained from any profiles. Before this commit, each profile could only obtain waitingPods within that profile. ([#124926](https://github.com/kubernetes/kubernetes/pull/124926), [@kerthcet](https://github.com/kerthcet))

### Failing Test

- Fixed issue where following Windows container logs would prevent container log rotation. ([#124444](https://github.com/kubernetes/kubernetes/pull/124444), [@claudiubelu](https://github.com/claudiubelu))
- Pkg k8s.io/apiserver/pkg/storage/cacher, method (*Cacher) Wait(context.Context) error ([#125450](https://github.com/kubernetes/kubernetes/pull/125450), [@mauri870](https://github.com/mauri870))
- Reverted remove legacycloudproviders from staging. ([#124864](https://github.com/kubernetes/kubernetes/pull/124864), [@carlory](https://github.com/carlory))

### Bug or Regression

- 'kubeadm: Stopped storing the ResolverConfig in the global KubeletConfiguration
  and sets it dynamically for each node instead.' ([#124038](https://github.com/kubernetes/kubernetes/pull/124038), [@SataQiu](https://github.com/SataQiu))
- 'kubeadm: fixed a regression where the KubeletConfiguration is not properly
  downloaded during "kubeadm upgrade" command from the kube-system/kubelet-config
  ConfigMap, resulting in the local ''/var/lib/kubelet/config.yaml'' file being
  written as a defaulted config.' ([#124480](https://github.com/kubernetes/kubernetes/pull/124480), [@neolit123](https://github.com/neolit123))
- Added an extra line between two different key value pairs under data when running kubectl describe configmap ([#123597](https://github.com/kubernetes/kubernetes/pull/123597), [@siddhantvirus](https://github.com/siddhantvirus))
- Allow parameter to be set along with proto file path ([#124281](https://github.com/kubernetes/kubernetes/pull/124281), [@fulviodenza](https://github.com/fulviodenza))
- Cel: converting a quantity value into a quantity value failed. ([#123669](https://github.com/kubernetes/kubernetes/pull/123669), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Client-go/tools/record.Broadcaster: fixed automatic shutdown on WithContext cancellation ([#124635](https://github.com/kubernetes/kubernetes/pull/124635), [@pohly](https://github.com/pohly))
- DRA: enhance validation for the ResourceClaimParametersReference and ResourceClassParametersReference with the following rules:
  
  " 1. `apiGroup`: If set, it must be a valid DNS subdomain (e.g. 'example.com')."
  " 2. `kind` and `name`: It must be valid path segment name. It may not be '.' or '..' and it may not contain '/' and '%' characters." ([#125218](https://github.com/kubernetes/kubernetes/pull/125218), [@carlory](https://github.com/carlory))
- Do not remove the "batch.kubernetes.io/job-tracking" finalizer from a Pod, in a corner
  case scenario, when the Pod is controlled by an API object which is not a batch Job
  (e.g. when the Pod is controlled by a custom CRD). ([#124798](https://github.com/kubernetes/kubernetes/pull/124798), [@mimowo](https://github.com/mimowo))
- Dropped the additional rule requirement (cronjobs/finalizers) for roles
  using kubectl create cronjobs to ensure backward compatibility. ([#124883](https://github.com/kubernetes/kubernetes/pull/124883), [@ardaguclu](https://github.com/ardaguclu))
- Enabled kubectl to find `kubectl-create-subcommand` plugins when positional
  arguments exists, e.g. `kubectl create subcommand arg`. ([#124123](https://github.com/kubernetes/kubernetes/pull/124123), [@sttts](https://github.com/sttts))
- Endpointslices mirrored from Endpoints by the EndpointSliceMirroring controller were not reconciled if modified. ([#124131](https://github.com/kubernetes/kubernetes/pull/124131), [@zyjhtangtang](https://github.com/zyjhtangtang))
- Ensured daemonset controller counts old unhealthy pods towards max unavailable budget. ([#123233](https://github.com/kubernetes/kubernetes/pull/123233), [@marshallbrekka](https://github.com/marshallbrekka))
- Fix "-kube-test-repo-list" e2e flag may not take effect ([#123587](https://github.com/kubernetes/kubernetes/pull/123587), [@huww98](https://github.com/huww98))
- Fix: the resourceclaim controller forgot to wait for `podSchedulingSynced` and templatesSynced ([#124589](https://github.com/kubernetes/kubernetes/pull/124589), [@carlory](https://github.com/carlory))
- Fixed EDITOR/KUBE_EDITOR with double-quoted paths with spaces when on Windows cmd.exe. ([#112104](https://github.com/kubernetes/kubernetes/pull/112104), [@oldium](https://github.com/oldium))
- Fixed a bug in the JSON frame reader that could cause it to retain a reference to the underlying array of the byte slice passed to Read. ([#123620](https://github.com/kubernetes/kubernetes/pull/123620), [@benluddy](https://github.com/benluddy))
- Fixed a bug in the scheduler where it would crash when prefilter returns a non-existent node. ([#124933](https://github.com/kubernetes/kubernetes/pull/124933), [@AxeZhan](https://github.com/AxeZhan))
- Fixed a bug where `kubectl describe` incorrectly displayed NetworkPolicy port ranges
  (showing only the starting port). ([#123316](https://github.com/kubernetes/kubernetes/pull/123316), [@jcaamano](https://github.com/jcaamano))
- Fixed a bug where hard evictions due to resource pressure allowed pods
  to use the full termination grace period instead of shutting down instantly. 
  This bug also affected force deleted pods. Both cases now receive a termination grace period of 1 second. ([#124063](https://github.com/kubernetes/kubernetes/pull/124063), [@olyazavr](https://github.com/olyazavr))
- Fixed a missing status prefix in custom resource validation error messages. ([#123822](https://github.com/kubernetes/kubernetes/pull/123822), [@JoelSpeed](https://github.com/JoelSpeed))
- Fixed a race condition in kube-controller-manager and the scheduler, caused by
  a bug in the transforming informer during the Resync operation, 
  by making the transforming function idempotent. ([#124352](https://github.com/kubernetes/kubernetes/pull/124352), [@wojtek-t](https://github.com/wojtek-t))
- Fixed a race condition in the transforming informer that occurred when objects were accessed during the Resync operation. ([#124344](https://github.com/kubernetes/kubernetes/pull/124344), [@wojtek-t](https://github.com/wojtek-t))
- Fixed a regression where `kubelet --hostname-override` no longer worked
  correctly with an external cloud provider. ([#124516](https://github.com/kubernetes/kubernetes/pull/124516), [@danwinship](https://github.com/danwinship))
- Fixed an issue that prevents the linking of trace spans for requests that are proxied through kube-aggregator. ([#124189](https://github.com/kubernetes/kubernetes/pull/124189), [@toddtreece](https://github.com/toddtreece))
- Fixed an issue where kubelet on Windows would fail if a pod had a SecurityContext with `RunAsUser`. ([#125040](https://github.com/kubernetes/kubernetes/pull/125040), [@carlory](https://github.com/carlory))
- Fixed bug where kubectl get with --sort-by flag does not sort strings alphanumerically. ([#124514](https://github.com/kubernetes/kubernetes/pull/124514), [@brianpursley](https://github.com/brianpursley))
- Fixed the format of the error indicating that a user does not have permission on the object referenced by paramRef in ValidatingAdmissionPolicyBinding. ([#124653](https://github.com/kubernetes/kubernetes/pull/124653), [@m1kola](https://github.com/m1kola))
- Fixed throughput when scheduling DaemonSet pods to reach 300 pods/s, if the configured QPS allows it. ([#124714](https://github.com/kubernetes/kubernetes/pull/124714), [@sanposhiho](https://github.com/sanposhiho))
- Improved scheduling latency when many gated pods ([#124618](https://github.com/kubernetes/kubernetes/pull/124618), [@gabesaba](https://github.com/gabesaba))
- Kube-apiserver: fixed a 1.28 regression printing pods with invalid initContainer status. ([#124906](https://github.com/kubernetes/kubernetes/pull/124906), [@liggitt](https://github.com/liggitt))
- Kubeadm: don't mount /etc/pki in kube-apisever and kube-controller-manager pods as an additional Linux system CA location. Mount /etc/pki/ca-trust and /etc/pki/tls/certs instead. /etc/ca-certificate, /usr/share/ca-certificates, /usr/local/share/ca-certificates and /etc/ssl/certs continue to be mounted. ([#124361](https://github.com/kubernetes/kubernetes/pull/124361), [@neolit123](https://github.com/neolit123))
- Kubeadm: during kubelet health checks, respect the healthz address:port configured in the KubeletConfiguration instead of hardcoding localhost:10248. ([#125265](https://github.com/kubernetes/kubernetes/pull/125265), [@neolit123](https://github.com/neolit123))
- Kubeadm: during the preflight check "CreateJob" of "kubeadm upgrade", check if there are no nodes where a Pod can schedule. If there are none, show a warning and skip this preflight check. This can happen in single node clusters where the only node was drained. ([#124503](https://github.com/kubernetes/kubernetes/pull/124503), [@neolit123](https://github.com/neolit123))
- Kubeadm: fixed a bug where the PublicKeysECDSA feature gate was not respected when generating kubeconfig files. ([#125388](https://github.com/kubernetes/kubernetes/pull/125388), [@neolit123](https://github.com/neolit123))
- Kubeadm: fixed a regression where the JoinConfiguration.discovery.timeout was no longer respected and the value was always hardcoded to "5m" (5 minutes). ([#125480](https://github.com/kubernetes/kubernetes/pull/125480), [@neolit123](https://github.com/neolit123))
- Kubectl support both:
  - "kubectl create secret docker-registry <NAME> --from-file=<path/to/.docker/config.json>"
  - "kubectl create secret docker-registry <NAME> --from-file=.dockerconfigjson=<path/to/.docker/config.json>" ([#119589](https://github.com/kubernetes/kubernetes/pull/119589), [@carlory](https://github.com/carlory))
- Kubectl: Show the Pod phase in the STATUS column as 'Failed' or 'Succeeded' when the Pod is terminated ([#122038](https://github.com/kubernetes/kubernetes/pull/122038), [@lowang-bh](https://github.com/lowang-bh))
- Kubelet no longer crashes when a DRA driver returns a nil as part of the Node(Un)PrepareResources response instead of an empty struct (did not affect drivers written in Go, first showed up with a driver written in Rust). ([#124091](https://github.com/kubernetes/kubernetes/pull/124091), [@bitoku](https://github.com/bitoku))
- Removed admission plugin PersistentVolumeLabel. Please use https://github.com/kubernetes-sigs/cloud-pv-admission-labeler instead if you need a similar functionality. ([#124505](https://github.com/kubernetes/kubernetes/pull/124505), [@jsafrane](https://github.com/jsafrane))
- StatefulSet autodelete will respect controlling owners on PVC claims as described in https://github.com/kubernetes/enhancements/pull/4375 ([#122499](https://github.com/kubernetes/kubernetes/pull/122499), [@mattcary](https://github.com/mattcary))
- Status.terminating field now gets tracked faster when active Pods are deleted, specifically when Job is failed, gets suspended or has too many active pods ([#125175](https://github.com/kubernetes/kubernetes/pull/125175), [@dejanzele](https://github.com/dejanzele))
- The "fake" clients generated by `client-gen` now have the same semantics on
  error as the real clients; in particular, a failed Get(), Create(), etc, no longer
  returns `nil`. (It now returns a pointer to a zero-valued object, like the real
  clients do.) This will break some downstream unit tests that were testing
  `result == nil` rather than `err != nil`, and in some cases may expose bugs
  in the underlying code that were hidden by the incorrect unit tests. ([#122892](https://github.com/kubernetes/kubernetes/pull/122892), [@danwinship](https://github.com/danwinship))
- The Service LoadBalancer controller was not correctly considering the service.Status new IPMode field and excluding the Ports when comparing if the status has changed, causing that changes in these fields may not update the service.Status correctly ([#125225](https://github.com/kubernetes/kubernetes/pull/125225), [@aojea](https://github.com/aojea))
- The emission of RecreatingFailedPod and RecreatingTerminatedPod events has been
  removed from the StatefulSet lifecycle. ([#123809](https://github.com/kubernetes/kubernetes/pull/123809), [@atiratree](https://github.com/atiratree))
- The nftables kube-proxy mode now has its own metrics rather than reporting
  metrics with "iptables" in their names. ([#124557](https://github.com/kubernetes/kubernetes/pull/124557), [@danwinship](https://github.com/danwinship))
- Updated description of default values for --healthz-bind-address and --metrics-bind-address parameters ([#123545](https://github.com/kubernetes/kubernetes/pull/123545), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- `Job`: Fixed a bug where `SuccessCriteriaMet` could be added to the Job with
  `successPolicy` regardless of the `featureGate` being enabled. ([#125429](https://github.com/kubernetes/kubernetes/pull/125429), [@tenzen-y](https://github.com/tenzen-y))
- `kubeadm`: Allowed the `kubeadm init phase certs sa` command to accept the `--config` flag. ([#125396](https://github.com/kubernetes/kubernetes/pull/125396), [@Kavinraja-G](https://github.com/Kavinraja-G))
- `kubeadm`: Improved the `IsPrivilegedUser` preflight check to not fail on certain Windows setups. ([#124665](https://github.com/kubernetes/kubernetes/pull/124665), [@neolit123](https://github.com/neolit123))

### Other (Cleanup or Flake)

- ACTION-REQUIRED: DRA drivers using the v1alpha2 kubelet gRPC API are no longer supported and need to be updated. ([#124316](https://github.com/kubernetes/kubernetes/pull/124316), [@pohly](https://github.com/pohly))
- Built etcd image v3.5.13. ([#124026](https://github.com/kubernetes/kubernetes/pull/124026), [@liangyuanpeng](https://github.com/liangyuanpeng))
- Built etcd image v3.5.14. ([#125235](https://github.com/kubernetes/kubernetes/pull/125235), [@humblec](https://github.com/humblec))
- CSI spec support has been lifted to v1.9.0 in this release ([#125150](https://github.com/kubernetes/kubernetes/pull/125150), [@humblec](https://github.com/humblec))
- E2e.test and e2e_node.test: tests which depend on alpha or beta feature gates now have `Feature:Alpha` or `Feature:Beta` as Ginkgo labels. The inline text is `[Alpha]` or `[Beta]`, as before. ([#124350](https://github.com/kubernetes/kubernetes/pull/124350), [@pohly](https://github.com/pohly))
- Etcd: Updated to v3.5.13. ([#124027](https://github.com/kubernetes/kubernetes/pull/124027), [@liangyuanpeng](https://github.com/liangyuanpeng))
- Exposed the `apiserver_watch_cache_resource_version` metric to simplify debugging problems with watchcache. ([#125377](https://github.com/kubernetes/kubernetes/pull/125377), [@wojtek-t](https://github.com/wojtek-t))
- Fixed a typo in the help text for the pod_scheduling_sli_duration_seconds metric in kube-scheduler ([#124221](https://github.com/kubernetes/kubernetes/pull/124221), [@arturhoo](https://github.com/arturhoo))
- Job-controller: the `JobReadyPods` feature flag has been removed (deprecated since v1.31) ([#125168](https://github.com/kubernetes/kubernetes/pull/125168), [@kaisoz](https://github.com/kaisoz))
- Kubeadm: only enable the klog flags that are still supported for kubeadm, rather than hiding the unwanted flags. This means that the previously unrecommended hidden flags about klog (including `--alsologtostderr`, `--log-backtrace-at`, `--log-dir`, `--logtostderr`, `--log-file`, `--log-file-max-size`, `--one-output`, `--skip-log-headers`, `--stderrthreshold` and `--vmodule`) are no longer allowed to be used. ([#125179](https://github.com/kubernetes/kubernetes/pull/125179), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: removed the EXPERIMENTAL tag from the phase "kubeadm join control-plane-prepare download-certs". ([#124374](https://github.com/kubernetes/kubernetes/pull/124374), [@neolit123](https://github.com/neolit123))
- Kubeadm: removed the deprecated and NO-OP "kubeadm join control-plane-join update-status" phase. ([#124373](https://github.com/kubernetes/kubernetes/pull/124373), [@neolit123](https://github.com/neolit123))
- Kubeadm: removed the deprecated output.kubeadm.k8s.io/v1alpha2 API for structured output. Please use v1alpha3 instead. ([#124496](https://github.com/kubernetes/kubernetes/pull/124496), [@carlory](https://github.com/carlory))
- Kubeadm: the deprecated `UpgradeAddonsBeforeControlPlane` featuregate has been removed, upgrade of the CoreDNS and kube-proxy addons will not be triggered until all the control plane instances have been upgraded. ([#124715](https://github.com/kubernetes/kubernetes/pull/124715), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: the global --rootfs flag is now considered non-experimental. ([#124375](https://github.com/kubernetes/kubernetes/pull/124375), [@neolit123](https://github.com/neolit123))
- Kubectl describe service and ingress will now use endpointslices instead of ([#124598](https://github.com/kubernetes/kubernetes/pull/124598), [@aroradaman](https://github.com/aroradaman))
- Kubelet flags `--iptables-masquerade-bit` and `--iptables-drop-bit` were deprecated in v1.28 and have now been removed entirely. ([#122363](https://github.com/kubernetes/kubernetes/pull/122363), [@carlory](https://github.com/carlory))
- Migrated the pkg/proxy to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#122979](https://github.com/kubernetes/kubernetes/pull/122979), [@fatsheep9146](https://github.com/fatsheep9146))
- Moved remote CRI implementation from kubelet to `k8s.io/cri-client` repository. ([#124634](https://github.com/kubernetes/kubernetes/pull/124634), [@saschagrunert](https://github.com/saschagrunert))
- Removed GA ServiceNodePortStaticSubrange feature gate. ([#124738](https://github.com/kubernetes/kubernetes/pull/124738), [@xuzhenglun](https://github.com/xuzhenglun))
- Removed `ENABLE_CLIENT_GO_WATCH_LIST_ALPHA` environment variable from the reflector.
  To activate the feature set `KUBE_FEATURE_WatchListClient` environment variable or a corresponding command line option (this works only with binaries that explicitly expose it). ([#122791](https://github.com/kubernetes/kubernetes/pull/122791), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Removed generally available feature gate `CSINodeExpandSecret`. ([#124462](https://github.com/kubernetes/kubernetes/pull/124462), [@carlory](https://github.com/carlory))
- Removed generally available feature gate `ConsistentHTTPGetHandlers`. ([#124463](https://github.com/kubernetes/kubernetes/pull/124463), [@carlory](https://github.com/carlory))
- Removed generally available feature gate `ReadWriteOncePod`. ([#124329](https://github.com/kubernetes/kubernetes/pull/124329), [@chrishenzie](https://github.com/chrishenzie))
- Removed the last remaining in-tree gcp cloud provider and credential provider.
  Please use the external cloud provider and credential provider from https://github.com/kubernetes/cloud-provider-gcp
  instead. ([#124519](https://github.com/kubernetes/kubernetes/pull/124519), [@dims](https://github.com/dims))
- Scheduler framework: PreBind implementations are now allowed to return Pending and Unschedulable status codes. ([#125360](https://github.com/kubernetes/kubernetes/pull/125360), [@pohly](https://github.com/pohly))
- The feature gate "DefaultHostNetworkHostPortsInPodTemplates" has been removed.  This behavior was deprecated in v1.28, and has had no reports of trouble since. ([#124417](https://github.com/kubernetes/kubernetes/pull/124417), [@thockin](https://github.com/thockin))
- The feature gate "SkipReadOnlyValidationGCE" has been removed.  This gate has been active for "2" releases with no reports of issues (and was such a niche thing, we didn't expect any). ([#124210](https://github.com/kubernetes/kubernetes/pull/124210), [@thockin](https://github.com/thockin))
- The kube-scheduler exposes "/livez" and "/readz" for health checks that are in compliance with https://kubernetes.io/docs/reference/using-api/health-checks/#api-endpoints-for-health ([#118148](https://github.com/kubernetes/kubernetes/pull/118148), [@linxiulei](https://github.com/linxiulei))
- The kubelet is no longer able to recover from device manager state file older than 1.20. If the proper recommended upgrade flow is followed, there should be no issue. ([#123398](https://github.com/kubernetes/kubernetes/pull/123398), [@ffromani](https://github.com/ffromani))
- Updated CNI Plugins to v1.5.0. ([#125113](https://github.com/kubernetes/kubernetes/pull/125113), [@bzsuni](https://github.com/bzsuni))
- Updated cni-plugins to v1.4.1. ([#123894](https://github.com/kubernetes/kubernetes/pull/123894), [@saschagrunert](https://github.com/saschagrunert))
- Updated cri-tools to v1.30.0. ([#124364](https://github.com/kubernetes/kubernetes/pull/124364), [@saschagrunert](https://github.com/saschagrunert))
- `kubeadm`: The `NodeSwap` check that kubeadm performs during preflight, has a new warning to verify if swap has been configured correctly. ([#125157](https://github.com/kubernetes/kubernetes/pull/125157), [@carlory](https://github.com/carlory))