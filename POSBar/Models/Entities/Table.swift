import CoreData
import Foundation

@objc(Table)
public final class Table: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Table> {
        NSFetchRequest<Table>(entityName: "Table")
    }

    @NSManaged public var id: UUID
    @NSManaged public var number: Int16
    @NSManaged public var status: String
    @NSManaged public var currentOrder: Order?
}
