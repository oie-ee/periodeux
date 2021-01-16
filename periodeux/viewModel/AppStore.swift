
import Foundation


class AppStore: ObservableObject {
    @Published var selectedDate : Date
    
    init() {
        self.selectedDate = Date()
    }
}
