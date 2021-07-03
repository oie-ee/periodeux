
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
        
        self.daysTilPeriod = 1
        
        self.currentReport = ReportDB()
    }
    
    func selectDate(_ date: Date) -> Void {
        self.selectedDate = date
    }
    
    func setDaysTilPeriod(value: Int) {
        self.daysTilPeriod = value
    }
}
