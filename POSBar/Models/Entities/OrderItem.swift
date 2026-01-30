import CoreData
import Foundation

@objc(OrderItem)
public final class OrderItem: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItem> {
        NSFetchRequest<OrderItem>(entityName: "OrderItem")
    }

    @NSManaged public var id: UUID
    @NSManaged public var quantity: Int16
    @NSManaged public var subtotal: Double
    @NSManaged public var order: Order
    @NSManaged public var product: Product
}

extension OrderItem {
    var productName: String {
        product.name
    }
}
