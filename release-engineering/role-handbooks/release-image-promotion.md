# Image Promotion

We need to publishing images to the `k8s-staging-kubernetes` GCS Bucket and then promoting them to production. To do that we need to follow the steps:

This step should be done after `Official Stage` is completed and no errors.

 - Forking/cloning https://github.com/kubernetes-sigs/k8s-container-image-promoter
 - Forking/cloning https://github.com/kubernetes/k8s.io. If you already have that make sure you have an up-to-date copy of the repository.
 - From the root of `k8s-container-image-promoter` repository

```shell
go install ./cmd/cip-mm/... # Installs the manifest merge utility, cip-mm
```

- From the root of `k8s.io` repository

```shell
cip-mm --base_dir=$GOPATH/src/k8s.io/k8s.io/k8s.gcr.io --staging_repo=gcr.io/k8s-staging-kubernetes --filter_tag=v1.19.0-rc.2
```

When the release cut is not Alpha / Beta or RC we need to promote the next images as well, for example, if you are cutting `v1.19.0` you will need to promote the images for `1.19.1-rc.0` as well, so the commands will be something like:

```shell
cip-mm --base_dir=$GOPATH/src/k8s.io/k8s.io/k8s.gcr.io --staging_repo=gcr.io/k8s-staging-kubernetes --filter_tag=v1.19.0

cip-mm --base_dir=$GOPATH/src/k8s.io/k8s.io/k8s.gcr.io --staging_repo=gcr.io/k8s-staging-kubernetes --filter_tag=v1.19.1-rc.0
```

_note_: If you clone the repo in another structure like `$GOPATH/src/github.com/kubernetes/k8s.io` you will nee to set the `--base_dir` as `--base_dir=$GOPATH/src/github.com/kubernetes/k8s.io/k8s.gcr.io`
_note 2_: The `--filter_tag` you will add the release that you are working, like `v1.19.0-rc.3` / `v1.19.0-beta.1` / `v1.19.0`

- After the command ran you should see updates to the `k8s.gcr.io/images/k8s-staging-kubernetes/images.yaml`
- Create a branch and open a Pull Request with the new digests to promote. Add the links for cloudbuild jobs for `Mock Stage` and `Mock Release` and tag `@kubernetes/release-engineering` and add a explict `/hold` to be lifted before we start the `Official Release` step.

Examples:
 - [PR example 1](https://github.com/kubernetes/k8s.io/pull/1106)
 - [PR example 2](https://github.com/kubernetes/k8s.io/pull/1147)
 - [PR example 3](https://github.com/kubernetes/k8s.io/pull/1071)

 - After the Pull Request is approved and **before** start the `Official Release` step, we need to unhold the PR to get that merged  and watch the following [Prow Job](https://prow.k8s.io/?job=post-k8sio-cip) to succeed. When the latest master ran without errors, then we can continue with `Official Release`.

 - When the Prow job ran you should be able to get the image by running, for example:

```shell
skopeo inspect docker://us.gcr.io/k8s-artifacts-prod/kube-apiserver:v1.19.0-rc.4 --raw
```