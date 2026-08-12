# Repository settings (image producer)

Public operational notes for maintainers of
[xgic/gitlab-dev](https://github.com/xgic/gitlab-dev).

## Branch protection

`main` is protected via a repository **ruleset** (XGIC public norms):

| Rule | Intent |
|------|--------|
| No force-push / no deletion of `main` | History integrity |
| Pull request required (1 approval) | Human UI review |
| Linear history | Clean default branch |
| Required signatures | Verified commits |
| Required status check **build-image** | CI smoke for production image |

Configure under **Settings → Rules → Rulesets** (or the GitHub Rulesets API). Do not
document private bypass tokens or private inventory here.

## Releases and GHCR

| Concern | Policy |
|---------|--------|
| **GitHub Release** | Required for every final semver line (`vX.Y.Z`). Tags alone are incomplete. |
| **Automation** | On `v*` tags, [Publish GHCR](../.github/workflows/publish.yml) pushes multi-arch image tags **and** creates/updates the GitHub Release. |
| **Prereleases** | Use `vX.Y.ZrcN` (or documented prerelease pattern) with `prerelease: true` when introducing that flow. |
| **Image** | `ghcr.io/xgic/xgic-gitlab` — package page linked from the README GHCR badge. |
| **Template** | End-user Compose stack: [xgic/gitlab](https://github.com/xgic/gitlab) |

Hub context: [python-package-release.md](https://github.com/xgic/ai/blob/main/docs/python-package-release.md)
covers **PyPI** packages. Image producers follow the same **Release-required** rule;
publish path is GHCR + GitHub Release (not PyPI) unless the repo also ships a library.

## Labels

Apply PR labels consistently (`documentation`, `bug`, `enhancement`, `chore`, …).

## Related

- [AGENTS.md](../AGENTS.md)
- [CONTRIBUTING.md](../CONTRIBUTING.md)
- [CHANGELOG.md](../CHANGELOG.md)
- [xgic/ai BASE-STANDARDS](https://github.com/xgic/ai/blob/main/docs/BASE-STANDARDS-FOR-ORCHESTRATED-REPOS.md)
- [README standards (hub)](https://github.com/xgic/ai/blob/main/docs/readme-standards.md)

## Sole-developer review gate (GitHub)

GitHub does **not** allow the PR author to submit an **Approve** review on their own pull request.
When `required_approving_review_count` is `1` and the only human is the author, the UI shows
"review required" while Approve is unavailable.

**XGIC policy (same pattern as other sole-dev public producers/templates):**

| Layer | Behavior |
|-------|----------|
| **Process** | Explicit human UI **LGTM** remains mandatory before merge (comment, conversation, or session LGTM). Agents never self-merge. |
| **Ruleset** | **Protect Main** still requires a PR, linear history, signed commits, and **build-image**. |
| **Bypass** | Repository **Admin** may use the ruleset **pull_request** bypass (configured on Protect Main) so a sole maintainer can merge after LGTM when self-approval is impossible. |

Do **not** disable "require a pull request" to work around this. Prefer Admin bypass or a second reviewer account when the team grows.

Reference: payload-cms Protect Main (`bypass_actors` RepositoryRole Admin, `bypass_mode: pull_request`).
