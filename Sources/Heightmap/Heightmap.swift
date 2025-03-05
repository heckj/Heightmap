/// A two-dimensional array of unit-values, used to represent a height map.
public struct Heightmap: Sendable, Hashable {
    /// The linear interior contents of the two-dimensional array.
    ///
    /// To compute an index location, use ``XZIndex/XZtoStride(x:z:width:)`` or access
    /// the contents through ``subscript(_:)-8ag3d`` or ``subscript(_:_:)``.
    public var contents: [Float]
    /// The width of the array.
    ///
    /// This typically aligns to the ``XZIndex/x`` coordinate in ``XZIndex``.
    public let width: Int
    /// The height of the array.
    ///
    /// This typically aligns to the ``XZIndex/z`` coordinate in ``XZIndex``.
    public let height: Int

    /// Creates a new height map from the collection of floating point values that you provide.
    /// - Parameters:
    ///   - contents: The array of floating point values that represents the heightmap.
    ///   - width: The width of the height map
    ///
    /// Values that extend beyond the length of a two-dimensional array are truncated.
    public init(_ contents: [Float], width: Int) {
        self.width = width
        precondition(contents.count >= width)
        height = contents.count / width
        // make a copy of the array, truncating any extra stuff...
        self.contents = Array(contents[0 ..< (height * width)])
    }

    /// Creates a new height map from the collection of floating point values that you provide.
    /// - Parameters:
    ///   - contents: The array of floating point values that represents the heightmap.
    ///   - width: The width of the height map
    ///   - depth: The depth of the height map
    ///
    /// Values that extend beyond the length of a two-dimensional array are truncated.
    public init(_ contents: [Float], width: Int, depth: Int) {
        self.width = width
        height = depth
        // make a copy of the array, truncating any extra stuff...
        precondition(contents.count >= width * height)
        self.contents = Array(contents[0 ..< (height * width)])
    }

    /// Creates a new height map normalizing the collection of floating point values that you provide to unit values.
    /// - Parameters:
    ///   - normalizing: The array of floating point values that represents the heightmap.
    ///   - width: The width of the height map
    ///
    /// The normalization process only changes the values if the collection of floating point values
    /// provided extends outside of the values 0.0 to 1.0.
    /// Values that extend beyond the length of a two-dimensional array are truncated.
    public init(normalizing: [Float], width: Int) {
        self.width = width
        height = normalizing.count / width
        // make a copy of the array, truncating any extra stuff...
        let temp = Array(normalizing[0 ..< (height * width)])
        contents = temp.normalizeUnitValues()
    }

    /// Returns the floating point value at the width and depth you provide.
    public subscript(_ x: Int, _ z: Int) -> Float {
        contents[XZIndex.XZtoStride(x: x, z: z, width: width)]
    }

    /// Returns the floating point value at the width and depth you provide.
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
