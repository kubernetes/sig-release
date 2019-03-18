## Action Required

- Health check (liveness & readiness) probes using an HTTPGetAction will no longer follow redirects to different hostnames from the original probe request. Instead, these non-local redirects will be treated as a Success (the documented behavior). In this case an event with reason "ProbeWarning" will be generated, indicating that the redirect was ignored. If you were previously relying on the redirect to run health checks against different endpoints, you will need to perform the healthcheck logic outside the Kubelet, for instance by proxying the external endpoint rather than redirecting to it. ([#75416](https://github.com/kubernetes/kubernetes/pull/75416), [@tallclair](https://github.com/tallclair)) Courtesy of SIG Network, SIG Node, and SIG Testing
- The node.k8s.io API group and runtimeclasses.node.k8s.io resource have been migrated to a built-in API. If you were using RuntimeClasses (an default-disabled alpha feature, as of Kubernetes v1.12), then you must recreate all RuntimeClasses after upgrading, and the runtimeclasses.node.k8s.io CRD should be manually deleted. RuntimeClasses can no longer be created without a defined handler. ([#74433](https://github.com/kubernetes/kubernetes/pull/74433), [@tallclair](https://github.com/tallclair)) Courtesy of SIG API Machinery, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Testing
- Transition CSINodeInfo and CSIDriver alpha CRDs to in-tree CSINode and CSIDriver core storage v1beta1 APIs. ([#74283](https://github.com/kubernetes/kubernetes/pull/74283), [@xing-yang](https://github.com/xing-yang)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG Auth, SIG Node, SIG Storage, and SIG Testing
- Added cadvisor metric labels `pod` and `container` where `pod_name` and `container_name` are present to match instrumentation guidelines. ([#69099](https://github.com/kubernetes/kubernetes/pull/69099), [@ehashman](https://github.com/ehashman)) Courtesy of SIG Instrumentation, and SIG Node
- The --storage-versions flag of kube-apiserver is removed. The storage versions will always be the default value built-in the kube-apiserver binary. ([#67678](https://github.com/kubernetes/kubernetes/pull/67678), [@caesarxuchao](https://github.com/caesarxuchao)) Courtesy of SIG API Machinery, and SIG Testing
- Promote ValidateProxyRedirects to Beta, and enable by default. This feature restricts redirect following from the apiserver to same-host redirects. ([#72552](https://github.com/kubernetes/kubernetes/pull/72552), [@tallclair](https://github.com/tallclair)) Courtesy of SIG API Machinery, and SIG Node


## New Features

- Add ResourceVersion as a precondition for delete in order to ensure a delete fails if an unobserved change happens to an object. ([#74040](https://github.com/kubernetes/kubernetes/pull/74040), [@ajatprabha](https://github.com/ajatprabha)) Courtesy of SIG API Machinery
- Support collecting pod logs under /var/log/pods/NAMESPACE_NAME_UID to stackdriver with `k8s_pod` resource type. ([#74502](https://github.com/kubernetes/kubernetes/pull/74502), [@Random-Liu](https://github.com/Random-Liu)) Courtesy of SIG Cluster Lifecycle, SIG GCP, and SIG Instrumentation
- Change CRI pod log directory from `/var/log/pods/UID` to `/var/log/pods/NAMESPACE_NAME_UID`. ([#74441](https://github.com/kubernetes/kubernetes/pull/74441), [@Random-Liu](https://github.com/Random-Liu)) Courtesy of SIG Cluster Lifecycle, SIG GCP, SIG Node, and SIG Testing
- Promote RuntimeClass to beta, and enable by default. ([#75003](https://github.com/kubernetes/kubernetes/pull/75003), [@tallclair](https://github.com/tallclair)) Courtesy of SIG Auth, SIG Node, and SIG Testing
- New "dry_run" metric label (indicating the value of the dryRun query parameter) into the metrics: ([#74997](https://github.com/kubernetes/kubernetes/pull/74997), [@jennybuckley](https://github.com/jennybuckley)) Courtesy of SIG API Machinery
- GCE: bump COS image version to cos-beta-73-11647-64-0 ([#75149](https://github.com/kubernetes/kubernetes/pull/75149), [@yguo0905](https://github.com/yguo0905)) Courtesy of SIG Cluster Lifecycle
- Alpha support for ephemeral CSI inline volumes that are embedded in pod specs. ([#74086](https://github.com/kubernetes/kubernetes/pull/74086), [@vladimirvivien](https://github.com/vladimirvivien)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG Auth, SIG CLI, and SIG Storage
- Add support for node side CSI volume expansion ([#74863](https://github.com/kubernetes/kubernetes/pull/74863), [@gnufied](https://github.com/gnufied)) Courtesy of SIG Node, SIG Storage, and SIG Testing
- Add a new kubelet endpoint for serving first-class resource metrics ([#73946](https://github.com/kubernetes/kubernetes/pull/73946), [@dashpole](https://github.com/dashpole)) Courtesy of SIG Node, and SIG Testing
- Deprecate AWS, Azure, GCE and Cinder specific volume limit predicates. ([#74544](https://github.com/kubernetes/kubernetes/pull/74544), [@gnufied](https://github.com/gnufied)) Courtesy of SIG Scheduling, and SIG Storage
- If CSINodeInfo and CSIMigration feature flags are active in the cluster, Kubelet will post NotReady until CSINode is initialized with basic volume plugin mechanism information for well-known drivers ([#74835](https://github.com/kubernetes/kubernetes/pull/74835), [@davidz627](https://github.com/davidz627)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG Node, SIG Storage, and SIG Testing
- add subcommand `kubectl create cronjob` ([#71651](https://github.com/kubernetes/kubernetes/pull/71651), [@Pingan2017](https://github.com/Pingan2017)) Courtesy of SIG CLI
- The CSIBlockVolume feature gate is now beta, and defaults to enabled. ([#74909](https://github.com/kubernetes/kubernetes/pull/74909), [@bswartz](https://github.com/bswartz)) Courtesy of SIG Testing
- Pre-existing log files are now opened with O_APPEND, instead of O_TRUNC. This helps prevent losing logs when components crash-loop, and also enables external log rotation utilities to truncate log files in-place without components extending log files to their pre-truncation sizes on subsequent writes. ([#74837](https://github.com/kubernetes/kubernetes/pull/74837), [@mtaufen](https://github.com/mtaufen)) Courtesy of SIG API Machinery, SIG Architecture, SIG CLI, SIG Cloud Provider, and SIG Cluster Lifecycle
- the test/e2e/e2e.test binary can test arbitrary storage drivers, see the `-storage.testdriver` parameter ([#72836](https://github.com/kubernetes/kubernetes/pull/72836), [@pohly](https://github.com/pohly)) Courtesy of SIG Storage, and SIG Testing
- kubeadm: add certificate-key and skip-certificate-key-print flags to kubeadm init ([#74671](https://github.com/kubernetes/kubernetes/pull/74671), [@yagonobre](https://github.com/yagonobre)) Courtesy of SIG Cluster Lifecycle
- Admission webhooks rules can now limit scope to only match namespaced, or only cluster-scoped resources with a `scope: "Cluster" | "Namespaced" | "*"` field. ([#74477](https://github.com/kubernetes/kubernetes/pull/74477), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery
- Add `nullable` support to CustomResourceDefinition OpenAPI validation schemata. ([#74804](https://github.com/kubernetes/kubernetes/pull/74804), [@sttts](https://github.com/sttts)) Courtesy of SIG API Machinery
- Increase api server client certificate expiration histogram resolution to accommodate short-lived (< 6h) client certificates. ([#74806](https://github.com/kubernetes/kubernetes/pull/74806), [@mxinden](https://github.com/mxinden)) Courtesy of SIG API Machinery, and SIG Auth
- Default RBAC policy no longer grants access to discovery and permission-checking APIs (used by `kubectl auth can-i`) to *unauthenticatedusers. Upgraded clusters preserve prior behavior, but cluster administrators wishing to grant unauthenticated users access in new clusters will need to explicitly opt-in to expose the discovery and/or permission-checking APIs: ([#73807](https://github.com/kubernetes/kubernetes/pull/73807), [@dekkagaijin](https://github.com/dekkagaijin)) Courtesy of SIG Auth, and SIG Testing
- The PersistentLocalVolumes feature is GA. The feature gate cannot be disabled and will be removed in Kubernetes 1.17 ([#74769](https://github.com/kubernetes/kubernetes/pull/74769), [@msau42](https://github.com/msau42)) Courtesy of SIG Storage
- Convert `latency`/`latencies` in metrics name to `duration`. ([#74418](https://github.com/kubernetes/kubernetes/pull/74418), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG API Machinery, SIG Instrumentation, SIG Network, SIG Node, SIG Scheduling, and SIG Testing
- Update to use golang 1.12 ([#74632](https://github.com/kubernetes/kubernetes/pull/74632), [@cblecker](https://github.com/cblecker)) Courtesy of SIG API Machinery, SIG Release, SIG Scalability, and SIG Testing
- The `RunAsGroup` feature has been promoted to beta and enabled by default. PodSpec and PodSecurityPolicy objects can be used to control the primary GID of containers on supported container runtimes. ([#73007](https://github.com/kubernetes/kubernetes/pull/73007), [@krmayankk](https://github.com/krmayankk)) Courtesy of SIG Auth, SIG Node, and SIG Testing
- Adds the same information to an init container as a standard container in a pod when using PodPresets. ([#71479](https://github.com/kubernetes/kubernetes/pull/71479), [@soggiest](https://github.com/soggiest)) Courtesy of SIG Node, SIG Service Catalog, and SIG Testing
- kube-conformance image will now run ginkgo with the --dryRun flag if the container is run with the environment variable E2E_DRYRUN set. ([#74731](https://github.com/kubernetes/kubernetes/pull/74731), [@johnSchnake](https://github.com/johnSchnake)) Courtesy of SIG Cluster Lifecycle, and SIG Release
- Introduce dynamic volume provisioning shim for CSI migration ([#73653](https://github.com/kubernetes/kubernetes/pull/73653), [@ddebroy](https://github.com/ddebroy)) Courtesy of SIG Apps, and SIG Storage
-         # Apply resources from a directory containing kustomization.yaml ([#74140](https://github.com/kubernetes/kubernetes/pull/74140), [@Liujingfang1](https://github.com/Liujingfang1)) Courtesy of SIG Auth, SIG CLI, SIG Release, and SIG Testing
- kubeadm: Allow to download certificate secrets uploaded by `init` or `upload-certs` phase, allowing to transfer certificate secrets (certificates and keys) from the cluster to other master machines when creating HA deployments. ([#74168](https://github.com/kubernetes/kubernetes/pull/74168), [@ereslibre](https://github.com/ereslibre)) Courtesy of SIG Cluster Lifecycle
- The `--quiet` option to `kubectl run` now suppresses resource deletion messages emitted when the `--rm` option is specified. ([#73266](https://github.com/kubernetes/kubernetes/pull/73266), [@awh](https://github.com/awh)) Courtesy of SIG CLI
- Add Custom Resource support to "kubectl autoscale" ([#72678](https://github.com/kubernetes/kubernetes/pull/72678), [@rmohr](https://github.com/rmohr)) Courtesy of SIG Autoscaling, and SIG CLI
- The new test ``[sig-network] DNS should provide /etc/hosts entries for the cluster [LinuxOnly] [Conformance]`` will validate the host entries set in the ``/etc/hosts`` file (pod's FQDN and hostname), which should be managed by Kubelet. ([#72729](https://github.com/kubernetes/kubernetes/pull/72729), [@bclau](https://github.com/bclau)) Courtesy of SIG Architecture, SIG Network, SIG Testing, and SIG Windows
- Allow Cinder volume limit to be configured from node too ([#74542](https://github.com/kubernetes/kubernetes/pull/74542), [@gnufied](https://github.com/gnufied)) Courtesy of SIG Cloud Provider, SIG OpenStack, and SIG Storage
- Allow the kubelet to pass Windows GMSA credentials down to Docker ([#73726](https://github.com/kubernetes/kubernetes/pull/73726), [@wk8](https://github.com/wk8)) Courtesy of SIG Node, and SIG Windows
- It is now possible to combine the `-f` and `-l` flags in `kubectl logs` ([#67573](https://github.com/kubernetes/kubernetes/pull/67573), [@m1kola](https://github.com/m1kola)) Courtesy of SIG CLI, and SIG Scalability
- New conformance tests added for API Aggregation. ([#63947](https://github.com/kubernetes/kubernetes/pull/63947), [@jennybuckley](https://github.com/jennybuckley)) Courtesy of SIG API Machinery, SIG Architecture, and SIG Testing
- Move fluentd-elasticsearch addon images to community controlled location ([#73819](https://github.com/kubernetes/kubernetes/pull/73819), [@coffeepac](https://github.com/coffeepac)) Courtesy of SIG Cluster Lifecycle, and SIG Instrumentation
- The PriorityClass API has been promoted to `scheduling.k8s.io/v1` with no changes. The `scheduling.k8s.io/v1beta1` version is now deprecated and will stop being served by default in v1.17. ([#73555](https://github.com/kubernetes/kubernetes/pull/73555), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG API Machinery, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Scheduling, and SIG Testing
- kubeadm: remove local etcd members from the etcd cluster when kubeadm reset ([#74112](https://github.com/kubernetes/kubernetes/pull/74112), [@pytimer](https://github.com/pytimer)) Courtesy of SIG Cluster Lifecycle
- kubeadm: Do not fail preflight checks when running on >= 5.0 Linux kernel ([#74355](https://github.com/kubernetes/kubernetes/pull/74355), [@brb](https://github.com/brb)) Courtesy of SIG Cluster Lifecycle
- The Ingress API is now available via `networking.k8s.io/v1beta1`. `extensions/v1beta1` Ingress objects are deprecated and will no longer be served in v1.18. ([#74057](https://github.com/kubernetes/kubernetes/pull/74057), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Network, and SIG Testing
- Optimize scheduler cache snapshot algorithm to improve scheduling throughput. ([#74041](https://github.com/kubernetes/kubernetes/pull/74041), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG Scheduling
- kubeadm: Allow to upload certificates required to join a new control-plane to kubeadm-certs secret using the flag `--experimental-upload-certs` on `init` or upload-certs phase. ([#73907](https://github.com/kubernetes/kubernetes/pull/73907), [@yagonobre](https://github.com/yagonobre)) Courtesy of SIG Cluster Lifecycle
- Change kubelet metrics to conform metrics guidelines. ([#72470](https://github.com/kubernetes/kubernetes/pull/72470), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, SIG Node, and SIG Testing
- none ([#74182](https://github.com/kubernetes/kubernetes/pull/74182), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG Azure, and SIG Cloud Provider
- vSphere cloud provider correctly retrieves the VM's UUID when running on Windows ([#71147](https://github.com/kubernetes/kubernetes/pull/71147), [@benmoss](https://github.com/benmoss)) Courtesy of SIG Cloud Provider, SIG VMWare, and SIG Windows
- kubelet now accepts `pid=<number>` in the `--system-reserved` and `--kube-reserved` options to ensure that the specified number of process IDs will be reserved for the system as a whole and for Kubernetes system daemons respectively.  Please reference `Kube Reserved` and `System Reserved` in `Reserve Compute Resources for System Daemons` in the Kubernetes documentation for general discussion of resource reservation.  To utilize this functionality, you must set the feature gate `SupportNodePidsLimit=true` ([#73651](https://github.com/kubernetes/kubernetes/pull/73651), [@RobertKrawitz](https://github.com/RobertKrawitz)) Courtesy of SIG Architecture, SIG Node, and SIG Testing
- `kubectl auth reconcile` now outputs details about what changes are being made ([#71564](https://github.com/kubernetes/kubernetes/pull/71564), [@liggitt](https://github.com/liggitt)) Courtesy of SIG Auth, and SIG CLI
- Kustomize is developed in its own repo https://github.com/kubernetes-sigs/kustomize ([#73033](https://github.com/kubernetes/kubernetes/pull/73033), [@Liujingfang1](https://github.com/Liujingfang1)) Courtesy of SIG CLI
- Change docker metrics to conform metrics guidelines and using histogram for better aggregation. ([#72323](https://github.com/kubernetes/kubernetes/pull/72323), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, SIG Node, and SIG Testing
- Add kubelet_node_name metrics. ([#72910](https://github.com/kubernetes/kubernetes/pull/72910), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, and SIG Node
- The HugePages feature gate has graduated to GA, and can no longer be disabled. The feature gate will be removed in v1.16 ([#72785](https://github.com/kubernetes/kubernetes/pull/72785), [@derekwaynecarr](https://github.com/derekwaynecarr)) Courtesy of SIG Apps, and SIG Node
- Updated AWS SDK to v1.16.26 for ECR PrivateLink support ([#73435](https://github.com/kubernetes/kubernetes/pull/73435), [@micahhausler](https://github.com/micahhausler)) Courtesy of SIG AWS
- Expand kubectl wait to work with more types of selectors. ([#71746](https://github.com/kubernetes/kubernetes/pull/71746), [@rctl](https://github.com/rctl)) Courtesy of SIG CLI, and SIG Testing
- The CustomPodDNS feature gate has graduated to GA, and can no longer be disabled. The feature gate will be removed in v1.16 ([#72832](https://github.com/kubernetes/kubernetes/pull/72832), [@MrHohn](https://github.com/MrHohn)) Courtesy of SIG Apps, SIG Network, and SIG Node
- Introduced support for Windows nodes into the cluster bringup scripts for GCE. ([#73442](https://github.com/kubernetes/kubernetes/pull/73442), [@pjh](https://github.com/pjh)) Courtesy of SIG Cluster Lifecycle, and SIG GCP
- Graduate Pod Priority and Preemption to GA. ([#73498](https://github.com/kubernetes/kubernetes/pull/73498), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG Scheduling
- Adds configuration for AWS endpoint fine control: ([#72245](https://github.com/kubernetes/kubernetes/pull/72245), [@ampsingram](https://github.com/ampsingram)) Courtesy of SIG Cloud Provider
- The CoreDNS configuration now has the forward plugin for proxy in the default configuration instead of the proxy plugin.  ([#73267](https://github.com/kubernetes/kubernetes/pull/73267), [@rajansandeep](https://github.com/rajansandeep)) Courtesy of SIG Cluster Lifecycle
- Added alpha field storageVersionHash to the discovery document for each resource. Its value must be treated as opaque by clients. Only equality comparison on the value is valid. ([#73191](https://github.com/kubernetes/kubernetes/pull/73191), [@caesarxuchao](https://github.com/caesarxuchao)) Courtesy of SIG API Machinery
- Change proxy metrics to conform metrics guidelines. ([#72334](https://github.com/kubernetes/kubernetes/pull/72334), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, and SIG Network
- If you are running the cloud-controller-manager and you have the `pvlabel.kubernetes.io` alpha Initializer enabled, you must now enable PersistentVolume labeling using the `PersistentVolumeLabel` admission controller instead. You can do this by adding `PersistentVolumeLabel` in the `--enable-admission-plugins` kube-apiserver flag.  ([#73102](https://github.com/kubernetes/kubernetes/pull/73102), [@andrewsykim](https://github.com/andrewsykim)) Courtesy of SIG Cloud Provider, SIG OpenStack, and SIG Storage
- kubectl supports copying files with wild card ([#72641](https://github.com/kubernetes/kubernetes/pull/72641), [@dixudx](https://github.com/dixudx)) Courtesy of SIG CLI
- kubeadm now attempts to detect an installed CRI by its usual domain socket, so that --cri-socket can be omitted from the command line if Docker is not used and there is a single CRI installed. ([#69366](https://github.com/kubernetes/kubernetes/pull/69366), [@rosti](https://github.com/rosti)) Courtesy of SIG Cluster Lifecycle
- Install CSINodeInfo and CSIDriver CRDs in the local cluster. ([#72584](https://github.com/kubernetes/kubernetes/pull/72584), [@xing-yang](https://github.com/xing-yang)) Courtesy of SIG Storage
- Node OS/arch labels are promoted to GA ([#73048](https://github.com/kubernetes/kubernetes/pull/73048), [@yujuhong](https://github.com/yujuhong)) Courtesy of SIG Node
- Change apiserver metrics to conform metrics guidelines. ([#72336](https://github.com/kubernetes/kubernetes/pull/72336), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG API Machinery, SIG Instrumentation, and SIG Testing
- Add support for max attach limit for Cinder ([#72980](https://github.com/kubernetes/kubernetes/pull/72980), [@gnufied](https://github.com/gnufied)) Courtesy of SIG Scheduling, and SIG Storage
- Enable mTLS encription between etcd and kube-apiserver in GCE ([#70144](https://github.com/kubernetes/kubernetes/pull/70144), [@wenjiaswe](https://github.com/wenjiaswe)) Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG GCP


## API Changes

- Add mechanism for Admission Webhooks to specify which version of AdmissionReview they support ([#74998](https://github.com/kubernetes/kubernetes/pull/74998), [@mbohlool](https://github.com/mbohlool))
- PriorityClass in scheduling.k8s.io/v1beta1 and scheduling.k8s.io/v1alpha1 are deprecated by PriorityClass scheduling.k8s.io/v1 and will not be served starting in v1.17. ([#74465](https://github.com/kubernetes/kubernetes/pull/74465), [@bsalamat](https://github.com/bsalamat))
- export query parameter is deprecated and will be removed in a future release ([#73783](https://github.com/kubernetes/kubernetes/pull/73783), [@deads2k](https://github.com/deads2k))
- [CRI] Add a new field called `runtime_handler` into PodSandbox and PodSandboxStatus to track the RuntimeClass information of a pod. ([#73833](https://github.com/kubernetes/kubernetes/pull/73833), [@haiyanmeng](https://github.com/haiyanmeng))


## Notes From Multiple SIGs

### SIG API Machinery, SIG Instrumentation, and SIG Testing

- Add duration metric for CRD webhook converters ([#74376](https://github.com/kubernetes/kubernetes/pull/74376), [@mbohlool](https://github.com/mbohlool))

### SIG Node, and SIG Windows

- Add network stats for Windows nodes and containers ([#74788](https://github.com/kubernetes/kubernetes/pull/74788), [@feiskyer](https://github.com/feiskyer))
- Kubelet: add usageNanoCores from CRI stats provider ([#73659](https://github.com/kubernetes/kubernetes/pull/73659), [@feiskyer](https://github.com/feiskyer))
- Add network stats for Windows nodes and pods. ([#70121](https://github.com/kubernetes/kubernetes/pull/70121), [@feiskyer](https://github.com/feiskyer))

### SIG Auth, and SIG Testing

- `system:kube-controller-manager` and `system:kube-scheduler` users are now permitted to perform delegated authentication/authorization checks by default RBAC policy ([#72491](https://github.com/kubernetes/kubernetes/pull/72491), [@liggitt](https://github.com/liggitt))

### SIG Cloud Provider, and SIG VMWare

- MAC Address filter has been fixed in vSphere Cloud Provider, it no longer ignores `00:1c:14` and `00:05:69` prefixes ([#73721](https://github.com/kubernetes/kubernetes/pull/73721), [@frapposelli](https://github.com/frapposelli))

### SIG Cluster Lifecycle, and SIG Windows

- CoreDNS is only officially supported on Linux at this time.  As such, when kubeadm is used to deploy this component into your kubernetes cluster, it will be restricted (using nodeSelectors) to run only on nodes with that operating system. This ensures that in clusters which include Windows nodes, the scheduler will not ever attempt to place CoreDNS pods on these machines, reducing setup latency and enhancing initial cluster stability. ([#69940](https://github.com/kubernetes/kubernetes/pull/69940), [@MarcPow](https://github.com/MarcPow))

### SIG API Machinery, SIG Cloud Provider, and SIG Scheduling

- Fix graceful apiserver shutdown to not drop outgoing bytes before the process terminates. ([#72970](https://github.com/kubernetes/kubernetes/pull/72970), [@sttts](https://github.com/sttts))

### SIG Node, and SIG Scheduling

- kubelet: updated logic of verifying a static critical pod. ([#75144](https://github.com/kubernetes/kubernetes/pull/75144), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Node, and SIG Storage

- Because some plugins mount volume on sub-directory of volume path, we need to distinguish between volume path and mount path to fix issue in reconstruction. ([#74653](https://github.com/kubernetes/kubernetes/pull/74653), [@cofyc](https://github.com/cofyc))
- The deprecated `MountPropagation` feature gate has been removed, and the feature is now unconditionally enabled.  ([#74720](https://github.com/kubernetes/kubernetes/pull/74720), [@bertinatto](https://github.com/bertinatto))
- Events reported for container creation, start, and stop now report the container name in the message and are more consistently formatted. ([#73892](https://github.com/kubernetes/kubernetes/pull/73892), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, SIG Auth, SIG CLI, and SIG Testing

- watch.Until now works for long durations. ([#67350](https://github.com/kubernetes/kubernetes/pull/67350), [@tnozicka](https://github.com/tnozicka))
- The `/swaggerapi/*` schema docs, deprecated since 1.7, have been removed in favor of the /openapi/v2 schema docs. ([#72924](https://github.com/kubernetes/kubernetes/pull/72924), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Release, and SIG Storage

- Fix keymutex issues which may crash in some platforms. ([#74348](https://github.com/kubernetes/kubernetes/pull/74348), [@danielqsj](https://github.com/danielqsj))

### SIG API Machinery, SIG Apps, and SIG CLI

- Speedup kubectl by >10 when calling out to kube-apiserver for discovery information. ([#73345](https://github.com/kubernetes/kubernetes/pull/73345), [@sttts](https://github.com/sttts))

### SIG Apps, SIG Scheduling, and SIG Testing

- Pod eviction now honors graceful deletion by default if no delete options are provided in the eviction request ([#72730](https://github.com/kubernetes/kubernetes/pull/72730), [@liggitt](https://github.com/liggitt))

### SIG AWS, and SIG Cloud Provider

- Ensure ownership when deleting a load balancer security group ([#74311](https://github.com/kubernetes/kubernetes/pull/74311), [@hpedrorodrigues](https://github.com/hpedrorodrigues))
- Prevent AWS Network Load Balancer security groups ingress rules to be deleted by ensuring target groups are tagged. ([#73594](https://github.com/kubernetes/kubernetes/pull/73594), [@masterzen](https://github.com/masterzen))
- AWS ELB health checks will now use HTTPS/SSL protocol for HTTPS/SSL backends. ([#70309](https://github.com/kubernetes/kubernetes/pull/70309), [@2rs2ts](https://github.com/2rs2ts))

### SIG Network, and SIG Testing

- Services of type=LoadBalancer which have no endpoints will now immediately ICMP reject connections, rather than time out. ([#74394](https://github.com/kubernetes/kubernetes/pull/74394), [@thockin](https://github.com/thockin))

### SIG Cluster Lifecycle, SIG Release, and SIG Testing

- Split up the mondo `kubernetes-test` tarball into `kubernetes-test-portable` and `kubernetes-test-{OS}-{ARCH}` tarballs. ([#74065](https://github.com/kubernetes/kubernetes/pull/74065), [@ixdy](https://github.com/ixdy))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Cloud Provider, SIG Network, SIG Node, SIG Scheduling, SIG Storage, SIG Testing, and SIG VMWare

- This change applies zone labels to vSphere Volumes automatically. The zone labels are visible on the PV: ([#72687](https://github.com/kubernetes/kubernetes/pull/72687), [@subramanian-neelakantan](https://github.com/subramanian-neelakantan))

### SIG CLI, and SIG Testing

- `kubectl delete --all-namespaces` is a recognized flag. ([#73716](https://github.com/kubernetes/kubernetes/pull/73716), [@deads2k](https://github.com/deads2k))

### SIG Apps, and SIG Scheduling

- As per deprecation policy in https://kubernetes.io/docs/reference/using-api/deprecation-policy/  ([#73001](https://github.com/kubernetes/kubernetes/pull/73001), [@shivnagarajan](https://github.com/shivnagarajan))

### SIG Azure, and SIG Cloud Provider

- Allow disable outbound SNAT when Azure standard load balancer is used together with outbound rules.  ([#75282](https://github.com/kubernetes/kubernetes/pull/75282), [@feiskyer](https://github.com/feiskyer))
- Ensure Azure load balancer cleaned up on 404 or 403 when deleting LoadBalancer services. ([#75256](https://github.com/kubernetes/kubernetes/pull/75256), [@feiskyer](https://github.com/feiskyer))
- Fix kubelet start failure issue on Azure Stack due to InstanceMetadata setting ([#74936](https://github.com/kubernetes/kubernetes/pull/74936), [@rjaini](https://github.com/rjaini))
- The resource group name in Azure providerID is not converted to lower cases. ([#74882](https://github.com/kubernetes/kubernetes/pull/74882), [@feiskyer](https://github.com/feiskyer))
- fix issue: fail to detach azure disk when there is server side error ([#74398](https://github.com/kubernetes/kubernetes/pull/74398), [@andyzhangx](https://github.com/andyzhangx))
- Fix subnet annotation checking for Azure internal loadbalancer ([#74498](https://github.com/kubernetes/kubernetes/pull/74498), [@feiskyer](https://github.com/feiskyer))
- fix mixed protocol issue for azure load balancer ([#74200](https://github.com/kubernetes/kubernetes/pull/74200), [@andyzhangx](https://github.com/andyzhangx))

### SIG API Machinery, SIG Architecture, SIG CLI, SIG Release, and SIG Testing

- kube-apiserver now serves OpenAPI specs for registered CRDs with defined  ([#71192](https://github.com/kubernetes/kubernetes/pull/71192), [@roycaihw](https://github.com/roycaihw))

### SIG Cluster Lifecycle, and SIG GCP

- Fix liveness probe in fluentd-gcp cluster addon ([#74522](https://github.com/kubernetes/kubernetes/pull/74522), [@Pluies](https://github.com/Pluies))
- Reduce GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#72062](https://github.com/kubernetes/kubernetes/pull/72062), [@jpbetz](https://github.com/jpbetz))

### SIG Azure, and SIG Storage

- fix parse devicePath issue on Azure Disk ([#74499](https://github.com/kubernetes/kubernetes/pull/74499), [@andyzhangx](https://github.com/andyzhangx))

### SIG Network, and SIG Node

- Fix the unexpected NotReady status when Node's iops is full if the runtime is dockershim. ([#74389](https://github.com/kubernetes/kubernetes/pull/74389), [@answer1991](https://github.com/answer1991))

### SIG API Machinery, and SIG Auth

- error messages returned in authentication webhook status responses are now correctly included in the apiserver log ([#73595](https://github.com/kubernetes/kubernetes/pull/73595), [@liggitt](https://github.com/liggitt))

### SIG Architecture, and SIG Auth

- The `rules` field in RBAC Role and ClusterRole objects is now correctly reported as optional in the openapi schema. ([#73250](https://github.com/kubernetes/kubernetes/pull/73250), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG Auth, SIG Node, SIG Scheduling, and SIG Testing

- A new `TaintNodesByCondition` admission plugin taints newly created Node objects as "not ready", to fix a race condition that could cause pods to be scheduled on new nodes before their taints were updated to accurately reflect their reported conditions. This admission plugin is enabled by default if the `TaintNodesByCondition` feature is enabled. ([#73097](https://github.com/kubernetes/kubernetes/pull/73097), [@bsalamat](https://github.com/bsalamat))

### SIG Storage, and SIG Testing

- The CSIPersistentVolume and KubeletPluginWatcher feature gates cannot be disabled, and will be removed in Kubernetes v1.16 ([#74830](https://github.com/kubernetes/kubernetes/pull/74830), [@msau42](https://github.com/msau42))

### SIG Cluster Lifecycle, and SIG Testing

- exit kube-proxy when configuration file changes ([#59176](https://github.com/kubernetes/kubernetes/pull/59176), [@dixudx](https://github.com/dixudx))
- kube-addon-manager was updated to v9.0, and now uses kubectl v1.13.2 and prunes workload resources via the apps/v1 API ([#72978](https://github.com/kubernetes/kubernetes/pull/72978), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG Auth, and SIG Testing

- Fixes use of webhook admission plugins with multi-version custom resources ([#74154](https://github.com/kubernetes/kubernetes/pull/74154), [@mbohlool](https://github.com/mbohlool))
- The /swagger.json and /swagger-2.0.0.pb-v1 schema documents, deprecated since v1.10, have been removed in favor of `/openapi/v2` ([#73148](https://github.com/kubernetes/kubernetes/pull/73148), [@liggitt](https://github.com/liggitt))

### SIG Release, and SIG Testing

- Update to use go1.12.1 ([#75413](https://github.com/kubernetes/kubernetes/pull/75413), [@BenTheElder](https://github.com/BenTheElder))
- --make-symlinks for hyperkube was marked hidden for a while, This flag is now deprecated and will be removed in a future release. ([#74975](https://github.com/kubernetes/kubernetes/pull/74975), [@dims](https://github.com/dims))
- Update to go1.11.5 ([#73326](https://github.com/kubernetes/kubernetes/pull/73326), [@ixdy](https://github.com/ixdy))

### SIG Node, SIG Storage, and SIG Testing

- Delay CSI client initialization to make reconstruction of CSI volume possible because clients may not be available on kubelet restart. ([#74652](https://github.com/kubernetes/kubernetes/pull/74652), [@cofyc](https://github.com/cofyc))

### SIG API Machinery, and SIG Testing

- Fix kube-apiserver not to create default/kubernetes service endpoints before it reports readiness via the /healthz and therefore is ready to serve requests. Also early during startup old endpoints are remove which might be left over from a previously crashed kube-apiserver. ([#74668](https://github.com/kubernetes/kubernetes/pull/74668), [@sttts](https://github.com/sttts))
- Add a configuration field to shorten the timeout of validating/mutating admission webhook call. The timeout value must be between 1 and 30 seconds. Default to 30 seconds when unspecified.  ([#74562](https://github.com/kubernetes/kubernetes/pull/74562), [@roycaihw](https://github.com/roycaihw))
- The apiserver, including both the kube-apiserver and apiservers built with the generic apiserver library, will now return 413 RequestEntityTooLarge error if a json patch contains more than 10,000 operations. ([#74000](https://github.com/kubernetes/kubernetes/pull/74000), [@caesarxuchao](https://github.com/caesarxuchao))
- fixes an error processing watch events when running skewed apiservers ([#73482](https://github.com/kubernetes/kubernetes/pull/73482), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG Apps, SIG Architecture, SIG Node, SIG Storage, and SIG Testing

- Extends the VolumeSubpathEnvExpansion alpha feature to support environment variable expansion ([#71351](https://github.com/kubernetes/kubernetes/pull/71351), [@kevtaylor](https://github.com/kevtaylor))

### SIG API Machinery, and SIG Windows

- windows: Ensure graceful termination when being run as windows service ([#73292](https://github.com/kubernetes/kubernetes/pull/73292), [@steffengy](https://github.com/steffengy))

### SIG API Machinery, and SIG Cloud Provider

- Considerably reduced the CPU load in kube-apiserver while aggregating OpenAPI specifications from aggregated API servers. ([#71223](https://github.com/kubernetes/kubernetes/pull/71223), [@sttts](https://github.com/sttts))

### SIG Node, and SIG Testing

- e2e tests that require SSH may be used against clusters that have nodes without external IP addresses by setting the environment variable `KUBE_SSH_BASTION` to the `host:port` of a machine that is allowed to SSH to those nodes.  The same private key that the test would use is used for the bastion host.  The test connects to the bastion and then tunnels another SSH connection to the node. ([#72286](https://github.com/kubernetes/kubernetes/pull/72286), [@smarterclayton](https://github.com/smarterclayton))
- PidPressure evicts pods from lowest priority to highest priority ([#72844](https://github.com/kubernetes/kubernetes/pull/72844), [@dashpole](https://github.com/dashpole))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Autoscaling, SIG CLI, SIG Cluster Lifecycle, SIG Storage, and SIG Testing

- client-go: the deprecated versionless API group accessors (like `clientset.Apps()` have been removed). Use an explicit version instead (like `clientset.AppsV1()`) ([#74422](https://github.com/kubernetes/kubernetes/pull/74422), [@liggitt](https://github.com/liggitt))

### SIG Azure, SIG Cloud Provider, and SIG Storage

- fix get azure accounts timeout issue when there is no out-bound IP ([#74191](https://github.com/kubernetes/kubernetes/pull/74191), [@andyzhangx](https://github.com/andyzhangx))

### SIG API Machinery, SIG Cluster Lifecycle, SIG Network, and SIG Windows

- Added kube-proxy support for overlay networking and DSR in Windows and new flags for network-name, source-vip, and enable-dsr. ([#70896](https://github.com/kubernetes/kubernetes/pull/70896), [@ksubrmnn](https://github.com/ksubrmnn))

### SIG Cloud Provider, SIG Storage, and SIG VMWare

- This change ensures that volumes get provisioned based on the zone information provided in allowedTopologies. ([#72731](https://github.com/kubernetes/kubernetes/pull/72731), [@skarthiksrinivas](https://github.com/skarthiksrinivas))

### SIG Node, SIG Scheduling, and SIG Testing

- Kubelet won't evict a static pod with priority `system-node-critical` upon resource pressure. ([#74222](https://github.com/kubernetes/kubernetes/pull/74222), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Cluster Lifecycle, SIG Node, and SIG Scalability

- kubelet: resolved hang/timeout issues when running large numbers of pods with unique configmap/secret references ([#74755](https://github.com/kubernetes/kubernetes/pull/74755), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle, and SIG Network

- Reduces the cache TTL for negative responses to 5s minimum. ([#74093](https://github.com/kubernetes/kubernetes/pull/74093), [@blakebarnett](https://github.com/blakebarnett))

### SIG Architecture, and SIG Node

- kubelet: OS and Arch information is now recorded in `kubernetes.io/os` and `kubernetes.io/arch` labels on Node objects. The previous labels (`beta.kubernetes.io/os` and `beta.kubernetes.io/arch`) are still recorded, but are deprecated and targeted for removal in 1.18. ([#73333](https://github.com/kubernetes/kubernetes/pull/73333), [@yujuhong](https://github.com/yujuhong))

### SIG API Machinery, and SIG Instrumentation

- This PR removes the following metrics: ([#74636](https://github.com/kubernetes/kubernetes/pull/74636), [@logicalhan](https://github.com/logicalhan))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, and SIG Testing

- Breaking changes in client-go: ([#72214](https://github.com/kubernetes/kubernetes/pull/72214), [@caesarxuchao](https://github.com/caesarxuchao))

### SIG API Machinery, SIG Apps, SIG Cloud Provider, and SIG Storage

- Remove the out-of-tree PersistentVolumeLabel controller because it cannot run without Initializers (removed in v1.14). If you are using AWS EBS, GCE PD, Azure Disk, Cinder Disk or vSphere volumes and rely on zone labels, then enable the `PersistentVolumeLabel` admission controller in the `kube-apiserver` in the `--enable-admission-plugins` flag.  ([#74615](https://github.com/kubernetes/kubernetes/pull/74615), [@andrewsykim](https://github.com/andrewsykim))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Scalability

- Scale max-inflight limits together with master VM sizes. ([#73268](https://github.com/kubernetes/kubernetes/pull/73268), [@wojtek-t](https://github.com/wojtek-t))

### SIG Auth, and SIG CLI

- Add `kubectl auth can-i --list` option which could help users know what actions they can do in specific namespace. ([#64820](https://github.com/kubernetes/kubernetes/pull/64820), [@WanLinghao](https://github.com/WanLinghao))

### SIG Apps, SIG Architecture, and SIG Storage

- Fixes a bug that prevented deletion of dynamically provisioned volumes in Quobyte backends. ([#68925](https://github.com/kubernetes/kubernetes/pull/68925), [@casusbelli](https://github.com/casusbelli))

### SIG Cluster Lifecycle, SIG GCP, SIG Instrumentation, and SIG Node

- the fluentd addon daemonset will now target all nodes. ([#74424](https://github.com/kubernetes/kubernetes/pull/74424), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG Architecture, and SIG CLI

- Deprecate --export flag from kubectl get command. ([#73787](https://github.com/kubernetes/kubernetes/pull/73787), [@soltysh](https://github.com/soltysh))

### SIG API Machinery, SIG Architecture, SIG CLI, and SIG Cluster Lifecycle

- kubeadm: fix a bug in the underlying library for diff related to characters like '%' ([#73941](https://github.com/kubernetes/kubernetes/pull/73941), [@neolit123](https://github.com/neolit123))

### SIG API Machinery, and SIG Scheduling

- Fix watch to not send the same set of events multiple times causing watcher to go back in time ([#73845](https://github.com/kubernetes/kubernetes/pull/73845), [@wojtek-t](https://github.com/wojtek-t))


## Notes from Individual SIGs

### SIG API Machinery

- Add mechanism for Admission Webhooks to specify which version of AdmissionReview they support ([#74998](https://github.com/kubernetes/kubernetes/pull/74998), [@mbohlool](https://github.com/mbohlool))
- The kube-apiserver OpenAPI definitions with the prefix "io.k8s.kubernetes.pkg" (deprecated since 1.9) have been removed. ([#74596](https://github.com/kubernetes/kubernetes/pull/74596), [@sttts](https://github.com/sttts))
- client-go: PortForwarder.GetPorts() now contain correct local port if no local port was initially specified when setting up the port forwarder ([#73676](https://github.com/kubernetes/kubernetes/pull/73676), [@martin-helmich](https://github.com/martin-helmich))
- Fixes an issue with missing apiVersion/kind in object data sent to admission webhooks ([#74448](https://github.com/kubernetes/kubernetes/pull/74448), [@liggitt](https://github.com/liggitt))
- export query parameter is deprecated and will be removed in a future release ([#73783](https://github.com/kubernetes/kubernetes/pull/73783), [@deads2k](https://github.com/deads2k))
- kube-apiserver now only aggregates openapi schemas from `/openapi/v2` endpoints of aggregated API servers. The fallback to aggregate from `/swagger.json` has been removed. Ensure aggregated API servers provide schema information via `/openapi/v2` (available since v1.10). ([#73441](https://github.com/kubernetes/kubernetes/pull/73441), [@roycaihw](https://github.com/roycaihw))
- Fix a bug that aggregated openapi spec may override swagger securityDefinitions and swagger info in kube-apiserver ([#73484](https://github.com/kubernetes/kubernetes/pull/73484), [@roycaihw](https://github.com/roycaihw))
- kube-apiserver: the deprecated `repair-malformed-updates` has been removed ([#73663](https://github.com/kubernetes/kubernetes/pull/73663), [@danielqsj](https://github.com/danielqsj))
- Prometheus metrics for crd_autoregister, crd_finalizer and crd_naming_condition_controller are exported. ([#71767](https://github.com/kubernetes/kubernetes/pull/71767), [@roycaihw](https://github.com/roycaihw))
- Fix admission metrics in seconds. ([#72343](https://github.com/kubernetes/kubernetes/pull/72343), [@danielqsj](https://github.com/danielqsj))
- When a watch is closed by an HTTP2 load balancer and we are told to go away, skip printing the message to stderr by default. ([#73277](https://github.com/kubernetes/kubernetes/pull/73277), [@smarterclayton](https://github.com/smarterclayton))
- jsonpath expressions containing `[start:end:step]` slice are now evaluated correctly ([#73149](https://github.com/kubernetes/kubernetes/pull/73149), [@liggitt](https://github.com/liggitt))
- metadata.deletionTimestamp is no longer moved into the future when issuing repeated DELETE requests against a resource containing a finalizer. ([#73138](https://github.com/kubernetes/kubernetes/pull/73138), [@liggitt](https://github.com/liggitt))

### SIG Apps

- Adds deleting pods created by DaemonSet assigned to not existing nodes. ([#73401](https://github.com/kubernetes/kubernetes/pull/73401), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))

### SIG Azure

- fix Azure Container Registry anonymous repo image pull error ([#74715](https://github.com/kubernetes/kubernetes/pull/74715), [@andyzhangx](https://github.com/andyzhangx))

### SIG CLI

- Fix panic in kubectl cp command ([#75037](https://github.com/kubernetes/kubernetes/pull/75037), [@soltysh](https://github.com/soltysh))
- Fix --help flag parsing  ([#74682](https://github.com/kubernetes/kubernetes/pull/74682), [@soltysh](https://github.com/soltysh))
- kubectl: fix a bug where "describe" cannot obtain the event messages for a static pod ([#74156](https://github.com/kubernetes/kubernetes/pull/74156), [@gaorong](https://github.com/gaorong))
- Fixed panic when performing a "set env" operation on a --local resource ([#65636](https://github.com/kubernetes/kubernetes/pull/65636), [@juanvallejo](https://github.com/juanvallejo))
- Missing directories listed in a user's PATH are no longer considered errors and are instead logged by the "kubectl plugin list" command when listing available plugins. ([#73542](https://github.com/kubernetes/kubernetes/pull/73542), [@juanvallejo](https://github.com/juanvallejo))
- Now users could get object info like: ([#73063](https://github.com/kubernetes/kubernetes/pull/73063), [@WanLinghao](https://github.com/WanLinghao))
- Remove deprecated args '--show-all' ([#69255](https://github.com/kubernetes/kubernetes/pull/69255), [@Pingan2017](https://github.com/Pingan2017))
- The "kubectl api-resources" command will no longer fail to display any resources on a single failure  ([#73035](https://github.com/kubernetes/kubernetes/pull/73035), [@juanvallejo](https://github.com/juanvallejo))
- kubectl loads config file once and uses persistent client config ([#71117](https://github.com/kubernetes/kubernetes/pull/71117), [@dixudx](https://github.com/dixudx))
- Print `SizeLimit` of `EmptyDir` in `kubectl describe pod` outputs. ([#69279](https://github.com/kubernetes/kubernetes/pull/69279), [@dtaniwaki](https://github.com/dtaniwaki))

### SIG Cloud Provider

- Fixed a bug that caused PV allocation on non-English vSphere installations to fail  ([#73115](https://github.com/kubernetes/kubernetes/pull/73115), [@alvaroaleman](https://github.com/alvaroaleman))

### SIG Cluster Lifecycle

- couldn't create a kubeconfig; the CA files couldn't be loaded: failed to load key: couldn't load the private key file /etc/kubernetes/pki/ca.key: open /etc/kubernetes/pki/ca.key: no such file or directory ([#75431](https://github.com/kubernetes/kubernetes/pull/75431), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: Allow certain certs/keys to be missing on the secret when transferring secrets using `--experimental-upload-certs` feature ([#75415](https://github.com/kubernetes/kubernetes/pull/75415), [@ereslibre](https://github.com/ereslibre))
- kubeadm: when calling "reset" on a control-plane node, remove the APIEndpoint information for this node from the ClusterStatus in the kubeadm ConfigMap. ([#75082](https://github.com/kubernetes/kubernetes/pull/75082), [@neolit123](https://github.com/neolit123))
- kubeadm: fixed nil pointer dereference caused by a bug in url parsing ([#74454](https://github.com/kubernetes/kubernetes/pull/74454), [@bart0sh](https://github.com/bart0sh))
- CoreDNS adds readinessProbe which prevents loadbalancing to unready pods, and also allows rolling updates to work as expected. ([#74137](https://github.com/kubernetes/kubernetes/pull/74137), [@rajansandeep](https://github.com/rajansandeep))
- kubeadm no longer allows using v1alpha3 configs for anything else than converting them to v1beta1. ([#74025](https://github.com/kubernetes/kubernetes/pull/74025), [@rosti](https://github.com/rosti))
- kubeadm: allow the usage of --kubeconfig-dir and --config flags on kubeadm init ([#73998](https://github.com/kubernetes/kubernetes/pull/73998), [@yagonobre](https://github.com/yagonobre))
- kubeadm: all master components are now exclusively relying on the `PriorityClassName` pod spec for annotating them as cluster critical components. Since `scheduler.alpha.kubernetes.io/critical-pod` annotation is no longer supported by Kubernetes 1.14 this annotation is no longer added to master components. ([#73857](https://github.com/kubernetes/kubernetes/pull/73857), [@ereslibre](https://github.com/ereslibre))
- kubeadm no longer dumps backtrace if it fails to remove the running containers on reset. ([#73951](https://github.com/kubernetes/kubernetes/pull/73951), [@rosti](https://github.com/rosti))
- kubeadm: `kubeadm alpha preflight` and `kubeadm alpha preflight node` are removed; you can now use `kubeadm join phase preflight` ([#73718](https://github.com/kubernetes/kubernetes/pull/73718), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm reset: fixed crash caused by absence of a configuration file ([#73636](https://github.com/kubernetes/kubernetes/pull/73636), [@bart0sh](https://github.com/bart0sh))
- CoreDNS is now version 1.3.1 ([#73610](https://github.com/kubernetes/kubernetes/pull/73610), [@rajansandeep](https://github.com/rajansandeep))
- kubeadm: When certificates are present joining a new control plane make sure that they match at least the required SANs ([#73093](https://github.com/kubernetes/kubernetes/pull/73093), [@ereslibre](https://github.com/ereslibre))
- kubeadm: add back `--cert-dir` option for `kubeadm init phase certs sa` ([#73239](https://github.com/kubernetes/kubernetes/pull/73239), [@mattkelly](https://github.com/mattkelly))
- kubeadm: explicitly wait for `etcd` to have grown when joining a new control plane ([#72984](https://github.com/kubernetes/kubernetes/pull/72984), [@ereslibre](https://github.com/ereslibre))
- kubeadm: pull images when joining a new control plane instance ([#72870](https://github.com/kubernetes/kubernetes/pull/72870), [@MalloZup](https://github.com/MalloZup))

### SIG Network

- kubeadm: improved RequiredIPVSKernelModulesAvailable warning message ([#74033](https://github.com/kubernetes/kubernetes/pull/74033), [@bart0sh](https://github.com/bart0sh))

### SIG Node

- Fix dockershim panic issues when deleting docker images. ([#75367](https://github.com/kubernetes/kubernetes/pull/75367), [@feiskyer](https://github.com/feiskyer))
- Kubelet no longer watches configmaps and secrets for terminated pods, in worst scenario causing it to not be able to send other requests to kube-apiserver ([#74809](https://github.com/kubernetes/kubernetes/pull/74809), [@oxddr](https://github.com/oxddr))
- Kubelet: replace `du` and `find` with a golang implementation ([#74675](https://github.com/kubernetes/kubernetes/pull/74675), [@dashpole](https://github.com/dashpole))
- Fixes panic if a kubelet is run against an older kube-apiserver ([#74529](https://github.com/kubernetes/kubernetes/pull/74529), [@liggitt](https://github.com/liggitt))
- Fix help message for --container-runtime-endpoint: only unix socket is support on Linux. ([#74712](https://github.com/kubernetes/kubernetes/pull/74712), [@feiskyer](https://github.com/feiskyer))
- Image garbage collection no longer fails for images with only one tag but more than one repository associated. ([#70647](https://github.com/kubernetes/kubernetes/pull/70647), [@corvus-ch](https://github.com/corvus-ch))
- kubelet's --containerized flag will no longer be supported and will be removed in a future release ([#74267](https://github.com/kubernetes/kubernetes/pull/74267), [@dims](https://github.com/dims))
- Re-issue Allocate grpc calls before starting a container that requests device-plugin resources if the cached state is missing. ([#73824](https://github.com/kubernetes/kubernetes/pull/73824), [@jiayingz](https://github.com/jiayingz))
- [CRI] Add a new field called `runtime_handler` into PodSandbox and PodSandboxStatus to track the RuntimeClass information of a pod. ([#73833](https://github.com/kubernetes/kubernetes/pull/73833), [@haiyanmeng](https://github.com/haiyanmeng))
- Kubelet now tries to stop containers in unknown state once before restart or remove. ([#73802](https://github.com/kubernetes/kubernetes/pull/73802), [@Random-Liu](https://github.com/Random-Liu))
- when pleg channel is full, discard events and record its count ([#72709](https://github.com/kubernetes/kubernetes/pull/72709), [@changyaowei](https://github.com/changyaowei))
- fix #73264 cpuPeriod was not reset, but used as set via flag, although it was disabled via alpha gate ([#73342](https://github.com/kubernetes/kubernetes/pull/73342), [@szuecs](https://github.com/szuecs))
- Update kubelet CLI summary documentation and generated Webpage ([#73256](https://github.com/kubernetes/kubernetes/pull/73256), [@deitch](https://github.com/deitch))
- Set a low oom_score_adj for containers in pods with system-critical priorities ([#73758](https://github.com/kubernetes/kubernetes/pull/73758), [@sjenning](https://github.com/sjenning))
- remove kubelet flag '--experimental-fail-swap-on' (deprecated in v1.8) ([#69552](https://github.com/kubernetes/kubernetes/pull/69552), [@Pingan2017](https://github.com/Pingan2017))
- remove stale OutOfDisk condition from kubelet side ([#72507](https://github.com/kubernetes/kubernetes/pull/72507), [@dixudx](https://github.com/dixudx))
- Fixes the setting of NodeAddresses when using the vSphere CloudProvider and nodes that have multiple IP addresses. ([#70805](https://github.com/kubernetes/kubernetes/pull/70805), [@danwinship](https://github.com/danwinship))

### SIG Scheduling

- fix the flake in scheduling_queue_test.go ([#74611](https://github.com/kubernetes/kubernetes/pull/74611), [@denkensk](https://github.com/denkensk))
- PriorityClass in scheduling.k8s.io/v1beta1 and scheduling.k8s.io/v1alpha1 are deprecated by PriorityClass scheduling.k8s.io/v1 and will not be served starting in v1.17. ([#74465](https://github.com/kubernetes/kubernetes/pull/74465), [@bsalamat](https://github.com/bsalamat))
- Don't update the Pod object after each scheduling attempt by adding a timestamp to the scheduling queue. ([#73700](https://github.com/kubernetes/kubernetes/pull/73700), [@denkensk](https://github.com/denkensk))
- scheduler: use incremental scheduling cycle in PriorityQueue to put all in-flight unschedulable pods back to active queue if we received move request ([#73309](https://github.com/kubernetes/kubernetes/pull/73309), [@cofyc](https://github.com/cofyc))
- scheduler: makes pod less racing so as to be put back into activeQ properly ([#73078](https://github.com/kubernetes/kubernetes/pull/73078), [@Huang-Wei](https://github.com/Huang-Wei))
- acquire lock before operating unschedulablepodsmap ([#73022](https://github.com/kubernetes/kubernetes/pull/73022), [@denkensk](https://github.com/denkensk))
- add goroutine to move unschedulable pods to activeq if they are not retried for more than 1 minute ([#72558](https://github.com/kubernetes/kubernetes/pull/72558), [@denkensk](https://github.com/denkensk))

### SIG Storage

- Update CSI version to 1.1 ([#75391](https://github.com/kubernetes/kubernetes/pull/75391), [@gnufied](https://github.com/gnufied))
- iscsi modules haven't even been loaded /sys/class/iscsi_host directory won't exist ([#74787](https://github.com/kubernetes/kubernetes/pull/74787), [@jianglingxia](https://github.com/jianglingxia))
- Fixed scanning of failed iSCSI targets. ([#74306](https://github.com/kubernetes/kubernetes/pull/74306), [@jsafrane](https://github.com/jsafrane))
- StorageOS volume plugin updated to fix an issue where volume mount succeeds even if request to mount via StorageOS API fails. ([#69782](https://github.com/kubernetes/kubernetes/pull/69782), [@darkowlzz](https://github.com/darkowlzz))
- Ensure directories on volumes are group-executable when using fsGroup ([#73533](https://github.com/kubernetes/kubernetes/pull/73533), [@mxey](https://github.com/mxey))

### SIG Testing

- e2e storage tests run faster and are easier to read ([#72434](https://github.com/kubernetes/kubernetes/pull/72434), [@pohly](https://github.com/pohly))
- Is ->It in line 6 ([#73898](https://github.com/kubernetes/kubernetes/pull/73898), [@xiezongzhe](https://github.com/xiezongzhe))
- e2e.test now rejects unknown --provider values instead of merely warning about them. An empty provider name is not accepted anymore and was replaced by "skeleton" (= a provider with no special behavior). ([#73402](https://github.com/kubernetes/kubernetes/pull/73402), [@pohly](https://github.com/pohly))

### SIG Windows

- fix smb unmount issue on Windows ([#75087](https://github.com/kubernetes/kubernetes/pull/75087), [@andyzhangx](https://github.com/andyzhangx))
- fix smb remount issue on Windows ([#73661](https://github.com/kubernetes/kubernetes/pull/73661), [@andyzhangx](https://github.com/andyzhangx))



