## What's New (Major Themes)

### Removal of several beta Kubernetes APIs

A number of APIs are no longer serving specific Beta versions in favour of the GA version of those APIs. All existing objects can be interacted with via general availability APIs. This removal includes beta versions of `ValidatingWebhookConfiguration`, `MutatingWebhookConfiguration`, `CustomResourceDefinition`, `APIService`, `TokenReview`, `SubjectAccessReview`, `CertificateSigningRequest`, `Lease`, `Ingress`, and `IngressClass` APIs. For the full list check out [Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22) and the blog post [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://blog.k8s.io/2021/07/14/upcoming-changes-in-kubernetes-1-22/).

### Kubernetes release cadence change

We all have to adapt to change in our lives, and especially so in the past year. The Kubernetes release team was also affected from the COVID-19 pandemic and has listened to its user base regarding the number of releases in a calendar year. From April 23, 2021 it was made official that Kubernetes release cadence has reduced from 4 releases per year to 3 releases per year.

You can read more in the official blog post [Kubernetes Release Cadence Change: Here’s What You Need To Know](https://blog.k8s.io/2021/07/20/new-kubernetes-release-cadence/).

### External credential providers

Kubernetes client [credential plugins](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#client-go-credential-plugins) have been in beta since 1.11, a few eons ago. With the release of Kubernetes 1.22, this feature set graduates to stable. The GA feature set includes improved support for plugins that provide interactive login flows.
This release also contains a number of bug fixes to the feature set. Aspiring plugin authors can look at [sample-exec-plugin](https://github.com/ankeesler/sample-exec-plugin) as a way to get started.

Related to this topic, the in-tree Azure and GCP authentication plugins have been [deprecated](https://github.com/kubernetes/kubernetes/pull/102181) in favor of out-of-tree implementations.

### Server-side Apply graduates to GA

Server-side Apply is a new object merge algorithm, as well as tracking of field ownership, running on the Kubernetes API server. Server-side Apply helps users and controllers manage their resources via declarative configurations. It allows them to create and/or modify their objects declaratively, simply by sending their fully specified intent. After being in beta for a couple releases, [Server-side Apply](https://kubernetes.io/docs/reference/using-api/server-side-apply/) is now generally available.

### Cluster Storage Interface graduations

CSI support for Windows nodes moves to GA in the 1.22 release. In Kubernetes v1.22, Windows privileged containers are only an alpha feature. To allow using CSI storage on Windows nodes, [CSIProxy](https://github.com/kubernetes-csi/csi-proxy) enables CSI node plugins to be deployed as unprivileged pods, using the proxy to perform privileged storage operations on the node.

Another feature moving to GA in v1.22 is CSI Service Account Token support. This feature allows CSI drivers to use pods' [bound service account tokens](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/#bound-service-account-token-volume) instead of a more privileged identity. It also provides control over to re-publishing these volumes, so that short-lived tokens can be refreshed.

### SIG Windows development tools

To grow the developer community, SIG Windows  released multiple [tools](https://github.com/kubernetes-sigs/sig-windows-dev-tools/). The new tools support multiple CNI providers (Antrea, Calico), can run on multiple platforms (any vagrant compatible provider, such as Hyper-V, VirtualBox, or vSphere).
There is also a new way to run bleeding edge Windows features from scratch by compiling the windows kubelet and kube-proxy, then using them along with daily builds of other Kubernetes components.

### Deploy a more secure control plane with kubeadm

A new alpha feature allows running the kubeadm control plane components as non-root users. This is a long requested security measure in kubeadm. To try it you must enable the kubeadm-specific `RootlessControlPlane` feature gate. When you deploy a cluster using this alpha feature, your control plane runs with lower privileges.

A new [v1beta3 configuration API](https://github.com/kubernetes/kubeadm/issues/1796). It [iterates over v1beta2](https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta3) by adding some long requested features and deprecating some existing ones. The `V1beta3` is now the preferred API version; the `v1beta2` API also remains available and is not yet deprecated.

### etcd moves to version 3.5.0

Kubernetes' default backend storage, etcd, has a new release 3.5.0 and the community embraced it. The new release comes with improvements to the Security, performance, monitoring and developer experience. There are numerous bug fixes to lease objects causing memory leaks, and compact operation causing deadlocks and more. A couple of new features are also introduced like the migration to structured logging and build in log rotation. The release comes with a detailed future roadmap to implement a solution to traffic overload. A full and detailed list of changes can be read in the [3.5.0 release announcement](https://etcd.io/blog/2021/announcing-etcd-3.5/).

### Kubernetes Node system swap support

Every system administrator or Kubernetes user has been in the same boat regarding setting up and using Kubernetes: disable swap space. With the release of Kubernetes 1.22, *alpha* support is available to run nodes with swap memory. This change lets administrators opt in to configuring swap on Linux nodes, treating a portion of block storage as additional virtual memory.

### Cluster-wide seccomp defaults

A new alpha feature gate `SeccompDefault` has been added to the kubelet, together with a corresponding command line flag `--seccomp-default` and kubelet configuration. If both are enabled, then the kubelet's behavior changes for pods that don't explicitly set a seccomp profile.
With cluster-wide seccomp defaults, the kubelet uses the `RuntimeDefault` seccomp profile by default, rather than than `Unconfined`. This allows enhancing the default cluster wide workload security of the Kubernetes deployment. Security administrators will now sleep better knowing there is some security by default for the workloads.

To learn more about the feature, please refer to the official [seccomp tutorial](https://kubernetes.io/docs/tutorials/clusters/seccomp/#enable-the-use-of-runtimedefault-as-the-default-seccomp-profile-for-all-workloads).

### Quality of Service for memory resources

Originally, Kubernetes used the v1 cgroups API. With that design, the QoS class for a pod only applied to CPU resources (such as `cpu_shares`). The Kubernetes cgroup manager uses `memory.limit_in_bytes` in v1 cgroups to limit the memory capacity for a container, and uses `oom_scores` to recommend an order for killing container processes if an out-of-memory event occurs. This implementation has shortcomings: for `Guaranteed` pods, memory can not be fully reserved, and the page cache is at risk of being recycled. For `Burstable` pods, overcommitting memory (setting `request` less than `limit` ) could increase the risk of a container being killed when the Linux kernel detects an out of memory condition.

As an alpha feature, Kubernetes v1.22 can use the cgroups v2 API to control memory allocation and isolation. This feature is designed to improve workload and node availability when there is contention for memory resources.

### API changes and improvements for ephemeral containers

The API used to create [Ephemeral Containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/) changed in 1.22. The Ephemeral Containers feature is alpha and disabled by default, and the new API does not work with clients that attempt to use the old API.

For stable features, the `kubectl` tool follows the Kubernetes [version skew policy](https://kubernetes.io/releases/version-skew-policy/);
however, kubectl v1.21 and older do not support the new API for ephemeral containers.
Users who create ephemeral containers using `kubectl debug` should note that kubectl version 1.22 will attempt to fall back to the old API; older versions of kubectl will not work with cluster versions of 1.22 or later. Please update kubectl to 1.22 if you wish to use `kubectl debug` with a mix of cluster versions.

## Known Issues

### CPU and Memory manager are not working correctly for Guaranteed Pods with multiple containers

A regression bug was found where guaranteed Pods with multiple containers do not work properly with set allocations for CPU, Memory, and Device manager. [The fix will be availability in coming releases](https://github.com/kubernetes/kubernetes/pull/103979).

### `CSIMigrationvSphere` feature gate has not migrated to new CRD APIs

If CSIMigrationvSphere feature gate is enabled, user should not upgrade to Kubernetes v1.22. vSphere CSI Driver does not support Kubernetes v1.22 yet because it uses v1beta1 CRD APIs. Support for v1.22 will be added at a later release. Check the following document for supported Kubernetes releases for a given [vSphere CSI Driver version](https://vsphere-csi-driver.sigs.k8s.io/compatiblity_matrix.html#compatibility-matrix-for-vsphere-csi-driver).

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Audit log files are now created with a mode of 0600. Existing file permissions will not be changed. If you need the audit file to be readable by a non-root user, you can pre-create the file with the desired permissions. ([#95387](https://github.com/kubernetes/kubernetes/pull/95387), [@JAORMX](https://github.com/JAORMX)) [SIG API Machinery and Auth]
 - CSI migration of AWS EBS volumes requires AWS EBS CSI driver ver. 1.0 that supports `allowAutoIOPSPerGBIncrease` parameter in StorageClass. ([#101082](https://github.com/kubernetes/kubernetes/pull/101082), [@jsafrane](https://github.com/jsafrane))
 - Conformance image is now built with Distroless. Users running Conformance testing should rely on container entrypoint instead of manual invocation to `/run_e2e.sh` or `/gorunner`, as they are now deprecated and will be removed in 1.25 release. Invoking `ginkgo` and `e2e.test` are still supported through overriding entrypoint (docker) or defining container `spec.command` (kubernetes). ([#99178](https://github.com/kubernetes/kubernetes/pull/99178), [@wilsonehusin](https://github.com/wilsonehusin))
 - Default `StreamingProxyRedirects` to disabled. If there is a >= 2 version skew between master and nodes, and the old nodes were enabling `--redirect-container-streaming`, this will break them. In this case, the `StreamingProxyRedirects` can still be manually enabled. ([#101647](https://github.com/kubernetes/kubernetes/pull/101647), [@pacoxu](https://github.com/pacoxu))
 - Intree volume plugin scaleIO support has been completely removed from Kubernetes. ([#101685](https://github.com/kubernetes/kubernetes/pull/101685), [@Jiawei0227](https://github.com/Jiawei0227))
 - Kubeadm: remove the automatic detection and matching of cgroup drivers for Docker. For new clusters if you have not configured the cgroup driver explicitly you might get a failure in the `kubelet` on driver mismatch (kubeadm clusters should be using the `systemd` driver). Also remove the `IsDockerSystemdCheck` preflight check (warning) that checks if the Docker cgroup driver is set to `systemd`. Ideally such detection / coordination should be on the side of CRI implementers and the kubelet (tracked [here](https://github.com/kubernetes/kubernetes/issues/99808)). Please see the [page](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/) on how to configure cgroup drivers with kubeadm manually ([#99647](https://github.com/kubernetes/kubernetes/pull/99647), [@neolit123](https://github.com/neolit123))
 - Kubeadm: the flag `--cri-socket` is no longer allowed in a mixture with the flag `--config`. Please use the kubeadm configuration for setting the CRI socket for a node using `{Init|Join}Configuration.nodeRegistration.criSocket`. ([#101600](https://github.com/kubernetes/kubernetes/pull/101600), [@KofClubs](https://github.com/KofClubs))
 - Newly provisioned PVs by Azure disk will no longer have the beta `FailureDomain` label. Azure disk volume plugin will start to have GA topology label instead. ([#101534](https://github.com/kubernetes/kubernetes/pull/101534), [@kassarl](https://github.com/kassarl))
 - Scheduler's CycleState now embeds internal read/write locking inside its `Read()` and `Write()` functions. Meanwhile, `Lock()` and `Unlock()` function are removed. Scheduler plugin developers are now required to remove `CycleState#Lock()` and `CycleState#Unlock()`. Just simply use `Read()` and `Write()` as they're natively thread-safe now. ([#101542](https://github.com/kubernetes/kubernetes/pull/101542), [@Huang-Wei](https://github.com/Huang-Wei))
 - The `CSIMigrationVSphereComplete` feature flag is removed. `InTreePluginvSphereUnregister` will be the way moving forward. ([#101272](https://github.com/kubernetes/kubernetes/pull/101272), [@Jiawei0227](https://github.com/Jiawei0227))
 - The flag `--experimental-patches` is now deprecated and will be removed in a future release. You can migrate to using the new flag `--patches`. Add a new field `{Init|Join}Configuration.patches.directory` that can be used for the same purpose. For `init` and `join` it is now recommended that you migrate to configure patches via `{Init|Join}Configuration.patches.directory`. For the time being, these flags can be mixed with `--config`, but that might change in the future. On a command line, the last *patches flag takes precedence over previous flags and the value in config. `kubeadm upgrade --patches` will continue to be the only available option, since `upgrade` does not support a configuration file yet. ([#103063](https://github.com/kubernetes/kubernetes/pull/103063), [@neolit123](https://github.com/neolit123))
 
## Changes by Kind

### Deprecation

- Controller-manager: the following flags have no effect and would be removed in v1.24:
  - `--port`
  - `--address`
  The insecure port flags `--port` may only be set to 0 now.
  
  In addtion, please be careful that:
  - controller-manager MUST start with `--authorization-kubeconfig` and `--authentication-kubeconfig` correctly set to get authentication/authorization working.
  - liveness/readiness probes to controller-manager MUST use HTTPS now, and the default port has been changed to 10257.
  - Applications that fetch metrics from controller-manager should use a dedicated service account which is allowed to access nonResourceURLs `/metrics`. ([#96216](https://github.com/kubernetes/kubernetes/pull/96216), [@knight42](https://github.com/knight42)) [SIG API Machinery, Cloud Provider, Instrumentation and Testing]
- Deprecate `--record` flag in `kubectl`. The `--record` flag is being replaced with the [mechanism](https://github.com/kubernetes/enhancements/tree/master/keps/sig-cli/859-kubectl-headers) which annotates HTTP requests with kubectl command details. ([#102873](https://github.com/kubernetes/kubernetes/pull/102873), [@soltysh](https://github.com/soltysh))
- E2e.test: removed the  `--viper-config` flag. If you were previously using this to pass flags to `e2e.test` via a file, you will need to pass them directly on the command line, e.g. `e2e.test --e2e-output-dir`. ([#102598](https://github.com/kubernetes/kubernetes/pull/102598), [@dims](https://github.com/dims))
- For `kubeadm`: remove the ClusterStatus API from v1beta3 and its management in the kube-system/kubeadm-config ConfigMap. This method of keeping track of what API endpoints exists in the cluster was replaced (in a prior release) by a method to annotate the etcd Pods that `kubeadm` creates in "stacked etcd" clusters. The following CLI sub-phases are deprecated and are now a NO-OP: for `kubeadm join`: "control-plane-join/update-status", for `kubeadm reset`: "update-cluster-status". Unless you are using these phases explicitly, you should not be affected. ([#101915](https://github.com/kubernetes/kubernetes/pull/101915), [@neolit123](https://github.com/neolit123))
- Kubead: remove the deprecated `--csr-only` and `--csr-dir` flags from `kubeadm init phase certs`. Deprecate the same flags under `kubeadm certs renew`. In both the cases the command `kubeadm certs generate-csr` should be used instead. ([#102108](https://github.com/kubernetes/kubernetes/pull/102108), [@neolit123](https://github.com/neolit123))
- Kubeadm: Remove the deprecated command `kubeadm alpha kubeconfig`. Please use `kubeadm kubeconfig` instead. ([#101938](https://github.com/kubernetes/kubernetes/pull/101938), [@knight42](https://github.com/knight42))
- Kubeadm: Remove the deprecated hyperkube image support in `v1beta3`. This implies removal of `ClusterConfiguration.UseHyperKubeImage.` ([#101537](https://github.com/kubernetes/kubernetes/pull/101537), [@neolit123](https://github.com/neolit123))
- Kubeadm: Remove the field `ClusterConfiguration.DNS.Type` in v1beta3 since CoreDNS is the only supported DNS type. ([#101547](https://github.com/kubernetes/kubernetes/pull/101547), [@neolit123](https://github.com/neolit123))
- Kubeadm: remove the deprecated command `kubeadm config view`. A replacement for this command is `kubectl get cm -n kube-system kubeadm-config -o=jsonpath="{.data.ClusterConfiguration}"` ([#102071](https://github.com/kubernetes/kubernetes/pull/102071), [@neolit123](https://github.com/neolit123))
- Kubeadm: remove the deprecated flag '--image-pull-timeout' for 'kubeadm upgrade apply' command ([#102093](https://github.com/kubernetes/kubernetes/pull/102093), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated flag `--insecure-port` from the kube-apiserver manifest that kubeadm manages. The flag had no effect since 1.20, since the insecure serving of the component was disabled in the same version. ([#102121](https://github.com/kubernetes/kubernetes/pull/102121), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: remove the deprecated kubeadm API `v1beta1`. Introduce a new kubeadm API `v1beta3`. See [kubeadm/v1beta3](https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta3) for a list of changes since `v1beta2`. Note that `v1beta2` is not yet deprecated, but will be in a future release. ([#101129](https://github.com/kubernetes/kubernetes/pull/101129), [@neolit123](https://github.com/neolit123))
- Newly provisioned PVs by vSphere in-tree plugin will no longer have the beta `FailureDomain` label. vSphere volume plugin will start to have GA topology label ([#102414](https://github.com/kubernetes/kubernetes/pull/102414), [@divyenpatel](https://github.com/divyenpatel))
- Removal of the CSI `NodePublish` path by the kubelet is deprecated. This must be done by the CSI plugin according to the CSI spec. ([#101441](https://github.com/kubernetes/kubernetes/pull/101441), [@dobsonj](https://github.com/dobsonj))
- Remove support for the Service `topologyKeys` field (alpha) and the `kube-proxy` implementation of it. This field was deprecated several cycles ago. This functionality is replaced by the combination of automatic topology hints per-endpoint (alpha) and the Service `internalTrafficPolicy` field (alpha). ([#102412](https://github.com/kubernetes/kubernetes/pull/102412), [@andrewsykim](https://github.com/andrewsykim))
- The `PodUnknown` phase is now deprecated. ([#95286](https://github.com/kubernetes/kubernetes/pull/95286), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- The `storageos`, `quobyte` and `flocker` storage volume plugins are deprecated and will be removed in a later release. ([#101773](https://github.com/kubernetes/kubernetes/pull/101773), [@Jiawei0227](https://github.com/Jiawei0227))
- The deprecated flag `--hard-pod-affinity-symmetric-weight` and `--scheduler-name` have been removed from `kube-scheduler`. Use `ComponentConfig` instead to configure those parameters. ([#102805](https://github.com/kubernetes/kubernetes/pull/102805), [@ahg-g](https://github.com/ahg-g))
- The feature Dynamic Kubelet Configuration is deprecated and kubelet will report warning when the flag `--dynamic-config-dir` is used. Feature gate `DynamicKubeletConfig` is disabled out of the box and needs to be explicitly enabled. ([#102966](https://github.com/kubernetes/kubernetes/pull/102966), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Cloud Provider, Instrumentation and Node]
- The in-tree azure and gcp auth plugins have been deprecated.  The https://github.com/Azure/kubelogin and gcloud commands serve as out-of-tree replacements via the kubectl/client-go credential plugin mechanism. ([#102181](https://github.com/kubernetes/kubernetes/pull/102181), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- The ingress `v1beta1` has been deprecated. ([#102030](https://github.com/kubernetes/kubernetes/pull/102030), [@aojea](https://github.com/aojea))

### API Change

- A new score extension for NodeResourcesFit plugin that merges the functionality of `NodeResourcesLeastAllocated`, `NodeResourcesMostAllocated`, `RequestedToCapacityRatio` plugins, which are marked as deprecated as of v1beta2. In v1beta1, the three plugins can still be used in v1beta1 but not at the same time with the score extension of `NodeResourcesFit`. ([#101822](https://github.com/kubernetes/kubernetes/pull/101822), [@yuzhiquan](https://github.com/yuzhiquan))
- A value of `Auto` is now a valid for the `service.kubernetes.io/topology-aware-hints` annotation. ([#100728](https://github.com/kubernetes/kubernetes/pull/100728), [@robscott](https://github.com/robscott))
- Add `DataSourceRef` alpha field to PVC spec, which allows contents other than `PVCs` and `VolumeSnapshots` to be data sources. ([#103276](https://github.com/kubernetes/kubernetes/pull/103276), [@bswartz](https://github.com/bswartz))
- Add `PersistentVolumeClaimDeletePoilcy` to StatefulSet API. ([#99378](https://github.com/kubernetes/kubernetes/pull/99378), [@mattcary](https://github.com/mattcary))
- Add a new Priority and Fairness rule that exempts all probes (`/readyz`, `/healthz`, `/livez`) to prevent restarting of healthy `kube-apiserver` instance by kubelet. ([#100678](https://github.com/kubernetes/kubernetes/pull/100678), [@tkashem](https://github.com/tkashem))
- Add alpha support for HostProcess containers on Windows ([#99576](https://github.com/kubernetes/kubernetes/pull/99576), [@marosset](https://github.com/marosset)) [SIG API Machinery, Apps, Node, Testing and Windows]
- Add distributed tracing to the `kube-apiserver`. It is can be enabled with the feature gate `APIServerTracing` ([#94942](https://github.com/kubernetes/kubernetes/pull/94942), [@dashpole](https://github.com/dashpole))
- Add three metrics to the job controller to monitor if a job works in healthy condition.
  `IndexedJob` has been promoted to Beta. ([#101292](https://github.com/kubernetes/kubernetes/pull/101292), [@AliceZhang2016](https://github.com/AliceZhang2016))
- Added field `.status.uncountedTerminatedPods` to the Job resource. This field is used by the job controller to keep track of finished pods before adding them to the Job status counters. Pods created by the job controller get the finalizer `batch.kubernetes.io/job-tracking`
  Jobs that are tracked using this mechanism get the annotation `batch.kubernetes.io/job-tracking`. This is a temporary measure. Two releases after this feature graduates to beta, the annotation won't be added to Jobs anymore. ([#98817](https://github.com/kubernetes/kubernetes/pull/98817), [@alculquicondor](https://github.com/alculquicondor))
- Added new kubelet alpha feature `SeccompDefault`. This feature enables falling back to
  the `RuntimeDefault` (former `runtime/default`) seccomp profile if nothing else is specified
  in the pod/container `SecurityContext` or the pod annotation level. To use the feature, enable
  the feature gate as well as set the kubelet configuration option `SeccompDefault`
  (`--seccomp-default`) to `true`. ([#101943](https://github.com/kubernetes/kubernetes/pull/101943), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node]
- Adds the `ReadWriteOncePod` access mode for `PersistentVolumes` and `PersistentVolumeClaims`. Restricts volume access to a single pod on a single node. ([#102028](https://github.com/kubernetes/kubernetes/pull/102028), [@chrishenzie](https://github.com/chrishenzie))
- Alpha swap support can now be enabled on Kubernetes nodes with the `NodeSwapEnabled` feature flag. See [KEP-2400](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/2400-node-swap/README.md#design-details) for details. ([#102823](https://github.com/kubernetes/kubernetes/pull/102823), [@ehashman](https://github.com/ehashman))
- Because of the implementation logic of `time.Format` in golang, the displayed time zone is not consistent. ([#102366](https://github.com/kubernetes/kubernetes/pull/102366), [@cndoit18](https://github.com/cndoit18))
- Corrected the documentation for escaping dollar signs in a container's env, command and args property. ([#101916](https://github.com/kubernetes/kubernetes/pull/101916), [@MartinKanters](https://github.com/MartinKanters)) [SIG Apps]
- Enable `MaxSurge` for `DaemonSet` by default. ([#101742](https://github.com/kubernetes/kubernetes/pull/101742), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Enforce the `ReadWriteOncePod` PVC access mode during scheduling ([#103082](https://github.com/kubernetes/kubernetes/pull/103082), [@chrishenzie](https://github.com/chrishenzie))
- Ephemeral containers are now allowed to configure a `securityContext` that differs from that of the Pod. Cluster administrators should ensure that security policy controllers support `EphemeralContainers` before enabling this feature in clusters. ([#99023](https://github.com/kubernetes/kubernetes/pull/99023), [@verb](https://github.com/verb))
- Exec plugin authors can override default handling of standard input via new `interactiveMode` kubeconfig field. ([#99310](https://github.com/kubernetes/kubernetes/pull/99310), [@ankeesler](https://github.com/ankeesler))
- If someone had the `ProbeTerminationGracePeriod` alpha feature enabled in 1.21, they should update/delete any workloads/pods with probe `terminationGracePeriods` < 1 before upgrading ([#103245](https://github.com/kubernetes/kubernetes/pull/103245), [@wzshiming](https://github.com/wzshiming))
- Improved parsing of label selectors ([#102188](https://github.com/kubernetes/kubernetes/pull/102188), [@alculquicondor](https://github.com/alculquicondor)) [SIG API Machinery]
- Introduce `minReadySeconds` api to the `StatefulSets`. ([#100842](https://github.com/kubernetes/kubernetes/pull/100842), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Introducing Memory quality of service support with `cgroups v2 (Alpha)`. The `MemoryQoS` feature is now in Alpha. This allows `kubelet` running with `cgroups v2` to set memory QoS at container, pod and QoS level to protect and guarantee better memory quality. This feature can be enabled through feature gate Memory QoS. ([#102970](https://github.com/kubernetes/kubernetes/pull/102970), [@borgerli](https://github.com/borgerli))
- Kube API server accepts `Impersonate-Uid` header to impersonate a user with a specific UID, in the same way that you can currently use `Impersonate-User`, `Impersonate-Group` and `Impersonate-Extra`. ([#99961](https://github.com/kubernetes/kubernetes/pull/99961), [@margocrawf](https://github.com/margocrawf))
- Kube-apiserver: `--service-account-issuer` can be specified multiple times now, to enable non-disruptive change of issuer. ([#101155](https://github.com/kubernetes/kubernetes/pull/101155), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth, Node and Testing]
- Kube-controller-manager: the `--horizontal-pod-autoscaler-use-rest-clients` flag and Heapster support in the horizontal pod autoscaler, deprecated since 1.12, is removed. ([#90368](https://github.com/kubernetes/kubernetes/pull/90368), [@serathius](https://github.com/serathius))
- Kube-scheduler: a plugin enabled in a v1beta2 configuration file takes precedence over the default configuration for that plugin. This simplifies enabling default plugins with custom configuration without needing to explicitly disable those default plugins. ([#99582](https://github.com/kubernetes/kubernetes/pull/99582), [@chendave](https://github.com/chendave))
- New `node-high` priority-level has been added to Suggested API Priority and ([#101151](https://github.com/kubernetes/kubernetes/pull/101151), [@mborsz](https://github.com/mborsz))
- NodeSwapEnabled feature flag was renamed to NodeSwap
  
  The flag was only available in the 1.22.0-beta.1 release, and the new flag should be used going forward. ([#103553](https://github.com/kubernetes/kubernetes/pull/103553), [@ehashman](https://github.com/ehashman)) [SIG Node]
- Omit comparison with boolean constant ([#101523](https://github.com/kubernetes/kubernetes/pull/101523), [@chuntaochen](https://github.com/chuntaochen)) [SIG CLI and Cloud Provider]
- Removed the feature flag for probe-level termination grace period from Kubelet. If a user wants to disable this feature on already created pods, they will have to delete and recreate the pods. ([#103168](https://github.com/kubernetes/kubernetes/pull/103168), [@raisaat](https://github.com/raisaat)) [SIG Apps and Node]
- Revert addition of Add `PersistentVolumeClaimDeletePoilcy` to `StatefulSet`API. ([#103747](https://github.com/kubernetes/kubernetes/pull/103747), [@mattcary](https://github.com/mattcary))
- Scheduler could be configured  to consider new resources beside CPU and memory,  GPU for example, for the score plugin of `NodeResourcesBalancedAllocation`. ([#101946](https://github.com/kubernetes/kubernetes/pull/101946), [@chendave](https://github.com/chendave)) [SIG Scheduling]
- Server Side Apply now treats all <Some>Selector fields as atomic (meaning the entire selector is managed by a single writer and updated together), since they contain interrelated and inseparable fields that do not merge in intuitive ways. ([#97989](https://github.com/kubernetes/kubernetes/pull/97989), [@Danil-Grigorev](https://github.com/Danil-Grigorev)) [SIG API Machinery]
- Suspend Job feature graduated to beta. Added the `action` label to Job controller sync metrics `job_sync_total` and `job_sync_duration_seconds`. ([#102022](https://github.com/kubernetes/kubernetes/pull/102022), [@adtac](https://github.com/adtac))
- The API documentation for the DaemonSet's `spec.updateStrategy.rollingUpdate.maxUnavailable` field was corrected to state that the value is rounded up. ([#101296](https://github.com/kubernetes/kubernetes/pull/101296), [@Miciah](https://github.com/Miciah))
- The `CSIServiceAccountToken` graduates to Ga and is unconditionally enabled. ([#103001](https://github.com/kubernetes/kubernetes/pull/103001), [@zshihang](https://github.com/zshihang))
- The `CertificateSigningRequest.certificates.k8s.io` API supports an optional expirationSeconds field to allow the client to request a particular duration for the issued certificate.  The default signer implementations provided by the Kubernetes controller manager will honor this field as long as it does not exceed the --cluster-signing-duration flag. ([#99494](https://github.com/kubernetes/kubernetes/pull/99494), [@enj](https://github.com/enj))
- The `EndpointSlicen Mirroring controller` no longer mirrors the `last-applied-configuration` annotation created by `kubectl` to update `EndpointSlices`. ([#102731](https://github.com/kubernetes/kubernetes/pull/102731), [@sharmarajdaksh](https://github.com/sharmarajdaksh))
- The `NetworkPolicyEndPort` is graduated to beta and is enabled by default. ([#102834](https://github.com/kubernetes/kubernetes/pull/102834), [@rikatz](https://github.com/rikatz))
- The `PodDeletionCost` feature has been promoted to beta, and enabled by default. ([#101080](https://github.com/kubernetes/kubernetes/pull/101080), [@ahg-g](https://github.com/ahg-g))
- The `Server Side Apply` treats certain structs as atomic. Meaning the entire selector field is managed by a single writer and updated together. ([#100684](https://github.com/kubernetes/kubernetes/pull/100684), [@Jefftree](https://github.com/Jefftree))
- The `ServiceAppProtocol` feature gate has been removed. It reached GA in Kubernetes ([#103190](https://github.com/kubernetes/kubernetes/pull/103190), [@robscott](https://github.com/robscott))
- The `TerminationGracePeriodSeconds` on pod specs and container probes should not be negative. Negative values of `TerminationGracePeriodSeconds` will be treated as the value `1s` on the delete path. Immutable field validation will be relaxed in order to update negative values. In a future release, negative values will not be permitted. ([#98866](https://github.com/kubernetes/kubernetes/pull/98866), [@wzshiming](https://github.com/wzshiming))
- The `kube-scheduler` component config `v1beta2` API available
  Three scheduler plugins deprecated (`NodeLabel`, `ServiceAffinity`, `NodePreferAvoidPods`). ([#99597](https://github.com/kubernetes/kubernetes/pull/99597), [@adtac](https://github.com/adtac))
- The `pod/eviction` subresource now accepts `policy/v1` eviction requests in addition to `policy/v1beta1` eviction requests ([#100724](https://github.com/kubernetes/kubernetes/pull/100724), [@liggitt](https://github.com/liggitt))
- The `podAffinity`, `NamespaceSelector` and the associated `CrossNamespaceAffinity` quota scope features graduate to Beta and they are now enabled by default. ([#101496](https://github.com/kubernetes/kubernetes/pull/101496), [@ahg-g](https://github.com/ahg-g))
- The `pods/ephemeralcontainers` API now returns and expects a `Pod` object instead of `EphemeralContainers`. This is incompatible with the previous alpha-level API. ([#101034](https://github.com/kubernetes/kubernetes/pull/101034), [@verb](https://github.com/verb)) [SIG Apps, Auth, CLI and Testing]
- The `v1.Node` and `.status.images[].names` are  now optional. ([#102159](https://github.com/kubernetes/kubernetes/pull/102159), [@roycaihw](https://github.com/roycaihw))
- The deprecated flag `--algorithm-provider` has been removed from `kube-scheduler`. Use instead `ComponentConfig` to configure the set of enabled plugins. ([#102239](https://github.com/kubernetes/kubernetes/pull/102239), [@Haleygo](https://github.com/Haleygo))
- The options `--ssh-user` and `--ssh-key` are removed. They only functioned on GCE, and only in-tree. Use the apiserver network proxy instead. ([#102297](https://github.com/kubernetes/kubernetes/pull/102297), [@deads2k](https://github.com/deads2k))
- Track Job completion through status and Pod finalizers, removing dependency on Pod tombstones. ([#98238](https://github.com/kubernetes/kubernetes/pull/98238), [@alculquicondor](https://github.com/alculquicondor)) [SIG API Machinery, Apps, Auth and Testing]
- Track ownership of scale subresource for all scalable resources i.e. Deployment, ReplicaSet, StatefulSet, ReplicationController, and Custom Resources. ([#98377](https://github.com/kubernetes/kubernetes/pull/98377), [@nodo](https://github.com/nodo)) [SIG API Machinery and Testing]

### Feature

- A `system-cluster-critical` pod should not get a low OOM Score. 
  
  As of now both `system-node-critical` and `system-cluster-critical` pods have -997 OOM score, making them one of the last processes to be OOMKilled. By definition `system-cluster-critical` pods can be scheduled elsewhere if there is a resource crunch on the node where as `system-node-critical` pods cannot be rescheduled. This was the reason for `system-node-critical` to have higher priority value than `system-cluster-critical`.  This change allows only `system-node-critical` priority class to have low OOMScore.
  
  action required
  If the user wants to have the pod to be OOMKilled last and the pod has `system-cluster-critical` priority class, it has to be changed to `system-node-critical` priority class to preserve the existing behavior ([#99729](https://github.com/kubernetes/kubernetes/pull/99729), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- API Server tracing can now trace re-entrant api requests. ([#103218](https://github.com/kubernetes/kubernetes/pull/103218), [@dashpole](https://github.com/dashpole)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- APIServerTracing now collects spans from etcd client calls, and propagates context to etcd. ([#103216](https://github.com/kubernetes/kubernetes/pull/103216), [@dashpole](https://github.com/dashpole)) [SIG API Machinery, Cloud Provider and Instrumentation]
- APIServerTracing now collects spans from outgoing requests to admission webhooks. ([#103601](https://github.com/kubernetes/kubernetes/pull/103601), [@dashpole](https://github.com/dashpole)) [SIG API Machinery]
- Add a namespace label for all `apiserver_admission_* metrics`.
  Expand the histogram range to 0-10s for all `apiserver_admission_*_duration_seconds` metrics. ([#101208](https://github.com/kubernetes/kubernetes/pull/101208), [@voutcn](https://github.com/voutcn))
- Add unified map on CRI to support `cgroup v2`. Refer to https://github.com/opencontainers/runtime-spec/blob/master/config-linux.md#unified. ([#102578](https://github.com/kubernetes/kubernetes/pull/102578), [@payall4u](https://github.com/payall4u))
- Added BinaryData description to `kubectl describe` command. ([#100568](https://github.com/kubernetes/kubernetes/pull/100568), [@lauchokyip](https://github.com/lauchokyip))
- Added a new metric `apiserver_flowcontrol_request_concurrency_in_use` that shows the number of
  seats (concurrency) occupied by the currently executing requests in the API Priority and Fairness system. ([#102795](https://github.com/kubernetes/kubernetes/pull/102795), [@tkashem](https://github.com/tkashem))
- Added field-selector option for `kubectl top pod` ([#102155](https://github.com/kubernetes/kubernetes/pull/102155), [@lauchokyip](https://github.com/lauchokyip)) [SIG CLI]
- Added new metrics about API Priority and Fairness.  Each one has a label `priority_level`.  The last two also have a label `bound` taking values `min` and `max.
  - apiserver_flowcontrol_current_r: R(the time of the last change in state of the queues)
  - apiserver_flowcontrol_dispatch_r: R(the time of the latest request dispatch)
  - apiserver_flowcontrol_latest_s: S(the request last dispatched) = R(when that request starts executing in the virtual world)
  - apiserver_flowcontrol_next_s_bounds: min and max next S among non-empty queues
  - apiserver_flowcontrol_next_discounted_s_bounds: min and max next S - (sum [over requests executing] width * estimatedDuration) among non-empty queues ([#102859](https://github.com/kubernetes/kubernetes/pull/102859), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery and Instrumentation]
- Adding `--restart-kubelet` flag on E2E Node test suite ([#97028](https://github.com/kubernetes/kubernetes/pull/97028), [@knabben](https://github.com/knabben)) [SIG Node and Testing]
- Adds feature gate `KubeletInUserNamespace` which enables support for running kubelet in a user namespace.
  
  The user namespace has to be created before running kubelet.
  All the node components such as CRI need to be running in the same user namespace.
  
  When the feature gate is enabled, kubelet ignores errors that happens during setting the following sysctl values: `vm.overcommit_memory`, `vm.panic_on_oom`, `kernel.panic`, `kernel.panic_on_oops`, `kernel.keys.root_maxkeys`, `kernel.keys.root_maxbytes`. (These sysctl values for the host, not for the containers)
  
  kubelet also ignores an error during opening `/dev/kmsg`.
  This feature gate also allows kube-proxy to ignore an error during setting `RLIMIT_NOFILE`.
  
  This feature gate is especially useful for running Kubernetes inside Rootless Docker/Podman with `kind` or `minikube`. ([#92863](https://github.com/kubernetes/kubernetes/pull/92863), [@AkihiroSuda](https://github.com/AkihiroSuda)) [SIG Network, Node and Testing]
- Adds metrics for the delegated authenticator used by extension APIs that delegate authentication logic to the Kube API server. ([#99364](https://github.com/kubernetes/kubernetes/pull/99364), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Adds metrics for the delegated authorizer used by extension APIs that delegate authorization logic to the Kube API server. ([#100339](https://github.com/kubernetes/kubernetes/pull/100339), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Adds two kubemark flags, `--max-pods` and `--extended-resources`. ([#100267](https://github.com/kubernetes/kubernetes/pull/100267), [@Jeffwan](https://github.com/Jeffwan))
- An audit log entry will be generated when a `ValidatingAdmissionWebhook` is failing to open. ([#92739](https://github.com/kubernetes/kubernetes/pull/92739), [@cnphil](https://github.com/cnphil))
- Base images: Updated to
  - debian-base:buster-v1.6.0
  - debian-iptables:buster-v1.6.0 ([#100976](https://github.com/kubernetes/kubernetes/pull/100976), [@jindijamie](https://github.com/jindijamie))
- Base-images: Update to `debian-base:buster-v1.7.1` ([#102594](https://github.com/kubernetes/kubernetes/pull/102594), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Deprecated warning message for `igonre-errors` flag. ([#102677](https://github.com/kubernetes/kubernetes/pull/102677), [@yuzhiquan](https://github.com/yuzhiquan))
- Endpoints that have more than 1000 endpoints will be truncated and the `endpoints.kubernetes.io/over-capacity` annotation on the Endpoints resource will be set to `truncated`. ([#103520](https://github.com/kubernetes/kubernetes/pull/103520), [@swetharepakula](https://github.com/swetharepakula)) [SIG Apps and Network]
- Expose `/debug/flags/v` to allow dynamically setting log level for kube-proxy. ([#98306](https://github.com/kubernetes/kubernetes/pull/98306), [@borgerli](https://github.com/borgerli)) [SIG Network]
- Expose container start time as `container_start_time_seconds` in the kubelet `/metrics/resource` endpoint. ([#102444](https://github.com/kubernetes/kubernetes/pull/102444), [@sanwishe](https://github.com/sanwishe))
- Extended resources defined in `LeastAllocated`, `MostAllocated` and `RequestedToCapacityRatio` plugin argument are bypassed by the scheduler if the incoming Pod doesn't request them in the pod spec. ([#103169](https://github.com/kubernetes/kubernetes/pull/103169), [@Huang-Wei](https://github.com/Huang-Wei))
- Feat: change parittion style to GPT on Windows ([#101412](https://github.com/kubernetes/kubernetes/pull/101412), [@andyzhangx](https://github.com/andyzhangx)) [SIG Storage and Windows]
- Features gates `EndpointSliceProxying` & `WindowsEndpointSliceProxying` graduates to GA and are unconditionally enabled. Kube-proxy will use EndpointSlices for endpoint information. ([#103451](https://github.com/kubernetes/kubernetes/pull/103451), [@swetharepakula](https://github.com/swetharepakula))
- Fluentd: isolate logging resources in separate namespace `logging` ([#68004](https://github.com/kubernetes/kubernetes/pull/68004), [@saravanan30erd](https://github.com/saravanan30erd))
- For `kubeadm`: add `--validity-period` flag for `kubeadm kubeconfig user` command. ([#100907](https://github.com/kubernetes/kubernetes/pull/100907), [@SataQiu](https://github.com/SataQiu))
- Implement `minReadySeconds` for the `StatefulSets`. ([#101316](https://github.com/kubernetes/kubernetes/pull/101316), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Improve logging of `APIService` availability changes in kube-apiserver. ([#101420](https://github.com/kubernetes/kubernetes/pull/101420), [@sttts](https://github.com/sttts))
- Introduce a feature gate `DisableCloudProviders` allowing to disable cloud-provider initialization in KAPI, KCM and kubelet.
  `DisableCloudProviders` FeatureGate is currently in Alpha, which means is currently disabled by default. Once the FeatureGate moves to beta, in-tree cloud providers would be disabled by default, and a user won't be able to specify `--cloud-provider=<aws|openstack|azure|gcp|vsphere>` anymore to any of KCM, KAPI or kubelet. Only a '--cloud-provider=external' would be allowed. CCM would have to run out-of-tree with CSI. ([#100136](https://github.com/kubernetes/kubernetes/pull/100136), [@Danil-Grigorev](https://github.com/Danil-Grigorev))
- JSON logging format is no longer available by default in non-core Kubernetes Components and require owners to opt in. ([#102869](https://github.com/kubernetes/kubernetes/pull/102869), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Kube-apiserver: the alpha PodSecurity feature can be enabled by passing `--feature-gates=PodSecurity=true`, and enables controlling allowed pods using namespace labels. See https://git.k8s.io/enhancements/keps/sig-auth/2579-psp-replacement for more details. ([#103099](https://github.com/kubernetes/kubernetes/pull/103099), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth, Instrumentation, Release, Security and Testing]
- Kube-proxy uses V1 `EndpointSlices`. ([#103306](https://github.com/kubernetes/kubernetes/pull/103306), [@swetharepakula](https://github.com/swetharepakula))
- Kubeadm: Add the `RootlessControlPlane` kubeadm specific feature gate (Alpha in 1.22, disabled by default). It can be used to enable an experimental feature that makes the control plane component static Pod containers for `kube-apiserver`, `kube-controller-manager`, `kube-scheduler` and `etcd` to run as a non-root users. ([#102158](https://github.com/kubernetes/kubernetes/pull/102158), [@vinayakankugoyal](https://github.com/vinayakankugoyal))
- Kubeadm: Set the `seccompProfile` to `runtime/default` in the `PodSecurityContext` of the control-plane components that run as static Pods. ([#100234](https://github.com/kubernetes/kubernetes/pull/100234), [@vinayakankugoyal](https://github.com/vinayakankugoyal))
- Kubeadm: add a new field `skipPhases` to `v1beta3` `InitConfiguration` and `JoinConfiguration` that can contain a list of phases to skip during "kubeadm init" and "kubeadm join". The flag "--skip-phases" takes precedence over this field. ([#101923](https://github.com/kubernetes/kubernetes/pull/101923), [@neolit123](https://github.com/neolit123))
- Kubeadm: add the `--dry-run` flag to the `control-plane` phase of "kubeadm init". ([#102722](https://github.com/kubernetes/kubernetes/pull/102722), [@vinayakankugoyal](https://github.com/vinayakankugoyal))
- Kubeadm: add the `imagePullPolicy` field in the `nodeRegistration` section of `InitConfiguration` and `JoinConfiguration` in `v1beta3`. This allows the user to specify the image pull policy during "kubeadm init" and "kubeadm join". The value of this field must be one of `Always`, `IfNotPresent` or `Never`. The default behavior continues to be `IfNotPresent`. ([#102901](https://github.com/kubernetes/kubernetes/pull/102901), [@wangyysde](https://github.com/wangyysde))
- Kubeadm: during "kubeadm init/join/upgrade", always default the `cgroupDriver` value in the `KubeletConfiguration` to `systemd`, unless the user was explicit about the value. See [configure-cgroup-driver](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/) for more details. ([#102133](https://github.com/kubernetes/kubernetes/pull/102133), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: update `CoreDNS` to 1.8.4. Grant `CoreDNS` permissions to "list" and "watch" `EndpointSlice` objects to accommodate dual-stack support. ([#102466](https://github.com/kubernetes/kubernetes/pull/102466), [@pacoxu](https://github.com/pacoxu))
- Kubectl: add `LAST RESTART` column to `kubectl get pods` output. ([#100142](https://github.com/kubernetes/kubernetes/pull/100142), [@Ethyling](https://github.com/Ethyling))
- Kubemark's hollow-node will now print flags before starting. ([#101181](https://github.com/kubernetes/kubernetes/pull/101181), [@mm4tt](https://github.com/mm4tt))
- Kubernetes is now built with Golang 1.16.3 ([#101206](https://github.com/kubernetes/kubernetes/pull/101206), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.16.4 ([#101809](https://github.com/kubernetes/kubernetes/pull/101809), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.16.5. ([#102689](https://github.com/kubernetes/kubernetes/pull/102689), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Golang 1.16.6 ([#103669](https://github.com/kubernetes/kubernetes/pull/103669), [@cpanato](https://github.com/cpanato)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Leader Migration for controller managers graduated to beta. ([#103533](https://github.com/kubernetes/kubernetes/pull/103533), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery and Cloud Provider]
- Make kubectl command headers default for beta. ([#103238](https://github.com/kubernetes/kubernetes/pull/103238), [@seans3](https://github.com/seans3)) [SIG CLI]
- Mark `net.ipv4.ip_unprivileged_port_start` as safe `sysctl`. ([#103326](https://github.com/kubernetes/kubernetes/pull/103326), [@pacoxu](https://github.com/pacoxu))
- Metrics server nanny has now poll period set to 30s (previously 5 minutes) to allow faster scaling of metrics server. ([#101869](https://github.com/kubernetes/kubernetes/pull/101869), [@olagacek](https://github.com/olagacek)) [SIG Cloud Provider and Instrumentation]
- NetworkPolicy validation framework support for windows. ([#98077](https://github.com/kubernetes/kubernetes/pull/98077), [@jayunit100](https://github.com/jayunit100))
- New feature gate `ExpandedDNSConfig` is now available. This feature allows Kubernetes to have expanded DNS configuration. ([#100651](https://github.com/kubernetes/kubernetes/pull/100651), [@gjkim42](https://github.com/gjkim42))
- New metrics: `apiserver_kube_aggregator_x509_missing_san_total` and `apiserver_webhooks_x509_missing_san_total`. This metric measures a number of connections to webhooks/aggregated API servers that use certificates without Subject Alternative Names. It being non-zero is a warning sign that these connections will stop functioning in the future since Golang is going to deprecate x509 certificate subject Common Names for server hostname verification. ([#95396](https://github.com/kubernetes/kubernetes/pull/95396), [@stlaz](https://github.com/stlaz)) [SIG API Machinery, Auth and Instrumentation]
- Node Problem Detector is now available for GCE Windows nodes. ([#101539](https://github.com/kubernetes/kubernetes/pull/101539), [@jeremyje](https://github.com/jeremyje)) [SIG Cloud Provider, Node and Windows]
- Promote Cronjobs storage version to `batch/v1`. ([#102363](https://github.com/kubernetes/kubernetes/pull/102363), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Promote `CronJobControllerV2` flag to GA, with removal in 1.23. ([#102529](https://github.com/kubernetes/kubernetes/pull/102529), [@soltysh](https://github.com/soltysh))
- Promote `EndpointSliceTerminatingCondition` to Beta. This enables the `terminating` and `serving` conditions for EndpointSlice by default. ([#103596](https://github.com/kubernetes/kubernetes/pull/103596), [@andrewsykim](https://github.com/andrewsykim))
- Run etcd as non-root on GCE provider ([#100635](https://github.com/kubernetes/kubernetes/pull/100635), [@cindy52](https://github.com/cindy52))
- Scheduler nows provides an option for plugin developers to move `Pods` to activeQ. ([#103383](https://github.com/kubernetes/kubernetes/pull/103383), [@Huang-Wei](https://github.com/Huang-Wei))
- Secret values are now masked by default in `kubectl diff` output. ([#96084](https://github.com/kubernetes/kubernetes/pull/96084), [@loozhengyuan](https://github.com/loozhengyuan))
- Services with `externalTrafficPolicy: Local` now support graceful termination when using
  the iptables or ipvs mode of kube-proxy with `EndpointSlices` enabled. Specifically, if a
  connection for such a service arrives on a node when there are no "Ready" endpoints
  for the service, but there is at least one Terminating pod for that service on the node,
  then kube-proxy will send the traffic to the Terminating pod rather than dropping it. This
  patches up a race condition between when a pod is killed and when the external load
  balancer notices that it has been killed. ([#97238](https://github.com/kubernetes/kubernetes/pull/97238), [@andrewsykim](https://github.com/andrewsykim))
- Shell completion has been migrated to Cobra's go solution.  `kubectl` is now smarter about disabling file completion when it does not apply.  Furthermore, completion for the `cp` command does not show all files unless the user has started typing something. ([#96087](https://github.com/kubernetes/kubernetes/pull/96087), [@marckhouzam](https://github.com/marckhouzam)) [SIG CLI]
- Some of the in-tree storage drivers indicate support for the `MetricsProvider` interface, but fail to configure this for BlockMode volumes. With a recent change, `Kubelet` will call `GetMetrics()` for BlockMode volumes, and the in-tree drivers that miss the support cause a Go panic. Now the in-tree storage drivers that support BlockMode volumes, will return the Capacity of the volume in the `GetMetrics()` call. ([#101587](https://github.com/kubernetes/kubernetes/pull/101587), [@nixpanic](https://github.com/nixpanic))
- Support `FakeClientset` match subresource. ([#100939](https://github.com/kubernetes/kubernetes/pull/100939), [@wzshiming](https://github.com/wzshiming))
- The "Leader Migration" now support a wildcard component name and the default value. ([#102711](https://github.com/kubernetes/kubernetes/pull/102711), [@jiahuif](https://github.com/jiahuif))
- The CSI driver supports the NodeServiceCapability `VOLUME_MOUNT_GROUP` and the `DelegateFSGroupToCSIDriver` feature gate is enabled, kubelet will delegate applying FSGroup to the driver by passing it to `NodeStageVolume` and `NodePublishVolume`, regardless of what other `FSGroup` policies are set, this is an alpha feature. ([#103244](https://github.com/kubernetes/kubernetes/pull/103244), [@verult](https://github.com/verult))
- The Memory Manager feature graduates to Beta and it is enabled by default. ([#101947](https://github.com/kubernetes/kubernetes/pull/101947), [@cynepco3hahue](https://github.com/cynepco3hahue))
- The `BoundServiceAccountTokenVolume` graduates to GA and thus will be unconditionally enabled. The feature gate is going to be removed in 1.23. ([#101992](https://github.com/kubernetes/kubernetes/pull/101992), [@zshihang](https://github.com/zshihang))
- The `EmptyDir` memory backed volumes are sized as the the minimum of pod allocatable memory on a host and an optional explicit user provided value. ([#101048](https://github.com/kubernetes/kubernetes/pull/101048), [@dims](https://github.com/dims))
- The `HugePageStorageMediumSize` feature graduates to GA and unconditionally enabled. Allowing unconditional usage of multiple sizes huge page resources on a container level. ([#99144](https://github.com/kubernetes/kubernetes/pull/99144), [@bart0sh](https://github.com/bart0sh))
- The `IngressClassNamespacedParams` feature gate has graduated to beta and is enabled by default. This means IngressClass resource will now have two new fields - `spec.paramters.namespace` and `spec.parameters.scope`. ([#101711](https://github.com/kubernetes/kubernetes/pull/101711), [@hbagdi](https://github.com/hbagdi))
- The `LogarithmicScaleDown` feature graduates to Beta and enabled by default. ([#101767](https://github.com/kubernetes/kubernetes/pull/101767), [@damemi](https://github.com/damemi))
- The `NamespaceDefaultLabelName` is promoted to GA in this release. All Namespace API objects have a `kubernetes.io/metadata.name` label matching their `metadata.name` field to allow selecting any `namespace` by its name using a label selector. ([#101342](https://github.com/kubernetes/kubernetes/pull/101342), [@rosenhouse](https://github.com/rosenhouse))
- The `ServiceInternalTrafficPolicy` feature graduates to Beta and enable by default, which enables the `internalTrafficPolicy` field of Service by default. ([#103462](https://github.com/kubernetes/kubernetes/pull/103462), [@andrewsykim](https://github.com/andrewsykim))
- The `ServiceLBNodePortControl` graduates to Beta and is enabled by default. ([#100412](https://github.com/kubernetes/kubernetes/pull/100412), [@hanlins](https://github.com/hanlins))
- The `SetHostnameAsFQDN` graduates to GA and thus will be unconditionally disabled. ([#101294](https://github.com/kubernetes/kubernetes/pull/101294), [@javidiaz](https://github.com/javidiaz))
- The `WarningHeader` feature is now GA and is unconditionally enabled. The `apiserver_requested_deprecated_apis` metric has graduated to stable status. The `WarningHeader` feature-gate is no longer operative and will be removed in v1.24. ([#100754](https://github.com/kubernetes/kubernetes/pull/100754), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Instrumentation and Testing]
- The `kubectl debug` is able to create ephemeral containers in pre-1.22 clusters with the `EphemeralContainers` feature enabled. Note that versions of kubectl prior to 1.22 are unable to create ephemeral containers in clusters version 1.22 and greater due to an API change. ([#103292](https://github.com/kubernetes/kubernetes/pull/103292), [@verb](https://github.com/verb))
- The client-go credential plugins are now GA and are enabled by default. ([#102890](https://github.com/kubernetes/kubernetes/pull/102890), [@ankeesler](https://github.com/ankeesler))
- The feature gate `SSA` graduated to GA in v1.22 and therefore is unconditionally enabled. ([#100139](https://github.com/kubernetes/kubernetes/pull/100139), [@Jefftree](https://github.com/Jefftree))
- The job controller removes running pods when the number of completions is achieved. ([#99963](https://github.com/kubernetes/kubernetes/pull/99963), [@alculquicondor](https://github.com/alculquicondor))
- The kubeconfig is now exposed in `the kube-scheduler` framework handle. Out-of-tree plugins can leverage that to build CRD informers easily. ([#100644](https://github.com/kubernetes/kubernetes/pull/100644), [@Huang-Wei](https://github.com/Huang-Wei))
- The new flag `--chunk-size=SIZE` for `kubectl drain` has been promoted to beta, and enabled by default. This flag  may be used to alter the number of items or disable this feature when `0` is passed. ([#100148](https://github.com/kubernetes/kubernetes/pull/100148), [@KnVerey](https://github.com/KnVerey))
- The new flag `--chunk-size=SIZE` has been added to `kubectl describe`. This flag may be used to alter the number of items or disable this feature when `0` is passed. ([#101171](https://github.com/kubernetes/kubernetes/pull/101171), [@KnVerey](https://github.com/KnVerey))
- The pod resource API will provide memory manager metrics in the case when the memory manager feature gate is enabled, and the memory manager policy is static. ([#101030](https://github.com/kubernetes/kubernetes/pull/101030), [@cynepco3hahue](https://github.com/cynepco3hahue))
- The prefer nominated node graduates to Beta and enabld by default. ([#102201](https://github.com/kubernetes/kubernetes/pull/102201), [@chendave](https://github.com/chendave))
- Update etcd version to 3.5.0-beta.3. ([#102062](https://github.com/kubernetes/kubernetes/pull/102062), [@serathius](https://github.com/serathius))
- Update the Debian images to pick up CVE fixes in the base images:
  - Update the `debian-base` image to v1.7.0
  - Update the `debian-iptables` image to v1.6.1 ([#102302](https://github.com/kubernetes/kubernetes/pull/102302), [@xmudrii](https://github.com/xmudrii))
- Update the setcap image to buster-v2.0.1. ([#102377](https://github.com/kubernetes/kubernetes/pull/102377), [@xmudrii](https://github.com/xmudrii))
- Update the system-validators library to v1.5.0. Includes validation for `seccomp` and fixes a stdout/stderr problem in the Docker validator. ([#103390](https://github.com/kubernetes/kubernetes/pull/103390), [@ironyman](https://github.com/ironyman))
- Updates the following images to pick up CVE fixes:
  - `debian` to v1.8.0
  - `debian-iptables` to v1.6.5
  - `setcap` to v2.0.3 ([#103235](https://github.com/kubernetes/kubernetes/pull/103235), [@thejoycekung](https://github.com/thejoycekung)) [SIG API Machinery, Release and Testing]
- Warnings for the use of deprecated and known-bad values in pod specs are now sent. ([#101688](https://github.com/kubernetes/kubernetes/pull/101688), [@liggitt](https://github.com/liggitt))
- Watch requests are now handled throttled by priority and fairness filter in `kube-apiserver`. ([#102171](https://github.com/kubernetes/kubernetes/pull/102171), [@wojtek-t](https://github.com/wojtek-t))
- You can use this Builder function to create events Field Selector ([#101817](https://github.com/kubernetes/kubernetes/pull/101817), [@cndoit18](https://github.com/cndoit18)) [SIG API Machinery and Scalability]
- `Scheduler` now registers event handlers dynamically. ([#101394](https://github.com/kubernetes/kubernetes/pull/101394), [@Huang-Wei](https://github.com/Huang-Wei))
- `kubectl`: Enable using protocol buffers to request Metrics API. ([#102039](https://github.com/kubernetes/kubernetes/pull/102039), [@serathius](https://github.com/serathius))

### Documentation

- The command`kubectl debug` will now print a warning message when using the `--target` option since many container runtimes do not support this yet. ([#101074](https://github.com/kubernetes/kubernetes/pull/101074), [@verb](https://github.com/verb))

### Failing Test

- Fixed generic ephemeal volumes with `OwnerReferencesPermissionEnforcement` admission plugin enabled. ([#101186](https://github.com/kubernetes/kubernetes/pull/101186), [@jsafrane](https://github.com/jsafrane))
- Fixes `kubectl drain --dry-run=server`. ([#100206](https://github.com/kubernetes/kubernetes/pull/100206), [@KnVerey](https://github.com/KnVerey))
- Fixes an overly restrictive conformance test to accept service account tokens signed by an ECDSA key ([#100680](https://github.com/kubernetes/kubernetes/pull/100680), [@smira](https://github.com/smira)) [SIG Architecture, Auth and Testing]
- Fixes the `should receive events on concurrent watches in same order` conformance test to work properly on clusters that auto-create additional configmaps in namespaces. ([#101950](https://github.com/kubernetes/kubernetes/pull/101950), [@liggitt](https://github.com/liggitt))
- Resolves an issue with the "ServiceAccountIssuerDiscovery should support OIDC discovery" conformance test failing on clusters which are configured with issuers outside the cluster ([#101589](https://github.com/kubernetes/kubernetes/pull/101589), [@mtaufen](https://github.com/mtaufen)) [SIG Auth and Testing]

### Bug or Regression

- Added jitter factor to lease controller that better smears load on kube-apiserver over time. ([#101652](https://github.com/kubernetes/kubernetes/pull/101652), [@marseel](https://github.com/marseel)) [SIG API Machinery and Scalability]
- Added privileges for `EndpointSlice` to the default view & edit RBAC roles. ([#101203](https://github.com/kubernetes/kubernetes/pull/101203), [@mtougeron](https://github.com/mtougeron))
- After DBus restarts, make `GracefulNodeShutdown` work again ([#100369](https://github.com/kubernetes/kubernetes/pull/100369), [@wzshiming](https://github.com/wzshiming))
- Aggregate errors when putting vmss. ([#98350](https://github.com/kubernetes/kubernetes/pull/98350), [@nilo19](https://github.com/nilo19))
- Aggregate write permissions on events to users with edit and admin role. ([#102858](https://github.com/kubernetes/kubernetes/pull/102858), [@tumido](https://github.com/tumido))
- Aggregated roles no longer include write access to `EndpointSlices`. This rolls back part of a change that was introduced earlier in the Kubernetes 1.22 cycle. ([#103703](https://github.com/kubernetes/kubernetes/pull/103703), [@robscott](https://github.com/robscott))
- Applying fix for not deleting existing public IP when a service is deleted in Azure. ([#100694](https://github.com/kubernetes/kubernetes/pull/100694), [@nilo19](https://github.com/nilo19))
- Applying fix for not tagging static public IP. ([#101752](https://github.com/kubernetes/kubernetes/pull/101752), [@nilo19](https://github.com/nilo19))
- Applying fix so that deleting non-existing disk returns success. ([#102083](https://github.com/kubernetes/kubernetes/pull/102083), [@andyzhangx](https://github.com/andyzhangx))
- Applying fix: cleanup outdated routes. ([#102935](https://github.com/kubernetes/kubernetes/pull/102935), [@nilo19](https://github.com/nilo19))
- Avoid caching the Azure VMSS instances whose network profile is nil ([#100948](https://github.com/kubernetes/kubernetes/pull/100948), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Azure: Avoid setting cached Sku when updating VMSS and VMSS instances. ([#102005](https://github.com/kubernetes/kubernetes/pull/102005), [@feiskyer](https://github.com/feiskyer))
- Azurefile: Normalize share name to not include the capital letters ([#100731](https://github.com/kubernetes/kubernetes/pull/100731), [@kassarl](https://github.com/kassarl))
- Chain the field manager creation calls in `newDefaultFieldManager` to be explicit about the order of operations. ([#101076](https://github.com/kubernetes/kubernetes/pull/101076), [@kevindelgado](https://github.com/kevindelgado))
- Disruption controller shouldn't error while syncing for unmanaged pods. ([#103414](https://github.com/kubernetes/kubernetes/pull/103414), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps and Testing]
- Ensure service is deleted when the Azure resource group has been deleted. ([#100944](https://github.com/kubernetes/kubernetes/pull/100944), [@feiskyer](https://github.com/feiskyer))
- Ensures `ExecProbeTimeout=false` kubelet feature gate with dockershim is taken into account, when the exec probe takes longer than `timeoutSeconds` configuration. ([#100200](https://github.com/kubernetes/kubernetes/pull/100200), [@jackfrancis](https://github.com/jackfrancis))
- Expose `rest_client_rate_limiter_duration_seconds` metric to component-base to track client side rate limiter latency in seconds. Broken down by verb and URL. ([#100311](https://github.com/kubernetes/kubernetes/pull/100311), [@IonutBajescu](https://github.com/IonutBajescu)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Fire an event when failing to open `NodePort`. ([#100599](https://github.com/kubernetes/kubernetes/pull/100599), [@masap](https://github.com/masap))
- Fix Azure node public IP fetching issues from instance metadata service when the node is part of standard load balancer backend pool. ([#100690](https://github.com/kubernetes/kubernetes/pull/100690), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix `EndpointSlice` describe panic when an Endpoint doesn't have zone. ([#101025](https://github.com/kubernetes/kubernetes/pull/101025), [@tnqn](https://github.com/tnqn))
- Fix `kubectl set env` or `resources` not working for initcontainers. ([#101669](https://github.com/kubernetes/kubernetes/pull/101669), [@carlory](https://github.com/carlory))
- Fix `kubectl` alpha debug node does not work on tainted(NoExecute) nodes and tolerate everything. ([#98431](https://github.com/kubernetes/kubernetes/pull/98431), [@wawa0210](https://github.com/wawa0210))
- Fix a bug on the `endpointslicemirroring` controller where endpoint `NotReadyAddresses` were mirrored as Ready to the corresponding `EndpointSlice`. ([#102683](https://github.com/kubernetes/kubernetes/pull/102683), [@aojea](https://github.com/aojea))
- Fix a bug that a preemptor pod may exist as a phantom in the scheduler. ([#102498](https://github.com/kubernetes/kubernetes/pull/102498), [@Huang-Wei](https://github.com/Huang-Wei))
- Fix a number of race conditions in the kubelet when pods are starting up or shutting down that might cause pods to take a long time to shut down. ([#102344](https://github.com/kubernetes/kubernetes/pull/102344), [@smarterclayton](https://github.com/smarterclayton)) [SIG Apps, Node, Storage and Testing]
- Fix an issue with `kubectl` on certain older version of Windows or when legacy console mode is enabled on Windows 8 which causes `kubectl exec` to crash. ([#102825](https://github.com/kubernetes/kubernetes/pull/102825), [@n4j](https://github.com/n4j))
- Fix availability set cache in vmss cache ([#100110](https://github.com/kubernetes/kubernetes/pull/100110), [@CecileRobertMichon](https://github.com/CecileRobertMichon)) [SIG Cloud Provider]
- Fix how nulls are handled in array and objects in [json patches](https://github.com/evanphx/json-patch). ([#102467](https://github.com/kubernetes/kubernetes/pull/102467), [@pacoxu](https://github.com/pacoxu))
- Fix panic when `kubectl create ingress` has annotation flag and an empty value set. ([#101377](https://github.com/kubernetes/kubernetes/pull/101377), [@rikatz](https://github.com/rikatz))
- Fix performance regression for update and apply operations on large CRDs. ([#103318](https://github.com/kubernetes/kubernetes/pull/103318), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Fix raw block mode CSI `NodePublishVolume` stage miss pod info. ([#99069](https://github.com/kubernetes/kubernetes/pull/99069), [@phantooom](https://github.com/phantooom))
- Fix resource enforcement when using systemd cgroup driver ([#102147](https://github.com/kubernetes/kubernetes/pull/102147), [@kolyshkin](https://github.com/kolyshkin))
- Fix rounding of volume storage requests. ([#100100](https://github.com/kubernetes/kubernetes/pull/100100), [@maxlaverse](https://github.com/maxlaverse))
- Fix runtime container status for `PostStart` hook error. ([#100608](https://github.com/kubernetes/kubernetes/pull/100608), [@pacoxu](https://github.com/pacoxu))
- Fix scoring for `NodeResourcesMostAllocated` and `NodeResourcesBalancedAllocation` plugins when nodes have containers with no requests. This was leaving to under-utilization of small nodes. ([#102925](https://github.com/kubernetes/kubernetes/pull/102925), [@alculquicondor](https://github.com/alculquicondor))
- Fix the code is leaking the defaulting between unrelated pod instances. ([#103284](https://github.com/kubernetes/kubernetes/pull/103284), [@kebe7jun](https://github.com/kebe7jun)) [SIG CLI]
- Fix winkernel kube-proxy to only use dual stack when host and networking supports it ([#101047](https://github.com/kubernetes/kubernetes/pull/101047), [@jsturtevant](https://github.com/jsturtevant)) [SIG Network and Windows]
- Fix: Azure file inline volume namespace issue in CSI migration translation ([#101235](https://github.com/kubernetes/kubernetes/pull/101235), [@andyzhangx](https://github.com/andyzhangx))
- Fix: Bug in `kube-proxy` latency metrics to calculate only the latency value for the `Endpoints` that are created after it starts running. This is needed because all the `Endpoints` objects are processed on restarts, independently when they were. ([#100861](https://github.com/kubernetes/kubernetes/pull/100861), [@aojea](https://github.com/aojea))
- Fix: avoid nil-pointer panic when checking the frontend IP configuration ([#101739](https://github.com/kubernetes/kubernetes/pull/101739), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: display of Job completion mode in `kubectl describe`. ([#101160](https://github.com/kubernetes/kubernetes/pull/101160), [@alculquicondor](https://github.com/alculquicondor))
- Fix: return empty VMAS name if using standalone VM ([#103470](https://github.com/kubernetes/kubernetes/pull/103470), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: set "host is down" as corrupted mount. When SMB server is down, there is no way to terminate pod which is using SMB mount, would get an error. ([#101398](https://github.com/kubernetes/kubernetes/pull/101398), [@andyzhangx](https://github.com/andyzhangx))
- Fix: using NVMe AWS EBS volumes partitions. ([#100500](https://github.com/kubernetes/kubernetes/pull/100500), [@jsafrane](https://github.com/jsafrane))
- Fixed 'kubelet' runtime panic for timed-out portforward streams. ([#102489](https://github.com/kubernetes/kubernetes/pull/102489), [@saschagrunert](https://github.com/saschagrunert))
- Fixed SELinux relabeling of CSI volumes after CSI driver failure. ([#103154](https://github.com/kubernetes/kubernetes/pull/103154), [@jsafrane](https://github.com/jsafrane)) [SIG Node and Storage]
- Fixed `garbage collection` of dangling `VolumeAttachments` for `PersistentVolumes` migrated to CSI on startup of `kube-controller-manager`. ([#102176](https://github.com/kubernetes/kubernetes/pull/102176), [@timebertt](https://github.com/timebertt))
- Fixed `port-forward` memory leak for long-running and heavily used connections. ([#99839](https://github.com/kubernetes/kubernetes/pull/99839), [@saschagrunert](https://github.com/saschagrunert))
- Fixed a bug due to which the controller was not populating the `lastSuccessfulTime` field added to `cronjob.status` in `batch/v1`. ([#102642](https://github.com/kubernetes/kubernetes/pull/102642), [@alaypatel07](https://github.com/alaypatel07))
- Fixed a bug that `kubectl create configmap` always returns zero exit code when failed. ([#101780](https://github.com/kubernetes/kubernetes/pull/101780), [@nak3](https://github.com/nak3)) [SIG CLI]
- Fixed a bug that scheduler extenders are not called on preemptions. ([#103019](https://github.com/kubernetes/kubernetes/pull/103019), [@ordovicia](https://github.com/ordovicia))
- Fixed a bug where `startupProbe` stopped working after a container's first restart. ([#101093](https://github.com/kubernetes/kubernetes/pull/101093), [@wzshiming](https://github.com/wzshiming))
- Fixed an issue blocking azure auth to prompt to device code authentication flow when refresh token expires. ([#102063](https://github.com/kubernetes/kubernetes/pull/102063), [@tdihp](https://github.com/tdihp))
- Fixed false-positive uncertain volume attachments, which led to unexpected detachment of CSI migrated volumes ([#101737](https://github.com/kubernetes/kubernetes/pull/101737), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Apps and Storage]
- Fixed mounting of NFS volumes when IPv6 address is used as a server. ([#101067](https://github.com/kubernetes/kubernetes/pull/101067), [@Elbehery](https://github.com/Elbehery)) [SIG Storage]
- Fixed starting new pods after previous pod timed out unmounting its volumes. ([#100183](https://github.com/kubernetes/kubernetes/pull/100183), [@jsafrane](https://github.com/jsafrane))
- Fixed very rare volume corruption when a pod is deleted while kubelet is offline. ([#102059](https://github.com/kubernetes/kubernetes/pull/102059), [@jsafrane](https://github.com/jsafrane))
- Fixes a data race issue in the priority and fairness API server filter. ([#100638](https://github.com/kubernetes/kubernetes/pull/100638), [@tkashem](https://github.com/tkashem))
- Fixes issue with websocket-based watches of Service objects not closing correctly on timeout. ([#102539](https://github.com/kubernetes/kubernetes/pull/102539), [@liggitt](https://github.com/liggitt))
- For `kubeadm`: support for custom imagetags for etcd images which contain build metadata, when imagetags are in the form of version_metadata. For instance, if the etcd version is v3.4.13+patch.0, the supported imagetag would be v3.4.13_patch.0 ([#100350](https://github.com/kubernetes/kubernetes/pull/100350), [@jr0d](https://github.com/jr0d))
- For vSphere: fix regression during attach disk if datastore is within a storage folder or datastore cluster. ([#102892](https://github.com/kubernetes/kubernetes/pull/102892), [@gnufied](https://github.com/gnufied))
- GCE Windows clusters have their TCP/IP parameters are set to GCE's recommended values. ([#103057](https://github.com/kubernetes/kubernetes/pull/103057), [@jeremyje](https://github.com/jeremyje)) [SIG Cloud Provider and Windows]
- GCE Windows will no longer install Docker on containerd nodes. ([#101747](https://github.com/kubernetes/kubernetes/pull/101747), [@jeremyje](https://github.com/jeremyje)) [SIG Cloud Provider and Windows]
- Generated OpenAPI now correctly specifies 201 as a possible response code for PATCH operations. ([#100141](https://github.com/kubernetes/kubernetes/pull/100141), [@brendandburns](https://github.com/brendandburns))
- Graceful termination will now be honored when deleting a collection of pods. ([#100101](https://github.com/kubernetes/kubernetes/pull/100101), [@deads2k](https://github.com/deads2k))
- If `kube-proxy` mode  is userspace do not enable `EndpointSlices`. ([#100913](https://github.com/kubernetes/kubernetes/pull/100913), [@JornShen](https://github.com/JornShen))
- Kubeadm: allow passing the flag `--log-file` if `--config` is passed. If you wish to log to a file you must also pass `--logtostderr=false` or `--alsologtostderr=true`. Alternatively you can pipe to a file using "kubeadm ... | tee ...". ([#101449](https://github.com/kubernetes/kubernetes/pull/101449), [@CaoDonghui123](https://github.com/CaoDonghui123))
- Kubeadm: enable `--experimental-patches` flag for `kubeadm join phase control-plane-join all` command. ([#101110](https://github.com/kubernetes/kubernetes/pull/101110), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: fix a bug where `kubeadm join` for control plane nodes would download certificates and keys from the cluster, but would not write publicly readable certificates and public keys with mode `0644` and instead use mode `0600`. ([#103313](https://github.com/kubernetes/kubernetes/pull/103313), [@neolit123](https://github.com/neolit123))
- Kubeadm: fix the bug that `kubeadm` only uses the first hash in `caCertHashes` to verify the root CA. ([#101977](https://github.com/kubernetes/kubernetes/pull/101977), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: remove the "ephemeral_storage" request from the etcd static pod that kubeadm deploys on stacked etcd control plane nodes. This request has caused sporadic failures on some setups due to a problem in the kubelet with cadvisor and the LocalStorageCapacityIsolation feature gate. See this issue for more details: https://github.com/kubernetes/kubernetes/issues/99305 ([#102673](https://github.com/kubernetes/kubernetes/pull/102673), [@jackfrancis](https://github.com/jackfrancis)) [SIG Cluster Lifecycle]
- Kubeadm: when using a custom image repository for CoreDNS kubeadm now will append the `coredns` image name instead of `coredns/coredns`, thus restoring the behaviour existing before the v1.21 release. Users who rely on nested folder for the coredns image should set the `clusterConfiguration.dns.imageRepository` value including the nested path name (e.g using `registry.company.xyz/coredns` will force kubeadm to use `registry.company.xyz/coredns/coredns` image). No action is needed if using the default registry (k8s.gcr.io). ([#102502](https://github.com/kubernetes/kubernetes/pull/102502), [@ykakarap](https://github.com/ykakarap))
- Kubelet: improve the performance when waiting for a synchronization of the node list with the `kube-apiserver`. ([#99336](https://github.com/kubernetes/kubernetes/pull/99336), [@neolit123](https://github.com/neolit123))
- Kubelet: the returned value for PodIPs is the same in the Downward API and in the `pod.status.PodIPs` field ([#103307](https://github.com/kubernetes/kubernetes/pull/103307), [@aojea](https://github.com/aojea))
- Limit vSphere volume name to 63 characters long. ([#100404](https://github.com/kubernetes/kubernetes/pull/100404), [@gnufied](https://github.com/gnufied))
- Logging for GCE Windows clusters will be more accurate and complete when using Fluent bit. ([#101271](https://github.com/kubernetes/kubernetes/pull/101271), [@jeremyje](https://github.com/jeremyje))
- Metrics Server will use Addon Manager 1.8.3 ([#103541](https://github.com/kubernetes/kubernetes/pull/103541), [@jbartosik](https://github.com/jbartosik)) [SIG Cloud Provider and Instrumentation]
- Output for `kubectl describe podsecuritypolicy` is now kind specific and cleaner ([#101436](https://github.com/kubernetes/kubernetes/pull/101436), [@KnVerey](https://github.com/KnVerey))
- Parsing of cpuset information now properly detects more invalid input such as `1--3` or `10-6`. ([#100565](https://github.com/kubernetes/kubernetes/pull/100565), [@lack](https://github.com/lack))
- Pods that are known to the kubelet to have previously been Running should not revert to Pending state, the kubelet will now infer a termination. ([#102821](https://github.com/kubernetes/kubernetes/pull/102821), [@ehashman](https://github.com/ehashman))
- Prevent Kubelet stuck in `DiskPressure` when `imagefs.minReclaim` is set ([#99095](https://github.com/kubernetes/kubernetes/pull/99095), [@maxlaverse](https://github.com/maxlaverse))
- Reduces delay initializing on non-AWS platforms docker runtime. ([#93260](https://github.com/kubernetes/kubernetes/pull/93260), [@nckturner](https://github.com/nckturner)) [SIG Cloud Provider]
- Register/Deregister Targets in chunks for AWS TargetGroup ([#101592](https://github.com/kubernetes/kubernetes/pull/101592), [@M00nF1sh](https://github.com/M00nF1sh)) [SIG Cloud Provider]
- Removed `/sbin/apparmor_parser` requirement for the AppArmor host validation.
  This allows using AppArmor on distributions which ship the binary in a different path. ([#97968](https://github.com/kubernetes/kubernetes/pull/97968), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node and Testing]
- Renames the timeout field for the `DelegatingAuthenticationOptions` to `TokenRequestTimeout` and set the timeout only for the token review client. Previously the timeout was also applied to watches making them reconnecting every 10 seconds. ([#100959](https://github.com/kubernetes/kubernetes/pull/100959), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Reorganized iptables rules to reduce rules in `KUBE-SERVICES` and `KUBE-NODEPORTS`. ([#96959](https://github.com/kubernetes/kubernetes/pull/96959), [@tssurya](https://github.com/tssurya))
- Respect annotation size limit for server-side apply updates to the client-side apply annotation. Also, fix opt-out of this behavior by setting the client-side apply annotation to the empty string. ([#102105](https://github.com/kubernetes/kubernetes/pull/102105), [@julianvmodesto](https://github.com/julianvmodesto)) [SIG API Machinery]
- Retry `FibreChannel` devices cleanup after error to ensure `FibreChannel` device is detached before it can be used on another node. ([#101862](https://github.com/kubernetes/kubernetes/pull/101862), [@jsafrane](https://github.com/jsafrane))
- Support correct sorting for cpu, memory, storage, ephemeral-storage, hugepages, and attachable-volumes. ([#100435](https://github.com/kubernetes/kubernetes/pull/100435), [@lauchokyip](https://github.com/lauchokyip))
- Switch scheduler to generate the merge patch on pod status instead of the full pod ([#103133](https://github.com/kubernetes/kubernetes/pull/103133), [@marwanad](https://github.com/marwanad)) [SIG Scheduling]
- The `EndpointSlice` IP validation now matches `Endpoints` IP validation. ([#101084](https://github.com/kubernetes/kubernetes/pull/101084), [@robscott](https://github.com/robscott))
- The `kube-apiserver` now reports the synthetic verb when logging requests, better explaining the user intent and matching what is reported in the metrics. ([#102934](https://github.com/kubernetes/kubernetes/pull/102934), [@lavalamp](https://github.com/lavalamp))
- The `kube-controller-manager'` sets the upper-bound timeout limit for outgoing requests to 70s. Previously ([#99358](https://github.com/kubernetes/kubernetes/pull/99358), [@p0lyn0mial](https://github.com/p0lyn0mial))
- The `kube-proxy` log now shows the "Skipping topology aware endpoint filtering since no hints were provided for zone" warning under the right conditions. ([#101857](https://github.com/kubernetes/kubernetes/pull/101857), [@dervoeti](https://github.com/dervoeti))
- The `kubectl create service` now respects the `namespace` flag. ([#101005](https://github.com/kubernetes/kubernetes/pull/101005), [@zxh326](https://github.com/zxh326))
- The `kubectl get` now truncates multi-line strings to avoid breaking printing ([#103514](https://github.com/kubernetes/kubernetes/pull/103514), [@soltysh](https://github.com/soltysh))
- The `kubectl wait --for=delete` command now ignores the not found error correctly. ([#96702](https://github.com/kubernetes/kubernetes/pull/96702), [@lingsamuel](https://github.com/lingsamuel))
- The `kubelet` now reports distinguishes log messages about certificate rotation for its client cert and server cert separately to make debugging problems with one or the other easier. ([#101252](https://github.com/kubernetes/kubernetes/pull/101252), [@smarterclayton](https://github.com/smarterclayton))
- The `serviceOwnsFrontendIP` shouldn't report error when the public IP doesn't match. ([#102516](https://github.com/kubernetes/kubernetes/pull/102516), [@nilo19](https://github.com/nilo19))
- The `system:aggregate-to-edit` role no longer includes write access to the Endpoints API. For new Kubernetes 1.22 clusters, the `edit` and `admin` roles will no longer include that access in newly created Kubernetes 1.22 clusters. This will have no affect on existing clusters upgrading to Kubernetes 1.22. To retain write access to Endpoints in the aggregated `edit` and `admin` roles for newly created 1.22 clusters, refer to https://github.com/kubernetes/website/pull/29025. ([#103704](https://github.com/kubernetes/kubernetes/pull/103704), [@robscott](https://github.com/robscott)) [SIG Auth and Network]
- The conformance tests:
  - Services should serve multiport endpoints from pods
  - Services should serve a basic endpoint from pods
  were only validating the API objects, not performing any validation on the actual Services implementation.
  Those tests now validate that the Services under test are able to forward traffic to the endpoints. ([#101709](https://github.com/kubernetes/kubernetes/pull/101709), [@aojea](https://github.com/aojea)) [SIG Network and Testing]
- The current behavior for Services that `IPFamilyPolicy` set as `PreferDualstack`. The current behavior when the cluster is upgraded to dual-stack is:
  - Services that have been set to IPFamilyPolicy = PreferDualstack will be upgraded when the service object is updated. e.g., when a user change a label.
  
  This behavior will change to:
  - Services that have been set  IPFamilyPolicy = PreferDualstack will not be upgraded when the service object is updated. User can still change policy, type etc and existing behaviors remain the same. ([#102898](https://github.com/kubernetes/kubernetes/pull/102898), [@khenidak](https://github.com/khenidak)) [SIG Network and Testing]
- The reason and message fields for pod status are no longer reset unless the phase also changes. ([#103785](https://github.com/kubernetes/kubernetes/pull/103785), [@smarterclayton](https://github.com/smarterclayton)) [SIG Node]
- Treat VSphere "File (vmdk path here) was not found" errors as success during volume deletion ([#92372](https://github.com/kubernetes/kubernetes/pull/92372), [@breunigs](https://github.com/breunigs)) [SIG Cloud Provider and Storage]
- Update `kube-proxy` base image `debian-iptables` to v1.6.2 to pickup [documentation](https://github.com/kubernetes/release/pull/2106)
  \n"- `debian-iptables`: select nft mode if ntf lines > legacy lines, matching [iptables-wrappers](https://github.com/kubernetes-sigs/iptables-wrappers/)" ([#102590](https://github.com/kubernetes/kubernetes/pull/102590), [@BenTheElder](https://github.com/BenTheElder))
- Update klog v2.9.0. ([#102332](https://github.com/kubernetes/kubernetes/pull/102332), [@pacoxu](https://github.com/pacoxu))
- Updated the Graceful Node Shutdown Pod termination reason and message.
  Updated the Graceful Node Shutdown Pod rejection reason and message. ([#102840](https://github.com/kubernetes/kubernetes/pull/102840), [@Kissy](https://github.com/Kissy))
- Updates dependency `sigs.k8s.io/structured-merge-diff` to v4.1.1. ([#100784](https://github.com/kubernetes/kubernetes/pull/100784), [@kevindelgado](https://github.com/kevindelgado))
- Updates hostprocess tests to specify user. ([#102965](https://github.com/kubernetes/kubernetes/pull/102965), [@jsturtevant](https://github.com/jsturtevant))
- Upgrades functionality of `kubectl kustomize` as described at
  https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.2.0 ([#103419](https://github.com/kubernetes/kubernetes/pull/103419), [@natasha41575](https://github.com/natasha41575)) [SIG CLI]
- Upgrades functionality of `kubectl kustomize` as described at [kustomize/v4.1.2](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.1.2) ([#101120](https://github.com/kubernetes/kubernetes/pull/101120), [@monopole](https://github.com/monopole))
- Upgrading etcd: `kubeadm` upgrade etcd to 3.4.13-3 ([#100612](https://github.com/kubernetes/kubernetes/pull/100612), [@pacoxu](https://github.com/pacoxu))
- Use default timeout of 10s for Azure ACR credential provider. ([#100686](https://github.com/kubernetes/kubernetes/pull/100686), [@hasheddan](https://github.com/hasheddan)) [SIG Cloud Provider]
- We no longer allow the cluster operator to delete any suggested priority & fairness bootstrap configuration object. If a cluster operator removes a suggested configuration, it will be restored by the apiserver. ([#102067](https://github.com/kubernetes/kubernetes/pull/102067), [@tkashem](https://github.com/tkashem))
- When `DisableAcceleratorUsageMetrics` is set, do not collect accelerator metrics using cAdvisor. ([#101712](https://github.com/kubernetes/kubernetes/pull/101712), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Instrumentation and Node]
- YAML documents separators ("---") can now be followed by whitespace and comments ("# ....") on the same line. This fixes a bug where documents starting with a comment after the separator were ignored. Other types of content on the same line will result in an error. ([#103457](https://github.com/kubernetes/kubernetes/pull/103457), [@codearky](https://github.com/codearky)) [SIG API Machinery]
- `oc describe quota` used has the same unit format as hard ([#102177](https://github.com/kubernetes/kubernetes/pull/102177), [@atiratree](https://github.com/atiratree)) [SIG CLI]

### Other (Cleanup or Flake)

- After the deprecation period,now the Kubelet's  `--chaos-chance` flag  are removed. ([#101057](https://github.com/kubernetes/kubernetes/pull/101057), [@wangyysde](https://github.com/wangyysde)) [SIG Node]
- Allow CSI drivers to just run offline expansion tests. ([#102665](https://github.com/kubernetes/kubernetes/pull/102665), [@gnufied](https://github.com/gnufied))
- Changed buildmode of non static Kubernetes binaries to produce position independent executables (PIE). ([#102323](https://github.com/kubernetes/kubernetes/pull/102323), [@saschagrunert](https://github.com/saschagrunert))
- Clarified the description of a test in the e2e suite that mentions "SCTP" but is
  actually intended to be testing the behavior of network plugins that don't
  implement SCTP. ([#102509](https://github.com/kubernetes/kubernetes/pull/102509), [@danwinship](https://github.com/danwinship))
- Client-go: reduce verbosity of `Starting/Stopping reflector` messages to 3 again. ([#102788](https://github.com/kubernetes/kubernetes/pull/102788), [@pohly](https://github.com/pohly))
- Disable log sampling when using json logging format. ([#102620](https://github.com/kubernetes/kubernetes/pull/102620), [@serathius](https://github.com/serathius))
- Exposes `WithCustomRoundTripper` method for specifying a middleware function for custom HTTP behaviour for the delegated auth clients. ([#99775](https://github.com/kubernetes/kubernetes/pull/99775), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Fake clients now implement a `FakeClient` interface ([#100940](https://github.com/kubernetes/kubernetes/pull/100940), [@markusthoemmes](https://github.com/markusthoemmes)) [SIG API Machinery and Instrumentation]
- Featuregate `ServiceLoadBalancerClass` graduates to Beta and is enables by default. ([#103129](https://github.com/kubernetes/kubernetes/pull/103129), [@XudongLiuHarold](https://github.com/XudongLiuHarold))
- Improve func `ToSelectableFields`' performance for event. ([#102461](https://github.com/kubernetes/kubernetes/pull/102461), [@goodluckbot](https://github.com/goodluckbot))
- Increased `CSINodeIDMaxLength` from 128 bytes to 192 bytes. Prepare to increase the length limit to 256 bytes in 1.23 release. ([#101256](https://github.com/kubernetes/kubernetes/pull/101256), [@Jiawei0227](https://github.com/Jiawei0227))
- JSON logging now supports having information about source code location in the logging format, source code information is available under the key "caller". ([#102437](https://github.com/kubernetes/kubernetes/pull/102437), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Kubeadm: move the BootstrapToken* API and related utilities from v1beta3 to a separate API group/version - bootstraptoken/v1. ([#102964](https://github.com/kubernetes/kubernetes/pull/102964), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: the `CriticalAddonsOnly` toleration has been removed from `kube-proxy` DaemonSet ([#101966](https://github.com/kubernetes/kubernetes/pull/101966), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Metrics Server updated to use `0.4.4` image that doesn't depend on deprecated `authorization.k8s.io/v1beta1` subjectaccessreviews API version. ([#101477](https://github.com/kubernetes/kubernetes/pull/101477), [@x13n](https://github.com/x13n))
- Migrate `proxy/ipvs/proxier.go` logs to structured logging. ([#97796](https://github.com/kubernetes/kubernetes/pull/97796), [@JornShen](https://github.com/JornShen))
- Migrate `staging/src/k8s.io/apiserver/pkg/registry` logs to structured logging. ([#98287](https://github.com/kubernetes/kubernetes/pull/98287), [@lala123912](https://github.com/lala123912))
- Migrate some log messages to structured logging in `pkg/volume/plugins.go`. ([#101510](https://github.com/kubernetes/kubernetes/pull/101510), [@huchengze](https://github.com/huchengze))
- Migrate some log messages to structured logging in `pkg/volume/volume_linux.go`. ([#99566](https://github.com/kubernetes/kubernetes/pull/99566), [@huchengze](https://github.com/huchengze))
- Official binaries now include the golang generated build ID `buildid` instead of an empty string. ([#101411](https://github.com/kubernetes/kubernetes/pull/101411), [@saschagrunert](https://github.com/saschagrunert))
- Remove balanced attached node volumes feature. ([#102443](https://github.com/kubernetes/kubernetes/pull/102443), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Remove deprecated `--generator` flag from `kubectl autoscale`. ([#99900](https://github.com/kubernetes/kubernetes/pull/99900), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Remove the deprecated flag `--generator` from `kubectl create deployment` command. ([#99915](https://github.com/kubernetes/kubernetes/pull/99915), [@BLasan](https://github.com/BLasan))
- Remove the duplicate packet import. ([#101187](https://github.com/kubernetes/kubernetes/pull/101187), [@chuntaochen](https://github.com/chuntaochen))
- Replace `go-bindata` with `//go:embed`. ([#99829](https://github.com/kubernetes/kubernetes/pull/99829), [@palnabarun](https://github.com/palnabarun))
- The `DynamicFakeClient` now exposes its tracker via a `Tracker()` function. ([#100085](https://github.com/kubernetes/kubernetes/pull/100085), [@markusthoemmes](https://github.com/markusthoemmes))
- The `VolumeSnapshotDataSource` feature gate that is GA since v1.20 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#101531](https://github.com/kubernetes/kubernetes/pull/101531), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Storage]
- The deprecated `CRIContainerLogRotation` feature-gate has been removed, since the `CRIContainerLogRotatio`n feature graduated to GA in 1.21 and was unconditionally enabled. ([#101578](https://github.com/kubernetes/kubernetes/pull/101578), [@carlory](https://github.com/carlory))
- The deprecated `RootCAConfigMap` feature-gate has been removed, since the `RootCAConfigMap` feature graduated to GA in 1.21 and is unconditionally enabled. ([#101579](https://github.com/kubernetes/kubernetes/pull/101579), [@carlory](https://github.com/carlory))
- The deprecated `runAsGroup` feature-gate has been removed, since the `runAsGroup` feature graduated to GA in 1.21. ([#101581](https://github.com/kubernetes/kubernetes/pull/101581), [@carlory](https://github.com/carlory))
- The etcd client has been updated to 3.5.0; `github.com/golang/protobuf`, `google.golang.org/protobuf`, and `google.golang.org/grpc` have been updated to current versions. ([#100488](https://github.com/kubernetes/kubernetes/pull/100488), [@liggitt](https://github.com/liggitt))
- Update Azure Go SDK to v55.0.0. ([#102441](https://github.com/kubernetes/kubernetes/pull/102441), [@feiskyer](https://github.com/feiskyer))
- Update Azure Go SDK version to v53.1.0 ([#101357](https://github.com/kubernetes/kubernetes/pull/101357), [@feiskyer](https://github.com/feiskyer)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Update CNI plugins to v0.9.1. ([#102328](https://github.com/kubernetes/kubernetes/pull/102328), [@lentzi90](https://github.com/lentzi90))
- Update Calico to v3.19.1. ([#102386](https://github.com/kubernetes/kubernetes/pull/102386), [@JornShen](https://github.com/JornShen))
- Update cri-tools dependency to `v1.21.0`. ([#100956](https://github.com/kubernetes/kubernetes/pull/100956), [@saschagrunert](https://github.com/saschagrunert))
- Update dep `google/gnostic` and `google/go-cmp` to v0.5.5 and updating transitive dependencies `protobuf`. ([#102783](https://github.com/kubernetes/kubernetes/pull/102783), [@mcbenjemaa](https://github.com/mcbenjemaa))
- Update golang.org/x/net to v0.0.0-20210520170846-37e1c6afe023 ([#103176](https://github.com/kubernetes/kubernetes/pull/103176), [@CaoDonghui123](https://github.com/CaoDonghui123)) [SIG API Machinery, Auth, CLI, Cloud Provider, Cluster Lifecycle, Node and Storage]
- Updated command descriptions and examples for grammar and punctuation consistency. ([#103524](https://github.com/kubernetes/kubernetes/pull/103524), [@bergerhoffer](https://github.com/bergerhoffer)) [SIG Auth and CLI]
- Updated pause image to version 3.5, which now runs per default as pseudo user and group `65535:65535`. This does not have any effect on remote container runtimes like CRI-O and containerd, which setup the pod sandbox user and group on their own. ([#100292](https://github.com/kubernetes/kubernetes/pull/100292), [@saschagrunert](https://github.com/saschagrunert))
- Upgrade functionality of `kubectl kustomize` as described at [kustomize/v4.1.3](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.1.3). ([#102193](https://github.com/kubernetes/kubernetes/pull/102193), [@gautierdelorme](https://github.com/gautierdelorme))

## Dependencies

### Added
- github.com/antihax/optional: [v1.0.0](https://github.com/antihax/optional/tree/v1.0.0)
- github.com/benbjohnson/clock: [v1.0.3](https://github.com/benbjohnson/clock/tree/v1.0.3)
- github.com/certifi/gocertifi: [2c3bb06](https://github.com/certifi/gocertifi/tree/2c3bb06)
- github.com/checkpoint-restore/go-criu/v5: [v5.0.0](https://github.com/checkpoint-restore/go-criu/v5/tree/v5.0.0)
- github.com/cncf/udpa/go: [5459f2c](https://github.com/cncf/udpa/go/tree/5459f2c)
- github.com/cockroachdb/errors: [v1.2.4](https://github.com/cockroachdb/errors/tree/v1.2.4)
- github.com/cockroachdb/logtags: [eb05cc2](https://github.com/cockroachdb/logtags/tree/eb05cc2)
- github.com/coredns/caddy: [v1.1.0](https://github.com/coredns/caddy/tree/v1.1.0)
- github.com/felixge/httpsnoop: [v1.0.1](https://github.com/felixge/httpsnoop/tree/v1.0.1)
- github.com/frankban/quicktest: [v1.11.3](https://github.com/frankban/quicktest/tree/v1.11.3)
- github.com/getsentry/raven-go: [v0.2.0](https://github.com/getsentry/raven-go/tree/v0.2.0)
- github.com/go-kit/log: [v0.1.0](https://github.com/go-kit/log/tree/v0.1.0)
- github.com/gofrs/uuid: [v4.0.0+incompatible](https://github.com/gofrs/uuid/tree/v4.0.0)
- github.com/josharian/intern: [v1.0.0](https://github.com/josharian/intern/tree/v1.0.0)
- github.com/jpillora/backoff: [v1.0.0](https://github.com/jpillora/backoff/tree/v1.0.0)
- github.com/nxadm/tail: [v1.4.4](https://github.com/nxadm/tail/tree/v1.4.4)
- github.com/opentracing/opentracing-go: [v1.1.0](https://github.com/opentracing/opentracing-go/tree/v1.1.0)
- github.com/robfig/cron/v3: [v3.0.1](https://github.com/robfig/cron/v3/tree/v3.0.1)
- github.com/stoewer/go-strcase: [v1.2.0](https://github.com/stoewer/go-strcase/tree/v1.2.0)
- go.etcd.io/etcd/api/v3: v3.5.0
- go.etcd.io/etcd/client/pkg/v3: v3.5.0
- go.etcd.io/etcd/client/v2: v2.305.0
- go.etcd.io/etcd/client/v3: v3.5.0
- go.etcd.io/etcd/pkg/v3: v3.5.0
- go.etcd.io/etcd/raft/v3: v3.5.0
- go.etcd.io/etcd/server/v3: v3.5.0
- go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc: v0.20.0
- go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp: v0.20.0
- go.opentelemetry.io/contrib: v0.20.0
- go.opentelemetry.io/otel/exporters/otlp: v0.20.0
- go.opentelemetry.io/otel/metric: v0.20.0
- go.opentelemetry.io/otel/oteltest: v0.20.0
- go.opentelemetry.io/otel/sdk/export/metric: v0.20.0
- go.opentelemetry.io/otel/sdk/metric: v0.20.0
- go.opentelemetry.io/otel/sdk: v0.20.0
- go.opentelemetry.io/otel/trace: v0.20.0
- go.opentelemetry.io/otel: v0.20.0
- go.opentelemetry.io/proto/otlp: v0.7.0
- go.uber.org/goleak: v1.1.10

### Changed
- github.com/Azure/azure-sdk-for-go: [v43.0.0+incompatible → v55.0.0+incompatible](https://github.com/Azure/azure-sdk-for-go/compare/v43.0.0...v55.0.0)
- github.com/Azure/go-ansiterm: [d6e3b33 → d185dfc](https://github.com/Azure/go-ansiterm/compare/d6e3b33...d185dfc)
- github.com/Azure/go-autorest/autorest/adal: [v0.9.5 → v0.9.13](https://github.com/Azure/go-autorest/autorest/adal/compare/v0.9.5...v0.9.13)
- github.com/Azure/go-autorest/autorest/to: [v0.2.0 → v0.4.0](https://github.com/Azure/go-autorest/autorest/to/compare/v0.2.0...v0.4.0)
- github.com/Azure/go-autorest/autorest: [v0.11.12 → v0.11.18](https://github.com/Azure/go-autorest/autorest/compare/v0.11.12...v0.11.18)
- github.com/Azure/go-autorest/logger: [v0.2.0 → v0.2.1](https://github.com/Azure/go-autorest/logger/compare/v0.2.0...v0.2.1)
- github.com/alecthomas/units: [c3de453 → f65c72e](https://github.com/alecthomas/units/compare/c3de453...f65c72e)
- github.com/auth0/go-jwt-middleware: [5493cab → v1.0.1](https://github.com/auth0/go-jwt-middleware/compare/5493cab...v1.0.1)
- github.com/aws/aws-sdk-go: [v1.35.24 → v1.38.49](https://github.com/aws/aws-sdk-go/compare/v1.35.24...v1.38.49)
- github.com/cilium/ebpf: [v0.2.0 → v0.5.0](https://github.com/cilium/ebpf/compare/v0.2.0...v0.5.0)
- github.com/cockroachdb/datadriven: [80d97fb → bf6692d](https://github.com/cockroachdb/datadriven/compare/80d97fb...bf6692d)
- github.com/container-storage-interface/spec: [v1.3.0 → v1.5.0](https://github.com/container-storage-interface/spec/compare/v1.3.0...v1.5.0)
- github.com/containerd/console: [v1.0.1 → v1.0.2](https://github.com/containerd/console/compare/v1.0.1...v1.0.2)
- github.com/containernetworking/cni: [v0.8.0 → v0.8.1](https://github.com/containernetworking/cni/compare/v0.8.0...v0.8.1)
- github.com/coredns/corefile-migration: [v1.0.11 → v1.0.12](https://github.com/coredns/corefile-migration/compare/v1.0.11...v1.0.12)
- github.com/coreos/go-systemd/v22: [v22.1.0 → v22.3.2](https://github.com/coreos/go-systemd/v22/compare/v22.1.0...v22.3.2)
- github.com/envoyproxy/go-control-plane: [5f8ba28 → 668b12f](https://github.com/envoyproxy/go-control-plane/compare/5f8ba28...668b12f)
- github.com/evanphx/json-patch: [v4.9.0+incompatible → v4.11.0+incompatible](https://github.com/evanphx/json-patch/compare/v4.9.0...v4.11.0)
- github.com/form3tech-oss/jwt-go: [v3.2.2+incompatible → v3.2.3+incompatible](https://github.com/form3tech-oss/jwt-go/compare/v3.2.2...v3.2.3)
- github.com/go-logfmt/logfmt: [v0.4.0 → v0.5.0](https://github.com/go-logfmt/logfmt/compare/v0.4.0...v0.5.0)
- github.com/go-openapi/jsonpointer: [v0.19.3 → v0.19.5](https://github.com/go-openapi/jsonpointer/compare/v0.19.3...v0.19.5)
- github.com/go-openapi/jsonreference: [v0.19.3 → v0.19.5](https://github.com/go-openapi/jsonreference/compare/v0.19.3...v0.19.5)
- github.com/go-openapi/swag: [v0.19.5 → v0.19.14](https://github.com/go-openapi/swag/compare/v0.19.5...v0.19.14)
- github.com/godbus/dbus/v5: [v5.0.3 → v5.0.4](https://github.com/godbus/dbus/v5/compare/v5.0.3...v5.0.4)
- github.com/golang/groupcache: [8c9f03a → 41bb18b](https://github.com/golang/groupcache/compare/8c9f03a...41bb18b)
- github.com/golang/protobuf: [v1.4.3 → v1.5.2](https://github.com/golang/protobuf/compare/v1.4.3...v1.5.2)
- github.com/google/btree: [v1.0.0 → v1.0.1](https://github.com/google/btree/compare/v1.0.0...v1.0.1)
- github.com/google/cadvisor: [v0.39.0 → v0.39.2](https://github.com/google/cadvisor/compare/v0.39.0...v0.39.2)
- github.com/google/go-cmp: [v0.5.2 → v0.5.5](https://github.com/google/go-cmp/compare/v0.5.2...v0.5.5)
- github.com/googleapis/gnostic: [v0.4.1 → v0.5.5](https://github.com/googleapis/gnostic/compare/v0.4.1...v0.5.5)
- github.com/gopherjs/gopherjs: [0766667 → fce0ec3](https://github.com/gopherjs/gopherjs/compare/0766667...fce0ec3)
- github.com/grpc-ecosystem/go-grpc-middleware: [f849b54 → v1.3.0](https://github.com/grpc-ecosystem/go-grpc-middleware/compare/f849b54...v1.3.0)
- github.com/grpc-ecosystem/grpc-gateway: [v1.9.5 → v1.16.0](https://github.com/grpc-ecosystem/grpc-gateway/compare/v1.9.5...v1.16.0)
- github.com/heketi/heketi: [v10.2.0+incompatible → v10.3.0+incompatible](https://github.com/heketi/heketi/compare/v10.2.0...v10.3.0)
- github.com/jonboulle/clockwork: [v0.1.0 → v0.2.2](https://github.com/jonboulle/clockwork/compare/v0.1.0...v0.2.2)
- github.com/json-iterator/go: [v1.1.10 → v1.1.11](https://github.com/json-iterator/go/compare/v1.1.10...v1.1.11)
- github.com/julienschmidt/httprouter: [v1.2.0 → v1.3.0](https://github.com/julienschmidt/httprouter/compare/v1.2.0...v1.3.0)
- github.com/kr/pretty: [v0.2.0 → v0.2.1](https://github.com/kr/pretty/compare/v0.2.0...v0.2.1)
- github.com/mailru/easyjson: [v0.7.0 → v0.7.6](https://github.com/mailru/easyjson/compare/v0.7.0...v0.7.6)
- github.com/mattn/go-isatty: [v0.0.4 → v0.0.3](https://github.com/mattn/go-isatty/compare/v0.0.4...v0.0.3)
- github.com/miekg/dns: [v1.1.35 → v1.0.14](https://github.com/miekg/dns/compare/v1.1.35...v1.0.14)
- github.com/moby/sys/mountinfo: [v0.4.0 → v0.4.1](https://github.com/moby/sys/mountinfo/compare/v0.4.0...v0.4.1)
- github.com/moby/term: [df9cb8a → 9d4ed18](https://github.com/moby/term/compare/df9cb8a...9d4ed18)
- github.com/mwitkow/go-conntrack: [cc309e4 → 2f06839](https://github.com/mwitkow/go-conntrack/compare/cc309e4...2f06839)
- github.com/onsi/ginkgo: [v1.11.0 → v1.14.0](https://github.com/onsi/ginkgo/compare/v1.11.0...v1.14.0)
- github.com/onsi/gomega: [v1.7.0 → v1.10.1](https://github.com/onsi/gomega/compare/v1.7.0...v1.10.1)
- github.com/opencontainers/runc: [v1.0.0-rc93 → v1.0.0-rc95](https://github.com/opencontainers/runc/compare/v1.0.0-rc93...v1.0.0-rc95)
- github.com/opencontainers/runtime-spec: [e6143ca → 1c3f411](https://github.com/opencontainers/runtime-spec/compare/e6143ca...1c3f411)
- github.com/prometheus/client_golang: [v1.7.1 → v1.11.0](https://github.com/prometheus/client_golang/compare/v1.7.1...v1.11.0)
- github.com/prometheus/common: [v0.10.0 → v0.26.0](https://github.com/prometheus/common/compare/v0.10.0...v0.26.0)
- github.com/prometheus/procfs: [v0.2.0 → v0.6.0](https://github.com/prometheus/procfs/compare/v0.2.0...v0.6.0)
- github.com/rogpeppe/fastuuid: [6724a57 → v1.2.0](https://github.com/rogpeppe/fastuuid/compare/6724a57...v1.2.0)
- github.com/smartystreets/assertions: [b2de0cb → v1.1.0](https://github.com/smartystreets/assertions/compare/b2de0cb...v1.1.0)
- github.com/soheilhy/cmux: [v0.1.4 → v0.1.5](https://github.com/soheilhy/cmux/compare/v0.1.4...v0.1.5)
- github.com/spf13/cobra: [v1.1.1 → v1.1.3](https://github.com/spf13/cobra/compare/v1.1.1...v1.1.3)
- github.com/spf13/jwalterweatherman: [v1.1.0 → v1.0.0](https://github.com/spf13/jwalterweatherman/compare/v1.1.0...v1.0.0)
- github.com/stretchr/testify: [v1.6.1 → v1.7.0](https://github.com/stretchr/testify/compare/v1.6.1...v1.7.0)
- github.com/tmc/grpc-websocket-proxy: [0ad062e → e5319fd](https://github.com/tmc/grpc-websocket-proxy/compare/0ad062e...e5319fd)
- github.com/yuin/goldmark: [v1.2.1 → v1.3.5](https://github.com/yuin/goldmark/compare/v1.2.1...v1.3.5)
- go.etcd.io/bbolt: v1.3.5 → v1.3.6
- go.uber.org/atomic: v1.4.0 → v1.7.0
- go.uber.org/multierr: v1.1.0 → v1.6.0
- go.uber.org/zap: v1.10.0 → v1.17.0
- golang.org/x/lint: 738671d → 6edffad
- golang.org/x/mod: ce943fd → v0.4.2
- golang.org/x/net: 3d97a24 → 37e1c6a
- golang.org/x/sync: 67f06af → 036812b
- golang.org/x/sys: a50acf3 → 59db8d7
- golang.org/x/text: v0.3.4 → v0.3.6
- golang.org/x/tools: v0.1.0 → v0.1.2
- google.golang.org/genproto: 8816d57 → f16073e
- google.golang.org/grpc: v1.27.1 → v1.38.0
- google.golang.org/protobuf: v1.25.0 → v1.26.0
- gopkg.in/yaml.v3: 9f266ea → 496545a
- k8s.io/klog/v2: v2.8.0 → v2.9.0
- k8s.io/kube-openapi: 591a79e → 9528897
- k8s.io/system-validators: v1.4.0 → v1.5.0
- k8s.io/utils: 67b214c → 4b05e18
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.15 → v0.0.21
- sigs.k8s.io/kustomize/api: v0.8.5 → v0.8.11
- sigs.k8s.io/kustomize/cmd/config: v0.9.7 → v0.9.13
- sigs.k8s.io/kustomize/kustomize/v4: v4.0.5 → v4.2.0
- sigs.k8s.io/kustomize/kyaml: v0.10.15 → v0.11.0
- sigs.k8s.io/structured-merge-diff/v4: v4.1.0 → v4.1.2

### Removed
- github.com/agnivade/levenshtein: [v1.0.1](https://github.com/agnivade/levenshtein/tree/v1.0.1)
- github.com/alecthomas/template: [fb15b89](https://github.com/alecthomas/template/tree/fb15b89)
- github.com/andreyvit/diff: [c7f18ee](https://github.com/andreyvit/diff/tree/c7f18ee)
- github.com/bifurcation/mint: [93c51c6](https://github.com/bifurcation/mint/tree/93c51c6)
- github.com/caddyserver/caddy: [v1.0.3](https://github.com/caddyserver/caddy/tree/v1.0.3)
- github.com/cenkalti/backoff: [v2.1.1+incompatible](https://github.com/cenkalti/backoff/tree/v2.1.1)
- github.com/checkpoint-restore/go-criu/v4: [v4.1.0](https://github.com/checkpoint-restore/go-criu/v4/tree/v4.1.0)
- github.com/cheekybits/genny: [9127e81](https://github.com/cheekybits/genny/tree/9127e81)
- github.com/go-acme/lego: [v2.5.0+incompatible](https://github.com/go-acme/lego/tree/v2.5.0)
- github.com/go-bindata/go-bindata: [v3.1.1+incompatible](https://github.com/go-bindata/go-bindata/tree/v3.1.1)
- github.com/go-openapi/analysis: [v0.19.5](https://github.com/go-openapi/analysis/tree/v0.19.5)
- github.com/go-openapi/errors: [v0.19.2](https://github.com/go-openapi/errors/tree/v0.19.2)
- github.com/go-openapi/loads: [v0.19.4](https://github.com/go-openapi/loads/tree/v0.19.4)
- github.com/go-openapi/runtime: [v0.19.4](https://github.com/go-openapi/runtime/tree/v0.19.4)
- github.com/go-openapi/spec: [v0.19.5](https://github.com/go-openapi/spec/tree/v0.19.5)
- github.com/go-openapi/strfmt: [v0.19.5](https://github.com/go-openapi/strfmt/tree/v0.19.5)
- github.com/go-openapi/validate: [v0.19.8](https://github.com/go-openapi/validate/tree/v0.19.8)
- github.com/gobuffalo/here: [v0.6.0](https://github.com/gobuffalo/here/tree/v0.6.0)
- github.com/hpcloud/tail: [v1.0.0](https://github.com/hpcloud/tail/tree/v1.0.0)
- github.com/jimstudt/http-authentication: [3eca13d](https://github.com/jimstudt/http-authentication/tree/3eca13d)
- github.com/klauspost/cpuid: [v1.2.0](https://github.com/klauspost/cpuid/tree/v1.2.0)
- github.com/kr/logfmt: [b84e30a](https://github.com/kr/logfmt/tree/b84e30a)
- github.com/kylelemons/godebug: [d65d576](https://github.com/kylelemons/godebug/tree/d65d576)
- github.com/lucas-clemente/aes12: [cd47fb3](https://github.com/lucas-clemente/aes12/tree/cd47fb3)
- github.com/lucas-clemente/quic-clients: [v0.1.0](https://github.com/lucas-clemente/quic-clients/tree/v0.1.0)
- github.com/lucas-clemente/quic-go-certificates: [d2f8652](https://github.com/lucas-clemente/quic-go-certificates/tree/d2f8652)
- github.com/lucas-clemente/quic-go: [v0.10.2](https://github.com/lucas-clemente/quic-go/tree/v0.10.2)
- github.com/markbates/pkger: [v0.17.1](https://github.com/markbates/pkger/tree/v0.17.1)
- github.com/marten-seemann/qtls: [v0.2.3](https://github.com/marten-seemann/qtls/tree/v0.2.3)
- github.com/mholt/certmagic: [6a42ef9](https://github.com/mholt/certmagic/tree/6a42ef9)
- github.com/naoina/go-stringutil: [v0.1.0](https://github.com/naoina/go-stringutil/tree/v0.1.0)
- github.com/naoina/toml: [v0.1.1](https://github.com/naoina/toml/tree/v0.1.1)
- github.com/robfig/cron: [v1.1.0](https://github.com/robfig/cron/tree/v1.1.0)
- github.com/satori/go.uuid: [v1.2.0](https://github.com/satori/go.uuid/tree/v1.2.0)
- github.com/thecodeteam/goscaleio: [v0.1.0](https://github.com/thecodeteam/goscaleio/tree/v0.1.0)
- github.com/tidwall/pretty: [v1.0.0](https://github.com/tidwall/pretty/tree/v1.0.0)
- github.com/vektah/gqlparser: [v1.1.2](https://github.com/vektah/gqlparser/tree/v1.1.2)
- go.etcd.io/etcd: dd1b699
- go.mongodb.org/mongo-driver: v1.1.2
- gopkg.in/cheggaaa/pb.v1: v1.0.25
- gopkg.in/fsnotify.v1: v1.4.7
- gopkg.in/mcuadros/go-syslog.v2: v2.2.1
- gopkg.in/resty.v1: v1.12.0
- k8s.io/heapster: v1.2.0-beta.1
