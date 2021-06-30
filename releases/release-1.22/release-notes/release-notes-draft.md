## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Audit log files are now created with a mode of 0600. Existing file permissions will not be changed. If you need the audit file to be readable by a non-root user, you can pre-create the file with the desired permissions. ([#95387](https://github.com/kubernetes/kubernetes/pull/95387), [@JAORMX](https://github.com/JAORMX)) [SIG API Machinery and Auth]
 - CSI migration of AWS EBS volumes requires AWS EBS CSI driver ver. 1.0 that supports `allowAutoIOPSPerGBIncrease` parameter in StorageClass. ([#101082](https://github.com/kubernetes/kubernetes/pull/101082), [@jsafrane](https://github.com/jsafrane))
 - Conformance image is now built with Distroless. Users running Conformance testing should rely on container entrypoint instead of manual invocation to `/run_e2e.sh` or `/gorunner`, as they are now deprecated and will be removed in 1.25 release. Invoking `ginkgo` and `e2e.test` are still supported through overriding entrypoint (docker) or defining container `spec.command` (kubernetes). ([#99178](https://github.com/kubernetes/kubernetes/pull/99178), [@wilsonehusin](https://github.com/wilsonehusin))
 - Default `StreamingProxyRedirects` to disabled. If there is a >= 2 version skew between master and nodes, and the old nodes were enabling `--redirect-container-streaming`, this will break them. In this case, the `StreamingProxyRedirects` can still be manually enabled. ([#101647](https://github.com/kubernetes/kubernetes/pull/101647), [@pacoxu](https://github.com/pacoxu))
 - Intree volume plugin scaleIO support has been completely removed from Kubernetes. ([#101685](https://github.com/kubernetes/kubernetes/pull/101685), [@Jiawei0227](https://github.com/Jiawei0227))
 - Kubeadm: remove the automatic detection and matching of cgroup drivers for Docker. For new clusters if you have not configured the cgroup driver explicitly you might get a failure in the `kubelet` on driver mismatch (kubeadm clusters should be using the `systemd` driver). Also remove the `IsDockerSystemdCheck` preflight check (warning) that checks if the Docker cgroup driver is set to `systemd`. Ideally such detection / coordination should be on the side of CRI implementers and the kubelet (tracked [here](https://github.com/kubernetes/kubernetes/issues/99808)). Please see the [page](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/) on how to configure cgroup drivers with kubeadm manually ([#99647](https://github.com/kubernetes/kubernetes/pull/99647), [@neolit123](https://github.com/neolit123))
 - Kubeadm: the flag --cri-socket is no longer allowed in a mixture with the flag --config. Please use the kubeadm configuration for setting the CRI socket for a node using {Init|Join}Configuration.nodeRegistration.criSocket. ([#101600](https://github.com/kubernetes/kubernetes/pull/101600), [@KofClubs](https://github.com/KofClubs)) [SIG Cluster Lifecycle]
 - Newly provisioned PVs by Azure disk will no longer have the beta `FailureDomain` label. Azure disk volume plugin will start to have GA topology label instead. ([#101534](https://github.com/kubernetes/kubernetes/pull/101534), [@kassarl](https://github.com/kassarl))
 - Scheduler's CycleState now embeds internal read/write locking inside its `Read()` and `Write()` functions. Meanwhile, `Lock()` and `Unlock()` function are removed. Scheduler plugin developers are now required to remove `CycleState#Lock()` and `CycleState#Unlock()`. Just simply use `Read()` and `Write()` as they're natively thread-safe now. ([#101542](https://github.com/kubernetes/kubernetes/pull/101542), [@Huang-Wei](https://github.com/Huang-Wei))
 - The `CSIMigrationVSphereComplete` feature flag is removed. `InTreePluginvSphereUnregister` will be the way moving forward. ([#101272](https://github.com/kubernetes/kubernetes/pull/101272), [@Jiawei0227](https://github.com/Jiawei0227))
 
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
- Deprecate --record flag in kubectl. The --record flag is being replaced with the mechanism from https://github.com/kubernetes/enhancements/tree/master/keps/sig-cli/859-kubectl-headers which annotates HTTP requests with kubectl command details. ([#102873](https://github.com/kubernetes/kubernetes/pull/102873), [@soltysh](https://github.com/soltysh)) [SIG CLI]
- E2e.test: removed the  `--viper-config` flag.  If you were previously using this to pass flags to `e2e.test` via a file, you will need to pass them directly on the command line, e.g. `e2e.test --e2e-output-dir` ([#102598](https://github.com/kubernetes/kubernetes/pull/102598), [@dims](https://github.com/dims)) [SIG Testing]
- For `kubeadm`: remove the ClusterStatus API from v1beta3 and its management in the kube-system/kubeadm-config ConfigMap. This method of keeping track of what API endpoints exists in the cluster was replaced (in a prior release) by a method to annotate the etcd Pods that `kubeadm` creates in "stacked etcd" clusters. The following CLI sub-phases are deprecated and are now a NO-OP: for `kubeadm join`: "control-plane-join/update-status", for `kubeadm reset`: "update-cluster-status". Unless you are using these phases explicitly, you should not be affected. ([#101915](https://github.com/kubernetes/kubernetes/pull/101915), [@neolit123](https://github.com/neolit123))
- Kubead: remove the deprecated `--csr-only` and `--csr-dir` flags from `kubeadm init phase certs`. Deprecate the same flags under `kubeadm certs renew`. In both the cases the command `kubeadm certs generate-csr` should be used instead. ([#102108](https://github.com/kubernetes/kubernetes/pull/102108), [@neolit123](https://github.com/neolit123))
- Kubeadm: Remove the deprecated command `kubeadm alpha kubeconfig`. Please use `kubeadm kubeconfig` instead. ([#101938](https://github.com/kubernetes/kubernetes/pull/101938), [@knight42](https://github.com/knight42))
- Kubeadm: Remove the deprecated hyperkube image support in `v1beta3`. This implies removal of `ClusterConfiguration.UseHyperKubeImage.` ([#101537](https://github.com/kubernetes/kubernetes/pull/101537), [@neolit123](https://github.com/neolit123))
- Kubeadm: Remove the field `ClusterConfiguration.DNS.Type` in v1beta3 since CoreDNS is the only supported DNS type. ([#101547](https://github.com/kubernetes/kubernetes/pull/101547), [@neolit123](https://github.com/neolit123))
- Kubeadm: remove the deprecated command 'kubeadm config view'. A replacement for this command is 'kubectl get cm -n kube-system kubeadm-config -o=jsonpath="{.data.ClusterConfiguration}"' ([#102071](https://github.com/kubernetes/kubernetes/pull/102071), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated flag '--image-pull-timeout' for 'kubeadm upgrade apply' command ([#102093](https://github.com/kubernetes/kubernetes/pull/102093), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated flag `--insecure-port` from the kube-apiserver manifest that kubeadm manages. The flag had no effect since 1.20, since the insecure serving of the component was disabled in the same version. ([#102121](https://github.com/kubernetes/kubernetes/pull/102121), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: remove the deprecated kubeadm API `v1beta1`. Introduce a new kubeadm API `v1beta3`. See [kubeadm/v1beta3](https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta3) for a list of changes since `v1beta2`. Note that `v1beta2` is not yet deprecated, but will be in a future release. ([#101129](https://github.com/kubernetes/kubernetes/pull/101129), [@neolit123](https://github.com/neolit123))
- Newly provisioned PVs by vSphere in-tree plugin will no longer have the beta FailureDomain label. vSphere volume plugin will start to have GA topology label instead. ([#102414](https://github.com/kubernetes/kubernetes/pull/102414), [@divyenpatel](https://github.com/divyenpatel)) [SIG Cloud Provider, Storage and Testing]
- Removal of the CSI `NodePublish` path by the kubelet is deprecated. This must be done by the CSI plugin according to the CSI spec. ([#101441](https://github.com/kubernetes/kubernetes/pull/101441), [@dobsonj](https://github.com/dobsonj))
- Remove support for the Service `topologyKeys` field (alpha) and the `kube-proxy` implementation of it. This field was deprecated several cycles ago. This functionality is replaced by the combination of automatic topology hints per-endpoint (alpha) and the Service `internalTrafficPolicy` field (alpha). ([#102412](https://github.com/kubernetes/kubernetes/pull/102412), [@andrewsykim](https://github.com/andrewsykim))
- The `PodUnknown` phase is now deprecated. ([#95286](https://github.com/kubernetes/kubernetes/pull/95286), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- The `storageos`, `quobyte` and `flocker` storage volume plugins are deprecated and will be removed in a later release. ([#101773](https://github.com/kubernetes/kubernetes/pull/101773), [@Jiawei0227](https://github.com/Jiawei0227))
- The deprecated flag --hard-pod-affinity-symmetric-weight and --scheduler-name have been removed from kube-scheduler. Use ComponentConfig instead to configure those parameters. ([#102805](https://github.com/kubernetes/kubernetes/pull/102805), [@ahg-g](https://github.com/ahg-g)) [SIG Scheduling]
- The ingress `v1beta1` has been deprecated. ([#102030](https://github.com/kubernetes/kubernetes/pull/102030), [@aojea](https://github.com/aojea))

### API Change

- A value of `Auto` is now a valid for the `service.kubernetes.io/topology-aware-hints` annotation. ([#100728](https://github.com/kubernetes/kubernetes/pull/100728), [@robscott](https://github.com/robscott))
- Add a new Priority and Fairness rule that exempts all probes (`/readyz`, `/healthz`, `/livez`) to prevent restarting of healthy `kube-apiserver` instance by kubelet. ([#100678](https://github.com/kubernetes/kubernetes/pull/100678), [@tkashem](https://github.com/tkashem))
- Add alpha support for HostProcess containers on Windows ([#99576](https://github.com/kubernetes/kubernetes/pull/99576), [@marosset](https://github.com/marosset)) [SIG API Machinery, Apps, Node, Testing and Windows]
- Add three metrics to the job controller to monitor if a job works in healthy condition.
  `IndexedJob` has been promoted to Beta. ([#101292](https://github.com/kubernetes/kubernetes/pull/101292), [@AliceZhang2016](https://github.com/AliceZhang2016))
- Because of the implementation logic of time.Format in golang, the displayed time zone is not consistent ([#102366](https://github.com/kubernetes/kubernetes/pull/102366), [@cndoit18](https://github.com/cndoit18)) [SIG Apps, Auth, Autoscaling, CLI, Cluster Lifecycle, Instrumentation, Network, Node and Testing]
- Corrected the documentation for escaping dollar signs in a container's env, command and args property. ([#101916](https://github.com/kubernetes/kubernetes/pull/101916), [@MartinKanters](https://github.com/MartinKanters)) [SIG Apps]
- Enable `MaxSurge` for `DaemonSet` by default. ([#101742](https://github.com/kubernetes/kubernetes/pull/101742), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Endpoint slices mirroring controller no longer mirrors the last-applied-configuration annotation created by kubectl to updated endpoint slices ([#102731](https://github.com/kubernetes/kubernetes/pull/102731), [@sharmarajdaksh](https://github.com/sharmarajdaksh)) [SIG API Machinery, Apps, Cloud Provider, Network, Release, Scheduling, Storage and Testing]
- Exec plugin authors can override default handling of standard input via new interactiveMode kubeconfig field ([#99310](https://github.com/kubernetes/kubernetes/pull/99310), [@ankeesler](https://github.com/ankeesler)) [SIG API Machinery, Auth, CLI and Testing]
- Introduce `minReadySeconds` api to the `StatefulSets`. ([#100842](https://github.com/kubernetes/kubernetes/pull/100842), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Kube-apiserver: `--service-account-issuer` can be specified multiple times now, to enable non-disruptive change of issuer. ([#101155](https://github.com/kubernetes/kubernetes/pull/101155), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth, Node and Testing]
- Kube-controller-manager: the `--horizontal-pod-autoscaler-use-rest-clients` flag and Heapster support in the horizontal pod autoscaler, deprecated since 1.12, is removed. ([#90368](https://github.com/kubernetes/kubernetes/pull/90368), [@serathius](https://github.com/serathius))
- Kube-scheduler component config v1beta2 API available
  Three scheduler plugins deprecated (NodeLabel, ServiceAffinity, NodePreferAvoidPods) ([#99597](https://github.com/kubernetes/kubernetes/pull/99597), [@adtac](https://github.com/adtac)) [SIG Scheduling]
- Network Policy EndPort is graduated to beta and is enabled by default ([#102834](https://github.com/kubernetes/kubernetes/pull/102834), [@rikatz](https://github.com/rikatz)) [SIG Network]
- New `node-high` priority-level has been added to Suggested API Priority and ([#101151](https://github.com/kubernetes/kubernetes/pull/101151), [@mborsz](https://github.com/mborsz))
- Omit comparison with boolean constant ([#101523](https://github.com/kubernetes/kubernetes/pull/101523), [@chuntaochen](https://github.com/chuntaochen)) [SIG CLI and Cloud Provider]
- Server Side Apply now treats all <Some>Selector fields as atomic (meaning the entire selector is managed by a single writer and updated together), since they contain interrelated and inseparable fields that do not merge in intuitive ways. ([#97989](https://github.com/kubernetes/kubernetes/pull/97989), [@Danil-Grigorev](https://github.com/Danil-Grigorev)) [SIG API Machinery]
- The `PodDeletionCost` feature has been promoted to beta, and enabled by default. ([#101080](https://github.com/kubernetes/kubernetes/pull/101080), [@ahg-g](https://github.com/ahg-g))
- The `Server Side Apply` treats certain structs as atomic. Meaning the entire selector field is managed by a single writer and updated together. ([#100684](https://github.com/kubernetes/kubernetes/pull/100684), [@Jefftree](https://github.com/Jefftree))
- The `pod/eviction` subresource now accepts `policy/v1` eviction requests in addition to `policy/v1beta1` eviction requests ([#100724](https://github.com/kubernetes/kubernetes/pull/100724), [@liggitt](https://github.com/liggitt))
- The `podAffinity`, `NamespaceSelector` and the associated `CrossNamespaceAffinity` quota scope features graduate to Beta and they are now enabled by default. ([#101496](https://github.com/kubernetes/kubernetes/pull/101496), [@ahg-g](https://github.com/ahg-g))
- The `pods/ephemeralcontainers` API now returns and expects a `Pod` object instead of `EphemeralContainers`. This is incompatible with the previous alpha-level API. ([#101034](https://github.com/kubernetes/kubernetes/pull/101034), [@verb](https://github.com/verb)) [SIG Apps, Auth, CLI and Testing]
- The `v1.Node` and `.status.images[].names` are  now optional. ([#102159](https://github.com/kubernetes/kubernetes/pull/102159), [@roycaihw](https://github.com/roycaihw))
- The deprecated flag `--algorithm-provider` has been removed from `kube-scheduler`. Use instead `ComponentConfig` to configure the set of enabled plugins. ([#102239](https://github.com/kubernetes/kubernetes/pull/102239), [@Haleygo](https://github.com/Haleygo))
- The options `--ssh-user` and `--ssh-key` are removed. They only functioned on GCE, and only in-tree. Use the apiserver network proxy instead. ([#102297](https://github.com/kubernetes/kubernetes/pull/102297), [@deads2k](https://github.com/deads2k))
- Track ownership of scale subresource for all scalable resources i.e. Deployment, ReplicaSet, StatefulSet, ReplicationController, and Custom Resources. ([#98377](https://github.com/kubernetes/kubernetes/pull/98377), [@nodo](https://github.com/nodo)) [SIG API Machinery and Testing]

### Feature

- A `system-cluster-critical` pod should not get a low OOM Score. 
  
  As of now both `system-node-critical` and `system-cluster-critical` pods have -997 OOM score, making them one of the last processes to be OOMKilled. By definition `system-cluster-critical` pods can be scheduled elsewhere if there is a resource crunch on the node where as `system-node-critical` pods cannot be rescheduled. This was the reason for `system-node-critical` to have higher priority value than `system-cluster-critical`.  This change allows only `system-node-critical` priority class to have low OOMScore.
  
  action required
  If the user wants to have the pod to be OOMKilled last and the pod has `system-cluster-critical` priority class, it has to be changed to `system-node-critical` priority class to preserve the existing behavior ([#99729](https://github.com/kubernetes/kubernetes/pull/99729), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- A new metric apiserver_flowcontrol_request_concurrency_in_use that shows the number of
  seats (concurrency) occupied by the currently executing requests in the API Priority and Fairness system ([#102795](https://github.com/kubernetes/kubernetes/pull/102795), [@tkashem](https://github.com/tkashem)) [SIG API Machinery and Instrumentation]
- Add a namespace label for all apiserver_admission_* metrics.
  - Expand the histogram range to 0-10s for all apiserver_admission_*_duration_seconds metrics. ([#101208](https://github.com/kubernetes/kubernetes/pull/101208), [@voutcn](https://github.com/voutcn)) [SIG API Machinery and Instrumentation]
- Added BinaryData description to `kubectl describe` command. ([#100568](https://github.com/kubernetes/kubernetes/pull/100568), [@lauchokyip](https://github.com/lauchokyip))
- Adds two kubemark flags, `--max-pods` and `--extended-resources`. ([#100267](https://github.com/kubernetes/kubernetes/pull/100267), [@Jeffwan](https://github.com/Jeffwan))
- An audit log entry will be generated when a `ValidatingAdmissionWebhook` is failing open. ([#92739](https://github.com/kubernetes/kubernetes/pull/92739), [@cnphil](https://github.com/cnphil))
- Base images: Updated to
  - debian-base:buster-v1.6.0
  - debian-iptables:buster-v1.6.0 ([#100976](https://github.com/kubernetes/kubernetes/pull/100976), [@jindijamie](https://github.com/jindijamie))
- Base-images: Update to debian-base:buster-v1.7.1 ([#102594](https://github.com/kubernetes/kubernetes/pull/102594), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG API Machinery and Release]
- Feat: change parittion style to GPT on Windows ([#101412](https://github.com/kubernetes/kubernetes/pull/101412), [@andyzhangx](https://github.com/andyzhangx)) [SIG Storage and Windows]
- Fluentd: isolate logging resources in separate namespace `logging` ([#68004](https://github.com/kubernetes/kubernetes/pull/68004), [@saravanan30erd](https://github.com/saravanan30erd))
- For `kubeadm`: add `--validity-period` flag for `kubeadm kubeconfig user` command. ([#100907](https://github.com/kubernetes/kubernetes/pull/100907), [@SataQiu](https://github.com/SataQiu))
- Implement minReadySeconds for the StatefulSets. ([#101316](https://github.com/kubernetes/kubernetes/pull/101316), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps and Testing]
- Improve logging of APIService availability changes in kube-apiserver. ([#101420](https://github.com/kubernetes/kubernetes/pull/101420), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- Introduce a feature gate `DisableCloudProviders` allowing to disable cloud-provider initialization in KAPI, KCM and kubelet.
  `DisableCloudProviders` FeatureGate is currently in Alpha, which means is currently disabled by default. Once the FeatureGate moves to beta, in-tree cloud providers would be disabled by default, and a user won't be able to specify `--cloud-provider=<aws|openstack|azure|gcp|vsphere>` anymore to any of KCM, KAPI or kubelet. Only a '--cloud-provider=external' would be allowed. CCM would have to run out-of-tree with CSI. ([#100136](https://github.com/kubernetes/kubernetes/pull/100136), [@Danil-Grigorev](https://github.com/Danil-Grigorev))
- Kubeadm: Set the `seccompProfile` to `runtime/default` in the `PodSecurityContext` of the control-plane components that run as static Pods. ([#100234](https://github.com/kubernetes/kubernetes/pull/100234), [@vinayakankugoyal](https://github.com/vinayakankugoyal))
- Kubeadm: add a new field `skipPhases` to `v1beta3` `InitConfiguration` and `JoinConfiguration` that can contain a list of phases to skip during "kubeadm init" and "kubeadm join". The flag "--skip-phases" takes precedence over this field. ([#101923](https://github.com/kubernetes/kubernetes/pull/101923), [@neolit123](https://github.com/neolit123))
- Kubeadm: add the "--dry-run" flag to the "control-plane" phase of "kubeadm init" ([#102722](https://github.com/kubernetes/kubernetes/pull/102722), [@vinayakankugoyal](https://github.com/vinayakankugoyal)) [SIG Cluster Lifecycle]
- Kubeadm: add the "imagePullPolicy" field in the "nodeRegistration" section of InitConfiguration and JoinConfiguration in v1beta3. This allows the user to specify the image pull policy during "kubeadm init" and "kubeadm join". The value of this field must be one of "Always", "IfNotPresent" or "Never". The default behavior continues to be "IfNotPresent". ([#102901](https://github.com/kubernetes/kubernetes/pull/102901), [@wangyysde](https://github.com/wangyysde)) [SIG Cluster Lifecycle]
- Kubeadm: add the RootlessControlPlane kubeadm specific feature gate (Alpha in 1.22, disabled by default).
  It can be used to enable an experimental feature that makes the control plane component static Pod containers 
  for kube-apiserver, kube-controller-manager, kube-scheduler and etcd to run as a non-root users. ([#102158](https://github.com/kubernetes/kubernetes/pull/102158), [@vinayakankugoyal](https://github.com/vinayakankugoyal)) [SIG Cluster Lifecycle]
- Kubeadm: during "kubeadm init/join/upgrade", always default the `cgroupDriver` value in the `KubeletConfiguration` to `systemd`, unless the user was explicit about the value. See [configure-cgroup-driver](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/) for more details. ([#102133](https://github.com/kubernetes/kubernetes/pull/102133), [@pacoxu](https://github.com/pacoxu))
- Kubeadm: update CoreDNS to 1.8.4. Grant CoreDNS permissions to "list" and "watch" EndpointSlice objects to accommodate dual-stack support. ([#102466](https://github.com/kubernetes/kubernetes/pull/102466), [@pacoxu](https://github.com/pacoxu)) [SIG Cluster Lifecycle]
- Kubectl: add `LAST RESTART` column to `kubectl get pods` output. ([#100142](https://github.com/kubernetes/kubernetes/pull/100142), [@Ethyling](https://github.com/Ethyling))
- Kubemark's hollow-node will now print flags before starting. ([#101181](https://github.com/kubernetes/kubernetes/pull/101181), [@mm4tt](https://github.com/mm4tt))
- Kubernetes is now built with Golang 1.16.3 ([#101206](https://github.com/kubernetes/kubernetes/pull/101206), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.16.4 ([#101809](https://github.com/kubernetes/kubernetes/pull/101809), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Kubernetes is now built with Golang 1.16.5 ([#102689](https://github.com/kubernetes/kubernetes/pull/102689), [@cpanato](https://github.com/cpanato)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Leader Migration now support a wildcard component name and the default value. ([#102711](https://github.com/kubernetes/kubernetes/pull/102711), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery and Cloud Provider]
- Metrics server nanny has now poll period set to 30s (previously 5 minutes) to allow faster scaling of metrics server. ([#101869](https://github.com/kubernetes/kubernetes/pull/101869), [@olagacek](https://github.com/olagacek)) [SIG Cloud Provider and Instrumentation]
- NetworkPolicy validation framework support for windows. ([#98077](https://github.com/kubernetes/kubernetes/pull/98077), [@jayunit100](https://github.com/jayunit100))
- New feature gate `ExpandedDNSConfig` is now available. This feature allows Kubernetes to have expanded DNS configuration. ([#100651](https://github.com/kubernetes/kubernetes/pull/100651), [@gjkim42](https://github.com/gjkim42))
- New metrics: `apiserver_kube_aggregator_x509_missing_san_total` and `apiserver_webhooks_x509_missing_san_total`. This metric measures a number of connections to webhooks/aggregated API servers that use certificates without Subject Alternative Names. It being non-zero is a warning sign that these connections will stop functioning in the future since Golang is going to deprecate x509 certificate subject Common Names for server hostname verification. ([#95396](https://github.com/kubernetes/kubernetes/pull/95396), [@stlaz](https://github.com/stlaz)) [SIG API Machinery, Auth and Instrumentation]
- Node Problem Detector is now available for GCE Windows nodes. ([#101539](https://github.com/kubernetes/kubernetes/pull/101539), [@jeremyje](https://github.com/jeremyje)) [SIG Cloud Provider, Node and Windows]
- Promote Cronjobs storage version to `batch/v1`. ([#102363](https://github.com/kubernetes/kubernetes/pull/102363), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Promote `CronJobControllerV2` flag to GA, with removal in 1.23. ([#102529](https://github.com/kubernetes/kubernetes/pull/102529), [@soltysh](https://github.com/soltysh))
- Run etcd as non-root on GCE provider' ([#100635](https://github.com/kubernetes/kubernetes/pull/100635), [@cindy52](https://github.com/cindy52)) [SIG Cloud Provider]
- Secret values are now masked by default in kubectl diff output. ([#96084](https://github.com/kubernetes/kubernetes/pull/96084), [@loozhengyuan](https://github.com/loozhengyuan)) [SIG CLI]
- SetHostnameAsFQDN has been graduated to GA, which means feature cannot be disabled using a feature gate. ([#101294](https://github.com/kubernetes/kubernetes/pull/101294), [@javidiaz](https://github.com/javidiaz)) [SIG Node]
- Some of the in-tree storage drivers indicate support for the `MetricsProvider` interface, but fail to configure this for BlockMode volumes. With a recent change, `Kubelet` will call `GetMetrics()` for BlockMode volumes, and the in-tree drivers that miss the support cause a Go panic. Now the in-tree storage drivers that support BlockMode volumes, will return the Capacity of the volume in the `GetMetrics()` call. ([#101587](https://github.com/kubernetes/kubernetes/pull/101587), [@nixpanic](https://github.com/nixpanic))
- Support `FakeClientset` match subresource. ([#100939](https://github.com/kubernetes/kubernetes/pull/100939), [@wzshiming](https://github.com/wzshiming))
- The `BoundServiceAccountTokenVolume` graduates to GA and thus will be unconditionally enabled. The feature gate is going to be removed in 1.23. ([#101992](https://github.com/kubernetes/kubernetes/pull/101992), [@zshihang](https://github.com/zshihang))
- The `EmptyDir` memory backed volumes are sized as the the minimum of pod allocatable memory on a host and an optional explicit user provided value. ([#101048](https://github.com/kubernetes/kubernetes/pull/101048), [@dims](https://github.com/dims))
- The `NamespaceDefaultLabelName` is promoted to GA in this release. All Namespace API objects have a `kubernetes.io/metadata.name` label matching their `metadata.name` field to allow selecting any `namespace` by its name using a label selector. ([#101342](https://github.com/kubernetes/kubernetes/pull/101342), [@rosenhouse](https://github.com/rosenhouse))
- The `WarningHeader` feature is now GA and is unconditionally enabled. The `apiserver_requested_deprecated_apis` metric has graduated to stable status. The `WarningHeader` feature-gate is no longer operative and will be removed in v1.24. ([#100754](https://github.com/kubernetes/kubernetes/pull/100754), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Instrumentation and Testing]
- The feature gate `SSA` graduated to GA in v1.22 and therefore is unconditionally enabled. ([#100139](https://github.com/kubernetes/kubernetes/pull/100139), [@Jefftree](https://github.com/Jefftree))
- The job controller removes running pods when the number of completions is achieved. ([#99963](https://github.com/kubernetes/kubernetes/pull/99963), [@alculquicondor](https://github.com/alculquicondor))
- The kubeconfig is now exposed in `the kube-scheduler` framework handle. Out-of-tree plugins can leverage that to build CRD informers easily. ([#100644](https://github.com/kubernetes/kubernetes/pull/100644), [@Huang-Wei](https://github.com/Huang-Wei))
- The new flag `--chunk-size=SIZE` for `kubectl drain` has been promoted to beta, and enabled by default. This flag  may be used to alter the number of items or disable this feature when `0` is passed. ([#100148](https://github.com/kubernetes/kubernetes/pull/100148), [@KnVerey](https://github.com/KnVerey))
- The new flag `--chunk-size=SIZE` has been added to `kubectl describe`. This flag may be used to alter the number of items or disable this feature when `0` is passed. ([#101171](https://github.com/kubernetes/kubernetes/pull/101171), [@KnVerey](https://github.com/KnVerey))
- The pod resource API will provide memory manager metrics in the case when the memory manager feature gate enabled and the memory manager policy is static. ([#101030](https://github.com/kubernetes/kubernetes/pull/101030), [@cynepco3hahue](https://github.com/cynepco3hahue)) [SIG Node and Testing]
- The prefer nominated node graduates to Beta and enabld by default. ([#102201](https://github.com/kubernetes/kubernetes/pull/102201), [@chendave](https://github.com/chendave))
- Update etcd version to 3.5.0-beta.3 ([#102062](https://github.com/kubernetes/kubernetes/pull/102062), [@serathius](https://github.com/serathius)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- Update the Debian images to pick up CVE fixes in the base images:
  - Update the `debian-base` image to v1.7.0
  - Update the `debian-iptables` image to v1.6.1 ([#102302](https://github.com/kubernetes/kubernetes/pull/102302), [@xmudrii](https://github.com/xmudrii))
- Update the setcap image to buster-v2.0.1. ([#102377](https://github.com/kubernetes/kubernetes/pull/102377), [@xmudrii](https://github.com/xmudrii))
- Warnings for the use of deprecated and known-bad values in pod specs are now sent. ([#101688](https://github.com/kubernetes/kubernetes/pull/101688), [@liggitt](https://github.com/liggitt))
- Watch requests are now handled throttled by priority and fairness filter in `kube-apiserver`. ([#102171](https://github.com/kubernetes/kubernetes/pull/102171), [@wojtek-t](https://github.com/wojtek-t))
- You can use this Builder function to create events Field Selector ([#101817](https://github.com/kubernetes/kubernetes/pull/101817), [@cndoit18](https://github.com/cndoit18)) [SIG API Machinery and Scalability]
- `Scheduler` now registers event handlers dynamically. ([#101394](https://github.com/kubernetes/kubernetes/pull/101394), [@Huang-Wei](https://github.com/Huang-Wei))
- `kubectl`: Enable using protocol buffers to request Metrics API. ([#102039](https://github.com/kubernetes/kubernetes/pull/102039), [@serathius](https://github.com/serathius))

### Failing Test

- Fixed generic ephemeal volumes with `OwnerReferencesPermissionEnforcement` admission plugin enabled. ([#101186](https://github.com/kubernetes/kubernetes/pull/101186), [@jsafrane](https://github.com/jsafrane))
- Fixes `kubectl drain --dry-run=server`. ([#100206](https://github.com/kubernetes/kubernetes/pull/100206), [@KnVerey](https://github.com/KnVerey))
- Fixes an overly restrictive conformance test to accept service account tokens signed by an ECDSA key ([#100680](https://github.com/kubernetes/kubernetes/pull/100680), [@smira](https://github.com/smira)) [SIG Architecture, Auth and Testing]
- Fixes the `should receive events on concurrent watches in same order` conformance test to work properly on clusters that auto-create additional configmaps in namespaces. ([#101950](https://github.com/kubernetes/kubernetes/pull/101950), [@liggitt](https://github.com/liggitt))
- Resolves an issue with the "ServiceAccountIssuerDiscovery should support OIDC discovery" conformance test failing on clusters which are configured with issuers outside the cluster ([#101589](https://github.com/kubernetes/kubernetes/pull/101589), [@mtaufen](https://github.com/mtaufen)) [SIG Auth and Testing]

### Bug or Regression

- Added jitter factor to lease controller that better smears load on kube-apiserver over time. ([#101652](https://github.com/kubernetes/kubernetes/pull/101652), [@marseel](https://github.com/marseel)) [SIG API Machinery and Scalability]
- Added privileges for `EndpointSlice` to the default view & edit RBAC roles. ([#101203](https://github.com/kubernetes/kubernetes/pull/101203), [@mtougeron](https://github.com/mtougeron))
- After DBus restarts, make GracefulNodeShutdown work again ([#100369](https://github.com/kubernetes/kubernetes/pull/100369), [@wzshiming](https://github.com/wzshiming)) [SIG Node and Testing]
- Aggregate errors when putting vmss. ([#98350](https://github.com/kubernetes/kubernetes/pull/98350), [@nilo19](https://github.com/nilo19))
- Aggregate write permissions on events to edit and admin role ([#102858](https://github.com/kubernetes/kubernetes/pull/102858), [@tumido](https://github.com/tumido)) [SIG Auth]
- Applying fix for not deleting existing public IP when a service is deleted in Azure. ([#100694](https://github.com/kubernetes/kubernetes/pull/100694), [@nilo19](https://github.com/nilo19))
- Applying fix for not tagging static public IP. ([#101752](https://github.com/kubernetes/kubernetes/pull/101752), [@nilo19](https://github.com/nilo19))
- Applying fix so that deleting non-existing disk returns success. ([#102083](https://github.com/kubernetes/kubernetes/pull/102083), [@andyzhangx](https://github.com/andyzhangx))
- Applying fix: cleanup outdated routes. ([#102935](https://github.com/kubernetes/kubernetes/pull/102935), [@nilo19](https://github.com/nilo19))
- Avoid caching the Azure VMSS instances whose network profile is nil ([#100948](https://github.com/kubernetes/kubernetes/pull/100948), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Azure: Avoid setting cached Sku when updating VMSS and VMSS instances. ([#102005](https://github.com/kubernetes/kubernetes/pull/102005), [@feiskyer](https://github.com/feiskyer))
- Azurefile: Normalize share name to not include the capital letters ([#100731](https://github.com/kubernetes/kubernetes/pull/100731), [@kassarl](https://github.com/kassarl))
- Chain the field manager creation calls in `newDefaultFieldManager` to be explicit about the order of operations. ([#101076](https://github.com/kubernetes/kubernetes/pull/101076), [@kevindelgado](https://github.com/kevindelgado))
- Changed the Graceful Node Shutdown Pod termination reason and message.
  Changed the Graceful Node Shutdown Pod rejection reason and message. ([#102840](https://github.com/kubernetes/kubernetes/pull/102840), [@Kissy](https://github.com/Kissy)) [SIG Node]
- Ensure service is deleted when the Azure resource group has been deleted. ([#100944](https://github.com/kubernetes/kubernetes/pull/100944), [@feiskyer](https://github.com/feiskyer))
- Ensures `ExecProbeTimeout=false` kubelet feature gate with dockershim is taken into account, when the exec probe takes longer than `timeoutSeconds` configuration. ([#100200](https://github.com/kubernetes/kubernetes/pull/100200), [@jackfrancis](https://github.com/jackfrancis))
- Expose `rest_client_rate_limiter_duration_seconds` metric to component-base to track client side rate limiter latency in seconds. Broken down by verb and URL. ([#100311](https://github.com/kubernetes/kubernetes/pull/100311), [@IonutBajescu](https://github.com/IonutBajescu)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Fire an event when failing to open `NodePort`. ([#100599](https://github.com/kubernetes/kubernetes/pull/100599), [@masap](https://github.com/masap))
- Fix Azure node public IP fetching issues from instance metadata service when the node is part of standard load balancer backend pool. ([#100690](https://github.com/kubernetes/kubernetes/pull/100690), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix EndpointSlice describe panic when an Endpoint doesn't have zone ([#101025](https://github.com/kubernetes/kubernetes/pull/101025), [@tnqn](https://github.com/tnqn)) [SIG CLI]
- Fix `kubectl set env` or `resources` not working for initcontainers. ([#101669](https://github.com/kubernetes/kubernetes/pull/101669), [@carlory](https://github.com/carlory))
- Fix a bug on the endpoint slices mirroring controller where endpoint `NotReadyAddresses` were mirrored as Ready to the corresponding `EndpointSlice`. ([#102683](https://github.com/kubernetes/kubernetes/pull/102683), [@aojea](https://github.com/aojea))
- Fix a bug that a preemptor pod may exist as a phantom in the scheduler. ([#102498](https://github.com/kubernetes/kubernetes/pull/102498), [@Huang-Wei](https://github.com/Huang-Wei))
- Fix an issue with `kubectl` on certain older version of Windows or when legacy console mode is enabled on Windows 8 which causes `kubectl exec` to crash. ([#102825](https://github.com/kubernetes/kubernetes/pull/102825), [@n4j](https://github.com/n4j))
- Fix availability set cache in vmss cache ([#100110](https://github.com/kubernetes/kubernetes/pull/100110), [@CecileRobertMichon](https://github.com/CecileRobertMichon)) [SIG Cloud Provider]
- Fix how nulls are handled in array and objects in [json patches](https://github.com/evanphx/json-patch). ([#102467](https://github.com/kubernetes/kubernetes/pull/102467), [@pacoxu](https://github.com/pacoxu))
- Fix panic when `kubectl create ingress` has annotation flag and an empty value set. ([#101377](https://github.com/kubernetes/kubernetes/pull/101377), [@rikatz](https://github.com/rikatz))
- Fix raw block mode CSI `NodePublishVolume` stage miss pod info. ([#99069](https://github.com/kubernetes/kubernetes/pull/99069), [@phantooom](https://github.com/phantooom))
- Fix resource enforcement when using systemd cgroup driver ([#102147](https://github.com/kubernetes/kubernetes/pull/102147), [@kolyshkin](https://github.com/kolyshkin))
- Fix rounding of volume storage requests. ([#100100](https://github.com/kubernetes/kubernetes/pull/100100), [@maxlaverse](https://github.com/maxlaverse))
- Fix runtime container status for post start hook error. ([#100608](https://github.com/kubernetes/kubernetes/pull/100608), [@pacoxu](https://github.com/pacoxu))
- Fix scoring for NodeResourcesMostAllocated and NodeResourcesBalancedAllocation plugins when nodes have containers with no requests. This was leaving to under-utilization of small nodes. ([#102925](https://github.com/kubernetes/kubernetes/pull/102925), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix: Azure file inline volume namespace issue in CSI migration translation ([#101235](https://github.com/kubernetes/kubernetes/pull/101235), [@andyzhangx](https://github.com/andyzhangx))
- Fix: Bug in `kube-proxy` latency metrics to calculate only the latency value for the `Endpoints` that are created after it starts running. This is needed because all the `Endpoints` objects are processed on restarts, independently when they were. ([#100861](https://github.com/kubernetes/kubernetes/pull/100861), [@aojea](https://github.com/aojea))
- Fix: avoid nil-pointer panic when checking the frontend IP configuration ([#101739](https://github.com/kubernetes/kubernetes/pull/101739), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: display of Job completion mode in `kubectl describe`. ([#101160](https://github.com/kubernetes/kubernetes/pull/101160), [@alculquicondor](https://github.com/alculquicondor))
- Fix: set "host is down" as corrupted mount. When SMB server is down, there is no way to terminate pod which is using SMB mount, would get an error. ([#101398](https://github.com/kubernetes/kubernetes/pull/101398), [@andyzhangx](https://github.com/andyzhangx))
- Fix: using NVMe AWS EBS volumes partitions. ([#100500](https://github.com/kubernetes/kubernetes/pull/100500), [@jsafrane](https://github.com/jsafrane))
- Fixed 'kubelet' runtime panic for timed-out portforward streams. ([#102489](https://github.com/kubernetes/kubernetes/pull/102489), [@saschagrunert](https://github.com/saschagrunert))
- Fixed `garbage collection` of dangling `VolumeAttachments` for `PersistentVolumes` migrated to CSI on startup of `kube-controller-manager`. ([#102176](https://github.com/kubernetes/kubernetes/pull/102176), [@timebertt](https://github.com/timebertt))
- Fixed a bug that `kubectl create configmap` always returns zero exit code when failed. ([#101780](https://github.com/kubernetes/kubernetes/pull/101780), [@nak3](https://github.com/nak3)) [SIG CLI]
- Fixed a bug that scheduler extenders are not called on preemptions ([#103019](https://github.com/kubernetes/kubernetes/pull/103019), [@ordovicia](https://github.com/ordovicia)) [SIG Scheduling]
- Fixed a bug where `startupProbe` stopped working after a container's first restart. ([#101093](https://github.com/kubernetes/kubernetes/pull/101093), [@wzshiming](https://github.com/wzshiming))
- Fixed an issue blocking azure auth to prompt to device code authentication flow when refresh token expires. ([#102063](https://github.com/kubernetes/kubernetes/pull/102063), [@tdihp](https://github.com/tdihp))
- Fixed false-positive uncertain volume attachments, which led to unexpected detachment of CSI migrated volumes ([#101737](https://github.com/kubernetes/kubernetes/pull/101737), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Apps and Storage]
- Fixed mounting of NFS volumes when IPv6 address is used as a server. ([#101067](https://github.com/kubernetes/kubernetes/pull/101067), [@Elbehery](https://github.com/Elbehery)) [SIG Storage]
- Fixed port-forward memory leak for long-running and heavily used connections. ([#99839](https://github.com/kubernetes/kubernetes/pull/99839), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery and Node]
- Fixed starting new pods after previous pod timed out unmounting its volumes. ([#100183](https://github.com/kubernetes/kubernetes/pull/100183), [@jsafrane](https://github.com/jsafrane)) [SIG Node, Storage and Testing]
- Fixed very rare volume corruption when a pod is deleted while kubelet is offline. ([#102059](https://github.com/kubernetes/kubernetes/pull/102059), [@jsafrane](https://github.com/jsafrane))
- Fixes a bug due to which the controller was not populating the lastSuccessfulTime field added to batch/v1 cronjob.status ([#102642](https://github.com/kubernetes/kubernetes/pull/102642), [@alaypatel07](https://github.com/alaypatel07)) [SIG Apps]
- Fixes a data race issue in the priority and fairness API server filter. ([#100638](https://github.com/kubernetes/kubernetes/pull/100638), [@tkashem](https://github.com/tkashem))
- Fixes issue with websocket-based watches of Service objects not closing correctly on timeout. ([#102539](https://github.com/kubernetes/kubernetes/pull/102539), [@liggitt](https://github.com/liggitt))
- For `kubeadm`: support for custom imagetags for etcd images which contain build metadata, when imagetags are in the form of version_metadata. For instance, if the etcd version is v3.4.13+patch.0, the supported imagetag would be v3.4.13_patch.0 ([#100350](https://github.com/kubernetes/kubernetes/pull/100350), [@jr0d](https://github.com/jr0d))
- For vSphere: fix regression during attach disk if datastore is within a storage folder or datastore cluster. ([#102892](https://github.com/kubernetes/kubernetes/pull/102892), [@gnufied](https://github.com/gnufied))
- GCE Windows will no longer install Docker on containerd nodes. ([#101747](https://github.com/kubernetes/kubernetes/pull/101747), [@jeremyje](https://github.com/jeremyje)) [SIG Cloud Provider and Windows]
- Generated OpenAPI now correctly specifies 201 as a possible response code for PATCH operations. ([#100141](https://github.com/kubernetes/kubernetes/pull/100141), [@brendandburns](https://github.com/brendandburns))
- If `kube-proxy` mode  is userspace do not enable `EndpointSlices`. ([#100913](https://github.com/kubernetes/kubernetes/pull/100913), [@JornShen](https://github.com/JornShen))
- Kube-apiserver now reports the synthetic verb when logging requests, better explaining the user intent and matching what is reported in the metrics. ([#102934](https://github.com/kubernetes/kubernetes/pull/102934), [@lavalamp](https://github.com/lavalamp)) [SIG API Machinery and Instrumentation]
- Kubeadm: allow passing the flag --log-file if --config is passed. If you wish to log to a file you must also pass --logtostderr=false or --alsologtostderr=true. Alternatively you can pipe to a file using "kubeadm ... | tee ...". ([#101449](https://github.com/kubernetes/kubernetes/pull/101449), [@CaoDonghui123](https://github.com/CaoDonghui123)) [SIG Cluster Lifecycle]
- Kubeadm: enable `--experimental-patches` flag for `kubeadm join phase control-plane-join all` command. ([#101110](https://github.com/kubernetes/kubernetes/pull/101110), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: fix the bug that kubeadm only uses the first hash in caCertHashes to verify the root CA ([#101977](https://github.com/kubernetes/kubernetes/pull/101977), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: remove the "ephemeral_storage" request from the etcd static pod that kubeadm deploys on stacked etcd control plane nodes. This request has caused sporadic failures on some setups due to a problem in the kubelet with cadvisor and the LocalStorageCapacityIsolation feature gate. See this issue for more details: https://github.com/kubernetes/kubernetes/issues/99305 ([#102673](https://github.com/kubernetes/kubernetes/pull/102673), [@jackfrancis](https://github.com/jackfrancis)) [SIG Cluster Lifecycle]
- Kubeadm: when using a custom image repository for CoreDNS kubeadm now will append the `coredns` image name instead of `coredns/coredns`, thus restoring the behaviour existing before the v1.21 release. Users who rely on nested folder for the coredns image should set the `clusterConfiguration.dns.imageRepository` value including the nested path name (e.g using `registry.company.xyz/coredns` will force kubeadm to use `registry.company.xyz/coredns/coredns` image). No action is needed if using the default registry (k8s.gcr.io). ([#102502](https://github.com/kubernetes/kubernetes/pull/102502), [@ykakarap](https://github.com/ykakarap))
- Kubelet: improve the performance when waiting for a synchronization of the node list with the `kube-apiserver`. ([#99336](https://github.com/kubernetes/kubernetes/pull/99336), [@neolit123](https://github.com/neolit123))
- Limit vSphere volume name to 63 characters long. ([#100404](https://github.com/kubernetes/kubernetes/pull/100404), [@gnufied](https://github.com/gnufied))
- Logging for GCE Windows clusters will be more accurate and complete when using Fluent bit. ([#101271](https://github.com/kubernetes/kubernetes/pull/101271), [@jeremyje](https://github.com/jeremyje))
- Output for `kubectl describe podsecuritypolicy` is now kind specific and cleaner ([#101436](https://github.com/kubernetes/kubernetes/pull/101436), [@KnVerey](https://github.com/KnVerey))
- Parsing of cpuset information now properly detects more invalid input such as `1--3` or `10-6`. ([#100565](https://github.com/kubernetes/kubernetes/pull/100565), [@lack](https://github.com/lack))
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
- The `EndpointSlice` IP validation now matches `Endpoints` IP validation. ([#101084](https://github.com/kubernetes/kubernetes/pull/101084), [@robscott](https://github.com/robscott))
- The `kube-controller-manager'` sets the upper-bound timeout limit for outgoing requests to 70s. Previously ([#99358](https://github.com/kubernetes/kubernetes/pull/99358), [@p0lyn0mial](https://github.com/p0lyn0mial))
- The `kube-proxy` log now shows the "Skipping topology aware endpoint filtering since no hints were provided for zone" warning under the right conditions. ([#101857](https://github.com/kubernetes/kubernetes/pull/101857), [@dervoeti](https://github.com/dervoeti))
- The `kubectl create service` now respects the `namespace` flag. ([#101005](https://github.com/kubernetes/kubernetes/pull/101005), [@zxh326](https://github.com/zxh326))
- The `kubectl wait --for=delete` command now ignores the not found error correctly. ([#96702](https://github.com/kubernetes/kubernetes/pull/96702), [@lingsamuel](https://github.com/lingsamuel))
- The `serviceOwnsFrontendIP` shouldn't report error when the public IP doesn't match. ([#102516](https://github.com/kubernetes/kubernetes/pull/102516), [@nilo19](https://github.com/nilo19))
- The conformance tests:
  - Services should serve multiport endpoints from pods
  - Services should serve a basic endpoint from pods
  were only validating the API objects, not performing any validation on the actual Services implementation.
  Those tests now validate that the Services under test are able to forward traffic to the endpoints. ([#101709](https://github.com/kubernetes/kubernetes/pull/101709), [@aojea](https://github.com/aojea)) [SIG Network and Testing]
- The kubelet now reports distinguishes log messages about certificate rotation for its client cert and server cert separately to make debugging problems with one or the other easier. ([#101252](https://github.com/kubernetes/kubernetes/pull/101252), [@smarterclayton](https://github.com/smarterclayton)) [SIG API Machinery and Auth]
- Update `kube-proxy` base image `debian-iptables` to v1.6.2 to pickup [documentation](https://github.com/kubernetes/release/pull/2106)
  \n"- `debian-iptables`: select nft mode if ntf lines > legacy lines, matching [iptables-wrappers](https://github.com/kubernetes-sigs/iptables-wrappers/)" ([#102590](https://github.com/kubernetes/kubernetes/pull/102590), [@BenTheElder](https://github.com/BenTheElder))
- Update klog v2.9.0. ([#102332](https://github.com/kubernetes/kubernetes/pull/102332), [@pacoxu](https://github.com/pacoxu))
- Updates dependency `sigs.k8s.io/structured-merge-diff` to v4.1.1. ([#100784](https://github.com/kubernetes/kubernetes/pull/100784), [@kevindelgado](https://github.com/kevindelgado))
- Updates hostprocess tests to specify user. ([#102965](https://github.com/kubernetes/kubernetes/pull/102965), [@jsturtevant](https://github.com/jsturtevant))
- Upgrades functionality of `kubectl kustomize` as described at [kustomize/v4.1.2](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.1.2) ([#101120](https://github.com/kubernetes/kubernetes/pull/101120), [@monopole](https://github.com/monopole))
- Upgrading etcd: `kubeadm` upgrade etcd to 3.4.13-3 ([#100612](https://github.com/kubernetes/kubernetes/pull/100612), [@pacoxu](https://github.com/pacoxu))
- Use default timeout of 10s for Azure ACR credential provider. ([#100686](https://github.com/kubernetes/kubernetes/pull/100686), [@hasheddan](https://github.com/hasheddan)) [SIG Cloud Provider]
- We no longer allow the cluster operator to delete any suggested priority & fairness bootstrap configuration object. \nIf a cluster operator removes a suggested configuration, it will be restored by the apiserver. ([#102067](https://github.com/kubernetes/kubernetes/pull/102067), [@tkashem](https://github.com/tkashem))
- When `DisableAcceleratorUsageMetrics` is set, do not collect accelerator metrics using cAdvisor. ([#101712](https://github.com/kubernetes/kubernetes/pull/101712), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Instrumentation and Node]

### Other (Cleanup or Flake)

- After the deprecation period,now the Kubelet's  `--chaos-chance` flag  are removed. ([#101057](https://github.com/kubernetes/kubernetes/pull/101057), [@wangyysde](https://github.com/wangyysde)) [SIG Node]
- Allow CSI drivers to just run offline expansion tests ([#102665](https://github.com/kubernetes/kubernetes/pull/102665), [@gnufied](https://github.com/gnufied)) [SIG Storage and Testing]
- Changed buildmode of non static Kubernetes binaries to produce position independent executables (PIE). ([#102323](https://github.com/kubernetes/kubernetes/pull/102323), [@saschagrunert](https://github.com/saschagrunert))
- Clarified the description of a test in the e2e suite that mentions "SCTP" but is
  actually intended to be testing the behavior of network plugins that don't
  implement SCTP. ([#102509](https://github.com/kubernetes/kubernetes/pull/102509), [@danwinship](https://github.com/danwinship))
- Client-go: reduce verbosity of "Starting/Stopping reflector" messages to 3 again ([#102788](https://github.com/kubernetes/kubernetes/pull/102788), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Disable log sampling when using json logging format. ([#102620](https://github.com/kubernetes/kubernetes/pull/102620), [@serathius](https://github.com/serathius))
- Exposes `WithCustomRoundTripper` method for specifying a middleware function for custom HTTP behaviour for the delegated auth clients. ([#99775](https://github.com/kubernetes/kubernetes/pull/99775), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Fake clients now implement a `FakeClient` interface ([#100940](https://github.com/kubernetes/kubernetes/pull/100940), [@markusthoemmes](https://github.com/markusthoemmes)) [SIG API Machinery and Instrumentation]
- Improve func `ToSelectableFields`' performance for event. ([#102461](https://github.com/kubernetes/kubernetes/pull/102461), [@goodluckbot](https://github.com/goodluckbot))
- JSON logging now supports having information about source code location in the logging format, source code information is available under the key "caller" ([#102437](https://github.com/kubernetes/kubernetes/pull/102437), [@MadhavJivrajani](https://github.com/MadhavJivrajani)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Kubeadm: the `CriticalAddonsOnly` toleration has been removed from `kube-proxy` DaemonSet ([#101966](https://github.com/kubernetes/kubernetes/pull/101966), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Metrics Server updated to use 0.4.4 image that doesn't depend on deprecated authorization.k8s.io/v1beta1 subjectaccessreviews API version. ([#101477](https://github.com/kubernetes/kubernetes/pull/101477), [@x13n](https://github.com/x13n)) [SIG Cloud Provider and Instrumentation]
- Migrate `proxy/ipvs/proxier.go` logs to structured logging. ([#97796](https://github.com/kubernetes/kubernetes/pull/97796), [@JornShen](https://github.com/JornShen))
- Migrate some log messages to structured logging in `pkg/volume/plugins.go`. ([#101510](https://github.com/kubernetes/kubernetes/pull/101510), [@huchengze](https://github.com/huchengze))
- Migrate some log messages to structured logging in `pkg/volume/volume_linux.go`. ([#99566](https://github.com/kubernetes/kubernetes/pull/99566), [@huchengze](https://github.com/huchengze))
- Migrate staging/src/k8s.io/apiserver/pkg/registry logs to structured logging. ([#98287](https://github.com/kubernetes/kubernetes/pull/98287), [@lala123912](https://github.com/lala123912)) [SIG API Machinery]
- Official binaries now include the golang generated build ID `buildid` instead of an empty string. ([#101411](https://github.com/kubernetes/kubernetes/pull/101411), [@saschagrunert](https://github.com/saschagrunert))
- Remove balanced attached node volumes feature. ([#102443](https://github.com/kubernetes/kubernetes/pull/102443), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Remove deprecated `--generator` flag from `kubectl autoscale`. ([#99900](https://github.com/kubernetes/kubernetes/pull/99900), [@MadhavJivrajani](https://github.com/MadhavJivrajani))
- Remove the deprecated flag `--generator` from `kubectl create deployment` command. ([#99915](https://github.com/kubernetes/kubernetes/pull/99915), [@BLasan](https://github.com/BLasan))
- Remove the duplicate packet import. ([#101187](https://github.com/kubernetes/kubernetes/pull/101187), [@chuntaochen](https://github.com/chuntaochen))
- The `DynamicFakeClient` now exposes its tracker via a `Tracker()` function. ([#100085](https://github.com/kubernetes/kubernetes/pull/100085), [@markusthoemmes](https://github.com/markusthoemmes))
- The `VolumeSnapshotDataSource` feature gate that is GA since v1.20 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#101531](https://github.com/kubernetes/kubernetes/pull/101531), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Storage]
- The deprecated CRIContainerLogRotation feature-gate has been removed, since the CRIContainerLogRotation feature graduated to GA in 1.21 and was unconditionally enabled. ([#101578](https://github.com/kubernetes/kubernetes/pull/101578), [@carlory](https://github.com/carlory)) [SIG Node]
- The deprecated RootCAConfigMap feature-gate has been removed, since the RootCAConfigMap feature graduated to GA in 1.21 and was unconditionally enabled. ([#101579](https://github.com/kubernetes/kubernetes/pull/101579), [@carlory](https://github.com/carlory)) [SIG Auth]
- The etcd client has been updated to 3.5.0; github.com/golang/protobuf, google.golang.org/protobuf, and google.golang.org/grpc have been updated to current versions. ([#100488](https://github.com/kubernetes/kubernetes/pull/100488), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node, Storage and Testing]
- Update Azure Go SDK to v55.0.0 ([#102441](https://github.com/kubernetes/kubernetes/pull/102441), [@feiskyer](https://github.com/feiskyer)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node and Storage]
- Update Azure Go SDK version to v53.1.0 ([#101357](https://github.com/kubernetes/kubernetes/pull/101357), [@feiskyer](https://github.com/feiskyer)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Update CNI plugins to v0.9.1. ([#102328](https://github.com/kubernetes/kubernetes/pull/102328), [@lentzi90](https://github.com/lentzi90))
- Update Calico to v3.19.1 ([#102386](https://github.com/kubernetes/kubernetes/pull/102386), [@JornShen](https://github.com/JornShen)) [SIG Cloud Provider]
- Update cri-tools dependency to v1.21.0 ([#100956](https://github.com/kubernetes/kubernetes/pull/100956), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider and Node]
- Update dep google/gnostic and google/go-cmp to v0.5.5 and updating transitive dependencies protobuf ([#102783](https://github.com/kubernetes/kubernetes/pull/102783), [@mcbenjemaa](https://github.com/mcbenjemaa)) [SIG Architecture and Testing]
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
- github.com/etcd-io/gofail: [ad7f989](https://github.com/etcd-io/gofail/tree/ad7f989)
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
- go.etcd.io/etcd/etcdutl/v3: v3.5.0
- go.etcd.io/etcd/pkg/v3: v3.5.0
- go.etcd.io/etcd/raft/v3: v3.5.0
- go.etcd.io/etcd/server/v3: v3.5.0
- go.etcd.io/etcd/tests/v3: v3.5.0
- go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc: v0.20.0
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
- github.com/grpc-ecosystem/go-grpc-middleware: [f849b54 → v1.3.0](https://github.com/grpc-ecosystem/go-grpc-middleware/compare/f849b54...v1.3.0)
- github.com/grpc-ecosystem/grpc-gateway: [v1.9.5 → v1.16.0](https://github.com/grpc-ecosystem/grpc-gateway/compare/v1.9.5...v1.16.0)
- github.com/jonboulle/clockwork: [v0.1.0 → v0.2.2](https://github.com/jonboulle/clockwork/compare/v0.1.0...v0.2.2)
- github.com/json-iterator/go: [v1.1.10 → v1.1.11](https://github.com/json-iterator/go/compare/v1.1.10...v1.1.11)
- github.com/julienschmidt/httprouter: [v1.2.0 → v1.3.0](https://github.com/julienschmidt/httprouter/compare/v1.2.0...v1.3.0)
- github.com/kr/pretty: [v0.2.0 → v0.2.1](https://github.com/kr/pretty/compare/v0.2.0...v0.2.1)
- github.com/mailru/easyjson: [v0.7.0 → v0.7.6](https://github.com/mailru/easyjson/compare/v0.7.0...v0.7.6)
- github.com/mattn/go-isatty: [v0.0.4 → v0.0.3](https://github.com/mattn/go-isatty/compare/v0.0.4...v0.0.3)
- github.com/mattn/go-runewidth: [v0.0.7 → v0.0.9](https://github.com/mattn/go-runewidth/compare/v0.0.7...v0.0.9)
- github.com/miekg/dns: [v1.1.35 → v1.0.14](https://github.com/miekg/dns/compare/v1.1.35...v1.0.14)
- github.com/moby/sys/mountinfo: [v0.4.0 → v0.4.1](https://github.com/moby/sys/mountinfo/compare/v0.4.0...v0.4.1)
- github.com/moby/term: [df9cb8a → 9d4ed18](https://github.com/moby/term/compare/df9cb8a...9d4ed18)
- github.com/mwitkow/go-conntrack: [cc309e4 → 2f06839](https://github.com/mwitkow/go-conntrack/compare/cc309e4...2f06839)
- github.com/olekukonko/tablewriter: [v0.0.4 → v0.0.5](https://github.com/olekukonko/tablewriter/compare/v0.0.4...v0.0.5)
- github.com/onsi/ginkgo: [v1.11.0 → v1.14.0](https://github.com/onsi/ginkgo/compare/v1.11.0...v1.14.0)
- github.com/onsi/gomega: [v1.7.0 → v1.10.1](https://github.com/onsi/gomega/compare/v1.7.0...v1.10.1)
- github.com/opencontainers/runc: [v1.0.0-rc93 → v1.0.0-rc95](https://github.com/opencontainers/runc/compare/v1.0.0-rc93...v1.0.0-rc95)
- github.com/opencontainers/runtime-spec: [e6143ca → 1c3f411](https://github.com/opencontainers/runtime-spec/compare/e6143ca...1c3f411)
- github.com/prometheus/client_golang: [v1.7.1 → v1.11.0](https://github.com/prometheus/client_golang/compare/v1.7.1...v1.11.0)
- github.com/prometheus/common: [v0.10.0 → v0.26.0](https://github.com/prometheus/common/compare/v0.10.0...v0.26.0)
- github.com/prometheus/procfs: [v0.2.0 → v0.6.0](https://github.com/prometheus/procfs/compare/v0.2.0...v0.6.0)
- github.com/rogpeppe/fastuuid: [6724a57 → v1.2.0](https://github.com/rogpeppe/fastuuid/compare/6724a57...v1.2.0)
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
- golang.org/x/net: 3d97a24 → a5a99cb
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
- k8s.io/utils: 67b214c → da69540
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.15 → v0.0.20
- sigs.k8s.io/kustomize/api: v0.8.5 → v0.8.10
- sigs.k8s.io/kustomize/cmd/config: v0.9.7 → v0.9.12
- sigs.k8s.io/kustomize/kustomize/v4: v4.0.5 → v4.1.3
- sigs.k8s.io/kustomize/kyaml: v0.10.15 → v0.10.20
- sigs.k8s.io/structured-merge-diff/v4: v4.1.0 → v4.1.1

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
