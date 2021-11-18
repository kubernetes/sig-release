## Changes by Kind

### Deprecation

- A deprecation notice has been added when using the kube-proxy userspace proxier, which will be removed in v1.25. (#103860) ([#104631](https://github.com/kubernetes/kubernetes/pull/104631), [@perithompson](https://github.com/perithompson))
- Feature-gate `VolumeSubpath` has been deprecated and cannot be disabled. It will be completely removed in 1.25 ([#105474](https://github.com/kubernetes/kubernetes/pull/105474), [@mauriciopoppe](https://github.com/mauriciopoppe))
- Kubeadm: remove the deprecated / NO-OP phase `update-cluster-status` in `kubeadm reset` ([#105888](https://github.com/kubernetes/kubernetes/pull/105888), [@neolit123](https://github.com/neolit123))
- Removed `kubectl --dry-run` empty default value and boolean values. `kubectl --dry-run` usage must be specified with `--dry-run=(server|client|none)`. ([#105327](https://github.com/kubernetes/kubernetes/pull/105327), [@julianvmodesto](https://github.com/julianvmodesto))

### API Change

- Ephemeral containers graduated to beta and are now available by default. ([#105405](https://github.com/kubernetes/kubernetes/pull/105405), [@verb](https://github.com/verb))
- Introduce `OS` field in the PodSpec ([#104693](https://github.com/kubernetes/kubernetes/pull/104693), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- Introduce `v1beta3` API for scheduler. This version 
  - increases the weight of user specifiable priorities.
  The weights of following priority plugins are increased
    - `TaintTolerations` to 3 - as leveraging node tainting to group nodes in the cluster is becoming a widely-adopted practice
    - `NodeAffinity` to 2
    - `InterPodAffinity` to 2
  
  - Won't have `HealthzBindAddress`, `MetricsBindAddress` fields ([#104251](https://github.com/kubernetes/kubernetes/pull/104251), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- JSON log output is configurable and now supports writing info messages to stdout and error messages to stderr. Info messages can be buffered in memory. The default is to write both to stdout without buffering, as before. ([#104873](https://github.com/kubernetes/kubernetes/pull/104873), [@pohly](https://github.com/pohly))
- JobTrackingWithFinalizers graduates to beta. Feature is enabled by default. ([#105687](https://github.com/kubernetes/kubernetes/pull/105687), [@alculquicondor](https://github.com/alculquicondor))
- Kube-scheduler: support for configuration file version `v1beta1` is removed. Update configuration files to v1beta2(xref: https://github.com/kubernetes/enhancements/issues/2901) or v1beta3 before upgrading to 1.23. ([#104782](https://github.com/kubernetes/kubernetes/pull/104782), [@kerthcet](https://github.com/kerthcet))
- Remove `NodeLease` feature gate that was graduated and locked to stable in 1.17 release. ([#105222](https://github.com/kubernetes/kubernetes/pull/105222), [@cyclinder](https://github.com/cyclinder))
- The "Generic Ephemeral Volume" feature graduates to GA. It is now enabled unconditionally. ([#105609](https://github.com/kubernetes/kubernetes/pull/105609), [@pohly](https://github.com/pohly))
- The `TTLAfterFinished` feature gate is now GA and enabled by default. ([#105219](https://github.com/kubernetes/kubernetes/pull/105219), [@sahilvv](https://github.com/sahilvv))
- The legacy scheduler policy config is removed in v1.23, the associated flags `policy-config-file`, `policy-configmap`, `policy-configmap-namespace` and `use-legacy-policy-config` are also removed. Migrate to Component Config instead, see https://kubernetes.io/docs/reference/scheduling/config/ for details. ([#105424](https://github.com/kubernetes/kubernetes/pull/105424), [@kerthcet](https://github.com/kerthcet))
- Track the number of Pods with a Ready condition in Job status. The feature is alpha and needs the feature gate JobReadyPods to be enabled. ([#104915](https://github.com/kubernetes/kubernetes/pull/104915), [@alculquicondor](https://github.com/alculquicondor))

### Feature

- Add a new `distribute-cpus-across-numa` option to the static `CPUManager` policy. When enabled, this will trigger the `CPUManager` to evenly distribute CPUs across NUMA nodes in cases where more than one NUMA node is required to satisfy the allocation. ([#105631](https://github.com/kubernetes/kubernetes/pull/105631), [@klueska](https://github.com/klueska))
- Add support to generate client-side binaries for windows/arm64 platform ([#104894](https://github.com/kubernetes/kubernetes/pull/104894), [@pacoxu](https://github.com/pacoxu))
- Added a new feature gate `CustomResourceValidationExpressions` to enable expression validation for Custom Resource. ([#105107](https://github.com/kubernetes/kubernetes/pull/105107), [@cici37](https://github.com/cici37))
- Adds new [alpha] command 'kubectl events' ([#99557](https://github.com/kubernetes/kubernetes/pull/99557), [@bboreham](https://github.com/bboreham))
- Client-go: pass `DeleteOptions` down to the fake client `Reactor` ([#102945](https://github.com/kubernetes/kubernetes/pull/102945), [@chenchun](https://github.com/chenchun))
- Enhance scheduler `VolumeBinding` plugin to handle Lost PVC as `UnschedulableAndUnresolvable` ([#105245](https://github.com/kubernetes/kubernetes/pull/105245), [@yibozhuang](https://github.com/yibozhuang))
- Feature gate `StorageObjectInUseProtection` has been deprecated and cannot be disabled. It will be completely removed in 1.25 ([#105495](https://github.com/kubernetes/kubernetes/pull/105495), [@ikeeip](https://github.com/ikeeip))
- Kubectl will now provide shell completion choices for the `--output/-o` flag ([#105851](https://github.com/kubernetes/kubernetes/pull/105851), [@marckhouzam](https://github.com/marckhouzam))
- Kubernetes is now built with Golang 1.17.2 ([#105563](https://github.com/kubernetes/kubernetes/pull/105563), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Move the `GetAllocatableResources` Endpoint in PodResource API to the beta that will make it enabled by default. ([#105003](https://github.com/kubernetes/kubernetes/pull/105003), [@swatisehgal](https://github.com/swatisehgal))
- Node affinity, Node selectors, and tolerations are now mutable for Jobs that are suspended and have never been started ([#105479](https://github.com/kubernetes/kubernetes/pull/105479), [@ahg-g](https://github.com/ahg-g))
- Pod template annotations and labels are now mutable for Jobs that are suspended and have never been started ([#105980](https://github.com/kubernetes/kubernetes/pull/105980), [@ahg-g](https://github.com/ahg-g))
- PodSecurity: in 1.23+ restricted policy levels, Pods and containers which set `runAsUser=0` are forbidden at admission-time; previously, they would be rejected at runtime ([#105857](https://github.com/kubernetes/kubernetes/pull/105857), [@liggitt](https://github.com/liggitt))
- Shell completion now knows to continue suggesting resource names when the command supports it.  For example `kubectl get pod pod1 <TAB>` will suggest more Pod names. ([#105711](https://github.com/kubernetes/kubernetes/pull/105711), [@marckhouzam](https://github.com/marckhouzam))
- Support to enable Hyper-V in GCE Windows Nodes created with `kube-up` ([#105999](https://github.com/kubernetes/kubernetes/pull/105999), [@mauriciopoppe](https://github.com/mauriciopoppe))
- The CPUManager policy options are now enabled, and we introduce a graduation path for the new CPU Manager policy options. ([#105012](https://github.com/kubernetes/kubernetes/pull/105012), [@fromanirh](https://github.com/fromanirh))
- The Pods and Pod controllers that are exempted from the PodSecurity admission process are now marked with the `pod-security.kubernetes.io/exempt: user/namespace/runtimeClass` annotation, based on what caused the exemption.
  
  The enforcement level that allowed or denied a Pod during PodSecurity admission is now marked by the `pod-security.kubernetes.io/enforce-policy` annotation.
  
  The annotation that informs about audit policy violations changed from `pod-security.kubernetes.io/audit` to `pod-security.kubernetes.io/audit-violation`. ([#105908](https://github.com/kubernetes/kubernetes/pull/105908), [@stlaz](https://github.com/stlaz))
- The etcd container image now supports Windows. ([#92433](https://github.com/kubernetes/kubernetes/pull/92433), [@claudiubelu](https://github.com/claudiubelu))
- When feature gate `JobTrackingWithFinalizers` is enabled:
  - Limit the number of Pods tracked in a single Job sync to avoid starvation of small Jobs.
  - The metric `job_pod_finished_total` counts the number of finished Pods tracked by the Job controller. ([#105197](https://github.com/kubernetes/kubernetes/pull/105197), [@alculquicondor](https://github.com/alculquicondor))
- `client-go`, using log level 9, traces the following events of a HTTP request:
      - DNS lookup
      - TCP dialing
      - TLS handshake
      - Time to get a connection from the pool
      - Time to process a request ([#105156](https://github.com/kubernetes/kubernetes/pull/105156), [@aojea](https://github.com/aojea))

### Failing Test

- Fixes hostPath storage E2E tests within SELinux enabled env ([#104551](https://github.com/kubernetes/kubernetes/pull/104551), [@Elbehery](https://github.com/Elbehery))

### Bug or Regression

- Add Pod Security admission metrics: `pod_security_evaluations_total`, `pod_security_exemptions_total`, `pod_security_errors_total` ([#105898](https://github.com/kubernetes/kubernetes/pull/105898), [@tallclair](https://github.com/tallclair))
- Apimachinery: Pretty printed JSON and YAML output is now indented consistently. ([#105466](https://github.com/kubernetes/kubernetes/pull/105466), [@liggitt](https://github.com/liggitt))
- Be able to create a Pod with Generic Ephemeral Volumes as raw block devices. ([#105682](https://github.com/kubernetes/kubernetes/pull/105682), [@pohly](https://github.com/pohly))
- Change `kubectl diff --invalid-arg` status code from 1 to 2 to match docs ([#105445](https://github.com/kubernetes/kubernetes/pull/105445), [@ardaguclu](https://github.com/ardaguclu))
- Client-go uses the same HTTP client for all the generated groups and versions, allowing to share customized transports for multiple groups versions. ([#105490](https://github.com/kubernetes/kubernetes/pull/105490), [@aojea](https://github.com/aojea))
- Evicted and other terminated Pods will no longer revert to the `Running` phase. ([#105462](https://github.com/kubernetes/kubernetes/pull/105462), [@ehashman](https://github.com/ehashman))
- Fix pod name of NonIndexed Jobs to not include rogue `-1` substring ([#105676](https://github.com/kubernetes/kubernetes/pull/105676), [@alculquicondor](https://github.com/alculquicondor))
- Fix scoring for `NodeResourcesBalancedAllocation` plugins when nodes have containers with no requests. ([#105845](https://github.com/kubernetes/kubernetes/pull/105845), [@ahmad-diaa](https://github.com/ahmad-diaa))
- Fix: do not try to delete a LoadBalancer that does not exist ([#105777](https://github.com/kubernetes/kubernetes/pull/105777), [@nilo19](https://github.com/nilo19))
- Fix: leave the probe path empty for TCP probes ([#105253](https://github.com/kubernetes/kubernetes/pull/105253), [@nilo19](https://github.com/nilo19))
- Fix: remove VMSS and VMSS instances from SLB backend pool only when necessary ([#105839](https://github.com/kubernetes/kubernetes/pull/105839), [@nilo19](https://github.com/nilo19))
- Fix: skip `instance not found` when decoupling VMSSs from LB ([#105666](https://github.com/kubernetes/kubernetes/pull/105666), [@nilo19](https://github.com/nilo19))
- Fixed a bug that prevents a PersistentVolume that has a PersistentVolumeClaim UID which doesn't exist in local cache but exists in etcd from being updated to the Released phase. ([#105211](https://github.com/kubernetes/kubernetes/pull/105211), [@xiaopingrubyist](https://github.com/xiaopingrubyist))
- Fixed architecture within manifest for non `amd64` etcd images. ([#105484](https://github.com/kubernetes/kubernetes/pull/105484), [@saschagrunert](https://github.com/saschagrunert))
- Fixed concurrent map access causing panics when logging timed-out API calls. ([#105734](https://github.com/kubernetes/kubernetes/pull/105734), [@marseel](https://github.com/marseel))
- Fixed consolidate logs for `instance not found` error
  Fixed skip `not found` nodes when reconciling LB backend address pools ([#105188](https://github.com/kubernetes/kubernetes/pull/105188), [@nilo19](https://github.com/nilo19))
- Fixes a bug that could result in the EndpointSlice controller unnecessarily updating EndpointSlices associated with a Service that had Topology Aware Hints enabled. ([#105267](https://github.com/kubernetes/kubernetes/pull/105267), [@llhuii](https://github.com/llhuii))
- Fixes the `should support building a client with a CSR` E2E test to work with clusters configured with short certificate lifetimes ([#105396](https://github.com/kubernetes/kubernetes/pull/105396), [@liggitt](https://github.com/liggitt))
- Handle Generic Ephemeral Volumes properly in the node limits scheduler filter and the kubelet `hostPath` check. ([#100482](https://github.com/kubernetes/kubernetes/pull/100482), [@pohly](https://github.com/pohly))
- Ignore `not a vmss instance` error for VMAS nodes in `EnsureBackendPoolDeleted`. ([#105185](https://github.com/kubernetes/kubernetes/pull/105185), [@ialidzhikov](https://github.com/ialidzhikov))
- Kube-apiserver: fix a memory leak when deleting multiple objects with a `deletecollection`. ([#105606](https://github.com/kubernetes/kubernetes/pull/105606), [@sxllwx](https://github.com/sxllwx))
- Kubeadm: do not allow empty `--config` paths to be passed to `kubeadm kubeconfig user` ([#105649](https://github.com/kubernetes/kubernetes/pull/105649), [@navist2020](https://github.com/navist2020))
- Kubelet did not report `kubelet_volume_stats_*` metrics for Generic Ephemeral Volumes. ([#105569](https://github.com/kubernetes/kubernetes/pull/105569), [@pohly](https://github.com/pohly))
- Kubelet's Node Grace Shutdown will terminate probes when shutting down ([#105215](https://github.com/kubernetes/kubernetes/pull/105215), [@rphillips](https://github.com/rphillips))
- Migrated kubernetes object references (= name + namespace) to structured logging when using JSON as log output format ([#104877](https://github.com/kubernetes/kubernetes/pull/104877), [@pohly](https://github.com/pohly))
- Podresources interface was changed, now it returns only isolated CPUs ([#97415](https://github.com/kubernetes/kubernetes/pull/97415), [@AlexeyPerevalov](https://github.com/AlexeyPerevalov))
- Resolves a potential issue with GC and NS controllers which may delete objects after getting a 404 response from the server during its startup. This PR ensures that requests to aggregated APIs will get 503, not 404 while the APIServiceRegistrationController hasn't finished its job. ([#104748](https://github.com/kubernetes/kubernetes/pull/104748), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Revert building binaries with PIE mode. ([#105352](https://github.com/kubernetes/kubernetes/pull/105352), [@ehashman](https://github.com/ehashman))
- Support more than 100 disk mounts on Windows ([#105673](https://github.com/kubernetes/kubernetes/pull/105673), [@andyzhangx](https://github.com/andyzhangx))
- Support using negative array index in JSON patch replace operations. ([#105896](https://github.com/kubernetes/kubernetes/pull/105896), [@zqzten](https://github.com/zqzten))
- The `--leader-elect*` CLI args are now honored in scheduler. ([#105915](https://github.com/kubernetes/kubernetes/pull/105915), [@Huang-Wei](https://github.com/Huang-Wei))
- The `--leader-elect*` CLI args are now honored in the scheduler. ([#105712](https://github.com/kubernetes/kubernetes/pull/105712), [@Huang-Wei](https://github.com/Huang-Wei))
- The `client-go` dynamic client sets the header `Content-Type: application/json` by default ([#104327](https://github.com/kubernetes/kubernetes/pull/104327), [@sxllwx](https://github.com/sxllwx))
- The `pods/binding` subresource now honors `metadata.uid` and `metadata.resourceVersion` ([#105913](https://github.com/kubernetes/kubernetes/pull/105913), [@aholic](https://github.com/aholic))
- Topology Hints now excludes control plane notes from capacity calculations. ([#104744](https://github.com/kubernetes/kubernetes/pull/104744), [@robscott](https://github.com/robscott))
- Watch requests that are delegated to aggregated API servers no longer reserve concurrency units (seats) in the API Priority and Fairness dispatcher for their entire duration. ([#105511](https://github.com/kubernetes/kubernetes/pull/105511), [@benluddy](https://github.com/benluddy))
- `--log-flush-frequency` had no effect in several commands or was missing. Help and warning texts were not always using the right format for a command (`add_dir_header` instead of `add-dir-header`). Fixing this included cleaning up flag handling in component-base/logs: that package no longer adds flags to the global flag sets. Commands which want the klog and `--log-flush-frequency` flags must explicitly call `logs.AddFlags`; the new `cli.Run` does that for commands. That helper function also covers flag normalization and printing of usage and errors in a consistent way (print usage text first if parsing failed, then the error). ([#105076](https://github.com/kubernetes/kubernetes/pull/105076), [@pohly](https://github.com/pohly))

### Other (Cleanup or Flake)

- All `klog` flags except for `-v` and `-vmodule` are deprecated. Support for `-vmodule` is only guaranteed for the text log format. ([#105042](https://github.com/kubernetes/kubernetes/pull/105042), [@pohly](https://github.com/pohly))
- Kube-apiserver: requests to node, Service, and Pod `/proxy` subresources with no additional URL path now only automatically redirect GET and HEAD requests. ([#95128](https://github.com/kubernetes/kubernetes/pull/95128), [@Riaankl](https://github.com/Riaankl))
- Migrate `pkg/scheduler/framework/plugins/interpodaffinity/filtering.go`,`pkg/scheduler/framework/plugins/podtopologyspread/filtering.go`, `pkg/scheduler/framework/plugins/volumezone/volume_zone.go` to structured logging ([#105931](https://github.com/kubernetes/kubernetes/pull/105931), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Migrated `cmd/kube-scheduler/app/server.go`, `pkg/scheduler/framework/plugins/nodelabel/node_label.go`, `pkg/scheduler/framework/plugins/nodevolumelimits/csi.go`, `pkg/scheduler/framework/plugins/nodevolumelimits/non_csi.go` to structured logging ([#105855](https://github.com/kubernetes/kubernetes/pull/105855), [@shivanshu1333](https://github.com/shivanshu1333))
- Migrated `pkg/proxy/ipvs` to structured logging ([#104932](https://github.com/kubernetes/kubernetes/pull/104932), [@shivanshu1333](https://github.com/shivanshu1333))
- Migrated `pkg/proxy` to structured logging ([#104891](https://github.com/kubernetes/kubernetes/pull/104891), [@shivanshu1333](https://github.com/shivanshu1333))
- Support allocating whole NUMA nodes in the CPUManager when there is not a 1:1 mapping between socket and NUMA node ([#102015](https://github.com/kubernetes/kubernetes/pull/102015), [@klueska](https://github.com/klueska))