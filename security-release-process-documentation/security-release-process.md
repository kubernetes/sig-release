# Security Release Process

Kubernetes is a large growing community of volunteers, users, and vendors. The Kubernetes community has adopted this security disclosures and response policy to ensure we responsibly handle critical issues.


**Table of Contents**

- [Product Security Team (PST)](#product-security-team-pst)
  * [Product Security Team Membership](#product-security-team-membership)
    + [Roles](#roles)
      - [Release/Project Manager](#release-project-manager)
      - [Triage](#triage)
      - [Infra](#infra)
      - [Disclosure](#disclosure)
    + [Per-Issue Assignment Options](#per-issue-assignment-options)
      - [Scheduled Rotation](#scheduled-rotation)
      - [Queue](#queue)
    + [Release Manager Role](#release-manager-role)
- [Disclosures](#disclosures)
  * [Private Disclosure Processes](#private-disclosure-processes)
  * [Public Disclosure Processes](#public-disclosure-processes)
- [Patch, Release, and Public Communication](#patch-release-and-public-communication)
  * [Fix Team Organization](#fix-team-organization)
  * [Fix Development Process](#fix-development-process)
  * [Fix Disclosure Process](#fix-disclosure-process)
  * [Retrospective](#retrospective)
- [Private Distributors List](#private-distributors-list)
  * [Embargo Policy](#embargo-policy)
  * [Contributing Back](#contributing-back)
  * [Membership Criteria](#membership-criteria)
  * [Requesting to Join](#requesting-to-join)
- [Security Bug Bar](#security-bug-bar)
  * [Server](#server)
    + [Critical](#critical)
      - [Elevation of privilege](#elevation-of-privilege)
      - [Information disclosure (targeted)](#information-disclosure-targeted)
    + [Important](#important)
      - [Denial of service](#denial-of-service)
      - [Elevation of privilege](#elevation-of-privilege-1)
      - [Spoofing](#spoofing)
      - [Tampering](#tampering)
      - [Security features](#security-features)
      - [Information disclosure (targeted)](#information-disclosure-targeted-1)
    + [Moderate](#moderate)
      - [Denial of service](#denial-of-service-1)
      - [Spoofing](#spoofing-1)
      - [Tampering](#tampering-1)
      - [Security assurances](#security-assurances)
    + [Low](#low)
      - [Tampering](#tampering-2)
  * [Client](#client)
    + [Critical](#critical-1)
      - [Elevation of privilege](#elevation-of-privilege-2)
      - [Information disclosure (targeted)](#information-disclosure-targeted-2)
    + [Important](#important-1)
      - [Denial of service](#denial-of-service-2)
      - [Elevation of privilege](#elevation-of-privilege-3)
      - [Tampering](#tampering-3)
      - [Security features](#security-features-1)
      - [Information disclosure (targeted)](#information-disclosure-targeted-3)
    + [Moderate](#moderate-1)
      - [Tampering](#tampering-4)
      - [Security assurances](#security-assurances-1)
    + [Low](#low-1)
      - [Denial of service](#denial-of-service-3)
      - [Tampering](#tampering-5)

## Product Security Team (PST)

Security vulnerabilities should be handled quickly and sometimes privately. The primary goal of this process is to reduce the total time users are vulnerable to publicly known exploits.

The Product Security Team (PST) is responsible for organizing the entire response including internal communication and external disclosure but will need help from relevant developers and release managers to successfully run this process.

The initial Product Security Team will consist of four volunteers subscribed to the private [Kubernetes Security](https://groups.google.com/forum/#!forum/kubernetes-security) list. These are the people who have been involved in the initial discussion and volunteered:

- Brandon Philips (**[@philips](https://github.com/philips)**) `<brandon.philips@coreos.com>` [4096R/154343260542DF34]
- Jess Frazelle (**[@jessfraz](https://github.com/jessfraz)**) `<jess@linux.com>` [4096R/0x18F3685C0022BFF3]
- CJ Cullen (**[@cjcullen](https://github.com/cjcullen)**) `<cjcullen@google.com>`
- Tim Allclair (**[@tallclair](https://github.com/tallclair)**) `<tallclair@google.com>` [4096R/0x5E6F2E2DA760AF51]
- Jordan Liggitt (**[@liggitt](https://github.com/liggitt)**) `<jliggitt@redhat.com>` [4096R/0x39928704103C7229]

### Product Security Team Membership

Membership to the product security team is based on filling a specific role.
These are defined below to make sure everyone "carries water".

#### Roles

##### Release/Project Manager

Per issue, sees it through to the end. The sheep herder.
A rotating role so we can make sure everyone helps and no one is stuck constantly with the sheep herding.

##### Triage

Makes sure the people who should be in "the know" (aka notified) are notified, also responds to issues that are not actually issues and lets the OP know that.
This person is the escalation path for a bug if it is one.
Right now it seems like it's a kinda first come, first served, in that who ever responds first basically does this or escalates to someone who can.

##### Infra

Making sure we can test the fixes appropriately. This person is the build cop.
Who do you call when the cluster is not well or you gotta test something weird, or the release branch is all messed up? This person.

##### Disclosure

Handles public messaging around the bug. Documentation on how to upgrade. Changelog. Explaining to public the severity. Notifications of bugs sent to mailing lists etc. Requests CVEs.

#### Per-Issue Assignment Options

##### Scheduled Rotation

Each week has a primary & secondary for each role. If something comes up that week, primary owns it. Secondary is there if we can't get a hold of the primary, or if primary has a really good reason why they can’t handle it.

##### Queue

Each role has an ordered list of “who’s handling the next issue.” If something comes up, top of the list takes it. If we can’t contact them, or they have a good reason not to, we go down the list. We’d probably need some coordination of vacation schedules to make sure we don’t leave a role unstaffed.

#### Release Manager Role

Also included on the private [Kubernetes Security](https://groups.google.com/forum/#!forum/kubernetes-security) list are all [Release Managers](/release-managers.md).

It is the responsibility of the PST to add and remove Release Managers as Kubernetes minor releases created and deprecated.

## Disclosures

### Private Disclosure Processes

The Kubernetes Community asks that all suspected vulnerabilities be privately and responsibly disclosed via the Private Disclosure process available at [https://kubernetes.io/security](https://kubernetes.io/security).

### Public Disclosure Processes

If you know of a publicly disclosed security vulnerability please IMMEDIATELY email [kubernetes-security@googlegroups.com](mailto:kubernetes-security@googlegroups.com) to inform the Product Security Team (PST) about the vulnerability so they may start the patch, release, and communication process.

If possible the PST will ask the person making the public report if the issue can be handled via a private disclosure process. If the reporter denies the PST will move swiftly with the fix and release process. In extreme cases you can ask GitHub to delete the issue but this generally isn't necessary and is unlikely to make a public disclosure less damaging.

## Patch, Release, and Public Communication

For each vulnerability a member of the PST will volunteer to lead coordination
with the Fix Team, Release Managers and is responsible for sending disclosure
emails to the rest of the community. This lead will be referred to as the Fix Lead.

The role of Fix Lead should rotate round-robin across the PST.

All of the timelines below are suggestions and assume a Private Disclosure.
The Fix Lead drives the schedule using their best judgment based on severity,
development time, and release manager feedback. If the Fix Lead is dealing with
a Public Disclosure all timelines become ASAP. If the fix relies on another
upstream project's disclosure timeline, that will adjust the process as well.
We will work with the upstream project to fit their timeline and best protect
our users.

### Fix Team Organization

These steps should be completed within the first 24 hours of Disclosure.

- The Fix Lead will work quickly to identify relevant engineers from the affected projects and packages and CC those engineers into the disclosure thread. This selected developers are the Fix Team. A best guess is to invite all assignees in the OWNERS file from the affected packages.
- The Fix Lead will get the Fix Team access to private security repos to develop the fix.

### Fix Development Process

These steps should be completed within the 1-7 days of Disclosure.

- The Fix Lead and the Fix Team will create a [CVSS](https://www.first.org/cvss/specification-document) using the [CVSS Calculator](https://www.first.org/cvss/calculator/3.0). The Fix Lead makes the final call on the calculated CVSS; it is better to move quickly than make the CVSS perfect.
- The Fix Team will notify the Fix Lead that work on the fix branch is complete once there are LGTMs on all commits in the private repo from one or more relevant assignees in the relevant OWNERS file.

If the CVSS score is under 4.0 ([a low severity score](https://www.first.org/cvss/specification-document#i5)) the Fix Team can decide to slow the release process down in the face of holidays, developer bandwidth, etc. These decisions must be discussed on the kubernetes-security mailing list.

### Fix Disclosure Process

With the Fix Development underway the Fix Lead needs to come up with an overall communication plan for the wider community. This Disclosure process should begin after the Fix Team has developed a Fix or mitigation so that a realistic timeline can be communicated to users.

**Disclosure of Forthcoming Fix to Users** (Completed within 1-7 days of Disclosure)

- The Fix Lead will email [kubernetes-announce@googlegroups.com](https://groups.google.com/forum/#!forum/kubernetes-announce) and [kubernetes-security-announce@googlegroups.com](https://groups.google.com/forum/#!forum/kubernetes-security-announce) informing users that a security vulnerability has been disclosed and that a fix will be made available at YYYY-MM-DD HH:MM UTC in the future via this list. This time is the Release Date. This will be the action of any release that causes a new release of [github.com/kubernetes/kubernetes/releases](https://github.com/kubernetes/kubernetes/releases). Any other releases should use [kubernetes-users@googlegroups.com](https://groups.google.com/forum/#!forum/kubernetes-users).
- The Fix Lead will include any mitigating steps users can take until a fix is available.

The communication to users should be actionable. They should know when to block time to apply patches, understand exact mitigation steps, etc.

**Optional Fix Disclosure to Private Distributors List** (Completed within 1-14 days of Disclosure):

- The Fix Lead will make a determination with the help of the Fix Team if an issue is critical enough to require early disclosure to distributors. Generally this Private Distributor Disclosure process should be reserved for remotely exploitable or privilege escalation issues. Otherwise, this process can be skipped.
- The Fix Lead will email the patches to kubernetes-distributors-announce@googlegroups.com so distributors can prepare builds to be available to users on the day of the issue's announcement. Distributors should read about the [Private Distributors List](#private-distributors-list) to find out the requirements for being added to this list.
- **What if a vendor breaks embargo?** The PST will assess the damage. The Fix Lead will make the call to release earlier or continue with the plan. When in doubt push forward and go public ASAP.

**Fix Release Day** (Completed within 1-21 days of Disclosure)

- The Release Managers will ensure all the binaries are built, publicly available, and functional before the Release Date.
  - TODO: this will require a private security build process.
- The Release Managers will create a new patch release branch from the latest patch release tag + the fix from the security branch. As a practical example if v1.5.3 is the latest patch release in kubernetes.git a new branch will be created called v1.5.4 which includes only patches required to fix the issue.
- The Fix Lead will cherry-pick the patches onto the master branch and all relevant release branches. The Fix Team will LGTM and merge.
- The Release Managers will merge these PRs as quickly as possible. Changes shouldn't be made to the commits even for a typo in the CHANGELOG as this will change the git sha of the already built and commits leading to confusion and potentially conflicts as the fix is cherry-picked around branches.
- The Fix Lead will request a CVE from [DWF](https://github.com/distributedweaknessfiling/DWF-Documentation) and include the CVSS and release details.
- The Fix Lead will email kubernetes-{dev,users,announce,security-announce}@googlegroups.com now that everything is public announcing the new releases, the CVE number, the location of the binaries, and the relevant merged PRs to get wide distribution and user action. As much as possible this email should be actionable and include links how to apply the fix to users environments; this can include links to external distributor documentation. The recommended target time is 4pm UTC on a non-Friday weekday. This means the announcement will be seen morning Pacific, early evening Europe, and late evening Asia.
- The Fix Lead will remove the Fix Team from the private security repo.

### Retrospective

These steps should be completed 1-3 days after the Release Date. The retrospective process [should be blameless](https://landing.google.com/sre/book/chapters/postmortem-culture.html).

- The Fix Lead will send a retrospective of the process to kubernetes-dev@googlegroups.com including details on everyone involved, the timeline of the process, links to relevant PRs that introduced the issue, if relevant, and any critiques of the response and release process.
- The Release Managers and Fix Team are also encouraged to send their own feedback on the process to kubernetes-dev@googlegroups.com. Honest critique is the only way we are going to get good at this as a community.

## Private Distributors List

This list is intended to be used primarily to provide actionable information to
multiple distribution vendors at once. This list is not intended for
individuals to find out about security issues.

### Embargo Policy

The information members receive on kubernetes-distributors-announce must not be
made public, shared, nor even hinted at anywhere beyond the need-to-know within
your specific team except with the list's explicit approval. This holds
true until the public disclosure date/time that was agreed upon by the list.
Members of the list and others may not use the information for anything other
than getting the issue fixed for your respective distribution's users.

Before any information from the list is shared with respective members of your
team required to fix said issue, they must agree to the same terms and only
find out information on a need-to-know basis.

In the unfortunate event you share the information beyond what is allowed by
this policy, you _must_ urgently inform the kubernetes-security@googlegroups.com
mailing list of exactly what information
leaked and to whom. A retrospective will take place after the leak so
we can assess how to not make the same mistake in the future.

If you continue to leak information and break the policy outlined here, you
will be removed from the list.

### Contributing Back

This is a team effort. As a member of the list you must carry some water. This
could be in the form of the following:

**Technical**

- Review and/or test the proposed patches and point out potential issues with
  them (such as incomplete fixes for the originally reported issues, additional
  issues you might notice, and newly introduced bugs), and inform the list of the
  work done even if no issues were encountered.

**Administrative**

- Help draft emails to the public disclosure mailing list.
- Help with release notes.

### Membership Criteria

To be eligible for the kubernetes-distributors-announce mailing list, your
distribution should:

1. Be an actively maintained distribution of kubernetes components.
2. Have a user base not limited to your own organization.
3. Have a publicly verifiable track record up to present day of fixing security
   issues.
4. Not be a downstream or rebuild of another distribution.
5. Be a participant and active contributor in the community.
6. Accept the [Embargo Policy](#embargo-policy) that is outlined above.
7. Be willing to [contribute back](#contributing-back) as outlined above.
8. Have someone already on the list vouch for the person requesting membership
   on behalf of your distribution.

### Requesting to Join

New membership requests are sent to kubernetes-security@googlegroups.com.

In the body of your request please specify how you qualify and fulfill each
criterion listed in [Membership Criteria](#membership-criteria).

Here is a psuedo example:

```
To: kubernetes-security@googlegroups.com
Subject: Seven-Corp Membership to kubernetes-distributors-announce

Below are each criterion and why I think we, Seven-Corp, qualify.

> 1. Be an actively maintained distribution of kubernetes components.

We distribute the "Seven" distribution of kubernetes [link]. We have been doing
this since 1999 before containers were even cool.

> 2. Have a user base not limited to your own organization.

Our user base spans of the extensive "Seven" community. We have a slack and
GitHub repos and mailing lists where the community hangs out. [links]

> 3. Have a publicly verifiable track record up to present day of fixing security
   issues.

We announce on our blog all upstream patches we apply to "Seven." [link to blog
posts]

> 4. Not be a downstream or rebuild of another distribution.

This does not apply, "Seven" is a unique snowflake distribution.

> 5. Be a participant and active contributor in the community.

Our members, Acidburn, Cereal, and ZeroCool are outstanding members and are well
known throughout the kubernetes community. Especially for their contributions
in hacking the Gibson.

> 6. Accept the Embargo Policy that is outlined above.

We accept.

> 7. Be willing to contribute back as outlined above.

We are definitely willing to help!

> 8. Be willing and able to handle PGP-encrypted email.

Yes.

> 9. Have someone already on the list vouch for the person requesting membership
   on behalf of your distribution.

CrashOverride will vouch for Acidburn joining the list on behalf of the "Seven"
distribution.
```

## Security Bug Bar

The content presented below outline basic criteria when considering the effect
of bugs disclosed to the Product Security Team and their severity. These apply
mostly to items in "core" but could be abstractly applied to those in other
repos as well.

### Server

The server bar is usually not appropriate when user interaction is part of 
the exploitation process. If a "Critical" vulnerability exists only on server 
components, and is exploited in a way that requires user interaction and results 
in the compromise of the server, the severity may be reduced from "Critical" to 
"Important" in accordance with the data definition of extensive user 
interaction presented at the start of the client severity pivot.

The "server" pertains to any server-side components we distribute, but you can
specifically think of `kube-apiserver`, `kubelet`, and `cloud-controller-manager`
being the main ones.

#### Critical

Network worms or _unavoidable_ cases where the server is "owned."

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than 
authorized. 

- Remote Anonymous User
    - Unauthorized access. Examples:
        - read and write access to API objects
        - arbitrary writing to the file system or server components like etcd
        - getting data from the server or server components
    - Execution of arbitrary code (remote code execution in the server)

This includes all write access violations and exploitable reads.

##### Information disclosure (targeted)

Cases where the attacker can locate and read information from anywhere on the 
system, including system information that was not intended or designed to be 
exposed.

- Remote Anonymous User
    - Unauthorized access. Examples:
        - Personally identifiable information (PII) disclosure
        - Disclosure of PII (email addresses, cloud provider credentials)
        - Attacker can collect PII without user consent or in a covert fashion

#### Important

Non-default critical scenarios or cases where mitigations exist that can help 
prevent critical scenarios.

##### Denial of service

Must be "easy to exploit" by sending a small amount of data or be otherwise 
quickly induced.

- Remote Anonymous User 
    - Persistent DoS. Examples:
        - Sending a single malicious TCP packet results in service failure
        - Sending a small number of packets that causes a service failure
    - Temporary DoS with amplification. Examples:
        - Sending a small number of packets that causes the system to be 
          unusable for a period of time
        - Server being down for a minute or longer
        - A single remote client consuming all available resources 
          (sessions, memory) on a server by establishing sessions and keeping them open

- Authenticated User
    - Persistent DoS against a high value asset. Example:
        - Sending a small number of packets that causes a service failure for 
          a high value asset in server roles 
          (API server, etcd, controllers, etc), such as when a 
          authenticated user can perform a DoS on etcd

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than 
authorized. 

- Authenticated User
    - Unauthorized access. Examples:
        - arbitrary writing to the file system or server components like etcd,
          where the user should not have the ability to write
        - reading or writing to API objects where the user should not be able
          to
        - getting data from the server or server components, where the user
          should not have the ability to read
    - Execution of arbitrary code (remote code execution in the server)

This includes all write access violations and exploitable reads.

##### Spoofing

An entity (computer, server, user, process) is able to masquerade as a 
specific entity (user or computer) of his/her choice.

Examples:
- Service masquerades as the API server for the cluster and effectively
  man-in-the-middle's the real API server.
- API server uses client certificate authentication (SSL) improperly to allow 
  an attacker to be identified as any user of his/her choice
- RBAC bug that allows a malicious remote user to be seen as a different user 
  of his or her choice

##### Tampering

Modification of any “high value asset” data in a common or default scenario 
where the modification persists. This includes permanent or persistent 
modification of any user or system data used in a common or default scenario.

Examples:

- Modification of application data files or databases in a common or default
  scenario, such as authenticated etcd injection
- Modification of cluster or API objects without user consent in a common or 
  default scenario

##### Security features

Breaking or bypassing any security feature provided. A vulnerability in a 
security feature is rated “Important” by default, but the rating may be adjusted
based on other considerations as documented here.

Examples:

- Disabling or bypassing a `NetworkPolicy` or `PodSecurityPolicy` without 
  informing users or gaining consent
- Reconfiguring a `NetworkPolicy` and allowing connections to other processes
  without consent

##### Information disclosure (targeted)

Cases where the attacker can easily read information on the system from 
specific locations, including system information, which was not 
intended/designed to be exposed.

Examples:

- Targeted disclosure of the existence of a file
- Targeted disclosure of anonymous data

#### Moderate

##### Denial of service

- Remote Anonymous User 
    - Temporary DoS _without_ amplification. Examples:
        - Multiple remote clients consuming all available resources 
          (sessions, memory) on a server by establishing sessions and 
          keeping them open

- Authenticated User
    - Persistent DoS. Example:
        - Logged in user can send a specific object and crash the API Server, 
          and the crash is not due to a write access violation, exploitable 
          or read access violation

##### Spoofing

An entity (computer, server, user, process) is able to masquerade as a 
different, random entity that cannot be specifically selected.

Examples:
- Client properly authenticates to server, but server hands back a session 
  from another random user who happens to be connected to the server at the 
  same time

##### Tampering

Permanent or persistent modification of any user or system data in a specific scenario

Examples:

- Modification of application data files or databases in a specific scenario, 
  for example writing to etcd when a user adds a specific type of API object and
  only if the API version is v2.1
- Modification of cluster or API objects without user consent in a specific scenario

##### Security assurances

A security assurance is either a security feature or another product 
feature/function that customers expect to offer security protection. 
Communications have messaged (explicitly or implicitly) that customers can 
rely on the integrity of the feature, and that’s what makes it a security 
assurance. Security bulletins will be released for a shortcoming in a security 
assurance that undermines the customer’s reliance or trust.

Examples:

- Processes running with normal “user” privileges cannot gain “admin” 
  privileges unless admin password/credentials have been provided 
  via intentionally authorized methods.

#### Low

##### Tampering

Temporary modification of data in a specific scenario that does not persist.

### Client

"User interaction" can only happen in client-driven scenario. 
Using `kubectl` or a client library are extensive user interaction.

The effect of extensive user interaction is not one level reduction in severity,
but is and has been a reduction in severity in certain circumstances where the
phrase extensive user interaction appears in the bug bar. The intent is to help
differentiate fast-spreading and wormable attacks from those, where because 
the user interacts, the attack is slowed down. This bug bar does not allow you 
to reduce the Elevation of Privilege below "Important" because of user interaction.


#### Critical

Network worms or _unavoidable_ cases where the client is "owned" without
warnings or prompts.

##### Elevation of privilege 

The ability to either execute arbitrary code or obtain more privilege than 
authorized. 

- Remote Anonymous User
    - Unauthorized access. Examples:
        - read and write access to API objects
        - arbitrary writing/reading to/from the file system 
    - Execution of arbitrary code (remote code execution via client)

This includes all write access violations and exploitable reads.

##### Information disclosure (targeted)

Cases where the attacker can locate and read information from anywhere on the 
system, including system information that was not intended or designed to be 
exposed.

- Remote Anonymous User
    - Unauthorized access. Examples:
        - Personally identifiable information (PII) disclosure
        - Disclosure of PII (email addresses, local data)
        - Attacker can collect PII without user consent or in a covert fashion
        - Client "phone-ing home" without permission

#### Important

Non-default critical scenarios or cases where mitigations exist that can help 
prevent critical scenarios.

##### Denial of service

System corruption DoS requires re-installation of system and/or components.

Examples:

- Calling a `kubectl` command makes the local machine unbootable.

##### Elevation of privilege

The ability to either execute arbitrary code or obtain more privilege than 
authorized. 

- Authenticated User
    - Unauthorized access. Examples:
        - arbitrary writing to the file system,
          where the user should not have the ability to write
        - reading or writing to API objects where the user should not be able
          to
        - local low privilege user can elevate themselves to another user,
          administrator, or local system.
    - Execution of arbitrary code (remote code execution via the client)

This includes all write access violations and exploitable reads.

##### Tampering

Modification of any user data or data used to make trust decisions 
in a common or default scenario where the modification persists. 
This includes permanent or persistent modification of any user or system data 
used in a common or default scenario.

Examples:

- Modification of application data files such as `~/.kube` in a specific
  scenario
- Modification of cluster or objects without user consent in a specific scenario

##### Security features

Breaking or bypassing any security feature provided. A vulnerability in a 
security feature is rated “Important” by default, but the rating may be adjusted
based on other considerations as documented here.

Examples:

- Disabling or bypassing a RBAC without informing users or gaining consent
- Reconfiguring RBAC without consent

##### Information disclosure (targeted)

Cases where the attacker can read information on the system from known 
locations, including system information that was not intended or designed to 
be exposed.

Examples:

- Targeted existence of a file

#### Moderate

##### Tampering

Modification of any user data or data used to make trust decisions 
in a specific scenario where the modification persists. 
This includes permanent or persistent modification of any user or system data 
used in a specific scenario.

Examples:

- Modification of application data files such as `~/.kube` in a specific scenario
- Modification of cluster or objects without user consent in a specific scenario

##### Security assurances

A security assurance is either a security feature or another product 
feature/function that customers expect to offer security protection. 
Communications have messaged (explicitly or implicitly) that customers can 
rely on the integrity of the feature, and that’s what makes it a security 
assurance. Security bulletins will be released for a shortcoming in a security 
assurance that undermines the customer’s reliance or trust.

Examples:

- Processes running with normal “user” privileges cannot gain “admin” 
  privileges unless admin password/credentials have been provided 
  via intentionally authorized methods.

#### Low

##### Denial of service

Temporary DoS requires restart of the client application.

Example:

- Running a `kubectl` command crashes the client.

##### Tampering

Temporary modification of data in a specific scenario that does not persist.
