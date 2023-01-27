## Changes by Kind

### API Change

- 'Added a `ResourceClaim` API (in the `resource.k8s.io/v1alpha1` API group and
  behind the `DynamicResourceAllocation` feature gate).
  The new API is now more flexible than the existing Device Plugins feature of Kubernetes because it
  allows Pods to request (claim) special kinds of resources, which can be available at node level, cluster
  level, or following any other model you implement.' ([#111023](https://github.com/kubernetes/kubernetes/pull/111023), [@pohly](https://github.com/pohly))
- 'Priority and Fairness has introduced a new feature called _borrowing_ that allows an API priority level
  to borrow a number of seats from other priority level(s). As a cluster operator, you can enable borrowing
  for a certain priority level configuration object via the two newly introduced fields `lendablePercent`, and
  `borrowingLimitPercent` located under the `.spec.limited` field of the designated priority level.
  This change added the following metrics:
  - `apiserver_flowcontrol_nominal_limit_seats`: Nominal number of execution seats configured for each priority level
  - `apiserver_flowcontrol_lower_limit_seats`: Configured lower bound on number of execution seats available to each priority level
  - `apiserver_flowcontrol_upper_limit_seats`: Configured upper bound on number of execution seats available to each priority level
  - `apiserver_flowcontrol_demand_seats`: Observations, at the end of every nanosecond, of (the number of seats each priority level could use) / (nominal number of seats for that level)
  - `apiserver_flowcontrol_demand_seats_high_watermark`: High watermark, over last adjustment period, of demand_seats
  - `apiserver_flowcontrol_demand_seats_average`: Time-weighted average, over last adjustment period, of demand_seats
  - `apiserver_flowcontrol_demand_seats_stdev`: Time-weighted standard deviation, over last adjustment period, of demand_seats
  - `apiserver_flowcontrol_demand_seats_smoothed`: Smoothed seat demands
  - `apiserver_flowcontrol_target_seats`: Seat allocation targets
  - `apiserver_flowcontrol_seat_fair_frac`: Fair fraction of server's concurrency to allocate to each priority level that can use it
  - `apiserver_flowcontrol_current_limit_seats`: current derived number of execution seats available to each priority level
  The possibility of borrowing means that the old metric `apiserver_flowcontrol_request_concurrency_limit` can no longer mean both the configured concurrency limit and the enforced concurrency limit. Henceforth it means the configured concurrency limit.' ([#113485](https://github.com/kubernetes/kubernetes/pull/113485), [@MikeSpreitzer](https://github.com/MikeSpreitzer))
- '`PodDisruptionBudget` now adds an alpha `spec.unhealthyPodEvictionPolicy` field.
  When the `PDBUnhealthyPodEvictionPolicy` feature-gate is enabled in `kube-apiserver`,
  setting this field to `"AlwaysAllow"` allows pods to be evicted if they do not
  have a ready condition, regardless of whether the PodDisruptionBudget is currently
  healthy.'
   ([#113375](https://github.com/kubernetes/kubernetes/pull/113375), [@atiratree](https://github.com/atiratree))
- Added a feature that allows a `StatefulSet` to start numbering replicas from an arbitrary non-negative ordinal, using the `.spec.ordinals.start` field. ([#112744](https://github.com/kubernetes/kubernetes/pull/112744), [@pwschuurman](https://github.com/pwschuurman))
- Added a new namespace alpha field to `DataSourceRef` field in `PersistentVolumeClaim` API. ([#113186](https://github.com/kubernetes/kubernetes/pull/113186), [@ttakahashi21](https://github.com/ttakahashi21))
- Aggregated discovery will be alpha and can be toggled with the `AggregatedDiscoveryEndpoint` feature flag. ([#113171](https://github.com/kubernetes/kubernetes/pull/113171), [@Jefftree](https://github.com/Jefftree))
- Enabled the "Retriable and non-retriable pod failures for jobs" feature into beta. ([#113360](https://github.com/kubernetes/kubernetes/pull/113360), [@mimowo](https://github.com/mimowo))

### Feature

- Promoted `kubectl alpha events` to `kubectl events`. ([#113819](https://github.com/kubernetes/kubernetes/pull/113819), [@soltysh](https://github.com/soltysh))
- Updated `cAdvisor` to `v0.46.0`. ([#113769](https://github.com/kubernetes/kubernetes/pull/113769), [@bobbypage](https://github.com/bobbypage))

### Bug or Regression

- Known issue: Job field `.spec.podFailurePolicy.rules[*].onExitCode` might be ignored if the Pod is deleted before it terminates. ([#113856](https://github.com/kubernetes/kubernetes/pull/113856), [@alculquicondor](https://github.com/alculquicondor))
- Kubelet: fixed nil pointer in reflector start for standalone mode. ([#113501](https://github.com/kubernetes/kubernetes/pull/113501), [@pacoxu](https://github.com/pacoxu))

### Other (Cleanup or Flake)

- '`kubelet_kubelet_credential_provider_plugin_duration` was renamed to `kubelet_credential_provider_plugin_duration`
  and `kubelet_kubelet_credential_provider_plugin_errors` was renamed to `kubelet_credential_provider_plugin_errors`.'
   ([#113754](https://github.com/kubernetes/kubernetes/pull/113754), [@logicalhan](https://github.com/logicalhan))
- Renamed the feature gate for CEL in Admission Control to `ValidatingAdmissionPolicy`. ([#113735](https://github.com/kubernetes/kubernetes/pull/113735), [@cici37](https://github.com/cici37))