import Foundation

extension Decimal {
    static func * (lhs: Decimal, rhs: Decimal) -> Decimal {
        var lhsCopy = lhs
        var rhsCopy = rhs
        var result = Decimal()
        NSDecimalMultiply(&result, &lhsCopy, &rhsCopy, .bankers)
        return result
    }

    func formattedCurrency() -> String {
        let number = NSDecimalNumber(decimal: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "CZK"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: number) ?? "Kč 0"
    }
}
