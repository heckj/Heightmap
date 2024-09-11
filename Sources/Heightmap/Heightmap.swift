public struct Heightmap: Sendable, Hashable {
    public var contents: [Float]
    public let width: Int
    public let height: Int

    public init(_ contents: [Float], width: Int) {
        self.width = width
        height = contents.count / width
        // make a copy of the array, truncating any extra stuff...
        self.contents = Array(contents[0 ..< (height * width)])
    }

    public subscript(_ x: Int, _ z: Int) -> Float {
        contents[XZIndex.XZtoStride(x: x, z: z, width: width)]
    }

    public subscript(_ xz: XZIndex) -> Float {
        contents[XZIndex.XZtoStride(x: xz.x, z: xz.z, width: width)]
    }
}

extension Heightmap: Sequence {
    public typealias Iterator = HeightmapIterator

    public func makeIterator() -> HeightmapIterator {
        HeightmapIterator(self)
    }

    public struct HeightmapIterator: IteratorProtocol {
        var position: Int
        let originalArray: Heightmap

        init(_ originalArray: Heightmap) {
            position = -1
            self.originalArray = originalArray
        }

        public mutating func next() -> Float? {
            if position < originalArray.contents.count - 1 {
                position += 1
                return originalArray.contents[position]
            }
            return nil
        }
    }
}

extension Heightmap: Collection {
    public typealias Index = Int

    public func index(after i: Int) -> Int {
        i + 1
    }

    public var startIndex: Int {
        0
    }

    public var endIndex: Int {
        contents.count
    }

    public subscript(linearindex: Int) -> Float {
        get {
            precondition(linearindex >= 0 && linearindex < contents.count)
            return contents[linearindex]
        }
        set(newValue) {
            precondition(linearindex >= 0 && linearindex < contents.count)
            contents[linearindex] = newValue
        }
    }
}

extension Heightmap: Codable {}
