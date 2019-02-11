## Action Required

- Promote ValidateProxyRedirects to Beta, and enable by default. This feature restricts redirect following from the apiserver to same-host redirects. ([#72552](https://github.com/kubernetes/kubernetes/pull/72552), [@tallclair](https://github.com/tallclair)) Courtesy of SIG API Machinery, and SIG Node


## New Features

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


## Notes From Multiple SIGs

### SIG Node, and SIG Windows

- Kubelet: add usageNanoCores from CRI stats provider ([#73659](https://github.com/kubernetes/kubernetes/pull/73659), [@feiskyer](https://github.com/feiskyer))
- Add network stats for Windows nodes and pods. ([#70121](https://github.com/kubernetes/kubernetes/pull/70121), [@feiskyer](https://github.com/feiskyer))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Scalability

- Scale max-inflight limits together with master VM sizes. ([#73268](https://github.com/kubernetes/kubernetes/pull/73268), [@wojtek-t](https://github.com/wojtek-t))

### SIG Apps, and SIG Scheduling

- As per deprecation policy in https://kubernetes.io/docs/reference/using-api/deprecation-policy/  ([#73001](https://github.com/kubernetes/kubernetes/pull/73001), [@shivnagarajan](https://github.com/shivnagarajan))

### SIG Node, and SIG Testing

- e2e tests that require SSH may be used against clusters that have nodes without external IP addresses by setting the environment variable `KUBE_SSH_BASTION` to the `host:port` of a machine that is allowed to SSH to those nodes.  The same private key that the test would use is used for the bastion host.  The test connects to the bastion and then tunnels another SSH connection to the node. ([#72286](https://github.com/kubernetes/kubernetes/pull/72286), [@smarterclayton](https://github.com/smarterclayton))
- PidPressure evicts pods from lowest priority to highest priority ([#72844](https://github.com/kubernetes/kubernetes/pull/72844), [@dashpole](https://github.com/dashpole))

### SIG API Machinery, SIG Auth, and SIG Testing

- The /swagger.json and /swagger-2.0.0.pb-v1 schema documents, deprecated since v1.10, have been removed in favor of `/openapi/v2` ([#73148](https://github.com/kubernetes/kubernetes/pull/73148), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, and SIG Cloud Provider

- Considerably reduced the CPU load in kube-apiserver while aggregating OpenAPI specifications from aggregated API servers. ([#71223](https://github.com/kubernetes/kubernetes/pull/71223), [@sttts](https://github.com/sttts))

### SIG Auth, and SIG Testing

- `system:kube-controller-manager` and `system:kube-scheduler` users are now permitted to perform delegated authentication/authorization checks by default RBAC policy ([#72491](https://github.com/kubernetes/kubernetes/pull/72491), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, and SIG Auth

- error messages returned in authentication webhook status responses are now correctly included in the apiserver log ([#73595](https://github.com/kubernetes/kubernetes/pull/73595), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, and SIG Testing

- fixes an error processing watch events when running skewed apiservers ([#73482](https://github.com/kubernetes/kubernetes/pull/73482), [@liggitt](https://github.com/liggitt))

### SIG Release, and SIG Testing

- Update to go1.11.5 ([#73326](https://github.com/kubernetes/kubernetes/pull/73326), [@ixdy](https://github.com/ixdy))

### SIG API Machinery, SIG Auth, SIG Node, SIG Scheduling, and SIG Testing

- A new `TaintNodesByCondition` admission plugin taints newly created Node objects as "not ready", to fix a race condition that could cause pods to be scheduled on new nodes before their taints were updated to accurately reflect their reported conditions. This admission plugin is enabled by default if the `TaintNodesByCondition` feature is enabled. ([#73097](https://github.com/kubernetes/kubernetes/pull/73097), [@bsalamat](https://github.com/bsalamat))

### SIG AWS, and SIG Cloud Provider

- Prevent AWS Network Load Balancer security groups ingress rules to be deleted by ensuring target groups are tagged. ([#73594](https://github.com/kubernetes/kubernetes/pull/73594), [@masterzen](https://github.com/masterzen))
- AWS ELB health checks will now use HTTPS/SSL protocol for HTTPS/SSL backends. ([#70309](https://github.com/kubernetes/kubernetes/pull/70309), [@2rs2ts](https://github.com/2rs2ts))

### SIG Cluster Lifecycle, and SIG Testing

- exit kube-proxy when configuration file changes ([#59176](https://github.com/kubernetes/kubernetes/pull/59176), [@dixudx](https://github.com/dixudx))
- kube-addon-manager was updated to v9.0, and now uses kubectl v1.13.2 and prunes workload resources via the apps/v1 API ([#72978](https://github.com/kubernetes/kubernetes/pull/72978), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle, and SIG Windows

- CoreDNS is only officially supported on Linux at this time.  As such, when kubeadm is used to deploy this component into your kubernetes cluster, it will be restricted (using nodeSelectors) to run only on nodes with that operating system. This ensures that in clusters which include Windows nodes, the scheduler will not ever attempt to place CoreDNS pods on these machines, reducing setup latency and enhancing initial cluster stability. ([#69940](https://github.com/kubernetes/kubernetes/pull/69940), [@MarcPow](https://github.com/MarcPow))

### SIG API Machinery, SIG Cloud Provider, and SIG Scheduling

- Fix graceful apiserver shutdown to not drop outgoing bytes before the process terminates. ([#72970](https://github.com/kubernetes/kubernetes/pull/72970), [@sttts](https://github.com/sttts))

### SIG API Machinery, SIG Auth, SIG CLI, and SIG Testing

- The `/swaggerapi/*` schema docs, deprecated since 1.7, have been removed in favor of the /openapi/v2 schema docs. ([#72924](https://github.com/kubernetes/kubernetes/pull/72924), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle, and SIG GCP

- Reduce GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#72062](https://github.com/kubernetes/kubernetes/pull/72062), [@jpbetz](https://github.com/jpbetz))

### SIG API Machinery, and SIG Scheduling

- Fix watch to not send the same set of events multiple times causing watcher to go back in time ([#73845](https://github.com/kubernetes/kubernetes/pull/73845), [@wojtek-t](https://github.com/wojtek-t))

### SIG CLI, and SIG Testing

- `kubectl delete --all-namespaces` is a recognized flag. ([#73716](https://github.com/kubernetes/kubernetes/pull/73716), [@deads2k](https://github.com/deads2k))

### SIG Cloud Provider, and SIG VMWare

- MAC Address filter has been fixed in vSphere Cloud Provider, it no longer ignores `00:1c:14` and `00:05:69` prefixes ([#73721](https://github.com/kubernetes/kubernetes/pull/73721), [@frapposelli](https://github.com/frapposelli))

### SIG Apps, SIG Architecture, and SIG Storage

- Fixes a bug that prevented deletion of dynamically provisioned volumes in Quobyte backends. ([#68925](https://github.com/kubernetes/kubernetes/pull/68925), [@casusbelli](https://github.com/casusbelli))

### SIG Architecture, and SIG Auth

- The `rules` field in RBAC Role and ClusterRole objects is now correctly reported as optional in the openapi schema. ([#73250](https://github.com/kubernetes/kubernetes/pull/73250), [@liggitt](https://github.com/liggitt))

### SIG Apps, SIG Scheduling, and SIG Testing

- Pod eviction now honors graceful deletion by default if no delete options are provided in the eviction request ([#72730](https://github.com/kubernetes/kubernetes/pull/72730), [@liggitt](https://github.com/liggitt))


## Notes from Individual SIGs

### SIG API Machinery

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

### SIG CLI

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

- kubeadm: `kubeadm alpha preflight` and `kubeadm alpha preflight node` are removed; you can now use `kubeadm join phase preflight` ([#73718](https://github.com/kubernetes/kubernetes/pull/73718), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm reset: fixed crash caused by absence of a configuration file ([#73636](https://github.com/kubernetes/kubernetes/pull/73636), [@bart0sh](https://github.com/bart0sh))
- CoreDNS is now version 1.3.1 ([#73610](https://github.com/kubernetes/kubernetes/pull/73610), [@rajansandeep](https://github.com/rajansandeep))
- kubeadm: When certificates are present joining a new control plane make sure that they match at least the required SANs ([#73093](https://github.com/kubernetes/kubernetes/pull/73093), [@ereslibre](https://github.com/ereslibre))
- kubeadm: add back `--cert-dir` option for `kubeadm init phase certs sa` ([#73239](https://github.com/kubernetes/kubernetes/pull/73239), [@mattkelly](https://github.com/mattkelly))
- kubeadm: explicitly wait for `etcd` to have grown when joining a new control plane ([#72984](https://github.com/kubernetes/kubernetes/pull/72984), [@ereslibre](https://github.com/ereslibre))
- kubeadm: pull images when joining a new control plane instance ([#72870](https://github.com/kubernetes/kubernetes/pull/72870), [@MalloZup](https://github.com/MalloZup))

### SIG Node

- Set a low oom_score_adj for containers in pods with system-critical priorities ([#73758](https://github.com/kubernetes/kubernetes/pull/73758), [@sjenning](https://github.com/sjenning))
- remove kubelet flag '--experimental-fail-swap-on' (deprecated in v1.8) ([#69552](https://github.com/kubernetes/kubernetes/pull/69552), [@Pingan2017](https://github.com/Pingan2017))
- remove stale OutOfDisk condition from kubelet side ([#72507](https://github.com/kubernetes/kubernetes/pull/72507), [@dixudx](https://github.com/dixudx))
- Fixes the setting of NodeAddresses when using the vSphere CloudProvider and nodes that have multiple IP addresses. ([#70805](https://github.com/kubernetes/kubernetes/pull/70805), [@danwinship](https://github.com/danwinship))

### SIG Scheduling

- scheduler: use incremental scheduling cycle in PriorityQueue to put all in-flight unschedulable pods back to active queue if we received move request ([#73309](https://github.com/kubernetes/kubernetes/pull/73309), [@cofyc](https://github.com/cofyc))
- scheduler: makes pod less racing so as to be put back into activeQ properly ([#73078](https://github.com/kubernetes/kubernetes/pull/73078), [@Huang-Wei](https://github.com/Huang-Wei))
- acquire lock before operating unschedulablepodsmap ([#73022](https://github.com/kubernetes/kubernetes/pull/73022), [@denkensk](https://github.com/denkensk))
- add goroutine to move unschedulable pods to activeq if they are not retried for more than 1 minute ([#72558](https://github.com/kubernetes/kubernetes/pull/72558), [@denkensk](https://github.com/denkensk))

### SIG Storage

- Ensure directories on volumes are group-executable when using fsGroup ([#73533](https://github.com/kubernetes/kubernetes/pull/73533), [@mxey](https://github.com/mxey))

### SIG Testing

- e2e.test now rejects unknown --provider values instead of merely warning about them. An empty provider name is not accepted anymore and was replaced by "skeleton" (= a provider with no special behavior). ([#73402](https://github.com/kubernetes/kubernetes/pull/73402), [@pohly](https://github.com/pohly))



