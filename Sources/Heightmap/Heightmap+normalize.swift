public extension Heightmap {
    static func normalize(_ contents: [Float], expand: Bool = false) -> [Float] {
        if contents.isEmpty { return contents }
        var minValue: Float = contents[0]
        var maxValue: Float = minValue
        for floatValue in contents {
            minValue = Swift.min(minValue, floatValue)
            maxValue = Swift.max(maxValue, floatValue)
        }
        if minValue >= 0, maxValue <= 1.0, !expand {
            return contents
        }
        var normalizedData: [Float] = []
        let range: Float = maxValue - minValue
        let offset: Float = 0.0 - minValue
        for floatValue in contents {
            normalizedData.append((floatValue + offset) / range)
        }
        return normalizedData
    }

    func normalize(expand: Bool = false) -> Self {
        let normalizedData = Self.normalize(contents, expand: expand)
        return Heightmap(normalizedData, width: width)
    }

    mutating func normalized(expand: Bool = false) {
        contents = Self.normalize(contents, expand: expand)
    }

    init(bytes: [UInt8], width: Int) {
        self.width = width
        height = bytes.count / width
        // make a copy of the array, truncating any extra stuff...
        let temp = bytes[0 ..< (height * width)].map { byte in
            Float(byte)
        }
        contents = Self.normalize(temp)
    }
}
