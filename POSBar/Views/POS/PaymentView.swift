import SwiftUI

struct PaymentView: View {
    let total: Double
    @ObservedObject var viewModel: PaymentViewModel
    let onPay: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Hotovostní platba")
                .font(.title2.bold())

            VStack(spacing: 8) {
                Text("Celkem k úhradě")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(String(format: "%.0f Kč", total))
                    .font(.largeTitle.weight(.bold))
            }

            TextField("Přijatá částka", text: $viewModel.amountReceived)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)

            HStack(spacing: 12) {
                QuickAmountButton(title: "100", action: { viewModel.amountReceived = "100" })
                QuickAmountButton(title: "200", action: { viewModel.amountReceived = "200" })
                QuickAmountButton(title: "500", action: { viewModel.amountReceived = "500" })
            }

            Button(action: onPay) {
                Text("Zaplaceno hotově")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(viewModel.amountValue < total || total == 0)

            if viewModel.amountValue >= total {
                Text("Vrácení: \(String(format: "%.0f Kč", viewModel.amountValue - total))")
                    .font(.headline)
                    .foregroundColor(.green)
            }
        }
        .padding(24)
    }
}

private struct QuickAmountButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("+\(title)")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(.systemGray5))
                .cornerRadius(8)
        }
    }
}
