#!/usr/bin/env bash
set -euo pipefail
SSH_PORT="${1:-1389}"

sudo apt update
sudo apt -y upgrade
sudo apt -y install jq ufw fail2ban curl git build-essential ca-certificates unattended-upgrades apt-listchanges

# SSH hardening (keep TCP forwarding enabled for local SSH tunnel access)
sudo sed -i "s/^#*Port .*/Port ${SSH_PORT}/" /etc/ssh/sshd_config
sudo tee /etc/ssh/sshd_config.d/99-openclaw-hardening.conf >/dev/null <<EOF
PasswordAuthentication no
KbdInteractiveAuthentication no
PermitRootLogin no
PubkeyAuthentication yes
PermitEmptyPasswords no
X11Forwarding no
MaxAuthTries 3
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2
AllowTcpForwarding yes
AllowAgentForwarding no
EOF
sudo systemctl restart ssh

# Firewall baseline
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit "${SSH_PORT}/tcp"
sudo ufw --force enable

# Fail2ban baseline for ssh
sudo tee /etc/fail2ban/jail.d/sshd-local.conf >/dev/null <<EOF
[sshd]
enabled = true
port = ${SSH_PORT}
maxretry = 5
findtime = 10m
bantime = 1h
EOF
sudo systemctl enable fail2ban --now

# Automatic security updates
sudo dpkg-reconfigure -f noninteractive unattended-upgrades

# Kernel/network hardening basics
sudo tee /etc/sysctl.d/99-openclaw-hardening.conf >/dev/null <<EOF
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_syncookies = 1
EOF
sudo sysctl --system >/dev/null

if ! command -v node >/dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
  sudo apt -y install nodejs
fi
sudo npm i -g openclaw@latest

openclaw status || true
openclaw gateway config.patch --raw '{"gateway":{"mode":"local","bind":"loopback","trustedProxies":["127.0.0.1/32","::1/128"]}}' || true
openclaw doctor --non-interactive || true

echo "Bootstrap complete"
