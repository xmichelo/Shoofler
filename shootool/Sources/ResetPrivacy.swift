import ArgumentParser

extension Shootool {
    /// The `blog` command struct.
    struct ResetPrivacy: ParsableCommand {
        /// The configuration for the `blog` command.
        static let configuration = CommandConfiguration(
            abstract: "Reset the privacy permissions for Shoofler.",
        )
        
        /// Perform the `reset-privacy` command
        mutating func run() throws {
            print("Resetting privacy permissions for Shoofler.")
            _ = try Shell.execute(command: "tccutil reset All app.shoofler.Shoofler", verbose: true)
        }
    }
}
