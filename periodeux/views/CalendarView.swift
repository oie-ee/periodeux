
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
    
    var firstWeekday: Int {
        return self.calendar.firstWeekday
    }
    
    @State private var today: Int = Calendar.current.component(.day, from: Date())
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var currentYear: Int = Calendar.current.component(.year, from: Date())
    
    
    // MARK: - Start Of Period Calculation
    @State private var firstDayOfPeriod: String = "11.01.2021 01:00"
    @State private var lastDayOfPeriod: String = "16.01.2021 01:00"
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
                            
                            let daysElapsed = column + ((row - 1) * 7)
                            let selectedDay = weekdayPosition(daysElapsed)
                            
                            Button(action: {
                                
                                appStore.selectedDate = generateDateFromSelectedDay(
                                    day: selectedDay,
                                    month: self.selectedMonth,
                                    year: self.selectedYear
                                ) ?? Date()
                                
                                selectedDayArray =  [Bool](repeating: false, count: 32)
                                
                                selectedDayArray[selectedDay] = true
                            }, label: {
                                ZStack {
                                    
                                    let currentDate = generateDateFromSelectedDay(
                                        day: selectedDay,
                                        month: self.selectedMonth,
                                        year: self.selectedYear
                                    ) ?? Date()
                                    
                                    let visualTypeOfDay011 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: pastFirstDayOfPeriodDate11,
                                        endInterval: pastLastDayOfPeriodDate11)
                                    
                                    let visualTypeOfDay012 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: pastFirstDayOfPeriodDate12,
                                        endInterval: pastLastDayOfPeriodDate12)
                                    
                                    let visualTypeOfDay = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate,
                                        endInterval: lastDayOfPeriodDate)
                                    
                                    let visualTypeOfDay2 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate2,
                                        endInterval: lastDayOfPeriodDate2)
                                    
                                    let visualTypeOfDay3 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate3,
                                        endInterval: lastDayOfPeriodDate3)
                                    
                                    let visualTypeOfDay4 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate4,
                                        endInterval: lastDayOfPeriodDate4)
                                    
                                    let visualTypeOfDay5 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate5,
                                        endInterval: lastDayOfPeriodDate5)
                                    
                                    let visualTypeOfDay6 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate6,
                                        endInterval: lastDayOfPeriodDate6)
                                    
                                    let visualTypeOfDay7 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate7,
                                        endInterval: lastDayOfPeriodDate7)
                                    
                                    let visualTypeOfDay8 = generateDateViewType(
                                        date: currentDate,
                                        startInterval: firstDayOfPeriodDate8,
                                        endInterval: lastDayOfPeriodDate8)
                                    
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
                                    
                                    //Day of Ovulation
                                    if  selectedDay == 29 && self.selectedMonth == 11 && self.selectedYear == 2020 || selectedDay == 28 && self.selectedMonth == 12 && self.selectedYear == 2020 || selectedDay == 26 && self.selectedMonth == currentMonth && self.selectedYear == currentYear || selectedDay == 24 && self.selectedMonth == 2 && self.selectedYear == currentYear || selectedDay == 25 && self.selectedMonth == 3 && self.selectedYear == currentYear || selectedDay == 23 && self.selectedMonth == 4 && self.selectedYear == currentYear || selectedDay == 22 && self.selectedMonth == 5 && self.selectedYear == currentYear || selectedDay == 20 && self.selectedMonth == 6 && self.selectedYear == currentYear || selectedDay == 19 && self.selectedMonth == 7 && self.selectedYear == currentYear || selectedDay == 17 && self.selectedMonth == 8 && self.selectedYear == currentYear{
                                        Circle().foregroundColor(Color(UIColor.systemTeal)).opacity(0.1)
                                            .frame(height: 40)
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.semibold))
                                            .foregroundColor(Color(UIColor.systemTeal))
                                    }
                                    
                                    //FirstDay of Period
                                    if  visualTypeOfDay == "startInterval" || visualTypeOfDay2 == "startInterval" || visualTypeOfDay3 == "startInterval" || visualTypeOfDay4 == "startInterval" || visualTypeOfDay5 == "startInterval" || visualTypeOfDay6 == "startInterval" || visualTypeOfDay7 == "startInterval" || visualTypeOfDay8 == "startInterval"  || visualTypeOfDay012 == "startInterval" || visualTypeOfDay011 == "startInterval"{
                                        
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
                                    if  visualTypeOfDay == "isPeriod" || visualTypeOfDay2 == "isPeriod" || visualTypeOfDay3 == "isPeriod" || visualTypeOfDay4 == "isPeriod" || visualTypeOfDay5 == "isPeriod" || visualTypeOfDay6 == "isPeriod" || visualTypeOfDay7 == "isPeriod" || visualTypeOfDay8 == "isPeriod" || visualTypeOfDay012 == "isPeriod" || visualTypeOfDay011 == "isPeriod"{
                                        
                                        RoundedCorners(tl: 0, tr: 0, bl: 0, br: 0)
                                            .foregroundColor(ColorManager.backgroundOrange)
                                            .frame(height: 40)
                                        
                                        Text("\(selectedDay)")
                                            .font(Font.title3.weight(.regular))
                                            .foregroundColor(ColorManager.highlightOrange)
                                    }
                                    
                                    //Last Day Of Period
                                    if  visualTypeOfDay == "endInterval" || visualTypeOfDay2 == "endInterval" || visualTypeOfDay3 == "endInterval" || visualTypeOfDay4 == "endInterval" || visualTypeOfDay5 == "endInterval" || visualTypeOfDay6 == "endInterval" || visualTypeOfDay7 == "endInterval" || visualTypeOfDay8 == "endInterval"  || visualTypeOfDay012 == "endInterval" || visualTypeOfDay011 == "endInterval"{
                                        
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
    
    //Generate Date From Day/Month/Year Int
    func generateDateFromSelectedDay(day: Int, month: Int, year: Int) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let convertedDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 01:00")
        
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
    func generateDateViewType (date: Date, startInterval: Date, endInterval: Date) -> String {
        if(date == startInterval) {
            return "startInterval"
        }
        
        if(date == endInterval) {
            return "endInterval"
        }
        
        if(date < startInterval || date > endInterval) {
            return "noPeriod"
        }
        
        if(date > startInterval && date < endInterval) {
            return "isPeriod"
        }
        
        return "none"
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

// MARK: - Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
