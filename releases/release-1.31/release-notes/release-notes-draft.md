## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Added support to the scheduler to start using QueueingHint registered for Pod/Updated event to determine whether unschedulable Pods update make them schedulable, when the feature gate `SchedulerQueueingHints` is enabled.
  Previously, when unschedulable Pods are updated, the scheduler always put Pods back to activeQ/backoffQ. But, actually not all updates to Pods make Pods schedulable, especially considering many scheduling constraints nowadays are immutable.
  Now, when unschedulable Pods are updated, the scheduling queue checks with QueueingHint(s) whether the update may make the pods schedulable, and requeues them to activeQ/backoffQ **only when** at least one QueueingHint(s) return Queue. 
  
  Action required for custom scheduler plugin developers:
  Plugins **have to** implement a QueueingHint for Pod/Update event if the rejection from them could be resolved by updating unscheduled Pods themselves.
  Example: suppose you develop a custom plugin that denies Pods that have a `schedulable=false` label. 
  Given Pods with a `schedulable=false` label will be schedulable if the `schedulable=false` label is removed, this plugin would implement QueueingHint for Pod/Update event that returns Queue when such label changes are made in unscheduled Pods. ([#122234](https://github.com/kubernetes/kubernetes/pull/122234), [@AxeZhan](https://github.com/AxeZhan)) [SIG Scheduling and Testing]
 - Kubelet flag `--keep-terminated-pod-volumes` was removed.  This flag was deprecated in 2017. ([#122082](https://github.com/kubernetes/kubernetes/pull/122082), [@carlory](https://github.com/carlory)) [SIG Apps, Node, Storage and Testing]
 - Reduced state change noise when volume expansion fails. Also mark certain failures as infeasible.
  
  If you are using the RecoverVolumeExpansionFailure Alpha feature, after upgrading to this release, existing PVCs with status.allocatedResourceStatus set to "ControllerResizeFailed" or "NodeResizeFailed" should have their status.allocatedResourceStatus cleared. ([#126108](https://github.com/kubernetes/kubernetes/pull/126108), [@gnufied](https://github.com/gnufied)) [SIG Apps, Auth, Node, Storage and Testing]
 
## Changes by Kind

### Deprecation

- 'kubeadm: marked the sub-phase of ''init kubelet-finilize'' called ''experimental-cert-rotation''
  as deprecated and print a warning if it is used directly; it will be removed in
  a future release. Add a replacement sub-phase ''enable-client-cert-rotation''.' ([#124419](https://github.com/kubernetes/kubernetes/pull/124419), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Added a warning when creating or updating a PersistentVolume (PV) with the deprecated annotation `volume.beta.kubernetes.io/mount-options`. ([#124819](https://github.com/kubernetes/kubernetes/pull/124819), [@carlory](https://github.com/carlory))
- CephFS volume plugin ( `kubernetes.io/cephfs`) was removed in this release and the `cephfs` volume type became non-functional. Alternative is to use CephFS CSI driver (https://github.com/ceph/ceph-csi/) in your Kubernetes Cluster. A re-deployment of your application is required to use the new driver if you were using `kubernetes.io/cephfs` volume plugin before upgrading cluster version to 1.31+. ([#124544](https://github.com/kubernetes/kubernetes/pull/124544), [@carlory](https://github.com/carlory)) [SIG Node, Scalability, Storage and Testing]
- CephRBD volume plugin ( `kubernetes.io/rbd`) was removed in this release. And its csi migration support was also removed, so the `rbd` volume type became non-functional. Alternative is to use RBD CSI driver (https://github.com/ceph/ceph-csi/) in your Kubernetes Cluster. A re-deployment of your application is required to use the new driver if you were using `kubernetes.io/rbd` volume plugin before upgrading cluster version to 1.31+. ([#124546](https://github.com/kubernetes/kubernetes/pull/124546), [@carlory](https://github.com/carlory)) [SIG Node, Scalability, Scheduling, Storage and Testing]
- Kube-scheduler deprecated all non-csi volumelimit plugins and removed those from defaults plugins. 
  - AzureDiskLimits
  - CinderLimits
  - EBSLimits
  - GCEPDLimits
  
  The NodeVolumeLimits plugin can handle the same functionality as the above plugins since the above volume types are migrated to CSI.
  Please remove those plugins and replace them with the NodeVolumeLimits plugin if you explicitly use those plugins in the scheduler config.
  Those plugins will be removed in the release 1.32. ([#124500](https://github.com/kubernetes/kubernetes/pull/124500), [@carlory](https://github.com/carlory)) [SIG Scheduling and Storage]
- Kubeadm: deprecated the kubeadm `RootlessControlPlane` feature gate (previously alpha), given that the core K8s `UserNamespacesSupport` feature gate graduated to beta in 1.30.
  Once core Kubernetes support for user namespaces is generally available and kubeadm has started to support running the control plane in userns pods, the kubeadm `RootlessControlPlane` feature gate will be removed entirely.
  Until kubeadm supports the userns functionality out of the box, users can continue using the deprecated  `RootlessControlPlane` feature gate, or  opt-in `UserNamespacesSupport` by using kubeadm patches on the static pod manifests. ([#124997](https://github.com/kubernetes/kubernetes/pull/124997), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Removed k8s.io/legacy-cloud-providers from staging. ([#124767](https://github.com/kubernetes/kubernetes/pull/124767), [@carlory](https://github.com/carlory)) [SIG API Machinery, Cloud Provider and Release]
- Removed legacy cloud provider integration code (undoing a previous reverted commit). ([#124886](https://github.com/kubernetes/kubernetes/pull/124886), [@carlory](https://github.com/carlory)) [SIG Cloud Provider and Release]

### API Change

- Add UserNamespaces field to NodeRuntimeHandlerFeatures ([#126034](https://github.com/kubernetes/kubernetes/pull/126034), [@sohankunkerkar](https://github.com/sohankunkerkar)) [SIG API Machinery, Apps and Node]
- Added Coordinated Leader Election as Alpha under the `CoordinatedLeaderElection` feature gate. With the feature enabled, the control plane can use LeaseCandidate objects (coordination.k8s.io/v1alpha1 API group) to participate in a leader election and let the kube-apiserver select the best instance according to some strategy. ([#124012](https://github.com/kubernetes/kubernetes/pull/124012), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery, Apps, Auth, Cloud Provider, Etcd, Node, Release, Scheduling and Testing]
- Added Node.Status.Features.SupplementalGroupsPolicy field which is set to true when the feature is implemented in the CRI implementation (KEP-3619). ([#125470](https://github.com/kubernetes/kubernetes/pull/125470), [@everpeace](https://github.com/everpeace)) [SIG API Machinery, Apps, Node and Testing]
- Added an AllocatedResourcesStatus to each container status to indicate the health status of devices exposed by the device plugin. ([#126243](https://github.com/kubernetes/kubernetes/pull/126243), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG API Machinery, Apps, Node and Testing]
- Added support to the kube-proxy nodePortAddresses / --nodeport-addresses option to
  accept the value "primary", meaning to only listen for NodePort connections
  on the node's primary IPv4 and/or IPv6 address (according to the Node object).
  This is strongly recommended, if you were not previously using
  --nodeport-addresses, to avoid surprising behavior.
  (This behavior is enabled by default with the nftables backend; you would
  need to explicitly request `--nodeport-addresses 0.0.0.0/0,::/0` there to get
  the traditional "listen on all interfaces" behavior.) ([#123105](https://github.com/kubernetes/kubernetes/pull/123105), [@danwinship](https://github.com/danwinship)) [SIG API Machinery, Network and Windows]
- Added the feature gates `StrictCostEnforcementForVAP` and `StrictCostEnforcementForWebhooks` to enforce the strict cost calculation for CEL extended libraries. It is strongly recommended to turn on the feature gates as early as possible. ([#124675](https://github.com/kubernetes/kubernetes/pull/124675), [@cici37](https://github.com/cici37)) [SIG API Machinery, Auth, Node and Testing]
- Changed how the API server handles updates to `.spec.defaultBackend` of Ingress objects.
  Server-side apply now considers `.spec.defaultBackend` to be an atomic struct.  This means that any field-owner who sets values in that struct (they are mutually exclusive) owns the whole struct. For almost all users this change has no impact; for controllers that want to change the default backend port from number to name (or vice-versa), this makes it easier. ([#126207](https://github.com/kubernetes/kubernetes/pull/126207), [@thockin](https://github.com/thockin)) [SIG API Machinery]
- Component-base/logs: when compiled with Go >= 1.21, component-base will automatically configure the slog default logger together with initializing klog. ([#120696](https://github.com/kubernetes/kubernetes/pull/120696), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Storage and Testing]
- CustomResourceDefinition objects created with non-empty `caBundle` fields which are invalid or do not contain any certificates will not appear in discovery or serve endpoints until a valid `caBundle` is provided. Updates to CustomResourceDefinition are no longer allowed to transition a valid `caBundle` field to an invalid `caBundle` field, because this breaks serving of the existing CustomResourceDefinition. ([#124061](https://github.com/kubernetes/kubernetes/pull/124061), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery]
- DRA: Added a feature so the number of ResourceClaim objects can be limited per namespace and by the number of devices requested through a specific class via the v1.ResourceQuota mechanism. ([#120611](https://github.com/kubernetes/kubernetes/pull/120611), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, CLI, Etcd, Node, Release, Scheduling and Testing]
- DRA: Added new API and several new features. ([#125488](https://github.com/kubernetes/kubernetes/pull/125488), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, CLI, Cluster Lifecycle, Etcd, Node, Release, Scheduling, Storage and Testing]
- DRA: The Dynamic Resource Allocation (DRA) driver's daemonset must be deployed with a service account that enables writing ResourceSlice and reading ResourceClaim objects. ([#125163](https://github.com/kubernetes/kubernetes/pull/125163), [@pohly](https://github.com/pohly)) [SIG Auth, Node and Testing]
- Dynamic Resource Allocation (DRA): client-side validation of a ResourceHandle would have accepted a missing DriverName, whereas server-side validation then would have raised an error. ([#124075](https://github.com/kubernetes/kubernetes/pull/124075), [@pohly](https://github.com/pohly))
- Dynamic Resource Allocation (DRA): in the `pod.spec.recourceClaims` array, the `source` indirection is no longer necessary. Instead of e.g. `source: resourceClaimTemplateName: my-template`, one can write `resourceClaimTemplateName: my-template`. ([#125116](https://github.com/kubernetes/kubernetes/pull/125116), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, Node, Scheduling and Testing]
- Fixed a 1.30.0 regression in OpenAPI descriptions of the `imagePullSecrets` and 
  `hostAliases` fields to mark the fields used as keys in those lists as either defaulted
  or required. ([#124553](https://github.com/kubernetes/kubernetes/pull/124553), [@pmalek](https://github.com/pmalek))
- Fixed a 1.30.0 regression in openapi descriptions of `PodIP.IP`  and `HostIP.IP` fields to mark the fields used as keys in those lists as required. ([#126057](https://github.com/kubernetes/kubernetes/pull/126057), [@thockin](https://github.com/thockin))
- Fixed a bug in the API server where empty collections of ValidatingAdmissionPolicies did not have an `items` field. ([#124568](https://github.com/kubernetes/kubernetes/pull/124568), [@xyz-li](https://github.com/xyz-li)) [SIG API Machinery]
- Fixed a deep copy issue when retrieving the controller reference. ([#124116](https://github.com/kubernetes/kubernetes/pull/124116), [@HiranmoyChowdhury](https://github.com/HiranmoyChowdhury)) [SIG API Machinery and Release]
- Fixed code-generator client-gen to work with `api/v1`-like package structure. ([#125162](https://github.com/kubernetes/kubernetes/pull/125162), [@sttts](https://github.com/sttts)) [SIG API Machinery and Apps]
- Fixed incorrect "v1 Binding is deprecated in v1.6+" warning in kube-scheduler log. ([#125540](https://github.com/kubernetes/kubernetes/pull/125540), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Fixed the comment for the Job's managedBy field. ([#124793](https://github.com/kubernetes/kubernetes/pull/124793), [@mimowo](https://github.com/mimowo)) [SIG API Machinery and Apps]
- Fixed the documentation for the default value of the procMount entry in the pod securityContext.
  The documentation was previously using the name of the internal variable 'DefaultProcMount' rather than the actual value 'Default'. ([#125782](https://github.com/kubernetes/kubernetes/pull/125782), [@aborrero](https://github.com/aborrero)) [SIG Apps and Node]
- Graduate PodDisruptionConditions to GA and lock ([#125461](https://github.com/kubernetes/kubernetes/pull/125461), [@mimowo](https://github.com/mimowo)) [SIG Apps, Node, Scheduling and Testing]
- Graduated MatchLabelKeys/MismatchLabelKeys feature in PodAffinity/PodAntiAffinity to Beta. ([#123638](https://github.com/kubernetes/kubernetes/pull/123638), [@sanposhiho](https://github.com/sanposhiho)) [SIG API Machinery, Apps, Scheduling and Testing]
- Graduated `JobPodFailurePolicy` to GA and locked it to it's default. ([#125442](https://github.com/kubernetes/kubernetes/pull/125442), [@mimowo](https://github.com/mimowo)) [SIG API Machinery, Apps, Scheduling and Testing]
- Graduated the Job SuccessPolicy to Beta.
  
  The new reason label, "SuccessPolicy" and "CompletionsReached" are added to the "jobs_finished_total" metric.
  Additionally, If we enable the "JobSuccessPolicy" feature gate, the Job gets "CompletionsReached" reason for the "SuccessCriteriaMet" and "Complete" condition type
  when the number of succeeded Job Pods (".status.succeeded") reached the desired completions (".spec.completions"). ([#126067](https://github.com/kubernetes/kubernetes/pull/126067), [@tenzen-y](https://github.com/tenzen-y)) [SIG API Machinery, Apps and Testing]
- Graduated the `DisableNodeKubeProxyVersion` feature gate to beta. By default, the kubelet no longer attempts to set the `.status.kubeProxyVersion` field for its associated Node. ([#123845](https://github.com/kubernetes/kubernetes/pull/123845), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG API Machinery, Cloud Provider, Network, Node and Testing]
- Improved scheduling performance when many nodes, and prefilter returned 1-2 nodes (e.g. daemonset)
  
  For developers of out-of-tree PostFilter plugins, note that the semantics of NodeToStatusMap are changing: A node with an absent value in the NodeToStatusMap should be interpreted as having an UnschedulableAndUnresolvable status. ([#125197](https://github.com/kubernetes/kubernetes/pull/125197), [@gabesaba](https://github.com/gabesaba))
- Introduced a new boolean kubelet flag `--fail-cgroupv1`. ([#126031](https://github.com/kubernetes/kubernetes/pull/126031), [@harche](https://github.com/harche)) [SIG API Machinery and Node]
- K8s.io/apimachinery/pkg/util/runtime: Added support for new calls to handle panics and errors in the context where they occur. `PanicHandlers` and `ErrorHandlers` now must accept a context parameter for that. Log output is structured instead of unstructured. ([#121970](https://github.com/kubernetes/kubernetes/pull/121970), [@pohly](https://github.com/pohly)) [SIG API Machinery and Instrumentation]
- KEP-1880: Users of the new feature to add multiple service CIDR will use by default a dual-write strategy on the new ClusterIP allocators to avoid the problem of possible duplicate IPs allocated to Services when running skewed kube-apiservers using different allocators. They can opt-out of this behavior by enabled the feature gate DisableAllocatorDualWrite. ([#122047](https://github.com/kubernetes/kubernetes/pull/122047), [@aojea](https://github.com/aojea)) [SIG API Machinery, Apps, Instrumentation and Testing]
- Kube-apiserver: Added Alpha features to allow API server authz to check the context of requests:
  - The `AuthorizeWithSelectors` feature gate enables including field and label selector information from requests in webhook authorization calls.
  - The `AuthorizeNodeWithSelectors` feature gate changes node authorizer behavior to limit requests from node API clients, so that each Node can only get / list / watch its own Node API object, and can also only get / list / watch Pod API objects bound to that node. Clients using kubelet credentials to read other nodes or unrelated pods must change their authentication credentials (recommended), adjust their usage, or obtain broader read access independent of the node authorizer. ([#125571](https://github.com/kubernetes/kubernetes/pull/125571), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth, Node, Scheduling and Testing]
- Kube-apiserver: ControllerRevision objects are now verified to contain valid JSON data in the `data` field. ([#125549](https://github.com/kubernetes/kubernetes/pull/125549), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Apps]
- Kube-apiserver: the `--encryption-provider-config` file is now loaded with strict deserialization, which fails if the config file contains duplicate or unknown fields. This protects against accidentally running with config files that are malformed, mis-indented, or have typos in field names, and getting unexpected behavior. When `--encryption-provider-config-automatic-reload` is used, new encryption config files that contain typos after the kube-apiserver is running are treated as invalid and the last valid config is used. ([#124912](https://github.com/kubernetes/kubernetes/pull/124912), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- Kube-controller-manager: the `horizontal-pod-autoscaler-upscale-delay` and `horizontal-pod-autoscaler-downscale-delay` flags have been removed (deprecated and non-functional since v1.12). ([#124948](https://github.com/kubernetes/kubernetes/pull/124948), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery, Apps and Autoscaling]
- Made kube-proxy Windows service control manager integration(--windows-service) configurable in v1alpha1 component configuration via `WindowsRunAsService` field. ([#126072](https://github.com/kubernetes/kubernetes/pull/126072), [@aroradaman](https://github.com/aroradaman)) [SIG Network and Scalability]
- PersistentVolumeLastPhaseTransitionTime feature is stable and enabled by default. ([#124969](https://github.com/kubernetes/kubernetes/pull/124969), [@RomanBednar](https://github.com/RomanBednar)) [SIG API Machinery, Apps, Storage and Testing]
- Promoted LocalStorageCapacityIsolation to Beta and enable if user namespace is enabled for the pod. ([#126014](https://github.com/kubernetes/kubernetes/pull/126014), [@PannagaRao](https://github.com/PannagaRao)) [SIG Apps, Autoscaling, Node, Storage and Testing]
- Promoted StatefulSetStartOrdinal to stable. This means `--feature-gates=StatefulSetStartOrdinal=true` are not needed on kube-apiserver and kube-controller-manager binaries and they'll be removed soon following policy at https://kubernetes.io/docs/reference/using-api/deprecation-policy/#deprecation. ([#125374](https://github.com/kubernetes/kubernetes/pull/125374), [@pwschuurman](https://github.com/pwschuurman)) [SIG API Machinery, Apps and Testing]
- Promoted feature-gate `VolumeAttributesClass` to Beta (disabled by default). Users need to enable the feature gate and the storage v1beta1 group to use this new feature.
  - Promoted API `VolumeAttributesClass` and `VolumeAttributesClassList` to `storage.k8s.io/v1beta1`. ([#126145](https://github.com/kubernetes/kubernetes/pull/126145), [@carlory](https://github.com/carlory)) [SIG API Machinery, Apps, CLI, Etcd, Storage and Testing]
- Removed deprecated command flags --volume-host-cidr-denylist
  and --volume-host-allow-local-loopback from kube-controller-manager.
   ([#124017](https://github.com/kubernetes/kubernetes/pull/124017), [@carlory](https://github.com/carlory)) [SIG API Machinery, Apps, Cloud Provider and Storage]
- Removed feature gate `CustomResourceValidationExpressions`. ([#126136](https://github.com/kubernetes/kubernetes/pull/126136), [@cici37](https://github.com/cici37)) [SIG API Machinery, Cloud Provider and Testing]
- Reverted "Move ConsistentListFromCache feature flag to Beta and enable it by default". ([#126139](https://github.com/kubernetes/kubernetes/pull/126139), [@enj](https://github.com/enj))
- Revised the Pod API with Alpha support for volumes derived from OCI artifacts. This feature is behind the `ImageVolume` feature gate. ([#125660](https://github.com/kubernetes/kubernetes/pull/125660), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery, Apps and Node]
- Supported fine-grained supplemental groups policy (KEP-3619), which enabled
  fine-grained control for supplementary groups in the first container processes.
  This allows you to choose whether to include groups defined in the container image (/etc/groups)
  for the container's primary UID or not. ([#117842](https://github.com/kubernetes/kubernetes/pull/117842), [@everpeace](https://github.com/everpeace)) [SIG API Machinery, Apps and Node]
- The (alpha) nftables mode of kube-proxy now requires version 1.0.1 or later
  of the nft command-line, and kernel 5.13 or later. (For testing/development
  purposes, you can use older kernels, as far back as 5.4, if you set the
  `nftables.skipKernelVersionCheck` option in the kube-proxy config, but this is not
  recommended in production since it may cause problems with other nftables
  users on the system.) ([#124152](https://github.com/kubernetes/kubernetes/pull/124152), [@danwinship](https://github.com/danwinship)) [SIG Network]
- To enhance usability and developer experience, CRD validation rules now support direct use of (CEL) reserved keywords as field names in object validation expressions for existing expressions in storage, will fully support runtime in next release for compatibility concern. ([#126188](https://github.com/kubernetes/kubernetes/pull/126188), [@cici37](https://github.com/cici37)) [SIG API Machinery and Testing]
- Updated the feature MultiCIDRServiceAllocator to beta (disabled by default). Users need to enable the feature gate and the networking v1beta1 group to be able to use this new feature, that allows to dynamically reconfigure Service CIDR ranges. ([#125021](https://github.com/kubernetes/kubernetes/pull/125021), [@aojea](https://github.com/aojea)) [SIG API Machinery, Apps, CLI, Etcd, Instrumentation, Network and Testing]
- Use omitempty for optional Job Pod Failure Policy fields. ([#126046](https://github.com/kubernetes/kubernetes/pull/126046), [@mimowo](https://github.com/mimowo))
- User can choose a different static policy option `SpreadPhysicalCPUsPreferredOption` to spread cpus across physical cpus for some specific applications ([#123733](https://github.com/kubernetes/kubernetes/pull/123733), [@Jeffwan](https://github.com/Jeffwan)) [SIG Node]
- When the featuregate AnonymousAuthConfigurableEndpoints is enabled users can update the AuthenticationConfig file with endpoints for with anonymous requests are alllowed. ([#124917](https://github.com/kubernetes/kubernetes/pull/124917), [@vinayakankugoyal](https://github.com/vinayakankugoyal)) [SIG API Machinery, Auth, Cloud Provider, Node and Testing]

### Feature

- 'kubeadm: enhanced the "patches" functionality to be able to patch coredns
  deployment. The new patch target is called "corednsdeployment" (e.g. patch file
  "corednsdeployment+json.json"). This makes it possible to apply custom patches
  to coredns deployment during "init" and "upgrade".' ([#124820](https://github.com/kubernetes/kubernetes/pull/124820), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- 'kubeadm: marked the flag "--experimental-output'' as deprecated (it will
  be removed in a future release) and added a new flag ''--output" that serves the
  same purpose. Affected commands are - "kubeadm config images list", "kubeadm token
  list", "kubeadm upgrade plan", "kubeadm certs check-expiration".' ([#124393](https://github.com/kubernetes/kubernetes/pull/124393), [@carlory](https://github.com/carlory)) [SIG Cluster Lifecycle]
- ACTION REQUIRED for custom scheduler plugin developers:
  `EventsToRegister` in the `EnqueueExtensions` interface gets `ctx` in the parameters and `error` in the return values.
  Please change your plugins' implementation accordingly. ([#126113](https://github.com/kubernetes/kubernetes/pull/126113), [@googs1025](https://github.com/googs1025)) [SIG Node, Scheduling, Storage and Testing]
- Add --for=create option to kubectl wait ([#125868](https://github.com/kubernetes/kubernetes/pull/125868), [@soltysh](https://github.com/soltysh)) [SIG CLI and Testing]
- Add a TopologyManager policy option: max-allowable-numa-nodes to configures maxAllowableNUMANodes for kubelet. ([#124148](https://github.com/kubernetes/kubernetes/pull/124148), [@cyclinder](https://github.com/cyclinder)) [SIG Node and Testing]
- Added Custom resource field selectors in beta and enabled them by default. Check out https://github.com/kubernetes/enhancements/issues/4358 for more details. ([#124681](https://github.com/kubernetes/kubernetes/pull/124681), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth and Testing]
- Added Extra.DisableAvailableConditionController for Generic Control Plane setup. ([#125650](https://github.com/kubernetes/kubernetes/pull/125650), [@mjudeikis](https://github.com/mjudeikis)) [SIG API Machinery]
- Added OCI VolumeSource Container Runtime Interface API fields and types. ([#125659](https://github.com/kubernetes/kubernetes/pull/125659), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- Added `--keep-*` flags to `kubectl debug`, which enables to control the removal
  of probes, labels, annotations and initContainers from copy pod. ([#123149](https://github.com/kubernetes/kubernetes/pull/123149), [@mochizuki875](https://github.com/mochizuki875)) [SIG CLI and Testing]
- Added `cri-client` staging repository. ([#123797](https://github.com/kubernetes/kubernetes/pull/123797), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery, Node, Release and Testing]
- Added `storage_class` and `volume_attributes_class` labels to `pv_collector_bound_pvc_count` and `pv_collector_unbound_pvc_count` metrics. ([#126166](https://github.com/kubernetes/kubernetes/pull/126166), [@AndrewSirenko](https://github.com/AndrewSirenko)) [SIG Apps, Instrumentation, Storage and Testing]
- Added a feature to report an event to pod if kubelet does `attach operation failed` when kubelet is running with `--enable-controller-attach-detach=false`. ([#124884](https://github.com/kubernetes/kubernetes/pull/124884), [@carlory](https://github.com/carlory))
- Added a warning log, an event for cgroup v1 usage and a metric for cgroup version. ([#125328](https://github.com/kubernetes/kubernetes/pull/125328), [@harche](https://github.com/harche))
- Added apiserver.latency.k8s.io/apf-queue-wait annotation to the audit log
  to record the time spent waiting in APF queue. ([#123919](https://github.com/kubernetes/kubernetes/pull/123919), [@hakuna-matatah](https://github.com/hakuna-matatah))
- Added check for etcd version to warn about deprecated etcd versions if `ConsistentListFromCache` is enabled. ([#124612](https://github.com/kubernetes/kubernetes/pull/124612), [@ah8ad3](https://github.com/ah8ad3)) [SIG API Machinery]
- Added completion for `kubectl set image`. ([#124592](https://github.com/kubernetes/kubernetes/pull/124592), [@ah8ad3](https://github.com/ah8ad3)) [SIG CLI]
- Added field management support to the fake client-go typed client.
  Use `fake.NewClientset()` instead of `fake.NewSimpleClientset()` to create a clientset with managed field support. ([#125560](https://github.com/kubernetes/kubernetes/pull/125560), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth, Instrumentation and Testing]
- Added flag to `kubectl logs` called `--all-pods` to get all pods from a object that uses a pod selector. ([#124732](https://github.com/kubernetes/kubernetes/pull/124732), [@cmwylie19](https://github.com/cmwylie19)) [SIG CLI and Testing]
- Added namespace autocompletion for `kubectl config set-context` command. ([#124994](https://github.com/kubernetes/kubernetes/pull/124994), [@TessaIO](https://github.com/TessaIO)) [SIG CLI]
- Added ports autocompletion for kubectl port-foward command. ([#124683](https://github.com/kubernetes/kubernetes/pull/124683), [@TessaIO](https://github.com/TessaIO)) [SIG CLI]
- Added support for CEL(Common Expression Language) expressions and `additionalProperties` to be used under nested quantifiers in CRD schemas. ([#124381](https://github.com/kubernetes/kubernetes/pull/124381), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery]
- Added support for building Windows kube-proxy container image.
  A container image for kube-proxy on Windows can now be built with the command
  `make release-images KUBE_BUILD_WINDOWS=y`.
  The Windows kube-proxy image can be used with Windows Host Process Containers. ([#109939](https://github.com/kubernetes/kubernetes/pull/109939), [@claudiubelu](https://github.com/claudiubelu)) [SIG Windows]
- Added support for kube-proxy iptables mode to track packets that were wrongfully marked invalid by conntrack and subsequently dropped by introducing `kubeproxy_iptables_ct_state_invalid_dropped_packets_total` metric. ([#122812](https://github.com/kubernetes/kubernetes/pull/122812), [@aroradaman](https://github.com/aroradaman)) [SIG Instrumentation, Network and Testing]
- Added the `WatchList` method to the `rest client` in `client-go`. When used,
  it establishes a stream to obtain a consistent snapshot of data from the server.
  This method is meant to be used by the generated client. ([#122657](https://github.com/kubernetes/kubernetes/pull/122657), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Added the ability to the kubelet server to dynamically load certificate files. ([#124574](https://github.com/kubernetes/kubernetes/pull/124574), [@zhangweikop](https://github.com/zhangweikop)) [SIG Auth and Node]
- Allowed creating ServiceAccount tokens bound to Node objects.
  This allows users to bind a service account token's validity to a named Node object, similar to Pod bound tokens.
  Use with `kubectl create token <serviceaccount-name> --bound-object-kind=Node --bound-object-node=<node-name>`. ([#125238](https://github.com/kubernetes/kubernetes/pull/125238), [@munnerz](https://github.com/munnerz)) [SIG Auth and CLI]
- Built Kubernetes with Go 1.22.3. ([#124828](https://github.com/kubernetes/kubernetes/pull/124828), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Built Kubernetes with Go 1.22.4. ([#125363](https://github.com/kubernetes/kubernetes/pull/125363), [@cpanato](https://github.com/cpanato)) [SIG Architecture, Cloud Provider, Release, Storage and Testing]
- Built kubernetes with `Go 1.23rc2`. ([#126047](https://github.com/kubernetes/kubernetes/pull/126047), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Bump the KubeletCgroupDriverFromCRI feature gate to beta and true by default. The kubelet will continue to use its KubeletConfiguration field as a fallback if the CRI implementation doesn't support this feature. ([#125828](https://github.com/kubernetes/kubernetes/pull/125828), [@haircommander](https://github.com/haircommander)) [SIG Node]
- CEL: added name formats library. ([#123572](https://github.com/kubernetes/kubernetes/pull/123572), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery]
- Changed Linux swap handling to restrict access to swap for containers in high priority Pods.
  New Pods that have a node- or cluster-critical priority are prohibited from accessing swap on Linux,
  even if your cluster and node configuration could otherwise allow this. ([#125277](https://github.com/kubernetes/kubernetes/pull/125277), [@iholder101](https://github.com/iholder101)) [SIG Node and Testing]
- Client-go/reflector: warns when the bookmark event for initial events hasn't been received ([#124614](https://github.com/kubernetes/kubernetes/pull/124614), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Continued streaming kubelet logs when the CRI server of the runtime was unavailable. ([#124025](https://github.com/kubernetes/kubernetes/pull/124025), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- Delay setting terminal Job conditions until all pods are terminal.
  
  Additionally, the FailureTarget condition is also added to the Job object in the first Job
  status update as soon as the failure conditions are met (backoffLimit is exceeded, maxFailedIndexes, 
  or activeDeadlineSeconds is exceeded).
  
  Similarly, the SuccessCriteriaMet condition is added in the first update as soon as the expected number
  of pod completions is reached.
  
  Also, introduce the following validation rules for Job status when JobManagedBy is enabled:
  1. the count of ready pods is less or equal than active
  2. when transitioning to terminal phase for Job, the number of terminating pods is 0
  3. terminal Job conditions (Failed and Complete) should be preceded by adding the corresponding interim conditions: FailureTarget and SuccessCriteriaMet ([#125510](https://github.com/kubernetes/kubernetes/pull/125510), [@mimowo](https://github.com/mimowo)) [SIG Apps and Testing]
- Dependencies: started using registry.k8s.io/pause:3.10. ([#125112](https://github.com/kubernetes/kubernetes/pull/125112), [@neolit123](https://github.com/neolit123)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Node, Release, Testing and Windows]
- Enabled feature gates for PortForward (kubectl port-forward) over WebSockets by default (beta).
   - Server-side feature gate: PortForwardWebsocket
   - Client-side (kubectl) feature gate: PORT_FORWARD_WEBSOCKETS environment variable
   - To turn off PortForward over WebSockets for kubectl, the environment variable feature gate must be explicitly set - PORT_FORWARD_WEBSOCKETS=false ([#125528](https://github.com/kubernetes/kubernetes/pull/125528), [@seans3](https://github.com/seans3)) [SIG API Machinery and CLI]
- Enforced kubelet to request serving certificates only once it has at least one IP address in the `.status.addresses` of its associated Node object. This avoids requesting DNS-only serving certificates before externally set addresses are in place. Until 1.33, the previous behavior can be opted back into by setting the deprecated AllowDNSOnlyNodeCSR feature gate to true in the kubelet. ([#125813](https://github.com/kubernetes/kubernetes/pull/125813), [@aojea](https://github.com/aojea)) [SIG Auth, Cloud Provider and Node]
- Fixed a missing behavior where Windows nodes did not implement memory-pressure eviction. ([#122922](https://github.com/kubernetes/kubernetes/pull/122922), [@marosset](https://github.com/marosset)) [SIG Node, Testing and Windows]
- Graduated Kubernetes' support for AppArmor to GA. ([#125257](https://github.com/kubernetes/kubernetes/pull/125257), [@vinayakankugoyal](https://github.com/vinayakankugoyal)) [SIG Apps, Node and Testing]
- Graduated support for Container Device Interface (CDI) device IDs to general availability. The `DevicePluginCDIDevices` feature gate is now enabled unconditionally. ([#123315](https://github.com/kubernetes/kubernetes/pull/123315), [@bart0sh](https://github.com/bart0sh)) [SIG Node]
- Graduated the `WatchList` feature gate to beta for kube-apiserver and enabled `WatchListClient` for kube-controller-manager (KCM). ([#125591](https://github.com/kubernetes/kubernetes/pull/125591), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery and Testing]
- If the feature-gate VolumeAttributesClass is enabled, when finding a suitable persistent volume for a claim, the kube-controller-manager will be aware of the `volumeAttributesClassName` field of PVC and PV objects. The `volumeAttributesClassName` field is a reference to a VolumeAttributesClass object, which contains a set of key-value pairs that present mutable attributes of the volume. It's forbidden to change the `volumeAttributesClassName` field of a PVC object until the PVC is bound to a PV object. During the binding process, if a PVC has a `volumeAttributesClassName` field set, the controller will only consider volumes that have the same `volumeAttributesClassName` as the PVC. If the `volumeAttributesClassName` field is not set or set to an empty string, only volumes with empty `volumeAttributesClassName` will be considered. ([#121902](https://github.com/kubernetes/kubernetes/pull/121902), [@carlory](https://github.com/carlory)) [SIG Apps, Scheduling, Storage and Testing]
- Implemented `event_handling_duration_seconds` metric, which is the time the scheduler takes to handle each kind of events. ([#125929](https://github.com/kubernetes/kubernetes/pull/125929), [@sanposhiho](https://github.com/sanposhiho))
- Implemented `queueing_hint_execution_duration_seconds` metric, which is the time the QueueingHint function takes. ([#126227](https://github.com/kubernetes/kubernetes/pull/126227), [@sanposhiho](https://github.com/sanposhiho))
- Implemented new cluster events UpdatePodScaleDown and UpdatePodLabel for scheduler plugins. ([#122628](https://github.com/kubernetes/kubernetes/pull/122628), [@sanposhiho](https://github.com/sanposhiho))
- Improved memory usage of kube-apiserver by dropping`.metadata.managedFields` field that self-requested informers of kube-apiserver didn't need. ([#124667](https://github.com/kubernetes/kubernetes/pull/124667), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery]
- In the client-side apply on create, defining the null value as "delete the key associated with this value". ([#125646](https://github.com/kubernetes/kubernetes/pull/125646), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG API Machinery, CLI and Testing]
- Introduces new functionality to the client-go's `List` method, allowing users to enable API streaming. To activate this feature, users can set the `client-go.WatchListClient` feature gate.
  
  It is important to note that the server must support streaming for this feature to function properly. If streaming is not supported by the server, client-go will revert to using the normal `LIST` method to obtain data. ([#124509](https://github.com/kubernetes/kubernetes/pull/124509), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery, Auth, Instrumentation and Testing]
- Introduces new functionality to the dynamic client's `List` method, allowing users to enable API streaming. To activate this feature, users can set the `client-go.WatchListClient` feature gate.
  
  It is important to note that the server must support streaming for this feature to function properly. If streaming is not supported by the server, the client will revert to using the normal `LIST` method to obtain data. ([#125305](https://github.com/kubernetes/kubernetes/pull/125305), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery and Testing]
- KEP-3857: promoted RecursiveReadOnlyMounts feature to beta. ([#125475](https://github.com/kubernetes/kubernetes/pull/125475), [@AkihiroSuda](https://github.com/AkihiroSuda)) [SIG Node]
- Kube-apiserver: Added support to disable http/2 serving with a `--disable-http2-serving` flag.
   ([#122176](https://github.com/kubernetes/kubernetes/pull/122176), [@slashpai](https://github.com/slashpai)) [SIG API Machinery]
- Kube-apiserver: when the Alpha `UserNamespacesPodSecurityStandards` feature gate is enabled, Pod Security Admission enforcement of the baseline policy now allows `procMount=Unmasked` for user namespace pods that set `hostUsers=false`. ([#126163](https://github.com/kubernetes/kubernetes/pull/126163), [@haircommander](https://github.com/haircommander))
- Kube-proxy's nftables mode (--proxy-mode=nftables) is now beta and available by default. ([#124383](https://github.com/kubernetes/kubernetes/pull/124383), [@danwinship](https://github.com/danwinship)) [SIG Cloud Provider and Network]
- Kube-scheduler implemented scheduling hints for the CSILimit plugin.
  The scheduling hints allow the scheduler to retry scheduling a Pod that was previously rejected by the CSILimit plugin if a deleted pod has a PersistantVolumeClaim (PVC) from the same driver. ([#121508](https://github.com/kubernetes/kubernetes/pull/121508), [@utam0k](https://github.com/utam0k)) [SIG Scheduling and Storage]
- Kube-scheduler implemented scheduling hints for the VolumeBinding plugin.
  The scheduling hints allow the scheduler to retry scheduling a Pod that was previously rejected by the VolumeBinding plugin only if a new resource referenced by the plugin was created or an existing resource referenced by the plugin was updated. ([#124959](https://github.com/kubernetes/kubernetes/pull/124959), [@bells17](https://github.com/bells17)) [SIG Scheduling and Storage]
- Kube-scheduler implemented scheduling hints for the VolumeBinding plugin.
  The scheduling hints allow the scheduler to retry scheduling a Pod that was previously rejected by the VolumeBinding plugin only if a new resource referenced by the plugin was created or an existing resource referenced by the plugin was updated. ([#124961](https://github.com/kubernetes/kubernetes/pull/124961), [@bells17](https://github.com/bells17)) [SIG Scheduling and Storage]
- Kube-scheduler implemented scheduling hints for the VolumeRestriction plugin.
  Scheduling hints allow the scheduler to retry scheduling Pods that were previously rejected by the VolumeRestriction plugin if the Pod is deleted and the deleted Pod conflicts with the existing volumes of the current Pod. ([#125279](https://github.com/kubernetes/kubernetes/pull/125279), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG Scheduling and Storage]
- Kube-scheduler implementedscheduling hints for the VolumeBinding plugin.
  The scheduling hints allow the scheduler to retry scheduling a Pod that was previously rejected by the VolumeBinding plugin only if a new resource referenced by the plugin was created or an existing resource referenced by the plugin was updated. ([#124958](https://github.com/kubernetes/kubernetes/pull/124958), [@bells17](https://github.com/bells17)) [SIG Scheduling and Storage]
- Kube-scheduler implements scheduling hints for the VolumeRestriction plugin.
  Scheduling hints allow the scheduler to retry scheduling Pods that were previously rejected by the VolumeRestriction plugin if a new pvc added, and the pvc belongs to pod. ([#125280](https://github.com/kubernetes/kubernetes/pull/125280), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG Scheduling and Storage]
- Kube-scheduler implements scheduling hints for the VolumeZone plugin.
  The scheduling hints allow the scheduler to only retry scheduling a Pod
  that was previously rejected by the VolemeZone plugin if  addition/update of node, 
  addition/update of PV, addition/update of PVC, or addition of SC matches pod's topology settings. ([#124996](https://github.com/kubernetes/kubernetes/pull/124996), [@Gekko0114](https://github.com/Gekko0114)) [SIG Scheduling and Storage]
- Kube-scheduler implements scheduling hints for the VolumeZone plugin.
  The scheduling hints allow the scheduler to only retry scheduling a Pod
  that was previously rejected by the VolemeZone plugin if  addition/update of node, 
  addition/update of PV, addition/update of PVC, or addition of SC matches pod's topology settings. ([#125000](https://github.com/kubernetes/kubernetes/pull/125000), [@Gekko0114](https://github.com/Gekko0114)) [SIG Scheduling and Storage]
- Kube-scheduler implements scheduling hints for the VolumeZone plugin.
  The scheduling hints allow the scheduler to only retry scheduling a Pod
  that was previously rejected by the VolemeZone plugin if  addition/update of node, 
  addition/update of PV, addition/update of PVC, or addition of SC matches pod's topology settings. ([#125001](https://github.com/kubernetes/kubernetes/pull/125001), [@Gekko0114](https://github.com/Gekko0114)) [SIG Scheduling and Storage]
- Kubeadm: Ensured that during "upgrade" , if the "etcd.yaml" static pod did not need upgrade, still consider rotating the etcd certificates and restarting the etcd static pod if the "kube-apiserver.yaml" manifest was to be upgraded and if certificate renewal was not disabled. ([#124688](https://github.com/kubernetes/kubernetes/pull/124688), [@neolit123](https://github.com/neolit123))
- Kubeadm: Switched kubeadm to start using the CRI client library instead of shelling out of the `crictl` binary
  for actions against a CRI endpoint. The kubeadm deb/rpm packages will continue to install the `cri-tools`
  package for one more release, but in you must adapt your scripts to install `crictl` manually from
  https://github.com/kubernetes-sigs/cri-tools/releases or a different location.
  
  The `kubeadm` package will stop depending on the `cri-tools` package in Kubernetes 1.32, which means that
  installing `kubeadm` will no longer automatically ensure installation of `crictl`. ([#124685](https://github.com/kubernetes/kubernetes/pull/124685), [@saschagrunert](https://github.com/saschagrunert))
- Kubeadm: Switched to using the new etcd endpoints introduced in 3.5.11 - /livez (for liveness probe) and /readyz (for readyness and startup probe). With this change it is no longer possible to deploy a custom etcd version older than 3.5.11 with kubeadm 1.31. If so, please upgrade etcd to a supported version. ([#124465](https://github.com/kubernetes/kubernetes/pull/124465), [@neolit123](https://github.com/neolit123))
- Kubeadm: Used output/v1alpha3 to print structural output for the commands "kubeadm config images list" and "kubeadm token list". ([#124464](https://github.com/kubernetes/kubernetes/pull/124464), [@carlory](https://github.com/carlory))
- Kubeadm: added the ControlPlaneKubeletLocalMode feature gate. It can be used to tell kubeadm to use the local kube-apiserver endpoint for the kubelet when creating a cluster with "kubeadm init" or when joining control plane nodes with "kubeadm join".  The "kubeadm join" workflow now includes two new experimental phases called "control-plane-join-etcd" and "kubelet-wait-bootstrap" which will be used when the feature gate is enabled. This phases will be marked as non-experimental when ControlPlaneKubeletLocalMode becomes GA. During "kubeadm upgrade" commands, if the feature gate is enabled, modify the "/etc/kubernetes/kubelet.conf " to use the local kube-apiserver endpoint. This upgrade mechanism will be removed once the feature gate goes GA and is hardcoded to true. ([#125582](https://github.com/kubernetes/kubernetes/pull/125582), [@chrischdi](https://github.com/chrischdi))
- Kubeadm: enabled the v1beta4 API. For a complete changelog since v1beta3 please see https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/. 
  
  The API does include a few breaking changes:
  - The "extraArgs" component construct is now a list of "name"/"value" pairs instead of a string/string map. This has been done to support duplicate args where needed.
  - The "JoinConfiguration.discovery.timeout" field has been replaced by "JoinConfiguration.timeouts.discovery".
  - The "ClusterConfiguration.timeoutForControlPlane" field has been replaced by "{Init|Join}Configuration.timeouts.controlPlaneComponentHealthCheck".
  Please use the command "kubeadm config migrate" to migrate your existing v1beta3 configuration to v1beta4.
  
  v1beta3 is now marked as deprecated but will continue to be supported until version 1.34 or later.
  The storage configuration in the kube-system/kubeadm-config ConfigMap is now a v1beta4 ClusterConfiguration. ([#125029](https://github.com/kubernetes/kubernetes/pull/125029), [@neolit123](https://github.com/neolit123))
- Kubelet would not restart the container when fields other than image in the Pod spec change. pod spec change. ([#124220](https://github.com/kubernetes/kubernetes/pull/124220), [@HirazawaUi](https://github.com/HirazawaUi))
- Kubelet/stats: set INFO log level for stats not found in cadvisor memory cache error. ([#125656](https://github.com/kubernetes/kubernetes/pull/125656), [@gyuho](https://github.com/gyuho))
- Kubelet: warn instead of error for the unsupported options on Windows "CgroupsPerQOS" and "EnforceNodeAllocatable". ([#123137](https://github.com/kubernetes/kubernetes/pull/123137), [@neolit123](https://github.com/neolit123)) [SIG Node and Windows]
- Kubemark: added two flags, `--kube-api-qps` which indicates the maximum QPS to the apiserver, and `--kube-api-burst` which indicates maximum burst for throttle to the apiserver. ([#124147](https://github.com/kubernetes/kubernetes/pull/124147), [@devincd](https://github.com/devincd))
- Kubernetes is now built with go 1.22.5. ([#125894](https://github.com/kubernetes/kubernetes/pull/125894), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- LogarithmicScaleDown is now GA. ([#125459](https://github.com/kubernetes/kubernetes/pull/125459), [@MinpengJin](https://github.com/MinpengJin)) [SIG Apps and Scheduling]
- Moved `ConsistentListFromCache` feature flag to beta and enabled it by default. ([#123513](https://github.com/kubernetes/kubernetes/pull/123513), [@serathius](https://github.com/serathius)) [SIG API Machinery and Testing]
- Promote HonorPVReclaimPolicy to beta and enable the feature-gate by default ([#124842](https://github.com/kubernetes/kubernetes/pull/124842), [@carlory](https://github.com/carlory)) [SIG Apps, Storage and Testing]
- Promoted KEP-4191 "Split Image Filesystem" to Beta. ([#126205](https://github.com/kubernetes/kubernetes/pull/126205), [@kwilczynski](https://github.com/kwilczynski))
- Promoted ProcMountType feature to Beta. ([#125259](https://github.com/kubernetes/kubernetes/pull/125259), [@sohankunkerkar](https://github.com/sohankunkerkar))
- Promoted `generateName` retries to beta, and made the `NameGenerationRetries` feature gate
  enabled by default.
  You can read https://kep.k8s.io/4420 for more details. ([#124673](https://github.com/kubernetes/kubernetes/pull/124673), [@jpbetz](https://github.com/jpbetz))
- Promoted the feature gate `KubeProxyDrainingTerminatingNodes` to stable ([#125082](https://github.com/kubernetes/kubernetes/pull/125082), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Promoted the metrics for both VAP and CRD validation rules to Beta. ([#126237](https://github.com/kubernetes/kubernetes/pull/126237), [@cici37](https://github.com/cici37)) [SIG API Machinery and Instrumentation]
- Scheduler changes its logic of calculating `evaluatedNodes` from "contains the number of nodes that filtered out by PreFilterResult and Filter plugins" to "the number of nodes filtered out by Filter plugins only". ([#124735](https://github.com/kubernetes/kubernetes/pull/124735), [@AxeZhan](https://github.com/AxeZhan))
- Services implemented a field selector for the ClusterIP and Type fields.
  The Kubelet uses this field selector to avoid monitoring Headless Services, which helps reduce memory consumption. ([#123905](https://github.com/kubernetes/kubernetes/pull/123905), [@aojea](https://github.com/aojea)) [SIG Apps, Node and Testing]
- Starting in 1.31, `container_engine_t` was added to the list of allowed SELinux types in the baseline Pod Security Standards profile. ([#126165](https://github.com/kubernetes/kubernetes/pull/126165), [@haircommander](https://github.com/haircommander))
- The PodDisruptionBudget `spec.unhealthyPodEvictionPolicy` field has graduated to GA. This field may be set to `AlwaysAllow` to always allow unhealthy pods covered by the PodDisruptionBudget to be evicted. ([#123428](https://github.com/kubernetes/kubernetes/pull/123428), [@atiratree](https://github.com/atiratree)) [SIG Apps, Auth, Node and Testing]
- The Service trafficDistribution field has graduated to beta and is now available for configuration by default, without the need to enable any feature flag. Services that do not have the field configured will continue to operate with their existing behavior. Refer to the documentation https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution for more details. ([#125838](https://github.com/kubernetes/kubernetes/pull/125838), [@gauravkghildiyal](https://github.com/gauravkghildiyal)) [SIG Network and Testing]
- The feature-gate CSIMigrationPortworx was promoted to beta in Kubernetes 1.25, but turned off by default. In 1.31, it was turned on by default. Before upgrading to 1.31, please make sure that the corresponding portworx csi driver is installed if you are using Portworx. ([#125016](https://github.com/kubernetes/kubernetes/pull/125016), [@carlory](https://github.com/carlory)) [SIG Storage]
- The iptables mode of kube-proxy now tracks accepted packets that are destined for node-ports on localhost by introducing `kubeproxy_iptables_localhost_nodeports_accepted_packets_total` metric.
  This will help users to identify if they rely on iptables.localhostNodePorts feature and ulitmately help them to migrate from iptables to nftables. ([#125015](https://github.com/kubernetes/kubernetes/pull/125015), [@aroradaman](https://github.com/aroradaman)) [SIG Instrumentation, Network and Testing]
- The kube-proxy command line flag `--proxy-port-range`, which was previously deprecated and non-functional, has now been removed. ([#126293](https://github.com/kubernetes/kubernetes/pull/126293), [@aroradaman](https://github.com/aroradaman)) [SIG Network]
- The kube-scheduler added scheduling hints for the InterPodAffinity plugin.
  These hints allow the scheduler to retry scheduling a Pod
  that was previously rejected by the InterPodAffinity plugin if there are changes (create, delete, or update) to a related Pod or a node that matches the pod affinity criteria. ([#122471](https://github.com/kubernetes/kubernetes/pull/122471), [@nayihz](https://github.com/nayihz)) [SIG Scheduling and Testing]
- The name of CEL(Common Expression Language) optional type has been changed from `optional` to `optional_type`. ([#124328](https://github.com/kubernetes/kubernetes/pull/124328), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Network and Node]
- The scheduler implemented QueueingHint in the TaintToleration plugin, enhancing the throughput of scheduling. ([#124287](https://github.com/kubernetes/kubernetes/pull/124287), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling and Testing]
- The scheduler implements QueueingHint in VolumeBinding plugin's CSINode event, which enhances the throughput of scheduling. ([#125097](https://github.com/kubernetes/kubernetes/pull/125097), [@YamasouA](https://github.com/YamasouA)) [SIG Scheduling and Storage]
- The sidecars' finish time will now be accounted for when calculating the job's finish time. ([#124942](https://github.com/kubernetes/kubernetes/pull/124942), [@AxeZhan](https://github.com/AxeZhan)) [SIG Apps]
- This PR added tracing support to the kubelet's read-only endpoint, which currently
  does not have tracing. It makes use of the `WithPublicEndpoint` option to prevent callers
  from influencing sampling decisions. ([#121770](https://github.com/kubernetes/kubernetes/pull/121770), [@frzifus](https://github.com/frzifus)) [SIG Node]
- Updated the CEL default compatibility environment version to 1.30, ensuring that extended libraries added before version 1.30 are available for use. ([#124779](https://github.com/kubernetes/kubernetes/pull/124779), [@cici37](https://github.com/cici37))
- Users can traverse all the pods that are in the scheduler and waiting in the permit stage through method `IterateOverWaitingPods`. In other words,  all waitingPods in scheduler can be obtained from any profiles. Before this commit, each profile could only obtain waitingPods within that profile. ([#124926](https://github.com/kubernetes/kubernetes/pull/124926), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Windows Kubeproxy will use the update load balancer API for load balancer updates, instead of the previous delete and create APIs.
  - Deletion of remote endpoints will be triggered only for terminated endpoints (those present in the old endpoints map but not in the new endpoints map), whereas previously it was also done for terminating endpoints. ([#124092](https://github.com/kubernetes/kubernetes/pull/124092), [@princepereira](https://github.com/princepereira)) [SIG Network and Windows]
- `--custom` flag in `kubectl debug` will be enabled by default and yaml support is added. ([#125333](https://github.com/kubernetes/kubernetes/pull/125333), [@ardaguclu](https://github.com/ardaguclu)) [SIG CLI and Testing]
- `ElasticIndexedJob` is graduated to GA. ([#125751](https://github.com/kubernetes/kubernetes/pull/125751), [@ahg-g](https://github.com/ahg-g)) [SIG Apps and Testing]
- `pause`: Added a `-v` flag to the Windows variant of the pause binary, which
  prints the version of pause and exits. The Linux pause binary already has this flag. ([#125067](https://github.com/kubernetes/kubernetes/pull/125067), [@neolit123](https://github.com/neolit123))

### Failing Test

- Fixed bug in KEP-4191 if feature gate is turned on but container runtime is not configured. ([#126335](https://github.com/kubernetes/kubernetes/pull/126335), [@kannon92](https://github.com/kannon92))
- Fixed issue where following Windows container logs would prevent container log rotation. ([#124444](https://github.com/kubernetes/kubernetes/pull/124444), [@claudiubelu](https://github.com/claudiubelu)) [SIG Node, Testing and Windows]
- Introduced `Wait(context.Context) error` method in pkg k8s.io/apiserver/pkg/storage/cacher to improve watch cache initialization resilience. ([#125450](https://github.com/kubernetes/kubernetes/pull/125450), [@mauri870](https://github.com/mauri870))
- Reverted remove legacycloudproviders from staging. ([#124864](https://github.com/kubernetes/kubernetes/pull/124864), [@carlory](https://github.com/carlory))

### Bug or Regression

- "Fixed the ResourceClaim controller forgetting to wait for `podSchedulingSynced` 
  and `templatesSynced`." ([#124589](https://github.com/kubernetes/kubernetes/pull/124589), [@carlory](https://github.com/carlory)) [SIG Apps and Node]
- 'kubeadm: Stopped storing the ResolverConfig in the global KubeletConfiguration
  and sets it dynamically for each node instead.' ([#124038](https://github.com/kubernetes/kubernetes/pull/124038), [@SataQiu](https://github.com/SataQiu))
- 'kubeadm: fixed a regression where the KubeletConfiguration is not properly
  downloaded during "kubeadm upgrade" command from the kube-system/kubelet-config
  ConfigMap, resulting in the local ''/var/lib/kubelet/config.yaml'' file being
  written as a defaulted config.' ([#124480](https://github.com/kubernetes/kubernetes/pull/124480), [@neolit123](https://github.com/neolit123))
- .status.terminating field now gets tracked faster when active Pods are deleted, specifically when Job is failed, gets suspended or has too many active pods. ([#125175](https://github.com/kubernetes/kubernetes/pull/125175), [@dejanzele](https://github.com/dejanzele)) [SIG Apps and Testing]
- Added `/sys/devices/virtual/powercap` to default masked paths. It avoids the potential security risk that the ability to read these files may offer a power-based sidechannel attack against any workloads running on the same kernel. ([#125970](https://github.com/kubernetes/kubernetes/pull/125970), [@carlory](https://github.com/carlory))
- Added an extra line between two different key value pairs under data when running `kubectl describe configmap`. ([#123597](https://github.com/kubernetes/kubernetes/pull/123597), [@siddhantvirus](https://github.com/siddhantvirus))
- Added kubectl support for:
  - kubectl create secret docker-registry <NAME> --from-file=<path/to/.docker/config.json>
  - kubectl create secret docker-registry <NAME> --from-file=.dockerconfigjson=<path/to/.docker/config.json> ([#119589](https://github.com/kubernetes/kubernetes/pull/119589), [@carlory](https://github.com/carlory))
- Added metrics for the nftables kube-proxy mode rather than it reporting
  metrics with "iptables" in their names. ([#124557](https://github.com/kubernetes/kubernetes/pull/124557), [@danwinship](https://github.com/danwinship)) [SIG Network and Windows]
- Allowed calling Stop multiple times on RetryWatcher without panicking. ([#126125](https://github.com/kubernetes/kubernetes/pull/126125), [@mprahl](https://github.com/mprahl))
- Allowed parameter to be set along with proto file path. ([#124281](https://github.com/kubernetes/kubernetes/pull/124281), [@fulviodenza](https://github.com/fulviodenza))
- Cel: converting a quantity value into a quantity value failed. ([#123669](https://github.com/kubernetes/kubernetes/pull/123669), [@pohly](https://github.com/pohly))
- Client-go/tools/record.Broadcaster: Fixed automatic shutdown on WithContext cancellation. ([#124635](https://github.com/kubernetes/kubernetes/pull/124635), [@pohly](https://github.com/pohly))
- Do not remove the "batch.kubernetes.io/job-tracking" finalizer from a Pod, in a corner
  case scenario, when the Pod is controlled by an API object which is not a batch Job
  (e.g. when the Pod is controlled by a custom CRD). ([#124798](https://github.com/kubernetes/kubernetes/pull/124798), [@mimowo](https://github.com/mimowo)) [SIG Apps and Testing]
- Dropped the additional rule requirement (cronjobs/finalizers) for roles
  using kubectl create cronjobs to ensure backward compatibility. ([#124883](https://github.com/kubernetes/kubernetes/pull/124883), [@ardaguclu](https://github.com/ardaguclu))
- Dynamic Resource Allocation (DRA): using structured parameters with a claim that gets reused between pods may have led to a claim with an invalid state (allocated without a finalizer) which then caused scheduling of pods using the claim to stop. ([#124931](https://github.com/kubernetes/kubernetes/pull/124931), [@pohly](https://github.com/pohly)) [SIG Node and Scheduling]
- Dynamic Resource Allocator (DRA): Enhanced validation for the ResourceClaimParametersReference and ResourceClassParametersReference with the following rules:
  
  1. `apiGroup`: If set, it must be a valid DNS subdomain (e.g. 'example.com').
  2. `kind` and `name`: It must be valid path segment name. It may not be '.' or '..' and it may not contain '/' and '%' characters. ([#125218](https://github.com/kubernetes/kubernetes/pull/125218), [@carlory](https://github.com/carlory))
- Enabled kubectl to find `kubectl-create-subcommand` plugins when positional
  arguments exists, e.g. `kubectl create subcommand arg`. ([#124123](https://github.com/kubernetes/kubernetes/pull/124123), [@sttts](https://github.com/sttts))
- Ensured daemonset controller counts old unhealthy pods towards max unavailable budget. ([#123233](https://github.com/kubernetes/kubernetes/pull/123233), [@marshallbrekka](https://github.com/marshallbrekka))
- Fix a bug that when PodTopologySpread rejects Pods, they may be stuck in Pending state for 5 min in a worst case scenario.
  The same problem could happen with custom plugins which have Pod/Add or Pod/Update in EventsToRegister,
  which is also solved with this PR, but only when the feature flag SchedulerQueueingHints is enabled. ([#122627](https://github.com/kubernetes/kubernetes/pull/122627), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling and Testing]
- Fix bug where Server Side Apply causing spurious resourceVersion bumps on no-op patches containing empty maps. ([#125317](https://github.com/kubernetes/kubernetes/pull/125317), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery and Testing]
- Fix endpoints status out-of-sync when the pod state changes rapidly ([#125675](https://github.com/kubernetes/kubernetes/pull/125675), [@tnqn](https://github.com/tnqn)) [SIG Apps, Network and Testing]
- Fix the bug where PodIP field is temporarily removed for a terminal pod ([#125404](https://github.com/kubernetes/kubernetes/pull/125404), [@mimowo](https://github.com/mimowo)) [SIG Node and Testing]
- Fixed "-kube-test-repo-list" e2e flag may not take effect. ([#123587](https://github.com/kubernetes/kubernetes/pull/123587), [@huww98](https://github.com/huww98)) [SIG API Machinery, Apps, Autoscaling, CLI, Network, Node, Scheduling, Storage, Testing and Windows]
- Fixed EDITOR/KUBE_EDITOR with double-quoted paths with spaces when on Windows cmd.exe. ([#112104](https://github.com/kubernetes/kubernetes/pull/112104), [@oldium](https://github.com/oldium)) [SIG CLI and Windows]
- Fixed a bug in storage-version-migrator-controller that would cause migration attempts to fail if resources were deleted when the migration was in progress. ([#126107](https://github.com/kubernetes/kubernetes/pull/126107), [@enj](https://github.com/enj)) [SIG API Machinery, Apps, Auth and Testing]
- Fixed a bug in the JSON frame reader that could cause it to retain a reference to the underlying array of the byte slice passed to read. ([#123620](https://github.com/kubernetes/kubernetes/pull/123620), [@benluddy](https://github.com/benluddy))
- Fixed a bug in the scheduler where it would crash when prefilter returns a non-existent node. ([#124933](https://github.com/kubernetes/kubernetes/pull/124933), [@AxeZhan](https://github.com/AxeZhan)) [SIG Scheduling and Testing]
- Fixed a bug that Pods could stuck in the unschedulable pod pool 
  if they're rejected by PreEnqueue plugins that could change its result by a change in resources apart from Pods.
  
  DRA plugin is the only plugin that meets the criteria of the bug in in-tree, 
  and hence if you have `DynamicResourceAllocation` feature flag enabled, 
  your DRA Pods could be affected by this bug. ([#125527](https://github.com/kubernetes/kubernetes/pull/125527), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling and Testing]
- Fixed a bug that init containers with `Always` restartPolicy may not terminate gracefully if the pod hasn't initialized yet. ([#125935](https://github.com/kubernetes/kubernetes/pull/125935), [@gjkim42](https://github.com/gjkim42)) [SIG Node and Testing]
- Fixed a bug where `kubectl describe` incorrectly displayed NetworkPolicy port ranges
  (showing only the starting port). ([#123316](https://github.com/kubernetes/kubernetes/pull/123316), [@jcaamano](https://github.com/jcaamano))
- Fixed a bug where hard evictions due to resource pressure allowed pods
  to use the full termination grace period instead of shutting down instantly. 
  This bug also affected force deleted pods. Both cases now receive a termination grace period of 1 second. ([#124063](https://github.com/kubernetes/kubernetes/pull/124063), [@olyazavr](https://github.com/olyazavr))
- Fixed a bug where the Kubelet didn't calculate the process usage of pods correctly, leading to pods never getting evicted for PID use. ([#124101](https://github.com/kubernetes/kubernetes/pull/124101), [@haircommander](https://github.com/haircommander)) [SIG Node and Testing]
- Fixed a missing status prefix in custom resource validation error messages. ([#123822](https://github.com/kubernetes/kubernetes/pull/123822), [@JoelSpeed](https://github.com/JoelSpeed))
- Fixed a race condition in kube-controller-manager and the scheduler, caused by
  a bug in the transforming informer during the Resync operation, 
  by making the transforming function idempotent. ([#124352](https://github.com/kubernetes/kubernetes/pull/124352), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Scheduling]
- Fixed a race condition in the transforming informer that occurred when objects were accessed during the Resync operation. ([#124344](https://github.com/kubernetes/kubernetes/pull/124344), [@wojtek-t](https://github.com/wojtek-t))
- Fixed a regression where `kubelet --hostname-override` no longer worked
  correctly with an external cloud provider. ([#124516](https://github.com/kubernetes/kubernetes/pull/124516), [@danwinship](https://github.com/danwinship))
- Fixed an issue that prevents the linking of trace spans for requests that are proxied through kube-aggregator. ([#124189](https://github.com/kubernetes/kubernetes/pull/124189), [@toddtreece](https://github.com/toddtreece))
- Fixed an issue where kubelet on Windows would fail if a pod had a SecurityContext with `RunAsUser`. ([#125040](https://github.com/kubernetes/kubernetes/pull/125040), [@carlory](https://github.com/carlory)) [SIG Storage, Testing and Windows]
- Fixed an issue where the Service LoadBalancer controller was not correctly considering the `service.Status new IPMode` field and excluding the Ports when checking if the status was changed, resulting in the changed field potentially not to update the `service.Status` correctly. ([#125225](https://github.com/kubernetes/kubernetes/pull/125225), [@aojea](https://github.com/aojea)) [SIG Apps, Cloud Provider and Network]
- Fixed bug where Server Side Apply causes spurious resourceVersion bumps on no-op patches to custom resources. ([#125263](https://github.com/kubernetes/kubernetes/pull/125263), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery and Testing]
- Fixed bug where kubectl get with --sort-by flag does not sort strings alphanumerically. ([#124514](https://github.com/kubernetes/kubernetes/pull/124514), [@brianpursley](https://github.com/brianpursley))
- Fixed fake clientset ApplyScale subresource from 'status' to 'scale'. ([#126073](https://github.com/kubernetes/kubernetes/pull/126073), [@a7i](https://github.com/a7i))
- Fixed kubelet so it would no longer crash when a DRA(Dynamic Resource Allocation) driver returns a nil as part of the Node(Un)PrepareResources response instead of an empty struct (Did not affect drivers written in Go, first showed up with a driver written in Rust). returns a nil as part of the Node(Un)PrepareResources response instead of an empty struct (did not affect drivers written in Go, first showed up with a driver written in Rust). ([#124091](https://github.com/kubernetes/kubernetes/pull/124091), [@bitoku](https://github.com/bitoku))
- Fixed node report notReady with reason 'container runtime status check may not have completed yet' after kubelet restart. ([#124430](https://github.com/kubernetes/kubernetes/pull/124430), [@AllenXu93](https://github.com/AllenXu93))
- Fixed null `lastTransitionTime` in Pod condition when setting the scheduling gate. ([#122636](https://github.com/kubernetes/kubernetes/pull/122636), [@lianghao208](https://github.com/lianghao208)) [SIG Node and Scheduling]
- Fixed recursive LIST from watch cache returning object matching key. ([#125584](https://github.com/kubernetes/kubernetes/pull/125584), [@serathius](https://github.com/serathius)) [SIG API Machinery and Testing]
- Fixed sample-cli-plugin help text to be consistent and always use `kubectl ns`. ([#125641](https://github.com/kubernetes/kubernetes/pull/125641), [@nirs](https://github.com/nirs))
- Fixed the bug where if Endpointslices mirrored from Endpoints by the EndpointSliceMirroring controller they would not reconcile if modified. were not reconciled if modified ([#124131](https://github.com/kubernetes/kubernetes/pull/124131), [@zyjhtangtang](https://github.com/zyjhtangtang)) [SIG Apps and Network]
- Fixed the format of the error indicating that a user does not have permission on the object referenced by paramRef in ValidatingAdmissionPolicyBinding. ([#124653](https://github.com/kubernetes/kubernetes/pull/124653), [@m1kola](https://github.com/m1kola))
- Fixed throughput when scheduling DaemonSet pods to reach 300 pods/s, if the configured QPS allows it. ([#124714](https://github.com/kubernetes/kubernetes/pull/124714), [@sanposhiho](https://github.com/sanposhiho))
- Fixed: during the kube-controller-manager restart, when the corresponding Endpoints resource was manually deleted and recreated, causing the endpointslice to fail to be created normally. ([#125359](https://github.com/kubernetes/kubernetes/pull/125359), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Apps and Network]
- For statically provisioned PVs, if its volume source is CSI type or it has migrated annotation, when it's deleted, the PersisentVolume controller won't changes its phase to the Failed state. 
  
  With this patch, the external provisioner can remove the finalizer in next reconcile loop. Unfortunately if the provious existing pv has the Failed state, this patch won't take effort. It requires users to remove finalizer. ([#125767](https://github.com/kubernetes/kubernetes/pull/125767), [@carlory](https://github.com/carlory)) [SIG Apps and Storage]
- Improved scheduling latency when there are many gated pods and events that trigger requeueing from the unschedulable pool. ([#124618](https://github.com/kubernetes/kubernetes/pull/124618), [@gabesaba](https://github.com/gabesaba)) [SIG Scheduling and Testing]
- Kube-apiserver: fixed a 1.27+ regression watching a single namespace via the deprecated /api/v1/watch/namespaces/$name endpoint where watch events were not delivered after the watch was established. ([#125145](https://github.com/kubernetes/kubernetes/pull/125145), [@xyz-li](https://github.com/xyz-li)) [SIG API Machinery, Node and Testing]
- Kube-apiserver: fixed a 1.28 regression printing pods with invalid initContainer status. ([#124906](https://github.com/kubernetes/kubernetes/pull/124906), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: fixed a potential crash serving CustomResourceDefinitions that combine an invalid schema and CEL validation rules. ([#126167](https://github.com/kubernetes/kubernetes/pull/126167), [@cici37](https://github.com/cici37)) [SIG API Machinery and Testing]
- Kube-apiserver: timeouts configured for authorization webhooks in the --authorization-config file are now honored, and webhook timeouts are accurately reflected in webhook metrics with result=timeout ([#125552](https://github.com/kubernetes/kubernetes/pull/125552), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth and Testing]
- Kubeadm: Added `--yes` flag to the list of allowed flags so that it can be mixed with `kubeadm upgrade apply --config`. ([#125566](https://github.com/kubernetes/kubernetes/pull/125566), [@xmudrii](https://github.com/xmudrii))
- Kubeadm: Added support during the preflight check "CreateJob" of "kubeadm upgrade" to check if there are no nodes where a Pod can be scheduled. If there are none, show a warning and skip this preflight check. This can happen in single node clusters where the only node was drained. ([#124503](https://github.com/kubernetes/kubernetes/pull/124503), [@neolit123](https://github.com/neolit123))
- Kubeadm: Fixed a bug where the PublicKeysECDSA feature gate was not respected when generating kubeconfig files. ([#125388](https://github.com/kubernetes/kubernetes/pull/125388), [@neolit123](https://github.com/neolit123))
- Kubeadm: Fixed a regression where the JoinConfiguration.discovery.timeout was no longer respected and the value was always hardcoded to "5m" (5 minutes). ([#125480](https://github.com/kubernetes/kubernetes/pull/125480), [@neolit123](https://github.com/neolit123))
- Kubeadm: Removed support for mounting /etc/pki as an additional Linux system CA location
  in kube-apisever and kube-controller-manager pods. Instead, it shifted to supporting the
  mounting of /etc/pki/ca-trust and /etc/pki/tls/certs. The locations /etc/ca-certificate,
  /usr/share/ca-certificates, /usr/local/share/ca-certificates, and /etc/ssl/certs continued
  to be supported. ([#124361](https://github.com/kubernetes/kubernetes/pull/124361), [@neolit123](https://github.com/neolit123))
- Kubeadm: The healthz address:port configured in the KubeletConfiguration was used during kubelet health checks, instead of hardcoding localhost:10248. ([#125265](https://github.com/kubernetes/kubernetes/pull/125265), [@neolit123](https://github.com/neolit123))
- Kubeadm: during the validation of existing kubeconfig files on disk, handle cases where the "ca.crt" is a bundle and has intermediate certificates. Find a common trust anchor between the "ca.crt" bundle and the CA in the existing kubeconfig on disk instead of treating "ca.crt" as a file containing a single CA. ([#123102](https://github.com/kubernetes/kubernetes/pull/123102), [@astundzia](https://github.com/astundzia))
- Kubeadm: fixed a bug on 'kubeadm join' where using patches with a kubeletconfiguration target was not respected when performing the local kubelet healthz check. ([#126224](https://github.com/kubernetes/kubernetes/pull/126224), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fixed a bug where the path of the manifest can not be specified when `kubeadm upgrade diff` specified a config file, and the `--api-server-manifest`, `--controller-manager-manifest` and `--scheduler-manifest` flags of `kubeadm upgrade diff` are marked as deprecated and will be removed in a future release. ([#125779](https://github.com/kubernetes/kubernetes/pull/125779), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: the `--feature-gates` flag is deprecated and no-op for `kubeadm upgrade apply/plan`, and it will be removed in a future release. The upgrade workflow is not designed to reconfigure the cluster. Please edit the 'featureGates' field of ClusterConfiguration which is defined in the kube-system/kubeadm-config ConfigMap instead. ([#125797](https://github.com/kubernetes/kubernetes/pull/125797), [@SataQiu](https://github.com/SataQiu))
- Kubectl: Show the Pod phase in the STATUS column as 'Failed' or 'Succeeded' when the Pod is terminated ([#122038](https://github.com/kubernetes/kubernetes/pull/122038), [@lowang-bh](https://github.com/lowang-bh))
- Kubelet now hard rejects pods with AppArmor if the node does not have AppArmor. ([#125776](https://github.com/kubernetes/kubernetes/pull/125776), [@vinayakankugoyal](https://github.com/vinayakankugoyal))
- Mount-utils: treated syscall.ENODEV as corrupted mount. ([#126174](https://github.com/kubernetes/kubernetes/pull/126174), [@dobsonj](https://github.com/dobsonj))
- Now the .status.ready field is tracked faster when active Pods are deleted, specifically when Job is failed, gets suspended or has too many active pods. ([#125546](https://github.com/kubernetes/kubernetes/pull/125546), [@dejanzele](https://github.com/dejanzele))
- Removed admission plugin `PersistentVolumeLabel`. Please use https://github.com/kubernetes-sigs/cloud-pv-admission-labeler instead if you need a similar functionality. ([#124505](https://github.com/kubernetes/kubernetes/pull/124505), [@jsafrane](https://github.com/jsafrane)) [SIG API Machinery, Auth and Storage]
- Reverted `Graduates the `WatchList` feature gate to Beta for kube-apiserver and enables `WatchListClient` for kube-controller-manager (KCM)`. ([#126191](https://github.com/kubernetes/kubernetes/pull/126191), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery and Testing]
- Set ProcMountType feature to disabled by default, to follow the lead of UserNamespacesSupport (which it relies on). ([#126291](https://github.com/kubernetes/kubernetes/pull/126291), [@haircommander](https://github.com/haircommander)) [SIG Node]
- StatefulSet autodelete respected controlling owners on PVC claims as described in https://github.com/kubernetes/enhancements/pull/4375. ([#122499](https://github.com/kubernetes/kubernetes/pull/122499), [@mattcary](https://github.com/mattcary)) [SIG Apps and Testing]
- Stopped using wmic on Windows to get uuid in the kubelet. ([#126012](https://github.com/kubernetes/kubernetes/pull/126012), [@marosset](https://github.com/marosset)) [SIG Node and Windows]
- The "fake" clients generated by `client-gen` now have the same semantics on
  error as the real clients; in particular, a failed Get(), Create(), etc, no longer
  returns `nil`. (It now returns a pointer to a zero-valued object, like the real
  clients do.) This will break some downstream unit tests that were testing
  `result == nil` rather than `err != nil`, and in some cases may expose bugs
  in the underlying code that were hidden by the incorrect unit tests. ([#122892](https://github.com/kubernetes/kubernetes/pull/122892), [@danwinship](https://github.com/danwinship)) [SIG API Machinery, Auth, Cloud Provider, Instrumentation and Storage]
- The emission of RecreatingFailedPod and RecreatingTerminatedPod events has been
  removed from the StatefulSet lifecycle. ([#123809](https://github.com/kubernetes/kubernetes/pull/123809), [@atiratree](https://github.com/atiratree)) [SIG Apps and Testing]
- The scheduler retries scheduling Pods rejected by PreFilterResult (PreFilter plugins) more appropriately; it now takes events registered in those rejector PreFilter plugins into consideration. ([#122251](https://github.com/kubernetes/kubernetes/pull/122251), [@olderTaoist](https://github.com/olderTaoist)) [SIG Scheduling and Testing]
- Updated description of default values for `--healthz-bind-address` and `--metrics-bind-address` parameters. ([#123545](https://github.com/kubernetes/kubernetes/pull/123545), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- When schedulingQueueHint is enabled, the scheduling queue doesn't update Pods being scheduled immediately. ([#125578](https://github.com/kubernetes/kubernetes/pull/125578), [@nayihz](https://github.com/nayihz))
- `Job`: Fixed a bug where `SuccessCriteriaMet` could be added to the Job with
  `successPolicy` regardless of the `featureGate` being enabled. ([#125429](https://github.com/kubernetes/kubernetes/pull/125429), [@tenzen-y](https://github.com/tenzen-y))
- ```
  
  #### Additional documentation e.g., KEPs (Kubernetes Enhancement Proposals), usage docs, etc.: ([#125272](https://github.com/kubernetes/kubernetes/pull/125272), [@mauri870](https://github.com/mauri870))
- `kubeadm`: Allowed the `kubeadm init phase certs sa` command to accept the `--config` flag. ([#125396](https://github.com/kubernetes/kubernetes/pull/125396), [@Kavinraja-G](https://github.com/Kavinraja-G))
- `kubeadm`: Improved the `IsPrivilegedUser` preflight check to not fail on certain Windows setups. ([#124665](https://github.com/kubernetes/kubernetes/pull/124665), [@neolit123](https://github.com/neolit123))
- `lastSuccessfullTime` in cronjobs will now be set reliably. ([#122025](https://github.com/kubernetes/kubernetes/pull/122025), [@lukashankeln](https://github.com/lukashankeln))

### Other (Cleanup or Flake)

- "Removed the ability to run `kubectl exec [POD] [COMMAND]` without a `--` separator.
  The `--` separator has been recommended since the Kubernetes v1.18 release, which also deprecated the legacy way of invoking `kubectl exec`.
  
  This change aligns with the deprecation of legacy `kubectl exec` command execution and enforces the use of `kubectl exec [POD] -- [COMMAND]` for improved compatibility and adherence to recommended practices."
   ([#125437](https://github.com/kubernetes/kubernetes/pull/125437), [@ardaguclu](https://github.com/ardaguclu)) [SIG CLI and Testing]
- "`kubectl describe service`" and "`kubectl describe ingress`" will now use endpointslices instead of endpoints.
   ([#124598](https://github.com/kubernetes/kubernetes/pull/124598), [@aroradaman](https://github.com/aroradaman)) [SIG CLI and Network]
- ACTION-REQUIRED: Dynamic Resource Allocation (DRA) drivers using the v1alpha2 kubelet gRPC API are no longer supported and need to be updated. ([#124316](https://github.com/kubernetes/kubernetes/pull/124316), [@pohly](https://github.com/pohly)) [SIG Node and Testing]
- API Priority and Fairness feature was promoted to GA in 1.29, the corresponding 
  feature gate 'APIPriorityAndFairness' has been removed in 1.31. ([#125846](https://github.com/kubernetes/kubernetes/pull/125846), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Added a testcase to check hostname and hostNetwork. ([#124428](https://github.com/kubernetes/kubernetes/pull/124428), [@yashsingh74](https://github.com/yashsingh74)) [SIG Architecture, Network and Testing]
- Built etcd image v3.5.13. ([#124026](https://github.com/kubernetes/kubernetes/pull/124026), [@liangyuanpeng](https://github.com/liangyuanpeng)) [SIG API Machinery and Etcd]
- Built etcd image v3.5.14. ([#125235](https://github.com/kubernetes/kubernetes/pull/125235), [@humblec](https://github.com/humblec))
- Built kubernetes with `Go 1.22.5`. ([#126330](https://github.com/kubernetes/kubernetes/pull/126330), [@ArkaSaha30](https://github.com/ArkaSaha30)) [SIG Release and Testing]
- Cleaned deprecated context.StopCh in favor of ctx. ([#125661](https://github.com/kubernetes/kubernetes/pull/125661), [@mjudeikis](https://github.com/mjudeikis))
- Container Storage Interface (CSI) spec support has been lifted to v1.9.0 in this release. ([#125150](https://github.com/kubernetes/kubernetes/pull/125150), [@humblec](https://github.com/humblec)) [SIG Storage and Testing]
- Drop support for the deprecated and unsupported kubectl run flags:
  - filename
  - force
  - grace-period
  - kustomize
  - recursive
  - timeout
  - wait
  
  Drop support for the deprecated --delete-local-data from kubectl drain, users should use --delete-emptydir-data, instead. ([#125842](https://github.com/kubernetes/kubernetes/pull/125842), [@soltysh](https://github.com/soltysh)) [SIG CLI]
- Dynamic Resource Allocation (DRA): fixed some small, unlikely race condition during pod scheduling. ([#124595](https://github.com/kubernetes/kubernetes/pull/124595), [@pohly](https://github.com/pohly)) [SIG Node, Scheduling and Testing]
- E2e.test and e2e_node.test: tests which depend on alpha or beta feature gates now have `Feature:Alpha` or `Feature:Beta` as Ginkgo labels. The inline text is `[Alpha]` or `[Beta]`, as before. ([#124350](https://github.com/kubernetes/kubernetes/pull/124350), [@pohly](https://github.com/pohly))
- Ensured that the Node Admission plugin to reject CSR requests created by a node identity for the signers `kubernetes.io/kubelet-serving` or `kubernetes.io/kube-apiserver-client-kubelet` with a CN starting with `system:node:`, but where the CN is not `system:node:${node-name}`. The feature gate `AllowInsecureKubeletCertificateSigningRequests` defaults to `false`, but can be enabled to revert to the previous behavior. This feature gate will be removed in Kubernetes v1.33. ([#126441](https://github.com/kubernetes/kubernetes/pull/126441), [@micahhausler](https://github.com/micahhausler))
- Etcd: Updated to v3.5.13. ([#124027](https://github.com/kubernetes/kubernetes/pull/124027), [@liangyuanpeng](https://github.com/liangyuanpeng)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle, Etcd and Testing]
- Exposed the `apiserver_watch_cache_resource_version` metric to simplify debugging problems with watchcache. ([#125377](https://github.com/kubernetes/kubernetes/pull/125377), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Instrumentation]
- Exposed the kube-scheduler "/livez" and "/readz" endpoints for health checks that are in compliance with https://kubernetes.io/docs/reference/using-api/health-checks/#api-endpoints-for-health. ([#118148](https://github.com/kubernetes/kubernetes/pull/118148), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery, Scheduling and Testing]
- Finished initial generic controlplane refactor of kube-apiserver, providing a sample binariy building a kube-like controlplane without contrainer orchestration resources. ([#124530](https://github.com/kubernetes/kubernetes/pull/124530), [@sttts](https://github.com/sttts)) [SIG API Machinery, Apps, Cloud Provider, Network, Node and Testing]
- Fixed a typo in the help text for the pod_scheduling_sli_duration_seconds metric in kube-scheduler. ([#124221](https://github.com/kubernetes/kubernetes/pull/124221), [@arturhoo](https://github.com/arturhoo)) [SIG Instrumentation, Scheduling and Testing]
- Improved the documentation clarity for building Kubernetes in Docker Environment, making it more understandable for new users and contributors. ([#125536](https://github.com/kubernetes/kubernetes/pull/125536), [@this-is-yaash](https://github.com/this-is-yaash))
- Job-controller: the `JobReadyPods` feature flag has been removed (deprecated since v1.31). ([#125168](https://github.com/kubernetes/kubernetes/pull/125168), [@kaisoz](https://github.com/kaisoz))
- Kube-apiserver: the `--enable-logs-handler` flag and log-serving functionality which was already deprecated is now switched off by default and scheduled to be removed in v1.33. ([#125787](https://github.com/kubernetes/kubernetes/pull/125787), [@dims](https://github.com/dims)) [SIG API Machinery, Network and Testing]
- Kubeadm: Removed the deprecated `UpgradeAddonsBeforeControlPlane` feature gate; Ensured that the upgrade of the CoreDNS and kube-proxy addons would not be triggered until all the control plane instances were upgraded. ([#124715](https://github.com/kubernetes/kubernetes/pull/124715), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: Strictly enabled only the supported klog flags, disallowing previously available but unrecommended options. This means that hidden flags about klog (including `--alsologtostderr`, `--log-backtrace-at`, `--log-dir`, `--logtostderr`, `--log-file`, `--log-file-max-size`, `--one-output`, `--skip-log-headers`, `--stderrthreshold` and `--vmodule`) are no longer allowed to be used. ([#125179](https://github.com/kubernetes/kubernetes/pull/125179), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: The global --rootfs flag considered non-experimental. ([#124375](https://github.com/kubernetes/kubernetes/pull/124375), [@neolit123](https://github.com/neolit123))
- Kubeadm: improved the warning/error messages of `validateSupportedVersion` to include the checked resource kind name. ([#125758](https://github.com/kubernetes/kubernetes/pull/125758), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: removed the EXPERIMENTAL tag from the phase "kubeadm join control-plane-prepare download-certs". ([#124374](https://github.com/kubernetes/kubernetes/pull/124374), [@neolit123](https://github.com/neolit123))
- Kubeadm: removed the deprecated `output.kubeadm.k8s.io/v1alpha2` API for structured output. Please use v1alpha3 instead. ([#124496](https://github.com/kubernetes/kubernetes/pull/124496), [@carlory](https://github.com/carlory))
- Kubeadm: removed the deprecated and NO-OP "kubeadm join control-plane-join update-status" phase. ([#124373](https://github.com/kubernetes/kubernetes/pull/124373), [@neolit123](https://github.com/neolit123))
- Kubelet is no longer able to recover from device manager state file older than 1.20. If the proper recommended upgrade flow is followed, there should be no issue. ([#123398](https://github.com/kubernetes/kubernetes/pull/123398), [@ffromani](https://github.com/ffromani)) [SIG Node and Testing]
- Migrated the pkg/proxy to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#122979](https://github.com/kubernetes/kubernetes/pull/122979), [@fatsheep9146](https://github.com/fatsheep9146)) [SIG Network and Scalability]
- Moved remote CRI implementation from kubelet to `k8s.io/cri-client` repository. ([#124634](https://github.com/kubernetes/kubernetes/pull/124634), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node, Release and Testing]
- Optimized log output to avoid printing out redundant information of the pod. ([#124055](https://github.com/kubernetes/kubernetes/pull/124055), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Removed GA ServiceNodePortStaticSubrange feature gate. ([#124738](https://github.com/kubernetes/kubernetes/pull/124738), [@xuzhenglun](https://github.com/xuzhenglun))
- Removed Kubelet flags `--iptables-masquerade-bit` and `--iptables-drop-bit` as they were deprecated in v1.28. in v1.28 and have now been removed entirely. ([#122363](https://github.com/kubernetes/kubernetes/pull/122363), [@carlory](https://github.com/carlory)) [SIG Network and Node]
- Removed `ENABLE_CLIENT_GO_WATCH_LIST_ALPHA` environment variable from the reflector.
  To activate the feature set `KUBE_FEATURE_WatchListClient` environment variable or a corresponding command line option (this works only with binaries that explicitly expose it). ([#122791](https://github.com/kubernetes/kubernetes/pull/122791), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery and Testing]
- Removed generally available feature gate `CSINodeExpandSecret`. ([#124462](https://github.com/kubernetes/kubernetes/pull/124462), [@carlory](https://github.com/carlory))
- Removed generally available feature gate `ConsistentHTTPGetHandlers`. ([#124463](https://github.com/kubernetes/kubernetes/pull/124463), [@carlory](https://github.com/carlory))
- Removed generally available feature gate `ReadWriteOncePod`. ([#124329](https://github.com/kubernetes/kubernetes/pull/124329), [@chrishenzie](https://github.com/chrishenzie))
- Removed the following feature gates:
  - `InTreePluginAWSUnregister`
  - `InTreePluginAzureDiskUnregister`
  - `InTreePluginAzureFileUnregister`
  - `InTreePluginGCEUnregister`
  - `InTreePluginOpenStackUnregister`
  - `InTreePluginvSphereUnregister` ([#124815](https://github.com/kubernetes/kubernetes/pull/124815), [@carlory](https://github.com/carlory)) [SIG Storage]
- Removed the last remaining in-tree gcp cloud provider and credential provider.
  Please use the external cloud provider and credential provider from https://github.com/kubernetes/cloud-provider-gcp
  instead. ([#124519](https://github.com/kubernetes/kubernetes/pull/124519), [@dims](https://github.com/dims)) [SIG API Machinery, Apps, Auth, Autoscaling, Cloud Provider, Instrumentation, Network, Node, Scheduling, Storage and Testing]
- Scheduler framework: Allowed PreBind implementations to return Pending and Unschedulable status codes. ([#125360](https://github.com/kubernetes/kubernetes/pull/125360), [@pohly](https://github.com/pohly))
- Set LocalStorageCapacityIsolationFSQuotaMonitoring to false by default, to match UserNamespacesSupport (which the feature relies on). ([#126355](https://github.com/kubernetes/kubernetes/pull/126355), [@haircommander](https://github.com/haircommander))
- The ValidatingAdmissionPolicy metrics have been redone to count and time all validations, including failures and admissions. ([#126124](https://github.com/kubernetes/kubernetes/pull/126124), [@cici37](https://github.com/cici37)) [SIG API Machinery and Instrumentation]
- The feature gate "DefaultHostNetworkHostPortsInPodTemplates" has been removed.  This behavior was deprecated in v1.28, and has had no reports of issues since. ([#124417](https://github.com/kubernetes/kubernetes/pull/124417), [@thockin](https://github.com/thockin))
- The feature gate "SkipReadOnlyValidationGCE" has been removed.  This gate has been active for 2 releases with no reports of issues (and was such a niche thing, we didn't expect any). ([#124210](https://github.com/kubernetes/kubernetes/pull/124210), [@thockin](https://github.com/thockin))
- Updated CNI Plugins to v1.5.0. ([#125113](https://github.com/kubernetes/kubernetes/pull/125113), [@bzsuni](https://github.com/bzsuni)) [SIG Cloud Provider, Network, Node and Testing]
- Updated cni-plugins to v1.4.1. ([#123894](https://github.com/kubernetes/kubernetes/pull/123894), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Node and Testing]
- Updated cri-tools to v1.30.0. ([#124364](https://github.com/kubernetes/kubernetes/pull/124364), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Node and Release]
- `kubeadm`: The `NodeSwap` check that kubeadm performs during preflight, has a new warning to verify if swap has been configured correctly. ([#125157](https://github.com/kubernetes/kubernetes/pull/125157), [@carlory](https://github.com/carlory))
- `kubectl describe service` now shows internal traffic policy and ip mode of load balancer IP. ([#125117](https://github.com/kubernetes/kubernetes/pull/125117), [@tnqn](https://github.com/tnqn)) [SIG CLI and Network]