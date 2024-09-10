@testable import Heightmap
import XCTest

final class XZIndexTests: XCTestCase {
    func test2DstrideToXY() throws {
        var result = XZIndex.strideToXZ(5, width: 4)
        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.z, 1)

        result = XZIndex.strideToXZ(4, width: 4)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.z, 1)

        result = XZIndex.strideToXZ(3, width: 4)
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.z, 0)

        result = XZIndex.strideToXZ(0, width: 4)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.z, 0)
    }

    func test2DXYToStride() throws {
        XCTAssertEqual(XZIndex.XZtoStride(x: 0, z: 0, width: 4), 0)
        XCTAssertEqual(XZIndex.XZtoStride(x: 1, z: 0, width: 4), 1)
        XCTAssertEqual(XZIndex.XZtoStride(x: 2, z: 0, width: 4), 2)
        XCTAssertEqual(XZIndex.XZtoStride(x: 3, z: 0, width: 4), 3)
        XCTAssertEqual(XZIndex.XZtoStride(x: 0, z: 1, width: 4), 4)
        XCTAssertEqual(XZIndex.XZtoStride(x: 1, z: 1, width: 4), 5)
    }

    func testHeightmapInitializer() throws {
        let h = Heightmap(_contents: [0, 0, 0, 0, 0, -1], width: 5)
        XCTAssertEqual(h.width, 5)
        XCTAssertEqual(h.height, 1)

        XCTAssertEqual(h.contents.count, 5)
    }
}
