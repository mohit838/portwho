SHELL := /usr/bin/env bash

.PHONY: all test install uninstall install-system uninstall-system docs-dev docs-build deb

all:
	@true

test:
	bash tests/test_portwho.sh

install:
	./install.sh

uninstall:
	./uninstall.sh

install-system:
	sudo ./install.sh --system

uninstall-system:
	sudo ./uninstall.sh --system

docs-dev:
	cd docs && npm install && npm run dev

docs-build:
	cd docs && npm install && npm run build

deb:
	dpkg-buildpackage -us -uc -b
