//
//  CalenderDayView.swift
//  periodeux
//
//  Created by Gustav on 03.06.21.
//

import SwiftUI

struct CalenderDayView: View {
    
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
    let date: Date?
    
    var circleColor: Color {
        guard self.date != nil else {
            return Color.clear
        }
        
        switch self.dayType {
        case .noPeriod:
            return .clear
        case .ovulation:
            return Color(UIColor.systemTeal).opacity(0.1)
        default:
            return .red
        }
    }
    
    var dayNumber: Int? {
        guard self.date != nil else {
            return nil
        }
        
        return Calendar.current.component(.day, from: self.date!)
    }
    
    
    var body: some View {
        ZStack {
            if date != nil {
                Text("\(dayNumber!)")
            }
            
            Circle().foregroundColor(circleColor)
                .frame(height: 40)
        }
        
    }
}

//struct CalenderDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalenderDayView()
//    }
//}
