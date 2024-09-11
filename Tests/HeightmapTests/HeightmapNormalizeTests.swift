import Heightmap
import XCTest

final class HeightmapNormalizeTests: XCTestCase {
    func testNormalizeUnitValuesAlreadyUnit() throws {
        let data: [Float] = [0.2, 0.2, 0.4, 0.8, 0.4, 1.0]
        let h = Heightmap(data, width: 3)
        // default should be no change when data is already within 0.0...1.0
        XCTAssertEqual(data, h.normalize().contents)
    }

    func testExpandWithinNormalizeUnitValues() throws {
        let data: [Float] = [0.2, 0.2, 0.4, 0.8, 0.4, 1.0]
        let h = Heightmap(data, width: 3)
        // default should be no change when data is already within 0.0...1.0
        let expected: [Float] = [0.0, 0.0, 0.25, 0.75, 0.25, 1.0]
        let converted = h.normalize(expand: true).contents
        for i in 0 ..< data.count {
            XCTAssertEqual(converted[i], expected[i], accuracy: 0.01)
        }
    }

    func testNormalizeToUnitValues() throws {
        let data: [Float] = [-1, -0.5, 0, 0.5, 0.5, 1.0]
        let h = Heightmap(data, width: 3)
        // default should be no change when data is already within 0.0...1.0
        let expected: [Float] = [0.0, 0.25, 0.5, 0.75, 0.75, 1.0]
        let converted = h.normalize().contents
        for i in 0 ..< data.count {
            XCTAssertEqual(converted[i], expected[i], accuracy: 0.01)
        }
    }

    func testNormalizeToUnitValuesHighEndExtended() throws {
        let data: [Float] = [0.0, 0.5, 1, 1.5, 1.5, 2.0]
        let h = Heightmap(data, width: 3)
        // default should be no change when data is already within 0.0...1.0
        let expected: [Float] = [0.0, 0.25, 0.5, 0.75, 0.75, 1.0]
        let converted = h.normalize().contents
        for i in 0 ..< data.count {
            XCTAssertEqual(converted[i], expected[i], accuracy: 0.01)
        }
    }

    func testNormalizeToUnitValuesHighAndLowExtended() throws {
        let data: [Float] = [-2.0, -1, 0, 1, 1, 2.0]
        let h = Heightmap(data, width: 3)
        // default should be no change when data is already within 0.0...1.0
        let expected: [Float] = [0.0, 0.25, 0.5, 0.75, 0.75, 1.0]
        let converted = h.normalize().contents
        for i in 0 ..< data.count {
            XCTAssertEqual(converted[i], expected[i], accuracy: 0.01)
        }
    }
}
