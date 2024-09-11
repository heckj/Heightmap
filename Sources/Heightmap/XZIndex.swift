/// A two-dimensional coordinate index to a height map.
public struct XZIndex: Sendable, Hashable {
    /// The width coordinate of the index location.
    public let x: Int
    /// The depth coordinate of the index location.
    public let z: Int

    /// Creates a two-dimensional coordinate index to a height map.
    /// - Parameters:
    ///   - x: The width coordinate in the height map.
    ///   - z: The depth coordinate in the height map.
    public init(x: Int, z: Int) {
        self.x = x
        self.z = z
    }

    /// Converts a linear index position to a 2D integer coordinate.
    /// - Parameters:
    ///   - stride: The linear index location.
    ///   - width: The width of the height map.
    /// - Returns: The XZIndex that represents the location you provided.
    @inlinable
    public static func strideToXZ(_ stride: Int, width: Int) -> XZIndex {
        var z = 0
        if stride > (width - 1) {
            z = stride / width
        }
        let remaining = stride - (z * width)
        return XZIndex(x: remaining, z: z)
    }

    /// Converts an 2D integer coordinate to a linear index position.
    /// - Parameters:
    ///   - x: The width coordinate.
    ///   - z: The depth coordinate.
    ///   - width: The width of the height map.
    /// - Returns: The integer location in a flattened array.
    @inlinable
    public static func XZtoStride(x: Int, z: Int, width: Int) -> Int {
        let minorOffset = z * width
        return minorOffset + x
    }
}
