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
    static func generateDateFromComponents(day: Int, month: Int, year: Int, hour: Int) -> Date? {
        
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        components.hour = hour
        
        return Calendar.current.date(from: components)
    }
    
    // strips away time component
    static func generateDayDateFromDate(_ date: Date) -> Date {
        return Calendar.current.date(bySettingHour: 2, minute: 0, second: 0, of: date) ?? date
    }
    
}


struct CalenderDayView: View {
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var currentReport: ReportDB = ReportDB()
    
    var dayEntry: DayEntry?
    
    var date: Date? {
        return self.dayEntry?.date
    }
    
    var isSelected: Bool {
        return self.date == appStore.selectedDate
    }
    
    var circleColor: Color {
        
        guard self.dayEntry != nil else {
            return .clear
        }
        guard !isSelected else {
            return Color(UIColor.systemGray6)
        }
        
        
        switch self.dayEntry!.dayType {
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
        default:
            return .red
        }
    }
    
    var textColor: Color {
        guard self.dayEntry != nil else {
            return .clear
        }
        
//        guard !isSelected else {
//            return .primary
//        }
        
        switch self.dayEntry!.dayType {
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
        guard self.dayEntry != nil else {
            return .body
        }
        
        switch self.dayEntry!.dayType {
        case .ovulation:
            return Font.title3.weight(.semibold)
        case .currentDay:
            return Font.title3.weight(.bold)
        default:
            return Font.title3
        }
    }
    
    var dayNumber: Int {
        guard self.dayEntry != nil else {
            return 0
        }
        
        return Calendar.current.component(.day, from: self.dayEntry!.date)
    }
    
    var intervalBackground: RoundedCorners? {
        guard self.dayEntry != nil else {
            return nil
        }
        
        switch self.dayEntry!.dayType {
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
        guard self.dayEntry != nil else {
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
        
        switch self.dayEntry!.dayType {
        case .startInterval:
            return EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
            
        case .endInterval:
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
            
        default:
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }

    
    
    var body: some View {
        
        guard dayEntry != nil else  {
            return AnyView(
                Circle().foregroundColor(circleColor)
                .frame(height: 40)
            )
        }
        return AnyView(
                Button(
                    action: {
                    
                        appStore.selectDate(self.date!)
                        
                        let reportID = reportStore.getExistingReportID(date: appStore.selectedDate)
                                                       if(reportID != 0) {
                                                           let report = reportStore.findByID(id: reportID)
                                                           appStore.currentReport = report!
                                                       }
                    
                    },
                    label: {
                        ZStack {
                            
                            Circle().foregroundColor(circleColor)
                                .frame(height: 40)
                            
                            
                            if dayEntry != nil {
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
