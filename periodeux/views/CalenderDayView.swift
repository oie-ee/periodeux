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
        case selectedDay
    }
    
    let dayType: DayType
    
    init(_ date: Date, dayType: DayType) {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        
        self.id = day + month + year
            
        self.date = Self.generateDateFromComponents(day: day, month: month, year: year)!
        
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
    
}


struct CalenderDayView: View {
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    let dayEntry: DayEntry?
    
    var date: Date? {
        return self.dayEntry?.date
    }
    
    var circleColor: Color {
        
        guard self.dayEntry != nil else {
            return .clear
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
        case .selectedDay:
            return Color(UIColor.systemGray6)
        default:
            return .red
        }
    }
    
    var textColor: Color {
        guard self.dayEntry != nil else {
            return .clear
        }
        
        switch self.dayEntry!.dayType {
        case .ovulation:
            return Color(UIColor.systemTeal)
        case .startInterval:
            return .white
        case .inInterval, .endInterval:
            return ColorManager.highlightOrange
        case .selectedDay:
            return .primary
        
        default:
            return .secondary
        }
    }
    
    var textFont: Font {
        guard self.dayEntry != nil else {
            return .body
        }
        
        guard appStore.selectedDate != self.date else {
            return Font.title3.weight(.bold)
        }
        
        switch self.dayEntry!.dayType {
        case .ovulation:
            return Font.title3.weight(.semibold)
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
                    
                        appStore.selectedDate = self.date!
                    
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
