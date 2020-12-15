
import SwiftUI

struct CalendarView: View {
    var body: some View {
        HStack{
            
            Text("November 2020")
                .font(.system(size: 24.0))
                .fontWeight(.semibold)
                .padding(.top, 17)
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .resizable()
                .font(Font.title.weight(.semibold))
                .frame(width: 10.0, height: 17.0)
                .padding(.trailing, 13)
                .padding(.top, 17)
            
            Image(systemName: "chevron.right")
                .resizable()
                .font(Font.title.weight(.semibold))
                .frame(width: 10.0, height: 17.0)
                .padding(.top, 17)
        }.frame(width: 325)
        
        //Weekdays in calendar
        WeekDays()
    }
}

struct WeekDays: View {
    
    let weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
    var body: some View {
        
        HStack(spacing: 22){
            
            ForEach(weekdays, id: \.self) { weekdays in
                Text("\(weekdays)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            
        }.frame(width: 325)
        
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
            CalendarView()
    }
}
