## New Features

- add azure disk encryption(SSE+CMK) support ([#84605](https://github.com/kubernetes/kubernetes/pull/84605), [@andyzhangx](https://github.com/andyzhangx))

  Courtesy of SIG Cloud Provider, and SIG Storage
- Reduce default NodeStatusReportFrequency to 5 minutes. With this change, periodic node status updates will be send every 5m if node status doesn't change (otherwise they are still send with 10s).
  
  Bump NodeProblemDetector version to v0.8.0 to reduce forced NodeStatus updates frequency to 5 minutes. ([#84007](https://github.com/kubernetes/kubernetes/pull/84007), [@wojtek-t](https://github.com/wojtek-t))

  Courtesy of SIG Cluster Lifecycle, SIG Node, SIG Scalability, and SIG Testing
- CSI Topology feature is GA. The CSINodeInfo feature gate is deprecated and will be removed in a future release. The storage.k8s.io/v1beta1 CSINode object is deprecated and will be removed in a future release. ([#83474](https://github.com/kubernetes/kubernetes/pull/83474), [@msau42](https://github.com/msau42))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, SIG Storage, and SIG Testing
- Added kubelet serving certificate metric `server_rotation_seconds` which is a histogram reporting the age of a just rotated serving certificate in seconds. ([#84534](https://github.com/kubernetes/kubernetes/pull/84534), [@sambdavidson](https://github.com/sambdavidson))

  Courtesy of SIG API Machinery, SIG Auth, SIG Instrumentation, and SIG Node
- local: support local filesystem volume with block resource reconstruction ([#84218](https://github.com/kubernetes/kubernetes/pull/84218), [@cofyc](https://github.com/cofyc))

  Courtesy of SIG Node, SIG Storage, and SIG Testing
- kubelet: a configuration file specified via `--config` is now loaded with strict deserialization, which fails if the config file contains duplicate or unknown fields. This protects against accidentally running with config files that are malformed, mis-indented, or have typos in field names, and getting unexpected behavior. ([#83204](https://github.com/kubernetes/kubernetes/pull/83204), [@obitech](https://github.com/obitech))

  Courtesy of SIG Cluster Lifecycle, and SIG Node
- kubeadm now propagates proxy environment variables to kube-proxy ([#84559](https://github.com/kubernetes/kubernetes/pull/84559), [@yastij](https://github.com/yastij))

  Courtesy of SIG Cluster Lifecycle
- Reload apiserver SNI certificates from disk every minute ([#84303](https://github.com/kubernetes/kubernetes/pull/84303), [@jackkleeman](https://github.com/jackkleeman))

  Courtesy of SIG API Machinery, and SIG Testing
- Update Azure SDK versions to v35.0.0 ([#84543](https://github.com/kubernetes/kubernetes/pull/84543), [@andyzhangx](https://github.com/andyzhangx))

  Courtesy of SIG Cloud Provider
- Scheduler now reports metrics on cache size including nodes, pods, and assumed pods ([#83508](https://github.com/kubernetes/kubernetes/pull/83508), [@damemi](https://github.com/damemi))

  Courtesy of SIG Instrumentation, and SIG Scheduling


## API Changes

- Fixed EndpointSlice port name validation to match Endpoint port name validation (allowing port names longer than 15 characters) ([#84481](https://github.com/kubernetes/kubernetes/pull/84481), [@robscott](https://github.com/robscott))


## Notes From Multiple SIGs

### SIG Apps, and SIG Network

- People can see the right log and note. ([#84637](https://github.com/kubernetes/kubernetes/pull/84637), [@zhipengzuo](https://github.com/zhipengzuo))

### SIG Scheduling, and SIG Testing

- Scheduler Policy API has a new recommended apiVersion "apiVersion: kubescheduler.config.k8s.io/v1" which is consistent with the scheduler API group "kubescheduler.config.k8s.io". It holds the same API as the old apiVersion "apiVersion: v1". ([#83578](https://github.com/kubernetes/kubernetes/pull/83578), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Cluster Lifecycle, and SIG Node

- sourcesReady provides the readiness of kubelet configuration sources such as apiserver update readiness. ([#81344](https://github.com/kubernetes/kubernetes/pull/81344), [@zouyee](https://github.com/zouyee))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Testing

- Update default etcd server version to 3.4.3 ([#84329](https://github.com/kubernetes/kubernetes/pull/84329), [@jingyih](https://github.com/jingyih))

### SIG Cluster Lifecycle, and SIG Network

- This PR sets the --cluster-dns flag value to kube-dns service IP whether or not NodeLocal DNSCache is enabled. NodeLocal DNSCache will listen on both the link-local as well as the service IP. ([#84383](https://github.com/kubernetes/kubernetes/pull/84383), [@prameshj](https://github.com/prameshj))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Scheduling

- kube-scheduler: emits a warning when a malformed component config file is used with v1alpha1. ([#84129](https://github.com/kubernetes/kubernetes/pull/84129), [@obitech](https://github.com/obitech))

### SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, and SIG Node

- The certificate signer no longer accepts ca.key passwords via the CFSSL_CA_PK_PASSWORD environment variable. This capability was not prompted by user request, never advertised, and recommended against in the security audit. ([#84677](https://github.com/kubernetes/kubernetes/pull/84677), [@mikedanese](https://github.com/mikedanese))

### SIG Node, and SIG Storage

- Removed Alpha feature `MountContainers` ([#84365](https://github.com/kubernetes/kubernetes/pull/84365), [@codenrhoden](https://github.com/codenrhoden))


## Notes from Individual SIGs

### SIG API Machinery

- Fix the bug that EndpointSlice for masters wasn't created after enabling EndpointSlice feature on a pre-existing cluster. ([#84421](https://github.com/kubernetes/kubernetes/pull/84421), [@tnqn](https://github.com/tnqn))

### SIG Network

- Ensure the KUBE-MARK-DROP chain in kube-proxy mode=iptables. The chain is ensured for both ipv4 and ipv6 in dual-stack operation. ([#84422](https://github.com/kubernetes/kubernetes/pull/84422), [@aojea](https://github.com/aojea))
- deprecate cleanup-ipvs flag ([#83832](https://github.com/kubernetes/kubernetes/pull/83832), [@gongguan](https://github.com/gongguan))
- Fixed EndpointSlice port name validation to match Endpoint port name validation (allowing port names longer than 15 characters) ([#84481](https://github.com/kubernetes/kubernetes/pull/84481), [@robscott](https://github.com/robscott))
- kube-proxy: emits a warning when a malformed component config file is used with v1alpha1. ([#84143](https://github.com/kubernetes/kubernetes/pull/84143), [@phenixblue](https://github.com/phenixblue))

### SIG Node

- Fixed a bug in the single-numa-policy of the TopologyManager. Previously, best-effort pods would result in a terminated state with a TopologyAffinity error. Now they will run as expected. ([#83777](https://github.com/kubernetes/kubernetes/pull/83777), [@lmdaly](https://github.com/lmdaly))

### SIG Scheduling

- Only validate duplication of the RequestedToCapacityRatio custom priority and allow other custom predicates/priorities ([#84646](https://github.com/kubernetes/kubernetes/pull/84646), [@liu-cong](https://github.com/liu-cong))
- Scheduler policy configs can no longer be declared multiple times ([#83963](https://github.com/kubernetes/kubernetes/pull/83963), [@damemi](https://github.com/damemi))



