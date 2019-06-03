## Action Required

- Fix public IPs issues when multiple clusters are sharing the same resource group.



If the cluster is upgraded from old releases and the same resource group would be shared by multiple clusters, please recreate those LoadBalancer services or add a new tag 'kubernetes-cluster-name: <cluster-name>' manually for existing public IPs.
For multiple clusters sharing the same resource group, they should be configured with different cluster name by `kube-controller-manager --cluster-name=<cluster-name>` ([#77630](https://github.com/kubernetes/kubernetes/pull/77630), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure, and SIG Cloud Provider
- Azure cloud provider could now be configured by Kubernetes secrets and a new option `cloudConfigType` is introduced, whose candicate values are `file`, `secret` and `merge` (default is `merge`).


Since Azure cloud provider would read Kubernetes secrets, the following RBAC should be configured:

    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRole
    metadata:
    labels:
        kubernetes.io/cluster-service: "true"
    name: system:azure-cloud-provider-secret-getter
    rules:
    - apiGroups: [""]
    resources: ["secrets"]
    verbs:
    - get
    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
    labels:
        kubernetes.io/cluster-service: "true"
    name: system:azure-cloud-provider-secret-getter
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: system:azure-cloud-provider-secret-getter
    subjects:
    - kind: ServiceAccount
    name: azure-cloud-provider
    namespace: kube-system ([#78242](https://github.com/kubernetes/kubernetes/pull/78242), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure, and SIG Cloud Provider
- The Node.Status.Volumes.Attached.DevicePath field is now unset for CSI volumes. Update any external controllers that depend on this field. ([#75799](https://github.com/kubernetes/kubernetes/pull/75799), [@msau42](https://github.com/msau42)) Courtesy of SIG Storage
- ACTION REQUIRED  The deprecated flag --conntrack-max has been removed from kube-proxy. Users of this flag should switch to --conntrack-min and --conntrack-max-per-core instead. ([#78399](https://github.com/kubernetes/kubernetes/pull/78399), [@rikatz](https://github.com/rikatz)) Courtesy of SIG Cluster Lifecycle, and SIG Network
- Deprecated Kubelet security controls AllowPrivileged, HostNetworkSources, HostPIDSources, HostIPCSources have been removed. Enforcement of these restrictions should be done through admission control instead (e.g. PodSecurityPolicy).
The deprecated Kubelet flag `--allow-privileged` has been removed. Remove any use of `--allow-privileged` from your kubelet scripts or manifests. ([#77820](https://github.com/kubernetes/kubernetes/pull/77820), [@dims](https://github.com/dims)) Courtesy of SIG Cluster Lifecycle, SIG GCP, SIG Node, and SIG Testing


## New Features

- Allow to read OpenStack user credentials from a secret instead of a local config file. ([#75062](https://github.com/kubernetes/kubernetes/pull/75062), [@Fedosin](https://github.com/Fedosin)) Courtesy of SIG Cloud Provider, and SIG Storage
- Implement and update interfaces and skeleton for the scheduling framework. ([#75848](https://github.com/kubernetes/kubernetes/pull/75848), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG Scheduling, and SIG Testing
- Add support for Azure File plugin to csi-translation-lib ([#78356](https://github.com/kubernetes/kubernetes/pull/78356), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG Azure, and SIG Storage
- Handle resize operation for volume plugins migrated to CSI ([#77994](https://github.com/kubernetes/kubernetes/pull/77994), [@gnufied](https://github.com/gnufied)) Courtesy of SIG API Machinery, SIG Apps, and SIG Storage
- CRI API will now be available in the kubernetes/cri-api repository ([#75531](https://github.com/kubernetes/kubernetes/pull/75531), [@dims](https://github.com/dims)) Courtesy of SIG Network, SIG Node, SIG Release, and SIG Testing
- As of Kubernetes 1.15, the SupportNodePidsLimit feature introduced as alpha in Kubernetes 1.14 is now beta, and the ability to utilize it is enabled by default.  It is no longer necessary to set the feature gate `SupportNodePidsLimit=true`.  In all other respects, this functionality behaves as it did in Kubernetes 1.14. ([#76221](https://github.com/kubernetes/kubernetes/pull/76221), [@RobertKrawitz](https://github.com/RobertKrawitz)) Courtesy of SIG Testing
- Support both JSON and YAML for scheduler configuration. ([#75857](https://github.com/kubernetes/kubernetes/pull/75857), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- kubeadm: a new command `kubeadm upgrade node` is introduced for upgrading nodes (both secondary control-plane nodes and worker nodes)
The command `kubeadm upgrade node config` is now deprecated; use `kubeadm upgrade node` instead.
The command `kubeadm upgrade node experimental-control-plane` is now deprecated; use `kubeadm upgrade node` instead. ([#78408](https://github.com/kubernetes/kubernetes/pull/78408), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle
- Support starting Kubernetes on GCE using containerd in COS and Ubuntu with `KUBE_CONTAINER_RUNTIME=containerd`. ([#77889](https://github.com/kubernetes/kubernetes/pull/77889), [@Random-Liu](https://github.com/Random-Liu)) Courtesy of SIG Cluster Lifecycle, and SIG Node
- Add --sort-by option to kubectl top command ([#75920](https://github.com/kubernetes/kubernetes/pull/75920), [@artmello](https://github.com/artmello)) Courtesy of SIG CLI
- kubeadm: Add ability to specify certificate encryption and decryption key for the upload/download certificates phases as part of the new v1beta2 kubeadm config format. ([#77012](https://github.com/kubernetes/kubernetes/pull/77012), [@rosti](https://github.com/rosti)) Courtesy of SIG Cluster Lifecycle
- Enable 3rd party device monitoring by default ([#77274](https://github.com/kubernetes/kubernetes/pull/77274), [@RenaudWasTaken](https://github.com/RenaudWasTaken)) Courtesy of SIG Node
- watch can now be enabled  for events using the flag --watch-cache-sizes on kube-apiserver ([#74321](https://github.com/kubernetes/kubernetes/pull/74321), [@yastij](https://github.com/yastij)) Courtesy of SIG API Machinery
- Add  NonPrempting field to the PriorityClass. ([#74614](https://github.com/kubernetes/kubernetes/pull/74614), [@denkensk](https://github.com/denkensk)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, SIG Node, SIG Scheduling, and SIG Testing
- Update to use go 1.12.4 ([#76576](https://github.com/kubernetes/kubernetes/pull/76576), [@cblecker](https://github.com/cblecker)) Courtesy of SIG Release, and SIG Testing
- give users the option to suppress detailed output in integration test ([#76063](https://github.com/kubernetes/kubernetes/pull/76063), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Testing
- kubeadm's ignored pre-flight errors can now be configured via InitConfiguration and JoinConfiguration. ([#75499](https://github.com/kubernetes/kubernetes/pull/75499), [@marccarre](https://github.com/marccarre)) Courtesy of SIG Cluster Lifecycle
- Change kubelet probe metrics to counter type.
The metrics `prober_probe_result` is replaced by `prober_probe_total`. ([#76074](https://github.com/kubernetes/kubernetes/pull/76074), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, and SIG Node
- Transition service account controller clients to TokenRequest API ([#72179](https://github.com/kubernetes/kubernetes/pull/72179), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, and SIG Testing
- kubelet now allows use of XFS quotas (on XFS and suitably configured ext4fs filesystems) to monitor storage consumption for ephemeral storage (currently for emptydir volumes only).  This method of monitoring consumption is faster and more accurate than the old method of walking the filesystem tree.  It does not enforce limits, only monitors consumption.  To utilize this functionality, you must set the feature  gate `LocalStorageCapacityIsolationFSQuotaMonitoring=true`. For ext4fs filesystems, you must create the
filesystem with `mkfs.ext4 -O project <block_device>` and run `tune2fs -Q prjquota `block device`; XFS
filesystems need no additional preparation.  The filesystem must be mounted with option `project` in
`/etc/fstab`.  If your primary partition is the root filesystem, you must also add `rootflags=pquota` to your
GRUB config file. ([#66928](https://github.com/kubernetes/kubernetes/pull/66928), [@RobertKrawitz](https://github.com/RobertKrawitz)) Courtesy of SIG API Machinery, SIG Apps, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, SIG Release, SIG Scheduling, SIG Storage, and SIG Testing
- `kubectl rollout restart` now works for daemonsets and statefulsets. ([#77423](https://github.com/kubernetes/kubernetes/pull/77423), [@apelisse](https://github.com/apelisse)) Courtesy of SIG CLI, and SIG Testing
- Add `Option` field to the admission webhook `AdmissionReview` API that provides the operation options (e.g. `DeleteOption` or `CreateOption`) for the operation being performed. ([#77563](https://github.com/kubernetes/kubernetes/pull/77563), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, SIG Auth, and SIG Testing
- `kubectl get -w` now prints custom resource definitions with custom print columns ([#76161](https://github.com/kubernetes/kubernetes/pull/76161), [@liggitt](https://github.com/liggitt)) Courtesy of SIG CLI
- kubeadm: add optional ECDSA support.
kubeadm still generates RSA keys when deploying a node, but also accepts ECDSA
keys if they exist already in the directory specified in --cert-dir option. ([#76390](https://github.com/kubernetes/kubernetes/pull/76390), [@rojkov](https://github.com/rojkov)) Courtesy of SIG Cluster Lifecycle
- Finalizer Protection for Service LoadBalancers is now added as Alpha (disabled by default). This feature ensures the Service resource is not fully deleted until the correlating load balancer resources are deleted. ([#78262](https://github.com/kubernetes/kubernetes/pull/78262), [@MrHohn](https://github.com/MrHohn)) Courtesy of SIG Apps, SIG Cloud Provider, SIG Network, and SIG Testing
- remove VM API call dep in azure disk WaitForAttach ([#77483](https://github.com/kubernetes/kubernetes/pull/77483), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG Azure, and SIG Storage
- Add Post-bind extension point to the scheduling framework ([#77567](https://github.com/kubernetes/kubernetes/pull/77567), [@wgliang](https://github.com/wgliang)) Courtesy of SIG Scheduling, and SIG Testing
- scheduler: add metrics to record number of pending pods in different queues ([#75501](https://github.com/kubernetes/kubernetes/pull/75501), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Apps, and SIG Scheduling
- The kubelet only collects metrics for the node, container runtime, kubelet, pods, and containers. ([#72787](https://github.com/kubernetes/kubernetes/pull/72787), [@dashpole](https://github.com/dashpole)) Courtesy of SIG Node, and SIG Testing
- Add ListPager.EachListItem utility function to client-go to enable incremental processing of chunked list responses ([#75849](https://github.com/kubernetes/kubernetes/pull/75849), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, and SIG Apps
- Add --image-repository flag to "kubeadm config images". ([#75866](https://github.com/kubernetes/kubernetes/pull/75866), [@jmkeyes](https://github.com/jmkeyes)) Courtesy of SIG Cluster Lifecycle
- Add support for Azure Disk plugin to csi-translation-lib ([#78330](https://github.com/kubernetes/kubernetes/pull/78330), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG Azure, and SIG Storage
- Add `kubeadm alpha certs certificate-key` command to generate secure random key to use on `kubeadm init --experimental-upload-certs` ([#77848](https://github.com/kubernetes/kubernetes/pull/77848), [@yagonobre](https://github.com/yagonobre)) Courtesy of SIG Cluster Lifecycle
- Object count quota is now supported for namespaced custom resources using the `count/<resource>.<group>` syntax. ([#72384](https://github.com/kubernetes/kubernetes/pull/72384), [@zhouhaibing089](https://github.com/zhouhaibing089)) Courtesy of SIG API Machinery, SIG Apps, and SIG Testing
- Implement Permit extension point of the scheduling framework. ([#77559](https://github.com/kubernetes/kubernetes/pull/77559), [@ahg-g](https://github.com/ahg-g)) Courtesy of SIG Scheduling, and SIG Testing
- GCE clusters will include some IP ranges that are not in used on the public Internet to the list of non-masq IPs.
Bump ip-masq-agent version to v2.3.0 with flag `nomasq-all-reserved-ranges` turned on. ([#77458](https://github.com/kubernetes/kubernetes/pull/77458), [@grayluck](https://github.com/grayluck)) Courtesy of SIG Cluster Lifecycle, and SIG Network
- `k8s.io/kubernetes` and published components (like `k8s.io/client-go` and `k8s.io/api`) now publish go module files containing dependency version information. See http://git.k8s.io/client-go/INSTALL.md#go-modules for details on consuming `k8s.io/client-go` using go modules. ([#74877](https://github.com/kubernetes/kubernetes/pull/74877), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Release
- CustomResourcesDefinition conversion via webhooks is promoted to beta. It requires that spec.preserveUnknownFields is set to false. ([#78426](https://github.com/kubernetes/kubernetes/pull/78426), [@sttts](https://github.com/sttts)) Courtesy of SIG API Machinery, and SIG Testing
- Expose CSI volume stats via kubelet volume metrics ([#76188](https://github.com/kubernetes/kubernetes/pull/76188), [@humblec](https://github.com/humblec)) Courtesy of SIG Storage
- Introduce Topolgy into the runtimeClass API ([#75744](https://github.com/kubernetes/kubernetes/pull/75744), [@yastij](https://github.com/yastij)) Courtesy of SIG Node, and SIG Scheduling
- Support print volumeMode using `kubectl get pv/pvc -o wide` ([#76646](https://github.com/kubernetes/kubernetes/pull/76646), [@cwdsuzhou](https://github.com/cwdsuzhou)) Courtesy of SIG CLI
- The CustomResourcePublishOpenAPI feature is now beta and enabled by default. CustomResourceDefinitions with [structural schemas](https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md) now publish schemas in the OpenAPI document served at `/openapi/v2`. CustomResourceDefinitions with non-structural schemas have a `NonStructuralSchema` condition added with details about what needs to be corrected in the validation schema. ([#77825](https://github.com/kubernetes/kubernetes/pull/77825), [@roycaihw](https://github.com/roycaihw)) Courtesy of SIG API Machinery, and SIG Testing
- Support "queue-sort" extension point for scheduling framework ([#77529](https://github.com/kubernetes/kubernetes/pull/77529), [@draveness](https://github.com/draveness)) Courtesy of SIG Scheduling
- Add completed job status in Cronjob event. ([#75712](https://github.com/kubernetes/kubernetes/pull/75712), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Apps
- Create a new `kubectl rollout restart` command that does a rolling restart of a deployment. ([#76062](https://github.com/kubernetes/kubernetes/pull/76062), [@apelisse](https://github.com/apelisse)) Courtesy of SIG CLI, and SIG Testing
- The dockershim container runtime now accepts the `docker` runtime handler from a RuntimeClass. ([#78323](https://github.com/kubernetes/kubernetes/pull/78323), [@tallclair](https://github.com/tallclair)) Courtesy of SIG Node, and SIG Testing
- Add TLS termination support for NLB ([#74910](https://github.com/kubernetes/kubernetes/pull/74910), [@M00nF1sh](https://github.com/M00nF1sh)) Courtesy of SIG Cloud Provider
- Added `CNI_VERSION` and `CNI_SHA1` environment variables in kube-up.sh to configure CNI versions on GCE. ([#76353](https://github.com/kubernetes/kubernetes/pull/76353), [@Random-Liu](https://github.com/Random-Liu)) Courtesy of SIG Network, and SIG Node
- API changes and deprecating the use of special annotations for Windows GMSA support (version beta) ([#75459](https://github.com/kubernetes/kubernetes/pull/75459), [@wk8](https://github.com/wk8)) Courtesy of SIG API Machinery, SIG Apps, SIG Node, SIG Testing, and SIG Windows
- kubectl exec now allows using resource name (e.g., deployment/mydeployment) to select a matching pod.
kubectl exec now allows using --pod-running-timeout flag to wait till at least one pod is running. ([#73664](https://github.com/kubernetes/kubernetes/pull/73664), [@prksu](https://github.com/prksu)) Courtesy of SIG CLI, and SIG Testing
- The transformer_failures_total metric is deprecated in favor of transformation_operation_total. The old metric will continue to be populated but will be removed in a future release. ([#70715](https://github.com/kubernetes/kubernetes/pull/70715), [@immutableT](https://github.com/immutableT)) Courtesy of SIG API Machinery, and SIG Instrumentation
- Allow updates/patches to pod disruption budgets ([#69867](https://github.com/kubernetes/kubernetes/pull/69867), [@davidmccormick](https://github.com/davidmccormick)) Courtesy of SIG Apps, SIG Auth, and SIG Testing
- Paginate requests from the kube-apiserver watch cache to etcd in chunks.
Paginate reflector init and resync List calls that are not served by watch cache. ([#75389](https://github.com/kubernetes/kubernetes/pull/75389), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, SIG Apps, and SIG Testing
- Add CRD spec.preserveUnknownFields boolean, defaulting to true in v1beta1 and to false in v1 CRDs. If false, fields not specified in the validation schema will be removed when sent to the API server or when read from etcd. ([#77333](https://github.com/kubernetes/kubernetes/pull/77333), [@sttts](https://github.com/sttts)) Courtesy of SIG API Machinery, and SIG Testing
- kubeadm: kubeadm alpha certs renew and kubeadm upgrade now supports renews of certificates embedded in KubeConfig files managed by kubeadm; this does not apply to certificates signed by external CAs.  ([#77180](https://github.com/kubernetes/kubernetes/pull/77180), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle
- Migrate oom watcher not relying on cAdviosr's API any more ([#74942](https://github.com/kubernetes/kubernetes/pull/74942), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG Node
- Allow to define kubeconfig file for OpenStack cloud provider. ([#77415](https://github.com/kubernetes/kubernetes/pull/77415), [@Fedosin](https://github.com/Fedosin)) Courtesy of SIG Cloud Provider, and SIG Storage
- Admission webhooks can now register for a single version of a resource (for example, `apps/v1 deployments`) and be called when any other version of that resource is modified (for example `extensions/v1beta1 deployments`). This allows new versions of a resource to be handled by admission webhooks without needing to update every webhook to understand the new version. See the API documentation for the `matchPolicy: Equivalent` option in MutatingWebhookConfiguration and ValidatingWebhookConfiguration types. ([#78135](https://github.com/kubernetes/kubernetes/pull/78135), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, and SIG Testing
- add operation name for vm/vmss update operations in prometheus metrics ([#77491](https://github.com/kubernetes/kubernetes/pull/77491), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG Azure, and SIG Cloud Provider
- Add RuntimeClass restrictions & defaulting to PodSecurityPolicy. ([#73795](https://github.com/kubernetes/kubernetes/pull/73795), [@tallclair](https://github.com/tallclair)) Courtesy of SIG Apps, SIG Architecture, SIG Auth, and SIG Node
- Users may now execute `get-kube-binaries.sh` to request a client for an OS/Arch unlike the one of the host on which the script is invoked. ([#74889](https://github.com/kubernetes/kubernetes/pull/74889), [@akutz](https://github.com/akutz)) Courtesy of SIG Cluster Lifecycle
- Supports configure accessLogs for AWS NLB ([#78497](https://github.com/kubernetes/kubernetes/pull/78497), [@M00nF1sh](https://github.com/M00nF1sh)) Courtesy of SIG Cloud Provider
- The storageVersionHash feature is beta now. "StorageVersionHash" is a field in the discovery document of each resource. It allows clients to detect if the storage version of that resource has changed. Its value must be treated as opaque by clients. Only equality comparison on the value is valid. ([#78325](https://github.com/kubernetes/kubernetes/pull/78325), [@caesarxuchao](https://github.com/caesarxuchao)) Courtesy of SIG API Machinery, and SIG Testing
- Kubelet plugin registration now has retry and exponential backoff logic for when registration of plugins (like CSI or device plugin) fail. ([#73891](https://github.com/kubernetes/kubernetes/pull/73891), [@taragu](https://github.com/taragu)) Courtesy of SIG Node, and SIG Storage
- Add Un-reserve extension point for the scheduling framework. ([#77598](https://github.com/kubernetes/kubernetes/pull/77598), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- kubeadm: flag “--experimental-control-plane” is now deprecated. use “--control-plane” instead
kubeadm: flag “--experimental-upload-certs” is now deprecated. use “--upload-certs” instead ([#78452](https://github.com/kubernetes/kubernetes/pull/78452), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle
- Add configuration options for the scheduling framework and its plugins. ([#77501](https://github.com/kubernetes/kubernetes/pull/77501), [@JieJhih](https://github.com/JieJhih)) Courtesy of SIG Scheduling, and SIG Testing
- Kubelet will attempt to use wincat.exe in the pause container for port forwarding when running on Windows ([#75479](https://github.com/kubernetes/kubernetes/pull/75479), [@benmoss](https://github.com/benmoss)) Courtesy of SIG Node, and SIG Windows
- Kubeadm: a new command `kubeadm alpha certs check-expiration` was created in order to help users in managing expiration for local PKI certificates ([#77863](https://github.com/kubernetes/kubernetes/pull/77863), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle
- Introducing new semantic for metric "volume_operation_total_seconds" to be the end to end latency of volume provisioning/deletion. Existing metric "storage_operation_duration_seconds" will remain untouched however exposed to the following potential issues:
1. for volume's provisioned/deleted via external provisioner/deleter, "storage_operation_duration_seconds" will NOT wait for the external operation to be done before reporting latency metric (effectively close to 0). This will be fixed by using "volume_operation_total_seconds" instead
2. if there's a transient error happened during "provisioning/deletion", i.e., a volume is still in-use while a deleteVolume has been called, original "storage_operation_duration_seconds" will NOT wait until a volume has been finally deleted before reporting a not accurate latency metric. The newly implemented metric "volume_operation_total_seconds", however, wait util a provisioning/deletion operation has been fully executed.

Potential impacts:
If an SLO/alert has been defined based on "volume_operation_total_seconds", it might get violated because of the more accurate metric might be significantly larger than previously reported. The metric is defined to be a histogram and the new semantic could change the distribution. ([#78061](https://github.com/kubernetes/kubernetes/pull/78061), [@yuxiangqian](https://github.com/yuxiangqian)) Courtesy of SIG Apps, and SIG Storage
- The metric `kube_proxy_sync_proxy_rules_last_timestamp_seconds` is now available, indicating the last time that kube-proxy successfully applied proxying rules. ([#74027](https://github.com/kubernetes/kubernetes/pull/74027), [@squeed](https://github.com/squeed)) Courtesy of SIG Instrumentation, and SIG Network
- Support specify the Resource Group of Route Table when update Pod network route (Azure) ([#75580](https://github.com/kubernetes/kubernetes/pull/75580), [@suker200](https://github.com/suker200)) Courtesy of SIG Cloud Provider
- proxy/transport: Support Content-Encoding: deflate ([#76551](https://github.com/kubernetes/kubernetes/pull/76551), [@JieJhih](https://github.com/JieJhih)) Courtesy of SIG API Machinery
- util/initsystem: add support for the OpenRC init system ([#73101](https://github.com/kubernetes/kubernetes/pull/73101), [@oz123](https://github.com/oz123)) Courtesy of SIG Cluster Lifecycle, and SIG Node
- Implement un-reserve extension point for the scheduling framework. ([#77457](https://github.com/kubernetes/kubernetes/pull/77457), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- kubeadm: implement deletion of multiple bootstrap tokens at once ([#75646](https://github.com/kubernetes/kubernetes/pull/75646), [@bart0sh](https://github.com/bart0sh)) Courtesy of SIG Cluster Lifecycle
- Admission webhooks are now properly called for `scale` and `deployments/rollback` subresources ([#76849](https://github.com/kubernetes/kubernetes/pull/76849), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG Auth, and SIG Testing
- Windows support for preserving the destination IP as the VIP when loadbalancing with DSR. ([#74825](https://github.com/kubernetes/kubernetes/pull/74825), [@ksubrmnn](https://github.com/ksubrmnn)) Courtesy of SIG Network, and SIG Windows


## API Changes

- This change enables a user to specify a DataSource/Kind of type "PersistentVolumeClaim" in their PVC spec.  This can then be detected by the external csi-provisioner and plugins if capable. ([#76913](https://github.com/kubernetes/kubernetes/pull/76913), [@j-griffith](https://github.com/j-griffith))
- Introduce the v1beta2 config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))
- Resource list requests for PartialObjectMetadata now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- Add a condition NonStructuralSchema to CustomResourceDefinition listing Structural Schema violations as defined in KEP https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md. CRD authors should update their validation schemas to be structural in order to participate in future CRD features. ([#77207](https://github.com/kubernetes/kubernetes/pull/77207), [@sttts](https://github.com/sttts))
- CustomResourceDefinition with invalid regular expression in the pattern field of OpenAPI v3 validation schemas are not considere structural. ([#78453](https://github.com/kubernetes/kubernetes/pull/78453), [@sttts](https://github.com/sttts))
- Promote meta.k8s.io/v1beta1 Table and PartialObjectMetadata to v1. ([#77136](https://github.com/kubernetes/kubernetes/pull/77136), [@smarterclayton](https://github.com/smarterclayton))
- [IPVS] Introduces flag ipvs-strict-arp to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- CRD validation schemas should not specify `metadata` fields other than `name` and `generateName`. A schema will not be considered structural (and therefore ready for future features) if `metadata` is specified in any other way. ([#77653](https://github.com/kubernetes/kubernetes/pull/77653), [@sttts](https://github.com/sttts))


## Notes From Multiple SIGs

### SIG CLI, and SIG Scheduling

- Support parsing more v1.Taint forms. `key:effect`, `key=:effect-` are now accepted. ([#74159](https://github.com/kubernetes/kubernetes/pull/74159), [@dlipovetsky](https://github.com/dlipovetsky))

### SIG Apps, SIG Instrumentation, and SIG Scalability

- The `series.state` field in the events.k8s.io/v1beta1 Event API is deprecated and will be removed in v1.18 ([#75987](https://github.com/kubernetes/kubernetes/pull/75987), [@yastij](https://github.com/yastij))

### SIG Cloud Provider, and SIG VMWare

- Fix vSphere SAML token auth when using Zones ([#78137](https://github.com/kubernetes/kubernetes/pull/78137), [@dougm](https://github.com/dougm))
- Support vSphere SAML token auth when using Zones ([#75515](https://github.com/kubernetes/kubernetes/pull/75515), [@dougm](https://github.com/dougm))

### SIG API Machinery, SIG Apps, and SIG Testing

- Updates that remove remaining `metadata.finalizers` from  an object that is pending deletion (non-nil metadata.deletionTimestamp) and has no graceful deletion pending (nil or 0 metadata.deletionGracePeriodSeconds) now results in immediate deletion of the object. ([#77952](https://github.com/kubernetes/kubernetes/pull/77952), [@liggitt](https://github.com/liggitt))

### SIG Release, and SIG Testing

- Update to use go 1.12.5 ([#77528](https://github.com/kubernetes/kubernetes/pull/77528), [@cblecker](https://github.com/cblecker))

### SIG Scheduling, and SIG Storage

- Count PVCs that are unbound towards attach limit ([#73863](https://github.com/kubernetes/kubernetes/pull/73863), [@gnufied](https://github.com/gnufied))

### SIG CLI, and SIG Testing

- Preserves existing namespace information in manifests when running `kubectl set ... --local` commands ([#77267](https://github.com/kubernetes/kubernetes/pull/77267), [@liggitt](https://github.com/liggitt))
- `kubectl scale job`, deprecated since 1.10, has been removed ([#78445](https://github.com/kubernetes/kubernetes/pull/78445), [@soltysh](https://github.com/soltysh))

### SIG Cloud Provider, and SIG Node

- Rancher credential provider has now been removed ([#77099](https://github.com/kubernetes/kubernetes/pull/77099), [@dims](https://github.com/dims))

### SIG Cluster Lifecycle, and SIG Instrumentation

- [metrics-server addon] Restore connecting to nodes via IP addresses ([#76819](https://github.com/kubernetes/kubernetes/pull/76819), [@serathius](https://github.com/serathius))

### SIG API Machinery, SIG CLI, and SIG Testing

- Clients may now request that API objects are converted to the `v1.Table` and `v1.PartialObjectMetadata` forms for generic access to objects. ([#77448](https://github.com/kubernetes/kubernetes/pull/77448), [@smarterclayton](https://github.com/smarterclayton))

### SIG Apps, and SIG Testing

- Remove extra pod creation expections when daemonset fails to create pods in batches. ([#74856](https://github.com/kubernetes/kubernetes/pull/74856), [@draveness](https://github.com/draveness))

### SIG API Machinery, and SIG Storage

- StorageObjectInUseProtection admission plugin is additionally enabled by default.
So default enabled admission plugins are now `NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota,StorageObjectInUseProtection`. Please note that if you previously had not set the `--admission-control` flag, your cluster behavior may change (to be more standard). ([#74610](https://github.com/kubernetes/kubernetes/pull/74610), [@oomichi](https://github.com/oomichi))

### SIG Cluster Lifecycle, SIG GCP, and SIG Windows

- Windows nodes on GCE now have the Windows firewall enabled by default. ([#78507](https://github.com/kubernetes/kubernetes/pull/78507), [@pjh](https://github.com/pjh))

### SIG Auth, SIG CLI, and SIG Storage

- Inline CSI ephemeral volumes can now be controlled with PodSecurityPolicy when the CSIInlineVolume alpha feature is enabled ([#76915](https://github.com/kubernetes/kubernetes/pull/76915), [@vladimirvivien](https://github.com/vladimirvivien))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Updated klog to 0.3.0 ([#76474](https://github.com/kubernetes/kubernetes/pull/76474), [@vincepri](https://github.com/vincepri))

### SIG API Machinery, and SIG Instrumentation

- Replace *_admission_latencies_milliseconds_summary and *_admission_latencies_milliseconds metrics due to reporting wrong unit (was labelled milliseconds, but reported seconds), and multiple naming guideline violations (units should be in base units and "duration" is the best practice labelling to measure the time a request takes). Please convert to use *_admission_duration_seconds and *_admission_duration_seconds_summary, these now report the unit as described, and follow the instrumentation best practices. ([#75279](https://github.com/kubernetes/kubernetes/pull/75279), [@danielqsj](https://github.com/danielqsj))

### SIG Cluster Lifecycle, and SIG Network

- NodeLocal DNSCache graduating to beta. ([#77887](https://github.com/kubernetes/kubernetes/pull/77887), [@prameshj](https://github.com/prameshj))

### SIG CLI, SIG Network, and SIG Testing

- ingress:  Update in-tree Ingress controllers, examples, and clients to target networking.k8s.io/v1beta1 ([#77617](https://github.com/kubernetes/kubernetes/pull/77617), [@cmluciano](https://github.com/cmluciano))

### SIG API Machinery, SIG Auth, SIG Release, and SIG Testing

- Added port configuration to Admission webhook configuration service reference.
- Added port configuration to AuditSink webhook configuration service reference.
- Added port configuration to CRD Conversion webhook configuration service reference.
- Added port configuration to kube-aggregator service reference. ([#74855](https://github.com/kubernetes/kubernetes/pull/74855), [@mbohlool](https://github.com/mbohlool))

### SIG Azure, SIG Cloud Provider, and SIG Storage

- Switch to instance-level update APIs for Azure VMSS loadbalancer operations ([#76656](https://github.com/kubernetes/kubernetes/pull/76656), [@feiskyer](https://github.com/feiskyer))
- fix detach azure disk back off issue which has too big lock in failure retry condition ([#76573](https://github.com/kubernetes/kubernetes/pull/76573), [@andyzhangx](https://github.com/andyzhangx))
- Fix incorrect azuredisk lun error ([#77912](https://github.com/kubernetes/kubernetes/pull/77912), [@andyzhangx](https://github.com/andyzhangx))
- ---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: azurefile
provisioner: kubernetes.io/azure-file
parameters:
  skuName: Standard_LRS
  resourceGroup: EXISTING_RESOURCE_GROUP_NAME
  storageAccount: EXISTING_STORAGE_ACCOUNT_NAME
  shareName: SHARE_NAME
```

**Which issue(s) this PR fixes**:
<!--
*Automatically closes linked issue when PR is merged.
Usage: `Fixes #<issue number>`, or `Fixes (paste link of issue)`.
_If PR is about `failing-tests or flakes`, please post the related issues/tests in a comment and do not use `Fixes`_-->
Fixes #76986

**Special notes for your reviewer**:
add shareName param in azure file storage class

**Release note**:
<!--
If no, just write "NONE" in the release-note block below.
If yes, a release note is required:
Enter your extended release note in the block below. If the PR requires additional action from users switching to the new release, include the string "action required".
-->
```
specify azure file share name in azure file plugin ([#76988](https://github.com/kubernetes/kubernetes/pull/76988), [@andyzhangx](https://github.com/andyzhangx))

### SIG Cluster Lifecycle, and SIG Windows

- Windows nodes on GCE use a known-working 1809 image rather than the latest 1809 image. ([#76722](https://github.com/kubernetes/kubernetes/pull/76722), [@pjh](https://github.com/pjh))

### SIG Auth, and SIG Testing

- Validating admission webhooks are now properly called for CREATE operations on the following resources: tokenreviews, subjectaccessreviews, localsubjectaccessreviews, selfsubjectaccessreviews, selfsubjectrulesreviews ([#76959](https://github.com/kubernetes/kubernetes/pull/76959), [@sbezverk](https://github.com/sbezverk))

### SIG Azure, and SIG Storage

- remove vmsizelist call in azure disk GetVolumeLimits which happens in kubelet finally ([#77851](https://github.com/kubernetes/kubernetes/pull/77851), [@andyzhangx](https://github.com/andyzhangx))

### SIG Apps, and SIG Network

- Allow trailing dots in the externalName of Services of type ExternalName. ([#78385](https://github.com/kubernetes/kubernetes/pull/78385), [@thz](https://github.com/thz))
- Route controller now respects rate limiting to the cloud provider on deletion, previously it was only for create. ([#78581](https://github.com/kubernetes/kubernetes/pull/78581), [@andrewsykim](https://github.com/andrewsykim))

### SIG API Machinery, SIG Azure, SIG CLI, and SIG Cloud Provider

- Upgrade go-autorest to v11.1.2 ([#77070](https://github.com/kubernetes/kubernetes/pull/77070), [@feiskyer](https://github.com/feiskyer))

### SIG Cluster Lifecycle, SIG Release, and SIG Testing

- Ensures the conformance test image saves results before exiting when ginkgo returns non-zero value. ([#76039](https://github.com/kubernetes/kubernetes/pull/76039), [@johnSchnake](https://github.com/johnSchnake))

### SIG Storage, and SIG Testing

- Fix bug with block volume expansion ([#77317](https://github.com/kubernetes/kubernetes/pull/77317), [@gnufied](https://github.com/gnufied))

### SIG AWS, SIG Scalability, and SIG Storage

- Use zone from node for topology aware aws-ebs volume creation to reduce unnecessary cloud provider calls ([#78276](https://github.com/kubernetes/kubernetes/pull/78276), [@zhan849](https://github.com/zhan849))

### SIG API Machinery, and SIG Release

- Implementing deduplication logic for v1beta1.Event API ([#65782](https://github.com/kubernetes/kubernetes/pull/65782), [@yastij](https://github.com/yastij))

### SIG AWS, SIG Cloud Provider, and SIG Node

- The AWS credential provider can now obtain ECR credentials even without the AWS cloud provider or being on an EC2 instance. Additionally, AWS credential provider caching has been improved to honor the ECR credential timeout. ([#75587](https://github.com/kubernetes/kubernetes/pull/75587), [@tiffanyfay](https://github.com/tiffanyfay))

### SIG API Machinery, SIG Node, and SIG Scalability

- The Kubelet now properly requests protobuf objects where they are
supported from the apiserver, reducing load in large clusters. ([#75602](https://github.com/kubernetes/kubernetes/pull/75602), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, and SIG Scalability

- Introduce API for watch bookmark events.
Introduce Alpha field `AllowWatchBookmarks` in ListOptions for requesting watch bookmarks from apiserver. The implementation in apiserver is hidden behind feature gate `WatchBookmark` (currently in Alpha stage). ([#74074](https://github.com/kubernetes/kubernetes/pull/74074), [@wojtek-t](https://github.com/wojtek-t))

### SIG Auth, SIG AWS, and SIG Cloud Provider

- The `system:aws-cloud-provider` cluster role, deprecated in v1.13, is no longer auto-created. Deployments using the AWS cloud provider should grant required permissions to the `aws-cloud-provider` service account in the `kube-system` namespace as part of deployment.  ([#66635](https://github.com/kubernetes/kubernetes/pull/66635), [@wgliang](https://github.com/wgliang))

### SIG Cluster Lifecycle, SIG Ibmcloud, SIG Scalability, and SIG Testing

- Kubemark scripts have been fixed for IKS clusters. ([#76909](https://github.com/kubernetes/kubernetes/pull/76909), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Cluster Lifecycle, SIG GCP, and SIG Node

- Fixes a NPD bug on GCI, so that it disables glog writing to files for log-counter ([#76211](https://github.com/kubernetes/kubernetes/pull/76211), [@wangzhen127](https://github.com/wangzhen127))

### SIG API Machinery, SIG Node, and SIG Release

- Signal handling is initialized within hyperkube commands that require it (apiserver, kubelet) ([#76659](https://github.com/kubernetes/kubernetes/pull/76659), [@S-Chan](https://github.com/S-Chan))

### SIG API Machinery, and SIG Apps

- Fixed a potential deadlock in resource quota controller
Enabled recording partial usage info for quota objects specifying multiple resources, when only some of the resources' usage can be determined. ([#74747](https://github.com/kubernetes/kubernetes/pull/74747), [@liggitt](https://github.com/liggitt))

### SIG Apps, SIG Cloud Provider, and SIG Scalability

- Fix bug where cloud-controller-manager initializes nodes multiple times ([#75405](https://github.com/kubernetes/kubernetes/pull/75405), [@tghartland](https://github.com/tghartland))

### SIG AWS, and SIG Cloud Provider

- consume the AWS region list from the AWS SDK instead of a hard-coded list in the cloud provider ([#75990](https://github.com/kubernetes/kubernetes/pull/75990), [@mcrute](https://github.com/mcrute))
- Limit use of tags when calling EC2 API to prevent API throttling for very large clusters ([#76749](https://github.com/kubernetes/kubernetes/pull/76749), [@mcrute](https://github.com/mcrute))
- reverts an aws-ebs volume provisioner optimization as we need to further discuss a viable optimization ([#78200](https://github.com/kubernetes/kubernetes/pull/78200), [@zhan849](https://github.com/zhan849))

### SIG Apps, and SIG Storage

- Add a field to store CSI volume expansion secrets ([#77516](https://github.com/kubernetes/kubernetes/pull/77516), [@gnufied](https://github.com/gnufied))

### SIG Instrumentation, and SIG Node

- If a pod has a running instance, the stats of its previously terminated instances will not show up in the kubelet summary stats any more for CRI runtimes like containerd and cri-o.

This keeps the behavior consistent with Docker integration, and fixes an issue that some container Prometheus metrics don't work when there are summary stats for multiple instances of the same pod. ([#77426](https://github.com/kubernetes/kubernetes/pull/77426), [@Random-Liu](https://github.com/Random-Liu))

### SIG API Machinery, SIG Cluster Lifecycle, SIG Instrumentation, and SIG Node

- metrics added to kubelet endpoint 'metrics/probes':

   process_start_time_seconds  ([#77975](https://github.com/kubernetes/kubernetes/pull/77975), [@logicalhan](https://github.com/logicalhan))

### SIG API Machinery, and SIG Auth

- client-go: The `rest.AnonymousClientConfig(*rest.Config) *rest.Config` helper method no longer copies custom `Transport` and `WrapTransport` fields, because those can be used to inject user credentials. ([#75771](https://github.com/kubernetes/kubernetes/pull/75771), [@liggitt](https://github.com/liggitt))

### SIG Instrumentation, SIG Storage, and SIG Testing

- Adds a new "storage_operation_status_count" metric for kube-controller-manager and kubelet to count success and error statues. ([#75750](https://github.com/kubernetes/kubernetes/pull/75750), [@msau42](https://github.com/msau42))

### SIG API Machinery, and SIG Cloud Provider

- Remove the function Parallelize, please convert to use the function ParallelizeUntil. ([#76595](https://github.com/kubernetes/kubernetes/pull/76595), [@danielqsj](https://github.com/danielqsj))
- GCE-only flag `cloud-provider-gce-lb-src-cidrs` becomes optional for external cloud providers. ([#76627](https://github.com/kubernetes/kubernetes/pull/76627), [@timoreimann](https://github.com/timoreimann))

### SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Fix OpenID Connect (OIDC) token refresh when the client secret contains a special character. ([#76914](https://github.com/kubernetes/kubernetes/pull/76914), [@tsuna](https://github.com/tsuna))

### SIG Auth, SIG CLI, and SIG Testing

- improve `kubectl auth can-i` command by warning users when they try access resource out of scope ([#76014](https://github.com/kubernetes/kubernetes/pull/76014), [@WanLinghao](https://github.com/WanLinghao))

### SIG Azure, and SIG Cloud Provider

- fix azure disk list corruption issue ([#77187](https://github.com/kubernetes/kubernetes/pull/77187), [@andyzhangx](https://github.com/andyzhangx))
- Ensure the backend pools are set correctly for Azure SLB with multiple backend pools (e.g. outbound rules) ([#76691](https://github.com/kubernetes/kubernetes/pull/76691), [@feiskyer](https://github.com/feiskyer))
- Kubelet could be run with no Azure identity now. A sample cloud provider configure is:  `{"vmType": "vmss", "useInstanceMetadata": true}` ([#77906](https://github.com/kubernetes/kubernetes/pull/77906), [@feiskyer](https://github.com/feiskyer))
-  Upgrade Azure network API version to 2018-07-01, so that EnableTcpReset could be enabled on Azure standard loadbalancer (SLB). ([#78012](https://github.com/kubernetes/kubernetes/pull/78012), [@feiskyer](https://github.com/feiskyer))
- Fix race conditions for Azure loadbalancer and route updates. ([#77490](https://github.com/kubernetes/kubernetes/pull/77490), [@feiskyer](https://github.com/feiskyer))
- fix incorrect prometheus azure metrics ([#77722](https://github.com/kubernetes/kubernetes/pull/77722), [@andyzhangx](https://github.com/andyzhangx))
- Fix some service tags not supported issues for Azure LoadBalancer service ([#77719](https://github.com/kubernetes/kubernetes/pull/77719), [@feiskyer](https://github.com/feiskyer))
- fix azure retry issue when return 2XX with error ([#78298](https://github.com/kubernetes/kubernetes/pull/78298), [@andyzhangx](https://github.com/andyzhangx))
- Add etag for NSG updates so as to fix nsg race condition ([#77210](https://github.com/kubernetes/kubernetes/pull/77210), [@feiskyer](https://github.com/feiskyer))

### SIG API Machinery, SIG Cluster Lifecycle, SIG Network, and SIG Testing

- ingress objects are now persisted in etcd using the networking.k8s.io/v1beta1 version ([#77139](https://github.com/kubernetes/kubernetes/pull/77139), [@cmluciano](https://github.com/cmluciano))

### SIG Cluster Lifecycle, and SIG GCP

- GCE: Disable the Windows defender to work around a bug that could cause nodes to crash and reboot ([#78272](https://github.com/kubernetes/kubernetes/pull/78272), [@yujuhong](https://github.com/yujuhong))
- GCE/Windows: force kill Stackdriver logging processes when the service cannot be stopped ([#77378](https://github.com/kubernetes/kubernetes/pull/77378), [@yujuhong](https://github.com/yujuhong))
- [fluentd-gcp addon] Bump fluentd-gcp-scaler to v0.5.2 to pick up security fixes. ([#76762](https://github.com/kubernetes/kubernetes/pull/76762), [@serathius](https://github.com/serathius))
- Reduce GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#76352](https://github.com/kubernetes/kubernetes/pull/76352), [@jpbetz](https://github.com/jpbetz))
- GCE/Windows: disable stackdriver logging agent to prevent node startup failures ([#76099](https://github.com/kubernetes/kubernetes/pull/76099), [@yujuhong](https://github.com/yujuhong))
- API servers using the default Google Compute Engine bootstrapping scripts will have their insecure port (`:8080`) disabled by default. To enable the insecure port, set `ENABLE_APISERVER_INSECURE_PORT=true` in kube-env or as an environment variable. ([#77447](https://github.com/kubernetes/kubernetes/pull/77447), [@dekkagaijin](https://github.com/dekkagaijin))

### SIG Apps, SIG Cluster Lifecycle, SIG Release, SIG Storage, and SIG Testing

- CSI alpha CRDs have been removed ([#75747](https://github.com/kubernetes/kubernetes/pull/75747), [@msau42](https://github.com/msau42))

### SIG Cluster Lifecycle, and SIG Testing

- Default TTL for DNS records in kubernetes zone is changed from 5s to 30s to keep consistent with old dnsmasq based kube-dns. The TTL can be customized with command `kubectl edit -n kube-system configmap/coredns`. ([#76238](https://github.com/kubernetes/kubernetes/pull/76238), [@Dieken](https://github.com/Dieken))
- kube-up.sh no longer supports "centos" and "local" providers ([#76711](https://github.com/kubernetes/kubernetes/pull/76711), [@dims](https://github.com/dims))
- Bump addon-manager to v9.0.1
- Rebase image on debian-base:v1.0.0 ([#77282](https://github.com/kubernetes/kubernetes/pull/77282), [@MrHohn](https://github.com/MrHohn))
- Override protocol between etcd server and kube-apiserver on master with HTTPS instead HTTP when mTLS is enabled in GCE ([#74690](https://github.com/kubernetes/kubernetes/pull/74690), [@wenjiaswe](https://github.com/wenjiaswe))

### SIG API Machinery, and SIG Testing

- Added objectSelector to admission webhook configurations. objectSelector is evaluated the oldObject and newObject that would be sent to the webhook, and is considered to match if either object matches the selector. A null object (oldObject in the case of create, or newObject in the case of delete) or an object that cannot have labels (like a DeploymentRollback or a PodProxyOptions object) is not considered to match. Use the object selector only if the webhook is opt-in, because end users may skip the admission webhook by setting the labels. ([#78505](https://github.com/kubernetes/kubernetes/pull/78505), [@caesarxuchao](https://github.com/caesarxuchao))
- Fixes a bug where the kube-apiserver won't start if a broken webhook is installed and the client ca configmap is empty ([#60771](https://github.com/kubernetes/kubernetes/pull/60771), [@jennybuckley](https://github.com/jennybuckley))
- Watch will now support converting response objects into Table or PartialObjectMetadata forms. ([#71548](https://github.com/kubernetes/kubernetes/pull/71548), [@smarterclayton](https://github.com/smarterclayton))
- In CRD webhook conversion ignore changes to metadata other than for labels and annotations. ([#77743](https://github.com/kubernetes/kubernetes/pull/77743), [@sttts](https://github.com/sttts))
- Adding ListMeta.RemainingItemCount. When responding a LIST request, if the server has more data available, and if the request does not contain label selectors or field selectors, the server sets the ListOptions.RemainingItemCount to the number of remaining objects. ([#75993](https://github.com/kubernetes/kubernetes/pull/75993), [@caesarxuchao](https://github.com/caesarxuchao))

### SIG Autoscaling, and SIG Cluster Lifecycle

- Update Cluster Autoscaler to 1.14.0; changelog: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.14.0 ([#75480](https://github.com/kubernetes/kubernetes/pull/75480), [@losipiuk](https://github.com/losipiuk))

### SIG Cloud Provider, and SIG Storage

- The GCERegionalPersistentDisk feature gate (GA in 1.13) can no longer be disabled. The feature gate will be removed in v1.17. ([#77412](https://github.com/kubernetes/kubernetes/pull/77412), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle, SIG GCP, and SIG Testing

- [stackdriver addon] Bump prometheus-to-sd to v0.5.0 to pick up security fixes.
[fluentd-gcp addon] Bump fluentd-gcp-scaler to v0.5.1 to pick up security fixes.
[fluentd-gcp addon] Bump event-exporter to v0.2.4 to pick up security fixes.
[fluentd-gcp addon] Bump prometheus-to-sd to v0.5.0 to pick up security fixes.
[metatada-proxy addon] Bump prometheus-to-sd v0.5.0 to pick up security fixes. ([#75362](https://github.com/kubernetes/kubernetes/pull/75362), [@serathius](https://github.com/serathius))


## Notes from Individual SIGs

### SIG API Machinery

- Fixed a bug in the apiserver storage that could cause just-added finalizers to be ignored on an immediately following delete request, leading to premature deletion. ([#77619](https://github.com/kubernetes/kubernetes/pull/77619), [@caesarxuchao](https://github.com/caesarxuchao))
- API requests rejected by admission webhooks which specify an http status code < 400 are now assigned a 400 status code. ([#77022](https://github.com/kubernetes/kubernetes/pull/77022), [@liggitt](https://github.com/liggitt))
- Improved README for k8s.io/sample-apiserver ([#73447](https://github.com/kubernetes/kubernetes/pull/73447), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- kube-apiserver: the `--enable-logs-handler` flag and log-serving functionality is deprecated, and scheduled to be removed in v1.19. ([#77611](https://github.com/kubernetes/kubernetes/pull/77611), [@rohitsardesai83](https://github.com/rohitsardesai83))
- Fixed a transient error API requests for custom resources could encounter while changes to the CustomResourceDefinition were being applied. ([#77816](https://github.com/kubernetes/kubernetes/pull/77816), [@liggitt](https://github.com/liggitt))
- Resource list requests for PartialObjectMetadata now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- Add a condition NonStructuralSchema to CustomResourceDefinition listing Structural Schema violations as defined in KEP https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md. CRD authors should update their validation schemas to be structural in order to participate in future CRD features. ([#77207](https://github.com/kubernetes/kubernetes/pull/77207), [@sttts](https://github.com/sttts))
- Add name validation for dynamic client methods in client-go ([#75072](https://github.com/kubernetes/kubernetes/pull/75072), [@lblackstone](https://github.com/lblackstone))
- CustomResourceDefinition with invalid regular expression in the pattern field of OpenAPI v3 validation schemas are not considere structural. ([#78453](https://github.com/kubernetes/kubernetes/pull/78453), [@sttts](https://github.com/sttts))
- API paging is now enabled by default in k8s.io/apiserver recommended options, and in k8s.io/sample-apiserver ([#77278](https://github.com/kubernetes/kubernetes/pull/77278), [@liggitt](https://github.com/liggitt))
- Promote meta.k8s.io/v1beta1 Table and PartialObjectMetadata to v1. ([#77136](https://github.com/kubernetes/kubernetes/pull/77136), [@smarterclayton](https://github.com/smarterclayton))
- Increased verbose level for local openapi aggregation logs to avoid flooding the log during normal operation ([#75781](https://github.com/kubernetes/kubernetes/pull/75781), [@roycaihw](https://github.com/roycaihw))
- k8s.io/client-go/dynamic/dynamicinformer.NewFilteredDynamicSharedInformerFactory now honours namespace argument ([#77945](https://github.com/kubernetes/kubernetes/pull/77945), [@michaelfig](https://github.com/michaelfig))
- client-go and kubectl no longer write cached discovery files with world-accessible file permissions ([#77874](https://github.com/kubernetes/kubernetes/pull/77874), [@yuchengwu](https://github.com/yuchengwu))
- Fixes an error with stuck informers when an etcd watch receives update or delete events with missing data ([#76675](https://github.com/kubernetes/kubernetes/pull/76675), [@ryanmcnamara](https://github.com/ryanmcnamara))
- DelayingQueue.ShutDown() is now able to be invoked multiple times without causing a closed channel panic. ([#77170](https://github.com/kubernetes/kubernetes/pull/77170), [@smarterclayton](https://github.com/smarterclayton))
- When specifying an invalid value for a label, it was not always
clear which label the value was specified for. Starting with this release, the
label's key is included in such error messages, which makes debugging easier. ([#77144](https://github.com/kubernetes/kubernetes/pull/77144), [@kenegozi](https://github.com/kenegozi))
- Fixes a regression proxying responses from aggregated API servers which could cause watch requests to hang until the first event was received ([#75887](https://github.com/kubernetes/kubernetes/pull/75887), [@liggitt](https://github.com/liggitt))
- Fixes a bug where dry-run is not honored for pod/eviction sub-resource. ([#76969](https://github.com/kubernetes/kubernetes/pull/76969), [@apelisse](https://github.com/apelisse))
- Use stdlib to log stack trace when a panic occurs ([#75853](https://github.com/kubernetes/kubernetes/pull/75853), [@roycaihw](https://github.com/roycaihw))
- CRD validation schemas should not specify `metadata` fields other than `name` and `generateName`. A schema will not be considered structural (and therefore ready for future features) if `metadata` is specified in any other way. ([#77653](https://github.com/kubernetes/kubernetes/pull/77653), [@sttts](https://github.com/sttts))
- Publish DeleteOptions parameters for deletecollection endpoints in OpenAPI spec ([#77843](https://github.com/kubernetes/kubernetes/pull/77843), [@roycaihw](https://github.com/roycaihw))
- Active watches of custom resources now terminate properly if the CRD is modified. ([#78029](https://github.com/kubernetes/kubernetes/pull/78029), [@liggitt](https://github.com/liggitt))

### SIG Apps

- This change enables a user to specify a DataSource/Kind of type "PersistentVolumeClaim" in their PVC spec.  This can then be detected by the external csi-provisioner and plugins if capable. ([#76913](https://github.com/kubernetes/kubernetes/pull/76913), [@j-griffith](https://github.com/j-griffith))
- Fixes bug in DaemonSetController causing it to stop processing some DaemonSets for 5 minutes after node removal. ([#76060](https://github.com/kubernetes/kubernetes/pull/76060), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- StatefulSet controllers no longer force a resync every 30 seconds when nothing has changed. ([#75622](https://github.com/kubernetes/kubernetes/pull/75622), [@jonsabo](https://github.com/jonsabo))
- enhance the daemonset sync logic in clock-skew scenario ([#77208](https://github.com/kubernetes/kubernetes/pull/77208), [@DaiHao](https://github.com/DaiHao))
- Fix a bug that causes DaemonSet rolling update to hang when its pod gets stuck at terminating.  ([#77773](https://github.com/kubernetes/kubernetes/pull/77773), [@DaiHao](https://github.com/DaiHao))

### SIG Azure

- fix issue that pull image failed from a cross-subscription Azure Container Registry when using MSI to authenticate ([#77245](https://github.com/kubernetes/kubernetes/pull/77245), [@norshtein](https://github.com/norshtein))

### SIG CLI

- Fix kubectl exec usage string ([#77589](https://github.com/kubernetes/kubernetes/pull/77589), [@soltysh](https://github.com/soltysh))
- Fix kubectl describe CronJobs error of `Successful Job History Limit`. ([#77347](https://github.com/kubernetes/kubernetes/pull/77347), [@danielqsj](https://github.com/danielqsj))
- In the 'kubectl describe' output, the fields with names containing special characters are displayed as-is without any pretty formatting.  ([#75483](https://github.com/kubernetes/kubernetes/pull/75483), [@gsadhani](https://github.com/gsadhani))
- Fixes incorrect handling by kubectl of custom resources whose Kind is "Status" ([#77368](https://github.com/kubernetes/kubernetes/pull/77368), [@liggitt](https://github.com/liggitt))
- Clean links handling in cp's tar code ([#76788](https://github.com/kubernetes/kubernetes/pull/76788), [@soltysh](https://github.com/soltysh))
- Remove deprecated --pod/-p flag from kubectl exec. The flag has been marked as deprecated since k8s version v1.12 ([#76713](https://github.com/kubernetes/kubernetes/pull/76713), [@prksu](https://github.com/prksu))
- Report cp errors consistently  ([#77010](https://github.com/kubernetes/kubernetes/pull/77010), [@soltysh](https://github.com/soltysh))

### SIG Cloud Provider

- `aws-cloud-provider` service account in the `kube-system` namespace need to be granted with list node permission with this optimization ([#76976](https://github.com/kubernetes/kubernetes/pull/76976), [@zhan849](https://github.com/zhan849))
- refactor AWS NLB securityGroup handling ([#74692](https://github.com/kubernetes/kubernetes/pull/74692), [@M00nF1sh](https://github.com/M00nF1sh))

### SIG Cluster Lifecycle

- Ensures that the node-role.kubernetes.io/master taint is applied to the master with NoSchedule on GCE. ([#78183](https://github.com/kubernetes/kubernetes/pull/78183), [@cheftako](https://github.com/cheftako))
- CoreDNS is now version 1.5.0
    - A `ready` plugin has been included to report pod readiness
    - The `proxy` plugin has been deprecated. The `forward` plugin is to be used instead.
    - CoreDNS fixes the logging now that kubernetes’ client lib switched to klog from glog. ([#78030](https://github.com/kubernetes/kubernetes/pull/78030), [@rajansandeep](https://github.com/rajansandeep))
- kubeadm: Fix a bug where if couple of CRIs are installed a user override of the CRI during join (via kubeadm join --cri-socket ...) is ignored and kubeadm bails out with an error ([#76505](https://github.com/kubernetes/kubernetes/pull/76505), [@rosti](https://github.com/rosti))
- kubeadm: kubeadm upgrade now renews all the certificates used by one component before upgrading the component itself, with the exception of certificates signed by external CAs. User can eventually opt-out from certificate renewal during upgrades by setting the new flag --certificate-renewal to false. ([#76862](https://github.com/kubernetes/kubernetes/pull/76862), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: fix the machine readability of "kubeadm token create --print-join-command" ([#75487](https://github.com/kubernetes/kubernetes/pull/75487), [@displague](https://github.com/displague))
- Fixes segmentation fault issue with Protobuf library when log entries are deeply nested. ([#77224](https://github.com/kubernetes/kubernetes/pull/77224), [@qingling128](https://github.com/qingling128))
- kubeadm: Improve resiliency when it comes to updating the `kubeadm-config` config map upon new control plane joins or resets. This allows for safe multiple control plane joins and/or resets. ([#76821](https://github.com/kubernetes/kubernetes/pull/76821), [@ereslibre](https://github.com/ereslibre))
- k8s-dns-node-cache image version v1.15.1 ([#76640](https://github.com/kubernetes/kubernetes/pull/76640), [@george-angel](https://github.com/george-angel))
- Introduce the v1beta2 config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))
- kubeadm: preflight checks on external etcd certificates are now skipped when joining a control-plane node with automatic copy of cluster certificates (--certificate-key) ([#75847](https://github.com/kubernetes/kubernetes/pull/75847), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: implement CRI detection for Windows worker nodes ([#78053](https://github.com/kubernetes/kubernetes/pull/78053), [@ksubrmnn](https://github.com/ksubrmnn))
- kubeadm: v1beta2 InitConfiguration no longer embeds ClusterConfiguration it it. ([#77739](https://github.com/kubernetes/kubernetes/pull/77739), [@rosti](https://github.com/rosti))
- kubeadm: Support for deprecated old kubeadm v1alpha3 config is totally removed. ([#75179](https://github.com/kubernetes/kubernetes/pull/75179), [@rosti](https://github.com/rosti))
- kubeadm: fix a bug related to volume unmount if the kubelet run directory is a symbolic link ([#77507](https://github.com/kubernetes/kubernetes/pull/77507), [@cuericlee](https://github.com/cuericlee))
- Deprecates the kubeadm config upload command as it's replacement is now graduated. Please see `kubeadm init phase upload-config` ([#77946](https://github.com/kubernetes/kubernetes/pull/77946), [@Klaven](https://github.com/Klaven))
- kubeadm: bump the minimum supported Docker version to 1.13.1 ([#77051](https://github.com/kubernetes/kubernetes/pull/77051), [@chenzhiwei](https://github.com/chenzhiwei))
-  `StubDomains` and `Upstreamnameserver` which contains a service name will be omitted while translating to the equivalent CoreDNS config. ([#75969](https://github.com/kubernetes/kubernetes/pull/75969), [@rajansandeep](https://github.com/rajansandeep))
- In case kubeadm can't access the current Kubernetes version remotely and fails to parse
the git-based version it falls back to a static predefined value of
k8s.io/kubernetes/cmd/kubeadm/app/constants.CurrentKubernetesVersion. ([#72454](https://github.com/kubernetes/kubernetes/pull/72454), [@rojkov](https://github.com/rojkov))
- kubeadm: kubeadm alpha cert renew now ignores certificates signed by external CAs ([#76865](https://github.com/kubernetes/kubernetes/pull/76865), [@fabriziopandini](https://github.com/fabriziopandini))
- Kubeadm will now include the missing certificate key if it is unable to find an expected key during `kubeadm join` when used with the `--experimental-control-plane` flow ([#76636](https://github.com/kubernetes/kubernetes/pull/76636), [@mdaniel](https://github.com/mdaniel))
- Fix error handling for loading initCfg in kubeadm upgrade and apply ([#78611](https://github.com/kubernetes/kubernetes/pull/78611), [@odinuge](https://github.com/odinuge))
- kubeadm: kubeadm alpha certs renew  --csr-only now reads the current certificates as the authoritative source for certificates attributes (same as kubeadm alpha certs renew) ([#77780](https://github.com/kubernetes/kubernetes/pull/77780), [@fabriziopandini](https://github.com/fabriziopandini))
- Bump metrics-server to v0.3.2 ([#76437](https://github.com/kubernetes/kubernetes/pull/76437), [@brett-elliott](https://github.com/brett-elliott))
- Update cri-tools to v1.14.0 ([#75658](https://github.com/kubernetes/kubernetes/pull/75658), [@feiskyer](https://github.com/feiskyer))
- GCE Windows nodes will rely solely on kubernetes and kube-proxy (and not the GCE agent) for network address management. ([#75855](https://github.com/kubernetes/kubernetes/pull/75855), [@pjh](https://github.com/pjh))
- kubeadm: fix "upgrade plan" not defaulting to a "stable" version if no version argument is passed ([#75900](https://github.com/kubernetes/kubernetes/pull/75900), [@neolit123](https://github.com/neolit123))
- Juju provider source moved to the Charmed Kubernetes org ([#76628](https://github.com/kubernetes/kubernetes/pull/76628), [@kwmonroe](https://github.com/kwmonroe))
- kubeadm: expose the kubeadm reset command as phases ([#77847](https://github.com/kubernetes/kubernetes/pull/77847), [@yagonobre](https://github.com/yagonobre))

### SIG GCP

- GCE/Windows: add support for stackdriver logging agent ([#76850](https://github.com/kubernetes/kubernetes/pull/76850), [@yujuhong](https://github.com/yujuhong))

### SIG Network

- Remove deprecated flag --cleanup-iptables from kube-proxy ([#78344](https://github.com/kubernetes/kubernetes/pull/78344), [@aramase](https://github.com/aramase))
- Fixed panic in kube-proxy when parsing iptables-save output ([#78428](https://github.com/kubernetes/kubernetes/pull/78428), [@luksa](https://github.com/luksa))
- [IPVS] Allow for transparent kube-proxy restarts ([#75283](https://github.com/kubernetes/kubernetes/pull/75283), [@lbernail](https://github.com/lbernail))
- Packets considered INVALID by conntrack are now dropped. In particular, this fixes
a problem where spurious retransmits in a long-running TCP connection to a service
IP could result in the connection being closed with the error "Connection reset by
peer" ([#74840](https://github.com/kubernetes/kubernetes/pull/74840), [@anfernee](https://github.com/anfernee))
- kube-proxy no longer automatically cleans up network rules created by running kube-proxy in other modes. If you are switching the mode that kube-proxy is in running in (EG: iptables to IPVS), you will need to run `kube-proxy --cleanup`, or restart the worker node (recommended) before restarting kube-proxy.

If you are not switching kube-proxy between different modes, this change should not require any action. ([#76109](https://github.com/kubernetes/kubernetes/pull/76109), [@vllry](https://github.com/vllry))
- kube-proxy: HealthzBindAddress and MetricsBindAddress support ipv6 address. ([#76320](https://github.com/kubernetes/kubernetes/pull/76320), [@JieJhih](https://github.com/JieJhih))
- The userspace proxy now respects the IPTables proxy's minSyncInterval parameter. ([#71735](https://github.com/kubernetes/kubernetes/pull/71735), [@dcbw](https://github.com/dcbw))
- [IPVS] Introduces flag ipvs-strict-arp to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- iptables proxier: route local traffic to LB IPs to service chain ([#77523](https://github.com/kubernetes/kubernetes/pull/77523), [@andrewsykim](https://github.com/andrewsykim))
- IPVS: Disable graceful termination for UDP traffic to solve issues with high number of UDP connections (DNS / syslog in particular) ([#77802](https://github.com/kubernetes/kubernetes/pull/77802), [@lbernail](https://github.com/lbernail))
- Fix a bug where kube-proxy returns error due to existing ipset rules using a different hash type. ([#77371](https://github.com/kubernetes/kubernetes/pull/77371), [@andrewsykim](https://github.com/andrewsykim))
- Fixes spurious error messages about failing to clean up iptables rules when using iptables 1.8. ([#77303](https://github.com/kubernetes/kubernetes/pull/77303), [@danwinship](https://github.com/danwinship))
- Increase log level to 2 for IPVS graceful termination ([#78395](https://github.com/kubernetes/kubernetes/pull/78395), [@andrewsykim](https://github.com/andrewsykim))
- kube-proxy: os exit when CleanupAndExit is set to true ([#76732](https://github.com/kubernetes/kubernetes/pull/76732), [@JieJhih](https://github.com/JieJhih))

### SIG Node

- Fix TestEventChannelFull random fail ([#76603](https://github.com/kubernetes/kubernetes/pull/76603), [@changyaowei](https://github.com/changyaowei))
- Allow init container to get its own field value as environment variable values(downwardAPI spport) ([#75109](https://github.com/kubernetes/kubernetes/pull/75109), [@yuchengwu](https://github.com/yuchengwu))
- Deprecate kubelet cAdvisor json endpoints ([#78504](https://github.com/kubernetes/kubernetes/pull/78504), [@dashpole](https://github.com/dashpole))
- UpdateContainerResources is no longer recorded as a `container_status` operation. It now uses the label `update_container` ([#75278](https://github.com/kubernetes/kubernetes/pull/75278), [@Nessex](https://github.com/Nessex))
- Check if container memory stats are available before accessing it ([#77656](https://github.com/kubernetes/kubernetes/pull/77656), [@yastij](https://github.com/yastij))
- Fix some potential deadlocks and file descriptor leaking for inotify watches. ([#75376](https://github.com/kubernetes/kubernetes/pull/75376), [@cpuguy83](https://github.com/cpuguy83))
- kubelet: fix fail to close kubelet->API connections on heartbeat failure when bootstrapping or client certificate rotation is disabled ([#78016](https://github.com/kubernetes/kubernetes/pull/78016), [@gaorong](https://github.com/gaorong))
- Fix panic logspam when running kubelet in standalone mode. ([#77888](https://github.com/kubernetes/kubernetes/pull/77888), [@tallclair](https://github.com/tallclair))
- Set selinux label at plugin socket directory ([#73241](https://github.com/kubernetes/kubernetes/pull/73241), [@vikaschoudhary16](https://github.com/vikaschoudhary16))
- Fix broken detection of non-root image user ID ([#78261](https://github.com/kubernetes/kubernetes/pull/78261), [@tallclair](https://github.com/tallclair))

### SIG Release

- Remove hyperkube short aliases from source code, Because hyperkube docker image currently create these aliases. ([#76953](https://github.com/kubernetes/kubernetes/pull/76953), [@Rand01ph](https://github.com/Rand01ph))
- fix KUBE_SERVER_PLATFORMS null error when cross compiling kubectl for non-linux platform ([#78059](https://github.com/kubernetes/kubernetes/pull/78059), [@figo](https://github.com/figo))

### SIG Scalability

- Fixed a kubemark panic when hollow-node is morphed as proxy. ([#76848](https://github.com/kubernetes/kubernetes/pull/76848), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Scheduling

- Tolerations with the same key and effect will be merged into one which has the value of the latest toleration for best effort pods. ([#75985](https://github.com/kubernetes/kubernetes/pull/75985), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Promote resource quota scope selector to GA ([#78448](https://github.com/kubernetes/kubernetes/pull/78448), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- 2X performance improvement on both required and preferred PodAffinity. ([#76243](https://github.com/kubernetes/kubernetes/pull/76243), [@Huang-Wei](https://github.com/Huang-Wei))
- Fixed a scheduler racing issue to ensure low priority pods to be unschedulable on the node(s) where high priority pods have `NominatedNodeName` set to the node(s).  ([#77990](https://github.com/kubernetes/kubernetes/pull/77990), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Storage

- Fix issue in Portworx volume driver causing controller manager to crash ([#76341](https://github.com/kubernetes/kubernetes/pull/76341), [@harsh-px](https://github.com/harsh-px))
- fix bug for regular empty file ([#62159](https://github.com/kubernetes/kubernetes/pull/62159), [@dixudx](https://github.com/dixudx))
- Reset exponential backoff when storage operation changes ([#75213](https://github.com/kubernetes/kubernetes/pull/75213), [@gnufied](https://github.com/gnufied))
- Reduce event spam for AttachVolume storage operation ([#75986](https://github.com/kubernetes/kubernetes/pull/75986), [@mucahitkurt](https://github.com/mucahitkurt))
- Till this release, iscsi plugin was waiting 10 seconds for a path to appear in the device list. However this timeout is not enough or less than default device discovery timeout in most of the systems which cause certain device to be not accounted for the volume. This timeout has been lifted to 30seconds from this release and it should help to avoid mount issues due to device discovery. ([#78475](https://github.com/kubernetes/kubernetes/pull/78475), [@humblec](https://github.com/humblec))

### SIG Testing

- Validating admission webhooks are now properly called for CREATE operations on the following resources: pods/binding, pods/eviction, bindings ([#76910](https://github.com/kubernetes/kubernetes/pull/76910), [@liggitt](https://github.com/liggitt))
- Client:
 Version:           19.03.0-beta3
 API version:       1.40
 Go version:        go1.12.4
 Git commit:        c55e026
 Built:             Thu Apr 25 03:03:18 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta3
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.4
  Git commit:       c55e026
  Built:            Thu Apr 25 03:01:56 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```
**Which issue(s) this PR fixes**:
<!--
*Automatically closes linked issue when PR is merged.
Usage: `Fixes #<issue number>`, or `Fixes (paste link of issue)`.
_If PR is about `failing-tests or flakes`, please post the related issues/tests in a comment and do not use `Fixes`_-->
Fixes #

**Special notes for your reviewer**:

**Does this PR introduce a user-facing change?**:
<!--
If no, just write "NONE" in the release-note block below.
If yes, a release note is required:
Enter your extended release note in the block below. If the PR requires additional action from users switching to the new release, include the string "action required".
-->
```
Fix local-up-cluster.sh didn't work with docker 19.03.0-beta3  ([#77495](https://github.com/kubernetes/kubernetes/pull/77495), [@wanghaoran1988](https://github.com/wanghaoran1988))

### SIG Windows

- Windows Kubelet nodes will now correctly search the default location for Docker credentials (`%USERPROFILE%\.docker\config.json`) when pulling images from a private registry (https://kubernetes.io/docs/concepts/containers/images/#configuring-nodes-to-authenticate-to-a-private-registry) ([#78528](https://github.com/kubernetes/kubernetes/pull/78528), [@bclau](https://github.com/bclau))
