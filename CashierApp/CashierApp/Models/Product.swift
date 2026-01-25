import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Decimal
    let sku: String
}
