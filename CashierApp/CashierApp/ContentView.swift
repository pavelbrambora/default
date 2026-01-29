import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var cartItems: [CartItem] = []

    private let products: [Product] = [
        Product(name: "Espresso", price: 59, sku: "COF-001"),
        Product(name: "Cappuccino", price: 79, sku: "COF-002"),
        Product(name: "Latté", price: 89, sku: "COF-003"),
        Product(name: "Croissant", price: 45, sku: "BAK-004"),
        Product(name: "Limonáda", price: 55, sku: "DRI-005"),
        Product(name: "Sendvič", price: 119, sku: "FOO-006")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Vyhledat položku nebo SKU", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nabídka")
                            .font(.title2.bold())

                        List(filteredProducts) { product in
                            ProductRow(product: product) {
                                addProduct(product)
                            }
                        }
                        .listStyle(.plain)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Košík")
                            .font(.title2.bold())

                        if cartItems.isEmpty {
                            ContentUnavailableView("Košík je prázdný", systemImage: "cart")
                        } else {
                            List {
                                ForEach(cartItems) { item in
                                    CartItemRow(
                                        item: item,
                                        onDecrease: { decrementItem(item) },
                                        onIncrease: { incrementItem(item) },
                                        onRemove: { removeItem(item) }
                                    )
                                }
                            }
                            .listStyle(.plain)
                        }

                        CheckoutSummaryView(
                            subtotal: subtotal,
                            tax: tax,
                            total: total
                        )
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Pokladna")
        }
    }

    private var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return products }
        return products.filter { product in
            product.name.localizedCaseInsensitiveContains(searchText)
                || product.sku.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var subtotal: Decimal {
        cartItems.reduce(0) { $0 + $1.lineTotal }
    }

    private var tax: Decimal {
        subtotal * Decimal(0.21)
    }

    private var total: Decimal {
        subtotal + tax
    }

    private func addProduct(_ product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product == product }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }

    private func incrementItem(_ item: CartItem) {
        guard let index = cartItems.firstIndex(of: item) else { return }
        cartItems[index].quantity += 1
    }

    private func decrementItem(_ item: CartItem) {
        guard let index = cartItems.firstIndex(of: item) else { return }
        cartItems[index].quantity -= 1
        if cartItems[index].quantity <= 0 {
            cartItems.remove(at: index)
        }
    }

    private func removeItem(_ item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }
}

#Preview {
    ContentView()
}
