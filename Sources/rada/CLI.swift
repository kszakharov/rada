import ArgumentParser
import Foundation
import FoundationModels

@main
@available(macOS 26, *)
struct CLI: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "rada",
    abstract: "CLI for Apple Foundation Models."
  )

  @Option(
    name: [.short, .long],
    help: "Prompt to send to the model."
  )
  var prompt: String?

  @Flag(
    name: .long,
    help: "Check Foundation Models availability."
  )
  var check = false

  @Flag(
    name: .long,
    help: "Print version."
  )
  var version = false

  @Argument(
    help: "Prompt passed as positional arguments."
  )
  var positional: [String] = []

  mutating func run() async throws {
    if version {
      print(appVersion)
      return
    }

    let model = SystemLanguageModel.default

    guard case .available = model.availability else {
      throw ValidationError(
        "Foundation Models not available on this device."
      )
    }

    if check {
      print("Foundation Models available.")
      return
    }

    let resolvedPrompt = try resolvePrompt()

    let session = LanguageModelSession()

    let stream = session.streamResponse(to: resolvedPrompt)

    for try await partial in stream {
      print(partial.content, terminator: "")
      fflush(stdout)
    }

    print()
  }

  private func resolvePrompt() throws -> String {
    // 1. -p / --prompt
    if let prompt, !prompt.isEmpty {
      return prompt
    }

    // 2. stdin
    if let stdin = readStdin(), !stdin.isEmpty {
      return stdin
    }

    // 3. positional args
    if !positional.isEmpty {
      return positional.joined(separator: " ")
    }

    // 4. interactive
    print(">>> ", terminator: "")
    fflush(stdout)

    let input = readLine()?
      .trimmingCharacters(in: .whitespacesAndNewlines)

    guard let input, !input.isEmpty else {
      throw ValidationError("No prompt provided.")
    }

    return input
  }

  private func readStdin() -> String? {
    guard isatty(fileno(stdin)) == 0 else {
      return nil
    }

    let data = FileHandle.standardInput.readDataToEndOfFile()

    guard !data.isEmpty else {
      return nil
    }

    return String(data: data, encoding: .utf8)?
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
