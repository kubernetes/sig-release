# Cutting a Kubernetes patch release

A step by step guide for cutting Kubernetes patch releases. At a high-level:

- Maintain GitHub release cut issue
- Update tools (~15m)
- Run `krel stage` (~2h)
- Run `krel release` (~15m)
- Run `krel stage --no-mock` (~2h)
- Run `kpromo pr` & merge PR
- Wait for image promo job (~1h)
- Run `krel release --no-mock` (~15m)
- Send announcements (~30m)


## Prerequisites

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

Run the following command ([source](https://github.com/kubernetes-sigs/promo-tools/blob/main/docs/promotion-pull-requests.md#preparing-environment)):

```
go install sigs.k8s.io/promo-tools/v4/cmd/kpromo@latest
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

Mock stages and releases are non-destructive and can be reran upon failure. To begin the mock stage, run the following `krel stage` command (replace the stage with the appropriate "type").

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

> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after this step

## 5. No-mock stage and no-mock release

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

This also takes about **2 hours**. Once passed, move on to the "release" command using a specific build-version string (output from the first stage).

```
# take the output of the previous command from the logs and copy this command somewhere
# It should look like this:
krel release --type=alpha|beta|official|release --branch=release-1.xx --build-version=v1.xx.yy-alpha|beta|rc-z+<some-hash>
```

> [!CAUTION]
Do not run the command yet, just copy it somewhere and wait for the image promo to happen first.

## 6. Image promotion

Promote the images (`alpha`, `beta` or `rc`) using `kpromo`. The tool will automatically create / open a PR with the images and tags properly promoted.

### Which image should be promoted?

The images that need to be promoted depend on the release you're cutting:

- **Alpha or Beta release:** just promote the images for the release you're cutting (e.g. v1.20.0-beta.1)
- **The first RC (e.g. v1.20.0-rc.0):** promote the images for the RC and for the next minor alpha release (e.g. v1.21.0-alpha.0)
- **The subsequent RCs (e.g. v1.20.0-rc.1):** promote the images for the RC you're cutting (e.g. v1.20.0-rc.0)
- **A stable release (e.g. v1.20.0):** promote the images for the release you're cutting and for the RC of the next patch release (e.g. v1.20.1-rc.0)

Some examples can be found below:

```
kpromo pr --fork=jimangel --tag="v1.29.0-alpha.1"

# RC
kpromo pr --fork=jimangel --tag="v1.32.0-rc.1"
#or
kpromo pr --fork=jimangel --tag="v1.29.0-rc.0" --tag="v1.30.0-alpha.0"
```

### Run kpromo (opens the PR)

> [!IMPORTANT]
If promoting the first release candidate (rc), include the next release alpha as follows.

```
kpromo pr --fork=<your-username> --tag="v1.xx.yy-rc-z" --tag="v1.xx+1.yy-alpha-0"
```

> [!TIP]
Multiple tags can be specified with the `kpromo` pr command

This is the standard command to be run ([source](https://github.com/kubernetes-sigs/promo-tools/blob/main/docs/promotion-pull-requests.md#promoting-images)):

```
# --interactive=true asks confirmation before every step, highly recommended

kpromo pr --fork=<your-username> --tag="v1.xx.yy-alpha|beta|rc-z" --interactive=true 
```

 > [!WARNING]
`FATA growing manifest with image filter [] and tag [1.29.0-alpha.1]: no images survived filtering; double-check your --filter_* flag(s) for typos`
means you forgot the letter "v" in the tag parameter.

Once run the command its output should look like this:

```
INFO Successfully created PR #xxxx                
INFO Successfully created PR: https://github.com/kubernetes/k8s.io/pull/xxxx 
```

### Merge PR

Wait for the generated PR to be merged (after approval and LGTM).
You might wanna ping @release-managers on Slack to speed this process up.

**The PR is not blocked by anything but approvals / review.**

> [Example PR](https://github.com/kubernetes/k8s.io/pull/3024).

### Wait on image promotion job

!! DO NOT CONTINUE **RELEASE** (UNTIL FINISHED)

> [!CAUTION]
**After** the Pull Request is merged and **before** starting the official nomock release step, watch [the following Prow Job](https://prow.k8s.io/?job=post-k8sio-image-promo) and wait for it to succeed.

If the job fails, look into the root cause and message the Slack thread. In many cases a rerun is fine (such as 429 too many requests).

To Rerun, click the refresh icon button shown below:

![image](https://hackmd.io/_uploads/Bk6UOW5Kyg.png)


> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after the image promotion step

## 7. Cut the actual release

You should have copied the no mock release command output from the nomock stage previously, now you can run the release:

```
krel release --nomock --build-version=v1.xx.yy-alpha|beta|rc-z+<some-hash>
```

> [!NOTE]
Remember to update the Slack ([thread](#Create-a-thread-on-release-management)) and the release-cut GitHub [issue](#Release-cut-issue) after this no-mock release step.

## 8. Notify public dev Google group mailinglist

> **NOTE from February 2025: Using manual is the preferred method given current issues with Sendgrid.**

### Manually create release HTML announcements

Sometimes you might need to manually send the announcement, in which case you can run this command:

```
krel announce send -p --tag v1.xx.yy-alpha|beta|rc-z --name "First Last" --email "your-email@gmail.com" > ~/Downloads/announce.html
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

## 9. Notify stakeholders

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
```

## 10. Update schedule on k/website

> [!NOTE]
**Only for patch releases**

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

Close out related issues, open new issues if you find any, and ask Google admins to revoke your personal access to GCP if it is no longer required.
You might want to delete your GitHub access token too.
