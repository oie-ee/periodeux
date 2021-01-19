
import SwiftUI

struct SingleDayView: View {
    
    @EnvironmentObject var appStore : AppStore
    
    @Binding var selectedDayArray : [Bool]
    @State var dayOfMonth : Int
    @State var numberOfDays : Range<Int>
    
    @State var selectedMonth : Int
    @State var selectedYear : Int
    
    var body: some View {
        Button(action: {
            
            appStore.selectedDate = generateDateFromSelectedDay(day: dayOfMonth, month: self.selectedMonth, year: self.selectedYear) ?? Date()
            
            selectedDayArray =  [Bool](repeating: false, count: 32)
            
            selectedDayArray[dayOfMonth] = true
        }, label: {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 0, style: .continuous).foregroundColor(.white)
                
                let arrayRange = 0...31
                
                if(arrayRange.contains(dayOfMonth)) {
                    Circle().foregroundColor(selectedDayArray[dayOfMonth] ? Color(UIColor.systemGray6) : .white)
                } else {
                    Circle().foregroundColor(.white)
                }
                
                
                if numberOfDays.contains(dayOfMonth) {
                    Text("\(dayOfMonth)")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
        })
    }
    
    //Generate Date From DAy/Month/Year Ints
    func generateDateFromSelectedDay(day: Int, month: Int, year: Int) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let convertedDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 01:00")
        
        return convertedDate
    }
}

