# SMLogger

Powerful and customizable log manager for your Apps.


## Requirements

- iOS 9.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+


## Integration

#### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `SMLogger` by adding the proper description to your `Package.swift` file:

```swift
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/siginur/SMLogger.git", from: "1.5.0"),
    ]
)
```
Then run `swift build` whenever you get prepared.


## Usage

### Initialization

```swift
import SMLogger
```
You can choose between predefined types of message format and output or to create your own by implementing `LogMessageFormat` and `LogOutput` protocols.
```swift
let logger = SMLogger(strategy: .default)
```
You can also to log by a few strategies at a time, just initialize `SMLogger` with an array of strategies.
```swift
let logger = SMLogger(strategies: [.default])
```

### LogStrategy
`LogStrategy` is a class that contains message format, output strategy for logging(e.x. you can log to console, file, text stream etc.), severity level filters and other preferences. <br>
By default `SMLogger` uses `.default` strategy that configured with `TextLogMessageFormat` and `ConsoleLogOutput`.

### LogSeverity
| Severity | Tag   | Level |
|:---------|-------|:------|
| fatal    | FATAL | 1000  |
| error    | ERROR | 800   |
| warning  | WARN  | 600   |
| info     | INFO  | 400   |
| debug    | DEBUG | 200   |
| trace    | TRACE | 100   |

Each log message has it's own severity level, you can filter logs by severity level in `LogStrategy` class.
Also you can create your own log severity levels.

### LogMessageFormat
`LogMessageFormat` protocol defines a format of your log messages, like date, line number, message etc. <br>
You have 2 predefined log message formats:
- `JSONLogMessageFormat` log messages in JSON format.
- `TextLogMessageFormat` log messages as a plain text. **[default]**

You can also create your own message format by implementing `LogMessageFormat` protocol.

### LogOutput
`LogOutput` protocol defines an output destination of your log messages.
There are 5 predefined log outputs:
- `ConsoleLogOutput` prints logs to console. **[default]**
- `FileLogOutput` save logs into file (can be configured to max number of lines per file or file size).
- `StreamLogOutput` streams to `TextOutputStream`.
- `NotificationLogOutput` send your logs via `NotificationCenter`.
- `MemoryLogOutput` store logs in memory.

You can also create your own log outputs by implementing `LogOutput ` protocol.











































