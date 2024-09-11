extension [Float] {
    func normalizeUnitValues(expand: Bool = false) -> Self {
        if isEmpty { return self }
        var minValue: Float = self[startIndex]
        var maxValue: Float = minValue
        for floatValue in self {
            minValue = Swift.min(minValue, floatValue)
            maxValue = Swift.max(maxValue, floatValue)
        }
        if minValue >= 0, maxValue <= 1.0, !expand {
            return self
        }
        let range: Float = maxValue - minValue
        let offset: Float = 0.0 - minValue
        return map { floatValue in
            (floatValue + offset) / range
        }
    }
}
