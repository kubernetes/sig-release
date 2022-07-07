# Release Manager selection

> DISCLAIMER: The initial draft of this document is intended to capture the
> current state of the Release Manager selection process. It is neither a
> perfect, nor complete process, but it is one that we have at present,
> so hopefully documenting it is a step in the right direction.

As described on the Kubernetes Community [website][release-managers-page], the
Release Managers group is a group of Kubernetes contributors (under the Release
Engineering subproject of SIG Release) which is tasked with publishing
Kubernetes release artifacts, as well as maintaining the processes and tooling
to do so.

- [Expectations](#expectations)
- [Identification](#identification)
- [Selection](#selection)
- [Promotion](#promotion)

## Expectations

(From ["Becoming a Release Manager Associate"][becoming-a-release-manager-associate])

Contributors can become Associates by demonstrating the following:

- consistent participation, including 6-12 months of active release
  engineering-related work
- experience fulfilling a technical lead role on the Release Team during a
  release cycle
  - this experience provides a solid baseline for understanding how SIG Release
    works overall—including our expectations regarding technical skills,
    communications/responsiveness, and reliability
- working on SIG Release items that improve our interactions with Testgrid,
  cleaning up libraries, etc.
  - these efforts require interacting and pairing with Release Managers and
    Associates

There is currently no one accepted process for identifying or selecting
candidate Release Manager Associates.

## Identification

In the past, we have done the following to consider candidates:

- A candidate expresses interest to a Release Manager or SIG lead
- A Release Manager or SIG lead recognizes the work of the candidate and
  suggests they join the team
- A SIG lead reaches out to current Release Team towards the end of the
  release to seed candidates

## Selection

Once a candidate has been identified, SIG leads or senior Release Managers will
do the following:

- discuss the expectations of the role with them
- confirm interest with the candidate
- discuss the candidate with other Release Managers and SIG leads
- vote on confirming the candidate as a Release Manager Associate

If confirmed, members of Release Managers group will work with the candidate
will work with the new Release Manager Associate on [onboarding][onboarding].

## Promotion

(From ["Becoming a Release Manager"][becoming-a-release-manager])

To become a Release Manager, one must first serve as a Release Manager
Associate. Associates graduate to Release Manager by actively working on
releases over several cycles and:

- demonstrating the willingness to lead
- tag-teaming with Release Managers on patches, to eventually cut a release
  independently
  - because releases have a limiting function, we also consider substantial
    contributions to image promotion and other core Release Engineering tasks
- questioning how Associates work, suggesting improvements, gathering feedback,
  and driving change
- being reliable and responsive
- leaning into advanced work that requires Release Manager-level access and
  privileges to complete

[becoming-a-release-manager]: https://kubernetes.io/releases/release-managers/#becoming-a-release-manager
[becoming-a-release-manager-associate]: https://kubernetes.io/releases/release-managers/#becoming-a-release-manager-associate
[onboarding]: https://github.com/kubernetes/sig-release/issues/new?assignees=&labels=sig%2Frelease%2C+area%2Frelease-eng&template=release-manager.md&title=Release+Manager+access+for+%3CGH-handle%3E
[release-managers-page]: https://kubernetes.io/releases/release-managers/
