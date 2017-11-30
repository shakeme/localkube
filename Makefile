###
# Variable
##

playbook	?= site
hosts		?= hosts

.PHONY: clean
clean:
	vagrant destroy -f
	rm -rf ~/.localkube
	#ansible-host

.PHONY: clean-certs
clean-certs:
	rm -rf ~/.localkube/certs/*

.PHONY: all
all: up provision

.PHONY: up
up:
	vagrant up

.PHONY: suspend
suspend:
	vagrant suspend

.PHONY: resume
resume:
	vagrant resume

.PHONY: restart
restart:
	cd andible_nodes && ansible -i hosts controller -a "sudo reboot"

.PHONY: status
status:
	cd ansible_nodes && ansible -i hosts --become etcd -a "etcdctl --ca-file /etc/kubernetes/certs/ca.pem cluster-health"
	cd ansible_nodes && ansible -i hosts controller -a "kubectl get componentstatuses --sort-by=.metadata.name"

.PHONY: provision
provision: provision-host provision-nodes

.PHONY: provision-host
provision-host:
	cd ansible_host && ansible-playbook --inventory-file="$(hosts)" "$(playbook).yml"

.PHONY: provision-nodes
provision-nodes:
	cd ansible_nodes && ansible-playbook --inventory-file="$(hosts)" "$(playbook).yml"


