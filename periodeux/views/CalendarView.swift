
import SwiftUI

struct CalendarView: View {
    
    // MARK: - Properties
    @State private var calendar = Calendar.current
    
    private let dateFormatter = DateFormatter()
    
    @State private var selectedDate: Date = Date()
    
    @State private var numbersOfDays: Int = 0
    
    @State private var daysElapsed: Int = 0
    
    @State var selectedDayArray = [Bool](repeating: false, count: 32)
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    var firstWeekdayOfCalendar: Int {
        return self.calendar.firstWeekday
    }
    
    @State private var today: Int = Calendar.current.component(.day, from: Date())
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var currentYear: Int = Calendar.current.component(.year, from: Date())
    
    
    // MARK: - Start Of Period Calculation
    @State private var firstDayOfPeriod: String = "11.01.2021 03:00"
    @State private var lastDayOfPeriod: String = "16.01.2021 03:00"
    @State private var currentDate: Date = Date()
    
    var pastFirstDayOfPeriodDate11: Date {
        return subtractsCycleLengthDays(date: pastFirstDayOfPeriodDate12)
    }
    
    var pastLastDayOfPeriodDate11: Date {
        return subtractsCycleLengthDays(date: pastLastDayOfPeriodDate12)
    }
    
    var pastFirstDayOfPeriodDate12: Date {
        return subtractsCycleLengthDays(date: firstDayOfPeriodDate)
    }
    
    var pastLastDayOfPeriodDate12: Date {
        return subtractsCycleLengthDays(date: lastDayOfPeriodDate)
    }
    
    //January is here
    var firstDayOfPeriodDate: Date {
        return generateDateFromString(string: firstDayOfPeriod)
    }
    
    var lastDayOfPeriodDate: Date {
        return generateDateFromString(string: lastDayOfPeriod)
    }
    
    var firstDayOfPeriodDate2: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate)
    }
    
    var lastDayOfPeriodDate2: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate)
    }
    
    var firstDayOfPeriodDate3: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate2)
    }
    
    var lastDayOfPeriodDate3: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate2)
    }
    
    var firstDayOfPeriodDate4: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate3)
    }
    
    var lastDayOfPeriodDate4: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate3)
    }
    
    var firstDayOfPeriodDate5: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate4)
    }
    
    var lastDayOfPeriodDate5: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate4)
    }
    
    var firstDayOfPeriodDate6: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate5)
    }
    
    var lastDayOfPeriodDate6: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate5)
    }
    
    var firstDayOfPeriodDate7: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate6)
    }
    
    var lastDayOfPeriodDate7: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate6)
    }
    
    var firstDayOfPeriodDate8: Date {
        return addCycleLengthDays(date: firstDayOfPeriodDate7)
    }
    
    var lastDayOfPeriodDate8: Date {
        return addCycleLengthDays(date: lastDayOfPeriodDate7)
    }
    // MARK: - End Of Period Calculation
    
    //Calculate days til next period start
    var daysBetweenDates: Int {
        let startDate = currentDate
        let endDate = firstDayOfPeriodDate6
        
        //Escape
        if(currentDate >= endDate) {
            return 20
        }
        
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        return components.day! + 1
    }
        
    var numberOfDays: Range<Int> {
        return self.calendar.range(of: .day, in: .month, for: self.selectedDate)!
    }
    
    var selectedYear: Int {
        return Calendar.current.component(.year, from: self.selectedDate)
    }
    
    var selectedMonth: Int {
        return Calendar.current.component(.month, from: self.selectedDate)
    }
    
    func weekdayPosition(_ cellNumber: Int) -> Int {
        
        let firstCellPositionOfMonth = self.firstWeekdayOfMonth - self.firstWeekdayOfCalendar + 1
        let position = cellNumber - (self.firstWeekdayOfMonth - 1 - (self.firstWeekdayOfCalendar - 1))
        let firstPosition = (self.firstWeekdayOfMonth - 1 - (self.firstWeekdayOfCalendar - 1))
        
        return firstPosition < 0 ? position - 7 : position
    }
    
    
    
    func dateFromCellNumber(_ cellNumber: Int) -> Date? {
        let firstCellPositionOfMonth = (self.firstWeekdayOfMonth - self.firstWeekdayOfCalendar + 7) % 7
        let day = cellNumber - firstCellPositionOfMonth
        
        return day > 0 && day <= self.numberOfDays.count ?
            self.generateDateFromSelectedDay(day: day, month: self.selectedMonth, year: self.selectedYear) : nil
    }
   
    var firstWeekdayOfMonth: Int {
        
        let firstDayOfMonth = self.calendar.dateComponents([.calendar, .year,.month], from: self.selectedDate).date!
        let weekday = self.calendar.component(.weekday, from: firstDayOfMonth)
        
        return weekday
    }
    
    var monthName: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM Y"
        
        return dateFormatter.string(from: selectedDate)
    }
    
    // MARK: - Body
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
                .padding(.trailing, 14)
                
                
                //Right Chevron
                Button(action: {
                    self.selectedDate = calendar.date(byAdding: .month, value: 1, to: self.selectedDate) ?? Date()
                    
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .font(Font.title.weight(.semibold))
                        .frame(width: 10.0, height: 17.0)
                }
                .padding(.trailing, 2)
                
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
                            
                            let cellNumber = column + ((row - 1) * 7)
                            let currentDate = dateFromCellNumber(cellNumber)
                            
                            CalenderDayView(dayType: .ovulation, date: currentDate)
                            
                            
                        }
                    }
                }
            }.padding([.leading, .trailing], 8)
            
        }
        .onAppear {
            appStore.daysTilPeriod = daysBetweenDates
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
    
    //Generate Date From Day/Month/Year Int
    func generateDateFromSelectedDay(day: Int, month: Int, year: Int) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let convertedDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 03:00")
        
        return convertedDate
    }
    
    //Generate Date From String
    func generateDateFromString(string: String) -> Date{
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "DD.MM.y HH:mm"
        
        return (stringFormatter.date(from: string) ?? Date())
    }
    
    //Add CycleLength (Days) To Date
    func addCycleLengthDays(date: Date) -> Date {
        
        var dateComponent = DateComponents()
        dateComponent.day = 29
        
        let increasedDate = Calendar.current.date(byAdding: dateComponent, to: date) ?? Date()
        return increasedDate
    }
    
    //Substract CycleLength (Days) From Date
    func subtractsCycleLengthDays(date: Date) -> Date {
        
        var dateComponent = DateComponents()
        dateComponent.day = -29
        
        let decreasedDate = Calendar.current.date(byAdding: dateComponent, to: date) ?? Date()
        return decreasedDate
    }
    
    //Generate String That Tells Period Yes/No From Dates
    func generateDateViewType (date: Date) -> CalenderDayView.DayType {
        
        return .startInterval
//        if(date == startInterval) {
//            return .startInterval
//        }
//
//        if(date == endInterval) {
//            return .endInterval
//        }
//
//        if(date < startInterval || date > endInterval) {
//            return .noPeriod
//        }
//
//        if(date > startInterval && date < endInterval) {
//            return .inInterval
//        }
//
//        return .none
    }
    
    
    
}

// MARK: - RoundedCorners
struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        return path
    }
}
