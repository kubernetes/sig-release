# Contributing Guidelines

Welcome to Kubernetes. We are excited about the prospect of you joining our [community](https://git.k8s.io/community)! The Kubernetes community abides by the CNCF [code of conduct](code-of-conduct.md). Here is an excerpt:

_As contributors and maintainers of this project, and in the interest of fostering an open and welcoming community, we pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities._

- [Getting Started](#getting-started)
- [Mentorship](#mentorship)
- [Contact Information](#contact-information)
- [Contributing Code](#contributing-code)
- [Coding Style](#coding-style)
  - [Explain 'nolint' Directives](#explain-nolint-directives)
  - [Use Descriptive Variable Names Sparingly](#use-descriptive-variable-names-sparingly)
  - [Don't Wrap Function Signatures](#dont-wrap-function-signatures)
  - [Return Early](#return-early)
  - [Wrap Errors](#wrap-errors)
  - [Scope Errors](#scope-errors)
  - [Prefer Table Driven Tests](#prefer-table-driven-tests)
- [Establishing a Development Environment](#establishing-a-development-environment)
- [Attribution](#attribution)

## Getting Started

We have full documentation on how to get started contributing here:

<!---
If your repo has certain guidelines for contribution, put them here ahead of the general k8s resources
-->

- [Contributor License Agreement](https://git.k8s.io/community/CLA.md) Kubernetes projects require that you sign a Contributor License Agreement (CLA) before we can accept your pull requests
- [Kubernetes Contributor Guide](https://git.k8s.io/community/contributors/guide) - Main contributor documentation, or you can just jump directly to the [contributing section](https://git.k8s.io/community/contributors/guide#contributing)
- [Contributor Cheat Sheet](https://git.k8s.io/community/contributors/guide/contributor-cheatsheet) - Common resources for existing developers

## Mentorship

- [Mentoring Initiatives](https://git.k8s.io/community/mentoring) - We have a diverse set of mentorship programs available that are always looking for volunteers!

## Contact Information

<!-- TODO(contact): Dedupe with README and k/community -->

- [Slack channel](https://kubernetes.slack.com/messages/sig-release)
- [Mailing list](https://groups.google.com/forum/#!forum/kubernetes-sig-release)

## Contributing Code

To contribute bug fixes or features to SIG Release repositories:

1. Communicate your intent.
1. Make your changes.
1. Test your changes.
1. Update documentation and examples where appropriate.
1. Open a Pull Request (PR).

Communicating your intent lets SIG Release members know that you intend
to contribute, and how. This sets you up for success - you can avoid duplicating
an effort that may already be underway, adding a feature that may be rejected,
or heading down a path that you would be steered away from at review time. The
best way to communicate your intent is via a detailed GitHub issue. Take a look
first to see if there's already an issue relating to the thing you'd like to
contribute. If there isn't, please raise a new one! Let us know what you'd like
to work on, and why. SIG Release members can't always triage new issues
immediately, but we encourage you to bring them to our attention via one of our
[communication channels][contact].

> NOTE: Unlike the core [Kubernetes release cycle][kubernetes-release-cycle],
> [SIG Release repositories][sig-release-subprojects] are versioned/released on
> ad hoc (as needed basis), which means that the changes you've made will
> not necessarily be immediately available for consumption in tagged artifacts.
>
> We may release components for the following, non-exhaustive reasons:
>
> - unblocking a core Kubernetes release cycle
> - unblocking Kubernetes projects that leverage our libraries
> - mitigating a security vulnerability
> - critical bug fixes or regressions
> - a feature is incomplete or does not work as intended
>
> If you need a new component release to unblock your project, please contact us to request one.

<!--
TODO(contribute): Review Crossplane release process for more inspiration
ref: https://github.com/crossplane/crossplane/blob/master/docs/reference/release-cycle.md
-->

Be sure to practice [good git commit hygiene] as you make your changes. All but
the smallest changes should be broken up into a few commits that tell a story.
Use your git commits to provide context for the folks who will review PR, and
the folks who will be spelunking the codebase in the months and years to come.
Ensure each of your commits is signed-off by using `git commit -s`. SIG Release
members highly values readable, idiomatic Go code. Familiarize yourself with
the [Coding Style](#coding-style) section below and try to preempt any comments
your reviewers would otherwise leave. Most repos will contain `Makefile`s or
[`mage`][mage] targets that will help you build/test/lint/verify your changes.
If you don't see a target for your use case, maybe that could be your first
contribution!

<!--
TODO(contribute): Decide on stance around testing libraries: https://github.com/golang/go/wiki/TestComments#assert-libraries
-->

All code should be covered by tests. We strive, wherever possible, to follow
the common Go [test review comments]. We encourage the use of table-driven
unit tests - you can find an example [below](#prefer-table-driven-tests). Note
that when opening a PR your reviewer will expect you to detail how you've
tested your work. For all but the smallest changes, some manual testing is
encouraged in addition to unit tests.

All documentation is under revision control. Any change that introduces new
behavior or changes existing behavior must include updates to any relevant
documentation. Please keep documentation changes in distinct commits.

Once your change is written, tested, and documented the final step is to have it
reviewed! You'll be presented with a template and a small checklist when you
open a PR. Please read the template and fill out the checklist. Please make all
requested changes in subsequent commits. This allows your reviewers to see what
has changed as you address their comments. Be mindful of your commit history as
you do this - avoid commit messages like "Address review feedback" if possible.
If doing so is difficult a good alternative is to rewrite your commit history
to clean them up after your PR is approved but before it is merged.

In summary, please:

- Discuss your change in a GitHub issue before you start.
- Use your Git commit messages to communicate your intent to your reviewers.
- Sign-off on all git commits by running `git commit -s`
- Add or update tests for all changes.
- Preempt [coding style](#coding-style) review comments.
- Update all relevant documentation.
- Don't force push to address review feedback. Your commits should tell a story.
- If necessary, tidy up your git commit history once your PR is approved.

Thank you for reading through our contributing guide! We appreciate you taking
the time to ensure your contributions are high quality and easy for our
community to review and accept. Please don't hesitate to [reach out to
us][contact] if you have any questions about contributing!

## Coding Style

SIG Release prefers not to maintain its own style guide, but we do
enforce the style and best practices established by the Go project and its
community. This means contributors should:

- Follow the guidelines set out by the [Effective Go] document.
- Preempt common Go [code review comments] and [test review comments].

These coding style guidelines apply to all SIG Release repositories unless
stated otherwise.

Below we cover some of the feedback we most frequently leave on pull requests.
Most of these are covered by the documents above, but may be subtle or easily
missed and thus warrant closer attention.

### Explain 'nolint' Directives

We use [golangci-lint] on all our Golang-based repositories to enforce many
style and safety rules that are not covered here. We prefer to tolerate false
positives from our linter configuration in order to make sure we catch as many
issues as possible.
This means it's sometimes necessary to override the linter to make a build pass.

You can override the linter using a `//nolint` comment directive. When you do so
you must:

1. Be specific. Apply `//nolint:nameoflinter` at as tight a scope as possible.
1. Include a comment explaining why you're disabling the linter.

For example:

```go
func hash(s string) string {
        h := fnv.New32()
        _ = h.Write([]byte(s)) //nolint:errcheck // Writing to a hash never returns an error.
        return fmt.Sprintf("%x", h.Sum32())
}
```

Here we only disable the specific linter that would emit a warning (`errcheck`),
for the specific line where that warning would be emitted.

### Use Descriptive Variable Names Sparingly

Quoting the Go [code review comments]:

> Variable names in Go should be short rather than long. This is especially true
> for local variables with limited scope. Prefer `c` to `lineCount`. Prefer `i`
> to `sliceIndex`.
>
> The basic rule: the further from its declaration that a name is used, the more
> descriptive the name must be. For a method receiver, one or two letters is
> sufficient. Common variables such as loop indices and readers can be a single
> letter (`i`, `r`). More unusual things and global variables need more
> descriptive names.

Another way to frame the above is that we prefer to use short variables in all
cases where a (human) reader could easily infer what the variable was from its
source. For example:

```go
// NumberOfGeese might be used outside this package, or many many lines further
// down the file so it needs a descriptive name. It's also just an int, which
// doesn't give the reader much clue about what it's for.
const NumberOfGeese = 42

// w is plenty for the first argument here. Naming it gooseWrangler is redundant
// because readers can tell what it is from its type. looseGeese on the other
// hand warrants a descriptive name. It's short lived (lines wise), and its type
// doesn't give us any context about what it's for.
func capture(w goose.Wrangler, looseGeese int) error {
        // Important goose capturing logic.
        for looseGeese > 0 {
                // It's not obvious from the w.Wrangle method name what the
                // return value is, so a descriptive name names sense here too.
                captured, err := w.Wrangle()
                if err != nil {
                        return errors.Wrap(err, "defeated by geese")
                }
                looseGeese = looseGeese - captured
        }

        // We prefer 'y' to 'yard' here because 'yard' is implied by 'NewYard'.
        y := goose.NewYard(w)
        return y.Secure()
}
```

### Don't Wrap Function Signatures

Quoting again from the Go [code review comments]:

> Most of the time when people wrap lines "unnaturally" (in the middle of
> function calls or function declarations, more or less, say, though some
> exceptions are around), the wrapping would be unnecessary if they had a
> reasonable number of parameters and reasonably short variable names. Long
> lines seem to go with long names, and getting rid of the long names helps a
> lot.

```go
func capture(gooseWrangler goose.Wrangler, looseGeese int, gooseYard goose.Yard,
        duckWrangler duck.Wrangler, looseDucks, duckYard duck.Yard) error {
        // Important fowl wrangling logic.
}
```

If you find the need to wrap a function signature like the above it's almost
always a sign that your argument names are superfluously verbose, or that your
function is doing too much. If your function needs to take many optional
arguments, perhaps to enable dependency injection, use variadic functions as
options. In this case we usually make an exception for wrapped function calls.
For example:

```go
type Wrangler struct {
        fw fowl.Wrangler
        loose int
}

type Option func(w *Wrangler)

func WithFowlWrangler(fw fowl.Wrangler) Option {
        return func(w *Wrangler) {
                w.fw = fw
        }
}

func NewWrangler(looseGeese int, o ...Option) *Wrangler {
        w := &Wrangler{
                fw: fowl.DefaultWrangler{}
                loose: 
        }

        for _, fn := range o {
                fn(w)
        }

        return w
}

func example() {
        w := NewWrangler(42,
                WithFowlWrangler(chicken.NewWrangler()),
                WithSomeOtherOption(),
                WithYetAnotherOption())
        
        w.Wrangle()
}
```

You can read more about this pattern on [Dave Cheney's blog].

### Return Early

We prefer to return early. Another way to think about this is that we prefer to
handle terminal cases (e.g., errors) early. So for example instead of:

```go
func example() error {
        v := fetch()
        if v == 42 {
                // Really important business logic.
                b := embiggen(v)
                for k, v := range lookup(b) {
                        if v == true {
                                store(k)
                        } else {
                                remove(k)
                        }
                }
                return nil
        }
        return errors.New("v was a bad number")
}
```

We prefer:

```go
func example() error {
        v := fetch()
        if v != 42 {
                return errors.New("v was a bad number")
        }
        // Really important business logic.
        b := embiggen(v)
        for k, v := range lookup(b) {
                // "Continue early" is a variant of "return early".
                if v == false {
                        remove(k)
                        continue
                }
                store(k)
        }
        return nil
}
```

This approach gets error handling out of the way first, allowing the 'core' of
the function to follow at the scope of the function, not a conditional. Or put
otherwise, with the least amount of indentation.

Quoting [Effective Go]:

> In the Go libraries, you'll find that when an `if` statement doesn't flow into
> the next statement—that is, the body ends in break, continue, goto, or
> return—the unnecessary else is omitted.

### Wrap Errors

<!--
TODO(contribute): Consider error packages like
[`crossplane-runtime/pkg/errors`]
-->

Always wrap errors with context. This allows us to emit logs and events with
useful, specific errors that can be related to deeper parts of the codebase
without having to actually plumb loggers and event sources deep down into the
codebase.

For example:

```go
import "github.com/crossplane/crossplane-runtime/pkg/errors"

func example() error {
        v, err := fetch()
        if err != nil {
                return errors.Wrap(err, "could not fetch the thing")
        }

        store(embiggen(v))
        return nil
}
```

### Scope Errors

Where possible, keep errors as narrowly scoped as possible. This avoids bugs
that can appear due to 'shadowed' errors, i.e. accidental re-use of an existing
`err` variable, as code is refactored over time. Keeping errors scoped to the
error handling conditional block can help protect against this.

So for example, instead of:

```go
func example() error {
        err := enable()
        if err != nil {
                return errors.Wrap(err, "could not enable the thing")
        }

        // 'err' still exists here at the function scope.

        return errors.Wrap(emit(), "could not emit the thing")
}
```

We prefer:

```go
func example() error {
        if err := enable(); err != nil {
                // 'err' exists here inside the conditional block.
                return errors.Wrap(err, "could not enable the thing")
        }

        // 'err' does not exist here at the function scope. It's scoped to the
        // above conditional block.

        return errors.Wrap(emit(), "could not emit the thing")
}
```

Note that the 'return early' advice above trumps this rule - it's okay to
declare errors at the function scope if it lets you keep business logic less
nested.

That is, instead of:

```go
func example() error {
        if v, err := fetch(); err != nil {
                return errors.Wrap(err, "could not enable the thing")
        } else {
                store(embiggen(v))
        }
        
        return nil
}
```

We prefer:

```go
func example() error {
        v, err := fetch()
        if err != nil {
                return errors.Wrap(err, "could not enable the thing")
        }

        store(embiggen(v))
        return nil
}
```

### Prefer Table Driven Tests

As mentioned in [Contributing Code](#contributing-code), we defer to the advice
laid out in the Go project's [test review comments] documents. This means we
prefer table-driven tests.

The most common form of a test is as follows:

```go
// Example is the function we're testing.
func Example(ctx context.Context, input string) (int, error) {
        // ...
}

// Test function names are always PascalCase. No underscores.
func TestExample(t *testing.T) {
        type args struct {
                ctx   context.Context
                input string
        }

        type want struct {
                output int
                err    error
        }

        cases := map[string]struct{
                reason string
                args   args
                want   want
        }{
                // The summary is always PascalCase. No spaces, hyphens, or underscores.
                "BriefTestCaseSummary": {
                        reason: "A longer summary of what we're testing - printed if the test fails.",
                        args: args{
                                ctx: context.Background(),
                                input: "some input value",
                        }
                        want: want{
                                output: "the expected output",
                                err: nil,
                        }
                },
        }
        
        for name, tc := range cases {
                t.Run(name, func(t *testing.T) {
                        got, err := Example(tc.args.ctx, tc.args.input)

                        // We prefer to use https://github.com/google/go-cmp/
                        // even for simple comparisons to keep test output
                        // consistent.
                        if diff := cmp.Diff(tc.want.err, err, test.EquateErrors()); diff != "" {
                                t.Errorf("%s\nExample(...): -want, +got:\n%s", tc.reason, diff)
                        }

                        if diff := cmp.Diff(tc.want.output, got); diff != "" {
                                t.Errorf("%s\nExample(...): -want, +got:\n%s", tc.reason, diff)
                        }
                })
        }
}
```

## Establishing a Development Environment

<!--
TODO(contribute): Evaluate Crossplane guidance on establishing a development
environment.

The Crossplane project consists of several repositories under the crossplane and
crossplane-contrib GitHub organisations. Most of these projects use the Upbound
[build submodule]; a library of common Makefiles. Establishing a development
environment typically requires:

1. Forking and cloning the repository you wish to work on.
1. Installing development dependencies.
1. Running `make` to establish the build submodule.

Run `make help` for information on the available Make targets. Useful targets
include:

- `make reviewable` - Run code generation, linters, and unit tests.
- `make e2e` - Run end-to-end tests.
- `make` - Build Crossplane.

Once you've built Crossplane you can deploy it to a Kubernetes cluster of your
choice. [`kind`] (Kubernetes in Docker) is a good choice for development. The
`kind.sh` script contains several utilities to deploy and run a development
build of Crossplane to `kind`:

```bash
# Build Crossplane locally.
make

# See what commands are available.
./cluster/local/kind.sh help

# Start a new kind cluster. Specifying KUBE_IMAGE is optional.
KUBE_IMAGE=kindest/node:v1.23.0 ./cluster/local/kind.sh up

# Use Helm to deploy the local build of Crossplane.
./cluster/local/kind.sh helm-install

# Use Helm to upgrade the local build of Crossplane.
./cluster/local/kind.sh helm-upgrade
```

When iterating rapidly on a change it can be faster to run Crossplane as a local
process, rather than as a pod deployed by Helm to your Kubernetes cluster. Use
Helm to install your local Crossplane build per the above instructions, then:

```bash
# Stop the Helm-deployed Crossplane pod.
kubectl -n crossplane-system scale deploy crossplane --replicas=0

# Run Crossplane locally; it should connect to your kind cluster if said cluster
# is your active kubectl context. You can also go run cmd/crossplane/main.go.
make run
```
-->

Coming soon!

## Attribution

This guide was initially created from the
[`kubernetes-template-project`][template-project].

The style guide was copied from the amazing
[CONTRIBUTING.md][crossplane-contributing] created by the
[Crossplane][crossplane] project maintainers.

Copied at [this commit][crossplane-contributing-commit], with attribution to
the following Crossplane contributors:

- [negz](https://github.com/negz)
- [hasheddan](https://github.com/hasheddan)
- [jbw976](https://github.com/jbw976)
- [bassam](https://github.com/bassam)
- [alvarodelvalle](https://github.com/alvarodelvalle)
- [tv42](https://github.com/tv42)
- [ravisantoshgudimetla](https://github.com/ravisantoshgudimetla)
- [nchetan](https://github.com/nchetan)
- [muvaf](https://github.com/muvaf)

[contact]: #contact-information
[crossplane]: https://github.com/crossplane
[crossplane-contributing]: https://github.com/crossplane/crossplane/blob/master/CONTRIBUTING.md
[crossplane-contributing-commit]: https://github.com/crossplane/crossplane/blob/2c10ff0e81b83d609cfa81c3a24ce842ab234c38/CONTRIBUTING.md
[build submodule]: https://github.com/upbound/build/
[`kind`]: https://kind.sigs.k8s.io/
[kubernetes-release-cycle]: https://kubernetes.io/releases/release/
[good git commit hygiene]: https://www.futurelearn.com/info/blog/telling-stories-with-your-git-history
[Developer Certificate of Origin]: https://github.com/apps/dco
[code review comments]: https://github.com/golang/go/wiki/CodeReviewComments
[test review comments]: https://github.com/golang/go/wiki/TestComments
[Effective Go]: https://golang.org/doc/effective_go
[Dave Cheney's blog]: https://dave.cheney.net/2014/10/17/functional-options-for-friendly-apis
[`crossplane-runtime/pkg/errors`]: https://pkg.go.dev/github.com/crossplane/crossplane-runtime/pkg/errors
[golangci-lint]: https://golangci-lint.run/
[mage]: https://magefile.org/
[sig-release-subprojects]: https://git.k8s.io/community/sig-release#subprojects
[template-project]: https://git.k8s.io/kubernetes-template-project
