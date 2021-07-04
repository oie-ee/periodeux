
import Foundation
import SwiftUI

class AppStore: ObservableObject {
    @EnvironmentObject var reportStore : ReportStore
    
    @Published var selectedDate : Date
    
    @Published var currentReport : ReportDB
    
    init() {
        self.selectedDate = Date()
        
        self.currentReport = ReportDB()
    }
    
    func selectDate(_ date: Date) -> Void {
        self.selectedDate = date
    }
}
