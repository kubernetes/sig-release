# Upgrade Job Versions

An example of how, given an upgrade job, the different ways I can verify:
- what version is it upgrading FROM (**old-version**)
- what version is it upgrading TO (**new-version**)

## TL;DR
- there are [very few jobs](#jobs-that-do-use-release-builds) that actually use released/tagged builds
- most jobs use one of these versions, built off the HEAD of a branch

| name           | branch eg    | actual eg                           |
| -------------- | ------------ | ----------------------------------- |
| ci/latest      | master       | v1.13.0-alpha.0.1226+426ef9d349bb3a |
| ci/k8s-beta    | release-1.12 | v1.12.0-beta.1.129+1d58f1aebfe1e3   |
| ci/k8s-stable1 | release-1.11 | v1.11.3-beta.0.71+a4529464e4629c    |
| ci/k8s-stable2 | release-1.10 | v1.10.8-beta.0.33+a963fce72fed31    |
| ci/k8s-stable3 | release-1.9  | v1.9.11-beta.0.36+06bf888123ca89    |

NB: these examples are based on the current cycle at time of writing, which is release-1.12

### Option A: Look at the job name
aka trust the job

- upgrade-cluster: master + nodes upgraded to **new-version**, **old-version** tests run
- upgrade-cluster-new: master + nodes upgraded to **new-version**, **new-version** tests run
- upgrade-master: master upgraded to **new-version**, nodes left at **old-version**, **old-version** tests run

references:
- https://github.com/kubernetes/community/blob/master/contributors/devel/sig-testing/e2e-tests.md#test-jobs-naming-convention

### Option B: Look at the job arguments
aka trust the CI

- job config is output as first line of build log
- OR if you know the job name, you can search for it in kubernetes/test-infra
- look for the `--extract=` flags
- the version there corresponds to files in GCS buckets

ci/foo versions live in kubernetes-release-dev:
```shell
$ for suffix in beta stable1 stable2 stable3; do
  echo ci/k8s-$suffix: $(gsutil cat gs://kubernetes-release-dev/ci/k8s-$suffix.txt);
done

ci/k8s-beta: v1.12.0-beta.1.129+1d58f1aebfe1e3
ci/k8s-stable1: v1.11.3-beta.0.71+a4529464e4629c
ci/k8s-stable2: v1.10.8-beta.0.33+a963fce72fed31
ci/k8s-stable3: v1.9.11-beta.0.36+06bf888123ca89
```

release/foo versions live in kubernetes-release:
```shell
$ for prefix in latest stable; do
  echo release/$prefix-1.11: $(gsutil cat gs://kubernetes-release/release/$prefix-1.11.txt)
  done

release/latest-1.11: v1.11.4-beta.0
release/stable-1.11: v1.11.3
```
references:
- https://github.com/kubernetes/test-infra#release-branch-jobs--image-validation-jobs
- https://github.com/kubernetes/test-infra/tree/master/kubetest#extract-a-build
- https://github.com/kubernetes/test-infra/blob/master/kubetest/extract_k8s.go

### Option C: Look at the job's log
aka trust nothing

- look at the build log
- search for "kube-apiserver version:"
- if the version has an -alpha -beta or -rc suffix, it is a build, not a released version
- if there is a +, everything after the + is a commit sha
- you can use https://github.com/kubernetes/kubernetes/commit/`<commit sha>`
- everything displayed under the commit has made it into the build

### Known Issues

- the "version" displayed by Gubernator is the **old-version**
- the commit displayed by TestGrid is the **old-version**
- neither of these display the **new-version** (ref: [kubernetes/test-infra#3392](https://github.com/kubernetes/test-infra/issues/3392))

---

## Example

https://k8s-gubernator.appspot.com/build/kubernetes-jenkins/logs/ci-kubernetes-e2e-gce-new-master-upgrade-cluster-parallel/4843

### Option A: Look at the job name

- this is upgrading a new cluster to the HEAD of master
- **old-version** is `release-1.11` HEAD, **new-version** is `master` HEAD

### Option B: Look at the job arguments

- first line of build log has `--extract=ci/latest --extract=ci/k8s-stable1`
- **old-version** is `release-1.11` HEAD, **new-version** is `master` HEAD (as of the the time the job ran)

OR:

- search for the job https://github.com/kubernetes/test-infra/search?q=ci-kubernetes-e2e-gce-new-master-upgrade-cluster-parallel&unscoped_q=ci-kubernetes-e2e-gce-new-master-upgrade-cluster-parallel
- job is defined at https://github.com/kubernetes/test-infra/blob/3caafeffebfef243499a92c76cc5eea9e216f138/config/jobs/kubernetes/sig-cluster-lifecycle/k8s-upgrade-gce.yaml#L355
- relevant parameters are `- --extract=ci/latest - --extract=ci/k8s-stable1`
- **old-version** is `release-1.11` HEAD, **new-version** is `master` HEAD (as of the the time the job ran)

### Option C: Look at the job's log

- look at https://storage.googleapis.com/kubernetes-jenkins/logs/ci-kubernetes-e2e-gce-new-master-upgrade-cluster-parallel/4843/build-log.txt
- search for kube-apiserver-version
```
I0912 04:20:36.512] Sep 12 04:20:36.512: INFO: kube-apiserver version: v1.11.3-beta.0.71+a4529464e4629c
I0912 04:58:45.311] Sep 12 04:58:45.307: INFO: kube-apiserver version: v1.13.0-alpha.0.1226+426ef9d349bb3a
```
- **old-version** is v1.11.3-beta.0.71+a4529464e4629c
  - it has v1.11 in it, it is from somewhere on the release-1.11 branch
  - it has a -alpha or -beta suffix, it is not a tag or cut build
  - everything after the + is a commit sha https://github.com/kubernetes/kubernetes/commit/a4529464e4629c
  - everything under that commit has been included
- **new-version** is v1.13.0-alpha.0.1226+426ef9d349bb3a
  - it has v1.13 in it, it is from somewhere on the master branch
  - it has a -alpha or -beta suffix, it is not a tag or cut build
  - everything after the + is a commit sha https://github.com/kubernetes/kubernetes/commit/426ef9d349bb3a
  - everything under that commit has been included

---

## Jobs that do use release builds

- ci-kubernetes-gce-conformance-stable-1-y
- ci-kubernetes-e2e-kubeadm-gce-stable-on-master
- ci-kubernetes-e2e-kubeadm-gce-upgrade-stable-master

```shell
config/jobs/kubernetes/sig-gcp/gce-conformance.yaml
119:      - --extract=release/stable-1.9
140:      - --extract=release/stable-1.10
161:      - --extract=release/stable-1.11

config/jobs/kubernetes/sig-cluster-lifecycle/kubeadm-x-on-y.yaml
98:      - --extract=release/stable

config/jobs/kubernetes/sig-cluster-lifecycle/kubeadm-upgrade.yaml
115:      - --extract=release/stable
```

- ci-kubernetes-e2e-kubeadm-gce-upgrade-1-x-1-y

```shell
config/jobs/kubernetes/sig-cluster-lifecycle/kubeadm-upgrade.yaml
21:      - --extract=release/latest-1.10
32:      - --upgrade_args=--ginkgo.focus=\[Feature:MasterUpgrade\] --ginkgo.skip=statefulset-upgrade|hpa-upgrade|service-upgrade --upgrade-target=release/latest-1.10
52:      - --extract=release/latest-1.11
63:      - --upgrade_args=--ginkgo.focus=\[Feature:MasterUpgrade\] --ginkgo.skip=statefulset-upgrade|hpa-upgrade|service-upgrade --upgrade-target=release/latest-1.11
83:      - --extract=release/latest-1.12
94:      - --upgrade_args=--ginkgo.focus=\[Feature:MasterUpgrade\] --ginkgo.skip=statefulset-upgrade|hpa-upgrade|service-upgrade --upgrade-target=release/latest-1.9
```

---

## Known Issues

- https://github.com/kubernetes/test-infra/issues/3392 - testgrid only shows **old-version**'s sha, can it also show **new-version**'s sha?
