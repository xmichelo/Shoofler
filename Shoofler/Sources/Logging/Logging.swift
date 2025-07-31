import CocoaLumberjackSwift

// MARK: - Logging setup

/// Performs the initialization of the logging system.
func setupLogging() {
    // We log to the console
    let consoleLogger = DDOSLogger.sharedInstance
    consoleLogger.logFormatter = LogFormatter(levelIndicator: .emojiThenText, timestampFormat: .time)
    DDLog.add(DDOSLogger.sharedInstance, with: .verbose)
    
    // We also log to file, in the folder ~/Library/Logs/Shoofler
    let logFileManager = LogFileManager()
    logFileManager.maximumNumberOfLogFiles = 20
    logFileManager.logFilesDiskQuota = 200 * 1024 * 1024
    
    let fileLogger = DDFileLogger(logFileManager: logFileManager)
    fileLogger.doNotReuseLogFiles = true
    fileLogger.maximumFileSize = 50 * 1024 * 1024
    fileLogger.rollingFrequency = 0
    fileLogger.logFormatter = LogFormatter(levelIndicator: .text, timestampFormat: .dateTime)
    DDLog.add(fileLogger, with: .debug)
}

// MARK: - Wrappers for CocoaLumberjack calls

/// Logs a message with the verbose level.
/// - Parameters:
///   - message: the message.
@inlinable
func logVerbose(_ message: String) {
    DDLogVerbose(DDLogMessageFormat(stringLiteral: message))
}

/// Logs a message with the debug level.
/// - Parameters:
///   - message: the message.
@inlinable
func logDebug(_ message: String) {
    DDLogDebug(DDLogMessageFormat(stringLiteral: message))
}

/// Logs a message with the info level.
/// - Parameters:
///   - message: the message.
@inlinable
func logInfo(_ message: String) {
    DDLogInfo(DDLogMessageFormat(stringLiteral: message))
}

/// Logs a message with the Warn level.
/// - Parameters:
///   - message: the message.
@inlinable
func logWarn(_ message: String) {
    DDLogWarn(DDLogMessageFormat(stringLiteral: message))
}

/// Logs a message with the error level.
/// - Parameters:
///   - message: the message.
@inlinable
func logError(_ message: String) {
    DDLogError(DDLogMessageFormat(stringLiteral: message))
}
