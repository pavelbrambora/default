import CoreData
import Foundation

final class ProductCatalogViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        loadProducts()
    }

    func loadProducts() {
        let request = Product.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Product.category, ascending: true),
            NSSortDescriptor(keyPath: \Product.name, ascending: true)
        ]

        do {
            products = try context.fetch(request)
        } catch {
            products = []
        }
    }
}
