
import SwiftUI

struct ColorManager {
    static let highlightOrange = Color("highlightOrange")
    static let backgroundOrange = Color("backgroundOrange")
}

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            
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
                }
              
            }
            .navigationTitle("Hey, you \u{1f44b}")
            
            List {
            NavigationLink(destination: Text("Insights")){
                Text("Insights")
            }
            
            NavigationLink(destination: Text("Settings")){
                Text("Settings")
            }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
