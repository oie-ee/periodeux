
import SwiftUI

struct ColorManager {
    static let highlightOrange = Color("highlightOrange")
    static let backgroundOrange = Color("backgroundOrange")
}

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            
            List {
                ScrollView {
                    
                    LazyVStack(alignment: .leading, spacing: 20) {
                        // Your period starts in ... stack
                        CountdownView()
                        
                        //Rectangle and content
                        HStack{
                            Spacer()
                            RectangleWrapperView()
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 20)
                    }
                }
                
                NavigationLink(destination: Text("Insights")){
                    Text("Insights")
                }
                
                NavigationLink(destination: Text("Settings")){
                    Text("Settings")
                }
            } .navigationTitle("PeriodABC")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
