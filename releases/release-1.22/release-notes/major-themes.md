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

A new alpha feature gate SeccompDefault has been added to the kubelet, together with a corresponding command line flag `--seccomp-default` and kubelet configuration. If both are enabled, then the kubelet's behavior changes for pods that don't explicitly set a seccomp profile.
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

