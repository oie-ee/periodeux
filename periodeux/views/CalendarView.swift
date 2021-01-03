
import SwiftUI

struct CalendarView: View {
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    @State private var selectedYear: Int = 2021
    @State private var selectedMonth: Int = 0
    
    @State private var numbersOfDays: Int = 0
    @State private var firstWeekday: Int = 0
    @State private var nameOfMonth: String = "–"
    
    var body: some View {
        
        VStack {
            
            // Data: Month with selection
            HStack(alignment: .center) {
                
                Text("\(self.nameOfMonth)")
                    .font(Font.title2.weight(.semibold))
                
                Spacer()
                
                Button(action: {
                    self.selectedMonth = selectedMonth - 1
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .font(Font.title.weight(.semibold))
                        .frame(width: 10.0, height: 17.0)
                }.onChange(of: selectedMonth, perform: {
                    value in
                    self.update()
                })
                
                Button(action: {
                    self.selectedMonth = selectedMonth + 1
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .font(Font.title.weight(.semibold))
                        .frame(width: 10.0, height: 17.0)
                }.onChange(of: selectedMonth, perform: {
                    value in
                    self.update()
                })
            }.padding([.leading, .trailing, .bottom])
            
            //Days of the Week
            WeekDays()
            
            
            // Grid
            VStack {
                ForEach(1..<7) {
                    row in
                    HStack {
                        ForEach(1..<8) {
                            column in
                            
                            let previousDaysElapsed = 7 * (row - 1)
                            let currentDay = column + previousDaysElapsed
                            
                            let dayIsInRange = (currentDay > self.firstWeekday) && currentDay <= (self.numbersOfDays + self.firstWeekday)
                            
                            ZStack {
                                Circle().foregroundColor(dayIsInRange ? .white : .gray)
                                Text(dayIsInRange ? "\(currentDay - self.firstWeekday)" : "")
                            }
                            
                        }
                    }
                }
            }
            .padding()
            
        }
        .frame(width: 400, height: 400)
        .onAppear {
            self.update()
        }
        
    }
    
    
    private func update() {
        
        let dateComponents = DateComponents(year: self.selectedYear, month: self.selectedMonth + 1, day: 1)
        guard let selectedDate = calendar.date(from: dateComponents) else { return }
        
        // Number of Days
        let range = calendar.range(of: .day, in: .month, for: selectedDate)!
        self.numbersOfDays = range.count
        
        // First Weekday
        self.firstWeekday = calendar.component(.weekday, from: selectedDate) // 1 == sunday
        
        // Name of Month
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "MMMM y"
        nameOfMonth = dateFormatter.string(from: selectedDate)
        
    }
}

struct WeekDays: View {
    
    let weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
    var body: some View {
        
        HStack(spacing: 24){
            
            ForEach(weekdays, id: \.self) { weekdays in
                Text("\(weekdays)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            
        }
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
