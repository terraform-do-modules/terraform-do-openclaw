#!/usr/bin/env bash
set -euo pipefail
openclaw status --deep
openclaw doctor --non-interactive
openclaw security audit --deep
ss -lntp | grep -E '18789|18792|1389' || true
