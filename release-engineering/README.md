# Release Engineering

## Schedule of Recurring Work

These topics recur for release engineering during every release cycle. To keep the team’s workflow more manageable, it’s advisable to account for this work as part of the time/planning budget:

### Weekly

- Cherry pick triage and approval
- Provide status updates at Release Team meetings
 
### Bimonthly

-  k/release updates
   - Go dependencies / go.mod updates
     - We don’t deliver k/release binaries to users, but toolchain artifacts may leak into the actual 
Kubernetes project delivered artifacts—making it important for these dependencies to be updated from a security perspective
   - Push new semver tags to demarcate a release or preferred consumable instance of the release tooling

### Monthly

- Patch releases: 1.Y.Z, 1.Y.(Z-1), ...1.Y.(Z-...n)
 - A week before each patch deadline, notify the community of the pending deadline
 - A week before each patch deadline, generate an updated status report on all cherry picks and share it
 - Cut the three most recent minor versions
 - Communicate to the community ahead of the final release from a release branch, to ensure 
that any final cherry-pick content is merged ahead of that last release
 - Deprovision CI for the oldest release branch after its last release
 - Golang versions in Kubernetes
   - Document the different triage types/priorities and a triage process:
     - Golang 1.X release
     - Golang 1.X.Y release
     - Golang 1.X.Y release with CVE with no or minor Kubernetes impact (what is the maximum CVSS?)
     - Golang 1.X.Y release with CVE with major Kubernetes impact (what is the mininum CVSS?)
   - Document the different triage per repo/image
     - kubernetes/kubernetes
       - UNLESS there are CVEs—then we must address
       - Every update requires an update to bazel rules_go
     - kubernetes/release
       - images/k8s-cloud-builder
       - images/build/cross (kube-cross)
       - images/build/go-runner (arguably part of the Golang version updates above)
     - kubernetes/test-infra
       - kubekins
       - Krte

### Ongoing

- Cut prereleases (Alpha, Beta, Release Candidate) for the minor release in development
 
### Ad Hoc/As Needed

- Update Golang versions in Kubernetes
- Update core Kubernetes base images, e.g.:
- Update core Kubernetes base images, e.g.:
  - CRI tools
  - CNI plugins
  - OS base images (example: debian-base)
  - debian-iptables
  - debian-hyperkube-base
  - Publishing bot updates
    - The bot runs runs on a schedule but sometimes breaks, requiring ad hoc fixes
  - Curation of the [base images exception list](https://github.com/kubernetes/sig-release/blob/master/release-engineering/baseimage-exception-list.md) (most of this list is complete; more info [here](https://github.com/kubernetes/enhancements/issues/1729))
  - Maintaining instructions on how to consume all above official artifacts, plus variations for how 
consumers can test pre-release Alpha/Beta/RC artifacts
  - push-build.sh maintenance, until it goes away
