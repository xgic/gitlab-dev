# XGIC GitLab Dev

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.14-blue?logo=python&logoColor=white)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/Docker-image-blue?logo=docker&logoColor=white)](https://docs.docker.com/)

**Producer repository** for the production XGIC GitLab orchestration image  
`ghcr.io/xgic/xgic-gitlab`.

| Concern | Repository |
|---------|------------|
| Dev Container, multi-stage **build**, GHCR **publish** | **this repo** (`xgic/gitlab-dev`) |
| End-user Docker Compose template (official GitLab EE + orchestration image) | [xgic/gitlab](https://github.com/xgic/gitlab) |
| GitLab GraphQL automation library | [xgic/gitlab-graphql](https://github.com/xgic/gitlab-graphql) |
| XGIC GitLab CLI (ops) | [xgic/gitlab-cli](https://github.com/xgic/gitlab-cli) |

Architecture: [ADR-0001](https://github.com/xgic/ai/blob/main/docs/adr/0001-xgic-gitlab-architecture-and-repository-naming.md).  
Multi-repo standards: [xgic/ai](https://github.com/xgic/ai).

## Production image (not a Dev Container)

The published image is a **production orchestration runtime**:

- Base: official `python:3.14.6-slim`
- **No** VS Code server / Dev Container metadata in the final stage
- **No** `FROM gitlab/gitlab-ee` (application services use official vendor images in Compose)

## Quick start (build locally)

```bash
git clone https://github.com/xgic/gitlab-dev.git
cd gitlab-dev
docker build -t ghcr.io/xgic/xgic-gitlab:local --target production .
```

Dev Container support will land as contributor tooling in this repository; it does **not** ship as the production image.

## Related

- Template stack: https://github.com/xgic/gitlab  
- Public standards hub: https://github.com/xgic/ai  
