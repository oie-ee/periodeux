
import SwiftUI

struct WeekDays: View {
    let firstWeekDay = Calendar.current.firstWeekday
    let weekdays = Calendar.current.shortWeekdaySymbols
    
    var weekdayRange: ArraySlice<String> {
        print(firstWeekDay)
        
        guard firstWeekDay > 1 else {
            return weekdays[0...weekdays.count - 1]
        }
        return weekdays[(firstWeekDay - 1)...(weekdays.count - 1)] + weekdays[0...(firstWeekDay - 2)]
        
    }
    
    var body: some View {
        
        HStack{
            ForEach(weekdayRange, id: \.self) { weekdays in
                
                Spacer()
                
                Text("\(weekdays)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                   // .frame(width: 36)
                
                Spacer()
            }
        }.padding([.leading, .trailing], 8)
    }
}
