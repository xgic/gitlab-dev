#!/bin/sh
set -eu

# Minimal HTTP health endpoint for Compose; extend with orchestration CLI later.
python - <<'PY'
from http.server import BaseHTTPRequestHandler, HTTPServer


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path in ("/healthz", "/"):
            body = b"ok\n"
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, fmt, *args):
        return


HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
PY
