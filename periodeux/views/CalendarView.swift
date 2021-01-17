
import SwiftUI

struct CalendarView: View {
    
    @State  private var calendar = Calendar.current
    
    private let dateFormatter = DateFormatter()
    
    @State private var selectedDate: Date = Date()
    
    
    @State private var numbersOfDays: Int = 0
    
    @State private var daysElapsed: Int = 0
    
    @State var selectedDayArray = [Bool](repeating: false, count: 32)
    
    @EnvironmentObject var appStore : AppStore
    
    
    var firstWeekday: Int {
        return self.calendar.firstWeekday
    }
    
    @State private var today: Int = Calendar.current.component(.day, from: Date())
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var numberOfDays: Range<Int> {
        return self.calendar.range(of: .day, in: .month, for: self.selectedDate)!
    }
    
    var selectedYear: Int {
        return Calendar.current.component(.year, from: self.selectedDate)
    }
    
    var selectedMonth: Int {
        return Calendar.current.component(.month, from: self.selectedDate)
    }
    
    func weekdayPosition(_ elapsed: Int) -> Int {
        let position = elapsed - (self.firstDayOfMonth - 1 - (self.firstWeekday - 1))
        let firstPosition = (self.firstDayOfMonth - 1 - (self.firstWeekday - 1))
        
        return firstPosition < 0 ? position - 7 : position
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
            VStack(spacing: 0){
                ForEach(1..<7) {
                    row in
                    HStack(spacing: 0){
                        ForEach(1..<8) {
                            column in
                            
                            let daysElapsed = column + ((row - 1) * 7)
                            let selectedDay = weekdayPosition(daysElapsed)
                            
                            Button(action: {
                                print("\(selectedDay) was selected")
                                
                                appStore.selectedDate = generateDateFromSelectedDay(
                                    day: selectedDay,
                                    month: self.selectedMonth,
                                    year: self.selectedYear
                                ) ?? Date()
                                
                                selectedDayArray =  [Bool](repeating: false, count: 32)
                                
                                selectedDayArray[selectedDay] = true
                            }, label: {
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 0, style: .continuous).foregroundColor(.white)
                                    
                                    let arrayRange = 0...31
                                    
                                    if(arrayRange.contains(selectedDay)) {
                                        Circle().foregroundColor(selectedDayArray[selectedDay] ? Color(UIColor.systemGray6) : .white)
                                    } else {
                                        Circle().foregroundColor(.white)
                                    }
                                    
                                    if numberOfDays.contains(selectedDay) {
                                        Text("\(selectedDay)")
                                            .font(.title3)
                                            .foregroundColor(.black)
                                    }
                                    
                                    //current Date is highlighted
                                    if  selectedDay == today && self.selectedMonth == currentMonth && self.selectedYear == currentYear{
                                        Circle().foregroundColor(Color(UIColor.systemGray4)).opacity(0.7)
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.bold))
                                            .foregroundColor(.black)
                                        
                                    }
                                    
                                }
                            })
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
    
    func generateDateFromSelectedDay(day: Int, month: Int, year: Int) -> Date? {
        
        print("Day \(day)")
        print("Month \(month)")
        print("Year \(year)")
        
        print("SelectedDate \(self.selectedMonth)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let convertedDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 01:00")
        
        return convertedDate
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
