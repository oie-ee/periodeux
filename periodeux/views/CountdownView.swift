
import SwiftUI

struct CountdownView: View {
    
    @EnvironmentObject var appStore : AppStore
    
    
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
            
            Text("Your period starts in")
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
                
                Text("\(appStore.daysTilPeriod)")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
