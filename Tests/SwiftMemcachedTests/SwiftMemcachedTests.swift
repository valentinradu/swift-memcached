@testable import SwiftMemcached
import XCTest

private struct User: Codable {}
private struct Image: Codable {}

final class SwiftMemcachedTests: XCTestCase {
    func testExample() async throws {
        // Initialization
        let url = URL(string: "localhost:2020")!
        let session = MemcachedConnection(url: url)

        // Alternatively, with options
        // let options = MemcachedOptions(timeout: 10, retries: 3, enableCompression: true)
        // let session = MemcachedConnection(url: url, options: options)

        // Once you have the a connection, you can send commands
        let user = try await session.perform(.get(key: "user1", of: User.self))
        try await session.perform(.set(key: "user1", value: user))
        try await session.perform(.delete(key: "user1"))

        // For more complex cases, and to improve performance over the wire, you can use a pipeline
        var pipeline = MemcachedPipeline()
        let profileImageCommand = pipeline.enqueue(.get(key: "profile-image", of: Image.self))
        let backgroundImageCommand = pipeline.enqueue(.get(key: "background-image", of: Image.self))
        let thirdUserCommand = pipeline.enqueue(.get(key: "user3", of: User.self))
        try await pipeline.flush(using: session)

        // Type safe responses and full flexibility over awaiting and error handling
        let (profileImage, backgroundImage) = try await (
            profileImageCommand.result(),
            backgroundImageCommand.result()
        )
        let thirdUser = try await thirdUserCommand.result()

        print(profileImage!, backgroundImage!, thirdUser!)
    }
}
