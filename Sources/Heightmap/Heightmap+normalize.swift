public extension Heightmap {
    /// Returns a height map with the values normalized to map between 0.0 and 1.0.
    /// - Parameter expand: A Boolean value that indicates that the normalization should expand values within the range 0.0 to 1.0.
    func normalize(expand: Bool = false) -> Self {
        let normalizedData = contents.normalizeUnitValues(expand: expand)
        return Heightmap(normalizedData, width: width)
    }

    /// Changes the contents of the height map to normalize the values between 0 and 1.0.
    /// - Parameter expand: A Boolean value that indicates that the normalization should expand values within the range 0.0 to 1.0.
    mutating func normalized(expand: Bool = false) {
        contents = contents.normalizeUnitValues(expand: expand)
    }

    /// Creates a new height map from the collection of bytes that you provide.
    /// - Parameters:
    ///   - bytes: The array of bytes that represents the height map.
    ///   - width: The width of the height map.
    /// Values that extend beyond the length of a two-dimensional array are truncated.
    init(bytes: [UInt8], width: Int) {
        let temp = bytes.map { byte in
            Float(byte)
        }
        self.init(normalizing: temp, width: width)
    }
}
