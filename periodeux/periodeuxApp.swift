
import SwiftUI

@main
struct periodeuxApp: App {
    
    var appStore = AppStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appStore)
        }
    }
}
