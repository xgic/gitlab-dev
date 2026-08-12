# Changelog

All notable changes to **xgic/gitlab-dev** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-08-12

### Added

- Multi-stage Dockerfile (`python:3.14.6-slim` production target) and health entrypoint.
- CI smoke check for the production image `/healthz` endpoint (build only; no push on PRs).
- GHCR publish workflow for `ghcr.io/xgic/xgic-gitlab` on `main`, tags `v*`, and
  `workflow_dispatch` (multi-arch `linux/amd64` + `linux/arm64`).
- GitHub Release creation on `v*` tags (paired with GHCR publish).
- Community health files, Dependabot for GitHub Actions, issue templates, and
  repository-settings documentation for maintainers.

[Unreleased]: https://github.com/xgic/gitlab-dev/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/xgic/gitlab-dev/releases/tag/v0.1.0
