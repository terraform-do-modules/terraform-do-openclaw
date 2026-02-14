# Contributing to OpenClaw on DigitalOcean

Thanks for contributing!

## Quick Guidelines

1. **Open an issue first** for large changes
2. **Keep changes scoped** and production-safe
3. **Test thoroughly** before submitting
4. **Update documentation** as needed
5. **No secrets** in commits

## For Infrastructure Changes

Include in your PR:
- **Risk level**: Low/Medium/High and why
- **Rollback plan**: How to revert if needed
- **Validation**: Output from terraform plan/validate

## Pull Request Checklist

- [ ] Code follows the style guidelines
- [ ] `terraform fmt -check -recursive` passes
- [ ] `terraform validate` passes
- [ ] CI checks (tflint/checkov) pass
- [ ] Documentation updated
- [ ] Commit messages follow conventional commits

## Commit Message Format

Use conventional commits:

```
type(scope): subject

Examples:
feat(infra): add support for custom SSH port
fix(scripts): resolve bootstrap permission issue
docs(readme): update deployment instructions
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

## Development Setup

```bash
# Clone and setup
git clone https://github.com/anmolnagpal/openclaw-do-platform.git
cd openclaw-do-platform

# Configure DigitalOcean
export DIGITALOCEAN_TOKEN="your_token"

# Test locally
cd infra
terraform init -backend=false
terraform validate
terraform fmt -check -recursive
```

## Testing Changes

```bash
# Validate terraform
make plan

# Run security audit (in safe environment)
./scripts/security-audit.sh

# Test bootstrap (use test droplet)
./scripts/bootstrap.sh 1389
```

## Style Guidelines

### Terraform
- 2 spaces indentation
- Run `terraform fmt` before committing
- Use descriptive variable names
- Comment complex logic

### Shell Scripts
- Use `#!/usr/bin/env bash`
- Include error handling (`set -e`)
- Add comments for clarity
- Validate with shellcheck

### Documentation
- Clear, concise language
- Include code examples
- Keep lines under 100 characters
- Proper markdown formatting

## Getting Help

- **Questions?** Open an issue with `question` label
- **Security issues?** See [SECURITY.md](SECURITY.md)
- **Discussions** Use GitHub Discussions

## Recognition

Contributors are recognized in:
- Project README
- Release notes
- CHANGELOG

Thank you! 🚀
