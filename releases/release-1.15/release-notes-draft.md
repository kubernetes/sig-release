# Kubernetes v1.15 Release Notes

## 1.15 What’s New

A complete changelog for the release notes is now hosted in a customizable format at [https://relnotes.k8s.io/](https://relnotes.k8s.io/?releaseVersions=1.15.0). Check it out and please give us your feedback!

Kubernetes 1.15 consists of **25 enhancements**: 2 moving to stable, 13 in beta, and 10 in alpha. The main themes of this release are:

#### Continuous Improvement
- Project sustainability is not just about features. Many SIGs have been working on  improving test coverage, ensuring the basics stay reliable, and stability of the core feature set and working on maturing existing features and cleaning up the backlog.

#### Extensibility

- The community has been asking for continuing support of extensibility, so this cycle features more work around CRDs and API Machinery. Most of the enhancements in this cycle were from SIG API Machinery and related areas.

### Extensibility around core Kubernetes APIs

#### CustomResourceDefinitions Pruning
To enforce both data consistency and security, Kubernetes performs pruning, or the automatic removal of unknown fields in objects sent to a Kubernetes API. An "unknown" field is one that is not specified in the OpenAPI validation schema. This behavior is already in place for native resources and ensures only data structures specified by the CRD developer are persisted to etcd. It will be available as a beta feature in Kubernetes 1.15.

Pruning is activated by setting `spec.preserveUnknownFields: false` in the CustomResourceDefinition. A future apiextensions.k8s.io/v1 variant of CRDs will enforce pruning.

Pruning requires that CRD developer provides complete, structural validation schemas, either at the top-level or for all versions of the CRD.

#### CustomResourceDefinition Defaulting

CustomResourceDefinitions also have new support for defaulting, with defaults specified using the `default` keyword in the OpenAPI validation schema. Defaults are set for unspecified fields in an object sent to the API, and when reading from etcd.

Defaulting will be available as alpha in Kubernetes 1.15 and requires structural schemas.

#### CustomResourceDefinition OpenAPI Publishing

OpenAPI specs for native types have long been served at /openapi/v2, and they are consumed by a number of components, notably kubectl client-side validation, kubectl explain and OpenAPI based client generators.

With Kubernetes 1.15 as beta, OpenAPI schemas are also published for CRDs, as long as their schemas are structural.

These changes are reflected in the following Kubernetes enhancements:
([#383](https://github.com/kubernetes/enhancements/issues/383)), ([#575](https://github.com/kubernetes/enhancements/issues/575) ), ([#492](https://github.com/kubernetes/enhancements/issues/492) ), ([#598](https://github.com/kubernetes/enhancements/issues/598) ), ([#692](https://github.com/kubernetes/enhancements/issues/692) ), ([#95](https://github.com/kubernetes/enhancements/issues/95) ), ([#995](https://github.com/kubernetes/enhancements/issues/995) ), ([#956](https://github.com/kubernetes/enhancements/issues/956) )

### Cluster Lifecycle Stability and Usability Improvements
Work on making Kubernetes installation, upgrade and configuration even more robust has been a major focus for this cycle for SIG Cluster Lifecycle (see the May 6, 2019 [Community Update](https://docs.google.com/presentation/d/1QUOsQxfEfHlMq4lPjlK2ewQHsr9peEKymDw5_XwZm8Q/edit?usp=sharing)). Bug fixes across bare metal tooling and production-ready user stories, such as the high availability use cases have been given priority for 1.15.

kubeadm, the cluster lifecycle building block, continues to receive features and stability work required for bootstrapping production clusters efficiently. kubeadm has promoted high availability (HA) capability to beta, allowing users to use the familiar `kubeadm init` and `kubeadm join` commands to [configure and deploy an HA control plane](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/). An entire new test suite has been created specifically for ensuring these features will stay stable over time.

Certificate management has become more robust in 1.15, with kubeadm now seamlessly rotating all your certificates (on upgrades) before they expire. Check the [kubeadm documentation](https://github.com/kubernetes/website/blob/dev-1.15/content/en/docs/reference/setup-tools/kubeadm/kubeadm-alpha.md) for information on how to manage your certificates.

The kubeadm configuration file API is moving from v1beta1 to v1beta2 in 1.15.

These changes are reflected in the following Kubernetes enhancements:
([#357](https://github.com/kubernetes/enhancements/issues/357) ), ([#970](https://github.com/kubernetes/enhancements/issues/970) )

### Continued improvement of CSI
In Kubernetes v1.15, SIG Storage continued work to [enable migration of in-tree volume plugins](https://github.com/kubernetes/enhancements/issues/625) to the Container Storage Interface (CSI). SIG Storage worked on bringing CSI to feature parity with in-tree functionality, including functionality like resizing, inline volumes, and more. SIG Storage introduces new alpha functionality in CSI that doesn't exist in the Kubernetes Storage subsystem yet, like volume cloning.

Volume cloning enables users to specify another PVC as a "DataSource" when provisioning a new volume. If the underlying storage system supports this functionality and implements the "CLONE_VOLUME" capability in its CSI driver, then the new volume becomes a clone of the source volume.

These changes are reflected in the following Kubernetes enhancements:
([#625](https://github.com/kubernetes/enhancements/issues/625))

#### Additional Notable Feature Updates
- Support for go modules in Kubernetes Core.
- Continued preparation for cloud provider extraction and code organization.  The cloud provider code has been moved to kubernetes/legacy-cloud-providers for easier removal later and external consumption.
- Kubectl [get and describe](https://github.com/kubernetes/enhancements/issues/515) now works with extensions
- Nodes now support [third party monitoring plugins](https://github.com/kubernetes/enhancements/issues/606).
- A new [Scheduling Framework](https://github.com/kubernetes/enhancements/issues/624) for schedule plugins is now Alpha.
- ExecutionHook API [designed to trigger hook commands](https://github.com/kubernetes/enhancements/issues/962) in containers is now Alpha.
- Continued deprecation of extensions/v1beta1, apps/v1beta1, and apps/v1beta2 APIs; these extensions will be retired in 1.16!

Check the [release notes website](https://relnotes.k8s.io/?releaseVersions=1.15.0) for the complete changelog of notable features and fixes.




## Known Issues

- Concurrently joining control-plane nodes does not work as expected in kubeadm 1.15.0. The feature was planned for release in 1.15.0, but a fix may  come in a follow up patch release.

- Using `--log-file` is known to be problematic in 1.15. This presents as things being logged multiple times to the same file. The behaviour and details of this issue, as well as some preliminary attempts at fixing it are documented [here](https://github.com/kubernetes/kubernetes/issues/78734#issuecomment-501372131)

## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

#### API Machinery

- `k8s.io/kubernetes` and published components (such as `k8s.io/client-go` and `k8s.io/api`) now contain go module files including dependency version information. See [go-modules](http://git.k8s.io/client-go/INSTALL.md#go-modules) for details on consuming `k8s.io/client-go` using go modules. ([#74877](https://github.com/kubernetes/kubernetes/pull/74877), [@liggitt](https://github.com/liggitt))

#### Apps

- Hyperkube short aliases have been removed from source code, because hyperkube docker image currently creates these aliases. ([#76953](https://github.com/kubernetes/kubernetes/pull/76953), [@Rand01ph](https://github.com/Rand01ph))

#### Auth

- The Rancher credential provider has now been removed. This only affects you if you are using the downstream Rancher distro. ([#77099](https://github.com/kubernetes/kubernetes/pull/77099), [@dims](https://github.com/dims))


#### AWS

- The `system:aws-cloud-provider` cluster role, deprecated in v1.13, is no longer auto-created. Deployments using the AWS cloud provider should grant required permissions to the `aws-cloud-provider` service account in the `kube-system` namespace as part of deployment.  ([#66635](https://github.com/kubernetes/kubernetes/pull/66635), [@wgliang](https://github.com/wgliang))

#### Azure

- Kubelet can now run without identity on Azure. A sample cloud provider configuration is:  `{"vmType": "vmss", "useInstanceMetadata": true, "subscriptionId": "<subscriptionId>"}` ([#77906](https://github.com/kubernetes/kubernetes/pull/77906), [@feiskyer](https://github.com/feiskyer))
- Multiple Kubernetes clusters can now share the same resource group
    - When upgrading from previous releases, issues will arise with public IPs if multiple clusters share the same resource group. To solve these problems, make the following changes to the cluster:
Recreate the relevant LoadBalancer services, or add a new tag 'kubernetes-cluster-name: <cluster-name>' manually for existing public IPs.
Configure each cluster with a different cluster name using `kube-controller-manager --cluster-name=<cluster-name>` ([#77630](https://github.com/kubernetes/kubernetes/pull/77630), [@feiskyer](https://github.com/feiskyer))
- The cloud config for Azure cloud provider can now be initialized from Kubernetes secret azure-cloud-provider in kube-system namespace
    - the secret is a serialized version of `azure.json` file with key cloud-config. And the secret name is azure-cloud-provider.
    - A new option cloudConfigType has been added to the cloud-config file. Supported values are: `file`, `secret` and `merge` (`merge` is the default value).
    - To allow Azure cloud provider to read secrets, the [RBAC rules](https://github.com/kubernetes/kubernetes/pull/78242) should be configured.

#### CLI

- `kubectl scale job`, deprecated since 1.10, has been removed. ([#78445](https://github.com/kubernetes/kubernetes/pull/78445), [@soltysh](https://github.com/soltysh))
- The deprecated `--pod`/`-p` flag for `kubectl exec` has been removed. The flag has been marked as deprecated since k8s version v1.12. ([#76713](https://github.com/kubernetes/kubernetes/pull/76713), [@prksu](https://github.com/prksu))


#### Lifecycle

- Support for deprecated old kubeadm v1alpha3 config has been totally removed. ([#75179](https://github.com/kubernetes/kubernetes/pull/75179), [@rosti](https://github.com/rosti))
- kube-up.sh no longer supports "centos" and "local" providers. ([#76711](https://github.com/kubernetes/kubernetes/pull/76711), [@dims](https://github.com/dims))

#### Network

- The deprecated flag `--conntrack-max` has been removed from kube-proxy. Users of this flag should switch to `--conntrack-min` and `--conntrack-max-per-core` instead. ([#78399](https://github.com/kubernetes/kubernetes/pull/78399), [@rikatz](https://github.com/rikatz))
- The deprecated kube-proxy flag `--cleanup-iptables` has been removed. ([#78344](https://github.com/kubernetes/kubernetes/pull/78344), [@aramase](https://github.com/aramase))

#### Node

- The deprecated kubelet security controls `AllowPrivileged`, `HostNetworkSources`, `HostPIDSources`, and `HostIPCSources` have been removed. Enforcement of these restrictions should be done through admission control (such as `PodSecurityPolicy`) instead. ([#77820](https://github.com/kubernetes/kubernetes/pull/77820), [@dims](https://github.com/dims))
- The deprecated Kubelet flag `--allow-privileged` has been removed. Remove any use of the flag from your kubelet scripts or manifests. ([#77820](https://github.com/kubernetes/kubernetes/pull/77820), [@dims](https://github.com/dims))
- The kubelet now only collects cgroups metrics for the node, container runtime, kubelet, pods, and containers. ([#72787](https://github.com/kubernetes/kubernetes/pull/72787), [@dashpole](https://github.com/dashpole))

#### Storage

- The `Node.Status.Volumes.Attached.DevicePath` field is now unset for CSI volumes. You must update any external controllers that depend on this field. ([#75799](https://github.com/kubernetes/kubernetes/pull/75799), [@msau42](https://github.com/msau42))
- CSI alpha CRDs have been removed ([#75747](https://github.com/kubernetes/kubernetes/pull/75747), [@msau42](https://github.com/msau42))
- The `StorageObjectInUseProtection` admission plugin is enabled by default, so  the default enabled admission plugins are now `NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota,StorageObjectInUseProtection`. Please note that if you previously had not set the `--admission-control` flag, your cluster behavior may change (to be more standard). ([#74610](https://github.com/kubernetes/kubernetes/pull/74610), [@oomichi](https://github.com/oomichi))



## Deprecations and Removals

- kubectl
  - `kubectl convert`, deprecated since v1.14, will be removed in v1.17.
  - The `--export` flag for the `kubectl get` command, deprecated since v1.14, will be removed in v1.18.
  - The `--pod`/`-p` flag for `kubectl exec`, deprecated since 1.12, has been removed.
  - `kubectl scale job`, deprecated since 1.10, has been removed. ([#78445](https://github.com/kubernetes/kubernetes/pull/78445), [@soltysh](https://github.com/soltysh))


- kubelet
  - The `beta.kubernetes.io/os` and `beta.kubernetes.io/arch` labels, deprecated since v1.14, are targeted for removal in v1.18.
  - The `--containerized` flag, deprecated since v1.14, will be removed in a future release.
  - cAdvisor json endpoints have been deprecated. ([#78504](https://github.com/kubernetes/kubernetes/pull/78504), [@dashpole](https://github.com/dashpole))

- kube-apiserver
  - The `--enable-logs-handler` flag and log-serving functionality is deprecated, and scheduled to be removed in v1.19. ([#77611](https://github.com/kubernetes/kubernetes/pull/77611), [@rohitsardesai83](https://github.com/rohitsardesai83))

- kube-proxy
  - The deprecated `--cleanup-iptables` has been removed,. ([#78344](https://github.com/kubernetes/kubernetes/pull/78344), [@aramase](https://github.com/aramase))


- API
  - Ingress resources will no longer be served from `extensions/v1beta1` in v1.19. Migrate use to the `networking.k8s.io/v1beta1` API, available since v1.14. Existing persisted data can be retrieved via the `networking.k8s.io/v1beta1` API.
  - NetworkPolicy resources will no longer be served from `extensions/v1beta1` in v1.16. Migrate use to the `networking.k8s.io/v1` API, available since v1.8. Existing persisted data can be retrieved via the `networking.k8s.io/v1` API.
  - PodSecurityPolicy resources will no longer be served from `extensions/v1beta1` in v1.16. Migrate to the `policy/v1beta1` API, available since v1.10. Existing persisted data can be retrieved via the `policy/v1beta1` API.
  - DaemonSet, Deployment, and ReplicaSet resources will no longer be served from `extensions/v1beta1`, `apps/v1beta1`, or `apps/v1beta2` in v1.16. Migrate to the `apps/v1` API, available since v1.9. Existing persisted data can be retrieved via the `apps/v1` API.
  - PriorityClass resources will no longer be served from `scheduling.k8s.io/v1beta1` and `scheduling.k8s.io/v1alpha1` in v1.17. Migrate use to the `scheduling.k8s.io/v1` API, available since v1.14. Existing persisted data can be retrieved via the `scheduling.k8s.io/v1` API.
  - The `export` query parameter for list API calls, deprecated since v1.14, will be removed in v1.18.
  - The `series.state` field in the events.k8s.io/v1beta1 Event API is deprecated and will be removed in v1.18 ([#75987](https://github.com/kubernetes/kubernetes/pull/75987), [@yastij](https://github.com/yastij))

- kubeadm
  - The `kubeadm upgrade node config` and `kubeadm upgrade node experimental-control-plane` commands are deprecated in favor of `kubeadm upgrade node`, and will be removed in a future release. ([#78408](https://github.com/kubernetes/kubernetes/pull/78408), [@fabriziopandini](https://github.com/fabriziopandini))
  - The flag `--experimental-control-plane` is now deprecated in favor of  `--control-plane`. The flag `--experimental-upload-certs` is now deprecated in favor of `--upload-certs` ([#78452](https://github.com/kubernetes/kubernetes/pull/78452), [@fabriziopandini](https://github.com/fabriziopandini))
  - `kubeadm config upload` has been deprecated, as its replacement is now graduated. Please use `kubeadm init phase upload-config` instead. ([#77946](https://github.com/kubernetes/kubernetes/pull/77946), [@Klaven](https://github.com/Klaven))

- The following features are now GA, and the associated feature gates are deprecated and will be removed in v1.17:
  - `GCERegionalPersistentDisk`

## Metrics Changes

### Added metrics

- The metric `kube_proxy_sync_proxy_rules_last_timestamp_seconds` is now available, indicating the last time that kube-proxy successfully applied proxying rules. ([#74027](https://github.com/kubernetes/kubernetes/pull/74027), [@squeed](https://github.com/squeed))
- `process_start_time_seconds` has been added to kubelet’s '/metrics/probes' endpoint ([#77975](https://github.com/kubernetes/kubernetes/pull/77975), [@logicalhan](https://github.com/logicalhan))
- Scheduler: added metrics to record the number of pending pods in different queues ([#75501](https://github.com/kubernetes/kubernetes/pull/75501), [@Huang-Wei](https://github.com/Huang-Wei))
- Exposed CSI volume stats via kubelet volume metrics ([#76188](https://github.com/kubernetes/kubernetes/pull/76188), [@humblec](https://github.com/humblec))
- Added a new `storage_operation_status_count` metric for kube-controller-manager and kubelet to count success and error statues. ([#75750](https://github.com/kubernetes/kubernetes/pull/75750), [@msau42](https://github.com/msau42))

### Deprecated/changed metrics

- kubelet probe metrics are now of the counter type rather than the gauge type, and the `prober_probe_result` has been replaced by `prober_probe_total`. ([#76074](https://github.com/kubernetes/kubernetes/pull/76074), [@danielqsj](https://github.com/danielqsj))
- The `transformer_failures_total` metric is deprecated in favor of `transformation_operation_total`. The old metric will continue to be populated but will be removed in a future release. ([#70715](https://github.com/kubernetes/kubernetes/pull/70715), [@immutableT](https://github.com/immutableT))
- Introducing new semantic for metric `volume_operation_total_seconds` to be the end to end latency of volume provisioning/deletion. Existing metric "storage_operation_duration_seconds" will remain untouched, however it is exposed to the following potential issues:
  1. For volumes provisioned/deleted via external provisioner/deleter, `storage_operation_duration_seconds` will NOT wait for the external operation to be done before reporting latency metric (effectively close to 0). This will be fixed by using `volume_operation_total_seconds` instead
  2. if there's a transient error happened during "provisioning/deletion", i.e., a volume is still in-use while a deleteVolume has been called, original `storage_operation_duration_seconds` will NOT wait until a volume has been finally deleted before reporting an inaccurate latency metric. The newly implemented metric `volume_operation_total_seconds`, however, waits until a provisioning/deletion operation has been fully executed.

    Potential impacts:
    If an SLO/alert has been defined based on `volume_operation_total_seconds`, it might get violated because of the more accurate metric might be significantly larger than previously reported. The metric is defined to be a histogram and the new semantic could change the distribution. ([#78061](https://github.com/kubernetes/kubernetes/pull/78061), [@yuxiangqian](https://github.com/yuxiangqian))

- Implement the scheduling framework with `Reserve`, `Prebind`, `Permit`, `Post-bind`, `Queue sort` and `Unreserve` extension points.
([#77567](https://github.com/kubernetes/kubernetes/pull/77567), [@wgliang](https://github.com/wgliang))
([#77559](https://github.com/kubernetes/kubernetes/pull/77559), [@ahg-g](https://github.com/ahg-g))
([#77529](https://github.com/kubernetes/kubernetes/pull/77529), [@draveness](https://github.com/draveness))
([#77598](https://github.com/kubernetes/kubernetes/pull/77598), [@danielqsj](https://github.com/danielqsj))
([#77501](https://github.com/kubernetes/kubernetes/pull/77501), [@JieJhih](https://github.com/JieJhih))
([#77457](https://github.com/kubernetes/kubernetes/pull/77457), [@danielqsj](https://github.com/danielqsj))
- Replaced *_admission_latencies_milliseconds_summary and *_admission_latencies_milliseconds metrics because they were reporting seconds rather than milliseconds. They were also subject to multiple naming guideline violations (units should be in base units and "duration" is the best practice labelling to measure the time a request takes). Please convert to use *_admission_duration_seconds and *_admission_duration_seconds_summary, as these now report the unit as described, and follow the instrumentation best practices. ([#75279](https://github.com/kubernetes/kubernetes/pull/75279), [@danielqsj](https://github.com/danielqsj))
- Fixed admission metrics histogram bucket sizes to cover 25ms to ~2.5 seconds. ([#78608](https://github.com/kubernetes/kubernetes/pull/78608), [@jpbetz](https://github.com/jpbetz))
- Fixed incorrect prometheus azure metrics. ([#77722](https://github.com/kubernetes/kubernetes/pull/77722), [@andyzhangx](https://github.com/andyzhangx))
- `kubectl scale job`, deprecated since 1.10, has been removed. ([#78445](https://github.com/kubernetes/kubernetes/pull/78445), [@soltysh](https://github.com/soltysh))



## Notable Features

### Stable

- You can now create a non-preempting Pod priority. If set on a class, the pod will continue to be prioritized above queued pods of a lesser class, but will not preempt running pods. ([#74614](https://github.com/kubernetes/kubernetes/pull/74614), [@denkensk](https://github.com/denkensk))

- Third party device monitoring is now enabled by default (KubeletPodResources). ([#77274](https://github.com/kubernetes/kubernetes/pull/77274), [@RenaudWasTaken](https://github.com/RenaudWasTaken))
- The kube-apiserver’s `watch` can now be enabled for events using the `--watch-cache-sizes` flag. ([#74321](https://github.com/kubernetes/kubernetes/pull/74321), [@yastij](https://github.com/yastij))

### Beta

- Admission webhooks can now register for a single version of a resource (for example, `apps/v1 deployments`) and be called when any other version of that resource is modified (for example `extensions/v1beta1 deployments`). This allows new versions of a resource to be handled by admission webhooks without needing to update every webhook to understand the new version. See the API documentation for the `matchPolicy: Equivalent` option in MutatingWebhookConfiguration and ValidatingWebhookConfiguration types. ([#78135](https://github.com/kubernetes/kubernetes/pull/78135), [@liggitt](https://github.com/liggitt))
- The CustomResourcePublishOpenAPI feature is now beta and enabled by default. CustomResourceDefinitions with [structural schemas](https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md) now publish schemas in the OpenAPI document served at `/openapi/v2`. CustomResourceDefinitions with non-structural schemas have a `NonStructuralSchema` condition added with details about what needs to be corrected in the validation schema. ([#77825](https://github.com/kubernetes/kubernetes/pull/77825), [@roycaihw](https://github.com/roycaihw))
- Online volume expansion (ExpandInUsePersistentVolumes) is now a beta feature. As such, it is enabled by default. ([#77755](https://github.com/kubernetes/kubernetes/pull/77755), [@gnufied](https://github.com/gnufied))
- The `SupportNodePidsLimit` feature is now beta, and enabled by default.  It is no longer necessary to set the feature gate `SupportNodePidsLimit=true`. ([#76221](https://github.com/kubernetes/kubernetes/pull/76221), [@RobertKrawitz](https://github.com/RobertKrawitz))
- kubeadm now includes the ability to specify certificate encryption and decryption keys for the upload and download certificate phases as part of the new v1beta2 kubeadm config format. ([#77012](https://github.com/kubernetes/kubernetes/pull/77012), [@rosti](https://github.com/rosti))
- You can now use kubeadm's `InitConfiguration` and `JoinConfiguration` to define which preflight errors will be ignored. ([#75499](https://github.com/kubernetes/kubernetes/pull/75499), [@marccarre](https://github.com/marccarre))
- CustomResourcesDefinition conversion via Web Hooks is promoted to beta. Note that you must set `spec.preserveUnknownFields` to `false`. ([#78426](https://github.com/kubernetes/kubernetes/pull/78426), [@sttts](https://github.com/sttts))
- Group Managed Service Account support has moved to a new API for beta. Special annotations for Windows GMSA support have been deprecated.
([#75459](https://github.com/kubernetes/kubernetes/pull/75459), [@wk8](https://github.com/wk8))
- The `storageVersionHash` feature is now beta. `StorageVersionHash` is a field in the discovery document of each resource. It enables clients to detect whether the storage version of that resource has changed. Its value must be treated as opaque by clients. Only equality comparison on the value is valid. ([#78325](https://github.com/kubernetes/kubernetes/pull/78325), [@caesarxuchao](https://github.com/caesarxuchao))
- Ingress objects are now persisted in etcd using the `networking.k8s.io/v1beta1` version ([#77139](https://github.com/kubernetes/kubernetes/pull/77139), [@cmluciano](https://github.com/cmluciano))
- NodeLocal DNSCache graduating to beta. ([#77887](https://github.com/kubernetes/kubernetes/pull/77887), [@prameshj](https://github.com/prameshj))

### Alpha

- kubelet now allows the use of XFS quotas (on XFS and suitably configured ext4fs filesystems) to monitor storage consumption for ephemeral storage.  This method of monitoring consumption, which is currently available only for `emptyDir` volumes, is faster and more accurate than the old method of walking the filesystem tree. Note that it does not enforce limits, it only monitors consumption. To utilize this functionality, set the feature gate `LocalStorageCapacityIsolationFSQuotaMonitoring=true`. For ext4fs filesystems, create the filesystem with `mkfs.ext4 -O project <block_device>` and run `tune2fs -Q prjquota `block device`; XFS filesystems need no additional preparation. The filesystem must be mounted with option `project` in `/etc/fstab`. If the primary partition is the root filesystem, add `rootflags=pquota` to the GRUB config file. ([#66928](https://github.com/kubernetes/kubernetes/pull/66928), [@RobertKrawitz](https://github.com/RobertKrawitz))
- Finalizer Protection for Service LoadBalancers (ServiceLoadBalancerFinalizer) has been added as an Alpha feature, which is disabled by default. This feature ensures the Service resource is not fully deleted until the correlating load balancer resources are deleted. ([#78262](https://github.com/kubernetes/kubernetes/pull/78262), [@MrHohn](https://github.com/MrHohn))
- Inline CSI ephemeral volumes can now be controlled with PodSecurityPolicy when the CSIInlineVolume alpha feature is enabled. ([#76915](https://github.com/kubernetes/kubernetes/pull/76915), [@vladimirvivien](https://github.com/vladimirvivien))
- Kubernetes now includes an alpha field, `AllowWatchBookmarks`, in ListOptions for requesting the watching of bookmarks from apiserver. The implementation in apiserver is hidden behind the feature gate `WatchBookmark`. ([#74074](https://github.com/kubernetes/kubernetes/pull/74074), [@wojtek-t](https://github.com/wojtek-t))

### Staging Repositories

- The CRI API is now available in the `k8s.io/cri-api` staging repository. ([#75531](https://github.com/kubernetes/kubernetes/pull/75531), [@dims](https://github.com/dims))
- Support for the Azure File plugin has been added to `csi-translation-lib` (CSIMigrationAzureFile). ([#78356](https://github.com/kubernetes/kubernetes/pull/78356), [@andyzhangx](https://github.com/andyzhangx))
- Added support for Azure Disk plugin to csi-translation-lib (CSIMigrationAzureDisk) ([#78330](https://github.com/kubernetes/kubernetes/pull/78330), [@andyzhangx](https://github.com/andyzhangx))

### CLI Improvements

- Added `kubeadm upgrade node`. This command can be used to upgrade both secondary control-plane nodes and worker nodes. The `kubeadm upgrade node config` and `kubeadm upgrade node experimental-control-plane` commands are now deprecated. ([#78408](https://github.com/kubernetes/kubernetes/pull/78408), [@fabriziopandini](https://github.com/fabriziopandini))
- The `kubectl top` command now includes a `--sort-by` option to sort by `memory` or `cpu`. ([#75920](https://github.com/kubernetes/kubernetes/pull/75920), [@artmello](https://github.com/artmello))
- `kubectl rollout restart` now works for DaemonSets and StatefulSets. ([#77423](https://github.com/kubernetes/kubernetes/pull/77423), [@apelisse](https://github.com/apelisse))
- `kubectl get --watch=true` now prints custom resource definitions with custom print columns. ([#76161](https://github.com/kubernetes/kubernetes/pull/76161), [@liggitt](https://github.com/liggitt))
- Added `kubeadm alpha certs certificate-key` command to generate secure random key to use on `kubeadm init --experimental-upload-certs` ([#77848](https://github.com/kubernetes/kubernetes/pull/77848), [@yagonobre](https://github.com/yagonobre))
- Kubernetes now supports printing the `volumeMode` using `kubectl get pv/pvc -o wide` ([#76646](https://github.com/kubernetes/kubernetes/pull/76646), [@cwdsuzhou](https://github.com/cwdsuzhou))
- Created a new `kubectl rollout restart` command that does a rolling restart of a deployment. ([#76062](https://github.com/kubernetes/kubernetes/pull/76062), [@apelisse](https://github.com/apelisse))
- `kubectl exec` now allows using the resource name to select a matching pod and `--pod-running-timeout` flag to wait till at least one pod is running. ([#73664](https://github.com/kubernetes/kubernetes/pull/73664), [@prksu](https://github.com/prksu))
- `kubeadm alpha certs renew` and `kubeadm upgrade` now supports renewal of certificates embedded in KubeConfig files managed by kubeadm; this does not apply to certificates signed by external CAs.  ([#77180](https://github.com/kubernetes/kubernetes/pull/77180), [@fabriziopandini](https://github.com/fabriziopandini))
- Kubeadm: a new command `kubeadm alpha certs check-expiration` was created in order to help users in managing expiration for local PKI certificates ([#77863](https://github.com/kubernetes/kubernetes/pull/77863), [@fabriziopandini](https://github.com/fabriziopandini))

### Misc

- Service account controller clients to now use the TokenRequest API, and tokens are periodically rotated. ([#72179](https://github.com/kubernetes/kubernetes/pull/72179), [@WanLinghao](https://github.com/WanLinghao))
- Added `ListPager.EachListItem` utility function to client-go to enable incremental processing of chunked list responses ([#75849](https://github.com/kubernetes/kubernetes/pull/75849), [@jpbetz](https://github.com/jpbetz))
- Object count quota is now supported for namespaced custom resources using the `count/<resource>.<group>` syntax. ([#72384](https://github.com/kubernetes/kubernetes/pull/72384), [@zhouhaibing089](https://github.com/zhouhaibing089))
- Added completed job status in Cron Job event. ([#75712](https://github.com/kubernetes/kubernetes/pull/75712), [@danielqsj](https://github.com/danielqsj))
- Pod disruption budgets can now be updated and patched. ([#69867](https://github.com/kubernetes/kubernetes/pull/69867), [@davidmccormick](https://github.com/davidmccormick))
- Add CRD spec.preserveUnknownFields boolean, defaulting to true in v1beta1 and to false in v1 CRDs. If false, fields not specified in the validation schema will be removed when sent to the API server or when read from etcd. ([#77333](https://github.com/kubernetes/kubernetes/pull/77333), [@sttts](https://github.com/sttts))
- Added RuntimeClass restrictions and defaulting to PodSecurityPolicy. ([#73795](https://github.com/kubernetes/kubernetes/pull/73795), [@tallclair](https://github.com/tallclair))
- Kubelet plugin registration now has retry and exponential backoff logic for when registration of plugins (such as CSI or device plugin) fail. ([#73891](https://github.com/kubernetes/kubernetes/pull/73891), [@taragu](https://github.com/taragu))
- proxy/transport now supports Content-Encoding: deflate ([#76551](https://github.com/kubernetes/kubernetes/pull/76551), [@JieJhih](https://github.com/JieJhih))
- Admission webhooks are now properly called for `scale` and `deployments/rollback` subresources. ([#76849](https://github.com/kubernetes/kubernetes/pull/76849), [@liggitt](https://github.com/liggitt))

## API Changes

- CRDs get support for x-kubernetes-int-or-string to allow faithful representation of IntOrString types in CustomResources.([#78815](https://github.com/kubernetes/kubernetes/pull/78815), [@sttts](https://github.com/sttts))
- Introduced the [`v1beta2`](https://docs.google.com/document/d/1XnP67oO1i9VcDIpw42IzptnJsc5OQM-HTf8cVcjCR2w/edit) config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))
- Resource list requests for `PartialObjectMetadata` now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- Added a condition `NonStructuralSchema` to `CustomResourceDefinition` listing Structural Schema violations as defined in the [KEP](https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md). CRD authors should update their validation schemas to be structural in order to participate in future CRD features. ([#77207](https://github.com/kubernetes/kubernetes/pull/77207), [@sttts](https://github.com/sttts))
- Promoted meta.k8s.io/v1beta1 Table and PartialObjectMetadata to v1. ([#77136](https://github.com/kubernetes/kubernetes/pull/77136), [@smarterclayton](https://github.com/smarterclayton))
- Introduced the flag `--ipvs-strict-arp` to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- CRD validation schemas should not specify `metadata` fields other than `name` and `generateName`. A schema will not be considered structural (and therefore ready for future features) if `metadata` is specified in any other way. ([#77653](https://github.com/kubernetes/kubernetes/pull/77653), [@sttts](https://github.com/sttts))

## Other notable changes

### API Machinery

- Added port configuration to Admission webhook configuration service reference.
- Added port configuration to AuditSink webhook configuration service reference.
- Added port configuration to CRD Conversion webhook configuration service reference.
- Added port configuration to kube-aggregator service reference. ([#74855](https://github.com/kubernetes/kubernetes/pull/74855), [@mbohlool](https://github.com/mbohlool))
- Implemented deduplication logic for v1beta1.Event API ([#65782](https://github.com/kubernetes/kubernetes/pull/65782), [@yastij](https://github.com/yastij))
- Added `objectSelector` to admission webhook configurations. `objectSelector` is evaluated the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. ([#78505](https://github.com/kubernetes/kubernetes/pull/78505), [@caesarxuchao](https://github.com/caesarxuchao))
- Watch will now support converting response objects into Table or PartialObjectMetadata forms. ([#71548](https://github.com/kubernetes/kubernetes/pull/71548), [@smarterclayton](https://github.com/smarterclayton))
- In CRD webhook conversion, Kubernetes will now ignore changes to metadata other than for labels and annotations. ([#77743](https://github.com/kubernetes/kubernetes/pull/77743), [@sttts](https://github.com/sttts))
- Added ListMeta.RemainingItemCount. When responding to a LIST request, if the server has more data available, and if the request does not contain label selectors or field selectors, the server sets the ListOptions.RemainingItemCount to the number of remaining objects. ([#75993](https://github.com/kubernetes/kubernetes/pull/75993), [@caesarxuchao](https://github.com/caesarxuchao))
- Clients may now request that API objects are converted to the `v1.Table` and `v1.PartialObjectMetadata` forms for generic access to objects. ([#77448](https://github.com/kubernetes/kubernetes/pull/77448), [@smarterclayton](https://github.com/smarterclayton))

- Fixed a spurious error where update requests to the status subresource of multi-version custom resources would complain about an incorrect API version. ([#78713](https://github.com/kubernetes/kubernetes/pull/78713), [@liggitt](https://github.com/liggitt))
- Fixed a bug in apiserver storage that could cause just-added finalizers to be ignored immediately following a delete request, leading to premature deletion. ([#77619](https://github.com/kubernetes/kubernetes/pull/77619), [@caesarxuchao](https://github.com/caesarxuchao))
- API requests rejected by admission webhooks which specify an http status code < 400 are now assigned a 400 status code. ([#77022](https://github.com/kubernetes/kubernetes/pull/77022), [@liggitt](https://github.com/liggitt))
- Fixed a transient error API requests for custom resources could encounter while changes to the CustomResourceDefinition were being applied. ([#77816](https://github.com/kubernetes/kubernetes/pull/77816), [@liggitt](https://github.com/liggitt))
[@smarterclayton](https://github.com/smarterclayton))
- Added name validation for dynamic client methods in client-go ([#75072](https://github.com/kubernetes/kubernetes/pull/75072), [@lblackstone](https://github.com/lblackstone))
- CustomResourceDefinition with invalid regular expression in the pattern field of OpenAPI v3 validation schemas are no longer considered structural. ([#78453](https://github.com/kubernetes/kubernetes/pull/78453), [@sttts](https://github.com/sttts))
- API paging is now enabled by default in k8s.io/apiserver recommended options, and in k8s.io/sample-apiserver ([#77278](https://github.com/kubernetes/kubernetes/pull/77278), [@liggitt](https://github.com/liggitt))

- Increased verbose level for local openapi aggregation logs to avoid flooding the log during normal operation ([#75781](https://github.com/kubernetes/kubernetes/pull/75781), [@roycaihw](https://github.com/roycaihw))
- k8s.io/client-go/dynamic/dynamicinformer.NewFilteredDynamicSharedInformerFactory now honours the `namespace` argument. ([#77945](https://github.com/kubernetes/kubernetes/pull/77945), [@michaelfig](https://github.com/michaelfig))
- client-go and kubectl no longer write cached discovery files with world-accessible file permissions. ([#77874](https://github.com/kubernetes/kubernetes/pull/77874), [@yuchengwu](https://github.com/yuchengwu))
- Fixed an error with stuck informers when an etcd watch receives update or delete events with missing data. ([#76675](https://github.com/kubernetes/kubernetes/pull/76675), [@ryanmcnamara](https://github.com/ryanmcnamara))
- `DelayingQueue.ShutDown()` can now be invoked multiple times without causing a closed channel panic. ([#77170](https://github.com/kubernetes/kubernetes/pull/77170), [@smarterclayton](https://github.com/smarterclayton))
- When specifying an invalid value for a label, it was not always clear which label the value was specified for. Starting with this release, the label's key is included in such error messages, which makes debugging easier. ([#77144](https://github.com/kubernetes/kubernetes/pull/77144), [@kenegozi](https://github.com/kenegozi))
- Fixed a regression error when proxying responses from aggregated API servers, which could cause watch requests to hang until the first event was received. ([#75887](https://github.com/kubernetes/kubernetes/pull/75887), [@liggitt](https://github.com/liggitt))
- Fixed a bug where dry-run is not honored for pod/eviction sub-resource. ([#76969](https://github.com/kubernetes/kubernetes/pull/76969), [@apelisse](https://github.com/apelisse))

- DeleteOptions parameters for deletecollection endpoints are now published in the OpenAPI spec. ([#77843](https://github.com/kubernetes/kubernetes/pull/77843), [@roycaihw](https://github.com/roycaihw))
- Active watches of custom resources now terminate properly if the CRD is modified. ([#78029](https://github.com/kubernetes/kubernetes/pull/78029), [@liggitt](https://github.com/liggitt))
- Fixed a potential deadlock in the resource quota controller. Enabled recording partial usage info for quota objects specifying multiple resources, when only some of the resources' usage can be determined. ([#74747](https://github.com/kubernetes/kubernetes/pull/74747), [@liggitt](https://github.com/liggitt))
- Updates that remove remaining `metadata.finalizers` from  an object that is pending deletion (non-nil metadata.deletionTimestamp) and has no graceful deletion pending (nil or 0 metadata.deletionGracePeriodSeconds) now results in immediate deletion of the object. ([#77952](https://github.com/kubernetes/kubernetes/pull/77952), [@liggitt](https://github.com/liggitt))
- client-go: The `rest.AnonymousClientConfig(*rest.Config) *rest.Config` helper method no longer copies custom `Transport` and `WrapTransport` fields, because those can be used to inject user credentials. ([#75771](https://github.com/kubernetes/kubernetes/pull/75771), [@liggitt](https://github.com/liggitt))
- Validating admission webhooks are now properly called for CREATE operations on the following resources: pods/binding, pods/eviction, bindings ([#76910](https://github.com/kubernetes/kubernetes/pull/76910), [@liggitt](https://github.com/liggitt))
- Removed the function Parallelize, please convert to use the function ParallelizeUntil. ([#76595](https://github.com/kubernetes/kubernetes/pull/76595), [@danielqsj](https://github.com/danielqsj))

### Apps

- Users can now specify a DataSource/Kind of type `PersistentVolumeClaim` in their PVC spec.  This can then be detected by the external csi-provisioner and plugins if capable. ([#76913](https://github.com/kubernetes/kubernetes/pull/76913), [@j-griffith](https://github.com/j-griffith))
- Fixed bug in DaemonSetController causing it to stop processing some DaemonSets for 5 minutes after node removal. ([#76060](https://github.com/kubernetes/kubernetes/pull/76060), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- StatefulSet controllers no longer force a resync every 30 seconds when nothing has changed. ([#75622](https://github.com/kubernetes/kubernetes/pull/75622), [@jonsabo](https://github.com/jonsabo))
- Enhanced the daemonset sync logic to avoid a problem where pods are thought to be unavailable when the controller's clock is slower than the node's clock. ([#77208](https://github.com/kubernetes/kubernetes/pull/77208), [@DaiHao](https://github.com/DaiHao))
- Fixed a bug that caused a DaemonSet rolling update to hang when its pod gets stuck at terminating.  ([#77773](https://github.com/kubernetes/kubernetes/pull/77773), [@DaiHao](https://github.com/DaiHao))
- Route controller now respects rate limiting to the cloud provider on deletion; previously it was only for create. ([#78581](https://github.com/kubernetes/kubernetes/pull/78581), [@andrewsykim](https://github.com/andrewsykim))
- Removed extra pod creation expectations when daemonset fails to create pods in batches. ([#74856](https://github.com/kubernetes/kubernetes/pull/74856), [@draveness](https://github.com/draveness))
- Resolved spurious rollouts of workload controllers when upgrading the API server, due to incorrect defaulting of an alpha procMount field in pods. ([#78885](https://github.com/kubernetes/kubernetes/pull/78885), [@liggitt](https://github.com/liggitt))

### Auth

- Fixed OpenID Connect (OIDC) token refresh when the client secret contains a special character. ([#76914](https://github.com/kubernetes/kubernetes/pull/76914), [@tsuna](https://github.com/tsuna))
- Improved `kubectl auth can-i` command by warning users when they try to access a resource out of scope. ([#76014](https://github.com/kubernetes/kubernetes/pull/76014), [@WanLinghao](https://github.com/WanLinghao))
- Validating admission webhooks are now properly called for CREATE operations on the following resources: tokenreviews, subjectaccessreviews, localsubjectaccessreviews, selfsubjectaccessreviews, selfsubjectrulesreviews ([#76959](https://github.com/kubernetes/kubernetes/pull/76959), [@sbezverk](https://github.com/sbezverk))

### Autoscaling

- Horizontal Pod Autoscaling can now scale targets up even when one or more metrics are invalid/unavailable, as long as one metric indicates a scale up should occur. ([#78503](https://github.com/kubernetes/kubernetes/pull/78503), [@gjtempleton](https://github.com/gjtempleton))


### AWS

- Kubernetes will now use the zone from the node for topology aware aws-ebs volume creation to reduce unnecessary cloud provider calls. ([#78276](https://github.com/kubernetes/kubernetes/pull/78276), [@zhan849](https://github.com/zhan849))
- Kubernetes now supports configure accessLogs for AWS NLB. ([#78497](https://github.com/kubernetes/kubernetes/pull/78497), [@M00nF1sh](https://github.com/M00nF1sh))
- Kubernetes now supports update LoadBalancerSourceRanges for AWS NLB([#74692](https://github.com/kubernetes/kubernetes/pull/74692), [@M00nF1sh](https://github.com/M00nF1sh))
- Kubernetes now supports configure TLS termination for AWS NLB([#74910](https://github.com/kubernetes/kubernetes/pull/74910), [@M00nF1sh](https://github.com/M00nF1sh))
- Kubernetes will now consume the AWS region list from the AWS SDK instead of a hard-coded list in the cloud provider. ([#75990](https://github.com/kubernetes/kubernetes/pull/75990), [@mcrute](https://github.com/mcrute))
- Limit use of tags when calling EC2 API to prevent API throttling for very large clusters. ([#76749](https://github.com/kubernetes/kubernetes/pull/76749), [@mcrute](https://github.com/mcrute))
- The AWS credential provider can now obtain ECR credentials even without the AWS cloud provider or being on an EC2 instance. Additionally, AWS credential provider caching has been improved to honor the ECR credential timeout. ([#75587](https://github.com/kubernetes/kubernetes/pull/75587), [@tiffanyfay](https://github.com/tiffanyfay))


### Azure

- Kubernetes now supports specifying the Resource Group of the Route Table when updating the Pod network route on Azure. ([#75580](https://github.com/kubernetes/kubernetes/pull/75580), [@suker200](https://github.com/suker200))
- Kubernetes now uses instance-level update APIs for Azure VMSS loadbalancer operations. ([#76656](https://github.com/kubernetes/kubernetes/pull/76656), [@feiskyer](https://github.com/feiskyer))
- Users can now specify azure file share name in the azure file plugin, making it possible to use existing shares or specify a new share name. ([#76988](https://github.com/kubernetes/kubernetes/pull/76988), [@andyzhangx](https://github.com/andyzhangx))
- You can now run kubelet with no Azure identity. A sample cloud provider configuration is:  `{"vmType": "vmss", "useInstanceMetadata": true, "subscriptionId": "<subscriptionId>"}` ([#77906](https://github.com/kubernetes/kubernetes/pull/77906), [@feiskyer](https://github.com/feiskyer))
- Fixed some service tags not supported issues for Azure LoadBalancer service. ([#77719](https://github.com/kubernetes/kubernetes/pull/77719), [@feiskyer](https://github.com/feiskyer))
- Fixed an issue where `pull image` fails from a cross-subscription Azure Container Registry when using MSI to authenticate. ([#77245](https://github.com/kubernetes/kubernetes/pull/77245), [@norshtein](https://github.com/norshtein))
- Azure cloud provider can now be configured by Kubernetes secrets and a new option `cloudConfigType` has been introduced. Candidate values are `file`, `secret` or `merge` (default is `merge`). Note that the secret is a serialized version of `azure.json` file with key cloud-config. And the secret name is azure-cloud-provider in kube-system namespace. ([#78242](https://github.com/kubernetes/kubernetes/pull/78242), [@feiskyer](https://github.com/feiskyer))

### CLI

- Fixed `kubectl exec` usage string to correctly reflect flag placement. ([#77589](https://github.com/kubernetes/kubernetes/pull/77589), [@soltysh](https://github.com/soltysh))
- Fixed `kubectl describe cronjobs` error of `Successful Job History Limit`. ([#77347](https://github.com/kubernetes/kubernetes/pull/77347), [@danielqsj](https://github.com/danielqsj))
- In the `kubectl describe` output, the fields with names containing special characters are now displayed as-is without any pretty formatting, avoiding awkward outputs.  ([#75483](https://github.com/kubernetes/kubernetes/pull/75483), [@gsadhani](https://github.com/gsadhani))
- Fixed incorrect handling by kubectl of custom resources whose Kind is "Status". ([#77368](https://github.com/kubernetes/kubernetes/pull/77368), [@liggitt](https://github.com/liggitt))
- Report cp errors consistently, providing full message whether copying to or from a pod.  ([#77010](https://github.com/kubernetes/kubernetes/pull/77010), [@soltysh](https://github.com/soltysh))
- Preserved existing namespace information in manifests when running `
set ... --local` commands. ([#77267](https://github.com/kubernetes/kubernetes/pull/77267), [@liggitt](https://github.com/liggitt))
- Support for parsing more v1.Taint forms has been added. For example, `key:effect`, `key=:effect-` are now accepted. ([#74159](https://github.com/kubernetes/kubernetes/pull/74159), [@dlipovetsky](https://github.com/dlipovetsky))

### Cloud Provider

- The GCE-only flag `cloud-provider-gce-lb-src-cidrs` is now optional for external cloud providers. ([#76627](https://github.com/kubernetes/kubernetes/pull/76627), [@timoreimann](https://github.com/timoreimann))
- Fixed a bug where cloud-controller-manager initializes nodes multiple times. ([#75405](https://github.com/kubernetes/kubernetes/pull/75405), [@tghartland](https://github.com/tghartland))

### Cluster Lifecycle

- `kubeadm upgrade` now renews all the certificates used by a component before upgrading the component itself, with the exception of certificates signed by external CAs. User can eventually opt-out of certificate renewal during upgrades by setting the new flag `--certificate-renewal` to false. ([#76862](https://github.com/kubernetes/kubernetes/pull/76862), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm still generates RSA keys when deploying a node, but also accepts ECDSA
keys if they already exist in the directory specified in the `--cert-dir` option. ([#76390](https://github.com/kubernetes/kubernetes/pull/76390), [@rojkov](https://github.com/rojkov))
- kubeadm now implements CRI detection for Windows worker nodes ([#78053](https://github.com/kubernetes/kubernetes/pull/78053), [@ksubrmnn](https://github.com/ksubrmnn))
- Added `--image-repository` flag to `kubeadm config images`. ([#75866](https://github.com/kubernetes/kubernetes/pull/75866), [@jmkeyes](https://github.com/jmkeyes))

- kubeadm: The kubeadm reset command has now been exposed as phases. ([#77847](https://github.com/kubernetes/kubernetes/pull/77847), [@yagonobre](https://github.com/yagonobre))
- kubeadm: Improved resiliency when it comes to updating the `kubeadm-config` configmap upon new control plane joins or resets. This allows for safe multiple control plane joins and/or resets. ([#76821](https://github.com/kubernetes/kubernetes/pull/76821), [@ereslibre](https://github.com/ereslibre))
- kubeadm: Bumped the minimum supported Docker version to 1.13.1 ([#77051](https://github.com/kubernetes/kubernetes/pull/77051), [@chenzhiwei](https://github.com/chenzhiwei))
- Reverted the CoreDNS version to 1.3.1 for kubeadm ([#78545](https://github.com/kubernetes/kubernetes/pull/78545), [@neolit123](https://github.com/neolit123))
- kubeadm: Fixed the machine readability of `kubeadm token create --print-join-command` ([#75487](https://github.com/kubernetes/kubernetes/pull/75487), [@displague](https://github.com/displague))
- `kubeadm alpha certs renew --csr-only` now reads the current certificates as the authoritative source for certificates attributes (same as kubeadm alpha certs renew). ([#77780](https://github.com/kubernetes/kubernetes/pull/77780), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: You can now delete multiple bootstrap tokens at once. ([#75646](https://github.com/kubernetes/kubernetes/pull/75646), [@bart0sh](https://github.com/bart0sh))
- util/initsystem: Added support for the OpenRC init system ([#73101](https://github.com/kubernetes/kubernetes/pull/73101), [@oz123](https://github.com/oz123))
- Default TTL for DNS records in kubernetes zone has been changed from 5s to 30s to keep consistent with old dnsmasq based kube-dns. The TTL can be customized with command `kubectl edit -n kube-system configmap/coredns`. ([#76238](https://github.com/kubernetes/kubernetes/pull/76238), [@Dieken](https://github.com/Dieken))
- Communication between the etcd server and kube-apiserver on master is now overridden to use HTTPS instead of HTTP when mTLS is enabled in GCE. ([#74690](https://github.com/kubernetes/kubernetes/pull/74690), [@wenjiaswe](https://github.com/wenjiaswe))

### GCP

- [stackdriver addon] Bumped prometheus-to-sd to v0.5.0 to pick up security fixes.
[fluentd-gcp addon] Bumped fluentd-gcp-scaler to v0.5.1 to pick up security fixes.
[fluentd-gcp addon] Bumped event-exporter to v0.2.4 to pick up security fixes.
[fluentd-gcp addon] Bumped prometheus-to-sd to v0.5.0 to pick up security fixes.
[metatada-proxy addon] Bumped prometheus-to-sd v0.5.0 to pick up security fixes. ([#75362](https://github.com/kubernetes/kubernetes/pull/75362), [@serathius](https://github.com/serathius))
- [fluentd-gcp addon] Bump fluentd-gcp-scaler to v0.5.2 to pick up security fixes. ([#76762](https://github.com/kubernetes/kubernetes/pull/76762), [@serathius](https://github.com/serathius))
- The GCERegionalPersistentDisk feature gate (GA in 1.13) can no longer be disabled. The feature gate will be removed in v1.17. ([#77412](https://github.com/kubernetes/kubernetes/pull/77412), [@liggitt](https://github.com/liggitt))
- GCE/Windows: When the service cannot be stopped Stackdriver logging processes are now force killed ([#77378](https://github.com/kubernetes/kubernetes/pull/77378), [@yujuhong](https://github.com/yujuhong))
- Reduced GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#76352](https://github.com/kubernetes/kubernetes/pull/76352), [@jpbetz](https://github.com/jpbetz))
- GCE/Windows: disabled stackdriver logging agent to prevent node startup failures ([#76099](https://github.com/kubernetes/kubernetes/pull/76099), [@yujuhong](https://github.com/yujuhong))
- API servers using the default Google Compute Engine bootstrapping scripts will have their insecure port (`:8080`) disabled by default. To enable the insecure port, set `ENABLE_APISERVER_INSECURE_PORT=true` in kube-env or as an environment variable. ([#77447](https://github.com/kubernetes/kubernetes/pull/77447), [@dekkagaijin](https://github.com/dekkagaijin))
- Fixed a NPD bug on GCI, so that it disables glog writing to files for log-counter. ([#76211](https://github.com/kubernetes/kubernetes/pull/76211), [@wangzhen127](https://github.com/wangzhen127))
- Windows nodes on GCE now have the Windows firewall enabled by default. ([#78507](https://github.com/kubernetes/kubernetes/pull/78507), [@pjh](https://github.com/pjh))
- Added `CNI_VERSION` and `CNI_SHA1` environment variables in `kube-up.sh` to configure CNI versions on GCE. ([#76353](https://github.com/kubernetes/kubernetes/pull/76353), [@Random-Liu](https://github.com/Random-Liu))
- GCE clusters will include some IP ranges that are not used on the public Internet in the list of non-masq IPs. Bumped ip-masq-agent version to v2.3.0 with flag `nomasq-all-reserved-ranges` turned on. ([#77458](https://github.com/kubernetes/kubernetes/pull/77458), [@grayluck](https://github.com/grayluck))
- GCE/Windows: added support for the stackdriver logging agent ([#76850](https://github.com/kubernetes/kubernetes/pull/76850), [@yujuhong](https://github.com/yujuhong))
- GCE Windows nodes will rely solely on kubernetes and kube-proxy (and not the GCE agent) for network address management. ([#75855](https://github.com/kubernetes/kubernetes/pull/75855), [@pjh](https://github.com/pjh))
- Ensured that the `node-role.kubernetes.io/master` taint is applied to the master with NoSchedule on GCE. ([#78183](https://github.com/kubernetes/kubernetes/pull/78183), [@cheftako](https://github.com/cheftako))
- Windows nodes on GCE now use a known-working 1809 image rather than the latest 1809 image. ([#76722](https://github.com/kubernetes/kubernetes/pull/76722), [@pjh](https://github.com/pjh))
- kube-up.sh scripts now disable the KubeletPodResources feature for Windows nodes, due to issue #[78628](https://github.com/kubernetes/kubernetes/pull/78668). ([#78668](https://github.com/kubernetes/kubernetes/pull/78668), [@mtaufen](https://github.com/mtaufen))


### Instrumentation

- [metrics-server addon] Restored the ability to connect to nodes via IP addresses. ([#76819](https://github.com/kubernetes/kubernetes/pull/76819), [@serathius](https://github.com/serathius))
- If a pod has a running instance, the stats of its previously terminated instances will not show up in the kubelet summary stats any more for CRI runtimes such as containerd and cri-o. This keeps the behavior consistent with Docker integration, and fixes an issue that some container Prometheus metrics don't work when there are summary stats for multiple instances of the same pod. ([#77426](https://github.com/kubernetes/kubernetes/pull/77426), [@Random-Liu](https://github.com/Random-Liu))


### Network

- Ingress objects are now persisted in etcd using the networking.k8s.io/v1beta1 version ([#77139](https://github.com/kubernetes/kubernetes/pull/77139), [@cmluciano](https://github.com/cmluciano))
- Transparent kube-proxy restarts when using IPVS are now allowed. ([#75283](https://github.com/kubernetes/kubernetes/pull/75283), [@lbernail](https://github.com/lbernail))
- Packets considered INVALID by conntrack are now dropped. In particular, this fixes
a problem where spurious retransmits in a long-running TCP connection to a service
IP could result in the connection being closed with the error "Connection reset by
peer" ([#74840](https://github.com/kubernetes/kubernetes/pull/74840), [@anfernee](https://github.com/anfernee))
- kube-proxy no longer automatically cleans up network rules created by running kube-proxy in other modes. If you are switching the kube-proxy mode (EG: iptables to IPVS), you will need to run `kube-proxy --cleanup`, or restart the worker node (recommended) before restarting kube-proxy. If you are not switching kube-proxy between different modes, this change should not require any action. ([#76109](https://github.com/kubernetes/kubernetes/pull/76109), [@vllry](https://github.com/vllry))
- kube-proxy: HealthzBindAddress and MetricsBindAddress now support ipv6 addresses. ([#76320](https://github.com/kubernetes/kubernetes/pull/76320), [@JieJhih](https://github.com/JieJhih))
- The userspace proxy now respects the IPTables proxy's minSyncInterval parameter. ([#71735](https://github.com/kubernetes/kubernetes/pull/71735), [@dcbw](https://github.com/dcbw))

- iptables proxier: now routes local traffic to LB IPs to service chain ([#77523](https://github.com/kubernetes/kubernetes/pull/77523), [@andrewsykim](https://github.com/andrewsykim))
- IPVS: Disabled graceful termination for UDP traffic to solve issues with high number of UDP connections (DNS / syslog in particular) ([#77802](https://github.com/kubernetes/kubernetes/pull/77802), [@lbernail](https://github.com/lbernail))
- Fixed a bug where kube-proxy returns error due to existing ipset rules using a different hash type. ([#77371](https://github.com/kubernetes/kubernetes/pull/77371), [@andrewsykim](https://github.com/andrewsykim))
- Fixed spurious error messages about failing to clean up iptables rules when using iptables 1.8. ([#77303](https://github.com/kubernetes/kubernetes/pull/77303), [@danwinship](https://github.com/danwinship))
- Increased log level to 2 for IPVS graceful termination ([#78395](https://github.com/kubernetes/kubernetes/pull/78395), [@andrewsykim](https://github.com/andrewsykim))
- kube-proxy: os exit when CleanupAndExit is set to true ([#76732](https://github.com/kubernetes/kubernetes/pull/76732), [@JieJhih](https://github.com/JieJhih))
- Kubernetes will now allow trailing dots in the externalName of Services of type ExternalName. ([#78385](https://github.com/kubernetes/kubernetes/pull/78385), [@thz](https://github.com/thz))

### Node

- The dockershim container runtime now accepts the `docker` runtime handler from a RuntimeClass. ([#78323](https://github.com/kubernetes/kubernetes/pull/78323), [@tallclair](https://github.com/tallclair))
- The init container can now get its own field value as environment variable values using downwardAPI support. ([#75109](https://github.com/kubernetes/kubernetes/pull/75109), [@yuchengwu](https://github.com/yuchengwu))
- UpdateContainerResources is no longer recorded as a `container_status` operation. It now uses the label `update_container`. ([#75278](https://github.com/kubernetes/kubernetes/pull/75278), [@Nessex](https://github.com/Nessex))
- kubelet: fix fail to close kubelet->API connections on heartbeat failure when bootstrapping or client certificate rotation is disabled ([#78016](https://github.com/kubernetes/kubernetes/pull/78016), [@gaorong](https://github.com/gaorong))
- Set selinux label at plugin socket directory ([#73241](https://github.com/kubernetes/kubernetes/pull/73241), [@vikaschoudhary16](https://github.com/vikaschoudhary16))
- Fixed detection of non-root image user ID.([#78261](https://github.com/kubernetes/kubernetes/pull/78261), [@tallclair](https://github.com/tallclair))
- Signal handling is now initialized within hyperkube commands that require it, such as apiserver and kubelet. ([#76659](https://github.com/kubernetes/kubernetes/pull/76659), [@S-Chan](https://github.com/S-Chan))
- The Kubelet now properly requests protobuf objects where they are supported from the apiserver, reducing load in large clusters. ([#75602](https://github.com/kubernetes/kubernetes/pull/75602), [@smarterclayton](https://github.com/smarterclayton))

### OpenStack

- You can now define a kubeconfig file for the OpenStack cloud provider. ([#77415](https://github.com/kubernetes/kubernetes/pull/77415), [@Fedosin](https://github.com/Fedosin))
- OpenStack user credentials can now be read from a secret instead of a local config file. ([#75062](https://github.com/kubernetes/kubernetes/pull/75062), [@Fedosin](https://github.com/Fedosin))

### Release

- Removed hyperkube short aliases from source code because hyperkube docker image currently create these aliases. ([#76953](https://github.com/kubernetes/kubernetes/pull/76953), [@Rand01ph](https://github.com/Rand01ph))

### Scheduling

- Tolerations with the same key and effect will be merged into one that has the value of the latest toleration for best effort pods. ([#75985](https://github.com/kubernetes/kubernetes/pull/75985), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Achieved 2X performance improvement on both required and preferred PodAffinity. ([#76243](https://github.com/kubernetes/kubernetes/pull/76243), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed a scheduler racing issue to ensure low priority pods are unschedulable on the node(s) where high priority pods have `NominatedNodeName` set to the node(s).  ([#77990](https://github.com/kubernetes/kubernetes/pull/77990), [@Huang-Wei](https://github.com/Huang-Wei))

### Storage

- Fixed issue with kubelet waiting on invalid devicepath on AWS ([#78595](https://github.com/kubernetes/kubernetes/pull/78595), [@gnufied](https://github.com/gnufied))
- StorageOS volumes now show correct mount information (node and mount time) in the StorageOS administration CLI and UI. ([#78522](https://github.com/kubernetes/kubernetes/pull/78522), [@croomes](https://github.com/croomes))
- Fixed issue in Portworx volume driver causing controller manager to crash. ([#76341](https://github.com/kubernetes/kubernetes/pull/76341), [@harsh-px](https://github.com/harsh-px))
- For an empty regular file, `stat --printf %F` will now display `regular empty file` instead of `regular file`. ([#62159](https://github.com/kubernetes/kubernetes/pull/62159), [@dixudx](https://github.com/dixudx))
- You can now have different operation names for different storage operations. This still prevents two operations on same volume from happening concurrently but if the operation changes, it resets the exponential backoff.
([#75213](https://github.com/kubernetes/kubernetes/pull/75213), [@gnufied](https://github.com/gnufied))
- Reduced event spam for `AttachVolume` storage operation. ([#75986](https://github.com/kubernetes/kubernetes/pull/75986), [@mucahitkurt](https://github.com/mucahitkurt))
- Until this release, the iscsi plugin was waiting 10 seconds for a path to appear in the device list. However this timeout is not enough, or is less than the default device discovery timeout in most systems, which prevents certain devices from being discovered. This timeout has been raised to 30 seconds, which should help to avoid mount issues due to device discovery. ([#78475](https://github.com/kubernetes/kubernetes/pull/78475), [@humblec](https://github.com/humblec))
- Added a field to store CSI volume expansion secrets ([#77516](https://github.com/kubernetes/kubernetes/pull/77516), [@gnufied](https://github.com/gnufied))
- Fixed a bug in block volume expansion. ([#77317](https://github.com/kubernetes/kubernetes/pull/77317), [@gnufied](https://github.com/gnufied))
- Count PVCs that are unbound towards attach limit. ([#73863](https://github.com/kubernetes/kubernetes/pull/73863), [@gnufied](https://github.com/gnufied))

### VMware

- SAML token delegation (required for Zones support in vSphere) is now supported ([#78876](https://github.com/kubernetes/kubernetes/pull/78876), [@dougm](https://github.com/dougm))
- vSphere SAML token auth is now supported when using Zones ([#75515](https://github.com/kubernetes/kubernetes/pull/75515), [@dougm](https://github.com/dougm))

### Windows

- Kubectl port-forward for Windows containers was added in v1.15. To use it, you’ll need to build a new pause image including WinCAT. ([#75479](https://github.com/kubernetes/kubernetes/pull/75479), [@benmoss](https://github.com/benmoss))
- We’re working to simplify the Windows node join experience with better scripts and kubeadm. Scripts and doc updates are still in the works, but some of the needed improvements are included in 1.15.  These include:
    - Windows kube-proxy will wait for HNS network creation on start ([#78612](https://github.com/kubernetes/kubernetes/pull/78612), [@ksubrmnn](https://github.com/ksubrmnn))
    - kubeadm: implemented CRI detection for Windows worker nodes ([#78053](https://github.com/kubernetes/kubernetes/pull/78053), [@ksubrmnn](https://github.com/ksubrmnn))
- Worked toward support for Windows Server version 1903, including adding Windows support for preserving the destination IP as the VIP when loadbalancing with DSR. ([#74825](https://github.com/kubernetes/kubernetes/pull/74825), [@ksubrmnn](https://github.com/ksubrmnn))
- Bug fix: Windows Kubelet nodes will now correctly search the default location for Docker credentials (`%USERPROFILE%\.docker\config.json`) when pulling images from a private registry. (https://kubernetes.io/docs/concepts/containers/images/#configuring-nodes-to-authenticate-to-a-private-registry) ([#78528](https://github.com/kubernetes/kubernetes/pull/78528), [@bclau](https://github.com/bclau))


## Dependencies

### Changed

- The default Go version was updated to 1.12.5. ([#78528](https://github.com/kubernetes/kubernetes/pull/78528))
- cri-tools has been updated to v1.14.0. ([#75658](https://github.com/kubernetes/kubernetes/pull/75658))
- Cluster Autoscaler has been updated to v1.15.0. ([#78866](https://github.com/kubernetes/kubernetes/pull/78866))
- Kibana has been upgraded to v6.6.1. ([#71251](https://github.com/kubernetes/kubernetes/pull/71251))
- CAdvisor has been updated to v0.33.2. ([#76291](https://github.com/kubernetes/kubernetes/pull/76291))
- Fluentd-gcp-scaler has been upgraded to v0.5.2. ([#76762](https://github.com/kubernetes/kubernetes/pull/76762))
- Fluentd in fluentd-elasticsearch has been upgraded to v1.4.2. ([#76854](https://github.com/kubernetes/kubernetes/pull/76854))
- fluentd-elasticsearch has been updated to v2.5.2. ([#76854](https://github.com/kubernetes/kubernetes/pull/76854))
- event-exporter has been updated to v0.2.5. ([#77815](https://github.com/kubernetes/kubernetes/pull/77815))
- es-image has been updated to Elasticsearch 6.7.2. ([#77765](https://github.com/kubernetes/kubernetes/pull/77765))
- metrics-server has been updated to v0.3.3. ([#77950](https://github.com/kubernetes/kubernetes/pull/77950))
- ip-masq-agent has been updated to v2.4.1. ([#77844](https://github.com/kubernetes/kubernetes/pull/77844))
- addon-manager has been updated to v9.0.1 ([#77282](https://github.com/kubernetes/kubernetes/pull/77282))
- go-autorest has been updated to v11.1.2 ([#77070](https://github.com/kubernetes/kubernetes/pull/77070))
- klog has been updated to 0.3.0 ([#76474](https://github.com/kubernetes/kubernetes/pull/76474))
- k8s-dns-node-cache image has been updated to v1.15.1 ([#76640](https://github.com/kubernetes/kubernetes/pull/76640), [@george-angel](https://github.com/george-angel))

### Unchanged

- Default etcd server version remains unchanged at v3.3.10. The etcd client version was updated to v3.3.10. ([#71615](https://github.com/kubernetes/kubernetes/pull/71615), [#70168](https://github.com/kubernetes/kubernetes/pull/70168), [#76917](https://github.com/kubernetes/kubernetes/pull/76917))
- The list of validated docker versions remains unchanged.
  - The current list is 1.13.1, 17.03, 17.06, 17.09, 18.06, 18.09. ([#72823](https://github.com/kubernetes/kubernetes/pull/72823), [#72831](https://github.com/kubernetes/kubernetes/pull/72831))
- CNI remains unchanged at v0.7.5. ([#75455](https://github.com/kubernetes/kubernetes/pull/75455))
- CSI remains unchanged at to v1.1.0. ([#75391](https://github.com/kubernetes/kubernetes/pull/75391))
- The dashboard add-on remains unchanged at v1.10.1. ([#72495](https://github.com/kubernetes/kubernetes/pull/72495))
- kube-dns is unchanged at v1.14.13 as of Kubernetes 1.12. ([#68900](https://github.com/kubernetes/kubernetes/pull/68900))
- Influxdb is unchanged at v1.3.3 as of Kubernetes 1.10. ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Grafana is unchanged at v4.4.3 as of Kubernetes 1.10. ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- The fluent-plugin-kubernetes_metadata_filter plugin in fluentd-elasticsearch is unchanged at v2.1.6. ([#71180](https://github.com/kubernetes/kubernetes/pull/71180))
- fluentd-gcp is unchanged at v3.2.0 as of Kubernetes 1.13. ([#70954](https://github.com/kubernetes/kubernetes/pull/70954))
- OIDC authentication is unchanged at coreos/go-oidc v2 as of Kubernetes 1.10. ([#58544](https://github.com/kubernetes/kubernetes/pull/58544))
- Calico is unchanged at v3.3.1 as of Kubernetes 1.13. ([#70932](https://github.com/kubernetes/kubernetes/pull/70932))
- crictl on GCE was updated to v1.14.0. ([#75658](https://github.com/kubernetes/kubernetes/pull/75658))
- CoreDNS is unchanged at v1.3.1 as of Kubernetes 1.14. ([#78691](https://github.com/kubernetes/kubernetes/pull/78691))
- GLBC remains unchanged at v1.2.3 as of Kubernetes 1.12. ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- Ingress-gce remains unchanged at v1.2.3 as of Kubernetes 1.12. ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
