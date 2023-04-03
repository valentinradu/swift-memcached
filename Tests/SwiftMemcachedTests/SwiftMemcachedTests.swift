@testable import SwiftMemcached
import XCTest

final class SwiftMemcachedTests: XCTestCase {
    func testExample() async throws {
        // Initialization
        let url = URL(string: "localhost:2020")!
        let connection = MemcachedConnection(url: url)

        // Alternatively, with options
        // let options = MemcachedOptions(timeout: 10, retries: 3, enableCompression: true)
        // let connection = MemcachedConnection(url: url, options: options)

        // Once you have a connection, you can send commands
        let user = try await connection.perform(.get(key: "user1"))
        try await connection.perform(.set(key: "user1", value: Data()))
        try await connection.perform(.delete(key: "user1"))

        print(user!)

        // For more complex cases, and to improve performance over the wire, you can use a pipeline
        var pipeline = MemcachedPipeline()
        let profileImageTask = pipeline.enqueue(.get(key: "profile-image"))
        let backgroundImageTask = pipeline.enqueue(.get(key: "background-image"))
        let thirdUserTask = pipeline.enqueue(.get(key: "user3"))
        try await pipeline.flush(using: connection)

        // Type safe responses and full flexibility over awaiting and error handling
        let (profileImage, backgroundImage) = try await (
            profileImageTask.value,
            backgroundImageTask.value
        )
        let thirdUser = try await thirdUserTask.value

        print(profileImage!, backgroundImage!, thirdUser!)
    }
}
