# v1.19.0-alpha.2

## Changelog since v1.18.0-rc.1

## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

- Kubeadm now respects user specified etcd versions in the ClusterConfiguration and properly uses them. If users do not want to stick to the version specified in the ClusterConfiguration, they should edit the kubeadm-config config map and delete it. ([#89588](https://github.com/kubernetes/kubernetes/pull/89588), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]

## Changes by Kind

### Deprecation

- Kubernetes no longer supports building hyperkube images ([#88676](https://github.com/kubernetes/kubernetes/pull/88676), [@dims](https://github.com/dims)) [SIG Cluster Lifecycle and Release]

### API Change

- K8s.io/apimachinery - scheme.Convert() now uses only explicitly registered conversions - default reflection based conversion is no longer available. `+k8s:conversion-gen` tags can be used with the `k8s.io/code-generator` component to generate conversions. ([#90018](https://github.com/kubernetes/kubernetes/pull/90018), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery, Apps and Testing]
- Kube-proxy: add `--bind-address-hard-fail` flag to treat failure to bind to a port as fatal ([#89350](https://github.com/kubernetes/kubernetes/pull/89350), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle and Network]
- Kubelet's --runonce option is now also available in Kubelet's config file as `runOnce`. ([#89128](https://github.com/kubernetes/kubernetes/pull/89128), [@vincent178](https://github.com/vincent178)) [SIG Node]
- Promote Immutable Secrets/ConfigMaps feature to Beta and enable the feature by default.
  This allows to set `Immutable` field in Secrets or ConfigMap object to mark their contents as immutable. ([#89594](https://github.com/kubernetes/kubernetes/pull/89594), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps and Testing]
- Remove kubescheduler.config.k8s.io/v1alpha1 ([#89298](https://github.com/kubernetes/kubernetes/pull/89298), [@gavinfish](https://github.com/gavinfish)) [SIG Scheduling]
- ServiceAppProtocol feature gate is now beta and enabled by default, adding new AppProtocol field to Services and Endpoints. ([#90023](https://github.com/kubernetes/kubernetes/pull/90023), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- The Kubelet's `--volume-plugin-dir` option is now available via the Kubelet config file field `VolumePluginDir`. ([#88480](https://github.com/kubernetes/kubernetes/pull/88480), [@savitharaghunathan](https://github.com/savitharaghunathan)) [SIG Node]

### Feature

- deps: Update to Golang 1.13.9
  - build: Remove kube-cross image building ([#89275](https://github.com/kubernetes/kubernetes/pull/89275), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]
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
- Support create or update VMSS asynchronously. ([#89248](https://github.com/kubernetes/kubernetes/pull/89248), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Support for running on a host that uses cgroups v2 unified mode ([#85218](https://github.com/kubernetes/kubernetes/pull/85218), [@giuseppe](https://github.com/giuseppe)) [SIG Node]
- Update etcd client side to v3.4.4 ([#89169](https://github.com/kubernetes/kubernetes/pull/89169), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Update etcd client side to v3.4.7 ([#89822](https://github.com/kubernetes/kubernetes/pull/89822), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Upgrade to azure-sdk v40.2.0 ([#89105](https://github.com/kubernetes/kubernetes/pull/89105), [@andyzhangx](https://github.com/andyzhangx)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Storage and Testing]

### Documentation

- Improved error message for incorrect auth field. ([#82829](https://github.com/kubernetes/kubernetes/pull/82829), [@martin-schibsted](https://github.com/martin-schibsted)) [SIG Auth]
- Updated the instructions for deploying the sample app. ([#82785](https://github.com/kubernetes/kubernetes/pull/82785), [@ashish-billore](https://github.com/ashish-billore)) [SIG API Machinery]

### Bug or Regression

- A PV set from in-tree source will have ordered requirement values in NodeAffinity when converted to CSIPersistentVolumeSource ([#88987](https://github.com/kubernetes/kubernetes/pull/88987), [@jiahuif](https://github.com/jiahuif)) [SIG Storage]
- An issue preventing GCP cloud-controller-manager running out-of-cluster to initialize new Nodes is now fixed. ([#90057](https://github.com/kubernetes/kubernetes/pull/90057), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Apps and Cloud Provider]
- Avoid GCE API calls when initializing GCE CloudProvider for Kubelets. ([#90218](https://github.com/kubernetes/kubernetes/pull/90218), [@wojtek-t](https://github.com/wojtek-t)) [SIG Cloud Provider and Scalability]
- Avoid unnecessary GCE API calls when adding IP alises or reflecting them in Node object in GCE cloud provider. ([#90242](https://github.com/kubernetes/kubernetes/pull/90242), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps, Cloud Provider and Network]
- Azure auth module for kubectl now requests login after refresh token expires. ([#86481](https://github.com/kubernetes/kubernetes/pull/86481), [@tdihp](https://github.com/tdihp)) [SIG API Machinery and Auth]
- Azure: fix concurreny issue in lb creation ([#89604](https://github.com/kubernetes/kubernetes/pull/89604), [@aramase](https://github.com/aramase)) [SIG Cloud Provider]
- Bug fix for AWS NLB service when nodePort for existing servicePort changed manually. ([#89562](https://github.com/kubernetes/kubernetes/pull/89562), [@M00nF1sh](https://github.com/M00nF1sh)) [SIG Cloud Provider]
- CSINode initialization does not crash kubelet on startup when APIServer is not reachable or kubelet has not the right credentials yet. ([#89589](https://github.com/kubernetes/kubernetes/pull/89589), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Client-go: resolves an issue with informers falling back to full list requests when timeouts are encountered, rather than re-establishing a watch. ([#89652](https://github.com/kubernetes/kubernetes/pull/89652), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- Dual-stack: fix the bug that Service clusterIP does not respect specified ipFamily ([#89612](https://github.com/kubernetes/kubernetes/pull/89612), [@SataQiu](https://github.com/SataQiu)) [SIG Network]
- Ensure Azure availability zone is always in lower cases. ([#89722](https://github.com/kubernetes/kubernetes/pull/89722), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Explain CRDs whose resource name are the same as builtin objects ([#89505](https://github.com/kubernetes/kubernetes/pull/89505), [@knight42](https://github.com/knight42)) [SIG API Machinery, CLI and Testing]
- Fix a bug that didn't allow to use IPv6 addresses with leading zeros ([#89341](https://github.com/kubernetes/kubernetes/pull/89341), [@aojea](https://github.com/aojea)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fix bug with xfs_repair from stopping xfs mount ([#89444](https://github.com/kubernetes/kubernetes/pull/89444), [@gnufied](https://github.com/gnufied)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Fix detection of SystemOOMs in which the victim is a container. ([#88871](https://github.com/kubernetes/kubernetes/pull/88871), [@dashpole](https://github.com/dashpole)) [SIG Node]
- Fix flaws in Azure File CSI translation ([#90162](https://github.com/kubernetes/kubernetes/pull/90162), [@rfranzke](https://github.com/rfranzke)) [SIG Release and Storage]
- Fix kube-apiserver startup to wait for APIServices to be installed into the HTTP handler before reporting readiness. ([#89147](https://github.com/kubernetes/kubernetes/pull/89147), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- Fix kubectl describe CSINode nil pointer error ([#89646](https://github.com/kubernetes/kubernetes/pull/89646), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix kubectl diff so it doesn't actually persist patches ([#89795](https://github.com/kubernetes/kubernetes/pull/89795), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- Fix kubectl version should print version info without config file ([#89913](https://github.com/kubernetes/kubernetes/pull/89913), [@zhouya0](https://github.com/zhouya0)) [SIG API Machinery and CLI]
- Fix missing `-c` shorthand for `--container` flag of `kubectl alpha debug` ([#89674](https://github.com/kubernetes/kubernetes/pull/89674), [@superbrothers](https://github.com/superbrothers)) [SIG CLI]
- Fix printers ignoring object average value ([#89142](https://github.com/kubernetes/kubernetes/pull/89142), [@zhouya0](https://github.com/zhouya0)) [SIG API Machinery]
- Fix scheduler crash when removing node before its pods ([#89908](https://github.com/kubernetes/kubernetes/pull/89908), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix the VMSS name and resource group name when updating Azure VMSS for LoadBalancer backendPools ([#89337](https://github.com/kubernetes/kubernetes/pull/89337), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix: get attach disk error due to missing item in max count table ([#89768](https://github.com/kubernetes/kubernetes/pull/89768), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fixed a bug where executing a kubectl command with a jsonpath output expression that has a nested range would ignore expressions following the nested range. ([#88464](https://github.com/kubernetes/kubernetes/pull/88464), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery]
- Fixed a regression running kubectl commands with  --local or --dry-run flags when no kubeconfig file is present ([#90243](https://github.com/kubernetes/kubernetes/pull/90243), [@soltysh](https://github.com/soltysh)) [SIG API Machinery, CLI and Testing]
- Fixed an issue mounting credentials for service accounts whose name contains `.` characters ([#89696](https://github.com/kubernetes/kubernetes/pull/89696), [@nabokihms](https://github.com/nabokihms)) [SIG Auth]
- Fixed bug where a nonzero exit code was returned when initializing zsh completion even though zsh completion was successfully initialized ([#88165](https://github.com/kubernetes/kubernetes/pull/88165), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed mountOptions in iSCSI and FibreChannel volume plugins. ([#89172](https://github.com/kubernetes/kubernetes/pull/89172), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed the EndpointSlice controller to run without error on a cluster with the OwnerReferencesPermissionEnforcement validating admission plugin enabled. ([#89741](https://github.com/kubernetes/kubernetes/pull/89741), [@marun](https://github.com/marun)) [SIG Auth and Network]
- Fixes a bug defining a default value for a replicas field in a custom resource definition that has the scale subresource enabled ([#89833](https://github.com/kubernetes/kubernetes/pull/89833), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fixes conversion error for HorizontalPodAutoscaler objects with invalid annotations ([#89963](https://github.com/kubernetes/kubernetes/pull/89963), [@liggitt](https://github.com/liggitt)) [SIG Autoscaling]
- Fixes kubectl to apply all validly built objects, instead of stopping on error. ([#89848](https://github.com/kubernetes/kubernetes/pull/89848), [@seans3](https://github.com/seans3)) [SIG CLI and Testing]
- Fixes v1.18.0-rc.1 regression in `kubectl port-forward` when specifying a local and remote port ([#89401](https://github.com/kubernetes/kubernetes/pull/89401), [@liggitt](https://github.com/liggitt)) [SIG CLI]
- For GCE cluster provider, fix bug of not being able to create internal type load balancer for clusters with more than 1000 nodes in a single zone. ([#89902](https://github.com/kubernetes/kubernetes/pull/89902), [@wojtek-t](https://github.com/wojtek-t)) [SIG Cloud Provider, Network and Scalability]
- If firstTimestamp is not set use eventTime when printing event ([#89999](https://github.com/kubernetes/kubernetes/pull/89999), [@soltysh](https://github.com/soltysh)) [SIG CLI]
- If we set parameter cgroupPerQos=false and cgroupRoot=/docker，this function will retrun  nodeAllocatableRoot=/docker/kubepods, it is not right, the correct return should be /docker.
  cm.NodeAllocatableRoot(s.CgroupRoot, s.CgroupDriver)
  
  kubeDeps.CAdvisorInterface, err = cadvisor.New(imageFsInfoProvider, s.RootDirectory, cgroupRoots, cadvisor.UsingLegacyCadvisorStats(s.ContainerRuntime, s.RemoteRuntimeEndpoint))
  the above funtion，as we use cgroupRoots to create cadvisor interface，the wrong parameter cgroupRoots will lead eviction manager not  to collect metric from /docker, then kubelet frequently print those error：
  E0303 17:25:03.436781 63839 summary_sys_containers.go:47] Failed to get system container stats for "/docker": failed to get cgroup stats for "/docker": failed to get container info for "/docker": unknown container "/docker"
  E0303 17:25:03.436809 63839 helpers.go:680] eviction manager: failed to construct signal: "allocatableMemory.available" error: system container "pods" not found in metrics ([#88970](https://github.com/kubernetes/kubernetes/pull/88970), [@mysunshine92](https://github.com/mysunshine92)) [SIG Node]
- In the kubelet resource metrics endpoint at /metrics/resource, change the names of the following metrics:
  - node_cpu_usage_seconds --> node_cpu_usage_seconds_total
  - container_cpu_usage_seconds --> container_cpu_usage_seconds_total
  This is a partial revert of &#35;86282, which was added in 1.18.0, and initially removed the _total suffix ([#89540](https://github.com/kubernetes/kubernetes/pull/89540), [@dashpole](https://github.com/dashpole)) [SIG Instrumentation and Node]
- Ipvs: only attempt setting of sysctlconnreuse on supported kernels ([#88541](https://github.com/kubernetes/kubernetes/pull/88541), [@cmluciano](https://github.com/cmluciano)) [SIG Network]
- Kube-apiserver: multiple comma-separated protocols in a single X-Stream-Protocol-Version header are now recognized, in addition to multiple headers, complying with RFC2616 ([#89857](https://github.com/kubernetes/kubernetes/pull/89857), [@tedyu](https://github.com/tedyu)) [SIG API Machinery]
- Kubeadm increased to 5 minutes its timeout for the TLS bootstrapping process to complete upon join ([#89735](https://github.com/kubernetes/kubernetes/pull/89735), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: during join when a check is performed that a Node with the same name already exists in the cluster, make sure the NodeReady condition is properly validated ([#89602](https://github.com/kubernetes/kubernetes/pull/89602), [@kvaps](https://github.com/kvaps)) [SIG Cluster Lifecycle]
- Kubeadm: ensure `image-pull-timeout` flag is respected during upgrade phase ([#90328](https://github.com/kubernetes/kubernetes/pull/90328), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where post upgrade to 1.18.x, nodes cannot join the cluster due to missing RBAC ([#89537](https://github.com/kubernetes/kubernetes/pull/89537), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fix misleading warning about passing control-plane related flags on 'kubeadm join' ([#89596](https://github.com/kubernetes/kubernetes/pull/89596), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fix misleading warning for the kube-apiserver authz modes during "kubeadm init" ([#90064](https://github.com/kubernetes/kubernetes/pull/90064), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubectl azure authentication: fixed a regression in 1.18.0 where "spn:" prefix was unexpectedly added to the `apiserver-id` configuration in the kubeconfig file ([#89706](https://github.com/kubernetes/kubernetes/pull/89706), [@weinong](https://github.com/weinong)) [SIG API Machinery and Auth]
- Kubelet: fix the bug that kubelet help information can not show the right type of flags ([#88515](https://github.com/kubernetes/kubernetes/pull/88515), [@SataQiu](https://github.com/SataQiu)) [SIG Docs and Node]
- Node ([#89677](https://github.com/kubernetes/kubernetes/pull/89677), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Resolved a regression in v1.18.0-rc.1 mounting windows volumes ([#89319](https://github.com/kubernetes/kubernetes/pull/89319), [@mboersma](https://github.com/mboersma)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Restore the ability to `kubectl apply --prune` without --namespace flag.  Since 1.17, `kubectl apply --prune` only prunes resources in the default namespace (or from kubeconfig) or explicitly specified in command line flag.  But this is s breaking change from kubectl 1.16, which can prune resources in all namespace in config file.  This patch restores the kubectl 1.16 behaviour. ([#89551](https://github.com/kubernetes/kubernetes/pull/89551), [@tatsuhiro-t](https://github.com/tatsuhiro-t)) [SIG CLI and Testing]
- Restores priority of static control plane pods in the cluster/gce/manifests control-plane manifests ([#89970](https://github.com/kubernetes/kubernetes/pull/89970), [@liggitt](https://github.com/liggitt)) [SIG Cluster Lifecycle and Node]
- Service account tokens bound to pods can now be used during the pod deletion grace period. ([#89583](https://github.com/kubernetes/kubernetes/pull/89583), [@liggitt](https://github.com/liggitt)) [SIG Auth]
- Sync LB backend nodes for Service Type=LoadBalancer on Add/Delete node events. ([#81185](https://github.com/kubernetes/kubernetes/pull/81185), [@andrewsykim](https://github.com/andrewsykim)) [SIG Apps and Network]
- Wait for all CRDs to show up in discovery endpoint before reporting readiness. ([#89145](https://github.com/kubernetes/kubernetes/pull/89145), [@sttts](https://github.com/sttts)) [SIG API Machinery]

### Other (Cleanup or Flake)

- Beta.kubernetes.io/arch is already deprecated since v1.14, are targeted for removal in v1.18 ([#89462](https://github.com/kubernetes/kubernetes/pull/89462), [@wawa0210](https://github.com/wawa0210)) [SIG Testing]
- Change beta.kubernetes.io/os  to kubernetes.io/os ([#89460](https://github.com/kubernetes/kubernetes/pull/89460), [@wawa0210](https://github.com/wawa0210)) [SIG Testing and Windows]
- Changes not found message when using `kubectl get` to retrieve not namespaced resources ([#89861](https://github.com/kubernetes/kubernetes/pull/89861), [@rccrdpccl](https://github.com/rccrdpccl)) [SIG CLI]
- Deprecate kubectl top flags related to heapster
  Drop support of heapster in kubectl top ([#87498](https://github.com/kubernetes/kubernetes/pull/87498), [@serathius](https://github.com/serathius)) [SIG CLI]
- Kube-proxy exposes a new metric, `kubeproxy_sync_proxy_rules_last_queued_timestamp_seconds`, that indicates the last time a change for kube-proxy was queued to be applied. ([#90175](https://github.com/kubernetes/kubernetes/pull/90175), [@squeed](https://github.com/squeed)) [SIG Instrumentation and Network]
- None. ([#90273](https://github.com/kubernetes/kubernetes/pull/90273), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Reduce event spam during a volume operation error. ([#89794](https://github.com/kubernetes/kubernetes/pull/89794), [@msau42](https://github.com/msau42)) [SIG Storage]
- Scheduler PreScore plugins are not executed if there is one filtered node or less. ([#89370](https://github.com/kubernetes/kubernetes/pull/89370), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- The PR adds functionality to generate events when a PV or PVC processing encounters certain failures. The events help users to know the reason for the failure so they can take necessary recovery actions. ([#89845](https://github.com/kubernetes/kubernetes/pull/89845), [@yuga711](https://github.com/yuga711)) [SIG Apps]
- The PodShareProcessNamespace feature gate has been removed, and the PodShareProcessNamespace is unconditionally enabled. ([#90099](https://github.com/kubernetes/kubernetes/pull/90099), [@tanjunchen](https://github.com/tanjunchen)) [SIG Node]
- UI change ([#87743](https://github.com/kubernetes/kubernetes/pull/87743), [@u2takey](https://github.com/u2takey)) [SIG Apps and Node]
- Update default etcd server version to 3.4.4 ([#89214](https://github.com/kubernetes/kubernetes/pull/89214), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cluster Lifecycle and Testing]
- Update default etcd server version to 3.4.7 ([#89895](https://github.com/kubernetes/kubernetes/pull/89895), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cluster Lifecycle and Testing]
- `kubectl config view` now redacts bearer tokens by default, similar to client certificates. The `--raw` flag can still be used to output full content. ([#88985](https://github.com/kubernetes/kubernetes/pull/88985), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery and CLI]