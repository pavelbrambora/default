import Foundation

struct CartItem: Identifiable, Hashable {
    let id = UUID()
    let product: Product
    var quantity: Int

    var lineTotal: Decimal {
        product.price * Decimal(quantity)
    }
}
