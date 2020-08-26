## What’s New (Major Themes)

### Deprecation warnings

SIG API Machinery implemented [warnings when using deprecated APIs](https://kubernetes.io/docs/reference/using-api/deprecation-policy/#rest-resources-aka-api-objects)
that are visible to `kubectl` users and API consumers, and metrics visible to cluster administrators.
Requests to a deprecated API are returned with a warning containing a target removal release and any replacement API.
Warnings can also be returned by [admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#admissionreview-response-warning),
and specified for [deprecated versions of custom resources](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definition-versioning/#version-deprecation).

### Avoiding permanent beta

From Kubernetes 1.20 onwards, SIG Architecture will implement a new policy to transition all REST APIs out of beta within nine months. The idea behind the new policy is to avoid features staying in beta for a long time. Once a new API enters beta, it will have nine months to either:

 - reach GA, and deprecate the beta, or
 - have a new beta version _(and deprecate the previous beta)_.

If a REST API reaches the end of that nine-month countdown, then the next Kubernetes release will deprecate that API version. More information can be found on [the Kubernetes Blog](https://kubernetes.io/blog/2020/08/21/moving-forward-from-beta/).

### Expanded CLI support for debugging workloads and nodes

SIG CLI expanded on debugging with `kubectl` to support two new debugging workflows: debugging workloads by creating a copy, and debugging nodes by creating a container in host namespaces. These can be convenient to:
 - Insert a debug container in clusters that don’t have ephemeral containers enabled 
 - Modify a crashing container for easier debugging by changing its image, for example to busybox, or its command, for example, to `sleep 1d` so you have time to `kubectl exec`.
 - Inspect configuration files on a node's host filesystem

Since these new workflows don’t require any new cluster features, they’re available for experimentation with your existing clusters via `kubectl alpha debug`. We’d love to hear your feedback on debugging with `kubectl`. Reach us by opening an issue, visiting [#sig-cli](https://kubernetes.slack.com/messages/sig-cli) or commenting on enhancement [#1441](https://features.k8s.io/1441).

### Structured logging

SIG Instrumentation standardized the structure of log messages and references to Kubernetes objects. Structured logging makes parsing, processing, storing, querying and analyzing logs easier. New methods in the klog library enforce log message structure.

### EndpointSlices are now enabled by default

EndpointSlices are an exciting new API that provides a scalable and extensible alternative to the Endpoints API. EndpointSlices track IP addresses, ports, readiness, and topology information for Pods backing a Service.

In Kubernetes 1.19 this feature will be enabled by default with kube-proxy reading from EndpointSlices instead of Endpoints. Although this will mostly be an invisible change, it should result in noticeable scalability improvements in large clusters. It will also enable significant new features in future Kubernetes releases like Topology Aware Routing.

### Ingress graduates to General Availability

SIG Network has graduated the widely used [Ingress API](https://kubernetes.io/docs/concepts/services-networking/ingress/) to general availability in Kubernetes 1.19. This change recognises years of hard work by Kubernetes contributors, and paves the way for further work on future networking APIs in Kubernetes.

### seccomp graduates to General Availability

The seccomp (secure computing mode) support for Kubernetes has graduated to General Availability (GA). This feature can be used to increase the workload security by restricting the system calls for a Pod (applies to all containers) or single containers.

Technically this means that a first class `seccompProfile` field has been added to the Pod and Container `securityContext` objects:

```yaml
securityContext:
  seccompProfile:
    type: RuntimeDefault|Localhost|Unconfined # choose one of the three
    localhostProfile: my-profiles/profile-allow.json # only necessary if type == Localhost
```

The support for `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io/...` annotations are now deprecated, and will be removed in Kubernetes v1.22.0. Right now, an automatic version skew handling will convert the new field into the annotations and vice versa. This means there is no action required for converting existing workloads in a cluster.

You can find more information about how to restrict container system calls with seccomp in the new [documentation page on Kubernetes.io][seccomp-docs]

[seccomp-docs]: https://kubernetes.io/docs/tutorials/clusters/seccomp/


### Production images moved to community control

As of Kuberenetes v1.19, Kubernetes container images are stored on a community-controlled storage bucket, 
located at `{asia,eu,us}.gcr.io/k8s-artifacts-prod`. The `k8s.gcr.io` vanity domain has been updated 
to this new bucket. This brings production artifacts under community control.

### KubeSchedulerConfiguration graduates to Beta

SIG Scheduling graduates `KubeSchedulerConfiguration` to Beta. The [KubeSchedulerConfiguration](https://kubernetes.io/docs/reference/scheduling/config) feature allows you to tune the algorithms and other settings of the kube-scheduler. You can easily enable or disable specific functionality (contained in plugins) in selected scheduling phases without having to rewrite the rest of the configuration. Furthermore, a single kube-scheduler instance can serve different configurations, called profiles. Pods can select the profile they want to be scheduled under via the `.spec.schedulerName` field.

### CSI Migration - AzureDisk and vSphere (beta)
 
In-tree volume plugins and all cloud provider dependencies are being moved out of the Kubernetes core. The CSI migration feature allows existing volumes using the legacy APIs to continue to function even when the code has been removed, by routing all the volume operations to the respective CSI driver. The AzureDisk and vSphere implementations of this feature have been promoted to beta.

### Storage capacity tracking

Traditionally, the Kubernetes scheduler was based on the assumption that additional persistent storage is available everywhere in the cluster and has infinite capacity. Topology constraints addressed the first point, but up to now pod scheduling was still done without considering that the remaining storage capacity may not be enough to start a new pod. [Storage capacity tracking](https://github.com/kubernetes/enhancements/tree/master/keps/sig-storage/1472-storage-capacity-tracking), a new alpha feature, addresses that by adding an API for a CSI driver to report storage capacity and uses that information in the Kubernetes scheduler when choosing a node for a pod. This feature serves as a stepping stone for supporting dynamic provisioning for local volumes and other volume types that are more capacity constrained.

### CSI Volume health monitoring
 
The alpha version of CSI health monitoring is being released with Kubernetes 1.19. This feature enables CSI Drivers to share abnormal volume conditions from the underlying storage systems with Kubernetes so that they can be reported as events on PVCs or Pods. This feature serves as a stepping stone towards programmatic detection and resolution of individual volume health issues by Kubernetes.

### General ephemeral volumes

Kubernetes provides volume plugins whose lifecycle is tied to a pod and can be used as scratch space (e.g. the builtin “empty dir” volume type) or to load some data in to a pod (e.g. the builtin ConfigMap and Secret volume types or “CSI inline volumes”). The new [generic ephemeral volumes](https://github.com/kubernetes/enhancements/tree/master/keps/sig-storage/1698-generic-ephemeral-volumes) alpha feature allows any existing storage driver that supports dynamic provisioning to be used as an ephemeral volume with the volume’s lifecycle bound to the Pod.
 - It can be used to provide scratch storage that is different from the root disk, for example persistent memory, or a separate local disk on that node.
 - All StorageClass parameters for volume provisioning are supported.
 - All features supported with PersistentVolumeClaims are supported, such as storage capacity tracking, snapshots and restore, and volume resizing.

### Immutable Secrets and ConfigMaps (beta)

Secret and ConfigMap volumes can be marked as immutable, which significantly reduces load on the API server if there are many Secret and ConfigMap volumes in the cluster.
See [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) and [Secret](https://kubernetes.io/docs/concepts/configuration/secret/) for more information.

### CSI Proxy for Windows

The CSI Proxy for Windows is being promoted to beta along with the 1.19 release. This CSI Proxy enables CSI Drivers to run on Windows by allowing containers in Windows to perform privileged storage operations. At beta, the CSI Proxy for Windows supports storage drivers using direct attached disks and SMB.

### Dashboard v2

SIG UI has released v2 of the Kubernetes Dashboard add-on. You can find the most recent release in the [kubernetes/dashboard](https://github.com/kubernetes/dashboard/releases) repository. Kubernetes Dashboard now includes CRD support, new translations, and an updated version of AngularJS.

### Windows containerd support graduates to beta

Initially introduced in Kubernetes 1.18, Windows containerd support goes to Beta on this release. This includes the added support for Windows Server version 2004 (complete version compatibility can be found in the [documentation for Windows](https://kubernetes.io/docs/setup/production-environment/windows/intro-windows-in-kubernetes/#cri-containerd)).

SIG Windows is also including several addition to this release:
 - Direct Server Return (DSR) mode support, allowing large numbers of services to scale up efficiently
 - Windows containers  now honor CPU limits
 - Performance improvements for collections of metrics and summary

### Increase the Kubernetes support window to one year

As of Kubernetes 1.19, bugfix support via patch releases for a Kubernetes minor release has increased from 9 months to 1 year.

A survey conducted in early 2019 by the working group (WG) Long Term Support (LTS) showed that a significant subset of Kubernetes end-users fail to upgrade within the previous 9-month support period. 
A yearly support period provides the cushion end-users appear to desire, and is more in harmony with familiar annual planning cycles.

## Known Issues

The new storage capacity tracking alpha feature is known to be affected by a limitation of the WaitForFirstConsumer volume binding mode: [#94217](https://github.com/kubernetes/kubernetes/issues/94217)

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- ACTION REQUIRED: Switch core master base images (kube-controller-manager) from debian to distroless. If you need Flex Volumes support using scripts, please build your own image with required packages (like bash) ([#91329](https://github.com/kubernetes/kubernetes/pull/91329), [@dims](https://github.com/dims)) [SIG Cloud Provider, Release, Storage and Testing]
- ACTION REQUIRED: Support for basic authentication via the --basic-auth-file flag has been removed.  Users should migrate to --token-auth-file for similar functionality. ([#89069](https://github.com/kubernetes/kubernetes/pull/89069), [@enj](https://github.com/enj)) [SIG API Machinery]
 - Azure blob disk feature(`kind`: `Shared`, `Dedicated`) has been deprecated, you should use `kind`: `Managed` in `kubernetes.io/azure-disk` storage class. ([#92905](https://github.com/kubernetes/kubernetes/pull/92905), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
 - CVE-2020-8559 (Medium): Privilege escalation from compromised node to cluster. See https://github.com/kubernetes/kubernetes/issues/92914 for more details.
  The API Server will no longer proxy non-101 responses for upgrade requests. This could break proxied backends (such as an extension API server) that respond to upgrade requests with a non-101 response code. ([#92941](https://github.com/kubernetes/kubernetes/pull/92941), [@tallclair](https://github.com/tallclair)) [SIG API Machinery]
 - Kubeadm does not set the deprecated '--cgroup-driver' flag in /var/lib/kubelet/kubeadm-flags.env, it will be set in the kubelet config.yaml. If you have this flag in /var/lib/kubelet/kubeadm-flags.env or /etc/default/kubelet (/etc/sysconfig/kubelet for RPMs) please remove it and set the value using KubeletConfiguration ([#90513](https://github.com/kubernetes/kubernetes/pull/90513), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
 - Kubeadm now respects user specified etcd versions in the ClusterConfiguration and properly uses them. If users do not want to stick to the version specified in the ClusterConfiguration, they should edit the kubeadm-config config map and delete it. ([#89588](https://github.com/kubernetes/kubernetes/pull/89588), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
 - Kubeadm respects resolvConf value set by user even if systemd-resolved service is active. kubeadm no longer sets the flag in '--resolv-conf' in /var/lib/kubelet/kubeadm-flags.env. If you have this flag in /var/lib/kubelet/kubeadm-flags.env or /etc/default/kubelet (/etc/sysconfig/kubelet for RPMs) please remove it and set the value using KubeletConfiguration ([#90394](https://github.com/kubernetes/kubernetes/pull/90394), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
 - Kubeadm: Move the "kubeadm init" phase "kubelet-start" later in the init workflow, after the "kubeconfig" phase. This makes kubeadm start the kubelet only after the KubeletConfiguration component config file (/var/lib/kubelet/config.yaml) is generated and solves a problem where init systems like OpenRC cannot crashloop the kubelet service. ([#90892](https://github.com/kubernetes/kubernetes/pull/90892), [@xphoniex](https://github.com/xphoniex)) [SIG Cluster Lifecycle]
 - The 'kubeadm config upload' command is finally removed after a full GA deprecation cycle. If you still use it, please, use 'kubeadm init phase upload-config' instead ([#92610](https://github.com/kubernetes/kubernetes/pull/92610), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
 - Upgrade kubescheduler.config.k8s.io/v1alpha2 to kubescheduler.config.k8s.io/v1beta1
  
   - `.bindTimeoutSeconds` was moved as part of plugin args for `VolumeBinding`,
     which can be configured separately per [profile](&#35;profiles).
   - `.extenders` are updated to satisfy API standards. In particular:
     - `.extenders` decoding is case sensitive. All fields are affected.
     - `.extenders[*].httpTimeout` is of type `metav1.Duration`.
     - `.extenders[*].enableHttps` is renamed to `.extenders[*].enableHTTPS`.
   - `RequestedToCapacityRatio` args decoding is case sensitive. All fields are affected.
   - `DefaultPodTopologySpread` [plugin](&#35;scheduling-plugins) is renamed to `SelectorSpread`.
   - `Unreserve` extension point is removed from Profile definition. All `Reserve`
     plugins implement an `Unreserve` call.
   - `.disablePreemption` was removed. Users can disable preemption by disabling the
     "DefaultPreemption" PostFilter plugin. ([#91420](https://github.com/kubernetes/kubernetes/pull/91420), [@pancernik](https://github.com/pancernik)) [SIG Scheduling]
 
## Changes by Kind

### Deprecation

- Added support for vSphere in-tree volumes migration to vSphere CSI driver. The in-tree vSphere Volume plugin will be deprecated and removed in a future release.
  
  Users that self-deploy Kubernetes on vSphere should enable CSIMigration + CSIMigrationvSphere features and install the vSphere CSI Driver (https://github.com/kubernetes-sigs/vsphere-csi-driver) to avoid disruption to existing Pod and PVC objects at that time. Users should start using the vSphere CSI driver directly for any new volumes.
  
  The CSI Migration feature for vSphere Volume also requires minimum vSphere vCenter/ESXi Version to be 7.0u1 and minimum HW Version to be VM version 15.
  
  vSAN raw policy parameter is deprecated for the in-tree vSphere Volume plugin and will be removed in a future release. ([#90911](https://github.com/kubernetes/kubernetes/pull/90911), [@divyenpatel](https://github.com/divyenpatel)) [SIG API Machinery, Node and Storage]
- Apiextensions.k8s.io/v1beta1 is deprecated in favor of apiextensions.k8s.io/v1 ([#90673](https://github.com/kubernetes/kubernetes/pull/90673), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- Apiregistration.k8s.io/v1beta1 is deprecated in favor of apiregistration.k8s.io/v1 ([#90672](https://github.com/kubernetes/kubernetes/pull/90672), [@deads2k](https://github.com/deads2k)) [SIG API Machinery]
- Authentication.k8s.io/v1beta1 and authorization.k8s.io/v1beta1 are deprecated in 1.19 in favor of v1 levels and will be removed in 1.22 ([#90458](https://github.com/kubernetes/kubernetes/pull/90458), [@deads2k](https://github.com/deads2k)) [SIG API Machinery and Auth]
- Autoscaling/v2beta1 is deprecated in favor of autoscaling/v2beta2 ([#90463](https://github.com/kubernetes/kubernetes/pull/90463), [@deads2k](https://github.com/deads2k)) [SIG Autoscaling]
- Coordination.k8s.io/v1beta1 is deprecated in 1.19, targeted for removal in 1.22, use v1 instead. ([#90559](https://github.com/kubernetes/kubernetes/pull/90559), [@deads2k](https://github.com/deads2k)) [SIG Scalability]
- Ensure that volume capability and staging target fields are present in nodeExpansion CSI calls

  Behaviour of NodeExpandVolume being called between NodeStage and NodePublish is deprecated for CSI volumes. CSI drivers should support calling NodeExpandVolume after NodePublish if they have node EXPAND_VOLUME capability ([#86968](https://github.com/kubernetes/kubernetes/pull/86968), [@gnufied](https://github.com/gnufied)) [SIG Storage]
- Feat: azure disk migration go beta in 1.19. Feature gates CSIMigration to Beta (on by default) and CSIMigrationAzureDisk to Beta (off by default since it requires installation of the AzureDisk CSI Driver)
  The in-tree AzureDisk plugin "kubernetes.io/azure-disk" is now deprecated and will be removed in 1.23. Users should enable CSIMigration + CSIMigrationAzureDisk features and install the AzureDisk CSI Driver (https://github.com/kubernetes-sigs/azuredisk-csi-driver) to avoid disruption to existing Pod and PVC objects at that time.
  Users should start using the AzureDisk CSI Driver directly for any new volumes. ([#90896](https://github.com/kubernetes/kubernetes/pull/90896), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Kube-apiserver: the componentstatus API is deprecated. This API provided status of etcd, kube-scheduler, and kube-controller-manager components, but only worked when those components were local to the API server, and when kube-scheduler and kube-controller-manager exposed unsecured health endpoints. Instead of this API, etcd health is included in the kube-apiserver health check and kube-scheduler/kube-controller-manager health checks can be made directly against those components' health endpoints. ([#93570](https://github.com/kubernetes/kubernetes/pull/93570), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Apps and Cluster Lifecycle]
- Kubeadm: `kubeadm config view` command has been deprecated and will be removed in a feature release, please use `kubectl get cm -o yaml -n kube-system kubeadm-config` to get the kubeadm config directly ([#92740](https://github.com/kubernetes/kubernetes/pull/92740), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: deprecate the "kubeadm alpha kubelet config enable-dynamic" command. To continue using the feature please defer to the guide for "Dynamic Kubelet Configuration" at k8s.io. ([#92881](https://github.com/kubernetes/kubernetes/pull/92881), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: deprecate the feature `--experimental-kustomize` in favor of `--experimental-patches`. The supported patch formats are the same as "kubectl patch". They are read as files from a directory and can be applied to kubeadm components during init/join/upgrade. Only patching of static Pods is supported for the time being. ([#92017](https://github.com/kubernetes/kubernetes/pull/92017), [@neolit123](https://github.com/neolit123))
- Kubeadm: remove the deprecated "--use-api" flag for "kubeadm alpha certs renew" ([#90143](https://github.com/kubernetes/kubernetes/pull/90143), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubernetes no longer supports building hyperkube images ([#88676](https://github.com/kubernetes/kubernetes/pull/88676), [@dims](https://github.com/dims)) [SIG Cluster Lifecycle and Release]
- Remove --export flag from kubectl get command. ([#88649](https://github.com/kubernetes/kubernetes/pull/88649), [@oke-py](https://github.com/oke-py)) [SIG CLI and Testing]
- Scheduler's alpha feature 'ResourceLimitsPriorityFunction' is completely removed due to lack of usage ([#91883](https://github.com/kubernetes/kubernetes/pull/91883), [@SataQiu](https://github.com/SataQiu)) [SIG Scheduling and Testing]
- Storage.k8s.io/v1beta1 is deprecated in favor of storage.k8s.io/v1 ([#90671](https://github.com/kubernetes/kubernetes/pull/90671), [@deads2k](https://github.com/deads2k)) [SIG Storage]

### API Change

- A new alpha-level field, `SupportsFsGroup`, has been introduced for CSIDrivers to allow them to specify whether they support volume ownership and permission modifications. The `CSIVolumeSupportFSGroup` feature gate must be enabled to allow this field to be used. ([#92001](https://github.com/kubernetes/kubernetes/pull/92001), [@huffmanca](https://github.com/huffmanca)) [SIG API Machinery, CLI and Storage]
- Added pod version skew strategy for seccomp profile to synchronize the deprecated annotations with the new API Server fields. Please see the corresponding section [in the KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/20190717-seccomp-ga.md&#35;version-skew-strategy) for more detailed explanations. ([#91408](https://github.com/kubernetes/kubernetes/pull/91408), [@saschagrunert](https://github.com/saschagrunert)) [SIG Apps, Auth, CLI and Node]
- Adds the ability to disable Accelerator/GPU metrics collected by Kubelet ([#91930](https://github.com/kubernetes/kubernetes/pull/91930), [@RenaudWasTaken](https://github.com/RenaudWasTaken)) [SIG Node]
- Admission webhooks can now return warning messages that are surfaced to API clients, using the `.response.warnings` field in the admission review response. ([#92667](https://github.com/kubernetes/kubernetes/pull/92667), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- CertificateSigningRequest API conditions were updated:
  - a `status` field was added; this field defaults to `True`, and may only be set to `True` for `Approved`, `Denied`, and `Failed` conditions
  - a `lastTransitionTime` field was added
  - a `Failed` condition type was added to allow signers to indicate permanent failure; this condition can be added via the `certificatesigningrequests/status` subresource.
  - `Approved` and `Denied` conditions are mutually exclusive
  - `Approved`, `Denied`, and `Failed` conditions can no longer be removed from a CSR ([#90191](https://github.com/kubernetes/kubernetes/pull/90191), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Apps, Auth, CLI and Node]
- Cluster admins can now turn off /logs endpoint in kubelet by setting enableSystemLogHandler to false in their kubelet configuration file. enableSystemLogHandler can be set to true only when enableDebuggingHandlers is also set to true. ([#87273](https://github.com/kubernetes/kubernetes/pull/87273), [@SaranBalaji90](https://github.com/SaranBalaji90)) [SIG Node]
- Custom Endpoints are now mirrored to EndpointSlices by a new EndpointSliceMirroring controller. ([#91637](https://github.com/kubernetes/kubernetes/pull/91637), [@robscott](https://github.com/robscott)) [SIG API Machinery, Apps, Auth, Cloud Provider, Instrumentation, Network and Testing]
- CustomResourceDefinitions added support for marking versions as deprecated by setting `spec.versions[*].deprecated` to `true`, and for optionally overriding the default deprecation warning with a `spec.versions[*].deprecationWarning` field. ([#92329](https://github.com/kubernetes/kubernetes/pull/92329), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
- EnvVarSource api doc bug fixes ([#91194](https://github.com/kubernetes/kubernetes/pull/91194), [@wawa0210](https://github.com/wawa0210)) [SIG Apps]
- Fix bug in reflector that couldn't recover from "Too large resource version" errors ([#92537](https://github.com/kubernetes/kubernetes/pull/92537), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery]
- Fixed: log timestamps now include trailing zeros to maintain a fixed width ([#91207](https://github.com/kubernetes/kubernetes/pull/91207), [@iamchuckss](https://github.com/iamchuckss)) [SIG Apps and Node]
- Generic ephemeral volumes, a new alpha feature under the `GenericEphemeralVolume` feature gate, provide a more flexible alternative to `EmptyDir` volumes: as with `EmptyDir`, volumes are created and deleted for each pod automatically by Kubernetes. But because the normal provisioning process is used (`PersistentVolumeClaim`), storage can be provided by third-party storage vendors and all of the usual volume features work. Volumes don't need to be empt; for example, restoring from snapshot is supported. ([#92784](https://github.com/kubernetes/kubernetes/pull/92784), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, CLI, Instrumentation, Node, Scheduling, Storage and Testing]
- Go1.14.4 is now the minimum version required for building Kubernetes ([#92438](https://github.com/kubernetes/kubernetes/pull/92438), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Storage and Testing]
- Hide managedFields from kubectl edit command ([#91946](https://github.com/kubernetes/kubernetes/pull/91946), [@soltysh](https://github.com/soltysh)) [SIG CLI]
- K8s.io/apimachinery - scheme.Convert() now uses only explicitly registered conversions - default reflection based conversion is no longer available. `+k8s:conversion-gen` tags can be used with the `k8s.io/code-generator` component to generate conversions. ([#90018](https://github.com/kubernetes/kubernetes/pull/90018), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery, Apps and Testing]
- Kube-proxy: add `--bind-address-hard-fail` flag to treat failure to bind to a port as fatal ([#89350](https://github.com/kubernetes/kubernetes/pull/89350), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle and Network]
- Kubebuilder validation tags are set on metav1.Condition for CRD generation ([#92660](https://github.com/kubernetes/kubernetes/pull/92660), [@damemi](https://github.com/damemi)) [SIG API Machinery]
- Kubelet's --runonce option is now also available in Kubelet's config file as `runOnce`. ([#89128](https://github.com/kubernetes/kubernetes/pull/89128), [@vincent178](https://github.com/vincent178)) [SIG Node]
- Kubelet: add '--logging-format' flag to support structured logging ([#91532](https://github.com/kubernetes/kubernetes/pull/91532), [@afrouzMashaykhi](https://github.com/afrouzMashaykhi)) [SIG API Machinery, Cluster Lifecycle, Instrumentation and Node]
- Kubernetes is now built with golang 1.15.0-rc.1.
  - The deprecated, legacy behavior of treating the CommonName field on X.509 serving certificates as a host name when no Subject Alternative Names are present is now disabled by default. It can be temporarily re-enabled by adding the value x509ignoreCN=0 to the GODEBUG environment variable. ([#93264](https://github.com/kubernetes/kubernetes/pull/93264), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scalability, Storage and Testing]
- Promote Immutable Secrets/ConfigMaps feature to Beta and enable the feature by default.
  This allows to set `Immutable` field in Secrets or ConfigMap object to mark their contents as immutable. ([#89594](https://github.com/kubernetes/kubernetes/pull/89594), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps and Testing]
- Remove `BindTimeoutSeconds` from schedule configuration `KubeSchedulerConfiguration` ([#91580](https://github.com/kubernetes/kubernetes/pull/91580), [@cofyc](https://github.com/cofyc)) [SIG Scheduling and Testing]
- Remove kubescheduler.config.k8s.io/v1alpha1 ([#89298](https://github.com/kubernetes/kubernetes/pull/89298), [@gavinfish](https://github.com/gavinfish)) [SIG Scheduling]
- Reserve plugins that fail to reserve will trigger the unreserve extension point ([#92391](https://github.com/kubernetes/kubernetes/pull/92391), [@adtac](https://github.com/adtac)) [SIG Scheduling and Testing]
- Resolve regression in `metadata.managedFields` handling in update/patch requests submitted by older API clients ([#91748](https://github.com/kubernetes/kubernetes/pull/91748), [@apelisse](https://github.com/apelisse))
- Scheduler: optionally check for available storage capacity before scheduling pods which have unbound volumes (alpha feature with the new `CSIStorageCapacity` feature gate, only works for CSI drivers and depends on support for the feature in a CSI driver deployment) ([#92387](https://github.com/kubernetes/kubernetes/pull/92387), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, Scheduling, Storage and Testing]
- Seccomp support has graduated to GA. A new `seccompProfile` field is added to pod and container securityContext objects. Support for `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io/...` annotations is deprecated, and will be removed in v1.22. ([#91381](https://github.com/kubernetes/kubernetes/pull/91381), [@pjbgf](https://github.com/pjbgf)) [SIG Apps, Auth, Node, Release, Scheduling and Testing]
- ServiceAppProtocol feature gate is now beta and enabled by default, adding new AppProtocol field to Services and Endpoints. ([#90023](https://github.com/kubernetes/kubernetes/pull/90023), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- SetHostnameAsFQDN is a new field in PodSpec. When set to true, the fully 
  qualified domain name (FQDN) of a Pod is set as hostname of its containers. 
  In Linux containers, this means setting the FQDN in the hostname field of the 
  kernel (the nodename field of struct utsname).  In Windows containers, this
  means setting the this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters to FQDN. 
  If a pod does not have FQDN, this has no effect. ([#91699](https://github.com/kubernetes/kubernetes/pull/91699), [@javidiaz](https://github.com/javidiaz)) [SIG Apps, Network, Node and Testing]
- The CertificateSigningRequest API is promoted to certificates.k8s.io/v1 with the following changes:
  - `spec.signerName` is now required, and requests for `kubernetes.io/legacy-unknown` are not allowed to be created via the `certificates.k8s.io/v1` API
  - `spec.usages` is now required, may not contain duplicate values, and must only contain known usages
  - `status.conditions` may not contain duplicate types
  - `status.conditions[*].status` is now required
  - `status.certificate` must be PEM-encoded, and contain only CERTIFICATE blocks ([#91685](https://github.com/kubernetes/kubernetes/pull/91685), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Architecture, Auth, CLI and Testing]
- The HugePageStorageMediumSize feature gate is now on by default allowing usage of multiple sizes huge page resources on a container level. ([#90592](https://github.com/kubernetes/kubernetes/pull/90592), [@bart0sh](https://github.com/bart0sh)) [SIG Node]
- The Kubelet's --node-status-max-images option is now available via the Kubelet config file field nodeStatusMaxImage ([#91275](https://github.com/kubernetes/kubernetes/pull/91275), [@knabben](https://github.com/knabben)) [SIG Node]
- The Kubelet's --seccomp-profile-root option is now marked as deprecated. ([#91182](https://github.com/kubernetes/kubernetes/pull/91182), [@knabben](https://github.com/knabben)) [SIG Node]
- The Kubelet's `--bootstrap-checkpoint-path` option is now removed. ([#91577](https://github.com/kubernetes/kubernetes/pull/91577), [@knabben](https://github.com/knabben)) [SIG Apps and Node]
- The Kubelet's `--cloud-provider` and `--cloud-config` options are now marked as deprecated. ([#90408](https://github.com/kubernetes/kubernetes/pull/90408), [@knabben](https://github.com/knabben)) [SIG Cloud Provider and Node]
- The Kubelet's `--enable-server` and `--provider-id` option is now available via the Kubelet config file field `enableServer` and `providerID` respectively. ([#90494](https://github.com/kubernetes/kubernetes/pull/90494), [@knabben](https://github.com/knabben)) [SIG Node]
- The Kubelet's `--kernel-memcg-notification` option is now available via the Kubelet config file field kernelMemcgNotification ([#91863](https://github.com/kubernetes/kubernetes/pull/91863), [@knabben](https://github.com/knabben)) [SIG Cloud Provider, Node and Testing]
- The Kubelet's `--really-crash-for-testing` and  `--chaos-chance` options are now marked as deprecated. ([#90499](https://github.com/kubernetes/kubernetes/pull/90499), [@knabben](https://github.com/knabben)) [SIG Node]
- The Kubelet's `--volume-plugin-dir` option is now available via the Kubelet config file field `VolumePluginDir`. ([#88480](https://github.com/kubernetes/kubernetes/pull/88480), [@savitharaghunathan](https://github.com/savitharaghunathan)) [SIG Node]
- The `DefaultIngressClass` feature is now GA. The `--feature-gate` parameter will be removed in 1.20. ([#91957](https://github.com/kubernetes/kubernetes/pull/91957), [@cmluciano](https://github.com/cmluciano)) [SIG API Machinery, Apps, Network and Testing]
- The alpha `DynamicAuditing` feature gate and `auditregistration.k8s.io/v1alpha1` API have been removed and are no longer supported. ([#91502](https://github.com/kubernetes/kubernetes/pull/91502), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Auth and Testing]
- The kube-controller-manager managed signers can now have distinct signing certificates and keys.  See the help about `--cluster-signing-[signer-name]-{cert,key}-file`.  `--cluster-signing-{cert,key}-file` is still the default. ([#90822](https://github.com/kubernetes/kubernetes/pull/90822), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Apps and Auth]
- The unused `series.state` field, deprecated since v1.14, is removed from the `events.k8s.io/v1beta1` and `v1` Event types. ([#90449](https://github.com/kubernetes/kubernetes/pull/90449), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps]
- Unreserve extension point for scheduler plugins is merged into Reserve extension point ([#92200](https://github.com/kubernetes/kubernetes/pull/92200), [@adtac](https://github.com/adtac)) [SIG Scheduling and Testing]
- Update Golang to v1.14.4 ([#88638](https://github.com/kubernetes/kubernetes/pull/88638), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Cloud Provider, Release and Testing]
- Updated the API documentation for Service.Spec.IPFamily to warn that its exact
  semantics will probably change before the dual-stack feature goes GA, and users
  should look at ClusterIP or Endpoints, not IPFamily, to figure out if an existing
  Service is IPv4, IPv6, or dual-stack. ([#91527](https://github.com/kubernetes/kubernetes/pull/91527), [@danwinship](https://github.com/danwinship)) [SIG Apps and Network]
- Users can configure a resource prefix to ignore a group of resources. ([#88842](https://github.com/kubernetes/kubernetes/pull/88842), [@angao](https://github.com/angao)) [SIG Node and Scheduling]
- `Ingress` and `IngressClass` resources have graduated to `networking.k8s.io/v1`. Ingress and IngressClass types in the `extensions/v1beta1` and `networking.k8s.io/v1beta1` API versions are deprecated and will no longer be served in 1.22+. Persisted objects can be accessed via the `networking.k8s.io/v1` API. Notable changes in v1 Ingress objects (v1beta1 field names are unchanged):
  - `spec.backend` -> `spec.defaultBackend`
  - `serviceName` -> `service.name`
  - `servicePort` -> `service.port.name` (for string values)
  - `servicePort` -> `service.port.number` (for numeric values)
  - `pathType` no longer has a default value in v1; "Exact", "Prefix", or "ImplementationSpecific" must be specified
  Other Ingress API updates:
  - backends can now be resource or service backends
  - `path` is no longer required to be a valid regular expression ([#89778](https://github.com/kubernetes/kubernetes/pull/89778), [@cmluciano](https://github.com/cmluciano)) [SIG API Machinery, Apps, CLI, Network and Testing]
- `NodeResourcesLeastAllocated` and `NodeResourcesMostAllocated` plugins now support customized weight on the CPU and memory. ([#90544](https://github.com/kubernetes/kubernetes/pull/90544), [@chendave](https://github.com/chendave)) [SIG Scheduling]
- `PostFilter` type is added to scheduler component config API on version v1beta1. ([#91547](https://github.com/kubernetes/kubernetes/pull/91547), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- `RequestedToCapacityRatioArgs` encoding is now strict ([#91603](https://github.com/kubernetes/kubernetes/pull/91603), [@pancernik](https://github.com/pancernik)) [SIG Scheduling]
- `v1beta1` Scheduler `Extender` encoding is case-sensitive (`v1alpha1`/`v1alpha2` was case-insensitive), its `httpTimeout` field uses duration encoding (for example, one second is specified as `"1s"`), and the `enableHttps` field in `v1alpha1`/`v1alpha2` was renamed to `enableHTTPS`. ([#91625](https://github.com/kubernetes/kubernetes/pull/91625), [@pancernik](https://github.com/pancernik)) [SIG Scheduling]

### Feature

- A defaultpreemption plugin is registered and enabled in scheduler which replaces the legacy hard-coded Pod preemption logic. ([#92049](https://github.com/kubernetes/kubernetes/pull/92049), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- A new extension point `PostFilter` is introduced to scheduler framework which runs after Filter phase to resolve scheduling filter failures. A typical implementation is running preemption logic. ([#91314](https://github.com/kubernetes/kubernetes/pull/91314), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- ACTION REQUIRED : In CoreDNS v1.7.0, [metrics names have been changed](https://github.com/coredns/coredns/blob/master/notes/coredns-1.7.0.md&#35;metric-changes) which will be backward incompatible with existing reporting formulas that use the old metrics' names. Adjust your formulas to the new names before upgrading. 
  
  Kubeadm now includes CoreDNS version v1.7.0. Some of the major changes include:
  -  Fixed a bug that could cause CoreDNS to stop updating service records.
  -  Fixed a bug in the forward plugin where only the first upstream server is always selected no matter which policy is set.
  -  Remove already deprecated options `resyncperiod` and `upstream` in the Kubernetes plugin.
  -  Includes Prometheus metrics name changes (to bring them in line with standard Prometheus metrics naming convention). They will be backward incompatible with existing reporting formulas that use the old metrics' names.
  -  The federation plugin (allows for v1 Kubernetes federation) has been removed.
  More details are available in https://coredns.io/2020/06/15/coredns-1.7.0-release/ ([#92651](https://github.com/kubernetes/kubernetes/pull/92651), [@rajansandeep](https://github.com/rajansandeep)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- API requests to deprecated versions now receive a warning header in the API response, and cause a metric indicating use of a deprecated API to be published:
  - `kubectl` outputs warnings to stderr, and accepts a `--warnings-as-errors` option to treat warnings as fatal errors
  - `k8s.io/client-go` outputs warnings to stderr by default; override this per-client by setting `config.WarningHandler`, or per-process with `rest.SetDefaultWarningHandler()`
  - `kube-apiserver` publishes `apiserver_requested_deprecated_apis` gauge metrics set to `1` for deprecated APIs which have been requested, with `group`, `version`, `resource`, `subresource`, and `removed_release` labels ([#73032](https://github.com/kubernetes/kubernetes/pull/73032), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, CLI, Instrumentation and Testing]
- Add --logging-format flag for component-base. Defaults to "text" using unchanged klog. ([#89683](https://github.com/kubernetes/kubernetes/pull/89683), [@yuzhiquan](https://github.com/yuzhiquan)) [SIG Instrumentation]
- Add --port flag to kubectl create deployment ([#91113](https://github.com/kubernetes/kubernetes/pull/91113), [@soltysh](https://github.com/soltysh)) [SIG CLI and Testing]
- Add .import-restrictions file to cmd/cloud-controller-manager. ([#90630](https://github.com/kubernetes/kubernetes/pull/90630), [@nilo19](https://github.com/nilo19)) [SIG API Machinery and Cloud Provider]
- Add Annotations to CRI-API ImageSpec objects. ([#90061](https://github.com/kubernetes/kubernetes/pull/90061), [@marosset](https://github.com/marosset)) [SIG Node and Windows]
- Add attempts label to scheduler's PodSchedulingDuration metric. ([#92650](https://github.com/kubernetes/kubernetes/pull/92650), [@ahg-g](https://github.com/ahg-g)) [SIG Instrumentation and Scheduling]
- Add client-side and server-side dry-run support to kubectl scale ([#89666](https://github.com/kubernetes/kubernetes/pull/89666), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- Add selectors to kubectl diff ([#90857](https://github.com/kubernetes/kubernetes/pull/90857), [@sethpollack](https://github.com/sethpollack)) [SIG CLI]
- Add support for cgroups v2 node validation ([#89901](https://github.com/kubernetes/kubernetes/pull/89901), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle and Node]
- Add support for pre allocated huge pages with different sizes, on node level ([#89252](https://github.com/kubernetes/kubernetes/pull/89252), [@odinuge](https://github.com/odinuge)) [SIG Apps and Node]
- Add tags support for Azure File Driver ([#92825](https://github.com/kubernetes/kubernetes/pull/92825), [@ZeroMagic](https://github.com/ZeroMagic)) [SIG Cloud Provider and Storage]
- Add tags support for azure disk driver ([#92356](https://github.com/kubernetes/kubernetes/pull/92356), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Added --privileged flag to kubectl run ([#90569](https://github.com/kubernetes/kubernetes/pull/90569), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Added a new `GetPreferredAllocation()` call to the `v1beta1` device plugin API. ([#92665](https://github.com/kubernetes/kubernetes/pull/92665), [@klueska](https://github.com/klueska)) [SIG Node and Testing]
- Added feature support to Windows for configuring session affinity of Kubernetes services.
  required: [Windows Server vNext Insider Preview Build 19551](https://blogs.windows.com/windowsexperience/2020/01/28/announcing-windows-server-vnext-insider-preview-build-19551/) (or higher) ([#91701](https://github.com/kubernetes/kubernetes/pull/91701), [@elweb9858](https://github.com/elweb9858)) [SIG Network and Windows]
- Added kube-apiserver metrics: apiserver_current_inflight_request_measures and, when API Priority and Fairness is enable, windowed_request_stats. ([#91177](https://github.com/kubernetes/kubernetes/pull/91177), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery, Instrumentation and Testing]
- Added service.beta.kubernetes.io/aws-load-balancer-target-node-labels annotation to target nodes in AWS LoadBalancer Services ([#90943](https://github.com/kubernetes/kubernetes/pull/90943), [@foobarfran](https://github.com/foobarfran)) [SIG Cloud Provider]
- Adding a set of debugging endpoints under prefix "/debug/flowcontrol/*" for dumping internal states of flow-control system with different granularity. ([#90967](https://github.com/kubernetes/kubernetes/pull/90967), [@yue9944882](https://github.com/yue9944882)) [SIG API Machinery]
- Adds profile label to kube-scheduler metric framework_extension_point_duration_seconds ([#92268](https://github.com/kubernetes/kubernetes/pull/92268), [@alculquicondor](https://github.com/alculquicondor)) [SIG Instrumentation and Scheduling]
- Adds profile label to kube-scheduler metric schedule_attempts_total
  - Adds result and profile label to e2e_scheduling_duration_seconds. Times for unschedulable and error attempts are now recorded. ([#92202](https://github.com/kubernetes/kubernetes/pull/92202), [@alculquicondor](https://github.com/alculquicondor)) [SIG Instrumentation and Scheduling]
- Audit events for API requests to deprecated API versions now include a `"k8s.io/deprecated": "true"` audit annotation. If a target removal release is identified, the audit event includes a `"k8s.io/removal-release": "<majorVersion>.<minorVersion>"` audit annotation as well. ([#92842](https://github.com/kubernetes/kubernetes/pull/92842), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Instrumentation]
- Bump Dashboard to v2.0.1 ([#91526](https://github.com/kubernetes/kubernetes/pull/91526), [@maciaszczykm](https://github.com/maciaszczykm)) [SIG Cloud Provider]
- Cloud node-controller use InstancesV2 ([#91319](https://github.com/kubernetes/kubernetes/pull/91319), [@gongguan](https://github.com/gongguan)) [SIG Apps, Cloud Provider, Scalability and Storage]
- Deps: Update to Golang 1.13.9
  - build: Remove kube-cross image building ([#89275](https://github.com/kubernetes/kubernetes/pull/89275), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]
- Detailed scheduler scoring result can be printed at verbose level 10. ([#89384](https://github.com/kubernetes/kubernetes/pull/89384), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- E2e.test can print the list of conformance tests that need to pass for the cluster to be conformant. ([#88924](https://github.com/kubernetes/kubernetes/pull/88924), [@dims](https://github.com/dims)) [SIG Architecture and Testing]
- Enable feature Gate DefaultPodTopologySpread to use PodTopologySpread plugin to do defaultspreading. In doing so, legacy DefaultPodTopologySpread plugin is disabled. ([#91793](https://github.com/kubernetes/kubernetes/pull/91793), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- EndpointSlice controller waits longer to retry failed sync. ([#89438](https://github.com/kubernetes/kubernetes/pull/89438), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Extend AWS azToRegion method to support Local Zones ([#90874](https://github.com/kubernetes/kubernetes/pull/90874), [@Jeffwan](https://github.com/Jeffwan)) [SIG Cloud Provider]
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
- Improves IPVS proxy performance by only running `EnsureDummyInterface` if the virtual server address is not binded already. ([#92609](https://github.com/kubernetes/kubernetes/pull/92609), [@andrewsykim](https://github.com/andrewsykim)) [SIG Network]
- Kube-Proxy now supports EndpointSlices on Windows with the EndpointSliceProxying feature gate. ([#90909](https://github.com/kubernetes/kubernetes/pull/90909), [@kumarvin123](https://github.com/kumarvin123)) [SIG Network and Windows]
- Kube-Proxy now supports IPv6DualStack on Windows with the IPv6DualStack feature gate. ([#90853](https://github.com/kubernetes/kubernetes/pull/90853), [@kumarvin123](https://github.com/kumarvin123)) [SIG Network, Node and Windows]
- Kube-addon-manager has been updated to v9.1.1 to allow overriding the default list of whitelisted resources (https://github.com/kubernetes/kubernetes/pull/91018) ([#91240](https://github.com/kubernetes/kubernetes/pull/91240), [@tosi3k](https://github.com/tosi3k)) [SIG Cloud Provider, Scalability and Testing]
- Kube-apiserver backed by etcd3 exports metric showing the database file size. ([#89151](https://github.com/kubernetes/kubernetes/pull/89151), [@jingyih](https://github.com/jingyih)) [SIG API Machinery]
- Kube-apiserver, kube-scheduler and kube-controller manager now use SO_REUSEPORT socket option when listening on address defined by --bind-address and --secure-port flags, when running on Unix systems (Windows is NOT supported). This allows to run multiple instances of those processes on a single host with the same configuration, which allows to update/restart them in a graceful way, without causing downtime. ([#88893](https://github.com/kubernetes/kubernetes/pull/88893), [@invidian](https://github.com/invidian)) [SIG API Machinery, Scheduling and Testing]
- Kube-apiserver: The NodeRestriction admission plugin now restricts Node labels kubelets are permitted to set when creating a new Node to the `--node-labels` parameters accepted by kubelets in 1.16+. ([#90307](https://github.com/kubernetes/kubernetes/pull/90307), [@liggitt](https://github.com/liggitt)) [SIG Auth and Node]
- Kube-controller-manager: add '--logging-format' flag to support structured logging ([#91521](https://github.com/kubernetes/kubernetes/pull/91521), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery and Instrumentation]
- Kube-controller-manager: the `--experimental-cluster-signing-duration` flag is marked as deprecated for removal in v1.22, and is replaced with `--cluster-signing-duration`. ([#91154](https://github.com/kubernetes/kubernetes/pull/91154), [@liggitt](https://github.com/liggitt)) [SIG Auth and Cloud Provider]
- Kube-proxy now consumes EndpointSlices instead of Endpoints by default on Linux. A new alpha `WindowsEndpointSliceProxying` feature gate allows the feature to be enabled on Windows. ([#92736](https://github.com/kubernetes/kubernetes/pull/92736), [@robscott](https://github.com/robscott)) [SIG Network]
- Kube-scheduler: add '--logging-format' flag to support structured logging ([#91522](https://github.com/kubernetes/kubernetes/pull/91522), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery, Cluster Lifecycle, Instrumentation and Scheduling]
- Kubeadm now distinguishes between generated and user supplied component configs, regenerating the former ones if a config upgrade is required ([#86070](https://github.com/kubernetes/kubernetes/pull/86070), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: Allow manually upgraded component configs to be supplied in a YAML file via the --config option during upgrade plan & apply. The old behavior of --config in which kubeadm configuration and component configs that overwrite everything cluster stored is preserved too. The behavior to use with --config is now determined based on whether kubeadm config API objects (API group "kubeadm.kubernetes.io") were supplied in the file or not. ([#91980](https://github.com/kubernetes/kubernetes/pull/91980), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: add startup probes for static Pods to protect slow starting containers ([#91179](https://github.com/kubernetes/kubernetes/pull/91179), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: deprecate the "--csr-only" and "--csr-dir" flags of the "kubeadm init phase certs" subcommands. Please use "kubeadm alpha certs generate-csr" instead. This new command allows you to generate new private keys and certificate signing requests for all the control-plane components, so that the certificates can be signed by an external CA. ([#92183](https://github.com/kubernetes/kubernetes/pull/92183), [@wallrj](https://github.com/wallrj)) [SIG Cluster Lifecycle]
- Kubeadm: during 'upgrade apply', if the kube-proxy ConfigMap is missing, assume that kube-proxy should not be upgraded. Same applies to a missing kube-dns/coredns ConfigMap for the DNS server addon. Note that this is a temporary workaround until 'upgrade apply' supports phases. Once phases are supported the kube-proxy/dns upgrade should be skipped manually. ([#89593](https://github.com/kubernetes/kubernetes/pull/89593), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: switch control-plane static Pods to the "system-node-critical" priority class ([#90063](https://github.com/kubernetes/kubernetes/pull/90063), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: upgrade plan now prints a table indicating the state of known component configs prior to upgrade ([#88124](https://github.com/kubernetes/kubernetes/pull/88124), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubectl supports taint no without specifying(without having to type the full resource name) ([#88723](https://github.com/kubernetes/kubernetes/pull/88723), [@wawa0210](https://github.com/wawa0210)) [SIG CLI]
- Kubelet: following metrics have been renamed:
  kubelet_running_container_count --> kubelet_running_containers
  kubelet_running_pod_count --> kubelet_running_pods ([#92407](https://github.com/kubernetes/kubernetes/pull/92407), [@RainbowMango](https://github.com/RainbowMango)) [SIG API Machinery, Cluster Lifecycle, Instrumentation and Node]
- Kubelets configured to rotate client certificates now publish a `certificate_manager_server_ttl_seconds` gauge metric indicating the remaining seconds until certificate expiration. ([#91148](https://github.com/kubernetes/kubernetes/pull/91148), [@liggitt](https://github.com/liggitt)) [SIG Auth and Node]
- New scoring for PodTopologySpreading that yields better spreading ([#90475](https://github.com/kubernetes/kubernetes/pull/90475), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- No actions required. This is a small enhancement to a utility library. ([#92440](https://github.com/kubernetes/kubernetes/pull/92440), [@luigibk](https://github.com/luigibk)) [SIG Network]
- PodTolerationRestriction: Mention Whitelist Scope in Error ([#87582](https://github.com/kubernetes/kubernetes/pull/87582), [@mrueg](https://github.com/mrueg)) [SIG Scheduling]
- Provider-specific Notes: vsphere: vsphere.conf - new option to disable credentials secret management for performance concerns ([#90836](https://github.com/kubernetes/kubernetes/pull/90836), [@Danil-Grigorev](https://github.com/Danil-Grigorev)) [SIG Cloud Provider]
- Rename pod_preemption_metrics to preemption_metrics. ([#93256](https://github.com/kubernetes/kubernetes/pull/93256), [@ahg-g](https://github.com/ahg-g)) [SIG Instrumentation and Scheduling]
- Rest.Config now supports a flag to override proxy configuration that was previously only configurable through environment variables. ([#81443](https://github.com/kubernetes/kubernetes/pull/81443), [@mikedanese](https://github.com/mikedanese)) [SIG API Machinery and Node]
- Scores from PodTopologySpreading have reduced differentiation as maxSkew increases. ([#90820](https://github.com/kubernetes/kubernetes/pull/90820), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Server-side apply behavior has been regularized in the case where a field is removed from the applied configuration. Removed fields which have no other owners are deleted from the live object, or reset to their default value if they have one. Safe ownership transfers, such as the transfer of a `replicas` field from a user to an HPA without resetting to the default value are documented in [Transferring Ownership](https://kubernetes.io/docs/reference/using-api/api-concepts/&#35;transferring-ownership) ([#92661](https://github.com/kubernetes/kubernetes/pull/92661), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Testing]
- Service controller: only sync LB node pools when relevant fields in Node changes ([#90769](https://github.com/kubernetes/kubernetes/pull/90769), [@andrewsykim](https://github.com/andrewsykim)) [SIG Apps and Network]
- Set CSIMigrationvSphere feature gates to beta.
  Users should enable CSIMigration + CSIMigrationvSphere features and install the vSphere CSI Driver (https://github.com/kubernetes-sigs/vsphere-csi-driver) to move workload from the in-tree vSphere plugin "kubernetes.io/vsphere-volume" to vSphere CSI Driver.
  
  Requires: vSphere vCenter/ESXi Version: 7.0u1, HW Version: VM version 15 ([#92816](https://github.com/kubernetes/kubernetes/pull/92816), [@divyenpatel](https://github.com/divyenpatel)) [SIG Cloud Provider and Storage]
- Support `kubectl create deployment` with replicas ([#91562](https://github.com/kubernetes/kubernetes/pull/91562), [@zhouya0](https://github.com/zhouya0))
- Support a smooth upgrade from client-side apply to server-side apply without conflicts, as well as support the corresponding downgrade. ([#90187](https://github.com/kubernetes/kubernetes/pull/90187), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG API Machinery and Testing]
- Support create or update VMSS asynchronously. ([#89248](https://github.com/kubernetes/kubernetes/pull/89248), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Support for running on a host that uses cgroups v2 unified mode ([#85218](https://github.com/kubernetes/kubernetes/pull/85218), [@giuseppe](https://github.com/giuseppe)) [SIG Node]
- Switch core master base images (kube-apiserver, kube-scheduler) from debian to distroless ([#90674](https://github.com/kubernetes/kubernetes/pull/90674), [@dims](https://github.com/dims)) [SIG Cloud Provider, Release and Scalability]
- Switch etcd image (with migration scripts) from debian to distroless ([#91171](https://github.com/kubernetes/kubernetes/pull/91171), [@dims](https://github.com/dims)) [SIG API Machinery and Cloud Provider]
- The RotateKubeletClientCertificate feature gate has been promoted to GA, and the kubelet --feature-gate RotateKubeletClientCertificate parameter will be removed in 1.20. ([#91780](https://github.com/kubernetes/kubernetes/pull/91780), [@liggitt](https://github.com/liggitt)) [SIG Auth and Node]
- The SCTPSupport feature is now active by default. ([#88932](https://github.com/kubernetes/kubernetes/pull/88932), [@janosi](https://github.com/janosi)) [SIG Network]
- The `certificatesigningrequests/approval` subresource now supports patch API requests ([#91558](https://github.com/kubernetes/kubernetes/pull/91558), [@liggitt](https://github.com/liggitt)) [SIG Auth and Testing]
- The metric label name of `kubernetes_build_info` has been updated from `camel case` to `snake case`:
  - gitVersion --> git_version
  - gitCommit --> git_commit
  - gitTreeState --> git_tree_state
  - buildDate --> build_date
  - goVersion --> go_version
  
  This change happens in `kube-apiserver`、`kube-scheduler`、`kube-proxy` and `kube-controller-manager`. ([#91805](https://github.com/kubernetes/kubernetes/pull/91805), [@RainbowMango](https://github.com/RainbowMango)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Trace output in apiserver logs is more organized and comprehensive. Traces are nested, and for all non-long running request endpoints, the entire filter chain is instrumented (e.g. authentication check is included). ([#88936](https://github.com/kubernetes/kubernetes/pull/88936), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Scheduling]
- Try to send watch bookmarks (if requested) periodically in addition to sending them right before timeout ([#90560](https://github.com/kubernetes/kubernetes/pull/90560), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery]
- Update cri-tools to v1.18.0 ([#89720](https://github.com/kubernetes/kubernetes/pull/89720), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider, Cluster Lifecycle, Release and Scalability]
- Update etcd client side to v3.4.4 ([#89169](https://github.com/kubernetes/kubernetes/pull/89169), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Update etcd client side to v3.4.7 ([#89822](https://github.com/kubernetes/kubernetes/pull/89822), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Update etcd client side to v3.4.9 ([#92075](https://github.com/kubernetes/kubernetes/pull/92075), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cloud Provider and Instrumentation]
- Upgrade to azure-sdk v40.2.0 ([#89105](https://github.com/kubernetes/kubernetes/pull/89105), [@andyzhangx](https://github.com/andyzhangx)) [SIG CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Storage and Testing]
- Warn users that `kubectl port-forward` does not support UDP now ([#91616](https://github.com/kubernetes/kubernetes/pull/91616), [@knight42](https://github.com/knight42)) [SIG CLI]
- Weight of PodTopologySpread scheduling Score is doubled. ([#91258](https://github.com/kubernetes/kubernetes/pull/91258), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- `EventRecorder()` is exposed to `FrameworkHandle` interface so that scheduler plugin developers can choose to log cluster-level events. ([#92010](https://github.com/kubernetes/kubernetes/pull/92010), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling]
- `kubectl alpha debug` command now supports debugging pods by copy the original one. ([#90094](https://github.com/kubernetes/kubernetes/pull/90094), [@aylei](https://github.com/aylei)) [SIG CLI]
- `kubectl alpha debug` now supports debugging nodes by creating a debugging container running in the node's host namespaces. ([#92310](https://github.com/kubernetes/kubernetes/pull/92310), [@verb](https://github.com/verb)) [SIG CLI]
- `local-up-cluster.sh` installs CSI snapshotter by default now, can be disabled with `ENABLE_CSI_SNAPSHOTTER=false`. ([#91504](https://github.com/kubernetes/kubernetes/pull/91504), [@pohly](https://github.com/pohly))
- `maxThreshold` of `ImageLocality` plugin is now scaled by the number of images in the pod, which helps to distinguish the node priorities for pod with several images. ([#91138](https://github.com/kubernetes/kubernetes/pull/91138), [@chendave](https://github.com/chendave)) [SIG Scheduling]

### Documentation

- Updated the instructions for deploying the sample app. ([#82785](https://github.com/kubernetes/kubernetes/pull/82785), [@ashish-billore](https://github.com/ashish-billore)) [SIG API Machinery]

### Failing Test

- Kube-proxy iptables min-sync-period defaults to 1 sec. Previously, it was 0. ([#92836](https://github.com/kubernetes/kubernetes/pull/92836), [@aojea](https://github.com/aojea)) [SIG Network]

### Bug or Regression

- A PV set from in-tree source will have ordered requirement values in NodeAffinity when converted to CSIPersistentVolumeSource ([#88987](https://github.com/kubernetes/kubernetes/pull/88987), [@jiahuif](https://github.com/jiahuif)) [SIG Storage]
- A panic in the apiserver caused by the `informer-sync` health checker is now fixed. ([#93600](https://github.com/kubernetes/kubernetes/pull/93600), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG API Machinery]
- An issue preventing GCP cloud-controller-manager running out-of-cluster to initialize new Nodes is now fixed. ([#90057](https://github.com/kubernetes/kubernetes/pull/90057), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Apps and Cloud Provider]
- Avoid GCE API calls when initializing GCE CloudProvider for Kubelets. ([#90218](https://github.com/kubernetes/kubernetes/pull/90218), [@wojtek-t](https://github.com/wojtek-t)) [SIG Cloud Provider and Scalability]
- Avoid unnecessary GCE API calls when adding IP alises or reflecting them in Node object in GCE cloud provider. ([#90242](https://github.com/kubernetes/kubernetes/pull/90242), [@wojtek-t](https://github.com/wojtek-t)) [SIG Apps, Cloud Provider and Network]
- Avoid unnecessary scheduling churn when annotations are updated while Pods are being scheduled. ([#90373](https://github.com/kubernetes/kubernetes/pull/90373), [@fabiokung](https://github.com/fabiokung)) [SIG Scheduling]
- Azure auth module for kubectl now requests login after refresh token expires. ([#86481](https://github.com/kubernetes/kubernetes/pull/86481), [@tdihp](https://github.com/tdihp)) [SIG API Machinery and Auth]
- Azure: fix concurreny issue in lb creation ([#89604](https://github.com/kubernetes/kubernetes/pull/89604), [@aramase](https://github.com/aramase)) [SIG Cloud Provider]
- Azure: per VMSS VMSS VMs cache to prevent throttling on clusters having many attached VMSS ([#93107](https://github.com/kubernetes/kubernetes/pull/93107), [@bpineau](https://github.com/bpineau)) [SIG Cloud Provider]
- Azure: set dest prefix and port for IPv6 inbound security rule ([#91831](https://github.com/kubernetes/kubernetes/pull/91831), [@aramase](https://github.com/aramase)) [SIG Cloud Provider]
- Base-images: Update to kube-cross:v1.13.9-5 ([#90963](https://github.com/kubernetes/kubernetes/pull/90963), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]
- Bug fix for AWS NLB service when nodePort for existing servicePort changed manually. ([#89562](https://github.com/kubernetes/kubernetes/pull/89562), [@M00nF1sh](https://github.com/M00nF1sh)) [SIG Cloud Provider]
- CSINode initialization does not crash kubelet on startup when APIServer is not reachable or kubelet has not the right credentials yet. ([#89589](https://github.com/kubernetes/kubernetes/pull/89589), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- CVE-2020-8557 (Medium): Node-local denial of service via container /etc/hosts file. See https://github.com/kubernetes/kubernetes/issues/93032 for more details. ([#92916](https://github.com/kubernetes/kubernetes/pull/92916), [@joelsmith](https://github.com/joelsmith)) [SIG Node]
- Client-go: resolves an issue with informers falling back to full list requests when timeouts are encountered, rather than re-establishing a watch. ([#89652](https://github.com/kubernetes/kubernetes/pull/89652), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- CloudNodeLifecycleController will check node existence status before shutdown status when monitoring nodes. ([#90737](https://github.com/kubernetes/kubernetes/pull/90737), [@jiahuif](https://github.com/jiahuif)) [SIG Apps and Cloud Provider]
- Containers which specify a `startupProbe` but not a `readinessProbe` were previously considered "ready" before the `startupProbe` completed, but are now considered "not-ready". ([#92196](https://github.com/kubernetes/kubernetes/pull/92196), [@thockin](https://github.com/thockin)) [SIG Node]
- Cordoned nodes are now deregistered from AWS target groups. ([#85920](https://github.com/kubernetes/kubernetes/pull/85920), [@hoelzro](https://github.com/hoelzro)) [SIG Cloud Provider]
- Do not add nodes labeled with kubernetes.azure.com/managed=false to backend pool of load balancer. ([#93034](https://github.com/kubernetes/kubernetes/pull/93034), [@matthias50](https://github.com/matthias50)) [SIG Cloud Provider]
- Do not retry volume expansion if CSI driver returns FailedPrecondition error ([#92986](https://github.com/kubernetes/kubernetes/pull/92986), [@gnufied](https://github.com/gnufied)) [SIG Node and Storage]
- Dockershim security: pod sandbox now always run with `no-new-privileges` and `runtime/default` seccomp profile
  dockershim seccomp: custom profiles can now have smaller seccomp profiles when set at pod level ([#90948](https://github.com/kubernetes/kubernetes/pull/90948), [@pjbgf](https://github.com/pjbgf)) [SIG Node]
- Dual-stack: fix the bug that Service clusterIP does not respect specified ipFamily ([#89612](https://github.com/kubernetes/kubernetes/pull/89612), [@SataQiu](https://github.com/SataQiu)) [SIG Network]
- EndpointSliceMirroring controller now copies labels from Endpoints to EndpointSlices. ([#93442](https://github.com/kubernetes/kubernetes/pull/93442), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Ensure Azure availability zone is always in lower cases. ([#89722](https://github.com/kubernetes/kubernetes/pull/89722), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Eviction requests for pods that have a non-zero DeletionTimestamp will always succeed ([#91342](https://github.com/kubernetes/kubernetes/pull/91342), [@michaelgugino](https://github.com/michaelgugino)) [SIG Apps]
- Explain CRDs whose resource name are the same as builtin objects ([#89505](https://github.com/kubernetes/kubernetes/pull/89505), [@knight42](https://github.com/knight42)) [SIG API Machinery, CLI and Testing]
- Extend kube-apiserver /readyz with new "informer-sync" check ensuring that internal informers are synced. ([#92644](https://github.com/kubernetes/kubernetes/pull/92644), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Testing]
- Extended DSR loadbalancer feature in winkernel kube-proxy to HNS versions 9.3-9.max, 10.2+ ([#93080](https://github.com/kubernetes/kubernetes/pull/93080), [@elweb9858](https://github.com/elweb9858)) [SIG Network]
- First pod with required affinity terms can schedule only on nodes with matching topology keys. ([#91168](https://github.com/kubernetes/kubernetes/pull/91168), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- Fix AWS Loadbalancer VPC CIDR calculation when CIDR in disassociated state exists. ([#92227](https://github.com/kubernetes/kubernetes/pull/92227), [@M00nF1sh](https://github.com/M00nF1sh)) [SIG Cloud Provider]
- Fix InstanceMetadataByProviderID for unmanaged nodes ([#92572](https://github.com/kubernetes/kubernetes/pull/92572), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix `VirtualMachineScaleSets.virtualMachines.GET` not allowed issues when customers have set VMSS orchestrationMode. ([#91097](https://github.com/kubernetes/kubernetes/pull/91097), [@feiskyer](https://github.com/feiskyer))
- Fix a bug that didn't allow to use IPv6 addresses with leading zeros ([#89341](https://github.com/kubernetes/kubernetes/pull/89341), [@aojea](https://github.com/aojea)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fix a bug where ExternalTrafficPolicy is not applied to service ExternalIPs. ([#90537](https://github.com/kubernetes/kubernetes/pull/90537), [@freehan](https://github.com/freehan)) [SIG Network]
- Fix a condition when expiring nil VM entry in VMSS cache ([#92681](https://github.com/kubernetes/kubernetes/pull/92681), [@ArchangelSDY](https://github.com/ArchangelSDY)) [SIG Cloud Provider]
- Fix a racing issue where the scheduler may perform unnecessary scheduling attempts. ([#90660](https://github.com/kubernetes/kubernetes/pull/90660), [@Huang-Wei](https://github.com/Huang-Wei))
- Fix an issue with container restarts using a modified configmap or secret subpath volume mount. ([#89629](https://github.com/kubernetes/kubernetes/pull/89629), [@fatedier](https://github.com/fatedier)) [SIG Architecture, Storage and Testing]
- Fix bug in the port allocation logic that caused that the NodePort creation with statically assigned portNumber collide in multi-master HA cluster ([#89937](https://github.com/kubernetes/kubernetes/pull/89937), [@aojea](https://github.com/aojea)) [SIG Network and Testing]
- Fix bug with xfs_repair from stopping xfs mount ([#89444](https://github.com/kubernetes/kubernetes/pull/89444), [@gnufied](https://github.com/gnufied)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Fix clusterdump info namespaces flag not working ([#91890](https://github.com/kubernetes/kubernetes/pull/91890), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix detection of SystemOOMs in which the victim is a container. ([#88871](https://github.com/kubernetes/kubernetes/pull/88871), [@dashpole](https://github.com/dashpole)) [SIG Node]
- Fix detection of image filesystem, disk metrics for devicemapper, detection of OOM Kills on 5.0+ linux kernels. ([#92919](https://github.com/kubernetes/kubernetes/pull/92919), [@dashpole](https://github.com/dashpole)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Node]
- Fix etcd version migration script in etcd image. ([#91925](https://github.com/kubernetes/kubernetes/pull/91925), [@wenjiaswe](https://github.com/wenjiaswe)) [SIG API Machinery]
- Fix flaws in Azure File CSI translation ([#90162](https://github.com/kubernetes/kubernetes/pull/90162), [@rfranzke](https://github.com/rfranzke)) [SIG Release and Storage]
- Fix instance not found issues when an Azure Node is recreated in a short time ([#93316](https://github.com/kubernetes/kubernetes/pull/93316), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix issues when supported huge page sizes changes ([#80831](https://github.com/kubernetes/kubernetes/pull/80831), [@odinuge](https://github.com/odinuge)) [SIG Node and Testing]
- Fix kube-apiserver startup to wait for APIServices to be installed into the HTTP handler before reporting readiness. ([#89147](https://github.com/kubernetes/kubernetes/pull/89147), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- Fix kubectl create --dryrun client ignores namespace ([#90502](https://github.com/kubernetes/kubernetes/pull/90502), [@zhouya0](https://github.com/zhouya0))
- Fix kubectl create secret docker-registry --from-file not usable ([#90960](https://github.com/kubernetes/kubernetes/pull/90960), [@zhouya0](https://github.com/zhouya0)) [SIG CLI and Testing]
- Fix kubectl describe CSINode nil pointer error ([#89646](https://github.com/kubernetes/kubernetes/pull/89646), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix kubectl describe node for users not having access to lease information. ([#90469](https://github.com/kubernetes/kubernetes/pull/90469), [@uthark](https://github.com/uthark)) [SIG CLI]
- Fix kubectl describe output format for empty annotations. ([#91405](https://github.com/kubernetes/kubernetes/pull/91405), [@iyashu](https://github.com/iyashu)) [SIG CLI]
- Fix kubectl diff so it doesn't actually persist patches ([#89795](https://github.com/kubernetes/kubernetes/pull/89795), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- Fix kubectl run  --dry-run client  ignore namespace ([#90785](https://github.com/kubernetes/kubernetes/pull/90785), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Fix kubectl version should print version info without config file ([#89913](https://github.com/kubernetes/kubernetes/pull/89913), [@zhouya0](https://github.com/zhouya0)) [SIG API Machinery and CLI]
- Fix missing `-c` shorthand for `--container` flag of `kubectl alpha debug` ([#89674](https://github.com/kubernetes/kubernetes/pull/89674), [@superbrothers](https://github.com/superbrothers)) [SIG CLI]
- Fix printers ignoring object average value ([#89142](https://github.com/kubernetes/kubernetes/pull/89142), [@zhouya0](https://github.com/zhouya0)) [SIG API Machinery]
- Fix public IP not shown issues after assigning public IP to Azure VMs ([#90886](https://github.com/kubernetes/kubernetes/pull/90886), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix scheduler crash when removing node before its pods ([#89908](https://github.com/kubernetes/kubernetes/pull/89908), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix the VMSS name and resource group name when updating Azure VMSS for LoadBalancer backendPools ([#89337](https://github.com/kubernetes/kubernetes/pull/89337), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix throttling issues when Azure VM computer name prefix is different from VMSS name ([#92793](https://github.com/kubernetes/kubernetes/pull/92793), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix: Azure deallocating node should be regarded as shut down ([#92257](https://github.com/kubernetes/kubernetes/pull/92257), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: GetLabelsForVolume panic issue for azure disk PV ([#92166](https://github.com/kubernetes/kubernetes/pull/92166), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: add azure file migration support on annotation support ([#91093](https://github.com/kubernetes/kubernetes/pull/91093), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Node]
- Fix: azure disk dangling attach issue which would cause API throttling ([#90749](https://github.com/kubernetes/kubernetes/pull/90749), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: determine the correct ip config based on ip family ([#93043](https://github.com/kubernetes/kubernetes/pull/93043), [@aramase](https://github.com/aramase)) [SIG Cloud Provider]
- Fix: don't use docker config cache if it's empty ([#92330](https://github.com/kubernetes/kubernetes/pull/92330), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: fix topology issue in azure disk storage class migration ([#91196](https://github.com/kubernetes/kubernetes/pull/91196), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: get attach disk error due to missing item in max count table ([#89768](https://github.com/kubernetes/kubernetes/pull/89768), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix: incorrect max azure disk max count ([#92331](https://github.com/kubernetes/kubernetes/pull/92331), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix: initial delay in mounting azure disk & file ([#93052](https://github.com/kubernetes/kubernetes/pull/93052), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fix: support removal of nodes backed by deleted non VMSS instances on Azure ([#91184](https://github.com/kubernetes/kubernetes/pull/91184), [@bpineau](https://github.com/bpineau)) [SIG Cloud Provider]
- Fix: use force detach for azure disk ([#91948](https://github.com/kubernetes/kubernetes/pull/91948), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fixed a 1.18 regression in wait.Forever that skips the backoff period on the first repeat ([#90476](https://github.com/kubernetes/kubernetes/pull/90476), [@zhan849](https://github.com/zhan849)) [SIG API Machinery]
- Fixed a bug that mistake use newObj as oldObj in endpoint slice update. ([#92339](https://github.com/kubernetes/kubernetes/pull/92339), [@fatkun](https://github.com/fatkun)) [SIG Apps and Network]
- Fixed a bug where executing a kubectl command with a jsonpath output expression that has a nested range would ignore expressions following the nested range. ([#88464](https://github.com/kubernetes/kubernetes/pull/88464), [@brianpursley](https://github.com/brianpursley)) [SIG API Machinery]
- Fixed a bug whereby the allocation of reusable CPUs and devices was not being honored when the TopologyManager was enabled ([#93189](https://github.com/kubernetes/kubernetes/pull/93189), [@klueska](https://github.com/klueska)) [SIG Node]
- Fixed a performance issue applying json patches to deeply nested objects ([#92069](https://github.com/kubernetes/kubernetes/pull/92069), [@tapih](https://github.com/tapih)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fixed a regression preventing garbage collection of RBAC role and binding objects ([#90534](https://github.com/kubernetes/kubernetes/pull/90534), [@apelisse](https://github.com/apelisse)) [SIG Auth]
- Fixed a regression running kubectl commands with  --local or --dry-run flags when no kubeconfig file is present ([#90243](https://github.com/kubernetes/kubernetes/pull/90243), [@soltysh](https://github.com/soltysh)) [SIG API Machinery, CLI and Testing]
- Fixed ambiguous behavior when bearer token (kubectl --token=..) and an exec credential plugin was configured in the same context - the bearer token now takes precedence. ([#91745](https://github.com/kubernetes/kubernetes/pull/91745), [@anderseknert](https://github.com/anderseknert)) [SIG API Machinery, Auth and Testing]
- Fixed an issue mounting credentials for service accounts whose name contains `.` characters ([#89696](https://github.com/kubernetes/kubernetes/pull/89696), [@nabokihms](https://github.com/nabokihms)) [SIG Auth]
- Fixed an issue that a Pod's nominatedNodeName cannot be cleared upon node deletion. ([#91750](https://github.com/kubernetes/kubernetes/pull/91750), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Scheduling and Testing]
- Fixed bug where a nonzero exit code was returned when initializing zsh completion even though zsh completion was successfully initialized ([#88165](https://github.com/kubernetes/kubernetes/pull/88165), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed memory leak in endpointSliceTracker ([#92838](https://github.com/kubernetes/kubernetes/pull/92838), [@tnqn](https://github.com/tnqn)) [SIG Apps and Network]
- Fixed mountOptions in iSCSI and FibreChannel volume plugins. ([#89172](https://github.com/kubernetes/kubernetes/pull/89172), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed node data lost in kube-scheduler for clusters with imbalance on number of nodes across zones ([#93355](https://github.com/kubernetes/kubernetes/pull/93355), [@maelk](https://github.com/maelk))
- Fixed several bugs involving the IPFamily field when creating or updating services
  in clusters with the IPv6DualStack feature gate enabled.
  
  Beware that the behavior of the IPFamily field is strange and inconsistent and will
  likely be changed before the dual-stack feature goes GA. Users should treat the
  field as "write-only" for now and should not make any assumptions about a service
  based on its current IPFamily value. ([#91400](https://github.com/kubernetes/kubernetes/pull/91400), [@danwinship](https://github.com/danwinship)) [SIG Apps and Network]
- Fixed the EndpointSlice controller to run without error on a cluster with the OwnerReferencesPermissionEnforcement validating admission plugin enabled. ([#89741](https://github.com/kubernetes/kubernetes/pull/89741), [@marun](https://github.com/marun)) [SIG Auth and Network]
- Fixed the EndpointSliceController to correctly create endpoints for IPv6-only pods.
  
  Fixed the EndpointController to allow IPv6 headless services, if the IPv6DualStack
  feature gate is enabled, by specifying `ipFamily: IPv6` on the service. (This already
  worked with the EndpointSliceController.) ([#91399](https://github.com/kubernetes/kubernetes/pull/91399), [@danwinship](https://github.com/danwinship)) [SIG Apps and Network]
- Fixed using of a read-only iSCSI volume in multiple pods. ([#91738](https://github.com/kubernetes/kubernetes/pull/91738), [@jsafrane](https://github.com/jsafrane)) [SIG Storage and Testing]
- Fixes CSI volume attachment scaling issue by using informers. ([#91307](https://github.com/kubernetes/kubernetes/pull/91307), [@yuga711](https://github.com/yuga711)) [SIG API Machinery, Apps, Node, Storage and Testing]
- Fixes a bug defining a default value for a replicas field in a custom resource definition that has the scale subresource enabled ([#89833](https://github.com/kubernetes/kubernetes/pull/89833), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Fixes a bug that non directory hostpath type can be recognized as HostPathFile and adds e2e tests for HostPathType ([#64829](https://github.com/kubernetes/kubernetes/pull/64829), [@dixudx](https://github.com/dixudx)) [SIG Apps, Storage and Testing]
- Fixes a problem with 63-second or 1-second connection delays with some VXLAN-based
  network plugins which was first widely noticed in 1.16 (though some users saw it
  earlier than that, possibly only with specific network plugins). If you were previously
  using ethtool to disable checksum offload on your primary network interface, you should
  now be able to stop doing that. ([#92035](https://github.com/kubernetes/kubernetes/pull/92035), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- Fixes a regression in 1.17 that dropped cache-control headers on API requests ([#90468](https://github.com/kubernetes/kubernetes/pull/90468), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Testing]
- Fixes conversion error for HorizontalPodAutoscaler objects with invalid annotations ([#89963](https://github.com/kubernetes/kubernetes/pull/89963), [@liggitt](https://github.com/liggitt)) [SIG Autoscaling]
- Fixes kubectl to apply all validly built objects, instead of stopping on error. ([#89848](https://github.com/kubernetes/kubernetes/pull/89848), [@seans3](https://github.com/seans3)) [SIG CLI and Testing]
- Fixes regression in CPUManager that caused freeing of exclusive CPUs at incorrect times ([#90377](https://github.com/kubernetes/kubernetes/pull/90377), [@cbf123](https://github.com/cbf123)) [SIG Cloud Provider and Node]
- Fixes regression in CPUManager that had the (rare) possibility to release exclusive CPUs in app containers inherited from init containers. ([#90419](https://github.com/kubernetes/kubernetes/pull/90419), [@klueska](https://github.com/klueska)) [SIG Node]
- Fixes v1.18.0-rc.1 regression in `kubectl port-forward` when specifying a local and remote port ([#89401](https://github.com/kubernetes/kubernetes/pull/89401), [@liggitt](https://github.com/liggitt))
- Fixing race condition with EndpointSlice controller garbage collection. ([#91311](https://github.com/kubernetes/kubernetes/pull/91311), [@robscott](https://github.com/robscott)) [SIG Apps, Network and Testing]
- For GCE cluster provider, fix bug of not being able to create internal type load balancer for clusters with more than 1000 nodes in a single zone. ([#89902](https://github.com/kubernetes/kubernetes/pull/89902), [@wojtek-t](https://github.com/wojtek-t)) [SIG Cloud Provider, Network and Scalability]
- For external storage e2e test suite, update external driver, to pick snapshot provisioner from VolumeSnapshotClass, when a VolumeSnapshotClass is explicitly provided as an input. ([#90878](https://github.com/kubernetes/kubernetes/pull/90878), [@saikat-royc](https://github.com/saikat-royc)) [SIG Storage and Testing]
- Get-kube.sh: fix order to get the binaries from the right bucket ([#91635](https://github.com/kubernetes/kubernetes/pull/91635), [@cpanato](https://github.com/cpanato)) [SIG Release]
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
- Kube-aggregator certificates are dynamically loaded on change from disk ([#92791](https://github.com/kubernetes/kubernetes/pull/92791), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Kube-apiserver: fixes scale subresource patch handling to avoid returning unnecessary 409 Conflict error to clients ([#90342](https://github.com/kubernetes/kubernetes/pull/90342), [@liggitt](https://github.com/liggitt)) [SIG Apps, Autoscaling and Testing]
- Kube-apiserver: jsonpath expressions with consecutive recursive descent operators are no longer evaluated for custom resource printer columns ([#93408](https://github.com/kubernetes/kubernetes/pull/93408), [@joelsmith](https://github.com/joelsmith)) [SIG API Machinery]
- Kube-apiserver: multiple comma-separated protocols in a single X-Stream-Protocol-Version header are now recognized, in addition to multiple headers, complying with RFC2616 ([#89857](https://github.com/kubernetes/kubernetes/pull/89857), [@tedyu](https://github.com/tedyu)) [SIG API Machinery]
- Kube-proxy IP family will be determined by the nodeIP used by the proxier. The order of precedence is:
  1. the configured --bind-address if the bind address is not 0.0.0.0 or ::
  2. the primary IP from the Node object, if set.
  3. if no IP is found, NodeIP defaults to 127.0.0.1 and the IP family to IPv4 ([#91725](https://github.com/kubernetes/kubernetes/pull/91725), [@aojea](https://github.com/aojea)) [SIG Network]
- Kube-proxy, in dual-stack mode, infers the service IP family from the ClusterIP instead of using the `Service.Spec.IPFamily` field ([#91357](https://github.com/kubernetes/kubernetes/pull/91357), [@aojea](https://github.com/aojea))
- Kube-up now includes CoreDNS version v1.7.0. Some of the major changes include:
  -  Fixed a bug that could cause CoreDNS to stop updating service records.
  -  Fixed a bug in the forward plugin where only the first upstream server is always selected no matter which policy is set.
  -  Remove already deprecated options `resyncperiod` and `upstream` in the Kubernetes plugin.
  -  Includes Prometheus metrics name changes (to bring them in line with standard Prometheus metrics naming convention). They will be backward incompatible with existing reporting formulas that use the old metrics' names.
  -  The federation plugin (allows for v1 Kubernetes federation) has been removed.
  More details are available in https://coredns.io/2020/06/15/coredns-1.7.0-release/ ([#92718](https://github.com/kubernetes/kubernetes/pull/92718), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cloud Provider]
- Kube-up: fixes setup of validating admission webhook credential configuration ([#91995](https://github.com/kubernetes/kubernetes/pull/91995), [@liggitt](https://github.com/liggitt)) [SIG Cloud Provider and Cluster Lifecycle]
- Kubeadm increased to 5 minutes its timeout for the TLS bootstrapping process to complete upon join ([#89735](https://github.com/kubernetes/kubernetes/pull/89735), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: Add retries for kubeadm join / UpdateStatus to make update status more resilient by adding a retry loop to this operation ([#91952](https://github.com/kubernetes/kubernetes/pull/91952), [@xlgao-zju](https://github.com/xlgao-zju)) [SIG Cluster Lifecycle]
- Kubeadm: add the deprecated flag --port=0 to kube-controller-manager and kube-scheduler manifests to disable insecure serving. Without this flag the components by default serve (e.g. /metrics) insecurely on the default node interface (controlled by --address). Users that wish to override this behavior and enable insecure serving can pass a custom --port=X via kubeadm's "extraArgs" mechanic for these components. ([#92720](https://github.com/kubernetes/kubernetes/pull/92720), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: during "join", don't re-add an etcd member if it already exists in the cluster. ([#92118](https://github.com/kubernetes/kubernetes/pull/92118), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: during "reset" do not remove the only remaining stacked etcd member from the cluster and just proceed with the cleanup of the local etcd storage. ([#91145](https://github.com/kubernetes/kubernetes/pull/91145), [@tnqn](https://github.com/tnqn)) [SIG Cluster Lifecycle]
- Kubeadm: during join when a check is performed that a Node with the same name already exists in the cluster, make sure the NodeReady condition is properly validated ([#89602](https://github.com/kubernetes/kubernetes/pull/89602), [@kvaps](https://github.com/kvaps)) [SIG Cluster Lifecycle]
- Kubeadm: ensure `image-pull-timeout` flag is respected during upgrade phase ([#90328](https://github.com/kubernetes/kubernetes/pull/90328), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: fix a bug where post upgrade to 1.18.x, nodes cannot join the cluster due to missing RBAC ([#89537](https://github.com/kubernetes/kubernetes/pull/89537), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fix misleading warning about passing control-plane related flags on 'kubeadm join' ([#89596](https://github.com/kubernetes/kubernetes/pull/89596), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: increase robustness for "kubeadm join" when adding etcd members on slower setups ([#90645](https://github.com/kubernetes/kubernetes/pull/90645), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: remove duplicate DNS names and IP addresses from generated certificates ([#92753](https://github.com/kubernetes/kubernetes/pull/92753), [@QianChenglong](https://github.com/QianChenglong)) [SIG Cluster Lifecycle]
- Kubectl azure authentication: fixed a regression in 1.18.0 where "spn:" prefix was unexpectedly added to the `apiserver-id` configuration in the kubeconfig file ([#89706](https://github.com/kubernetes/kubernetes/pull/89706), [@weinong](https://github.com/weinong)) [SIG API Machinery and Auth]
- Kubectl: fix the bug that kubectl autoscale does not honor '--name' flag ([#91855](https://github.com/kubernetes/kubernetes/pull/91855), [@SataQiu](https://github.com/SataQiu)) [SIG CLI]
- Kubectl: fix the bug that kubectl scale does not honor '--timeout' flag ([#91858](https://github.com/kubernetes/kubernetes/pull/91858), [@SataQiu](https://github.com/SataQiu)) [SIG CLI]
- Kubelet: fix the bug that kubelet help information can not show the right type of flags ([#88515](https://github.com/kubernetes/kubernetes/pull/88515), [@SataQiu](https://github.com/SataQiu)) [SIG Docs and Node]
- Kuberuntime security: pod sandbox now always runs with `runtime/default` seccomp profile
  kuberuntime seccomp: custom profiles can now have smaller seccomp profiles when set at pod level ([#90949](https://github.com/kubernetes/kubernetes/pull/90949), [@pjbgf](https://github.com/pjbgf)) [SIG Node]
- Make Kubelet bootstrap certificate signal aware ([#92786](https://github.com/kubernetes/kubernetes/pull/92786), [@answer1991](https://github.com/answer1991)) [SIG API Machinery, Auth and Node]
- Node ([#89677](https://github.com/kubernetes/kubernetes/pull/89677), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- On AWS nodes with multiple network interfaces, kubelet should now more reliably report addresses from secondary interfaces. ([#91889](https://github.com/kubernetes/kubernetes/pull/91889), [@anguslees](https://github.com/anguslees)) [SIG Cloud Provider]
- Pod Conditions updates are skipped for re-scheduling attempts ([#91252](https://github.com/kubernetes/kubernetes/pull/91252), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Pods can now be considered for preemption after a previously nominated node has become unschedulable and unresolvable. ([#92604](https://github.com/kubernetes/kubernetes/pull/92604), [@soulxu](https://github.com/soulxu))
- Prevent PVC requested size overflow when expanding or creating a volume ([#90907](https://github.com/kubernetes/kubernetes/pull/90907), [@gnufied](https://github.com/gnufied)) [SIG Cloud Provider and Storage]
- Provides a fix to allow a cluster in a private Azure cloud to authenticate to ACR in the same cloud. ([#90425](https://github.com/kubernetes/kubernetes/pull/90425), [@DavidParks8](https://github.com/DavidParks8)) [SIG Cloud Provider]
- Refine aws loadbalancer worker node SG rule logic to be deterministic ([#92224](https://github.com/kubernetes/kubernetes/pull/92224), [@M00nF1sh](https://github.com/M00nF1sh)) [SIG Cloud Provider]
- Resolve regression in metadata.managedFields handling in create/update/patch requests not using server-side apply ([#91690](https://github.com/kubernetes/kubernetes/pull/91690), [@apelisse](https://github.com/apelisse)) [SIG API Machinery and Testing]
- Resolved a regression in v1.18.0-rc.1 mounting windows volumes ([#89319](https://github.com/kubernetes/kubernetes/pull/89319), [@mboersma](https://github.com/mboersma)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Resolves an issue using `kubectl certificate approve/deny` against a server serving the v1 CSR API ([#91691](https://github.com/kubernetes/kubernetes/pull/91691), [@liggitt](https://github.com/liggitt)) [SIG Auth and CLI]
- Restore the ability to `kubectl apply --prune` without --namespace flag.  Since 1.17, `kubectl apply --prune` only prunes resources in the default namespace (or from kubeconfig) or explicitly specified in command line flag.  But this is s breaking change from kubectl 1.16, which can prune resources in all namespace in config file.  This patch restores the kubectl 1.16 behaviour. ([#89551](https://github.com/kubernetes/kubernetes/pull/89551), [@tatsuhiro-t](https://github.com/tatsuhiro-t)) [SIG CLI and Testing]
- Restores priority of static control plane pods in the cluster/gce/manifests control-plane manifests ([#89970](https://github.com/kubernetes/kubernetes/pull/89970), [@liggitt](https://github.com/liggitt)) [SIG Cluster Lifecycle and Node]
- Reverted devicemanager for Windows node added in 1.19rc1. ([#93263](https://github.com/kubernetes/kubernetes/pull/93263), [@liggitt](https://github.com/liggitt)) [SIG Node and Windows]
- Scheduler v1 Policy config or algorithm-provider settings can now be passed alongside v1beta1 ComponentConfig to aid transition from Policy to CC ([#92531](https://github.com/kubernetes/kubernetes/pull/92531), [@damemi](https://github.com/damemi)) [SIG Scheduling]
- Scheduling failures due to no nodes available are now reported as unschedulable under ```schedule_attempts_total``` metric. ([#90989](https://github.com/kubernetes/kubernetes/pull/90989), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- Service account tokens bound to pods can now be used during the pod deletion grace period. ([#89583](https://github.com/kubernetes/kubernetes/pull/89583), [@liggitt](https://github.com/liggitt)) [SIG Auth]
- Service load balancers no longer exclude nodes marked unschedulable from the candidate nodes. The service load balancer exclusion label should be used instead.
  
  Users upgrading from 1.18 who have cordoned nodes should set the `node.kubernetes.io/exclude-from-external-load-balancers` label on the impacted nodes before upgrading if they wish those nodes to remain excluded from service load balancers. ([#90823](https://github.com/kubernetes/kubernetes/pull/90823), [@smarterclayton](https://github.com/smarterclayton)) [SIG Apps, Cloud Provider and Network]
- Support kubectl annotate --list option ([#92576](https://github.com/kubernetes/kubernetes/pull/92576), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Sync LB backend nodes for Service `Type=LoadBalancer` on Add/Delete node events. ([#81185](https://github.com/kubernetes/kubernetes/pull/81185), [@andrewsykim](https://github.com/andrewsykim))
- The following components that do not expect non-empty, non-flag arguments will now print an error message and exit if an argument is specified: cloud-controller-manager, kube-apiserver, kube-controller-manager, kube-proxy, kubeadm {alpha|config|token|version}, kubemark. Flags should be prefixed with a single dash "-" (0x45) for short form or double dash "--" for long form. Before this change, malformed flags (for example, starting with a non-ascii dash character such as 0x8211: "–") would have been silently treated as positional arguments and ignored. ([#91349](https://github.com/kubernetes/kubernetes/pull/91349), [@neolit123](https://github.com/neolit123)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle, Network and Scheduling]
- The terminationGracePeriodSeconds from pod spec is respected for the mirror pod. ([#92442](https://github.com/kubernetes/kubernetes/pull/92442), [@tedyu](https://github.com/tedyu)) [SIG Node and Testing]
- Update github.com/moby/ipvs to v1.0.1 to fix IPVS compatibility issue with older kernels ([#90555](https://github.com/kubernetes/kubernetes/pull/90555), [@andrewsykim](https://github.com/andrewsykim)) [SIG Network]
- Updates to pod status via the status subresource now validate that `status.podIP` and `status.podIPs` fields are well-formed. ([#90628](https://github.com/kubernetes/kubernetes/pull/90628), [@liggitt](https://github.com/liggitt)) [SIG Apps and Node]
- Wait for all CRDs to show up in discovery endpoint before reporting readiness. ([#89145](https://github.com/kubernetes/kubernetes/pull/89145), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- When evicting, Pods in Pending state are removed without checking PDBs. ([#83906](https://github.com/kubernetes/kubernetes/pull/83906), [@michaelgugino](https://github.com/michaelgugino)) [SIG API Machinery, Apps, Node and Scheduling]
- [security] Vulnerability in golang.org/x/text/encoding/unicode ([#92219](https://github.com/kubernetes/kubernetes/pull/92219), [@voor](https://github.com/voor)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Node]

### Other (Cleanup or Flake)

- --cache-dir sets cache directory for both http and discovery, defaults to $HOME/.kube/cache ([#92910](https://github.com/kubernetes/kubernetes/pull/92910), [@soltysh](https://github.com/soltysh)) [SIG API Machinery and CLI]
- Add `pod.Namespace` to the image log ([#91945](https://github.com/kubernetes/kubernetes/pull/91945), [@zhipengzuo](https://github.com/zhipengzuo))
- Add the ability to disable kubeconfig file lock through DISABLE_KUBECONFIG_LOCK env var ([#92513](https://github.com/kubernetes/kubernetes/pull/92513), [@soltysh](https://github.com/soltysh)) [SIG API Machinery and CLI]
- Adds additional testing to ensure that udp pods conntrack are cleaned up ([#90180](https://github.com/kubernetes/kubernetes/pull/90180), [@JacobTanenbaum](https://github.com/JacobTanenbaum)) [SIG Architecture, Network and Testing]
- Adjusts the fsType for cinder values to be `ext4` if no fsType is specified. ([#90608](https://github.com/kubernetes/kubernetes/pull/90608), [@huffmanca](https://github.com/huffmanca)) [SIG Storage]
- Base-images: Use debian-base:v2.1.0 ([#90697](https://github.com/kubernetes/kubernetes/pull/90697), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery and Release]
- Base-images: Use debian-iptables:v12.1.0 ([#90782](https://github.com/kubernetes/kubernetes/pull/90782), [@justaugustus](https://github.com/justaugustus)) [SIG Release]
- Beta.kubernetes.io/arch is already deprecated since v1.14, are targeted for removal in v1.18 ([#89462](https://github.com/kubernetes/kubernetes/pull/89462), [@wawa0210](https://github.com/wawa0210)) [SIG Testing]
- Build: Update to debian-base@v2.1.2 and debian-iptables@v12.1.1 ([#93667](https://github.com/kubernetes/kubernetes/pull/93667), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Release and Testing]
- Change beta.kubernetes.io/os  to kubernetes.io/os ([#89460](https://github.com/kubernetes/kubernetes/pull/89460), [@wawa0210](https://github.com/wawa0210)) [SIG Testing and Windows]
- Change beta.kubernetes.io/os to kubernetes.io/os ([#89461](https://github.com/kubernetes/kubernetes/pull/89461), [@wawa0210](https://github.com/wawa0210)) [SIG Cloud Provider and Cluster Lifecycle]
- Changes not found message when using `kubectl get` to retrieve not namespaced resources ([#89861](https://github.com/kubernetes/kubernetes/pull/89861), [@rccrdpccl](https://github.com/rccrdpccl)) [SIG CLI]
- CoreDNS will no longer be supporting Federation data translation for kube-dns ConfigMap ([#92716](https://github.com/kubernetes/kubernetes/pull/92716), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cluster Lifecycle]
- Deprecate kubectl top flags related to heapster
  Drop support of heapster in kubectl top ([#87498](https://github.com/kubernetes/kubernetes/pull/87498), [@serathius](https://github.com/serathius)) [SIG CLI]
- Deprecate the `--target-ram-md` flags that is no longer used for anything. ([#91818](https://github.com/kubernetes/kubernetes/pull/91818), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery]
- Drop some conformance tests that rely on Kubelet API directly ([#90615](https://github.com/kubernetes/kubernetes/pull/90615), [@dims](https://github.com/dims)) [SIG Architecture, Network, Release and Testing]
- Emit `WaitingForPodScheduled` event if the unbound PVC is in delay binding mode but used by a pod ([#91455](https://github.com/kubernetes/kubernetes/pull/91455), [@cofyc](https://github.com/cofyc)) [SIG Storage]
- Fix: license issue in blob disk feature ([#92824](https://github.com/kubernetes/kubernetes/pull/92824), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Improve server-side apply conflict errors by setting dedicated kubectl subcommand field managers ([#88885](https://github.com/kubernetes/kubernetes/pull/88885), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- IsFullyQualifiedDomainName() validates each label based on IsDNS1123Label. ([#90172](https://github.com/kubernetes/kubernetes/pull/90172), [@nak3](https://github.com/nak3)) [SIG API Machinery and Network]
- It is now possible to use the service annotation `cloud.google.com/network-tier: Standard` to configure the Network Tier of the GCE Loadbalancer ([#88532](https://github.com/kubernetes/kubernetes/pull/88532), [@zioproto](https://github.com/zioproto)) [SIG Cloud Provider, Network and Testing]
- Kube-aggregator: renames aggregator_unavailable_apiservice_count metric to aggregator_unavailable_apiservice_total ([#88156](https://github.com/kubernetes/kubernetes/pull/88156), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Kube-apiserver: openapi schemas published for custom resources now reference standard ListMeta schema definitions ([#92546](https://github.com/kubernetes/kubernetes/pull/92546), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
- Kube-proxy exposes a new metric, `kubeproxy_sync_proxy_rules_last_queued_timestamp_seconds`, that indicates the last time a change for kube-proxy was queued to be applied. ([#90175](https://github.com/kubernetes/kubernetes/pull/90175), [@squeed](https://github.com/squeed)) [SIG Instrumentation and Network]
- Kube-scheduler: The metric name `scheduler_total_preemption_attempts` has been renamed to `scheduler_preemption_attempts_total`. ([#91448](https://github.com/kubernetes/kubernetes/pull/91448), [@RainbowMango](https://github.com/RainbowMango)) [SIG API Machinery, Cluster Lifecycle, Instrumentation and Scheduling]
- Kube-up: defaults to limiting critical pods to the kube-system namespace to match behavior prior to 1.17 ([#93121](https://github.com/kubernetes/kubernetes/pull/93121), [@liggitt](https://github.com/liggitt)) [SIG Cloud Provider and Scheduling]
- Kubeadm now forwards the IPv6DualStack feature gate using the kubelet component config, instead of the kubelet command line ([#90840](https://github.com/kubernetes/kubernetes/pull/90840), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm: do not use a DaemonSet for the pre-pull of control-plane images during "kubeadm upgrade apply". Individual node upgrades now pull the required images using a preflight check. The flag "--image-pull-timeout" for "kubeadm upgrade apply" is now deprecated and will be removed in a future release following a GA deprecation policy. ([#90788](https://github.com/kubernetes/kubernetes/pull/90788), [@xlgao-zju](https://github.com/xlgao-zju)) [SIG Cluster Lifecycle]
- Kubeadm: use two separate checks on /livez and /readyz for the kube-apiserver static Pod instead of using /healthz ([#90970](https://github.com/kubernetes/kubernetes/pull/90970), [@johscheuer](https://github.com/johscheuer)) [SIG Cluster Lifecycle]
- NONE ([#91597](https://github.com/kubernetes/kubernetes/pull/91597), [@elmiko](https://github.com/elmiko)) [SIG Autoscaling and Testing]
- Openapi-controller: remove the trailing `1` character literal from the rate limiting metric `APIServiceOpenAPIAggregationControllerQueue1` and rename it to `open_api_aggregation_controller` to adhere to Prometheus best practices. ([#77979](https://github.com/kubernetes/kubernetes/pull/77979), [@s-urbaniak](https://github.com/s-urbaniak)) [SIG API Machinery]
- Reduce event spam during a volume operation error. ([#89794](https://github.com/kubernetes/kubernetes/pull/89794), [@msau42](https://github.com/msau42)) [SIG Storage]
- Refactor the local nodeipam range allocator and instrument the cidrset used to store the allocated CIDRs with the following metrics:
  "cidrset_cidrs_allocations_total",
  "cidrset_cidrs_releases_total",
  "cidrset_usage_cidrs",
  "cidrset_allocation_tries_per_request", ([#90288](https://github.com/kubernetes/kubernetes/pull/90288), [@aojea](https://github.com/aojea)) [SIG Apps, Instrumentation, Network and Scalability]
- Remove deprecated --server-dry-run flag from kubectl apply ([#91308](https://github.com/kubernetes/kubernetes/pull/91308), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG CLI and Testing]
- Renamed DefaultPodTopologySpread plugin to SelectorSpread plugin to avoid naming conflicts with feature Gate DefaultPodTopologySpread ([#92501](https://github.com/kubernetes/kubernetes/pull/92501), [@rakeshreddybandi](https://github.com/rakeshreddybandi)) [SIG Release, Scheduling and Testing]
- Replace framework.Failf with ExpectNoError ([#91811](https://github.com/kubernetes/kubernetes/pull/91811), [@lixiaobing1](https://github.com/lixiaobing1)) [SIG Instrumentation, Storage and Testing]
- Scheduler PreScore plugins are not executed if there is one filtered node or less. ([#89370](https://github.com/kubernetes/kubernetes/pull/89370), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- The "HostPath should give a volume the correct mode" is no longer a conformance test ([#90861](https://github.com/kubernetes/kubernetes/pull/90861), [@dims](https://github.com/dims)) [SIG Architecture and Testing]
- The Kubelet's `--experimental-allocatable-ignore-eviction` option is now marked as deprecated. ([#91578](https://github.com/kubernetes/kubernetes/pull/91578), [@knabben](https://github.com/knabben)) [SIG Node]
- The Kubelet's `--experimental-mounter-path` and `--experimental-check-node-capabilities-before-mount` options are now marked as deprecated. ([#91373](https://github.com/kubernetes/kubernetes/pull/91373), [@knabben](https://github.com/knabben))
- The PR adds functionality to generate events when a PV or PVC processing encounters certain failures. The events help users to know the reason for the failure so they can take necessary recovery actions. ([#89845](https://github.com/kubernetes/kubernetes/pull/89845), [@yuga711](https://github.com/yuga711)) [SIG Apps]
- The PodShareProcessNamespace feature gate has been removed, and the PodShareProcessNamespace is unconditionally enabled. ([#90099](https://github.com/kubernetes/kubernetes/pull/90099), [@tanjunchen](https://github.com/tanjunchen)) [SIG Node]
- The kube-apiserver `--kubelet-https` flag is deprecated. kube-apiserver connections to kubelets now unconditionally use `https` (kubelets have unconditionally used `https` to serve the endpoints the apiserver communicates with since before v1.0). ([#91630](https://github.com/kubernetes/kubernetes/pull/91630), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Node]
- Update CNI to v0.8.6 ([#91370](https://github.com/kubernetes/kubernetes/pull/91370), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Network, Release and Testing]
- Update Golang to v1.14.5
  - Update repo-infra to 0.0.7 (to support go1.14.5 and go1.13.13)
    - Includes:
      - bazelbuild/bazel-toolchains@3.3.2
      - bazelbuild/rules_go@v0.22.7 ([#93088](https://github.com/kubernetes/kubernetes/pull/93088), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]
- Update Golang to v1.14.6
  - Update repo-infra to 0.0.8 (to support go1.14.6 and go1.13.14)
    - Includes:
      - bazelbuild/bazel-toolchains@3.4.0
      - bazelbuild/rules_go@v0.22.8 ([#93198](https://github.com/kubernetes/kubernetes/pull/93198), [@justaugustus](https://github.com/justaugustus)) [SIG Release and Testing]
- Update corefile-migration library to 1.0.8 ([#91856](https://github.com/kubernetes/kubernetes/pull/91856), [@wawa0210](https://github.com/wawa0210)) [SIG Node]
- Update default etcd server version to 3.4.4 ([#89214](https://github.com/kubernetes/kubernetes/pull/89214), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cluster Lifecycle and Testing]
- Update default etcd server version to 3.4.7 ([#89895](https://github.com/kubernetes/kubernetes/pull/89895), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cluster Lifecycle and Testing]
- Update default etcd server version to 3.4.9 ([#92349](https://github.com/kubernetes/kubernetes/pull/92349), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- Update go.etcd.io/bbolt to v1.3.5 ([#92350](https://github.com/kubernetes/kubernetes/pull/92350), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery and Cloud Provider]
- Update opencontainers/runtime-spec dependency to v1.0.2 ([#89644](https://github.com/kubernetes/kubernetes/pull/89644), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- `beta.kubernetes.io/os` and `beta.kubernetes.io/arch` node labels are deprecated. Update node selectors to use `kubernetes.io/os` and `kubernetes.io/arch`. ([#91046](https://github.com/kubernetes/kubernetes/pull/91046), [@wawa0210](https://github.com/wawa0210)) [SIG Apps and Node]
- `kubectl config view` now redacts bearer tokens by default, similar to client certificates. The `--raw` flag can still be used to output full content. ([#88985](https://github.com/kubernetes/kubernetes/pull/88985), [@puerco](https://github.com/puerco))

## Dependencies

### Added
- cloud.google.com/go/bigquery: v1.0.1
- cloud.google.com/go/datastore: v1.0.0
- cloud.google.com/go/pubsub: v1.0.1
- cloud.google.com/go/storage: v1.0.0
- dmitri.shuralyov.com/gpu/mtl: 666a987
- github.com/cespare/xxhash/v2: [v2.1.1](https://github.com/cespare/xxhash/v2/tree/v2.1.1)
- github.com/checkpoint-restore/go-criu/v4: [v4.0.2](https://github.com/checkpoint-restore/go-criu/v4/tree/v4.0.2)
- github.com/chzyer/logex: [v1.1.10](https://github.com/chzyer/logex/tree/v1.1.10)
- github.com/chzyer/readline: [2972be2](https://github.com/chzyer/readline/tree/2972be2)
- github.com/chzyer/test: [a1ea475](https://github.com/chzyer/test/tree/a1ea475)
- github.com/containerd/cgroups: [0dbf7f0](https://github.com/containerd/cgroups/tree/0dbf7f0)
- github.com/containerd/continuity: [aaeac12](https://github.com/containerd/continuity/tree/aaeac12)
- github.com/containerd/fifo: [a9fb20d](https://github.com/containerd/fifo/tree/a9fb20d)
- github.com/containerd/go-runc: [5a6d9f3](https://github.com/containerd/go-runc/tree/5a6d9f3)
- github.com/containerd/ttrpc: [v1.0.0](https://github.com/containerd/ttrpc/tree/v1.0.0)
- github.com/coreos/bbolt: [v1.3.2](https://github.com/coreos/bbolt/tree/v1.3.2)
- github.com/coreos/go-systemd/v22: [v22.1.0](https://github.com/coreos/go-systemd/v22/tree/v22.1.0)
- github.com/cpuguy83/go-md2man/v2: [v2.0.0](https://github.com/cpuguy83/go-md2man/v2/tree/v2.0.0)
- github.com/docopt/docopt-go: [ee0de3b](https://github.com/docopt/docopt-go/tree/ee0de3b)
- github.com/go-gl/glfw/v3.3/glfw: [12ad95a](https://github.com/go-gl/glfw/v3.3/glfw/tree/12ad95a)
- github.com/go-ini/ini: [v1.9.0](https://github.com/go-ini/ini/tree/v1.9.0)
- github.com/godbus/dbus/v5: [v5.0.3](https://github.com/godbus/dbus/v5/tree/v5.0.3)
- github.com/ianlancetaylor/demangle: [5e5cf60](https://github.com/ianlancetaylor/demangle/tree/5e5cf60)
- github.com/ishidawataru/sctp: [7c296d4](https://github.com/ishidawataru/sctp/tree/7c296d4)
- github.com/moby/ipvs: [v1.0.1](https://github.com/moby/ipvs/tree/v1.0.1)
- github.com/moby/sys/mountinfo: [v0.1.3](https://github.com/moby/sys/mountinfo/tree/v0.1.3)
- github.com/moby/term: [672ec06](https://github.com/moby/term/tree/672ec06)
- github.com/russross/blackfriday/v2: [v2.0.1](https://github.com/russross/blackfriday/v2/tree/v2.0.1)
- github.com/shurcooL/sanitized_anchor_name: [v1.0.0](https://github.com/shurcooL/sanitized_anchor_name/tree/v1.0.0)
- github.com/ugorji/go: [v1.1.4](https://github.com/ugorji/go/tree/v1.1.4)
- github.com/yuin/goldmark: [v1.1.27](https://github.com/yuin/goldmark/tree/v1.1.27)
- google.golang.org/protobuf: v1.24.0
- gotest.tools/v3: v3.0.2
- k8s.io/klog/v2: v2.2.0

### Changed
- cloud.google.com/go: v0.38.0 → v0.51.0
- github.com/Azure/azure-sdk-for-go: [v35.0.0+incompatible → v43.0.0+incompatible](https://github.com/Azure/azure-sdk-for-go/compare/v35.0.0...v43.0.0)
- github.com/Azure/go-autorest/autorest/adal: [v0.5.0 → v0.8.2](https://github.com/Azure/go-autorest/autorest/adal/compare/v0.5.0...v0.8.2)
- github.com/Azure/go-autorest/autorest/date: [v0.1.0 → v0.2.0](https://github.com/Azure/go-autorest/autorest/date/compare/v0.1.0...v0.2.0)
- github.com/Azure/go-autorest/autorest/mocks: [v0.2.0 → v0.3.0](https://github.com/Azure/go-autorest/autorest/mocks/compare/v0.2.0...v0.3.0)
- github.com/Azure/go-autorest/autorest: [v0.9.0 → v0.9.6](https://github.com/Azure/go-autorest/autorest/compare/v0.9.0...v0.9.6)
- github.com/GoogleCloudPlatform/k8s-cloud-provider: [27a4ced → 7901bc8](https://github.com/GoogleCloudPlatform/k8s-cloud-provider/compare/27a4ced...7901bc8)
- github.com/Microsoft/go-winio: [v0.4.14 → fc70bd9](https://github.com/Microsoft/go-winio/compare/v0.4.14...fc70bd9)
- github.com/Microsoft/hcsshim: [672e52e → 5eafd15](https://github.com/Microsoft/hcsshim/compare/672e52e...5eafd15)
- github.com/alecthomas/template: [a0175ee → fb15b89](https://github.com/alecthomas/template/compare/a0175ee...fb15b89)
- github.com/alecthomas/units: [2efee85 → c3de453](https://github.com/alecthomas/units/compare/2efee85...c3de453)
- github.com/beorn7/perks: [v1.0.0 → v1.0.1](https://github.com/beorn7/perks/compare/v1.0.0...v1.0.1)
- github.com/cilium/ebpf: [95b36a5 → 1c8d4c9](https://github.com/cilium/ebpf/compare/95b36a5...1c8d4c9)
- github.com/containerd/console: [84eeaae → v1.0.0](https://github.com/containerd/console/compare/84eeaae...v1.0.0)
- github.com/containerd/containerd: [v1.0.2 → v1.3.3](https://github.com/containerd/containerd/compare/v1.0.2...v1.3.3)
- github.com/containerd/typeurl: [2a93cfd → v1.0.0](https://github.com/containerd/typeurl/compare/2a93cfd...v1.0.0)
- github.com/containernetworking/cni: [v0.7.1 → v0.8.0](https://github.com/containernetworking/cni/compare/v0.7.1...v0.8.0)
- github.com/coredns/corefile-migration: [v1.0.6 → v1.0.10](https://github.com/coredns/corefile-migration/compare/v1.0.6...v1.0.10)
- github.com/coreos/pkg: [97fdf19 → 399ea9e](https://github.com/coreos/pkg/compare/97fdf19...399ea9e)
- github.com/docker/docker: [be7ac8b → aa6a989](https://github.com/docker/docker/compare/be7ac8b...aa6a989)
- github.com/docker/go-connections: [v0.3.0 → v0.4.0](https://github.com/docker/go-connections/compare/v0.3.0...v0.4.0)
- github.com/evanphx/json-patch: [v4.2.0+incompatible → e83c0a1](https://github.com/evanphx/json-patch/compare/v4.2.0...e83c0a1)
- github.com/fsnotify/fsnotify: [v1.4.7 → v1.4.9](https://github.com/fsnotify/fsnotify/compare/v1.4.7...v1.4.9)
- github.com/go-kit/kit: [v0.8.0 → v0.9.0](https://github.com/go-kit/kit/compare/v0.8.0...v0.9.0)
- github.com/go-logfmt/logfmt: [v0.3.0 → v0.4.0](https://github.com/go-logfmt/logfmt/compare/v0.3.0...v0.4.0)
- github.com/go-logr/logr: [v0.1.0 → v0.2.0](https://github.com/go-logr/logr/compare/v0.1.0...v0.2.0)
- github.com/golang/groupcache: [02826c3 → 215e871](https://github.com/golang/groupcache/compare/02826c3...215e871)
- github.com/golang/protobuf: [v1.3.2 → v1.4.2](https://github.com/golang/protobuf/compare/v1.3.2...v1.4.2)
- github.com/google/cadvisor: [v0.35.0 → v0.37.0](https://github.com/google/cadvisor/compare/v0.35.0...v0.37.0)
- github.com/google/go-cmp: [v0.3.0 → v0.4.0](https://github.com/google/go-cmp/compare/v0.3.0...v0.4.0)
- github.com/google/pprof: [3ea8567 → d4f498a](https://github.com/google/pprof/compare/3ea8567...d4f498a)
- github.com/googleapis/gax-go/v2: [v2.0.4 → v2.0.5](https://github.com/googleapis/gax-go/v2/compare/v2.0.4...v2.0.5)
- github.com/googleapis/gnostic: [v0.1.0 → v0.4.1](https://github.com/googleapis/gnostic/compare/v0.1.0...v0.4.1)
- github.com/gorilla/mux: [v1.7.0 → v1.7.3](https://github.com/gorilla/mux/compare/v1.7.0...v1.7.3)
- github.com/json-iterator/go: [v1.1.8 → v1.1.10](https://github.com/json-iterator/go/compare/v1.1.8...v1.1.10)
- github.com/jstemmer/go-junit-report: [af01ea7 → v0.9.1](https://github.com/jstemmer/go-junit-report/compare/af01ea7...v0.9.1)
- github.com/konsorten/go-windows-terminal-sequences: [v1.0.1 → v1.0.3](https://github.com/konsorten/go-windows-terminal-sequences/compare/v1.0.1...v1.0.3)
- github.com/kr/pretty: [v0.1.0 → v0.2.0](https://github.com/kr/pretty/compare/v0.1.0...v0.2.0)
- github.com/mattn/go-isatty: [v0.0.9 → v0.0.4](https://github.com/mattn/go-isatty/compare/v0.0.9...v0.0.4)
- github.com/matttproud/golang_protobuf_extensions: [v1.0.1 → c182aff](https://github.com/matttproud/golang_protobuf_extensions/compare/v1.0.1...c182aff)
- github.com/mistifyio/go-zfs: [v2.1.1+incompatible → f784269](https://github.com/mistifyio/go-zfs/compare/v2.1.1...f784269)
- github.com/mrunalp/fileutils: [7d4729f → abd8a0e](https://github.com/mrunalp/fileutils/compare/7d4729f...abd8a0e)
- github.com/opencontainers/runc: [v1.0.0-rc10 → 819fcc6](https://github.com/opencontainers/runc/compare/v1.0.0-rc10...819fcc6)
- github.com/opencontainers/runtime-spec: [v1.0.0 → 237cc4f](https://github.com/opencontainers/runtime-spec/compare/v1.0.0...237cc4f)
- github.com/opencontainers/selinux: [5215b18 → v1.5.2](https://github.com/opencontainers/selinux/compare/5215b18...v1.5.2)
- github.com/pkg/errors: [v0.8.1 → v0.9.1](https://github.com/pkg/errors/compare/v0.8.1...v0.9.1)
- github.com/prometheus/client_golang: [v1.0.0 → v1.7.1](https://github.com/prometheus/client_golang/compare/v1.0.0...v1.7.1)
- github.com/prometheus/common: [v0.4.1 → v0.10.0](https://github.com/prometheus/common/compare/v0.4.1...v0.10.0)
- github.com/prometheus/procfs: [v0.0.2 → v0.1.3](https://github.com/prometheus/procfs/compare/v0.0.2...v0.1.3)
- github.com/rubiojr/go-vhd: [0bfd3b3 → 02e2102](https://github.com/rubiojr/go-vhd/compare/0bfd3b3...02e2102)
- github.com/sirupsen/logrus: [v1.4.2 → v1.6.0](https://github.com/sirupsen/logrus/compare/v1.4.2...v1.6.0)
- github.com/spf13/cobra: [v0.0.5 → v1.0.0](https://github.com/spf13/cobra/compare/v0.0.5...v1.0.0)
- github.com/spf13/viper: [v1.3.2 → v1.4.0](https://github.com/spf13/viper/compare/v1.3.2...v1.4.0)
- github.com/tmc/grpc-websocket-proxy: [89b8d40 → 0ad062e](https://github.com/tmc/grpc-websocket-proxy/compare/89b8d40...0ad062e)
- github.com/urfave/cli: [v1.20.0 → v1.22.2](https://github.com/urfave/cli/compare/v1.20.0...v1.22.2)
- github.com/vishvananda/netlink: [v1.0.0 → v1.1.0](https://github.com/vishvananda/netlink/compare/v1.0.0...v1.1.0)
- github.com/vishvananda/netns: [be1fbed → 52d707b](https://github.com/vishvananda/netns/compare/be1fbed...52d707b)
- go.etcd.io/bbolt: v1.3.3 → v1.3.5
- go.etcd.io/etcd: 3cf2f69 → 18dfb9c
- go.opencensus.io: v0.21.0 → v0.22.2
- go.uber.org/atomic: v1.3.2 → v1.4.0
- golang.org/x/crypto: bac4c82 → 75b2880
- golang.org/x/exp: 4b39c73 → da58074
- golang.org/x/image: 0694c2d → cff245a
- golang.org/x/lint: 959b441 → fdd1cda
- golang.org/x/mobile: d3739f8 → d2bd2a2
- golang.org/x/mod: 4bf6d31 → v0.3.0
- golang.org/x/net: 13f9640 → ab34263
- golang.org/x/oauth2: 0f29369 → 858c2ad
- golang.org/x/sys: fde4db3 → ed371f2
- golang.org/x/text: v0.3.2 → v0.3.3
- golang.org/x/time: 9d24e82 → 555d28b
- golang.org/x/tools: 65e3620 → c1934b7
- golang.org/x/xerrors: a985d34 → 9bdfabe
- google.golang.org/api: 5213b80 → v0.15.1
- google.golang.org/appengine: v1.5.0 → v1.6.5
- google.golang.org/genproto: 24fa4b2 → cb27e3a
- google.golang.org/grpc: v1.26.0 → v1.27.0
- gopkg.in/check.v1: 788fd78 → 41f04d3
- honnef.co/go/tools: v0.0.1-2019.2.2 → v0.0.1-2019.2.3
- k8s.io/gengo: 36b2048 → 8167cfd
- k8s.io/kube-openapi: bf4fb3b → 656914f
- k8s.io/system-validators: v1.0.4 → v1.1.2
- k8s.io/utils: 0a110f9 → d5654de
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.7 → v0.0.9
- sigs.k8s.io/structured-merge-diff/v3: v3.0.0 → 43c19bb

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
- github.com/checkpoint-restore/go-criu: [17b0214](https://github.com/checkpoint-restore/go-criu/tree/17b0214)
- github.com/client9/misspell: [v0.3.4](https://github.com/client9/misspell/tree/v0.3.4)
- github.com/coreos/go-etcd: [v2.0.0+incompatible](https://github.com/coreos/go-etcd/tree/v2.0.0)
- github.com/cpuguy83/go-md2man: [v1.0.10](https://github.com/cpuguy83/go-md2man/tree/v1.0.10)
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
- github.com/godbus/dbus: [2ff6f7f](https://github.com/godbus/dbus/tree/2ff6f7f)
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
