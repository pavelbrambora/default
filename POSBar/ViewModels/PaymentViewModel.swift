import Foundation

final class PaymentViewModel: ObservableObject {
    @Published var amountReceived: String = ""

    var amountValue: Double {
        Double(amountReceived.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    func reset() {
        amountReceived = ""
    }
}
