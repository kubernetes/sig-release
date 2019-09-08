## Docker Images

|                          	| 386 	| amd64 	| arm 	| arm64 	| ppc64le 	| s390x 	|
|--------------------------	|:---:	|:-----:	|:---:	|:-----:	|:-------:	|:-----:	|
| cloud-controller-manager 	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|
| conformance              	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|
| hyperkube                	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|
| kube-apiserver           	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|
| kube-controller-manager  	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|
| kube-proxy               	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|
| kube-scheduler           	|  ✅  	|   ✅   	|  ✅  	|   ✅   	|    ✅    	|   ✅   	|

Note: starting at 1.16 container images archives for 'amd64' will contain the arch in the name, like 'kube-apiserver-amd64'.
These can be found inside the binaries tar files, in the manifest.json file under "RepoTags".

## Storage

### Binaries

|  | darwin/386 | darwin/amd64 | linux/386 | linux/amd64 | linux/arm | linux/arm64 | linux/ppc64le | linux/s390x | windows/386 | windows/amd64 |
|------------------------|----------|------------|---------|-----------|---------|-----------|-------------|-----------|-----------|-------------|
| apiextensions-apiserver |  |  |  | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 |  |  |
| cloud-controller-manager |  |  |  | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 |  |  |
| hyperkube |  |  |  | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 |  |  |
| kube-apiserver |  |  |  | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 |  |  |
| kube-controller-manager |  |  |  | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 |  |  |
| kube-proxy |  |  |  | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 |  | exe,<br />exe.md5,<br />exe.sha1,<br />exe.sha512 |
| kube-scheduler |  |  |  | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 | [binary_file],<br />docker_tag,<br />docker_tag.md5,<br />docker_tag.sha1,<br />docker_tag.sha512,<br />md5,<br />sha1,<br />sha512,<br />tar,<br />tar.md5,<br />tar.sha1,<br />tar.sha512 |  |  |
| kubeadm |  |  |  | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 |  | exe,<br />exe.md5,<br />exe.sha1,<br />exe.sha512 |
| kubectl | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | exe,<br />exe.md5,<br />exe.sha1,<br />exe.sha512 | exe,<br />exe.md5,<br />exe.sha1,<br />exe.sha512 |
| kubelet |  |  |  | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 |  | exe,<br />exe.md5,<br />exe.sha1,<br />exe.sha512 |
| mounter |  |  |  | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 | [binary_file],<br />md5,<br />sha1,<br />sha512 |  |  |

### Extra files (for GCE)

There are also files: .md5, .sha1, .sha512 for every position below

| File 	|
|-----------------------------	|
| configure.sh 	|
| master.yaml 	|
| node.yaml 	|
| shutdown.sh 	|
|  |
| windows/common.psm1 	|
| windows/configure.ps1 	|
| windows/install-ssh.psm1 	|
| windows/k8s-node-setup.psm1 	|
| windows/user-profile.psm1 	|

### Tar archives

There are also files: .md5, .sha1, .sha512 for every position below

| File&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | darwin/386 | darwin/amd64 | linux/386 | linux/amd64 | linux/arm | linux/arm64 | linux/ppc64le | linux/s390x | windows/386 | windows/amd64 | portable |
|----|:----------:|:------------:|:---------:|:-----------:|:---------:|:-----------:|:-------------:|:-----------:|:------------:|:-------------:|:--------:|
| kubernetes-client-**[system-arch]**.tar.gz | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |
| kubernetes-node-**[system-arch]**.tar.gz |  |  |  | ✅ | ✅ | ✅ | ✅ | ✅ |  | ✅ |  |
| kubernetes-server-**[system-arch]**.tar.gz |  |  |  | ✅ | ✅ | ✅ | ✅ | ✅ |  |  |  |
| kubernetes-test-**[system-arch]**.tar.gz |  | ✅ |  | ✅ | ✅ | ✅ | ✅ | ✅ |  | ✅ | ✅ |
|  |  |  |  |  |  |  |  |  |  |  |  |
| kubernetes-manifests.tar.gz |  |  |  |  |  |  |  |  |  |  |  |
| kubernetes-test.tar.gz |  |  |  |  |  |  |  |  |  |  |  |
| kubernetes-src.tar.gz |  |  |  |  |  |  |  |  |  |  |  |
| kubernetes.tar.gz |  |  |  |  |  |  |  |  |  |  |  |

### Other (uncategorized) files

| File 	|
|-----------------------------	|
| release/latest-1.16.txt |
| release/latest-1.txt |
| release/latest.txt |

Files in directory: **archive**

Comment: It looks like in the directory: **archive** we can find:
- copy of **anago** (script used for building artifacts)
- shallow copy of kubernetes repository

Staged files
It looks like all staged files vere copied to release directory, but please be aware there was no effort taken to compare them.

## Packages

