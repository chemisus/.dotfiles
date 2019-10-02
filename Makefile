CWD:=$(shell pwd)
PROFILE=$(HOME)/.bashrc
MAIN:=$(CWD)/main

default: clean main install

.PHONY: clean
clean:
	rm -f ./main

main:
	echo "source $(CWD)/files/bash_colors" > main
	echo "source $(CWD)/files/git-aliases" >> main
	echo "source $(CWD)/files/linux" >> main
	echo "source $(CWD)/files/docker-compose" >> main


install:
	echo "source $(MAIN)" >> $(PROFILE)
#	echo "source ~/.dotfiles/main" >> ~/.bashrc
