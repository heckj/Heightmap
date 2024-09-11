@testable import Heightmap
import XCTest

final class HeightmapTests: XCTestCase {
    func testHeightmapInitializer() throws {
        let h = Heightmap([0, 0, 0, 0, 0, -1], width: 5)
        XCTAssertEqual(h.width, 5)
        XCTAssertEqual(h.height, 1)

        XCTAssertEqual(h.contents.count, 5)
    }

    func testHeightmapSubscripts() throws {
        let h = Heightmap([0, 0, 0, 0, 0, -1], width: 3)
        XCTAssertEqual(h[2, 1], -1)
        XCTAssertEqual(h[XZIndex(x: 2, z: 1)], -1)
    }

    func testHeightmapSequence() throws {
        let h = Heightmap([0, 0, 0, 0, 0, -1], width: 3)
        XCTAssertEqual(h.width, 3)
        XCTAssertEqual(h.height, 2)

        XCTAssertEqual(h.contents.count, 6)
        XCTAssertEqual(h.count, 6)
        var count = 0
        for _ in h {
            count += 1
        }
        XCTAssertEqual(count, 6)
    }

    func testHeightmapCollection() throws {
        let h = Heightmap([0, 0, 0, 0, 0, -1], width: 3)
        XCTAssertEqual(h[0], 0)
    }

    func testHeightmapCollectionToArray() throws {
        let h = Heightmap([0, 0, 0, 0, 0, -1], width: 3)
        let externalize = Array(h)
        XCTAssertEqual(externalize.count, h.count)
    }
}
