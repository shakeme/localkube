###
# Variable
##

playbook	?= site
hosts		?= hosts

.PHONY: all
all: vagrant-up provision

.PHONY: vagrant-up
vagrant-up:
	vagrant up

.PHONY: vagrant-suspend
vagrant-suspend:
	vagrant suspend

.PHONY: vagrant-resume
vagrant-resume:
	vagrant resume

.PHONY: provision
provision: provision-host provision-nodes

.PHONY: provision-host
provision-host:
	cd ansible_host && ansible-playbook --inventory-file="$(hosts)" "$(playbook).yml"

.PHONY: provision-nodes
provision-nodes:
	cd ansible_nodes && ansible-playbook --inventory-file="$(hosts)" "$(playbook).yml"


