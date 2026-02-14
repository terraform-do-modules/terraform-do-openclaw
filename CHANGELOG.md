# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial production-ready infrastructure baseline
- CloudDrove shared GitHub Actions workflows
- Comprehensive documentation
- Apache 2.0 License
- Security scanning with Checkov
- Terraform validation workflows
- Scripts for deployment and security auditing

### Changed
- Consolidated all scripts into `scripts/` directory
- Improved README with better structure and examples
- Migrated to reusable GitHub Actions workflows

### Removed
- Internal draft and SEO planning documents
- Unused logo assets
- Cost model documentation

## [1.0.0] - 2026-02-14

### Added
- Terraform infrastructure for DigitalOcean VPC and Droplet
- Bootstrap script with host hardening
- Security audit and post-install check scripts
- SSH tunnel helper script
- Production readiness checklist
- Architecture documentation
- CI/CD workflows (Terraform CI, tflint, Checkov)
- Makefile for common operations

### Security
- SSH key-only authentication
- Root login disabled
- UFW firewall with deny-by-default
- fail2ban for brute-force protection
- Unattended security updates
- Loopback-only OpenClaw gateway

[Unreleased]: https://github.com/anmolnagpal/openclaw-do-platform/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/anmolnagpal/openclaw-do-platform/releases/tag/v1.0.0
