import ArgumentParser
import Foundation		


@main
struct Shootool: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Automation tool for Shoofler.",
        subcommands: [Web.self, Test.self]
    )
}


struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}

extension Shootool {
    struct Web: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "perform a web related task."
        )
        mutating func run() {
            do {
                let home = try getEnvironmentVariable("HOMO")
                print("HOME is \(home)")
                let result = try executeShell(command: "lferjkfjer")
                print(result.stdout)
            } catch let result as ShellError {
                print("Error: \(result.description)")
                Darwin.exit(result.terminationStatus)
            } catch {
                print("Error: \(error.localizedDescription)")
                Darwin.exit(-1)
            }
        }
    }
    
    struct Test: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "perform a test related task."
        )
        mutating func run() {
            do {
                let result = try executeShell(command: "efw")
                print(result.stdout)
            } catch {
                Shootool.exit(withError: error)
            }
        }
    }
}
