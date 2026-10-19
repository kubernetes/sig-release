# Kubernetes Release Docs Team - Branch Sync Script

Bash script to perform the weekly branch syncs of the Docs team.

## Description

Each week the Docs team merges the `main` branch into the
`dev-<future release>` branch of kubernetes/website to avoid merge conflicts
on release day. This script provides a user friendly execution of the branch
sync commands from the
[release timeline](../release-timeline.md#weekly-branch-sync-prs).

## Getting started

### Installing

Download the script or clone this repo and add executable permissions to the
script to allow it to run:

```
chmod +x branch-sync.sh
```

## Usage

```
Usage: ./branch-sync.sh FUTURE_RELEASE [-p | --push] [-u | --user USER]
Options:
  -p, --push    Push the branch sync automatically without prompting
  -u, --user    Set the GitHub user that owns the website fork
  -h, --help    Display this help message
```

The script clones your fork into a `website` directory in the current
working directory. Remove or rename that directory before running the script
again.

### Example start of the script

```
$ ./branch-sync.sh 1.XX -u <your GitHub username>
USER: <your GitHub username>
FUTURE_RELEASE: 1.XX
AUTO_PUSH: false
Do you want to proceed with these values? (y/n):
```
