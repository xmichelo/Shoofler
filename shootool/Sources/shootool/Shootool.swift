import ArgumentParser
import Foundation


/// Top-level structure for the shootool command-line tool.
@main
struct Shootool: ParsableCommand {
    /// Configuration for the shootool command-line automation tool
    static let configuration = CommandConfiguration(
        abstract: "Automation tool for Shoofler.",
        subcommands: [Blog.self, Website.self]
    )
}
