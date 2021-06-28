
import SwiftUI

struct ColorManager {
    static let highlightOrange = Color("highlightOrange")
    static let backgroundOrange = Color("backgroundOrange")
    static let lightestElement = Color("lightestElement")
    static let customTeal = Color("customTeal")
    static let addEditCellBackgound = Color("addEditCellBackground")
}

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            
            // Mark: – First Tab
            NavigationView {
                
                    ScrollView {
                        
                        LazyVStack(alignment: .leading, spacing: 20) {
                            // Your period starts in ... stack
                            CountdownView()
                                .offset(x: 30)
                            
                            //Rectangle and content
                            HStack{
                                
                                Spacer()
                                
                                RectangleWrapperView()
                                
                                Spacer()
                                
                            }
                        }.offset(y: 30)
                        
                    }.navigationBarTitle("Overview", displayMode: .inline)
                   // .navigationBarTitleDisplayMode(.inline)
                     //.navigationBarHidden(true)
            }.tabItem {
                Image(systemName: "calendar")
                Text("Overview")
            }
            
            // MARK: – Second Tab
            InsightsView()
                
                .tabItem {
                    Label("Insights", systemImage: "rectangle.and.text.magnifyingglass")
                }
            
            // MARK: – Third Tab
                
            SettingView()
               
                
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
        }
        .accentColor(ColorManager.highlightOrange)
    }
    
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

