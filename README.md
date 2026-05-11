# rada<sup>🇺🇦</sup> [![Version](https://img.shields.io/github/v/release/kszakharov/rada?label=version)](https://github.com/kszakharov/rada/releases/latest) [![Swift Version](https://img.shields.io/badge/Swift-6.2%2B-F05138?logo=swift&logoColor=white)](https://swift.org) [![macOS Version](https://img.shields.io/badge/macOS-26%20Tahoe%2B-000000?logo=apple&logoColor=white)](https://developer.apple.com/macos/) [![On-Device AI](https://img.shields.io/badge/AI-100%25%20on--device-30B27A?logo=apple&logoColor=white)](https://developer.apple.com/documentation/foundationmodels) [![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A minimal Swift CLI that runs prompts through Apple's on-device Foundation Models framework — no network, no API keys, just local inference on macOS 26+.

## Requirements

- macOS 26 or later
- Apple Silicon (Foundation Models runs on-device)

## Installation

### Build from source

```shell
git clone https://github.com/kszakharov/rada.git
cd rada
swift build -c release
cp .build/release/rada /usr/local/bin/rada
```

## Usage

`rada` supports multiple input modes:

**Argument:**
```shell
rada "What is the capital of Ukraine?"
The capital of Ukraine is Kyiv.
```

**Option:**
```shell
rada --prompt "What is the capital of Ukraine?"
The capital of Ukraine is Kyiv.
```

**Interactive (REPL):**
```shell
rada
>>> What is the capital of Ukraine?
The capital of Ukraine is Kyiv.
```

**Pipe:**
```shell
echo "What is the capital of Ukraine?" | rada
The capital of Ukraine is Kyiv.
```

The response streams to stdout as it is generated.

## How it works

`rada` uses `SystemLanguageModel.default` from the `FoundationModels` framework — Apple's on-device LLM available on macOS 26+. No data leaves the device.

## License

MIT License - see [LICENSE](LICENSE) file for details.
