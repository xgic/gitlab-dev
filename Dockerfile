# Multi-stage build for ghcr.io/xgic/xgic-gitlab
# Production final stage only is published. Dev stages stay local/CI build helpers.
#
# Public-safe: no private hosts or production project paths.

# -----------------------------------------------------------------------------
# Base
# -----------------------------------------------------------------------------
FROM python:3.14.6-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Builder (install build-only deps if needed later)
# -----------------------------------------------------------------------------
FROM base AS builder

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --upgrade pip \
    && python -m pip install --no-cache-dir -r /tmp/requirements.txt \
    && python -m pip install --no-cache-dir --target /install -r /tmp/requirements.txt

# -----------------------------------------------------------------------------
# Production orchestration image (published to GHCR)
# -----------------------------------------------------------------------------
FROM base AS production

LABEL org.opencontainers.image.title="xgic-gitlab" \
      org.opencontainers.image.description="Production-ready XGIC orchestration runtime for GitLab Compose stacks: lightweight Python health and ops entrypoint, multi-arch GHCR delivery (ghcr.io/xgic/xgic-gitlab), and a clean companion to official GitLab EE, PostgreSQL, and Redis in the xgic/gitlab template." \
      org.opencontainers.image.url="https://github.com/xgic/gitlab-dev" \
      org.opencontainers.image.documentation="https://github.com/xgic/gitlab-dev#readme" \
      org.opencontainers.image.source="https://github.com/xgic/gitlab-dev" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.vendor="XGIC"

COPY --from=builder /install /usr/local/lib/python3.14/site-packages
COPY src/ /app/src/
COPY scripts/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh \
    && useradd --create-home --uid 10001 --shell /usr/sbin/nologin xgic \
    && chown -R xgic:xgic /app

USER xgic
WORKDIR /app

# Lightweight readiness for Compose healthchecks
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -fsS http://127.0.0.1:8080/healthz || exit 1

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
