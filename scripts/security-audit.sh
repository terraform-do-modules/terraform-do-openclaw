#!/usr/bin/env bash
set -euo pipefail

echo "== OpenClaw status =="
openclaw status --deep

echo "== OpenClaw security audit =="
openclaw security audit --deep

echo "== Listening ports =="
ss -lntp

echo "== UFW =="
sudo ufw status verbose

echo "== Fail2ban =="
sudo fail2ban-client status sshd || true

echo "== Unattended upgrades =="
systemctl is-enabled unattended-upgrades || true
systemctl status unattended-upgrades --no-pager -l | sed -n '1,40p' || true
