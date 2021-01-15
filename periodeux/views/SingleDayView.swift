//
//import SwiftUI
//
//struct SingleDayView: View {
//    
//    var calendar = Calendar.current
//    
//    var selectedDate: Date = Date()
//    
//    @Binding var daysElapsed: Int
//    @Binding var dayOfMonth: Int
//    
//    var firstWeekday: Int {
//        return self.calendar.firstWeekday
//    }
//    
//    var numberOfDays: Range<Int> {
//        return self.calendar.range(of: .day, in: .month, for: self.selectedDate)!
//    }
//    
//    func weekdayPosition(_ elapsed: Int) -> Int {
//        let position = elapsed - (self.firstDayOfMonth - 1 - (self.firstWeekday - 1))
//        let firstPosition = (self.firstDayOfMonth - 1 - (self.firstWeekday - 1))
//        
//        return firstPosition < 0 ? position - 7 : position
//    }
//    
//    var firstDayOfMonth: Int {
//        
//        let firstDateOfMonthAMonthToMuch = self.calendar.date(bySetting: .day, value: 1, of: self.selectedDate) ?? Date()
//        let date = self.calendar.date(byAdding: .month, value: -1, to: firstDateOfMonthAMonthToMuch) ?? Date()
//        let weekday = self.calendar.component(.weekday, from: date)
//        
//        return weekday
//    }
//    
//    
//    var body: some View {
//        
//        //let daysElapsed = column + ((row - 1) * 7)
//        //let dayOfMonth = weekdayPosition(daysElapsed)
//        
//        ZStack {
//            
//            Circle().foregroundColor(.white)
//            
//            if self.numberOfDays.contains(dayOfMonth) {
//                Text("\(dayOfMonth)")
//                    .font(.title3)
//            }
//            
//        }
//        
//    }
//}
//
////struct SingleDayView_Previews: PreviewProvider {
////    static var previews: some View {
////        SingleDayView()
////    }
////}
