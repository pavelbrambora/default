import CoreData
import Foundation

final class OrderViewModel: ObservableObject {
    @Published private(set) var currentOrder: Order
    @Published private(set) var items: [OrderItem] = []
    @Published private(set) var total: Double = 0
    @Published var tableNumber: Int16 = 0

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        self.currentOrder = Order(context: context)
        self.currentOrder.id = UUID()
        self.currentOrder.status = "open"
        self.currentOrder.timestamp = Date()
        self.currentOrder.tableNumber = 0
        self.currentOrder.total = 0
    }

    func addItem(_ product: Product) {
        let item = OrderItem(context: context)
        item.id = UUID()
        item.product = product
        item.quantity = 1
        item.subtotal = product.price
        item.order = currentOrder

        items.append(item)
        recalculateTotal()
    }

    func removeItem(_ item: OrderItem) {
        if let index = items.firstIndex(where: { $0.objectID == item.objectID }) {
            items.remove(at: index)
            context.delete(item)
            recalculateTotal()
        }
    }

    func updateQuantity(for item: OrderItem, delta: Int16) {
        let newQuantity = max(1, item.quantity + delta)
        item.quantity = newQuantity
        item.subtotal = Double(newQuantity) * item.product.price
        recalculateTotal()
    }

    func applyTableNumber() {
        currentOrder.tableNumber = tableNumber
    }

    func finalizeCashPayment(amountReceived: Double) {
        currentOrder.status = "paid"
        currentOrder.total = total
        CoreDataManager.shared.save()
        startNewOrder()
    }

    private func recalculateTotal() {
        total = items.reduce(0) { $0 + $1.subtotal }
        currentOrder.total = total
    }

    private func startNewOrder() {
        currentOrder = Order(context: context)
        currentOrder.id = UUID()
        currentOrder.status = "open"
        currentOrder.timestamp = Date()
        currentOrder.tableNumber = 0
        currentOrder.total = 0
        items = []
        total = 0
    }
}
