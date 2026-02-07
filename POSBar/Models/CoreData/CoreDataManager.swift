import CoreData
import Foundation

final class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentCloudKitContainer

    private init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "POSBar")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        if let description = container.persistentStoreDescriptions.first {
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                assertionFailure("Unresolved Core Data error: \(error)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    static func preview() -> CoreDataManager {
        let manager = CoreDataManager(inMemory: true)
        let context = manager.container.viewContext
        SampleData.seed(into: context)
        return manager
    }

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                assertionFailure("Failed to save Core Data context: \(error)")
            }
        }
    }
}

enum SampleData {
    static func seed(into context: NSManagedObjectContext) {
        let products: [(String, String, Double)] = [
            ("Pilsner", "Beer", 49),
            ("IPA", "Beer", 69),
            ("Gin & Tonic", "Cocktail", 119),
            ("Espresso", "Coffee", 45),
            ("Mineral Water", "Soft", 35)
        ]

        for (name, category, price) in products {
            let product = Product(context: context)
            product.id = UUID()
            product.name = name
            product.category = category
            product.price = price
            product.isAvailable = true
        }

        do {
            try context.save()
        } catch {
            assertionFailure("Failed to seed sample data: \(error)")
        }
    }
}
