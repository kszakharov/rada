.DEFAULT_GOAL := help
.PHONY: help build install uninstall format lint set-version unset-version

VERSION ?= $(shell git describe --always --tags --dirty)
VERSION_FILE = Sources/rada/Version.swift

IS_GIT_REPO := $(shell git rev-parse --is-inside-work-tree 2>/dev/null)

PREFIX ?= /usr/local
BINARY_NAME := rada


help:
	@echo "Available targets:"
	@echo "  build          Build the project"
	@echo "  install        Install the binary"
	@echo "  uninstall      Uninstall the binary"
	@echo "  format         Format code"
	@echo "  lint           Run linter"
	@echo "  set-version    Update version file with current git version"
	@echo "  unset-version  Reset version file"

build: set-version
	@trap '$(MAKE) unset-version' EXIT; \
	swift build --configuration release

install:
	install -d $(PREFIX)/bin
	install .build/release/$(BINARY_NAME) $(PREFIX)/bin/$(BINARY_NAME)

uninstall:
	rm -f $(PREFIX)/bin/$(BINARY_NAME)

format:
	swift format format . --in-place --parallel --recursive

lint:
	swift format lint . --parallel --recursive --strict

set-version:
ifeq ($(IS_GIT_REPO),true)
	@# avoid tracking changes for file:
	@git update-index --assume-unchanged $(VERSION_FILE)
endif
	@echo VERSION: $(VERSION)
	@printf 'public let appVersion = "%s"\n' "$(VERSION)" > $(VERSION_FILE)

unset-version:
ifeq ($(IS_GIT_REPO),true)
	@git update-index --no-assume-unchanged $(VERSION_FILE)
	@git restore $(VERSION_FILE)
endif
