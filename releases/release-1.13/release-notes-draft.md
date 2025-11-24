# Kubernetes 1.13 Release Notes

## Security Content

- CVE-2018-1002105, a critical security issue in the Kubernetes API Server, is resolved in v1.13.0 (and in [v1.10.11](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.10.md/#v11011), [v1.11.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md/#v1115), and [v1.12.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md/#v1123)). We recommend all clusters running previous versions update to one of these releases immediately. See issue [#71411](https://github.com/kubernetes/kubernetes/issues/71411) for details.

## Urgent Upgrade Notes

### (No, really, you MUST do this before you upgrade)

Before upgrading to Kubernetes 1.13, you must keep the following in mind:

- kube-apiserver
  - The deprecated `etcd2` storage backend has been removed. Before upgrading a kube-apiserver using `--storage-backend=etcd2`, etcd v2 data must be migrated to the v3 storage backend, and kube-apiserver invocations changed to use `--storage-backend=etcd3`. Please consult the installation procedure used to set up etcd for specific migration instructions. Backups prior to upgrade are always a good practice, but since the etcd2 to etcd3 migration is not reversible, an etcd backup prior to migration is essential.
  - The deprecated `--etcd-quorum-read` flag has been removed. Quorum reads are now always enabled when fetching data from etcd. Remove the `--etcd-quorum-read` flag from kube-apiserver invocations before upgrading.
- kube-controller-manager
  - The deprecated `--insecure-experimental-approve-all-kubelet-csrs-for-group` flag has been removed.
- kubelet
  - The deprecated `--google-json-key` flag has been removed. Remove the `--google-json-key` flag from kubelet invocations before upgrading. ([#69354](https://github.com/kubernetes/kubernetes/pull/69354), [@yujuhong](https://github.com/yujuhong))
  - DaemonSet pods now make use of scheduling features that require kubelets to be at 1.11 or above. Ensure all kubelets in the cluster are at 1.11 or above before upgrading kube-controller-manager to 1.13.
  - The schema for the alpha `CSINodeInfo` CRD has been split into `spec` and `status` fields, and new fields `status.available` and `status.volumePluginMechanism` added. Clusters using the previous alpha schema must delete and recreate the CRD using the new schema. ([#70515](https://github.com/kubernetes/kubernetes/pull/70515), [@davidz627](https://github.com/davidz627))
- kube-scheduler dropped support for configuration files with apiVersion `componentconfig/v1alpha1`. Ensure kube-scheduler is configured using command-line flags or a configuration file with apiVersion `kubescheduler.config.k8s.io/v1alpha1` before upgrading to 1.13.
- kubectl
  - The deprecated command `run-container` has been removed. Invocations should use `kubectl run` instead ([#70728](https://github.com/kubernetes/kubernetes/pull/70728), [@Pingan2017](https://github.com/Pingan2017))
- client-go releases will no longer have bootstrap (k8s.io/client-go/tools/bootstrap) related code. Any reference to it will break. Please redirect all references to k8s.io/bootstrap instead. ([#67356](https://github.com/kubernetes/kubernetes/pull/67356), [@yliaog](https://github.com/yliaog))
- Kubernetes cannot distinguish between GCE Zonal PDs and Regional PDs with the same name. To workaround this issue, precreate PDs with unique names. PDs that are dynamically provisioned do not encounter this issue. ([#70716](https://github.com/kubernetes/kubernetes/pull/70716), [@msau42](https://github.com/msau42))

## Known Issues

- If kubelet plugin registration for a driver fails, kubelet will not retry. The driver must delete and recreate the driver registration socket in order to force kubelet to attempt registration again. Restarting only the driver container may not be sufficient to trigger recreation of the socket, instead a pod restart may be required. ([#71487](https://github.com/kubernetes/kubernetes/issues/71487))
- In some cases, a Flex volume resize may leave a PVC with erroneous Resizing condition even after volume has been successfully expanded. Users may choose to delete the condition, but it is not required. ([#71470](https://github.com/kubernetes/kubernetes/issues/71470))
- The CSI driver-registrar external sidecar container v1.0.0-rc2 is known to take up to 1 minute to start in some cases. We expect this issue to be resolved in a future release of the sidecar container. For verification, please see the release notes of future releases of the external sidecar container. ([#76](https://github.com/kubernetes-csi/driver-registrar/issues/76))
- When using IPV6-only, be sure to use `proxy-mode=iptables` as `proxy-mode=ipvs` is known to not work. ([#68437](https://github.com/kubernetes/kubernetes/issues/68437))

## Deprecations

- kube-apiserver
  - The `--service-account-api-audiences` flag is deprecated in favor of `--api-audiences`. The old flag is accepted with a warning but will be removed in a future release. ([#70105](https://github.com/kubernetes/kubernetes/pull/70105), [@mikedanese](https://github.com/mikedanese))
  - The `--experimental-encryption-provider-config` flag is deprecated in favor of `--encryption-provider-config`. The old flag is accepted with a warning but will be removed in 1.14. ([#71206](https://github.com/kubernetes/kubernetes/pull/71206), [@stlaz](https://github.com/stlaz))
  - As part of graduating the etcd encryption feature to beta, the configuration file referenced by `--encryption-provider-config` now uses `kind: EncryptionConfiguration` and `apiVersion: apiserver.config.k8s.io/v1`. Support for `kind: EncryptionConfig` and `apiVersion: v1` is deprecated and will be removed in a future release. ([#67383](https://github.com/kubernetes/kubernetes/pull/67383), [@stlaz](https://github.com/stlaz))
  - The `--deserialization-cache-size` flag is deprecated, and will be removed in a future release. The flag is inactive since the etcd2 storage backend was removed. ([#69842](https://github.com/kubernetes/kubernetes/pull/69842), [@liggitt](https://github.com/liggitt))
  - The `Node` authorization mode no longer allows kubelets to delete their Node API objects (prior to 1.11, in rare circumstances related to cloudprovider node ID changes, kubelets would attempt to delete/recreate their Node object at startup) ([#71021](https://github.com/kubernetes/kubernetes/pull/71021), [@liggitt](https://github.com/liggitt))
  - The built-in `system:csi-external-provisioner` and `system:csi-external-attacher` cluster roles are deprecated and will not be auto-created in a future release. CSI deployments should provide their own RBAC role definitions with required permissions. ([#69868](https://github.com/kubernetes/kubernetes/pull/69868), [@pohly]( https://github.com/pohly))
  - The built-in `system:aws-cloud-provider` cluster role is deprecated and will not be auto-created in a future release. Deployments using the AWS cloud provider should grant required permissions to the `aws-cloud-provider` service account in the `kube-system` namespace as part of deployment. ([#66635](https://github.com/kubernetes/kubernetes/pull/66635), [@wgliang](https://github.com/wgliang))
- kubelet
  - Use of the beta plugin registration directory `{kubelet_root_dir}/plugins/` for registration of external drivers via the kubelet plugin registration protocol is deprecated in favor of `{kubelet_root_dir}/plugins_registry/`. Support for the old directory is planned to be removed in v1.15. Device plugin and CSI storage drivers should switch to the new directory prior to v1.15. Only CSI storage drivers that support 0.x versions of the CSI API are allowed in the old directory. ([#70494](https://github.com/kubernetes/kubernetes/pull/70494) by [@RenaudWasTaken](https://github.com/RenaudWasTaken) and [#71314](https://github.com/kubernetes/kubernetes/pull/71314) by [@saad-ali](https://github.com/saad-ali))
  - With the release of the CSI 1.0 API, support for CSI drivers using 0.3 and older releases of the CSI API is deprecated, and is planned to be removed in Kubernetes v1.15. CSI drivers should be updated to support the CSI 1.0 API, and deployed in the new kubelet plugin registration directory (`{kubelet_root_dir}/plugins_registry/`) once all nodes in the cluster are at 1.13 or higher ([#71020](https://github.com/kubernetes/kubernetes/pull/71020) and [#71314](https://github.com/kubernetes/kubernetes/pull/71314), both by [@saad-ali](https://github.com/saad-ali))
  - Use of the `--node-labels` flag to set labels under the `kubernetes.io/` and `k8s.io/` prefix will be subject to restriction by the `NodeRestriction` admission plugin in future releases. [See admission plugin documentation](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction) for allowed labels. ([#68267](https://github.com/kubernetes/kubernetes/pull/68267), [@liggitt](https://github.com/liggitt))
- kube-scheduler
  - The alpha critical pod annotation (`scheduler.alpha.kubernetes.io/critical-pod`) is deprecated. Pod priority should be used instead to mark pods as critical. ([#70298](https://github.com/kubernetes/kubernetes/pull/70298), [@bsalamat](https://github.com/bsalamat))
- The following features are now GA, and the associated feature gates are deprecated and will be removed in a future release:
  - CSIPersistentVolume
  - GCERegionalPersistentDisk
  - KubeletPluginsWatcher
  - VolumeScheduling
- kubeadm
  - The DynamicKubeletConfig feature gate is deprecated. The functionality is still accessible by using the kubeadm alpha kubelet enable-dynamic command.
  - The command `kubeadm config print-defaults` is deprecated in favor of `kubeadm config print init-defaults` and `kubeadm config print join-defaults` ([#69617](https://github.com/kubernetes/kubernetes/pull/69617), [@rosti](https://github.com/rosti))
  - support for the `v1alpha3` configuration file format is deprecated and will be removed in 1.14. Use `kubeadm config migrate` to migrate `v1alpha3` configuration files to `v1beta1`, which provides improvements in image repository management, addons configuration, and other areas. The documentation for `v1beta1` can be found here: https://godoc.org/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta1
- The `node.status.volumes.attached.devicePath` field is deprecated for CSI volumes and will not be set in future releases ([#71095](https://github.com/kubernetes/kubernetes/pull/71095), [@msau42](https://github.com/msau42))
- kubectl
  - The `kubectl convert` command is deprecated and will be removed in a future release ([#70820](https://github.com/kubernetes/kubernetes/pull/70820), [@seans3](https://github.com/seans3))
- Support for passing unknown provider names to the E2E test binaries is deprecated and will be removed in a future release. Use `--provider=skeleton` (no ssh access) or `--provider=local` (local cluster with ssh) instead. ([#70141](https://github.com/kubernetes/kubernetes/pull/70141), [@pohly](https://github.com/pohly))

## Major Themes

### SIG API Machinery

For the 1.13 release, SIG API Machinery is happy to announce that the [dry-run functionality](https://kubernetes.io//docs/reference/using-api/api-concepts/#dry-run) is now beta.

### SIG Auth

With this release we've made several important enhancements to core SIG Auth areas. In the authorization category, we've further reduced Kubelet privileges by [restricting node self-updates of labels to a whitelisted selection and by disallowing kubelets from deleting their Node API object](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction). In authentication, we added alpha-level support for automounting improved service account tokens through projected volumes. We also enabled [audience validation in TokenReview](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.13/#tokenreview-v1-authentication-k8s-io) for the new tokens for improved scoping. Under audit logging, the new alpha-level "dynamic audit configuration" adds support for [dynamically registering webhooks to receive a stream of audit events](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#dynamic-backend). Finally, we've enhanced secrets protection by graduating [etcd encryption](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/) out of experimental.

### SIG AWS

In v1.13 we worked on tighter integrations of Kubernetes API objects with AWS services. These include three out-of-tree alpha feature releases:

1) Alpha for AWS ALB (Application Load Balancer) integration to Kubernetes Ingress resources.
2) Alpha for CSI specification 0.3 integration to AWS EBS (Elastic Block Store)
3) Alpha for the cloudprovider-aws cloud controller manager binary. Additionally we added [aws-k8s-tester](https://github.com/kubernetes/test-infra/issues/9814), deployer interface for kubetest, to the test-infra repository. This plugin allowed us to integrate Prow to the 3 subprojects defined above in order to provide CI signal for all 3 features. The CI signal is visible [here](https://testgrid.k8s.io/) under SIG-AWS.

For detailed release notes on the three alpha features from SIG AWS, please refer to the following Changelogs:

- [aws-alb-ingress-controller v1.0.0](https://github.com/kubernetes-sigs/aws-alb-ingress-controller/releases/tag/v1.0.0)
- [aws-ebs-csi-driver v0.1](https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/CHANGELOG-0.x.md#v010)
- [cloudprovider-aws external v0.1.0] (https://github.com/kubernetes/cloud-provider-aws/blob/master/changelogs/CHANGELOG-0.1.md)

### SIG Azure

For 1.13 SIG Azure was focused on adding additional Azure Disk support for Ultra SSD, Standard SSD, and Premium Azure Files. Azure Availability Zones and cross resource group nodes were also moved from Alpha to Beta in 1.13.

### SIG Big Data

During the 1.13 release cycle, SIG Big Data has been focused on community engagements relating to 3rd-party project integrations with Kubernetes. There have been no impacts on the 1.13 release.

### SIG CLI

Over the course of 1.13 release SIG CLI mostly focused on stabilizing the items we’ve been working on over the past releases such as server-side printing and its support in kubectl, as well as finishing [kubectl diff which is based on server-side dry-run feature](https://kubernetes.io/docs/concepts/overview/object-management-kubectl/#how-to-create-objects). We’ve continued separating kubectl code to prepare for extraction out of main repository. Finally, thanks to the awesome support and feedback from community we’ve managed to promote the new [plugin mechanism to Beta](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/).

### SIG Cloud Provider

For v1.13, SIG Cloud Provider has been focused on stabilizing the common APIs and interfaces consumed by cloud providers today. This involved auditing the cloud provider APIs for anything that should be deprecated as well as adding changes where necessary. In addition, SIG Cloud Provider has begun exploratory work around having a “cloud provider” e2e test suite which can be used to test common cloud provider functionalities with resources such as nodes and load balancers.

We are also continuing our long running effort to extract all the existing cloud providers that live in k8s.io/kubernetes into their own respective repos. Along with this migration, we are slowly transitioning users to use the cloud-controller-manager for any cloud provider features instead of the kube-controller-manager.

### SIG Cluster Lifecycle

For 1.13 SIG Cluster Lifecycle is pleased to announce the long awaited promotion of kubeadm to stable GA, and the promotion of kubeadm’s configuration API to `v1beta1`.
In this release the SIG again focused on further improving the user experience on cluster creation and also fixing a number of bugs and other assorted improvements.

Some notable changes in kubeadm since Kubernetes 1.12:

- kubeadm’s configuration API is now `v1beta1`. The new configuration format provides improvements in - image repository management, addons configuration, and other areas. We encourage `v1alpha3` users to migrate to this configuration API using `kubeadm config migrate`, as `v1alpha3` will be removed in 1.14. The documentation for `v1beta1` can be found here: https://godoc.org/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta1
- kubeadm has graduated `kubeadm alpha phase` commands to `kubeadm init phase`. This means that the phases of creating a control-plane node are now tightly integrated as part of the `init` command. Alpha features, not yet ready for GA are still kept under `kubeadm alpha` and we appreciate feedback on them.
- `kubeadm init` and `kubeadm init phase` now have a `--image-repository` flag, improving support for environments with limited access to official kubernetes repository.
- The DynamicKubeletConfig and SelfHosting functionality was moved outside of `kubeadm init` and feature gates and is now exposed under `kubeadm alpha`.
- Kubeadm init phase certs now support the `--csr-only` option, simplifying custom CA creation.
- `kubeadm join --experimental-control-plane` now automatically adds a new etcd member for `local etcd` mode, further simplifying required tasks for HA clusters setup.
- Improvements were made to `kubeadm reset` related to cleaning  etcd and notifying the user about the state of iptables.
- kubeadm commands now print warnings if input YAML documents contain unknown or duplicate fields.
- kubeadm now properly recognizes Docker 18.09.0 and newer, but still treats 18.06 as the default supported version.
- kubeadm now automatically sets the `--pod-infra-container-image` flag when starting the kubelet.

### SIG IBM Cloud

The IBM Cloud SIG was focused on defining its charter and working towards moving its cloud provider code to an external repository with a goal to have this work done by the end of Kubernetes 1.14 release cycle. In the SIG meetings, we also made sure to share updates on the latest Kubernetes developments in the IBM Cloud like the availability of Kubernetes v1.12.2 in the IBM Cloud Kubernetes Service (IKS). The SIG updates were provided in the Kubernetes community weekly call and at the KubeCon China 2018.

### SIG Multicluster

Moving Federation v2 from Alpha towards Beta has been the focus of our effort over the past quarter.  To this end we engaged with end users, and successfully enlisted additional contributors from companies including IBM, Amadeus, Cisco and others. Federation v2 provides a suite of decoupled API’s and  re-usable components for building multi-cluster control planes. We plan to start releasing Beta components in late 2018.  In addition, more minor updates were made to our cluster-registry and multi-cluster ingress sub-projects.

### SIG Network

For 1.13, the areas of focus were in IPv6, DNS improvements and some smaller items:
CoreDNS is now the default cluster DNS passing all of the scale/resource usage tests
Node-local DNS cache feature is available in Alpha. This feature deploys a lightweight DNS caching Daemonset that avoids the conntrack and converts queries from UDP to more reliable TCP.
PodReady++ feature now has `kubectl` CLI support.

Progress was made towards finalizing the IPv6 dual stack support KEP and support for topological routing of services.

### SIG Node

SIG Node focused on stability and performance improvements in the 1.13 release.  A new alpha feature is introduced to improve the mechanism that nodes heartbeat back to the control plane.  The `NodeLease` feature results in the node using a `Lease` resource in the `kube-node-lease` namespace that is renewed periodically.  The `NodeStatus` that was used previously to heartbeat back to the control plane is only updated when it changes.  This reduces load on the control plane for large clusters. The Kubelet plugin registration mechanism, which enables automatic discovery of external plugins (including CSI and device plugins) has been promoted to stable in this release (introduced as alpha in 1.11 and promoted to beta in 1.12).

### SIG Openstack

The major theme for the SIG OpenStack release is the work-in-progress for removing the in-tree provider. This work, being done in conjunction with SIG Cloud Provider, is focusing on moving internal APIs that the OpenStack (and other providers) depends upon to staging to guarantee API stability. This work also included abstracting the in-tree Cinder API and refactoring code to the external Cinder provider to remove additional Cinder volume provider code.

Additional work was also done to implement an OpenStack driver for the Cluster API effort lead by SIG Cluster Lifecycle. For the external Cloud-Provider-OpenStack code, the SIG largely focused on bug fixes and updates to match K8s 1.13 development.

### SIG Scalability

SIG Scalability has mostly focused on stability and deflaking our tests, investing into framework for writing scalability tests (ClusterLoader v2) with a goal to migrate all tests to it by the end of 2018 and on the work towards extending definition of Kubernetes scalability by providing more/better user-friendly SLIs/SLOs.

### SIG Scheduling

SIG Scheduling has mostly focused on stability in 1.13 and has postponed some of the major features to the next versions. There are still two notable changes: 1. TaintBasedEviction is moved to Beta and will be enabled by default. With this feature enabled, condition taints are automatically added to the nodes and pods can add tolerations for them if needed. 2. Pod critical annotation is deprecated. Pods should use pod priority instead of the annotation.

It is worth noting again that kube-scheduler will use apiVersion `kubescheduler.config.k8s.io/v1alpha1` instead of `componentconfig/v1alpha1` in its configuration files in 1.13.

### SIG Service Catalog

The Service Plan Defaults feature is still under active development.
We continue to improve the UX for the svcat CLI, specifically filling in gaps for the new Namespaced Service Broker feature.

### SIG Storage

Over the last year, SIG Storage has been focused on adding support for the Container Storage Interface (CSI) to Kubernetes. The specification recently moved to 1.0, and on the heels of this achievement, Kubernetes v1.13 moves CSI support for PersistentVolumes to GA.

With CSI the Kubernetes volume layer becomes truly extensible, allowing third party storage developers to write drivers making their storage systems available in Kubernetes without having to touch the core code.

CSI was first introduction as alpha in Kubernetes v1.9 and moved to beta in Kubernetes v1.10.

You can find a list of sample and production drivers in the [CSI Documentation](https://kubernetes.io/docs/concepts/storage/volumes/#csi).

SIG Storage also moves support for Block Volumes to beta (introduced as alpha in v1.9) and support for Topology Aware Volume Scheduling to stable (introduced as alpha in v1.9 and promoted to beta in 1.10).

### SIG UI

The migration to the newest version of Angular is still under active development as it is most important thing on the roadmap at the moment. We are getting closer to to the new release. We continue fixing bugs and adding other improvements.

### SIG VMWare

Major focus for SIG VMware for this release is the work on moving internal APIs that the vSphere provider depends upon to staging to guarantee API stability. This work is being done in conjunction with SIG Cloud Provider and includes the creation of a brand new vsphere-csi plugin to replace the current volume functionalities in-tree.

Additional work was also done to implement a vSphere provider for the Cluster API effort lead by SIG Cluster Lifecycle. For the out-of-tree vSphere cloud provider, the SIG largely focused on bug fixes and updates to match K8s 1.13 development.

### SIG Windows

SIG Windows focused on improving reliability for Windows and Kubernetes support

## New Features

- kubelet: When node lease feature is enabled, kubelet reports node status to api server only if there is some change or it didn't report over last report interval. ([#69753](https://github.com/kubernetes/kubernetes/pull/69753), [@wangzhen127](https://github.com/wangzhen127))
- vSphereVolume implements Raw Block Volume Support  ([#68761](https://github.com/kubernetes/kubernetes/pull/68761), [@fanzhangio](https://github.com/fanzhangio))
- CRD supports multi-version Schema, Subresources and AdditionalPrintColumns (NOTE that CRDs created prior to 1.13 populated the top-level additionalPrinterColumns field by default. To apply an updated that changes to per-version additionalPrinterColumns, the top-level additionalPrinterColumns field must be explicitly set to null). ([#70211](https://github.com/kubernetes/kubernetes/pull/70211), [@roycaihw](https://github.com/roycaihw))
- New addon in addon manager that automatically installs CSI CRDs if CSIDriverRegistry or CSINodeInfo feature gates are true. ([#70193](https://github.com/kubernetes/kubernetes/pull/70193), [@saad-ali](https://github.com/saad-ali))
- Delegated authorization can now allow unrestricted access for `system:masters` like the main kube-apiserver ([#70671](https://github.com/kubernetes/kubernetes/pull/70671), [@deads2k](https://github.com/deads2k))
- Added dns capabilities for Windows CNI plugins: ([#67435](https://github.com/kubernetes/kubernetes/pull/67435), [@feiskyer](https://github.com/feiskyer))
- kube-apiserver: `--audit-webhook-version` and `--audit-log-version` now default to `audit.k8s.io/v1` if unspecified ([#70476](https://github.com/kubernetes/kubernetes/pull/70476), [@charrywanganthony](https://github.com/charrywanganthony))
- kubeadm: timeoutForControlPlane is introduced as part of the API Server config, that controls the timeout for the wait for control plane to be up. Default value is 4 minutes. ([#70480](https://github.com/kubernetes/kubernetes/pull/70480), [@rosti](https://github.com/rosti))
- `--api-audiences` now defaults to the `--service-account-issuer` if the issuer is provided but the API audience is not. ([#70308](https://github.com/kubernetes/kubernetes/pull/70308), [@mikedanese](https://github.com/mikedanese))
- Added support for projected volume in describe function  ([#70158](https://github.com/kubernetes/kubernetes/pull/70158), [@WanLinghao](https://github.com/WanLinghao))
- kubeadm now automatically creates a new stacked etcd member when joining a new control plane node (does not applies to external etcd) ([#69486](https://github.com/kubernetes/kubernetes/pull/69486), [@fabriziopandini](https://github.com/fabriziopandini))
- Display the usage of ephemeral-storage when using `kubectl describe node` ([#70268](https://github.com/kubernetes/kubernetes/pull/70268), [@Pingan2017](https://github.com/Pingan2017))
- Added functionality to enable br_netfilter and ip_forward for debian packages to improve kubeadm support for CRI runtime besides Docker.  ([#70152](https://github.com/kubernetes/kubernetes/pull/70152), [@ashwanikhemani](https://github.com/ashwanikhemani))
- Added regions ap-northeast-3 and eu-west-3 to the list of well known AWS regions. ([#70252](https://github.com/kubernetes/kubernetes/pull/70252), [@nckturner](https://github.com/nckturner))
- kubeadm: Implemented preflight check to ensure that number of CPUs ([#70048](https://github.com/kubernetes/kubernetes/pull/70048), [@bart0sh](https://github.com/bart0sh))
- CoreDNS is now the default DNS server in kube-up deployments.  ([#69883](https://github.com/kubernetes/kubernetes/pull/69883), [@chrisohaver](https://github.com/chrisohaver))
- Opt out of chowning and chmoding from kubectl cp. ([#69573](https://github.com/kubernetes/kubernetes/pull/69573), [@bjhaid](https://github.com/bjhaid))
- Failed to provision volume with StorageClass "azurefile-premium": failed to create share andy-mg1121-dynamic-pvc-1a7b2813-d1b7-11e8-9e96-000d3a03e16b in account f7228f99bcde411e8ba4900: failed to create file share, err: storage: service returned error: StatusCode=400, ErrorCode=InvalidHeaderValue, ErrorMessage=The value for one of the HTTP headers is not in the correct format. ([#69718](https://github.com/kubernetes/kubernetes/pull/69718), [@andyzhangx](https://github.com/andyzhangx))
- `TaintBasedEvictions` feature is promoted to beta. ([#69824](https://github.com/kubernetes/kubernetes/pull/69824), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed https://github.com/kubernetes/client-go/issues/478 by adding support for JSON Patch in client-go/dynamic/fake ([#69330](https://github.com/kubernetes/kubernetes/pull/69330), [@vaikas-google](https://github.com/vaikas-google))
- Dry-run is promoted to Beta and will be enabled by default. ([#69644](https://github.com/kubernetes/kubernetes/pull/69644), [@apelisse](https://github.com/apelisse))
- `kubectl get priorityclass` now prints value column by default. ([#69431](https://github.com/kubernetes/kubernetes/pull/69431), [@Huang-Wei](https://github.com/Huang-Wei))
- Added a new container based image for running e2e tests ([#69368](https://github.com/kubernetes/kubernetes/pull/69368), [@dims](https://github.com/dims))
- The `LC_ALL` and `LC_MESSAGES` env vars can now be used to set desired locale for `kubectl` while keeping `LANG` unchanged. ([#69500](https://github.com/kubernetes/kubernetes/pull/69500), [@m1kola](https://github.com/m1kola))
- NodeLifecycleController: Now node lease renewal is treated as the heartbeat signal from the node, in addition to NodeStatus Update. ([#69241](https://github.com/kubernetes/kubernetes/pull/69241), [@wangzhen127](https://github.com/wangzhen127))
- Added dynamic shared informers to write generic, non-generated controllers ([#69308](https://github.com/kubernetes/kubernetes/pull/69308), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Upgraded to etcd 3.3 client ([#69322](https://github.com/kubernetes/kubernetes/pull/69322), [@jpbetz](https://github.com/jpbetz))
- It is now possible to use named ports in the `kubectl port-forward` command ([#69477](https://github.com/kubernetes/kubernetes/pull/69477), [@m1kola](https://github.com/m1kola))
- `kubectl wait` now supports condition value checks other than true using `--for condition=available=false` ([#69295](https://github.com/kubernetes/kubernetes/pull/69295), [@deads2k](https://github.com/deads2k))
- Updated defaultbackend image to 1.5. Users should concentrate on updating scripts to the new version. ([#69120](https://github.com/kubernetes/kubernetes/pull/69120), [@aledbf](https://github.com/aledbf))
- Bumped Dashboard version to v1.10.0 ([#68450](https://github.com/kubernetes/kubernetes/pull/68450), [@jeefy](https://github.com/jeefy))
- Added env variables to control CPU requests of kube-controller-manager and kube-scheduler. ([#68823](https://github.com/kubernetes/kubernetes/pull/68823), [@loburm](https://github.com/loburm))
- PodSecurityPolicy objects now support a `MayRunAs` rule for `fsGroup` and `supplementalGroups` options. This allows specifying ranges of allowed GIDs for pods/containers without forcing a default GID the way `MustRunAs` does. This means that a container to which such a policy applies to won't use any fsGroup/supplementalGroup GID if not explicitly specified, yet a specified GID must still fall in the GID range according to the policy. ([#65135](https://github.com/kubernetes/kubernetes/pull/65135), [@stlaz](https://github.com/stlaz))
- Upgrade Stackdriver Logging Agent addon image to 0.6-1.6.0-1 to use Fluentd v1.2. This provides nanoseconds timestamp granularity for logs. ([#70954](https://github.com/kubernetes/kubernetes/pull/70954), [@qingling128](https://github.com/qingling128))
- When the BoundServiceAccountTokenVolumes Alpha feature is enabled, ServiceAccount volumes now use a projected volume source and their names have the prefix "kube-api-access". ([#69848](https://github.com/kubernetes/kubernetes/pull/69848), [@mikedanese](https://github.com/mikedanese))
- Raw block volume support is promoted to beta, and enabled by default. This is accessible via the `volumeDevices` container field in pod specs, and the `volumeMode` field in persistent volume and persistent volume claims definitions. ([#71167](https://github.com/kubernetes/kubernetes/pull/71167), [@msau42](https://github.com/msau42))
- TokenReview now supports audience validation of tokens with audiences other than the kube-apiserver.  ([#62692](https://github.com/kubernetes/kubernetes/pull/62692), [@mikedanese](https://github.com/mikedanese))
- StatefulSet is supported in `kubectl autoscale` command ([#71103](https://github.com/kubernetes/kubernetes/pull/71103), [@Pingan2017](https://github.com/Pingan2017))
- Kubernetes v1.13 moves support for Container Storage Interface to GA. As part of this move Kubernetes now supports CSI v1.0.0 and deprecates support for CSI 0.3 and older releases. Older CSI drivers must be updated to CSI 1.0 and moved to the new kubelet plugin registration directory in order to work with Kubernetes 1.15+. ([#71020](https://github.com/kubernetes/kubernetes/pull/71020), [@saad-ali](https://github.com/saad-ali))
- Added option to create CSRs instead of certificates for kubeadm init phase certs and kubeadm alpha certs renew ([#70809](https://github.com/kubernetes/kubernetes/pull/70809), [@liztio](https://github.com/liztio))
- Added a kubelet socket which serves an grpc service containing the devices used by containers on the node. ([#70508](https://github.com/kubernetes/kubernetes/pull/70508), [@dashpole](https://github.com/dashpole))
- Added DynamicAuditing feature which allows for the configuration of audit webhooks through the use of an AuditSink API object. ([#67257](https://github.com/kubernetes/kubernetes/pull/67257), [@pbarker](https://github.com/pbarker))
- The kube-apiserver's healthz now takes in an optional query parameter which allows you to disable health checks from causing healthz failures.  ([#70676](https://github.com/kubernetes/kubernetes/pull/70676), [@logicalhan](https://github.com/logicalhan))
- Introduced support for running a nodelocal dns cache. It is disabled by default, can be enabled by setting KUBE_ENABLE_NODELOCAL_DNS=true ([#70555](https://github.com/kubernetes/kubernetes/pull/70555), [@prameshj](https://github.com/prameshj))
- Added readiness gates in extended output for pods ([#70775](https://github.com/kubernetes/kubernetes/pull/70775), [@freehan](https://github.com/freehan))
- Added `Ready` column and improve human-readable output of Deployments and StatefulSets ([#70466](https://github.com/kubernetes/kubernetes/pull/70466), [@Pingan2017](https://github.com/Pingan2017))
- Added `kubelet_container_log_size_bytes` metric representing the log file size of a container. ([#70749](https://github.com/kubernetes/kubernetes/pull/70749), [@brancz](https://github.com/brancz))
- NodeLifecycleController: When node lease feature is enabled, node lease will be deleted when the corresponding node is deleted. ([#70034](https://github.com/kubernetes/kubernetes/pull/70034), [@wangzhen127](https://github.com/wangzhen127))
- GCERegionalPersistentDisk feature is GA now! ([#70716](https://github.com/kubernetes/kubernetes/pull/70716), [@jingxu97](https://github.com/jingxu97))
- Added secure port 10259 to the kube-scheduler (enabled by default) and deprecate old insecure port 10251. Without further flags self-signed certs are created on startup in memory. ([#69663](https://github.com/kubernetes/kubernetes/pull/69663), [@sttts](https://github.com/sttts))

## Release Notes From SIGs

### SIG API Machinery

- The OwnerReferencesPermissionEnforcement admission plugin now checks authorization for the correct scope (namespaced or cluster-scoped) of the owner resource type. Previously, it always checked permissions at the same scope as the child resource. ([#70389](https://github.com/kubernetes/kubernetes/pull/70389), [@caesarxuchao](https://github.com/caesarxuchao))
- OpenAPI spec now correctly marks delete request's body parameter as optional ([#70032](https://github.com/kubernetes/kubernetes/pull/70032), [@iamneha](https://github.com/iamneha))
- The rules for incrementing `metadata.generation` of custom resources changed: ([#69059](https://github.com/kubernetes/kubernetes/pull/69059), [@caesarxuchao](https://github.com/caesarxuchao))
  - If the custom resource participates the spec/status convention, the metadata.generation of the CR increments when there is any change, except for the changes to the metadata or the changes to the status.
  - If the custom resource does not participate the spec/status convention, the metadata.generation of the CR increments when there is any change to the CR, except for changes to the metadata.
  - A custom resource is considered to participate the spec/status convention if and only if the "CustomResourceSubresources" feature gate is turned on and the CRD has `.spec.subresources.status={}`.
- Fixed patch/update operations on multi-version custom resources ([#70087](https://github.com/kubernetes/kubernetes/pull/70087), [@liggitt](https://github.com/liggitt))
- Reduced memory utilization of admission webhook metrics by removing resource related labels. ([#69895](https://github.com/kubernetes/kubernetes/pull/69895), [@jpbetz](https://github.com/jpbetz))
- Kubelet can now parse PEM file containing both TLS certificate and key in arbitrary order. Previously key was always required to be first. ([#69536](https://github.com/kubernetes/kubernetes/pull/69536), [@awly](https://github.com/awly))
- Code-gen: Removed lowercasing for project imports ([#68484](https://github.com/kubernetes/kubernetes/pull/68484), [@jsturtevant](https://github.com/jsturtevant))
- Fixed client cert setup in delegating authentication logic ([#69430](https://github.com/kubernetes/kubernetes/pull/69430), [@DirectXMan12](https://github.com/DirectXMan12))
- OpenAPI spec and API reference now reflect dryRun query parameter for POST/PUT/PATCH operations ([#69359](https://github.com/kubernetes/kubernetes/pull/69359), [@roycaihw](https://github.com/roycaihw))
- Fixed the sample-apiserver so that its BanFlunder admission plugin can be used. ([#68417](https://github.com/kubernetes/kubernetes/pull/68417), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- APIService availability related to networking glitches are corrected faster ([#68678](https://github.com/kubernetes/kubernetes/pull/68678), [@deads2k](https://github.com/deads2k))
- Fixed an issue with stuck connections handling error responses ([#71412](https://github.com/kubernetes/kubernetes/pull/71412), [@liggitt](https://github.com/liggitt))
- apiserver: fixed handling and logging of panics in REST handlers ([#71076](https://github.com/kubernetes/kubernetes/pull/71076), [@liggitt](https://github.com/liggitt))
- kube-controller-manager no longer removes ownerReferences from ResourceQuota objects ([#70035](https://github.com/kubernetes/kubernetes/pull/70035), [@liggitt](https://github.com/liggitt))
- "unfinished_work_microseconds" is added to the workqueue metrics; it can be used to detect stuck worker threads. (kube-controller-manager runs many workqueues.) ([#70884](https://github.com/kubernetes/kubernetes/pull/70884), [@lavalamp](https://github.com/lavalamp))
- Timeouts set in ListOptions for clients are also be respected locally ([#70998](https://github.com/kubernetes/kubernetes/pull/70998), [@deads2k](https://github.com/deads2k))
- Added support for CRD conversion webhook ([#67006](https://github.com/kubernetes/kubernetes/pull/67006), [@mbohlool](https://github.com/mbohlool))
- client-go: fixed sending oversized data frames to spdystreams in remotecommand.NewSPDYExecutor ([#70999](https://github.com/kubernetes/kubernetes/pull/70999), [@liggitt](https://github.com/liggitt))
- Fixed missing flags in `-controller-manager --help`. ([#71298](https://github.com/kubernetes/kubernetes/pull/71298), [@stewart-yu](https://github.com/stewart-yu))
- Fixed missing flags in `kube-apiserver --help`. ([#70204](https://github.com/kubernetes/kubernetes/pull/70204), [@imjching](https://github.com/imjching))
- The caBundle and service fields in admission webhook API objects now correctly indicate they are optional ([#70138](https://github.com/kubernetes/kubernetes/pull/70138), [@liggitt](https://github.com/liggitt))
- Fixed an issue with stuck connections handling error responses ([#71419](https://github.com/kubernetes/kubernetes/pull/71419), [@liggitt](https://github.com/liggitt))
- kube-controller-manager and cloud-controller-manager now hold generated serving certificates in-memory unless a writeable location is specified with --cert-dir ([#69884](https://github.com/kubernetes/kubernetes/pull/69884), [@liggitt](https://github.com/liggitt))
- CCM server will not listen insecurely if secure port is specified ([#68982](https://github.com/kubernetes/kubernetes/pull/68982), [@aruneli](https://github.com/aruneli))
- List operations against the API now return internal server errors instead of partially complete lists when a value cannot be transformed from storage. The updated behavior is consistent with all other operations that require transforming data from storage such as watch and get. ([#69399](https://github.com/kubernetes/kubernetes/pull/69399), [@mikedanese](https://github.com/mikedanese))

### SIG Auth

- API Server can be configured to reject requests that cannot be audit-logged. ([#65763](https://github.com/kubernetes/kubernetes/pull/65763), [@x13n](https://github.com/x13n))
- Go clients created from a kubeconfig that specifies a TokenFile now periodically reload the token from the specified file. ([#70606](https://github.com/kubernetes/kubernetes/pull/70606), [@mikedanese](https://github.com/mikedanese))
- When `--rotate-server-certificates` is enabled, kubelet will no longer request a new certificate on startup if the current certificate on disk is satisfactory. ([#69991](https://github.com/kubernetes/kubernetes/pull/69991), [@agunnerson-ibm](https://github.com/agunnerson-ibm))
- Added dynamic audit configuration api ([#67547](https://github.com/kubernetes/kubernetes/pull/67547), [@pbarker](https://github.com/pbarker))
- Added ability to control primary GID of containers through Pod Spec and PodSecurityPolicy ([#67802](https://github.com/kubernetes/kubernetes/pull/67802), [@krmayankk](https://github.com/krmayankk))
- kube-apiserver: the `NodeRestriction` admission plugin now prevents kubelets from modifying `Node` labels prefixed with `node-restriction.kubernetes.io/`. The `node-restriction.kubernetes.io/` label prefix is reserved for cluster administrators to use for labeling `Node` objects to target workloads to nodes in a way that kubelets cannot modify or spoof. ([#68267](https://github.com/kubernetes/kubernetes/pull/68267), [@liggitt](https://github.com/liggitt))

### SIG Autoscaling

- Updated Cluster Autoscaler version to 1.13.0. See the [Release Notes](https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.13.0) for more information. ([#71513](https://github.com/kubernetes/kubernetes/pull/71513), [@losipiuk](https://github.com/losipiuk))

### SIG AWS

- `service.beta.kubernetes.io/aws-load-balancer-internal` now supports true and false values, previously it only supported non-empty strings ([#69436](https://github.com/kubernetes/kubernetes/pull/69436), [@mcrute](https://github.com/mcrute))
- Added `service.beta.kubernetes.io/aws-load-balancer-security-groups` annotation to set the security groups to the AWS ELB to be the only ones specified in the annotation in case this is present (does not add `0.0.0.0/0`).  ([#62774](https://github.com/kubernetes/kubernetes/pull/62774), [@Raffo](https://github.com/Raffo))

### SIG Azure

- Ensured orphan public IPs on Azure deleted when service recreated with the same name. ([#70463](https://github.com/kubernetes/kubernetes/pull/70463), [@feiskyer](https://github.com/feiskyer))
- Improved Azure instance metadata handling by adding caches. ([#70353](https://github.com/kubernetes/kubernetes/pull/70353), [@feiskyer](https://github.com/feiskyer))
- Corrected check for non-Azure managed nodes with the Azure cloud provider ([#70135](https://github.com/kubernetes/kubernetes/pull/70135), [@marc-sensenich](https://github.com/marc-sensenich))
- Fixed azure disk attach/detach failed forever issue ([#71377](https://github.com/kubernetes/kubernetes/pull/71377), [@andyzhangx](https://github.com/andyzhangx))
- DisksAreAttached --> getNodeDataDisks--> GetDataDisks --> getVirtualMachine --> vmCache.Get ([#71495](https://github.com/kubernetes/kubernetes/pull/71495), [@andyzhangx](https://github.com/andyzhangx))

### SIG CLI

- `kubectl apply` can now change a deployment strategy from rollout to recreate without explicitly clearing the rollout-related fields ([#70436](https://github.com/kubernetes/kubernetes/pull/70436), [@liggitt](https://github.com/liggitt))
- The `kubectl plugin list` command now displays discovered plugin paths in the same order as they are found in a user's PATH variable. ([#70443](https://github.com/kubernetes/kubernetes/pull/70443), [@juanvallejo](https://github.com/juanvallejo))
- `kubectl get` no longer exits before printing all of its results if an error is found ([#70311](https://github.com/kubernetes/kubernetes/pull/70311), [@juanvallejo](https://github.com/juanvallejo))
- Fixed a runtime error occurring when sorting the output of `kubectl get` with empty results ([#70740](https://github.com/kubernetes/kubernetes/pull/70740), [@mfpierre](https://github.com/mfpierre))
- kubectl: support multiple arguments for cordon/uncordon and drain ([#68655](https://github.com/kubernetes/kubernetes/pull/68655), [@goodluckbot](https://github.com/goodluckbot))
- Fixed ability for admin/edit/view users to see controller revisions, needed for kubectl rollout commands ([#70699](https://github.com/kubernetes/kubernetes/pull/70699), [@liggitt](https://github.com/liggitt))
- `kubectl rollout undo` now returns errors when attempting to rollback a deployment to a non-existent revision ([#70039](https://github.com/kubernetes/kubernetes/pull/70039), [@liggitt](https://github.com/liggitt))
- kubectl run now generates apps/v1 deployments by default ([#71006](https://github.com/kubernetes/kubernetes/pull/71006), [@liggitt](https://github.com/liggitt))
- The "kubectl cp" command now supports path shortcuts (../) in remote paths. ([#65189](https://github.com/kubernetes/kubernetes/pull/65189), [@juanvallejo](https://github.com/juanvallejo))
- Fixed dry-run output in kubectl apply --prune ([#69344](https://github.com/kubernetes/kubernetes/pull/69344), [@zegl](https://github.com/zegl))
- The kubectl wait command must handle when a watch returns an error vs closing by printing out the error and retrying the watch. ([#69389](https://github.com/kubernetes/kubernetes/pull/69389), [@smarterclayton](https://github.com/smarterclayton))
- kubectl: support multiple arguments for cordon/uncordon and drain ([#68655](https://github.com/kubernetes/kubernetes/pull/68655), [@goodluckbot](https://github.com/goodluckbot))

### SIG Cloud Provider

- Added deprecation warning for all cloud providers ([#69171](https://github.com/kubernetes/kubernetes/pull/69171), [@andrewsykim](https://github.com/andrewsykim))

### SIG Cluster Lifecycle

- kubeadm: Updates version of CoreDNS to 1.2.6 ([#70796](https://github.com/kubernetes/kubernetes/pull/70796), [@detiber](https://github.com/detiber))
- kubeadm: Validate kubeconfig files in case of external CA mode. ([#70537](https://github.com/kubernetes/kubernetes/pull/70537), [@yagonobre](https://github.com/yagonobre))
- kubeadm: The writable config file option for extra volumes is renamed to readOnly with a reversed meaning. With readOnly defaulted to false (as in pod specs). ([#70495](https://github.com/kubernetes/kubernetes/pull/70495), [@rosti](https://github.com/rosti))
- kubeadm: Multiple API server endpoints support upon join is removed as it is now redundant. ([#69812](https://github.com/kubernetes/kubernetes/pull/69812), [@rosti](https://github.com/rosti))
- `kubeadm reset` now cleans up custom etcd data path ([#70003](https://github.com/kubernetes/kubernetes/pull/70003), [@yagonobre](https://github.com/yagonobre))
- kubeadm: Fixed unnecessary upgrades caused by undefined order of Volumes and VolumeMounts in manifests ([#70027](https://github.com/kubernetes/kubernetes/pull/70027), [@bart0sh](https://github.com/bart0sh))
- kubeadm: Fixed node join taints. ([#69846](https://github.com/kubernetes/kubernetes/pull/69846), [@andrewrynhard](https://github.com/andrewrynhard))
- Fixed cluster autoscaler addon permissions so it can access batch/job. ([#69858](https://github.com/kubernetes/kubernetes/pull/69858), [@losipiuk](https://github.com/losipiuk))
- kubeadm: JoinConfiguration now houses the discovery options in a nested Discovery structure, which in turn has a couple of other nested structures to house more specific options (BootstrapTokenDiscovery and FileDiscovery) ([#67763](https://github.com/kubernetes/kubernetes/pull/67763), [@rosti](https://github.com/rosti))
- kubeadm: Fixed a possible scenario where kubeadm can pull much newer control-plane images ([#69301](https://github.com/kubernetes/kubernetes/pull/69301), [@neolit123](https://github.com/neolit123))
- kubeadm now allows mixing of init/cluster and join configuration in a single YAML file (although a warning gets printed in this case).  ([#69426](https://github.com/kubernetes/kubernetes/pull/69426), [@rosti](https://github.com/rosti))
- kubeadm: Added a `v1beta1` API. ([#69289](https://github.com/kubernetes/kubernetes/pull/69289), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm init correctly uses `--node-name` and `--cri-socket` when `--config` option is also used ([#71323](https://github.com/kubernetes/kubernetes/pull/71323), [@bart0sh](https://github.com/bart0sh))
- kubeadm: Always pass spec.nodeName as `--hostname-override` for kube-proxy ([#71283](https://github.com/kubernetes/kubernetes/pull/71283), [@Klaven](https://github.com/Klaven))
- `kubeadm join` correctly uses `--node-name` and `--cri-socket` when `--config` option is also used ([#71270](https://github.com/kubernetes/kubernetes/pull/71270), [@bart0sh](https://github.com/bart0sh))
- kubeadm now supports the `--image-repository` flag for customizing what registry to pull images from ([#71135](https://github.com/kubernetes/kubernetes/pull/71135), [@luxas](https://github.com/luxas))
- kubeadm: The writable config file option for extra volumes is renamed to readOnly with a reversed meaning. With readOnly defaulted to false (as in pod specs). ([#70495](https://github.com/kubernetes/kubernetes/pull/70495), [@rosti](https://github.com/rosti))
- kubeadm: Multiple API server endpoints support upon join is removed as it is now redundant. ([#69812](https://github.com/kubernetes/kubernetes/pull/69812), [@rosti](https://github.com/rosti))
- kubeadm: JoinConfiguration now houses the discovery options in a nested Discovery structure, which in turn has a couple of other nested structures to house more specific options (BootstrapTokenDiscovery and FileDiscovery) ([#67763](https://github.com/kubernetes/kubernetes/pull/67763), [@rosti](https://github.com/rosti))
- kubeadm: Added a `v1beta1` API. ([#69289](https://github.com/kubernetes/kubernetes/pull/69289), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: Use `advertise-client-urls` instead of `listen-client-urls` as and `etcd-servers` options for apiserver. ([#69827](https://github.com/kubernetes/kubernetes/pull/69827), [@tomkukral](https://github.com/tomkukral))
- Kubeadm now respects the custom image registry configuration across joins and upgrades. Kubeadm passes the custom registry to the kubelet for a custom pause container. ([#70603](https://github.com/kubernetes/kubernetes/pull/70603), [@chuckha](https://github.com/chuckha))
- `kubeadm reset` now outputs instructions about manual iptables rules cleanup. ([#70874](https://github.com/kubernetes/kubernetes/pull/70874), [@rdodev](https://github.com/rdodev))
- kubeadm: remove the AuditPolicyConfiguration feature gate ([#70807](https://github.com/kubernetes/kubernetes/pull/70807), [@Klaven](https://github.com/Klaven))
- kubeadm pre-pulls Etcd image only if external Etcd is not used and ([#70743](https://github.com/kubernetes/kubernetes/pull/70743), [@bart0sh](https://github.com/bart0sh))
- kubeadm: UnifiedControlPlaneImage is replaced by UseHyperKubeImage boolean value. ([#70793](https://github.com/kubernetes/kubernetes/pull/70793), [@rosti](https://github.com/rosti))
- For kube-up and derived configurations, CoreDNS will honor master taints, for consistency with kube-dns behavior. ([#70868](https://github.com/kubernetes/kubernetes/pull/70868), [@justinsb](https://github.com/justinsb))
- Recognize newer docker versions without -ce/-ee suffix: 18.09.0 ([#71001](https://github.com/kubernetes/kubernetes/pull/71001), [@thomas-riccardi](https://github.com/thomas-riccardi))
- Any external provider should be aware the cloud-provider interface should be imported from :- ([#68310](https://github.com/kubernetes/kubernetes/pull/68310), [@cheftako](https://github.com/cheftako))
- Fixed 'kubeadm upgrade' infinite loop waiting for pod restart ([#69886](https://github.com/kubernetes/kubernetes/pull/69886), [@bart0sh](https://github.com/bart0sh))
- Bumped addon-manager to v8.8 ([#69337](https://github.com/kubernetes/kubernetes/pull/69337), [@MrHohn](https://github.com/MrHohn))
- GCE: Filter out spammy audit logs from cluster autoscaler. ([#70696](https://github.com/kubernetes/kubernetes/pull/70696), [@loburm](https://github.com/loburm))
- GCE: Enable by default audit logging truncating backend. ([#68288](https://github.com/kubernetes/kubernetes/pull/68288), [@loburm](https://github.com/loburm))
- Bumped cluster-proportional-autoscaler to 1.3.0 ([#69338](https://github.com/kubernetes/kubernetes/pull/69338), [@MrHohn](https://github.com/MrHohn))
- Updated defaultbackend to v1.5 ([#69334](https://github.com/kubernetes/kubernetes/pull/69334), [@bowei](https://github.com/bowei))

### SIG GCP

- Added tolerations for Stackdriver Logging and Metadata Agents. ([#69737](https://github.com/kubernetes/kubernetes/pull/69737), [@qingling128](https://github.com/qingling128))
- Enabled insertId generation, and updated Stackdriver Logging Agent image to 0.5-1.5.36-1-k8s. This help reduce log duplication and guarantee log order. ([#68920](https://github.com/kubernetes/kubernetes/pull/68920), [@qingling128](https://github.com/qingling128))
- Updated crictl to v1.12.0 ([#69033](https://github.com/kubernetes/kubernetes/pull/69033), [@feiskyer](https://github.com/feiskyer))

### SIG Network

- Corrected family type (inet6) for ipsets in ipv6-only clusters ([#68436](https://github.com/kubernetes/kubernetes/pull/68436), [@uablrek](https://github.com/uablrek))
- kube-proxy argument `hostname-override` can be used to override hostname defined in the configuration file ([#69340](https://github.com/kubernetes/kubernetes/pull/69340), [@stevesloka](https://github.com/stevesloka))
- CoreDNS correctly implements DNS spec for Services with externalNames that look like IP addresses. Kube-dns does not follow the spec for the same case, resulting in a behavior change when moving from Kube-dns to CoreDNS. See: [coredns/coredns#2324](https://github.com/coredns/coredns/issues/2324)
- IPVS proxier now set net/ipv4/vs/conn_reuse_mode to 0 by default, which will highly improve IPVS proxier performance. ([#71114](https://github.com/kubernetes/kubernetes/pull/71114), [@Lion-Wei](https://github.com/Lion-Wei))
- CoreDNS is now version 1.2.6 ([#70799](https://github.com/kubernetes/kubernetes/pull/70799), [@rajansandeep](https://github.com/rajansandeep))
- Addon configuration is introduced in the kubeadm config API, while feature flag CoreDNS is now deprecated. ([#70024](https://github.com/kubernetes/kubernetes/pull/70024), [@fabriziopandini](https://github.com/fabriziopandini))

### SIG Node

- Fixed a bug in previous releases where a pod could be placed inside another pod's cgroup when specifying --cgroup-root ([#70678](https://github.com/kubernetes/kubernetes/pull/70678), [@dashpole](https://github.com/dashpole))
- Optimized calculating stats when only CPU and Memory stats are returned from Kubelet stats/summary http endpoint.  ([#68841](https://github.com/kubernetes/kubernetes/pull/68841), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- kubelet now supports `log-file` option to write logs directly to a specific file ([#70917](https://github.com/kubernetes/kubernetes/pull/70917), [@dims](https://github.com/dims))
- Do not detach volume if mount in progress ([#71145](https://github.com/kubernetes/kubernetes/pull/71145), [@gnufied](https://github.com/gnufied))
- The runtimeHandler field on the RuntimeClass resource now accepts the empty string. ([#69550](https://github.com/kubernetes/kubernetes/pull/69550), [@tallclair](https://github.com/tallclair))
- kube-apiserver: fixes `procMount` field incorrectly being marked as required in openapi schema ([#69694](https://github.com/kubernetes/kubernetes/pull/69694), [@jessfraz](https://github.com/jessfraz))

### SIG OpenStack

- Fixed cloud-controller-manager crash when using OpenStack provider and PersistentVolume initializing controller   ([#70459](https://github.com/kubernetes/kubernetes/pull/70459), [@mvladev](https://github.com/mvladev))

### SIG Release

- Use debian-base instead of busybox as base image for server images ([#70245](https://github.com/kubernetes/kubernetes/pull/70245), [@ixdy](https://github.com/ixdy))
- Images for cloud-controller-manager, kube-apiserver, kube-controller-manager, and kube-scheduler now contain a minimal /etc/nsswitch.conf and should respect /etc/hosts for lookups ([#69238](https://github.com/kubernetes/kubernetes/pull/69238), [@BenTheElder](https://github.com/BenTheElder))

### SIG Scheduling

- Added metrics for volume scheduling operations ([#59529](https://github.com/kubernetes/kubernetes/pull/59529), [@wackxu](https://github.com/wackxu))
- Improved memory use and performance when processing large numbers of pods containing tolerations ([#65350](https://github.com/kubernetes/kubernetes/pull/65350), [@liggitt](https://github.com/liggitt))
- Fixed a bug in the scheduler that could cause the scheduler to go to an infinite loop when all nodes in a zone are removed. ([#69758](https://github.com/kubernetes/kubernetes/pull/69758), [@bsalamat](https://github.com/bsalamat))
- Clear pod binding cache on bind error to make sure stale pod binding cache will not be used. ([#71212](https://github.com/kubernetes/kubernetes/pull/71212), [@cofyc](https://github.com/cofyc))
- Fixed a scheduler panic due to internal cache inconsistency ([#71063](https://github.com/kubernetes/kubernetes/pull/71063), [@Huang-Wei](https://github.com/Huang-Wei))
- Report kube-scheduler unhealthy if leader election is deadlocked. ([#71085](https://github.com/kubernetes/kubernetes/pull/71085), [@bsalamat](https://github.com/bsalamat))
- Fixed a potential bug that scheduler preempts unnecessary pods. ([#70898](https://github.com/kubernetes/kubernetes/pull/70898), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Storage

- Fixed CSI volume limits not showing up in node's capacity and allocatable ([#70540](https://github.com/kubernetes/kubernetes/pull/70540), [@gnufied](https://github.com/gnufied))
- CSI drivers now have access to mountOptions defined on the storage class when attaching volumes. ([#67898](https://github.com/kubernetes/kubernetes/pull/67898), [@bswartz](https://github.com/bswartz))
- change default azure file mount permission to 0777 ([#69854](https://github.com/kubernetes/kubernetes/pull/69854), [@andyzhangx](https://github.com/andyzhangx))
- Fixed subpath in containerized kubelet. ([#69565](https://github.com/kubernetes/kubernetes/pull/69565), [@jsafrane](https://github.com/jsafrane))
- Fixed panic on iSCSI volume tear down. ([#69140](https://github.com/kubernetes/kubernetes/pull/69140), [@jsafrane](https://github.com/jsafrane))
- CSIPersistentVolume feature, i.e. PersistentVolumes with CSIPersistentVolumeSource, is GA.  ([#69929](https://github.com/kubernetes/kubernetes/pull/69929), [@jsafrane](https://github.com/jsafrane))
- Fixed CSIDriver API object to allow missing fields. ([#69331](https://github.com/kubernetes/kubernetes/pull/69331), [@jsafrane](https://github.com/jsafrane))
- Flex volume plugins now support expandvolume (to increase underlying volume capacity) and expanfs (resize filesystem) commands that Flex plugin authors can implement to support expanding in use Flex PersistentVolumes ([#67851](https://github.com/kubernetes/kubernetes/pull/67851), [@aniket-s-kulkarni](https://github.com/aniket-s-kulkarni))
- Enabled AttachVolumeLimit feature ([#69225](https://github.com/kubernetes/kubernetes/pull/69225), [@gnufied](https://github.com/gnufied))
- The default storage class annotation for the storage addons has been changed to use the GA variant ([#68345](https://github.com/kubernetes/kubernetes/pull/68345), [@smelchior](https://github.com/smelchior))
- GlusterFS PersistentVolumes sources can now reference endpoints in any namespace using the `spec.glusterfs.endpointsNamespace` field. Ensure all kubelets are upgraded to 1.13+ before using this capability. ([#60195](https://github.com/kubernetes/kubernetes/pull/60195), [@humblec](https://github.com/humblec))
- Fixed GetVolumeLimits log flushing issue ([#69558](https://github.com/kubernetes/kubernetes/pull/69558), [@andyzhangx](https://github.com/andyzhangx))
- The `MountPropagation` feature is unconditionally enabled in v1.13, and can no longer be disabled. ([#68230](https://github.com/kubernetes/kubernetes/pull/68230), [@bertinatto](https://github.com/bertinatto))

### SIG Windows

-	`kubelet --system-reserved` and `--kube-reserved` are supported now on Windows nodes ([#69960](https://github.com/kubernetes/kubernetes/pull/69960), [@feiskyer](https://github.com/feiskyer))
- Windows runtime endpoints is now switched to `npipe:////./pipe/dockershim` from `tcp://localhost:3735`. ([#69516](https://github.com/kubernetes/kubernetes/pull/69516), [@feiskyer](https://github.com/feiskyer))
- Fixed service issues with named targetPort for Windows ([#70076](https://github.com/kubernetes/kubernetes/pull/70076), [@feiskyer](https://github.com/feiskyer))
- Handle Windows named pipes in host mounts. ([#69484](https://github.com/kubernetes/kubernetes/pull/69484), [@ddebroy](https://github.com/ddebroy))
- Fixed inconsistency in windows kernel proxy when updating HNS policy. ([#68923](https://github.com/kubernetes/kubernetes/pull/68923), [@delulu](https://github.com/delulu))

##  External Dependencies

- Default etcd server is unchanged at v3.2.24 since Kubernetes 1.12. ([#68318](https://github.com/kubernetes/kubernetes/pull/68318))
- The list of validated docker versions remain unchanged at 1.11.1, 1.12.1, 1.13.1, 17.03, 17.06, 17.09, 18.06 since Kubernetes 1.12. ([#68495](https://github.com/kubernetes/kubernetes/pull/68495))
- The default Go version was updated to 1.11.2. ([#70665](https://github.com/kubernetes/kubernetes/pull/70665))
- The minimum supported Go version was updated to 1.11.2 ([#69386](https://github.com/kubernetes/kubernetes/pull/69386))
- CNI is unchanged at v0.6.0 since Kubernetes 1.10 ([#51250](https://github.com/kubernetes/kubernetes/pull/51250))
- CSI is updated to 1.0.0. Pre-1.0.0 API support is now deprecated. ([#71020](https://github.com/kubernetes/kubernetes/pull/71020)])
- The dashboard add-on has been updated to v1.10.0. ([#68450](https://github.com/kubernetes/kubernetes/pull/68450))
- Heapster remains at v1.6.0-beta, but is now retired in Kubernetes 1.13  ([#67074](https://github.com/kubernetes/kubernetes/pull/67074))
- Cluster Autoscaler has been upgraded to v1.13.0 ([#71513](https://github.com/kubernetes/kubernetes/pull/71513))
- kube-dns is unchanged at v1.14.13 since Kubernetes 1.12 ([#68900](https://github.com/kubernetes/kubernetes/pull/68900))
- Influxdb is unchanged at v1.3.3 since Kubernetes 1.10 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Grafana is unchanged at v4.4.3 since Kubernetes 1.10 ([#53319](https://github.com/kubernetes/kubernetes/pull/53319))
- Kibana has been upgraded to v6.3.2.  ([#67582](https://github.com/kubernetes/kubernetes/pull/67582))
- CAdvisor has been updated to v0.32.0 ([#70964](https://github.com/kubernetes/kubernetes/pull/70964))
- fluentd-gcp-scaler has been updated to v0.5.0 ([#68837](https://github.com/kubernetes/kubernetes/pull/68837))
- Fluentd in fluentd-elasticsearch is unchanged at v1.2.4 since Kubernetes 1.11 ([#67434](https://github.com/kubernetes/kubernetes/pull/67434))
- fluentd-elasticsearch has been updated to v2.2.1 ([#68012](https://github.com/kubernetes/kubernetes/pull/68012))
- The fluent-plugin-kubernetes_metadata_filter plugin in fluentd-elasticsearch is unchanged at 2.0.0 since Kubernetes 1.12 ([#67544](https://github.com/kubernetes/kubernetes/pull/67544))
- fluentd-gcp has been updated to v3.2.0 ([#70954](https://github.com/kubernetes/kubernetes/pull/70954))
- OIDC authentication is unchanged at coreos/go-oidc v2 since Kubernetes 1.10 ([#58544](https://github.com/kubernetes/kubernetes/pull/58544))
- Calico was updated to v3.3.1 ([#70932](https://github.com/kubernetes/kubernetes/pull/70932))
- Upgraded crictl on GCE to v1.12.0 ([#69033](https://github.com/kubernetes/kubernetes/pull/69033))
- CoreDNS has been updated to v1.2.6 ([#70799](https://github.com/kubernetes/kubernetes/pull/70799))
- event-exporter has been updated to v0.2.3 ([#67691](https://github.com/kubernetes/kubernetes/pull/67691))
- Es-image remains unchanged at Elasticsearch 6.3.2 since Kubernetes 1.12 ([#67484](https://github.com/kubernetes/kubernetes/pull/67484))
- metrics-server remains unchanged at v0.3.1 since Kubernetes 1.12 ([#68746](https://github.com/kubernetes/kubernetes/pull/68746))
- GLBC remains unchanged at v1.2.3 since Kubernetes 1.12 ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- Ingress-gce remains unchanged at v1.2.3 since Kubernetes 1.12 ([#66793](https://github.com/kubernetes/kubernetes/pull/66793))
- ip-masq-agen remains unchanged at v2.1.1 since Kubernetes 1.12 ([#67916](https://github.com/kubernetes/kubernetes/pull/67916))
