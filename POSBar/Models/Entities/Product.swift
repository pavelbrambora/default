import CoreData
import Foundation

@objc(Product)
public final class Product: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var price: Double
    @NSManaged public var category: String?
    @NSManaged public var isAvailable: Bool
    @NSManaged public var orderItems: Set<OrderItem>?
}

extension Product {
    var displayCategory: String {
        category ?? "General"
    }
}
