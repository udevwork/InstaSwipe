import Foundation

extension BinaryFloatingPoint {
    /// Returns normalized value for the range between `a` and `b`
    /// - Parameters:
    ///   - min: minimum of the range of the measurement
    ///   - max: maximum of the range of the measurement
    ///   - a: minimum of the range of the scale
    ///   - b: minimum of the range of the scale
    func normalize(min: Self, max: Self, from a: Self = 0, to b: Self = 1) -> Self {
        (b - a) * ((self - min) / (max - min)) + a
    }
}
