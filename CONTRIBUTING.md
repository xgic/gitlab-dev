# Contributing

1. Open a labeled issue for the change.
2. Create a short-lived branch from `main` that includes the issue number.
3. Use Conventional Commits; keep changes public-safe.
4. Open a pull request; assign `@xgic` for active work unless the issue is explicitly unassigned.
5. Human review in the GitHub UI is required before merge to `main`.

Multi-repo standards: https://github.com/xgic/ai  
Documentation style: https://github.com/xgic/ai/blob/main/docs/documentation-style.md  
README standards: https://github.com/xgic/ai/blob/main/docs/readme-standards.md  
Maintainer settings (branch protection, releases): [docs/repository-settings.md](docs/repository-settings.md)

## Releases (image producer)

1. Land changes on `main` via reviewed PRs.
2. Update [CHANGELOG.md](CHANGELOG.md) for the version (Keep a Changelog).
3. After human LGTM for **that** release line, push an annotated tag `vX.Y.Z`.
4. [Publish GHCR](.github/workflows/publish.yml) builds multi-arch tags **and** creates the
   **GitHub Release** for `v*` tags. Do not ship a final version with only a tag or only GHCR.

