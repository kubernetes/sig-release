## Action Required

- Node labels `beta.kubernetes.io/metadata-proxy-ready`, `beta.kubernetes.io/metadata-proxy-ready` and `beta.kubernetes.io/kube-proxy-ds-ready` are no longer added on new nodes.
  - ip-mask-agent addon starts to use the label `node.kubernetes.io/masq-agent-ds-ready` instead of `beta.kubernetes.io/masq-agent-ds-ready` as its node selector.
  - kube-proxy addon starts to use the label `node.kubernetes.io/kube-proxy-ds-ready` instead of `beta.kubernetes.io/kube-proxy-ds-ready` as its node selector.
  - metadata-proxy addon starts to use the label `cloud.google.com/metadata-proxy-ready` instead of `beta.kubernetes.io/metadata-proxy-ready` as its node selector.
  - Kubelet removes the ability to set `kubernetes.io` or `k8s.io` labels via --node-labels other than the [specifically allowed labels/prefixes](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/0000-20170814-bounding-self-labeling-kubelets.md&#35;proposal). ([#79305](https://github.com/kubernetes/kubernetes/pull/79305), [@paivagustavo](https://github.com/paivagustavo))

  Courtesy of SIG Auth, SIG Cluster Lifecycle, and SIG Node
- Remove DirectCodecFactory(replace with serializer.WithoutConversionCodecFactory), DirectEncoder(replace with runtime.WithVersionEncoder) and DirectDecoder(replace with runtime.WithoutVersionDecoder). action required ([#79263](https://github.com/kubernetes/kubernetes/pull/79263), [@draveness](https://github.com/draveness))

  Courtesy of SIG API Machinery
- scheduler.alpha.kubernetes.io/critical-pod annotation is removed. Pod priority (spec.priorityClassName) should be used instead to mark pods as critical. Action required! ([#80342](https://github.com/kubernetes/kubernetes/pull/80342), [@draveness](https://github.com/draveness))

  Courtesy of SIG API Machinery, SIG Apps, SIG Cluster Lifecycle, SIG Instrumentation, SIG Node, SIG Scheduling, and SIG Testing
- Removed cadvisor metric labels `pod_name` and `container_name` to match instrumentation guidelines.
  
  any Prometheus queries that match `pod_name` and `container_name` labels (e.g. cadvisor or kubelet probe metrics) must be updated to use `pod` and `container` instead. ([#80376](https://github.com/kubernetes/kubernetes/pull/80376), [@ehashman](https://github.com/ehashman))

  Courtesy of SIG Instrumentation, SIG Node, and SIG Testing
- Removed deprecated flag `--resource-container` from kube-proxy.
  
  The deprecated `--resource-container` flag has been removed from kube-proxy, and specifying it will now cause an error.  The behavior is now as if you specified `--resource-container=""`.  If you previously specified a non-empty `--resource-container`, you can no longer do so as of kubernetes 1.16. ([#78294](https://github.com/kubernetes/kubernetes/pull/78294), [@vllry](https://github.com/vllry))

  Courtesy of SIG Cluster Lifecycle, and SIG Network
- The following APIs are no longer served by default:
  - All resources under `apps/v1beta1` and `apps/v1beta2` - use `apps/v1` instead
  - `daemonsets`, `deployments`, `replicasets` resources under `extensions/v1beta1` - use `apps/v1` instead
  - `networkpolicies` resources under `extensions/v1beta1` - use `networking.k8s.io/v1` instead
  - `podsecuritypolicies` resources under `extensions/v1beta1` - use `policy/v1beta1` instead
  
  Serving these resources can be temporarily re-enabled using the `--runtime-config` apiserver flag. 
  - `apps/v1beta1=true`
  - `apps/v1beta2=true`
  - `extensions/v1beta1/daemonsets=true,extensions/v1beta1/deployments=true,extensions/v1beta1/replicasets=true,extensions/v1beta1/networkpolicies=true,extensions/v1beta1/podsecuritypolicies=true`
  
  The ability to serve these resources will be completely removed in v1.18. ([#70672](https://github.com/kubernetes/kubernetes/pull/70672), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, SIG Apps, SIG Network, and SIG Testing
- Revert "scheduler.alpha.kubernetes.io/critical-pod annotation is removed. Pod priority (spec.priorityClassName) should be used instead to mark pods as critical. Action required!" ([#80277](https://github.com/kubernetes/kubernetes/pull/80277), [@draveness](https://github.com/draveness))

  Courtesy of SIG Apps, SIG Cluster Lifecycle, SIG Instrumentation, SIG Node, SIG Scheduling, and SIG Testing
- Migrate scheduler to use v1beta1 Event API. any tool targeting scheduler events needs to use v1beta1 Event API ([#78447](https://github.com/kubernetes/kubernetes/pull/78447), [@yastij](https://github.com/yastij))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG Scheduling, and SIG Testing
- kubeadm now deletes the bootstrap-kubelet.conf file after TLS bootstrap
  User relying on bootstrap-kubelet.conf should switch to kubelet.conf that contains node credentials ([#80676](https://github.com/kubernetes/kubernetes/pull/80676), [@fabriziopandini](https://github.com/fabriziopandini))

  Courtesy of SIG Cluster Lifecycle
- container images tar files for 'amd64' will now contain the architecture in the RepoTags manifest.json section.
  If you are using docker manifests there are not visible changes. ([#80266](https://github.com/kubernetes/kubernetes/pull/80266), [@javier-b-perez](https://github.com/javier-b-perez))

  Courtesy of SIG Release
- hyperkube: the `--make-symlinks` flag, deprecated in v1.14, has been removed. ([#80017](https://github.com/kubernetes/kubernetes/pull/80017), [@Pothulapati](https://github.com/Pothulapati))

  Courtesy of SIG Release


## New Features

- Add Bind extension point to the scheduling framework. ([#79313](https://github.com/kubernetes/kubernetes/pull/79313), [@chenchun](https://github.com/chenchun))

  Courtesy of SIG Scheduling, and SIG Testing
- kubeadm: enable secure serving for the kube-scheduler ([#80951](https://github.com/kubernetes/kubernetes/pull/80951), [@neolit123](https://github.com/neolit123))

  Courtesy of SIG Cluster Lifecycle
- Addition of Overhead field to the PodSpec and RuntimeClass types as part of the Pod Overhead KEP ([#76968](https://github.com/kubernetes/kubernetes/pull/76968), [@egernst](https://github.com/egernst))

  Courtesy of SIG API Machinery, SIG Apps, SIG CLI, and SIG Node
- On Windows systems, %USERPROFILE% is now preferred over %HOMEDRIVE%\%HOMEPATH% as the home folder if %HOMEDRIVE%\%HOMEPATH% does not contain a .kube\config file, and %USERPROFILE% exists and is writeable. ([#73923](https://github.com/kubernetes/kubernetes/pull/73923), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, SIG CLI, and SIG Windows
- To configure controller manager to use ipv6dual stack:
  use --cluster-cidr="<cidr1>,<cidr2>".
  
  Notes:
   
  1. Only the first two cidrs are used (soft limits for Alpha, might be lifted later on). 
  2. Only the "RangeAllocator" (default) is allowed as a value for --cidr-allocator-type . Cloud allocators are not compatible with ipv6dualstack  ([#73977](https://github.com/kubernetes/kubernetes/pull/73977), [@khenidak](https://github.com/khenidak))

  Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, SIG Release, SIG Scheduling, and SIG Testing
- The `CustomResourceDefinition` API type is promoted to `apiextensions.k8s.io/v1` with the following changes:
  - Use of the new `default` feature in validation schemas is limited to v1
  - `spec.scope` is no longer defaulted to `Namespaced` and must be explicitly specified
  - `spec.version` is removed; use `spec.versions` instead
  - `spec.validation` is removed; use `spec.versions[*].schema` instead
  - `spec.subresources` is removed; use `spec.versions[*].subresources` instead
  - `spec.additionalPrinterColumns` is removed; use `spec.versions[*].additionalPrinterColumns` instead
  - `spec.conversion.webhookClientConfig` is moved to `spec.conversion.webhook.clientConfig`
  - `spec.conversion.conversionReviewVersions` is moved to `spec.conversion.webhook.conversionReviewVersions`
  - `spec.versions[*].schema.openAPIV3Schema` is now required when creating v1 CustomResourceDefinitions
  - `spec.preserveUnknownFields: true` is disallowed when creating v1 CustomResourceDefinitions; it must be specified within schema definitions as `x-kubernetes-preserve-unknown-fields: true`
  - In `additionalPrinterColumns` items, the `JSONPath` field was renamed to `jsonPath` (fixes https://github.com/kubernetes/kubernetes/issues/66531) ([#79604](https://github.com/kubernetes/kubernetes/pull/79604), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, and SIG Testing
- when PodInfoOnMount is enabled for a CSI driver, the new csi.storage.k8s.io/ephemeral parameter in the volume context allows a driver's NodePublishVolume implementation to determine on a case-by-case basis whether the volume is ephemeral or a normal persistent volume ([#79983](https://github.com/kubernetes/kubernetes/pull/79983), [@pohly](https://github.com/pohly))

  Courtesy of SIG Storage, and SIG Testing
- kubelet: change node-lease-renew-interval to 0.25 of lease-renew-duration ([#80429](https://github.com/kubernetes/kubernetes/pull/80429), [@gaorong](https://github.com/gaorong))

  Courtesy of SIG Architecture, and SIG Node
- KMS Providers will install a healthz check for the status of kms-pluign in kube-apiservers' encryption config.  ([#78540](https://github.com/kubernetes/kubernetes/pull/78540), [@immutableT](https://github.com/immutableT))

  Courtesy of SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Testing
- Add a `Patch` method to `ScaleInterface` ([#80699](https://github.com/kubernetes/kubernetes/pull/80699), [@knight42](https://github.com/knight42))

  Courtesy of SIG API Machinery
- When HPAScaleToZero feature gate is enabled HPA supports scaling to zero pods based on object or external metrics. HPA remains active as long as at least one metric value available.
  
  To downgrade the cluster to version that does not support scale-to-zero feature:
  1. make sure there are no hpa objects with minReplicas=0. Here is a oneliner to update it to 1:
      $ kubectl get hpa --all-namespaces  --no-headers=true | awk  '{if($6==0) printf "kubectl patch hpa/%s --namespace=%s -p \"{\\\"spec\\\":{\\\"minReplicas\\\":1}}\"\n", $2, $1 }' | sh
  2. disable HPAScaleToZero feature gate
   ([#74526](https://github.com/kubernetes/kubernetes/pull/74526), [@DXist](https://github.com/DXist))

  Courtesy of SIG API Machinery, SIG Apps, and SIG Autoscaling
- kubeamd: use the --pod-network-cidr flag to init or use the podSubnet field in the kubeadm config to pass a comma separated list of pod CIDRs.  ([#79033](https://github.com/kubernetes/kubernetes/pull/79033), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle, SIG Network, and SIG Testing
- When using the conformance test image, a new environment variable E2E_USE_GO_RUNNER will cause the tests to be run with the new Golang-based test runner rather than the current bash wrapper. ([#79284](https://github.com/kubernetes/kubernetes/pull/79284), [@johnSchnake](https://github.com/johnSchnake))

  Courtesy of SIG Cluster Lifecycle, SIG Release, and SIG Testing
- Integrated volume limits for in-tree and CSI volumes into one scheduler predicate. ([#77595](https://github.com/kubernetes/kubernetes/pull/77595), [@bertinatto](https://github.com/bertinatto))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Node, SIG Release, SIG Scheduling, SIG Storage, and SIG Testing
- enhance Azure cloud provider code to support both AAD and ADFS authentication. ([#80841](https://github.com/kubernetes/kubernetes/pull/80841), [@rjaini](https://github.com/rjaini))

  Courtesy of SIG Cloud Provider
- Update Azure SDK + go-autorest API versions ([#79574](https://github.com/kubernetes/kubernetes/pull/79574), [@justaugustus](https://github.com/justaugustus))

  Courtesy of SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node
- CRDs under k8s.io and kubernetes.io must have the "api-approved.kubernetes.io" set to either `unapproved.*` or a link to the pull request approving the schema.  See https://github.com/kubernetes/enhancements/pull/1111 for more details. ([#79992](https://github.com/kubernetes/kubernetes/pull/79992), [@deads2k](https://github.com/deads2k))

  Courtesy of SIG API Machinery
- Added a metric 'apiserver_watch_events_total' that can be used to understand the number of watch events in the system. ([#78732](https://github.com/kubernetes/kubernetes/pull/78732), [@mborsz](https://github.com/mborsz))

  Courtesy of SIG API Machinery
- Return error when the scoring plugin returns score out of range [0, 100]. ([#81015](https://github.com/kubernetes/kubernetes/pull/81015), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- added an new Prometheus counter metric "sync_proxy_rules_iptables_restore_failures_total" for kube-proxy iptables-restore failures (both ipvs and iptables modes)
   ([#81210](https://github.com/kubernetes/kubernetes/pull/81210), [@figo](https://github.com/figo))

  Courtesy of SIG Network
- Implement normalize plugin extension point for the scheduler framework.
   ([#80383](https://github.com/kubernetes/kubernetes/pull/80383), [@liu-cong](https://github.com/liu-cong))

  Courtesy of SIG API Machinery, SIG Apps, SIG Architecture, SIG Auth, SIG Autoscaling, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Instrumentation, SIG Network, SIG Node, SIG Release, SIG Scheduling, SIG Storage, and SIG Testing
- Kibana has been slightly revamped/improved in the latest version ([#80421](https://github.com/kubernetes/kubernetes/pull/80421), [@lostick](https://github.com/lostick))

  Courtesy of SIG Cluster Lifecycle, and SIG Instrumentation
- The behavior of the default handler for 404 requests fro the GCE Ingress load balancer is slightly modified in the sense that it now exports metrics using prometheus. The metrics exported include: 
  - http_404_request_total  (the number of 404 requests handled)
  - http_404_request_duration_ms (the amount of time the server took to respond in ms)
  
  Also includes percentile groupings. The directory for the default 404 handler includes instructions on how to enable prometheus for monitoring and setting alerts.
   ([#79106](https://github.com/kubernetes/kubernetes/pull/79106), [@vbannai](https://github.com/vbannai))

  Courtesy of SIG Cluster Lifecycle
- Enable cadvisor ProcessMetrics collecting. ([#79002](https://github.com/kubernetes/kubernetes/pull/79002), [@jiayingz](https://github.com/jiayingz))

  Courtesy of SIG Node
- The `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` APIs have been promoted to `admissionregistration.k8s.io/v1`:
  - `failurePolicy` default changed from `Ignore` to `Fail` for v1
  - `matchPolicy` default changed from `Exact` to `Equivalent` for v1
  - `timeout` default changed from `30s` to `10s` for v1
  - `sideEffects` default value is removed, and the field made required, and only `None` and `NoneOnDryRun` are permitted for v1
  - `admissionReviewVersions` default value is removed and the field made required for v1 (supported versions for AdmissionReview are `v1` and `v1beta1`)
  - The `name` field for specified webhooks must be unique for `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` objects created via `admissionregistration.k8s.io/v1`
  The `admissionregistration.k8s.io/v1beta1` versions of `MutatingWebhookConfiguration` and `ValidatingWebhookConfiguration` are deprecated and will no longer be served in v1.19. ([#79549](https://github.com/kubernetes/kubernetes/pull/79549), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, SIG Apps, SIG CLI, and SIG Testing
- TBD ([#80730](https://github.com/kubernetes/kubernetes/pull/80730), [@jennybuckley](https://github.com/jennybuckley))

  Courtesy of SIG API Machinery, SIG Cloud Provider, and SIG Testing
- Update Azure API versions (containerregistry --> 2018-09-01, network --> 2018-08-01) ([#79583](https://github.com/kubernetes/kubernetes/pull/79583), [@justaugustus](https://github.com/justaugustus))

  Courtesy of SIG Cloud Provider
- Use a named array instead of a score array in normalizing-score phase. ([#80901](https://github.com/kubernetes/kubernetes/pull/80901), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- kubeadm ClusterConfiguration now supports featureGates: IPv6DualStack: true ([#80145](https://github.com/kubernetes/kubernetes/pull/80145), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- Conversion webhooks can now indicate they support receiving and responding with `ConversionReview` API objects in the `apiextensions.k8s.io/v1` version by including `v1` in the `conversionReviewVersions` list in their CustomResourceDefinition. Conversion webhooks must respond with a ConversionReview object in the same apiVersion they receive. `apiextensions.k8s.io/v1` `ConversionReview` responses must specify a `response.uid` that matches the `request.uid` of the object they were sent. ([#81476](https://github.com/kubernetes/kubernetes/pull/81476), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, and SIG Testing
- Add a azure cloud configuration `LoadBalancerName` and `LoadBalancerResourceGroup` to allow the corresponding customizations of azure load balancer. ([#81054](https://github.com/kubernetes/kubernetes/pull/81054), [@nilo19](https://github.com/nilo19))

  Courtesy of SIG Cloud Provider
- Add Score extension point to the scheduling framework. ([#79109](https://github.com/kubernetes/kubernetes/pull/79109), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling, and SIG Testing
- The `AdmissionReview` API sent to and received from admission webhooks has been promoted to `admission.k8s.io/v1`. Webhooks can specify a preference for receiving `v1` AdmissionReview objects with `admissionReviewVersions: ["v1","v1beta1"]`, and must respond with an API object in the same `apiVersion` they are sent. When webhooks use `admission.k8s.io/v1`, the following additional validation is performed on their responses:
  - `response.patch` and `response.patchType` are not permitted from validating admission webhooks
  - `apiVersion: "admission.k8s.io/v1"` is required
  - `kind: "AdmissionReview"` is required
  - `response.uid: "<value of request.uid>"` is required
  - `response.patchType: "JSONPatch"` is required (if `response.patch` is set) ([#80231](https://github.com/kubernetes/kubernetes/pull/80231), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery, SIG Apps, SIG Auth, SIG CLI, SIG Node, and SIG Testing
- Add Pre-filter extension point to the scheduling framework. ([#78005](https://github.com/kubernetes/kubernetes/pull/78005), [@ahg-g](https://github.com/ahg-g))

  Courtesy of SIG Scheduling, and SIG Testing
- Add support for writing out of tree custom scheduler plugins. ([#78162](https://github.com/kubernetes/kubernetes/pull/78162), [@hex108](https://github.com/hex108))

  Courtesy of SIG Scheduling
- kubeadm: support fetching configuration from the original cluster for 'upgrade diff' ([#80025](https://github.com/kubernetes/kubernetes/pull/80025), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- Add a service annotation `service.beta.kubernetes.io/azure-pip-name` to specify the public IP name for Azure load balancer. ([#81213](https://github.com/kubernetes/kubernetes/pull/81213), [@nilo19](https://github.com/nilo19))

  Courtesy of SIG Cloud Provider
- RateLimiter add a context-aware method, fix client-go request goruntine backlog in async timeout scene. ([#79375](https://github.com/kubernetes/kubernetes/pull/79375), [@answer1991](https://github.com/answer1991))

  Courtesy of SIG API Machinery
-    Add Filter extension point to the scheduling framework. ([#78477](https://github.com/kubernetes/kubernetes/pull/78477), [@YoubingLi](https://github.com/YoubingLi))

  Courtesy of SIG Scheduling, and SIG Testing
- Add CSI Migration Shim for VerifyVolumesAreAttached and BulkVolumeVerify ([#80443](https://github.com/kubernetes/kubernetes/pull/80443), [@davidz627](https://github.com/davidz627))

  Courtesy of SIG Storage
- update to use go 1.12.6 ([#78958](https://github.com/kubernetes/kubernetes/pull/78958), [@tao12345666333](https://github.com/tao12345666333))

  Courtesy of SIG Testing
- `kubectl get -w` now takes an `--output-watch-events` flag to indicate the event type (ADDED, MODIFIED, DELETED) ([#72416](https://github.com/kubernetes/kubernetes/pull/72416), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG CLI, and SIG Testing
- Creates an annotation 'service.beta.kubernetes.io/aws-load-balancer-eip-allocations' to assign AWS EIP to the newly created Network Load Balancer. Number of allocations and subnets must match. ([#69263](https://github.com/kubernetes/kubernetes/pull/69263), [@brooksgarrett](https://github.com/brooksgarrett))

  Courtesy of SIG Cloud Provider
- New flag --endpoint-updates-batch-period in kube-controller-manager can be used to reduce number of endpoints updates generated by pod changes. ([#80509](https://github.com/kubernetes/kubernetes/pull/80509), [@mborsz](https://github.com/mborsz))

  Courtesy of SIG Apps, and SIG Network
- kubelet now exports an "kubelet_evictions" metric that counts the number of pod evictions carried out by the kubelet to reclaim resources ([#81377](https://github.com/kubernetes/kubernetes/pull/81377), [@sjenning](https://github.com/sjenning))

  Courtesy of SIG Instrumentation, and SIG Node
- Implement a new feature that allows applying kustomize patches to static pod manifests generated by kubeadm.  ([#80905](https://github.com/kubernetes/kubernetes/pull/80905), [@fabriziopandini](https://github.com/fabriziopandini))

  Courtesy of SIG Cluster Lifecycle
- Introduce a new admission controller for RuntimeClass. Initially, RuntimeClass will be used to apply the pod overhead associated with a given RuntimeClass to the Pod.Spec if a corresponding RuntimeClassName is specified.
  
  PodOverhead is an alpha feature as of Kubernetes 1.16. ([#78484](https://github.com/kubernetes/kubernetes/pull/78484), [@egernst](https://github.com/egernst))

  Courtesy of SIG API Machinery, and SIG Node
- Mounts /home/kubernetes/bin/nvidia/vulkan/icd.d on the host to /etc/vulkan/icd.d inside containers requesting GPU. ([#78868](https://github.com/kubernetes/kubernetes/pull/78868), [@chardch](https://github.com/chardch))

  Courtesy of SIG Cluster Lifecycle
- update to use go 1.12.7 ([#79966](https://github.com/kubernetes/kubernetes/pull/79966), [@tao12345666333](https://github.com/tao12345666333))

  Courtesy of SIG Testing
- Add --shutdown-delay-duration to kube-apiserver in order to delay a graceful shutdown. `/healthz` will keep returning success during this time and requests are normally served, but `/readyz` will return faillure immediately. This delay can be used to allow the SDN to update iptables on all nodes and stop sending traffic. ([#74416](https://github.com/kubernetes/kubernetes/pull/74416), [@sttts](https://github.com/sttts))

  Courtesy of SIG API Machinery
- Implement "post-filter" extension point for scheduling framework ([#78097](https://github.com/kubernetes/kubernetes/pull/78097), [@draveness](https://github.com/draveness))

  Courtesy of SIG Scheduling, and SIG Testing
- Improves validation errors for custom resources ([#81212](https://github.com/kubernetes/kubernetes/pull/81212), [@liggitt](https://github.com/liggitt))

  Courtesy of SIG API Machinery
- Introduction of the pod overhead feature to the scheduler.  This functionality is alpha-level as of 
  Kubernetes v1.16, and is only honored by servers that enable the PodOverhead feature.gate.  ([#78319](https://github.com/kubernetes/kubernetes/pull/78319), [@egernst](https://github.com/egernst))

  Courtesy of SIG API Machinery, SIG Apps, SIG Node, and SIG Scheduling
- Attempt to set the kubelet's hostname & internal IP if `--cloud-provider=external` and no node addresses exists ([#75229](https://github.com/kubernetes/kubernetes/pull/75229), [@andrewsykim](https://github.com/andrewsykim))

  Courtesy of SIG Node
- Add Bind extension point of the scheduling framework ([#78513](https://github.com/kubernetes/kubernetes/pull/78513), [@chenchun](https://github.com/chenchun))

  Courtesy of SIG Scheduling, and SIG Testing
- Optimize EC2 DescribeInstances API calls in aws cloud provider library by querying instance ID instead of EC2 filters when possible ([#78140](https://github.com/kubernetes/kubernetes/pull/78140), [@zhan849](https://github.com/zhan849))

  Courtesy of SIG Cloud Provider, and SIG Scalability
- Add --kubernetes-version to "kubeadm init phase certs ca" and "kubeadm init phase kubeconfig" ([#80115](https://github.com/kubernetes/kubernetes/pull/80115), [@gyuho](https://github.com/gyuho))

  Courtesy of SIG Cluster Lifecycle
- Promote WatchBookmark feature to beta and enable it by default.
  With WatchBookmark feature, clients are able to request watch events with BOOKMARK type. Clients should not assume bookmarks are returned at any specific interval, nor may they assume the server will send any BOOKMARK event during a session. ([#79786](https://github.com/kubernetes/kubernetes/pull/79786), [@wojtek-t](https://github.com/wojtek-t))

  Courtesy of SIG API Machinery
- kubeadm: provide "--control-plane-endpoint" flag for `controlPlaneEndpoint` ([#79270](https://github.com/kubernetes/kubernetes/pull/79270), [@SataQiu](https://github.com/SataQiu))

  Courtesy of SIG Cluster Lifecycle
- In order to enable dual-stack support within kubeadm and kubernetes components, as part of the init config file, the user should set feature-gate IPv6DualStack=true in the ClusterConfiguration. Additionally, for each worker node, the user should set the feature-gate for kubelet using either nodeRegistration.kubeletExtraArgs or  KUBELET_EXTRA_ARGS. ([#80531](https://github.com/kubernetes/kubernetes/pull/80531), [@Arvinderpal](https://github.com/Arvinderpal))

  Courtesy of SIG Cluster Lifecycle
- Add support for AWS EBS on windows ([#79552](https://github.com/kubernetes/kubernetes/pull/79552), [@wongma7](https://github.com/wongma7))

  Courtesy of SIG Storage, SIG Testing, and SIG Windows
- if targetPort is changed that will process by service controller  ([#77712](https://github.com/kubernetes/kubernetes/pull/77712), [@Sn0rt](https://github.com/Sn0rt))

  Courtesy of SIG Apps, and SIG Network


## API Changes

- The alpha `metadata.initializers` field, deprecated in 1.13, has been removed. ([#79504](https://github.com/kubernetes/kubernetes/pull/79504), [@yue9944882](https://github.com/yue9944882))
- Add scheduling support for RuntimeClasses. RuntimeClasses can now specify nodeSelector constraints & tolerations, which are merged into the PodSpec for pods using that RuntimeClass. ([#80825](https://github.com/kubernetes/kubernetes/pull/80825), [@tallclair](https://github.com/tallclair))
- Kubelet should now more reliably report the same primary node IP even if the set of node IPs reported by the CloudProvider changes. ([#79391](https://github.com/kubernetes/kubernetes/pull/79391), [@danwinship](https://github.com/danwinship))


## Notes From Multiple SIGs

### SIG Cloud Provider, SIG Release, and SIG Testing

- Update to use go 1.12.8 ([#81390](https://github.com/kubernetes/kubernetes/pull/81390), [@cblecker](https://github.com/cblecker))

### SIG CLI, and SIG Storage

- Non nil DataSource entries on PVC's are now displayed as part of `describe pvc` output. ([#76463](https://github.com/kubernetes/kubernetes/pull/76463), [@j-griffith](https://github.com/j-griffith))

### SIG API Machinery, SIG CLI, SIG Node, and SIG Testing

- Fix kubelet errors in AArch64 with huge page sizes smaller than 1MiB ([#78495](https://github.com/kubernetes/kubernetes/pull/78495), [@odinuge](https://github.com/odinuge))

### SIG API Machinery, SIG Apps, and SIG Testing

- The namespace controller has been updated to use the metadata client which improves memory
  and CPU usage of the Kube controller manager. ([#78744](https://github.com/kubernetes/kubernetes/pull/78744), [@smarterclayton](https://github.com/smarterclayton))
- The garbage collector and generic object quota controller have been updated to use the metadata client which improves memory
  and CPU usage of the Kube controller manager. ([#78742](https://github.com/kubernetes/kubernetes/pull/78742), [@smarterclayton](https://github.com/smarterclayton))

### SIG Node, and SIG Scheduling

- Kubelet considers all static pods as critical. Static pods pass kubelet admission even if a node does not have enough resources. Users must ensure that they account for resources when creating static pods. ([#80491](https://github.com/kubernetes/kubernetes/pull/80491), [@hpandeycodeit](https://github.com/hpandeycodeit))

### SIG Cluster Lifecycle, SIG Storage, and SIG Testing

- Failed iscsi logout is now re-tried periodically. ([#78941](https://github.com/kubernetes/kubernetes/pull/78941), [@jsafrane](https://github.com/jsafrane))

### SIG Storage, and SIG Testing

- Pass-through volume MountOptions to global mount (NodeStageVolume) on the node for CSI ([#80191](https://github.com/kubernetes/kubernetes/pull/80191), [@davidz627](https://github.com/davidz627))

### SIG Node, and SIG Windows

- cpuUsageNanoCores is now reported in the Kubelet summary API on Windows nodes ([#80176](https://github.com/kubernetes/kubernetes/pull/80176), [@liyanhui1228](https://github.com/liyanhui1228))

### SIG API Machinery, SIG Apps, SIG Auth, SIG Node, and SIG Storage

- Remove CSIPersistentVolume feature gates ([#79309](https://github.com/kubernetes/kubernetes/pull/79309), [@draveness](https://github.com/draveness))

### SIG API Machinery, SIG Cluster Lifecycle, and SIG Release

- etcd Docker image can be run as non-root ([#79722](https://github.com/kubernetes/kubernetes/pull/79722), [@randomvariable](https://github.com/randomvariable))

### SIG Cloud Provider, and SIG Release

- cloud-controller-manager binaries and docker images are no longer shipped with kubernetes releases. ([#81029](https://github.com/kubernetes/kubernetes/pull/81029), [@dims](https://github.com/dims))

### SIG Release, and SIG Testing

- Update to use go 1.12.9 ([#81489](https://github.com/kubernetes/kubernetes/pull/81489), [@BenTheElder](https://github.com/BenTheElder))

### SIG Cluster Lifecycle, SIG Network, SIG Node, and SIG Testing

- kubelet now accepts a --cni-cache-dir option, which defaults to /var/lib/cni/cache, where CNI stores cache files. ([#78908](https://github.com/kubernetes/kubernetes/pull/78908), [@dcbw](https://github.com/dcbw))

### SIG API Machinery, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, SIG Storage, and SIG Testing

- Remove deprecated cloud providers - ovirt, cloudstack and photon ([#72178](https://github.com/kubernetes/kubernetes/pull/72178), [@dims](https://github.com/dims))

### SIG API Machinery, SIG Apps, SIG Architecture, SIG Node, and SIG Scheduling

- The deprecated node condition type 'OutOfDisk' has been removed. Use the 'DiskPressure' condition instead. ([#72420](https://github.com/kubernetes/kubernetes/pull/72420), [@Pingan2017](https://github.com/Pingan2017))

### SIG API Machinery, SIG Cloud Provider, and SIG Release

- hyperkube will drop support for cloud-controller-manager in a future release ([#81219](https://github.com/kubernetes/kubernetes/pull/81219), [@dims](https://github.com/dims))

### SIG Apps, and SIG Node

- Init container resource requests now impact pod QoS class ([#75223](https://github.com/kubernetes/kubernetes/pull/75223), [@sjenning](https://github.com/sjenning))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Node, and SIG Release

- Update golang/x/net dependency to bring in fixes for CVE-2019-9512, CVE-2019-9514 ([#81394](https://github.com/kubernetes/kubernetes/pull/81394), [@cblecker](https://github.com/cblecker))

### SIG Apps, SIG Node, SIG Testing, and SIG Windows

- Add v1.Container.SecurityContext.WindowsOptions.RunAsUserName to the pod spec  ([#79489](https://github.com/kubernetes/kubernetes/pull/79489), [@bclau](https://github.com/bclau))

### SIG API Machinery, and SIG Testing

- A new client `k8s.io/client-go/metadata.Client` has been added for accessing objects generically. This client makes it easier to retrieve only the metadata (the `metadata` sub-section) from resources on the cluster in an efficient manner for use cases that deal with objects generically, like the garbage collector, quota, or the namespace controller. The client asks the server to return a `meta.k8s.io/v1 PartialObjectMetadata` object for list, get, delete, watch, and patch operations on both normal APIs and custom resources which can be encoded in protobuf for additional work. If the server does not yet support this API the client will gracefully fall back to JSON and transform the response objects into PartialObjectMetadata. ([#77819](https://github.com/kubernetes/kubernetes/pull/77819), [@smarterclayton](https://github.com/smarterclayton))
- Fixes CVE-2019-11250: client-go header logging (at verbosity levels >= 7) now masks `Authorization` header contents ([#81330](https://github.com/kubernetes/kubernetes/pull/81330), [@tedyu](https://github.com/tedyu))
- Fixes a bug in openapi published for custom resources using x-kubernetes-preserve-unknown-fields extensions, so that kubectl will allow sending unknown fields for that portion of the object. ([#79636](https://github.com/kubernetes/kubernetes/pull/79636), [@liggitt](https://github.com/liggitt))

### SIG Apps, and SIG CLI

- kubectl logs --selector will support --tail=-1. ([#74943](https://github.com/kubernetes/kubernetes/pull/74943), [@JishanXing](https://github.com/JishanXing))

### SIG Cluster Lifecycle, and SIG Testing

- kube-addon-manager has been updated to v9.0.2 to fix a bug in leader election (https://github.com/kubernetes/kubernetes/pull/80575) ([#80861](https://github.com/kubernetes/kubernetes/pull/80861), [@mborsz](https://github.com/mborsz))

### SIG API Machinery, and SIG Scalability

- Fix a bug that ListOptions.AllowWatchBookmarks wasn't propagating correctly in kube-apiserver. ([#80157](https://github.com/kubernetes/kubernetes/pull/80157), [@wojtek-t](https://github.com/wojtek-t))
- Kubernetes now supports transparent compression of API responses. Clients that send `Accept-Encoding: gzip` will now receive a GZIP compressed response body if the API call was larger than 128KB.  Go clients automatically request gzip-encoding by default and should see reduced transfer times for very large API requests.  Clients in other languages may need to make changes to benefit from compression. ([#77449](https://github.com/kubernetes/kubernetes/pull/77449), [@smarterclayton](https://github.com/smarterclayton))

### SIG CLI, SIG Cluster Lifecycle, and SIG Testing

- E2E tests no longer add command line flags directly to the command line, test suites that want that need to be updated if they don't use HandleFlags
  loading a -viper-config=e2e.yaml with suffix (introduced in 1.13) works again and now has a regression test ([#75593](https://github.com/kubernetes/kubernetes/pull/75593), [@pohly](https://github.com/pohly))

### SIG API Machinery, SIG Apps, SIG Node, SIG Scheduling, and SIG Testing

- The GA PodPriority feature gate is now on by default and cannot be disabled. The feature gate will be removed in v1.18. ([#79262](https://github.com/kubernetes/kubernetes/pull/79262), [@draveness](https://github.com/draveness))

### SIG Cloud Provider, and SIG Storage

- Fixed detachment of deleted volumes on OpenStack / Cinder. ([#80518](https://github.com/kubernetes/kubernetes/pull/80518), [@jsafrane](https://github.com/jsafrane))

### SIG API Machinery, SIG Auth, SIG Cluster Lifecycle, and SIG Testing

- The kube-apiserver has improved behavior for both startup and shutdown sequences and also now exposes `\readyz` for readiness checking. Readyz includes all existing healthz checks but also adds a shutdown check. When a cluster admin initiates a shutdown, the kube-apiserver will try to process existing requests (for the duration of request timeout) before killing the apiserver process.  
  
  The apiserver also now takes an optional flag "--maximum-startup-sequence-duration". This allows you to explicitly define an upper bound on the apiserver startup sequences before healthz begins to fail. By keeping the kubelet liveness initial delay short, this can enable quick kubelet recovery as soon as we have a boot sequence which has not completed in our expected time frame, despite lack of completion from longer boot sequences (like RBAC). Kube-apiserver behavior when the value of this flag is zero is backwards compatible (this is as the defaulted value of the flag). ([#78458](https://github.com/kubernetes/kubernetes/pull/78458), [@logicalhan](https://github.com/logicalhan))

### SIG API Machinery, SIG Apps, and SIG Node

- API: the metadata.selfLink field is deprecated in individual and list objects. It will no longer be returned starting in v1.20, and the field will be removed entirely in v1.21. ([#80978](https://github.com/kubernetes/kubernetes/pull/80978), [@wojtek-t](https://github.com/wojtek-t))

### SIG Node, and SIG Storage

- Use O_CLOEXEC to ensure file descriptors do not leak to subprocesses. ([#74691](https://github.com/kubernetes/kubernetes/pull/74691), [@cpuguy83](https://github.com/cpuguy83))
- fix pod stuck issue due to corrupt mnt point in flexvol plugin, call Unmount if PathExists returns any error ([#75234](https://github.com/kubernetes/kubernetes/pull/75234), [@andyzhangx](https://github.com/andyzhangx))
- Errors from pod volume set up are now propagated as pod events. ([#80369](https://github.com/kubernetes/kubernetes/pull/80369), [@jsafrane](https://github.com/jsafrane))

### SIG Cluster Lifecycle, and SIG Network

- kubeadm: use the service-cidr flag to pass the desired service CIDR to the kube-controller-manager via its service-cluster-ip-range flag. ([#78625](https://github.com/kubernetes/kubernetes/pull/78625), [@Arvinderpal](https://github.com/Arvinderpal))

### SIG API Machinery, SIG CLI, SIG Release, and SIG Testing

- add  `kubectl replace --raw` and `kubectl delete --raw` to have parity with create and get ([#79724](https://github.com/kubernetes/kubernetes/pull/79724), [@deads2k](https://github.com/deads2k))

### SIG API Machinery, SIG Release, and SIG Testing

- The sample-apiserver gains support for OpenAPI v2 spec serving at `/openapi/v2`.
  
  The `generate-internal-groups.sh` script in k8s.io/code-generator will generate OpenAPI definitions by default in `pkg/generated/openapi`. Additional API group dependencies can be added via `OPENAPI_EXTRA_PACKAGES=<group>/<version> <group2>/<version2>...`. ([#79843](https://github.com/kubernetes/kubernetes/pull/79843), [@sttts](https://github.com/sttts))

### SIG API Machinery, SIG Auth, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Update gogo/protobuf to serialize backward, as to get better performance on deep objects. ([#77355](https://github.com/kubernetes/kubernetes/pull/77355), [@apelisse](https://github.com/apelisse))

### SIG Network, and SIG Node

- Fixes problems with connecting to services on localhost on some systems; in particular, DNS queries to systemd-resolved on Ubuntu. ([#80591](https://github.com/kubernetes/kubernetes/pull/80591), [@danwinship](https://github.com/danwinship))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, and SIG Cluster Lifecycle

- Reflector watchHandler Warning log 'The resourceVersion for the provided watch is too old.' is now logged as Info.  ([#78991](https://github.com/kubernetes/kubernetes/pull/78991), [@sallyom](https://github.com/sallyom))
- Fix a bug that pretty printer marshals empty byte or uint8 slice as null ([#81096](https://github.com/kubernetes/kubernetes/pull/81096), [@roycaihw](https://github.com/roycaihw))

### SIG API Machinery, and SIG Network

- Deprecate the `--cloud-provider-gce-lb-src-cidrs` flag in the kube-apiserver. This flag will be removed once the GCE Cloud Provider is removed from kube-apiserver.  ([#81094](https://github.com/kubernetes/kubernetes/pull/81094), [@andrewsykim](https://github.com/andrewsykim))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, SIG Network, SIG Node, SIG Release, and SIG Scheduling

- Fix duplicate error messages in cli commands ([#79493](https://github.com/kubernetes/kubernetes/pull/79493), [@odinuge](https://github.com/odinuge))

### SIG API Machinery, SIG CLI, SIG Cloud Provider, SIG Cluster Lifecycle, and SIG Node

- Fix CRD validation error on 'items' field. ([#76124](https://github.com/kubernetes/kubernetes/pull/76124), [@tossmilestone](https://github.com/tossmilestone))

### SIG Cluster Lifecycle, and SIG Instrumentation

- updated fluentd to 1.5.1, elasticsearchs & kibana to 7.1.1 ([#79014](https://github.com/kubernetes/kubernetes/pull/79014), [@monotek](https://github.com/monotek))

### SIG Node, SIG Storage, and SIG Testing

- Volumes specified in a pod but not used in it are no longer unnecessarily formatted, mounted and reported in `node.status.volumesInUse`. ([#81163](https://github.com/kubernetes/kubernetes/pull/81163), [@jsafrane](https://github.com/jsafrane))

### SIG API Machinery, SIG Apps, SIG Cluster Lifecycle, SIG Node, SIG Scheduling, SIG Storage, and SIG Testing

- `[]TopologySpreadConstraint` is introduced into PodSpec to support the "Even Pods Spread" alpha feature. ([#77327](https://github.com/kubernetes/kubernetes/pull/77327), [@Huang-Wei](https://github.com/Huang-Wei))

### SIG Auth, SIG Node, and SIG Storage

- Remove KubeletPluginsWatcher feature gates ([#79310](https://github.com/kubernetes/kubernetes/pull/79310), [@draveness](https://github.com/draveness))

### SIG API Machinery, and SIG Scheduling

- Correct the maximum allowed insecure bind port for the kube-scheduler and kube-apiserver to 65535. ([#79346](https://github.com/kubernetes/kubernetes/pull/79346), [@ncdc](https://github.com/ncdc))

### SIG API Machinery, and SIG Auth

- kube-apiserver: the `--basic-auth-file` flag and authentication mode is deprecated and will be removed in a future release. It is not recommended for production environments. ([#81152](https://github.com/kubernetes/kubernetes/pull/81152), [@tedyu](https://github.com/tedyu))
- SubjectAccessReview requests sent for RBAC escalation, impersonation, and pod security policy authorization checks now populate the version attribute. ([#80007](https://github.com/kubernetes/kubernetes/pull/80007), [@liggitt](https://github.com/liggitt))

### SIG API Machinery, and SIG Cluster Lifecycle

- etcd migration image no longer supports etcd2 version.  ([#80037](https://github.com/kubernetes/kubernetes/pull/80037), [@dims](https://github.com/dims))
- Use HTTPS as etcd-apiserver protocol when mTLS between etcd and kube-apiserver on master is enabled, change etcd metrics/health port to 2382. ([#77561](https://github.com/kubernetes/kubernetes/pull/77561), [@wenjiaswe](https://github.com/wenjiaswe))


## Notes from Individual SIGs

### SIG API Machinery

- Remove GetReference() and GetPartialReference() function from pkg/api/ref, as the same function exists also in staging/src/k8s.io/client-go/tools/ref ([#80361](https://github.com/kubernetes/kubernetes/pull/80361), [@wojtek-t](https://github.com/wojtek-t))
- Fix CVE-2019-11247: API server allows access to custom resources via wrong scope ([#80750](https://github.com/kubernetes/kubernetes/pull/80750), [@sttts](https://github.com/sttts))
- The CRD handler now properly re-creates stale CR storage to reflect CRD update. ([#79114](https://github.com/kubernetes/kubernetes/pull/79114), [@roycaihw](https://github.com/roycaihw))
- The alpha `metadata.initializers` field, deprecated in 1.13, has been removed. ([#79504](https://github.com/kubernetes/kubernetes/pull/79504), [@yue9944882](https://github.com/yue9944882))
- openapi now advertises correctly supported patch types for custom resources ([#81515](https://github.com/kubernetes/kubernetes/pull/81515), [@liggitt](https://github.com/liggitt))
- Resolves a transient 404 response to custom resource requests during server startup ([#81244](https://github.com/kubernetes/kubernetes/pull/81244), [@liggitt](https://github.com/liggitt))
- Resolves an issue serving aggregated APIs backed by services that respond to requests to `/` with non-2xx HTTP responses ([#79895](https://github.com/kubernetes/kubernetes/pull/79895), [@deads2k](https://github.com/deads2k))

### SIG Apps

- fix a bug that pods not be deleted from unmatched nodes by daemon controller   ([#78974](https://github.com/kubernetes/kubernetes/pull/78974), [@DaiHao](https://github.com/DaiHao))
- Fix a bug that causes DaemonSet rolling update hang when there exist failed pods.  ([#78170](https://github.com/kubernetes/kubernetes/pull/78170), [@DaiHao](https://github.com/DaiHao))

### SIG CLI

- Fixes output of `kubectl get --watch-only` when watching a single resource ([#79345](https://github.com/kubernetes/kubernetes/pull/79345), [@liggitt](https://github.com/liggitt))
- Fixes a bug where `kubectl set config` hangs and uses 100% CPU on some invalid property names  ([#79000](https://github.com/kubernetes/kubernetes/pull/79000), [@pswica](https://github.com/pswica))
- Fixes invalid "time stamp is the future" error when kubectl cp-ing a file ([#73982](https://github.com/kubernetes/kubernetes/pull/73982), [@tanshanshan](https://github.com/tanshanshan))
- Fix CVE-2019-11249: Incomplete fixes for CVE-2019-1002101 and CVE-2019-11246, kubectl cp potential directory traversal ([#80436](https://github.com/kubernetes/kubernetes/pull/80436), [@M00nF1sh](https://github.com/M00nF1sh))
- Fixed the bash completion error with override flags. ([#80802](https://github.com/kubernetes/kubernetes/pull/80802), [@dtaniwaki](https://github.com/dtaniwaki))
- Fix a bug in server printer that could cause kube-apiserver to panic. ([#79349](https://github.com/kubernetes/kubernetes/pull/79349), [@roycaihw](https://github.com/roycaihw))

### SIG Cloud Provider

- fix: make azure disk URI as case insensitive ([#79020](https://github.com/kubernetes/kubernetes/pull/79020), [@andyzhangx](https://github.com/andyzhangx))
- Fix Azure client requests stuck issues on http.StatusTooManyRequests (HTTP Code 429). ([#81279](https://github.com/kubernetes/kubernetes/pull/81279), [@feiskyer](https://github.com/feiskyer))
- Fix conflicted cache when the requests are canceled by other Azure operations. ([#81282](https://github.com/kubernetes/kubernetes/pull/81282), [@feiskyer](https://github.com/feiskyer))
- Fix retry issues when the nodes are under deleting on Azure ([#80419](https://github.com/kubernetes/kubernetes/pull/80419), [@feiskyer](https://github.com/feiskyer))
- Fix public IP not found issues for VMSS nodes ([#80703](https://github.com/kubernetes/kubernetes/pull/80703), [@feiskyer](https://github.com/feiskyer))
- When a load balancer type service is created in a k8s cluster that is backed by Azure Standard Load Balancer, the corresponding load balancer rule added in the Azure Standard Load Balancer would now have the "EnableTcpReset" property set to true.  ([#80624](https://github.com/kubernetes/kubernetes/pull/80624), [@xuto2](https://github.com/xuto2))
- switch to VM Update call in attach/detach disk operation, original CreateOrUpdate call may lead to orphaned VMs or blocked resources ([#81208](https://github.com/kubernetes/kubernetes/pull/81208), [@andyzhangx](https://github.com/andyzhangx))
- Kubelet could be run with no Azure identity without subscriptionId configured now.
  A sample cloud provider configure is: '{"vmType": "vmss", "useInstanceMetadata": true}'. ([#81500](https://github.com/kubernetes/kubernetes/pull/81500), [@feiskyer](https://github.com/feiskyer))
- Default resourceGroup should be used when the value of annotation azure-load-balancer-resource-group is an empty string. ([#79514](https://github.com/kubernetes/kubernetes/pull/79514), [@feiskyer](https://github.com/feiskyer))

### SIG Cluster Lifecycle

- Fixed a bug in kube-addon-manager's leader election logic that made all replicas active. ([#80575](https://github.com/kubernetes/kubernetes/pull/80575), [@mborsz](https://github.com/mborsz))
- kubeadm: avoid double deletion of the upgrade prepull DaemonSet ([#80798](https://github.com/kubernetes/kubernetes/pull/80798), [@xlgao-zju](https://github.com/xlgao-zju))
- Fix error in `kubeadm join --discovery-file` when using discovery files with embedded credentials ([#80675](https://github.com/kubernetes/kubernetes/pull/80675), [@fabriziopandini](https://github.com/fabriziopandini))
- Volume expansion is enabled in the default GCE storageclass ([#78672](https://github.com/kubernetes/kubernetes/pull/78672), [@msau42](https://github.com/msau42))
- Fix remove the etcd member from the cluster during a kubeadm reset. ([#79326](https://github.com/kubernetes/kubernetes/pull/79326), [@bradbeam](https://github.com/bradbeam))
- Update the GCE windows node image to include hot fixes since July. ([#81106](https://github.com/kubernetes/kubernetes/pull/81106), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm: fix "certificate-authority" files not being pre-loaded when using file discovery ([#80966](https://github.com/kubernetes/kubernetes/pull/80966), [@neolit123](https://github.com/neolit123))
- kubeadm: fixed ignoring errors when pulling control plane images ([#80529](https://github.com/kubernetes/kubernetes/pull/80529), [@bart0sh](https://github.com/bart0sh))
- This PR fixes an error when using external etcd but storing etcd certificates in the same folder and with the same name used by kubeadm for local etcd certificates; for an older version of kubeadm, the workaround is to avoid file name used by kubeadm for local etcd. ([#80867](https://github.com/kubernetes/kubernetes/pull/80867), [@fabriziopandini](https://github.com/fabriziopandini))
- kubeadm: fix a potential panic if kubeadm discovers an invalid, existing kubeconfig file ([#79165](https://github.com/kubernetes/kubernetes/pull/79165), [@neolit123](https://github.com/neolit123))
- kubeadm: implement support for concurrent add/remove of stacked etcd members ([#79677](https://github.com/kubernetes/kubernetes/pull/79677), [@neolit123](https://github.com/neolit123))
- kubeadm: treat non-fatal errors as warnings when doing reset ([#80862](https://github.com/kubernetes/kubernetes/pull/80862), [@drpaneas](https://github.com/drpaneas))
- kubeadm: use etcd's /health endpoint for a HTTP liveness probe on localhost instead of having a custom health check using etcdctl ([#81385](https://github.com/kubernetes/kubernetes/pull/81385), [@neolit123](https://github.com/neolit123))
- Add instruction to setup "Application Default Credentials" to run GCE Windows e2e tests locally.  ([#81337](https://github.com/kubernetes/kubernetes/pull/81337), [@YangLu1031](https://github.com/YangLu1031))
- kubeadm: fall back to client version in case of certain HTTP errors ([#80024](https://github.com/kubernetes/kubernetes/pull/80024), [@RainbowMango](https://github.com/RainbowMango))
- kubeadm: the permissions of generated CSR files are changed from 0644 to 0600 ([#81217](https://github.com/kubernetes/kubernetes/pull/81217), [@SataQiu](https://github.com/SataQiu))
- Fix error handling and potential go null pointer exception in kubeadm upgrade diff ([#80648](https://github.com/kubernetes/kubernetes/pull/80648), [@odinuge](https://github.com/odinuge))
- kubeadm: fix the bug that "--cri-socket" flag does not work for `kubeadm reset` ([#79498](https://github.com/kubernetes/kubernetes/pull/79498), [@SataQiu](https://github.com/SataQiu))
- "kubeadm join" fails if file-based discovery is too long, with a default timeout of 5 minutes. ([#80804](https://github.com/kubernetes/kubernetes/pull/80804), [@olivierlemasle](https://github.com/olivierlemasle))
- kubeadm: introduce deterministic ordering for the certificates generation in the phase command "kubeadm init phase certs" . ([#78556](https://github.com/kubernetes/kubernetes/pull/78556), [@neolit123](https://github.com/neolit123))
- kubeadm: implement retry logic for certain ConfigMap failures when joining nodes ([#78915](https://github.com/kubernetes/kubernetes/pull/78915), [@ereslibre](https://github.com/ereslibre))
- kubeadm: prevent PSP blocking of upgrade image prepull by using a non-root user ([#77792](https://github.com/kubernetes/kubernetes/pull/77792), [@neolit123](https://github.com/neolit123))
- kubeadm: produce errors if they occur when resetting cluster status for a control-plane node ([#80573](https://github.com/kubernetes/kubernetes/pull/80573), [@bart0sh](https://github.com/bart0sh))

### SIG Network

- Reduce kube-proxy cpu usage in IPVS mode when a large number of nodePort services exist. ([#79444](https://github.com/kubernetes/kubernetes/pull/79444), [@cezarsa](https://github.com/cezarsa))
- Improvement in Kube-proxy. Kube-proxy waits for some duration for the node to be defined. ([#77167](https://github.com/kubernetes/kubernetes/pull/77167), [@paulsubrata55](https://github.com/paulsubrata55))
- Fix a bug in the IPVS proxier where virtual servers are not cleaned up even though the corresponding Service object was deleted. ([#80942](https://github.com/kubernetes/kubernetes/pull/80942), [@gongguan](https://github.com/gongguan))
- Increase log level for graceful termination to v=5 ([#80100](https://github.com/kubernetes/kubernetes/pull/80100), [@andrewsykim](https://github.com/andrewsykim))
- kube-proxy --cleanup will return the correct exit code if the cleanup was successful ([#78775](https://github.com/kubernetes/kubernetes/pull/78775), [@johscheuer](https://github.com/johscheuer))
- Fix a string comparison bug in IPVS graceful termination where UDP real servers are not deleted. ([#78999](https://github.com/kubernetes/kubernetes/pull/78999), [@andrewsykim](https://github.com/andrewsykim))

### SIG Node

- Passing an invalid policy name in the `--cpu-manager-policy` flag will now cause the kubelet to fail instead of simply ignoring the flag and running the `cpumanager`s default policy instead. ([#80294](https://github.com/kubernetes/kubernetes/pull/80294), [@klueska](https://github.com/klueska))
- Fix a bug where kubelet would not retry pod sandbox creation when the restart policy of the pod is Never ([#79451](https://github.com/kubernetes/kubernetes/pull/79451), [@yujuhong](https://github.com/yujuhong))
- When specifying `--(kube|system)-reserved-cgroup`, with `--cgroup-driver=systemd`, it is now possible to use the fully qualified cgroupfs name (i.e. `/test-cgroup.slice`). ([#78793](https://github.com/kubernetes/kubernetes/pull/78793), [@mattjmcnaughton](https://github.com/mattjmcnaughton))
- Add scheduling support for RuntimeClasses. RuntimeClasses can now specify nodeSelector constraints & tolerations, which are merged into the PodSpec for pods using that RuntimeClass. ([#80825](https://github.com/kubernetes/kubernetes/pull/80825), [@tallclair](https://github.com/tallclair))
- make node lease renew interval more heuristic based on node-status-update-frequency in kubelet ([#80173](https://github.com/kubernetes/kubernetes/pull/80173), [@gaorong](https://github.com/gaorong))
- kubelet's --containerized flag was deprecated in 1.14. This flag is removed in 1.16. ([#80043](https://github.com/kubernetes/kubernetes/pull/80043), [@dims](https://github.com/dims))
- Remove pids cgroup controller requirement when related feature gates are disabled
   ([#79073](https://github.com/kubernetes/kubernetes/pull/79073), [@rafatio](https://github.com/rafatio))
- na ([#79892](https://github.com/kubernetes/kubernetes/pull/79892), [@mikebrow](https://github.com/mikebrow))
- Kubelet should now more reliably report the same primary node IP even if the set of node IPs reported by the CloudProvider changes. ([#79391](https://github.com/kubernetes/kubernetes/pull/79391), [@danwinship](https://github.com/danwinship))
- Fix kubelet NodeLease potential performance issues. Kubelet now will try to update lease using cached one instead of get from API Server every time. ([#81174](https://github.com/kubernetes/kubernetes/pull/81174), [@answer1991](https://github.com/answer1991))

### SIG Release

- Remove HugePages, VolumeScheduling, CustomPodDNS and PodReadinessGates feature flags ([#79307](https://github.com/kubernetes/kubernetes/pull/79307), [@draveness](https://github.com/draveness))

### SIG Scheduling

- Scheduler should terminate when it looses leader lock. ([#81306](https://github.com/kubernetes/kubernetes/pull/81306), [@ravisantoshgudimetla](https://github.com/ravisantoshgudimetla))
- If scheduler extender filtered a not found node, current scheduling round for this pod will just be skipped.
   ([#79641](https://github.com/kubernetes/kubernetes/pull/79641), [@yqwang-ms](https://github.com/yqwang-ms))
- Extender bind should respect IsInterested ([#79804](https://github.com/kubernetes/kubernetes/pull/79804), [@yqwang-ms](https://github.com/yqwang-ms))

### SIG Storage

- Fix possible fd leak and closing of dirs in doSafeMakeDir  ([#79534](https://github.com/kubernetes/kubernetes/pull/79534), [@odinuge](https://github.com/odinuge))
- Update portworx plugin dependency on libopenstorage/openstorage to v1.0.0 ([#80495](https://github.com/kubernetes/kubernetes/pull/80495), [@adityadani](https://github.com/adityadani))
- fix kubelet fail to delete orphaned pod directory when the kubelet's pods directory (default is "/var/lib/kubelet/pods") symbolically links to another disk device's directory ([#79094](https://github.com/kubernetes/kubernetes/pull/79094), [@gaorong](https://github.com/gaorong))
- Cinder and ScaleIO volume providers have been deprecated and will be removed in a future release. ([#80099](https://github.com/kubernetes/kubernetes/pull/80099), [@dims](https://github.com/dims))
- Reduces GCE PD Node Attach Limits by 1 since the node boot disk is considered an attachable disk ([#80923](https://github.com/kubernetes/kubernetes/pull/80923), [@davidz627](https://github.com/davidz627))
-     Azure disks of shared kind will no longer fail if they do not contain skuname or 
      storageaccounttype. ([#80837](https://github.com/kubernetes/kubernetes/pull/80837), [@rmweir](https://github.com/rmweir))
- changes timeout value in csi plugin from 15s to 2min which fixes the timeout issue ([#79529](https://github.com/kubernetes/kubernetes/pull/79529), [@andyzhangx](https://github.com/andyzhangx))
- Fixes validation of VolumeAttachment API objects created with inline volume sources. ([#80945](https://github.com/kubernetes/kubernetes/pull/80945), [@tedyu](https://github.com/tedyu))
- remove iSCSI volume storage cleartext secrets in logs ([#81215](https://github.com/kubernetes/kubernetes/pull/81215), [@zouyee](https://github.com/zouyee))
- Bugfix: csi plugin supporting raw block that does not need attach mounted failed ([#79920](https://github.com/kubernetes/kubernetes/pull/79920), [@cwdsuzhou](https://github.com/cwdsuzhou))
- NFS Drivers are now enabled to collect metrics, StatFS metrics provider is used to collect the metrics. (&#35;75805 , @brahmaroutu) ([#75805](https://github.com/kubernetes/kubernetes/pull/75805), [@brahmaroutu](https://github.com/brahmaroutu))
- Fixed a bug in the CSI metrics that does not return not supported error when a CSI driver does not support metrics. ([#79851](https://github.com/kubernetes/kubernetes/pull/79851), [@jparklab](https://github.com/jparklab))

### SIG Testing

- Remove deprecated github.com/kardianos/osext dependency ([#80142](https://github.com/kubernetes/kubernetes/pull/80142), [@loqutus](https://github.com/loqutus))
- fix pod list return value of framework.WaitForPodsWithLabelRunningReady ([#78687](https://github.com/kubernetes/kubernetes/pull/78687), [@pohly](https://github.com/pohly))



## Bug Fixes

- Determine system model to get credentials for windows nodes. ([#80764](https://github.com/kubernetes/kubernetes/pull/80764), [@liyanhui1228](https://github.com/liyanhui1228))


