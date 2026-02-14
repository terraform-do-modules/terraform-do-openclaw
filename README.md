<div align="center">

# OpenClaw on DigitalOcean

**Production-ready Terraform infrastructure for deploying OpenClaw with security hardening built-in**

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Terraform CI](https://github.com/anmolnagpal/openclaw-do-platform/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/anmolnagpal/openclaw-do-platform/actions/workflows/terraform-ci.yml)
[![tflint](https://github.com/anmolnagpal/openclaw-do-platform/actions/workflows/tflint.yml/badge.svg)](https://github.com/anmolnagpal/openclaw-do-platform/actions/workflows/tflint.yml)
[![checkov](https://github.com/anmolnagpal/openclaw-do-platform/actions/workflows/checkov.yml/badge.svg)](https://github.com/anmolnagpal/openclaw-do-platform/actions/workflows/checkov.yml)

[Features](#features) •
[Quick Start](#quick-start) •
[Documentation](#project-structure) •
[Contributing](#contributing) •
[Security](#security)

</div>

---

## Features

Deploy OpenClaw on DigitalOcean with a production-focused baseline that includes infrastructure automation, security hardening, and operational best practices out of the box.

**Why use this?**
- 🚀 **Fast deployment** - Single command to provision and configure everything
- 🔒 **Secure by default** - SSH-only access, firewall rules, fail2ban, automatic updates
- 🎯 **Production-ready** - Loopback-only gateway with SSH tunnel access
- ✅ **CI/CD integrated** - Automated validation with Terraform, tflint, and checkov
- 📦 **CloudDrove powered** - Using battle-tested reusable GitHub Actions workflows

---

## Quick Start

### Prerequisites

- Terraform >= 1.5.4
- DigitalOcean account and API token
- SSH key added to DigitalOcean

### 1. Configure

```bash
# Set your DigitalOcean token
export DIGITALOCEAN_TOKEN="your_token_here"

# Copy and edit configuration
cp infra/env/prod.tfvars.example infra/env/prod.tfvars
# Edit prod.tfvars with your SSH key fingerprint and preferences
```

**Optional but recommended:** Configure remote state storage

```bash
cp infra/backend.tf.example infra/backend.tf
# Edit backend.tf with your state backend settings
```

### 2. Deploy

```bash
make up
```

This command will:
- Create a VPC and networking resources
- Provision a hardened Droplet
- Install and configure OpenClaw
- Set up security rules and monitoring

### 3. Access OpenClaw

Connect via SSH tunnel for secure access:

```bash
ssh -p 1389 -N -L 18789:127.0.0.1:18789 ubuntu@<droplet-ip>
```

Then open `http://127.0.0.1:18789` in your browser.

---

## Architecture

```
┌─────────────────────────────────────┐
│   DigitalOcean VPC (10.10.0.0/16)   │
│                                     │
│  ┌──────────────────────────────┐  │
│  │  Hardened Ubuntu Droplet     │  │
│  │                              │  │
│  │  • OpenClaw (127.0.0.1:18789)│  │
│  │  • UFW Firewall (SSH only)   │  │
│  │  • fail2ban                  │  │
│  │  • Auto-updates              │  │
│  └────────┬─────────────────────┘  │
│           │                         │
└───────────┼─────────────────────────┘
            │
            │ SSH Tunnel (Port 1389)
            │
       [Your Machine]
```

**Key design decisions:**
- OpenClaw gateway binds to localhost only (no public exposure)
- All access goes through SSH tunnel
- Firewall allows only SSH traffic
- SSH uses key-based auth only, root login disabled

See [`docs/architecture.md`](docs/architecture.md) for detailed diagrams.

---

## Project Structure

```
├── infra/              Terraform infrastructure code
│   ├── main.tf           Main infrastructure definitions
│   ├── variables.tf      Input variables
│   ├── outputs.tf        Output values
│   └── env/             Environment configurations
├── scripts/            All operational scripts
│   ├── bootstrap.sh             System hardening and OpenClaw setup
│   ├── post-install-checks.sh   Verify deployment
│   ├── security-audit.sh        Security validation
│   └── ssh-tunnel.sh            Tunnel helper
├── docs/               Documentation
│   ├── architecture.md
│   └── PROD_READINESS_CHECKLIST.md
└── .github/workflows/  CI/CD automation
```

---

## Post-Deployment Validation

After deployment, run these checks to verify everything is configured correctly:

```bash
# Verify OpenClaw is running and healthy
./scripts/post-install-checks.sh

# Run security audit
./scripts/security-audit.sh
```

**Expected results:**
- ✅ OpenClaw gateway bound to `127.0.0.1:18789`
- ✅ Firewall allows only SSH (port 1389)
- ✅ `openclaw doctor --non-interactive` passes
- ✅ `openclaw security audit --deep` shows no critical issues

---

## Security Features

This baseline includes multiple layers of security hardening:

**Network Security**
- Loopback-only OpenClaw gateway (no direct internet access)
- UFW firewall with deny-by-default policy
- SSH rate limiting to prevent brute force attacks

**SSH Hardening**
- Key-based authentication only (passwords disabled)
- Root login disabled
- Non-standard SSH port (1389)
- fail2ban monitoring for intrusion attempts

**System Hardening**
- Unattended security updates enabled
- Minimal attack surface (only required packages)
- Regular security patching workflow

> **Important:** This configuration provides a strong security baseline, but security is an ongoing process. Regularly update, audit, and monitor your deployment.

---

## Common Operations

### Plan infrastructure changes

```bash
make plan
```

### Update OpenClaw

SSH into the server and follow OpenClaw's update procedure:

```bash
ssh -p 1389 ubuntu@<droplet-ip>
# Follow OpenClaw update instructions
```

### View infrastructure state

```bash
cd infra && terraform show
```

### Destroy infrastructure

```bash
make down
```

---

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Cannot connect to dashboard | SSH tunnel not running | Re-run the SSH tunnel command and keep terminal open |
| `ERR_CONNECTION_REFUSED` | Wrong port or OpenClaw not running | Check OpenClaw status: `systemctl status openclaw` |
| Terraform validation fails | Variable type mismatch | Review `infra/variables.tf` and your `.tfvars` file |
| SSH connection refused | Wrong IP or firewall issue | Verify droplet IP with `terraform output` |

For more help, check [`docs/PROD_READINESS_CHECKLIST.md`](docs/PROD_READINESS_CHECKLIST.md).

---

## Contributing

Contributions are welcome! Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for guidelines.

When submitting PRs, include:
- Description of changes
- Reasoning and use case
- Risk assessment
- Testing/verification steps

---

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

---

## Security

We take security seriously. See [SECURITY.md](SECURITY.md) for our security policy and how to report vulnerabilities.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

---

<div align="center">

**⭐ If you find this helpful, please star the repo!**

Made with ❤️ for the OpenClaw community

</div>
