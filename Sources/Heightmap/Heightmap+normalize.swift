public extension Heightmap {
    func normalize(expand: Bool = false) -> Self {
        if contents.isEmpty { return self }
        var minValue: Float = contents[0]
        var maxValue: Float = minValue
        for floatValue in contents {
            minValue = Swift.min(minValue, floatValue)
            maxValue = Swift.max(maxValue, floatValue)
        }
        if minValue >= 0, maxValue <= 1.0, !expand {
            return self
        }
        var normalizedData: [Float] = []
        let range: Float = maxValue - minValue
        let offset: Float = 0.0 - minValue
        for floatValue in contents {
            normalizedData.append((floatValue + offset) / range)
        }
        return Heightmap(normalizedData, width: width)
    }
}
