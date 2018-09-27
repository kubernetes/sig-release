> - Start SHA: 91e7b4fd31fcd3d5f436da26c980becec37ceefe
> - End Sha: 337e0e18f1aefa199bd0a1786f8eab42e948064c

## Known Issues

- Feature [#566](https://github.com/kubernetes/kubernetes/issues/566) enabling CoreDNS as the default for kube-up deployments was dropped from the release due to a scalability memory resource consumption issue observed. If a cluster operator is considering using CoreDNS on a cluster greater than 2000 nodes, it may be necessary to give more consideration to CoreDNS pod memory resource limits and experimentally measure that memory usage versus cluster resource availability.
- kube-controller-manager currently needs a writable `--cert-dir` (default is `/var/run/kubernetes`) for generating self-signed certificates, when no `--tls-cert-file` or `--tls-private-key-file` are provided.
- The `system:kube-controller-manager` ClusterRole lacks permission to `get` the `configmap` extension-apiserver-authentication. kube-controller-manager errors if run with a service account bound to the clusterrole.
- Runtime handler and Windows npipe protocol are not supported yet in crictl v1.11.x. Those features will be supported in crictl [v1.12.0](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.12.0), together with Kubernetes v1.12.1.

## Major Themes

### SIG API Machinery

SIG API work this cycle involved development of the "dry run" functionality, which enables users to see the results of a particular command without persisting those changes.

### SIG-autoscaling

SIG Autoscaling focused on improving the Horizontal Pod Autoscaling API and algorithm:
- We released autoscaling/v2beta2, which cleans up and unifies the API
- We improved readiness detection and smoothing to work well in a larger variety or use cases

### SIG-Azure

Sig Azure was focused on two primary new alpha features:
# Adding Azure Availability Zones support to cloud provider.
# Supporting Cross RG resources (disks, Azure File and node [Experimental]

Besides the above new features, support for Azure Virtual Machine Scale Sets (VMSS) and Cluster-Autoscaler is now stable and considered GA:

- Azure virtual machine scale sets (VMSS) allow you to create and manage identical load balanced
VMs that automatically increase or decrease based on demand or a set schedule.
- With this new stable feature, Kubernetes supports the scaling of containerized applications
with Azure VMSS, including the ability to integrate it with cluster-autoscaler to automatically
adjust the size of the Kubernetes clusters based on the same conditions. 

### SIG-cli

SIG CLI focused on implementing the new plugin mechanism, providing a library with common CLI tooling for plugin authors and further refactorings of the code.

### SIG-cloud-provider

This is the first Kubernetes release for this SIG! In v1.12, SIG Cloud Provider focused on building the processes and infrastructure to better support existing and new cloud providers. Some of these initiatives (many of which are still in progress) are:

- Reporting E2E conformance test results to TestGrid from every cloud provider (in collaboration with SIG Testing & SIG Release)
- Defining minimum required documentation from each cloud provider which includes (in collaboration with SIG Docs): 
  - example manifests for the kube-apiserver, kube-controller-manager, kube-schedule, kubelet, and the cloud-controller-manager
  - labels/annotations that are consumed by any cloud specific controllers

In addition to the above, SIG Cloud Provider has been focusing on a long running effort to remove cloud provider code from kubernetes/kubernetes. 

### SIG-cluster-lifecycle

In 1.12, SIG Cluster lifecycle has focused on improving the user experience in kubeadm, by fixing a number of bugs and adding some new important features.

Here is a list of some of the changes that have been made to kubeadm:

- Kubeadm internal config has been promoted to `v1alpha3`:
  - `v1alpha1` has been removed.
  - `v1alpha3` has split apart `MasterConfiguration` into separate components; `InitConfiguration`, `ClusterConfiguration`, `JoinConfiguration`, `KubeletConfiguration`, and `KubeProxyConfiguration`
  - Different configuration types can be supplied all in the same file separated by `---`.
- Improved CRI handling
  - crictl is no longer required in docker-only setups.
  - Better detection of installed CRI.
  - Better output for image pull errors.
- Improved air-gapped and offline support
  - kubeadm now handles air-gapped environments by using the local client version as a fallback.
  - Some kubeadm commands are now allowed to work in a completely offline mode.
- Certificate handling improvements:
  - Renew certs as part of upgrade.
  - New `kubeadm alpha phase certs renew` command for renewing certificates.
  - Certificates created with kubeadm now have improved uniqueness of Distinguished Name fields.
- HA improvements:
  - `kubeadm join --experimental-control-plane` can now be used to join control plane instances to an existing cluster.
  - `kubeadm upgrade node experimental-control-plane` can now be used for upgrading secondary control plane instances created with `kubeadm join --experimental-control-plane`.
Multi-arch support (EXPERIMENTAL):
  - kubeadm now adds support for docker “schema 2” manifest lists. This is preliminary part of the process of making kubeadm based k8s deployments to support multiple architectures.
Deprecating features:
  - The Alpha feature-gates HighAvailability, SelfHosting, CertsInSecrets are now deprecated, and will be removed in k8s v1.13.0.

### SIG-ibmcloud

As a newly created SIG, the SIG-ibmcloud has mainly focused on SIG set up, sharing IBM Clouds ongoing Kubernetes work like scalability tests, Kubernetes upgrade strategy etc. with the SIG members and start working on processes to move cloud provider code to a public GitHub repo.

### SIG-instrumentation

No feature work, but a large refactoring of metrics-server as well as a number of bug fixes.

### SIG-node

SIG-node graduated the PodShareProcessNamespace feature from alpha to beta.  This feature allows a pod spec to request that all containers in a pod share a common process namespaces.  

Two alpha features were also added in this release.  

The RuntimeClass alpha feature enables a node to surface multiple runtime options to support a variety of workload types.  Examples include native linux containers, and “sandboxed” containers that isolate the container from the host kernel.  

The CustomCFSQuotaPeriod alpha feature enables node administrators to change the default period used to enforce CFS quota on a node.  This can improve performance for some workloads that experience latency while using CFS quota with the default measurement period.  Finally, the SIG continues to focus on improving reliability by fixing bugs while working out design and implementation of future features.

### SIG-OpenStack

SIG-OpenStack development was primarily focused on fixing bugs and improving feature parity with OpenStack resources. New features were primarily limited to the external provider in an effort to drive adoption of the OpenStack external provider over the in-tree provider.

In-tree bug fixes and improvements included:
- Fix load balancer status without VIP.
- Fix filtering of server status.
- Fix resizing PVC of Cinder volume.
- Disable load balancer configuration if it is not defined in cloud config.
- Add support for node shutdown taint.

The external provider includes all of the above with the additional fixes and features:
- Fix bug to prevent allocation of existing floating IP.
- Fix Cinder authentication bug when OS_DOMAIN_NAME not specified.
- Fix Keystone authentication errors by skipping synchronization for unscoped tokens.
- Fix authentication error for client-auth-plugin
- Fix dependency references from in-tree-provider to point to external provider.
- Add shutdown instance by Provider ID.
- Add annotation to preserve floating IP after service delete.
- Add conformance testing to stable and development branches.
- Add support support to Manilla for trustee authentication and supplying custom CAs.
- Add and update documentation.
- Add support to Manilla for provisioning existing shares.
- Add cluster name to load balancer description
- Add synchronization between Kubernetes and Keystone projects
- Add use internal DNS name for 'hostname' of nodes.
- Add support for CSI spec v0.3.0 for both Cinder and Manilla
- Add 'cascade delete' support for Octavia load balancers to improve performance.
- Add improved load balancer naming.

### SIG-scheduling

SIG Scheduling development efforts have been primarily focused on improving performance and reliability of the scheduler.
- Performance of the inter-pod affinity/anti-affinity feature is improved over 100X via algorithmic optimization.
- DaemonSet pods, which used to be scheduled by the DaemonSet controller, will be scheduled by the default scheduler in 1.12. This change allows DaemonSet pods to enjoy all the scheduling features of the default scheduler.
- The Image Locality priority function of the scheduler has been improved and is now enabled by default. With this feature enabled, nodes that have all or a partial set of images required for running a pod are preferred over other nodes, which improves pod start-up time.
- TaintNodeByCondition has been moved to Beta and is enabled by default.
- Scheduler throughput has been improved by ~50% in large clusters (>2000 nodes).

### SIG-service-catalog
- The Originating Identity feature, which lets the broker know which user that performed an action, is now GA.
- [Namespaced Brokers](https://svc-cat.io/docs/namespaced-broker-resources/), which enable operators to install a broker into a namespace instead of the cluster level, reached GA.
- The [Service Plan Defaults](https://svc-cat.io/docs/service-plan-defaults/) feature is in alpha and is under active development. This feature gives operators the ability to define defaults for when someone provisions a service.
- We now support [filtering which services are exposed by Service Catalog](https://svc-cat.io/docs/catalog-restrictions/).
- We have also Improved the CLI experience both for kubectl and svcat by improving the output formatting, and by adding more commands.

### SIG-storage

SIG Storage promoted the [Kubernetes volume topology feature](https://github.com/kubernetes/features/issues/490) to beta. This enables Kubernetes to understand and act intelligently on volume accessibility information (such as the “zone” a cloud volume is provisioned in, the “rack” that a SAN array is accessible from, and so on).

The [dynamic maximum volume count](https://github.com/kubernetes/features/issues/554) feature was also moved to beta. This enables a volume plugin to specify the maximum number of a given volume type per node as a function of the node characteristics (for example, a larger limit for larger nodes, a smaller limit for smaller nodes).

SIG Storage also worked on a number of [Container Storage Interface (CSI) features](https://github.com/kubernetes/features/issues/178) this quarter in anticipation of moving support for CSI from beta to GA in the next Kubernetes release. This includes graduating the dependent “mount namespace propagation” feature to GA, moving the Kubelet plugin registration mechanism to beta, adding alpha support for a new CSI driver registry as well as for topology, and adding a number of alpha features to support the use of CSI for “local ephemeral volumes” (that is, volumes that exist for the lifecycle of a pod and contain some injected information, like a token or secret).

With Kubernetes v1.12, SIG Storage also introduced alpha support for [volume snapshotting](https://github.com/kubernetes/features/issues/177). This feature introduces the ability to create/delete volume snapshots and create new volumes from a snapshot using the Kubernetes API.

### SIG-vmware

SIG-VMware development was primarily focused on fixing bugs for the in-tree cloud provider, starting the development of the external cloud provider and taking ownership of the cluster-api provider for vSphere.

In-tree cloud provider bug fixes and improvements included:
- Adding initial Zones support to the provider using vSphere Tags
- Improving the testing harness for the cloud provider by introducing vcsim for automated testing
- Fixing a bug that was preventing updates from 1.10 to 1.11

The external cloud provider was established and reached feature parity with in-tree, and we expect to stabilize it and have it as preferred deployment model by 1.13. We are also getting started on externalizing the vSphere volume functionalities in a CSI plugin to fully reproduce the current in-tree storage functionality.

The Cluster API effort is currently undergoing a complete rehaul of the existing codebase, moving off Terraform and into using govmomi directly.

### SIG-windows

SIG Windows focused on stability and reliability of our existing feature set. We primarily fixed bugs as we march towards a near future stable release.

## Action Required

- etcd2 as a backend is deprecated and support will be removed in Kubernetes 1.13.
- The --storage-versions flag of kube-apiserver is now deprecated. This flag should be omitted to ensure the default storage versions are used. Otherwise the cluster is not safe to upgrade to a version newer than 1.12. This flag will be removed in 1.13. ([#68080](https://github.com/kubernetes/kubernetes/pull/68080), [@caesarxuchao](https://github.com/caesarxuchao)) Courtesy of SIG API Machinery
- Volume dynamic provisioning scheduling has been moved to beta, which means that the DynamicProvisioningScheduling alpha feature gate has been removed but the VolumeScheduling beta feature gate is still required for this feature. ([#67432](https://github.com/kubernetes/kubernetes/pull/67432), [@lichuqiang](https://github.com/lichuqiang)) Courtesy of SIG Apps, SIG Architecture, SIG Storage, and SIG Testing
- The API server and client-go libraries have been fixed to support additional non-alpha-numeric characters in UserInfo "extra" data keys. Both should be updated in order to properly support extra data containing "/" characters or other characters disallowed in HTTP headers. ([#65799](https://github.com/kubernetes/kubernetes/pull/65799), [@dekkagaijin](https://github.com/dekkagaijin)) Courtesy of SIG Auth
- The `NodeConfiguration` kind in the kubeadm v1alpha2 API has been renamed `JoinConfiguration` in v1alpha3 ([#65951](https://github.com/kubernetes/kubernetes/pull/65951), [@luxas](https://github.com/luxas)) Courtesy of SIG Cluster Lifecycle
- The `MasterConfiguration` kind in the kubeadm v1alpha2 API has been renamed `InitConfiguration` in v1alpha3 ([#65945](https://github.com/kubernetes/kubernetes/pull/65945), [@luxas](https://github.com/luxas)) Courtesy of SIG Cluster Lifecycle
- The formerly publicly-available cAdvisor web UI that the kubelet started using `--cadvisor-port` has been entirely removed in 1.12. The recommended way to run cAdvisor if you still need it, is via a DaemonSet. ([#65707](https://github.com/kubernetes/kubernetes/pull/65707), [@dims](https://github.com/dims))
- Cluster Autoscaler version has been updated to 1.3.1-beta.1. Release notes: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.3.1-beta.1 ([#65857](https://github.com/kubernetes/kubernetes/pull/65857), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska)) Courtesy of SIG Autoscaling
- kubeadm: The `v1alpha1` config API has been removed. ([#65628](https://github.com/kubernetes/kubernetes/pull/65628), [@luxas](https://github.com/luxas)) Courtesy of SIG Cluster Lifecycle
- kube-apiserver: When using `--enable-admission-plugins` the `Priority` admission plugin is now enabled by default (matching changes in 1.11.1+). If using `--admission-control` to fully specify the set of admission plugins, it is now necessary to add the `Priority` admission plugin for the PodPriority feature to work properly. ([#65739](https://github.com/kubernetes/kubernetes/pull/65739), [@liggitt](https://github.com/liggitt)) Courtesy of SIG Scheduling
- The `system-node-critical` and `system-cluster-critical` priority classes are now limited to the `kube-system` namespace by the `PodPriority` admission plugin (matching changes in 1.11.1+). ([#65593](https://github.com/kubernetes/kubernetes/pull/65593), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG Scheduling
- kubeadm: Control plane images (etcd, kube-apiserver, kube-proxy, etc.) no longer use arch suffixes. Arch suffixes are kept for kube-dns only. ([#66960](https://github.com/kubernetes/kubernetes/pull/66960), 
[@rosti](https://github.com/rosti)) Courtesy of SIG Cluster Lifecycle, SIG Release, and SIG Testing
- kubeadm - Feature-gates HighAvailability, SelfHosting, CertsInSecrets are now deprecated and can no longer be used for new clusters. Cluster updates using above feature-gates flag is not supported. ([#67786](https://github.com/kubernetes/kubernetes/pull/67786), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle
- 'KubeSchedulerConfiguration' which used to be under GroupVersion 'componentconfig/v1alpha1',
is now under 'kubescheduler.config.k8s.io/v1alpha1'.  ([#66916](https://github.com/kubernetes/kubernetes/pull/66916), [@dixudx](https://github.com/dixudx)) Courtesy of SIG Cluster Lifecycle, SIG Scheduling, and SIG Testing
- The flag `--skip-preflight-checks` of kubeadm has been removed. Please use `--ignore-preflight-errors` instead. ([#62727](https://github.com/kubernetes/kubernetes/pull/62727), [@xiangpengzhao](https://github.com/xiangpengzhao))
- If Openstack LoadBalancer is not defined in cloud config, the loadbalancer will no longer beis not initialized. any more in openstack. All setups must have some setting under that section for the OpenStack provider. ([#65781](https://github.com/kubernetes/kubernetes/pull/65781), [@zetaab](https://github.com/zetaab))

## Deprecations and removals

- Kubeadm: The Alpha feature-gates HighAvailability, SelfHosting, CertsInSecrets are now deprecated, and will be removed in k8s v1.13.0.
- The cloudstack and ovirt controllers have been deprecated and will be removed in a future version. ([#68199](https://github.com/kubernetes/kubernetes/pull/68199), [@dims](https://github.com/dims))
- All kubectl run generators have been deprecated except for run-pod/v1. This is part of a move to make `kubectl run` simpler, enabling it create only pods; if additional resources are needed, you should use `kubectl create` instead. ([#68132](https://github.com/kubernetes/kubernetes/pull/68132), [@soltysh](https://github.com/soltysh))
- The deprecated --interactive flag has been removed from kubectl logs. ([#65420](https://github.com/kubernetes/kubernetes/pull/65420), [@jsoref](https://github.com/jsoref))
-The deprecated shorthand flag `-c` has been removed from `kubectl version (--client)`. ([#66817](https://github.com/kubernetes/kubernetes/pull/66817), [@charrywanganthony](https://github.com/charrywanganthony))
- The `--pod` flag (`-p` shorthand) of the kubectl exec command has been marked as deprecated, and will be removed in a future version. This flag is currently optional. ([#66558](https://github.com/kubernetes/kubernetes/pull/66558), [@quasoft](https://github.com/quasoft))
- kubectl: `--use-openapi-print-columns` has been deprecated in favor of `--server-print`, and will be removed in a future version. ([#65601](https://github.com/kubernetes/kubernetes/pull/65601), [@liggitt](https://github.com/liggitt))
- The watch API endpoints prefixed with `/watch` are deprecated and will be removed in a future release. These standard method for watching resources (supported since v1.0) is to use the list API endpoints with a `?watch=true` parameter. All client-go clients have used the parameter method since v1.6.0. ([#65147](https://github.com/kubernetes/kubernetes/pull/65147), [@liggitt](https://github.com/liggitt))
- Using the Horizontal Pod Autoscaler with metrics from Heapster is now deprecated and will be disabled in a future version. ([#68089](https://github.com/kubernetes/kubernetes/pull/68089), [@DirectXMan12](https://github.com/DirectXMan12))
- The watch API endpoints prefixed with `/watch` are deprecated and will be removed in a future release. These standard method for watching resources (supported since v1.0) is to use the list API endpoints with a `?watch=true` parameter. All client-go clients have used the parameter method since v1.6.0. ([#65147](https://github.com/kubernetes/kubernetes/pull/65147), [@liggitt](https://github.com/liggitt))

## New Features

- Kubernetes now registers volume topology information reported by a node-level Container Storage Interface (CSI) driver. This enables Kubernetes support of CSI topology mechanisms. ([#67684](https://github.com/kubernetes/kubernetes/pull/67684), [@verult](https://github.com/verult)) Courtesy of SIG API Machinery, SIG Node, SIG Storage, and SIG Testing
- Addon-manager has been bumped to v8.7 ([#68299](https://github.com/kubernetes/kubernetes/pull/68299), [@MrHohn](https://github.com/MrHohn)) Courtesy of SIG Cluster Lifecycle, and SIG Testing
- The CSI volume plugin no longer needs an external attacher for non-attachable CSI volumes. ([#67955](https://github.com/kubernetes/kubernetes/pull/67955), [@jsafrane](https://github.com/jsafrane)) Courtesy of SIG API Machinery, SIG Node, SIG Storage, and SIG Testing
- KubeletPluginsWatcher feature graduated to beta. ([#68200](https://github.com/kubernetes/kubernetes/pull/68200), [@RenaudWasTaken](https://github.com/RenaudWasTaken)) Courtesy of SIG Node, SIG Storage, and SIG Testing
- A TTL mechanism has been added to clean up Jobs after they finish. ([#66840](https://github.com/kubernetes/kubernetes/pull/66840), [@janetkuo](https://github.com/janetkuo)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, and SIG Testing
- The scheduler is now optimized to throttle computational tasks involved with node selection. ([#67555](https://github.com/kubernetes/kubernetes/pull/67555), [@wgliang](https://github.com/wgliang)) Courtesy of SIG API Machinery, and SIG Scheduling
- The  performance of Pod affinity/anti-affinity in the scheduler has been improved. ([#67788](https://github.com/kubernetes/kubernetes/pull/67788), [@ahmad-diaa](https://github.com/ahmad-diaa)) Courtesy of SIG Scalability, and SIG Scheduling
- A kubelet parameter and config option has been added to change the CFS quota period from the default 100ms to some other value between 1µs and 1s. This was done to improve response latencies for workloads running in clusters with guaranteed and burstable QoS classes. ([#63437](https://github.com/kubernetes/kubernetes/pull/63437), [@szuecs](https://github.com/szuecs)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG CLI,, SIG Node, and SIG Scheduling
- Secure serving on port 10258 to cloud-controller-manager (configurable via `--secure-port`) is now enabled. Delegated authentication and authorization are to be configured using the same flags as for aggregated API servers. Without configuration, the secure port will only allow access to `/healthz`. ([#67069](https://github.com/kubernetes/kubernetes/pull/67069), [@sttts](https://github.com/sttts)) Courtesy of SIG Auth, and SIG Cloud Provider
- The commands `kubeadm alpha phases renew <cert-name>` have been added. ([#67910](https://github.com/kubernetes/kubernetes/pull/67910), [@liztio](https://github.com/liztio)) Courtesy of SIG API Machinery, and SIG Cluster Lifecycle
- ProcMount has been added to SecurityContext and AllowedProcMounts has been added to PodSecurityPolicy to allow paths in the container's /proc to not be masked. ([#64283](https://github.com/kubernetes/kubernetes/pull/64283), [@jessfraz](https://github.com/jessfraz)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, and SIG Node
- Secure serving on port 10257 to kube-controller-manager (configurable via `--secure-port`) is now enabled. Delegated authentication and authorization are to be configured using the same flags as for aggregated API servers. Without configuration, the secure port will only allow access to `/healthz`. ([#64149](https://github.com/kubernetes/kubernetes/pull/64149), [@sttts](https://github.com/sttts)) Courtesy of SIG API Machinery, SIG Auth, SIG Cloud Provider, SIG Scheduling, and SIG Testing
- Azure cloud provider now supports unmanaged nodes (such as on-prem) that are labeled with `kubernetes.azure.com/managed=false` and `alpha.service-controller.kubernetes.io/exclude-balancer=true` ([#67984](https://github.com/kubernetes/kubernetes/pull/67984), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure, and SIG Cloud Provider
- SCTP is now supported as an additional protocol (alpha) alongside TCP and UDP in Pod, Service, Endpoint, and NetworkPolicy.  ([#64973](https://github.com/kubernetes/kubernetes/pull/64973), [@janosi](https://github.com/janosi)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, and SIG Scheduling
- Autoscaling/v2beta2 and custom_metrics/v1beta2 have been introduced, which implement metric selectors for Object and Pods metrics, as well as allowing AverageValue targets on Objects, similar to External metrics. ([#64097](https://github.com/kubernetes/kubernetes/pull/64097), [@damemi](https://github.com/damemi)) Courtesy of SIG API Machinery, SIG Architecture, SIG Autoscaling, SIG CLI, and SIG Testing
- kubelet: Users can now enable the alpha NodeLease feature gate to have the Kubelet create and periodically renew a Lease in the kube-node-lease namespace. The lease duration defaults to 40s, and can be configured via the kubelet.config.k8s.io/v1beta1.KubeletConfiguration's NodeLeaseDurationSeconds field. ([#66257](https://github.com/kubernetes/kubernetes/pull/66257), [@mtaufen](https://github.com/mtaufen)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG Cluster Lifecycle, SIG Node, and SIG Testing
- PodReadinessGate is now turned on by default. ([#67406](https://github.com/kubernetes/kubernetes/pull/67406), [@freehan](https://github.com/freehan)) Courtesy of SIG Node
- Azure cloud provider now supports cross resource group nodes that are labeled with `kubernetes.azure.com/resource-group=<rg-name>` and `alpha.service-controller.kubernetes.io/exclude-balancer=true` ([#67604](https://github.com/kubernetes/kubernetes/pull/67604), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure, SIG Cloud Provider, and SIG Storage
- Annotations are now supported for remote admission webhooks. ([#58679](https://github.com/kubernetes/kubernetes/pull/58679), [@CaoShuFeng](https://github.com/CaoShuFeng)) Courtesy of SIG API Machinery, and SIG Auth
- The scheduler now scores fewer than all nodes in every scheduling cycle. This can improve performance of the scheduler in large clusters. ([#66733](https://github.com/kubernetes/kubernetes/pull/66733), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG Scheduling
- Node affinity for Azure unzoned managed disks has been added. ([#67229](https://github.com/kubernetes/kubernetes/pull/67229), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure
- The Attacher/Detacher interfaces for local storage have been refactored  ([#66884](https://github.com/kubernetes/kubernetes/pull/66884), [@NickrenREN](https://github.com/NickrenREN)) Courtesy of SIG Storage
- DynamicProvisioningScheduling and VolumeScheduling is now supported for Azure managed disks. Feature gates DynamicProvisioningScheduling and VolumeScheduling should be enabled before using this feature. ([#67121](https://github.com/kubernetes/kubernetes/pull/67121), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure, and SIG Storage
- The audit.k8s.io api group has been upgraded from v1beta1 to v1. ([#65891](https://github.com/kubernetes/kubernetes/pull/65891), [@CaoShuFeng](https://github.com/CaoShuFeng)) Courtesy of SIG API Machinery
- The quota admission configuration API graduated to v1beta1. ([#66156](https://github.com/kubernetes/kubernetes/pull/66156), [@vikaschoudhary16](https://github.com/vikaschoudhary16)) Courtesy of SIG Node, and SIG Scheduling
- Kube-apiserver --help flag help is now printed in sections. ([#64517](https://github.com/kubernetes/kubernetes/pull/64517), [@sttts](https://github.com/sttts))
- Azure managed disks now support availability zones and new parameters `zoned`, `zone` and `zones` are added for AzureDisk storage class. ([#66553](https://github.com/kubernetes/kubernetes/pull/66553), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure
- Kubectl create job command has been added. ([#60316](https://github.com/kubernetes/kubernetes/pull/60316), [@soltysh](https://github.com/soltysh)) Courtesy of SIG CLI
- Kubelet serving certificate bootstrapping and rotation has been promoted to beta status. ([#66726](https://github.com/kubernetes/kubernetes/pull/66726), [@liggitt](https://github.com/liggitt)) Courtesy of SIG Auth, and SIG Node
- Azure nodes with availability zone will now have label `failure-domain.beta.kubernetes.io/zone=<region>-<zoneID>`. ([#66242](https://github.com/kubernetes/kubernetes/pull/66242), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure
- kubeadm: Default component configs are now printable via kubeadm config print-default ([#66074](https://github.com/kubernetes/kubernetes/pull/66074), [@rosti](https://github.com/rosti)) Courtesy of SIG Cluster Lifecycle
- Mount propagation has been promoted to GA. The `MountPropagation` feature gate is deprecated and will be removed in 1.13. ([#67255](https://github.com/kubernetes/kubernetes/pull/67255), [@bertinatto](https://github.com/bertinatto)) Courtesy of SIG Apps, SIG Architecture, SIG Node, and SIG Storage
- Ubuntu 18.04 (Bionic) series has been added to Juju charms ([#65644](https://github.com/kubernetes/kubernetes/pull/65644), [@tvansteenburgh](https://github.com/tvansteenburgh))
- kubeadm: The kubeadm configuration now supports the definition of more than one control plane instances with their own APIEndpoint. The APIEndpoint for the "bootstrap" control plane instance should be defined using `InitConfiguration.APIEndpoint`, while the APIEndpoints for additional control plane instances should be added using `JoinConfiguration.APIEndpoint`. ([#67832](https://github.com/kubernetes/kubernetes/pull/67832), [@fabriziopandini](https://github.com/fabriziopandini))
- Add new `--server-dry-run` flag to `kubectl apply` so that the request will be sent to the server with the dry-run flag (alpha), which means that changes won't be persisted. ([#68069](https://github.com/kubernetes/kubernetes/pull/68069), [@apelisse](https://github.com/apelisse))
- Introduce CSI Cluster Registration mechanism to ease CSI plugin discovery and allow CSI drivers to customize Kubernetes' interaction with them. ([#67803](https://github.com/kubernetes/kubernetes/pull/67803), [@saad-ali](https://github.com/saad-ali))
- The PodShareProcessNamespace feature to configure PID namespace sharing within a pod has been promoted to beta. ([#66507](https://github.com/kubernetes/kubernetes/pull/66507), [@verb](https://github.com/verb))

## API Changes

- kubeadm now supports the phase command "alpha phase kubelet config annotate-cri". ([#68449](https://github.com/kubernetes/kubernetes/pull/68449), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: --cri-socket now defaults to tcp://localhost:2375 when running on Windows. ([#67447](https://github.com/kubernetes/kubernetes/pull/67447), [@benmoss](https://github.com/benmoss))
- kubeadm now includes a new EXPERIMENTAL `--rootfs`, which (if specified) causes kubeadm to chroot before performing any file operations.  This is expected to be useful when setting up kubernetes on a different filesystem, such as invoking kubeadm from docker. ([#54935](https://github.com/kubernetes/kubernetes/pull/54935), [@anguslees](https://github.com/anguslees))
- The  command line option  --cri-socket-path of the kubeadm subcommand "kubeadm config images pull" has been renamed to --cri-socket to be consistent with the rest of kubeadm subcommands. 
- kubeadm: The ControlPlaneEndpoint was moved from the API config struct to ClusterConfiguration ([#67830](https://github.com/kubernetes/kubernetes/pull/67830), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: InitConfiguration now consists of two structs: InitConfiguration and ClusterConfiguration ([#67441](https://github.com/kubernetes/kubernetes/pull/67441), [@rosti](https://github.com/rosti))
- The RuntimeClass API has been added. This feature is in alpha, and the RuntimeClass feature gate must be enabled in order to use it. The RuntimeClass API resource defines different classes of runtimes that may be used to run containers in the cluster. Pods can select a RuntimeClass to use via the RuntimeClassName field. ([#67737](https://github.com/kubernetes/kubernetes/pull/67737), [@tallclair](https://github.com/tallclair))
- To address the possibility of dry-run requests overwhelming admission webhooks that rely on side effects and a reconciliation mechanism, a new field is being added to `admissionregistration.k8s.io/v1beta1.ValidatingWebhookConfiguration` and `admissionregistration.k8s.io/v1beta1.MutatingWebhookConfiguration` so that webhooks can explicitly register as having dry-run support. If a dry-run request is made on a resource that triggers a non dry-run supporting webhook, the request will be completely rejected, with "400: Bad Request". Additionally, a new field is being added to the `admission.k8s.io/v1beta1.AdmissionReview` API object, exposing to webhooks whether or not the request being reviewed is a dry-run. ([#66936](https://github.com/kubernetes/kubernetes/pull/66936), [@jennybuckley](https://github.com/jennybuckley))
- CRI now supports a "runtime_handler" field for RunPodSandboxRequest, used for selecting the runtime configuration to run the sandbox with (alpha feature). ([#67518](https://github.com/kubernetes/kubernetes/pull/67518), [@tallclair](https://github.com/tallclair))
- More fields are allowed at the root of the CRD validation schema when the status subresource is enabled. ([#65357](https://github.com/kubernetes/kubernetes/pull/65357), [@nikhita](https://github.com/nikhita))
- The --docker-disable-shared-pid kubelet flag has been removed. PID namespace sharing can instead be enable per-pod using the ShareProcessNamespace option. ([#66506](https://github.com/kubernetes/kubernetes/pull/66506), [@verb](https://github.com/verb))
- Added the --dns-loop-detect option to dnsmasq, which is run by kube-dns. ([#67302](https://github.com/kubernetes/kubernetes/pull/67302), [@dixudx](https://github.com/dixudx))
- Kubernetes now supports extra `--prune-whitelist` resources in kube-addon-manager. ([#67743](https://github.com/kubernetes/kubernetes/pull/67743), [@Random-Liu](https://github.com/Random-Liu))
- Graduate Resource Quota ScopeSelectors to beta, and enable it by default. ([#67077](https://github.com/kubernetes/kubernetes/pull/67077), [@vikaschoudhary16](https://github.com/vikaschoudhary16))
- The OpenAPI spec and documentation now reflect the 202 Accepted response path for delete requests. Note that this change in the openapi spec may affect some clients that depend on the error paths.  ([#63418](https://github.com/kubernetes/kubernetes/pull/63418), [@roycaihw](https://github.com/roycaihw))
- The alpha `Initializers` admission plugin is no longer enabled by default. This matches the off-by-default behavior of the alpha API which drives initializer behavior. ([#66039](https://github.com/kubernetes/kubernetes/pull/66039), [@liggitt](https://github.com/liggitt))
- Adding validation to kube-scheduler at the API level ([#66799](https://github.com/kubernetes/kubernetes/pull/66799), [@noqcks](https://github.com/noqcks))
- `DisruptedPods` field in `PodDisruptionBudget` is optional instead of required. ([#63757](https://github.com/kubernetes/kubernetes/pull/63757), [@nak3](https://github.com/nak3))

## Other Notable Changes

### SIG API Machinery

- `kubectl get apiservice` now shows the target service and whether the service is available ([#67747](https://github.com/kubernetes/kubernetes/pull/67747), [@smarterclayton](https://github.com/smarterclayton))
- Apiserver panics will now be returned as 500 errors rather than terminating the apiserver process. ([#68001](https://github.com/kubernetes/kubernetes/pull/68001), [@sttts](https://github.com/sttts))
- API paging is now enabled for custom resource definitions, custom resources and APIService objects. ([#67861](https://github.com/kubernetes/kubernetes/pull/67861), [@liggitt](https://github.com/liggitt))
- To address the possibility dry-run requests overwhelming admission webhooks that rely on side effects and a reconciliation mechanism, a new field is being added to admissionregistration.k8s.io/v1beta1.ValidatingWebhookConfiguration and admissionregistration.k8s.io/v1beta1.MutatingWebhookConfiguration so that webhooks can explicitly register as having dry-run support. If a dry-run request is made on a resource that triggers a non dry-run supporting webhook, the request will be completely rejected, with "400: Bad Request". Additionally, a new field is being added to the admission.k8s.io/v1beta1.AdmissionReview API object, exposing to webhooks whether or not the request being reviewed is a dry-run. ([#66936](https://github.com/kubernetes/kubernetes/pull/66936), [@jennybuckley](https://github.com/jennybuckley))
- kube-apiserver now includes all registered API groups in discovery, including registered extension API group/versions for unavailable extension API servers. ([#66932](https://github.com/kubernetes/kubernetes/pull/66932), [@nilebox](https://github.com/nilebox))
- kube-apiserver: setting a `dryRun` query parameter on a CONNECT request will now cause the request to be rejected, consistent with behavior of other mutating API requests. Examples of CONNECT APIs are the `nodes/proxy`, `services/proxy`, `pods/proxy`, `pods/exec`, and `pods/attach` subresources. Note that this prevents sending a `dryRun` parameter to backends via `{nodes,services,pods}/proxy` subresources. ([#66083](https://github.com/kubernetes/kubernetes/pull/66083), [@jennybuckley](https://github.com/jennybuckley))
- In clusters where the DryRun feature is enabled, dry-run requests will go through the normal admission chain. Because of this, ImagePolicyWebhook authors should especially make sure that their webhooks do not rely on side effects. ([#66391](https://github.com/kubernetes/kubernetes/pull/66391), [@jennybuckley](https://github.com/jennybuckley))
- Added etcd_object_count metrics for CustomResources. ([#65983](https://github.com/kubernetes/kubernetes/pull/65983), [@sttts](https://github.com/sttts))
- The OpenAPI version field will now be properly autopopulated without needing other OpenAPI fields present in generic API server code. ([#66411](https://github.com/kubernetes/kubernetes/pull/66411), [@DirectXMan12](https://github.com/DirectXMan12))
- TLS timeouts have been extended to work around slow arm64 math/big functions. ([#66264](https://github.com/kubernetes/kubernetes/pull/66264), [@joejulian](https://github.com/joejulian))
- Kubernetes now checks CREATE admission for create-on-update requests instead of UPDATE admission. ([#65572](https://github.com/kubernetes/kubernetes/pull/65572), [@yue9944882](https://github.com/yue9944882))
- kube- and cloud-controller-manager can now listen on ports up to 65535 rather than 32768, solving problems with operating systems that request these higher ports.. ([#65860](https://github.com/kubernetes/kubernetes/pull/65860), [@sttts](https://github.com/sttts))
- LimitRange and Endpoints resources can be created via an update API call if the object does not already exist. When this occurs, an authorization check is now made to ensure the user making the API call is authorized to create the object. In previous releases, only an update authorization check was performed. ([#65150](https://github.com/kubernetes/kubernetes/pull/65150), [@jennybuckley](https://github.com/jennybuckley))
- More fields are allowed at the root of the CRD validation schema when the status subresource is enabled. ([#65357](https://github.com/kubernetes/kubernetes/pull/65357), [@nikhita](https://github.com/nikhita))
- api-machinery utility functions `SetTransportDefaults` and `DialerFor` once again respect custom Dial functions set on transports ([#65547](https://github.com/kubernetes/kubernetes/pull/65547), [@liggitt](https://github.com/liggitt))
- AdvancedAuditing has been promoted to GA, replacing the previous (legacy) audit logging mechanisms. ([#65862](https://github.com/kubernetes/kubernetes/pull/65862), [@loburm](https://github.com/loburm))
- Added --authorization-always-allow-paths to components doing delegated authorization to exclude certain HTTP paths like /healthz from authorization. ([#67543](https://github.com/kubernetes/kubernetes/pull/67543), [@sttts](https://github.com/sttts))
- Allow ImageReview backend to return annotations to be added to the created pod. ([#64597](https://github.com/kubernetes/kubernetes/pull/64597), [@wteiken](https://github.com/wteiken))
- Upon receiving a LIST request with an expired continue token, the apiserver now returns a continue token together with the 410 "the from parameter is too old" error. If the client does not care about getting a list from a consistent snapshot, the client can use this token to continue listing from the next key, but the returned chunk will be from the latest snapshot. ([#67284](https://github.com/kubernetes/kubernetes/pull/67284), [@caesarxuchao](https://github.com/caesarxuchao))

### SIG Apps

- The service controller will now retry creating the load balancer when `persistUpdate` fails due to conflict. ([#68087](https://github.com/kubernetes/kubernetes/pull/68087), [@grayluck](https://github.com/grayluck))
- The latent controller caches no longer cause repeating deletion messages for deleted pods. ([#67826](https://github.com/kubernetes/kubernetes/pull/67826), [@deads2k](https://github.com/deads2k))

### SIG Auth

- TokenRequest and TokenRequestProjection are now beta features. To enable these feature, the API server needs to be started with the `--service-account-issuer`, `--service-account-signing-key-file`, and `--service-account-api-audiences` flags. 
([#67349](https://github.com/kubernetes/kubernetes/pull/67349), [@mikedanese](https://github.com/mikedanese))
- The admin RBAC role now aggregates edit and view.  The edit RBAC role now aggregates view.  ([#66684](https://github.com/kubernetes/kubernetes/pull/66684), [@deads2k](https://github.com/deads2k))
- UserInfo derived from service account tokens created from the TokenRequest API now include the pod name and UID in the Extra field. ([#61858](https://github.com/kubernetes/kubernetes/pull/61858), [@mikedanese](https://github.com/mikedanese))
- The extension API server can now dynamically discover the requestheader CA certificate when the core API server doesn't use certificate based authentication for it's clients. ([#66394](https://github.com/kubernetes/kubernetes/pull/66394), [@rtripat](https://github.com/rtripat))

### SIG Autoscaling

- Horizontal Pod Autoscaler default update interval has been increased from 30s to 15s, improving HPA reaction time for metric changes. ([#68021](https://github.com/kubernetes/kubernetes/pull/68021), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- To avoid soft-deleted pods incorrectly affecting scale up replica count calculations, the HPA controller will stop counting soft-deleted pods for scaling purposes. ([#67067](https://github.com/kubernetes/kubernetes/pull/67067), [@moonek](https://github.com/moonek))
- HPA reaction to metric changes has been spend up by removing the scale up forbidden window. ([#66615](https://github.com/kubernetes/kubernetes/pull/66615), [@jbartosik](https://github.com/jbartosik))

### SIG AWS

- AWS LoadBalancer security group ICMP rules now match the documentation of  spec.loadBalancerSourceRanges ([#63572](https://github.com/kubernetes/kubernetes/pull/63572), [@haz-mat](https://github.com/haz-mat))
- The aws cloud provider now reports a `Hostname` address type for nodes based on the `local-hostname` metadata key. ([#67715](https://github.com/kubernetes/kubernetes/pull/67715), [@liggitt](https://github.com/liggitt))

### SIG Azure

- \API calls for Azure instance metadata have been reduced to help avoid "too many requests" errors.. ([#67478](https://github.com/kubernetes/kubernetes/pull/67478), [@feiskyer](https://github.com/feiskyer))
- Azure Go SDK has been upgraded to v19.0.0 and VirtualMachineScaleSetVM now supports availability zones. ([#66648](https://github.com/kubernetes/kubernetes/pull/66648), [@feiskyer](https://github.com/feiskyer))
- User Assigned MSI (https://docs.microsoft.com/en-us/azure/active-directory/managed-service-identity/overview), which provides for managed identities, is now suppored for Kubernetes clusters on Azure. ([#66180](https://github.com/kubernetes/kubernetes/pull/66180), [@kkmsft](https://github.com/kkmsft))
- The Azure load balancer idle connection timeout for services is now configurable.([#66045](https://github.com/kubernetes/kubernetes/pull/6605), [@cpuguy83](https://github.com/cpuguy83))
- When provisioning workloads, Kubernetes will now skip nodes that have a primary NIC in a 'Failed' provisioningState. ([#65412](https://github.com/kubernetes/kubernetes/pull/65412), [@yastij](https://github.com/yastij))
- The NodeShutdown taint is now supported for Azure. ([#68033](https://github.com/kubernetes/kubernetes/pull/68033), [@yastij](https://github.com/yastij))

### SIG CLI

- Added a sample-cli-plugin staging repository and cli-runtime staging repository to help showcase the new kubectl plugins mechanism. ([#67938](https://github.com/kubernetes/kubernetes/pull/67938), [#67658](https://github.com/kubernetes/kubernetes/pull/67658), [@soltysh](https://github.com/soltysh))
- The plugin mechanism functionality now closely follows the git plugin design ([#66876](https://github.com/kubernetes/kubernetes/pull/66876), [@juanvallejo](https://github.com/juanvallejo))
- kubectl patch now respects --local ([#67399](https://github.com/kubernetes/kubernetes/pull/67399), [@deads2k](https://github.com/deads2k))
- kubectl: When an object can't be updated and must be deleted by force, kubectl will now recreating resources for immutable fields.([#66602](https://github.com/kubernetes/kubernetes/pull/66602), [@dixudx](https://github.com/dixudx))
- `kubectl create {clusterrole,role}`'s `--resources` flag now supports asterisk to specify all resources. ([#62945](https://github.com/kubernetes/kubernetes/pull/62945), [@nak3](https://github.com/nak3))
- kubectl: the wait command now prints an error message and exits with the code 1, if there is no resources matching selectors ([#66692](https://github.com/kubernetes/kubernetes/pull/66692), [@m1kola](https://github.com/m1kola))
- Kubectl now handles newlines for `command`, `args`, `env`, and `annotations` in `kubectl describe` wrapping. ([#66841](https://github.com/kubernetes/kubernetes/pull/66841), [@smarterclayton](https://github.com/smarterclayton))
- The `kubectl patch` command no longer exits with exit code 1 when a redundant patch results in a no-op ([#66725](https://github.com/kubernetes/kubernetes/pull/66725), [@juanvallejo](https://github.com/juanvallejo))
- The output of `kubectl get events` has been improved to prioritize showing the message, and to move some fields to `-o wide`. ([#66643](https://github.com/kubernetes/kubernetes/pull/66643), [@smarterclayton](https://github.com/smarterclayton))
- `kubectl config set-context` can now set attributes of the current context, such as the current namespace, by passing `--current` instead of a specific context name ([#66140](https://github.com/kubernetes/kubernetes/pull/66140), [@liggitt](https://github.com/liggitt))
- "kubectl delete" no longer waits for dependent objects to be deleted when removing parent resources ([#65908](https://github.com/kubernetes/kubernetes/pull/65908), [@juanvallejo](https://github.com/juanvallejo))
- A new flag, `--keepalive`, has been introduced, for kubectl proxy to allow setting keep-alive period for long-running request. ([#63793](https://github.com/kubernetes/kubernetes/pull/63793), [@hzxuzhonghu](https://github.com/hzxuzhonghu))
- kubectl: fixed a regression with --use-openapi-print-columns that would not print object contents ([#65600](https://github.com/kubernetes/kubernetes/pull/65600), [@liggitt](https://github.com/liggitt))
- The display of jobs in `kubectl get` and `kubectl describe` has been improved to emphasize progress and duration. ([#65463](https://github.com/kubernetes/kubernetes/pull/65463), [@smarterclayton](https://github.com/smarterclayton))
- CSI volume attributes have been added to kubectl describe pv`. ([#65074](https://github.com/kubernetes/kubernetes/pull/65074), [@wgliang](https://github.com/wgliang))
- Running `kubectl describe pvc` now shows which pods are mounted to the pvc being described with the `Mounted By` field ([#65837](https://github.com/kubernetes/kubernetes/pull/65837), [@clandry94](https://github.com/clandry94))
- `kubectl create secret tls` can now read certificate and key files from process substitution arguments ([#67713](https://github.com/kubernetes/kubernetes/pull/67713), [@liggitt](https://github.com/liggitt))
- `kubectl rollout status` now works for unlimited timeouts. ([#67817](https://github.com/kubernetes/kubernetes/pull/67817), [@tnozicka](https://github.com/tnozicka))

### SIG Cloud Provider

- The cloudstack cloud provider now reports a `Hostname` address type for nodes based on the `local-hostname` metadata key. ([#67719](https://github.com/kubernetes/kubernetes/pull/67719), [@liggitt](https://github.com/liggitt))
- The OpenStack cloud provider now reports a `Hostname` address type for nodes ([#67748](https://github.com/kubernetes/kubernetes/pull/67748), [@FengyunPan2](https://github.com/FengyunPan2))
- The vSphere cloud provider now suppoerts zones. ([#66795](https://github.com/kubernetes/kubernetes/pull/66795), [@jiatongw](https://github.com/jiatongw))

### SIG Cluster Lifecycle

- External CAs can now be used for kubeadm with only a certificate, as long as all required certificates already exist. ([#68296](https://github.com/kubernetes/kubernetes/pull/68296), [@liztio](https://github.com/liztio))
- kubeadm now works better when not connected to the Internet. In addition,  common kubeadm commands will now work without an available networking interface. ([#67397](https://github.com/kubernetes/kubernetes/pull/67397), [@neolit123](https://github.com/neolit123))
- Scrape frequency of metrics-server has been increased to 30s.([#68127](https://github.com/kubernetes/kubernetes/pull/68127), [@serathius](https://github.com/serathius))
- Kubernetes juju charms will now use CSI for ceph. ([#66523](https://github.com/kubernetes/kubernetes/pull/66523), [@hyperbolic2346](https://github.com/hyperbolic2346))
- kubeadm uses audit policy v1 instead of v1beta1 ([#67176](https://github.com/kubernetes/kubernetes/pull/67176), [@charrywanganthony](https://github.com/charrywanganthony))
- Kubeadm nodes will no longer be able to run with an empty or invalid hostname in /proc/sys/kernel/hostname ([#64815](https://github.com/kubernetes/kubernetes/pull/64815), [@dixudx](https://github.com/dixudx))
- kubeadm now can join the cluster with pre-existing client certificate if provided ([#66482](https://github.com/kubernetes/kubernetes/pull/66482), [@dixudx](https://github.com/dixudx))
([#66382](https://github.com/kubernetes/kubernetes/pull/66382), [@bart0sh](https://github.com/bart0sh)) 
- kubeadm will no longer hang indefinitely if there is no Internet connection and --kubernetes-version is not specified.([#65676](https://github.com/kubernetes/kubernetes/pull/65676), [@dkoshkin](https://github.com/dkoshkin))
- kubeadm: kube-proxy will now run on all nodes, and not just master nodes.([#65931](https://github.com/kubernetes/kubernetes/pull/65931), [@neolit123](https://github.com/neolit123))
- kubeadm now uses separate YAML documents for the kubelet and kube-proxy ComponentConfigs. ([#65787](https://github.com/kubernetes/kubernetes/pull/65787), [@luxas](https://github.com/luxas))
- kubeadm will now print required flags when running `kubeadm upgrade plan`.([#65802](https://github.com/kubernetes/kubernetes/pull/65802), [@xlgao-zju](https://github.com/xlgao-zju))
- Unix support for ZFS as a valid graph driver has been added for Docker, enabling users to use Kubeadm with ZFS. ([#65635](https://github.com/kubernetes/kubernetes/pull/65635), [@neolit123](https://github.com/neolit123))

### SIG GCP

- GCE: decrease cpu requests on master node, to allow more components to fit on one core machine. ([#67504](https://github.com/kubernetes/kubernetes/pull/67504), [@loburm](https://github.com/loburm))
- Kubernetes 1.12 includes a large number of metadata agent improvements, including expanding the metadata agent's access to all API groups and removing metadata agent config maps in favor of command line flags. It also includes improvements to the logging agent, such as multiple fixes and adjustments.
 ([#66485](https://github.com/kubernetes/kubernetes/pull/66485), [@bmoyles0117](https://github.com/bmoyles0117))
- cluster/gce: Kubernetes now generates consistent key sizes in config-default.sh using /dev/urandom instead of /dev/random   ([#67139](https://github.com/kubernetes/kubernetes/pull/67139), [@yogi-sagar](https://github.com/yogi-sagar))

### SIG Instrumentation

 The etcdv3 client can now be monitored by Prometheus. ([#64741](https://github.com/kubernetes/kubernetes/pull/64741), [@wgliang](https://github.com/wgliang))

### SIG Network

- The ip-masq-agent will now be scheduled in all nodes except master due to NoSchedule/NoExecute tolerations. ([#66260](https://github.com/kubernetes/kubernetes/pull/66260), [@tanshanshan](https://github.com/tanshanshan))
- The CoreDNS service can now be monitored by Prometheus. ([#65589](https://github.com/kubernetes/kubernetes/pull/65589), [@rajansandeep](https://github.com/rajansandeep))
- Traffic shaping is now supported for the CNI network driver. ([#63194](https://github.com/kubernetes/kubernetes/pull/63194), [@m1093782566](https://github.com/m1093782566))
- The dockershim now sets the "bandwidth" and "ipRanges" CNI capabilities (dynamic parameters). Plugin authors and administrators can now take advantage of this by updating their CNI configuration file. For more information, see the [CNI docs](https://github.com/containernetworking/cni/blob/master/CONVENTIONS.md#dynamic-plugin-specific-fields-capabilities--runtime-configuration) ([#64445](https://github.com/kubernetes/kubernetes/pull/64445), [@squeed](https://github.com/squeed))

### SIG Node

- RuntimeClass is a new API resource for defining different classes of runtimes that may be used to run containers in the cluster. Pods can select a RunitmeClass to use via the RuntimeClassName field. This feature is in alpha, and the RuntimeClass feature gate must be enabled in order to use it. ([#67737](https://github.com/kubernetes/kubernetes/pull/67737), [@tallclair](https://github.com/tallclair))
- Sped up kubelet start time by executing an immediate runtime and node status update when the Kubelet sees that it has a CIDR. ([#67031](https://github.com/kubernetes/kubernetes/pull/67031), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- cpumanager will now rollback state if updateContainerCPUSet failed, indicating that the container start failed. This change will prevent CPU leaks. ([#67430](https://github.com/kubernetes/kubernetes/pull/67430), [@choury](https://github.com/choury))
- [CRI] RunPodSandboxRequest now has a runtime_handler field for selecting the runtime configuration to run the sandbox with. This feature is in alpha for 1.12.. ([#67518](https://github.com/kubernetes/kubernetes/pull/67518), [@tallclair](https://github.com/tallclair))
- If a container's requested device plugin resource hasn't registered after Kubelet restart, the container start will now fail.([#67145](https://github.com/kubernetes/kubernetes/pull/67145), [@jiayingz](https://github.com/jiayingz))
- Upgraded TaintNodesByCondition to beta. ([#62111](https://github.com/kubernetes/kubernetes/pull/62111), [@k82cn](https://github.com/k82cn))
- The PodShareProcessNamespace feature to configure PID namespace sharing within a pod has been promoted to beta. ([#66507](https://github.com/kubernetes/kubernetes/pull/66507), [@verb](https://github.com/verb))
- The CPU Manager will now validate the state of the node,  enabling Kubernetes to maintain the CPU topology even if resources change. ([#66718](https://github.com/kubernetes/kubernetes/pull/66718), [@ipuustin](https://github.com/ipuustin))
- Added support kubelet plugin watcher in device manager, as part of the new plugin system. ([#58755](https://github.com/kubernetes/kubernetes/pull/58755), [@vikaschoudhary16](https://github.com/vikaschoudhary16))
- Expose docker registry config for addons used in Juju deployments ([#66092](https://github.com/kubernetes/kubernetes/pull/66092), [@kwmonroe](https://github.com/kwmonroe))
- `RunAsGroup` which has been broken since 1.10, now works. ([#65926](https://github.com/kubernetes/kubernetes/pull/65926), [@Random-Liu](https://github.com/Random-Liu))
- The systemd config files are now reloaded before kubelet starts, so changes can take effect([#65702](https://github.com/kubernetes/kubernetes/pull/65702), [@mborsz](https://github.com/mborsz))
- Hostnames are now converted to lowercase before being used for node lookups in the kubernetes-worker charm. ([#65487](https://github.com/kubernetes/kubernetes/pull/65487), [@dshcherb](https://github.com/dshcherb))
- kubelets that specify `--cloud-provider` now only report addresses in Node status as determined by the cloud provider (unless `--hostname-override` is used to force reporting of the specified hostname) ([#65594](https://github.com/kubernetes/kubernetes/pull/65594), [@liggitt](https://github.com/liggitt))
- Kubelet now exposes `/debug/flags/v` to allow dynamically setting glog logging level.  For example, to change glog level to 3, you only have to send a PUT request like `curl -X PUT http://127.0.0.1:8080/debug/flags/v -d "3"`. ([#64601](https://github.com/kubernetes/kubernetes/pull/64601), [@hzxuzhonghu](https://github.com/hzxuzhonghu))

### SIG OpenStack

- Openstack now supports the node shutdown taint. The taint is added when an instance is shutdown in openstack. ([#67982](https://github.com/kubernetes/kubernetes/pull/67982), [@zetaab](https://github.com/zetaab))

### SIG Scheduling

- The equivalence class cache has been redesigned to be a two level cache, resulting in a significant increase in scheduling throughput and performance. ([#65714](https://github.com/kubernetes/kubernetes/pull/65714), [@resouer](https://github.com/resouer))
- kube-scheduler can now listen on ports up to 65535, correcting a problem with certain operating systems that request ports greater than 32768. ([#65833](https://github.com/kubernetes/kubernetes/pull/65833), [@sttts](https://github.com/sttts))
- Performance of the anti-affinity predicate of the default scheduler has been improved. ([#66948](https://github.com/kubernetes/kubernetes/pull/66948), [@mohamed-mehany](https://github.com/mohamed-mehany))
- The unreachable taint gets applied to a node when it loses its network connection. ([#67734](https://github.com/kubernetes/kubernetes/pull/67734), [@Huang-Wei](https://github.com/Huang-Wei))
- If `TaintNodesByCondition` is enabled, add `node.kubernetes.io/unschedulable` and `node.kubernetes.io/network-unavailable` automatically to DaemonSet pods. ([#64954](https://github.com/kubernetes/kubernetes/pull/64954), [@k82cn](https://github.com/k82cn))

### SIG Storage

- The AllowedTopologies field inside StorageClass is now validated against set and map semantics. Specifically, there cannot be duplicate TopologySelectorTerms, MatchLabelExpressions keys, or TopologySelectorLabelRequirement Values. ([#66843](https://github.com/kubernetes/kubernetes/pull/66843), [@verult](https://github.com/verult))
- A PersistentVolumeClaim may not have been synced to the controller local cache in time if the PersistentVolumeis bound by an external PV binder (such as kube-scheduler), so Kubernetes will now double check if PVC is not found in order to prevent the volume from being incorrectly reclaimed. ([#67062](https://github.com/kubernetes/kubernetes/pull/67062), [@cofyc](https://github.com/cofyc))
- Filesystems will now be properly unmounted when a backend is not reachable and returns EIO. ([#67097](https://github.com/kubernetes/kubernetes/pull/67097), [@chakri-nelluri](https://github.com/chakri-nelluri))
- The logic for attaching volumes has been changed so that attachdetach controller attaches volumes immediately when a Pod's PVCs are bound, preventing a problem that caused pods to have extremely long startup times. ([#66863](https://github.com/kubernetes/kubernetes/pull/66863), [@cofyc](https://github.com/cofyc))
- Dynamic provisions that create iSCSI PVs can now ensure that multipath is used by specifying 2 or more target portals in the PV, which will cause kubelet to wait up to 10 seconds for the multipath device. PVs with just one portal continue to work as before, with kubelet not waiting for the multipath device and just using the first disk it finds. ([#67140](https://github.com/kubernetes/kubernetes/pull/67140), [@bswartz](https://github.com/bswartz))
- ScaleIO volumes can now be provisioned without having to first manually create /dev/disk/by-id path on each kubernetes node (if not already present). ([#66174](https://github.com/kubernetes/kubernetes/pull/66174), [@ddebroy](https://github.com/ddebroy))
- Multi-line annotations injected via downward API files will no longer be sorted, scrambling their information. ([#65992](https://github.com/kubernetes/kubernetes/pull/65992), [@liggitt](https://github.com/liggitt))
- The constructed volume spec for the CSI plugin now includes a volume mode field. ([#65456](https://github.com/kubernetes/kubernetes/pull/65456), [@wenlxie](https://github.com/wenlxie))
- Kubernetes now includes a metric that reports the number of PVCs that are in-use,with plugin and node name as dimensions, making it possible to figure out how many PVCs each node is using when troubleshooting attach/detach issues.
 ([#64527](https://github.com/kubernetes/kubernetes/pull/64527), [@gnufied](https://github.com/gnufied))
- Added support to restore a volume from a volume snapshot data source.  ([#67087](https://github.com/kubernetes/kubernetes/pull/67087), [@xing-yang](https://github.com/xing-yang))
- When attaching iSCSI volumes, kubelet now scans only the specific LUNs being attached, and also deletes them after detaching. This avoids dangling references to LUNs that no longer exist, which used to be the cause of random I/O errors/timeouts in kernel logs, slowdowns during block-device related operations, and very rare cases of data corruption.
([#63176](https://github.com/kubernetes/kubernetes/pull/63176), [@bswartz](https://github.com/bswartz))
- Both directory and block devices are now supported for local volume plugin FileSystem VolumeMode.  ([#63011](https://github.com/kubernetes/kubernetes/pull/63011), [@NickrenREN](https://github.com/NickrenREN))
- CSI NodePublish call can optionally contain information about the pod that requested the CSI volume. ([#67945](https://github.com/kubernetes/kubernetes/pull/67945), [@jsafrane](https://github.com/jsafrane))
- Added support for volume attach limits for CSI volumes. ([#67731](https://github.com/kubernetes/kubernetes/pull/67731), [@gnufied](https://github.com/gnufied))

### SIG VMWare

- The vmUUID is now preserved when renewing nodeinfo in the vSphere cloud provider. ([#66007](https://github.com/kubernetes/kubernetes/pull/66007), [@w-leads](https://github.com/w-leads))
- You can now configure the vsphere cloud provider with a trusted Root-CA, enabling you to take advantage of TLS certificate rotation. ([#64758](https://github.com/kubernetes/kubernetes/pull/64758), [@mariantalla](https://github.com/mariantalla))

### SIG Windows

- Kubelet no longer attempts to sync iptables on non-Linux systems.. ([#67690](https://github.com/kubernetes/kubernetes/pull/67690), [@feiskyer](https://github.com/feiskyer))
- Kubelet no longer applies default hard evictions of nodefs.inodesFree on non-Linux systems. ([#67709](https://github.com/kubernetes/kubernetes/pull/67709), [@feiskyer](https://github.com/feiskyer))
- Windows system container "pods" now support kubelet stats. ([#66427](https://github.com/kubernetes/kubernetes/pull/66427), [@feiskyer](https://github.com/feiskyer))

## Other Notable Changes

### Bug Fixes

- Update debian-iptables and hyperkube-base images to include CVE fixes. ([#67365](https://github.com/kubernetes/kubernetes/pull/67365), [@ixdy](https://github.com/ixdy))
- Fix for resourcepool-path configuration in the vsphere.conf file. ([#66261](https://github.com/kubernetes/kubernetes/pull/66261), [@divyenpatel](https://github.com/divyenpatel))
- This fix prevents a GCE PD volume from being mounted if the udev device link is stale and tries to correct the link. ([#66832](https://github.com/kubernetes/kubernetes/pull/66832), [@msau42](https://github.com/msau42))
- Fix controller-manager crashes when flex plugin is removed from flex plugin directory ([#65536](https://github.com/kubernetes/kubernetes/pull/65536), [@gnufied](https://github.com/gnufied))
- Fix local volume directory can't be deleted because of volumeMode error ([#65310](https://github.com/kubernetes/kubernetes/pull/65310), [@wenlxie](https://github.com/wenlxie))
- bugfix: Do not print feature gates in the generic apiserver code for glog level 0 ([#65584](https://github.com/kubernetes/kubernetes/pull/65584), [@neolit123](https://github.com/neolit123))
- Fix an issue that pods using hostNetwork keep increasing. ([#67456](https://github.com/kubernetes/kubernetes/pull/67456), [@Huang-Wei](https://github.com/Huang-Wei))
- fixes an out of range panic in the NoExecuteTaintManager controller when running a non-64-bit build ([#65596](https://github.com/kubernetes/kubernetes/pull/65596), [@liggitt](https://github.com/liggitt))
- Fix kubelet to not leak goroutines/intofiy watchers on an inactive connection if it's closed ([#67285](https://github.com/kubernetes/kubernetes/pull/67285), [@yujuhong](https://github.com/yujuhong))
- Fix pod launch by kubelet when --cgroups-per-qos=false and --cgroup-driver="systemd" ([#66617](https://github.com/kubernetes/kubernetes/pull/66617), [@pravisankar](https://github.com/pravisankar))
- Fixed a panic in the node status update logic when existing node has nil labels. ([#66307](https://github.com/kubernetes/kubernetes/pull/66307), [@guoshimin](https://github.com/guoshimin))
- Fix the bug where image garbage collection is disabled by mistake. ([#66051](https://github.com/kubernetes/kubernetes/pull/66051), [@jiaxuanzhou](https://github.com/jiaxuanzhou))
- Fix a bug that preempting a pod may block forever. ([#65987](https://github.com/kubernetes/kubernetes/pull/65987), [@Random-Liu](https://github.com/Random-Liu))
- fixes the errors/warnings in fluentd configuration ([#67947](https://github.com/kubernetes/kubernetes/pull/67947), [@saravanan30erd](https://github.com/saravanan30erd))
- Fixed an issue which prevented `gcloud` from working on GCE when metadata concealment was enabled. ([#66630](https://github.com/kubernetes/kubernetes/pull/66630), [@dekkagaijin](https://github.com/dekkagaijin))
- Fix Stackdriver integration based on node annotation container.googleapis.com/instance_id. ([#66676](https://github.com/kubernetes/kubernetes/pull/66676), [@kawych](https://github.com/kawych))
- GCE: Fixes loadbalancer creation and deletion issues appearing in 1.10.5. ([#66400](https://github.com/kubernetes/kubernetes/pull/66400), [@nicksardo](https://github.com/nicksardo))
- Fixed exception detection in fluentd-gcp plugin. ([#65361](https://github.com/kubernetes/kubernetes/pull/65361), [@xperimental](https://github.com/xperimental))
- kubeadm:  Fix panic when node annotation is nil ([#67648](https://github.com/kubernetes/kubernetes/pull/67648), [@xlgao-zju](https://github.com/xlgao-zju))
- kubeadm: stop setting UID in the kubelet ConfigMap ([#66341](https://github.com/kubernetes/kubernetes/pull/66341), [@runiq](https://github.com/runiq))
- bazel deb package bugfix: The kubeadm deb package now reloads the kubelet after installation ([#65554](https://github.com/kubernetes/kubernetes/pull/65554), [@rdodev](https://github.com/rdodev))
- fix cluster-info dump error ([#66652](https://github.com/kubernetes/kubernetes/pull/66652), [@charrywanganthony](https://github.com/charrywanganthony))
- Fix kubelet startup failure when using ExecPlugin in kubeconfig ([#66395](https://github.com/kubernetes/kubernetes/pull/66395), [@awly](https://github.com/awly))
- kubectl: fixes a panic displaying pods with nominatedNodeName set ([#66406](https://github.com/kubernetes/kubernetes/pull/66406), [@liggitt](https://github.com/liggitt))
- prevents infinite CLI wait on delete when item is recreated ([#66136](https://github.com/kubernetes/kubernetes/pull/66136), [@deads2k](https://github.com/deads2k))
- Fix 'kubectl cp' with no arguments causes a panic ([#65482](https://github.com/kubernetes/kubernetes/pull/65482), [@wgliang](https://github.com/wgliang))
- Fixes the wrong elasticsearch node counter ([#65627](https://github.com/kubernetes/kubernetes/pull/65627), [@IvanovOleg](https://github.com/IvanovOleg))
- Fix an issue with dropped audit logs, when truncating and batch backends enabled at the same time. ([#65823](https://github.com/kubernetes/kubernetes/pull/65823), [@loburm](https://github.com/loburm))
- DaemonSet: Fix bug- daemonset didn't create pod after node have enough resource ([#67337](https://github.com/kubernetes/kubernetes/pull/67337), [@linyouchong](https://github.com/linyouchong))
- DaemonSet controller is now using backoff algorithm to avoid hot loops fighting with kubelet on pod recreation when a particular DaemonSet is misconfigured. ([#65309](https://github.com/kubernetes/kubernetes/pull/65309), [@tnozicka](https://github.com/tnozicka))
- Avoid creating new controller revisions for statefulsets when cache is stale ([#67039](https://github.com/kubernetes/kubernetes/pull/67039), [@mortent](https://github.com/mortent))
- Fixes issue when updating a DaemonSet causes a hash collision. ([#66476](https://github.com/kubernetes/kubernetes/pull/66476), [@mortent](https://github.com/mortent))
- fix rollout status for statefulsets ([#62943](https://github.com/kubernetes/kubernetes/pull/62943), [@faraazkhan](https://github.com/faraazkhan))
- fixes a validation error that could prevent updates to StatefulSet objects containing non-normalized resource requests ([#66165](https://github.com/kubernetes/kubernetes/pull/66165), [@liggitt](https://github.com/liggitt))
- Headless Services with no ports defined will now create Endpoints correctly, and appear in DNS. ([#67622](https://github.com/kubernetes/kubernetes/pull/67622), [@thockin](https://github.com/thockin))
- Prevent `resourceVersion` updates for custom resources on no-op writes. ([#67562](https://github.com/kubernetes/kubernetes/pull/67562), [@nikhita](https://github.com/nikhita))
- kube-controller-manager can now start the quota controller when discovery results can only be partially determined. ([#67433](https://github.com/kubernetes/kubernetes/pull/67433), [@deads2k](https://github.com/deads2k))
- Immediately close the other side of the connection when proxying. ([#67288](https://github.com/kubernetes/kubernetes/pull/67288), [@MHBauer](https://github.com/MHBauer))
- kube-apiserver: fixes error creating system priority classes when starting multiple apiservers simultaneously ([#67372](https://github.com/kubernetes/kubernetes/pull/67372), [@tanshanshan](https://github.com/tanshanshan))
-  Forget rate limit when CRD establish controller successfully updated CRD condition ([#67370](https://github.com/kubernetes/kubernetes/pull/67370), [@yue9944882](https://github.com/yue9944882))
- fixes a panic when using a mutating webhook admission plugin with a DELETE operation ([#66425](https://github.com/kubernetes/kubernetes/pull/66425), [@liggitt](https://github.com/liggitt))
- Fix creation of custom resources when the CRD contains non-conventional pluralization and subresources ([#66249](https://github.com/kubernetes/kubernetes/pull/66249), [@deads2k](https://github.com/deads2k))
- Aadjusted http/2 buffer sizes for apiservers to prevent starvation issues between concurrent streams ([#67902](https://github.com/kubernetes/kubernetes/pull/67902), [@liggitt](https://github.com/liggitt))
- Fixed a bug that was blocking extensible error handling when serializing API responses error out. Previously, serialization failures always resulted in the status code of the original response being returned. Now, the following behavior occurs: ([#67041](https://github.com/kubernetes/kubernetes/pull/67041), [@tristanburgess](https://github.com/tristanburgess))
- Fixes issue where pod scheduling may fail when using local PVs and pod affinity and anti-affinity without the default StatefulSet OrderedReady pod management policy ([#67556](https://github.com/kubernetes/kubernetes/pull/67556), [@msau42](https://github.com/msau42))
- Fix panic when processing Azure HTTP response. ([#68210](https://github.com/kubernetes/kubernetes/pull/68210), [@feiskyer](https://github.com/feiskyer))
- Fix volume limit for EBS on m5 and c5 instance types ([#66397](https://github.com/kubernetes/kubernetes/pull/66397), [@gnufied](https://github.com/gnufied))
- Fix a bug on GCE that /etc/crictl.yaml is not generated when crictl is preloaded. ([#66877](https://github.com/kubernetes/kubernetes/pull/66877), [@Random-Liu](https://github.com/Random-Liu))
- Revert #63905: Setup dns servers and search domains for Windows Pods. DNS for Windows containers will be set by CNI plugins. ([#66587](https://github.com/kubernetes/kubernetes/pull/66587), [@feiskyer](https://github.com/feiskyer))
- Fix validation for HealthzBindAddress in kube-proxy when --healthz-port is set to 0 ([#66138](https://github.com/kubernetes/kubernetes/pull/66138), [@wsong](https://github.com/wsong))
- Fixes issue [#68899](https://github.com/kubernetes/kubernetes/issues/68899) where pods might schedule on an unschedulable node. ([#68984](https://github.com/kubernetes/kubernetes/issues/68984), [@k82cn](https://github.com/k82cn))

### Not Very Notable (that is, non-user-facing)

- Unit tests have been added for scopes and scope selectors in the quota spec ([#66351](https://github.com/kubernetes/kubernetes/pull/66351), [@vikaschoudhary16](https://github.com/vikaschoudhary16)) Courtesy of SIG Node, and SIG Scheduling
- kubelet v1beta1 external ComponentConfig types are now available in the `k8s.io/kubelet` repo ([#67263](https://github.com/kubernetes/kubernetes/pull/67263), [@luxas](https://github.com/luxas)) Courtesy of SIG Cluster Lifecycle, SIG Node, SIG Scheduling, and SIG Testing
- Use sync.map to scale ecache better ([#66862](https://github.com/kubernetes/kubernetes/pull/66862), [@resouer](https://github.com/resouer))
- Extender preemption should respect IsInterested() ([#66291](https://github.com/kubernetes/kubernetes/pull/66291), [@resouer](https://github.com/resouer))
- This PR will leverage subtests on the existing table tests for the scheduler units. ([#63665](https://github.com/kubernetes/kubernetes/pull/63665), [@xchapter7x](https://github.com/xchapter7x))
- This PR will leverage subtests on the existing table tests for the scheduler units. ([#63666](https://github.com/kubernetes/kubernetes/pull/63666), [@xchapter7x](https://github.com/xchapter7x))
- Re-adds `pkg/generated/bindata.go` to the repository to allow some parts of k8s.io/kubernetes to be go-vendorable. ([#65985](https://github.com/kubernetes/kubernetes/pull/65985), [@ixdy](https://github.com/ixdy))
- If `TaintNodesByCondition` enabled, taint node with `TaintNodeUnschedulable` when initializing node to avoid race condition.
([#63955](https://github.com/kubernetes/kubernetes/pull/63955), [@k82cn](https://github.com/k82cn))
- Remove rescheduler since scheduling DS pods by default scheduler is moving to beta. ([#67687](https://github.com/kubernetes/kubernetes/pull/67687), [@Lion-Wei](https://github.com/Lion-Wei))
- kubeadm: make sure pre-pulled kube-proxy image and the one specified in its daemon set manifest are the same ([#67131](https://github.com/kubernetes/kubernetes/pull/67131), [@rosti](https://github.com/rosti))
- kubeadm: remove misleading error message regarding image pulling ([#66658](https://github.com/kubernetes/kubernetes/pull/66658), [@dixudx](https://github.com/dixudx))
- kubeadm: Pull sidecar and dnsmasq-nanny images when using kube-dns ([#66499](https://github.com/kubernetes/kubernetes/pull/66499), [@rosti](https://github.com/rosti))
- kubeadm: Fix pause image to not use architecture, as it is a manifest list ([#65920](https://github.com/kubernetes/kubernetes/pull/65920), [@dims](https://github.com/dims))
- kubeadm: Remove usage of `PersistentVolumeLabel` ([#65827](https://github.com/kubernetes/kubernetes/pull/65827), [@xlgao-zju](https://github.com/xlgao-zju))
- kubeadm: Add a `v1alpha3` API. This change creates a v1alpha3 API that is initially a duplicate of v1alpha2. ([#65629](https://github.com/kubernetes/kubernetes/pull/65629), [@luxas](https://github.com/luxas))
- Improved error message when checking the rollout status of StatefulSet with OnDelete strategy type. ([#66983](https://github.com/kubernetes/kubernetes/pull/66983), [@mortent](https://github.com/mortent))
- Defaults for file audit logging backend in batch mode changed: ([#67223](https://github.com/kubernetes/kubernetes/pull/67223), [@tallclair](https://github.com/tallclair))
- Role, ClusterRole and their bindings for cloud-provider is put under system namespace. Their addonmanager mode switches to EnsureExists. ([#67224](https://github.com/kubernetes/kubernetes/pull/67224), [@grayluck](https://github.com/grayluck))
- Don't let aggregated apiservers fail to launch if the external-apiserver-authentication configmap is not found in the cluster. ([#67836](https://github.com/kubernetes/kubernetes/pull/67836), [@sttts](https://github.com/sttts))
- Always create configmaps/extensions-apiserver-authentication from kube-apiserver. ([#67694](https://github.com/kubernetes/kubernetes/pull/67694), [@sttts](https://github.com/sttts))
- Switched certificate data replacement from "REDACTED" to "DATA+OMITTED" ([#66023](https://github.com/kubernetes/kubernetes/pull/66023), [@ibrasho](https://github.com/ibrasho))
- Decrease the amount of time it takes to modify kubeconfig files with large amounts of contexts ([#67093](https://github.com/kubernetes/kubernetes/pull/67093), [@juanvallejo](https://github.com/juanvallejo))
- Make EBS volume expansion faster ([#66728](https://github.com/kubernetes/kubernetes/pull/66728), [@gnufied](https://github.com/gnufied))
- Remove unused binary and container image for kube-aggregator. The functionality is already integrated into the kube-apiserver. ([#67157](https://github.com/kubernetes/kubernetes/pull/67157), [@dims](https://github.com/dims))
- kube-controller-manager now uses the informer cache instead of active pod gets in HPA controller ([#68241](https://github.com/kubernetes/kubernetes/pull/68241), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- Replace scale down forbidden window with scale down stabilization window. Rather than waiting a fixed period of time between scale downs HPA now scales down to the highest recommendation it during the scale down stabilization window. ([#68122](https://github.com/kubernetes/kubernetes/pull/68122), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- Improve CPU sample sanitization in HPA by taking metric's freshness into account. ([#68068](https://github.com/kubernetes/kubernetes/pull/68068), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- Replace scale up forbidden window with disregarding CPU samples collected when pod was initializing. ([#67252](https://github.com/kubernetes/kubernetes/pull/67252), [@jbartosik](https://github.com/jbartosik))
- [e2e] verifying LimitRange update is effective before creating new pod ([#68171](https://github.com/kubernetes/kubernetes/pull/68171), [@dixudx](https://github.com/dixudx))
- Port 31337 will be used by fluentd ([#68051](https://github.com/kubernetes/kubernetes/pull/68051), [@Szetty](https://github.com/Szetty))
- Fix flexvolume in containarized kubelets ([#65549](https://github.com/kubernetes/kubernetes/pull/65549), [@gnufied](https://github.com/gnufied))
- The check for unsupported plugins during volume resize has been moved from the admission controller to the two controllers that handle volume resize. ([#66780](https://github.com/kubernetes/kubernetes/pull/66780), [@kangarlou](https://github.com/kangarlou))
- kubeadm: remove redundant flags settings for kubelet ([#64682](https://github.com/kubernetes/kubernetes/pull/64682), [@dixudx](https://github.com/dixudx))
- Set “priorityClassName: system-node-critical” on kube-proxy manifest by default. ([#60150](https://github.com/kubernetes/kubernetes/pull/60150), [@MrHohn](https://github.com/MrHohn))
- kube-proxy v1beta1 external ComponentConfig types are now available in the `k8s.io/kube-proxy` repo ([#67688](https://github.com/kubernetes/kubernetes/pull/67688), [@Lion-Wei](https://github.com/Lion-Wei))
- add missing LastTransitionTime of ContainerReady condition ([#64867](https://github.com/kubernetes/kubernetes/pull/64867), [@dixudx](https://github.com/dixudx))

##  External Dependencies

- Default etcd server version is unchanged from v1.11: v3.2.18 ([#61198](https://github.com/kubernetes/kubernetes/pull/61198))
- Rescheduler is unchanged from v1.11: v0.4.0 ([#65454](https://github.com/kubernetes/kubernetes/pull/65454))
- The validated docker versions are the same as for v1.10: 1.11.2 to 1.13.1 and 17.03.x 
- The Go version is go1.10.3, as compared to go10.2 in v1.11. ([#65726](https://github.com/kubernetes/kubernetes/pull/65726), [@ixdy](https://github.com/ixdy))
- The minimum supported go is the same as for v1.10: go1.9.1. ([#55301](https://github.com/kubernetes/kubernetes/pull/55301))
- CNI is unchanged from v1.10: v0.6.0 ([#51250](https://github.com/kubernetes/kubernetes/pull/51250))
- CSI is unchanged from v1.11:  0.3.0 ([#64719](https://github.com/kubernetes/kubernetes/pull/64719))
- The dashboard add-on unchanged from v1.10: v1.8.3. ([#57326](https://github.com/kubernetes/kubernetes/pull/57326))
- Bump Heapster to v1.6.0-beta as compared to v1.5.2 in v1.11  ([#67074](https://github.com/kubernetes/kubernetes/pull/67074))
Cluster Autoscaler has been upgraded to version to v1.3.2-beta.2 from v1.3.0 in v1.11. See [release notes](https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.3.2-beta.2) for details. ([#67697](https://github.com/kubernetes/kubernetes/pull/67697))
- Kube-dns is unchanged from v1.11: v1.14.10 ([#62676](https://github.com/kubernetes/kubernetes/pull/62676))
- Influxdb is unchanged from v1.10: v1.3.3 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Grafana is unchanged from v1.10: v4.4.3 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Kibana is at v6.3.2.  ([#67582](https://github.com/kubernetes/kubernetes/pull/67582))
- CAdvisor is unchanged from v1.11:  v0.30.1 ([#64987](https://github.com/kubernetes/kubernetes/pull/64987))
- fluentd-gcp-scaler has been updated to v0.4.0, up from 0.3.0 in v1.11. ([#67691](https://github.com/kubernetes/kubernetes/pull/67691))
- fluentd in fluentd-es-image is unchanged from 1.10: v1.1.0 ([#58525](https://github.com/kubernetes/kubernetes/pull/58525))
- Fluentd in fluentd-elasticsearch is unchanged from v1.11:  v1.2.4 ([#67434](https://github.com/kubernetes/kubernetes/pull/67434))
- fluentd-elasticsearch is unchanged from 1.10: v2.0.4 ([#58525](https://github.com/kubernetes/kubernetes/pull/58525))
- The fluent-plugin-kubernetes_metadata_filter plugin in fluentd-elasticsearch has been downgraded to version 2.0.0 ([#67544](https://github.com/kubernetes/kubernetes/pull/67544))
- fluentd-gcp is unchanged from 1.10: v3.0.0. ([#60722](https://github.com/kubernetes/kubernetes/pull/60722))
- Ingress glbc is unchanged from 1.10: v1.0.0 ([#61302](https://github.com/kubernetes/kubernetes/pull/61302))
- OIDC authentication is unchanged from 1.10: coreos/go-oidc v2 ([#58544](https://github.com/kubernetes/kubernetes/pull/58544))
- Calico is unchanged from 1.10: v2.6.7 ([#59130](https://github.com/kubernetes/kubernetes/pull/59130))
- hcsshim is unchanged from v1.11, at v0.11 ([#64272](https://github.com/kubernetes/kubernetes/pull/64272))
- gitRepo volumes in pods no longer require git 1.8.5 or newer; older git versions are now supported. ([#62394](https://github.com/kubernetes/kubernetes/pull/62394))
- Upgraded crictl on GCE to v1.11.1, up from 1.11.0 on v1.11.  ([#66152](https://github.com/kubernetes/kubernetes/pull/66152))
CoreDNS has been updated to v1.2.2, up from v1.1.3 in v1.11 ([#68076](https://github.com/kubernetes/kubernetes/pull/68076))
- Setup dns servers and search domains for Windows Pods in dockershim. Docker EE version >= 17.10.0 is required for propagating DNS to containers. ([#63905](https://github.com/kubernetes/kubernetes/pull/63905))
- Istio addon is unchanged from v1.11, at  0.8.0. See [full Istio release notes](https://istio.io/about/notes/0.6.html) ([#64537](https://github.com/kubernetes/kubernetes/pull/64537))
- cadvisor godeps is unchanged from v1.11, at  v0.30.0 ([#64800](https://github.com/kubernetes/kubernetes/pull/64800))
- event-exporter to version v0.2.2, compared to v0.2.0 in v1.11. ([#66157](https://github.com/kubernetes/kubernetes/pull/66157))
- Rev the Azure SDK for networking to 2017-06-01 ([#61955](https://github.com/kubernetes/kubernetes/pull/61955))
- Es-image has been upgraded to Elasticsearch 6.3.2 ([#67484](https://github.com/kubernetes/kubernetes/pull/67484))
- metrics-server has been upgraded to v0.3.0. ([#68077](https://github.com/kubernetes/kubernetes/pull/68077))
- GLBC has been updated to v1.2.3 ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- Ingress-gce has been updated to v 1.2.0 ([#65641](https://github.com/kubernetes/kubernetes/pull/65641))
- ip-masq-agen has been updated to v2.1.1 ([#67916](https://github.com/kubernetes/kubernetes/pull/67916))
