"""Health helpers for the orchestration container."""


def status() -> str:
    """Return a simple readiness string."""
    return "ok"
