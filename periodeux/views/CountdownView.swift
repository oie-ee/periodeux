
import SwiftUI

struct CountdownView: View {
    
    @State  var daysTilPeriod: Int = 15
    
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
                    .frame(width: 58, height: 58)
                    .offset( y: -6.0)
                
                Circle()
                    .fill(ColorManager.backgroundOrange)
                    .frame(width: 50, height: 50)
                    .offset( y: -6.0)
                
                Text("\(daysTilPeriod)")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(ColorManager.highlightOrange)
                    .offset( y: -6.0)
            }
            
            Text("days.")
                .font(.body)
            
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView()
    }
}
