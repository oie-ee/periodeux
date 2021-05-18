
// MARK: - Insights

import SwiftUI

struct InsightsView: View {
    
    @State var showComposeMessageView: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack (alignment: .leading){
                    
                    // MARK: - First Section
                    Text("Your Average Period")
                        .font(Font.title3.weight(.semibold))
                        .padding(.bottom, 8)
                    
                    HStack(alignment: .top){
                        
                        VStack {
                            
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.backgroundOrange)
                                    .frame(height: 120)
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color.white, lineWidth: 12)
                                    .frame(height: 120)
                                
                                RoundedRectangle(cornerRadius: 11, style: .continuous)
                                    .stroke(ColorManager.highlightOrange, lineWidth: 2)
                                    .frame(height: 120)
                                
                                VStack{
                                    
                                    HStack{
                                        Text("29")
                                            .font(.largeTitle)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(ColorManager.highlightOrange)
                                            .frame(height: 120)
                                        
                                        Text("days")
                                            .font(.subheadline)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(ColorManager.highlightOrange)
                                            .offset(x: -6, y: 6.5)
                                    }
                                }
                            }
                            
                            Text("Cycle Length")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                        
                        VStack {
                            
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.highlightOrange.opacity(0.9))
                                    .frame(height: 120)
                                
                                
                                VStack{
                                    HStack{
                                        Text("6")
                                            .font(.largeTitle)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(ColorManager.backgroundOrange)
                                            .frame(height: 120)
                                        
                                        Text("days")
                                            .font(.subheadline)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(ColorManager.backgroundOrange)
                                            .offset(x: -4, y: 6.5)
                                    }
                                }
                            }
                            
                            
                            Text("Period Length")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                        
                    }.padding(.bottom, 40)
                    
                    // MARK: - Second Section
                    Group{
                        Text("Mood Prognosis")
                            .font(Font.title3.weight(.semibold))
                            .padding(.bottom, 2)
                        
                        Text("This is how you are most likely going to feel in the days leading up to your period:")
                            .font(Font.body.weight(.regular))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 15)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 5){
                                LargeMoodCellView(mood: MoodModel.mood5, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood7, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood1, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood2, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood11, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood8, isSelected: false)
                                    .disabled(true)
                            }.padding(.bottom, 32)
                            
                        }
                    }
                    
                    // MARK: - Third Section
                    Group{
                        Text("Frequent Symptoms")
                            .font(Font.title3.weight(.semibold))
                            .padding(.bottom, 2)
                        
                        Text("These are your most frequently reported symptoms:")
                            .font(Font.body.weight(.regular))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 15)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 5){
                                LargeSymptomCellView(symptom: SymptomModel.symptom4, isSelected: false)
                                    .disabled(true)
                                LargeSymptomCellView(symptom: SymptomModel.symptom3, isSelected: false)
                                    .disabled(true)
                                LargeSymptomCellView(symptom: SymptomModel.symptom5, isSelected: false)
                                    .disabled(true)
                                LargeSymptomCellView(symptom: SymptomModel.symptom10, isSelected: false)
                                    .disabled(true)
                                LargeSymptomCellView(symptom: SymptomModel.symptom1, isSelected: false)
                                    .disabled(true)
                            }.padding(.bottom, 32)
                        }
                    }
                    
                    // MARK: - Fourth Section
                    Group{
                        Text("Frequent Moods")
                            .font(Font.title3.weight(.semibold))
                            .padding(.bottom, 2)
                        
                        Text("These are your most frequently reported moods:")
                            .font(Font.body.weight(.regular))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 15)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 5){
                                LargeMoodCellView(mood: MoodModel.mood1, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood13, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood6, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood4, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood10, isSelected: false)
                                    .disabled(true)
                            }
                        }
                    }
                    
                    Spacer()
                    
                }.navigationTitle("Insights")
                .padding([.top, .leading, .trailing])
                
            }
        }
    }
}


// MARK: - Preview
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}



