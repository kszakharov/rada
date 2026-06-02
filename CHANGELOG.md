# Changelog

All notable changes to this project will be documented in this file.

## [0.2.2] - 2026-06-02

### Fixed

- Streaming output now prints incremental tokens instead of full accumulated content

## [0.2.1] - 2026-06-01

### Fixed

- Builds outside Git repositories (fixes Homebrew installs)

## [0.2.0] - 2026-05-31

### Added

- Homebrew installation via `brew install kszakharov/tap/rada`
- `--prompt` / `-p` option as an alternative to positional argument
- `--check` flag to verify Foundation Models availability
- `--version` flag
- Pipe/stdin support (`echo "..." | rada`)
- Interactive REPL mode (`>>>`) when no prompt is provided
- `make install` / `make uninstall` for installing the binary from source

### Fixed

- Version string now correctly derived via `git describe` in all build scenarios

## [0.1.0] - 2026-05-06

### Added

- Initial release of the CLI tool.
- Support for reading prompts from command-line arguments or standard input.
- Availability check with a clear error message when Foundation Models is unavailable.
- Availability check for on-device model support.
- Streaming responses using `LanguageModelSession`.
- Real-time output printing as tokens are received.
