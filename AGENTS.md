# AI agent instructions — XGIC GitLab Dev

Public repository. Follow https://github.com/xgic/ai for multi-repo standards.

## Product

- **Role:** Producer / Dev Container repo for **`ghcr.io/xgic/xgic-gitlab`**
- **Not** the end-user template (that is [xgic/gitlab](https://github.com/xgic/gitlab))
- Production image is **not** a Dev Container and must **not** use `FROM gitlab/gitlab-ee`

## Rules


**Public GitHub writes:** Before `gh issue create|edit`, `gh pr create|edit`, or any public comment on this repository, complete the **mandatory public-safe draft gate** in https://github.com/xgic/ai/blob/main/docs/BASE-STANDARDS-FOR-ORCHESTRATED-REPOS.md (fictional placeholders only; never name private hosts, private projects, or private tracker IDs). Optional helper from the hub clone: `python scripts/public-safe-scan.py path/to/draft.md`.
- Public-safe content only (no private hosts, private tracker IDs, internal paths).
- **Configuration over hard-coding:** hosts, tokens, namespace paths, user IDs via env/config or synthetic fixtures.
- Human code review in the GitHub UI before merge to `main`.
- Dedicated issue-number branches; Conventional Commits.
- **Labels (mandatory):** Every issue and pull request gets exactly one type label in the create call: `bug`, `enhancement`, `documentation`, `standards`, or `chore`. Welcome Discussion posts use `welcome` and `documentation`. Do not put scoped GitLab labels on GitHub. https://github.com/xgic/ai/blob/main/docs/community-health.md#labels-required Default assignee **`@xgic`** unless explicitly unassigned.
- Before close: complete Markdown checklists; confirm labels and assignee.
- Python 3.14+ for new code; Apache-2.0; root `CODEOWNERS` (`@xgic`).
- No Makefiles for environment orchestration.
- **Release milestone:** titled `X.Y.Z`, matching the published version. The Git tag stays `vX.Y.Z`. Set it on every issue and pull request included in the release. GitHub does not copy the issue milestone onto the pull request. The candidate and the final publish share it. When the shipped version changes, move both to that `X.Y.Z` before the milestone closes. Close the parent issue, then the milestone, after the final publish and its acceptance. https://github.com/xgic/ai/blob/main/docs/work-tracking-and-checklists.md

## Related

- Architecture: [ADR-0001](https://github.com/xgic/ai/blob/main/docs/adr/0001-xgic-gitlab-architecture-and-repository-naming.md)
- Template: https://github.com/xgic/gitlab

