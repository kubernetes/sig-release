## Private Distributors List

This list is used to provide actionable information to multiple distribution
vendors at once. This list is not intended for individuals to find out about
security issues.

### Embargo Policy

The information members receive on distributors-announce@kubernetes.io must not be
made public, shared, nor even hinted at anywhere beyond the need-to-know within
your specific team except with the list's explicit approval. This holds
true until the public disclosure date/time that was agreed upon by the list.
Members of the list and others may not use the information for anything other
than getting the issue fixed for your respective distribution's users.

Before any information from the list is shared with respective members of your
team required to fix said issue, they must agree to the same terms and only
find out information on a need-to-know basis.

In the unfortunate event you share the information beyond what is allowed by
this policy, you _must_ urgently inform the security@kubernetes.io
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

### Membership


| Email		| Organization	|
| ------------- |:-------------:|
| argoprod@us.ibm.com | IBM |
| aws-k8s-embargo-notification@amazon.com | AWS |
| bphilips@redhat.com | Kubernetes PST |
| brandon@ifup.org | Kubernetes PST |
| cjcullen@google.com | Kubernetes PST |
| k8s_security_grp@oracle.com | Oracle |
| kops-security-response@googlegroups.com | Kops |
| kubernetes-security-disclosure@google.com | Google |
| kubernetes-security@docker.com | Docker |
| kubernetes-security@huawei.com | Huawei |
| kubernetes-security@service.aliyun.com | Aliyun |
| kubernetes-security@service.microsoft.com | Microsoft |
| kubernetes-security@weave.works | WeaveWorks |
| liggitt@google.com | Kubernetes PST |
| me@jessfraz.com | Kubernetes PST |
| mke-security@mesosphere.com | Mesosphere |
| secalert@redhat.com | Red Hat |
| secure@sap.com | SAP |
| security-release-team@kubernetes.io | Kubernetes PST |
| security@kubernetes.io | Kubernetes PST |
| security@rancher.com | Rancher |
| security@vmware.com | VMware |
| stclair@google.com | Kubernetes PST |
| upstream-security@heptio.com | Heptio |
| vulnerabilityreports@cloudfoundry.org | Cloud Foundry |
| security@platform9.com | Platform9
| security@gravitational.com | Gravitational |

### Membership Criteria

To be eligible for the distributors-announce@kubernetes.io mailing list, your
distribution should:

0. Have an actively monitored security email alias for our project.
1. Be an actively maintained and [CNCF certified distribution of
   Kubernetes][conformance] components.
2. Have a user base not limited to your own organization.
3. Have a publicly verifiable track record up to present day of fixing security
   issues.
4. Not be a downstream or rebuild of another distribution.
5. Be a participant and active contributor in the community.
6. Accept the [Embargo Policy](#embargo-policy) that is outlined above.
7. Be willing to [contribute back](#contributing-back) as outlined above.
8. Have someone already on the list vouch for the person requesting membership
   on behalf of your distribution.

[conformance]: https://www.cncf.io/certification/software-conformance/

**Removal**: If your distribution stops meeting one or more of these criteria
after joining the list then you will be unsubscribed.

### Requesting to Join

New membership requests are sent to security@kubernetes.io

In the body of your request please specify how you qualify and fulfill each
criterion listed in [Membership Criteria](#membership-criteria).

Here is a psuedo example:

```
To: security@kubernetes.io
Subject: Seven-Corp Membership to distributors-announce@kubernetes.io

Below are each criterion and why I think we, Seven-Corp, qualify.

> 0. Have an actively monitored security alias email for our project.

Yes, please subscribe kubernetes-security-team@example.com to the distributor's
announce list.

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

> 10. Link to PR updating this document with your email in the membership table.

https://github.com/kubernetes/sig-release/edit/master/security-release-process-documentation/private-distributors-list.md
```


