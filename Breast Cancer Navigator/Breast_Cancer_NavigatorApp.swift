import SwiftUI
import SwiftData

@main
struct Breast_Cancer_NavigatorApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                LegalDisclaimerView()
                    .navigationBarHidden(true) // Hide navigation bar on initial view
            }
            .navigationViewStyle(StackNavigationViewStyle()) // Ensure Legal Disclaimer fills the screen
            .modelContainer(sharedModelContainer)
        }
    }
}

