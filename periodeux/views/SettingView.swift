

import SwiftUI


struct SettingView: View {
    
    @State var showComposeMessageView: Bool = false
    
    var body: some View {
        
      
            NavigationView {
                
             
                
                VStack (alignment: .leading){
                    
                    
                    List {
                        
                        NavigationLink(destination: PeriodDuration()) {
                            PeriodDuration()
                            
                        }
                        NavigationLink(destination: CycleDuration()) {
                            CycleDuration()
                        }
                        NavigationLink(destination: FirstPeriod()) {
                            FirstPeriod()
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
                
                .navigationTitle("Settings")
                
                
            }
       

        }
    }
    




struct PeriodDuration: View {

    var body: some View {
        HStack {
                VStack(alignment: .leading) {
                HStack {
                    Picker(selection: .constant(6), label: Text("Period duration")) /*@START_MENU_TOKEN@*/{
                                         Text("1 Day").tag(1)
                                         Text("2 Days").tag(2)
                                         Text("3 Days").tag(3)
                                         Text("4 Days").tag(4)
                                         Text("5 Days").tag(5)
                                         Text("6 Days").tag(6)
                                         Text("7 Days").tag(7)
                                         Text("8 Days").tag(8)
                                         Text("9 Days").tag(9)
                                         Text("10 Days").tag(10)
                                     }/*@END_MENU_TOKEN@*/
                
                }
            }
        }
    }
}

struct CycleDuration: View {

    var body: some View {
        HStack {
                VStack(alignment: .leading) {
                HStack {
                    Picker(selection: .constant(6), label: Text("Cycle duration")) /*@START_MENU_TOKEN@*/{
                                         Text("21 Days").tag(1)
                                         Text("22 Days").tag(2)
                                         Text("23 Days").tag(3)
                                         Text("24 Days").tag(4)
                                         Text("25 Days").tag(5)
                                         Text("26 Days").tag(6)
                                         Text("27 Days").tag(7)
                                         Text("28 Days").tag(8)
                                         Text("29 Days").tag(9)
                                         Text("30 Days").tag(10)
                                     }/*@END_MENU_TOKEN@*/
                
                }
            }
         
        }
    }
    }

struct FirstPeriod: View {

    var body: some View {
        
      Text("First day of last period")
            }
            }
        
    



// MARK: - Preview
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}



