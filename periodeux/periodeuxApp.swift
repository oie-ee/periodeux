
import SwiftUI

@main
struct periodeuxApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var appStore = AppStore()
    
    var body: some Scene {
        WindowGroup {
            
            if isOnboarding {
                OnboardingView()
                
            } else {
                
                ContentView()
                    .environmentObject(appStore)
                    .environmentObject(ReportStore(realm: RealmPersistent.initializer()))
                    .environmentObject(PeriodStore(realm: RealmPersistent.initializer()))
            }
        }
    }
}
