import CocoaLumberjackSwift

struct TimestampFormatStyle: FormatStyle, Equatable, Hashable {
    let formatString: String
        
    init(formatString: String) {
        self.formatString = formatString
    }
    
    func format(_ value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        formatter.timeZone = TimeZone.current
        return formatter.string(from: value)
    }
}

extension TimestampFormatStyle: ExpressibleByStringLiteral {
    // Conforming to ExpressibleByStringLiteral allows TimestampFormatStyle
    // to be used as the associated value for an enum
    init(stringLiteral: String) {
        formatString = stringLiteral
    }
}
