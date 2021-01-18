#todo

.PHONY: build
build:
	docker build -t ansible -f ansible.Dockerfile .
	docker build -t terraform -f terraform.Dockerfile .

.PHONY: ansible
ansible:
	docker run --rm -v config:/home ansible-playbook