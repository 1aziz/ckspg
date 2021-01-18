#todo
.PHONY: plan
plan:
	$(MAKE) -C infra plan

.PHONY: apply
apply:
	$(MAKE) -C infra apply

.PHONY: destroy
destroy:
	$(MAKE) -C infra destroy

.PHONY: config
config:
	docker stop ansible-playbook || true && docker rm ansible-playbook || true
	docker build -t ansible -f ansible.Dockerfile .
	docker create -it --name ansible-playbook ansible ansible-playbook playbook.yaml
	docker cp config/. ansible-playbook:/home
	docker cp /Users/aziz/.ssh/id_rsa ansible-playbook:/root/.ssh/id_rsa
	docker start -a ansible-playbook

.PHONY: kubeconfig
$(eval MASTER_IP = $(shell grep -A1 'master' config/inventory.txt | grep -v "master"))
 kubeconfig:
	rm -rf ~/.kube/config
	docker cp ansible-playbook:/home/config ~/.kube/config
	sed -i -e 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/$(MASTER_IP)/g' ~/.kube/config