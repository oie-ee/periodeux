
import Foundation
import SwiftUI

class AppStore: ObservableObject {
    @EnvironmentObject var reportStore : ReportStore
    
    @Published var selectedDate : Date 
    
//    @Published var selectedDateString : String
    
    @Published var daysTilPeriod : Int
    
    @Published var currentReport : ReportDB
    
    init() {
        self.selectedDate = Date()
        
        self.daysTilPeriod = 0
        
        self.currentReport = ReportDB()
    }
    
    func setDaysTilPeriod(value: Int) {
        self.daysTilPeriod = value
    }
}
