Kubernetes 1.10 "left shark" Release Burndown 

Self-link: [bit.ly/k8s110-burndown](http://bit.ly/k8s110-burndown)

Agenda [template](https://docs.google.com/document/d/1zLnmDDOp_ko9Yh5uPJtgqPFD7GKq76fQsKaenXoMHzM/edit)

Zoom [Link](http://bit.ly/k8s110-zoom)

## Date: 3/26/2018 ~ tentative Release Day!

Video [Link](https://youtu.be/dbh5RaKSXdQ)

* Release day mechanics:

    * Wrap up release notes, merge into draft that anago will consume

        * Need external dependencies

            * Ask sig-node, sig-api-machinery, etc., See prior list for 1.9 at [https://github.com/kubernetes/sig-release/blob/master/releases/release-1.9/release-notes-draft.md#external-dependencies](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.9/release-notes-draft.md#external-dependencies)

            * Etcd: 3.1.12; from [here](https://github.com/kubernetes/kubernetes/blob/master/hack/lib/etcd.sh#L19) or [here](https://github.com/kubernetes/kubernetes/blob/master/build/root/WORKSPACE#L22); last PR [60998](https://github.com/kubernetes/kubernetes/pull/60998) 

            * Docker:

                * see sig-node and [here](https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/system/docker_validator_test.go) … looks unchanged since 1.8

                * "The validated docker versions are the same as for v1.8 and v1.9: 1.11.2 to 1.13.1 and 17.03.x"

            * Go: 1.9.3; from [here](https://github.com/kubernetes/kubernetes/blob/master/build/root/WORKSPACE#L49); last PR [59012](https://github.com/kubernetes/kubernetes/pull/59012) 

            * CNI: 0.6.0; from [here](https://github.com/kubernetes/kubernetes/blob/master/build/root/WORKSPACE#L57); last PR [51250](https://github.com/kubernetes/kubernetes/pull/51250) 

            * CSI: 0.2.0;  from [here](https://github.com/kubernetes/kubernetes/blob/master/Godeps/Godeps.json#L456); last PR [60736](https://github.com/kubernetes/kubernetes/pull/60736) 

            * Dashboard add-on: 1.8.3, from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/dashboard/dashboard-deployment.yaml#L33), last PR [57326](https://github.com/kubernetes/kubernetes/pull57326) 

            * Heapster: unchanged at 1.5.0 from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/cluster-monitoring/google/heapster-controller.yaml) (note: changes in v1.11)

            * Cluster autoscaler: 1.1.2; from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/gce/manifests/cluster-autoscaler.manifest#L17); last PR [60842](https://github.com/kubernetes/kubernetes/pull/60842) [@mwielgus](https://github.com/mwielgus))

            * Kube-dns: 1.14.8 from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/dns/kube-dns/kube-dns.yaml.base#L98); last PR [58013](https://github.com/kubernetes/kubernetes/pull/58013) and [57918](https://github.com/kubernetes/kubernetes/pull/57918) 

            * influxdb: v1.3.3 and grafana v4.4.3 (unchanged); from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/cluster-monitoring/influxdb/influxdb-grafana-controller.yaml); last PR [53319](https://github.com/kubernetes/kubernetes/pull/53319) 

            * Cadvisor: 0.29.1, from [here](https://github.com/kubernetes/kubernetes/blob/master/Godeps/Godeps.json#L1478), last PR [60867](https://github.com/kubernetes/kubernetes/pull/60867)

            * fluentd-gcp-scaler: 0.3.0, from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-gcp/scaler-deployment.yaml), last PR [61269](https://github.com/kubernetes/kubernetes/pull/61269) 

            * Fluentd: 1.1.0; from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-elasticsearch/fluentd-es-image/Gemfile#L3); last PR [58525](https://github.com/kubernetes/kubernetes/pull/58525),  [@monotek](https://github.com/monotek))

            * Fluentd-elasticsearch: 2.0.4; from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-elasticsearch/fluentd-es-ds.yaml#L51); last PR [58525](https://github.com/kubernetes/kubernetes/pull/58525) 

            * Fluentd-gcp: v3.0.0; from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/fluentd-gcp/fluentd-gcp-ds.yaml#L4); last PR [60722](https://github.com/kubernetes/kubernetes/pull/60722))

            * ingress glbc image: 1.0.0, from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/gce/manifests/glbc.manifest#L16), last PR [61302](https://github.com/kubernetes/kubernetes/pull/61302)

            * oidc authentication: coreos/go-oidc v2; from [here](https://github.com/kubernetes/kubernetes/blob/master/Godeps/Godeps.json#L909) (but must go look at upstream dep to find the tag corresponding to the vendored commit and they don’t actually have releases?), last PR [58544](https://github.com/kubernetes/kubernetes/pull/58544) 

            * Calico: 2.6.7; from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/calico-policy-controller/calico-node-daemonset.yaml#L36); last PR [59130](https://github.com/kubernetes/kubernetes/pull/59130) 

            * COS image version: cos-stable-63-10032-71-0; from [here](https://github.com/kubernetes/kubernetes/blob/master/cluster/gce/config-default.sh#L77); last PR   [57204](https://github.com/kubernetes/kubernetes/pull/57204) [@yujuhong](https://github.com/yujuhong))

            * ...others?

        * Need clarity on PV resize vs volume resize

            * Michelle offered to help

        * Need PVC section (Jennifer)

            * Also ask Michelle? 

        * Known issues to be translated into release notes

    * Final doc check

        * OTW

    * Final signal check on release branch

        * Good to go

    * Final issue check

        * two upgrade issues

            * 61640 ~ testing env issue

            * 61645 ~ test depends on k8s dashboard pod which is not started by default anymore

    * Blog questions:

        * Need someone to insert link for where you download & interactive tutorial

        * Blog series = 2 blogs 

    * Branch manager cuts the release

    * 5pm Pacific ~ Release announcement sent to k8s-dev / announce

    * Media announcement

    * Rejoice!

* Issue review

    * [[test failed] should ensure that critical pod is scheduled in case there is no resources available ](https://github.com/kubernetes/kubernetes/issues/61645)

        * Not approved for milestone

        * This is known issue

        * Test needs to be patched

    * [[test failed] regular resource usage tracking resource tracking for 100 pods per node](https://github.com/kubernetes/kubernetes/issues/61640)

        * Need Google help (gke only)

        * Patch release fix, ACK by dchen

    * [[test flakes] master-scalability suites ](https://github.com/kubernetes/kubernetes/issues/60589)

        * Not blocking

* PR review

    * None

* Test signal review

    * [https://github.com/kubernetes/kubernetes/issues/61640](https://github.com/kubernetes/kubernetes/issues/61640)

        * Gke only, should not be a blocker, but probably need to patch up in following patch release for the testing environment

    * [https://github.com/kubernetes/kubernetes/issues/61645](https://github.com/kubernetes/kubernetes/issues/61645)

        * Dashboard issue again

    * [https://github.com/kubernetes/kubernetes/issues/61483](https://github.com/kubernetes/kubernetes/issues/61483)

        * Due to don’t have branched cross build job

        * Will fix in 1.11

* Docs review

## Date: 3/23/2018

Video [Link](https://youtu.be/QLiym7j60f4)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Risk assessment of what is in flight

        * [https://github.com/kubernetes/kubernetes/pull/61536](https://github.com/kubernetes/kubernetes/pull/61536) 

            * What the heck?

        * Document known issues and workarounds for: (msau, jrondeau, nchase)

            * [https://github.com/kubernetes/kubernetes/issues/61446](https://github.com/kubernetes/kubernetes/issues/61446) 

            * [https://github.com/kubernetes/kubernetes/issues/61456](https://github.com/kubernetes/kubernetes/issues/61456) 

        * [https://github.com/kubernetes/kubernetes/issues/61483](https://github.com/kubernetes/kubernetes/issues/61483) 

            * This job is not going to work properly, not blocking

            * Move job out of dashboard until it’s properly configured

        * [https://github.com/kubernetes/kubernetes/issues/61485](https://github.com/kubernetes/kubernetes/issues/61485) 

            * Done and green

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * Status update

            * Once merged, we need to get perf data to understand if it fixes the issue

    * Confidence check on release date

        * Any changes here?

        * Need SIG Scalability to attend Monday and agree to release

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW ~ Based on scalability regression]

    * Mon:** Release v1.10** 5 pm Pacific ~ Caleb to hold the announce until then, even if it ships earlier

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

    * Draft 1.11 schedule ASAP 

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * Issues Tracking [Spreadsheet](http://bit.ly/k8s110-issues)

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 6 ↑1 

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 6 ↑2

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 3 ↕0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 0 ↕0

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels) issues: 0 ↓1

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 3 ↕0 vs 354 ↑3 closed 

        * [Increase fluentd rolling-upgrade maxUnavailable to large value ](https://github.com/kubernetes/kubernetes/pull/61472)

            * needs approve from one of: [@crassirostris](https://github.com/crassirostris) [@piosz](https://github.com/piosz) [@x13n](https://github.com/x13n)

        * [[1.10] Automated cherry pick of #61373: Use inner volume name instead of outer volume name for subpath directory ](https://github.com/kubernetes/kubernetes/pull/61518)

            * Needs approve from one of: [@Random-Liu](https://github.com/random-liu) [@derekwaynecarr](https://github.com/derekwaynecarr) [@tallclair](https://github.com/tallclair) [@vishh](https://github.com/vishh) [@yujuhong](https://github.com/yujuhong) 

        * [Fix `PodScheduled` bug for static pod. ](https://github.com/kubernetes/kubernetes/pull/61504)

            * Needs passing tests

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

* Critical failures [YELLOW]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * Gce-kubeadm-1.9-on-1.10

        * [https://github.com/kubernetes/kubernetes/issues/61483](https://github.com/kubernetes/kubernetes/issues/61483) 

        * Due to we don’t have a branched cross job

* Test Infra Updates [GREEN]

* User-facing Documentation [GREENISH]

* Marketing [YELLOW]

    * Embargoed blog hitting the streets

    * Interview requests

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

    * Edits are done and need confirmation from SIGs

    * Locking edits on the doc, moving to MD

    * Noah doing awesome work tracking things down

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

    * Props for Noah who had this as his first contributor experience!

## * * *


## Date: 3/22/2018

Video [Link](https://youtu.be/5NnZ1wuHo7Y)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Risk assessment of what is in flight

        * [https://github.com/kubernetes/kubernetes/pull/61547](https://github.com/kubernetes/kubernetes/pull/61547#event-1536032521)

            * Should go to master, then be CP’d, but where is the context on this?

        * [https://github.com/kubernetes/kubernetes/pull/61373](https://github.com/kubernetes/kubernetes/pull/61373) 

            * [https://github.com/kubernetes/kubernetes/pull/61518](https://github.com/kubernetes/kubernetes/pull/61518) 

            * Needs cp-approved from Caleb

            * Needs lgtm from Saad

        * Document known issues and workarounds for: (msau, jrondeau, nchase)

            * [https://github.com/kubernetes/kubernetes/issues/61446](https://github.com/kubernetes/kubernetes/issues/61446) 

            * [https://github.com/kubernetes/kubernetes/issues/61456](https://github.com/kubernetes/kubernetes/issues/61456) 

        * [https://github.com/kubernetes/kubernetes/issues/61483](https://github.com/kubernetes/kubernetes/issues/61483) 

            * Need help from SIG-CL

        * [https://github.com/kubernetes/kubernetes/issues/61485](https://github.com/kubernetes/kubernetes/issues/61485) 

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * Status update

            * Second run also seems good:

            * INFO: perc50: 2.583489146s, perc90: 3.466873901s, perc99: 4.380595534

            * Fairly confident now the fix did the trick. Let's get it into 1.10 asap.

        * Follow-up with Shyam

    * Initial RT Lead nomination for 1.11: Josh Berkus

    * Confidence check on release date

        * 70%+ confidence

        * Dims says "SHIP IT!"

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW ~ Based on scalability regression]

    * Mon:** Release v1.10** 5 pm Pacific ~ Caleb to hold the announce until then, even if it ships earlier

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * Issues Tracking [Spreadsheet](http://bit.ly/k8s110-issues)

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 5 ↑1 

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 4 ↕0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 3 ↑1

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 0 ↕0

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels) issues: 1 ↑1 

            * [[job failed][1.10] ci-kubernetes-e2e-kubeadm-gce-1-9-on-1-10 ](https://github.com/kubernetes/kubernetes/issues/61483)

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 3 ↑2 vs 351 ↑1 closed 

        * [Increase fluentd rolling-upgrade maxUnavailable to large value ](https://github.com/kubernetes/kubernetes/pull/61472)

            * Ask Shyam

        * [[1.10] Automated cherry pick of #61373: Use inner volume name instead of outer volume name for subpath directory ](https://github.com/kubernetes/kubernetes/pull/61518)

        * [Fix `PodScheduled` bug for static pod. ](https://github.com/kubernetes/kubernetes/pull/61504)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

* Critical failures [YELLOW]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * Gce-kubeadm-1.9-on-1.10

        * Should this be blocking? There’s no equivalent job in master-blocking

        * [https://github.com/kubernetes/kubernetes/issues/61483](https://github.com/kubernetes/kubernetes/issues/61483) 

        * Who owns this?

    * Soak test looks bad?

        * [https://k8s-testgrid.appspot.com/sig-release-1.10-all#gci-gce-soak-1.10](https://k8s-testgrid.appspot.com/sig-release-1.10-all#gci-gce-soak-1.10) 

        * Bumped timeout 2h but still timing out? Gonna bump again...

* Test Infra Updates [GREEN]

* User-facing Documentation [GREENISH]

    * One outstanding PR. Plan B can merge without requested changes

    * Generated docs still not done. Should be able to make progress today, but might need to call in help.

    * Need to check merge status (merged branches yesterday but wrestling with git mysteries)

* Marketing [YELLOW]

    * **All hands on deck to review the ****[blo**g](https://docs.google.com/document/d/1_Wr6bnuWBP8oBGG_PdawUxK4f8aHO6eVyTlQy_rB1rM/edit)**!**

        * **Volunteers:**

            * **@Ihor**

            * **SIGs needed:**

                * **Node**

                * **API-Machinery**

    * **Need to answer ****[thes**e](https://docs.google.com/document/d/1k8wMmIMgKIb42cgRV1Zpa3ng2LsfBrY1ewHCyL3ih6M/edit)** questions**

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

    * Running behind on editing but will have it done today, expect markdown version tomorrow morning.  Anybody who doesn't respond to comments by then will have to live with our interpretation of their release notes.  We will run "TLDR" by the sigs in slack

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/21/2018

Video [Link](https://youtu.be/5NnZ1wuHo7Y)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Risk assessment of what is in flight

        * [https://github.com/kubernetes/kubernetes/pull/61373](https://github.com/kubernetes/kubernetes/pull/61373) 

            * Should be picked into 1.10 release

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * looking promising!

        * Need SIG Node to look into the bug/reversion

            * [https://github.com/kubernetes/kubernetes/pull/59953](https://github.com/kubernetes/kubernetes/pull/59953) 

            * Random-liu looking into this

        * fluentd issue not release blocking, but needs follow-up 

            * @shyam & @ working on this

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW ~ Based on scalability regression]

    * Mon:** Release v1.10** 

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * Issues Tracking [Spreadsheet](http://bit.ly/k8s110-issues)

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 4 ↓1

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 4 ↓1

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 2 ↓1

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 0 ↕0

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels) issues: 0 ↕0 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 1 ↕0 vs 350 ↑2 closed 

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels+) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-longterm)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

* Critical failures [YELLOW]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * gke jobs - fixed from gke side

    * Gke-1.10 need to enable dashboard addon

        * [https://k8s-testgrid.appspot.com/sig-release-1.10-blocking#gke-1.10](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking#gke-1.10)

        * Similar to [https://github.com/kubernetes/test-infra/pull/7217](https://github.com/kubernetes/test-infra/pull/7217), will do shortly

        * Should the dashboard test be in it’s own feature?

    * Gce-kubeadm-1.9-on-1.10

        * Should this be blocking? There’s no equivalent job in master-blocking

        * Need to ping SIG Cluster-Lifecycle ~ Sen will create an issue

    * Soak test looks bad?

        * [https://k8s-testgrid.appspot.com/sig-release-1.10-all#gci-gce-soak-1.10](https://k8s-testgrid.appspot.com/sig-release-1.10-all#gci-gce-soak-1.10) 

    * Scalability performance:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

            * Looks like [https://github.com/kubernetes/kubernetes/pull/59953](https://github.com/kubernetes/kubernetes/pull/59953) is the culprit?

* Test Infra Updates [GREEN]

* User-facing Documentation [YELLOW]

    * Down to 3 open docs PRs. Should have all merged by EOD today (all are on docs to finish, no more waiting on tech review)

    * Building api ref docs at a minimum today (previews requested by a couple of folks)

    * Should be green by tomorrow (Thursday, March 22)

* Marketing [YELLOW]

    * **All hands on deck to review the ****[blo**g](https://docs.google.com/document/d/1_Wr6bnuWBP8oBGG_PdawUxK4f8aHO6eVyTlQy_rB1rM/edit)**!**

        * **Volunteers:**

            * **@jdumars**

            * **@Ihor**

            * **SIGs needed:**

                * **Networking**

                * **Node**

                * **API-Machinery**

    * **Need to answer ****[thes**e](https://docs.google.com/document/d/1k8wMmIMgKIb42cgRV1Zpa3ng2LsfBrY1ewHCyL3ih6M/edit)** questions**

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/20/2018

Video [Link](https://youtu.be/BZ1jshT198E)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Risk assessment of what is in flight

        * Need to evaluate/approve:  (approved by RT) [https://github.com/kubernetes/kubernetes/pull/61411](https://github.com/kubernetes/kubernetes/pull/61411) which elminates the need for:

            * [https://github.com/kubernetes/kubernetes/pull/61313](https://github.com/kubernetes/kubernetes/pull/61313) 

            * [https://github.com/kubernetes/kubernetes/pull/61311](https://github.com/kubernetes/kubernetes/pull/61311) 

            * [https://github.com/kubernetes/website/pull/7678](https://github.com/kubernetes/website/pull/7678) 

        * [#61299](https://github.com/kubernetes/kubernetes/pull/61299) (downgrade test change) vs 
[#61282](https://github.com/kubernetes/kubernetes/pull/61282) + [#61316](https://github.com/kubernetes/kubernetes/pull/61316) (1.9 PVC controller change + PV controller pick)

            * Needed to get green downgrade test

            * In review as a single PR

    * Mon: End of code freeze (EOD PST)

    * Mon: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Mon: Master branch re-opens for 1.11

    * Mon: PRs for v1.10.0 must be cherry picked to release-1.10

    * Tue: Notify kubernetes-dev of lifting code freeze

    * Issue triage, clean-up, resolution

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * [@wasylkowski-a](https://github.com/wasylkowski-a) working on this

        * Need a go/no-go on this by Thursday

        * **Need to escalate to ______ ~ what is the actual impact of this?**

            * **5k nodes, time for pods to start up**

            * **@Wojtekt @shyam && SIG Scalability**

        * **Need to look at ****[kubemark 5k node**s](https://k8s-testgrid.appspot.com/sig-scalability-kubemark)** test for comparison**

        * **[http://perf-dash.k8s.i**o](http://perf-dash.k8s.io)** **

        * **as opposed to gce-5kNodes-master-DensityPodStartup **

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW ~ Based on scalability regression]

    * Mon:** Release v1.10** 

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * Issues Tracking [Spreadsheet](http://bit.ly/k8s110-issues)

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 5 ↓4

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 5 ↓4

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 3 ↓1

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 0 ↕0

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels) issues: 0 ↕0 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 1 ↓4 vs 348 ↑4 closed 

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

            * **[disable DaemonSet scheduling feature for 1.10** ](https://github.com/kubernetes/kubernetes/pull/61411)

            * **[Automated cherry pick of #61411: disable DaemonSet scheduling feature for 1.10** ](https://github.com/kubernetes/kubernetes/pull/61412)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels+) (links to PRs of interest)

            * [Always Start pvc-protection-controller and pv-protection-controller ](https://github.com/kubernetes/kubernetes/pull/61324)

                * Needs review, approvals, etc.

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-longterm)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

* Critical failures [YELLOW]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * All gke jobs start to fail since last night

        * [https://github.com/kubernetes/kubernetes/issues/61416](https://github.com/kubernetes/kubernetes/issues/61416) 

            * **Looks like a gke issue, trying to track down**

    * Alpha-feature suite failing: 

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

    * Scalability performance/flake:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * **@wasylkowski-a continuing bisecting **

            * **Latest update: ****[https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-37451104**6](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-374511046)** **

* Test Infra Updates [GREEN]

    * Lifted freeze

    * cblecker mentioned it should not nagging 1.11 prs? 

* User-facing Documentation [YELLOW]

    * PRs still trickling in, but small

    * [https://github.com/kubernetes/website/pull/7678](https://github.com/kubernetes/website/pull/7678) now moot, per ^^ (not yet closed, but tracking)

    * 1.9 downgrade issue still needs attention/doc

        * Jordan to help get this over the line

    * Generated docs this week; starting today

* Marketing [YELLOW]

    * **All hands on deck to review the ****[blo**g](https://docs.google.com/document/d/1_Wr6bnuWBP8oBGG_PdawUxK4f8aHO6eVyTlQy_rB1rM/edit)**!**

        * **Volunteers:**

            * **@jdumars**

            * **@Ihor**

            * **SIGs needed:**

                * **Networking**

                * **Node**

                * **API-Machinery**

    * **Need to answer ****[thes**e](https://docs.google.com/document/d/1k8wMmIMgKIb42cgRV1Zpa3ng2LsfBrY1ewHCyL3ih6M/edit)** questions**

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

    * Expect it to be edited down by Wednesday

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/19/2018

Video [Link](https://youtu.be/Kiu4lUPxJig)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Risk assessment of what is in flight

        * [https://github.com/kubernetes/kubernetes/pull/61313](https://github.com/kubernetes/kubernetes/pull/61313) 

            * - prefer to change yaml file ([https://github.com/kubernetes/kubernetes/pull/61311](https://github.com/kubernetes/kubernetes/pull/61311) ) instead of depending an optional admission controller ([https://github.com/kubernetes/kubernetes/pull/61313](https://github.com/kubernetes/kubernetes/pull/61313) )

            * - I'll update doc ([https://github.com/kubernetes/website/pull/7678](https://github.com/kubernetes/website/pull/7678) ) about that: Pod using hostNetwork should tolerate NetworkUnavailable taints

            * - I'll update release note for it

        * Changes to make alpha green

            * Automatically add tolerations for the conditions in an admission plugin [https://github.com/kubernetes/kubernetes/pull/61313](https://github.com/kubernetes/kubernetes/pull/61313) 

            * or Adding particular tolerations to a particular component ~ [https://github.com/kubernetes/kubernetes/pull/61311](https://github.com/kubernetes/kubernetes/pull/61311) 

                * Low risk

                * for 1.11 if graduating to beta, we need to revisit this discussion because it could impact daemonsets 

                * Moving forward with this

        * [https://github.com/kubernetes/kubernetes/pull/61324](https://github.com/kubernetes/kubernetes/pull/61324) 

            * By default, interactions between 1.10/1.11 are fine

            * Consider this non-blocking

        * [#61299](https://github.com/kubernetes/kubernetes/pull/61299) (downgrade test change) vs 
[#61282](https://github.com/kubernetes/kubernetes/pull/61282) + [#61316](https://github.com/kubernetes/kubernetes/pull/61316) (1.9 PVC controller change + PV controller pick)

            * Needed to get green downgrade test

            * Test changes still need review

                * JBerkus to get SIG-Storage attention

                * Need to test these somehow

            * Ping @krousey on this

            * Downgrade signal is ok even with PVC namespace cleanup failure

            * Will document as known issue with fix in progress for 1.9.x to clean up finalizers ([#61282](https://github.com/kubernetes/kubernetes/pull/61282) + [#61316](https://github.com/kubernetes/kubernetes/pull/61316))

        * (not blocking) [https://github.com/kubernetes/kubernetes/issues/61100](https://github.com/kubernetes/kubernetes/issues/61100) 

            * Ambiguous and far-reaching, currently P0 in cloud providers

            * Might be worked by @khenidak (will know more tonight)

            * 1.9.x is broken for Azure and OpenStack

                * Need document under known issues

        * [https://github.com/kubernetes/kubernetes/pull/61302](https://github.com/kubernetes/kubernetes/pull/61302)

            * diff between alpha and this is rate limiting

            * Approved (**needs to be in exception workflow**)

    * Mon: End of code freeze (EOD PST)

        * Cole OOO

        * Test jobs for 1.9 to master, signal goes way down (are there equivalent ug/dg jobs?) - yes

    * Mon: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Mon: Master branch re-opens for 1.11

    * Mon: PRs for v1.10.0 must be cherry picked to release-1.10

    * Mon: Notify kubernetes-dev of lifting code freeze

    * Issue triage, clean-up, resolution

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * [@wasylkowski-a](https://github.com/wasylkowski-a) working on this

        * Need a go/no-go on this by Thursday

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Mon:** Release v1.10** 

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * Issues Tracking [Spreadsheet](http://bit.ly/k8s110-issues)

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 9 ↕0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 9 ↕0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 4 ↓2

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 0 ↓4

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels) issues: 0 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 5 ↑1 vs 344 ↑7 closed 

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

            * [https://github.com/kubernetes/kubernetes/pull/61127](https://github.com/kubernetes/kubernetes/pull/61127) ~ **must be merged right before 1.10 goes out**

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Added NetworkUnavailable toleration to pod using host network. ](https://github.com/kubernetes/kubernetes/pull/61313)

                * Needs review, a-f-m label, approvals

            * [Fix cpu cfs quota flag with pod cgroups ](https://github.com/kubernetes/kubernetes/pull/61294)

                * needs LGTM, a-f-m label, pinged Dawn in Slack, others unresponsive

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

            * [Wait for only enough no. of RC replicas to be running in testutil ](https://github.com/kubernetes/kubernetes/pull/61351)

                * Merging once tests are green

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels+) (links to PRs of interest)

            * [Always Start pvc-protection-controller and pv-protection-controller ](https://github.com/kubernetes/kubernetes/pull/61324)

                * Needs review, approvals, etc.

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-longterm)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

* Critical failures [YELLOW]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * Alpha-feature suite failing:

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

        * Pending on [https://github.com/kubernetes/kubernetes/pull/61313](https://github.com/kubernetes/kubernetes/pull/61313)** **

    * Scalability performance/flake:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * **@wasylkowski-a continuing bisecting **

            * **Latest update: ****[https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-37425185**4](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-374251854)** **

    * Upgrade suites

        * Mostly green, some one-off flakes, will 

        * Downgrade is still busted [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764) 

            * [https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533) 

            * **Test fix in ****[https://github.com/kubernetes/kubernetes/pull/6131**6](https://github.com/kubernetes/kubernetes/pull/61316)** **

            * **Document into known?**

                * **Doc draft with comments here: ****[https://github.com/kubernetes/website/pull/773**1](https://github.com/kubernetes/website/pull/7731)

                * **@nickchase also aware, we're coordinating for relnotes**

                * **[https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-37377817**9](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-373778179)** saad’s summary**

* Test Infra Updates [GREEN]

    * All ok

* User-facing Documentation [YELLOW]

    * PRs still trickling in, but small

    * [https://github.com/kubernetes/website/pull/7678](https://github.com/kubernetes/website/pull/7678) looks ready to merge; putting hold until further notification (per item ^^)

    * 1.9 downgrade issue still needs attention/doc

        * Jordan to help get this over the line

    * Meeting with Steve Perry re: auto doc generation

* Marketing [YELLOW]

    * **All hands on deck to review the ****[blo**g](https://docs.google.com/document/d/1_Wr6bnuWBP8oBGG_PdawUxK4f8aHO6eVyTlQy_rB1rM/edit)**!**

        * **Volunteers:**

            * **@jdumars**

            * **@Ihor**

            * **SIGs needed:**

                * **Networking**

                * **Node**

                * **API-Machinery**

    * **Need to answer ****[thes**e](https://docs.google.com/document/d/1k8wMmIMgKIb42cgRV1Zpa3ng2LsfBrY1ewHCyL3ih6M/edit)** questions**

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

    * Expect it to be edited down by Wednesday

    * One last PR to catch last changes

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/16/2018

Video [Link](https://youtu.be/gdW3a7PvBbs)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Issue triage, clean-up, resolution

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * [@wasylkowski-a](https://github.com/wasylkowski-a) working on this

    * **Staffing**: Mehdy (@mbohlool) is on vacation and handing off 1.9 branch duties to Joe Betz (@jpbetz) 

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Mon: End of code freeze (EOD PST)

    * Mon: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Mon: Master branch re-opens for 1.11

    * Mon: PRs for v1.10.0 must be cherry picked to release-1.10

    * Mon: Notify kubernetes-dev of lifting code freeze

* ** **[Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for **_week 13_*** *[YELLOW]

    * Mon:** Release v1.10** 

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * Issues Tracking [Spreadsheet](http://bit.ly/k8s110-issues)

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 9 ↓8 Suspect bot removed?

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 9 ↓8

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 6 ↓5

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 4 ↓2

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels) issues: 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 4 ↓3 vs 337 ↑9 closed (**velocity is slowing**)

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

            * [https://github.com/kubernetes/kubernetes/pull/61127](https://github.com/kubernetes/kubernetes/pull/61127) ~ **must be merged right before 1.10 goes out**

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Added unschedulable taint ](https://github.com/kubernetes/kubernetes/pull/61161)

                * Milestone not approved

                * Needs general attention, esp since tests were manual

            * [(WIP) Add AUTOSCALER_ENV_VARS to kube-env to hotfix cluster autoscaler ](https://github.com/kubernetes/kubernetes/pull/61119)

                * **Needs LGTM / Approve**

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

        * [milestone/incomplete-labels](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fincomplete-labels+) (links to PRs of interest)

            * [Fail the ingress test if it timesout getting address ](https://github.com/kubernetes/kubernetes/pull/61234)

                * Needs SIG, approved-for-milestone labels

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-longterm)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

* Critical failures [YELLOW]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * GKE upgrade test failing

        * [https://github.com/kubernetes/kubernetes/issues/61290](https://github.com/kubernetes/kubernetes/issues/61290) 

    * Gce presubmit was failing on logging sink quota

        * Manually cleaned up stale logging sinks

        * This resource does not have a creation timestamp (?!) thus test-infra janitor cannot help with that

        * It should not be leaking to start with?! Sig-instrumentation want to investigate there.

    * Alpha-feature suite failing:

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

        * [https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442](https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442) 

        * **Fix in ****[https://github.com/kubernetes/kubernetes/pull/6116**1](https://github.com/kubernetes/kubernetes/pull/61161)** **

            * **Still pending review**

    * Gce-serial has one last test failure

        * Should restart all nodes: [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763) waiting for triage updates

            * [https://github.com/kubernetes/kubernetes/issues/60763#issuecomment-373358971](https://github.com/kubernetes/kubernetes/issues/60763#issuecomment-373358971) 

            * fluentd's asking more cpu resources than 1.9

            * Hopefully fixed by [https://github.com/kubernetes/kubernetes/pull/61269](https://github.com/kubernetes/kubernetes/pull/61269) 

            * **re-opened until testgrid goes green**

    * Scalability performance/flake:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * **@wasylkowski-a continuing bisecting **

            * **[https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-37365535**9](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-373655359)** still going on**

            * Run same test against the tip of the tree and see if the revert already handled the problem

    * Upgrade suites

        * 1.9 fixes merged

            * [http://k8s-testgrid.appspot.com/sig-release-master-upgrade#gce-1.9-master-upgrade-cluster](http://k8s-testgrid.appspot.com/sig-release-master-upgrade#gce-1.9-master-upgrade-cluster) has one last serial issue, same as [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763) 

            * [http://k8s-testgrid.appspot.com/sig-release-master-upgrade#gce-1.9-master-upgrade-cluster-parallel](http://k8s-testgrid.appspot.com/sig-release-master-upgrade#gce-1.9-master-upgrade-cluster-parallel) looks like `Proxy version v1` is still an issue?

                * Reopened [https://github.com/kubernetes/kubernetes/issues/60769](https://github.com/kubernetes/kubernetes/issues/60769) 

        * Downgrade is still busted [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764) 

            * [https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533) 

            * **AI? Maybe need to disable admission controller?**

                * **[https://github.com/kubernetes/kubernetes/pull/6128**2](https://github.com/kubernetes/kubernetes/pull/61282)** opened in 1.9 to always start pvc-protection-controller**

            * **Document into known?**

                * **Doc draft with comments here: ****[https://github.com/kubernetes/website/pull/773**1](https://github.com/kubernetes/website/pull/7731)

                * **@nickchase also aware, we're coordinating for relnotes**

                * **[https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-37377817**9](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-373778179)** saad’s summary**

* Test Infra Updates [GREEN]

* User-facing Documentation [YELLOW]

    * Docs PRs are continuing to trickle in, some against the wrong branch (we know, it can be confusing). In high careful triage mode.

    * PVC Protection (1.9)/Storage Object in Use Protection (1.10) docs are getting resolved. Plan B we'll finish fixing after release.

    * Generated docs coming next week

    * Jennifer traveling 3/16, can't make release burndown

* Marketing [YELLOW]

    * **Jaice/Ihor final review & draft by EOD Monday**

    * **Need to answer ****[thes**e](https://docs.google.com/document/d/1k8wMmIMgKIb42cgRV1Zpa3ng2LsfBrY1ewHCyL3ih6M/edit)** questions**

    * Need to figure out what "An average Kubernetes release" gets marketed like

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

* Announcements / Open Mic

    * SIG Scheduling update

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/15/2018

Video [Link](https://youtu.be/p7Nlrub-dg4)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Issue triage, clean-up, resolution

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

        * [@wasylkowski-a](https://github.com/wasylkowski-a) working on this

    * **Staffing**: Shyam hand-off to [@wasylkowski-a](https://github.com/wasylkowski-a), Mehdy (@mbohlool) is on vacation and handing off 1.9 branch duties to Joe Betz (@jpbetz) 

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Mon: End of code freeze (EOD PST)

    * Mon: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Mon: Master branch re-opens for 1.11

    * Mon: PRs for v1.10.0 must be cherry picked to release-1.10

    * Mon: Notify kubernetes-dev of lifting code freeze

* ** **[Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for **_week 13_*** *[YELLOW]

    * Mon:** Release v1.10** 

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [RED]

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 17 ↑1 (up 3 in 2 days)

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 17 ↑1

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 11 ↕0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 6 ↕0

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 7 ↓1 vs 328 ↑2 closed (**velocity is slowing**)

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

            * [https://github.com/kubernetes/kubernetes/pull/61127](https://github.com/kubernetes/kubernetes/pull/61127) ~ **must be merged right before 1.10 goes out**

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Fix deprecated gcloud compute networks --mode switches. ](https://github.com/kubernetes/kubernetes/pull/61203)

                * Needs approval from [@gmarek](https://github.com/gmarek)

            * [Added unschedulable taint ](https://github.com/kubernetes/kubernetes/pull/61161)

                * Milestone not approved

                * Needs general attention, esp since tests were manual

            * [(WIP) Add AUTOSCALER_ENV_VARS to kube-env to hotfix cluster autoscaler ](https://github.com/kubernetes/kubernetes/pull/61119)

                * **Needs LGTM / Approve**

            * [Fix issue with race condition during pod deletion ](https://github.com/kubernetes/kubernetes/pull/61071)

                * Needs clarification from [jsafrane](https://github.com/jsafrane)

                * Needs approve 

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

            * [Backoff only when failed pod shows up ](https://github.com/kubernetes/kubernetes/pull/60985)

                * **_Still_**** needs LGTM from @janetkuo in the PR **

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-longterm)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

    * beta.4 cut last night

* Critical failures [RED]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

* Test failure triage/resolution updates [YELLOW]

    * Brief outage for gke suite yesterday, due to gcloud killed a deprecated flag in staging

        * Fixed by [https://github.com/kubernetes/test-infra/pull/7278](https://github.com/kubernetes/test-infra/pull/7278) 

        * K8s fix [https://github.com/kubernetes/kubernetes/pull/61203](https://github.com/kubernetes/kubernetes/pull/61203) - need to get in before next gcloud release

        * Retro: someone need to watch for gcloud warnings? [https://github.com/kubernetes/kubernetes/issues/54238](https://github.com/kubernetes/kubernetes/issues/54238) was opened half year ago

    * Alpha-feature suite failing:

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

        * [https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442](https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442) 

        * **Fix in ****[https://github.com/kubernetes/kubernetes/pull/6116**1](https://github.com/kubernetes/kubernetes/pull/61161)** **

    * Gce-serial has one last test failure

        * Should restart all nodes: [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763) waiting for triage updates

            * [https://github.com/kubernetes/kubernetes/issues/60763#issuecomment-373358971](https://github.com/kubernetes/kubernetes/issues/60763#issuecomment-373358971) 

            * fluentd's asking more cpu resources than 1.9

            * @x13n is still looking into this

            * **Needs update**

    * Scalability performance/flake:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * @wasylkowski-a continuing bisecting 

    * Upgrade suites

        * A few 1.9 backport fixes pending

        * Downgrade is still busted [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764) 

            * [https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533) 

            * **AI? Maybe need to disable admission controller?**

            * **Document into known?**

                * **Doc draft with comments here: ****[https://github.com/kubernetes/website/pull/773**1](https://github.com/kubernetes/website/pull/7731)

                * **@nickchase also aware, we're coordinating for relnotes**

* Test Infra Updates [GREEN]

* User-facing Documentation [YELLOW]

    * Docs PRs are continuing to trickle in, some against the wrong branch (we know, it can be confusing). In high careful triage mode.

    * PVC Protection (1.9)/Storage Object in Use Protection (1.10) docs are getting resolved. Plan B we'll finish fixing after release.

    * Generated docs coming next week

    * Jennifer traveling 3/16, can't make release burndown

* Marketing [YELLOW]

    * Only SIG to review was storage

    * Network, security both pretty lean

    * Jaice/Ihor final review & draft by EOD Monday

    * Changes are affecting the blog series, so SIGs/I/J need to look this over ~ 2 of 5 got cut

    * Need to answer [these](https://docs.google.com/document/d/1k8wMmIMgKIb42cgRV1Zpa3ng2LsfBrY1ewHCyL3ih6M/edit) questions

    * "An average Kubernetes release"

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

* Announcements / Open Mic

    * SIG Scheduling is missing docs reviews

    * 3 Blog series not 5 this go around

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/14/2018

Video [Link](https://youtu.be/e14tlUBd2jQ)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Issue triage, clean-up, resolution

    * Need to resolve: [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589#issuecomment-372660403)

    * **Staffing**: Shyam to hand-off to someone (@Wojtekt is out sick), Mehdy (@mbohlool) is on vacation and handing off 1.9 branch duties to Joe Betz (@jpbetz) 

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Mon: End of code freeze (EOD PST)

    * Mon: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Mon: Master branch re-opens for 1.11

    * Mon: PRs for v1.10.0 must be cherry picked to release-1.10

    * Mon: Notify kubernetes-dev of lifting code freeze

* ** **[Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for **_week 13_*** *[YELLOW]

    * Mon:** Release v1.10** 

    * Mon: release v1.11 alpha

    * M-F: Manage media engagements

    * Tue: Hand-off to release to 1.10 patch manager

    * Thu: Retro

* Metrics review ↕0 ↑# ↓# [RED]

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 16 ↑2

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 16 ↑2

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 11 ↑1

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 6 ↑2

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 8 ↓5 vs 326 ↑11 closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

            * [https://github.com/kubernetes/kubernetes/pull/61127](https://github.com/kubernetes/kubernetes/pull/61127) ~ **must be merged right before 1.10 goes out**

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [(WIP) Add AUTOSCALER_ENV_VARS to kube-env to hotfix cluster autoscaler ](https://github.com/kubernetes/kubernetes/pull/61119)

                * **In progress**

            * [Fix issue with race condition during pod deletion ](https://github.com/kubernetes/kubernetes/pull/61071)

                * pull-kubernetes-e2e-gce failing:

                    * test/e2e/framework/framework.go:142
Mar 14 15:10:02.845: Couldn't delete ns: "e2e-tests-volume-xpbrd": namespace e2e-tests-volume-xpbrd was not deleted with limit: **timed out waiting for the condition**, pods remaining: 1 (&errors.errorString{s:"namespace e2e-tests-volume-xpbrd was not deleted with limit: timed out waiting for the condition, pods remaining: 1"})
test/e2e/framework/framework.go:318

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

            * [Increase apiserver mem-threshold in density test ](https://github.com/kubernetes/kubernetes/pull/61118)

                * **Ready to merge**

            * [Fix error handling in gc e2e test ](https://github.com/kubernetes/kubernetes/pull/60671)

                * **Still Needs LGTM & Approve**, @sig-testing-approvers

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

            * [Backoff only when failed pod shows up ](https://github.com/kubernetes/kubernetes/pull/60985)

                * **Still needs LGTM from @janetkuo in the PR **

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-longterm)

        * [Backoff only when failed pod shows up ](https://github.com/kubernetes/kubernetes/pull/60985)

            * Needs LGTM

        * [Increase loging verbosity for deleting stateful set pods ](https://github.com/kubernetes/kubernetes/pull/60579)

            * Ready to merge

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [GREEN]

    * beta.4 cut last night

* Critical failures [RED]

    * [https://github.com/kubernetes/sig-release/issues/86](https://github.com/kubernetes/sig-release/issues/86) 

    * Mem increases in controller manager understood:

        * fluentd scaler PR changed to look at correct thing, so scaler is trying to patch alongside the autoscaler, makes the daemonset controller do a lot of work, and leads to higher memory use: fluentd gcp pods being deleted/re-created.  Not sure why they are being deleted, but preceded by calls to kubelet for pod status - Shyam spoke to Daniel, and we need to change the fluentd scaler to not make API calls if the resource request for the object have not changed. Daniel working on pod startup latency issue, and also creating an issue for the instrumentation code.  

* Test failure triage/resolution updates [YELLOW]

    * Alpha-feature suite failing:

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

        * [https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442](https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442) **@k82cn is working on a fix (no updates yet?)**

    * Gke-serial back to green

    * Gce-serial has one last test failure

        * Should restart all nodes: [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763) waiting for triage updates

            * [https://github.com/kubernetes/kubernetes/pull/60386](https://github.com/kubernetes/kubernetes/pull/60386)** **might be the culprit? Assigned to sig-apps

    * Scalability performance/flake:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * See Shyam’s update above in critical failures

    * Port kubemark presubmit to use kubetest (failing in 1.7/1.8 which uses older go version and cannot compile kubetest)

        * I’m working on 1.7/1.8 fixes so those two branches can be unblocked

    * Upgrade suites

        * A few 1.9 backport fixes pending

        * Downgrade is still busted [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764) 

            * [https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533) 

            * **AI? Maybe need to disable admission controller?**

            * **Document into known?**

                * **Doc draft with comments here: ****[https://github.com/kubernetes/website/pull/773**1](https://github.com/kubernetes/website/pull/7731)

                * **@nickchase also aware, we're coordinating for relnotes**

* Test Infra Updates [GREEN]

* User-facing Documentation [YELLOW]

    * Docs PRs are continuing to trickle in, some against the wrong branch (we know, it can be confusing). In high careful triage mode.

    * A bit of a mess with docs for renamed beta feature. Anyone available to help pick through what we should do about PVC Protection (1.9)/Storage Object in Use Protection (1.10)?

    * Related to previous, looks like docs had better track Downgrade busted issue. We have a doc in, but … it needs a lotta love.

    * Asking for help with generated docs (helpers identified in sig-docs)

* Marketing [GREEN]

* Release notes update [RED/YELLOW/GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Working GDoc: [https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

    * Scalability is a big problem, and needs to be dealt with earlier ([https://github.com/kubernetes/community/blob/master/sig-scalability/processes/formal-scalability-processes.md](https://github.com/kubernetes/community/blob/master/sig-scalability/processes/formal-scalability-processes.md)) ~ need more attention on this,** it is a project risk! **

    * Need consistent place for procedural docs related to "known issues"

## * * *


## Date: 3/13/2018

Video [Link](https://youtu.be/kcKw57uEp20)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * **CRUNCH WEEK!!**

    * Begin M-F Burndown meetings

    * Wed: End of code freeze (EOD PST)

    * Wed: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Wed: Master branch re-opens for 1.11

    * Wed: PRs for v1.10.0 must be cherry picked to release-1.10

    * Thu: Notify kubernetes-dev of lifting code freeze

    * Fri: Initial go/no-go prediction for the release

    * **All-hands on deck for missing docs**

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[RED]

    * **Wed: Release v1.10 3/21/2018**

    * release v1.11 alpha

    * Manage media engagements

    * Hand-off to release to 1.10 patch manager

    * Prep for retro

* Metrics review ↕0 ↑# ↓# [RED]

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 14 ↓4

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 14 ↓4

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 10 ↓2

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 4 ↓12

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 13 ↓3 vs 315 ↑9 closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

            * We will get one PR from sig-cluster-lifecycle for kubeadm that will need to merge just before we cut v1.10 release. Similar to what was in [https://github.com/kubernetes/kubernetes/pull/56599](https://github.com/kubernetes/kubernetes/pull/56599) for 1.9. @timothysc will be creating a PR.

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Bump to etcd 3.1.12 to pick up critical fix](https://github.com/kubernetes/kubernetes/pull/60998)[ ](https://github.com/kubernetes/kubernetes/pull/60998)(merged)

                * **Pinged sttts, mikedanese**

            * [Use grpc to improve the CPU utilization of the logging agent. ](https://github.com/kubernetes/kubernetes/pull/60981)(merged)

                * **Ready to merge**

            * [Find most recent modified date for fluentd buffers recursively. ](https://github.com/kubernetes/kubernetes/pull/60951)

                * **Ready to merge**

            * [Fix default auditing options. ](https://github.com/kubernetes/kubernetes/pull/60739) 

                * **Tests failing**

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

            * [Update Kubelet command option description for IPv6 ](https://github.com/kubernetes/kubernetes/pull/60737)

                * **Added ****[@dchen110**7](https://github.com/dchen1107)** ****[@Random-Li**u](https://github.com/random-liu)** ****[@yujuhon**g](https://github.com/yujuhong)** to PR**

            * [Use pod UID as cache key instead of namespace/name ](https://github.com/kubernetes/kubernetes/pull/61069)

                * **Needs LGTM & Approve, @****sig-scheduling-maintainers**

            * [Fix error handling in gc e2e test ](https://github.com/kubernetes/kubernetes/pull/60671)

                * **Needs LGTM & Approve**, @sig-testing-approvers

            * [Cleanup old upgrading code that is v1.8->v1.9-specific ](https://github.com/kubernetes/kubernetes/pull/60359)

                * **Needs LGTM from ****[@dixud**x](https://github.com/dixudx)** ****[@fabriziopandin**i](https://github.com/fabriziopandini)** ****[@timothys**c](https://github.com/timothysc)** ****[@luxa**s](https://github.com/luxas)** **

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

            * [Backoff only when failed pod shows up ](https://github.com/kubernetes/kubernetes/pull/60985)

                * **Needs LGTM, pinged @janetkuo in the PR**** **

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [RED/YELLOW/GREEN]

    * Fast forwarded branch this morning. Will fast forward again around noon PST

* Critical failures [RED/YELLOW/GREEN]

* Test failure triage/resolution updates [YELLOW]

    * Gke tests back to green now :-)

    * Alpha-feature suite failing:

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

        * [https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442](https://github.com/kubernetes/kubernetes/issues/61050#issuecomment-372702442) **@k82cn is working on a fix **

    * Gci-gce|gke-serial: two tests left:

        * failing on resource usage tracking ~ 

            * [https://github.com/kubernetes/kubernetes/issues/60762](https://github.com/kubernetes/kubernetes/issues/60762) 

            * [https://github.com/kubernetes/kubernetes/pull/60981](https://github.com/kubernetes/kubernetes/pull/60981) claim fix the issue, and merged just now

            * Waiting for next run

        * Should restart all nodes: [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763) waiting for triage updates

            * @Crassirostris is looking into it

    * Scalability performance/unstability:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * Still tracking down performance caused by etcd version

            * **[https://github.com/kubernetes/kubernetes/pull/6099**8](https://github.com/kubernetes/kubernetes/pull/60998)

                * ^^ merged just now, waiting for result

            * Shyam still doing regression test

    * Upgrade suites

        * A few 1.9 backport fixes pending

        * Downgrade is still busted [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764) 

            * [https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533](https://github.com/kubernetes/kubernetes/issues/60764#issuecomment-372624533) 

            * **AI? Maybe need to disable admission controller?**

            * **Document into known?**

* Test Infra Updates [GREEN]

* User-facing Documentation [GREEN]

    * 3 docs PRs outstanding: 1 awaiting final tech review (could be merged without, just being extra careful), 1 waiting on final copyedit changes (could also be merged without, @jrondeau can make that call if need be), 1 landed this morning and needs only confirmation that it belongs in the 1.10 docs (not master and therefore published immediately)

    * Asking for help with generated docs (helpers identified in sig-docs)

* Marketing [GREEN]

* Release notes update [RED/YELLOW/GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

* Announcements / Open Mic

    * RC1 Monday 19th

    * Code freeze lifting Monday 19th mid-day

    * **New release date Monday 26th**

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 3/12/2018

Video [Link](https://youtu.be/xuScNCEaHJ4)

Attending:

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * **CRUNCH WEEK!!**

    * Begin M-F Burndown meetings

    * Wed: End of code freeze (EOD PST)

    * Wed: Perform final branchff ~ we need one sooner to catch [60989](https://github.com/kubernetes/kubernetes/pull/60989)

    * Wed: Master branch re-opens for 1.11

    * Wed: PRs for v1.10.0 must be cherry picked to release-1.10

    * Thu: Notify kubernetes-dev of lifting code freeze

    * Fri: Initial go/no-go prediction for the release

    * **All-hands on deck for missing docs**

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[RED/YELLOW/GREEN]

    * **Wed: Release v1.10 3/21/2018**

    * release v1.11 alpha

    * Manage media engagements

    * Hand-off to release to 1.10 patch manager

    * Prep for retro

* Metrics review ↕0 ↑# ↓# [RED/YELLOW/GREEN]

    * [Open ](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10)**[issue**s](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 18 ↓4

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 18 ↓2

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 0 ↓1

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 12 ↓1

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 16 ↑1 Review Needed

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 16 ↑1 vs 306 ↑11 closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Bump to etcd 3.1.12 to pick up critical fix ](https://github.com/kubernetes/kubernetes/pull/60998)

            * [Use grpc to improve the CPU utilization of the logging agent. ](https://github.com/kubernetes/kubernetes/pull/60981)

            * [Find most recent modified date for fluentd buffers recursively. ](https://github.com/kubernetes/kubernetes/pull/60951)

            * [Fix default auditing options. ](https://github.com/kubernetes/kubernetes/pull/60739) **(Needs attention)**

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

            * [fix show-all option description ](https://github.com/kubernetes/kubernetes/pull/61022)

            * [Fix error handling in gc e2e test ](https://github.com/kubernetes/kubernetes/pull/60671)

            * [Cleanup old upgrading code that is v1.8->v1.9-specific ](https://github.com/kubernetes/kubernetes/pull/60359)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

            * [Backoff only when failed pod shows up ](https://github.com/kubernetes/kubernetes/pull/60985) **(Needs attention) **

            * [prevent conformance test failure in DIND scenario ](https://github.com/kubernetes/kubernetes/pull/60811) **(Needs attention) **

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Branch Updates / Branch Health [No status]

    * No update

* Critical failures [YELLOW]

    * Alpha feature fails ~ Sen to open issue

        * [https://github.com/kubernetes/kubernetes/issues/61050](https://github.com/kubernetes/kubernetes/issues/61050) 

    * GKE problem with the dashboard being disabled ~ 

        * Ben has a fix? [https://github.com/kubernetes/test-infra/pull/7217](https://github.com/kubernetes/test-infra/pull/7217) 

* Test failure triage/resolution updates [YELLOW]

    * Gci-gke|pull-gke failing on a sig-ui test [https://github.com/kubernetes/kubernetes/issues/60767](https://github.com/kubernetes/kubernetes/issues/60767) 

    * Gci-gce|gke-serial:

        * failing on resource usage tracking ~ 

            * [https://github.com/kubernetes/kubernetes/issues/60762](https://github.com/kubernetes/kubernetes/issues/60762) 

            * [https://github.com/kubernetes/kubernetes/pull/60981](https://github.com/kubernetes/kubernetes/pull/60981) claim fix the issue

        * Flexvolume e2e fix: [https://github.com/kubernetes/kubernetes/pull/60859](https://github.com/kubernetes/kubernetes/pull/60859) 

        * Should restart all nodes: [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763) waiting for triage updates

            * **Need to hassle the sig**

    * Scalability performance/unstability:

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589) 

        * Still tracking down performance caused by etcd version

            * **Probably need to invite sig for an update ****here****?**

            * **[https://github.com/kubernetes/kubernetes/pull/6099**8](https://github.com/kubernetes/kubernetes/pull/60998)

                * **To be tracked as an individual item**

                * (also related etcd experimentation: [https://github.com/kubernetes/kubernetes/pull/61037](https://github.com/kubernetes/kubernetes/pull/61037))

        * etcd with Shyam

            * Reversion helped fix the issue, but there is another regression (over 5 second SLO)

            * Second round of bisection to ID problem 

            * ETA? Understand/debug by hopefully Wed

            * Another scalability/performance regression [issue](https://github.com/kubernetes/kubernetes/issues/60500) [60500](https://github.com/kubernetes/kubernetes/issues/60500)

                * Not super serious, but may be something behind it

                * Unrelated to etcd regression

    * Upgrade suites

        * A few 1.9 backport fixes pending

        * Downgrade is still busted [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764) 

* Test Infra Updates [No update]

* User-facing Documentation  [YELLOW]

    * Docs in "unusually good shape" woo!  

    * A couple of new docs over the weekend, and need to synchronize with Ihor

* Marketing [GREEN]

    * Refine blog post so an early draft can go to media

    * Get permission for interviews based on features

    * Due by Wednesday

        * AI: Jaice, Ihor, Caleb ~ up front, title, features section review

        * Kaitlyn updating 5 blog series

        * Jaice - project velocity

        * Case studies/eco highlights done

        * Kaitlyn working on webinar scheduling

        * Needs a "source of truth" review

        * Aparna to review with Brian/Tim

        * Needs a formal sign off

* Release notes update [YELLOW]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md) ([https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit#)) 

    * They are not perfect, but they are mostly there

    * 93 pages, 70 pages of extraneous info that needs to be merged

    * Need help getting themes in & some unknown items reconciled

    * Need a docs hack ~ Jaice to schedule

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

* * *


## Date: 3/9/2018  

Video [Link](https://youtu.be/JU8ZwLScA4Q)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Close out docs PRs by EOD today

        * 4 outstanding docs PRs, mostly there

        * Still need info on storage feature (J to follow-up with Saad Ali)

        * Content generation will happen next week

    * Good idea what release notes looks like

        * Generated version [draft](https://docs.google.com/document/d/18I1kM4zmEEZ-HKOyP3WHolN_rAO-6iF4IeLuCAbCgtk/edit)

        * Release themes by Wednesday

    * Sort out release branch health (flakes vs. real)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * **CRUNCH WEEK!!**

    * Begin M-F Burndown meetings

    * End of code freeze (EOD PST)

    * Perform final branchff

    * Master branch re-opens for 1.11

    * PRs for v1.10.0 must be cherry picked to release-1.10

    * Notify kubernetes-dev of lifting code freeze

    * Initial go/no-go prediction for the release

    * All-hands on deck for missing docs

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 22 ↓2

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 20 ↓2 

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 1 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 13 ↓2

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 0 ↕0

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 15 ↓1

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 15 ↕0 vs 295 ↑17 closed

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Fix default auditing options. ](https://github.com/kubernetes/kubernetes/pull/60739)(depends on [#60926](https://github.com/kubernetes/kubernetes/pull/60926) merging first)

            * [Make log audit backend configurable in GCE ](https://github.com/kubernetes/kubernetes/pull/60926)(needs approval)

            * [use temp kubeconfig for fake factory ](https://github.com/kubernetes/kubernetes/pull/60950) (needs a-f-m)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest) ~ 7

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Exception Requests [GREEN]

    * None

* Branch Updates / Branch Health [YELLOW]

    * Things are ok, FFW done for today

    * Release building ~ bot user is now in GH org

* Marketing Updates [GREEN]

    * Jaice still needs to update the blog post

    * Monday, marketing team is looking for user feedback on the beta post-blog post

* Documentation Updates [GREEN]

    * See above

* Critical build failures [RED]

    * Serial suite is still failing [https://github.com/kubernetes/kubernetes/issues/60003](https://github.com/kubernetes/kubernetes/issues/60003)

        * Fixes for two DaemonSet test failures merged: [#60747](https://github.com/kubernetes/kubernetes/pull/60747), [#60820](https://github.com/kubernetes/kubernetes/pull/60820)

        * 6 tests in gce-serial

            * Flexvolumes fix opened [https://github.com/kubernetes/kubernetes/pull/60859](https://github.com/kubernetes/kubernetes/pull/60859) 

    * Upgrade suites are still failing

        * [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764)

        * Downgrade failed due to fail to delete a statefulset, assigned to sig-storage/sig-apps

        * Need to either backport fixes to 1.9 tests or skip those tests

        * **Waiting for feedback from sig-apps **

    * Scalability suite is still flaky

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589)

        * Rolling back etcd server:  (DONE) [https://github.com/kubernetes/kubernetes/pull/60891](https://github.com/kubernetes/kubernetes/pull/60891) 

    * One sig-ui failure in [https://k8s-testgrid.appspot.com/sig-release-master-blocking#gci-gke](https://k8s-testgrid.appspot.com/sig-release-master-blocking#gci-gke) 

* Test Infra Updates [GREEN] (no update)

* * *


## Date: 3/7/2018  

Video Link

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Close out docs PRs

    * Good idea what release notes looks like

    * Sort out release branch health (flakes vs. real)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * **CRUNCH WEEK!!**

    * Begin M-F Burndown meetings

    * End of code freeze (EOD PST)

    * Perform final branchff

    * Master branch re-opens for 1.11

    * PRs for v1.10.0 must be cherry picked to release-1.10

    * Notify kubernetes-dev of lifting code freeze

    * Initial go/no-go prediction for the release

    * All-hands on deck for missing docs

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 24 ↓3

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 22 ↕0 

            * **API Memory usage regression**

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 1 ↓1

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 15 ↕0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 0 ↓1

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 0 ↓2

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 16 ↑2

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 15 ↓14 vs 278 ↑21 closed

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

            * [Fix default auditing options. ](https://github.com/kubernetes/kubernetes/pull/60739)

            * [Revert "Audit use buffered backend" ](https://github.com/kubernetes/kubernetes/pull/60727)

            * [WIP - Prevent read anomalies from the watch cache ](https://github.com/kubernetes/kubernetes/pull/60478)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Exception Requests [GREEN]

    * None

* Branch Updates / Branch Health [RED/YELLOW/GREEN]

    * FF this morning to pull in daemonset fixes, but master is still failing.

    * Beta to be cut right after this meeting

* Marketing Updates [GREEN]

    *  

* Documentation Updates [GREEN]

    * A few features still seem to be in doubt. Straggler PRs are coming in steadily; sig-docs is doing an awesome job of staying on top of doc merges.

* Critical build failures [YELLOW]

    * Kubeadm suites is back to green now :-) Thanks Ben

    * Submit-queue blocked for a few hours last night - [https://github.com/kubernetes/kubernetes/issues/60870](https://github.com/kubernetes/kubernetes/issues/60870) fixed by [https://github.com/kubernetes/kubernetes/pull/60872](https://github.com/kubernetes/kubernetes/pull/60872) 

    * Serial suite is still failing [https://github.com/kubernetes/kubernetes/issues/60003](https://github.com/kubernetes/kubernetes/issues/60003)

        * Fixes for two DaemonSet test failures merged: [#60747](https://github.com/kubernetes/kubernetes/pull/60747), [#60820](https://github.com/kubernetes/kubernetes/pull/60820)

        * 6 tests in gce-serial

            * Flexvolumes fix opened [https://github.com/kubernetes/kubernetes/pull/60859](https://github.com/kubernetes/kubernetes/pull/60859) 

        * 1 test in gke-serial

        * Update:  looking better now, with just a flexvolume fix pending

    * Upgrade suites are still failing

        * [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764)

        * Downgrade failed due to fail to delete a statefulset, assigned to sig-storage/sig-apps

        * Need to either backport fixes to 1.9 tests or skip those tests

        * Waiting for feedback from sig-apps

    * Scalability suite is still flaky

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589)

        * Rolling back etcd server: [https://github.com/kubernetes/kubernetes/pull/60891](https://github.com/kubernetes/kubernetes/pull/60891) 

        * Caused by etcd upgrade, PR in to revert for k8s, should fix the flake; Sen will follow up

* Test Infra Updates [GREEN] (no update)

* * *


## Date: 3/5/2018

Video [Link](https://youtu.be/WLeK9jZ2oEc)

Attending:

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Close out docs PRs

    * Good idea what release notes looks like

    * Sort out release branch health (flakes vs. real)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * **CRUNCH WEEK!!**

    * Begin M-F Burndown meetings

    * End of code freeze (EOD PST)

    * Perform final branchff

    * Master branch re-opens for 1.11

    * PRs for v1.10.0 must be cherry picked to release-1.10

    * Notify kubernetes-dev of lifting code freeze

    * Initial go/no-go prediction for the release

    * All-hands on deck for missing docs

* Metrics review ↕0 ↑# ↓# [RED/YELLOW/GREEN]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 27

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 22 

            * API Memory usage regression

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 2

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 15

            * Test failures have been added

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 1

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 2

        * [milestone/needs-attention](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone%2Fneeds-attention) issues: 14

        * Other priority Issues: 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 29 ↓7 vs 257 ↑19 closed

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Exception Requests [GREEN]

    * None

    * Caleb is going to make a GH-based storage mechanism for completed exception requests

* Branch Updates / Branch Health [RED/YELLOW/GREEN]

* Marketing Updates [RED/YELLOW/GREEN]

    *  

* Documentation Updates [RED/YELLOW/GREEN]

    *  A few features still seem to be in doubt. Straggler PRs are coming in steadily; sig-docs is doing an awesome job of staying on top of doc merges.

* Critical build failures [YELLOW]

    * Gce|gke-serial is failing multiple tests:

        * (looks worse after daemonset tests are fixed)

        * Unbrella issue: [https://github.com/kubernetes/kubernetes/issues/60003](https://github.com/kubernetes/kubernetes/issues/60003)

        * Failing test issues:

            * [https://github.com/kubernetes/kubernetes/issues/60761](https://github.com/kubernetes/kubernetes/issues/60761)

            * [https://github.com/kubernetes/kubernetes/issues/60762](https://github.com/kubernetes/kubernetes/issues/60762)

            * [https://github.com/kubernetes/kubernetes/issues/60745](https://github.com/kubernetes/kubernetes/issues/60745)

            * [https://github.com/kubernetes/kubernetes/issues/60725](https://github.com/kubernetes/kubernetes/issues/60725)

            * [https://github.com/kubernetes/kubernetes/issues/60763](https://github.com/kubernetes/kubernetes/issues/60763)

    * 1.9-master upgrade suites

        * Successfully upgraded!

        * Now deal with REAL test failures:

            * Unbrella issue: [https://github.com/kubernetes/kubernetes/issues/60764](https://github.com/kubernetes/kubernetes/issues/60764)

        * Test failures are linked within the issue

        * The downgrade suite is still borked, assigned to sig-cluster-lifecycle

        * 1.9 test breaks after upgrading to 1.10 - better design?

            * Talking to sig-cluster-lifecycle

    * Scalability suite is still flaky

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589)

        * [https://github.com/kubernetes/kubernetes/pull/60740](https://github.com/kubernetes/kubernetes/pull/60740) fixes the timeout issue, @shyamjvs is following up to monitoring performance issue

    * Kubeadm suite start to failing again

        * [https://github.com/kubernetes/kubernetes/issues/59762](https://github.com/kubernetes/kubernetes/issues/59762) 

        * After some test-infra fixes still cannot find kubeconfig

        * And according to [https://github.com/kubernetes/kubernetes/issues/59762#issuecomment-365550168](https://github.com/kubernetes/kubernetes/issues/59762#issuecomment-365550168), the kubeadm jobs should not be release blocking anymore?

* Test Infra Updates [GREEN]

    * `/milestone` had a bug, but is working now.

* * *


## Date: 3/2/2018

Video [Link](https://youtu.be/HeuMd3UDut8)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[GREEN]

    * Beta cut

    * Docs PRs due for review

    * Code freeze

    * Exception reviews

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[GREEN]

    * Another beta

    * Docs PRs are finalized

    * Release notes draft ready for review/refine

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 22

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 

            * [https://github.com/kubernetes/kubernetes/issues/60507](https://github.com/kubernetes/kubernetes/issues/60507) has PR open now and looking on track

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues:

        * Other priority Issues: 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 36 ↑# ↓# vs 238 ↑# closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Exception Requests [GREEN]

    * Approved request:

        * **Feature name:** [RunAsGroup in pod and container SecurityContext](https://groups.google.com/d/msg/kubernetes-milestone-burndown/kq4zhEI_c-I/vLVpJlMMBAAJ) 

* Branch Updates / Branch Health [GREEN]

    * Nothing to add

* Critical build failures [YELLOW]

    * Gce|gke-serial is failing daemonset tests

        * [https://github.com/kubernetes/kubernetes/issues/60003](https://github.com/kubernetes/kubernetes/issues/60003)

        * Fix opened: [https://github.com/kubernetes/kubernetes/pull/60672](https://github.com/kubernetes/kubernetes/pull/60672)

    * 1.9-master upgrade suites are failing on daemonset upgrade

        * [https://github.com/kubernetes/kubernetes/issues/60437](https://github.com/kubernetes/kubernetes/issues/60437)

        * [https://github.com/kubernetes/kubernetes/pull/60386](https://github.com/kubernetes/kubernetes/pull/60386) merged this morning, will follow up with today’s run

    * Scalability suite is flaky

        * [https://github.com/kubernetes/kubernetes/issues/60589](https://github.com/kubernetes/kubernetes/issues/60589)

        * Thanks Wojtec for triaging 

    * Kubeadm suite start to failing again

        * [https://github.com/kubernetes/kubernetes/issues/59762](https://github.com/kubernetes/kubernetes/issues/59762) 

        * @bentheelder has some fix to let kubeadm use latest-bazel build

* Test Infra Updates [GREEN]

    * `/milestone` command should be available later today. (WOOO!)

* User-facing Documentation YELLOW

    * (jrondeau) Working through tracking spreadsheet, pinging outstanding docs. Today is deadline, but I’m cutting some slack because I haven’t been reminding folks

    * (jrondeau) EOD update 3/2: 7 PRs + 4 features that don’t need docs identified on tracking board, out of 33 features. 3 other features look to be in doubt. Qs out in all remaining GH issues; at least half a dozen look as though they don’t need doc updates, but still confirming.

* Marketing [GREEN]

    * Nick, Ihor, Caleb, Jaice, Jennifer need to give the blog a once-over to ensure what is in there is accurate

    * Need to look at media key messages document ASAP!

    * 5 blog series is looking good

    * email sent out with those links/timing, please +1 in thread

* Release notes update [YELLOW]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Noah Abrahams is working on the basic draft

    * Correlating timeline vs. github branching ~ 

    * Jaice, Noah, and Jennifer meeting next week!

* Announcements / Open Mic

    * Nick will be running meetings next week

* Retro items ([Retro doc](http://bit.ly/kube110retro))

    * Release notes continues to be agonizing

## * * *


## Date: 2/28/2018

Video [Link](https://youtu.be/cx9bdcKY3jw)

Attending:

* Jaice, Nick, Vignesh, Noah, Sen, Jordan, Tim Pepper, Ihor, Josh, Cole Wagner, Natasha, 

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Code freeze

        * In effect

        * Exceptions have been going ok

    * Pruning

        * What do we need to keep an eye on?

    * beta to be cut

        * Fast forwarded release-1.10 branch today (28 Feb 18) [calebamiles]

        * Will wait for CI to run against branch

        * Will start cutting beta from branch

    * Docs PR deadline (not reviewed, but ready for review, and at a high level)

        * We need an update ASAP

    * Release notes - hopefully a cut by Friday

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Next beta

    * Docs complete deadline

* Issue review by SIG 
[Bug Leaderboard](https://docs.google.com/spreadsheets/d/1SAl4YcsB6V9yrBVN88FGMoC9rUUykAepDq2sfKQAOfM/edit?usp=sharing) ~ updated later today

    * Extra 24 hours helped

    * 

* Updates (general)

* Critical build failures [YELLOW]

    * Gke suites are fixed (yay)

    * Gci-gke|gce-slow is failing on a network test 

        * [https://github.com/kubernetes/kubernetes/issues/60588](https://github.com/kubernetes/kubernetes/issues/60588)

    * Gce|gke-ingress is failing L7 LB tests

        * [https://github.com/kubernetes/kubernetes/issues/60381](https://github.com/kubernetes/kubernetes/issues/60381)

    * Gce|gke-serial is failing daemonset tests

        * [https://github.com/kubernetes/kubernetes/issues/60003](https://github.com/kubernetes/kubernetes/issues/60003)

    * 1.9-master upgrade suites are failing on daemonset upgrade

        * [https://github.com/kubernetes/kubernetes/issues/60437](https://github.com/kubernetes/kubernetes/issues/60437)

        * Fix opened in [https://github.com/kubernetes/kubernetes/pull/60386](https://github.com/kubernetes/kubernetes/pull/60386)

    * Scalability suite is flaky

    * Kubeadm suite start to failing again

        * [https://github.com/kubernetes/kubernetes/issues/59762](https://github.com/kubernetes/kubernetes/issues/59762) 

* Exception Requests [GREEN]

    * Approved the following exceptions:

        * **Feature name:** [Advanced Audit Logging](https://groups.google.com/d/msg/kubernetes-milestone-burndown/FeOcIqdRmZQ/7G2s2WMIAQAJ)

        * **Feature name:** [GCE Regional Persistent Disk to beta](https://groups.google.com/d/msg/kubernetes-milestone-burndown/pwI3QwuCYL4/ugg9UdhWAQAJ)

    * Needs review/approval:

        * **Feature name:** [RunAsGroup in pod and container SecurityContext](https://groups.google.com/d/msg/kubernetes-milestone-burndown/kq4zhEI_c-I/vLVpJlMMBAAJ) 

* * *


## Date: 2/26/2018

Video [Link](https://youtu.be/2HRpZ8TLUlg)

Attending:

* Jaice, Josh, Nick, Natasha, Sen, Caleb, Stephen, Kaitlyn, Ihor

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[YELLOW]

    * Code freeze

        * Question: Is mungegithub still responsible for enforcing code freeze or do will live in an all tide world now **Answer: mungegithub for now**

        * PR: https://github.com/kubernetes/test-infra/pull/6999

    * Pruning

        * What do we need to keep an eye on?

    * beta to be cut

    * Docs PR deadline (not reviewed, but ready for review, and at a high level)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Next beta

    * Docs complete deadline

* Metrics review ↕0 ↑# ↓# [YELLOW]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 36↓12

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 0↕0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 1↕0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 17↓2

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 7↑1

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 6↓1

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 5↑1

        * Other priority Issues: 0↓2

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 38 ↑# ↓# vs 148 ↑# closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Issue review by SIG 
[Bug Leaderboard](https://docs.google.com/spreadsheets/d/1SAl4YcsB6V9yrBVN88FGMoC9rUUykAepDq2sfKQAOfM/edit?usp=sharing)

* Critical build failures [YELLOW]

    * OSS gke tests are all failing reach API server - [https://github.com/kubernetes/kubernetes/issues/60380](https://github.com/kubernetes/kubernetes/issues/60380)

        * Fix opened [https://github.com/kubernetes/kubernetes/pull/60334](https://github.com/kubernetes/kubernetes/pull/60334)

    * Ingress-gce is failing

        * [https://github.com/kubernetes/kubernetes/issues/60381](https://github.com/kubernetes/kubernetes/issues/60381)

        * Fix opened [https://github.com/kubernetes/kubernetes/pull/59982](https://github.com/kubernetes/kubernetes/pull/59982)

    * Serial-gce suite is failing

        * [https://github.com/kubernetes/kubernetes/issues/60003](https://github.com/kubernetes/kubernetes/issues/60003)

        * sig-network and sig-app tests

        * Needs triage

    * Upgrade test is failing

        * **Looks like daemonset upgrade is failing (sig-apps)**

        * [https://github.com/kubernetes/kubernetes/issues/60437](https://github.com/kubernetes/kubernetes/issues/60437) 

        * Needs triage

* Test failure triage/resolution updates [GREEN]

    * 7 open issues

    * Lots of noise from GKE tests, but fix PRs are open

* Test Infra Updates [YELLOW]

    * Cole to finish release jobs PR: [https://github.com/kubernetes/test-infra/pull/6834](https://github.com/kubernetes/test-infra/pull/6834)

    * Prioritized for today

    * Also doing code freeze

* Documentation & Marketing [GREEN]

    * Marketing:

        * Blog announcement is pre-drafted, Jaice to review and ensure what is in the release is reflected in the blog

        * Solidify the 5 blogs for the blog series - get agreement

        * Sound bite document for media Q&A - source of truth on the release

        * Schedule the post-release webinar with release team

    * Docs:

        * Need update from Jennifer

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

    * Auto-generated version is now working

    * Have basics in the preview blog, probably on k8s.io

    * Some status in the features tracking spreadsheet are not accurate (Ihor)

    * First cut soon

    * Link to the preview blog

* Announcements / Open Mic

    * M-W-F ~ cancellations will be in email and Slack channel

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *


## Date: 12/19/2018 ~ Cancelled for holiday

Video Link

Attending:

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[GREEN]

    * Code slush

    * Issue labels are correct and tracked

    * Begin hunting for "black swans"

    * Release notes status especially important so we know how to target our efforts on collecting this 

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[YELLOW]

    * Code Freeze

        * Need to turn on automation

    * Begin MWF Burndown meetings

    * Begin pruning (as necessary)

    * 1.10.0-beta.1 release

    * Docs deadline - PRs ready for review

    * Getting into crunch time

* Metrics review ↕0 ↑# ↓# [RED/YELLOW/GREEN]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 48 ↑5 

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 1 ↑1

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 21 ↑3 (trending up week over week)

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 5 ↑5 

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 8 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 13 ↓3

        * Other priority Issues: 

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 32 vs 92 closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

            * [Maximum of N per topology value. ](https://github.com/kubernetes/kubernetes/pull/41718)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Issue review by [SIG](https://docs.google.com/spreadsheets/d/1SAl4YcsB6V9yrBVN88FGMoC9rUUykAepDq2sfKQAOfM/edit#gid=161799236) 

* First critical and failing test issues

* * *


## Date: 2/12/2018

Video Link

Attending:

* Jaice Singer DuMars, SIG-human

* Jennifer Rondeau

* Nick Chase

* Jasmine the Puppy

* Sen Lu

* Natasha Woods

* Vignesh Pamu

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week  7/12 *[GREEN]

    * 1.10.0-beta.0 release

    * Create 'release-1.10' branch and begin daily branchff

    * All release branch CI jobs created

    * Send out weekly update

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week 8/12 *[GREEN]

    * Begin Code Slush

* Metrics review ↕0 ↑# ↓# [GREEN]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 43 ↓4 

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 0 ↕0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 0 ↕0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 18 ↑2 (trending up)

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 0 ↕0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 8 ↑3 

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 16 ↓8

        * Other Priority Issues: 1  ↕0

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: # ↑# ↓# vs # ↑# closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Exception Requests [GREEN]

    * None

* Issue review by SIG 
[Bug Leaderboard](https://docs.google.com/spreadsheets/d/1SAl4YcsB6V9yrBVN88FGMoC9rUUykAepDq2sfKQAOfM/edit?usp=sharing)


             Approved-for-milestone: 6
             Not approved: 37

<table>
  <tr>
    <td>SIG</td>
    <td>LINK</td>
    <td>COUNT</td>
    <td>DELTA ↕0 ↑# ↓# </td>
  </tr>
  <tr>
    <td>sig/api-machinery</td>
    <td>sig/api-machinery</td>
    <td>8</td>
    <td>↓1</td>
  </tr>
  <tr>
    <td>sig/apps</td>
    <td>sig/apps</td>
    <td>2</td>
    <td>↑2</td>
  </tr>
  <tr>
    <td>sig/architecture</td>
    <td>sig/architecture</td>
    <td>2</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/auth</td>
    <td>sig/auth</td>
    <td>6</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/autoscaling</td>
    <td>sig/autoscaling</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/aws</td>
    <td>sig/aws</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/azure</td>
    <td>sig/azure</td>
    <td>6</td>
    <td>↓1</td>
  </tr>
  <tr>
    <td>sig/cli</td>
    <td>sig/cli</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/cluster-lifecycle</td>
    <td>sig/cluster-lifecycle</td>
    <td>7</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/federation</td>
    <td>sig/federation</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/gcp</td>
    <td>sig/gcp</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/instrumentation</td>
    <td>sig/instrumentation</td>
    <td>3</td>
    <td>↓1</td>
  </tr>
  <tr>
    <td>sig/network</td>
    <td>sig/network</td>
    <td>2</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/node</td>
    <td>sig/node</td>
    <td>19</td>
    <td>↓1</td>
  </tr>
  <tr>
    <td>sig/release</td>
    <td>sig/release</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/scalability</td>
    <td>sig/scalability</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/service-catalog</td>
    <td>sig/service-catalog</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/storage</td>
    <td>sig/storage</td>
    <td>2</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/testing</td>
    <td>sig/testing</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/windows</td>
    <td>sig/windows</td>
    <td>3</td>
    <td>↑1</td>
  </tr>
</table>


* Branch Updates / Branch Health [GREEN]

* Test failure triage/resolution updates [YELLOW]

    * kubeadm tests need attention

* Test Infra Updates [GREEN]

    * On track to have the blocking tests on the release branch this week

* Documentation & Marketing [GREEN]

    * Tracking the timeline

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

* Announcements / Open Mic

    * None

* Retro items ([Retro doc](http://bit.ly/kube110retro))

* * *


## Date: 2/5/2018 ~ [video](https://youtu.be/hH9qfh-HWdI)

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[GREEN]

    * Possibly the pre-blog

        * Next week

    * Looking at issues, signal, release notes more deeply

        * New label coming for external-facing docs needed

        * Intermediate release notes draft underway

        * Starting to connect with SIGs on RNs early March

    * Send out weekly update + reminder of code slush/freeze dates

    * Marketing met with Ihor and developed an outline

        * Need reviews

    * Questions reporters have that need a source of truth, but are not in the blog

    * Marketing on track

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[GREEN]

    * 1.10.0-beta.0 release

    * Create 'release-1.10' branch and begin daily branchff

    * All release branch CI jobs created

* Metrics review ↕0 ↑# ↓# [GREEN]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 47 ↑2

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 0 ↕0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 0 ↕0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 16 ↑4

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 0 ↕0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 5 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 25 ↓2

        * Other Priority Issues: 1  ↕0

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: # ↑# ↓# vs # ↑# closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Issue review by SIG 

	Issue Leaderboard as of 2/3: 

<table>
  <tr>
    <td>SIG</td>
    <td>LINK</td>
    <td>COUNT</td>
    <td>DELTA ↕0 ↑# ↓# </td>
  </tr>
  <tr>
    <td>sig/api-machinery</td>
    <td>sig/api-machinery</td>
    <td>9</td>
    <td>↑1</td>
  </tr>
  <tr>
    <td>sig/apps</td>
    <td>sig/apps</td>
    <td>2</td>
    <td>0</td>
  </tr>
  <tr>
    <td>sig/architecture</td>
    <td>sig/architecture</td>
    <td>2</td>
    <td>↑1</td>
  </tr>
  <tr>
    <td>sig/auth</td>
    <td>sig/auth</td>
    <td>6</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/autoscaling</td>
    <td>sig/autoscaling</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/aws</td>
    <td>sig/aws</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/azure</td>
    <td>sig/azure</td>
    <td>7</td>
    <td>↑1</td>
  </tr>
  <tr>
    <td>sig/cli</td>
    <td>sig/cli</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/cluster-lifecycle</td>
    <td>sig/cluster-lifecycle</td>
    <td>7</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/federation</td>
    <td>sig/federation</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/gcp</td>
    <td>sig/gcp</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/instrumentation</td>
    <td>sig/instrumentation</td>
    <td>4</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/network</td>
    <td>sig/network</td>
    <td>2</td>
    <td>↑1 </td>
  </tr>
  <tr>
    <td>sig/node</td>
    <td>sig/node</td>
    <td>20</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/release</td>
    <td>sig/release</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/scalability</td>
    <td>sig/scalability</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/service-catalog</td>
    <td>sig/service-catalog</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/storage</td>
    <td>sig/storage</td>
    <td>2</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/testing</td>
    <td>sig/testing</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/windows</td>
    <td>sig/windows</td>
    <td>2</td>
    <td>↕0</td>
  </tr>
</table>


### List of Issues which look suspiciously like untracked features:

This is from Josh, for Ihor, as of 2/2.  List may not be complete, this is a by-hand review:

* CRI log rotation: [https://github.com/kubernetes/kubernetes/issues/58823](https://github.com/kubernetes/kubernetes/issues/58823)

* Taint CSI node shutdown condition: [https://github.com/kubernetes/kubernetes/issues/58635](https://github.com/kubernetes/kubernetes/issues/58635)

* Add metadata to on-disk log file: [https://github.com/kubernetes/kubernetes/issues/58638](https://github.com/kubernetes/kubernetes/issues/58638)

* Add field to NodeStatus: [https://github.com/kubernetes/kubernetes/issues/56896](https://github.com/kubernetes/kubernetes/issues/56896)

* Do deprecations get tracked as features?  [https://github.com/kubernetes/kubernetes/issues/56523](https://github.com/kubernetes/kubernetes/issues/56523)

* CRI log stats: [https://github.com/kubernetes/kubernetes/issues/55905](https://github.com/kubernetes/kubernetes/issues/55905)

* NVIDIA plugin: [https://github.com/kubernetes/kubernetes/issues/54011](https://github.com/kubernetes/kubernetes/issues/54011)

* Non-builtin CRI runtimes: [https://github.com/kubernetes/kubernetes/issues/47872](https://github.com/kubernetes/kubernetes/issues/47872)

* File-based interface for container logs: [https://github.com/kubernetes/kubernetes/issues/42188](https://github.com/kubernetes/kubernetes/issues/42188)

	All owners of issues with incomplete labels have been nagged.

* Test failure triage/resolution updates [GREEN]

    * Tests for GKE fixed

* Test Infra Updates [GREEN]

    * Everything looking good so far

* Documentation & Marketing [GREEN]

    * On track

* Release notes update [GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

* Announcements / Open Mic

* Retro items ([Retro doc](http://bit.ly/kube110retro))

* * *


## Date: 1/29/2018

Video Link

Attending:

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *this week *[GREEN]

    * Feature freeze follow-up [ Ihor ] 

        * In good progress with features, 35 in the release

        * Smaller than previous releases, may have some things in the KEP process

        * Marketing team follow-up tomorrow

        * Documentation team and Release team GO! See Ihor if you have questions

        * Need non-user facing docs label ~ either SIG-Testing or SIG-Contribx

    * Alpha release follow-up [ Caleb ]

        * Cut -alpha.2 this Friday no hiccups

* [Timeline](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-1.10.md) for *next week *[GREEN]

    * Marketing ramps up

    * Preview blog?

    * Start looking at issues, signal, release notes more deeply

* Metrics review ↕0 ↑# ↓# [GREEN]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 45 ↕0

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 0 ↕0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 0 ↕0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 12 ↕0

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 0 ↕0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 5 ↕0

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 27 ↕0

        * Other Priority Issues: 1  ↕0

        * [Non-Blocking, Labels Incomplete](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone-labels-incomplete) Issues: 0 ↕0

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 30 ↑3  vs 60 ↑9 closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Issue review by SIG 
[Issue Leaderboard](https://docs.google.com/spreadsheets/d/1SAl4YcsB6V9yrBVN88FGMoC9rUUykAepDq2sfKQAOfM/edit?usp=sharing)

<table>
  <tr>
    <td>SIG</td>
    <td>LINK</td>
    <td>COUNT</td>
    <td>DELTA ↕0 ↑# ↓# </td>
  </tr>
  <tr>
    <td>sig/api-machinery</td>
    <td>sig/api-machinery</td>
    <td>8</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/apps</td>
    <td>sig/apps</td>
    <td>2</td>
    <td>↓1</td>
  </tr>
  <tr>
    <td>sig/architecture</td>
    <td>sig/architecture</td>
    <td>1</td>
    <td>?</td>
  </tr>
  <tr>
    <td>sig/auth</td>
    <td>sig/auth</td>
    <td>6</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/autoscaling</td>
    <td>sig/autoscaling</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/aws</td>
    <td>sig/aws</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/azure</td>
    <td>sig/azure</td>
    <td>6</td>
    <td>?</td>
  </tr>
  <tr>
    <td>sig/cli</td>
    <td>sig/cli</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/cluster-lifecycle</td>
    <td>sig/cluster-lifecycle</td>
    <td>7</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/federation</td>
    <td>sig/federation</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/gcp</td>
    <td>sig/gcp</td>
    <td>1</td>
    <td>?</td>
  </tr>
  <tr>
    <td>sig/instrumentation</td>
    <td>sig/instrumentation</td>
    <td>4</td>
    <td>↑2 </td>
  </tr>
  <tr>
    <td>sig/network</td>
    <td>sig/network</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/node</td>
    <td>sig/node</td>
    <td>20</td>
    <td>↑1 </td>
  </tr>
  <tr>
    <td>sig/release</td>
    <td>sig/release</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/scalability</td>
    <td>sig/scalability</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/service-catalog</td>
    <td>sig/service-catalog</td>
    <td>0</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/storage</td>
    <td>sig/storage</td>
    <td>2</td>
    <td>↑1 </td>
  </tr>
  <tr>
    <td>sig/testing</td>
    <td>sig/testing</td>
    <td>1</td>
    <td>↕0</td>
  </tr>
  <tr>
    <td>sig/windows</td>
    <td>sig/windows</td>
    <td>2</td>
    <td>??</td>
  </tr>
</table>


* Branch Updates / Branch Health [RED/YELLOW/GREEN]

    * None

* Critical build failures [RED/YELLOW/GREEN]

* Test failure triage/resolution updates [RED/YELLOW/GREEN]

* Test Infra Updates [RED/YELLOW/GREEN]

* Documentation & Marketing [RED/YELLOW/GREEN]

    * JR: Sending email to SIGs later today with docs information, working with Zach to get docs documentation for the release process updated, 

* Release notes update [RED/YELLOW/GREEN]

    * Link to the [draft](https://github.com/kubernetes/sig-release/blob/master/releases/release-1.10/release-notes-draft.md)

* Announcements / Open Mic

    * Ihor missing next Monday

* Retro items ([Retro doc](http://bit.ly/kube110retro))

## * * *
Date: 1/22/2018 - release week 4 / 12

Video [Link](https://www.youtube.com/watch?v=onlFHICYB4Q&feature=youtu.be)

Attending:

* Ihor Dvoretskyi (features lead/CNCF)

* Jennifer Rondeau (docs lead/Heptio)

* Jaice Singer DuMars (Release lead, SIG-multiples)

* Steve Wade (Shadow Release Lead, Apprenda)

* Noah Abrahams (Shadow Release Notes)

* Tim Pepper (Shadow Bug Wrangler, VMware)

* Josh Berkus (Bug Wranglere, Red Hat)

* Sen Lu (CI Signal)

* David McMahon

* [Timeline](https://github.com/kubernetes/features/blob/master/release-1.10/release-1.10.md) for *this week *[RED]

    * Need to get alpha prerequisites figured out for Caleb

        * Caleb trying finish onboarding again today (22 Jan 2018)

    * Extend Feature Freeze to 1/29 and radiate

    * Marketing efforts begin

    * Need to start digging into CI signal and issues

    * SIGs need to identify what will need docs or not

    * Need to discuss better project tracking

    * Jaice to replace Phil as SIG-Release lead

* [Timeline](https://github.com/kubernetes/features/blob/master/release-1.10/release-1.10.md) for *next week *[GREEN]

    * 1.10.0-alpha.2 release

    * Wrap up the features process

    * Marketing planning/meeting

* Metrics review [GREEN]

    * [Open issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10) in the milestone: 44

        * [Release blocker](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Arelease-blocker) issues: 0

        * [Critical](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fcritical-urgent) Issues: 0

        * [Important](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-soon) Issues: 12

        * [Failing test](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Akind%2Ffailing-test) issues: 0

        * [Long term](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Apriority%2Fimportant-longterm) issues: 5

        * [No-priority](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=-label%3Apriority%2Fimportant-longterm%20is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20-label%3Apriority%2Fcritical-urgent%20-label%3Apriority%2Fimportant-soon%20-label%3Akind%2Ffailing-test%20) Issues: 27

        * [Non-Blocking, Labels Incomplete](https://github.com/kubernetes/kubernetes/issues?q=is%3Aissue+is%3Aopen+milestone%3Av1.10+label%3Amilestone-labels-incomplete) Issues: 0

    * [Bot-removed issues](https://github.com/kubernetes/kubernetes/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20milestone%3Av1.10%20label%3Amilestone-removed): 0

    * [Open PRs](https://github.com/kubernetes/kubernetes/pulls?q=is%3Apr+is%3Aopen+milestone%3Av1.10+sort%3Aupdated-desc) in the milestone: 27 vs 51 closed

        * [Release Blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Arelease-blocker%20) (links to PRs of interest)

        * [Critical](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fcritical-urgent%20) (links to PRs of interest)

        * [Important-Soon](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-soon) (links to PRs of interest)

        * [Test-blocking](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Akind%2Ffailing-test) (links to PRs of interest)

    * [Long-term](https://github.com/kubernetes/kubernetes/pulls?utf8=%E2%9C%93&q=is%3Apr%20is%3Aopen%20milestone%3Av1.10%20label%3Apriority%2Fimportant-long-term)

    * Testgrid dashboards

        * [presubmits-kubernetes-blocking](http://k8s-testgrid.appspot.com/presubmits-kubernetes-blocking)

        * [sig-release-master-blocking](https://k8s-testgrid.appspot.com/sig-release-master-blocking)

        * [sig-release-master-upgrade](https://k8s-testgrid.appspot.com/sig-release-master-upgrade)

        * [sig-release-1.10-blocking](https://k8s-testgrid.appspot.com/sig-release-1.10-blocking)

        * [sig-release-1.10-all](https://k8s-testgrid.appspot.com/sig-release-1.10-all)

* Issue review by SIG 

<table>
  <tr>
    <td>SIG</td>
    <td>LINK</td>
    <td>COUNT</td>
    <td>DELTA ↕0 ↑# ↓# </td>
  </tr>
  <tr>
    <td>sig/api-machinery</td>
    <td>sig/api-machinery</td>
    <td>8</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/apps</td>
    <td>sig/apps</td>
    <td>3</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/auth</td>
    <td>sig/auth</td>
    <td>6</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/autoscaling</td>
    <td>sig/autoscaling</td>
    <td>1</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/aws</td>
    <td>sig/aws</td>
    <td>1</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/cluster-lifecycle</td>
    <td>sig/cluster-lifecycle</td>
    <td>7</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/federation</td>
    <td>sig/federation</td>
    <td>0</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/instrumentation</td>
    <td>sig/instrumentation</td>
    <td>2</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/network</td>
    <td>sig/network</td>
    <td>1</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/node</td>
    <td>sig/node</td>
    <td>19</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/release</td>
    <td>sig/release</td>
    <td>0</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/scalability</td>
    <td>sig/scalability</td>
    <td>1</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/service-catalog</td>
    <td>sig/service-catalog</td>
    <td>0</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/storage</td>
    <td>sig/storage</td>
    <td>1</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/testing</td>
    <td>sig/testing</td>
    <td>1</td>
    <td></td>
  </tr>
  <tr>
    <td>sig/cli</td>
    <td>sig/cli</td>
    <td>1</td>
    <td></td>
  </tr>
</table>


* Branch Updates / Branch Health [RED]

    * Cannot cut an Alpha currently

* Testing

    * Some AWS tests may fail due to quota issues

* Documentation & Marketing [YELLOW]

    * Need to set up 1.10 docs branch, reach out to individual SIGs

    * Docs branch strategy is different

    * 22 open features in 1.10 milestone, not all feature owners have updated 

    * Key features and messages are available

    * Meeting today to discuss messaging, blog outline, and planning

* Release notes update [RED/YELLOW/GREEN]

    * Link to the [draft](https://github.com/kubernetes/features/blob/master/release-1.10/release-notes-draft.md)

    * Nick wants a better solution for generated docs

    * Updates pending

* Announcements / Open Mic

    * None

* Retro items ([Retro doc](http://bit.ly/kube110retro))

    * Reminder to log your feedback as we go so it doesn’t get missed

