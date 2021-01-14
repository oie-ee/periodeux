
import SwiftUI

struct CalendarView: View {
    
    private var calendar = Calendar.current
    
    private let dateFormatter = DateFormatter()
    
    @State private var selectedDate: Date = Date()
    
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    
    @State private var numbersOfDays: Int = 0
    
    var firstWeekday: Int {
        return self.calendar.firstWeekday
    }
    
    var numberOfDays: Range<Int> {
        return self.calendar.range(of: .day, in: .month, for: self.selectedDate)!
    }
    
    var firstDayOfMonth: Int {
        
        let firstDateOfMonthAMonthToMuch = self.calendar.date(bySetting: .day, value: 1, of: self.selectedDate) ?? Date()
        let date = self.calendar.date(byAdding: .month, value: -1, to: firstDateOfMonthAMonthToMuch) ?? Date()
        let weekday = self.calendar.component(.weekday, from: date)
        
        return weekday
    }
    
    var monthName: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM Y"
        
        return dateFormatter.string(from: selectedDate)
    }
    
    var body: some View {
        
        VStack {
            
            // Data: Month with selection
            HStack {
                
                Text(self.monthName)
                    .font(Font.title2.weight(.semibold))
                
                Spacer()
                
                //Left Chevron
                Button(action: {
                    self.selectedDate = calendar.date(byAdding: .month, value: -1, to: self.selectedDate) ?? Date()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .font(Font.title.weight(.semibold))
                        .frame(width: 10.0, height: 17.0)
                }
                .padding(.trailing, 6)
                
                
                //Right Chevron
                Button(action: {
                    self.selectedDate = calendar.date(byAdding: .month, value: 1, to: self.selectedDate) ?? Date()
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .font(Font.title.weight(.semibold))
                        .frame(width: 10.0, height: 17.0)
                }
                .padding(.trailing, 10)
                
            }.padding([.leading, .trailing])
            .padding(.bottom, 8)
            
            //Days of the Week
            WeekDays()
            
            
            // Day-Grid
            VStack {
                ForEach(1..<7) {
                    row in
                    HStack {
                        ForEach(1..<8) {
                            column in
                            
                            let daysElapsed = column + ((row - 1) * 7)
                            let dayOfMonth = daysElapsed - (self.firstDayOfMonth - 1 - (self.firstWeekday - 1))
                            
                            ZStack {
                                
                                Circle().foregroundColor(.white)
                                
                                if self.numberOfDays.contains(dayOfMonth) {
                                    Text("\(dayOfMonth)")
                                        .font(.title3)
                                }
                                
                            }
                            
                        }
                    }
                }
            }.padding([.leading, .trailing])
            
        }
        .frame(height: 400)
        .gesture(DragGesture(minimumDistance: 150, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width < 0 {
                            // left
                            self.selectedDate = calendar.date(byAdding: .month, value: 1, to: self.selectedDate) ?? Date()
                        }
                        
                        if value.translation.width > 0 {
                            // right
                            self.selectedDate = calendar.date(byAdding: .month, value: -1, to: self.selectedDate) ?? Date()
                        }
                    }))
    }
}

struct WeekDays: View {
    
    let firstWeekDay = Calendar.current.firstWeekday
    let weekdays = Calendar.current.shortWeekdaySymbols
    
    var weekdayRange: ArraySlice<String> {
        print(firstWeekDay)
        
        guard firstWeekDay > 1 else {
            return weekdays[0...weekdays.count - 1]
        }
        return weekdays[(firstWeekDay - 1)...(weekdays.count - 1)] + weekdays[0...(firstWeekDay - 2)]
        
    }
    
    var body: some View {
        
        HStack{
            ForEach(weekdayRange, id: \.self) { weekdays in
                
                Spacer()
                Text("\(weekdays)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemGray2))
                    .textCase(.uppercase)
                
                Spacer()
            }
        }.padding([.leading, .trailing], 8)
    }
}


//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
