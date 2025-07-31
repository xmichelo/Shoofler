import CocoaLumberjackSwift

/// Log file manager class that derives from the default one in order to customize the log file names
class LogFileManager: DDLogFileManagerDefault {
    /// Gets a new log file name
    override var newLogFileName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmssSSS"
        return "\(formatter.string(from: Date()))_Shoofler.log"
    }
    
    /// Check if a file is a log file.
    ///
    /// - Parameters:
    ///   - fileName: the file name.
    ///
    /// - Returns: true if and only if the file is a log file.
    override func isLogFile(withName fileName: String) -> Bool {
        return fileName.hasSuffix("_Shoofler.log")
    }
}
