import SwiftUI

struct ProductRow: View {
    let product: Product
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                Text("SKU: \(product.sku)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(product.price.formattedCurrency())
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button(action: onAdd) {
                Label("Přidat", systemImage: "plus.circle.fill")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProductRow(
        product: Product(name: "Cappuccino", price: 79, sku: "COF-001"),
        onAdd: {}
    )
    .padding()
}
