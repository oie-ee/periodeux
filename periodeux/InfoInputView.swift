

import SwiftUI

struct InfoInputView: View {
    @State var moods: [MoodModel] = dummyMoodData
    
    var body: some View {
        
        //Mood and Edit
        VStack(alignment: .leading){
            
            HStack(alignment: .bottom){
                
                Text("Mood")
                    .font(.headline)
                    .padding(.top, 12)
                
                Text("Edit")
                    .font(.caption2)
                    .foregroundColor(ColorManager.highlightOrange)
                    .offset(y: -0.5)
                
                Spacer()
                
            }.frame(width: 325)
            
            //MoodModel
            HStack {
                ForEach(moods){
                    mood in
                    MoodRowView(mood: mood)
                }
            }
            
            //Symptoms and Edit
            
        }
        
        
        //SymptomsIcons
        
        //Bleeding and Edit
        
        //BleedingIcons
    }
}


//MARK –  MoodModel
struct MoodModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
    
}

extension MoodModel {
    
    static var mood1 = MoodModel(name: "Happy", imageIcon: "app.fill")
    static var mood2 = MoodModel(name: "Sad", imageIcon: "app.fill")
    static var mood3 = MoodModel(name: "Hungry", imageIcon: "app.fill")
    static var mood4 = MoodModel(name: "Grumpy", imageIcon: "app.fill")
    
}

let dummyMoodData = [MoodModel.mood1, MoodModel.mood2, MoodModel.mood3, MoodModel.mood4]


//MARK –  SymptomModel
struct SymptomModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension SymptomModel {

    static var symptom1 = SymptomModel(name: "Pain", imageIcon: "app.fill")
    static var symptom2 = SymptomModel(name: "Bloating", imageIcon: "app.fill")
    static var symptom3 = SymptomModel(name: "Fatigue", imageIcon: "app.fill")
}

let dummySymptomData = [SymptomModel.symptom1, SymptomModel.symptom2, SymptomModel.symptom3]


struct InfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        InfoInputView()
    }
}
