# What's New (Major Themes)

## PodIsolationPolicy over PodSecurityPolicy

PSP as an Admission controller resource is being deprecated. Deployed PodSecurityPolicy's will keep working until version 1.25, their target removal from the codebase. A new feature called PodIsolationPolicy is being developed in KEP-2579, to learn more read the featured blog [here](Link to the larger blog)

## Kubernetes API Reference Documentation

The API reference is now generated with [`gen-resourcesdocs`](https://github.com/kubernetes-sigs/reference-docs/tree/c96658d89fb21037b7d00d27e6dbbe6b32375837/gen-resourcesdocs) and it is moving to [Kubernetes API](https://kubernetes.io/docs/reference/kubernetes-api/)

## Kustomize Updates in Kubectl

## Default Container Labels

## Immutable Secrets and ConfigMaps

Immutable Secrets and ConfigMaps graduates to GA. This feature allows users to specify that the contents of a particular Secret or ConfigMap is immutable for its object lifetime. For such instances, Kubelet will not watch/poll for changes and therefore reducing apiserver load.

## Storage Capacity Tracking

Traditionally, the Kubernetes scheduler was based on the assumptions that additional persistent storage is available everywhere in the cluster and has infinite capacity. Topology constraints addressed the first point, but up to now pod scheduling was still done without considering that the remaining storage capacity may not be enough to start a new pod. [Storage capacity tracking](https://docs.k8s.io/concepts/storage/storage-capacity/) addresses that by adding an API for a CSI driver to report storage capacity and uses that information in the Kubernetes scheduler when choosing a node for a pod. This feature serves as a stepping stone for supporting dynamic provisioning for local volumes and other volume types that are more capacity constrained.

## Generic Ephemeral Volumes

[Generic ephermeral volumes](https://docs.k8s.io/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes) feature allows any existing storage driver that supports dynamic provisioning to be used as an ephemeral volume with the volume’s lifecycle bound to the Pod. It can be used to provide scratch storage that is different from the root disk, for example persistent memory, or a separate local disk on that node. All StorageClass parameters for volume provisioning are supported. All features supported with PersistentVolumeClaims are supported, such as storage capacity tracking, snapshots and restore, and volume resizing.

## CSI Service Account Token

CSI Service Account Token feature moves to Beta in 1.21. This feature improves the security posture and allows CSI drivers to receive pods' [bound service account tokens](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/1205-bound-service-account-tokens/README.md). This feature also provides a knob to re-publish volumes so that short-lived volumes can be refreshed.

## CSI Health Monitoring

The CSI health monitoring feature is being released as a second Alpha in Kubernetes 1.21. This feature enables CSI Drivers to share abnormal volume conditions from the underlying storage systems with Kubernetes so that they can be reported as events on PVCs or Pods. This feature serves as a stepping stone towards programmatic detection and resolution of individual volume health issues by Kubernetes.
