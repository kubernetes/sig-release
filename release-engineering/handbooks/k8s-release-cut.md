# Cutting a Kubernetes release

<!-- toc -->
- [Cutting a Kubernetes release](#cutting-a-kubernetes-release)
  - [Prerequisites](#prerequisites)
    - [Green Release Signal (pre-releases only)](#green-release-signal-pre-releases-only)
    - [Access to GCP](#access-to-gcp)
    - [Install latest software (every time)](#install-latest-software-every-time)
      - [Download or update `Go` to the latest available stable version:](#download-or-update-go-to-the-latest-available-stable-version)
      - [Download or update the `gcloud` CLI to interact with GCP.](#download-or-update-the-gcloud-cli-to-interact-with-gcp)
      - [Download or update `krel`](#download-or-update-krel)
      - [Download or update the latest `kpromo` tool](#download-or-update-the-latest-kpromo-tool)
      - [Download schedule-builder](#download-schedule-builder)
    - [Configure GitHub Personal Access Token](#configure-github-personal-access-token)
  - [1. Release cut issue](#1-release-cut-issue)
  - [2. Create a thread on the `#release-management` Slack channel](#2-create-a-thread-on-the-release-management-slack-channel)
  - [3. Generate testgrid screenshots](#3-generate-testgrid-screenshots)
  - [4. Check publishing-bot status](#4-check-publishing-bot-status)
  - [5. Mock stage and Mock release](#5-mock-stage-and-mock-release)
  - [6. No-mock stage](#6-no-mock-stage)
  - [7. Image promotion](#7-image-promotion)
    - [Merge promo PR](#merge-promo-pr)
    - [Wait on image promotion job](#wait-on-image-promotion-job)
  - [8. No-mock release](#8-no-mock-release)
  - [9. Notify public dev Google group mailinglist](#9-notify-public-dev-google-group-mailinglist)
    - [Manually create release HTML announcements](#manually-create-release-html-announcements)
      - [Legacy Sendgrid method:](#legacy-sendgrid-method)
  - [10. Post release tasks](#10-post-release-tasks)
    - [\[RC.0 only\] Considerations and post branch creation release tasks](#rc0-only-considerations-and-post-branch-creation-release-tasks)
      - [Next Release Branch Creation](#next-release-branch-creation)
      - [Post branch creation release tasks](#post-branch-creation-release-tasks)
    - [\[Stable only\] Code Thaw](#stable-only-code-thaw)
    - [\[Patch only\] Update schedule on k/website](#patch-only-update-schedule-on-kwebsite)
  - [Cleanup](#cleanup)

A step by step guide for cutting Kubernetes patch releases. At a high-level:

- Maintain GitHub release cut issue
- Update tools (~15m)
- Run `krel stage` (~1h 15m - up to 2h)
- Run `krel release` (~15m)
- Run `krel stage --no-mock` (~1h 15m - up to 2h)
- Run `kpromo pr` & merge PR
- Wait for image promo prow job (~1h)
- Run `krel release --no-mock` (~15m)
- Send announcements (~30m)


## Prerequisites

### Green Release Signal (pre-releases only)

On the same day of the release, a green signal must've been given in the #release-management Slack channel. If in doubt, double check with the current Release Signal Team Lead.
You can find the complete list of release signal team members at this link (substitute `1.xx` with the current release version):

`https://github.com/kubernetes/sig-release/blob/master/releases/release-1.xx/release-team.md`

> [!NOTE]
Ensure that there are no patch releases in progress, coordinating with @release-managers.
These are typically scheduled on different days of the week, so there is usually no need to plan around them, but since they can sometimes overlap with other release activities, it's good to double-check.

### Access to GCP

You must be a member of [k8s-infra-release-editors](https://github.com/kubernetes/k8s.io/blob/main/groups/sig-release/groups.yaml) on GitHub.

Group membership grants access to [Google Cloud Platform (GCP)](https://console.cloud.google.com/) for issuing `krel` commands that ultimately launch [Cloud Build](https://cloud.google.com/build) jobs.

> [Example PR](https://github.com/kubernetes/k8s.io/pull/7781)

### Install latest software (every time)

Begin by updating to the latest package versions. This helps reduce failure points in the build process. The following packages are needed:

- golang (Go, used to build OSS tools)
- gcloud (GCP CLI)
- krel (OSS CLI Tool)
- kpromo (OSS CLI Tool)
- [optional] schedule-builder (OSS CLI Tool) 

#### Download or update `Go` to the latest available stable version:

[go.dev/dl](https://go.dev/dl/)

```
# to install
brew install go
    
# to update (latest)
brew upgrade go
```

[optional] if on a Linux-based system using [zsh](https://www.zsh.org/) (Mac, Linux, Windows WSL) add to `~/.zshrc` PATH:

```
export GOPATH=$(go env GOPATH)
export PATH="$HOME/go/bin:${PATH}"
#reload your .zshrc
source ~/.zshrc
```

#### Download or update the `gcloud` CLI to interact with GCP.

```
# to install
brew install --cask google-cloud-sdk
    
# to update
gcloud components update --quiet
```

Ensure your GCP credentials are active.
    
```
gcloud auth login
```

You will be prompted to log in via your default browser.

> [!TIP]
Ensure that the email you are using to login is the same added in the [Access to GCP](#Access-to-GCP) step.

#### Download or update `krel`

Krel ([docs](https://github.com/kubernetes/release/blob/master/docs/krel/README.md)).

First time:

```
git clone git@github.com:kubernetes/release.git
```

Every time:

```
cd release

# to update
git checkout master
git pull origin master
```

Compile `krel` using the script in the repo:

```
./compile-release-tools krel
```
 
Validate with:

```
krel version
```
   

#### Download or update the latest `kpromo` tool

Run the following command ([source](https://github.com/kubernetes-sigs/promo-tools/blob/main/docs/promotion-pull-requests.md#preparing-environment)) to get the latest release of `kpromo`:

```
go install sigs.k8s.io/promo-tools/v4/cmd/kpromo@main
```

or to build the latest version directly from a target branch:

```
git clone https://github.com/kubernetes-sigs/promo-tools
git pull origin <target-branch>
make kpromo
```

Validate with:

```
kpromo version
```

Output should look like this:

```
_  __  ____    ____     ___    __  __    ___
| |/ / |  _ \  |  _ \   / _ \  |  \/  |  / _ \
| ' /  | |_) | | |_) | | | | | | |\/| | | | | |
| . \  |  __/  |  _ <  | |_| | | |  | | | |_| |
|_|\_\ |_|     |_| \_\  \___/  |_|  |_|  \___/
kpromo: Kubernetes project artifact promoter

GitVersion:    v3.4.4
GitCommit:     unknown
GitTreeState:  unknown
BuildDate:     unknown
GoVersion:     go1.19.1
Compiler:      gc
Platform:      darwin/arm64
```
 
#### Download schedule-builder

Only when cutting a patch release (not a pre-release like alpha, beta, etc.).

```
go install k8s.io/release/cmd/schedule-builder@latest
``` 

### Configure GitHub Personal Access Token

Get a GitHub API token (one off or expiration based)

Navigate to `Settings > Developer Settings > Personal Access Token` to generate a new token. For the scopes, select:

- repo
- gist
- notifications
- user

Set an appropriate expiration date then click on `[GENERATE TOKEN]` and copy it.

> NOTE / TODO: Look into using fine grained tokens: https://stackoverflow.com/questions/78216547/minimum-permissions-for-a-github-access-token-to-clone-push-and-pull-from-repo. Doing the bare minimum seemed to not work.

Run this command in your shell to export the token and making it available for `krel` and `kpromo`. They should be short lived, no need to store.

```
export GITHUB_TOKEN=xyz
```

## 1. Release cut issue

First step before cutting the release is to open an [issue](https://github.com/kubernetes/sig-release/issues/new?template=cut-release.md).

An example issue you can follow can be found [here](https://github.com/kubernetes/sig-release/issues/2719).

The issue contains a series of steps to follow and at some point you will be asked to input the `krel version` command output:

```
GitVersion:    v0.13.0
GitCommit:     2c2e73f4e15c85beba135e4513308bffa79abc64
GitTreeState:  clean
BuildDate:     2022-09-14T08:01:01
GoVersion:     go1.19.1
Compiler:      gc
Platform:      darwin/arm64
```

> [!WARNING]
Always recompile `krel` before cutting a release.

## 2. Create a thread on the `#release-management` Slack channel

Helpful templates, each one has a "completed" response too:

```
:thread: Release Cut v1.xx.yy-alpha|beta|rc-z (GH Issue)

:hourglass_flowing_sand: Mock Stage (logs) 
-> :white_check_mark:

:hourglass_flowing_sand: Mock Release (logs)
-> :white_check_mark:

:hourglass_flowing_sand: No-mock Stage (logs)
-> :white_check_mark:

https://github.com/kubernetes/k8s.io/pull/xxxx

Image Promotion PR (link)
cc: @release-managers
-> Image promotion is :white_check_mark:

:hourglass_flowing_sand: No-mock Release (logs)
-> :white_check_mark:
```

## 3. Generate testgrid screenshots

Generate a comment with the `krel testgridshot` command as follows:

```
# defaults to master / main:
krel testgridshot

# specific branch:
krel testgridshot --branch 1.xx
```

Post the comment generated in the **GitHub issue**.

This comment contains a current snapshot of the test results for the target branch, if there is any error you should stop the release process and inform #release-management on Slack. Before proceeding the failing tests need to be either fixed or marked as non-release blocking.

## 4. Check publishing-bot status

Check the health of the publishing-bot by navigating to [this issue](https://github.com/kubernetes/kubernetes/issues/56876) if it's closed, the bot is healthy and you can keep going.

If the issue is open you must stop the release process and inform #release-management on Slack.

## 5. Mock stage and Mock release

> [!WARNING]
Before cutting `alpha.1` ideally some days before, ensure that @release-managers have performed the propedeutic tasks for the alpha cut (e.g. setting up the new OBS project)

Mock stages and mock releases are non-destructive and can be reran upon failure. To begin the mock stage, run the following `krel stage` command (replace the stage with the appropriate "type").

Run the following command from within the release repo directory.

```
# if cutting any unreleased version
krel stage --type alpha --branch master

krel stage --type beta --branch master

# or specify a branched version
krel stage --type official --branch release-1.xx

krel stage --type rc --branch release-1.xx
```

> [!WARNING]
If you encounter an error that looks like this
`Step #4: level=fatal msg="checking out obs project: checking out obs project: command /usr/local/bin/osc checkout isv:kubernetes:core:prerelease:v1.33:build did not succeed: Server returned an error: HTTP Error 404: Not Found\nProject not found: isv:kubernetes:core:prerelease:v1.33:build\n"`
The OBS project has not been created, contact @release-managers on Slack.

> [!CAUTION]
If you encounter this error
"FATA submit stage job: verifying repository state: local HEAD (d2eb4818bbaf2820128f21c1895308dad4cfc6de) is not equal to latest remote commit (90469b0184a2e3d1b31209bf8fed413273f92a17)" you need to pull the release repo [as follows](#Download-or-update-krel-docs)

The `krel` tool outputs a link to the logs.

This takes about **2 hours**. Once passed, move on to the "release" command using a specific build-version string (output from the first stage).

> [!NOTE]
At this point you should start updating the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue)

```
# take the output of the previous command from the logs and run the command
# It should look like this:
krel release --type=alpha|beta|official|release --branch=release-1.xx --build-version=v1.xx.yy-alpha|beta|rc-z+<some-hash>
```

If you are releasing an `alpha.1` you will have a command output that has a `build-version` parameter value containing `alpha.0`, same goes for `alpha.2` having `alpha.1` and so on. This is expected, you can proceed with executing the krel release command.

> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after this step

## 6. No-mock stage

The following stages, called no-mock, create real artifacts that can be promoted for general use. The process should be near identical to the `no-mock` stages ran prior.

Run the no-mock staging:

```
# if cutting an unreleased version
krel stage --type alpha --branch master --nomock

krel stage --type rc --branch release-1.xx --nomock

# or specify a branch version
krel stage --type official --branch release-1.xx --nomock
```

> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after this no-mock stage step

This also takes about **2 hours**. Once passed, move on to the `kpromo` command.

> [!CAUTION]
Do not run the release command yet, just copy it somewhere and wait for the image promo to happen first (which means the image promo PR gets merged and the prow job has to be completed).

## 7. Image promotion

Complete docs can be found [here](https://github.com/kubernetes-sigs/promo-tools/blob/main/docs/promotion-pull-requests.md)

 > [!WARNING]
`FATA growing manifest with image filter [] and tag [1.29.0-alpha.1]: no images survived filtering; double-check your --filter_* flag(s) for typos`
means you forgot the letter "v" in the tag parameter.

Once you've run the command its output should look like this:

```
INFO Successfully created PR #xxxx                
INFO Successfully created PR: https://github.com/kubernetes/k8s.io/pull/xxxx 
```

### Merge promo PR

Wait for the generated PR to be merged (after approval and LGTM).
You might wanna ping @release-managers on Slack to speed this process up.

**The PR has no dependencies outside of approvals / review.**

> [!CAUTION]
In case a blocking test goes red during the release cut, you should keep the PR held and reach a consesus with @release-managers that the promo can continue.
e.g. if a test went red for infra flakyness "Node not ready" it's probably ok to continue, but it's always better to double check.

> [Example PR](https://github.com/kubernetes/k8s.io/pull/3024).

### Wait on image promotion job

!! DO NOT CONTINUE **RELEASE** (UNTIL FINISHED)

> [!CAUTION]
**After** the Pull Request is merged and **before** starting the official nomock release step, watch [the following Prow Job](https://prow.k8s.io/?job=post-k8sio-image-promo) and wait for it to succeed.

If the job fails, look into the root cause and message the Slack thread. In many cases a rerun is fine (such as 429 too many requests or limit quota exceeded).
A resolution to this problem is being discussed [here](https://docs.google.com/document/d/1S5NlwOdtXKEWXvdkGRvVTsNip6niyhb52FSNk8-uJiQ/edit?resourcekey=0-IRBLdEtrNfK9e7z1w4y9ng&tab=t.0).

To check the logs after failure, click on the spyglass eye icon, otherwise you can look at the POD logs when the job is running by clicking on the paper icon.

To Rerun, click the refresh icon button shown below:

<img width="1710" alt="image" src="https://github.com/user-attachments/assets/9ea490ca-c99b-42bc-80f6-df890c9e145d" />

The UI can be funky at times, if you click rerun and it forces you to log in - you might need to click it again. 
In case it doesn't it should show a pop up:
- if it says it didn’t run, retry
- if it says it ran wait 30s and check again (takes a minute)

You might notice different jobs running, be sure to check out the hash from the merge commit that has been generated by prow after your image promo PR.
That is the hash of the job you want to check and rerun if it fails.

If the job is stuck in "triggered" (empty clock yellow icon), especially after a rerun, it's normal and expected. Please wait and do not touch it.

> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after the image promotion step

## 8. No-mock release

You should have copied the nomock release command output from the nomock stage previously run, now you can execute the release command as follows:

```
krel release --type=alpha|beta|official|release --branch=release-1.xx --build-version=v1.xx.yy-alpha|beta|rc-z+<some-hash>
```

> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after this no-mock release step.

## 9. Notify public dev Google group mailinglist

Ensure that you are a moderator of dev@kubernetes.io so you can send messages without passing by the moderation queue, and also an admin of [kubernetes-announce](https://groups.google.com/g/kubernetes-announce).
In case you are not part of these groups as moderator/admin, ask to be added in #release-management. 
Ideally this is a task that should be performed during onboarding and not on the day of the cut.

> **NOTE as of February 2025: Using manual is the preferred method given the issues with Sendgrid.**

### Manually create release HTML announcements

Sometimes you might need to manually send the announcement, in which case you can run this command:

```
krel announce send -p --tag v1.xx.yy-alpha|beta|rc.z --name "First Last" --email "your-email@gmail.com" > ~/Downloads/announce.html
```

And then send the email from your account as follows:

```
# SUBJECT:
# Kubernetes v1.xx.yy-alpha|beta|rc-z is live!

# ...
# SEND TO:
dev@kubernetes.io, kubernetes-announce@googlegroups.com
```

#### Legacy Sendgrid method:

> [!TIP]
username == email` & `password == normalx2`.

```
cd ~/release
export SENDGRID_API_KEY=<API_KEY previously shared>

krel announce send --tag v1.xx.yy-alpha|beta|rc-z --name "First Last" --email "your-email@gmail.com" --nomock
```

Samples:

```
# for 1.22.14, 1.23.11, 1.24.5 and 1.25.1
krel announce send --tag v1.24.14 --name "Jim Angel" --email "jameswangel@gmail.com" --nomock
krel announce send --tag v1.25.10 --name "Jim Angel" --email "jameswangel@gmail.com" --nomock
krel announce send --tag v1.26.5 --name "Jim Angel" --email "jameswangel@gmail.com" --nomock
krel announce send --tag v1.27.2 --name "Jim Angel" --email "jameswangel@gmail.com" --nomock
```

> [!WARNING]
You could run in a reached max recipients quota, in such case communicate with #release-management.

> [!TIP]
Kubernetes-announce might require permissions to post, check you have them or ask your release-manager buddy to post the message for you.

Post this message in release-management:

```
:kubernetes: Kubernetes v1.xx.yy is live! (shoutout to @xx & @Byfor helping cut the release)
https://groups.google.com/a/kubernetes.io/g/dev/c/fbaBcFvZFMo
```

Examples

```
:kubernetes: Kubernetes v1.23.11 is live! (shoutout to @arnaud & @Benjamin Kazemi for helping cut the release)
https://groups.google.com/a/kubernetes.io/g/dev/c/E14i6e2ndNc

:kubernetes: Kubernetes v1.24.5 is live! (shoutout to @arnaud & @Benjamin Kazemi for helping cut the release)
https://groups.google.com/a/kubernetes.io/g/dev/c/WSQwY55HeeI

:kubernetes: Kubernetes v1.25.1 is live! (shoutout to @arnaud & @Benjamin Kazemi for helping cut the release)
https://groups.google.com/a/kubernetes.io/g/dev/c/R5vB-jFqnDw
```

Copy / paste link to #release-management notification post.

> [!NOTE]
Remember to provide one last final update to the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after the announcement step

To valorize the release stats required in the release cut issue, run this command:

```
# date should be the previous release date
krel history --branch master --date-from yyyy-mm-dd 

krel history --branch release-1.xx --date-from yyyy-mm-dd

#example
krel history --branch release-1.33 --date-from 2025-04-23
```

## 10. Post release tasks

### [RC.0 only] Considerations and post branch creation release tasks

Remember that before launching the `nomock release` command for an rc.0, you need to ensure that the image promo job for the next alpha.0 has been completed successfully.

#### Next Release Branch Creation

> [!IMPORTANT]  
> The new release branch is created in the `nomock` staging phase and pushed to the repository during the `nomock` release phase of an rc.0 cut.

During a `rc.0` release our release tooling creates a new release branch named `release-X.Y`, where `X.Y.0` is the version of the upcoming release. 
Additionally, the `rc.0` release automatically triggers an `alpha.0` build for the subsequent release (e.g. for `v1.34.0-rc.0`, `v1.35.0-alpha.0` is created automatically).

Behind the scenes `krel` is executing a `git branch create` command and `git push`. 

At the same time Prow’s [`branchprotector`](https://git.k8s.io/test-infra/prow/cmd/branchprotector/README.md) runs every hour at 54 minutes past the hour and automatically adds [branch protection](https://help.github.com/articles/about-protected-branches/) to any new branch in the `kubernetes/kubernetes` repo, including the newly created one.
No need to manually create the branch protection rule.

However, it is important to ensure that the branch is protected. We had cases where the branch was not protected and this was noticed very late.

> [!NOTE]  
This means that the staging step will take about twice as long, as it will stage both versions `vX.Y.0-rc.0` and `vX.{Y+1}.0-alpha.0`. 
The release step will also be extended, but not substantially longer in time.

#### Post branch creation release tasks

See [here](post-release-branch-creation.md) for the complete list of post branch creation release tasks.

Such list resides in a different document to mainain this one in a bite-sized SRE style format.

> [!WARNING]
You will not be able to cut an rc.1 or any other cut against the new branch until the post branch creation tasks (post rc.0) are complete.

### [Stable only] Code Thaw

Code thaw means you need to lift the code freeze, [here](https://github.com/kubernetes/sig-release/blob/master/release-engineering/role-handbooks/branch-manager.md#code-thaw) 
are the docs on how to do it, with an example PR.

### [Patch only] Update schedule on k/website

> [!NOTE]
Only for patch releases, 1.x.y not for alpha, beta, rc or official.

You need to update the release schedule on the official Kubernetes website through schedule-builder, here is how:

```
# update k/website repo
git checkout main
git fetch upstream
git pull upstream main
git reset --hard upstream/main
rm -rf api-ref-generator
git submodule deinit -f api-ref-generator
git submodule update --init --recursive


# from in the k/website repo
git checkout -b schedule-updates-nov-2024
schedule-builder -uc ./data/releases/schedule.yaml -e ./data/releases/eol.yaml
git add .
git commit -m "updating release schedule"
git push -u origin schedule-updates-oct-2024
```

## Cleanup

Close the release cut issue and possibly related issues, open new issues if you find any docs or feature missing, and ask Google admins to revoke your personal access to GCP if it is no longer required.
You might want to delete your GitHub access token too.
