# Base Image Exception List

| Component Name        |           Base Image         |        Reasons    |
| --------------------- | :---------------------------:|:------------------:|
| 		kube-proxy      |  [k8s.gcr.io/debian-iptable](https://github.com/kubernetes/kubernetes/blob/1b9d0c1094d31f851a5ec6e277fbf0b7382196cf/build/common.sh#L101)   | Requires iptable  |
