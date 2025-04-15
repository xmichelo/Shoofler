import ArgumentParser
import Darwin
import Foundation

extension Shootool {
    /// The `blog` command struct.
    struct Blog: ParsableCommand {
        /// The configuration for the `blog` command.
        static let configuration = CommandConfiguration(
            abstract: "perform a task related to the Shoofler blog.",
            subcommands: [Publish.self]
        )
    }
}


extension Shootool.Blog {
    /// The `blog publish` sub-command struct
    struct Publish: ParsableCommand {
        /// The verbose flag.
        @Flag(name: .shortAndLong, help: "Enable verbose output.") var verbose: Bool = false
        
        /// The configuration for the `publish` sub-command.
        static let configuration = CommandConfiguration(
            abstract: "Publish the Shoofler blog to the web."
        )
        
        /// Perform the `blog publish` sub-command.
        mutating func run() throws {
            print("Performing checks.")
            try Shell.checkExecutableIsAvailable("hugo")
            let syncCommand = try Shell.getEnvironmentVariable("SHOOTOOL_BLOG_SYNC_COMMAND")
            try Shell.changeWorkingDirectory(to: "../www/blog")
            print("Generating blog.")
            _ = try Shell.execute(command: "hugo", verbose: verbose)
            print("Sync-ing blog.")
            _ = try Shell.execute(command: syncCommand, verbose: verbose)
        }
    }
}
