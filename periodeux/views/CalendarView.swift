
import SwiftUI

struct CalendarView: View {
    
    // MARK: - Properties
    @State private var calendar = Calendar.current
    
    private let dateFormatter = DateFormatter()
    
    @State private var selectedDate: Date = Date()
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    @EnvironmentObject var periodStore : PeriodStore
    
    @State private var currentToday: Int = Calendar.current.component(.day, from: Date())
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var currentYear: Int = Calendar.current.component(.year, from: Date())

    
    //Calculate days til next period start – not dynamic anymore
    var daysBetweenDates: Int {
        return 1
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
    
    func dateFromCellNumber(_ cellNumber: Int) -> Date? {
        let firstCellPositionOfMonth = (self.firstWeekdayOfMonth - self.calendar.firstWeekday + 7) % 7
        let day = cellNumber - firstCellPositionOfMonth
        
        return day > 0 && day <= self.numberOfDays.count ?
            DayEntry.generateDateFromComponents(day: day, month: self.selectedMonth, year: self.selectedYear) : nil
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
                            
                            
                           
                                ZStack {
                                    RoundedRectangle(cornerRadius: 0, style: .continuous).foregroundColor(ColorManager.lightestElement)
                                    
                                    if currentDate != nil {
                                        CalenderDayView(date: currentDate!)
                                    } else  {
                                        CalenderDayView()
                                    }
                                    
                                    
                                }
      

                            

                            
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
    
}

// MARK: - RoundedCorners
struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    let offset: CGSize = CGSize(width: 0, height: 0)
    
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
