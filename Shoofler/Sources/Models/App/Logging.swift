import CocoaLumberjackSwift
import CocoaLumberjack

/// Performs the initialization of the logging system.
func setupLogging() {
    let consoleLogger = DDOSLogger.sharedInstance
    consoleLogger.logFormatter = LogFormatter(levelIndicator: .emojiThenText)
    DDLog.add(DDOSLogger.sharedInstance, with: .verbose)
    
    let fileLogger = DDFileLogger()
    fileLogger.logFormatter = LogFormatter(levelIndicator: .text)
    DDLog.add(fileLogger, with: .debug)
}

/// Custom log formatter class.
class LogFormatter: NSObject, DDLogFormatter {
    
    /// Enumeration for the level indication
    enum LevelIndicator {
        /// The level is indicated by a string.
        case text
        
        /// The level is indicated a colored circle emoji.
        case emoji
        
        /// The level is indicated by a string followed by a colored circle emoji.
        case textThenEmoji
        
        /// The level is indicated by a colored circle emoji followed by a string.
        case emojiThenText
    }
    
    private let levelIndicator: LevelIndicator

    /// Class initializer
    ///
    /// - Parameters:
    ///   - levelIndicator: the level indicator to use.
    init(levelIndicator: LevelIndicator) {
        self.levelIndicator = levelIndicator
    }
    
    /// Formats the given log message as a string.
    ///
    /// - Parameters:
    ///   - logMessage: the log message to format.
    ///
    /// - Returns: the fomatted string to displayed for the message.
    func format(message logMessage: DDLogMessage) -> String? {
        return "\(levelIndicatorStringFor(logMessage.flag)) \(logMessage.message)"
    }
    
    /// Returns the level indicator string for the given log message flag.
    ///
    /// - Parameters:
    ///   - flag: The log message flag.
    ///
    /// - Returns: a string with the level indicator.
    func levelIndicatorStringFor(_ flag: DDLogFlag) -> String {
        switch levelIndicator {
        case .text:
            return Self.textLevelIndicatorStringFor(flag)
        case .emoji:
            return Self.emojiLevelIndicatorStringFor(flag)
        case .textThenEmoji:
            return Self.textLevelIndicatorStringFor(flag) + " " + Self.emojiLevelIndicatorStringFor(flag)
        case .emojiThenText:
            return Self.emojiLevelIndicatorStringFor(flag) + " " + Self.textLevelIndicatorStringFor(flag)
        }
    }
    
    /// Returns the text level indicator string for the given log message flag.
    ///
    /// - Parameters:
    ///   - flag:The log message flag.
    ///
    /// - Returns: a string with the text level indicator.
    static func textLevelIndicatorStringFor(_ flag: DDLogFlag) -> String {
        switch flag {
        case .verbose:
            return "[VERB]"
        case .debug:   
            return "[DEBU]"
        case .info:    
            return "[INFO]"
        case .warning: 
            return "[WARN]"
        case .error:   
            return "[ERRO]"
        default: 
            return "[UNKN]"
        }
    }

    /// Returns the emoji level indicator string for the given log message flag.
    ///
    /// - Parameters:
    ///   - flag: The log message flag.
    ///
    /// - Returns: a string with the emoji level indicator.
    static func emojiLevelIndicatorStringFor(_ flag: DDLogFlag) -> String {
        switch flag {
        case .verbose:
            return "⚪"
        case .debug:
            return "🔵"
        case .info:
            return "🟢"
        case .warning:
            return "🟠"
        case .error:
            return "🔴"
        default:
            return "⚫"
        }
    }
}
