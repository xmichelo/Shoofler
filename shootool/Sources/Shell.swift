import Foundation

struct ShellResult {
    var command: String
    var stdout: String
    var stderr: String
    var terminationStatus: Int32
}

func executeShellNoThrow(command: String) -> ShellResult {
    let process = Process()
    let stdoutPipe = Pipe()
    let stderrPipe = Pipe()
    
    process.standardOutput = stdoutPipe
    process.standardError = stderrPipe
    process.arguments = ["-c", command]
    process.launchPath = "/bin/zsh"
    
    do {
        try process.run()
        process.waitUntilExit()
    } catch {
        return ShellResult(command: command, stdout: "", stderr: error.localizedDescription, terminationStatus: -1)
    }
    
    let stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
    let stderrData = stderrPipe.fileHandleForReading.readDataToEndOfFile()
    let stdoutStr = String(data: stdoutData, encoding: .utf8) ?? ""
    let stderrStr = String(data: stderrData, encoding: .utf8) ?? ""
    return ShellResult(command: command, stdout: stdoutStr, stderr: stderrStr, terminationStatus: process.terminationStatus)
}

func executeShell(command: String) throws -> ShellResult {
    let result = executeShellNoThrow(command: command)
    if result.terminationStatus != 0 {
        throw ShellError(
            terminationStatus: result.terminationStatus,
            description: "shell command failed: \(result.command)\n\(result.stderr)"
        )
    }
    
    return result
}

func getEnvironmentVariable(_ name: String) throws -> String {
    guard let value = ProcessInfo.processInfo.environment[name] else {
        throw ShellError(
            terminationStatus: -1, description: "Environment variable \(name) is not defined.")
    }
    
    return value
}

struct ShellError: Error, CustomStringConvertible {
    let terminationStatus: Int32
    let description: String
}
