## Changes by Kind

### Deprecation

- Kubectl: removed deprecated flag `prune-whitelist` for apply, use flag `prune-allowlist`. instead. ([#120246](https://github.com/kubernetes/kubernetes/pull/120246), [@pacoxu](https://github.com/pacoxu))

### API Change

- Added `CEL` library for IP Addresses and CIDRs. This will not be available for use until 1.31. ([#121912](https://github.com/kubernetes/kubernetes/pull/121912), [@JoelSpeed](https://github.com/JoelSpeed))
- Added a rule on the `kube_codegen` tool to ignore vendor folder during the code generation. ([#122729](https://github.com/kubernetes/kubernetes/pull/122729), [@jparrill](https://github.com/jparrill))
- Added to MutableFeatureGate the ability to override the default setting of feature gates, to allow default-enabling a feature on a component-by-component basis instead of for all affected components simultaneously. ([#122647](https://github.com/kubernetes/kubernetes/pull/122647), [@benluddy](https://github.com/benluddy)) [SIG API Machinery and Cluster Lifecycle]
- Allowed users to mutate `FSGroupPolicy` and `PodInfoOnMount` in `CSIDriver.Spec`. ([#116209](https://github.com/kubernetes/kubernetes/pull/116209), [@haoruan](https://github.com/haoruan))
- Client-go events: `NewEventBroadcasterAdapterWithContext` should be used instead of `NewEventBroadcasterAdapter` if the goal is to support contextual logging. ([#122142](https://github.com/kubernetes/kubernetes/pull/122142), [@pohly](https://github.com/pohly)) [SIG API Machinery, Instrumentation and Scheduling]
- Fixed accidental enablement of the new alpha `optionalOldSelf` API field in `CustomResourceDefinition` validation rules, which should only be allowed to be set when the `CRDValidationRatcheting` feature gate is enabled. ([#122329](https://github.com/kubernetes/kubernetes/pull/122329), [@jpbetz](https://github.com/jpbetz))
- Implemented  `prescore` extension point for `volumeBinding` plugin. Return skip if it doesn't do anything in Score. ([#115768](https://github.com/kubernetes/kubernetes/pull/115768), [@AxeZhan](https://github.com/AxeZhan))
- Resource.k8s.io/ResourceClaim (alpha API): the strategic merge patch strategy for the `status.reservedFor` array was changed such that a strategic-merge-patch can add individual entries. This breaks clients using strategic merge patch to update status which rely on the previous behavior (replacing the entire array). ([#122276](https://github.com/kubernetes/kubernetes/pull/122276), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- When scheduling a mixture of pods using `ResourceClaims` and others which don't, scheduling a pod with `ResourceClaims` impacts scheduling latency less. ([#121876](https://github.com/kubernetes/kubernetes/pull/121876), [@pohly](https://github.com/pohly))

### Feature

- Added Timezone column in the output of kubectl get cronjob command. ([#122231](https://github.com/kubernetes/kubernetes/pull/122231), [@ardaguclu](https://github.com/ardaguclu))
- Added `WatchListClient` feature gate to `client-go`. When enabled it allows the client to get a stream of individual items instead of chunking from the server. ([#122571](https://github.com/kubernetes/kubernetes/pull/122571), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Added `exec-interactive-mode` and `exec-provide-cluster-info` flags in kubectl config set-credentials command. ([#122023](https://github.com/kubernetes/kubernetes/pull/122023), [@ardaguclu](https://github.com/ardaguclu))
- Added `process_start_time_seconds` to /metrics/slis endpoint of all components ([#122750](https://github.com/kubernetes/kubernetes/pull/122750), [@Richabanker](https://github.com/Richabanker))
- Allowed scheduling framework plugins that implement `io.Closer` to be gracefully closed. ([#122498](https://github.com/kubernetes/kubernetes/pull/122498), [@Gekko0114](https://github.com/Gekko0114))
- Changed `--nodeport-addresses` behavior to default to "primary node IP(s) only" rather than "all node IPs". ([#122724](https://github.com/kubernetes/kubernetes/pull/122724), [@nayihz](https://github.com/nayihz))
- Etcd: build image for v3.5.11 ([#122233](https://github.com/kubernetes/kubernetes/pull/122233), [@mzaian](https://github.com/mzaian)) [SIG API Machinery]
- Informers now support adding Indexers after the informer starts ([#117046](https://github.com/kubernetes/kubernetes/pull/117046), [@howardjohn](https://github.com/howardjohn)) [SIG API Machinery]
- Introduced a feature gate mechanism to `client-go`. Depending on the actual implementation, users can control features via environmental variables or command line options. ([#122555](https://github.com/kubernetes/kubernetes/pull/122555), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Kube-scheduler implements scheduling hints for the NodeAffinity plugin.
  The scheduling hints allow the scheduler to only retry scheduling a Pod
  that was previously rejected by the NodeAffinity plugin if a new Node or a Node update matches the Pod's node affinity. ([#122309](https://github.com/kubernetes/kubernetes/pull/122309), [@carlory](https://github.com/carlory)) [SIG Scheduling]
- Kube-scheduler implements scheduling hints for the NodeResourceFit plugin.
  The scheduling hints allow the scheduler to only retry scheduling a Pod
  that was previously rejected by the NodeResourceFit plugin if a new Node or 
  a Node update matches the Pod's resource requirements or if an old pod update 
  or delete matches the  Pod's resource requirements. ([#119177](https://github.com/kubernetes/kubernetes/pull/119177), [@carlory](https://github.com/carlory)) [SIG Scheduling]
- Kube-scheduler implements scheduling hints for the NodeUnschedulable plugin.
  The scheduling hints allow the scheduler to only retry scheduling a Pod
  that was previously rejected by the NodeSchedulable plugin if a new Node or a Node update sets .spec.unschedulable to false. ([#122334](https://github.com/kubernetes/kubernetes/pull/122334), [@carlory](https://github.com/carlory)) [SIG Scheduling]
- Kube-scheduler implements scheduling hints for the PodTopologySpread plugin.
  The scheduling hints allow the scheduler to retry scheduling a Pod
  that was previously rejected by the PodTopologySpread plugin if create/delete/update a related Pod or a node which matches the toplogyKey. ([#122195](https://github.com/kubernetes/kubernetes/pull/122195), [@nayihz](https://github.com/nayihz)) [SIG Scheduling]
- Kubeadm: added better handling of errors during unmount when calling "kubeadm reset". When failing to unmount directories under "/var/run/kubelet", kubeadm will now throw an error instead of showing a warning and continuing to cleanup said directory. In such situations it is better for you to inspect the problem and resolve it manually, then you can call "kubeadm reset" again to complete the cleanup. ([#122530](https://github.com/kubernetes/kubernetes/pull/122530), [@neolit123](https://github.com/neolit123))
- Kubectl debug: added sysadmin profile ([#119200](https://github.com/kubernetes/kubernetes/pull/119200), [@eiffel-fl](https://github.com/eiffel-fl))
- Kubernetes is now built with Go `1.21.6`. ([#122705](https://github.com/kubernetes/kubernetes/pull/122705), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with go `1.22rc2`. ([#122889](https://github.com/kubernetes/kubernetes/pull/122889), [@cpanato](https://github.com/cpanato))
- Printed more information when kubectl describe a VolumeAttributesClass ([#122640](https://github.com/kubernetes/kubernetes/pull/122640), [@carlory](https://github.com/carlory))
- Promoted `KubeProxyDrainingTerminatingNodes` to `Beta`. ([#122914](https://github.com/kubernetes/kubernetes/pull/122914), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Promoted feature gate `StableLoadBalancerNodeSet` to `GA` . ([#122961](https://github.com/kubernetes/kubernetes/pull/122961), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Scheduler skips NodeAffinity Score plugin when NodeAffinity Score plugin has nothing to do 
  with a Pod. You might notice an increase in the metric `plugin_execution_duration_seconds` for `extension_point=score` `plugin=NodeAffinity`, because the plugin will only run when the plugin is relevant. ([#117024](https://github.com/kubernetes/kubernetes/pull/117024), [@sanposhiho](https://github.com/sanposhiho))
- The option `ignorable` of scheduler extender can skip error both filter and bind. ([#122503](https://github.com/kubernetes/kubernetes/pull/122503), [@sunbinnnnn](https://github.com/sunbinnnnn)) [SIG Scheduling]
- Updated `kubedns` and `nodelocaldns` to release version `1.22.28`. ([#121908](https://github.com/kubernetes/kubernetes/pull/121908), [@mzaian](https://github.com/mzaian))
- Updated some interfaces' signature in scheduler:
  
  1. PluginsRunner: used NodeInfo in `RunPreScorePlugins` and `RunScorePlugins`.
  2. PreScorePlugin: used NodeInfo in `PreScore`.
  3. Extender: used NodeInfo in `Filter` and `Prioritize`. ([#121954](https://github.com/kubernetes/kubernetes/pull/121954), [@AxeZhan](https://github.com/AxeZhan))
- When PreFilterResult filters out some Nodes, the scheduling framework assumes them as rejected via `UnschedulableAndUnresolvable`, 
  that is those nodes won't be in the candidates of preemption process.
  Also, corrected how the scheduling framework handle Unschedulable status from PreFilter. 
  Before this PR, if PreFilter return `Unschedulable`, it may result in an unexpected abortion in the preemption, 
  which shouldn't happen in the default scheduler, but may happen in schedulers with a custom plugin. ([#119779](https://github.com/kubernetes/kubernetes/pull/119779), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- `kubectl describe`: added Suspend to job, and Node-Selectors and Tolerations to pod template output ([#122618](https://github.com/kubernetes/kubernetes/pull/122618), [@ivanvc](https://github.com/ivanvc)) [SIG CLI]

### Documentation

- A deprecated flag `--pod-max-in-unschedulable-pods-duration` was initially planned to be removed in v1.26, but we have to change this plan. We found [an issue](https://github.com/kubernetes/kubernetes/issues/110175) in which Pods can be stuck in the unschedulable pod pool for 5 min, and using this flag is the only workaround for this issue. 
  This issue only could happen if you use custom plugins or if you change plugin set being used in your scheduler via the scheduler config. ([#122013](https://github.com/kubernetes/kubernetes/pull/122013), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Fixed delete pod declare no controllor note. ([#120159](https://github.com/kubernetes/kubernetes/pull/120159), [@Ithrael](https://github.com/Ithrael))

### Bug or Regression

- Added `imagefs.inodesfree` to default `EvictionHard` settings. ([#121834](https://github.com/kubernetes/kubernetes/pull/121834), [@vaibhav2107](https://github.com/vaibhav2107))
- Added metric name along with the utilization information when running kubectl get hpa ([#122804](https://github.com/kubernetes/kubernetes/pull/122804), [@sreeram-venkitesh](https://github.com/sreeram-venkitesh)) [SIG CLI]
- Allowed deletion of pods that use raw block volumes on node reboot. ([#122211](https://github.com/kubernetes/kubernetes/pull/122211), [@gnufied](https://github.com/gnufied))
- Changed the API server so that for admission webhooks that have a URL matching the hostname `localhost`, or a loopback IP address, the connection supports HTTP/2 where it can be negotiated. ([#122558](https://github.com/kubernetes/kubernetes/pull/122558), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery and Testing]
- Etcd: Updated to `v3.5.11`. ([#122393](https://github.com/kubernetes/kubernetes/pull/122393), [@mzaian](https://github.com/mzaian))
- Fix: Ignore unnecessary node events and improve daemonset controller performance. ([#121669](https://github.com/kubernetes/kubernetes/pull/121669), [@xigang](https://github.com/xigang)) [SIG Apps]
- Fix: Mount point may become local without calling `NodePublishVolume` after node rebooting. ([#119923](https://github.com/kubernetes/kubernetes/pull/119923), [@cvvz](https://github.com/cvvz))
- Fixed Windows credential provider, cannot find binary. Windows credential provider binary path may have ".exe" suffix so it is better to use `LookPath()` to support it flexibly. ([#120291](https://github.com/kubernetes/kubernetes/pull/120291), [@lzhecheng](https://github.com/lzhecheng))
- Fixed a bug in ValidatingAdmissionPolicy that caused policies which were using CRD parameters to fail to synchronize ([#123003](https://github.com/kubernetes/kubernetes/pull/123003), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery and Testing]
- Fixed a bug where `kubectl` drain would consider a pod as having been deleted if an error occurs while calling the API. ([#122574](https://github.com/kubernetes/kubernetes/pull/122574), [@brianpursley](https://github.com/brianpursley))
- Fixed a race condition in the iptables mode of kube-proxy in `1.27` and later
  that could result in some updates getting lost (e.g., when a service gets a
  new endpoint, the rules for the new endpoint might not be added until
  much later). ([#122204](https://github.com/kubernetes/kubernetes/pull/122204), [@danwinship](https://github.com/danwinship))
- Fixed a regression since 1.24 in the scheduling framework when overriding MultiPoint plugins (e.g. default plugins).
  The incorrect loop logic might lead to a plugin being loaded multiple times, consequently preventing any Pod from being scheduled, which is unexpected. ([#122068](https://github.com/kubernetes/kubernetes/pull/122068), [@caohe](https://github.com/caohe)) [SIG Scheduling]
- Fixed an issue where kubectl apply could panic when imported as a library ([#122346](https://github.com/kubernetes/kubernetes/pull/122346), [@Jefftree](https://github.com/Jefftree))
- Fixed migration of in-tree vSphere volumes to the CSI driver. ([#122341](https://github.com/kubernetes/kubernetes/pull/122341), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed panic of Evented PLEG during kubelet start-up. ([#122475](https://github.com/kubernetes/kubernetes/pull/122475), [@pacoxu](https://github.com/pacoxu))
- Fixed resource deletion failure caused by quota calculation error when `InPlacePodVerticalScalin         g` is turned on. ([#122701](https://github.com/kubernetes/kubernetes/pull/122701), [@carlory](https://github.com/carlory))
- Fixed the following volume plugins may not create user visible files after kubelet was restarted. 
  - configmap 
  - secret 
  - projected
  - downwardapi ([#122807](https://github.com/kubernetes/kubernetes/pull/122807), [@carlory](https://github.com/carlory))
- For statically provisioned PVs, if its volume source is CSI type or it has #     migrated annotation, when it's deleted, the PersisentVolume controller won't change #     its phase to the Failed state. 
  
  With this patch, the external provisioner can #     remove the finalizer in next reconcile loop. Unfortunately if the provious existing #     pv has the Failed state, this patch won't take effort. It requires users to remove #     finalizer. ([#122030](https://github.com/kubernetes/kubernetes/pull/122030), [@carlory](https://github.com/carlory))
- If a pvc has an empty storageClassName, persistentvolume controller won't try to assign a default StorageClass . ([#122704](https://github.com/kubernetes/kubernetes/pull/122704), [@carlory](https://github.com/carlory))
- Improved scheduler performance when no scoring plugins are defined. ([#122058](https://github.com/kubernetes/kubernetes/pull/122058), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Improved scheduler performance when no scoring plugins are defined. ([#122435](https://github.com/kubernetes/kubernetes/pull/122435), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Kube-proxy: fixed `LoadBalancerSourceRanges` not working for nftables mode ([#122614](https://github.com/kubernetes/kubernetes/pull/122614), [@tnqn](https://github.com/tnqn))
- Kubeadm: fixed a regression in "kubeadm init" that caused a user-specified --kubeconfig file to be ignored. ([#122735](https://github.com/kubernetes/kubernetes/pull/122735), [@avorima](https://github.com/avorima))
- Make decoding etcd's response respect the timeout context. ([#121815](https://github.com/kubernetes/kubernetes/pull/121815), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG API Machinery]
- QueueingHint implementation for NodeAffinity is reverted because we found potential scenarios where events that make Pods schedulable could be missed. ([#122285](https://github.com/kubernetes/kubernetes/pull/122285), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Removed wrong warning event (FileSystemResizeFailed) during a pod creation if it uses a readonly volume and the capacity of the volume is greater or equal to its request storage. ([#122508](https://github.com/kubernetes/kubernetes/pull/122508), [@carlory](https://github.com/carlory))
- Reverted the EventedPLEG feature (beta, but disabled by default) back to alpha for a known issue. ([#122697](https://github.com/kubernetes/kubernetes/pull/122697), [@pacoxu](https://github.com/pacoxu))
- The scheduling queue didn't notice any extenders' failures, it could miss some cluster events,
  and it could end up Pods rejected by Extenders stuck in unschedulable pod pool in 5min in the worst-case scenario.
  Now, the scheduling queue notices extenders' failures and requeue Pods rejected by Extenders appropriately. ([#122022](https://github.com/kubernetes/kubernetes/pull/122022), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Used `errors.Is()` to handle err returned by `LookPath()`. ([#122600](https://github.com/kubernetes/kubernetes/pull/122600), [@lzhecheng](https://github.com/lzhecheng))
- ValidateVolumeAttributesClassUpdate also validates new vac object. ([#122449](https://github.com/kubernetes/kubernetes/pull/122449), [@carlory](https://github.com/carlory)) [SIG Storage]
- When using a claim with immediate allocation and a pod referencing that claim couldn't get scheduled, the scheduler incorrectly may have tried to deallocate that claim. ([#122415](https://github.com/kubernetes/kubernetes/pull/122415), [@pohly](https://github.com/pohly)) [SIG Node and Scheduling]
- `QueueingHint` implementation for `NodeUnschedulable` is reverted because we found potential scenarios where events that make Pods schedulable could be missed. ([#122288](https://github.com/kubernetes/kubernetes/pull/122288), [@sanposhiho](https://github.com/sanposhiho))

### Other (Cleanup or Flake)

- Added warning for `PV` on reclaim policy when it is `Recycle` . ([#122339](https://github.com/kubernetes/kubernetes/pull/122339), [@carlory](https://github.com/carlory))
- Cleanup: removed getStorageAccountName warning messages ([#121983](https://github.com/kubernetes/kubernetes/pull/121983), [@andyzhangx](https://github.com/andyzhangx))
- Client-go: Optimized leaders renewing leases by updating leader lock optimistically without getting the record from the apiserver first. Also added a new metric `leader_election_slowpath_total` that allow users to monitor how many leader elections are updated non-optimistically. ([#122069](https://github.com/kubernetes/kubernetes/pull/122069), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery, Architecture and Instrumentation]
- Kubeadm: improved the overall logic, error handling and output messages when #     waiting for the kubelet and API server /healthz endpoints to return 'ok'. The #     kubelet and API server checks no longer run in parallel, but one after another #     (in serial). ([#121958](https://github.com/kubernetes/kubernetes/pull/121958), [@neolit123](https://github.com/neolit123))
- Kubeadm: show the supported shell types of 'kubeadm completion' in the error message when an invalid shell was specified ([#122477](https://github.com/kubernetes/kubernetes/pull/122477), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: used `ttlSecondsAfterFinished` to automatically clean up the `upgrade-health-check` Job that runs during upgrade preflighting. ([#122079](https://github.com/kubernetes/kubernetes/pull/122079), [@carlory](https://github.com/carlory))
- Locked GA feature-gate `ConsistentHTTPGetHandlers` to default. ([#122578](https://github.com/kubernetes/kubernetes/pull/122578), [@carlory](https://github.com/carlory))
- Migrated `client-go/metadata` to contextual logging. ([#122225](https://github.com/kubernetes/kubernetes/pull/122225), [@ricardoapl](https://github.com/ricardoapl))
- Migrated the cmd/kube-proxy to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#122197](https://github.com/kubernetes/kubernetes/pull/122197), [@fatsheep9146](https://github.com/fatsheep9146)) [SIG Network]
- Removed GA featuregate `RemoveSelfLink`. ([#122468](https://github.com/kubernetes/kubernetes/pull/122468), [@carlory](https://github.com/carlory))
- Removed GA featuregate about `ExperimentalHostUserNamespaceDefaultingGate` in `1.30`. ([#122088](https://github.com/kubernetes/kubernetes/pull/122088), [@bzsuni](https://github.com/bzsuni))
- Removed GA featuregate about `IPTablesOwnershipCleanup` in `1.30`. ([#122137](https://github.com/kubernetes/kubernetes/pull/122137), [@bzsuni](https://github.com/bzsuni))
- Removed generally available feature gate `ExpandedDNSConfig`. ([#122086](https://github.com/kubernetes/kubernetes/pull/122086), [@bzsuni](https://github.com/bzsuni)) [SIG Network]
- Removed generally available feature gate `KubeletPodResourcesGetAllocatable`. ([#122138](https://github.com/kubernetes/kubernetes/pull/122138), [@ii2day](https://github.com/ii2day)) [SIG Node]
- Removed generally available feature gate `KubeletPodResources`. ([#122139](https://github.com/kubernetes/kubernetes/pull/122139), [@bzsuni](https://github.com/bzsuni)) [SIG Node]
- Removed generally available feature gate `MinimizeIPTablesRestore`. ([#122136](https://github.com/kubernetes/kubernetes/pull/122136), [@ty-dc](https://github.com/ty-dc)) [SIG Network]
- Removed generally available feature gate `ProxyTerminatingEndpoints`. ([#122134](https://github.com/kubernetes/kubernetes/pull/122134), [@ty-dc](https://github.com/ty-dc)) [SIG Network]
- Removed the deprecated `azureFile` in-tree storage plugin. ([#122576](https://github.com/kubernetes/kubernetes/pull/122576), [@carlory](https://github.com/carlory))
- Setting `--cidr-allocator-type` to `CloudAllocator` for `kube-controller-manager` will be removed in a future release. Please switch to and explore the options available in your external cloud provider ([#123011](https://github.com/kubernetes/kubernetes/pull/123011), [@dims](https://github.com/dims)) [SIG API Machinery and Network]
- The GA feature-gate APISelfSubjectReview is removed, and the feature is unconditionally enabled. ([#122032](https://github.com/kubernetes/kubernetes/pull/122032), [@carlory](https://github.com/carlory)) [SIG Auth and Testing]
- The feature gate `LegacyServiceAccountTokenTracking` (GA since 1.28) is now removed, since the feature is unconditionally enabled. ([#122409](https://github.com/kubernetes/kubernetes/pull/122409), [@Rei1010](https://github.com/Rei1010)) [SIG Auth]
- The in-tree cloud provider for azure has now been removed. Please use the external cloud provider and CSI driver from https://github.com/kubernetes/cloud-provider-azure instead. ([#122857](https://github.com/kubernetes/kubernetes/pull/122857), [@nilo19](https://github.com/nilo19)) [SIG API Machinery, Cloud Provider, Instrumentation, Node and Testing]
- The in-tree cloud provider for vSphere has now been removed. Please use the external cloud provider and CSI driver from https://github.com/kubernetes/cloud-provider-vsphere instead. ([#122937](https://github.com/kubernetes/kubernetes/pull/122937), [@dims](https://github.com/dims)) [SIG API Machinery, Cloud Provider, Storage and Testing]
- Updated `kube-dns` to `v1.22.27`. ([#121736](https://github.com/kubernetes/kubernetes/pull/121736), [@ty-dc](https://github.com/ty-dc))
- Updated cni-plugins to v1.4.0. ([#122178](https://github.com/kubernetes/kubernetes/pull/122178), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Node and Testing]
- Updated cri-tools to v1.29.0. ([#122271](https://github.com/kubernetes/kubernetes/pull/122271), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider]
- `kube-proxy` nftables mode is now compatible with kernel `5.4` ([#122296](https://github.com/kubernetes/kubernetes/pull/122296), [@tnqn](https://github.com/tnqn))