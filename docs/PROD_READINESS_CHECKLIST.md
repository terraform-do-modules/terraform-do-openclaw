# Production Readiness Checklist

## Security
- [ ] SSH key-only auth enabled
- [ ] Root login disabled
- [ ] UFW deny-by-default + SSH rate limit enabled
- [ ] Fail2ban enabled for SSH
- [ ] OpenClaw gateway bind = loopback
- [ ] trustedProxies set to loopback CIDRs
- [ ] Secrets stored outside git and rotated periodically

## Reliability
- [ ] Remote Terraform state configured (`infra/backend.tf`)
- [ ] CI validate checks green on main branch
- [ ] Post-install checks pass (`./scripts/post-install-checks.sh`)
- [ ] Security audit clean (`./scripts/security-audit.sh`)
- [ ] Restore/rebuild runbook tested from scratch

## Operations
- [ ] Daily update policy defined
- [ ] Alerting/monitoring baseline configured
- [ ] SSH tunnel access documented for operators
- [ ] Incident owner and escalation path documented
