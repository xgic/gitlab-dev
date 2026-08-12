# XGIC GitLab Dev

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.14-blue?logo=python&logoColor=white)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/Docker-image-blue?logo=docker&logoColor=white)](https://docs.docker.com/)
[![GHCR](https://img.shields.io/badge/GHCR-xgic--gitlab-blue?logo=github)](https://github.com/users/xgic/packages/container/package/xgic-gitlab)
[![Release](https://img.shields.io/github/v/release/xgic/gitlab-dev)](https://github.com/xgic/gitlab-dev/releases)
[![CI](https://github.com/xgic/gitlab-dev/actions/workflows/ci.yml/badge.svg)](https://github.com/xgic/gitlab-dev/actions/workflows/ci.yml)

**Image producer** for the production XGIC GitLab orchestration image
`ghcr.io/xgic/xgic-gitlab`.

This is the **`*-dev` producer** in the dual-repo model
([ADR-0001](https://github.com/xgic/ai/blob/main/docs/adr/0001-xgic-gitlab-architecture-and-repository-naming.md)).
Day-to-day stack operation starts from the clean template:
[xgic/gitlab](https://github.com/xgic/gitlab).

Standards hub: [xgic/ai](https://github.com/xgic/ai) ·
[README standards](https://github.com/xgic/ai/blob/main/docs/readme-standards.md)

---

## Vision

Operators should run **official GitLab EE + PostgreSQL + Redis** from a clean Compose template,
while XGIC maintains a **versioned orchestration image** with reproducible multi-stage builds and
GHCR publish automation. This repository owns the **build and publish** path—not the end-user
Compose experience.

Humans and AI agents working on the **image** work here. Humans and AI agents standing up a
**GitLab stack** use [xgic/gitlab](https://github.com/xgic/gitlab).

---

## Dual-repo model

| Concern | Repository |
|---------|------------|
| Multi-stage **build**, GHCR **publish**, producer CI | **This repo** (`xgic/gitlab-dev`) |
| End-user Docker Compose **template** (GitLab EE + orchestration image) | [xgic/gitlab](https://github.com/xgic/gitlab) |
| GraphQL automation library | [xgic/gitlab-graphql](https://github.com/xgic/gitlab-graphql) |
| GitLab CLI module (`xgic gitlab …`) | [xgic/gitlab-cli](https://github.com/xgic/gitlab-cli) |

---

## Why this producer exists

| Benefit | Detail |
|---------|--------|
| **Separation of concerns** | Image build ≠ operator template |
| **Reproducible GHCR tags** | `latest`, `main`, `sha-*`, semver on `v*` tags |
| **Official vendor images in Compose** | Production image is **not** `FROM gitlab/gitlab-ee` |
| **Public-safe defaults** | No private hosts in committed examples |
| **AI-operable CI** | PR builds smoke the image; publish only from trusted branches/tags |

---

## Production image (not a Dev Container)

The published image is a **production orchestration runtime**:

- Base: official `python:3.14.6-slim`
- **No** VS Code server / Dev Container metadata in the final stage
- **No** `FROM gitlab/gitlab-ee` (application services use official vendor images in Compose)

Dev Container support may land as **contributor tooling** in this repository; it does **not** ship
as the production image.

---

## Quick start (build locally)

```bash
git clone https://github.com/xgic/gitlab-dev.git
cd gitlab-dev
docker build -t ghcr.io/xgic/xgic-gitlab:local --target production .
```

**Prefer the template for running a stack:** https://github.com/xgic/gitlab

---

## GHCR publish

| Event | Workflow | Registry push |
|-------|----------|---------------|
| Pull request | [CI](.github/workflows/ci.yml) (`build-image`) | No (build + health smoke only) |
| Push to `main` | [Publish GHCR](.github/workflows/publish.yml) (`publish-ghcr`) | Yes — `latest`, `main`, `sha-<short>` |
| Tag `v*` | Publish GHCR | Yes — semver, `latest`, `sha-<short>` |
| Manual | `workflow_dispatch` on Publish GHCR | Yes |

Image: **`ghcr.io/xgic/xgic-gitlab`** (product name; not nested under the repo path).

Auth uses the Actions `GITHUB_TOKEN` with `packages: write` (no long-lived registry PAT). After the
first successful publish, set the package visibility to **public** under GitHub Packages if pulls
should work unauthenticated.

```bash
# Reproducible release pin (recommended for templates and operators)
docker pull ghcr.io/xgic/xgic-gitlab:0.1.0

# Rolling tip of main (also published as latest after main builds)
docker pull ghcr.io/xgic/xgic-gitlab:latest
```

**Current GitHub Release:** [v0.1.0](https://github.com/xgic/gitlab-dev/releases/tag/v0.1.0)  
Package: [ghcr.io/xgic/xgic-gitlab](https://github.com/users/xgic/packages/container/package/xgic-gitlab)

Every final semver line must have a **GitHub Release** (not only a tag or GHCR push). See
[docs/repository-settings.md](docs/repository-settings.md) after the standards PR lands on `main`.

---

## AI agent guidance

- **App / stack work:** clone and operate [xgic/gitlab](https://github.com/xgic/gitlab).
- **Image / CI / Dockerfile work:** work in this producer; open PRs; do not force-push `main`.
- Keep public issue/PR text **public-safe** (fictional hosts only).

---

## Related

- Template stack: https://github.com/xgic/gitlab  
- Public standards hub: https://github.com/xgic/ai  
- Modular CLI: https://github.com/xgic/cli  

---

## License

Apache License 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE).  
Copyright form: `Copyright 2026 XGIC`.
