# Supported Platforms

A Kubernetes release consists of a set of Go binaries for various Operating Systems and CPU architectures. Platforms are identified using the Go `<GOOS>-<GOARCH>` parlance.

## Released Binaries

Kubernetes currently releases binaries for the following components on the listed platforms:

|   Component / Platform  | darwin-amd64 | linux-386 | linux-amd64 | linux-arm | linux-arm64 | linux-ppc64le | linux-s390x | windows-386 | windows-amd64 |
|:-----------------------:|:------------:|:---------:|:-----------:|:---------:|:-----------:|:-------------:|:-----------:|:-----------:|:-------------:|
| apiextensions-apiserver |              |           |      X      |     X     |      X      |       X       |      X      |             |               |
|     kube-aggregator     |              |           |      X      |     X     |      X      |       X       |      X      |             |               |
|      kube-apiserver     |              |           |      X      |     X     |      X      |       X       |      X      |             |               |
| kube-controller-manager |              |           |      X      |     X     |      X      |       X       |      X      |             |               |
|        kube-proxy       |              |           |      X      |     X     |      X      |       X       |      X      |             |       X       |
|      kube-scheduler     |              |           |      X      |     X     |      X      |       X       |      X      |             |               |
|         kubeadm         |              |           |      X      |     X     |      X      |       X       |      X      |             |       X       |
|         kubectl         |       X      |     X     |      X      |     X     |      X      |       X       |      X      |      X      |       X       |
|         kubelet         |              |           |      X      |     X     |      X      |       X       |      X      |             |       X       |
|         mounter         |              |           |      X      |     X     |      X      |       X       |      X      |             |               |
