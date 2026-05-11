import Foundation
import FoundationModels

@main
struct CLI {
  static func main() async throws {
    // Read prompt from CLI args or stdin
    let prompt: String
    if CommandLine.arguments.count > 1 {
      prompt = CommandLine.arguments.dropFirst().joined(separator: " ")
    } else {
      print("Enter prompt: ", terminator: "")
      prompt = readLine() ?? ""
    }

    guard !prompt.isEmpty else {
      print("No prompt provided.")
      return
    }

    // Check availability
    let model = SystemLanguageModel.default
    guard case .available = model.availability else {
      print("Foundation Models not available on this device.")
      return
    }

    // Create session and stream the response
    let session = LanguageModelSession()
    print("\nResponse:")

    let stream = session.streamResponse(to: prompt)
    for try await partial in stream {
      print(partial.content, terminator: "")
      fflush(stdout)
    }
    print()  // trailing newline
  }
}
