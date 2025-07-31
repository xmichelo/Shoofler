import CocoaLumberjackSwift

/// Custom log formatter class defines the content of a log entry.
class LogFormatter: NSObject, DDLogFormatter {
    private let levelIndicator: LevelIndicator
    private let timestampFormat: TimestampFormat
    
    init(levelIndicator: LevelIndicator, timestampFormat: TimestampFormat) {
        self.levelIndicator = levelIndicator
        self.timestampFormat = timestampFormat
    }
    
    func format(message logMessage: DDLogMessage) -> String? {
        return "\(levelIndicatorStringFor(logMessage.flag)) \(timestampStringFor(logMessage.timestamp)) \(logMessage.message)"
    }
    
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

enum LevelIndicator {
    case text // e.g. "[WARN]"
    case emoji // e.g. "🟠"
    case textThenEmoji // e.g. "[WARN] 🟠"
    case emojiThenText // e.g. "🟠 [WARN]"
}

// MARK: - TimeStampFormat

enum TimestampFormat: TimestampFormatStyle, Codable {
    case time = "HH:mm:ss.SSS"
    case dateTime = "yyyy-MM-dd HH:mm:ss.SSS OOOO"
}
