## Action Required

- kube-apiserver: the deprecated `--etcd-quorum-read` flag has been removed, and quorum reads are always enabled when fetching data from etcd. ([#69527](https://github.com/kubernetes/kubernetes/pull/69527), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery
- client-go release will no longer have bootstrap (k8s.io/client-go/tools/bootstrap) related code. any reference to it will break. Please redirect all references to k8s.io/bootstrap instead. ([#67356](https://github.com/kubernetes/kubernetes/pull/67356), [@yliaog](https://github.com/yliaog)) Courtesy of SIG API Machinery, SIG Architecture, SIG Cluster Lifecycle, and SIG Testing


## New Features

- kube-apiserver: `--audit-webhook-version` and `--audit-log-version` now default to `audit.k8s.io/v1` if unspecified ([#70476](https://github.com/kubernetes/kubernetes/pull/70476), [@charrywanganthony](https://github.com/charrywanganthony)) Courtesy of SIG API Machinery
- kubeadm: timeoutForControlPlane is introduced as part of the API Server config, that controls the timeout for the wait for control plane to be up. Default value is 4 minutes. ([#70480](https://github.com/kubernetes/kubernetes/pull/70480), [@rosti](https://github.com/rosti)) Courtesy of SIG Cluster Lifecycle
- Scheduler only activates unschedulable pods if node's scheduling related properties change. ([#70366](https://github.com/kubernetes/kubernetes/pull/70366), [@mlmhl](https://github.com/mlmhl)) Courtesy of SIG Scheduling
- --api-audiences now defaults to the --service-account-issuer if the issuer is provided but the API audience is not. ([#70308](https://github.com/kubernetes/kubernetes/pull/70308), [@mikedanese](https://github.com/mikedanese)) Courtesy of SIG API Machinery, and SIG Auth
- add support for projected volume in describe function  ([#70158](https://github.com/kubernetes/kubernetes/pull/70158), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG CLI
- kubeadm now automatically creates a new stacked etcd member when joining a new control plane node (does not applies to external etcd) ([#69486](https://github.com/kubernetes/kubernetes/pull/69486), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle
- Display the usage of ephemeral-storage when using `kubectl describe node` ([#70268](https://github.com/kubernetes/kubernetes/pull/70268), [@Pingan2017](https://github.com/Pingan2017)) Courtesy of SIG CLI
- Added functionality to enable br_netfilter and ip_forward for debian packages to improve kubeadm support for CRI runtime besides Docker.  ([#70152](https://github.com/kubernetes/kubernetes/pull/70152), [@ashwanikhemani](https://github.com/ashwanikhemani)) Courtesy of SIG Cluster Lifecycle
- Add regions ap-northeast-3 and eu-west-3 to the list of well known AWS regions. ([#70252](https://github.com/kubernetes/kubernetes/pull/70252), [@nckturner](https://github.com/nckturner)) Courtesy of SIG AWS, and SIG Cloud Provider
- Add scheduler benchmark tests for PodAffinity and NodeAffinity. ([#69898](https://github.com/kubernetes/kubernetes/pull/69898), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Scheduling, and SIG Testing
- kubeadm: Implemented preflight check to ensure that number of CPUs ([#70048](https://github.com/kubernetes/kubernetes/pull/70048), [@bart0sh](https://github.com/bart0sh)) Courtesy of SIG Cluster Lifecycle
- CoreDNS is now the default DNS server in kube-up deployments.  ([#69883](https://github.com/kubernetes/kubernetes/pull/69883), [@chrisohaver](https://github.com/chrisohaver)) Courtesy of SIG Cluster Lifecycle
- Opt out of chowning and chmoding from kubectl cp. ([#69573](https://github.com/kubernetes/kubernetes/pull/69573), [@bjhaid](https://github.com/bjhaid)) Courtesy of SIG CLI
- Failed to provision volume with StorageClass "azurefile-premium": failed to create share andy-mg1121-dynamic-pvc-1a7b2813-d1b7-11e8-9e96-000d3a03e16b in account f7228f99bcde411e8ba4900: failed to create file share, err: storage: service returned error: StatusCode=400, ErrorCode=InvalidHeaderValue, ErrorMessage=The value for one of the HTTP headers is not in the correct format. ([#69718](https://github.com/kubernetes/kubernetes/pull/69718), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG API Machinery, SIG Azure, SIG Cloud Provider, and SIG Storage
- `TaintBasedEvictions` feature is promoted to beta. ([#69824](https://github.com/kubernetes/kubernetes/pull/69824), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Scheduling
- Promote resource limits priority function to beta ([#69437](https://github.com/kubernetes/kubernetes/pull/69437), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) Courtesy of SIG Scheduling, and SIG Testing
- Fix https://github.com/kubernetes/client-go/issues/478 by adding support for JSON Patch in client-go/dynamic/fake ([#69330](https://github.com/kubernetes/kubernetes/pull/69330), [@vaikas-google](https://github.com/vaikas-google)) Courtesy of SIG API Machinery, SIG Architecture, SIG Cluster Lifecycle, and SIG Node
- Dry-run is promoted to Beta and will be enabled by default. ([#69644](https://github.com/kubernetes/kubernetes/pull/69644), [@apelisse](https://github.com/apelisse)) Courtesy of SIG API Machinery
- `kubectl get priorityclass` now prints value column by default. ([#69431](https://github.com/kubernetes/kubernetes/pull/69431), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG CLI, and SIG Scheduling
- Added a new container based image for running e2e tests ([#69368](https://github.com/kubernetes/kubernetes/pull/69368), [@dims](https://github.com/dims)) Courtesy of SIG Cluster Lifecycle, and SIG Testing
- The `LC_ALL` and `LC_MESSAGES` env vars can now be used to set desired locale for `kubectl` while keeping `LANG` unchanged. ([#69500](https://github.com/kubernetes/kubernetes/pull/69500), [@m1kola](https://github.com/m1kola)) Courtesy of SIG CLI
- NodeLifecycleController: Now node lease renewal is treated as the heartbeat signal from the node, in addition to NodeStatus Update. ([#69241](https://github.com/kubernetes/kubernetes/pull/69241), [@wangzhen127](https://github.com/wangzhen127)) Courtesy of SIG API Machinery, SIG Node, and SIG Testing
- adds dynamic shared informers to write generic, non-generated controllers ([#69308](https://github.com/kubernetes/kubernetes/pull/69308), [@p0lyn0mial](https://github.com/p0lyn0mial)) Courtesy of SIG API Machinery
- Upgrade to etcd 3.3 client ([#69322](https://github.com/kubernetes/kubernetes/pull/69322), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Testing
- It is now possible to use named ports in the `kubectl port-forward` command ([#69477](https://github.com/kubernetes/kubernetes/pull/69477), [@m1kola](https://github.com/m1kola)) Courtesy of SIG CLI
- Update to use go1.11.1 ([#69386](https://github.com/kubernetes/kubernetes/pull/69386), [@cblecker](https://github.com/cblecker)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG Autoscaling, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, SIG Release, SIG Scalability, SIG Scheduling, SIG Storage, and SIG Testing
- `kubectl wait` now supports condition value checks other than true using `--for condition=available=false` ([#69295](https://github.com/kubernetes/kubernetes/pull/69295), [@deads2k](https://github.com/deads2k)) Courtesy of SIG CLI
- Update defaultbackend image to 1.5. Users should concentrate on updating scripts to the new version. ([#69120](https://github.com/kubernetes/kubernetes/pull/69120), [@aledbf](https://github.com/aledbf)) Courtesy of SIG Cluster Lifecycle
- Bump Dashboard version to v1.10.0 ([#68450](https://github.com/kubernetes/kubernetes/pull/68450), [@jeefy](https://github.com/jeefy)) Courtesy of SIG Cluster Lifecycle
- [GCP] Added env variables to control CPU requests of kube-controller-manager and kube-scheduler. ([#68823](https://github.com/kubernetes/kubernetes/pull/68823), [@loburm](https://github.com/loburm)) Courtesy of SIG Cluster Lifecycle
- PodSecurityPolicy objects now support a `MayRunAs` rule for `fsGroup` and `supplementalGroups` options. This allows specifying ranges of allowed GIDs for pods/containers without forcing a default GID the way `MustRunAs` does. This means that a container to which such a policy applies to won't use any fsGroup/supplementalGroup GID if not explicitly specified, yet a specified GID must still fall in the GID range according to the policy. ([#65135](https://github.com/kubernetes/kubernetes/pull/65135), [@stlaz](https://github.com/stlaz)) Courtesy of SIG Apps, SIG Architecture, SIG Auth, and SIG Network


## API Changes

- kubeadm: The writable config file option for extra volumes is renamed to readOnly with a reversed meaning. With readOnly defaulted to false (as in pod specs). ([#70495](https://github.com/kubernetes/kubernetes/pull/70495), [@rosti](https://github.com/rosti))
- kubeadm: Multiple API server endpoints support upon join is removed as it is now redundant. ([#69812](https://github.com/kubernetes/kubernetes/pull/69812), [@rosti](https://github.com/rosti))
- Critical pod annotation is deprecated. Pod priority should be used instead to mark pods as critical. ([#70298](https://github.com/kubernetes/kubernetes/pull/70298), [@bsalamat](https://github.com/bsalamat))
- kubeadm: JoinConfiguration now houses the discovery options in a nested Discovery structure, which in turn has a couple of other nested structures to house more specific options (BootstrapTokenDiscovery and FileDiscovery) ([#67763](https://github.com/kubernetes/kubernetes/pull/67763), [@rosti](https://github.com/rosti))
- kubeadm: Add a `v1beta1` API. ([#69289](https://github.com/kubernetes/kubernetes/pull/69289), [@fabriziopandini](https://github.com/fabriziopandini))


## Notes From Multiple SIGs

### SIG Azure, and SIG Cloud Provider

- Ensure orphan public IPs on Azure deleted when service recreated with the same name. ([#70463](https://github.com/kubernetes/kubernetes/pull/70463), [@feiskyer](https://github.com/feiskyer))
- Improve Azure instance metadata handling by adding caches. ([#70353](https://github.com/kubernetes/kubernetes/pull/70353), [@feiskyer](https://github.com/feiskyer))
- Corrects check for non-Azure managed nodes with the Azure cloud provider ([#70135](https://github.com/kubernetes/kubernetes/pull/70135), [@marc-sensenich](https://github.com/marc-sensenich))

### SIG Apps, SIG Storage, and SIG Testing

- Fix tests to use fsync instead of sync ([#69755](https://github.com/kubernetes/kubernetes/pull/69755), [@mrunalp](https://github.com/mrunalp))

### SIG API Machinery, SIG CLI, and SIG Scheduling

- Refactor factory_test.go to use a fake k8s client. ([#69412](https://github.com/kubernetes/kubernetes/pull/69412), [@tossmilestone](https://github.com/tossmilestone))

### SIG Cluster Lifecycle, and SIG GCP

- Add tolerations for Stackdriver Logging and Metadata Agents. ([#69737](https://github.com/kubernetes/kubernetes/pull/69737), [@qingling128](https://github.com/qingling128))
- Enable insertId generation, and update Stackdriver Logging Agent image to 0.5-1.5.36-1-k8s. This help reduce log duplication and guarantee log order. ([#68920](https://github.com/kubernetes/kubernetes/pull/68920), [@qingling128](https://github.com/qingling128))

### SIG Cluster Lifecycle, and SIG Node

- The runtimeHandler field on the RuntimeClass resource now accepts the empty string. ([#69550](https://github.com/kubernetes/kubernetes/pull/69550), [@tallclair](https://github.com/tallclair))

### SIG Apps, SIG Node, and SIG Storage

- The `MountPropagation` feature is unconditionally enabled in v1.13, and can no longer be disabled. ([#68230](https://github.com/kubernetes/kubernetes/pull/68230), [@bertinatto](https://github.com/bertinatto))

### SIG API Machinery, SIG Auth, and SIG Testing

- The --service-account-api-audiences on kube-apiserver is deprecated in favor of --api-audiences. ([#70105](https://github.com/kubernetes/kubernetes/pull/70105), [@mikedanese](https://github.com/mikedanese))

### SIG Apps, SIG Architecture, and SIG Node

- kube-apiserver: fixes `procMount` field incorrectly being marked as required in openapi schema ([#69694](https://github.com/kubernetes/kubernetes/pull/69694), [@jessfraz](https://github.com/jessfraz))

### SIG API Machinery, and SIG Cloud Provider

- kube-controller-manager and cloud-controller-manager now hold generated serving certificates in-memory unless a writeable location is specified with --cert-dir ([#69884](https://github.com/kubernetes/kubernetes/pull/69884), [@liggitt](https://github.com/liggitt))

### SIG Cloud Provider, SIG Network, and SIG Testing

- GCE/GKE load balancer health check default interval changes from 2 seconds to 8 seconds, unhealthyThreshold to 3. ([#70099](https://github.com/kubernetes/kubernetes/pull/70099), [@grayluck](https://github.com/grayluck))

### SIG Cluster Lifecycle, SIG Release, and SIG Testing

- Updates to use debian-iptables v11.0, debian-hyperkube-base 0.12.0, and kube-addon-manager:v8.9. ([#70209](https://github.com/kubernetes/kubernetes/pull/70209), [@ixdy](https://github.com/ixdy))
- Images based on debian-base no longer include the libsystemd0 package. This should have no user-facing impact. ([#69995](https://github.com/kubernetes/kubernetes/pull/69995), [@ixdy](https://github.com/ixdy))

### SIG API Machinery, and SIG Auth

- When `--rotate-server-certificates` is enabled, kubelet will no longer request a new certificate on startup if the current certificate on disk is satisfactory. ([#69991](https://github.com/kubernetes/kubernetes/pull/69991), [@agunnerson-ibm](https://github.com/agunnerson-ibm))
- List operations against the API now return internal server errors instead of partially complete lists when a value cannot be transformed from storage. The updated behavior is consistent with all other operations that require transforming data from storage such as watch and get. ([#69399](https://github.com/kubernetes/kubernetes/pull/69399), [@mikedanese](https://github.com/mikedanese))

### SIG Cluster Lifecycle, and SIG Storage

- The default storage class annotation for the storage addons has been changed to use the GA variant ([#68345](https://github.com/kubernetes/kubernetes/pull/68345), [@smelchior](https://github.com/smelchior))

### SIG CLI, and SIG Testing

- The "kubectl cp" command now supports path shortcuts (../) in remote paths. ([#65189](https://github.com/kubernetes/kubernetes/pull/65189), [@juanvallejo](https://github.com/juanvallejo))

### SIG Cloud Provider, and SIG OpenStack

- Fix cloud-controller-manager crash when using OpenStack provider and PersistentVolume initializing controller   ([#70459](https://github.com/kubernetes/kubernetes/pull/70459), [@mvladev](https://github.com/mvladev))

### SIG Apps, SIG Architecture, SIG Auth, SIG Network, and SIG Testing

- Add ability to control primary GID of containers through Pod Spec and PodSecurityPolicy ([#67802](https://github.com/kubernetes/kubernetes/pull/67802), [@krmayankk](https://github.com/krmayankk))

### SIG Node, and SIG Testing

- Remove unused chaosclient. ([#68409](https://github.com/kubernetes/kubernetes/pull/68409), [@wgliang](https://github.com/wgliang))

### SIG API Machinery, and SIG CLI

- The kubectl wait command must handle when a watch returns an error vs closing by printing out the error and retrying the watch. ([#69389](https://github.com/kubernetes/kubernetes/pull/69389), [@smarterclayton](https://github.com/smarterclayton))

### SIG Node, and SIG Storage

- Handle Windows named pipes in host mounts. ([#69484](https://github.com/kubernetes/kubernetes/pull/69484), [@ddebroy](https://github.com/ddebroy))

### SIG Apps, SIG CLI, and SIG Testing

- `kubectl rollout undo` now returns errors when attempting to rollback a deployment to a non-existent revision ([#70039](https://github.com/kubernetes/kubernetes/pull/70039), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG Apps, SIG Architecture, SIG Auth, SIG Autoscaling, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, SIG Scheduling, SIG Storage, and SIG Testing

- Add dynamic audit configuration api ([#67547](https://github.com/kubernetes/kubernetes/pull/67547), [@pbarker](https://github.com/pbarker))

### SIG API Machinery, SIG Cloud Provider, and SIG Testing

- CCM server will not listen insecurely if secure port is specified ([#68982](https://github.com/kubernetes/kubernetes/pull/68982), [@aruneli](https://github.com/aruneli))

### SIG Contributor Experience, SIG Network, and SIG Windows

- fix inconsistency in windows kernel proxy when updating HNS policy. ([#68923](https://github.com/kubernetes/kubernetes/pull/68923), [@delulu](https://github.com/delulu))

### SIG API Machinery, and SIG Storage

- Fixed CSIDriver API object to allow missing fields. ([#69331](https://github.com/kubernetes/kubernetes/pull/69331), [@jsafrane](https://github.com/jsafrane))

### SIG Node, and SIG Windows

- kubelet --system-reserved and --kube-reserved are supported now on Windows nodes ([#69960](https://github.com/kubernetes/kubernetes/pull/69960), [@feiskyer](https://github.com/feiskyer))
- Windows runtime endpoints is now switched to 'npipe:////./pipe/dockershim' from 'tcp://localhost:3735'. ([#69516](https://github.com/kubernetes/kubernetes/pull/69516), [@feiskyer](https://github.com/feiskyer))

### SIG API Machinery, SIG Scheduling, and SIG Testing

- Replace Parallelize with function ParallelizeUntil and formally deprecate the Parallelize. ([#68403](https://github.com/kubernetes/kubernetes/pull/68403), [@wgliang](https://github.com/wgliang))

### SIG Cluster Lifecycle, and SIG Testing

- fix 'kubeadm upgrade' infinite loop waiting for pod restart ([#69886](https://github.com/kubernetes/kubernetes/pull/69886), [@bart0sh](https://github.com/bart0sh))
- test/e2e/e2e.test: ([#69105](https://github.com/kubernetes/kubernetes/pull/69105), [@pohly](https://github.com/pohly))
- Bump addon-manager to v8.8 ([#69337](https://github.com/kubernetes/kubernetes/pull/69337), [@MrHohn](https://github.com/MrHohn))

### SIG Cluster Lifecycle, SIG GCP, and SIG Node

- Remove the deprecated --google-json-key flag from kubelet. ([#69354](https://github.com/kubernetes/kubernetes/pull/69354), [@yujuhong](https://github.com/yujuhong))
- Update crictl to v1.12.0 ([#69033](https://github.com/kubernetes/kubernetes/pull/69033), [@feiskyer](https://github.com/feiskyer))

### SIG Cloud Provider, and SIG Storage

- Updating OWNERS list for vSphere Cloud Provider. ([#69187](https://github.com/kubernetes/kubernetes/pull/69187), [@SandeepPissay](https://github.com/SandeepPissay))

### SIG CLI, SIG Cluster Lifecycle, SIG Node, and SIG Scheduling

- Move scheduler cache interface and implementation to pkg/scheduler/internal/cache. ([#68968](https://github.com/kubernetes/kubernetes/pull/68968), [@wgliang](https://github.com/wgliang))

### SIG API Machinery, and SIG Architecture

- The caBundle and service fields in admission webhook API objects now correctly indicate they are optional ([#70138](https://github.com/kubernetes/kubernetes/pull/70138), [@liggitt](https://github.com/liggitt))

### SIG Network, and SIG Windows

- Fix service issues with named targetPort for Windows ([#70076](https://github.com/kubernetes/kubernetes/pull/70076), [@feiskyer](https://github.com/feiskyer))

### SIG Azure, and SIG Storage

- fix GetVolumeLimits log flushing issue ([#69558](https://github.com/kubernetes/kubernetes/pull/69558), [@andyzhangx](https://github.com/andyzhangx))

### SIG Apps, SIG Scheduling, and SIG Testing

- Scheduling conformance tests related to daemonsets should set the annotation that relaxes node selection restrictions, if any are set. This ensures conformance tests can run on a wider array of clusters. ([#68793](https://github.com/kubernetes/kubernetes/pull/68793), [@aveshagarwal](https://github.com/aveshagarwal))

### SIG API Machinery, SIG Cloud Provider, SIG Node, SIG Storage, and SIG Testing

- Any external provider should be aware the cloud-provider interface should be imported from :- ([#68310](https://github.com/kubernetes/kubernetes/pull/68310), [@cheftako](https://github.com/cheftako))

### SIG AWS, and SIG Cloud Provider

- service.beta.kubernetes.io/aws-load-balancer-internal now supports true and false values, previously it only supported non-empty strings ([#69436](https://github.com/kubernetes/kubernetes/pull/69436), [@mcrute](https://github.com/mcrute))
- Adds `service.beta.kubernetes.io/aws-load-balancer-security-groups` annotation to set the security groups to the AWS ELB to be the only ones specified in the annotation in case this is present (does not add `0.0.0.0/0`).  ([#62774](https://github.com/kubernetes/kubernetes/pull/62774), [@Raffo](https://github.com/Raffo))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Testing

- kube-apiserver has removed support for the `etcd2` storage backend (deprecated since v1.9). Existing clusters must migrate etcd v2 data to etcd v3 storage before upgrading to v1.13. ([#69310](https://github.com/kubernetes/kubernetes/pull/69310), [@liggitt](https://github.com/liggitt))

### SIG Storage, and SIG Testing

- Flex volume plugins now support expandvolume (to increase underlying volume capacity) and expanfs (resize filesystem) commands that Flex plugin authors can implement to support expanding in use Flex PersistentVolumes ([#67851](https://github.com/kubernetes/kubernetes/pull/67851), [@aniket-s-kulkarni](https://github.com/aniket-s-kulkarni))
- The builtin system:csi-external-provisioner and system:csi-external-attacher cluster roles ([#69868](https://github.com/kubernetes/kubernetes/pull/69868), [@pohly](https://github.com/pohly))
- Enable AttachVolumeLimit feature ([#69225](https://github.com/kubernetes/kubernetes/pull/69225), [@gnufied](https://github.com/gnufied))


## Notes from Individual SIGs

### SIG API Machinery

- The OwnerReferencesPermissionEnforcement admission plugin now checks authorization for the correct scope (namespaced or cluster-scoped) of the owner resource type. Previously, it always checked permissions at the same scope as the child resource. ([#70389](https://github.com/kubernetes/kubernetes/pull/70389), [@caesarxuchao](https://github.com/caesarxuchao))
- OpenAPI spec marks delete request's body parameter as optional ([#70032](https://github.com/kubernetes/kubernetes/pull/70032), [@iamneha](https://github.com/iamneha))
- We changed when the `metadata.generation` of a custom resource (CR) increments. ([#69059](https://github.com/kubernetes/kubernetes/pull/69059), [@caesarxuchao](https://github.com/caesarxuchao))
- Remove kube-controller-manager flag '--insecure-experimental-approve-all-kubelet-csrs-for-group'(deprecated in v1.7) ([#69209](https://github.com/kubernetes/kubernetes/pull/69209), [@Pingan2017](https://github.com/Pingan2017))
- Fixed patch/update operations on multi-version custom resources ([#70087](https://github.com/kubernetes/kubernetes/pull/70087), [@liggitt](https://github.com/liggitt))
- Reduce memory utilization of admission webhook metrics by removing resource related labels. ([#69895](https://github.com/kubernetes/kubernetes/pull/69895), [@jpbetz](https://github.com/jpbetz))
- kube-apiserver: the `--deserialization-cache-size` flag is no longer used, is deprecated, and will be removed in a future release ([#69842](https://github.com/kubernetes/kubernetes/pull/69842), [@liggitt](https://github.com/liggitt))
- Kubelet can now parse PEM file containing both TLS certificate and key in arbitrary order. Previously key was always required to be first. ([#69536](https://github.com/kubernetes/kubernetes/pull/69536), [@awly](https://github.com/awly))
- Code-gen: Remove lowercasing for project imports ([#68484](https://github.com/kubernetes/kubernetes/pull/68484), [@jsturtevant](https://github.com/jsturtevant))
- Fix client cert setup in delegating authentication logic ([#69430](https://github.com/kubernetes/kubernetes/pull/69430), [@DirectXMan12](https://github.com/DirectXMan12))
- OpenAPI spec and API reference now reflect dryRun query parameter for POST/PUT/PATCH operations ([#69359](https://github.com/kubernetes/kubernetes/pull/69359), [@roycaihw](https://github.com/roycaihw))
- Fixes the sample-apiserver so that its BanFlunder admission plugin can be used. ([#68417](https://github.com/kubernetes/kubernetes/pull/68417), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- apiservice availability related to networking glitches are corrected faster ([#68678](https://github.com/kubernetes/kubernetes/pull/68678), [@deads2k](https://github.com/deads2k))

### SIG Apps

- `kubectl apply` can now change a deployment strategy from rollout to recreate without explicitly clearing the rollout-related fields ([#70436](https://github.com/kubernetes/kubernetes/pull/70436), [@liggitt](https://github.com/liggitt))

### SIG CLI

- The `kubectl plugin list` command will now display discovered plugin paths in the same order as they are found in a user's PATH variable. ([#70443](https://github.com/kubernetes/kubernetes/pull/70443), [@juanvallejo](https://github.com/juanvallejo))
- "kubectl get" no longer exits before printing all of its results if an error is found ([#70311](https://github.com/kubernetes/kubernetes/pull/70311), [@juanvallejo](https://github.com/juanvallejo))

### SIG Cloud Provider

- add deprecation warning for all cloud providers ([#69171](https://github.com/kubernetes/kubernetes/pull/69171), [@andrewsykim](https://github.com/andrewsykim))

### SIG Cluster Lifecycle

- kubeadm: validate kubeconfig files in case of external CA mode. ([#70537](https://github.com/kubernetes/kubernetes/pull/70537), [@yagonobre](https://github.com/yagonobre))
- kubeadm: The writable config file option for extra volumes is renamed to readOnly with a reversed meaning. With readOnly defaulted to false (as in pod specs). ([#70495](https://github.com/kubernetes/kubernetes/pull/70495), [@rosti](https://github.com/rosti))
- kubeadm: Control plane component configs are separated into ClusterConfiguration sub-structs. ([#70371](https://github.com/kubernetes/kubernetes/pull/70371), [@rosti](https://github.com/rosti))
- kubeadm: Multiple API server endpoints support upon join is removed as it is now redundant. ([#69812](https://github.com/kubernetes/kubernetes/pull/69812), [@rosti](https://github.com/rosti))
- Kubeadm reset now clean up custom etcd data path ([#70003](https://github.com/kubernetes/kubernetes/pull/70003), [@yagonobre](https://github.com/yagonobre))
- kubeadm: fix unnecessary upgrades caused by undefined order of Volumes and VolumeMounts in manifests ([#70027](https://github.com/kubernetes/kubernetes/pull/70027), [@bart0sh](https://github.com/bart0sh))
- kubeadm: Introduce config print init/join-defaults that deprecate config print-defaults by decoupling init and join configs. ([#69617](https://github.com/kubernetes/kubernetes/pull/69617), [@rosti](https://github.com/rosti))
- kubeadm: Fix node join taints. ([#69846](https://github.com/kubernetes/kubernetes/pull/69846), [@andrewrynhard](https://github.com/andrewrynhard))
- Fix cluster autoscaler addon permissions so it can access batch/job. ([#69858](https://github.com/kubernetes/kubernetes/pull/69858), [@losipiuk](https://github.com/losipiuk))
- kubeadm: JoinConfiguration now houses the discovery options in a nested Discovery structure, which in turn has a couple of other nested structures to house more specific options (BootstrapTokenDiscovery and FileDiscovery) ([#67763](https://github.com/kubernetes/kubernetes/pull/67763), [@rosti](https://github.com/rosti))
- [GCE] Enable by default audit logging truncating backend. ([#68288](https://github.com/kubernetes/kubernetes/pull/68288), [@loburm](https://github.com/loburm))
- kubeadm: fix a possible scenario where kubeadm can pull much newer control-plane images ([#69301](https://github.com/kubernetes/kubernetes/pull/69301), [@neolit123](https://github.com/neolit123))
- kubeadm now allows mixing of init/cluster and join configuration in a single YAML file (although a warning gets printed in this case).  ([#69426](https://github.com/kubernetes/kubernetes/pull/69426), [@rosti](https://github.com/rosti))
- kubeadm: Add a `v1beta1` API. ([#69289](https://github.com/kubernetes/kubernetes/pull/69289), [@fabriziopandini](https://github.com/fabriziopandini))
- Bump cluster-proportional-autoscaler to 1.3.0 ([#69338](https://github.com/kubernetes/kubernetes/pull/69338), [@MrHohn](https://github.com/MrHohn))
- Update defaultbackend to v1.5 ([#69334](https://github.com/kubernetes/kubernetes/pull/69334), [@bowei](https://github.com/bowei))

### SIG Network

- Corrected family type (inet6) for ipsets in ipv6-only clusters ([#68436](https://github.com/kubernetes/kubernetes/pull/68436), [@uablrek](https://github.com/uablrek))
- kube-proxy argument `hostname-override` can be used to override hostname defined in the configuration file ([#69340](https://github.com/kubernetes/kubernetes/pull/69340), [@stevesloka](https://github.com/stevesloka))

### SIG Node

- Optimizes calculating stats when only CPU and Memory stats are returned from Kubelet stats/summary http endpoint.  ([#68841](https://github.com/kubernetes/kubernetes/pull/68841), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))

### SIG Release

- Use debian-base instead of busybox as base image for server images ([#70245](https://github.com/kubernetes/kubernetes/pull/70245), [@ixdy](https://github.com/ixdy))
- Images for cloud-controller-manager, kube-apiserver, kube-controller-manager, and kube-scheduler now contain a minimal /etc/nsswitch.conf and should respect /etc/hosts for lookups ([#69238](https://github.com/kubernetes/kubernetes/pull/69238), [@BenTheElder](https://github.com/BenTheElder))

### SIG Scheduling

- Refactor scheduler_test.go to use a fake k8s client. ([#70290](https://github.com/kubernetes/kubernetes/pull/70290), [@tossmilestone](https://github.com/tossmilestone))
- Critical pod annotation is deprecated. Pod priority should be used instead to mark pods as critical. ([#70298](https://github.com/kubernetes/kubernetes/pull/70298), [@bsalamat](https://github.com/bsalamat))
- Add metrics for volume scheduling operations ([#59529](https://github.com/kubernetes/kubernetes/pull/59529), [@wackxu](https://github.com/wackxu))
- improves memory use and performance when processing large numbers of pods containing tolerations ([#65350](https://github.com/kubernetes/kubernetes/pull/65350), [@liggitt](https://github.com/liggitt))
- Fix a bug in the scheduler that could cause the scheduler to go to an infinite loop when all nodes in a zone are removed. ([#69758](https://github.com/kubernetes/kubernetes/pull/69758), [@bsalamat](https://github.com/bsalamat))
- Move NodeInfo utils into pkg/scheduler/cache. ([#69495](https://github.com/kubernetes/kubernetes/pull/69495), [@wgliang](https://github.com/wgliang))
- Move CacheComparer to pkg/scheduler/internal/cache/comparer. ([#69317](https://github.com/kubernetes/kubernetes/pull/69317), [@wgliang](https://github.com/wgliang))
- Move FakeCache to pkg/scheduler/internal/cache/fake. ([#69318](https://github.com/kubernetes/kubernetes/pull/69318), [@wgliang](https://github.com/wgliang))

### SIG Storage

- Fix CSI volume limits not showing up in node's capacity and allocatable ([#70540](https://github.com/kubernetes/kubernetes/pull/70540), [@gnufied](https://github.com/gnufied))
- CSI drivers now have access to mountOptions defined on the storage class when attaching volumes. ([#67898](https://github.com/kubernetes/kubernetes/pull/67898), [@bswartz](https://github.com/bswartz))
- change default azure file mount permission to 0777 ([#69854](https://github.com/kubernetes/kubernetes/pull/69854), [@andyzhangx](https://github.com/andyzhangx))
- Fixed subpath in containerized kubelet. ([#69565](https://github.com/kubernetes/kubernetes/pull/69565), [@jsafrane](https://github.com/jsafrane))
- Fixed panic on iSCSI volume tear down. ([#69140](https://github.com/kubernetes/kubernetes/pull/69140), [@jsafrane](https://github.com/jsafrane))

### SIG Testing

- Support for passing unknown provider names to the E2E test binaries is going to be deprecated. Use `--provider=skeleton` (no ssh access) or `--provider=local` (local cluster with ssh) instead. ([#70141](https://github.com/kubernetes/kubernetes/pull/70141), [@pohly](https://github.com/pohly))
- Wait for pod failed event in subpath test. ([#69300](https://github.com/kubernetes/kubernetes/pull/69300), [@mrunalp](https://github.com/mrunalp))
- Bump up pod short start timeout to 2 minutes. ([#69291](https://github.com/kubernetes/kubernetes/pull/69291), [@mrunalp](https://github.com/mrunalp))
- Use the mounted "/var/run/secrets/kubernetes.io/serviceaccount/token" as the token file for running in-cluster based e2e testing. ([#69273](https://github.com/kubernetes/kubernetes/pull/69273), [@dims](https://github.com/dims))



## Other Notable Changes

- Speedup process lookup in /proc ([#66367](https://github.com/kubernetes/kubernetes/pull/66367), [@cpuguy83](https://github.com/cpuguy83))


