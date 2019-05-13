## Action Required

- Fix public IPs issues when multiple clusters are sharing the same resource group.



If the cluster is upgraded from old releases and the same resource group would be shared by multiple clusters, please recreate those LoadBalancer services or add a new tag 'kubernetes-cluster-name: <cluster-name>' manually for existing public IPs.
For multiple clusters sharing the same resource group, they should be configured with different cluster name by `kube-controller-manager --cluster-name=<cluster-name>` ([#77630](https://github.com/kubernetes/kubernetes/pull/77630), [@feiskyer](https://github.com/feiskyer)) Courtesy of SIG Azure, and SIG Cloud Provider
- The Node.Status.Volumes.Attached.DevicePath field is now unset for CSI volumes. Update any external controllers that depend on this field. ([#75799](https://github.com/kubernetes/kubernetes/pull/75799), [@msau42](https://github.com/msau42)) Courtesy of SIG Storage


## New Features

- kubeadm: add optional ECDSA support.
kubeadm still generates RSA keys when deploying a node, but also accepts ECDSA
keys if they exist already in the directory specified in --cert-dir option. ([#76390](https://github.com/kubernetes/kubernetes/pull/76390), [@rojkov](https://github.com/rojkov)) Courtesy of SIG Cluster Lifecycle
- scheduler: add metrics to record number of pending pods in different queues ([#75501](https://github.com/kubernetes/kubernetes/pull/75501), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Apps, and SIG Scheduling
- Add Un-reserve extension point for the scheduling framework. ([#77598](https://github.com/kubernetes/kubernetes/pull/77598), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- Implement un-reserve extension point for the scheduling framework. ([#77457](https://github.com/kubernetes/kubernetes/pull/77457), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- Add completed job status in Cronjob event. ([#75712](https://github.com/kubernetes/kubernetes/pull/75712), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Apps
- Support specify the Resource Group of Route Table when update Pod network route (Azure) ([#75580](https://github.com/kubernetes/kubernetes/pull/75580), [@suker200](https://github.com/suker200)) Courtesy of SIG Cloud Provider
- Update to use go 1.12.4 ([#76576](https://github.com/kubernetes/kubernetes/pull/76576), [@cblecker](https://github.com/cblecker)) Courtesy of SIG Release, and SIG Testing
- GCE clusters will include some IP ranges that are not in used on the public Internet to the list of non-masq IPs.
Bump ip-masq-agent version to v2.3.0 with flag `nomasq-all-reserved-ranges` turned on. ([#77458](https://github.com/kubernetes/kubernetes/pull/77458), [@grayluck](https://github.com/grayluck)) Courtesy of SIG Cluster Lifecycle, and SIG Network
- kubeadm: Add ability to specify certificate encryption and decryption key for the upload/download certificates phases as part of the new v1beta2 kubeadm config format. ([#77012](https://github.com/kubernetes/kubernetes/pull/77012), [@rosti](https://github.com/rosti)) Courtesy of SIG Cluster Lifecycle
- Add RuntimeClass restrictions & defaulting to PodSecurityPolicy. ([#73795](https://github.com/kubernetes/kubernetes/pull/73795), [@tallclair](https://github.com/tallclair)) Courtesy of SIG Apps, SIG Architecture, SIG Auth, and SIG Node
- Support both JSON and YAML for scheduler configuration. ([#75857](https://github.com/kubernetes/kubernetes/pull/75857), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Scheduling, and SIG Testing
- Added `CNI_VERSION` and `CNI_SHA1` environment variables in kube-up.sh to configure CNI versions on GCE. ([#76353](https://github.com/kubernetes/kubernetes/pull/76353), [@Random-Liu](https://github.com/Random-Liu)) Courtesy of SIG Network, and SIG Node
- Add ListPager.EachListItem utility function to client-go to enable incremental processing of chunked list responses ([#75849](https://github.com/kubernetes/kubernetes/pull/75849), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, and SIG Apps
- Object count quota is now supported for namespaced custom resources using the `count/<resource>.<group>` syntax. ([#72384](https://github.com/kubernetes/kubernetes/pull/72384), [@zhouhaibing089](https://github.com/zhouhaibing089)) Courtesy of SIG API Machinery, SIG Apps, and SIG Testing
- Add --image-repository flag to "kubeadm config images". ([#75866](https://github.com/kubernetes/kubernetes/pull/75866), [@jmkeyes](https://github.com/jmkeyes)) Courtesy of SIG Cluster Lifecycle
- watch can now be enabled  for events using the flag --watch-cache-sizes on kube-apiserver ([#74321](https://github.com/kubernetes/kubernetes/pull/74321), [@yastij](https://github.com/yastij)) Courtesy of SIG API Machinery
- `kubectl get -w` now prints custom resource definitions with custom print columns ([#76161](https://github.com/kubernetes/kubernetes/pull/76161), [@liggitt](https://github.com/liggitt)) Courtesy of SIG CLI
- Migrate oom watcher not relying on cAdviosr's API any more ([#74942](https://github.com/kubernetes/kubernetes/pull/74942), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG Node
- Allow to read OpenStack user credentials from a secret instead of a local config file. ([#75062](https://github.com/kubernetes/kubernetes/pull/75062), [@Fedosin](https://github.com/Fedosin)) Courtesy of SIG Cloud Provider, and SIG Storage
- Users may now execute `get-kube-binaries.sh` to request a client for an OS/Arch unlike the one of the host on which the script is invoked. ([#74889](https://github.com/kubernetes/kubernetes/pull/74889), [@akutz](https://github.com/akutz)) Courtesy of SIG Cluster Lifecycle
- Allow to define kubeconfig file for OpenStack cloud provider. ([#77415](https://github.com/kubernetes/kubernetes/pull/77415), [@Fedosin](https://github.com/Fedosin)) Courtesy of SIG Cloud Provider, and SIG Storage
- remove VM API call dep in azure disk WaitForAttach ([#77483](https://github.com/kubernetes/kubernetes/pull/77483), [@andyzhangx](https://github.com/andyzhangx)) Courtesy of SIG Azure, and SIG Storage
- `k8s.io/kubernetes` and published components (like `k8s.io/client-go` and `k8s.io/api`) now publish go module files containing dependency version information. See http://git.k8s.io/client-go/INSTALL.md#go-modules for details on consuming `k8s.io/client-go` using go modules. ([#74877](https://github.com/kubernetes/kubernetes/pull/74877), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Release
- kubeadm: implement deletion of multiple bootstrap tokens at once ([#75646](https://github.com/kubernetes/kubernetes/pull/75646), [@bart0sh](https://github.com/bart0sh)) Courtesy of SIG Cluster Lifecycle
- As of Kubernetes 1.15, the SupportNodePidsLimit feature introduced as alpha in Kubernetes 1.14 is now beta, and the ability to utilize it is enabled by default.  It is no longer necessary to set the feature gate `SupportNodePidsLimit=true`.  In all other respects, this functionality behaves as it did in Kubernetes 1.14. ([#76221](https://github.com/kubernetes/kubernetes/pull/76221), [@RobertKrawitz](https://github.com/RobertKrawitz)) Courtesy of SIG Testing
- kubectl exec now allows using resource name (e.g., deployment/mydeployment) to select a matching pod.
kubectl exec now allows using --pod-running-timeout flag to wait till at least one pod is running. ([#73664](https://github.com/kubernetes/kubernetes/pull/73664), [@prksu](https://github.com/prksu)) Courtesy of SIG CLI, and SIG Testing
- Implement and update interfaces and skeleton for the scheduling framework. ([#75848](https://github.com/kubernetes/kubernetes/pull/75848), [@bsalamat](https://github.com/bsalamat)) Courtesy of SIG Scheduling, and SIG Testing
-     util/initsystem: add support for the OpenRC init system ([#73101](https://github.com/kubernetes/kubernetes/pull/73101), [@oz123](https://github.com/oz123)) Courtesy of SIG Cluster Lifecycle, and SIG Node
- give users the option to suppress detailed output in integration test ([#76063](https://github.com/kubernetes/kubernetes/pull/76063), [@Huang-Wei](https://github.com/Huang-Wei)) Courtesy of SIG Testing
- Support print volumeMode using `kubectl get pv/pvc -o wide` ([#76646](https://github.com/kubernetes/kubernetes/pull/76646), [@cwdsuzhou](https://github.com/cwdsuzhou)) Courtesy of SIG CLI
- Change kubelet probe metrics to counter type.
The metrics `prober_probe_result` is replaced by `prober_probe_total`. ([#76074](https://github.com/kubernetes/kubernetes/pull/76074), [@danielqsj](https://github.com/danielqsj)) Courtesy of SIG Instrumentation, and SIG Node
- Paginate requests from the kube-apiserver watch cache to etcd in chunks.
Paginate reflector init and resync List calls that are not served by watch cache. ([#75389](https://github.com/kubernetes/kubernetes/pull/75389), [@jpbetz](https://github.com/jpbetz)) Courtesy of SIG API Machinery, SIG Apps, and SIG Testing
- Admission webhooks are now properly called for `scale` and `deployments/rollback` subresources ([#76849](https://github.com/kubernetes/kubernetes/pull/76849), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG Auth, and SIG Testing
- Transition service account controller clients to TokenRequest API ([#72179](https://github.com/kubernetes/kubernetes/pull/72179), [@WanLinghao](https://github.com/WanLinghao)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, and SIG Testing
- Create a new `kubectl rollout restart` command that does a rolling restart of a deployment. ([#76062](https://github.com/kubernetes/kubernetes/pull/76062), [@apelisse](https://github.com/apelisse)) Courtesy of SIG CLI, and SIG Testing
- CRI API will now be available in the kubernetes/cri-api repository ([#75531](https://github.com/kubernetes/kubernetes/pull/75531), [@dims](https://github.com/dims)) Courtesy of SIG Network, SIG Node, SIG Release, and SIG Testing
- Add TLS termination support for NLB ([#74910](https://github.com/kubernetes/kubernetes/pull/74910), [@M00nF1sh](https://github.com/M00nF1sh)) Courtesy of SIG Cloud Provider
- kubeadm: kubeadm alpha certs renew and kubeadm upgrade now supports renews of certificates embedded in KubeConfig files managed by kubeadm; this does not apply to certificates signed by external CAs.  ([#77180](https://github.com/kubernetes/kubernetes/pull/77180), [@fabriziopandini](https://github.com/fabriziopandini)) Courtesy of SIG Cluster Lifecycle


## API Changes

- Introduce the v1beta2 config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))
- [IPVS] Introduces flag ipvs-strict-arp to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- Resource list requests for PartialObjectMetadata now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- Add a condition NonStructuralSchema to CustomResourceDefinition listing Structural Schema violations as defined in KEP https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md. CRD authors should update their validation schemas to be structural in order to participate in future CRD features. ([#77207](https://github.com/kubernetes/kubernetes/pull/77207), [@sttts](https://github.com/sttts))
- Promote meta.k8s.io/v1beta1 Table and PartialObjectMetadata to v1. ([#77136](https://github.com/kubernetes/kubernetes/pull/77136), [@smarterclayton](https://github.com/smarterclayton))


## Notes From Multiple SIGs

### SIG API Machinery, and SIG Storage

- StorageObjectInUseProtection admission plugin is additionally enabled by default.
So default enabled admission plugins are now `NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota,StorageObjectInUseProtection`. Please note that if you previously had not set the `--admission-control` flag, your cluster behavior may change (to be more standard). ([#74610](https://github.com/kubernetes/kubernetes/pull/74610), [@oomichi](https://github.com/oomichi))

### SIG Cluster Lifecycle, and SIG Testing

- Default TTL for DNS records in kubernetes zone is changed from 5s to 30s to keep consistent with old dnsmasq based kube-dns. The TTL can be customized with command `kubectl edit -n kube-system configmap/coredns`. ([#76238](https://github.com/kubernetes/kubernetes/pull/76238), [@Dieken](https://github.com/Dieken))
- Bump addon-manager to v9.0.1
- Rebase image on debian-base:v1.0.0 ([#77282](https://github.com/kubernetes/kubernetes/pull/77282), [@MrHohn](https://github.com/MrHohn))
- kube-up.sh no longer supports "centos" and "local" providers ([#76711](https://github.com/kubernetes/kubernetes/pull/76711), [@dims](https://github.com/dims))
- Override protocol between etcd server and kube-apiserver on master with HTTPS instead HTTP when mTLS is enabled in GCE ([#74690](https://github.com/kubernetes/kubernetes/pull/74690), [@wenjiaswe](https://github.com/wenjiaswe))

### SIG Apps, and SIG Testing

- Remove extra pod creation expections when daemonset fails to create pods in batches. ([#74856](https://github.com/kubernetes/kubernetes/pull/74856), [@draveness](https://github.com/draveness))

### SIG Cluster Lifecycle, SIG Release, and SIG Testing

- Ensures the conformance test image saves results before exiting when ginkgo returns non-zero value. ([#76039](https://github.com/kubernetes/kubernetes/pull/76039), [@johnSchnake](https://github.com/johnSchnake))

### SIG Release, and SIG Testing

- Update to use go 1.12.5 ([#77528](https://github.com/kubernetes/kubernetes/pull/77528), [@cblecker](https://github.com/cblecker))

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

### SIG CLI, and SIG Scheduling

- Support parsing more v1.Taint forms. `key:effect`, `key=:effect-` are now accepted. ([#74159](https://github.com/kubernetes/kubernetes/pull/74159), [@dlipovetsky](https://github.com/dlipovetsky))

### SIG Cluster Lifecycle, SIG GCP, and SIG Node

- Fixes a NPD bug on GCI, so that it disables glog writing to files for log-counter ([#76211](https://github.com/kubernetes/kubernetes/pull/76211), [@wangzhen127](https://github.com/wangzhen127))

### SIG API Machinery, and SIG Auth

- client-go: The `rest.AnonymousClientConfig(*rest.Config) *rest.Config` helper method no longer copies custom `Transport` and `WrapTransport` fields, because those can be used to inject user credentials. ([#75771](https://github.com/kubernetes/kubernetes/pull/75771), [@liggitt](https://github.com/liggitt))

### SIG Cloud Provider, and SIG VMWare

- Support vSphere SAML token auth when using Zones ([#75515](https://github.com/kubernetes/kubernetes/pull/75515), [@dougm](https://github.com/dougm))

### SIG Auth, SIG CLI, and SIG Testing

- improve `kubectl auth can-i` command by warning users when they try access resource out of scope ([#76014](https://github.com/kubernetes/kubernetes/pull/76014), [@WanLinghao](https://github.com/WanLinghao))

### SIG API Machinery, SIG Node, and SIG Release

- Signal handling is initialized within hyperkube commands that require it (apiserver, kubelet) ([#76659](https://github.com/kubernetes/kubernetes/pull/76659), [@S-Chan](https://github.com/S-Chan))

### SIG Cloud Provider, and SIG Storage

- The GCERegionalPersistentDisk feature gate (GA in 1.13) can no longer be disabled. The feature gate will be removed in v1.17. ([#77412](https://github.com/kubernetes/kubernetes/pull/77412), [@liggitt](https://github.com/liggitt))

### SIG Apps, SIG Instrumentation, and SIG Scalability

- The `series.state` field in the events.k8s.io/v1beta1 Event API is deprecated and will be removed in v1.18 ([#75987](https://github.com/kubernetes/kubernetes/pull/75987), [@yastij](https://github.com/yastij))

### SIG Apps, and SIG Storage

- Add a field to store CSI volume expansion secrets ([#77516](https://github.com/kubernetes/kubernetes/pull/77516), [@gnufied](https://github.com/gnufied))

### SIG AWS, and SIG Cloud Provider

- Limit use of tags when calling EC2 API to prevent API throttling for very large clusters ([#76749](https://github.com/kubernetes/kubernetes/pull/76749), [@mcrute](https://github.com/mcrute))

### SIG API Machinery, and SIG Instrumentation

- Replace *_admission_latencies_milliseconds_summary and *_admission_latencies_milliseconds metrics due to reporting wrong unit (was labelled milliseconds, but reported seconds), and multiple naming guideline violations (units should be in base units and "duration" is the best practice labelling to measure the time a request takes). Please convert to use *_admission_duration_seconds and *_admission_duration_seconds_summary, these now report the unit as described, and follow the instrumentation best practices. ([#75279](https://github.com/kubernetes/kubernetes/pull/75279), [@danielqsj](https://github.com/danielqsj))

### SIG Azure, and SIG Cloud Provider

- Fix some service tags not supported issues for Azure LoadBalancer service ([#77719](https://github.com/kubernetes/kubernetes/pull/77719), [@feiskyer](https://github.com/feiskyer))
- Add etag for NSG updates so as to fix nsg race condition ([#77210](https://github.com/kubernetes/kubernetes/pull/77210), [@feiskyer](https://github.com/feiskyer))
- Ensure the backend pools are set correctly for Azure SLB with multiple backend pools (e.g. outbound rules) ([#76691](https://github.com/kubernetes/kubernetes/pull/76691), [@feiskyer](https://github.com/feiskyer))
- fix azure disk list corruption issue ([#77187](https://github.com/kubernetes/kubernetes/pull/77187), [@andyzhangx](https://github.com/andyzhangx))
- Fix race conditions for Azure loadbalancer and route updates. ([#77490](https://github.com/kubernetes/kubernetes/pull/77490), [@feiskyer](https://github.com/feiskyer))

### SIG Cloud Provider, and SIG Node

- Rancher credential provider has now been removed ([#77099](https://github.com/kubernetes/kubernetes/pull/77099), [@dims](https://github.com/dims))

### SIG Auth, SIG AWS, and SIG Cloud Provider

- The `system:aws-cloud-provider` cluster role, deprecated in v1.13, is no longer auto-created. Deployments using the AWS cloud provider should grant required permissions to the `aws-cloud-provider` service account in the `kube-system` namespace as part of deployment.  ([#66635](https://github.com/kubernetes/kubernetes/pull/66635), [@wgliang](https://github.com/wgliang))

### SIG CLI, and SIG Testing

- Preserves existing namespace information in manifests when running `kubectl set ... --local` commands ([#77267](https://github.com/kubernetes/kubernetes/pull/77267), [@liggitt](https://github.com/liggitt))

### SIG Auth, and SIG Testing

- Validating admission webhooks are now properly called for CREATE operations on the following resources: tokenreviews, subjectaccessreviews, localsubjectaccessreviews, selfsubjectaccessreviews, selfsubjectrulesreviews ([#76959](https://github.com/kubernetes/kubernetes/pull/76959), [@sbezverk](https://github.com/sbezverk))

### SIG Scheduling, and SIG Storage

- Count PVCs that are unbound towards attach limit ([#73863](https://github.com/kubernetes/kubernetes/pull/73863), [@gnufied](https://github.com/gnufied))

### SIG CLI, SIG Network, and SIG Testing

- ingress:  Update in-tree Ingress controllers, examples, and clients to target networking.k8s.io/v1beta1 ([#77617](https://github.com/kubernetes/kubernetes/pull/77617), [@cmluciano](https://github.com/cmluciano))

### SIG API Machinery, and SIG Testing

- Fixes a bug where the kube-apiserver won't start if a broken webhook is installed and the client ca configmap is empty ([#60771](https://github.com/kubernetes/kubernetes/pull/60771), [@jennybuckley](https://github.com/jennybuckley))
- Watch will now support converting response objects into Table or PartialObjectMetadata forms. ([#71548](https://github.com/kubernetes/kubernetes/pull/71548), [@smarterclayton](https://github.com/smarterclayton))
- Adding ListMeta.RemainingItemCount. When responding a LIST request, if the server has more data available, and if the request does not contain label selectors or field selectors, the server sets the ListOptions.RemainingItemCount to the number of remaining objects. ([#75993](https://github.com/kubernetes/kubernetes/pull/75993), [@caesarxuchao](https://github.com/caesarxuchao))

### SIG Instrumentation, SIG Storage, and SIG Testing

- Adds a new "storage_operation_status_count" metric for kube-controller-manager and kubelet to count success and error statues. ([#75750](https://github.com/kubernetes/kubernetes/pull/75750), [@msau42](https://github.com/msau42))

### SIG Cluster Lifecycle, and SIG Instrumentation

- [metrics-server addon] Restore connecting to nodes via IP addresses ([#76819](https://github.com/kubernetes/kubernetes/pull/76819), [@serathius](https://github.com/serathius))

### SIG API Machinery, SIG Azure, SIG CLI, and SIG Cloud Provider

- Upgrade go-autorest to v11.1.2 ([#77070](https://github.com/kubernetes/kubernetes/pull/77070), [@feiskyer](https://github.com/feiskyer))

### SIG AWS, SIG Cloud Provider, and SIG Node

- The AWS credential provider can now obtain ECR credentials even without the AWS cloud provider or being on an EC2 instance. Additionally, AWS credential provider caching has been improved to honor the ECR credential timeout. ([#75587](https://github.com/kubernetes/kubernetes/pull/75587), [@tiffanyfay](https://github.com/tiffanyfay))

### SIG Cluster Lifecycle, and SIG GCP

- API servers using the default Google Compute Engine bootstrapping scripts will have their insecure port (`:8080`) disabled by default. To enable the insecure port, set `ENABLE_APISERVER_INSECURE_PORT=true` in kube-env or as an environment variable. ([#77447](https://github.com/kubernetes/kubernetes/pull/77447), [@dekkagaijin](https://github.com/dekkagaijin))
- GCE/Windows: force kill Stackdriver logging processes when the service cannot be stopped ([#77378](https://github.com/kubernetes/kubernetes/pull/77378), [@yujuhong](https://github.com/yujuhong))
- GCE/Windows: disable stackdriver logging agent to prevent node startup failures ([#76099](https://github.com/kubernetes/kubernetes/pull/76099), [@yujuhong](https://github.com/yujuhong))
- [fluentd-gcp addon] Bump fluentd-gcp-scaler to v0.5.2 to pick up security fixes. ([#76762](https://github.com/kubernetes/kubernetes/pull/76762), [@serathius](https://github.com/serathius))
- Reduce GCE log rotation check from 1 hour to every 5 minutes.  Rotation policy is unchanged (new day starts, log file size > 100MB). ([#76352](https://github.com/kubernetes/kubernetes/pull/76352), [@jpbetz](https://github.com/jpbetz))

### SIG Cluster Lifecycle, SIG GCP, and SIG Testing

- [stackdriver addon] Bump prometheus-to-sd to v0.5.0 to pick up security fixes.
[fluentd-gcp addon] Bump fluentd-gcp-scaler to v0.5.1 to pick up security fixes.
[fluentd-gcp addon] Bump event-exporter to v0.2.4 to pick up security fixes.
[fluentd-gcp addon] Bump prometheus-to-sd to v0.5.0 to pick up security fixes.
[metatada-proxy addon] Bump prometheus-to-sd v0.5.0 to pick up security fixes. ([#75362](https://github.com/kubernetes/kubernetes/pull/75362), [@serathius](https://github.com/serathius))

### SIG API Machinery, and SIG Apps

- Fixed a potential deadlock in resource quota controller
Enabled recording partial usage info for quota objects specifying multiple resources, when only some of the resources' usage can be determined. ([#74747](https://github.com/kubernetes/kubernetes/pull/74747), [@liggitt](https://github.com/liggitt))

### SIG Apps, SIG Cluster Lifecycle, SIG Release, SIG Storage, and SIG Testing

- CSI alpha CRDs have been removed ([#75747](https://github.com/kubernetes/kubernetes/pull/75747), [@msau42](https://github.com/msau42))

### SIG API Machinery, SIG CLI, and SIG Testing

- Clients may now request that API objects are converted to the `v1.Table` and `v1.PartialObjectMetadata` forms for generic access to objects. ([#77448](https://github.com/kubernetes/kubernetes/pull/77448), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, SIG Auth, SIG Release, and SIG Testing

- Added port configuration to Admission webhook configuration service reference.
- Added port configuration to AuditSink webhook configuration service reference.
- Added port configuration to CRD Conversion webhook configuration service reference.
- Added port configuration to kube-aggregator service reference. ([#74855](https://github.com/kubernetes/kubernetes/pull/74855), [@mbohlool](https://github.com/mbohlool))

### SIG Storage, and SIG Testing

- Fix bug with block volume expansion ([#77317](https://github.com/kubernetes/kubernetes/pull/77317), [@gnufied](https://github.com/gnufied))

### SIG Cluster Lifecycle, SIG Ibmcloud, SIG Scalability, and SIG Testing

- Kubemark scripts have been fixed for IKS clusters. ([#76909](https://github.com/kubernetes/kubernetes/pull/76909), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Fix OpenID Connect (OIDC) token refresh when the client secret contains a special character. ([#76914](https://github.com/kubernetes/kubernetes/pull/76914), [@tsuna](https://github.com/tsuna))

### SIG Autoscaling, and SIG Cluster Lifecycle

- Update Cluster Autoscaler to 1.14.0; changelog: https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.14.0 ([#75480](https://github.com/kubernetes/kubernetes/pull/75480), [@losipiuk](https://github.com/losipiuk))

### SIG Instrumentation, and SIG Node

- If a pod has a running instance, the stats of its previously terminated instances will not show up in the kubelet summary stats any more for CRI runtimes like containerd and cri-o.

This keeps the behavior consistent with Docker integration, and fixes an issue that some container Prometheus metrics don't work when there are summary stats for multiple instances of the same pod. ([#77426](https://github.com/kubernetes/kubernetes/pull/77426), [@Random-Liu](https://github.com/Random-Liu))

### SIG API Machinery, and SIG Scalability

- Introduce API for watch bookmark events.
Introduce Alpha field `AllowWatchBookmarks` in ListOptions for requesting watch bookmarks from apiserver. The implementation in apiserver is hidden behind feature gate `WatchBookmark` (currently in Alpha stage). ([#74074](https://github.com/kubernetes/kubernetes/pull/74074), [@wojtek-t](https://github.com/wojtek-t))

### SIG API Machinery, and SIG Cloud Provider

- Remove the function Parallelize, please convert to use the function ParallelizeUntil. ([#76595](https://github.com/kubernetes/kubernetes/pull/76595), [@danielqsj](https://github.com/danielqsj))
- GCE-only flag `cloud-provider-gce-lb-src-cidrs` becomes optional for external cloud providers. ([#76627](https://github.com/kubernetes/kubernetes/pull/76627), [@timoreimann](https://github.com/timoreimann))

### SIG API Machinery, SIG Cluster Lifecycle, SIG Network, and SIG Testing

- ingress objects are now persisted in etcd using the networking.k8s.io/v1beta1 version ([#77139](https://github.com/kubernetes/kubernetes/pull/77139), [@cmluciano](https://github.com/cmluciano))

### SIG Cluster Lifecycle, and SIG Windows

- Windows nodes on GCE use a known-working 1809 image rather than the latest 1809 image. ([#76722](https://github.com/kubernetes/kubernetes/pull/76722), [@pjh](https://github.com/pjh))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Updated klog to 0.3.0 ([#76474](https://github.com/kubernetes/kubernetes/pull/76474), [@vincepri](https://github.com/vincepri))


## Notes from Individual SIGs

### SIG API Machinery

- API requests rejected by admission webhooks which specify an http status code < 400 are now assigned a 400 status code. ([#77022](https://github.com/kubernetes/kubernetes/pull/77022), [@liggitt](https://github.com/liggitt))
- Fixes an error with stuck informers when an etcd watch receives update or delete events with missing data ([#76675](https://github.com/kubernetes/kubernetes/pull/76675), [@ryanmcnamara](https://github.com/ryanmcnamara))
- Fixes a bug where dry-run is not honored for pod/eviction sub-resource. ([#76969](https://github.com/kubernetes/kubernetes/pull/76969), [@apelisse](https://github.com/apelisse))
- Use stdlib to log stack trace when a panic occurs ([#75853](https://github.com/kubernetes/kubernetes/pull/75853), [@roycaihw](https://github.com/roycaihw))
- Increased verbose level for local openapi aggregation logs to avoid flooding the log during normal operation ([#75781](https://github.com/kubernetes/kubernetes/pull/75781), [@roycaihw](https://github.com/roycaihw))
- Add name validation for dynamic client methods in client-go ([#75072](https://github.com/kubernetes/kubernetes/pull/75072), [@lblackstone](https://github.com/lblackstone))
- API paging is now enabled by default in k8s.io/apiserver recommended options, and in k8s.io/sample-apiserver ([#77278](https://github.com/kubernetes/kubernetes/pull/77278), [@liggitt](https://github.com/liggitt))
- Resource list requests for PartialObjectMetadata now correctly return list metadata like the resourceVersion and the continue token. ([#75971](https://github.com/kubernetes/kubernetes/pull/75971), [@smarterclayton](https://github.com/smarterclayton))
- When specifying an invalid value for a label, it was not always
clear which label the value was specified for. Starting with this release, the
label's key is included in such error messages, which makes debugging easier. ([#77144](https://github.com/kubernetes/kubernetes/pull/77144), [@kenegozi](https://github.com/kenegozi))
- Fixes a regression proxying responses from aggregated API servers which could cause watch requests to hang until the first event was received ([#75887](https://github.com/kubernetes/kubernetes/pull/75887), [@liggitt](https://github.com/liggitt))
- Add a condition NonStructuralSchema to CustomResourceDefinition listing Structural Schema violations as defined in KEP https://github.com/kubernetes/enhancements/blob/master/keps/sig-api-machinery/20190425-structural-openapi.md. CRD authors should update their validation schemas to be structural in order to participate in future CRD features. ([#77207](https://github.com/kubernetes/kubernetes/pull/77207), [@sttts](https://github.com/sttts))
- Promote meta.k8s.io/v1beta1 Table and PartialObjectMetadata to v1. ([#77136](https://github.com/kubernetes/kubernetes/pull/77136), [@smarterclayton](https://github.com/smarterclayton))

### SIG Apps

- StatefulSet controllers no longer force a resync every 30 seconds when nothing has changed. ([#75622](https://github.com/kubernetes/kubernetes/pull/75622), [@jonsabo](https://github.com/jonsabo))
- Fixes bug in DaemonSetController causing it to stop processing some DaemonSets for 5 minutes after node removal. ([#76060](https://github.com/kubernetes/kubernetes/pull/76060), [@krzysztof-jastrzebski](https://github.com/krzysztof-jastrzebski))
- enhance the daemonset sync logic in clock-skew scenario ([#77208](https://github.com/kubernetes/kubernetes/pull/77208), [@DaiHao](https://github.com/DaiHao))

### SIG Azure

- fix issue that pull image failed from a cross-subscription Azure Container Registry when using MSI to authenticate ([#77245](https://github.com/kubernetes/kubernetes/pull/77245), [@norshtein](https://github.com/norshtein))

### SIG CLI

- Fixes incorrect handling by kubectl of custom resources whose Kind is "Status" ([#77368](https://github.com/kubernetes/kubernetes/pull/77368), [@liggitt](https://github.com/liggitt))
- Clean links handling in cp's tar code ([#76788](https://github.com/kubernetes/kubernetes/pull/76788), [@soltysh](https://github.com/soltysh))
- Fix kubectl describe CronJobs error of `Successful Job History Limit`. ([#77347](https://github.com/kubernetes/kubernetes/pull/77347), [@danielqsj](https://github.com/danielqsj))
- In the 'kubectl describe' output, the fields with names containing special characters are displayed as-is without any pretty formatting.  ([#75483](https://github.com/kubernetes/kubernetes/pull/75483), [@gsadhani](https://github.com/gsadhani))
- Report cp errors consistently  ([#77010](https://github.com/kubernetes/kubernetes/pull/77010), [@soltysh](https://github.com/soltysh))

### SIG Cloud Provider

- 1. we need to add this change to 1.14 for sure
2. shall we merge it back to 1.13 as well? ([#76976](https://github.com/kubernetes/kubernetes/pull/76976), [@zhan849](https://github.com/zhan849))

### SIG Cluster Lifecycle

- Juju provider source moved to the Charmed Kubernetes org ([#76628](https://github.com/kubernetes/kubernetes/pull/76628), [@kwmonroe](https://github.com/kwmonroe))
- kubeadm: preflight checks on external etcd certificates are now skipped when joining a control-plane node with automatic copy of cluster certificates (--certificate-key) ([#75847](https://github.com/kubernetes/kubernetes/pull/75847), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: Improve resiliency when it comes to updating the `kubeadm-config` config map upon new control plane joins or resets. This allows for safe multiple control plane joins and/or resets. ([#76821](https://github.com/kubernetes/kubernetes/pull/76821), [@ereslibre](https://github.com/ereslibre))
- Kubeadm will now include the missing certificate key if it is unable to find an expected key during `kubeadm join` when used with the `--experimental-control-plane` flow ([#76636](https://github.com/kubernetes/kubernetes/pull/76636), [@mdaniel](https://github.com/mdaniel))
- Introduce the v1beta2 config format to kubeadm. ([#76710](https://github.com/kubernetes/kubernetes/pull/76710), [@rosti](https://github.com/rosti))
- Fixes segmentation fault issue with Protobuf library when log entries are deeply nested. ([#77224](https://github.com/kubernetes/kubernetes/pull/77224), [@qingling128](https://github.com/qingling128))
- Bump metrics-server to v0.3.2 ([#76437](https://github.com/kubernetes/kubernetes/pull/76437), [@brett-elliott](https://github.com/brett-elliott))
- kubeadm: Support for deprecated old kubeadm v1alpha3 config is totally removed. ([#75179](https://github.com/kubernetes/kubernetes/pull/75179), [@rosti](https://github.com/rosti))
- kubeadm: kubeadm alpha cert renew now ignores certificates signed by external CAs ([#76865](https://github.com/kubernetes/kubernetes/pull/76865), [@fabriziopandini](https://github.com/fabriziopandini))
- GCE Windows nodes will rely solely on kubernetes and kube-proxy (and not the GCE agent) for network address management. ([#75855](https://github.com/kubernetes/kubernetes/pull/75855), [@pjh](https://github.com/pjh))
-  `StubDomains` and `Upstreamnameserver` which contains a service name will be omitted while translating to the equivalent CoreDNS config. ([#75969](https://github.com/kubernetes/kubernetes/pull/75969), [@rajansandeep](https://github.com/rajansandeep))
- Update cri-tools to v1.14.0 ([#75658](https://github.com/kubernetes/kubernetes/pull/75658), [@feiskyer](https://github.com/feiskyer))
- k8s-dns-node-cache image version v1.15.1 ([#76640](https://github.com/kubernetes/kubernetes/pull/76640), [@george-angel](https://github.com/george-angel))
- kubeadm: fix the machine readability of "kubeadm token create --print-join-command" ([#75487](https://github.com/kubernetes/kubernetes/pull/75487), [@displague](https://github.com/displague))
- In case kubeadm can't access the current Kubernetes version remotely and fails to parse
the git-based version it falls back to a static predefined value of
k8s.io/kubernetes/cmd/kubeadm/app/constants.CurrentKubernetesVersion. ([#72454](https://github.com/kubernetes/kubernetes/pull/72454), [@rojkov](https://github.com/rojkov))
- kubeadm: bump the minimum supported Docker version to 1.13.1 ([#77051](https://github.com/kubernetes/kubernetes/pull/77051), [@chenzhiwei](https://github.com/chenzhiwei))
- kubeadm: fix "upgrade plan" not defaulting to a "stable" version if no version argument is passed ([#75900](https://github.com/kubernetes/kubernetes/pull/75900), [@neolit123](https://github.com/neolit123))
- kubeadm: kubeadm upgrade now renews all the certificates used by one component before upgrading the component itself, with the exception of certificates signed by external CAs. User can eventually opt-out from certificate renewal during upgrades by setting the new flag --certificate-renewal to false. ([#76862](https://github.com/kubernetes/kubernetes/pull/76862), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: Fix a bug where if couple of CRIs are installed a user override of the CRI during join (via kubeadm join --cri-socket ...) is ignored and kubeadm bails out with an error ([#76505](https://github.com/kubernetes/kubernetes/pull/76505), [@rosti](https://github.com/rosti))

### SIG GCP

- GCE/Windows: add support for stackdriver logging agent ([#76850](https://github.com/kubernetes/kubernetes/pull/76850), [@yujuhong](https://github.com/yujuhong))

### SIG Network

- [IPVS] Allow for transparent kube-proxy restarts ([#75283](https://github.com/kubernetes/kubernetes/pull/75283), [@lbernail](https://github.com/lbernail))
- Packets considered INVALID by conntrack are now dropped. In particular, this fixes
a problem where spurious retransmits in a long-running TCP connection to a service
IP could result in the connection being closed with the error "Connection reset by
peer" ([#74840](https://github.com/kubernetes/kubernetes/pull/74840), [@anfernee](https://github.com/anfernee))
- kube-proxy: os exit when CleanupAndExit is set to true ([#76732](https://github.com/kubernetes/kubernetes/pull/76732), [@JieJhih](https://github.com/JieJhih))
- [IPVS] Introduces flag ipvs-strict-arp to configure stricter ARP sysctls, defaulting to false to preserve existing behaviors. This was enabled by default in 1.13.0, which impacted a few CNI plugins. ([#75295](https://github.com/kubernetes/kubernetes/pull/75295), [@lbernail](https://github.com/lbernail))
- kube-proxy no longer automatically cleans up network rules created by running kube-proxy in other modes. If you are switching the mode that kube-proxy is in running in (EG: iptables to IPVS), you will need to run `kube-proxy --cleanup`, or restart the worker node (recommended) before restarting kube-proxy.

If you are not switching kube-proxy between different modes, this change should not require any action. ([#76109](https://github.com/kubernetes/kubernetes/pull/76109), [@vllry](https://github.com/vllry))
- The userspace proxy now respects the IPTables proxy's minSyncInterval parameter. ([#71735](https://github.com/kubernetes/kubernetes/pull/71735), [@dcbw](https://github.com/dcbw))
- kube-proxy: HealthzBindAddress and MetricsBindAddress support ipv6 address. ([#76320](https://github.com/kubernetes/kubernetes/pull/76320), [@JieJhih](https://github.com/JieJhih))
- Fixes spurious error messages about failing to clean up iptables rules when using iptables 1.8. ([#77303](https://github.com/kubernetes/kubernetes/pull/77303), [@danwinship](https://github.com/danwinship))

### SIG Node

- Fix some potential deadlocks and file descriptor leaking for inotify watches. ([#75376](https://github.com/kubernetes/kubernetes/pull/75376), [@cpuguy83](https://github.com/cpuguy83))
- UpdateContainerResources is no longer recorded as a `container_status` operation. It now uses the label `update_container` ([#75278](https://github.com/kubernetes/kubernetes/pull/75278), [@Nessex](https://github.com/Nessex))
- Check if container memory stats are available before accessing it ([#77656](https://github.com/kubernetes/kubernetes/pull/77656), [@yastij](https://github.com/yastij))
- Fix TestEventChannelFull random fail ([#76603](https://github.com/kubernetes/kubernetes/pull/76603), [@changyaowei](https://github.com/changyaowei))

### SIG Release

- Remove hyperkube short aliases from source code, Because hyperkube docker image currently create these aliases. ([#76953](https://github.com/kubernetes/kubernetes/pull/76953), [@Rand01ph](https://github.com/Rand01ph))

### SIG Scalability

- Fixed a kubemark panic when hollow-node is morphed as proxy. ([#76848](https://github.com/kubernetes/kubernetes/pull/76848), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Scheduling

- Tolerations with the same key and effect will be merged into one which has the value of the latest toleration for best effort pods. ([#75985](https://github.com/kubernetes/kubernetes/pull/75985), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- 2X performance improvement on both required and preferred PodAffinity. ([#76243](https://github.com/kubernetes/kubernetes/pull/76243), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Storage

- Fix issue in Portworx volume driver causing controller manager to crash ([#76341](https://github.com/kubernetes/kubernetes/pull/76341), [@harsh-px](https://github.com/harsh-px))
- Reset exponential backoff when storage operation changes ([#75213](https://github.com/kubernetes/kubernetes/pull/75213), [@gnufied](https://github.com/gnufied))
- Reduce event spam for AttachVolume storage operation ([#75986](https://github.com/kubernetes/kubernetes/pull/75986), [@mucahitkurt](https://github.com/mucahitkurt))

### SIG Testing

- Client:
 Version:           19.03.0-beta3
 API version:       1.40
 Go version:        go1.12.4
 Git commit:        c55e026
 Built:             Thu Apr 25 03:03:18 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta3
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.4
  Git commit:       c55e026
  Built:            Thu Apr 25 03:01:56 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```
**Which issue(s) this PR fixes**:
<!--
*Automatically closes linked issue when PR is merged.
Usage: `Fixes #<issue number>`, or `Fixes (paste link of issue)`.
_If PR is about `failing-tests or flakes`, please post the related issues/tests in a comment and do not use `Fixes`_-->
Fixes #

**Special notes for your reviewer**:

**Does this PR introduce a user-facing change?**:
<!--
If no, just write "NONE" in the release-note block below.
If yes, a release note is required:
Enter your extended release note in the block below. If the PR requires additional action from users switching to the new release, include the string "action required".
-->
```
Fix local-up-cluster.sh didn't work with docker 19.03.0-beta3  ([#77495](https://github.com/kubernetes/kubernetes/pull/77495), [@wanghaoran1988](https://github.com/wanghaoran1988))
- Validating admission webhooks are now properly called for CREATE operations on the following resources: pods/binding, pods/eviction, bindings ([#76910](https://github.com/kubernetes/kubernetes/pull/76910), [@liggitt](https://github.com/liggitt))



