import ArgumentParser
import Darwin

extension Shootool {
    /// The `blog` command struct.
    struct Blog: ParsableCommand {
        /// The configuration for the publish command.
        static let configuration = CommandConfiguration(
            abstract: "perform a task related to the Shoofler blog.",
            subcommands: [Publish.self]
        )
    }
}


extension Shootool.Blog {
    /// The `blog publish` sub-command struct
    struct Publish: ParsableCommand {
        /// The configuration for the `publish` sub-command.
        static let configuration = CommandConfiguration(
            abstract: "Publish the Shoofler blog to the web"
        )
        
        /// Perform the `blog publish` sub-command.
        mutating func run() throws {
            try Shell.checkExecutableIsAvailable("find")
            try Shell.checkExecutableIsAvailable("rsync")
            try Shell.checkExecutableIsAvailable("hugo")
            try _ = Shell.getEnvironmentVariable("SHOOTOOL_RSYNC_REMOTE")
        }
    }
}
