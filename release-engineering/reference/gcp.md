# Google Cloud Platform

- [IAM](#iam)
- [Projects](#projects)
  - [Kubernetes Releases](#kubernetes-releases)
  - [Release Engineering](#release-engineering)
- [KMS](#kms)

## IAM

The following kubernetes.io Google Groups exist to grant Release Managers access to K8s Infra GCP resources.

Mail to the groups below will be ignored. Please instead use the [contact groups listed on the Release Managers page][release-managers].

- `k8s-infra-release-admins` - Release Engineering subproject owners
- `k8s-infra-release-editors` - Release Managers
- `k8s-infra-release-viewers` - Release Manager Associates

[Membership](https://git.k8s.io/k8s.io/groups/sig-release/groups.yaml) and [permissions](https://git.k8s.io/k8s.io/infra/gcp/bash/ensure-release-projects.sh) for each group are defined in [kubernetes/k8s.io](https://git.k8s.io/k8s.io).

## Projects

### Kubernetes Releases

| Name | Status | Tenancy | Ownership | Purpose |
|---|---|---|---|---|
| `k8s-release` | Active | Kubernetes | Release Engineering | Default project for `krel` staging and release Cloud Build jobs (K8s Infra) |
| `k8s-staging-kubernetes` | Active | Kubernetes | Release Engineering | Staging registry project for Kubernetes release images (K8s Infra) |
| `k8s-release-test-prod` | Active | Kubernetes | Release Engineering | Test production project for Kubernetes releases (K8s Infra) |
| `k8s-artifacts-prod` | Active | Kubernetes | SIG K8s Infra | Production project for Kubernetes Community artifacts (`registry.k8s.io`) (K8s Infra) |
| `kubernetes-release-test` | Legacy | Google | Release Engineering | Former staging project for Kubernetes releases; no longer used by `krel` |
| `google-containers` | Frozen | Google | Google | Former production project (`k8s.gcr.io`), frozen since 2023 |

### Release Engineering

| Name | Status | Tenancy | Ownership | Purpose |
|---|---|---|---|---|
| `k8s-infra-sig-release-prototype` | Deprecated | Kubernetes | Release Engineering | Test staging project for Release Engineering (K8s Infra) |
| `k8s-staging-release-test` | Deprecated | Kubernetes | Release Engineering | Test staging project for Release Engineering (K8s Infra) |
| `k8s-staging-releng` | Active | Kubernetes | Release Engineering | Staging project for Release Engineering tooling (K8s Infra) |
| `k8s-releng-prod` | Active | Kubernetes | Release Engineering | Production project for Release Engineering (K8s Infra) |
| `k8s-staging-releng-test` | Deprecated | Kubernetes | Release Engineering | Staging project for Release Engineering build images (K8s Infra) |

## KMS

Release Engineering GCP projects often require access to sensitive credentials to execute work.

An example is the `k8s-release-robot`'s GitHub token, used to commit, push, and create GitHub releases for `kubernetes/kubernetes`.

To facilitate this on K8s Infra, we use the `k8s-releng-prod` project to store KMS assets.

Decryption access to specific keyrings within the `k8s-releng-prod` project is then delegated out to the other Release Engineering GCP projects by members of the `k8s-infra-release-admins` group.

To date, the following projects have access to decrypt KMS assets:

- `k8s-staging-kubernetes`
- `k8s-staging-releng`

[release-managers]: https://github.com/kubernetes/website/blob/main/content/en/releases/release-managers.md
