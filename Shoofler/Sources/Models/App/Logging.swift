import CocoaLumberjackSwift

/// Performs the initialization of the logging system.
func setupLogging() {
    let consoleLogger = DDOSLogger.sharedInstance
    consoleLogger.logFormatter = LogFormatter(levelIndicator: .emojiThenText, timestampFormat: .time)
    DDLog.add(DDOSLogger.sharedInstance, with: .verbose)
    
    let fileLogger = DDFileLogger()
    fileLogger.logFormatter = LogFormatter(levelIndicator: .text, timestampFormat: .dateTime)
    DDLog.add(fileLogger, with: .debug)
}

// MARK: - LogFormatter

/// Custom log formatter class.
class LogFormatter: NSObject, DDLogFormatter {
    private let levelIndicator: LevelIndicator
    private let timestampFormat: TimestampFormat
    
    /// Class initializer
    ///
    /// - Parameters:
    ///   - levelIndicator: the level indicator to use.
    ///   - timestampFormat: the timestamp format
    init(levelIndicator: LevelIndicator, timestampFormat: TimestampFormat) {
        self.levelIndicator = levelIndicator
        self.timestampFormat = timestampFormat
    }
    
    /// Formats the given log message as a string.
    ///
    /// - Parameters:
    ///   - logMessage: the log message to format.
    ///
    /// - Returns: the fomatted string to displayed for the message.
    func format(message logMessage: DDLogMessage) -> String? {
        return "\(levelIndicatorStringFor(logMessage.flag)) \(timestampStringFor(logMessage.timestamp)) \(logMessage.message)"
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
    
    func timestampStringFor(_ timestamp: Date) -> String {
        timestamp.formatted(timestampFormat.rawValue)
        
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

// MARK: - LevelIndicator

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

// MARK: - TimeStampFormat

/// Enumeration for the timestamp display format.
enum TimestampFormat: TimestampFormatStyle, Codable {
    /// Display only the time
    case time = "HH:mm:ss.SSS"
    
    /// Display the date and time.
    case dateTime = "yyyy-MM-dd HH:mm:ss.SSS OOOO"
}

// MARK: - TimestampFormatStyle

/// Custom formatter for the timestamp.
struct TimestampFormatStyle: FormatStyle, Equatable, Hashable {
    let formatString: String
        
    /// Initializer for the timestamp format style.
    ///
    /// - Parameters:
    ///   - formatString: The format string.
    init(formatString: String) {
        self.formatString = formatString
    }
    
    /// Format a date.
    ///
    /// - Parameters:
    ///   - value: The date to format
    ///
    /// - Returns: a string containing the formatted date.
    func format(_ value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        formatter.timeZone = TimeZone.current
        return formatter.string(from: value)
    }
}

extension TimestampFormatStyle: ExpressibleByStringLiteral {
    /// Initializer using a string literal
    ///
    /// - Parameters:
    ///   - stringLiteral: the string literal.
    init(stringLiteral: String) {
        formatString = stringLiteral
    }
}
