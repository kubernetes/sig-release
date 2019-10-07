# Kubernetes 1.10 Release Notes Draft

# Major Themes

### Node

Many of the changes within SIG-Node revolve around control, with the beta release of [Dynamic Kubelet Configuration](https://github.com/kubernetes/features/issues/281), the ability to make changes to Kubelet without having to bring down the node, and alpha support for the ability to [configure whether containers in a pod should share a single process namespace](https://github.com/kubernetes/features/issues/495), The CRI has also seen some improvements and has been upgraded to v1alpha2, with support for  [support for Windows Container Configuration](https://github.com/kubernetes/features/issues/547) and the beta release of the [CRI validation test suite](https://github.com/kubernetes/features/issues/292). 

The Resource Management Working Group graduated three features to beta in the 1.10 release.  First, [CPU Manager](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/), which allows users to request exclusive CPU cores.  This helps performance in a variety of use-cases, including network latency sensitive applications, as well as applications that benefit from CPU cache residency.  Next, [Huge Pages](https://kubernetes.io/docs/tasks/manage-hugepages/scheduling-hugepages/), which allows pods to consume either 2Mi or 1Gi Huge Pages.  This benefits applications that consume large amounts of memory.  Use of Huge Pages is a common tuning recommendation for databases and JVMs.  Finally, the [Device Plugin](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) feature, which provides a framework for vendors to advertise their resources to the Kubelet without changing Kubernetes core code.  Targeted devices include GPUs, High-performance NICs, FPGAs, InfiniBand, and other similar computing resources that may require vendor specific initialization and setup.

### Storage

This release brings additional power to both local storage and Persistent Volumes. [Mount namespace propagation](https://github.com/kubernetes/features/issues/432) allows a container to mount a volume as rslave so that host mounts can be seen inside the container, or as rshared so that mounts made inside a container can be seen by the host. (Note that this is [not supported on Windows](https://github.com/kubernetes/kubernetes/pull/60275).) [Local Ephemeral Storage Capacity Isolation](https://github.com/kubernetes/features/issues/361) makes it possible to set requests and limits on ephemeral local storage resources. In addition, you can now create [Local Persistent Storage](https://github.com/kubernetes/features/issues/121), which enables PersistentVolumes to be created with locally attached disks, and not just network volumes.

On the Persistent Volumes side, this release [Prevents deletion of Persistent Volume Claims that are used by a pod](https://github.com/kubernetes/features/issues/498) and [Persistent Volumes that are bound to a Persistent Volume Claim](https://github.com/kubernetes/features/issues/499), making it impossible to delete storage that is in use by a pod. 

This release also includes [Topology Aware Volume Scheduling](https://github.com/kubernetes/features/issues/490) for local persistent volumes and beta support for [Out-of-tree CSI Volume Plugins](https://github.com/kubernetes/features/issues/178).

### Windows

This release continues to enable more existing features on Windows, including container CPU resources, image filesystem stats, and flexvolumes. It also adds Windows service control manager support and experimental support for Hyper-V isolation of single-container pods.

### OpenStack

SIG-OpenStack updated the OpenStack provider to use newer APIs, consolidated community code into one repository, engaged with the Cloud Provider Working Group to have a consistent plan for moving provider code into individual repositories, improved testing of provider code, and strengthened ties with the OpenStack developer community.

### API-machinery

[API Aggregation](https://github.com/kubernetes/features/issues/263) has been upgraded to "stable" in Kubernetes 1.10, so you can use it in production. Webhooks have seen numerous improvements, including alpha [Support for self-hosting authorizer webhooks](https://github.com/kubernetes/features/issues/516).

### Auth

This release lays the groundwork for new authentication methods, including the alpha release of [External client-go credential providers](https://github.com/kubernetes/features/issues/541)  and the [TokenRequest API](https://github.com/kubernetes/features/issues/542). In addition, [Pod Security Policy](https://github.com/kubernetes/features/issues/5) now lets administrators decide what contexts pods can run in, and gives administrators the ability to [limit node access to the API](https://github.com/kubernetes/features/issues/279).

### Azure

Kubernetes 1.10 includes alpha [Azure support for cluster-autoscaler](https://github.com/kubernetes/features/issues/514), as well as [support for Azure Virtual Machine Scale Sets](https://github.com/kubernetes/features/issues/513).

### CLI

This release includes a change to [kubectl get and describe to work better with extensions](https://github.com/kubernetes/features/issues/515), as the server, rather than the client, returns this information for a smoother user experience.

### Cluster Lifecycle

This release includes beta [support for out-of-process and out-of-tree cloud providers](https://github.com/kubernetes/features/issues/88).

### Network

In terms of networking, Kubernetes 1.10 is about control. Users now have beta support for the ability to [configure a pod's resolv.conf](https://github.com/kubernetes/features/issues/504), rather than relying on the cluster DNS, as well as [configuring the NodePort IP address](https://github.com/kubernetes/features/issues/539). You can also  [switch the default DNS plugin to CoreDNS](https://github.com/kubernetes/features/issues/427) (beta). 

# Before Upgrading

* In-place node upgrades to this release from versions 1.7.14, 1.8.9, and 1.9.4 are not supported if using subpath volumes with PVCs.  Such pods should be drained from the node first.

* The minimum supported version of Docker is now 1.11; if you are using Docker 1.10 or below, be sure to upgrade Docker before upgrading Kubernetes. ([#57845](https://github.com/kubernetes/kubernetes/pull/57845), [@yujuhong](https://github.com/yujuhong))

* The Container Runtime Interface (CRI) version has increased from v1alpha1 to v1alpha2. Runtimes implementing the CRI will need to update to the new version, which configures container namespaces using an enumeration rather than booleans. This change to the alpha API is not backwards compatible; implementations of the CRI such as containerd, will need to update to the new API version. ([#58973](https://github.com/kubernetes/kubernetes/pull/58973), [@verb](https://github.com/verb))

* The default Flexvolume plugin directory for COS images on GCE has changed to `/home/kubernetes/flexvolume`, rather than `/etc/srv/kubernetes/kubelet-plugins/volume/exec`. Existing Flexvolume installations in clusters using COS images must be moved to the new directory, and installation processes must be updated with the new path. ([#58171](https://github.com/kubernetes/kubernetes/pull/58171), [@verult](https://github.com/verult))

* Default values differ between the Kubelet's componentconfig (config file) API and the Kubelet's command line. Be sure to review the default values when migrating to using a config file. For example, the authz mode is set to "AlwaysAllow" if you rely on the command line, but defaults to the more secure "Webhook" mode if you load config from a file. ([#59666](https://github.com/kubernetes/kubernetes/pull/59666), [@mtaufen](https://github.com/mtaufen))

* [GCP kube-up.sh] Variables that were part of kube-env that were only used for kubelet flags are no longer being set, and are being replaced by the more portable mechanism of the kubelet configuration file. The individual variables in the kube-env metadata entry were never meant to be a stable interface and this release note only applies if you are depending on them. ([#60020](https://github.com/kubernetes/kubernetes/pull/60020), [@roberthbailey](https://github.com/roberthbailey))

* kube-proxy: feature gates are now specified as a map when provided via a JSON or YAML KubeProxyConfiguration, rather than as a string of key-value pairs. For example:

KubeProxyConfiguration Before:

```
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
**featureGates: "SupportIPVSProxyMode=true"**
```

KubeProxyConfiguration After:

```
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
**featureGates:**
**  SupportIPVSProxyMode: true**
```

([#57962](https://github.com/kubernetes/kubernetes/pull/57962), [@xiangpengzhao](https://github.com/xiangpengzhao))

* The `kubeletconfig` API group has graduated from alpha to beta, and the name has changed to `kubelet.config.k8s.io`. Please use `kubelet.config.k8s.io/v1beta1`, as `kubeletconfig/v1alpha1` is no longer available.  ([#53833](https://github.com/kubernetes/kubernetes/pull/53833), [@mtaufen](https://github.com/mtaufen))

* kube-apiserver: the experimental in-tree Keystone password authenticator has been removed in favor of extensions that enable use of Keystone tokens. ([#59492](https://github.com/kubernetes/kubernetes/pull/59492), [@dims](https://github.com/dims))

* The udpTimeoutMilliseconds field in the kube-proxy configuration file has been renamed to udpIdleTimeout. Administrators must update their files accordingly. ([#57754](https://github.com/kubernetes/kubernetes/pull/57754), [@ncdc](https://github.com/ncdc))

* The kubelet's `--cloud-provider=auto-detect` feature has been removed; make certain to specify the cloud provider. ([#56287](https://github.com/kubernetes/kubernetes/pull/56287), [@stewart-yu](https://github.com/stewart-yu))

* kube-apiserver: the OpenID Connect authenticator no longer accepts tokens from the Google v3 token APIs; users must switch to the "https://www.googleapis.com/oauth2/v4/token" endpoint.

* kube-apiserver: the root /proxy paths have been removed (deprecated since v1.2). Use the /proxy subresources on objects that support HTTP proxying. ([#59884](https://github.com/kubernetes/kubernetes/pull/59884), [@mikedanese](https://github.com/mikedanese))

* Eviction thresholds set to 0% or 100% will turn off eviction. ([#59681](https://github.com/kubernetes/kubernetes/pull/59681), [@mtaufen](https://github.com/mtaufen))

* CustomResourceDefinitions: OpenAPI v3 validation schemas containing `$ref`references are no longer permitted. Before upgrading, ensure CRD definitions do not include those `$ref` fields. ([#58438](https://github.com/kubernetes/kubernetes/pull/58438), [@carlory](https://github.com/carlory))

* Webhooks now do not skip cluster-scoped resources. Before upgrading your Kubernetes clusters, double check whether you have configured webhooks for cluster-scoped objects (e.g., nodes, persistentVolume), as these webhooks will start to take effect. Delete/modify the configs if that's not desirable. ([#58185](https://github.com/kubernetes/kubernetes/pull/58185), [@caesarxuchao](https://github.com/caesarxuchao))

* Using kubectl gcp auth plugin with a Google Service Account to authenticate to a cluster now additionally requests a token with the  "userinfo.email" scope. This way, users can write ClusterRoleBindings/RoleBindings with the email address of the service account directly. (This is a breaking change if the numeric uniqueIDs of the Google service accounts were being used in RBAC role bindings. The behavior can be overridden by explicitly specifying the scope values as comma-separated string in the "users[*].config.scopes" field in the KUBECONFIG file.) This way, users can now  set a Google Service Account JSON key in the  GOOGLE_APPLICATION_CREDENTIALS environment variable, craft a kubeconfig file with GKE master IP+CA cert, and authenticate to GKE in headless mode without requiring gcloud CLI. ([#58141](https://github.com/kubernetes/kubernetes/pull/58141), [@ahmetb](https://github.com/ahmetb))

* kubectl port-forward no longer supports the deprecated -p <pod-name> flag; the flag itself is unnecessary and should be replaced by just the `<pod-name>`. ([#59705](https://github.com/kubernetes/kubernetes/pull/59705), [@phsiao](https://github.com/phsiao))

* Removed deprecated --require-kubeconfig flag, removed default --kubeconfig value (([#58367](https://github.com/kubernetes/kubernetes/pull/58367), [@zhangxiaoyu-zidif](https://github.com/zhangxiaoyu-zidif))

* The public-address-override, address, and port flags have been removed and replaced by bind-address, insecure-bind-address, and insecure-port, respectively. They are marked as deprecated in [#36604](https://github.com/kubernetes/kubernetes/pull/36604), which is more than a year ago.  ([#59018](https://github.com/kubernetes/kubernetes/pull/59018), [@hzxuzhonghu](https://github.com/hzxuzhonghu))

* The alpha `--init-config-dir` flag has been removed. Instead, use the `--config` flag to reference a kubelet configuration file directly. ([#57624](https://github.com/kubernetes/kubernetes/pull/57624), [@mtaufen](https://github.com/mtaufen))

* Removed deprecated and unmaintained salt support. kubernetes-salt.tar.gz will no longer be published in the release tarball. ([#58248](https://github.com/kubernetes/kubernetes/pull/58248), [@mikedanese](https://github.com/mikedanese))

* The deprecated –mode switch for GCE has been removed.([#61203](https://github.com/kubernetes/kubernetes/pull/61203))

* The word “manifest” has been expunged from the Kubelet API. ([#60314](https://github.com/kubernetes/kubernetes/pull/60314))

* [https://github.com/kubernetes/kubernetes/issues/49213](https://github.com/kubernetes/kubernetes/issues/49213) sig-cluster-lifecycle has decided to phase out the cluster/ directory over the next couple of releases in favor of deployment automations maintained outside of the core repo and outside of kubernetes orgs. [@kubernetes/sig-cluster-lifecycle-misc](https://github.com/orgs/kubernetes/teams/sig-cluster-lifecycle-misc))

    * Remove deprecated ContainerVM support from GCE kube-up.  ([#58247](https://github.com/kubernetes/kubernetes/pull/58247), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated kube-push.sh functionality.  ([#58246](https://github.com/kubernetes/kubernetes/pull/58246), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated container-linux support in gce kube-up.sh.  ([#58098](https://github.com/kubernetes/kubernetes/pull/58098), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated and unmaintained photon-controller kube-up.sh.  ([#58096](https://github.com/kubernetes/kubernetes/pull/58096), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated and unmaintained libvirt-coreos kube-up.sh.  ([#58023](https://github.com/kubernetes/kubernetes/pull/58023), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated and unmaintained windows installer.  ([#58020](https://github.com/kubernetes/kubernetes/pull/58020), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated and unmaintained openstack-heat kube-up.sh.  ([#58021](https://github.com/kubernetes/kubernetes/pull/58021), [@mikedanese](https://github.com/mikedanese))

    * Remove deprecated vagrant kube-up.sh. ([#58118](https://github.com/kubernetes/kubernetes/pull/58118),[@roberthbailey](https://github.com/roberthbailey))

* The DaemonSet controller, its integration tests, and its e2e tests, have been updated to use the apps/v1 API. Users should, but are not yet required to, update their scripts accordingly. ([#59883](https://github.com/kubernetes/kubernetes/pull/59883), [@kow3ns](https://github.com/kow3ns))

* MountPropagation feature is now beta. As a consequence, all volume mounts in containers are now `rslave` on Linux by default. To make this default work in all Linux environments the entire mount tree should be marked as shareable, e.g. via `mount --make-rshared /`. All Linux distributions that use systemd already have the root directory mounted as rshared and hence they need not do anything. In Linux environments without systemd we recommend running `mount --make-rshared /` during boot before docker is started, ([@jsafrane](https://github.com/jsafrane))

# Known Issues

* Use of subPath module with hostPath volumes can cause issues during reconstruction ([#61446](https://github.com/kubernetes/kubernetes/issues/61446)) and with containerized kubelets ([#61456](https://github.com/kubernetes/kubernetes/issues/61456)). The workaround for this issue is to specify the complete path in the hostPath volume. Use of subPathmounts nested within atomic writer volumes (configmap, secret, downwardAPI, projected) does not work ([#61545](https://github.com/kubernetes/kubernetes/issues/61545)), and socket files cannot be loaded from a subPath ([#62377](https://github.com/kubernetes/kubernetes/issues/61377)). Work on these issues is ongoing.

* Kubeadm is currently omitting etcd certificates in a self-hosted deployment; this will be fixed in a point relelase. ([#61322](https://github.com/kubernetes/kubernetes/issues/61322))

* Some users, especially those with very large clusters, may see higher memory usage by the kube-controller-manager in 1.10. ([#61041](https://github.com/kubernetes/kubernetes/issues/61041))

# Deprecations

* etcd2 as a backend is deprecated and support will be removed in Kubernetes 1.13.

* VolumeScheduling and LocalPersistentVolume features are beta and enabled by default.  The PersistentVolume NodeAffinity alpha annotation is deprecated and will be removed in a future release. ([#59391](https://github.com/kubernetes/kubernetes/pull/59391), [@msau42](https://github.com/msau42))

* The alpha Accelerators feature gate is deprecated and will be removed in v1.11. Please use device plugins ([https://github.com/kubernetes/features/issues/368](https://github.com/kubernetes/features/issues/368)) instead. They can be enabled using the DevicePlugins feature gate. ([#57384](https://github.com/kubernetes/kubernetes/pull/57384), [@mindprince](https://github.com/mindprince))

* The ability to use kubectl scale jobs is deprecated. All other scale operations remain in place, but the ability to scale jobs will be removed in a future release.  ([#60139](https://github.com/kubernetes/kubernetes/pull/60139), [@soltysh](https://github.com/soltysh))

* Flags that can be set via the [Kubelet's --config file](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/) are now deprecated in favor of the file. ([#60148](https://github.com/kubernetes/kubernetes/pull/60148), [@mtaufen](https://github.com/mtaufen))

* `--show-all` (which only affected pods and only for human readable/non-API printers) is now defaulted to true and deprecated.  The flag determines whether pods in a terminal state are displayed. It will be inert in 1.11 and removed in a future release. ([#60210](https://github.com/kubernetes/kubernetes/pull/60210), [@deads2k](https://github.com/deads2k))

* The ability to use the insecure HTTP port of kube-controller-manager and cloud-controller-manager has been deprecated, and will be removed in a future release. Use `--secure-port` and `--bind-address` instead. ([#59582](https://github.com/kubernetes/kubernetes/pull/59582), [@sttts](https://github.com/sttts))

* The ability to use the insecure flags `--insecure-bind-address`, `--insecure-port` in the apiserver has been deprecated and will be removed in a future release. Use `--secure-port` and `--bind-address` instead. ([#59018](https://github.com/kubernetes/kubernetes/pull/59018), [@hzxuzhonghu](https://github.com/hzxuzhonghu))

* The recycling reclaim policy has been deprecated. Users should use dynamic provisioning instead. ([#59063](https://github.com/kubernetes/kubernetes/pull/59063), [@ayushpateria](https://github.com/ayushpateria))

* kube-apiserver flag --tls-ca-file has had no effect for some time.  It is now deprecated and slated for removal in 1.11.  If you are specifying this flag, you must remove it from your launch config before upgrading to 1.11. ([#58968](https://github.com/kubernetes/kubernetes/pull/58968), [@deads2k](https://github.com/deads2k))

* The `PodSecurityPolicy` API has been moved to the `policy/v1beta1` API group. The `PodSecurityPolicy` API in the `extensions/v1beta1` API group is deprecated and will be removed in a future release. Authorizations for using pod security policy resources should change to reference the `policy` API group after upgrading to 1.11. ([#54933](https://github.com/kubernetes/kubernetes/pull/54933), [@php-coder](https://github.com/php-coder))

* Add `--enable-admission-plugin` `--disable-admission-plugin` flags and deprecate `--admission-control`. When using the separate flag, the order in which they're specified doesn't matter.  ([#58123](https://github.com/kubernetes/kubernetes/pull/58123), [@hzxuzhonghu](https://github.com/hzxuzhonghu))

* The kubelet  --docker-disable-shared-pid flag, which runs docker containers with a process namespace that is shared between all containers in a pod, is now deprecated and will be removed in a future release. It is replaced by `v1.Pod.Spec.ShareProcessNamespace`, which configures this behavior. This field is alpha and can be enabled with --feature-gates=PodShareProcessNamespace=true. ([#58093](https://github.com/kubernetes/kubernetes/pull/58093), [@verb](https://github.com/verb))

* The kubelet's cadvisor port has been deprecated. The default will change to 0 (disabled) in 1.12, and the cadvisor port will be removed entirely in 1.13. ([#59827](https://github.com/kubernetes/kubernetes/pull/59827), [@dashpole](https://github.com/dashpole))

* rktnetes has been deprecated in favor of rktlet. Please see [https://github.com/kubernetes-incubator/rktlet](https://github.com/kubernetes-incubator/rktlet) for more information. ([#58418](https://github.com/kubernetes/kubernetes/pull/58418), [@yujuhong](https://github.com/yujuhong))

* The Kubelet now explicitly registers all of its command-line flags with an internal flagset, which prevents flags from third party libraries from unintentionally leaking into the Kubelet's command-line API. Many unintentionally leaked flags are now marked deprecated, so that users have a chance to migrate away from them before they are removed. In addition, one previously leaked flag, --cloud-provider-gce-lb-src-cidrs, has been entirely removed from the Kubelet's command-line API, because it is irrelevant to Kubelet operation. The deprecated flags are: 

    * --application_metrics_count_limit
    * --boot_id_file
    * --container_hints
    * --containerd
    * --docker
    * --docker_env_metadata_whitelist
    * --docker_only
    * --docker-tls
    * --docker-tls-ca
    * --docker-tls-cert
    * --docker-tls-key
    * --enable_load_reader
    * --event_storage_age_limit
    * --event_storage_event_limit
    * --global_housekeeping_interval
    * --google-json-key
    * --log_cadvisor_usage
    * --machine_id_file
    * --storage_driver_user
    * --storage_driver_password
    * --storage_driver_host
    * --storage_driver_db
    * --storage_driver_table
    * --storage_driver_secure
    * --storage_driver_buffer_duration

([#57613](https://github.com/kubernetes/kubernetes/pull/57613), [@mtaufen](https://github.com/mtaufen))

* The boostrapped RBAC role and rolebinding for the `cloud-provider` service account is now deprecated. If you're currently using this service account, you must create and apply your own [RBAC policy](https://kubernetes.io/docs/admin/authorization/rbac/) for new clusters. ([#59949](https://github.com/kubernetes/kubernetes/pull/59949), [@nicksardo](https://github.com/nicksardo))

* Format-separated endpoints for the OpenAPI spec, such as /swagger.json, /swagger-2.0.0.0.json, and so on, have been deprecated. The old endpoints will remain in 1.10, 1.11, 1.12 and 1.13, and get removed in 1.14. Please use single `/openapi/v2` endpoint with the appropriate Accept: header instead. For example:

<table>
  <tr>
    <td>previous</td>
    <td>now</td>
  </tr>
  <tr>
    <td>GET /swagger.json</td>
    <td>GET /openapi/v2 
Accept: application/json</td>
  </tr>
  <tr>
    <td>GET /swagger-2.0.0.pb-v1</td>
    <td>GET /openapi/v2 
Accept: application/com.github.proto-openapi.spec.v2@v1.0+protobuf</td>
  </tr>
  <tr>
    <td>GET /swagger-2.0.0.pb-v1.gz</td>
    <td>GET /openapi/v2 
Accept: application/com.github.proto-openapi.spec.v2@v1.0+protobuf Accept-Encoding: gzip</td>
  </tr>
</table>

 ([#59293](https://github.com/kubernetes/kubernetes/pull/59293), [@roycaihw](https://github.com/roycaihw))

# Other Notable Changes

### Apps

* Updated defaultbackend image to 1.4 and deployment apiVersion to apps/v1. Users should concentrate on updating scripts to the new version. ([#57866](https://github.com/kubernetes/kubernetes/pull/57866), [@zouyee](https://github.com/zouyee))

* Fix StatefulSet to work correctly with set-based selectors. ([#59365](https://github.com/kubernetes/kubernetes/pull/59365), [@ayushpateria](https://github.com/ayushpateria))

* Fixes a case when Deployment with recreate strategy could get stuck on old failed Pod. ([#60301](https://github.com/kubernetes/kubernetes/pull/60301), [@tnozicka](https://github.com/tnozicka))

* ConfigMap objects now support binary data via a new `binaryData` field. When using `kubectl create configmap --from-file`, files containing non-UTF8 data will be placed in this new field in order to preserve the non-UTF8 data. Note that kubectl's `--append-hash` feature doesn't take `binaryData` into account. Use of this feature requires 1.10+ apiserver and kubelets. ([#57938](https://github.com/kubernetes/kubernetes/pull/57938), [@dims](https://github.com/dims))

### AWS

* Add AWS cloud provider option to use an assumed IAM role. For example, this allows running Controller Manager in a account separate from the worker nodes, but still allows all resources created to interact with the workers. ELBs created would be in the same account as the worker nodes for instance.([#59668](https://github.com/kubernetes/kubernetes/pull/59668), [@brycecarman](https://github.com/brycecarman))

* AWS EBS volume plugin now includes block and volumeMode support. ([#58625](https://github.com/kubernetes/kubernetes/pull/58625), [@screeley44](https://github.com/screeley44))

* On AWS kubelet returns an error when started under conditions that do not allow it to work (AWS has not yet tagged the instance), rather than failing silently. ([#60125](https://github.com/kubernetes/kubernetes/pull/60125), [@vainu-arto](https://github.com/vainu-arto))

* AWS Security Groups created for ELBs will now be tagged with the same additional tags as the ELB; that is, the tags specified by the "service.beta.kubernetes.io/aws-load-balancer-additional-resource-tags" annotation. This is useful for identifying orphaned resources. ([#58767](https://github.com/kubernetes/kubernetes/pull/58767), [@2rs2ts](https://github.com/2rs2ts))

* AWS Network Load Balancers will now be deleted properly, including security group rules. Fixes [#57568](https://github.com/kubernetes/kubernetes/pull/57568) ([#57569](https://github.com/kubernetes/kubernetes/pull/57569), [@micahhausler](https://github.com/micahhausler))

* Time for attach/detach retry operations has been decreased from 10-12s to 2-6s ([#56974](https://github.com/kubernetes/kubernetes/pull/56974), [@gnufied](https://github.com/gnufied))

### Auth

* Contexts must be named in kubeconfigs. ([#56769](https://github.com/kubernetes/kubernetes/pull/56769), [@dixudx](https://github.com/dixudx))

* vSphere operations will no longer fail due to authentication errors. ([#57978](https://github.com/kubernetes/kubernetes/pull/57978), [@prashima](https://github.com/prashima))

* This removes the cloud-provider role and role binding from the rbac boostrapper and replaces it with a policy applied via addon mgr. This also creates a new clusterrole allowing the service account to create events for any namespace.

* client-go: alpha support for out-of-tree exec-based credential providers. For example, a cloud provider could create their own authentication system rather than using the standard authentication provided with Kubernetes. ([#59495](https://github.com/kubernetes/kubernetes/pull/59495), [@ericchiang](https://github.com/ericchiang))

* The node authorizer now allows nodes to request service account tokens for the service accounts of pods running on them. This allows agents using the node identity to take actions on behalf of local pods. ([#55019](https://github.com/kubernetes/kubernetes/pull/55019), [@mikedanese](https://github.com/mikedanese))

* kube-apiserver: the OpenID Connect authenticator can now verify ID Tokens signed with JOSE algorithms other than RS256 through the --oidc-signing-algs flag. ([#58544](https://github.com/kubernetes/kubernetes/pull/58544), [@ericchiang](https://github.com/ericchiang))

* Requests with invalid credentials no longer match audit policy rules where users or groups are set, correcting a problem where authorized requests were getting through. ([#59398](https://github.com/kubernetes/kubernetes/pull/59398), [@CaoShuFeng](https://github.com/CaoShuFeng))

* The Stackdriver Metadata Agent addon now includes RBAC manifests, enabling it to watch nodes and pods. ([#57455](https://github.com/kubernetes/kubernetes/pull/57455), [@kawych](https://github.com/kawych))

* Fix RBAC role for certificate controller to allow cleaning up of Certificate Signing Requests that are Approved and issued or Denied. ([#59375](https://github.com/kubernetes/kubernetes/pull/59375), [@mikedanese](https://github.com/mikedanese))

* kube-apiserver: Use of the `--admission-control-config-file` with a file containing an AdmissionConfiguration apiserver.k8s.io/v1alpha1 config object no longer leads to an error when launching kube-apiserver. ([#58439]([https://github.com/kubernetes/kubernetes/pull/58439](https://github.com/kubernetes/kubernetes/pull/58439)) [@liggitt](https://github.com/liggitt))

* Default enabled admission plugins are now `NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota`. Please note that if you previously had not set the `--admission-control` flag, your cluster behavior may change (to be more standard). ([#58684](https://github.com/kubernetes/kubernetes/pull/58684), [@hzxuzhonghu](https://github.com/hzxuzhonghu))

* Encryption key and encryption provider rotation now works properly. ([#58375](https://github.com/kubernetes/kubernetes/pull/58375), [@liggitt](https://github.com/liggitt)

* RBAC: The system:kubelet-api-admin cluster role can be used to grant full access to the kubelet API  so integrators can grant this role to the --kubelet-client-certificate credential given to the apiserver. ([#57128](https://github.com/kubernetes/kubernetes/pull/57128), [@liggitt](https://github.com/liggitt))

* DenyEscalatingExec admission controller now checks psp HostNetwork as well as hostIPC and hostPID. hostNetwork is also checked to deny exec /attach. ([#56839](https://github.com/kubernetes/kubernetes/pull/56839), [@hzxuzhonghu]=(https://github.com/hzxuzhonghu))

* When using Role-Based Access Control, the "admin", "edit", and "view" roles now have the expected permissions on NetworkPolicy resources, rather than reserving those permissions to only cluster-admin. ([#56650](https://github.com/kubernetes/kubernetes/pull/56650), [@danwinship](https://github.com/danwinship))

* Added docker-logins config to kubernetes-worker charm. ([#56217](https://github.com/kubernetes/kubernetes/pull/56217), [@Cynerva](https://github.com/Cynerva))

* Add ability to control primary GID of containers through Pod Spec at Pod level and Per Container SecurityContext level. ([#52077](https://github.com/kubernetes/kubernetes/pull/52077))

### CLI

* Use structured generator for kubectl autoscale.  ([#55913](https://github.com/kubernetes/kubernetes/pull/55913), [@wackxu](https://github.com/wackxu))

* Allow kubectl to set image|env on a cronjob ([#57742](https://github.com/kubernetes/kubernetes/pull/57742), [@soltysh](https://github.com/soltysh))

* Fixed crash in kubectl cp when path has multiple leading slashes. ([#58144](https://github.com/kubernetes/kubernetes/pull/58144), [@tomerf](https://github.com/tomerf))

* kubectl port-forward now allows using resource name (e.g., deployment/www) to select a matching pod, as well as the use of --pod-running-timeout to wait until at least one pod is running. ([#59705](https://github.com/kubernetes/kubernetes/pull/59705), [@phsiao](https://github.com/phsiao))

* 'cj' has been added as a shortname for CronJobs, as in `kubectl get cj` ([#59499](https://github.com/kubernetes/kubernetes/pull/59499), [@soltysh](https://github.com/soltysh))

* `crds` has been added as a shortname for CustomResourceDefinition, as in `kubectl get crds` ([#59061](https://github.com/kubernetes/kubernetes/pull/59061), [@nikhita](https://github.com/nikhita))

* Fix kubectl explain for resources not existing in default version of API group, such as  `batch/v1, Kind=CronJob`. ([#58753](https://github.com/kubernetes/kubernetes/pull/58753), [@soltysh](https://github.com/soltysh))

* Added the ability to select pods in a chosen node to be drained based on given pod label-selector. ([#56864](https://github.com/kubernetes/kubernetes/pull/56864), [@juanvallejo](https://github.com/juanvallejo))

* Kubectl explain now prints out the Kind and API version of the resource being explained. ([#55689](https://github.com/kubernetes/kubernetes/pull/55689), [@luksa](https://github.com/luksa))

### Cluster Lifecycle

* The default Kubernetes version for kubeadm is now 1.10. ([#61127](https://github.com/kubernetes/kubernetes/pull/61127), [@timothysc](https://github.com/timothysc))

* The minimum Kubernetes version in kubeadm is now v1.9.0. ([#57233](https://github.com/kubernetes/kubernetes/pull/57233), [@xiangpengzhao](https://github.com/xiangpengzhao))

* Fixes a bug in Heapster deployment for google sink. ([#57902](https://github.com/kubernetes/kubernetes/pull/57902), [@kawych](https://github.com/kawych))

* On cluster provision or upgrade, kubeadm now generates certs and secures all connections to the etcd static-pod with mTLS. This includes the etcd serving cert, the etcd peer cert, and the apiserver etcd client cert. Flags and hostMounts are added to the etcd and apiserver static-pods to load these certs. For connections to etcd, https is now used in favor of http. ([#57415](https://github.com/kubernetes/kubernetes/pull/57415), [@stealthybox](https://github.com/stealthybox) These certs are also generated on upgrade.  ([#60385](https://github.com/kubernetes/kubernetes/pull/60385), [@stealthybox](https://github.com/stealthybox))

* Demoted controlplane passthrough flags apiserver-extra-args, controller-manager-extra-args, scheduler-extra-args to alpha flags ([#59882](https://github.com/kubernetes/kubernetes/pull/59882), [@kris-nova](https://github.com/kris-nova))

* The new flag `--apiserver-advertise-dns-address` is used in the node's kubelet.confg to point to the API server, allowing users to define a DNS entry instead of an IP address. ([#59288](https://github.com/kubernetes/kubernetes/pull/59288), [@stevesloka](https://github.com/stevesloka))

* MasterConfiguration manifiest The criSocket flag is now usable within the `MasterConfiguration` and `NodeConfiguration` manifest files that exist for configuring kubeadm. Before it only existed as a command line flag and was not able to be configured when using the `--config` flag and the manifest files. ([#59057](https://github.com/kubernetes/kubernetes/pull/59057)([#59292](https://github.com/kubernetes/kubernetes/pull/59292), [@JordanFaust](https://github.com/JordanFaust))

* `kubeadm init` can now omit the tainting of the master node if configured to do so in `kubeadm.yaml` using `noTaintMaster: true`. For example, uses can create a file with the content:

```
apiVersion: [kubeadm.k8s.io/v1alpha1](http://kubeadm.k8s.io/v1alpha1)
kind: MasterConfiguration
kubernetesVersion: v1.9.1
noTaintMaster: true
```

And point to the file using the --config flag, as in 

`kubeadm init --config /etc/kubeadm/kubeadm.yaml`

([#55479](https://github.com/kubernetes/kubernetes/pull/55479), [@ijc](https://github.com/ijc))

* kubeadm: New "imagePullPolicy" option in the init configuration file, that gets forwarded to kubelet static pods to control pull policy for etcd and control plane images. This option allows for precise image pull policy specification for master nodes and thus for more tight control over images. It is useful in CI environments and in environments, where the user has total control over master VM templates (thus, the master VM templates can be preloaded with the required Docker images for the control plane services). ([#58960](https://github.com/kubernetes/kubernetes/pull/58960), [@rosti](https://github.com/rosti))

* Fixed issue with charm upgrades resulting in an error state. ([#59064](https://github.com/kubernetes/kubernetes/pull/59064), [@hyperbolic2346](https://github.com/hyperbolic2346))

* kube-apiserver --advertise-address is now set using downward API for self-hosted Kubernetes with kubeadm. ([#56084](https://github.com/kubernetes/kubernetes/pull/56084), [@andrewsykim](https://github.com/andrewsykim))

* When using client or server certificate rotation, the Kubelet will no longer wait until the initial rotation succeeds or fails before starting static pods.  This makes running self-hosted masters with rotation more predictable. ([#58930](https://github.com/kubernetes/kubernetes/pull/58930), [@smarterclayton](https://github.com/smarterclayton))

* Kubeadm no longer throws an error for the --cloud-provider=external flag. ([#58259](https://github.com/kubernetes/kubernetes/pull/58259), [@dims](https://github.com/dims))

* Added support for network spaces in the kubeapi-load-balancer charm. ([#58708](https://github.com/kubernetes/kubernetes/pull/58708), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Added support for network spaces in the kubernetes-master charm. ([#58704](https://github.com/kubernetes/kubernetes/pull/58704), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Added support for network spaces in the kubernetes-worker charm. ([#58523](https://github.com/kubernetes/kubernetes/pull/58523), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Added support for changing nginx and default backend images to kubernetes-worker config. ([#58542](https://github.com/kubernetes/kubernetes/pull/58542), [@hyperbolic2346](https://github.com/hyperbolic2346))

* kubeadm now accepts `--apiserver-extra-args`, `--controller-manager-extra-args` and `--scheduler-extra-args`, making it possible to override / specify additional flags for control plane components. One good example is to deploy Kubernetes with a different admission-control flag on API server. ([#58080](https://github.com/kubernetes/kubernetes/pull/58080), [@simonferquel](https://github.com/simonferquel))

* Alpha Initializers have been removed from kubadm admission control.  Kubeadm users who still want to use Initializers can use apiServerExtraArgs through the kubeadm config file to enable it when booting up the cluster. ([#58428](https://github.com/kubernetes/kubernetes/pull/58428), [@dixudx](https://github.com/dixudx))

* ValidatingAdmissionWebhook and MutatingAdmissionWebhook are beta, and are enabled in kubeadm by default. ([#58255](https://github.com/kubernetes/kubernetes/pull/58255), [@dixudx](https://github.com/dixudx))

* Add proxy_read_timeout flag to kubeapi_load_balancer charm. ([#57926](https://github.com/kubernetes/kubernetes/pull/57926), [@wwwtyro](https://github.com/wwwtyro))

* Check for known manifests during preflight instead of only checking for non-empty manifests directory. This makes the preflight checks less heavy-handed by specifically checking for well-known files (kube-apiserver.yaml, kube-controller-manager.yaml, kube-scheduler.yaml, etcd.yaml) in /etc/kubernetes/manifests instead of simply checking for a non-empty directory. ([#57287](https://github.com/kubernetes/kubernetes/pull/57287), [@mattkelly](https://github.com/mattkelly))

* PVC Protection alpha feature was renamed to Storage Protection. The Storage Protection feature is beta. ([#59052](https://github.com/kubernetes/kubernetes/pull/59052), [@pospispa](https://github.com/pospispa))

* iSCSI sessions managed by kubernetes will now explicitly set startup.mode to 'manual' to  prevent automatic login after node failure recovery. This is the default open-iscsi mode, so this change will only impact users who have changed their startup.mode to be 'automatic' in /etc/iscsi/iscsid.conf. ([#57475](https://github.com/kubernetes/kubernetes/pull/57475), [@stmcginnis](https://github.com/stmcginnis))

* The IPVS feature gateway is now enabled by default in kubeadm, which makes the  --feature-gates=SupportIPVSProxyMode=true obsolete, and it is no longer supported. ([#60540](https://github.com/kubernetes/kubernetes/pull/60540), [@m1093782566](https://github.com/m1093782566))

### GCP

* ingress-gce image in glbc.manifest updated to 1.0.0 ([#61302](https://github.com/kubernetes/kubernetes/pull/61302), [@rramkumar1](https://github.com/rramkumar1))

### Instrumentation

* For advanced auditing, audit policy supports subresources wildcard matching, such as "resource/", "/subresource","*". ([#55306](https://github.com/kubernetes/kubernetes/pull/55306), [@hzxuzhonghu](https://github.com/hzxuzhonghu))

* [Auditing](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/) is now enabled behind a featureGate in kubeadm. A user can supply their own audit policy with configuration option as well as a place for the audit logs to live. If no policy is supplied a default policy will be provided. The default policy will log all Metadata level policy logs. It is the example provided in the documentation. ([#59067](https://github.com/kubernetes/kubernetes/pull/59067), [@chuckha](https://github.com/chuckha))

* Reduce Metrics Server memory requirement from 140Mi + 4Mi per node to 40Mi + 4Mi per node. ([#58391](https://github.com/kubernetes/kubernetes/pull/58391), [@kawych](https://github.com/kawych))

* Annotations is added to advanced audit api. ([#58806](https://github.com/kubernetes/kubernetes/pull/58806), [@CaoShuFeng](https://github.com/CaoShuFeng))

* Reorganized iptables rules to fix a performance regression on clusters with thousands of services. ([#56164](https://github.com/kubernetes/kubernetes/pull/56164), [@danwinship](https://github.com/danwinship))

* Container runtime daemon (e.g. dockerd) logs in GCE cluster will be uploaded to stackdriver and elasticsearch with tag `container-runtime`. ([#59103](https://github.com/kubernetes/kubernetes/pull/59103), [@Random-Liu](https://github.com/Random-Liu))

* Enable prometheus apiserver metrics for custom resources. ([#57682](https://github.com/kubernetes/kubernetes/pull/57682), [@nikhita](https://github.com/nikhita))

* Add apiserver metric for number of requests dropped because of inflight limit, making it easier to figure out on which dimension the master is overloaded. ([#58340](https://github.com/kubernetes/kubernetes/pull/58340), [@gmarek](https://github.com/gmarek))

* The Metrics Server now exposes metrics via the /metric endpoint. These metrics are in the prometheus format.  ([#57456](https://github.com/kubernetes/kubernetes/pull/57456), [@kawych](https://github.com/kawych))

* Reduced the CPU and memory requests for the Metrics Server Nanny sidecar container to free up unused resources.  ([#57252](https://github.com/kubernetes/kubernetes/pull/57252), [@kawych](https://github.com/kawych))

* Enabled log rotation for load balancer's api logs to prevent running out of disk space. ([#56979](https://github.com/kubernetes/kubernetes/pull/56979), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Fixed `etcd-version-monitor` to backward compatibly support etcd 3.1 [go-grpc-prometheus](https://github.com/grpc-ecosystem/go-grpc-prometheus) metrics format. ([#56871](https://github.com/kubernetes/kubernetes/pull/56871), [@jpbetz](https://github.com/jpbetz))

### Node

* Summary of Container Runtime changes:
  * [beta] [cri-tools](https://github.com/kubernetes-incubator/cri-tools): CLI and validation tools for CRI is now v1.0.0-beta.0. This release mainly focused on UX improvements. [@feiskyer]
  * [stable] [containerd](https://github.com/containerd/containerd): containerd v1.1 natively supports CRI v1alpha2 now, so users can use Kubernetes v1.10 with containerd v1.1 directly, without having to use the intermediate cri-containerd daemon. [All Kubernetes 1.10 tests passed](https://k8s-testgrid.appspot.com/sig-node-containerd). [@Random-Liu]
  * [stable] [cri-o](https://github.com/kubernetes-incubator/cri-o): cri-o v1.10 updated CRI version to v1alpha2 and made several bug and stability fixes. [@mrunalp]
  * [stable] [frakti](https://github.com/kubernetes/frakti): frakti v1.10 implemented GCE Persistent Disk as a high performance volume, fixed several bugs, added ARM64 support, and passed all CRI validation conformance tests and node e2e conformance tests. [@resouer]

* Fixed race conditions around devicemanager Allocate() and endpoint deletion. ([#60856](https://github.com/kubernetes/kubernetes/pull/60856), [@jiayingz](https://github.com/jiayingz))

* kubelet initial flag parse now normalizes flags instead of exiting.  ([#61053](https://github.com/kubernetes/kubernetes/pull/61053), [@andrewsykim](https://github.com/andrewsykim))

* Fixed regression where kubelet --cpu-cfs-quota flag did not work when --cgroups-per-qos was enabled ([#61294](https://github.com/kubernetes/kubernetes/pull/61294), [@derekwaynecarr](https://github.com/derekwaynecarr))

* Kubelet now supports container log rotation for container runtimes implementing CRI (container runtime interface).  The feature can be enabled with feature gate `CRIContainerLogRotation`. The flags `--container-log-max-size` and `--container-log-max-files` can be used to configure the rotation behavior. ([#59898](https://github.com/kubernetes/kubernetes/pull/59898), [@Random-Liu](https://github.com/Random-Liu))

* Fixed a bug where if an error was returned that was not an `autorest.DetailedError` we would return `"not found", nil` which caused nodes to go to `NotReady` state. ([#57484](https://github.com/kubernetes/kubernetes/pull/57484), [@brendandburns](https://github.com/brendandburns))

* [HugePages](https://kubernetes.io/docs/tasks/manage-hugepages/scheduling-hugepages/) feature is beta, and thus enabled by default. ([#56939](https://github.com/kubernetes/kubernetes/pull/56939), [@derekwaynecarr](https://github.com/derekwaynecarr))

* Avoid panic when failing to allocate a Cloud CIDR (aka GCE Alias IP Range).  ([#58186](https://github.com/kubernetes/kubernetes/pull/58186), [@negz](https://github.com/negz))

* 'none' can now be specified in KubeletConfiguration.EnforceNodeAllocatable (--enforce-node-allocatable) to explicitly disable enforcement. ([#59515](https://github.com/kubernetes/kubernetes/pull/59515), [@mtaufen](https://github.com/mtaufen))

* The alpha KubeletConfiguration.ConfigTrialDuration field is no longer available. It can still be set using the dynamic configuration alpha feature. ([#59628](https://github.com/kubernetes/kubernetes/pull/59628), [@mtaufen](https://github.com/mtaufen))

* Summary API will include pod CPU and Memory stats for CRI container runtime. ([#60328](https://github.com/kubernetes/kubernetes/pull/60328), [@Random-Liu](https://github.com/Random-Liu))

* Some field names in the Kubelet's now v1beta1 config API differ from the v1alpha1 API: for example, PodManifestPath is renamed to StaticPodPath, ManifestURL is renamed to StaticPodURL, and ManifestURLHeader is renamed to StaticPodURLHeader. Users should focus on switching to the v1beta1 API. ([#60314](https://github.com/kubernetes/kubernetes/pull/60314), [@mtaufen](https://github.com/mtaufen))

* The DevicePlugins feature has graduated to beta, and is now enabled by default; users should focus on moving to the v1beta API if possible. ([#60170](https://github.com/kubernetes/kubernetes/pull/60170), [@jiayingz](https://github.com/jiayingz))

* Per-cpu metrics have been disabled by default for to improve scalability. ([#60106](https://github.com/kubernetes/kubernetes/pull/60106), [@dashpole](https://github.com/dashpole))

* When the `PodShareProcessNamespace` alpha feature is enabled, setting `pod.Spec.ShareProcessNamespace` to `true` will cause a single process namespace to be shared between all containers in a pod. ([#58716](https://github.com/kubernetes/kubernetes/pull/58716), [@verb](https://github.com/verb))

* Resource quotas on extended resources such as GPUs are now supported. ([#57302](https://github.com/kubernetes/kubernetes/pull/57302), [@lichuqiang](https://github.com/lichuqiang))

* If the TaintNodesByCondition is enabled, a node will be tainted when it is under PID pressure.  ([#60008](https://github.com/kubernetes/kubernetes/pull/60008), [@k82cn](https://github.com/k82cn))

* The Kubelet Summary API will now include total usage of pods through the "pods" SystemContainer. ([#57802](https://github.com/kubernetes/kubernetes/pull/57802), [@dashpole](https://github.com/dashpole))

* vSphere Cloud Provider supports VMs provisioned on vSphere v6.5. ([#59519](https://github.com/kubernetes/kubernetes/pull/59519), [@abrarshivani](https://github.com/abrarshivani))

* Created k8s.gcr.io image repo alias to pull images from the closest regional repo. Replaces gcr.io/google_containers. ([#57824](https://github.com/kubernetes/kubernetes/pull/57824), [@thockin](https://github.com/thockin))

* Fix the bug where kubelet in the standalone mode would wait for the update from the apiserver source, even if there wasn't one. ([#59276](https://github.com/kubernetes/kubernetes/pull/59276), [@roboll](https://github.com/roboll))

* Changes secret, configMap, downwardAPI and projected volumes to mount read-only, instead of allowing applications to write data and then reverting it automatically. Until version 1.11, setting the feature gate ReadOnlyAPIDataVolumes=false will preserve the old behavior. ([#58720](https://github.com/kubernetes/kubernetes/pull/58720), [@joelsmith](https://github.com/joelsmith))

* Fixes a bug where kubelet crashes trying to free memory under memory pressure. ([#58574](https://github.com/kubernetes/kubernetes/pull/58574), [@yastij](https://github.com/yastij))

* New alpha feature limits the number of processes running in a pod. Cluster administrators will be able to place limits by using the new kubelet command line parameter --pod-max-pids. Note that since this is a alpha feature they will need to enable the "SupportPodPidsLimit" feature. By default, we do not set any maximum limit, If an administrator wants to enable this, they should enable SupportPodPidsLimit=true in the --feature-gates= parameter to kubelet and specify the limit using the --pod-max-pids parameter. The limit set is the total count of all processes running in all containers in the pod. ([#57973](https://github.com/kubernetes/kubernetes/pull/57973),[@dims](https://github.com/dims))

* Fixes bug finding master replicas in GCE when running multiple Kubernetes clusters. ([#58561](https://github.com/kubernetes/kubernetes/pull/58561), [@jesseshieh](https://github.com/jesseshieh))

* --tls-min-version on kubelet and kube-apiserver allow for configuring minimum TLS versions ([#58528](https://github.com/kubernetes/kubernetes/pull/58528), [@deads2k](https://github.com/deads2k))

* Fix a bug affecting nested data volumes such as secret, configmap, etc. ([#57422](https://github.com/kubernetes/kubernetes/pull/57422), [@joelsmith](https://github.com/joelsmith))

* kubelet will no longer attempt to remove images being used by running containers when garbage collecting. ([#57020](https://github.com/kubernetes/kubernetes/pull/57020), [@dixudx](https://github.com/dixudx))

* Allow kubernetes components to react to SIGTERM signal and shutdown gracefully. ([#57756](https://github.com/kubernetes/kubernetes/pull/57756), [@mborsz](https://github.com/mborsz))

* Fixed garbage collection and resource quota issue when the controller-manager uses --leader-elect=false ([#57340](https://github.com/kubernetes/kubernetes/pull/57340), [@jmcmeek](https://github.com/jmcmeek))

* Fixed issue creating docker secrets with kubectl 1.9 for accessing docker private registries. ([#57463](https://github.com/kubernetes/kubernetes/pull/57463), [@dims](https://github.com/dims))

* The CPU Manager feature is now beta, and is enabled by default, but the default policy is no-op so no action is required. ([#55977](https://github.com/kubernetes/kubernetes/pull/55977), [@ConnorDoyle](https://github.com/ConnorDoyle))

### OpenStack

* Fixed a bug in the OpenStack cloud provider where dual stack deployments (IPv4 and IPv6) did not work well when using kubenet as the network plugin. ([#59749](https://github.com/kubernetes/kubernetes/pull/59749), [@zioproto](https://github.com/zioproto))

* Fixed a bug that tries to use the octavia client to query flip. ([#59075](https://github.com/kubernetes/kubernetes/pull/59075), [@jrperritt](https://github.com/jrperritt))

* Kubernetes now registers metadata.hostname as node name for OpenStack nodes, eliminating a problem with invalid node names. ([#58502](https://github.com/kubernetes/kubernetes/pull/58502), [@dixudx](https://github.com/dixudx))

* Authentication information for OpenStack cloud provider can now be specified as environment variables. When we convert the OpenStack cloud provider to run in an external process, we can now use the kubernetes Secrets capability to inject the OS_* variables. This way we can specify the cloud configuration as a configmap, and specify secrets for the userid/password information. The configmap is mounted as a file, and the secrets are made available as environment variables. The external controller itself runs as a pod/daemonset. For backward compatibility, we preload all the OS_* variables, and if anything is in the config file, then that overrides the environment variables. ([#58300](https://github.com/kubernetes/kubernetes/pull/58300), [@dims](https://github.com/dims))

* Fixed issue when using OpenStack config drive for node metadata. Since we need to run commands such as blkid, we need to ensure that api server and kube controller are running in the privileged mode. ([#57561](https://github.com/kubernetes/kubernetes/pull/57561), [@dims](https://github.com/dims))

* Orphaned routes are properly removed from terminated instances. ([#56258](https://github.com/kubernetes/kubernetes/pull/56258), [@databus23](https://github.com/databus23))

* OpenStack Cinder will now detach properly when Nova is shut down. ([#56846](https://github.com/kubernetes/kubernetes/pull/56846), [@zetaab](https://github.com/zetaab))
### Scalability

* Added the ability to limit the increase in apiserver memory usage when audit logging with buffering is enabled. ([#61118](https://github.com/kubernetes/kubernetes/pull/61118), [@shyamjvs](https://github.com/shyamjvs))

* Upgrade to etcd client 3.2.13 and grpc 1.7.5 to improve HA etcd cluster stability. ([#57480](https://github.com/kubernetes/kubernetes/pull/57480), [@jpbetz](https://github.com/jpbetz))

### Storage

* Fixes CVE-2017-1002101 - See [https://issue.k8s.io/60813](https://issue.k8s.io/60813) for details on this **major security fix**. ([#61044](https://github.com/kubernetes/kubernetes/pull/61044), [@liggitt](https://github.com/liggitt))

* Fixed missing error checking that could cause kubelet to crash in a race condition. ([#60962](https://github.com/kubernetes/kubernetes/pull/60962), [@technicianted](https://github.com/technicianted))

* Fixed a regression that prevented using `subPath` volume mounts with secret, configMap, projected, and downwardAPI volumes. ([#61080](https://github.com/kubernetes/kubernetes/pull/61080), [@liggitt](https://github.com/liggitt))

* K8s supports cephfs fuse mount. ([#55866](https://github.com/kubernetes/kubernetes/pull/55866), [@zhangxiaoyu-zidif](https://github.com/zhangxiaoyu-zidif))

* Use GiB unit for creating and resizing volumes for Glusterfs. ([#56581](https://github.com/kubernetes/kubernetes/pull/56581), [@gnufied](https://github.com/gnufied))

* Adding support for Block Volume type to rbd plugin. ([#56651](https://github.com/kubernetes/kubernetes/pull/56651), [@sbezverk](https://github.com/sbezverk))

* Add FSType for CSI volume source to specify filesystems (alpha defaults to ext4) ([#58209](https://github.com/kubernetes/kubernetes/pull/58209), [@NickrenREN](https://github.com/NickrenREN))

* Enabled File system resize of mounted volumes. ([#58794](https://github.com/kubernetes/kubernetes/pull/58794), [@gnufied](https://github.com/gnufied))

* The Local Volume Plugin has been updated to support Block volumeMode PVs. With this change, it is now possible to create local volume PVs for raw block devices. ([#59303](https://github.com/kubernetes/kubernetes/pull/59303), [@dhirajh](https://github.com/dhirajh))

* Fixed an issue where Portworx volume driver wasn't passing namespace and annotations to the Portworx Create API. ([#59607](https://github.com/kubernetes/kubernetes/pull/59607), [@harsh-px](https://github.com/harsh-px))

* Addressed breaking changes introduced by new 0.2.0 release of CSI spec. Specifically, csi.Version was removed from all API calls and CcontrollerProbe and NodeProbe were consolidated into a single Probe API call. ([#59209](https://github.com/kubernetes/kubernetes/pull/59209), [@sbezverk](https://github.com/sbezverk))

* GCE PD volume plugin now supports block volumes. ([#58710](https://github.com/kubernetes/kubernetes/pull/58710), [@screeley44](https://github.com/screeley44))

* Implements MountDevice and UnmountDevice for the CSI Plugin, the functions will call through to NodeStageVolume/NodeUnstageVolume for CSI plugins. ([#60115](https://github.com/kubernetes/kubernetes/pull/60115), [@davidz627](https://github.com/davidz627))

* The LocalStorageCapacityIsolation feature is beta and enabled by default.  The LocalStorageCapacityIsolation feature added a new resource type ResourceEphemeralStorage "ephemeral-storage" so that this resource can be allocated, limited, and consumed as the same way as CPU/memory. All the features related to resource management (resource request/limit, quota, limitrange) are available for local ephemeral storage. This local ephemeral storage represents the storage for root file system, which will be consumed by containers' writable layer and logs. Some volumes such as emptyDir might also consume this storage. ([#60159](https://github.com/kubernetes/kubernetes/pull/60159), [@jingxu97](https://github.com/jingxu97))

* VolumeScheduling and LocalPersistentVolume features are beta and enabled by default.  The PersistentVolume NodeAffinity alpha annotation is deprecated and will be removed in a future release. ([#59391](https://github.com/kubernetes/kubernetes/pull/59391), [@msau42](https://github.com/msau42))

* K8s now supports rbd-nbd for Ceph rbd volume mounts. ([#58916](https://github.com/kubernetes/kubernetes/pull/58916), [@ianchakeres](https://github.com/ianchakeres))

* CSI now allows credentials to be specified on CreateVolume/DeleteVolume, ControllerPublishVolume/ControllerUnpublishVolume, and NodePublishVolume/NodeUnpublishVolume operations. Before this change all API calls had to fetch key/value stored in secret and use it to authenticate/authorize these operations. With this change API calls receive key/value as a input parameter so they not need to know where and how credentials were stored and fetched. Main goal was to make these API calls CO (Container Orchestrator) agnostic.  ([#60118](https://github.com/kubernetes/kubernetes/pull/60118), [@sbezverk](https://github.com/sbezverk))

* StorageOS volume plugin has been updated to support mount options and environments where the kubelet runs in a container and the device location should be specified. ([#58816](https://github.com/kubernetes/kubernetes/pull/58816), [@croomes](https://github.com/croomes))

* Get parent dir via canonical absolute path when trying to judge mount-point, fixing a problem that caused an NFS volume with improper permissions to get stuck in `TERMINATING` status. ([#58433](https://github.com/kubernetes/kubernetes/pull/58433), [@yue9944882]](https://github.com/yue9944882))

* Clusters with GCE feature 'DiskAlphaAPI' enabled can now dynamically provision GCE PD volumes. ([#59447](https://github.com/kubernetes/kubernetes/pull/59447), [@verult](https://github.com/verult))

* Added `keyring` parameter for Ceph RBD provisioner. ([#58287](https://github.com/kubernetes/kubernetes/pull/58287), [@madddi](https://github.com/madddi))

* Added xfsprogs to hyperkube container image. ([#56937](https://github.com/kubernetes/kubernetes/pull/56937), [@redbaron](https://github.com/redbaron))

* Improved messages user gets during and after volume resizing is done, providing a clear message to the user explaining what to do when resizing is finished. ([#58415](https://github.com/kubernetes/kubernetes/pull/58415), [@gnufied](https://github.com/gnufied))

* MountPropagation feature is now beta. As consequence, all volume mounts in containers are now "rslave" on Linux by default. To make this default work in all Linux environments you should have entire mount tree marked as shareable via "mount --make-rshared /". All Linux distributions that use systemd already have root directory mounted as rshared and hence they need not do anything. In Linux environments without systemd we  recommend running "mount --make-rshared /" during boot, before docker is started. ([#59252](https://github.com/kubernetes/kubernetes/pull/59252), [@jsafrane](https://github.com/jsafrane))

* Volume metrics support for vSphere Cloud Provider has been added. You can now monitor available space, capacity, and used space on volumes created using vSphere. ([#59328](https://github.com/kubernetes/kubernetes/pull/59328), [@divyenpatel](https://github.com/divyenpatel))

* Emit number of bound and unbound persistent volumes as Metrics. This PR adds four kinds of Volume Metrics for kube-controller-manager: bound PVC numbers, unbound PVC numbers, bound PV numbers and unbound PV numbers. The PVC metrics use namespace as dimension and the PV metrics use StorageClassName as its dimension. With these metrics we can better monitor the use of volumes in the cluster. ([#57872](https://github.com/kubernetes/kubernetes/pull/57872), [@mlmhl](https://github.com/mlmhl))

* Add windows config to Kubelet CRI so that WindowsContainerResources can be managed. ([#57076](https://github.com/kubernetes/kubernetes/pull/57076), [@feiskyer](https://github.com/feiskyer))

* PersistentVolumes that are bound to a PersistentVolumeClaim will not be deleted. ([#58743](https://github.com/kubernetes/kubernetes/pull/58743), [@NickrenREN](https://github.com/NickrenREN))

* The VolumeAttachment API is now available as V1beta1, and is enabled by default. The Alpha API is deprecated and will be removed in a future release.  ([#58462](https://github.com/kubernetes/kubernetes/pull/58462), [@NickrenREN](https://github.com/NickrenREN))

* Add storage-backend configuration option to kubernetes-master charm. ([#58830](https://github.com/kubernetes/kubernetes/pull/58830), [@wwwtyro](https://github.com/wwwtyro))

* Fixed dynamic provisioning of GCE PDs to round to the next GB (base 1000) instead of GiB (base 1024). ([#56600](https://github.com/kubernetes/kubernetes/pull/56600), [@edisonxiang](https://github.com/edisonxiang))

* PersistentVolume flexVolume sources can now reference secrets in a namespace other than the PersistentVolumeClaim's namespace. ([#56460](https://github.com/kubernetes/kubernetes/pull/56460), [@liggitt](https://github.com/liggitt))

### Windows

* kubelet and kube-proxy can now be run as native Windows services. ([#60144](https://github.com/kubernetes/kubernetes/pull/60144), [@alinbalutoiu](https://github.com/alinbalutoiu))

* WindowsContainerResources is set now for windows containers. ([#59333](https://github.com/kubernetes/kubernetes/pull/59333), [@feiskyer](https://github.com/feiskyer))

* Disable mount propagation for windows containers (because it is not supported by the OS). ([#60275](https://github.com/kubernetes/kubernetes/pull/60275), [@feiskyer](https://github.com/feiskyer))

* Fix image file system stats for windows nodes. ([#59743](https://github.com/kubernetes/kubernetes/pull/59743), [@feiskyer](https://github.com/feiskyer))

* Kubernetes will now return an error if New-SmbGlobalMapping failed when mounting an azure file on Windows. ([#59540](https://github.com/kubernetes/kubernetes/pull/59540), [@andyzhangx](https://github.com/andyzhangx))

* Kubernetes now uses the more reliable GlobalMemoryStatusEx to get total physical memory on windows nodes. ([#57124](https://github.com/kubernetes/kubernetes/pull/57124), [@JiangtianLi](https://github.com/JiangtianLi))

* Windows containers now support experimental Hyper-V isolation by setting annotation `experimental.windows.kubernetes.io/isolation-type=hyperv` and feature gates HyperVContainer. At the moment this function only supports one container per pod. ([#58751]([https://github.com/kubernetes/kubernetes/pull/58751](https://github.com/kubernetes/kubernetes/pull/58751)), [@feiskyer](https://github.com/feiskyer))

* Get windows kernel version directly from registry rather than windows.getVersion(). ([#58498](https://github.com/kubernetes/kubernetes/pull/58498), [@feiskyer](https://github.com/feiskyer))

* Fixed controller manager crash when using mixed case names in a vSphere cloud provider environment. ([#57286](https://github.com/kubernetes/kubernetes/pull/57286), [@rohitjogvmw](https://github.com/rohitjogvmw))

* Flexvolume is now [enabled on Windows nodes](https://github.com/andyzhangx/Demo/tree/master/windows/flexvolume). ([#56921](https://github.com/kubernetes/kubernetes/pull/56921), [@andyzhangx](https://github.com/andyzhangx))

### Autoscaling

* The getSubnetIDForLB() returns subnet id rather than net id. ([#58208](https://github.com/kubernetes/kubernetes/pull/58208), [@FengyunPan](https://github.com/FengyunPan))

* `kubectl scale` can now scale any resource (kube, CRD, aggregate) conforming to the standard scale endpoint ([#58298](https://github.com/kubernetes/kubernetes/pull/58298), [@p0lyn0mial](https://github.com/p0lyn0mial))

* Cluster Autoscaler has been updated to Version 1.2.0, which includes fixes around GPUs and base image change. See [https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-](https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.1.2)1.2.0for details. ([#60842](https://github.com/kubernetes/kubernetes/pull/60842), [@mwielgus](https://github.com/mwielgus))

* Allows HorizontalPodAutoscaler to use global metrics not associated with any Kubernetes object (for example metrics from a hosting service running outside of the Kubernetes cluster). ([#60096](https://github.com/kubernetes/kubernetes/pull/60096), [@MaciekPytel](https://github.com/MaciekPytel))

* fluentd-gcp resources can be modified via a ScalingPolicy. ([#59657](https://github.com/kubernetes/kubernetes/pull/59657), [@x13n](https://github.com/x13n))

* Added anti-affinity to kube-dns pods. Otherwise the "no single point of failure" setting doesn't actually work (a single node failure can still take down the entire cluster). ([#57683](https://github.com/kubernetes/kubernetes/pull/57683), [@vainu-arto](https://github.com/vainu-arto))

### API-Machinery

* Fixed webhooks to use the scheme provided in clientConfig, instead of defaulting to http. ([#60943](https://github.com/kubernetes/kubernetes/pull/60943), [@jennybuckley](https://github.com/jennybuckley))

* The webhook admission controller in a custom apiserver now works off-the-shelf. ([#60995](https://github.com/kubernetes/kubernetes/pull/60995), [@caesarxuchao](https://github.com/caesarxuchao))

* Upgrade the default etcd server version to 3.1.12 to pick up critical etcd "mvcc "unsynced" watcher restore operation" fix. ([#60998](https://github.com/kubernetes/kubernetes/pull/60998), [@jpbetz](https://github.com/jpbetz))

* Fixed bug allowing garbage collector to enter a broken state that could only be fixed by restarting the controller-manager. ([#61201](https://github.com/kubernetes/kubernetes/pull/61201), [@jennybuckley](https://github.com/jennybuckley))

* kube-apiserver: The external hostname no longer longer use the cloud provider API to select a default. It can be set explicitly using --external-hostname, if needed. If there is no default, AdvertiseAddress or os.Hostname() will be used, in that order. ([#56812](https://github.com/kubernetes/kubernetes/pull/56812), [@dims](https://github.com/dims))

* Custom resources can be listed with a set of grouped resources (category) by specifying the categories in the [CustomResourceDefinition spec](https://kubernetes.io/docs/tasks/access-kubernetes-api/extend-api-custom-resource-definitions/#categories). Example: They can be used with `kubectl get important`, where `important` is a category. ([#59561](https://github.com/kubernetes/kubernetes/pull/59561), [@nikhita](https://github.com/nikhita))

* Fixed an issue making it possible to create a situation in which two webhooks make it impossible to delete each other. ValidatingWebhooks and MutatingWebhooks will not be called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects in the admissionregistration.k8s.io group ([#59840](https://github.com/kubernetes/kubernetes/pull/59840), [@jennybuckley](https://github.com/jennybuckley))

* Fixed potential deadlock when deleting CustomResourceDefinition for custom resources with finalizers. ([#60542](https://github.com/kubernetes/kubernetes/pull/60542), [@liggitt](https://github.com/liggitt))

* A buffered audit backend can be used with other audit backends. ([#60076](https://github.com/kubernetes/kubernetes/pull/60076), [@crassirostris](https://github.com/crassirostris))

* Introduced `--http2-max-streams-per-connection` command line flag on api-servers and set default to 1000 for aggregated API servers. ([#60054](https://github.com/kubernetes/kubernetes/pull/60054), [@MikeSpreitzer](https://github.com/MikeSpreitzer))

* APIserver backed by etcdv3 exports metric shows number of resources per kind. ([#59757](https://github.com/kubernetes/kubernetes/pull/59757), [@gmarek](https://github.com/gmarek))

* Add `kubectl create job --from-cronjob` command. ([#60084](https://github.com/kubernetes/kubernetes/pull/60084), [@soltysh](https://github.com/soltysh))

* `/status` and `/scale` subresources have been added for custom resources. See [https://github.com/kubernetes/kubernetes/pull/55168](https://github.com/kubernetes/kubernetes/pull/55168) for more details. ([#55168](https://github.com/kubernetes/kubernetes/pull/55168), [@nikhita](https://github.com/nikhita))

* Restores the ability of older clients to delete and scale jobs with initContainers. ([#59880](https://github.com/kubernetes/kubernetes/pull/59880), [@liggitt](https://github.com/liggitt))

* Fixed a race condition causing apiserver crashes during etcd healthchecking. ([#60069](https://github.com/kubernetes/kubernetes/pull/60069), [@wojtek-t](https://github.com/wojtek-t))

* Fixed a race condition in k8s.io/client-go/tools/cache.SharedInformer that could violate the sequential delivery guarantee and cause panics on shutdown in Kubernetes 1.8.* and 1.9.*. ([#59828](https://github.com/kubernetes/kubernetes/pull/59828), [@krousey](https://github.com/krousey))

* Add automatic etcd 3.2->3.1 and 3.1->3.0 minor version rollback support to gcr.io/google_container/etcd images. For HA clusters, all members must be stopped before performing a rollback. ([#59298](https://github.com/kubernetes/kubernetes/pull/59298), [@jpbetz](https://github.com/jpbetz))

* The `meta.k8s.io/v1alpha1` objects for retrieving tabular responses from the server (`Table`) or fetching just the `ObjectMeta` for an object (as `PartialObjectMetadata`) are now beta as part of `meta.k8s.io/v1beta1` and configurations must be changed to use the new API.  Clients may request alternate representations of normal Kubernetes objects by passing an `Accept` header like `application/json;as=Table;g=meta.k8s.io;v=v1beta1` or `application/json;as=PartialObjectMetadata;g=meta.k8s.io;v1=v1beta1`.  Older servers will ignore this representation or return an error if it is not available.  Clients may request fallback to the normal object by adding a non-qualified mime-type to their `Accept` header like `application/json` - the server will then respond with either the alternate representation if it is supported or the fallback mime-type which is the normal object response. ([#59059](https://github.com/kubernetes/kubernetes/pull/59059), [@smarterclayton]([https://github.com/smarterclayton](https://github.com/smarterclayton) ))

* kube-apiserver now uses SSH tunnels for webhooks if the webhook is not directly routable from apiserver's network environment. ([#58644](https://github.com/kubernetes/kubernetes/pull/58644), [@yguo0905](https://github.com/yguo0905))

* Access to externally managed IP addresses via the kube-apiserver service proxy subresource is no longer allowed by default. This can be re-enabled via the `ServiceProxyAllowExternalIPs` feature gate, but will be disallowed completely in 1.11 ([#57265](https://github.com/kubernetes/kubernetes/pull/57265), [@brendandburns](https://github.com/brendandburns))

* The apiregistration.k8s.io (aggregation) is now generally available. Users should transition from the v1beta1 API to the v1 API. ([#58393](https://github.com/kubernetes/kubernetes/pull/58393), [@deads2k](https://github.com/deads2k))

* Fixes an issue where the resourceVersion of an object in a DELETE watch event was not the resourceVersion of the delete itself, but of the last update to the object. This could disrupt the ability of clients clients to re-establish watches properly. ([#58547](https://github.com/kubernetes/kubernetes/pull/58547), [@liggitt](https://github.com/liggitt))

* kube-apiserver: requests to endpoints handled by unavailable extension API servers (as indicated by an `Available` condition of `false` in the registered APIService) now return `503` errors instead of `404` errors. ([#58070](https://github.com/kubernetes/kubernetes/pull/58070), [@weekface](https://github.com/weekface))

* Custom resources can now be submitted to and received from the API server in application/yaml format, consistent with other API resources. ([#58260](https://github.com/kubernetes/kubernetes/pull/58260), [@liggitt](https://github.com/liggitt))

### Network

* Fixed kube-proxy to work correctly with iptables 1.6.2 and later. ([#60978](https://github.com/kubernetes/kubernetes/pull/60978), [@danwinship](https://github.com/danwinship))

* Makes the kube-dns addon optional so that users can deploy their own DNS solution. ([#57113](https://github.com/kubernetes/kubernetes/pull/57113), [@wwwtyro]([https://github.com/wwwtyro](https://github.com/wwwtyro) ))

* `kubectl port-forward` now supports specifying a service to port forward to, as in `kubectl port-forward svc/myservice 8443:443`. Additional support has also been added for looking up targetPort for a service, as well as enabling using svc/name to select a pod. ([#59809](https://github.com/kubernetes/kubernetes/pull/59809), [@phsiao](https://github.com/phsiao))
* [Make NodePort IP address](https://github.com/kubernetes/website/pull/7631/files)[ses configurabl](https://github.com/kubernetes/website/pull/7631/files)[e](https://github.com/kubernetes/website/pull/7631/files). ([#58052](https://github.com/kubernetes/kubernetes/pull/58052), [@m1093782566](https://github.com/m1093782566))

* Fixed the issue in kube-proxy iptables/ipvs mode to properly handle incorrect IP version. ([#56880](https://github.com/kubernetes/kubernetes/pull/56880), [@MrHohn](https://github.com/MrHohn))
* Kubeadm: CoreDNS supports migration of the kube-dns configuration to CoreDNS configuration when upgrading the service discovery from kube-dns to CoreDNS as part of Beta.  ([#58828](https://github.com/kubernetes/kubernetes/pull/58828), [@rajansandeep](https://github.com/rajansandeep))

* Adds BETA support for `DNSConfig` field in PodSpec and `DNSPolicy=None`, so configurable pod resolve.conf is now enabled by default. ([#59771](https://github.com/kubernetes/kubernetes/pull/59771), [@MrHohn](https://github.com/MrHohn))
* Removed some redundant rules created by the iptables proxier to improve performance on systems with very many services. ([#57461](https://github.com/kubernetes/kubernetes/pull/57461), [@danwinship](https://github.com/danwinship))

* Fix an issue where port forwarding doesn't forward local TCP6 ports to the pod ([#57457](https://github.com/kubernetes/kubernetes/pull/57457), [@vfreex](https://github.com/vfreex))
* Correctly handle transient connection reset errors on GET requests from client library. ([#58520](https://github.com/kubernetes/kubernetes/pull/58520), [@porridge](https://github.com/porridge))

* GCE: Allows existing internal load balancers to continue using a subnetwork that may have been wrongfully chosen due to a bug choosing subnetworks on automatic networks.  ([#57861](https://github.com/kubernetes/kubernetes/pull/57861), [@nicksardo](https://github.com/nicksardo))
### Azure

* Set node external IP for azure node when disabling UseInstanceMetadata. ([#60959](https://github.com/kubernetes/kubernetes/pull/60959), [@feiskyer](https://github.com/feiskyer))

* Changed default azure file/dir mode to 0755. ([#56551](https://github.com/kubernetes/kubernetes/pull/56551), [@andyzhangx](https://github.com/andyzhangx))

* Fixed azure file plugin failure issue on Windows after node restart. ([#60625](https://github.com/kubernetes/kubernetes/pull/60625), [@andyzhangx](https://github.com/andyzhangx))([#60623](https://github.com/kubernetes/kubernetes/pull/60623), [@feiskyer](https://github.com/feiskyer))

* Fixed race condition issue when detaching azure disk, preventing `Multi-Attach error`s when scheduling one pod from one node to another. ([#60183](https://github.com/kubernetes/kubernetes/pull/60183), [@andyzhangx](https://github.com/andyzhangx))

* Add AzureDisk support for vmss nodes. ([#59716]([https://github.com/kubernetes/kubernetes/pull/59716](https://github.com/kubernetes/kubernetes/pull/59716)), [@feiskyer](https://github.com/feiskyer))

* Map correct vmset name for Azure internal load balancers. ([#59747](https://github.com/kubernetes/kubernetes/pull/59747), [@feiskyer](https://github.com/feiskyer))

* Node's providerID will now follow the Azure resource ID format (`azure:///subscriptions/<id>/resourceGroups/<rg>/providers/Microsoft.Compute/virtualMachines/<node-name>` rather than `azure://d84a1c30-0c9f-11e8-8a34-000d3a919531`) when useInstanceMetadata is enabled ([#59539](https://github.com/kubernetes/kubernetes/pull/59539), [@feiskyer](https://github.com/feiskyer))

* Azure public IP is now correctly removed after a service is deleted. ([#59340](https://github.com/kubernetes/kubernetes/pull/59340), [@feiskyer](https://github.com/feiskyer))

* Added PV size grow feature for azure filesystems. ([#57017](https://github.com/kubernetes/kubernetes/pull/57017), [@andyzhangx](https://github.com/andyzhangx))

* Ensured IP is set for Azure internal load balancer. ([#59083](https://github.com/kubernetes/kubernetes/pull/59083), [@feiskyer](https://github.com/feiskyer))

* Set fsGroup by securityContext.fsGroup in azure file. However,f user both sets gid=xxx in mountOptions in azure storage class and securityContext.fsGroup, gid=xxx setting in mountOptions takes precedence. ([#58316](https://github.com/kubernetes/kubernetes/pull/58316), [@andyzhangx](https://github.com/andyzhangx))

* If an Azure disk is not found, K8s will immediately detach it. ([#58345](https://github.com/kubernetes/kubernetes/pull/58345), [@rootfs](https://github.com/rootfs))
* Instrumented the Azure cloud provider for Prometheus monitoring. ([#58204](https://github.com/kubernetes/kubernetes/pull/58204), [@cosmincojocar](https://github.com/cosmincojocar))

* Fixed device name change issues for azure disk. ([#57953](https://github.com/kubernetes/kubernetes/pull/57953), [@andyzhangx](https://github.com/andyzhangx)) ([#57549](https://github.com/kubernetes/kubernetes/pull/57549), [@andyzhangx](https://github.com/andyzhangx))

* Support multiple scale sets in Azure cloud provider. ([#57543](https://github.com/kubernetes/kubernetes/pull/57543), [@feiskyer](https://github.com/feiskyer))

* Support LoadBalancer for Azure Virtual Machine Scale Sets ([#57131](https://github.com/kubernetes/kubernetes/pull/57131), [@feiskyer](https://github.com/feiskyer))

* Fixed incorrect error info when creating an azure file PVC failed. ([#56550](https://github.com/kubernetes/kubernetes/pull/56550), [@andyzhangx](https://github.com/andyzhangx))

* Added mount options support for azure disk. For example:

```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: hdd
provisioner: kubernetes.io/azure-disk
mountOptions:
  - barrier=1
  - acl
parameters:
  skuname: Standard_LRS
  kind: Managed
  fstype: ext3
```

([#56147](https://github.com/kubernetes/kubernetes/pull/56147), [@andyzhangx](https://github.com/andyzhangx))

### Scheduling

* Fixed a bug the in scheduler cache by using Pod UID as the cache key instead of namespace/name ([#61069](https://github.com/kubernetes/kubernetes/pull/61069), [@anfernee](https://github.com/anfernee))

* When `TaintNodesByCondition` is enabled, added `node.kubernetes.io/unschedulable:NoSchedule` ([#61161](https://github.com/kubernetes/kubernetes/pull/61161), [@k82cn](https://github.com/k82cn))

* kube-scheduler: Support extender managed extended resources in kube-scheduler ([#60332](https://github.com/kubernetes/kubernetes/pull/60332), [@yguo0905](https://github.com/yguo0905))

* Updated priority of mirror pod according to PriorityClassName. ([#58485](https://github.com/kubernetes/kubernetes/pull/58485), [@k82cn](https://github.com/k82cn))

* kube-scheduler: restores default leader election behavior. Setting the `--leader-elect`  command line parameter to `true` ([#60524](https://github.com/kubernetes/kubernetes/pull/60524), [@dims](https://github.com/dims))

* All pods with priorityClassName system-node-critical and system-cluster-critical will be critical pods while preserving backwards compatibility. ([#58835](https://github.com/kubernetes/kubernetes/pull/58835), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
* Priority admission controller picks a global default with the lowest priority value if more than one such default PriorityClass exists. ([#59991](https://github.com/kubernetes/kubernetes/pull/59991), [@bsalamat](https://github.com/bsalamat))
* Disallow PriorityClass names with 'system-' prefix for user defined priority classes. ([#59382](https://github.com/kubernetes/kubernetes/pull/59382), [@bsalamat](https://github.com/bsalamat))
* kube-scheduler: Use default predicates/prioritizers if they are unspecified in the policy config. ([#59363](https://github.com/kubernetes/kubernetes/pull/59363), [@yguo0905](https://github.com/yguo0905))

* Scheduler should be able to read from config file if configmap is not present. ([#59386](https://github.com/kubernetes/kubernetes/pull/59386), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
* Add apiserver metric for current inflight-request usage. ([#58342](https://github.com/kubernetes/kubernetes/pull/58342), [@gmarek](https://github.com/gmarek))

* Stability: Make Pod delete event handling of scheduler more robust. ([#58712](https://github.com/kubernetes/kubernetes/pull/58712), [@bsalamat](https://github.com/bsalamat))* Allow scheduler set AlwaysCheckAllPredicates, short circuit all predicates if one predicate fails can greatly improve the scheduling performance. ([#56926](https://github.com/kubernetes/kubernetes/pull/56926), [@wgliang](https://github.com/wgliang))

* GCE: support passing kube-scheduler policy config via SCHEDULER_POLICY_CONFIG. This allows us to specify a customized scheduler policy configuration. ([#57425](https://github.com/kubernetes/kubernetes/pull/57425), [@yguo0905](https://github.com/yguo0905))

* Returns an error for non overcommitable resources if they don't have limit field set in container spec to prevent users from creating invalid configurations. ([#57170](https://github.com/kubernetes/kubernetes/pull/57170), [@jiayingz](https://github.com/jiayingz))

* GCE: Fixed ILB creation on automatic networks with manually created subnetworks. ([#57351](https://github.com/kubernetes/kubernetes/pull/57351), [@nicksardo](https://github.com/nicksardo))

* Multiple Performance Improvements to the MatchInterPodAffinity predicate ([#57476](https://github.com/kubernetes/kubernetes/pull/57476), [@misterikkit](https://github.com/misterikkit))([#57477](https://github.com/kubernetes/kubernetes/pull/57477), [@misterikkit](https://github.com/misterikkit))

* The calico-node addon tolerates all NoExecute and NoSchedule taints by default. So Calico components can even be scheduled on tainted nodes. ([#57122](https://github.com/kubernetes/kubernetes/pull/57122), [@caseydavenport](https://github.com/caseydavenport))
* The scheduler skips pods that use a PVC that either does not exist or is being deleted. ([#55957](https://github.com/kubernetes/kubernetes/pull/55957), [@jsafrane](https://github.com/jsafrane))

### Other changes

* Updated dashboard version to v1.8.3, which keeps auto-generated certs in memory. ([#57326](https://github.com/kubernetes/kubernetes/pull/57326), [@floreks](https://github.com/floreks))

* fluentd-gcp addon: Fixed bug with reporting metrics in event-exporter. ([#60126](https://github.com/kubernetes/kubernetes/pull/60126), [@serathius](https://github.com/serathius))

* Avoid hook errors when effecting label changes on kubernetes-worker charm. ([#59803](https://github.com/kubernetes/kubernetes/pull/59803), [@wwwtyro](https://github.com/wwwtyro))

* Fixed charm issue where docker login would run prior to daemon options being set.  ([#59396](https://github.com/kubernetes/kubernetes/pull/59396), [@kwmonroe](https://github.com/kwmonroe))

* Implementers of the cloud provider interface will note the addition of a context to this interface. Trivial code modification will be necessary for a cloud provider to continue to compile. ([#59287](https://github.com/kubernetes/kubernetes/pull/59287), [@cheftako](https://github.com/cheftako))

* Added configurable etcd quota backend bytes in GCE. ([#59259](https://github.com/kubernetes/kubernetes/pull/59259), [@wojtek-t](https://github.com/wojtek-t))

* GCP: allow a master to not include a metadata concealment firewall rule (if it's not running the metadata proxy). ([#58104](https://github.com/kubernetes/kubernetes/pull/58104), [@ihmccreery](https://github.com/ihmccreery))

* Fixed issue with kubernetes-worker option allow-privileged not properly handling the value True with a capital T. ([#59116](https://github.com/kubernetes/kubernetes/pull/59116), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Controller-manager --service-sync-period flag has been removed. (It was never used in the code and should have no user impact.) ([#59359](https://github.com/kubernetes/kubernetes/pull/59359), [@khenidak](https://github.com/khenidak))

* [fluentd-gcp addon] Switch to the image provided by Stackdriver. The Stackdriver Logging Agent container image uses fluentd v0.14.25. ([#59128](https://github.com/kubernetes/kubernetes/pull/59128), [@bmoyles0117](https://github.com/bmoyles0117))

# Non-user-facing Changes

* CRI now uses moutpoint as image filesystem identifier instead of UUID. ([#59475](https://github.com/kubernetes/kubernetes/pull/59475), [@Random-Liu](https://github.com/Random-Liu))

* GCE: support Cloud TPU API in cloud provider ([#58029](https://github.com/kubernetes/kubernetes/pull/58029), [@yguo0905](https://github.com/yguo0905))

* kubelet now notifies systemd that it has finished starting, if systemd is available and running. ([#60654](https://github.com/kubernetes/kubernetes/pull/60654), [@dcbw](https://github.com/dcbw))

* Do not count failed pods as unready in HPA controller ([#60648](https://github.com/kubernetes/kubernetes/pull/60648), [@bskiba](https://github.com/bskiba))

* fixed foreground deletion of podtemplates ([#60683](https://github.com/kubernetes/kubernetes/pull/60683), [@nilebox](https://github.com/nilebox))

* Conformance tests are added for the DaemonSet kinds in the apps/v1 group version. Deprecated versions of DaemonSet will not be tested for conformance, and conformance is only applicable to release 1.10 and later. ([#60456](https://github.com/kubernetes/kubernetes/pull/60456), [@kow3ns](https://github.com/kow3ns))

* Log audit backend can now be configured to perform batching before writing events to disk. ([#60237](https://github.com/kubernetes/kubernetes/pull/60237), [@crassirostris](https://github.com/crassirostris))

* New conformance tests added for the Garbage Collector ([#60116](https://github.com/kubernetes/kubernetes/pull/60116), [@jennybuckley](https://github.com/jennybuckley))

* Fixes a bug where character devices are not recognized by the kubelet ([#60440](https://github.com/kubernetes/kubernetes/pull/60440), [@andrewsykim](https://github.com/andrewsykim))

* StatefulSet in apps/v1 is now included in Conformance Tests. ([#60336](https://github.com/kubernetes/kubernetes/pull/60336), [@enisoc](https://github.com/enisoc))

* dockertools: disable memory swap on Linux. ([#59404](https://github.com/kubernetes/kubernetes/pull/59404), [@ohmystack](https://github.com/ohmystack))

* Increase timeout of integration tests ([#60458](https://github.com/kubernetes/kubernetes/pull/60458), [@jennybuckley](https://github.com/jennybuckley))

* force node name lowercase on static pod name generating ([#59849](https://github.com/kubernetes/kubernetes/pull/59849), [@yue9944882]([https://github.com/yue9944882](https://github.com/yue9944882))

* fix device name change issue for azure disk ([#60346](https://github.com/kubernetes/kubernetes/pull/60346), [@andyzhangx](https://github.com/andyzhangx))

* Additional changes to iptables kube-proxy backend to improve performance on clusters with very large numbers of services. ([#60306](https://github.com/kubernetes/kubernetes/pull/60306), [@danwinship](https://github.com/danwinship))

* add spelling checking script ([#59463](https://github.com/kubernetes/kubernetes/pull/59463), [@dixudx](https://github.com/dixudx))

* Use consts as predicate name in handlers ([#59952](https://github.com/kubernetes/kubernetes/pull/59952), [@resouer](https://github.com/resouer))

* Fix instanceID for vmss nodes. ([#59857](https://github.com/kubernetes/kubernetes/pull/59857), [@feiskyer](https://github.com/feiskyer))

* Increase allowed lag for ssh key sync loop in tunneler to allow for one failure ([#60068](https://github.com/kubernetes/kubernetes/pull/60068), [@wojtek-t](https://github.com/wojtek-t))

* Set an upper bound (5 minutes) on how long the Kubelet will wait before exiting when the client cert from disk is missing or invalid. This prevents the Kubelet from waiting forever without attempting to bootstrap a new client credentials. ([#59316](https://github.com/kubernetes/kubernetes/pull/59316), [@smarterclayton](https://github.com/smarterclayton))

* Add ipset binary for IPVS to hyperkube docker image ([#57648](https://github.com/kubernetes/kubernetes/pull/57648), [@Fsero](https://github.com/Fsero))

* Making sure CSI E2E test runs on a local cluster ([#60017](https://github.com/kubernetes/kubernetes/pull/60017), [@sbezverk](https://github.com/sbezverk))

* Fix kubelet PVC stale metrics ([#59170](https://github.com/kubernetes/kubernetes/pull/59170), [@cofyc](https://github.com/cofyc))

* Separate current ARM rate limiter into read/write ([#59830](https://github.com/kubernetes/kubernetes/pull/59830), [@khenidak](https://github.com/khenidak))

* Improve control over how ARM rate limiter is used within Azure cloud provider, add generic cache for Azure VM/LB/NSG/RouteTable ([#59520](https://github.com/kubernetes/kubernetes/pull/59520), [@feiskyer](https://github.com/feiskyer))

* fix typo  ([#59619](https://github.com/kubernetes/kubernetes/pull/59619), [@jianliao82](https://github.com/jianliao82))

* DaemonSet, Deployment, ReplicaSet, and StatefulSet objects are now persisted in etcd in apps/v1 format ([#58854](https://github.com/kubernetes/kubernetes/pull/58854), [@liggitt](https://github.com/liggitt))

* YAMLDecoder Read now tracks rest of buffer on io.ErrShortBuffer ([#58817](https://github.com/kubernetes/kubernetes/pull/58817), [@karlhungus](https://github.com/karlhungus))

* Prevent kubelet from getting wedged if initialization of modules returns an error. ([#59020](https://github.com/kubernetes/kubernetes/pull/59020), [@brendandburns](https://github.com/brendandburns))

* Fixed a race condition inside kubernetes-worker that would result in a temporary error situation. ([#59005](https://github.com/kubernetes/kubernetes/pull/59005), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Fix regression in the CRI: do not add a default hostname on short image names ([#58955](https://github.com/kubernetes/kubernetes/pull/58955), [@runcom](https://github.com/runcom))

* use containing API group when resolving shortname from discovery ([#58741](https://github.com/kubernetes/kubernetes/pull/58741), [@dixudx](https://github.com/dixudx))

* remove spaces from kubectl describe hpa ([#56331](https://github.com/kubernetes/kubernetes/pull/56331), [@shiywang](https://github.com/shiywang))

* fluentd-es addon: multiline stacktraces are now grouped into one entry automatically ([#58063](https://github.com/kubernetes/kubernetes/pull/58063), [@monotek](https://github.com/monotek))

* Default scheduler code is moved out of the plugin directory. ([#57852](https://github.com/kubernetes/kubernetes/pull/57852), [@misterikkit](https://github.com/misterikkit))

* CDK nginx ingress is now handled via a daemon set. ([#57530](https://github.com/kubernetes/kubernetes/pull/57530), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Move local PV negative scheduling tests to integration ([#57570](https://github.com/kubernetes/kubernetes/pull/57570), [@sbezverk](https://github.com/sbezverk))

* Only create Privileged PSP binding during e2e tests if RBAC is enabled. ([#56382](https://github.com/kubernetes/kubernetes/pull/56382), [@mikkeloscar](https://github.com/mikkeloscar))

* ignore nonexistent ns net file error when deleting container network in case a retry ([#57697](https://github.com/kubernetes/kubernetes/pull/57697), [@dixudx](https://github.com/dixudx))

* Use old dns-ip mechanism with older cdk-addons. ([#57403](https://github.com/kubernetes/kubernetes/pull/57403), [@wwwtyro](https://github.com/wwwtyro))

* Retry 'connection refused' errors when setting up clusters on GCE. ([#57394](https://github.com/kubernetes/kubernetes/pull/57394), [@mborsz](https://github.com/mborsz))

* YAMLDecoder Read now returns the number of bytes read ([#57000](https://github.com/kubernetes/kubernetes/pull/57000), [@sel](https://github.com/sel))

* Drop hacks used for Mesos integration that was already removed from main kubernetes repository ([#56754](https://github.com/kubernetes/kubernetes/pull/56754), [@dims](https://github.com/dims))

* Compare correct file names for volume detach operation ([#57053](https://github.com/kubernetes/kubernetes/pull/57053), [@prashima](https://github.com/prashima))

* Fixed documentation typo in IPVS README. ([#56578](https://github.com/kubernetes/kubernetes/pull/56578), [@shift](https://github.com/shift))

* The ConfigOK node condition has been renamed to KubeletConfigOk. ([#59905](https://github.com/kubernetes/kubernetes/pull/59905), [@mtaufen](https://github.com/mtaufen))

* Adding pkg/kubelet/apis/deviceplugin/v1beta1 API. ([#59588](https://github.com/kubernetes/kubernetes/pull/59588), [@jiayingz](https://github.com/jiayingz))

* Fixes volume predicate handler for equiv class ([#59335](https://github.com/kubernetes/kubernetes/pull/59335), [@resouer](https://github.com/resouer))

* Bugfix: vSphere Cloud Provider (VCP) does not need any special service account anymore. ([#59440](https://github.com/kubernetes/kubernetes/pull/59440), [@rohitjogvmw](https://github.com/rohitjogvmw))

* fix the error prone account creation method of blob disk ([#59739](https://github.com/kubernetes/kubernetes/pull/59739), [@andyzhangx](https://github.com/andyzhangx))

* Updated kubernetes-worker to request new security tokens when the aws cloud provider changes the registered node name. ([#59730](https://github.com/kubernetes/kubernetes/pull/59730), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Pod priority can be specified ins PodSpec even when the feature is disabled, but it will be effective only when the feature is enabled. ([#59291](https://github.com/kubernetes/kubernetes/pull/59291), [@bsalamat](https://github.com/bsalamat))* Add generic cache for Azure VMSS ([#59652](https://github.com/kubernetes/kubernetes/pull/59652), [@feiskyer](https://github.com/feiskyer))

* fix the create azure file pvc failure if there is no storage account in current resource group ([#56557](https://github.com/kubernetes/kubernetes/pull/56557), [@andyzhangx](https://github.com/andyzhangx))

* Implement envelope service with gRPC, so that KMS providers can be pulled out from API server. ([#55684](https://github.com/kubernetes/kubernetes/pull/55684), [@wu-qiang](https://github.com/wu-qiang))

* Enable golint for `pkg/scheduler` and fix the golint errors in it. ([#58437](https://github.com/kubernetes/kubernetes/pull/58437), [@tossmilestone](https://github.com/tossmilestone))

* Ensure euqiv hash calculation is per schedule ([#59245](https://github.com/kubernetes/kubernetes/pull/59245), [@resouer](https://github.com/resouer))

* Upped the timeout for apiserver communication in the juju kubernetes-worker charm. ([#59219](https://github.com/kubernetes/kubernetes/pull/59219), [@hyperbolic2346](https://github.com/hyperbolic2346))

* kubeadm init: skip checking cri socket in preflight checks ([#58802](https://github.com/kubernetes/kubernetes/pull/58802), [@dixudx](https://github.com/dixudx))

* Configurable etcd compaction frequency in GCE ([#59106](https://github.com/kubernetes/kubernetes/pull/59106), [@wojtek-t](https://github.com/wojtek-t))

* Fixed a bug which caused the apiserver reboot failure in the presence of malfunctioning webhooks. ([#59073](https://github.com/kubernetes/kubernetes/pull/59073), [@caesarxuchao](https://github.com/caesarxuchao))

* GCE: Apiserver uses `InternalIP` as the most preferred kubelet address type by default. ([#59019](https://github.com/kubernetes/kubernetes/pull/59019), [@MrHohn](https://github.com/MrHohn))

* CRI: Add a call to reopen log file for a container.  ([#58899](https://github.com/kubernetes/kubernetes/pull/58899), [@yujuhong](https://github.com/yujuhong))

* The alpha KubeletConfigFile feature gate has been removed, because it was redundant with the Kubelet's --config flag. It is no longer necessary to set this gate to use the flag. The --config flag is still considered alpha. ([#58978](https://github.com/kubernetes/kubernetes/pull/58978), [@mtaufen](https://github.com/mtaufen))

* Fixing extra_sans option on master and load balancer. ([#58843](https://github.com/kubernetes/kubernetes/pull/58843), [@hyperbolic2346](https://github.com/hyperbolic2346))

* Ensure config has been created before attempting to launch ingress. ([#58756](https://github.com/kubernetes/kubernetes/pull/58756), [@wwwtyro](https://github.com/wwwtyro))

* Support metrics API in `kubectl top` commands. ([#56206](https://github.com/kubernetes/kubernetes/pull/56206), [@brancz](https://github.com/brancz))

* Bump GCE metadata proxy to v0.1.9 to pick up security fixes. ([#58221](https://github.com/kubernetes/kubernetes/pull/58221), [@ihmccreery](https://github.com/ihmccreery))

* "ExternalTrafficLocalOnly" has been removed from feature gate. It has been a GA feature since v1.7. ([#56948](https://github.com/kubernetes/kubernetes/pull/56948), [@MrHohn](https://github.com/MrHohn))
* feat(fakeclient): push event on watched channel on add/update/delete ([#57504](https://github.com/kubernetes/kubernetes/pull/57504), [@yue9944882](https://github.com/yue9944882))

* Fixes a possible deadlock preventing quota from being recalculated ([#58107](https://github.com/kubernetes/kubernetes/pull/58107), [@ironcladlou](https://github.com/ironcladlou))

* Bump metadata proxy version to v0.1.7 to pick up security fix. ([#57762](https://github.com/kubernetes/kubernetes/pull/57762), [@ihmccreery](https://github.com/ihmccreery))

* The kubelet uses a new release 3.1 of the pause container with the Docker runtime. This version will clean up orphaned zombie processes that it inherits. ([#57517](https://github.com/kubernetes/kubernetes/pull/57517), [@verb](https://github.com/verb))

* Add cache for VM get operation in azure cloud provider ([#57432](https://github.com/kubernetes/kubernetes/pull/57432), [@karataliu](https://github.com/karataliu))

* Configurable liveness probe initial delays for etcd and kube-apiserver in GCE ([#57749](https://github.com/kubernetes/kubernetes/pull/57749), [@wojtek-t](https://github.com/wojtek-t))

* Fixed garbage collection hang ([#57503](https://github.com/kubernetes/kubernetes/pull/57503), [@liggitt](https://github.com/liggitt)

* Improve scheduler performance of MatchInterPodAffinity predicate. ([#57478](https://github.com/kubernetes/kubernetes/pull/57478), [@misterikkit](https://github.com/misterikkit))

* Add the path '/version/' to the `system:discovery` cluster role. ([#57368](https://github.com/kubernetes/kubernetes/pull/57368), [@brendandburns](https://github.com/brendandburns))

* adding predicates ordering for the kubernetes scheduler. ([#57168](https://github.com/kubernetes/kubernetes/pull/57168), [@yastij](https://github.com/yastij))

* Fix ipvs proxier nodeport ethassumption ([#56685](https://github.com/kubernetes/kubernetes/pull/56685), [@m1093782566](https://github.com/m1093782566))

* Fix Heapster configuration and Metrics Server configuration to enable overriding default resource requirements. ([#56965](https://github.com/kubernetes/kubernetes/pull/56965), [@kawych](https://github.com/kawych))

* Improved event generation in volume mount, attach, and extend operations ([#56872](https://github.com/kubernetes/kubernetes/pull/56872), [@davidz627](https://github.com/davidz627))

* Remove ScrubDNS interface from cloudprovider. ([#56955](https://github.com/kubernetes/kubernetes/pull/56955), [@feiskyer](https://github.com/feiskyer))

* Fixed a garbage collection race condition where objects with ownerRefs pointing to cluster-scoped objects could be deleted incorrectly. ([#57211](https://github.com/kubernetes/kubernetes/pull/57211), [@liggitt](https://github.com/liggitt))

* api-server provides specific events when unable to repair a service cluster ip or node port ([#54304](https://github.com/kubernetes/kubernetes/pull/54304), [@frodenas](https://github.com/frodenas))

* delete useless params containerized ([#56146](https://github.com/kubernetes/kubernetes/pull/56146), [@jiulongzaitian](https://github.com/jiulongzaitian))

* dockershim now makes an Image's Labels available in the Info field of ImageStatusResponse ([#58036](https://github.com/kubernetes/kubernetes/pull/58036), [@shlevy](https://github.com/shlevy))

* Support GetLabelsForVolume in OpenStack Provider ([#58871](https://github.com/kubernetes/kubernetes/pull/58871), [@edisonxiang](https://github.com/edisonxiang))

* Add "nominatedNodeName" field to PodStatus. This field is set when a pod preempts other pods on the node. ([#58990](https://github.com/kubernetes/kubernetes/pull/58990), [@bsalamat](https://github.com/bsalamat))* Fix the PersistentVolumeLabel controller from initializing the PV labels when it's not the next pending initializer. ([#56831](https://github.com/kubernetes/kubernetes/pull/56831), [@jhorwit2](https://github.com/jhorwit2))

* Rename StorageProtection to StorageObjectInUseProtection ([#59901](https://github.com/kubernetes/kubernetes/pull/59901), [@NickrenREN](https://github.com/NickrenREN))

* Add support for cloud-controller-manager in local-up-cluster.sh ([#57757](https://github.com/kubernetes/kubernetes/pull/57757), [@dims](https://github.com/dims))

* GCE: A role and clusterrole will now be provided with GCE/GKE for allowing the cloud-provider to post warning events on all services and watching configmaps in the kube-system namespace. No user action is required. ([#59686](https://github.com/kubernetes/kubernetes/pull/59686), [@nicksardo](https://github.com/nicksardo))

* Wait for kubedns to be ready when collecting the cluster IP. ([#57337](https://github.com/kubernetes/kubernetes/pull/57337), [@wwwtyro](https://github.com/wwwtyro))

# External Dependencies
* The supported etcd server version is 3.1.12, as compared to 3.0.17 in v1.9 ([#60988](https://github.com/kubernetes/kubernetes/pull/60988))
* The validated docker versions are the same as for v1.9: 1.11.2 to 1.13.1 and 17.03.x ([ref](https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/system/docker_validator_test.go))
* The Go version is go1.9.3, as compared to go1.9.2 in v1.9. ([#59012](https://github.com/kubernetes/kubernetes/pull/59012))
* The minimum supported go is the same as for v1.9: go1.9.1. ([#55301](https://github.com/kubernetes/kubernetes/pull/55301))
* CNI is the same as v1.9: v0.6.0 ([#51250](https://github.com/kubernetes/kubernetes/pull/51250))
* CSI is updated to 0.2.0 as compared to 0.1.0 in v1.9. ([#60736](https://github.com/kubernetes/kubernetes/pull/60736))
* The dashboard add-on has been updated to v1.8.3, as compared to 1.8.0 in v1.9. ([#517326](https://github.com/kubernetes/kubernetes/pull/57326))
* Heapster has is the same as v1.9: v1.5.0. It will be upgraded in v1.11. ([ref](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/cluster-monitoring/google/heapster-controller.yaml))
* Cluster Autoscaler has been updated to v1.2.0. ([#60842](https://github.com/kubernetes/kubernetes/pull/60842), [@mwielgus](https://github.com/mwielgus))
* Updates kube-dns to v1.14.8 ([#57918](https://github.com/kubernetes/kubernetes/pull/57918), [@rramkumar1](https://github.com/rramkumar1))
* Influxdb is unchanged from v1.9: v1.3.3 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
* Grafana is unchanged from v1.9: v4.4.3 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
* CAdvisor is v0.29.1 ([#60867](https://github.com/kubernetes/kubernetes/pull/60867)) 
* fluentd-gcp-scaler is v0.3.0 ([#61269](https://github.com/kubernetes/kubernetes/pull/61269)) 
* Updated fluentd in fluentd-es-image to fluentd v1.1.0 ([#58525](https://github.com/kubernetes/kubernetes/pull/58525), [@monotek](https://github.com/monotek))
* fluentd-elasticsearch is v2.0.4 ([#58525](https://github.com/kubernetes/kubernetes/pull/58525)) 
* Updated fluentd-gcp to v3.0.0. ([#60722](https://github.com/kubernetes/kubernetes/pull/60722))
* Ingress glbc is v1.0.0 ([#61302](https://github.com/kubernetes/kubernetes/pull/61302)) 
* OIDC authentication is coreos/go-oidc v2 ([#58544](https://github.com/kubernetes/kubernetes/pull/58544)) 
* Updated fluentd-gcp updated to v2.0.11. ([#56927](https://github.com/kubernetes/kubernetes/pull/56927), [@x13n](https://github.com/x13n))
* Calico has been updated to v2.6.7 ([#59130](https://github.com/kubernetes/kubernetes/pull/59130), [@caseydavenport](https://github.com/caseydavenport))
