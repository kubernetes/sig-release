# Kubernetes 1.11 Release Notes

This document is for release notes for Kubernetes 1.11. These release notes are initially generated from commit messages, and are sorted based on the release note tag.

Commits should be tagged as follows:

**/release-note-before-upgrading**

This tag is for urgent changes that users must take into consideration before upgrading. For example, mandatory upgrades of dependencies or other upgrade/downgrade issues belong in this category.

**/release-note-feature**

This tag is for changes that are related to major features that are listed in the feature tracking spreadsheet.

**/release-note**

This tag is for changes that are user-facing. For example, API changes or CLI flag changes belong in this category. Fixed bugs that affect the user experience should also be in this category.

**/release-note-none**

This tag is for changes that don't affect the user experience, such as behind-the-scenes improvements that only other Kubernetes developers will notice. These notes will appear in the changelog but not the release notes.

## Draft Log

- April 24, 2018: Added pending notes from v1.10.0 to to 3dbcd1d ([@marpaia](https://github.com/marpaia))
- April 28, 2018: Sorted through 4/24/18 notes ([@nickchase](https://github.com/nickchase))
- May 17, 2018: Added unsorted notes from 3bdcd1d to f86ec3f ([@marpaia](https://github.com/marpaia))
- June 8, 2018: Added placeholders for "Major Themes" ([@nickchase](https://github.com/nickchase))
- June 8, 2018: Added unsorted notes from f86ec3f to a7a081b ([@marpaia](https://github.com/marpaia))
- June 11, 2018: Sorted notes from f86ec3f to a7a081b ([@nickchase](https://github.com/nickchase))

## Major Themes

### sig-api-machinery


### sig-apps


### sig-architecture


### sig-auth


### sig-autoscaling


### sig-aws


### sig-azure


### sig-big-data


### sig-cli


### sig-cluster-lifecycle


### sig-cluster-ops


### sig-gcp


### sig-instrumentation


### sig-multicluster


### sig-network


### sig-node


### sig-openstack


### sig-scalability


### sig-scheduling


### sig-service-catalog


### sig-storage


### sig-windows


## Before Upgrading

* Default mount propagation has changed from "HostToContainer" ("rslave" in Linux terminology), as it was in 1.10, to "None" ("private") to match the behavior in 1.9 and earlier releases. "HostToContainer" as a default caused regressions in some pods. ([#62462](https://github.com/kubernetes/kubernetes/pull/62462), [@jsafrane](https://github.com/jsafrane))
* The kube-apiserver `--storage-version` flag has been removed; you must use `--storage-versions` instead. ([#61453](https://github.com/kubernetes/kubernetes/pull/61453), [@hzxuzhonghu](https://github.com/hzxuzhonghu))
* [Pod priority and preemption](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/)
is enabled by default. Even if you don't plan to use this feature,
you might need to take some action right after upgrading.
In multi-tenant clusters where not all users are trusted, you are advised to create appropriate
amount of quota for two default priority classes, `system-cluster-critical` and
`system-node-critical`. These two priority classes are added to clusters by default.
[ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
should be created to limit users from creating Pods at these priorities if not all users of your
cluster are trusted. We do not advise disabling this feature since critical system Pods rely on
the scheduler preemption to be scheduled when cluster is under resource pressure.
 
### Pending

* client-go developers must switch to the new dynamic client. This new client is easier to use, and the old one is deprecated and will be removed in a future version. **(EDITOR'S NOTE:  If the old client is deprecated, it's still there, so do developers actually HAVE to switch, and if so, why?)** (#62913, @deads2k)
* Add warnings that authors of aggregated API servers must not rely on authorization being done by the kube-apiserver. **(EDITOR'S NOTE: Why? And is this note that warnings must be added, or is this note the warning?)** ([#61349](https://github.com/kubernetes/kubernetes/pull/61349), [@sttts](https://github.com/sttts))
* kubeadm: Remove the `.CloudProvider` and `.PrivilegedPods` configuration option (#63866, @luxas)
* kubeadm now uses an upgraded API version for the configuration file, `kubeadm.k8s.io/v1alpha2`. kubeadm in v1.11 will still be able to read `v1alpha1` configuration, and will automatically convert the configuration to `v1alpha2` internally and when storing the configuration in the ConfigMap in the cluster. (#63788, @luxas)
* The annotation `service.alpha.kubernetes.io/tolerate-unready-endpoints` is deprecated.  Users should use Service.spec.publishNotReadyAddresses instead. (#63742, @thockin)
* avoid duplicate status in audit events (#62695, @CaoShuFeng)
* You must now specify Node.Spec.ConfigSource.ConfigMap.KubeletConfigKey when using dynamic Kubelet config to tell the Kubelet which key of the ConfigMap identifies its config file. (#59847, @mtaufen)
* Kubernetes version command line parameter in kubeadm has been updated to drop an unnecessary redirection from ci/latest.txt to ci-cross/latest.txt. Users should know exactly where the builds are stored on Google Cloud storage buckets from now on. For example for 1.9 and 1.10, users can specify ci/latest-1.9 and ci/latest-1.10 as the CI build jobs what build images correctly updates those. The CI jobs for master update the ci-cross/latest location, so if you are looking for latest master builds, then the correct parameter to use would be ci-cross/latest. (#63504, @dims)
* GC is now bound by QPS (it wasn't before) and so if you need more QPS to avoid ratelimiting GC, you'll have to set it. (#63657, @shyamjvs)
* [action required] TODO (#64792, @luxas)
* kubeadm: Update the dropin for the kubelet in v1.11 (#64780, @luxas)
* kubeadm: Let the `--node-name` flag flow down to `--hostname-override` for the kubelet (#64706, @liztio)
* [action required] kubeadm: The Token-related fields in the `MasterConfiguration` object have now been refactored. Instead of the top-level `.Token`, `.TokenTTL`, `.TokenUsages`, `.TokenGroups` fields, there is now a `BootstrapTokens` slice of `BootstrapToken` objects that support the same features under the `.Token`, `.TTL`, `.Usages`, `.Groups` fields. (#64408, @luxas)
* [action required] `.NodeName` and `.CRISocket` in the `MasterConfiguration` and `NodeConfiguration` v1alpha1 API objects are now `.NodeRegistration.Name` and `.NodeRegistration.CRISocket` respectively in the v1alpha2 API. The `.NoTaintMaster` field has been removed in the v1alpha2 API. (#64210, @luxas)
* (ACTION REQUIRED) PersisntVolumeLabel admission controller is now disabled by default. If you depend on this feature (AWS/GCE) then ensure it is added to the `--enable-admission-plugins` flag on the kube-apiserver. (#64326, @andrewsykim)
* [action required] kubeadm: The `:Etcd` struct has been refactored in the v1alpha2 API. All the options now reside under either `.Etcd.Local` or `.Etcd.External`. Automatic conversions from the v1alpha1 API are supported. (#64066, @luxas)
* [action required] kubeadm: kubelets in kubeadm clusters now disable the readonly port (10255). If you're relying on unauthenticated access to the readonly port, please switch to using the secure port (10250). Instead, you can now use ServiceAccount tokens when talking to the secure port, which will make it easier to get access to e.g. the `/metrics` endpoint of the kubelet securely. (#64187, @luxas)
* [action required] kubeadm: Support for `.AuthorizationModes` in the kubeadm v1alpha2 API has been removed. Instead, you can use the `.APIServerExtraArgs` and `.APIServerExtraVolumes` fields to achieve the same effect. Files using the v1alpha1 API and setting this field will be automatically upgraded to this v1alpha2 API and the information will be preserved. (#64068, @luxas)
* [action required] The formerly publicly-available cAdvisor web UI that the kubelet ran on port 4194 by default is now turned off by default. The flag configuring what port to run this UI on `--cadvisor-port` was deprecated in v1.10. Now the default is `--cadvisor-port=0`, in other words, to not run the web server. The recommended way to run cAdvisor if you still need it, is via a DaemonSet. The `--cadvisor-port` will be removed in v1.12 (#63881, @luxas)
* [action required] kubeadm: The `.ImagePullPolicy` field has been removed in the v1alpha2 API version. Instead it's set statically to `IfNotPresent` for all required images. If you want to always pull the latest images before cluster init (like what `Always` would do), run `kubeadm config images pull` before each `kubeadm init`. If you don't want the kubelet to pull any images at `kubeadm init` time, as you for instance don't have an internet connection, you can also run `kubeadm config images pull` before `kubeadm init` or side-load the images some other way (e.g. `docker load -i image.tar`). Having the images locally cached will result in no pull at runtime, which makes it possible to run without any internet connection. (#64096, @luxas)
*  kubeadm: Remove the `.CloudProvider` and `.PrivilegedPods` configuration option (#63866, @luxas)
* [action required] kubeadm now uses an upgraded API version for the configuration file, `kubeadm.k8s.io/v1alpha2`. kubeadm in v1.11 will still be able to read `v1alpha1` configuration, and will automatically convert the configuration to `v1alpha2` internally and when storing the configuration in the ConfigMap in the cluster. (#63788, @luxas)
* The annotation `service.alpha.kubernetes.io/tolerate-unready-endpoints` is deprecated.  Users should use Service.spec.publishNotReadyAddresses instead. (#63742, @thockin)
* avoid duplicate status in audit events (#62695, @CaoShuFeng)


#### New Deprecations

* `--show-all`, which only affected pods, and even then only for human readable/non-API printers, is inert in v1.11, and will be removed in a future release. ([#60793](https://github.com/kubernetes/kubernetes/pull/60793), [@charrywanganthony](https://github.com/charrywanganthony))
* Deprecate kubectl rolling-update  (#61285, @soltysh)
* Deprecate InfluxDB cluster monitoring (#62328, @serathius)
* The annotation `service.alpha.kubernetes.io/tolerate-unready-endpoints` is deprecated.  Users should use Service.spec.publishNotReadyAddresses instead. (#63742, @thockin)
* kube-apiserver: the default `--endpoint-reconciler-type` is now `lease`. The `master-count` endpoint reconciler type is deprecated and will be removed in 1.13. (#63383, @liggitt)
* OpenStack built-in cloud provider is now deprecated. Please use the external cloud provider for OpenStack. (#63524, @dims)
* The Kubelet's deprecated --allow-privileged flag now defaults to true. This enables users to stop setting --allow-privileged in order to transition to PodSecurityPolicy. Previously, users had to continue setting --allow-privileged, because the default was false. (#63442, @mtaufen)
* The old dynamic client has been replaced by a new one.  The previous dynamic client will exist for one release in `client-go/deprecated-dynamic`.  Switch as soon as possible. (#63446, @deads2k)

##### Pending

* in-tree support for openstack credentials is now deprecated. please use the "client-keystone-auth" from the cloud-provider-openstack repository. details on how to use this new capability is documented here - https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/using-client-keystone-auth.md (#64346, @dims)
* core v1: deprecate the gitRepo volume type (#63445, @ericchiang)
* Deprecate InfluxDB cluster monitoring (#62328, @serathius)
* The annotation `service.alpha.kubernetes.io/tolerate-unready-endpoints` is deprecated.  Users should use Service.spec.publishNotReadyAddresses instead. (#63742, @thockin)
* The old dynamic client has been replaced by a new one.  The previous dynamic client will exist for one release in `client-go/deprecated-dynamic`.  Switch as soon as possible. (#63446, @deads2k)
* OpenStack built-in cloud provider is now deprecated. Please use the external cloud provider for OpenStack. (#63524, @dims)
* kube-apiserver: the default `--endpoint-reconciler-type` is now `lease`. The `master-count` endpoint reconciler type is deprecated and will be removed in 1.13. (#63383, @liggitt)



#### Removed Deprecations

* --include-extended-apis, which was deprecated back in [#32894](https://github.com/kubernetes/kubernetes/pull/32894), has been removed. ([#62803](https://github.com/kubernetes/kubernetes/pull/62803), [@deads2k](https://github.com/deads2k))
* Kubelets will no longer set `externalID` in their node spec. ([#61877](https://github.com/kubernetes/kubernetes/pull/61877), [@mikedanese](https://github.com/mikedanese))
* The initresource admission plugin has been removed. ([#58784](https://github.com/kubernetes/kubernetes/pull/58784), [@wackxu](https://github.com/wackxu))
* `ObjectMeta `, `ListOptions`, and `DeleteOptions` have been removed from the core api group.  Please reference them in `meta/v1`. ([#61809](https://github.com/kubernetes/kubernetes/pull/61809), [@hzxuzhonghu](https://github.com/hzxuzhonghu))
* The deprecated --mode flag in check-network-mode has been removed. ([#60102](https://github.com/kubernetes/kubernetes/pull/60102), [@satyasm](https://github.com/satyasm))
* Support for the `alpha.kubernetes.io/nvidia-gpu` resource, which was deprecated in 1.10, has been removed. Please use the resource exposed by DevicePlugins instead (`nvidia.com/gpu`). ([#61498](https://github.com/kubernetes/kubernetes/pull/61498), [@mindprince](https://github.com/mindprince))
* The kube-cloud-controller-manager flag --service-account-private-key-file has been removed. ([#60875](https://github.com/kubernetes/kubernetes/pull/60875), [@charrywanganthony](https://github.com/charrywanganthony))

**Pending**
* The rknetes code, which was deprecated in 1.10, has been removed. **(What should be used instead? CRI?)** ([#61432](https://github.com/kubernetes/kubernetes/pull/61432), [@filbranden](https://github.com/filbranden))
* DaemonSet scheduling associated with the alpha ScheduleDaemonSetPods feature flag has been removed from the 1.10 release. See https://github.com/kubernetes/features/issues/548 for feature status. **(EDITOR'S NOTE: Should this be 1.11 or is this a leftover change that didn't quite make it?)** ([#61411](https://github.com/kubernetes/kubernetes/pull/61411), [@liggitt](https://github.com/liggitt))
* The METADATA_AGENT_VERSION configuration option has been removed. **(EDITOR'S NOTE: From where? What should be used instead?)** (#63000, @kawych)

#### Alpha, Beta, Stable

* The --experimental-qos-reserve kubelet flags has been replaced by the alpha level --qos-reserved flag or the QOSReserved field in the kubeletconfig, and requires the QOSReserved feature gate to be enabled. (#62509, @sjenning)
* The `PriorityClass` API is promoted to `scheduling.k8s.io/v1beta1` (#63100, @ravisantoshgudimetla)

**Pending**

* Removed alpha functionality that allowed the controller manager to approve kubelet server certificates. **(EDITOR'S NOTE: Has this been replaced with something else? What is the effect on the user?)** ([#62471](https://github.com/kubernetes/kubernetes/pull/62471), [@mikedanese](https://github.com/mikedanese))
* Modify e2e tests to use priorityClass beta version & switch priorityClass feature to beta (#63724, @ravisantoshgudimetla)
* client-go: credential exec plugins have been promoted to beta (#64482, @ericchiang)
* Declare IPVS-based kube-proxy GA (#58442, @m1093782566)



## Other Notable Changes

### Sig API-Machinery
* The kubeadm config option `API.ControlPlaneEndpoint` has been extended to take an optional port which may differ from the apiserver's bind port. ([#62314](https://github.com/kubernetes/kubernetes/pull/62314), [@rjosephwright](https://github.com/rjosephwright))

#### Pending

* Orphan delete is now supported for custom resources (#63386, @roycaihw)
* Meta data of CustomResources is now pruned and schema checked during deserialization of requests and when read from etcd. In the former case, invalid meta data is rejected, in the later it is dropped from the CustomResource objects. (#64267, @sttts)
* The kube-apiserver openapi doc now includes extensions identifying APIService and CustomResourceDefinition kinds (#64174, @liggitt)
* Subresources for custom resources is now beta and enabled by default. With this, updates to the `/status` subresource will disallow updates to all fields other than `.status` (not just `.spec` and `.metadata` as before). Also, `required` can be used at the root of the CRD OpenAPI validation schema when the `/status` subresource is enabled. (#63598, @nikhita)
* CustomResourceDefinitions Status subresource now supports GET and PATCH (#63619, @roycaihw)
* When updating /status subresource of a custom resource, only the value at the `.status` subpath for the update is considered. (#63385, @CaoShuFeng)
* Add a way to pass extra arguments to etcd. (#63961, @mborsz)
* Label ExternalEtcdClientCertificates can be used for ignoring all preflight check issues related to client certificate files for external etcd. (#64269, @kad)
* Add Establishing Controller on CRDs to avoid race between Established condition and CRs actually served. In HA setups, the Established condition is delayed by 5 seconds. (#63068, @xmudrii)
* Add spec.additionalPrinterColumns to CRDs to define server side printing columns. (#60991, @sttts)
* Add CRD Versioning with NOP converter (#63830, @mbohlool)
* Allow "required" and "description" to be used at the CRD OpenAPI validation schema root when the /status subresource is enabled. (#63533, @sttts)


### Sig Auth
* RBAC information is now included in audit logs via audit.Event annotations: ([#58807](https://github.com/kubernetes/kubernetes/pull/58807), [@CaoShuFeng](https://github.com/CaoShuFeng))
    * authorization.k8s.io/decision = {allow, forbid}
    * authorization.k8s.io/reason = human-readable reason for the decision
* `kubectl certificate approve|deny` will not modify an already approved or denied CSR unless the `--force` flag is provided. ([#61971](https://github.com/kubernetes/kubernetes/pull/61971), [@smarterclayton](https://github.com/smarterclayton))
* The `--bootstrap-kubeconfig` argument to Kubelet previously created the first bootstrap client credentials in the certificates directory as `kubelet-client.key` and `kubelet-client.crt`.  Subsequent certificates created by cert rotation were created in a combined PEM file that was atomically rotated as `kubelet-client-DATE.pem` in that directory, which meant clients relying on the `node.kubeconfig` generated by bootstrapping would never use a rotated cert.  The initial bootstrap certificate is now generated into the cert directory as a PEM file and symlinked to `kubelet-client-current.pem` so that the generated kubeconfig remains valid after rotation. (#62152, @smarterclayton)

#### Pending 

* owner references can be set during creation without deletion power (#63403, @deads2k)
* Implements OIDC distributed claims. (#63213, @filmil)

### Sig Azure
* Azure cloud provider now supports standard SKU load balancer and public IP. To use it, set the cloud provider config with
    {
       "loadBalancerSku": "standard",
       "excludeMasterFromStandardLB": true,
    }
If excludeMasterFromStandardLB is not set, it will be default to true, which means master nodes are excluded from the standard load balancer. Also note that the standard load balancer doesn't work with annotation `service.beta.kubernetes.io/azure-load-balancer-mode`. This is because all nodes (except master) are added as the loadbalancer backends.
([#61884](https://github.com/kubernetes/kubernetes/pull/61884), [#62707](https://github.com/kubernetes/kubernetes/pull/62707), [@feiskyer](https://github.com/feiskyer))
* The Azure cloud provider now supports specifying allowed service tags by annotation `service.beta.kubernetes.io/azure-allowed-service-tags` ([#61467](https://github.com/kubernetes/kubernetes/pull/61467), [@feiskyer](https://github.com/feiskyer))

#### Pending

* Fix kube-controller-manager panic while provisioning Azure security group rules (#64739, @feiskyer)
* Add azuredisk PV size grow feature (#64386, @andyzhangx)
* fix data loss issue if using existing azure disk with partitions in disk mount  (#63270, @andyzhangx)
* AWS EBS, Azure Disk, GCE PD and Ceph RBD volume plugins support dynamic provisioning of raw block volumes. (#64447, @jsafrane)
* fix azure file size grow issue (#64383, @andyzhangx)
* Fix SessionAffinity not updated issue for Azure load balancer (#64180, @feiskyer)
* add block device support for azure disk (#63841, @andyzhangx)
* Do not check vmSetName when getting Azure node's IP (#63541, @feiskyer)
* Azure VMSS: support VM names to contain the `_` character (#63526, @djsly)


### Sig CLI

#### Pending

* kubectl will list all allowed print formats when an invalid format is passed. (#64371, @CaoShuFeng)
* Fix kubectl auth can-i exit code. It will return 1 if the user is not allowed and 0 if it's allowed. (#59579, @fbac)
* apply global flag "context" for kubectl config view --minify (#64608, @dixudx)
* kubectl built for darwin from darwin now enables cgo to use the system-native C libraries for DNS resolution. Cross-compiled kubectl (e.g. from an official kubernetes release) still uses the go-native netgo DNS implementation.  (#64219, @ixdy)
* kubectl apply --prune supports CronJob resource.  (#62991, @tomoe)
* The --dry-run flag has been enabled for kubectl auth reconcile (#64458, @mrogers950)
* kubectl delete does not use reapers for removing objects anymore, but relies on server-side GC entirely (#63979, @soltysh)
* kubectl: This client version requires the `apps/v1` APIs, so it will not work against a cluster version older than v1.9.0. Note that kubectl only guarantees compatibility with clusters that are +/-1 minor version away. (#61419, @enisoc)
* Use DeleteOptions.PropagationPolicy instead of OrphanDependents in kubectl  (#59851, @nilebox)
* `kubectl wait` is a new command that allows waiting for one or more resources to be deleted or to reach a specific condition (#64034, @deads2k)
* `kubectl auth reconcile` only works with rbac.v1 (#63967, @deads2k)
* kubectl and client-go now detects duplicated name for user, cluster and context when loading kubeconfig and reports error  (#60464, @roycaihw)
* Add 'UpdateStrategyType' and 'RollingUpdateStrategy' to 'kubectl describe sts' command output. (#63844, @tossmilestone)
* Adding initial Korean translation for kubectl (#62040, @ianychoi)
* `kubectl cp` supports completion. (#60371, @superbrothers)
* the shortcuts which were moved server-side in at least 1.9 have been removed from being hardcoded in kubectl (#63507, @deads2k)
* `kubectl delete` with selection criteria defaults to ignoring not found errors (#63490, @deads2k)
* `kubectl create [secret | configmap] --from-file` now works on Windows with fully-qualified paths (#63439, @liggitt)
* Use /usr/bin/env in all script shebangs to increase portability. (#62657, @matthyx)



### Sig Cluster-Lifecycle
* Phase `kubeadm alpha phase kubelet` has been added to support dynamic kubelet configuration in kubeadm. ([#57224](https://github.com/kubernetes/kubernetes/pull/57224), [@xiangpengzhao](https://github.com/xiangpengzhao))
* `kubeadm alpha phase kubeconfig user` now supports the specification of groups (organizations) in a client certificate. ([#62627](https://github.com/kubernetes/kubernetes/pull/62627), [@xiangpengzhao](https://github.com/xiangpengzhao))
* The --cluster-name parameter has been added to kubeadm init, enabling users to specify the cluster name in kubeconfig. ([#60852](https://github.com/kubernetes/kubernetes/pull/60852), [@karan](https://github.com/karan))
* The logging feature for kubeadm commands now supports a verbosity setting. ([#57661](https://github.com/kubernetes/kubernetes/pull/57661), [@vbmade2000](https://github.com/vbmade2000))
* kubeadm config can now override the Node CIDR Mask Size passed to kube-controller-manager. ([#61705](https://github.com/kubernetes/kubernetes/pull/61705), [@jstangroome](https://github.com/jstangroome))
* kubeadm now has a join timeout that can be controlled via the discoveryTimeout config option (set to 5 minutes by default). ([#60983](https://github.com/kubernetes/kubernetes/pull/60983), [@rosti](https://github.com/rosti))
* kubeadm: Added the writable boolean option to kubeadm config. The option works on a per-volume basis for *ExtraVolumes* config keys. ([#60428](https://github.com/kubernetes/kubernetes/pull/60428), [@rosti](https://github.com/rosti))
* Fixed a configuration error when upgrading kubeadm from 1.9 to 1.10+; Kubernetes must have the same major and minor versions as the kubeadm library. ([#62568](https://github.com/kubernetes/kubernetes/pull/62568), [@liztio](https://github.com/liztio))

#### Pending
* kubeadm now configures the etcd liveness probe correctly when etcd is listening on all interfaces (#64670, @stealthybox)
* kubeadm: only run kube-proxy on architecture consistent nodes (#64696, @dixudx)
* kubeadm: Add a new `kubeadm upgrade node config` command (#64624, @luxas)
* Kubeadm: Make CoreDNS run in read-only mode and drop all unneeded privileges  (#64473, @nberlee)
* kubeadm: Set the kubelet `--resolv-conf` flag conditionally on init (#64665, @stealthybox)
* kubeadm upgrade apply can now ignore version errors with --force (#64570, @liztio)
* kubeadm now preserves previous manifests after upgrades (#64337, @liztio)
* kubeadm: conditionally set the kubelet cgroup driver for Docker (#64347, @neolit123)
* kubeadm: Add a 'kubeadm config migrate' command to convert old API types to their newer counterparts in the new, supported API types. This is just a client-side tool, it just executes locally without requiring a cluster to be running. You can think about this as an Unix pipe that upgrades config files. (#64232, @luxas)
* kubeadm will pull required images during preflight checks if it cannot find them on the system (#64105, @chuckha)
* kubeadm: rename the addon parameter `kube-dns` to `coredns` for `kubeadm alpha phases addons` as CoreDNS is now the default DNS server in 1.11. (#64274, @neolit123)
* kubeadm: when starting the API server use the arguments --enable-admission-plugins and --disable-admission-plugins instead of the deprecated --admission-control. (#64165, @neolit123)
* Correct the way we reset containers and pods in kubeadm via crictl (#63862, @runcom)
* "kubeadm init" now writes a structured and versioned kubelet ComponentConfiguration file to `/var/lib/kubelet/config.yaml` and an environment file with runtime flags (you can source this file in the systemd kubelet dropin) to `/var/lib/kubelet/kubeadm-flags.env`. (#63887, @luxas)
* kubeadm: A `kubeadm config print-default` command has now been added that you can use as a starting point when writing your own kubeadm configuration files (#63969, @luxas)
* Update kubeadm's minimum supported kubernetes in v1.11.x to 1.10 (#63920, @dixudx)
* kubeadm has removed `.Etcd.SelfHosting` from its configuration API. It was never used in practice. (#63871, @luxas)
* adds the `kubeadm upgrade diff` command to show how static pod manifests will be changed by an upgrade. (#63930, @liztio)
* Adds a `kubeadm config images pull` command to pull container images used by kubeadm. (#63833, @chuckha)
* kubeadm now checks that IPv4/IPv6 forwarding is enabled (#63872, @kad)
* kubeadm will now deploy CoreDNS by default instead of KubeDNS (#63509, @detiber)
* kubeadm upgrade now supports external etcd setups again (#63495, @detiber)
* kubeadm will no longer generate an unused etcd CA and certificates when configured to use an external etcd cluster. (#63806, @detiber)
* Removes a preflight check for kubeadm that validated custom kube-apiserver, kube-controller-manager and kube-scheduler arguments. (#63673, @chuckha)
* Adds a list-images subcommand to kubeadm that lists required images for a kubeadm install. (#63450, @chuckha)
* Kubernetes version command line parameter in kubeadm has been updated to drop an unnecessary redirection from ci/latest.txt to ci-cross/latest.txt. Users should know exactly where the builds are stored on Google Cloud storage buckets from now on. For example for 1.9 and 1.10, users can specify ci/latest-1.9 and ci/latest-1.10 as the CI build jobs what build images correctly updates those. The CI jobs for master update the ci-cross/latest location, so if you are looking for latest master builds, then the correct parameter to use would be ci-cross/latest. (#63504, @dims)
* Search standard KubeConfig file locations when using `kubeadm token` without `--kubeconfig`. (#62850, @neolit123)


### Sig GCP
* [fluentd-gcp addon] Increase CPU limit for fluentd to 1 core to achieve 100kb/s throughput. ([#62430](https://github.com/kubernetes/kubernetes/pull/62430), [@bmoyles0117](https://github.com/bmoyles0117))

### Sig Networking
* The internal IP address of the node is now added as additional information for kubectl, ([#57623](https://github.com/kubernetes/kubernetes/pull/57623), [@dixudx](https://github.com/dixudx))
* NetworkPolicies can now target specific pods in other namespaces by including both a namespaceSelector and a podSelector in the same peer element. ([#60452](https://github.com/kubernetes/kubernetes/pull/60452), [@danwinship](https://github.com/danwinship))
* kubelet's --cni-bin-dir option now accepts multiple comma-separated CNI binary directory paths, which are searched for CNI plugins in the given order. ([#58714](https://github.com/kubernetes/kubernetes/pull/58714), [@dcbw](https://github.com/dcbw))
* Added --ipvs-exclude-cidrs flag to kube-proxy.  ([#62083](https://github.com/kubernetes/kubernetes/pull/62083), [@rramkumar1](https://github.com/rramkumar1))

#### Pending

* Setup dns servers and search domains for Windows Pods in dockershim. Docker EE version >= 17.10.0 is required for propagating DNS to containers. (#63905, @feiskyer)
* CoreDNS deployment configuration now uses k8s.gcr.io imageRepository (#64775, @rajansandeep)
* CoreDNS is now v1.1.3 (#64258, @rajansandeep)
* Report node DNS info with --node-ip flag (#63170, @micahhausler)


### Sig Node

#### Pending

* kubernetes now packages cri-tools (crictl) in addition to all the other kubeadm tools in a deb and rpm. (#64836, @chuckha)
* Graduate CRI container log rotation to beta, and enable it by default. (#64046, @yujuhong)
* Kubernetes cluster on GCE have crictl installed now. Users can use it to help debug their node. The documentation of crictl can be found https://github.com/kubernetes-incubator/cri-tools/blob/master/docs/crictl.md. (#63357, @Random-Liu)
* CRI: update documents for container logpath. The container log path has been changed from containername_attempt#.log to containername/attempt#.log  (#62015, @feiskyer)

### Sig OpenStack

#### Pending

* Provide a meaningful error message in openstack cloud provider when no valid IP address can be found for a node (#64318, @gonzolino)
* Restores the pre-1.10 behavior of the openstack cloud provider which uses the instance name as the Kubernetes Node name. This requires instances be named with RFC-1123 compatible names. (#63903, @liggitt)
* try to read openstack auth config from client config and fall back to read from the environment variables if not available (#60200, @dixudx)


### Sig Scheduler
* kube-scheduler now has the --write-config-to flag ([#62515](https://github.com/kubernetes/kubernetes/pull/62515), [@resouer](https://github.com/resouer))
* Performance of the affinity/anti-affinity predicate for the default scheduler has been significantly improved. ([#62211](https://github.com/kubernetes/kubernetes/pull/62211), [@bsalamat](https://github.com/bsalamat))
* The scheduler schedules DaemonSet Pods. This is an alpha feature disabled by default. ([#63223](https://github.com/kubernetes/kubernetes/pull/63223), [@k82cn](https://github.com/k82cn))
* The `PriorityClass` API is promoted to `scheduling.k8s.io/v1beta1` ([#63100](https://github.com/kubernetes/kubernetes/pull/63100), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
* Rescheduler is now used only to help schedule critical DaemonSet Pods. Other critical pods rely
 on the scheduler preemption to be scheduled when a cluster is under resource pressure. ([#64592](https://github.com/kubernetes/kubernetes/pull/64592), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
* Improve the scheduler's cache robustness by increasing cache generation numbers monotonically in
  order to avoid collision and use of stale information in the scheduler. ([#63264](https://github.com/kubernetes/kubernetes/pull/63264), [@bsalamat](https://github.com/bsalamat))
* `nodeSelector` has a new field called `matchFields`. It can be used to constraint placement of a
 Pod on a Node with the given name. ([#62453](https://github.com/kubernetes/kubernetes/pull/62453), [@k82cn](https://github.com/k82cn))

### Sig Storage
* gitRepo volumes in pods no longer require git 1.8.5 or newer; older git versions are now supported. ([#62394](https://github.com/kubernetes/kubernetes/pull/62394), [@jsafrane](https://github.com/jsafrane))
* Added support for resizing Portworx volumes. (#62308, @harsh-px)

#### Pending

* Adding CSI driver registration code. (#64560, @sbezverk)
* Fixed CSI gRPC connection leak during volume operations. (#64519, @vladimirvivien)
* Fixed error reporting of CSI volumes attachment. (#63303, @jsafrane)
* Fixed SELinux relabeling of CSI volumes. (#64026, @jsafrane)
* Fixed detach of already detached CSI volumes. (#63295, @jsafrane)
* Provides API support for external CSI storage drivers to support block volumes. (#64723, @vladimirvivien)
* Updated Container Storage Interface specification version to v0.3.0 (#64719, @davidz627)
* minor fix for VolumeZoneChecker predicate, storageclass can be in annotation and spec. (#63749, @wenlxie)
* Fixes issue for readOnly subpath mounts for SELinux systems and when the volume mountPath already existed in the container image. (#64351, @msau42)
* Volume topology aware dynamic provisioning (#63193, @lichuqiang)
* Add a volume projection that is able to project service account tokens. (#62005, @mikedanese)
* PodSecurityPolicy now supports restricting hostPath volume mounts to be readOnly and under specific path prefixes (#58647, @jhorwit2)
* API change for volume topology aware dynamic provisioning (#63233, @lichuqiang)
* Add Alpha support for dynamic volume limits based on node type (#64154, @gnufied)
* AWS EBS volumes can be now used as ReadOnly in pods. (#64403, @jsafrane)
* Move Volume expansion to Beta (#64288, @gnufied)
* Basic plumbing for volume topology aware dynamic provisioning (#63232, @lichuqiang)
* Changes ext3/ext4 volume creation to not reserve any portion of the volume for the root user. (#64102, @atombender)

### Sig Vsphere

* Adds a mechanism in vSphere Cloud Provider to get credentials from Kubernetes secrets (#63902, @abrarshivani)
* vSphere Cloud Provider: add SAML token authentication support (#63824, @dougm)


### Sig Windows

* Add log and fs stats for Windows containers (#62266, @feiskyer)
* Fail fast if cgroups-per-qos is set on Windows (#62984, @feiskyer)



### Sig Windows

This release supports more of Kubernetes API for pods and containers on Windows:

* Metrics: Pod, Container, Log filesystem ([#62266](https://github.com/kubernetes/kubernetes/pull/62266), [@feiskyer](https://github.com/feiskyer))
* Security contexts: run_as_user [#64009](https://github.com/kubernetes/kubernetes/pull/64009), ([@feiskyer](https://github.com/feiskyer))
* Storage: Local persistent volumes ([#62012](https://github.com/kubernetes/kubernetes/pull/62012), [@andyzhangx](https://github.com/andyzhangx)) and fstype for Azure disk ([#61267](https://github.com/kubernetes/kubernetes/pull/61267), [@andyzhangx](https://github.com/andyzhangx))

Improvements in Windows Server version 1803 also bring new storage functionality to Kubernetes v1.11

* Volume mounts for ConfigMap and Secret
* Flexvolume plugins for SMB and iSCSI storage are also available out-of-tree at [Microsoft/K8s-Storage-Plugins](https://github.com/Microsoft/K8s-Storage-Plugins)

### Uncategorized

* Added prometheus cluster monitoring addon to kube-up ([#62195](https://github.com/kubernetes/kubernetes/pull/62195), [@serathius](https://github.com/serathius))
* kube-apiserver: oidc authentication now supports requiring specific claims with `--oidc-required-claim=<claim>=<value>` ([#62136](https://github.com/kubernetes/kubernetes/pull/62136), [@rithujohn191](https://github.com/rithujohn191))
* The CRD OpenAPI v3 specification for validation now allows additionalProperties, which are mutually exclusive to properties. ([#62333](https://github.com/kubernetes/kubernetes/pull/62333), [@sttts](https://github.com/sttts))
* Extend the Stackdriver Metadata Agent by adding a new Deployment for ingesting unscheduled pods and services.   ([#62043](https://github.com/kubernetes/kubernetes/pull/62043), [@supriyagarg](https://github.com/supriyagarg))
* Kubelet now exposes a new endpoint, `/metrics/probes`, which exposes a Prometheus metric containing the liveness and/or readiness probe results for a container. ([#61369](https://github.com/kubernetes/kubernetes/pull/61369), [@rramkumar1](https://github.com/rramkumar1))
* `kubectl patch` now supports `--dry-run`. ([#60675](https://github.com/kubernetes/kubernetes/pull/60675), [@timoreimann](https://github.com/timoreimann))
* You can now use the `base64decode` function in kubectl go templates to decode base64-encoded data such as `kubectl get secret SECRET -o go-template='{{ .data.KEY | base64decode }}'`. ([#60755](https://github.com/kubernetes/kubernetes/pull/60755), [@glb](https://github.com/glb))
* Added `MatchFields` to `NodeSelectorTerm`; in 1.11, it only supports `metadata.name`. ([#62002](https://github.com/kubernetes/kubernetes/pull/62002), [@k82cn](https://github.com/k82cn))

### Pending

* kubectl no longer renders a List as suffix kind name for CRD resources ([#62512](https://github.com/kubernetes/kubernetes/pull/62512), [@dixudx](https://github.com/dixudx))
* Updated kube-dns to Version 1.14.10. Major changes: ([#62676](https://github.com/kubernetes/kubernetes/pull/62676), [@MrHohn](https://github.com/MrHohn))
    * Fixed a bug in DNS resolution for externalName services
    * and PTR records that need to query from upstream nameserver.
* Add generators for `apps/v1` deployments. ([#61288](https://github.com/kubernetes/kubernetes/pull/61288), [@ayushpateria](https://github.com/ayushpateria))
* kubectl: improves compatibility with older servers when creating/updating API objects **(EDITOR'S NOTE: Specifically ...?) ([#61949](https://github.com/kubernetes/kubernetes/pull/61949), [@liggitt](https://github.com/liggitt))
* `kubectl apply` view/edit-last-applied support completion. ([#60499](https://github.com/kubernetes/kubernetes/pull/60499), [@superbrothers](https://github.com/superbrothers))
* Add all kinds of resource objects' statuses in HPA description. ([#59609](https://github.com/kubernetes/kubernetes/pull/59609), [@zhangxiaoyu-zidif](https://github.com/zhangxiaoyu-zidif))
* Add apiserver configuration option to choose audit output version. **(Which is?)** ([#60056](https://github.com/kubernetes/kubernetes/pull/60056), [@crassirostris](https://github.com/crassirostris))
* Implement preemption for extender with a verb and new interface ([#58717](https://github.com/kubernetes/kubernetes/pull/58717), [@resouer](https://github.com/resouer))
* adds the `kubeadm upgrade diff` command to show how static pod manifests will be changed by an upgrade. (#63930, @liztio)
* Adds a `kubeadm config images pull` command to pull container images used by kubeadm. (#63833, @chuckha)
* Restores the pre-1.10 behavior of the openstack cloud provider which uses the instance name as the Kubernetes Node name. This requires instances be named with RFC-1123 compatible names. (#63903, @liggitt)
* Added support for NFS relations on kubernetes-worker charm. (#63817, @hyperbolic2346)
* Kubernetes cluster on GCE have crictl installed now. Users can use it to help debug their node. The documentation of crictl can be found https://github.com/kubernetes-incubator/cri-tools/blob/master/docs/crictl.md. (#63357, @Random-Liu)
* The NodeRestriction admission plugin now prevents kubelets from modifying/removing taints applied to their Node API object. (#63167, @liggitt)
* kubeadm now checks that IPv4/IPv6 forwarding is enabled (#63872, @kad)
* kubeadm will now deploy CoreDNS by default instead of KubeDNS (#63509, @detiber)
* owner references can be set during creation without deletion power (#63403, @deads2k)
* Implements OIDC distributed claims. (#63213, @filmil)
* Use /usr/bin/env in all script shebangs to increase portability. (#62657, @matthyx)
* `kubectl cp` supports completion. (#60371, @superbrothers)
* Azure VMSS: support VM names to contain the `_` character (#63526, @djsly)
* Create a new `dryRun` query parameter for mutating endpoints. If the parameter is set, then the query will be rejected, as the feature is not implemented yet. This will allow forward compatibility with future clients; otherwise, future clients talking with older apiservers might end up modifying a resource even if they include the `dryRun` query parameter. (#63557, @apelisse)
* Search standard KubeConfig file locations when using `kubeadm token` without `--kubeconfig`. (#62850, @neolit123)
*   Include the list of security groups when failing with the errors that more then one is tagged (#58874, @sorenmat)
* Allow "required" to be used at the CRD OpenAPI validation schema when the /status subresource is enabled. (#63533, @sttts)
* try to read openstack auth config from client config and fall back to read from the environment variables if not available (#60200, @dixudx)
* Services can listen on same host ports on different interfaces with --nodeport-addresses specified (#62003, @m1093782566)
* Adding initial Korean translation for kubectl (#62040, @ianychoi)
* Report node DNS info with --node-ip flag (#63170, @micahhausler)
* CustomResourceDefinitions Status subresource now supports GET and PATCH (#63619, @roycaihw)
* Re-enable nodeipam controller for external clouds.  (#63049, @andrewsykim)
* Removes a preflight check for kubeadm that validated custom kube-apiserver, kube-controller-manager and kube-scheduler arguments. (#63673, @chuckha)
* Adds a list-images subcommand to kubeadm that lists required images for a kubeadm install. (#63450, @chuckha)
* list/watch API requests with a fieldSelector that specifies `metadata.name` can now be authorized as requests for an individual named resource (#63469, @wojtek-t)
* Add a way to pass extra arguments to etcd. (#63961, @mborsz)
* `kubectl delete` with selection criteria defaults to ignoring not found errors (#63490, @deads2k)
* When updating /status subresource of a custom resource, only the value at the `.status` subpath for the update is considered. (#63385, @CaoShuFeng)
* Supported nodeSelector.matchFields (node's `metadata.node`) in scheduler. (#62453, @k82cn)
* Kubelet will set extended resource capacity to zero after it restarts. If the extended resource is exported by a device plugin, its capacity will change to a valid value after the device plugin re-connects with the Kubelet. If the extended resource is exported by an external component through direct node status capacity patching, the component should repatch the field after kubelet becomes ready again. During the time gap, pods previously assigned with such resources may fail kubelet admission but their controller should create new pods in response to such failures. (#64784, @jiayingz)
* The Sysctls experimental feature has been promoted to beta (enabled by default via the `Sysctls` feature flag). PodSecurityPolicy and Pod objects now have fields for specifying and controlling sysctls. Alpha sysctl annotations will be ignored by 1.11+ kubelets. All alpha sysctl annotations in existing deployments must be converted to API fields to be effective. (#63717, @ingvagabund)
* Kubelet: Add security context for Windows containers (#64009, @feiskyer)
* Add proxy for container streaming in kubelet for streaming auth. (#64006, @Random-Liu)
* Implement kubelet side online file system resizing (#62460, @mlmhl)
* The maximum number of images the Kubelet will report in the Node status can now be controlled via the Kubelet's --node-status-max-images flag. The default (50) remains the same. (#64170, @mtaufen)
* Add probe based mechanism for kubelet plugin discovery (#63328, @vikaschoudhary16)
* The dynamic Kubelet config feature is now beta, and the DynamicKubeletConfig feature gate is on by default. In order to use dynamic Kubelet config, ensure that the Kubelet's --dynamic-config-dir option is set.  (#64275, @mtaufen)
* Add reason message logs for non-exist Azure resources (#64248, @feiskyer)
* The Kubelet now exports metrics that report the assigned (node_config_assigned), last-known-good (node_config_last_known_good), and active (node_config_active) config sources, and a metric indicating whether the node is experiencing a config-related error (node_config_error). The config source metrics always report the value 1, and carry the node_config_name, node_config_uid, node_config_resource_version, and node_config_kubelet_key labels, which identify the config version. The error metric reports 1 if there is an error, 0 otherwise. (#57527, @mtaufen)
* The kubelet certificate rotation feature can now be enabled via the `.RotateCertificates` field in the kubelet's config file. The `--rotate-certificates` flag is now deprecated, and will be removed in a future release. (#63912, @luxas)
* The dynamic Kubelet config feature will now update config in the event of a ConfigMap mutation, which reduces the chance for silent config skew. Only name, namespace, and kubeletConfigKey may now be set in Node.Spec.ConfigSource.ConfigMap. The least disruptive pattern for config management is still to create a new ConfigMap and incrementally roll out a new Node.Spec.ConfigSource. (#63221, @mtaufen)
* The NodeRestriction admission plugin now prevents kubelets from modifying/removing taints applied to their Node API object. (#63167, @liggitt)
* The status of dynamic Kubelet config is now reported via Node.Status.Config, rather than the KubeletConfigOk node condition. (#63314, @mtaufen)
* kubelet: fix hangs in updating Node status after network interruptions/changes between the kubelet and API server (#63492, @liggitt)
* The Kubelet's deprecated --allow-privileged flag now defaults to true. This enables users to stop setting --allow-privileged in order to transition to PodSecurityPolicy. Previously, users had to continue setting --allow-privileged, because the default was false. (#63442, @mtaufen)
* You must now specify Node.Spec.ConfigSource.ConfigMap.KubeletConfigKey when using dynamic Kubelet config to tell the Kubelet which key of the ConfigMap identifies its config file. (#59847, @mtaufen)
* Introduce ContainersReady condition in Pod Status (#64646, @freehan)
* Ability to quota resources by priority (#57963, @vikaschoudhary16)
* Add parametrizable priority function mapping requested/capacity ratio to priority (#63929, @losipiuk)
* PodSecurityPolicy admission information is added to audit logs (#58143, @CaoShuFeng)
* Adds feature gate for plugin watcher (#64605, @vikaschoudhary16)
* TokenRequests now are required to have an expiration duration between 10 minutes and 2^32 seconds. (#63999, @mikedanese)
* Expose `/debug/flags/v` to allow dynamically set glog logging level, if want to change glog level to 3, you only have to send a PUT request with like `curl -X PUT http://127.0.0.1:8080/debug/flags/v -d "3"`. (#63777, @hzxuzhonghu)
* New conformance test added for Watch. (#61424, @jennybuckley)
* Exec authenticator plugin supports TLS client certificates. (#61803, @awly)
* Use Patch instead of Put to sync pod status (#62306, @freehan)
* Update nvidia-gpu-device-plugin DaemonSet config to use RollingUpdate updateStrategy instead of OnDelete. (#64296, @mindprince)
* API server properly parses propagationPolicy as a query parameter sent with a delete request (#63414, @roycaihw)
* Property `serverAddressByClientCIDRs` in `metav1.APIGroup` (discovery API) now become optional instead of required (#61963, @roycaihw)
* apiservices/status and certificatesigningrequests/status now support GET and PATCH (#64063, @roycaihw)
* Allow env from resource with keys & updated tests (#60636, @PhilipGough)
* APIServices with kube-like versions (e.g. v1, v2beta1, etc.) will be sorted appropriately within each group.  (#64004, @mbohlool)
* event object references with apiversion will now report an apiversion. (#63913, @deads2k)
* increase grpc client default response size (#63977, @runcom)
* HTTP transport now uses `context.Context` to cancel dial operations. k8s.io/client-go/transport/Config struct has been updated to accept a function with a `context.Context` parameter. This is a breaking change if you use this field in your code. (#60012, @ash2k)
* Remove UID mutation from request.context. (#63957, @hzxuzhonghu)
* list/watch API requests with a fieldSelector that specifies `metadata.name` can now be authorized as requests for an individual named resource (#63469, @wojtek-t)
* Added support for NFS relations on kubernetes-worker charm. (#63817, @hyperbolic2346)
* Create a new `dryRun` query parameter for mutating endpoints. If the parameter is set, then the query will be rejected, as the feature is not implemented yet. This will allow forward compatibility with future clients; otherwise, future clients talking with older apiservers might end up modifying a resource even if they include the `dryRun` query parameter. (#63557, @apelisse)
* Services can listen on same host ports on different interfaces with --nodeport-addresses specified (#62003, @m1093782566)
* corrects a race condition in bootstrapping aggregated cluster roles in new HA clusters (#63761, @liggitt)
* Re-enable nodeipam controller for external clouds.  (#63049, @andrewsykim)
* Apply pod name and namespace labels to pod cgroup in cAdvisor metrics (#63406, @derekwaynecarr)
* GC is now bound by QPS (it wasn't before) and so if you need more QPS to avoid ratelimiting GC, you'll have to set it. (#63657, @shyamjvs)
*   Include the list of security groups when failing with the errors that more then one is tagged (#58874, @sorenmat)
* [fluentd-gcp addon] Use the logging agent's node name as the metadata agent URL. (#63353, @bmoyles0117)



#### New Stuff

#### Version Upgrades

* Update version of Istio addon from 0.5.1 to 0.6.0. ([#61911](https://github.com/kubernetes/kubernetes/pull/61911), [@ostromart](https://github.com/ostromart))
    * See https://istio.io/about/notes/0.6.html for full Isto release notes.
* Upgrade the default etcd server version to 3.2.18 ([#61198](https://github.com/kubernetes/kubernetes/pull/61198), [@jpbetz](https://github.com/jpbetz))
* GCE: Bump GLBC version to 1.1.0 - supporting multiple certificates and HTTP2 ([#62427](https://github.com/kubernetes/kubernetes/pull/62427), [@nicksardo](https://github.com/nicksardo))
* Cluster Autoscaler 1.2.1 (release notes: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.2.1) ([#62457](https://github.com/kubernetes/kubernetes/pull/62457), [@mwielgus](https://github.com/mwielgus))
* Update kube-dns to Version 1.14.9 in kubeadm. ([#61918](https://github.com/kubernetes/kubernetes/pull/61918), [@MrHohn](https://github.com/MrHohn))
* GCE: Updates GLBC version to 1.0.1 which includes a fix which prevents multi-cluster ingress objects from creating full load balancers. ([#62075](https://github.com/kubernetes/kubernetes/pull/62075), [@nicksardo](https://github.com/nicksardo))
* Update to use go1.10.1 ([#60597](https://github.com/kubernetes/kubernetes/pull/60597), [@cblecker](https://github.com/cblecker))
* Rev the Azure SDK for networking to 2017-06-01 ([#61955](https://github.com/kubernetes/kubernetes/pull/61955), [@brendandburns](https://github.com/brendandburns))
* Update kube-dns to Version 1.14.9. Major changes: ([#61908](https://github.com/kubernetes/kubernetes/pull/61908), [@MrHohn](https://github.com/MrHohn))
    * - Fix for kube-dns returns NXDOMAIN when not yet synced with apiserver.
    * - Don't generate empty record for externalName service.
    * - Add validation for upstreamNameserver port.
    * - Update go version to 1.9.3.
* Cluster Autoscaler 1.2.0 - release notes available here: https://github.com/kubernetes/autoscaler/releases ([#61561](https://github.com/kubernetes/kubernetes/pull/61561), [@mwielgus](https://github.com/mwielgus))
* Bump Heapster to v1.5.2 ([#61396](https://github.com/kubernetes/kubernetes/pull/61396), [@kawych](https://github.com/kawych))
* Update to use go1.10.2 ([#63412](https://github.com/kubernetes/kubernetes/pull/63412), [@praseodym](https://github.com/praseodym))
* Update istio addon manifest to 0.8 (#64537, @ostromart)
* Update cadvisor godeps to v0.30.0 (#64800, @dashpole)
* GCE: Update cloud provider to use TPU v1 API (#64727, @yguo0905)
* Update event-exporter to version v0.2.0  that supports old (gke_container/gce_instance) and new (k8s_container/k8s_node/k8s_pod) stackdriver resources. (#63918, @cezarygerard)
* Update to use go1.10.2 (#63412, @praseodym)
* Cluster Autoscaler 1.2.2 (release notes: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.2.2) (#63974, @aleksandra-malinowska)



#### Not Very Notable

* [fluentd-gcp addon] Update event-exporter image to have the latest base image. ([#61727](https://github.com/kubernetes/kubernetes/pull/61727), [@crassirostris](https://github.com/crassirostris))
* cluster/kube-up.sh now provisions a Kubelet config file for GCE via the metadata server. This file is installed by the corresponding GCE init scripts. ([#62183](https://github.com/kubernetes/kubernetes/pull/62183), [@mtaufen](https://github.com/mtaufen))
* Make volume usage metrics available for Cinder ([#62668](https://github.com/kubernetes/kubernetes/pull/62668), [@zetaab](https://github.com/zetaab))
* cinder volume plugin :  ([#61082](https://github.com/kubernetes/kubernetes/pull/61082), [@wenlxie](https://github.com/wenlxie))
    * When the cinder volume status is `error`,  controller will not do `attach ` and `detach ` operation
* Allow user to scale l7 default backend deployment ([#62685](https://github.com/kubernetes/kubernetes/pull/62685), [@freehan](https://github.com/freehan))
* Add support to ingest log entries to Stackdriver against new "k8s_container" and "k8s_node" resources. ([#62076](https://github.com/kubernetes/kubernetes/pull/62076), [@qingling128](https://github.com/qingling128))
* Disabled CheckNodeMemoryPressure and CheckNodeDiskPressure predicates if TaintNodesByCondition enabled ([#60398](https://github.com/kubernetes/kubernetes/pull/60398), [@k82cn](https://github.com/k82cn))
* Support custom test configuration for IPAM performance integration tests ([#61959](https://github.com/kubernetes/kubernetes/pull/61959), [@satyasm](https://github.com/satyasm))
* OIDC authentication now allows tokens without an "email_verified" claim when using the "email" claim. If an "email_verified" claim is present when using the "email" claim, it must be `true`. ([#61508](https://github.com/kubernetes/kubernetes/pull/61508), [@rithujohn191](https://github.com/rithujohn191))
* Add e2e test for CRD Watch ([#61025](https://github.com/kubernetes/kubernetes/pull/61025), [@ayushpateria](https://github.com/ayushpateria))
* Return error if get NodeStageSecret and NodePublishSecret failed in CSI volume plugin ([#61096](https://github.com/kubernetes/kubernetes/pull/61096), [@mlmhl](https://github.com/mlmhl))
* kubernetes-master charm now supports metrics server for horizontal pod autoscaler. ([#60174](https://github.com/kubernetes/kubernetes/pull/60174), [@hyperbolic2346](https://github.com/hyperbolic2346))
* Add ipset and udevadm to the hyperkube base image. ([#61357](https://github.com/kubernetes/kubernetes/pull/61357), [@rphillips](https://github.com/rphillips))
* In a GCE cluster, the default `HAIRPIN_MODE` is now "hairpin-veth". ([#60166](https://github.com/kubernetes/kubernetes/pull/60166), [@rramkumar1](https://github.com/rramkumar1))
* Balanced resource allocation priority in scheduler to include volume count on node  ([#60525](https://github.com/kubernetes/kubernetes/pull/60525), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
* new dhcp-domain parameter to be used for figuring out the hostname of a node ([#61890](https://github.com/kubernetes/kubernetes/pull/61890), [@dims](https://github.com/dims))
* The node authorizer now automatically sets up rules for Node.Spec.ConfigSource when the DynamicKubeletConfig feature gate is enabled. ([#60100](https://github.com/kubernetes/kubernetes/pull/60100), [@mtaufen](https://github.com/mtaufen))
* Disable ipamperf integration tests as part of every PR verification. ([#61863](https://github.com/kubernetes/kubernetes/pull/61863), [@satyasm](https://github.com/satyasm))
* Enable server-side print in kubectl by default, with the ability to turn it off with --server-print=false ([#61477](https://github.com/kubernetes/kubernetes/pull/61477), [@soltysh](https://github.com/soltysh))
* Updated admission controller settings for Juju deployed Kubernetes clusters ([#61427](https://github.com/kubernetes/kubernetes/pull/61427), [@hyperbolic2346](https://github.com/hyperbolic2346))
* Performance test framework and basic tests for the IPAM controller, to simulate behavior ([#61143](https://github.com/kubernetes/kubernetes/pull/61143), [@satyasm](https://github.com/satyasm))
    * of the four supported modes under lightly loaded and loaded conditions, where load is
    * defined as the number of operations to perform as against the configured kubernetes
    * API server QPS.
* Automatically add system critical priority classes at cluster boostrapping. ([#60519](https://github.com/kubernetes/kubernetes/pull/60519), [@bsalamat](https://github.com/bsalamat))
* Removed always pull policy from the template for ingress on CDK. ([#61598](https://github.com/kubernetes/kubernetes/pull/61598), [@hyperbolic2346](https://github.com/hyperbolic2346))
* `make test-cmd` now works on OSX. ([#61393](https://github.com/kubernetes/kubernetes/pull/61393), [@totherme](https://github.com/totherme))
* Conformance: ReplicaSet must be supported in the `apps/v1` version. ([#61367](https://github.com/kubernetes/kubernetes/pull/61367), [@enisoc](https://github.com/enisoc))
* Remove 'system' prefix from Metadata Agent rbac configuration ([#61394](https://github.com/kubernetes/kubernetes/pull/61394), [@kawych](https://github.com/kawych))
* Support new NODE_OS_DISTRIBUTION 'custom' on GCE ([#61235](https://github.com/kubernetes/kubernetes/pull/61235), [@yguo0905](https://github.com/yguo0905))
    * on a new add event.
* include file name in the error when visiting files ([#60919](https://github.com/kubernetes/kubernetes/pull/60919), [@dixudx](https://github.com/dixudx))
* Split PodPriority and PodPreemption feature gate (#62243, @resouer)
* Code generated for CRDs now passes `go vet`. (#62412, @bhcleek)
* "beginPort+offset" format support for port range which affects kube-proxy only ([#58731](https://github.com/kubernetes/kubernetes/pull/58731), [@yue9944882](https://github.com/yue9944882))
* Added e2e test for watch ([#60331](https://github.com/kubernetes/kubernetes/pull/60331), [@jennybuckley](https://github.com/jennybuckley))
* kubeadm: prompt the user for confirmation when resetting a master node (#59115, @alexbrand)
* add warnings on using pod-infra-container-image for remote container runtime (#62982, @dixudx)
* kubeadm creates kube-proxy with a toleration to run on all nodes, no matter the taint. (#62390, @discordianfish)
* Mount additional paths required for a working CA root, for setups where /etc/ssl/certs doesn't contains certificates but just symlink. (#59122, @klausenbusk)
* Introduce truncating audit backend that can be enabled for existing backend to limit the size of individual audit events and batches of events. (#61711, @crassirostris)
* Modify the kubeadm upgrade DAG for the TLS Upgrade (#62655, @stealthybox)
* stop kubelet to cloud provider integration potentially wedging kubelet sync loop (#62543, @ingvagabund)
* Set pod status to "Running" if there is at least one container still reporting as "Running" status and others are "Completed". (#62642, @ceshihao)
* Add 'UpdateStrategyType' and 'RollingUpdateStrategy' to 'kubectl describe sts' command output. (#63844, @tossmilestone)
* kubeadm has removed `.Etcd.SelfHosting` from its configuration API. It was never used in practice. (#63871, @luxas)
* Fix memory cgroup notifications, and reduce associated log spam. (#63220, @dashpole)
* The status of dynamic Kubelet config is now reported via Node.Status.Config, rather than the KubeletConfigOk node condition. (#63314, @mtaufen)
* use subtest for table units (pkg-scheduler-algorithm-priorities) (#63658, @xchapter7x)
* CRI: update documents for container logpath. The container log path has been changed from containername_attempt#.log to containername/attempt#.log  (#62015, @feiskyer)
* kubeadm will no longer generate an unused etcd CA and certificates when configured to use an external etcd cluster. (#63806, @detiber)
* Apply pod name and namespace labels to pod cgroup in cAdvisor metrics (#63406, @derekwaynecarr)

## Bug Fixes

### Pending

#### User Facing

* Fixes issue where PersistentVolume.NodeAffinity.NodeSelectorTerms were ANDed instead of ORed. ([#62556](https://github.com/kubernetes/kubernetes/pull/62556), [@msau42](https://github.com/msau42))
* Fix potential infinite loop that can occur when NFS PVs are recycled. ([#62572](https://github.com/kubernetes/kubernetes/pull/62572), [@joelsmith](https://github.com/joelsmith))
* Fixed column alignment when kubectl get is used with custom columns from OpenAPI schema ([#56629](https://github.com/kubernetes/kubernetes/pull/56629), [@luksa](https://github.com/luksa))
* kubectl: restore the ability to show resource kinds when displaying multiple objects ([#61985](https://github.com/kubernetes/kubernetes/pull/61985), [@liggitt](https://github.com/liggitt))
* Fixed a panic in `kubectl run --attach ...` when the api server failed to create the runtime object (due to name conflict, PSP restriction, etc.) ([#61713](https://github.com/kubernetes/kubernetes/pull/61713), [@mountkin](https://github.com/mountkin))
* kube-scheduler has been fixed to use `--leader-elect` option back to true (as it was in previous versions) ([#59732](https://github.com/kubernetes/kubernetes/pull/59732), [@dims](https://github.com/dims))
* kubectl: fixes issue with `-o yaml` and `-o json` omitting kind and apiVersion when used with `--dry-run` ([#61808](https://github.com/kubernetes/kubernetes/pull/61808), [@liggitt](https://github.com/liggitt))
* Ensure reasons end up as comments in `kubectl edit`. ([#60990](https://github.com/kubernetes/kubernetes/pull/60990), [@bmcstdio](https://github.com/bmcstdio))
* Remove UID mutation from request.context. (#63957, @hzxuzhonghu)
* minor fix for VolumeZoneChecker predicate, storageclass can be in annotation and spec. (#63749, @wenlxie)
* Fixes issue where subpath readOnly mounts failed (#63045, @msau42)
* `kubectl create [secret | configmap] --from-file` now works on Windows with fully-qualified paths (#63439, @liggitt)
* Fix stackdriver metrics for node memory using wrong metric type (#63535, @serathius)
* kubeadm upgrade now supports external etcd setups again (#63495, @detiber)
* fix mount unmount failure for a Windows pod (#63272, @andyzhangx)
* Do not check vmSetName when getting Azure node's IP (#63541, @feiskyer)
* [fluentd-gcp addon] Use the logging agent's node name as the metadata agent URL. (#63353, @bmoyles0117)
* corrects a race condition in bootstrapping aggregated cluster roles in new HA clusters (#63761, @liggitt)

#### General Fixes and Reliability

* Fix regression in `v1.JobSpec.backoffLimit` that caused failed Jobs to be restarted indefinitely. (#63650, @soltysh)
* fixes a potential deadlock in the garbage collection controller (#64235, @liggitt)
* fix formatAndMount func issue on Windows (#63248, @andyzhangx)
* Dynamic env in subpath - Fixes Issue 48677 (#49388, @kevtaylor)
* Fix issue of colliding nodePorts when the cluster has services with externalTrafficPolicy=Local (#64349, @nicksardo)
* fixes a panic applying json patches containing out of bounds operations (#64355, @liggitt)
* Fix incorrectly propagated ResourceVersion in ListRequests returning 0 items. (#64150, @wojtek-t)
* Fix memory cgroup notifications, and reduce associated log spam. (#63220, @dashpole)
* GCE: Fix to make the built-in `kubernetes` service properly point to the master's load balancer address in clusters that use multiple master VMs. (#63696, @grosskur)
* fix mount unmount failure for a Windows pod (#63272, @andyzhangx)
* Fix stackdriver metrics for node memory using wrong metric type (#63535, @serathius)
* Fixes issue where subpath readOnly mounts failed (#63045, @msau42)
* Fixes fake client generation for non-namespaced subresources (#60445, @jhorwit2)
* Fixed #731 kubeadm upgrade ignores HighAvailability feature gate ([#62455](https://github.com/kubernetes/kubernetes/pull/62455), [@fabriziopandini](https://github.com/fabriziopandini))
* Schedule even if extender is not available when using extender  ([#61445](https://github.com/kubernetes/kubernetes/pull/61445), [@resouer](https://github.com/resouer))
* Fix panic create/update CRD when mutating/validating webhook configured. ([#61404](https://github.com/kubernetes/kubernetes/pull/61404), [@hzxuzhonghu](https://github.com/hzxuzhonghu))
* Pods requesting resources prefixed with `*kubernetes.io` will remain unscheduled if there are no nodes exposing that resource. ([#61860](https://github.com/kubernetes/kubernetes/pull/61860), [@mindprince](https://github.com/mindprince))
* fix scheduling policy on ConfigMap breaks without the --policy-configmap-namespace flag set ([#61388](https://github.com/kubernetes/kubernetes/pull/61388), [@zjj2wry](https://github.com/zjj2wry))
* fix sorting taints in case the sorting keys are equal ([#61255](https://github.com/kubernetes/kubernetes/pull/61255), [@dixudx](https://github.com/dixudx))
* fix sorting tolerations in case the keys are equal ([#61252](https://github.com/kubernetes/kubernetes/pull/61252), [@dixudx](https://github.com/dixudx))
* Bugfix for erroneous upgrade needed messaging in kubernetes worker charm. ([#60873](https://github.com/kubernetes/kubernetes/pull/60873), [@wwwtyro](https://github.com/wwwtyro))
* Fix inter-pod anti-affinity check to consider a pod a match when all the anti-affinity terms match. ([#62715](https://github.com/kubernetes/kubernetes/pull/62715), [@bsalamat](https://github.com/bsalamat))
* GCE: Bump GLBC version to 1.1.1 - fixing an issue of handling multiple certs with identical certificates ([#62751](https://github.com/kubernetes/kubernetes/pull/62751), [@nicksardo](https://github.com/nicksardo))
* Pod affinity `nodeSelectorTerm.matchExpressions` may now be empty, and works as previously documented: nil or empty `matchExpressions` matches no objects in scheduler. ([#62448](https://github.com/kubernetes/kubernetes/pull/62448), [@k82cn](https://github.com/k82cn))
* Fix an issue in inter-pod affinity predicate that cause affinity to self being processed incorrectly ([#62591](https://github.com/kubernetes/kubernetes/pull/62591), [@bsalamat](https://github.com/bsalamat))
* fix WaitForAttach failure issue for azure disk ([#62612](https://github.com/kubernetes/kubernetes/pull/62612), [@andyzhangx](https://github.com/andyzhangx))
* Fix user visible files creation for windows ([#62375](https://github.com/kubernetes/kubernetes/pull/62375), [@feiskyer](https://github.com/feiskyer))
* Fix machineID getting for vmss nodes when using instance metadata ([#62611](https://github.com/kubernetes/kubernetes/pull/62611), [@feiskyer](https://github.com/feiskyer))
* Fix Forward chain default reject policy for IPVS proxier ([#62007](https://github.com/kubernetes/kubernetes/pull/62007), [@m1093782566](https://github.com/m1093782566))
* fix nsenter GetFileType issue in containerized kubelet ([#62467](https://github.com/kubernetes/kubernetes/pull/62467), [@andyzhangx](https://github.com/andyzhangx))
* Ensure expected load balancer is selected for Azure ([#62450](https://github.com/kubernetes/kubernetes/pull/62450), [@feiskyer](https://github.com/feiskyer))
* Resolves forbidden error when the `daemon-set-controller` cluster role access `controllerrevisions` resources. ([#62146](https://github.com/kubernetes/kubernetes/pull/62146), [@frodenas](https://github.com/frodenas))
* kubeadm: surface external etcd preflight validation errors ([#60585](https://github.com/kubernetes/kubernetes/pull/60585), [@alexbrand](https://github.com/alexbrand))
* fix incompatible file type checking on Windows ([#62154](https://github.com/kubernetes/kubernetes/pull/62154), [@dixudx](https://github.com/dixudx))
* fix local volume absolute path issue on Windows ([#62018](https://github.com/kubernetes/kubernetes/pull/62018), [@andyzhangx](https://github.com/andyzhangx))
* fix the issue that default azure disk fsypte(ext4) does not work on Windows ([#62250](https://github.com/kubernetes/kubernetes/pull/62250), [@andyzhangx](https://github.com/andyzhangx))
* Fixed bug in rbd-nbd utility when nbd is used. ([#62168](https://github.com/kubernetes/kubernetes/pull/62168), [@piontec](https://github.com/piontec))
* fix local volume issue on Windows ([#62012](https://github.com/kubernetes/kubernetes/pull/62012), [@andyzhangx](https://github.com/andyzhangx))
* Fix a bug that fluentd doesn't inject container logs for CRI container runtimes (containerd, cri-o etc.) into elasticsearch on GCE. ([#61818](https://github.com/kubernetes/kubernetes/pull/61818), [@Random-Liu](https://github.com/Random-Liu))
* flexvolume: trigger plugin init only for the relevant plugin while probe ([#58519](https://github.com/kubernetes/kubernetes/pull/58519), [@linyouchong](https://github.com/linyouchong))
* Fixed ingress issue with CDK and pre-1.9 versions of kubernetes. ([#61859](https://github.com/kubernetes/kubernetes/pull/61859), [@hyperbolic2346](https://github.com/hyperbolic2346))
* Fix racy panics when using fake watches with ObjectTracker ([#61195](https://github.com/kubernetes/kubernetes/pull/61195), [@grantr](https://github.com/grantr))
* Fix mounting of UNIX sockets(and other special files) in subpaths ([#61480](https://github.com/kubernetes/kubernetes/pull/61480), [@gnufied](https://github.com/gnufied))
* Fixed [#61123](https://github.com/kubernetes/kubernetes/pull/61123) by triggering syncer.Update on all cases including when a syncer is created ([#61124](https://github.com/kubernetes/kubernetes/pull/61124), [@satyasm](https://github.com/satyasm))
* Fix data race in node lifecycle controller ([#60831](https://github.com/kubernetes/kubernetes/pull/60831), [@resouer](https://github.com/resouer))
* fix resultRun by resetting it to 0 on pod restart (#62853, @tony612)
* Fix the liveness probe to use `/bin/bash -c` instead of `/bin/bash c`. (#63033, @bmoyles0117)
* Fix scheduler informers to receive events for all the pods in the cluster. (#63003, @bsalamat)
* Fix in vSphere Cloud Provider to handle upgrades from kubernetes version less than v1.9.4 to v1.9.4 and above. (#62919, @abrarshivani)
* Fix error where config map for Metadata Agent was not created by addon manager. (#62909, @kawych)
* Fixes the kubernetes.default.svc loopback service resolution to use a loopback configuration. (#62649, @liggitt)
* fix permissions to allow statefulset scaling for admins, editors, and viewers (#62336, @deads2k)
* GCE: Fix for internal load balancer management resulting in backend services with outdated instance group links. (#62885, @nicksardo)
* Deployment will stop adding pod-template-hash labels/selector to ReplicaSets and Pods it adopts. Resources created by Deployments are not affected (will still have pod-template-hash labels/selector).  ([#61615](https://github.com/kubernetes/kubernetes/pull/61615), [@janetkuo](https://github.com/janetkuo))
* Use inline func to ensure unlock is executed ([#61644](https://github.com/kubernetes/kubernetes/pull/61644), [@resouer](https://github.com/resouer))
* Ensure cloudprovider.InstanceNotFound is reported when the VM is not found on Azure ([#61531](https://github.com/kubernetes/kubernetes/pull/61531), [@feiskyer](https://github.com/feiskyer))
* CRI: define the mount behavior when host path does not exist: runtime should report error if the host path doesn't exist ([#61460](https://github.com/kubernetes/kubernetes/pull/61460), [@feiskyer](https://github.com/feiskyer))
* kubernetes-master charm now properly clears the client-ca-file setting on the apiserver snap ([#61479](https://github.com/kubernetes/kubernetes/pull/61479), [@hyperbolic2346](https://github.com/hyperbolic2346))
* Bound cloud allocator to 10 retries with 100 ms delay between retries. ([#61375](https://github.com/kubernetes/kubernetes/pull/61375), [@satyasm](https://github.com/satyasm))
* respect fstype in Windows for azure disk ([#61267](https://github.com/kubernetes/kubernetes/pull/61267), [@andyzhangx](https://github.com/andyzhangx))
* Unready pods will no longer impact the number of desired replicas when using horizontal auto-scaling with external metrics or object metrics. ([#60886](https://github.com/kubernetes/kubernetes/pull/60886), [@mattjmcnaughton](https://github.com/mattjmcnaughton))
* Nodes are not deleted from kubernetes anymore if node is shutdown in Openstack. ([#59931](https://github.com/kubernetes/kubernetes/pull/59931), [@zetaab](https://github.com/zetaab))
* authz: nodes should not be able to delete themselves (#62818, @mikedanese)
* removed unsafe double RLock in cpumanager (#62464, @choury)
* kubelet: fix hangs in updating Node status after network interruptions/changes between the kubelet and API server (#63492, @liggitt)
* the shortcuts which were moved server-side in at least 1.9 have been removed from being hardcoded in kubectl (#63507, @deads2k)
* Increase scheduler cache generation number monotonically in order to avoid collision and use of stale information in scheduler. (#63264, @bsalamat)
* Fixes fake client generation for non-namespaced subresources (#60445, @jhorwit2)
* kubelet: fix hangs in updating Node status after network interruptions/changes between the kubelet and API server (#63492, @liggitt)

## Not Sorted Yet

### Action Required


### Other notable changes
