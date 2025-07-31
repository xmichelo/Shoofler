import CocoaLumberjackSwift

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
