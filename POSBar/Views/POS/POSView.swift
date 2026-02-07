import CoreData
import SwiftUI

struct POSView: View {
    @StateObject var viewModel: OrderViewModel
    @StateObject private var catalogViewModel: ProductCatalogViewModel
    @StateObject private var paymentViewModel = PaymentViewModel()
    @State private var showPayment = false

    init(viewModel: OrderViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _catalogViewModel = StateObject(wrappedValue: ProductCatalogViewModel(context: viewModel.currentOrder.managedObjectContext!))
    }

    var body: some View {
        HStack(spacing: 0) {
            ProductGridView(products: catalogViewModel.products) { product in
                viewModel.addItem(product)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))

            OrderDetailView(
                items: viewModel.items,
                total: viewModel.total,
                tableNumber: $viewModel.tableNumber,
                onIncrease: { item in viewModel.updateQuantity(for: item, delta: 1) },
                onDecrease: { item in viewModel.updateQuantity(for: item, delta: -1) },
                onRemove: { item in viewModel.removeItem(item) },
                onPayment: { showPayment = true }
            )
            .frame(maxWidth: 420)
            .background(Color(.secondarySystemBackground))
        }
        .sheet(isPresented: $showPayment) {
            PaymentView(
                total: viewModel.total,
                viewModel: paymentViewModel,
                onPay: {
                    viewModel.finalizeCashPayment(amountReceived: paymentViewModel.amountValue)
                    paymentViewModel.reset()
                    showPayment = false
                }
            )
            .presentationDetents([.medium])
        }
    }
}

struct POSView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = CoreDataManager.preview()
        POSView(viewModel: OrderViewModel(context: manager.container.viewContext))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
