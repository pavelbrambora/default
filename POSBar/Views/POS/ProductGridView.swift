import SwiftUI

struct ProductGridView: View {
    let products: [Product]
    let onProductTap: (Product) -> Void

    private let columns = [
        GridItem(.adaptive(minimum: 140), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(groupedProducts.keys.sorted(), id: \ .self) { category in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(category)
                            .font(.title3.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(groupedProducts[category] ?? [], id: \ .objectID) { product in
                                Button {
                                    onProductTap(product)
                                } label: {
                                    VStack(spacing: 8) {
                                        Text(product.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.center)

                                        Text(String(format: "%.0f Kč", product.price))
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 80)
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                }
                            }
                        }
                    }
                }
            }
            .padding(20)
        }
    }

    private var groupedProducts: [String: [Product]] {
        Dictionary(grouping: products) { $0.displayCategory }
    }
}
