
import SwiftUI

struct ColorManager {
    static let highlightOrange = Color("highlightOrange")
    static let backgroundOrange = Color("backgroundOrange")
}

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            
            // Mark: – First Tab
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
                    
                } .navigationTitle("PeriodABC")
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            // MARK: – Second Tab
            Text("Insights")
                .tabItem {
                    Label("Insights", systemImage: "rectangle.and.text.magnifyingglass")
                }
            
            // MARK: – Third Tab
            Text("Setting")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
        }.accentColor(ColorManager.highlightOrange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
