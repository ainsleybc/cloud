.PHONY:
	tf-plan tf-apply tf-init tf-refresh tf-show tf-decrypt tf-encrypt
	ansible-install-roles ansible-encrypt ansible-decrypt

##
## Global
##

initialize: tf-init ansible-install-roles

encrypt: tf-encrypt ansible-encrypt

decrypt: tf-decrypt ansible-decrypt

##
## Terraform
##

tf-plan: tf-init
	cd terraform && terraform plan -out="plan.tfplan" -state=terraform.tfstate

tf-apply: tf-init
	cd terraform && terraform apply plan.tfplan

tf-init: tf-init
	cd terraform && terraform init

tf-refresh: tf-init
	cd terraform && terraform refresh

tf-show: tf-init
	cd terraform && terraform show

tf-decrypt: tf-decrypt-vars tf-decrypt-state

tf-encrypt: tf-encrypt-vars tf-encrypt-state

tf-decrypt-vars:
	cd terraform && ansible-vault decrypt --vault-id ../.secret --output terraform.tfvars terraform.tfvars.vault

tf-encrypt-vars:
	cd terraform && ansible-vault encrypt --vault-id ../.secret --output terraform.tfvars.vault terraform.tfvars

tf-decrypt-state:
	cd terraform && ansible-vault decrypt --vault-id ../.secret --output terraform.tfstate terraform.tfstate.vault

tf-encrypt-state:
	cd terraform && ansible-vault encrypt --vault-id ../.secret --output terraform.tfstate.vault terraform.tfstate

##
## Ansible
##

ansible-install-roles:
	cd ansible && ansible-galaxy install -r requirements.yml -p roles

ansible-decrypt:
	cd ansible && ansible-vault decrypt --vault-id ../.secret --output vars.yml vars.yml.vault

ansible-encrypt:
	cd ansible && ansible-vault encrypt --vault-id ../.secret --output vars.yml.vault vars.yml

ansible-webserver:
	cd ansible && ansible-playbook -i production -e @vars.yml --vault-id .secret webserver.yml
