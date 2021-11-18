## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Log messages in JSON format are written to stderr by default now (same as text format) instead of stdout. Users who expected JSON output on stdout must now capture stderr instead or in addition to stdout. ([#106146](https://github.com/kubernetes/kubernetes/pull/106146), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Cluster Lifecycle and Instrumentation]
 - [kube-log-runner](https://github.com/kubernetes/kubernetes/tree/master/staging/src/k8s.io/component-base/logs/kube-log-runner) is included in release tar balls. It can be used to replace the deprecated `--log-file` parameter. ([#106123](https://github.com/kubernetes/kubernetes/pull/106123), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Cloud Provider, Cluster Lifecycle and Instrumentation]
 
## Changes by Kind

### Deprecation

- Kubeadm: add a new `output/v1alpha2` API that is identical to the `output/v1alpha1`, but attempts to resolve some internal dependencies with the `kubeadm/v1beta2` API. The `output/v1alpha1` API is now deprecated and will be removed in a future release. ([#105295](https://github.com/kubernetes/kubernetes/pull/105295), [@neolit123](https://github.com/neolit123))
- Kubeadm: add the kubeadm specific, Alpha (disabled by default) feature gate `UnversionedKubeletConfigMap`. When this feature is enabled kubeadm will start using a new naming format for the `ConfigMap` where it stores the `KubeletConfiguration` structure. The old format included the Kubernetes version - "kube-system/kubelet-config-1.22", while the new format does not - "kube-system/kubelet-config". A similar formatting change is done for the related RBAC rules. The old format is now DEPRECATED and will be removed after the feature graduates to GA. When writing the `ConfigMap` kubeadm (init, upgrade apply) will respect the value of `UnversionedKubeletConfigMap`, while when reading it (join, reset, upgrade), it would attempt to use new format first and fallback to the legacy format if needed. ([#105741](https://github.com/kubernetes/kubernetes/pull/105741), [@neolit123](https://github.com/neolit123))
- Kubeadm: remove the deprecated / NO-OP phase `update-cluster-status` in `kubeadm reset` ([#105888](https://github.com/kubernetes/kubernetes/pull/105888), [@neolit123](https://github.com/neolit123))

### API Change

- A new field `omitManagedFields` has been added to both `audit.Policy` and `audit.PolicyRule` 
  so cluster operators can opt in to omit managed fields of the request and response bodies from 
  being written to the API audit log. ([#94986](https://github.com/kubernetes/kubernetes/pull/94986), [@tkashem](https://github.com/tkashem)) [SIG API Machinery, Auth, Cloud Provider and Testing]
- Create HPA v2 from v2beta2 with some fields changed. ([#102534](https://github.com/kubernetes/kubernetes/pull/102534), [@wangyysde](https://github.com/wangyysde)) [SIG API Machinery, Apps, Auth, Autoscaling and Testing]
- Fix kube-proxy regression on UDP services because the logic to detect stale connections was not considering if the endpoint was ready. ([#106163](https://github.com/kubernetes/kubernetes/pull/106163), [@aojea](https://github.com/aojea)) [SIG API Machinery, Apps, Architecture, Auth, Autoscaling, CLI, Cloud Provider, Contributor Experience, Instrumentation, Network, Node, Release, Scalability, Scheduling, Storage, Testing and Windows]
- Implement support for recovering from volume expansion failures ([#106154](https://github.com/kubernetes/kubernetes/pull/106154), [@gnufied](https://github.com/gnufied)) [SIG API Machinery, Apps and Storage]
- In kubelet, log verbosity and flush frequency can also be configured via the configuration file and not just via command line flags. In other commands (kube-apiserver, kube-controller-manager), the flags are listed in the "Logs flags" group and not under "Global" or "Misc". The type for `-vmodule` was made a bit more descriptive (`pattern=N,...` instead of `moduleSpec`). ([#106090](https://github.com/kubernetes/kubernetes/pull/106090), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, CLI, Cluster Lifecycle, Instrumentation, Node and Scheduling]
- Introduce `OS` field in the PodSpec ([#104693](https://github.com/kubernetes/kubernetes/pull/104693), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- KubeSchedulerConfiguration provides a new field `MultiPoint` which will register a plugin for all valid extension points ([#105611](https://github.com/kubernetes/kubernetes/pull/105611), [@damemi](https://github.com/damemi)) [SIG Scheduling and Testing]
- Kubelet should reject pods whose OS doesn't match the node's OS label. ([#105292](https://github.com/kubernetes/kubernetes/pull/105292), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Apps and Node]
- The "Generic Ephemeral Volume" feature graduates to GA. It is now enabled unconditionally. ([#105609](https://github.com/kubernetes/kubernetes/pull/105609), [@pohly](https://github.com/pohly))
- The Kubelet's `--register-with-taints` option is now available via the Kubelet config file field registerWithTaints ([#105437](https://github.com/kubernetes/kubernetes/pull/105437), [@cmssczy](https://github.com/cmssczy)) [SIG Node and Scalability]
- The `CSIVolumeFSGroupPolicy` feature has moved from beta to GA. ([#105940](https://github.com/kubernetes/kubernetes/pull/105940), [@dobsonj](https://github.com/dobsonj))
- The `IngressClass.Spec.Parameters.Namespace` field is now GA. ([#104636](https://github.com/kubernetes/kubernetes/pull/104636), [@hbagdi](https://github.com/hbagdi))
- Track the number of Pods with a Ready condition in Job status. The feature is alpha and needs the feature gate `JobReadyPods` to be enabled. ([#104915](https://github.com/kubernetes/kubernetes/pull/104915), [@alculquicondor](https://github.com/alculquicondor))
- Validation rules for Custom Resource Definitions can be written in the [CEL expression language](https://github.com/google/cel-spec) using the `x-kubernetes-validations` extension in OpenAPIv3 schemas (alpha). This is gated by the alpha "CustomResourceValidationExpressions" feature gate. ([#106051](https://github.com/kubernetes/kubernetes/pull/106051), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Node, Storage and Testing]

### Feature

- (beta feature) If the CSI driver supports the NodeServiceCapability `VOLUME_MOUNT_GROUP` and the `DelegateFSGroupToCSIDriver` feature gate is enabled, kubelet will delegate applying FSGroup to the driver by passing it to NodeStageVolume and NodePublishVolume, regardless of what other FSGroup policies are set. ([#106330](https://github.com/kubernetes/kubernetes/pull/106330), [@verult](https://github.com/verult)) [SIG Storage]
- Add support for Portworx plugin to csi-translation-lib. Alpha release
  
  Portworx CSI driver is required to enable migration.
  This PR adds support of the `CSIMigrationPortworx` feature gate, which can be enabled by:
  
  1. Adding the feature flag to the kube-controller-manager `--feature-gates=CSIMigrationPortworx=true` 
  2. Adding the feature flag to the kubelet config:
  
  featureGates:
    CSIMigrationPortworx: true ([#103447](https://github.com/kubernetes/kubernetes/pull/103447), [@trierra](https://github.com/trierra)) [SIG API Machinery, Apps, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Scalability, Scheduling, Storage, Testing and Windows]
- Add support for `PodAndContainerStatsFromCRI` featuregate, which allows a user to specify their pod stats must also come from the CRI, not cAdvisor. ([#103095](https://github.com/kubernetes/kubernetes/pull/103095), [@haircommander](https://github.com/haircommander))
- Added ability for `kubectl wait` to wait on arbitary JSON path. ([#105776](https://github.com/kubernetes/kubernetes/pull/105776), [@lauchokyip](https://github.com/lauchokyip))
- Added the ability to specify whether to use an RFC7396 JSON Merge Patch, an RFC6902 JSON Patch, or a Strategic Merge Patch to perform an override of the resources created by `kubectl run` and `kubectl expose`. ([#105140](https://github.com/kubernetes/kubernetes/pull/105140), [@brianpursley](https://github.com/brianpursley))
- Adding an option for `kubectl cp` to resume on network errors until completion, requires tar in addition to tail inside the container image. ([#104792](https://github.com/kubernetes/kubernetes/pull/104792), [@matthyx](https://github.com/matthyx))
- Adds `--as-uid` flag to `kubectl` to allow uid impersonation in the same way as user and group impersonation. ([#105794](https://github.com/kubernetes/kubernetes/pull/105794), [@margocrawf](https://github.com/margocrawf))
- Adds new [alpha] command 'kubectl events' ([#99557](https://github.com/kubernetes/kubernetes/pull/99557), [@bboreham](https://github.com/bboreham))
- Allows users to prevent garbage collection on pinned images ([#103299](https://github.com/kubernetes/kubernetes/pull/103299), [@wgahnagl](https://github.com/wgahnagl)) [SIG Node]
- CSIMigrationGCE feature flag is turned ON by default ([#104722](https://github.com/kubernetes/kubernetes/pull/104722), [@leiyiz](https://github.com/leiyiz)) [SIG Apps, Cloud Provider, Node, Storage and Testing]
- Changed feature `CSIMigrationAWS` to on by default. This feature requires the AWS EBS CSI driver to be installed. ([#106098](https://github.com/kubernetes/kubernetes/pull/106098), [@wongma7](https://github.com/wongma7))
- Client-go: pass `DeleteOptions` down to the fake client `Reactor` ([#102945](https://github.com/kubernetes/kubernetes/pull/102945), [@chenchun](https://github.com/chenchun))
- Ensures that volume is deleted from the storage backend when the user tries to delete the PV object manually and the PV `ReclaimPolicy` is `Delete`. ([#105773](https://github.com/kubernetes/kubernetes/pull/105773), [@deepakkinni](https://github.com/deepakkinni))
- Graduating `controller_admission_duration_seconds`, `step_admission_duration_seconds`, `webhook_admission_duration_seconds`, `apiserver_current_inflight_requests` and `apiserver_response_sizes` metrics to stable. ([#106122](https://github.com/kubernetes/kubernetes/pull/106122), [@rezakrimi](https://github.com/rezakrimi)) [SIG API Machinery, Instrumentation and Testing]
- Graduating `pending_pods`, `preemption_attempts_total`, `preemption_victims` and `schedule_attempts_total` metrics to stable. Also `e2e_scheduling_duration_seconds` is renamed to `scheduling_attempt_duration_seconds` and the latter is graduated to stable. ([#105941](https://github.com/kubernetes/kubernetes/pull/105941), [@rezakrimi](https://github.com/rezakrimi)) [SIG Instrumentation, Scheduling and Testing]
- Integration testing now takes periodic Prometheus scrapes from the etcd server.
  There is a new script ,`hack/run-prometheus-on-etcd-scrapes.sh`, that runs a containerized Prometheus server against an archive of such scrapes. ([#106190](https://github.com/kubernetes/kubernetes/pull/106190), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery and Testing]
- Kube-apiserver: when merging lists, server side spply now prefers the order of the submitted request instead of the existing persisted object ([#105983](https://github.com/kubernetes/kubernetes/pull/105983), [@jiahuif](https://github.com/jiahuif))
- Kubectl will now provide shell completion choices for the `--output/-o` flag ([#105851](https://github.com/kubernetes/kubernetes/pull/105851), [@marckhouzam](https://github.com/marckhouzam))
- Kubelet should reconcile `kubernetes.io/os` and `kubernetes.io/arch` labels on the node object. The side-effect of this is kubelet would deny admission to pod which has nodeSelector with label `kubernetes.io/os` or `kubernetes.io/arch` which doesn't match the underlying OS or arch on the host OS. 
  - The label reconciliation happens as part of periodic status update which can be configured via flag `--node-status-update-frequency` ([#104613](https://github.com/kubernetes/kubernetes/pull/104613), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Node, Testing and Windows]
- Kubernetes is now built with Golang `1.17.3`. ([#106209](https://github.com/kubernetes/kubernetes/pull/106209), [@cpanato](https://github.com/cpanato))
- Move `ConfigurableFSGroupPolicy` to GA.
  Rename metric `volume_fsgroup_recursive_apply` to `volume_apply_access_control`. ([#105885](https://github.com/kubernetes/kubernetes/pull/105885), [@gnufied](https://github.com/gnufied))
- Moving `WindowsHostProcessContainers` feature to beta ([#106058](https://github.com/kubernetes/kubernetes/pull/106058), [@marosset](https://github.com/marosset))
- Pod template annotations and labels are now mutable for Jobs that are suspended and have never been started ([#105980](https://github.com/kubernetes/kubernetes/pull/105980), [@ahg-g](https://github.com/ahg-g))
- PodSecurity: in 1.23+ restricted policy levels, Pods and containers which set `runAsUser=0` are forbidden at admission-time; previously, they would be rejected at runtime ([#105857](https://github.com/kubernetes/kubernetes/pull/105857), [@liggitt](https://github.com/liggitt))
- Shell completion now knows to continue suggesting resource names when the command supports it.  For example `kubectl get pod pod1 <TAB>` will suggest more Pod names. ([#105711](https://github.com/kubernetes/kubernetes/pull/105711), [@marckhouzam](https://github.com/marckhouzam))
- Support to enable Hyper-V in GCE Windows Nodes created with `kube-up` ([#105999](https://github.com/kubernetes/kubernetes/pull/105999), [@mauriciopoppe](https://github.com/mauriciopoppe))
- The PodSecurity admission plugin has graduated to beta and is now enabled by default. The admission configuration version has been promoted to `pod-security.admission.config.k8s.io/v1beta1`. See `https://kubernetes.io/docs/concepts/security/pod-security-admission/` for usage. ([#106089](https://github.com/kubernetes/kubernetes/pull/106089), [@liggitt](https://github.com/liggitt))
- The Pods and Pod controllers that are exempted from the PodSecurity admission process are now marked with the `pod-security.kubernetes.io/exempt: user/namespace/runtimeClass` annotation, based on what caused the exemption.
  
  The enforcement level that allowed or denied a Pod during PodSecurity admission is now marked by the `pod-security.kubernetes.io/enforce-policy` annotation.
  
  The annotation that informs about audit policy violations changed from `pod-security.kubernetes.io/audit` to `pod-security.kubernetes.io/audit-violation`. ([#105908](https://github.com/kubernetes/kubernetes/pull/105908), [@stlaz](https://github.com/stlaz))
- The `/openapi/v3` endpoint will be populated with `OpenAPI v3` if the feature flag is enabled. ([#105945](https://github.com/kubernetes/kubernetes/pull/105945), [@Jefftree](https://github.com/Jefftree))
- The `DownwardAPIHugePages` feature is now enabled by default. ([#106271](https://github.com/kubernetes/kubernetes/pull/106271), [@mysunshine92](https://github.com/mysunshine92))
- The `kubectl describe namespace` now shows Conditions. ([#106219](https://github.com/kubernetes/kubernetes/pull/106219), [@dlipovetsky](https://github.com/dlipovetsky))
- This PR adds the following metrics for API Priority and Fairness.
  - **apiserver_flowcontrol_priority_level_seat_count_samples**: histograms of seats occupied by executing requests (both regular and final-delay phases included), broken down by priority_level; the observations are taken once per millisecond.
  - **apiserver_flowcontrol_priority_level_seat_count_watermarks**: histograms of high and low watermarks of number of seats occupied by executing requests (both regular and final-delay phases included), broken down by priority_level.
  - **apiserver_flowcontrol_watch_count_samples**: histograms of number of watches relevant to a given mutating request, broken down by that request's priority_level and flow_schema. ([#105873](https://github.com/kubernetes/kubernetes/pull/105873), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery, Instrumentation and Testing]
- Topology Aware Hints have graduated to beta. ([#106433](https://github.com/kubernetes/kubernetes/pull/106433), [@robscott](https://github.com/robscott)) [SIG Network]
- Update the system-validators library to `v1.6.0`. ([#106323](https://github.com/kubernetes/kubernetes/pull/106323), [@neolit123](https://github.com/neolit123))
- Upgrade etcd to 3.5.1 ([#105706](https://github.com/kubernetes/kubernetes/pull/105706), [@uthark](https://github.com/uthark)) [SIG Cloud Provider, Cluster Lifecycle and Testing]
- When using `RequestedToCapacityRatio` ScoringStrategy, empty shape will cause error. ([#106169](https://github.com/kubernetes/kubernetes/pull/106169), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]

### Documentation

- Graduating `pod_scheduling_duration_seconds`, `pod_scheduling_attempts`, `framework_extension_point_duration_seconds`, `plugin_execution_duration_seconds` and `queue_incoming_pods_total` metrics to stable. ([#106266](https://github.com/kubernetes/kubernetes/pull/106266), [@ahg-g](https://github.com/ahg-g)) [SIG Instrumentation, Scheduling and Testing]
- Users should not rely on unsupported CRON_TZ variable when specifying schedule, both the API server and cronjob controller will emit warnings pointing to https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/ containing explanation ([#106455](https://github.com/kubernetes/kubernetes/pull/106455), [@soltysh](https://github.com/soltysh)) [SIG Apps]

### Bug or Regression

- (PodSecurity admission) errors validating workload resources (deployment, replicaset, etc.) no longer block admission. ([#106017](https://github.com/kubernetes/kubernetes/pull/106017), [@tallclair](https://github.com/tallclair)) [SIG Auth]
- Add Pod Security admission metrics: `pod_security_evaluations_total`, `pod_security_exemptions_total`, `pod_security_errors_total` ([#105898](https://github.com/kubernetes/kubernetes/pull/105898), [@tallclair](https://github.com/tallclair))
- Add support for Windows Network stats in Containerd ([#105744](https://github.com/kubernetes/kubernetes/pull/105744), [@jsturtevant](https://github.com/jsturtevant)) [SIG Node, Testing and Windows]
- Added show-capacity option to `kubectl top node` to show `Capacity` resource usage ([#102917](https://github.com/kubernetes/kubernetes/pull/102917), [@bysnupy](https://github.com/bysnupy)) [SIG CLI]
- Do not unmount and mount subpath bind mounts during container creation unless bind mount changes ([#105512](https://github.com/kubernetes/kubernetes/pull/105512), [@gnufied](https://github.com/gnufied)) [SIG Storage]
- Don't use a custom dialer for the kubelet if is not rotating certificates, so we can reuse TCP connections and have only one between the apiserver and the kubelet.
  If users experiment problems with stale connections  using `HTTP1.1`, they can force the previous behavior of the kubelet by setting the environment variable `DISABLE_HTTP2`. ([#104844](https://github.com/kubernetes/kubernetes/pull/104844), [@aojea](https://github.com/aojea))
- Enhanced event messages for pod failed for exec probe timeout ([#106201](https://github.com/kubernetes/kubernetes/pull/106201), [@yxxhero](https://github.com/yxxhero)) [SIG Node]
- Ensure Pods are removed from the scheduler cache when the scheduler misses deletion events due to transient errors ([#106102](https://github.com/kubernetes/kubernetes/pull/106102), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix a panic in kubectl when creating secrets with an improper output type ([#106317](https://github.com/kubernetes/kubernetes/pull/106317), [@lauchokyip](https://github.com/lauchokyip)) [SIG CLI]
- Fix scoring for `NodeResourcesBalancedAllocation` plugins when nodes have containers with no requests. ([#105845](https://github.com/kubernetes/kubernetes/pull/105845), [@ahmad-diaa](https://github.com/ahmad-diaa))
- Fix: do not try to delete a LoadBalancer that does not exist ([#105777](https://github.com/kubernetes/kubernetes/pull/105777), [@nilo19](https://github.com/nilo19))
- Fix: leave the probe path empty for TCP probes ([#105253](https://github.com/kubernetes/kubernetes/pull/105253), [@nilo19](https://github.com/nilo19))
- Fix: remove VMSS and VMSS instances from SLB backend pool only when necessary ([#105839](https://github.com/kubernetes/kubernetes/pull/105839), [@nilo19](https://github.com/nilo19))
- Fixed a bug which could cause webhooks to have an incorrect copy of the old object after an Apply or Update ([#106195](https://github.com/kubernetes/kubernetes/pull/106195), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery]
- Fixed applying of SELinux labels to CSI volumes on very busy systems (with "error checking for SELinux support: could not get consistent content of /proc/self/mountinfo after 3 attempts") ([#105934](https://github.com/kubernetes/kubernetes/pull/105934), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed concurrent map access causing panics when logging timed-out API calls. ([#105734](https://github.com/kubernetes/kubernetes/pull/105734), [@marseel](https://github.com/marseel))
- Fixed the bug where using `kubectl patch` with `$deleteFromPrimitiveList` on a nonexistent or empty list would add the item to the list. ([#105421](https://github.com/kubernetes/kubernetes/pull/105421), [@brianpursley](https://github.com/brianpursley))
- Fixed the issue where logging output of kube-scheduler configuration files included line breaks and escape characters. The output also attempted to output the configuration file in one section without showing the user a more readable format. ([#106228](https://github.com/kubernetes/kubernetes/pull/106228), [@sanchayanghosh](https://github.com/sanchayanghosh)) [SIG Scheduling]
- Kube-up now includes CoreDNS version v1.8.6 ([#106091](https://github.com/kubernetes/kubernetes/pull/106091), [@rajansandeep](https://github.com/rajansandeep)) [SIG Cloud Provider]
- Kubeadm: Fix a bug on Windows worker nodes, where the downloaded `KubeletConfiguration` from the cluster can contain Linux paths that do not work on Windows and can trip the kubelet binary. ([#105992](https://github.com/kubernetes/kubernetes/pull/105992), [@hwdef](https://github.com/hwdef))
- Kubelet: fixes a file descriptor leak in log rotation ([#106382](https://github.com/kubernetes/kubernetes/pull/106382), [@rphillips](https://github.com/rphillips)) [SIG Node]
- Pod SecurityContext sysctls name parameter for update requests where the existing object's sysctl contains slashes and kubelet sysctl whitelist support contains slashes. ([#102393](https://github.com/kubernetes/kubernetes/pull/102393), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Apps, Auth, Node, Storage and Testing]
- Pod will not start when Init container was OOM killed. ([#104650](https://github.com/kubernetes/kubernetes/pull/104650), [@yxxhero](https://github.com/yxxhero)) [SIG Node]
- Reduce the number of calls to docker for stats via dockershim. For Windows this reduces the latency when calling docker, for Linux this saves cpu cycles. ([#104287](https://github.com/kubernetes/kubernetes/pull/104287), [@jsturtevant](https://github.com/jsturtevant)) [SIG Node and Windows]
- Resolves a potential issue with GC and NS controllers which may delete objects after getting a 404 response from the server during its startup. This PR ensures that requests to aggregated APIs will get 503, not 404 while the APIServiceRegistrationController hasn't finished its job. ([#104748](https://github.com/kubernetes/kubernetes/pull/104748), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Respect grace period when updating static pods. ([#104743](https://github.com/kubernetes/kubernetes/pull/104743), [@gjkim42](https://github.com/gjkim42)) [SIG Node and Testing]
- Support using negative array index in JSON patch replace operations. ([#105896](https://github.com/kubernetes/kubernetes/pull/105896), [@zqzten](https://github.com/zqzten))
- The `--leader-elect*` CLI args are now honored in scheduler. ([#105915](https://github.com/kubernetes/kubernetes/pull/105915), [@Huang-Wei](https://github.com/Huang-Wei))
- The `EndpointSlice` mirroring controller now cleans up managed `EndpointSlices` when a service selector is added. ([#105997](https://github.com/kubernetes/kubernetes/pull/105997), [@robscott](https://github.com/robscott))
- The `kubectl port-forward` service will now properly exit when the attached pod dies. ([#103526](https://github.com/kubernetes/kubernetes/pull/103526), [@brianpursley](https://github.com/brianpursley))
- The `pods/binding` subresource now honors `metadata.uid` and `metadata.resourceVersion` ([#105913](https://github.com/kubernetes/kubernetes/pull/105913), [@aholic](https://github.com/aholic))
- The kube-proxy sync_proxy_rules_iptables_total metric now gives
  the correct number of rules, rather than being off by one.
  
  Fixed multiple iptables proxy regressions introduced in 1.22:
  
    - When using Services with SessionAffinity, client affinity for an
      endpoint now gets broken when that endpoint becomes non-ready
      (rather than continuing until the endpoint is fully deleted).
  
    - Traffic to a service IP now starts getting rejected (as opposed to
      merely dropped) as soon as there are no longer any *usable*
      endpoints, rather than waiting until all of the terminating
      endpoints have terminated even when those terminating endpoints
      were not being used.
  
    - Chains for endpoints that won't be used are no longer output to
      iptables, saving a bit of memory/time/cpu. ([#106030](https://github.com/kubernetes/kubernetes/pull/106030), [@danwinship](https://github.com/danwinship)) [SIG Network]
- Upgrades functionality of `kubectl kustomize` as described in
  https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.4.1 ([#106389](https://github.com/kubernetes/kubernetes/pull/106389), [@natasha41575](https://github.com/natasha41575))

### Other (Cleanup or Flake)

- Changed buckets in apiserver_request_duration_seconds metric from [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,1.25, 1.5, 1.75, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 40, 50, 60] to [0.05, 0.1, 0.2, 0.4, 0.6, 0.8, 1.0, 1.25, 1.5, 2, 3, 4, 5, 6, 8, 10, 15, 20, 30, 45, 60] ([#106306](https://github.com/kubernetes/kubernetes/pull/106306), [@pawbana](https://github.com/pawbana)) [SIG API Machinery, Instrumentation and Testing]
- Kubectl: deprecated command line flags (like several of the klog flags) now have a `DEPRECATED: <explanation>` comment. ([#106172](https://github.com/kubernetes/kubernetes/pull/106172), [@pohly](https://github.com/pohly)) [SIG CLI]
- Kubemark is now built as a portable, static binary. ([#106150](https://github.com/kubernetes/kubernetes/pull/106150), [@pohly](https://github.com/pohly)) [SIG Scalability and Testing]
- Migrate `pkg/scheduler/framework/plugins/interpodaffinity/filtering.go`,`pkg/scheduler/framework/plugins/podtopologyspread/filtering.go`, `pkg/scheduler/framework/plugins/volumezone/volume_zone.go` to structured logging ([#105931](https://github.com/kubernetes/kubernetes/pull/105931), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated `cmd/kube-scheduler/app/server.go`, `pkg/scheduler/framework/plugins/nodelabel/node_label.go`, `pkg/scheduler/framework/plugins/nodevolumelimits/csi.go`, `pkg/scheduler/framework/plugins/nodevolumelimits/non_csi.go` to structured logging ([#105855](https://github.com/kubernetes/kubernetes/pull/105855), [@shivanshu1333](https://github.com/shivanshu1333))
- Migrated `pkg/scheduler/framework/plugins/volumebinding/assume_cache.go` to structured logging. ([#105904](https://github.com/kubernetes/kubernetes/pull/105904), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Instrumentation, Scheduling and Storage]
- Migrated `pkg/scheduler/framework/preemption/preemption.go`, `pkg/scheduler/framework/plugins/examples/stateful/stateful.go`, and `pkg/scheduler/framework/plugins/noderesources/resource_allocation.go` to structured logging ([#105967](https://github.com/kubernetes/kubernetes/pull/105967), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Instrumentation, Node and Scheduling]
- Migrated scheduler file `cache.go` to structured logging ([#105969](https://github.com/kubernetes/kubernetes/pull/105969), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Instrumentation and Scheduling]
- Migrated scheduler files `comparer.go`, `dumper.go`, `node_tree.go` to structured logging ([#105968](https://github.com/kubernetes/kubernetes/pull/105968), [@shivanshu1333](https://github.com/shivanshu1333)) [SIG Instrumentation and Scheduling]
- Remove deprecated and not supported old cronjob controller. ([#106126](https://github.com/kubernetes/kubernetes/pull/106126), [@soltysh](https://github.com/soltysh)) [SIG Apps]
- Remove ignore error flag for drain, and set this feature as default ([#105571](https://github.com/kubernetes/kubernetes/pull/105571), [@yuzhiquan](https://github.com/yuzhiquan)) [SIG CLI]
- The `kube-proxy` image contains `/go-runner` as a replacement for deprecated `klog` flags. ([#106301](https://github.com/kubernetes/kubernetes/pull/106301), [@pohly](https://github.com/pohly))

## Dependencies

### Added
- bazil.org/fuse: 371fbbd
- github.com/OneOfOne/xxhash: [v1.2.2](https://github.com/OneOfOne/xxhash/tree/v1.2.2)
- github.com/antlr/antlr4/runtime/Go/antlr: [b48c857](https://github.com/antlr/antlr4/runtime/Go/antlr/tree/b48c857)
- github.com/cespare/xxhash: [v1.1.0](https://github.com/cespare/xxhash/tree/v1.1.0)
- github.com/cncf/xds/go: [fbca930](https://github.com/cncf/xds/go/tree/fbca930)
- github.com/getkin/kin-openapi: [v0.76.0](https://github.com/getkin/kin-openapi/tree/v0.76.0)
- github.com/go-logr/zapr: [v1.2.0](https://github.com/go-logr/zapr/tree/v1.2.0)
- github.com/google/cel-go: [v0.9.0](https://github.com/google/cel-go/tree/v0.9.0)
- github.com/google/cel-spec: [v0.6.0](https://github.com/google/cel-spec/tree/v0.6.0)
- github.com/google/martian/v3: [v3.1.0](https://github.com/google/martian/v3/tree/v3.1.0)
- github.com/kr/fs: [v0.1.0](https://github.com/kr/fs/tree/v0.1.0)
- github.com/pkg/sftp: [v1.10.1](https://github.com/pkg/sftp/tree/v1.10.1)
- github.com/spaolacci/murmur3: [f09979e](https://github.com/spaolacci/murmur3/tree/f09979e)
- sigs.k8s.io/json: c049b76

### Changed
- cloud.google.com/go/bigquery: v1.4.0 → v1.8.0
- cloud.google.com/go/storage: v1.6.0 → v1.10.0
- cloud.google.com/go: v0.54.0 → v0.81.0
- github.com/GoogleCloudPlatform/k8s-cloud-provider: [7901bc8 → ea6160c](https://github.com/GoogleCloudPlatform/k8s-cloud-provider/compare/7901bc8...ea6160c)
- github.com/Microsoft/go-winio: [v0.4.15 → v0.4.17](https://github.com/Microsoft/go-winio/compare/v0.4.15...v0.4.17)
- github.com/Microsoft/hcsshim: [5eafd15 → v0.8.22](https://github.com/Microsoft/hcsshim/compare/5eafd15...v0.8.22)
- github.com/benbjohnson/clock: [v1.0.3 → v1.1.0](https://github.com/benbjohnson/clock/compare/v1.0.3...v1.1.0)
- github.com/bketelsen/crypt: [5cbc8cc → v0.0.4](https://github.com/bketelsen/crypt/compare/5cbc8cc...v0.0.4)
- github.com/containerd/cgroups: [0dbf7f0 → v1.0.1](https://github.com/containerd/cgroups/compare/0dbf7f0...v1.0.1)
- github.com/containerd/containerd: [v1.4.4 → v1.4.11](https://github.com/containerd/containerd/compare/v1.4.4...v1.4.11)
- github.com/containerd/continuity: [aaeac12 → v0.1.0](https://github.com/containerd/continuity/compare/aaeac12...v0.1.0)
- github.com/containerd/fifo: [a9fb20d → v1.0.0](https://github.com/containerd/fifo/compare/a9fb20d...v1.0.0)
- github.com/containerd/go-runc: [5a6d9f3 → v1.0.0](https://github.com/containerd/go-runc/compare/5a6d9f3...v1.0.0)
- github.com/containerd/typeurl: [v1.0.1 → v1.0.2](https://github.com/containerd/typeurl/compare/v1.0.1...v1.0.2)
- github.com/coredns/corefile-migration: [v1.0.12 → v1.0.14](https://github.com/coredns/corefile-migration/compare/v1.0.12...v1.0.14)
- github.com/docker/docker: [v20.10.2+incompatible → v20.10.7+incompatible](https://github.com/docker/docker/compare/v20.10.2...v20.10.7)
- github.com/envoyproxy/go-control-plane: [668b12f → 63b5d3c](https://github.com/envoyproxy/go-control-plane/compare/668b12f...63b5d3c)
- github.com/evanphx/json-patch: [v4.11.0+incompatible → v4.12.0+incompatible](https://github.com/evanphx/json-patch/compare/v4.11.0...v4.12.0)
- github.com/go-logr/logr: [v0.4.0 → v1.2.0](https://github.com/go-logr/logr/compare/v0.4.0...v1.2.0)
- github.com/golang/glog: [23def4e → v1.0.0](https://github.com/golang/glog/compare/23def4e...v1.0.0)
- github.com/golang/mock: [v1.4.4 → v1.5.0](https://github.com/golang/mock/compare/v1.4.4...v1.5.0)
- github.com/google/cadvisor: [v0.39.2 → v0.43.0](https://github.com/google/cadvisor/compare/v0.39.2...v0.43.0)
- github.com/google/pprof: [1ebb73c → cbba55b](https://github.com/google/pprof/compare/1ebb73c...cbba55b)
- github.com/hashicorp/golang-lru: [v0.5.1 → v0.5.0](https://github.com/hashicorp/golang-lru/compare/v0.5.1...v0.5.0)
- github.com/ianlancetaylor/demangle: [5e5cf60 → 28f6c0f](https://github.com/ianlancetaylor/demangle/compare/5e5cf60...28f6c0f)
- github.com/json-iterator/go: [v1.1.11 → v1.1.12](https://github.com/json-iterator/go/compare/v1.1.11...v1.1.12)
- github.com/magiconair/properties: [v1.8.1 → v1.8.5](https://github.com/magiconair/properties/compare/v1.8.1...v1.8.5)
- github.com/mitchellh/go-homedir: [v1.1.0 → v1.0.0](https://github.com/mitchellh/go-homedir/compare/v1.1.0...v1.0.0)
- github.com/mitchellh/mapstructure: [v1.1.2 → v1.4.1](https://github.com/mitchellh/mapstructure/compare/v1.1.2...v1.4.1)
- github.com/modern-go/reflect2: [v1.0.1 → v1.0.2](https://github.com/modern-go/reflect2/compare/v1.0.1...v1.0.2)
- github.com/opencontainers/runc: [v1.0.1 → v1.0.2](https://github.com/opencontainers/runc/compare/v1.0.1...v1.0.2)
- github.com/pelletier/go-toml: [v1.2.0 → v1.9.3](https://github.com/pelletier/go-toml/compare/v1.2.0...v1.9.3)
- github.com/prometheus/common: [v0.26.0 → v0.28.0](https://github.com/prometheus/common/compare/v0.26.0...v0.28.0)
- github.com/spf13/afero: [v1.2.2 → v1.6.0](https://github.com/spf13/afero/compare/v1.2.2...v1.6.0)
- github.com/spf13/cast: [v1.3.0 → v1.3.1](https://github.com/spf13/cast/compare/v1.3.0...v1.3.1)
- github.com/spf13/cobra: [v1.1.3 → v1.2.1](https://github.com/spf13/cobra/compare/v1.1.3...v1.2.1)
- github.com/spf13/jwalterweatherman: [v1.0.0 → v1.1.0](https://github.com/spf13/jwalterweatherman/compare/v1.0.0...v1.1.0)
- github.com/spf13/viper: [v1.7.0 → v1.8.1](https://github.com/spf13/viper/compare/v1.7.0...v1.8.1)
- github.com/yuin/goldmark: [v1.3.5 → v1.4.0](https://github.com/yuin/goldmark/compare/v1.3.5...v1.4.0)
- go.opencensus.io: v0.22.3 → v0.23.0
- go.uber.org/zap: v1.17.0 → v1.19.0
- golang.org/x/crypto: 5ea612d → 32db794
- golang.org/x/net: 37e1c6a → e898025
- golang.org/x/oauth2: bf48bf1 → 2bc19b1
- golang.org/x/sys: 59db8d7 → f4d4317
- golang.org/x/term: 6a3ed07 → 6886f2d
- golang.org/x/text: v0.3.6 → v0.3.7
- golang.org/x/tools: v0.1.2 → d4cc65f
- google.golang.org/api: v0.20.0 → v0.46.0
- google.golang.org/appengine: v1.6.5 → v1.6.7
- google.golang.org/genproto: f16073e → fe13028
- google.golang.org/grpc: v1.38.0 → v1.40.0
- google.golang.org/protobuf: v1.26.0 → v1.27.1
- gopkg.in/ini.v1: v1.51.0 → v1.62.0
- honnef.co/go/tools: v0.0.1-2020.1.3 → v0.0.1-2020.1.4
- k8s.io/gengo: b6c5ce2 → 485abfe
- k8s.io/klog/v2: v2.9.0 → v2.30.0
- k8s.io/kube-openapi: 9528897 → e816edb
- k8s.io/system-validators: v1.5.0 → v1.6.0
- k8s.io/utils: 4b05e18 → cb0fa31
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.22 → v0.0.25
- sigs.k8s.io/kustomize/api: v0.8.11 → v0.10.1
- sigs.k8s.io/kustomize/cmd/config: v0.9.13 → v0.10.2
- sigs.k8s.io/kustomize/kustomize/v4: v4.2.0 → v4.4.1
- sigs.k8s.io/kustomize/kyaml: v0.11.0 → v0.13.0
- sigs.k8s.io/structured-merge-diff/v4: v4.1.2 → v4.2.0

### Removed
- cloud.google.com/go/datastore: v1.1.0
- cloud.google.com/go/pubsub: v1.2.0
- github.com/alecthomas/units: [f65c72e](https://github.com/alecthomas/units/tree/f65c72e)
- github.com/coreos/bbolt: [v1.3.2](https://github.com/coreos/bbolt/tree/v1.3.2)
- github.com/coreos/etcd: [v3.3.13+incompatible](https://github.com/coreos/etcd/tree/v3.3.13)
- github.com/coreos/go-systemd: [95778df](https://github.com/coreos/go-systemd/tree/95778df)
- github.com/coreos/pkg: [399ea9e](https://github.com/coreos/pkg/tree/399ea9e)
- github.com/dgrijalva/jwt-go: [v3.2.0+incompatible](https://github.com/dgrijalva/jwt-go/tree/v3.2.0)
- github.com/google/martian: [v2.1.0+incompatible](https://github.com/google/martian/tree/v2.1.0)
- github.com/jpillora/backoff: [v1.0.0](https://github.com/jpillora/backoff/tree/v1.0.0)
- gotest.tools: v2.2.0+incompatible
