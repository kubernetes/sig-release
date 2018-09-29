# Release Blocking Jobs

Here is a list of jobs that should block release if not healthy.

If you want to add a release-branch job, please add them to sig-release-x.x-all dashboard first,
and show the test is not flaky, then the release team can decide if the test should be added
to release-blocking dashboard as well.

<!-- TODO(krzyzacy): define blocking criteria -->

<!-- TODO(krzyzacy): use master-blocking dashboard, once we sort out jobs like scalability -->

We use [1.12 release-blocking dashboard](http://k8s-testgrid.appspot.com/sig-release-1.12-blocking)
as a source of truth:

* Make & Unit & Integration
  - build
  - verify
  - integration
  - bazel-build
  - bazel-test
* GCE
  - gce-cos-default
  - gce-cos-serial
  - gce-cos-slow
  - gce-cos-ingress
  - gce-cos-reboot
  - gce-cos-alphafeatures
  - gce-cos-conformance
  - gce-gpu-device-plugin
  - gce-scalability
* GKE
  - gke-cos-default
  - gke-cos-serial
  - gke-cos-slow
  - gke-cos-ingress
  - gke-cos-reboot
  - gke-gpu-device-plugin
  - gke-gpu-device-plugin-p100
* AWS
  - kops-aws
* Node
  - node-kubelet
* [Kubeadm](https://github.com/kubernetes/kubeadm/blob/master/docs/managing-e2e-tests.md)
  - kubeadm
  - kubeadm-$(X-1)-on-$(X)

## Testgrid Release Blocking Dashboards

[master blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)
[1.12 blocking](https://k8s-testgrid.appspot.com/sig-release-1.12-blocking)
[1.11 blocking](https://k8s-testgrid.appspot.com/sig-release-1.11-blocking)
[1.10 blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

<!--
The link map need to be updated every release
-->