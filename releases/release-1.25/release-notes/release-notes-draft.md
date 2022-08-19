## What's New (Major Themes)

### PodSecurityPolicy is Removed, Pod Security Admission graduates to Stable

PodSecurityPolicy was initially [deprecated in v1.21](/blog/2021/04/06/podsecuritypolicy-deprecation-past-present-and-future/), and with the release of v1.25, it has been removed. The updates required to improve its usability would have introduced breaking changes, so it became necessary to remove it in favor of a more friendly replacement. That replacement is [Pod Security Admission](/docs/concepts/security/pod-security-admission/), which graduates to Stable with this release. If you are currently relying on PodSecurityPolicy, please follow the instructions for [migration to Pod Security Admission](/docs/tasks/configure-pod-container/migrate-from-psp/).

### Ephemeral Containers Graduate to Stable

[Ephemeral Containers](/docs/concepts/workloads/pods/ephemeral-containers/) are containers that exist for only a limited time within an existing pod. This is particularly useful for troubleshooting when you need to examine another container but cannot use `kubectl exec` because that container has crashed or its image lacks debugging utilities. Ephemeral containers graduated to Beta in Kubernetes v1.23, and with this release, the feature graduates to Stable.

### Support for cgroups v2 Graduates to Stable

It has been more than two years since the Linux kernel cgroups v2 API was declared stable. With some distributions now defaulting to this API, Kubernetes must support it to continue operating on those distributions. cgroups v2 offers several improvements over cgroups v1, for more information see the [cgroups v2](https://kubernetes.io/docs/concepts/architecture/cgroups/) documentation. While cgroups v1 will continue to be supported, this enhancement puts Kubernetes to be ready for eventual deprecation and replacement in favor of v2.


### Windows support improved

- [Performance dashboards](http://perf-dash.k8s.io/#/?jobname=soak-tests-capz-windows-2019) added support for Windows
- [Unit tests](https://github.com/kubernetes/kubernetes/issues/51540) added support for Windows
- [Conformance tests](https://github.com/kubernetes/kubernetes/pull/108592) added support for Windows
- New repository created for [Windows Operational Readiness](https://github.com/kubernetes-sigs/windows-operational-readiness)

### Moved container registry service from k8s.gcr.io to registry.k8s.io

[Moving container registry from k8s.gcr.io to registry.k8s.io](https://github.com/kubernetes/kubernetes/pull/109938) got merged. For more details, see the [wiki page](https://github.com/kubernetes/k8s.io/wiki/New-Registry-url-for-Kubernetes-\(registry.k8s.io\)), [announcement](https://groups.google.com/a/kubernetes.io/g/dev/c/DYZYNQ_A6_c/m/oD9_Q8Q9AAAJ) was sent to the kubernetes development mailing list.

### Promoted SeccompDefault to Beta

SeccompDefault promoted to beta, see the tutorial [Restrict a Container's Syscalls with seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/#enable-the-use-of-runtimedefault-as-the-default-seccomp-profile-for-all-workloads) for more details.

### Promoted endPort in Network Policy to Stable

Promoted `endPort` in [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/#targeting-a-range-of-ports) to GA. Network Policy providers that support `endPort` field now can use it to specify a range of ports to apply a Network Policy. Previously, each Network Policy could only target a single port.

Please be aware that `endPort` field **MUST BE SUPPORTED** by the Network Policy provider. If your provider does not support `endPort`, and this field is specified in a Network Policy, the Network Policy will be created covering only the port field (single port).

### Promoted Local Ephemeral Storage Capacity Isolation to Stable
The [Local Ephemeral Storage Capacity Isolation](https://github.com/kubernetes/enhancements/tree/master/keps/sig-storage/361-local-ephemeral-storage-isolation) feature moved to GA. This was introduced as alpha in 1.8, moved to beta in 1.10, and it is now a stable feature. It provides support for capacity isolation of local ephemeral storage between pods, such as `EmptyDir`, so that a pod can be hard limited in its consumption of shared resources by evicting Pods if its consumption of local ephemeral storage exceeds that limit.

### Promoted core CSI Migration to Stable

[CSI Migration](https://kubernetes.io/blog/2021/12/10/storage-in-tree-to-csi-migration-status-update/#quick-recap-what-is-csi-migration-and-why-migrate) is an ongoing effort that SIG Storage has been working on for a few releases. The goal is to move in-tree volume plugins to out-of-tree CSI drivers and eventually remove the in-tree volume plugins. The [core CSI Migration](https://github.com/kubernetes/enhancements/tree/master/keps/sig-storage/625-csi-migration) feature moved to GA. CSI Migration for GCE PD and AWS EBS also moved to GA. CSI Migration for vSphere remains in beta (but is on by default). CSI Migration for Portworx moved to Beta (but is off-by-default).


### Promoted CSI Ephemeral Volume to Stable

The [CSI Ephemeral Volume](https://github.com/kubernetes/enhancements/tree/master/keps/sig-storage/596-csi-inline-volumes) feature allows CSI volumes to be specified directly in the pod specification for ephemeral use cases. They can be used to inject arbitrary states, such as configuration, secrets, identity, variables or similar information, directly inside pods using a mounted volume. This was initially introduced in 1.15 as an alpha feature, and it moved to GA. This feature is used by some CSI drivers such as the [secret-store CSI driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver).

### Promoted CRD Validation Expression Language to Beta

[CRD Validation Expression Language](https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/2876-crd-validation-expression-language/README.mdv) is promoted to beta, which makes it possible to declare how custom resources are validated using the [Common Expression Language (CEL)](https://github.com/google/cel-spec). Please see the [validation rules](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/#validation-rules) guide.

### Promoted Server Side Unknown Field Validation to Beta

Promoted the `ServerSideFieldValidation` feature gate to beta (on by default). This allows optionally triggering schema validation on the API server that errors when unknown fields are detected. This allows the removal of client-side validation from kubectl while maintaining the same core functionality of erroring out on requests that contain unknown or invalid fields.


###  Introduced KMS v2

Introduce KMS v2alpha1 API to add performance, rotation, and observability improvements. Encrypt data at rest (ie Kubernetes `Secrets`) with DEK using AES-GCM instead of AES-CBC for kms data encryption. No user action is required. Reads with AES-GCM and AES-CBC will continue to be allowed. See the guide [Using a KMS provider for data encryption](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) for more information.

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Deprecated beta APIs scheduled for removal in 1.25 are no longer served. See https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25 for more information. ([#108797](https://github.com/kubernetes/kubernetes/pull/108797), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Instrumentation and Testing]
 - Encrypted data with DEK using AES-GCM instead of AES-CBC for kms data encryption. No user action required. Reads with AES-GCM and AES-CBC will continue to be allowed. ([#111119](https://github.com/kubernetes/kubernetes/pull/111119), [@aramase](https://github.com/aramase))
 - End-to-end testing has been migrated from Ginkgo v1 to v2.
  
  When running test/e2e via the Ginkgo CLI, the v2 CLI must be used and `-timeout=24h` (or some other, suitable value) must be passed because the default timeout was reduced from 24h to 1h. When running it via `go test`, the corresponding `-args` parameter is `-ginkgo.timeout=24h`. To build the CLI in the Kubernetes repo, use `make all WHAT=github.com/onsi/ginkgo/v2/ginkgo`.
  Ginkgo V2 doesn't accept go test's `-parallel` flags to parallelize Ginkgo specs, please switch to use `ginkgo -p` or `ginkgo -procs=N` instead. ([#109111](https://github.com/kubernetes/kubernetes/pull/109111), [@chendave](https://github.com/chendave)) [SIG API Machinery, Apps, Architecture, Auth, Autoscaling, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scheduling, Storage, Testing and Windows]
 - No action required; No API/CLI changed; Add new Windows Image Support ([#110333](https://github.com/kubernetes/kubernetes/pull/110333), [@liurupeng](https://github.com/liurupeng)) [SIG Cloud Provider and Windows]
 - The intree volume plugin flocker support was completely removed from Kubernetes. ([#111618](https://github.com/kubernetes/kubernetes/pull/111618), [@Jiawei0227](https://github.com/Jiawei0227))
 - The intree volume plugin quobyte support has been completely removed from Kubernetes. ([#111619](https://github.com/kubernetes/kubernetes/pull/111619), [@Jiawei0227](https://github.com/Jiawei0227))
 - The intree volume plugin storageos support has been completely removed from Kubernetes. ([#111620](https://github.com/kubernetes/kubernetes/pull/111620), [@Jiawei0227](https://github.com/Jiawei0227))
 - There is a new OCI image registry (`registry.k8s.io`) that can be used to pull Kubernetes images. The old registry (`k8s.gcr.io`) will continue to be supported for the foreseeable future, but the new name should perform better because it frontends equivalent mirrors in other clouds.  Please point your clusters to the new registry going forward. \n\nAdmission/Policy integrations that have an allowlist of registries need to include `registry.k8s.io` alongside `k8s.gcr.io`.\nAir-gapped environments and image garbage-collection configurations will need to update to pre-pull and preserve required images under `registry.k8s.io` as well as `k8s.gcr.io`. ([#109938](https://github.com/kubernetes/kubernetes/pull/109938), [@dims](https://github.com/dims))
 
## Changes by Kind

### Deprecation

- API server's deprecated `--service-account-api-audiences` flag was removed.  Use `--api-audiences` instead. ([#108624](https://github.com/kubernetes/kubernetes/pull/108624), [@ialidzhikov](https://github.com/ialidzhikov))
- Ginkgo.Measure has been deprecated in Ginkgo V2, switch to use gomega/gmeasure instead ([#111065](https://github.com/kubernetes/kubernetes/pull/111065), [@chendave](https://github.com/chendave)) [SIG Autoscaling and Testing]
- Kube-controller-manager: Removed flags  `deleting-pods-qps`, `deleting-pods-burst`, and `register-retry-count`. ([#109612](https://github.com/kubernetes/kubernetes/pull/109612), [@pandaamanda](https://github.com/pandaamanda))
- Kubeadm: during "upgrade apply/diff/node", in case the `ClusterConfiguration.imageRepository` stored in the "kubeadm-config" `ConfigMap` contains the legacy "k8s.gcr.io" repository, modify it to the new default "registry.k8s.io". Reflect the change in the in-cluster `ConfigMap` only during "upgrade apply". ([#110343](https://github.com/kubernetes/kubernetes/pull/110343), [@neolit123](https://github.com/neolit123))
- Kubeadm: graduated the kubeadm specific feature gate `UnversionedKubeletConfigMap` to GA and locked it to `true` by default. The kubelet related ConfigMap and RBAC rules are now locked to have a simplified naming `*kubelet-config` instead of the legacy naming `*kubelet-config-x.yy`, where `x.yy` was the version of the control plane. If you have previously used the old naming format with `UnversionedKubeletConfigMap=false`, you must manually copy the config map from `kube-system/kubelet-config-x.yy` to `kube-system/kubelet-config` before upgrading to `v1.25`. ([#110327](https://github.com/kubernetes/kubernetes/pull/110327), [@neolit123](https://github.com/neolit123))
- Kubeadm: stop applying the `node-role.kubernetes.io/master:NoSchedule` taint to control plane nodes for new clusters. Remove the taint from existing control plane nodes during "kubeadm upgrade apply" ([#110095](https://github.com/kubernetes/kubernetes/pull/110095), [@neolit123](https://github.com/neolit123))
- Support for the alpha seccomp annotations `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io`, deprecated since v1.19, was partially removed. Kubelets no longer support the annotations, use of the annotations in static pods is no longer supported, and the seccomp annotations are no longer auto-populated when pods with seccomp fields are created. Auto-population of the seccomp fields from the annotations is planned to be removed in 1.27. Pods  should use the corresponding pod or container `securityContext.seccompProfile` field instead. ([#109819](https://github.com/kubernetes/kubernetes/pull/109819), [@saschagrunert](https://github.com/saschagrunert))
- The `gcp` and `azure` auth plugins have been removed from client-go and kubectl. See https://github.com/Azure/kubelogin and https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke ([#110013](https://github.com/kubernetes/kubernetes/pull/110013), [@enj](https://github.com/enj))
- The beta `PodSecurityPolicy` admission plugin, deprecated since 1.21, is removed. Follow the instructions at https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp/ to migrate to the built-in PodSecurity admission plugin (or to another third-party  policy webhook) prior to upgrading to v1.25. ([#109798](https://github.com/kubernetes/kubernetes/pull/109798), [@liggitt](https://github.com/liggitt))
- VSphere releases less than 7.0u2 are not supported for in-tree vSphere volume  as of Kubernetes v1.25. Please consider upgrading vSphere (both ESXi and vCenter)  to 7.0u2 or above. ([#111255](https://github.com/kubernetes/kubernetes/pull/111255), [@divyenpatel](https://github.com/divyenpatel))
- Windows winkernel kube-proxy no longer supports Windows HNS v1 APIs. ([#110957](https://github.com/kubernetes/kubernetes/pull/110957), [@papagalu](https://github.com/papagalu))

### API Change

- Add `NodeInclusionPolicy` to `TopologySpreadConstraints` in PodSpec. ([#108492](https://github.com/kubernetes/kubernetes/pull/108492), [@kerthcet](https://github.com/kerthcet))
- Added KMS v2alpha1 support. ([#111126](https://github.com/kubernetes/kubernetes/pull/111126), [@aramase](https://github.com/aramase))
- Added a deprecated warning for node beta label usage in PV/SC/RC and CSI Storage Capacity. ([#108554](https://github.com/kubernetes/kubernetes/pull/108554), [@pacoxu](https://github.com/pacoxu))
- Added a new feature gate `CheckpointRestore` to enable support to checkpoint containers. If enabled it is possible to checkpoint a container using the newly kubelet API (/checkpoint/{podNamespace}/{podName}/{containerName}). ([#104907](https://github.com/kubernetes/kubernetes/pull/104907), [@adrianreber](https://github.com/adrianreber)) [SIG Node and Testing]
- Added alpha support for user namespaces in pods phase 1 (KEP 127, feature gate: UserNamespacesStatelessPodsSupport) ([#111090](https://github.com/kubernetes/kubernetes/pull/111090), [@rata](https://github.com/rata))
- As of v1.25, the PodSecurity `restricted` level no longer requires pods that set .spec.os.name="windows" to also set Linux-specific securityContext fields. If a 1.25+ cluster has unsupported [out-of-skew](https://kubernetes.io/releases/version-skew-policy/#kubelet) nodes prior to v1.23 and wants to ensure namespaces enforcing the `restricted` policy continue to require Linux-specific securityContext fields on all pods, ensure a version of the `restricted` prior to v1.25 is selected by labeling the namespace (for example, `pod-security.kubernetes.io/enforce-version: v1.24`) ([#105919](https://github.com/kubernetes/kubernetes/pull/105919), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Changed ownership semantics of PersistentVolume's spec.claimRef from `atomic` to `granular`. ([#110495](https://github.com/kubernetes/kubernetes/pull/110495), [@alexzielenski](https://github.com/alexzielenski))
- Extended ContainerStatus CRI API to allow runtime response with container resource requests and limits that are in effect.
  - UpdateContainerResources CRI API now supports both Linux and Windows. ([#111645](https://github.com/kubernetes/kubernetes/pull/111645), [@vinaykul](https://github.com/vinaykul))
- For v1.25, Kubernetes will be using Golang 1.19, In this PR the version is updated to 1.19rc2 as GA is not yet available. ([#111254](https://github.com/kubernetes/kubernetes/pull/111254), [@dims](https://github.com/dims))
- Introduced NodeIPAM support for multiple ClusterCIDRs ([#2593](https://github.com/kubernetes/enhancements/issues/2593)) as an alpha feature.
  Set feature gate `MultiCIDRRangeAllocator=true`, determines whether the `MultiCIDRRangeAllocator` controller can be used, while the kube-controller-manager flag below will pick the active controller.
  Enabled the `MultiCIDRRangeAllocator` by setting `--cidr-allocator-type=MultiCIDRRangeAllocator` flag in kube-controller-manager. ([#109090](https://github.com/kubernetes/kubernetes/pull/109090), [@sarveshr7](https://github.com/sarveshr7))
- Introduced PodHasNetwork condition for pods. ([#111358](https://github.com/kubernetes/kubernetes/pull/111358), [@ddebroy](https://github.com/ddebroy))
- Introduced support for handling pod failures with respect to the configured pod failure policy rules. ([#111113](https://github.com/kubernetes/kubernetes/pull/111113), [@mimowo](https://github.com/mimowo))
- Introduction of the `DisruptionTarget` pod condition type. Its `reason` field indicates the reason for pod termination:
  - PreemptionByKubeScheduler (Pod preempted by kube-scheduler)
  - DeletionByTaintManager (Pod deleted by taint manager due to NoExecute taint)
  - EvictionByEvictionAPI (Pod evicted by Eviction API)
  - DeletionByPodGC (an orphaned Pod deleted by PodGC) ([#110959](https://github.com/kubernetes/kubernetes/pull/110959), [@mimowo](https://github.com/mimowo))
- Kube-Scheduler ComponentConfig is graduated to GA, `kubescheduler.config.k8s.io/v1` is available now. 
  Plugin `SelectorSpread` is removed in v1. ([#110534](https://github.com/kubernetes/kubernetes/pull/110534), [@kerthcet](https://github.com/kerthcet))
- Local Storage Capacity Isolation feature is GA in 1.25 release. For systems (rootless) that cannot check root file system, please use kubelet config --local-storage-capacity-isolation=false to disable this feature. Once disabled, pod cannot set local ephemeral storage request/limit, and emptyDir sizeLimit niether. ([#111513](https://github.com/kubernetes/kubernetes/pull/111513), [@jingxu97](https://github.com/jingxu97))
- Make PodSpec.Ports' description clearer on how this information is only informational and how it can be incorrect. ([#110564](https://github.com/kubernetes/kubernetes/pull/110564), [@j4m3s-s](https://github.com/j4m3s-s)) [SIG API Machinery, Network and Node]
- On compatible systems, a mounter's Unmount implementation is changed to not return an error when the specified target can be detected as not a mount point. On Linux, the behavior of detecting a mount point depends on `umount` command is validated when the mounter is created. Additionally, mount point checks will be skipped in CleanupMountPoint/CleanupMountWithForce if the mounter's Unmount having the changed behavior of not returning error when target is not a mount point. ([#109676](https://github.com/kubernetes/kubernetes/pull/109676), [@cartermckinnon](https://github.com/cartermckinnon)) [SIG Storage]
- PersistentVolumeClaim objects are no longer left with storage class set to `nil` forever, but will be updated retroactively once any StorageClass is set or created as default. ([#111467](https://github.com/kubernetes/kubernetes/pull/111467), [@RomanBednar](https://github.com/RomanBednar))
- Promote StatefulSet minReadySeconds to GA. This means `--feature-gates=StatefulSetMinReadySeconds=true` are not needed on kube-apiserver and kube-controller-manager binaries and they'll be removed soon following policy at https://kubernetes.io/docs/reference/using-api/deprecation-policy/#deprecation ([#110896](https://github.com/kubernetes/kubernetes/pull/110896), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG API Machinery, Apps and Testing]
- Promoted CronJob's TimeZone support to beta. ([#111435](https://github.com/kubernetes/kubernetes/pull/111435), [@soltysh](https://github.com/soltysh))
- Promoted DaemonSet MaxSurge to GA. This means `--feature-gates=DaemonSetUpdateSurge=true` are not needed on kube-apiserver and kube-controller-manager binaries and they'll be removed soon following policy at https://kubernetes.io/docs/reference/using-api/deprecation-policy/#deprecation . ([#111194](https://github.com/kubernetes/kubernetes/pull/111194), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Scheduler: included supported ScoringStrategyType list in error message for NodeResourcesFit plugin ([#111206](https://github.com/kubernetes/kubernetes/pull/111206), [@SataQiu](https://github.com/SataQiu))
- The Go API for logging configuration in `k8s.io/component-base` was moved to `k8s.io/component-base/logs/api/v1`. The configuration file format and command line flags are the same as before. ([#105797](https://github.com/kubernetes/kubernetes/pull/105797), [@pohly](https://github.com/pohly))
- The Pod `spec.podOS` field is promoted to GA. The `IdentifyPodOS` feature gate unconditionally enabled, and will no longer be accepted as a `--feature-gates` parameter in 1.27. ([#111229](https://github.com/kubernetes/kubernetes/pull/111229), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- The PodTopologySpread is respected after rolling upgrades. ([#111441](https://github.com/kubernetes/kubernetes/pull/111441), [@denkensk](https://github.com/denkensk))
- The `CSIInlineVolume` feature has moved from beta to GA. ([#111258](https://github.com/kubernetes/kubernetes/pull/111258), [@dobsonj](https://github.com/dobsonj))
- The `PodSecurity` admission plugin has graduated to GA and is enabled by default. The admission configuration version has been promoted to `pod-security.admission.config.k8s.io/v1`. ([#110459](https://github.com/kubernetes/kubernetes/pull/110459), [@wangyysde](https://github.com/wangyysde))
- The `endPort` field in Network Policy is now promoted to GA
  
  Network Policy providers that support `endPort` field now can use it to specify a range of ports to apply a Network Policy.
  
  Previously, each Network Policy could only target a single port.
  
  Please be aware that `endPort` field MUST BE SUPPORTED by the Network Policy provider. In case your provider does not support `endPort` and this field is specified in a Network Policy, the Network Policy will be created covering only the port field (single port). ([#110868](https://github.com/kubernetes/kubernetes/pull/110868), [@rikatz](https://github.com/rikatz))
- The `metadata.clusterName` field is completely removed. This should not have any user-visible impact. ([#109602](https://github.com/kubernetes/kubernetes/pull/109602), [@lavalamp](https://github.com/lavalamp))
- The `minDomains` field in Pod Topology Spread is graduated to beta ([#110388](https://github.com/kubernetes/kubernetes/pull/110388), [@sanposhiho](https://github.com/sanposhiho)) [SIG API Machinery and Apps]
- The command line flag `enable-taint-manager` for kube-controller-manager is deprecated and will be removed in 1.26. The feature that it supports, taint based eviction, is enabled by default and will continue to be implicitly enabled when the flag is removed. ([#111411](https://github.com/kubernetes/kubernetes/pull/111411), [@alculquicondor](https://github.com/alculquicondor))
- This release added support for `NodeExpandSecret` for CSI driver client which enables the CSI drivers to make use of this secret while performing node expansion operation based on the user request. Previously there was no secret  provided as part of the `nodeexpansion` call, thus CSI drivers did not make use of the same while expanding the volume at the node side. ([#105963](https://github.com/kubernetes/kubernetes/pull/105963), [@zhucan](https://github.com/zhucan))
- [Ephemeral Containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/) are now generally available (GA). The `EphemeralContainers` feature gate is always enabled and should be removed from `--feature-gates` flag on the kube-apiserver and the kubelet command lines. The `EphemeralContainers` feature gate is [deprecated and scheduled for removal](https://kubernetes.io/docs/reference/using-api/deprecation-policy/#deprecation)  in a future release. ([#111402](https://github.com/kubernetes/kubernetes/pull/111402), [@verb](https://github.com/verb))

### Feature

- Added KMS `v2alpha1` API. ([#110201](https://github.com/kubernetes/kubernetes/pull/110201), [@aramase](https://github.com/aramase))
- Added Service Account field in the output of `kubectl describe pod` command. ([#111192](https://github.com/kubernetes/kubernetes/pull/111192), [@aufarg](https://github.com/aufarg))
- Added a new `align-by-socket` policy option to cpu manager `static` policy.  When enabled CPU's to be aligned at socket boundary rather than NUMA boundary. ([#111278](https://github.com/kubernetes/kubernetes/pull/111278), [@arpitsardhana](https://github.com/arpitsardhana))
- Added container probe duration metrics. ([#104484](https://github.com/kubernetes/kubernetes/pull/104484), [@jackfrancis](https://github.com/jackfrancis))
- Added new flags into alpha events such as --output, --types, --no-headers. ([#110007](https://github.com/kubernetes/kubernetes/pull/110007), [@ardaguclu](https://github.com/ardaguclu))
- Added sum feature to `kubectl top pod` ([#105100](https://github.com/kubernetes/kubernetes/pull/105100), [@lauchokyip](https://github.com/lauchokyip))
- Added the `Apply` and `ApplyStatus` methods to the dynamic `ResourceInterface` ([#109443](https://github.com/kubernetes/kubernetes/pull/109443), [@kevindelgado](https://github.com/kevindelgado))
- Feature gate `CSIMigration` was locked to enabled. `CSIMigration` is GA now. The feature gate will be removed in `v1.27`. ([#110410](https://github.com/kubernetes/kubernetes/pull/110410), [@Jiawei0227](https://github.com/Jiawei0227))
- Feature gate `ProbeTerminationGracePeriod` is enabled by default. ([#108541](https://github.com/kubernetes/kubernetes/pull/108541), [@kerthcet](https://github.com/kerthcet))
- Ginkgo: when e2e tests are invoked through ginkgo-e2e.sh, the default now is to use color escape sequences only when connected to a terminal. `GINKGO_NO_COLOR=y/n` can be used to override that default. ([#111633](https://github.com/kubernetes/kubernetes/pull/111633), [@pohly](https://github.com/pohly))
- Graduated SeccompDefault to `beta`. The Kubelet feature gate is now enabled by default and the configuration/CLI flag still defaults to `false`. ([#110805](https://github.com/kubernetes/kubernetes/pull/110805), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node and Testing]
- Graduated ServerSideFieldValidation to `beta`. Schema validation is performed server-side and requests will receive warnings for any invalid/unknown fields by default. ([#110178](https://github.com/kubernetes/kubernetes/pull/110178), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Storage and Testing]
- Graduated `CustomResourceValidationExpressions` to `beta`. The `CustomResourceValidationExpressions` feature gate is now enabled by default. ([#111524](https://github.com/kubernetes/kubernetes/pull/111524), [@cici37](https://github.com/cici37))
- Graduated `ServiceIPStaticSubrange` feature to Beta (disabled by default). ([#110419](https://github.com/kubernetes/kubernetes/pull/110419), [@aojea](https://github.com/aojea))
- If a Pod has a DisruptionTarget condition with status=True for more than 2 minutes without getting a DeletionTimestamp, the control plane resets it to status=False. ([#111475](https://github.com/kubernetes/kubernetes/pull/111475), [@alculquicondor](https://github.com/alculquicondor))
- In "large" clusters, kube-proxy in iptables mode will now sometimes
  leave unused rules in iptables for a while (up to `--iptables-sync-period`)
  before deleting them. This improves performance by not requiring it to
  check for stale rules on every sync. (In smaller clusters, it will still
  remove unused rules immediately once they are no longer used.)
  
  (The threshold for "large" used here is currently "1000 endpoints" but
  this is subject to change.) ([#110334](https://github.com/kubernetes/kubernetes/pull/110334), [@danwinship](https://github.com/danwinship))
- Kube-up now includes CoreDNS version v1.9.3. ([#110488](https://github.com/kubernetes/kubernetes/pull/110488), [@mzaian](https://github.com/mzaian))
- Kubeadm: Added support for additional authentication strategies in `kubeadm join` with discovery/kubeconfig file: client-go authentication plugins (`exec`), `tokenFile`, and `authProvider.` ([#110553](https://github.com/kubernetes/kubernetes/pull/110553), [@tallaxes](https://github.com/tallaxes))
- Kubeadm: Update CoreDNS to v1.9.3. ([#110489](https://github.com/kubernetes/kubernetes/pull/110489), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: added support for the flag `--print-manifest` to the addon phases `kube-proxy` and `coredns` of `kubeadm init phase addon`. If this flag is `usedkubeadm` will not apply a given addon and instead print to the terminal the API objects that will be applied. ([#109995](https://github.com/kubernetes/kubernetes/pull/109995), [@wangyysde](https://github.com/wangyysde))
- Kubeadm: enhanced the "patches" functionality to be able to patch kubelet config files containing `v1beta1.KubeletConfiguration`. The new patch target is called `kubeletconfiguration` (e.g. patch file `kubeletconfiguration+json.json`).This makes it possible to apply node specific KubeletConfiguration options during `init`, `join` and `upgrade`, while the main `KubeletConfiguration` that is passed to `init` as part of the `--config` file can still act as the global stored in the cluster `KubeletConfiguration`. ([#110405](https://github.com/kubernetes/kubernetes/pull/110405), [@neolit123](https://github.com/neolit123))
- Kubeadm: make sure the etcd static pod startup probe uses /health?serializable=false while the liveness probe uses /health?serializable=true&exclude=NOSPACE. The NOSPACE exclusion would allow administrators to address space issues one member at a time. ([#110744](https://github.com/kubernetes/kubernetes/pull/110744), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: modified the etcd static Pod `liveness` and `readiness` probes to use a new etcd `v3.5.3+` HTTP(s) health check endpoint `/health?serializable=true` that allows to track the health of individual etcd members and not fail all members if a single member is not healthy in the etcd cluster. ([#110072](https://github.com/kubernetes/kubernetes/pull/110072), [@neolit123](https://github.com/neolit123))
- Kubeadm: support experimental JSON/YAML output for `kubeadm upgrade plan` with the `--output` flag. ([#108447](https://github.com/kubernetes/kubernetes/pull/108447), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: the preferred pod anti-affinity for CoreDNS is now enabled by default. ([#110593](https://github.com/kubernetes/kubernetes/pull/110593), [@SataQiu](https://github.com/SataQiu))
- Kubectl: support multiple resources for kubectl rollout status. ([#108777](https://github.com/kubernetes/kubernetes/pull/108777), [@pjo256](https://github.com/pjo256))
- Kubernetes is now built with Golang 1.18.2. ([#110043](https://github.com/kubernetes/kubernetes/pull/110043), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Golang 1.18.3 ([#110421](https://github.com/kubernetes/kubernetes/pull/110421), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Kubernetes is now built with Golang 1.19.0. ([#111679](https://github.com/kubernetes/kubernetes/pull/111679), [@puerco](https://github.com/puerco))
- Lock CSIMigrationAzureDisk feature gate to default. ([#110491](https://github.com/kubernetes/kubernetes/pull/110491), [@andyzhangx](https://github.com/andyzhangx))
- Metric `running_managed_controllers` is enabled for Cloud Node Lifecycle controller. ([#111033](https://github.com/kubernetes/kubernetes/pull/111033), [@jprzychodzen](https://github.com/jprzychodzen))
- Metric `running_managed_controllers` is enabled for Node IPAM controller in KCM. ([#111466](https://github.com/kubernetes/kubernetes/pull/111466), [@jprzychodzen](https://github.com/jprzychodzen))
- Metric `running_managed_controllers` is enabled for Route,Service and Cloud Node controllers in KCM and CCM. ([#111462](https://github.com/kubernetes/kubernetes/pull/111462), [@jprzychodzen](https://github.com/jprzychodzen))
- New `KUBECACHEDIR` environment variable was introduced to override default discovery cache directory which is `$HOME/.kube/cache`. ([#109479](https://github.com/kubernetes/kubernetes/pull/109479), [@ardaguclu](https://github.com/ardaguclu))
- Pod SecurityContext and PodSecurityPolicy supports slash as sysctl separator. ([#106834](https://github.com/kubernetes/kubernetes/pull/106834), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Apps, Architecture, Auth, Node, Security and Testing]
- Promoted LocalStorageCapacityIsolationFSQuotaMonitoring to beta. ([#107329](https://github.com/kubernetes/kubernetes/pull/107329), [@pacoxu](https://github.com/pacoxu))
- Promoted the `CSIMigrationPortworx` feature gate to Beta. ([#110411](https://github.com/kubernetes/kubernetes/pull/110411), [@trierra](https://github.com/trierra))
- Return a warning when applying a `pod-security.kubernetes.io` label to a PodSecurity-exempted namespace.
  Stop including the `pod-security.kubernetes.io/exempt=namespace` audit annotation on namespace requests. ([#109680](https://github.com/kubernetes/kubernetes/pull/109680), [@tallclair](https://github.com/tallclair))
- The  new flag `etcd-ready-timeout` has been added. It configures a timeout of an additional etcd check performed as part of readyz check. ([#111399](https://github.com/kubernetes/kubernetes/pull/111399), [@Argh4k](https://github.com/Argh4k))
- The TopologySpreadConstraints will be shown in describe command for pods, deployments, daemonsets, etc. ([#109563](https://github.com/kubernetes/kubernetes/pull/109563), [@ardaguclu](https://github.com/ardaguclu))
- The `kubectl diff` changed to ignore managed fields by default, and a new --show-managed-fields flag has been added to allow you to include managed fields in the diff. ([#111319](https://github.com/kubernetes/kubernetes/pull/111319), [@brianpursley](https://github.com/brianpursley))
- The beta feature `ServiceIPStaticSubrange` is now enabled by default. ([#110703](https://github.com/kubernetes/kubernetes/pull/110703), [@aojea](https://github.com/aojea))
- Updated base image for Windows pause container images to one built on Windows machines to address limitations of building Windows container images on Linux machines. ([#110379](https://github.com/kubernetes/kubernetes/pull/110379), [@marosset](https://github.com/marosset))
- Updated cAdvisor to v0.45.0. ([#111647](https://github.com/kubernetes/kubernetes/pull/111647), [@bobbypage](https://github.com/bobbypage))
- Updated debian-base, debian-iptables, and setcap images:
  - debian-base:bullseye-v1.3.0
  - debian-iptables:bullseye-v1.4.0
  - setcap:bullseye-v1.3.0 ([#110558](https://github.com/kubernetes/kubernetes/pull/110558), [@wespanther](https://github.com/wespanther))
- When using the OpenStack legacy cloud provider, kubelet and KCM will ignore unknown configuration directives rather than failing to start. ([#109709](https://github.com/kubernetes/kubernetes/pull/109709), [@mdbooth](https://github.com/mdbooth))
- ` JobTrackingWithFinalizers` enabled by default. This feature allows to keep track of the Job progress without relying on Pods staying in the apiserver.
   ([#110948](https://github.com/kubernetes/kubernetes/pull/110948), [@alculquicondor](https://github.com/alculquicondor))
- `CSIMigrationAWS` upgraded to GA and locked to true.
   ([#111479](https://github.com/kubernetes/kubernetes/pull/111479), [@wongma7](https://github.com/wongma7))
- `CSIMigrationGCE` upgraded to GA and locked to true.
   ([#111301](https://github.com/kubernetes/kubernetes/pull/111301), [@mattcary](https://github.com/mattcary))
- `CSIMigrationvSphere` feature is now enabled by default.
   ([#103523](https://github.com/kubernetes/kubernetes/pull/103523), [@divyenpatel](https://github.com/divyenpatel))
- `MaxUnavailable` for `StatefulSets`, allows faster `RollingUpdate` by taking down more than 1 pod at a time. 
  The number of pods you want to take down during a `RollingUpdate` is configurable using `maxUnavailable` parameter.
   ([#109251](https://github.com/kubernetes/kubernetes/pull/109251), [@krmayankk](https://github.com/krmayankk))
- The `gcp` and `azure` auth plugins have been restored to client-go and kubectl until https://issue.k8s.io/111911 is resolved in supported kubectl minor versions. ([#111918](https://github.com/kubernetes/kubernetes/pull/111918), [@liggitt](https://github.com/liggitt))

### Documentation

- EndpointSlices with Pod referencing Nodes that don't exist couldn't be created or updated. The behavior on the EndpointSlice controller has been modified to update the EndpointSlice without the Pods that reference non-existing Nodes and keep retrying until all Pods reference existing Nodes. However, if `service.Spec.PublishNotReadyAddresses` is set, all the Pods are published without retrying. Fixed EndpointSlices metrics to reflect correctly the number of desired EndpointSlices when no endpoints are present. ([#110639](https://github.com/kubernetes/kubernetes/pull/110639), [@aojea](https://github.com/aojea))
- Optimization of kubectl Chinese translation ([#110538](https://github.com/kubernetes/kubernetes/pull/110538), [@hwdef](https://github.com/hwdef)) [SIG CLI]

### Failing Test

- E2e tests: fixed bug in the e2e image `agnhost:2.38` which hangs instead of exiting if a `SIGTERM` signal is received and the `shutdown-delay` option is `0`. ([#110214](https://github.com/kubernetes/kubernetes/pull/110214), [@aojea](https://github.com/aojea))
- In-tree GCE PD test cases no longer run in Kubernetes testing harness anymore (side effect of switching on CSI migration in 1.22). Please switch on the environment variable `ENABLE_STORAGE_GCE_PD_DRIVER` to `yes` if you need to run these tests. ([#109541](https://github.com/kubernetes/kubernetes/pull/109541), [@dims](https://github.com/dims))

### Bug or Regression

- A bug was fixed where a job sync was not retried in case of a transient ResourceQuota conflict. ([#111026](https://github.com/kubernetes/kubernetes/pull/111026), [@alculquicondor](https://github.com/alculquicondor))
- A change of a failed job condition status to `False` does not result in duplicate  conditions. ([#110292](https://github.com/kubernetes/kubernetes/pull/110292), [@mimowo](https://github.com/mimowo))
- Added error message "dry-run can not be used when --force is set" when dry-run and force flags are set in replace command. ([#110326](https://github.com/kubernetes/kubernetes/pull/110326), [@ardaguclu](https://github.com/ardaguclu))
- Added the latest GCE pinhole firewall feature, which introduces `destination-ranges` in the ingress `firewall-rules`. It restricts access to the backend IPs by allowing traffic through `ILB` or `NetLB` only. This change does **NOT** change the existing `ILB` or `NetLB` behavior. ([#109510](https://github.com/kubernetes/kubernetes/pull/109510), [@sugangli](https://github.com/sugangli))
- Allow expansion of ephemeral volumes ([#109987](https://github.com/kubernetes/kubernetes/pull/109987), [@gnufied](https://github.com/gnufied)) [SIG Node and Storage]
- Apiserver: fixed audit of loading more than one webhooks. ([#110145](https://github.com/kubernetes/kubernetes/pull/110145), [@sxllwx](https://github.com/sxllwx))
- Bug fix in test/e2e/framework  Framework.RecordFlakeIfError ([#111048](https://github.com/kubernetes/kubernetes/pull/111048), [@alingse](https://github.com/alingse)) [SIG Testing]
- Client-go: fixed an error in the fake client when creating API requests are submitted to subresources like `pods/eviction`. ([#110425](https://github.com/kubernetes/kubernetes/pull/110425), [@LY-today](https://github.com/LY-today))
- Do not raise an error when setting a label with the same value, ignore it. ([#105936](https://github.com/kubernetes/kubernetes/pull/105936), [@zigarn](https://github.com/zigarn))
- Do not report terminated container metrics ([#110950](https://github.com/kubernetes/kubernetes/pull/110950), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Node]
- EndpointSlices marked for deletion are now ignored during reconciliation. ([#109624](https://github.com/kubernetes/kubernetes/pull/109624), [@aryan9600](https://github.com/aryan9600))
- Etcd: Update to v3.5.4 ([#110033](https://github.com/kubernetes/kubernetes/pull/110033), [@mk46](https://github.com/mk46)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- Faster mount detection for linux kernel 5.10+ using openat2 speeding up pod churn rates. On Kernel versions less 5.10, it will fallback to using the original way of detecting mount points i.e by parsing /proc/mounts. ([#109217](https://github.com/kubernetes/kubernetes/pull/109217), [@manugupt1](https://github.com/manugupt1))
- FibreChannel volume plugin may match the wrong device and wrong associated devicemapper parent. This may cause a disater that pods attach wrong disks. ([#110719](https://github.com/kubernetes/kubernetes/pull/110719), [@xakdwch](https://github.com/xakdwch))
- Fix a bug where CRI implementations that use cAdvisor stats provider (CRI-O) don't evict pods when their logs exceed ephemeral storage limit. ([#108115](https://github.com/kubernetes/kubernetes/pull/108115), [@haircommander](https://github.com/haircommander)) [SIG Node]
- Fix a bug where metrics are not recorded during Preemption(PostFilter). ([#108727](https://github.com/kubernetes/kubernetes/pull/108727), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Fix a data race in authentication between AuthenticatedGroupAdder and cached token authenticator. ([#109969](https://github.com/kubernetes/kubernetes/pull/109969), [@sttts](https://github.com/sttts)) [SIG API Machinery and Auth]
- Fix bug that prevented the job controller from enforcing activeDeadlineSeconds when set. ([#110294](https://github.com/kubernetes/kubernetes/pull/110294), [@harshanarayana](https://github.com/harshanarayana))
- Fix for volume reconstruction of CSI ephemeral volumes ([#108997](https://github.com/kubernetes/kubernetes/pull/108997), [@dobsonj](https://github.com/dobsonj)) [SIG Node, Storage and Testing]
- Fix incorrectly report scope for request_duration_seconds and request_slo_duration_seconds metrics for POST custom resources API calls. ([#110009](https://github.com/kubernetes/kubernetes/pull/110009), [@azylinski](https://github.com/azylinski)) [SIG Instrumentation]
- Fix printing resources with int64 fields ([#110408](https://github.com/kubernetes/kubernetes/pull/110408), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Fix spurious kube-apiserver log warnings related to openapi v3 merging when creating or modifying CustomResourceDefinition objects ([#109880](https://github.com/kubernetes/kubernetes/pull/109880), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery and Testing]
- Fix the bug that reported incorrect metrics for the cluster IP allocator. ([#110027](https://github.com/kubernetes/kubernetes/pull/110027), [@tksm](https://github.com/tksm))
- Fixed JobTrackingWithFinalizers when a pod succeeds after the job is considered failed, which led to API conflicts that blocked finishing the job. ([#111646](https://github.com/kubernetes/kubernetes/pull/111646), [@alculquicondor](https://github.com/alculquicondor))
- Fixed `JobTrackingWithFinalizers` that:
  - was declaring a job finished before counting all the created pods in the status
  - was leaving pods with finalizers, blocking pod and job deletions
   `JobTrackingWithFinalizers` is still disabled by default. ([#109486](https://github.com/kubernetes/kubernetes/pull/109486), [@alculquicondor](https://github.com/alculquicondor))
- Fixed `NeedResize` build failure on Windows. ([#109721](https://github.com/kubernetes/kubernetes/pull/109721), [@andyzhangx](https://github.com/andyzhangx))
- Fixed a bug in `kubectl` that caused the wrong result length when using `--chunk-size` and `--selector` together. ([#110652](https://github.com/kubernetes/kubernetes/pull/110652), [@Abirdcfly](https://github.com/Abirdcfly))
- Fixed a bug involving Services of type `LoadBalancer` with multiple IPs and a `LoadBalancerSourceRanges` that overlaps the node IP. ([#109826](https://github.com/kubernetes/kubernetes/pull/109826), [@danwinship](https://github.com/danwinship))
- Fixed a bug which could have allowed an improperly annotated LoadBalancer service to become active. ([#109601](https://github.com/kubernetes/kubernetes/pull/109601), [@mdbooth](https://github.com/mdbooth))
- Fixed a kubelet issue that could result in invalid pod status updates to be sent to the api-server where pods would be reported in a terminal phase but also report a ready condition of true in some cases. ([#110256](https://github.com/kubernetes/kubernetes/pull/110256), [@bobbypage](https://github.com/bobbypage))
- Fixed an issue on Windows nodes where `HostProcess` containers may not be created as expected. ([#110140](https://github.com/kubernetes/kubernetes/pull/110140), [@marosset](https://github.com/marosset))
- Fixed bug where CSI migration doesn't count inline volumes for attach limit. ([#107787](https://github.com/kubernetes/kubernetes/pull/107787), [@Jiawei0227](https://github.com/Jiawei0227))
- Fixed error "dbus: connection closed by user" after dbus daemon restarts. ([#110496](https://github.com/kubernetes/kubernetes/pull/110496), [@kolyshkin](https://github.com/kolyshkin))
- Fixed image pull failure when `IMDS` is unavailable in kubelet startup. ([#110523](https://github.com/kubernetes/kubernetes/pull/110523), [@andyzhangx](https://github.com/andyzhangx))
- Fixed memory leak in the job controller related to `JobTrackingWithFinalizers`. ([#111721](https://github.com/kubernetes/kubernetes/pull/111721), [@alculquicondor](https://github.com/alculquicondor))
- Fixed mounting of iSCSI volumes over IPv6 networks. ([#110688](https://github.com/kubernetes/kubernetes/pull/110688), [@jsafrane](https://github.com/jsafrane))
- Fixed performance issue when creating large objects using SSA with fully unspecified schemas ( preserveUnknownFields ). ([#111557](https://github.com/kubernetes/kubernetes/pull/111557), [@alexzielenski](https://github.com/alexzielenski))
- Fixed s.RuntimeCgroups error condition and Fixed possible wrong log print. ([#110648](https://github.com/kubernetes/kubernetes/pull/110648), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- Fixed scheduling of **CronJob** with `@every X` schedules. ([#109250](https://github.com/kubernetes/kubernetes/pull/109250), [@d-honeybadger](https://github.com/d-honeybadger))
- Fixed strict server-side field validation treating `metadata` fields as unknown fields. ([#109268](https://github.com/kubernetes/kubernetes/pull/109268), [@liggitt](https://github.com/liggitt))
- Fixed the GCE firewall update when the destination IPs are changing so that firewalls reflect the IP updates of the LBs. ([#111186](https://github.com/kubernetes/kubernetes/pull/111186), [@sugangli](https://github.com/sugangli))
- Fixed the bug that a `ServiceIPStaticSubrange` enabled cluster assigns duplicate IP addresses when the dynamic block is exhausted. ([#109928](https://github.com/kubernetes/kubernetes/pull/109928), [@tksm](https://github.com/tksm))
- For scheduler plugin developers: the scheduler framework's shared PodInformer is now initialized with empty indexers. This enables scheduler plugins to add their extra indexers. Note that only non-conflict indexers are allowed to be added. ([#110663](https://github.com/kubernetes/kubernetes/pull/110663), [@fromanirh](https://github.com/fromanirh)) [SIG Scheduling]
- If the parent directory of the file specified in the `--audit-log-path` argument does not exist, Kubernetes now creates it. ([#110813](https://github.com/kubernetes/kubernetes/pull/110813), [@vpnachev](https://github.com/vpnachev)) [SIG Auth]
- Informer/reflector callers can now catch and unwrap specific API errors by type. ([#110076](https://github.com/kubernetes/kubernetes/pull/110076), [@karlkfi](https://github.com/karlkfi))
- Kube-apiserver: Get, GetList and Watch requests that should be served by the apiserver cacher during shutdown will be rejected to avoid a deadlock situation leaving requests hanging. ([#108414](https://github.com/kubernetes/kubernetes/pull/108414), [@aojea](https://github.com/aojea))
- Kubeadm: Fixed duplicate `unix://` prefix in node annotation. ([#110656](https://github.com/kubernetes/kubernetes/pull/110656), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: a bug was fixed due to which configurable `KubernetesVersion` was not being respected during kubeadm join. ([#110791](https://github.com/kubernetes/kubernetes/pull/110791), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: enabled the --experimental-watch-progress-notify-interval flag for etcd and set it to 5s. The flag specifies an interval at which etcd sends watch data to the kube-apiserver. ([#111383](https://github.com/kubernetes/kubernetes/pull/111383), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Kubeadm: now sets the host `OS` environment variables when executing `crictl` during image pulls. This fixed a bug where `*PROXY` environment variables did not affect `crictl` internet connectivity. ([#110134](https://github.com/kubernetes/kubernetes/pull/110134), [@mk46](https://github.com/mk46))
- Kubeadm: only taint control plane nodes when the legacy "master" taint is present. This avoids the bug where "kubeadm upgrade" will re-taint a control plane  node with the new "control plane" taint even if the user explicitly untainted the node. ([#109840](https://github.com/kubernetes/kubernetes/pull/109840), [@neolit123](https://github.com/neolit123))
- Kubeadm: respect user specified image repository when using Kubernetes ci version ([#111017](https://github.com/kubernetes/kubernetes/pull/111017), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: support retry mechanism for removing container in reset phase ([#110837](https://github.com/kubernetes/kubernetes/pull/110837), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubelet: added log for volume metric collection taking too long ([#107490](https://github.com/kubernetes/kubernetes/pull/107490), [@pacoxu](https://github.com/pacoxu))
- Kubelet: added retry of checking Unix domain sockets on Windows nodes for the plugin registration mechanism. ([#110075](https://github.com/kubernetes/kubernetes/pull/110075), [@luckerby](https://github.com/luckerby))
- Kubelet: added validation for labels provided with --node-labels. Malformed labels will result in errors. ([#109263](https://github.com/kubernetes/kubernetes/pull/109263), [@FeLvi-zzz](https://github.com/FeLvi-zzz))
- Kubelet: wait for node allocatable ephemeral-storage data. ([#101882](https://github.com/kubernetes/kubernetes/pull/101882), [@jackfrancis](https://github.com/jackfrancis))
- Kubernetes now correctly handles "search ." in the host's resolv.conf file by preserving the "." entry in the "resolv.conf" that the kubelet writes to pods. ([#109441](https://github.com/kubernetes/kubernetes/pull/109441), [@Miciah](https://github.com/Miciah)) [SIG Network and Node]
- Made usage of key encipherment optional in API validation. ([#111061](https://github.com/kubernetes/kubernetes/pull/111061), [@pacoxu](https://github.com/pacoxu))
- ManagedFields time is correctly updated when the value of a managed field is modified. ([#110058](https://github.com/kubernetes/kubernetes/pull/110058), [@glebiller](https://github.com/glebiller))
- OpenAPI will no longer duplicate these schemas:
  - `io.k8s.apimachinery.pkg.apis.meta.v1.DeleteOptions_v2`
  - `io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta_v2`
  - `io.k8s.apimachinery.pkg.apis.meta.v1.OwnerReference_v2`
  - `io.k8s.apimachinery.pkg.apis.meta.v1.StatusDetails_v2`
  - `io.k8s.apimachinery.pkg.apis.meta.v1.Status_v2` ([#110179](https://github.com/kubernetes/kubernetes/pull/110179), [@Jefftree](https://github.com/Jefftree))
- Panics while calling validating admission webhook are caught and honor the fail open or fail closed setting. ([#108746](https://github.com/kubernetes/kubernetes/pull/108746), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- Pods now post their `readiness` during termination. ([#110191](https://github.com/kubernetes/kubernetes/pull/110191), [@rphillips](https://github.com/rphillips))
- Reduced duration to sync proxy rules on Windows `kube-proxy` when using `kernelspace` mode. ([#109124](https://github.com/kubernetes/kubernetes/pull/109124), [@daschott](https://github.com/daschott))
- Reduced the number of cloud API calls and service downtime caused by excessive re-configurations of cluster LBs with externalTrafficPolicy=Local when node readiness changes (https://github.com/kubernetes/kubernetes/issues/111539). The service controller (in cloud-controller-manager) will avoid resyncing nodes which are transitioning between `Ready` / `NotReady` (only for for ETP=Local Services).  The LBs used for these services will solely rely on the health check probe defined by the `healthCheckNodePort` to determine if a particular node is to be used for traffic load balancing. ([#109706](https://github.com/kubernetes/kubernetes/pull/109706), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Removed the recently re-introduced schedulability predicate ([#109706](https://github.com/kubernetes/kubernetes/pull/109706)) as to not have unschedulable nodes removed from load balancers back-end pools. ([#111691](https://github.com/kubernetes/kubernetes/pull/111691), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Removed unused flags from `kubectl run` command. ([#110668](https://github.com/kubernetes/kubernetes/pull/110668), [@brianpursley](https://github.com/brianpursley))
- Run kubelet, when there is an error exit, print the error log. ([#110691](https://github.com/kubernetes/kubernetes/pull/110691), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085))
- The `priority_level_request_utilization` metric histogram is adjusted so that for the cases where `phase=waiting` the denominator is the cumulative capacity of all of the priority level's queues.
   The `read_vs_write_current_requests` metric histogram is adjusted, in the case of using API Priority and Fairness instead of max-in-flight, to divide by the relevant limit: sum of queue capacities for waiting requests, sum of seat limits for executing requests. ([#110164](https://github.com/kubernetes/kubernetes/pull/110164), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- The commands `kubeadm certs renew` and `kubeadm certs check-expiration` now honor the `cert-dir` flag on a running Kubernetes cluster. ([#110709](https://github.com/kubernetes/kubernetes/pull/110709), [@chendave](https://github.com/chendave))
- The kube-proxy `sync_proxy_rules_no_endpoints_total` metric now only counts local-traffic-policy services which have remote endpoints but not local endpoints. ([#109782](https://github.com/kubernetes/kubernetes/pull/109782), [@danwinship](https://github.com/danwinship))
- The namespace editors and admins can now create leases.coordination.k8s.io and should use this type for leaderelection instead of configmaps. ([#111472](https://github.com/kubernetes/kubernetes/pull/111472), [@deads2k](https://github.com/deads2k))
- The node annotation alpha.kubernetes.io/provided-node-ip is no longer set ONLY when `--cloud-provider=external`.  Now, it is set on kubelet startup if the `--cloud-provider` flag is set at all, including the deprecated in-tree providers. ([#109794](https://github.com/kubernetes/kubernetes/pull/109794), [@mdbooth](https://github.com/mdbooth)) [SIG Network and Node]
- The pod phase lifecycle guarantees that terminal Pods, those whose states are `Unready` or `Succeeded`, can not regress and will have all container stopped. Hence, terminal Pods will never be reachable and should not publish their IP addresses on the `Endpoints` or `EndpointSlices`, independently of the Service `TolerateUnready` option. ([#110255](https://github.com/kubernetes/kubernetes/pull/110255), [@robscott](https://github.com/robscott))
- Unmounted volumes correctly for reconstructed volumes even if mount operation fails after kubelet restart. ([#110670](https://github.com/kubernetes/kubernetes/pull/110670), [@gnufied](https://github.com/gnufied))
- Updated max azure data disk count map with new VM types. ([#111406](https://github.com/kubernetes/kubernetes/pull/111406), [@bennerv](https://github.com/bennerv))
- Updated to cAdvisor v0.44.1 to fix an issue where metrics generated by kubelet for pod network stats were empty in some cases. ([#109658](https://github.com/kubernetes/kubernetes/pull/109658), [@bobbypage](https://github.com/bobbypage))
- Upgraded Azure/go-autorest/autorest to v0.11.27. ([#110371](https://github.com/kubernetes/kubernetes/pull/110371), [@andyzhangx](https://github.com/andyzhangx))
- Upgraded functionality of `kubectl kustomize` as described at
  https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.5.7. ([#111606](https://github.com/kubernetes/kubernetes/pull/111606), [@natasha41575](https://github.com/natasha41575))
- Use checksums instead of fsyncs to ensure discovery cache integrity ([#110851](https://github.com/kubernetes/kubernetes/pull/110851), [@negz](https://github.com/negz)) [SIG API Machinery]
- UserName check for 'ContainerAdministrator' is now case-insensitive if runAsNonRoot is set to true on Windows. ([#111009](https://github.com/kubernetes/kubernetes/pull/111009), [@marosset](https://github.com/marosset))
- Volumes are no longer detached from healthy nodes after 6 minutes timeout. 6 minute force-detach timeout is used only for unhealthy nodes (`node.status.conditions["Ready"]!= true`). ([#110721](https://github.com/kubernetes/kubernetes/pull/110721), [@jsafrane](https://github.com/jsafrane))
- When metrics are counted, discard the wrong container StartTime metrics ([#110880](https://github.com/kubernetes/kubernetes/pull/110880), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Instrumentation and Node]
- Windows kubelet plugin Watcher now working as intended. ([#111439](https://github.com/kubernetes/kubernetes/pull/111439), [@claudiubelu](https://github.com/claudiubelu))
- [aws] Fixed a bug which reduces the number of unnecessary calls to STS in the event of assume role failures in the legacy cloud provider ([#110706](https://github.com/kubernetes/kubernetes/pull/110706), [@prateekgogia](https://github.com/prateekgogia)) [SIG Cloud Provider]
- `pod.Spec.RuntimeClassName` field is now available in kubectl describe command. ([#110914](https://github.com/kubernetes/kubernetes/pull/110914), [@yeahdongcn](https://github.com/yeahdongcn))

### Other (Cleanup or Flake)

- Add missing powershell option to kubectl completion command short description. ([#109773](https://github.com/kubernetes/kubernetes/pull/109773), [@danielhelfand](https://github.com/danielhelfand))
- Added e2e test flag to specify which volume drivers should be installed. This  deprecated the ENABLE_STORAGE_GCE_PD_DRIVER environment variable. ([#111481](https://github.com/kubernetes/kubernetes/pull/111481), [@mattcary](https://github.com/mattcary))
- Changed PV framework delete timeout to 5 minutes as documented. ([#109764](https://github.com/kubernetes/kubernetes/pull/109764), [@saikat-royc](https://github.com/saikat-royc))
- Default burst limit for the discovery client set to 300. ([#109141](https://github.com/kubernetes/kubernetes/pull/109141), [@ulucinar](https://github.com/ulucinar))
- Deleted the `apimachinery/clock` package. Please use `k8s.io/utils/clock` package instead. ([#109752](https://github.com/kubernetes/kubernetes/pull/109752), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Feature gates that graduated to GA in 1.23 or earlier and were unconditionally enabled have been removed: CSIServiceAccountToken, ConfigurableFSGroupPolicy, EndpointSlice, EndpointSliceNodeName, EndpointSliceProxying, GenericEphemeralVolume, IPv6DualStack, IngressClassNamespacedParams, StorageObjectInUseProtection, TTLAfterFinished, VolumeSubpath, WindowsEndpointSliceProxying. ([#109435](https://github.com/kubernetes/kubernetes/pull/109435), [@pohly](https://github.com/pohly))
- For Linux, `kube-proxy` uses a new “distroless” container image, instead of an image based on Debian. ([#111060](https://github.com/kubernetes/kubernetes/pull/111060), [@aojea](https://github.com/aojea))
- For resources built into an apiserver, the server now logs at `-v=3` whether it is using watch caching. ([#109175](https://github.com/kubernetes/kubernetes/pull/109175), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- GlusterFS provisioner (`kubernetes.io/glusterfs`) has been deprecated in this release. ([#111485](https://github.com/kubernetes/kubernetes/pull/111485), [@humblec](https://github.com/humblec))
- Improved `kubectl run` and `kubectl debug` error messages upon attaching failures. ([#110764](https://github.com/kubernetes/kubernetes/pull/110764), [@soltysh](https://github.com/soltysh))
- In the event that more than one IngressClass is designated "default", the DefaultIngressClass admission controller will choose one rather than fail. ([#110974](https://github.com/kubernetes/kubernetes/pull/110974), [@kidddddddddddddddddddddd](https://github.com/kidddddddddddddddddddddd)) [SIG Network]
- Kube-proxy: The "userspace" proxy-mode is deprecated on Linux and Windows, despite being the default on Windows.  As of v1.26, the default mode for Windows will change to 'kernelspace'. ([#110762](https://github.com/kubernetes/kubernetes/pull/110762), [@pandaamanda](https://github.com/pandaamanda)) [SIG Network]
- Kubeadm: perform additional dockershim cleanup. Treat all container runtimes as remote by using the flag "--container-runtime=remote", given dockershim was removed in 1.24 and given kubeadm 1.25 supports a kubelet version of 1.24 and 1.25. The flag "--network-plugin" will no longer be used for new clusters. Stop cleaning up the following dockershim related directories on "kubeadm reset": "/var/lib/dockershim", "/var/runkubernetes", "/var/lib/cni" ([#110022](https://github.com/kubernetes/kubernetes/pull/110022), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubelet's deprecated `--experimental-kernel-memcg-notification` flag is now removed.  Use `--kernel-memcg-notification` instead. ([#109388](https://github.com/kubernetes/kubernetes/pull/109388), [@ialidzhikov](https://github.com/ialidzhikov))
- Kubelet: Silenced flag output on errors. ([#110728](https://github.com/kubernetes/kubernetes/pull/110728), [@howardjohn](https://github.com/howardjohn))
- Kubernetes binaries are now built-in `module` mode instead of `GOPATH` mode. ([#109464](https://github.com/kubernetes/kubernetes/pull/109464), [@liggitt](https://github.com/liggitt))
- Removed branch `release-1.20` from prom bot due to EOL. ([#110748](https://github.com/kubernetes/kubernetes/pull/110748), [@cpanato](https://github.com/cpanato))
- Removed deprecated kubectl.kubernetes.io/default-logs-container support ([#109254](https://github.com/kubernetes/kubernetes/pull/109254), [@pacoxu](https://github.com/pacoxu))
- Renamed `apiserver_watch_cache_watch_cache_initializations_total` to `apiserver_watch_cache_initializations_total` ([#109579](https://github.com/kubernetes/kubernetes/pull/109579), [@logicalhan](https://github.com/logicalhan))
- Shell completion is now provided for the "--subresource" flag. ([#109070](https://github.com/kubernetes/kubernetes/pull/109070), [@marckhouzam](https://github.com/marckhouzam))
- Some apiserver metrics were changed, as follows.
  - `priority_level_seat_count_samples` is replaced with `priority_level_seat_utilization`, which samples every nanosecond rather than every millisecond; the old metric conveyed utilization despite its name.
  - `priority_level_seat_count_watermarks` is removed.
  - `priority_level_request_count_samples` is replaced with `priority_level_request_utilization`, which samples every nanosecond rather than every millisecond; the old metric conveyed utilization despite its name.
  - `priority_level_request_count_watermarks` is removed.
  - `read_vs_write_request_count_samples` is replaced with `read_vs_write_current_requests`, which samples every nanosecond rather than every second; the new metric, like the old one, measures utilization when the max-in-flight filter is used and number of requests when the API Priority and Fairness filter is used.
  - `read_vs_write_request_count_watermarks` is removed. ([#110104](https://github.com/kubernetes/kubernetes/pull/110104), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery, Instrumentation and Testing]
- The kube-controller-manager's deprecated `--experimental-cluster-signing-duration` flag is now removed. Adapt your machinery to use the `--cluster-signing-duration` flag that is available since v1.19. ([#108476](https://github.com/kubernetes/kubernetes/pull/108476), [@ialidzhikov](https://github.com/ialidzhikov))
- The kube-scheduler ComponentConfig v1beta2 is deprecated in v1.25. ([#111547](https://github.com/kubernetes/kubernetes/pull/111547), [@kerthcet](https://github.com/kerthcet))
- The kubelet no longer supports collecting accelerator metrics through cAdvisor. The feature gate `DisableAcceleratorUsageMetrics` is now GA and cannot be disabled. ([#110940](https://github.com/kubernetes/kubernetes/pull/110940), [@pacoxu](https://github.com/pacoxu))
- Updated cri-tools to [v1.24.2(https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.24.2). ([#109813](https://github.com/kubernetes/kubernetes/pull/109813), [@saschagrunert](https://github.com/saschagrunert))
- `apiserver_dropped_requests` is dropped from this release since `apiserver_request_total` can now be used to track dropped requests. `etcd_object_counts` is also removed in favor of `apiserver_storage_objects`. `apiserver_registered_watchers` is also removed in favor of `apiserver_longrunning_requests`. ([#110337](https://github.com/kubernetes/kubernetes/pull/110337), [@logicalhan](https://github.com/logicalhan))
- `apiserver_longrunning_gauge` was removed from the codebase. Please use `apiserver_longrunning_requests`
  instead.
   ([#110310](https://github.com/kubernetes/kubernetes/pull/110310), [@logicalhan](https://github.com/logicalhan))
