## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Deprecated beta APIs scheduled for removal in 1.25 are no longer served. See https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25 for more information. ([#108797](https://github.com/kubernetes/kubernetes/pull/108797), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Instrumentation and Testing]
 - No action required; No API/CLI changed; Add new Windows Image Support ([#110333](https://github.com/kubernetes/kubernetes/pull/110333), [@liurupeng](https://github.com/liurupeng)) [SIG Cloud Provider and Windows]
 - There is a new OCI image registry (registry.k8s.io) that can be used to pull kubernetes images. The old registry (k8s.gcr.io) will continue to be supported for the foreseeable future, but the new name should perform better because it frontends equivalent mirrors in other clouds.  Please point your clusters to the new registry going forward. 
  
  Admission/Policy integrations that have an allowlist of registries need to include "registry.k8s.io" alongside "k8s.gcr.io".
  Air-gapped environments and image garbage-collection configurations will need to update to pre-pull and preserve required images under "registry.k8s.io" as well as "k8s.gcr.io". ([#109938](https://github.com/kubernetes/kubernetes/pull/109938), [@dims](https://github.com/dims))
 
## Changes by Kind

### Deprecation

- Kube-controller-manager:  'deleting-pods-qps'  'deleting-pods-burst'  'register-retry-count' flags are removed. ([#109612](https://github.com/kubernetes/kubernetes/pull/109612), [@pandaamanda](https://github.com/pandaamanda))
- Kubeadm: during "upgrade apply/diff/node", in case the `ClusterConfiguration.imageRepository` stored in the "kubeadm-config" `ConfigMap` contains the legacy "k8s.gcr.io" repository, modify it to the new default "registry.k8s.io". Reflect the change in the in-cluster `ConfigMap` only during "upgrade apply". ([#110343](https://github.com/kubernetes/kubernetes/pull/110343), [@neolit123](https://github.com/neolit123))
- Kubeadm: graduate the kubeadm specific feature gate UnversionedKubeletConfigMap to GA and lock it to "true" by default. The kubelet related ConfigMap and RBAC rules are now locked to have a simplified naming "*kubelet-config" instead of the legacy naming "*kubelet-config-x.yy", where "x.yy" was the version of the control plane. If you have previously used the old naming format with UnversionedKubeletConfigMap=false, you must manually copy the config map from kube-system/kubelet-config-x.yy to kube-system/kubelet-config before upgrading to 1.25. ([#110327](https://github.com/kubernetes/kubernetes/pull/110327), [@neolit123](https://github.com/neolit123))
- Kubeadm: stop applying the `node-role.kubernetes.io/master:NoSchedule` taint to control plane nodes for new clusters. Remove the taint from existing control plane nodes during "kubeadm upgrade apply" ([#110095](https://github.com/kubernetes/kubernetes/pull/110095), [@neolit123](https://github.com/neolit123))
- The `gcp` and `azure` auth plugins have been removed from client-go and kubectl. See https://github.com/Azure/kubelogin and https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke ([#110013](https://github.com/kubernetes/kubernetes/pull/110013), [@enj](https://github.com/enj))
- The beta `PodSecurityPolicy` admission plugin, deprecated since 1.21, is removed. Follow the instructions at https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp/ to migrate to the built-in PodSecurity admission plugin (or to another third-party  policy webhook) prior to upgrading to v1.25. ([#109798](https://github.com/kubernetes/kubernetes/pull/109798), [@liggitt](https://github.com/liggitt))

### API Change

- Add `NodeInclusionPolicy` to `TopologySpreadConstraints` in PodSpec. ([#108492](https://github.com/kubernetes/kubernetes/pull/108492), [@kerthcet](https://github.com/kerthcet))
- The Go API for logging configuration in k8s.io/component-base was moved to k8s.io/component-base/logs/api/v1. The configuration file format and command line flags are the same as before. ([#105797](https://github.com/kubernetes/kubernetes/pull/105797), [@pohly](https://github.com/pohly))
- The PodSecurity admission plugin has graduated to GA and is enabled by default. The admission configuration version has been promoted to `pod-security.admission.config.k8s.io/v1`. ([#110459](https://github.com/kubernetes/kubernetes/pull/110459), [@wangyysde](https://github.com/wangyysde))
- The `metadata.clusterName` field is completely removed. This should not have any user-visible impact. ([#109602](https://github.com/kubernetes/kubernetes/pull/109602), [@lavalamp](https://github.com/lavalamp))
- This release add support for NodeExpandSecret for CSI driver client which enables the CSI drivers to make use of this secret while performing node expansion operation based on the user request. Previously there was no secret  provided as part of the nodeexpansion call, thus CSI drivers were not make use of the same while expanding the volume at node side. ([#105963](https://github.com/kubernetes/kubernetes/pull/105963), [@zhucan](https://github.com/zhucan))

### Feature

- Added sum feature to `kubectl top pod` ([#105100](https://github.com/kubernetes/kubernetes/pull/105100), [@lauchokyip](https://github.com/lauchokyip))
- Added the `Apply` and `ApplyStatus` methods to the dynamic `ResourceInterface` ([#109443](https://github.com/kubernetes/kubernetes/pull/109443), [@kevindelgado](https://github.com/kevindelgado))
- Adds KMS v2alpha1 API. ([#110201](https://github.com/kubernetes/kubernetes/pull/110201), [@aramase](https://github.com/aramase))
- Feature gate `CSIMigration` is locked to enabled. CSIMigration is GA now.The feature gate will be removed in 1.27. ([#110410](https://github.com/kubernetes/kubernetes/pull/110410), [@Jiawei0227](https://github.com/Jiawei0227))
- Graduate ServiceIPStaticSubrange feature to beta (disabled by default). ([#110419](https://github.com/kubernetes/kubernetes/pull/110419), [@aojea](https://github.com/aojea))
- Kube-up now includes CoreDNS version v1.9.3. ([#110488](https://github.com/kubernetes/kubernetes/pull/110488), [@mzaian](https://github.com/mzaian))
- Kubeadm: Add support for additional authentication strategies in `kubeadm join` with discovery/kubeconfig file: client-go authentication plugins (`exec`), `tokenFile`, and `authProvider.` ([#110553](https://github.com/kubernetes/kubernetes/pull/110553), [@tallaxes](https://github.com/tallaxes))
- Kubeadm: Update CoreDNS to v1.9.3. ([#110489](https://github.com/kubernetes/kubernetes/pull/110489), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: add support for the flag "--print-manifest" to the addon phases "kube-proxy" and "coredns" of "kubeadm init phase addon". If this flag is usedkubeadm will not apply a given addon and instead print to the terminal the API objects that will be applied. ([#109995](https://github.com/kubernetes/kubernetes/pull/109995), [@wangyysde](https://github.com/wangyysde))
- Kubeadm: enhance the "patches" functionality to be able to patch kubelet config files containing v1beta1.KubeletConfiguration. The new patch target is called "kubeletconfiguration" (e.g. patch file "kubeletconfiguration+json.json").This makes it possible to apply node specific KubeletConfiguration options during "init", "join" and "upgrade", while the main KubeletConfiguration that is passed to "init" as part of the "--config" file can still act as the global / stored in the cluster KubeletConfiguration. ([#110405](https://github.com/kubernetes/kubernetes/pull/110405), [@neolit123](https://github.com/neolit123))
- Kubeadm: modify the etcd static Pod liveness and readyness probes to use a new etcd 3.5.3+ HTTP(s) health check endpoint "/health?serializable=true" that allows to track the health of individual etcd members and not fail all members if a single member is not healthy in the etcd cluster. ([#110072](https://github.com/kubernetes/kubernetes/pull/110072), [@neolit123](https://github.com/neolit123))
- Kubeadm: support experimental JSON/YAML output for "kubeadm upgrade plan" with the "--output" flag ([#108447](https://github.com/kubernetes/kubernetes/pull/108447), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: the preferred pod anti-affinity for CoreDNS is now enabled by default ([#110593](https://github.com/kubernetes/kubernetes/pull/110593), [@SataQiu](https://github.com/SataQiu))
- Kubectl: support multiple resources for kubectl rollout status. ([#108777](https://github.com/kubernetes/kubernetes/pull/108777), [@pjo256](https://github.com/pjo256))
- Kubernetes is now built with Golang 1.18.2. ([#110043](https://github.com/kubernetes/kubernetes/pull/110043), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Golang 1.18.3 ([#110421](https://github.com/kubernetes/kubernetes/pull/110421), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Lock CSIMigrationAzureDisk feature gate to default. ([#110491](https://github.com/kubernetes/kubernetes/pull/110491), [@andyzhangx](https://github.com/andyzhangx))
- MaxUnavailable for StatefulSets, allows faster RollingUpdate by taking down more than 1 pod at a time. The number of pods you want to take down during a RollingUpdate is configurable using maxUnavailable parameter. ([#109251](https://github.com/kubernetes/kubernetes/pull/109251), [@krmayankk](https://github.com/krmayankk))
- Promote the CSIMigrationPortworx feature gate to Beta. ([#110411](https://github.com/kubernetes/kubernetes/pull/110411), [@trierra](https://github.com/trierra))
- Return a warning when applying a `pod-security.kubernetes.io` label to a PodSecurity-exempted namespace.
  Stop including the `pod-security.kubernetes.io/exempt=namespace` audit annotation on namespace requests. ([#109680](https://github.com/kubernetes/kubernetes/pull/109680), [@tallclair](https://github.com/tallclair))
- The TopologySpreadConstraints will be shown in describe command for pods, deployments, daemonsets, etc. ([#109563](https://github.com/kubernetes/kubernetes/pull/109563), [@ardaguclu](https://github.com/ardaguclu))
- Updat debian-base, debian-iptables, and setcap images:
  - debian-base:bullseye-v1.3.0
  - debian-iptables:bullseye-v1.4.0
  - setcap:bullseye-v1.3.0 ([#110558](https://github.com/kubernetes/kubernetes/pull/110558), [@wespanther](https://github.com/wespanther))
- Update base image for Windows pause container images to one built on Windows machines to address limitations of building Windows container images on Linux machines. ([#110379](https://github.com/kubernetes/kubernetes/pull/110379), [@marosset](https://github.com/marosset))
- When using the OpenStack legacy cloud provider, kubelet and KCM will ignore unknown configuration directives rather than failing to start. ([#109709](https://github.com/kubernetes/kubernetes/pull/109709), [@mdbooth](https://github.com/mdbooth))

### Documentation

- EndpointSlices with Pod referencing Nodes that doesn't exist couldn't be created or updated.The behavior on the EndpointSlice controller has been modified to update the EndpointSlice without the Pods that reference non-existing Nodes, and keep retrying until all Pods reference existing Nodes.However, if service.Spec.PublishNotReadyAddresses is set, all the Pods are published without retrying.Fixed EndpointSlices metrics to reflect correctly the number of desired EndpointSlices when no endpoints are present. ([#110639](https://github.com/kubernetes/kubernetes/pull/110639), [@aojea](https://github.com/aojea))

### Failing Test

- E2e tests: fix bug in the e2e image agnhost:2.38 which hangs instead of exiting if a SIGTERM signal is received and the shutdown-delay option is 0` ([#110214](https://github.com/kubernetes/kubernetes/pull/110214), [@aojea](https://github.com/aojea))
- In-tree GCE PD test cases no longer run in Kubernetes testing harness anymore (side effect of switching on csi migration in 1.22). Please switch on environment variable ENABLE_STORAGE_GCE_PD_DRIVER to "yes" if you need to run these tests. ([#109541](https://github.com/kubernetes/kubernetes/pull/109541), [@dims](https://github.com/dims))

### Bug or Regression

- A change of a failed job condition status to `False` does not result in duplicate conditions. ([#110292](https://github.com/kubernetes/kubernetes/pull/110292), [@mimowo](https://github.com/mimowo))
- Allow expansion of ephemeral volumes ([#109987](https://github.com/kubernetes/kubernetes/pull/109987), [@gnufied](https://github.com/gnufied)) [SIG Node and Storage]
- Apiserver: fix audit of loading more than one webhooks. ([#110145](https://github.com/kubernetes/kubernetes/pull/110145), [@sxllwx](https://github.com/sxllwx))
- Client-go: fix an error in the fake client when create API requests are submitted to subresources like pods/eviction ([#110425](https://github.com/kubernetes/kubernetes/pull/110425), [@LY-today](https://github.com/LY-today))
- Do not raise an error when setting a label with the same value, ignore it. ([#105936](https://github.com/kubernetes/kubernetes/pull/105936), [@zigarn](https://github.com/zigarn))
- EndpointSlices marked for deletion are now ignored during reconciliation. ([#109624](https://github.com/kubernetes/kubernetes/pull/109624), [@aryan9600](https://github.com/aryan9600)) [SIG Apps and Network]
- Etcd: Update to v3.5.4 ([#110033](https://github.com/kubernetes/kubernetes/pull/110033), [@mk46](https://github.com/mk46)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- FibreChannel volume plugin may match the wrong device and wrong associated devicemapper parent.This may cause a disater that pods attach wrong disks. ([#110719](https://github.com/kubernetes/kubernetes/pull/110719), [@xakdwch](https://github.com/xakdwch))
- Fix "dbus: connection closed by user" error after dbus daemon restart. ([#110496](https://github.com/kubernetes/kubernetes/pull/110496), [@kolyshkin](https://github.com/kolyshkin))
- Fix JobTrackingWithFinalizers that:
  - was declaring a job finished before counting all the created pods in the status
  - was leaving pods with finalizers, blocking pod and job deletions
   JobTrackingWithFinalizers is still disabled by default. ([#109486](https://github.com/kubernetes/kubernetes/pull/109486), [@alculquicondor](https://github.com/alculquicondor))
- Fix a bug involving Services of type LoadBalancer with multiple IPs and a LoadBalancerSourceRanges that overlaps the node IP. ([#109826](https://github.com/kubernetes/kubernetes/pull/109826), [@danwinship](https://github.com/danwinship))
- Fix a bug that caused the wrong result length when using --chunk-size and --selector together. ([#110652](https://github.com/kubernetes/kubernetes/pull/110652), [@Abirdcfly](https://github.com/Abirdcfly))
- Fix a bug where CRI implementations that use cAdvisor stats provider (CRI-O) don't evict pods when their logs exceed ephemeral storage limit. ([#108115](https://github.com/kubernetes/kubernetes/pull/108115), [@haircommander](https://github.com/haircommander)) [SIG Node]
- Fix a bug where metrics are not recorded during Preemption(PostFilter). ([#108727](https://github.com/kubernetes/kubernetes/pull/108727), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Fix a data race in authentication between AuthenticatedGroupAdder and cached token authenticator. ([#109969](https://github.com/kubernetes/kubernetes/pull/109969), [@sttts](https://github.com/sttts)) [SIG API Machinery and Auth]
- Fix a kubelet issue that could result in invalid pod status updates to be sent to the api-server where pods would be reported in a terminal phase but also report a ready condition of true in some cases. ([#110256](https://github.com/kubernetes/kubernetes/pull/110256), [@bobbypage](https://github.com/bobbypage))
- Fix an issue on Windows nodes where HostProcess containers may not be created as expected. ([#110140](https://github.com/kubernetes/kubernetes/pull/110140), [@marosset](https://github.com/marosset))
- Fix bug that prevented the job controller from enforcing activeDeadlineSeconds when set. ([#110294](https://github.com/kubernetes/kubernetes/pull/110294), [@harshanarayana](https://github.com/harshanarayana))
- Fix for volume reconstruction of CSI ephemeral volumes ([#108997](https://github.com/kubernetes/kubernetes/pull/108997), [@dobsonj](https://github.com/dobsonj)) [SIG Node, Storage and Testing]
- Fix image pulling failure when IMDS is unavailable in kubelet startup. ([#110523](https://github.com/kubernetes/kubernetes/pull/110523), [@andyzhangx](https://github.com/andyzhangx))
- Fix incorrectly report scope for request_duration_seconds and request_slo_duration_seconds metrics for POST custom resources API calls. ([#110009](https://github.com/kubernetes/kubernetes/pull/110009), [@azylinski](https://github.com/azylinski)) [SIG Instrumentation]
- Fix printing resources with int64 fields ([#110408](https://github.com/kubernetes/kubernetes/pull/110408), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Fix scheduling of cronjobs with @every X schedules. ([#109250](https://github.com/kubernetes/kubernetes/pull/109250), [@d-honeybadger](https://github.com/d-honeybadger))
- Fix spurious kube-apiserver log warnings related to openapi v3 merging when creating or modifying CustomResourceDefinition objects ([#109880](https://github.com/kubernetes/kubernetes/pull/109880), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery and Testing]
- Fix strict server-side field validation treating metadata fields as unknown fields. ([#109268](https://github.com/kubernetes/kubernetes/pull/109268), [@liggitt](https://github.com/liggitt))
- Fix the bug that a ServiceIPStaticSubrange enabled cluster assigns duplicate IP addresses when dynamic block is exhausted. ([#109928](https://github.com/kubernetes/kubernetes/pull/109928), [@tksm](https://github.com/tksm))
- Fix the bug that reported incorrect metrics for the cluster IP allocator. ([#110027](https://github.com/kubernetes/kubernetes/pull/110027), [@tksm](https://github.com/tksm))
- Fix the bug where CSI migration doesn't count inline volumes for attach limit. ([#107787](https://github.com/kubernetes/kubernetes/pull/107787), [@Jiawei0227](https://github.com/Jiawei0227))
- Fix: NeedResize build failure on Windows ([#109721](https://github.com/kubernetes/kubernetes/pull/109721), [@andyzhangx](https://github.com/andyzhangx))
- Informer/reflector callers can now catch and unwrap specific API errors by type. ([#110076](https://github.com/kubernetes/kubernetes/pull/110076), [@karlkfi](https://github.com/karlkfi))
- Kube-apiserver: Get, GetList and Watch requests that should be served by the apiserver cacher during shutdown will be rejected to avoid a deadlock situation leaving requests hanging. ([#108414](https://github.com/kubernetes/kubernetes/pull/108414), [@aojea](https://github.com/aojea))
- Kubeadm: handle dup `unix://` prefix in node annotation ([#110656](https://github.com/kubernetes/kubernetes/pull/110656), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: only taint control plane nodes when the legacy "master" taint is present. This avoids the bug where "kubeadm upgrade" will re-taint a control plane  node with the new "control plane" taint even if the user explicitly untainted the node. ([#109840](https://github.com/kubernetes/kubernetes/pull/109840), [@neolit123](https://github.com/neolit123))
- Kubeadm: pass the host OS environment variables when executing "crictl" during image pulls. This fixes a bug where *PROXY environment variables did not affect crictl's internet connectivity. ([#110134](https://github.com/kubernetes/kubernetes/pull/110134), [@mk46](https://github.com/mk46))
- Kubelet: add retry of checking Unix domain sockets on Windows nodes for the plugin registration mechanism ([#110075](https://github.com/kubernetes/kubernetes/pull/110075), [@luckerby](https://github.com/luckerby))
- Kubelet: wait for node allocatable ephemeral-storage data ([#101882](https://github.com/kubernetes/kubernetes/pull/101882), [@jackfrancis](https://github.com/jackfrancis))
- Kubernetes now correctly handles "search ." in the host's resolv.conf file by preserving the "." entry in the "resolv.conf" that the kubelet writes to pods. ([#109441](https://github.com/kubernetes/kubernetes/pull/109441), [@Miciah](https://github.com/Miciah)) [SIG Network and Node]
- ManagedFields time is correctly updated when the value of a managed field is modified. ([#110058](https://github.com/kubernetes/kubernetes/pull/110058), [@glebiller](https://github.com/glebiller))
- OpenAPI will no longer duplicate these schemas:
  - io.k8s.apimachinery.pkg.apis.meta.v1.DeleteOptions_v2
  - io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta_v2
  - io.k8s.apimachinery.pkg.apis.meta.v1.OwnerReference_v2
  - io.k8s.apimachinery.pkg.apis.meta.v1.StatusDetails_v2
  - io.k8s.apimachinery.pkg.apis.meta.v1.Status_v2 ([#110179](https://github.com/kubernetes/kubernetes/pull/110179), [@Jefftree](https://github.com/Jefftree))
- Panics while calling validating admission webhook are caught and honor the fail open or fail closed setting. ([#108746](https://github.com/kubernetes/kubernetes/pull/108746), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- Pods will now post their readiness during termination. ([#110191](https://github.com/kubernetes/kubernetes/pull/110191), [@rphillips](https://github.com/rphillips))
- Reduced time taken to sync proxy rules on Windows kube-proxy with kernelspace mode. ([#109124](https://github.com/kubernetes/kubernetes/pull/109124), [@daschott](https://github.com/daschott))
- Remove unused flags from kubectl run command. ([#110668](https://github.com/kubernetes/kubernetes/pull/110668), [@brianpursley](https://github.com/brianpursley))
- The kube-proxy `sync_proxy_rules_no_endpoints_total` metric now only counts local-traffic-policy services which have remote endpoints but not local endpoints. ([#109782](https://github.com/kubernetes/kubernetes/pull/109782), [@danwinship](https://github.com/danwinship))
- The pod phase lifecycle guarantees that terminal Pods, those whose states are `Unready` or `Succeeded`, can not regress and will have all container stopped. Hence, terminal Pods will never be reachable and should not publish their IP addresses on the `Endpoints` or `EndpointSlices`, independently of the Service `TolerateUnready` option. ([#110255](https://github.com/kubernetes/kubernetes/pull/110255), [@robscott](https://github.com/robscott))
- This change picks up the latest GCE pinhole firewall feature, which introduces destination-ranges in the ingress firewall-rules. It restricts the access to the backend IPs via allowing traffic via allowing traffic through ILB or NetLB IP only. This change does NOT change the existing ILB or NetLB behavior. ([#109510](https://github.com/kubernetes/kubernetes/pull/109510), [@sugangli](https://github.com/sugangli))
- Updated to cAdvisor v0.44.1 to fix an issue where metrics generated by kubelet for pod network stats were empty in some cases. ([#109658](https://github.com/kubernetes/kubernetes/pull/109658), [@bobbypage](https://github.com/bobbypage))
- Upgrade Azure/go-autorest/autorest to v0.11.27 ([#110371](https://github.com/kubernetes/kubernetes/pull/110371), [@andyzhangx](https://github.com/andyzhangx))
- Volumes are no longer detached from healthy nodes after 6 minutes timeout.6 minute force-detach timeout is used only for unhealthy nodes (`node.status.conditions["Ready"]!= true`). ([#110721](https://github.com/kubernetes/kubernetes/pull/110721), [@jsafrane](https://github.com/jsafrane))
- `kubeadm certs renew` and `kubeadm certs check-expiration`  now honor the `cert-dir` on a working kubernetes cluster. ([#110709](https://github.com/kubernetes/kubernetes/pull/110709), [@chendave](https://github.com/chendave))

### Other (Cleanup or Flake)

- Add missing powershell option to kubectl completion command short description. ([#109773](https://github.com/kubernetes/kubernetes/pull/109773), [@danielhelfand](https://github.com/danielhelfand))
- Apimachinery/clock: This deletes the apimachinery/clock package. Please use k8s.io/utils/clock instead. ([#109752](https://github.com/kubernetes/kubernetes/pull/109752), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Apiserver_longrunning_gauge is removed from the codebase. Please use apiserver_longrunning_requests instead. ([#110310](https://github.com/kubernetes/kubernetes/pull/110310), [@logicalhan](https://github.com/logicalhan))
- Change PV framework delete timeout to 5 minutes as documented ([#109764](https://github.com/kubernetes/kubernetes/pull/109764), [@saikat-royc](https://github.com/saikat-royc))
- Feature gates that graduated to GA in 1.23 or earlier and were unconditionally enabled have been removed: CSIServiceAccountToken, ConfigurableFSGroupPolicy, EndpointSlice, EndpointSliceNodeName, EndpointSliceProxying, GenericEphemeralVolume, IPv6DualStack, IngressClassNamespacedParams, StorageObjectInUseProtection, TTLAfterFinished, VolumeSubpath, WindowsEndpointSliceProxying. ([#109435](https://github.com/kubernetes/kubernetes/pull/109435), [@pohly](https://github.com/pohly))
- For resources built into an apiserver, the server now logs at `-v=3` whether it is using watch caching. ([#109175](https://github.com/kubernetes/kubernetes/pull/109175), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- Improve kubectl run and debug attach problems error. ([#110764](https://github.com/kubernetes/kubernetes/pull/110764), [@soltysh](https://github.com/soltysh))
- Kubeadm: perform additional dockershim cleanup. Treat all container runtimes as remote by using the flag "--container-runtime=remote", given dockershim was removed in 1.24 and given kubeadm 1.25 supports a kubelet version of 1.24 and 1.25. The flag "--network-plugin" will no longer be used for new clusters. Stop cleaning up the following dockershim related directories on "kubeadm reset": "/var/lib/dockershim", "/var/runkubernetes", "/var/lib/cni" ([#110022](https://github.com/kubernetes/kubernetes/pull/110022), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubelet's deprecated `--experimental-kernel-memcg-notification` flag is now removed.  Use `--kernel-memcg-notification` instead. ([#109388](https://github.com/kubernetes/kubernetes/pull/109388), [@ialidzhikov](https://github.com/ialidzhikov))
- Kubelet: silence flag output on errors ([#110728](https://github.com/kubernetes/kubernetes/pull/110728), [@howardjohn](https://github.com/howardjohn))
- Kubernetes binaries are now built in module mode instead of GOPATH mode. ([#109464](https://github.com/kubernetes/kubernetes/pull/109464), [@liggitt](https://github.com/liggitt))
- Remove release-1.20 from prom bot due to eol. ([#110748](https://github.com/kubernetes/kubernetes/pull/110748), [@cpanato](https://github.com/cpanato))
- Removed deprecated kubectl.kubernetes.io/default-logs-container support ([#109254](https://github.com/kubernetes/kubernetes/pull/109254), [@pacoxu](https://github.com/pacoxu))
- Renamed `apiserver_watch_cache_watch_cache_initializations_total` to `apiserver_watch_cache_initializations_total` ([#109579](https://github.com/kubernetes/kubernetes/pull/109579), [@logicalhan](https://github.com/logicalhan))
- The kube-controller-manager's deprecated `--experimental-cluster-signing-duration` flag is now removed. Adapt your machinery to use the `--cluster-signing-duration` flag that is available since v1.19. ([#108476](https://github.com/kubernetes/kubernetes/pull/108476), [@ialidzhikov](https://github.com/ialidzhikov))
- Updated cri-tools to [v1.24.2(https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.24.2) ([#109813](https://github.com/kubernetes/kubernetes/pull/109813), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Node and Release]
- `apiserver_dropped_requests` is dropped from this release since `apiserver_request_total` can now be used to track dropped requests. `etcd_object_counts` is also removed in favor of `apiserver_storage_objects`. `apiserver_registered_watchers` is also removed in favor of `apiserver_longrunning_requests`. ([#110337](https://github.com/kubernetes/kubernetes/pull/110337), [@logicalhan](https://github.com/logicalhan))