
import SwiftUI

struct CalendarView: View {
    
    private var calendar = Calendar.current
    
    private let dateFormatter = DateFormatter()
    
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date()) - 1
    
    @State private var numbersOfDays: Int = 0
    @State private var firstWeekday: Int = 0
    @State private var nameOfMonth: String = "–"
    
    var body: some View {
        
        VStack {
            
            // Data: Month with selection
            HStack {
                
                Text("\(self.nameOfMonth)")
                    .font(Font.title2.weight(.semibold))
                
                Spacer()
                
                //Left Chevron
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
                }).padding(.trailing, 6)
                
                
                //Right Chevron
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
                }).padding(.trailing, 10)
                
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
                            
                            let previousDaysElapsed = 7 * (row - 1)
                            let currentDay = (column + previousDaysElapsed)
                            
                            
                            let dayIsInRange = (currentDay > self.firstWeekday)  && currentDay <= (self.numbersOfDays + self.firstWeekday)
                            
                            ZStack {
                                Circle().foregroundColor(dayIsInRange ? .white : .white)
                                Text(dayIsInRange ? "\(currentDay - self.firstWeekday)" : "")
                                    .font(.title3)
                            }
                            
                        }
                    }
                }
            }.padding([.leading, .trailing])
            
        }
        .frame(height: 400)
        .onAppear {
            self.update()
        }
        .gesture(DragGesture(minimumDistance: 150, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width < 0 {
                            // left
                            self.selectedMonth = selectedMonth + 1
                        }
                        
                        if value.translation.width > 0 {
                            // right
                            self.selectedMonth = selectedMonth - 1
                        }
                    }))
    }
    
    
    private func update() {
        
        let dateComponents = DateComponents(year: self.selectedYear, month: self.selectedMonth + 1, day: 1)
        guard let selectedDate = calendar.date(from: dateComponents) else { return }
        
        // Number of Days
        let range = calendar.range(of: .day, in: .month, for: selectedDate)!
        self.numbersOfDays = range.count
        
        // First Weekday
        self.firstWeekday = calendar.component(.weekday, from: selectedDate) - 2 // 1 == sunday
        if self.firstWeekday == -1 {
            self.firstWeekday = 6
        }
        
        // Name of Month
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "MMMM y"
        nameOfMonth = dateFormatter.string(from: selectedDate)
        
    }
}

struct WeekDays: View {
    
    let weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
    var body: some View {
        
        HStack{
            
            ForEach(weekdays, id: \.self) { weekdays in
                
                Spacer()
                
                Text("\(weekdays)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemGray2))
                
                Spacer()
            }
        }.padding([.leading, .trailing], 8)
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
