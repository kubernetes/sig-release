# Release notes for v1.21.0

[Documentation](https://docs.k8s.io/docs/home)
# Changelog since v1.20.0

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Kube-proxy's IPVS proxy mode no longer sets the net.ipv4.conf.all.route_localnet sysctl parameter. Nodes upgrading will have net.ipv4.conf.all.route_localnet set to 1 but new nodes will inherit the system default (usually 0). If you relied on any behavior requiring net.ipv4.conf.all.route_localnet, you must set ensure it is enabled as kube-proxy will no longer set it automatically. This change helps to further mitigate CVE-2020-8558. ([#92938](https://github.com/kubernetes/kubernetes/pull/92938), [@lbernail](https://github.com/lbernail)) [SIG Network and Release]
 - Kubeadm: during "init" an empty cgroupDriver value in the KubeletConfiguration is now always set to "systemd" unless the user is explicit about it. This requires existing machine setups to configure the container runtime to use the "systemd" driver. Documentation on this topic can be found here: https://kubernetes.io/docs/setup/production-environment/container-runtimes/. When upgrading existing clusters / nodes using "kubeadm upgrade" the old cgroupDriver value is preserved, but in 1.22 this change will also apply to "upgrade". For more information on migrating to the "systemd" driver or remaining on the "cgroupfs" driver see: https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/. ([#99471](https://github.com/kubernetes/kubernetes/pull/99471), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
 - Migrate `pkg/kubelet/(dockershim, network)` to structured logging
  Exit code changed from 255 to 1 ([#98939](https://github.com/kubernetes/kubernetes/pull/98939), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Network and Node]
 - Migrate `pkg/kubelet/certificate` to structured logging
  Exit code changed from 255 to 1 ([#98993](https://github.com/kubernetes/kubernetes/pull/98993), [@SataQiu](https://github.com/SataQiu)) [SIG Auth and Node]
 - Newly provisioned PVs by EBS plugin will no longer use the deprecated "failure-domain.beta.kubernetes.io/zone" and "failure-domain.beta.kubernetes.io/region" labels. It will use "topology.kubernetes.io/zone" and "topology.kubernetes.io/region" labels instead. ([#99130](https://github.com/kubernetes/kubernetes/pull/99130), [@ayberk](https://github.com/ayberk)) [SIG Cloud Provider, Storage and Testing]
 - Newly provisioned PVs by OpenStack Cinder plugin will no longer use the deprecated "failure-domain.beta.kubernetes.io/zone" and "failure-domain.beta.kubernetes.io/region" labels. It will use "topology.kubernetes.io/zone" and "topology.kubernetes.io/region" labels instead. ([#99719](https://github.com/kubernetes/kubernetes/pull/99719), [@jsafrane](https://github.com/jsafrane)) [SIG Cloud Provider and Storage]
 - Newly provisioned PVs by gce-pd will no longer have the beta FailureDomain label. gce-pd volume plugin will start to have GA topology label instead. ([#98700](https://github.com/kubernetes/kubernetes/pull/98700), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Cloud Provider, Storage and Testing]
 - OpenStack Cinder CSI migration is on by default, Clinder CSI driver must be installed on clusters on OpenStack for Cinder volumes to work. ([#98538](https://github.com/kubernetes/kubernetes/pull/98538), [@dims](https://github.com/dims)) [SIG Storage]
 - Remove alpha CSIMigrationXXComplete flag and add alpha InTreePluginXXUnregister flag. Deprecate CSIMigrationvSphereComplete flag and it will be removed in 1.22. ([#98243](https://github.com/kubernetes/kubernetes/pull/98243), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Node and Storage]
 - Remove storage metrics `storage_operation_errors_total`, since we already have `storage_operation_status_count`.And add new field `status` for `storage_operation_duration_seconds`, so that we can know about all status storage operation latency. ([#98332](https://github.com/kubernetes/kubernetes/pull/98332), [@JornShen](https://github.com/JornShen)) [SIG Instrumentation and Storage]
 - The metric `storage_operation_errors_total` is not removed, but is marked deprecated, and the metric `storage_operation_status_count` is marked deprecated. In both cases the storage_operation_duration_seconds metric can be used to recover equivalent counts (using `status=fail-unknown` in the case of `storage_operations_errors_total`). ([#99045](https://github.com/kubernetes/kubernetes/pull/99045), [@mattcary](https://github.com/mattcary)) [SIG Instrumentation and Storage]
 - `ServiceNodeExclusion`, `NodeDisruptionExclusion` and `LegacyNodeRoleBehavior`(locked to false) features have been promoted to GA. 
  To prevent control plane nodes from being added to load balancers automatically, upgrade users need to add "node.kubernetes.io/exclude-from-external-load-balancers" label to control plane nodes. ([#97543](https://github.com/kubernetes/kubernetes/pull/97543), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery, Apps, Cloud Provider and Network]
 
## Changes by Kind

### Deprecation

- Deprecate the `topologyKeys` field in Service. This capability will be replaced with upcoming work around Topology Aware Subsetting and Service Internal Traffic Policy. ([#96736](https://github.com/kubernetes/kubernetes/pull/96736), [@andrewsykim](https://github.com/andrewsykim)) [SIG Apps]
- Kubeadm: deprecated command "alpha selfhosting pivot" is removed now. ([#97627](https://github.com/kubernetes/kubernetes/pull/97627), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: graduate the command `kubeadm alpha kubeconfig user` to `kubeadm kubeconfig user`. The `kubeadm alpha kubeconfig user` command is deprecated now. ([#97583](https://github.com/kubernetes/kubernetes/pull/97583), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: the "kubeadm alpha certs" command is removed now, please use "kubeadm certs" instead. ([#97706](https://github.com/kubernetes/kubernetes/pull/97706), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: the deprecated kube-dns is no longer supported as an option. If "ClusterConfiguration.dns.type" is set to "kube-dns" kubeadm will now throw an error. ([#99646](https://github.com/kubernetes/kubernetes/pull/99646), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cluster Lifecycle]
- Remove deprecated --generator --replicas --service-generator --service-overrides --schedule from kubectl run
  Deprecate --serviceaccount --hostport --requests --limits in kubectl run ([#99732](https://github.com/kubernetes/kubernetes/pull/99732), [@soltysh](https://github.com/soltysh)) [SIG CLI and Testing]
- Remove the deprecated metrics "scheduling_algorithm_preemption_evaluation_seconds" and "binding_duration_seconds", suggest to use "scheduler_framework_extension_point_duration_seconds" instead. ([#96447](https://github.com/kubernetes/kubernetes/pull/96447), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle, Instrumentation, Scheduling and Testing]
- Removing experimental windows container hyper-v support with Docker ([#97141](https://github.com/kubernetes/kubernetes/pull/97141), [@wawa0210](https://github.com/wawa0210)) [SIG Node and Windows]
- The GA TokenRequest and TokenRequestProjection feature gates have been removed and are unconditionally enabled. Remove explicit use of those feature gates in CLI invocations. ([#97148](https://github.com/kubernetes/kubernetes/pull/97148), [@wawa0210](https://github.com/wawa0210)) [SIG Node]
- The PodSecurityPolicy API is deprecated in 1.21, and will no longer be served starting in 1.25. ([#97171](https://github.com/kubernetes/kubernetes/pull/97171), [@deads2k](https://github.com/deads2k)) [SIG Auth and CLI]
- The `batch/v2alpha1` CronJob type definitions and clients are deprecated and removed. ([#96987](https://github.com/kubernetes/kubernetes/pull/96987), [@soltysh](https://github.com/soltysh)) [SIG API Machinery, Apps, CLI and Testing]
- The `export` query parameter (inconsistently supported by API resources and deprecated in v1.14) is fully removed.  Requests setting this query parameter will now receive a 400 status response. ([#98312](https://github.com/kubernetes/kubernetes/pull/98312), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Auth and Testing]
- `audit.k8s.io/v1beta1` and `audit.k8s.io/v1alpha1` audit policy configuration and audit events are deprecated in favor of `audit.k8s.io/v1`, available since v1.13. kube-apiserver invocations that specify alpha or beta policy configurations with `--audit-policy-file`, or explicitly request alpha or beta audit events with `--audit-log-version` / `--audit-webhook-version` must update to use `audit.k8s.io/v1` and accept `audit.k8s.io/v1` events prior to v1.24. ([#98858](https://github.com/kubernetes/kubernetes/pull/98858), [@carlory](https://github.com/carlory)) [SIG Auth]
- `diskformat` stroage class parameter for in-tree vSphere volume plugin is deprecated as of v1.21 release. Please consider updating storageclass and remove `diskformat` parameter. vSphere CSI Driver does not support diskformat storageclass parameter.
  
  vSphere releases less than 67u3 are deprecated as of v1.21. Please consider upgrading vSphere to 67u3 or above. vSphere CSI Driver requires minimum vSphere 67u3.
  
  VM Hardware version less than 15 is deprecated as of v1.21. Please consider upgrading the Node VM Hardware version to 15 or above. vSphere CSI Driver recommends Node VM's Hardware version set to at least vmx-15.
  
  Multi vCenter support is deprecated as of v1.21. If you have a Kubernetes cluster spanning across multiple vCenter servers, please consider moving all k8s nodes to a single vCenter Server. vSphere CSI Driver does not support Kubernetes deployment spanning across multiple vCenter servers.
  
  Support for these deprecations will be available till Kubernetes v1.24. ([#98546](https://github.com/kubernetes/kubernetes/pull/98546), [@divyenpatel](https://github.com/divyenpatel)) [SIG Cloud Provider and Storage]

### API Change

- "Auto" is now a valid value for the `service.kubernetes.io/topology-aware-hints` annotation. ([#100728](https://github.com/kubernetes/kubernetes/pull/100728), [@robscott](https://github.com/robscott)) [SIG Apps, Instrumentation and Network]
- 1. PodAffinityTerm includes a namespaceSelector field to allow selecting eligible namespaces based on their labels. 
  2. A new CrossNamespacePodAffinity quota scope API that allows restricting which namespaces allowed to use PodAffinityTerm with corss-namespace reference via namespaceSelector or namespaces fields. ([#98582](https://github.com/kubernetes/kubernetes/pull/98582), [@ahg-g](https://github.com/ahg-g)) [SIG API Machinery, Apps, Auth and Testing]
- Add Probe-level terminationGracePeriodSeconds field ([#99375](https://github.com/kubernetes/kubernetes/pull/99375), [@ehashman](https://github.com/ehashman)) [SIG API Machinery, Apps, Node and Testing]
- Added `.spec.completionMode` field to Job, with accepted values `NonIndexed` (default) and `Indexed`. This is an alpha field and is only honored by servers with the `IndexedJob` feature gate enabled. ([#98441](https://github.com/kubernetes/kubernetes/pull/98441), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps and CLI]
- Adds support for endPort field in NetworkPolicy ([#97058](https://github.com/kubernetes/kubernetes/pull/97058), [@rikatz](https://github.com/rikatz)) [SIG Apps and Network]
- CSIServiceAccountToken is Beta now ([#99298](https://github.com/kubernetes/kubernetes/pull/99298), [@zshihang](https://github.com/zshihang)) [SIG Auth, Storage and Testing]
- Cluster admins can now turn off /debug/pprof and /debug/flags/v endpoint in kubelet by setting enableProfilingHandler and enableDebugFlagsHandler to false in their kubelet configuration file. enableProfilingHandler and enableDebugFlagsHandler can be set to true only when enableDebuggingHandlers is also set to true. ([#98458](https://github.com/kubernetes/kubernetes/pull/98458), [@SaranBalaji90](https://github.com/SaranBalaji90)) [SIG Node]
- DaemonSets accept a MaxSurge integer or percent on their rolling update strategy that will launch the updated pod on nodes and wait for those pods to go ready before marking the old out-of-date pods as deleted. This allows workloads to avoid downtime during upgrades when deployed using DaemonSets. This feature is alpha and is behind the DaemonSetUpdateSurge feature gate. ([#96441](https://github.com/kubernetes/kubernetes/pull/96441), [@smarterclayton](https://github.com/smarterclayton)) [SIG Apps and Testing]
- Discovery.k8s.io/v1beta1 EndpointSlices are deprecated in favor of discovery.k8s.io/v1, and will no longer be served in Kubernetes v1.25. ([#100472](https://github.com/kubernetes/kubernetes/pull/100472), [@liggitt](https://github.com/liggitt)) [SIG Network]
- Enable SPDY pings to keep connections alive, so that `kubectl exec` and `kubectl portforward` won't be interrupted. ([#97083](https://github.com/kubernetes/kubernetes/pull/97083), [@knight42](https://github.com/knight42)) [SIG API Machinery and CLI]
- EndpointSlice API is now GA. The EndpointSlice topology field has been removed from the GA API and will be replaced by a new per Endpoint Zone field. If the topology field was previously used, it will be converted into an annotation in the v1 Resource. The discovery.k8s.io/v1alpha1 API is removed. ([#99662](https://github.com/kubernetes/kubernetes/pull/99662), [@swetharepakula](https://github.com/swetharepakula)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network and Testing]
- EndpointSlice Controllers are now GA. The EndpointSlice Controller will not populate the `deprecatedTopology` field and will only provide topology information through the `zone` and `nodeName` fields. ([#99870](https://github.com/kubernetes/kubernetes/pull/99870), [@swetharepakula](https://github.com/swetharepakula)) [SIG API Machinery, Apps, Auth, Network and Testing]
- FieldManager no longer owns fields that get reset before the object is persisted (e.g. "status wiping"). ([#99661](https://github.com/kubernetes/kubernetes/pull/99661), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, Auth and Testing]
- Fixes using server-side apply with APIService resources ([#98576](https://github.com/kubernetes/kubernetes/pull/98576), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, Apps and Testing]
- Generic ephemeral volumes are beta. ([#99643](https://github.com/kubernetes/kubernetes/pull/99643), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, CLI, Node, Storage and Testing]
- Hugepages request values are limited to integer multiples of the page size. ([#98515](https://github.com/kubernetes/kubernetes/pull/98515), [@lala123912](https://github.com/lala123912)) [SIG Apps]
- Implement the GetAvailableResources in the podresources API. ([#95734](https://github.com/kubernetes/kubernetes/pull/95734), [@fromanirh](https://github.com/fromanirh)) [SIG Instrumentation, Node and Testing]
- IngressClass resource can now reference a resource in a specific namespace 
  for implementation-specific configuration(previously only Cluster-level resources were allowed). 
  This feature can be enabled using the IngressClassNamespacedParams feature gate. ([#99275](https://github.com/kubernetes/kubernetes/pull/99275), [@hbagdi](https://github.com/hbagdi)) [SIG API Machinery, CLI and Network]
- Jobs API has a new .spec.suspend field that can be used to suspend and resume Jobs. This is an alpha field which is only honored by servers with the `SuspendJob` feature gate enabled. ([#98727](https://github.com/kubernetes/kubernetes/pull/98727), [@adtac](https://github.com/adtac)) [SIG API Machinery, Apps, Node, Scheduling and Testing]
- Kubelet Graceful Node Shutdown feature is now beta. ([#99735](https://github.com/kubernetes/kubernetes/pull/99735), [@bobbypage](https://github.com/bobbypage)) [SIG Node]
- Kubernetes is now built using go1.15.7 ([#98363](https://github.com/kubernetes/kubernetes/pull/98363), [@cpanato](https://github.com/cpanato)) [SIG Cloud Provider, Instrumentation, Node, Release and Testing]
- Namespace API objects now have a `kubernetes.io/metadata.name` label matching their metadata.name field to allow selecting any namespace by its name using a label selector. ([#96968](https://github.com/kubernetes/kubernetes/pull/96968), [@jayunit100](https://github.com/jayunit100)) [SIG API Machinery, Apps, Cloud Provider, Storage and Testing]
- One new field "InternalTrafficPolicy" in Service is added.
  It specifies if the cluster internal traffic should be routed to all endpoints or node-local endpoints only.
  "Cluster" routes internal traffic to a Service to all endpoints.
  "Local" routes traffic to node-local endpoints only, and traffic is dropped if no node-local endpoints are ready.
  The default value is "Cluster". ([#96600](https://github.com/kubernetes/kubernetes/pull/96600), [@maplain](https://github.com/maplain)) [SIG API Machinery, Apps and Network]
- PodDisruptionBudget API objects can now contain conditions in status. ([#98127](https://github.com/kubernetes/kubernetes/pull/98127), [@mortent](https://github.com/mortent)) [SIG API Machinery, Apps, Auth, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- PodSecurityPolicy only stores "generic" as allowed volume type if the GenericEphemeralVolume feature gate is enabled ([#98918](https://github.com/kubernetes/kubernetes/pull/98918), [@pohly](https://github.com/pohly)) [SIG Auth and Security]
- Promote CronJobs to batch/v1 ([#99423](https://github.com/kubernetes/kubernetes/pull/99423), [@soltysh](https://github.com/soltysh)) [SIG API Machinery, Apps, CLI and Testing]
- Promote Immutable Secrets/ConfigMaps feature to Stable. This allows to set `immutable` field in Secret or ConfigMap object to mark their contents as immutable. ([#97615](https://github.com/kubernetes/kubernetes/pull/97615), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps, Architecture, Node and Testing]
- Remove support for building Kubernetes with bazel. ([#99561](https://github.com/kubernetes/kubernetes/pull/99561), [@BenTheElder](https://github.com/BenTheElder)) [SIG API Machinery, Apps, Architecture, Auth, Autoscaling, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scalability, Scheduling, Storage, Testing and Windows]
- SSA treats certain structs as atomic ([#100684](https://github.com/kubernetes/kubernetes/pull/100684), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery, Auth, Node and Storage]
- Scheduler extender filter interface now can report unresolvable failed nodes in the new field `FailedAndUnresolvableNodes` of  `ExtenderFilterResult` struct. Nodes in this map will be skipped in the preemption phase. ([#92866](https://github.com/kubernetes/kubernetes/pull/92866), [@cofyc](https://github.com/cofyc)) [SIG Scheduling]
- Server Side Apply now treats all <Some>Selector fields as atomic (meaning the entire selector is managed by a single writer and updated together), since they contain interrelated and inseparable fields that do not merge in intuitive ways. ([#97989](https://github.com/kubernetes/kubernetes/pull/97989), [@Danil-Grigorev](https://github.com/Danil-Grigorev)) [SIG API Machinery]
- Setting loadBalancerClass in load balancer type of service is available with this PR. 
  Users who want to use a custom load balancer can specify loadBalancerClass to achieve it. ([#98277](https://github.com/kubernetes/kubernetes/pull/98277), [@XudongLiuHarold](https://github.com/XudongLiuHarold)) [SIG API Machinery, Apps, Cloud Provider and Network]
- Storage capacity tracking (= the CSIStorageCapacity feature) is beta, storage.k8s.io/v1alpha1/VolumeAttachment and storage.k8s.io/v1alpha1/CSIStorageCapacity objects are deprecated ([#99641](https://github.com/kubernetes/kubernetes/pull/99641), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, Scheduling, Storage and Testing]
- Support for Indexed Job: a Job that is considered completed when Pods associated to indexes from 0 to (.spec.completions-1) have succeeded. ([#98812](https://github.com/kubernetes/kubernetes/pull/98812), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps and CLI]
- The BoundServiceAccountTokenVolume feature has been promoted to beta, and enabled by default.
  - This changes the tokens provided to containers at `/var/run/secrets/kubernetes.io/serviceaccount/token` to be time-limited, auto-refreshed, and invalidated when the containing pod is deleted.
  - Clients should reload the token from disk periodically (once per minute is recommended) to ensure they continue to use a valid token. `k8s.io/client-go` version v11.0.0+ and v0.15.0+ reload tokens automatically.
  - By default, injected tokens are given an extended lifetime so they remain valid even after a new refreshed token is provided. The metric `serviceaccount_stale_tokens_total` can be used to monitor for workloads that are depending on the extended lifetime and are continuing to use tokens even after a refreshed token is provided to the container. If that metric indicates no existing workloads are depending on extended lifetimes, injected token lifetime can be shortened to 1 hour by starting `kube-apiserver` with `--service-account-extend-token-expiration=false`. ([#95667](https://github.com/kubernetes/kubernetes/pull/95667), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth, Cluster Lifecycle and Testing]
- The Endpoints controller will now set the `endpoints.kubernetes.io/over-capacity` annotation to "warning" when an Endpoints resource contains more than 1000 addresses. In a future release, the controller will truncate Endpoints that exceed this limit. The EndpointSlice API can be used to support significantly larger number of addresses. ([#99975](https://github.com/kubernetes/kubernetes/pull/99975), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- The PodDisruptionBudget API has been promoted to policy/v1 with no schema changes. The only functional change is that an empty selector (`{}`) written to a policy/v1 PodDisruptionBudget now selects all pods in the namespace. The behavior of the policy/v1beta1 API remains unchanged. The policy/v1beta1 PodDisruptionBudget API is deprecated and will no longer be served in 1.25+. ([#99290](https://github.com/kubernetes/kubernetes/pull/99290), [@mortent](https://github.com/mortent)) [SIG API Machinery, Apps, Auth, Autoscaling, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Scheduling and Testing]
- The apiserver now resets managedFields that got corrupted by a mutating admission controller. ([#98074](https://github.com/kubernetes/kubernetes/pull/98074), [@kwiesmueller](https://github.com/kwiesmueller)) [SIG API Machinery and Testing]
- Topology Aware Hints are now available in alpha and can be enabled with the `TopologyAwareHints` feature gate. ([#99522](https://github.com/kubernetes/kubernetes/pull/99522), [@robscott](https://github.com/robscott)) [SIG API Machinery, Apps, Auth, Instrumentation, Network and Testing]
- We have added a new Priority & Fairness rule that exempts all probes (/readyz, /healthz, /livez) to prevent 
  restarting of "healthy" kube-apiserver instance(s) by kubelet. ([#100678](https://github.com/kubernetes/kubernetes/pull/100678), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- `controller.kubernetes.io/pod-deletion-cost` annotation can be set to offer a hint on the cost of deleting a pod compared to other pods belonging to the same ReplicaSet. Pods with lower deletion cost are deleted first. This is an alpha feature. ([#99163](https://github.com/kubernetes/kubernetes/pull/99163), [@ahg-g](https://github.com/ahg-g)) [SIG Apps]

### Feature

- A client-go metric, rest_client_exec_plugin_call_total, has been added to track total calls to client-go credential plugins. ([#98892](https://github.com/kubernetes/kubernetes/pull/98892), [@ankeesler](https://github.com/ankeesler)) [SIG API Machinery, Auth, Cluster Lifecycle and Instrumentation]
- A new histogram metric to track the time it took to delete a job by the ttl-after-finished controller ([#98676](https://github.com/kubernetes/kubernetes/pull/98676), [@ahg-g](https://github.com/ahg-g)) [SIG Apps and Instrumentation]
- AWS cloudprovider supports auto-discovering subnets without any kubernetes.io/cluster/<clusterName> tags. It also supports additional service annotation service.beta.kubernetes.io/aws-load-balancer-subnets to manually configure the subnets. ([#97431](https://github.com/kubernetes/kubernetes/pull/97431), [@kishorj](https://github.com/kishorj)) [SIG Cloud Provider]
- Add --permit-address-sharing flag to kube-apiserver to listen with SO_REUSEADDR. While allowing to listen on wildcard IPs like 0.0.0.0 and specific IPs in parallel, it avoid waiting for the kernel to release socket in TIME_WAIT state, and hence, considably reducing kube-apiserver restart times under certain conditions. ([#93861](https://github.com/kubernetes/kubernetes/pull/93861), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- Add `csi_operations_seconds` metric on kubelet that exposes CSI operations duration and status for node CSI operations. ([#98979](https://github.com/kubernetes/kubernetes/pull/98979), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Instrumentation and Storage]
- Add `migrated` field into `storage_operation_duration_seconds` metric ([#99050](https://github.com/kubernetes/kubernetes/pull/99050), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Apps, Instrumentation and Storage]
- Add flag --lease-reuse-duration-seconds for kube-apiserver to config etcd lease reuse duration. ([#97009](https://github.com/kubernetes/kubernetes/pull/97009), [@lingsamuel](https://github.com/lingsamuel)) [SIG API Machinery and Scalability]
- Add ignore-errors flag for drain, support none-break drain in group. ([#98203](https://github.com/kubernetes/kubernetes/pull/98203), [@yuzhiquan](https://github.com/yuzhiquan)) [SIG CLI]
- Add metric etcd_lease_object_counts for kube-apiserver to observe max objects attached to a single etcd lease. ([#97480](https://github.com/kubernetes/kubernetes/pull/97480), [@lingsamuel](https://github.com/lingsamuel)) [SIG API Machinery, Instrumentation and Scalability]
- Add support to generate client-side binaries for new darwin/arm64 platform ([#97743](https://github.com/kubernetes/kubernetes/pull/97743), [@dims](https://github.com/dims)) [SIG Release and Testing]
- Added `ephemeral_volume_controller_create[_failures]_total` counters to kube-controller-manager metrics ([#99115](https://github.com/kubernetes/kubernetes/pull/99115), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Cluster Lifecycle, Instrumentation and Storage]
- Added support for installing arm64 node artifacts. ([#99242](https://github.com/kubernetes/kubernetes/pull/99242), [@liu-cong](https://github.com/liu-cong)) [SIG Cloud Provider]
- Adds alpha feature `VolumeCapacityPriority` which makes the scheduler prioritize nodes based on the best matching size of statically provisioned PVs across multiple topologies. ([#96347](https://github.com/kubernetes/kubernetes/pull/96347), [@cofyc](https://github.com/cofyc)) [SIG Apps, Network, Scheduling, Storage and Testing]
- Adds the ability to pass --strict-transport-security-directives to the kube-apiserver to set the HSTS header appropriately.  Be sure you understand the consequences to browsers before setting this field. ([#96502](https://github.com/kubernetes/kubernetes/pull/96502), [@249043822](https://github.com/249043822)) [SIG Auth]
- Adds two new metrics to cronjobs, a  histogram to track the time difference when a job is created and the expected time when it should be created, and a gauge for the missed schedules of a cronjob ([#99341](https://github.com/kubernetes/kubernetes/pull/99341), [@alaypatel07](https://github.com/alaypatel07)) [SIG Apps and Instrumentation]
- Alpha implementation of Kubectl Command Headers: SIG CLI KEP 859 enabled when KUBECTL_COMMAND_HEADERS environment variable set on the client command line.
  - To enable: export KUBECTL_COMMAND_HEADERS=1; kubectl ... ([#98952](https://github.com/kubernetes/kubernetes/pull/98952), [@seans3](https://github.com/seans3)) [SIG API Machinery and CLI]
- Base-images: Update to debian-iptables:buster-v1.4.0
  - Uses iptables 1.8.5
  - base-images: Update to debian-base:buster-v1.3.0
  - cluster/images/etcd: Build etcd:3.4.13-2 image
    - Uses debian-base:buster-v1.3.0 ([#98401](https://github.com/kubernetes/kubernetes/pull/98401), [@pacoxu](https://github.com/pacoxu)) [SIG Testing]
- Component owner can configure the allowlist of metric label with flag '--allow-metric-labels'. ([#99738](https://github.com/kubernetes/kubernetes/pull/99738), [@YoyinZyc](https://github.com/YoyinZyc)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- EmptyDir memory backed volumes are sized as the the minimum of pod allocatable memory on a host and an optional explicit user provided value. ([#100319](https://github.com/kubernetes/kubernetes/pull/100319), [@derekwaynecarr](https://github.com/derekwaynecarr)) [SIG Node]
- Enables Kubelet to check volume condition and log events to corresponding pods. ([#99284](https://github.com/kubernetes/kubernetes/pull/99284), [@fengzixu](https://github.com/fengzixu)) [SIG Apps, Instrumentation, Node and Storage]
- EndpointSliceNodeName will always be enabled, so NodeName will always be available in the v1beta1 API. ([#99746](https://github.com/kubernetes/kubernetes/pull/99746), [@swetharepakula](https://github.com/swetharepakula)) [SIG Apps and Network]
- Export NewDebuggingRoundTripper function and DebugLevel options in the k8s.io/client-go/transport package. ([#98324](https://github.com/kubernetes/kubernetes/pull/98324), [@atosatto](https://github.com/atosatto)) [SIG API Machinery]
- Feature gate RootCAConfigMap is graduated to GA in 1.21 and will be removed in 1.22. ([#98033](https://github.com/kubernetes/kubernetes/pull/98033), [@zshihang](https://github.com/zshihang)) [SIG API Machinery and Auth]
- Fluentd: isolate logging resources in separate namespace ([#68004](https://github.com/kubernetes/kubernetes/pull/68004), [@saravanan30erd](https://github.com/saravanan30erd)) [SIG Cloud Provider and Instrumentation]
- Graduate CRIContainerLogRotation feature gate to GA. ([#99651](https://github.com/kubernetes/kubernetes/pull/99651), [@umohnani8](https://github.com/umohnani8)) [SIG Node and Testing]
- It add two flags, `--max-pods` and `--extended-resources` ([#100267](https://github.com/kubernetes/kubernetes/pull/100267), [@Jeffwan](https://github.com/Jeffwan)) [SIG Node and Scalability]
- Kube config is now exposed in the scheduler framework handle. Out-of-tree plugins can leverage that to build CRD informers easily. ([#100644](https://github.com/kubernetes/kubernetes/pull/100644), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Apps, Scheduling and Testing]
- Kube-proxy iptables: new metric sync_proxy_rules_iptables_total that exposes the number of rules programmed per table in each iteration ([#99653](https://github.com/kubernetes/kubernetes/pull/99653), [@aojea](https://github.com/aojea)) [SIG Instrumentation and Network]
- Kube-scheduler now logs plugin scoring summaries at --v=4 ([#99411](https://github.com/kubernetes/kubernetes/pull/99411), [@damemi](https://github.com/damemi)) [SIG Scheduling]
- Kubeadm now includes CoreDNS v1.8.0. ([#96429](https://github.com/kubernetes/kubernetes/pull/96429), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cluster Lifecycle]
- Kubeadm: a warning to user as ipv6 site-local is deprecated ([#99574](https://github.com/kubernetes/kubernetes/pull/99574), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle and Network]
- Kubeadm: add support for certificate chain validation. When using kubeadm in external CA mode, this allows an intermediate CA to be used to sign the certificates. The intermediate CA certificate must be appended to each signed certificate for this to work correctly. ([#97266](https://github.com/kubernetes/kubernetes/pull/97266), [@robbiemcmichael](https://github.com/robbiemcmichael)) [SIG Cluster Lifecycle]
- Kubeadm: amend the node kernel validation to treat CGROUP_PIDS, FAIR_GROUP_SCHED as required and CFS_BANDWIDTH, CGROUP_HUGETLB as optional ([#96378](https://github.com/kubernetes/kubernetes/pull/96378), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle and Node]
- Kubeadm: apply the "node.kubernetes.io/exclude-from-external-load-balancers" label on control plane nodes during "init", "join" and "upgrade" to preserve backwards compatibility with the lagacy LB mode where nodes labeled as "master" where excluded. To opt-out you can remove the label from a node. See #97543 and the linked KEP for more details. ([#98269](https://github.com/kubernetes/kubernetes/pull/98269), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: during "init" and "join" perform preflight validation on the host / node name and throw warnings if a name is not compliant ([#99194](https://github.com/kubernetes/kubernetes/pull/99194), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: if the user has customized their image repository via the kubeadm configuration, pass the custom pause image repository and tag to the kubelet via --pod-infra-container-image not only for Docker but for all container runtimes. This flag tells the kubelet that it should not garbage collect the image. ([#99476](https://github.com/kubernetes/kubernetes/pull/99476), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: promote IPv6DualStack feature gate to Beta ([#99294](https://github.com/kubernetes/kubernetes/pull/99294), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubect: Added --use-protocol-buffers flag to kubectl top pods and nodes ([#96655](https://github.com/kubernetes/kubernetes/pull/96655), [@serathius](https://github.com/serathius)) [SIG CLI]
- Kubectl version changed to write a warning message to stderr if the client and server version difference exceeds the supported version skew of +/-1 minor version. ([#98250](https://github.com/kubernetes/kubernetes/pull/98250), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Kubectl wait ensures that observedGeneration >= generation if applicable ([#97408](https://github.com/kubernetes/kubernetes/pull/97408), [@KnicKnic](https://github.com/KnicKnic)) [SIG CLI]
- Kubectl: `kubectl get` will omit managed fields by default now. Users could set `--show-managed-fields` to true to show managedFields when the output format is either `json` or `yaml`. ([#96878](https://github.com/kubernetes/kubernetes/pull/96878), [@knight42](https://github.com/knight42)) [SIG CLI and Testing]
- Kubectl: add support for bash-completion for comma separated list on `kubectl get` ([#98301](https://github.com/kubernetes/kubernetes/pull/98301), [@phil9909](https://github.com/phil9909)) [SIG CLI]
- Kubernetes is now built using go1.15.8 ([#98834](https://github.com/kubernetes/kubernetes/pull/98834), [@cpanato](https://github.com/cpanato)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.16 ([#98572](https://github.com/kubernetes/kubernetes/pull/98572), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node, Release and Testing]
- Kubernetes is now built with Golang 1.16.1 ([#100106](https://github.com/kubernetes/kubernetes/pull/100106), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Metrics can now be disabled explicitly via a command line flag (i.e. '--disabled-metrics=bad_metric1,bad_metric2') ([#99217](https://github.com/kubernetes/kubernetes/pull/99217), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- New admission controller "DenyServiceExternalIPs" is available.  Clusters which do not *need- the Service "externalIPs" feature should enable this controller and be more secure. ([#97395](https://github.com/kubernetes/kubernetes/pull/97395), [@thockin](https://github.com/thockin)) [SIG API Machinery]
- Overall, enable the feature of `PreferNominatedNode` will  improve the performance of scheduling where preemption might frequently happen, but in theory, enable the feature of `PreferNominatedNode`, the pod might not be scheduled to the best candidate node in the cluster. ([#93179](https://github.com/kubernetes/kubernetes/pull/93179), [@chendave](https://github.com/chendave)) [SIG Scheduling and Testing]
- Pause image upgraded to 3.4.1 in kubelet and kubeadm for both Linux and Windows. ([#98205](https://github.com/kubernetes/kubernetes/pull/98205), [@pacoxu](https://github.com/pacoxu)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Node, Testing and Windows]
- Persistent Volumes formatted with the btrfs filesystem will now automatically resize when expanded. ([#99361](https://github.com/kubernetes/kubernetes/pull/99361), [@Novex](https://github.com/Novex)) [SIG Storage]
- Port the devicemanager to Windows node to allow device plugins like directx ([#93285](https://github.com/kubernetes/kubernetes/pull/93285), [@aarnaud](https://github.com/aarnaud)) [SIG Node, Testing and Windows]
- Remove cAdvisor json metrics api collected by Kubelet ([#99236](https://github.com/kubernetes/kubernetes/pull/99236), [@pacoxu](https://github.com/pacoxu)) [SIG Node]
- Rename metrics `etcd_object_counts` to `apiserver_storage_object_counts` and mark it as stable. The original `etcd_object_counts` metrics name is marked as "Deprecated" and will be removed in the future. ([#99785](https://github.com/kubernetes/kubernetes/pull/99785), [@erain](https://github.com/erain)) [SIG API Machinery, Instrumentation and Testing]
- Sysctls is now GA and locked to default ([#99158](https://github.com/kubernetes/kubernetes/pull/99158), [@wgahnagl](https://github.com/wgahnagl)) [SIG Node]
- System-cluster-critical pods should not get a low OOM Score. 
  
  As of now both system-node-critical and system-cluster-critical pods have -997 OOM score, making them one of the last processes to be OOMKilled. By definition system-cluster-critical pods can be scheduled elsewhere if there is a resource crunch on the node where as system-node-critical pods cannot be rescheduled. This was the reason for system-node-critical to have higher priority value than system-cluster-critical.  This change allows only system-node-critical priority class to have low OOMScore.
  
  action required
  If the user wants to have the pod to be OOMKilled last and the pod has system-cluster-critical priority class, it has to be changed to system-node-critical priority class to preserve the existing behavior ([#99729](https://github.com/kubernetes/kubernetes/pull/99729), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Node]
- TTLAfterFinished is now beta and enabled by default ([#98678](https://github.com/kubernetes/kubernetes/pull/98678), [@ahg-g](https://github.com/ahg-g)) [SIG Apps and Auth]
- The Kubernetes pause image manifest list now contains an image for Windows Server 20H2. ([#97322](https://github.com/kubernetes/kubernetes/pull/97322), [@claudiubelu](https://github.com/claudiubelu)) [SIG Windows]
- The NodeAffinity plugin implements the PreFilter extension, offering enhanced performance for Filter. ([#99213](https://github.com/kubernetes/kubernetes/pull/99213), [@AliceZhang2016](https://github.com/AliceZhang2016)) [SIG Scheduling]
- The `RunAsGroup` feature has been promoted to GA in this release. ([#94641](https://github.com/kubernetes/kubernetes/pull/94641), [@krmayankk](https://github.com/krmayankk)) [SIG Auth and Node]
- The `ServiceAccountIssuerDiscovery` feature has graduated to GA, and is unconditionally enabled. The `ServiceAccountIssuerDiscovery` feature-gate will be removed in 1.22. ([#98553](https://github.com/kubernetes/kubernetes/pull/98553), [@mtaufen](https://github.com/mtaufen)) [SIG API Machinery, Auth and Testing]
- The apimachinery util/net function used to detect the bind address `ResolveBindAddress()` takes into consideration global IP addresses on loopback interfaces when 1) the host has default routes, or 2) there are no global IPs on those interfaces in order to support more complex network scenarios like BGP Unnumbered RFC 5549 ([#95790](https://github.com/kubernetes/kubernetes/pull/95790), [@aojea](https://github.com/aojea)) [SIG Network]
- The endpointslice mirroring controller mirrors endpoints annotations and labels to the generated endpoint slices, it also ensures that updates on any of these fields are mirrored. 
  The well-known annotation endpoints.kubernetes.io/last-change-trigger-time is skipped and not mirrored. ([#98116](https://github.com/kubernetes/kubernetes/pull/98116), [@aojea](https://github.com/aojea)) [SIG Apps, Network and Testing]
- The job controller removes running pods when the number of completions was achieved. ([#99963](https://github.com/kubernetes/kubernetes/pull/99963), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- Turn CronJobControllerV2 on by default. ([#98878](https://github.com/kubernetes/kubernetes/pull/98878), [@soltysh](https://github.com/soltysh)) [SIG Apps]
- Update pause container to run as pseudo user and group `65535:65535`. This implies the release of version 3.5 of the container images. ([#97963](https://github.com/kubernetes/kubernetes/pull/97963), [@saschagrunert](https://github.com/saschagrunert)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Node, Release, Security and Testing]
- Update the latest validated version of Docker to 20.10 ([#98977](https://github.com/kubernetes/kubernetes/pull/98977), [@neolit123](https://github.com/neolit123)) [SIG CLI, Cluster Lifecycle and Node]
- Upgrade node local dns to 1.17.0 for better IPv6 support ([#99749](https://github.com/kubernetes/kubernetes/pull/99749), [@pacoxu](https://github.com/pacoxu)) [SIG Cloud Provider and Network]
- Upgrades `IPv6Dualstack` to `Beta` and turns it on by default. Clusters new and existing will not be affected until user starting adding secondary pod and service cidrs cli flags as described here: https://github.com/kubernetes/enhancements/tree/master/keps/sig-network/563-dual-stack ([#98969](https://github.com/kubernetes/kubernetes/pull/98969), [@khenidak](https://github.com/khenidak)) [SIG API Machinery, Apps, Cloud Provider, Network and Node]
- Users might specify the `kubectl.kubernetes.io/default-container` annotation in a Pod to preselect container for kubectl commands. ([#99833](https://github.com/kubernetes/kubernetes/pull/99833), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG CLI]
- When downscaling ReplicaSets, ready and creation timestamps are compared in a logarithmic scale. ([#99212](https://github.com/kubernetes/kubernetes/pull/99212), [@damemi](https://github.com/damemi)) [SIG Apps and Testing]
- When the kubelet is watching a ConfigMap or Secret purely in the context of setting environment variables
  for containers, only hold that watch for a defined duration before cancelling it. This change reduces the CPU
  and memory usage of the kube-apiserver in large clusters. ([#99393](https://github.com/kubernetes/kubernetes/pull/99393), [@chenyw1990](https://github.com/chenyw1990)) [SIG API Machinery, Node and Testing]
- WindowsEndpointSliceProxying feature gate has graduated to beta and is enabled by default. This means kube-proxy will  read from EndpointSlices instead of Endpoints on Windows by default. ([#99794](https://github.com/kubernetes/kubernetes/pull/99794), [@robscott](https://github.com/robscott)) [SIG Network]

### Documentation

- Feat: azure file migration go beta in 1.21. Feature gates CSIMigration to Beta (on by default) and CSIMigrationAzureFile to Beta (off by default since it requires installation of the AzureFile CSI Driver)
  The in-tree AzureFile plugin "kubernetes.io/azure-file" is now deprecated and will be removed in 1.23. Users should enable CSIMigration + CSIMigrationAzureFile features and install the AzureFile CSI Driver (https://github.com/kubernetes-sigs/azurefile-csi-driver) to avoid disruption to existing Pod and PVC objects at that time.
  Users should start using the AzureFile CSI Driver directly for any new volumes.
  
  Azure File CSI driver does not support using same persistent volume with different fsgroups, when CSI migration is enabled for azurefile driver, such case is not supported. (there is a case we support where volume is mounted with 0777 and then it readable/writable by everyone) ([#96293](https://github.com/kubernetes/kubernetes/pull/96293), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Official support to build kubernetes with docker-machine / remote docker is removed. This change does not affect building kubernetes with docker locally. ([#97935](https://github.com/kubernetes/kubernetes/pull/97935), [@adeniyistephen](https://github.com/adeniyistephen)) [SIG Release and Testing]
- Set kubelet option `--volume-stats-agg-period` to negative value to disable volume calculations. ([#96675](https://github.com/kubernetes/kubernetes/pull/96675), [@pacoxu](https://github.com/pacoxu)) [SIG Node]

### Failing Test

- Escape the special characters like `[`, `]` and ` ` that exist in vsphere windows path ([#98830](https://github.com/kubernetes/kubernetes/pull/98830), [@liyanhui1228](https://github.com/liyanhui1228)) [SIG Storage and Windows]
- Fixes an overly restrictive conformance test to accept service account tokens signed by an ECDSA key ([#100680](https://github.com/kubernetes/kubernetes/pull/100680), [@smira](https://github.com/smira)) [SIG Architecture, Auth and Testing]
- Fixes kubectl drain --dry-run=server ([#100206](https://github.com/kubernetes/kubernetes/pull/100206), [@KnVerey](https://github.com/KnVerey)) [SIG CLI and Testing]
- Kube-proxy: fix a bug on UDP NodePort Services where stale conntrack entries may blackhole the traffic directed to the NodePort. ([#98305](https://github.com/kubernetes/kubernetes/pull/98305), [@aojea](https://github.com/aojea)) [SIG Network]
- Kubelet: fixes a bug in the HostPort dockershim implementation that caused the conformance test "HostPort validates that there is no conflict between pods with same hostPort but different hostIP and protocol" to fail. ([#98755](https://github.com/kubernetes/kubernetes/pull/98755), [@aojea](https://github.com/aojea)) [SIG Cloud Provider, Network and Node]

### Bug or Regression

- A lease can only attach up to 1k objects. ([#98257](https://github.com/kubernetes/kubernetes/pull/98257), [@lingsamuel](https://github.com/lingsamuel)) [SIG API Machinery]
- AcceleratorStats will be available in the Summary API of kubelet when cri_stats_provider is used. ([#96873](https://github.com/kubernetes/kubernetes/pull/96873), [@ruiwen-zhao](https://github.com/ruiwen-zhao)) [SIG Node]
- All data is no longer automatically deleted when a failure is detected during creation of the volume data file on a CSI volume. Now only the data file and volume path is removed. ([#96021](https://github.com/kubernetes/kubernetes/pull/96021), [@huffmanca](https://github.com/huffmanca)) [SIG Storage]
- Clean ReplicaSet by revision instead of creation timestamp in deployment controller ([#97407](https://github.com/kubernetes/kubernetes/pull/97407), [@waynepeking348](https://github.com/waynepeking348)) [SIG Apps]
- Cleanup subnet in frontend IP configs to prevent huge subnet request bodies in some scenarios. ([#98133](https://github.com/kubernetes/kubernetes/pull/98133), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Cloud-controller-manager: routes controller should not depend on --allocate-node-cidrs ([#97029](https://github.com/kubernetes/kubernetes/pull/97029), [@andrewsykim](https://github.com/andrewsykim)) [SIG Cloud Provider and Testing]
- Cluster autoscaler updated to v1.20.0 ([#97011](https://github.com/kubernetes/kubernetes/pull/97011), [@towca](https://github.com/towca)) [SIG Cloud Provider]
- Copy annotations with empty value when deployment rolls back ([#94858](https://github.com/kubernetes/kubernetes/pull/94858), [@waynepeking348](https://github.com/waynepeking348)) [SIG Apps]
- Count pod overhead against an entity's ResourceQuota ([#99600](https://github.com/kubernetes/kubernetes/pull/99600), [@gjkim42](https://github.com/gjkim42)) [SIG API Machinery and Node]
- Creating a PVC with DataSource should fail for non-CSI plugins. ([#97086](https://github.com/kubernetes/kubernetes/pull/97086), [@xing-yang](https://github.com/xing-yang)) [SIG Apps and Storage]
- Detach volumes from vSphere nodes not tracked by attach-detach controller ([#96689](https://github.com/kubernetes/kubernetes/pull/96689), [@gnufied](https://github.com/gnufied)) [SIG Cloud Provider and Storage]
- EndpointSlice controller is now less likely to emit FailedToUpdateEndpointSlices events. ([#99345](https://github.com/kubernetes/kubernetes/pull/99345), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- EndpointSlice controllers are less likely to create duplicate EndpointSlices. ([#100103](https://github.com/kubernetes/kubernetes/pull/100103), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- EndpointSliceMirroring controller is now less likely to emit FailedToUpdateEndpointSlices events. ([#99756](https://github.com/kubernetes/kubernetes/pull/99756), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Ensure only one LoadBalancer rule is created when HA mode is enabled ([#99825](https://github.com/kubernetes/kubernetes/pull/99825), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Ensure that client-go's EventBroadcaster is safe (non-racy) during shutdown. ([#95664](https://github.com/kubernetes/kubernetes/pull/95664), [@DirectXMan12](https://github.com/DirectXMan12)) [SIG API Machinery]
- Expose `rest_client_rate_limiter_duration_seconds` metric to component-base to track client side rate limiter latency in seconds. Broken down by verb and URL. ([#100311](https://github.com/kubernetes/kubernetes/pull/100311), [@IonutBajescu](https://github.com/IonutBajescu)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Faster update the pod status reacting on probe results. Among other changes, the first readiness probe will be called faster when startup probes succeeded, which will make Pod status as ready faster. ([#98376](https://github.com/kubernetes/kubernetes/pull/98376), [@matthyx](https://github.com/matthyx)) [SIG Node and Testing]
- Fire an event when failing to open NodePort ([#100599](https://github.com/kubernetes/kubernetes/pull/100599), [@masap](https://github.com/masap)) [SIG Network]
- Fix Azure file share not deleted issue when the namespace is deleted ([#97417](https://github.com/kubernetes/kubernetes/pull/97417), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix CSI-migrated inline EBS volumes failing to mount if their volumeID is prefixed by aws:// ([#96821](https://github.com/kubernetes/kubernetes/pull/96821), [@wongma7](https://github.com/wongma7)) [SIG Storage]
- Fix CVE-2020-8555 for Gluster client connections. ([#97922](https://github.com/kubernetes/kubernetes/pull/97922), [@liggitt](https://github.com/liggitt)) [SIG Storage]
- Fix NPE in ephemeral storage eviction ([#98261](https://github.com/kubernetes/kubernetes/pull/98261), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Fix a bug in kube-proxy latency metrics to calculate only the latency value for the endpoints that are created after it starts running. This is needed because all the endpoints objects are processed on restarts, independently when they were generated. ([#100861](https://github.com/kubernetes/kubernetes/pull/100861), [@aojea](https://github.com/aojea)) [SIG Instrumentation and Network]
- Fix availability set cache in vmss cache ([#100110](https://github.com/kubernetes/kubernetes/pull/100110), [@CecileRobertMichon](https://github.com/CecileRobertMichon)) [SIG Cloud Provider]
- Fix azure file migration issue ([#97877](https://github.com/kubernetes/kubernetes/pull/97877), [@andyzhangx](https://github.com/andyzhangx)) [SIG Auth, Cloud Provider and Storage]
- Fix bug that would let the Horizontal Pod Autoscaler scale down despite at least one metric being unavailable/invalid ([#99514](https://github.com/kubernetes/kubernetes/pull/99514), [@mikkeloscar](https://github.com/mikkeloscar)) [SIG Apps and Autoscaling]
- Fix cgroup handling for systemd with cgroup v2 ([#98365](https://github.com/kubernetes/kubernetes/pull/98365), [@odinuge](https://github.com/odinuge)) [SIG Node]
- Fix counting error in service/nodeport/loadbalancer quota check ([#97451](https://github.com/kubernetes/kubernetes/pull/97451), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery, Network and Testing]
- Fix errors when accessing Windows container stats for Dockershim ([#98510](https://github.com/kubernetes/kubernetes/pull/98510), [@jsturtevant](https://github.com/jsturtevant)) [SIG Node and Windows]
- Fix missing cadvisor machine metrics. ([#97006](https://github.com/kubernetes/kubernetes/pull/97006), [@lingsamuel](https://github.com/lingsamuel)) [SIG Node]
- Fix nil VMSS name when setting service to auto mode ([#97366](https://github.com/kubernetes/kubernetes/pull/97366), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix raw block mode CSI NodePublishVolume stage miss pod info ([#99069](https://github.com/kubernetes/kubernetes/pull/99069), [@phantooom](https://github.com/phantooom)) [SIG Storage]
- Fix rounding of volume storage requests ([#100100](https://github.com/kubernetes/kubernetes/pull/100100), [@maxlaverse](https://github.com/maxlaverse)) [SIG Cloud Provider and Storage]
- Fix smb mount PermissionDenied issue on Windows ([#99550](https://github.com/kubernetes/kubernetes/pull/99550), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider, Storage and Windows]
- Fix the panic when kubelet registers if a node object already exists with no Status.Capacity or Status.Allocatable ([#95269](https://github.com/kubernetes/kubernetes/pull/95269), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- Fix the regression with the slow pods termination. Before this fix pods may take an additional time to terminate - up to one minute. Reversing the change that ensured that CNI resources cleaned up when the pod is removed on API server. ([#97980](https://github.com/kubernetes/kubernetes/pull/97980), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Node]
- Fix to recover CSI volumes from certain dangling attachments ([#96617](https://github.com/kubernetes/kubernetes/pull/96617), [@yuga711](https://github.com/yuga711)) [SIG Apps and Storage]
- Fix: azure file latency issue for metadata-heavy workloads ([#97082](https://github.com/kubernetes/kubernetes/pull/97082), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix: not delete existing pip when service is deleted ([#100694](https://github.com/kubernetes/kubernetes/pull/100694), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fixed Cinder volume IDs on OpenStack Train ([#96673](https://github.com/kubernetes/kubernetes/pull/96673), [@jsafrane](https://github.com/jsafrane)) [SIG Cloud Provider]
- Fixed FibreChannel volume plugin corrupting filesystems on detach of multipath volumes. ([#97013](https://github.com/kubernetes/kubernetes/pull/97013), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed a bug in kubelet that will saturate CPU utilization after containerd got restarted. ([#97174](https://github.com/kubernetes/kubernetes/pull/97174), [@hanlins](https://github.com/hanlins)) [SIG Node]
- Fixed a bug that causes smaller number of conntrack-max being used under CPU static policy. (#99225, @xh4n3) ([#99613](https://github.com/kubernetes/kubernetes/pull/99613), [@xh4n3](https://github.com/xh4n3)) [SIG Network]
- Fixed a bug that on k8s nodes, when the policy of INPUT chain in filter table is not ACCEPT, healthcheck nodeport would not work.
  Added iptables rules to allow healthcheck nodeport traffic. ([#97824](https://github.com/kubernetes/kubernetes/pull/97824), [@hanlins](https://github.com/hanlins)) [SIG Network]
- Fixed a bug that the kubelet cannot start on BtrfS. ([#98042](https://github.com/kubernetes/kubernetes/pull/98042), [@gjkim42](https://github.com/gjkim42)) [SIG Node]
- Fixed a race condition on API server startup ensuring previously created webhook configurations are effective before the first write request is admitted. ([#95783](https://github.com/kubernetes/kubernetes/pull/95783), [@roycaihw](https://github.com/roycaihw)) [SIG API Machinery]
- Fixed an issue with garbage collection failing to clean up namespaced children of an object also referenced incorrectly by cluster-scoped children ([#98068](https://github.com/kubernetes/kubernetes/pull/98068), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Apps]
- Fixed authentication_duration_seconds metric. Previously it included whole apiserver request duration. ([#99944](https://github.com/kubernetes/kubernetes/pull/99944), [@marseel](https://github.com/marseel)) [SIG API Machinery, Instrumentation and Scalability]
- Fixed bug in CPUManager with race on container map access ([#97427](https://github.com/kubernetes/kubernetes/pull/97427), [@klueska](https://github.com/klueska)) [SIG Node]
- Fixed bug that caused cAdvisor to incorrectly detect single-socket multi-NUMA topology. ([#99315](https://github.com/kubernetes/kubernetes/pull/99315), [@iwankgb](https://github.com/iwankgb)) [SIG Node]
- Fixed cleanup of block devices when /var/lib/kubelet is a symlink. ([#96889](https://github.com/kubernetes/kubernetes/pull/96889), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed kube-proxy container image architecture for non amd64 images. ([#98526](https://github.com/kubernetes/kubernetes/pull/98526), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery, Release and Testing]
- Fixed no effect namespace when exposing deployment with --dry-run=client. ([#97492](https://github.com/kubernetes/kubernetes/pull/97492), [@masap](https://github.com/masap)) [SIG CLI]
- Fixed port-forward memory leak for long-running and heavily used connections. ([#99839](https://github.com/kubernetes/kubernetes/pull/99839), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery and Node]
- Fixed provisioning of Cinder volumes migrated to CSI when StorageClass with AllowedTopologies was used. ([#98311](https://github.com/kubernetes/kubernetes/pull/98311), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed using volume partitions on AWS Nitro systems. ([#100500](https://github.com/kubernetes/kubernetes/pull/100500), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixes a data race issue in the priority and fairness API server filter ([#100638](https://github.com/kubernetes/kubernetes/pull/100638), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Fixes a panic in the disruption budget controller for PDB objects with invalid selectors ([#98750](https://github.com/kubernetes/kubernetes/pull/98750), [@mortent](https://github.com/mortent)) [SIG Apps]
- Fixes add-on manager leader election ([#98968](https://github.com/kubernetes/kubernetes/pull/98968), [@liggitt](https://github.com/liggitt)) [SIG Cloud Provider]
- Fixes connection errors when using `--volume-host-cidr-denylist` or `--volume-host-allow-local-loopback` ([#98436](https://github.com/kubernetes/kubernetes/pull/98436), [@liggitt](https://github.com/liggitt)) [SIG Network and Storage]
- Fixes spurious errors about IPv6 in kube-proxy logs on nodes with IPv6 disabled. ([#99127](https://github.com/kubernetes/kubernetes/pull/99127), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- Fixing a bug where a failed node may not have the NoExecute taint set correctly ([#96876](https://github.com/kubernetes/kubernetes/pull/96876), [@howieyuen](https://github.com/howieyuen)) [SIG Apps and Node]
- GCE Internal LoadBalancer sync loop will now release the ILB IP address upon sync failure. An error in ILB forwarding rule creation will no longer leak IP addresses. ([#97740](https://github.com/kubernetes/kubernetes/pull/97740), [@prameshj](https://github.com/prameshj)) [SIG Cloud Provider and Network]
- Generated OpenAPI now correctly specifies 201 as a possible response code for PATCH operations ([#100141](https://github.com/kubernetes/kubernetes/pull/100141), [@brendandburns](https://github.com/brendandburns)) [SIG API Machinery]
- Ignore update pod with no new images in alwaysPullImages admission controller ([#96668](https://github.com/kubernetes/kubernetes/pull/96668), [@pacoxu](https://github.com/pacoxu)) [SIG Apps, Auth and Node]
- Improve speed of vSphere PV provisioning and reduce number of API calls ([#100054](https://github.com/kubernetes/kubernetes/pull/100054), [@gnufied](https://github.com/gnufied)) [SIG Cloud Provider and Storage]
- In the method that ensures that the docker and containerd are in the correct containers with the proper OOM score set up, fixed the bug of identifying containerd process. ([#97888](https://github.com/kubernetes/kubernetes/pull/97888), [@pacoxu](https://github.com/pacoxu)) [SIG Node]
- KCM sets the upper-bound timeout limit for outgoing requests to 70s. Previously no timeout was set. Requests without explicit timeout might potentially hang forever and lead to starvation of the application. ([#99358](https://github.com/kubernetes/kubernetes/pull/99358), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- KUBECTL_EXTERNAL_DIFF now accepts equal sign for additional parameters. ([#98158](https://github.com/kubernetes/kubernetes/pull/98158), [@dougsland](https://github.com/dougsland)) [SIG CLI]
- Kube-apiserver: an update of a pod with a generic ephemeral volume dropped that volume if the feature had been disabled since creating the pod with such a volume ([#99446](https://github.com/kubernetes/kubernetes/pull/99446), [@pohly](https://github.com/pohly)) [SIG Apps, Node and Storage]
- Kube-proxy: remove deprecated --cleanup-ipvs flag of kube-proxy, and make --cleanup flag always to flush IPVS ([#97336](https://github.com/kubernetes/kubernetes/pull/97336), [@maaoBit](https://github.com/maaoBit)) [SIG Network]
- Kubeadm now installs version 3.4.13 of etcd when creating a cluster with v1.19 ([#97244](https://github.com/kubernetes/kubernetes/pull/97244), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: Some text in the `kubeadm upgrade plan` output has changed. If you have scripts or other automation that parses this output, please review these changes and update your scripts to account for the new output. ([#98728](https://github.com/kubernetes/kubernetes/pull/98728), [@stmcginnis](https://github.com/stmcginnis)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug in the host memory detection code on 32bit Linux platforms ([#97403](https://github.com/kubernetes/kubernetes/pull/97403), [@abelbarrera15](https://github.com/abelbarrera15)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where "kubeadm join" would not properly handle missing names for existing etcd members. ([#97372](https://github.com/kubernetes/kubernetes/pull/97372), [@ihgann](https://github.com/ihgann)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where "kubeadm upgrade" commands can fail if CoreDNS v1.8.0 is installed. ([#97919](https://github.com/kubernetes/kubernetes/pull/97919), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where external credentials in an existing admin.conf prevented the CA certificate to be written in the cluster-info ConfigMap. ([#98882](https://github.com/kubernetes/kubernetes/pull/98882), [@kvaps](https://github.com/kvaps)) [SIG Cluster Lifecycle]
- Kubeadm: get k8s CI version markers from k8s infra bucket ([#98836](https://github.com/kubernetes/kubernetes/pull/98836), [@hasheddan](https://github.com/hasheddan)) [SIG Cluster Lifecycle and Release]
- Kubeadm: skip validating pod subnet against node-cidr-mask when allocate-node-cidrs is set to be false ([#98984](https://github.com/kubernetes/kubernetes/pull/98984), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubectl logs: Fix --ignore-errors does not take effect if multiple logs are printed and unfollowed ([#97686](https://github.com/kubernetes/kubernetes/pull/97686), [@wzshiming](https://github.com/wzshiming)) [SIG CLI]
- Kubectl-convert: Fix `no kind "Ingress" is registered for version` error ([#97754](https://github.com/kubernetes/kubernetes/pull/97754), [@wzshiming](https://github.com/wzshiming)) [SIG CLI and Testing]
- Kubectl: Fixed panic when describing an ingress backend without an API Group ([#100505](https://github.com/kubernetes/kubernetes/pull/100505), [@lauchokyip](https://github.com/lauchokyip)) [SIG CLI]
- Kubelet now cleans up orphaned volume directories automatically ([#95301](https://github.com/kubernetes/kubernetes/pull/95301), [@lorenz](https://github.com/lorenz)) [SIG Node and Storage]
- Kubelet.exe on Windows now checks that the process running as administrator and the executing user account is listed in the built-in administrators group.  This is the equivalent to checking the process is running as uid 0. ([#96616](https://github.com/kubernetes/kubernetes/pull/96616), [@perithompson](https://github.com/perithompson)) [SIG Node and Windows]
- Kubelet: Fix kubelet from panic after getting the wrong signal ([#98200](https://github.com/kubernetes/kubernetes/pull/98200), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Kubelet: Fix repeatedly acquiring the inhibit lock ([#98088](https://github.com/kubernetes/kubernetes/pull/98088), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Kubelet: Fixed the bug of getting the number of cpu when the number of cpu logical processors is more than 64 in windows ([#97378](https://github.com/kubernetes/kubernetes/pull/97378), [@hwdef](https://github.com/hwdef)) [SIG Node and Windows]
- Mitigate CVE-2020-8555 for kube-up using GCE by preventing local loopback folume hosts. ([#97934](https://github.com/kubernetes/kubernetes/pull/97934), [@mattcary](https://github.com/mattcary)) [SIG Cloud Provider and Storage]
- On single-stack configured (IPv4 or IPv6, but not both) clusters, Services which are both headless (no clusterIP) and selectorless (empty or undefined selector) will report `ipFamilyPolicy RequireDualStack` and will have entries in `ipFamilies[]` for both IPv4 and IPv6.  This is a change from alpha, but does not have any impact on the manually-specified Endpoints and EndpointSlices for the Service. ([#99555](https://github.com/kubernetes/kubernetes/pull/99555), [@thockin](https://github.com/thockin)) [SIG Apps and Network]
- Pass `KUBE_BUILD_CONFORMANCE=y` to the package-tarballs to reenable building the conformance tarballs. ([#100571](https://github.com/kubernetes/kubernetes/pull/100571), [@puerco](https://github.com/puerco)) [SIG Release]
- Performance regression #97685 has been fixed. ([#97860](https://github.com/kubernetes/kubernetes/pull/97860), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- Pod Log stats for windows now reports metrics ([#99221](https://github.com/kubernetes/kubernetes/pull/99221), [@jsturtevant](https://github.com/jsturtevant)) [SIG Node, Storage, Testing and Windows]
- Readjust kubelet_containers_per_pod_count bucket ([#98169](https://github.com/kubernetes/kubernetes/pull/98169), [@wawa0210](https://github.com/wawa0210)) [SIG Instrumentation and Node]
- Reduce vSphere volume name to 63 characters ([#100404](https://github.com/kubernetes/kubernetes/pull/100404), [@gnufied](https://github.com/gnufied)) [SIG Storage]
- Reduces delay initializing on non-AWS platforms docker runtime. ([#93260](https://github.com/kubernetes/kubernetes/pull/93260), [@nckturner](https://github.com/nckturner)) [SIG Cloud Provider]
- Remove CSI topology from migrated in-tree gcepd volume. ([#97823](https://github.com/kubernetes/kubernetes/pull/97823), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Cloud Provider and Storage]
- Removed `/sbin/apparmor_parser` requirement for the AppArmor host validation.
  This allows using AppArmor on distributions which ship the binary in a different path. ([#97968](https://github.com/kubernetes/kubernetes/pull/97968), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node and Testing]
- Requests with invalid timeout parameters in the request URL now appear in the audit log correctly. ([#96901](https://github.com/kubernetes/kubernetes/pull/96901), [@tkashem](https://github.com/tkashem)) [SIG API Machinery and Testing]
- Resolve a "concurrent map read and map write" crashing error in the kubelet ([#95111](https://github.com/kubernetes/kubernetes/pull/95111), [@choury](https://github.com/choury)) [SIG Node]
- Resolves spurious `Failed to list *v1.Secret` or `Failed to list *v1.ConfigMap` messages in kubelet logs. ([#99538](https://github.com/kubernetes/kubernetes/pull/99538), [@liggitt](https://github.com/liggitt)) [SIG Auth and Node]
- Respect ExecProbeTimeout=false for dockershim ([#100200](https://github.com/kubernetes/kubernetes/pull/100200), [@jackfrancis](https://github.com/jackfrancis)) [SIG Node and Testing]
- Return zero time (midnight on Jan. 1, 1970) instead of negative number when reporting startedAt and finishedAt of the not started or a running Pod when using dockershim as a runtime. ([#99585](https://github.com/kubernetes/kubernetes/pull/99585), [@Iceber](https://github.com/Iceber)) [SIG Node]
- Reverts breaking change to inline AzureFile volumes; referenced secrets are now searched for in the same namespace as the pod as in previous releases. ([#100563](https://github.com/kubernetes/kubernetes/pull/100563), [@msau42](https://github.com/msau42)) [SIG Storage]
- Scores from InterPodAffinity have stronger differentiation. ([#98096](https://github.com/kubernetes/kubernetes/pull/98096), [@leileiwan](https://github.com/leileiwan)) [SIG Scheduling]
- Specifying the KUBE_TEST_REPO environment variable when e2e tests are executed will instruct the test infrastructure to load that image from a location within the specified repo, using a predefined pattern. ([#93510](https://github.com/kubernetes/kubernetes/pull/93510), [@smarterclayton](https://github.com/smarterclayton)) [SIG Testing]
- Static pods will be deleted gracefully. ([#98103](https://github.com/kubernetes/kubernetes/pull/98103), [@gjkim42](https://github.com/gjkim42)) [SIG Node]
- Stdin is now only passed to client-go exec credential plugins when it is detected to be an interactive terminal. Previously, it was passed to client-go exec plugins when **stdout*- was detected to be an interactive terminal. ([#99654](https://github.com/kubernetes/kubernetes/pull/99654), [@ankeesler](https://github.com/ankeesler)) [SIG API Machinery and Auth]
- Sync node status during kubelet node shutdown.
  Adds an pod admission handler that rejects new pods when the node is in progress of shutting down. ([#98005](https://github.com/kubernetes/kubernetes/pull/98005), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- The maximum number of ports allowed in EndpointSlices has been increased from 100 to 20,000 ([#99795](https://github.com/kubernetes/kubernetes/pull/99795), [@robscott](https://github.com/robscott)) [SIG Network]
- Truncates a message if it hits the NoteLengthLimit when the scheduler records an event for the pod that indicates the pod has failed to schedule. ([#98715](https://github.com/kubernetes/kubernetes/pull/98715), [@carlory](https://github.com/carlory)) [SIG Scheduling]
- Updated k8s.gcr.io/ingress-gce-404-server-with-metrics-amd64 to a version that serves /metrics endpoint on a non-default port. ([#97621](https://github.com/kubernetes/kubernetes/pull/97621), [@vbannai](https://github.com/vbannai)) [SIG Cloud Provider]
- Updates dependency sigs.k8s.io/structured-merge-diff to v4.1.1 ([#100784](https://github.com/kubernetes/kubernetes/pull/100784), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Updates the commands 
   - kubectl kustomize {arg}
   - kubectl apply -k {arg}
  to use same code as kustomize CLI v4.0.5
   - [v4.0.5]: https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.0.5 ([#98946](https://github.com/kubernetes/kubernetes/pull/98946), [@monopole](https://github.com/monopole)) [SIG API Machinery, Architecture, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node and Storage]
- Use default timeout of 10s for Azure ACR credential provider. ([#100686](https://github.com/kubernetes/kubernetes/pull/100686), [@hasheddan](https://github.com/hasheddan)) [SIG Cloud Provider]
- Use force unmount for NFS volumes if regular mount fails after 1 minute timeout ([#96844](https://github.com/kubernetes/kubernetes/pull/96844), [@gnufied](https://github.com/gnufied)) [SIG Storage]
- Use network.Interface.VirtualMachine.ID to get the binded VM
  Skip standalone VM when reconciling LoadBalancer ([#97635](https://github.com/kubernetes/kubernetes/pull/97635), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Users will see increase in time for deletion of pods and also guarantee that removal of pod from api server  would mean deletion of all the resources from container runtime. ([#92817](https://github.com/kubernetes/kubernetes/pull/92817), [@kmala](https://github.com/kmala)) [SIG Node]
- Using exec auth plugins with kubectl no longer results in warnings about constructing many client instances from the same exec auth config. ([#97857](https://github.com/kubernetes/kubernetes/pull/97857), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Auth]
- When a CNI plugin returns dual-stack pod IPs, kubelet will now try to respect the
  "primary IP family" of the cluster by picking a primary pod IP of the same family
  as the (primary) node IP, rather than assuming that the CNI plugin returned the IPs
  in the order the administrator wanted (since some CNI plugins don't allow
  configuring this). ([#97979](https://github.com/kubernetes/kubernetes/pull/97979), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- When dynamically provisioning Azure File volumes for a premium account, the requested size will be set to 100GB if the request is initially lower than this value to accommodate Azure File requirements. ([#99122](https://github.com/kubernetes/kubernetes/pull/99122), [@huffmanca](https://github.com/huffmanca)) [SIG Cloud Provider and Storage]
- When using Containerd on Windows, the "C:\Windows\System32\drivers\etc\hosts" file will now be managed by kubelet. ([#83730](https://github.com/kubernetes/kubernetes/pull/83730), [@claudiubelu](https://github.com/claudiubelu)) [SIG Node and Windows]
- [kubeadm] Support for custom imagetags for etcd images which contain build metadata, when imagetags are in the form of version_metadata. For instance, if the etcd version is v3.4.13+patch.0, the supported imagetag would be v3.4.13_patch.0 ([#100350](https://github.com/kubernetes/kubernetes/pull/100350), [@jr0d](https://github.com/jr0d)) [SIG Cluster Lifecycle]
- `VolumeBindingArgs` now allow `BindTimeoutSeconds` to be set as zero, while the value zero indicates no waiting for the checking of volume binding operation. ([#99835](https://github.com/kubernetes/kubernetes/pull/99835), [@chendave](https://github.com/chendave)) [SIG Scheduling and Storage]
- `kubectl exec` and `kubectl attach` now honor the `--quiet` flag which suppresses output from the local binary that could be confused by a script with the remote command output (all non-failure output is hidden). In addition, print inline with exec and attach the list of alternate containers when we default to the first spec.container. ([#99004](https://github.com/kubernetes/kubernetes/pull/99004), [@smarterclayton](https://github.com/smarterclayton)) [SIG CLI]

### Other (Cleanup or Flake)

- APIs for kubelet annotations and labels from k8s.io/kubernetes/pkg/kubelet/apis are now available under k8s.io/kubelet/pkg/apis/ ([#98931](https://github.com/kubernetes/kubernetes/pull/98931), [@michaelbeaumont](https://github.com/michaelbeaumont)) [SIG Apps, Auth and Node]
- Apiserver_request_duration_seconds is promoted to stable status. ([#99925](https://github.com/kubernetes/kubernetes/pull/99925), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery, Instrumentation and Testing]
- Apiserver_request_total is promoted to stable status and no longer has a content-type dimensions, so any alerts/charts which presume the existence of this will fail. This is however, unlikely to be the case since it was effectively an unbounded dimension in the first place. ([#99788](https://github.com/kubernetes/kubernetes/pull/99788), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery, Instrumentation and Testing]
- Bump github.com/Azure/go-autorest/autorest to v0.11.12 ([#97033](https://github.com/kubernetes/kubernetes/pull/97033), [@patrickshan](https://github.com/patrickshan)) [SIG API Machinery, CLI, Cloud Provider and Cluster Lifecycle]
- Delete deprecated `service.beta.kubernetes.io/azure-load-balancer-mixed-protocols` mixed procotol annotation in favor of the MixedProtocolLBService feature ([#97096](https://github.com/kubernetes/kubernetes/pull/97096), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- DynamicFakeClient now exposes its tracker via a `Tracker()` function ([#100085](https://github.com/kubernetes/kubernetes/pull/100085), [@markusthoemmes](https://github.com/markusthoemmes)) [SIG API Machinery]
- EndpointSlice generation is now incremented when labels change. ([#99750](https://github.com/kubernetes/kubernetes/pull/99750), [@robscott](https://github.com/robscott)) [SIG Network]
- Exposes WithCustomRoundTripper method for specifying a middleware function for custom HTTP behaviour for the delegated auth clients. ([#99775](https://github.com/kubernetes/kubernetes/pull/99775), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Featuregate AllowInsecureBackendProxy is promoted to GA ([#99658](https://github.com/kubernetes/kubernetes/pull/99658), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- If kube-apiserver enabled goaway feature, clients required golang 1.15.8 or 1.16+ version to avoid un-expected data race issue. ([#98809](https://github.com/kubernetes/kubernetes/pull/98809), [@answer1991](https://github.com/answer1991)) [SIG API Machinery]
- Kube-apiserver: The OIDC authenticator no longer waits 10 seconds before attempting to fetch the metadata required to verify tokens. ([#97693](https://github.com/kubernetes/kubernetes/pull/97693), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- Kube-proxy: Traffic from the cluster directed to ExternalIPs is always sent directly to the Service. ([#96296](https://github.com/kubernetes/kubernetes/pull/96296), [@aojea](https://github.com/aojea)) [SIG Network and Testing]
- Kubeadm: change the default image repository for CI images from 'gcr.io/kubernetes-ci-images' to 'gcr.io/k8s-staging-ci-images' ([#97087](https://github.com/kubernetes/kubernetes/pull/97087), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubectl: The deprecated `kubectl alpha debug` command is removed. Use `kubectl debug` instead. ([#98111](https://github.com/kubernetes/kubernetes/pull/98111), [@pandaamanda](https://github.com/pandaamanda)) [SIG CLI]
- Kubelet: completed support for structured logging ([#100196](https://github.com/kubernetes/kubernetes/pull/100196), [@ehashman](https://github.com/ehashman)) [SIG Instrumentation and Node]
- Migrate `pkg/kubelet/(cri)` to structured logging ([#99006](https://github.com/kubernetes/kubernetes/pull/99006), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Node]
- Migrate `pkg/kubelet/(eviction)` to structured logging ([#99032](https://github.com/kubernetes/kubernetes/pull/99032), [@yangjunmyfm192085](https://github.com/yangjunmyfm192085)) [SIG Node]
- Migrate `pkg/kubelet/(pod, pleg)` to structured logging ([#98990](https://github.com/kubernetes/kubernetes/pull/98990), [@gjkim42](https://github.com/gjkim42)) [SIG Instrumentation and Node]
- Migrate pkg/kubelet/cloudresource to structured logging ([#98999](https://github.com/kubernetes/kubernetes/pull/98999), [@sladyn98](https://github.com/sladyn98)) [SIG Node]
- Migrate pkg/kubelet/nodestatus to structured logging ([#99001](https://github.com/kubernetes/kubernetes/pull/99001), [@QiWang19](https://github.com/QiWang19)) [SIG Node]
- Migrate some log messages to structured logging in pkg/volume/volume_linux.go. ([#99566](https://github.com/kubernetes/kubernetes/pull/99566), [@huchengze](https://github.com/huchengze)) [SIG Instrumentation and Storage]
- Prepare to increased CSINodeIDMaxLength from 128  bytes to 192 bytes in 1.22. ([#98753](https://github.com/kubernetes/kubernetes/pull/98753), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Apps and Storage]
- Process start time on Windows now uses current process information ([#97491](https://github.com/kubernetes/kubernetes/pull/97491), [@jsturtevant](https://github.com/jsturtevant)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Windows]
- Resolves flakes in the Ingress conformance tests due to conflicts with controllers updating the Ingress object ([#98430](https://github.com/kubernetes/kubernetes/pull/98430), [@liggitt](https://github.com/liggitt)) [SIG Network and Testing]
- Several flags related to the deprecated dockershim which are present in the kubelet command line are now deprecated. ([#98730](https://github.com/kubernetes/kubernetes/pull/98730), [@dims](https://github.com/dims)) [SIG Node]
- The `AttachVolumeLimit` feature gate that is GA since v1.17 is now removed. ([#96539](https://github.com/kubernetes/kubernetes/pull/96539), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Storage]
- The `CSINodeInfo` feature gate that is GA since v1.17 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#96561](https://github.com/kubernetes/kubernetes/pull/96561), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Apps, Auth, Scheduling, Storage and Testing]
- The default delegating authorization options now allow unauthenticated access to healthz, readyz, and livez.  A system:masters user connecting to an authz delegator will not perform an authz check. ([#98325](https://github.com/kubernetes/kubernetes/pull/98325), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Auth, Cloud Provider and Scheduling]
- The deprecated feature gates `CSIDriverRegistry`, `BlockVolume` and `CSIBlockVolume` are now unconditionally enabled and can no longer be specified in component invocations. ([#98021](https://github.com/kubernetes/kubernetes/pull/98021), [@gavinfish](https://github.com/gavinfish)) [SIG Storage]
- The deprecated feature gates `RotateKubeletClientCertificate`, `AttachVolumeLimit`, `VolumePVCDataSource` and `EvenPodsSpread` are now unconditionally enabled and can no longer be specified in component invocations. ([#97306](https://github.com/kubernetes/kubernetes/pull/97306), [@gavinfish](https://github.com/gavinfish)) [SIG Node, Scheduling and Storage]
- The e2e suite can be instructed not to wait for pods in kube-system to be ready or for all nodes to be ready by passing `--allowed-not-ready-nodes=-1` when invoking the e2e.test program. This allows callers to run subsets of the e2e suite in scenarios other than perfectly healthy clusters. ([#98781](https://github.com/kubernetes/kubernetes/pull/98781), [@smarterclayton](https://github.com/smarterclayton)) [SIG Testing]
- The feature gates `WindowsGMSA` and `WindowsRunAsUserName` that are GA since v1.18 are now removed. ([#96531](https://github.com/kubernetes/kubernetes/pull/96531), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Node and Windows]
- The new `-gce-zones` flag on the `e2e.test` binary instructs tests that check for information about how the cluster interacts with the cloud to limit their queries to the provided zone list. If not specified, the current behavior of asking the cloud provider for all available zones in multi zone clusters is preserved. ([#98787](https://github.com/kubernetes/kubernetes/pull/98787), [@smarterclayton](https://github.com/smarterclayton)) [SIG API Machinery, Cluster Lifecycle and Testing]
- Update cri-tools to [v1.20.0](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.20.0) ([#97967](https://github.com/kubernetes/kubernetes/pull/97967), [@rajibmitra](https://github.com/rajibmitra)) [SIG Cloud Provider]
- Windows nodes on GCE will take longer to start due to dependencies installed at node creation time. ([#98284](https://github.com/kubernetes/kubernetes/pull/98284), [@pjh](https://github.com/pjh)) [SIG Cloud Provider]
- `apiserver_storage_objects` (a newer version of `etcd_object_counts) is promoted and marked as stable. ([#100082](https://github.com/kubernetes/kubernetes/pull/100082), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery, Instrumentation and Testing]

### Uncategorized

- GCE L4 Loadbalancers now handle > 5 ports in service spec correctly. ([#99595](https://github.com/kubernetes/kubernetes/pull/99595), [@prameshj](https://github.com/prameshj)) [SIG Cloud Provider]
- The DownwardAPIHugePages feature is beta.  Users may use the feature if all workers in their cluster are min 1.20 version.  The feature will be enabled by default in all installations in 1.22. ([#99610](https://github.com/kubernetes/kubernetes/pull/99610), [@derekwaynecarr](https://github.com/derekwaynecarr)) [SIG Node]

## Dependencies

### Added
- github.com/go-errors/errors: [v1.0.1](https://github.com/go-errors/errors/tree/v1.0.1)
- github.com/gobuffalo/here: [v0.6.0](https://github.com/gobuffalo/here/tree/v0.6.0)
- github.com/google/shlex: [e7afc7f](https://github.com/google/shlex/tree/e7afc7f)
- github.com/markbates/pkger: [v0.17.1](https://github.com/markbates/pkger/tree/v0.17.1)
- github.com/moby/spdystream: [v0.2.0](https://github.com/moby/spdystream/tree/v0.2.0)
- github.com/monochromegane/go-gitignore: [205db1a](https://github.com/monochromegane/go-gitignore/tree/205db1a)
- github.com/niemeyer/pretty: [a10e7ca](https://github.com/niemeyer/pretty/tree/a10e7ca)
- github.com/xlab/treeprint: [a009c39](https://github.com/xlab/treeprint/tree/a009c39)
- go.starlark.net: 8dd3e2e
- golang.org/x/term: 6a3ed07
- sigs.k8s.io/kustomize/api: v0.8.5
- sigs.k8s.io/kustomize/cmd/config: v0.9.7
- sigs.k8s.io/kustomize/kustomize/v4: v4.0.5
- sigs.k8s.io/kustomize/kyaml: v0.10.15

### Changed
- dmitri.shuralyov.com/gpu/mtl: 666a987 → 28db891
- github.com/Azure/go-autorest/autorest: [v0.11.1 → v0.11.12](https://github.com/Azure/go-autorest/autorest/compare/v0.11.1...v0.11.12)
- github.com/NYTimes/gziphandler: [56545f4 → v1.1.1](https://github.com/NYTimes/gziphandler/compare/56545f4...v1.1.1)
- github.com/cilium/ebpf: [1c8d4c9 → v0.2.0](https://github.com/cilium/ebpf/compare/1c8d4c9...v0.2.0)
- github.com/container-storage-interface/spec: [v1.2.0 → v1.3.0](https://github.com/container-storage-interface/spec/compare/v1.2.0...v1.3.0)
- github.com/containerd/console: [v1.0.0 → v1.0.1](https://github.com/containerd/console/compare/v1.0.0...v1.0.1)
- github.com/containerd/containerd: [v1.4.1 → v1.4.4](https://github.com/containerd/containerd/compare/v1.4.1...v1.4.4)
- github.com/coredns/corefile-migration: [v1.0.10 → v1.0.11](https://github.com/coredns/corefile-migration/compare/v1.0.10...v1.0.11)
- github.com/creack/pty: [v1.1.7 → v1.1.11](https://github.com/creack/pty/compare/v1.1.7...v1.1.11)
- github.com/docker/docker: [bd33bbf → v20.10.2+incompatible](https://github.com/docker/docker/compare/bd33bbf...v20.10.2)
- github.com/go-logr/logr: [v0.2.0 → v0.4.0](https://github.com/go-logr/logr/compare/v0.2.0...v0.4.0)
- github.com/go-openapi/spec: [v0.19.3 → v0.19.5](https://github.com/go-openapi/spec/compare/v0.19.3...v0.19.5)
- github.com/go-openapi/strfmt: [v0.19.3 → v0.19.5](https://github.com/go-openapi/strfmt/compare/v0.19.3...v0.19.5)
- github.com/go-openapi/validate: [v0.19.5 → v0.19.8](https://github.com/go-openapi/validate/compare/v0.19.5...v0.19.8)
- github.com/gogo/protobuf: [v1.3.1 → v1.3.2](https://github.com/gogo/protobuf/compare/v1.3.1...v1.3.2)
- github.com/golang/mock: [v1.4.1 → v1.4.4](https://github.com/golang/mock/compare/v1.4.1...v1.4.4)
- github.com/google/cadvisor: [v0.38.5 → v0.39.0](https://github.com/google/cadvisor/compare/v0.38.5...v0.39.0)
- github.com/heketi/heketi: [c2e2a4a → v10.2.0+incompatible](https://github.com/heketi/heketi/compare/c2e2a4a...v10.2.0)
- github.com/kisielk/errcheck: [v1.2.0 → v1.5.0](https://github.com/kisielk/errcheck/compare/v1.2.0...v1.5.0)
- github.com/konsorten/go-windows-terminal-sequences: [v1.0.3 → v1.0.2](https://github.com/konsorten/go-windows-terminal-sequences/compare/v1.0.3...v1.0.2)
- github.com/kr/text: [v0.1.0 → v0.2.0](https://github.com/kr/text/compare/v0.1.0...v0.2.0)
- github.com/mattn/go-runewidth: [v0.0.2 → v0.0.7](https://github.com/mattn/go-runewidth/compare/v0.0.2...v0.0.7)
- github.com/miekg/dns: [v1.1.4 → v1.1.35](https://github.com/miekg/dns/compare/v1.1.4...v1.1.35)
- github.com/moby/sys/mountinfo: [v0.1.3 → v0.4.0](https://github.com/moby/sys/mountinfo/compare/v0.1.3...v0.4.0)
- github.com/moby/term: [672ec06 → df9cb8a](https://github.com/moby/term/compare/672ec06...df9cb8a)
- github.com/mrunalp/fileutils: [abd8a0e → v0.5.0](https://github.com/mrunalp/fileutils/compare/abd8a0e...v0.5.0)
- github.com/olekukonko/tablewriter: [a0225b3 → v0.0.4](https://github.com/olekukonko/tablewriter/compare/a0225b3...v0.0.4)
- github.com/opencontainers/runc: [v1.0.0-rc92 → v1.0.0-rc93](https://github.com/opencontainers/runc/compare/v1.0.0-rc92...v1.0.0-rc93)
- github.com/opencontainers/runtime-spec: [4d89ac9 → e6143ca](https://github.com/opencontainers/runtime-spec/compare/4d89ac9...e6143ca)
- github.com/opencontainers/selinux: [v1.6.0 → v1.8.0](https://github.com/opencontainers/selinux/compare/v1.6.0...v1.8.0)
- github.com/sergi/go-diff: [v1.0.0 → v1.1.0](https://github.com/sergi/go-diff/compare/v1.0.0...v1.1.0)
- github.com/sirupsen/logrus: [v1.6.0 → v1.7.0](https://github.com/sirupsen/logrus/compare/v1.6.0...v1.7.0)
- github.com/syndtr/gocapability: [d983527 → 42c35b4](https://github.com/syndtr/gocapability/compare/d983527...42c35b4)
- github.com/willf/bitset: [d5bec33 → v1.1.11](https://github.com/willf/bitset/compare/d5bec33...v1.1.11)
- github.com/yuin/goldmark: [v1.1.27 → v1.2.1](https://github.com/yuin/goldmark/compare/v1.1.27...v1.2.1)
- golang.org/x/crypto: 7f63de1 → 5ea612d
- golang.org/x/exp: 6cc2880 → 85be41e
- golang.org/x/mobile: d2bd2a2 → e6ae53a
- golang.org/x/mod: v0.3.0 → ce943fd
- golang.org/x/net: 69a7880 → 3d97a24
- golang.org/x/sync: cd5d95a → 67f06af
- golang.org/x/sys: 5cba982 → a50acf3
- golang.org/x/time: 3af7569 → f8bda1e
- golang.org/x/tools: c1934b7 → v0.1.0
- gopkg.in/check.v1: 41f04d3 → 8fa4692
- gopkg.in/yaml.v2: v2.2.8 → v2.4.0
- gotest.tools/v3: v3.0.2 → v3.0.3
- k8s.io/gengo: 83324d8 → b6c5ce2
- k8s.io/klog/v2: v2.4.0 → v2.8.0
- k8s.io/kube-openapi: d219536 → 591a79e
- k8s.io/system-validators: v1.2.0 → v1.4.0
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.14 → v0.0.15
- sigs.k8s.io/structured-merge-diff/v4: v4.0.2 → v4.1.0

### Removed
- github.com/codegangsta/negroni: [v1.0.0](https://github.com/codegangsta/negroni/tree/v1.0.0)
- github.com/docker/spdystream: [449fdfc](https://github.com/docker/spdystream/tree/449fdfc)
- github.com/golangplus/bytes: [45c989f](https://github.com/golangplus/bytes/tree/45c989f)
- github.com/golangplus/fmt: [2a5d6d7](https://github.com/golangplus/fmt/tree/2a5d6d7)
- github.com/gorilla/context: [v1.1.1](https://github.com/gorilla/context/tree/v1.1.1)
- github.com/kr/pty: [v1.1.5](https://github.com/kr/pty/tree/v1.1.5)
- rsc.io/quote/v3: v3.1.0
- rsc.io/sampler: v1.3.0
- sigs.k8s.io/kustomize: v2.0.3+incompatible
