public extension Heightmap {
    func normalize(expand: Bool = false) -> Self {
        let normalizedData = contents.normalizeUnitValues(expand: expand)
        return Heightmap(normalizedData, width: width)
    }

    mutating func normalized(expand: Bool = false) {
        contents = contents.normalizeUnitValues(expand: expand)
    }

    init(bytes: [UInt8], width: Int) {
        self.width = width
        height = bytes.count / width
        // make a copy of the array, truncating any extra stuff...
        let temp = bytes[0 ..< (height * width)].map { byte in
            Float(byte)
        }
        contents = temp.normalizeUnitValues()
    }
}
