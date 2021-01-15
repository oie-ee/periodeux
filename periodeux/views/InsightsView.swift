

import SwiftUI


struct InsightsView: View {
    
    @State var showComposeMessageView: Bool = false
    
    var body: some View {
      
            NavigationView {
                
                VStack (alignment: .leading){
                    
                    HStack(alignment: .top){
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(ColorManager.backgroundOrange)
                                .frame(height: 160)
                            
                            VStack{
                                
                                Text("27")
                                    .font(.largeTitle)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(ColorManager.highlightOrange)
                                    .frame(height: 120)
                                
                                Text("Average Cycle Length")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorManager.highlightOrange)
                            }
                        }
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(ColorManager.highlightOrange.opacity(0.9))
                                .frame(height: 160)
                            
                            VStack{
                                Text("6")
                                    .font(.largeTitle)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(ColorManager.backgroundOrange)
                                    .frame(height: 120)
                                
                                Text("Average Period Length")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorManager.backgroundOrange)
                                
                            }
                        }
                    }
                   
                    Spacer()
                    
                }.navigationTitle("Insights")
                .padding([.top, .leading, .trailing])
                
                
            }
       

        }
    }
    







// MARK: - Preview
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}



