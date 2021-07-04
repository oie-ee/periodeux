//
//  CalenderDayView.swift
//  periodeux
//
//  Created by Gustav on 03.06.21.
//

import SwiftUI


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
