import Foundation

/// A namespace for shell related functions.
struct  Shell {
    /// Structure holding the result for the execution of a shell command.
    struct Result {
        /// The invoked command.
        var command: String
        /// The captured standard output.
        var stdout: String
        /// The captured standard error stream.
        var stderr: String
        /// The termination status (a.k.a. exit code) for the execution of the command.
        var terminationStatus: Int32
    }
    
    /// Execute a the given command and return the result.
    ///
    /// This function does not throw.
    ///
    /// - Parameters:
    ///     - command: The command to execute
    ///
    /// - Returns: The ``Result`` of the execution
    static func executeNoThrow(command: String) -> Shell.Result {
        let process = Process()
        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        
        process.standardOutput = stdoutPipe
        process.standardError = stderrPipe
        process.arguments = ["-c", command]
        process.launchPath = "/bin/zsh"

        var stdoutStr: String = ""
        var stderrStr: String = ""
        do {
            try process.run()
            process.waitUntilExit()
            let stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
            let stderrData = stderrPipe.fileHandleForReading.readDataToEndOfFile()
            stdoutStr = String(data: stdoutData, encoding: .utf8) ?? ""
            if !stdoutStr.isEmpty {
                print(stdoutStr)
            }
            stderrStr = String(data: stderrData, encoding: .utf8) ?? ""
            if !stderrStr.isEmpty {
                print(stderrStr)
            }
            return Shell.Result(command: command, stdout: stdoutStr, stderr: stderrStr, terminationStatus: process.terminationStatus)
        } catch {
            return Shell.Result(command: command, stdout: "", stderr: error.localizedDescription, terminationStatus: -1)
        }
        
    }
    
    /// Execute a the given command and return the result.
    ///
    /// - Parameters:
    ///  - command: The command to execute.
    ///
    /// - Returns: The ``Result`` of the execution.
    ///
    /// - Throws: `Shooltool.RuntimeError.shellCommandFailed` in case of failure.
    static func execute(command: String, verbose: Bool = false) throws -> Shell.Result {
        let result = executeNoThrow(command: command)
        if result.terminationStatus != 0 {
            throw Shootool.RuntimeError.shellCommandFailed(command)
        }
        return result
    }
    
    /// Retrieve the value of an environment variable.
    ///
    /// - Parameters:
    ///     - name: the name of the environment variable.
    ///
    /// - Returns: The value of the environment variable.
    ///
    /// - Throws: `Shootool.RuntimeError.EnviromentVariableNotSet` if the environment variable is not defined.
    static func getEnvironmentVariable(_ name: String) throws -> String {
        guard let value = ProcessInfo.processInfo.environment[name] else {
            throw Shootool.RuntimeError.EnviromentVariableNotSet(name)
        }
        
        return value
    }
    
    /// Check whether an executable is available.
    ///
    /// The implementation of this function relies on the `which` command-line tool.
    ///
    /// - Parameters:
    ///     - exe: The executable to check the availability of.
    ///
    /// - Throws: `Shootool.RuntimeError.commandNotFound` if the executable is not available.
    static func checkExecutableIsAvailable(_ exe: String) throws {
        let result = executeNoThrow(command: "which \(exe)")
        if result.terminationStatus != 0 {
            throw Shootool.RuntimeError.commandNotFound(exe)
        }
    }
    
    /// Change the current working directory
    ///
    /// - Parameters:
    ///     - path: The path of the new working directory. Relative path are supported.
    ///
    /// - Throws: `Shootool.RuntimeError.couldNotChangeWorkingDirectory` if the working directory could not be changed.
    static func changeWorkingDirectory(to path: String) throws {
        if !FileManager.default.changeCurrentDirectoryPath(path) {
            throw Shootool.RuntimeError.couldNotChangeWorkingDirectory(path)
        }
    }
}
