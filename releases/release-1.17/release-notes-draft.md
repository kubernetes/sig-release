## Action Required

- Remove deprecated "include-uninitialized" flag. action required ([#80337](https://github.com/kubernetes/kubernetes/pull/80337), [@draveness](https://github.com/draveness))

  Courtesy of SIG CLI
- Deprecate the default service IP CIDR. The previous default was `10.0.0.0/24` which will be removed in 6 months/2 releases. Cluster admins must specify their own desired value, by using `--service-cluster-ip-range` on kube-apiserver. ([#81668](https://github.com/kubernetes/kubernetes/pull/81668), [@darshanime](https://github.com/darshanime))

  Courtesy of SIG API Machinery, and SIG Network
- The deprecated feature gates `GCERegionalPersistentDisk`, `EnableAggregatedDiscoveryTimeout` and `PersistentLocalVolumes` are now unconditionally enabled and can no longer be specified in component invocations. ([#82472](https://github.com/kubernetes/kubernetes/pull/82472), [@draveness](https://github.com/draveness))

  Courtesy of SIG API Machinery, SIG Storage, and SIG Testing


## New Features

- Added cloud operation count metrics to azure cloud controller manager. ([#82574](https://github.com/kubernetes/kubernetes/pull/82574), [@kkmsft](https://github.com/kkmsft))

  Courtesy of SIG Cloud Provider
- kubeadm: use the --service-cluster-ip-range flag to init or use the ServiceSubnet field in the kubeadm config to pass a comma separated list of Service CIDRs.  ([#82473](https://github.com/kubernetes/kubernetes/pull/82473), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- Consolidate ScoreWithNormalizePlugin into the ScorePlugin interface ([#83042](https://github.com/kubernetes/kubernetes/pull/83042), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- When registering with a 1.17+ API server, MutatingWebhookConfiguration and ValidatingWebhookConfiguration objects can now request that only `v1` AdmissionReview requests be sent to them. Previously, webhooks were required to support receiving `v1beta1` AdmissionReview requests as well for compatibility with API servers <= 1.15.
  - When registering with a 1.17+ API server, a CustomResourceDefinition conversion webhook can now request that only `v1` ConversionReview requests be sent to them. Previously, conversion webhooks were required to support receiving `v1beta1` ConversionReview requests as well for compatibility with API servers <= 1.15. ([#82707](https://github.com/kubernetes/kubernetes/pull/82707), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery
- New APIs to allow adding/removing pods from pre-calculated prefilter state in the scheduling framework ([#82912](https://github.com/kubernetes/kubernetes/pull/82912), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling, and SIG Testing
- Added metrics 'authentication_latency_seconds' that can be used to understand the latency of authentication. ([#82409](https://github.com/kubernetes/kubernetes/pull/82409), [@RainbowMango](https://github.com/RainbowMango))

  Courtesy of SIG API Machinery, SIG Auth, and SIG Instrumentation
- Reduces the number of calls made to the Azure API when requesting the instance view of a virtual machine scale set node. ([#82496](https://github.com/kubernetes/kubernetes/pull/82496), [@hasheddan](https://github.com/hasheddan))

  Courtesy of SIG Cloud Provider
- Added Clone method to the scheduling framework's PluginContext and ContextData. ([#82951](https://github.com/kubernetes/kubernetes/pull/82951), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling
- Bump version of event-exporter to 0.3.1, to switch it to protobuf. ([#83396](https://github.com/kubernetes/kubernetes/pull/83396), [@loburm](https://github.com/loburm))

  Courtesy of SIG Instrumentation, and SIG Scalability
- /test/e2e/framework: Adds a flag "non-blocking-taints" which allows tests to run in environments with tainted nodes. String value should be a comma-separated list. ([#81043](https://github.com/kubernetes/kubernetes/pull/81043), [@johnSchnake](https://github.com/johnSchnake))

  Courtesy of SIG Testing
- Remove MaxPriority in the scheduler API, please use MaxNodeScore or MaxExtenderPriority instead. ([#83386](https://github.com/kubernetes/kubernetes/pull/83386), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- Modified the scheduling framework's Filter API. ([#82842](https://github.com/kubernetes/kubernetes/pull/82842), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling, and SIG Testing
- Update crictl to v1.16.1. ([#82856](https://github.com/kubernetes/kubernetes/pull/82856), [@Random-Liu](https://github.com/Random-Liu))

  Courtesy of SIG Cluster Lifecycle, and SIG Node


## Notes From Multiple SIGs

### SIG Network, and SIG Windows

- Fixes kube-proxy bug accessing self nodeip:port on windows ([#83027](https://github.com/kubernetes/kubernetes/pull/83027), [@liggitt](https://github.com/liggitt))

### SIG Release, and SIG Testing

- The deprecated mondo `kubernetes-test` tarball is no longer built. Users running Kubernetes e2e tests should use the `kubernetes-test-portable` and `kubernetes-test-{OS}-{ARCH}` tarballs instead. ([#83093](https://github.com/kubernetes/kubernetes/pull/83093), [@ixdy](https://github.com/ixdy))
- Update to go 1.12.10 ([#83139](https://github.com/kubernetes/kubernetes/pull/83139), [@cblecker](https://github.com/cblecker))

### SIG Auth, and SIG Cluster Lifecycle

- Fix typos in `certificates.k8s.io/v1beta1` KeyUsage constant names: `UsageContentCommittment` becomes `UsageContentCommitment` and `UsageNetscapSGC` becomes `UsageNetscapeSGC`. ([#82511](https://github.com/kubernetes/kubernetes/pull/82511), [@abursavich](https://github.com/abursavich))

### SIG Cloud Provider, SIG Network, and SIG Node

- On AWS nodes with multiple network interfaces, kubelet should now more reliably report the same primary node IP. ([#80747](https://github.com/kubernetes/kubernetes/pull/80747), [@danwinship](https://github.com/danwinship))

### SIG Apps, and SIG Storage

- Report non-confusing error for negative storage size in PVC spec. ([#82759](https://github.com/kubernetes/kubernetes/pull/82759), [@sttts](https://github.com/sttts))

### SIG Scheduling, and SIG Testing

- Some scheduler extender API fields are moved from `pkg/scheduler/api` to `pkg/scheduler/apis/extender/v1`. ([#83262](https://github.com/kubernetes/kubernetes/pull/83262), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Auth, and SIG Node

- k8s dockerconfigjson secrets are now compatible with docker config desktop authentication credentials files ([#82148](https://github.com/kubernetes/kubernetes/pull/82148), [@bbourbie](https://github.com/bbourbie))

### SIG Cluster Lifecycle, SIG Network, SIG Node, and SIG Testing

- Kubernetes no longer monitors firewalld. On systems using firewalld for firewall
  maintenance, kube-proxy will take slightly longer to recover from disruptive
  firewalld operations that delete kube-proxy's iptables rules. ([#81517](https://github.com/kubernetes/kubernetes/pull/81517), [@danwinship](https://github.com/danwinship))

### SIG API Machinery, and SIG Testing

- Restores compatibility with <=1.15.x custom resources by not publishing OpenAPI for non-structural custom resource definitions ([#82653](https://github.com/kubernetes/kubernetes/pull/82653), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle, and SIG Network

- kube-dns add-on: 
  - All containers are now being executed under more restrictive privileges. 
  - Most of the containers now run as non-root user and has the root filesystem set as read-only. 
  - The remaining container running as root only has the minimum Linux capabilities it requires to run. 
  - Privilege escalation has been disabled for all containers.
   ([#82347](https://github.com/kubernetes/kubernetes/pull/82347), [@pjbgf](https://github.com/pjbgf))

### SIG Network, and SIG Node

- Fix panic in kubelet when running IPv4/IPv6 dual-stack mode with a CNI plugin ([#82508](https://github.com/kubernetes/kubernetes/pull/82508), [@aanm](https://github.com/aanm))
- The docker container runtime now enforces a 220 second timeout on container network operations. ([#71653](https://github.com/kubernetes/kubernetes/pull/71653), [@liucimin](https://github.com/liucimin))

### SIG Apps, SIG Cloud Provider, and SIG Network

- Update Azure load balancer to prevent orphaned public IP addresses ([#82890](https://github.com/kubernetes/kubernetes/pull/82890), [@chewong](https://github.com/chewong))

### SIG Cloud Provider, and SIG Storage

- Fix possible fd leak and closing of dirs when using openstack ([#82873](https://github.com/kubernetes/kubernetes/pull/82873), [@odinuge](https://github.com/odinuge))

### SIG Architecture, and SIG Testing

- Conformance tests may now include disruptive tests. If you are running tests against a live cluster, consider skipping those tests tagged as `Disruptive` to avoid non-test workloads being impacted. Be aware, skipping any conformance tests (even disruptive ones) will make the results ineligible for consideration for the CNCF Certified Kubernetes program. ([#82664](https://github.com/kubernetes/kubernetes/pull/82664), [@johnSchnake](https://github.com/johnSchnake))


## Notes from Individual SIGs

### SIG API Machinery

- Fixes a goroutine leak in kube-apiserver when a request times out. ([#83333](https://github.com/kubernetes/kubernetes/pull/83333), [@lavalamp](https://github.com/lavalamp))
- Resolves issue with /readyz and /livez not including etcd and kms health checks ([#82713](https://github.com/kubernetes/kubernetes/pull/82713), [@logicalhan](https://github.com/logicalhan))
- Resolves regression generating informers for packages whose names contain `.` characters ([#82410](https://github.com/kubernetes/kubernetes/pull/82410), [@nikhita](https://github.com/nikhita))
- Fixes regression in logging spurious stack traces when proxied connections are closed by the backend ([#82588](https://github.com/kubernetes/kubernetes/pull/82588), [@liggitt](https://github.com/liggitt))
- Fixes the bug in informer-gen that it produces incorrect code if a type has nonNamespaced tag set. ([#80458](https://github.com/kubernetes/kubernetes/pull/80458), [@tatsuhiro-t](https://github.com/tatsuhiro-t))

### SIG CLI

- &#35; kubectl rollout history sts/test-sts 
  statefulset.apps/test-sts 
  REVISION
  0
  0
  0
  1
  2
  3 ([#82643](https://github.com/kubernetes/kubernetes/pull/82643), [@ZP-AlwaysWin](https://github.com/ZP-AlwaysWin))
- Correct a reference to a not/no longer used kustomize subcommand in the documentation ([#82535](https://github.com/kubernetes/kubernetes/pull/82535), [@demobox](https://github.com/demobox))

### SIG Cloud Provider

- fix: azure disk detach failure if node not exists ([#82640](https://github.com/kubernetes/kubernetes/pull/82640), [@andyzhangx](https://github.com/andyzhangx))
- Fix aggressive VM calls for Azure VMSS ([#83102](https://github.com/kubernetes/kubernetes/pull/83102), [@feiskyer](https://github.com/feiskyer))

### SIG Cluster Lifecycle

- dashboard: disable the dashboard Deployment on non-Linux nodes. This step is required to support Windows worker nodes. ([#82975](https://github.com/kubernetes/kubernetes/pull/82975), [@wawa0210](https://github.com/wawa0210))
- [namespace test-cpzh07-18 object latency-deployment-61 creation error: Post https://35.237.145.223/apis/apps/v1/namespaces/test-cpzh07-18/deployments: dial tcp 35.237.145.223:443: connect: connection refused
  namespace test-cpzh07-18 object latency-deployment-64 creation error: Post https://35.237.145.223/apis/apps/v1/namespaces/test-cpzh07-18/deployments: dial tcp 35.237.145.223:443: connect: connection refused
  namespace test-cpzh07-18 object latency-deployment-65 creation error: Post https://35.237.145.223/apis/apps/v1/namespaces/test-cpzh07-18/deployments: dial tcp 35.237.145.223:443: connect: connection refused
  namespace test-cpzh07-17 object latency-deployment-24 creation error: Post https://35.237.145.223/apis/apps/v1/namespaces/test-cpzh07-17/deployments: dial tcp 35.237.145.223:443: connect: connection refused
  namespace test-cpzh07-17 object latency-deployment-74 creation error: Post https://35.237.145.223/apis/apps/v1/namespaces/test-cpzh07-17/deployments: dial tcp 35.237.145.223:443: connect: connection refused
  namespace test-cpzh07-18 object latency-deployment-24 creation error: Post https://35.237.145.223/apis/apps/v1/namespaces/test-cpzh07-18/deployments: dial tcp 35.237.145.223:443: connect: connection refused
  (...) ([#83390](https://github.com/kubernetes/kubernetes/pull/83390), [@mborsz](https://github.com/mborsz))
- Fixes a panic in kube-controller-manager cleaning up bootstrap tokens ([#82887](https://github.com/kubernetes/kubernetes/pull/82887), [@tedyu](https://github.com/tedyu))
- Bump metrics-server to v0.3.5 ([#83015](https://github.com/kubernetes/kubernetes/pull/83015), [@olagacek](https://github.com/olagacek))

### SIG Network

- Improved performance of kube-proxy with EndpointSlice enabled with more efficient sorting.  ([#83035](https://github.com/kubernetes/kubernetes/pull/83035), [@robscott](https://github.com/robscott))

### SIG Node

- Limit the body length of exec readiness/liveness probes. remote CRIs and Docker shim read a max of 16MB output of which the exec probe itself inspects 10kb. ([#82514](https://github.com/kubernetes/kubernetes/pull/82514), [@dims](https://github.com/dims))
- Single static pod files and pod files from http endpoints cannot be larger than 10 MB. HTTP probe payloads are now truncated to 10KB. ([#82669](https://github.com/kubernetes/kubernetes/pull/82669), [@rphillips](https://github.com/rphillips))
- Use online nodes instead of possible nodes when discovering available NUMA nodes ([#83196](https://github.com/kubernetes/kubernetes/pull/83196), [@zouyee](https://github.com/zouyee))
- Use ipv4 in wincat port forward. ([#83036](https://github.com/kubernetes/kubernetes/pull/83036), [@liyanhui1228](https://github.com/liyanhui1228))

### SIG Scheduling

- Fixed a scheduler panic when using PodAffinity. ([#82841](https://github.com/kubernetes/kubernetes/pull/82841), [@Huang-Wei](https://github.com/Huang-Wei))
- Take the context as the first argument of Schedule. ([#82119](https://github.com/kubernetes/kubernetes/pull/82119), [@wgliang](https://github.com/wgliang))
- fixed an issue that the correct PluginConfig.Args is not passed to the corresponding PluginFactory in kube-scheduler when multiple PluginConfig items are defined. ([#82483](https://github.com/kubernetes/kubernetes/pull/82483), [@everpeace](https://github.com/everpeace))

### SIG Storage

- PersistentVolumeLabel admission plugin, responsible for labeling `PersistentVolumes` with topology labels, now does not overwrite existing labels on PVs that were dynamically provisioned. It trusts the  dynamic provisioning that it provided the correct labels to the `PersistentVolume`, saving one potentially expensive cloud API call. `PersistentVolumes` created manually by users are labelled by the admission plugin in the same way as before. ([#82830](https://github.com/kubernetes/kubernetes/pull/82830), [@jsafrane](https://github.com/jsafrane))

### SIG Testing

- Adding TerminationGracePeriodSeconds to the test framework API ([#82170](https://github.com/kubernetes/kubernetes/pull/82170), [@vivekbagade](https://github.com/vivekbagade))



