## Container Images

|                         | 386 | amd64 | arm64 | ppc64le | s390x |
| ----------------------- | :-: | :---: | :---: | :-----: | :---: |
| conformance             | ✅  |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-apiserver          | ✅  |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-controller-manager | ✅  |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-proxy              | ✅  |  ✅   |  ✅   |   ✅    |  ✅   |
| kube-scheduler          | ✅  |  ✅   |  ✅   |   ✅    |  ✅   |
| kubectl                 | ✅  |  ✅   |  ✅   |   ✅    |  ✅   |

## Storage

### Binaries

|                         | darwin/amd64                          | linux/386                             | linux/amd64                                                    | linux/arm64                                                    | linux/ppc64le                                                  | linux/s390x                                                    | windows/386                 | windows/amd64               |
| ----------------------- | ------------------------------------- | ------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------- | --------------------------- | --------------------------- |
| apiextensions-apiserver |                                       |                                       | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          |                             |                             |
| kube-apiserver          |                                       |                                       | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 |                             |                             |
| kube-controller-manager |                                       |                                       | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 |                             |                             |
| kube-proxy              |                                       |                                       | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 |                             | exe<br />sha256<br />sha512 |
| kube-scheduler          |                                       |                                       | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 | [binary_file]<br />docker_tag<br />tar<br />sha256<br />sha512 |                             |                             |
| kubeadm                 |                                       |                                       | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          |                             | exe<br />sha256<br />sha512 |
| kubectl                 | [binary_file]<br />sha256<br />sha512 | [binary_file]<br />sha256<br />sha512 | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | exe<br />sha256<br />sha512 | exe<br />sha256<br />sha512 |
| kubelet                 |                                       |                                       | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          |                             | exe<br />sha256<br />sha512 |
| mounter                 |                                       |                                       | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          | [binary_file]<br />sha256<br />sha512                          |                             |                             |

### Extra files (for GCE)

There are also corresponding `*.sha256` and `*.sha512` for every file below

| File                        |
| --------------------------- |
| configure.sh                |
| master.yaml                 |
| node.yaml                   |
| shutdown.sh                 |
| windows/common.psm1         |
| windows/configure.ps1       |
| windows/install-ssh.psm1    |
| windows/k8s-node-setup.psm1 |
| windows/user-profile.psm1   |

### Tar archives

There are also corresponding `*.sha256` and `*.sha512` for every file below

| File                                       | darwin/amd64 | linux/386 | linux/amd64 | linux/arm64 | linux/ppc64le | linux/s390x | windows/386 | windows/amd64 | portable |
| ------------------------------------------ | :----------: | :-------: | :---------: | :---------: | :-----------: | :---------: | :---------: | :-----------: | :------: |
| kubernetes-client-**[system-arch]**.tar.gz |      ✅      |    ✅     |     ✅      |     ✅      |      ✅       |     ✅      |     ✅      |      ✅       |          |
| kubernetes-node-**[system-arch]**.tar.gz   |              |           |     ✅      |     ✅      |      ✅       |     ✅      |             |      ✅       |          |
| kubernetes-server-**[system-arch]**.tar.gz |              |           |     ✅      |     ✅      |      ✅       |     ✅      |             |               |          |
| kubernetes-test-**[system-arch]**.tar.gz   |      ✅      |           |     ✅      |     ✅      |      ✅       |     ✅      |             |      ✅       |    ✅    |
| kubernetes-manifests.tar.gz                |              |           |             |             |               |             |             |               |          |
| kubernetes-test.tar.gz                     |              |           |             |             |               |             |             |               |          |
| kubernetes-src.tar.gz                      |              |           |             |             |               |             |             |               |          |
| kubernetes.tar.gz                          |              |           |             |             |               |             |             |               |          |

### Other (uncategorized) files

| File                    |
| ----------------------- |
| release/latest-1.16.txt |
| release/latest-1.txt    |
| release/latest.txt      |

Files in directory: **archive**

Comment: It looks like in the directory: **archive** we can find:

- copy of **anago** (script used for building artifacts)
- shallow copy of kubernetes repository

Staged files
It looks like all staged files were copied to release directory, but please be aware there was no effort taken to compare them.

## Packages

### RPMs

