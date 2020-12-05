
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
                    
                }
                
            }
            .navigationTitle("Hey, you \u{1f44b}")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
