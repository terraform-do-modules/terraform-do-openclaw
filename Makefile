SHELL := /bin/bash

.PHONY: help init plan apply bootstrap up down destroy clean validate fmt

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

init: ## Initialize Terraform
	cd infra && terraform init

plan: ## Run Terraform plan
	cd infra && terraform plan -var-file=env/prod.tfvars

apply: ## Apply Terraform changes
	cd infra && terraform apply -var-file=env/prod.tfvars -auto-approve

bootstrap: ## Bootstrap the server
	@IP=$$(cd infra && terraform output -raw server_ip); \
	echo "Bootstrapping $$IP"; \
	scp -P 1389 scripts/bootstrap.sh ubuntu@$$IP:/tmp/bootstrap.sh; \
	ssh -p 1389 ubuntu@$$IP "chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh 1389"

up: init apply bootstrap ## Deploy everything (init + apply + bootstrap)
	@echo "Done. Tunnel command:" \
	&& echo "ssh -p 1389 -N -L 18789:127.0.0.1:18789 ubuntu@<server-ip>"

destroy: ## Destroy all infrastructure
	@echo "⚠️  WARNING: This will destroy all resources!"
	@read -p "Are you sure? (yes/no): " confirm && [ "$$confirm" = "yes" ]
	cd infra && terraform destroy -var-file=env/prod.tfvars

down: destroy ## Alias for destroy

clean: ## Clean up Terraform files
	rm -rf infra/.terraform
	rm -f infra/.terraform.lock.hcl
	rm -f infra/terraform.tfstate*

validate: ## Validate Terraform configuration
	cd infra && terraform validate

fmt: ## Format Terraform files
	cd infra && terraform fmt -recursive

check: validate ## Run all checks (validate + format check)
	cd infra && terraform fmt -check -recursive
	@echo "✅ All checks passed!"
