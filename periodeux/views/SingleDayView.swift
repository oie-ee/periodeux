
import SwiftUI

struct SingleDayView: View {
    
    @EnvironmentObject var appStore : AppStore
    
    @Binding var selectedDayArray : [Bool]
    @State var dayOfMonth : Int
    @State var numberOfDays : Range<Int>
    
    @State var isReallySelected : Bool = false
    
    @State var selectedMonth : Int
    @State var selectedYear : Int
    
    var body: some View {
        Button(action: {
            print("\(dayOfMonth) was selected")
                                            
            appStore.selectedDate = generateDateFromSelectedDay(day: dayOfMonth, month: self.selectedMonth, year: self.selectedYear) ?? Date()
            
            selectedDayArray =  [Bool](repeating: false, count: 32)
            
            selectedDayArray[dayOfMonth] = true
        }, label: {
            
            ZStack {
                
                let arrayRange = 0...31
                
                if(arrayRange.contains(dayOfMonth)) {
                    Circle().foregroundColor(selectedDayArray[dayOfMonth] ? .gray : .white)
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
    
    func generateDateFromSelectedDay(day: Int, month: Int, year: Int) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let convertedDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 01:00")
        
        return convertedDate
    }
}

//struct SingleDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleDayView()
//    }
//}
