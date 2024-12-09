# Release Notes Editing Flow
  - [Introduction](#introduction)
  - [Motivation](#motivation)
  - [Workflow Operation](#workflow-operation)
    - [krel release-notes --fix](#krel-release-notes--fix)
      - [Starting the interactive mode](#starting-the-interactive-mode)
      - [Reviewing and editing the release notes](#reviewing-and-editing-the-release-notes)
      - [Exiting the review loop](#exiting-the-review-loop)
    - [Submitting changes back](#submitting-changes-back)
    - [Re-running the workflow](#re-running-the-workflow)
      - [Modified Release Notes](#modified-release-notes)


## Introduction

Ensuring the production of a document comprised of well written and 
informative release notes is one of the responsibilities of the 
Release Team each cycle. 

A good introduction talk is the "[Lightning Talk: Kubernetes Release Notes Tips & Tricks](https://www.youtube.com/watch?v=n62oPohOyYs)" 
where you can find some general guidelines about the release notes 
(wording, grammar, labels, etc).

Release Engineering has developed various tools to help the Team 
complete its duties. One of them is `krel` — the [Kubernetes Release
Toolbox](https://github.com/kubernetes/release/tree/master/docs/krel).
Krel has many subcommands that help the release process in many ways,
among them the `release-notes` subcommand.

This document details how to use krel to review and edit the 
Kubernetes release notes during the cycle. 

## Motivation

The final Kubernetes Release Notes document is a large document composed of
hundreds of entries that the contributors write into their Pull Requests. As
an example, the [release notes document for Kubernetes 1.19](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md)
has 388 entries.

Before v1.20, the Release Notes Team had to wait until code freeze to review
and edit each Kubernetes release note in a short time. During the same
timespan, the Team was expected to contact the sigs and edit the Major themes.
Work was unbalanced with little to do most of the cycle and a packed 
agenda during the last few weeks. 

To balance the team's efforts evenly, tooling was developed to enable a new workflow.

## Workflow Operation

Reviewing the release notes involves running krel regularly to review new release
notes in incoming pull requests, possibly editing some of them, and submitting
changes back to the `sig-release` repository.

### `krel release-notes --fix`

The main interactive editing flow is started with the `--fix` flag. The interactive
mode will show the user all release notes that need to be reviewed. After
reviewing each note, the user can edit the note's attributes using their editor of
choice.

The `--fix` flag is available when invoking krel with the `--create-draft-pr` option.
This is an example invocation to edit the release notes for Kubernetes v1.19:

```bash
krel release-notes --create-draft-pr --org=MyGitHubOrg --fix --tag=v1.19.0
```
As with all `krel release-notes` subcommands, a GitHub token must be exported in
an environment variable called `GITHUB_TOKEN`. The user should supply their GitHub
organization where krel will push changes and from where it will create pull
requests.

After invoking the subcommand, krel will clone the `kubernetes/kubernetes` repository
and query GitHub for all pull requests filed during the specified range. Note that
this process might take a long time, particularly at the end of the cycle when the
branch has lots of commits.

Since the note gatherer hits the GitHub API quite heavily, you will get rate limited.
During a normal operation `krel` will handle them correctly, but you may find yourself
forced to wait when doing several runs after one another. 


#### Starting the interactive mode

When `--fix` is used, krel will switch to interactive mode.
It will print a short intro and prompt the user before starting:

```
Welcome to the Kubernetes Release Notes editing tool!

This tool will allow you to review and edit all the release
notes submitted by the Kubernetes contributors before publishing
the updated draft.

The flow will show each of the release notes that need to be
reviewed once and you can choose to edit it or not.

After you choose, it will be marked as reviewed and will not
be shown during the next sessions unless you choose to do a
full review of all notes.

You can hit Ctrl+C at any time to exit the review process
and submit the draft PR with the revisions made so far.

Would you like to continue from the last session? (y/n):
``` 

#### Reviewing and editing the release notes

Once started, the flow will present the user each release note to
review. If the user's notices a field that needs to be changed, 
they might choose to edit that note. Here is an example:

```
Release Note for PR 92546:
==========================
Pull Request URL: https://github.com/kubernetes/kubernetes/pull/92546
    Author: @liggitt
    SIGs: [api-machinery]
    Kinds: [cleanup]
    Areas: [custom-resources]
    Feature: false
    ActionRequired: false
    ReleaseVersion: 1.19.0
    Text:
    │ kube-apiserver: openapi schemas published for custom resources now reference
    │ standard ListMeta schema definitions

- Fix note for PR #92546? (y/N): 

```

If the user chooses to edit the note when prompted, krel will open the current note
in the default editor (defined in `$EDITOR`) for the user to edit:

```
---
# This is the current map for this Pull Request.
# The original note content is commented out, if you need to
# change a field, remove the comment and change the value.
# To cancel, exit without changing anything or leave the file blank.
# Important! pr: and releasenote: have to be uncommented.
#
# pr: 92546
# releasenote:
#   text: 'kube-apiserver: openapi schemas published for custom resources now reference
#     standard ListMeta schema definitions'
#   documentation: []
#   author: liggitt
#   areas:
#   - custom-resources
#   kinds:
#   - cleanup
#   sigs:
#   - api-machinery
#   feature: false
#   action_required: false
#   release_version: 1.19.0
~
~                                  
~                       
```

By default, all the note's fields are commented out. The user can choose one or more
fields to uncomment and modify. If at least one field is modified, a [release note map
file](https://github.com/kubernetes/release/blob/master/docs/release-notes-maps.md) 
will be created in the release directory after saving the file and exiting the editor.

__Note:__ A valid map file should have at least the PR number and the releasenote struct.

If the user makes an error (a YAML syntax error for example), krel will prompt the user
to retry editing the note:

```
ERRO The yaml code does not have a PR number      
- An error occurred while editing PR #92546. Try again? (y/n)
```

#### Exiting the review loop

When in the interactive cycle, krel will present the user with every release note that
has not yet been reviewed. It is not necessary to review all the notes in one go, at
any time the user may hit Ctrl+C and the interactive flow will exit at that point.

To continue the editing process at a later time, `krel` will save its state
in the release directory. It will store information about each review session inside of
the `release-notes/sessions/`. The JSON files include the user's data and the release
notes reviewed during the session.

At this point, krel will create the current release notes draft. This file is the 
latest version of the automatically generated release notes and is made public for
any interested party to review. 

### Submitting changes back

After exiting the interactive mode, krel will prompt the user to create a pull request
submitting all changes back to the sig-release repository:

```
INFO Release Notes Draft written to /tmp/k8s-730127624/releases/release-1.19/release-notes-draft.md 
Create pull request with your changes? (y/n): 
```

If the user choses so, krel will create the pull request on their behalf by creating a
branch in their sig-release fork, pushing the changes, and creating the PR in GitHub. 

Note that the PR will include the release notes draft with all changes defined in
the maps during the editing flow. All the mapping files and session data will be
submitted in the same PR.

If the user cancels the PR, the local fork of sig-release will be left in a temporary
directory with all changes done by krel. To submit the changes back to sig-release, 
the user will be required to push and create the PR manually. To assist them with this
process, krel will show some instructions:

```
Create pull request with your changes? (y/n): n
Pull request creation was canceled. Your local copy of k/sig-release
has not been deleted for you to review your changes. You may
push your changes to your fork and create the PR from there.

Your fork of kubernetes/sig-release was cloned here:
/tmp/k8s-730127624

WARN Pull request canceled. Local changes were not pushed back.
```

Needless to say, all editing not PR'ed back to sig-release will be lost.

### Re-running the workflow

It is highly recommended that the Release Notes team runs the editing flow
frequently (say on a weekly basis), alternating team members ensure the
current user has a reasonable amount of work to do and the editing effort
is split fairly.

Thanks to the session files, each subsequent run of krel will remember where
it left off. This means that each user will need to review only new Pull
Requests that are filed after the last run.

#### Modified Release Notes

During the release cycle, each Pull Request author and/or admins may modify
the release note and/or flags in GitHub. When this happens, krel will detect
the change and will present the note again for review, flagging it so that the 
user knows that the contents have been modified:

```
Release Note for PR 92546:
✨ Note contents are modified with a map
==========================
Pull Request URL: https://github.com/kubernetes/kubernetes/pull/92546
    Author: @liggitt
    SIGs: [api-machinery]
```

