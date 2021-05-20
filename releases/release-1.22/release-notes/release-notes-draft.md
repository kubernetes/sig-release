## Urgent Upgrade Notes 

### (No, really, you MUST read this before you upgrade)

- Audit log files are now created with a mode of 0600. Existing file permissions will not be changed. If you need the audit file to be readable by a non-root user, you can pre-create the file with the desired permissions. ([#95387](https://github.com/kubernetes/kubernetes/pull/95387), [@JAORMX](https://github.com/JAORMX)) [SIG API Machinery and Auth]
 - Newly provisioned PVs by Azure disk will no longer have the beta FailureDomain label. Azure disk volume plugin will start to have GA topology label instead. ([#101534](https://github.com/kubernetes/kubernetes/pull/101534), [@kassarl](https://github.com/kassarl)) [SIG Cloud Provider and Storage]
 
## Changes by Kind

### Deprecation

- Kubeadm: remove the deprecated kubeadm API v1beta1. Introduce a new kubeadm API v1beta3. See https://pkg.go.dev/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta3 for a list of changes since v1beta2. Note that v1beta2 is not yet deprecated, but will be in a future release. ([#101129](https://github.com/kubernetes/kubernetes/pull/101129), [@neolit123](https://github.com/neolit123)) [SIG Cluster Lifecycle]
- PodUnknown phase is now deprecated. ([#95286](https://github.com/kubernetes/kubernetes/pull/95286), [@SergeyKanzhelev](https://github.com/SergeyKanzhelev)) [SIG Apps, CLI, Network, Node, Storage and Testing]
- Removal of the CSI nodepublish path by the kubelet is deprecated. This must be done by the CSI plugin according to the CSI spec. ([#101441](https://github.com/kubernetes/kubernetes/pull/101441), [@dobsonj](https://github.com/dobsonj)) [SIG Storage]

### API Change

- "Auto" is now a valid value for the `service.kubernetes.io/topology-aware-hints` annotation. ([#100728](https://github.com/kubernetes/kubernetes/pull/100728), [@robscott](https://github.com/robscott)) [SIG Apps, Instrumentation and Network]
- Add three metrics to job controller to monitor if Job works in a healthy condition.
  IndexedJob promoted to Beta ([#101292](https://github.com/kubernetes/kubernetes/pull/101292), [@AliceZhang2016](https://github.com/AliceZhang2016)) [SIG Apps, Instrumentation and Testing]
- Kube-apiserver: `--service-account-issuer` can be specified multiple times now, to enable non-disruptive change of issuer. ([#101155](https://github.com/kubernetes/kubernetes/pull/101155), [@zshihang](https://github.com/zshihang)) [SIG API Machinery, Auth, Node and Testing]
- New "node-high" priority-level has been added to Suggested API Priority and Fairness configuration. ([#101151](https://github.com/kubernetes/kubernetes/pull/101151), [@mborsz](https://github.com/mborsz)) [SIG API Machinery]
- PodDeletionCost promoted to Beta ([#101080](https://github.com/kubernetes/kubernetes/pull/101080), [@ahg-g](https://github.com/ahg-g)) [SIG Apps]
- SSA treats certain structs as atomic ([#100684](https://github.com/kubernetes/kubernetes/pull/100684), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery, Auth, Node and Storage]
- Server Side Apply now treats all <Some>Selector fields as atomic (meaning the entire selector is managed by a single writer and updated together), since they contain interrelated and inseparable fields that do not merge in intuitive ways. ([#97989](https://github.com/kubernetes/kubernetes/pull/97989), [@Danil-Grigorev](https://github.com/Danil-Grigorev)) [SIG API Machinery]
- The `pods/ephemeralcontainers` API now returns and expects a `Pod` object instead of `EphemeralContainers`. This is incompatible with the previous alpha-level API. ([#101034](https://github.com/kubernetes/kubernetes/pull/101034), [@verb](https://github.com/verb)) [SIG Apps, Auth, CLI and Testing]
- The pod/eviction subresource now accepts policy/v1 Eviction requests in addition to policy/v1beta1 Eviction requests ([#100724](https://github.com/kubernetes/kubernetes/pull/100724), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Apps, Architecture, Auth, CLI, Storage and Testing]
- Track ownership of scale subresource for all scalable resources i.e. Deployment, ReplicaSet, StatefulSet, ReplicationController, and Custom Resources. ([#98377](https://github.com/kubernetes/kubernetes/pull/98377), [@nodo](https://github.com/nodo)) [SIG API Machinery and Testing]
- We have added a new Priority & Fairness rule that exempts all probes (/readyz, /healthz, /livez) to prevent 
  restarting of "healthy" kube-apiserver instance(s) by kubelet. ([#100678](https://github.com/kubernetes/kubernetes/pull/100678), [@tkashem](https://github.com/tkashem)) [SIG API Machinery]

### Feature

- Added BinaryData description to kubectl describe ([#100568](https://github.com/kubernetes/kubernetes/pull/100568), [@lauchokyip](https://github.com/lauchokyip)) [SIG CLI]
- Base image updates to mitigate kube-proxy and etcd container image CVEs
  - debian-base to buster-v1.6.0
  - debian-iptables to buster-v1.6.0 ([#100976](https://github.com/kubernetes/kubernetes/pull/100976), [@jindijamie](https://github.com/jindijamie)) [SIG Release and Testing]
- EmptyDir memory backed volumes are sized as the the minimum of pod allocatable memory on a host and an optional explicit user provided value. ([#101048](https://github.com/kubernetes/kubernetes/pull/101048), [@dims](https://github.com/dims)) [SIG Node]
- Feat: change parittion style to GPT on Windows ([#101412](https://github.com/kubernetes/kubernetes/pull/101412), [@andyzhangx](https://github.com/andyzhangx)) [SIG Storage and Windows]
- Fluentd: isolate logging resources in separate namespace ([#68004](https://github.com/kubernetes/kubernetes/pull/68004), [@saravanan30erd](https://github.com/saravanan30erd)) [SIG Cloud Provider and Instrumentation]
- It add two flags, `--max-pods` and `--extended-resources` ([#100267](https://github.com/kubernetes/kubernetes/pull/100267), [@Jeffwan](https://github.com/Jeffwan)) [SIG Node and Scalability]
- Kube config is now exposed in the scheduler framework handle. Out-of-tree plugins can leverage that to build CRD informers easily. ([#100644](https://github.com/kubernetes/kubernetes/pull/100644), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG Apps, Scheduling and Testing]
- Kubeadm: add --validity-period flag for 'kubeadm kubeconfig user' command ([#100907](https://github.com/kubernetes/kubernetes/pull/100907), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubemark's hollow-node will now print flags before starting ([#101181](https://github.com/kubernetes/kubernetes/pull/101181), [@mm4tt](https://github.com/mm4tt)) [SIG Scalability]
- Kubernetes is now built with Golang 1.16.3 ([#101206](https://github.com/kubernetes/kubernetes/pull/101206), [@justaugustus](https://github.com/justaugustus)) [SIG Cloud Provider, Instrumentation, Release and Testing]
- Promote NamespaceDefaultLabelName to GA.  All Namespace API objects have a `kubernetes.io/metadata.name` label matching their metadata.name field to allow selecting any namespace by its name using a label selector. ([#101342](https://github.com/kubernetes/kubernetes/pull/101342), [@rosenhouse](https://github.com/rosenhouse)) [SIG API Machinery and Apps]
- Run etcd as non-root on GCE provider' ([#100635](https://github.com/kubernetes/kubernetes/pull/100635), [@cindy52](https://github.com/cindy52)) [SIG Cloud Provider]
- SSA is GA ([#100139](https://github.com/kubernetes/kubernetes/pull/100139), [@Jefftree](https://github.com/Jefftree)) [SIG API Machinery]
- System-cluster-critical pods should not get a low OOM Score. 
  
  As of now both system-node-critical and system-cluster-critical pods have -997 OOM score, making them one of the last processes to be OOMKilled. By definition system-cluster-critical pods can be scheduled elsewhere if there is a resource crunch on the node where as system-node-critical pods cannot be rescheduled. This was the reason for system-node-critical to have higher priority value than system-cluster-critical.  This change allows only system-node-critical priority class to have low OOMScore.
  
  action required
  If the user wants to have the pod to be OOMKilled last and the pod has system-cluster-critical priority class, it has to be changed to system-node-critical priority class to preserve the existing behavior ([#99729](https://github.com/kubernetes/kubernetes/pull/99729), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)) [SIG Node]
- The job controller removes running pods when the number of completions was achieved. ([#99963](https://github.com/kubernetes/kubernetes/pull/99963), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps]
- `kubectl describe` will by default fetch large lists of resources in chunks of up to 500 items rather than requesting all resources up front from the server. A new flag `--chunk-size=SIZE` may be used to alter the number of items or disable this feature when `0` is passed.  This is a beta feature. ([#101171](https://github.com/kubernetes/kubernetes/pull/101171), [@KnVerey](https://github.com/KnVerey)) [SIG CLI and Testing]
- `kubectl drain` will by default fetch large lists of resources in chunks of up to 500 items rather than requesting all resources up front from the server. A new flag `--chunk-size=SIZE` may be used to alter the number of items or disable this feature when `0` is passed.  This is a beta feature. ([#100148](https://github.com/kubernetes/kubernetes/pull/100148), [@KnVerey](https://github.com/KnVerey)) [SIG CLI and Testing]

### Failing Test

- Fixed generic ephemeal volumes with OwnerReferencesPermissionEnforcement admission plugin enabled. ([#101186](https://github.com/kubernetes/kubernetes/pull/101186), [@jsafrane](https://github.com/jsafrane)) [SIG Auth and Storage]
- Fixes kubectl drain --dry-run=server ([#100206](https://github.com/kubernetes/kubernetes/pull/100206), [@KnVerey](https://github.com/KnVerey)) [SIG CLI and Testing]

### Bug or Regression

- Added privileges for EndpointSlice to the default view & edit RBAC roles ([#101203](https://github.com/kubernetes/kubernetes/pull/101203), [@mtougeron](https://github.com/mtougeron)) [SIG Auth and Security]
- Avoid caching the Azure VMSS instances whose network profile is nil ([#100948](https://github.com/kubernetes/kubernetes/pull/100948), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Azurefile: Normalize share name to not include capital letters ([#100731](https://github.com/kubernetes/kubernetes/pull/100731), [@kassarl](https://github.com/kassarl)) [SIG Cloud Provider and Storage]
- Chain the field manager creation calls in newDefaultFieldManager ([#101076](https://github.com/kubernetes/kubernetes/pull/101076), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery]
- EndpointSlice IP validation now matches Endpoints IP validation. ([#101084](https://github.com/kubernetes/kubernetes/pull/101084), [@robscott](https://github.com/robscott)) [SIG Apps and Network]
- Ensure service deleted when the Azure resource group has been deleted ([#100944](https://github.com/kubernetes/kubernetes/pull/100944), [@feiskyer](https://github.com/feiskyer)) [SIG Cloud Provider]
- Expose `rest_client_rate_limiter_duration_seconds` metric to component-base to track client side rate limiter latency in seconds. Broken down by verb and URL. ([#100311](https://github.com/kubernetes/kubernetes/pull/100311), [@IonutBajescu](https://github.com/IonutBajescu)) [SIG API Machinery, Cluster Lifecycle and Instrumentation]
- Fire an event when failing to open NodePort ([#100599](https://github.com/kubernetes/kubernetes/pull/100599), [@masap](https://github.com/masap)) [SIG Network]
- Fix EndpointSlice describe panic when an Endpoint doesn't have zone ([#101025](https://github.com/kubernetes/kubernetes/pull/101025), [@tnqn](https://github.com/tnqn)) [SIG CLI]
- Fix a bug in kube-proxy latency metrics to calculate only the latency value for the endpoints that are created after it starts running. This is needed because all the endpoints objects are processed on restarts, independently when they were generated. ([#100861](https://github.com/kubernetes/kubernetes/pull/100861), [@aojea](https://github.com/aojea)) [SIG Instrumentation and Network]
- Fix availability set cache in vmss cache ([#100110](https://github.com/kubernetes/kubernetes/pull/100110), [@CecileRobertMichon](https://github.com/CecileRobertMichon)) [SIG Cloud Provider]
- Fix display of Job completion mode in kubectl describe ([#101160](https://github.com/kubernetes/kubernetes/pull/101160), [@alculquicondor](https://github.com/alculquicondor)) [SIG Apps and CLI]
- Fix panic with kubectl create ingress annotation flag and empty value ([#101377](https://github.com/kubernetes/kubernetes/pull/101377), [@rikatz](https://github.com/rikatz)) [SIG CLI]
- Fix raw block mode CSI NodePublishVolume stage miss pod info ([#99069](https://github.com/kubernetes/kubernetes/pull/99069), [@phantooom](https://github.com/phantooom)) [SIG Storage]
- Fix rounding of volume storage requests ([#100100](https://github.com/kubernetes/kubernetes/pull/100100), [@maxlaverse](https://github.com/maxlaverse)) [SIG Cloud Provider and Storage]
- Fix: azure file inline volume namespace issue in csi migration translation ([#101235](https://github.com/kubernetes/kubernetes/pull/101235), [@andyzhangx](https://github.com/andyzhangx)) [SIG Apps, Cloud Provider, Node and Storage]
- Fix: not delete existing pip when service is deleted ([#100694](https://github.com/kubernetes/kubernetes/pull/100694), [@nilo19](https://github.com/nilo19)) [SIG Cloud Provider]
- Fix: set "host is down" as corrupted mount ([#101398](https://github.com/kubernetes/kubernetes/pull/101398), [@andyzhangx](https://github.com/andyzhangx)) [SIG Cloud Provider and Storage]
- Fixed a bug where startupProbe stopped working after a container's first restart ([#101093](https://github.com/kubernetes/kubernetes/pull/101093), [@wzshiming](https://github.com/wzshiming)) [SIG Node]
- Fixed mounting of NFS volumes when IPv6 address is used as a server. ([#101067](https://github.com/kubernetes/kubernetes/pull/101067), [@Elbehery](https://github.com/Elbehery)) [SIG Storage]
- Fixed port-forward memory leak for long-running and heavily used connections. ([#99839](https://github.com/kubernetes/kubernetes/pull/99839), [@saschagrunert](https://github.com/saschagrunert)) [SIG API Machinery and Node]
- Fixed using volume partitions on AWS Nitro systems. ([#100500](https://github.com/kubernetes/kubernetes/pull/100500), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Generated OpenAPI now correctly specifies 201 as a possible response code for PATCH operations ([#100141](https://github.com/kubernetes/kubernetes/pull/100141), [@brendandburns](https://github.com/brendandburns)) [SIG API Machinery]
- KCM sets the upper-bound timeout limit for outgoing requests to 70s. Previously no timeout was set. Requests without explicit timeout might potentially hang forever and lead to starvation of the application. ([#99358](https://github.com/kubernetes/kubernetes/pull/99358), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Kubeadm upgrade etcd to 3.4.13-3 ([#100612](https://github.com/kubernetes/kubernetes/pull/100612), [@pacoxu](https://github.com/pacoxu)) [SIG API Machinery, Cloud Provider and Cluster Lifecycle]
- Kubeadm: enable '--experimental-patches' flag for 'kubeadm join phase control-plane-join all' command ([#101110](https://github.com/kubernetes/kubernetes/pull/101110), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Kubectl create service now respects namespace flag ([#101005](https://github.com/kubernetes/kubernetes/pull/101005), [@zxh326](https://github.com/zxh326)) [SIG CLI]
- Kubelet: improve the performance when waiting for a synchronization of the node list with the kube-apiserver ([#99336](https://github.com/kubernetes/kubernetes/pull/99336), [@neolit123](https://github.com/neolit123)) [SIG Node]
- Logging for GCE Windows clusters will be more accurate and complete when using Fluent-bit. ([#101271](https://github.com/kubernetes/kubernetes/pull/101271), [@jeremyje](https://github.com/jeremyje)) [SIG Cloud Provider and Windows]
- No support endpointslice in linux userpace mode ([#100913](https://github.com/kubernetes/kubernetes/pull/100913), [@JornShen](https://github.com/JornShen)) [SIG Network]
- Prevent Kubelet stuck in DiskPressure when imagefs minReclaim is set ([#99095](https://github.com/kubernetes/kubernetes/pull/99095), [@maxlaverse](https://github.com/maxlaverse)) [SIG Node]
- Reduce vSphere volume name to 63 characters ([#100404](https://github.com/kubernetes/kubernetes/pull/100404), [@gnufied](https://github.com/gnufied)) [SIG Storage]
- Reduces delay initializing on non-AWS platforms docker runtime. ([#93260](https://github.com/kubernetes/kubernetes/pull/93260), [@nckturner](https://github.com/nckturner)) [SIG Cloud Provider]
- Removed `/sbin/apparmor_parser` requirement for the AppArmor host validation.
  This allows using AppArmor on distributions which ship the binary in a different path. ([#97968](https://github.com/kubernetes/kubernetes/pull/97968), [@saschagrunert](https://github.com/saschagrunert)) [SIG Node and Testing]
- Renames the timeout field for the DelegatingAuthenticationOptions to TokenRequestTimeout and set the timeout only for the token review client. Previously the timeout was also applied to watches making them reconnecting every 10 seconds. ([#100959](https://github.com/kubernetes/kubernetes/pull/100959), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery, Auth and Cloud Provider]
- Reorganized iptables rules to reduce rules in KUBE-SERVICES and KUBE-NODEPORTS chains and improve performance ([#96959](https://github.com/kubernetes/kubernetes/pull/96959), [@tssurya](https://github.com/tssurya)) [SIG Network]
- Respect ExecProbeTimeout=false for dockershim ([#100200](https://github.com/kubernetes/kubernetes/pull/100200), [@jackfrancis](https://github.com/jackfrancis)) [SIG Node and Testing]
- Restore kind-specific output for `kubectl describe podsecuritypolicy` ([#101436](https://github.com/kubernetes/kubernetes/pull/101436), [@KnVerey](https://github.com/KnVerey)) [SIG CLI]
- The kubelet now reports distinguishes log messages about certificate rotation for its client cert and server cert separately to make debugging problems with one or the other easier. ([#101252](https://github.com/kubernetes/kubernetes/pull/101252), [@smarterclayton](https://github.com/smarterclayton)) [SIG API Machinery and Auth]
- Updates dependency sigs.k8s.io/structured-merge-diff to v4.1.1 ([#100784](https://github.com/kubernetes/kubernetes/pull/100784), [@kevindelgado](https://github.com/kevindelgado)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation and Storage]
- Upgrades functionality of `kubectl kustomize` as described at
  https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.1.2 ([#101120](https://github.com/kubernetes/kubernetes/pull/101120), [@monopole](https://github.com/monopole)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Use default timeout of 10s for Azure ACR credential provider. ([#100686](https://github.com/kubernetes/kubernetes/pull/100686), [@hasheddan](https://github.com/hasheddan)) [SIG Cloud Provider]
- [kubeadm] Support for custom imagetags for etcd images which contain build metadata, when imagetags are in the form of version_metadata. For instance, if the etcd version is v3.4.13+patch.0, the supported imagetag would be v3.4.13_patch.0 ([#100350](https://github.com/kubernetes/kubernetes/pull/100350), [@jr0d](https://github.com/jr0d)) [SIG Cluster Lifecycle]

### Other (Cleanup or Flake)

- After the deprecation period,now the Kubelet's  `--chaos-chance` flag  are removed. ([#101057](https://github.com/kubernetes/kubernetes/pull/101057), [@wangyysde](https://github.com/wangyysde)) [SIG Node]
- DynamicFakeClient now exposes its tracker via a `Tracker()` function ([#100085](https://github.com/kubernetes/kubernetes/pull/100085), [@markusthoemmes](https://github.com/markusthoemmes)) [SIG API Machinery]
- Exposes WithCustomRoundTripper method for specifying a middleware function for custom HTTP behaviour for the delegated auth clients. ([#99775](https://github.com/kubernetes/kubernetes/pull/99775), [@p0lyn0mial](https://github.com/p0lyn0mial)) [SIG API Machinery]
- Fake clients now implement a `FakeClient` interface ([#100940](https://github.com/kubernetes/kubernetes/pull/100940), [@markusthoemmes](https://github.com/markusthoemmes)) [SIG API Machinery and Instrumentation]
- Migrate some log messages to structured logging in pkg/volume/volume_linux.go. ([#99566](https://github.com/kubernetes/kubernetes/pull/99566), [@huchengze](https://github.com/huchengze)) [SIG Instrumentation and Storage]
- Official binaries now include the golang generated build ID (`buildid`) instead of an empty string. ([#101411](https://github.com/kubernetes/kubernetes/pull/101411), [@saschagrunert](https://github.com/saschagrunert)) [SIG Release]
- Remove deprecated --generator flag from kubectl autoscale ([#99900](https://github.com/kubernetes/kubernetes/pull/99900), [@MadhavJivrajani](https://github.com/MadhavJivrajani)) [SIG CLI]
- Remove duplicate packet import ([#101187](https://github.com/kubernetes/kubernetes/pull/101187), [@GreenApple10](https://github.com/GreenApple10)) [SIG API Machinery]
- Remove the deprecated flag --generator from kubectl create deployment command ([#99915](https://github.com/kubernetes/kubernetes/pull/99915), [@BLasan](https://github.com/BLasan)) [SIG CLI]
- The `VolumeSnapshotDataSource` feature gate that is GA since v1.20 is unconditionally enabled, and can no longer be specified via the `--feature-gates` argument. ([#101531](https://github.com/kubernetes/kubernetes/pull/101531), [@ialidzhikov](https://github.com/ialidzhikov)) [SIG Storage]
- The deprecated CRIContainerLogRotation feature-gate has been removed, since the CRIContainerLogRotation feature graduated to GA in 1.21 and was unconditionally enabled. ([#101578](https://github.com/kubernetes/kubernetes/pull/101578), [@carlory](https://github.com/carlory)) [SIG Node]
- The deprecated RootCAConfigMap feature-gate has been removed, since the RootCAConfigMap feature graduated to GA in 1.21 and was unconditionally enabled. ([#101579](https://github.com/kubernetes/kubernetes/pull/101579), [@carlory](https://github.com/carlory)) [SIG Auth]
- Update Azure Go SDK version to v53.1.0 ([#101357](https://github.com/kubernetes/kubernetes/pull/101357), [@feiskyer](https://github.com/feiskyer)) [SIG API Machinery, CLI, Cloud Provider, Cluster Lifecycle and Instrumentation]
- Update cri-tools dependency to v1.21.0 ([#100956](https://github.com/kubernetes/kubernetes/pull/100956), [@saschagrunert](https://github.com/saschagrunert)) [SIG Cloud Provider and Node]

## Dependencies

### Added
- github.com/gofrs/uuid: [v4.0.0+incompatible](https://github.com/gofrs/uuid/tree/v4.0.0)
- github.com/stoewer/go-strcase: [v1.2.0](https://github.com/stoewer/go-strcase/tree/v1.2.0)
- go.uber.org/tools: 2cfd321

### Changed
- github.com/Azure/azure-sdk-for-go: [v43.0.0+incompatible → v53.1.0+incompatible](https://github.com/Azure/azure-sdk-for-go/compare/v43.0.0...v53.1.0)
- github.com/Azure/go-autorest/autorest/adal: [v0.9.5 → v0.9.10](https://github.com/Azure/go-autorest/autorest/adal/compare/v0.9.5...v0.9.10)
- github.com/Azure/go-autorest/autorest: [v0.11.12 → v0.11.17](https://github.com/Azure/go-autorest/autorest/compare/v0.11.12...v0.11.17)
- github.com/googleapis/gnostic: [v0.4.1 → v0.5.1](https://github.com/googleapis/gnostic/compare/v0.4.1...v0.5.1)
- go.uber.org/atomic: v1.4.0 → v1.6.0
- go.uber.org/multierr: v1.1.0 → v1.5.0
- go.uber.org/zap: v1.10.0 → v1.16.0
- gopkg.in/yaml.v3: 9f266ea → eeeca48
- k8s.io/kube-openapi: 591a79e → 9528897
- sigs.k8s.io/kustomize/api: v0.8.5 → v0.8.8
- sigs.k8s.io/kustomize/cmd/config: v0.9.7 → v0.9.10
- sigs.k8s.io/kustomize/kustomize/v4: v4.0.5 → v4.1.2
- sigs.k8s.io/kustomize/kyaml: v0.10.15 → v0.10.17
- sigs.k8s.io/structured-merge-diff/v4: v4.1.0 → v4.1.1

### Removed
- github.com/satori/go.uuid: [v1.2.0](https://github.com/satori/go.uuid/tree/v1.2.0)
