import CoreData
import Foundation

@objc(Order)
public final class Order: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: UUID
    @NSManaged public var tableNumber: Int16
    @NSManaged public var status: String
    @NSManaged public var timestamp: Date
    @NSManaged public var total: Double
    @NSManaged public var items: Set<OrderItem>?
}

extension Order {
    var itemList: [OrderItem] {
        Array(items ?? [])
    }
}
