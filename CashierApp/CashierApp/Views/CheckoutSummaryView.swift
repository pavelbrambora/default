import SwiftUI
import UIKit

struct CheckoutSummaryView: View {
    let subtotal: Decimal
    let tax: Decimal
    let total: Decimal

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Mezisoučet")
                Spacer()
                Text(subtotal.formattedCurrency())
            }

            HStack {
                Text("DPH 21 %")
                Spacer()
                Text(tax.formattedCurrency())
            }

            Divider()

            HStack {
                Text("Celkem")
                    .font(.headline)
                Spacer()
                Text(total.formattedCurrency())
                    .font(.headline)
            }

            Button {
                // Placeholder action
            } label: {
                Text("Dokončit prodej")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CheckoutSummaryView(subtotal: 250, tax: 52.5, total: 302.5)
        .padding()
}
