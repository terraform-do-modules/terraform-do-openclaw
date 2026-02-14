# Security Policy

## Reporting a Vulnerability

We take the security of this project seriously. If you discover a security vulnerability, please follow these steps:

### How to Report

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to: **security@clouddrove.com** (or your preferred security contact)

Include the following information in your report:

- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact
- Suggested fix (if any)

### What to Expect

1. **Acknowledgment**: We will acknowledge receipt of your report within 48 hours.
2. **Investigation**: We will investigate and validate the reported vulnerability.
3. **Updates**: We will keep you informed of our progress.
4. **Resolution**: Once resolved, we will publicly disclose the vulnerability (with credit to you, if desired).

### Supported Versions

We actively maintain security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| < 1.0   | :x:                |

## Security Best Practices

When using this project:

1. **Secrets Management**
   - Never commit secrets to the repository
   - Use environment variables or secret management tools
   - Rotate credentials regularly

2. **SSH Access**
   - Use strong SSH keys (minimum 2048-bit RSA or ED25519)
   - Disable password authentication
   - Use non-standard SSH ports where possible

3. **Infrastructure**
   - Keep Terraform and provider versions up to date
   - Review and apply security patches promptly
   - Use principle of least privilege for IAM/access controls

4. **Monitoring**
   - Enable audit logging
   - Monitor for suspicious activities
   - Set up alerts for security events

## Known Security Considerations

- OpenClaw gateway binds to localhost only by design
- SSH tunnel required for dashboard access
- Firewall configured for deny-by-default with SSH-only ingress
- No secrets are stored in this repository

## Security Features

This project includes:

- ✅ Automated security scanning (Checkov)
- ✅ Infrastructure as Code security checks
- ✅ Hardened SSH configuration
- ✅ UFW firewall with fail2ban
- ✅ Unattended security updates

## Attribution

We appreciate security researchers who responsibly disclose vulnerabilities. With your permission, we will acknowledge your contribution in our changelog and documentation.
