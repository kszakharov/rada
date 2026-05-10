.DEFAULT_GOAL := help

.PHONY: help build format lint


help:
	@echo "Available targets:"
	@echo "  build   Build the project"
	@echo "  format  Format code"
	@echo "  lint    Run linter"

build:
	swift build --configuration release

format:
	swift format format . --in-place --parallel --recursive

lint:
	swift format lint . --parallel --recursive --strict
