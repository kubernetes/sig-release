# Image Promotion <!-- omit in toc -->

- [Preparing Environment](#preparing-environment)
- [Promoting Images Using `krel promote-images`](#promoting-images-using-krel-promote-images)
- [Completing the Image Promotion](#completing-the-image-promotion)

When cutting a new Kubernetes release, we need to publish images to the `k8s-staging-kubernetes` GCS Bucket and then promote them to the production.

**The Image Promotion should be done after `Official Stage` is completed and there are no errors.**

## Preparing Environment

First, take the following steps to prepare your environment for promoting images:

- Fork the [`kubernetes/k8s.io` repository](https://github.com/kubernetes/k8s.io)
- Fork and clone the [`kubernetes/release` repository](https://github.com/kubernetes/release)
- From the root of the `kubernetes/release` repository, run the following command to compile and install the release tools:

```shell
make release-tools
```

## Promoting Images Using `krel promote-images`

The images are promoted by using the `krel promote-images` command. This command takes the following parameters:

- The `-i` flag runs the command in the interactive mode, so `krel` will ask you to confirm each step
- The `--fork` flag takes the GitHub username and fork/repository name of your `kubernetes/k8s.io` fork that will be used to push the changes
  - If your fork name is `k8s.io` you can just specify your GitHub username, such as `--fork=<your-github-username>`
  - Otherwise, you can specify both GitHub username and fork name, such as `--fork=<your-github-username>/<k8s.io-fork-name>`
- The `--tag` flag takes the version tag of the images that will be promoted. This flag can be specified multiple times if you're promoting images for multiple releases.

Depending on the release you're cutting, you need to run the following command:

- If you're cutting Alpha, Beta, or RC release, use the following `krel promote-images` command to promote images for the release you're cutting:

```shell
krel promote-images -i --fork=<your-github-username> --tag=v1.20.0-beta.1
```

- If you're cutting a stable release (e.g. `v1.20.0`), you need to promote the images for the release you're cutting and for the next RC release (e.g. `v1.20.1-rc.0`). You can use the following command to do that:

```shell
krel promote-images -i --fork=<your-github-username> --tag=v1.20.0 --tag=v1.20.1-rc.0
```

The following steps are taken by the `krel promote-images` command:

- Clone and update your `kubernetes/k8s.io` fork
- Update the images manifest (`k8s.gcr.io/images/k8s-staging-kubernetes/images.yaml`) to add the image digests for specified releases/tags
- Create a branch and push it to your fork
- Create a PR in the `kubernetes/k8s.io` repository with an explicit `/hold`

Example PRs:

- [PR example 1](https://github.com/kubernetes/k8s.io/pull/1386)
- [PR example 2](https://github.com/kubernetes/k8s.io/pull/1348)

## Completing the Image Promotion

Once the `krel promote-images` command is done take the following steps to complete image promotion and continue the release process:

- Edit the PR description to add links for GCB jobs for `Mock Stage`, `Mock Release`, and `Official Stage` steps, or a link to the release tracking issue which includes the needed links
- Once the PR is approved by Release Managers:
  - If you're cutting Alpha, Beta, or RC release, lift the hold and proceed with the release process
  - If you're cutting a stable release, ensure that a [Build Admin](https://git.k8s.io/sig-release/release-managers.md#build-admins) is available to cut the packages before lifting the hold and proceeding with the release
- After the Pull Request is merged and **before** starting the `Official Release` step, we need to watch the following [Prow Job](https://prow.k8s.io/?job=post-k8sio-image-promo) to succeed. When the latest master ran without errors, then we can continue with `Official Release`.
