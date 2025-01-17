# Release Signal One Pager

<h3>Minimum text, maximum learning.</h3>

Detailed version of this is the [Release Signal Handbook](/release-team/role-handbooks/release-signal/README.md). This is meant to be a quick
reference rather than a comprehensive guide.

Also refer to [tips and tricks of the game](/release-team/role-handbooks/release-signal/README.md#tips-and-tricks-of-the-game).

## Release Signal - Testgrid Observation Loop

```mermaid
flowchart TD
    A["Observe Testgrid"] -- Failure --> B["Create GitHub Issue using flake/failure template"]
    A -- Flake --> C["Confirm using Triage"]
    C -- Is a flake --> B
    C -- Not a flake --> A
    B --> D["Add relevant details"]
    D --> A1["Add labels: </br> #8226; Priority </br> #8226; Milestone </br> #8226; SIG Label"]
    A1 --> E["Tag @kubernetes/release-team-release-signal"]
    E --> F["Message #release-ci-signal Slack channel"]
    F --> G["Reach out to SIG on Slack"]
    G --> H["Ping SIG TLs/Chairs/Active Members"]
    H --> I["Ask if it's a blocker for upcoming release cut"]
    I -- Is a blocker --> J["Mark as blocker"]
    I -- Not a blocker --> K["Mark as non-blocker"]
    J & K --> L["Add issue with Metadata (e.g. Links, Notes, etc.) to CI Signal Board"]
    L --> A
    
    style H fill:#FFD700,color:#000000
    style I fill:#90EE90,color:#000000
    style J fill:#FF6347,color:#FFFFFF
    style K fill:#87CEFA,color:#000000

    linkStyle 0 stroke:red,stroke-width:2px;
    linkStyle 1,2 stroke:purple,stroke-width:2px;

    classDef important fill:#FF9999,stroke:#333,stroke-width:2px,color:#000000;
    class N important
```

## Release Signal - Go or No-Go

Go or No-Go signal with diagrams and steps can be found [here](/release-team/role-handbooks/release-signal/README.md#release-cutting---go-or-no-go). 

## Release Signal - Following up on issues/PRs in milestone

```mermaid
sequenceDiagram
    participant RS as Release Signal Team
    participant IO as Issue/PR Owners
    Note over RS, IO: Release Cycle Starts
    RS ->> IO: Send Code Freeze Reminder (1 month+ before)
    Note over IO: Review issues/PRs
    RS ->> IO: Send Code Freeze Reminder (1.5 weeks before)
    Note over IO: Finalize issues/PRs
    Note over RS, IO: Code Freeze Deadline
    RS ->> IO: Help merge PRs
    Note over IO: Submit exception requests
    Note over RS, IO: Post Code Freeze
    Note over RS: Remove non-release issues/PRs from milestone <br> (Except those with approved exception requests)

    par Monitor Post-Freeze Changes
        Note over RS: Monitor bug fixes, regressions, and <br> important PRs added after code freeze
    and Continue Release Process
        Note over RS: Remove issues/PRs that could not be completed <br> even after additional exception request time
    end

    Note over RS, IO: Release Cycle Ends
```
