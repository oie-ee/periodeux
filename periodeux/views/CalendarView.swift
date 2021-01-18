
import SwiftUI

struct CalendarView: View {
    
    @State private var calendar = Calendar.current
    
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
    
    @State private var firstDayOfPeriod: String = "11.01.2021 01:00"
    @State private var lastDayOfPeriod: String = "16.01.2021 01:00"
//    @State private var middleDayOfPeriod: String
    
    
    
    func compareFirstDateOfPeriod(date1: Date, to date2: Date, toGranularity component: Calendar.Component) -> Bool {

        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let result = calendar.compare((generateDateFromString(string: firstDayOfPeriod)), to: (generateDateFromString(string: lastDayOfPeriod)), toGranularity: .day)
       
        let isFirstDay = result == .orderedAscending
        
        return isFirstDay
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
                            
                            let daysElapsed = column + ((row - 1) * 7)
                            let selectedDay = weekdayPosition(daysElapsed)
                            
                            Button(action: {
                                print("\(selectedDay) was selected")
                                print("\(generateDateFromString(string: firstDayOfPeriod)) was the first day")
                                print("\(generateDateFromString(string: lastDayOfPeriod)) was the last day")
                                print("\(compareFirstDateOfPeriod(date1: (generateDateFromString(string: firstDayOfPeriod)), to: (generateDateFromString(string: lastDayOfPeriod)), toGranularity: .day))")
                                
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
                                            .frame(height: 40)
                                    } else {
                                        Circle().foregroundColor(.white)
                                            .frame(height: 40)
                                    }
                                    
                                    if numberOfDays.contains(selectedDay) {
                                        Text("\(selectedDay)")
                                            .font(.title3)
                                            .foregroundColor(.black)
                                    }
                                    
                                    //current Date is highlighted
                                    if  selectedDay == today && self.selectedMonth == currentMonth && self.selectedYear == currentYear{
                                        Circle().foregroundColor(Color(UIColor.systemGray4)).opacity(0.7)
                                            .frame(height: 40)
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.bold))
                                            .foregroundColor(.black)
                                    }
                                  
                                    //FirstDay of Period
                                    if  selectedDay == 11 && self.selectedMonth == currentMonth && self.selectedYear == currentYear{
                                        
                                        RoundedCorners(tl: 40, tr: 0, bl: 40, br: 0)
                                            .foregroundColor(ColorManager.backgroundOrange)
                                            .frame(height: 40)
                                            .offset(x: 5)
                                        
                                        Circle().foregroundColor(ColorManager.highlightOrange)
                                            .frame(height: 40)
                                        
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.regular))
                                            .foregroundColor(.white)
                                    }
                                    //Middle Days of Period
                                    if  (selectedDay >= 12 && selectedDay <= 15) && self.selectedMonth == currentMonth && self.selectedYear == currentYear{
                                        
                                        RoundedCorners(tl: 0, tr: 0, bl: 0, br: 0)
                                            .foregroundColor(ColorManager.backgroundOrange)
                                            .frame(height: 40)
                                        
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.regular))
                                            .foregroundColor(ColorManager.highlightOrange)
                                    }
                                    //Last Day Of Period
                                    if  selectedDay == 16 && self.selectedMonth == currentMonth && self.selectedYear == currentYear{
                                        
                                        RoundedCorners(tl: 00, tr: 30, bl: 0, br: 30)
                                            .foregroundColor(ColorManager.backgroundOrange)
                                            .frame(height: 40)
                                        
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.regular))
                                            .foregroundColor(ColorManager.highlightOrange)
                                    }
                                    
                                }
                            })
                        }
                    }
                }
            }.padding([.leading, .trailing], 8)
            
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let convertedDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 01:00")
        
        return convertedDate
    }
    
    func generateDateFromString(string: String) -> Date{
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "DD.MM.y HH:mm"
        
        return (stringFormatter.date(from: string) ?? Date())
    }
}

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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
