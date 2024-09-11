public extension Heightmap {
    func normalize(expand: Bool = false) -> Self {
        let normalizedData = contents.normalizeUnitValues(expand: expand)
        return Heightmap(normalizedData, width: width)
    }

    mutating func normalized(expand: Bool = false) {
        contents = contents.normalizeUnitValues(expand: expand)
    }

    init(bytes: [UInt8], width: Int) {
        let temp = bytes.map { byte in
            Float(byte)
        }
        self.init(normalizing: temp, width: width)
    }
}
