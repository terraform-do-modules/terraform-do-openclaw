#!/usr/bin/env bash
set -euo pipefail
HOST="${1:?server ip required}"
PORT="${2:-1389}"
ssh -p "${PORT}" -N -L 18789:127.0.0.1:18789 ubuntu@"${HOST}"
