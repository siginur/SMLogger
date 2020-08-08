import Foundation

public class ASLogger {
    
    static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return f
    }()
    
    let identifier: String
    
    public init(_ `class`: AnyClass) {
        identifier = String(describing: `class`.self)
    }
    
    public init(_ fileName: String = #file) {
        identifier = fileName
    }
    
    public func error(_ message: String, functionName: String = #function, line: Int = #line) {
        log(.error, message: message, functionName: functionName, line: line)
    }
    
    public func warning(_ message: String, functionName: String = #function, line: Int = #line) {
        log(.warning, message: message, functionName: functionName, line: line)
    }
    
    public func info(_ message: String, functionName: String = #function, line: Int = #line) {
        log(.info, message: message, functionName: functionName, line: line)
    }
    
    public func debug(_ message: String, functionName: String = #function, line: Int = #line) {
        log(.debug, message: message, functionName: functionName, line: line)
    }
    
    public func log(_ level: Level, message: String, functionName: String = #function, line: Int = #line) {
        print("[\(level.rawValue.uppercased())] \(Self.formatter.string(from: Date())) \(identifier):\(line) \(functionName). \(message)")
    }
    
}

public extension ASLogger {
    enum Level: String {
        case error
        case warning
        case info
        case debug
    }
}
