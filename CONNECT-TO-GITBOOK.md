# How These Docs Get Published

This repo lives in Azure DevOps, but GitBook's Git Sync only supports GitHub and
GitLab. So the docs take one extra hop:

```
Azure DevOps (asgn_swug, docs-migration branch)   <- you edit here
        |
        |  azure-pipelines.yml, on every push
        v
GitHub (BT-Software-Team/asgn_sug, main branch)   <- a mirror; do not edit
        |
        |  GitBook Git Sync
        v
GitBook site
```

Azure DevOps is the source of truth. The GitHub repo is a mirror and nothing
else.

## Editing the docs

Commit Markdown to the `docs-migration` branch in Azure DevOps. That's it — the
mirror runs automatically and GitBook picks the change up within a minute or so.

Add any new page to `SUMMARY.md`, which is what GitBook uses to build the
navigation. A page that isn't listed there won't appear on the site.

## Two things not to do

**Don't edit in the GitBook UI.** GitBook can be configured to write changes back
to GitHub, but the mirror force-pushes over `main` on every Azure commit. Anything
written from the GitBook side gets destroyed on the next push, with no warning and
nothing to recover from. The space is configured with GitHub as the source of
truth to prevent this — leave it that way.

**Don't push to the GitHub repo directly.** Same reason: the next mirror run
overwrites it.

## The GitHub repo is public

`BT-Software-Team/asgn_sug` is public, and the mirror is automatic. Anything
committed to `docs-migration` is world-readable within about a minute, with no
review step in between. Before committing, check for anything that shouldn't be:
unreleased feature descriptions, internal hostnames or IPs, customer names,
license keys pasted into a troubleshooting example.

Git history is public too, so deleting a file in a later commit does not unpublish
it.

## Pipeline setup

Already configured, recorded here in case it needs rebuilding.

1. **Variable group** — Pipelines → Library → group named `github-mirror`, holding
   `GITHUB_TOKEN` marked secret (the padlock). The token is a GitHub fine-grained
   PAT scoped to `BT-Software-Team/asgn_sug` with **Contents: read and write**.
   Nothing more is needed. Fine-grained PATs against an org repo may need an org
   owner to approve them.

2. **Pipeline** — Pipelines → New pipeline → Azure Repos Git → `asgn_swug` →
   Existing Azure Pipelines YAML file → `/azure-pipelines.yml`, on the
   `docs-migration` branch. On first run, authorize it to use the variable group.

3. **GitBook** — point Git Sync at `BT-Software-Team/asgn_sug`, branch `main`,
   with GitHub as the source of truth.

`azure-pipelines.yml` must stay on the `docs-migration` branch. Azure Pipelines
reads trigger configuration from the branch being pushed, so the same file on
`main` would never fire.

## Versioning by release

To version the docs per release, create a GitBook **Variant** (Space → version
dropdown → New Variant) mapped to a GitHub branch. Mirroring a second branch means
adding another push line to `azure-pipelines.yml` — the current pipeline mirrors
`docs-migration` only.