### RPMs
|  	| aarch64 	| armhfp 	| ppc64le 	| s390x 	| x86_64 	|
|------------------------------------------	|:-------:	|:------:	|:-------:	|:-----:	|:------:	|
| cri-tools-**[k8s-version]**.**[arch]**.rpm 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| kubectl-**[k8s-version]**.**[arch]**.rpm 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| kubernetes-cni-**[cni-version]**.**[arch]**.rpm 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| kubeadm-**[k8s-version]**.**[arch]**.rpm 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| kubelet-**[k8s-version]**.**[arch]**.rpm 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
|  	|  	|  	|  	|  	|  	|
| repodata/**[checksum]**-primary.sqlite.bz2 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| repodata/**[checksum]**-filelists.sqlite.bz2 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| repodata/**[checksum]**-primary.xml.gz 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| repodata/**[checksum]**-other.sqlite.bz2 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| repodata/**[checksum]**-other.xml.gz 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| repodata/**[checksum]**-filelists.xml.gz 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|
| repodata/repomd.xml 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	| ✅ 	|

### Debs
| File&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | amd64 | arm64 | armhf | ppc64el | s390x |
|---|-----|-----|-----|-------|-----|
| cri-tools_**[cri-tools-version]**_**[arch]**.deb | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubeadm_**[k8s-version]**_**[arch]**.deb | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubectl_**[k8s-version]**_**[arch]**.deb | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubelet_**[k8s-version]**_**[arch]**.deb | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |
| kubernetes-cni_**[k8s-cni-version]**_**[arch]**.deb | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial | nightly/bionic<br />nightly/jessie<br />nightly/sid<br />nightly/stretch<br />nightly/trusty<br />nightly/xenial<br /><br />stable/bionic<br />stable/jessie<br />stable/sid<br />stable/stretch<br />stable/trusty<br />stable/xenial<br /><br />unstable/bionic<br />unstable/jessie<br />unstable/sid<br />unstable/stretch<br />unstable/trusty<br />unstable/xenial |

### Contents of tar archives

##### Content of `kubernetes-client-[system-arch].tar.gz` on example of `kubernetes-client-linux-386.tar.gz` (directories removed from list):
```
➜ $ tar -ztvf kubernetes-client-linux-386.tar.gz
-rwxr-xr-x  0 root   root 37748128 Jul  5 16:26 kubernetes/client/bin/kubectl
```

##### Content of `kubernetes-node-[system-arch].tar.gz` on example of `kubernetes-node-linux-amd64.tar.gz` (directories removed from list):
```
➜ $ tar -ztvf kubernetes-node-linux-amd64.tar.gz
-rwxr-xr-x  0 root   root 39313856 Jul  5 16:26 kubernetes/node/bin/kubeadm
-rwxr-xr-x  0 root   root 36692480 Jul  5 16:26 kubernetes/node/bin/kube-proxy
-rwxr-xr-x  0 root   root 43035584 Jul  5 16:26 kubernetes/node/bin/kubectl
-rwxr-xr-x  0 root   root 113803872 Jul  5 16:26 kubernetes/node/bin/kubelet
-rw-r--r--  0 root   root   1171762 Jul  5 16:26 kubernetes/LICENSES
-rw-r--r--  0 root   root  29150046 Jul  5 16:26 kubernetes/kubernetes-src.tar.gz
```

##### Content of `kubernetes-server-[system-arch].tar.gz` on example of `kubernetes-server-linux-amd64.tar.gz` (directories removed from list):
```
➜ $ tar -ztvf kubernetes-server-linux-amd64.tar.gz
-rwxr-xr-x  0 root   root 110018784 Jul  5 16:30 kubernetes/server/bin/kube-controller-manager
-rw-r--r--  0 root   root 138259968 Jul  5 16:27 kubernetes/server/bin/cloud-controller-manager.tar
-rwxr-xr-x  0 root   root  39313856 Jul  5 16:30 kubernetes/server/bin/kubeadm
-rwxr-xr-x  0 root   root 195544384 Jul  5 16:30 kubernetes/server/bin/hyperkube
-rw-r--r--  0 root   root        16 Jul  5 16:27 kubernetes/server/bin/cloud-controller-manager.docker_tag
-rw-r--r--  0 root   root        16 Jul  5 16:27 kubernetes/server/bin/kube-apiserver.docker_tag
-rw-r--r--  0 root   root        16 Jul  5 16:27 kubernetes/server/bin/kube-scheduler.docker_tag
-rw-r--r--  0 root   root 153907712 Jul  5 16:27 kubernetes/server/bin/kube-controller-manager.tar
-rwxr-xr-x  0 root   root  38884704 Jul  5 16:30 kubernetes/server/bin/kube-scheduler
-rw-r--r--  0 root   root 203098112 Jul  5 16:27 kubernetes/server/bin/kube-apiserver.tar
-rw-r--r--  0 root   root        16 Jul  5 16:27 kubernetes/server/bin/kube-proxy.docker_tag
-rwxr-xr-x  0 root   root 159209248 Jul  5 16:30 kubernetes/server/bin/kube-apiserver
-rwxr-xr-x  0 root   root  36692480 Jul  5 16:30 kubernetes/server/bin/kube-proxy
-rwxr-xr-x  0 root   root  43035584 Jul  5 16:30 kubernetes/server/bin/kubectl
-rw-r--r--  0 root   root  83986944 Jul  5 16:27 kubernetes/server/bin/kube-proxy.tar
-rwxr-xr-x  0 root   root   1648224 Jul  5 16:30 kubernetes/server/bin/mounter
-rwxr-xr-x  0 root   root  94371200 Jul  5 16:30 kubernetes/server/bin/cloud-controller-manager
-rw-r--r--  0 root   root        16 Jul  5 16:27 kubernetes/server/bin/kube-controller-manager.docker_tag
-rw-r--r--  0 root   root  82773504 Jul  5 16:27 kubernetes/server/bin/kube-scheduler.tar
-rwxr-xr-x  0 root   root  43653824 Jul  5 16:30 kubernetes/server/bin/apiextensions-apiserver
-rwxr-xr-x  0 root   root 113803872 Jul  5 16:30 kubernetes/server/bin/kubelet
-rw-r--r--  0 root   root   1171762 Jul  5 16:30 kubernetes/LICENSES
-rw-r--r--  0 root   root  29150046 Jul  5 16:30 kubernetes/kubernetes-src.tar.gz
```

##### Content of `kubernetes-test-[system-arch].tar.gz` on example of `kubernetes-test-linux-amd64.tar.gz` (directories removed from list):
```
➜ $ tar -ztvf kubernetes-test-linux-amd64.tar.gz
-rwxr-xr-x  0 root   root 199571040 Jul  5 16:37 kubernetes/test/bin/genman
-rwxr-xr-x  0 root   root  42366560 Jul  5 16:37 kubernetes/test/bin/gendocs
-rwxr-xr-x  0 root   root 178091560 Jul  5 16:37 kubernetes/test/bin/e2e_node.test
-rwxr-xr-x  0 root   root 192029152 Jul  5 16:37 kubernetes/test/bin/genkubedocs
-rwxr-xr-x  0 root   root   5483328 Jul  5 16:37 kubernetes/test/bin/linkcheck
-rwxr-xr-x  0 root   root   4093952 Jul  5 16:37 kubernetes/test/bin/genswaggertypedocs
-rwxr-xr-x  0 root   root 124288648 Jul  5 16:37 kubernetes/test/bin/e2e.test
-rwxr-xr-x  0 root   root   8814784 Jul  5 16:37 kubernetes/test/bin/ginkgo
-rwxr-xr-x  0 root   root  42358368 Jul  5 16:37 kubernetes/test/bin/genyaml
-rwxr-xr-x  0 root   root 110000664 Jul  5 16:37 kubernetes/test/bin/kubemark
```

##### Content of `kubernetes-manifests.tar.gz` (directories removed from list):
```
➜ $ tar -ztvf kubernetes-manifests.tar.gz
-rw-r--r--  0 root   root      425 Jul  5 16:05 kubernetes/gci-trusty/ip-masq-agent/podsecuritypolicies/ip-masq-agent-psp-binding.yaml
-rw-r--r--  0 root   root     1857 Jul  5 16:05 kubernetes/gci-trusty/ip-masq-agent/ip-masq-agent.yaml
-rw-r--r--  0 root   root     1289 Jul  5 16:26 kubernetes/gci-trusty/abac-authz-policy.jsonl
-rw-r--r--  0 root   root     1116 Jul  5 16:05 kubernetes/gci-trusty/cluster-loadbalancing/glbc/default-svc-controller.yaml
-rw-r--r--  0 root   root      577 Jul  5 16:05 kubernetes/gci-trusty/cluster-loadbalancing/glbc/default-svc.yaml
-rw-r--r--  0 root   root     5746 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-node-daemonset.yaml
-rw-r--r--  0 root   root     2078 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-deployment.yaml
-rw-r--r--  0 root   root      185 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-serviceaccount.yaml
-rw-r--r--  0 root   root      378 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/hostendpoints-crd.yaml
-rw-r--r--  0 root   root      394 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/globalnetworksets-crd.yaml
-rw-r--r--  0 root   root      189 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-serviceaccount.yaml
-rw-r--r--  0 root   root      354 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/ippool-crd.yaml
-rw-r--r--  0 root   root      408 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/globalnetworkpolicy-crd.yaml
-rw-r--r--  0 root   root      259 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-clusterrole.yaml
-rw-r--r--  0 root   root     1145 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-node-vertical-autoscaler-deployment.yaml
-rw-r--r--  0 root   root      398 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/globalfelixconfig-crd.yaml
-rw-r--r--  0 root   root      451 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-node-vertical-autoscaler-configmap.yaml
-rw-r--r--  0 root   root      394 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/bgpconfigurations-crd.yaml
-rw-r--r--  0 root   root      452 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-configmap.yaml
-rw-r--r--  0 root   root      402 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/felixconfigurations-crd.yaml
-rw-r--r--  0 root   root      189 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-serviceaccount.yaml
-rw-r--r--  0 root   root      456 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-configmap.yaml
-rw-r--r--  0 root   root      411 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/podsecuritypolicies/calico-node-psp-binding.yaml
-rw-r--r--  0 root   root      377 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-role.yaml
-rw-r--r--  0 root   root     1153 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-deployment.yaml
-rw-r--r--  0 root   root      345 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-clusterrolebinding.yaml
-rw-r--r--  0 root   root      374 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-rolebinding.yaml
-rw-r--r--  0 root   root      356 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-service.yaml
-rw-r--r--  0 root   root      363 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-clusterrolebinding.yaml
-rw-r--r--  0 root   root      402 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/clusterinformations-crd.yaml
-rw-r--r--  0 root   root      363 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-clusterrolebinding.yaml
-rw-r--r--  0 root   root      364 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-cpva-clusterrole.yaml
-rw-r--r--  0 root   root     1650 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-clusterrole.yaml
-rw-r--r--  0 root   root      390 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/globalbgpconfig-crd.yaml
-rw-r--r--  0 root   root     1137 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-horizontal-autoscaler-deployment.yaml
-rw-r--r--  0 root   root      387 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/networkpolicies-crd.yaml
-rw-r--r--  0 root   root      190 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-cpva-serviceaccount.yaml
-rw-r--r--  0 root   root      366 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/calico-cpva-clusterrolebinding.yaml
-rw-r--r--  0 root   root      349 Jul  5 16:05 kubernetes/gci-trusty/calico-policy-controller/typha-vertical-autoscaler-clusterrole.yaml
-rw-r--r--  0 root   root      427 Jul  5 16:05 kubernetes/gci-trusty/metadata-proxy/gce/podsecuritypolicies/metadata-proxy-psp-binding.yaml
-rw-r--r--  0 root   root     2768 Jul  5 16:05 kubernetes/gci-trusty/metadata-proxy/gce/metadata-proxy.yaml
-rw-r--r--  0 root   root     3368 Jul  5 16:05 kubernetes/gci-trusty/dns-horizontal-autoscaler/dns-horizontal-autoscaler.yaml
-rw-r--r--  0 root   root     2508 Jul  5 16:05 kubernetes/gci-trusty/node-termination-handler/daemonset.yaml
-rw-r--r--  0 root   root      398 Jul  5 16:05 kubernetes/gci-trusty/metrics-server/auth-delegator.yaml
-rw-r--r--  0 root   root      801 Jul  5 16:05 kubernetes/gci-trusty/metrics-server/resource-reader.yaml
-rw-r--r--  0 root   root      336 Jul  5 16:05 kubernetes/gci-trusty/metrics-server/metrics-server-service.yaml
-rw-r--r--  0 root   root      388 Jul  5 16:05 kubernetes/gci-trusty/metrics-server/metrics-apiservice.yaml
-rw-r--r--  0 root   root      419 Jul  5 16:05 kubernetes/gci-trusty/metrics-server/auth-reader.yaml
-rw-r--r--  0 root   root     3255 Jul  5 16:05 kubernetes/gci-trusty/metrics-server/metrics-server-deployment.yaml
-rw-r--r--  0 root   root      456 Jul  5 16:26 kubernetes/gci-trusty/etcd-empty-dir-cleanup.yaml
-rw-r--r--  0 root   root     3394 Jul  5 16:26 kubernetes/gci-trusty/etcd.manifest
-rw-r--r--  0 root   root     2275 Jul  5 16:05 kubernetes/gci-trusty/rbac/cluster-loadbalancing/glbc/roles.yaml
-rw-r--r--  0 root   root      647 Jul  5 16:05 kubernetes/gci-trusty/rbac/cluster-loadbalancing/glbc/user-rolebindings.yaml
-rw-r--r--  0 root   root      782 Jul  5 16:05 kubernetes/gci-trusty/rbac/legacy-kubelet-user-disable/kubelet-binding.yaml
-rw-r--r--  0 root   root      565 Jul  5 16:05 kubernetes/gci-trusty/rbac/legacy-kubelet-user/kubelet-binding.yaml
-rw-r--r--  0 root   root     2059 Jul  5 16:05 kubernetes/gci-trusty/rbac/cluster-autoscaler/cluster-autoscaler-rbac.yaml
-rw-r--r--  0 root   root      338 Jul  5 16:05 kubernetes/gci-trusty/rbac/kubelet-api-auth/kubelet-api-admin-role.yaml
-rw-r--r--  0 root   root      427 Jul  5 16:05 kubernetes/gci-trusty/rbac/kubelet-api-auth/kube-apiserver-kubelet-api-admin-binding.yaml
-rw-r--r--  0 root   root     1399 Jul  5 16:05 kubernetes/gci-trusty/rbac/kubelet-cert-rotation/kubelet-certificate-management.yaml
-rw-r--r--  0 root   root      397 Jul  5 16:05 kubernetes/gci-trusty/node-problem-detector/standalone/npd-binding.yaml
-rw-r--r--  0 root   root      423 Jul  5 16:05 kubernetes/gci-trusty/node-problem-detector/podsecuritypolicies/npd-psp-binding.yaml
-rw-r--r--  0 root   root     2418 Jul  5 16:05 kubernetes/gci-trusty/node-problem-detector/npd.yaml
-rw-r--r--  0 root   root     4721 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/googleinfluxdb/heapster-controller-combined.yaml
-rw-r--r--  0 root   root      492 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/influxdb/grafana-service.yaml
-rw-r--r--  0 root   root     2738 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/influxdb/influxdb-grafana-controller.yaml
-rw-r--r--  0 root   root      302 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/influxdb/heapster-service.yaml
-rw-r--r--  0 root   root      393 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/influxdb/influxdb-service.yaml
-rw-r--r--  0 root   root     4712 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/influxdb/heapster-controller.yaml
-rw-r--r--  0 root   root     1123 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/heapster-rbac.yaml
-rw-r--r--  0 root   root      302 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/stackdriver/heapster-service.yaml
-rw-r--r--  0 root   root     4221 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/stackdriver/heapster-controller.yaml
-rw-r--r--  0 root   root      302 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/standalone/heapster-service.yaml
-rw-r--r--  0 root   root     3009 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/standalone/heapster-controller.yaml
-rw-r--r--  0 root   root      302 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/google/heapster-service.yaml
-rw-r--r--  0 root   root     4632 Jul  5 16:05 kubernetes/gci-trusty/cluster-monitoring/google/heapster-controller.yaml
-rw-r--r--  0 root   root     4619 Jul  5 16:05 kubernetes/gci-trusty/dns/coredns/coredns.yaml.in
-rw-r--r--  0 root   root     6451 Jul  5 16:05 kubernetes/gci-trusty/dns/kube-dns/kube-dns.yaml.in
-rw-r--r--  0 root   root     3922 Jul  5 16:05 kubernetes/gci-trusty/dns/nodelocaldns/nodelocaldns.yaml
-rw-r--r--  0 root   root      166 Jul  5 16:05 kubernetes/gci-trusty/limit-range/limit-range.yaml
-rw-r--r--  0 root   root     4037 Jul  5 16:26 kubernetes/gci-trusty/kube-apiserver.manifest
-rw-r--r--  0 root   root     1457 Jul  5 16:05 kubernetes/gci-trusty/loadbalancing/cloud-provider-role.yaml
-rw-r--r--  0 root   root      685 Jul  5 16:05 kubernetes/gci-trusty/loadbalancing/cloud-provider-binding.yaml
-rw-r--r--  0 root   root     2183 Jul  5 16:05 kubernetes/gci-trusty/prometheus/alertmanager-deployment.yaml
-rw-r--r--  0 root   root      319 Jul  5 16:05 kubernetes/gci-trusty/prometheus/alertmanager-pvc.yaml
-rw-r--r--  0 root   root     2239 Jul  5 16:05 kubernetes/gci-trusty/prometheus/kube-state-metrics-rbac.yaml
-rw-r--r--  0 root   root      371 Jul  5 16:05 kubernetes/gci-trusty/prometheus/alertmanager-service.yaml
-rw-r--r--  0 root   root     3063 Jul  5 16:05 kubernetes/gci-trusty/prometheus/prometheus-statefulset.yaml
-rw-r--r--  0 root   root      402 Jul  5 16:05 kubernetes/gci-trusty/prometheus/alertmanager-configmap.yaml
-rw-r--r--  0 root   root     5440 Jul  5 16:05 kubernetes/gci-trusty/prometheus/prometheus-configmap.yaml
-rw-r--r--  0 root   root     1069 Jul  5 16:05 kubernetes/gci-trusty/prometheus/prometheus-rbac.yaml
-rw-r--r--  0 root   root      424 Jul  5 16:05 kubernetes/gci-trusty/prometheus/node-exporter-service.yaml
-rw-r--r--  0 root   root      347 Jul  5 16:05 kubernetes/gci-trusty/prometheus/prometheus-service.yaml
-rw-r--r--  0 root   root      506 Jul  5 16:05 kubernetes/gci-trusty/prometheus/kube-state-metrics-service.yaml
-rw-r--r--  0 root   root     2379 Jul  5 16:05 kubernetes/gci-trusty/prometheus/kube-state-metrics-deployment.yaml
-rw-r--r--  0 root   root     1577 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/unprivileged-addon.yaml
-rw-r--r--  0 root   root      572 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/persistent-volume-binder-role.yaml
-rw-r--r--  0 root   root      742 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/node-binding.yaml
-rw-r--r--  0 root   root      535 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/kube-system-binding.yaml
-rw-r--r--  0 root   root      643 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/persistent-volume-binder-binding.yaml
-rw-r--r--  0 root   root      364 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/unprivileged-addon-role.yaml
-rw-r--r--  0 root   root      330 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/privileged-role.yaml
-rw-r--r--  0 root   root      791 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/privileged.yaml
-rw-r--r--  0 root   root      425 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/kube-proxy-binding.yaml
-rw-r--r--  0 root   root      878 Jul  5 16:05 kubernetes/gci-trusty/podsecuritypolicies/persistent-volume-binder.yaml
-rw-r--r--  0 root   root      551 Jul  5 16:05 kubernetes/gci-trusty/dashboard/dashboard-secret.yaml
-rw-r--r--  0 root   root      322 Jul  5 16:05 kubernetes/gci-trusty/dashboard/dashboard-service.yaml
-rw-r--r--  0 root   root     1353 Jul  5 16:05 kubernetes/gci-trusty/dashboard/dashboard-rbac.yaml
-rw-r--r--  0 root   root      264 Jul  5 16:05 kubernetes/gci-trusty/dashboard/dashboard-configmap.yaml
-rw-r--r--  0 root   root     1780 Jul  5 16:05 kubernetes/gci-trusty/dashboard/dashboard-controller.yaml
-rw-r--r--  0 root   root     3513 Jul  5 16:26 kubernetes/gci-trusty/cluster-autoscaler.manifest
-rw-r--r--  0 root   root      354 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/kibana-service.yaml
-rw-r--r--  0 root   root      382 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/es-service.yaml
-rw-r--r--  0 root   root     1321 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/kibana-deployment.yaml
-rw-r--r--  0 root   root     2492 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/fluentd-es-ds.yaml
-rw-r--r--  0 root   root      399 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/podsecuritypolicies/es-psp-binding.yaml
-rw-r--r--  0 root   root     2624 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/es-statefulset.yaml
-rw-r--r--  0 root   root    16124 Jul  5 16:05 kubernetes/gci-trusty/fluentd-elasticsearch/fluentd-es-configmap.yaml
-rw-r--r--  0 root   root      488 Jul  5 16:05 kubernetes/gci-trusty/kube-proxy/kube-proxy-rbac.yaml
-rw-r--r--  0 root   root     2060 Jul  5 16:05 kubernetes/gci-trusty/kube-proxy/kube-proxy-ds.yaml
-rw-r--r--  0 root   root     4512 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-ds.yaml
-rw-r--r--  0 root   root     1015 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/scaler-rbac.yaml
-rw-r--r--  0 root   root      323 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/scaler-policy.yaml
-rw-r--r--  0 root   root    16675 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-configmap-old.yaml
-rw-r--r--  0 root   root      190 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-ds-sa.yaml
-rw-r--r--  0 root   root     1281 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/event-exporter-psp.yaml
-rw-r--r--  0 root   root      356 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/event-exporter-psp-role.yaml
-rw-r--r--  0 root   root     1189 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp.yaml
-rw-r--r--  0 root   root      427 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/event-exporter-psp-binding.yaml
-rw-r--r--  0 root   root      350 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-role.yaml
-rw-r--r--  0 root   root      415 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-binding.yaml
-rw-r--r--  0 root   root      968 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/scaler-deployment.yaml
-rw-r--r--  0 root   root     2329 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/event-exporter.yaml
-rw-r--r--  0 root   root    18765 Jul  5 16:05 kubernetes/gci-trusty/fluentd-gcp/fluentd-gcp-configmap.yaml
-rw-r--r--  0 root   root     2698 Jul  5 16:26 kubernetes/gci-trusty/kube-controller-manager.manifest
-rw-r--r--  0 root   root      685 Jul  5 16:05 kubernetes/gci-trusty/metadata-agent/stackdriver/metadata-agent-rbac.yaml
-rw-r--r--  0 root   root      433 Jul  5 16:05 kubernetes/gci-trusty/metadata-agent/stackdriver/podsecuritypolicies/metadata-agent-psp-binding.yaml
-rw-r--r--  0 root   root     3493 Jul  5 16:05 kubernetes/gci-trusty/metadata-agent/stackdriver/metadata-agent.yaml
-rw-r--r--  0 root   root     2464 Jul  5 16:26 kubernetes/gci-trusty/glbc.manifest
-rw-r--r--  0 root   root     1493 Jul  5 16:26 kubernetes/gci-trusty/kube-scheduler.manifest
-rw-r--r--  0 root   root     1658 Jul  5 16:05 kubernetes/gci-trusty/device-plugins/nvidia-gpu/daemonset.yaml
-rw-r--r--  0 root   root     1315 Jul  5 16:26 kubernetes/gci-trusty/kube-addon-manager.yaml
-rw-r--r--  0 root   root   121915 Jul  5 16:26 kubernetes/gci-trusty/gci-configure-helper.sh
-rw-r--r--  0 root   root     2149 Jul  5 16:26 kubernetes/gci-trusty/kube-proxy.manifest
-rw-r--r--  0 root   root      261 Jul  5 16:05 kubernetes/gci-trusty/storage-class/aws/default.yaml
-rw-r--r--  0 root   root      269 Jul  5 16:05 kubernetes/gci-trusty/storage-class/local/default.yaml
-rw-r--r--  0 root   root      241 Jul  5 16:05 kubernetes/gci-trusty/storage-class/openstack/default.yaml
-rw-r--r--  0 root   root      245 Jul  5 16:05 kubernetes/gci-trusty/storage-class/azure/default.yaml
-rw-r--r--  0 root   root      228 Jul  5 16:05 kubernetes/gci-trusty/storage-class/vsphere/default.yaml
-rw-r--r--  0 root   root      300 Jul  5 16:05 kubernetes/gci-trusty/storage-class/gce/default.yaml
-rw-r--r--  0 root   root     4120 Jul  5 16:26 kubernetes/gci-trusty/health-monitor.sh
```

##### Content of `kubernetes.tar.gz` (directories removed from list):

```
➜ $ tar -ztvf kubernetes.tar.gz
-rw-r--r--  0 root   root      107 Jul  5 16:37 kubernetes/cluster/addons/ip-masq-agent/OWNERS
-rw-r--r--  0 root   root      425 Jul  5 16:37 kubernetes/cluster/addons/ip-masq-agent/podsecuritypolicies/ip-masq-agent-psp-binding.yaml
-rw-r--r--  0 root   root     1857 Jul  5 16:37 kubernetes/cluster/addons/ip-masq-agent/ip-masq-agent.yaml
-rw-r--r--  0 root   root      309 Jul  5 16:37 kubernetes/cluster/addons/cluster-loadbalancing/glbc/README.md
-rw-r--r--  0 root   root     1116 Jul  5 16:37 kubernetes/cluster/addons/cluster-loadbalancing/glbc/default-svc-controller.yaml
-rw-r--r--  0 root   root      577 Jul  5 16:37 kubernetes/cluster/addons/cluster-loadbalancing/glbc/default-svc.yaml
-rw-r--r--  0 root   root      102 Jul  5 16:37 kubernetes/cluster/addons/cluster-loadbalancing/OWNERS
-rw-r--r--  0 root   root     5746 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-node-daemonset.yaml
-rw-r--r--  0 root   root     2078 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-deployment.yaml
-rw-r--r--  0 root   root      185 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-serviceaccount.yaml
-rw-r--r--  0 root   root      378 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/hostendpoints-crd.yaml
-rw-r--r--  0 root   root      159 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/OWNERS
-rw-r--r--  0 root   root      394 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/globalnetworksets-crd.yaml
-rw-r--r--  0 root   root      541 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/README.md
-rw-r--r--  0 root   root      189 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-serviceaccount.yaml
-rw-r--r--  0 root   root      354 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/ippool-crd.yaml
-rw-r--r--  0 root   root      408 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/globalnetworkpolicy-crd.yaml
-rw-r--r--  0 root   root      259 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-clusterrole.yaml
-rw-r--r--  0 root   root     1145 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-node-vertical-autoscaler-deployment.yaml
-rw-r--r--  0 root   root      398 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/globalfelixconfig-crd.yaml
-rw-r--r--  0 root   root      451 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-node-vertical-autoscaler-configmap.yaml
-rw-r--r--  0 root   root      394 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/bgpconfigurations-crd.yaml
-rw-r--r--  0 root   root      452 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-configmap.yaml
-rw-r--r--  0 root   root      402 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/felixconfigurations-crd.yaml
-rw-r--r--  0 root   root      189 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-serviceaccount.yaml
-rw-r--r--  0 root   root      456 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-configmap.yaml
-rw-r--r--  0 root   root      411 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/podsecuritypolicies/calico-node-psp-binding.yaml
-rw-r--r--  0 root   root      377 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-role.yaml
-rw-r--r--  0 root   root     1153 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-deployment.yaml
-rw-r--r--  0 root   root      345 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-clusterrolebinding.yaml
-rw-r--r--  0 root   root      374 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-rolebinding.yaml
-rw-r--r--  0 root   root      356 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-service.yaml
-rw-r--r--  0 root   root      363 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-clusterrolebinding.yaml
-rw-r--r--  0 root   root      402 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/clusterinformations-crd.yaml
-rw-r--r--  0 root   root      363 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-clusterrolebinding.yaml
-rw-r--r--  0 root   root      364 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-cpva-clusterrole.yaml
-rw-r--r--  0 root   root     1650 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-clusterrole.yaml
-rw-r--r--  0 root   root      390 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/globalbgpconfig-crd.yaml
-rw-r--r--  0 root   root     1137 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-horizontal-autoscaler-deployment.yaml
-rw-r--r--  0 root   root      387 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/networkpolicies-crd.yaml
-rw-r--r--  0 root   root      190 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-cpva-serviceaccount.yaml
-rw-r--r--  0 root   root      366 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/calico-cpva-clusterrolebinding.yaml
-rw-r--r--  0 root   root      349 Jul  5 16:37 kubernetes/cluster/addons/calico-policy-controller/typha-vertical-autoscaler-clusterrole.yaml
-rw-r--r--  0 root   root      137 Jul  5 16:37 kubernetes/cluster/addons/metadata-proxy/OWNERS
-rw-r--r--  0 root   root      153 Jul  5 16:37 kubernetes/cluster/addons/metadata-proxy/README.md
-rw-r--r--  0 root   root      427 Jul  5 16:37 kubernetes/cluster/addons/metadata-proxy/gce/podsecuritypolicies/metadata-proxy-psp-binding.yaml
-rw-r--r--  0 root   root     2768 Jul  5 16:37 kubernetes/cluster/addons/metadata-proxy/gce/metadata-proxy.yaml
-rw-r--r--  0 root   root      189 Jul  5 16:37 kubernetes/cluster/addons/dns-horizontal-autoscaler/MAINTAINERS.md
-rw-r--r--  0 root   root      107 Jul  5 16:37 kubernetes/cluster/addons/dns-horizontal-autoscaler/OWNERS
-rw-r--r--  0 root   root      731 Jul  5 16:37 kubernetes/cluster/addons/dns-horizontal-autoscaler/README.md
-rw-r--r--  0 root   root     3368 Jul  5 16:37 kubernetes/cluster/addons/dns-horizontal-autoscaler/dns-horizontal-autoscaler.yaml
-rw-r--r--  0 root   root      107 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/OWNERS
-rw-r--r--  0 root   root     1227 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/README.md
-rw-r--r--  0 root   root      398 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/auth-delegator.yaml
-rw-r--r--  0 root   root      801 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/resource-reader.yaml
-rw-r--r--  0 root   root      336 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/metrics-server-service.yaml
-rw-r--r--  0 root   root      388 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/metrics-apiservice.yaml
-rw-r--r--  0 root   root      419 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/auth-reader.yaml
-rw-r--r--  0 root   root     3255 Jul  5 16:37 kubernetes/cluster/addons/metrics-server/metrics-server-deployment.yaml
-rw-r--r--  0 root   root     1763 Jul  5 16:37 kubernetes/cluster/addons/README.md
-rw-r--r--  0 root   root     2275 Jul  5 16:37 kubernetes/cluster/addons/rbac/cluster-loadbalancing/glbc/roles.yaml
-rw-r--r--  0 root   root      647 Jul  5 16:37 kubernetes/cluster/addons/rbac/cluster-loadbalancing/glbc/user-rolebindings.yaml
-rw-r--r--  0 root   root      782 Jul  5 16:37 kubernetes/cluster/addons/rbac/legacy-kubelet-user-disable/kubelet-binding.yaml
-rw-r--r--  0 root   root      565 Jul  5 16:37 kubernetes/cluster/addons/rbac/legacy-kubelet-user/kubelet-binding.yaml
-rw-r--r--  0 root   root     2059 Jul  5 16:37 kubernetes/cluster/addons/rbac/cluster-autoscaler/cluster-autoscaler-rbac.yaml
-rw-r--r--  0 root   root      338 Jul  5 16:37 kubernetes/cluster/addons/rbac/kubelet-api-auth/kubelet-api-admin-role.yaml
-rw-r--r--  0 root   root      427 Jul  5 16:37 kubernetes/cluster/addons/rbac/kubelet-api-auth/kube-apiserver-kubelet-api-admin-binding.yaml
-rw-r--r--  0 root   root     1399 Jul  5 16:37 kubernetes/cluster/addons/rbac/kubelet-cert-rotation/kubelet-certificate-management.yaml
-rw-r--r--  0 root   root      214 Jul  5 16:37 kubernetes/cluster/addons/node-problem-detector/MAINTAINERS.md
-rw-r--r--  0 root   root      127 Jul  5 16:37 kubernetes/cluster/addons/node-problem-detector/OWNERS
-rw-r--r--  0 root   root      323 Jul  5 16:37 kubernetes/cluster/addons/node-problem-detector/README.md
-rw-r--r--  0 root   root      397 Jul  5 16:37 kubernetes/cluster/addons/node-problem-detector/standalone/npd-binding.yaml
-rw-r--r--  0 root   root      423 Jul  5 16:37 kubernetes/cluster/addons/node-problem-detector/podsecuritypolicies/npd-psp-binding.yaml
-rw-r--r--  0 root   root     2418 Jul  5 16:37 kubernetes/cluster/addons/node-problem-detector/npd.yaml
-rw-r--r--  0 root   root     4721 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/googleinfluxdb/heapster-controller-combined.yaml
-rw-r--r--  0 root   root      492 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/influxdb/grafana-service.yaml
-rw-r--r--  0 root   root     2738 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/influxdb/influxdb-grafana-controller.yaml
-rw-r--r--  0 root   root      302 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/influxdb/heapster-service.yaml
-rw-r--r--  0 root   root      393 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/influxdb/influxdb-service.yaml
-rw-r--r--  0 root   root     4712 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/influxdb/heapster-controller.yaml
-rw-r--r--  0 root   root     1123 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/heapster-rbac.yaml
-rw-r--r--  0 root   root      107 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/OWNERS
-rw-r--r--  0 root   root      302 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/stackdriver/heapster-service.yaml
-rw-r--r--  0 root   root     4221 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/stackdriver/heapster-controller.yaml
-rw-r--r--  0 root   root     1317 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/README.md
-rw-r--r--  0 root   root      302 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml
-rw-r--r--  0 root   root     3009 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml
-rw-r--r--  0 root   root      302 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/google/heapster-service.yaml
-rw-r--r--  0 root   root     4632 Jul  5 16:37 kubernetes/cluster/addons/cluster-monitoring/google/heapster-controller.yaml
-rw-r--r--  0 root   root      107 Jul  5 16:37 kubernetes/cluster/addons/dns/OWNERS
-rw-r--r--  0 root   root      376 Jul  5 16:37 kubernetes/cluster/addons/dns/coredns/transforms2salt.sed
-rw-r--r--  0 root   root      319 Jul  5 16:37 kubernetes/cluster/addons/dns/coredns/transforms2sed.sed
-rw-r--r--  0 root   root     4577 Jul  5 16:37 kubernetes/cluster/addons/dns/coredns/coredns.yaml.sed
-rw-r--r--  0 root   root     1075 Jul  5 16:37 kubernetes/cluster/addons/dns/coredns/Makefile
-rw-r--r--  0 root   root     4619 Jul  5 16:37 kubernetes/cluster/addons/dns/coredns/coredns.yaml.in
-rw-r--r--  0 root   root     4549 Jul  5 16:37 kubernetes/cluster/addons/dns/coredns/coredns.yaml.base
-rw-r--r--  0 root   root     6371 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/kube-dns.yaml.base
-rw-r--r--  0 root   root     1954 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/README.md
-rw-r--r--  0 root   root      376 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/transforms2salt.sed
-rw-r--r--  0 root   root      319 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/transforms2sed.sed
-rw-r--r--  0 root   root     1077 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/Makefile
-rw-r--r--  0 root   root     6451 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/kube-dns.yaml.in
-rw-r--r--  0 root   root     6364 Jul  5 16:37 kubernetes/cluster/addons/dns/kube-dns/kube-dns.yaml.sed
-rw-r--r--  0 root   root     2132 Jul  5 16:37 kubernetes/cluster/addons/dns/nodelocaldns/README.md
-rw-r--r--  0 root   root     3922 Jul  5 16:37 kubernetes/cluster/addons/dns/nodelocaldns/nodelocaldns.yaml
-rw-r--r--  0 root   root      765 Jul  5 16:37 kubernetes/cluster/addons/BUILD
-rw-r--r--  0 root   root     2183 Jul  5 16:37 kubernetes/cluster/addons/prometheus/alertmanager-deployment.yaml
-rw-r--r--  0 root   root      150 Jul  5 16:37 kubernetes/cluster/addons/prometheus/OWNERS
-rw-r--r--  0 root   root      319 Jul  5 16:37 kubernetes/cluster/addons/prometheus/alertmanager-pvc.yaml
-rw-r--r--  0 root   root      349 Jul  5 16:37 kubernetes/cluster/addons/prometheus/README.md
-rw-r--r--  0 root   root     2239 Jul  5 16:37 kubernetes/cluster/addons/prometheus/kube-state-metrics-rbac.yaml
-rw-r--r--  0 root   root     1468 Jul  5 16:37 kubernetes/cluster/addons/prometheus/node-exporter-ds.yml
-rw-r--r--  0 root   root      371 Jul  5 16:37 kubernetes/cluster/addons/prometheus/alertmanager-service.yaml
-rw-r--r--  0 root   root     3063 Jul  5 16:37 kubernetes/cluster/addons/prometheus/prometheus-statefulset.yaml
-rw-r--r--  0 root   root      402 Jul  5 16:37 kubernetes/cluster/addons/prometheus/alertmanager-configmap.yaml
-rw-r--r--  0 root   root     5440 Jul  5 16:37 kubernetes/cluster/addons/prometheus/prometheus-configmap.yaml
-rw-r--r--  0 root   root     1069 Jul  5 16:37 kubernetes/cluster/addons/prometheus/prometheus-rbac.yaml
-rw-r--r--  0 root   root      424 Jul  5 16:37 kubernetes/cluster/addons/prometheus/node-exporter-service.yaml
-rw-r--r--  0 root   root      347 Jul  5 16:37 kubernetes/cluster/addons/prometheus/prometheus-service.yaml
-rw-r--r--  0 root   root      506 Jul  5 16:37 kubernetes/cluster/addons/prometheus/kube-state-metrics-service.yaml
-rw-r--r--  0 root   root     2379 Jul  5 16:37 kubernetes/cluster/addons/prometheus/kube-state-metrics-deployment.yaml
-rw-r--r--  0 root   root      242 Jul  5 16:37 kubernetes/cluster/addons/dashboard/MAINTAINERS.md
-rw-r--r--  0 root   root      551 Jul  5 16:37 kubernetes/cluster/addons/dashboard/dashboard-secret.yaml
-rw-r--r--  0 root   root      322 Jul  5 16:37 kubernetes/cluster/addons/dashboard/dashboard-service.yaml
-rw-r--r--  0 root   root     1353 Jul  5 16:37 kubernetes/cluster/addons/dashboard/dashboard-rbac.yaml
-rw-r--r--  0 root   root      183 Jul  5 16:37 kubernetes/cluster/addons/dashboard/OWNERS
-rw-r--r--  0 root   root      400 Jul  5 16:37 kubernetes/cluster/addons/dashboard/README.md
-rw-r--r--  0 root   root      264 Jul  5 16:37 kubernetes/cluster/addons/dashboard/dashboard-configmap.yaml
-rw-r--r--  0 root   root     1780 Jul  5 16:37 kubernetes/cluster/addons/dashboard/dashboard-controller.yaml
-rwxr-xr-x  0 root   root     1040 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/run.sh
-rw-r--r--  0 root   root     7478 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/go.sum
-rw-r--r--  0 root   root       32 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/.gitignore
-rw-r--r--  0 root   root     3787 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/elasticsearch_logging_discovery.go
-rwxr-xr-x  0 root   root      827 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/Makefile
-rw-r--r--  0 root   root     1127 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/Dockerfile
-rw-r--r--  0 root   root     1136 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/BUILD
-rw-r--r--  0 root   root      275 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/config/elasticsearch.yml
-rw-r--r--  0 root   root      330 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/config/log4j2.properties
-rw-r--r--  0 root   root     1752 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-image/go.mod
-rw-r--r--  0 root   root      163 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/OWNERS
-rw-r--r--  0 root   root      354 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/kibana-service.yaml
-rw-r--r--  0 root   root      382 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-service.yaml
-rw-r--r--  0 root   root     5151 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/README.md
-rw-r--r--  0 root   root     1321 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/kibana-deployment.yaml
-rw-r--r--  0 root   root     2492 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-ds.yaml
-rw-r--r--  0 root   root      399 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/podsecuritypolicies/es-psp-binding.yaml
-rw-r--r--  0 root   root     2624 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/es-statefulset.yaml
-rwxr-xr-x  0 root   root     1045 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/run.sh
-rw-r--r--  0 root   root      786 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/README.md
-rwxr-xr-x  0 root   root      940 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/clean-install
-rw-r--r--  0 root   root      819 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Makefile
-rw-r--r--  0 root   root     2050 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Dockerfile
-rwxr-xr-x  0 root   root      921 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/clean-apt
-rw-r--r--  0 root   root      431 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Gemfile
-rw-r--r--  0 root   root      231 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-image/fluent.conf
-rw-r--r--  0 root   root    16124 Jul  5 16:37 kubernetes/cluster/addons/fluentd-elasticsearch/fluentd-es-configmap.yaml
-rw-r--r--  0 root   root      149 Jul  5 16:37 kubernetes/cluster/addons/kube-proxy/OWNERS
-rw-r--r--  0 root   root      488 Jul  5 16:37 kubernetes/cluster/addons/kube-proxy/kube-proxy-rbac.yaml
-rw-r--r--  0 root   root     2060 Jul  5 16:37 kubernetes/cluster/addons/kube-proxy/kube-proxy-ds.yaml
-rw-r--r--  0 root   root     4512 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-ds.yaml
-rw-r--r--  0 root   root     1015 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/scaler-rbac.yaml
-rw-r--r--  0 root   root      121 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/OWNERS
-rw-r--r--  0 root   root     2897 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/README.md
-rw-r--r--  0 root   root      323 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/scaler-policy.yaml
-rw-r--r--  0 root   root    16675 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-configmap-old.yaml
-rw-r--r--  0 root   root      190 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-ds-sa.yaml
-rw-r--r--  0 root   root     1281 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/event-exporter-psp.yaml
-rw-r--r--  0 root   root      356 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/event-exporter-psp-role.yaml
-rw-r--r--  0 root   root     1189 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp.yaml
-rw-r--r--  0 root   root      427 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/event-exporter-psp-binding.yaml
-rw-r--r--  0 root   root      350 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-role.yaml
-rw-r--r--  0 root   root      415 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/podsecuritypolicies/fluentd-gcp-psp-binding.yaml
-rw-r--r--  0 root   root      968 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/scaler-deployment.yaml
-rw-r--r--  0 root   root      322 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-image/README.md
-rw-r--r--  0 root   root     2329 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/event-exporter.yaml
-rw-r--r--  0 root   root    18765 Jul  5 16:37 kubernetes/cluster/addons/fluentd-gcp/fluentd-gcp-configmap.yaml
-rw-r--r--  0 root   root      121 Jul  5 16:37 kubernetes/cluster/addons/metadata-agent/OWNERS
-rw-r--r--  0 root   root      685 Jul  5 16:37 kubernetes/cluster/addons/metadata-agent/stackdriver/metadata-agent-rbac.yaml
-rw-r--r--  0 root   root      433 Jul  5 16:37 kubernetes/cluster/addons/metadata-agent/stackdriver/podsecuritypolicies/metadata-agent-psp-binding.yaml
-rw-r--r--  0 root   root     3493 Jul  5 16:37 kubernetes/cluster/addons/metadata-agent/stackdriver/metadata-agent.yaml
-rw-r--r--  0 root   root      132 Jul  5 16:37 kubernetes/cluster/addons/metadata-agent/README.md
-rw-r--r--  0 root   root     1658 Jul  5 16:37 kubernetes/cluster/addons/device-plugins/nvidia-gpu/daemonset.yaml
-rw-r--r--  0 root   root      261 Jul  5 16:37 kubernetes/cluster/addons/storage-class/aws/default.yaml
-rw-r--r--  0 root   root      269 Jul  5 16:37 kubernetes/cluster/addons/storage-class/local/default.yaml
-rw-r--r--  0 root   root      241 Jul  5 16:37 kubernetes/cluster/addons/storage-class/openstack/default.yaml
-rw-r--r--  0 root   root      245 Jul  5 16:37 kubernetes/cluster/addons/storage-class/azure/default.yaml
-rw-r--r--  0 root   root      228 Jul  5 16:37 kubernetes/cluster/addons/storage-class/vsphere/default.yaml
-rw-r--r--  0 root   root      300 Jul  5 16:37 kubernetes/cluster/addons/storage-class/gce/default.yaml
-rw-r--r--  0 root   root     3286 Jul  5 16:37 kubernetes/cluster/addons/addon-manager/CHANGELOG.md
-rw-r--r--  0 root   root      109 Jul  5 16:37 kubernetes/cluster/addons/addon-manager/OWNERS
-rw-r--r--  0 root   root     2448 Jul  5 16:37 kubernetes/cluster/addons/addon-manager/README.md
-rw-r--r--  0 root   root     1685 Jul  5 16:37 kubernetes/cluster/addons/addon-manager/Makefile
-rw-r--r--  0 root   root      710 Jul  5 16:37 kubernetes/cluster/addons/addon-manager/Dockerfile
-rwxr-xr-x  0 root   root     9251 Jul  5 16:37 kubernetes/cluster/addons/addon-manager/kube-addons.sh
-rw-r--r--  0 root   root     2417 Jul  5 16:37 kubernetes/cluster/skeleton/util.sh
-rw-r--r--  0 root   root      281 Jul  5 16:37 kubernetes/cluster/OWNERS
-rwxr-xr-x  0 root   root    16500 Jul  5 16:37 kubernetes/cluster/common.sh
-rw-r--r--  0 root   root      211 Jul  5 16:37 kubernetes/cluster/juju/OWNERS
-rw-r--r--  0 root   root       12 Jul  5 16:37 kubernetes/cluster/juju/.gitignore
-rw-r--r--  0 root   root      236 Jul  5 16:37 kubernetes/cluster/juju/README.md
-rw-r--r--  0 root   root      743 Jul  5 16:37 kubernetes/cluster/README.md
-rwxr-xr-x  0 root   root     1278 Jul  5 16:37 kubernetes/cluster/kubeadm.sh
-rwxr-xr-x  0 root   root     9720 Jul  5 16:37 kubernetes/cluster/get-kube-binaries.sh
-rwxr-xr-x  0 root   root     1037 Jul  5 16:37 kubernetes/cluster/test-e2e.sh
-rwxr-xr-x  0 root   root     2364 Jul  5 16:37 kubernetes/cluster/kubectl.sh
-rwxr-xr-x  0 root   root     2483 Jul  5 16:37 kubernetes/cluster/kube-up.sh
-rw-r--r--  0 root   root     1349 Jul  5 16:37 kubernetes/cluster/BUILD
-rwxr-xr-x  0 root   root      731 Jul  5 16:37 kubernetes/cluster/kubernetes-anywhere/util.sh
-rw-r--r--  0 root   root     2802 Jul  5 16:37 kubernetes/cluster/pre-existing/util.sh
-rwxr-xr-x  0 root   root     1112 Jul  5 16:37 kubernetes/cluster/kube-down.sh
-rwxr-xr-x  0 root   root     2869 Jul  5 16:37 kubernetes/cluster/clientbin.sh
-rwxr-xr-x  0 root   root     1504 Jul  5 16:37 kubernetes/cluster/kube-util.sh
-rwxr-xr-x  0 root   root     7464 Jul  5 16:37 kubernetes/cluster/validate-cluster.sh
-rw-r--r--  0 root   root      137 Jul  5 16:37 kubernetes/cluster/images/etcd/OWNERS
-rw-r--r--  0 root   root     2956 Jul  5 16:37 kubernetes/cluster/images/etcd/README.md
-rw-r--r--  0 root   root     8721 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/migrator.go
-rw-r--r--  0 root   root     3847 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/migrate_server.go
-rw-r--r--  0 root   root    10784 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/integration_test.go
-rw-r--r--  0 root   root     6014 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/versions.go
-rw-r--r--  0 root   root     4361 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/data_dir_test.go
-rw-r--r--  0 root   root     7281 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/migrate_client.go
-rw-r--r--  0 root   root     2379 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/BUILD
-rw-r--r--  0 root   root     2931 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/versions_test.go
-rw-r--r--  0 root   root     7388 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/migrate.go
-rw-r--r--  0 root   root       13 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/testdata/datadir_with_version/version.txt
-rw-r--r--  0 root   root        0 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/testdata/datadir_without_version/.placeholder
-rw-r--r--  0 root   root     4399 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/data_dir.go
-rw-r--r--  0 root   root     8940 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate/rollback_v2.go
-rw-r--r--  0 root   root     7613 Jul  5 16:37 kubernetes/cluster/images/etcd/Makefile
-rw-r--r--  0 root   root      717 Jul  5 16:37 kubernetes/cluster/images/etcd/Dockerfile
-rwxr-xr-x  0 root   root     3931 Jul  5 16:37 kubernetes/cluster/images/etcd/migrate-if-needed.sh
-rw-r--r--  0 root   root      163 Jul  5 16:37 kubernetes/cluster/images/hyperkube/OWNERS
-rw-r--r--  0 root   root     1166 Jul  5 16:37 kubernetes/cluster/images/hyperkube/README.md
-rw-r--r--  0 root   root     1648 Jul  5 16:37 kubernetes/cluster/images/hyperkube/Makefile
-rw-r--r--  0 root   root      658 Jul  5 16:37 kubernetes/cluster/images/hyperkube/Dockerfile
-rw-r--r--  0 root   root      968 Jul  5 16:37 kubernetes/cluster/images/hyperkube/BUILD
-rw-r--r--  0 root   root     1043 Jul  5 16:37 kubernetes/cluster/images/etcd-empty-dir-cleanup/etcd-empty-dir-cleanup.sh
-rw-r--r--  0 root   root     1536 Jul  5 16:37 kubernetes/cluster/images/etcd-empty-dir-cleanup/Makefile
-rw-r--r--  0 root   root      824 Jul  5 16:37 kubernetes/cluster/images/etcd-empty-dir-cleanup/Dockerfile
-rw-r--r--  0 root   root    11960 Jul  5 16:37 kubernetes/cluster/images/etcd-version-monitor/etcd-version-monitor.go
-rw-r--r--  0 root   root     1361 Jul  5 16:37 kubernetes/cluster/images/etcd-version-monitor/README.md
-rw-r--r--  0 root   root     1515 Jul  5 16:37 kubernetes/cluster/images/etcd-version-monitor/Makefile
-rw-r--r--  0 root   root      687 Jul  5 16:37 kubernetes/cluster/images/etcd-version-monitor/Dockerfile
-rw-r--r--  0 root   root     1152 Jul  5 16:37 kubernetes/cluster/images/etcd-version-monitor/BUILD
-rw-r--r--  0 root   root      270 Jul  5 16:37 kubernetes/cluster/images/etcd-version-monitor/etcd-version-monitor.yaml
-rw-r--r--  0 root   root      309 Jul  5 16:37 kubernetes/cluster/images/conformance/OWNERS
-rw-r--r--  0 root   root     1538 Jul  5 16:37 kubernetes/cluster/images/conformance/conformance-e2e.yaml
-rw-r--r--  0 root   root     1339 Jul  5 16:37 kubernetes/cluster/images/conformance/README.md
-rw-r--r--  0 root   root     2347 Jul  5 16:37 kubernetes/cluster/images/conformance/Makefile
-rw-r--r--  0 root   root      983 Jul  5 16:37 kubernetes/cluster/images/conformance/Dockerfile
-rw-r--r--  0 root   root     1770 Jul  5 16:37 kubernetes/cluster/images/conformance/BUILD
-rwxr-xr-x  0 root   root     2113 Jul  5 16:37 kubernetes/cluster/images/conformance/run_e2e.sh
-rwxr-xr-x  0 root   root     1162 Jul  5 16:37 kubernetes/cluster/images/conformance/conformance-e2e.sh
-rw-r--r--  0 root   root      147 Jul  5 16:37 kubernetes/cluster/images/kubemark/OWNERS
-rw-r--r--  0 root   root     1268 Jul  5 16:37 kubernetes/cluster/images/kubemark/Makefile
-rw-r--r--  0 root   root      632 Jul  5 16:37 kubernetes/cluster/images/kubemark/Dockerfile
-rw-r--r--  0 root   root      792 Jul  5 16:37 kubernetes/cluster/images/kubemark/BUILD
-rwxr-xr-x  0 root   root     4417 Jul  5 16:37 kubernetes/cluster/update-storage-objects.sh
-rwxr-xr-x  0 root   root     1062 Jul  5 16:37 kubernetes/cluster/test-smoke.sh
-rwxr-xr-x  0 root   root      994 Jul  5 16:37 kubernetes/cluster/test-network.sh
-rwxr-xr-x  0 root   root     7959 Jul  5 16:37 kubernetes/cluster/get-kube.sh
-rwxr-xr-x  0 root   root     9386 Jul  5 16:37 kubernetes/cluster/restore-from-backup.sh
-rw-r--r--  0 root   root      147 Jul  5 16:37 kubernetes/cluster/kubemark/OWNERS
-rw-r--r--  0 root   root     1373 Jul  5 16:37 kubernetes/cluster/kubemark/pre-existing/config-default.sh
-rw-r--r--  0 root   root     2138 Jul  5 16:37 kubernetes/cluster/kubemark/iks/config-default.sh
-rw-r--r--  0 root   root     6916 Jul  5 16:37 kubernetes/cluster/kubemark/gce/config-default.sh
-rw-r--r--  0 root   root      848 Jul  5 16:37 kubernetes/cluster/kubemark/util.sh
-rw-r--r--  0 root   root      287 Jul  5 16:37 kubernetes/cluster/gce/addons/node-termination-handler/README
-rw-r--r--  0 root   root     2508 Jul  5 16:37 kubernetes/cluster/gce/addons/node-termination-handler/daemonset.yaml
-rw-r--r--  0 root   root      357 Jul  5 16:37 kubernetes/cluster/gce/addons/README.md
-rw-r--r--  0 root   root      166 Jul  5 16:37 kubernetes/cluster/gce/addons/limit-range/limit-range.yaml
-rw-r--r--  0 root   root     1457 Jul  5 16:37 kubernetes/cluster/gce/addons/loadbalancing/cloud-provider-role.yaml
-rw-r--r--  0 root   root      685 Jul  5 16:37 kubernetes/cluster/gce/addons/loadbalancing/cloud-provider-binding.yaml
-rw-r--r--  0 root   root      682 Jul  5 16:37 kubernetes/cluster/gce/addons/BUILD
-rw-r--r--  0 root   root     1577 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/unprivileged-addon.yaml
-rw-r--r--  0 root   root      572 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/persistent-volume-binder-role.yaml
-rw-r--r--  0 root   root      742 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/node-binding.yaml
-rw-r--r--  0 root   root      535 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/kube-system-binding.yaml
-rw-r--r--  0 root   root      643 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/persistent-volume-binder-binding.yaml
-rw-r--r--  0 root   root      364 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/unprivileged-addon-role.yaml
-rw-r--r--  0 root   root      330 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/privileged-role.yaml
-rw-r--r--  0 root   root      791 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/privileged.yaml
-rw-r--r--  0 root   root      425 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/kube-proxy-binding.yaml
-rw-r--r--  0 root   root      878 Jul  5 16:37 kubernetes/cluster/gce/addons/podsecuritypolicies/persistent-volume-binder.yaml
-rw-r--r--  0 root   root     4843 Jul  5 16:37 kubernetes/cluster/gce/config-common.sh
-rwxr-xr-x  0 root   root    22668 Jul  5 16:37 kubernetes/cluster/gce/config-default.sh
-rw-r--r--  0 root   root      307 Jul  5 16:37 kubernetes/cluster/gce/OWNERS
-rwxr-xr-x  0 root   root    20316 Jul  5 16:37 kubernetes/cluster/gce/upgrade.sh
-rwxr-xr-x  0 root   root    25558 Jul  5 16:37 kubernetes/cluster/gce/config-test.sh
-rw-r--r--  0 root   root     1289 Jul  5 16:37 kubernetes/cluster/gce/manifests/abac-authz-policy.jsonl
-rw-r--r--  0 root   root      133 Jul  5 16:37 kubernetes/cluster/gce/manifests/OWNERS
-rw-r--r--  0 root   root      456 Jul  5 16:37 kubernetes/cluster/gce/manifests/etcd-empty-dir-cleanup.yaml
-rw-r--r--  0 root   root     3394 Jul  5 16:37 kubernetes/cluster/gce/manifests/etcd.manifest
-rw-r--r--  0 root   root     4037 Jul  5 16:37 kubernetes/cluster/gce/manifests/kube-apiserver.manifest
-rw-r--r--  0 root   root     1077 Jul  5 16:37 kubernetes/cluster/gce/manifests/BUILD
-rw-r--r--  0 root   root     3513 Jul  5 16:37 kubernetes/cluster/gce/manifests/cluster-autoscaler.manifest
-rw-r--r--  0 root   root     2698 Jul  5 16:37 kubernetes/cluster/gce/manifests/kube-controller-manager.manifest
-rw-r--r--  0 root   root     2464 Jul  5 16:37 kubernetes/cluster/gce/manifests/glbc.manifest
-rw-r--r--  0 root   root     1493 Jul  5 16:37 kubernetes/cluster/gce/manifests/kube-scheduler.manifest
-rw-r--r--  0 root   root     1315 Jul  5 16:37 kubernetes/cluster/gce/manifests/kube-addon-manager.yaml
-rw-r--r--  0 root   root     2149 Jul  5 16:37 kubernetes/cluster/gce/manifests/kube-proxy.manifest
-rwxr-xr-x  0 root   root     1427 Jul  5 16:37 kubernetes/cluster/gce/delete-stranded-load-balancers.sh
-rw-r--r--  0 root   root      583 Jul  5 16:37 kubernetes/cluster/gce/BUILD
lrwxrwxrwx  0 root   root        0 Jul  5 16:37 kubernetes/cluster/gce/cos -> gci
-rwxr-xr-x  0 root   root    22192 Jul  5 16:37 kubernetes/cluster/gce/windows/smoke-test.sh
-rw-r--r--  0 root   root     9675 Jul  5 16:37 kubernetes/cluster/gce/windows/testonly/user-profile.psm1
-rw-r--r--  0 root   root    11391 Jul  5 16:37 kubernetes/cluster/gce/windows/testonly/install-ssh.psm1
-rw-r--r--  0 root   root     4702 Jul  5 16:37 kubernetes/cluster/gce/windows/configure.ps1
-rw-r--r--  0 root   root     6560 Jul  5 16:37 kubernetes/cluster/gce/windows/README-GCE-Windows-kube-up.md
-rw-r--r--  0 root   root      159 Jul  5 16:37 kubernetes/cluster/gce/windows/OWNERS
-rw-r--r--  0 root   root    21223 Jul  5 16:37 kubernetes/cluster/gce/windows/common.psm1
-rw-r--r--  0 root   root     1121 Jul  5 16:37 kubernetes/cluster/gce/windows/BUILD
-rw-r--r--  0 root   root    52327 Jul  5 16:37 kubernetes/cluster/gce/windows/k8s-node-setup.psm1
-rwxr-xr-x  0 root   root     2641 Jul  5 16:37 kubernetes/cluster/gce/windows/node-helper.sh
lrwxrwxrwx  0 root   root        0 Jul  5 16:37 kubernetes/cluster/gce/ubuntu -> gci
lrwxrwxrwx  0 root   root        0 Jul  5 16:37 kubernetes/cluster/gce/custom -> gci
-rwxr-xr-x  0 root   root     3694 Jul  5 16:37 kubernetes/cluster/gce/list-resources.sh
-rwxr-xr-x  0 root   root     6149 Jul  5 16:37 kubernetes/cluster/gce/upgrade-aliases.sh
-rw-r--r--  0 root   root       98 Jul  5 16:37 kubernetes/cluster/gce/gci/OWNERS
-rw-r--r--  0 root   root      564 Jul  5 16:37 kubernetes/cluster/gce/gci/README.md
-rw-r--r--  0 root   root     7929 Jul  5 16:37 kubernetes/cluster/gce/gci/apiserver_manifest_test.go
-rw-r--r--  0 root   root     3856 Jul  5 16:37 kubernetes/cluster/gce/gci/node.yaml
-rw-r--r--  0 root   root     4789 Jul  5 16:37 kubernetes/cluster/gce/gci/configure_helper_test.go
-rwxr-xr-x  0 root   root     7796 Jul  5 16:37 kubernetes/cluster/gce/gci/master-helper.sh
-rw-r--r--  0 root   root     3876 Jul  5 16:37 kubernetes/cluster/gce/gci/master.yaml
-rw-r--r--  0 root   root     1781 Jul  5 16:37 kubernetes/cluster/gce/gci/BUILD
-rw-r--r--  0 root   root    17531 Jul  5 16:37 kubernetes/cluster/gce/gci/configure.sh
-rw-r--r--  0 root   root   121915 Jul  5 16:37 kubernetes/cluster/gce/gci/configure-helper.sh
-rwxr-xr-x  0 root   root     1192 Jul  5 16:37 kubernetes/cluster/gce/gci/helper.sh
-rwxr-xr-x  0 root   root     1082 Jul  5 16:37 kubernetes/cluster/gce/gci/shutdown.sh
-rwxr-xr-x  0 root   root     1877 Jul  5 16:37 kubernetes/cluster/gce/gci/node-helper.sh
-rwxr-xr-x  0 root   root     2465 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/stage-upload.sh
-rw-r--r--  0 root   root     2912 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/mounter.go
-rw-r--r--  0 root   root        8 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/.gitignore
-rw-r--r--  0 root   root      862 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/Makefile
-rw-r--r--  0 root   root      745 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/Dockerfile
-rw-r--r--  0 root   root      578 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/BUILD
-rw-r--r--  0 root   root      367 Jul  5 16:37 kubernetes/cluster/gce/gci/mounter/Changelog
-rwxr-xr-x  0 root   root     5846 Jul  5 16:37 kubernetes/cluster/gce/gci/flexvolume_node_setup.sh
-rw-r--r--  0 root   root     4120 Jul  5 16:37 kubernetes/cluster/gce/gci/health-monitor.sh
-rwxr-xr-x  0 root   root   132470 Jul  5 16:37 kubernetes/cluster/gce/util.sh
-rwxr-xr-x  0 root   root     5753 Jul  5 16:37 kubernetes/cluster/get-kube-local.sh
-rwxr-xr-x  0 root   root    24172 Jul  5 16:37 kubernetes/cluster/log-dump/log-dump.sh
-rw-r--r--  0 root   root     2187 Jul  5 16:37 kubernetes/cluster/log-dump/logexporter-daemonset.yaml
-rw-r--r--  0 root   root      184 Jul  5 16:37 kubernetes/docs/OWNERS
-rw-r--r--  0 root   root       46 Jul  5 16:37 kubernetes/docs/.gitignore
-rw-r--r--  0 root   root      346 Jul  5 16:37 kubernetes/docs/BUILD
-rwxr-xr-x  0 root   root    28540 Jul  5 16:37 kubernetes/hack/lib/golang.sh
-rw-r--r--  0 root   root     2212 Jul  5 16:37 kubernetes/hack/lib/swagger.sh
-rwxr-xr-x  0 root   root     5109 Jul  5 16:37 kubernetes/hack/lib/etcd.sh
-rw-r--r--  0 root   root     4443 Jul  5 16:37 kubernetes/hack/lib/logging.sh
-rw-r--r--  0 root   root    11698 Jul  5 16:37 kubernetes/hack/lib/test.sh
-rw-r--r--  0 root   root      502 Jul  5 16:37 kubernetes/hack/lib/BUILD
-rw-r--r--  0 root   root     2994 Jul  5 16:37 kubernetes/hack/lib/protoc.sh
-rw-r--r--  0 root   root       24 Jul  5 16:37 kubernetes/hack/lib/.gitattributes
-rwxr-xr-x  0 root   root     5447 Jul  5 16:37 kubernetes/hack/lib/init.sh
-rwxr-xr-x  0 root   root    24049 Jul  5 16:37 kubernetes/hack/lib/util.sh
-rw-r--r--  0 root   root     7362 Jul  5 16:37 kubernetes/hack/lib/version.sh
-rw-r--r--  0 root   root     3167 Jul  5 16:37 kubernetes/README.md
-rw-r--r--  0 root   root      153 Jul  5 16:37 kubernetes/server/README
-rw-r--r--  0 root   root    75593 Jul  5 16:37 kubernetes/server/kubernetes-manifests.tar.gz
-rw-r--r--  0 root   root       16 Jul  5 16:37 kubernetes/version
-rw-r--r--  0 root   root  1171762 Jul  5 16:37 kubernetes/LICENSES
-rw-r--r--  0 root   root      146 Jul  5 16:37 kubernetes/client/README
```

##### Content of `kubernetes-test.tar.gz` and `kubernetes-src.tar.gz` are not present in this document
because of the amount of information present inside. First contains content of https://github.com/kubernetes/kubernetes/tree/master/test + some helpers,
and the second contains source code of kubernetes.
