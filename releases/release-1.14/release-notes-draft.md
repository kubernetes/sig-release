## New Features

- Install CSINodeInfo and CSIDriver CRDs in the local cluster. ([#72584](https://github.com/kubernetes/kubernetes/pull/72584), [@xing-yang](https://github.com/xing-yang)) Courtesy of SIG Storage
- Node OS/arch labels are promoted to GA ([#73048](https://github.com/kubernetes/kubernetes/pull/73048), [@yujuhong](https://github.com/yujuhong)) Courtesy of SIG Node
- Change apiserver metrics to conform metrics guidelines. ([#72336](https://github.com/kubernetes/kubernetes/pull/72336), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG API Machinery, SIG Instrumentation, and SIG Testing
- Add support for max attach limit for Cinder ([#72980](https://github.com/kubernetes/kubernetes/pull/72980), [@gnufied](https://github.com/gnufied)) Courtesy of SIG Scheduling, and SIG Storage
- Enable mTLS encription between etcd and kube-apiserver in GCE ([#70144](https://github.com/kubernetes/kubernetes/pull/70144), [@wenjiaswe](https://github.com/wenjiaswe)) Courtesy of SIG API Machinery, SIG Cluster Lifecycle, and SIG GCP


## Notes From Multiple SIGs

### SIG Node, and SIG Testing

- e2e tests that require SSH may be used against clusters that have nodes without external IP addresses by setting the environment variable `KUBE_SSH_BASTION` to the `host:port` of a machine that is allowed to SSH to those nodes.  The same private key that the test would use is used for the bastion host.  The test connects to the bastion and then tunnels another SSH connection to the node. ([#72286](https://github.com/kubernetes/kubernetes/pull/72286), [@smarterclayton](https://github.com/smarterclayton))
- PidPressure evicts pods from lowest priority to highest priority ([#72844](https://github.com/kubernetes/kubernetes/pull/72844), [@dashpole](https://github.com/dashpole))

### SIG API Machinery, SIG Cloud Provider, and SIG Scheduling

- Fix graceful apiserver shutdown to not drop outgoing bytes before the process terminates. ([#72970](https://github.com/kubernetes/kubernetes/pull/72970), [@sttts](https://github.com/sttts))

### SIG Cluster Lifecycle, and SIG GCP

- Reduce GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#72062](https://github.com/kubernetes/kubernetes/pull/72062), [@jpbetz](https://github.com/jpbetz))

### SIG API Machinery, SIG Auth, SIG CLI, and SIG Testing

- The `/swaggerapi/*` schema docs, deprecated since 1.7, have been removed in favor of the /openapi/v2 schema docs. ([#72924](https://github.com/kubernetes/kubernetes/pull/72924), [@liggitt](https://github.com/liggitt))


## Notes from Individual SIGs

### SIG API Machinery

- jsonpath expressions containing `[start:end:step]` slice are now evaluated correctly ([#73149](https://github.com/kubernetes/kubernetes/pull/73149), [@liggitt](https://github.com/liggitt))
- metadata.deletionTimestamp is no longer moved into the future when issuing repeated DELETE requests against a resource containing a finalizer. ([#73138](https://github.com/kubernetes/kubernetes/pull/73138), [@liggitt](https://github.com/liggitt))

### SIG CLI

- The "kubectl api-resources" command will no longer fail to display any resources on a single failure  ([#73035](https://github.com/kubernetes/kubernetes/pull/73035), [@juanvallejo](https://github.com/juanvallejo))
- kubectl loads config file once and uses persistent client config ([#71117](https://github.com/kubernetes/kubernetes/pull/71117), [@dixudx](https://github.com/dixudx))
- Print `SizeLimit` of `EmptyDir` in `kubectl describe pod` outputs. ([#69279](https://github.com/kubernetes/kubernetes/pull/69279), [@dtaniwaki](https://github.com/dtaniwaki))

### SIG Cluster Lifecycle

- kubeadm: explicitly wait for `etcd` to have grown when joining a new control plane ([#72984](https://github.com/kubernetes/kubernetes/pull/72984), [@ereslibre](https://github.com/ereslibre))
- kubeadm: pull images when joining a new control plane instance ([#72870](https://github.com/kubernetes/kubernetes/pull/72870), [@MalloZup](https://github.com/MalloZup))

### SIG Node

- remove stale OutOfDisk condition from kubelet side ([#72507](https://github.com/kubernetes/kubernetes/pull/72507), [@dixudx](https://github.com/dixudx))
- Fixes the setting of NodeAddresses when using the vSphere CloudProvider and nodes that have multiple IP addresses. ([#70805](https://github.com/kubernetes/kubernetes/pull/70805), [@danwinship](https://github.com/danwinship))

### SIG Scheduling

- acquire lock before operating unschedulablepodsmap ([#73022](https://github.com/kubernetes/kubernetes/pull/73022), [@denkensk](https://github.com/denkensk))
- add goroutine to move unschedulable pods to activeq if they are not retried for more than 1 minute ([#72558](https://github.com/kubernetes/kubernetes/pull/72558), [@denkensk](https://github.com/denkensk))