
import SwiftUI

struct CountdownView: View {
    
    @EnvironmentObject var periodStore : PeriodStore
    
    
    
    var countdownText: String {
        if periodStore.daysTilPeriod < 1 {
            return "Your period ends in"
        } else {
            return "Your period starts in"
        }
    }
    
    var countdown: Int {
        if periodStore.daysTilPeriod < 1 {
            
            let today = Date().startOfDay()
            
            guard today != nil else {
                return 0
            }
            
            let currentPeriod = periodStore.getNextOrCurrentPeriodFromDate(
                today!)
            
            guard currentPeriod != nil else {
                return 0
            }
            
            return Calendar.current.dateComponents([.day], from: today!, to: currentPeriod!.endDate).day ?? 0
        } else {
            return periodStore.daysTilPeriod
        }
    }
    
    
    // MARK: - Body
    var body: some View {
        
        //Greeting
        Text("Hey, you 👋")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(width: 320, alignment: .topLeading)
            .padding(.top, 10)
        
        //Your period starts in ... days.
        HStack{
            
            Text(countdownText)
                .font(.body)
                .frame(alignment: .leading)
            
            ZStack{
                
                Circle()
                    .stroke(ColorManager.highlightOrange)
                    .frame(width: 52, height: 52)
                    .offset(y: -4.0)
                
                Circle()
                    .fill(ColorManager.backgroundOrange)
                    .frame(width: 46, height: 46)
                    .offset(y: -4.0)
                
                Text("\(countdown)").font(.system(.title, design: .rounded)).fontWeight(.bold)
                    .foregroundColor(ColorManager.highlightOrange)
                    .offset(y: -4.0)
            }
            
            Text("days.")
                .font(.body)
            
        }
    }
}

// MARK: - Preview
struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView()
    }
}
