all: 
	cd ./Packer/ && \
	packer validate azure_machine.pkr.hcl && \
	packer build azure_machine.pkr.hcl && \
	cd ../terraform-azure && \
	terraform init && \
	terraform validate && \
	terraform plan && \
	terraform apply --auto-approve && \
	cd .. 

pk: 
	packer inspect ./azure_machine.pkr.hcl

ted: 
	cd ./terraform-azure && \
	terraform destroy --auto-approve