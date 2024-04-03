## Changes by Kind

### Deprecation

- Kubectl: removed deprecated flag `prune-whitelist` for apply, use flag `prune-allowlist` instead. ([#120246](https://github.com/kubernetes/kubernetes/pull/120246), [@pacoxu](https://github.com/pacoxu))
- Removed the `SecurityContextDeny` admission plugin, deprecated since `v1.27`. The Pod Security Admission plugin, available since v1.25, is recommended instead. See https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#securitycontextdeny for more information. ([#122612](https://github.com/kubernetes/kubernetes/pull/122612), [@mtardy](https://github.com/mtardy))

### API Change

- 'PodSpec API: removed note that hostAliases are not supported on hostNetwork Pods. The feature has been supported since v1.8.'
   ([#122422](https://github.com/kubernetes/kubernetes/pull/122422), [@neolit123](https://github.com/neolit123))
- A new (alpha) field, `trafficDistribution`, has been added to the Service `spec`.
  This field provides a way to express preferences for how traffic is distributed to the endpoints for a Service.
  It can be enabled through the `ServiceTrafficDistribution` feature gate. ([#123487](https://github.com/kubernetes/kubernetes/pull/123487), [@gauravkghildiyal](https://github.com/gauravkghildiyal)) [SIG API Machinery, Apps and Network]
- Added (alpha) support for the managedBy field on Jobs. Jobs with a custom value of this field - any
  value other than `kubernetes.io/job-controller` - are skipped by the job controller, and their
  reconciliation is delegated to an external controller, indicated by the value of the field. Jobs that
  don't have this field at all, or where the field value is the reserved string `kubernetes.io/job-controller`,
  are reconciled by the built-in job controller. ([#123273](https://github.com/kubernetes/kubernetes/pull/123273), [@mimowo](https://github.com/mimowo)) [SIG API Machinery, Apps and Testing]
- Added `CEL` library for IP Addresses and CIDRs. This will not be available for use until 1.31. ([#121912](https://github.com/kubernetes/kubernetes/pull/121912), [@JoelSpeed](https://github.com/JoelSpeed))
- Added a CBOR implementation of `runtime.Serializer`. Until CBOR graduates to Alpha, API servers will refuse to start if configured with CBOR support. ([#122881](https://github.com/kubernetes/kubernetes/pull/122881), [@benluddy](https://github.com/benluddy)) [SIG API Machinery]
- Added a alpha feature, behind the `RelaxedEnvironmentVariableValidation` feature gate.
  When that gate is enabled, Kubernetes allows almost all printable ASCII characters to be used in the names
  of environment variables for containers in Pods. ([#123385](https://github.com/kubernetes/kubernetes/pull/123385), [@HirazawaUi](https://github.com/HirazawaUi)) [SIG Apps, Node and Testing]
- Added a rule on the `kube_codegen` tool to ignore vendor folder during the code generation. ([#122729](https://github.com/kubernetes/kubernetes/pull/122729), [@jparrill](https://github.com/jparrill))
- Added alpha support for field selectors on custom resources.
  Provided that the `CustomResourceFieldSelectors` feature gate is enabled, the CustomResourceDefinition
  API now lets you specify `selectableFields`. Listing a field there allows filtering custom resources for that
  CustomResourceDefinition in **list** or **watch** requests. ([#122717](https://github.com/kubernetes/kubernetes/pull/122717), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery]
- Added alpha-level support for the SuccessPolicy in Jobs. ([#123412](https://github.com/kubernetes/kubernetes/pull/123412), [@tenzen-y](https://github.com/tenzen-y))
- Added audienceMatchPolicy field to AuthenticationConfiguration and support for configuring multiple audiences.
  The "audienceMatchPolicy" can be empty (or unset) when a single audience is specified in the "audiences" field.
  The "audienceMatchPolicy" must be set to "MatchAny" when multiple audiences are specified in the "audiences" field. ([#123165](https://github.com/kubernetes/kubernetes/pull/123165), [@aramase](https://github.com/aramase))
- Added support for configuring multiple JWT authenticators in Structured Authentication Configuration. The maximum allowed JWT authenticators in the authentication configuration is 64. ([#123431](https://github.com/kubernetes/kubernetes/pull/123431), [@aramase](https://github.com/aramase)) [SIG Auth and Testing]
- Added the following CLI option for `kube-controller-manager`:
  - `disable-force-detach` (defaults to `false`): Prevent force detaching volumes based on maximum unmount time and node status. If enabled, the non-graceful node shutdown feature must be used to recover from node failure (see https://kubernetes.io/blog/2023/08/16/kubernetes-1-28-non-graceful-node-shutdown-ga/). If enabled and a pod must be forcibly terminated at the risk of corruption, then the appropriate VolumeAttachment object (see here: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/volume-attachment-v1/) must be deleted. ([#120344](https://github.com/kubernetes/kubernetes/pull/120344), [@rohitssingh](https://github.com/rohitssingh))
- Added to `MutableFeatureGate` the ability to override the default setting of feature gates, to allow default-enabling a feature on a component-by-component basis instead of for all affected components simultaneously. ([#122647](https://github.com/kubernetes/kubernetes/pull/122647), [@benluddy](https://github.com/benluddy))
- Aggregated discovery supports both v2beta1 and v2 types and feature is promoted to GA. ([#122882](https://github.com/kubernetes/kubernetes/pull/122882), [@Jefftree](https://github.com/Jefftree))
- Allowed container runtimes to fix an image garbage collection bug by adding an `image_id` field to the CRI Container message. ([#123508](https://github.com/kubernetes/kubernetes/pull/123508), [@saschagrunert](https://github.com/saschagrunert))
- Allowed users to mutate `FSGroupPolicy` and `PodInfoOnMount` in `CSIDriver.Spec`. ([#116209](https://github.com/kubernetes/kubernetes/pull/116209), [@haoruan](https://github.com/haoruan))
- AppArmor profiles can now be configured through fields on the PodSecurityContext and container SecurityContext.
  - The beta AppArmor annotations are deprecated.
  - AppArmor status is no longer included in the node ready condition ([#123435](https://github.com/kubernetes/kubernetes/pull/123435), [@tallclair](https://github.com/tallclair)) [SIG API Machinery, Apps, Auth, Node and Testing]
- Client-go events: `NewEventBroadcasterAdapterWithContext` should be used instead of `NewEventBroadcasterAdapter` if the goal is to support contextual logging. ([#122142](https://github.com/kubernetes/kubernetes/pull/122142), [@pohly](https://github.com/pohly)) [SIG API Machinery, Instrumentation and Scheduling]
- Conflicting issuers between JWT authenticators and service account config are now detected and fail on API server startup.  Previously such a config would run but would be inconsistently effective depending on the credential. ([#123561](https://github.com/kubernetes/kubernetes/pull/123561), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- Contextual logging is now beta and enabled by default. ([#122589](https://github.com/kubernetes/kubernetes/pull/122589), [@pohly](https://github.com/pohly)) [SIG Instrumentation]
- Cri-api: KEP-3857: Recursive Read-only (RRO) mounts. ([#123272](https://github.com/kubernetes/kubernetes/pull/123272), [@AkihiroSuda](https://github.com/AkihiroSuda))
- Dynamic Resource Allocation: DRA drivers may now use "structured parameters" to let the scheduler handle claim allocation. ([#123516](https://github.com/kubernetes/kubernetes/pull/123516), [@pohly](https://github.com/pohly)) [SIG API Machinery, Apps, Auth, CLI, Cluster Lifecycle, Instrumentation, Node, Release, Scheduling, Storage and Testing]
- Enabled a mechanism for concurrent log rotatation via `kubelet` using a configuration entity of `containerLogMaxWorkers` which controls the maximum number of concurrent rotation that can be performed and an interval configuration of `containerLogMonitorInterval` that can aid in configuring the monitoring duration to best suite your cluster's log generation standards. ([#114301](https://github.com/kubernetes/kubernetes/pull/114301), [@harshanarayana](https://github.com/harshanarayana))
- Fixed accidental enablement of the new alpha `optionalOldSelf` API field in `CustomResourceDefinition` validation rules, which should only be allowed to be set when the `CRDValidationRatcheting` feature gate is enabled. ([#122329](https://github.com/kubernetes/kubernetes/pull/122329), [@jpbetz](https://github.com/jpbetz))
- Graduated pod scheduling gates to general availability.
  The `PodSchedulingReadiness` feature gate no longer has any effect, and the
  `.spec.schedulingGates` field is always available within the Pod and PodTemplate APIs. ([#123575](https://github.com/kubernetes/kubernetes/pull/123575), [@Huang-Wei](https://github.com/Huang-Wei)) [SIG API Machinery, Apps, Node, Scheduling and Testing]
- Graduated support for `minDomains` in pod topology spread constraints, to general availability.
  The `MinDomainsInPodTopologySpread` feature gate no longer has any effect, and the field is
  always available within the Pod and PodTemplate APIs. ([#123481](https://github.com/kubernetes/kubernetes/pull/123481), [@sanposhiho](https://github.com/sanposhiho)) [SIG API Machinery, Apps, Scheduling and Testing]
- Implemented  `prescore` extension point for `volumeBinding` plugin. Return skip if it doesn't do anything in Score. ([#115768](https://github.com/kubernetes/kubernetes/pull/115768), [@AxeZhan](https://github.com/AxeZhan))
- JWT authenticator config set via the --authentication-config flag is now dynamically reloaded as the file changes on disk. ([#123525](https://github.com/kubernetes/kubernetes/pull/123525), [@enj](https://github.com/enj)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver: the AuthenticationConfiguration type accepted in `--authentication-config` files has been promoted to `apiserver.config.k8s.io/v1beta1`. ([#123696](https://github.com/kubernetes/kubernetes/pull/123696), [@aramase](https://github.com/aramase)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver: the AuthorizationConfiguration type accepted in `--authorization-config` files has been promoted to `apiserver.config.k8s.io/v1beta1`. ([#123640](https://github.com/kubernetes/kubernetes/pull/123640), [@liggitt](https://github.com/liggitt)) [SIG Auth and Testing]
- Kubelet should fail if NodeSwap is used with LimitedSwap and cgroupv1 node. ([#123738](https://github.com/kubernetes/kubernetes/pull/123738), [@kannon92](https://github.com/kannon92)) [SIG API Machinery, Node and Testing]
- Kubelet: a custom root directory for pod logs (instead of default /var/log/pods) can be specified using the `podLogsDir`
  key in kubelet configuration. ([#112957](https://github.com/kubernetes/kubernetes/pull/112957), [@mxpv](https://github.com/mxpv)) [SIG API Machinery, Node, Scalability and Testing]
- Kubelet: the `.memorySwap.swapBehavior` field in kubelet configuration accepts a new value `NoSwap` and makes this the default if unspecified; the previously accepted `UnlimitedSwap` value has been dropped. ([#122745](https://github.com/kubernetes/kubernetes/pull/122745), [@kannon92](https://github.com/kannon92)) [SIG API Machinery, Node and Testing]
- OIDC authentication will now fail if the username asserted based on a CEL expression config is the empty string.  Previously the request would be authenticated with the username set to the empty string. ([#123568](https://github.com/kubernetes/kubernetes/pull/123568), [@enj](https://github.com/enj)) [SIG API Machinery, Auth and Testing]
- Promoted AdmissionWebhookMatchConditions to GA. The feature is now stable and the feature gate is now locked to default. ([#123560](https://github.com/kubernetes/kubernetes/pull/123560), [@ivelichkovich](https://github.com/ivelichkovich))
- Resource.k8s.io/ResourceClaim (alpha API): the strategic merge patch strategy for the `status.reservedFor` array was changed such that a strategic-merge-patch can add individual entries. This breaks clients using strategic merge patch to update status which rely on the previous behavior (replacing the entire array). ([#122276](https://github.com/kubernetes/kubernetes/pull/122276), [@pohly](https://github.com/pohly)) [SIG API Machinery]
- Structured Authentication Configuration now supports `DiscoveryURL`. 
  discoveryURL if specified, overrides the URL used to fetch discovery information. 
  This is for scenarios where the well-known and jwks endpoints are hosted at a different
  location than the issuer (such as locally in the cluster). ([#123527](https://github.com/kubernetes/kubernetes/pull/123527), [@aramase](https://github.com/aramase)) [SIG API Machinery, Auth and Testing]
- Support Recursive Read-only (RRO) mounts  (KEP-3857) ([#123180](https://github.com/kubernetes/kubernetes/pull/123180), [@AkihiroSuda](https://github.com/AkihiroSuda)) [SIG API Machinery, Apps, Node and Testing]
- Text logging in Kubernetes components now uses [textlogger](https://pkg.go.dev/k8s.io/klog/v2@v2.120.0/textlogger). The same split streams of info and error log entries with buffering of info entries is now also supported for text output (off by default, alpha feature). Previously, this was only supported for JSON. Performance is better also without split streams. ([#114672](https://github.com/kubernetes/kubernetes/pull/114672), [@pohly](https://github.com/pohly)) [SIG API Machinery, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Storage and Testing]
- The StructuredAuthenticationConfiguration feature is now beta and enabled by default. ([#123719](https://github.com/kubernetes/kubernetes/pull/123719), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- The `StorageVersionMigration` API, which was previously available as a Custom Resource Definition (CRD), is now a built-in API in Kubernetes. ([#123344](https://github.com/kubernetes/kubernetes/pull/123344), [@nilekhc](https://github.com/nilekhc)) [SIG API Machinery, Apps, Auth, CLI and Testing]
- The kubernetes repo now uses Go workspaces.  This should not impact end users at all, but does have impact for developers of downstream projects.  Switching to workspaces caused some breaking changes in the flags to the various k8s.io/code-generator tools.  Downstream consumers should look at staging/src/k8s.io/code-generator/kube_codegen.sh to see the changes. ([#123529](https://github.com/kubernetes/kubernetes/pull/123529), [@thockin](https://github.com/thockin)) [SIG API Machinery, Apps, Architecture, Auth, CLI, Cloud Provider, Cluster Lifecycle, Instrumentation, Network, Node, Release, Storage and Testing]
- Updated an audit annotation key used by the `…/serviceaccounts/<name>/token` resource handler.
  The annotation used to persist the issued credential identifier is now `authentication.kubernetes.io/issued-credential-id`. ([#123098](https://github.com/kubernetes/kubernetes/pull/123098), [@munnerz](https://github.com/munnerz)) [SIG Auth]
- ValidatingAdmissionPolicy was promoted to GA and will be enabled by default. ([#123405](https://github.com/kubernetes/kubernetes/pull/123405), [@cici37](https://github.com/cici37))
- When configuring a JWT authenticator:
  
  If username.expression uses 'claims.email', then 'claims.email_verified' must be used in
  username.expression or extra[*].valueExpression or claimValidationRules[*].expression.
  An example claim validation rule expression that matches the validation automatically
  applied when username.claim is set to 'email' is 'claims.?email_verified.orValue(true)'. ([#123737](https://github.com/kubernetes/kubernetes/pull/123737), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- When scheduling a mixture of pods using `ResourceClaims` and others which don't, scheduling a pod with `ResourceClaims` impacts scheduling latency less. ([#121876](https://github.com/kubernetes/kubernetes/pull/121876), [@pohly](https://github.com/pohly))

### Feature

- A new kubelet metric `image_pull_duration_seconds` was added. The metric tracks the duration (in seconds) it takes for an image to be pulled, including the time spent in the waiting queue of image puller. The metric is broken down by bucketed image size. ([#121719](https://github.com/kubernetes/kubernetes/pull/121719), [@ruiwen-zhao](https://github.com/ruiwen-zhao))
- A new metric `lifecycle_handler_sleep_terminated_total` is added to record how many times LifecycleHandler sleep got unexpectedly terminated. ([#122456](https://github.com/kubernetes/kubernetes/pull/122456), [@AxeZhan](https://github.com/AxeZhan)) [SIG Node and Testing]
- Added "reason" field to image_garbage_collected_total metric, so admins can differentiate images that were collected for reason "age" vs "space". ([#123345](https://github.com/kubernetes/kubernetes/pull/123345), [@haircommander](https://github.com/haircommander))
- Added Timezone column in the output of kubectl get cronjob command. ([#122231](https://github.com/kubernetes/kubernetes/pull/122231), [@ardaguclu](https://github.com/ardaguclu))
- Added `WatchListClient` feature gate to `client-go`. When enabled it allows the client to get a stream of individual items instead of chunking from the server. ([#122571](https://github.com/kubernetes/kubernetes/pull/122571), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Added `access_mode` label to `volume_manager_selinux_*` metrics. ([#123667](https://github.com/kubernetes/kubernetes/pull/123667), [@jsafrane](https://github.com/jsafrane)) [SIG Node, Storage and Testing]
- Added `client-go` support for upgrading subresource fields from client-side to server-side management. ([#123484](https://github.com/kubernetes/kubernetes/pull/123484), [@erikgb](https://github.com/erikgb))
- Added `exec-interactive-mode` and `exec-provide-cluster-info` flags in kubectl config set-credentials command. ([#122023](https://github.com/kubernetes/kubernetes/pull/122023), [@ardaguclu](https://github.com/ardaguclu))
- Added `process_start_time_seconds` to `/metrics/slis` endpoint of all components. ([#122750](https://github.com/kubernetes/kubernetes/pull/122750), [@richabanker](https://github.com/richabanker))
- Added a new metric `apiserver_encryption_config_controller_automatic_reloads_total` 
  to measure total number of API server encryption configuration reload successes and failures. 
  This metric contains the `status` label with a value that is either `success` or `failure`.
  Deprecated the metrics `apiserver_encryption_config_controller_automatic_reload_success_total`
  and `apiserver_encryption_config_controller_automatic_reload_failure_total`. 
  Use `apiserver_encryption_config_controller_automatic_reloads_total` instead. ([#123179](https://github.com/kubernetes/kubernetes/pull/123179), [@aramase](https://github.com/aramase))
- Added apiserver_watch_cache_read_wait metric to measure watch cache impact on request latency. ([#123190](https://github.com/kubernetes/kubernetes/pull/123190), [@padlar](https://github.com/padlar)) [SIG API Machinery and Instrumentation]
- Added feature gate `MutatingAdmissionPolicy` for enabling mutation policy in admission chain. ([#123425](https://github.com/kubernetes/kubernetes/pull/123425), [@cici37](https://github.com/cici37))
- Added kubelet metrics to track the memory manager allocation and pinning. ([#121778](https://github.com/kubernetes/kubernetes/pull/121778), [@Tal-or](https://github.com/Tal-or))
- Added new flag, namely `custom`, in kubectl debug to let users customize pre-defined profiles. ([#120346](https://github.com/kubernetes/kubernetes/pull/120346), [@ardaguclu](https://github.com/ardaguclu))
- Added support for cloud provider integrations to supply optional, per-Node custom labels that will be
  applied to Nodes by the node controller.
  Extra labels will only be applied where the cloud provider integration implements this. ([#123223](https://github.com/kubernetes/kubernetes/pull/123223), [@mmerkes](https://github.com/mmerkes)) [SIG Cloud Provider]
- Allowed scheduling framework plugins that implement `io.Closer` to be gracefully closed. ([#122498](https://github.com/kubernetes/kubernetes/pull/122498), [@Gekko0114](https://github.com/Gekko0114))
- Bumped cAdvisor to v0.49.0. ([#123599](https://github.com/kubernetes/kubernetes/pull/123599), [@bobbypage](https://github.com/bobbypage))
- Changed `--nodeport-addresses` behavior to default to "primary node IP(s) only" rather than "all node IPs". ([#122724](https://github.com/kubernetes/kubernetes/pull/122724), [@nayihz](https://github.com/nayihz))
- Embedded Node information into Pod-bound service account tokens as additional metadata.
  Set the 'JTI' field in issued service account tokens, and embed this information as `authentication.kubernetes.io/credential-id` in user's ExtraInfo. ([#123135](https://github.com/kubernetes/kubernetes/pull/123135), [@munnerz](https://github.com/munnerz))
- Etcd: built image for `v3.5.11`. ([#122233](https://github.com/kubernetes/kubernetes/pull/122233), [@mzaian](https://github.com/mzaian))
- Feature gates for RemoteCommand (kubectl exec, cp, and attach) over WebSockets are now enabled by default (Beta).
  - Server-side feature gate: `TranslateStreamCloseWebsocketRequests`
  - Client-side (kubectl) feature gate: `KUBECTL_REMOTE_COMMAND_WEBSOCKETS`
  - To turn off RemoteCommand over WebSockets for kubectl, the environment variable feature gate must be explicitly set `KUBECTL_REMOTE_COMMAND_WEBSOCKETS=false`. ([#123281](https://github.com/kubernetes/kubernetes/pull/123281), [@seans3](https://github.com/seans3))
- Graduated "Forensic Container Checkpointing" (KEP #2008) from Alpha to Beta. ([#123215](https://github.com/kubernetes/kubernetes/pull/123215), [@adrianreber](https://github.com/adrianreber))
- Graduated HorizontalPodAutoscaler support for per-container metrics to stable. ([#123482](https://github.com/kubernetes/kubernetes/pull/123482), [@sanposhiho](https://github.com/sanposhiho)) [SIG API Machinery, Apps and Autoscaling]
- Graduated support for passing dual-stack `kubelet --node-ip` values when using
  a cloud provider. The feature is now GA and the `CloudDualStackNodeIPs` feature
  gate is always enabled. ([#123134](https://github.com/kubernetes/kubernetes/pull/123134), [@danwinship](https://github.com/danwinship)) [SIG API Machinery, Cloud Provider and Node]
- In the Pod API, setting the alpha `procMount` field to `Unmasked` in a container now requires setting `spec.hostUsers=false` as well. ([#123520](https://github.com/kubernetes/kubernetes/pull/123520), [@haircommander](https://github.com/haircommander)) [SIG Apps, Auth and Testing]
- Informers now support adding Indexers after the informer starts. ([#117046](https://github.com/kubernetes/kubernetes/pull/117046), [@howardjohn](https://github.com/howardjohn))
- Introduced a feature gate mechanism to `client-go`. Depending on the actual implementation, users can control features via environmental variables or command line options. ([#122555](https://github.com/kubernetes/kubernetes/pull/122555), [@p0lyn0mial](https://github.com/p0lyn0mial))
- It is possible to configure the IDs that the Kubelet uses to create user namespaces.
  
  
  User namespaces support is a Beta feature now. ([#123593](https://github.com/kubernetes/kubernetes/pull/123593), [@giuseppe](https://github.com/giuseppe)) [SIG Node]
- Kube-apiserver now reloads the `--authorization-config` file when it changes. Reloads increment the `apiserver_authorization_config_controller_automatic_reload_last_timestamp_seconds` timestamp metric, with `status="success"` for successful reloads and `status="failed"` for failed reloads. Failed reloads keep using the previously loaded authorization configuration. ([#121946](https://github.com/kubernetes/kubernetes/pull/121946), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver now reports latency metric for JWT authenticator authenticate token decisions in the `apiserver_authentication_jwt_authenticator_latency_seconds` metric, labeled by jwtIssuer hash and result. ([#123225](https://github.com/kubernetes/kubernetes/pull/123225), [@aramase](https://github.com/aramase)) [SIG API Machinery and Auth]
- Kube-apiserver now reports metrics for authorization decisions in the `apiserver_authorization_decisions_total` metric, labeled by authorizer type, name, and decision. ([#123333](https://github.com/kubernetes/kubernetes/pull/123333), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver now reports the following metrics for authorization webhook match conditions:
  - `apiserver_authorization_match_condition_evaluation_errors_total` counter metric labeled by authorizer type and name
  - `apiserver_authorization_match_condition_exclusions_total` counter metric labeled by authorizer type and name
  - `apiserver_authorization_match_condition_evaluation_seconds` histogram metric labeled by authorizer type and name ([#123611](https://github.com/kubernetes/kubernetes/pull/123611), [@ritazh](https://github.com/ritazh)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver: Authorization webhooks now report the following metrics:
  - apiserver_authorization_webhook_evaluations_total
  - apiserver_authorization_webhook_duration_seconds
  - apiserver_authorization_webhook_evaluations_fail_open_total ([#123639](https://github.com/kubernetes/kubernetes/pull/123639), [@liggitt](https://github.com/liggitt)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver: JWT authenticator now report the following metrics:
  - apiserver_authentication_config_controller_automatic_reloads_total
  - apiserver_authentication_config_controller_automatic_reload_last_timestamp_seconds ([#123793](https://github.com/kubernetes/kubernetes/pull/123793), [@aramase](https://github.com/aramase)) [SIG API Machinery, Auth and Testing]
- Kube-apiserver: the StructuredAuthorizationConfiguration feature gate was promoted to beta and now allows using the `--authorization-configuration` flag. ([#123641](https://github.com/kubernetes/kubernetes/pull/123641), [@liggitt](https://github.com/liggitt))
- Kube-controller-manager: increased the global level for broadcaster's logging to 3 so that users can ignore event messages by lowering the logging level. It reduces information noise. ([#122293](https://github.com/kubernetes/kubernetes/pull/122293), [@mengjiao-liu](https://github.com/mengjiao-liu))
- Kube-scheduler implemented scheduling hints for the `NodeAffinity` plugin. The scheduling hints allowed the scheduler to only retry scheduling a Pod that had been previously rejected by the `NodeAffinity` plugin if a new Node or a Node update matched the Pod's node affinity. ([#122309](https://github.com/kubernetes/kubernetes/pull/122309), [@carlory](https://github.com/carlory))
- Kube-scheduler implemented scheduling hints for the `NodeResourceFit` plugin. The scheduling hints allowed the scheduler to only retry scheduling a Pod that had been previously rejected by the `NodeResourceFit` plugin if a new Node or a Node update matched the Pod's resource requirements or if an old pod update or delete matched the Pod's resource requirements. ([#119177](https://github.com/kubernetes/kubernetes/pull/119177), [@carlory](https://github.com/carlory))
- Kube-scheduler implemented scheduling hints for the `NodeUnschedulable` plugin. The scheduling hints allowed the scheduler to only retry scheduling a Pod that had been previously rejected by the NodeSchedulable plugin if a new Node or a Node update had set `.spec.unschedulable` to false. ([#122334](https://github.com/kubernetes/kubernetes/pull/122334), [@carlory](https://github.com/carlory))
- Kube-scheduler implemented scheduling hints for the `PodTopologySpread` plugin. The scheduling hints allow the scheduler to retry scheduling a Pod that had been previously rejected by the `PodTopologySpread` plugin if a related Pod was created/deleted/updated or if a node matched the `topologyKey`. ([#122195](https://github.com/kubernetes/kubernetes/pull/122195), [@nayihz](https://github.com/nayihz))
- Kubeadm: added better handling of errors during unmount when calling "kubeadm reset". When failing to unmount directories under "/var/run/kubelet", kubeadm will now throw an error instead of showing a warning and continuing to cleanup said directory. In such situations it is better for you to inspect the problem and resolve it manually, then you can call "kubeadm reset" again to complete the cleanup. ([#122530](https://github.com/kubernetes/kubernetes/pull/122530), [@neolit123](https://github.com/neolit123))
- Kubeadm: added support for machine readable output with "-o yaml" and "-o json" to the command "kubeadm certs check-expiration". This change is added in a new API "kind": "CertificateExpirationInfo",  "apiVersion": "output.kubeadm.k8s.io/v1alpha3". The existing non structured formatting is preserved. The output API version v1alpha2 is now deprecated and will be removed in a future release. Please migrate to using v1alpha3. ([#123372](https://github.com/kubernetes/kubernetes/pull/123372), [@carlory](https://github.com/carlory))
- Kubeadm: added the WaitForAllControlPlaneComponents feature gate. It can be used to tell kubeadm to wait for all control plane components to be ready when running "kubeadm init" or "kubeadm join --control-plane". Currently kubeadm only waits for the kube-apiserver. The "kubeadm join" workflow now includes a new experimental phase called "wait-control-plane". This phase will be marked as non-experimental when WaitForAllControlPlaneComponents becomes GA. Accordingly a "kubeadm init" phase "wait-control-plane" will also be available once WaitForAllControlPlaneComponents becomes GA. These phases can be skipped if the user prefers to not wait for the control plane components. ([#123341](https://github.com/kubernetes/kubernetes/pull/123341), [@neolit123](https://github.com/neolit123))
- Kubeadm: printed all the kubelets and nodes that need to be upgraded on "upgrade plan". ([#123578](https://github.com/kubernetes/kubernetes/pull/123578), [@carlory](https://github.com/carlory))
- Kubectl debug: added sysadmin profile. ([#119200](https://github.com/kubernetes/kubernetes/pull/119200), [@eiffel-fl](https://github.com/eiffel-fl))
- Kubectl port-forward over websockets (tunneling SPDY) can be enabled using an `Alpha` feature flag environment variable: KUBECTL_PORT_FORWARD_WEBSOCKETS=true. The API Server being communicated to must *also* have an `Alpha` feature flag enabled: PortForwardWebsockets. ([#123413](https://github.com/kubernetes/kubernetes/pull/123413), [@seans3](https://github.com/seans3)) [SIG API Machinery, CLI, Node and Testing]
- Kubernetes is now built with Go `1.21.6`. ([#122705](https://github.com/kubernetes/kubernetes/pull/122705), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with Go `1.22`. ([#123217](https://github.com/kubernetes/kubernetes/pull/123217), [@cpanato](https://github.com/cpanato))
- Kubernetes is now built with go 1.22.1 ([#123750](https://github.com/kubernetes/kubernetes/pull/123750), [@cpanato](https://github.com/cpanato)) [SIG Release and Testing]
- Kubernetes is now built with go `1.22rc2`. ([#122889](https://github.com/kubernetes/kubernetes/pull/122889), [@cpanato](https://github.com/cpanato))
- LoadBalancerIPMode feature is now marked as Beta. ([#123418](https://github.com/kubernetes/kubernetes/pull/123418), [@rikatz](https://github.com/rikatz))
- New alpha feature gate `SELinuxMount` can be used to speed up SELinux relabeling of volumes. ([#123157](https://github.com/kubernetes/kubernetes/pull/123157), [@jsafrane](https://github.com/jsafrane)) [SIG Node and Storage]
- Node podresources API now includes init containers with containerRestartPolicy of `Always` when `SidecarContainers` feature is enabled. ([#120718](https://github.com/kubernetes/kubernetes/pull/120718), [@gjkim42](https://github.com/gjkim42)) [SIG Node and Testing]
- Printed more information when kubectl describe a `VolumeAttributesClass`. ([#122640](https://github.com/kubernetes/kubernetes/pull/122640), [@carlory](https://github.com/carlory))
- Promoted ImageMaximumGCAge feature to beta. ([#123424](https://github.com/kubernetes/kubernetes/pull/123424), [@haircommander](https://github.com/haircommander))
- Promoted `KubeProxyDrainingTerminatingNodes` to `Beta`. ([#122914](https://github.com/kubernetes/kubernetes/pull/122914), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Promoted feature gate `StableLoadBalancerNodeSet` to `GA` . ([#122961](https://github.com/kubernetes/kubernetes/pull/122961), [@alexanderConstantinescu](https://github.com/alexanderConstantinescu))
- Promoted the NodeLogQuery feature to beta. There have been no functional changes from alpha. ([#123205](https://github.com/kubernetes/kubernetes/pull/123205), [@aravindhp](https://github.com/aravindhp))
- Promoted the `CRDValidationRatcheting` feature gate to beta, and made it enabled by default. ([#121461](https://github.com/kubernetes/kubernetes/pull/121461), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery and Testing]
- Promoted the `status.hostIPs` field for Pods to general availability.
  The `PodHostIPs` feature gate no longer has any effect, and the
  `status.hostIPs` field is always available within the Pod API. ([#122870](https://github.com/kubernetes/kubernetes/pull/122870), [@wzshiming](https://github.com/wzshiming)) [SIG Apps, Network, Node and Testing]
- Revised node selection based on container image location.
  The kube-scheduler now considers whether nodes have the images available for init containers, and
  for sidecar containers if the cluster has `SidecarContainers` enabled. ([#123366](https://github.com/kubernetes/kubernetes/pull/123366), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]
- Scheduler extender `ignorable` option now handles errors for both filter and bind phases. ([#122503](https://github.com/kubernetes/kubernetes/pull/122503), [@sunbinnnnn](https://github.com/sunbinnnnn))
- Scheduler skips `NodeAffinity Score` plugin when `NodeAffinity Score` plugin has nothing to do with a Pod. You might notice an increase in the metric `plugin_execution_duration_seconds` for `extension_point=score` `plugin=NodeAffinity`, because the plugin will only run when the plugin is relevant. ([#117024](https://github.com/kubernetes/kubernetes/pull/117024), [@sanposhiho](https://github.com/sanposhiho))
- Some interfaces' signatures in the scheduler were updated: 
  - PluginsRunner: used NodeInfo in `RunPreScorePlugins` and `RunScorePlugins`. 
  - PreScorePlugin: used NodeInfo in `PreScore`. 
  - Extender: used NodeInfo in `Filter` and `Prioritize`. ([#121954](https://github.com/kubernetes/kubernetes/pull/121954), [@AxeZhan](https://github.com/AxeZhan))
- Targeted drop-in kubelet configuration dir feature to Beta. ([#122907](https://github.com/kubernetes/kubernetes/pull/122907), [@sohankunkerkar](https://github.com/sohankunkerkar))
- The Kubelet rejects creating the pod if hostUserns=false and the CRI runtime does not support user namespaces. ([#123216](https://github.com/kubernetes/kubernetes/pull/123216), [@giuseppe](https://github.com/giuseppe)) [SIG Node]
- The PriorityLevelConfiguration object now allows a zero value for the `nominalConcurrencyShares` field in both the `flowcontrol.apiserver.k8s.io/v1` and `flowcontrol.apiserver.k8s.io/v1beta3` APIs. ([#123001](https://github.com/kubernetes/kubernetes/pull/123001), [@tkashem](https://github.com/tkashem))
- The `apiserver.latency.k8s.io/decode-response-object` annotation was added to the audit log to record the decoding time. ([#121512](https://github.com/kubernetes/kubernetes/pull/121512), [@HirazawaUi](https://github.com/HirazawaUi))
- The scheduler retries Pods, which are failed by nodevolumelimits due to not found PVCs, only when new PVCs are added. ([#121952](https://github.com/kubernetes/kubernetes/pull/121952), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling and Storage]
- The watch cache now waits until it is at least as fresh as given requestedWatchRV if sendInitialEvents was requested. ([#122830](https://github.com/kubernetes/kubernetes/pull/122830), [@p0lyn0mial](https://github.com/p0lyn0mial))
- Updated ImageGCMaxAge behavior in the kubelet to wait the MaxAge duration after the kubelet has restarted before garbage collecting ([#123343](https://github.com/kubernetes/kubernetes/pull/123343), [@haircommander](https://github.com/haircommander))
- Updated `distroless-iptables` to `v0.5.0`, debian-base to `bookworm-v1.0.1` and setcap to `bookworm-v1.0.1`. ([#123170](https://github.com/kubernetes/kubernetes/pull/123170), [@cpanato](https://github.com/cpanato))
- Updated `kubedns` and `nodelocaldns` to release version `1.22.28`. ([#121908](https://github.com/kubernetes/kubernetes/pull/121908), [@mzaian](https://github.com/mzaian))
- Users can traverse all the pods that are in the scheduler and waiting in the permit stage through method `IterateOverWaitingPods`. In other words,  all waitingPods in scheduler can be obtained from any profiles. Before this commit, each profile could only obtain waitingPods within that profile. ([#122946](https://github.com/kubernetes/kubernetes/pull/122946), [@NoicFank](https://github.com/NoicFank)) [SIG Scheduling]
- ValidatingAdmissionPolicy now exclude TokenReview, SelfSubjectReview, LocalSubjectAccessReview, and SubjectAccessReview from all versions of authentication.k8s.io and authorization.k8s.io group. ([#123543](https://github.com/kubernetes/kubernetes/pull/123543), [@jiahuif](https://github.com/jiahuif)) [SIG API Machinery and Testing]
- When PreFilterResult filters out some Nodes, the scheduling framework assumes them as rejected via `UnschedulableAndUnresolvable`, 
  that is those nodes won't be in the candidates of preemption process.
  Also, corrected how the scheduling framework handle Unschedulable status from PreFilter. 
  Before this PR, if PreFilter return `Unschedulable`, it may result in an unexpected abortion in the preemption, 
  which shouldn't happen in the default scheduler, but may happen in schedulers with a custom plugin. ([#119779](https://github.com/kubernetes/kubernetes/pull/119779), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- When the RetryGenerateName feature gate is enabled on the kube-apiserver,
  create requests using generateName are retried automatically by the apiserver when the generated name conflicts with an existing resource name, up to a max limit of 7 retries.
  This feature is in alpha. ([#122887](https://github.com/kubernetes/kubernetes/pull/122887), [@jpbetz](https://github.com/jpbetz)) [SIG API Machinery]
- `NewVolumeManagerReconstruction` feature is now GA. ([#123442](https://github.com/kubernetes/kubernetes/pull/123442), [@jsafrane](https://github.com/jsafrane))
- `ValidatingAdmissionPolicy` now supports type checking policies that make use of `variables`. ([#123083](https://github.com/kubernetes/kubernetes/pull/123083), [@jiahuif](https://github.com/jiahuif))
- `kubectl describe`: added Suspend to job, and Node-Selectors and Tolerations to pod template output. ([#122618](https://github.com/kubernetes/kubernetes/pull/122618), [@ivanvc](https://github.com/ivanvc))
- `kubectl get job` now displays the status for the listed jobs. ([#123226](https://github.com/kubernetes/kubernetes/pull/123226), [@ivanvc](https://github.com/ivanvc)) [SIG Apps and CLI]

### Documentation

- A deprecated flag `--pod-max-in-unschedulable-pods-duration` was initially planned to be removed in v1.26, but we have to change this plan. We found [an issue](https://github.com/kubernetes/kubernetes/issues/110175) in which Pods can be stuck in the unschedulable pod pool for 5 min, and using this flag is the only workaround for this issue. 
  This issue only could happen if you use custom plugins or if you change plugin set being used in your scheduler via the scheduler config. ([#122013](https://github.com/kubernetes/kubernetes/pull/122013), [@sanposhiho](https://github.com/sanposhiho)) [SIG Scheduling]
- Added a new internal metric `kubelet_first_network_pod_start_sli_duration_second` in the kubelet that allow developers to understand the source of the latency problems on node startups. ([#121720](https://github.com/kubernetes/kubernetes/pull/121720), [@aojea](https://github.com/aojea))
- Modified the error message of `unmanagedFatal` to enhance clarity while preserving grammatical consistency with `unmanagedWarning`. This improvement ensures a more understandable prompt for users. ([#120159](https://github.com/kubernetes/kubernetes/pull/120159), [@Ithrael](https://github.com/Ithrael))

### Failing Test

- Revert "support sharing waitingPods across different scheduler profiles" ([#124001](https://github.com/kubernetes/kubernetes/pull/124001), [@kerthcet](https://github.com/kerthcet)) [SIG Scheduling]

### Bug or Regression

- Added `imagefs.inodesfree` to default `EvictionHard` settings. ([#121834](https://github.com/kubernetes/kubernetes/pull/121834), [@vaibhav2107](https://github.com/vaibhav2107))
- Added metric name along with the utilization information when running `kubectl get hpa`. ([#122804](https://github.com/kubernetes/kubernetes/pull/122804), [@sreeram-venkitesh](https://github.com/sreeram-venkitesh))
- Adds the namespace when using 'kubectl logs <pod-name>' and the pod is not found. Previously the message returned would be 'Error from server (NotFound): pods "my-pod-name" not found'. This has been updated to reflect the namespace in the message as follows: 'Error from server (NotFound): pods "my-pod-name" not found in namespace "default"' ([#120111](https://github.com/kubernetes/kubernetes/pull/120111), [@newtondev](https://github.com/newtondev)) [SIG CLI]
- Allowed deletion of pods that use raw block volumes on node reboot. ([#122211](https://github.com/kubernetes/kubernetes/pull/122211), [@gnufied](https://github.com/gnufied))
- An issue where `AvailableBytes` sometimes did not report correctly on WindowsNodes when `PodAndContainerStatsFromCRI` feature was enabled has been fixed. ([#122846](https://github.com/kubernetes/kubernetes/pull/122846), [@marosset](https://github.com/marosset))
- Changed the API server so that for admission webhooks that have a URL matching the hostname `localhost`, or a loopback IP address, the connection supports HTTP/2 where it can be negotiated. ([#122558](https://github.com/kubernetes/kubernetes/pull/122558), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery and Testing]
- Currently, NodeAdded QueueingHint could not always be called because of the internal feature called preCheck.
  It's definitely not something expected for plugin developers,
  and we're trying to eventually remove preCheck completely to fix this.
  Until then we'll register UpdateNodeTaint event for plugins that have NodeAdded event, but don't have UpdateNodeTaint event.
  It'd result in a bad impact on the requeuing efficiency though, a lot better than some Pods being stuck in the
  unschedulable pod pool. ([#122292](https://github.com/kubernetes/kubernetes/pull/122292), [@sanposhiho](https://github.com/sanposhiho)) [SIG Node, Scheduling, Storage and Testing]
- DRA: ResourceClaim and PodSchedulingContext status updates no longer allow changing object meta data. ([#123730](https://github.com/kubernetes/kubernetes/pull/123730), [@pohly](https://github.com/pohly)) [SIG Node]
- DRA: fixed potential data race with no known real-world implications. ([#123222](https://github.com/kubernetes/kubernetes/pull/123222), [@pohly](https://github.com/pohly)) [SIG Node]
- Etcd: Updated to `v3.5.11`. ([#122393](https://github.com/kubernetes/kubernetes/pull/122393), [@mzaian](https://github.com/mzaian))
- Fix enabling consistent list from watch cache also works for resourceVersion=0 ([#123676](https://github.com/kubernetes/kubernetes/pull/123676), [@serathius](https://github.com/serathius)) [SIG API Machinery]
- Fixed 1.29.0+ regression in migration of in-tree vSphere volumes to the CSI driver. ([#122341](https://github.com/kubernetes/kubernetes/pull/122341), [@jsafrane](https://github.com/jsafrane)) [SIG Storage]
- Fixed CEL estimated cost to for expressions that perform operations on the result of `map()` operations, (e.g. `.map(...).exists(...)` ) to have the correct estimated instead of an unbounded cost. ([#123562](https://github.com/kubernetes/kubernetes/pull/123562), [@jpbetz](https://github.com/jpbetz))
- Fixed Pod stuck in `Terminating` because of `GenerateUnmapVolumeFunc` missing `globalUnmapPath` when kubelet tries to clean up all volumes that failed reconstruction. ([#123032](https://github.com/kubernetes/kubernetes/pull/123032), [@carlory](https://github.com/carlory))
- Fixed Windows credential provider, cannot find binary. Windows credential provider binary path may have ".exe" suffix so it is better to use `LookPath()` to support it flexibly. ([#120291](https://github.com/kubernetes/kubernetes/pull/120291), [@lzhecheng](https://github.com/lzhecheng))
- Fixed `kubectl explain` to show enum for field types if they were defined. ([#123023](https://github.com/kubernetes/kubernetes/pull/123023), [@ah8ad3](https://github.com/ah8ad3))
- Fixed a bug in `ValidatingAdmissionPolicy` that caused policies which were using CRD parameters to fail to synchronize. ([#123003](https://github.com/kubernetes/kubernetes/pull/123003), [@alexzielenski](https://github.com/alexzielenski))
- Fixed a bug that an init container with containerRestartPolicy with `Always` cannot update its state from terminated to non-terminated for the pod with restartPolicy with `Never` or `OnFailure`. ([#123323](https://github.com/kubernetes/kubernetes/pull/123323), [@gjkim42](https://github.com/gjkim42)) [SIG Apps and Node]
- Fixed a bug where `kubectl` drain would consider a pod as having been deleted if an error occurs while calling the API. ([#122574](https://github.com/kubernetes/kubernetes/pull/122574), [@brianpursley](https://github.com/brianpursley))
- Fixed a race condition in the iptables mode of kube-proxy in `1.27` and later
  that could result in some updates getting lost (e.g., when a service gets a
  new endpoint, the rules for the new endpoint might not be added until
  much later). ([#122204](https://github.com/kubernetes/kubernetes/pull/122204), [@danwinship](https://github.com/danwinship))
- Fixed a regression since `1.24` in the scheduling framework when 
  overriding MultiPoint plugins (e.g. default plugins).
  The incorrect loop logic might lead to a plugin being loaded multiple times,
  consequently preventing any Pod from being scheduled, which is unexpected. ([#122068](https://github.com/kubernetes/kubernetes/pull/122068), [@caohe](https://github.com/caohe))
- Fixed an error when trying to expand a volume that does not require node expansion. ([#123055](https://github.com/kubernetes/kubernetes/pull/123055), [@gnufied](https://github.com/gnufied))
- Fixed an issue calculating total CPU usage reported for Windows nodes. ([#122999](https://github.com/kubernetes/kubernetes/pull/122999), [@marosset](https://github.com/marosset))
- Fixed an issue to ignore unnecessary node events and improve daemonset controller performance. ([#121669](https://github.com/kubernetes/kubernetes/pull/121669), [@xigang](https://github.com/xigang))
- Fixed an issue where a JWT authenticator configured via `--authentication-config` would fail to verify tokens that were not signed using RS256. ([#123282](https://github.com/kubernetes/kubernetes/pull/123282), [@enj](https://github.com/enj))
- Fixed an issue where mount point may become local without calling `NodePublishVolume` after node rebooting. ([#119923](https://github.com/kubernetes/kubernetes/pull/119923), [@cvvz](https://github.com/cvvz))
- Fixed an issue where the `configmap`, `secret`, `projected`, and `downwardAPI` volume types didn't create user-visible files after a kubelet restart. This fix ensures data persistence and accessibility after restarts.
   ([#122807](https://github.com/kubernetes/kubernetes/pull/122807), [@carlory](https://github.com/carlory))
- Fixed bug where health check could pass while APIServices are missing from aggregated discovery. ([#122883](https://github.com/kubernetes/kubernetes/pull/122883), [@Jefftree](https://github.com/Jefftree))
- Fixed bug where providing a FieldPath to a CRD Validation Rule would erroneously affect the reported field path of other unrelated CRD Validation Rules on the same schema. ([#123475](https://github.com/kubernetes/kubernetes/pull/123475), [@alexzielenski](https://github.com/alexzielenski))
- Fixed cleanup of Pod volume mounts when a file was used as a subpath. ([#123052](https://github.com/kubernetes/kubernetes/pull/123052), [@jsafrane](https://github.com/jsafrane)) [SIG Node]
- Fixed deprecated version for `pod_scheduling_duration_seconds` that caused the metric to be hidden by default in `1.29`. ([#123038](https://github.com/kubernetes/kubernetes/pull/123038), [@alculquicondor](https://github.com/alculquicondor))
- Fixed incorrect syncCronJob error logging. ([#122493](https://github.com/kubernetes/kubernetes/pull/122493), [@mengjiao-liu](https://github.com/mengjiao-liu)) [SIG Apps]
- Fixed node lifecycle controller panic when conditionType ready is been patch `nil` by mistake. ([#122874](https://github.com/kubernetes/kubernetes/pull/122874), [@fusida](https://github.com/fusida))
- Fixed non-recursive list returning "resource version too high" error when consistent list from cache is enabled. ([#123674](https://github.com/kubernetes/kubernetes/pull/123674), [@serathius](https://github.com/serathius))
- Fixed panic of Evented PLEG during kubelet start-up. ([#122475](https://github.com/kubernetes/kubernetes/pull/122475), [@pacoxu](https://github.com/pacoxu))
- Fixed resource deletion failure caused by quota calculation error when `InPlacePodVerticalScaling` is turned on. ([#122701](https://github.com/kubernetes/kubernetes/pull/122701), [@carlory](https://github.com/carlory))
- Fixed the disruption controller's PDB status synchronization to maintain all PDB conditions during an update. ([#122056](https://github.com/kubernetes/kubernetes/pull/122056), [@dhenkel92](https://github.com/dhenkel92)) [SIG Apps]
- Fixes a 1.26.0+ regression in kube-proxy to make externalIPs work with externalTrafficPolicy: Local ([#121919](https://github.com/kubernetes/kubernetes/pull/121919), [@uablrek](https://github.com/uablrek)) [SIG Network]
- Fixes a 1.27.0+ regression in kubeadm: do not upload kubelet patch configuration into `kube-system/kubelet-config` ConfigMap ([#123093](https://github.com/kubernetes/kubernetes/pull/123093), [@SataQiu](https://github.com/SataQiu)) [SIG Cluster Lifecycle]
- Fixes a 1.29.0 regression in kubectl that did not honor the --attach flag. ([#122447](https://github.com/kubernetes/kubernetes/pull/122447), [@ardaguclu](https://github.com/ardaguclu)) [SIG CLI]
- For statically provisioned PVs, if its volume source is CSI type or it has migrated annotation, when it's deleted, the PersisentVolume controller won't change its phase to the Failed state. With this patch, the external provisioner can remove the finalizer in the next reconcile loop. Unfortunately, if the previous existing pv has the Failed state, this patch won't take effort. It requires users to remove finalizer. ([#122030](https://github.com/kubernetes/kubernetes/pull/122030), [@carlory](https://github.com/carlory))
- Improved scheduler performance when no scoring plugins are defined. ([#122058](https://github.com/kubernetes/kubernetes/pull/122058), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Improved scheduler performance when no scoring plugins are defined. ([#122435](https://github.com/kubernetes/kubernetes/pull/122435), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- Improved scheduler performance when no scoring plugins are defined. ([#123384](https://github.com/kubernetes/kubernetes/pull/123384), [@aleksandra-malinowska](https://github.com/aleksandra-malinowska))
- JWTs used in service account and OIDC authentication are now strictly parsed to confirm that they use compact serialization.  Other encodings were not previously accepted, but would result in different unspecific errors. ([#123540](https://github.com/kubernetes/kubernetes/pull/123540), [@enj](https://github.com/enj)) [SIG API Machinery and Auth]
- Kube-apiserver: fixes a 1.27+ regression in watch stability by serving watch requests without a resourceVersion from the watch cache by default, as in <1.27 (disabling the change in #115096 by default). This mitigates the impact of an etcd watch bug (https://github.com/etcd-io/etcd/pull/17555). If the 1.27 change in #115096 to serve these requests from underlying storage is still desired despite the impact on watch stability, it can be re-enabled with a `WatchFromStorageWithoutResourceVersion` feature gate. ([#123935](https://github.com/kubernetes/kubernetes/pull/123935), [@serathius](https://github.com/serathius)) [SIG API Machinery and Etcd]
- Kube-proxy: fixed `LoadBalancerSourceRanges` not working for `nftables` mode. ([#122614](https://github.com/kubernetes/kubernetes/pull/122614), [@tnqn](https://github.com/tnqn))
- Kubeadm: avoided uploading a defaulted flag value "--authorization-mode=Node,RBAC" for the kube-apiserver in the ClusterConfiguration stored in the "kube-system/kubeadm-config" ConfigMap. "Node,RBAC" are already the kubeadm defaults for this flag, so this action is redundant. ([#123555](https://github.com/kubernetes/kubernetes/pull/123555), [@neolit123](https://github.com/neolit123))
- Kubeadm: fixed a bug during kubeadm upgrade, where it is not possible to mount a new device and create a symbolic link for /etc/kubernetes (or a sub-directory) so that kubeadm stores its information on the mounted device. ([#123406](https://github.com/kubernetes/kubernetes/pull/123406), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: fixed a bug where "kubeadm upgrade plan -o yaml|json" includes unneeded output and was missing component config information. ([#123492](https://github.com/kubernetes/kubernetes/pull/123492), [@carlory](https://github.com/carlory))
- Kubeadm: fixed a bug where the --rootfs global flag does not work with "kubeadm upgrade node" for control plane nodes. ([#123077](https://github.com/kubernetes/kubernetes/pull/123077), [@neolit123](https://github.com/neolit123))
- Kubeadm: fixed a regression in "kubeadm init" that caused a user-specified --kubeconfig file to be ignored. ([#122735](https://github.com/kubernetes/kubernetes/pull/122735), [@avorima](https://github.com/avorima))
- Kubeadm: in the new output API "output.kubeadm.k8s.io/v1alpha3" modified the UpgradePlan structure that is used when calling "kubeadm upgrade plan ... -o yaml|json", to include a list of multiple available upgrades. ([#123461](https://github.com/kubernetes/kubernetes/pull/123461), [@carlory](https://github.com/carlory))
- Kubeadm: the `kubelet-finalize` phase of `kubeadm init` no longer requires the kubelet kubeconfig to have a specific authinfo. ([#123171](https://github.com/kubernetes/kubernetes/pull/123171), [@vrutkovs](https://github.com/vrutkovs))
- Made decoding etcd's response respect the timeout context. ([#121815](https://github.com/kubernetes/kubernetes/pull/121815), [@HirazawaUi](https://github.com/HirazawaUi))
- OpenAPI V2 will no longer publish aggregated apiserver OpenAPI for group-versions not matching the APIService specified group version. ([#123570](https://github.com/kubernetes/kubernetes/pull/123570), [@Jefftree](https://github.com/Jefftree))
- Patched a leak of a discovery document that would occur when an Aggregated APIService changed its Spec.Service field and did not change it back. ([#123517](https://github.com/kubernetes/kubernetes/pull/123517), [@Jefftree](https://github.com/Jefftree))
- Prevented watch cache starvation by moving its watch to separate RPC. Added a SeparateCacheWatchRPC feature flag to disable this behavior. ([#123532](https://github.com/kubernetes/kubernetes/pull/123532), [@serathius](https://github.com/serathius))
- Previously, the scheduling queue didn't notice any extenders' failures, potentially resulting in missed cluster events and Pods rejected by Extenders being stuck in the unschedulable pod pool for up to 5 minutes in the worst-case scenario. Now, the scheduling queue notices extenders' failures and requeues Pods rejected by Extenders appropriately. ([#122022](https://github.com/kubernetes/kubernetes/pull/122022), [@sanposhiho](https://github.com/sanposhiho))
- QueueingHint implementation for `NodeAffinity` was reverted because we found potential scenarios where events that make Pods schedulable could be missed. ([#122285](https://github.com/kubernetes/kubernetes/pull/122285), [@sanposhiho](https://github.com/sanposhiho))
- Removed wrong warning event `FileSystemResizeFailed` during a pod creation if it uses a readonly volume and the capacity of the volume is greater or equal to its request storage. ([#122508](https://github.com/kubernetes/kubernetes/pull/122508), [@carlory](https://github.com/carlory))
- Restored --verify-only function in code generation wrappers. ([#123261](https://github.com/kubernetes/kubernetes/pull/123261), [@skitt](https://github.com/skitt))
- Reverted the `EventedPLEG` feature (beta, but disabled by default) back to alpha for a known issue. ([#122697](https://github.com/kubernetes/kubernetes/pull/122697), [@pacoxu](https://github.com/pacoxu))
- Sample-apiserver manifest example now has correct RBAC. ([#123479](https://github.com/kubernetes/kubernetes/pull/123479), [@Jefftree](https://github.com/Jefftree))
- The initialization of nodes using external cloud-providers now waits for the providerID value to be available before declaring the node ready. This is required because previously, if there were errors of communication with the cloud-provider on the cloud-controller-manager, nodes may have been declared Ready without having this field or the zone labels, and the information was never reconciled. The providerID and the zone labels are required for integrations like loadbalancers to work correctly. Users still can opt-out to this new behavior by setting the feature flag OptionalProviderID in the cloud-controller-manager. ([#123331](https://github.com/kubernetes/kubernetes/pull/123331), [@aojea](https://github.com/aojea)) [SIG API Machinery, Cloud Provider and Testing]
- The initialization of nodes using external cloud-providers now waits for the providerID value to be available before untainting it. This is required because , if there are communication errors with the cloud-provider on the cloud-controller-manager, nodes may have been declared Ready without having this field or the zone labels, and this information was never reconciled. The providerID and the zone labels are required for integrations like loadbalancers to work correctly. Cloud providers that does not implement the `GetInstanceProviderID` method will not require the providerID to be set and will not fail to initialize the node for backward compatibility issues. ([#123713](https://github.com/kubernetes/kubernetes/pull/123713), [@aojea](https://github.com/aojea)) [SIG Cloud Provider]
- The persistentvolume controller no longer automatically assigns a default `StorageClass` to PVCs (Persistent Volume Claims) with an empty `storageClassName`. ([#122704](https://github.com/kubernetes/kubernetes/pull/122704), [@carlory](https://github.com/carlory))
- Updated google.golang.org/protobuf to v1.33.0 to resolve CVE-2024-24786. ([#123758](https://github.com/kubernetes/kubernetes/pull/123758), [@liggitt](https://github.com/liggitt))
- Used `errors.Is()` to handle err returned by `LookPath()`. ([#122600](https://github.com/kubernetes/kubernetes/pull/122600), [@lzhecheng](https://github.com/lzhecheng))
- When using a claim with immediate allocation and a pod referencing that claim couldn't get scheduled, the scheduler incorrectly may have tried to deallocate that claim. ([#122415](https://github.com/kubernetes/kubernetes/pull/122415), [@pohly](https://github.com/pohly)) [SIG Node and Scheduling]
- [kubeadam][structured authz] avoided setting default `--authorization-mode` when `--authorization-config` is provided ([#123654](https://github.com/kubernetes/kubernetes/pull/123654), [@LiorLieberman](https://github.com/LiorLieberman))
- `QueueingHint` implementation for `NodeUnschedulable` is reverted because we found potential scenarios where events that make Pods schedulable could be missed. ([#122288](https://github.com/kubernetes/kubernetes/pull/122288), [@sanposhiho](https://github.com/sanposhiho))
- `ValidateVolumeAttributesClassUpdate` also validates new VolumeAttributesClass object. ([#122449](https://github.com/kubernetes/kubernetes/pull/122449), [@carlory](https://github.com/carlory))

### Other (Cleanup or Flake)

- Accepted zero as a default value for kubectl create token duration. ([#123565](https://github.com/kubernetes/kubernetes/pull/123565), [@ah8ad3](https://github.com/ah8ad3))
- Added an optimization to reduce stack memory usage for watch requests. It can be disabled with the feature gate: `APIServingWithRoutine=false` ([#120902](https://github.com/kubernetes/kubernetes/pull/120902), [@linxiulei](https://github.com/linxiulei))
- Added warning for `PV` on reclaim policy when it is `Recycle` . ([#122339](https://github.com/kubernetes/kubernetes/pull/122339), [@carlory](https://github.com/carlory))
- Cleanup: removed `getStorageAccountName` warning messages. ([#121983](https://github.com/kubernetes/kubernetes/pull/121983), [@andyzhangx](https://github.com/andyzhangx))
- Client-go: Optimized leaders renewing leases by updating leader lock optimistically without getting the record from the apiserver first. Also added a new metric `leader_election_slowpath_total` that allow users to monitor how many leader elections are updated non-optimistically. ([#122069](https://github.com/kubernetes/kubernetes/pull/122069), [@linxiulei](https://github.com/linxiulei)) [SIG API Machinery, Architecture and Instrumentation]
- Etcd image `v3.5.12` has been built. ([#123069](https://github.com/kubernetes/kubernetes/pull/123069), [@bzsuni](https://github.com/bzsuni))
- Fixed a bug where registered wildcard cluster event sources didn't work in scheduler requeueing. ([#123117](https://github.com/kubernetes/kubernetes/pull/123117), [@kerthcet](https://github.com/kerthcet))
- Kubeadm: improved the overall logic, error handling and output messages when waiting for the kubelet and API server /healthz endpoints to return `OK`. The kubelet and API server checks no longer run in parallel, but one after another(in serial). ([#121958](https://github.com/kubernetes/kubernetes/pull/121958), [@neolit123](https://github.com/neolit123))
- Kubeadm: made sure that a variety of API server requests are retried during "init", "join", "upgrade", "reset" workflows. Prior to this change some API server requests, such as, creating or updating ConfigMaps were "one-shot" - i.e. they could fail if the API server dropped connectivity for a very short period of time. ([#123271](https://github.com/kubernetes/kubernetes/pull/123271), [@neolit123](https://github.com/neolit123))
- Kubeadm: the `bridge-nf-call-iptables=1` and `bridge-nf-call-ip6tables=1` preflight checks are removed since not all the network implementations require this setting, network plugins are responsible for setting this correctly depending on whether or not they connect containers to Linux bridges or use some other mechanism. ([#123464](https://github.com/kubernetes/kubernetes/pull/123464), [@SataQiu](https://github.com/SataQiu))
- Kubeadm: used `ttlSecondsAfterFinished` to automatically clean up the `upgrade-health-check` Job that runs during upgrade preflighting. ([#122079](https://github.com/kubernetes/kubernetes/pull/122079), [@carlory](https://github.com/carlory))
- Locked GA feature-gate `ConsistentHTTPGetHandlers` to default. ([#122578](https://github.com/kubernetes/kubernetes/pull/122578), [@carlory](https://github.com/carlory))
- Migrated `client-go/metadata` to contextual logging. ([#122225](https://github.com/kubernetes/kubernetes/pull/122225), [@ricardoapl](https://github.com/ricardoapl))
- Migrated the kube-proxy to use [contextual logging](https://k8s.io/docs/concepts/cluster-administration/system-logs/#contextual-logging). ([#122197](https://github.com/kubernetes/kubernetes/pull/122197), [@fatsheep9146](https://github.com/fatsheep9146))
- Promoted feature-gate `LegacyServiceAccountTokenCleanUp` to GA and locked it to default. ([#122635](https://github.com/kubernetes/kubernetes/pull/122635), [@carlory](https://github.com/carlory))
- Removed GA feature gate `RemoveSelfLink`. ([#122468](https://github.com/kubernetes/kubernetes/pull/122468), [@carlory](https://github.com/carlory))
- Removed GA featuregate about `ExperimentalHostUserNamespaceDefaultingGate` in `1.30`. ([#122088](https://github.com/kubernetes/kubernetes/pull/122088), [@bzsuni](https://github.com/bzsuni))
- Removed GA featuregate about `IPTablesOwnershipCleanup` in `1.30`. ([#122137](https://github.com/kubernetes/kubernetes/pull/122137), [@bzsuni](https://github.com/bzsuni))
- Removed generally available feature gate `ExpandedDNSConfig`. ([#122086](https://github.com/kubernetes/kubernetes/pull/122086), [@bzsuni](https://github.com/bzsuni)) [SIG Network]
- Removed generally available feature gate `KubeletPodResourcesGetAllocatable`. ([#122138](https://github.com/kubernetes/kubernetes/pull/122138), [@ii2day](https://github.com/ii2day)) [SIG Node]
- Removed generally available feature gate `KubeletPodResources`. ([#122139](https://github.com/kubernetes/kubernetes/pull/122139), [@bzsuni](https://github.com/bzsuni)) [SIG Node]
- Removed generally available feature gate `MinimizeIPTablesRestore`. ([#122136](https://github.com/kubernetes/kubernetes/pull/122136), [@ty-dc](https://github.com/ty-dc)) [SIG Network]
- Removed generally available feature gate `ProxyTerminatingEndpoints`. ([#122134](https://github.com/kubernetes/kubernetes/pull/122134), [@ty-dc](https://github.com/ty-dc)) [SIG Network]
- Removed the deprecated `azureFile` in-tree storage plugin. ([#122576](https://github.com/kubernetes/kubernetes/pull/122576), [@carlory](https://github.com/carlory))
- Setting `--cidr-allocator-type` to `CloudAllocator` for `kube-controller-manager` will be removed in a future release. Please switch to and explore the options available in your external cloud provider. ([#123011](https://github.com/kubernetes/kubernetes/pull/123011), [@dims](https://github.com/dims))
- The GA feature-gate `APISelfSubjectReview` is removed, and the feature is unconditionally enabled. ([#122032](https://github.com/kubernetes/kubernetes/pull/122032), [@carlory](https://github.com/carlory))
- The feature gate `LegacyServiceAccountTokenTracking` (GA since 1.28) is now removed, since the feature is unconditionally enabled. ([#122409](https://github.com/kubernetes/kubernetes/pull/122409), [@Rei1010](https://github.com/Rei1010)) [SIG Auth]
- The in-tree cloud provider for Azure has now been removed. Please use the external cloud provider and CSI driver from https://github.com/kubernetes/cloud-provider-azure instead. ([#122857](https://github.com/kubernetes/kubernetes/pull/122857), [@nilo19](https://github.com/nilo19))
- The in-tree cloud provider for vSphere has now been removed. Please use the external cloud provider and CSI driver from https://github.com/kubernetes/cloud-provider-vsphere instead. ([#122937](https://github.com/kubernetes/kubernetes/pull/122937), [@dims](https://github.com/dims)) [SIG API Machinery, Cloud Provider, Storage and Testing]
- Updated `etcd` to version `3.5.12`. ([#123150](https://github.com/kubernetes/kubernetes/pull/123150), [@bzsuni](https://github.com/bzsuni))
- Updated `kube-dns` to `v1.22.27`. ([#121736](https://github.com/kubernetes/kubernetes/pull/121736), [@ty-dc](https://github.com/ty-dc))
- Updated cni-plugins to `v1.4.0`. ([#122178](https://github.com/kubernetes/kubernetes/pull/122178), [@saschagrunert](https://github.com/saschagrunert))
- Updated cri-tools to `v1.29.0`. ([#122271](https://github.com/kubernetes/kubernetes/pull/122271), [@saschagrunert](https://github.com/saschagrunert))
- Updated kubedns and nodelocaldns to v1.23.0. ([#123310](https://github.com/kubernetes/kubernetes/pull/123310), [@bzsuni](https://github.com/bzsuni))
- Upgraded metrics server to v0.7.0. ([#123504](https://github.com/kubernetes/kubernetes/pull/123504), [@pacoxu](https://github.com/pacoxu))
- `kube-proxy` nftables mode is now compatible with kernel `5.4`. ([#122296](https://github.com/kubernetes/kubernetes/pull/122296), [@tnqn](https://github.com/tnqn))
- `kubeadm completion` error message now displays supported shell types when an invalid shell was specified. ([#122477](https://github.com/kubernetes/kubernetes/pull/122477), [@SataQiu](https://github.com/SataQiu))

### Uncategorized

- Fixed an issue where kubectl apply could panic when imported as a library. ([#122346](https://github.com/kubernetes/kubernetes/pull/122346), [@Jefftree](https://github.com/Jefftree))