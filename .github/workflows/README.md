# CI workflows

| Workflow | Job | Purpose |
|----------|-----|---------|
| `ci.yml` | `build-image` | PR/main validation: build production stage, smoke `/healthz` (no push) |
| `publish.yml` | `publish-ghcr` | Push `ghcr.io/xgic/xgic-gitlab` on `main`, tags `v*`, and manual dispatch |

End-user Compose template: https://github.com/xgic/gitlab
