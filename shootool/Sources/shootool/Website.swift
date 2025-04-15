import ArgumentParser

extension Shootool {
    /// The `website` command struct.
    struct Website: ParsableCommand {
        /// The configuration for the `website` command.
        static let configuration = CommandConfiguration(
            abstract: "perform a task related to the Shoofler website.",
            subcommands: [Publish.self]
        )
    }
}


extension Shootool.Website {
    /// The `website publish` sub-command struct
    struct Publish: ParsableCommand {
        /// The verbose flag.
        @Flag(name: .shortAndLong, help: "Enable verbose output.") var verbose: Bool = false
        
        /// The configuration for the `publish` sub-command.
        static let configuration = CommandConfiguration(
            abstract: "Publish the Shoofler website to the web."
        )
        
        /// Perform the `website publish` sub-command.
        mutating func run() throws {
            print("Performing checks.")
            try Shell.checkExecutableIsAvailable("hugo")
            let syncCommand = try Shell.getEnvironmentVariable("SHOOTOOL_WEBSITE_SYNC_COMMAND")
            try Shell.changeWorkingDirectory(to: "../www")
            print("Sync-ing website.")
            _ = try Shell.execute(command: syncCommand, verbose: verbose)
        }
    }
}
