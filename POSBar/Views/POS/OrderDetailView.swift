import SwiftUI

struct OrderDetailView: View {
    let items: [OrderItem]
    let total: Double
    @Binding var tableNumber: Int16
    let onIncrease: (OrderItem) -> Void
    let onDecrease: (OrderItem) -> Void
    let onRemove: (OrderItem) -> Void
    let onPayment: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Objednávka")
                    .font(.title2.bold())
                Spacer()
                HStack {
                    Text("Stůl")
                        .font(.subheadline)
                    TextField("0", value: $tableNumber, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .textFieldStyle(.roundedBorder)
                }
            }

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(items, id: \ .objectID) { item in
                        OrderItemRow(
                            item: item,
                            onIncrease: { onIncrease(item) },
                            onDecrease: { onDecrease(item) },
                            onRemove: { onRemove(item) }
                        )
                    }
                }
            }

            Divider()

            VStack(spacing: 12) {
                HStack {
                    Text("Celkem")
                        .font(.title3.weight(.semibold))
                    Spacer()
                    Text(String(format: "%.0f Kč", total))
                        .font(.title3.weight(.bold))
                }

                Button(action: onPayment) {
                    Text("Hotovostní platba")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(items.isEmpty)
            }
        }
        .padding(20)
    }
}

private struct OrderItemRow: View {
    let item: OrderItem
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.productName)
                    .font(.headline)
                Text(String(format: "%.0f Kč", item.product.price))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            HStack(spacing: 8) {
                Button(action: onDecrease) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title3)
                }

                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(width: 32)

                Button(action: onIncrease) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
            }
            Button(action: onRemove) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
