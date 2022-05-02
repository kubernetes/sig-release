## Major Themes

### Dockershim Removed from kubelet

After its deprecation in v1.20, the dockershim component has been removed from the kubelet.
From v1.24 onwards, you will need to either use one of the other [supported runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/) (such as containerd or CRI-O)
or use cri-dockerd if you are relying on Docker Engine as your container runtime.
For more information about ensuring your cluster is ready for this removal, please
see [this guide](/blog/2022/03/31/ready-for-dockershim-removal/).

### Beta APIs Off by Default

[New beta APIs will not be enabled in clusters by default](https://github.com/kubernetes/enhancements/issues/3136).
Existing beta APIs and new versions of existing beta APIs, will continue to be enabled by default.

### Signing Release Artifacts

Release artifacts are [signed](https://github.com/kubernetes/enhancements/issues/3031) using [cosign](https://github.com/sigstore/cosign)
signatures
and there is experimental support for [verifying image signatures](/docs/tasks/administer-cluster/verify-signed-images/).
Signing and verification of release artifacts is part of [increasing software supply chain security for the Kubernetes release process](https://github.com/kubernetes/enhancements/issues/3027).

### OpenAPI v3

Kubernetes 1.24 offers beta support for publishing its APIs in the [OpenAPI v3 format](https://github.com/kubernetes/enhancements/issues/2896).

### Storage Capacity and Volume Expansion Are Generally Available

[Storage capacity tracking](https://github.com/kubernetes/enhancements/issues/1472)
supports exposing currently available storage capacity via [CSIStorageCapacity objects](https://kubernetes.io/docs/concepts/storage/storage-capacity/#api)
and enhances scheduling of pods that use CSI volumes with late binding.

[Volume expansion](https://github.com/kubernetes/enhancements/issues/284) adds support
for resizing existing persistent volumes.

### NonPreemptingPriority to Stable

This feature adds [a new option to PriorityClasses](https://github.com/kubernetes/enhancements/issues/902),
which can enable or disable pod preemption.

### Storage Plugin Migration

There is work under way to [migrate the internals of in-tree storage plugins](https://github.com/kubernetes/enhancements/issues/625) to call out to CSI Plugins,
while maintaining the original API.
The [Azure Disk](https://github.com/kubernetes/enhancements/issues/1490)
and [OpenStack Cinder](https://github.com/kubernetes/enhancements/issues/1489) plugins
have both been migrated.

### gRPC Probes Graduate to Beta

With Kubernetes 1.24, the [gRPC probes functionality](https://github.com/kubernetes/enhancements/issues/2727)
has entered beta and is available by default. You can now [configure startup, liveness, and readiness probes](/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes) for your gRPC app
natively within Kubernetes, without exposing an HTTP endpoint or
using an extra executable.

### Kubelet Credential Provider Graduates to Beta

Originally released as Alpha in Kubernetes 1.20, the kubelet's support for
[image credential providers](/docs/tasks/kubelet-credential-provider/kubelet-credential-provider/)
has now graduated to Beta.
This allows the kubelet to dynamically retrieve credentials for a container image registry
using exec plugins, rather than storing credentials on the node's filesystem.

### Contextual Logging in Alpha

Kubernetes 1.24 has introduced [contextual logging](https://github.com/kubernetes/enhancements/issues/3077)
that enables the caller of a function to control all aspects of logging (output formatting, verbosity, additional values and names).

### Avoiding Collisions in IP allocation to Services

Kubernetes 1.24 introduced a new opt-in feature that allows you to
[soft-reserve a range for static IP address assignments](/docs/concepts/services-networking/service/#service-ip-static-sub-range)
to Services.
With the manual enablement of this feature, the cluster will prefer automatic assignment from
the pool of Service IP addresses thereby reducing the risk of collision.

A Service `ClusterIP` can be assigned:

* dynamically, which means the cluster will automatically pick a free IP within the configured Service IP range.
* statically, which means the user will set one IP within the configured Service IP range.

Service `ClusterIP` are unique, hence, trying to create a Service with a `ClusterIP` that has already been allocated will return an error.

## Urgent Upgrade Notes

### (No, really, you MUST read this before you upgrade)

- Docker runtime support using dockershim in the kubelet is now completely removed in 1.24. The kubelet used to have a module called dockershim, which implements CRI support for Docker, and it has seen maintenance issues in the Kubernetes community. From 1.24 onwards, please move to a container runtime that is a full-fledged implementation of CRI (v1alpha1 or v1 compliant) as they become available. ([#97252](https://github.com/kubernetes/kubernetes/pull/97252), [@dims](https://github.com/dims))
- Fixed bug with leads to Node goes `Not-ready` state when credentials for vCenter stored in a secret and Zones feature is in use. Zone labels setup moved to KCM component, kubelet skips this step during startup in such case. If credentials stored in cloud-provider config file as plaintext current behaviour does not change and no action required. For proper functioning `kube-system:vsphere-legacy-cloud-provider` should be allowed to update node object if vCenter credentials stored in secret and Zone feature used. ([#101028](https://github.com/kubernetes/kubernetes/pull/101028), [@lobziik](https://github.com/lobziik))
- The `LegacyServiceAccountTokenNoAutoGeneration` feature gate is beta, and enabled by default. When enabled, Secret API objects containing service account tokens are no longer auto-generated for every ServiceAccount. Use the [TokenRequest](https://kubernetes.io/docs/reference/kubernetes-api/authentication-resources/token-request-v1/) API to acquire service account tokens, or if a non-expiring token is required, create a Secret API object for the token controller to populate with a service account token by following this [guide](https://kubernetes.io/docs/concepts/configuration/secret/#service-account-token-secrets). ([#108309](https://github.com/kubernetes/kubernetes/pull/108309), [@zshihang](https://github.com/zshihang))
- The calculations for Pod topology spread skew now exclude nodes that
  don't match the node affinity/selector. This may lead to unschedulable pods if you previously had pods
  matching the spreading selector on those excluded nodes (not matching the node affinity/selector),
  especially when the `topologyKey` is not node-level. Revisit the node affinity and/or pod selector in the
  topology spread constraints to avoid this scenario. ([#107009](https://github.com/kubernetes/kubernetes/pull/107009), [@kerthcet](https://github.com/kerthcet))
- Remove the deprecated flag `--experimental-check-node-capabilities-before-mount`. With CSI now GA, there is a better alternative. Remove any use of  `--experimental-check-node-capabilities-before-mount` from your kubelet scripts or manifests. ([#104732](https://github.com/kubernetes/kubernetes/pull/104732), [@mengjiao-liu](https://github.com/mengjiao-liu))
- `kubeadm.k8s.io/v1beta2` has been deprecated and will be removed in a future release, possibly in 3 releases (one year). You should start using `kubeadm.k8s.io/v1beta3` for new clusters. To migrate your old configuration files on disk you can use the `kubeadm config migrate` command. ([#107013](https://github.com/kubernetes/kubernetes/pull/107013), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: default the kubeadm configuration to the containerd socket (Unix: `unix:///var/run/containerd/containerd.sock`, Windows: `npipe:////./pipe/containerd-containerd`) instead of the one for Docker. If the `Init|JoinConfiguration.nodeRegistration.criSocket` field is empty during cluster creation and multiple sockets are found on the host always throw an error and ask the user to specify which one to use by setting the value in the field. Make sure you update any kubeadm configuration files on disk, to not include the dockershim socket unless you are still using kubelet version < 1.24 with kubeadm >= 1.24. Remove the DockerValidor and ServiceCheck for the `docker` service from kubeadm preflight. Docker is no longer special cased during host validation and ideally this task should be done in the now external cri-dockerd project where the importance of the compatibility matters. Use `crictl` for all communication with CRI sockets for actions like pulling images and obtaining a list of running containers instead of using the docker CLI in the case of Docker. ([#107317](https://github.com/kubernetes/kubernetes/pull/107317), [@neolit123](https://github.com/neolit123))
- The feature gate was mentioned as `csiMigrationRBD` where it should have been `CSIMigrationRBD` to be in parity with other migration plugins. This release correct the same and keep it as `CSIMigrationRBD`.
    users who have configured this feature gate as `csiMigrationRBD` has to reconfigure the same to `CSIMigrationRBD` from this release. ([#107554](https://github.com/kubernetes/kubernetes/pull/107554), [@humblec](https://github.com/humblec))
- The experimental dynamic log sanitization feature has been deprecated and removed in the 1.24 release. The feature is no longer available for use. ([#107207](https://github.com/kubernetes/kubernetes/pull/107207), [@ehashman](https://github.com/ehashman))
- Kubeadm: apply `second stage` of the plan to migrate kubeadm away from the usage of the word `master` in labels and taints. For new clusters, the label `node-role.kubernetes.io/master` will no longer be added to control plane nodes, only the label `node-role.kubernetes.io/control-plane` will be added. For clusters that are being upgraded to 1.24 with `kubeadm upgrade apply`, the command will remove the label `node-role.kubernetes.io/master` from existing control plane nodes. For new clusters, both the old taint `node-role.kubernetes.io/master:NoSchedule` and new taint `node-role.kubernetes.io/control-plane:NoSchedule` will be added to control plane nodes. In release 1.20 (`first stage`), a release note instructed to preemptively tolerate the new taint. For clusters that are being upgraded to 1.24 with `kubeadm upgrade apply`, the command will add the new taint `node-role.kubernetes.io/control-plane:NoSchedule` to existing control plane nodes. Please adapt your infrastructure to these changes. In 1.25 the old taint `node-role.kubernetes.io/master:NoSchedule` will be removed. ([#107533](https://github.com/kubernetes/kubernetes/pull/107533), [@neolit123](https://github.com/neolit123))
- The feature gate was mentioned as `csiMigrationRBD` where it should have been `CSIMigrationRBD` to be in parity with other migration plugins. This release correct the same and keep it as `CSIMigrationRBD`.
  users who have configured this feature gate as `csiMigrationRBD` has to reconfigure the same to `CSIMigrationRBD` from this release. ([#107554](https://github.com/kubernetes/kubernetes/pull/107554), [@humblec](https://github.com/humblec))

## Changes by Kind

### Deprecation

- Deprecated `Service.Spec.LoadBalancerIP`. This field was under-specified and its meaning varies across implementations.  As of Kubernetes v1.24, users are encouraged to use implementation-specific annotations when available.  This field may be removed in a future API version. ([#107235](https://github.com/kubernetes/kubernetes/pull/107235), [@uablrek](https://github.com/uablrek))
- Kube-apiserver: the `--master-count` flag and `--endpoint-reconciler-type=master-count` reconciler are deprecated in favor of the lease reconciler ([#108062](https://github.com/kubernetes/kubernetes/pull/108062), [@aojea](https://github.com/aojea))
- Kube-apiserver: the insecure address flags `--address`, `--insecure-bind-address`, `--port` and `--insecure-port` (inert since 1.20) are removed ([#106859](https://github.com/kubernetes/kubernetes/pull/106859), [@knight42](https://github.com/knight42))
- Kubeadm: graduated the `UnversionedKubeletConfigMap` feature gate to Beta and enabled the feature by default. This implies that 1) for new clusters kubeadm will start using the `kube-system/kubelet-config` naming scheme for the kubelet ConfigMap and RBAC rules, instead of the legacy `kubelet-config-x.yy` naming. 2) during upgrade, kubeadm will only write the new scheme ConfigMap and RBAC objects. To disable the feature you can pass `UnversionedKubeletConfigMap: false` in the kubeadm config for new clusters. For upgrade on existing clusters you can also override the behavior by patching the ClusterConfiguration object in `kube-system/kubeadm-config`. More details in the associated KEP. ([#108027](https://github.com/kubernetes/kubernetes/pull/108027), [@neolit123](https://github.com/neolit123))
- Remove `tolerate-unready-endpoints` annotation in Service deprecated from 1.11, use `Service.spec.publishNotReadyAddresses` instead. ([#108020](https://github.com/kubernetes/kubernetes/pull/108020), [@tossmilestone](https://github.com/tossmilestone))
- Remove deprecated feature gates `ValidateProxyRedirects` and `StreamingProxyRedirects` ([#106830](https://github.com/kubernetes/kubernetes/pull/106830), [@pacoxu](https://github.com/pacoxu))
- Remove insecure serving configuration from cloud-provider package, which is consumed by cloud-controller-managers. ([#108953](https://github.com/kubernetes/kubernetes/pull/108953), [@nckturner](https://github.com/nckturner))
- The `--pod-infra-container-image` kubelet flag is deprecated and will be removed in future releases ([#108045](https://github.com/kubernetes/kubernetes/pull/108045), [@hakman](https://github.com/hakman))
- The `client.authentication.k8s.io/v1alpha1` ExecCredential has been removed. If you are using a client-go credential plugin that relies on the v1alpha1 API please contact the distributor of your plugin for instructions on how to migrate to the v1 API. ([#108616](https://github.com/kubernetes/kubernetes/pull/108616), [@margocrawf](https://github.com/margocrawf))
- The `node.k8s.io/v1alpha1` RuntimeClass API is no longer served. Use the `node.k8s.io/v1` API version, available since v1.20 ([#103061](https://github.com/kubernetes/kubernetes/pull/103061), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- The cluster addon for dashboard was removed. To install dashboard, see [here](https://github.com/kubernetes/dashboard/blob/master/docs/user/README.md). ([#107481](https://github.com/kubernetes/kubernetes/pull/107481), [@shu-mutou](https://github.com/shu-mutou))
- The in-tree Azure plugin has been deprecated. The Azure kubelogin plugin serves as an out-of-tree replacement via the kubectl/client-go credential plugin mechanism.  Users will now see a warning in the logs regarding this deprecation. ([#107904](https://github.com/kubernetes/kubernetes/pull/107904), [@sabbey37](https://github.com/sabbey37))
- The insecure address flags `--address` and `--port` in kube-controller-manager have had no effect since v1.20 and are removed in v1.24. ([#106860](https://github.com/kubernetes/kubernetes/pull/106860), [@knight42](https://github.com/knight42))
- The metadata.clusterName field is deprecated. This field has always been unwritable and always blank, but its presence is confusing, so we will remove it next release. Out of an abundance of caution, this release we have merely changed the name in the go struct to ensure any accidental client uses are found before complete removal. ([#108717](https://github.com/kubernetes/kubernetes/pull/108717), [@lavalamp](https://github.com/lavalamp))
- VSphere releases less than 7.0u2 are deprecated as of v1.24. Please consider upgrading vSphere to 7.0u2 or above. vSphere CSI Driver requires minimum vSphere 7.0u2.

  General Support for vSphere 6.7 will end on October 15, 2022. vSphere 6.7 Update 3 is deprecated in Kubernetes v1.24.  Customers are recommended to upgrade vSphere (both ESXi and vCenter) to 7.0u2 or above.  vSphere CSI Driver 2.2.3 and higher supports CSI Migration.

  Support for these deprecations will be available till October 15, 2022. ([#109089](https://github.com/kubernetes/kubernetes/pull/109089), [@deepakkinni](https://github.com/deepakkinni))

### API Change

- Add 2 new options for kube-proxy running in winkernel mode. `--forward-healthcheck-vip`, if specified as true, health check traffic whose destination is service VIP will be forwarded to kube-proxy's healthcheck service. `--root-hnsendpoint-name` specifies the name of the hns endpoint for the root network namespace. This option enables the pass-through load balancers like Google's GCLB to correctly health check the backend services. Without this change, the health check packets is dropped, and Windows node will be considered to be unhealthy by those load balancers. ([#99287](https://github.com/kubernetes/kubernetes/pull/99287), [@anfernee](https://github.com/anfernee))
- Added CEL runtime cost calculation into CustomerResource validation. CustomerResource validation will fail if runtime cost exceeds the budget. ([#108482](https://github.com/kubernetes/kubernetes/pull/108482), [@cici37](https://github.com/cici37))
- Added a new metric `webhook_fail_open_count` to monitor webhooks that fail to open. ([#107171](https://github.com/kubernetes/kubernetes/pull/107171), [@ltagliamonte-dd](https://github.com/ltagliamonte-dd))
- Adds a new Status subresource in Network Policy objects ([#107963](https://github.com/kubernetes/kubernetes/pull/107963), [@rikatz](https://github.com/rikatz))
- Adds support for `InterfaceNamePrefix` and `BridgeInterface` as arguments to `--detect-local-mode` option and also introduces a new optional `--pod-interface-name-prefix` and `--pod-bridge-interface` flags to kube-proxy. ([#95400](https://github.com/kubernetes/kubernetes/pull/95400), [@tssurya](https://github.com/tssurya))
- CEL CRD validation expressions may now reference existing object state using the identifier `oldSelf`. ([#108073](https://github.com/kubernetes/kubernetes/pull/108073), [@benluddy](https://github.com/benluddy))
- CRD deep copies should no longer contain shallow copies of `JSONSchemaProps.XValidations`. ([#107956](https://github.com/kubernetes/kubernetes/pull/107956), [@benluddy](https://github.com/benluddy))
- CRD writes will generate validation errors if a CEL validation rule references the identifier `oldSelf` on a part of the schema that does not support it. ([#108013](https://github.com/kubernetes/kubernetes/pull/108013), [@benluddy](https://github.com/benluddy))
- CSIStorageCapacity.storage.k8s.io: The v1beta1 version of this API is deprecated in favor of v1, and will be removed in v1.27. If a CSI driver supports storage capacity tracking, then it must get deployed with a release of external-provisioner that supports the v1 API. ([#108445](https://github.com/kubernetes/kubernetes/pull/108445), [@pohly](https://github.com/pohly))
- Custom resource requests with `fieldValidation=Strict` consistently require `apiVersion` and `kind`, matching non-strict requests ([#109019](https://github.com/kubernetes/kubernetes/pull/109019), [@liggitt](https://github.com/liggitt))
- Feature of `DefaultPodTopologySpread` is graduated to GA ([#108278](https://github.com/kubernetes/kubernetes/pull/108278), [@kerthcet](https://github.com/kerthcet))
- Feature of `NonPreemptingPriority` is graduated to GA ([#107432](https://github.com/kubernetes/kubernetes/pull/107432), [@denkensk](https://github.com/denkensk))
- Feature of `PodOverhead` is graduated to GA ([#108441](https://github.com/kubernetes/kubernetes/pull/108441), [@pacoxu](https://github.com/pacoxu))
- Fixed OpenAPI serialization of the x-kubernetes-validations field ([#107970](https://github.com/kubernetes/kubernetes/pull/107970), [@liggitt](https://github.com/liggitt))
- Fixed failed flushing logs in defer function when kubelet cmd exit 1. ([#104774](https://github.com/kubernetes/kubernetes/pull/104774), [@kerthcet](https://github.com/kerthcet))
- Fixes a regression in v1beta1 PodDisruptionBudget handling of `strategic merge patch`-type API requests for the `selector` field. Prior to 1.21, these requests would merge `matchLabels` content and replace `matchExpressions` content. In 1.21, patch requests touching the `selector` field started replacing the entire selector. This is consistent with server-side apply and the v1 PodDisruptionBudget behavior, but should not have been changed for v1beta1. ([#108138](https://github.com/kubernetes/kubernetes/pull/108138), [@liggitt](https://github.com/liggitt))
- Improve kubectl's user help commands readability ([#104736](https://github.com/kubernetes/kubernetes/pull/104736), [@lauchokyip](https://github.com/lauchokyip))
- Indexed Jobs graduated to stable. ([#107395](https://github.com/kubernetes/kubernetes/pull/107395), [@alculquicondor](https://github.com/alculquicondor))
- Introduce a v1alpha1 networking API for ClusterCIDRConfig ([#108290](https://github.com/kubernetes/kubernetes/pull/108290), [@sarveshr7](https://github.com/sarveshr7))
- Introduction of a new "sync_proxy_rules_no_local_endpoints_total" proxy metric. This metric represents the number of services with no internal endpoints. The "traffic_policy" label will contain both "internal" or "external". ([#108930](https://github.com/kubernetes/kubernetes/pull/108930), [@MaxRenaud](https://github.com/MaxRenaud))
- JobReadyPods graduates to Beta and it's enabled by default. ([#107476](https://github.com/kubernetes/kubernetes/pull/107476), [@alculquicondor](https://github.com/alculquicondor))
- Kube-apiserver: `--audit-log-version` and `--audit-webhook-version` now only support the default value of `audit.k8s.io/v1`. The v1alpha1 and v1beta1 audit log versions, deprecated since 1.13, have been removed. ([#108092](https://github.com/kubernetes/kubernetes/pull/108092), [@carlory](https://github.com/carlory))
- Kube-apiserver: the `metadata.selfLink` field can no longer be populated by kube-apiserver; it was deprecated in 1.16 and has not been populated by default since 1.20+. ([#107527](https://github.com/kubernetes/kubernetes/pull/107527), [@wojtek-t](https://github.com/wojtek-t))
- Kubelet external Credential Provider feature is moved to Beta. Credential Provider Plugin and Credential Provider Config API's updated from v1alpha1 to v1beta1 with no API changes. ([#108847](https://github.com/kubernetes/kubernetes/pull/108847), [@adisky](https://github.com/adisky))
- Make STS available replicas optional again. ([#109241](https://github.com/kubernetes/kubernetes/pull/109241), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- MaxUnavailable for StatefulSets, allows faster RollingUpdate by taking down more than 1 pod at a time. The number of pods you want to take down during a RollingUpdate is configurable using maxUnavailable parameter. ([#82162](https://github.com/kubernetes/kubernetes/pull/82162), [@krmayankk](https://github.com/krmayankk))
- Non-graceful node shutdown handling is enabled for stateful workload failovers ([#108486](https://github.com/kubernetes/kubernetes/pull/108486), [@sonasingh46](https://github.com/sonasingh46))
- Omit enum declarations from the static openapi file captured at https://git.k8s.io/kubernetes/api/openapi-spec. This file is used to generate API clients, and use of enums in those generated clients (rather than strings) can break forward compatibility with additional future values in those fields. See https://issue.k8s.io/109177 for details. ([#109178](https://github.com/kubernetes/kubernetes/pull/109178), [@liggitt](https://github.com/liggitt))
- OpenAPI V3 is turned on by default ([#109031](https://github.com/kubernetes/kubernetes/pull/109031), [@Jefftree](https://github.com/Jefftree))
- Pod affinity namespace selector and cross-namespace quota graduated to GA. The feature gate `PodAffinityNamespaceSelector` is locked and will be removed in 1.26. ([#108136](https://github.com/kubernetes/kubernetes/pull/108136), [@ahg-g](https://github.com/ahg-g))
- Promote IdentifyPodOS feature to beta. ([#107859](https://github.com/kubernetes/kubernetes/pull/107859), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Remove a v1alpha1 networking API for ClusterCIDRConfig ([#109436](https://github.com/kubernetes/kubernetes/pull/109436), [@JamesLaverack](https://github.com/JamesLaverack))
- Renamed metrics `evictions_number` to `evictions_total` and mark it as stable. The original `evictions_number` metrics name is marked as "Deprecated" and has been removed in kubernetes 1.23 . ([#106366](https://github.com/kubernetes/kubernetes/pull/106366), [@cyclinder](https://github.com/cyclinder))
- Skip x-kubernetes-validations rules if having fundamental error against the OpenAPIv3 schema. ([#108859](https://github.com/kubernetes/kubernetes/pull/108859), [@cici37](https://github.com/cici37))
- Support for gRPC probes is now in beta. GRPCContainerProbe feature gate is enabled by default. ([#108522](https://github.com/kubernetes/kubernetes/pull/108522), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- Suspend job to GA. The feature gate `SuspendJob` is locked and will be removed in 1.26. ([#108129](https://github.com/kubernetes/kubernetes/pull/108129), [@ahg-g](https://github.com/ahg-g))
- The AnyVolumeDataSource feature is now beta, and the feature gate is enabled by default. In order to provide user feedback on PVCs with data sources, deployers must install the VolumePopulators CRD and the data-source-validator controller. ([#108736](https://github.com/kubernetes/kubernetes/pull/108736), [@bswartz](https://github.com/bswartz))
- The CertificateSigningRequest `spec.expirationSeconds` API field has graduated to GA. The `CSRDuration` feature gate for the field is now unconditionally enabled and will be removed in 1.26. ([#108782](https://github.com/kubernetes/kubernetes/pull/108782), [@cfryanr](https://github.com/cfryanr))
- The `ServerSideFieldValidation` feature has graduated to beta and is now enabled by default. Kubectl 1.24 and newer will use server-side validation instead of client-side validation when writing to API servers with the feature enabled. ([#108889](https://github.com/kubernetes/kubernetes/pull/108889), [@kevindelgado](https://github.com/kevindelgado))
- The `ServiceLBNodePortControl` feature has graduated to GA. The feature gate will be removed in 1.26. ([#107027](https://github.com/kubernetes/kubernetes/pull/107027), [@uablrek](https://github.com/uablrek))
- The deprecated kube-controller-manager flag '--deployment-controller-sync-period' has been removed, it is not used by the deployment controller. ([#107178](https://github.com/kubernetes/kubernetes/pull/107178), [@SataQiu](https://github.com/SataQiu))
- The feature `DynamicKubeletConfig` has been removed from the kubelet. ([#106932](https://github.com/kubernetes/kubernetes/pull/106932), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- The infrastructure for contextual logging is complete (feature gate implemented, JSON backend ready). ([#108995](https://github.com/kubernetes/kubernetes/pull/108995), [@pohly](https://github.com/pohly))
- This adds an optional `timeZone` field as part of the CronJob spec to support running cron jobs in a specific time zone. ([#108032](https://github.com/kubernetes/kubernetes/pull/108032), [@deejross](https://github.com/deejross))
- Updated the default API priority-and-fairness config to avoid endpoint/configmaps operations from controller-manager to all match leader-election priority level. ([#106725](https://github.com/kubernetes/kubernetes/pull/106725), [@wojtek-t](https://github.com/wojtek-t))
- `topologySpreadConstraints` includes `minDomains` field to limit the minimum number of topology domains. ([#107674](https://github.com/kubernetes/kubernetes/pull/107674), [@sanposhiho](https://github.com/sanposhiho))

### Feature

- A new Priority and Fairness metric 'apiserver_flowcontrol_work_estimate_seats_samples' has been added that tracks the estimated seats associated with a request. ([#106628](https://github.com/kubernetes/kubernetes/pull/106628), [@tkashem](https://github.com/tkashem))
- Add a deprecated cmd flag for the time interval between flushing pods from unschedulable queue to active queue or backoff queue. ([#108017](https://github.com/kubernetes/kubernetes/pull/108017), [@denkensk](https://github.com/denkensk))
- Add one metrics(`kubelet_volume_stats_health_abnormal`) of volume health state to kubelet ([#105585](https://github.com/kubernetes/kubernetes/pull/105585), [@fengzixu](https://github.com/fengzixu))
- Add the metric `container_oom_events_total` to kubelet's cAdvisor metric endpoint. ([#108004](https://github.com/kubernetes/kubernetes/pull/108004), [@jonkerj](https://github.com/jonkerj))
- Added `SetTransform` to `SharedInformer` to allow users to transform objects before they are stored. ([#107507](https://github.com/kubernetes/kubernetes/pull/107507), [@alexzielenski](https://github.com/alexzielenski))
- Added a `proxy-url` flag into `kubectl config set-cluster`. ([#105566](https://github.com/kubernetes/kubernetes/pull/105566), [@ardaguclu](https://github.com/ardaguclu))
- Added a metric for measuring end-to-end volume mount timing. ([#107006](https://github.com/kubernetes/kubernetes/pull/107006), [@gnufied](https://github.com/gnufied))
- Added a new Priority and Fairness metric `apiserver_flowcontrol_request_dispatch_no_accommodation_total` to track the number of times a request dispatch attempt results in a no-accommodation status due to lack of available seats. ([#106629](https://github.com/kubernetes/kubernetes/pull/106629), [@tkashem](https://github.com/tkashem))
- Added a path `/header?key=` to `agnhost netexec` allowing one to view what the header value is of the incoming request.

  Ex:

  ```$ curl -H "X-Forwarded-For: something" 172.17.0.2:8080/header?key=X-Forwarded-For
  something``` ([#107796](https://github.com/kubernetes/kubernetes/pull/107796), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Added completion for `kubectl config set-context`. ([#106739](https://github.com/kubernetes/kubernetes/pull/106739), [@kebe7jun](https://github.com/kebe7jun))
- Added field `add_ambient_capabilities` to the Capabilities message in the CRI-API. ([#104620](https://github.com/kubernetes/kubernetes/pull/104620), [@vinayakankugoyal](https://github.com/vinayakankugoyal))
- Added label selector flag to all `kubectl rollout` commands. ([#99758](https://github.com/kubernetes/kubernetes/pull/99758), [@aramperes](https://github.com/aramperes))
- Added more message for no PodSandbox container. ([#107116](https://github.com/kubernetes/kubernetes/pull/107116), [@yxxhero](https://github.com/yxxhero))
- Added prune flag into `diff` command to simulate `apply --prune`. ([#105164](https://github.com/kubernetes/kubernetes/pull/105164), [@ardaguclu](https://github.com/ardaguclu))
- Added support for `btrfs` resizing ([#108561](https://github.com/kubernetes/kubernetes/pull/108561), [@RomanBednar](https://github.com/RomanBednar))
- Added support for kubectl commands (`kubectl exec` and `kubectl port-forward`) via a SOCKS5 proxy. ([#105632](https://github.com/kubernetes/kubernetes/pull/105632), [@xens](https://github.com/xens))
- Adds `OpenAPIV3SchemaInterface` to `DiscoveryClient` and its variants for fetching OpenAPI v3 schema documents. ([#108992](https://github.com/kubernetes/kubernetes/pull/108992), [@alexzielenski](https://github.com/alexzielenski))
- Allow kubectl to manage resources by filename patterns without the shell expanding it first ([#102265](https://github.com/kubernetes/kubernetes/pull/102265), [@danielrodriguez](https://github.com/danielrodriguez))
- An alpha flag `--subresource` is added to get, patch, edit replace kubectl commands to fetch and update status and scale subresources. ([#99556](https://github.com/kubernetes/kubernetes/pull/99556), [@nikhita](https://github.com/nikhita))
- Apiextensions_openapi_v3_regeneration_count metric (alpha) will be emitted for OpenAPI V3. ([#109128](https://github.com/kubernetes/kubernetes/pull/109128), [@Jefftree](https://github.com/Jefftree))
- Apply ProxyTerminatingEndpoints to all traffic policies (external, internal, cluster, local). ([#108691](https://github.com/kubernetes/kubernetes/pull/108691), [@andrewsykim](https://github.com/andrewsykim))
- CEL regex patterns in x-kubernetes-valiation rules are compiled when CRDs are created/updated if the pattern is provided as a string constant in the expression. Any regex compile errors are reported as a CRD create/update validation error. ([#108617](https://github.com/kubernetes/kubernetes/pull/108617), [@jpbetz](https://github.com/jpbetz))
- CRD `x-kubernetes-validations` rules now support the CEL functions: `isSorted`, `sum`, `min`, `max`, `indexOf`, `lastIndexOf`, `find` and `findAll`. ([#108312](https://github.com/kubernetes/kubernetes/pull/108312), [@jpbetz](https://github.com/jpbetz))
- Changes the kubectl `--validate` flag from a bool to a string that accepts the values {true, strict, warn, false, ignore}
  - true/strict - perform validation and error the request on any invalid fields in the ojbect. It will attempt to perform server-side validation if it is enabled on the apiserver, otherwise it will fall back to client-side validation.
  - warn - perform server-side validation and warn on any invalid fields (but ultimately let the request succeed by dropping any invalid fields from the object). If validation is not available on the server, perform no validation.
  - false/ignore - perform no validation, silently dropping invalid fields from the object. ([#108350](https://github.com/kubernetes/kubernetes/pull/108350), [@kevindelgado](https://github.com/kevindelgado))
- Client-go metrics: change bucket distribution for `rest_client_request_duration_seconds` and `rest_client_rate_limiter_duration_seconds` from [0.001, 0.002, 0.004, 0.008, 0.016, 0.032, 0.064, 0.128, 0.256, 0.512] to [0.005, 0.025, 0.1, 0.25, 0.5, 1.0, 2.0, 4.0, 8.0, 15.0, 30.0, 60.0}] ([#106911](https://github.com/kubernetes/kubernetes/pull/106911), [@aojea](https://github.com/aojea))
- Client-go: add new histogram metric to record the size of the requests and responses. ([#108296](https://github.com/kubernetes/kubernetes/pull/108296), [@aojea](https://github.com/aojea))
- CycleState is now optimized for "write once and read many times". ([#108724](https://github.com/kubernetes/kubernetes/pull/108724), [@sanposhiho](https://github.com/sanposhiho))
- Enabled beta feature HonorPVReclaimPolicy by default. ([#109035](https://github.com/kubernetes/kubernetes/pull/109035), [@deepakkinni](https://github.com/deepakkinni))
- Env var for additional cli flags used in the csi-proxy binary when a Windows nodepool is created with `kube-up.sh` ([#107806](https://github.com/kubernetes/kubernetes/pull/107806), [@mauriciopoppe](https://github.com/mauriciopoppe))
- Feature of `PreferNominatedNode` is graduated to GA. ([#106619](https://github.com/kubernetes/kubernetes/pull/106619), [@chendave](https://github.com/chendave))
- In text format, log messages that previously used quoting to prevent multi-line output (for example, text="some \"quotation\", a\nline break") will now be printed with more readable multi-line output without the escape sequences. ([#107103](https://github.com/kubernetes/kubernetes/pull/107103), [@pohly](https://github.com/pohly))
- Increase default value of discovery cache TTL for kubectl to 6 hours. ([#107141](https://github.com/kubernetes/kubernetes/pull/107141), [@mk46](https://github.com/mk46))
- Introduce policy to allow the HPA to consume the `external.metrics.k8s.io` API group. ([#104244](https://github.com/kubernetes/kubernetes/pull/104244), [@dgrisonnet](https://github.com/dgrisonnet))
- Kube-apiserver: Subresources such as `status` and `scale` now support tabular output content types. ([#103516](https://github.com/kubernetes/kubernetes/pull/103516), [@ykakarap](https://github.com/ykakarap))
- Kube-apiserver: when merging lists, Server Side Apply now prefers the order of the submitted request instead of the existing persisted object. ([#107565](https://github.com/kubernetes/kubernetes/pull/107565), [@jiahuif](https://github.com/jiahuif))
- Kubeadm: added support for dry running `kubeadm reset`. The new flag `kubeadm reset --dry-run` is similar to the existing flag for `kubeadm init/join/upgrade` and allows you to see what changes would be applied. ([#107512](https://github.com/kubernetes/kubernetes/pull/107512), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: added the flag `--experimental-initial-corrupt-check` to etcd static Pod manifests to ensure etcd member data consistency ([#109074](https://github.com/kubernetes/kubernetes/pull/109074), [@neolit123](https://github.com/neolit123))
- Kubeadm: better surface errors during `kubeadm upgrade` when waiting for the kubelet to restart static pods on control plane nodes ([#108315](https://github.com/kubernetes/kubernetes/pull/108315), [@Monokaix](https://github.com/Monokaix))
- Kubeadm: improve the strict parsing of user YAML/JSON configuration files. Next to printing warnings for unknown and duplicate fields (current state), also print warnings for fields with incorrect case sensitivity - e.g. `controlPlaneEndpoint` (valid), `ControlPlaneEndpoint` (invalid). Instead of only printing warnings during `init` and `join` also print warnings when downloading the ClusterConfiguration, KubeletConfiguration or KubeProxyConfiguration objects from the cluster. This can be useful if the user has patched these objects in their respective ConfigMaps with mistakes. ([#107725](https://github.com/kubernetes/kubernetes/pull/107725), [@neolit123](https://github.com/neolit123))
- Kubectl now supports shell completion for the <type>/<name> format for specifying resources.
  kubectl now provides shell completion for container names following the `--container/-c` flag of the `exec` command.
  kubectl's shell completion now suggests resource types for commands that only apply to pods. ([#108493](https://github.com/kubernetes/kubernetes/pull/108493), [@marckhouzam](https://github.com/marckhouzam))
- Kubelet: add `kubelet_volume_metric_collection_duration_seconds` metrics for volume disk usage calculation duration ([#107201](https://github.com/kubernetes/kubernetes/pull/107201), [@pacoxu](https://github.com/pacoxu))
- Kubelet: the following dockershim related flags are also removed along with dockershim `--experimental-dockershim-root-directory`, `--docker-endpoint`, `--image-pull-progress-deadline`, `--network-plugin`, `--cni-conf-dir`, `--cni-bin-dir`, `--cni-cache-dir`, `--network-plugin-mtu`. ([#106907](https://github.com/kubernetes/kubernetes/pull/106907), [@cyclinder](https://github.com/cyclinder))
- Kubernetes 1.24 bumped version of golang it is compiled with to go1.18, which introduced significant changes to its garbage collection algorithm. As a result, we observed an increase in memory usage for kube-apiserver in larger an heavily loaded clusters up to ~25% (with the benefit of API call latencies drop by up to 10x on 99th percentiles). If the memory increase is not acceptable for you you can mitigate by setting GOGC env variable (for our tests using GOGC=63 brings memory usage back to original value, although the exact value may depend on usage patterns on your cluster). ([#108870](https://github.com/kubernetes/kubernetes/pull/108870), [@dims](https://github.com/dims))
- Kubernetes 1.24 is built with go1.18, which will no longer validate certificates signed with a SHA-1 hash algorithm by default. See https://golang.org/doc/go1.18#sha1 for more details. If you are using certificates like this in admission or conversion ([#109024](https://github.com/kubernetes/kubernetes/pull/109024), [@stlaz](https://github.com/stlaz))
- Kubernetes in now built with go1.18rc1 ([#107105](https://github.com/kubernetes/kubernetes/pull/107105), [@justaugustus](https://github.com/justaugustus))
- Kubernetes is now built with Golang 1.17.4 ([#106833](https://github.com/kubernetes/kubernetes/pull/106833), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Golang 1.17.5. ([#106956](https://github.com/kubernetes/kubernetes/pull/106956), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Golang 1.17.6. ([#107612](https://github.com/kubernetes/kubernetes/pull/107612), [@palnabarun](https://github.com/palnabarun))
- Kubernetes is now built with Golang 1.17.7 ([#108091](https://github.com/kubernetes/kubernetes/pull/108091), [@xmudrii](https://github.com/xmudrii))
- Kubernetes is now built with Golang 1.18.1 ([#109461](https://github.com/kubernetes/kubernetes/pull/109461), [@cpanato](https://github.com/cpanato))
- Leader Migration is now GA. All new configuration files onwards should use version v1. ([#109072](https://github.com/kubernetes/kubernetes/pull/109072), [@jiahuif](https://github.com/jiahuif))
- Mark AzureDisk CSI migration as GA ([#107681](https://github.com/kubernetes/kubernetes/pull/107681), [@andyzhangx](https://github.com/andyzhangx))
- Move volume expansion feature to GA ([#108929](https://github.com/kubernetes/kubernetes/pull/108929), [@gnufied](https://github.com/gnufied))
- Moving MixedProtocolLBService from alpha to beta ([#109213](https://github.com/kubernetes/kubernetes/pull/109213), [@bridgetkromhout](https://github.com/bridgetkromhout))
- New "field_validation_request_duration_seconds" metric, measures how long requests take, indicating the value of the fieldValidation query parameter and whether or not server-side field validation is enabled on the apiserver ([#109120](https://github.com/kubernetes/kubernetes/pull/109120), [@kevindelgado](https://github.com/kevindelgado))
- New feature gate, ServiceIPStaticSubrange, to enable the new strategy in the Service IP allocators, so the IP range is subdivided and dynamic allocated ClusterIP addresses for Services are allocated preferently from the upper range. ([#106792](https://github.com/kubernetes/kubernetes/pull/106792), [@aojea](https://github.com/aojea))
- No ([#108432](https://github.com/kubernetes/kubernetes/pull/108432), [@iXinqi](https://github.com/iXinqi)) [SIG Testing and Windows]
- OpenAPI definitions served by kube-apiserver now include enum types by default. ([#108898](https://github.com/kubernetes/kubernetes/pull/108898), [@jiahuif](https://github.com/jiahuif))
- OpenStack Cinder CSI migration is now GA and switched on by default, Cinder CSI driver must be installed on clusters on OpenStack for Cinder volumes to work (has been since v1.21). ([#107462](https://github.com/kubernetes/kubernetes/pull/107462), [@dims](https://github.com/dims))
- PreFilter extension in the scheduler framework now returns not only status but also PreFilterResult ([#108648](https://github.com/kubernetes/kubernetes/pull/108648), [@ahg-g](https://github.com/ahg-g))
- Promoted graceful shutdown based on pod priority to beta ([#107986](https://github.com/kubernetes/kubernetes/pull/107986), [@wzshiming](https://github.com/wzshiming))
- Removed feature gate `SetHostnameAsFQDN`. ([#108038](https://github.com/kubernetes/kubernetes/pull/108038), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Removed kube-scheduler insecure flags. You can use `--bind-address` and `--secure-port` instead. ([#106865](https://github.com/kubernetes/kubernetes/pull/106865), [@jonyhy96](https://github.com/jonyhy96))
- Removed the `ImmutableEphemeralVolumes` feature gate. ([#107152](https://github.com/kubernetes/kubernetes/pull/107152), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Set `PodMaxUnschedulableQDuration` as 5 min. ([#108761](https://github.com/kubernetes/kubernetes/pull/108761), [@denkensk](https://github.com/denkensk))
- Support in-tree PV deletion protection finalizer. ([#108400](https://github.com/kubernetes/kubernetes/pull/108400), [@deepakkinni](https://github.com/deepakkinni))
- The `.spec.loadBalancerClass` field for Services is now generally available. ([#107979](https://github.com/kubernetes/kubernetes/pull/107979), [@XudongLiuHarold](https://github.com/XudongLiuHarold))
- The `NamespaceDefaultLabelName` feature gate, GA since v1.22, is now removed. ([#106838](https://github.com/kubernetes/kubernetes/pull/106838), [@mengjiao-liu](https://github.com/mengjiao-liu))
- The `kubectl logs` will now warn and default to the first container in a pod. This new behavior brings it in line with `kubectl exec`. ([#105964](https://github.com/kubernetes/kubernetes/pull/105964), [@kidlj](https://github.com/kidlj))
- The `v1` version of `LeaderMigrationConfiguration` supports only `leases` API for leader election. To use formerly supported mechanisms, please continue using `v1beta1`. ([#108016](https://github.com/kubernetes/kubernetes/pull/108016), [@jiahuif](https://github.com/jiahuif))
- The kubelet now creates an iptables chain named `KUBE-IPTABLES-HINT` in
  the `mangle` table. Containerized components that need to modify iptables
  rules in the host network namespace can use the existence of this chain
  to more-reliably determine whether the system is using iptables-legacy or
  iptables-nft. ([#109059](https://github.com/kubernetes/kubernetes/pull/109059), [@danwinship](https://github.com/danwinship))
- The output of `kubectl describe ingress` now includes an IngressClass name if available. ([#107921](https://github.com/kubernetes/kubernetes/pull/107921), [@mpuckett159](https://github.com/mpuckett159))
- The scheduler prints info logs when the extender returned an error. (`--v>5`) ([#107974](https://github.com/kubernetes/kubernetes/pull/107974), [@sanposhiho](https://github.com/sanposhiho))
- The script `cluster/gce/gci/configure.sh` now supports downloading `crictl` on ARM64 nodes ([#108034](https://github.com/kubernetes/kubernetes/pull/108034), [@tstapler](https://github.com/tstapler))
- Turn on `CSIMigrationAzureFile` by default on 1.24 ([#105070](https://github.com/kubernetes/kubernetes/pull/105070), [@andyzhangx](https://github.com/andyzhangx))
- Update the k8s.io/system-validators library to v1.7.0 ([#108988](https://github.com/kubernetes/kubernetes/pull/108988), [@neolit123](https://github.com/neolit123))
- Updated golang.org/x/net to v0.0.0-20211209124913-491a49abca63. ([#106949](https://github.com/kubernetes/kubernetes/pull/106949), [@cpanato](https://github.com/cpanato))
- Updates `kubectl kustomize` and `kubectl apply -k` to Kustomize v4.5.4 ([#108994](https://github.com/kubernetes/kubernetes/pull/108994), [@KnVerey](https://github.com/KnVerey))
- When invoked with `-list-images`, the `e2e.test` binary now also lists the images that might be needed for storage tests. ([#108458](https://github.com/kubernetes/kubernetes/pull/108458), [@pohly](https://github.com/pohly))
- `kubectl config delete-user` now supports completion ([#107142](https://github.com/kubernetes/kubernetes/pull/107142), [@dimbleby](https://github.com/dimbleby))
- `kubectl create token` can now be used to request a service account token, and permission to request service account tokens is added to the `edit` and `admin` RBAC roles ([#107880](https://github.com/kubernetes/kubernetes/pull/107880), [@liggitt](https://github.com/liggitt))
- `kubectl version` now includes information on the embedded version of Kustomize ([#108817](https://github.com/kubernetes/kubernetes/pull/108817), [@KnVerey](https://github.com/KnVerey))

### Bug or Regression

- A node IP provided to kublet via `--node-ip` will now be preferred for when determining the node's primary IP and using the external cloud provider (CCM). ([#107750](https://github.com/kubernetes/kubernetes/pull/107750), [@stephenfin](https://github.com/stephenfin))
- A static pod that is rapidly updated was failing to start until the Kubelet was restarted. ([#107900](https://github.com/kubernetes/kubernetes/pull/107900), [@smarterclayton](https://github.com/smarterclayton))
- Add one metrics(`kubelet_volume_stats_health_abnormal`) of volume health state to kubelet ([#108758](https://github.com/kubernetes/kubernetes/pull/108758), [@fengzixu](https://github.com/fengzixu))
- Added a new label `type` to `apiserver_flowcontrol_request_execution_seconds` metric - it has the following values: - 'regular': indicates that it is a non long running request - 'watch': indicates that it is a watch request. ([#105517](https://github.com/kubernetes/kubernetes/pull/105517), [@tkashem](https://github.com/tkashem))
- Added a test to guarantee that conformance clusters require at least 2 untainted nodes. ([#106313](https://github.com/kubernetes/kubernetes/pull/106313), [@aojea](https://github.com/aojea))
- Adds PV deletion protection finalizer only when PV reclaimPolicy is Delete for dynamically provisioned volumes. ([#109205](https://github.com/kubernetes/kubernetes/pull/109205), [@deepakkinni](https://github.com/deepakkinni))
- Allowed attached volumes to be mounted quicker by skipping exponential backoff when checking for reported-in-use volumes. ([#106853](https://github.com/kubernetes/kubernetes/pull/106853), [@gnufied](https://github.com/gnufied))
- Alowed useful inclusion of `-args $prog_args` in KUBE_TEST_ARGS, when doing `make test-integration`. ([#107516](https://github.com/kubernetes/kubernetes/pull/107516), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- An inefficient lock in EndpointSlice controller metrics cache has been reworked. Network programming latency may be significantly reduced in certain scenarios, especially in clusters with a large number of Services. ([#107091](https://github.com/kubernetes/kubernetes/pull/107091), [@robscott](https://github.com/robscott))
- Apiserver will now reject connection attempts to `0.0.0.0/::` when handling a proxy subresource request. ([#107402](https://github.com/kubernetes/kubernetes/pull/107402), [@anguslees](https://github.com/anguslees))
- Bug: client-go clientset was not defaulting to the user agent, and was using the default golang agent for all the requests. ([#108772](https://github.com/kubernetes/kubernetes/pull/108772), [@aojea](https://github.com/aojea))
- Bump `sigs.k8s.io/apiserver-network-proxy/konnectivity-client@v0.0.30` to fix a goroutine leak in kube-apiserver when using egress selctor with the gRPC mode. ([#108437](https://github.com/kubernetes/kubernetes/pull/108437), [@andrewsykim](https://github.com/andrewsykim))
- CEL validation failure returns object type instead of object. ([#107090](https://github.com/kubernetes/kubernetes/pull/107090), [@cici37](https://github.com/cici37))
- CRI-API: IPs returned by `PodSandboxNetworkStatus`` are ignored by the kubelet for host-network pods. ([#106715](https://github.com/kubernetes/kubernetes/pull/106715), [@aojea](https://github.com/aojea))
- Call `NodeExpand` on all nodes in case of RWX volumes ([#108693](https://github.com/kubernetes/kubernetes/pull/108693), [@gnufied](https://github.com/gnufied))
- Changed node staging path for CSI driver to use a PV agnostic path. Nodes must be drained before updating the kubelet with this change. ([#107065](https://github.com/kubernetes/kubernetes/pull/107065), [@saikat-royc](https://github.com/saikat-royc))
- Client-go: fixed the paged list calls with `ResourceVersionMatch` set would fail once paging is kicked in. ([#107311](https://github.com/kubernetes/kubernetes/pull/107311), [@fasaxc](https://github.com/fasaxc))
- Correct event registration for multiple scheduler plugins; this fixes a potential significant delay in re-queueing unschedulable pods. ([#109442](https://github.com/kubernetes/kubernetes/pull/109442), [@ahg-g](https://github.com/ahg-g))
- Etcd: Update to v3.5.3 ([#109471](https://github.com/kubernetes/kubernetes/pull/109471), [@justaugustus](https://github.com/justaugustus))
- Existing InTree AzureFile PVs which don't have a secret namespace defined will now work properly after enabling CSI migration - the namespace will be obtained from ClaimRef. ([#108000](https://github.com/kubernetes/kubernetes/pull/108000), [@RomanBednar](https://github.com/RomanBednar))
- Failure to start a container cannot accidentally result in the pod being considered "Succeeded" in the presence of deletion. ([#107845](https://github.com/kubernetes/kubernetes/pull/107845), [@smarterclayton](https://github.com/smarterclayton))
- Fix a race in the timeout handler that could lead to kube-apiserver crashes ([#108455](https://github.com/kubernetes/kubernetes/pull/108455), [@Argh4k](https://github.com/Argh4k))
- Fix container creation errors for pods with cpu requests bigger than 256 cpus ([#106570](https://github.com/kubernetes/kubernetes/pull/106570), [@odinuge](https://github.com/odinuge))
- Fix issue where the job controller might not remove the job tracking finalizer from pods when deleting a job, or when the pod is orphan ([#108752](https://github.com/kubernetes/kubernetes/pull/108752), [@alculquicondor](https://github.com/alculquicondor))
- Fix libct/cg/fs2: fixed GetStats for unsupported hugetlb error on Raspbian Bullseye ([#106912](https://github.com/kubernetes/kubernetes/pull/106912), [@Letme](https://github.com/Letme))
- Fix the bug that the outdated services may be sent to the cloud provider ([#107631](https://github.com/kubernetes/kubernetes/pull/107631), [@lzhecheng](https://github.com/lzhecheng))
- Fix the overestimated cost of delegated API requests in kube-apiserver API priority & fairness ([#109188](https://github.com/kubernetes/kubernetes/pull/109188), [@wojtek-t](https://github.com/wojtek-t))
- Fix to allow `fsGroup` to be applied for CSI Inline Volumes ([#108662](https://github.com/kubernetes/kubernetes/pull/108662), [@dobsonj](https://github.com/dobsonj))
- Fixed CSI migration of Azure Disk in-tree StorageClasses with topology requirements in Azure regions that do not have availability zones. ([#109154](https://github.com/kubernetes/kubernetes/pull/109154), [@jsafrane](https://github.com/jsafrane))
- Fixed `--retries` functionality for negative values in `kubectl cp` ([#108748](https://github.com/kubernetes/kubernetes/pull/108748), [@atiratree](https://github.com/atiratree))
- Fixed `azureDisk` parameter lowercase translation issue. ([#107429](https://github.com/kubernetes/kubernetes/pull/107429), [@andyzhangx](https://github.com/andyzhangx))
- Fixed `azureFile` `volumeID` collision issue in CSI migration. ([#107575](https://github.com/kubernetes/kubernetes/pull/107575), [@andyzhangx](https://github.com/andyzhangx))
- Fixed a bug in attachdetach controller that didn't properly handle kube-apiserver errors leading to stuck attachments/detachments. ([#108167](https://github.com/kubernetes/kubernetes/pull/108167), [@jfremy](https://github.com/jfremy))
- Fixed a bug that a pod's `.status.nominatedNodeName` is not cleared properly, and thus over-occupied system resources. ([#106816](https://github.com/kubernetes/kubernetes/pull/106816), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed a bug that caused credentials in an exec plugin to override the static certificates set in a kubeconfig. ([#107410](https://github.com/kubernetes/kubernetes/pull/107410), [@margocrawf](https://github.com/margocrawf))
- Fixed a bug that could cause panic when a `/healthz` request times out. ([#107034](https://github.com/kubernetes/kubernetes/pull/107034), [@benluddy](https://github.com/benluddy))
- Fixed a bug that out-of-tree plugin is misplaced when using scheduler v1beta3 config ([#108613](https://github.com/kubernetes/kubernetes/pull/108613), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed a bug where a partial `EndpointSlice` update could cause node name information to be dropped from endpoints that were not updated. ([#108198](https://github.com/kubernetes/kubernetes/pull/108198), [@liggitt](https://github.com/liggitt))
- Fixed a bug where unwanted fields were being returned from a `create --dry-run`: uid and, if generateName was used, name. ([#107088](https://github.com/kubernetes/kubernetes/pull/107088), [@joejulian](https://github.com/joejulian))
- Fixed a bug where vSphere client connections where not being closed during testing. Leaked vSphere client sessions were causing resource exhaustion during automated testing. ([#107337](https://github.com/kubernetes/kubernetes/pull/107337), [@derek-pryor](https://github.com/derek-pryor))
- Fixed a panic when using invalid output format in `kubectl create secret` command. ([#107221](https://github.com/kubernetes/kubernetes/pull/107221), [@rikatz](https://github.com/rikatz))
- Fixed a rare race condition handling requests that timeout. ([#107452](https://github.com/kubernetes/kubernetes/pull/107452), [@liggitt](https://github.com/liggitt))
- Fixed a regression in 1.23 that incorrectly pruned data from array items of a custom resource that set `x-kubernetes-preserve-unknown-fields: true`. ([#107688](https://github.com/kubernetes/kubernetes/pull/107688), [@liggitt](https://github.com/liggitt))
- Fixed a regression in 1.23 where update requests to previously persisted `Service` objects that have not been modified since 1.19 can be rejected with an incorrect `spec.clusterIPs: Required value` error. ([#107847](https://github.com/kubernetes/kubernetes/pull/107847), [@thockin](https://github.com/thockin))
- Fixed a regression that could incorrectly reject pods with `OutOfCpu` errors if they were rapidly scheduled after other pods were reported as complete in the API. The Kubelet now waits to report the phase of a pod as terminal in the API until all running containers are guaranteed to have stopped and no new containers can be started.  Short-lived pods may take slightly longer (~1s) to report Succeeded or Failed after this change. ([#108366](https://github.com/kubernetes/kubernetes/pull/108366), [@smarterclayton](https://github.com/smarterclayton))
- Fixed bug in `TopologyManager` for ensuring aligned allocations on machines with more than 2 NUMA nodes ([#108052](https://github.com/kubernetes/kubernetes/pull/108052), [@klueska](https://github.com/klueska))
- Fixed bug in error messaging for basic-auth and ssh secret validations. ([#106179](https://github.com/kubernetes/kubernetes/pull/106179), [@vivek-koppuru](https://github.com/vivek-koppuru))
- Fixed detaching CSI volumes from nodes when a CSI driver name has prefix "csi-". ([#107025](https://github.com/kubernetes/kubernetes/pull/107025), [@jsafrane](https://github.com/jsafrane))
- Fixed duplicate port opening in kube-proxy when `--nodeport-addresses` is empty. ([#107413](https://github.com/kubernetes/kubernetes/pull/107413), [@tnqn](https://github.com/tnqn))
- Fixed handling of objects with invalid selectors. ([#107559](https://github.com/kubernetes/kubernetes/pull/107559), [@liggitt](https://github.com/liggitt))
- Fixed indexer bug that resulted in incorrect index updates if number of index values for a given object was changing during update ([#109137](https://github.com/kubernetes/kubernetes/pull/109137), [@wojtek-t](https://github.com/wojtek-t))
- Fixed kubectl bug where bash completions don't work if `--context` flag is specified with a value that contains a colon. ([#107439](https://github.com/kubernetes/kubernetes/pull/107439), [@brianpursley](https://github.com/brianpursley))
- Fixed performance regression in JSON logging caused by syncing stdout every time error was logged. ([#107035](https://github.com/kubernetes/kubernetes/pull/107035), [@serathius](https://github.com/serathius))
- Fixed regression in CPUManager that it will release exclusive CPUs in app containers inherited from init containers when the init containers were removed. ([#104837](https://github.com/kubernetes/kubernetes/pull/104837), [@eggiter](https://github.com/eggiter))
- Fixed static pod add and removes restarts in certain cases. ([#107695](https://github.com/kubernetes/kubernetes/pull/107695), [@rphillips](https://github.com/rphillips))
- Fixed: deleted a non-existent Azure disk issue. ([#107406](https://github.com/kubernetes/kubernetes/pull/107406), [@andyzhangx](https://github.com/andyzhangx))
- Fixed: do not return early in the node informer when there is no change of the topology label. ([#108149](https://github.com/kubernetes/kubernetes/pull/108149), [@nilo19](https://github.com/nilo19))
- Fixed: removed outdated ipv4 route when the corresponding node is deleted. ([#106164](https://github.com/kubernetes/kubernetes/pull/106164), [@nilo19](https://github.com/nilo19))
- Fixes bug in CronJob Controller V2 where it would lose track of jobs upon job template labels change. ([#107997](https://github.com/kubernetes/kubernetes/pull/107997), [@d-honeybadger](https://github.com/d-honeybadger))
- If drainer has nil for Ctx or Client it will error with `RunCordonOrUncordon`. ([#105297](https://github.com/kubernetes/kubernetes/pull/105297), [@jackfrancis](https://github.com/jackfrancis))
- Improved handling of unmount failures when device may be in-use by another container/process. ([#107789](https://github.com/kubernetes/kubernetes/pull/107789), [@gnufied](https://github.com/gnufied))
- Improved logging when volume times out waiting for attach/detach. ([#108628](https://github.com/kubernetes/kubernetes/pull/108628), [@RomanBednar](https://github.com/RomanBednar))
- Improved the rounding of `PodTopologySpread` scores to offer better scoring when spreading a low number of pods. ([#107384](https://github.com/kubernetes/kubernetes/pull/107384), [@sanposhiho](https://github.com/sanposhiho))
- Increase Azure ACR credential provider timeout ([#108209](https://github.com/kubernetes/kubernetes/pull/108209), [@andyzhangx](https://github.com/andyzhangx))
- Kube-apiserver: Server Side Apply merge order is reverted to match v1.22 behavior until http://issue.k8s.io/104641 is resolved. ([#106660](https://github.com/kubernetes/kubernetes/pull/106660), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: ensures the namespace of objects sent to admission webhooks matches the request namespace. Previously, objects without a namespace set would have the request namespace populated after mutating admission, and objects with a namespace that did not match the request namespace would be rejected after admission. ([#94637](https://github.com/kubernetes/kubernetes/pull/94637), [@liggitt](https://github.com/liggitt))
- Kube-apiserver: removed `apf_fd` from server logs which could contain data identifying the requesting user ([#108631](https://github.com/kubernetes/kubernetes/pull/108631), [@jupblb](https://github.com/jupblb))
- Kube-proxy in iptables mode now only logs the full iptables input at `-v=9` rather than `-v=5`. ([#108224](https://github.com/kubernetes/kubernetes/pull/108224), [@danwinship](https://github.com/danwinship))
- Kube-proxy will no longer hold service node ports open on the node. Users are still advised not to run any listener on node ports range used by kube-proxy. ([#108496](https://github.com/kubernetes/kubernetes/pull/108496), [@khenidak](https://github.com/khenidak))
- Kubeadm: allow the `certs check-expiration` command to not require the existence of the cluster CA key (ca.key file) when checking the expiration of managed certificates in kubeconfig files. ([#106854](https://github.com/kubernetes/kubernetes/pull/106854), [@neolit123](https://github.com/neolit123))
- Kubeadm: during execution of the `certs check-expiration` command, treat the etcd CA as external if there is a missing etcd CA key file (etcd/ca.key) and perform the proper validation on certificates signed by the etcd CA. Additionally, make sure that the CA for all entries in the output table is included - for both certificates on disk and in kubeconfig files. ([#106891](https://github.com/kubernetes/kubernetes/pull/106891), [@neolit123](https://github.com/neolit123))
- Kubeadm: fixed a bug related to a warning printed if the `KubeletConfiguration` `resolvConf` field value does not match `/run/systemd/resolve/resolv.conf` ([#107785](https://github.com/kubernetes/kubernetes/pull/107785), [@chendave](https://github.com/chendave))
- Kubeadm: fixed a bug when using `kubeadm init --dry-run` with certificate authority files (`ca.key` / `ca.crt`) present in `/etc/kubernetes/pki`) ([#108410](https://github.com/kubernetes/kubernetes/pull/108410), [@Haleygo](https://github.com/Haleygo))
- Kubeadm: fixed a bug where Windows nodes fail to join an IPv6 cluster due to preflight errors ([#108769](https://github.com/kubernetes/kubernetes/pull/108769), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: fixed the bug that `kubeadm certs generate-csr` command does not remove duplicated SANs ([#107982](https://github.com/kubernetes/kubernetes/pull/107982), [@SataQiu](https://github.com/SataQiu))
- Kubelet now checks "NoExecute" taint/toleration before accepting pods, except for static pods. ([#101218](https://github.com/kubernetes/kubernetes/pull/101218), [@gjkim42](https://github.com/gjkim42))
- Metrics Server image bumped to v0.5.2 ([#106492](https://github.com/kubernetes/kubernetes/pull/106492), [@serathius](https://github.com/serathius))
- Modified command line errors (for example, `kubectl list` -> `unknown command`) that were printed as log message with escaped line breaks instead of a multi-line plain text, making the error hard to read. ([#107044](https://github.com/kubernetes/kubernetes/pull/107044), [@pohly](https://github.com/pohly))
- Modified log messages that were logged with `"v":0` in JSON output although they were debug messages with a higher verbosity. ([#106978](https://github.com/kubernetes/kubernetes/pull/106978), [@pohly](https://github.com/pohly))
- No ([#107769](https://github.com/kubernetes/kubernetes/pull/107769), [@liurupeng](https://github.com/liurupeng)) [SIG Cloud Provider and Windows]
- NodeRestriction admission: nodes are now allowed to update PersistentVolumeClaim status fields `resizeStatus` and `allocatedResources` when the `RecoverVolumeExpansionFailure` feature is enabled. ([#107686](https://github.com/kubernetes/kubernetes/pull/107686), [@gnufied](https://github.com/gnufied))
- Only extend token lifetimes when `--service-account-extend-token-expiration` is true and the requested token audiences are empty or exactly match all values for `--api-audiences`. ([#105954](https://github.com/kubernetes/kubernetes/pull/105954), [@jyotimahapatra](https://github.com/jyotimahapatra))
- Prevent kube-scheduler from nominating a Pod that was already scheduled to a node ([#109245](https://github.com/kubernetes/kubernetes/pull/109245), [@alculquicondor](https://github.com/alculquicondor))
- Prevent unnecessary `Endpoints` and `EndpointSlice` updates caused by `Pod ResourceVersion` change ([#108078](https://github.com/kubernetes/kubernetes/pull/108078), [@tnqn](https://github.com/tnqn))
- Print `<default>` as the value in case kubectl describe ingress shows `default-backend:80` when no default backend is present ([#108506](https://github.com/kubernetes/kubernetes/pull/108506), [@jlsong01](https://github.com/jlsong01))
- Publishing kube-proxy metrics for Windows kernel-mode ([#106581](https://github.com/kubernetes/kubernetes/pull/106581), [@knabben](https://github.com/knabben))
- Re-adds response status and headers on verbose kubectl responses ([#108505](https://github.com/kubernetes/kubernetes/pull/108505), [@rikatz](https://github.com/rikatz))
- Record requests rejected with 429 in the apiserver_request_total metric ([#108927](https://github.com/kubernetes/kubernetes/pull/108927), [@wojtek-t](https://github.com/wojtek-t))
- Removed validation if AppArmor profiles are loaded on the local node. This should be handled by the container runtime. ([#97966](https://github.com/kubernetes/kubernetes/pull/97966), [@saschagrunert](https://github.com/saschagrunert))
- Replace the url label of `rest_client_request_duration_seconds` and `rest_client_rate_limiter_duration_seconds` metrics with a host label to prevent cardinality explosions and keep only the useful information. This is a breaking change required for security reasons. ([#106539](https://github.com/kubernetes/kubernetes/pull/106539), [@dgrisonnet](https://github.com/dgrisonnet))
- Restored `NumPDBViolations` info of nodes, when `HTTPExtender ProcessPreemption`. This info will be used in subsequent filtering steps - `pickOneNodeForPreemption` ([#105853](https://github.com/kubernetes/kubernetes/pull/105853), [@caden2016](https://github.com/caden2016))
- Reverted graceful node shutdown to match 1.21 behavior of setting pods that have not yet successfully completed to "Failed" phase if the GracefulNodeShutdown feature is enabled in kubelet. The GracefulNodeShutdown feature is beta and must be explicitly configured via kubelet config to be enabled in 1.21+. This changes 1.22 and 1.23 behavior on node shutdown to match 1.21. If you do not want pods to be marked terminated on node shutdown in 1.22 and 1.23, disable the GracefulNodeShutdown feature. ([#106901](https://github.com/kubernetes/kubernetes/pull/106901), [@bobbypage](https://github.com/bobbypage))
- Reverts the CRI API version surfaced by dockershim to v1alpha2 ([#106803](https://github.com/kubernetes/kubernetes/pull/106803), [@saschagrunert](https://github.com/saschagrunert))
- Services with "internalTrafficPolicy: Local" now behave more like
  "externalTrafficPolicy: Local". Also, "internalTrafficPolicy: Local,
  externalTrafficPolicy: Cluster" is now implemented correctly. ([#106497](https://github.com/kubernetes/kubernetes/pull/106497), [@danwinship](https://github.com/danwinship))
- Sets JobTrackingWithFinalizers, a beta feature, as disabled by default, due to unresolved bug https://github.com/kubernetes/kubernetes/issues/109485 ([#109487](https://github.com/kubernetes/kubernetes/pull/109487), [@alculquicondor](https://github.com/alculquicondor))
- Skip re-allocate logic if pod is already removed to avoid panic ([#108831](https://github.com/kubernetes/kubernetes/pull/108831), [@waynepeking348](https://github.com/waynepeking348))
- The Service field `spec.internalTrafficPolicy` is no longer defaulted for Services when the type is `ExternalName`. The field is also dropped on read when the Service type is `ExternalName`. ([#104846](https://github.com/kubernetes/kubernetes/pull/104846), [@andrewsykim](https://github.com/andrewsykim))
- The `ServerSideFieldValidation` feature has been reverted to alpha for 1.24. ([#109271](https://github.com/kubernetes/kubernetes/pull/109271), [@liggitt](https://github.com/liggitt))
- The `TopologyAwareHints` feature gate is now enabled by default. This will allow users to opt-in to Topology Aware Hints by setting the `service.kubernetes.io/topology-aware-hints` on a Service. This will not affect any Services without that annotation set. ([#108747](https://github.com/kubernetes/kubernetes/pull/108747), [@robscott](https://github.com/robscott))
- The deprecated flag `--really-crash-for-testing` was removed. ([#101719](https://github.com/kubernetes/kubernetes/pull/101719), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- The kubelet no longer forcefully closes active connections on heartbeat failures, using the HTTP2 health check mechanism to detect broken connections. Users can force the previous behavior of the kubelet by setting the environment variable DISABLE_HTTP2. ([#108107](https://github.com/kubernetes/kubernetes/pull/108107), [@aojea](https://github.com/aojea))
- This code change fixes the bug that UDP services would trigger unnecessary LoadBalancer updates. The root cause is that a field not working for non-TCP protocols is considered.
  ref: https://github.com/kubernetes-sigs/cloud-provider-azure/pull/1090 ([#107981](https://github.com/kubernetes/kubernetes/pull/107981), [@lzhecheng](https://github.com/lzhecheng))
- Topology translation of in-tree vSphere volume to vSphere CSI. ([#108611](https://github.com/kubernetes/kubernetes/pull/108611), [@divyenpatel](https://github.com/divyenpatel))
- Updating kubelet permissions check for Windows nodes to see if process is elevated instead of checking if process owner is in Administrators group ([#108146](https://github.com/kubernetes/kubernetes/pull/108146), [@marosset](https://github.com/marosset))
- `apiserver`, if configured to reconcile the `kubernetes.default` service endpoints, checks if the configured Service IP range matches the apiserver public address IP family, and fails to start if not. ([#106721](https://github.com/kubernetes/kubernetes/pull/106721), [@aojea](https://github.com/aojea))
- `kubectl version` now fails when given extra arguments. ([#107967](https://github.com/kubernetes/kubernetes/pull/107967), [@jlsong01](https://github.com/jlsong01))

### Other (Cleanup or Flake)

- '`build/dependencies.yaml`: remove the dependency on Docker. With the dockershim removal, core Kubernetes no longer
  has to track the latest validated version of Docker.' ([#107607](https://github.com/kubernetes/kubernetes/pull/107607), [@neolit123](https://github.com/neolit123))
- API server's deprecated `--experimental-encryption-provider-config` flag is now removed. Adapt your machinery to use the `--encryption-provider-config` flag that is available since v1.13. ([#108423](https://github.com/kubernetes/kubernetes/pull/108423), [@ialidzhikov](https://github.com/ialidzhikov))
- API server's deprecated `--target-ram-mb` flag is now removed. ([#108457](https://github.com/kubernetes/kubernetes/pull/108457), [@ialidzhikov](https://github.com/ialidzhikov))
- Added PreemptionPolicy in PriorityClass describe ([#108701](https://github.com/kubernetes/kubernetes/pull/108701), [@denkensk](https://github.com/denkensk))
- Added an e2e test to verify that the cluster is not vulnerable to CVE-2021-29923 when using Services with IPs with leading zeros, note that this test is a necessary but not sufficient condition, all the components in the clusters that consume IPs addresses from the APIs MUST interpret them as decimal or discard them. ([#107552](https://github.com/kubernetes/kubernetes/pull/107552), [@aojea](https://github.com/aojea))
- Added an example for the `kubectl plugin list` command. ([#106600](https://github.com/kubernetes/kubernetes/pull/106600), [@bergerhoffer](https://github.com/bergerhoffer))
- Added details about preemption in the event for scheduling failed. ([#107775](https://github.com/kubernetes/kubernetes/pull/107775), [@denkensk](https://github.com/denkensk))
- Allow KUBE_TEST_REPO_LIST to be a remote url ([#108429](https://github.com/kubernetes/kubernetes/pull/108429), [@dims](https://github.com/dims))
- Client-go: if resetting the body fails before a retry, an error is now surfaced to the user. ([#109050](https://github.com/kubernetes/kubernetes/pull/109050), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Deprecate apiserver_dropped_requests_total metric. The same data can be read from apiserver_request_terminations_total metric. ([#109018](https://github.com/kubernetes/kubernetes/pull/109018), [@wojtek-t](https://github.com/wojtek-t))
- Deprecated types in `k8s.io/apimachinery/util/clock`. Please use `k8s.io/utils/clock` instead. ([#106850](https://github.com/kubernetes/kubernetes/pull/106850), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- E2e tests wait for `kube-root-ca.crt` to be populated in namespaces for use with projected service account tokens, reducing delays starting those test pods and errors in the logs. ([#107763](https://github.com/kubernetes/kubernetes/pull/107763), [@smarterclayton](https://github.com/smarterclayton))
- Endpoints and EndpointSlice controllers no longer populate [resourceVersion of targetRef](https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/object-reference/#ObjectReference) in Endpoints and EndpointSlices ([#108450](https://github.com/kubernetes/kubernetes/pull/108450), [@tnqn](https://github.com/tnqn))
- Fixed default config flags for `NewDefaultKubectlCommand`. ([#107131](https://github.com/kubernetes/kubernetes/pull/107131), [@jonnylangefeld](https://github.com/jonnylangefeld))
- Fixed documentation typo in cloud-provider. ([#106445](https://github.com/kubernetes/kubernetes/pull/106445), [@majst01](https://github.com/majst01))
- Fixed spelling of implemented in pkg/proxy/apis/config/types.go line 206 ([#106453](https://github.com/kubernetes/kubernetes/pull/106453), [@davidleitw](https://github.com/davidleitw))
- Improve error message when applying CRDs before the CRD exists in a cluster ([#107363](https://github.com/kubernetes/kubernetes/pull/107363), [@eddiezane](https://github.com/eddiezane))
- Improved algorithm for selecting `best` non-preferred hint in the TopologyManager ([#108154](https://github.com/kubernetes/kubernetes/pull/108154), [@klueska](https://github.com/klueska))
- Kube-proxy doesn't set the sysctl `net.ipv4.conf.all.route_localnet=1` if no IPv4 loopback address is selected by the `nodePortAddresses` configuration parameter. ([#107684](https://github.com/kubernetes/kubernetes/pull/107684), [@aojea](https://github.com/aojea))
- Kubeadm: all warning messages are printed to stderr instead of stdout. ([#107467](https://github.com/kubernetes/kubernetes/pull/107467), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: handled the removal of dockershim related flags for new kubeadm clusters. If kubelet <1.24 is on the host, kubeadm >=1.24 can continue using the built-in dockershim in the kubelet if the user passes the `{Init|Join}Configuration.nodeRegistration.criSocket` value in the kubeadm configuration to be equal to `unix:///var/run/dockershim.sock` on Unix or `npipe:////./pipe/dockershim` on Windows. If kubelet version >=1.24 is on the host, kubeadm >=1.24 will treat all container runtimes as "remote" using the kubelet flags `--container-runtime=remote --container-runtime-endpoint=scheme://some/path`. The special management for kubelet <1.24 will be removed in kubeadm 1.25. ([#106973](https://github.com/kubernetes/kubernetes/pull/106973), [@neolit123](https://github.com/neolit123))
- Kubeadm: make sure that `kubeadm init/join` always use a URL scheme (unix:// on Linux and npipe:// on Windows) when passing a value to the `--container-runtime-endpoint` kubelet flag. This flag's value is taken from the kubeadm configuration `criSocket` field or the `--cri-socket` CLI flag. Automatically add a missing URL scheme to the user configuration in memory, but warn them that they should also update their configuration on disk manually. During `kubeadm upgrade apply/node` mutate the `/var/lib/kubelet/kubeadm-flags.env` file on disk and the `kubeadm.alpha.kubernetes.io/cri-socket` annotation Node object if needed. These automatic actions are temporary and will be removed in a future release. In the future the kubelet may not support CRI endpoints without an URL scheme. ([#107295](https://github.com/kubernetes/kubernetes/pull/107295), [@neolit123](https://github.com/neolit123))
- Kubeadm: remove the `IPv6DualStack` feature gate. The feature has been GA and locked to enabled since 1.23. ([#106648](https://github.com/kubernetes/kubernetes/pull/106648), [@calvin0327](https://github.com/calvin0327))
- Kubeadm: removed the deprecated `output/v1alpha1` API used for machine readable output by some kubeadm commands. In 1.23 kubeadm started using the newer version `output/v1alpha2` for the same purpose. ([#107468](https://github.com/kubernetes/kubernetes/pull/107468), [@neolit123](https://github.com/neolit123))
- Kubeadm: removed the restriction that the `ca.crt` can only contain one certificate. If there is more than one certificate in the `ca.crt` file, kubeadm will pick the first one by default. ([#107327](https://github.com/kubernetes/kubernetes/pull/107327), [@SataQiu](https://github.com/SataQiu))
- Kubectl stack traces now only print at verbose `-v=99` and not `-v=6` ([#108053](https://github.com/kubernetes/kubernetes/pull/108053), [@eddiezane](https://github.com/eddiezane))
- Kubectl: restored `--dry-run`, `--dry-run=true`, and `--dry-run=false` for compatibility with pre-1.23 invocations. ([#107003](https://github.com/kubernetes/kubernetes/pull/107003), [@julianvmodesto](https://github.com/julianvmodesto))
- Kubelet config validation error messages are updated. ([#105360](https://github.com/kubernetes/kubernetes/pull/105360), [@shuheiktgw](https://github.com/shuheiktgw))
- Kubernetes e2e framework will use the url `invalid.registry.k8s.io/invalid` instead `invalid.com/invalid` for test that use an invalid registry. ([#107455](https://github.com/kubernetes/kubernetes/pull/107455), [@aojea](https://github.com/aojea))
- Marked kubelet `--container-runtime-endpoint` and `--image-service-endpoint` CLI flags as stable. ([#106954](https://github.com/kubernetes/kubernetes/pull/106954), [@saschagrunert](https://github.com/saschagrunert))
- Migrate `volume/csi/csi-client.go` logs to structured logging. ([#99441](https://github.com/kubernetes/kubernetes/pull/99441), [@CKchen0726](https://github.com/CKchen0726))
- Migrate statefulset files to structured logging ([#106109](https://github.com/kubernetes/kubernetes/pull/106109), [@h4ghhh](https://github.com/h4ghhh))
- Refactor kubelet command line for enabling features and "drop `RuntimeClass` feature gate" if present. Note that this feature has been on by default since 1.14 and was GA'ed in 1.20. ([#106882](https://github.com/kubernetes/kubernetes/pull/106882), [@cyclinder](https://github.com/cyclinder))
- Remove deprecated `--serviceaccount`, `--hostport`, `--requests` and `--limits` from kubectl run. ([#108820](https://github.com/kubernetes/kubernetes/pull/108820), [@mozillazg](https://github.com/mozillazg))
- Remove support for `node-expansion` between `node-stage` and `node-publish` ([#108614](https://github.com/kubernetes/kubernetes/pull/108614), [@gnufied](https://github.com/gnufied))
- Removed deprecated `generator` and `container-port` flags ([#106824](https://github.com/kubernetes/kubernetes/pull/106824), [@lauchokyip](https://github.com/lauchokyip))
- Removed kubelet `--non-masquerade-cidr` deprecated CLI flag ([#107096](https://github.com/kubernetes/kubernetes/pull/107096), [@hakman](https://github.com/hakman))
- Rename unschedulableQ to unschedulablePods ([#108919](https://github.com/kubernetes/kubernetes/pull/108919), [@denkensk](https://github.com/denkensk))
- SPDY transport in client-go will no longer follow redirects. ([#108531](https://github.com/kubernetes/kubernetes/pull/108531), [@tallclair](https://github.com/tallclair))
- ServerResources was deprecated in February 2019 (https://github.com/kubernetes/kubernetes/commit/618050e) and now it's being removed and ServerGroupsAndResources is suggested to be used instead ([#107180](https://github.com/kubernetes/kubernetes/pull/107180), [@ardaguclu](https://github.com/ardaguclu))
- The API server's deprecated `--deserialization-cache-size` flag is now removed. ([#108448](https://github.com/kubernetes/kubernetes/pull/108448), [@ialidzhikov](https://github.com/ialidzhikov))
- The `--container-runtime` kubelet flag is deprecated and will be removed in future releases. ([#107094](https://github.com/kubernetes/kubernetes/pull/107094), [@adisky](https://github.com/adisky))
- The `WarningHeaders` feature gate that is GA since v1.22 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#108394](https://github.com/kubernetes/kubernetes/pull/108394), [@ialidzhikov](https://github.com/ialidzhikov))
- The `e2e.test` binary supports a new `--kubelet-root` parameter to override the default `/var/lib/kubelet` path. CSI storage tests use this. ([#108253](https://github.com/kubernetes/kubernetes/pull/108253), [@pohly](https://github.com/pohly))
- The fluentd-elasticsearch addon is no longer included in the cluster directory. It is available from https://github.com/kubernetes-sigs/instrumentation-addons/tree/master/fluentd-elasticsearch. ([#107553](https://github.com/kubernetes/kubernetes/pull/107553), [@liggitt](https://github.com/liggitt))
- The scheduler framework option `runAllFilters` is removed. ([#108829](https://github.com/kubernetes/kubernetes/pull/108829), [@kerthcet](https://github.com/kerthcet))
- Updated cri-tools to [v1.23.0](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.23.0). ([#107604](https://github.com/kubernetes/kubernetes/pull/107604), [@saschagrunert](https://github.com/saschagrunert))
- Updated runc to 1.1.0 and updated cadvisor to 0.44.0 ([#109029](https://github.com/kubernetes/kubernetes/pull/109029), [@ehashman](https://github.com/ehashman))
- Updated runc to 1.1.1 ([#109104](https://github.com/kubernetes/kubernetes/pull/109104), [@kolyshkin](https://github.com/kolyshkin))
- Updated the error message to not use the `--max-resource-write-bytes` & `--json-patch-max-copy-bytes` string. ([#106875](https://github.com/kubernetes/kubernetes/pull/106875), [@warmchang](https://github.com/warmchang))
- Users who look at iptables dumps will see some changes in the naming and structure of rules. ([#109060](https://github.com/kubernetes/kubernetes/pull/109060), [@thockin](https://github.com/thockin))
- Windows Pause no longer has support for SAC releases 1903, 1909, 2004. Windows image support is now Ltcs 2019 (1809), 20H2, LTSC 2022 ([#107056](https://github.com/kubernetes/kubernetes/pull/107056), [@jsturtevant](https://github.com/jsturtevant))
- [k8s.io/utils/clock]: IntervalClock is now deprecated in favour of SimpleIntervalClock ([#108059](https://github.com/kubernetes/kubernetes/pull/108059), [@RaghavRoy145](https://github.com/RaghavRoy145))
- `kube-addon-manager` image version is bumped to 9.1.6 ([#108341](https://github.com/kubernetes/kubernetes/pull/108341), [@zshihang](https://github.com/zshihang))
- Add SourceVolumeMode field to VolumeSnapshotContents. Documentation for this alpha feature is pending. ([#665](https://github.com/kubernetes-csi/external-snapshotter/pull/665), [@RaunakShah](https://github.com/RaunakShah))
- Update snapshotter module to v6 and client module to v5. Documentation for this alpha feature is pending. ([#670],(https://github.com/kubernetes-csi/external-snapshotter/pull/670), [@RaunakShah](https://github.com/RaunakShah))

### Uncategorized

- Deprecate kubectl version long output, will be replaced with kubectl version ` --short`. Users requiring full output should use `--output=yaml|json` instead. ([#108987](https://github.com/kubernetes/kubernetes/pull/108987), [@soltysh](https://github.com/soltysh))
