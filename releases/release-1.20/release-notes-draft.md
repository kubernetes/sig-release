# Release notes for v1.20.0-alpha.2

[Documentation](https://docs.k8s.io/docs/home)
# Changelog since v1.19.0

## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- The deprecated flag --experimental-kustomize is now removed from kubeadm commands. Use --experimental-patches instead, which was introduced in 1.19. Migration infromation available in --help description for --exprimental-patches. ([#94871](https://github.com/kubernetes/kubernetes/pull/94871), [@neolit123](https://github.com/neolit123))
 
## Changes by Kind

### Deprecation

- Action-required: kubeadm: graduate the "kubeadm alpha certs" command to a parent command "kubeadm certs". The command "kubeadm alpha certs" is deprecated and will be removed in a future release. Please migrate. ([#94938](https://github.com/kubernetes/kubernetes/pull/94938), [@yagonobre](https://github.com/yagonobre)) [SIG Cluster Lifecycle]
- Kubeadm: deprecate self-hosting support. The experimental command "kubeadm alpha self-hosting" is now deprecated and will be removed in a future release. ([#95125](https://github.com/kubernetes/kubernetes/pull/95125), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated "kubeadm alpha kubelet config enable-dynamic" command. To continue using the feature please defer to the guide for "Dynamic Kubelet Configuration" at k8s.io. This change also removes the parent command "kubeadm alpha kubelet" as there are no more sub-commands under it for the time being. ([#94668](https://github.com/kubernetes/kubernetes/pull/94668), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: remove the deprecated --kubelet-config flag for the command "kubeadm upgrade node" ([#94869](https://github.com/kubernetes/kubernetes/pull/94869), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubelet's deprecated endpoint `metrics/resource/v1alpha1` has been removed, please adopt to `metrics/resource`. ([#94272](https://github.com/kubernetes/kubernetes/pull/94272), [@RainbowMango](https://github.com/RainbowMango)) [SIG Instrumentation and Node]
- Removes deprecated scheduler metrics DeprecatedSchedulingDuration, DeprecatedSchedulingAlgorithmPredicateEvaluationSecondsDuration, DeprecatedSchedulingAlgorithmPriorityEvaluationSecondsDuration ([#94884](https://github.com/kubernetes/kubernetes/pull/94884), [@arghya88](https://github.com/arghya88)) [SIG Instrumentation and Scheduling]
- Scheduler alpha metrics binding_duration_seconds and scheduling_algorithm_preemption_evaluation_seconds are deprecated, Both of those metrics are now covered as part of framework_extension_point_duration_seconds, the former as a PostFilter the latter and a Bind plugin. The plan is to remove both in 1.21 ([#95001](https://github.com/kubernetes/kubernetes/pull/95001), [@arghya88](https://github.com/arghya88)) [SIG Instrumentation and Scheduling]
- The v1alpha1 PodPreset API and admission plugin has been removed with no built-in replacement. Admission webhooks can be used to modify pods on creation. ([#94090](https://github.com/kubernetes/kubernetes/pull/94090), [@deads2k](https://github.com/deads2k)) [SIG API Machinery, Apps, CLI, Cloud Provider, Scalability and Testing]

### API Change

- A new `nofuzz` go build tag now disables gofuzz support. Release binaries enable this. ([#92491](https://github.com/kubernetes/kubernetes/pull/92491), [@BenTheElder](https://github.com/BenTheElder)) [SIG API Machinery]
- External facing API podresources is now available under k8s.io/kubelet/pkg/apis/ ([#92632](https://github.com/kubernetes/kubernetes/pull/92632), [@RenaudWasTaken](https://github.com/RenaudWasTaken)) [SIG Node and Testing]
- Fix conversions for custom metrics. ([#94481](https://github.com/kubernetes/kubernetes/pull/94481), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Instrumentation]
- GPU metrics provided by kubelet are now disabled by default. ([#95184](https://github.com/kubernetes/kubernetes/pull/95184), [@RenaudWasTaken](https://github.com/RenaudWasTaken))
- Kube-controller-manager: volume plugins can be restricted from contacting local and loopback addresses by setting `--volume-host-allow-local-loopback=false`, or from contacting specific CIDR ranges by setting `--volume-host-cidr-denylist` (for example, `--volume-host-cidr-denylist=127.0.0.1/28,feed::/16`) ([#91785](https://github.com/kubernetes/kubernetes/pull/91785), [@mattcary](https://github.com/mattcary)) [SIG API Machinery, Apps, Auth, CLI, Network, Node, Storage and Testing]
- Migrate scheduler, controller-manager and cloud-controller-manager to use LeaseLock ([#94603](https://github.com/kubernetes/kubernetes/pull/94603), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery, Apps, Cloud Provider and Scheduling]
- Modify DNS-1123 error messages to indicate that RFC 1123 is not followed exactly ([#94182](https://github.com/kubernetes/kubernetes/pull/94182), [@mattfenwick](https://github.com/mattfenwick)) [SIG API Machinery, Apps, Auth, Network and Node]
- Server Side Apply now treats LabelSelector fields as atomic (meaning the entire selector is managed by a single writer and updated together), since they contain interrelated and inseparable fields that do not merge in intuitive ways. ([#93901](https://github.com/kubernetes/kubernetes/pull/93901), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Storage and Testing]
- The ServiceAccountIssuerDiscovery feature gate is now Beta and enabled by default. ([#91921](https://github.com/kubernetes/kubernetes/pull/91921), [@mtaufen](https://github.com/mtaufen)) [SIG Auth]
- The status of v1beta1 CRDs without "preserveUnknownFields:false" now shows a violation, "spec.preserveUnknownFields: Invalid value: true: must be false". ([#93078](https://github.com/kubernetes/kubernetes/pull/93078), [@vareti](https://github.com/vareti))
- WinOverlay feature graduated to beta ([#94807](https://github.com/kubernetes/kubernetes/pull/94807), [@ksubrmnn](https://github.com/ksubrmnn)) [SIG Windows]

### Feature

- Add foreground cascading deletion to kubectl with the new `kubectl delete foreground|background|orphan` option. ([#93384](https://github.com/kubernetes/kubernetes/pull/93384), [@zhouya0](https://github.com/zhouya0))
- Add metrics for azure service operations (route and loadbalancer). ([#94124](https://github.com/kubernetes/kubernetes/pull/94124), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider and Instrumentation]
- Add network rule support in Azure account creation. ([#94239](https://github.com/kubernetes/kubernetes/pull/94239), [@andyzhangx](https://github.com/andyzhangx))
- Added `get-users` and `delete-user` to the `kubectl config` subcommand ([#89840](https://github.com/kubernetes/kubernetes/pull/89840), [@eddiezane](https://github.com/eddiezane)) [SIG CLI]
- Added counter metric "apiserver_request_self" to count API server self-requests with labels for verb, resource, and subresource. ([#94288](https://github.com/kubernetes/kubernetes/pull/94288), [@LogicalShark](https://github.com/LogicalShark)) [SIG API Machinery, Auth, Instrumentation and Scheduling]
- Added new k8s.io/component-helpers repository providing shared helper code for (core) components. ([#92507](https://github.com/kubernetes/kubernetes/pull/92507), [@ingvagabund](https://github.com/ingvagabund)) [SIG Apps, Node, Release and Scheduling]
- Azure: Support multiple services sharing one IP address ([#94991](https://github.com/kubernetes/kubernetes/pull/94991), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Configure AWS LoadBalancer health check protocol via service annotations. ([#94546](https://github.com/kubernetes/kubernetes/pull/94546), [@kishorj](https://github.com/kishorj))
- Ephemeral containers now apply the same API defaults as initContainers and containers ([#94896](https://github.com/kubernetes/kubernetes/pull/94896), [@wawa0210](https://github.com/wawa0210)) [SIG Apps and CLI]
- In dual-stack bare-metal clusters, you can now pass dual-stack IPs to `kubelet --node-ip`.
  eg: `kubelet --node-ip 10.1.0.5,fd01::0005`. This is not yet supported for non-bare-metal
  clusters.
  
  In dual-stack clusters where nodes have dual-stack addresses, hostNetwork pods
  will now get dual-stack PodIPs. ([#95239](https://github.com/kubernetes/kubernetes/pull/95239), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- Introduces a new GCE specific cluster creation variable KUBE_PROXY_DISABLE. When set to true, this will skip over the creation of kube-proxy (whether the daemonset or static pod). This can be used to control the lifecycle of kube-proxy separately from the lifecycle of the nodes. ([#91977](https://github.com/kubernetes/kubernetes/pull/91977), [@varunmar](https://github.com/varunmar)) [SIG Cloud Provider]
- Kubeadm now prints warnings instead of throwing errors if the current system time is outside of the NotBefore and NotAfter bounds of a loaded certificate.  ([#94504](https://github.com/kubernetes/kubernetes/pull/94504), [@neolit123](https://github.com/neolit123))
- Kubeadm: Add a preflight check that the control-plane node has at least 1700MB of RAM ([#93275](https://github.com/kubernetes/kubernetes/pull/93275), [@xlgao-zju](https://github.com/xlgao-zju)) [SIG Cluster Lifecycle]
- Kubeadm: add the "--cluster-name" flag to the "kubeadm alpha kubeconfig user" to allow configuring the cluster name in the generated kubeconfig file ([#93992](https://github.com/kubernetes/kubernetes/pull/93992), [@prabhu43](https://github.com/prabhu43)) [SIG Cluster Lifecycle]
- Kubeadm: add the "--kubeconfig" flag to the "kubeadm init phase upload-certs" command to allow users to pass a custom location for a kubeconfig file. ([#94765](https://github.com/kubernetes/kubernetes/pull/94765), [@zhanw15](https://github.com/zhanw15)) [SIG Cluster Lifecycle]
- Kubeadm: make etcd pod request 100m CPU, 100Mi memory and 100Mi ephemeral_storage by default ([#94479](https://github.com/kubernetes/kubernetes/pull/94479), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubeadm: make the command "kubeadm alpha kubeconfig user" accept a "--config" flag and remove the following flags:
  - apiserver-advertise-address / apiserver-bind-port: use either localAPIEndpoint from InitConfiguration or controlPlaneEndpoint from ClusterConfiguration.
  - cluster-name: use clusterName from ClusterConfiguration
  - cert-dir: use certificatesDir from ClusterConfiguration ([#94879](https://github.com/kubernetes/kubernetes/pull/94879), [@knight42](https://github.com/knight42)) [SIG Cluster Lifecycle]
- Kubectl rollout history sts/sts-name --revision=some-revision will start showing the detailed view of  the sts on that specified revision ([#86506](https://github.com/kubernetes/kubernetes/pull/86506), [@dineshba](https://github.com/dineshba)) [SIG CLI]
- Kubemark now supports both real and hollow nodes in a single cluster. ([#93201](https://github.com/kubernetes/kubernetes/pull/93201), [@ellistarn](https://github.com/ellistarn)) [SIG Scalability]
- Kubernetes is now built using go1.15.2
  - build: Update to k/repo-infra@v0.1.1 (supports go1.15.2)
  - build: Use go-runner:buster-v2.0.1 (built using go1.15.1)
  - bazel: Replace --features with Starlark build settings flag
  - hack/lib/util.sh: some bash cleanups
    
    - switched one spot to use kube::logging
    - make kube::util::find-binary return an error when it doesn't find
      anything so that hack scripts fail fast instead of with '' binary not
      found errors.
    - this required deleting some genfeddoc stuff. the binary no longer
      exists in k/k repo since we removed federation/, and I don't see it
      in https://github.com/kubernetes-sigs/kubefed/ either. I'm assuming
      that it's gone for good now.
  
  - bazel: output go_binary rule directly from go_binary_conditional_pure
    
    From: @mikedanese:
    Instead of aliasing. Aliases are annoying in a number of ways. This is
    specifically bugging me now because they make the action graph harder to
    analyze programmatically. By using aliases here, we would need to handle
    potentially aliased go_binary targets and dereference to the effective
    target.
  
    The comment references an issue with `pure = select(...)` which appears
    to be resolved considering this now builds.
  
  - make kube::util::find-binary not dependent on bazel-out/ structure
  
    Implement an aspect that outputs go_build_mode metadata for go binaries,
    and use that during binary selection. ([#94449](https://github.com/kubernetes/kubernetes/pull/94449), [@justaugustus](https://github.com/justaugustus)) [SIG Architecture, CLI, Cluster Lifecycle, Node, Release and Testing]
- Only update Azure data disks when attach/detach ([#94265](https://github.com/kubernetes/kubernetes/pull/94265), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Promote SupportNodePidsLimit to GA to provide node-to-pod PID isolation.
  Promote SupportPodPidsLimit to GA to provide ability to limit PIDs per pod. ([#94140](https://github.com/kubernetes/kubernetes/pull/94140), [@derekwaynecarr](https://github.com/derekwaynecarr))
- Send GCE node startup scripts logs to console and journal. ([#95311](https://github.com/kubernetes/kubernetes/pull/95311), [@karan](https://github.com/karan))
- Support [service.beta.kubernetes.io/azure-pip-ip-tags] annotations to allow customers to specify ip-tags to influence public-ip creation in Azure [Tag1=Value1, Tag2=Value2, etc.] ([#94114](https://github.com/kubernetes/kubernetes/pull/94114), [@MarcPow](https://github.com/MarcPow)) [SIG Cloud Provider]

### Documentation

- Kubelet: remove alpha warnings for CNI flags. ([#94508](https://github.com/kubernetes/kubernetes/pull/94508), [@andrewsykim](https://github.com/andrewsykim)) [SIG Network and Node]

### Bug or Regression

- Add kubectl wait  --ignore-not-found flag ([#90969](https://github.com/kubernetes/kubernetes/pull/90969), [@zhouya0](https://github.com/zhouya0)) [SIG CLI]
- Azure ARM client: don't segfault on empty response and http error ([#94078](https://github.com/kubernetes/kubernetes/pull/94078), [@bpineau](https://github.com/bpineau)) [SIG Cloud Provider]
- Azure armclient backoff step defaults to 1 (no retry). ([#94180](https://github.com/kubernetes/kubernetes/pull/94180), [@feiskyer](https://github.com/feiskyer))
- Azure: fix a bug that kube-controller-manager would panic if wrong Azure VMSS name is configured ([#94306](https://github.com/kubernetes/kubernetes/pull/94306), [@knight42](https://github.com/knight42)) [SIG Cloud Provider]
- Both apiserver_request_duration_seconds metrics and RequestReceivedTimestamp fields of an audit event now take into account the time a request spends in the apiserver request filters. ([#94903](https://github.com/kubernetes/kubernetes/pull/94903), [@tkashem](https://github.com/tkashem))
- Build/lib/release: Explicitly use '--platform' in building server images
  
  When we switched to go-runner for building the apiserver,
  controller-manager, and scheduler server components, we no longer
  reference the individual architectures in the image names, specifically
  in the 'FROM' directive of the server image Dockerfiles.
  
  As a result, server images for non-amd64 images copy in the go-runner
  amd64 binary instead of the go-runner that matches that architecture.
  
  This commit explicitly sets the '--platform=linux/${arch}' to ensure
  we're pulling the correct go-runner arch from the manifest list.
  
  Before:
  `FROM ${base_image}`
  
  After:
  `FROM --platform=linux/${arch} ${base_image}` ([#94552](https://github.com/kubernetes/kubernetes/pull/94552), [@justaugustus](https://github.com/justaugustus)) [SIG Release]
- CSIDriver object can be deployed during volume attachment. ([#93710](https://github.com/kubernetes/kubernetes/pull/93710), [@Jiawei0227](https://github.com/Jiawei0227)) [SIG Apps, Node, Storage and Testing]
- Ceph RBD volume expansion now works even when ceph.conf was not provided. ([#92027](https://github.com/kubernetes/kubernetes/pull/92027), [@juliantaylor](https://github.com/juliantaylor))
- Cloud node controller: handle empty providerID from getProviderID ([#95342](https://github.com/kubernetes/kubernetes/pull/95342), [@nicolehanjing](https://github.com/nicolehanjing)) [SIG Cloud Provider]
- Do not fail sorting empty elements. ([#94666](https://github.com/kubernetes/kubernetes/pull/94666), [@soltysh](https://github.com/soltysh)) [SIG CLI]
- Dual-stack: make nodeipam compatible with existing single-stack clusters when dual-stack feature gate become enabled by default ([#90439](https://github.com/kubernetes/kubernetes/pull/90439), [@SataQiu](https://github.com/SataQiu)) [SIG API Machinery]
- Endpoint slice controller now mirrors parent's service label to its corresponding endpoint slices. ([#94443](https://github.com/kubernetes/kubernetes/pull/94443), [@aojea](https://github.com/aojea))
- Ensure getPrimaryInterfaceID not panic when network interfaces for Azure VMSS are null ([#94355](https://github.com/kubernetes/kubernetes/pull/94355), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Fix a bug where loadbalancer deletion gets stuck because of missing resource group. ([#93962](https://github.com/kubernetes/kubernetes/pull/93962), [@phiphi282](https://github.com/phiphi282))
- Fix a concurrent map writes error in kubelet ([#93773](https://github.com/kubernetes/kubernetes/pull/93773), [@knight42](https://github.com/knight42)) [SIG Node]
- Fix a panic in `kubectl debug` when a pod has multiple init or ephemeral containers. ([#94580](https://github.com/kubernetes/kubernetes/pull/94580), [@kiyoshim55](https://github.com/kiyoshim55))
- Fix a regression where kubeadm bails out with a fatal error when an optional version command line argument is supplied to the "kubeadm upgrade plan" command ([#94421](https://github.com/kubernetes/kubernetes/pull/94421), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Fix azure file migration panic ([#94853](https://github.com/kubernetes/kubernetes/pull/94853), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix detach azure disk issue when vm not exist ([#95177](https://github.com/kubernetes/kubernetes/pull/95177), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix etcd_object_counts metric reported by kube-apiserver ([#94773](https://github.com/kubernetes/kubernetes/pull/94773), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]
- Fix incorrectly reported verbs for kube-apiserver metrics for CRD objects ([#93523](https://github.com/kubernetes/kubernetes/pull/93523), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Instrumentation]
- Fix kubectl SchemaError on CRDs with schema using x-kubernetes-preserve-unknown-fields on array types. ([#94888](https://github.com/kubernetes/kubernetes/pull/94888), [@sttts](https://github.com/sttts)) [SIG API Machinery]
- Fix missing csi annotations on node during parallel csinode update. ([#94389](https://github.com/kubernetes/kubernetes/pull/94389), [@pacoxu](https://github.com/pacoxu)) [SIG Storage]
- Fix network_programming_latency metric reporting for Endpoints/EndpointSlice deletions, where we don't have correct timestamp ([#95363](https://github.com/kubernetes/kubernetes/pull/95363), [@wojtek-t](https://github.com/wojtek-t)) [SIG Network and Scalability]
- Fix race condition on timeCache locks. ([#94751](https://github.com/kubernetes/kubernetes/pull/94751), [@auxten](https://github.com/auxten))
- Fix regression on `kubectl portforward` when TCP and UCP services were configured on the same port. ([#94728](https://github.com/kubernetes/kubernetes/pull/94728), [@amorenoz](https://github.com/amorenoz))
- Fix scheduler cache snapshot when a Node is deleted before its Pods ([#95130](https://github.com/kubernetes/kubernetes/pull/95130), [@alculquicondor](https://github.com/alculquicondor)) [SIG Scheduling]
- Fix the `cloudprovider_azure_api_request_duration_seconds` metric buckets to correctly capture the latency metrics. Previously, the majority of the calls would fall in the "+Inf" bucket. ([#94873](https://github.com/kubernetes/kubernetes/pull/94873), [@marwanad](https://github.com/marwanad)) [SIG Cloud Provider and Instrumentation]
- Fix: azure disk resize error if source does not exist ([#93011](https://github.com/kubernetes/kubernetes/pull/93011), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: detach azure disk broken on Azure Stack ([#94885](https://github.com/kubernetes/kubernetes/pull/94885), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider]
- Fix: use sensitiveOptions on Windows mount ([#94126](https://github.com/kubernetes/kubernetes/pull/94126), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fixed a bug causing incorrect formatting of `kubectl describe ingress`. ([#94985](https://github.com/kubernetes/kubernetes/pull/94985), [@howardjohn](https://github.com/howardjohn)) [SIG CLI and Network]
- Fixed a bug in client-go where new clients with customized `Dial`, `Proxy`, `GetCert` config may get stale HTTP transports. ([#95427](https://github.com/kubernetes/kubernetes/pull/95427), [@roycaihw](https://github.com/roycaihw)) [SIG API Machinery]
- Fixed a bug that prevents the use of ephemeral containers in the presence of a validating admission webhook. ([#94685](https://github.com/kubernetes/kubernetes/pull/94685), [@verb](https://github.com/verb)) [SIG Node and Testing]
- Fixed a bug where improper storage and comparison of endpoints led to excessive API traffic from the endpoints controller ([#94112](https://github.com/kubernetes/kubernetes/pull/94112), [@damemi](https://github.com/damemi)) [SIG Apps, Network and Testing]
- Fixed bug in reflector that couldn't recover from "Too large resource version" errors with API servers 1.17.0-1.18.5 ([#94316](https://github.com/kubernetes/kubernetes/pull/94316), [@janeczku](https://github.com/janeczku)) [SIG API Machinery]
- Fixed bug where kubectl top pod output is not sorted when --sort-by and --containers flags are used together ([#93692](https://github.com/kubernetes/kubernetes/pull/93692), [@brianpursley](https://github.com/brianpursley)) [SIG CLI]
- Fixed kubelet creating extra sandbox for pods with RestartPolicyOnFailure after all containers succeeded ([#92614](https://github.com/kubernetes/kubernetes/pull/92614), [@tnqn](https://github.com/tnqn)) [SIG Node and Testing]
- Fixes an issue proxying to ipv6 pods without specifying a port ([#94834](https://github.com/kubernetes/kubernetes/pull/94834), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and Network]
- Gracefully delete nodes when their parent scale set went missing ([#95289](https://github.com/kubernetes/kubernetes/pull/95289), [@bpineau](https://github.com/bpineau)) [SIG Cloud Provider]
- Ignore root user check when windows pod starts ([#92355](https://github.com/kubernetes/kubernetes/pull/92355), [@wawa0210](https://github.com/wawa0210)) [SIG Node and Windows]
- In dual-stack clusters, kubelet will now set up both IPv4 and IPv6 iptables rules, which may
  fix some problems, eg with HostPorts. ([#94474](https://github.com/kubernetes/kubernetes/pull/94474), [@danwinship](https://github.com/danwinship)) [SIG Network and Node]
- Increase maximum IOPS of AWS EBS io1 volume to current maximum (64,000). ([#90014](https://github.com/kubernetes/kubernetes/pull/90014), [@jacobmarble](https://github.com/jacobmarble))
- K8s.io/apimachinery: runtime.DefaultUnstructuredConverter.FromUnstructured now handles converting integer fields to typed float values ([#93250](https://github.com/kubernetes/kubernetes/pull/93250), [@liggitt](https://github.com/liggitt)) [SIG API Machinery]
- Kube-proxy now trims extra spaces found in loadBalancerSourceRanges to match Service validation. ([#94107](https://github.com/kubernetes/kubernetes/pull/94107), [@robscott](https://github.com/robscott)) [SIG Network]
- Kubeadm ensures "kubeadm reset" does not unmount the root "/var/lib/kubelet" directory if it is mounted by the user. ([#93702](https://github.com/kubernetes/kubernetes/pull/93702), [@thtanaka](https://github.com/thtanaka))
- Kubeadm now makes sure the etcd manifest is regenerated upon upgrade even when no etcd version change takes place ([#94395](https://github.com/kubernetes/kubernetes/pull/94395), [@rosti](https://github.com/rosti)) [SIG Cluster Lifecycle]
- Kubeadm now warns (instead of error out) on missing "ca.key" files for root CA, front-proxy CA and etcd CA, during "kubeadm join --control-plane" if the user has provided all certificates, keys and kubeconfig files which require signing with the given CA keys. ([#94988](https://github.com/kubernetes/kubernetes/pull/94988), [@neolit123](https://github.com/neolit123))
- Kubeadm: avoid a panic when determining if the running version of CoreDNS is supported during upgrades ([#94299](https://github.com/kubernetes/kubernetes/pull/94299), [@zouyee](https://github.com/zouyee)) [SIG Cluster Lifecycle]
- Kubeadm: ensure the etcd data directory is created with 0700 permissions during control-plane init and join ([#94102](https://github.com/kubernetes/kubernetes/pull/94102), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: fix the bug that kubeadm tries to call 'docker info' even if the CRI socket was for another CR ([#94555](https://github.com/kubernetes/kubernetes/pull/94555), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubeadm: for Docker as the container runtime, make the "kubeadm reset" command stop containers before removing them ([#94586](https://github.com/kubernetes/kubernetes/pull/94586), [@BedivereZero](https://github.com/BedivereZero)) [SIG Cluster Lifecycle]
- Kubeadm: make the kubeconfig files for the kube-controller-manager and kube-scheduler use the LocalAPIEndpoint instead of the ControlPlaneEndpoint. This makes kubeadm clusters more reseliant to version skew problems during immutable upgrades: https://kubernetes.io/docs/setup/release/version-skew-policy/&#35;kube-controller-manager-kube-scheduler-and-cloud-controller-manager ([#94398](https://github.com/kubernetes/kubernetes/pull/94398), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: relax the validation of kubeconfig server URLs. Allow the user to define custom kubeconfig server URLs without erroring out during validation of existing kubeconfig files (e.g. when using external CA mode). ([#94816](https://github.com/kubernetes/kubernetes/pull/94816), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubelet: assume that swap is disabled when `/proc/swaps` does not exist ([#93931](https://github.com/kubernetes/kubernetes/pull/93931), [@SataQiu](https://github.com/SataQiu)) [SIG Node]
- NONE ([#71269](https://github.com/kubernetes/kubernetes/pull/71269), [@DeliangFan](https://github.com/DeliangFan)) [SIG Node]
- New Azure instance types do now have correct max data disk count information. ([#94340](https://github.com/kubernetes/kubernetes/pull/94340), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Cloud Provider and Storage]
- Port mapping now allows the same `containerPort` of different containers to different `hostPort` without naming the mapping explicitly. ([#94494](https://github.com/kubernetes/kubernetes/pull/94494), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev))
- Recreate EndpointSlices on rapid Service creation. ([#94730](https://github.com/kubernetes/kubernetes/pull/94730), [@robscott](https://github.com/robscott))
- Require feature flag CustomCPUCFSQuotaPeriod if setting a non-default cpuCFSQuotaPeriod in kubelet config. ([#94687](https://github.com/kubernetes/kubernetes/pull/94687), [@karan](https://github.com/karan)) [SIG Node]
- StatefulSet Controller now waits for PersistentVolumeClaim deletion before creating pods. ([#93457](https://github.com/kubernetes/kubernetes/pull/93457), [@ymmt2005](https://github.com/ymmt2005))
- StreamWatcher now calls HandleCrash at appropriate sequence. ([#93108](https://github.com/kubernetes/kubernetes/pull/93108), [@lixiaobing1](https://github.com/lixiaobing1))
- The `/debug/api_priority_and_fairness/dump_requests` path at an apiserver will no longer return a phantom line for each exempt priority level. ([#93406](https://github.com/kubernetes/kubernetes/pull/93406), [@MikeSpreitzer](https://github.com/MikeSpreitzer)) [SIG API Machinery]
- The kubelet recognizes the --containerd-namespace flag to configure the namespace used by cadvisor. ([#87054](https://github.com/kubernetes/kubernetes/pull/87054), [@changyaowei](https://github.com/changyaowei)) [SIG Node]
- Update Calico to v3.15.2 ([#94241](https://github.com/kubernetes/kubernetes/pull/94241), [@lmm](https://github.com/lmm)) [SIG Cloud Provider]
- Update default etcd server version to 3.4.13 ([#94287](https://github.com/kubernetes/kubernetes/pull/94287), [@jingyih](https://github.com/jingyih)) [SIG API Machinery, Cloud Provider, Cluster Lifecycle and Testing]
- Use NLB Subnet CIDRs instead of VPC CIDRs in Health Check SG Rules ([#93515](https://github.com/kubernetes/kubernetes/pull/93515), [@t0rr3sp3dr0](https://github.com/t0rr3sp3dr0)) [SIG Cloud Provider]
- Users will see increase in time for deletion of pods and also guarantee that removal of pod from api server  would mean deletion of all the resources from container runtime. ([#92817](https://github.com/kubernetes/kubernetes/pull/92817), [@kmala](https://github.com/kmala)) [SIG Node]
- Very large patches may now be specified to `kubectl patch` with the `--patch-file` flag instead of including them directly on the command line. The `--patch` and `--patch-file` flags are mutually exclusive. ([#93548](https://github.com/kubernetes/kubernetes/pull/93548), [@smarterclayton](https://github.com/smarterclayton)) [SIG CLI]
- Warn instead of fail when creating Roles and ClusterRoles with custom verbs via kubectl ([#92492](https://github.com/kubernetes/kubernetes/pull/92492), [@eddiezane](https://github.com/eddiezane)) [SIG CLI]

### Other (Cleanup or Flake)

- Add fine grained debugging to intra-pod conformance test to troubleshoot networking issues for potentially unhealthy nodes when running conformance or sonobuoy tests. ([#93837](https://github.com/kubernetes/kubernetes/pull/93837), [@jayunit100](https://github.com/jayunit100))
- Add the following metrics:
  - network_plugin_operations_total
  - network_plugin_operations_errors_total ([#93066](https://github.com/kubernetes/kubernetes/pull/93066), [@AnishShah](https://github.com/AnishShah))
- Adds a bootstrapping ClusterRole, ClusterRoleBinding and group for /metrics, /livez/*, /readyz/*, & /healthz/- endpoints. ([#93311](https://github.com/kubernetes/kubernetes/pull/93311), [@logicalhan](https://github.com/logicalhan)) [SIG API Machinery, Auth, Cloud Provider and Instrumentation]
- AdmissionReview objects sent for the creation of Namespace API objects now populate the `namespace` attribute consistently (previously the `namespace` attribute was empty for Namespace creation via POST requests, and populated for Namespace creation via server-side-apply PATCH requests) ([#95012](https://github.com/kubernetes/kubernetes/pull/95012), [@nodo](https://github.com/nodo)) [SIG API Machinery and Testing]
- Base-images: Update to debian-iptables:buster-v1.3.0
  - Uses iptables 1.8.5
  - base-images: Update to debian-base:buster-v1.2.0
  - cluster/images/etcd: Build etcd:3.4.13-1 image
    - Uses debian-base:buster-v1.2.0 ([#94733](https://github.com/kubernetes/kubernetes/pull/94733), [@justaugustus](https://github.com/justaugustus)) [SIG API Machinery, Release and Testing]
- Client-go header logging (at verbosity levels >= 9) now masks `Authorization` header contents ([#95316](https://github.com/kubernetes/kubernetes/pull/95316), [@sfowl](https://github.com/sfowl)) [SIG API Machinery]
- Decrease warning message frequency on setting volume ownership for configmap/secret. ([#92878](https://github.com/kubernetes/kubernetes/pull/92878), [@jvanz](https://github.com/jvanz))
- Enhance log information of verifyRunAsNonRoot, add pod, container information ([#94911](https://github.com/kubernetes/kubernetes/pull/94911), [@wawa0210](https://github.com/wawa0210)) [SIG Node]
- Fix kubelet to properly log when a container is started. Previously, kubelet may log that container is dead and was restarted when it was actually started for the first time. This behavior only happened on pods with initContainers and regular containers. ([#91469](https://github.com/kubernetes/kubernetes/pull/91469), [@rata](https://github.com/rata))
- Fixes the message about no auth for metrics in scheduler. ([#94035](https://github.com/kubernetes/kubernetes/pull/94035), [@zhouya0](https://github.com/zhouya0)) [SIG Scheduling]
- Kubeadm: Separate argument key/value in log msg ([#94016](https://github.com/kubernetes/kubernetes/pull/94016), [@mrueg](https://github.com/mrueg)) [SIG Cluster Lifecycle]
- Kubeadm: remove the CoreDNS check for known image digests when applying the addon ([#94506](https://github.com/kubernetes/kubernetes/pull/94506), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- Kubeadm: update the default pause image version to 1.4.0 on Windows. With this update the image supports Windows versions 1809 (2019LTS), 1903, 1909, 2004 ([#95419](https://github.com/kubernetes/kubernetes/pull/95419), [@jsturtevant](https://github.com/jsturtevant)) [SIG Cluster Lifecycle and Windows]
- Lock ExternalPolicyForExternalIP to default, this feature gate will be removed in 1.22. ([#94581](https://github.com/kubernetes/kubernetes/pull/94581), [@knabben](https://github.com/knabben)) [SIG Network]
- Mask ceph RBD adminSecrets in logs when logLevel >= 4. ([#95245](https://github.com/kubernetes/kubernetes/pull/95245), [@sfowl](https://github.com/sfowl))
- NONE ([#95098](https://github.com/kubernetes/kubernetes/pull/95098), [@phunziker](https://github.com/phunziker))
- NONE ([#95412](https://github.com/kubernetes/kubernetes/pull/95412), [@saikat-royc](https://github.com/saikat-royc))
- Remove offensive words from kubectl cluster-info command. ([#95202](https://github.com/kubernetes/kubernetes/pull/95202), [@rikatz](https://github.com/rikatz))
- Remove support for "ci/k8s-master" version label in kubeadm, use "ci/latest" instead. See kubernetes/test-infra&#35;18517. ([#93626](https://github.com/kubernetes/kubernetes/pull/93626), [@vikkyomkar](https://github.com/vikkyomkar))
- Service.beta.kubernetes.io/azure-load-balancer-disable-tcp-reset is removed.  All Standard load balancers will always enable tcp resets. ([#94297](https://github.com/kubernetes/kubernetes/pull/94297), [@MarcPow](https://github.com/MarcPow)) [SIG Cloud Provider]
- Stop propagating SelfLink (deprecated in 1.16) in kube-apiserver ([#94397](https://github.com/kubernetes/kubernetes/pull/94397), [@wojtek-t](https://github.com/wojtek-t)) [SIG API Machinery and Testing]
- Strip unnecessary security contexts on Windows ([#93475](https://github.com/kubernetes/kubernetes/pull/93475), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Node, Testing and Windows]
- To ensure the code be strong,  add unit test for GetAddressAndDialer ([#93180](https://github.com/kubernetes/kubernetes/pull/93180), [@FreeZhang61](https://github.com/FreeZhang61)) [SIG Node]
- Update CNI plugins to v0.8.7 ([#94367](https://github.com/kubernetes/kubernetes/pull/94367), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Network, Node, Release and Testing]
- Update cri-tools to [v1.19.0](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.19.0) ([#94307](https://github.com/kubernetes/kubernetes/pull/94307), [@xmudrii](https://github.com/xmudrii)) [SIG Cloud Provider]
- Update etcd client side to v3.4.13 ([#94259](https://github.com/kubernetes/kubernetes/pull/94259), [@jingyih](https://github.com/jingyih)) [SIG API Machinery and Cloud Provider]
- Vsphere: improve logging message on node cache refresh event ([#95236](https://github.com/kubernetes/kubernetes/pull/95236), [@andrewsykim](https://github.com/andrewsykim)) [SIG Cloud Provider]
- `kubectl api-resources` now prints the API version (as 'API group/version', same as output of `kubectl api-versions`). The column APIGROUP is now APIVERSION ([#95253](https://github.com/kubernetes/kubernetes/pull/95253), [@sallyom](https://github.com/sallyom)) [SIG CLI]
- `kubectl get ingress` now prefers the `networking.k8s.io/v1` over `extensions/v1beta1` (deprecated since v1.14). To explicitly request the deprecated version, use `kubectl get ingress.v1beta1.extensions`. ([#94309](https://github.com/kubernetes/kubernetes/pull/94309), [@liggitt](https://github.com/liggitt)) [SIG API Machinery and CLI]

## Dependencies

### Added
- github.com/Azure/go-autorest: [v14.2.0+incompatible](https://github.com/Azure/go-autorest/tree/v14.2.0)
- github.com/fvbommel/sortorder: [v1.0.1](https://github.com/fvbommel/sortorder/tree/v1.0.1)
- github.com/jmespath/go-jmespath/internal/testify: [v1.5.1](https://github.com/jmespath/go-jmespath/internal/testify/tree/v1.5.1)

### Changed
- github.com/Azure/go-autorest/autorest/adal: [v0.8.2 → v0.9.0](https://github.com/Azure/go-autorest/autorest/adal/compare/v0.8.2...v0.9.0)
- github.com/Azure/go-autorest/autorest/date: [v0.2.0 → v0.3.0](https://github.com/Azure/go-autorest/autorest/date/compare/v0.2.0...v0.3.0)
- github.com/Azure/go-autorest/autorest/mocks: [v0.3.0 → v0.4.0](https://github.com/Azure/go-autorest/autorest/mocks/compare/v0.3.0...v0.4.0)
- github.com/Azure/go-autorest/autorest: [v0.9.6 → v0.11.1](https://github.com/Azure/go-autorest/autorest/compare/v0.9.6...v0.11.1)
- github.com/Azure/go-autorest/logger: [v0.1.0 → v0.2.0](https://github.com/Azure/go-autorest/logger/compare/v0.1.0...v0.2.0)
- github.com/Azure/go-autorest/tracing: [v0.5.0 → v0.6.0](https://github.com/Azure/go-autorest/tracing/compare/v0.5.0...v0.6.0)
- github.com/aws/aws-sdk-go: [v1.28.2 → v1.35.5](https://github.com/aws/aws-sdk-go/compare/v1.28.2...v1.35.5)
- github.com/jmespath/go-jmespath: [c2b33e8 → v0.4.0](https://github.com/jmespath/go-jmespath/compare/c2b33e8...v0.4.0)
- github.com/opencontainers/go-digest: [v1.0.0-rc1 → v1.0.0](https://github.com/opencontainers/go-digest/compare/v1.0.0-rc1...v1.0.0)
- github.com/storageos/go-api: [343b3ef → v2.2.0+incompatible](https://github.com/storageos/go-api/compare/343b3ef...v2.2.0)
- go.etcd.io/etcd: 17cef6e → dd1b699
- k8s.io/kube-openapi: 6aeccd4 → 8b50664
- k8s.io/system-validators: v1.1.2 → v1.2.0
- sigs.k8s.io/apiserver-network-proxy/konnectivity-client: v0.0.9 → v0.0.12
- sigs.k8s.io/structured-merge-diff/v4: v4.0.1 → b3cf1e8

### Removed
- github.com/xlab/handysort: [fb3537e](https://github.com/xlab/handysort/tree/fb3537e)
- vbom.ml/util: db5cfe1
