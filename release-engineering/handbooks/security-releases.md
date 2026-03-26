# Security Releases

This document describes the process for handling security fixes in Kubernetes
releases, including coordinating with the Security Response Committee (SRC) and
managing CVE data maps.

- [Coordination with the Security Response Committee](#coordination-with-the-security-response-committee)
- [CVE data maps](#cve-data-maps)
  - [Creating CVE data maps with krel](#creating-cve-data-maps-with-krel)
  - [Multiple releases affected by the same CVE](#multiple-releases-affected-by-the-same-cve)
  - [Uploading externally provided data maps](#uploading-externally-provided-data-maps)
- [Announcing security fixes](#announcing-security-fixes)
- [Security releases for patch branches](#security-releases-for-patch-branches)

## Coordination with the Security Response Committee

The Security Response Committee (SRC) may contact Release Managers via the
[Security Release Team][security-release-team] mailing list if there are
security fixes needed on a release branch.

Once the release has been confirmed to contain security fixes, the Release
Manager must inform the current Release Team Lead and Lead Shadows. Information
pertaining to these fixes is considered need-to-know and should not be
disseminated to anyone else on the Release Team.

You must not make any public announcements regarding these fixes unless the SRC
tells you to.

See the [Security Release Process](https://git.k8s.io/security/security-release-process.md)
doc for more details.

[security-release-team]: https://groups.google.com/a/kubernetes.io/forum/#!forum/security-release-team

## CVE data maps

Before starting the release process for a release that contains security fixes,
the Release Managers need to reach out to the SRC and ask them to provide a CVE
data map that contains information about security fixes.

A CVE data map file is created for each CVE and looks like this:

```yaml
---
pr: <cherry-pick PR number>
datafields:
  cve:
    id: CVE-2022-0000
    title: "<title for given CVE>"
    description: |
      <description of vulnerability>

      **Affected Versions**:
        - kube-apiserver v1.25.0
        <list of affected versions>...

      **Fixed Versions**:
        - kube-apiserver v1.25.1
        <list of fixed versions>...

      <credits and acknowledgements (optional)>
    trackingissue: "https://github.com/kubernetes/kubernetes/issues/<issue-number>"
    vector: "<cvss vector string>"
    score: <cvss score>
    rating: "<CVE rating (Low/Medium/High/Critical)>"
    linkedprs: []

```

### Creating CVE data maps with krel

The CVE data map can be created using `krel`. Running the following command will
open a text editor with a sample data map. Populating and saving the data map
will automatically upload it to the appropriate (private) bucket (this requires
access to the said bucket, therefore only the Release Managers can use this
command).

```shell
krel cve edit CVE-2022-0000
```

### Multiple releases affected by the same CVE

If multiple affected releases are affected by the same CVE, you must put a data
map for each release in the **same data map file**, such as:

```yaml
---
pr: <cherry-pick PR number for first release branch>
datafields:
  cve:
    id: CVE-2022-0000
    ...
---
pr: <cherry-pick PR number for second release branch>
datafields:
  cve:
    id: CVE-2022-0000
    ...
---
pr: <cherry-pick PR number for third release branch>
datafields:
  cve:
    id: CVE-2022-0000
    ...
```

### Uploading externally provided data maps

If CVE data map YAML files are provided by the SRC (instead of using `krel cve`
command), those files can be uploaded to the appropriate private bucket using
`krel` such as:

```shell
krel cve edit CVE-2022-0000 -f ./path-to-data-map.yaml
```

This command will also take care of validating the provided data map file. Once
the data maps are uploaded, `krel` will (automatically) take those data maps
into account when generating the changelog and the release announcement emails.

## Announcing security fixes

The security fixes are announced upon publishing releases by:

- Including information about security fixes in the release announcement sent to
  kubernetes-announce and dev mailing lists.
- Including information about security fixes in CHANGELOGs for affected
  releases.
- Sending an email announcement for each security fix to the relevant mailing
  lists (done by the Security Response Committee).

The first two are handled by Release Managers in coordination with the SRC.

## Security releases for patch branches

The SRC will contact you via the [Security Release Team][security-release-team]
mailing list if security releases are needed on branches.

In contrast to a normal release, you must not make any public announcements or
push tags or release artifacts to public repositories until the SRC tells you
to.

See the [Security Release Process](https://git.k8s.io/security/security-release-process.md)
doc for more details.