|                                                 | aarch64 | ppc64le | s390x | x86_64 |
| ----------------------------------------------- | :-----: | :-----: | :---: | :----: |
| cri-tools-**[k8s-version]**.**[arch]**.rpm      |   ✅    |   ✅    |  ✅   |   ✅   |
| kubectl-**[k8s-version]**.**[arch]**.rpm        |   ✅    |   ✅    |  ✅   |   ✅   |
| kubernetes-cni-**[cni-version]**.**[arch]**.rpm |   ✅    |   ✅    |  ✅   |   ✅   |
| kubeadm-**[k8s-version]**.**[arch]**.rpm        |   ✅    |   ✅    |  ✅   |   ✅   |
| kubelet-**[k8s-version]**.**[arch]**.rpm        |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/**[checksum]**-primary.sqlite.bz2      |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/**[checksum]**-filelists.sqlite.bz2    |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/**[checksum]**-primary.xml.gz          |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/**[checksum]**-other.sqlite.bz2        |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/**[checksum]**-other.xml.gz            |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/**[checksum]**-filelists.xml.gz        |   ✅    |   ✅    |  ✅   |   ✅   |
| repodata/repomd.xml                             |   ✅    |   ✅    |  ✅   |   ✅   |

### Debs

| File                                                      | amd64                                                                                                                                                                                                                                                                                                                                                                    | arm64                                                                                                                                                                                                                                                                                                                                                                    | ppc64el                                                                                                                                                                                                                                                                                                                                                                  | s390x                                                                                                                                                                                                                                                                                                                                                                    |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| cri-tools**\*[cri-tools-version]\*\*\***[arch]\*\*.deb    | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubeadm**\*[k8s-version]\*\*\***[arch]\*\*.deb            | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubectl**\*[k8s-version]\*\*\***[arch]\*\*.deb            | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubelet**\*[k8s-version]\*\*\***[arch]\*\*.deb            | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubernetes-cni**\*[k8s-cni-version]\*\*\***[arch]\*\*.deb | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |

### Contents of tar archives

All contents listed below are artifacts of the [v1.20.0 release](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#v1200).

##### Content of `kubernetes-client-[system-arch].tar.gz` on example of `kubernetes-client-linux-386.tar.gz` (directories removed from list):

*Summary*

- Binary for `kubectl`

<details><summary>Expand Contents</summary>
<p>

```
➜ $ tar -ztvf kubernetes-client-linux-386.tar.gz
-rwxr-xr-x root/root  35266560 2020-12-08 12:10 kubernetes/client/bin/kubectl
```

</p>
</details>

##### Content of `kubernetes-node-[system-arch].tar.gz` on example of `kubernetes-node-linux-amd64.tar.gz` (directories removed from list):

*Summary*

- Kubernetes source tarball
- Binaries for `kubectl` / `kubeadm` / `kube-proxy` / `kubelet`
- [LICENSES](https://github.com/kubernetes/kubernetes/tree/master/LICENSES)

<details><summary>Expand Contents</summary>
<p>

```
➜ $ tar -ztvf kubernetes-node-linux-amd64.tar.gz
-rw-r--r-- root/root  35790270 2020-12-08 12:11 kubernetes/kubernetes-src.tar.gz
-rwxr-xr-x root/root  40230912 2020-12-08 12:11 kubernetes/node/bin/kubectl
-rwxr-xr-x root/root  39219200 2020-12-08 12:11 kubernetes/node/bin/kubeadm
-rwxr-xr-x root/root  39485440 2020-12-08 12:11 kubernetes/node/bin/kube-proxy
-rwxr-xr-x root/root 113974120 2020-12-08 12:11 kubernetes/node/bin/kubelet
-rw-r--r-- root/root     11596 2020-12-08 12:11 kubernetes/LICENSES/LICENSE
-rw-r--r-- root/root        78 2020-12-08 12:11 kubernetes/LICENSES/OWNERS
-rw-r--r-- root/root     11492 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.mongodb.org/mongo-driver/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:11 kubernetes/LICENSES/vendor/google.golang.org/appengine/LICENSE
-rw-r--r-- root/root     11483 2020-12-08 12:11 kubernetes/LICENSES/vendor/google.golang.org/grpc/LICENSE
-rw-r--r-- root/root      1612 2020-12-08 12:11 kubernetes/LICENSES/vendor/google.golang.org/protobuf/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:11 kubernetes/LICENSES/vendor/google.golang.org/api/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:11 kubernetes/LICENSES/vendor/google.golang.org/genproto/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:11 kubernetes/LICENSES/vendor/bitbucket.org/bertimus9/systemstat/LICENSE
-rw-r--r-- root/root     11469 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.etcd.io/etcd/LICENSE
-rw-r--r-- root/root      1191 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.etcd.io/bbolt/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/oauth2/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/net/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/text/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/sys/LICENSE
-rw-r--r-- root/root      1596 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/tools/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/time/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/crypto/LICENSE
-rw-r--r-- root/root      1600 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/xerrors/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/mod/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:11 kubernetes/LICENSES/vendor/golang.org/x/sync/LICENSE
-rw-r--r-- root/root     11477 2020-12-08 12:11 kubernetes/LICENSES/vendor/cloud.google.com/go/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.uber.org/zap/LICENSE
-rw-r--r-- root/root      1192 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.uber.org/multierr/LICENSE
-rw-r--r-- root/root      1188 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.uber.org/atomic/LICENSE
-rw-r--r-- root/root      2670 2020-12-08 12:11 kubernetes/LICENSES/vendor/sigs.k8s.io/yaml/LICENSE
-rw-r--r-- root/root     11480 2020-12-08 12:11 kubernetes/LICENSES/vendor/sigs.k8s.io/kustomize/LICENSE
-rw-r--r-- root/root     11548 2020-12-08 12:11 kubernetes/LICENSES/vendor/sigs.k8s.io/apiserver-network-proxy/konnectivity-client/LICENSE
-rw-r--r-- root/root     11510 2020-12-08 12:11 kubernetes/LICENSES/vendor/sigs.k8s.io/structured-merge-diff/v4/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:11 kubernetes/LICENSES/vendor/go.opencensus.io/LICENSE
-rw-r--r-- root/root      1647 2020-12-08 12:11 kubernetes/LICENSES/vendor/gonum.org/v1/gonum/LICENSE
-rw-r--r-- root/root      1637 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/gcfg.v1/LICENSE
-rw-r--r-- root/root      1396 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/warnings.v0/LICENSE
-rw-r--r-- root/root      1222 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/natefinch/lumberjack.v2/LICENSE
-rw-r--r-- root/root      1721 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/tomb.v1/LICENSE
-rw-r--r-- root/root      1658 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/fsnotify.v1/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/square/go-jose.v2/LICENSE
-rw-r--r-- root/root     10364 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/ini.v1/LICENSE
-rw-r--r-- root/root      1635 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/inf.v0/LICENSE
-rw-r--r-- root/root      2264 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/yaml.v3/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:11 kubernetes/LICENSES/vendor/gopkg.in/yaml.v2/LICENSE
-rw-r--r-- root/root      1227 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/asaskevich/govalidator/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/go-grpc-prometheus/LICENSE
-rw-r--r-- root/root      1672 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/grpc-gateway/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/go-grpc-middleware/LICENSE
-rw-r--r-- root/root      2516 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/storageos/go-api/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/thecodeteam/goscaleio/LICENSE
-rw-r--r-- root/root      1212 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Microsoft/hcsshim/LICENSE
-rw-r--r-- root/root      1216 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Microsoft/go-winio/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/subosito/gotenv/LICENSE
-rw-r--r-- root/root      1190 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mailru/easyjson/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/cespare/xxhash/v2/LICENSE
-rw-r--r-- root/root      1213 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/satori/go.uuid/LICENSE
-rw-r--r-- root/root     11500 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/modern-go/concurrent/LICENSE
-rw-r--r-- root/root     11496 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/modern-go/reflect2/LICENSE
-rw-r--r-- root/root     11465 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/jonboulle/clockwork/LICENSE
-rw-r--r-- root/root     11501 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/pquerna/cachecontrol/LICENSE
-rw-r--r-- root/root       704 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/inconshreveable/mousetrap/LICENSE
-rw-r--r-- root/root     10894 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/docker/docker/LICENSE
-rw-r--r-- root/root     10900 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/docker/spdystream/LICENSE
-rw-r--r-- root/root     11466 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/docker/distribution/LICENSE
-rw-r--r-- root/root     10905 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/docker/go-connections/LICENSE
-rw-r--r-- root/root     10893 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/docker/go-units/LICENSE
-rw-r--r-- root/root      1613 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/golang/protobuf/LICENSE
-rw-r--r-- root/root     11483 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/golang/mock/LICENSE
-rw-r--r-- root/root     10410 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/golang/groupcache/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/morikuni/aec/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/swag/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/strfmt/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/jsonreference/LICENSE
-rw-r--r-- root/root     11497 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/runtime/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/spec/LICENSE
-rw-r--r-- root/root     11505 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/jsonpointer/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/loads/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/validate/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/errors/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-openapi/analysis/LICENSE
-rw-r--r-- root/root      1207 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/tmc/grpc-websocket-proxy/LICENSE
-rw-r--r-- root/root     11524 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/container-storage-interface/spec/LICENSE
-rw-r--r-- root/root      1212 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-stack/stack/LICENSE
-rw-r--r-- root/root      1201 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/peterbourgon/diskv/LICENSE
-rw-r--r-- root/root      1216 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/emicklei/go-restful/LICENSE
-rw-r--r-- root/root      1618 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/PuerkitoBio/urlesc/LICENSE
-rw-r--r-- root/root      1610 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/PuerkitoBio/purell/LICENSE
-rw-r--r-- root/root      1233 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mitchellh/go-wordwrap/LICENSE
-rw-r--r-- root/root      1232 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mitchellh/mapstructure/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/xiang90/probing/LICENSE
-rw-r--r-- root/root     10901 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/clusterhq/flocker-go/LICENSE
-rw-r--r-- root/root     11537 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/GoogleCloudPlatform/k8s-cloud-provider/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/aws/aws-sdk-go/LICENSE
-rw-r--r-- root/root      1217 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/robfig/cron/LICENSE
-rw-r--r-- root/root     11500 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/euank/go-kmsg-parser/LICENSE
-rw-r--r-- root/root      1211 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/rubiojr/go-vhd/LICENSE
-rw-r--r-- root/root      1514 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/seccomp/libseccomp-golang/LICENSE
-rw-r--r-- root/root      2682 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/ghodss/yaml/LICENSE
-rw-r--r-- root/root     11498 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/caddyserver/caddy/LICENSE
-rw-r--r-- root/root     10933 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/vishvananda/netns/LICENSE
-rw-r--r-- root/root     10937 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/vishvananda/netlink/LICENSE
-rw-r--r-- root/root      1679 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/fsnotify/fsnotify/LICENSE
-rw-r--r-- root/root      1236 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/shurcooL/sanitized_anchor_name/LICENSE
-rw-r--r-- root/root     11468 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mistifyio/go-zfs/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/sirupsen/logrus/LICENSE
-rw-r--r-- root/root      1616 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/liggitt/tabwriter/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/karrick/godirwalk/LICENSE
-rw-r--r-- root/root      1607 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/willf/bitset/LICENSE
-rw-r--r-- root/root      1608 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/google/go-cmp/LICENSE
-rw-r--r-- root/root      1605 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/google/uuid/LICENSE
-rw-r--r-- root/root     11485 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/google/btree/LICENSE
-rw-r--r-- root/root     10898 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/google/cadvisor/LICENSE
-rw-r--r-- root/root     11487 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/google/gofuzz/LICENSE
-rw-r--r-- root/root      1736 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/miekg/dns/LICENSE
-rw-r--r-- root/root     11504 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/opencontainers/selinux/LICENSE
-rw-r--r-- root/root     10899 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/opencontainers/runc/LICENSE
-rw-r--r-- root/root     10952 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/opencontainers/go-digest/LICENSE
-rw-r--r-- root/root     10920 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/opencontainers/image-spec/LICENSE
-rw-r--r-- root/root     10924 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/opencontainers/runtime-spec/LICENSE
-rw-r--r-- root/root     11512 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/coredns/corefile-migration/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/godbus/dbus/v5/LICENSE
-rw-r--r-- root/root     11456 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/coreos/go-oidc/LICENSE
-rw-r--r-- root/root     10410 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/coreos/go-systemd/LICENSE
-rw-r--r-- root/root     10414 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/coreos/go-systemd/v22/LICENSE
-rw-r--r-- root/root     11448 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/coreos/pkg/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/coreos/go-semver/LICENSE
-rw-r--r-- root/root      1193 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/dgrijalva/jwt-go/LICENSE
-rw-r--r-- root/root     10917 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/libopenstorage/openstorage/LICENSE
-rw-r--r-- root/root      1449 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/gorilla/websocket/LICENSE
-rw-r--r-- root/root      1563 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/russross/blackfriday/LICENSE
-rw-r--r-- root/root      1566 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/russross/blackfriday/v2/LICENSE
-rw-r--r-- root/root      1542 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/JeffAshton/win_pdh/LICENSE
-rw-r--r-- root/root      1640 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/chai2010/gettext-go/LICENSE
-rw-r--r-- root/root     11497 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/moby/sys/mountinfo/LICENSE
-rw-r--r-- root/root     10886 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/moby/term/LICENSE
-rw-r--r-- root/root     11446 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/moby/ipvs/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mindprince/gonvml/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/ishidawataru/sctp/LICENSE
-rw-r--r-- root/root     11518 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/checkpoint-restore/go-criu/v4/LICENSE
-rw-r--r-- root/root      1435 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/pkg/errors/LICENSE
-rw-r--r-- root/root     11484 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-logr/logr/LICENSE
-rw-r--r-- root/root      1230 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/blang/semver/LICENSE
-rw-r--r-- root/root     11534 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/matttproud/golang_protobuf_extensions/LICENSE
-rw-r--r-- root/root      1500 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/magiconair/properties/LICENSE
-rw-r--r-- root/root      1185 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/beorn7/perks/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/azure-sdk-for-go/LICENSE
-rw-r--r-- root/root     10904 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/LICENSE
-rw-r--r-- root/root     10911 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/logger/LICENSE
-rw-r--r-- root/root     10918 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/adal/LICENSE
-rw-r--r-- root/root     10916 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/to/LICENSE
-rw-r--r-- root/root     10913 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/LICENSE
-rw-r--r-- root/root     10919 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/mocks/LICENSE
-rw-r--r-- root/root     10918 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/date/LICENSE
-rw-r--r-- root/root     10924 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/validation/LICENSE
-rw-r--r-- root/root     10912 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/tracing/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/Azure/go-ansiterm/LICENSE
-rw-r--r-- root/root       314 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-bindata/go-bindata/LICENSE
-rw-r--r-- root/root      1201 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/form3tech-oss/jwt-go/LICENSE
-rw-r--r-- root/root       899 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/davecgh/go-spew/LICENSE
-rw-r--r-- root/root      1272 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/hpcloud/tail/LICENSE
-rw-r--r-- root/root      1205 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/json-iterator/go/LICENSE
-rw-r--r-- root/root      2737 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/daviddengcn/go-colortext/LICENSE
-rw-r--r-- root/root      1267 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/cilium/ebpf/LICENSE
-rw-r--r-- root/root      1620 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/elazarl/goproxy/LICENSE
-rw-r--r-- root/root      1230 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/MakeNowJust/heredoc/LICENSE
-rw-r--r-- root/root      1202 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/spf13/cast/LICENSE
-rw-r--r-- root/root     10269 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/spf13/afero/LICENSE
-rw-r--r-- root/root      1656 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/spf13/pflag/LICENSE
-rw-r--r-- root/root      1204 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/spf13/viper/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/spf13/jwalterweatherman/LICENSE
-rw-r--r-- root/root     10269 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/spf13/cobra/LICENSE
-rw-r--r-- root/root      1218 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/fvbommel/sortorder/LICENSE
-rw-r--r-- root/root      1613 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mvdan/xurls/LICENSE
-rw-r--r-- root/root      1698 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/cyphar/filepath-securejoin/LICENSE
-rw-r--r-- root/root      1634 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/evanphx/json-patch/LICENSE
-rw-r--r-- root/root      1614 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/quobyte/api/LICENSE
-rw-r--r-- root/root      1208 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/armon/circbuf/LICENSE
-rw-r--r-- root/root       721 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/NYTimes/gziphandler/LICENSE
-rw-r--r-- root/root     11498 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/googleapis/gnostic/LICENSE
-rw-r--r-- root/root      1614 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/googleapis/gax-go/v2/LICENSE
-rw-r--r-- root/root      1683 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/munnerz/goautoneg/LICENSE
-rw-r--r-- root/root      1227 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/exponent-io/jsonpath/LICENSE
-rw-r--r-- root/root      1202 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mohae/deepcopy/LICENSE
-rw-r--r-- root/root      1294 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/konsorten/go-windows-terminal-sequences/LICENSE
-rw-r--r-- root/root       702 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/jmespath/go-jmespath/LICENSE
-rw-r--r-- root/root      1242 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/pelletier/go-toml/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/onsi/gomega/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/onsi/ginkgo/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/cpuguy83/go-md2man/v2/LICENSE
-rw-r--r-- root/root      1665 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/imdario/mergo/LICENSE
-rw-r--r-- root/root       389 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/heketi/heketi/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/go-ozzo/ozzo-validation/LICENSE
-rw-r--r-- root/root      1238 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/stretchr/testify/LICENSE
-rw-r--r-- root/root      1246 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/stretchr/objx/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/fatih/camelcase/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/vmware/govmomi/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/syndtr/gocapability/LICENSE
-rw-r--r-- root/root     10895 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mrunalp/fileutils/LICENSE
-rw-r--r-- root/root     11487 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/soheilhy/cmux/LICENSE
-rw-r--r-- root/root      1275 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/dustin/go-humanize/LICENSE
-rw-r--r-- root/root     11507 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/containernetworking/cni/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/prometheus/common/LICENSE
-rw-r--r-- root/root     11506 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/prometheus/client_model/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/prometheus/procfs/LICENSE
-rw-r--r-- root/root     11508 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/prometheus/client_golang/LICENSE
-rw-r--r-- root/root     16106 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/hashicorp/hcl/LICENSE
-rw-r--r-- root/root     16064 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/hashicorp/golang-lru/LICENSE
-rw-r--r-- root/root      1584 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/pmezard/go-difflib/LICENSE
-rw-r--r-- root/root     11492 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/containerd/ttrpc/LICENSE
-rw-r--r-- root/root     10904 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/containerd/console/LICENSE
-rw-r--r-- root/root     11496 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/containerd/cgroups/LICENSE
-rw-r--r-- root/root     10910 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/containerd/containerd/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/gregjones/httpcache/LICENSE
-rw-r--r-- root/root      1647 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/mxk/go-flowrate/LICENSE
-rw-r--r-- root/root     10896 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/gophercloud/gophercloud/LICENSE
-rw-r--r-- root/root      1810 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/gogo/protobuf/LICENSE
-rw-r--r-- root/root      1217 2020-12-08 12:11 kubernetes/LICENSES/vendor/github.com/lithammer/dedent/LICENSE
-rw-r--r-- root/root     11435 2020-12-08 12:11 kubernetes/LICENSES/vendor/k8s.io/heapster/LICENSE
-rw-r--r-- root/root     11486 2020-12-08 12:11 kubernetes/LICENSES/vendor/k8s.io/system-validators/LICENSE
-rw-r--r-- root/root     11477 2020-12-08 12:11 kubernetes/LICENSES/vendor/k8s.io/kube-openapi/LICENSE
-rw-r--r-- root/root     11459 2020-12-08 12:11 kubernetes/LICENSES/vendor/k8s.io/gengo/LICENSE
-rw-r--r-- root/root     10382 2020-12-08 12:11 kubernetes/LICENSES/vendor/k8s.io/klog/v2/LICENSE
-rw-r--r-- root/root     11463 2020-12-08 12:11 kubernetes/LICENSES/vendor/k8s.io/utils/LICENSE
```

</p>
</details>

##### Content of `kubernetes-server-[system-arch].tar.gz` on example of `kubernetes-server-linux-amd64.tar.gz` (directories removed from list):

*Summary*

- Kubernetes source tarball (`kubernetes-src.tar.gz`)
- OCI image tarballs (`*.tar`) for `kube-proxy` / `kube-apiserver` / `kube-controller-manager` / `kube-scheduler`
- Docker tags (`*.docker_tag`) for `kube-proxy` / `kube-apiserver` / `kube-controller-manager` / `kube-scheduler`
- Binaries for `kube-proxy` / `kube-apiserver` / `kube-controller-manager` / `kube-scheduler` / `kubelet` / `kubeadm` / `mounter`
- [LICENSES](https://github.com/kubernetes/kubernetes/tree/master/LICENSES)

<details><summary>Expand Contents</summary>
<p>

```
➜ $ tar -ztvf kubernetes-server-linux-amd64.tar.gz
-rw-r--r-- root/root  35790270 2020-12-08 12:12 kubernetes/kubernetes-src.tar.gz
-rw------- root/root 120378880 2020-12-08 12:11 kubernetes/server/bin/kube-proxy.tar
-rwxr-xr-x root/root  46665728 2020-12-08 12:12 kubernetes/server/bin/apiextensions-apiserver
-rw------- root/root 122924544 2020-12-08 12:11 kubernetes/server/bin/kube-apiserver.tar
-rw-r--r-- root/root         8 2020-12-08 12:11 kubernetes/server/bin/kube-controller-manager.docker_tag
-rwxr-xr-x root/root  40230912 2020-12-08 12:12 kubernetes/server/bin/kubectl
-rw-r--r-- root/root         8 2020-12-08 12:11 kubernetes/server/bin/kube-scheduler.docker_tag
-rw-r--r-- root/root         8 2020-12-08 12:11 kubernetes/server/bin/kube-proxy.docker_tag
-rwxr-xr-x root/root  44658688 2020-12-08 12:12 kubernetes/server/bin/kube-aggregator
-rwxr-xr-x root/root   1630208 2020-12-08 12:12 kubernetes/server/bin/mounter
-rwxr-xr-x root/root  42848256 2020-12-08 12:12 kubernetes/server/bin/kube-scheduler
-rwxr-xr-x root/root 112308224 2020-12-08 12:12 kubernetes/server/bin/kube-controller-manager
-rwxr-xr-x root/root 118128640 2020-12-08 12:12 kubernetes/server/bin/kube-apiserver
-rw------- root/root  47644160 2020-12-08 12:11 kubernetes/server/bin/kube-scheduler.tar
-rwxr-xr-x root/root  39219200 2020-12-08 12:12 kubernetes/server/bin/kubeadm
-rwxr-xr-x root/root  39485440 2020-12-08 12:12 kubernetes/server/bin/kube-proxy
-rw-r--r-- root/root         8 2020-12-08 12:11 kubernetes/server/bin/kube-apiserver.docker_tag
-rwxr-xr-x root/root 113974120 2020-12-08 12:12 kubernetes/server/bin/kubelet
-rw------- root/root 117104128 2020-12-08 12:11 kubernetes/server/bin/kube-controller-manager.tar
-rw-r--r-- root/root     11596 2020-12-08 12:12 kubernetes/LICENSES/LICENSE
-rw-r--r-- root/root        78 2020-12-08 12:12 kubernetes/LICENSES/OWNERS
-rw-r--r-- root/root     11492 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.mongodb.org/mongo-driver/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:12 kubernetes/LICENSES/vendor/google.golang.org/appengine/LICENSE
-rw-r--r-- root/root     11483 2020-12-08 12:12 kubernetes/LICENSES/vendor/google.golang.org/grpc/LICENSE
-rw-r--r-- root/root      1612 2020-12-08 12:12 kubernetes/LICENSES/vendor/google.golang.org/protobuf/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:12 kubernetes/LICENSES/vendor/google.golang.org/api/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:12 kubernetes/LICENSES/vendor/google.golang.org/genproto/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:12 kubernetes/LICENSES/vendor/bitbucket.org/bertimus9/systemstat/LICENSE
-rw-r--r-- root/root     11469 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.etcd.io/etcd/LICENSE
-rw-r--r-- root/root      1191 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.etcd.io/bbolt/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/oauth2/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/net/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/text/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/sys/LICENSE
-rw-r--r-- root/root      1596 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/tools/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/time/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/crypto/LICENSE
-rw-r--r-- root/root      1600 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/xerrors/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/mod/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:12 kubernetes/LICENSES/vendor/golang.org/x/sync/LICENSE
-rw-r--r-- root/root     11477 2020-12-08 12:12 kubernetes/LICENSES/vendor/cloud.google.com/go/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.uber.org/zap/LICENSE
-rw-r--r-- root/root      1192 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.uber.org/multierr/LICENSE
-rw-r--r-- root/root      1188 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.uber.org/atomic/LICENSE
-rw-r--r-- root/root      2670 2020-12-08 12:12 kubernetes/LICENSES/vendor/sigs.k8s.io/yaml/LICENSE
-rw-r--r-- root/root     11480 2020-12-08 12:12 kubernetes/LICENSES/vendor/sigs.k8s.io/kustomize/LICENSE
-rw-r--r-- root/root     11548 2020-12-08 12:12 kubernetes/LICENSES/vendor/sigs.k8s.io/apiserver-network-proxy/konnectivity-client/LICENSE
-rw-r--r-- root/root     11510 2020-12-08 12:12 kubernetes/LICENSES/vendor/sigs.k8s.io/structured-merge-diff/v4/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:12 kubernetes/LICENSES/vendor/go.opencensus.io/LICENSE
-rw-r--r-- root/root      1647 2020-12-08 12:12 kubernetes/LICENSES/vendor/gonum.org/v1/gonum/LICENSE
-rw-r--r-- root/root      1637 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/gcfg.v1/LICENSE
-rw-r--r-- root/root      1396 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/warnings.v0/LICENSE
-rw-r--r-- root/root      1222 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/natefinch/lumberjack.v2/LICENSE
-rw-r--r-- root/root      1721 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/tomb.v1/LICENSE
-rw-r--r-- root/root      1658 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/fsnotify.v1/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/square/go-jose.v2/LICENSE
-rw-r--r-- root/root     10364 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/ini.v1/LICENSE
-rw-r--r-- root/root      1635 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/inf.v0/LICENSE
-rw-r--r-- root/root      2264 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/yaml.v3/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:12 kubernetes/LICENSES/vendor/gopkg.in/yaml.v2/LICENSE
-rw-r--r-- root/root      1227 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/asaskevich/govalidator/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/go-grpc-prometheus/LICENSE
-rw-r--r-- root/root      1672 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/grpc-gateway/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/go-grpc-middleware/LICENSE
-rw-r--r-- root/root      2516 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/storageos/go-api/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/thecodeteam/goscaleio/LICENSE
-rw-r--r-- root/root      1212 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Microsoft/hcsshim/LICENSE
-rw-r--r-- root/root      1216 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Microsoft/go-winio/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/subosito/gotenv/LICENSE
-rw-r--r-- root/root      1190 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mailru/easyjson/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/cespare/xxhash/v2/LICENSE
-rw-r--r-- root/root      1213 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/satori/go.uuid/LICENSE
-rw-r--r-- root/root     11500 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/modern-go/concurrent/LICENSE
-rw-r--r-- root/root     11496 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/modern-go/reflect2/LICENSE
-rw-r--r-- root/root     11465 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/jonboulle/clockwork/LICENSE
-rw-r--r-- root/root     11501 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/pquerna/cachecontrol/LICENSE
-rw-r--r-- root/root       704 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/inconshreveable/mousetrap/LICENSE
-rw-r--r-- root/root     10894 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/docker/docker/LICENSE
-rw-r--r-- root/root     10900 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/docker/spdystream/LICENSE
-rw-r--r-- root/root     11466 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/docker/distribution/LICENSE
-rw-r--r-- root/root     10905 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/docker/go-connections/LICENSE
-rw-r--r-- root/root     10893 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/docker/go-units/LICENSE
-rw-r--r-- root/root      1613 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/golang/protobuf/LICENSE
-rw-r--r-- root/root     11483 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/golang/mock/LICENSE
-rw-r--r-- root/root     10410 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/golang/groupcache/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/morikuni/aec/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/swag/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/strfmt/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/jsonreference/LICENSE
-rw-r--r-- root/root     11497 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/runtime/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/spec/LICENSE
-rw-r--r-- root/root     11505 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/jsonpointer/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/loads/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/validate/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/errors/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-openapi/analysis/LICENSE
-rw-r--r-- root/root      1207 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/tmc/grpc-websocket-proxy/LICENSE
-rw-r--r-- root/root     11524 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/container-storage-interface/spec/LICENSE
-rw-r--r-- root/root      1212 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-stack/stack/LICENSE
-rw-r--r-- root/root      1201 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/peterbourgon/diskv/LICENSE
-rw-r--r-- root/root      1216 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/emicklei/go-restful/LICENSE
-rw-r--r-- root/root      1618 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/PuerkitoBio/urlesc/LICENSE
-rw-r--r-- root/root      1610 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/PuerkitoBio/purell/LICENSE
-rw-r--r-- root/root      1233 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mitchellh/go-wordwrap/LICENSE
-rw-r--r-- root/root      1232 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mitchellh/mapstructure/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/xiang90/probing/LICENSE
-rw-r--r-- root/root     10901 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/clusterhq/flocker-go/LICENSE
-rw-r--r-- root/root     11537 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/GoogleCloudPlatform/k8s-cloud-provider/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/aws/aws-sdk-go/LICENSE
-rw-r--r-- root/root      1217 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/robfig/cron/LICENSE
-rw-r--r-- root/root     11500 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/euank/go-kmsg-parser/LICENSE
-rw-r--r-- root/root      1211 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/rubiojr/go-vhd/LICENSE
-rw-r--r-- root/root      1514 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/seccomp/libseccomp-golang/LICENSE
-rw-r--r-- root/root      2682 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/ghodss/yaml/LICENSE
-rw-r--r-- root/root     11498 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/caddyserver/caddy/LICENSE
-rw-r--r-- root/root     10933 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/vishvananda/netns/LICENSE
-rw-r--r-- root/root     10937 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/vishvananda/netlink/LICENSE
-rw-r--r-- root/root      1679 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/fsnotify/fsnotify/LICENSE
-rw-r--r-- root/root      1236 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/shurcooL/sanitized_anchor_name/LICENSE
-rw-r--r-- root/root     11468 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mistifyio/go-zfs/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/sirupsen/logrus/LICENSE
-rw-r--r-- root/root      1616 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/liggitt/tabwriter/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/karrick/godirwalk/LICENSE
-rw-r--r-- root/root      1607 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/willf/bitset/LICENSE
-rw-r--r-- root/root      1608 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/google/go-cmp/LICENSE
-rw-r--r-- root/root      1605 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/google/uuid/LICENSE
-rw-r--r-- root/root     11485 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/google/btree/LICENSE
-rw-r--r-- root/root     10898 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/google/cadvisor/LICENSE
-rw-r--r-- root/root     11487 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/google/gofuzz/LICENSE
-rw-r--r-- root/root      1736 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/miekg/dns/LICENSE
-rw-r--r-- root/root     11504 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/opencontainers/selinux/LICENSE
-rw-r--r-- root/root     10899 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/opencontainers/runc/LICENSE
-rw-r--r-- root/root     10952 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/opencontainers/go-digest/LICENSE
-rw-r--r-- root/root     10920 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/opencontainers/image-spec/LICENSE
-rw-r--r-- root/root     10924 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/opencontainers/runtime-spec/LICENSE
-rw-r--r-- root/root     11512 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/coredns/corefile-migration/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/godbus/dbus/v5/LICENSE
-rw-r--r-- root/root     11456 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/coreos/go-oidc/LICENSE
-rw-r--r-- root/root     10410 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/coreos/go-systemd/LICENSE
-rw-r--r-- root/root     10414 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/coreos/go-systemd/v22/LICENSE
-rw-r--r-- root/root     11448 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/coreos/pkg/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/coreos/go-semver/LICENSE
-rw-r--r-- root/root      1193 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/dgrijalva/jwt-go/LICENSE
-rw-r--r-- root/root     10917 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/libopenstorage/openstorage/LICENSE
-rw-r--r-- root/root      1449 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/gorilla/websocket/LICENSE
-rw-r--r-- root/root      1563 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/russross/blackfriday/LICENSE
-rw-r--r-- root/root      1566 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/russross/blackfriday/v2/LICENSE
-rw-r--r-- root/root      1542 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/JeffAshton/win_pdh/LICENSE
-rw-r--r-- root/root      1640 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/chai2010/gettext-go/LICENSE
-rw-r--r-- root/root     11497 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/moby/sys/mountinfo/LICENSE
-rw-r--r-- root/root     10886 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/moby/term/LICENSE
-rw-r--r-- root/root     11446 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/moby/ipvs/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mindprince/gonvml/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/ishidawataru/sctp/LICENSE
-rw-r--r-- root/root     11518 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/checkpoint-restore/go-criu/v4/LICENSE
-rw-r--r-- root/root      1435 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/pkg/errors/LICENSE
-rw-r--r-- root/root     11484 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-logr/logr/LICENSE
-rw-r--r-- root/root      1230 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/blang/semver/LICENSE
-rw-r--r-- root/root     11534 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/matttproud/golang_protobuf_extensions/LICENSE
-rw-r--r-- root/root      1500 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/magiconair/properties/LICENSE
-rw-r--r-- root/root      1185 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/beorn7/perks/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/azure-sdk-for-go/LICENSE
-rw-r--r-- root/root     10904 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/LICENSE
-rw-r--r-- root/root     10911 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/logger/LICENSE
-rw-r--r-- root/root     10918 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/adal/LICENSE
-rw-r--r-- root/root     10916 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/to/LICENSE
-rw-r--r-- root/root     10913 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/LICENSE
-rw-r--r-- root/root     10919 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/mocks/LICENSE
-rw-r--r-- root/root     10918 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/date/LICENSE
-rw-r--r-- root/root     10924 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/validation/LICENSE
-rw-r--r-- root/root     10912 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/tracing/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/Azure/go-ansiterm/LICENSE
-rw-r--r-- root/root       314 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-bindata/go-bindata/LICENSE
-rw-r--r-- root/root      1201 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/form3tech-oss/jwt-go/LICENSE
-rw-r--r-- root/root       899 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/davecgh/go-spew/LICENSE
-rw-r--r-- root/root      1272 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/hpcloud/tail/LICENSE
-rw-r--r-- root/root      1205 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/json-iterator/go/LICENSE
-rw-r--r-- root/root      2737 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/daviddengcn/go-colortext/LICENSE
-rw-r--r-- root/root      1267 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/cilium/ebpf/LICENSE
-rw-r--r-- root/root      1620 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/elazarl/goproxy/LICENSE
-rw-r--r-- root/root      1230 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/MakeNowJust/heredoc/LICENSE
-rw-r--r-- root/root      1202 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/spf13/cast/LICENSE
-rw-r--r-- root/root     10269 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/spf13/afero/LICENSE
-rw-r--r-- root/root      1656 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/spf13/pflag/LICENSE
-rw-r--r-- root/root      1204 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/spf13/viper/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/spf13/jwalterweatherman/LICENSE
-rw-r--r-- root/root     10269 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/spf13/cobra/LICENSE
-rw-r--r-- root/root      1218 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/fvbommel/sortorder/LICENSE
-rw-r--r-- root/root      1613 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mvdan/xurls/LICENSE
-rw-r--r-- root/root      1698 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/cyphar/filepath-securejoin/LICENSE
-rw-r--r-- root/root      1634 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/evanphx/json-patch/LICENSE
-rw-r--r-- root/root      1614 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/quobyte/api/LICENSE
-rw-r--r-- root/root      1208 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/armon/circbuf/LICENSE
-rw-r--r-- root/root       721 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/NYTimes/gziphandler/LICENSE
-rw-r--r-- root/root     11498 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/googleapis/gnostic/LICENSE
-rw-r--r-- root/root      1614 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/googleapis/gax-go/v2/LICENSE
-rw-r--r-- root/root      1683 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/munnerz/goautoneg/LICENSE
-rw-r--r-- root/root      1227 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/exponent-io/jsonpath/LICENSE
-rw-r--r-- root/root      1202 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mohae/deepcopy/LICENSE
-rw-r--r-- root/root      1294 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/konsorten/go-windows-terminal-sequences/LICENSE
-rw-r--r-- root/root       702 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/jmespath/go-jmespath/LICENSE
-rw-r--r-- root/root      1242 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/pelletier/go-toml/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/onsi/gomega/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/onsi/ginkgo/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/cpuguy83/go-md2man/v2/LICENSE
-rw-r--r-- root/root      1665 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/imdario/mergo/LICENSE
-rw-r--r-- root/root       389 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/heketi/heketi/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/go-ozzo/ozzo-validation/LICENSE
-rw-r--r-- root/root      1238 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/stretchr/testify/LICENSE
-rw-r--r-- root/root      1246 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/stretchr/objx/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/fatih/camelcase/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/vmware/govmomi/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/syndtr/gocapability/LICENSE
-rw-r--r-- root/root     10895 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mrunalp/fileutils/LICENSE
-rw-r--r-- root/root     11487 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/soheilhy/cmux/LICENSE
-rw-r--r-- root/root      1275 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/dustin/go-humanize/LICENSE
-rw-r--r-- root/root     11507 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/containernetworking/cni/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/prometheus/common/LICENSE
-rw-r--r-- root/root     11506 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/prometheus/client_model/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/prometheus/procfs/LICENSE
-rw-r--r-- root/root     11508 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/prometheus/client_golang/LICENSE
-rw-r--r-- root/root     16106 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/hashicorp/hcl/LICENSE
-rw-r--r-- root/root     16064 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/hashicorp/golang-lru/LICENSE
-rw-r--r-- root/root      1584 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/pmezard/go-difflib/LICENSE
-rw-r--r-- root/root     11492 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/containerd/ttrpc/LICENSE
-rw-r--r-- root/root     10904 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/containerd/console/LICENSE
-rw-r--r-- root/root     11496 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/containerd/cgroups/LICENSE
-rw-r--r-- root/root     10910 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/containerd/containerd/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/gregjones/httpcache/LICENSE
-rw-r--r-- root/root      1647 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/mxk/go-flowrate/LICENSE
-rw-r--r-- root/root     10896 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/gophercloud/gophercloud/LICENSE
-rw-r--r-- root/root      1810 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/gogo/protobuf/LICENSE
-rw-r--r-- root/root      1217 2020-12-08 12:12 kubernetes/LICENSES/vendor/github.com/lithammer/dedent/LICENSE
-rw-r--r-- root/root     11435 2020-12-08 12:12 kubernetes/LICENSES/vendor/k8s.io/heapster/LICENSE
-rw-r--r-- root/root     11486 2020-12-08 12:12 kubernetes/LICENSES/vendor/k8s.io/system-validators/LICENSE
-rw-r--r-- root/root     11477 2020-12-08 12:12 kubernetes/LICENSES/vendor/k8s.io/kube-openapi/LICENSE
-rw-r--r-- root/root     11459 2020-12-08 12:12 kubernetes/LICENSES/vendor/k8s.io/gengo/LICENSE
-rw-r--r-- root/root     10382 2020-12-08 12:12 kubernetes/LICENSES/vendor/k8s.io/klog/v2/LICENSE
-rw-r--r-- root/root     11463 2020-12-08 12:12 kubernetes/LICENSES/vendor/k8s.io/utils/LICENSE
```

</p>
</details>

##### Content of `kubernetes-test-[system-arch].tar.gz` on example of `kubernetes-test-linux-amd64.tar.gz` (directories removed from list):

- Binaries for `genyaml` / `gendocs` / `e2e.test` / `go-runner` / `kubemark` / `genkubedocs` / `linkcheck` / `genswaggertypedocs` / `e2e_node.test` / `genman` / `ginkgo`

<details><summary>Expand Contents</summary>
<p>

```
➜ $ tar -ztvf kubernetes-test-linux-amd64.tar.gz
-rwxr-xr-x root/root  39895040 2020-12-08 12:17 kubernetes/test/bin/genyaml
-rwxr-xr-x root/root  39903232 2020-12-08 12:17 kubernetes/test/bin/gendocs
-rwxr-xr-x root/root 122987792 2020-12-08 12:17 kubernetes/test/bin/e2e.test
-rwxr-xr-x root/root   1929216 2020-12-08 12:17 kubernetes/test/bin/go-runner
-rwxr-xr-x root/root 112175880 2020-12-08 12:16 kubernetes/test/bin/kubemark
-rwxr-xr-x root/root 150267272 2020-12-08 12:17 kubernetes/test/bin/genkubedocs
-rwxr-xr-x root/root   5091328 2020-12-08 12:17 kubernetes/test/bin/linkcheck
-rwxr-xr-x root/root   6717440 2020-12-08 12:17 kubernetes/test/bin/genswaggertypedocs
-rwxr-xr-x root/root 135916432 2020-12-08 12:16 kubernetes/test/bin/e2e_node.test
-rwxr-xr-x root/root 157217352 2020-12-08 12:17 kubernetes/test/bin/genman
-rwxr-xr-x root/root   7651328 2020-12-08 12:17 kubernetes/test/bin/ginkgo
```

</p>
</details>

##### Content of `kubernetes-manifests.tar.gz` (directories removed from list):

*Summary*

- `kube-system` manifests for Kubernetes distros, such as COS (see [cluster/gce/gci](https://github.com/kubernetes/kubernetes/tree/master/cluster/gce/gci) for more information)

<details><summary>Expand Contents</summary>
<p>

```
➜ $ tar -ztvf kubernetes-manifests.tar.gz
-rw-r--r-- root/root      2845 2020-12-08 12:10 kubernetes/gci-trusty/glbc.manifest
-rw-r--r-- root/root       419 2020-12-08 11:50 kubernetes/gci-trusty/metrics-server/auth-reader.yaml
-rw-r--r-- root/root       388 2020-12-08 11:50 kubernetes/gci-trusty/metrics-server/metrics-apiservice.yaml
-rw-r--r-- root/root      3352 2020-12-08 11:50 kubernetes/gci-trusty/metrics-server/metrics-server-deployment.yaml
-rw-r--r-- root/root       398 2020-12-08 11:50 kubernetes/gci-trusty/metrics-server/auth-delegator.yaml
-rw-r--r-- root/root       844 2020-12-08 11:50 kubernetes/gci-trusty/metrics-server/resource-reader.yaml
-rw-r--r-- root/root       336 2020-12-08 11:50 kubernetes/gci-trusty/metrics-server/metrics-server-service.yaml
-rw-r--r-- root/root    118780 2020-12-08 12:10 kubernetes/gci-trusty/gci-configure-helper.sh
-rw-r--r-- root/root     16675 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-configmap-old.yaml
-rw-r--r-- root/root       190 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-ds-sa.yaml
-rw-r--r-- root/root      2366 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/event-exporter.yaml
-rw-r--r-- root/root       350 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-role.yaml
-rw-r--r-- root/root       415 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-binding.yaml
-rw-r--r-- root/root       356 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/event-exporter-psp-role.yaml
-rw-r--r-- root/root       427 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/event-exporter-psp-binding.yaml
-rw-r--r-- root/root      1189 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp.yaml
-rw-r--r-- root/root      1281 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/event-exporter-psp.yaml
-rw-r--r-- root/root     18765 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-configmap.yaml
-rw-r--r-- root/root       968 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/scaler-deployment.yaml
-rw-r--r-- root/root      1009 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/scaler-rbac.yaml
-rw-r--r-- root/root       323 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/scaler-policy.yaml
-rw-r--r-- root/root      4216 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-ds.yaml
-rw-r--r-- root/root       397 2020-12-08 11:50 kubernetes/gci-trusty/node-problem-detector/standalone/npd-binding.yaml
-rw-r--r-- root/root      2507 2020-12-08 11:50 kubernetes/gci-trusty/node-problem-detector/npd.yaml
-rw-r--r-- root/root       423 2020-12-08 11:50 kubernetes/gci-trusty/node-problem-detector/podsecuritypolicies/npd-psp-binding.yaml
-rw-r--r-- root/root       389 2020-12-08 11:50 kubernetes/gci-trusty/node-problem-detector/kubelet-user-standalone/npd-binding.yaml
-rw-r--r-- root/root       261 2020-12-08 11:50 kubernetes/gci-trusty/storage-class/aws/default.yaml
-rw-r--r-- root/root       241 2020-12-08 11:50 kubernetes/gci-trusty/storage-class/openstack/default.yaml
-rw-r--r-- root/root       228 2020-12-08 11:50 kubernetes/gci-trusty/storage-class/vsphere/default.yaml
-rw-r--r-- root/root       245 2020-12-08 11:50 kubernetes/gci-trusty/storage-class/azure/default.yaml
-rw-r--r-- root/root       300 2020-12-08 11:50 kubernetes/gci-trusty/storage-class/gce/default.yaml
-rw-r--r-- root/root       269 2020-12-08 11:50 kubernetes/gci-trusty/storage-class/local/default.yaml
-rw-r--r-- root/root      4140 2020-12-08 12:10 kubernetes/gci-trusty/health-monitor.sh
-rw-r--r-- root/root       409 2020-12-08 11:50 kubernetes/gci-trusty/konnectivity-agent/konnectivity-rbac.yaml
-rw-r--r-- root/root       197 2020-12-08 11:50 kubernetes/gci-trusty/konnectivity-agent/konnectivity-agent-rbac.yaml
-rw-r--r-- root/root      2023 2020-12-08 11:50 kubernetes/gci-trusty/konnectivity-agent/konnectivity-agent-ds.yaml
-rw-r--r-- root/root      1289 2020-12-08 12:10 kubernetes/gci-trusty/abac-authz-policy.jsonl
-rw-r--r-- root/root      2434 2020-12-08 11:50 kubernetes/gci-trusty/node-termination-handler/daemonset.yaml
-rw-r--r-- root/root       791 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/privileged.yaml
-rw-r--r-- root/root       572 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/persistent-volume-binder-role.yaml
-rw-r--r-- root/root       878 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/persistent-volume-binder.yaml
-rw-r--r-- root/root       535 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/kube-system-binding.yaml
-rw-r--r-- root/root       643 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/persistent-volume-binder-binding.yaml
-rw-r--r-- root/root       425 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/kube-proxy-binding.yaml
-rw-r--r-- root/root       364 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/unprivileged-addon-role.yaml
-rw-r--r-- root/root       742 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/node-binding.yaml
-rw-r--r-- root/root      1577 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/unprivileged-addon.yaml
-rw-r--r-- root/root       330 2020-12-08 11:50 kubernetes/gci-trusty/podsecuritypolicies/privileged-role.yaml
-rw-r--r-- root/root     25526 2020-12-08 12:10 kubernetes/gci-trusty/configure-kubeapiserver.sh
-rw-r--r-- root/root      1021 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-deployment.yaml
-rw-r--r-- root/root       329 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-role.yaml
-rw-r--r-- root/root       321 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-clusterrolebinding.yaml
-rw-r--r-- root/root      1037 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-deployment.yaml
-rw-r--r-- root/root       331 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/networkset-crd.yaml
-rw-r--r-- root/root      2020 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-deployment.yaml
-rw-r--r-- root/root       147 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-serviceaccount.yaml
-rw-r--r-- root/root       352 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/globalnetworksets-crd.yaml
-rw-r--r-- root/root       312 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/ippool-crd.yaml
-rw-r--r-- root/root       356 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/globalfelixconfig-crd.yaml
-rw-r--r-- root/root       356 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-service.yaml
-rw-r--r-- root/root       293 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-clusterrole.yaml
-rw-r--r-- root/root       148 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-cpva-serviceaccount.yaml
-rw-r--r-- root/root       369 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/podsecuritypolicies/calico-node-psp-binding.yaml
-rw-r--r-- root/root       352 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/bgpconfigurations-crd.yaml
-rw-r--r-- root/root       342 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/blockaffinity-crd.yaml
-rw-r--r-- root/root       414 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-configmap.yaml
-rw-r--r-- root/root       308 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-cpva-clusterrole.yaml
-rw-r--r-- root/root       345 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/networkpolicies-crd.yaml
-rw-r--r-- root/root       360 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/clusterinformations-crd.yaml
-rw-r--r-- root/root       316 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/bgppeers-crd.yaml
-rw-r--r-- root/root       303 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-clusterrolebinding.yaml
-rw-r--r-- root/root       336 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/hostendpoints-crd.yaml
-rw-r--r-- root/root       348 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/globalbgpconfig-crd.yaml
-rw-r--r-- root/root       360 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/felixconfigurations-crd.yaml
-rw-r--r-- root/root       328 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/ipamhandle-crd.yaml
-rw-r--r-- root/root       324 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-cpva-clusterrolebinding.yaml
-rw-r--r-- root/root      6099 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-node-daemonset.yaml
-rw-r--r-- root/root       410 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-configmap.yaml
-rw-r--r-- root/root       324 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/ipamblock-crd.yaml
-rw-r--r-- root/root      3380 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-clusterrole.yaml
-rw-r--r-- root/root       226 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-clusterrole.yaml
-rw-r--r-- root/root       143 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-serviceaccount.yaml
-rw-r--r-- root/root       366 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/globalnetworkpolicy-crd.yaml
-rw-r--r-- root/root       409 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-node-vertical-autoscaler-configmap.yaml
-rw-r--r-- root/root       321 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-clusterrolebinding.yaml
-rw-r--r-- root/root      1029 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/calico-node-vertical-autoscaler-deployment.yaml
-rw-r--r-- root/root       328 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/ipamconfig-crd.yaml
-rw-r--r-- root/root       147 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-serviceaccount.yaml
-rw-r--r-- root/root       332 2020-12-08 11:50 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-rolebinding.yaml
-rw-r--r-- root/root      1579 2020-12-08 12:10 kubernetes/gci-trusty/kube-addon-manager.yaml
-rw-r--r-- root/root      2941 2020-12-08 11:50 kubernetes/gci-trusty/volumesnapshots/volume-snapshot-controller/rbac-volume-snapshot-controller.yaml
-rw-r--r-- root/root       675 2020-12-08 11:50 kubernetes/gci-trusty/volumesnapshots/volume-snapshot-controller/volume-snapshot-controller-deployment.yaml
-rw-r--r-- root/root      5888 2020-12-08 11:50 kubernetes/gci-trusty/volumesnapshots/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
-rw-r--r-- root/root     19001 2020-12-08 11:50 kubernetes/gci-trusty/volumesnapshots/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
-rw-r--r-- root/root     22543 2020-12-08 11:50 kubernetes/gci-trusty/volumesnapshots/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
-rw-r--r-- root/root      3624 2020-12-08 12:10 kubernetes/gci-trusty/etcd.manifest
-rw-r--r-- root/root      1931 2020-12-08 12:10 kubernetes/gci-trusty/kube-proxy.manifest
-rw-r--r-- root/root      3354 2020-12-08 11:50 kubernetes/gci-trusty/dns-horizontal-autoscaler/dns-horizontal-autoscaler.yaml
-rw-r--r-- root/root      2507 2020-12-08 11:50 kubernetes/gci-trusty/metadata-proxy/gce/metadata-proxy.yaml
-rw-r--r-- root/root       427 2020-12-08 11:50 kubernetes/gci-trusty/metadata-proxy/gce/podsecuritypolicies/metadata-proxy-psp-binding.yaml
-rw-r--r-- root/root       425 2020-12-08 11:50 kubernetes/gci-trusty/ip-masq-agent/podsecuritypolicies/ip-masq-agent-psp-binding.yaml
-rw-r--r-- root/root      1748 2020-12-08 11:50 kubernetes/gci-trusty/ip-masq-agent/ip-masq-agent.yaml
-rw-r--r-- root/root       226 2020-12-08 11:50 kubernetes/gci-trusty/limit-range/limit-range.yaml
-rw-r--r-- root/root       399 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/podsecuritypolicies/es-psp-binding.yaml
-rw-r--r-- root/root      1519 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/kibana-deployment.yaml
-rw-r--r-- root/root      3186 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/es-statefulset.yaml
-rw-r--r-- root/root       354 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/kibana-service.yaml
-rw-r--r-- root/root       580 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/es-service.yaml
-rw-r--r-- root/root     16125 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/fluentd-es-configmap.yaml
-rw-r--r-- root/root      2581 2020-12-08 11:50 kubernetes/gci-trusty/fluentd-elasticsearch/fluentd-es-ds.yaml
-rw-r--r-- root/root      6878 2020-12-08 11:50 kubernetes/gci-trusty/dashboard/dashboard.yaml
-rw-r--r-- root/root       433 2020-12-08 11:50 kubernetes/gci-trusty/metadata-agent/stackdriver/podsecuritypolicies/metadata-agent-psp-binding.yaml
-rw-r--r-- root/root       685 2020-12-08 11:50 kubernetes/gci-trusty/metadata-agent/stackdriver/metadata-agent-rbac.yaml
-rw-r--r-- root/root      3581 2020-12-08 11:50 kubernetes/gci-trusty/metadata-agent/stackdriver/metadata-agent.yaml
-rw-r--r-- root/root      5007 2020-12-08 11:50 kubernetes/gci-trusty/dns/coredns/coredns.yaml.in
-rw-r--r-- root/root      7245 2020-12-08 11:50 kubernetes/gci-trusty/dns/kube-dns/kube-dns.yaml.in
-rw-r--r-- root/root      5334 2020-12-08 11:50 kubernetes/gci-trusty/dns/nodelocaldns/nodelocaldns.yaml
-rw-r--r-- root/root      1765 2020-12-08 12:10 kubernetes/gci-trusty/kube-scheduler.manifest
-rw-r--r-- root/root      2024 2020-12-08 11:50 kubernetes/gci-trusty/kube-proxy/kube-proxy-ds.yaml
-rw-r--r-- root/root       488 2020-12-08 11:50 kubernetes/gci-trusty/kube-proxy/kube-proxy-rbac.yaml
-rw-r--r-- root/root       644 2020-12-08 11:50 kubernetes/gci-trusty/admission-resource-quota-critical-pods/resource-quota.yaml
-rw-r--r-- root/root       685 2020-12-08 11:50 kubernetes/gci-trusty/loadbalancing/cloud-provider-binding.yaml
-rw-r--r-- root/root      1540 2020-12-08 11:50 kubernetes/gci-trusty/loadbalancing/cloud-provider-role.yaml
-rw-r--r-- root/root      3680 2020-12-08 12:10 kubernetes/gci-trusty/cluster-autoscaler.manifest
-rw-r--r-- root/root      1641 2020-12-08 12:10 kubernetes/gci-trusty/konnectivity-server.yaml
-rw-r--r-- root/root      1587 2020-12-08 11:50 kubernetes/gci-trusty/device-plugins/nvidia-gpu/daemonset.yaml
-rw-r--r-- root/root      2970 2020-12-08 12:10 kubernetes/gci-trusty/kube-controller-manager.manifest
-rw-r--r-- root/root      4216 2020-12-08 12:10 kubernetes/gci-trusty/kube-apiserver.manifest
-rw-r--r-- root/root       577 2020-12-08 11:50 kubernetes/gci-trusty/cluster-loadbalancing/glbc/default-svc.yaml
-rw-r--r-- root/root      1108 2020-12-08 11:50 kubernetes/gci-trusty/cluster-loadbalancing/glbc/default-svc-controller.yaml
-rw-r--r-- root/root       782 2020-12-08 11:50 kubernetes/gci-trusty/rbac/legacy-kubelet-user-disable/kubelet-binding.yaml
-rw-r--r-- root/root       565 2020-12-08 11:50 kubernetes/gci-trusty/rbac/legacy-kubelet-user/kubelet-binding.yaml
-rw-r--r-- root/root      1399 2020-12-08 11:50 kubernetes/gci-trusty/rbac/kubelet-cert-rotation/kubelet-certificate-management.yaml
-rw-r--r-- root/root      2089 2020-12-08 11:50 kubernetes/gci-trusty/rbac/cluster-autoscaler/cluster-autoscaler-rbac.yaml
-rw-r--r-- root/root       338 2020-12-08 11:50 kubernetes/gci-trusty/rbac/kubelet-api-auth/kubelet-api-admin-role.yaml
-rw-r--r-- root/root       427 2020-12-08 11:50 kubernetes/gci-trusty/rbac/kubelet-api-auth/kube-apiserver-kubelet-api-admin-binding.yaml
-rw-r--r-- root/root       647 2020-12-08 11:50 kubernetes/gci-trusty/rbac/cluster-loadbalancing/glbc/user-rolebindings.yaml
-rw-r--r-- root/root      2593 2020-12-08 11:50 kubernetes/gci-trusty/rbac/cluster-loadbalancing/glbc/roles.yaml
```

</p>
</details>

##### Content of `kubernetes.tar.gz` (directories removed from list):

*Summary*

- Various scripts, `README`'s, `OWNERS` files, `BUILD` files, `.gitignore` files, etc.
- Source code for tools that live in `kubernetes/kubernetes`, but are not core components (e.g. binaries in `kubernetes-test` tarball)
- [LICENSES](https://github.com/kubernetes/kubernetes/tree/master/LICENSES)

<details><summary>Expand Contents</summary>
<p>

```
➜ $ tar -ztvf kubernetes.tar.gz
-rw-r--r-- root/root       146 2020-12-08 12:16 kubernetes/client/README
-rw-r--r-- root/root       208 2020-12-08 12:16 kubernetes/docs/OWNERS
-rw-r--r-- root/root       346 2020-12-08 12:16 kubernetes/docs/BUILD
-rw-r--r-- root/root        46 2020-12-08 12:16 kubernetes/docs/.gitignore
-rwxr-xr-x root/root      2826 2020-12-08 12:16 kubernetes/cluster/kubectl.sh
-rw-r--r-- root/root      2192 2020-12-08 12:16 kubernetes/cluster/pre-existing/util.sh
-rw-r--r-- root/root        77 2020-12-08 12:16 kubernetes/cluster/pre-existing/OWNERS
-rwxr-xr-x root/root      1414 2020-12-08 12:16 kubernetes/cluster/kube-util.sh
-rw-r--r-- root/root      2417 2020-12-08 12:16 kubernetes/cluster/skeleton/util.sh
-rw-r--r-- root/root        73 2020-12-08 12:16 kubernetes/cluster/skeleton/OWNERS
-rw-r--r-- root/root       848 2020-12-08 12:16 kubernetes/cluster/kubemark/util.sh
-rw-r--r-- root/root      1373 2020-12-08 12:16 kubernetes/cluster/kubemark/pre-existing/config-default.sh
-rw-r--r-- root/root      2939 2020-12-08 12:16 kubernetes/cluster/kubemark/gce/config-default.sh
-rw-r--r-- root/root       233 2020-12-08 12:16 kubernetes/cluster/kubemark/OWNERS
-rw-r--r-- root/root      2138 2020-12-08 12:16 kubernetes/cluster/kubemark/iks/config-default.sh
-rwxr-xr-x root/root     18035 2020-12-08 12:16 kubernetes/cluster/common.sh
-rwxr-xr-x root/root      7476 2020-12-08 12:16 kubernetes/cluster/validate-cluster.sh
-rw-r--r-- root/root       624 2020-12-08 12:16 kubernetes/cluster/images/etcd/cp/BUILD
-rw-r--r-- root/root      1599 2020-12-08 12:16 kubernetes/cluster/images/etcd/cp/cp.go
-rw-r--r-- root/root      1161 2020-12-08 12:16 kubernetes/cluster/images/etcd/Dockerfile
-rw-r--r-- root/root       700 2020-12-08 12:16 kubernetes/cluster/images/etcd/cloudbuild.yaml
-rw-r--r-- root/root      8964 2020-12-08 12:16 kubernetes/cluster/images/etcd/Makefile
-rw-r--r-- root/root       137 2020-12-08 12:16 kubernetes/cluster/images/etcd/OWNERS
-rwxr-xr-x root/root       836 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate-if-needed.sh
-rw-r--r-- root/root      4374 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/data_dir.go
-rw-r--r-- root/root      3442 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/options_test.go
-rw-r--r-- root/root      5980 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/versions.go
-rw-r--r-- root/root      2634 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/versions_test.go
-rw-r--r-- root/root       752 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/util_others.go
-rw-r--r-- root/root        13 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/testdata/datadir_with_version/version.txt
-rw-r--r-- root/root         0 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/testdata/datadir_without_version/.placeholder
-rw-r--r-- root/root      4613 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/data_dir_test.go
-rw-r--r-- root/root      1474 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/copy_file.go
-rw-r--r-- root/root      3885 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/migrate.go
-rw-r--r-- root/root     11043 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/integration_test.go
-rw-r--r-- root/root      7437 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/migrate_client.go
-rw-r--r-- root/root       720 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/utils_windows.go
-rw-r--r-- root/root      6578 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/migrator.go
-rw-r--r-- root/root      3563 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/BUILD
-rw-r--r-- root/root      3880 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/migrate_server.go
-rw-r--r-- root/root      9790 2020-12-08 12:16 kubernetes/cluster/images/etcd/migrate/options.go
-rw-r--r-- root/root      2933 2020-12-08 12:16 kubernetes/cluster/images/etcd/README.md
-rw-r--r-- root/root       862 2020-12-08 12:16 kubernetes/cluster/images/kubemark/Dockerfile
-rw-r--r-- root/root      1268 2020-12-08 12:16 kubernetes/cluster/images/kubemark/Makefile
-rw-r--r-- root/root       173 2020-12-08 12:16 kubernetes/cluster/images/kubemark/OWNERS
-rw-r--r-- root/root       791 2020-12-08 12:16 kubernetes/cluster/images/kubemark/BUILD
-rw-r--r-- root/root       687 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/Dockerfile
-rw-r--r-- root/root       250 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/etcd-version-monitor.yaml
-rw-r--r-- root/root     11758 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/etcd-version-monitor.go
-rw-r--r-- root/root      1515 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/Makefile
-rw-r--r-- root/root        79 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/OWNERS
-rw-r--r-- root/root      1056 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/BUILD
-rw-r--r-- root/root      1356 2020-12-08 12:16 kubernetes/cluster/images/etcd-version-monitor/README.md
-rw-r--r-- root/root       107 2020-12-08 12:16 kubernetes/cluster/images/OWNERS
-rw-r--r-- root/root      1538 2020-12-08 12:16 kubernetes/cluster/images/conformance/conformance-e2e.yaml
-rw-r--r-- root/root      1007 2020-12-08 12:16 kubernetes/cluster/images/conformance/Dockerfile
-rwxr-xr-x root/root      1294 2020-12-08 12:16 kubernetes/cluster/images/conformance/conformance-e2e.sh
-rw-r--r-- root/root      2548 2020-12-08 12:16 kubernetes/cluster/images/conformance/Makefile
-rw-r--r-- root/root      2345 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/tar.go
-rw-r--r-- root/root       785 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/Makefile
-rw-r--r-- root/root      3738 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/tar_test.go
-rw-r--r-- root/root      2739 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/cmd.go
-rw-r--r-- root/root      3663 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/e2erunner.go
-rw-r--r-- root/root      1052 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/BUILD
-rw-r--r-- root/root      3793 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/cmd_test.go
-rw-r--r-- root/root      2542 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/const.go
-rw-r--r-- root/root         0 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/README.md
-rw-r--r-- root/root      1695 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/env_test.go
-rw-r--r-- root/root      1896 2020-12-08 12:16 kubernetes/cluster/images/conformance/go-runner/env.go
-rwxr-xr-x root/root      2271 2020-12-08 12:16 kubernetes/cluster/images/conformance/run_e2e.sh
-rw-r--r-- root/root       334 2020-12-08 12:16 kubernetes/cluster/images/conformance/OWNERS
-rw-r--r-- root/root      1879 2020-12-08 12:16 kubernetes/cluster/images/conformance/BUILD
-rw-r--r-- root/root      1376 2020-12-08 12:16 kubernetes/cluster/images/conformance/README.md
-rwxr-xr-x root/root      6149 2020-12-08 12:16 kubernetes/cluster/gce/upgrade-aliases.sh
-rw-r--r-- root/root      6093 2020-12-08 12:16 kubernetes/cluster/gce/windows/configure.ps1
-rw-r--r-- root/root      7498 2020-12-08 12:16 kubernetes/cluster/gce/windows/README-GCE-Windows-kube-up.md
-rw-r--r-- root/root     82204 2020-12-08 12:16 kubernetes/cluster/gce/windows/k8s-node-setup.psm1
-rwxr-xr-x root/root      2656 2020-12-08 12:16 kubernetes/cluster/gce/windows/node-helper.sh
-rw-r--r-- root/root       189 2020-12-08 12:16 kubernetes/cluster/gce/windows/OWNERS
-rw-r--r-- root/root      1121 2020-12-08 12:16 kubernetes/cluster/gce/windows/BUILD
-rw-r--r-- root/root      9675 2020-12-08 12:16 kubernetes/cluster/gce/windows/testonly/user-profile.psm1
-rw-r--r-- root/root     11389 2020-12-08 12:16 kubernetes/cluster/gce/windows/testonly/install-ssh.psm1
-rw-r--r-- root/root     21811 2020-12-08 12:16 kubernetes/cluster/gce/windows/common.psm1
-rwxr-xr-x root/root     22249 2020-12-08 12:16 kubernetes/cluster/gce/windows/smoke-test.sh
-rwxr-xr-x root/root    146797 2020-12-08 12:16 kubernetes/cluster/gce/util.sh
-rwxr-xr-x root/root     29153 2020-12-08 12:16 kubernetes/cluster/gce/config-test.sh
-rw-r--r-- root/root      2845 2020-12-08 12:16 kubernetes/cluster/gce/manifests/glbc.manifest
-rw-r--r-- root/root      1289 2020-12-08 12:16 kubernetes/cluster/gce/manifests/abac-authz-policy.jsonl
-rw-r--r-- root/root      1579 2020-12-08 12:16 kubernetes/cluster/gce/manifests/kube-addon-manager.yaml
-rw-r--r-- root/root      3624 2020-12-08 12:16 kubernetes/cluster/gce/manifests/etcd.manifest
-rw-r--r-- root/root      1931 2020-12-08 12:16 kubernetes/cluster/gce/manifests/kube-proxy.manifest
-rw-r--r-- root/root       143 2020-12-08 12:16 kubernetes/cluster/gce/manifests/OWNERS
-rw-r--r-- root/root      1765 2020-12-08 12:16 kubernetes/cluster/gce/manifests/kube-scheduler.manifest
-rw-r--r-- root/root      1074 2020-12-08 12:16 kubernetes/cluster/gce/manifests/BUILD
-rw-r--r-- root/root      3680 2020-12-08 12:16 kubernetes/cluster/gce/manifests/cluster-autoscaler.manifest
-rw-r--r-- root/root      1641 2020-12-08 12:16 kubernetes/cluster/gce/manifests/konnectivity-server.yaml
-rw-r--r-- root/root      2970 2020-12-08 12:16 kubernetes/cluster/gce/manifests/kube-controller-manager.manifest
-rw-r--r-- root/root      4216 2020-12-08 12:16 kubernetes/cluster/gce/manifests/kube-apiserver.manifest
-rwxr-xr-x root/root      3734 2020-12-08 12:16 kubernetes/cluster/gce/list-resources.sh
lrwxrwxrwx root/root         0 2020-12-08 12:16 kubernetes/cluster/gce/ubuntu -> gci
-rw-r--r-- root/root      5809 2020-12-08 12:16 kubernetes/cluster/gce/gci/apiserver_etcd_test.go
-rwxr-xr-x root/root      1192 2020-12-08 12:16 kubernetes/cluster/gce/gci/helper.sh
-rw-r--r-- root/root      9980 2020-12-08 12:16 kubernetes/cluster/gce/gci/audit_policy_test.go
-rw-r--r-- root/root     24524 2020-12-08 12:16 kubernetes/cluster/gce/gci/configure.sh
-rw-r--r-- root/root      4158 2020-12-08 12:16 kubernetes/cluster/gce/gci/append_or_replace_prefixed_line_test.go
-rw-r--r-- root/root      4979 2020-12-08 12:16 kubernetes/cluster/gce/gci/configure_helper_test.go
-rw-r--r-- root/root      1163 2020-12-08 12:16 kubernetes/cluster/gce/gci/testdata/kube-apiserver/base.template
-rw-r--r-- root/root       271 2020-12-08 12:16 kubernetes/cluster/gce/gci/testdata/kube-apiserver/kms.template
-rw-r--r-- root/root       856 2020-12-08 12:16 kubernetes/cluster/gce/gci/testdata/kube-apiserver/etcd.template
-rwxr-xr-x root/root      8993 2020-12-08 12:16 kubernetes/cluster/gce/gci/master-helper.sh
-rw-r--r-- root/root      4140 2020-12-08 12:16 kubernetes/cluster/gce/gci/health-monitor.sh
-rwxr-xr-x root/root      1082 2020-12-08 12:16 kubernetes/cluster/gce/gci/shutdown.sh
-rw-r--r-- root/root     25526 2020-12-08 12:16 kubernetes/cluster/gce/gci/configure-kubeapiserver.sh
-rw-r--r-- root/root       745 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/Dockerfile
-rw-r--r-- root/root       862 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/Makefile
-rw-r--r-- root/root      2912 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/mounter.go
-rw-r--r-- root/root       367 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/Changelog
-rw-r--r-- root/root       578 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/BUILD
-rwxr-xr-x root/root      2478 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/stage-upload.sh
-rw-r--r-- root/root         8 2020-12-08 12:16 kubernetes/cluster/gce/gci/mounter/.gitignore
-rw-r--r-- root/root      6236 2020-12-08 12:16 kubernetes/cluster/gce/gci/apiserver_kms_test.go
-rw-r--r-- root/root    118780 2020-12-08 12:16 kubernetes/cluster/gce/gci/configure-helper.sh
-rw-r--r-- root/root      3930 2020-12-08 12:16 kubernetes/cluster/gce/gci/node.yaml
-rwxr-xr-x root/root      5974 2020-12-08 12:16 kubernetes/cluster/gce/gci/flexvolume_node_setup.sh
-rwxr-xr-x root/root      2010 2020-12-08 12:16 kubernetes/cluster/gce/gci/node-helper.sh
-rw-r--r-- root/root       144 2020-12-08 12:16 kubernetes/cluster/gce/gci/OWNERS
-rw-r--r-- root/root      2887 2020-12-08 12:16 kubernetes/cluster/gce/gci/BUILD
-rw-r--r-- root/root      1109 2020-12-08 12:16 kubernetes/cluster/gce/gci/kube-master-internal-route.sh
-rw-r--r-- root/root      4785 2020-12-08 12:16 kubernetes/cluster/gce/gci/master.yaml
-rw-r--r-- root/root      6640 2020-12-08 12:16 kubernetes/cluster/gce/gci/README.md
-rw-r--r-- root/root       442 2020-12-08 12:16 kubernetes/cluster/gce/OWNERS
-rw-r--r-- root/root      5631 2020-12-08 12:16 kubernetes/cluster/gce/config-common.sh
-rwxr-xr-x root/root     27134 2020-12-08 12:16 kubernetes/cluster/gce/config-default.sh
-rw-r--r-- root/root       583 2020-12-08 12:16 kubernetes/cluster/gce/BUILD
-rwxr-xr-x root/root      1427 2020-12-08 12:16 kubernetes/cluster/gce/delete-stranded-load-balancers.sh
-rwxr-xr-x root/root     25740 2020-12-08 12:16 kubernetes/cluster/gce/upgrade.sh
-rw-r--r-- root/root       409 2020-12-08 12:16 kubernetes/cluster/gce/addons/konnectivity-agent/konnectivity-rbac.yaml
-rw-r--r-- root/root       197 2020-12-08 12:16 kubernetes/cluster/gce/addons/konnectivity-agent/konnectivity-agent-rbac.yaml
-rw-r--r-- root/root      2023 2020-12-08 12:16 kubernetes/cluster/gce/addons/konnectivity-agent/konnectivity-agent-ds.yaml
-rw-r--r-- root/root      2434 2020-12-08 12:16 kubernetes/cluster/gce/addons/node-termination-handler/daemonset.yaml
-rw-r--r-- root/root       287 2020-12-08 12:16 kubernetes/cluster/gce/addons/node-termination-handler/README
-rw-r--r-- root/root       791 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/privileged.yaml
-rw-r--r-- root/root       572 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/persistent-volume-binder-role.yaml
-rw-r--r-- root/root       878 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/persistent-volume-binder.yaml
-rw-r--r-- root/root       535 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/kube-system-binding.yaml
-rw-r--r-- root/root       643 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/persistent-volume-binder-binding.yaml
-rw-r--r-- root/root       425 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/kube-proxy-binding.yaml
-rw-r--r-- root/root       364 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/unprivileged-addon-role.yaml
-rw-r--r-- root/root       742 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/node-binding.yaml
-rw-r--r-- root/root      1577 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/unprivileged-addon.yaml
-rw-r--r-- root/root       330 2020-12-08 12:16 kubernetes/cluster/gce/addons/podsecuritypolicies/privileged-role.yaml
-rw-r--r-- root/root       226 2020-12-08 12:16 kubernetes/cluster/gce/addons/limit-range/limit-range.yaml
-rw-r--r-- root/root       682 2020-12-08 12:16 kubernetes/cluster/gce/addons/BUILD
-rw-r--r-- root/root       644 2020-12-08 12:16 kubernetes/cluster/gce/addons/admission-resource-quota-critical-pods/resource-quota.yaml
-rw-r--r-- root/root       685 2020-12-08 12:16 kubernetes/cluster/gce/addons/loadbalancing/cloud-provider-binding.yaml
-rw-r--r-- root/root      1540 2020-12-08 12:16 kubernetes/cluster/gce/addons/loadbalancing/cloud-provider-role.yaml
-rw-r--r-- root/root       357 2020-12-08 12:16 kubernetes/cluster/gce/addons/README.md
lrwxrwxrwx root/root         0 2020-12-08 12:16 kubernetes/cluster/gce/custom -> gci
lrwxrwxrwx root/root         0 2020-12-08 12:16 kubernetes/cluster/gce/cos -> gci
-rw-r--r-- root/root       307 2020-12-08 12:16 kubernetes/cluster/OWNERS
-rwxr-xr-x root/root      1112 2020-12-08 12:16 kubernetes/cluster/kube-down.sh
-rwxr-xr-x root/root      9005 2020-12-08 12:16 kubernetes/cluster/get-kube.sh
-rw-r--r-- root/root      1235 2020-12-08 12:16 kubernetes/cluster/BUILD
-rwxr-xr-x root/root      9459 2020-12-08 12:16 kubernetes/cluster/get-kube-binaries.sh
-rw-r--r-- root/root       419 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/auth-reader.yaml
-rw-r--r-- root/root       388 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/metrics-apiservice.yaml
-rw-r--r-- root/root      3352 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/metrics-server-deployment.yaml
-rw-r--r-- root/root       188 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/OWNERS
-rw-r--r-- root/root       398 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/auth-delegator.yaml
-rw-r--r-- root/root       844 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/resource-reader.yaml
-rw-r--r-- root/root       336 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/metrics-server-service.yaml
-rw-r--r-- root/root      1227 2020-12-08 12:16 kubernetes/cluster/addons/metrics-server/README.md
-rw-r--r-- root/root       322 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-image/README.md
-rw-r--r-- root/root     16675 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-configmap-old.yaml
-rw-r--r-- root/root       190 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-ds-sa.yaml
-rw-r--r-- root/root      2366 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/event-exporter.yaml
-rw-r--r-- root/root       350 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-role.yaml
-rw-r--r-- root/root       415 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-binding.yaml
-rw-r--r-- root/root       356 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/event-exporter-psp-role.yaml
-rw-r--r-- root/root       427 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/event-exporter-psp-binding.yaml
-rw-r--r-- root/root      1189 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp.yaml
-rw-r--r-- root/root      1281 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/event-exporter-psp.yaml
-rw-r--r-- root/root       194 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/OWNERS
-rw-r--r-- root/root     18765 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-configmap.yaml
-rw-r--r-- root/root       968 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/scaler-deployment.yaml
-rw-r--r-- root/root      1009 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/scaler-rbac.yaml
-rw-r--r-- root/root       323 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/scaler-policy.yaml
-rw-r--r-- root/root      4216 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-ds.yaml
-rw-r--r-- root/root      2775 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-gcp/README.md
-rw-r--r-- root/root       397 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/standalone/npd-binding.yaml
-rw-r--r-- root/root        78 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/MAINTAINERS.md
-rw-r--r-- root/root      2507 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/npd.yaml
-rw-r--r-- root/root       423 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/podsecuritypolicies/npd-psp-binding.yaml
-rw-r--r-- root/root       389 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/kubelet-user-standalone/npd-binding.yaml
-rw-r--r-- root/root       127 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/OWNERS
-rw-r--r-- root/root       192 2020-12-08 12:16 kubernetes/cluster/addons/node-problem-detector/README.md
-rw-r--r-- root/root       261 2020-12-08 12:16 kubernetes/cluster/addons/storage-class/aws/default.yaml
-rw-r--r-- root/root       241 2020-12-08 12:16 kubernetes/cluster/addons/storage-class/openstack/default.yaml
-rw-r--r-- root/root       228 2020-12-08 12:16 kubernetes/cluster/addons/storage-class/vsphere/default.yaml
-rw-r--r-- root/root       245 2020-12-08 12:16 kubernetes/cluster/addons/storage-class/azure/default.yaml
-rw-r--r-- root/root       300 2020-12-08 12:16 kubernetes/cluster/addons/storage-class/gce/default.yaml
-rw-r--r-- root/root       269 2020-12-08 12:16 kubernetes/cluster/addons/storage-class/local/default.yaml
-rw-r--r-- root/root      1021 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-deployment.yaml
-rw-r--r-- root/root       329 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-role.yaml
-rw-r--r-- root/root       321 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-clusterrolebinding.yaml
-rw-r--r-- root/root      1037 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-deployment.yaml
-rw-r--r-- root/root       331 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/networkset-crd.yaml
-rw-r--r-- root/root      2020 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-deployment.yaml
-rw-r--r-- root/root       147 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-serviceaccount.yaml
-rw-r--r-- root/root       352 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/globalnetworksets-crd.yaml
-rw-r--r-- root/root       312 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/ippool-crd.yaml
-rw-r--r-- root/root       356 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/globalfelixconfig-crd.yaml
-rw-r--r-- root/root       356 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-service.yaml
-rw-r--r-- root/root       293 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-clusterrole.yaml
-rw-r--r-- root/root       148 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-cpva-serviceaccount.yaml
-rw-r--r-- root/root       369 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/podsecuritypolicies/calico-node-psp-binding.yaml
-rw-r--r-- root/root       352 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/bgpconfigurations-crd.yaml
-rw-r--r-- root/root       342 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/blockaffinity-crd.yaml
-rw-r--r-- root/root       414 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-configmap.yaml
-rw-r--r-- root/root       308 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-cpva-clusterrole.yaml
-rw-r--r-- root/root       345 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/networkpolicies-crd.yaml
-rw-r--r-- root/root       360 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/clusterinformations-crd.yaml
-rw-r--r-- root/root       316 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/bgppeers-crd.yaml
-rw-r--r-- root/root       303 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-clusterrolebinding.yaml
-rw-r--r-- root/root       336 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/hostendpoints-crd.yaml
-rw-r--r-- root/root       170 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/OWNERS
-rw-r--r-- root/root       348 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/globalbgpconfig-crd.yaml
-rw-r--r-- root/root       360 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/felixconfigurations-crd.yaml
-rw-r--r-- root/root       328 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/ipamhandle-crd.yaml
-rw-r--r-- root/root       324 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-cpva-clusterrolebinding.yaml
-rw-r--r-- root/root      6099 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-node-daemonset.yaml
-rw-r--r-- root/root       410 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-configmap.yaml
-rw-r--r-- root/root       324 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/ipamblock-crd.yaml
-rw-r--r-- root/root      3380 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-clusterrole.yaml
-rw-r--r-- root/root       226 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-clusterrole.yaml
-rw-r--r-- root/root       143 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-serviceaccount.yaml
-rw-r--r-- root/root       366 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/globalnetworkpolicy-crd.yaml
-rw-r--r-- root/root       409 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-node-vertical-autoscaler-configmap.yaml
-rw-r--r-- root/root       321 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-clusterrolebinding.yaml
-rw-r--r-- root/root      1029 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/calico-node-vertical-autoscaler-deployment.yaml
-rw-r--r-- root/root       328 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/ipamconfig-crd.yaml
-rw-r--r-- root/root       147 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-serviceaccount.yaml
-rw-r--r-- root/root       332 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-rolebinding.yaml
-rw-r--r-- root/root       409 2020-12-08 12:16 kubernetes/cluster/addons/calico-policy-controller/README.md
-rw-r--r-- root/root      2941 2020-12-08 12:16 kubernetes/cluster/addons/volumesnapshots/volume-snapshot-controller/rbac-volume-snapshot-controller.yaml
-rw-r--r-- root/root       675 2020-12-08 12:16 kubernetes/cluster/addons/volumesnapshots/volume-snapshot-controller/volume-snapshot-controller-deployment.yaml
-rw-r--r-- root/root        91 2020-12-08 12:16 kubernetes/cluster/addons/volumesnapshots/OWNERS
-rw-r--r-- root/root      5888 2020-12-08 12:16 kubernetes/cluster/addons/volumesnapshots/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
-rw-r--r-- root/root     19001 2020-12-08 12:16 kubernetes/cluster/addons/volumesnapshots/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
-rw-r--r-- root/root     22543 2020-12-08 12:16 kubernetes/cluster/addons/volumesnapshots/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
-rw-r--r-- root/root        49 2020-12-08 12:16 kubernetes/cluster/addons/dns-horizontal-autoscaler/MAINTAINERS.md
-rw-r--r-- root/root       107 2020-12-08 12:16 kubernetes/cluster/addons/dns-horizontal-autoscaler/OWNERS
-rw-r--r-- root/root      3354 2020-12-08 12:16 kubernetes/cluster/addons/dns-horizontal-autoscaler/dns-horizontal-autoscaler.yaml
-rw-r--r-- root/root       596 2020-12-08 12:16 kubernetes/cluster/addons/dns-horizontal-autoscaler/README.md
-rw-r--r-- root/root      2507 2020-12-08 12:16 kubernetes/cluster/addons/metadata-proxy/gce/metadata-proxy.yaml
-rw-r--r-- root/root       427 2020-12-08 12:16 kubernetes/cluster/addons/metadata-proxy/gce/podsecuritypolicies/metadata-proxy-psp-binding.yaml
-rw-r--r-- root/root       149 2020-12-08 12:16 kubernetes/cluster/addons/metadata-proxy/OWNERS
-rw-r--r-- root/root       153 2020-12-08 12:16 kubernetes/cluster/addons/metadata-proxy/README.md
-rw-r--r-- root/root       425 2020-12-08 12:16 kubernetes/cluster/addons/ip-masq-agent/podsecuritypolicies/ip-masq-agent-psp-binding.yaml
-rw-r--r-- root/root      1748 2020-12-08 12:16 kubernetes/cluster/addons/ip-masq-agent/ip-masq-agent.yaml
-rw-r--r-- root/root       136 2020-12-08 12:16 kubernetes/cluster/addons/ip-masq-agent/OWNERS
-rw-r--r-- root/root      2226 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/go.mod
-rw-r--r-- root/root      1127 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/Dockerfile
-rwxr-xr-x root/root       871 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/Makefile
-rw-r--r-- root/root     23010 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/go.sum
-rw-r--r-- root/root      4576 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/elasticsearch_logging_discovery.go
-rw-r--r-- root/root       330 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/config/log4j2.properties
-rw-r--r-- root/root       205 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/config/elasticsearch.yml
-rw-r--r-- root/root      1195 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/BUILD
-rwxr-xr-x root/root      1040 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/run.sh
-rw-r--r-- root/root        32 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/.gitignore
-rw-r--r-- root/root      2190 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Dockerfile
-rw-r--r-- root/root       865 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Makefile
-rwxr-xr-x root/root      1052 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/entrypoint.sh
-rw-r--r-- root/root       267 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/fluent.conf
-rw-r--r-- root/root       451 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Gemfile
-rw-r--r-- root/root       662 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/README.md
-rw-r--r-- root/root       399 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/podsecuritypolicies/es-psp-binding.yaml
-rw-r--r-- root/root      1519 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/kibana-deployment.yaml
-rw-r--r-- root/root       189 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/OWNERS
-rw-r--r-- root/root      3186 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-statefulset.yaml
-rw-r--r-- root/root       354 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/kibana-service.yaml
-rw-r--r-- root/root       580 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/es-service.yaml
-rw-r--r-- root/root     16125 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-configmap.yaml
-rw-r--r-- root/root      4550 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/README.md
-rw-r--r-- root/root      2581 2020-12-08 12:16 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-ds.yaml
-rw-r--r-- root/root       242 2020-12-08 12:16 kubernetes/cluster/addons/dashboard/MAINTAINERS.md
-rw-r--r-- root/root      6878 2020-12-08 12:16 kubernetes/cluster/addons/dashboard/dashboard.yaml
-rw-r--r-- root/root       147 2020-12-08 12:16 kubernetes/cluster/addons/dashboard/OWNERS
-rw-r--r-- root/root       281 2020-12-08 12:16 kubernetes/cluster/addons/dashboard/README.md
-rw-r--r-- root/root       100 2020-12-08 12:16 kubernetes/cluster/addons/OWNERS
-rw-r--r-- root/root       433 2020-12-08 12:16 kubernetes/cluster/addons/metadata-agent/stackdriver/podsecuritypolicies/metadata-agent-psp-binding.yaml
-rw-r--r-- root/root       685 2020-12-08 12:16 kubernetes/cluster/addons/metadata-agent/stackdriver/metadata-agent-rbac.yaml
-rw-r--r-- root/root      3581 2020-12-08 12:16 kubernetes/cluster/addons/metadata-agent/stackdriver/metadata-agent.yaml
-rw-r--r-- root/root       183 2020-12-08 12:16 kubernetes/cluster/addons/metadata-agent/OWNERS
-rw-r--r-- root/root       132 2020-12-08 12:16 kubernetes/cluster/addons/metadata-agent/README.md
-rw-r--r-- root/root      1075 2020-12-08 12:16 kubernetes/cluster/addons/dns/coredns/Makefile
-rw-r--r-- root/root      5009 2020-12-08 12:16 kubernetes/cluster/addons/dns/coredns/coredns.yaml.sed
-rw-r--r-- root/root       287 2020-12-08 12:16 kubernetes/cluster/addons/dns/coredns/transforms2sed.sed
-rw-r--r-- root/root      4957 2020-12-08 12:16 kubernetes/cluster/addons/dns/coredns/coredns.yaml.base
-rw-r--r-- root/root      5007 2020-12-08 12:16 kubernetes/cluster/addons/dns/coredns/coredns.yaml.in
-rw-r--r-- root/root       344 2020-12-08 12:16 kubernetes/cluster/addons/dns/coredns/transforms2salt.sed
-rw-r--r-- root/root       129 2020-12-08 12:16 kubernetes/cluster/addons/dns/OWNERS
-rw-r--r-- root/root      7245 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/kube-dns.yaml.in
-rw-r--r-- root/root      7252 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/kube-dns.yaml.sed
-rw-r--r-- root/root      1077 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/Makefile
-rw-r--r-- root/root       287 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/transforms2sed.sed
-rw-r--r-- root/root      7211 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/kube-dns.yaml.base
-rw-r--r-- root/root       344 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/transforms2salt.sed
-rw-r--r-- root/root      1841 2020-12-08 12:16 kubernetes/cluster/addons/dns/kube-dns/README.md
-rw-r--r-- root/root      5334 2020-12-08 12:16 kubernetes/cluster/addons/dns/nodelocaldns/nodelocaldns.yaml
-rw-r--r-- root/root      2644 2020-12-08 12:16 kubernetes/cluster/addons/dns/nodelocaldns/README.md
-rw-r--r-- root/root      2024 2020-12-08 12:16 kubernetes/cluster/addons/kube-proxy/kube-proxy-ds.yaml
-rw-r--r-- root/root       149 2020-12-08 12:16 kubernetes/cluster/addons/kube-proxy/OWNERS
-rw-r--r-- root/root       488 2020-12-08 12:16 kubernetes/cluster/addons/kube-proxy/kube-proxy-rbac.yaml
-rw-r--r-- root/root       765 2020-12-08 12:16 kubernetes/cluster/addons/BUILD
-rw-r--r-- root/root       745 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/Dockerfile
-rw-r--r-- root/root      2065 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/Makefile
-rwxr-xr-x root/root      3147 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/kube-addons-main.sh
-rw-r--r-- root/root      3879 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/CHANGELOG.md
-rw-r--r-- root/root       119 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/OWNERS
-rwxr-xr-x root/root      9523 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/kube-addons-test.sh
-rwxr-xr-x root/root     11053 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/kube-addons.sh
-rw-r--r-- root/root      2544 2020-12-08 12:16 kubernetes/cluster/addons/addon-manager/README.md
-rw-r--r-- root/root      1587 2020-12-08 12:16 kubernetes/cluster/addons/device-plugins/nvidia-gpu/daemonset.yaml
-rw-r--r-- root/root       577 2020-12-08 12:16 kubernetes/cluster/addons/cluster-loadbalancing/glbc/default-svc.yaml
-rw-r--r-- root/root      1108 2020-12-08 12:16 kubernetes/cluster/addons/cluster-loadbalancing/glbc/default-svc-controller.yaml
-rw-r--r-- root/root       309 2020-12-08 12:16 kubernetes/cluster/addons/cluster-loadbalancing/glbc/README.md
-rw-r--r-- root/root       102 2020-12-08 12:16 kubernetes/cluster/addons/cluster-loadbalancing/OWNERS
-rw-r--r-- root/root       782 2020-12-08 12:16 kubernetes/cluster/addons/rbac/legacy-kubelet-user-disable/kubelet-binding.yaml
-rw-r--r-- root/root       565 2020-12-08 12:16 kubernetes/cluster/addons/rbac/legacy-kubelet-user/kubelet-binding.yaml
-rw-r--r-- root/root      1399 2020-12-08 12:16 kubernetes/cluster/addons/rbac/kubelet-cert-rotation/kubelet-certificate-management.yaml
-rw-r--r-- root/root      2089 2020-12-08 12:16 kubernetes/cluster/addons/rbac/cluster-autoscaler/cluster-autoscaler-rbac.yaml
-rw-r--r-- root/root       338 2020-12-08 12:16 kubernetes/cluster/addons/rbac/kubelet-api-auth/kubelet-api-admin-role.yaml
-rw-r--r-- root/root       427 2020-12-08 12:16 kubernetes/cluster/addons/rbac/kubelet-api-auth/kube-apiserver-kubelet-api-admin-binding.yaml
-rw-r--r-- root/root       647 2020-12-08 12:16 kubernetes/cluster/addons/rbac/cluster-loadbalancing/glbc/user-rolebindings.yaml
-rw-r--r-- root/root      2593 2020-12-08 12:16 kubernetes/cluster/addons/rbac/cluster-loadbalancing/glbc/roles.yaml
-rw-r--r-- root/root      1655 2020-12-08 12:16 kubernetes/cluster/addons/README.md
-rw-r--r-- root/root      2326 2020-12-08 12:16 kubernetes/cluster/log-dump/logexporter-daemonset.yaml
-rw-r--r-- root/root       173 2020-12-08 12:16 kubernetes/cluster/log-dump/OWNERS
-rwxr-xr-x root/root     29094 2020-12-08 12:16 kubernetes/cluster/log-dump/log-dump.sh
-rw-r--r-- root/root      1007 2020-12-08 12:16 kubernetes/cluster/log-dump/README.md
-rwxr-xr-x root/root      2483 2020-12-08 12:16 kubernetes/cluster/kube-up.sh
-rw-r--r-- root/root       331 2020-12-08 12:16 kubernetes/cluster/README.md
-rw-r--r-- root/root      2959 2020-12-08 12:16 kubernetes/hack/lib/protoc.sh
-rwxr-xr-x root/root     25774 2020-12-08 12:16 kubernetes/hack/lib/util.sh
-rw-r--r-- root/root      7345 2020-12-08 12:16 kubernetes/hack/lib/version.sh
-rw-r--r-- root/root     12383 2020-12-08 12:16 kubernetes/hack/lib/test.sh
-rw-r--r-- root/root      4443 2020-12-08 12:16 kubernetes/hack/lib/logging.sh
-rwxr-xr-x root/root      5406 2020-12-08 12:16 kubernetes/hack/lib/etcd.sh
-rw-r--r-- root/root      2313 2020-12-08 12:16 kubernetes/hack/lib/swagger.sh
-rwxr-xr-x root/root     29049 2020-12-08 12:16 kubernetes/hack/lib/golang.sh
-rw-r--r-- root/root       502 2020-12-08 12:16 kubernetes/hack/lib/BUILD
-rwxr-xr-x root/root      5694 2020-12-08 12:16 kubernetes/hack/lib/init.sh
-rw-r--r-- root/root        24 2020-12-08 12:16 kubernetes/hack/lib/.gitattributes
-rw-r--r-- root/root     84317 2020-12-08 12:16 kubernetes/server/kubernetes-manifests.tar.gz
-rw-r--r-- root/root       153 2020-12-08 12:16 kubernetes/server/README
-rw-r--r-- root/root         8 2020-12-08 12:16 kubernetes/version
-rw-r--r-- root/root      3386 2020-12-08 12:16 kubernetes/README.md
-rw-r--r-- root/root     11596 2020-12-08 12:16 kubernetes/LICENSES/LICENSE
-rw-r--r-- root/root        78 2020-12-08 12:16 kubernetes/LICENSES/OWNERS
-rw-r--r-- root/root     11492 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.mongodb.org/mongo-driver/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:16 kubernetes/LICENSES/vendor/google.golang.org/appengine/LICENSE
-rw-r--r-- root/root     11483 2020-12-08 12:16 kubernetes/LICENSES/vendor/google.golang.org/grpc/LICENSE
-rw-r--r-- root/root      1612 2020-12-08 12:16 kubernetes/LICENSES/vendor/google.golang.org/protobuf/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:16 kubernetes/LICENSES/vendor/google.golang.org/api/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:16 kubernetes/LICENSES/vendor/google.golang.org/genproto/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:16 kubernetes/LICENSES/vendor/bitbucket.org/bertimus9/systemstat/LICENSE
-rw-r--r-- root/root     11469 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.etcd.io/etcd/LICENSE
-rw-r--r-- root/root      1191 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.etcd.io/bbolt/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/oauth2/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/net/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/text/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/sys/LICENSE
-rw-r--r-- root/root      1596 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/tools/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/time/LICENSE
-rw-r--r-- root/root      1598 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/crypto/LICENSE
-rw-r--r-- root/root      1600 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/xerrors/LICENSE
-rw-r--r-- root/root      1592 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/mod/LICENSE
-rw-r--r-- root/root      1594 2020-12-08 12:16 kubernetes/LICENSES/vendor/golang.org/x/sync/LICENSE
-rw-r--r-- root/root     11477 2020-12-08 12:16 kubernetes/LICENSES/vendor/cloud.google.com/go/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.uber.org/zap/LICENSE
-rw-r--r-- root/root      1192 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.uber.org/multierr/LICENSE
-rw-r--r-- root/root      1188 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.uber.org/atomic/LICENSE
-rw-r--r-- root/root      2670 2020-12-08 12:16 kubernetes/LICENSES/vendor/sigs.k8s.io/yaml/LICENSE
-rw-r--r-- root/root     11480 2020-12-08 12:16 kubernetes/LICENSES/vendor/sigs.k8s.io/kustomize/LICENSE
-rw-r--r-- root/root     11548 2020-12-08 12:16 kubernetes/LICENSES/vendor/sigs.k8s.io/apiserver-network-proxy/konnectivity-client/LICENSE
-rw-r--r-- root/root     11510 2020-12-08 12:16 kubernetes/LICENSES/vendor/sigs.k8s.io/structured-merge-diff/v4/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:16 kubernetes/LICENSES/vendor/go.opencensus.io/LICENSE
-rw-r--r-- root/root      1647 2020-12-08 12:16 kubernetes/LICENSES/vendor/gonum.org/v1/gonum/LICENSE
-rw-r--r-- root/root      1637 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/gcfg.v1/LICENSE
-rw-r--r-- root/root      1396 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/warnings.v0/LICENSE
-rw-r--r-- root/root      1222 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/natefinch/lumberjack.v2/LICENSE
-rw-r--r-- root/root      1721 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/tomb.v1/LICENSE
-rw-r--r-- root/root      1658 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/fsnotify.v1/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/square/go-jose.v2/LICENSE
-rw-r--r-- root/root     10364 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/ini.v1/LICENSE
-rw-r--r-- root/root      1635 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/inf.v0/LICENSE
-rw-r--r-- root/root      2264 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/yaml.v3/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:16 kubernetes/LICENSES/vendor/gopkg.in/yaml.v2/LICENSE
-rw-r--r-- root/root      1227 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/asaskevich/govalidator/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/go-grpc-prometheus/LICENSE
-rw-r--r-- root/root      1672 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/grpc-gateway/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/grpc-ecosystem/go-grpc-middleware/LICENSE
-rw-r--r-- root/root      2516 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/storageos/go-api/LICENSE
-rw-r--r-- root/root     11470 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/thecodeteam/goscaleio/LICENSE
-rw-r--r-- root/root      1212 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Microsoft/hcsshim/LICENSE
-rw-r--r-- root/root      1216 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Microsoft/go-winio/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/subosito/gotenv/LICENSE
-rw-r--r-- root/root      1190 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mailru/easyjson/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/cespare/xxhash/v2/LICENSE
-rw-r--r-- root/root      1213 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/satori/go.uuid/LICENSE
-rw-r--r-- root/root     11500 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/modern-go/concurrent/LICENSE
-rw-r--r-- root/root     11496 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/modern-go/reflect2/LICENSE
-rw-r--r-- root/root     11465 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/jonboulle/clockwork/LICENSE
-rw-r--r-- root/root     11501 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/pquerna/cachecontrol/LICENSE
-rw-r--r-- root/root       704 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/inconshreveable/mousetrap/LICENSE
-rw-r--r-- root/root     10894 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/docker/docker/LICENSE
-rw-r--r-- root/root     10900 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/docker/spdystream/LICENSE
-rw-r--r-- root/root     11466 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/docker/distribution/LICENSE
-rw-r--r-- root/root     10905 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/docker/go-connections/LICENSE
-rw-r--r-- root/root     10893 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/docker/go-units/LICENSE
-rw-r--r-- root/root      1613 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/golang/protobuf/LICENSE
-rw-r--r-- root/root     11483 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/golang/mock/LICENSE
-rw-r--r-- root/root     10410 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/golang/groupcache/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/morikuni/aec/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/swag/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/strfmt/LICENSE
-rw-r--r-- root/root     11509 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/jsonreference/LICENSE
-rw-r--r-- root/root     11497 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/runtime/LICENSE
-rw-r--r-- root/root     11491 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/spec/LICENSE
-rw-r--r-- root/root     11505 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/jsonpointer/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/loads/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/validate/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/errors/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-openapi/analysis/LICENSE
-rw-r--r-- root/root      1207 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/tmc/grpc-websocket-proxy/LICENSE
-rw-r--r-- root/root     11524 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/container-storage-interface/spec/LICENSE
-rw-r--r-- root/root      1212 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-stack/stack/LICENSE
-rw-r--r-- root/root      1201 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/peterbourgon/diskv/LICENSE
-rw-r--r-- root/root      1216 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/emicklei/go-restful/LICENSE
-rw-r--r-- root/root      1618 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/PuerkitoBio/urlesc/LICENSE
-rw-r--r-- root/root      1610 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/PuerkitoBio/purell/LICENSE
-rw-r--r-- root/root      1233 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mitchellh/go-wordwrap/LICENSE
-rw-r--r-- root/root      1232 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mitchellh/mapstructure/LICENSE
-rw-r--r-- root/root      1209 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/xiang90/probing/LICENSE
-rw-r--r-- root/root     10901 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/clusterhq/flocker-go/LICENSE
-rw-r--r-- root/root     11537 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/GoogleCloudPlatform/k8s-cloud-provider/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/aws/aws-sdk-go/LICENSE
-rw-r--r-- root/root      1217 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/robfig/cron/LICENSE
-rw-r--r-- root/root     11500 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/euank/go-kmsg-parser/LICENSE
-rw-r--r-- root/root      1211 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/rubiojr/go-vhd/LICENSE
-rw-r--r-- root/root      1514 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/seccomp/libseccomp-golang/LICENSE
-rw-r--r-- root/root      2682 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/ghodss/yaml/LICENSE
-rw-r--r-- root/root     11498 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/caddyserver/caddy/LICENSE
-rw-r--r-- root/root     10933 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/vishvananda/netns/LICENSE
-rw-r--r-- root/root     10937 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/vishvananda/netlink/LICENSE
-rw-r--r-- root/root      1679 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/fsnotify/fsnotify/LICENSE
-rw-r--r-- root/root      1236 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/shurcooL/sanitized_anchor_name/LICENSE
-rw-r--r-- root/root     11468 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mistifyio/go-zfs/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/sirupsen/logrus/LICENSE
-rw-r--r-- root/root      1616 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/liggitt/tabwriter/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/karrick/godirwalk/LICENSE
-rw-r--r-- root/root      1607 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/willf/bitset/LICENSE
-rw-r--r-- root/root      1608 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/google/go-cmp/LICENSE
-rw-r--r-- root/root      1605 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/google/uuid/LICENSE
-rw-r--r-- root/root     11485 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/google/btree/LICENSE
-rw-r--r-- root/root     10898 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/google/cadvisor/LICENSE
-rw-r--r-- root/root     11487 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/google/gofuzz/LICENSE
-rw-r--r-- root/root      1736 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/miekg/dns/LICENSE
-rw-r--r-- root/root     11504 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/opencontainers/selinux/LICENSE
-rw-r--r-- root/root     10899 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/opencontainers/runc/LICENSE
-rw-r--r-- root/root     10952 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/opencontainers/go-digest/LICENSE
-rw-r--r-- root/root     10920 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/opencontainers/image-spec/LICENSE
-rw-r--r-- root/root     10924 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/opencontainers/runtime-spec/LICENSE
-rw-r--r-- root/root     11512 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/coredns/corefile-migration/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/godbus/dbus/v5/LICENSE
-rw-r--r-- root/root     11456 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/coreos/go-oidc/LICENSE
-rw-r--r-- root/root     10410 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/coreos/go-systemd/LICENSE
-rw-r--r-- root/root     10414 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/coreos/go-systemd/v22/LICENSE
-rw-r--r-- root/root     11448 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/coreos/pkg/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/coreos/go-semver/LICENSE
-rw-r--r-- root/root      1193 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/dgrijalva/jwt-go/LICENSE
-rw-r--r-- root/root     10917 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/libopenstorage/openstorage/LICENSE
-rw-r--r-- root/root      1449 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/gorilla/websocket/LICENSE
-rw-r--r-- root/root      1563 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/russross/blackfriday/LICENSE
-rw-r--r-- root/root      1566 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/russross/blackfriday/v2/LICENSE
-rw-r--r-- root/root      1542 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/JeffAshton/win_pdh/LICENSE
-rw-r--r-- root/root      1640 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/chai2010/gettext-go/LICENSE
-rw-r--r-- root/root     11497 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/moby/sys/mountinfo/LICENSE
-rw-r--r-- root/root     10886 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/moby/term/LICENSE
-rw-r--r-- root/root     11446 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/moby/ipvs/LICENSE
-rw-r--r-- root/root     11495 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mindprince/gonvml/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/ishidawataru/sctp/LICENSE
-rw-r--r-- root/root     11518 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/checkpoint-restore/go-criu/v4/LICENSE
-rw-r--r-- root/root      1435 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/pkg/errors/LICENSE
-rw-r--r-- root/root     11484 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-logr/logr/LICENSE
-rw-r--r-- root/root      1230 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/blang/semver/LICENSE
-rw-r--r-- root/root     11534 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/matttproud/golang_protobuf_extensions/LICENSE
-rw-r--r-- root/root      1500 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/magiconair/properties/LICENSE
-rw-r--r-- root/root      1185 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/beorn7/perks/LICENSE
-rw-r--r-- root/root     11499 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/azure-sdk-for-go/LICENSE
-rw-r--r-- root/root     10904 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/LICENSE
-rw-r--r-- root/root     10911 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/logger/LICENSE
-rw-r--r-- root/root     10918 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/adal/LICENSE
-rw-r--r-- root/root     10916 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/to/LICENSE
-rw-r--r-- root/root     10913 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/LICENSE
-rw-r--r-- root/root     10919 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/mocks/LICENSE
-rw-r--r-- root/root     10918 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/date/LICENSE
-rw-r--r-- root/root     10924 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/autorest/validation/LICENSE
-rw-r--r-- root/root     10912 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-autorest/tracing/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/Azure/go-ansiterm/LICENSE
-rw-r--r-- root/root       314 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-bindata/go-bindata/LICENSE
-rw-r--r-- root/root      1201 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/form3tech-oss/jwt-go/LICENSE
-rw-r--r-- root/root       899 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/davecgh/go-spew/LICENSE
-rw-r--r-- root/root      1272 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/hpcloud/tail/LICENSE
-rw-r--r-- root/root      1205 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/json-iterator/go/LICENSE
-rw-r--r-- root/root      2737 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/daviddengcn/go-colortext/LICENSE
-rw-r--r-- root/root      1267 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/cilium/ebpf/LICENSE
-rw-r--r-- root/root      1620 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/elazarl/goproxy/LICENSE
-rw-r--r-- root/root      1230 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/MakeNowJust/heredoc/LICENSE
-rw-r--r-- root/root      1202 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/spf13/cast/LICENSE
-rw-r--r-- root/root     10269 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/spf13/afero/LICENSE
-rw-r--r-- root/root      1656 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/spf13/pflag/LICENSE
-rw-r--r-- root/root      1204 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/spf13/viper/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/spf13/jwalterweatherman/LICENSE
-rw-r--r-- root/root     10269 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/spf13/cobra/LICENSE
-rw-r--r-- root/root      1218 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/fvbommel/sortorder/LICENSE
-rw-r--r-- root/root      1613 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mvdan/xurls/LICENSE
-rw-r--r-- root/root      1698 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/cyphar/filepath-securejoin/LICENSE
-rw-r--r-- root/root      1634 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/evanphx/json-patch/LICENSE
-rw-r--r-- root/root      1614 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/quobyte/api/LICENSE
-rw-r--r-- root/root      1208 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/armon/circbuf/LICENSE
-rw-r--r-- root/root       721 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/NYTimes/gziphandler/LICENSE
-rw-r--r-- root/root     11498 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/googleapis/gnostic/LICENSE
-rw-r--r-- root/root      1614 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/googleapis/gax-go/v2/LICENSE
-rw-r--r-- root/root      1683 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/munnerz/goautoneg/LICENSE
-rw-r--r-- root/root      1227 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/exponent-io/jsonpath/LICENSE
-rw-r--r-- root/root      1202 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mohae/deepcopy/LICENSE
-rw-r--r-- root/root      1294 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/konsorten/go-windows-terminal-sequences/LICENSE
-rw-r--r-- root/root       702 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/jmespath/go-jmespath/LICENSE
-rw-r--r-- root/root      1242 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/pelletier/go-toml/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/onsi/gomega/LICENSE
-rw-r--r-- root/root      1187 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/onsi/ginkgo/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/cpuguy83/go-md2man/v2/LICENSE
-rw-r--r-- root/root      1665 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/imdario/mergo/LICENSE
-rw-r--r-- root/root       389 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/heketi/heketi/LICENSE
-rw-r--r-- root/root      1225 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/go-ozzo/ozzo-validation/LICENSE
-rw-r--r-- root/root      1238 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/stretchr/testify/LICENSE
-rw-r--r-- root/root      1246 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/stretchr/objx/LICENSE
-rw-r--r-- root/root      1215 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/fatih/camelcase/LICENSE
-rw-r--r-- root/root     11493 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/vmware/govmomi/LICENSE
-rw-r--r-- root/root      1459 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/syndtr/gocapability/LICENSE
-rw-r--r-- root/root     10895 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mrunalp/fileutils/LICENSE
-rw-r--r-- root/root     11487 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/soheilhy/cmux/LICENSE
-rw-r--r-- root/root      1275 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/dustin/go-humanize/LICENSE
-rw-r--r-- root/root     11507 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/containernetworking/cni/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/prometheus/common/LICENSE
-rw-r--r-- root/root     11506 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/prometheus/client_model/LICENSE
-rw-r--r-- root/root     11494 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/prometheus/procfs/LICENSE
-rw-r--r-- root/root     11508 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/prometheus/client_golang/LICENSE
-rw-r--r-- root/root     16106 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/hashicorp/hcl/LICENSE
-rw-r--r-- root/root     16064 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/hashicorp/golang-lru/LICENSE
-rw-r--r-- root/root      1584 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/pmezard/go-difflib/LICENSE
-rw-r--r-- root/root     11492 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/containerd/ttrpc/LICENSE
-rw-r--r-- root/root     10904 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/containerd/console/LICENSE
-rw-r--r-- root/root     11496 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/containerd/cgroups/LICENSE
-rw-r--r-- root/root     10910 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/containerd/containerd/LICENSE
-rw-r--r-- root/root      1228 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/gregjones/httpcache/LICENSE
-rw-r--r-- root/root      1647 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/mxk/go-flowrate/LICENSE
-rw-r--r-- root/root     10896 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/gophercloud/gophercloud/LICENSE
-rw-r--r-- root/root      1810 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/gogo/protobuf/LICENSE
-rw-r--r-- root/root      1217 2020-12-08 12:16 kubernetes/LICENSES/vendor/github.com/lithammer/dedent/LICENSE
-rw-r--r-- root/root     11435 2020-12-08 12:16 kubernetes/LICENSES/vendor/k8s.io/heapster/LICENSE
-rw-r--r-- root/root     11486 2020-12-08 12:16 kubernetes/LICENSES/vendor/k8s.io/system-validators/LICENSE
-rw-r--r-- root/root     11477 2020-12-08 12:16 kubernetes/LICENSES/vendor/k8s.io/kube-openapi/LICENSE
-rw-r--r-- root/root     11459 2020-12-08 12:16 kubernetes/LICENSES/vendor/k8s.io/gengo/LICENSE
-rw-r--r-- root/root     10382 2020-12-08 12:16 kubernetes/LICENSES/vendor/k8s.io/klog/v2/LICENSE
-rw-r--r-- root/root     11463 2020-12-08 12:16 kubernetes/LICENSES/vendor/k8s.io/utils/LICENSE
```

</p>
</details>

> Content of `kubernetes-test.tar.gz` and `kubernetes-src.tar.gz` are not present in this document because of the amount of information present inside. First contains content of https://github.com/kubernetes/kubernetes/tree/master/test + some helpers, and the second contains source code of kubernetes.
