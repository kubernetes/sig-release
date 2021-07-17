## What's New (Major Themes)

### Deprecation of old Kubernetes APIs and Feature

A number of APIs are no longer serving specific Beta versions in favour of the GA version of those APIs. All existing objects can be interacted with via general availability APIs. This removal includes and is not limited to `ValidatingWebhookConfiguration`, `MutatingWebhookConfiguration`, `CustomResourceDefinition`, `APIService`, `TokenReview`, `SubjectAccessReview`, `CertificateSigningRequest`, `Lease`, `Ingress`, `IngressClass` and more. For the full list checkout [Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22) and the blog post [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/).

### Kubernetes Node system swap support

Every system admin or kubernetes user has in the same boat regarding setting up and using Kubernetes, disabled swap space. Using the swap space has its benefits and if a Linux user enables it on machine running kublet is in a world of hurt. With the release of Kubernetes 1.22, alpha support is available for nodes running with swap memory. This change allows administrators to enable the Kubelet to control swap memory use on Linux nodes for container workloads in limited and unlimited configurations.

### Kuberentes Release Cadence Change

We all had to adapt to change in our life even more so in the past year. The Kubernetes Release team was also affected from the pandemic and listen it is user base regarding the number of release in a calendar year. From April 23, 2021 it was made official that Kubernetes release cycle is decrimented by one, from 4 to 3, a year. You can read more in the official blog post [Kuberentes Release Cadence Change: Here’s What You Need To Know]()

### Enable seccomp by default

A new alpha feature gate SeccompDefault has been added to the kubelet together with a corresponding command line flag `--seccomp-default` and kubelet configuration. If both are enabled, then the kubelet will use the RuntimeDefault seccomp profile rather than Unconfined if they're not specified in the Pod or Container SecurityContext. This allows enhancing the default cluster wide workload security of the Kubernetes deployment. Security administrators will now sleep better knowing there is some security by default for the workloads.
To learn more about the feature, please refer to the [official documentation](https://kubernetes.io/docs/tutorials/clusters/seccomp/#enable-the-use-of-runtimedefault-as-the-default-seccomp-profile-for-all-workloads) and look out for the feature blog post.

### Support memory qos with cgroups v2

In traditional `cgroups v1` implementation in Kubernetes, pod qos class and qos manager can only limit cpu resources, such as `cpu_shares`. Kubernetes cgroup manager uses `memory.limit_in_bytes` in `cgroups v1` to limit the memory capacity and uses `oom_scores` to determine the order of killing the container processes when OOM occurs. This implementation has downfalls as `Guaranteed` memory can not be fully reserved, page cache is at risk of being recycled. And `Burstable` memory allocation overcommit ( request < limit ) could increase OOM possibility when kernel memory runs out.
[KEP-2570](https://github.com/kubernetes/enhancements/pull/2571) introduces cgroups v2, which brings new capabilities for memory controllers and it would help Kubernetes enhance memory isolation quality. This feature is designed to improve workload and node availability in memory resource. It is first introduced as alpha in Kubernetes 1.22.

### Etcd moving to version 3.5.0

Kubernetes default backend storage of etcd has a new release 3.5.0 and the community embraced it. The new release comes with improvements to the Security, performance, monitoring and developer experience. There are numerous bug fixes to lease objects causing memory leaks, and compact operation causing deadlocks and more. A couple of new features are also introduced like the migration to structured logging and build in log rotation. The release comes with a detailed future roadmap to implement a solution to traffic overload. A full and detailed list of changes can be read at [ETCD blog post about the 3.5.0 release ](https://etcd.io/blog/2021/announcing-etcd-3.5/)

### External credential providers

[client-go credential plugins](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#client-go-credential-plugins) have been in beta since 1.11, a few eons ago. With the release of Kubernetes 1.22, this feature set graduates to stable. The GA feature set includes improved support for plugins that provide interactive login flows. This release also contains a number of bug fixes to the feature set. Aspiring plugin authors can look at [sample-exec-plugin](https://github.com/ankeesler/sample-exec-plugin) as a way to get started.
Related to this topic, [the in-tree azure and gcp auth plugins have been deprecated](https://github.com/kubernetes/kubernetes/pull/102181) in favor of out-of-tree implementations of these plugins.

### SIG Windows development tools

To grow the developer community, sig-windows released [multiple tools](https://github.com/kubernetes-sigs/sig-windows-dev-tools/), which supports multiple CNI providers (antrea, calico), can run on multiple platforms (any vagrant compatible provider, such as hyper-v, virtualbox, vsphere), and provides a sandbox for running bleeding edge windows features from scratch by compiling the windows kubelet and kube proxy and running from sig-release daily builds.

### SIG Cluster Lifecycle adds features to kubeadm

A new [v1beta3 configuration API](https://github.com/kubernetes/kubeadm/issues/1796). It [iterates over v1beta2](https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta3) by adding some long requested features and deprecating some existing ones. The `V1beta3` is now the preferred API version, but `v1beta2` is not yet deprecated (TBD in a future release).

[A new Alpha feature](https://github.com/kubernetes/kubeadm/issues/2473) for running the kubeadm control plane components as non-root users. This is a long requested security measure in kubeadm. To try it you must enable the kubeadm-specific `RootlessControlPlane` feature gate. After we improved the sleep for security folks, they can drink their morning cup of beverage a bit less hastily.

### Lets `kubectl debug` with the new and improved API for Ephermal Containers

The API used to create Ephemeral Containers changed in 1.22. The Ephemeral Containers feature is alpha anddisabled by default, and the new API will not work with clients attempting to use the old API.
Users who create ephemeral containers using kubectl debug should note that kubectl version 1.22 will attempt to fallback to the old API, but older versions of kubectl will not work with cluster versions of 1.22 or later. Please update kubectl to 1.22 if you wish to use kubectl debug with a mix of cluster versions. (This only applies to debugging using ephemeral containers.)
Admission plugin authors should note that the AdmissionReview request will now contain the entire v1.Pod rather than just a list of ephemeral containers as before.
Cluster administrators should note that securityContext may now be set on ephemeral containers and ensure that cluster security policies are applied to these fields prior to enabling the Ephemeral Containers feature.

### Server-side Apply graduates to GA in 1.22.

Server-side Apply is a new object merge algorithm, as well as tracking of field ownership, running on the Kubernetes api-server. It helps users and controllers manage their resources via declarative configurations. It allows them to create and/or modify their objects declaratively, simply by sending their fully specified intent. After being in beta for a couple releases, Server-side Apply graduates to GA in 1.22.

### SIG Storage Moves couple features to GA

CSI Windows moves to GA in the 1.22 release. Windows currently does not support privileged containers. To solve this problem, [CSIProxy](https://github.com/kubernetes-csi/csi-proxy) enables CSI node plugins to bedeployed as unprivileged pods and use the proxy to perform privileged storage operations on the node.
CSI Service Account Token moves to GA in 1.22. This feature allows CSI drivers to use pods' [bound service account tokens](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/1205-bound-service-account-tokens/README.md) instead of a more privileged identity. It also provides a knob to re-publish volumes so that short-lived volumes can be refreshed. 

