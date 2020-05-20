# Release notes for v1.19.0-beta.0

[Documentation](https://docs.k8s.io/docs/home)
# Changelog since v1.18.0-rc.1

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Kubeadm does not set the deprecated '--cgroup-driver' flag in /var/lib/kubelet/kubeadm-flags.env, it will be set in the kubelet config.yaml. If you have this flag in /var/lib/kubelet/kubeadm-flags.env or /etc/default/kubelet (/etc/sysconfig/kubelet for RPMs) please remove it and set the value using KubeletConfiguration ([#90513](https://github.com/kubernetes/kubernetes/pull/90513), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
 - Kubeadm now respects user specified etcd versions in the ClusterConfiguration and properly uses them. If users do not want to stick to the version specified in the ClusterConfiguration, they should edit the kubeadm-config config map and delete it. ([#89588](https://github.com/kubernetes/kubernetes/pull/89588), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
 - Kubeadm respects resolvConf value set by user even if systemd-resolved service is active. kubeadm no longer sets the flag in '--resolv-conf' in /var/lib/kubelet/kubeadm-flags.env. If you have this flag in /var/lib/kubelet/kubeadm-flags.env or /etc/default/kubelet (/etc/sysconfig/kubelet for RPMs) please remove it and set the value using KubeletConfiguration ([#90394](https://github.com/kubernetes/kubernetes/pull/90394), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
 - Kubeadm: Move the "kubeadm init" phase "kubelet-start" later in the init workflow, after the "kubeconfig" phase. This makes kubeadm start the kubelet only after the KubeletConfiguration component config file (/var/lib/kubelet/config.yaml) is generated and solves a problem where init systems like OpenRC cannot crashloop the kubelet service. ([#90892](https://github.com/kubernetes/kubernetes/pull/90892), [@xphoniex](https://github.com/xphoniex)) [SIG Cluster Lifecycle]
 
## Changes by Kind

### Deprecation

- Apiextensions.k8s.io/v1beta1 is deprecated in favor of apiextensions.k8s.io/v1 ([#90673](https://github.com/kubernetes/kubernetes/pull/90673), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- Apiregistration.k8s.io/v1beta1 is deprecated in favor of apiregistration.k8s.io/v1 ([#90672](https://github.com/kubernetes/kubernetes/pull/90672), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- Authentication.k8s.io/v1beta1 and authorization.k8s.io/v1beta1 are deprecated in 1.19 in favor of v1 levels and will be removed in 1.22 ([#90458](https://github.com/kubernetes/kubernetes/pull/90458), [@deads2k](https://github.com/deads2k)) [SIG API Machinery and Auth]
- Autoscaling/v2beta1 is deprecated in favor of autoscaling/v2beta2 ([#90463](https://github.com/kubernetes/kubernetes/pull/90463), [@deads2k](https://github.com/deads2k)) [SIG Autoscaling]
- Coordination.k8s.io/v1beta1 is deprecated in 1.19, targeted for removal in 1.22, use v1 instead. ([#90559](https://github.com/kubernetes/kubernetes/pull/90559), [@deads2k](https://github.com/deads2k)) [SIG Scalability]
- Kubernetes no longer supports building hyperkube images ([#88676](https://github.com/kubernetes/kubernetes/pull/88676), [@dims](https://github.com/dims)) [SIG Cluster Lifecycle and Release]
- Storage.k8s.io/v1beta1 is deprecated in favor of storage.k8s.io/v1 ([#90671](https://github.com/kubernetes/kubernetes/pull/90671), [@deads2k](https://github.com/deads2k)) [SIG Storage]

### API Change

- EnvVarSource api doc bug fixes ([#91194](https://github.com/kubernetes/kubernetes/pull/91194), [@wawa0210](https://github.com/wawa0210)) [SIG Apps]
- Fixed: log timestamps now include trailing zeros to maintain a fixed width ([#91207](https://github.com/kubernetes/kubernetes/pull/91207), [@iamchuckss](https://github.com/iamchuckss)) [SIG Apps and Node]
- K8s.io/apimachinery - scheme.Convert() now uses only explicitly registered conversions - default reflection based conversion is no longer available. `+k8s:conversion-gen` tags can be used with the `k8s.io/code-generator` component to generate conversions. ([#90018](https://github.com/kubernetes/kubernetes/pull/90018), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery, Apps and Testing]
- Kube-proxy: add `--bind-address-hard-fail` flag to treat failure to bind to a port as fatal ([#89350](https://github.com/kubernetes/kubernetes/pull/89350), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle and Network]
- Kubelet's --runonce option is now also available in Kubelet's config file as `runOnce`. ([#89128](https://github.com/kubernetes/kubernetes/pull/89128), [@vincent178](https://github.com/vincent178)) [SIG Node]
- Promote Immutable Secrets/ConfigMaps feature to Beta and enable the feature by default.
  This allows to set `Immutable` field in Secrets or ConfigMap object to mark their contents as immutable. ([#89594](https://github.com/kubernetes/kubernetes/pull/89594), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps and Testing]
- Remove kubescheduler.config.k8s.io/v1alpha1 ([#89298](https://github.com/kubernetes/kubernetes/pull/89298), [@gavinfish](https://github.com/gavinfish)) [SIG Scheduling]
- ServiceAppProtocol feature gate is now beta and enabled by default, adding new AppProtocol field to Services and Endpoints. ([#90023](https://github.com/kubernetes/kubernetes/pull/90023), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- The Kubelet's `--really-crash-for-testing` and  `--chaos-chance` options are now marked as deprecated. ([#90499](https://github.com/kubernetes/kubernetes/pull/90499), [@knabben](https://github.com/knabben)) [SIG Node]
- The Kubelet's `--volume-plugin-dir` option is now available via the Kubelet config file field `VolumePluginDir`. ([#88480](https://github.com/kubernetes/kubernetes/pull/88480), [@savitharaghunathan](https://github.com/savitharaghunathan)) [SIG Node]
- The unused `series.state` field, deprecated since v1.14, is removed from the `events.k8s.io/v1beta1` and `v1` Event types. ([#90449](https://github.com/kubernetes/kubernetes/pull/90449), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps]
- `NodeResourcesLeastAllocated` and `NodeResourcesMostAllocated` plugins now support customized weight on the CPU and memory. ([#90544](https://github.com/kubernetes/kubernetes/pull/90544), [@chendave](https://github.com/chendave)) [SIG Scheduling]

### Feature

- Add .import-restrictions file to cmd/cloud-controller-manager. ([#90630](https://github.com/kubernetes/kubernetes/pull/90630), [@nilo19](https://github.com/nilo19)) [SIG API Machinery and Cloud Provider]
- Add Annotations to CRI-API ImageSpec objects. ([#90061](https://github.com/kubernetes/kubernetes/pull/90061), [@marosset](https://github.com/marosset)) [SIG Node and Windows]
- Add client-side and server-side dry-run support to kubectl scale ([#89666](https://github.com/kubernetes/kubernetes/pull/89666), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- Add support for cgroups v2 node validation ([#89901](https://github.com/kubernetes/kubernetes/pull/89901), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle and Node]
- Add support for pre allocated huge pages with different sizes, on node level ([#89252](https://github.com/kubernetes/kubernetes/pull/89252), [@odinuge](https://github.com/odinuge)) [SIG Apps and Node]
- Detailed scheduler scoring result can be printed at verbose level 10. ([#89384](https://github.com/kubernetes/kubernetes/pull/89384), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- E2e.test can print the list of conformance tests that need to pass for the cluster to be conformant. ([#88924](https://github.com/kubernetes/kubernetes/pull/88924), [@dims](https://github.com/dims)) [SIG Architecture and Testing]
- EndpointSlice controller waits longer to retry failed sync. ([#89438](https://github.com/kubernetes/kubernetes/pull/89438), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Feat: add azure shared disk support ([#89511](https://github.com/kubernetes/kubernetes/pull/89511), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Feat: change azure disk api-version ([#89250](https://github.com/kubernetes/kubernetes/pull/89250), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Feat: support [Azure shared disk](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-shared-enable), added a new field(`maxShares`) in azure disk storage class:
  
  kind: StorageClass
  apiVersion: storage.k8s.io/v1
  metadata:
    name: shared-disk
  provisioner: kubernetes.io/azure-disk
  parameters:
    skuname: Premium_LRS  &#35; Currently only available with premium SSDs.
    cachingMode: None  &#35; ReadOnly host caching is not available for premium SSDs with maxShares>1
    maxShares: 2 ([#89328](https://github.com/kubernetes/kubernetes/pull/89328), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Kube-apiserver backed by etcd3 exports metric showing the database file size. ([#89151](https://github.com/kubernetes/kubernetes/pull/89151), [@jingyih](https://github.com/jingyih)) [SIG API Machinery]
- Kube-apiserver, kube-scheduler and kube-controller manager now use SO_REUSEPORT socket option when listening on address defined by --bind-address and --secure-port flags, when running on Unix systems (Windows is NOT supported). This allows to run multiple instances of those processes on a single host with the same configuration, which allows to update/restart them in a graceful way, without causing downtime. ([#88893](https://github.com/kubernetes/kubernetes/pull/88893), [@invidian](https://github.com/invidian)) [SIG API Machinery, Scheduling and Testing]
- Kube-apiserver: The NodeRestriction admission plugin now restricts Node labels kubelets are permitted to set when creating a new Node to the `--node-labels` parameters accepted by kubelets in 1.16+. ([#90307](https://github.com/kubernetes/kubernetes/pull/90307), [@liggitt](https://github.com/liggitt)) [SIG Auth and Node]
- Kubeadm: during 'upgrade apply', if the kube-proxy ConfigMap is missing, assume that kube-proxy should not be upgraded. Same applies to a missing kube-dns/coredns ConfigMap for the DNS server addon. Note that this is a temporary workaround until 'upgrade apply' supports phases. Once phases are supported the kube-proxy/dns upgrade should be skipped manually. ([#89593](https://github.com/kubernetes/kubernetes/pull/89593), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: switch control-plane static Pods to the "system-node-critical" priority class ([#90063](https://github.com/kubernetes/kubernetes/pull/90063), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubectl supports taint no without specifying(without having to type the full resource name) ([#88723](https://github.com/kubernetes/kubernetes/pull/88723), [@wawa0210](https://github.com/wawa0210)) [SIG CLI]
- Kubelets configured to rotate client certificates now publish a `certificate_manager_server_ttl_seconds` gauge metric indicating the remaining seconds until certificate expiration. ([#91148](https://github.com/kubernetes/kubernetes/pull/91148), [@liggitt](https://github.com/liggitt)) [SIG Auth and Node]
- NONE ([#89131](https://github.com/kubernetes/kubernetes/pull/89131), [@cwdsuzhou](https://github.com/cwdsuzhou)) [SIG Scheduling]
- New scoring for PodTopologySpreading that yields better spreading ([#90475](https://github.com/kubernetes/kubernetes/pull/90475), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Rest.Config now supports a flag to override proxy configuration that was previously only configurable through environment variables. ([#81443](https://github.com/kubernetes/kubernetes/pull/81443), [@mikedanese](https://github.com/mikedanese)) [SIG API Machinery and Node]
- Scores from PodTopologySpreading have reduced differentiation as maxSkew increases. ([#90820](https://github.com/kubernetes/kubernetes/pull/90820), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Service controller: only sync LB node pools when relevant fields in Node changes ([#90769](https://github.com/kubernetes/kubernetes/pull/90769), [@andrewsykim](https://github.com/andrewsykim)) [SIG Apps and Network]
- Support create or update VMSS asynchronously. ([#89248](https://github.com/kubernetes/kubernetes/pull/89248), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Support for running on a host that uses cgroups v2 unified mode ([#85218](https://github.com/kubernetes/kubernetes/pull/85218), [@giuseppe](https://github.com/giuseppe)) [SIG Node]
- Switch core master base images (kube-apiserver, kube-scheduler) from debian to distroless ([#90674](https://github.com/kubernetes/kubernetes/pull/90674), [@dims](https://github.com/dims)) [SIG Cloud Provider, Release and Scalability]
- Try to send watch bookmarks (if requested) periodically in addition to sending them right before timeout ([#90249](https://github.com/kubernetes/kubernetes/pull/90249), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery]
- Update cri-tools to v1.18.0 ([#89720](https://github.com/kubernetes/kubernetes/pull/89720), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Cluster Lifecycle, Release and Scalability]
- Update etcd client side to v3.4.4 ([#89169](https://github.com/kubernetes/kubernetes/pull/89169), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Update etcd client side to v3.4.7 ([#89822](https://github.com/kubernetes/kubernetes/pull/89822), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Upgrade to azure-sdk v40.2.0 ([#89105](https://github.com/kubernetes/kubernetes/pull/89105), [@andyzhangx](https://github.com/andyzhangx)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Storage and Testing]
- deps: Update to Golang 1.13.9
  - build: Remove kube-cross image building ([#89275](https://github.com/kubernetes/kubernetes/pull/89275), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]

### Documentation

- Improved error message for incorrect auth field. ([#82829](https://github.com/kubernetes/kubernetes/pull/82829), [@martin-schibsted](https://github.com/martin-schibsted)) [SIG Auth]
- Updated the instructions for deploying the sample app. ([#82785](https://github.com/kubernetes/kubernetes/pull/82785), [@ashish-billore](https://github.com/ashish-billore)) [SIG API Machinery]

### Bug or Regression

- A PV set from in-tree source will have ordered requirement values in NodeAffinity when converted to CSIPersistentVolumeSource ([#88987](https://github.com/kubernetes/kubernetes/pull/88987), [@jiahuif](https://github.com/jiahuif)) [SIG Storage]
- Add support for TLS 1.3 ciphers: TLS_AES_128_GCM_SHA256, TLS_CHACHA20_POLY1305_SHA256 and TLS_AES_256_GCM_SHA384. ([#90843](https://github.com/kubernetes/kubernetes/pull/90843), [@pjbgf](https://github.com/pjbgf)) [SIG API Machinery, Auth and Cluster Lifecycle]
- An issue preventing GCP cloud-controller-manager running out-of-cluster to initialize new Nodes is now fixed. ([#90057](https://github.com/kubernetes/kubernetes/pull/90057), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Apps and Cloud Provider]
- Avoid GCE API calls when initializing GCE CloudProvider for Kubelets. ([#90218](https://github.com/kubernetes/kubernetes/pull/90218), [@wojtek-t](https://github.com/wojtek-t)) [SIG Cloud Provider and Scalability]
- Avoid unnecessary GCE API calls when adding IP alises or reflecting them in Node object in GCE cloud provider. ([#90242](https://github.com/kubernetes/kubernetes/pull/90242), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps, Cloud Provider and Network]
- Avoid unnecessary scheduling churn when annotations are updated while Pods are being scheduled. ([#90373](https://github.com/kubernetes/kubernetes/pull/90373), [@fabiokung](https://github.com/fabiokung)) [SIG Scheduling]
- Azure auth module for kubectl now requests login after refresh token expires. ([#86481](https://github.com/kubernetes/kubernetes/pull/86481), [@tdihp](https://github.com/tdihp)) [SIG API Machinery and Auth]
- Azure: fix concurreny issue in lb creation ([#89604](https://github.com/kubernetes/kubernetes/pull/89604), [@aramase](https://github.com/aramase)) [SIG Cloud Provider]
- Base-images: Update to kube-cross:v1.13.9-5 ([#90963](https://github.com/kubernetes/kubernetes/pull/90963), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]
- Bug fix for AWS NLB service when nodePort for existing servicePort changed manually. ([#89562](https://github.com/kubernetes/kubernetes/pull/89562), [@M00nF1sh](https://github.com/M00nF1sh)) [SIG Cloud Provider]
- CSINode initialization does not crash kubelet on startup when APIServer is not reachable or kubelet has not the right credentials yet. ([#89589](https://github.com/kubernetes/kubernetes/pull/89589), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Client-go: resolves an issue with informers falling back to full list requests when timeouts are encountered, rather than re-establishing a watch. ([#89652](https://github.com/kubernetes/kubernetes/pull/89652), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- CloudNodeLifecycleController will check node existence status before shutdown status when monitoring nodes. ([#90737](https://github.com/kubernetes/kubernetes/pull/90737), [@jiahuif](https://github.com/jiahuif)) [SIG Apps and Cloud Provider]
- Cordoned nodes are now deregistered from AWS target groups. ([#85920](https://github.com/kubernetes/kubernetes/pull/85920), [@hoelzro](https://github.com/hoelzro)) [SIG Cloud Provider]
- Dual-stack: fix the bug that Service clusterIP does not respect specified ipFamily ([#89612](https://github.com/kubernetes/kubernetes/pull/89612), [@SataQiu](https://github.com/SataQiu)) [SIG Network]
- Ensure Azure availability zone is always in lower cases. ([#89722](https://github.com/kubernetes/kubernetes/pull/89722), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Explain CRDs whose resource name are the same as builtin objects ([#89505](https://github.com/kubernetes/kubernetes/pull/89505), [@knight42](https://github.com/knight42)) [SIG API Machinery, CLI and Testing]
- First pod with required affinity terms can schedule only on nodes with matching topology keys. ([#91168](https://github.com/kubernetes/kubernetes/pull/91168), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- Fix VirtualMachineScaleSets.virtualMachines.GET not allowed issues when customers have set VMSS orchestrationMode. ([#91097](https://github.com/kubernetes/kubernetes/pull/91097), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix a bug that didn't allow to use IPv6 addresses with leading zeros ([#89341](https://github.com/kubernetes/kubernetes/pull/89341), [@aojea](https://github.com/aojea)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fix a bug where ExternalTrafficPolicy is not applied to service ExternalIPs. ([#90537](https://github.com/kubernetes/kubernetes/pull/90537), [@freehan](https://github.com/freehan)) [SIG Network]
- Fix a racing issue that scheduler may perform unnecessary scheduling attempt. ([#90660](https://github.com/kubernetes/kubernetes/pull/90660), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- Fix bug with xfs_repair from stopping xfs mount ([#89444](https://github.com/kubernetes/kubernetes/pull/89444), [@gnufied](https://github.com/gnufied)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Fix detection of SystemOOMs in which the victim is a container. ([#88871](https://github.com/kubernetes/kubernetes/pull/88871), [@dashpole](https://github.com/dashpole)) [SIG Node]
- Fix flaws in Azure File CSI translation ([#90162](https://github.com/kubernetes/kubernetes/pull/90162), [@rfranzke](https://github.com/rfranzke)) [SIG Release and Storage]
- Fix kube-apiserver startup to wait for APIServices to be installed into the HTTP handler before reporting readiness. ([#89147](https://github.com/kubernetes/kubernetes/pull/89147), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- Fix kubectl create --dryrun client ignore namespace ([#90502](https://github.com/kubernetes/kubernetes/pull/90502), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix kubectl describe CSINode nil pointer error ([#89646](https://github.com/kubernetes/kubernetes/pull/89646), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix kubectl diff so it doesn't actually persist patches ([#89795](https://github.com/kubernetes/kubernetes/pull/89795), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- Fix kubectl run  --dry-run client  ignore namespace ([#90785](https://github.com/kubernetes/kubernetes/pull/90785), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix kubectl version should print version info without config file ([#89913](https://github.com/kubernetes/kubernetes/pull/89913), [@zhouya0](https://github.com/zhouya0)) [SIG API Machinery and CLI]
- Fix missing `-c` shorthand for `--container` flag of `kubectl alpha debug` ([#89674](https://github.com/kubernetes/kubernetes/pull/89674), [@superbrothers](https://github.com/superbrothers)) [SIG CLI]
- Fix printers ignoring object average value ([#89142](https://github.com/kubernetes/kubernetes/pull/89142), [@zhouya0](https://github.com/zhouya0)) [SIG API Machinery]
- Fix public IP not shown issues after assigning public IP to Azure VMs ([#90886](https://github.com/kubernetes/kubernetes/pull/90886), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix scheduler crash when removing node before its pods ([#89908](https://github.com/kubernetes/kubernetes/pull/89908), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix the VMSS name and resource group name when updating Azure VMSS for LoadBalancer backendPools ([#89337](https://github.com/kubernetes/kubernetes/pull/89337), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix: add azure file migration support on annotation support ([#91093](https://github.com/kubernetes/kubernetes/pull/91093), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Node]
- Fix: azure disk dangling attach issue which would cause API throttling ([#90749](https://github.com/kubernetes/kubernetes/pull/90749), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: get attach disk error due to missing item in max count table ([#89768](https://github.com/kubernetes/kubernetes/pull/89768), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix: support removal of nodes backed by deleted non VMSS instances on Azure ([#91184](https://github.com/kubernetes/kubernetes/pull/91184), [@bpineau](https://github.com/bpineau)) [SIG Cloud Provider]
- Fixed a 1.18 regression in wait.Forever that skips the backoff period on the first repeat ([#90476](https://github.com/kubernetes/kubernetes/pull/90476), [@zhan849](https://github.com/zhan849)) [SIG API Machinery]
- Fixed a bug where executing a kubectl command with a jsonpath output expression that has a nested range would ignore expressions following the nested range. ([#88464](https://github.com/kubernetes/kubernetes/pull/88464), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery]
- Fixed a regression preventing garbage collection of RBAC role and binding objects ([#90534](https://github.com/kubernetes/kubernetes/pull/90534), [@apelisse](https://github.com/apelisse)) [SIG Auth]
- Fixed a regression running kubectl commands with  --local or --dry-run flags when no kubeconfig file is present ([#90243](https://github.com/kubernetes/kubernetes/pull/90243), [@soltysh](https://github.com/soltysh)) [SIG API Machinery, CLI and Testing]
- Fixed an issue mounting credentials for service accounts whose name contains `.` characters ([#89696](https://github.com/kubernetes/kubernetes/pull/89696), [@nabokihms](https://github.com/nabokihms)) [SIG Auth]
- Fixed bug where a nonzero exit code was returned when initializing zsh completion even though zsh completion was successfully initialized ([#88165](https://github.com/kubernetes/kubernetes/pull/88165), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed mountOptions in iSCSI and FibreChannel volume plugins. ([#89172](https://github.com/kubernetes/kubernetes/pull/89172), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed the EndpointSlice controller to run without error on a cluster with the OwnerReferencesPermissionEnforcement validating admission plugin enabled. ([#89741](https://github.com/kubernetes/kubernetes/pull/89741), [@marun](https://github.com/marun)) [SIG Auth and Network]
- Fixes a bug defining a default value for a replicas field in a custom resource definition that has the scale subresource enabled ([#89833](https://github.com/kubernetes/kubernetes/pull/89833), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fixes a bug that non directory hostpath type can be recognized as HostPathFile and adds e2e tests for HostPathType ([#64829](https://github.com/kubernetes/kubernetes/pull/64829), [@dixudx](https://github.com/dixudx)) [SIG Apps, Storage and Testing]
- Fixes a regression in 1.17 that dropped cache-control headers on API requests ([#90468](https://github.com/kubernetes/kubernetes/pull/90468), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- Fixes conversion error for HorizontalPodAutoscaler objects with invalid annotations ([#89963](https://github.com/kubernetes/kubernetes/pull/89963), [@liggitt](https://github.com/liggitt)) [SIG Autoscaling]
- Fixes kubectl to apply all validly built objects, instead of stopping on error. ([#89848](https://github.com/kubernetes/kubernetes/pull/89848), [@seans3](https://github.com/seans3)) [SIG CLI and Testing]
- Fixes regression in CPUManager that caused freeing of exclusive CPUs at incorrect times ([#90377](https://github.com/kubernetes/kubernetes/pull/90377), [@cbf123](https://github.com/cbf123)) [SIG Cloud Provider and Node]
- Fixes regression in CPUManager that had the (rare) possibility to release exclusive CPUs in app containers inherited from init containers. ([#90419](https://github.com/kubernetes/kubernetes/pull/90419), [@klueska](https://github.com/klueska)) [SIG Node]
- Fixes v1.18.0-rc.1 regression in `kubectl port-forward` when specifying a local and remote port ([#89401](https://github.com/kubernetes/kubernetes/pull/89401), [@liggitt](https://github.com/liggitt)) [SIG CLI]
- For GCE cluster provider, fix bug of not being able to create internal type load balancer for clusters with more than 1000 nodes in a single zone. ([#89902](https://github.com/kubernetes/kubernetes/pull/89902), [@wojtek-t](https://github.com/wojtek-t)) [SIG Cloud Provider, Network and Scalability]
- For external storage e2e test suite, update external driver, to pick snapshot provisioner from VolumeSnapshotClass, when a VolumeSnapshotClass is explicitly provided as an input. ([#90878](https://github.com/kubernetes/kubernetes/pull/90878), [@saikat-royc](https://github.com/saikat-royc)) [SIG Storage and Testing]
- If firstTimestamp is not set use eventTime when printing event ([#89999](https://github.com/kubernetes/kubernetes/pull/89999), [@soltysh](https://github.com/soltysh)) [SIG CLI]
- If we set parameter cgroupPerQos=false and cgroupRoot=/docker，this function will retrun  nodeAllocatableRoot=/docker/kubepods, it is not right, the correct return should be /docker.
  cm.NodeAllocatableRoot(s.CgroupRoot, s.CgroupDriver)
  
  kubeDeps.CAdvisorInterface, err = cadvisor.New(imageFsInfoProvider, s.RootDirectory, cgroupRoots, cadvisor.UsingLegacyCadvisorStats(s.ContainerRuntime, s.RemoteRuntimeEndpoint))
  the above funtion，as we use cgroupRoots to create cadvisor interface，the wrong parameter cgroupRoots will lead eviction manager not  to collect metric from /docker, then kubelet frequently print those error：
  E0303 17:25:03.436781 63839 summary_sys_containers.go:47] Failed to get system container stats for "/docker": failed to get cgroup stats for "/docker": failed to get container info for "/docker": unknown container "/docker"
  E0303 17:25:03.436809 63839 helpers.go:680] eviction manager: failed to construct signal: "allocatableMemory.available" error: system container "pods" not found in metrics ([#88970](https://github.com/kubernetes/kubernetes/pull/88970), [@mysunshine92](https://github.com/mysunshine92)) [SIG Node]
- In a HA env, during the period a standby scheduler lost connection to API server, if a Pod is deleted and recreated, and the standby scheduler becomes master afterwards, there could be a scheduler cache corruption. This PR fixes this issue. ([#91126](https://github.com/kubernetes/kubernetes/pull/91126), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- In the kubelet resource metrics endpoint at /metrics/resource, change the names of the following metrics:
  - node_cpu_usage_seconds --> node_cpu_usage_seconds_total
  - container_cpu_usage_seconds --> container_cpu_usage_seconds_total
  This is a partial revert of &#35;86282, which was added in 1.18.0, and initially removed the _total suffix ([#89540](https://github.com/kubernetes/kubernetes/pull/89540), [@dashpole](https://github.com/dashpole)) [SIG Instrumentation and Node]
- Ipvs: only attempt setting of sysctlconnreuse on supported kernels ([#88541](https://github.com/kubernetes/kubernetes/pull/88541), [@cmluciano](https://github.com/cmluciano)) [SIG Network]
- Jsonpath support in kubectl / client-go serializes complex types (maps / slices / structs) as json instead of Go-syntax. ([#89660](https://github.com/kubernetes/kubernetes/pull/89660), [@pjferrell](https://github.com/pjferrell)) [SIG API Machinery, CLI and Cluster Lifecycle]
- Kube-apiserver: multiple comma-separated protocols in a single X-Stream-Protocol-Version header are now recognized, in addition to multiple headers, complying with RFC2616 ([#89857](https://github.com/kubernetes/kubernetes/pull/89857), [@tedyu](https://github.com/tedyu)) [SIG API Machinery]
- Kubeadm increased to 5 minutes its timeout for the TLS bootstrapping process to complete upon join ([#89735](https://github.com/kubernetes/kubernetes/pull/89735), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: during join when a check is performed that a Node with the same name already exists in the cluster, make sure the NodeReady condition is properly validated ([#89602](https://github.com/kubernetes/kubernetes/pull/89602), [@kvaps](https://github.com/kvaps)) [SIG Cluster Lifecycle]
- Kubeadm: ensure `image-pull-timeout` flag is respected during upgrade phase ([#90328](https://github.com/kubernetes/kubernetes/pull/90328), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where post upgrade to 1.18.x, nodes cannot join the cluster due to missing RBAC ([#89537](https://github.com/kubernetes/kubernetes/pull/89537), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fix misleading warning about passing control-plane related flags on 'kubeadm join' ([#89596](https://github.com/kubernetes/kubernetes/pull/89596), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: increase robustness for "kubeadm join" when adding etcd members on slower setups ([#90645](https://github.com/kubernetes/kubernetes/pull/90645), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubectl azure authentication: fixed a regression in 1.18.0 where "spn:" prefix was unexpectedly added to the `apiserver-id` configuration in the kubeconfig file ([#89706](https://github.com/kubernetes/kubernetes/pull/89706), [@weinong](https://github.com/weinong)) [SIG API Machinery and Auth]
- Kubelet: fix the bug that kubelet help information can not show the right type of flags ([#88515](https://github.com/kubernetes/kubernetes/pull/88515), [@SataQiu](https://github.com/SataQiu)) [SIG Docs and Node]
- Prevent PVC requested size overflow when expanding or creating a volume ([#90907](https://github.com/kubernetes/kubernetes/pull/90907), [@gnufied](https://github.com/gnufied)) [SIG Cloud Provider and Storage]
- Provides a fix to allow a cluster in a private Azure cloud to authenticate to ACR in the same cloud. ([#90425](https://github.com/kubernetes/kubernetes/pull/90425), [@DavidParks8](https://github.com/DavidParks8)) [SIG Cloud Provider]
- Resolved a regression in v1.18.0-rc.1 mounting windows volumes ([#89319](https://github.com/kubernetes/kubernetes/pull/89319), [@mboersma](https://github.com/mboersma)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Restore the ability to `kubectl apply --prune` without --namespace flag.  Since 1.17, `kubectl apply --prune` only prunes resources in the default namespace (or from kubeconfig) or explicitly specified in command line flag.  But this is s breaking change from kubectl 1.16, which can prune resources in all namespace in config file.  This patch restores the kubectl 1.16 behaviour. ([#89551](https://github.com/kubernetes/kubernetes/pull/89551), [@tatsuhiro-t](https://github.com/tatsuhiro-t)) [SIG CLI and Testing]
- Restores priority of static control plane pods in the cluster/gce/manifests control-plane manifests ([#89970](https://github.com/kubernetes/kubernetes/pull/89970), [@liggitt](https://github.com/liggitt)) [SIG Cluster Lifecycle and Node]
- Scheduling failures due to no nodes available are now reported as unschedulable under ```schedule_attempts_total``` metric. ([#90989](https://github.com/kubernetes/kubernetes/pull/90989), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- Service account tokens bound to pods can now be used during the pod deletion grace period. ([#89583](https://github.com/kubernetes/kubernetes/pull/89583), [@liggitt](https://github.com/liggitt)) [SIG Auth]
- Sync LB backend nodes for Service Type=LoadBalancer on Add/Delete node events. ([#81185](https://github.com/kubernetes/kubernetes/pull/81185), [@andrewsykim](https://github.com/andrewsykim)) [SIG Apps and Network]
- Update github.com/moby/ipvs to v1.0.1 to fix IPVS compatiblity issue with older kernels ([#90555](https://github.com/kubernetes/kubernetes/pull/90555), [@andrewsykim](https://github.com/andrewsykim)) [SIG Network]
- Updates to pod status via the status subresource now validate that `status.podIP` and `status.podIPs` fields are well-formed. ([#90628](https://github.com/kubernetes/kubernetes/pull/90628), [@liggitt](https://github.com/liggitt)) [SIG Apps and Node]
- Wait for all CRDs to show up in discovery endpoint before reporting readiness. ([#89145](https://github.com/kubernetes/kubernetes/pull/89145), [@sttts](https://github.com/sttts)) [SIG API Machinery]

### Other (Cleanup or Flake)

- Adds additional testing to ensure that udp pods conntrack are cleaned up ([#90180](https://github.com/kubernetes/kubernetes/pull/90180), [@JacobTanenbaum](https://github.com/JacobTanenbaum)) [SIG Architecture, Network and Testing]
- Adjusts the fsType for cinder values to be `ext4` if no fsType is specified. ([#90608](https://github.com/kubernetes/kubernetes/pull/90608), [@huffmanca](https://github.com/huffmanca)) [SIG Storage]
- Beta.kubernetes.io/arch is already deprecated since v1.14, are targeted for removal in v1.18 ([#89462](https://github.com/kubernetes/kubernetes/pull/89462), [@wawa0210](https://github.com/wawa0210)) [SIG Testing]
- Change beta.kubernetes.io/os  to kubernetes.io/os ([#89460](https://github.com/kubernetes/kubernetes/pull/89460), [@wawa0210](https://github.com/wawa0210)) [SIG Testing and Windows]
- Change beta.kubernetes.io/os to kubernetes.io/os ([#89461](https://github.com/kubernetes/kubernetes/pull/89461), [@wawa0210](https://github.com/wawa0210)) [SIG Cloud Provider and Cluster Lifecycle]
- Changes not found message when using `kubectl get` to retrieve not namespaced resources ([#89861](https://github.com/kubernetes/kubernetes/pull/89861), [@rccrdpccl](https://github.com/rccrdpccl)) [SIG CLI]
- Deprecate kubectl top flags related to heapster
  Drop support of heapster in kubectl top ([#87498](https://github.com/kubernetes/kubernetes/pull/87498), [@serathius](https://github.com/serathius)) [SIG CLI]
- Drop some conformance tests that rely on Kubelet API directly ([#90615](https://github.com/kubernetes/kubernetes/pull/90615), [@dims](https://github.com/dims)) [SIG Architecture, Network, Release and Testing]
- Improve server-side apply conflict errors by setting dedicated kubectl subcommand field managers ([#88885](https://github.com/kubernetes/kubernetes/pull/88885), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- It is now possible to use the service annotation `cloud.google.com/network-tier: Standard` to configure the Network Tier of the GCE Loadbalancer ([#88532](https://github.com/kubernetes/kubernetes/pull/88532), [@zioproto](https://github.com/zioproto)) [SIG Cloud Provider, Network and Testing]
- Kube-proxy exposes a new metric, `kubeproxy_sync_proxy_rules_last_queued_timestamp_seconds`, that indicates the last time a change for kube-proxy was queued to be applied. ([#90175](https://github.com/kubernetes/kubernetes/pull/90175), [@squeed](https://github.com/squeed)) [SIG Instrumentation and Network]
- Kubeadm now forwards the IPv6DualStack feature gate using the kubelet component config, instead of the kubelet command line ([#90840](https://github.com/kubernetes/kubernetes/pull/90840), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: do not use a DaemonSet for the pre-pull of control-plane images during "kubeadm upgrade apply". Individual node upgrades now pull the required images using a preflight check. The flag "--image-pull-timeout" for "kubeadm upgrade apply" is now deprecated and will be removed in a future release following a GA deprecation policy. ([#90788](https://github.com/kubernetes/kubernetes/pull/90788), [@xlgao-zju](https://github.com/xlgao-zju)) [SIG Cluster Lifecycle]
- Kubeadm: use two separate checks on /livez and /readyz for the kube-apiserver static Pod instead of using /healthz ([#90970](https://github.com/kubernetes/kubernetes/pull/90970), [@johscheuer](https://github.com/johscheuer)) [SIG Cluster Lifecycle]
- Node ([#76443](https://github.com/kubernetes/kubernetes/pull/76443), [@mgdevstack](https://github.com/mgdevstack)) [SIG Architecture, Network, Node, Testing and Windows]
- None. ([#89367](https://github.com/kubernetes/kubernetes/pull/89367), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Reduce event spam during a volume operation error. ([#89794](https://github.com/kubernetes/kubernetes/pull/89794), [@msau42](https://github.com/msau42)) [SIG Storage]
- Scheduler PreScore plugins are not executed if there is one filtered node or less. ([#89370](https://github.com/kubernetes/kubernetes/pull/89370), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- The "HostPath should give a volume the correct mode" is no longer a conformance test ([#90861](https://github.com/kubernetes/kubernetes/pull/90861), [@dims](https://github.com/dims)) [SIG Architecture and Testing]
- The PR adds functionality to generate events when a PV or PVC processing encounters certain failures. The events help users to know the reason for the failure so they can take necessary recovery actions. ([#89845](https://github.com/kubernetes/kubernetes/pull/89845), [@yuga711](https://github.com/yuga711)) [SIG Apps]
- The PodShareProcessNamespace feature gate has been removed, and the PodShareProcessNamespace is unconditionally enabled. ([#90099](https://github.com/kubernetes/kubernetes/pull/90099), [@tanjunchen](https://github.com/tanjunchen)) [SIG Node]
- Update default etcd server version to 3.4.4 ([#89214](https://github.com/kubernetes/kubernetes/pull/89214), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cluster Lifecycle and Testing]
- Update default etcd server version to 3.4.7 ([#89895](https://github.com/kubernetes/kubernetes/pull/89895), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cluster Lifecycle and Testing]
- Update opencontainers/runtime-spec dependency to v1.0.2 ([#89644](https://github.com/kubernetes/kubernetes/pull/89644), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- `beta.kubernetes.io/os` and `beta.kubernetes.io/arch` node labels are deprecated. Update node selectors to use `kubernetes.io/os` and `kubernetes.io/arch`. ([#91046](https://github.com/kubernetes/kubernetes/pull/91046), [@wawa0210](https://github.com/wawa0210)) [SIG Apps and Node]
- `kubectl config view` now redacts bearer tokens by default, similar to client certificates. The `--raw` flag can still be used to output full content. ([#88985](https://github.com/kubernetes/kubernetes/pull/88985), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery and CLI]
- base-images: Use debian-base:v2.1.0 ([#90697](https://github.com/kubernetes/kubernetes/pull/90697), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery and Release]
- base-images: Use debian-iptables:v12.1.0 ([#90782](https://github.com/kubernetes/kubernetes/pull/90782), [@justaugustus](https://github.com/justaugustus)) [SIG Release]

## Dependencies

### Added
- cloud.google.com/go/bigquery: v1.0.1
- cloud.google.com/go/datastore: v1.0.0
- cloud.google.com/go/pubsub: v1.0.1
- cloud.google.com/go/storage: v1.0.0
- dmitri.shuralyov.com/gpu/mtl: 666a987
- github.com/cespare/xxhash/v2: [v2.1.1](https://github.com/cespare/xxhash/v2/tree/v2.1.1)
- github.com/chzyer/logex: [v1.1.10](https://github.com/chzyer/logex/tree/v1.1.10)
- github.com/chzyer/readline: [2972be2](https://github.com/chzyer/readline/tree/2972be2)
- github.com/chzyer/test: [a1ea475](https://github.com/chzyer/test/tree/a1ea475)
- github.com/containerd/ttrpc: [v1.0.0](https://github.com/containerd/ttrpc/tree/v1.0.0)
- github.com/coreos/bbolt: [v1.3.2](https://github.com/coreos/bbolt/tree/v1.3.2)
- github.com/cpuguy83/go-md2man/v2: [v2.0.0](https://github.com/cpuguy83/go-md2man/v2/tree/v2.0.0)
- github.com/docopt/docopt-go: [ee0de3b](https://github.com/docopt/docopt-go/tree/ee0de3b)
- github.com/go-gl/glfw/v3.3/glfw: [12ad95a](https://github.com/go-gl/glfw/v3.3/glfw/tree/12ad95a)
- github.com/go-ini/ini: [v1.9.0](https://github.com/go-ini/ini/tree/v1.9.0)
- github.com/ianlancetaylor/demangle: [5e5cf60](https://github.com/ianlancetaylor/demangle/tree/5e5cf60)
- github.com/ishidawataru/sctp: [7c296d4](https://github.com/ishidawataru/sctp/tree/7c296d4)
- github.com/moby/ipvs: [v1.0.1](https://github.com/moby/ipvs/tree/v1.0.1)
- github.com/moby/term: [672ec06](https://github.com/moby/term/tree/672ec06)
- github.com/russross/blackfriday/v2: [v2.0.1](https://github.com/russross/blackfriday/v2/tree/v2.0.1)
- github.com/shurcooL/sanitized_anchor_name: [v1.0.0](https://github.com/shurcooL/sanitized_anchor_name/tree/v1.0.0)
- github.com/ugorji/go: [v1.1.4](https://github.com/ugorji/go/tree/v1.1.4)
- google.golang.org/protobuf: v1.23.0
- gotest.tools/v3: v3.0.2
- k8s.io/klog/v2: v2.0.0

### Changed
- cloud.google.com/go: v0.38.0 → v0.51.0
- github.com/Azure/azure-sdk-for-go: [v35.0.0+incompatible → v40.2.0+incompatible](https://github.com/Azure/azure-sdk-for-go/compare/v35.0.0...v40.2.0)
- github.com/Azure/go-autorest/autorest/adal: [v0.5.0 → v0.8.2](https://github.com/Azure/go-autorest/autorest/adal/compare/v0.5.0...v0.8.2)
- github.com/Azure/go-autorest/autorest/date: [v0.1.0 → v0.2.0](https://github.com/Azure/go-autorest/autorest/date/compare/v0.1.0...v0.2.0)
- github.com/Azure/go-autorest/autorest/mocks: [v0.2.0 → v0.3.0](https://github.com/Azure/go-autorest/autorest/mocks/compare/v0.2.0...v0.3.0)
- github.com/Azure/go-autorest/autorest: [v0.9.0 → v0.9.6](https://github.com/Azure/go-autorest/autorest/compare/v0.9.0...v0.9.6)
- github.com/GoogleCloudPlatform/k8s-cloud-provider: [27a4ced → 7901bc8](https://github.com/GoogleCloudPlatform/k8s-cloud-provider/compare/27a4ced...7901bc8)
- github.com/Microsoft/go-winio: [v0.4.14 → fc70bd9](https://github.com/Microsoft/go-winio/compare/v0.4.14...fc70bd9)
- github.com/alecthomas/template: [a0175ee → fb15b89](https://github.com/alecthomas/template/compare/a0175ee...fb15b89)
- github.com/alecthomas/units: [2efee85 → c3de453](https://github.com/alecthomas/units/compare/2efee85...c3de453)
- github.com/beorn7/perks: [v1.0.0 → v1.0.1](https://github.com/beorn7/perks/compare/v1.0.0...v1.0.1)
- github.com/checkpoint-restore/go-criu: [17b0214 → bdb7599](https://github.com/checkpoint-restore/go-criu/compare/17b0214...bdb7599)
- github.com/cilium/ebpf: [95b36a5 → d9fb101](https://github.com/cilium/ebpf/compare/95b36a5...d9fb101)
- github.com/containerd/console: [84eeaae → v1.0.0](https://github.com/containerd/console/compare/84eeaae...v1.0.0)
- github.com/containerd/containerd: [v1.0.2 → v1.3.3](https://github.com/containerd/containerd/compare/v1.0.2...v1.3.3)
- github.com/containerd/typeurl: [2a93cfd → v1.0.0](https://github.com/containerd/typeurl/compare/2a93cfd...v1.0.0)
- github.com/coreos/pkg: [97fdf19 → 399ea9e](https://github.com/coreos/pkg/compare/97fdf19...399ea9e)
- github.com/docker/docker: [be7ac8b → aa6a989](https://github.com/docker/docker/compare/be7ac8b...aa6a989)
- github.com/fsnotify/fsnotify: [v1.4.7 → v1.4.9](https://github.com/fsnotify/fsnotify/compare/v1.4.7...v1.4.9)
- github.com/go-kit/kit: [v0.8.0 → v0.9.0](https://github.com/go-kit/kit/compare/v0.8.0...v0.9.0)
- github.com/go-logfmt/logfmt: [v0.3.0 → v0.4.0](https://github.com/go-logfmt/logfmt/compare/v0.3.0...v0.4.0)
- github.com/godbus/dbus: [2ff6f7f → ade71ed](https://github.com/godbus/dbus/compare/2ff6f7f...ade71ed)
- github.com/golang/groupcache: [02826c3 → 215e871](https://github.com/golang/groupcache/compare/02826c3...215e871)
- github.com/golang/protobuf: [v1.3.2 → v1.4.2](https://github.com/golang/protobuf/compare/v1.3.2...v1.4.2)
- github.com/google/cadvisor: [v0.35.0 → 6a8d614](https://github.com/google/cadvisor/compare/v0.35.0...6a8d614)
- github.com/google/go-cmp: [v0.3.0 → v0.4.0](https://github.com/google/go-cmp/compare/v0.3.0...v0.4.0)
- github.com/google/pprof: [3ea8567 → d4f498a](https://github.com/google/pprof/compare/3ea8567...d4f498a)
- github.com/googleapis/gax-go/v2: [v2.0.4 → v2.0.5](https://github.com/googleapis/gax-go/v2/compare/v2.0.4...v2.0.5)
- github.com/googleapis/gnostic: [v0.1.0 → v0.4.1](https://github.com/googleapis/gnostic/compare/v0.1.0...v0.4.1)
- github.com/gorilla/mux: [v1.7.0 → v1.7.3](https://github.com/gorilla/mux/compare/v1.7.0...v1.7.3)
- github.com/json-iterator/go: [v1.1.8 → v1.1.9](https://github.com/json-iterator/go/compare/v1.1.8...v1.1.9)
- github.com/jstemmer/go-junit-report: [af01ea7 → v0.9.1](https://github.com/jstemmer/go-junit-report/compare/af01ea7...v0.9.1)
- github.com/konsorten/go-windows-terminal-sequences: [v1.0.1 → v1.0.2](https://github.com/konsorten/go-windows-terminal-sequences/compare/v1.0.1...v1.0.2)
- github.com/kr/pretty: [v0.1.0 → v0.2.0](https://github.com/kr/pretty/compare/v0.1.0...v0.2.0)
- github.com/mattn/go-isatty: [v0.0.9 → v0.0.4](https://github.com/mattn/go-isatty/compare/v0.0.9...v0.0.4)
- github.com/matttproud/golang_protobuf_extensions: [v1.0.1 → c182aff](https://github.com/matttproud/golang_protobuf_extensions/compare/v1.0.1...c182aff)
- github.com/mistifyio/go-zfs: [v2.1.1+incompatible → f784269](https://github.com/mistifyio/go-zfs/compare/v2.1.1...f784269)
- github.com/opencontainers/runtime-spec: [v1.0.0 → v1.0.2](https://github.com/opencontainers/runtime-spec/compare/v1.0.0...v1.0.2)
- github.com/opencontainers/selinux: [5215b18 → v1.3.3](https://github.com/opencontainers/selinux/compare/5215b18...v1.3.3)
- github.com/pkg/errors: [v0.8.1 → v0.9.1](https://github.com/pkg/errors/compare/v0.8.1...v0.9.1)
- github.com/prometheus/client_golang: [v1.0.0 → v1.6.0](https://github.com/prometheus/client_golang/compare/v1.0.0...v1.6.0)
- github.com/prometheus/common: [v0.4.1 → v0.9.1](https://github.com/prometheus/common/compare/v0.4.1...v0.9.1)
- github.com/prometheus/procfs: [v0.0.2 → v0.0.11](https://github.com/prometheus/procfs/compare/v0.0.2...v0.0.11)
- github.com/spf13/cobra: [v0.0.5 → v1.0.0](https://github.com/spf13/cobra/compare/v0.0.5...v1.0.0)
- github.com/spf13/viper: [v1.3.2 → v1.4.0](https://github.com/spf13/viper/compare/v1.3.2...v1.4.0)
- github.com/tmc/grpc-websocket-proxy: [89b8d40 → 0ad062e](https://github.com/tmc/grpc-websocket-proxy/compare/89b8d40...0ad062e)
- github.com/vishvananda/netlink: [v1.0.0 → v1.1.0](https://github.com/vishvananda/netlink/compare/v1.0.0...v1.1.0)
- github.com/vishvananda/netns: [be1fbed → 0a2b9b5](https://github.com/vishvananda/netns/compare/be1fbed...0a2b9b5)
- go.etcd.io/etcd: 3cf2f69 → e694b7b
- go.opencensus.io: v0.21.0 → v0.22.2
- go.uber.org/atomic: v1.3.2 → v1.4.0
- golang.org/x/exp: 4b39c73 → da58074
- golang.org/x/image: 0694c2d → cff245a
- golang.org/x/lint: 959b441 → fdd1cda
- golang.org/x/mobile: d3739f8 → d2bd2a2
- golang.org/x/mod: 4bf6d31 → v0.1.0
- golang.org/x/net: 13f9640 → d3edc99
- golang.org/x/oauth2: 0f29369 → 858c2ad
- golang.org/x/time: 9d24e82 → 555d28b
- golang.org/x/xerrors: a985d34 → 9bdfabe
- google.golang.org/api: 5213b80 → v0.15.1
- google.golang.org/appengine: v1.5.0 → v1.6.5
- google.golang.org/genproto: 24fa4b2 → ca5a221
- gopkg.in/check.v1: 788fd78 → 41f04d3
- honnef.co/go/tools: v0.0.1-2019.2.2 → v0.0.1-2019.2.3
- k8s.io/gengo: 36b2048 → 8167cfd
- k8s.io/kube-openapi: bf4fb3b → 656914f
- k8s.io/system-validators: v1.0.4 → v1.1.2
- k8s.io/utils: 0a110f9 → 2df71eb
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.7 → 33b9978

### Removed
- github.com/OpenPeeDeeP/depguard: [v1.0.1](https://github.com/OpenPeeDeeP/depguard/tree/v1.0.1)
- github.com/Rican7/retry: [v0.1.0](https://github.com/Rican7/retry/tree/v0.1.0)
- github.com/StackExchange/wmi: [5d04971](https://github.com/StackExchange/wmi/tree/5d04971)
- github.com/anmitsu/go-shlex: [648efa6](https://github.com/anmitsu/go-shlex/tree/648efa6)
- github.com/bazelbuild/bazel-gazelle: [70208cb](https://github.com/bazelbuild/bazel-gazelle/tree/70208cb)
- github.com/bazelbuild/buildtools: [69366ca](https://github.com/bazelbuild/buildtools/tree/69366ca)
- github.com/bazelbuild/rules_go: [6dae44d](https://github.com/bazelbuild/rules_go/tree/6dae44d)
- github.com/bradfitz/go-smtpd: [deb6d62](https://github.com/bradfitz/go-smtpd/tree/deb6d62)
- github.com/cespare/prettybench: [03b8cfe](https://github.com/cespare/prettybench/tree/03b8cfe)
- github.com/client9/misspell: [v0.3.4](https://github.com/client9/misspell/tree/v0.3.4)
- github.com/coreos/go-etcd: [v2.0.0+incompatible](https://github.com/coreos/go-etcd/tree/v2.0.0)
- github.com/docker/libnetwork: [c8a5fca](https://github.com/docker/libnetwork/tree/c8a5fca)
- github.com/gliderlabs/ssh: [v0.1.1](https://github.com/gliderlabs/ssh/tree/v0.1.1)
- github.com/go-critic/go-critic: [1df3008](https://github.com/go-critic/go-critic/tree/1df3008)
- github.com/go-lintpack/lintpack: [v0.5.2](https://github.com/go-lintpack/lintpack/tree/v0.5.2)
- github.com/go-ole/go-ole: [v1.2.1](https://github.com/go-ole/go-ole/tree/v1.2.1)
- github.com/go-toolsmith/astcast: [v1.0.0](https://github.com/go-toolsmith/astcast/tree/v1.0.0)
- github.com/go-toolsmith/astcopy: [v1.0.0](https://github.com/go-toolsmith/astcopy/tree/v1.0.0)
- github.com/go-toolsmith/astequal: [v1.0.0](https://github.com/go-toolsmith/astequal/tree/v1.0.0)
- github.com/go-toolsmith/astfmt: [v1.0.0](https://github.com/go-toolsmith/astfmt/tree/v1.0.0)
- github.com/go-toolsmith/astinfo: [9809ff7](https://github.com/go-toolsmith/astinfo/tree/9809ff7)
- github.com/go-toolsmith/astp: [v1.0.0](https://github.com/go-toolsmith/astp/tree/v1.0.0)
- github.com/go-toolsmith/pkgload: [v1.0.0](https://github.com/go-toolsmith/pkgload/tree/v1.0.0)
- github.com/go-toolsmith/strparse: [v1.0.0](https://github.com/go-toolsmith/strparse/tree/v1.0.0)
- github.com/go-toolsmith/typep: [v1.0.0](https://github.com/go-toolsmith/typep/tree/v1.0.0)
- github.com/gobwas/glob: [v0.2.3](https://github.com/gobwas/glob/tree/v0.2.3)
- github.com/golangci/check: [cfe4005](https://github.com/golangci/check/tree/cfe4005)
- github.com/golangci/dupl: [3e9179a](https://github.com/golangci/dupl/tree/3e9179a)
- github.com/golangci/errcheck: [ef45e06](https://github.com/golangci/errcheck/tree/ef45e06)
- github.com/golangci/go-misc: [927a3d8](https://github.com/golangci/go-misc/tree/927a3d8)
- github.com/golangci/go-tools: [e32c541](https://github.com/golangci/go-tools/tree/e32c541)
- github.com/golangci/goconst: [041c5f2](https://github.com/golangci/goconst/tree/041c5f2)
- github.com/golangci/gocyclo: [2becd97](https://github.com/golangci/gocyclo/tree/2becd97)
- github.com/golangci/gofmt: [0b8337e](https://github.com/golangci/gofmt/tree/0b8337e)
- github.com/golangci/golangci-lint: [v1.18.0](https://github.com/golangci/golangci-lint/tree/v1.18.0)
- github.com/golangci/gosec: [66fb7fc](https://github.com/golangci/gosec/tree/66fb7fc)
- github.com/golangci/ineffassign: [42439a7](https://github.com/golangci/ineffassign/tree/42439a7)
- github.com/golangci/lint-1: [ee948d0](https://github.com/golangci/lint-1/tree/ee948d0)
- github.com/golangci/maligned: [b1d8939](https://github.com/golangci/maligned/tree/b1d8939)
- github.com/golangci/misspell: [950f5d1](https://github.com/golangci/misspell/tree/950f5d1)
- github.com/golangci/prealloc: [215b22d](https://github.com/golangci/prealloc/tree/215b22d)
- github.com/golangci/revgrep: [d9c87f5](https://github.com/golangci/revgrep/tree/d9c87f5)
- github.com/golangci/unconvert: [28b1c44](https://github.com/golangci/unconvert/tree/28b1c44)
- github.com/google/go-github: [v17.0.0+incompatible](https://github.com/google/go-github/tree/v17.0.0)
- github.com/google/go-querystring: [v1.0.0](https://github.com/google/go-querystring/tree/v1.0.0)
- github.com/gostaticanalysis/analysisutil: [v0.0.3](https://github.com/gostaticanalysis/analysisutil/tree/v0.0.3)
- github.com/jellevandenhooff/dkim: [f50fe3d](https://github.com/jellevandenhooff/dkim/tree/f50fe3d)
- github.com/klauspost/compress: [v1.4.1](https://github.com/klauspost/compress/tree/v1.4.1)
- github.com/logrusorgru/aurora: [a7b3b31](https://github.com/logrusorgru/aurora/tree/a7b3b31)
- github.com/mattn/go-shellwords: [v1.0.5](https://github.com/mattn/go-shellwords/tree/v1.0.5)
- github.com/mattn/goveralls: [v0.0.2](https://github.com/mattn/goveralls/tree/v0.0.2)
- github.com/mesos/mesos-go: [v0.0.9](https://github.com/mesos/mesos-go/tree/v0.0.9)
- github.com/mitchellh/go-ps: [4fdf99a](https://github.com/mitchellh/go-ps/tree/4fdf99a)
- github.com/mozilla/tls-observatory: [8791a20](https://github.com/mozilla/tls-observatory/tree/8791a20)
- github.com/nbutton23/zxcvbn-go: [eafdab6](https://github.com/nbutton23/zxcvbn-go/tree/eafdab6)
- github.com/pquerna/ffjson: [af8b230](https://github.com/pquerna/ffjson/tree/af8b230)
- github.com/quasilyte/go-consistent: [c6f3937](https://github.com/quasilyte/go-consistent/tree/c6f3937)
- github.com/ryanuber/go-glob: [256dc44](https://github.com/ryanuber/go-glob/tree/256dc44)
- github.com/shirou/gopsutil: [c95755e](https://github.com/shirou/gopsutil/tree/c95755e)
- github.com/shirou/w32: [bb4de01](https://github.com/shirou/w32/tree/bb4de01)
- github.com/shurcooL/go-goon: [37c2f52](https://github.com/shurcooL/go-goon/tree/37c2f52)
- github.com/shurcooL/go: [9e1955d](https://github.com/shurcooL/go/tree/9e1955d)
- github.com/sourcegraph/go-diff: [v0.5.1](https://github.com/sourcegraph/go-diff/tree/v0.5.1)
- github.com/tarm/serial: [98f6abe](https://github.com/tarm/serial/tree/98f6abe)
- github.com/timakin/bodyclose: [87058b9](https://github.com/timakin/bodyclose/tree/87058b9)
- github.com/ugorji/go/codec: [d75b2dc](https://github.com/ugorji/go/codec/tree/d75b2dc)
- github.com/ultraware/funlen: [v0.0.2](https://github.com/ultraware/funlen/tree/v0.0.2)
- github.com/valyala/bytebufferpool: [v1.0.0](https://github.com/valyala/bytebufferpool/tree/v1.0.0)
- github.com/valyala/fasthttp: [v1.2.0](https://github.com/valyala/fasthttp/tree/v1.2.0)
- github.com/valyala/quicktemplate: [v1.1.1](https://github.com/valyala/quicktemplate/tree/v1.1.1)
- github.com/valyala/tcplisten: [ceec8f9](https://github.com/valyala/tcplisten/tree/ceec8f9)
- go4.org: 417644f
- golang.org/x/build: 2835ba2
- golang.org/x/perf: 6e6d33e
- gopkg.in/airbrake/gobrake.v2: v2.0.9
- gopkg.in/gemnasium/logrus-airbrake-hook.v2: v2.1.2
- gotest.tools/gotestsum: v0.3.5
- grpc.go4.org: 11d0a25
- k8s.io/klog: v1.0.0
- k8s.io/repo-infra: v0.0.1-alpha.1
- mvdan.cc/interfacer: c200402
- mvdan.cc/lint: adc824a
- mvdan.cc/unparam: fbb5962
- sourcegraph.com/sqs/pbtypes: d3ebe8f
