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
    
    let dayEntry: DayEntry?
    
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
        default:
            return .secondary
        }
    }
    
    var textFont: Font {
        guard self.dayEntry != nil else {
            return .body
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

    
    
    var body: some View {
        ZStack {
            intervalBackground
                .foregroundColor(ColorManager.backgroundOrange)
                .frame(height: 40)
            
            Circle().foregroundColor(circleColor)
                .frame(height: 40)
            

            if dayEntry != nil {
                Text("\(dayNumber)")
                    .foregroundColor(self.textColor)
            }
            
        }
        
    }
}

//struct CalenderDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalenderDayView()
//    }
//}