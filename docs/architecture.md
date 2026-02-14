# Architecture

```mermaid
flowchart LR
    A[Operator Laptop] -->|SSH Tunnel :1389\n-L 18789:127.0.0.1:18789| B[DO Droplet Ubuntu 24.04]
    B --> C[OpenClaw Gateway\n127.0.0.1:18789]
    B --> D[OpenClaw Control UI\n127.0.0.1:18792]
    B --> E[System Services\nUFW + Fail2ban + unattended-upgrades]
    F[Terraform infra/] --> G[DigitalOcean VPC]
    F --> B
```

## Security model

- Gateway and dashboard are loopback-bound on server.
- No direct public exposure of OpenClaw ports.
- Access path is SSH-only with local forwarding.
- Host-level controls: firewall, SSH hardening, fail2ban, patching.
