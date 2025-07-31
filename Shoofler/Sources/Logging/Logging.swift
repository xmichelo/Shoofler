import CocoaLumberjackSwift

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
