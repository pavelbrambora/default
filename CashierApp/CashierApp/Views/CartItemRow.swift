import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    let onDecrease: () -> Void
    let onIncrease: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name)
                    .font(.headline)
                Text("\(item.product.price.formattedCurrency()) · \(item.product.sku)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            HStack(spacing: 8) {
                Button(action: onDecrease) {
                    Image(systemName: "minus.circle")
                }

                Text("\(item.quantity)")
                    .frame(minWidth: 24)

                Button(action: onIncrease) {
                    Image(systemName: "plus.circle")
                }
            }
            .buttonStyle(.borderless)

            Text(item.lineTotal.formattedCurrency())
                .frame(width: 90, alignment: .trailing)

            Button(role: .destructive, action: onRemove) {
                Image(systemName: "trash")
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    CartItemRow(
        item: CartItem(product: Product(name: "Latté", price: 89, sku: "COF-002"), quantity: 2),
        onDecrease: {},
        onIncrease: {},
        onRemove: {}
    )
    .padding()
}
