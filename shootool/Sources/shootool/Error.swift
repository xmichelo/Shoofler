import Foundation

extension Shootool {
    /// Enumeration for runtime errors
    enum RuntimeError: Error, CustomStringConvertible {
        /// Error thrown when a shell command fails.
        case shellCommandFailed(String)
        /// Error thrown when a command cannot be found.
        case commandNotFound(String)
        /// Error thrown when an environment variable is not not.
        case EnviromentVariableNotSet(String)
        
        /// The description of the error.
        public var description: String {
            switch self {
            case .shellCommandFailed(let command):
                return "The following command failed: \(command)."
            case .commandNotFound(let message):
                return "The shell command '\(message)' was not found."
            case .EnviromentVariableNotSet(let variable):
                return "The variable \(variable) is not defined."
            }
        }
    }
}
