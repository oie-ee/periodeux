

import SwiftUI

struct InfoInputView: View {
    @State var moods: [MoodModel] = dummyMoodData
    @State var symptoms: [SymptomModel] = dummySymptomData
    @State var bleedings: [BleedingModel] = dummyBleedingData
    @State var showingModalView = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            //Mood and Edit
            HStack(alignment: .bottom){
                
                Text("Mood")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView()
                }
                
                Spacer()
                
            }.frame(width: 325)
            
            //MoodModel
            HStack {
                ForEach(moods){
                    mood in
                    MoodRowView(mood: mood)
                }
            }
            
            Spacer()
                .frame(height: 15)
            
            //Symptoms and Edit
            
            HStack(alignment: .bottom){
                
                Text("Symptom")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView()
                }
                
                Spacer()
                
            }.frame(width: 325)
            
            //SymptomsIcons
            
            HStack {
                ForEach(symptoms){
                    symptom in
                    SymptomRowView(symptom: symptom)
                }
            }
            
            Spacer()
                .frame(height: 15)
            
            //Bleeding and Edit
            HStack(alignment: .bottom){
                
                Text("Bleeding")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView()
                }
                
                Spacer()
                
            }.frame(width: 325)
            
            //BleedingIcons
            HStack {
                ForEach(bleedings){
                    bleeding in
                    BleedingRowView(bleeding: bleeding)
                }
            }
        }
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


//MARK –  BleedingModel
struct BleedingModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension BleedingModel {
    
    static var bleeding1 = BleedingModel(name: "No Bleeding", imageIcon: "app.fill")
    static var bleeding2 = BleedingModel(name: "Strong", imageIcon: "app.fill")
}

let dummyBleedingData = [BleedingModel.bleeding1]

struct InfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        InfoInputView()
    }
}
