# Changelog

All notable changes to **xgic/gitlab-dev** will be documented in this file.

## [Unreleased]

### Added

- GHCR publish workflow for `ghcr.io/xgic/xgic-gitlab` on `main`, tags `v*`, and `workflow_dispatch` (multi-arch `linux/amd64` + `linux/arm64`).
- CI smoke check for the production image `/healthz` endpoint (build only; no push on PRs).

### Added (scaffold)

- Initial public scaffold: multi-stage Dockerfile (`python:3.14.6-slim` production target), health entrypoint, CI image build, community health files.
