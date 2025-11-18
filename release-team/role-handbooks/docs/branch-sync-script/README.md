# Kubernetes Release Docs Team - Branch Sync Script

Bash script to use to perform weekly branch syncs for kubernetes release team

## Description

Each week the release docs team needs to merge the `main` branch into `dev-[future release]` branch in order to avoid merge conflicts on release day. This script provides a user friendly execution of the branch sync commands from the [release docs handbook](https://github.com/kubernetes/sig-release/blob/b51237ddb556bb6d24e43d7424e55cb9e66694d5/release-team/role-handbooks/docs/Release-Timeline.md#maintain-the-current-and-upcoming-dev-branch)).

## Getting Started

### Installing

Download the script or clone this repo and add executable permissions to the script to allow it to run
```
chmod +x branch-sync.sh
```

## Usage
```
Usage: ./branch-sync.sh FUTURE_RELEASE [-p | --push] [-u | --user]
Options:
  -p, --push    Push the branch sync automatically
  -u, --user    Manually set github user
  -h, --help    Display this help message
```

### Example Start of Script

```
➜ ./branch-sync.sh 1.31 -u youruser   
USER: youruser
FUTURE_RELEASE: 1.31
AUTO_PUSH: false
Do you want to proceed with these values? (y/n):
```