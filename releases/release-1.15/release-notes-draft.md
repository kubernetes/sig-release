## Action Required

- The Node.Status.Volumes.Attached.DevicePath field is now unset for CSI volumes. Update any external controllers that depend on this field. ([#75799](https://github.com/kubernetes/kubernetes/pull/75799), [@msau42](https://github.com/msau42)) Courtesy of SIG Storage


## New Features

- Migrate oom watcher not relying on cAdviosr's API any more ([#74942](https://github.com/kubernetes/kubernetes/pull/74942), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG Node
- Allow to read OpenStack user credentials from a secret instead of a local config file. ([#75062](https://github.com/kubernetes/kubernetes/pull/75062), [@Fedosin](https://github.com/Fedosin)) Courtesy of SIG Cloud Provider, and SIG Storage
- Object count quota is now supported for namespaced custom resources using the `count/<resource>.<group>` syntax. ([#72384](https://github.com/kubernetes/kubernetes/pull/72384), [@zhouhaibing089](https://github.com/zhouhaibing089)) Courtesy of SIG API Machinery, SIG Apps, and SIG Testing
- Added `CNI_VERSION` and `CNI_SHA1` environment variables in kube-up.sh to configure CNI versions on GCE. ([#76353](https://github.com/kubernetes/kubernetes/pull/76353), [@Random-Liu](https://github.com/Random-Liu)) Courtesy of SIG Network, and SIG Node
- Admission webhooks are now properly called for `scale` and `deployments/rollback` subresources ([#76849](https://github.com/kubernetes/kubernetes/pull/76849), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG Auth, and SIG Testing
- Support specify the Resource Group of Route Table when update Pod network route (Azure) ([#75580](https://github.com/kubernetes/kubernetes/pull/75580), [@suker200](https://github.com/suker200)) Courtesy of SIG Cloud Provider
- give users the option to suppress detailed output in integration test ([#76063](https://github.com/kubernetes/kubernetes/pull/76063), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Testing
- Support print volumeMode using `kubectl get pv/pvc -o wide` ([#76646](https://github.com/kubernetes/kubernetes/pull/76646), [@cwdsuzhou](https://github.com/cwdsuzhou)) Courtesy of SIG CLI
- scheduler: add metrics to record number of pending pods in different queues ([#75501](https://github.com/kubernetes/kubernetes/pull/75501), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Apps, and SIG Scheduling
- Add completed job status in Cronjob event. ([#75712](https://github.com/kubernetes/kubernetes/pull/75712), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Apps
- Support both JSON and YAML for scheduler configuration. ([#75857](https://github.com/kubernetes/kubernetes/pull/75857), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- CRI API will now be available in the kubernetes/cri-api repository ([#75531](https://github.com/kubernetes/kubernetes/pull/75531), [@dims](https://github.com/dims)) Courtesy of SIG Network, SIG Node, SIG Release, and SIG Testing
- `kubectl get -w` now prints custom resource definitions with custom print columns ([#76161](https://github.com/kubernetes/kubernetes/pull/76161), [@liggitt](https://github.com/liggitt)) Courtesy of SIG CLI
- Add --image-repository flag to "kubeadm config images". ([#75866](https://github.com/kubernetes/kubernetes/pull/75866), [@jmkeyes](https://github.com/jmkeyes)) Courtesy of SIG Cluster Lifecycle
- Paginate requests from the kube-apiserver watch cache to etcd in chunks.
Paginate reflector init and resync List calls that are not served by watch cache. ([#75389](https://github.com/kubernetes/kubernetes/pull/75389), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, SIG Apps, and SIG Testing
- watch can now be enabled  for events using the flag --watch-cache-sizes on kube-apiserver ([#74321](https://github.com/kubernetes/kubernetes/pull/74321), [@yastij](https://github.com/yastij)) Courtesy of SIG API Machinery
- kubeadm: implement deletion of multiple bootstrap tokens at once ([#75646](https://github.com/kubernetes/kubernetes/pull/75646), [@bart0sh](https://github.com/bart0sh)) Courtesy of SIG Cluster Lifecycle
- kubeadm: add optional ECDSA support.
kubeadm still generates RSA keys when deploying a node, but also accepts ECDSA
keys if they exist already in the directory specified in --cert-dir option. ([#76390](https://github.com/kubernetes/kubernetes/pull/76390), [@rojkov](https://github.com/rojkov)) Courtesy of SIG Cluster Lifecycle
- Add ListPager.EachListItem utility function to client-go to enable incremental processing of chunked list responses ([#75849](https://github.com/kubernetes/kubernetes/pull/75849), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, and SIG Apps
- `k8s.io/kubernetes` and published components (like `k8s.io/client-go` and `k8s.io/api`) now publish go module files containing dependency version information. See http://git.k8s.io/client-go/INSTALL.md#go-modules for details on consuming `k8s.io/client-go` using go modules. ([#74877](https://github.com/kubernetes/kubernetes/pull/74877), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Release
- Users may now execute `get-kube-binaries.sh` to request a client for an OS/Arch unlike the one of the host on which the script is invoked. ([#74889](https://github.com/kubernetes/kubernetes/pull/74889), [@akutz](https://github.com/akutz)) Courtesy of SIG Cluster Lifecycle
- Create a new `kubectl rollout restart` command that does a rolling restart of a deployment. ([#76062](https://github.com/kubernetes/kubernetes/pull/76062), [@apelisse](https://github.com/apelisse)) Courtesy of SIG CLI, and SIG Testing
- kubectl exec now allows using resource name (e.g., deployment/mydeployment) to select a matching pod.
kubectl exec now allows using --pod-running-timeout flag to wait till at least one pod is running. ([#73664](https://github.com/kubernetes/kubernetes/pull/73664), [@prksu](https://github.com/prksu)) Courtesy of SIG CLI, and SIG Testing
- Update to use go 1.12.4 ([#76576](https://github.com/kubernetes/kubernetes/pull/76576), [@cblecker](https://github.com/cblecker)) Courtesy of SIG Release, and SIG Testing
- Transition service account controller clients to TokenRequest API ([#72179](https://github.com/kubernetes/kubernetes/pull/72179), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, and SIG Testing
- Change kubelet probe metrics to counter type.
The metrics `prober_probe_result` is replaced by `prober_probe_total`. ([#76074](https://github.com/kubernetes/kubernetes/pull/76074), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, and SIG Node


## API Changes

- Resource list requests for PartialObjectMetadata now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- [IPVS] Introduces flag ipvs-strict-arp to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- Introduce the v1beta2 config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))


## Notes From Multiple SIGs

### SIG API Machinery, SIG Node, and SIG Scalability

- The Kubelet now properly requests protobuf objects where they are
supported from the apiserver, reducing load in large clusters. ([#75602](https://github.com/kubernetes/kubernetes/pull/75602), [@smarterclayton](https://github.com/smarterclayton))

### SIG Azure, SIG Cloud Provider, and SIG Storage

- ---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: azurefile
provisioner: kubernetes.io/azure-file
parameters:
  skuName: Standard_LRS
  resourceGroup: EXISTING_RESOURCE_GROUP_NAME
  storageAccount: EXISTING_STORAGE_ACCOUNT_NAME
  shareName: SHARE_NAME
```

**Which issue(s) this PR fixes**:
<!--
*Automatically closes linked issue when PR is merged.
Usage: `Fixes #<issue number>`, or `Fixes (paste link of issue)`.
_If PR is about `failing-tests or flakes`, please post the related issues/tests in a comment and do not use `Fixes`_-->
Fixes #76986

**Special notes for your reviewer**:
add shareName param in azure file storage class

**Release note**:
<!--
If no, just write "NONE" in the release-note block below.
If yes, a release note is required:
Enter your extended release note in the block below. If the PR requires additional action from users switching to the new release, include the string "action required".
-->
```
specify azure file share name in azure file plugin ([#76988](https://github.com/kubernetes/kubernetes/pull/76988), [@andyzhangx](https://github.com/andyzhangx))
- Switch to instance-level update APIs for Azure VMSS loadbalancer operations ([#76656](https://github.com/kubernetes/kubernetes/pull/76656), [@feiskyer](https://github.com/feiskyer))
- fix detach azure disk back off issue which has too big lock in failure retry condition ([#76573](https://github.com/kubernetes/kubernetes/pull/76573), [@andyzhangx](https://github.com/andyzhangx))

### SIG API Machinery, SIG Auth, SIG Release, and SIG Testing

- Added port configuration to Admission webhook configuration service reference.
- Added port configuration to AuditSink webhook configuration service reference.
- Added port configuration to CRD Conversion webhook configuration service reference.
- Added port configuration to kube-aggregator service reference. ([#74855](https://github.com/kubernetes/kubernetes/pull/74855), [@mbohlool](https://github.com/mbohlool))

### SIG API Machinery, and SIG Scalability

- Introduce API for watch bookmark events.
Introduce Alpha field `AllowWatchBookmarks` in ListOptions for requesting watch bookmarks from apiserver. The implementation in apiserver is hidden behind feature gate `WatchBookmark` (currently in Alpha stage). ([#74074](https://github.com/kubernetes/kubernetes/pull/74074), [@wojtek-t](https://github.com/wojtek-t))

### SIG Auth, and SIG Testing

- Validating admission webhooks are now properly called for CREATE operations on the following resources: tokenreviews, subjectaccessreviews, localsubjectaccessreviews, selfsubjectaccessreviews, selfsubjectrulesreviews ([#76959](https://github.com/kubernetes/kubernetes/pull/76959), [@sbezverk](https://github.com/sbezverk))

### SIG API Machinery, SIG Azure, SIG CLI, and SIG Cloud Provider

- Upgrade go-autorest to v11.1.2 ([#77070](https://github.com/kubernetes/kubernetes/pull/77070), [@feiskyer](https://github.com/feiskyer))

### SIG Cluster Lifecycle, SIG Release, and SIG Testing

- Ensures the conformance test image saves results before exiting when ginkgo returns non-zero value. ([#76039](https://github.com/kubernetes/kubernetes/pull/76039), [@johnSchnake](https://github.com/johnSchnake))

### SIG Cluster Lifecycle, SIG GCP, and SIG Node

- Fixes a NPD bug on GCI, so that it disables glog writing to files for log-counter ([#76211](https://github.com/kubernetes/kubernetes/pull/76211), [@wangzhen127](https://github.com/wangzhen127))

### SIG Cluster Lifecycle, and SIG Windows

- Windows nodes on GCE use a known-working 1809 image rather than the latest 1809 image. ([#76722](https://github.com/kubernetes/kubernetes/pull/76722), [@pjh](https://github.com/pjh))

### SIG API Machinery, and SIG Cloud Provider

- Remove the function Parallelize, please convert to use the function ParallelizeUntil. ([#76595](https://github.com/kubernetes/kubernetes/pull/76595), [@danielqsj](https://github.com/danielqsj))

### SIG Cloud Provider, and SIG Node

- Rancher credential provider has now been removed ([#77099](https://github.com/kubernetes/kubernetes/pull/77099), [@dims](https://github.com/dims))

### SIG Instrumentation, SIG Storage, and SIG Testing

- Adds a new "storage_operation_status_count" metric for kube-controller-manager and kubelet to count success and error statues. ([#75750](https://github.com/kubernetes/kubernetes/pull/75750), [@msau42](https://github.com/msau42))

### SIG Cloud Provider, and SIG VMWare

- Support vSphere SAML token auth when using Zones ([#75515](https://github.com/kubernetes/kubernetes/pull/75515), [@dougm](https://github.com/dougm))

### SIG API Machinery, and SIG Instrumentation

- Replace *_admission_latencies_milliseconds_summary and *_admission_latencies_milliseconds metrics due to reporting wrong unit (was labelled milliseconds, but reported seconds), and multiple naming guideline violations (units should be in base units and "duration" is the best practice labelling to measure the time a request takes). Please convert to use *_admission_duration_seconds and *_admission_duration_seconds_summary, these now report the unit as described, and follow the instrumentation best practices. ([#75279](https://github.com/kubernetes/kubernetes/pull/75279), [@danielqsj](https://github.com/danielqsj))

### SIG Cluster Lifecycle, and SIG Instrumentation

- [metrics-server addon] Restore connecting to nodes via IP addresses ([#76819](https://github.com/kubernetes/kubernetes/pull/76819), [@serathius](https://github.com/serathius))

### SIG Apps, SIG Cluster Lifecycle, SIG Release, SIG Storage, and SIG Testing

- CSI alpha CRDs have been removed ([#75747](https://github.com/kubernetes/kubernetes/pull/75747), [@msau42](https://github.com/msau42))

### SIG Auth, SIG AWS, and SIG Cloud Provider

- The `system:aws-cloud-provider` cluster role, deprecated in v1.13, is no longer auto-created. Deployments using the AWS cloud provider should grant required permissions to the `aws-cloud-provider` service account in the `kube-system` namespace as part of deployment.  ([#66635](https://github.com/kubernetes/kubernetes/pull/66635), [@wgliang](https://github.com/wgliang))

### SIG Autoscaling, and SIG Cluster Lifecycle

- Update Cluster Autoscaler to 1.14.0; changelog: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.14.0 ([#75480](https://github.com/kubernetes/kubernetes/pull/75480), [@losipiuk](https://github.com/losipiuk))

### SIG CLI, and SIG Scheduling

- Support parsing more v1.Taint forms. `key:effect`, `key=:effect-` are now accepted. ([#74159](https://github.com/kubernetes/kubernetes/pull/74159), [@dlipovetsky](https://github.com/dlipovetsky))

### SIG Cluster Lifecycle, and SIG GCP

- Reduce GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#76352](https://github.com/kubernetes/kubernetes/pull/76352), [@jpbetz](https://github.com/jpbetz))
- GCE/Windows: disable stackdriver logging agent to prevent node startup failures ([#76099](https://github.com/kubernetes/kubernetes/pull/76099), [@yujuhong](https://github.com/yujuhong))

### SIG Scheduling, and SIG Storage

- Count PVCs that are unbound towards attach limit ([#73863](https://github.com/kubernetes/kubernetes/pull/73863), [@gnufied](https://github.com/gnufied))

### SIG AWS, SIG Cloud Provider, and SIG Node

- The AWS credential provider can now obtain ECR credentials even without the AWS cloud provider or being on an EC2 instance. Additionally, AWS credential provider caching has been improved to honor the ECR credential timeout. ([#75587](https://github.com/kubernetes/kubernetes/pull/75587), [@tiffanyfay](https://github.com/tiffanyfay))

### SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Fix OpenID Connect (OIDC) token refresh when the client secret contains a special character. ([#76914](https://github.com/kubernetes/kubernetes/pull/76914), [@tsuna](https://github.com/tsuna))

### SIG API Machinery, and SIG Apps

- Fixed a potential deadlock in resource quota controller
Enabled recording partial usage info for quota objects specifying multiple resources, when only some of the resources' usage can be determined. ([#74747](https://github.com/kubernetes/kubernetes/pull/74747), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, and SIG Storage

- StorageObjectInUseProtection admission plugin is additionally enabled by default.
So default enabled admission plugins are now `NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota,StorageObjectInUseProtection`. Please note that if you previously had not set the `--admission-control` flag, your cluster behavior may change (to be more standard). ([#74610](https://github.com/kubernetes/kubernetes/pull/74610), [@oomichi](https://github.com/oomichi))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Updated klog to 0.3.0 ([#76474](https://github.com/kubernetes/kubernetes/pull/76474), [@vincepri](https://github.com/vincepri))

### SIG Cluster Lifecycle, and SIG Testing

- Override protocol between etcd server and kube-apiserver on master with HTTPS instead HTTP when mTLS is enabled in GCE ([#74690](https://github.com/kubernetes/kubernetes/pull/74690), [@wenjiaswe](https://github.com/wenjiaswe))
- kube-up.sh no longer supports "centos" and "local" providers ([#76711](https://github.com/kubernetes/kubernetes/pull/76711), [@dims](https://github.com/dims))
- Default TTL for DNS records in kubernetes zone is changed from 5s to 30s to keep consistent with old dnsmasq based kube-dns. The TTL can be customized with command `kubectl edit -n kube-system configmap/coredns`. ([#76238](https://github.com/kubernetes/kubernetes/pull/76238), [@Dieken](https://github.com/Dieken))

### SIG Cluster Lifecycle, SIG GCP, and SIG Testing

- [stackdriver addon] Bump prometheus-to-sd to v0.5.0 to pick up security fixes.
[fluentd-gcp addon] Bump fluentd-gcp-scaler to v0.5.1 to pick up security fixes.
[fluentd-gcp addon] Bump event-exporter to v0.2.4 to pick up security fixes.
[fluentd-gcp addon] Bump prometheus-to-sd to v0.5.0 to pick up security fixes.
[metatada-proxy addon] Bump prometheus-to-sd v0.5.0 to pick up security fixes. ([#75362](https://github.com/kubernetes/kubernetes/pull/75362), [@serathius](https://github.com/serathius))

### SIG Auth, SIG CLI, and SIG Testing

- improve `kubectl auth can-i` command by warning users when they try access resource out of scope ([#76014](https://github.com/kubernetes/kubernetes/pull/76014), [@WanLinghao](https://github.com/WanLinghao))

### SIG Azure, and SIG Cloud Provider

- Ensure the backend pools are set correctly for Azure SLB with multiple backend pools (e.g. outbound rules) ([#76691](https://github.com/kubernetes/kubernetes/pull/76691), [@feiskyer](https://github.com/feiskyer))

### SIG API Machinery, and SIG Testing

- Fixes a bug where the kube-apiserver won't start if a broken webhook is installed and the client ca configmap is empty ([#60771](https://github.com/kubernetes/kubernetes/pull/60771), [@jennybuckley](https://github.com/jennybuckley))
- Watch will now support converting response objects into Table or PartialObjectMetadata forms. ([#71548](https://github.com/kubernetes/kubernetes/pull/71548), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, and SIG Auth

- client-go: The `rest.AnonymousClientConfig(*rest.Config) *rest.Config` helper method no longer copies custom `Transport` and `WrapTransport` fields, because those can be used to inject user credentials. ([#75771](https://github.com/kubernetes/kubernetes/pull/75771), [@liggitt](https://github.com/liggitt))


## Notes from Individual SIGs

### SIG API Machinery

- Fixes a bug where dry-run is not honored for pod/eviction sub-resource. ([#76969](https://github.com/kubernetes/kubernetes/pull/76969), [@apelisse](https://github.com/apelisse))
- Resource list requests for PartialObjectMetadata now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- Use stdlib to log stack trace when a panic occurs ([#75853](https://github.com/kubernetes/kubernetes/pull/75853), [@roycaihw](https://github.com/roycaihw))
- Increased verbose level for local openapi aggregation logs to avoid flooding the log during normal operation ([#75781](https://github.com/kubernetes/kubernetes/pull/75781), [@roycaihw](https://github.com/roycaihw))
- Add name validation for dynamic client methods in client-go ([#75072](https://github.com/kubernetes/kubernetes/pull/75072), [@lblackstone](https://github.com/lblackstone))
- Fixes a regression proxying responses from aggregated API servers which could cause watch requests to hang until the first event was received ([#75887](https://github.com/kubernetes/kubernetes/pull/75887), [@liggitt](https://github.com/liggitt))

### SIG Apps

- StatefulSet controllers no longer force a resync every 30 seconds when nothing has changed. ([#75622](https://github.com/kubernetes/kubernetes/pull/75622), [@jonsabo](https://github.com/jonsabo))
- Fixes bug in DaemonSetController causing it to stop processing some DaemonSets for 5 minutes after node removal. ([#76060](https://github.com/kubernetes/kubernetes/pull/76060), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))

### SIG CLI

- Report cp errors consistently  ([#77010](https://github.com/kubernetes/kubernetes/pull/77010), [@soltysh](https://github.com/soltysh))
- In the 'kubectl describe' output, the fields with names containing special characters are displayed as-is without any pretty formatting.  ([#75483](https://github.com/kubernetes/kubernetes/pull/75483), [@gsadhani](https://github.com/gsadhani))

### SIG Cluster Lifecycle

- Update cri-tools to v1.14.0 ([#75658](https://github.com/kubernetes/kubernetes/pull/75658), [@feiskyer](https://github.com/feiskyer))
- kubeadm: kubeadm alpha cert renew now ignores certificates signed by external CAs ([#76865](https://github.com/kubernetes/kubernetes/pull/76865), [@fabriziopandini](https://github.com/fabriziopandini))
- k8s-dns-node-cache image version v1.15.1 ([#76640](https://github.com/kubernetes/kubernetes/pull/76640), [@george-angel](https://github.com/george-angel))
- kubeadm: preflight checks on external etcd certificates are now skipped when joining a control-plane node with automatic copy of cluster certificates (--certificate-key) ([#75847](https://github.com/kubernetes/kubernetes/pull/75847), [@fabriziopandini](https://github.com/fabriziopandini))
- GCE Windows nodes will rely solely on kubernetes and kube-proxy (and not the GCE agent) for network address management. ([#75855](https://github.com/kubernetes/kubernetes/pull/75855), [@pjh](https://github.com/pjh))
- kubeadm: fix the machine readability of "kubeadm token create --print-join-command" ([#75487](https://github.com/kubernetes/kubernetes/pull/75487), [@displague](https://github.com/displague))
- In case kubeadm can't access the current Kubernetes version remotely and fails to parse
the git-based version it falls back to a static predefined value of
k8s.io/kubernetes/cmd/kubeadm/app/constants.CurrentKubernetesVersion. ([#72454](https://github.com/kubernetes/kubernetes/pull/72454), [@rojkov](https://github.com/rojkov))
- kubeadm: Support for deprecated old kubeadm v1alpha3 config is totally removed. ([#75179](https://github.com/kubernetes/kubernetes/pull/75179), [@rosti](https://github.com/rosti))
- Juju provider source moved to the Charmed Kubernetes org ([#76628](https://github.com/kubernetes/kubernetes/pull/76628), [@kwmonroe](https://github.com/kwmonroe))
- kubeadm: Fix a bug where if couple of CRIs are installed a user override of the CRI during join (via kubeadm join --cri-socket ...) is ignored and kubeadm bails out with an error ([#76505](https://github.com/kubernetes/kubernetes/pull/76505), [@rosti](https://github.com/rosti))
- kubeadm: fix "upgrade plan" not defaulting to a "stable" version if no version argument is passed ([#75900](https://github.com/kubernetes/kubernetes/pull/75900), [@neolit123](https://github.com/neolit123))
- kubeadm: bump the minimum supported Docker version to 1.13.1 ([#77051](https://github.com/kubernetes/kubernetes/pull/77051), [@chenzhiwei](https://github.com/chenzhiwei))
-  `StubDomains` and `Upstreamnameserver` which contains a service name will be omitted while translating to the equivalent CoreDNS config. ([#75969](https://github.com/kubernetes/kubernetes/pull/75969), [@rajansandeep](https://github.com/rajansandeep))
- Introduce the v1beta2 config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))
- Kubeadm will now include the missing certificate key if it is unable to find an expected key during `kubeadm join` when used with the `--experimental-control-plane` flow ([#76636](https://github.com/kubernetes/kubernetes/pull/76636), [@mdaniel](https://github.com/mdaniel))
- Bump metrics-server to v0.3.2 ([#76437](https://github.com/kubernetes/kubernetes/pull/76437), [@brett-elliott](https://github.com/brett-elliott))
- kubeadm: Improve resiliency when it comes to updating the `kubeadm-config` config map upon new control plane joins or resets. This allows for safe multiple control plane joins and/or resets. ([#76821](https://github.com/kubernetes/kubernetes/pull/76821), [@ereslibre](https://github.com/ereslibre))
- kubeadm: kubeadm upgrade now renews all the certificates used by one component before upgrading the component itself, with the exception of certificates signed by external CAs. User can eventually opt-out from certificate renewal during upgrades by setting the new flag --certificate-renewal to false. ([#76862](https://github.com/kubernetes/kubernetes/pull/76862), [@fabriziopandini](https://github.com/fabriziopandini))

### SIG GCP

- GCE/Windows: add support for stackdriver logging agent ([#76850](https://github.com/kubernetes/kubernetes/pull/76850), [@yujuhong](https://github.com/yujuhong))

### SIG Network

- Packets considered INVALID by conntrack are now dropped. In particular, this fixes
a problem where spurious retransmits in a long-running TCP connection to a service
IP could result in the connection being closed with the error "Connection reset by
peer" ([#74840](https://github.com/kubernetes/kubernetes/pull/74840), [@anfernee](https://github.com/anfernee))
- [IPVS] Allow for transparent kube-proxy restarts ([#75283](https://github.com/kubernetes/kubernetes/pull/75283), [@lbernail](https://github.com/lbernail))
- kube-proxy: HealthzBindAddress and MetricsBindAddress support ipv6 address. ([#76320](https://github.com/kubernetes/kubernetes/pull/76320), [@JieJhih](https://github.com/JieJhih))
- kube-proxy: os exit when CleanupAndExit is set to true ([#76732](https://github.com/kubernetes/kubernetes/pull/76732), [@JieJhih](https://github.com/JieJhih))
- [IPVS] Introduces flag ipvs-strict-arp to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- The userspace proxy now respects the IPTables proxy's minSyncInterval parameter. ([#71735](https://github.com/kubernetes/kubernetes/pull/71735), [@dcbw](https://github.com/dcbw))
- kube-proxy no longer automatically cleans up network rules created by running kube-proxy in other modes. If you are switching the mode that kube-proxy is in running in (EG: iptables to IPVS), you will need to run `kube-proxy --cleanup`, or restart the worker node (recommended) before restarting kube-proxy.

If you are not switching kube-proxy between different modes, this change should not require any action. ([#76109](https://github.com/kubernetes/kubernetes/pull/76109), [@vllry](https://github.com/vllry))

### SIG Node

- UpdateContainerResources is no longer recorded as a `container_status` operation. It now uses the label `update_container` ([#75278](https://github.com/kubernetes/kubernetes/pull/75278), [@Nessex](https://github.com/Nessex))
- Fix some potential deadlocks and file descriptor leaking for inotify watches. ([#75376](https://github.com/kubernetes/kubernetes/pull/75376), [@cpuguy83](https://github.com/cpuguy83))

### SIG Scalability

- Fixed a kubemark panic when hollow-node is morphed as proxy. ([#76848](https://github.com/kubernetes/kubernetes/pull/76848), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Scheduling

- 2X performance improvement on both required and preferred PodAffinity. ([#76243](https://github.com/kubernetes/kubernetes/pull/76243), [@Huang-Wei](https://github.com/Huang-Wei))
- Tolerations with the same key and effect will be merged into one which has the value of the latest toleration for best effort pods. ([#75985](https://github.com/kubernetes/kubernetes/pull/75985), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))

### SIG Storage

- Reduce event spam for AttachVolume storage operation ([#75986](https://github.com/kubernetes/kubernetes/pull/75986), [@mucahitkurt](https://github.com/mucahitkurt))
- Fix issue in Portworx volume driver causing controller manager to crash ([#76341](https://github.com/kubernetes/kubernetes/pull/76341), [@harsh-px](https://github.com/harsh-px))
- Reset exponential backoff when storage operation changes ([#75213](https://github.com/kubernetes/kubernetes/pull/75213), [@gnufied](https://github.com/gnufied))

### SIG Testing

- Validating admission webhooks are now properly called for CREATE operations on the following resources: pods/binding, pods/eviction, bindings ([#76910](https://github.com/kubernetes/kubernetes/pull/76910), [@liggitt](https://github.com/liggitt))



