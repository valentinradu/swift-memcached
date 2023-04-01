import Foundation

/// Errors related to the session.
public enum MemcachedConnectionError: Error {
    /// The unstructured data received from the server is could not be decoded.
    /// This usually happens when trying to fetch the wrong type for a key.
    case failedToDecodeUnstructuredDataForKey(String)
    // TODO: Add other errors related to the session here
}

/// Options can be set per session and later overriden per command.
public struct MemcachedOptions {
    /// The amount of time before timeouting a command.
    public let timeout: TimeInterval
    /// The number of retries before failing a command.
    public let retries: TimeInterval
    /// Enables compression.
    public let enableCompression: Bool
}

/// The `MemcachedConnection` manages the connection with a single server and sends commands to it.
public actor MemcachedConnection {
    /// Initializes the session from a server URL.
    /// - Note: The initializer itself **does not** connect to the server.
    /// We lazily connect to the server during the first request we make.
    /// - Parameters:
    ///   - url: The server URL
    ///   - options: Session-wide options, can be overriden if needed. If not provided, we use defaults.
    public init(url: URL, options: MemcachedOptions? = nil) {
        // TODO: Implement this
        fatalError()
    }

    /// Checks if the server is currently reachable by sending a `noop` command.
    /// Can also be used in a keep-alive mechanism, where recovery is handled by the consumer.
    /// - Throws: Throws if the server is not reachable
    public func checkIfServerIsReachable() async throws {
        // TODO: Implement this
        fatalError()
    }

    /// Performs a single command right away.
    /// It sends the package over the wire and waits for a response.
    /// - Parameter command: The command to perform
    /// - Returns: The result of the command. Discardable.
    @discardableResult
    public func perform<Result>(_ command: MemcachedCommand<Result>) async throws -> Result {
        // TODO: Implement this
        fatalError()
    }
}

/// The pipeline allows sending multiple commands in one batch.
public struct MemcachedPipeline {
    /// Enqueues a command on the pipeline
    /// - Parameter command: The command to enqueue
    /// - Returns: The enqueued command
    public mutating func enqueue<Result>(_ command: MemcachedCommand<Result>) -> MemcachedCommand<Result> {
        fatalError()
    }

    /// Flushes the pipeline and sends all commands to the server.
    /// - Parameter session: The session used to connect to the server
    /// - Throws: It can throw if the commands sending failed. Will not wait for the response and **will not throw** if the response fail.
    public func flush(using session: MemcachedConnection) async throws {}
}

/// A server command.
public actor MemcachedCommand<Result> {
    fileprivate func perform(using: MemcachedConnection) async throws -> Result {
        fatalError()
    }

    /// Awaits for the command's result.
    /// - Returns: The result
    /// - Throws: Can throw when the command failed
    public func result() async throws -> Result {
        // TODO: Implement this
        fatalError()
    }
}

public extension MemcachedCommand {
    /// Fetch a value by key
    /// - Parameters:
    ///   - key: The key
    ///   - options: Overrides the session options per command
    ///   - of: The expected type of the stored value
    /// - Returns: A `MemcachedCommand` command
    static func get<Value>(key: String, of: Value.Type,
                           options: MemcachedOptions? = nil) -> MemcachedCommand<Value?>
        where Value: Codable {
        // TODO: Implement this
        fatalError()
    }

    /// Set a value by key
    /// - Parameters:
    ///   - key: The key
    ///   - options: Overrides the session options per command
    ///   - value: The value
    /// - Returns: A `MemcachedCommand` command
    static func set<Value>(key: String, value: Value,
                           options: MemcachedOptions? = nil) -> MemcachedCommand<Void>
        where Value: Codable {
        // TODO: Implement this
        fatalError()
    }

    /// Delete a value by key
    /// - Parameters:
    ///   - key: The key
    ///   - options: Overrides the session options per command
    /// - Returns: A `MemcachedCommand` command
    static func delete(key: String,
                       options: MemcachedOptions? = nil) -> MemcachedCommand<Bool> {
        // TODO: Implement this
        fatalError()
    }
}