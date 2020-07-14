import Foundation
/** 
    TODO: Break out into logging framework in different repo
    - Make it thread safe
*/

private let formatString = "MM-dd-yyyy HH:mm:ss.SSS"
enum LogLevel: Int {
    case info = 0
    case error
    case debug
    case warn
    case verbose

    var identifier: String {
        switch self {
            case .info:    return "I"
            case .debug:   return "D"
            case .warn:    return "W"
            case .verbose: return "V"
            case .error:   return "E"

        }
    }

}

enum LogSource {
    case file(URL)
    case console
}

open class Logger {
    private var _threadQueue: DispatchQueue 
    var level: LogLevel 
    var sources: [LogSource] = [LogSource]()

    internal init(label: String, level: LogLevel, sources: [LogSource] = [.console]) {
        self.level = level
        self.sources = sources
        // TODO: figure out how to set requirements on the package level, docs are not helpful....
        if #available(OSX 10.12, *) {
            self._threadQueue = DispatchQueue(label: label, qos: .default, attributes: [], autoreleaseFrequency: .workItem, target: nil)
        } else {
            self._threadQueue = DispatchQueue(label: label)
        }
    }

    var formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter
    }()

    // TODO: keep track of end of file for performance? see if performance is even an issue
    private func _log(_ s: String) {
        _threadQueue.async { [weak self] in
            self?.sources.forEach { source in 
                switch source { 
                    case .file(let fileUrl):
                        let fileMgr = FileManager.default
                        let fileOut = "\n\(s)"
                        guard let output = fileOut.data(using: .utf8) else { return }
                        do {
                            if fileMgr.fileExists(atPath: fileUrl.path) {
                                let fileHandle = try FileHandle(forUpdating: fileUrl) 
                                fileHandle.seekToEndOfFile()
                                fileHandle.write(output)
                                fileHandle.closeFile()
                            } else {
                                try s.write(to: fileUrl, atomically: false, encoding: .utf8)
                            }
                        } catch {
                            print("Failed to write to: \(fileUrl.absoluteString) - Error:\(error)")
                        }                   
                    case .console:
                        print(s)
                }
            }
        }
        
    }

    func out(_ level: LogLevel = .info, _ text: String,  fileName: String = #file, function: String =  #function, line: Int = #line) {
        if level.rawValue >= self.level.rawValue {
            let string = "[\(self.formatter.string(from:Date()))]-[\((fileName as NSString).lastPathComponent):\(line): \(function)()][\(level.identifier)]: \(text)"
            self._log(string)
        }
    }
}
