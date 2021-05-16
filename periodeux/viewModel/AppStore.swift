
import Foundation


class AppStore: ObservableObject {
    @Published var selectedDate : Date
    
//    @Published var selectedDateString : String
    
    @Published var daysTilPeriod : Int
    
    init() {
        self.selectedDate = Date()
        
        self.daysTilPeriod = 0
    }
    
    func setDaysTilPeriod(value: Int) {
        self.daysTilPeriod = value
    }
}
