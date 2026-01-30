import CoreData
import SwiftUI

@main
struct POSBarApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            POSView(viewModel: OrderViewModel(context: appState.context))
                .environment(\.managedObjectContext, appState.context)
                .environmentObject(appState)
        }
    }
}

final class AppState: ObservableObject {
    let coreData = CoreDataManager.shared

    var context: NSManagedObjectContext {
        coreData.container.viewContext
    }

    init() {
        seedIfNeeded()
    }

    private func seedIfNeeded() {
        let request = Product.fetchRequest()
        request.fetchLimit = 1
        let count = (try? context.count(for: request)) ?? 0
        if count == 0 {
            SampleData.seed(into: context)
        }
    }
}
