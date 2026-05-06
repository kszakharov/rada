# rada

A minimal Swift CLI that runs prompts through Apple's on-device Foundation Models framework — no network, no API keys, just local inference on macOS 26+.

## Requirements

- macOS 26 or later
- Apple Silicon (Foundation Models runs on-device)

## Installation

### Build from source

```sh
git clone https://github.com/kszakharov/rada.git
cd rada
swift build -c release
cp .build/release/rada /usr/local/bin/rada
```

## Usage

Pass a prompt as an argument:

```sh
rada "What is the capital of Ukraine?"

Response:
The capital of Ukraine is Kyiv.
```

The response streams to stdout as it is generated.

## How it works

`rada` uses `SystemLanguageModel.default` from the `FoundationModels` framework — Apple's on-device LLM available on macOS 26+. No data leaves the device.

## License

MIT License - see [LICENSE](LICENSE) file for details.
