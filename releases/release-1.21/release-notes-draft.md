# Release notes for v1.21.0-alpha.2

[Documentation](https://docs.k8s.io/docs/home)
# Changelog since v1.20.0

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Kube-proxy's IPVS proxy mode no longer sets the net.ipv4.conf.all.route_localnet sysctl parameter. Nodes upgrading will have net.ipv4.conf.all.route_localnet set to 1 but new nodes will inherit the system default (usually 0). If you relied on any behavior requiring net.ipv4.conf.all.route_localnet, you must set ensure it is enabled as kube-proxy will no longer set it automatically. This change helps to further mitigate CVE-2020-8558. ([#92938](https://github.com/kubernetes/kubernetes/pull/92938), [@lbernail](https://github.com/lbernail)) [SIG Network and Release]
 - Remove alpha CSIMigrationXXComplete flag and add alpha InTreePluginXXUnregister flag. Deprecate CSIMigrationvSphereComplete flag and it will be removed in 1.22. ([#98243](https://github.com/kubernetes/kubernetes/pull/98243), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Node and Storage]
 - Remove storage metrics `storage_operation_errors_total`, since we already have `storage_operation_status_count`.And add new field `status` for `storage_operation_duration_seconds`, so that we can know about all status storage operation latency. ([#98332](https://github.com/kubernetes/kubernetes/pull/98332), [@JornShen](https://github.com/JornShen)) [SIG Instrumentation and Storage]
 - `ServiceNodeExclusion`, `NodeDisruptionExclusion` and `LegacyNodeRoleBehavior`(locked to false) features have been promoted to GA. 
  To prevent control plane nodes from being added to load balancers automatically, upgrade users need to add "node.kubernetes.io/exclude-from-external-load-balancers"  label to control plane nodes. ([#97543](https://github.com/kubernetes/kubernetes/pull/97543), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery, Apps, Cloud Provider and Network]
 
## Changes by Kind

### Deprecation

- Deprecate the `topologyKeys` field in Service. This capability will be replaced with upcoming work around Topology Aware Subsetting and Service Internal Traffic Policy. ([#96736](https://github.com/kubernetes/kubernetes/pull/96736), [@andrewsykim](https://github.com/andrewsykim)) [SIG Apps]
- Kubeadm: deprecated command "alpha selfhosting pivot" is removed now. ([#97627](https://github.com/kubernetes/kubernetes/pull/97627), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: graduate the command `kubeadm alpha kubeconfig user` to `kubeadm kubeconfig user`. The `kubeadm alpha kubeconfig user` command is deprecated now. ([#97583](https://github.com/kubernetes/kubernetes/pull/97583), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: the "kubeadm alpha certs" command is removed now, please use "kubeadm certs" instead. ([#97706](https://github.com/kubernetes/kubernetes/pull/97706), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Remove the TokenRequest and TokenRequestProjection feature gates ([#97148](https://github.com/kubernetes/kubernetes/pull/97148), [@wawa0210](https://github.com/wawa0210)) [SIG Node]
- Remove the deprecated metrics "scheduling_algorithm_preemption_evaluation_seconds" and "binding_duration_seconds", suggest to use "scheduler_framework_extension_point_duration_seconds" instead. ([#96447](https://github.com/kubernetes/kubernetes/pull/96447), [@chendave](https://github.com/chendave)) [SIG Cluster Lifecycle, Instrumentation, Scheduling and Testing]
- Removing experimental windows container hyper-v support with Docker ([#97141](https://github.com/kubernetes/kubernetes/pull/97141), [@wawa0210](https://github.com/wawa0210)) [SIG Node and Windows]
- The PodSecurityPolicy API is deprecated in 1.21, and will no longer be served starting in 1.25. ([#97171](https://github.com/kubernetes/kubernetes/pull/97171), [@deads2k](https://github.com/deads2k)) [SIG Auth and CLI]
- The `export` query parameter (inconsistently supported by API resources and deprecated in v1.14) is fully removed.  Requests setting this query parameter will now receive a 400 status response. ([#98312](https://github.com/kubernetes/kubernetes/pull/98312), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Auth and Testing]

### API Change

- Change the APIVersion proto name of BoundObjectRef from aPIVersion to apiVersion. ([#97379](https://github.com/kubernetes/kubernetes/pull/97379), [@kebe7jun](https://github.com/kebe7jun)) [SIG Auth]
- Enable SPDY pings to keep connections alive, so that `kubectl exec` and `kubectl portforward` won't be interrupted. ([#97083](https://github.com/kubernetes/kubernetes/pull/97083), [@knight42](https://github.com/knight42)) [SIG API Machinery and CLI]
- Promote Immutable Secrets/ConfigMaps feature to Stable.
  This allows to set `Immutable` field in Secrets or ConfigMap object to mark their contents as immutable. ([#97615](https://github.com/kubernetes/kubernetes/pull/97615), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps, Architecture, Node and Testing]

### Feature

- Add flag --lease-reuse-duration-seconds for kube-apiserver to config etcd lease reuse duration. ([#97009](https://github.com/kubernetes/kubernetes/pull/97009), [@lingsamuel](https://github.com/lingsamuel)) [SIG API Machinery and Scalability]
- Add metric etcd_lease_object_counts for kube-apiserver to observe max objects attached to a single etcd lease. ([#97480](https://github.com/kubernetes/kubernetes/pull/97480), [@lingsamuel](https://github.com/lingsamuel)) [SIG API Machinery, Instrumentation and Scalability]
- Adds the ability to pass --strict-transport-security-directives to the kube-apiserver to set the HSTS header appropriately.  Be sure you understand the consequences to browsers before setting this field. ([#96502](https://github.com/kubernetes/kubernetes/pull/96502), [@249043822](https://github.com/249043822)) [SIG Auth]
- Base-images: Update to debian-iptables:buster-v1.4.0
  - Uses iptables 1.8.5
  - base-images: Update to debian-base:buster-v1.3.0
  - cluster/images/etcd: Build etcd:3.4.13-2 image
    - Uses debian-base:buster-v1.3.0 ([#98401](https://github.com/kubernetes/kubernetes/pull/98401), [@pacoxu](https://github.com/pacoxu)) [SIG Testing]
- Export NewDebuggingRoundTripper function and DebugLevel options in the k8s.io/client-go/transport package. ([#98324](https://github.com/kubernetes/kubernetes/pull/98324), [@atosatto](https://github.com/atosatto)) [SIG API Machinery]
- Kubeadm now includes CoreDNS v1.8.0. ([#96429](https://github.com/kubernetes/kubernetes/pull/96429), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cluster Lifecycle]
- Kubeadm: add support for certificate chain validation. When using kubeadm in external CA mode, this allows an intermediate CA to be used to sign the certificates. The intermediate CA certificate must be appended to each signed certificate for this to work correctly. ([#97266](https://github.com/kubernetes/kubernetes/pull/97266), [@robbiemcmichael](https://github.com/robbiemcmichael)) [SIG Cluster Lifecycle]
- Kubeadm: amend the node kernel validation to treat CGROUP_PIDS, FAIR_GROUP_SCHED as required and CFS_BANDWIDTH, CGROUP_HUGETLB as optional ([#96378](https://github.com/kubernetes/kubernetes/pull/96378), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle and Node]
- Kubectl wait ensures that observedGeneration >= generation if applicable ([#97408](https://github.com/kubernetes/kubernetes/pull/97408), [@KnicKnic](https://github.com/KnicKnic)) [SIG CLI]
- New admission controller "denyserviceexternalips" is available.  Clusters which do not *need- the Service "externalIPs" feature should enable this controller and be more secure. ([#97395](https://github.com/kubernetes/kubernetes/pull/97395), [@thockin](https://github.com/thockin)) [SIG API Machinery]
- Overall, enable the feature of `PreferNominatedNode` will  improve the performance of scheduling where preemption might frequently happen, but in theory, enable the feature of `PreferNominatedNode`, the pod might not be scheduled to the best candidate node in the cluster. ([#93179](https://github.com/kubernetes/kubernetes/pull/93179), [@chendave](https://github.com/chendave)) [SIG Scheduling and Testing]
- Port the devicemanager to Windows node to allow device plugins like directx ([#93285](https://github.com/kubernetes/kubernetes/pull/93285), [@aarnaud](https://github.com/aarnaud)) [SIG Node, Testing and Windows]
- The Kubernetes pause image manifest list now contains an image for Windows Server 20H2. ([#97322](https://github.com/kubernetes/kubernetes/pull/97322), [@claudiubelu](https://github.com/claudiubelu)) [SIG Windows]
- The apimachinery util/net function used to detect the bind address `ResolveBindAddress()`
  takes into consideration global ip addresses on loopback interfaces when:
      - the host has default routes
      - there are no global IPs on those interfaces.
  in order to support more complex network scenarios like BGP Unnumbered RFC 5549 ([#95790](https://github.com/kubernetes/kubernetes/pull/95790), [@aojea](https://github.com/aojea)) [SIG Network]

### Documentation

- Set kubelet option `--volume-stats-agg-period` to negative value to disable volume calculations. ([#96675](https://github.com/kubernetes/kubernetes/pull/96675), [@pacoxu](https://github.com/pacoxu)) [SIG Node]

### Bug or Regression

- ## Changelog
  
  ### General
  - Fix priority expander falling back to a random choice even though there is a higher priority option to choose
  - Clone `kubernetes/kubernetes` in `update-vendor.sh` shallowly, instead of fetching all revisions
  - Speed up binpacking by reducing the number of PreFilter calls (call once per pod instead of #pods*#nodes times)
  - Speed up finding unneeded nodes by 5x+ in very large clusters by reducing the number of PreFilter calls
  - Expose `--max-nodes-total` as a metric
  - Errors in `IncreaseSize` changed fromt type `apiError` to `cloudProviderError`
  - Make `build-in-docker` and `test-in-docker` work on Linux systems with SELinux enabled
  - Fix an error where existing nodes were not considered as destinations while finding place for pods in scale-down simulations
  - Remove redundant log lines and reduce severity around parsing kubeEnv
  - Don't treat nodes created by virtual kuebelet as nodes from non-autoscaled node groups
  - Remove redundant logging around calculating node utilization
  - Add configurable `--network` and `--rm` flags for docker in `Makefile`
  - Substract DaemonSet pods' requests from node allocatable in the denominator while computing node utilization
  - Include taints by condition when determining if a node is unready/still starting
  - Fix `update-vendor.sh` to work on OSX and zsh
  - Add best-effort eviction for DaemonSet pods while scaling down non-empty nodes
  - Add build support for ARM64
  
  ### AliCloud
  - Add missing daemonsets and replicasets to ALI example cluster role
  
  ### Apache CloudStack
  - Add support for Apache CloudStack
  
  ### AWS
  - Regenerate list of EC2 instances
  - Fix pricing endpoint in AWS China Region
  
  ### Azure
  - Add optional jitter on initial VMSS VM cache refresh, keep the refreshes spread over time
  - Serve from cache for the whole period of ongoing throttling
  - Fix unwanted VMSS VMs cache invalidations
  - Enforce setting the number of retries if cloud provider backoff is enabled
  - Don't update capacity if VMSS provisioning state is updating
  - Support allocatable resources overrides via VMSS tags
  - Add missing stable labels in template nodes
  - Proactively set instance status to deleting on node deletions
  
  ### Cluster API
  - Migrate interaction with the API from using internal types to using Unstructured
  - Improve tests to work better with constrained resources
  - Add support for node autodiscovery
  - Add support for `--cloud-config`
  - Update group identifier to use for Cluster API annotations
  
  ### Exoscale
  - Add support for Exoscale
  
  ### GCE
  - Decrease the number of GCE Read Requests made while deleting nodes
  - Base pricing of custom instances on their instance family type
  - Add pricing information for missing machine types
  - Add pricing information for different GPU types
  - Ignore the new `topology.gke.io/zone` label when comparing groups
  - Add missing stable labels to template nodes
  
  ### HuaweiCloud
  - Add auto scaling group support
  - Implement node group by AS
  - Implement getting desired instance number of node group
  - Implement increasing node group size
  - Implement TemplateNodeInfo
  - Implement caching instances
  
  ### IONOS
  - Add support for IONOS
  
  ### Kubemark
  - Skip non-kubemark nodes while computing node infos for node groups.
  
  ### Magnum
  - Add Magnum support in the Cluster Autoscaler helm chart
  
  ### Packet
  - Allow empty nodepools
  - Add support for multiple nodepools
  - Add pricing support
  
  ## Image
  Image: `k8s.gcr.io/autoscaling/cluster-autoscaler:v1.20.0` ([#97011](https://github.com/kubernetes/kubernetes/pull/97011), [@towca](https://github.com/towca)) [SIG Cloud Provider]
- AcceleratorStats will be available in the Summary API of kubelet when cri_stats_provider is used. ([#96873](https://github.com/kubernetes/kubernetes/pull/96873), [@ruiwen-zhao](https://github.com/ruiwen-zhao)) [SIG Node]
- Add limited lines to log when having tail option ([#93920](https://github.com/kubernetes/kubernetes/pull/93920), [@zhouya0](https://github.com/zhouya0)) [SIG Node]
- Avoid systemd-logind loading configuration warning ([#97950](https://github.com/kubernetes/kubernetes/pull/97950), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Clean ReplicaSet by revision instead of creation timestamp in deployment controller ([#97407](https://github.com/kubernetes/kubernetes/pull/97407), [@waynepeking348](https://github.com/waynepeking348)) [SIG Apps]
- Cloud-controller-manager: routes controller should not depend on --allocate-node-cidrs ([#97029](https://github.com/kubernetes/kubernetes/pull/97029), [@andrewsykim](https://github.com/andrewsykim)) [SIG Cloud Provider and Testing]
- Copy annotations with empty value when deployment rolls back ([#94858](https://github.com/kubernetes/kubernetes/pull/94858), [@waynepeking348](https://github.com/waynepeking348)) [SIG Apps]
- Detach volumes from vSphere nodes not tracked by attach-detach controller ([#96689](https://github.com/kubernetes/kubernetes/pull/96689), [@gnufied](https://github.com/gnufied)) [SIG Cloud Provider and Storage]
- Ensure that client-go's EventBroadcaster is safe (non-racy) during shutdown. ([#95664](https://github.com/kubernetes/kubernetes/pull/95664), [@DirectXMan12](https://github.com/DirectXMan12)) [SIG API Machinery]
- Fix Azure file share not deleted issue when the namespace is deleted ([#97417](https://github.com/kubernetes/kubernetes/pull/97417), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix CSI-migrated inline EBS volumes failing to mount if their volumeID is prefixed by aws:// ([#96821](https://github.com/kubernetes/kubernetes/pull/96821), [@wongma7](https://github.com/wongma7)) [SIG Storage]
- Fix CVE-2020-8555 for Gluster client connections. ([#97922](https://github.com/kubernetes/kubernetes/pull/97922), [@liggitt](https://github.com/liggitt)) [SIG Storage]
- Fix NPE in ephemeral storage eviction ([#98261](https://github.com/kubernetes/kubernetes/pull/98261), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Fix azure file migration issue ([#97877](https://github.com/kubernetes/kubernetes/pull/97877), [@andyzhangx](https://github.com/andyzhangx)) [SIG Auth, Cloud Provider and Storage]
- Fix counting error in service/nodeport/loadbalancer quota check ([#97451](https://github.com/kubernetes/kubernetes/pull/97451), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery, Network and Testing]
- Fix kubectl label error when local=true is set ([#97440](https://github.com/kubernetes/kubernetes/pull/97440), [@pandaamanda](https://github.com/pandaamanda)) [SIG CLI]
- Fix kubectl-convert import known versions ([#97754](https://github.com/kubernetes/kubernetes/pull/97754), [@wzshiming](https://github.com/wzshiming)) [SIG CLI and Testing]
- Fix kubelet from panic after getting the wrong signal ([#98200](https://github.com/kubernetes/kubernetes/pull/98200), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Fix missing cadvisor machine metrics. ([#97006](https://github.com/kubernetes/kubernetes/pull/97006), [@lingsamuel](https://github.com/lingsamuel)) [SIG Node]
- Fix nil VMSS name when setting service to auto mode ([#97366](https://github.com/kubernetes/kubernetes/pull/97366), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix repeatedly aquire the inhibit lock ([#98088](https://github.com/kubernetes/kubernetes/pull/98088), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Fix the panic when kubelet registers if a node object already exists with no Status.Capacity or Status.Allocatable ([#95269](https://github.com/kubernetes/kubernetes/pull/95269), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- Fix the regression with the slow pods termination. Before this fix pods may take an additional time to terminate - up to one minute. Reversing the change that ensured that CNI resources cleaned up when the pod is removed on API server. ([#97980](https://github.com/kubernetes/kubernetes/pull/97980), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Node]
- Fix to recover CSI volumes from certain dangling attachments ([#96617](https://github.com/kubernetes/kubernetes/pull/96617), [@yuga711](https://github.com/yuga711)) [SIG Apps and Storage]
- Fix: azure file latency issue for metadata-heavy workloads ([#97082](https://github.com/kubernetes/kubernetes/pull/97082), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fixed Cinder volume IDs on OpenStack Train ([#96673](https://github.com/kubernetes/kubernetes/pull/96673), [@jsafrane](https://github.com/jsafrane)) [SIG Cloud Provider]
- Fixed FibreChannel volume plugin corrupting filesystems on detach of multipath volumes. ([#97013](https://github.com/kubernetes/kubernetes/pull/97013), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed a bug in kubelet that will saturate CPU utilization after containerd got restarted. ([#97174](https://github.com/kubernetes/kubernetes/pull/97174), [@hanlins](https://github.com/hanlins)) [SIG Node]
- Fixed a bug that the kubelet cannot start on BtrfS. ([#98042](https://github.com/kubernetes/kubernetes/pull/98042), [@gjkim42](https://github.com/gjkim42)) [SIG Node]
- Fixed an issue with garbage collection failing to clean up namespaced children of an object also referenced incorrectly by cluster-scoped children ([#98068](https://github.com/kubernetes/kubernetes/pull/98068), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Apps]
- Fixed bug in CPUManager with race on container map access ([#97427](https://github.com/kubernetes/kubernetes/pull/97427), [@klueska](https://github.com/klueska)) [SIG Node]
- Fixed cleanup of block devices when /var/lib/kubelet is a symlink. ([#96889](https://github.com/kubernetes/kubernetes/pull/96889), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed no effect namespace when exposing deployment with --dry-run=client. ([#97492](https://github.com/kubernetes/kubernetes/pull/97492), [@masap](https://github.com/masap)) [SIG CLI]
- Fixes connection errors when using `--volume-host-cidr-denylist` or `--volume-host-allow-local-loopback` ([#98436](https://github.com/kubernetes/kubernetes/pull/98436), [@liggitt](https://github.com/liggitt)) [SIG Network and Storage]
- Fixing a bug where a failed node may not have the NoExecute taint set correctly ([#96876](https://github.com/kubernetes/kubernetes/pull/96876), [@howieyuen](https://github.com/howieyuen)) [SIG Apps and Node]
- GCE Internal LoadBalancer sync loop will now release the ILB IP address upon sync failure. An error in ILB forwarding rule creation will no longer leak IP addresses. ([#97740](https://github.com/kubernetes/kubernetes/pull/97740), [@prameshj](https://github.com/prameshj)) [SIG Cloud Provider and Network]
- Ignore update pod with no new images in alwaysPullImages admission controller ([#96668](https://github.com/kubernetes/kubernetes/pull/96668), [@pacoxu](https://github.com/pacoxu)) [SIG Apps, Auth and Node]
- Indentation of `Resource Quota` block in kubectl describe namespaces output gets correct. ([#97946](https://github.com/kubernetes/kubernetes/pull/97946), [@dty1er](https://github.com/dty1er)) [SIG CLI]
- KUBECTL_EXTERNAL_DIFF now accepts equal sign for additional parameters. ([#98158](https://github.com/kubernetes/kubernetes/pull/98158), [@dougsland](https://github.com/dougsland)) [SIG CLI]
- Kubeadm now installs version 3.4.13 of etcd when creating a cluster with v1.19 ([#97244](https://github.com/kubernetes/kubernetes/pull/97244), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: avoid detection of the container runtime for commands that do not need it ([#97625](https://github.com/kubernetes/kubernetes/pull/97625), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug in the host memory detection code on 32bit Linux platforms ([#97403](https://github.com/kubernetes/kubernetes/pull/97403), [@abelbarrera15](https://github.com/abelbarrera15)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where "kubeadm join" would not properly handle missing names for existing etcd members. ([#97372](https://github.com/kubernetes/kubernetes/pull/97372), [@ihgann](https://github.com/ihgann)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where "kubeadm upgrade" commands can fail if CoreDNS v1.8.0 is installed. ([#97919](https://github.com/kubernetes/kubernetes/pull/97919), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubelet should ignore cgroup driver check on Windows node. ([#97764](https://github.com/kubernetes/kubernetes/pull/97764), [@pacoxu](https://github.com/pacoxu)) [SIG Node and Windows]
- Make podTopologyHints protected by lock ([#95111](https://github.com/kubernetes/kubernetes/pull/95111), [@choury](https://github.com/choury)) [SIG Node]
- Performance regresssion #97685 has been fixed. ([#97860](https://github.com/kubernetes/kubernetes/pull/97860), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- Readjust kubelet_containers_per_pod_count bucket ([#98169](https://github.com/kubernetes/kubernetes/pull/98169), [@wawa0210](https://github.com/wawa0210)) [SIG Instrumentation and Node]
- Remove CSI topology from migrated in-tree gcepd volume. ([#97823](https://github.com/kubernetes/kubernetes/pull/97823), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Cloud Provider and Storage]
- Remove deprecated --cleanup-ipvs flag of kube-proxy, and make --cleanup flag always to flush IPVS ([#97336](https://github.com/kubernetes/kubernetes/pull/97336), [@maaoBit](https://github.com/maaoBit)) [SIG Network]
- Scores from InterPodAffinity have stronger differentiation. ([#98096](https://github.com/kubernetes/kubernetes/pull/98096), [@leileiwan](https://github.com/leileiwan)) [SIG Scheduling]
- Specifying the KUBE_TEST_REPO environment variable when e2e tests are executed will instruct the test infrastructure to load that image from a location within the specified repo, using a predefined pattern. ([#93510](https://github.com/kubernetes/kubernetes/pull/93510), [@smarterclayton](https://github.com/smarterclayton)) [SIG Testing]
- Static pods will be deleted gracefully. ([#98103](https://github.com/kubernetes/kubernetes/pull/98103), [@gjkim42](https://github.com/gjkim42)) [SIG Node]
- Sync node status during kubelet node shutdown.
  Adds an pod admission handler that rejects new pods when the node is in progress of shutting down. ([#98005](https://github.com/kubernetes/kubernetes/pull/98005), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- The current version of the container image publicly exposed IP serving a /metrics endpoint to the Internet. The new version of the container image serves /metrics endpoint on a different port. ([#97621](https://github.com/kubernetes/kubernetes/pull/97621), [@vbannai](https://github.com/vbannai)) [SIG Cloud Provider]
- Use force unmount for NFS volumes if regular mount fails after 1 minute timeout ([#96844](https://github.com/kubernetes/kubernetes/pull/96844), [@gnufied](https://github.com/gnufied)) [SIG Storage]
- Use network.Interface.VirtualMachine.ID to get the binded VM
  Skip standalone VM when reconciling LoadBalancer ([#97635](https://github.com/kubernetes/kubernetes/pull/97635), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Users will see increase in time for deletion of pods and also guarantee that removal of pod from api server  would mean deletion of all the resources from container runtime. ([#92817](https://github.com/kubernetes/kubernetes/pull/92817), [@kmala](https://github.com/kmala)) [SIG Node]
- Using exec auth plugins with kubectl no longer results in warnings about constructing many client instances from the same exec auth config. ([#97857](https://github.com/kubernetes/kubernetes/pull/97857), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Auth]
- Warning about using a deprecated volume plugin is logged only once. ([#96751](https://github.com/kubernetes/kubernetes/pull/96751), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- We will no longer automatically delete all data when a failure is detected during creation of the volume data file on a CSI volume. Now we will only remove the data file and volume path. ([#96021](https://github.com/kubernetes/kubernetes/pull/96021), [@huffmanca](https://github.com/huffmanca)) [SIG Storage]

### Other (Cleanup or Flake)

- Bump github.com/Azure/go-autorest/autorest to v0.11.12 ([#97033](https://github.com/kubernetes/kubernetes/pull/97033), [@patrickshan](https://github.com/patrickshan)) [SIG API Machinery, CLI, Cloud Provider and Cluster Lifecycle]
- Delete deprecated mixed procotol annotation ([#97096](https://github.com/kubernetes/kubernetes/pull/97096), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Kube-proxy: Traffic from the cluster directed to ExternalIPs is always send directly to the Service. ([#96296](https://github.com/kubernetes/kubernetes/pull/96296), [@aojea](https://github.com/aojea)) [SIG Network and Testing]
- Kubeadm: change the default image repository for CI images from 'gcr.io/kubernetes-ci-images' to 'gcr.io/k8s-staging-ci-images' ([#97087](https://github.com/kubernetes/kubernetes/pull/97087), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: fix a whitespace issue in the output of the "kubeadm join" command shown as the output of "kubeadm init" and "kubeadm token create --print-join-command" ([#97413](https://github.com/kubernetes/kubernetes/pull/97413), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: improve the error messaging when the user provides an invalid discovery token CA certificate hash. ([#97290](https://github.com/kubernetes/kubernetes/pull/97290), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Migrate generic_scheduler.go and types.go to structured logging. ([#98134](https://github.com/kubernetes/kubernetes/pull/98134), [@tanjing2020](https://github.com/tanjing2020)) [SIG Scheduling]
- Migrate log messages in pkg/scheduler/{scheduler.go,factory.go} to structured logging ([#97509](https://github.com/kubernetes/kubernetes/pull/97509), [@aldudko](https://github.com/aldudko)) [SIG Scheduling]
- Migrate proxy/iptables/proxier.go logs to structured logging ([#97678](https://github.com/kubernetes/kubernetes/pull/97678), [@JornShen](https://github.com/JornShen)) [SIG Network]
- Migrate proxy/winuserspace/proxier.go logs to structured logging ([#97941](https://github.com/kubernetes/kubernetes/pull/97941), [@JornShen](https://github.com/JornShen)) [SIG Network]
- Migrate some scheduler log messages to structured logging ([#97349](https://github.com/kubernetes/kubernetes/pull/97349), [@aldudko](https://github.com/aldudko)) [SIG Scheduling]
- Migrate staging/src/k8s.io/apiserver/pkg/admission logs to  structured logging ([#98138](https://github.com/kubernetes/kubernetes/pull/98138), [@lala123912](https://github.com/lala123912)) [SIG API Machinery]
- Migrate staging/src/k8s.io/apiserver/pkg/audit/policy/reader.go logs to structured logging. ([#98252](https://github.com/kubernetes/kubernetes/pull/98252), [@lala123912](https://github.com/lala123912)) [SIG API Machinery and Auth]
- Migrate staging\src\k8s.io\apiserver\pkg\endpoints logs to  structured logging ([#98093](https://github.com/kubernetes/kubernetes/pull/98093), [@lala123912](https://github.com/lala123912)) [SIG API Machinery]
- NetworkPolicy validation framework optimizations for rapidly verifying CNI's work correctly across several pods and namespaces ([#91592](https://github.com/kubernetes/kubernetes/pull/91592), [@jayunit100](https://github.com/jayunit100)) [SIG Network, Storage and Testing]
- Node ([#96552](https://github.com/kubernetes/kubernetes/pull/96552), [@pandaamanda](https://github.com/pandaamanda)) [SIG Apps, Cloud Provider, Node and Scheduling]
- Official support to build kubernetes with docker-machine / remote docker is removed. This change does not affect building kubernetes with docker locally. ([#97618](https://github.com/kubernetes/kubernetes/pull/97618), [@jherrera123](https://github.com/jherrera123)) [SIG Release and Testing]
- Resolves flakes in the Ingress conformance tests due to conflicts with controllers updating the Ingress object ([#98430](https://github.com/kubernetes/kubernetes/pull/98430), [@liggitt](https://github.com/liggitt)) [SIG Network and Testing]
- Scheduler plugin validation now provides all errors detected instead of the first one. ([#96745](https://github.com/kubernetes/kubernetes/pull/96745), [@lingsamuel](https://github.com/lingsamuel)) [SIG Node, Scheduling and Testing]
- Storage related e2e testsuite redesign & cleanup ([#96573](https://github.com/kubernetes/kubernetes/pull/96573), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Storage and Testing]
- The OIDC authenticator no longer waits 10 seconds before attempting to fetch the metadata required to verify tokens. ([#97693](https://github.com/kubernetes/kubernetes/pull/97693), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- The `AttachVolumeLimit` feature gate that is GA since v1.17 is now removed. ([#96539](https://github.com/kubernetes/kubernetes/pull/96539), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Storage]
- The `CSINodeInfo` feature gate that is GA since v1.17 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#96561](https://github.com/kubernetes/kubernetes/pull/96561), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Apps, Auth, Scheduling, Storage and Testing]
- The default delegating authorization options now allow unauthenticated access to healthz, readyz, and livez.  A system:masters user connecting to an authz delegator will not perform an authz check. ([#98325](https://github.com/kubernetes/kubernetes/pull/98325), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Auth, Cloud Provider and Scheduling]
- The deprecated feature gates `RotateKubeletClientCertificate`, `AttachVolumeLimit`, `VolumePVCDataSource` and `EvenPodsSpread` are now unconditionally enabled and can no longer be specified in component invocations. ([#97306](https://github.com/kubernetes/kubernetes/pull/97306), [@gavinfish](https://github.com/gavinfish)) [SIG Node, Scheduling and Storage]
- The kubectl alpha debug command was scheduled to be removed in v1.21. ([#98111](https://github.com/kubernetes/kubernetes/pull/98111), [@pandaamanda](https://github.com/pandaamanda)) [SIG CLI]
- Update cri-tools to [v1.20.0](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.20.0) ([#97967](https://github.com/kubernetes/kubernetes/pull/97967), [@rajibmitra](https://github.com/rajibmitra)) [SIG Cloud Provider]
- Windows nodes on GCE will take longer to start due to dependencies installed at node creation time. ([#98284](https://github.com/kubernetes/kubernetes/pull/98284), [@pjh](https://github.com/pjh)) [SIG Cloud Provider]

### Uncategorized

- Adding Brazilian Portuguese translation for kubectl ([#61595](https://github.com/kubernetes/kubernetes/pull/61595), [@cpanato](https://github.com/cpanato)) [SIG CLI]

## Dependencies

### Added
_Nothing has changed._

### Changed
- github.com/Azure/go-autorest/autorest: [v0.11.1 → v0.11.12](https://github.com/Azure/go-autorest/autorest/compare/v0.11.1...v0.11.12)
- github.com/coredns/corefile-migration: [v1.0.10 → v1.0.11](https://github.com/coredns/corefile-migration/compare/v1.0.10...v1.0.11)
- github.com/golang/mock: [v1.4.1 → v1.4.4](https://github.com/golang/mock/compare/v1.4.1...v1.4.4)
- github.com/google/cadvisor: [v0.38.5 → v0.38.7](https://github.com/google/cadvisor/compare/v0.38.5...v0.38.7)
- github.com/heketi/heketi: [c2e2a4a → v10.2.0+incompatible](https://github.com/heketi/heketi/compare/c2e2a4a...v10.2.0)
- github.com/miekg/dns: [v1.1.4 → v1.1.35](https://github.com/miekg/dns/compare/v1.1.4...v1.1.35)
- k8s.io/gengo: 83324d8 → b6c5ce2
- k8s.io/system-validators: v1.2.0 → v1.3.0

### Removed
- rsc.io/quote/v3: v3.1.0
- rsc.io/sampler: v1.3.0
