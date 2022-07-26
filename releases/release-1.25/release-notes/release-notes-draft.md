## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Deprecated beta APIs scheduled for removal in 1.25 are no longer served. See https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25 for more information. ([#108797](https://github.com/kubernetes/kubernetes/pull/108797), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Instrumentation and Testing]
 - End-to-end testing has been migrated from Ginkgo v1 to v2.
  
  When running test/e2e via the Ginkgo CLI, the v2 CLI must be used and `-timeout=24h` (or some other, suitable value) must be passed because the default timeout was reduced from 24h to 1h. When running it via `go test`, the corresponding `-args` parameter is `-ginkgo.timeout=24h`. To build the CLI in the Kubernetes repo, use `make all WHAT=github.com/onsi/ginkgo/v2/ginkgo`.
  Ginkgo V2 doesn't accept go test's `-parallel` flags to parallelize Ginkgo specs, please switch to use `ginkgo -p` or `ginkgo -procs=N` instead. ([#109111](https://github.com/kubernetes/kubernetes/pull/109111), [@chendave](https://github.com/chendave)) [SIG API Machinery, Apps, Architecture, Auth, Autoscaling, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scheduling, Storage, Testing and Windows]
 - No action required; No API/CLI changed; Add new Windows Image Support ([#110333](https://github.com/kubernetes/kubernetes/pull/110333), [@liurupeng](https://github.com/liurupeng)) [SIG Cloud Provider and Windows]
 - There is a new OCI image registry (`registry.k8s.io`) that can be used to pull Kubernetes images. The old registry (`k8s.gcr.io`) will continue to be supported for the foreseeable future, but the new name should perform better because it frontends equivalent mirrors in other clouds.  Please point your clusters to the new registry going forward. \n\nAdmission/Policy integrations that have an allowlist of registries need to include `registry.k8s.io` alongside `k8s.gcr.io`.\nAir-gapped environments and image garbage-collection configurations will need to update to pre-pull and preserve required images under `registry.k8s.io` as well as `k8s.gcr.io`. ([#109938](https://github.com/kubernetes/kubernetes/pull/109938), [@dims](https://github.com/dims))
 
## Changes by Kind

### Deprecation

- Ginkgo.Measure has been deprecated in Ginkgo V2, switch to use gomega/gmeasure instead ([#111065](https://github.com/kubernetes/kubernetes/pull/111065), [@chendave](https://github.com/chendave)) [SIG Autoscaling and Testing]
- Kube-controller-manager: Removed flags  `deleting-pods-qps`, `deleting-pods-burst`, and `register-retry-count`. ([#109612](https://github.com/kubernetes/kubernetes/pull/109612), [@pandaamanda](https://github.com/pandaamanda))
- Kubeadm: during "upgrade apply/diff/node", in case the `ClusterConfiguration.imageRepository` stored in the "kubeadm-config" `ConfigMap` contains the legacy "k8s.gcr.io" repository, modify it to the new default "registry.k8s.io". Reflect the change in the in-cluster `ConfigMap` only during "upgrade apply". ([#110343](https://github.com/kubernetes/kubernetes/pull/110343), [@neolit123](https://github.com/neolit123))
- Kubeadm: graduated the kubeadm specific feature gate `UnversionedKubeletConfigMap` to GA and locked it to `true` by default. The kubelet related ConfigMap and RBAC rules are now locked to have a simplified naming `*kubelet-config` instead of the legacy naming `*kubelet-config-x.yy`, where `x.yy` was the version of the control plane. If you have previously used the old naming format with `UnversionedKubeletConfigMap=false`, you must manually copy the config map from `kube-system/kubelet-config-x.yy` to `kube-system/kubelet-config` before upgrading to `v1.25`. ([#110327](https://github.com/kubernetes/kubernetes/pull/110327), [@neolit123](https://github.com/neolit123))
- Kubeadm: stop applying the `node-role.kubernetes.io/master:NoSchedule` taint to control plane nodes for new clusters. Remove the taint from existing control plane nodes during "kubeadm upgrade apply" ([#110095](https://github.com/kubernetes/kubernetes/pull/110095), [@neolit123](https://github.com/neolit123))
- The `gcp` and `azure` auth plugins have been removed from client-go and kubectl. See https://github.com/Azure/kubelogin and https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke ([#110013](https://github.com/kubernetes/kubernetes/pull/110013), [@enj](https://github.com/enj))
- The beta `PodSecurityPolicy` admission plugin, deprecated since 1.21, is removed. Follow the instructions at https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp/ to migrate to the built-in PodSecurity admission plugin (or to another third-party  policy webhook) prior to upgrading to v1.25. ([#109798](https://github.com/kubernetes/kubernetes/pull/109798), [@liggitt](https://github.com/liggitt))
- Windows winkernel Kube-proxy no longer supports Windows HNS v1 APIs ([#110957](https://github.com/kubernetes/kubernetes/pull/110957), [@papagalu](https://github.com/papagalu)) [SIG Network and Windows]

### API Change

- Add `NodeInclusionPolicy` to `TopologySpreadConstraints` in PodSpec. ([#108492](https://github.com/kubernetes/kubernetes/pull/108492), [@kerthcet](https://github.com/kerthcet))
- Added a new feature gate `CheckpointRestore` to enable support to checkpoint containers. If enabled it is possible to checkpoint a container using the newly kubelet API (/checkpoint/{podNamespace}/{podName}/{containerName}). ([#104907](https://github.com/kubernetes/kubernetes/pull/104907), [@adrianreber](https://github.com/adrianreber)) [SIG Node and Testing]
- EndPort field in Network Policy is now promoted to GA
  
  Network Policy providers that support endPort field now can use it to specify a range of ports to apply a Network Policy.
  
  Previously, each Network Policy could only target a single port.
  
  Please be aware that endPort field MUST BE SUPPORTED by the Network Policy provider. In case your provider does not support endPort and this field is specified in a Network Policy, the Network Policy will be created covering only the port field (single port). ([#110868](https://github.com/kubernetes/kubernetes/pull/110868), [@rikatz](https://github.com/rikatz)) [SIG API Machinery, Network and Testing]
- Make PodSpec.Ports' description clearer on how this information is only informational and how it can be incorrect. ([#110564](https://github.com/kubernetes/kubernetes/pull/110564), [@j4m3s-s](https://github.com/j4m3s-s)) [SIG API Machinery, Network and Node]
- On compatible systems, a mounter's Unmount implementation is changed to not return an error when the specified target can be detected as not a mount point. On Linux, the behavior of detecting a mount point depends on `umount` command is validated when the mounter is created. Additionally, mount point checks will be skipped in CleanupMountPoint/CleanupMountWithForce if the mounter's Unmount having the changed behavior of not returning error when target is not a mount point. ([#109676](https://github.com/kubernetes/kubernetes/pull/109676), [@cartermckinnon](https://github.com/cartermckinnon)) [SIG Storage]
- Promote DaemonSet MaxSurge to GA. This means `--feature-gates=DaemonSetUpdateSurge=true` are not needed on kube-apiserver and kube-controller-manager binaries and they'll be removed soon following policy at https://kubernetes.io/docs/reference/using-api/deprecation-policy/#deprecation ([#111194](https://github.com/kubernetes/kubernetes/pull/111194), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps]
- Promote StatefulSet minReadySeconds to GA. This means `--feature-gates=StatefulSetMinReadySeconds=true` are not needed on kube-apiserver and kube-controller-manager binaries and they'll be removed soon following policy at https://kubernetes.io/docs/reference/using-api/deprecation-policy/#deprecation ([#110896](https://github.com/kubernetes/kubernetes/pull/110896), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG API Machinery, Apps and Testing]
- The Go API for logging configuration in `k8s.io/component-base` was moved to `k8s.io/component-base/logs/api/v1`. The configuration file format and command line flags are the same as before. ([#105797](https://github.com/kubernetes/kubernetes/pull/105797), [@pohly](https://github.com/pohly))
- The Pod `spec.podOS` field is promoted to GA. The `IdentifyPodOS` feature gate unconditionally enabled, and will no longer be accepted as a `--feature-gates` parameter in 1.27. ([#111229](https://github.com/kubernetes/kubernetes/pull/111229), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG API Machinery, Apps and Windows]
- The `PodSecurity` admission plugin has graduated to GA and is enabled by default. The admission configuration version has been promoted to `pod-security.admission.config.k8s.io/v1`. ([#110459](https://github.com/kubernetes/kubernetes/pull/110459), [@wangyysde](https://github.com/wangyysde))
- The `metadata.clusterName` field is completely removed. This should not have any user-visible impact. ([#109602](https://github.com/kubernetes/kubernetes/pull/109602), [@lavalamp](https://github.com/lavalamp))
- The `minDomains` field in Pod Topology Spread is graduated to beta ([#110388](https://github.com/kubernetes/kubernetes/pull/110388), [@sanposhiho](https://github.com/sanposhiho)) [SIG API Machinery and Apps]
- This release added support for `NodeExpandSecret` for CSI driver client which enables the CSI drivers to make use of this secret while performing node expansion operation based on the user request. Previously there was no secret  provided as part of the `nodeexpansion` call, thus CSI drivers did not make use of the same while expanding the volume at the node side. ([#105963](https://github.com/kubernetes/kubernetes/pull/105963), [@zhucan](https://github.com/zhucan))

### Feature

- Added KMS `v2alpha1` API. ([#110201](https://github.com/kubernetes/kubernetes/pull/110201), [@aramase](https://github.com/aramase))
- Added sum feature to `kubectl top pod` ([#105100](https://github.com/kubernetes/kubernetes/pull/105100), [@lauchokyip](https://github.com/lauchokyip))
- Added the `Apply` and `ApplyStatus` methods to the dynamic `ResourceInterface` ([#109443](https://github.com/kubernetes/kubernetes/pull/109443), [@kevindelgado](https://github.com/kevindelgado))
- Feature gate `CSIMigration` was locked to enabled. `CSIMigration` is GA now. The feature gate will be removed in `v1.27`. ([#110410](https://github.com/kubernetes/kubernetes/pull/110410), [@Jiawei0227](https://github.com/Jiawei0227))
- Graduated SeccompDefault to `beta`. The Kubelet feature gate is now enabled by default and the configuration/CLI flag still defaults to `false`. ([#110805](https://github.com/kubernetes/kubernetes/pull/110805), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node and Testing]
- Graduated ServerSideFieldValidation to `beta`. Schema validation is performed server-side and requests will receive warnings for any invalid/unknown fields by default. ([#110178](https://github.com/kubernetes/kubernetes/pull/110178), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Storage and Testing]
- Graduated `ServiceIPStaticSubrange` feature to Beta (disabled by default). ([#110419](https://github.com/kubernetes/kubernetes/pull/110419), [@aojea](https://github.com/aojea))
- In "large" clusters, kube-proxy in iptables mode will now sometimes
  leave unused rules in iptables for a while (up to `--iptables-sync-period`)
  before deleting them. This improves performance by not requiring it to
  check for stale rules on every sync. (In smaller clusters, it will still
  remove unused rules immediately once they are no longer used.)
  
  (The threshold for "large" used here is currently "1000 endpoints" but
  this is subject to change.) ([#110334](https://github.com/kubernetes/kubernetes/pull/110334), [@danwinship](https://github.com/danwinship)) [SIG Network]
- JobTrackingWithFinalizers enabled by default. This feature allows to keep track of the Job progress without relying on Pods staying in the apiserver. ([#110948](https://github.com/kubernetes/kubernetes/pull/110948), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
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
- Lock CSIMigrationAzureDisk feature gate to default. ([#110491](https://github.com/kubernetes/kubernetes/pull/110491), [@andyzhangx](https://github.com/andyzhangx))
- New `KUBECACHEDIR` environment variable was introduced to override default discovery cache directory which is $HOME/.kube/cache ([#109479](https://github.com/kubernetes/kubernetes/pull/109479), [@ardaguclu](https://github.com/ardaguclu))
- Pod SecurityContext and PodSecurityPolicy supports slash as sysctl separator. ([#106834](https://github.com/kubernetes/kubernetes/pull/106834), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Apps, Architecture, Auth, Node, Security and Testing]
- Promoted the `CSIMigrationPortworx` feature gate to Beta. ([#110411](https://github.com/kubernetes/kubernetes/pull/110411), [@trierra](https://github.com/trierra))
- Return a warning when applying a `pod-security.kubernetes.io` label to a PodSecurity-exempted namespace.
  Stop including the `pod-security.kubernetes.io/exempt=namespace` audit annotation on namespace requests. ([#109680](https://github.com/kubernetes/kubernetes/pull/109680), [@tallclair](https://github.com/tallclair))
- The TopologySpreadConstraints will be shown in describe command for pods, deployments, daemonsets, etc. ([#109563](https://github.com/kubernetes/kubernetes/pull/109563), [@ardaguclu](https://github.com/ardaguclu))
- The beta feature `ServiceIPStaticSubrange` is now enabled by default. ([#110703](https://github.com/kubernetes/kubernetes/pull/110703), [@aojea](https://github.com/aojea))
- Updated base image for Windows pause container images to one built on Windows machines to address limitations of building Windows container images on Linux machines. ([#110379](https://github.com/kubernetes/kubernetes/pull/110379), [@marosset](https://github.com/marosset))
- Updated debian-base, debian-iptables, and setcap images:
  - debian-base:bullseye-v1.3.0
  - debian-iptables:bullseye-v1.4.0
  - setcap:bullseye-v1.3.0 ([#110558](https://github.com/kubernetes/kubernetes/pull/110558), [@wespanther](https://github.com/wespanther))
- When using the OpenStack legacy cloud provider, kubelet and KCM will ignore unknown configuration directives rather than failing to start. ([#109709](https://github.com/kubernetes/kubernetes/pull/109709), [@mdbooth](https://github.com/mdbooth))
- `CSIMigrationvSphere` feature is now enabled by default.
   ([#103523](https://github.com/kubernetes/kubernetes/pull/103523), [@divyenpatel](https://github.com/divyenpatel))
- `MaxUnavailable` for `StatefulSets`, allows faster `RollingUpdate` by taking down more than 1 pod at a time. 
  The number of pods you want to take down during a `RollingUpdate` is configurable using `maxUnavailable` parameter.
   ([#109251](https://github.com/kubernetes/kubernetes/pull/109251), [@krmayankk](https://github.com/krmayankk))

### Documentation

- EndpointSlices with Pod referencing Nodes that don't exist couldn't be created or updated. The behavior on the EndpointSlice controller has been modified to update the EndpointSlice without the Pods that reference non-existing Nodes and keep retrying until all Pods reference existing Nodes. However, if `service.Spec.PublishNotReadyAddresses` is set, all the Pods are published without retrying. Fixed EndpointSlices metrics to reflect correctly the number of desired EndpointSlices when no endpoints are present. ([#110639](https://github.com/kubernetes/kubernetes/pull/110639), [@aojea](https://github.com/aojea))
- Optimization of kubectl Chinese translation ([#110538](https://github.com/kubernetes/kubernetes/pull/110538), [@hwdef](https://github.com/hwdef)) [SIG CLI]

### Failing Test

- E2e tests: fixed bug in the e2e image `agnhost:2.38` which hangs instead of exiting if a `SIGTERM` signal is received and the `shutdown-delay` option is `0`. ([#110214](https://github.com/kubernetes/kubernetes/pull/110214), [@aojea](https://github.com/aojea))

### Bug or Regression

- A  bug was fixed where a job sync was not retried in case of a transient ResourceQuota conflict. ([#111026](https://github.com/kubernetes/kubernetes/pull/111026), [@alculquicondor](https://github.com/alculquicondor))
- A change of a failed job condition status to `False` does not result in duplicate conditions. ([#110292](https://github.com/kubernetes/kubernetes/pull/110292), [@mimowo](https://github.com/mimowo))
- Added the latest GCE pinhole firewall feature, which introduces `destination-ranges` in the ingress `firewall-rules`. It restricts access to the backend IPs by allowing traffic through `ILB` or `NetLB` only. This change does **NOT** change the existing `ILB` or `NetLB` behavior. ([#109510](https://github.com/kubernetes/kubernetes/pull/109510), [@sugangli](https://github.com/sugangli))
- Adds error message "dry-run can not be used when --force is set" when dry-run and force flags are set in replace command. ([#110326](https://github.com/kubernetes/kubernetes/pull/110326), [@ardaguclu](https://github.com/ardaguclu)) [SIG CLI]
- Allow expansion of ephemeral volumes ([#109987](https://github.com/kubernetes/kubernetes/pull/109987), [@gnufied](https://github.com/gnufied)) [SIG Node and Storage]
- Apiserver: fixed audit of loading more than one webhooks. ([#110145](https://github.com/kubernetes/kubernetes/pull/110145), [@sxllwx](https://github.com/sxllwx))
- Bug fix in test/e2e/framework  Framework.RecordFlakeIfError ([#111048](https://github.com/kubernetes/kubernetes/pull/111048), [@alingse](https://github.com/alingse)) [SIG Testing]
- Client-go: fixed an error in the fake client when creating API requests are submitted to subresources like `pods/eviction`. ([#110425](https://github.com/kubernetes/kubernetes/pull/110425), [@LY-today](https://github.com/LY-today))
- Do not raise an error when setting a label with the same value, ignore it. ([#105936](https://github.com/kubernetes/kubernetes/pull/105936), [@zigarn](https://github.com/zigarn))
- Do not report terminated container metrics ([#110950](https://github.com/kubernetes/kubernetes/pull/110950), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Node]
- EndpointSlices marked for deletion are now ignored during reconciliation. ([#109624](https://github.com/kubernetes/kubernetes/pull/109624), [@aryan9600](https://github.com/aryan9600)) [SIG Apps and Network]
- Etcd: Update to v3.5.4 ([#110033](https://github.com/kubernetes/kubernetes/pull/110033), [@mk46](https://github.com/mk46)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
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
- Fixed `JobTrackingWithFinalizers` that:
  - was declaring a job finished before counting all the created pods in the status
  - was leaving pods with finalizers, blocking pod and job deletions
   `JobTrackingWithFinalizers` is still disabled by default. ([#109486](https://github.com/kubernetes/kubernetes/pull/109486), [@alculquicondor](https://github.com/alculquicondor))
- Fixed a bug in `kubectl` that caused the wrong result length when using `--chunk-size` and `--selector` together. ([#110652](https://github.com/kubernetes/kubernetes/pull/110652), [@Abirdcfly](https://github.com/Abirdcfly))
- Fixed a bug involving Services of type `LoadBalancer` with multiple IPs and a `LoadBalancerSourceRanges` that overlaps the node IP. ([#109826](https://github.com/kubernetes/kubernetes/pull/109826), [@danwinship](https://github.com/danwinship))
- Fixed a kubelet issue that could result in invalid pod status updates to be sent to the api-server where pods would be reported in a terminal phase but also report a ready condition of true in some cases. ([#110256](https://github.com/kubernetes/kubernetes/pull/110256), [@bobbypage](https://github.com/bobbypage))
- Fixed an issue on Windows nodes where `HostProcess` containers may not be created as expected. ([#110140](https://github.com/kubernetes/kubernetes/pull/110140), [@marosset](https://github.com/marosset))
- Fixed bug where CSI migration doesn't count inline volumes for attach limit. ([#107787](https://github.com/kubernetes/kubernetes/pull/107787), [@Jiawei0227](https://github.com/Jiawei0227))
- Fixed error "dbus: connection closed by user" after dbus daemon restarts. ([#110496](https://github.com/kubernetes/kubernetes/pull/110496), [@kolyshkin](https://github.com/kolyshkin))
- Fixed image pull failure when `IMDS` is unavailable in kubelet startup. ([#110523](https://github.com/kubernetes/kubernetes/pull/110523), [@andyzhangx](https://github.com/andyzhangx))
- Fixed scheduling of **CronJob** with `@every X` schedules. ([#109250](https://github.com/kubernetes/kubernetes/pull/109250), [@d-honeybadger](https://github.com/d-honeybadger))
- Fixed strict server-side field validation treating `metadata` fields as unknown fields. ([#109268](https://github.com/kubernetes/kubernetes/pull/109268), [@liggitt](https://github.com/liggitt))
- Fixed the bug that a `ServiceIPStaticSubrange` enabled cluster assigns duplicate IP addresses when the dynamic block is exhausted. ([#109928](https://github.com/kubernetes/kubernetes/pull/109928), [@tksm](https://github.com/tksm))
- For scheduler plugin developers: the scheduler framework's shared PodInformer is now initialized with empty indexers. This enables scheduler plugins to add their extra indexers. Note that only non-conflict indexers are allowed to be added. ([#110663](https://github.com/kubernetes/kubernetes/pull/110663), [@fromanirh](https://github.com/fromanirh)) [SIG Scheduling]
- If the parent directory of the file specified in the `--audit-log-path` argument does not exist, Kubernetes now creates it. ([#110813](https://github.com/kubernetes/kubernetes/pull/110813), [@vpnachev](https://github.com/vpnachev)) [SIG Auth]
- Informer/reflector callers can now catch and unwrap specific API errors by type. ([#110076](https://github.com/kubernetes/kubernetes/pull/110076), [@karlkfi](https://github.com/karlkfi))
- Kube-apiserver: Get, GetList and Watch requests that should be served by the apiserver cacher during shutdown will be rejected to avoid a deadlock situation leaving requests hanging. ([#108414](https://github.com/kubernetes/kubernetes/pull/108414), [@aojea](https://github.com/aojea))
- Kubeadm: Fixed duplicate `unix://` prefix in node annotation. ([#110656](https://github.com/kubernetes/kubernetes/pull/110656), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: a bug was fixed due to which configurable `KubernetesVersion` was not being respected during kubeadm join. ([#110791](https://github.com/kubernetes/kubernetes/pull/110791), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: now sets the host `OS` environment variables when executing `crictl` during image pulls. This fixed a bug where `*PROXY` environment variables did not affect `crictl` internet connectivity. ([#110134](https://github.com/kubernetes/kubernetes/pull/110134), [@mk46](https://github.com/mk46))
- Kubeadm: only taint control plane nodes when the legacy "master" taint is present. This avoids the bug where "kubeadm upgrade" will re-taint a control plane  node with the new "control plane" taint even if the user explicitly untainted the node. ([#109840](https://github.com/kubernetes/kubernetes/pull/109840), [@neolit123](https://github.com/neolit123))
- Kubeadm: respect user specified image repository when using Kubernetes ci version ([#111017](https://github.com/kubernetes/kubernetes/pull/111017), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: support retry mechanism for removing container in reset phase ([#110837](https://github.com/kubernetes/kubernetes/pull/110837), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubelet: added retry of checking Unix domain sockets on Windows nodes for the plugin registration mechanism. ([#110075](https://github.com/kubernetes/kubernetes/pull/110075), [@luckerby](https://github.com/luckerby))
- Kubelet: wait for node allocatable ephemeral-storage data. ([#101882](https://github.com/kubernetes/kubernetes/pull/101882), [@jackfrancis](https://github.com/jackfrancis))
- Kubernetes now correctly handles "search ." in the host's resolv.conf file by preserving the "." entry in the "resolv.conf" that the kubelet writes to pods. ([#109441](https://github.com/kubernetes/kubernetes/pull/109441), [@Miciah](https://github.com/Miciah)) [SIG Network and Node]
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
- Removed unused flags from `kubectl run` command. ([#110668](https://github.com/kubernetes/kubernetes/pull/110668), [@brianpursley](https://github.com/brianpursley))
- Run kubelet, when there is an error exit, print the error log ([#110691](https://github.com/kubernetes/kubernetes/pull/110691), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Node]
- The commands `kubeadm certs renew` and `kubeadm certs check-expiration` now honor the `cert-dir` flag on a running Kubernetes cluster. ([#110709](https://github.com/kubernetes/kubernetes/pull/110709), [@chendave](https://github.com/chendave))
- The kube-proxy `sync_proxy_rules_no_endpoints_total` metric now only counts local-traffic-policy services which have remote endpoints but not local endpoints. ([#109782](https://github.com/kubernetes/kubernetes/pull/109782), [@danwinship](https://github.com/danwinship))
- The node annotation alpha.kubernetes.io/provided-node-ip is no longer set ONLY when `--cloud-provider=external`.  Now, it is set on kubelet startup if the `--cloud-provider` flag is set at all, including the deprecated in-tree providers. ([#109794](https://github.com/kubernetes/kubernetes/pull/109794), [@mdbooth](https://github.com/mdbooth)) [SIG Network and Node]
- The pod phase lifecycle guarantees that terminal Pods, those whose states are `Unready` or `Succeeded`, can not regress and will have all container stopped. Hence, terminal Pods will never be reachable and should not publish their IP addresses on the `Endpoints` or `EndpointSlices`, independently of the Service `TolerateUnready` option. ([#110255](https://github.com/kubernetes/kubernetes/pull/110255), [@robscott](https://github.com/robscott))
- This change fixes the gce firewall update when the destination IPs are changing so that firewalls reflect the IP updates of the LBs. ([#111186](https://github.com/kubernetes/kubernetes/pull/111186), [@sugangli](https://github.com/sugangli)) [SIG Cloud Provider]
- Upgrade Azure/go-autorest/autorest to v0.11.27 ([#110371](https://github.com/kubernetes/kubernetes/pull/110371), [@andyzhangx](https://github.com/andyzhangx))
- Volumes are no longer detached from healthy nodes after 6 minutes timeout. 6 minute force-detach timeout is used only for unhealthy nodes (`node.status.conditions["Ready"]!= true`). ([#110721](https://github.com/kubernetes/kubernetes/pull/110721), [@jsafrane](https://github.com/jsafrane))
- When metrics are counted, discard the wrong container StartTime metrics ([#110880](https://github.com/kubernetes/kubernetes/pull/110880), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Instrumentation and Node]
- [aws] Fixed a bug which reduces the number of unnecessary calls to STS in the event of assume role failures in the legacy cloud provider ([#110706](https://github.com/kubernetes/kubernetes/pull/110706), [@prateekgogia](https://github.com/prateekgogia)) [SIG Cloud Provider]
- `pod.Spec.RuntimeClassName` field is now available in kubectl describe command. ([#110914](https://github.com/kubernetes/kubernetes/pull/110914), [@yeahdongcn](https://github.com/yeahdongcn))

### Other (Cleanup or Flake)

- Add missing powershell option to kubectl completion command short description. ([#109773](https://github.com/kubernetes/kubernetes/pull/109773), [@danielhelfand](https://github.com/danielhelfand))
- Change PV framework delete timeout to 5 minutes as documented ([#109764](https://github.com/kubernetes/kubernetes/pull/109764), [@saikat-royc](https://github.com/saikat-royc))
- Deleted the `apimachinery/clock` package. Please use `k8s.io/utils/clock` package instead. ([#109752](https://github.com/kubernetes/kubernetes/pull/109752), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Feature gates that graduated to GA in 1.23 or earlier and were unconditionally enabled have been removed: CSIServiceAccountToken, ConfigurableFSGroupPolicy, EndpointSlice, EndpointSliceNodeName, EndpointSliceProxying, GenericEphemeralVolume, IPv6DualStack, IngressClassNamespacedParams, StorageObjectInUseProtection, TTLAfterFinished, VolumeSubpath, WindowsEndpointSliceProxying. ([#109435](https://github.com/kubernetes/kubernetes/pull/109435), [@pohly](https://github.com/pohly))
- For resources built into an apiserver, the server now logs at `-v=3` whether it is using watch caching. ([#109175](https://github.com/kubernetes/kubernetes/pull/109175), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
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
- Some apiserver metrics were changed, as follows.
  - `priority_level_seat_count_samples` is replaced with `priority_level_seat_utilization`, which samples every nanosecond rather than every millisecond; the old metric conveyed utilization despite its name.
  - `priority_level_seat_count_watermarks` is removed.
  - `priority_level_request_count_samples` is replaced with `priority_level_request_utilization`, which samples every nanosecond rather than every millisecond; the old metric conveyed utilization despite its name.
  - `priority_level_request_count_watermarks` is removed.
  - `read_vs_write_request_count_samples` is replaced with `read_vs_write_current_requests`, which samples every nanosecond rather than every second; the new metric, like the old one, measures utilization when the max-in-flight filter is used and number of requests when the API Priority and Fairness filter is used.
  - `read_vs_write_request_count_watermarks` is removed. ([#110104](https://github.com/kubernetes/kubernetes/pull/110104), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery, Instrumentation and Testing]
- The kube-controller-manager's deprecated `--experimental-cluster-signing-duration` flag is now removed. Adapt your machinery to use the `--cluster-signing-duration` flag that is available since v1.19. ([#108476](https://github.com/kubernetes/kubernetes/pull/108476), [@ialidzhikov](https://github.com/ialidzhikov))
- Updated cri-tools to [v1.24.2(https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.24.2) ([#109813](https://github.com/kubernetes/kubernetes/pull/109813), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Node and Release]
- `apiserver_dropped_requests` is dropped from this release since `apiserver_request_total` can now be used to track dropped requests. `etcd_object_counts` is also removed in favor of `apiserver_storage_objects`. `apiserver_registered_watchers` is also removed in favor of `apiserver_longrunning_requests`. ([#110337](https://github.com/kubernetes/kubernetes/pull/110337), [@logicalhan](https://github.com/logicalhan))
- `apiserver_longrunning_gauge` was removed from the codebase. Please use `apiserver_longrunning_requests`
  instead.
   ([#110310](https://github.com/kubernetes/kubernetes/pull/110310), [@logicalhan](https://github.com/logicalhan))