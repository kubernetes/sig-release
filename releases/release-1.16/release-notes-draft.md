## Action Required

- Migrate scheduler to use v1beta1 Event API. any tool targeting scheduler events needs to use v1beta1 Event API ([#78447](https://github.com/kubernetes/kubernetes/pull/78447), [@yastij](https://github.com/yastij)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG Scheduling, and SIG Testing
- Node labels `beta.kubernetes.io/metadata-proxy-ready`, `beta.kubernetes.io/metadata-proxy-ready` and `beta.kubernetes.io/kube-proxy-ds-ready` are no longer added on new nodes.
ip-mask-agent addon starts to use the label `node.kubernetes.io/masq-agent-ds-ready` instead of `beta.kubernetes.io/masq-agent-ds-ready` as its node selector.
kube-proxy addon starts to use the label `node.kubernetes.io/kube-proxy-ds-ready` instead of `beta.kubernetes.io/kube-proxy-ds-ready` as its node selector.
metadata-proxy addon starts to use the label `cloud.google.com/metadata-proxy-ready` instead of `beta.kubernetes.io/metadata-proxy-ready` as its node selector.
Kubelet removes the ability to set `kubernetes.io` or `k8s.io` labels via --node-labels other than the [specifically allowed labels/prefixes](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/0000-20170814-bounding-self-labeling-kubelets.md&#35;proposal). ([#79305](https://github.com/kubernetes/kubernetes/pull/79305), [@paivagustavo](https://github.com/paivagustavo)) Courtesy of SIG Auth, SIG Cluster Lifecycle, and SIG Node
- scheduler.alpha.kubernetes.io/critical-pod annotation is removed. Pod priority (spec.priorityClassName) should be used instead to mark pods as critical. Action required! ([#79554](https://github.com/kubernetes/kubernetes/pull/79554), [@draveness](https://github.com/draveness)) Courtesy of SIG Apps, SIG Cluster Lifecycle, SIG GCP, SIG Instrumentation, SIG Node, SIG Scheduling, and SIG Testing
- hyperkube: the `--make-symlinks` flag, deprecated in v1.14, has been removed. ([#80017](https://github.com/kubernetes/kubernetes/pull/80017), [@Pothulapati](https://github.com/Pothulapati)) Courtesy of SIG Release
- The following APIs are no longer served by default:
All resources under `apps/v1beta1` and `apps/v1beta2` - use `apps/v1` instead
`daemonsets`, `deployments`, `replicasets` resources under `extensions/v1beta1` - use `apps/v1` instead
`networkpolicies` resources under `extensions/v1beta1` - use `networking.k8s.io/v1` instead
`podsecuritypolicies` resources under `extensions/v1beta1` - use `policy/v1beta1` instead

Serving these resources can be temporarily re-enabled using the `--runtime-config` apiserver flag. 
`apps/v1beta1=true`
`apps/v1beta2=true`
`extensions/v1beta1/daemonsets=true,extensions/v1beta1/deployments=true,extensions/v1beta1/replicasets=true,extensions/v1beta1/networkpolicies=true,extensions/v1beta1/podsecuritypolicies=true`

The ability to serve these resources will be completely removed in v1.18. ([#70672](https://github.com/kubernetes/kubernetes/pull/70672), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG Apps, SIG Network, and SIG Testing
- Removed deprecated flag `--resource-container` from kube-proxy.

The deprecated `--resource-container` flag has been removed from kube-proxy, and specifying it will now cause an error.  The behavior is now as if you specified `--resource-container=""`.  If you previously specified a non-empty `--resource-container`, you can no longer do so as of kubernetes 1.16. ([#78294](https://github.com/kubernetes/kubernetes/pull/78294), [@vllry](https://github.com/vllry)) Courtesy of SIG Cluster Lifecycle, SIG GCP, and SIG Network


## New Features

- kubeadm ClusterConfiguration now supports featureGates: IPv6DualStack: true ([#80145](https://github.com/kubernetes/kubernetes/pull/80145), [@Arvinderpal](https://github.com/Arvinderpal)) Courtesy of SIG Cluster Lifecycle
- `kubectl get -w` now takes an `--output-watch-events` flag to indicate the event type (ADDED, MODIFIED, DELETED) ([#72416](https://github.com/kubernetes/kubernetes/pull/72416), [@liggitt](https://github.com/liggitt)) Courtesy of SIG CLI, and SIG Testing
- Addition of Overhead field to the PodSpec and RuntimeClass types as part of the Pod Overhead KEP ([#76968](https://github.com/kubernetes/kubernetes/pull/76968), [@egernst](https://github.com/egernst)) Courtesy of SIG API Machinery, SIG Apps, SIG CLI, and SIG Node
- The behavior of the default handler for 404 requests fro the GCE Ingress load balancer is slightly modified in the sense that it now exports metrics using prometheus. The metrics exported include: 
- http_404_request_total  (the number of 404 requests handled)
- http_404_request_duration_ms (the amount of time the server took to respond in ms)

Also includes percentile groupings. The directory for the default 404 handler includes instructions on how to enable prometheus for monitoring and setting alerts.
 ([#79106](https://github.com/kubernetes/kubernetes/pull/79106), [@vbannai](https://github.com/vbannai)) Courtesy of SIG Cluster Lifecycle
- When HPAScaleToZero feature gate is enabled HPA supports scaling to zero pods based on object or external metrics. HPA remains active as long as at least one metric value available.

To downgrade the cluster to version that does not support scale-to-zero feature:
1. make sure there are no hpa objects with minReplicas=0. Here is a oneliner to update it to 1:
    $ kubectl get hpa --all-namespaces  --no-headers=true | awk  '{if($6==0) printf "kubectl patch hpa/%s --namespace=%s -p \"{\\\"spec\\\":{\\\"minReplicas\\\":1}}\"\n", $2, $1 }' | sh
2. disable HPAScaleToZero feature gate
 ([#74526](https://github.com/kubernetes/kubernetes/pull/74526), [@DXist](https://github.com/DXist)) Courtesy of SIG API Machinery, SIG Apps, and SIG Autoscaling
- Add --shutdown-delay-duration to kube-apiserver in order to delay a graceful shutdown. `/healthz` will keep returning success during this time and requests are normally served, but `/readyz` will return faillure immediately. This delay can be used to allow the SDN to update iptables on all nodes and stop sending traffic. ([#74416](https://github.com/kubernetes/kubernetes/pull/74416), [@sttts](https://github.com/sttts)) Courtesy of SIG API Machinery
- Add Pre-filter extension point to the scheduling framework. ([#78005](https://github.com/kubernetes/kubernetes/pull/78005), [@ahg-g](https://github.com/ahg-g)) Courtesy of SIG Scheduling, and SIG Testing
- On Windows systems, %USERPROFILE% is now preferred over %HOMEDRIVE%\%HOMEPATH% as the home folder if %HOMEDRIVE%\%HOMEPATH% does not contain a .kube\config file, and %USERPROFILE% exists and is writeable. ([#73923](https://github.com/kubernetes/kubernetes/pull/73923), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG CLI, and SIG Windows
- Added a metric 'apiserver_watch_events_total' that can be used to understand the number of watch events in the system. ([#78732](https://github.com/kubernetes/kubernetes/pull/78732), [@mborsz](https://github.com/mborsz)) Courtesy of SIG API Machinery
- Introduce a new admission controller for RuntimeClass. Initially, RuntimeClass will be used to apply the pod overhead associated with a given RuntimeClass to the Pod.Spec if a corresponding RuntimeClassName is specified.

PodOverhead is an alpha feature as of Kubernetes 1.16. ([#78484](https://github.com/kubernetes/kubernetes/pull/78484), [@egernst](https://github.com/egernst)) Courtesy of SIG API Machinery, and SIG Node
- Mounts /home/kubernetes/bin/nvidia/vulkan/icd.d on the host to /etc/vulkan/icd.d inside containers requesting GPU. ([#78868](https://github.com/kubernetes/kubernetes/pull/78868), [@chardch](https://github.com/chardch)) Courtesy of SIG Cluster Lifecycle
- Add Bind extension point to the scheduling framework. ([#79313](https://github.com/kubernetes/kubernetes/pull/79313), [@chenchun](https://github.com/chenchun)) Courtesy of SIG Scheduling, and SIG Testing
- Update Azure API versions (containerregistry --> 2018-09-01, network --> 2018-08-01) ([#79583](https://github.com/kubernetes/kubernetes/pull/79583), [@justaugustus](https://github.com/justaugustus)) Courtesy of SIG Azure, and SIG Cloud Provider
- Add Bind extension point of the scheduling framework ([#78513](https://github.com/kubernetes/kubernetes/pull/78513), [@chenchun](https://github.com/chenchun)) Courtesy of SIG Scheduling, and SIG Testing
- Add support for writing out of tree custom scheduler plugins. ([#78162](https://github.com/kubernetes/kubernetes/pull/78162), [@hex108](https://github.com/hex108)) Courtesy of SIG Scheduling
- update to use go 1.12.7 ([#79966](https://github.com/kubernetes/kubernetes/pull/79966), [@tao12345666333](https://github.com/tao12345666333)) Courtesy of SIG Testing
- **NONE** ([#79637](https://github.com/kubernetes/kubernetes/pull/79637), [@toliu](https://github.com/toliu)) Courtesy of SIG API Machinery, SIG CLI, and SIG Cloud Provider
- KMS Providers will install a healthz check for the status of kms-pluign in kube-apiservers' encryption config.  ([#78540](https://github.com/kubernetes/kubernetes/pull/78540), [@immutableT](https://github.com/immutableT)) Courtesy of SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Testing
- Enable cadvisor ProcessMetrics collecting. ([#79002](https://github.com/kubernetes/kubernetes/pull/79002), [@jiayingz](https://github.com/jiayingz)) Courtesy of SIG Node
- RateLimiter add a context-aware method, fix client-go request goruntine backlog in async timeout scene. ([#79375](https://github.com/kubernetes/kubernetes/pull/79375), [@answer1991](https://github.com/answer1991)) Courtesy of SIG API Machinery
- Promote WatchBookmark feature to beta and enable it by default.
With WatchBookmark feature, clients are able to request watch events with BOOKMARK type. Clients should not assume bookmarks are returned at any specific interval, nor may they assume the server will send any BOOKMARK event during a session. ([#79786](https://github.com/kubernetes/kubernetes/pull/79786), [@wojtek-t](https://github.com/wojtek-t)) Courtesy of SIG API Machinery
- Integrated volume limits for in-tree and CSI volumes into one scheduler predicate. ([#77595](https://github.com/kubernetes/kubernetes/pull/77595), [@bertinatto](https://github.com/bertinatto)) Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Node, SIG Release, SIG Scheduling, SIG Storage, and SIG Testing
- kubeadm: support fetching configuration from the original cluster for 'upgrade diff' ([#80025](https://github.com/kubernetes/kubernetes/pull/80025), [@SataQiu](https://github.com/SataQiu)) Courtesy of SIG Cluster Lifecycle
- The `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` APIs have been promoted to `admissionregistration.k8s.io/v1`:
`failurePolicy` default changed from `Ignore` to `Fail` for v1
`matchPolicy` default changed from `Exact` to `Equivalent` for v1
`timeout` default changed from `30s` to `10s` for v1
`sideEffects` default value is removed and the field made required for v1
`admissionReviewVersions` default value is removed and the field made required for v1 (supported versions for AdmissionReview are `v1` and `v1beta1`)
The `name` field for specified webhooks must be unique for `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` objects created via `admissionregistration.k8s.io/v1`
The `admissionregistration.k8s.io/v1beta1` versions of `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` are deprecated and will no longer be served in v1.19. ([#79549](https://github.com/kubernetes/kubernetes/pull/79549), [@liggitt](https://github.com/liggitt)) Courtesy of SIG API Machinery, SIG Apps, SIG CLI, and SIG Testing
- Optimize EC2 DescribeInstances API calls in aws cloud provider library by querying instance ID instead of EC2 filters when possible ([#78140](https://github.com/kubernetes/kubernetes/pull/78140), [@zhan849](https://github.com/zhan849)) Courtesy of SIG AWS, SIG Cloud Provider, and SIG Scalability
- update to use go 1.12.6 ([#78958](https://github.com/kubernetes/kubernetes/pull/78958), [@tao12345666333](https://github.com/tao12345666333)) Courtesy of SIG Testing
- When using the conformance test image, a new environment variable E2E_USE_GO_RUNNER will cause the tests to be run with the new Golang-based test runner rather than the current bash wrapper. ([#79284](https://github.com/kubernetes/kubernetes/pull/79284), [@johnSchnake](https://github.com/johnSchnake)) Courtesy of SIG Cluster Lifecycle, SIG Release, and SIG Testing
- To configure controller manager to use ipv6dual stack:
use --cluster-cidr="<cidr1>,<cidr2>".

Notes:
 
1. Only the first two cidrs are used (soft limits for Alpha, might be lifted later on). 
2. Only the "RangeAllocator" (default) is allowed as a value for --cidr-allocator-type . Cloud allocators are not compatible with ipv6dualstack  ([#73977](https://github.com/kubernetes/kubernetes/pull/73977), [@khenidak](https://github.com/khenidak)) Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, SIG Release, SIG Scheduling, and SIG Testing
- if targetPort is changed that will process by service controller  ([#77712](https://github.com/kubernetes/kubernetes/pull/77712), [@Sn0rt](https://github.com/Sn0rt)) Courtesy of SIG Apps, and SIG Network
- kubeadm: provide "--control-plane-endpoint" flag for `controlPlaneEndpoint` ([#79270](https://github.com/kubernetes/kubernetes/pull/79270), [@SataQiu](https://github.com/SataQiu)) Courtesy of SIG Cluster Lifecycle


## API Changes

- The alpha `metadata.initializers` field, deprecated in 1.13, has been removed. ([#79504](https://github.com/kubernetes/kubernetes/pull/79504), [@yue9944882](https://github.com/yue9944882))
- Kubelet should now more reliably report the same primary node IP even if the set of node IPs reported by the CloudProvider changes. ([#79391](https://github.com/kubernetes/kubernetes/pull/79391), [@danwinship](https://github.com/danwinship))


## Notes From Multiple SIGs

### SIG Cluster Lifecycle, and SIG Network

- kubeadm: use the service-cidr flag to pass the desired service CIDR to the kube-controller-manager via its service-cluster-ip-range flag. ([#78625](https://github.com/kubernetes/kubernetes/pull/78625), [@Arvinderpal](https://github.com/Arvinderpal))

### SIG CLI, SIG Cluster Lifecycle, and SIG Testing

- E2E tests no longer add command line flags directly to the command line, test suites that want that need to be updated if they don't use HandleFlags
loading a -viper-config=e2e.yaml with suffix (introduced in 1.13) works again and now has a regression test ([#75593](https://github.com/kubernetes/kubernetes/pull/75593), [@pohly](https://github.com/pohly))

### SIG API Machinery, SIG Apps, SIG Architecture, SIG Node, and SIG Scheduling

- The deprecated node condition type 'OutOfDisk' has been removed. Use the 'DiskPressure' condition instead. ([#72420](https://github.com/kubernetes/kubernetes/pull/72420), [@Pingan2017](https://github.com/Pingan2017))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, SIG Release, and SIG Scheduling

- Fix duplicate error messages in cli commands ([#79493](https://github.com/kubernetes/kubernetes/pull/79493), [@odinuge](https://github.com/odinuge))

### SIG Node, and SIG Storage

- fix pod stuck issue due to corrupt mnt point in flexvol plugin, call Unmount if PathExists returns any error ([#75234](https://github.com/kubernetes/kubernetes/pull/75234), [@andyzhangx](https://github.com/andyzhangx))
- Use O_CLOEXEC to ensure file descriptors do not leak to subprocesses. ([#74691](https://github.com/kubernetes/kubernetes/pull/74691), [@cpuguy83](https://github.com/cpuguy83))

### SIG Azure, and SIG Cloud Provider

- fix: make azure disk URI as case insensitive ([#79020](https://github.com/kubernetes/kubernetes/pull/79020), [@andyzhangx](https://github.com/andyzhangx))
- Default resourceGroup should be used when the value of annotation azure-load-balancer-resource-group is an empty string. ([#79514](https://github.com/kubernetes/kubernetes/pull/79514), [@feiskyer](https://github.com/feiskyer))

### SIG API Machinery, and SIG Cluster Lifecycle

- etcd migration image no longer supports etcd2 version.  ([#80037](https://github.com/kubernetes/kubernetes/pull/80037), [@dims](https://github.com/dims))

### SIG API Machinery, SIG Apps, SIG Node, SIG Scheduling, and SIG Testing

- The GA PodPriority feature gate is now on by default and cannot be disabled. The feature gate will be removed in v1.18. ([#79262](https://github.com/kubernetes/kubernetes/pull/79262), [@draveness](https://github.com/draveness))

### SIG Auth, SIG Node, and SIG Storage

- Remove KubeletPluginsWatcher feature gates ([#79310](https://github.com/kubernetes/kubernetes/pull/79310), [@draveness](https://github.com/draveness))

### SIG Apps, and SIG Node

- Init container resource requests now impact pod QoS class ([#75223](https://github.com/kubernetes/kubernetes/pull/75223), [@sjenning](https://github.com/sjenning))

### SIG Apps, and SIG CLI

- kubectl logs --selector will support --tail=-1. ([#74943](https://github.com/kubernetes/kubernetes/pull/74943), [@JishanXing](https://github.com/JishanXing))

### SIG API Machinery, SIG Apps, and SIG Testing

- The namespace controller has been updated to use the metadata client which improves memory
and CPU usage of the Kube controller manager. ([#78744](https://github.com/kubernetes/kubernetes/pull/78744), [@smarterclayton](https://github.com/smarterclayton))
- The garbage collector and generic object quota controller have been updated to use the metadata client which improves memory
and CPU usage of the Kube controller manager. ([#78742](https://github.com/kubernetes/kubernetes/pull/78742), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Node, and SIG Storage

- Remove CSIPersistentVolume feature gates ([#79309](https://github.com/kubernetes/kubernetes/pull/79309), [@draveness](https://github.com/draveness))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Fix CRD validation error on 'items' field. ([#76124](https://github.com/kubernetes/kubernetes/pull/76124), [@tossmilestone](https://github.com/tossmilestone))

### SIG Cluster Lifecycle, SIG Network, SIG Node, and SIG Testing

- kubelet now accepts a --cni-cache-dir option, which defaults to /var/lib/cni/cache, where CNI stores cache files. ([#78908](https://github.com/kubernetes/kubernetes/pull/78908), [@dcbw](https://github.com/dcbw))

### SIG API Machinery, and SIG Auth

- SubjectAccessReview requests sent for RBAC escalation, impersonation, and pod security policy authorization checks now populate the version attribute. ([#80007](https://github.com/kubernetes/kubernetes/pull/80007), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, and SIG Cluster Lifecycle

- Reflector watchHandler Warning log 'The resourceVersion for the provided watch is too old.' is now logged as Info.  ([#78991](https://github.com/kubernetes/kubernetes/pull/78991), [@sallyom](https://github.com/sallyom))

### SIG API Machinery, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, SIG Storage, and SIG Testing

- Remove deprecated cloud providers - ovirt, cloudstack and photon ([#72178](https://github.com/kubernetes/kubernetes/pull/72178), [@dims](https://github.com/dims))

### SIG API Machinery, SIG Auth, SIG Cluster Lifecycle, and SIG Testing

- The kube-apiserver has improved behavior for both startup and shutdown sequences and also now exposes `\readyz` for readiness checking. Readyz includes all existing healthz checks but also adds a shutdown check. When a cluster admin initiates a shutdown, the kube-apiserver will try to process existing requests (for the duration of request timeout) before killing the apiserver process.  

The apiserver also now takes an optional flag "--maximum-startup-sequence-duration". This allows you to explicitly define an upper bound on the apiserver startup sequences before healthz begins to fail. By keeping the kubelet liveness initial delay short, this can enable quick kubelet recovery as soon as we have a boot sequence which has not completed in our expected time frame, despite lack of completion from longer boot sequences (like RBAC). Kube-apiserver behavior when the value of this flag is zero is backwards compatible (this is as the defaulted value of the flag). ([#78458](https://github.com/kubernetes/kubernetes/pull/78458), [@logicalhan](https://github.com/logicalhan))

### SIG API Machinery, and SIG Testing

- Fixes a bug in openapi published for custom resources using x-kubernetes-preserve-unknown-fields extensions, so that kubectl will allow sending unknown fields for that portion of the object. ([#79636](https://github.com/kubernetes/kubernetes/pull/79636), [@liggitt](https://github.com/liggitt))
- A new client `k8s.io/client-go/metadata.Client` has been added for accessing objects generically. This client makes it easier to retrieve only the metadata (the `metadata` sub-section) from resources on the cluster in an efficient manner for use cases that deal with objects generically, like the garbage collector, quota, or the namespace controller. The client asks the server to return a `meta.k8s.io/v1 PartialObjectMetadata` object for list, get, delete, watch, and patch operations on both normal APIs and custom resources which can be encoded in protobuf for additional work. If the server does not yet support this API the client will gracefully fall back to JSON and transform the response objects into PartialObjectMetadata. ([#77819](https://github.com/kubernetes/kubernetes/pull/77819), [@smarterclayton](https://github.com/smarterclayton))

### SIG Cluster Lifecycle, and SIG Instrumentation

- updated fluentd to 1.5.1, elasticsearchs & kibana to 7.1.1 ([#79014](https://github.com/kubernetes/kubernetes/pull/79014), [@monotek](https://github.com/monotek))

### SIG API Machinery, and SIG Scalability

- Fix a bug that ListOptions.AllowWatchBookmarks wasn't propagating correctly in kube-apiserver. ([#80157](https://github.com/kubernetes/kubernetes/pull/80157), [@wojtek-t](https://github.com/wojtek-t))
- Kubernetes now supports transparent compression of API responses. Clients that send `Accept-Encoding: gzip` will now receive a GZIP compressed response body if the API call was larger than 128KB.  Go clients automatically request gzip-encoding by default and should see reduced transfer times for very large API requests.  Clients in other languages may need to make changes to benefit from compression. ([#77449](https://github.com/kubernetes/kubernetes/pull/77449), [@smarterclayton](https://github.com/smarterclayton))

### SIG API Machinery, SIG CLI, SIG Node, and SIG Testing

- Fix kubelet errors in AArch64 with huge page sizes smaller than 1MiB ([#78495](https://github.com/kubernetes/kubernetes/pull/78495), [@odinuge](https://github.com/odinuge))

### SIG API Machinery, SIG Release, and SIG Testing

- The sample-apiserver gains support for OpenAPI v2 spec serving at `/openapi/v2`.

The `generate-internal-groups.sh` script in k8s.io/code-generator will generate OpenAPI definitions by default in `pkg/generated/openapi`. Additional API group dependencies can be added via `OPENAPI_EXTRA_PACKAGES=<group>/<version> <group2>/<version2>...`. ([#79843](https://github.com/kubernetes/kubernetes/pull/79843), [@sttts](https://github.com/sttts))

### SIG API Machinery, SIG CLI, SIG Release, and SIG Testing

- add  `kubectl replace --raw` and `kubectl delete --raw` to have parity with create and get ([#79724](https://github.com/kubernetes/kubernetes/pull/79724), [@deads2k](https://github.com/deads2k))

### SIG API Machinery, and SIG Scheduling

- Correct the maximum allowed insecure bind port for the kube-scheduler and kube-apiserver to 65535. ([#79346](https://github.com/kubernetes/kubernetes/pull/79346), [@ncdc](https://github.com/ncdc))


## Notes from Individual SIGs

### SIG API Machinery

- The alpha `metadata.initializers` field, deprecated in 1.13, has been removed. ([#79504](https://github.com/kubernetes/kubernetes/pull/79504), [@yue9944882](https://github.com/yue9944882))
- The CRD handler now properly re-creates stale CR storage to reflect CRD update. ([#79114](https://github.com/kubernetes/kubernetes/pull/79114), [@roycaihw](https://github.com/roycaihw))
- Resolves an issue serving aggregated APIs backed by services that respond to requests to `/` with non-2xx HTTP responses ([#79895](https://github.com/kubernetes/kubernetes/pull/79895), [@deads2k](https://github.com/deads2k))

### SIG Apps

- fix a bug that pods not be deleted from unmatched nodes by daemon controller   ([#78974](https://github.com/kubernetes/kubernetes/pull/78974), [@DaiHao](https://github.com/DaiHao))

### SIG CLI

- Fix a bug in server printer that could cause kube-apiserver to panic. ([#79349](https://github.com/kubernetes/kubernetes/pull/79349), [@roycaihw](https://github.com/roycaihw))
- Fixes a bug where `kubectl set config` hangs and uses 100% CPU on some invalid property names  ([#79000](https://github.com/kubernetes/kubernetes/pull/79000), [@pswica](https://github.com/pswica))
- Fixes invalid "time stamp is the future" error when kubectl cp-ing a file ([#73982](https://github.com/kubernetes/kubernetes/pull/73982), [@tanshanshan](https://github.com/tanshanshan))
- Fixes output of `kubectl get --watch-only` when watching a single resource ([#79345](https://github.com/kubernetes/kubernetes/pull/79345), [@liggitt](https://github.com/liggitt))

### SIG Cluster Lifecycle

- Volume expansion is enabled in the default GCE storageclass ([#78672](https://github.com/kubernetes/kubernetes/pull/78672), [@msau42](https://github.com/msau42))
- kubeadm: fix the bug that "--cri-socket" flag does not work for `kubeadm reset` ([#79498](https://github.com/kubernetes/kubernetes/pull/79498), [@SataQiu](https://github.com/SataQiu))
- kubeadm: implement retry logic for certain ConfigMap failures when joining nodes ([#78915](https://github.com/kubernetes/kubernetes/pull/78915), [@ereslibre](https://github.com/ereslibre))
- Fix remove the etcd member from the cluster during a kubeadm reset. ([#79326](https://github.com/kubernetes/kubernetes/pull/79326), [@bradbeam](https://github.com/bradbeam))
- kubeadm: prevent PSP blocking of upgrade image prepull by using a non-root user ([#77792](https://github.com/kubernetes/kubernetes/pull/77792), [@neolit123](https://github.com/neolit123))
- kubeadm: implement support for concurrent add/remove of stacked etcd members ([#79677](https://github.com/kubernetes/kubernetes/pull/79677), [@neolit123](https://github.com/neolit123))

### SIG Network

- Increase log level for graceful termination to v=5 ([#80100](https://github.com/kubernetes/kubernetes/pull/80100), [@andrewsykim](https://github.com/andrewsykim))
- Fix a string comparison bug in IPVS graceful termination where UDP real servers are not deleted. ([#78999](https://github.com/kubernetes/kubernetes/pull/78999), [@andrewsykim](https://github.com/andrewsykim))

### SIG Node

- na ([#79892](https://github.com/kubernetes/kubernetes/pull/79892), [@mikebrow](https://github.com/mikebrow))
- NoNE ([#78559](https://github.com/kubernetes/kubernetes/pull/78559), [@mysunshine92](https://github.com/mysunshine92))
- Remove pids cgroup controller requirement when related feature gates are disabled
 ([#79073](https://github.com/kubernetes/kubernetes/pull/79073), [@rafatio](https://github.com/rafatio))
- kubelet's --containerized flag was deprecated in 1.14. This flag is removed in 1.16. ([#80043](https://github.com/kubernetes/kubernetes/pull/80043), [@dims](https://github.com/dims))
- Kubelet should now more reliably report the same primary node IP even if the set of node IPs reported by the CloudProvider changes. ([#79391](https://github.com/kubernetes/kubernetes/pull/79391), [@danwinship](https://github.com/danwinship))
- Fix a bug where kubelet would not retry pod sandbox creation when the restart policy of the pod is Never ([#79451](https://github.com/kubernetes/kubernetes/pull/79451), [@yujuhong](https://github.com/yujuhong))

### SIG Release

- Remove HugePages, VolumeScheduling, CustomPodDNS and PodReadinessGates feature flags ([#79307](https://github.com/kubernetes/kubernetes/pull/79307), [@draveness](https://github.com/draveness))

### SIG Storage

- changes timeout value in csi plugin from 15s to 2min which fixes the timeout issue ([#79529](https://github.com/kubernetes/kubernetes/pull/79529), [@andyzhangx](https://github.com/andyzhangx))
- Cinder and ScaleIO volume providers have been deprecated and will be removed in a future release. ([#80099](https://github.com/kubernetes/kubernetes/pull/80099), [@dims](https://github.com/dims))
- Fix possible fd leak and closing of dirs in doSafeMakeDir  ([#79534](https://github.com/kubernetes/kubernetes/pull/79534), [@odinuge](https://github.com/odinuge))
- fix kubelet fail to delete orphaned pod directory when the kubelet's pods directory (default is "/var/lib/kubelet/pods") symbolically links to another disk device's directory ([#79094](https://github.com/kubernetes/kubernetes/pull/79094), [@gaorong](https://github.com/gaorong))
- Bugfix: csi plugin supporting raw block that does not need attach mounted failed ([#79920](https://github.com/kubernetes/kubernetes/pull/79920), [@cwdsuzhou](https://github.com/cwdsuzhou))

### SIG Testing

- fix pod list return value of framework.WaitForPodsWithLabelRunningReady ([#78687](https://github.com/kubernetes/kubernetes/pull/78687), [@pohly](https://github.com/pohly))



