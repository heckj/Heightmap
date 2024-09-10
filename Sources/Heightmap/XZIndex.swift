public struct XZIndex: Sendable, Hashable {
    let x: Int
    let z: Int

    public init(x: Int, z: Int) {
        self.x = x
        self.z = z
    }

    @inlinable
    static func strideToXZ(_ stride: Int, width: Int) -> XZIndex {
        var z = 0
        if stride > (width - 1) {
            z = stride / width
        }
        let remaining = stride - (z * width)
        return XZIndex(x: remaining, z: z)
    }

    @inlinable
    static func XZtoStride(x: Int, z: Int, width: Int) -> Int {
        let minorOffset = z * width
        return minorOffset + x
    }
}
