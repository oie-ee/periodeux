//
//  CalenderDayView.swift
//  periodeux
//
//  Created by Gustav on 03.06.21.
//

import SwiftUI


struct DayEntry: Identifiable {
    var id: Int
    
    var date: Date
    
    enum DayType {
        case none
        case startInterval
        case endInterval
        case noPeriod
//        auto check for inInterval!
        case inInterval
        case ovulation
        case currentDay
    }
    
    let dayType: DayType
    
    init(_ date: Date, dayType: DayType) {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        
        self.id = day + month + year
            
        self.date = Self.generateDayDateFromDate(date)
        
        self.dayType = dayType
    }
    
    //Generate Date From Day/Month/Year Int
    static func generateDateFromComponents(day: Int, month: Int, year: Int) -> Date? {
        
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar.current.date(from: components)
    }
    
    // strips away time component
    static func generateDayDateFromDate(_ date: Date) -> Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date) ?? date
    }
    
}


struct CalenderDayView: View {
    

    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var currentReport: ReportDB = ReportDB()

    var date: Date?
    
    enum visualType {
        case none
        case startInterval
        case endInterval
        case noPeriod
        case inInterval
        case ovulation
        case currentDay
    }
    
    @Binding var selectedDate: Date
    
    var type: visualType

        
//        let period = periodStore.getLatestOccurenceOfPeriodForDate(period: latestPeriod!, date!)
//
//        guard period != nil else {
//            return DayEntry(date!, dayType: .noPeriod)
//        }
//
//        let isInPeriod = period!.isDateInPeriodInterval(self.date!)
//        let isPeriodStart = period!.isDatePeriodStartDay(self.date!)
//        let isPeriodEnd = period!.isDatePeriodEndDay(Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self.date!) ?? self.date!)
//
//        var dayType: DayEntry.DayType
//
//        switch (isInPeriod, isPeriodStart, isPeriodEnd) {
//
//        case (true, false, false):
//            dayType = .inInterval
//            break
//        case (false, true, false), (true, true, false):
//            dayType = .startInterval
//            break
//        case (false, false, true), (true, false, true):
//            dayType = .endInterval
//            break
//        default:
//            dayType = .noPeriod
//        }
//
//        let dayEntry = DayEntry(date!, dayType: dayType)
//
//        return dayEntry
    

    var isSelected: Bool {
        guard self.date != nil else {
            return false
        }
        
        return Calendar.current.isDate(self.date!, inSameDayAs: self.selectedDate)
    }
    
    var circleColor: Color {
        
        guard self.date != nil else {
            return .clear
        }
        guard !isSelected else {
            return Color(UIColor.systemGray6)
        }
        
        
        switch self.type {
        case .noPeriod:
            return .clear
        case .none:
            return .clear
        case .startInterval:
            return ColorManager.highlightOrange
        case .inInterval, .endInterval:
            return .clear
        case .ovulation:
            return Color(UIColor.systemTeal).opacity(0.1)
            
        case .currentDay:
            return Color(UIColor.systemGray4)
        }
    }
    
    var textColor: Color {
        guard self.date != nil else {
            return .clear
        }
        
//        guard !isSelected else {
//            return .primary
//        }
        
        switch self.type {
        case .ovulation:
            return Color(UIColor.systemTeal)
        case .startInterval:
            return .white
        case .inInterval, .endInterval:
            return ColorManager.highlightOrange
        case .currentDay:
            return .primary
        
        default:
            return .primary
        }
    }
    
    var textFont: Font {
        guard self.date != nil else {
            return .body
        }
        
        switch self.type {
        case .ovulation:
            return Font.title3.weight(.semibold)
        case .currentDay:
            return Font.title3.weight(.bold)
        default:
            return Font.title3
        }
    }
    
    var dayNumber: Int {
        guard self.date != nil else {
            return 0
        }
        
        return Calendar.current.component(.day, from: self.date!)
    }
    
    var intervalBackground: RoundedCorners? {
        guard self.date != nil else {
            return nil
        }
        
        switch self.type {
        case .startInterval:
            return RoundedCorners(tl: 40, tr: 0, bl: 40, br: 0)
                
        case .endInterval:
            return RoundedCorners(tl: 0, tr: 40, bl: 0, br: 40)
                
        case .inInterval:
            return RoundedCorners(tl: 0, tr: 0, bl: 0, br: 0)
                
        default:
            return nil
        }
    }
    
    var intervalBackgroundPadding: EdgeInsets {
        guard self.date != nil else {
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
        
        switch self.type {
        case .startInterval:
            return EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
            
        case .endInterval:
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
            
        default:
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }

    
    
    var body: some View {
        
        guard self.date != nil else  {
            return AnyView(
                Circle().foregroundColor(circleColor)
                .frame(height: 40)
            )
        }
        return AnyView(
                Button(
                    action: {

                    
                        appStore.selectDate(self.date!)

                    },
                    label: {
                        ZStack {
                            
                            Circle().foregroundColor(circleColor)
                                .frame(height: 40)
                            
                            
                            if date != nil {
                                Text("\(dayNumber)")
                                    .foregroundColor(self.textColor)
                                    .font(textFont)
                            }
                        }
                    }
                ).background(
                    intervalBackground
                        .foregroundColor(ColorManager.backgroundOrange)
                        .padding(intervalBackgroundPadding)
                )
            )
        
    }
}

//struct CalenderDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalenderDayView()
//    }
//}
