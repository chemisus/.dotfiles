CWD:=$(shell pwd)
PROFILE=$(HOME)/.bashrc
MAIN:=$(CWD)/main

default: clean main install

.PHONY: clean
clean:
	rm -f ./main

bin:
	mkdir -p ~/bin
	cp bin/* -r ~/bin

main:
	echo "source $(CWD)/files/bash_colors" > main
	echo "source $(CWD)/files/git-aliases" >> main
	echo "source $(CWD)/files/linux" >> main
	echo "source $(CWD)/files/docker-compose" >> main

php:
	sudo dnf install -y php-cli php-json

backup:
	cp $(HOME1)/.gitconfig $(HOME1)/.ssh $(HOME1)/.gnupg $(HOME1)/.mozilla ~ -r

install:
	echo "source $(MAIN)" >> $(PROFILE)
#	echo "source ~/.dotfiles/main" >> ~/.bashrc

docker:
	# rootless docker
	# https://docs.docker.com/engine/security/rootless/
	curl -fsSL https://get.docker.com/rootless | sh

pyenv:
	# https://github.com/pyenv/pyenv-installer
	# https://github.com/pyenv/pyenv/wiki/common-build-problems
	sudo dnf install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel findutils
	rm -rf ~/.pyenv
	curl -s -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	echo 'export PATH="$$HOME/.pyenv/bin:$$PATH"' >> $(MAIN)
	echo 'eval "$$(pyenv init -)"' >> $(MAIN)
	echo 'eval "$$(pyenv virtualenv-init -)"' >> $(MAIN)
	bash

nuvoapi:
	pyenv install 3.6.3
	pyenv local 3.6.3
	pip install --upgrade pip
	pip install virtualenv venv-run awscli aws-sam-cli
	python -m virtualenv -p `pyenv which python` .venv

nodejs:
	curl -L https://git.io/n-install | bash

#	venv-run --venv .venv/ 			\
#		sam							\
#			local                 	\
#			start-api             	\
#			--debug               	\
#			--profile $(PROFILE)  	\
#			--skip-pull-image     	\
#			-p $(PORT)            	\
#			--host $(HOST)        	\
#			-n environment.json
