

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
                    }.padding(.bottom, 30)
                    
                   Text("This is how you are most likely to feel, \nin the days leading up to your period:")
                    .font(Font.body.weight(.regular))
                    .padding(.bottom, 15)
                    
                    HStack{
                        LargeMoodCellView(mood: MoodModel.mood5)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        LargeMoodCellView(mood: MoodModel.mood7)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        LargeMoodCellView(mood: MoodModel.mood11)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        LargeMoodCellView(mood: MoodModel.mood1)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }.padding(.bottom, 30)
                    
                    Text("These are your most freuently reported symptoms:")
                     .font(Font.body.weight(.regular))
                     .padding(.bottom, 15)
                     
                     HStack{
                         LargeSymptomCellView(symptom: SymptomModel.symptom4)
                             .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                         LargeSymptomCellView(symptom: SymptomModel.symptom3)
                             .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                         LargeSymptomCellView(symptom: SymptomModel.symptom7)
                             .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                         LargeSymptomCellView(symptom: SymptomModel.symptom1)
                             .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
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



