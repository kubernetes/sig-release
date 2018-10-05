# Kubernetes Security Process Email Templates

This is a collection of email templates to handle various situations the PST needs to handle.

## Distributor List Removal

Subject: Kubernetes Disclosure List Removal Due to Uncertified Status

Hello $MEMBER-

The [Kubernetes Product Security Team][pst] has removed $EMAIL from the distributors-announce@kubernetes.io Google Group.

This is because $PRODUCT is no longer a [certified Kubernetes Distribution][conformance], a requirement for membership to this list.

If $PRODUCT recertifies, and meets all other criteria, please submit a [request to re-join using the normal process][join-process].

Thank You,

$PERSON on behalf of the Kubernetes

[pst]: https://github.com/kubernetes/sig-release/blob/master/security-release-process-documentation/security-release-process.md#product-security-team-pst
[conformance]: https://www.cncf.io/certification/software-conformance/
[criteria]: https://github.com/kubernetes/sig-release/blob/master/security-release-process-documentation/security-release-process.md#membership-criteria
[join-process]: https://github.com/kubernetes/sig-release/blob/master/security-release-process-documentation/security-release-process.md#private-distributors-list
