import CocoaLumberjackSwift

/// Log file manager class that derives from the default one in order to customize the log file names
class LogFileManager: DDLogFileManagerDefault {
    override var newLogFileName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmssSSS"
        return "\(formatter.string(from: Date()))_Shoofler.log"
    }
    
    override func isLogFile(withName fileName: String) -> Bool {
        return fileName.hasSuffix("_Shoofler.log")
    }
}
